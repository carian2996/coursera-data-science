# Ian Castillo Rosales
# Prediction
# 025/07/2015

predict_word <- function(phrase, bigrams, trigrams){
    
    # Split the phrase into tokens and remove all puctuation.
    phrase <- "How are you" # City
    split_phrase <- strsplit(x = phrase, split = " ", fixed = T)[[1]]
    split_phrase <- tolower(split_phrase)
    split_phrase <- gsub("[[:punct:]]", "", split_phrase)
    # split_phrase <- split_phrase[!split_phrase %in% stopwords("en")]
    split_phrase
    
    # Calculate the probabilities for every token, bigram and trigram
    sort_tokens$proba <- sort_tokens$Freq / sum(sort_tokens$Freq)
    sort_bigrams$proba <- sort_bigrams$Freq / sum(sort_bigrams$Freq)
    sort_trigrams$proba <- sort_trigrams$Freq / sum(sort_trigrams$Freq)
    
    # Split the bigrams to have separated words
    sep_bigrams <- data.frame(do.call('rbind', 
                                      strsplit(as.character(sort_bigrams$Var1), 
                                               " ",
                                               fixed=TRUE)), 
                              Freq = sort_bigrams$Freq,
                              proba = sort_bigrams$proba)
    colnames(sep_bigrams)[c(1, 2)] <-c("word1", "word2")
    
    # Split the trigrams to have separated words
    sep_trigrams <- data.frame(do.call('rbind', 
                                      strsplit(as.character(sort_trigrams$Var1), 
                                               " ",
                                               fixed=TRUE)), 
                              Freq = sort_trigrams$Freq,
                              proba = sort_trigrams$proba)
    colnames(sep_trigrams)[1:3] <-c("word1", "word2", "word3")
    
    # Get the last n-words in the phrase
    input <- split_phrase[length(split_phrase) - 1:0]
    output <- sep_trigrams %>% filter(word1 == input[1], word2 == input[2]) %>% select(word3, proba)
    if(nrow(output) == 0){
        output <- sep_bigrams %>% filter(word1 == input[2]) %>% select(word2)
    } else {
        denom <- sep_bigrams %>% filter(word1 == input[1], word2 == input[2]) %>% select(proba)
        as.character(output$word3[which.max(exp(log(output$proba) - log(denom$proba)))])
    }
    
}
