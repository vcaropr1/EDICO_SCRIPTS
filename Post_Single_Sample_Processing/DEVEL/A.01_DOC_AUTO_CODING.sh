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
PROJECT=$7
SM_TAG=$8
# DNA_HASH_ADDRESS=$5
# MDNA_HASH_ADDRESS=$6

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}


START_DOC_AUTO_CODING=`date '+%s'`

### --Remove X,Y,MT from the UCSC exons bed file

awk '{FS=" "} $1!~/[A-Z]/ {print $0}' $CODING_BED \
>| $CORE_PATH/$PROJECT/TEMP/$SM_TAG".UCSC.AUTO.CODING.bed"

### --Depth of Coverage AUTOSOMAL UCSC CODINGS--

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T DepthOfCoverage \
-R $REF_GENOME \
-I $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
-L $CORE_PATH/$PROJECT/TEMP/$SM_TAG".UCSC.AUTO.CODING.bed" \
-mmq 20 \
-mbq 10 \
--outputFormat csv \
-omitBaseOutput \
-omitIntervals \
--omitLocusTable \
-o $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.exon" \
-et NO_ET \
-K $KEY \
-ct 5 \
-ct 10 \
-ct 15 \
-ct 20 \
-nt 4

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.exon.sample_statistics" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.exon.sample_statistics.csv"

mv -v $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.exon.sample_summary" \
$CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/$SM_TAG".autosomal.exon.sample_summary.csv"

END_DOC_AUTO_CODING=`date '+%s'`

echo 'DEPTH_OF_COVERAGE_AUTO_CODING,A.01,'$START_DOC_AUTO_CODING','$END_DOC_AUTO_CODING >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
