rankhospital <- function(state, outcome, num = "best") {
  
  ## Read outcome data
  data<- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## get list of valid states and outcomes
  states<-unique(c(as.character(data$State)))
  outcomes<-c("heart attack", "heart failure", "pneumonia")
  colnum<-NULL
  
  ## Check that state and outcome are valid
  if(!state%in%states)
  {
    stop("invalid state")
  }else if(!outcome%in%outcomes)
  {
    stop("invalid outcome")
  }
  
  ##get outcome column id
  if(match(outcome,outcomes)==1){
    colnum<-11}else if(match(outcome,outcomes)==2){
      colnum<-17}else if(match(outcome,outcomes)== 3){
        colnum<-23}
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  #get data for specified state
  
  sd<-data[as.character(data[,7])==state,]
  
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
  c$Hospital.Name
}