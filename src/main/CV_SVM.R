# ECHR (SVM)

# run SVM_Accuracy()

# ------------------------------------------------------------------------------

source("~/ECHR-judicial-decisions/src/util/ArticleTables.R")
source("~/ECHR-judicial-decisions/src/util/AccuracyTables.R")
library(caret)
seeds <-
  c(1234,
    1989,
    290889,
    251091,
    240664,
    190364,
    120863,
    101295,
    31089,
    3573113)

# ------------------------------------------------------------------------------

SVM_Accuracy <- function(article_number) {
  sections <-
    c(
      "full",
      "procedure",
      "circumstances",
      "relevantLaw",
      "law",
      "topics",
      "facts",
      "topcir"
    )
  path <-
    paste("~/ECHR-judicial-decisions/echr_dataset/Article",
          article_number,
          "/",
          sep = "")
  average_tables <- create_average_tables(article_number)
  
  Y <-
    read.csv(paste(path, "cases_a", article_number, ".csv", sep = ""),
             header = FALSE)
  Y <- Y[, 2]
  levels(Y) <- c("N", "Y")
  # for every shuffle
  for (i in 1:10) {
    max_fold <- fold(article_number)
    # shuffle
    set.seed(seeds[i])
    shuffle <- runif(max_fold)
    # for every section
    for (section in sections) {
      switch(section,
             topcir = {
               exp_data_topic    <-
                 read.csv(paste(path, name_of_file(article_number, "topics"), sep = ""),
                          header = FALSE,
                          sep = "\t")
               exp_data_cir      <-
                 read.csv(paste(
                   path,
                   name_of_file(article_number, "circumstances"),
                   sep = ""
                 ),  header = FALSE)
               exp_data <- cbind(exp_data_topic, exp_data_cir)
             },
             facts = {
               exp_data_revLaw   <-
                 read.csv(paste(
                   path,
                   name_of_file(article_number, "relevantLaw"),
                   sep = ""
                 ), header = FALSE)
               exp_data_cir      <-
                 read.csv(paste(
                   path,
                   name_of_file(article_number, "circumstances"),
                   sep = ""
                 ),  header = FALSE)
               exp_data <- (exp_data_revLaw + exp_data_cir) / 2
             },
             topics = {
               exp_data    <-
                 read.csv(paste(path, name_of_file(article_number, "topics"), sep = ""),
                          header = FALSE,
                          sep = "\t")
             },
             {
               exp_data    <-
                 read.csv(paste(path, name_of_file(article_number, section), sep = ""), header = FALSE)
               
             })
      total_data <- ncol(exp_data)
      
      
      # shuffle data
      data        <- exp_data[order(shuffle), ]
      outcome     <- Y[order(shuffle)]
      
      fitControl  <- trainControl(method = "none")
      # parameter tuning
      svmGrid     <-
        expand.grid(C = 100)#VISE we want fix parameters here
      
      # 10 x 25/8/26 folds
      folds       <-
        cut(seq(1, max_fold), breaks = 10, labels = FALSE)
      
      # for every fold
      for (l in 1:10) {
        test_indexes    <- which(folds == l, arr.ind = TRUE)
        
        test_data       <- data[test_indexes, ]
        train_data      <- data[-test_indexes, ]
        test_class      <- as.factor(outcome[test_indexes])
        train_class     <- as.factor(outcome[-test_indexes])
        
        # train
        print(section)
        knnGrid     <- expand.grid(k = 9)
        fit_model <- train(x = train_data,
                           y = train_class,
                           method="knn",
                           metric="Accuracy",
                           trControl=fitControl,
                           #scale = FALSE,
                           tuneGrid = knnGrid)
        # predictions
        prediction <-
          predict(object = fit_model, test_data)
        if (article_number == "8" && length(prediction) == 25) {
          prediction <- c(prediction, NA)
        }
        average_tables[, l, section, i] <- prediction
        
        if (section == "topcir") {
          # voting
          tab <- average_tables[, l, 1:7, i]
          # for every row
          for (h in 1:nrow(tab)) {
            voting <- names(which.max(table(tab[h, ])))
            if (!is.null(voting)) {
              average_tables[h, l, "voting", i] <- voting
            }
          }
          
          # newvoting
          tab <- average_tables[, l, 1:5, i]
          # for every row
          for (h in 1:nrow(tab)) {
            voting <- names(which.max(table(tab[h, ])))
            if (!is.null(voting)) {
              average_tables[h, l, "newvoting", i] <- voting
            }
          }
          
          # outcome
          if (article_number == "8" &&
              length(test_class) == 25) {
            test_class <- c(test_class, NA)
          }
          average_tables[, l, "outcome", i] <- test_class
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

accuracy_section_3 <- SVM_Accuracy("3")
accuracy_section_6 <- SVM_Accuracy("6")
accuracy_section_8 <- SVM_Accuracy("8")



accuracy_section <- accuracy_section_3
btt <-
  bayesianCorrelatedT.test(as.vector(t(accuracy_section[, 1:10, "full"])), as.vector(t(accuracy_section[, 1:10, "circumstances"])), rho = 0.1)
plotPosterior(btt, c("Full", "Circumstances"), "Article 3")
btt$probabilities

apply(accuracy_section[, "average", ], 2, max) - apply(accuracy_section[, "average", ], 2, min) 