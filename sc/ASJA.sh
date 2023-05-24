# !/bin/bash
dir=`pwd`
outdir=$dir/0404_ASJS
gtf=~/referenceFile/gencode.v29.annotation.gtf
CI_dir=$dir/exoN06
SI_dir=$dir/exoN06
samples='exoN06'

for s in ${samples};do
	echo $s
	mkdir -p $outdir/$s
	echo ${s}
	perl /home/E/ASJA/ASJA-all.pl -I /home/E/ASJA -G ${gtf} -SI ${SI_dir}/$s/stringtie_assembly.gtf -CI ${CI_dir}/$s -O $outdir/$s
done
