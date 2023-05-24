#!/usr/bin/bash
GDC_ref=~outpath/STAR_index
dir=`pwd`
fastq_dir=$dir/task_63a7fd69f9ac467547c8246c
bam_dir=$dir/exoN06
Read1='_1.fastq.gz'
Read2='_2.fastq.gz'
Bam_out='_mapped_reads.bam'
X1='_x1'
X1SJ='_x1SJ.out.tab'
Index2='_index2'
samples='exoN06'

for s in ${samples};do
echo $s
        
mkdir -p ${bam_dir}/$s
cd ${bam_dir}/$s
STAR  \
--genomeDir ${GDC_ref} \
--readFilesCommand zcat \
--readFilesIn ${fastq_dir}/${s}${Read1} ${fastq_dir}/${s}${Read2} \
--runThreadN 8 \
--outFilterMultimapScoreRange 1 \
--outFilterMultimapNmax 20 \
--outFilterMismatchNmax 10 \
--alignIntronMax 500000 \
--alignMatesGapMax 1000000 \
--sjdbScore 2 \
--alignSJDBoverhangMin 1 \
--genomeLoad NoSharedMemory \
--outFilterMatchNminOverLread 0.33 \
--outFilterScoreMinOverLread 0.33 \
--sjdbOverhang 100 \
--outSAMstrandField intronMotif \
--outSAMtype None \
--outSAMmode None \
--outFileNamePrefix ${bam_dir}/$s/$s${X1}
        
cd ${bam_dir}/$s
mkdir -p ${bam_dir}/$s/$s${Index2}
STAR \
--runMode genomeGenerate \
--genomeDir ${bam_dir}/$s/$s${Index2} \
--genomeFastaFiles ~/referenceFile/gencode.v29.annotation.gtf \
--sjdbOverhang 100 \
--runThreadN 12 \
--sjdbFileChrStartEnd ${bam_dir}/$s/$s${X1SJ}

cd ${bam_dir}/$s
STAR \
--genomeDir ${bam_dir}/$s/$s${Index2} \
--readFilesCommand zcat \
--readFilesIn ${fastq_dir}/${s}${Read1} ${fastq_dir}/${s}${Read2} \
--runThreadN 10 \
--outFilterMultimapScoreRange 1 \
--outFilterMultimapNmax 20 \
--outFilterMismatchNmax 10 \
--alignIntronMax 500000 \
--alignMatesGapMax 1000000 \
--sjdbScore 2 \
--alignSJDBoverhangMin 1 \
--genomeLoad NoSharedMemory \
--limitBAMsortRAM 70000000000 \
--outFilterMatchNminOverLread 0.33 \
--outFilterScoreMinOverLread 0.33 \
--sjdbOverhang 100 \
--outSAMstrandField intronMotif \
--outSAMattributes NH HI NM MD AS XS \
--outSAMunmapped Within \
--outSAMtype BAM SortedByCoordinate \
--outSAMheaderHD @HD VN:1.4 Sergey \
--chimOutType WithinBAM \
--chimSegmentMin 20

mv ${bam_dir}/$s/Aligned.sortedByCoord.out.bam ${bam_dir}/$s/$s${Bam_out}
sambamba index ${bam_dir}/$s/$s${Bam_out}
rm -rf ${bam_dir}/$s/$s${Index2}
done
