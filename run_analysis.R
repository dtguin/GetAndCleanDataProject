## run_analysis.R - R Script for the Getting and Cleaning Data Course project.
##
## This script assumes the working directory is set to a directrory where the
##     'UCI HAR Dataset' exists, and contains the contents of the project data downloaded and  
## unzipped from:  
##      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
## This script accomplishes the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## Author:  David Guinivere
##
##
run_analysis <- function () {
        setwd("UCI HAR Dataset") ## Change working directory to data set root
        ##
        ## Merge the training and the test sets to create one data set.
        ###############################################################
        x_test_df <- read.table("./test/X_test.txt")
        x_train_df <- read.table("./train/X_train.txt")
        ## Merge (append) the data frames into x_df
        x_df <- rbind(x_test_df, x_train_df)
        ##
        ## Extract only the measurements on the mean and standard deviation for each measurement. 
        #########################################################################################
        ##
        ## Define a data frame keep_cols which has 2 variables, col and colname
        ## to define which columns from the X_test and X_train 
        ## data frames to keep
        ## Create data frame of column names from "features.txt"
        xdf_names <- read.table("./features.txt")
        names(xdf_names) <- c("col","colnames") ## Assign variable names to the xdf_names data frame
        xdf_names <- xdf_names[1:554,] ## Remove last 7 rows, since they are not mean or std calculations
        fslines <- grep("mean|std",xdf_names$colname,invert=TRUE) ## get column names w/o mean or std        
        xdf_names <- xdf_names[(-1 * fslines), ] ## Drop unwanted column names by assigning them to negative row numbers.
        ##
        ## Appropriately labels the data set with descriptive variable names. 
        #####################################################################
        ##
        ## xdf_names has the 79 column names we want, now "pretty up" the variable names
        xdf_names$colnames <- gsub("-","",xdf_names$colnames) ## Remove "-" from column names
        xdf_names$colnames <- gsub("\\(\\)","",xdf_names$colnames) ## Remove "()" from column names
        xdf_names$colnames <- gsub("mean","Mean", xdf_names$colname) ## Convert "mean" to "Mean"
        xdf_names$colnames <- gsub("std","Std", xdf_names$colname) ## Convert "std" to "Std"
        xdf_keepcols <- xdf_names[,1] ## vector of column numbers to keep
        x_df <- x_df[,xdf_keepcols] ## drop unwanted columns from x_df 
        names(x_df) <- xdf_names[,2] 
        ## x_df variable names are now consistent
        ##
        ## x_df now contains both the X_test and X-train data, and only the Mean and Std columns 
        ## needed later in the analysis.
        ##
        ## Get the subjects
        subject_test <- read.table("./test/subject_test.txt")
        subject_train <- read.table("./train/subject_train.txt")
        var_subject <- rbind(subject_test, subject_train)
        names(var_subject) <- "subject" ## set proper name for subject variable before addiong to x_df
        x_df$subject <- var_subject ## add the subject variable to x_df
        ##
        ## Get the activities
        activity_test <- read.table("./test/y_test.txt")
        activity_train <- read.table("./train/y_train.txt")
        var_activity <- rbind(activity_test, activity_train)
        names(var_activity) <- "activity" ## set proper name for activity variable before adding to x_df
        x_df$activity <- var_activity  ## add the activity variable to x_df
        ##
        ## 5. From the data set xdf, create a second, independent tidy data set
        ## with the average of each variable for each activity and each subject.
        ###############################################################################
        first_row <- TRUE ## No new rows yet...
        for (subj in 1:30) {            ## Iterate over all 30 subjects
                for (act in 1:6) {      ## anf all 6 subjects
                        sub_df <- x_df[which((x_df$activity==act) & (x_df$subject==subj)),1:79]
                        new_row <- summarise_each(sub_df, funs(mean))
                        new_row$activity <- act
                        new_row$subject <- subj
                        if (first_row) {
                                ## first row
                                final_df <- new_row
                                first_row <- FALSE
                        } else {
                                final_df <- rbind(final_df, new_row)
                        }
                }
        }
        ##
        ##
        ## Final step is to uses descriptive activity names to name the activities in the data set        
        ##
        ## Get the Activity labels
        act <- read.table("./activity_labels.txt")
        act <- act[[2]]
        act <- factor(act)
        ## Maake the labels consistent with the final_df column names
        act <- tolower(act) ## convert factor names to lower case
        act <- gsub("ing","",act) ## remove "ing" from activities
        act <- gsub("tt", "t", act) ## handle resulting sitt
        final_df$activity <- factor(act)
        levels(x_df$activity) <- act
        ##
        setwd("..") ## return to parent directory
        write.table(final_df, file="CleanAndTidy.txt", row.names=FALSE)
        final_df
}