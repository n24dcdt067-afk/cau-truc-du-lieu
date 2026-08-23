# Python (bai37.py)
import sys

def main():
    input_data = sys.stdin.read().split()
    if not input_data: return

    n = int(input_data[0])
    so_chan = 0
    so_le = 0
    so_am = 0

    for i in range(1, n + 1):
        x = int(input_data[i])
        if x % 2 == 0:
            so_chan += 1
        else:
            so_le += 1

        if x < 0:
            so_am += 1

    print(f"chan {so_chan}, le {so_le}, am {so_am}")

if __name__ == "__main__":
    main()