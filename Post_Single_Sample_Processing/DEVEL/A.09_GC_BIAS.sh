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

START_GC_BIAS=`date '+%s'`

## --GC Bias Metrics--

$JAVA_1_7/java -jar $PICARD_DIR/CollectGcBiasMetrics.jar \
INPUT=$CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
OUTPUT=$CORE_PATH/$PROJECT/REPORTS/GC_BIAS/METRICS/$SM_TAG"_gc_bias_metrics.txt" \
CHART_OUTPUT=$CORE_PATH/$PROJECT/REPORTS/GC_BIAS/PDF/$SM_TAG"_gc_bias_metrics.pdf" \
SUMMARY_OUTPUT=$CORE_PATH/$PROJECT/REPORTS/GC_BIAS/SUMMARY/$SM_TAG"_gc_bias_summary.txt" \
R=$REF_GENOME \
VALIDATION_STRINGENCY=SILENT

END_GC_BIAS=`date '+%s'`

echo 'GC_BIAS,A.09,'$START_GC_BIAS','$END_GC_BIAS >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
