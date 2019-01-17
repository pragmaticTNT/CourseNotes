import math
import numpy as np
import matplotlib.pyplot as plt

def plotExample():
    M = np.identity(3)
    nMaxDigit = 8

    digitRange = range(1, nMaxDigit+1)
    maxEntries = []
    for i in digitRange:
        a = round(1/math.sqrt(2), i)
        print("Current value of a: ", a)
        M[0,1] = a
        M[1,0] = a
        M[1,2] = a
        M[2,1] = a
        print("===> M <===\n", M)
        invM = np.linalg.inv(M)
        print("===> inv(M) <===\n", invM)
        modInvM = np.log(np.absolute(invM))
        maxEntries.append(modInvM.max())
    plt.plot(digitRange, maxEntries, 'ro')
    plt.xlabel('# Digits of Precision of a')
    plt.ylabel('Log of Largest Value in A^{-1}')
    plt.title('Exponential Growth of Cond')
    plt.show()


def main():
    plotExample()

if __name__ == "__main__":
    main()
