#! /bin/bash

set

# THIS SCRIPT RUNS DRAGEN TO CREATE A GVCF OUTPUT TO BE USED IN JOINT CALLING
# THE GVCF WILL BE MOVED TO THE PROJECTS GVCF FOLDER

SM_TAG=$1
FASTQ_LIST=$2
OUT_DIR=$3
REF_HASH_DIR=$4
REF_GENOME=$5
DBSNP_138=$6
HAPMAP=$7
OMNI_VCF=$8
ONEKG_HIGH_CONF=$9
ONEKG_GOLD_STD=${10}

START_FROM_FASTQ=`date '+%s'`

/opt/edico/bin/dragen -f -r $REF_HASH_DIR --fastq-list $FASTQ_LIST --vc-sample-name $SM_TAG --enable-variant-caller true --vc-reference $REF_GENOME --output-directory $OUT_DIR'/DRAGEN_OUTPUT/' --intermediate-results-dir /staging/tmp --generate-md-tags true --preserve-bqsr-tags true --enable-duplicate-marking false --vc-max-alternate-alleles 3 --vc-emit-ref-confidence GVCF --output-file-prefix $SM_TAG --enable-vqsr true --vqsr-config-file /opt/edico/config/dragen-VQSR.cfg --vqsr-annotation INDEL,DP,QD,FS,MQRankSum,ReadPosRankSum --vqsr-annotation SNP,QD,ReadPosRankSum,FS,DP  --vqsr-resource SNP,15.0,$HAPMAP --vqsr-resource SNP,12.0,$OMNI_VCF --vqsr-resource SNP,10.0,$ONEKG_HIGH_CONF --vqsr-resource SNP,2.0,$DBSNP_138 --vqsr-resource INDEL,12.0,$ONEKG_GOLD_STD --vqsr-resource INDEL,2.0,$DBSNP_138 --vqsr-tranche 100.0 --vqsr-tranche 99.9 --vqsr-tranche 99.8 --vqsr-tranche 99.7 --vqsr-tranche 99.6 --vqsr-tranche 99.5 --vqsr-tranche 99.4 --vqsr-tranche 99.3 --vqsr-tranche 99.2 --vqsr-tranche 99.1 --vqsr-tranche 99.0 --vqsr-tranche 98.0 --vqsr-tranche 97.0 --vqsr-tranche 96.0 --vqsr-tranche 95.0 --vqsr-tranche 90.0 --vqsr-filter-level SNP,99.5 --vqsr-filter-level INDEL,99.0 --dbsnp $DBSNP_138

END_FROM_FASTQ=`date '+%s'`

mv $OUT_DIR'/DRAGEN_OUTPUT/'$SM_TAG'.gvcf' $OUT_DIR'/GVCF/'$SM_TAG'.gvcf'

echo 'FROM_FASTQ_GVCF,A.00,'$START_FROM_FASTQ','$END_FROM_FASTQ >> $OUT_DIR/REPORTS/run_times.csv

# dragen -f -r /staging/human/reference/GRC37/human_g1k_v37_decoy_hash_table -1 /isilon/sequencing/VITO/DRAGEN_TEST/FASTQ_RENAME_TEST/NA128911125002077_CGATGT_L001_R1_001.fastq.gz -2 /isilon/sequencing/VITO/DRAGEN_TEST/FASTQ_RENAME_TEST/NA128911125002077_CGATGT_L001_R2_001.fastq.gz --enable-variant-caller true --vc-reference /staging/human/reference/GRC37/human_g1k_v37_decoy.fasta --vc-sample-name NA128911125002077 --output-directory /isilon/sequencing/VITO/DRAGEN_TEST/DRAGEN1/FASTQ_ISILON/ --intermediate-results-dir /staging/tmp --RGID RGID --RGSM NA12891-1125002077 --generate-md-tags true --preserve-bqsr-tags true --enable-map-align-output true --enable-bam-indexing true --combine-samples-by-name=true --output-file-prefix NA12891-1125002077_isilon_fastq2