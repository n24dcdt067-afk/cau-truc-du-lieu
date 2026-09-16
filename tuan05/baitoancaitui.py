def knapsack_branch_and_bound():
    names = ['A', 'B', 'C', 'D', 'E', 'F']
    w = [4, 7, 3, 3, 3, 10]
    v = [19, 25, 7, 8, 9, 21]
    W = 14
    n = len(names)

    items = sorted(
        range(n),
        key=lambda i: v[i] / w[i],
        reverse=True
    )
    names = [names[i] for i in items]
    w = [w[i] for i in items]
    v = [v[i] for i in items]

    def bound(i, current_w, current_v):
        if current_w >= W:
            return 0
        b = current_v
        remain_w = W - current_w
        for j in range(i, n):
            if w[j] <= remain_w:
                remain_w -= w[j]
                b += v[j]
            else:
                b += v[j] * (remain_w / w[j])
                break
        return b

    # 1. Chế độ CÓ cắt nhánh
    nodes_cut = 0
    max_v_cut = 0
    best_x_cut = [0] * n
    x = [0] * n

    def branch_and_bound(i, current_w, current_v):
        nonlocal nodes_cut, max_v_cut, best_x_cut
        nodes_cut += 1

        if current_v > max_v_cut:
            max_v_cut = current_v
            best_x_cut = list(x)

        if i == n:
            return

        if current_w + w[i] <= W:
            x[i] = 1
            if bound(i + 1, current_w + w[i], current_v + v[i]) > max_v_cut:
                branch_and_bound(i + 1, current_w + w[i], current_v + v[i])
            x[i] = 0

        if bound(i + 1, current_w, current_v) > max_v_cut:
            x[i] = 0
            branch_and_bound(i + 1, current_w, current_v)

    branch_and_bound(0, 0, 0)

    # 2. Chế độ KHÔNG cắt nhánh
    nodes_no_cut = 0
    max_v_no_cut = 0

    def backtrack_no_cut(i, current_w, current_v):
        nonlocal nodes_no_cut, max_v_no_cut
        nodes_no_cut += 1

        if current_v > max_v_no_cut:
            max_v_no_cut = current_v

        if i == n:
            return

        if current_w + w[i] <= W:
            backtrack_no_cut(i + 1, current_w + w[i], current_v + v[i])

        backtrack_no_cut(i + 1, current_w, current_v)

    backtrack_no_cut(0, 0, 0)

    selected_items = [names[i] for i in range(n) if best_x_cut[i] == 1]

    print(f"Thứ tự xét sau khi sắp xếp: {', '.join(names)}")
    print(f"Giá trị lớn nhất: {max_v_cut}")
    print(f"Tập đồ vật được chọn: {set(selected_items)}")
    print(f"Số nút CÓ cắt nhánh: {nodes_cut}")
    print(f"Số nút KHÔNG cắt nhánh: {nodes_no_cut}")
    print(f"Số lần giảm: {nodes_no_cut / nodes_cut:.2f}")

if __name__ == "__main__":
    knapsack_branch_and_bound()