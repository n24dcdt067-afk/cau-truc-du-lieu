def thu(i: int, n: int, x: list, da_dung: list) -> int:
    if i == n:
        p = 3  # Thay 2 bang p trong R0 (Ca s = 6)
        if x[0] != p:
            return 0
        print(" ".join(map(str, x)))
        return 1

    dem = 0
    for v in range(1, n + 1):
        if not da_dung[v]:
            x[i] = v
            da_dung[v] = True
            dem += thu(i + 1, n, x, da_dung)
            da_dung[v] = False  # Hoan tac
    return dem


def main():
    print("MSSV: N24DCDT067 | Ma ca: 6")
    print("Nhap n (1..8):")
    try:
        n = int(input().strip())
    except (ValueError, EOFError):
        print("Du lieu khong hop le.")
        return
    if not 1 <= n <= 8:
        print("Du lieu khong hop le.")
        return

    x = [0] * n
    da_dung = [False] * (n + 1)
    dem = thu(0, n, x, da_dung)
    print("So hoan vi dat:", dem)


if __name__ == "__main__":
    main()