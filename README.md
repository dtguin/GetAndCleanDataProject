# GetAndCleanDataProject
David Guinivere's Repository for the project for the Getting And Cleaning Data course can be found at
    https://github.com/dtguin/GetAndCleanDataProject.git

#Contents of Repository
getdata-projectfiles-UCI HAR Dataset.zip --Raw data set.
               Downloaded, and unzipped from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


CleanTidyData.txt -- Is the final resulting data set

CodeBook.md -- Describes the variables in the CleanAndTidyData data set (above) and the transformations used to get from the raw data (train.csv and test.csv) to the final CleanAndTidy data set.

README.md -- (This file) Describes the contents of the repository, and the initial set up instructions.

run_analysis.R -- R Script file that combines the test and training data sets, including steps to clean the data to produce the CleanTidyData set.


#Set Up Instructions
1. Create a directory for the contents of this repository.

2. Download into your working directory:

    * getdata-projectfiles-UCI HAR Dataset.zip

    * run_analysis.R


    * CodeBook.md (Optional but nice to have handy as a reference)

    * README.md   (Optional but nice to have handy as a reference)

3. Unzip getdata-projectfiles-UCI HAR Dataset.zip into your working directory, this will create the "UCI HAR Dataset" directory
     NOTE: Your working directory7 should NOT be changed from Step 1 above.
	 
4. Open R (or R Studio) and set the working directory to be the directory created in Step 1, above.
        (Use the command:  setwd(<path>)   Example:  setwd("C:/R_Prog/Project")  
         where the directory C:/R_Prog/Project was created in Step 1)
		 
		 Also use the command library(dplyr) to load the dplyr package.

#To Run The Analysis
From R (or R Studio) type the following commands:

    * source("run_analysis.R")
	* clean_tidy_df <- run_analysis()
	
	This will create the data frame clean_tidy_df and create the file CleanTidyData.txt
	in your working directory.
	
#How the run_analysis.R Script Works
The script essential performs the steps required in order to meet the requirements for this project.

Initially the X_test and X_train data sets are merged to create an internal data frame (x_df).

Next all 581 column names for x_df are read into xdf_names and the unwanted 502 variable names are dropped from xdf_names.
The resulting 79 variable names go through a series of gsub() transformations.  
These transformations remove all hyphens ("-"), all parenthesis pairs ("()"), and finally convert lower case 
"mean" and "std" to "Mean" and "Std" respectively.  

Next the subject variable is populated from the subject_test.txt and subject_train.txt files, and added to the x_df data frame. 
Likewise the activity variable is populated from y_test.txt and y_train.txt and added to x_df as a variable.
	
At this point the internal x_df data frame is complete.

There are 2 for{} loops that are used to generate a subset data frame of x_df.
The subset data frame isolates the observations by activity for each subject. 
The summarise_all() function from the dplyr package is used to compute the mean for each variable in the subset data frame, 
the corresponding activity and subject is added as variables, and the result is stored in the new "clean and tidy" 
data frame that is returned from run_analysis.

The final step before returning is to convert the activity variable to a factor for the 6 activities.
