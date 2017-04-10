#!/bin/bash

CORE_PATH="/isilon/sequencing/Seq_Proj/"

PROJECT=$1

# GRABBING WHOLE GENOME CONCORDANCE.
# COMMENTED OUT DUE TO CAN'T GENERATE IN A REASONABLE TIMELY MANNER

# ls $CORE_PATH/$PROJECT/REPORTS/CONCORDANCE_MS/WHOLE_GENOME/*_concordance.csv \
# | awk '{print "awk","1",$0}' \
# | bash \
# | sort -r \
# | uniq \
# | awk 'NR>1' \
# | sort \
# | sed 's/,/\t/g' \
# | awk 'BEGIN {print "SM_TAG","COUNT_DISC_HOM","COUNT_CONC_HOM","PERCENT_CONC_HOM",\
# "COUNT_DISC_HET","COUNT_CONC_HET","PERCENT_CONC_HET",\
# "PERCENT_TOTAL_CONC","COUNT_HET_BEADCHIP","SENSITIVITY_2_HET","ARRAY_CONTENT"} \
# {print $1,$5,$6,$7,$2,$3,$4,$8,$9,$10,$11}' \
# | sed 's/ /\t/g' \
# >| $CORE_PATH/$PROJECT/TEMP/CONCORDANCE_WG_MS.txt

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

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS/WHOLE_GENOME/*_All_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_All_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""WG_ALL_TI_TV_COUNT""\t""WG_ALL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_ALL.REPORT.MS.TXT

# GRABBING TI/TV WHOLE GENOME, KNOWN

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS/WHOLE_GENOME/*_Known_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Known_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""WG_KNOWN_TI_TV_COUNT""\t""WG_KNOWN_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_KNOWN.REPORT.MS.TXT

# GRABBING TI/TV WHOLE GENOME, NOVEL

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS/WHOLE_GENOME/*_Novel_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Novel_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""WG_NOVEL_TI_TV_COUNT""\t""WG_NOVEL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_NOVEL.REPORT.MS.TXT

# GRABBING TI/TV CODING, ALL

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS/CODING/*_All_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_All_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""CODING_ALL_TI_TV_COUNT""\t""CODING_ALL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_ALL.REPORT.MS.TXT

# GRABBING TI/TV CODING, KNOWN

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS/CODING/*_Known_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Known_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""CODING_KNOWN_TI_TV_COUNT""\t""CODING_KNOWN_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_KNOWN.REPORT.MS.TXT

# GRABBING TI/TV CODING, NOVEL

ls $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS/CODING/*_Novel_titv.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/");print "awk \x27 END {print \x22"SMtag[10]"\x22,$2,$6}\x27",$0}' \
| bash \
| sed 's/_Novel_titv.txt//g' \
| awk 'BEGIN {print "SM_TAG""\t""CODING_NOVEL_TI_TV_COUNT""\t""CODING_NOVEL_TI_TV_RATIO"} {print $1"\t"$2"\t"$3}' \
>| $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_NOVEL.REPORT.MS.TXT

# GENERATE PCT IN DBSNP FOR SNVS WHOLE GENOME

ls $CORE_PATH/$PROJECT/SNV/MULTI/WHOLE_GENOME/PASS_VARIANT/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/SNV/MULTI/WHOLE_GENOME/PASS_VARIANT/"SMtag[11],\
"| awk \x27{t++NR} {s+=($3~\x22rs\x22)} END {print \x22"SMtag[11]"\x22,(s/t*100)}\x27"}' \
| bash \
| sed 's/.WHOLE.GENOME.SNV.PASS.VARIANT.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""PERCENT_SNV_WG_SNP138"} {print $1"\t"$2}' \
>| $CORE_PATH/$PROJECT/TEMP/WG_SNV_PCT_DBSNP.MS.txt

# GENERATE PCT IN DBSNP FOR SNVS CODING

ls $CORE_PATH/$PROJECT/SNV/MULTI/CODING/PASS_VARIANT/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/SNV/MULTI/CODING/PASS_VARIANT/"SMtag[11],\
"| awk \x27{t++NR} {s+=($3~\x22rs\x22)} END {print \x22"SMtag[11]"\x22,(s/t*100)}\x27"}' \
| bash \
| sed 's/.CODING.SNV.PASS.VARIANT.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""PERCENT_SNV_CODING_SNP138"} {print $1"\t"$2}' \
>| $CORE_PATH/$PROJECT/TEMP/CODING_SNV_PCT_DBSNP.MS.txt

# GENERATE PCT IN DBSNP FOR INDELS WHOLE GENOME

ls $CORE_PATH/$PROJECT/INDEL/MULTI/WHOLE_GENOME/PASS_VARIANT/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/INDEL/MULTI/WHOLE_GENOME/PASS_VARIANT/"SMtag[11],\
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
| sed 's/.WHOLE.GENOME.INDEL.PASS.VARIANT.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""COUNT_INDEL_WG""\t""PERCENT_INDEL_WG_SNP138""\t"\
"I_GT15_COUNT_WG""\t""I_GT15_PCT.DBSNP_WG""\t""D_GT15_COUNT_WG""\t""D_GT15_PCT.DBSNP_WG""\t"\
"I_LT15_COUNT_WG""\t""I_LT15_PCT.DBSNP_WG""\t""D_LT15_COUNT_WG""\t""D_LT15_PCT.DBSNP_WG""\t"\
"I_D_RATIO_WG""\t""I_D_RATIO_GT15_WG""\t""I_D_RATIO_LT15_WG""\t""I_1AND2_VS_3_WG""\t""D_1AND2_VS_3_WG"} \
{print $0}' \
>| $CORE_PATH/$PROJECT/TEMP/WG_INDEL_PCT_DBSNP.MS.txt

# GENERATE PCT IN DBSNP FOR INDELS CODING

ls $CORE_PATH/$PROJECT/INDEL/MULTI/CODING/PASS_VARIANT/*.vcf \
| awk '{split($1,SMtag,"/");print "grep -v \x22^#\x22","'$CORE_PATH'""/""'$PROJECT'""/INDEL/MULTI/CODING/PASS_VARIANT/"SMtag[11],\
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
| sed 's/.CODING.INDEL.PASS.VARIANT.vcf//g' \
| sed 's/ /\t/g' \
| awk 'BEGIN {print "SM_TAG""\t""COUNT_INDEL_CODING""\t""PERCENT_INDEL_CODING_SNP138""\t"\
"I_GT15_COUNT_CODING""\t""I_GT15_PCT.DBSNP_CODING""\t""D_GT15_COUNT_CODING""\t""D_GT15_PCT.DBSNP_CODING""\t"\
"I_LT15_COUNT_CODING""\t""I_LT15_PCT.DBSNP_CODING""\t""D_LT15_COUNT_CODING""\t""D_LT15_PCT.DBSNP_CODING""\t"\
"I_D_RATIO_CODING""\t""I_D_RATIO_GT15_CODING""\t""I_D_RATIO_LT15_CODING""\t""I_1AND2_VS_3_CODING""\t""D_1AND2_VS_3_CODING"} \
{print $0}' \
>| $CORE_PATH/$PROJECT/TEMP/CODING_INDEL_PCT_DBSNP.MS.txt

# GRABBING INSERT SIZE METRICS

ls $CORE_PATH/$PROJECT/REPORTS/INSERT_SIZE/METRICS/*_insert_size_metrics.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==8 {print \x22"SMtag[10]"\x22,$1,$2,$5,$6}\x27",$0}' \
| bash \
| sed 's/_insert_size_metrics.txt//g' \
| awk 'sub(/[_]+$/, "", $1) {print $0}' \
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

# GRABBING AT/GC DROPOUT METRICS

ls $CORE_PATH/$PROJECT/REPORTS/GC_BIAS/SUMMARY/*_gc_bias_summary.txt \
| awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==8 {print \x22"SMtag[10]"\x22,$4,$5}\x27",$0}' \
| bash \
| sed 's/_gc_bias_summary.txt//g' \
| awk 'BEGIN {print "SM_TAG","AT_DROPOUT","GC_DROPOUT"} \
{print $0}' \
| sed 's/ /\t/g' \
>| $CORE_PATH/$PROJECT/TEMP/GC_BIAS_METRICS.TXT

# GRABBING ESTIMATE LIBRARY/DUPLICATION METRICS
# 
# ls $CORE_PATH/$PROJECT/REPORTS/ESTIMATE_LIBRARY/*_duplication.txt \
# | awk 'BEGIN {OFS="\t"} {split($1,SMtag,"/"); print "awk \x27 NR==8 {print \x22"SMtag[9]"\x22,$2,$3,$4,$5,$6,$7,$8,$9}\x27",$0}' \
# | bash \
# | sed 's/_duplication.txt//g' \
# | awk 'BEGIN {print "SM_TAG","UNPAIRED_READS_EXAMINED","READ_PAIRS_EXAMINED","UNMAPPED_READS","UNPAIRED_READ_DUPLICATES","READ_PAIR_DUPLICATES","READ_PAIR_OPTICAL_DUPLICATES","PERCENT_DUPLICATION","ESTIMATED_LIBRARY_SIZE"} \
# {print $0}' \
# | sed 's/ /\t/g' \
# >| $CORE_PATH/$PROJECT/TEMP/DUPLICATES.TXT

# Joining all of the files together to make a QC report

TIMESTAMP=`date '+%F.%H-%M-%S'`

join -j 1 $CORE_PATH/$PROJECT/TEMP/VERFIY_BAM_ID.TXT $CORE_PATH/$PROJECT/TEMP/DOC_WG.TXT\
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/DOC_CODING.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_ALL.REPORT.MS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_KNOWN.REPORT.MS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_NOVEL.REPORT.MS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_ALL.REPORT.MS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_KNOWN.REPORT.MS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_NOVEL.REPORT.MS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/WG_SNV_PCT_DBSNP.MS.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/CODING_SNV_PCT_DBSNP.MS.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/WG_INDEL_PCT_DBSNP.MS.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/CODING_INDEL_PCT_DBSNP.MS.txt \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/INSERT_SIZE_METRICS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_1_METRICS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_2_METRICS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_PAIR_METRICS.TXT \
| join -j 1 - $CORE_PATH/$PROJECT/TEMP/GC_BIAS_METRICS.TXT \
| sed 's/ /,/g' \
>| $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS/$PROJECT".MULTI_SAMPLE_QC."$TIMESTAMP".csv"

# join -j 1 $CORE_PATH/$PROJECT/TEMP/CONCORDANCE_WG_MS.txt $CORE_PATH/$PROJECT/TEMP/VERFIY_BAM_ID.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/DOC_WG.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/DOC_CODING.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_ALL.REPORT.MS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_KNOWN.REPORT.MS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_WG_NOVEL.REPORT.MS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_ALL.REPORT.MS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_KNOWN.REPORT.MS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/TI_TV_CODING_NOVEL.REPORT.MS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/WG_SNV_PCT_DBSNP.MS.txt \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/CODING_SNV_PCT_DBSNP.MS.txt \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/WG_INDEL_PCT_DBSNP.MS.txt \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/CODING_INDEL_PCT_DBSNP.MS.txt \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/INSERT_SIZE_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_1_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_2_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/ALIGNMENT_SUMMARY_READ_PAIR_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/GC_BIAS_METRICS.TXT \
# | join -j 1 - $CORE_PATH/$PROJECT/TEMP/DUPLICATES.TXT \
# | sed 's/ /,/g' \
# >| $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS/$PROJECT".MULTI_SAMPLE_QC."$TIMESTAMP".csv"

echo QC REPORT 
echo $PROJECT".MULTI_SAMPLE_QC."$TIMESTAMP".csv"
echo has been written to 
echo $CORE_PATH/$PROJECT/REPORTS/QC_REPORTS
