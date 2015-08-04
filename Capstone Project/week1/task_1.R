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
corpus <- Corpus(dirCorpus, readerControl = list(reader = readPlain, language = "en"))

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

# ====================================================================================================
# ====================================================================================================

# Ian Castillo Rosales
# Getting data and overview
# 01/07/2015

# ===== Exploratory analysis of the document =====
one_word <- data.frame(table(tokens_text[[1]]))
two_word <- data.frame(table(tokens_text[[2]]))
three_word <- data.frame(table(tokens_text[[3]]))

sort_tokens <- one_word[order(one_word$Freq, decreasing = TRUE), ]
sort_bigrams <- two_word[order(two_word$Freq, decreasing = TRUE), ]
sort_trigrams <- three_word[order(three_word$Freq, decreasing = TRUE), ]


dictionary <- one_word  
dictionary[, 3] <- cumsum(one_word$Freq) 
dictionary[, 4] <- dictionary[, 3]/sum(one_word$Freq) 
colnames(dictionary) <- c("word", "freq", "cum_freq", "quant") 

tail(dictionary$cum_freq, 1) # Number of words in the sample 
length(unique(dictionary$word)) # Number of unique words 


quantile(c(0, dictionary[, 3])) 
quantile(c(0, dictionary[, 3]), .90) 

wordsByletter <- data.frame(letters, 0)
for(i in seq_along(letters)){
    wordsByletter[, 2][i] <- sum(apply(X = one_word, 
                                       MARGIN = 2, 
                                       FUN = substr, 1, 1)[ , 1] == letters[i])
}

c <- ggplot(wordsByletter, 
       aes(x = factor(wordsByletter[, 1]), 
           y = wordsByletter[, 2], 
           fill = factor(wordsByletter[, 1])))

c + geom_bar(stat = "identity") + 
    guides(fill=FALSE) + 
    xlab("Letters") +
    ylab("Frequency") +
    ggtitle("Frequency of words by letter")

wordcloud(sort_tokens$Var1, 
          sort_tokens$Freq, 
          scale=c(3.5,.5),
          max.words = 30,
          colors = brewer.pal(6, "GnBu")) 

wordcloud(sort_bigrams$Var1, 
          sort_bigrams$Freq,
          scale=c(2,.5),
          max.words = 28, 
          colors = brewer.pal(6, "BuGn")) 

wordcloud(sort_trigrams$Var1, 
          sort_trigrams$Freq,
          scale=c(1,.5),
          max.words = 25, 
          colors = brewer.pal(6, "BuPu")) 

# ====================================================================================================
# ====================================================================================================


Conditional probabilities
=========================

P(But who am I, I need) ~ P(But who am I, I need)
                        P(but who am i i need)
                        = P(need | but who am i i) P(but who am i i)
                        ...
                        = P(need | but who am i i) * P(i | but who am i) * P (i | but who am) *
                          P(am | but who) * P(who | but) * P(but)
            (Markov)    = P(need | i) * P(i | i) * P(i | am) * P(am | who) * P(who | but) * P(but)

Log aproximation
================

Log(P(But who am I, I need)) ~ LogP(need | i) + LogP(i | i) + LogP(i | am) 
                                + LogP(am | who) + LogP(who | but) + LogP(but)



# ====================================================================================================
# ====================================================================================================


# Ian Castillo Rosales
# Prediction
# 025/07/2015

set.seed(140)
no_test <- sample(seq(1000*(1-0.7)), size = 1)

test_phrase <- corpus_partition$CmuestrTest[[2]]$content
test_phrase <- strsplit(x = test_phrase, split = " ", fixed = T)[[1]]
test_phrase <- paste(test_phrase[-length(test_phrase)], collapse = " ")
test_phrase

predict_word <- function(phrase, bigrams, trigrams){
    
    phrase <- "You're the reason why I smile everyday. Can you follow me please? It would mean the"
    split_phrase <- strsplit(x = phrase, split = " ", fixed = T)[[1]]
    split_phrase <- tolower(split_phrase)
    split_phrase <- gsub("[[:punct:]]", "", split_phrase)
    split_phrase <- split_phrase[!split_phrase %in% stopwords("en")]
    split_phrase
    
    sep_bigrams <- do.call(rbind.data.frame, strsplit(bigrams, split = " "))
    colnames(sep_bigrams) <-c("word 1", "word 2")
    sep_bigrams <- sep_bigrams[order(sep_bigrams$"word 1"), ]
    
    sep_bigrams[, 1] <- as.character(sep_bigrams[, 1])
    sep_bigrams[, 2] <- as.character(sep_bigrams[, 2])
    
    sep_trigrams <- do.call(rbind.data.frame, strsplit(trigrams, split = " "))
    colnames(sep_trigrams) <-c("word 1", "word 2", "word 3")
    sep_trigrams <- sep_trigrams[order(sep_trigrams$"word 1"), ]
    
    sep_trigrams[, 1] <- as.character(sep_trigrams[, 1])
    sep_trigrams[, 2] <- as.character(sep_trigrams[, 2])
    sep_trigrams[, 3] <- as.character(sep_trigrams[, 3])
    
    last_word <- split_phrase[length(split_phrase)]
    
    prev_words <- table(sep_bigrams$"word 1"[sep_bigrams$"word 2" == last_word])
    total_prevwords <- length(sep_bigrams$"word 1"[sep_bigrams$"word 2" == last_word])
    
    names(which.max(prev_words/total_prevwords))
    
    llast_word <- split_phrase[length(split_phrase) - 1]
    pprev_words <- table(sep_trigrams$"word 2"[sep_trigrams$"word 3" == llast_word])
    total_pprevwords <- length(sep_trigrams$"word 2"[sep_trigrams$"word 3" == llast_word])
    all.equal(pprev_words)
    names(which.max(pprev_words/total_pprevwords))
}