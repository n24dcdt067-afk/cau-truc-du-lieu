def solve_tsp():
    # Ma tran chi phi de bai muc D
    c = [
        [0, 10, 9, 22, 23],
        [10, 0, 16, 19, 14],
        [9, 16, 0, 7, 28],
        [22, 19, 7, 0, 8],
        [23, 14, 28, 8, 0]
    ]
    n = len(c)

    # Tim canh re nhat toan ma tran (u != v)
    c_min = float('inf')
    for i in range(n):
        for j in range(n):
            if i != j and c[i][j] < c_min:
                c_min = c[i][j]

    # 1. Che do CO cat nhanh
    nodes_cut = 0
    min_cost_cut = float('inf')
    best_tour_cut = []
    tour = [0] * (n + 1)
    visited = [False] * n
    visited[0] = True

    def branch_and_bound(i, current_cost):
        nonlocal nodes_cut, min_cost_cut, best_tour_cut
        nodes_cut += 1

        for v in range(n):
            if not visited[v]:
                cost = current_cost + c[tour[i - 1]][v]
                # Can duoi: chi phi da di + so canh con lai * c_min
                lower_bound = cost + (n - i) * c_min

                if lower_bound < min_cost_cut:
                    tour[i] = v
                    visited[v] = True

                    if i == n - 1:
                        nodes_cut += 1  # Nut la khép chu trinh
                        total_cost = cost + c[v][tour[0]]
                        if total_cost < min_cost_cut:
                            min_cost_cut = total_cost
                            tour[n] = tour[0]
                            best_tour_cut = list(tour)
                    else:
                        branch_and_bound(i + 1, cost)

                    visited[v] = False

    branch_and_bound(1, 0)

    # 2. Che do KHONG cat nhanh
    nodes_no_cut = 0
    min_cost_no_cut = float('inf')
    visited_nc = [False] * n
    visited_nc[0] = True
    tour_nc = [0] * (n + 1)

    def backtrack_no_cut(i, current_cost):
        nonlocal nodes_no_cut, min_cost_no_cut
        nodes_no_cut += 1

        for v in range(n):
            if not visited_nc[v]:
                cost = current_cost + c[tour_nc[i - 1]][v]
                tour_nc[i] = v
                visited_nc[v] = True

                if i == n - 1:
                    nodes_no_cut += 1  # Nut la khép chu trinh
                    total_cost = cost + c[v][tour_nc[0]]
                    if total_cost < min_cost_no_cut:
                        min_cost_no_cut = total_cost
                else:
                    backtrack_no_cut(i + 1, cost)

                visited_nc[v] = False

    backtrack_no_cut(1, 0)

    print(f"Canh re nhat toan ma tran c_min: {c_min}")
    print(f"Chi phi hanh trinh toi uu: {min_cost_cut}")
    print(f"Hanh trinh toi uu: {' -> '.join(map(str, best_tour_cut))}")
    print(f"So nut khi CO cat nhanh: {nodes_cut}")
    print(f"So nut khi KHONG cat nhanh: {nodes_no_cut}")

if __name__ == "__main__":
    solve_tsp()