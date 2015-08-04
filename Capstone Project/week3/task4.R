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