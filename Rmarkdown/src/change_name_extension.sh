#!/bin/bash
#DianaOaxaca

FASTQ=$(ls data/*.fq | sed 's/_R.*.$//' | sed 's/data\///' | sort -u)
declare -a FASTQs=("$FASTQ")

for FILE in ${FASTQs[@]}; do
	mv data/$FILE'_R1_val_1.fq' data/$FILE'_R1_val_1.fastq'
	mv data/$FILE'_R2_val_2.fq'  data/$FILE'_R2_val_2.fastq'
done
