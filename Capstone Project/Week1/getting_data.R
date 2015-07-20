# Ian Castillo Rosales
# Getting data and overview
# 07/06/2015

# ===== Options and libraries =====

# OPTIONAL: Install framework package for text mining applications within R
# install.packages(c("tm", "NPL", "caret"))

# Load tm package. Loading required NLP package
library(NLP); library(tm); library(caret); library(SnowballC)
library(wordcloud)
getOption("encoding")

# ===== Set the paths and directions =====

# source("~/Coursera/week1/count_nrows.R") # Windows

# Set a local working directory (depends of you)
setwd("~/Coursera/data/en_US") # Windows
# setwd("~/Documents/datasciencecoursera/Capstone Project/Week1/") #Mac

# Create a rute for your Corpus (Optional)
dirCorpus <- DirSource("~/Coursera/data/en_US/") # Windows
# dirCorpus <- DirSource("~/Desktop/data_capstone/en_US/") # Mac

# ===== Load the corpus in the workspace =====
corpus <- Corpus(dirCorpus, readerControl = list(language = "en"))
summary(corpus)

# Explore the documents in the corpus
summary(corpus[[1]]$content); summary(corpus[[2]]$content); summary(corpus[[3]]$content)

# ===== Sample data =====

# Make analysis with the blog text
# Get the number of row in a document of the corpus
nrows_news <- as.numeric(summary(corpus[[1]]$content)[1])

# Set the value of the sample
n_muestra <- 5000
id_muestra <- sort(sample(x = 1:nrows_news, size = n_muestra, replace = F))

muestra <- corpus[[1]]$content[id_muestra]
# muestra <- paste(muestra[id_muestra], collapse = "")

# Create a partition of the sample
idPartition <- createDataPartition(y = id_muestra, p = 0.7, list = F)
muestraTrain<- paste(muestra[idPartition], collapse = " ")
muestraTest<- paste(muestra[-idPartition], collapse = " ")

CmuestraTrain <- Corpus(VectorSource(muestraTrain))
CmuestraTest <- Corpus(VectorSource(muestraTest))

# ===== Tokenization of a text =====

source("~/Coursera/week1/tokenization.R")
clean_sample <- tokenization(CmuestraTrain, "~/Coursera/week1/bad_words.txt")


# ===== Exploratory analysis of the document =====

qplot(x = names(tokens[[2]][1:15]), 
      y = tokens[[2]][1:15], 
      geom = "bar", 
      stat = "identity",
      xlab = "Most frenquent tokens",
      ylab = "Frequency",
      main = "Some words are more frequent than others?"
      )

tdm_sample <- TermDocumentMatrix(clean_sample[[3]])
freq_sample <- sort(rowSums(as.matrix(tdm_sample)), decreasing = T)
df_sample <- data.frame(words = names(freq_sample), freq = freq_sample)

wordcloud(df_sample$words, 
          df_sample$freq, 
          random.order = F, 
          scale=c(3.5,.5),
          max.words = 50, 
          colors = brewer.pal(6, "GnBu"))

tokenization <- function(cor, dir_badwords){
    # tokenization recive a corpus, clean the text; remove "/", "@" and "-".
    # transform all text to lowercase, remove punctuation, stopwords and "bad 
    # words", strip whitespaces in the text and finally, tokenize the text and 
    # make a frequency of the words.
    
    # INPUT
    # corpora = Text to analyze (should be in corpus class)
    # dir_badwords = Directory with the bad words to remove. Should be text file.
    
    # OUTPUT
    # tokens = tokens and frequency
    
    # Read the list of bad words
    bad_words <- readLines(dir_badwords)
    
    # Create a function to convert a pattern into whitespace
    toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
    
    # Do the cleaning in the text
    cor <- tm_map(cor, stemDocument)
    cor <- tm_map(cor, toSpace, "/|@|-|â€\u009d|â€œ|â€™|â€”|â€|zz+|http:.|www.|.com")
    cor <- tm_map(cor, content_transformer(tolower))
    cor <- tm_map(cor, removePunctuation)
    cor <- tm_map(cor, removeWords, stopwords("english"))
    cor <- tm_map(cor, removeWords, bad_words)
    cor <- tm_map(cor, stripWhitespace)
    
    tokens <- scan_tokenizer(cor[[1]]$content)
    
    freq_tokens <- table(tokens)
    freq_tokens <- freq_tokens[order(freq_tokens, decreasing = T)]
    output <- list(tokens, freq_tokens, cor)
    
    output
}
