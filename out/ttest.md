**Bayesian T-test**

With rope:

`correlatedBayesianTtest(as.vector(result_table[1:10,1:10,"section"] - result_table[1:10,1:10,"section"]),0.1, -0.01, 0.01)`

Without rope:

`correlatedBayesianTtest(as.vector(result_table[1:10,1:10,"section"] - result_table[1:10,1:10,"section"]),0.1, -0.00, 0.00)`


**GBM with rope:**

Voting vs. Topics and Circumstances

| Article   | left       | rope      | right     | 
| --------- | ---------- | --------- | --------- |
| Article 3 | 0.4158425  | 0.2740964 | 0.3100611 |
| Article 6 | 0.09372979 | 0.1282973 | 0.777973  |
| Article 8 | 0.05295208 | 0.1853013 | 0.7617467 |

Voting vs. Full

| Article   | left      | rope      | right     | 
| --------- | --------- | --------- | --------- |
| Article 3 | 0.3658581 | 0.346095  | 0.2880469 |
| Article 6 | 0.3709968 | 0.2580064 | 0.3709968 |
| Article 8 | 0.4616938 | 0.3885648 | 0.1497414 |

Voting vs. Procedure

| Article   | left         | rope         | right     | 
| --------- | ------------ | ------------ | --------- |
| Article 3 | 1.064465e-05 | 0.0001023511 | 0.999887  |
| Article 6 | 0.00663833   | 0.009186489  | 0.9841752 |
| Article 8 | 0.001250103  | 0.006311379  | 0.9924385 |

Voting vs. Circumstances

| Article   | left        | rope       | right     | 
| --------- | ----------- | ---------- | --------- |
| Article 3 | 0.3893295   | 0.2616882  | 0.3489823 |
| Article 6 | 0.004291023 | 0.01376819 | 0.9819408 |
| Article 8 | 0.09564572  | 0.2254591  | 0.6788951 |

Voting vs. Relevant Law

| Article   | left        | rope       | right     | 
| --------- | ----------- | ---------- | --------- |
| Article 3 | 0.06554214  | 0.1200087  | 0.8144491 |
| Article 6 | 0.2242868   | 0.1324913  | 0.6432219 |
| Article 8 | 0.003407119 | 0.01939902 | 0.9771939 |

Voting vs. Facts

| Article   | left       | rope      | right     | 
| --------- | ---------- | --------- | --------- |
| Article 3 | 0.2766307  | 0.3540657 | 0.3693036 |
| Article 6 | 0.1281735  | 0.1229923 | 0.7488341 |
| Article 8 | 0.02631654 | 0.1304858 | 0.8431977 |

Voting vs. Law

| Article   | left         | rope         | right     | 
| --------- | ------------ | ------------ | --------- |
| Article 3 | 1.213047e-07 | 1.056988e-06 | 0.9999988 |
| Article 6 | 0.003909042  | 0.004960099  | 0.9911309 |
| Article 8 | 1.699935e-05 | 0.0001161054 | 0.9998669 |

Voting vs. Topics

| Article   | left         | rope       | right     | 
| --------- | ------------ | ---------- | --------- |
| Article 3 | 0.004062321  | 0.02339239 | 0.9725453 |
| Article 6 | 0.005580745  | 0.0138477  | 0.9805716 |
| Article 8 | 0.0009579672 | 0.01515635 | 0.9838857 |


**GBM without rope:**

Voting vs. Topics and Circumstances

| Article   | left      | rope  | right     | 
| --------- | --------- | ----- | --------- |
| Article 3 | 0.5563427 | 0     | 0.4436573 |
| Article 6 | 0.1486239 | 0     | 0.8513761 |
| Article 8 | 0.1217628 | 0     | 0.8782372 |

Voting vs. Full

| Article   | left      | rope  | right     | 
| --------- | --------- | ----- | --------- |
| Article 3 | 0.5431193 | 0     | 0.4568807 |
| Article 6 | 0.5       | 0     | 0.5       |
| Article 8 | 0.6814794 | 0     | 0.3185206 |

Voting vs. Procedure

| Article   | left         | rope  | right     | 
| --------- | ------------ | ----- | --------- |
| Article 3 | 3.565836e-05 | 0     | 0.9999643 |
| Article 6 | 0.0103612    | 0     | 0.9896388 |
| Article 8 | 0.003184143  | 0     | 0.9968159 |

Voting vs. Circumstances

