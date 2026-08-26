# BẢNG TỔNG HỢP THỜI GIAN ĐO THỰC NGHIỆM

## 1. Bài 44: Thuật toán sắp xếp O(n²)
| Kích thước n | Thời gian T(n) (giây) | Tỉ lệ T(2n)/T(n) | Bậc lý thuyết |
| :--- | :--- | :--- | :--- |
| 500 | 0.005820 | - | - |
| 1000 | 0.024140 | 4.15 | ≈ 4.0 |
| 2000 | 0.097520 | 4.04 | ≈ 4.0 |
| 4000 | 0.386200 | 3.96 | ≈ 4.0 |

## 2. Bài 50: Phân loại láng giềng gần nhất (q = 1000 mẫu truy vấn, d = 20)
| Kích thước n | C++ (-O2) | Python thuần | Julia | Tỉ lệ tăng khi n tăng 10 lần |
| :--- | :--- | :--- | :--- | :--- |
| n = 10³ | 0.0152 s | 1.1240 s | 0.0420 s | - |
| n = 10⁴ | 0.1510 s | 11.5800 s | 0.4180 s | ≈ 10.0x |
| n = 10⁵ | 1.5180 s | 116.2000 s | 4.2100 s | ≈ 10.0x |