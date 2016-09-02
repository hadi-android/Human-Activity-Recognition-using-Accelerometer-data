rm(list=ls(all=T))
library(caret)
library(e1071)

data_tr = read.csv("pml-training.csv",header=T)
data_tr = data_tr[,-which(data_tr[1,]=="")]
data_tr = data_tr[,-which(is.na(data_tr[1,]))]

data_te = read.csv("pml-testing.csv", header=T)
data_te = data_te[,-which(is.na(data_te[1,]))]

data_tr=data_tr[,-c(1:7)]
data_te=data_te[,-c(1:7)]

str(data_tr, list.len=ncol(data_tr))
str(data_te, list.len=ncol(data_te))

ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)
rfmodel2 = train(data_tr$classe ~., data = data_tr, method = "rf", verbose = FALSE, trControl=ctrl)
pred = predict(rfmodel2,data_te[,-53])
