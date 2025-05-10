##Sara Gamal     9210455
##Eman Ibrahim   9210265

install.packages("png") 
library(png)
#1. First of all, start by cleaning the workspace and setting the working directory. 
rm(list = ls())
setwd("C:/Users/Sara/me/4th/big data/Big Data Labs/Big-Data-Labs/Lab 6 - Descriptive Analysis/Clustering")  

#2. Read the image bird_small.png.  

img <- readPNG("bird_small.png")  


#3. For the 3-dimensional image, You have one dimension for R, one dimension for G, and one dimension for B.  
#Create a data frame with three columns: - The first column contains all R values for all pixels.  - The second column contains all G values for all pixels. - The third column contains all B values for all pixels.
#Now every row in the data frame represents a pixel.


r <- as.vector(img[,,1])
g <- as.vector(img[,,2])
b <- as.vector(img[,,3])

df <- data.frame(R = r, G = g, B = b)
#4. Perform a k-means clustering on the data with 16 clusters and 15 iterations. 
kmeans_result <- kmeans(df, centers = 16, iter.max = 15)

#5.  Show the cluster each point belongs to. 
head(kmeans_result$cluster) 
#6. Display the 16 centroids of the clusters. What do these centroids represent?  
centroids <- kmeans_result$centers
print(centroids)
# These centroids represent the 16 colors used to approximate the image

#7. Assign each pixel to the centroid of its cluster.  
df_compressed <- centroids[kmeans_result$cluster, ]

#8. Reshape the data frame again to a 3-dimensional form.  
img_dim <- dim(img)
rows <- img_dim[1]
cols <- img_dim[2]
img_compressed <- array(0, dim = c(rows, cols, 3))

img_compressed[,,1] <- matrix(df_compressed[, 1], nrow = rows, byrow = FALSE)  # R
img_compressed[,,2] <- matrix(df_compressed[, 2], nrow = rows, byrow = FALSE)  # G
img_compressed[,,3] <- matrix(df_compressed[, 3], nrow = rows, byrow = FALSE)  # B


#9. Write the compressed image in a file named compressed.png. Now check its size. 
writePNG(img_compressed, target = "compressed.png")
