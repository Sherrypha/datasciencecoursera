---
title: "Getting and Cleaning Data Project"
author: "Sherifat Akintunde-Shitu"
date: "19 June 2018"
output: 
  html_document:
    keep_md: yes
    toc: yes
---
#Introduction
This file describes the variables, the data, and any transformations or work that you performed to clean up the data for the Getting and Cleaning Data Project. This file is split into three sections as seen in the table of content above. 

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
 

#Analysis
## *Getting data*
In this section, I 
- download the UCI HAR Dataset from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)- unzip the zip file and store the data from the files in tbl_dfs with corresponding names. the resulting tbl_dfs are as follow

        - *features*: List of all features.
        - *activity_labels*: Links the class labels with their activity name.
        - *X_train*: Training set.
        - *X_train*: Training labels.
        - *X_test*: Test set.
        - *Y_test*: Test labels.
        - *subject_train*: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
        - *subject_train*: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 



##*Data Processing*

###Step 1. Extract Mean and Standard Deviation Measures
To extract the mean and standard deviation measures, I used the grep() function to get IDs of features that have mean() and std() in their text and select subsets from X_test and X_train sets into ms_test and ms_train dataframes.

        - *ms_test* :subset of x_test with mean() and std() measures
        - *ms_train* :subset of x_train with mean() and std() measures

```r
# extract mean n std measures for tran and test sets
        ms_test<-select(X_test,grep("mean\\W|std\\W",as.character(features$V2)))
        ms_train<-select(X_train,grep("mean\\W|std\\W",as.character(features$V2)))
```
        
###Step 2. Bind Column labels
To create a more complete data set I bind the test and train subsets with their corresponting subject, activity and lables to form to form the test and train dfs

        - *test* : column bind of subject_test, Y_test and ms_test
        - *train* : column bind of subject_train, Y_train and ms_train

```r
#bind test subject, set and labels
        test<-cbind(subject_test,Y_test,ms_test)
#bind train subject, set and labels
        train<-cbind(subject_train,Y_train,ms_train)
```

###Step 3. Merge the train and test data sets

        - *data* : row bind of test and train data sets along with the activiry, subject and labels


```r
#merge test and train data sets
        data<-rbind(test,train)
```
###Step 4. To set the column names, I 
- extract the mean and standard deviation measures from the feautures df using the grep() function to get valuess of feautures that have mean() and std() in their text.
- use tolower() to make all the text lower case
- concantenate the resulting vector with vector c("subject","activity")
- save the concatenated vector as variables
- removed the '()' in the text using the gsub() function
- and then set the column names od the tbl_df : data to variables
        
        -*variables*: column names for data set

```r
#set colnames for merged data set
        variables<-c(c("subject","activity"),
             tolower(grep("mean\\W|std\\W",
                          as.character(features$V2),value=TRUE)))
        variables<-gsub("\\()","", variables)
        colnames(data)<- variables
```

###Step 5. Set Activity Names
To set activity names
- create a list of activity from the activity labels 
- using recode_factor() replace activity IDs with corresponding activity

        - *activity_list* :list of activity and coresponding IDs
        

```r
#give activities in the data set a descriptive name
        activity_list= as.list(as.character(activity_labels$V2),as.numeric(activity_labels$V1))
        data$activity<-recode_factor(data$activity, !!!activity_list)
```

###Step 6 Create Tidy Data Set with average Values
To create independent tidy data set with the average of each variable for each activity and each subject, 
- group data by activity, subject
- summarise the data using summarise_all() calling the mean function

        - *mean_data* - final tidy data set with the average of each variable for each activity and each subject

```r
        mean_data <-data  %>%
          group_by(activity,subject) %>%
          summarise_all(mean)
```

##*Outputing Result*
Output the tidy data set to a space separated file :'tidydata.txt'

```r
#write tidy data set to 
write.table(mean_data, file = "tidydata.txt", sep = " ", row.names = FALSE)
```
#Tidy data Description
Tidy data is a data set with 180 observations of 68 variables. the variables are a follows


