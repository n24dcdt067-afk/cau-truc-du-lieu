struct HoatDong
    ten::String
    s::Int
    f::Int
    id::Int
end

# Kiểm tra hai hoạt động có tương thích không
khong_chong_lan(a::HoatDong, b::HoatDong) = (a.f <= b.s) || (b.f <= a.s)

# 1. Tiêu chí: Kết thúc sớm nhất (EFT)
function tham_lam_ket_thuc_som(ds)
    ds_sap_xep = sort(ds, by = x -> (x.f, x.s))
    kq = HoatDong[]
    thoi_gian_cuoi = -1
    for hd in ds_sap_xep
        if hd.s >= thoi_gian_cuoi
            push!(kq, hd)
            thoi_gian_cuoi = hd.f
        end
    end
    return kq
end

# 2. Tiêu chí: Bắt đầu sớm nhất (EST)
function tham_lam_bat_dau_som(ds)
    ds_sap_xep = sort(ds, by = x -> (x.s, x.f))
    kq = HoatDong[]
    thoi_gian_cuoi = -1
    for hd in ds_sap_xep
        if hd.s >= thoi_gian_cuoi
            push!(kq, hd)
            thoi_gian_cuoi = hd.f
        end
    end
    return kq
end

# 3. Tiêu chí: Ngắn nhất (f - s nhỏ nhất)
function tham_lam_ngan_nhat(ds)
    con_lai = copy(ds)
    kq = HoatDong[]
    while !isempty(con_lai)
        chon = argmin(x -> (x.f - x.s, x.id), con_lai)
        push!(kq, chon)
        con_lai = filter(hd -> khong_chong_lan(chon, hd), con_lai)
    end
    return sort(kq, by = x -> x.s)
end

# 4. Tiêu chí: Ít chồng lấn nhất
function tham_lam_it_chong_lan(ds)
    con_lai = copy(ds)
    kq = HoatDong[]
    while !isempty(con_lai)
        dem_xung_dot(hd) = count(other -> other.id != hd.id && !khong_chong_lan(hd, other), con_lai)
        chon = argmin(x -> (dem_xung_dot(x), x.id), con_lai)
        push!(kq, chon)
        con_lai = filter(hd -> khong_chong_lan(chon, hd), con_lai)
    end
    return sort(kq, by = x -> x.s)
end

# 5. Quy hoạch động: Số nhiều nhất thật sự
function toi_uu_quy_hoach_dong(ds)
    ds_sap_xep = sort(ds, by = x -> x.f)
    n = length(ds_sap_xep)
    dp = ones(Int, n)
    vet = fill(-1, n)

    for i in 1:n
        for j in 1:(i-1)
            if ds_sap_xep[j].f <= ds_sap_xep[i].s && dp[j] + 1 > dp[i]
                dp[i] = dp[j] + 1
                vet[i] = j
            end
        end
    end

    max_idx = argmax(dp)
    kq = HoatDong[]
    curr = max_idx
    while curr != -1
        push!(kq, ds_sap_xep[curr])
        curr = vet[curr]
    end
    return reverse(kq)
end

function main()
    ds = [
        HoatDong("H1", 1, 5, 1),
        HoatDong("H2", 2, 5, 2),
        HoatDong("H3", 2, 6, 3),
        HoatDong("H4", 3, 4, 4),
        HoatDong("H5", 4, 8, 5),
        HoatDong("H6", 6, 9, 6),
        HoatDong("H7", 8, 11, 7),
        HoatDong("H8", 9, 14, 8),
        HoatDong("H9", 11, 13, 9),
        HoatDong("H10", 12, 15, 10)
    ]

    tieu_chi = [
        ("Kết thúc sớm nhất", tham_lam_ket_thuc_som(ds)),
        ("Bắt đầu sớm nhất",  tham_lam_bat_dau_som(ds)),
        ("Ngắn nhất",         tham_lam_ngan_nhat(ds)),
        ("Ít chồng lấn nhất", tham_lam_it_chong_lan(ds)),
        ("Số nhiều nhất thật sự", toi_uu_quy_hoach_dong(ds))
    ]

    so_toi_uu = length(tieu_chi[end][2])

    for (ten, kq) in tieu_chi
        ten_hd = join([hd.ten for hd in kq], ", ")
        so_luong = length(kq)
        dung = (ten == "Số nhiều nhất thật sự") ? "—" : (so_luong == so_toi_uu ? "Có" : "Không")
        println(rpad(ten, 25), ": [", ten_hd, "] (", so_luong, " hoạt động) | Tối ưu: ", dung)
    end
end

main()