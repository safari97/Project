# Course project for "Gettting and Cleaning Data" by Dr. Jeff Leek
# 
# Written by: Li Ding
# 2015-06-18

## Load data
# Load training set data
dataTrain <- read.table('./train/X_train.txt')
activityTrain <- read.table('./train/y_train.txt')
subjectTrain <- read.table('./train/subject_train.txt')

# Load test set data
dataTest <- read.table('./test/X_test.txt')
activityTest <- read.table('./test/y_test.txt')
subjectTest <- read.table('./test/subject_test.txt')

# Load the list of activities and the list of features
activities <- read.table('activity_labels.txt')
features <- read.table('features.txt')

# Stack training set data and test set data through row binding
# Modify column names
data <- rbind(dataTrain,dataTest)
names(data) <- features[,2]
activity <- rbind(activityTrain,activityTest)
names(activity) <- 'Activity'
subject <- rbind(subjectTrain,subjectTest)
names(subject) <- 'Subject'

data <- cbind(subject,activity,data)

# Convert to descriptive activity names
activities[,2] <- gsub('_','',activities[,2])
activities[,2] <- tolower(activities[,2])
fx1 <- function(x) {activities[x,2]}
data$Activity <- sapply(data$Activity, fx1)

# Combine columns 
#temp1 <- data.frame(TrainOrTest = rep('Train',dim(dataTrain)[1]))
#temp2 <- data.frame(TrainOrTest = rep('Test',dim(dataTest)[1]))
#temp <- rbind(temp1,temp2)
#data <- cbind(temp, data)

# Extract only mean and std columns
colindex <- grep('(.*mean\\())|(.*std\\()',names(data))
MeanStd <- data[,c(1:2,colindex)]

# Strip or replace special characters in the feature names
names(MeanStd) <- gsub('-mean\\(\\)','Mean',names(MeanStd))
names(MeanStd) <- gsub('-std\\(\\)','Std',names(MeanStd))
names(MeanStd) <- gsub('-','',names(MeanStd))

# Calculate average value for each subject_activity pair
bylist = list(Subject = MeanStd$Subject,Activity = MeanStd$Activity)
finaldata <- aggregate(MeanStd[,-1:-2], by = bylist, mean)

## Write the final data to a text file
write.table(finaldata,file = 'finaldata.txt',row.names = FALSE)
