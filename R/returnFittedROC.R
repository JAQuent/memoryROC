#' Returning false alarm and hit rates for the Dual Process Signal Detection (DPSD)
#'
#' This function allows you to get the correspending false alarm and hit rates for a given set of recollection 
#' and familiarity assuming that the variance of the old item distirbution is 1. This is helpful to compare  
#' raw hit and false alarm rates with fitted ones. 
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param recollection A value representing the recollection rate.
#' @param familiarity A value representing the familiarity rate
#' @return The function returns a list with components:
#' \item{falseAlarm}{The fitted false alarm rate.}
#' \item{hit}{The fitted hit rate.} 
#' @references Yonelinas, A. P., & Parks, C. M. (2007). Receiver operating characteristics (ROCs) in recognition memory: A review. Psychological Bulletin, 133(5), 800 - 832. http://doi.org/10.1037/0033-2909.133.5.800
#' @keywords memory ROC
#' @export

returnFittedROC       <- function(recollection, familiarity){
  rn                  <- 0
  oldvar              <- 1
  results             <- c()
  results$falseAlarm  <- c(seq(0.001, 0.99999, 0.01), 0.99999)
  criterion           <- qnorm(results$falseAlarm/(1 - rn), 0, 1)
  criterion[which(results$falseAlarm/(1 - rn) > 1)] <- 1000
  results$hit        <- results$falseAlarm + recollection + (1 - recollection)*pnorm(criterion, - familiarity, oldvar) - (1 - rn)*pnorm(criterion, 0, 1)
  results$hit[results$hit > 1] <- 1
  return(data.frame(results))
}
