% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cumRates.R
\name{cumRates}
\alias{cumRates}
\title{Extraction of cumulative hit and false alarm rates for memory ROC analysis}
\usage{
cumRates(responseScale, confidenceRatings, oldNew, old_newLevel = c(0, 1))
}
\arguments{
\item{responseScale}{An vector containing  possible levels of recognition responses ordered from highest to lowest (e.g. 6:1).}

\item{confidenceRatings}{An vector containing recognition responses according to levels of the variable responseScale.}

\item{oldNew}{An vector coding whether an item was new/not-studied or old/studied.}

\item{old_newLevel}{An vector containing  possible levels of oldNew. The first value or level is for new/not-studied 
items and the second value is for old/studied items. Defaults to c(0,1).}
}
\value{
The function returns a list with components:
\item{falseAlarm}{The extracted false alarm rate.}
\item{hit}{The extracted hit rate.}
}
\description{
This function allows you to extract cumulative hit and false alarm rates for memory ROC analysis.
}
\author{
Joern Alexander Quent, \email{alexander.quent@rub.de}
}
\keyword{ROC}
\keyword{alarm}
\keyword{false}
\keyword{hit}
