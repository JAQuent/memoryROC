#' Caculation of Area Under the Curve (AUC) for an ROC plot
#'
#' This function calculates the AUC by summing the tri- and rectangles, which can be made of each point. 
#' If missing, the y-intercept is added by linear interpolation. The last point, where both false Alarm rates reach 1, is also added. 
#' @author Joern Alexander Quent, \email{alexander.quent@rub.de}
#' @param falseAlarm A vector containing the false alarm rate.
#' @param hit A vector containing the hit rate.
#' @return The function returns the estimation of AUC.
#' @keywords memory ROC Area Under Curve AUC
#' @export

rocAUC <- function(falseAlarm, hit){
  # Adding a y-intercept by linear interpolation
  if (min(falseAlarm) != 0){
    linear_slope     <- (hit[2] - hit[1])/(falseAlarm[2] - falseAlarm[1])
    linear_intercept <- hit[1] - linear_slope * falseAlarm[1]
    falseAlarm <- c(0, falseAlarm, 1)
    hit        <- c(linear_intercept, hit, 1)
  } else {
    falseAlarm <- c(falseAlarm, 1)
    hit        <- c(hit, 1)
  }
  
  # Calculating AUC by summing the areas of triangles and rectangles
  AUC <- 0
  for(i in 1:(length(hit) - 1)){
    triangle  <- (falseAlarm[i + 1] -  falseAlarm[i]) * (hit[i + 1]- hit[i])/2
    rectangle <- (falseAlarm[i + 1] -  falseAlarm[i]) * hit[i]
    AUC       <- AUC + triangle + rectangle
  }
  return(AUC)
}