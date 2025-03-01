#! /usr/bin/env Rscript

#Sara Gamal Gerges 9210455
#Eman Ibrahim  9210265
con = file("stdin", "r")
while(length(line <- readLines(con, n=1, warn=FALSE)) > 0) {
 fields <- unlist(strsplit(line, ","))
  # Skip header
  if (fields[1] != "CustomerID") {
    cat(fields[1],"\t",fields[2], "\n",sep="")
  }
}
close(con)