function dem_gia_tri(L::DSLK, x::Int)::Int
    dem = 0
    p = L.dau
    while p !== nothing
        if p.gt == x
            dem += 1
        end
        p = p.ke
    end
    return dem
end