#!/bin/bash


SAMPLE_SHEET=$1
PROJECT=$2

SCRIPT_DIR='/isilon/sequencing/VITO/NEW_GIT_REPO/Whole_Genome_Post_Processing/SCRIPTS/DEVEL/'
JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
CORE_PATH="/isilon/sequencing/Seq_Proj"
BWA_DIR="/isilon/sequencing/Kurt/Programs/BWA/bwa-0.7.8/"
PICARD_DIR="/isilon/sequencing/Kurt/Programs/Picard/picard-tools-1.118"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.1-1"
VERIFY_DIR="/isilon/sequencing/Kurt/Programs/VerifyBamID/verifyBamID_20120620/bin/"
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
DBSNP_129_EXCLUDE_138="/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf"
CIDR_SEQSUITE_JAVA_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/java/jre1.7.0_45/bin"
CIDR_SEQSUITE_6_1_1_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/6.1.1"
VERACODE_CSV="/isilon/sequencing/CIDRSeqSuiteSoftware/resources/Veracode_hg18_hg19.csv"
GRCH37_WG_BED="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/5.0.0/aux_files/grch37.nogap.nochr.bed"

mkdir -p $CORE_PATH/$PROJECT/LOGS
mkdir -p $CORE_PATH/$PROJECT/BAM/{AGGREGATE,READGROUP}
mkdir -p $CORE_PATH/$PROJECT/HC_BAM
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
mkdir -p $CORE_PATH/$PROJECT/LUMPY/{RAW,BAM,UCSC_CODING}

CREATE_SAMPLE_INFO_ARRAY ()
{
SAMPLE_INFO_ARRAY=(`sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN{FS=","} NR>1 {print $1,$2,$3,$4}' | sed 's/,/\t/g' | sort -k 1,1 | awk '$2=="'$SAMPLE'" {print $1,$2,$3,$4}' | sort | uniq`)

PROJECT_NAME=${SAMPLE_INFO_ARRAY[0]}
SM_TAG=${SAMPLE_INFO_ARRAY[1]}
REF_GENOME=${SAMPLE_INFO_ARRAY[2]}
DBSNP_138=${SAMPLE_INFO_ARRAY[3]}
}

DOC_AUTO_CODING () {
echo \
 qsub \
 -N 'A.01_DOC_AUTO_CODING_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.01_DOC_AUTO_CODING_$SM_TAG.log \
 $SCRIPT_DIR/A.01_DOC_AUTO_CODING.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $KEY $CORE_PATH $CODING_BED \
 $PROJECT_NAME $SM_TAG
}

DOC_AUTO_WG () {
echo \
 qsub \
 -N 'A.02_DOC_AUTO_WG_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.01_DOC_AUTO_WG_$SM_TAG.log \
 $SCRIPT_DIR/A.01_DOC_AUTO_WG.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $KEY $CORE_PATH $GAP_BED \
 $PROJECT_NAME $SM_TAG
}

DOC_CODING () {
echo \
 qsub \
 -N 'A.03_DOC_CODING_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.03_DOC_CODING_$SM_TAG.log \
 $SCRIPT_DIR/A.03_DOC_CODING.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $KEY $CORE_PATH $CODING_BED $CODING_BED_MT \
 $GENE_LIST $PROJECT_NAME $SM_TAG
}

DOC_TRANSCRIPT () {
echo \
 qsub \
 -N 'A.04_DOC_TRANSCRIPT_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.04_DOC_TRANSCRIPT_$SM_TAG.log \
 $SCRIPT_DIR/A.04_DOC_TRANSCRIPT.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $KEY $CORE_PATH $TRANSCRIPT_BED $TRANSCRIPT_BED_MT \
 $GENE_LIST $PROJECT_NAME $SM_TAG
}

