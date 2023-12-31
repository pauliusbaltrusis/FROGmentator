% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FROG_mix.R
\name{FROG_mix}
\alias{FROG_mix}
\title{Generate a fragment distance vector for your digested DNAString object}
\usage{
FROG_mix(my_DNA, pattern1 = "CATATG", pattern2 = "CGTGACTGGA")
}
\arguments{
\item{my_DNA, }{That's your DNAString you aim to digest}

\item{pattern1, }{The palindromic sequence pattern the restriction enzyme 1 recognizes}

\item{pattern2, }{The non-PALINDROMIC nucleotide sequence pattern the restriction enzyme 2 recognizes}
}
\value{
A vector containing fragment lengths
}
\description{
Generate a fragment distance vector for your digested DNAString object
}
\examples{
my_DNA<-gen_DNA(1000)
pattern1<-'CATATG'
pattern2<-'CGTGACTGGA'
FROG_pal(my_DNA, pattern1, pattern2)

library(BSgenome.Hsapiens.UCSC.hg38)
chr1_Hsapiens<-BSgenome.Hsapiens.UCSC.hg38$chr1

FROG_pal(chr1_Hsapiens, pattern1, pattern2)
}
