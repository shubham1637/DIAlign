% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/merge_osw_mzml.R
\name{mergeOswAnalytes_ChromHeader}
\alias{mergeOswAnalytes_ChromHeader}
\title{Merge dataframes from OSW and mzML files}
\usage{
mergeOswAnalytes_ChromHeader(
  oswAnalytes,
  chromHead,
  analyteFDR = 1,
  runType = "DIA_Proteomics"
)
}
\arguments{
\item{oswAnalytes}{(dataframe) This is an output of getOswFiles.}

\item{chromHead}{(dataframe) This has two columns: chromatogramId and chromatogramIndex with integer values.}

\item{analyteFDR}{(numeric) Not used.}

\item{runType}{(char) This must be one of the strings "DIA_Proteomics", "DIA_Metabolomics".}
}
\value{
Invisible NULL
}
\description{
Merges dataframes on transition_id(OSW) = chromatogramId(mzML).
}
\seealso{
\code{\link{getOswFiles}}
}
\author{
Shubham Gupta, \email{shubh.gupta@mail.utoronto.ca}

ORCID: 0000-0003-3500-8152

License: (c) Author (2019) + GPL-3
Date: 2019-12-13
}
\keyword{internal}
