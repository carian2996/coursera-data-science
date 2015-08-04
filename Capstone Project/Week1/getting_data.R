# Ian Castillo Rosales
# Getting data and overview
# 07/06/2015

# ===== Options and libraries =====

# OPTIONAL: Install framework package for text mining applications within R
# install.packages(c("tm", "NPL", "caret", "SnowballC", "RWeka"))
install.packages("rbind")
# Load tm package. Loading required NLP package
library(NLP); library(tm); library(caret); library(SnowballC);
library(wordcloud); library(Unicode); library(ngram);
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
corpus <- Corpus(dirCorpus, readerControl = list(reader = readPlain, language = "en"))
summary(corpus)

# Explore the documents in the corpus
summary(corpus[[1]]$content); summary(corpus[[2]]$content); summary(corpus[[3]]$content)
# ===== Sample data =====
source("~/Coursera/week1/sample_text.R")
corpus_partition <- sample_text(no_text = 3, n_muestra = 1000, p_partition = 0.7)


# ===== Tokenization of a text =====

source("~/Coursera/week1/tokenization_text.R")
clean_sample <- tokenization(CmuestraTrain, "~/Coursera/week1/bad_words.txt")

sample_df <- data.frame(text = unlist(sapply(clean_sample[[2]], '[',"content")),
                        stringsAsFactors = F)

token_delim <- " \\t\\r\\n.!?,;\"()"

bitokens <- NGramTokenizer(sample_df, Weka_control(min = 2,
                                                  max = 2, 
                                                  delimiters = token_delim))
tritokens <- NGramTokenizer(sample_df, Weka_control(min = 3,
                                                   max = 3, 
                                                   delimiters = token_delim))

one_word <- data.frame(table(tokens))
two_word <- data.frame(table(bitokens))
three_word <- data.frame(table(tritokens))

sort_tokens <- one_word[order(one_word$Freq, decreasing = TRUE), ]
sort_bitokens <- two_word[order(two_word$Freq, decreasing = TRUE), ]
sort_tritokens <- three_word[order(three_word$Freq, decreasing = TRUE), ]

# ===== Exploratory analysis of the document =====

wordcloud(sort_tokens$Var1, 
          sort_tokens$Freq, 
          random.order = F, 
          scale=c(3.5,.5),
          max.words = 30, 
          colors = brewer.pal(6, "GnBu"))

wordcloud(sort_bitokens$bitokens, 
          sort_bitokens$Freq, 
          random.order = F, 
          scale=c(2,.5),
          max.words = 28, 
          colors = brewer.pal(6, "GnBu"))

wordcloud(sort_tritokens$tritokens, 
          sort_tritokens$Freq, 
          random.order = F, 
          scale=c(1,.5),
          max.words = 25, 
          colors = brewer.pal(6, "GnBu"))

dictionary <- one_word 
dictionary[, 3] <- cumsum(one_word$Freq)
dictionary[, 4] <- dictionary[, 3]/sum(one_word$Freq)
colnames(dictionary) <- c("word", "freq", "cum_freq", "quant")

tail(dictionary$cum_freq, 1) # Number of words in the sample
length(unique(dictionary$word)) # Number of unique words


quantile(c(0, dictionary[, 3]))
quantile(c(0, dictionary[, 3]), .90)

# ===== Modeling =====

predict_word <- function(palabra){
    
}

tdm_sample <- TermDocumentMatrix(clean_sample[[3]])
freq_sample <- sort(rowSums(as.matrix(tdm_sample)), decreasing = T)
df_sample <- data.frame(words = names(freq_sample), freq = freq_sample)


clean_sample[[3]]
