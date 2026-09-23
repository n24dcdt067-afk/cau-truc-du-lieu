module DichVu
using ..CauTruc
using ..BaiLam
export UngDung, trang_thai, thuc_hien!

mutable struct UngDung
    L::DSLK
    s::NganXep
    q::HangDoiVong
end
UngDung() = UngDung(DSLK([10, 20, 30]), NganXep(), HangDoiVong(5))

function trang_thai(u::UngDung)
    q = u.q
    return Dict(
        "language" => "Julia", "edition" => (isdefined(BaiLam, :BAN) ? BaiLam.BAN : "Đáp án"),
        "list" => Dict("values" => gia_tri(u.L), "n" => u.L.n),
        "stack" => Dict("values" => copy(u.s.a), "n" => length(u.s.a), "top" => dinh(u.s)),
        "queue" => Dict("values" => gia_tri(q), "a" => copy(q.a), "n" => q.n,
                        "dau" => q.dau, "so" => q.so,
                        "active" => [mod(q.dau + i, q.n) for i in 0:(q.so - 1)]))
end

function thuc_hien!(u::UngDung, d::AbstractDict)
    before = trang_thai(u)
    backup = deepcopy((u.L, u.s, u.q))
    try
        result, message, steps, trace = xu_ly!(u, d)
        state = trang_thai(u)
        return Dict("ok" => true, "result" => result, "message" => message,
                    "steps" => steps, "trace" => trace, "before" => before, "state" => state)
    catch
        u.L, u.s, u.q = backup
        rethrow()
    end
end

