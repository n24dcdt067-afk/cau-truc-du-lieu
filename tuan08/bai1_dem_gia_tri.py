def dem_gia_tri(L: DSLK, x: int) -> int:
    """Đếm số nút có gt == x bằng cách duyệt các liên kết; không đổi L."""
    x = so_nguyen(x)
    dem, p = 0, L.dau
    while p is not None:
        if p.gt == x:
            dem += 1
        p = p.ke
    return dem
# 1. Định nghĩa các cấu trúc cần thiết
class Nut:
    def __init__(self, gt, ke=None):
        self.gt = gt
        self.ke = ke

class DSLK:
    def __init__(self):
        self.dau = None
        self.n = 0

    def them_cuoi(self, gt):
        m = Nut(gt)
        if self.dau is None:
            self.dau = m
        else:
            p = self.dau
            while p.ke is not None:
                p = p.ke
            p.ke = m
        self.n += 1

def so_nguyen(x):
    return int(x)

# 2. Hàm của Bài 1
def dem_gia_tri(L: DSLK, x: int) -> int:
    """Đếm số nút có gt == x bằng cách duyệt các liên kết; không đổi L."""
    x = so_nguyen(x)
    dem, p = 0, L.dau
    while p is not None:
        if p.gt == x:
            dem += 1
        p = p.ke
    return dem

# 3. Đoạn chạy thử (Test case)
if __name__ == "__main__":
    # Test 1: Tạo danh sách 2 -> 1 -> 2 -> 2
    L = DSLK()
    for v in [2, 1, 2, 2]:
        L.them_cuoi(v)
    
    kq1 = dem_gia_tri(L, 2)
    print("Danh sách: 2 -> 1 -> 2 -> 2 | Đếm x = 2 -> Kết quả:", kq1)

    # Test 2: Danh sách rỗng
    L_rong = DSLK()
    kq2 = dem_gia_tri(L_rong, 2)
    print("Danh sách rỗng | Đếm x = 2 -> Kết quả:", kq2)