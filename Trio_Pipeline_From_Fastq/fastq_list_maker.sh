#! /bin/bash

set

SAMPLE_SHEET=$1 # STANDARD SAMPLE SHEET LIKE WE USE FOR NORMAL SUBMISSIONS
FASTQ_DIR=$2 # WHERE THE FASTQ FILES ARE HOUSED.  MUST BE IN ONE DIRECTORY.  FASTQ FILES MUST BE NAMED WITH RGPU_1/2 NAMES
OUT_DIR=$3 # WHERE YOU WANT THE FASTQ_LIST TO GO

for SAMPLE in $(awk 'BEGIN{FS=","} NR>1 {print $8}' $SAMPLE_SHEET | sort | uniq )
do
echo RGID,RGSM,RGLB,Lane,Read1File,Read2File >| $OUT_DIR/$SAMPLE'_fastq_list.csv'

# for RECORD in $(awk 'NR>1 {print $0}' $SAMPLE_SHEET | grep $SAMPLE)
for RECORD in $(awk 'BEGIN{FS=","} $8 ~ "'$SAMPLE'" {print $0}' $SAMPLE_SHEET)
do
RGID=$(echo $RECORD | awk 'BEGIN{FS=","} {print $2"_"$3}')
RGPU=$(echo $RECORD | awk 'BEGIN{FS=","} {print $2"_"$3"_"$4}')
LIBRARY=$(echo $RECORD | awk 'BEGIN{FS=","} {print $6}')
LANE=$(echo $RECORD | awk 'BEGIN{FS=","} {print $3}')
READ1_FASTQ=$(ls $FASTQ_DIR/* | grep $RGPU'_1')
READ2_FASTQ=$(ls $FASTQ_DIR/* | grep $RGPU'_2')

echo $RGID,$SAMPLE,$LIBRARY,$LANE,$READ1_FASTQ,$READ2_FASTQ >> $OUT_DIR/$SAMPLE'_fastq_list.csv'

done
done