function xu_ly!(u::UngDung, d::AbstractDict)
    op = get(d, "op", "")
    xops = ("list.prepend", "list.append", "list.find", "list.insert", "list.delete",
            "list.count", "list.delete_all", "stack.push", "queue.enqueue")
    x = op in xops ? so_nguyen(get(d, "x", nothing)) : nothing
    if op in ("list.prepend", "list.append", "list.insert") && u.L.n >= 50
        throw(ArgumentError("Giao diện giới hạn danh sách ở 50 nút."))
    end
    if op == "stack.push" && length(u.s.a) >= 50
        throw(ArgumentError("Giao diện giới hạn ngăn xếp ở 50 phần tử."))
    end
    k = op in ("stack.pop_many", "queue.peek_k") ? so_nguyen(get(d, "k", nothing), "k") : nothing
    trace = Any[]
    result = nothing
    message = ""
    steps = String[]
    if op == "all.reset"
        u.L, u.s, u.q = DSLK([10, 20, 30]), NganXep(), HangDoiVong(5)
        message = "Đã khôi phục dữ liệu ban đầu."
        steps = ["Danh sách 10 → 20 → 30. Ngăn xếp và hàng đợi rỗng."]
    elseif op == "list.reset"
        a = get(d, "values", nothing)
        (a isa AbstractVector && length(a) <= 50) || throw(ArgumentError("Nhập một dãy không quá 50 số nguyên."))
        a = [so_nguyen(v) for v in a]
        u.L = DSLK(a)
        result, message = u.L.n, "Đã tạo danh sách mới."
        steps = ["Mỗi giá trị tạo một nút riêng.", "Nút cuối có ke = nothing; n là số nút."]
    elseif op == "list.prepend"
        them_dau!(u.L, x)
        result, message = x, "Đã thêm $x vào đầu."
        steps = ["Tạo nút m chứa x.", "m.ke giữ đầu cũ; dau trỏ tới m; tăng n."]
    elseif op == "list.append"
        them_cuoi!(u.L, x)
        result, message = x, "Đã thêm $x vào cuối."
        steps = ["Rỗng: cập nhật dau. Không rỗng: duyệt đến nút cuối rồi nối m.", "Tăng n lên 1."]
    elseif op == "list.find"
        p, i = u.L.dau, 1
        while p !== nothing && p.gt != x
            p, i = p.ke, i + 1
        end
        result = p === nothing ? nothing : i
        message = p === nothing ? "Không có giá trị $x." : "Tìm thấy $x ở vị trí $i."
        steps = ["Lần theo ke từ dau. Vị trí hiển thị bắt đầu từ 1.", "Giá trị trùng: chọn nút đầu tiên."]
    elseif op == "list.insert"
        target = so_nguyen(get(d, "target", nothing), "Giá trị cần tìm")
        p = tim(u.L, target)
        if p === nothing
            result, message = false, "Không có nút $target; danh sách không đổi."
            steps = ["Cần tìm được nút p trước khi chèn."]
        else
            chen_sau!(u.L, p, x)
            result, message = true, "Đã chèn $x sau nút $target đầu tiên."
            steps = ["m.ke = p.ke giữ phần đuôi.", "p.ke = m nối nút mới; tăng n."]
        end
    elseif op == "list.delete"
        result = xoa!(u.L, x)
        message = result ? "Đã xoá một nút $x." : "Không có $x; danh sách không đổi."
        steps = ["Giữ truoc và p khi tìm.", "Xoá đầu sửa dau; trường hợp khác sửa truoc.ke.", "Chỉ giảm n khi xoá được."]
    elseif op == "list.reverse"
        dao!(u.L)
        result, message = gia_tri(u.L), "Đã đảo chiều các liên kết."
        steps = ["Lưu sau = p.ke trước khi sửa.", "p.ke = truoc; dời truoc và p.", "Cuối cùng dau = truoc; không tạo nút mới."]
    elseif op == "list.count"
        result = dem_gia_tri(u.L, x)
        message = "Số lần xuất hiện của $x: $result."
        steps = ["Đếm theo gt; không thay đổi các liên kết hoặc n."]
    elseif op == "list.delete_all"
        result = xoa_tat_ca!(u.L, x)
        message = "Đã xoá $result nút mang giá trị $x."
        steps = ["Không bỏ sót các nút trùng liên tiếp hoặc ở đầu.", "n giảm bằng số nút đã xoá."]
    elseif op == "stack.reset"
        u.s = NganXep()
        message, steps = "Đã làm rỗng ngăn xếp.", ["Mảng a rỗng, chưa có đỉnh."]
    elseif op == "stack.push"
        day!(u.s, x)
        result, message = x, "Đã đẩy $x lên đỉnh."
        steps = ["push! thêm x vào cuối Vector; phần tử cuối là đỉnh."]
    elseif op == "stack.pop"
        result = lay!(u.s)
        message = result === nothing ? "Ngăn xếp rỗng; không thay đổi." : "Đã lấy $result khỏi đỉnh."
        steps = ["Kiểm tra rỗng; nếu có phần tử thì pop! lấy và xoá phần tử cuối."]
    elseif op == "stack.peek"
        result, message = dinh(u.s), "Đã xem đỉnh; không lấy ra."
        steps = ["Đọc s.a[end] nếu không rỗng, không đổi số phần tử."]
    elseif op == "stack.empty"
        result, message = rong(u.s), "Đã kiểm tra ngăn xếp rỗng."
        steps = ["Kết quả đúng khi số phần tử bằng 0."]
    elseif op == "stack.pop_many"
        result = lay_nhieu!(u.s, k)
        message = "Đã lấy $k phần tử theo LIFO."
        steps = ["Kiểm tra k trước mọi thay đổi.", "Trả kết quả theo thứ tự lấy ra, không phải đáy tới đỉnh."]
    elseif op == "queue.reset"
        n = so_nguyen(get(d, "capacity", nothing), "Sức chứa")
        1 <= n <= 12 || throw(ArgumentError("Sức chứa trên giao diện từ 1 đến 12."))
        u.q = HangDoiVong(n)
        result, message = n, "Đã tạo hàng đợi rỗng."
        steps = ["Cấp phát mảng cố định; dau = 0, so = 0."]
    elseif op == "queue.enqueue"
        index = mod(u.q.dau + u.q.so, u.q.n)
        result = them!(u.q, x)
        message = result ? "Đã ghi $x vào ô logic $index." : "Hàng đầy; từ chối thêm, không ghi đè."
        steps = ["Nếu so = n: trả về false.", "Còn chỗ: ghi ô mod(dau + so, n) + 1 của Vector, rồi tăng so."]
    elseif op == "queue.dequeue"
        result = lay!(u.q)
        message = result === nothing ? "Hàng rỗng; không thay đổi." : "Đã lấy $result ở đầu hàng."
        steps = ["Rỗng: trả về nothing.", "Đọc q.a[dau + 1], tăng dau theo modulo và giảm so.", "Ô cũ vẫn có thể giữ giá trị, nhưng không thuộc hàng đợi logic."]
    elseif op == "queue.peek"
        result, message = xem_dau(u.q), "Đã xem đầu hàng; không lấy ra."
        steps = ["Chỉ đọc, không sửa dau hoặc so."]
    elseif op == "queue.empty"
        result, message = rong(u.q), "Đã kiểm tra hàng đợi rỗng."
        steps = ["Dựa vào so = 0, không dựa vào giá trị còn trong các ô."]
    elseif op == "queue.peek_k"
        result = xem_k(u.q, k)
        message = "Đã xem $k phần tử đầu theo FIFO."
        steps = ["Đi theo chỉ số vòng, không đọc thẳng k ô đầu mảng.", "a, dau, so, n không được thay đổi."]
    elseif op == "brackets.check"
        text = get(d, "text", nothing)
        text isa AbstractString || throw(ArgumentError("Cần nhập một chuỗi."))
        detail = can_ngoac_chi_tiet(text)
        result, message, trace = detail["valid"], detail["reason"], detail["trace"]
        steps = ["Mở: đẩy vào đỉnh. Đóng: phải khớp loại ở đỉnh.", "Cuối chuỗi: ngăn xếp phải rỗng."]
    else
        throw(ArgumentError("Không có thao tác này."))
    end
    return result, message, steps, trace
end
end # module
