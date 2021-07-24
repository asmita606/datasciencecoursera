rm(list = ls())

dir<-"UCI HAR Dataset/"

dir.train<-"UCI HAR Dataset/train/" ## train data directory

dir.test<-"UCI HAR Dataset/test/"   ## test data directory


X_train<-read.table(paste0(dir.train,"X_train.txt")) ## Reading train X
y_train<-read.table(paste0(dir.train,"y_train.txt"))[,1] ## Reading train y
subject_train<-read.table(paste0(dir.train,"subject_train.txt"))[,1] ## Subjects train


X_test<-read.table(paste0(dir.test,"X_test.txt")) ## Reading test X
y_test<-read.table(paste0(dir.test,"y_test.txt"))[,1] ## Reading test y
subject_test<-read.table(paste0(dir.test,"subject_test.txt"))[,1] ## Subjects test

## Merging Test and Train

MergedData<-rbind(X_train,X_test)
MergedData$Y<-as.factor(c(y_train,y_test))
MergedData$Subjects<-as.factor(c(subject_train,subject_test))

feature.names<-read.table(paste0(dir,"features.txt"))[,2] ## Feature Names

## measurements on the mean and standard deviation
index<-grep("[mM]ean|[sS]td",feature.names) 


# Extracting only the measurements on the mean 
# and standard deviation for each measurement. 

ExtDat<-MergedData[,c(index,ncol(MergedData)-1,ncol(MergedData))]


# Appropriately labelling the data set with descriptive variable names.
names(ExtDat)[1:(ncol(ExtDat)-2)]<-feature.names[index]


# Using descriptive activity names to name the activities in the data set
names(ExtDat)[ncol(ExtDat)-1]<-"labels"
activity_labels<-read.table(paste0(dir,"activity_labels.txt"))
activity_labels$V1<-as.factor(activity_labels$V1)

library(dplyr)
data<-merge(ExtDat,activity_labels,by.x="labels",by.y="V1",all=TRUE)
names(data)[ncol(data)]<-"activity names"
data$`activity names`<-as.factor(data$`activity names`)

data<-data[,-which(colnames(data)=="labels")] ## getting rid of additional column

# tidy data set with the average of each variable for each activity and each subject
tidydata<-data %>% group_by(`activity names`,Subjects) %>% summarise_if(is.numeric, mean, na.rm = TRUE)

write.table(tidydata,file="tidy data set.txt")

