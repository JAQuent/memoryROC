#' Calculating d-prime (d')
#' 
#' This function caculates the dimensionless statistic d-prime (d').
#' To do this, the (log-linear tranformed) percentage values are converted to z-values with the help of inverse cumulative distribution function (CDF)
#' of the Gaussian distribution with a mean of 0 and a standard deviation of 1. 
#' Or as a equation:
#' \deqn{d' = z(hit rate) - z(false alarm rate)}
#' where \eqn{z(p), p in [0,1]} is the inverse Gaussian CDF.
#' 
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param oldRating A value indicating the code for the remember response.
#' @param transformation Logical indicating to choose a log-linear tranformation following Snodgrass & Corwin (1988). Default is TRUE. 
#' @param ratings A vector contatining the codes for the know responses.
#' @param oldNew An vector coding whether an item was new/not-studied or old/studied.
#' @param oldNewLevels An vector containing  possible levels of old_newInformation. The first value or level is for new/not-studied 
#' items and the second value is for old/studied items. Defaults to c(0,1).
#' @return The function returns a value for d'.
#' @references Snodgrass, J. G., & Corwin, J. (1988). Pragmatics of measuring recognition memory: Applications to dementia and amnesia. Journal of Experimental Psychology: General, 117(1), 34–50. https://doi.org/10.1037/0096-3445.117.1.34
#' @keywords memory ROC d-prime d'
#' @export

dPrime <- function(oldRating, ratings, oldNew, oldNewLevels = c(0,1), transformation = TRUE){
  
  if(transformation){
    newStimuli <- ratings[which(oldNew == oldNewLevels[1])]
    oldStimuli <- ratings[which(oldNew == oldNewLevels[2])]
    
    hits        <- 0
    falseAlarms <- 0
    
    for(i in 1:length(oldRating)){
      hits        <- hits + (sum(oldStimuli == oldRating[i]))
      falseAlarms <- falseAlarms + (sum(newStimuli == oldRating[i]))
    }
    hitRate         <- (hits + 0.5) /(length(oldStimuli) + 1)
    falseAlarm_rate <- (falseAlarms + 0.5) /(length(newStimuli) + 1)
    
    value <- qnorm(hitRate) - qnorm(falseAlarm_rate)
  } else{
    newStimuli <- ratings[which(oldNew == oldNewLevels[1])]
    oldStimuli <- ratings[which(oldNew == oldNewLevels[2])]
    
    hits        <- 0
    falseAlarms <- 0
    
    for(i in 1:length(oldRating)){
      hits        <- hits + (sum(oldStimuli == oldRating[i]))
      falseAlarms <- falseAlarms + (sum(newStimuli == oldRating[i]))
    }
    hitRate         <- hits/length(oldStimuli)
    falseAlarm_rate <- falseAlarms/length(newStimuli)
    
    value <- qnorm(hitRate) - qnorm(falseAlarm_rate)
  }

  return(value)
}