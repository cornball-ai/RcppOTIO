% tinyrox says don't edit this manually, but it can't stop you!
\name{is_missing_reference}
\alias{is_missing_reference}
\title{Is this a MissingReference?}
\usage{
is_missing_reference(x)
}
\arguments{
\item{x}{A \code{MediaReference}.}
}
\value{
Logical.
}
\description{
Is this a MissingReference?
}
\examples{
is_missing_reference(MissingReference("x"))
is_missing_reference(ExternalReference("a.mov"))
}
