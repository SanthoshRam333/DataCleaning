set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5), ] ; X$var2[c(1,3)] = NA
X


#subsetting

X[1] #column

X[1,] #row

X[,1] #column

X[, "var1"] #column

X[1:2, "var2"]

X[(X$var1 <= 3 & X$var3 > 11),]

X[(X$var1 <=3 & X$var3 >15), ]

X[which(X$var2 > 8), ]


#sorting

sort(X$var1)

sort(X$var1, decreasing = T)

sort(X$var2, na.last = T)


#ordering

X[order(X$var1), ]

X[order(X$var1, X$var3), ]


#ordering with plyr

arrange(X, var1)

arrange(X, desc(var1))


#adding rows and columns

X$var4 <- rnorm(5)
X

Y <- cbind(X, rnorm(5))
Y


#summarizing data

restaurantData <- read.csv('Restaurants.csv')
head(restaurantData, n = 3)
tail(restaurantData, n = 3)

summary(restaurantData)

str(restaurantData)

quantile(restaurantData$cncldst, na.rm = T)

quantile(restaurantData$cncldst, probs = c(0.4, 0.65, 0.9))

table(restaurantData$zipcode, useNA = "ifany")

table(restaurantData$cncldst, restaurantData$zipcode)

sum(is.na(restaurantData$cncldst))

any(is.na(restaurantData$cncldst))

all(restaurantData$zipcode > 0)

colSums(is.na(restaurantData))

all(colSums(is.na(restaurantData))==0)

table(restaurantData$zipcode %in% c("21212"))

table(restaurantData$zipcode %in% c("21212", "21213"))

restaurantData[restaurantData$zipcode %in% c("21212", "21213"), ]


#cross tabs

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)

crosstab <- xtabs(Freq ~ Gender + Admit, data = DF)
crosstab

warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)
xt

#flat tables 

ftable(xt)


#size of a dataset

fakedata = rnorm(1e5)
object.size(fakedata)

print(object.size(fakedata), units = "Mb")


#creating sequences

s1 <- seq(1, 10, by = 2) ; s1

s2 <- seq(1, 10, length = 3) ; s2

x <- c(1, 3, 8, 25, 100) ; seq(along = x)


#subsetting variables

restaurantData$nearMe = restaurantData$nghbrhd %in% c("Roland Park", "Homeland")
table(restaurantData$nearMe)


#creating binary variables

restaurantData$zipWrong = ifelse(restaurantData$zipcode < 0, T, F)
table(restaurantData$zipWrong, restaurantData$zipcode < 0)


#creating categorical variables

restaurantData$zipGroups = cut(restaurantData$zipcode, breaks = quantile(restaurantData$zipcode))
table(restaurantData$zipGroups)
table(restaurantData$zipGroups, restaurantData$zipcode)

#easier cutting

restaurantData$zipGroups = cut2(restaurantData$zipcode, g = 1)
table(restaurantData$zipGroups)

#creating factor variables

restaurantData$zcf <- factor(restaurantData$zipcode)
restaurantData$zcf[1:10]

class(restaurantData$zcf)


#levels o factor variables 

yesno <- sample(c("yes", "no"), size = 10, replace = T)
yesnofac = factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")

as.numeric(yesnofac)


#using mutate function

library(Hmisc) ; library(plyr)
restaurantData2 = mutate(restaurantData, zipGroups = cut2(zipcode, g = 4))
table(restaurantData2$zipGroups)

















