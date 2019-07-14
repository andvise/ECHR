
library(caret)

# ------------------------------------------------------------------------------

seeds <- c(1234, 1989, 290889, 251091, 240664, 190364, 120863, 101295, 31089, 3573113)
labels   <- c("full", "procedure", "circumstances", "relevantLaw", "facts", "law", "topcir", "topics", "voting", "outcome")
sections <- c("full", "procedure", "circumstances", "relevantLaw", "facts", "law", "topcir", "topics")
sections_with_voting <- c("full", "procedure", "circumstances", "relevantLaw", "facts", "law", "topcir", "topics", "voting")

path <- "~/projects/ECHR-judicial-decisions/data/Article3/"

average_tables <- array(dim = c(25,10,10,10), dimnames = list(NULL, NULL, labels, NULL))

# for every table
for (i in 1:10) {
    print(i)
    # shuffle
    set.seed(seeds[i])
    shuffle <- runif(250)
    
    # for every section
    for (section in sections) {
        
        # path
        if (section == "topics") {
            file <- "formatted_topics3.csv"
            total_data <- 30
        } else if (section == "topcir") {
            file <- "formatted_topicsAndCircumstances.csv"
            total_data <- 2030
        } else {
            file <- paste("formatted_ngrams_a3_", section, ".csv", sep="")
            total_data <- 2000
        }
        
        exp_data <- read.csv(paste(path, file, sep=""))
        # shuffle data
        data <- exp_data[order(shuffle),]
        
        fitControl <- trainControl(method="none")
        svmGrid <-  expand.grid(C = 550)
        gbmGrid <-  expand.grid(interaction.depth = 9, 
                                n.trees = 1150, 
                                shrinkage = 0.1,
                                n.minobsinnode = 10)
        knnGrid <-  expand.grid(k = 9)
        
        # 10 x 25 folds
        folds <- cut(seq(1, 250), breaks=10, labels=FALSE)
        
        # for every fold
        for (l in 1:10) {
            
            test_indexes <- which(folds==l,arr.ind=TRUE)
            
            test_data       <- data[test_indexes,1:total_data]
            train_data      <- data[-test_indexes,1:total_data]
            test_class      <- as.factor(data[test_indexes,total_data+1])
            train_class     <- as.factor(data[-test_indexes,total_data+1])
            
            # train
            fit_svm <- train(x = train_data,
                             y = train_class,
                             method="svmLinear",
                             metric="Accuracy",
                             trControl=fitControl,
                             scale = FALSE,
                             tuneGrid = svmGrid)
            
            fit_gbm <- train(x = train_data,
                             y = train_class,
                             method = "gbm",
                             trControl = fitControl,
                             tuneGrid = gbmGrid,
                             metric = "Accuracy",
                             verbose = FALSE)
            
            fit_knn <- train(x = train_data,
                             y = train_class,
                             method="knn",
                             metric="Accuracy",
                             trControl=fitControl,
                             tuneGrid = knnGrid)
            
            fit_clf <- NULL
            
            if (section == "full") fit_clf = fit_gbm
            else if (section == "procedure") fit_clf = fit_svm
            else if (section == "circumstances") fit_clf = fit_gbm
            else if (section == "relevantLaw") fit_clf = fit_svm
            else if (section == "facts") fit_clf = fit_svm
            else if (section == "law") fit_clf = fit_gbm
            else if (section == "topics") fit_clf = fit_svm
            else if (section == "topcir") fit_clf = fit_gbm
            
            prediction <- predict(object=fit_clf, test_data[,1:total_data])
            average_tables[,l,section,i] <- prediction
            
            if (section == "topics") {
                
                # voting
                row <- apply(average_tables[,l,,i], 1, table)
                # for every row
                for (h in 1:25) {
                    voting <- names(sort(row[[h]], decreasing=TRUE)[1])
                    if (is.null(voting)) {
                        voting <- names(sort(row[,h], decreasing=TRUE)[1])
                    }
                    average_tables[h,l,"voting",i] <- voting
                }
                
                # outcome
                average_tables[,l,"outcome",i] <- test_class  # ending with topics
            }
        }  # end for fold
    }  # end for section
}  # end for table

# change 1s and 2s into N and Y
average_tables[which(average_tables == "1")] <- "N"
average_tables[which(average_tables == "2")] <- "Y"

# ------------------------------------------------------------------------------

# Calculates the accuracy.

accuracy <- function(predictions, answers) {
    sum((predictions==answers) / (length(answers)))
}

# ------------------------------------------------------------------------------

# Creates a table with the accuracy for every fold/shuffle and computes its average.

shuffle_names <- c("shuffle1", "shuffle2", "shuffle3", "shuffle4", "shuffle5", "shuffle6", "shuffle7", "shuffle8", "shuffle9", "shuffle10")
fold_names <- c("fold1", "fold2", "fold3", "fold4", "fold5", "fold6", "fold7", "fold8", "fold9", "fold10", "average")
sections_with_voting <- c("full", "procedure", "circumstances", "relevantLaw", "facts", "law", "topcir", "topics", "voting")

result_table <- array(dim = c(10,11,9), dimnames = list(shuffle_names, fold_names, sections_with_voting))

accuracy_results <- c()

for (section in sections_with_voting) {
    for (shuffle in 1:10) {
        for (fold in 1:10) {
            result_table[shuffle,fold,section] <- accuracy(average_tables[,fold,section,shuffle], average_tables[,fold,"outcome",shuffle])
        }
        result_table[shuffle,"average",section] <- mean(result_table[shuffle,1:10,section])
    }
    accuracy_results <- c(accuracy_results, mean(result_table[,"average",section]))
}

print(result_table)

accuracy_section <- setNames(accuracy_results, sections_with_voting)
print(accuracy_section)
