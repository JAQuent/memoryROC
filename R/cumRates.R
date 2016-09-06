#' Extraction of cumulative hit and false alarm rates for memory ROC analysis
#'
#' This function allows you to extract cumulative hit and false alarm rates for memory ROC analysis.
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param responseScale An vector containing  possible levels of recognition responses ordered from highest to lowest (e.g. 6:1).
#' @param confidenceRatings An vector containing recognition responses according to levels of the variable responseScale.
#' @param oldNew An vector coding whether an item was new/not-studied or old/studied. 
#' @param old_newLevel An vector containing  possible levels of oldNew. The first value or level is for new/not-studied 
#' items and the second value is for old/studied items. Defaults to c(0,1).
#' @return The function returns a list with components:
#' \item{falseAlarm}{The extracted false alarm rate.}
#' \item{hit}{The extracted hit rate.} 
#' @keywords ROC hit false alarm
#' @export

cumRates <- function(responseScale, confidenceRatings, oldNew, old_newLevel = c(0,1)){
  scaleLength <- length(responseScale)
  falseAlarm  <- c()
  hit         <- c()
  results     <- c()
  newStimuli <- confidenceRatings[which(oldNew == old_newLevel[1])]
  oldStimuli <- confidenceRatings[which(oldNew == old_newLevel[2])]
  for(i in 1:(scaleLength - 1)){
    if(i < 2){
      hit[i] <- sum(oldStimuli == responseScale[i]) / length(oldStimuli)
      falseAlarm[i] <- sum(newStimuli == responseScale[i]) / length(newStimuli)
    } else {
      hit[i]        <- hit[i - 1] + sum(oldStimuli == responseScale[i]) / length(oldStimuli)
      falseAlarm[i] <- falseAlarm[i - 1] + sum(newStimuli == responseScale[i]) / length(newStimuli)
    }
  }
  results$falseAlarm <- falseAlarm
  results$hit        <- hit
  return(data.frame(results))
}