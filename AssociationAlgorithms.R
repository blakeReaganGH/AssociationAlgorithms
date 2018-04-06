
#                           1.2.1
#1
lastfm <- read.table(file = "lastfm.csv", header = T, sep=",")

#2
dim(table(lastfm$user)) 
dim(table(lastfm$artist)) 
dim(table(lastfm$country))

#3
#records <- lastfm[0]
#4
lastfm$user <- as.factor(lastfm$user)
#5

library(arules)
library(arulesViz)

playlist <- split(x=lastfm[,"artist"],f=lastfm$user)
playlist <- lapply(playlist,unique)
playlist[1:2];
playlist <- as(playlist,"transactions")
playlist

#                                 1.2.2
#1
sort(itemFrequency(playlist), decreasing = FALSE)

#2
graphics.off()
itemFrequencyPlot(playlist,support=.1, horiz=TRUE)
#3
#3

itemsets <- apriori(playlist, parameter=list( target="frequent itemsets"))
summary(itemsets)
data(itemsets)
#4
rules <- apriori(lastfm, parameter=list(minlen=1,support=0.001682, confidence = 0.4,target="rules"))
summary(rules) 
graphics.off()
plot(rules)
plot(rules@quality)
plot(rules@quality$lift)
plot(rules@quality$confidence)

#5
highLiftRules <- head(sort(rules, by="lift"), 5)
inspect(highLiftRules)

#6
highconfRule <- head(sort(rules, by="confidence"), 1)
inspect(highconfRule)