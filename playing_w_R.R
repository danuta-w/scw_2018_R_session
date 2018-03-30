getwd()
setwd("C:/Users/au235508/scw_2018/intro_R/")
setwd("~/scw_2018/intro_R/")
# everything after hashtag will be ignored

cats <- 10 # cats <- 9
cats - 9

# avoid these variable names: c, C, F, t, T, S

# 6 main Data types (classes) are:
# characters 'agsfde', "agedse"
# integers
# complex
# logical
# numeric
# raw

# to examine features of these objects we can use: 
class(cats)
typeof(cats)

# Integer
i <- 2L
j <- 2
class(i)
class(j)
typeof(i)
typeof(j)

# complex
k <- 1 + 4i
class(k)

# logical
TRUE 
FALSE

# Data Structures -  4 main types
# atomic vector - all elements are of the same data types, 1D
# list - all different data types allowed, 1D
# matrix - all elements are of the same data types, multidimensional
# dataframe - all different data types, multidimensional, each column is a vector

# atomic vector:
logical_vector <- c(TRUE,TRUE,FALSE,FALSE)
class(logical_vector)
char_vector <- c("Lori","Upendra","Chris")
class(char_vector)
length(char_vector)
anyNA(char_vector)

mixed <- c(TRUE, "True") # type cohersion - turns it all into character - type hierarchy: character > complex > numeric > integer > logical
mixed
class(mixed)
anothermixed <- c("Stanford",FALSE, 2L, 3.14)
class(anothermixed)

# list
mylist <- list(chars = 'coffee', nums = c(1.4,5), logicals = TRUE, anotherlist = list(a='a',b=22))

# indexing
char_vector[2]
mylist[2]
class(mylist)
str(mylist) # to see the structure of a data structure
# mylist[3] vs. mylist$logicals - the first will give us the name of the list element and its value, the second gives the value only

# matrix
m <- matrix(nrow = 2, ncol = 3)
class(m)
m <- matrix(data = 1:6, nrow=2, ncol=3) # by default it fills it in column-wise
m <- matrix(data = 1:6, nrow=2, ncol=3, byrow=TRUE)

# Dataframes - like a table in Matlab
df <- data.frame(id=letters[1:10], x=1:10, y=11:20) # also columnwise by default
str(df)
class(df)
typeof(df)
head(df)
tail(df)
dim(df)
names(df) # column names
summary(df)

# factor
state <- factor(c("Arizona","California","Mass"))
state <- factor(c("AZ","CA","CA"))
state
nlevels(state)
levels(state)

ratings <- factor(c("low","high","medium","low")) # no hierarchy
ratings
r <- c("low","high","medium","low")
ratings <- factor(r)
ratings <- factor(r, levels=c("low","medium","high"), ordered = TRUE) # to add hierarchy
ratings
min(ratings)

survey <- data.frame(number=c(1,2,2,1,2), group=c("A","B","A","A","B"))
str(survey)
ndf <- data.frame(Day=1:5, Magnification=c(2,10,5,2,5), Observation=c("Growth","Death","No Change","Death","Growth"))
ndf

Day = 1:5
Magnification = c(2,10,5,2,5) 
Observation = c("Growth","Death","No Change","Death","Growth")
ndf2 <- data.frame(Day, Magnification, Observation)

# Import in Data
gapminder <- read.csv("gapminder-FiveYearData.csv") # use tab to complete!
class(gapminder)
dim(gapminder)
head(gapminder)
str(gapminder)
View(gapminder)
gapminder$country
gapminder[,1]
gapminder[3,2]
gapminder[7,]
gapminder[10:15,5:6]
gapminder[10:15,c("lifeExp","gdpPercap")]
gapminder[gapminder$country=='Gabon',]

#install.packages("dplyr")
#library(dplyr)

# this is a pipe %>%

# Best from dplyr:
# select for columns
# filter for rows
# group_by
# summarise
# mutate - to add new columns etc.
# arrange

select(gapminder,lifeExp, gdpPercap)
gapminder %>% select(lifeExp, gdpPercap)
gapminder %>% filter(lifeExp>71)

gapminder %>% 
  select(year, country, gdpPercap) %>% 
  filter(country == 'Mexico') %>% 
  head()

Mexico <- gapminder %>% 
  select(year, country, gdpPercap) %>% 
  filter(country == 'Mexico')

View(Mexico)

# order matters
neweurope <- gapminder %>% 
  filter(continent=="Europe" & year>1980) %>% 
  select(country, gdpPercap, year)
View(neweurope)

totalGDP <- gapminder %>% 
  group_by(country) %>% 
  filter(continent=="Europe" & year>1980) %>% 
  select(country, gdpPercap) %>% 
  summarise(total = sum(gdpPercap))
View(totalGDP)

# Use of group_by, summarise and arrange
gapminder %>% group_by(country) %>% tally()
# tally counts

gapminder %>% group_by(country) %>% summarise(avg = mean(pop), std = sd(pop), total = n())

