# Cấu trúc Hàng Đợi Vòng (Circular Queue)
class HangDoiVong:
    def __init__(self, n: int = 10):
        self.n = n
        self.a = [0] * n
        self.dau = 0
        self.so = 0

    def them(self, x: int):
        if self.so == self.n:
            raise OverflowError("Hàng đợi đầy")
        vi_tri = (self.dau + self.so) % self.n
        self.a[vi_tri] = x
        self.so += 1

    def lay(self) -> int:
        if self.so == 0:
            raise IndexError("Hàng đợi rỗng")
        x = self.a[self.dau]
        self.dau = (self.dau + 1) % self.n
        self.so -= 1
        return x

# Hàm Bài 4: Xem k phần tử đầu hàng đợi theo FIFO
def xem_k(q: HangDoiVong, k: int) -> list[int]:
    """Trả về k phần tử đầu theo FIFO, không đổi a, dau, so hoặc n."""
    if type(k) is not int or not (0 <= k <= q.so):
        raise ValueError("k phải là số nguyên từ 0 đến số phần tử hàng đợi.")
    result: list[int] = []
    for i in range(k):
        result.append(q.a[(q.dau + i) % q.n])
    return result

# --- CHẠY KIỂM THỬ THỰC TẾ ---
if __name__ == "__main__":
    print("=== KIỂM THỬ BÀI 4: XEM K PHẦN TỬ ĐẦU HÀNG ĐỢI (PYTHON) ===")

    # Thiết lập tình huống quay vòng theo đúng đề bài:
    # Tạo hàng đợi n=4; thêm 1, 2, 3, 4; lấy 2 lần; thêm 5, 6
    q = HangDoiVong(4)
    for x in [1, 2, 3, 4]:
        q.them(x)
    q.lay()
    q.lay()
    q.them(5)
    q.them(6)
    # Trạng thái lúc này: a = [5, 6, 3, 4], dau = 2, so = 4, n = 4

    print(f"Trạng thái ban đầu: mảng a = {q.a}, dau = {q.dau}, so = {q.so}, n = {q.n}")

    # Ca 1: Gọi xem_k(q, 3)
    kq1 = xem_k(q, 3)
    print(f"Ca 1 (k = 3): Kết quả xem = {kq1} (Kỳ vọng: [3, 4, 5])")
    print(f"       Kiểm tra trạng thái sau xem: mảng a = {q.a}, dau = {q.dau}, so = {q.so}")

    # Ca 2: Gọi xem_k(q, 0)
    kq2 = xem_k(q, 0)
    print(f"Ca 2 (k = 0): Kết quả xem = {kq2} (Kỳ vọng: [])")

    # Ca 3: Gọi xem_k(q, 4) - Xem toàn bộ theo FIFO
    kq3 = xem_k(q, 4)
    print(f"Ca 3 (k = 4): Kết quả xem = {kq3} (Kỳ vọng: [3, 4, 5, 6])")

    # Ca 4: k không hợp lệ (k = 5 vượt quá so=4, k = True) -> Bắt lỗi và giữ nguyên cấu trúc
    before = (q.a.copy(), q.dau, q.so, q.n)
    try:
        xem_k(q, 5)
    except ValueError as e:
        print(f"Ca 4 (k = 5 vượt quá): Bắt lỗi ngoại lệ -> {e}")
        print(f"       Trạng thái được giữ nguyên: {(q.a, q.dau, q.so, q.n) == before}")

    try:
        xem_k(q, True)
    except ValueError as e:
        print(f"Ca 5 (k = True kiểu bool): Bắt lỗi ngoại lệ -> {e}")
        print(f"       Trạng thái được giữ nguyên: {(q.a, q.dau, q.so, q.n) == before}")