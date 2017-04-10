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

START_BQSR=`date '+%s'`

## --Base Call Quality Score Distribution--

$JAVA_1_7/java -jar $PICARD_DIR/QualityScoreDistribution.jar \
INPUT=$CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
OUTPUT=$CORE_PATH/$PROJECT/REPORTS/BASECALL_Q_SCORE_DISTRIBUTION/METRICS/$SM_TAG"_quality_score_distribution.txt" \
CHART=$CORE_PATH/$PROJECT/REPORTS/BASECALL_Q_SCORE_DISTRIBUTION/PDF/$SM_TAG"_quality_score_distribution_chart.pdf" \
R=$REF_GENOME \
VALIDATION_STRINGENCY=SILENT \
INCLUDE_NO_CALLS=true

END_BQSR=`date '+%s'`

echo 'BASECALL_Q_SCORE_DISTRIBUTION,A.08,'$START_BQSR','$END_BQSR >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

