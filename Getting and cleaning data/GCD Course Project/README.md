---
title: "Getting and Cleaning Data Project"
author: "Sherifat Akintunde-Shitu"
date: "19 June 2018"
output: 
  html_document:
    keep_md: yes
    toc: yes
---
This file explains the content of the run_analysis.R file. 

#Introduction

The Source data for this file is A 561-feature vector with time and frequency domain variables, Its activity label, An identifier of the subject who carried out the experiment with files that include the following:
The dataset includes the following files:
=============================================================================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The run_analysis.r file contains function run_analysis that cleans up the UCI HAR Dataset to create a tidy data. The content of the file is split into the following sections by comments
        
         - *Section 1: Getting data*
         - *Section 2: Data Processing*
         - *Section 3: Outputing result*

#Analysis

===============================================================================================

##Section 1: Getting data
The code in this section

        - downloads the data
        - unzips the data
        - create tbl_df from the data set files. I chose to use tbl_df to make it easy to process data with the dplyr package,
        
=============================================================================================

##Section 2: Data Processing

  The code in this section does the following

        1. Extracts Mean and Standard Deviation Measures using the grep function to get IDs of features from the 'features' tbl_df that have mean() and std() in their text subsetting from X_test and X_train setsto get 

                - *ms_test* :subset of x_test with mean() and std() measures
                - *ms_train* :subset of x_train with mean() and std() measures

        2. Binds Column labels to create a more complete data set using the cbind function. It binds the test and train subsets with their corresponting subject, activity and lables to form to form the test and train dfs
                - *test* : column bind of subject_test, Y_test and ms_test

        3. Merges the train and test data sets using rbin

                - *data* : row bind of test and train data sets along with the activiry, subject and labels
        
        4. Sets the column names, by
                - extracting the mean and standard deviation measures from the feautures df using the grep() function to get valuess of feautures that have mean() and std() in their text.
                - using tolower() to make all the text lower case
                - concantenating the resulting vector with vector c("subject","activity")
                - ing the concatenated vector as variables
                - removing the '()' in the text using the gsub() function
                - and then setting the column names od the tbl_df : data to variables
                
                        -*variables*: column names for data set
        5. Sets descriptive activity names by
        - creating a list of activity from the activity labels 
        - using recode_factor() replace activity IDs with corresponding activity
        
                - *activity_list* :list of activity and coresponding IDs
        6. Creats Tidy Data Set with average values of each variable for each activity and each subject,

        - group data by activity, subject
        - summarise the data using summarise_all() calling the mean function

========================================================================================

##Section 3:Outputing Result
Outputs the tidy data set to a space separated file :'tidydata.txt'

========================================================================================

To run this file, save and source the file and run the run_anaysis()  function

==========================================

