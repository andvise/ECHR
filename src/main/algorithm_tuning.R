# ECHR

# ------------------------------------------------------------------------------

library(caret)
library(randomForest)

# ------------------------------------------------------------------------------

# echr = all the dataset
# train_set = the train set (200)
# test_set = the test set (50)

# ------------------------------------------------------------------------------

# Grid Search
fitControl <- trainControl(## 10-fold CV
    method = "repeatedcv",
    number = 10,
    ## repeated ten times
    repeats = 10)

# ------------------------------------------------------------------------------

# Algorithms
fitSvm <- function(train_set) {
    svmGrid <-  expand.grid(C = c(25, 50, 100, 150))
    trainSvm <- train(OUTCOME~., train_set,
                      method = "svmLinear",
                      trControl = fitControl,
                      tuneGrid = svmGrid,
                      metric = "Accuracy")
    return(trainSvm)
}

fitGbm <- function(train_set) {
    gbmGrid <-  expand.grid(interaction.depth = c(1, 3, 5), 
                            n.trees = c(10, 20, 40), 
                            shrinkage = 0.1)
    trainGbm <- train(OUTCOME~., train_set,
                      method = "gbm",
                      trControl = fitControl,
                      tuneGrid = gbmGrid,
                      metric = "Accuracy")
    return(trainGbm)
}

fitKnn <- function(train_set) {
    knnGrid <-  expand.grid(k = c(9, 11, 13, 15))
    trainKnn <- train(OUTCOME~., train_set,
                      method = "knn",
                      trControl = fitControl,
                      tuneGrid = knnGrid,
                      metric = "Accuracy")
    return(trainKnn)
}

fitForest <- function(train_set) {
    rForestGrid <- expand.grid(.mtry = c(1, 3, 5, 7, 9, 11, 13))
    trainRForest <- train(OUTCOME~., train_set,
                          method = "rf",
                          trControl = fitControl,
                          tuneGrid = rForestGrid,
                          metric = "Accuracy")
    return(trainRForest)
}

# ------------------------------------------------------------------------------

algorithmsEnum <- function() {
    list(SVM = "SVM", GBM = "GBM", KNN = "KNN", RF = "RANDOMFOREST")
}

trainAlgorithm <- function(algorithm_name, train_set) {
    algs <- algorithmsEnum()
    if (algorithm_name == algs$SVM) fitSvm(train_set)
    else if (algorithm_name == algs$GBM) fitGbm(train_set)
    else if (algorithm_name == algs$KNN) fitKnn(train_set)
    else if (algorithm_name == algs$RF) fitForest(train_set)
}

# ------------------------------------------------------------------------------

tuneAlgorithm <- function(article_number, algorithm_name) {
    # Get the data
    ngrams_path <- paste("~/ECHR-judicial-decisions/data/Article", article_number, "/formatted_ngrams_a", article_number, "_full.csv", sep = "")
    echr <- read.csv(ngrams_path)
    
    set.seed(42) # set the seed to make the experiment reproducible
    # createDataPartition does a stratified random split of the data
    trainIndex <- createDataPartition(echr$OUTCOME, p = .8,
                                      list = FALSE,
                                      times = 1)
    # Test set and training set
    train_set <- echr[ trainIndex,]
    test_set  <- echr[-trainIndex,]
    
    # Train
    t <- trainAlgorithm(algorithm_name, train_set)
    print(t)
    return(t)
}

# ------------------------------------------------------------------------------

# Run for every algorithm and take the mean for each article (3,6,8)

algs <- c("SVM", "GBM", "KNN", "RANDOMFOREST")
articles <- c("3", "6", "8")
result_mean <- c()

for(alg in algs) {
  tuned <- c()
  for(article in articles) {
    t <- tuneAlgorithm(article, alg)
    # Store the result
    tuned <- c(tuned, t)  # Could throw error w/ GBM. Run it anyway and check its output.
  }
  # Get the mean of each article
  result_mean <- c(result_mean, mean(tuned))
}

optimal_tuning <- setNames(result_mean, algs)
print(optimal_tuning)
