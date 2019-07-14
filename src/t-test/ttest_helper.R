source("~/projects/ECHR-judicial-decisions/src/t-test/bayesian_correlated_ttest.R")

alg <- c("GBM")
articles <- c("3", "6", "8")
sec <- c("topcir", "full", "procedure", "circumstances", "relevantLaw", "facts", "law", "topics")

for (a in alg) {
    print(a)
    for (article_number in articles) {
        print(article_number)
        workspace_path <- paste("~/projects/ECHR-judicial-decisions/src/workspaces/", a, "_", article_number, "_workspace.RData", sep = "")
        load(workspace_path)
        for (s in sec) {
            # Ttest
            ttest_rope <- correlatedBayesianTtest(as.vector(result_table[1:10,1:10,"voting"] - result_table[1:10,1:10,s]),0.1, -0.01, 0.01)
            ttest_no_rope <- correlatedBayesianTtest(as.vector(result_table[1:10,1:10,"voting"] - result_table[1:10,1:10,s]),0.1, -0.00, 0.00)
            print(s)
            print(ttest_rope)
            print("-----------")
            print(ttest_no_rope)
        }
    }
}

