% tinyrox says don't edit this manually, but it can't stop you!
\name{from_json_string}
\alias{from_json_string}
\title{Read an OTIO object from a JSON string}
\usage{
from_json_string(input)
}
\arguments{
\item{input}{A JSON string.}
}
\value{
The deserialized OTIO object.
}
\description{
Read an OTIO object from a JSON string
}
\examples{
tl <- Timeline("demo")
js <- to_json_string(tl)
tl2 <- from_json_string(js)
is_equivalent_to(tl, tl2)
}
