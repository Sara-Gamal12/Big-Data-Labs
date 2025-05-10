##Sara Gamal     9210455
##Eman Ibrahim   9210265

#1 First of all, start by cleaning the workspace and setting the working directory. 
rm(list = ls())  # Clear all variables
setwd("C:/Users/Sara/me/4th/big data/Big Data Labs/Big-Data-Labs/Lab 6 - Descriptive Analysis/Association Rules")  

#2 Load the libraries arules and arulesViz
# install.packages("arules")
# install.packages("arulesViz")
library(arules)
library(arulesViz)

# 3 Load the transactions (AssociationRules.csv), skip the header
trans <- read.transactions("AssociationRules.csv", format = "basket", header = FALSE)

# 4 Display first 100 transactions
inspect(trans[1:100])

# 5 Find the most frequent two items
item_freq <- itemFrequency(trans, type = "absolute")
top_items <- head(sort(item_freq, decreasing = TRUE), 2)
top_items
##1st item13   4948
##2nd item5   3699 

 # 6 Plot the 5 most frequent items
 itemFrequencyPlot(trans, topN = 5, type = "absolute", main = "Top 5 Frequent Items")

# 7 Generate association rules with minimum support and confidence
 rules <- apriori(trans, parameter = list(support = 0.01, confidence = 0.5, minlen = 2))
 
# 8 Sort rules by support and display first 6
rules_support <- sort(rules, by = "support", decreasing = TRUE)
inspect(rules_support[1:6])

# 9 Sort rules by confidence and display first 6
rules_conf <- sort(rules, by = "confidence", decreasing = TRUE)
inspect(rules_conf[1:6])

#10 Sort rules by lift and display first 6
 rules_lift <- sort(rules, by = "lift", decreasing = TRUE)
 inspect(rules_lift[1:6])

# 11 Plot rules: support vs confidence, lift as shading
 plot(rules, measure = c("support", "confidence"), shading = "lift", interactive = FALSE)

#12  Can you tell now what are the most interesting rules that are really 
# useful and provide a real business value and an insight to the concerned corporate?
 
most_important_rules <- sort(rules, by = c("lift", "confidence", "support"), descreasing = TRUE)
inspect(most_important_rules[1:6])
 
 ##most interesting rules are the ones with high lift, high confidence, and high support respectively
##those rules are more likely to be useful and provide a real business value and an insight to the concerned corporate
##Support-> How frequently the rule appears in the data.

##Confidence-> Probability that rhs occurs given lhs.

#Lift-> Strength of the association; higher than 1 means positive correlation.


 #     rhs                   lhs     support   confidence coverage lift    count
 #[1] {item15, item30, item56} => {item49} 0.0101  0.7709924  0.0131   19.42046 101  
 #[2] {item30, item56, item84} => {item49} 0.0100  0.7407407  0.0135   18.65846 100  
 #[3] {item15, item30, item49} => {item56} 0.0101  0.9619048  0.0105   16.58456 101  
 #[4] {item15, item56}         => {item49} 0.0101  0.6121212  0.0165   15.41867 101  
 #[5] {item15, item49}         => {item56} 0.0101  0.8632479  0.0117   14.88358 101  
 #[6] {item30, item49, item84} => {item56} 0.0100  0.8000000  0.0125   13.79310 100  