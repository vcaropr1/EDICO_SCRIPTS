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
GAP_BED=$6
PROJECT=$7
SM_TAG=$8

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_DOC_AUTO_WG=`date '+%s'`

### --Depth of Coverage On Bait--

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T DepthOfCoverage \
-R $REF_GENOME \
-I $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
-XL X \
-XL Y \
-XL MT \
-XL GL000207.1 \
-XL GL000226.1 \
-XL GL000229.1 \
-XL GL000231.1 \
-XL GL000210.1 \
-XL GL000239.1 \
-XL GL000235.1 \
-XL GL000201.1 \
-XL GL000247.1 \
-XL GL000245.1 \
-XL GL000197.1 \
-XL GL000203.1 \
-XL GL000246.1 \
-XL GL000249.1 \
-XL GL000196.1 \
-XL GL000248.1 \
-XL GL000244.1 \
-XL GL000238.1 \
-XL GL000202.1 \
-XL GL000234.1 \
-XL GL000232.1 \
-XL GL000206.1 \
-XL GL000240.1 \
-XL GL000236.1 \
-XL GL000241.1 \
-XL GL000243.1 \
-XL GL000242.1 \
-XL GL000230.1 \
-XL GL000237.1 \
-XL GL000233.1 \
-XL GL000204.1 \
-XL GL000198.1 \
-XL GL000208.1 \
-XL GL000191.1 \
-XL GL000227.1 \
-XL GL000228.1 \
-XL GL000214.1 \
-XL GL000221.1 \
-XL GL000209.1 \
-XL GL000218.1 \
-XL GL000220.1 \
-XL GL000213.1 \
-XL GL000211.1 \
-XL GL000199.1 \
-XL GL000217.1 \
-XL GL000216.1 \
-XL GL000215.1 \
-XL GL000205.1 \
-XL GL000219.1 \
-XL GL000224.1 \
-XL GL000223.1 \
-XL GL000195.1 \
-XL GL000212.1 \
-XL GL000222.1 \
-XL GL000200.1 \
-XL GL000193.1 \
-XL GL000194.1 \
-XL GL000225.1 \
-XL GL000192.1 \
-XL NC_007605 \
-XL hs37d5 \
-XL $GAP_BED \
-mmq 20 \
-mbq 10 \
--outputFormat csv \
-omitBaseOutput \
-omitIntervals \
--omitLocusTable \
-o $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.whole_genome" \
-et NO_ET \
-K $KEY \
-ct 5 \
-ct 10 \
-ct 15 \
-ct 20 \
-nt 4

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.whole_genome.sample_statistics" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.whole_genome.sample_statistics.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.whole_genome.sample_summary" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.whole_genome.sample_summary.csv"

END_DOC_AUTO_WG=`date '+%s'`

echo 'DEPTH_OF_COVERAGE_WG,A.02,'$START_DOC_AUTO_WG','$END_DOC_AUTO_WG >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv