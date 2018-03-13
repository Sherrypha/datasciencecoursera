##Programming assignment1 part 3
#function to correct fiename
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
#Write a function that takes a directory of data files and a threshold for complete cases and calculates the 
#correlation between sulfate and nitrate for monitor locations where the number of completely observed cases
#(on all variables) is greater than the threshold. 

#corr function
corr <-function(directory,threshold=0){
  #get num of files in directory
  nf <- length(list.files(directory))
  
  res<-numeric()
  
  for (i in 1:nf){
        filename<-correctfilename(i)
        path<-paste(directory,"/",filename, sep="")
        filedata <-read.csv(path, header = TRUE )
        #compare sum of complete cases with threshold
        if(sum(complete.cases(filedata))>threshold){
            #get complete cases from file
            cc <- filedata[complete.cases(filedata[,1:4]),]
            size <- nrow(cc)
            x <- cc[names(cc)=="sulfate"][,c(1)]
            y <- cc[names(cc)=="nitrate"][,c(1)]
            
            res=append(res, cor(x,y))
        }
        else
        {
          res
        }
  
  }
 
 res

  
}
