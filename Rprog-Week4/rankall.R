rankall <- function(outcome, num = "best") {

  ## Read outcome data
  data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## get list of valid states and outcomes
  states<-unique(c(as.character(data$State)))
  states<-sort(states,decreasing = FALSE)
  outcomes<-c("heart attack", "heart failure", "pneumonia")
  
  
  colnum<-NULL
  df= NULL #dataframe to hold result
  hospital <- NULL #vector to hold hospital name
  

  ## Check that outcome is valid
   if(!outcome%in%outcomes)
  {
    stop("invalid outcome")
  }
  
  ##get outcome column id
  if(match(outcome,outcomes)==1){
    colnum<-11}else if(match(outcome,outcomes)==2){
      colnum<-17}else if(match(outcome,outcomes)== 3){
        colnum<-23}
  
  ##get 
 ## min_per_state<-sapply(split(as.numeric(data[,colnum]), data[,7]), min, na.rm=TRUE)
 
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  #get data for specified state
  for (i in 1:length(states))
  {
    #get data for particular state
    sd<-data[as.character(data[,7])==states[i],]
    
    #remove NA rows
    sd<-sd[!(is.na(sd[,colnum])),]
    
    #get data for hospitals with the lowest mortality rate
    
    #order by Rate and hospital name
    sd<-sd[order(suppressWarnings(as.numeric(sd[,colnum])),sd$Hospital.Name),]
    
    
      if(num=="best"){
        c<-sd[sd[,colnum] == min(suppressWarnings(as.numeric(sd[,colnum])), na.rm = TRUE ),]
      }else if(num=="worst"){
        c<-sd[sd[,colnum] == max(suppressWarnings(as.numeric(sd[,colnum])), na.rm = TRUE ),]
      }else{
        c<-sd[num,]
      }
    #return best hospital
    hospital =append(hospital, c$Hospital.Name[1])
    state =append(state, states[i])
    
  }
  df =data.frame(hospital,state)
  colnames(df)=c("hospital","state")
  df
 
}
