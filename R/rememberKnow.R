#' Estimation of recollection and familiarity using the ROC Remember/Know procedure
#'
#' This function allows to estimate recollection and familiarity using ROC Remember/Know procedure.
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param rememberLevels A value indicating the code for the remember response.
#' @param knowLevels A vector contatining the codes for the know responses.
#' @param oldNew An vector coding whether an item was new/not-studied or old/studied.
#' @param confidenceRatings An vector containing recognition responses coding remember and know responses.
#' @param oldNewLevels An vector containing  possible levels of old_newInformation. The first value or level is for new/not-studied 
#' items and the second value is for old/studied items. Defaults to c(0,1).
#' @details The value of \code{\link{recollection}} is represented by the probability of a remember response for old items. The value of 
#' \code{\link{familiarity}} is represented by the probability for a know response for old items divided by 1  - \code{\link{recollection}}.
#' @return The function returns a list with components:
#' \item{recollection}{The estimation of recollection.}
#' \item{familiarity}{The estimation of familiarity.} 
#' @keywords memory ROC recollection familiarity Remember/Know
#' @references Yonelinas, A. P. (2001). Consciousness, Control, and Confidence: The 3 Cs of Recognition Memory. Journal of Experimental Psychology. General, 130(3), 361.
#' @export


rememberKnow <- function(rememberLevels, knowLevels, confidenceRatings, oldNew, oldNewLevels = c(0,1)){
  results     <- c()
  
  newStimuli <- confidenceRatings[which(oldNew == oldNewLevels[1])]
  oldStimuli <- confidenceRatings[which(oldNew == oldNewLevels[2])]
  
  results$recollection <- sum(oldStimuli == rememberLevels)/length(oldStimuli)
  temp <- 0
  for(i in 1:length(knowLevels)){
    temp <- temp + (sum(oldStimuli == knowLevels[i])/length(oldStimuli))
  }
  results$familiarity  <- temp / (1 - results$recollection)
  return(results)
}