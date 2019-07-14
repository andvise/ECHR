# ------------------------------------------------------------------------------

# Calculates the accuracy.

accuracy <- function(predictions, answers) {
    sum((predictions == answers) / (length(answers)))
}

# ------------------------------------------------------------------------------

# Creates a table with the accuracy for every fold/shuffle and computes its average.

create_accuracy_tables <- function(article_number, average_tables) {
    shuffle_names <- c("shuffle1", "shuffle2", "shuffle3", "shuffle4", "shuffle5", "shuffle6", "shuffle7", "shuffle8", "shuffle9", "shuffle10")
    fold_names <- c("fold1", "fold2", "fold3", "fold4", "fold5", "fold6", "fold7", "fold8", "fold9", "fold10")
    sections_with_voting <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir", "voting", "newvoting")
    
    result_table <- array(dim = c(10,10,10), dimnames = list(sections_with_voting, shuffle_names, fold_names))
    
    accuracy_results <- c()
    
    for (section in sections_with_voting) {
        for (shuffle in 1:10) {
            for (fold in 1:10) {
                if (article_number == "8" && is.na(average_tables[section,shuffle,fold,26])) {
                    result_table[section, shuffle, fold] <- accuracy(average_tables[section,shuffle,fold,1:25], average_tables["outcome",shuffle,fold,1:25])
                } else {
                    result_table[section, shuffle, fold] <- accuracy(average_tables[section,shuffle,fold,], average_tables["outcome",shuffle,fold,])
                }
            }
        }
        accuracy_results <- c(accuracy_results, mean(result_table[section,,]))
    }
    
    print(result_table)
    
    accuracy_section <- setNames(accuracy_results, sections_with_voting)
    print(accuracy_section)
    return(result_table)
}


create_voting <- function(class_table) {
  classifiers <- dimnames(class_table)[[1]]
  articles <- dimnames(class_table)[[2]]
  shuffles <- dimnames(class_table)[[4]]
  folds <- dimnames(class_table)[[5]]
  class_table.voting <- array(dim = c(length(articles), 10, 10, 26), dimnames = list(articles, shuffles,folds,NULL))
  result_tables.voting <- array(dim = c(length(articles), 10, 10), dimnames = list(articles, shuffles,folds))
  
  for (a in articles) {
    for (s in shuffles) {
      for (f in folds) {
        for (i in 1:26) {
          if (is.na(class_table[1,a,"voting",s,f,i])) {
            break
          }
          class_table.voting[a,s,f,i] <- names(which.max(table(class_table[,a,"voting",s,f,i])))
        }
      }
    }
  }  
  for (a in articles) {
  switch(a,
         "3" = {
           fold.size = 25
         },
         "6" = {
           fold.size = 8
         },
         "8" = {
           fold.size = 26
         })
    for (s in shuffles) {
      for (f in folds) {
        if (a == "8" && is.na(class_table[1,a,"outcome",s,f,26])) {
          result_tables.voting[a, s, f] <- accuracy(class_table.voting[a,s,f,1:25], class_table[1,a,"outcome",s,f,1:25])
          
        } else {
          result_tables.voting[a, s, f] <- accuracy(class_table.voting[a,s,f,1:fold.size], class_table[1,a,"outcome",s,f,1:fold.size])
        }
      }
    }
  }
  result_tables.voting
}
result_tables.voting <- create_voting(class_table)
apply(result_tables.voting[,,], 1,mean)
mean(apply(result_tables.voting[,,], 1,mean))

library(rNPBST)
class1 <- "SVM"
article <- "3"
sec1 <- "voting"

btt <-bayesianCorrelatedT.test(as.vector(t(res_tables[class1,article, sec1 , ,])), as.vector(t(result_tables.voting[article,,])), rho = 0.1)

plotPosterior(btt, c("SVM", "Ensemble"), paste("Article ",article))

btt$probabilities

  btt0 <-bayesianCorrelatedT.test(as.vector(t(res_tables[class1,article, sec1 , ,])), as.vector(t(res_tables[class2,article, sec2 , ,])), rho = 0.1, rope.min = 0, rope.max = 0)

#plotPosterior(btt, c("Full", "Circumstances"), paste("Article ",article))
btt0$probabilities