```
## [1] " Variable  1 :  activity  - recorded activity with levels ( WALKING, WALKING_UPSTAIRS , WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)"
## [1] " Variable  1 :  activity"
## [1] " Variable  2 :  subject - participating subjects with levels 1:30\n                                         Variable 3-68 are numeric variables with titles as seen below"
## [1] " Variable  3 :  tbodyacc-mean-x"
## [1] " Variable  4 :  tbodyacc-mean-y"
## [1] " Variable  5 :  tbodyacc-mean-z"
## [1] " Variable  6 :  tbodyacc-std-x"
## [1] " Variable  7 :  tbodyacc-std-y"
## [1] " Variable  8 :  tbodyacc-std-z"
## [1] " Variable  9 :  tgravityacc-mean-x"
## [1] " Variable  10 :  tgravityacc-mean-y"
## [1] " Variable  11 :  tgravityacc-mean-z"
## [1] " Variable  12 :  tgravityacc-std-x"
## [1] " Variable  13 :  tgravityacc-std-y"
## [1] " Variable  14 :  tgravityacc-std-z"
## [1] " Variable  15 :  tbodyaccjerk-mean-x"
## [1] " Variable  16 :  tbodyaccjerk-mean-y"
## [1] " Variable  17 :  tbodyaccjerk-mean-z"
## [1] " Variable  18 :  tbodyaccjerk-std-x"
## [1] " Variable  19 :  tbodyaccjerk-std-y"
## [1] " Variable  20 :  tbodyaccjerk-std-z"
## [1] " Variable  21 :  tbodygyro-mean-x"
## [1] " Variable  22 :  tbodygyro-mean-y"
## [1] " Variable  23 :  tbodygyro-mean-z"
## [1] " Variable  24 :  tbodygyro-std-x"
## [1] " Variable  25 :  tbodygyro-std-y"
## [1] " Variable  26 :  tbodygyro-std-z"
## [1] " Variable  27 :  tbodygyrojerk-mean-x"
## [1] " Variable  28 :  tbodygyrojerk-mean-y"
## [1] " Variable  29 :  tbodygyrojerk-mean-z"
## [1] " Variable  30 :  tbodygyrojerk-std-x"
## [1] " Variable  31 :  tbodygyrojerk-std-y"
## [1] " Variable  32 :  tbodygyrojerk-std-z"
## [1] " Variable  33 :  tbodyaccmag-mean"
## [1] " Variable  34 :  tbodyaccmag-std"
## [1] " Variable  35 :  tgravityaccmag-mean"
## [1] " Variable  36 :  tgravityaccmag-std"
## [1] " Variable  37 :  tbodyaccjerkmag-mean"
## [1] " Variable  38 :  tbodyaccjerkmag-std"
## [1] " Variable  39 :  tbodygyromag-mean"
## [1] " Variable  40 :  tbodygyromag-std"
## [1] " Variable  41 :  tbodygyrojerkmag-mean"
## [1] " Variable  42 :  tbodygyrojerkmag-std"
## [1] " Variable  43 :  fbodyacc-mean-x"
## [1] " Variable  44 :  fbodyacc-mean-y"
## [1] " Variable  45 :  fbodyacc-mean-z"
## [1] " Variable  46 :  fbodyacc-std-x"
## [1] " Variable  47 :  fbodyacc-std-y"
## [1] " Variable  48 :  fbodyacc-std-z"
## [1] " Variable  49 :  fbodyaccjerk-mean-x"
## [1] " Variable  50 :  fbodyaccjerk-mean-y"
## [1] " Variable  51 :  fbodyaccjerk-mean-z"
## [1] " Variable  52 :  fbodyaccjerk-std-x"
## [1] " Variable  53 :  fbodyaccjerk-std-y"
## [1] " Variable  54 :  fbodyaccjerk-std-z"
## [1] " Variable  55 :  fbodygyro-mean-x"
## [1] " Variable  56 :  fbodygyro-mean-y"
## [1] " Variable  57 :  fbodygyro-mean-z"
## [1] " Variable  58 :  fbodygyro-std-x"
## [1] " Variable  59 :  fbodygyro-std-y"
## [1] " Variable  60 :  fbodygyro-std-z"
## [1] " Variable  61 :  fbodyaccmag-mean"
## [1] " Variable  62 :  fbodyaccmag-std"
## [1] " Variable  63 :  fbodybodyaccjerkmag-mean"
## [1] " Variable  64 :  fbodybodyaccjerkmag-std"
## [1] " Variable  65 :  fbodybodygyromag-mean"
## [1] " Variable  66 :  fbodybodygyromag-std"
## [1] " Variable  67 :  fbodybodygyrojerkmag-mean"
## [1] " Variable  68 :  fbodybodygyrojerkmag-std"
```
