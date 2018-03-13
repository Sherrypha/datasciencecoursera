correctfilename <-function(id){
  if(id < 100)
  {
    if(id<10){
      filename<-paste("00",id,".csv",sep="")
    }else {
      filename<-paste("0",id,".csv",sep="")
    }
  }else{
    filename<-paste(id,".csv",sep="")
  }
  filename
}
complete <-function(directory,id=1:332){
  nf <- length(id)
  d = data.frame( id=rep(0, nf), nobs=rep(0,nf))
  for (i in 1:nf){
    filename<-correctfilename(id[i])
    path<-paste(directory,"/",filename, sep="")
    filedata <-read.csv(path, header = TRUE )
    d[i, ] = c(id[i],sum(complete.cases(filedata)))
  }
  d
  
}