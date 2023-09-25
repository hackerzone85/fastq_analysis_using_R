#softTrim
#trim first position lower than minQuality and all subsequent positions
#omit sequences that after trimming are shorter than minLength
#left trim to firstBase, (1 implies no left trim)
#input: ShortReadQ reads
#       integer minQuality
#       integer firstBase
#       integer minLength
#output: ShortReadQ trimmed reads
softTrim<-function(reads,minQuality,firstBase=1,minLength=5){
  qualMat<-as(FastqQuality(quality(quality(reads))),'matrix')
  qualList<-split(qualMat,row(qualMat))
  ends<-as.integer(lapply(qualList,
                          function(x){which(x < minQuality)[1]-1}))
  #length=end-start+1, so set start to no more than length+1 to avoid negative-length
  starts<-as.integer(lapply(ends,function(x){min(x+1,firstBase)}))
  #use whatever QualityScore subclass is sent
  newQ<-ShortReadQ(sread=subseq(sread(reads),start=starts,end=ends),
                   quality=new(Class=class(quality(reads)),
                               quality=subseq(quality(quality(reads)),
                                              start=starts,end=ends)),
                   id=id(reads))
  
  #apply minLength using srFilter
  lengthCutoff <- srFilter(function(x) {
    width(x)>=minLength
  },name="length cutoff")
  newQ[lengthCutoff(newQ)]
}