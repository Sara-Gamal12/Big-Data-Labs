##Sara Gamal     9210455
##Eman Ibrahim   9210265
#install.packages("rattle.data")
#install.packages("NbClust")
#install.packages("HSAUR")
library(NbClust)
library(cluster)
library(HSAUR)
#1. First of all, start by cleaning the workspace and setting the working directory. 
rm(list = ls())
setwd("C:/Users/Sara/me/4th/big data/Big Data Labs/Big-Data-Labs/Lab 6 - Descriptive Analysis/Clustering")  

#2. Import the dataset clustering_data.csv into a data frame and plot the points. 
data <- read.csv("clustering_data.csv", header = TRUE)
plot(data, main = "Scatter plot of clustering data", pch = 19)
#3. Perform a k-means clustering on the data with 10 clusters and 15 iterations. 
kmeans_result_10 <- kmeans(data, centers = 10, iter.max = 15)

#4. Print the cluster centroids. 
print(kmeans_result_10$centers)

#5. Plot data such that each point is colored according to its cluster. 
plot(data, col = kmeans_result_10$cluster, pch = 19, main = "K-means Clustering with 10 Clusters")

#6. Overlay the cluster centroids on the above plot. Plot them as solid filled triangles.
points(kmeans_result_10$centers, col = 1:10, pch = 17, cex = 2)

#7. What’s the difference between plot() and points()? 
#  plot(): Creates a new plot from scratch.
#  points(): Adds points to an existing plot.

#8. Now, determine the best number of clusters by two different ways. 
#-- method 1
wss <- (nrow(data)-1)*sum(apply(data,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(data, centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")
##--method 2
nc <- NbClust(data, min.nc=2, max.nc=15, method="kmeans")

#9. Tabulate the voting results.
table(nc$Best.n[1,])
##its clear the 3 is best number of clusters
#10. Perform a k-means clustering on the data with the best number of clusters chosen in step 3. Choose an appropriate number of iterations.
best_k <- sil_best  
kmeans_best <- kmeans(data, centers = best_k, iter.max = 20)
#11. Repeat (4, 5, 6) for the new number of clusters. 
print(kmeans_best$centers)
plot(data, col = kmeans_best$cluster, pch = 19, main = "K-means Clustering with 3 Clusters")
points(kmeans_best$centers, col = 1:10, pch = 17, cex = 2)

