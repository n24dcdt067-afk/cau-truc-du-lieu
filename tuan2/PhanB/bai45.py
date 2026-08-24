import sys

def power_mod(a: int, b: int, m: int) -> int:
    if m == 1:
        return 0
    res = 1 % m
    a %= m
    while b > 0:
        if b % 2 == 1:
            res = (res * a) % m
        a = (a * a) % m
        b //= 2
    return res

def main():
    data = sys.stdin.read().split()
    if not data:
        return
    a, b, m = map(int, data[:3])
    print(power_mod(a, b, m))

if __name__ == '__main__':
    main()