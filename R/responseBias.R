#' Calculating response bias (c)
#' 
#' This function calculates the response bias (c).
#' To do this, the (log-linear transformed if transformation = TRUE) percentage values are converted to z-values with the help of inverse cumulative distribution function (CDF)
#' of the Gaussian distribution with a mean of 0 and a standard deviation of 1. 
#' Or as a equation:
#' \deqn{c =  -0.5 * (z(hit rate) + z(false alarm rate))}
#' where \eqn{z(p), p in [0,1]} is the inverse Gaussian CDF.
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param oldRating Values corresponding to 'old' responses.
#' @param transformation Logical indicating to choose a log-linear transformation following Snodgrass & Corwin (1988). Default is TRUE. 
#' @param ratings A vector containing all responses.
#' @param oldNew An vector containing whether an item was new/not-studied or old/studied.
#' @param oldNewLevels An vector containing  possible levels of old_newInformation. The first value or level is for new/not-studied 
#' items and the second value is for old/studied items. Defaults to c(0,1).
#' @return The function returns a value for response bias (c).
#' @references Snodgrass, J. G., & Corwin, J. (1988). Pragmatics of measuring recognition memory: Applications to dementia and amnesia. Journal of Experimental Psychology: General, 117(1), 34–50. https://doi.org/10.1037/0096-3445.117.1.34
#' @keywords memory ROC response bias c
#' @name responseBias
#' @export

responseBias <- function(oldRating, ratings, oldNew, oldNewLevels = c(0,1), transformation = TRUE){
  
  # Calculate hit and false alarm rates
  rates <- calcHitFaRates(oldRating, ratings, oldNew, oldNewLevels, transformation)
  
  # Calculate d-prime
  value <- -0.5 * (qnorm(rates$hitRate) + qnorm(rates$falseAlarm_rate))
  
  # Return value
  return(value)
}
