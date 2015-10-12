# Ian Castillo Rosales
# Getting data and overview
# 07/06/2015

# rm(list=setdiff(ls(), c("corpus", "dirCorpus")))

# ===== Options and libraries =====

# OPTIONAL: Install framework package for text mining applications within R
# install.packages(c("tm", "NPL", "caret", "SnowballC", "RWeka"))
# Load tm package. Loading required NLP package
library(NLP); library(tm); library(caret); library(wordcloud);  library(ngram);
library(dplyr)
getOption("encoding")

# ===== Set the paths and directions =====

# source("~/Coursera/week1/count_nrows.R") # Windows

# Set a local working directory (depends of you)
# setwd("~/Coursera/data/en_US") # Windows
setwd("~/Documents/datasciencecoursera/Capstone Project/Week1/") #Mac

# Create a rute for your Corpus (Optional)
# dirCorpus <- DirSource("~/Coursera/data/en_US/", encoding = "UTF-8") # Windows
dirCorpus <- DirSource("~/Desktop/data_capstone/en_US/") # Mac

# ===== Load the corpus in the workspace =====
system.time(corpus <- Corpus(dirCorpus, 
                             readerControl = list(reader = readPlain, 
                                                  language = "en")))
summary(corpus)

# Explore the documents in the corpus
summary(corpus[[1]]$content) 
summary(corpus[[2]]$content) 
summary(corpus[[3]]$content)

# ===== Sample data =====
source("functions/sample_text.R")
system.time(corpus_partition <- sample_text(corpus_obj = corpus, 
                                            no_text = 2, 
                                            n_muestra = 15000, 
                                            p_partition = 0.7))

# ===== Cleaning text =====
source("functions/cleaning_text.R")
system.time(clean_text <- cleaning_text(doc = corpus_partition$CmuestraTrain, 
                                        dir_badwords = "bad_words.txt"))

# ===== Tokenization of text =====
source("functions/tokenization_text.R")
system.time(tokens_text <- tokenization_text(document = clean_text, 
                                             get_bigrams = T, 
                                             get_trigrams = T))

