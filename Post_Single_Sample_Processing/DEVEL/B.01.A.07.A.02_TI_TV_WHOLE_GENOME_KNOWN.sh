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

START_TI_TV_WG_KNOWN=`date '+%s'`

# TI/TV WHOLE GENOME KNOWN

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/SNV/SINGLE/WHOLE_GENOME/PASS/$SM_TAG".WHOLE.GENOME.SNV.PASS.vcf" \
--concordance $DBSNP_129_EXCLUDE_138 \
-o $CORE_PATH/$PROJECT/TEMP/$SM_TAG".QC.Known.TiTv.vcf"

$SAMTOOLS_DIR/bcftools/vcfutils.pl qstats $CORE_PATH/$PROJECT/TEMP/$SM_TAG".QC.Known.TiTv.vcf" \
>| $CORE_PATH/$PROJECT/REPORTS/TI_TV/WHOLE_GENOME/$SM_TAG"_Known_titv.txt"

END_TI_TV_WG_KNOWN=`date '+%s'`

echo 'TI_TV_WG_KNOWN,B.01.A.07.A.02,'$START_TI_TV_WG_KNOWN','$END_TI_TV_WG_KNOWN >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
