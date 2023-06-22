#' Plot the saved vector (fragment length) outputs generated with FROG_pal, FROG_nonpal or FROG_mix
#'
#' @param x, Saved output from FROG_pal, FROG_nonpal or FROG_mix (alternatively, an integer vector)
#' @param pattern1, Pattern1 used for digesting the DNAString
#' @param pattern2, Pattern2 used for digesting the DNAString
#'
#' @return Fragment length distributions and a table with basic descriptive statistics
#' @export
#' @import tidyverse
#' @import tibble
#' @import ggplot2
#' @import ggpubr
#' @import patchwork
#' @examples
#' library(FROGmentator)
#' my_DNA<-gen_DNA(1000)
#' pattern1<-'GATC'
#' FROG_pal_output<-FROG_pal(my_DNA, pattern1)
#' FROG_plot(FROG_pal_output, pattern1)
FROG_plot<- function(x, pattern1='', pattern2='') {
  my_filter<-mean(x)+3*sd(x) #apply a rough mean+3sd filter to avoid super long fragments
  #
  p1<-x[x<my_filter] %>% as.data.frame(.) %>% ggplot(aes(.))+
    geom_histogram(aes(), binwidth =mean(x)) + labs(x='frag length | 99.7% of data') + theme_bw()
  ##
  p2<-x[x<1000] %>% as.data.frame() %>% ggplot(aes(.))+
    geom_histogram(aes()) + labs(x='frag length | library prep') +scale_x_continuous(limits = c(1, 1000)) + theme_bw()
  ###
  table3<-tibble(mean=sprintf('%.1f',mean(x)), median=median(x), std=sprintf('%.1f',sd(x)), min=min(x), max=max(x), n=length(x), 'fr300-600'= nrow(filter(as.data.frame(x), x<300 & x<600))) %>% ggtexttable(rows = NULL, theme = ttheme('light')) %>% tab_add_title(text = 'Some descriptive statistics*', face = 'bold') %>% tab_add_title(text = '') %>% tab_add_footnote(text='*Fragment length means, median, standard deviation, min-max, total count \n and count between 300-600bp',padding = unit(1, 'line'), size = 9) %>% tab_add_footnote(text = 'Used here: hg38-UCSC-chr1', size = 8,face = 'italic', padding = unit(1,'line'))
  p<-(p1+p2)/(table3)
  p<-p+plot_annotation(title='Fragment outputs generated*', caption = paste('*Using enzyme(s) recognizing', pattern1, '/', pattern2))
  return(p)
  }
