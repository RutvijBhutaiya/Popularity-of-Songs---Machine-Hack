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

For EDA we used tableau for analysis and data visulization on raw train dataset - [Data_train](https://github.com/RutvijBhutaiya/Popularity-of-Songs-Machine-Hack/blob/master/Data_Train.csv). 


#### Genre wise Views and Followers

<p align="center"><img width=89% src=https://user-images.githubusercontent.com/44467789/75223283-1c6be780-57cc-11ea-9438-7e23bf3914b9.png>
  
As we can see the Bar chart, highest number of Views are to Future, Major Lazer and Monstercat. However, Mad Decent, Steve Akoi and MixMag has highest followers. 
Hence, we can say that high followers does not mean high views.  

<br>

#### Year Wise Comparision

<p align="center"><img width=89% src=https://user-images.githubusercontent.com/44467789/75223563-be8bcf80-57cc-11ea-97d2-81bdd1be4b07.png>
  
As we can see in the line chart, popularity and likes are continiously increasing. However, Views has seen slight decline since 2016. This could be due to followers, as we can also notice the decline on followers from 2015-16. 

One thing in common we have notices that from year 2011, al the variables are increasing with good delta. Hence, which also leads to more Views.  


<br>
  
#### Year wise Genre Views  
  
<p align="center"><img width=89% src=https://user-images.githubusercontent.com/44467789/75327507-85be2a00-58a2-11ea-85b4-a3044936a1af.png>   
  
As we can see in the above line chart from tableau, for Genre, Views for danceedm has increased rapidly in 2014-15 and followed with repid declient in 2016-18.  

For analysis we removed allmusic from the Genre list due to biaseness. Also, we excluded 2019 from the chart due to data avaliable for only few months of 2019 year. 

One intresting this we identified, is that rock music was the only player till 2000. So, we can assume that all the music creativity comes after or we have data for all other Genre after 2000. 




