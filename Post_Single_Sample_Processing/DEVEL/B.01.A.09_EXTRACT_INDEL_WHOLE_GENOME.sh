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

START_EXTRACT_INDEL_WG=`date '+%s'`

# Extract out sample

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
-selectType INDEL \
-selectType MIXED \
-selectType MNP \
--keepOriginalAC \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/VCF/SINGLE/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.vcf" \
-o $CORE_PATH/$PROJECT/INDEL/SINGLE/WHOLE_GENOME/$SM_TAG".WHOLE.GENOME.INDEL.vcf"

END_EXTRACT_INDEL_WG=`date '+%s'`

echo 'EXTRACT_INDEL_WG,B.01.A.09,'$START_EXTRACT_INDEL_WG','$END_EXTRACT_INDEL_WG >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
