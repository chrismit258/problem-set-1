#! /usr/bin/env bash 

datasets='/vol2/home/smithc/data-sets'

# Which state in states.tab.gz has the lowest murder rate?  
states="$datasets/misc/states.tab.gz"

answer_1=$(zcat $states \
    | cut -f1,6 \
    | sort -k2n \
    | grep -v '^#' \
    | head -n1 \
    | cut -f1 \
    | sed 's/"//g' \
    | sed 's/_/ /g')

echo "answer-1: $answer_1"

# How many sequence records are in the sample.fa file? 
samples="$datasets/fasta/sample.fa"

answer_2=$(grep "^>" $samples \
    | wc -l)

echo "answer-2: $answer_2"

# How many unique CpG IDs are in cpg.bed.gz? 
cpg="$datasets/bed/cpg.bed.gz"

answer_3=$(zcat $cpg \
    | cut -f4 \
    | sort \
    | uniq \
    | wc -l)

echo "answer-3: $answer_3"

# How many sequence records are in the SP1.fq file? 
SP1="$datasets/fastq/SP1.fq"

answer_4=$(grep '^@cluster' $SP1\
    | wc -l)

echo "answer-4: $answer_4"

# How many words are on lines containing the word bloody in hamlet.txt? 

hamlet="$datasets/misc/hamlet.txt"

answer_5=$(grep -i 'bloody' $hamlet \
    | wc -w)

echo "answer-5: $answer_5"

# What is the length of the sequence in the first record of sample.fa? 

answer_6=$(head -n2 $samples \
    | grep -v '^>' \
    | tr -d '\n' \
    | wc -c)

echo "answer-6: $answer_6"

# What is the name of the longest gene in genes.hg19.bed.gz? 

genes="$datasets/bed/genes.hg19.bed.gz"

answer_7=$(zcat $genes \
    | awk 'BEGIN {OFS="\t"}{print $0,$3-$2}'\
    | sort -k7nr \
    | head -n1 \
    | awk '{print $4}')

echo "answer-7: $answer_7"

# How many unique chromosomes are in genes.hg19.bed.gz? 

answer_8=$(zcat $genes \
    | awk '{print $1}' \
    | sort -u \
    | wc -l)

echo "answer-8: $answer_8"

# How many intervals are associated with CTCF (not CTCFL) in peaks.chr22.bed.gz? 

peaks="$datasets/bed/peaks.chr22.bed.gz"

answer_9=$(zcat $peaks \
    | awk '{print $4}' \
    | sort \
    | uniq -c \
    | grep -w 'CTCF' \
    | awk '{print $1}')

echo "answer-9: $answer_9"

# On what chromosome is the largest interval in lamina.bed? 

lamina="$datasets/bed/lamina.bed"

answer_10=$(awk 'BEGIN {OFS="\t"}{print $0, $3-$2}' $lamina \
    | sort -k5nr \
    | head -n1 \
    | awk '{print $1}')

echo "answer-10: $answer_10"




