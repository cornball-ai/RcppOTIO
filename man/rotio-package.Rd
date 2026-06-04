% tinyrox says don't edit this manually, but it can't stop you!
\docType{package}
\name{rotio-package}
\alias{rotio}
\alias{rotio-package}
\title{\packageTitle{rotio}}
\description{\packageDescription{rotio}}
\details{
Names follow OTIO exactly: \code{source_range}, \code{range_in_parent},
\code{append_child}, and so on. Tree children are addressed by position
and object reference, never by name.

Because the names are faithful to OTIO, attaching the package with
\code{library(rotio)} masks \code{base::comment} and
\code{base::comment<-} (these are the OTIO \code{Marker} comment
accessors). Use \code{rotio::comment} / \code{base::comment} to
disambiguate if you need both.

}
\section{Package Content}{\packageIndices{rotio}}
\author{\packageAuthor{rotio}}
\section{Maintainer}{\packageMaintainer{rotio}}
\keyword{internal}
