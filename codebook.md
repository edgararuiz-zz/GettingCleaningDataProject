---
title: "Code Book"
author: "Edgar Ruiz"
date: "September 22, 2015"
output: html_document
---

##Variables
There are **69 variables total**. The first three variables are the ones we used to aggregate the data by:

1. **Suject** - Contains the ID of the subject who performed the activity
2. **ActivityName** - The specific activity in words performed by the subject
3. **Activity** - ID of the Activity

**The name of each of the remaining 66 variables is formatted in a way that is easy to read**.  The name is divided 6 parts maximum.  Each part is evident by either a capital letter or a dash.  The combination of 2 or 3 possible values for each part makes up all the combinations for the 66 names in the data set.  Here are the parts and the order in which they would appear:

1. Time or Fourier 
2. Body or Gravity 
3. Acceleration or Gyroscope 
4. Jerk  
5. Magnitude 
6. -Mean or -StdDeviation
7. -X, Y or Z 

Part 5 and 7 are mutually exclusive, so if there variable refers to a Magnitude, there will be no X,Y or Z part. A couple of combinations are: **TimeBodyGyroscopeJerkMagnitude-Mean** and **FourierBodyAccelerationJerk-Mean-X**

For a full list of all the variables, please see **Appendix A1** below.

As far as the **units of measurement for this data set**, they are derived from the original train and test data sets, in which they have been normalized and bounded within -1,1.  

##Data

This data set is the combination of 8 different files:

1. x_test.txt
2. y_test.txt
3. subjext_text.txt
4. x_train.txt
5. y_train.txt
6. subject_train.txt
7. features.txt
8. activity_labels

These data contain activity readings captured by a smartphone from 30 volunteers.  These volunteers performed 6 activities.  The volunteers ID and the activity name are found in this data set, under Subject and ActivityName respectively.

For more background information about the experiment, please refer to a copy of the Original_README.txt and Features.txt files found in the same repository as this code book.



##Transformation goals
All of the transformations were in pursuit of achieving the assignments goals which are as follows:

* Merge the test and train data set
* Keep only the measurements for mean and standard deviation
* Use the activity name for the summarization
* Variable names are labeled appropriately
* Create a data set with the average for each activity and subject

Additionally, I had a couple of objectives to accomplish with the code:

* Programmatically identify the measure variables (mean and standard deviation)
* If possible, programmatically create the user-friendly header names 

##Transformations

Here are the transformations done and their purpose:

* Selected only the rows containing "mean" or "std" from the features.txt file. I used the 'grepl' command.  This will serve for 2 purposes, the first is to obtain the indexes of the variables that will be extracted from the test and train data sets and second, to create the vector containing the headers of the final data set.
```
features.needed <- features.table[grepl("mean\\(",features.table$V2)|grepl("std\\(",features.table$V2) ,]
```
* Capturing the vector indexes for the variables that will be extracted from train and test
```
needed.vector <- as.vector(features.needed$V1)
```
* Using the 'gsub' command, expanded the name of each of the variable names that were used.  Appended to the end the 'Subject' and 'Activity' header names
```
needed.names <- gsub("Jerk", "Jerk", needed.names)
needed.names <- gsub("Mag", "Magnitude", needed.names)
#...Excerpt, there are 9 more needed.names lines of code prior to the above 2
data.headers <- c(needed.names,"Subject","Activity")
```
* Read and loaded into their own variables the following: activity labels, X_test, y_text and subject _test
* Selected the variables enumerated in 'needed.vector' 
* Merged with the subject and activity data sets
* Added the Activity Name from the Activity Labels file
* Renamed the columns to user-friendly names (data.headers)
* Repeated the previous 4 steps of this process with the train data
* Using the 'cbind' command (merged) the train and test data sets into one
* Summarized the new data set by Subject and Activity Name


##Apendix A

###A1 - Full Variable List

