def two_pointers_target_sum(a, target):
    # Buoc 1: Sap xep mang neu chua sap xep - O(n log n)
    arr = sorted(a)
    
    # Buoc 2: Kiem tra bang hai con tro - O(n)
    left = 0
    right = len(arr) - 1
    
    while left < right:
        current_sum = arr[left] + arr[right]
        if current_sum == target:
            return True, (arr[left], arr[right])
        elif current_sum < target:
            left += 1
        else:
            right -= 1
            
    return False, None

if __name__ == "__main__":
    A = [8, 3, 5, 1, 9, 2]
    S = 10  # Tim cap co tong bang 10 (vi du: 1 + 9 hoac 8 + 2)
    
    print(f"Mang dau vao: {A}")
    print(f"Tong can tim S = {S}")
    found, pair = two_pointers_target_sum(A, S)
    if found:
        print(f"Ket qua: Tim thay cap {pair} co tong bang {S}")
    else:
        print("Ket qua: Khong tim thay cap nao thoa man")