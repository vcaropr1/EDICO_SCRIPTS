#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

JAVA_1_7=$1
GATK_DIR=$2
SAMTOOLS_DIR=$3
KEY=$4
REF_GENOME=$5
DBSNP_129_EXCLUDE_138=$6
CORE_PATH=$7
PROJECT=$8
SM_TAG=$9

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

START_TI_TV_CODING_NOVEL=`date '+%s'`

# TI/TV WHOLE GENOME NOVEL

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/SNV/SINGLE/CODING/PASS/$SM_TAG".CODING.SNV.PASS.vcf" \
--discordance $DBSNP_129_EXCLUDE_138 \
-o $CORE_PATH/$PROJECT/TEMP/$SM_TAG".QC.Novel.TiTv.vcf"

$SAMTOOLS_DIR/bcftools/vcfutils.pl qstats $CORE_PATH/$PROJECT/TEMP/$SM_TAG".QC.Novel.TiTv.vcf" >| \
$CORE_PATH/$PROJECT/REPORTS/TI_TV/CODING/$SM_TAG"_Novel_titv.txt"

END_TI_TV_CODING_NOVEL=`date '+%s'`

echo 'TI_TV_CODING_NOVEL,B.01.A.08.A.03,'$START_TI_TV_CODING_NOVEL','$END_TI_TV_CODING_NOVEL >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
