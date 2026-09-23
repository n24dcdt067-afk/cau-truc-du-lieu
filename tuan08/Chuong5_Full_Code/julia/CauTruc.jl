"""Thuật toán Chương 5. Mô-đun này chỉ dùng Julia Base, không cần gói ngoài."""
module CauTruc
export Nut, DSLK, NganXep, HangDoiVong, so_nguyen, them_dau!, them_cuoi!,
       tim, chen_sau!, xoa!, dao!, gia_tri, day!, lay!, dinh, rong, them!,
       xem_dau, can_ngoac_chi_tiet

function so_nguyen(x, ten="Giá trị")
    if !(x isa Integer) || x isa Bool || !(-1_000_000 <= x <= 1_000_000)
        throw(ArgumentError("$ten phải là số nguyên từ -1000000 đến 1000000."))
    end
    return Int(x)
end

mutable struct Nut
    gt::Int
    ke::Union{Nut,Nothing}
end
Nut(gt::Int) = Nut(gt, nothing)

mutable struct DSLK
    dau::Union{Nut,Nothing}
    n::Int
end
DSLK() = DSLK(nothing, 0)
function DSLK(values::AbstractVector)
    L = DSLK()
    for x in values
        them_cuoi!(L, x)
    end
    return L
end

function them_dau!(L::DSLK, gt)
    L.dau = Nut(so_nguyen(gt), L.dau)
    L.n += 1
    return L
end

function them_cuoi!(L::DSLK, gt)
    m = Nut(so_nguyen(gt))
    if L.dau === nothing
        L.dau = m
    else
        p = L.dau
        while p.ke !== nothing
            p = p.ke
        end
        p.ke = m
    end
    L.n += 1
    return L
end

function tim(L::DSLK, gt)
    gt = so_nguyen(gt)
    p = L.dau
    while p !== nothing && p.gt != gt
        p = p.ke
    end
    return p
end

"""Điều kiện: p thuộc danh sách L, thường nhận từ hàm tim."""
function chen_sau!(L::DSLK, p::Nut, gt)
    m = Nut(so_nguyen(gt), p.ke)  # Giữ đuôi trước khi thay p.ke.
    p.ke = m
    L.n += 1
    return m
end

function xoa!(L::DSLK, gt)
    gt = so_nguyen(gt)
    truoc = nothing
    p = L.dau
    while p !== nothing && p.gt != gt
        truoc = p
        p = p.ke
    end
    p === nothing && return false
    if truoc === nothing
        L.dau = p.ke
    else
        truoc.ke = p.ke
    end
    L.n -= 1
    return true
end

function dao!(L::DSLK)
    truoc = nothing
    p = L.dau
    while p !== nothing
        sau = p.ke
        p.ke = truoc
        truoc = p
        p = sau
    end
    L.dau = truoc
    return L
end

"""Bản sao dùng để hiển thị/kiểm thử; phát hiện chu trình và n không khớp."""
function gia_tri(L::DSLK)
    out = Int[]
    seen = IdDict{Nut,Bool}()
    p = L.dau
    while p !== nothing
        haskey(seen, p) && throw(ArgumentError("Danh sách có chu trình. Kiểm tra ke."))
        seen[p] = true
        push!(out, p.gt)
        p = p.ke
    end
    length(out) == L.n || throw(ArgumentError("n không bằng số nút thực tế."))
    return out
end

mutable struct NganXep
    a::Vector{Int}
end
NganXep() = NganXep(Int[])
day!(s::NganXep, x) = (push!(s.a, so_nguyen(x)); s)
lay!(s::NganXep) = isempty(s.a) ? nothing : pop!(s.a)
dinh(s::NganXep) = isempty(s.a) ? nothing : s.a[end]
rong(s::NganXep) = isempty(s.a)

mutable struct HangDoiVong
    a::Vector{Union{Int,Nothing}}
    n::Int
    dau::Int  # Chỉ số logic từ 0; khi truy cập Vector phải cộng 1.
    so::Int
end
function HangDoiVong(n::Integer=5)
    (n isa Bool || n <= 0) && throw(ArgumentError("Sức chứa phải là số nguyên dương."))
    a = Vector{Union{Int,Nothing}}(undef, n)
    fill!(a, nothing)
    return HangDoiVong(a, Int(n), 0, 0)
end
function them!(q::HangDoiVong, x)
    x = so_nguyen(x)
    q.so == q.n && return false
    q.a[mod(q.dau + q.so, q.n) + 1] = x
    q.so += 1
    return true
end
function lay!(q::HangDoiVong)
    q.so == 0 && return nothing
    x = q.a[q.dau + 1]
    # Ô cũ giữ giá trị, nhưng đã nằm ngoài các phần tử hợp lệ.
    q.dau = mod(q.dau + 1, q.n)
    q.so -= 1
    return x
end
xem_dau(q::HangDoiVong) = q.so == 0 ? nothing : q.a[q.dau + 1]
rong(q::HangDoiVong) = q.so == 0
function gia_tri(q::HangDoiVong)
    out = Int[]
    for i in 0:(q.so - 1)
        push!(out, q.a[mod(q.dau + i, q.n) + 1])
    end
    return out
end

"""Kiểm tra cấu trúc ngoặc, không phân tích cú pháp mã nguồn/dấu nháy."""
function can_ngoac_chi_tiet(text::AbstractString)
    length(text) <= 200 || throw(ArgumentError("Chuỗi kiểm tra tối đa 200 ký tự."))
    cap = Dict(')' => '(', ']' => '[', '}' => '{')
    st = Char[]
    trace = Any[]
    # enumerate đếm ký tự, không dùng chỉ số byte UTF-8 của chuỗi Julia.
    for (i, c) in enumerate(text)
        good = true
        if c in "([{"
            push!(st, c)
            note = "Đưa ngoặc mở vào đỉnh."
        elseif c in ")]}"
            if isempty(st)
                note, good = "Ngoặc đóng không có ngoặc mở tương ứng.", false
            elseif st[end] != cap[c]
                note, good = "Ngoặc đóng khác loại với ngoặc mở ở đỉnh.", false
            else
                pop!(st)
                note = "Khớp loại: lấy ngoặc mở khỏi đỉnh."
            end
        else
            note = "Không phải dấu ngoặc: bỏ qua."
        end
        push!(trace, Dict("pos" => i, "char" => string(c), "stack" => string.(st),
                         "note" => note, "ok" => good))
        if !good
            return Dict("valid" => false, "reason" => note, "trace" => trace)
        end
    end
    good = isempty(st)
    note = good ? "Các dấu ngoặc khớp nhau." : "Còn ngoặc mở chưa được đóng."
    push!(trace, Dict("pos" => length(text) + 1, "char" => "", "stack" => string.(st),
                     "note" => note, "ok" => good))
    return Dict("valid" => good, "reason" => note, "trace" => trace)
end
end # module
