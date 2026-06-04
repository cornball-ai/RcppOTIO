% tinyrox says don't edit this manually, but it can't stop you!
\name{type_version_map}
\alias{type_version_map}
\title{Registered schema names and their current versions}
\usage{
type_version_map()
}
\value{
A named integer vector mapping schema name to current version.
}
\description{
Registered schema names and their current versions
}
\examples{
library(rotio)
tvm <- type_version_map()
is.integer(tvm)
tvm[["Clip"]]
}
