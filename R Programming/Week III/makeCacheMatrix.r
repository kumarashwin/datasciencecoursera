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