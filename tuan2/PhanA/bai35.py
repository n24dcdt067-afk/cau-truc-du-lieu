# Python (bai35.py)
import sys

def main():
    s = sys.stdin.read().strip()
    if not s: return
    n = int(s)
    if n < 2: return

    is_prime = [True] * (n + 1)
    is_prime[0] = is_prime[1] = False

    p = 2
    while p * p <= n:
        if is_prime[p]:
            for i in range(p * p, n + 1, p):
                is_prime[i] = False
        p += 1

    if n <= 30:
        primes = [str(i) for i in range(2, n + 1) if is_prime[i]]
        print(" ".join(primes))
    else:
        count = 0
        total_sum = 0
        for i in range(2, n + 1):
            if is_prime[i]:
                count += 1
                total_sum += i
        print(f"so luong = {count}, tong = {total_sum}")

if __name__ == "__main__":
    main()