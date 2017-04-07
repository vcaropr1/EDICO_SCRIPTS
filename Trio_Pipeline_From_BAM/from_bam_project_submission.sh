#! /bin/bash

SAMPLE_SHEET=$1 # REGULAR SAMPLESHEET WITH FIELD 8 BEING SM_TAG
BAM_DIR=$2 # WHERE THE BAM FILES ARE LOCATED.  ALL FILES MUST BE IN ONE DIRECTORY AND CONTAIN THE RGPU_1/2 IN THE NAMES
OUT_DIR=$3 # PROJECT MAIN DIRECTORY

SCRIPT_DIR='/isilon/sequencing/VITO/NEW_GIT_REPO/EDICO_SCRIPTS/Trio_Pipeline_From_BAM'
REF_HASH_DIR='/staging/human/reference/GRC37/human_g1k_v37_decoy_hash_table'
REF_GENOME='/staging/human/reference/GRC37/human_g1k_v37_decoy.fasta'
HAPMAP='/isilon/sequencing/GATK_resource_bundle/2.5/b37/hapmap_3.3.b37.vcf'
OMNI_VCF='/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_omni2.5.b37.vcf'
ONEKG_HIGH_CONF='/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_phase1.snps.high_confidence.b37.vcf'
DBSNP_129='/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf'
DBSNP_138='/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.vcf'
ONEKG_GOLD_STD='/isilon/sequencing/GATK_resource_bundle/2.2/b37/Mills_and_1000G_gold_standard.indels.b37.vcf'

mkdir -p $OUT_DIR'/LOGS'
mkdir -p $OUT_DIR'/BAM'
mkdir -p $OUT_DIR'/REPORTS'
mkdir -p $OUT_DIR'/DRAGEN_OUTPUT'
mkdir -p $OUT_DIR'/GVCF'
mkdir -p $OUT_DIR'/TEMP'

echo PROCESS,STEP,START,END >| $OUT_DIR/REPORTS/run_times.csv

PROJECT=$(awk 'BEGIN{FS=","} NR>1 {print $1}' $SAMPLE_SHEET | sort | uniq)
JOINT_CALL_HOLD_ID=''

for SAMPLE in $( awk 'BEGIN{FS=","} NR>1 {print $8}' $SAMPLE_SHEET | sort | uniq)
do
VCF_JOB_ID=$(sbatch --gres=dragen_board:1 -o $OUT_DIR/LOGS/$SAMPLE'_FROM_BAM_VCF.log' $SCRIPT_DIR/from_bam_vcf.sh $SAMPLE $BAM_DIR $OUT_DIR $REF_HASH_DIR $REF_GENOME $DBSNP_138 $HAPMAP $OMNI_VCF $ONEKG_HIGH_CONF $ONEKG_GOLD_STD | awk '{print $4}')

GVCF_JOB_ID=$(sbatch --gres=dragen_board:1 -o $OUT_DIR/LOGS/$SAMPLE'_FROM_BAM_GVCF.log' $SCRIPT_DIR/from_bam_gvcf.sh $SAMPLE $BAM_DIR $OUT_DIR $REF_HASH_DIR $REF_GENOME $DBSNP_138 $HAPMAP $OMNI_VCF $ONEKG_HIGH_CONF $ONEKG_GOLD_STD | awk '{print $4}')
JOINT_CALL_HOLD_ID=$JOINT_CALL_HOLD_ID'afterok:'$GVCF_JOB_ID','
done

JOINT_CALL_HOLD_ID_REFORM=$(echo $JOINT_CALL_HOLD_ID | sed 's/,*$//g')

JOINT_JOB_ID=$(sbatch --gres=dragen_board:1 --dependency=$JOINT_CALL_HOLD_ID_REFORM -o $OUT_DIR/LOGS/$PROJECT'_JOINT_CALLING.log' $SCRIPT_DIR/joint_calling.sh $PROJECT $REF_HASH_DIR $REF_GENOME $HAPMAP $OMNI_VCF $ONEKG_HIGH_CONF $DBSNP_138 $ONEKG_GOLD_STD | awk '{print $4}')
