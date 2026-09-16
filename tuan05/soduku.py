import time

# Đề Sudoku mục E (0 đại diện cho ô trống)
GRID = [
    [0, 0, 0,  0, 0, 6,  0, 0, 0],
    [0, 8, 1,  0, 5, 0,  4, 0, 0],
    [0, 0, 9,  0, 0, 7,  0, 5, 8],
    [0, 0, 0,  0, 9, 0,  0, 0, 0],
    [0, 0, 6,  0, 0, 1,  0, 0, 7],
    [7, 4, 0,  0, 0, 0,  2, 0, 1],
    [0, 0, 0,  1, 3, 0,  0, 0, 4],
    [0, 0, 0,  0, 2, 9,  0, 0, 0],
    [9, 0, 0,  0, 0, 8,  0, 6, 0]
]

def get_candidates(board, r, c):
    """Lấy tập các số hợp lệ có thể điền vào ô (r, c)."""
    used = set(board[r])
    for i in range(9):
        used.add(board[i][c])
    br, bc = 3 * (r // 3), 3 * (c // 3)
    for i in range(br, br + 3):
        for j in range(bc, bc + 3):
            used.add(board[i][j])
    return [d for d in range(1, 10) if d not in used]

# -------------------------------------------------------------
# 1. BẢN 1: QUÉT TUẦN TỰ (Từ trái sang phải, từ trên xuống dưới)
# -------------------------------------------------------------
calls_seq = 0

def find_first_empty(board):
    for r in range(9):
        for c in range(9):
            if board[r][c] == 0:
                return r, c
    return None

def solve_sequential(board):
    global calls_seq
    calls_seq += 1

    empty = find_first_empty(board)
    if empty is None:
        return True

    r, c = empty
    candidates = get_candidates(board, r, c)

    for val in candidates:
        board[r][c] = val
        if solve_sequential(board):
            return True
        board[r][c] = 0

    return False

# -------------------------------------------------------------
# 2. BẢN 2: DÙNG HEURISTIC MRV (Ô có ít ứng viên nhất)
# -------------------------------------------------------------
calls_mrv = 0

def find_mrv_empty(board):
    best_cell = None
    min_cand_count = 10
    best_candidates = []

    for r in range(9):
        for c in range(9):
            if board[r][c] == 0:
                cands = get_candidates(board, r, c)
                count = len(cands)
                if count < min_cand_count:
                    min_cand_count = count
                    best_cell = (r, c)
                    best_candidates = cands
                    if count <= 1:
                        return best_cell, best_candidates
    return best_cell, best_candidates

def solve_mrv(board):
    global calls_mrv
    calls_mrv += 1

    cell, candidates = find_mrv_empty(board)
    if cell is None:
        return True

    r, c = cell
    for val in candidates:
        board[r][c] = val
        if solve_mrv(board):
            return True
        board[r][c] = 0

    return False

# -------------------------------------------------------------
# CHẠY ĐỐI SOÁNH
# -------------------------------------------------------------
if __name__ == "__main__":
    # Đếm số ô trống kiểm tra trước khi chạy
    empty_count = sum(row.count(0) for row in GRID)
    print(f"Số ô trống ban đầu: {empty_count}")

    # Chạy Quét tuần tự
    b1 = [row[:] for row in GRID]
    t0 = time.perf_counter()
    solve_sequential(b1)
    t_seq = time.perf_counter() - t0

    # Chạy MRV
    b2 = [row[:] for row in GRID]
    t0 = time.perf_counter()
    solve_mrv(b2)
    t_mrv = time.perf_counter() - t0

    same_solution = (b1 == b2)

    print(f"--- KẾT QUẢ SO SÁNH ---")
    print(f"Quét tuần tự : {calls_seq} lời gọi hàm, {t_seq:.5f}s")
    print(f"MRV          : {calls_mrv} lời gọi hàm, {t_mrv:.5f}s")
    print(f"Hai lời giải giống nhau: {same_solution}")
    print("\nLời giải hoàn chỉnh:")
    for row in b1:
        print(" ".join(map(str, row)))