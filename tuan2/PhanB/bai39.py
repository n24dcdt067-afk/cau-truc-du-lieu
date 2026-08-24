import sys

def cach2(a):
    n = len(a)
    best = a[0]
    for i in range(n):
        s = 0
        for j in range(i, n):
            s += a[j]
            if s > best:
                best = s
    return best

def main():
    input_data = sys.stdin.read().split()
    if not input_data:
        return
    n = int(input_data[0])
    a = [int(x) for x in input_data[1:n+1]]
    print(cach2(a))

if __name__ == '__main__':
    main()