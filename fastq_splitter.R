#!/usr/bin/Rscript
library(ShortRead)
# set the file (.gz files also work)
setwd("/home/blab/NGS_Data/ADas/GT_SO_4376_Ginger_Reports/9.SNP_Analysis/Sample4/fastx_filtered/")
myFile <- "combined.fastq"
#fileBaseName <- sub(".fastq$","",myFile)
# iterate over fastq file
f <- FastqStreamer(myFile, 2e+06, verbose=TRUE)
file_index <- 1
while (length(fq <- yield(f))) {
  newName <- paste("mate2","/","S4_R2_L3","_", file_index,".fastq.gz", sep="")
  writeFastq(fq,file=newName,mode = "w",compress = T)
  file_index <- file_index + 1
}
close(f)
