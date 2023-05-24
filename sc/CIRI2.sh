#!/usr/bin/bash
dir=`pwd`
bwa=~/software/bwa-0.7.17/bwa
out_dir=$dir/exoN06

Read1='.filtered.1.fq'
Read2='.filtered.2.fq'

fastq_dir=$dir/task_63a7fd69f9ac467547c8246c
sample=`ls $fastq_dir|grep gz|sed 's/.filtered.[1 2].fq.gz//g'|uniq`
Fasta=~/referenceFile/GRCh38.p12.genome.fa
CIRI2=~/software/CIRI_v2.0.6/CIRI2.pl
gtf=~/referenceFile/gencode.v29.annotation.gtf


	echo $s
	mkdir -p ${out_dir}/$s
	gunzip -k -f ${fastq_dir}/${s}${Read1}.gz ${fastq_dir}/${s}${Read2}.gz
        $bwa mem -T 19 -t 12 $Fasta ${fastq_dir}/${s}${Read1} ${fastq_dir}/${s}${Read2} > ${out_dir}/$s/aln-pe.sam 2> ${out_dir}/$s/aln-pe.log
        perl $CIRI2 -I ${out_dir}/$s/aln-pe.sam -0 -O ${out_dir}/$s/outfile -F $Fasta -A $gtf -T 12
        rm -f ${out_dir}/$s/aln-pe.sam
        
