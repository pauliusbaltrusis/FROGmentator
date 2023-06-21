#' Generate a fragment distance vector for your digested DNAString object
#'
#' @param my_DNA, That's your DNAString you aim to digest
#' @param pattern1, The palindromic sequence pattern the restriction enzyme 1 recognizes
#' @param pattern2, The non-PALINDROMIC nucleotide sequence pattern the restriction enzyme 2 recognizes
#'
#' @return A vector containing fragment lengths
#' @export
#' @importFrom Biostrings matchPattern reverseComplement
#' @importFrom plyranges as_iranges bind_ranges
#' @importFrom dplyr arrange
#' @importFrom stringr str_length
#' @import BSgenome.Hsapiens.UCSC.hg38
#' @examples my_DNA<-gen_DNA(1000)
#' pattern1<-'CATATG'
#' pattern2<-'CGTGACTGGA'
#' FROG_pal(my_DNA, pattern1, pattern2)
#'
#' library(BSgenome.Hsapiens.UCSC.hg38)
#' chr1_Hsapiens<-BSgenome.Hsapiens.UCSC.hg38$chr1
#'
#' FROG_pal(chr1_Hsapiens, pattern1, pattern2)
FROG_mix<- function(my_DNA, pattern1='CATATG', pattern2='CGTGACTGGA') {
  # pattern 1 is palindromic and pattern 2 - non-palindromic
  x<-matchPattern(pattern1, my_DNA)
  # rc of pattern2
  pattern2_rc<-reverseComplement(DNAString(pattern2))
  # pattern2 and pattern2_rc matches to the string
  z<-matchPattern(pattern2, my_DNA)
  w<-matchPattern(pattern2_rc, my_DNA)

  # join pattern2 and pattern2_rc to pattern1 and sort
  joined <-as_iranges(append(x, c(z,w))) |> arrange(start)

  st<-as_iranges(data.frame(start=1, width=1, seq='start'))
  en<-as_iranges(data.frame(start=(str_length(my_DNA)), width=1, seq='end'))

  range1<-bind_ranges(st,joined)
  range2<-bind_ranges(joined,en)
  #
  distances<-range2@start-range1@start #vectorized expression (vs while loop) = much faster
  #
  return(distances)
}
