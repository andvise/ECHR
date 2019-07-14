AverageTab <- function(res_tables,classifier) {
  library(xtable)
  articles <- c("3", "6", "8", "Average")
  section <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir", "voting", "newvoting", "Average")
  rows <- length(section)
  cols <- length(articles)
  avgtab <- array(dim = c(rows, cols), dimnames = list(section, articles))
  for (a in articles[1:(cols-1)]) {
    for (s in section[1:(rows-1)]) {
      avgtab[s,a] <- mean(res_tables[classifier, a, s, , ])
      
    }
    avgtab[rows, a] <- mean(avgtab[1:(rows-1),a])
  }

  for (s in section) {l
    avgtab[s,cols] <-  mean(avgtab[s,1:(cols-1)])
  }
  print(avgtab)
  print(xtable(avgtab*100, digits = 1))
    
}

res <-AverageTab(res_tables,"KNN")

## finding the differences between the different shuffles
ShuffleDifference <- function(res_tables, classifier) {
  library(xtable)
  articles <- c("3", "6", "8", "Average")
  section <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir", "voting", "newvoting", "Average")
  section <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir", "Average")
  rows <- length(section)
  cols <- length(articles)
  avgtab <- array(dim = c(rows, cols), dimnames = list(section, articles))
  for (a in articles[1:(cols-1)]) {
    for (s in section[1:(rows-1)]) {
      avgtab[s,a] <- max(apply(res_tables[classifier,a,s,,], 1,mean)) - min(apply(res_tables[classifier,a,s,,], 1,mean))
      
    }
    avgtab[rows, a] <- mean(avgtab[1:(rows-1),a])
  }
  
  for (s in section) {
    avgtab[s,cols] <-  mean(avgtab[s,1:(cols-1)])
  }
  #rownames(avgtab) <- c("Full", "Procedure", "Circumstances", "Relevant Law", "Law", "Topics", "Facts", "Topics and Cir", "Voting", "newvoting", "Average")
  print(avgtab)
  print(xtable(avgtab*100, digits = 1))
  
}
ShuffleDifference(res_tables,"SVM")
## Code necessary to make it work:
# once
require(devtools)
install_version("ggplot2", version = "2.2.1")

#all the times
is_theme_complete <- function(x) isTRUE(attr(x, "complete"))


cvres <- array(dim = c(3,100))
for (i in 1:3) {
  cvres[i,] <- as.vector(t(res_tables["SVM",i,"voting",,])) - as.vector(t(res_tables["SVM",i,"topcir",,]))
}
bsrt <- bayesianSignedRank.test(apply(res_tables["SVM",,"voting",,], 1,mean),apply(res_tables["SVM",,"topcir",,], 1,mean))
bst <- bayesianSign.test(apply(res_tables["SVM",,"voting",,], 1,mean),apply(res_tables["SVM",,"topcir",,], 1,mean))

bsrt$probabilities
bst$probabilities
plotSimplex(bsrt$sample, 5000)
htest <- hierarchical.test(cvres, sample_file = "simfile.txt")
library(rNPBST)



sections <- c("full", "circumstances", "topics", "topcir")
sec2 <- "voting"
articles <- c("3", "6", "8")
class1 <- "SVM"
class2 <- class1
tab <- array(dim = c(length(sections) * length(articles), 3), dimnames = list(rep(" ",length(sections) * length(articles)), c("left","rope","right")))
count = 1
for (s in sections) {
  for ( a in articles) {
    btt <-bayesianCorrelatedT.test(as.vector(t(res_tables[class1,a, sec2 , ,])), as.vector(t(res_tables[class2,a, s , ,])), rho = 0.1)
    tab[count, ] <- btt$probabilities 
    dimnames(tab)[[1]][count] <- paste(s,a,sep = " ")
    count <- count +1
  }
}
tab
print(xtable(tab*100, digits = 1))




class1 <- "SVM"
class2 <- class1
article <- "3"
sec1 <- "voting"
sec2 <- "full"

btt <-bayesianCorrelatedT.test(as.vector(t(res_tables[class1,article, sec1 , ,])), as.vector(t(res_tables[class2,article, sec2 , ,])), rho = 0.1)

plotPosterior(btt, c("Topics", "Circumstances"), paste("Article ",article))
btt$probabilities

btt0 <-bayesianCorrelatedT.test(as.vector(t(res_tables[class1,article, sec1 , ,])), as.vector(t(res_tables[class2,article, sec2 , ,])), rho = 0.1, rope.min = 0, rope.max = 0)

#plotPosterior(btt, c("Full", "Circumstances"), paste("Article ",article))
btt0$probabilities


Facts vs Circumstrances Art 6
left      rope     right 
0.5000000 0.2555666 0.2444334 
left      rope     right 
0.6354682 0.0000000 0.3645318 

Full vs Circumstrances Art 6
left      rope     right 
0.2120139 0.2376822 0.5503039 
left      rope     right 
0.3215603 0.0000000 0.6784397 

Full vs Circumstrances Art 8
left      rope     right 
0.2520653 0.4205135 0.3274213 
left      rope     right 
0.4559107 0.0000000 0.5440893 

Voting vs Topcir Art 3
left      rope     right 
0.4865875 0.3032067 0.2102058 
left      rope     right 
0.6504583 0.0000000 0.3495417 

Voting vs Topcir Art 6
left       rope      right 
0.03483734 0.07735588 0.88780678 
left      rope     right 
0.0648209 0.0000000 0.9351791 

Votings vs Topcir Art 8 
left      rope     right 
0.3519733 0.3660860 0.2819407 


Voting vs Topics Art 3
> btt$probabilities
left      rope     right 
0.7275002 0.1880750 0.0844248 
left      rope     right 
0.8393302 0.0000000 0.1606698 

Voting vs Topics Art 6
left       rope      right 
0.04056841 0.08886780 0.87056380 
left       rope      right 
0.07526999 0.00000000 0.92473001 


Voting vs Topics Art 8
0.1668139 0.3105216 0.5226645 
0.3041003 0.0000000 0.6958997 


Voting vs Full Art 3
left       rope      right 
0.02857389 0.16862735 0.80279876 
left       rope      right 
0.08382267 0.00000000 0.91617733 

Voting vs Full Art 6
left       rope      right 
0.07600544 0.25467584 0.66931872 
left      rope     right 
0.1743771 0.0000000 0.8256229 

Voting vs Full Art 8
left      rope     right 
0.0693930 0.3601698 0.5704372 
left      rope     right 
0.2028213 0.0000000 0.7971787 
