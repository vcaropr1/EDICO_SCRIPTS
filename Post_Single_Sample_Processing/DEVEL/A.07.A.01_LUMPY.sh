#$ -S /bin/bash
#$ -q rnd.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

set

SAMTOOLS_DIR=$1
LUMPY_DIR=$2
CODING_BED=$3
CODING_BED_MT=$4
CORE_PATH=$5
PROJECT=$6
SM_TAG=$7

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}


START_LUMPY=`date '+%s'`

# Grab the Median Insert size from insert size metrics

INSERT_SIZE_MED=`awk 'NR==8 {print $1}' $CORE_PATH/$PROJECT/REPORTS/INSERT_SIZE/METRICS/$SM_TAG"__insert_size_metrics.txt"`

echo MEDIAN INSERT SIZE IS $INSERT_SIZE_MED

INSERT_SIZE_STD=`awk 'NR==8 {print $2}' $CORE_PATH/$PROJECT/REPORTS/INSERT_SIZE/METRICS/$SM_TAG"__insert_size_metrics.txt"`

echo MEDIAN ABSOLUTE DEVIATION IS $INSERT_SIZE_STD

# Grab the read length from Alignment summary metrics

READ_LENGTH=`awk 'NR==10 {print $16}' $CORE_PATH/$PROJECT/REPORTS/ALIGNMENT_SUMMARY/$SM_TAG"_alignment_summary_metrics.txt"`

echo READ LENGTH IS $READ_LENGTH

# Extract the discordant paired-end alignments.

echo start discordant pe alignments `date`

$SAMTOOLS_DIR/samtools view -u -F 0x0002 $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
| $SAMTOOLS_DIR/samtools view -u -F 0x0100 - \
| $SAMTOOLS_DIR/samtools view -u -F 0x0004 - \
| $SAMTOOLS_DIR/samtools view -u -F 0x0008 - \
| $SAMTOOLS_DIR/samtools view -b -F 0x0400 - \
>| $CORE_PATH/$PROJECT/TEMP/$SM_TAG".lumpy.discordant.pe.bam"

echo end discordant pe alignments `date`

# sort the file

echo start sorting discordant pe alignments `date`

$SAMTOOLS_DIR/samtools sort $CORE_PATH/$PROJECT/TEMP/$SM_TAG".lumpy.discordant.pe.bam" \
$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.discordant.pe.sort"

echo end sorting discordant pe alignments `date`

# Extract the secondary alignments

echo start secondary alignments `date`

$SAMTOOLS_DIR/samtools view -h $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
| $LUMPY_DIR/scripts/extractSplitReads_BwaMem -i stdin \
| $SAMTOOLS_DIR/samtools view -Sb - \
>| $CORE_PATH/$PROJECT/TEMP/$SM_TAG".lumpy.split.reads.bam"

echo end secondary alignments `date`

# Sort the file

echo start sorting secondary alignments `date`

$SAMTOOLS_DIR/samtools sort $CORE_PATH/$PROJECT/TEMP/$SM_TAG".lumpy.split.reads.bam" \
$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.split.reads.sort"

echo end sorting secondary alignments `date`

# define paired-end distribution from 10000 proper alignments (break point probability distortion, not fragment size distribution)

echo start break point probability distortion `date`

$SAMTOOLS_DIR/samtools view $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
| tail -n+100000 \
| $LUMPY_DIR/scripts/pairend_distro.py \
-r $READ_LENGTH \
-X 4 \
-N 10000 \
-o $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.discordant.pe.sort.hist.txt"

echo end break point probability distortion `date`

# get coverages

echo start get coverages `date`

python $LUMPY_DIR/scripts/get_coverages.py \
$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.discordant.pe.sort.bam" \
$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.split.reads.sort.bam"

echo end get coverages `date`

# Generate exclusion list of regions with coverage greater than 250

echo start high coverage exclusion list `date`

