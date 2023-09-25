setwd("/home/blab/Desktop/Dehulajhari_HotSpring/fastqQC")
library("ShortRead")
fl <- dir("/home/blab/Desktop/Dehulajhari_HotSpring/fastqQC", "fastq.gz", full=TRUE)
fq1 <- readFastq(fl[1])
fq2 <- readFastq(fl[2])
fq3 <- readFastq(fl[3])
fq4 <- readFastq(fl[4])
fq5 <- readFastq(fl[5])



qaSummary.fq1 <- qa(fl[1], type="fastq")
qaSummary.fq1
head(qaSummary.fq1[["readCounts"]])
head(qaSummary.fq1[["baseCalls"]])
browseURL(report(qaSummary.fq1))

qaSummary.fq2 <- qa(fl[2], type="fastq")
qaSummary.fq2
head(qaSummary.fq1[["baseCalls"]])
head(qaSummary.fq2[["baseCalls"]])
browseURL(report(qaSummary.fq2))

tbls <- tables(fq1)
tbls2 <- tables(fq2)
head(tbls1$distribution)

save.image("/home/blab/Desktop/Dehulajhari_HotSpring/fastqQC/fastq_analysis.RData")


writeFasta(fq1, "/home/blab/Desktop/Cynobacteria/SRX11.fasta")
writeFasta(fq2, "/home/blab/Desktop/Cynobacteria/SRX22.fasta")












