# Ian Castillo Rosales
# Prediction
# 025/07/2015

set.seed(140)
no_test <- sample(seq(1000*(1-0.7)), size = 1)

# test_phrase <- corpus_partition$CmuestrTest[[2]]$content
# test_phrase <- strsplit(x = test_phrase, split = " ", fixed = T)[[1]]
# test_phrase <- paste(test_phrase[-length(test_phrase)], collapse = " ")
# test_phrase

predict_word <- function(phrase, bigrams, trigrams){
    
    phrase <- "But who am I, I need" # know
    split_phrase <- strsplit(x = phrase, split = " ", fixed = T)[[1]]
    split_phrase <- tolower(split_phrase)
    split_phrase <- gsub("[[:punct:]]", "", split_phrase)
    # split_phrase <- split_phrase[!split_phrase %in% stopwords("en")]
    split_phrase
    
    sort_tokens$proba <- sort_tokens$Freq / sum(sort_tokens$Freq)
    sort_bigrams$proba <- sort_bigrams$Freq / sum(sort_bigrams$Freq)
    # sort_trigrams$proba <- sort_trigrams$Freq / sum(sort_trigrams$Freq)
    
    sep_bigrams <- data.frame(do.call('rbind', 
                                      strsplit(as.character(sort_bigrams$Var1), 
                                               " ",
                                               fixed=TRUE)), 
                              Freq = sort_bigrams$Freq,
                              proba = sort_bigrams$proba)
    colnames(sep_bigrams)[c(1, 2)] <-c("word1", "word2")
    
    sep_bigrams$word2[sep_bigrams$word1 == rev(split_phrase)[1]]
    log(sep_bigrams$proba[sep_bigrams$word1 == rev(split_phrase)[1]])
    
    denom <- c()
    for(i in seq_along(split_phrase[-1])){
        denom <- c(denom, sep_bigrams$proba[sep_bigrams$word1 == rev(split_phrase)[i+1] & 
                              sep_bigrams$word2 == rev(split_phrase)[i]])
    }
    denom <- c(denom, sort_tokens$proba[sort_tokens$Var1 == rev(split_phrase)[6]])
    denom <- log(denom)
    denom <- sum(denom)
    
    resultado <- log(sep_bigrams$proba[sep_bigrams$word2 == rev(split_phrase)[1]]) / denom
    
    n_win <- which.max(log(sep_bigrams$proba[sep_bigrams$word2 == rev(split_phrase)[1]]) / denom)
    
    
    
    sep_bigrams[sep_bigrams$word2 == rev(split_phrase)[1] &
                sep_bigrams$word2 == "also", ]
    
#     
#     sep_bigrams[, 1] <- as.character(sep_bigrams[, 1])
#     sep_bigrams[, 2] <- as.character(sep_bigrams[, 2])
#     
#     sep_trigrams <- do.call(rbind.data.frame, strsplit(trigrams, split = " "))
#     colnames(sep_trigrams) <-c("word 1", "word 2", "word 3")
#     sep_trigrams <- sep_trigrams[order(sep_trigrams$"word 1"), ]
#     
#     sep_trigrams[, 1] <- as.character(sep_trigrams[, 1])
#     sep_trigrams[, 2] <- as.character(sep_trigrams[, 2])
#     sep_trigrams[, 3] <- as.character(sep_trigrams[, 3])
#     
#     last_word <- split_phrase[length(split_phrase)]
#     
#     prev_words <- table(sep_bigrams$"word 1"[sep_bigrams$"word 2" == last_word])
#     total_prevwords <- length(sep_bigrams$"word 1"[sep_bigrams$"word 2" == last_word])
#     
#     names(which.max(prev_words/total_prevwords))
#     
#     llast_word <- split_phrase[length(split_phrase) - 1]
#     pprev_words <- table(sep_trigrams$"word 2"[sep_trigrams$"word 3" == llast_word])
#     total_pprevwords <- length(sep_trigrams$"word 2"[sep_trigrams$"word 3" == llast_word])
#     all.equal(pprev_words)
#     names(which.max(pprev_words/total_pprevwords))
}
