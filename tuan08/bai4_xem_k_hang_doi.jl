# Cấu trúc Hàng Đợi Vòng
mutable struct HangDoiVong
    n::Int
    a::Vector{Int}
    dau::Int
    so::Int
    HangDoiVong(n::Int=10) = new(n, zeros(Int, n), 0, 0)
end

function them!(q::HangDoiVong, x::Int)
    q.so == q.n && error("Hàng đợi đầy")
    vi_tri = mod(q.dau + q.so, q.n) + 1
    q.a[vi_tri] = x
    q.so += 1
end

function lay!(q::HangDoiVong)
    q.so == 0 && error("Hàng đợi rỗng")
    x = q.a[q.dau + 1]
    q.dau = mod(q.dau + 1, q.n)
    q.so -= 1
    return x
end

# Hàm Bài 4: Xem k phần tử đầu hàng đợi theo FIFO
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

# --- CHẠY KIỂM THỬ THỰC TẾ ---
println("=== KIỂM THỬ BÀI 4: XEM K PHẦN TỬ ĐẦU HÀNG ĐỢI (JULIA) ===")

# Thiết lập tình huống quay vòng: n=4; nạp 1,2,3,4; lấy 2 lần; nạp 5,6
q = HangDoiVong(4)
for x in 1:4 them!(q, x) end
lay!(q); lay!(q)
them!(q, 5); them!(q, 6)

println("Trạng thái ban đầu: mảng a = ", q.a, ", dau = ", q.dau, ", so = ", q.so, ", n = ", q.n)

# Ca 1: Gọi xem_k(q, 3)
kq1 = xem_k(q, 3)
println("Ca 1 (k = 3): Kết quả xem = ", kq1, " (Kỳ vọng: [3, 4, 5])")
println("       Kiểm tra trạng thái sau xem: mảng a = ", q.a, ", dau = ", q.dau, ", so = ", q.so)

# Ca 2: Gọi xem_k(q, 0)
kq2 = xem_k(q, 0)
println("Ca 2 (k = 0): Kết quả xem = ", kq2, " (Kỳ vọng: Int[])")

# Ca 3: Gọi xem_k(q, 4) - Xem toàn bộ FIFO
kq3 = xem_k(q, 4)
println("Ca 3 (k = 4): Kết quả xem = ", kq3, " (Kỳ vọng: [3, 4, 5, 6])")

# Ca 4: k không hợp lệ (k = 5, k = true)
before = (copy(q.a), q.dau, q.so, q.n)
try
    xem_k(q, 5)
catch e
    println("Ca 4 (k = 5 vượt quá): Bắt lỗi ngoại lệ -> ", e)
    println("       Trạng thái được giữ nguyên: ", (q.a, q.dau, q.so, q.n) == before)
end

try
    xem_k(q, true)
catch e
    println("Ca 5 (k = true kiểu Bool): Bắt lỗi ngoại lệ -> ", e)
    println("       Trạng thái được giữ nguyên: ", (q.a, q.dau, q.so, q.n) == before)
end