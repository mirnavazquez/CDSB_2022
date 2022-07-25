#!/bin/bash
#DianaOaxaca 

export LC_ALL=en_US.UTF-8

FASTQ=$(ls data/*.fastq | sed 's/_R.*.$//' | sed 's/data\///' | sort -u)

mkdir -p results/02.assembly

declare -a FASTQs=("$FASTQ")

for FILE in ${FASTQs[@]}; do
	SPADESline='spades.py --meta -1 data/'$FILE'_R1_val_1.fastq -2 data/'$FILE'_R2_val_2.fastq -o results/02.assembly/'$FILE'_spades'
	MEGAHITline='megahit -1 data/'$FILE'_R1_val_1.fastq -2 data/'$FILE'_R2_val_2.fastq -o results/02.assembly/'$FILE'_megahit'
  	SPADES=$(spades.py --meta -1 data/$FILE'_R1_val_1.fastq' -2 data/$FILE'_R2_val_2.fastq'  -o results/02.assembly/$FILE'_spades')
        MEGAHIT=$(megahit -1 data/$FILE'_R1_val_1.fastq' -2 data/$FILE'_R2_val_2.fastq' -o results/02.assembly/$FILE'_megahit')
	echo -e $SPADESline"\n"$SPADES"\n"$MEGAHITline"\n"$MEGAHIT
done
