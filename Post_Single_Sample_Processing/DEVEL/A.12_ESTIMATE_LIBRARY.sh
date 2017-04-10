#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
PICARD_DIR=$2
CORE_PATH=$3
PROJECT=$4
SM_TAG=$5
START_ESTIMATE_LIBRARY=`date '+%s'`

## --Estimate Library Complexity from bam file

$JAVA_1_7/java -jar $PICARD_DIR/picard.jar \
EstimateLibraryComplexity \
INPUT=$CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
OUTPUT=$CORE_PATH/$PROJECT/REPORTS/ESTIMATE_LIBRARY/$SM_TAG"_duplication.txt" \
VALIDATION_STRINGENCY=SILENT

END_ESTIMATE_LIBRARY=`date '+%s'`

echo 'ESTIMATE_LIBRARY,A.13,'$START_ESTIMATE_LIBRARY','$END_ESTIMATE_LIBRARY >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

