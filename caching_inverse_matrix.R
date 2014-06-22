# Ian Castillo Rosales
# Programming Assignment 2 - R Programming - Coursera
# 22062014

MatrizEspecial <- function(matriz = matrix()) {
      inv <- NULL
      set <- function(y) {
            if(is.matrix(y)){ # Check if y is a matrix
                  if(ncol(y)==nrow(y)){ # Check if y is a square matrix
                        matriz <<- y
                        inv <<- NULL
                  } else{
                        message("This is not a square matrix")
                  }
            } else {
                  message("This is not a matrix")
            }
      }
      get <- function() matriz
      setinv <- function(inversa) inv <<- inversa
      getinv <- function() inv
      list(set = set, get = get, setinv = setinv, getinv = getinv)
}

CacheInv <- function(x, ...) {
      m <- x$getinv()
      if(!is.null(m)) {
            message("Getting cached data")
            return(m)
      }
      data <- x$get()
      if(det(data)!=0){ # Is the matrix singular?
            m <- solve(data)
            x$setinv(m)
            m
      } else {
            message("This matrix is singular")
      }
}
