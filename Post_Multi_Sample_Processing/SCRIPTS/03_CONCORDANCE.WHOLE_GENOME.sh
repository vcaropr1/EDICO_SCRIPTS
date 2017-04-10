#!/bin/bash

PROJECT=$1
CALLS=$2
CALL_OUTPUT=$3
TARGET_BED=$4

# CALLS IS EITHER SINGLE OR MULTI
# CALL_OUTPUT IS EITHER CONCORDANCE OR CONCORDANCE_MS
# TARGET BED WOULD BE "grch37.nogap.nochr.bed" FOR WHOLE GENOME

/isilon/sequencing/CIDRSeqSuiteSoftware/java/jre1.7.0_45/bin/java -jar \
/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/6.1.1/CIDRSeqSuite.jar \
-pipeline -concordance \
/isilon/sequencing/Seq_Proj/$PROJECT/SNV/$CALLS/WHOLE_GENOME/PASS/ \
/isilon/sequencing/Seq_Proj/$PROJECT/Pretesting/Final_Genotyping_Reports/ \
/isilon/sequencing/Seq_Proj/$PROJECT/REPORTS/$CALL_OUTPUT/WHOLE_GENOME/ \
/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/$TARGET_BED \
/isilon/sequencing/CIDRSeqSuiteSoftware/resources/Veracode_hg18_hg19.csv
