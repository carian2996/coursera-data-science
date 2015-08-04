sample_text <- function(corpus_obj, no_text = 1, n_muestra = 1000, p_partition = 0.7){
    
    # Get the number of row in a document of the corpus
    nrows_text <- as.numeric(summary(corpus_obj[[no_text]]$content)[1])
    
    # Set the value of the sample
    id_muestra <- sort(sample(x = 1:nrows_text, size = n_muestra, replace = F))
    
    muestra <- corpus_obj[[no_text]]$content[id_muestra]
    
    # Create a partition of the sample
    idPartition <- createDataPartition(y = id_muestra, p = p_partition, list = F)
    muestraTrain <- paste(muestra[idPartition], collapse = " ")
    muestraTest <- muestra[-idPartition]
        # paste(muestra[-idPartition], collapse = " ")
    
    output <- list(CmuestraTrain = Corpus(VectorSource(muestraTrain)), 
                   CmuestrTest = Corpus(VectorSource(muestraTest)))
    
    output
}