VERIFY_BAM_ID () {
echo \
 qsub \
 -N 'A.05_VERIFY_BAM_ID_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.05_VERIFY_BAM_ID_$SM_TAG.log \
 $SCRIPT_DIR/A.05_VERIFY_BAM_ID.sh \
 $JAVA_1_7 $GATK_DIR $VERIFY_DIR $REF_GENOME \
 $KEY $CORE_PATH $VERIFY_VCF \
 $PROJECT_NAME $SM_TAG
}

INSERT_SIZE () {
echo \
 qsub \
 -N 'A.06_INSERT_SIZE_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.06_INSERT_SIZE_$SM_TAG.log \
 $SCRIPT_DIR/A.06_INSERT_SIZE.sh \
 $JAVA_1_7 $PICARD_DIR $REF_GENOME \
 $CORE_PATH $PROJECT_NAME $SM_TAG
}

ALIGNMENT_SUMMARY_METRICS () {
echo \
 qsub \
 -N 'A.07_ALIGNMENT_SUMMARY_METRICS_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.07_ALIGNMENT_SUMMARY_METRICS_$SM_TAG.log \
 $SCRIPT_DIR/A.07_ALIGNMENT_SUMMARY_METRICS.sh \
 $JAVA_1_7 $PICARD_DIR $REF_GENOME \
 $CORE_PATH $PROJECT_NAME $SM_TAG
}

LUMPY () {
echo \
 qsub \
 -N 'A.07.A01_LUMPY_'$SM_TAG \
 -hold-jid 'A.07_ALIGNMENT_SUMMARY_METRICS_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.07.A01_LUMPY_$SM_TAG.log \
 $SCRIPT_DIR/A.07.A01_LUMPY.sh \
 $SAMTOOLS_DIR $LUMPY_DIR $CODING_BED $CODING_BED_MT\
 $CORE_PATH $PROJECT_NAME $SM_TAG
}

BASECALL_Q_SCORE_DISTRIBUTION () {
echo \
 qsub \
 -N 'A.08_BASECALL_Q_SCORE_DISTRIBUTION_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.08_BASECALL_Q_SCORE_DISTRIBUTION_$SM_TAG.log \
 $SCRIPT_DIR/A.08_BASECALL_Q_SCORE_DISTRIBUTION.sh \
 $JAVA_1_7 $PICARD_DIR $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
}

GC_BIAS () {
echo \
 qsub \
 -N 'A.09_GC_BIAS_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.09_GC_BIAS_$SM_TAG.log \
 $SCRIPT_DIR/A.09_GC_BIAS.sh \
 $JAVA_1_7 $PICARD_DIR $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
}

MEAN_QUALITY_BY_CYCLE () {
echo \
 qsub \
 -N 'A.10_MEAN_QUALITY_BY_CYCLE_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.10_MEAN_QUALITY_BY_CYCLE_$SM_TAG.log \
 $SCRIPT_DIR/A.10_MEAN_QUALITY_BY_CYCLE.sh \
 $JAVA_1_7 $PICARD_DIR $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
}

OXIDATION () {
echo \
 qsub \
 -N 'A.11_OXIDATION_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.11_OXIDATION_$SM_TAG.log \
 $SCRIPT_DIR/A.11_OXIDATION.sh \
 $JAVA_1_7 $PICARD_DIR $SAMTOOLS_DIR $REF_GENOME \
 $CORE_PATH $PROJECT $DBSNP_138 $SM_TAG
}

ESTIMATE_LIBRARY () {
echo \
 qsub \
 -N 'A.12_ESTIMATE_LIBRARY_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A.12_ESTIMATE_LIBRARY_$SM_TAG.log \
 $SCRIPT_DIR/A.12_ESTIMATE_LIBRARY.sh \
 $JAVA_1_7 $PICARD_DIR \
 $CORE_PATH $PROJECT $SM_TAG
}

