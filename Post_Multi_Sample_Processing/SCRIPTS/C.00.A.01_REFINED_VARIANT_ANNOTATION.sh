#$ -S /bin/bash
#$ -q rnd.q,test.q,prod.q
#$ -cwd
#$ -V
#$ -p -1000

set

PROJECT=$1
REF_GENOME=$2
DBSNP=$3
MDNA_HASH_ADDRESS=$4

JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
CORE_PATH="/isilon/sequencing/Seq_Proj/"
BWA_DIR="/isilon/sequencing/Kurt/Programs/BWA/bwa-0.7.8/"
PICARD_DIR="/isilon/sequencing/Kurt/Programs/Picard/picard-tools-1.118"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.1-1"
GATK_NIGHTLY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-nightly-2015-01-15-g92376d3"
GATK_3_3="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.3-0/"
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
REFERENCE="/isilon/sequencing/GATK_resource_bundle/bwa_mem_0.7.5a_ref/human_g1k_v37_decoy.fasta"
P3_1KG="/isilon/sequencing/1000genomes/Full_Project/Sep_2014/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.vcf.gz"
ExAC="/isilon/sequencing/ExAC/Release_0.3/ExAC.r0.3.sites.vep.vcf.gz"

$JAVA_1_7/java -jar \
$GATK_3_3/GenomeAnalysisTK.jar \
-T VariantAnnotator \
-R $REF_GENOME \
--variant $CORE_PATH/$PROJECT/$MDNA_HASH_ADDRESS/variants.all.refined.vcf \
-L 1 -L 2 -L 3 -L 4 -L 5 -L 6 -L 7 -L 8 -L 9 -L 10 \
-L 11 -L 12 -L 13 -L 14 -L 15 -L 16 -L 17 -L 18 -L 19 -L 20 -L 21 -L 22 \
-L X -L Y -L MT \
-A SampleList \
-A GCContent \
-A VariantType \
-A GenotypeSummaries \
-A AlleleBalance \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/$MDNA_HASH_ADDRESS/$PROJECT".REFINED.vcf"

# /isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin/java -jar \
# /isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.3-0/GenomeAnalysisTK.jar \
# -T VariantAnnotator \
# -R $REFERENCE \
# --variant /isilon/sequencing/Seq_Proj/$PROJECT/JOINT_CALL/$MDNA_HASH_ADDRESS/VQSR/variants.all.refined.vcf \
# -L /isilon/sequencing/Seq_Proj/$PROJECT/JOINT_CALL/$MDNA_HASH_ADDRESS/VQSR/variants.all.refined.vcf \
# -A SampleList \
# -A GCContent \
# -A VariantType \
# -A GenotypeSummaries \
# -A AlleleBalance \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o /isilon/sequencing/Seq_Proj/$PROJECT/JOINT_CALL/$MDNA_HASH_ADDRESS/VQSR/$PROJECT".REFINED.vcf"