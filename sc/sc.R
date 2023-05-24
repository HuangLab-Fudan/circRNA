setwd('D:\\exoN06')
#https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE100206
ASJA.res<-read.table('raw/circ/circRNA.txt',header = T,sep = "\t")# reading the result of ASJA
circ2.res<-read.table('outfile',header = T,sep = "\t")#reading the result of CIRI2, reomove the "#" on the header
circID<-paste(circ2.res$chr,circ2.res$circRNA_start,circ2.res$circRNA_end,circ2.res$strand,sep="_")
circ2.res$circID<-circID

final.res<-merge(ASJA.res,circ2.res,by='circID')
######################
host<-c()
for(s in 1:dim(final.res)[1]){
  host<-c(host,strsplit(as.character(final.res[s,'gene_id']),',')[[1]][1])
}
final.res$hostgeneid<-host

final.res.v2<-final.res[,c('circID','junction_reads','junction_reads_ratio','circRNA_type','hostgeneid')]
library(ggplot2)
ggplot(final.res.v2, aes(x=junction_reads_ratio))+
  geom_density(alpha=0.6)+theme_classic()
{
  range<-c(0,0.2,0.4,0.6,0.8,1)
  num<-table(cut(final.res.v2$junction_reads_ratio,range))
  num<-as.data.frame(num)
  ggplot(num,aes(x=Var1,y=Freq))+geom_col(fill='grey75')+theme_classic()+ylab(c("The number of circRNAs"))+xlab(c('The ragne of junction reads ratio'))
  
  }

{ 
  bsj<-table(final.res.v2$junction_reads)
  bsj<-as.data.frame(bsj)
  bsj$Var1<-as.numeric(bsj$Var1)
  ggplot(bsj,aes(x=Var1,y=Freq))+geom_col(fill='grey75')+theme_classic()+ylab(c("The number of circRNAs"))+xlab(c('Back-splicing junction reads'))+scale_x_continuous(breaks = seq(0,5000,100))
}
{
  org<-table(final.res.v2$circRNA_type)
  org<-as.data.frame(org)
  colnames(org)<-c('type','Freq')
  org$ratio<-paste(round(org$Freq/sum(org$Freq),2)*100,"%",sep="")
  library(dplyr)
  org <- org %>%
    arrange(desc(type)) %>%
    mutate(lab.ypos = cumsum(Freq) - 0.4*Freq)
  
  ggplot(org, aes(x = "", y = Freq, fill = type)) +
    geom_bar(stat = "identity") +
    coord_polar("y", start = 0)+
    geom_text(aes(y = lab.ypos, label = ratio,vjust=0.01,hjust=0.4), color = "black")+
    theme_void()
}
##
#####





























## circRNA_fi type
{
  final.type<-rep('nan',dim(final.res)[1])
  ind<-final.res$length_exon>0 & final.res$circRNA_type=='exon'
  final.type[ind]<-'exon'
  #
  ind<-final.res$length_exon>0 & final.res$circRNA_type=='intron'
  final.type[ind]<-'intron'
  #
  ind<-final.res$length_exon>0 & final.res$circRNA_type=='intergenic_region'
  final.type[ind]<-'intergenic_region'
  #
  ind<-as.character(final.res$length_exon)=='NA' & final.res$circRNA_type=='intron'
  index<-is.na(ind)
  final.type[index]<-'intron'
  #
  ind<-as.character(final.res$length_exon)=='NA' & final.res$circRNA_type=='intergenic_region'
  index<-is.na(ind)
  final.type[index]<-'intergenic_region'
  
  final.res$circRNA.final.type<-final.type
}

## circ RNA type plot
{
  final.res.v2<-final.res[,c(1,8,9,10,15,19,23)]
  type.of.circ<-table(final.res.v2$circRNA.final.type)
  pie(type.of.circ)
}

#### exon number plot
{
  exon.circ<-final.res.v2[which(final.res.v2$circRNA.final.type=='exon'),]
  
  exon.num<-c()
  for(s in 1:dim(exon.circ)[1]){
    exon.num<-c(exon.num,length(strsplit(as.character(exon.circ[s,'pos_exon']),';')[[1]]))
  }
  exon.circ$exon.num<-exon.num
  
  se<-seq(0,10,1)
  se<-c(se,max(exon.num))
  x<-table(cut(exon.circ$exon.num,breaks = se))
  pie(x)
}

#### exon number length plot
{
  exon.len<-exon.circ$length_exon/100
  se<-seq(0,20,2)
  se<-c(se,max(exon.len))
  x<-table(cut(exon.len,breaks = se))
  barplot(x)
}

###exon circRNA host gene
{
  exon.circ<-final.res.v2[which(final.res.v2$circRNA.final.type=='exon'),]
  
  exon.host.type<-c()
  for(s in 1:dim(exon.circ)[1]){
    exon.host.type<-c(exon.host.type,strsplit(strsplit(as.character(exon.circ[s,'annotaion']),';')[[1]][3]," ")[[1]][3])
    #exon.host.type<-c(exon.host.type,strsplit(as.character(exon.circ[s,'annotaion']),';')[[1]][3])
  }
  exon.circ$exon.host.type<-exon.host.type
  
  x<-table(exon.circ$exon.host.type)
  pie(x)
  
}