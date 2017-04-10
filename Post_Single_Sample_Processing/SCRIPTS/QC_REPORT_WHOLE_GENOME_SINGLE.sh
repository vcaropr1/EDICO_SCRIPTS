#!/bin/bash

CORE_PATH=$1
PROJECT=$2

# GRABBING WHOLE GENOME CONCORDANCE.

# ls $CORE_PATH/$PROJECT/REPORTS/CONCORDANCE/WHOLE_GENOME/*_concordance.csv \
# | awk '{print "awk","1",$0}' \
# | bash \
# | sort -r \
# | uniq \
# | awk 'NR>1' \
# | sort \
# | sed 's/,/\t/g' \
# | awk 'BEGIN {print "SM_TAG","COUNT_DISC_HOM","COUNT_CONC_HOM","PERCENT_CONC_HOM",\
# "COUNT_DISC_HET","COUNT_CONC_HET","PERCENT_CONC_HET",\
# "PERCENT_TOTAL_CONC","COUNT_HET_BEADCHIP","SENSITIVITY_2_HET"} \
# {print $1,$5,$6,$7,$2,$3,$4,$8,$9,$10}' \
# | sed 's/ /\t/g' \
# >| $CORE_PATH/$PROJECT/TEMP/CONCORDANCE_WG.txt

# Removed

# # GRABBING CODING CONCORDANCE.
# 
# ls $CORE_PATH/$PROJECT/REPORTS/CONCORDANCE/CODING/*_concordance.csv \
# | awk '{print "awk","1",$0}' \
# | bash \
# | sort -r \
# | uniq \
# | awk 'NR>1' \
# | sort \
# | sed 's/,/\t/g' \
# | awk 'BEGIN {print "SM_TAG","CODING_COUNT_DISC_HOM","CODING_COUNT_CONC_HOM","CODING_PERCENT_CONC_HOM",\
# "CODING_COUNT_DISC_HET","CODING_COUNT_CONC_HET","CODING_PERCENT_CONC_HET",\
# "CODING_PERCENT_TOTAL_CONC","CODING_COUNT_HET_BEADCHIP","CODING_SENSITIVITY_2_HET"} \
# {print $1,$5,$6,$7,$2,$3,$4,$8,$9,$10}' \
# | sed 's/ /\t/g' \
# >| $CORE_PATH/$PROJECT/TEMP/CONCORDANCE_CODING.txt

# GRABBING VERIFY BAM ID

