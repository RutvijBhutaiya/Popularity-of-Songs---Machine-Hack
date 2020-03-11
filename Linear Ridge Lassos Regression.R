

## Ridge & Lassos ##

#data = read.csv('songs_clean.csv')
#data = read.csv('songs_clean_outliers.csv')
#data = read.csv('songs_dummy_encode.csv')
#data = read.csv('songs_clean_outliers_with_dummy_Encoder.csv')


data = data[, -1]

attach(data)
str(data)

# Regression only support NUmuric values not charecter/factors

data = data[, -c(1)]
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



## Store Results Model wise..

# songs_clean.csv file data

lm.songs.clean.csv = lm$results

ridge.songs.clean.csv = ridge$results

lasso.songs.clean.csv = lasso$results



# songs_clean_outliers.csv data

lm.songs_clean_outliers.csv = lm$results

ridge.songs_clean_outliers.csv = ridge$results

lasso.songs_clean_outliers.csv = lasso$results



# songs_dummy_encode.csv data

lm.songs_dummy_encode.csv = lm$results

ridge.songs_dummy_encode.csv = ridge$results

lasso.songs_dummy_encode.csv = lasso$results



# songs_clean_outliers_with_dummy_Encoder.csv data

lm.songs_clean_outliers_with_dummy_Encoder.csv = lm$results

ridge.songs_clean_outliers_with_dummy_Encoder.csv = ridge$results

lasso.songs_clean_outliers_with_dummy_Encoder.csv = lasso$results





##  Data Frame

RSME.dataframe = data.frame(lm.songs.clean.csv$RMSE,
                          lm.songs_clean_outliers.csv$RMSE,
                          lm.songs_dummy_encode.csv$RMSE, 
                          lm.songs_clean_outliers_with_dummy_Encoder.csv$RMSE,
                          ridge.songs.clean.csv$RMSE, 
                          ridge.songs_clean_outliers.csv$RMSE,
                          ridge.songs_dummy_encode.csv$RMSE, 
                          ridge.songs_clean_outliers_with_dummy_Encoder.csv$RMSE,
                          lasso.songs.clean.csv$RMSE, 
                          lasso.songs_clean_outliers.csv$RMSE,
                          lasso.songs_dummy_encode.csv$RMSE, 
                          lasso.songs_clean_outliers_with_dummy_Encoder.csv$RMSE)

names(RSME.dataframe) = c('LM Data 1 RMSE', 'LM Data 2 RMSE', 'LM Data 3 RMSE', 'LM Data 4 RMSE',
                        'Ridge Data 1 RMSE', 'Ridge Data 2 RMSE', 'Ridge Data 3 RMSE', 'Ridge Data 4 RMSE',
                        'Lasso Data 1 RMSE', 'Lasso Data 2 RMSE', 'Lasso Data 3 RMSE', 'Lasso Data 4 RMSE')


RSME.Final.Compare = t(RSME.dataframe)

RSME.Final.Compare = RSME.Final.Compare[, -c(2,3,4,5)]

View(RSME.Final.Compare)

barplot(RSME.Final.Compare, col = 'seagreen')

# NOTE:  Data 1: songs_clean, Data2: songs_clean_outliers, Data 3: songs_dummy_encode, Data 4: songs_clean_outliers_with_dummy_Encoder


    
     
Rsqrd.dataframe = data.frame(lm.songs.clean.csv$Rsquared,
                            lm.songs_clean_outliers.csv$Rsquared,
                            lm.songs_dummy_encode.csv$Rsquared, 
                            lm.songs_clean_outliers_with_dummy_Encoder.csv$Rsquared,
                            ridge.songs.clean.csv$Rsquared, 
                            ridge.songs_clean_outliers.csv$Rsquared,
                            ridge.songs_dummy_encode.csv$Rsquared, 
                            ridge.songs_clean_outliers_with_dummy_Encoder.csv$Rsquared,
                            lasso.songs.clean.csv$Rsquared, 
                            lasso.songs_clean_outliers.csv$Rsquared,
                            lasso.songs_dummy_encode.csv$Rsquared, 
                            lasso.songs_clean_outliers_with_dummy_Encoder.csv$Rsquared)

names(Rsqrd.dataframe) = c('LM Data 1 Rsquared', 'LM Data 2 Rsquared', 'LM Data 3 Rsquared', 'LM Data 4 Rsquared',
                          'Ridge Data 1 Rsquared', 'Ridge Data 2 Rsquared', 'Ridge Data 3 Rsquared', 'Ridge Data 4 Rsquared',
                          'Lasso Data 1 Rsquared', 'Lasso Data 2 Rsquared', 'Lasso Data 3 Rsquared', 'Lasso Data 4 Rsquared')


Rsquared.Final.Compare = t(Rsqrd.dataframe)

Rsquared.Final.Compare = Rsquared.Final.Compare[, -c(2,3,4,5)]              
                       


RSME_Rsquared.Final.Compare = data.frame(RSME.Final.Compare, Rsquared.Final.Compare)
                
                       
                       
                       