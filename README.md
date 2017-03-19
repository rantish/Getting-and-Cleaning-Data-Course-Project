You should create one R script called run_analysis.R that does the following.

1.Merges the training and the test sets to create one data set.

The files that were used to load data are listed as follows:

subject_test.txt
X_test.txt
y_test.txt
subject_train.txt
X_train.txt
y_train.txt

Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
Names of Varibles Features come from “features.txt”
levels of Varible Activity come from “activity_labels.txt”

=====================================================================================================================
=====================================================================================================================
2.Extracts only the measurements on the mean and standard deviation for each measurement.

After Merging all datsets the script uses  wild card pattern matching to search for mean and sd variables by 
joining with the features dataset :-

FeaturesNames<-Features_Names$V2[grep("mean\\(\\)|std\\(\\)", Features_Names$V2)]

Subsetting is then done and relevant rows retained
=====================================================================================================================
=====================================================================================================================
3.Uses descriptive activity names to name the activities in the data set

Here I have utilised activity_labels.txt to assign activity levels  to my final dataset onbtained from Step 2 above.
=====================================================================================================================
=====================================================================================================================
4.Appropriately labels the data set with descriptive variable names.

#- prefix t  is replaced by  time
#- Acc is replaced by Accelerometer
#- Gyro is replaced by Gyroscope
#- prefix f is replaced by frequency
#- Mag is replaced by Magnitude
#- BodyBody is replaced by Body

=====================================================================================================================
=====================================================================================================================
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

UPLOADED the dataset to the repo.
=====================================================================================================================
=====================================================================================================================
