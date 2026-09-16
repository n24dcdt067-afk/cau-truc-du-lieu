# Danh sách 10 hoạt động: (Tên, Bắt đầu, Kết thúc)
hoat_dong = [
    ("H1", 1, 5),
    ("H2", 2, 5),
    ("H3", 2, 6),
    ("H4", 3, 4),
    ("H5", 4, 8),
    ("H6", 6, 9),
    ("H7", 8, 11),
    ("H8", 9, 14),
    ("H9", 11, 13),
    ("H10", 12, 15)
]

def khong_chong_lan(a, b):
    # Hai hoạt động [s1, f1) và [s2, f2) không chồng lấn khi f1 <= s2 hoặc f2 <= s1
    return a[2] <= b[1] or b[2] <= a[1]

# 1. Tiêu chí: Kết thúc sớm nhất (EFT)
def tham_lam_ket_thuc_som(ds):
    ds_sap_xep = sorted(ds, key=lambda x: (x[2], x[1]))
    kq = []
    thoi_gian_cuoi = -1
    for hd in ds_sap_xep:
        if hd[1] >= thoi_gian_cuoi:
            kq.append(hd)
            thoi_gian_cuoi = hd[2]
    return kq

# 2. Tiêu chí: Bắt đầu sớm nhất (EST)
def tham_lam_bat_dau_som(ds):
    ds_sap_xep = sorted(ds, key=lambda x: (x[1], x[2]))
    kq = []
    thoi_gian_cuoi = -1
    for hd in ds_sap_xep:
        if hd[1] >= thoi_gian_cuoi:
            kq.append(hd)
            thoi_gian_cuoi = hd[2]
    return kq

# 3. Tiêu chí: Thời lượng ngắn nhất (f - s nhỏ nhất)
def tham_lam_ngan_nhat(ds):
    ds_con_lai = ds.copy()
    kq = []
    while ds_con_lai:
        # Chọn hoạt động có độ dài nhỏ nhất, nếu bằng nhau thì ưu tiên thứ tự ban đầu
        chon = min(ds_con_lai, key=lambda x: (x[2] - x[1], ds.index(x)))
        kq.append(chon)
        ds_con_lai = [hd for hd in ds_con_lai if khong_chong_lan(chon, hd)]
    return sorted(kq, key=lambda x: x[1])

# 4. Tiêu chí: Ít chồng lấn nhất với các hoạt động khác
def tham_lam_it_chong_lan(ds):
    ds_con_lai = ds.copy()
    kq = []
    while ds_con_lai:
        def dem_xung_dot(hd):
            return sum(1 for other in ds_con_lai if other != hd and not khong_chong_lan(hd, other))
        
        # Chọn hoạt động có số xung đột ít nhất
        chon = min(ds_con_lai, key=lambda x: (dem_xung_dot(x), ds.index(x)))
        kq.append(chon)
        ds_con_lai = [hd for hd in ds_con_lai if khong_chong_lan(chon, hd)]
    return sorted(kq, key=lambda x: x[1])

# 5. Quy hoạch động: Tìm số hoạt động nhiều nhất thật sự
def toi_uu_quy_hoach_dong(ds):
    ds_sap_xep = sorted(ds, key=lambda x: x[2])
    n = len(ds_sap_xep)
    dp = [1] * n
    vet = [-1] * n

    for i in range(n):
        for j in range(i):
            if ds_sap_xep[j][2] <= ds_sap_xep[i][1]:
                if dp[j] + 1 > dp[i]:
                    dp[i] = dp[j] + 1
                    vet[i] = j

    max_val = max(dp)
    idx = dp.index(max_val)
    kq = []
    while idx != -1:
        kq.append(ds_sap_xep[idx])
        idx = vet[idx]
    return sorted(kq, key=lambda x: x[1])

if __name__ == "__main__":
    tieu_chi = [
        ("Kết thúc sớm nhất", tham_lam_ket_thuc_som(hoat_dong)),
        ("Bắt đầu sớm nhất", tham_lam_bat_dau_som(hoat_dong)),
        ("Ngắn nhất", tham_lam_ngan_nhat(hoat_dong)),
        ("Ít chồng lấn nhất", tham_lam_it_chong_lan(hoat_dong)),
        ("Số nhiều nhất thật sự", toi_uu_quy_hoach_dong(hoat_dong))
    ]

    so_toi_uu = len(tieu_chi[-1][1])

    for ten, kq in tieu_chi:
        ten_hd = ", ".join([hd[0] for hd in kq])
        so_luong = len(kq)
        dung = "Có" if so_luong == so_toi_uu else "Không"
        if ten == "Số nhiều nhất thật sự":
            dung = "—"
        print(f"{ten:25}: [{ten_hd}] ({so_luong} hoạt động) | Tối ưu: {dung}")