# Function to create a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x) {
  # Initialize an empty cache for the inverse matrix
  cache <- NULL
  
  # Function to set the matrix and update the cache
  setMatrix <- function(matrix) {
    x <<- matrix  # Use <<- to assign to the 'x' in the parent environment
    cache <<- NULL  # Reset the cache since the matrix has changed
  }
  
  # Function to get the matrix
  getMatrix <- function() {
    x
  }
  
  # Function to compute the inverse of the matrix
  getInverse <- function() {
    if (!is.null(cache)) {
      message("Getting cached inverse")
      return(cache)
    } else {
      message("Calculating inverse")
      cache <<- solve(x)  # Compute the inverse and update the cache
      return(cache)
    }
  }
  
  # Return a list of functions
  list(setMatrix = setMatrix, getMatrix = getMatrix, getInverse = getInverse)
}

# Function to compute the inverse of the special "matrix" object using caching
cacheSolve <- function(cacheMatrix) {
  cacheMatrix$getInverse()
}
matrix <- matrix(c(1, 2, 3, 4), nrow = 2)
cacheMatrix <- makeCacheMatrix(matrix)

# Calculate the inverse (it will be computed and cached)
cacheSolve(cacheMatrix)

#Retrieve the inverse (it will be retrieved from the cache)
cacheSolve(cacheMatrix)

