if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"./data/samsung.zip") #download zip file from given url
downloadDate<-date()
downloadDate    #Data downloaded "Thu Apr 24 11:42:46 2014"
unzip("./data/samsung.zip",exdir="./data")      # Unzip zip file in Data Folder

# 1. Merges the training and the test sets to create one data set
#read data in Train folder
subjectTrain<-read.table("./data/UCI HAR Dataset/Train/subject_train.txt") #read Subject data - subjectTrain dataframe
head(subjectTrain)
dim(subjectTrain)       # 7352 rows 1 variable - subject ID
xTrain<-read.table("./data/UCI HAR Dataset/Train/X_train.txt")  #read X_train data - xTrain dataframe
head(xTrain)
dim(xTrain)     #7352 rows 561 variables - measures
yTrain<-read.table("./data/UCI HAR Dataset/Train/y_train.txt")     #read y_train data - yTrain dataframe
head(yTrain)
dim(yTrain)     #7352 rows 1 variable - activity
# combine all three train dataframes by columns in Train dataframe subject_ID-measures-activity
Train<-cbind(subjectTrain,xTrain,yTrain)
head(Train)
dim(Train)      #7352 rows 563 variables

#read data in Test folder
subjectTest<-read.table("./data/UCI HAR Dataset/Test/subject_test.txt") #read Subject data - subjectTest dataframe
head(subjectTest)
dim(subjectTest)       # 2947 rows 1 variable - subject ID
xTest<-read.table("./data/UCI HAR Dataset/Test/X_test.txt")  #read X_test data - xTest dataframe
head(xTest)
dim(xTest)     #2947 rows 561 variables - measures
yTest<-read.table("./data/UCI HAR Dataset/Test/y_test.txt")     #read y_test data - yTest dataframe
head(yTest)
dim(yTest)     #2947 rows 1 variable - activity
# combine all three test dataframes by columns in Test dataframe subject_ID-measures-activity
Test<-cbind(subjectTest,xTest,yTest)
head(Test)
dim(Test)      #2947 rows 563 variables

#append train and test data sets - combine them by rows in big dataframe Data
Data<-rbind(Train,Test)
head(Data,n=3)
dim(Data)       #10299 rows 563 variables
str(Data)

#read the features.txt  file with labels for the measures from UCI HAR Dataset folder
labels<-read.table("./data/UCI HAR Dataset/features.txt")
head(labels)
dim(labels)     #561 rows 2 variables(second is the label of measures)

#rename the columns in Data dataframe
names(Data)[1]<-"SubjectID"
names(Data)[563]<-"Activity"
names(Data)[2:562]<-as.character(labels[,2])
names(Data)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#extract the measurements on the mean and standard deviation for each measurement plus SubjectID and activity column
#names(Data[,grepl("mean\\(\\)|std\\(\\)|SubjectID|Activity",names(Data),563)])
dataTidy<-Data[,grepl("mean\\(\\)|std\\(\\)|SubjectID|Activity",names(Data))]
head(dataTidy,n=3)
dim(dataTidy)        #10299 rows 68 variables means and standard deviations plus SubjectID and activity


# 3.Uses descriptive activity names to name the activities in the data set
# Read activity_labels.txt file from UCI HAR Dataset Folder
activityLabels<-read.table("./Data/UCI HAR Dataset/activity_labels.txt")
dataTidy$activitydesc<-rep(NA,nrow(dataTidy))             #generating new variable(populating with NAs) activitydesc which will store the activity labels
for (i in 1:length(activityLabels[,2])) {                       #assigning the activity labels to activitydesc variable
dataTidy$activitydesc[dataTidy$Activity==i]<-as.character(activityLabels[i,2])
}
dataTidy$activitydesc<-as.character(dataTidy$activitydesc)        #transforming the variable into factor 

# 4. Appropriately label the data set with descriptive column names
#clean the names of the variables in dataTidy dataframe
anyDuplicated(names(dataTidy))       #There are not duplicates names in the columns in the dataframe
#eliminate the special characters in labels like (,),- e.t.c
names(dataTidy) <- gsub("\\(", "", names(dataTidy))
names(dataTidy) <- gsub("\\)", "", names(dataTidy))
names(dataTidy) <-gsub("-","",names(dataTidy))
#all lower case in the labels
names(dataTidy)<-tolower(names(dataTidy))
write.table(dataTidy,"./Data/samsungTidy.txt", row.names = FALSE)       #save the dataframe-tidy data as a text file 

#5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(reshape2)
idVars<-c("activity","activitydesc","subjectid")        #define the vector of ID variables
measures<-names(dataTidy)[2:67]                         #define the vector of measured variables
melted<-melt(dataTidy,idVars,measure.vars=measures)     #melt dataTidy dataframe into form suitable for casting
Tidy<-dcast(melted, activitydesc + subjectid ~ variable, mean)          #recast mealted data computing avarage of measures
write.table(Tidy,"./Data/Tidy.txt" ,row.names = FALSE)   #save the dataframe of averaged measures by activity and subject into txt file
