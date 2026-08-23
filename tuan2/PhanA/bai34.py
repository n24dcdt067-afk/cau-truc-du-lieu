import sys

def main():
    s = sys.stdin.read().strip()
    if not s: return
    n = int(s)

    is_neg = (n < 0)
    n = abs(n)

    rev = 0
    while n > 0:
        rev = rev * 10 + (n % 10)
        n //= 10

    if is_neg:
        rev = -rev

    print(rev)

if __name__ == "__main__":
    main()