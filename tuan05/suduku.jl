# Đề Sudoku mục E (chỉ số đánh từ 1..9, số 0 đại diện cho ô trống)
const GRID_INIT = [
    0 0 0  0 0 6  0 0 0;
    0 8 1  0 5 0  4 0 0;
    0 0 9  0 0 7  0 5 8;
    0 0 0  0 9 0  0 0 0;
    0 0 6  0 0 1  0 0 7;
    7 4 0  0 0 0  2 0 1;
    0 0 0  1 3 0  0 0 4;
    0 0 0  0 2 9  0 0 0;
    9 0 0  0 0 8  0 6 0
]

function get_candidates(board, r, c)
    used = falses(9)
    for i in 1:9
        if board[r, i] != 0
            used[board[r, i]] = true
        end
        if board[i, c] != 0
            used[board[i, c]] = true
        end
    end
    br = 3 * div(r - 1, 3) + 1
    bc = 3 * div(c - 1, 3) + 1
    for i in br:(br + 2)
        for j in bc:(bc + 2)
            if board[i, j] != 0
                used[board[i, j]] = true
            end
        end
    end
    return [d for d in 1:9 if !used[d]]
end

# 1. BẢN THỨ NHẤT: QUÉT TUẦN TỰ
global calls_seq = 0

function find_first_empty(board)
    for r in 1:9
        for c in 1:9
            if board[r, c] == 0
                return (r, c)
            end
        end
    end
    return nothing
end

function solve_sequential(board)
    global calls_seq += 1

    empty_pos = find_first_empty(board)
    if empty_pos === nothing
        return true
    end

    r, c = empty_pos
    cands = get_candidates(board, r, c)

    for val in cands
        board[r, c] = val
        if solve_sequential(board)
            return true
        end
        board[r, c] = 0
    end

    return false
end

# 2. BẢN THỨ HAI: DÙNG HEURISTIC MRV
global calls_mrv = 0

function find_mrv_empty(board)
    best_pos = nothing
    min_cands = 10
    best_cands = Int[]

    for r in 1:9
        for c in 1:9
            if board[r, c] == 0
                cands = get_candidates(board, r, c)
                count = length(cands)
                if count < min_cands
                    min_cands = count
                    best_pos = (r, c)
                    best_cands = cands
                    if count <= 1
                        return (best_pos, best_cands)
                    end
                end
            end
        end
    end
    return (best_pos, best_cands)
end

function solve_mrv(board)
    global calls_mrv += 1

    empty_pos, cands = find_mrv_empty(board)
    if empty_pos === nothing
        return true
    end

    r, c = empty_pos
    for val in cands
        board[r, c] = val
        if solve_mrv(board)
            return true
        end
        board[r, c] = 0
    end

    return false
end

function main()
    empty_count = count(==(0), GRID_INIT)
    println("So o trong ban dau: ", empty_count)

    # Chạy bản Quét tuần tự
    b1 = copy(GRID_INIT)
    global calls_seq = 0
    t0 = time()
    solve_sequential(b1)
    t_seq = time() - t0

    # Chạy bản MRV
    b2 = copy(GRID_INIT)
    global calls_mrv = 0
    t0 = time()
    solve_mrv(b2)
    t_mrv = time() - t0

    same = (b1 == b2)

    println("Ban quet tuan tu: ", calls_seq, " loi goi ham, ", round(t_seq, digits=5), "s")
    println("Ban MRV: ", calls_mrv, " loi goi ham, ", round(t_mrv, digits=5), "s")
    println("Loi giai tim duoc co giong nhau khong: ", same ? "CO" : "KHONG")

    println("\nBan co hoan chinh:")
    for r in 1:9
        println(join(b1[r, :], " "))
    end
end

main()