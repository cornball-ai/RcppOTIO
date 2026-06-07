% tinyrox says don't edit this manually, but it can't stop you!
\docType{package}
\name{RcppOTIO-package}
\alias{RcppOTIO}
\alias{RcppOTIO-package}
\title{\packageTitle{RcppOTIO}}
\description{\packageDescription{RcppOTIO}}
\details{
Names follow OTIO exactly: \code{source_range}, \code{range_in_parent},
\code{append_child}, and so on. Tree children are addressed by position
and object reference, never by name.

Because the names are faithful to OTIO, attaching the package with
\code{library(RcppOTIO)} masks a few base functions: \code{comment} and
\code{comment<-} (the \code{Marker} comment accessors) and
\code{remove} (the edit algorithm; base \code{remove} is the alias of
\code{rm}). Use \code{RcppOTIO::} / \code{base::} to disambiguate if you
need both.

}
\section{Package Content}{\packageIndices{RcppOTIO}}
\author{\packageAuthor{RcppOTIO}}
\section{Maintainer}{\packageMaintainer{RcppOTIO}}
\keyword{internal}
