using Test, Random
include("CauTruc.jl")
using .CauTruc

@testset "Danh sách liên kết" begin
    L = DSLK()
    @test gia_tri(L) == Int[]
    @test tim(L, 1) === nothing
    @test !xoa!(L, 1)
    them_cuoi!(L, 20); them_dau!(L, 10); them_cuoi!(L, 30)
    @test gia_tri(L) == [10, 20, 30]
    p = tim(L, 20); old = p.ke
    m = chen_sau!(L, p, 25)
    @test m.ke === old
    @test gia_tri(L) == [10, 20, 25, 30]
    @test xoa!(L, 10)
    @test xoa!(L, 30)
    @test gia_tri(L) == [20, 25]
    @test !xoa!(L, 99)
    head = L.dau; tail = head.ke
    dao!(L)
    @test L.dau === tail
    @test tail.ke === head
    @test gia_tri(L) == [25, 20]
    for values in [Int[], [1]]
        K = DSLK(values); dao!(K)
        @test gia_tri(K) == values
    end
    K = DSLK([2, 2, 3]); xoa!(K, 2)
    @test gia_tri(K) == [2, 3]
    K = DSLK([1]); K.dau.ke = K.dau
    @test_throws ArgumentError gia_tri(K)
    K = DSLK([1]); K.n = 9
    @test_throws ArgumentError gia_tri(K)
end

@testset "Ngăn xếp" begin
    s = NganXep()
    @test rong(s)
    @test lay!(s) === nothing
    @test dinh(s) === nothing
    for x in [10, 20, 30]; day!(s, x); end
    @test dinh(s) == 30
    @test s.a == [10, 20, 30]
    @test [lay!(s), lay!(s), lay!(s)] == [30, 20, 10]
end

@testset "Hàng đợi vòng" begin
    @test_throws ArgumentError HangDoiVong(0)
    @test_throws ArgumentError HangDoiVong(-1)
    q = HangDoiVong(4)
    @test rong(q)
    @test lay!(q) === nothing
    @test gia_tri(q) == Int[]
    for x in 1:4; @test them!(q, x); end
    before = (copy(q.a), q.dau, q.so)
    @test !them!(q, 5)
    @test (q.a, q.dau, q.so) == before
    @test lay!(q) == 1
    @test q.a == [1, 2, 3, 4]
    @test gia_tri(q) == [2, 3, 4]
    @test them!(q, 5)
    @test q.a == [5, 2, 3, 4]
    @test gia_tri(q) == [2, 3, 4, 5]
    q = HangDoiVong(1)
    @test them!(q, 0)
    @test !them!(q, 1)
    @test lay!(q) == 0
    @test them!(q, 2)
end

@testset "Ngoặc và kiểu đầu vào" begin
    for text in ["", "a+b", "(a+[b*c])-{d/e}", "((()))"]
        @test can_ngoac_chi_tiet(text)["valid"]
    end
    for text in [")(", "([)]", "(()", "(a+[b)*c]"]
        @test !can_ngoac_chi_tiet(text)["valid"]
    end
    @test can_ngoac_chi_tiet("á[)]")["trace"][end]["pos"] == 3
    for x in [true, 2.5, "2", nothing, 1000001]
        @test_throws ArgumentError so_nguyen(x)
    end
end

@testset "Đối chiếu 1000 thao tác danh sách, seed cố định" begin
    rng = MersenneTwister(20260917)
    L = DSLK(); ref = Int[]
    for _ in 1:1000
        x = rand(rng, -10:10); op = rand(rng, 0:3)
        if op == 0
            them_dau!(L, x); pushfirst!(ref, x)
        elseif op == 1
            them_cuoi!(L, x); push!(ref, x)
        elseif op == 2
            idx = findfirst(==(x), ref)
            @test xoa!(L, x) == (idx !== nothing)
            if idx !== nothing; deleteat!(ref, idx); end
        else
            dao!(L); reverse!(ref)
        end
        @test gia_tri(L) == ref
    end
end

@testset "Đối chiếu 1000 thao tác hàng đợi, seed cố định" begin
    rng = MersenneTwister(20260917)
    q = HangDoiVong(7); ref = Int[]
    for _ in 1:1000
        if rand(rng) < 0.6
            x = rand(rng, -10:10); allowed = length(ref) < 7
            @test them!(q, x) == allowed
            if allowed; push!(ref, x); end
        else
            expected = isempty(ref) ? nothing : popfirst!(ref)
            @test lay!(q) === expected
        end
        @test gia_tri(q) == ref
    end
end
println("Đã kết thúc kiểm thử cơ bản. Xem kết quả Test Summary ở trên.")
