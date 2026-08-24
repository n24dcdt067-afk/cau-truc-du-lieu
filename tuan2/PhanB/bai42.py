import sys

def main():
    data = sys.stdin.read().split()
    if not data: return
    n, k = int(data[0]), int(data[1])
    if k > n or k <= 0: return
    a = [int(x) for x in data[2:n+2]]
    s = sum(a[:k])
    max_sum = s
    best_start = 0
    for i in range(k, n):
        s += a[i] - a[i - k]
        if s > max_sum:
            max_sum = s
            best_start = i - k + 1
    print(f"tong {max_sum}, bat dau tai vi tri {best_start + 1}")

if __name__ == '__main__':
    main()