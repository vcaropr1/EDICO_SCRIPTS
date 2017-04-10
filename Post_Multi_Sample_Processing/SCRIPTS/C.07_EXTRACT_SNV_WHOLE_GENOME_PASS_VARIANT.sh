#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

PROJECT=$1
SM_TAG=$2
REF_GENOME=$3
DBSNP=$4
MDNA_HASH_ADDRESS=$5

RIS_ID=${SM_TAG%@*}
BARCODE_2D=${SM_TAG#*@}

JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
CORE_PATH="/isilon/sequencing/Seq_Proj/"
BWA_DIR="/isilon/sequencing/Kurt/Programs/BWA/bwa-0.7.8/"
PICARD_DIR="/isilon/sequencing/Kurt/Programs/Picard/picard-tools-1.118"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.1-1"
VERIFY_DIR="/isilon/sequencing/Kurt/Programs/VerifyBamID/verifyBamID_20120620/bin/"
BED_DIR=$CORE_PATH"/BED_Files/"
GENE_LIST="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/RefSeqGene.GRCh37.Ready.txt"
VERIFY_VCF="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/Omni25_genotypes_1525_samples_v2.b37.PASS.ALL.sites.vcf"
CODING_BED="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/UCSC_hg19_CodingOnly_083013_MERGED_noContigs_noCHR.bed"
CODING_BED_MT="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/MT.coding.bed"
TRANSCRIPT_BED="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/Transcripts.UCSC.Merged.NoContigsAlts.bed"
TRANSCRIPT_BED_MT="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/MT.transcripts.bed"
GAP_BED="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/GRCh37.gaps.bed"
SAMTOOLS_DIR="/isilon/sequencing/Kurt/Programs/samtools/samtools-0.1.18/"
TABIX_DIR="/isilon/sequencing/Kurt/Programs/TABIX/tabix-0.2.6/"
LUMPY_DIR="/isilon/sequencing/Kurt/Programs/LUMPY/lumpy-sv-master"
KEY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_2/lee.watkins_jhmi.edu.key"

mkdir -p $CORE_PATH/$PROJECT/LOGS
mkdir -p $CORE_PATH/$PROJECT/BAM/
mkdir -p $CORE_PATH/$PROJECT/GVCF
mkdir -p $CORE_PATH/$PROJECT/REPORTS/{ALIGNMENT_SUMMARY,ANNOVAR,PICARD_DUPLICATES,QC_REPORTS,TI_TV,TI_TV_MS,VERIFY_BAM_ID,SAMPLE_SHEETS,OXIDATION,JUMPING,ESTIMATE_LIBRARY}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/TI_TV/{WHOLE_GENOME,CODING}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS/{WHOLE_GENOME,CODING}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/BASECALL_Q_SCORE_DISTRIBUTION/{METRICS,PDF}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/CONCORDANCE/{WHOLE_GENOME,CODING}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/CONCORDANCE_MS/{WHOLE_GENOME,CODING}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/COUNT_COVARIATES/{GATK_REPORT,PDF}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/GC_BIAS/{METRICS,PDF,SUMMARY}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/INSERT_SIZE/{METRICS,PDF}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/LOCAL_REALIGNMENT_INTERVALS
mkdir -p $CORE_PATH/$PROJECT/REPORTS/MEAN_QUALITY_BY_CYCLE/{METRICS,PDF}
mkdir -p $CORE_PATH/$PROJECT/REPORTS/DEPTH_OF_COVERAGE/{DEPTH_SUMMARY,CODING_COVERAGE,TRANSCRIPT_COVERAGE}
mkdir -p $CORE_PATH/$PROJECT/TEMP
mkdir -p $CORE_PATH/$PROJECT/FASTQ
mkdir -p $CORE_PATH/$PROJECT/BED_Files
mkdir -p $CORE_PATH/$PROJECT/VCF/SINGLE/WHOLE_GENOME/PASS
mkdir -p $CORE_PATH/$PROJECT/VCF/SINGLE/CODING/PASS
mkdir -p $CORE_PATH/$PROJECT/VCF/MULTI/WHOLE_GENOME/{PASS_ALL,PASS_VARIANT}
mkdir -p $CORE_PATH/$PROJECT/VCF/MULTI/CODING/{PASS_ALL,PASS_VARIANT}
mkdir -p $CORE_PATH/$PROJECT/SNV/SINGLE/WHOLE_GENOME/PASS
mkdir -p $CORE_PATH/$PROJECT/SNV/SINGLE/CODING/PASS
mkdir -p $CORE_PATH/$PROJECT/SNV/MULTI/WHOLE_GENOME/{PASS_ALL,PASS_VARIANT}
mkdir -p $CORE_PATH/$PROJECT/SNV/MULTI/CODING/{PASS_ALL,PASS_VARIANT}
mkdir -p $CORE_PATH/$PROJECT/INDEL/SINGLE/WHOLE_GENOME/PASS
mkdir -p $CORE_PATH/$PROJECT/INDEL/SINGLE/CODING/PASS
mkdir -p $CORE_PATH/$PROJECT/INDEL/MULTI/WHOLE_GENOME/{PASS_ALL,PASS_VARIANT}
mkdir -p $CORE_PATH/$PROJECT/INDEL/MULTI/CODING/{PASS_ALL,PASS_VARIANT}
mkdir -p $CORE_PATH/$PROJECT/LUMPY/{RAW,UCSC_CODING}

# Filter snv only, REMOVE NON-VARIANT, FAIL

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
-ef \
-env \
--keepOriginalAC \
-selectType SNP \
-et NO_ET \
-K $KEY \
--variant /isilon/sequencing/Seq_Proj/$PROJECT/$MDNA_HASH_ADDRESS/$PROJECT".REFINED.vcf" \
-o $CORE_PATH/$PROJECT/SNV/MULTI/WHOLE_GENOME/PASS_VARIANT/$SM_TAG".WHOLE.GENOME.SNV.PASS.VARIANT.vcf"

# qsub -N "C.07.A.01_TI_TV_WHOLE_GENOME_PASS_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.PASS.MS.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.PASS.MS.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/C.07.A.01_TI_TV_WHOLE_GENOME_PASS.sh $1 $2 $3 $4 $5
# 
# sleep 3s
# 
# qsub -N "C.07.A.02_TI_TV_WHOLE_GENOME_KNOWN_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.KNOWN.MS.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.KNOWN.MS.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/C.07.A.02_TI_TV_WHOLE_GENOME_KNOWN.sh $1 $2 $3 $4 $5
# 
# sleep 3s
# 
# qsub -N "C.07.A.03_TI_TV_WHOLE_GENOME_NOVEL_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.NOVEL.MS.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".TITV.WHOLE.GENOME.NOVEL.MS.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/C.07.A.03_TI_TV_WHOLE_GENOME_NOVEL.sh $1 $2 $3 $4 $5
# 
# sleep 3s
# 
# qsub -N "C.07.A.04_CONCORDANCE_WHOLE_GENOME_"$RIS_ID"_"$BARCODE_2D \
# -o $CORE_PATH/$PROJECT/LOGS/$SM_TAG".CONCORDANCE.WHOLE.GENOME.MS.log" \
# -e $CORE_PATH/$PROJECT/LOGS/$SM_TAG".CONCORDANCE.WHOLE.GENOME.MS.log" \
# $CORE_PATH/$PROJECT/SCRIPTS/C.07.A.04_CONCORDANCE_WHOLE_GENOME.sh $1 $2 $3 $4 $5
