import sys

def main():
    s = sys.stdin.read().strip()
    if not s: return
    n = int(s)
    
    count = 0
    total_sum = 0
    
    while n > 0:
        total_sum += n % 10
        count += 1
        n = n // 10
        
    print(f"{count} {total_sum}")

if __name__ == "__main__":
    main()