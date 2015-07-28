cleaning_text <- function(doc, dir_badwords){
    
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
    toEliminate <- content_transformer(function(x, pattern) gsub(pattern, "", x, perl = T))
    
    # Do the cleaning in the text
    doc <- tm_map(doc, content_transformer(tolower))
    doc <- tm_map(doc, removeNumbers)
    doc <- tm_map(doc, toEliminate, "\\p{P}")
    doc <- tm_map(doc, removePunctuation)
    # doc <- tm_map(doc, stemDocument)
    doc <- tm_map(doc, toSpace, "/|@|-|https?://|www|com")
    doc <- tm_map(doc, removeWords, stopwords("english"))
    doc <- tm_map(doc, removeWords, bad_words)
    doc <- tm_map(doc, stripWhitespace)
    
    doc
}