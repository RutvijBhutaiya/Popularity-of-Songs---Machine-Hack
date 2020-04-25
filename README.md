# Popularity of Songs - Machine-Hack

### Chartbusters Prediction : Foretell The Popularity Of Songs - Machine Hack. Intresting study based on dataset from famous songs popularity predictions since 1973 

<p align="center"><img width=75% src=https://user-images.githubusercontent.com/44467789/75104030-a16acb80-5629-11ea-97d3-92044801a57a.jpg>
  
                                                    Rod Hunt Illustrator


<br>

## Table of Content

- [Objective](#objective)
- [Approach](#approach)
- [Study Dataset Creation](#study-dataset-creation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Feature Analysis](#feature-analysis)
- [Regression Model](#regression-model)
-

<br>


## Objective

Build a prediction algorithm to Predict the views of songs based on the given features like, Songs Name, Songs launch time and date, Followers, Popularity etc. 

<br>

## Approach

- Download the data from [Machine Hack](https://www.machinehack.com/course/chartbusters-prediction-foretell-the-popularity-of-songs/)
- Data Cleaning and EDA
- Prediction model with outliers - study
- Prediction model without outliers - study
- 

<br>

## Data Cleaning and EDA (Exploratory Data Analysis)

For EDA we used Tableau for analysis and data visualization on raw train dataset - [Data_train](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/Data_Train.csv). 


#### Genre wise Views and Followers

<p align="center"><img width=90% src=https://user-images.githubusercontent.com/44467789/75223283-1c6be780-57cc-11ea-9438-7e23bf3914b9.png>
  
As we can see from the Bar chart, the highest number of Views are to Future, Major Lazer and Monstercat. However, Mad Decent, Steve Akoi and MixMag have highest followers. 
Hence, we can say that high followers do not mean high views.  

<br>

#### Year Wise Comparision

<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/75223563-be8bcf80-57cc-11ea-97d2-81bdd1be4b07.png>
  
As we can see in the line chart, popularity and likes are continuously increasing. However, Views has seen a slight decline since 2016. This could be due to followers, as we can also notice the decline in followers from 2015-16. 

One thing in common we have noticed that from the year 2011, al the variables are increasing with good delta. Hence, which also leads to more Views.  


<br>
  
#### Year wise Genre Views  
  
<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/75327507-85be2a00-58a2-11ea-85b4-a3044936a1af.png>   
  
As we can see in the above line chart from the tableau, for Genre, Views for danceedm has increased rapidly in 2014-15 and followed with rapid decline in 2016-18.  

For analysis, we removed allmusic from the Genre list due to biases. Also, we excluded 2019 from the chart due to data available for only a few months of the 2019 year. 

One interesting this we identified, is that rock music was the only player till 2000. So, we can assume that all the music creativity comes after or we have data for all other Genre after 2000. 

<br>

#### Word Chart for Song Names

<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/75328541-34af3580-58a4-11ea-81e4-1a91d8e84f75.png>
  
WOrd char is an interesting way to show the hidden art in the features. In the above-mentioned chart, Fonts indicates a number of Views and Green to red shade indicates a number of followers from high to low. 

As we can see that LIL UZI VERT is the most viewed song, but has one of the least followers. Similarly, Mad Decent has low viewership but one of the highest followers. 

<br>

#### Scatter Plot Views vs.  Likes, Followers, Popularity, Comments

<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/75329598-db480600-58a5-11ea-9483-92c90beb3d67.png>
  
As we can see in the above scatter plot with respect to Genre. We can clearly identify allmusic and some marks on danceedm. 

However, we can also see the skewness on COmments and Followers. 

<br>

#### Box Plot - Outliers

<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/75329772-4560ab00-58a6-11ea-9692-3ff7264cf571.png>
  
Last last Tableau analysis we have compared time with respect to outliers at time 00:00:00.

As we can see, the stamp on songs has 00:00 for minute and seconds  it is obvious that most of the songs launched at 00:00. But, we can also see the many songs were launched at midnight 00 hours. 
                       
<br>


## Feature Analysis 

In Feature analysis and data cleaning, we did few experiments with data. In this experiments we created 4 diffrent train datasets from main [data_train.csv](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/Data_Train.csv) file. 

We came with an idea that we don't only need clean and perfect data to run the models. We also wanted the domain view befor we clean data. Hence, we decided to crat 4 diffrent datasets and build models and check the accuracy on all the diffrent train dataset.

From the dataset structure, Genre and Songs_name are factors. 

1. Data file - with clean data but with outliers and without factor encoding - [songs_clean.csv](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/songs_clean.csv)

2. Data file -  without outilers and without factor encoding - [songs_clean_outliers.csv](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/songs_clean_outliers.csv)

3. Data file - with outliers and without factor encoding - [songs_dummy_encode.csv](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/songs_clean_outliers.csv)

4. Dat file - without outliers and with factor encoding - [songs_clean_outliers_with_dummy_Encoding.csv](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/songs_clean_outliers_with_dummy_Encoder.csv)

After that we begin our study with converting Likes and Populatity features into numeric, and we also checked missing values, if any. 

```
## Convert likes and popularity to Numeric

songs$Likes = as.numeric(songs$Likes)
songs$Popularity = as.numeric(songs$Popularity)

# Missing Values

colSums(is.na(songs))
```

The important and one of the significant feature is Timestamp. And hence, we extracted the details into date and time formate with diffrent feature creation,

```
# Timestamp Feature Expantion
## Create Seperate Feature for Day, Month, Year, Hour, Min, Sec 

songs$Day_Stamp = format(as.POSIXct(strptime(songs$Timestamp, "%Y-%m-%d %H:%M:%S", tz="")), 
                   format = "%d")

songs$Month_Stamp = format(as.POSIXct(strptime(songs$Timestamp, "%Y-%m-%d %H:%M:%S", tz="")), 
                         format = "%m")

songs$Year_Stamp = format(as.POSIXct(strptime(songs$Timestamp, "%Y-%m-%d %H:%M:%S", tz="")), 
                         format = "%Y")

songs$Hour_Stamp = format(as.POSIXct(strptime(songs$Timestamp, "%Y-%m-%d %H:%M:%S", tz="")), 
                         format = "%H")

songs$Min_Stamp = format(as.POSIXct(strptime(songs$Timestamp, "%Y-%m-%d %H:%M:%S", tz="")), 
                         format = "%M")

songs$Sec_Stamp = format(as.POSIXct(strptime(songs$Timestamp, "%Y-%m-%d %H:%M:%S", tz="")), 
                         format = "%S")

attach(songs)

songs = songs[ ,-6]

# Convert Char into numbers

songs$Day_Stamp = as.numeric(songs$Day_Stamp)
songs$Month_Stamp = as.numeric(songs$Month_Stamp)
songs$Year_Stamp = as.numeric(songs$Year_Stamp)
songs$Hour_Stamp = as.numeric(songs$Hour_Stamp)
songs$Min_Stamp = as.numeric(songs$Min_Stamp)
songs$Sec_Stamp = as.numeric(songs$Sec_Stamp)

```

In the following chart we have shown Correlation plot - Plot 1 gives correlation view for independent variables like, Views, Followers etc and Plot 2 gives correlation view for independent variables with respect to time like, Yesr_Stamp, Min_Stamp etc. 


<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/76192685-690de480-6208-11ea-9d86-9263a020e2a8.png>
                                              Corr Plot 1
                                                       
  
<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/76192687-6c08d500-6208-11ea-987a-f8d1ae01b9ee.png>
                                              Corr Plot 2
  
Similarly, we did analysis for variables with the use of rpivotTable. And found the following points. This points represents, the highest numbers of likes (target var) for partucular features. 

- #### Highest Likes to Names: LIL UZI VERT, Kodak Black and Future 
- #### Highest Likes to Genre: all Music, danceedm 
- #### Highest Likes in a Year: 2025 2016 2017
- #### Highest Likes in a month: March and December
- #### Highest Likes on a day: 15th, 16th, 17th, 26th
- #### Highest Likes for an hour: 0th hour Mindnight - 18th, 19th, 22nd (Evening)
- #### Highest Likes for a min: Starting of an hour 0,1,2,3,etc. 
- #### Highest Likes for a sec: Starting of a sec 0,1,2,3,etc.
                                                     
#### Outliers Study

Following box plot share the outliers, 

<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/76193326-c22a4800-6209-11ea-836f-4a059fb80ca5.png>
  
Features like, Comments and Followers variables carries outliers, However, as mentioned earlier, we already put dataset seperate to do a study on the data. 

And in following study, we removed the outliers and created new dataset for diffrent study. 

```
quantile(Comments, 0.97)

quantile(Followers,0.95)


## Remove Outliers based on 97% quantile range: for Comments and less than 20 comments

songs = songs[which(Comments > 20  & Comments <= 686 &
                                    Followers <= 216585), ]                     
```

Along with outliers we also studied skewness in the data,

Follwoing chart mentions Befor and After normalization for comments data distribution. Highly right skewed, due to '0' comments. 

<p align="center"><img width=85% src=https://user-images.githubusercontent.com/44467789/76194421-1fbf9400-620c-11ea-9747-878d83282faa.png>

```
library(forecast)

songs$Comments = log(songs$Comments)

attach(songs)

BoxCox.lambda(Comments)
attach(songs)

```

<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/76193729-a6737180-620a-11ea-99ec-b6e2f9619dd9.png>


Now, for factor variables Songs_name we decided to do factor encoding and for Genre we did one hot encoding. 

Again for this also, we vreated diffrent dataset to study. Hence, we also uploadted the same.

```
## Create dummy variables for feature : Genre

Genre.matrix = model.matrix(~ songs$Genre -1, data = songs)

songs = data.frame(songs, Genre.matrix)

songs = songs[, -3]

attach(songs)


## Label Encode for :Name

library(CatEncoders)

# Remove SOngs_name

songs = songs[, -3]
attach(songs)

factors = names(which(sapply(songs, is.factor)))

for (i in factors){
  encode <- LabelEncoder.fit(songs[, i])
  songs[, i] <- transform(encode, songs[, i])
}

attach(songs)

```

<br>

## Regression Model

As we mentioned in the Feature Analysis we did collected results from four diffrent datasets. The purpose of the study was, Is it only to achive low RSME or High RSquared - even if one need to compromise on important data observations. Or was it only to achive better score in terms of RSME or RSquared only. 

Interestingly we found followinf, doing the study. 

```
## Ridge & Lassos ##

#data = read.csv('songs_clean.csv')
#data = read.csv('songs_clean_outliers.csv')
#data = read.csv('songs_dummy_encode.csv')
#data = read.csv('songs_clean_outliers_with_dummy_Encoder.csv')
```

For Code on Regression - [Click here](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/Linear%20Ridge%20Lassos%20Regression.R)

<br>

## XGBoost Model