gapminder %>% group_by(country) %>% summarise(avg = mean(pop), std = sd(pop), total = n()) %>% arrange(avg)

gapminder %>% group_by(country) %>% summarise(avg = mean(pop), std = sd(pop), total = n()) %>% arrange(desc(avg))

# Mutate
gapminder_mod <- gapminder

gapminder_mod %>% mutate(gdp = pop * gdpPercap) %>% head()
gapminder_mod <- gapminder_mod %>% mutate(gdp = pop * gdpPercap) %>% head()

gapminder %>% group_by(country) %>% summarise(avglifeExp = mean(lifeExp)) %>% arrange(avglifeExp) %>% head(1)
gapminder %>% group_by(country) %>% summarise(avglifeExp = mean(lifeExp)) %>% arrange(desc(avglifeExp)) %>% head(1)

gapminder %>% group_by(country) %>% summarise(avglifeExp = mean(lifeExp)) %>% arrange(avglifeExp) %>% tail(1)
gapminder %>% group_by(country) %>% summarise(avglifeExp = mean(lifeExp)) %>% filter(avglifeExp==max(avglifeExp) | avglifeExp==min(avglifeExp))


## library(tidyverse)
# base R plotting
plot(gapminder_mod$gdpPercap,gapminder_mod$lifeExp)

# ggplot2 - three components: data, aestetics, geom (i.e. type of plot: scatter, bar etc.)
# library(ggplot2)

ggplot(gapminder_mod, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point()

# log10 conversion
ggplot(gapminder_mod, aes(x=log10(gdpPercap), y=lifeExp)) + 
  geom_point()

# transparency
ggplot(gapminder_mod, aes(x=log10(gdpPercap), y=lifeExp)) + 
  geom_point(alpha = 1/3, size = 3)

summary(gapminder) #for a quick look at the data

# adding color by continent
p <- ggplot(gapminder_mod, aes(x=log10(gdpPercap), y=lifeExp, color = continent)) + 
  geom_point()
p
p <- p + facet_wrap(~continent) # to split by continent
p
p2 <- p + geom_smooth(color = "orange")
p2

# Combine dplyr with ggplot2
gapminder_mod %>% ggplot(aes(gdpPercap,lifeExp)) + geom_point()

gapminder %>% mutate(gdp = pop * gdpPercap) %>% ggplot(aes(gdp,lifeExp)) + geom_point()
gapminder %>% ggplot(aes(gdpPercap)) + geom_histogram()

p3 <- gapminder %>% ggplot(aes(lifeExp, fill=continent)) + geom_histogram(binwidth = 1) + ggtitle("Histogram_gapminder")
p3

# saving plots
ggsave(p3, file = "histogram_lifeExp.png")

?ggplot2 # to get help

# line plot
gapminder_mod %>% 
  filter(country == "Afghanistan") %>% 
  ggplot(aes(x = year, y = lifeExp)) + geom_line(color = "blue")

# 2. Plot lifeExp against year...
p4 <- gapminder_mod %>% ggplot(aes(year,lifeExp)) + geom_point()
p4 <- p4 + facet_wrap(~continent)
p4 <- p4 + geom_smooth(color="orange") # but I can specify what model should be used for smoothing
p4

p5 <- gapminder_mod %>% ggplot(aes(year,lifeExp)) + geom_point() + facet_wrap(~continent) + geom_smooth(color="orange", lwd = 2, se = FALSE)
p6 <- p5 + geom_smooth(color="blue", lwd = 1, se = FALSE, method = "lm")
p6
ggsave(p6, file="LifeExp_by_year_lm_vs_loess.png")

# density plot
ggplot(gapminder_mod, aes(gdpPercap, lifeExp)) + geom_point(size = 1) + geom_density_2d() + scale_x_log10()


# Combine plots
# install.packages("gridExtra")
# library(gridEXtra)
gridExtra::grid.arrange(
  p5 <- ggplot(gapminder_mod,aes(year,lifeExp)) + geom_point() + facet_wrap(~continent) + geom_smooth(color="orange", lwd = 2, se = FALSE),
  p7 <- ggplot(gapminder_mod, aes(gdpPercap, lifeExp)) + geom_point(size = 1) + geom_density_2d() + scale_x_log10())


# loops
gapminder_mod %>% filter(continent == "Asia") %>% 
  summarise(avg = mean(lifeExp))

gapminder_mod %>% group_by(continent,year) %>% summarise(avg = mean(lifeExp))


contin <- unique(gapminder_mod$continent)
contin

# loops
for (c in contin) {
  # print(c)
  for (y in unique(gapminder_mod$year)){
  res <- gapminder %>% filter(continent == c) %>% summarise(avg = mean(lifeExp))
  print(paste0("The avg life expectancy of ", c, " in year ", y, " is: ", res)) # like string concatenation or [] in matlab
  }
  # print(res)
}

# Functions
adder <- function(x,y){
  print(paste0("The sum of ",x, " and ", y, " is: ",x+y))
  # return(x + y)
}
adder(2,3)
