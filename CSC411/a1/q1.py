from sklearn import datasets
import matplotlib.pyplot as plt
import numpy as np
import math as m

def load_data():
    boston = datasets.load_boston()
    X = boston.data
    y = boston.target
    features = boston.feature_names
    return X,y,features


def visualize(X, y, features):
    plt.figure(figsize=(20, 5))
    feature_count = X.shape[1]

    # i: index
    for i in range(feature_count):
        plt.subplot(3, 5, i + 1)
        # ===> Plot feature i against y
        plt.scatter(X[:, i], y, s=0.1, c='r')
        plt.xlabel(features[i])
        plt.ylabel('y value')
    plt.tight_layout()
    # plt.show()

def add_bias(X):
    n_row, n_col = X.shape
    bias = np.ones(n_row)
    X = np.column_stack((bias, X))
    return X

def fit_regression(X,y):
    # ===> Implement linear regression
    # Remember to use np.linalg.solve instead of inverting!
    # ---> Compute weights
    X = add_bias(X)
    XT = np.transpose(X)
    w = np.linalg.solve(XT.dot(X), XT.dot(y))
    return w

def main():
    # Load the data
    X, y, features = load_data()
    n_row, n_col = X.shape
    print("===> Features: {}".format(features))
    print("===> Number of Data Points: {}".format(n_row))
    print("===> Number of Features: {}".format(n_col))

    # Visualize the features
    visualize(X, y, features)

    # ---> Normalize data
    X = X / np.amax(X, axis = 0)

    # ===> Split data into train and test
    Xy = np.column_stack((X, y))
    np.random.shuffle(Xy)
    twentyPercent = m.ceil(n_row*0.2)
    X_test = Xy[0:twentyPercent, 0:-1]
    y_test = Xy[0:twentyPercent, -1]
    X_train = Xy[twentyPercent: , 0:-1]
    y_train = Xy[twentyPercent: , -1]

    # Fit regression model
    w = fit_regression(X_train, y_train)
    print("===> Listed of Features and Associated Weights")
    print("---  Bias: {}".format(w[0]))
    for i in range(n_col):
        print("---  {}: {}".format(features[i], w[i+1]))

    # Compute fitted values, MSE, etc.
    # ---> Add bias to test data
    X_test = add_bias(X_test)

    # ---> Compute fitted values
    y_pred = X_test.dot(w)

    # ===> Calculating Error
    test_size = y_test.size
    y_diff = y_test - y_pred

    # ---> Error Metric: Mean Squared Error
    MSE = sum(np.square(y_diff))/test_size
    print("===> MSE: {}".format(MSE))

    # ---> Error Metric 1: Explained Variance
    diff_var = sum(np.square(y_diff - y_diff.mean()))/(test_size-1)
    y_var = sum(np.square(y_test - y_test.mean()))/(test_size - 1)
    EV = 1 - diff_var / y_var
    print("===> EV: {}".format(EV))

    # ---> Error Metric 2: Median Absolute Error
    MAE = np.median(abs(y_diff))
    print("===> MAE: {}".format(MAE))


if __name__ == "__main__":
    main()

