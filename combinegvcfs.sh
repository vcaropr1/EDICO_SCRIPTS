#! /bin/bash

JOINT_CALL_PREFIX=$1
shift
OUT_DIR=$1
shift
REF_HASH_DIR=$1
shift
REF_GENOME=$1
shift

# dragen -f -r /staging/human/reference/GRC37/human_g1k_v37_decoy_hash_table --enable-combinegvcfs true --vc-reference /staging/human/reference/GRC37/human_g1k_v37_decoy.fasta --output-directory /isilon/sequencing/VITO/DRAGEN_TEST/MACROGEN_DATA/ --intermediate-results-dir /staging/tmp --output-file-prefix MACROGEN_COMBINED_GVCFS $GVCF_LIST

START_COMBINE_GVCFS=`date '+%s'`

CMD='dragen -f -r '$REF_HASH_DIR' --enable-combinegvcfs true --vc-reference'
CMD=$CMD' '$REF_GENOME' --output-directory '$OUT_DIR
CMD=$CMD' --output-file-prefix '$JOINT_CALL_PREFIX'_COMBINED_GVCFS'
while [ $# -gt 0 ]
do
  CMD=$CMD' --variant '$1
  shift
done

$CMD

END_COMBINE_GVCFS=`date '+%s'`



echo 'COMBINED_GVCFS,'$START_COMBINE_GVCFS','$END_COMBINE_GVCFS >> $OUT_DIR/run_times.csv