##Name: run_analysis.R 
#R Script to prepare tidy data as required for Getting and Cleaning Data Course Project

run_analysis <- function(){

library(dplyr)
library(codebook)

#Getting Data
#download project data set
if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/UCI HAR Dataset.zip"))
{download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                       destfile="./data/UCI HAR Dataset.zip" )}

#unzipdata
setwd("./data")
unzip("UCI HAR Dataset.zip")
setwd("../")

#read datasets 
activity_labels<-tbl_df(read.table("./data/UCI HAR Dataset/activity_labels.txt"))
features<-tbl_df(read.table("./data/UCI HAR Dataset/features.txt"))
subject_train<-tbl_df(read.table("./data/UCI HAR Dataset/train/subject_train.txt"))
X_train<-tbl_df(read.table("./data/UCI HAR Dataset/train/X_train.txt"))
Y_train<-tbl_df(read.table("./data/UCI HAR Dataset/train/Y_train.txt"))
subject_test<-tbl_df(read.table("./data/UCI HAR Dataset/test/subject_test.txt"))
X_test<-tbl_df(read.table("./data/UCI HAR Dataset/test/X_test.txt"))
Y_test<-tbl_df(read.table("./data/UCI HAR Dataset/test/Y_test.txt"))

##Processing Data
# extract mean n std measures for tran and test sets
ms_test<-select(X_test,grep("mean\\W|std\\W",as.character(features$V2)))
ms_train<-select(X_train,grep("mean\\W|std\\W",as.character(features$V2)))
#bind test subject, set and labels
test<-cbind(subject_test,Y_test,ms_test)
#bind train subject, set and labels
train<-cbind(subject_train,Y_train,ms_train)
#merge test and train data sets
data<-rbind(test,train)
#set colnames for merged data set
variables<-c(c("subject","activity"),
             tolower(grep("mean\\W|std\\W",
                          as.character(features$V2),value=TRUE)))
variables<-gsub("\\()","", variables)
colnames(data)<- variables
#give activities in the data set a descriptive name
activity_list= as.list(as.character(activity_labels$V2),as.numeric(activity_labels$V1))
data$activity<-recode_factor(data$activity, !!!activity_list)
#
mean_data <-data  %>%
        group_by(activity,subject) %>%
        summarise_all(mean)

#outputing results
#write tidy data set to .txt file
write.table(mean_data, file = "tidydata.txt", sep = " ", row.names = FALSE)
}