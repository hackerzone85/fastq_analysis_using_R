quality.type <- function(fastq.file,read.num=200) {
  ### script to tell the type of quality scores in Illumina FASTQ file
  ### fastqfile: FASTQ file name, including the path
  ### read.num: number of reads at the beginning to be sampled
  ### author: Sanzhen Liu
  ### date: 12/28/2011
	
  read.num <- min(read.num,10000) # limite the maximum reads
  
  d <- read.delim(fastq.file,nrows=4*read.num,header=F)
  d <- as.character(d[,1])
  qual.sample <- d[grep("^\\+",d)+1] # extract quality data
  qual.sample <- paste(qual.sample,collapse="") # concatnate quality data
 
  ### function to convert ASCII to integer:
	asc2int <- function(qual) {
		qual.asc <- strsplit(qual,"")[[1]] # split quality string
    # then convert string (ASCII) to integer:
		qual.int <- sapply(qual.asc, function(x) { strtoi(charToRaw(x),16L) })
	}
	
	qual.int <- asc2int(qual.sample)
  hist(as.numeric(qual.int))

  cat(paste("Fastq file:",fastq.file,"\n"))
  cat(paste("Read number (first part):",read.num,"\n"))
  cat(paste("Here is the summary of quality score:","\n"))
  print(summary(qual.int))
  ### judge (ref wikipedia - FASTQ)
  # S - Sanger        Phred+33,  raw reads typically (0, 40)
  # X - Solexa        Solexa+64, raw reads typically (-5, 40)
  # I - Illumina 1.3+ Phred+64,  raw reads typically (0, 40)
  # J - Illumina 1.5+ Phred+64,  raw reads typically (3, 40)
  # with 0=unused, 1=unused, 2=Read Segment Quality Control Indicator (bold) 
  # L - Illumina 1.8+ Phred+33,  raw reads typically (0, 41)
  if (min(qual.int)>=66) {
    cat("QUALITY TYPE: Illumina 1.3+, mostly likely Illumina 1.5+")
  } else {
    if (min(qual.int)>=64) {
      cat("QUALITY TYPE: Illumina 1.3+")
    }  else {
      if (min(qual.int)>=59) {
         cat("QUALITY TYPE: Solexa+64")
      } else {
        if (min(qual.int)>=33) {
          cat("QUALITY TYPE: Sanger")
        }
      }
    }
  }
  cat("\n")
  cat("ABOVE CONCLUSION IS JUST FOR YOUR REFERENCE.")
}
