#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V


CIDR_SEQSUITE_JAVA_DIR=$1
CIDR_SEQSUITE_6_1_1_DIR=$2
VERACODE_CSV=$3

CORE_PATH=$4
PROJECT=$5
SM_TAG=$6
TARGET_BED=$7
# /isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/grch37.nogap.nochr.bed TARGET_BED

mkdir -p $CORE_PATH/$PROJECT/TEMP/$SM_TAG

cp $CORE_PATH/$PROJECT/SNV/SINGLE/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.SNV.vcf" \
$CORE_PATH/$PROJECT/TEMP/$SM_TAG/$SM_TAG".WHOLE.GENOME.SNV.vcf"

CMD=$CIDR_SEQSUITE_JAVA_DIR'/java -jar'
CMD=$CMD' '$CIDR_SEQSUITE_6_1_1_DIR'/CIDRSeqSuite.jar'
CMD=$CMD' -pipeline -concordance'
CMD=$CMD' '$CORE_PATH'/'$PROJECT'/TEMP/'$SM_TAG
CMD=$CMD' '$CORE_PATH'/'$PROJECT'/Pretesting/Final_Genotyping_Reports/'
CMD=$CMD' '$CORE_PATH'/'$PROJECT'/TEMP/'$SM_TAG
CMD=$CMD' '$TARGET_BED
CMD=$CMD' '$VERACODE_CSV

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# $CIDR_SEQSUITE_JAVA_DIR/java -jar \
# $CIDR_SEQSUITE_6_1_1_DIR/CIDRSeqSuite.jar \
# -pipeline -concordance \
# $CORE_PATH/$PROJECT/TEMP/$SM_TAG \
# $CORE_PATH/$PROJECT/Pretesting/Final_Genotyping_Reports/ \
# $CORE_PATH/$PROJECT/TEMP/$SM_TAG \
# $TARGET_BED \
# $VERACODE_CSV

mv $CORE_PATH/$PROJECT/TEMP/$SM_TAG/$SM_TAG"_concordance.csv" \
$CORE_PATH/$PROJECT/REPORTS/CONCORDANCE_MS/WHOLE_GENOME/$SM_TAG"_concordance.csv"

mv $CORE_PATH/$PROJECT/TEMP/$SM_TAG/missing_data.csv \
$CORE_PATH/$PROJECT/REPORTS/CONCORDANCE_MS/WHOLE_GENOME/$SM_TAG"_missing_data.csv"

mv $CORE_PATH/$PROJECT/TEMP/$SM_TAG/discordant_data.csv \
$CORE_PATH/$PROJECT/REPORTS/CONCORDANCE_MS/WHOLE_GENOME/$SM_TAG"_discordant_calls.csv"