| Article   | left        | rope  | right     | 
| --------- | ----------- | ----- | --------- |
| Article 3 | 0.5213519   | 0     | 0.4786481 |
| Article 6 | 0.009058907 | 0     | 0.9909411 |
| Article 8 | 0.1875705   | 0     | 0.8124295 |

Voting vs. Relevant Law

| Article   | left        | rope  | right     | 
| --------- | ----------- | ----- | --------- |
| Article 3 | 0.1144899   | 0     | 0.8855101 |
| Article 6 | 0.2868526   | 0     | 0.7131474 |
| Article 8 | 0.009271196 | 0     | 0.9907288 |

Voting vs. Facts

| Article   | left       | rope  | right     | 
| --------- | ---------- | ----- | --------- |
| Article 3 | 0.4483613  | 0     | 0.5516387 |
| Article 6 | 0.183179   | 0     | 0.816821  |
| Article 8 | 0.07007591 | 0     | 0.9299241 |

Voting vs. Law

| Article   | left         | rope  | right     | 
| --------- | ------------ | ----- | --------- |
| Article 3 | 3.835437e-07 | 0     | 0.9999996 |
| Article 6 | 0.005937635  | 0     | 0.9940624 |
| Article 8 | 4.862779e-05 | 0     | 0.9999514 |

Voting vs. Topics

| Article   | left        | rope  | right     | 
| --------- | ----------- | ----- | --------- |
| Article 3 | 0.01114148  | 0     | 0.9888585 |
| Article 6 | 0.01065004  | 0     | 0.98935   |
| Article 8 | 0.004308861 | 0     | 0.9956911 |


**SVM with rope:**

Voting vs. Topics and Circumstances

| Article   | left       | rope       | right     | 
| --------- | ---------- | ---------- | --------- |
| Article 3 | 0.06460981 | 0.1562059  | 0.7791843 |
| Article 6 | 0.02128213 | 0.04011735 | 0.9386005 |
| Article 8 | 0.1205918  | 0.2400922  | 0.639316  |

Voting vs. Full

| Article   | left       | rope      | right     | 
| --------- | ---------- | --------- | --------- |
| Article 3 | 0.03217662 | 0.1750002 | 0.7928232 |
| Article 6 | 0.0937324  | 0.3018717 | 0.6043959 |
| Article 8 | 0.0812083  | 0.3085154 | 0.6102763 |

Voting vs. Procedure

| Article   | left       | rope       | right     | 
| --------- | ---------- | ---------- | --------- |
| Article 3 | 0.03456827 | 0.07953592 | 0.8858958 |
| Article 6 | 0.1931166  | 0.1441734  | 0.6627101 |
| Article 8 | 0.01322648 | 0.03152447 | 0.955249  |

Voting vs. Circumstances

| Article   | left        | rope       | right     | 
| --------- | ----------- | ---------- | --------- |
| Article 3 | 0.01332173  | 0.09139899 | 0.8952793 |
| Article 6 | 0.02248573  | 0.06927317 | 0.9082411 |
| Article 8 | 0.004589721 | 0.04779299 | 0.9476173 |

Voting vs. Relevant Law

| Article   | left        | rope       | right     | 
| --------- | ----------- | ---------- | --------- |
| Article 3 | 0.05759508  | 0.1190677  | 0.8233372 |
| Article 6 | 0.02007507  | 0.03067607 | 0.9492489 |
| Article 8 | 0.003783894 | 0.01998035 | 0.9762358 |

Voting vs. Facts

| Article   | left        | rope       | right     | 
| --------- | ----------- | ---------- | --------- |
| Article 3 | 0.3805515   | 0.28212    | 0.3373285 |
| Article 6 | 0.07768079  | 0.1315117  | 0.7908075 |
| Article 8 | 0.002473547 | 0.02124307 | 0.9762834 |

Voting vs. Law

| Article   | left         | rope         | right     | 
| --------- | ------------ | ------------ | --------- |
| Article 3 | 5.238375e-09 | 4.936295e-08 | 0.9999999 |
| Article 6 | 0.007586989  | 0.008637143  | 0.9837759 |
| Article 8 | 1.054925e-05 | 8.19596e-05  | 0.9999075 |

Voting vs. Topics

| Article   | left       | rope       | right    | 
| --------- | ---------- | ---------- | -------- |
| Article 3 | 0.4235937  | 0.3053843  | 0.271022 |
| Article 6 | 0.04842978 | 0.07207727 | 0.879493 |
| Article 8 | 0.2072596  | 0.2660484  | 0.526692 |


