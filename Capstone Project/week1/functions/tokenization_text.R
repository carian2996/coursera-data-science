tokenization_text <- function(document, get_bigrams = F, get_trigrams = F){
    document <- clean_text
    tokens <- scan_tokenizer(document[[1]]$content)
    
    output <- list(tokens = tokens)
    
    if(get_bigrams == T){
        bigrams <- ngrams(x = strsplit(x = document[[1]]$content, 
                                            split = " ", fixed = T)[[1]], 
                               n = 2)
        bigrams <- lapply(X = bigrams, 
                               FUN = paste, collapse = " ")
        bigrams <- unlist(lapply(X = bigrams, FUN = '[[', 1))
        output <- list(tokens = output[[1]], bigrams = bigrams)
    }
    
    if(get_trigrams == T){
        trigrams <- ngrams(x = strsplit(x = document[[1]]$content, 
                                            split = " ", fixed = T)[[1]], 
                               n = 3)
        trigrams <- lapply(X = trigrams, 
                               FUN = paste, collapse = " ")
        trigrams <- unlist(lapply(X = trigrams, FUN = '[[', 1))
        
        if(get_bigrams == T){
            output <- list(tokens = output[[1]], 
                           bigrams = output[[2]], 
                           trigrams = trigrams)
        } else{
            output <- list(tokens = output[[1]], trigrams = trigrams)
        }
    }
    
    output
    
}