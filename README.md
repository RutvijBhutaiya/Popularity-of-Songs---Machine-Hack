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

2. Data file -  with 






