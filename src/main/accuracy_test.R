
# ------------------------------------------------------------------------------

source("~/ECHR-judicial-decisions/src/util/ArticleTables.R")
source("~/ECHR-judicial-decisions/src/util/AccuracyTables.R")
library(caret)
seeds <- c(1234, 1989, 290889, 251091, 240664, 190364, 120863, 101295, 31089, 3573113)
classifiers <- c('glm')
articles <- c("3", "6", "8")
sections   <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir", "voting", "newvoting")
labels_shuffle   <- c("shuffle1", "shuffle2", "shuffle3", "shuffle4", "shuffle5", "shuffle6", "shuffle7", "shuffle8", "shuffle9", "shuffle10")
labels_fold   <- c("fold1", "fold2", "fold3", "fold4", "fold5", "fold6", "fold7", "fold8", "fold9", "fold10")
dimensions <- c(length(classifiers), length(articles), length(sections), 10, 10)
res_tables <- array(dim = dimensions, dimnames = list(classifiers, articles, sections, labels_shuffle,labels_fold))

sections_outcome   <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir", "voting", "newvoting", "outcome")
dimensions <- c(length(classifiers), length(articles), length(sections_outcome), 10, 10,26)
class_table  <- array(dim = dimensions, dimnames = list(classifiers, articles, sections_outcome, labels_shuffle,labels_fold, NULL))

# ------------------------------------------------------------------------------

sections <- c("full", "procedure", "circumstances", "relevantLaw", "law", "topics", "facts", "topcir")
for (classifier in classifiers) {
  print(paste("Start classifier ", classifier))
  for (article in articles) {
    print(paste("Start article ", article))
    
    path <- paste("~/ECHR-judicial-decisions/echr_dataset/Article", article, "/", sep="")
    average_tables <- create_average_tables(article)
    
    Y <- read.csv(paste(path, "cases_a", article, ".csv", sep=""), header = FALSE) 
    Y <- Y[,2]
    levels(Y) <- c("N", "Y")
    # for every shuffle
    for (i in 1:10) {
      print(paste("Shuffle ", i, " of 10"))
      
      max_fold <- fold(article)
      # shuffle
      set.seed(seeds[i])
      shuffle <- runif(max_fold)
      # for every section
      for (section in sections) {
        print(section)
        switch(section,
               topcir={
                 exp_data_topic    <- read.csv(paste(path, name_of_file(article, "topics"), sep=""), header = FALSE, sep = "\t") 
                 exp_data_cir      <- read.csv(paste(path, name_of_file(article, "circumstances"), sep=""),  header = FALSE)
                 exp_data <- cbind(exp_data_topic, exp_data_cir)
               },
               facts={
                 exp_data_revLaw   <- read.csv(paste(path, name_of_file(article, "relevantLaw"), sep=""), header = FALSE) 
                 exp_data_cir      <- read.csv(paste(path, name_of_file(article, "circumstances"), sep=""),  header = FALSE)
                 exp_data <- (exp_data_revLaw + exp_data_cir)/2
               },
               topics={
                 exp_data    <- read.csv(paste(path, name_of_file(article, "topics"), sep=""), header = FALSE, sep = "\t") 
               },
               {
                 exp_data    <- read.csv(paste(path, name_of_file(article, section), sep=""), header = FALSE) 
                 
               })
        colnames(exp_data) <- make.names(colnames(exp_data), unique = TRUE)
        
        total_data <- ncol(exp_data)
        
        
        # shuffle data
        data        <- exp_data[order(shuffle),]
        outcome     <- Y[order(shuffle)]
        
        fitControl  <- trainControl(method="none") 
        
        # 10 x 25/8/26 folds
        folds       <- cut(seq(1, max_fold), breaks=10, labels=FALSE)
        
        # for every fold
        for (l in 1:10) {
          
          test_indexes    <- which(folds==l,arr.ind=TRUE)
          
          test_data       <- data[test_indexes,]
          train_data      <- data[-test_indexes,]
          test_class      <- as.factor(outcome[test_indexes])
          train_class     <- as.factor(outcome[-test_indexes])
          
          # train
          switch(classifier,
                 SVM={
                   svmGrid     <- expand.grid(C = 100)#VISE we want fix parameters here
                   fit_model <- train(x = train_data,
                                      y = train_class,
                                      method="svmLinear",
                                      metric="Accuracy",
                                      trControl=fitControl,
                                      scale = FALSE,
                                      tuneGrid = svmGrid)
                 },
                 GBM={
                   gbmGrid     <- expand.grid(interaction.depth = 9,
                                              n.trees = 1150,
                                              shrinkage = 0.1,
                                              n.minobsinnode = 10)         
                   fit_model <- train(x = train_data,
                                      y = train_class,
                                      method = "gbm",
                                      metric = "Accuracy",
                                      trControl = fitControl,
                                      tuneGrid = gbmGrid,
                                      verbose = FALSE)
                 },
                 KNN={
                   knnGrid     <- expand.grid(k = 9)
                   fit_model <- train(x = train_data,
                                      y = train_class,
                                      method="knn",
                                      metric="Accuracy",
                                      trControl=fitControl,
                                      #scale = FALSE,
                                      tuneGrid = knnGrid)
                 },
                 glm={
                   fit_model <- train(x = train_data,
                                      y = train_class,
                                      method="glm",
                                      metric="Accuracy",
                                      trControl=fitControl)
                 },
                 {
                   print("error unknown classifier")
                   
                 })
          
          
          # predictions
          prediction <- predict(object=fit_model, test_data)
          if (article == "8" && length(prediction) == 25) {
            prediction <- c(prediction, NA)
          }
          average_tables[section,i,l,] <- prediction
          
          if (section == "topcir") {
            # voting
            tab <- average_tables[1:7,i,l,]
            # for every row
            for (h in 1:ncol(tab)) {
              voting <- names(which.max(table(tab[,h])))
              if (!is.null(voting)) {
                average_tables["voting",i,l,h] <- voting
              } 
            }
            
            # newvoting
            tab <- average_tables[c(1,2,3,4,6),i,l,]
            # for every row
            for (h in 1:ncol(tab)) {
              voting <- names(which.max(table(tab[,h])))
              if (!is.null(voting)) {
                average_tables["newvoting",i,l,h] <- voting
              } 
            }
            
            # outcome
            if (article == "8" && length(test_class) == 25) {
              test_class <- c(test_class, NA)
            }
            average_tables["outcome",i,l,] <- test_class
          }
        } # end for fold
      } # end for section
    } # end for shuffle
    
    # change 1s and 2s into N and Y
    average_tables[which(average_tables == "1")] <- "N"
    average_tables[which(average_tables == "2")] <- "Y"
    class_table[classifier,article,,,,1:(dim(average_tables)[4])] <- average_tables
    # -------------------------------------------------------------------------
    
    res_tables[classifier,article,,,] <- create_accuracy_tables(article, average_tables)
  } # end for classifier
} # end for article

#save(res_tables,class_table, file = "./results_svm.rData")
