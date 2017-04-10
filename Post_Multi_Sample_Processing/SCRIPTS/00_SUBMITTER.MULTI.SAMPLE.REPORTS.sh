#!/bin/bash

PROJECT=$1 # Just the project name.
MDNA_HASH_ADDRESS=$2 # should be "DRAGEN_OUTPUT"  I didn't change the variable name to match appropriately.  
SAMPLE_SHEET=$3

TIMESTAMP=`date '+%F.%H-%M-%S'`
SCRIPT_DIR="/isilon/sequencing/VITO/NEW_GIT_REPO/EDICO_SCRIPTS/Post_Multi_Sample_Processing/SCRIPTS/"
# set


# REFINE GENOTYPES FOR SNPS USING ALLELE FREQS FROM 1KG AND ExAC

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.00_GENOTYPE_REFINEMENT."$1,\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".GENOTYPE_REFINEMENT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".GENOTYPE_REFINEMENT.MS.log",\
"'$SCRIPT_DIR'""/C.00_GENOTYPE_REFINEMENT.sh",\
$1,$2,$3,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

# # ADD/UPDATE INFO ANNOTATIONS

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".REFINED_VARIANT_ANNOTATION.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".REFINED_VARIANT_ANNOTATION.MS.log",\
"-hold_jid C.00_GENOTYPE_REFINEMENT."$1,\
"'$SCRIPT_DIR'""/C.00.A.01_REFINED_VARIANT_ANNOTATION.sh",\
$1,$2,$3,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 


sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.01_EXTRACT_VCF_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.01_EXTRACT_VCF_WHOLE_GENOME.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.02_EXTRACT_VCF_CODING."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.02_EXTRACT_VCF_CODING.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.04_EXTRACT_VCF_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.VARIANT.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.04_EXTRACT_VCF_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.05_EXTRACT_SNV_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.05_EXTRACT_SNV_WHOLE_GENOME.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.06_EXTRACT_SNV_CODING."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.06_EXTRACT_SNV_CODING.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.07.A.01_TI_TV_WHOLE_GENOME_PASS_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.PASS.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.PASS.MS.log",\
"-hold_jid C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"'$SCRIPT_DIR'""/C.07.A.01_TI_TV_WHOLE_GENOME_PASS.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.07.A.02_TI_TV_WHOLE_GENOME_KNOWN_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.KNOWN.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.KNOWN.MS.log",\
"-hold_jid C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"'$SCRIPT_DIR'""/C.07.A.02_TI_TV_WHOLE_GENOME_KNOWN.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.07.A.03_TI_TV_WHOLE_GENOME_NOVEL_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.NOVEL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.WHOLE.GENOME.NOVEL.MS.log",\
"-hold_jid C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"'$SCRIPT_DIR'""/C.07.A.03_TI_TV_WHOLE_GENOME_NOVEL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

# Commented out concordance.  This step takes an absurd amount of time to run on WG data.  Not worth it per last conversation.

# sed 's/\r//g' $SAMPLE_SHEET \
# | awk 'NR>1' \
# | cut -d "," -f 1,8,12,18 \
# | sort \
# | uniq \
# | awk 'BEGIN {FS=","} \
# {split($2,smtag,"@"); print "qsub","-N","C.07.A.04_CONCORDANCE_WHOLE_GENOME_"smtag[1]"_"smtag[2],\
# "-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".CONCORDANCE.WHOLE.GENOME.MS.log",\
# "-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".CONCORDANCE.WHOLE.GENOME.MS.log",\
# "-hold_jid C.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
# "'$SCRIPT_DIR'""/C.07.A.04_CONCORDANCE_WHOLE_GENOME.sh",\
# $1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.VARIANT.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.08_EXTRACT_SNV_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.08.A.01_TI_TV_CODING_PASS_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.CODING.PASS.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.CODING.PASS.MS.log",\
"-hold_jid C.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"'$SCRIPT_DIR'""/C.08.A.01_TI_TV_CODING_PASS.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.08.A.02_TI_TV_CODING_KNOWN_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.CODING.KNOWN.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.CODING.KNOWN.MS.log",\
"-hold_jid C.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"'$SCRIPT_DIR'""/C.08.A.02_TI_TV_CODING_KNOWN.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.08.A.03_TI_TV_CODING_NOVEL_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.CODING.NOVEL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".TITV.CODING.NOVEL.MS.log",\
"-hold_jid C.08_EXTRACT_SNV_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"'$SCRIPT_DIR'""/C.08.A.03_TI_TV_CODING_NOVEL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.09_EXTRACT_INDEL_WHOLE_GENOME."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.09_EXTRACT_INDEL_WHOLE_GENOME.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.10_EXTRACT_INDEL_CODING."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.10_EXTRACT_INDEL_CODING.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.VARIANT.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.12_EXTRACT_INDEL_CODING_PASS_VARIANT."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.VARIANT.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.VARIANT.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.12_EXTRACT_INDEL_CODING_PASS_VARIANT.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