ANNOTATE_VCF () {
echo \
 qsub \
 -N 'B.01_ANNOTATE_VCF_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01_ANNOTATE_VCF_$SM_TAG.log \
 $SCRIPT_DIR/B.01_ANNOTATE_VCF.sh \
 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
}

	INDEX_VCF () {
	echo \
 qsub \
 -N 'B.01.A.01_INDEX_VCF_'$SM_TAG \
 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.01_INDEX_VCF_$SM_TAG.log \
 $SCRIPT_DIR/B.01.A.01_INDEX_VCF.sh \
 $TABIX_DIR \
 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_VCF_CODING () {
	echo \
 qsub \
 -N 'B.01.A.02_EXTRACT_VCF_CODING_'$SM_TAG \
 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.02_EXTRACT_VCF_CODING_$SM_TAG.log \
 $SCRIPT_DIR/B.01.A.02_EXTRACT_VCF_CODING.sh \
 $JAVA_1_7 $GATK_DIR $TABIX_DIR $KEY $CODING_BED $CODING_BED_MT $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT () {
	echo \
 qsub \
 -N 'B.01.A.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT_'$SM_TAG \
 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT_$SM_TAG.log \
 $SCRIPT_DIR/B.01.A.03_EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT.sh \
 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_VCF_CODING_PASS_VARIANT () {
	echo \
 qsub \
 -N 'B.01.A.04_EXTRACT_VCF_CODING_PASS_VARIANT_'$SM_TAG \
 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.04_EXTRACT_VCF_CODING_PASS_VARIANT_$SM_TAG.log \
 $SCRIPT_DIR/B.01.A.04_EXTRACT_VCF_CODING_PASS_VARIANT.sh \
 $JAVA_1_7 $GATK_DIR $KEY $CODING_BED $CODING_BED_MT $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_SNV_WHOLE_GENOME () {
	echo \
 qsub \
 -N 'B.01.A.05_EXTRACT_SNV_WHOLE_GENOME_'$SM_TAG \
 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.05_EXTRACT_SNV_WHOLE_GENOME_$SM_TAG.log \
 $SCRIPT_DIR/B.01.A.05_EXTRACT_SNV_WHOLE_GENOME.sh \
 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
	}

		CONCORDANCE_WHOLE_GENOME () {
			echo \
 			qsub \
 			-N 'B.01.A.05.A.01_CONCORDANCE_WHOLE_GENOME_'$SM_TAG \
 			-hold-jid 'B.01.A.05_EXTRACT_SNV_WHOLE_GENOME_'$SM_TAG \
 			-j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.05.A.01_CONCORDANCE_WHOLE_GENOME_$SM_TAG.log \
 			$SCRIPT_DIR/B.01.A.05.A.01_CONCORDANCE_WHOLE_GENOME.sh \
 			$CIDR_SEQSUITE_JAVA_DIR $CIDR_SEQSUITE_6_1_1_DIR $VERACODE_CSV \
 			$CORE_PATH $PROJECT $SM_TAG $GRCH37_WG_BED
		}

	EXTRACT_SNV_CODING () {
	echo \
 qsub \
 -N 'B.01.A.06_EXTRACT_SNV_CODING_'$SM_TAG \
 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.06_EXTRACT_SNV_CODING_$SM_TAG.log \
 $SCRIPT_DIR/B.01.A.06_EXTRACT_SNV_CODING.sh \
 $JAVA_1_7 $GATK_DIR $KEY $CODING_BED $CODING_BED_MT $REF_GENOME \
 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT () {
	echo \
 	 qsub \
 	 -N 'B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT_'$SM_TAG \
 	 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 	 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT_$SM_TAG.log \
 	 $SCRIPT_DIR/B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT.sh \
 	 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME \
 	 $CORE_PATH $PROJECT $SM_TAG
	}

		TI_TV_WHOLE_GENOME_PASS () {
		echo \
		 qsub \
		 -N 'B.01.A.07.A.01_TI_TV_WHOLE_GENOME_PASS_'$SM_TAG \
		 -hold-jid 'B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.07.A.01_TI_TV_WHOLE_GENOME_PASS_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.07.A.01_TI_TV_WHOLE_GENOME_PASS.sh \
		 $SAMTOOLS_DIR \
		 $CORE_PATH $PROJECT $SM_TAG
		}

		TI_TV_WHOLE_GENOME_KNOWN (){
		echo \
		 qsub \
		 -N 'B.01.A.07.A.02_TI_TV_WHOLE_GENOME_KNOWN_'$SM_TAG \
		 -hold-jid 'B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.07.A.02_TI_TV_WHOLE_GENOME_KNOWN_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.07.A.02_TI_TV_WHOLE_GENOME_KNOWN.sh \
		 $JAVA_1_7 $GATK_DIR $SAMTOOLS_DIR $KEY $REF_GENOME $DBSNP_129_EXCLUDE_138\
		 $CORE_PATH $PROJECT $SM_TAG
		}

		TI_TV_WHOLE_GENOME_NOVEL (){
		echo \
		 qsub \
		 -N 'B.01.A.07.A.03_TI_TV_WHOLE_GENOME_NOVEL_'$SM_TAG \
		 -hold-jid 'B.01.A.07_EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.07.A.03_TI_TV_WHOLE_GENOME_NOVEL_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.07.A.03_TI_TV_WHOLE_GENOME_NOVEL.sh \
		 $JAVA_1_7 $GATK_DIR $SAMTOOLS_DIR $KEY $REF_GENOME $DBSNP_129_EXCLUDE_138\
		 $CORE_PATH $PROJECT $SM_TAG
		}
	EXTRACT_SNV_CODING_PASS_VARIANT () {
	echo \
 	 qsub \
 	 -N 'B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT_'$SM_TAG \
 	 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
 	 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT_$SM_TAG.log \
 	 $SCRIPT_DIR/B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT.sh \
 	 $JAVA_1_7 $GATK_DIR $KEY $CODING_BED $CODING_BED_MT $REF_GENOME \
 	 $CORE_PATH $PROJECT $SM_TAG
	}

		TI_TV_CODING_PASS () {
		echo \
		 qsub \
		 -N 'B.01.A.08.A.01_EXTRACT_SNV_CODING_PASS_VARIANT_'$SM_TAG \
		 -hold-jid 'B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.08.A.01_TI_TV_CODING_PASS_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.08.A.01_TI_TV_CODING_PASS.sh \
		 $SAMTOOLS_DIR \
		 $CORE_PATH $PROJECT $SM_TAG
		}

		TI_TV_CODING_KNOWN () {
		echo \
		 qsub \
		 -N 'B.01.A.08.A.02_TI_TV_CODING_KNOWN_'$SM_TAG \
		 -hold-jid 'B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.08.A.02_TI_TV_CODING_KNOWN_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.08.A.02_TI_TV_CODING_KNOWN.sh \
		 $JAVA_1_7 $GATK_DIR $SAMTOOLS_DIR $KEY $REF_GENOME $DBSNP_129_EXCLUDE_138 \
		 $CORE_PATH $PROJECT $SM_TAG
		}

		TI_TV_CODING_NOVEL (){
		echo \
		 qsub \
		 -N 'B.01.A.08.A.03_TI_TV_CODING_NOVEL_'$SM_TAG \
		 -hold-jid 'B.01.A.08_EXTRACT_SNV_CODING_PASS_VARIANT_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.08.A.03_TI_TV_WHOLE_GENOME_NOVEL_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.08.A.03_TI_TV_WHOLE_GENOME_NOVEL.sh \
		 $JAVA_1_7 $GATK_DIR $SAMTOOLS_DIR $KEY $REF_GENOME $DBSNP_129_EXCLUDE_138 \
		 $CORE_PATH $PROJECT $SM_TAG
		}

	EXTRACT_INDEL_WHOLE_GENOME () {
		echo \
		 qsub \
		 -N 'B.01.A.09_EXTRACT_INDEL_WHOLE_GENOME_'$SM_TAG \
		 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.09_EXTRACT_INDEL_WHOLE_GENOME_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.09_EXTRACT_INDEL_WHOLE_GENOME.sh \
		 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME \
		 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_INDEL_CODING () {
		echo \
		 qsub \
		 -N 'B.01.A.10_EXTRACT_INDEL_CODING_'$SM_TAG \
		 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.10_EXTRACT_INDEL_CODING_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.10_EXTRACT_INDEL_CODING.sh \
		 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME $CODING_BED $CODING_BED_MT \
		 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT () {
		echo \
		 qsub \
		 -N 'B.01.A.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT_'$SM_TAG \
		 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.11_EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT.sh \
		 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME \
		 $CORE_PATH $PROJECT $SM_TAG
	}

	EXTRACT_INDEL_CODING_PASS_VARIANT () {
		echo \
		 qsub \
		 -N 'B.01.A.12_EXTRACT_INDEL_CODING_PASS_VARIANT_'$SM_TAG \
		 -hold-jid 'B.01_ANNOTATE_VCF_'$SM_TAG \
		 -j y -o $CORE_PATH/$PROJECT/LOGS/B.01.A.12_EXTRACT_INDEL_CODING_PASS_VARIANT_$SM_TAG.log \
		 $SCRIPT_DIR/B.01.A.12_EXTRACT_INDEL_CODING_PASS_VARIANT.sh \
		 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME $CODING_BED $CODING_BED_MT \
		 $CORE_PATH $PROJECT $SM_TAG
	}

GENERATE_QC_REPORT_HOLD_ID(){
QC_REPORT_HOLD_ID=$QC_REPORT_HOLD_ID'"A.01*","B.02*",'
echo $QC_REPORT_HOLD_ID
}

QC_REPORT_GENERATION () {
	echo \
	 qsub \
	 -N 'C.03_GENERATE_QC_REPORT_'$PROJECT_NAME \
	 -hold-jid '"A.01*","A.B02*"' \
	 -j y -o $CORE_PATH/$PROJECT/LOGS/C.03_GENERATE_QC_REPORT_$PROJECT.log \
	 $SCRIPT_DIR/C.03_GENERATE_QC_REPORT.sh \
	 $CORE_PATH $PROJECT	
}

for SAMPLE in $(awk 'BEGIN{FS=","} NR>1 {print $2}' $SAMPLE_SHEET | sort | uniq)
do
	CREATE_SAMPLE_INFO_ARRAY
	DOC_AUTO_CODING
	DOC_AUTO_WG
	DOC_CODING
	DOC_TRANSCRIPT
	VERIFY_BAM_ID
	INSERT_SIZE
	ALIGNMENT_SUMMARY_METRICS
	LUMPY
	BASECALL_Q_SCORE_DISTRIBUTION
	GC_BIAS
	MEAN_QUALITY_BY_CYCLE
	OXIDATION
	ESTIMATE_LIBRARY
	ANNOTATE_VCF
		INDEX_VCF
		EXTRACT_VCF_CODING
		EXTRACT_VCF_WHOLE_GENOME_PASS_VARIANT
		EXTRACT_VCF_CODING_PASS_VARIANT
		EXTRACT_SNV_WHOLE_GENOME
		EXTRACT_SNV_CODING
		EXTRACT_SNV_WHOLE_GENOME_PASS_VARIANT
			TI_TV_WHOLE_GENOME_PASS
			TI_TV_WHOLE_GENOME_KNOWN
			TI_TV_WHOLE_GENOME_NOVEL
		EXTRACT_SNV_CODING_PASS_VARIANT
			TI_TV_CODING_PASS
			TI_TV_CODING_KNOWN
			TI_TV_CODING_NOVEL
		EXTRACT_INDEL_WHOLE_GENOME
		EXTRACT_INDEL_CODING
		EXTRACT_INDEL_WHOLE_GENOME_PASS_VARIANT
		EXTRACT_INDEL_CODING_PASS_VARIANT
	CONCORDANCE_WHOLE_GENOME


done

# GENERATE_QC_REPORT_HOLD_ID
QC_REPORT_GENERATION