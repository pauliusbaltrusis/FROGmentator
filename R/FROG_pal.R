#' Generate a fragment distance vector for your digested DNAString object
#'
#' @param my_DNA, That's your DNAString you aim to digest
#' @param pattern1, the palindromic nucleotide sequence pattern the restriction enzyme 1 recognizes
#' @param pattern2, OPTIONAL: the palindromic nucleotide sequence pattern the restriction enzyme 2 recognizes
#'
#' @return a fragment length vector
#' @export
#' @importFrom Biostrings matchPattern
#' @importFrom plyranges as_iranges bind_ranges
#' @importFrom dplyr arrange
#' @importFrom stringr str_length
#' @examples my_DNA<-gen_DNA(1000)
#' pattern1<-'CGTACG'
#' FROG_pal(my_DNA, pattern1)
FROG_pal<- function(my_DNA, pattern1='CGTACG', pattern2='') {
  x<-matchPattern(pattern1, my_DNA)
  if (pattern2=='') {
    joined<-as_iranges(x)} else {
      y<-matchPattern(pattern2, my_DNA)
      joined<-as_iranges(append(x,y)) |> arrange(start)
    }
  st<-as_iranges(data.frame(start=1, width=1, seq='start'))
  en<-as_iranges(data.frame(start=(str_length(my_DNA)), width=1, seq='end'))

  range1<-bind_ranges(st,joined)
  range2<-bind_ranges(joined,en)

  distances<-range2@start-range1@start

  return(distances)
}