# Commented out because dragen doesn't have fun vqsr plot stuff

# sed 's/\r//g' $SAMPLE_SHEET \
# | awk 'NR>1' \
# | cut -d "," -f 1,8,12,18 \
# | sort \
# | uniq \
# | awk 'BEGIN {FS=","} N==2 \
# {split($2,smtag,"@"); print "qsub","-N","C.13_VQSR_SNP_PLOT."smtag[1]"_"smtag[2],\
# "-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.SNP.PLOT.MS.log",\
# "-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.SNP.PLOT.MS.log",\
# "'$SCRIPT_DIR'""/C.13_VQSR_SNP_PLOT_MS.sh",\
# $1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 
# 
# sed 's/\r//g' $SAMPLE_SHEET \
# | awk 'NR>1' \
# | cut -d "," -f 1,8,12,18 \
# | sort \
# | uniq \
# | awk 'BEGIN {FS=","} NR==2 \
# {split($2,smtag,"@"); print "qsub","-N","C.14_VQSR_INDEL_PLOT."smtag[1]"_"smtag[2],\
# "-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.INDEL.PLOT.MS.log",\
# "-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VQSR.INDEL.PLOT.MS.log",\
# "'$SCRIPT_DIR'""/C.14_VQSR_INDEL_PLOT_MS.sh",\
# $1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.15_EXTRACT_VCF_WHOLE_GENOME_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.WHOLE.GENOME.PASS.ALL.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.15_EXTRACT_VCF_WHOLE_GENOME_PASS_ALL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.16_EXTRACT_VCF_CODING_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.VCF.CODING.PASS.ALL.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.16_EXTRACT_VCF_CODING_PASS_ALL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.17_EXTRACT_INDEL_WHOLE_GENOME_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.WHOLE.GENOME.PASS.ALL.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.17_EXTRACT_INDEL_WHOLE_GENOME_PASS_ALL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.18_EXTRACT_INDEL_CODING_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.INDEL.CODING.PASS.ALL.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.18_EXTRACT_INDEL_CODING_PASS_ALL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.19_EXTRACT_SNV_WHOLE_GENOME_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.WHOLE.GENOME.PASS.ALL.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.19_EXTRACT_SNV_WHOLE_GENOME_PASS_ALL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,8,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.20_EXTRACT_SNV_CODING_PASS_ALL."smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.ALL.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".EXTRACT.SNV.CODING.PASS.ALL.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.20_EXTRACT_SNV_CODING_PASS_ALL.sh",\
$1,$2,$3,$4,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 


sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.21_BGZIP_REFINED_VCF."$1,\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".BGZIP_REFINED_VCF.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".BGZIP_REFINED_VCF.MS.log",\
"-hold_jid C.00.A.01_REFINED_VARIANT_ANNOTATION."$1,\
"'$SCRIPT_DIR'""/C.21_BGZIP_REFINED_VCF.sh",\
$1,$2,$3,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'NR>1' \
| cut -d "," -f 1,12,18 \
| sort \
| uniq \
| awk 'BEGIN {FS=","} \
{split($2,smtag,"@"); print "qsub","-N","C.21.A.01_TABIX_REFINED_VCF."$1,\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".TABIX_REFINED_VCF.MS.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$1".TABIX_REFINED_VCF.MS.log",\
"-hold_jid C.21_BGZIP_REFINED_VCF."$1,\
"'$SCRIPT_DIR'""/C.21.A.01_TABIX_REFINED_VCF.sh",\
$1,$2,$3,"'$MDNA_HASH_ADDRESS'""\n""sleep 3s"}' 
