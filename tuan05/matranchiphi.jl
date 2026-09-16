function solve_tsp()
    # Ma tran chi phi de bai muc D (chi so tu 1 den 5 ung voi dinh 0 den 4)
    c = [
         0 10  9 22 23;
        10  0 16 19 14;
         9 16  0  7 28;
        22 19  7  0  8;
        23 14 28  8  0
    ]
    n = size(c, 1)

    # Tim canh re nhat toan ma tran (u != v)
    c_min = typemax(Int)
    for i in 1:n
        for j in 1:n
            if i != j && c[i, j] < c_min
                c_min = c[i, j]
            end
        end
    end

    # 1. Che do CO cat nhanh
    nodes_cut = 0
    min_cost_cut = typemax(Int)
    best_tour_cut = zeros(Int, n + 1)
    tour = zeros(Int, n + 1)
    tour[1] = 1
    visited = falses(n)
    visited[1] = true

    function branch_and_bound(i, current_cost)
        nodes_cut += 1

        for v in 1:n
            if !visited[v]
                cost = current_cost + c[tour[i - 1], v]
                lower_bound = cost + (n - i) * c_min

                if lower_bound < min_cost_cut
                    tour[i] = v
                    visited[v] = true

                    if i == n
                        nodes_cut += 1 # Nut la khep chu trinh
                        total_cost = cost + c[v, tour[1]]
                        if total_cost < min_cost_cut
                            min_cost_cut = total_cost
                            tour[n + 1] = tour[1]
                            best_tour_cut = copy(tour)
                        end
                    else
                        branch_and_bound(i + 1, cost)
                    end

                    visited[v] = false
                end
            end
        end
    end

    branch_and_bound(2, 0)

    # 2. Che do KHONG cat nhanh
    nodes_no_cut = 0
    min_cost_no_cut = typemax(Int)
    tour_nc = zeros(Int, n + 1)
    tour_nc[1] = 1
    visited_nc = falses(n)
    visited_nc[1] = true

    function backtrack_no_cut(i, current_cost)
        nodes_no_cut += 1

        for v in 1:n
            if !visited_nc[v]
                cost = current_cost + c[tour_nc[i - 1], v]
                tour_nc[i] = v
                visited_nc[v] = true

                if i == n
                    nodes_no_cut += 1 # Nut la khep chu trinh
                    total_cost = cost + c[v, tour_nc[1]]
                    if total_cost < min_cost_no_cut
                        min_cost_no_cut = total_cost
                    end
                else
                    backtrack_no_cut(i + 1, cost)
                end

                visited_nc[v] = false
            end
        end
    end

    backtrack_no_cut(2, 0)

    # Chuyen chi so 1..5 ve dinh 0..4 theo de bai
    output_tour = [x - 1 for x in best_tour_cut]

    println("Canh re nhat toan ma tran c_min: ", c_min)
    println("Chi phi hanh trinh toi uu: ", min_cost_cut)
    println("Hanh trinh toi uu: ", join(output_tour, " -> "))
    println("So nut khi CO cat nhanh: ", nodes_cut)
    println("So nut khi KHONG cat nhanh: ", nodes_no_cut)
end

solve_tsp()