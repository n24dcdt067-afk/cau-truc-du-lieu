import sys

def main():
    data = sys.stdin.read().split()
    if not data: return
    n, a = int(data[0]), [int(x) for x in data[1:]]
    best = cur = a[0]
    start_idx = end_idx = temp_start = 0
    for i in range(1, n):
        if cur < 0: cur, temp_start = a[i], i
        else: cur += a[i]
        if cur > best: best, start_idx, end_idx = cur, temp_start, i
    print(f"tong {best}, doan [{start_idx + 1}..{end_idx + 1}]")

if __name__ == '__main__':
    main()