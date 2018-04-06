install.packages('rattle')
data(wine, package='rattle.data') 
library(rattle.data)

#wine_data = read.delim("wine.txt")
#head(wine)

# sapply(wine, is.numeric) <- this check for numeric values from dataset.
#1.1 

wine
wine.scale <- scale(wine[-1])
wine.scale

#1.2

 #(a)
 set.seed(1234)
 wss <- numeric(15) # 15 levels of k
 for (k in 1:15) wss[k] <- sum(kmeans(wine.scale, centers=k, nstart=25)$withinss)
 wss
 #or you can use nb clust
 
 plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within Sum of Squares") 
 
 #(b)
 set.seed(1234)
 km = kmeans(wine.scale,3, nstart=25)
 km

 #(c)
 km$centers
 km$size
 
 #(d)
 km$cluster
# wine_type <- data.frame(wine, km$cluster)
 
 table(wine$Type, km$cluster)
 
#2
library(datasets)
iris

 #2.1
 set.seed(123)
 iris.n <- iris[,1:5]
 idx <- sample(1:dim(iris[,1:5])[1], 40) # index
 iris40 <- iris.n[idx,]
 
 #2.2
 dend<-hclust(dist(iris40),method="ward.D")
 plot(dend, hang = -1, labels=iris40$Species)
 plot(dend, labels=iris40$Species)
 #2.3
 rect.hclust(dend, k=3)
 
 #groups <- cutree(dend, k=3)
 #groups
 #table(groups)
 