## Getting and Cleaning Data - Human Activity Recognition Using Smartphones Data Set 


**Introduction**

UCI Machine Learning Repository is a collection of databases used in different experiments for analysis of machine learning algorithms, available for use by other researchers. (1) Subject of this analysis is the human activity recognition using smartphones data set, which is result of experiment where observed subjects performing different activities wearing a Samsung Galaxy S2 on their waist. (2)

The goal of our analysis is to build a tidy dataset according given instructions, tha can be further used in future data analysis. Human activity recognition is very important domain of machine learning research because of its application in the real world as in medicine (technology driven assistive healthcare, monitoring of elderly people), sports, security, logistic support, location-based services, home automation etc.

**Data Collection**

This analysis was done with data sample from Human Activity Recognition Using Smartphones Data Set (UCI Machine Learning repository) (2) provided by Professor Jeff Leek for Getting and Cleaning Data course on Coursera.org. (3) Data were downloaded using R Programing Language (4) from the following link [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] on April 24, 2014. Data provided consists of two collections of datasets(test and train) and supporting documentation(text files - variables' codebook, variables' labels, activity description). Each collection of dataset(test and train) contains *Inertial signals* folder - raw data, which are processed and the result are three text files containing identifiers of the subject observed, code of activity he performed and measures, respectively. The measures' file has 561 variables: measures of acceleration and angular velocity summarized over a period of time with specific frequency (triaxial acceleration from the accelerometer and the estimated body acceleration; triaxial angular velocity from the gyroscope) and their summary statistics. All the raw measure variables were normalized to interval [-1,1], so they are unit free. (2) There are 30 subjects in total, performing 6 different activities: standing, sitting, laying, walking, walking up and walking down.
Analysis is done in RStudio (R3.0.3).

**Cleaning data**

This data repository contains R script called run_analysis.R, README.mdfile (brief explanation of the R script) and Codebook.md file(information about variables in tidy dataset).
In the R script first, data are downloaded to Data folder in the working directory from the link aforementioned. Since the downloaded file is an archive file, it's unziped. The result is UCI HAR Dataset folder. Steps for creating tidy data are following:

**1. Merge the training and the test sets to create one data set.**

Files *"subject_train.txt"*, *"X_train.txt"* and *"y_train.txt"* are read from *Train* folder in *UCI HAR Dataset*. All three files are combined by columns in one dataframe - *Train*.

Files *"subject_test.txt"*, *"X_test.txt"* and *"y_test.txt"* are read from *Test* folder in *UCI HAR Dataset*. All three files are binded by colums in one dataframe - *Test*.

Then, these two dataframes - *Train* and *Test* are combined by rows, *Test* dataframe is appended at the end of *Train* dataframe in one collective dataframe - *Data*. The result dataframe has 10299 rows(observations) and 563 variables(subject id, 561 measure variables and activity code).

Next, names of the columns in dataframe *Data* are assigned. First column - *subjectid*, last column - *activity* and 561 measure columns are named accordingly to labels provided in *"features.txt"* file from supporting documentation files.

**2. Extract only the measurements on the mean and standard deviation for each measurement.**

*Data* dataframe is subsetted(using regular expression *"mean\\(\\)|std\\(\\)|subjectid|activity"*) into dataframe *dataTidy*. *DataTidy* dataframe is consist of columns containing mean() and std() in their names plus the *subjectid* column and *activity* column. The result dataframe has 10299 rows and 68 columns.

**3. Use descriptive activity names to name the activities in the data set.**

Coding of activities performed by subjects is available in *"activity_labels.txt"* file in *UCI HAR Dataset* folder. According data in this file and activity column in dataTidy, new variable(column) *activitydesc* is added to dataframe *dataTidy*, containing descriptive names of activities performed by observed subjects.

**4. Appropriately label the data set with descriptive activity names.** 

5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.



References:

1. UCI Machine Learning Repository. [Online] http://archive.ics.uci.edu/ml/.

2. Human Activity Recognition Using Smartphones Data Set . UCI Machine Learning Repository. [Online] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

3. Coursera: Data Analysis By Jeff Leek . Coursers. [Online] https://class.coursera.org/dataanalysis-002/class.

4. The R Project for Statistical Computing. [Online] http://www.r-project.org/.


