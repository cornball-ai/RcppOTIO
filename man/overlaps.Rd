% tinyrox says don't edit this manually, but it can't stop you!
\name{overlaps}
\alias{overlaps}
\title{Does a TimeRange overlap another range?}
\usage{
overlaps(tr, other, epsilon_s = 1/384000)
}
\arguments{
\item{epsilon_s}{Tolerance in seconds.}

\item{tr,other}{\code{TimeRange} objects.}
}
\value{
Logical.
}
\description{
Does a TimeRange overlap another range?
}
