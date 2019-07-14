# In an ideal world:
# Get output from algorithm_tuning.R -> Should be moved to utils and renamed as TuneAlgorithm.R
# Output should go into grid:
# trainGrid     <- expand.grid(outputFromTheAlgorithmTuning)

algorithmsEnum <- function() {
  list(SVM = "SVM", GBM = "GBM", KNN = "KNN", RF = "RANDOMFOREST")
}

gridToUse <- function(algorithm_name) {
  algs <- algorithmsEnum()
  if (algorithm_name == algs$SVM) expand.grid(C = tune_outcome)
  else if (algorithm_name == algs$GBM) expand.grid(interaction.depth = tune_outcome,
                                                   n.trees = tune_outcome,
                                                   shrinkage = tune_outcome)
  else if (algorithm_name == algs$KNN) fitKnn(k = tune_outcome)
  else if (algorithm_name == algs$RF) fitForest(.mtry = tune_outcome)
}

methodToUse <- function(algorithm_name) {
  algs <- algorithmsEnum()
  if (algorithm_name == algs$SVM) "svmLinear"
  else if (algorithm_name == algs$GBM) "gbm"
  else if (algorithm_name == algs$KNN) "knn"
  else if (algorithm_name == algs$RF) "rf"
}

#trainAlg <- train(x = train_data,
#                  y = train_class,
#                  method=methodToUse(algorithm_name),
#                  metric="Accuracy",
#                  trControl=fitControl,
#                  tuneGrid = gridToUse(algorithm_name))
