#!/usr/bin/env

def gen_val(p, m):
    for x_1 in range(m+1):
        print("[x_1 = {}]".format(x_1), end="")
        for x_2 in range(1, p+1):
            result = x_1*p*(p - 2*x_2) + m*x_2*x_2
            print(" {}".format(result), end=""),
        print()

def main():
    p = 5
    m = 6
    gen_val(p,m)

if __name__ == "__main__":
    main()
