#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
GATK_DIR=$2
TABIX_DIR=$3
KEY=$4
CODING_BED=$5
CODING_BED_MT=$6
REF_GENOME=$7
CORE_PATH=$8
PROJECT=$9
SM_TAG=${10}

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_EXTRACT_VCF_CODING=`date '+%s'`

# EXTRACT SAMPLE AND FILTER ON CODING REGIONS

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
--keepOriginalAC \
-L $CODING_BED \
-L $CODING_BED_MT \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/VCF/SINGLE/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.vcf" \
-o $CORE_PATH/$PROJECT/VCF/SINGLE/CODING/$SM_TAG".CODING.vcf"

$TABIX_DIR/bgzip -c $CORE_PATH/$PROJECT/VCF/SINGLE/CODING/$SM_TAG".CODING.vcf" \
>| $CORE_PATH/$PROJECT/VCF/SINGLE/CODING/$SM_TAG".CODING.vcf.gz"

$TABIX_DIR/tabix -f -p vcf $CORE_PATH/$PROJECT/VCF/SINGLE/CODING/$SM_TAG".CODING.vcf.gz"

END_EXTRACT_VCF_CODING=`date '+%s'`

echo 'EXTRACT_VCF_CODING,B.01.A.02,'$START_EXTRACT_VCF_CODING','$END_EXTRACT_VCF_CODING >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
