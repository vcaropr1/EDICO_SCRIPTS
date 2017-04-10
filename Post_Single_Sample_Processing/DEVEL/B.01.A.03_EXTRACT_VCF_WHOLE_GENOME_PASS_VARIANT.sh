#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4
CORE_PATH=$5
PROJECT=$6
SM_TAG=$7

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_WG_PASS=`date '+%s'`

# Extract out sample, REMOVE NON-VARIANT, FILTERED

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
--keepOriginalAC \
-ef \
-env \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/VCF/SINGLE/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.vcf" \
-o $CORE_PATH/$PROJECT/VCF/SINGLE/WHOLE_GENOME/PASS/$SM_TAG".WHOLE.GENOME.PASS.vcf"

END_WG_PASS=`date '+%s'`

echo 'EXTRACT_VCF_WG_PASS,B.01.A.03,'$START_WG_PASS','$END_WG_PASS >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

