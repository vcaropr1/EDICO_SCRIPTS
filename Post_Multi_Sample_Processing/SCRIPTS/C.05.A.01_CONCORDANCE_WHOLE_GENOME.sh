#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V

PROJECT=$1
SM_TAG=$2
REF_GENOME=$3
DBSNP=$4
MDNA_HASH_ADDRESS=$5

CIDR_SEQSUITE_JAVA_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/java/jdk1.8.0_45/bin/"
CIDR_SEQSUITE_7_2_2_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/7.2.2/"
VERACODE_CSV=
CORE_PATH=
# /isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/grch37.nogap.nochr.bed TARGET_BED
# /isilon/sequencing/CIDRSeqSuiteSoftware/java/jdk1.8.0_45/bin/java -jar /isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/7.2.2/CIDRSeqSuite.jar -concordance /isilon/sequencing/Seq_Proj/EDICO_TRIO_TEST/SNV/MULTI/WHOLE_GENOME/PASS/ /isilon/sequencing/Seq_Proj/EDICO_TRIO_TEST/Pretesting/Final_Genotyping_Reports/ /isilon/sequencing/Seq_Proj/EDICO_TRIO_TEST/REPORTS/CONCORDANCE_MS/WHOLE_GENOME/ /isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/grch37.nogap.nochr.bed /isilon/sequencing/CIDRSeqSuiteSoftware/resources/Veracode_hg18_hg19.csv
mkdir -p $CORE_PATH/$PROJECT/TEMP/$SM_TAG

cp $CORE_PATH/$PROJECT/SNV/MULTI/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.SNV.vcf" \
$CORE_PATH/$PROJECT/TEMP/$SM_TAG/$SM_TAG".WHOLE.GENOME.SNV.vcf"

CMD=$CIDR_SEQSUITE_JAVA_DIR'/java -jar'
CMD=$CMD' '$CIDR_SEQSUITE_7_2_2_DIR'/CIDRSeqSuite.jar'
CMD=$CMD' -concordance'
CMD=$CMD' '$CORE_PATH'/'$PROJECT'/TEMP/'$SM_TAG
CMD=$CMD' '$CORE_PATH'/'$PROJECT'/Pretesting/Final_Genotyping_Reports/'
CMD=$CMD' '$CORE_PATH'/'$PROJECT'/TEMP/'$SM_TAG
CMD=$CMD' /isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/grch37.nogap.nochr.bed'
CMD=$CMD' /isilon/sequencing/CIDRSeqSuiteSoftware/resources/Veracode_hg18_hg19.csv'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# $CIDR_SEQSUITE_JAVA_DIR/java -jar \
# $CIDR_SEQSUITE_7_2_2_DIR/CIDRSeqSuite.jar \
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
