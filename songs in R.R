
### POPULARITY OF SONGS ###

songs = read.csv('Data_train.csv')

# Data Structure

summary(songs)

str(songs)
head(songs)

## Convert likes and popularity to Numeric

songs$Likes = as.numeric(songs$Likes)
songs$Popularity = as.numeric(songs$Popularity)



# Missing Values

colSums(is.na(songs))



### EXPLORATERY DATA ANALYSIS ###


# Identify Uniques values in data
# UNiques entries : Name, Genre

unique_name = unique(songs$Name)
length(unique_name)

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

## Origin Artist country is same - Remove country feature

songs = songs[, -4]
attach(songs)


## Correlation Study 1: Views, Comments, Likes, Popularity, Followers
## Correlation Study 2: Views, Day, Month, Year, Hour, Min, Sec

library(ggcorrplot)
library(corrplot)
library(RColorBrewer)


Corr1 = corrplot(cor(songs[, c(5,6,7,8,9)]), type = 'upper', order = 'hclust',
                 col = brewer.pal(n=5, name = 'YlGnBu')) 

Corr2 = corrplot(cor(songs[, c(5,10,11,12,13,14,15)]), type = 'upper', order = 'hclust',
                col = brewer.pal(n=7, name = 'YlOrBr')) 

# Sec_Stamp and Hour_stamp and Min_Stamp has high correlaition 


## Pivot table analysis

library(rpivotTable)

rpivotTable(songs)

##
# Highest Likes to Names: LIL UZI VERT, Kodak Black and Future 
# Highest Likes to Genre: all Music, danceedm 
# Highest Likes in a Year: 2025 2016 2017
# Highest Likes in a month: March and December
# Highest Likes on a day: 15th, 16th, 17th, 26th
# Highest Likes for an hour: 0th hour Mindnight - 18th, 19th, 22nd (Evening)
# Highest Likes for a min: Starting of an hour 0,1,2,3,etc. 
# Highest Likes for a sec: Starting of a sec 0,1,2,3,etc.


## Outliers Study


boxplot(Comments, main = 'Comments', col = 'coral')
boxplot(Likes, main = 'Likes', col = 'coral')
boxplot(Popularity, main = 'Popularity', col = 'coral')
boxplot(Followers, main = 'Followers', col = 'coral')


quantile(Comments, 0.97)

quantile(Followers,0.95)


## Remove Outliers based on 97% quantile range: for Comments and less than 20 comments

songs = songs[which(Comments > 20  & Comments <= 686 &
                                    Followers <= 216585), ]

#songs = songs[which(Comments <= 686 & Comments > 0 &
#                      Followers <= 2165852), ]


attach(songs)                    

## Data Discribution : Histogram

hist(Comments)


library(forecast)

songs$Comments = log(songs$Comments)

attach(songs)

BoxCox.lambda(Comments)
attach(songs)

## Remove Extreem Outlier from Comments Feature

#songs = songs[-c(54240,18714,58783,8896), ]
#attach(songs)

# boxplot(Comments, main = 'Comments', col = 'coral')


## NOTES:
# Oultiers exisits in Comments and Followers
# Due to High Correlation between Views and Comments we decided not to remove Outliers.
# But We removed one extreem outlier. 
# Due to Low correlation between Views and Followers 
# We analysized Highest followers are with Future - and that is the outliers. But can't remove the Genre 


## Plot regression charts

plot(Comments, Likes, main = 'Comments & Likes', col  = 'coral', abline(lm(Likes~Comments)))
plot(Popularity, Likes, main = 'Popularity & Likes', col  = 'coral', abline(lm(Likes~Popularity)))


#write.csv(songs, 'songs_clean.csv')


write.csv(songs, 'songs_clean_outliers.csv')




