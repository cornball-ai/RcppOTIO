% tinyrox says don't edit this manually, but it can't stop you!
\name{to_json_file}
\alias{to_json_file}
\title{Write an OTIO object to a JSON file}
\usage{
to_json_file(x, file_name, indent = 4L, target_schema_versions = NULL)
}
\arguments{
\item{x}{An OTIO object.}

\item{file_name}{Destination path.}

\item{indent}{Indentation width (spaces).}

\item{target_schema_versions}{Optional named integer vector of schema
downgrade targets; see \code{\link{to_json_string}}.}
}
\value{
\code{TRUE} on success (invisibly).
}
\description{
Write an OTIO object to a JSON file
}
\examples{
tl <- Timeline("demo")
f <- tempfile(fileext = ".otio")
to_json_file(tl, f)
unlink(f)
}
