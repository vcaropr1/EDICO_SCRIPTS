#! /bin/bash

BAM_DIR=$1
OUT_DIR=$2
# JOINT_CALL_PREFIX=$3

SCRIPT_DIR='/isilon/sequencing/VITO/DRAGEN_TEST/SCRIPTS'
REF_HASH_DIR='/staging/human/reference/GRC37/human_g1k_v37_decoy_hash_table'
REF_GENOME='/staging/human/reference/GRC37/human_g1k_v37_decoy.fasta'
HAPMAP='/isilon/sequencing/GATK_resource_bundle/2.5/b37/hapmap_3.3.b37.vcf'
OMNI_VCF='/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_omni2.5.b37.vcf'
ONEKG_HIGH_CONF='/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_phase1.snps.high_confidence.b37.vcf'
DBSNP_129='/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf'
ONEKG_GOLD_STD='/isilon/sequencing/GATK_resource_bundle/2.2/b37/Mills_and_1000G_gold_standard.indels.b37.vcf'

# echo STEP,START,END >| $OUT_DIR/run_times.csv

for BAM in $(ls $BAM_DIR/*.bam)
do
SM_TAG=$(basename $BAM .bam)

JOB_ID=$(sbatch -o $OUT_DIR/LOGS/$SM_TAG'_FROM_BAM.log' $SCRIPT_DIR/from_bam.sh $BAM $SM_TAG $OUT_DIR $REF_HASH_DIR $REF_GENOME | awk '{print $4}')

COMBINE_DEPENDENCY_LIST=$JOB_ID','
# GVCF_LIST=$GVCF_LIST''$OUT_DIR'/'$SM_TAG'.gvcf '
done

# COMBINE_DEPENDENCY_LIST=$(echo $COMBINE_DEPENDENCY_LIST | sed 's/,$//')

# COMBINE_JOBID=$(sbatch --gres=dragen_board:1 $COMBINE_DEPENDENCY_LIST -o $OUT_DIR/LOGS/'COMBINE_GVCFS.log' $SCRIPT_DIR/combinegvcfs.sh $JOINT_CALL_PREFIX $OUT_DIR $REF_HASH_DIR $REF_GENOME $GVCF_LIST | awk '{print $4}')

# JOINT_CALLID=$(sbatch --gres=dragen_board:1 --dependency=$COMBINE_JOBID -o $OUT_DIR/LOGS/'JOINT_CALLING.log' $SCRIPT_DIR/joint_calling.sh $JOINT_CALL_PREFIX $OUT_DIR $REF_HASH_DIR $REF_GENOME $HAPMAP $OMNI_VCF $ONEKG_HIGH_CONF $DBSNP_129 $ONEKG_GOLD_STD | awk '{print $4}')

# JOINT_CALLID=$(sbatch --gres=dragen_board:1 --dependency=$COMBINE_DEPENDENCY_LIST -o $OUT_DIR/LOGS/'JOINT_CALLING.log' $SCRIPT_DIR/joint_calling.sh $JOINT_CALL_PREFIX $OUT_DIR $REF_HASH_DIR $REF_GENOME $HAPMAP $OMNI_VCF $ONEKG_HIGH_CONF $DBSNP_129 $ONEKG_GOLD_STD | awk '{print $4}')

# #PER SAMPLE
# dragen -f -r /staging/human/reference/GRC37/human_g1k_v37_decoy_hash_table -b /isilon/sequencing/Seq_Proj/Macrogen_Data/BAM/$SAMPLE'.bam' --enable-duplicate-marking true --enable-variant-caller true --vc-reference /staging/human/reference/GRC37/human_g1k_v37_decoy.fasta --vc-sample-name $SAMPLE --vc-emit-ref-confidence GVCF --output-directory /isilon/sequencing/VITO/DRAGEN_TEST/MACROGEN_DATA/ --intermediate-results-dir /staging/tmp --output-file-prefix $SAMPLE
# 
# #PER PROJECT
# 
# 	#HOLD ON ALL PER SAMPLE
# 	dragen -f -r /staging/human/reference/GRC37/human_g1k_v37_decoy_hash_table --enable-combinegvcfs true --vc-reference /staging/human/reference/GRC37/human_g1k_v37_decoy.fasta --output-directory /isilon/sequencing/VITO/DRAGEN_TEST/MACROGEN_DATA/ --intermediate-results-dir /staging/tmp --output-file-prefix MACROGEN_COMBINED_GVCFS --variant /isilon/sequencing/VITO/DRAGEN_TEST/MACROGEN_DATA/NA12878.gvcf --variant /isilon/sequencing/VITO/DRAGEN_TEST/MACROGEN_DATA/NA12891.gvcf --variant /isilon/sequencing/VITO/DRAGEN_TEST/MACROGEN_DATA/NA12892.gvcf
# 	
# 	#HOLD ON COMBINE STEP ABOVE
	