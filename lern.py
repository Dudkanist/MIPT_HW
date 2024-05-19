from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import roc_curve
from sklearn.metrics import precision_recall_curve
import numpy as np
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('TkAgg')
iris_dataset = load_iris()
metric=['minkowski', 'manhattan', 'euclidean', 'chebyshev']
iris_dataset=({"data": iris_dataset["data"][49:],"target": iris_dataset["target"][49:]})
for i in range(2,40,2):
    knn = KNeighborsClassifier(n_neighbors=5)
    X_train, X_test, y_train, y_test = train_test_split(
     iris_dataset['data'], iris_dataset['target'], random_state=i)
    knn.fit(X_train, y_train)
    prob=knn.predict_proba(X_test)
    prob1=[]
    for j in range(len(prob)):
        prob1.append(prob[j][1])
    prob1=np.array(prob1)
    fpr, tpr, thresholds = roc_curve(y_test, prob1,pos_label=2)
    plt.plot(fpr, tpr, label="ROC Curve")
    plt.xlabel("FPR")
    plt.ylabel("TPR (recall)")
    close_zero = np.argmin(np.abs(thresholds))
    plt.plot(fpr[close_zero], tpr[close_zero], 'o', markersize=10,
         label="threshold zero", fillstyle="none", c='k', mew=2)
    plt.legend(loc=4)
    plt.show()
    precision, recall, thresholds = precision_recall_curve(y_test, prob1,pos_label=2)
    close_zero = np.argmin(np.abs(thresholds))
    y_pred = knn.predict(X_test)
    plt.plot(precision[close_zero], recall[close_zero], 'o', markersize=10,
         label="threshold zero", fillstyle="none", c='k', mew=2)
    plt.plot(precision, recall, label="precision recall curve")
    plt.xlabel("Precision")
    plt.ylabel("Recall")
    plt.legend(loc="best")
    plt.show()
    print("Test set predictions:\n", y_pred)
    print("Test set score: {:.2f}".format(np.mean(y_pred == y_test)))
    print("Test set score: {:.2f}".format(knn.score(X_test, y_test)))
