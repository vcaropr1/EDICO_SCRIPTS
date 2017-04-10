#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
GATK_DIR=$2
VERIFY_DIR=$3
REF_GENOME=$4
KEY=$5
CORE_PATH=$6
VERIFY_VCF=$7
PROJECT=$8
SM_TAG=$9

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_VERIFY_BAM_ID=`date '+%s'`

## --Creating an on the fly VCF file to be used as the reference for verifyBamID--

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
--variant $VERIFY_VCF \
-L 20 \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/TEMP/$SM_TAG".VerifyBamID.20.vcf"

## --Running verifyBamID--

$VERIFY_DIR/verifyBamID \
--bam $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
--vcf $CORE_PATH/$PROJECT/TEMP/$SM_TAG".VerifyBamID.20.vcf" \
--out $CORE_PATH/$PROJECT/REPORTS/VERIFY_BAM_ID/$SM_TAG \
--precise \
--verbose \
--maxDepth 200

END_VERIFY_BAM_ID=`date '+%s'`

echo 'VERIFY_BAM_ID,A.05,'$START_VERIFY_BAM_ID','$END_VERIFY_BAM_ID >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

