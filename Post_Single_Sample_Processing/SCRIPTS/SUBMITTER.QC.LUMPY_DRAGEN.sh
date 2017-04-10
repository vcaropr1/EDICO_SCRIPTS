#!/bin/bash

SAMPLE_SHEET=$1
PROJECT=$2

SCRIPT_DIR='/isilon/sequencing/VITO/NEW_GIT_REPO/EDICO_SCRIPTS/Post_Single_Sample_Processing/SCRIPTS/'
CORE_PATH='/isilon/sequencing/Seq_Proj'


mkdir -p $CORE_PATH/$PROJECT/LOGS


sed 's/\r//g' $SAMPLE_SHEET | \
awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.01_DOC_AUTO_CODING."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.AUTO.CODING.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.AUTO.CODING.log",\
"'$SCRIPT_DIR'""A.01_DOC_AUTO_CODING.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | \
awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.02_DOC_AUTO_WG."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.AUTO.WG.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.AUTO.WG.log",\
"'$SCRIPT_DIR'""A.02_DOC_AUTO_WG.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.03_DOC_CODING."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.CODING.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.CODING.log",\
"'$SCRIPT_DIR'""A.03_DOC_CODING.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.04_DOC_TRANSCRIPT."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.TRANSCRIPT.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".DOC.TRANSCRIPT.log",\
"'$SCRIPT_DIR'""A.04_DOC_TRANSCRIPT.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.05_VERIFY_BAM_ID."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".VERIFY.BAM.ID.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".VERIFY.BAM.ID.log",\
"'$SCRIPT_DIR'""A.05_VERIFY_BAM_ID.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.06_INSERT_SIZE."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".INSERT.SIZE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".INSERT.SIZE.log",\
"'$SCRIPT_DIR'""A.06_INSERT_SIZE.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.07_ALIGNMENT_SUMMARY_METRICS."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".ALIGNMENT.SUMMARY.METRICS.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".ALIGNMENT.SUMMARY.METRICS.log",\
"'$SCRIPT_DIR'""A.07_ALIGNMENT_SUMMARY_METRICS.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.08_BASECALL_Q_SCORE_DISTRIBUTION."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".BASECALL.Q.SCORE.DISTRIBUTION.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".BASECALL.Q.SCORE.DISTRIBUTION.log",\
"'$SCRIPT_DIR'""A.08_BASECALL_Q_SCORE_DISTRIBUTION.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.09_GC_BIAS."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".GC.BIAS.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".GC.BIAS.log",\
"'$SCRIPT_DIR'""A.09_GC_BIAS.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.10_MEAN_QUALITY_BY_CYCLE."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".MEAN.QUALITY.BY.CYCLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".MEAN.QUALITY.BY.CYCLE.log",\
"'$SCRIPT_DIR'""A.10_MEAN_QUALITY_BY_CYCLE.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.11_OXIDATION."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".OXIDATION.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".OXIDATION.log",\
"'$SCRIPT_DIR'""A.11_OXIDATION.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

# sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
# | awk ' \
# {split($2,smtag,"@"); print "qsub","-N","A.12_JUMPING."smtag[1]"_"smtag[2],\
# "-o","'$CORE_PATH'""/"$1"/LOGS/"$2".JUMPING.log",\
# "-e","'$CORE_PATH'""/"$1"/LOGS/"$2".JUMPING.log",\
# "'$SCRIPT_DIR'""A.12_JUMPING.sh",\
# $1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","A.13_ESTIMATE_LIBRARY."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".ESTIMATE.LIBRARY.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".ESTIMATE.LIBRARY.log",\
"'$SCRIPT_DIR'""A.13_ESTIMATE_LIBRARY.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".ANNOTATE.VCF.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".ANNOTATE.VCF.SINGLE.log",\
"'$SCRIPT_DIR'""B.01_ANNOTATE_VCF.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

# sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
# | awk ' \
# {split($2,smtag,"@"); print "qsub","-N","B.02_VQSR_SNP_PLOT."smtag[1]"_"smtag[2],\
# "-o","'$CORE_PATH'""/"$1"/LOGS/"$2".VQSR.SNP.PLOT.SINGLE.log",\
# "-e","'$CORE_PATH'""/"$1"/LOGS/"$2".VQSR.SNP.PLOT.SINGLE.log",\
# "'$SCRIPT_DIR'""B.02_VQSR_SNP_PLOT.sh",\
# $1,$2,$3,$4,$5,$6"\n""sleep 3s"}'
#
# sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
# | awk ' \
# {split($2,smtag,"@"); print "qsub","-N","B.03_VQSR_INDEL_PLOT."smtag[1]"_"smtag[2],\
# "-o","'$CORE_PATH'""/"$1"/LOGS/"$2".VQSR.INDEL.PLOT.SINGLE.log",\
# "-e","'$CORE_PATH'""/"$1"/LOGS/"$2".VQSR.INDEL.PLOT.SINGLE.log",\
# "'$SCRIPT_DIR'""B.03_VQSR_INDEL_PLOT.sh",\
# $1,$2,$3,$4,$5,$6"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.01_INDEX_VCF."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".INDEX.VCF.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".INDEX.VCF.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.01_INDEX_VCF.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.02_EXTRACT_VCF_CODING."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.02_EXTRACT_VCF_CODING.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.02_EXTRACT_VCF_CODING_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.VCF.CODING.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.VCF.CODING.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.02_EXTRACT_VCF_CODING.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.04_EXTRACT_VCF_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.VARAINT.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.VARAINT.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.04_EXTRACT_VCF_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.04_EXTRACT_VCF_CODING_PASS_VARIANT_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.VCF.CODING.PASS.VARAINT.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.VCF.CODING.PASS.VARIANT.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.04_EXTRACT_VCF_CODING_PASS_VARIANT.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.05_EXTRACT_SNV_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.05_EXTRACT_SNV_WHOLE_GENOME.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.05_EXTRACT_SNV_WHOLE_GENOME_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.WHOLE.GENOME.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.WHOLE.GENOME.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.05_EXTRACT_SNV_WHOLE_GENOME.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.06_EXTRACT_SNV_CODING."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.06_EXTRACT_SNV_CODING.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.06_EXTRACT_SNV_CODING_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.CODING.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.CODING.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.06_EXTRACT_SNV_CODING.sh $1 $2 $3 $4
#
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT.sh $1 $2 $3 $4
#

sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.07.A.01_TI_TV_WHOLE_GENOME_PASS."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.PASS.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.PASS.SINGLE.log",\
"-hold_jid B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.07.A.01_TI_TV_WHOLE_GENOME_PASS.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.07.A.01_TI_TV_WHOLE_GENOME_PASS_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.PASS.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.PASS.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.07.A.01_TI_TV_WHOLE_GENOME_PASS.sh $1 $2 $3 $4
# 
# sleep 3s
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.07.A.02_TI_TV_WHOLE_GENOME_KNOWN."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.KNOWN.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.KNOWN.SINGLE.log",\
"-hold_jid B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.07.A.02_TI_TV_WHOLE_GENOME_KNOWN.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.07.A.02_TI_TV_WHOLE_GENOME_KNOWN_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.KNOWN.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.KNOWN.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.07.A.02_TI_TV_WHOLE_GENOME_KNOWN.sh $1 $2 $3 $4
# 
# sleep 3s
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.07.A.03_TI_TV_WHOLE_GENOME_NOVEL."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.NOVEL.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.NOVEL.SINGLE.log",\
"-hold_jid B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.07.A.03_TI_TV_WHOLE_GENOME_NOVEL.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.07.A.03_TI_TV_WHOLE_GENOME_NOVEL_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.NOVEL.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.NOVEL.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.07.A.03_TI_TV_WHOLE_GENOME_NOVEL.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.VARAINT.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.VARAINT.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.CODING.PASS.VARAINT.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.SNV.CODING.PASS.VARIANT.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT.sh $1 $2 $3 $4
#
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.08.A.01_TI_TV_CODING_PASS."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.CODING.PASS.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.CODING.PASS.SINGLE.log",\
"-hold_jid B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.08.A.01_TI_TV_CODING_PASS.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.08.A.01_TI_TV_CODING_PASS_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.CODING.PASS.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.CODING.PASS.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.08.A.01_TI_TV_CODING_PASS.sh $1 $2 $3 $4
# 
# sleep 3s
#
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.08.A.02_TI_TV_CODING_KNOWN."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.CODING.KNOWN.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.CODING.KNOWN.SINGLE.log",\
"-hold_jid B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.08.A.02_TI_TV_CODING_KNOWN.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.08.A.02_TI_TV_CODING_KNOWN_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.CODING.KNOWN.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.CODING.KNOWN.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.08.A.02_TI_TV_CODING_KNOWN.sh $1 $2 $3 $4
# 
# sleep 3s
#
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.08.A.03_TI_TV_CODING_NOVEL."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.CODING.NOVEL.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".TITV.CODING.NOVEL.SINGLE.log",\
"-hold_jid B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.08.A.03_TI_TV_CODING_NOVEL.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.08.A.03_TI_TV_CODING_NOVEL_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.CODING.NOVEL.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.CODING.NOVEL.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.08.A.03_TI_TV_CODING_NOVEL.sh $1 $2 $3 $4 $5 $6
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.09_EXTRACT_INDEL_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.09_EXTRACT_INDEL_WHOLE_GENOME.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.09_EXTRACT_INDEL_WHOLE_GENOME_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.WHOLE.GENOME.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.WHOLE.GENOME.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.09_EXTRACT_INDEL_WHOLE_GENOME.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.10_EXTRACT_INDEL_CODING."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.10_EXTRACT_INDEL_CODING.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.10_EXTRACT_INDEL_CODING_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.CODING.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.CODING.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.10_EXTRACT_INDEL_CODING.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT.sh $1 $2 $3 $4
# 
sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN {FS=","} NR>1 {print $1,$8,$12,$18}' | sort | uniq \
| awk ' \
{split($2,smtag,"@"); print "qsub","-N","B.01.A.12_EXTRACT_INDEL_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.VARAINT.SINGLE.log",\
"-e","'$CORE_PATH'""/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.VARAINT.SINGLE.log",\
"-hold_jid B.01_ANNOTATE_VCF."smtag[1]"_"smtag[2], \
"'$SCRIPT_DIR'""B.01.A.12_EXTRACT_INDEL_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4"\n""sleep 3s"}'
# 
# qsub -N "B.01.A.12_EXTRACT_INDEL_CODING_PASS_VARIANT_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.CODING.PASS.VARAINT.SINGLE.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".EXTRACT.INDEL.CODING.PASS.VARIANT.SINGLE.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/B.01.A.12_EXTRACT_INDEL_CODING_PASS_VARIANT.sh $1 $2 $3 $4
