#! /bin/bash

PROJECT=$1
BINA_STYLE_SS=$2

CORE_PATH=/isilon/sequencing/Seq_Proj/
GRC37_HASH_TABLE=/staging/human/reference/GRC37/human_g1k_v37_decoy_hash_table/
REF_GENOME=/staging/human/reference/GRC37/human_g1k_v37_decoy.fasta
DBSNP_138=/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.vcf
VQSR_CONFIG_FILE=/opt/edico/config/dragen-VQSR.cfg
HAPMAP=/isilon/sequencing/GATK_resource_bundle/2.5/b37/hapmap_3.3.b37.vcf
OMNI_1KG=/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_omni2.5.b37.vcf
HI_CONF_1KG_PHASE1_SNP=/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_phase1.snps.high_confidence.b37.vcf
DBSNP_129=/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf
MILLS_1KG_GOLD_INDEL=/isilon/sequencing/GATK_resource_bundle/2.2/b37/Mills_and_1000G_gold_standard.indels.b37.vcf

mkdir -p $CORE_PATH/$PROJECT/DRAGEN_OUTPUT/
mkdir -p $CORE_PATH/$PROJECT/GVCF/
mkdir -p $CORE_PATH/$PROJECT/BAM/

# 	TO CREATE BAM AND VCF
for SAMPLE in $(awk 'BEGIN{FS=","} NR>1 {print $2}' $BINA_STYLE_SS); do dragen -f -r $GRC37_HASH_TABLE -b $CORE_PATH/$PROJECT/BAM/$SAMPLE".bam" --enable-variant-caller true --vc-sample-name $SAMPLE --vc-reference $REF_GENOME --output-directory $CORE_PATH/$PROJECT/DRAGEN_OUTPUT/ --intermediate-results-dir /staging/tmp --generate-md-tags true --enable-duplicate-marking false --vc-max-alternate-alleles 3 --enable-map-align-output true --enable-bam-indexing true --output-file-prefix $SAMPLE --dbsnp $DBSNP_138 --enable-vqsr true --vqsr-config-file $VQSR_CONFIG_FILE --vqsr-resource SNP,15.0,$HAPMAP --vqsr-resource SNP,12.0,$OMNI_1KG --vqsr-resource SNP,10.0,$HI_CONF_1KG_PHASE1_SNP --vqsr-resource SNP,2.0,$DBSNP_129 --vqsr-resource INDEL,12.0,$MILLS_1KG_GOLD_INDEL --vqsr-tranche 100.0 --vqsr-tranche 99.9 --vqsr-tranche 99.8 --vqsr-tranche 99.7 --vqsr-tranche 99.6 --vqsr-tranche 99.5 --vqsr-tranche 99.4 --vqsr-tranche 99.4 --vqsr-tranche 99.3 --vqsr-tranche 99.2 --vqsr-tranche 99.2 --vqsr-tranche 99.1 --vqsr-tranche 99.1 --vqsr-tranche 99.0 --vqsr-tranche 98.0 --vqsr-tranche 97.0 --vqsr-tranche 96.0 --vqsr-tranche 95.0 --vqsr-tranche 90.0 --vqsr-filter-level SNP,99.0 --vqsr-filter-level INDEL,95.0 --vqsr-lod-cutoff -5.0
# 	TO CREATE GVCF
 dragen -f -r $GRC37_HASH_TABLE -b $CORE_PATH/$PROJECT/BAM/$SAMPLE".bam" --enable-variant-caller true --vc-sample-name $SAMPLE --vc-reference $REF_GENOME --output-directory $CORE_PATH/$PROJECT/DRAGEN_OUTPUT/ --intermediate-results-dir /staging/tmp --generate-md-tags true --enable-duplicate-marking false --vc-max-alternate-alleles 3 --output-file-prefix $SAMPLE --dbsnp $DBSNP_138 --enable-vqsr true --vqsr-config-file $VQSR_CONFIG_FILE --vqsr-resource SNP,15.0,$HAPMAP --vqsr-resource SNP,12.0,$OMNI_1KG --vqsr-resource SNP,10.0,$HI_CONF_1KG_PHASE1_SNP --vqsr-resource SNP,2.0,$DBSNP_129 --vqsr-resource INDEL,12.0,$MILLS_1KG_GOLD_INDEL --vqsr-tranche 100.0 --vqsr-tranche 99.9 --vqsr-tranche 99.8 --vqsr-tranche 99.7 --vqsr-tranche 99.6 --vqsr-tranche 99.5 --vqsr-tranche 99.4 --vqsr-tranche 99.4 --vqsr-tranche 99.3 --vqsr-tranche 99.2 --vqsr-tranche 99.2 --vqsr-tranche 99.1 --vqsr-tranche 99.1 --vqsr-tranche 99.0 --vqsr-tranche 98.0 --vqsr-tranche 97.0 --vqsr-tranche 96.0 --vqsr-tranche 95.0 --vqsr-tranche 90.0 --vqsr-filter-level SNP,99.0 --vqsr-filter-level INDEL,95.0 --vqsr-lod-cutoff -5.0 --vc-emit-ref-confidence GVCF

 mv $CORE_PATH/$PROJECT/DRAGEN_OUTPUT/$SAMPLE".gvcf" $CORE_PATH/$PROJECT/GVCF/
 mv $CORE_PATH/$PROJECT/DRAGEN_OUTPUT/$SAMPLE".bam"* $CORE_PATH/$PROJECT/BAM/
done

