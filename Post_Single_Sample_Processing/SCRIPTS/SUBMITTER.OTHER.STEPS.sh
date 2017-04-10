#!/bin/bash

SAMPLE_SHEET=$1
SCRIPT=$2

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 \
{split($2,smtag,"@"); print "qsub","-N","'$SCRIPT'""_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".""'$SCRIPT'"".log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".""'$SCRIPT'"".log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/""'$SCRIPT'",\
$1,$2,$3,$4,$5,$6"\n""sleep 3s"}'
