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

START_INSERT_SIZE=`date '+%s'`

## --Insert Size--

$JAVA_1_7/java -jar $PICARD_DIR/CollectInsertSizeMetrics.jar \
INPUT=$CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
OUTPUT=$CORE_PATH/$PROJECT/REPORTS/INSERT_SIZE/METRICS/$SM_TAG"__insert_size_metrics.txt" \
H=$CORE_PATH/$PROJECT/REPORTS/INSERT_SIZE/PDF/$SM_TAG"_insert_size_metrics_histogram.pdf" \
R=$REF_GENOME \
VALIDATION_STRINGENCY=SILENT

END_INSERT_SIZE=`date '+%s'`

echo 'INSERT_SIZE,A.06,'$START_INSERT_SIZE','$END_INSERT_SIZE >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

