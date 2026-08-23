import sys

def main():
    s = sys.stdin.read().strip()
    if not s: return
    n = int(s)
    if n < 0:
        print("NO"); return

    left, right, found = 0, min(n, 10**9), False
    while left <= right:
        mid = (left + right) // 2
        sq = mid * mid
        if sq == n:
            found = True; break
        elif sq < n: left = mid + 1
        else: right = mid - 1

    print("YES" if found else "NO")

if __name__ == "__main__":
    main()