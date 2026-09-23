module BaiLam
using ..CauTruc
const BAN = "Sinh viên"

struct ChuaHoanThanh <: Exception
    msg::String
end
Base.showerror(io::IO, e::ChuaHoanThanh) = print(io, e.msg)
export dem_gia_tri, xoa_tat_ca!, lay_nhieu!, xem_k

"""Đếm các nút có gt == x, không thay đổi danh sách."""
function dem_gia_tri(L::DSLK, x)
    x = so_nguyen(x)
    dem = 0
    p = L.dau
    while p !== nothing
        p.gt == x && (dem += 1)
        p = p.ke
    end
    return dem
end

"""Một lượt duyệt, không tạo nút mới, trả về số nút đã xoá."""
function xoa_tat_ca!(L::DSLK, x)
    x = so_nguyen(x)
    dem = 0
    truoc = nothing
    p = L.dau
    while p !== nothing
        sau = p.ke
        if p.gt == x
            if truoc === nothing
                L.dau = sau
            else
                truoc.ke = sau
            end
            L.n -= 1
            dem += 1
            # Không dời truoc khi nút hiện tại bị loại.
        else
            truoc = p
        end
        p = sau
    end
    return dem
end

"""Lấy đúng k giá trị LIFO; kiểm tra k trước mọi thay đổi."""
function lay_nhieu!(s::NganXep, k)
    if !(k isa Integer) || k isa Bool || !(0 <= k <= length(s.a))
        throw(ArgumentError("k phải là số nguyên từ 0 đến số phần tử ngăn xếp."))
    end
    out = Int[]
    for _ in 1:k
        push!(out, lay!(s))
    end
    return out
end

"""Xem k giá trị FIFO mà không sửa a, dau, so, n."""
function xem_k(q::HangDoiVong, k)
    if !(k isa Integer) || k isa Bool || !(0 <= k <= q.so)
        throw(ArgumentError("k phải là số nguyên từ 0 đến số phần tử hàng đợi."))
    end
    out = Int[]
    for i in 0:(k - 1)
        push!(out, q.a[mod(q.dau + i, q.n) + 1])
    end
    return out
end

end # module