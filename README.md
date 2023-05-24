# circRNA
This is the program for identification circRNA from RNA-seq
The reference geonome and annotation file can be download following the command in Linux
	 mkdir referenceFile
	 cd referenceFile
	wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_29/GRCh38.p12.genome.fa.gz
	wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_29/gencode.v29.annotation.gtf.gz
	# Decompress files
	>gunzip GRCh38.p12.genome.fa.gz
	>gunzip gencode.v29.annotation.gtf.gz

related software shuold be download and installed.
	1. STAR, an aligner tool, obtainable via https://github.com/alexdobin/STAR
	2. BWA , an aligner tool, obtainable via https://sourceforge.net/projects/bio-bwa/files/ 
	3. FastQC, a quality control tool, obtainable via http://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc
	4. Trimmomatic, a trimmer for Illumina sequence data, obtainable via https://github.com/usadellab/Trimmomatic
	5. sambamba , SAM and BAM files manipulation tool, obtainable via https://github.com/biod/sambamba
	6. stringtie , a transcript assembly and quantitation tool, obtainable via https://github.com/gpertea/stringtie
	7. R software environment, a statistical computing and graphics environment, obtainable via https://cran.r-project.org/bin/linux/
	8. ASJA , identification junction program, obtainable via https://github.com/HuangLab-Fudan/ASJA
	9. CIRI2 , identification circRNA tool, obtainable via https://sourceforge.net/projects/ciri/files/CIRI2/
	10. bedtools , a potent toolkit for genomic mathematics, obtainable via https://github.com/arq5x/bedtools2/releases/download/

1. circRNA identification by CIRI2 
1.1 the BWA index should be created firstly.
usage:bwa index referenceFile/GRCh38.p12.genome.fa
2.2 identification circRNA used CIRI2, the input dir and CIRI2 dir should be change in CIRI2.sh.
usage: sh CIRI2.sh
circRNAs are saved at 'outfile'

2. circRNA identification by ASJA
To obtain circRNA, you can execute the 'ASAJ-all.pl' Perl script based on the ASJA user guide. Additionally, you can also run the following command:
2.2 usage: sh STAR.sh # The input directory, GTF directory, index directory, and reference genome directory should be modified in 'STAR.sh'.
2.3 usage: sh stringtie.sh # The input directory, GTF directory should be modified in stringtie.sh.
2.4 usage: sh ASJA.sh # The input directory, GTF directory and CI_dir and SI_dir should be change in ASJA.sh.
circRNAs are saved at 'raw/circ/circRNA.txt'

3. The characteristics of circRNA can be displayed using the R programming language.
usage: open R Studio and run the following command in the 'sc.R'

# circRNA
