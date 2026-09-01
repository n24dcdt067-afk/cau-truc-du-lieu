function two_pointers_target_sum(a, target)
    # Buoc 1: Sap xep mang - O(n log n)
    arr = sort(a)
    
    # Buoc 2: Duyet hai con tro (Julia su dung 1-based indexing) - O(n)
    left = 1
    right = length(arr)
    
    while left < right
        current_sum = arr[left] + arr[right]
        if current_sum == target
            return true, (arr[left], arr[right])
        elseif current_sum < target
            left += 1
        else
            right -= 1
        end
    end
    
    return false, nothing
end

A = [8, 3, 5, 1, 9, 2]
S = 10  # Tim cap co tong bang 10

println("Mang dau vao: ", A)
println("Tong can tim S = ", S)

found, pair = two_pointers_target_sum(A, S)
if found
    println("Ket qua: Tim thay cap ", pair, " co tong bang ", S)
else
    println("Ket qua: Khong tim thay cap nao thoa man")
end