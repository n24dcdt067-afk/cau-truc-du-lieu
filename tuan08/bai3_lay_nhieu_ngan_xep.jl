# Cấu trúc Ngăn Xếp
mutable struct NganXep
    a::Vector{Int}
    NganXep() = new(Int[])
end

day!(s::NganXep, x::Int) = push!(s.a, x)
lay!(s::NganXep) = isempty(s.a) ? error("Ngăn xếp rỗng") : pop!(s.a)

# Hàm Bài 3: Lấy nhiều phần tử ngăn xếp theo LIFO
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

# --- CHẠY KIỂM THỬ THỰC TẾ ---
println("=== KIỂM THỬ BÀI 3: LẤY NHIỀU PHẦN TỬ NGĂN XẾP (JULIA) ===")

# Ca 1: Ngăn xếp [10, 20, 30], lấy k = 2
s1 = NganXep()
for x in [10, 20, 30] day!(s1, x) end
kq1 = lay_nhieu!(s1, 2)
println("Ca 1 (k = 2): Lấy ra = ", kq1, " | Ngăn xếp còn = ", s1.a)

# Ca 2: Lấy k = 0
s2 = NganXep()
day!(s2, 10)
kq2 = lay_nhieu!(s2, 0)
println("Ca 2 (k = 0): Lấy ra = ", kq2, " | Ngăn xếp còn = ", s2.a)

# Ca 3: k không hợp lệ
s3 = NganXep()
for x in [10, 20, 30] day!(s3, x) end
try
    lay_nhieu!(s3, 4)
catch e
    println("Ca 3 (k = 4 vượt quá): Bắt lỗi ngoại lệ -> ", e)
    println("       Trạng thái s.a giữ nguyên: ", s3.a)
end

try
    lay_nhieu!(s3, true)
catch e
    println("Ca 4 (k = true kiểu Bool): Bắt lỗi ngoại lệ -> ", e)
    println("       Trạng thái s.a giữ nguyên: ", s3.a)
end