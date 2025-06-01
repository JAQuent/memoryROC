#' Calculating hit and false alarm rates
#' 
#' This function calculates hit and false alarm rates to be used by dPrime and responseBias. The default it to apply log-linear transformed percentage values.
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param oldRating Values corresponding to 'old' responses.
#' @param transformation Logical indicating to choose a log-linear transformation following Snodgrass & Corwin (1988). Default is TRUE. 
#' @param ratings A vector containing all responses.
#' @param oldNew An vector containing whether an item was new/not-studied or old/studied.
#' @param oldNewLevels An vector containing  possible levels of old_newInformation. The first value or level is for new/not-studied 
#' items and the second value is for old/studied items. Defaults to c(0,1).
#' @return The function returns a data frame with hitRate and falseAlarm_rate.
#' @references Snodgrass, J. G., & Corwin, J. (1988). Pragmatics of measuring recognition memory: Applications to dementia and amnesia. Journal of Experimental Psychology: General, 117(1), 34–50. https://doi.org/10.1037/0096-3445.117.1.34
#' @keywords memory ROC hit false alarm
#' @name calcHitFaRates
#' @export

calcHitFaRates <- function(oldRating, ratings, oldNew, oldNewLevels = c(0,1), transformation = TRUE){
  
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
  }

  return(data.frame(hitRate = hitRate, falseAlarm_rate = falseAlarm_rate))
}
