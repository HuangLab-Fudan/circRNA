#!/usr/bin/bash
dir=`pwd`
bam_dir=$dir/exoN06
gtf=~/referenceFile/gencode.v29.annotation.gtf
out_dir=$dir/exoN06
bam_file='_mapped_reads.bam'
samples='exoN06'
for s in `cat 1.txt`;do
	echo $s
	mkdir -p ${out_dir}/$s
	stringtie ${bam_dir}/$s/$s${bam_file} -f 0.1 -o ${out_dir}/$s/stringtie_assembly.gtf -p 12 -G ${gtf}
done
