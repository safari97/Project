# Getting and Cleaning Data: Course Project
## Code book 

#### Subject
The volunteers who participated in this experiment are called "subject". There were 30 subjects, numbering from 1 to 30.

#### Activity
There are six types of physical activities that the subjects have performed and whose data collected: 

* walking
* walkingupstairs
* walkingdownstairs
* sitting
* standing
* laying

### How to Decipher the Feature Names
There are 66 features in this data sets.  Each of the feature names consists of several part, each of which has certain physical/mathematical meanings, explained below. 

t: time domain signals   
f: frequency domain singals through Fast Fourier Transformation (FFT) 
Body: body of the subject, for example, body's linear acceleration and angular velocity   
Gravity: gravity  
Acc: acceleration
Gyro: angular velocity  
Jerk: jerk signal
Mag: magnitude  
Mean: mean value
Std: standard deviation
X/Y/Z: direction of acceleration or angular velocity

Any features that have "Mag" are scalar therefore have no X/Y/Z term. 

For example, "tBodyAccMeanX" means the average of body acceleration in X direction in time domain. 

#### List of Features
tBodyAccMeanX  
tBodyAccMeanY  
tBodyAccMeanZ  
tBodyAccStdX  
tBodyAccStdY  
tBodyAccStdZ  
tGravityAccMeanX  
tGravityAccMeanY  
tGravityAccMeanZ  
tGravityAccStdX  
tGravityAccStdY  
tGravityAccStdZ  
tBodyAccJerkMeanX  
tBodyAccJerkMeanY  
tBodyAccJerkMeanZ  
tBodyAccJerkStdX  
tBodyAccJerkStdY  
tBodyAccJerkStdZ        
tBodyGyroMeanX  
tBodyGyroMeanY  
tBodyGyroMeanZ  
tBodyGyroStdX           
tBodyGyroStdY  
tBodyGyroStdZ  
tBodyGyroJerkMeanX  
tBodyGyroJerkMeanY  
tBodyGyroJerkMeanZ  
tBodyGyroJerkStdX  
tBodyGyroJerkStdY  
tBodyGyroJerkStdZ       
tBodyAccMagMean  
tBodyAccMagStd  
tGravityAccMagMean  
tGravityAccMagStd  
tBodyAccJerkMagMean  
tBodyAccJerkMagStd  
tBodyGyroMagMean  
tBodyGyroMagStd         
tBodyGyroJerkMagMean  
tBodyGyroJerkMagStd  
fBodyAccMeanX   
fBodyAccMeanY           
fBodyAccMeanZ  
fBodyAccStdX  
fBodyAccStdY  
fBodyAccStdZ            
fBodyAccJerkMeanX  
fBodyAccJerkMeanY  
fBodyAccJerkMeanZ  
fBodyAccJerkStdX        
fBodyAccJerkStdY  
fBodyAccJerkStdZ  
fBodyGyroMeanX  
fBodyGyroMeanY          
fBodyGyroMeanZ  
fBodyGyroStdX  
fBodyGyroStdY  
fBodyGyroStdZ           
fBodyAccMagMean   
fBodyAccMagStd  
fBodyBodyAccJerkMagMean  
fBodyBodyAccJerkMagStd  
fBodyBodyGyroMagMean  
fBodyBodyGyroMagStd  
fBodyBodyGyroJerkMagMean  
fBodyBodyGyroJerkMagStd  
