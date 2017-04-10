#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
PICARD_DIR=$2
SAMTOOLS_DIR=$3
REF_GENOME=$4
CORE_PATH=$5
PROJECT=$6
DBSNP=$7
SM_TAG=$8

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_OXIDATION=`date '+%s'`

# Create CollectOxoGMetrics metrics bed files

 ($SAMTOOLS_DIR/samtools view -H $CORE_PATH'/'$PROJECT'/BAM/'$SM_TAG'.bam' \
 | grep "@SQ" ; echo -e 1"\t"1"\t"200000000"\t"+"\t"FOO) \
 >| $CORE_PATH/$PROJECT/TEMP/$SM_TAG".CHR1.oxidation.picard.bed"

# ($SAMTOOLS_DIR/samtools view -H $CORE_PATH/$PROJECT/$DNA_HASH_ADDRESS/Recalibration/alignments.bam \
# | grep "@SQ" ; echo -e 1"\t"1"\t"200000000"\t"+"\t"FOO) \
# >| $CORE_PATH/$PROJECT/TEMP/$SM_TAG".CHR1.oxidation.picard.bed"

## --Collect metrics quantifying the CpCG -> CpCA error rate from the provided SAM/BAM--

$JAVA_1_7/java -jar $PICARD_DIR/picard.jar \
CollectOxoGMetrics \
INPUT=$CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
OUTPUT=$CORE_PATH/$PROJECT/REPORTS/OXIDATION/$SM_TAG"_oxidation.txt" \
R=$REF_GENOME \
INTERVALS=$CORE_PATH/$PROJECT/TEMP/$SM_TAG".CHR1.oxidation.picard.bed" \
DB_SNP=$DBSNP \
MINIMUM_QUALITY_SCORE=10 \
MINIMUM_MAPPING_QUALITY=20 \
VALIDATION_STRINGENCY=SILENT

END_OXIDATION=`date '+%s'`

echo 'OXIDATION,A.11,'$START_OXIDATION','$END_OXIDATION >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
