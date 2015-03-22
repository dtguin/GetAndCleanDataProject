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

#To Run The Analysis
From R (or R Studio) type the following commands:

    * source("run_analysis.R")
	* clean_tidy_df <- run_analysis()
	
	This will create the data frame clean_tidy_df and create the file CleanTidyData.txt in your working directory.
	
