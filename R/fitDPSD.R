#' Estimation of recollection and familiarity by fitting to Dual Process Signal Detection (DPSD) model
#'
#' This function allows to estimate recollection and familiarity by fitting data to the DPSD model. 
#' The optimization is attempted by minimizing the total squared difference between observed and 
#' predicted hit and false alarm rates. The Broyden-Fletcher-Goldfarb-Shanno (BFGS) algorithm from the function. 
#' The function first uses standard start values and then random values in order to find the set of parameters, 
#' which fit the data best by returning the values with the lowest total squared difference.
#' The function \code{\link{optim}} is used for optimization. Box constraints limit estimations of recollection and familiarity to be positive.
#' A high number of iterations is necessary to get stable estimates. 
#' 
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param falseAlarm A vector containing the false alarm rate.
#' @param hit A vector containing the hit rate.
#' @param iterations A numeric value specifying the number of iterations. Default is set to 200.
#' @param startValues A vector containing start values for the fitting procress. The first position of the vector must hold a value for recollection, the second a value for familiarity and the criterion values have to follow. The number of necessary criterion values is equal to the number of confidence levels - 1. The default uses values between 0.5 and -1.5. 
#' @return The function returns a list with components:
#' \item{recollection}{The median of the estimations recollection.}  
#' \item{familiarity}{The median of the estimations of familiarity.}
#' @references Yonelinas, A. P. (1994). Receiver-operating characteristics in recognition memory: evidence for a dual-process model. Journal of Experimental Psychology: Learning, Memory, and Cognition, 20(6), 1341.
#' @seealso  A MATLAB implementation by Dorian Pustina served as an example for this function. 
#' See \code{\link{github.com/dorianps/memorysolve}}. 
#' @keywords ROC recollection familiarity
#' @export

fitDPSD <- function(falseAlarm, hit, iterations = 200, startValues = c(0.2, 0.5, seq(0.5, -1.5, length = length(falseAlarm)))){
  
  if (length(falseAlarm) != length(hit)) ('Vectors containing hit and false alarm rates do not have the same length')
  
  familiarityEstimates  <- c()
  recollectionEstimates <- c() 
  results               <- c()
  value                 <- c()
  
  # Function calculating total squared prediction error for hit and false alarm rates
  solver  <- function(x){
    oldvar           <- 1
    rn               <- 0
    dpri             <- x[1]
    ro               <- x[2]
    criterion        <- x[3:length(x)]
    
    predhit          <- (1 - ro) * (pnorm(criterion, -dpri, oldvar)) + ro
    predfalseAlarm   <- (1 - rn)*pnorm(criterion, rn, oldvar)
    
    sqdiffhit        <- (hit - predhit) * (hit - predhit)
    sqdifffalseAlarm <- (falseAlarm - predfalseAlarm) * (falseAlarm - predfalseAlarm)
    total            <- sum(sqdiffhit) + sum(sqdifffalseAlarm)
    return(total)
  }
  
 control <- list('maxit', 10000000, 'reltol', 0.0000000001)  
 for (i in 1:iterations){
   cat('\rProgress: |',rep('=',floor((i/iterations)*50)),rep(' ',50 - floor((i/iterations)*50)),'|', sep = '')
    if(i == 1){
      x0  <- startValues
    } else{
      x0  <- c(runif(1, min = 0, max = 1), runif(1, min = 0, max = 3), runif(length(falseAlarm), min = -5, max = 5))
    }

    temp <- try(optim(x0, solver, lower = c(0, 0, -Inf, -Inf, -Inf, -Inf, -Inf), method = "L-BFGS-B", control = control))
    familiarityEstimates[i]  <- temp$par[1]
    recollectionEstimates[i] <- temp$par[2]
    value[i]                 <- temp$value
    
 }
  results$recollection <- recollectionEstimates[which(value == min(value))][1]
  results$familiarity  <- familiarityEstimates[which(value == min(value))][1]
  return(results)
}