# Ian Castillo Rosales
# Programming Assignment 2 - R Programming - Coursera
# 22062014

## The general idea for these functions is calculate the inverse of a square matrix, the matrix provided is not singular (always invertible)
## The makeCacheMatrix creates a list with 4 functions, i.e., a special matrix to calculate the inverse. 
## Then, cacheSolve functions calculates the inverse of the matrix, but if the inverse had been calculated already, only past the result from the cache.


## The makeCacheMatrix creates a list with four functions.
	# 1. A function that sets the special matrix, check if the matrix is really a matrix, and if it's a square matrix.
	# 2. A function that bring the special matrix, once it has been set.
	# 3. When the inverse is calculated, the result is cached with this function.
	# 4. To obtain the result from the cache.

makeCacheMatrix <- function(matriz = matrix()) {
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


## The function first tests if the inverse has been calculated and stored in the cache. If is not the case
## calculate the inverse with the solve function. Checks if the matrix is singular, in that case, throw a 
## message "This matrix is singular".

cacheSolve <- function(x, ...) {
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
