import matplotlib.pyplot as plt

# Dữ liệu đo thực tế Bài 44
n = [500, 1000, 2000, 4000]
t = [0.005820, 0.024140, 0.097520, 0.386200]

plt.figure(figsize=(7, 4.5), dpi=300)
plt.plot(n, t, marker='o', color='b', linewidth=2, label='Thực nghiệm T(n)')

# Đường lý thuyết c * n^2
c = t[0] / (n[0] ** 2)
t_theory = [c * (x ** 2) for x in n]
plt.plot(n, t_theory, '--', color='r', label='Lý thuyết O(n²)')

plt.title('Đồ thị thời gian chạy thuật toán Selection Sort O(n²)', fontsize=12, fontweight='bold')
plt.xlabel('Kích thước đầu vào n', fontsize=11)
plt.ylabel('Thời gian T(n) (giây)', fontsize=11)
plt.grid(True, linestyle=':', alpha=0.6)
plt.legend()
plt.tight_layout()

# Lưu trực tiếp vào thư mục ketqua
plt.savefig('ketqua/do_thi_bai44.png')
print("Đã tạo xong: ketqua/do_thi_bai44.png")