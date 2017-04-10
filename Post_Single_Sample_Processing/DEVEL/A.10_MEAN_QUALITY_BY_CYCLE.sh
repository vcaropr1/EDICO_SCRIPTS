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

START_MEAN_QUALITY=`date '+%s'`

## --Mean Quality By Cycle--

$JAVA_1_7/java -jar $PICARD_DIR/MeanQualityByCycle.jar \
INPUT=$CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
OUTPUT=$CORE_PATH/$PROJECT/REPORTS/MEAN_QUALITY_BY_CYCLE/METRICS/$SM_TAG"_mean_quality_by_cycle.txt" \
CHART=$CORE_PATH/$PROJECT/REPORTS/MEAN_QUALITY_BY_CYCLE/PDF/$SM_TAG"_mean_quality_by_cycle_chart.pdf" \
R=$REF_GENOME \
VALIDATION_STRINGENCY=SILENT

END_MEAN_QUALITY=`date '+%s'`

echo 'MEAN_QUALITY_BY_CYCLE,A.10,'$START_MEAN_QUALITY','$END_MEAN_QUALITY >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

