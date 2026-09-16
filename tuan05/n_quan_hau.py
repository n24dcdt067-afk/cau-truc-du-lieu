def solve_n_queens(n):
    visited_nodes = 0
    solutions_count = 0
    first_solution = None

    # board[i] lưu chỉ số cột của quân hậu ở hàng i
    board = [-1] * n

    # Các mảng/tập hợp đánh dấu để kiểm tra điều kiện an toàn O(1)
    cols = [False] * n
    diag1 = [False] * (2 * n - 1)  # Đường chéo chính: row - col + (n - 1)
    diag2 = [False] * (2 * n - 1)  # Đường chéo phụ: row + col

    def backtrack(row):
        nonlocal visited_nodes, solutions_count, first_solution
        # Quy ước: Mỗi lần gọi đệ quy tính là một nút được duyệt
        visited_nodes += 1

        if row == n:
            solutions_count += 1
            if first_solution is None:
                first_solution = list(board)
            return

        for col in range(n):
            d1 = row - col + (n - 1)
            d2 = row + col

            if not cols[col] and not diag1[d1] and not diag2[d2]:
                # Đặt quân hậu
                board[row] = col
                cols[col] = diag1[d1] = diag2[d2] = True

                backtrack(row + 1)

                # Quay lui
                cols[col] = diag1[d1] = diag2[d2] = False
                board[row] = -1

    backtrack(0)

    # In kết quả
    print(f"Số nút đã duyệt: {visited_nodes}")
    print(f"Số lời giải: {solutions_count}")
    print("Bàn cờ của lời giải đầu tiên:")
    if first_solution:
        for r in range(n):
            c = first_solution[r]
            row_str = ["."] * n
            row_str[c] = "Q"
            print(" ".join(row_str))
    else:
        print("Không có lời giải phù hợp.")

if __name__ == "__main__":
    n = int(input("Nhập n: "))
    solve_n_queens(n)