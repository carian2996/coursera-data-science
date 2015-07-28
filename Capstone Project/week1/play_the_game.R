# tdm_sample <- TermDocumentMatrix(clean_sample[[3]])
# freq_sample <- sort(rowSums(as.matrix(tdm_sample)), decreasing = T)
# df_sample <- data.frame(words = names(freq_sample), freq = freq_sample)
# 
# 
# clean_sample[[3]]




# corpus[[1]]$content[1]
# Encoding(corpus[[1]]$content[227])
# enc2native(corpus[[1]]$content[1])
# 
# iconv(enc2native(corpus[[1]]$content[1]), "latin1", "UTF-8")
# 
# Encoding(enc2native(corpus[[1]]$content[1]))





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


# qplot(x = names(tokens[[2]][1:15]), 
#       y = tokens[[2]][1:15], 
#       geom = "bar", 
#       stat = "identity",
#       xlab = "Most frenquent tokens",
#       ylab = "Frequency",
#       main = "Some words are more frequent than others?"
#       )

# sample_df <- data.frame(text = unlist(sapply(clean_sample[[2]], '[',"content")),
#                         stringsAsFactors = F)
# 
# token_delim <- " \\t\\r\\n.!?,;\"()"
# 
# bitokens <- NGramTokenizer(sample_df, Weka_control(min = 2,
#                                                   max = 2, 
#                                                   delimiters = token_delim))
# tritokens <- NGramTokenizer(sample_df, Weka_control(min = 3,
#                                                    max = 3, 
#                                                    delimiters = token_delim))
# head(clean_sample[[1]][grep("â", clean_sample[[1]])])