#! /bin/bash

BAM=$1
SM_TAG=$2
OUT_DIR=$3
REF_HASH_DIR=$4
REF_GENOME=$5
DBSNP_138='/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.vcf'

START_FROM_BAM=`date '+%s'`

dragen -f -r $REF_HASH_DIR -b $BAM --enable-duplicate-marking false --enable-variant-caller true --vc-reference $REF_GENOME --vc-sample-name $SM_TAG --output-directory $OUT_DIR --intermediate-results-dir /staging/tmp --output-file-prefix $SM_TAG --dbsnp $DBSNP_138 --enable-map-align-output true --enable-bam-indexing true --enable-vqsr true --vqsr-config-file /opt/edico/config/dragen-VQSR.cfg --vqsr-filter-level SNP,99.9 --vqsr-filter-level INDEL,99.9 --vqsr-resource "SNP,15.0,/isilon/sequencing/GATK_resource_bundle/2.5/b37/hapmap_3.3.b37.vcf" --vqsr-resource "SNP,12.0,/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_omni2.5.b37.vcf" --vqsr-resource "SNP,10.0,/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_phase1.snps.high_confidence.b37.vcf" --vqsr-resource "INDEL,12.0,/isilon/sequencing/GATK_resource_bundle/2.2/b37/Mills_and_1000G_gold_standard.indels.b37.vcf" --vc-hard-filter "DRAGENHardSNP_QD:snp: QD < 2.0;DRAGENHardSNP_MQ:snp: MQ < 40.0;DRAGENHardSNP_FS:snp: FS > 60.0;DRAGENHardSNP_MQRankSum:snp: MQRankSum < -12.5;DRAGENHardSNP_ReadPosRankSum:snp: ReadPosRankSum < -8.0;DRAGENHardINDEL_QD:indel: QD < 2.0;DRAGENHardINDEL_ReadPosRankSum:indel: ReadPosRankSum < -20.0;DRAGENHardINDEL_FS:indel: FS > 200.0"
# --vqsr-annotation SNP,SOR,QD,FS,ReadPosRankSum,MQRankSum,MQ --vqsr-annotation INDEL,SOR,QD,FS,ReadPosRankSum,MQRankSum
# --vc-target-bed "/isilon/sequencing/VITO/DRAGEN_TEST/human_g1k_v37_decoy_primary_assembly_zero_based.bed"

END_FROM_BAM=`date '+%s'`



echo 'FROM_BAM_VQSR_VCF,'$START_FROM_BAM','$END_FROM_BAM >> $OUT_DIR/run_times.csv

START_FROM_BAM_GVCF=`date '+%s'`

dragen -f -r $REF_HASH_DIR -b $BAM --enable-variant-caller true --vc-sample-name $SM_TAG  --vc-reference $REF_GENOME --output-directory $OUT_DIR --intermediate-results-dir /staging/tmp --generate-md-tags true --enable-duplicate-marking false --vc-max-alternate-alleles 3 --combine-samples-by-name=true --output-file-prefix $SM_TAG --vc-emit-ref-confidence GVCF --dbsnp $DBSNP_138

END_FROM_BAM_GVCF=`date '+%s'`



echo 'FROM_BAM_GVCF,'$START_FROM_BAM_GVCF','$END_FROM_BAM_GVCF >> $OUT_DIR/run_times.csv