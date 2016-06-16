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