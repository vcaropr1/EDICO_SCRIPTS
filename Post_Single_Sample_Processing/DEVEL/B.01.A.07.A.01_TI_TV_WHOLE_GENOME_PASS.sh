#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set
SAMTOOLS_DIR=$1
CORE_PATH=$2
PROJECT=$3
SM_TAG=$4

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_WG_TITV_PASS=`date '+%s'`

# TI/TV WHOLE GENOME ALL

$SAMTOOLS_DIR/bcftools/vcfutils.pl qstats $CORE_PATH/$PROJECT/SNV/SINGLE/WHOLE_GENOME/PASS/$SM_TAG".WHOLE.GENOME.SNV.PASS.vcf" \
>| $CORE_PATH/$PROJECT/REPORTS/TI_TV/WHOLE_GENOME/$SM_TAG"_All_titv.txt"

END_WG_TITV_PASS=`date '+%s'`

echo 'TI_TV_WG_PASS,B.01.A.07.A01,'$START_WG_TITV_PASS','$END_WG_TITV_PASS >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv

