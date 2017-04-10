#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
CORE_PATH=$4
PROJECT=$5
SM_TAG=$6

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_EXTRACT_INDEL_WG_PASS=`date '+%s'`

# Filter INDEL+MIXED+MNP only, REMOVE NON-VARIANT, FAIL

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
-ef \
-env \
--keepOriginalAC \
-selectType INDEL \
-selectType MIXED \
-selectType MNP \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/VCF/SINGLE/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.vcf" \
-o $CORE_PATH/$PROJECT/INDEL/SINGLE/WHOLE_GENOME/PASS/$SM_TAG".WHOLE.GENOME.INDEL.PASS.vcf"

END_EXTRACT_INDEL_WG_PASS=`date '+%s'`

echo 'EXTRACT_INDEL_WG_PASS,B.01.A.11,'$START_EXTRACT_INDEL_WG_PASS','$END_EXTRACT_INDEL_WG_PASS >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
