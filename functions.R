add2 <-function(x,y){
  x+y
}
above10 <- function(x){
  use<- x>10
  x[use]
}
above <-function(x,y){
  use <- x>y
  x[use]
}
columnmean <-function(y, removeNA = TRUE){
  nc <-ncol(y)
  means <- numeric(nc)
  for(i in 1:nc)
  {
    means[i] <- mean(y[,i], na.rm = removeNA )
  }
  means
}
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
pollutantmean <-function(directory,pollutant, id=1:332){
    nf <- length(id)
    means <- numeric(nf)
    for (i in 1:nf){
        filename<-correctfilename(id[i])
        path<-paste(directory,"/",filename, sep="")
        filedata <-read.csv(path, header = TRUE )
        coldata<-filedata[names(filedata)==pollutant]
        means[i]<-mean(coldata[,c(1)] ,na.rm =TRUE)
     }
    means
  
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
corr <-function(directory,threshold=0){
  nf <- length(list.files("specdata"))
  x=NULL
  y=NULL
  
  for (i in 1:nf){
    filename<-correctfilename(i)
    path<-paste(directory,"/",filename, sep="")
    filedata <-read.csv(path, header = TRUE )
      if(sum(complete.cases(filedata))>threshold){
            cc <- filedata[complete.cases(filedata[,1:4]),]
            size <- nrow(cc)
            x=append(x,cc[names(cc)=="sulfate"][,c(1)])
            y=append(y,cc[names(cc)=="nitrate"][,c(1)])
          }
   
  }
  cor(x,y)
  
}
