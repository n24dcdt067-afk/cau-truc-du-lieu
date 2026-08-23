import sys

def main():
    # sys.stdin.read().split() là phương thức chuẩn đọc nhanh dữ liệu
    input_data = sys.stdin.read().split()
    if not input_data:
        return
    
    n = int(input_data[0])
    first_val = int(input_data[1])
    
    total_sum = first_val
    min_val = first_val
    max_val = first_val
    
    for i in range(2, n + 1):
        x = int(input_data[i])
        total_sum += x
        if x < min_val:
            min_val = x
        if x > max_val:
            max_val = x
            
    avg = total_sum / n
    print(f"{total_sum} {avg:.4f} {min_val} {max_val}")

if __name__ == "__main__":
    main()