ls $CORE_PATH/$PROJECT/REPORTS/VERIFY_BAM_ID/*selfSM \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 END {print \x22"SMtag[9]"\x22,$6,$7,$8,$9}\x27",$0}' \
| bash \
| sed 's/.selfSM//g' \
| awk 'BEGIN {print "SM_TAG""\t""FREEMIX""\t""FREELK1""\t""FREELK0""\t""COUNT.VERIFY.SITES.AVG.DP"} \
{print $1"\t"$3"\t"$4"\t"$5"\t"$2}' \
>| $CORE_PATH/$PROJECT/TEMP/VERFIY_BAM_ID.TXT

# GRABBING DEPTH OF COVERAGE, AUTOSOMAL, WG

ls $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/*.autosomal.whole_genome.sample_summary.csv \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 BEGIN {FS=\x22,\x22} NR==2 {print $1,$3,$7,$8,$9,$10}\x27",$0}' \
| bash \
| sed 's/.autosomal.whole_genome.sample_statistics.csv//g' \
| awk 'BEGIN {print "SM_TAG""\t""WG_MEAN_CVG""\t""WG_PCT_5x""\t""WG_PCT_10x""\t""WG_PCT_15x""\t""WG_PCT_20x"} \
{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6}' \
>| $CORE_PATH/$PROJECT/TEMP/DOC_WG.TXT

# GRABBING DEPTH OF COVERAGE, AUTOSOMAL, CODING

ls $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/DEPTH_SUMMARY/*.autosomal.exon.sample_summary.csv \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 BEGIN {FS=\x22,\x22} NR==2 {print $1,$3,$7,$8,$9,$10}\x27",$0}' \
| bash \
| sed 's/.autosomal.exon.sample_statistics.csv//g' \
| awk 'BEGIN {print "SM_TAG""\t""CODING_MEAN_CVG""\t""CODING_PCT_5x""\t""CODING_PCT_10x""\t""CODING_PCT_15x""\t""CODING_PCT_20x"} \
{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6}' \
>| $CORE_PATH/$PROJECT/TEMP/DOC_CODING.TXT

# GRABBING TI/TV WHOLE GENOME, ALL

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV/WHOLE_GENOME/*_All_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_All_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""WG_ALL_TI_TV_COUNT""\t""WG_ALL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_ALL.REPORT.TXT

# GRABBING TI/TV WHOLE GENOME, KNOWN

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV/WHOLE_GENOME/*_Known_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Known_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""WG_KNOWN_TI_TV_COUNT""\t""WG_KNOWN_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_KNOWN.REPORT.TXT

# GRABBING TI/TV WHOLE GENOME, NOVEL

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV/WHOLE_GENOME/*_Novel_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Novel_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""WG_NOVEL_TI_TV_COUNT""\t""WG_NOVEL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_NOVEL.REPORT.TXT

# GRABBING TI/TV CODING, ALL

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV/CODING/*_All_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_All_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""CODING_ALL_TI_TV_COUNT""\t""CODING_ALL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_ALL.REPORT.TXT

# GRABBING TI/TV CODING, KNOWN

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV/CODING/*_Known_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Known_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""CODING_KNOWN_TI_TV_COUNT""\t""CODING_KNOWN_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_KNOWN.REPORT.TXT

# GRABBING TI/TV CODING, NOVEL

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV/CODING/*_Novel_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Novel_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""CODING_NOVEL_TI_TV_COUNT""\t""CODING_NOVEL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_NOVEL.REPORT.TXT

# GENERATE PCT IN DBSNP FOR SNVS WHOLE GENOME

ls $CORE_PATH/$PROJECT/SNV/SINGLE/WHOLE_GENOME/PASS/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/SNV/SINGLE/WHOLE_GENOME/PASS/"SMtag[11],\
"| awk \x27{t++NR} {s+=($3~\x22rs\x22)} END {print \x22"SMtag[11]"\x22,(s/t*100)}\x27"}' \
| bash \
| sed 's/.WHOLE.GENOME.SNV.PASS.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""PERCENT_SNV_WG_SNP138"} {print $1"\t"$2}' \
>| $CORE_PATH/$PROJECT/TEMP/WG_SNV_PCT_DBSNP.txt

# GENERATE PCT IN DBSNP FOR SNVS CODING

ls $CORE_PATH/$PROJECT/SNV/SINGLE/CODING/PASS/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/SNV/SINGLE/CODING/PASS/"SMtag[11],\
"| awk \x27{t++NR} {s+=($3~\x22rs\x22)} END {print \x22"SMtag[11]"\x22,(s/t*100)}\x27"}' \
| bash \
| sed 's/.CODING.SNV.PASS.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""PERCENT_SNV_CODING_SNP138"} {print $1"\t"$2}' \
>| $CORE_PATH/$PROJECT/TEMP/CODING_SNV_PCT_DBSNP.txt

# GENERATE PCT IN DBSNP FOR INDELS WHOLE GENOME

ls $CORE_PATH/$PROJECT/INDEL/SINGLE/WHOLE_GENOME/PASS/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/INDEL/SINGLE/WHOLE_GENOME/PASS/"SMtag[11],\
"| awk \x27{count++NR} \
{count_dbsnp+=($3~\x22rs\x22)} \
{big_i_nm+=(length($5)-length($4))>15&&$5!~\x22,\x22} \
{big_i_nm_dbsnp+=(length($5)-length($4))>15&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{big_d_nm+=(length($5)-length($4))<-15&&$5!~\x22,\x22} \
{big_d_nm_dbsnp+=(length($5)-length($4))<-15&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{small_i_nm+=((length($5)-length($4))<=15&&(length($5)-length($4))>0)&&$5!~\x22,\x22} \
{small_i_nm_dbsnp+=((length($5)-length($4))<=15&&(length($5)-length($4))>0)&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{small_d_nm+=((length($5)-length($4))>=-15&&(length($5)-length($4))<0)&&$5!~\x22,\x22} \
{small_d_nm_dbsnp+=((length($5)-length($4))>=-15&&(length($5)-length($4))<0)&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{bp_two_i_nm+=((length($5)-length($4))<=2&&(length($5)-length($4))>0)&&$5!~\x22,\x22} \
{bp_three_i_nm+=(length($5)-length($4))==3&&$5!~\x22,\x22} \
{bp_two_d_nm+=((length($5)-length($4))>=-2&&(length($5)-length($4))<0)&&$5!~\x22,\x22} \
{bp_three_d_nm+=(length($5)-length($4))==-3&&$5!~\x22,\x22} \
END \
{print \x22"SMtag[11]"\x22,count,(count_dbsnp/count*100),\
big_i_nm,(big_i_nm_dbsnp/big_i_nm*100),big_d_nm,(big_d_nm_dbsnp/big_d_nm*100),\
small_i_nm,(small_i_nm_dbsnp/small_i_nm*100),small_d_nm,(small_d_nm_dbsnp/small_d_nm*100),\
((big_i_nm+small_i_nm)/(big_d_nm+small_d_nm)),(big_i_nm/big_d_nm),(small_i_nm/small_d_nm),\
(bp_two_i_nm/bp_three_i_nm),(bp_two_d_nm/bp_three_d_nm)}\x27"}' \
| bash \
| sed 's/.WHOLE.GENOME.INDEL.PASS.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""COUNT_INDEL_WG""\t""PERCENT_INDEL_WG_SNP138""\t"\
"I_GT15_COUNT_WG""\t""I_GT15_PCT.DBSNP_WG""\t""D_GT15_COUNT_WG""\t""D_GT15_PCT.DBSNP_WG""\t"\
"I_LT15_COUNT_WG""\t""I_LT15_PCT.DBSNP_WG""\t""D_LT15_COUNT_WG""\t""D_LT15_PCT.DBSNP_WG""\t"\
"I_D_RATIO_WG""\t""I_D_RATIO_GT15_WG""\t""I_D_RATIO_LT15_WG""\t""I_1AND2_VS_3_WG""\t""D_1AND2_VS_3_WG"} \
{print $0}' \
>| $CORE_PATH/$PROJECT/TEMP/WG_INDEL_PCT_DBSNP.txt

# GENERATE PCT IN DBSNP FOR INDELS CODING

ls $CORE_PATH/$PROJECT/INDEL/SINGLE/CODING/PASS/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/INDEL/SINGLE/CODING/PASS/"SMtag[11],\
"| awk \x27{count++NR} \
{count_dbsnp+=($3~\x22rs\x22)} \
{big_i_nm+=(length($5)-length($4))>15&&$5!~\x22,\x22} \
{big_i_nm_dbsnp+=(length($5)-length($4))>15&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{big_d_nm+=(length($5)-length($4))<-15&&$5!~\x22,\x22} \
{big_d_nm_dbsnp+=(length($5)-length($4))<-15&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{small_i_nm+=((length($5)-length($4))<=15&&(length($5)-length($4))>0)&&$5!~\x22,\x22} \
{small_i_nm_dbsnp+=((length($5)-length($4))<=15&&(length($5)-length($4))>0)&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{small_d_nm+=((length($5)-length($4))>=-15&&(length($5)-length($4))<0)&&$5!~\x22,\x22} \
{small_d_nm_dbsnp+=((length($5)-length($4))>=-15&&(length($5)-length($4))<0)&&$5!~\x22,\x22&&$3~\x22rs\x22} \
{bp_two_i_nm+=((length($5)-length($4))<=2&&(length($5)-length($4))>0)&&$5!~\x22,\x22} \
{bp_three_i_nm+=(length($5)-length($4))==3&&$5!~\x22,\x22} \
{bp_two_d_nm+=((length($5)-length($4))>=-2&&(length($5)-length($4))<0)&&$5!~\x22,\x22} \
{bp_three_d_nm+=(length($5)-length($4))==-3&&$5!~\x22,\x22} \
END \
{print \x22"SMtag[11]"\x22,count,(count_dbsnp/count*100),\
big_i_nm,(big_i_nm_dbsnp/big_i_nm*100),big_d_nm,(big_d_nm_dbsnp/big_d_nm*100),\
small_i_nm,(small_i_nm_dbsnp/small_i_nm*100),small_d_nm,(small_d_nm_dbsnp/small_d_nm*100),\
((big_i_nm+small_i_nm)/(big_d_nm+small_d_nm)),(big_i_nm/big_d_nm),(small_i_nm/small_d_nm),\
(bp_two_i_nm/bp_three_i_nm),(bp_two_d_nm/bp_three_d_nm)}\x27"}' \
| bash \
| sed 's/.CODING.INDEL.PASS.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""COUNT_INDEL_CODING""\t""PERCENT_INDEL_CODING_SNP138""\t"\
"I_GT15_COUNT_CODING""\t""I_GT15_PCT.DBSNP_CODING""\t""D_GT15_COUNT_CODING""\t""D_GT15_PCT.DBSNP_CODING""\t"\
"I_LT15_COUNT_CODING""\t""I_LT15_PCT.DBSNP_CODING""\t""D_LT15_COUNT_CODING""\t""D_LT15_PCT.DBSNP_CODING""\t"\
"I_D_RATIO_CODING""\t""I_D_RATIO_GT15_CODING""\t""I_D_RATIO_LT15_CODING""\t""I_1AND2_VS_3_CODING""\t""D_1AND2_VS_3_CODING"} \
{print $0}' \
>| $CORE_PATH/$PROJECT/TEMP/CODING_INDEL_PCT_DBSNP.txt

# GRABBING INSERT SIZE METRICS

ls $CORE_PATH/$PROJECT/REPORTS/INSERT_SIZE/METRICS/*__insert_size_metrics.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==8 {print \x22"SMtag[10]"\x22,$1,$2,$5,$6}\x27",$0}' \
| bash \
| sed 's/__insert_size_metrics.txt//g' \
| awk 'BEGIN {print "SM_TAG","MEDIAN_INSERT_SIZE","MEDIAN_ABSOLUTE_DEVIATION_INSERT_SIZE","MEAN_INSERT_SIZE","STANDARD_DEVIATION"} \
{print $0}' \
| sed 's/ /\t/g' \
>| $CORE_PATH/$PROJECT/TEMP/INSERT_SIZE_METRICS.TXT

# GRABBING ALIGNMENT SUMMARY METRICS FOR READ 1

ls $CORE_PATH/$PROJECT/REPORTS/ALIGNMENT_SUMMARY/*_alignment_summary_metrics.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==8 {print \x22"SMtag[9]"\x22,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$18,$19,$20,$22}\x27",$0}' \
| bash \
| sed 's/_alignment_summary_metrics.txt//g' \
| awk 'BEGIN {print "SM_TAG","PF_NOISE_READS_R1","PF_READS_ALIGNED_R1","PCT_PF_READS_ALIGNED_R1","PF_ALIGNED_BASES_R1","PF_HQ_ALIGNED_READS_R1","PF_HQ_ALIGNED_BASES_R1",\
"PF_HQ_ALIGNED_Q20_BASES_R1","PF_HQ_MEDIAN_MISMATCHES_R1","PF_MISMATCH_RATE_R1","PF_HQ_ERROR_RATE_R1","PF_INDEL_RATE_R1","PCT_READS_ALIGNED_IN_PAIRS_R1","BAD_CYCLES_R1",\
"STRAND_BALANCE_R1","PCT_ADAPTER_R1"} \
{print $0}' \
| sed 's/ /\t/g' \
>| $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_1_METRICS.TXT

# GRABBING ALIGNMENT SUMMARY METRICS FOR READ 2

ls $CORE_PATH/$PROJECT/REPORTS/ALIGNMENT_SUMMARY/*_alignment_summary_metrics.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==9 {print \x22"SMtag[9]"\x22,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$18,$19,$20,$22}\x27",$0}' \
| bash \
| sed 's/_alignment_summary_metrics.txt//g' \
| awk 'BEGIN {print "SM_TAG","PF_NOISE_READS_R2","PF_READS_ALIGNED_R2","PCT_PF_READS_ALIGNED_R2","PF_ALIGNED_BASES_R2","PF_HQ_ALIGNED_READS_R2","PF_HQ_ALIGNED_BASES_R2",\
"PF_HQ_ALIGNED_Q20_BASES_R2","PF_HQ_MEDIAN_MISMATCHES_R2","PF_MISMATCH_RATE_R2","PF_HQ_ERROR_RATE_R2","PF_INDEL_RATE_R2","PCT_READS_ALIGNED_IN_PAIRS_R2","BAD_CYCLES_R2",\
"STRAND_BALANCE_R2","PCT_ADAPTER_R2"} \
{print $0}' \
| sed 's/ /\t/g' \
>| $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_2_METRICS.TXT

# GRABBING ALIGNMENT SUMMARY METRICS FOR PAIR

ls $CORE_PATH/$PROJECT/REPORTS/ALIGNMENT_SUMMARY/*_alignment_summary_metrics.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==10 {print \x22"SMtag[9]"\x22,$2,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22}\x27",$0}' \
| bash \
| sed 's/_alignment_summary_metrics.txt//g' \
| awk 'BEGIN {print "SM_TAG","TOTAL_READS","PF_NOISE_READS_PAIR","PF_READS_ALIGNED_PAIR","PCT_PF_READS_ALIGNED_PAIR","PF_ALIGNED_BASES_PAIR","PF_HQ_ALIGNED_READS_PAIR","PF_HQ_ALIGNED_BASES_PAIR",\
"PF_HQ_ALIGNED_Q20_BASES_PAIR","PF_HQ_MEDIAN_MISMATCHES_PAIR","PF_MISMATCH_RATE_PAIR","PF_HQ_ERROR_RATE_PAIR","PF_INDEL_RATE_PAIR","MEAN_READ_LENGTH","READS_ALIGNED_IN_PAIRS","PCT_READS_ALIGNED_IN_PAIRS_PAIR","BAD_CYCLES_PAIR",\
"STRAND_BALANCE_PAIR","PCT_CHIMERAS","PCT_ADAPTER_PAIR"} \
{print $0}' \
| sed 's/ /\t/g' \
>| $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_PAIR_METRICS.TXT

# Removed, no added value.

# # GRABBING WGS METRICS
# 
# ls $CORE_PATH/$PROJECT/REPORTS/WGS_METRICS/*_wgs_metrics.txt \
# | awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==8 {print \x22"SMtag[9]"\x22,$0}\x27",$0}' \
# | bash \
# | sed 's/_wgs_metrics.txt//g' \
# | awk 'BEGIN {print "SM_TAG","GENOME_TERRITORY","MEAN_COVERAGE","SD_COVERAGE","MEDIAN_COVERAGE","MAD_COVERAGE","PCT_EXC_MAPQ","PCT_EXC_DUPE",\
# "PCT_EXC_UNPAIRED","PCT_EXC_BASEQ","PCT_EXC_OVERLAP","PCT_EXC_CAPPED","PCT_EXC_TOTAL","PCT_5X","PCT_10X","PCT_20X","PCT_30X",\
# "PCT_40X","PCT_50X","PCT_60X","PCT_70X","PCT_80X","PCT_90X","PCT_100X"} \
# {print $0}' \
# | sed 's/ /\t/g' \
# >| $CORE_PATH/$PROJECT/TEMP/WG_METRICS.TXT
# 
# # GRABBING JUMPING PCR METRICS
# 
# ls $CORE_PATH/$PROJECT/REPORTS/JUMPING/*_JumpingLibraryMetrics.txt \
# | awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==8 {print \x22"SMtag[9]"\x22,$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17}\x27",$0}' \
# | bash \
# | sed 's/_JumpingLibraryMetrics.txt//g' \
# | awk 'BEGIN {print "SM_TAG","JUMP_PAIRS","JUMP_DUPLICATE_PAIRS","JUMP_DUPLICATE_PCT","JUMP_LIBRARY_SIZE","JUMP_MEAN_INSERT_SIZE","JUMP_STDEV_INSERT_SIZE","NONJUMP_PAIRS",\
# "NONJUMP_DUPLICATE_PAIRS","NONJUMP_DUPLICATE_PCT","NONJUMP_LIBRARY_SIZE","NONJUMP_MEAN_INSERT_SIZE","NONJUMP_STDEV_INSERT_SIZE","CHIMERIC_PAIRS","FRAGMENTS","PCT_JUMPS","PCT_NONJUMPS",\
# "PCT_CHIMERAS"} \
# {print $0}' \
# | sed 's/ /\t/g' \
# >| $CORE_PATH/$PROJECT/TEMP/JUMPING.TXT
# 
# Joining all of the files together to make a QC report

TIMESTAMP=`date '+%F.%H-%M-%S'`

# join -j 1 $CORE_PATH/$PROJECT/TEMP/CONCORDANCE_WG.txt $CORE_PATH/$PROJECT/TEMP/VERFIY_BAM_ID.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/DOC_WG.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/DOC_CODING.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_ALL.REPORT.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_KNOWN.REPORT.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_NOVEL.REPORT.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_ALL.REPORT.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_KNOWN.REPORT.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_NOVEL.REPORT.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/INSERT_SIZE_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_1_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_2_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_PAIR_METRICS.TXT \
# | sed 's/ /,/g' \
# >| $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS/$PROJECT".SINGLE_SAMPLE_QC."$TIMESTAMP".csv"

join -j 1 $CORE_PATH/$PROJECT/TEMP/VERFIY_BAM_ID.TXT $CORE_PATH/$PROJECT/TEMP/DOC_WG.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/DOC_CODING.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_ALL.REPORT.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_KNOWN.REPORT.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_NOVEL.REPORT.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_ALL.REPORT.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_KNOWN.REPORT.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_NOVEL.REPORT.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/WG_SNV_PCT_DBSNP.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/CODING_SNV_PCT_DBSNP.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/WG_INDEL_PCT_DBSNP.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/CODING_INDEL_PCT_DBSNP.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/INSERT_SIZE_METRICS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_1_METRICS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_2_METRICS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_PAIR_METRICS.TXT \
| sed 's/ /,/g' \
>| $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS/$PROJECT".SINGLE_SAMPLE_QC."$TIMESTAMP".csv"

# GENERATE OXIDATION REPORT

cat $CORE_PATH/$PROJECT/REPORTS/OXIDATION/*txt \
| egrep -v "^#|^$|^SAMPLE" \
| awk 'BEGIN {print "SM_TAG","LIBRARY","CONTEXT","TOTAL_SITES","TOTAL_BASES","REF_NONOXO_BASES","REF_OXO_BASES","REF_TOTAL_BASES","ALT_NONOXO_BASES","ALT_OXO_BASES",\
"OXIDATION_ERROR_RATE","OXIDATION_Q","C_REF_REF_BASES","G_REF_REF_BASES","C_REF_ALT_BASES","G_REF_ALT_BASES","C_REF_OXO_ERROR_RATE","C_REF_OXO_Q","G_REF_OXO_ERROR_RATE","G_REF_OXO_Q"} \
{print $0}' \
| sed -r 's/[[:space:]]+/,/g' \
>| $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS/$PROJECT".OXIDATION."$TIMESTAMP".csv"

echo QC REPORT 
echo $PROJECT".SINGLE_SAMPLE_QC."$TIMESTAMP".csv"
echo has been written to 
echo $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS
echo
echo $PROJECT".OXIDATION."$TIMESTAMP".csv"
echo has been written to
echo $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS/