Index  | Variable Name
------ | -------------
1|Subject
2|ActivityName
3|Activity
4|TimeBodyAcceleration-Mean-X
5|TimeBodyAcceleration-Mean-Y
6|TimeBodyAcceleration-Mean-Z
7|TimeBodyAcceleration-StdDeviation-X
8|TimeBodyAcceleration-StdDeviation-Y
9|TimeBodyAcceleration-StdDeviation-Z
10|TimeGravityAcceleration-Mean-X
11|TimeGravityAcceleration-Mean-Y
12|TimeGravityAcceleration-Mean-Z
13|TimeGravityAcceleration-StdDeviation-X
14|TimeGravityAcceleration-StdDeviation-Y
15|TimeGravityAcceleration-StdDeviation-Z
16|TimeBodyAccelerationJerk-Mean-X
17|TimeBodyAccelerationJerk-Mean-Y
18|TimeBodyAccelerationJerk-Mean-Z
19|TimeBodyAccelerationJerk-StdDeviation-X
20|TimeBodyAccelerationJerk-StdDeviation-Y
21|TimeBodyAccelerationJerk-StdDeviation-Z
22|TimeBodyGyroscope-Mean-X
23|TimeBodyGyroscope-Mean-Y
24|TimeBodyGyroscope-Mean-Z
25|TimeBodyGyroscope-StdDeviation-X
26|TimeBodyGyroscope-StdDeviation-Y
27|TimeBodyGyroscope-StdDeviation-Z
28|TimeBodyGyroscopeJerk-Mean-X
29|TimeBodyGyroscopeJerk-Mean-Y
30|TimeBodyGyroscopeJerk-Mean-Z
31|TimeBodyGyroscopeJerk-StdDeviation-X
32|TimeBodyGyroscopeJerk-StdDeviation-Y
33|TimeBodyGyroscopeJerk-StdDeviation-Z
34|TimeBodyAccelerationMagnitude-Mean
35|TimeBodyAccelerationMagnitude-StdDeviation
36|TimeGravityAccelerationMagnitude-Mean
37|TimeGravityAccelerationMagnitude-StdDeviation
38|TimeBodyAccelerationJerkMagnitude-Mean
39|TimeBodyAccelerationJerkMagnitude-StdDeviation
40|TimeBodyGyroscopeMagnitude-Mean
41|TimeBodyGyroscopeMagnitude-StdDeviation
42|TimeBodyGyroscopeJerkMagnitude-Mean
43|TimeBodyGyroscopeJerkMagnitude-StdDeviation
44|FourierBodyAcceleration-Mean-X
45|FourierBodyAcceleration-Mean-Y
46|FourierBodyAcceleration-Mean-Z
47|FourierBodyAcceleration-StdDeviation-X
48|FourierBodyAcceleration-StdDeviation-Y
49|FourierBodyAcceleration-StdDeviation-Z
50|FourierBodyAccelerationJerk-Mean-X
51|FourierBodyAccelerationJerk-Mean-Y
52|FourierBodyAccelerationJerk-Mean-Z
53|FourierBodyAccelerationJerk-StdDeviation-X
54|FourierBodyAccelerationJerk-StdDeviation-Y
55|FourierBodyAccelerationJerk-StdDeviation-Z
56|FourierBodyGyroscope-Mean-X
57|FourierBodyGyroscope-Mean-Y
58|FourierBodyGyroscope-Mean-Z
59|FourierBodyGyroscope-StdDeviation-X
60|FourierBodyGyroscope-StdDeviation-Y
61|FourierBodyGyroscope-StdDeviation-Z
62|FourierBodyAccelerationMagnitude-Mean
63|FourierBodyAccelerationMagnitude-StdDeviation
64|FourierBodyAccelerationJerkMagnitude-Mean
65|FourierBodyAccelerationJerkMagnitude-StdDeviation
66|FourierBodyGyroscopeMagnitude-Mean
67|FourierBodyGyroscopeMagnitude-StdDeviation
68|FourierBodyGyroscopeJerkMagnitude-Mean
69|FourierBodyGyroscopeJerkMagnitude-StdDeviation

