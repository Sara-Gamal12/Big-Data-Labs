#! /usr/bin/env Rscript

#Sara Gamal Gerges 9210455
#Eman Ibrahim Elbedwihy  9210265

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

splitLine <- function(line) {
  val <- unlist(strsplit(line, "\t"))
  list(id = val[1], count = as.integer(val[2]))
}

env <- new.env(hash = TRUE)

con <- file("stdin", open = "r")
while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  line <- trimWhiteSpace(line)
  split <- splitLine(line)
  id <- split$id
  count <- split$count
  if (exists(id, envir = env, inherits = FALSE)) {
      oldcount <- get(id, envir = env)
      assign(id, oldcount + count, envir = env)
  }
  else assign(id, count, envir = env)
}
close(con)

for (id in ls(env, all = TRUE))
  cat(id, "\t", get(id, envir = env), "\n", sep = "")

