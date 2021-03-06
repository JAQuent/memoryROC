#' Estimation of recollection and familiarity by fitting to Dual Process Signal Detection (DPSD) model
#'
#' This function allows to estimate recollection and familiarity by fitting data to the DPSD model. 
#' The optimization is attempted by minimizing the total squared difference between observed and 
#' predicted hit and false alarm rates. The Broyden-Fletcher-Goldfarb-Shanno (BFGS) algorithm from the function. 
#' The function first uses standard start values and then random values in order to find the set of parameters, 
#' which fit the data best by returning the values with the lowest total squared difference.
#' The function \code{\link{optim}} is used for optimization. Box constraints limit estimations of recollection and familiarity to be positive.
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param responseScale An vector containing  possible levels of recognition responses ordered from highest to lowest (e.g. 6:1).
#' @param confidenceRatings An vector containing recognition responses according to levels of the variable responseScale.
#' @param oldNew An vector coding whether an item was new/not-studied or old/studied. 
#' @param oldNewLevels An vector containing  possible levels of old_newInformation. The first value or level is for new/not-studied 
#' @param iterations A numeric value specifying the number of iterations. Default is set to 200.
#' @return The function the set of parameters, which showed the lowest total squared difference:
#' \item{recollection}{Estimate of recollection.}  
#' \item{familiarity}{Estimate of familiarity.}
#' @references Yonelinas, A. P. (1994). Receiver-operating characteristics in recognition memory: evidence for a dual-process model. Journal of Experimental Psychology: Learning, Memory, and Cognition, 20(6), 1341.
#' @keywords ROC recollection familiarity DPSD
#' @export

DPSD <- function(responseScale, confidenceRatings, oldNew, oldNewLevels = c(0,1), iterations = 200){
  rates   <- cumRates(responseScale, confidenceRatings, oldNew, oldNewLevels)
  results <- fitDPSD(rates$falseAlarm, rates$hit, iterations)
  return(results)
}