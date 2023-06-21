#' Generate a random DNAString object of length n
#'
#' @param n
#'
#' @return
#' @export
#' @importFrom Biostrings DNAString
#' @examples
gen_DNA<- function(n){
  x<-do.call(paste0, replicate(1, sample(c('A','T','C','G'),n, TRUE), FALSE)) |>
    paste0(collapse = '') |>
    DNAString()
  return(x)
}
