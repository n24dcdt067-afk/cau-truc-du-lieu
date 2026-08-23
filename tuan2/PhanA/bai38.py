# Python (bai38.py)
import sys

def main():
    input_data = sys.stdin.read().split()
    if not input_data: return

    n = int(input_data[0])
    a = [int(x) for x in input_data[1:n + 1]]

    strict_inc = True
    non_dec = True

    for i in range(n - 1):
        if a[i] >= a[i + 1]:
            strict_inc = False
        if a[i] > a[i + 1]:
            non_dec = False
        if not strict_inc and not non_dec:
            break

    res1 = "YES" if strict_inc else "NO"
    res2 = "YES" if non_dec else "NO"
    print(f"{res1} — {res2}")

if __name__ == "__main__":
    main()