import numpy as np
import matplotlib.pyplot as plt
maxSize = 20

def geometricGen(a, r, n):
    if n < maxSize:
        return [a*np.power(r,i) for i in range(n)]
    else:
        print("[GEO] That matrix is too big!")
        return []

def arithmeticGen(a, k, n):
    if n < maxSize:
        return [a+i*k for i in range(n)]
    else:
        print("[ARI] That matrix is too big!")
        return []

def getBit(n, i):
    return (n >> i) & 1

def fill(A):
    n = len(A)
    outputMatrix = []
    po2 = np.power(2, [i for i in range(n)])
    for mask in range(np.power(2,n+1)):
        subset = [A[i]*getBit(mask,i) for i in range(n)]
        subsetSum = sum(subset)
        outputMatrix.append(subsetSum)
    return list(set(outputMatrix))

def lindiscB(A):
    maxDiff = 0
    for i in range(len(A)-1):
        # print("i:", i)
        # print("A[i] =", A[i])
        # print("A[i+1] =", A[i+1])
        if abs(A[i]-A[i+1]) > maxDiff:
            maxDiff = abs(A[i]-A[i+1])
    return maxDiff

def lindisc(A):
    B = [abs(i) for i in A]
    B = sorted(B)
    l_B = 0
    for i in range(len(B)-1, -1, -1):
        l_B = max(B[i], l_B - B[i])
    return l_B

def visualize(x):
    y = [0 for i in range(len(x))]
    plt.scatter(x, y, c='r', marker='x')
    plt.yticks([])
    #plt.axis('off')
    plt.show()
    return

def test(nTrials):
    MAXMAG = 1000
    fail = False
    for i in range(nTrials):
        #print("Trial", i+1)
        inputMatrix = sorted(np.random.randint(2*MAXMAG, size=10))
        inputMatrix = [i - MAXMAG for i in inputMatrix]
        outputMatrix = fill(inputMatrix)
        outputMatrix = sorted(outputMatrix)
        actLindisc = lindiscB(outputMatrix)
        algLindisc = lindisc(inputMatrix)
        if actLindisc != algLindisc:
            print("[ERR] Input:", inputMatrix)
            print("ACTUAL:", actLindisc)
            print("ALGOL:", algLindisc)
            visualize(outputMatrix)
            fail = True
            break

    if not fail:
        print("[OK]")
    return


if __name__ == "__main__":
    inputMatrix = [-32, -8, -2, 1, 4, 16]
    inputMatrix = [i + 9 for i in inputMatrix]
    inputMatrix += [abs(i) for i in inputMatrix if i < 0]
    #inputMatrix = geometricGen(1, 3, 4)
    #inputMatrix = arithmeticGen(4, 2, 10)
    outputMatrix = fill(inputMatrix)
    outputMatrix = sorted(outputMatrix)
    print("Input:", inputMatrix)
    print("Output:", outputMatrix)
    print("ACTUAL: 2*lindisc(output) =", lindiscB(outputMatrix))
    print("ALGOL: 2*lindisc(input) =", lindisc(inputMatrix))
    visualize(outputMatrix)
    #test(100)
