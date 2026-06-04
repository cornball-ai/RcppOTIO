% tinyrox says don't edit this manually, but it can't stop you!
\name{set_children}
\alias{set_children}
\alias{set_children<-}
\title{Replace all children of a composition}
\usage{
set_children(x, children)

set_children(x) <- value
}
\arguments{
\item{x}{A \code{Composition} or \code{SerializableCollection}.}

\item{children,value}{A list of OTIO objects (\code{Composable} for a
Composition; any OTIO object for a SerializableCollection).}
}
\value{
\code{x} (invisibly from the function form).
}
\description{
Available both as a function, \code{set_children(x, kids)}, and as a
replacement, \code{set_children(x) <- kids}.
}