python $LUMPY_DIR/scripts/get_exclude_regions.py \
250 \
$CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".high.coverge.exclude.bed" \
$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.discordant.pe.sort.bam" \
$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.split.reads.sort.bam"

echo end high coverage exclusion list `date`

# Run lumpy using both paired and split reads

echo start lumpy `date`

$LUMPY_DIR/bin/lumpy \
-mw 4 \
-tt 0.0 \
-x $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".high.coverge.exclude.bed" \
-pe bam_file:$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.discordant.pe.sort.bam",\
histo_file:$CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.discordant.pe.sort.hist.txt",\
mean:$INSERT_SIZE_MED,\
stdev:$INSERT_SIZE_STD,\
read_length:$READ_LENGTH,\
min_non_overlap:$READ_LENGTH,\
discordant_z:4,\
back_distance:20,\
weight:1,\
id:$SM_TAG,\
min_mapping_threshold:20 \
-sr bam_file:$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.split.reads.sort.bam",\
back_distance:20,\
weight:1,\
id:$SM_TAG,\
min_mapping_threshold:20 \
>| $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe"

echo -pe bam_file:$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.discordant.pe.sort.bam",\
histo_file:$CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.discordant.pe.sort.hist.txt",\
mean:$INSERT_SIZE_MED,\
stdev:$INSERT_SIZE_STD,\
read_length:$READ_LENGTH,\
min_non_overlap:$READ_LENGTH,\
discordant_z:4,\
back_distance:20,\
weight:1,\
id:$SM_TAG,\
min_mapping_threshold:20 >| $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".LUMPY.INPUT.STRING.txt"

echo -sr bam_file:$CORE_PATH/$PROJECT/LUMPY/BAM/$SM_TAG".lumpy.split.reads.sort.bam",\
back_distance:20,\
weight:1,\
id:$SM_TAG,\
min_mapping_threshold:20 >> $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".LUMPY.INPUT.STRING.txt"

echo end lumpy `date`

############################################################### 

# Was going to try to convert and use one of their provisional scripts to convert to VCF, but it doesn't look like it is worth the effort.
# 
# echo -e $SM_TAG"\t"1"\t"PE \
# >| $CORE_PATH/$PROJECT/TEMP/$SM_TAG".bedpeToVcf.config"
# 
# (awk '$1~/^[0-9]/' $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe" | sort -k1,1n -k2,2n ; \
# awk '$1=="X"' $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe" | sort -k 2,2n ; \
# awk '$1=="Y"' $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe" | sort -k 2,2n ; \
# awk '$1=="MT"' $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe" | sort -k 2,2n ;
# awk '$1~"GL"' $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe" | sort -k 2,2n ;
# awk '$1=="hs37d5"' $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe" | sort -k 2,2n) \
# | egrep "DELETION|DUPLICATION|INVERSION" \
# >| $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.sort.bedpe"
# 
# $LUMPY_DIR/bin/bedpeToVcf.py \
# -t lumpy_0.2.9 \
# -c $CORE_PATH/$PROJECT/TEMP/$SM_TAG".bedpeToVcf.config" \
# -b $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.sort.bedpe" \
# -f $REF_GENOME \
# -o $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe.vcf"
#
##############################################################

echo start filter on ucsc exons `date`

(sed 's/\r//g' $CODING_BED | sed -r 's/[[:space:]]+/\t/g' ; \
sed 's/\r//g' $CODING_BED_MT | sed -r 's/[[:space:]]+/\t/g' | cut -f 1-3) \
| pairToBed-2.16.2 \
-a $CORE_PATH/$PROJECT/LUMPY/RAW/$SM_TAG".lumpy.bedpe" \
-b /dev/stdin \
| egrep -v "hs37d5|GL000" \
>| $CORE_PATH/$PROJECT/LUMPY/UCSC_CODING/$SM_TAG".lumpy.all_ucsc_coding.bedpe"

echo end filter on ucsc exons `date`

END_LUMPY=`date '+%s'`

echo 'LUMPY,A.07.A01,'$START_LUMPY','$END_LUMPY >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
