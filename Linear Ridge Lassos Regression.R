

## Ridge & Lassos ##

data = read.csv('songs_clean.csv')
data = data[, -1]

attach(data)
str(data)

# Regression only support NUmuric values not charecter/factors

data = data[, -c(1,2,3,4)]
attach(data)


## Development and Validation Dataset

ind = sample(2, nrow(data), replace = T, prob= c(0.7,0.3))

dev = data[ind == 1,]
val = data[ind == 2,]

## CUstom COntro Parameter

library(caret)

custom  = trainControl(method = 'repeatedcv',
                       number = 10,
                       repeats = 5,
                       verboseIter = T)
## Linear Model

set.seed(1234)

lm = train(Views ~., data = dev,  method = 'lm', trcontrol = custom)

lm$results

summary(lm)

plot(lm$finalModel)


## Ridge Regression

library(glmnet)

set.seed(1234)

ridge = train(Views ~., data = dev,
              method = 'glmnet',
              tuneGrid =  expand.grid(alpha = 0, lambda = seq(0.00001,1,length = 5)),
              trcontrol = custom)

# Plot results
plot(ridge)

ridge

ridge$results

plot(varImp(ridge, scale = F))


## Lasso Regression

set.seed(1234)

lasso = train(Views ~., data = dev,
              method = 'glmnet',
              tuneGrid =  expand.grid(alpha = 1, lambda = seq(0.00001,1,length = 5)),
              trcontrol = custom)

plot(lasso)
plot(varImp(lasso, scale = T))


## Elastic Net Regression 

set.seed(1234)

enet = train(Views ~., data = dev,
             method = 'glmnet',
             tuneGrid =  expand.grid(alpha = seq(0,1, length = 10), lambda = seq(0.00001,0.2,length = 5)),
             trcontrol = custom)

plot(enet)


## Compare Models 

list = list(LinearModel = lm, Ridge = ridge, Lasso = lasso, ElasticNet = enet)
All_models = resamples(list)

summary(All_models)
bwplot(All_models)

xyplot(All_models, metric = 'RMSE')  # data is diffrenciating between 2 models


# Best MOdel alpha and Lambda values
enet$bestTune


## Prediction on Validation dataset

predict = predict(lm, val)
sqrt(mean((val$Views - predict)^2)) 

predict = predict(ridge, val)
sqrt(mean((val$Views - predict)^2)) 

predict = predict(lasso, val)
sqrt(mean((val$Views - predict)^2)) 

predict = predict(enet, val)
sqrt(mean((val$Views - predict)^2)) 

# NOTE : Ridge (L2) gives less RMSE





