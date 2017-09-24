if (!require("data.table")) {
        
        install.packages("data.table")
        
}

##read the data that would be used
testLabel<-read.table('./UCI HAR Dataset/test/y_test.txt')
testSet<-read.table('./UCI HAR Dataset/test/X_test.txt')
trainLabel<-read.table('./UCI HAR Dataset/train/y_train.txt')
trainSet<- read.table('./UCI HAR Dataset/train/X_train.txt')

##read features for futrher nameing
features<-read.table('./UCI HAR Dataset/features.txt')

##read activity for futher label
activity<-read.table('./UCI HAR Dataset/activity_labels.txt')

##read subject for further label
subject_train<-read.table('./UCI HAR Dataset/train/subject_train.txt')
subject_test<-read.table('./UCI HAR Dataset/test/subject_test.txt')

##create test and train data table for further merge.
train<-data.table(label=trainLabel,Set=trainSet)
test<-data.table(label=testLabel,Set=testSet)

##merge the two sets
data<-rbind(train,test)

##get the index to extract the colums we need
extraindex<-grep('mean|std',features[,2])+1

##extract only the measurements on the mean and standard deviation for each measurement
data2<-data[,c(1,extraindex),with=FALSE]

##Appropriately labels the dataset with descriptive variable names.
names(data2)<-c('Label',as.vector(features[,2]))[c(1,extraindex)]
names(activity)<-c('Label','activity')

##Uses descriptive to name the activities in the dataset
data2<-merge(activity,data2,by='Label')

##label the dataset
data2<-cbind(subject,data2)

##remove duplicate
data2<-data2[!duplicated(data2),]

data2<-as.data.table(data2)

##create a sub table
data_mean<-data2[,lapply(.SD,mean),by=.(Label,subject,activity)]

##write data table
write.table(data2,file='./data2.txt',row.names = FALSE)
