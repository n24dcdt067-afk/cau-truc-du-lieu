using Test, Random
include("CauTruc.jl")
include("BaiLam.jl")
using .CauTruc, .BaiLam

function make_stack(values)
    s = NganXep()
    for x in values; day!(s, x); end
    return s
end
function queue_wrap()
    q = HangDoiVong(4)
    for x in 1:4; them!(q, x); end
    lay!(q); lay!(q); them!(q, 5); them!(q, 6)
    return q
end

@testset "BT1: đếm giá trị" begin
    @test dem_gia_tri(DSLK(), 2) == 0
    L = DSLK([2, 1, 2, 2]); head = L.dau
    @test dem_gia_tri(L, 2) == 3
    @test gia_tri(L) == [2, 1, 2, 2]
    @test L.dau === head
    @test dem_gia_tri(DSLK([1, 3]), 2) == 0
end
@testset "BT2: xoá mọi giá trị" begin
    L = DSLK([2, 2, 1, 2, 3, 2]); p1, p3 = tim(L, 1), tim(L, 3)
    @test xoa_tat_ca!(L, 2) == 4
    @test gia_tri(L) == [1, 3]
    @test L.n == 2
    @test L.dau === p1
    @test p1.ke === p3
    L = DSLK([4, 4, 4])
    @test xoa_tat_ca!(L, 4) == 3
    @test L.dau === nothing
    @test gia_tri(L) == Int[]
    @test xoa_tat_ca!(DSLK(), 4) == 0
    L = DSLK([1, 2]); @test xoa_tat_ca!(L, 8) == 0
    @test gia_tri(L) == [1, 2]
end
@testset "BT3: lấy nhiều theo LIFO" begin
    s = make_stack([10, 20, 30])
    @test lay_nhieu!(s, 2) == [30, 20]
    @test s.a == [10]
    @test lay_nhieu!(s, 0) == Int[]
    @test s.a == [10]
    @test lay_nhieu!(s, 1) == [10]
    @test rong(s)
    @test lay_nhieu!(s, 0) == Int[]
    for k in (-1, 4, 1.5, true)
        s = make_stack([10, 20, 30]); before = copy(s.a)
        @test_throws ArgumentError lay_nhieu!(s, k)
        @test s.a == before
    end
    @test_throws ArgumentError lay_nhieu!(NganXep(), 1)
end
@testset "BT4: xem k phần tử FIFO" begin
    q = queue_wrap(); before = (copy(q.a), q.dau, q.so, q.n)
    @test xem_k(q, 3) == [3, 4, 5]
    @test (q.a, q.dau, q.so, q.n) == before
    @test xem_k(q, 0) == Int[]
    @test xem_k(q, 4) == [3, 4, 5, 6]
    for k in (-1, 5, 1.5, true)
        q = queue_wrap(); before = (copy(q.a), q.dau, q.so, q.n)
        @test_throws ArgumentError xem_k(q, k)
        @test (q.a, q.dau, q.so, q.n) == before
    end
    @test xem_k(HangDoiVong(4), 0) == Int[]
    @test_throws ArgumentError xem_k(HangDoiVong(4), 1)
end
@testset "200 dãy đối chiếu, seed cố định" begin
    rng = MersenneTwister(20260917)
    for _ in 1:200
        a = rand(rng, -3:3, rand(rng, 0:29)); x = rand(rng, -3:3)
        L = DSLK(a)
        @test dem_gia_tri(L, x) == count(==(x), a)
        @test xoa_tat_ca!(L, x) == count(==(x), a)
        @test gia_tri(L) == filter(!=(x), a)
    end
end
