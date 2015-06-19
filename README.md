# Getting and Cleaning Data: Course Project

## The Experimental Setup
The experiments have been carried out with a group of 30 volunteers (so called "subjects") within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, and LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

## What's in the Data
The data include the original (or raw) movement data collected by the Samsung smartphone and the processed data using predescribed methods. 
70% of the the subjects was selected as the training set and the remaining 30% was used as the test set. 

There are 4 text files and 2 folders. 
The 4 files are: 

* README.txt
* features.txt
* features_info.txt
* activity_labels.txt

The 2 folders are: 

* train
* test

In either of the folders, there are 3 text files. There is also one folder containing the original data, which is not used in this project. 

## How My Code Work
### Loading Data
Data from 8 files were loaded into R. 
Three files for the training set:

1. X_train.txt. This is the processed data on the training set
2. subject.txt. This is the subject IDs for the training set, 21 integers from 1 through 30. 
3. y_train.txt. This is the activity IDs for the training set, ranging 1 through 6. 

Three files for the test set: 

4. X_train.txt. This is the processed data on the training set
5. subject.txt. This is the subject IDs for the training set, 9 integers from 1 through 30. 
6. y_train.txt. This is the activity IDs for the training set, ranging 1 through 6. 

7. features.txt. This is names for all features, and will be used to identify data in X. 
8. activity_labels.txt. This is names for the 6 activites, and corresponds to the activity IDs. 

Function used: read.table(). 
The arguments were file names with or without path, depending on where the file was.

For example, for files on the top level of the folder,  

      features <- read.table('features.txt');  
for files in a nested folder, 
      
      dataTrain <- read.table('./train/X_train.txt)  

The resulted eight variables are described below:

* dataTrain: a 7352 by 561 data frame, containing processed data; 
* dataTest: a 2947 by 561 data frame; containing processed data; 
* subjectTrain: a 7352 by 1 data frame; containing subject IDs to conrresponding rows in dataTrain
* subjectTest: a 2947 by 1 data frame; containing subject IDs to corresponding rows in dataTest
* activityTrain: a 7352 by 1 data frame, containing activity IDs to corresponding rows in dataTrain
* activityTest: a 2947 by 1 data frame, containing activity IDs to corresponding rows in dataTest
* features: a 561 by 2 data frame, whose second column contains features names corresponding to the columns in dataTrain and dataTest. 
* activities: a 6 by 2 data frame, matching activity IDs to meaningful description such as "WALKING"

### Merging Data
We needed to combine training data with test data. We also needed to match subject IDs and activity IDs with actual data. It didn't matter which task we took on first. In my script I merged train data with test data first using three rbind() function calls, and resulted in three variables that combined data from both training set and test set:

* data (dataTrain and dataTest combined)
* subject (subjectTrain and subjectTest combined)
* activity (activityTrain and activityTest combined)

Next a cbind() merged data, subject and activity into one, and saved back to data:

    data <- cbind(subject,activity,data)  

Optional: to save the original information of which rows were from training set and which data were from test set, we could create one column that has values of either "training" or "test", and add that to data. (lines 38-42)

### Rename Columns
While performing the row binding, before column binding, the subject column and activity column were manually named: 

    names(activity) <- 'Activity'  
    names(subject) <- 'Subject'  

The feature names were imported from the second column in the variable, features:  

    names(data) <- features[,2]   
  
### Convert Activity IDs to Descriptive Words
Activities names were converted to lowercase and the underscores "_" were removed. 

    activities[,2] <- gsub('_','',activities[,2])    
    activities[,2] <- tolower(activities[,2])
    
Then a tiny function was built that will convert an integer to its corresponding activity name, based on the relation stored in the variable, activties. 

    fx1 <- function(x) {activities[x,2]}   

The relation was: 

    1 - walking   
    2 - walkingupstairs  
    3 - walkingdownstairs  
    4 - sitting  
    5 - standing  
    6 - laying  

Then an sapply() converted all 10299 activity IDs into descriptive activity names:

    activity <- sapply(activity, fx1)   

### Extract Features That Have mean() or std() 
The function grep() was used to find the column indices of features that either contains words "mean()" or "std()". 

I did it in one line by using regular expression and escape sequence for the parenthesis:  

    colindex <- grep('(.*mean\\()|(.*std\\()',names(data))   
  
This find 66 features. 

Once I had the indices a subset of the data was cut and saved to the variable "MeanSTD":

    MeanStd <- data[,c(1:2,colindex)]  
Be sure not to forget the first two columns, $Subject and $Activity. 

### Strip Special Characters in the Feature Names
This step, I think, was optional too. I'd like to remove the pairs of parentheses and replace the dash "-" with an underscore "_". The function gsub was used. Again backslashes were used for escape sequences. 

    names(MeanStd) <- gsub('-mean\\(\\)','Mean',names(MeanStd))  
    names(MeanStd) <- gsub('-std\\(\\)','Std',names(MeanStd))  
    names(MeanStd) <- gsub('-','_',names(MeanStd))

### Calculate the average of each feature for each activity and each subject. 
The function aggregate() worked perfectly for this case. To avoid the excessively long line, a list was created that contains the Subject column and the Activity column:    

    bylist = list(Subject = MeanStd$Subject,Activity = MeanStd$Activity)  

Here is the aggregate() call on MeanStd with mean as the FUN:

    finaldata <- aggregate(MeanStd[,-1:-2], by = bylist, mean)   
    
Note that the first two columns were excluded from the argument. The result was saved to finaldata.

### Write the Final Tidy Data to a Text File
A simple write.table() did the job: 

    write.table(finaldata,file = 'finaldata.txt',row.names = FALSE)  
