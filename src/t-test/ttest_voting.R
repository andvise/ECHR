source("~/projects/ECHR-judicial-decisions/src/t-test/bayesian_correlated_ttest.R")

# voting for each shuffle (10 shuffles)
article_3_voting = c(0.724, 0.720, 0.720, 0.740, 0.768, 0.752, 0.740, 0.764, 0.724, 0.740, 0.7392)
article_6_voting = c(0.8500, 0.8625, 0.8625, 0.8125, 0.8500, 0.8250, 0.8375, 0.8625, 0.8000, 0.8250)
# article 8 is missing last instance (26)
article_8_voting = c(0.784, 0.804, 0.764, 0.792, 0.792, 0.776, 0.772, 0.796, 0.772, 0.796, 0.7848)

paper_results_3_topcir = 0.75
paper_results_6_topcir = 0.84
paper_results_8_topcir = 0.78

# ------------------------------------------------------------------------------

ttest_rope <- correlatedBayesianTtest(as.vector(article_3_voting - paper_results_3_topcir), 0.1, -0.01, 0.01)
ttest_no_rope <- correlatedBayesianTtest(as.vector(article_3_voting - paper_results_3_topcir), 0.1, -0.00, 0.00)

print("Article 3")
print(ttest_rope)
print(ttest_no_rope)

ttest_rope <- correlatedBayesianTtest(as.vector(article_6_voting - paper_results_6_topcir), 0.1, -0.01, 0.01)
ttest_no_rope <- correlatedBayesianTtest(as.vector(article_6_voting - paper_results_6_topcir), 0.1, -0.00, 0.00)

print("Article 6")
print(ttest_rope)
print(ttest_no_rope)

ttest_rope <- correlatedBayesianTtest(as.vector(article_8_voting - paper_results_8_topcir), 0.1, -0.01, 0.01)
ttest_no_rope <- correlatedBayesianTtest(as.vector(article_8_voting - paper_results_8_topcir), 0.1, -0.00, 0.00)

print("Article 8")
print(ttest_rope)
print(ttest_no_rope)