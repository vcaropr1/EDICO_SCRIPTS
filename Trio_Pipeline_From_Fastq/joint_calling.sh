#! /bin/bash

PROJECT=$1
REF_HASH_DIR=$2
REF_GENOME=$3
HAPMAP=$4
OMNI_VCF=$5
ONEKG_HIGH_CONF=$6
DBSNP_138=$7
ONEKG_GOLD_STD=$8

CORE_PATH='/isilon/sequencing/Seq_Proj/'
GVCF_LIST=$(ls $CORE_PATH'/'$PROJECT'/GVCF/'*.gvcf | awk '{print "--variant",$0}' | tr '\n' ' ')

START_JOINT_CALLING=`date '+%s'`

/opt/edico/bin/dragen -f -r $REF_HASH_DIR --enable-joint-genotyping true --enable-vqsr true --vc-reference $REF_GENOME --output-directory $CORE_PATH'/'$PROJECT'/DRAGEN_OUTPUT/' --intermediate-results-dir /staging/tmp --output-file-prefix $PROJECT'_MS' $GVCF_LIST --vqsr-config-file /opt/edico/config/dragen-VQSR.cfg --vqsr-annotation INDEL,DP,QD,FS,MQRankSum,ReadPosRankSum --vqsr-annotation SNP,QD,ReadPosRankSum,FS,DP  --vqsr-resource SNP,15.0,$HAPMAP --vqsr-resource SNP,12.0,$OMNI_VCF --vqsr-resource SNP,10.0,$ONEKG_HIGH_CONF --vqsr-resource SNP,2.0,$DBSNP_138 --vqsr-resource INDEL,12.0,$ONEKG_GOLD_STD --vqsr-resource INDEL,2.0,$DBSNP_138 --vqsr-tranche 100.0 --vqsr-tranche 99.9 --vqsr-tranche 99.8 --vqsr-tranche 99.7 --vqsr-tranche 99.6 --vqsr-tranche 99.5 --vqsr-tranche 99.4 --vqsr-tranche 99.3 --vqsr-tranche 99.2 --vqsr-tranche 99.1 --vqsr-tranche 99.0 --vqsr-tranche 98.0 --vqsr-tranche 97.0 --vqsr-tranche 96.0 --vqsr-tranche 95.0 --vqsr-tranche 90.0 --vqsr-filter-level SNP,99.5 --vqsr-filter-level INDEL,99.0 --dbsnp $DBSNP_138

END_JOINT_CALLING=`date '+%s'`



echo 'JOINT_CALLING,'$START_JOINT_CALLING','$END_JOINT_CALLING >> $PROJECT'/REPORTS/'/run_times.csv