#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
GATK_DIR=$2
REF_GENOME=$3
KEY=$4
CORE_PATH=$5
CODING_BED=$6
CODING_BED_MT=$7
GENE_LIST=$8
PROJECT=$9
SM_TAG=${10}
RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_DOC_CODING=`date '+%s'`

### --Depth of Coverage On Bait--

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T DepthOfCoverage \
-R $REF_GENOME \
-geneList:REFSEQ $GENE_LIST \
-I $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
-L $CODING_BED \
-L $CODING_BED_MT \
-mmq 20 \
-mbq 10 \
--outputFormat csv \
-omitBaseOutput \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon" \
-ct 5 \
-ct 10 \
-ct 15 \
-ct 20

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_cumulative_coverage_counts" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_cumulative_coverage_counts.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_cumulative_coverage_proportions" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_cumulative_coverage_proportions.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_gene_summary" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_gene_summary.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_interval_statistics" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_interval_statistics.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_interval_summary" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_interval_summary.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_statistics" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_statistics.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_summary" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/CODING_COVERAGE/$SM_TAG".ucsc.exon.sample_summary.csv"

END_DOC_CODING=`date '+%s'`

echo 'DEPTH_OF_COVERAGE_CODING,A.03,'$START_DOC_CODING','$END_DOC_CODING >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

