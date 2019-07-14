**Voting dei voting**

Article 3

| shuffle1 | shuffle2 | shuffle3 | shuffle4 | shuffle5 | shuffle6 | shuffle7 | shuffle8 | shuffle9 | shuffle10 | average |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- | --------- | ------- |
| 0.724    | 0.720    | 0.720    | 0.740    | 0.768    | 0.752    | 0.740    | 0.764    | 0.724    | 0.740     | 0.7392  |


Article 6 

| shuffle1 | shuffle2 | shuffle3 | shuffle4 | shuffle5 | shuffle6 | shuffle7 | shuffle8 | shuffle9 | shuffle10 | average |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- | --------- | ------- |
| 0.8500   | 0.8625   | 0.8625   | 0.8125   | 0.8500   | 0.8250   | 0.8375   | 0.8625   | 0.8000   | 0.8250    | 0.83875 |


Article 8

Not precise: Missing instance 26

| shuffle1 | shuffle2 | shuffle3 | shuffle4 | shuffle5 | shuffle6 | shuffle7 | shuffle8 | shuffle9 | shuffle10 | average |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- | -------- | --------- | ------- |
| 0.784    | 0.804    | 0.764    | 0.792    | 0.792    | 0.776    | 0.772    | 0.796    | 0.772    | 0.796     | 0.7848  |


**Oracle voting**

| Feature Type  | Article 3 | Article 6 | Article 8 | 
| ------------- | --------- | --------- | --------- |
| Full          | GBM       | GBM       | GBM       |
| Procedure     | SVM       | SVM       | SVM       |
| Circumstances | GBM       | SVM       | KNN       |
| RelevantLaw   | SVM       | GBM       | SVM       |
| Facts         | SVM       | GBM       | GBM       |
| Law           | GBM       | SVM       | SVM       |
| Topics        | SVM       | KNN       | SVM       |
| Topics & Circ | GBM       | KNN       | SVM       |


| Feature Type  | Article 3 | Article 6 | Article 8 | Average   |
| ------------- | --------- | --------- | --------- | --------- |
| Full          | 0.7272    | 0.83125   | 0.7621846 | 0.7735449 |
| Procedure     | 0.6856    | 0.80625   | 0.6654000 | 0.7190833 |
| Circumstances | 0.7332    | 0.78625   | 0.7329077 | 0.7507859 |
| RelevantLaw   | 0.6960    | 0.81500   | 0.6891077 | 0.7308359 |
| Facts         | 0.7360    | 0.80500   | 0.7225231 | 0.7545077 |
| Law           | 0.5332    | 0.68125   | 0.6090462 | 0.6078321 |
| Topics        | 0.7396    | 0.84750   | 0.7011231 | 0.762741  |
| Topics & Circ | 0.7348    | 0.85750   | 0.7282923 | 0.7735308 |
| Voting        | 0.7556    | 0.86625   | 0.7479846 | 0.7899449 |