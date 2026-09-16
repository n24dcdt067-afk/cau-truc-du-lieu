function xau_ke_tiep!(x::Vector{Int})
    i = lastindex(x) # Dùng lastindex thay length để hết cảnh báo linter
    while i >= 1 && x[i] == 1
        x[i] = 0
        i -= 1
    end
    if i < 1
        return false
    end
    x[i] = 1
    return true
end

function liet_ke_xau(n::Int)
    x = zeros(Int, n)
    ds = [join(x)]
    while xau_ke_tiep!(x)
        push!(ds, join(x))
    end
    return ds
end

# In thử kết quả cho n = 3
println(liet_ke_xau(3))