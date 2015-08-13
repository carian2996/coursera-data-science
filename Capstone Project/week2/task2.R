# Ian Castillo Rosales
# Getting data and overview
# 01/07/2015

# ===== Exploratory analysis of the document =====
one_word <- data.frame(table(tokens_text$tokens))
two_word <- data.frame(table(tokens_text$bigrams))
# three_word <- data.frame(table(tokens_text[[3]]))

sort_tokens <- one_word[order(one_word$Freq, decreasing = TRUE), ]
sort_bigrams <- two_word[order(two_word$Freq, decreasing = TRUE), ]
# sort_trigrams <- three_word[order(three_word$Freq, decreasing = TRUE), ]


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
       aes(x = factor(wordsByletter$letters, levels = wordsByletter$letters[order(wordsByletter$X0, decreasing = T)]), 
           y = wordsByletter[, 2], 
           fill = factor(wordsByletter$letters, levels = wordsByletter$letters[order(wordsByletter$X0, decreasing = T)])))

c + geom_bar(stat = "identity") + 
    guides(fill=FALSE) + 
    xlab("Letters") +
    ylab("Frequency") +
    ggtitle("Frequency of words by letter")

wordcloud(sort_tokens$Var1, 
          sort_tokens$Freq, 
          scale=c(3.5,.5),
          max.words = 50,
          colors = brewer.pal(6, "Spectral")) 

wordcloud(sort_bigrams$Var1, 
          sort_bigrams$Freq,
          scale=c(2,.5),
          max.words = 28, 
          colors = brewer.pal(6, "Set2")) 

wordcloud(sort_trigrams$Var1, 
          sort_trigrams$Freq,
          scale=c(1,.5),
          max.words = 25, 
          colors = brewer.pal(6, "Set3")) 
