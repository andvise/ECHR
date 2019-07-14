instances = 25

voting_table <- array(dim=c(instances,100,3))
voting_table[,,1] <- svm_av_table[,,"voting",]
voting_table[,,2] <- gbm_av_table[,,"voting",]
voting_table[,,3] <- knn_av_table[,,"voting",]
View(voting_table)

# print(voting_table)

# ------------------------------------------------------------------------------

count_voting <- function(voting_svm, voting_gbm, voting_knn) {
    count_Y <- 0
    count_N <- 0

    if (voting_svm == "Y") count_Y <- count_Y + 1
    else if (voting_svm == "N") count_N <- count_N + 1
    
    if (voting_gbm == "Y") count_Y <- count_Y + 1
    else if (voting_gbm == "N") count_N <- count_N + 1
    
    if (voting_knn == "Y") count_Y <- count_Y + 1
    else if (voting_knn == "N") count_N <- count_N + 1
    
    
    if (count_Y > count_N) {
        return("Y") 
    } else {
        return("N")
    }
}

# ------------------------------------------------------------------------------

# Calculates the accuracy.

accuracy <- function(predictions, answers) {
    sum((predictions==answers) / (length(answers)))
}

# ------------------------------------------------------------------------------

fold_names_with_average <- c("fold1", "fold2", "fold3", "fold4", "fold5", "fold6", "fold7", "fold8", "fold9", "fold10", "average")
fold_names <- c("fold1", "fold2", "fold3", "fold4", "fold5", "fold6", "fold7", "fold8", "fold9", "fold10", "accuracy")
shuffle_names <- c("shuffle1", "shuffle2", "shuffle3", "shuffle4", "shuffle5", "shuffle6", "shuffle7", "shuffle8", "shuffle9", "shuffle10")
voting_result <- array(dim=c(instances,11, 10), dimnames=list(NULL, fold_names, shuffle_names))
accuracy_results <- c()

for (i in 1:10) {
    for (j in 1:10) {
        for (k in 1:instances) {
            voting_result[k,j,i] <- count_voting(svm_av_table[k,j,"voting", i], gbm_av_table[k,j,"voting", i], knn_av_table[k,j,"voting", i])
        }
    }
}

for (i in 1:10) {
    for (k in 1:instances) {
        voting_result[k,11,i] <- accuracy(voting_result[k,1:10,i], average_tables[k,1:10,"outcome",i])
    }
    accuracy_results <- c(accuracy_results, mean(as.numeric(voting_result[,"accuracy",i])))
}

accuracy_section <- setNames(accuracy_results, shuffle_names)
print(accuracy_section)
print(mean(accuracy_results))
