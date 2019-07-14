# ECHR-judicial-decisions
Predicting judicial decisions of the ECHR.

Paper can be found in the resources folder or here: https://peerj.com/articles/cs-93/

## TO DO:
 - all: Use relative path instead of absolute. https://stackoverflow.com/questions/36834767/how-to-use-rstudio-relative-paths
 - src/main/algorithm_tuning.R: Run & save results. Get the mean.
 - src/main/algorithm_tuning.R: Should be moved to utils and renamed as TuneAlgorithm.R
 - src/main: Add random forest.
 - src/t-test: Automate.
 - src/voting/voting_count.R: duplicate accuracy function, import from util.
 - src/voting/voting_oracle_*.R: Duplicated code can be imported instead.
 - src/workspaces: Run & save again.
 - out: Automate tables generation.
 

## The main idea:
Tune the algorithm with TuneAlgorithm.R - to slightly improve the results.
The tuned results are used for the cross validation of the specifc algorithm (SVM, GBM, KNN, RF).
The algorithm is trained with the appropriate tuning through CV_<alg>.R & TrainAlgorithm.R
This generates accuracy tables and workspace data, which is stored for the t-test.

Once all workspace data is collected, an Oracle voting is generated.
After, t-test results are generated - with and without rope.
