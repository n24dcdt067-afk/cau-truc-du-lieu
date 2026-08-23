# Python (bai36.py)
import sys

# Giới hạn lớn nhất của số nguyên 64-bit có dấu (tương đương LLONG_MAX trong C++)
LLONG_MAX = 9223372036854775807

def main():
    s = sys.stdin.read().strip()
    if not s: return
    n = int(s)
    if n < 0: return

    f = 1
    overflow = False

    for i in range(2, n + 1):
        if f > LLONG_MAX // i:
            overflow = True
            break
        f *= i

    if overflow:
        print("TRAN SO")
    else:
        print(f)

if __name__ == "__main__":
    main()