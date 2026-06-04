% tinyrox says don't edit this manually, but it can't stop you!
\name{from_json_file}
\alias{from_json_file}
\title{Read an OTIO object from a JSON file}
\usage{
from_json_file(file_name)
}
\arguments{
\item{file_name}{Source path.}
}
\value{
The deserialized OTIO object.
}
\description{
Read an OTIO object from a JSON file
}
\examples{
tl <- Timeline("demo")
f <- tempfile(fileext = ".otio")
to_json_file(tl, f)
tl2 <- from_json_file(f)
unlink(f)
is_equivalent_to(tl, tl2)
}