**SVM without rope:**

Voting vs. Topics and Circumstances

| Article   | left       | rope  | right     | 
| --------- | ---------- | ----- | --------- |
| Article 3 | 0.1262021  | 0     | 0.8737979 |
| Article 6 | 0.03702188 | 0     | 0.9629781 |
| Article 8 | 0.2220467  | 0     | 0.7779533 |

Voting vs. Full

| Article   | left       | rope  | right     | 
| --------- | ---------- | ----- | --------- |
| Article 3 | 0.090824   | 0     | 0.909176  |
| Article 6 | 0.2138597  | 0     | 0.7861403 |
| Article 8 | 0.2003125  | 0     | 0.7996875 |

Voting vs. Procedure

| Article   | left       | rope  | right     | 
| --------- | ---------- | ----- | --------- |
| Article 3 | 0.06522445 | 0     | 0.9347755 |
| Article 6 | 0.2599778  | 0     | 0.7400222 |
| Article 8 | 0.02501106 | 0     | 0.9749889 |

Voting vs. Circumstances

| Article   | left       | rope  | right     | 
| --------- | ---------- | ----- | --------- |
| Article 3 | 0.04102157 | 0     | 0.9589784 |
| Article 6 | 0.04756819 | 0     | 0.9524318 |
| Article 8 | 0.01710379 | 0     | 0.9828962 |

Voting vs. Relevant Law

| Article   | left        | rope  | right     | 
| --------- | ----------- | ----- | --------- |
| Article 3 | 0.105154    | 0     | 0.894846  |
| Article 6 | 0.03248173  | 0     | 0.9675183 |
| Article 8 | 0.009949151 | 0     | 0.9900508 |

Voting vs. Facts

| Article   | left        | rope  | right     | 
| --------- | ----------- | ----- | --------- |
| Article 3 | 0.5230954   | 0     | 0.4769046 |
| Article 6 | 0.1322476   | 0     | 0.8677524 |
| Article 8 | 0.008207584 | 0     | 0.9917924 |

Voting vs. Law

| Article   | left         | rope  | right     | 
| --------- | ------------ | ----- | --------- |
| Article 3 | 1.709378e-08 | 0     | 1         |
| Article 6 | 0.01118915   | 0     | 0.9888108 |
| Article 8 | 3.196952e-05 | 0     | 0.999968  |

Voting vs. Topics

| Article   | left       | rope  | right     | 
| --------- | ---------- | ----- | --------- |
| Article 3 | 0.5826837  | 0     | 0.4173163 |
| Article 6 | 0.07824076 | 0     | 0.9217592 |
| Article 8 | 0.3292688  | 0     | 0.6707312 |


**KNN with rope:**

Voting vs. Topics and Circumstances

| Article   | left       | rope       | right      | 
| --------- | ---------- | ---------- | ---------- |
| Article 3 | 0.09398731 | 0.1416638  | 0.7643489  |
| Article 6 | 0.8879869  | 0.07063438 | 0.04137874 |
| Article 8 | 0.03979489 | 0.1243461  | 0.08583044 |

Voting vs. Full

| Article   | left       | rope       | right      | 
| --------- | ---------- | ---------- | ---------- |
| Article 3 | 0.05424434 | 0.1409208  | 0.8048348  |
| Article 6 | 0.4906014  | 0.1474685  | 0.3619301  |
| Article 8 | 0.02874939 | 0.1420195  | 0.8292311  |

Voting vs. Procedure

| Article   | left         | rope         | right      | 
| --------- | ------------ | ------------ | ---------- |
| Article 3 | 0.004651594  | 0.01849459   | 0.9768538  |
| Article 6 | 0.04558248   | 0.05404188   | 0.9003756  |
| Article 8 | 2.001618e-05 | 0.0001087981 | 0.9998712  |

Voting vs. Circumstances

| Article   | left       | rope       | right      | 
| --------- | ---------- | ---------- | ---------- |
| Article 3 | 0.2070925  | 0.2300178  | 0.5628897  |
| Article 6 | 0.04926968 | 0.07064274 | 0.8800876  |
| Article 8 | 0.09210011 | 0.2674791  | 0.6404208  |

Voting vs. Relevant Law

| Article   | left        | rope        | right     | 
| --------- | ----------- | ----------- | --------- |
| Article 3 | 0.01850938  | 0.04379662  | 0.937694  |
| Article 6 | 0.001268229 | 0.002191228 | 0.9965405 |
| Article 8 | 0.000208818 | 0.002685603 | 0.9971056 |

