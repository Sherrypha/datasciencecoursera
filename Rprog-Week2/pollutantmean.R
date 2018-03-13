#function to convert id to three digit filenames to three digits
correctfilename <-function(id){
  if(id < 100)
  {
    if(id<10){
      #user ipur
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
  total <- numeric(nf)
  num_obs  <- numeric(nf)
  for (i in 1:nf){
    #get correct filename
    filename<-correctfilename(id[i])
    
    #generate file path
    path<-paste(directory,"/",filename, sep="")
    
    #read .csv file and get column data for specified pollutant
    filedata <-read.csv(path, header = TRUE )
    coldata<-filedata[names(filedata)==pollutant]
    
    #sum non NA values
    total[i]<-sum(coldata[,c(1)] ,na.rm =TRUE)
    
    #get number of non NA values
    num_obs[i]<- length(coldata[,c(1)][!is.na(coldata[,c(1)])])
  }
  #calculate and output mean
  sum(total)/sum(num_obs)
  
}