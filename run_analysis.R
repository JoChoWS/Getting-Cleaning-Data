library(dplyr)
library(data.table)

zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(zipURL, ".data/UCI")

# Zip file was opened manually as I could not get unzip() to work

setwd("~.//data//Irvine")


# Read in the data 

X_train <- read.table(".//X_train.txt", header = FALSE)
X_test <- read.table(".//X_test.txt", header = FALSE)
y_train <- read.table(".//y_train.txt", header = FALSE)
y_test <- read.table(".//y_test.txt", header = FALSE)

features <- read.table(".//features.txt", header = FALSE)
act_labels <- read.table(".//activity_labels.txt", header = FALSE)

subject_train <- read.table(".//subject_train.txt", header = FALSE)
subject_test <- read.table(".//subject_test.txt", header = FALSE)


#Merge the training and test data into one data frame

train <- data.frame(y_train, subject_train, X_train)
test <- data.frame(y_test, subject_test, X_test)

train_test <- rbind(train, test)


#Label the merged test and training data

setnames(train_test, c("Subject", "Activity", as.vector(features[,2])))


#Extract only measurements of mean and std for each element

MeanStd <- grep("Subject|Activity|mean|std", names(train_test))
valuesOnly <- data.frame(train_test[ ,MeanStd])


#Label the activities data with descriptive variable names rather than codes

valuesOnly[,2] <- act_labels[match(valuesOnly[,2], act_labels[,1]),2] 


#Tidy the data by removing improper symbols, and typos (e.g. "BodyBody")

setnames(valuesOnly, colnames(valuesOnly), gsub("\\(\\)", "", colnames(valuesOnly)))
setnames(valuesOnly, colnames(valuesOnly), gsub("-", "_", colnames(valuesOnly)))
setnames(valuesOnly, colnames(valuesOnly), gsub("BodyBody", "Body", colnames(valuesOnly)))


#Create an independent tidy dataset with the average of each variable
#for each activity and subject

tidy_data <- valuesOnly %>% group_by(Subject,Activity) %>%
                            summarise_each(funs(mean)) %>%
                            arrange(Subject,Activity)

write.table(tidy_data, file = ".\\tidy_data.txt", row.names=F)


