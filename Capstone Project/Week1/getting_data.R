# Ian Castillo Rosales
# Getting data and overview
# 07/06/2015

# OPTIONAL: Install framework package for text mining applications within R
# install.packages(c("tm", "NPL", "caret"))

# Load tm package. Loading required NLP package
library(NLP); library(tm); library(caret)
options(encoding = "UTF-8")
source("~/Coursera/week1/count_nrows.R") # Windows

# Set a local working directory (depends of you)
setwd("~/Coursera/data/en_US/") # Windows
setwd("~/Documents/datasciencecoursera/Capstone Project/Week1/") #Mac

# Create a rute for your Corpus (Optional)
dirCorpus <- DirSource("~/Coursera/data/en_US/") # Windows
dirCorpus <- DirSource("~/Desktop/data_capstone/en_US/") # Mac

corpus <- Corpus(x = dirCorpus, readerControl = list(language = "en"))

summary(corpus)

# Make analysis with the blog text

class(corpus[[1]]$content)
summary(corpus[[1]]$content)
head(corpus[[1]]$content)

nrows_news <- as.numeric(summary(corpus[[1]]$content)[1])

n_muestra <- 1000
id_muestra <- sort(sample(x = 1:nrows_news, size = n_muestra, replace = F))

muestra <- corpus[[1]]$content[id_muestra]
head(muestra)

idPartition <- createDataPartition(y = id_muestra, p = 0.7, list = F)

muestraTrain <- muestra[idPartition]
muestraTest <- muestra[-idPartition]

CmuestraTrain <- Corpus(VectorSource(muestraTrain))
CmuestraTest <- Corpus(VectorSource(muestraTest))

# ===== Tokenization of a text =====

tokenization <- function(corpus){
    bad_words <- read.csv("bad_words", header = F)
    
    
    toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
    
    CmuestraTrain <- tm_map(CmuestraTrain, toSpace, "/|@|-|\\(DOT\\)")
    CmuestraTrain <- tm_map(CmuestraTrain, content_transformer(tolower))
    CmuestraTrain <- tm_map(CmuestraTrain, removePunctuation)
    CmuestraTrain <- tm_map(CmuestraTrain, removeWords, stopwords("english"))
    CmuestraTrain <- tm_map(CmuestraTrain, removeWords, c("shit"))
    CmuestraTrain <- tm_map(CmuestraTrain, stripWhitespace)
    
    dtm_train <- DocumentTermMatrix(CmuestraTrain)
    freq <- colSums(as.matrix(dtm_train))
    tokens <- freq[order(freq, decreasing = T)]
    
    tokens
}





# ===== Load a sample of the corpus =====

# Create a connection and read certains lines of the corpus

# sample_creation <- function(sample_size, path){
#     con <- file(path)
#     nrow_text <- as.numeric(system("wc -l < en_US.news.txt", intern = T))
#     
#     text_sample <- c()
#     n_sample <- 0
#     for(i in 1:nrow_text){
#         test <- rbinom(1, 1, prob = c(0.5, 0.5))
#         if(test == 1){
#             n_sample <- n_sample + 1
#             readed_line <- scan(file = con, what = "char", nlines = 1, 
#                                 skip = i-1, quiet = T)
#             text_sample <- c(text_sample, readed_line)
#         }
#         if(n_sample == sample_size) break
#     }
#     close(con)
#     paste(text_sample, collapse = " ")
# }
# 
# sample <- sample_creation(sample_size = 10, path = "~/Documents/datasciencecoursera/Capstone Project/data/en_US/en_US.news.txt")

