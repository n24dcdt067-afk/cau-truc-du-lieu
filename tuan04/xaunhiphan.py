def xau_ke_tiep(x: list[int]) -> bool:
    i = len(x) - 1
    # Quét từ phải sang, xóa các số 1 về 0
    while i >= 0 and x[i] == 1:
        x[i] = 0
        i -= 1
    
    # Hết: mọi chữ số đều là 1
    if i < 0:
        return False
    
    # Đổi chữ số 0 đầu tiên thành 1
    x[i] = 1
    return True

def liet_ke_xau(n: int) -> list[str]:
    x = [0] * n
    ds = ["".join(map(str, x))]
    while xau_ke_tiep(x):
        ds.append("".join(map(str, x)))
    return ds

# Chạy thử với n = 3
print(liet_ke_xau(3))