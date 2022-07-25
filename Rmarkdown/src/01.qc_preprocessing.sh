#!/bin/bash
#DianaOaxaca

#Revisar la calidad de las lecturas de cada libreria con fastqc
#fastqc ../data/raw/ctrl_100M_R1.fastq ../data/raw/ctrl_100M_R1.fastq -o results/01.fastqc

#Remover lecturas de baja calidad y eliminar adaptadores

#trim_galore --fastqc --illumina --paired ../data/raw/ctrl_100M_R1.fastq ../data/raw/ctrl_100M_R1.fastq -o results/02.trimgalore/ctrl_trimgalore

export LC_ALL=en_US.UTF-8

mkdir -p results/{01.fastqc,01.trimgalore}

FASTQ=$(ls data/raw/*.fastq | sed 's/_R.*.$//' | sed 's/data\///' |sed 's/raw\///' | sort -u)
declare -a FASTQs=("$FASTQ")

for FILE in ${FASTQs[@]}; do
	FASTQCline='fastqc data/raw/'$FILE'_R1.fastq  data/raw/'$FILE'_R2.fastq -o results/01.fastqc/'
	TRIMline='trim_galore --fastqc --illumina --paired data/raw/'$FILE'_R1.fastq  data/raw/'$FILE'_R2.fastq -o results/01.trimgalore/'$FILE'_trimgalore'
	#echo -e $FASTQC"\n"$CMD 
	FASTQC=$(fastqc data/raw/$FILE'_R1.fastq'  data/raw/$FILE'_R2.fastq' -o results/01.fastqc/)
        TRIM=$(trim_galore --fastqc --illumina --length 75 -q 25  --paired data/raw/$FILE'_R1.fastq'  data/raw/$FILE'_R2.fastq' -o results/01.trimgalore/$FILE'_trimgalore')
	echo -e $FASTQCline"\n"$FASTQC"\n"$TRIMline"\n"$TRIM
done
