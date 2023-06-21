#' Generate a fragment distance vector for your digested DNAString object
#'
#' @param my_DNA, That's your DNAString you aim to digest
#' @param pattern1, the non-PALINDROMIC sequence pattern the restriction enzyme 1 recognizes
#' @param pattern2, OPTIONAL: the non-PALINDROMIC nucleotide sequence pattern the restriction enzyme 2 recognizes
#'
#' @return a fragment length vector
#' @export
#' @importFrom Biostrings matchPattern reverseComplement
#' @importFrom plyranges as_iranges bind_ranges
#' @importFrom dplyr arrange
#' @importFrom stringr str_length
#' @import BSgenome.Hsapiens.UCSC.hg38
#' @examples my_DNA<-gen_DNA(1000)
#' pattern1<-'ATGCTGATT'
#' pattern2<-'CGTGACTGGA'
#' FROG_pal(my_DNA, pattern1, pattern2)
#'
#' library(BSgenome.Hsapiens.UCSC.hg38)
#' chr1_Hsapiens<-BSgenome.Hsapiens.UCSC.hg38$chr1
#'
#' FROG_pal(chr1_Hsapiens, 'ATGCTGATT')
FROG_nonpal<- function(my_DNA, pattern1='ATGCTGATT', pattern2='CGTGACTGGA') {
  #rc the pattern1 string
  pattern1_rc<-reverseComplement(DNAString(pattern1))
  # find matches on both forward and reverse strands
  x<-matchPattern(pattern1, my_DNA)
  y<-matchPattern(pattern1_rc, my_DNA)
  #merge and sort pattern1 and pattern1_rc
  joined_p1<-as_iranges(append(x,y)) |> arrange(start)
  # check if pattern2 is provided
  if (pattern2=='') {
    # if pattern2 is empty, joined_p1 is the final joined object
    joined<-joined_p1} else {
      # if pattern2 is provided, pool pattern1,pattern1_rc + pattern2,pattern2_rc together
      pattern2_rc<-reverseComplement(DNAString(pattern2))
      z<-matchPattern(pattern2, my_DNA)
      w<-matchPattern(pattern2_rc, my_DNA)
      # join and sort pattern2 and pattern2_rc
      joined_p2 <-as_iranges(append(z,w)) |> arrange(start)
      # join everything and sort
      joined<-as_iranges(append(joined_p1,joined_p2)) |> arrange(start) # append! arrange()
    }
  #
  st<-as_iranges(data.frame(start=1, width=1, seq='start'))
  en<-as_iranges(data.frame(start=(str_length(my_DNA)), width=1, seq='end'))

  range1<-bind_ranges(st,joined)
  range2<-bind_ranges(joined,en)
  #
  distances<-range2@start-range1@start #vectorized expression (vs while loop) = much faster
  #
  return(distances)
}
