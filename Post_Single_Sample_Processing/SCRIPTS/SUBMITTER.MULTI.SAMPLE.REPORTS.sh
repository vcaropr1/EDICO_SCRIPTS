#!/bin/bash

SAMPLE_SHEET=$1
GATK_VERSION=$2
PED_FILE=$3

TIMESTAMP=`date '+%F.%H-%M-%S'`

# echo START ADDING EXTRA ANNNOTATIONS TO VCF FILE AT $TIMESTAMP
# echo

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR=2 \
{print "/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin/java",\
"-jar",\
"/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-""'$GATK_VERSION'""/GenomeAnalysisTK.jar",\
"-T VariantAnnotator",\
"-R",$3,\
"--variant /isilon/sequencing/Seq_Proj/"$1"/"$6"/VQSR/variants.all.vcf",\
"-L /isilon/sequencing/Seq_Proj/"$1"/"$6"/VQSR/variants.all.vcf",\
"-ped","'$PED_FILE'",\
"-A SampleList",\
"-A GCContent",\
"-A VariantType",\
"-A PossibleDeNovo",\
"-A MVLikelihoodRatio",\
"-A GenotypeSummaries",\
"-A SampleList",\
"--disable_auto_index_creation_and_locking_when_reading_rods",\
"-et NO_ET",\
"-K /isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_2/lee.watkins_jhmi.edu.key",\
"-o /isilon/sequencing/Seq_Proj/"$1"/"$6"/VQSR/variants.all.ANNOTATED.vcf"}' \
| awk 'NR==2'

# echo
# echo END ADDING EXTRA ANNNOTATIONS TO VCF FILE AT $TIMESTAMP

# echo
# echo START SUBMITTING JOBS

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.01_EXTRACT_VCF_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.01_EXTRACT_VCF_WHOLE_GENOME.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.02_EXTRACT_VCF_CODING."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.02_EXTRACT_VCF_CODING.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.04_EXTRACT_VCF_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.VARIANT.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.04_EXTRACT_VCF_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.05_EXTRACT_SNV_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.05_EXTRACT_SNV_WHOLE_GENOME.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.06_EXTRACT_SNV_CODING."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.06_EXTRACT_SNV_CODING.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.VARIANT.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.08_EXTRACT_SNV_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.09_EXTRACT_INDEL_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.09_EXTRACT_INDEL_WHOLE_GENOME.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.10_EXTRACT_INDEL_CODING."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.10_EXTRACT_INDEL_CODING.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.12_EXTRACT_INDEL_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.VARIANT.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.12_EXTRACT_INDEL_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

# sed 's/\r//g' $SAMPLE_SHEET \
# | awk 'BEGIN {FS=","} NR>1 \
# {split($2,smtag,"@"); print "qsub","-N","C.13_VQSR_SNP_PLOT."smtag[1]"_"smtag[2],\
# "-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.SNP.PLOT.MS.log",\
# "-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.SNP.PLOT.MS.log",\
# "/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.13_VQSR_SNP_PLOT_MS.sh",\
# $1,$2,$3,$4,$5,$6"\n""sleep 3s"}'
# 
# sed 's/\r//g' $SAMPLE_SHEET \
# | awk 'BEGIN {FS=","} NR>1 \
# {split($2,smtag,"@"); print "qsub","-N","C.14_VQSR_INDEL_PLOT."smtag[1]"_"smtag[2],\
# "-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.INDEL.PLOT.MS.log",\
# "-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.INDEL.PLOT.MS.log",\
# "/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.14_VQSR_INDEL_PLOT_MS.sh",\
# $1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.15_EXTRACT_VCF_WHOLE_GENOME_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.ALL.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.15_EXTRACT_VCF_WHOLE_GENOME_PASS_ALL.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.16_EXTRACT_VCF_CODING_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.ALL.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.16_EXTRACT_VCF_CODING_PASS_ALL.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.17_EXTRACT_INDEL_WHOLE_GENOME_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.ALL.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.17_EXTRACT_INDEL_WHOLE_GENOME_PASS_ALL.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.18_EXTRACT_INDEL_CODING_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.ALL.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.18_EXTRACT_INDEL_CODING_PASS_ALL.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.19_EXTRACT_SNV_WHOLE_GENOME_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.ALL.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.19_EXTRACT_SNV_WHOLE_GENOME_PASS_ALL.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","C.20_EXTRACT_SNV_CODING_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.ALL.MS.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/C.20_EXTRACT_SNV_CODING_PASS_ALL.sh",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

# echo
# echo DONE SUBMITTING SGE AT $TIMESTAMP

# echo
# echo START BGZIP-ING NEW VCF FILE AT $TIMESTAMP

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR=2 \
{print "bgzip-0.2.6 -c",\
"/isilon/sequencing/Seq_Proj/"$1"/"$6"/VQSR/variants.all.ANNOTATED.vcf",\
">| /isilon/sequencing/Seq_Proj/"$1"/"$6"/VQSR/variants.all.ANNOTATED.vcf.gz"}' \
| awk 'NR==2'

# echo
# echo END BGZIP-ING NEW VCF FILE AT $TIMESTAMP

# echo
# echo START TABIX ON BGZIP VCF FILE AT $TIMESTAMP

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR=2 \
{print "tabix-0.2.6 -f -p vcf",\
"/isilon/sequencing/Seq_Proj/"$1"/"$6"/VQSR/variants.all.ANNOTATED.vcf.gz"}' \
| awk 'NR==2'

# echo
# echo END TABIX ON BGZIP VCF FILE AT $TIMESTAMP

# echo FINISHED, JOBS HAVE BEEN SUBMITTED TO SGE AND VCF FILE ANNOTATED,BGZIPPED AND INDEXED WITH TABIX
