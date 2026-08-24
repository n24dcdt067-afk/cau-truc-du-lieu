import sys

def fib_lap(n):
    if n <= 2:
        return 1
    a, b = 1, 1
    for _ in range(3, n + 1):
        a, b = b, a + b
    return b

def main():
    line = sys.stdin.readline().strip()
    if not line:
        return
    n = int(line)
    if n > 92:
        print("tran long long")
    else:
        print(f"F = {fib_lap(n)}")

if __name__ == '__main__':
    main()