
#Load plyr, used for the join function
library(plyr)

#Set FilePaths
featuresFilename <- file.path('UCI HAR Dataset', 'features.txt')

features <- read.table(featuresFilename)
features<-features[2]
colnames(features)<-'features'
features<-rbind(data.frame(features=c('labels','subject')),features)

labelFilename <- file.path('UCI HAR Dataset', 'activity_labels.txt')
labels <- read.table(labelFilename)

trainLabelFilename <- file.path('UCI HAR Dataset', 'train/y_train.txt')
trainLabels <- read.table(trainLabelFilename)

trainSetFilename <- file.path('UCI HAR Dataset', 'train/x_train.txt')
trainSet <- read.table(trainSetFilename)

trainSubjectFilename <- file.path('UCI HAR Dataset', 'train/subject_train.txt')
trainSubject <- read.table(trainSubjectFilename)

trainData<-cbind(trainLabels,trainSubject,trainSet)

testLabelFilename <- file.path('UCI HAR Dataset', 'test/y_test.txt')
testLabels <- read.table(testLabelFilename)

testSetFilename <- file.path('UCI HAR Dataset', 'test/x_test.txt')
testSet <- read.table(testSetFilename)

testSubjectFilename <- file.path('UCI HAR Dataset', 'test/subject_test.txt')
testSubject <- read.table(testSubjectFilename)

testData<-cbind(testLabels,testSubject,testSet)

completeData<-join(trainData,testData)
names(completeData)<-features[1:563,]
completeData$labels <- factor(completeData$labels, levels=labels[,1], labels=labels[,2])

useCol<-c(1,2)
for (i in 3:563){
    if(length(grep('mean',names(completeData)[i]))==1){        
        useCol<-append(useCol,i)        
    }else if(length(grep('std',names(completeData)[i]))==1){
        useCol<-append(useCol,i)        
    }
}
tidyData<-completeData[,useCol]

##tidyData$labels <- factor(tidyData$labels, levels=labels[,1], labels=labels[,2])

splitData<-split(tidyData,list(tidyData$subject,tidyData$labels))
##length(names(tidyData))
finalData<-sapply(splitData, function(x) colMeans(x[3:length(names(tidyData))]))
write.csv(finalData, file="./tidydata.csv")