function xoa_tat_ca!(L::DSLK, x::Int)::Int
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
            # Giữ nguyên truoc
        else
            truoc = p
        end
        p = sau
    end
    return dem
end