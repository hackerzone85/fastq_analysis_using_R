fl = file("Sample1_1.fastq", "r")
idx = 0
while (isIncomplete(fl)) {
  recs = readLines(fl, n = 2e+06)
  writeLines(sprintf("fout-%d.fastq", idx), recs)
  idx <- idx + 1
}

mclapply(seq_len(idx), function(i) { 
  fq = readFastq(sprintf("fout-%d.fastq", idx)) 
  ## work, then... 
  TRUE }
  )
