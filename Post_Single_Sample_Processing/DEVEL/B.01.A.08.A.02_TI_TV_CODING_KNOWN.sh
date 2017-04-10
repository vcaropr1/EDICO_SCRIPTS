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

START_TI_TV_CODING_KNOWN=`date '+%s'`

# TI/TV WHOLE GENOME KNOWN

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-et NO_ET \
-K $KEY \
--variant $CORE_PATH/$PROJECT/SNV/SINGLE/CODING/PASS/$SM_TAG".CODING.SNV.PASS.vcf" \
--concordance /isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf \
-o $CORE_PATH/$PROJECT/TEMP/$SM_TAG".QC.Known.TiTv.vcf"

$SAMTOOLS_DIR/bcftools/vcfutils.pl qstats $CORE_PATH/$PROJECT/TEMP/$SM_TAG".QC.Known.TiTv.vcf" \
>| $CORE_PATH/$PROJECT/REPORTS/TI_TV/CODING/$SM_TAG"_Known_titv.txt"

END_TI_TV_CODING_KNOWN=`date '+%s'`

echo 'TI_TV_CODING_KNOWN,B.01.A.08.A.02,'$START_TI_TV_CODING_KNOWN','$END_TI_TV_CODING_KNOWN >> $CORE_PATH/$PROJECT/REPORTS/run_times.csv
