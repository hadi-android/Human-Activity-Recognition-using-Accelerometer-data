# clear all variables
rm(list=ls(all=T))

#add required libraries
library(caret)
library(e1071)

#read training set
data_tr = read.csv("pml-training.csv",header=T)

#remove NA and "" columns
data_tr = data_tr[,-which(data_tr[1,]=="")]
data_tr = data_tr[,-which(is.na(data_tr[1,]))]

#read testing set
data_te = read.csv("pml-testing.csv", header=T)

#remove NA columns
data_te = data_te[,-which(is.na(data_te[1,]))]

#remove non-relevant columns
data_tr=data_tr[,-c(1:7)]
data_te=data_te[,-c(1:7)]

#check if the columns for bot data sets are the same
str(data_tr, list.len=ncol(data_tr))
str(data_te, list.len=ncol(data_te))

# set up a 10-fold cross validation
ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)

#train using random forests and using all features
rfmodel2 = train(data_tr$classe ~., data = data_tr, method = "rf", verbose = FALSE, trControl=ctrl)

#predict class from testing set using the newly obtained model
pred = predict(rfmodel2,data_te[,-53])
