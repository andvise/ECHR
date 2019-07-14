# ECHR (GBM)

# run GBM_Accuracy()

# ------------------------------------------------------------------------------

source("~/projects/ECHR-judicial-decisions/src/util/ArticleTables.R")
source("~/projects/ECHR-judicial-decisions/src/util/AccuracyTables.R")
library(caret)
seeds <- c(1234, 1989, 290889, 251091, 240664, 190364, 120863, 101295, 31089, 3573113)

# ------------------------------------------------------------------------------

GBM_Accuracy <- function(article_number) {

    sections <- c("full", "procedure", "circumstances", "relevantLaw", "facts", "law", "topcir", "topics")
    path <- paste("~/projects/ECHR-judicial-decisions/data/Article", article_number, "/", sep="")
    average_tables <- create_average_tables(article_number)

    # for every shuffle
    for (i in 1:10) {
        max_fold <- fold(article_number)
        # shuffle
        set.seed(seeds[i])
        shuffle <- runif(max_fold)
        # for every section
        for (section in sections) {
            print(i)
            file        <- name_of_file(article_number, section)
            total_data  <- total_data_for_file(section)

            exp_data    <- read.csv(paste(path, file, sep=""))
            # shuffle data
            data        <- exp_data[order(shuffle),]

            fitControl  <- trainControl(method="none")
            # parameter tuning
            gbmGrid     <- expand.grid(interaction.depth = 9,
                                       n.trees = 1150,
                                       shrinkage = 0.1,
                                       n.minobsinnode = 10)

            # 10 x 25/8/26 folds
            folds       <- cut(seq(1, max_fold), breaks=10, labels=FALSE)

            # for every fold
            for (l in 1:10) {

                test_indexes    <- which(folds==l,arr.ind=TRUE)

                test_data       <- data[test_indexes,1:total_data]
                train_data      <- data[-test_indexes,1:total_data]
                test_class      <- as.factor(data[test_indexes,total_data+1])
                train_class     <- as.factor(data[-test_indexes,total_data+1])

                # train
                fit_gbm <- train(x = train_data,
                                 y = train_class,
                                 method = "gbm",
                                 metric = "Accuracy",
                                 trControl = fitControl,
                                 tuneGrid = gbmGrid,
                                 verbose = FALSE)
                 # predictions
                 prediction <- predict(object=fit_gbm, test_data[,1:total_data])
                 if (article_number == "8" && length(prediction) == 25) {
                     prediction <- c(prediction, NA)
                 }
                 average_tables[,l,section,i] <- prediction

                 if (section == "topics") {
                     # voting
                     row <- apply(average_tables[,l,c(1,2,3,4,5,6,8),i], 1, table)
                     row_length <- length_of_row(article_number)
                     # for every row
                     for (h in 1:row_length) {
                         voting <- names(sort(row[[h]], decreasing=TRUE)[1])
                         if (article_number == "8" && !is.null(voting)) {
                             average_tables[h,l,"voting",i] <- voting
                         } else if (article_number != "8") {
                             if (is.null(voting)) {
                                 voting <- names(sort(row[,h], decreasing=TRUE)[1])
                             }
                             average_tables[h,l,"voting",i] <- voting
                         }
                     }

                     # outcome
                     if (article_number == "8" && length(test_class) == 25) {
                         test_class <- c(test_class, NA)
                     }
                     average_tables[,l,"outcome",i] <- test_class
                 }
             } # end for fold
         } # end for section
     } # end for shuffle

     # change 1s and 2s into N and Y
     average_tables[which(average_tables == "1")] <- "N"
     average_tables[which(average_tables == "2")] <- "Y"

     # -------------------------------------------------------------------------

     create_accuracy_tables(article_number, average_tables)
}

#accuracy_section <- GBM_Accuracy("3")
#accuracy_section <- GBM_Accuracy("6")
#accuracy_section <- GBM_Accuracy("8")
