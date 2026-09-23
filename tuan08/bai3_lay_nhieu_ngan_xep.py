# Cấu trúc Ngăn Xếp (Stack)
class NganXep:
    def __init__(self):
        self.a = []

    def day(self, x):
        self.a.append(x)

    def lay(self):
        if not self.a:
            raise IndexError("Ngăn xếp rỗng")
        return self.a.pop()

    def rong(self):
        return len(self.a) == 0

# Hàm Bài 3: Lấy nhiều phần tử ngăn xếp theo LIFO
def lay_nhieu(s: NganXep, k: int) -> list[int]:
    """Lấy đúng k giá trị theo thứ tự LIFO; k không hợp lệ thì không sửa s."""
    if type(k) is not int or not (0 <= k <= len(s.a)):
        raise ValueError("k phải là số nguyên từ 0 đến số phần tử ngăn xếp.")
    result: list[int] = []
    for _ in range(k):
        result.append(s.lay())
    return result

# --- CHẠY KIỂM THỬ THỰC TẾ ---
if __name__ == "__main__":
    print("=== KIỂM THỬ BÀI 3: LẤY NHIỀU PHẦN TỬ NGĂN XẾP (PYTHON) ===")
    
    # Ca 1: Ngăn xếp [10, 20, 30], lấy k = 2
    s1 = NganXep()
    for x in [10, 20, 30]: s1.day(x)
    kq1 = lay_nhieu(s1, 2)
    print(f"Ca 1 (k = 2): Lấy ra = {kq1} | Ngăn xếp còn = {s1.a}")

    # Ca 2: Lấy k = 0
    s2 = NganXep()
    for x in [10]: s2.day(x)
    kq2 = lay_nhieu(s2, 0)
    print(f"Ca 2 (k = 0): Lấy ra = {kq2} | Ngăn xếp còn = {s2.a}")

    # Ca 3: k không hợp lệ (k = 5, k = True) -> Bắt lỗi và bảo toàn ngăn xếp
    s3 = NganXep()
    for x in [10, 20, 30]: s3.day(x)
    try:
        lay_nhieu(s3, 5)
    except ValueError as e:
        print(f"Ca 3 (k = 5 vượt quá): Bắt lỗi ngoại lệ -> {e}")
        print(f"       Trạng thái s.a được giữ nguyên: {s3.a}")

    try:
        lay_nhieu(s3, True)
    except ValueError as e:
        print(f"Ca 4 (k = True kiểu bool): Bắt lỗi ngoại lệ -> {e}")
        print(f"       Trạng thái s.a được giữ nguyên: {s3.a}")