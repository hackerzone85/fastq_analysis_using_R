snps<-read.table("test.bed",sep="\t",header=F)
colnames(snps)<-c("chr","start","end","id","strand")

# put the chromosomes in the good order: chr1, chr2, chr22, chrX
#goodChrOrder <- paste("chr",c(1:22,"X","Y"),sep="")
#snps$chr <- factor(snps$chr,levels=goodChrOrder)

# Plot the densities of snps in the bed file for each chr seperately
library(ggplot2)
snpDensity<-ggplot(snps) +
  geom_histogram(aes(x=start),binwidth=1e6) + # pick a binwidth that is not too small
  facet_wrap(~ chr,ncol=5) + # seperate plots for each chr, x-scales can differ from chr to chr
  ggtitle("Density of SNP across optimized ginger transcriptome assembly") +
  xlab("Position in the genome") +
  ylab("SNP Density") #+
 # theme_bw() # I prefer the black and white theme

# save the plot to .png file
tiff("snp_density.tiff",1920,1080)
print(snpDensity)
dev.off()
