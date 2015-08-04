# Ian Castillo Rosales
# Getting data and overview
# 07/06/2015

# rm(list=setdiff(ls(), c("corpus", "dirCorpus")))

# ===== Options and libraries =====

# OPTIONAL: Install framework package for text mining applications within R
# install.packages(c("tm", "NPL", "caret", "SnowballC", "RWeka"))
# Load tm package. Loading required NLP package
library(NLP); library(tm); library(caret); library(wordcloud);  library(ngram);
getOption("encoding")

# ===== Set the paths and directions =====

# source("~/Coursera/week1/count_nrows.R") # Windows

# Set a local working directory (depends of you)
setwd("~/Coursera/data/en_US") # Windows
# setwd("~/Documents/datasciencecoursera/Capstone Project/Week1/") #Mac

# Create a rute for your Corpus (Optional)
dirCorpus <- DirSource("~/Coursera/data/en_US/", encoding = "UTF-8") # Windows
# dirCorpus <- DirSource("~/Desktop/data_capstone/en_US/") # Mac

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
source("~/Coursera/week1/functions/sample_text.R")
corpus_partition <- sample_text(corpus = corpus, 
                                no_text = 3, 
                                n_muestra = 1000, 
                                p_partition = 0.7)

# ===== Cleaning text =====
source("~/Coursera/week1/functions/cleaning_text.R")
clean_text <- cleaning_text(doc = corpus, 
                            dir_badwords = "~/Coursera/week1/functions/bad_words.txt")

# ===== Tokenization of text =====
source("~/Coursera/week1/functions/tokenization_text.R")
tokens_text <- tokenization_text(document = clean_text, 
                                 get_bigrams = T, 
                                 get_trigrams = T)
