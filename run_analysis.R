
#Load plyr, used for the join function
library(plyr)

#Set Dataset Path relative to the workind directory
datasetPath <- 'UCI HAR Dataset'

#Set FilePaths - Note that there is a 'train' and a 'test' subdirectories
featuresFilename <- file.path(datasetPath, 'features.txt')
labelFilename <- file.path(datasetPath, 'activity_labels.txt')
trainLabelFilename <- file.path(datasetPath, 'train/y_train.txt')
trainSetFilename <- file.path(datasetPath, 'train/x_train.txt')
trainSubjectFilename <- file.path(datasetPath, 'train/subject_train.txt')
testLabelFilename <- file.path(datasetPath, 'test/y_test.txt')
testSetFilename <- file.path(datasetPath, 'test/x_test.txt')
testSubjectFilename <- file.path(datasetPath, 'test/subject_test.txt')

#Read Features and add 'labels' and 'subject'
#to the beggining of the list
features <- read.table(featuresFilename)
features <- features[2]
colnames(features) <-'features'
features <- rbind(data.frame(features=c('labels','subject')),features)

#Read Labels
labels <- read.table(labelFilename)

#Create trainData dataframe with Train Labels, Train Subjects and Train DataSet
trainData<-cbind(read.table(trainLabelFilename),read.table(trainSubjectFilename),read.table(trainSetFilename))

#Create testData dataframe with Test Labels, Test Subjects and Test DataSet
testData<-cbind(read.table(testLabelFilename),read.table(testSubjectFilename),read.table(testSetFilename))

#Remove Paths from memory
rm(datasetPath,featuresFilename,labelFilename,trainLabelFilename,trainSetFilename,trainSubjectFilename)
rm(testLabelFilename,testSetFilename,testSubjectFilename)

#Create completeData by joining trainData and testData
#and remove them from memory
completeData<-join(trainData,testData)
rm(trainData,testData)

#Name the columns of completeData using the loaded Features
#and remove it from memory
names(completeData)<-features[1:563,]
rm(features)

#Factor completeData with loaded Labels and remove it from memory
completeData$labels <- factor(completeData$labels, levels=labels[,1], labels=labels[,2])
rm(labels)

#useCol wil list the indexes of the columns of completeData we will use
#initialize useCol with 1 and 2 as they we wil keep
#both 'labels' and 'subjects' columns
useCol<-c(1,2)

#For all the remaining columns in completeData, check if they contain
#'mean' or 'std' and, if so, add them to useCol
for (i in 3:length(completeData)){
    if(length(grep('mean',names(completeData)[i]))==1){        
        useCol<-append(useCol,i)        
    }else if(length(grep('std',names(completeData)[i]))==1){
        useCol<-append(useCol,i)        
    }
}

#Set partialData a subset of completeData with the useCol columns
partialData<-completeData[,useCol]

#remove completeData and useCol
rm(completeData,useCol)

#split partialData by subject.labels and assign to splitData
splitData<-split(partialData,list(partialData$subject,partialData$labels))

#generate final tidyData with the mean of every variable of splitData
tidyData<-sapply(splitData, function(x) colMeans(x[3:length(names(partialData))]))

#remove splitData and partialData
rm(splitData,partialData)

#write tidyData as a csv to tidyData.csv
write.csv(tidyData, file="./tidyData.csv")

#remove tidyData
rm(tidyData)