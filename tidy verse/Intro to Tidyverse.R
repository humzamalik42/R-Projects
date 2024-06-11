setwd("/Users/hp/Documents/Tidyverse")
install.packages('ROCR')
install.packages('gapminder')
install.packages('dplyr')


library(ROCR)
library(gapminder)
library(dplyr)

gapminder  #loads gapminder dataset


#FILTER VERB -- extracting a subset of data from entire dataset
gapminder %>%
  filter(year == 2007)

gapminder %>%
  filter(country == "United States")

gapminder %>%
  filter(year == 2007, country == "United States")


#ARRANGE VERB -- sorts in ascending or descending order based on one of its variables
#helpful in finding extreme values i.e., date range
gapminder %>%
  arrange(gdpPercap)    #gdpPercap in ascending order

gapminder %>%
  arrange(desc(gdpPercap))  #gdpPercap in descending order

gapminder %>%
  filter(year == 2007) %>%
  arrange(desc(gdpPercap))  #gdpPercap in descending order in 2007


#MUTATE VERB -- changes or adds new variables
gapminder %>%
  mutate(pop = pop/1000000) %>%
  arrange(desc(pop))

gapminder %>%
  mutate(gdp = gdpPercap * pop) %>%
  filter(year == 2007) %>%
  arrange(desc(gdp))


#VISUALIZING WITH GGPLOT2

#Variable Assignment
gapminder_2007 <- gapminder %>%
  filter(year == 2007)  #creating a subset of data -- this subset of data will be used
                        #for visualizing

gapminder_2007

install.packages('caret')
library(caret)
install.packages('ggplot2')
library(ggplot2)

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + geom_point()  #this will create a scatterplot with gdppercap on x axis and lifeExp on y axis


#LOG SCALES
#Used because the distribution of one of the variables could span several orders of magnitude
#log scale: each fixed distance represents a multiplication of the value
#each unit on x axis represents 10 times the x axis value
#you can easily distinguish countires on either end of the spectrum and the relationship between variables also becomes more clear

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + geom_point() + scale_x_log10() #x axis will be on the log10 scale (each unit on x axis multiplied by 10)


#ADDITIONAL AESTHETICS
#Good way to represent categorical variables in scatterplot is to use color
#Good way to represent numerical variables in scatterplot is to increase the size of the point
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) + geom_point() + scale_x_log10()   #continent is a categorical variable so we color it

#FACETING
#you can get a subplot for each of the continents -- this is faceting
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) + geom_point() + scale_x_log10() + facet_wrap(~ continent) # ~ means 'by'

#SUMMARIZE VERB -- turns many rows into one
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))
  
#GROUP BY VERB -- turns groups into one row each
gapminder %>%
  group_by(year, continent) %>%   #one row for each combination of continent and year
  summarize(meanLifeExp = mean(lifeExp),  #meanLifeExp is a new column
            totalPop = sum(pop))    #totalPop is a new column


#VISUALIZING SUMMARIZED DATA
by_year_continent <- gapminder %>%   #instead of viewing the summarized data as a table like before, save it as a variable like this 
  group_by(year, continent) %>%   
  summarize(meanLifeExp = mean(lifeExp), 
            totalPop = sum(pop)) 

by_year_continent

install.packages('caret')
library(caret)
install.packages('ggplot2')
library(ggplot2)

ggplot(by_year_continent, aes(x = year, y = totalPop, color = continent)) + geom_point() + expand_limits(y = 0)   #this allows y axis to start from 0

#Line plots -- good for showing change over time
#Histograms & Bar Charts -- good for showing statistics of different categories
#Boxplot -- good for showing the distribution of numeric variables across several categories

#LINE PLOT
ggplot(year_continent, aes(x = year, y = meanLifeExp, color = continent)) + geom_line() + expand_limits(y = 0) 

#BARPLOT
ggplot(by_continent, aes(x = continent, y = meanLifeExp)) + geom_col() #creates a bar for every continent showing mean life exp on y axis

#HISTOGRAM
ggplot(gapminder_2007, aes(x = lifeExp)) + geom_histogram() #number of countries (frequency) on the y axis and lifeExp on x axis 

#BOXPLOT
ggplot(gapminder_2007, aes(x = continent, y = lifeExp)) + geom_boxplot()
#the black line in the middle of the box is the median life exp of each continent
#the top and bottom of the box represent the 25th and 75th percentile which means that half the distribution lies within this box
#dots represent outliers






