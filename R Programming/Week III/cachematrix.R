## Stores a cached version of the inverse of a given matrix and retrieves the cached
## version if the original matrix hasn't changed



## This function allow the user to transform a matrix into a special list
## object which encapsulates the matrix and, in addition, provides properties to
## access the original matrix along with properties to 'set' a new matrix, and also 'set'
## and 'get' the inverse of the original matrix. 
##
## This function, however, doesn't do
## the actual inversion of the original matrix

makeCacheMatrix <- function(mtrx = matrix())
{
  cachedInversedMatrix <- NULL
  
  setMatrix <- function(newMatrix) 
  {
    mtrx <<- newMatrix
    cachedInversedMatrix <<- NULL
  }
  
  getMatrix <- function() mtrx
  
  setCachedInversedMatrix <- function(inversedMatrix) cachedInversedMatrix <<- inversedMatrix
  
  getCachedInversedMatrix <- function() cachedInversedMatrix
  
  list(setMatrix = setMatrix,
       getMatrix = getMatrix,
       setCachedInversedMatrix = setCachedInversedMatrix,
       getCachedInversedMatrix = getCachedInversedMatrix)
}

## This is the function where the inversion of the matrix happens. But first, it checks
## to see if there is an existing cached inversed matrix calculated from the last time
## this function was called on the original matrix. As long as the matrix hasn't changed
## this function will print a message and return the cached object

cacheSolve <- function(mtrx, ...) {
  
  cachedInversedMatrix <- mtrx$getCachedInversedMatrix()
  
  if(!is.null(cachedInversedMatrix))
  {
    message("getting cached inversed matrix")
    return(cachedInversedMatrix)
  }
  
  originalMatrix <- mtrx$getMatrix()
  inversedMatrix <- solve(originalMatrix)
  mtrx$setCachedInversedMatrix(inversedMatrix)
  return(inversedMatrix)
}