#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
PICARD_DIR=$2
REF_GENOME=$3
CORE_PATH=$4
PROJECT=$5
SM_TAG=$6

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_ALIGNMENT_SUMMARY=`date '+%s'`

## --Alignment Summary Metrics--

$JAVA_1_7/java -jar $PICARD_DIR/CollectAlignmentSummaryMetrics.jar \
INPUT=$CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
OUTPUT=$CORE_PATH/$PROJECT/REPORTS/ALIGNMENT_SUMMARY/$SM_TAG"_alignment_summary_metrics.txt" \
R=$REF_GENOME \
VALIDATION_STRINGENCY=SILENT

END_ALIGNMENT_SUMMARY=`date '+%s'`

echo 'ALIGNMENT_SUMMARY_METRICS,A.07,'$START_ALIGNMENT_SUMMARY','$END_ALIGNMENT_SUMMARY >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
