# Ian Castillo Rosales
# Getting data and overview
# 19/07/2015

# Load tm package. Loading required NLP package
library(NLP); library(tm); library(caret)
options(encoding = "UTF-8") # Choose the correct encoding

# Set a local working directory (depends of you)
setwd("~/Documents/datasciencecoursera/Capstone Project/Week1/")

# Create a rute for your Corpus (Optional)
dirCorpus <- DirSource("~/Desktop/data_capstone/en_US/") 

# Load all the documents for the analysis
corpus <- Corpus(x = dirCorpus, readerControl = list(language = "en"))
summary(corpus)

# ========== The en_US.blogs.txt file is how many megabytes? ==========

info_blogs <- file.info("~/Desktop/data_capstone/en_US/en_US.blogs.txt")
info_blogs$size / 10^6

# ========== The en_US.twitter.txt has how many lines of text? ==========

length(corpus[[3]]$content)

# = What is the length of the longest line seen in any of the three en_US data sets? =
max_length_blogs <- max(nchar(corpus[[1]]$content))
max_length_news <- max(nchar(corpus[[2]]$content))
max_length_twitter <- max(nchar(corpus[[3]]$content))

max(max_length_blogs, max_length_news, max_length_twitter)

# ===== In the en_US twitter data set, if you divide the number of lines 
# where the word "love" (all lowercase) occurs by the number of lines the 
# word "hate" (all lowercase) occurs, about what do you get? =====

length(grep("love", corpus[[3]]$content)) / length(grep("hate", corpus[[3]]$content))

# ===== The one tweet in the en_US twitter data set 
# that matches the word "biostats" says what? =====

corpus[[3]]$content[grep("biostats", corpus[[3]]$content)]


# ===== How many tweets have the exact characters "A computer once beat me 
# at chess, but it was no match for me at kickboxing". =====
corpus[[3]]$content[
    grep("A computer once beat me at chess, but it was no match for me at kickboxing", 
         corpus[[3]]$content)]


