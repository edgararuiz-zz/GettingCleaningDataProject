
# Loading Activity lookup table------------------------------------------------------------------------------
activity.labels <- read.table("activity_labels.txt")
colnames(activity.labels) <- c("Activity", "ActivityName")

# Identifying the 'mean' and 'std' column variables----------------------------------------------------------
features.table <- read.table("features.txt")
features.needed <- features.table[grepl("mean\\(",features.table$V2)|grepl("std\\(",features.table$V2) ,]
needed.vector <- as.vector(features.needed$V1)

# Creating the data headers----------------------------------------------------------------------------------
needed.names <- gsub("Acc", "Acceleration", features.needed$V2)
needed.names <- gsub("Gyro", "Gyroscope", needed.names)
needed.names <- gsub("BodyBody", "Body", needed.names)
needed.names <- gsub("tBody", "TimeBody", needed.names)
needed.names <- gsub("tGravity", "TimeGravity", needed.names)
needed.names <- gsub("fBody", "FourierBody", needed.names)
needed.names <- gsub("fGravity", "FourierGravity", needed.names)
needed.names <- gsub("mean\\(\\)", "Mean", needed.names)
needed.names <- gsub("std\\(\\)", "StdDeviation", needed.names)
needed.names <- gsub("Jerk", "Jerk", needed.names)
needed.names <- gsub("Mag", "Magnitude", needed.names)
data.headers <- c(needed.names,"Subject","Activity")

# Test dataset preparation-----------------------------------------------------------------------------------
data.test <- read.table("test/X_test.txt") 
needed.test <- data.test[,needed.vector]
data.test <- NULL
subject <- read.table("test/subject_test.txt") 
activity <- read.table("test/y_test.txt")
needed.test <- cbind(needed.test,subject,activity)
colnames(needed.test) <- data.headers
needed.test <- merge(needed.test, activity.labels)

# Train dataset preparation----------------------------------------------------------------------------------
data.train <- read.table("train/X_train.txt") 
needed.train <- data.train[,needed.vector]
data.train <- NULL
subject <- read.table("train/subject_train.txt") 
activity <- read.table("train/y_train.txt")
needed.train <- cbind(needed.train,subject,activity)
colnames(needed.train) <- data.headers
needed.train <- merge(needed.train, activity.labels)

# Merging test and train datasets----------------------------------------------------------------------------
needed.merged <- rbind(needed.train, needed.test)
needed.test <- NULL
needed.train <- NULL

# Creating and exporting the tidy data set ------------------------------------------------------------------
summary.mean <- aggregate(.~Subject+ActivityName, data=needed.merged, FUN="mean")
needed.merged <- NULL
write.table(summary.mean, file="run_analysis.txt", row.names = FALSE )
