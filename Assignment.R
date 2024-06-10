install.packages("caret")
install.packages("ggplot2")
library("ggplot2")
library(caret)
library(e1071)
install.packages("corrplot")
library(corrplot)


arrest_data <- read.csv("/Users/hp/Documents/Winter Term/Big Data/Individual Assignment/arrest data 2.csv")
arrest_data
arrest_data_cor = cor(arrest_data)
corrplot(arrest_data_cor)
set.seed(111)
train.index <- sample(c(1:dim(arrest_data)[1]),dim(arrest_data)[1]*0.6)
train.df <- arrest_data[train.index,]
valid.df <- arrest_data[-train.index,]


glm.out = glm(arrest ~ fin + age + race + wexp + mar + paro + low_prior + medium_prior + high_prior + low_edu + med_edu + high_edu + low_employed + medium_employed + high_employed, family = binomial(logit), data = train.df)
summary(glm.out)

fitprob <- predict(glm.out,valid.df,type = "response")
validation <- cbind(valid.df,fitprob)
validation

prediction1 <- ifelse(fitprob >0.1,1,0)
prediction1
prediction2 <- ifelse(fitprob>0.2,1,0)
prediction2
prediction3 <- ifelse(fitprob>0.3,1,0)
prediction3
prediction4 <- ifelse(fitprob>0.4,1,0)
prediction4
prediction5 <- ifelse(fitprob>0.5,1,0)
prediction5
prediction6 <- ifelse(fitprob>0.6,1,0)
prediction6
prediction7 <- ifelse(fitprob>0.7,1,0)
prediction7
prediction8 <- ifelse(fitprob>0.8,1,0)
prediction8
prediction9 <- ifelse(fitprob>0.9,1,0)

predictions <- cbind(fitprob,prediction1,prediction2,prediction3,prediction4,prediction5,prediction6,prediction7,prediction8,prediction9)
predicted1 <- factor(prediction1)
actual <- factor(valid.df$arrest)
confusion_matrix <- confusionMatrix(data = predicted1, reference = actual, positive = '1')
confusion_matrix

predobj = prediction(fitprob,actual)
rocobj = performance(predobj, measure = 'tpr', x.measure = 'fpr')
plot(rocobj)
plot(rocobj, colorize=TRUE)
plot(rocobj, colorize=TRUE, print.cutoffs.at=seq(0,1,0.1), text.adj=c(-0.2,1.7))
install.packages("prediction")
library(ROCR)
install.packages('ROCR')
library(ROCR)

aucobj=performance(predobj,measure="auc")
auc_ROCR=performance(predobj,measure="auc")
auc_ROCR<-auc_ROCR@y.values[[1]]
auc_ROCR




