import sys

def main():
    data = sys.stdin.read().split()
    if not data: return
    n, a = int(data[0]), [int(x) for x in data[1:]]
    best = max_prod = min_prod = a[0]
    for x in a[1:]:
        if x < 0: max_prod, min_prod = min_prod, max_prod
        max_prod = max(x, max_prod * x)
        min_prod = min(x, min_prod * x)
        best = max(best, max_prod)
    print(best)

if __name__ == '__main__':
    main()