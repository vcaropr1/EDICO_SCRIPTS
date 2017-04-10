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
CODING_BED=$5
CODING_BED_MT=$6
CORE_PATH=$7
PROJECT=$8
SM_TAG=$9

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_EXTRACT_INDEL_CODING=`date '+%s'`

# EXTRACT SAMPLE AND FILTER ON CODING REGIONS

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
--keepOriginalAC \
-selectType INDEL \
-selectType MIXED \
-selectType MNP \
-L $CODING_BED \
-L $CODING_BED_MT \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/VCF/SINGLE/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.vcf" \
-o $CORE_PATH/$PROJECT/INDEL/SINGLE/CODING/$SM_TAG".CODING.INDEL.vcf"

END_EXTRACT_INDEL_CODING=`date '+%s'`

echo 'EXTRACT_INDEL_CODING,B.01.A.10,'$START_EXTRACT_INDEL_CODING','$END_EXTRACT_INDEL_CODING >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