Voting vs. Facts

| Article   | left        | rope        | right      | 
| --------- | ----------- | ----------- | ---------- |
| Article 3 | 0.004975551 | 0.02197708  | 0.9730474  |
| Article 6 | 0.001690978 | 0.003210577 | 0.9950984  |
| Article 8 | 0.002967846 | 0.02862372  | 0.9684084  |

Voting vs. Law

| Article   | left         | rope         | right     | 
| --------- | ------------ | ------------ | --------- |
| Article 3 | 9.820472e-09 | 8.820739e-08 | 0.9999999 |
| Article 6 | 0.00685997   | 0.008458468  | 0.9846816 |
| Article 8 | 2.002924e-05 | 0.0001004492 | 0.9998795 |

Voting vs. Topics

| Article   | left       | rope       | right     | 
| --------- | ---------- | ---------- | --------- |
| Article 3 | 0.1733267  | 0.2168245  | 0.6098488 |
| Article 6 | 0.8170624  | 0.1020388  | 0.0808988 |
| Article 8 | 0.02742521 | 0.1134236  | 0.8591512 |


**KNN without rope:**

Voting vs. Topics and Circumstances

| Article   | left       | rope | right     | 
| --------- | ---------- | ---- | --------- |
| Article 3 | 0.154062   | 0    | 0.845938  |
| Article 6 | 0.9300487  | 0    | 0.0699513 |
| Article 8 | 0.08583044 | 0    | 0.9141696 |

Voting vs. Full

| Article   | left       | rope | right     | 
| --------- | ---------- | ---- | --------- |
| Article 3 | 0.1087274  | 0    | 0.8912726 |
| Article 6 | 0.565495   | 0    | 0.434505  |
| Article 8 | 0.07668152 | 0    | 0.9233185 |

Voting vs. Procedure

| Article   | left         | rope | right     | 
| --------- | ------------ | ---- | --------- |
| Article 3 | 0.01077172   | 0    | 0.9892283 |
| Article 6 | 0.06851346   | 0    | 0.9314865 |
| Article 8 | 5.171018e-05 | 0    | 0.9999483 |

Voting vs. Circumstances

| Article   | left       | rope | right     | 
| --------- | ---------- | ---- | --------- |
| Article 3 | 0.3128361  | 0    | 0.6871639 |
| Article 6 | 0.07863536 | 0    | 0.9213646 |
| Article 8 | 0.1989818  | 0    | 0.8010182 |

Voting vs. Relevant Law

| Article   | left         | rope | right     | 
| --------- | ------------ | ---- | --------- |
| Article 3 | 0.03501876   | 0    | 0.9649812 |
| Article 6 | 0.002115613  | 0    | 0.9978844 |
| Article 8 | 0.0008230444 | 0    | 0.999177  |

Voting vs. Facts

| Article   | left         | rope | right     | 
| --------- | ------------ | ---- | --------- |
| Article 3 | 0.01208659   | 0    | 0.9879134 |
| Article 6 | 0.002913749  | 0    | 0.9970863 |
| Article 8 | 4.995629e-05 | 0    | 0.99995   |

Voting vs. Law

| Article   | left         | rope | right     | 
| --------- | ------------ | ---- | --------- |
| Article 3 | 3.137108e-08 | 0    | 1         |
| Article 6 | 0.01034655   | 0    | 0.9896534 |
| Article 8 | 0.8753754    | 0    | 0.1246246 |

Voting vs. Topics

| Article   | left       | rope | right     | 
| --------- | ---------- | ---- | --------- |
| Article 3 | 0.2707582  | 0    | 0.7292418 |
| Article 6 | 0.8753754  | 0    | 0.1246246 |
| Article 8 | 0.0667667  | 0    | 0.9332333 |



**Voting dei voting vs paper's Topcir**

| Article   | left       | rope      | right      | 
| --------- | ---------- | --------- | ---------- |
| Article 3 | 0.5412329  | 0.4487169 | 0.01005013 |
| Article 6 | 0.208632   | 0.6399961 | 0.151372   |
| Article 8 | 0.01247373 | 0.7993525 | 0.1881738  |

| Article   | left       | rope | right     | 
| --------- | ---------- | ---- | --------- |
| Article 3 | 0.9088869  | 0    | 0.0911131 |
| Article 6 | 0.5470006  | 0    | 0.4529994 |
| Article 8 | 0.206391   | 0    | 0.793609  |
