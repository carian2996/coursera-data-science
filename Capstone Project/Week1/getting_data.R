# Ian Castillo Rosales
# Getting data and overview
# 07/06/2015

# OPTIONAL: Install framework package for text mining applications within R
# install.packages("tm")

# Load tm package. Loading required NLP package
library(NLP)
library(tm)
source("~/Coursera/count_nrows.R") # Windows

# Set a local working directory (depends of you)
setwd("~/Coursera/data/en_US/") # Windows
setwd("~/Documents/datasciencecoursera/Capstone Project/data/en_US/") #Mac

# Create a rute for your Corpus (Optional)
dirCorpus <- DirSource("~/Coursera/data/en_US/") # Windows
dirCorpus <- DirSource("~/Documents/datasciencecoursera/Capstone Project/data/en_US/")
corpus <- Corpus(dirCorpus, readerControl = list(language = "en"))

# Summary what went in
summary(corpus)

# ===== Load a sample of the corpus =====

# Create a connection and read certains lines of the corpus

sample_creation <- function(sample_size, path){
    con <- file(path)
    nrow_text <- as.numeric(system("wc -l < en_US.news.txt", intern = T))
    
    text_sample <- c()
    n_sample <- 0
    for(i in 1:nrow_text){
        test <- rbinom(1, 1, prob = c(0.5, 0.5))
        if(test == 1){
            n_sample <- n_sample + 1
            readed_line <- scan(file = con, what = "char", nlines = 1, 
                                skip = i-1, quiet = T)
            text_sample <- c(text_sample, readed_line)
        }
        if(n_sample == sample_size) break
    }
    close(con)
    paste(text_sample, collapse = " ")
}

sample <- sample_creation(sample_size = 10, path = "~/Documents/datasciencecoursera/Capstone Project/data/en_US/en_US.news.txt")
