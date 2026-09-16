#include <iostream>
#include <vector>
#include <chrono>

using namespace std;

// Đề Sudoku mục E (0 đại diện cho ô trống)
const vector<vector<int>> GRID_INIT = {
    {0, 0, 0,  0, 0, 6,  0, 0, 0},
    {0, 8, 1,  0, 5, 0,  4, 0, 0},
    {0, 0, 9,  0, 0, 7,  0, 5, 8},
    {0, 0, 0,  0, 9, 0,  0, 0, 0},
    {0, 0, 6,  0, 0, 1,  0, 0, 7},
    {7, 4, 0,  0, 0, 0,  2, 0, 1},
    {0, 0, 0,  1, 3, 0,  0, 0, 4},
    {0, 0, 0,  0, 2, 9,  0, 0, 0},
    {9, 0, 0,  0, 0, 8,  0, 6, 0}
};

vector<int> get_candidates(const vector<vector<int>>& board, int r, int c) {
    vector<bool> used(10, false);
    for (int i = 0; i < 9; i++) {
        if (board[r][i] != 0) used[board[r][i]] = true;
        if (board[i][c] != 0) used[board[i][c]] = true;
    }
    int br = 3 * (r / 3), bc = 3 * (c / 3);
    for (int i = br; i < br + 3; i++) {
        for (int j = bc; j < bc + 3; j++) {
            if (board[i][j] != 0) used[board[i][j]] = true;
        }
    }
    vector<int> cands;
    for (int d = 1; d <= 9; d++) {
        if (!used[d]) cands.push_back(d);
    }
    return cands;
}

// -------------------------------------------------------------
// 1. BẢN THỨ NHẤT: QUÉT TUẦN TỰ
// -------------------------------------------------------------
long long calls_seq = 0;

bool find_first_empty(const vector<vector<int>>& board, int& r, int& c) {
    for (r = 0; r < 9; r++) {
        for (c = 0; c < 9; c++) {
            if (board[r][c] == 0) return true;
        }
    }
    return false;
}

bool solve_sequential(vector<vector<int>>& board) {
    calls_seq++;

    int r, c;
    if (!find_first_empty(board, r, c)) return true;

    vector<int> cands = get_candidates(board, r, c);
    for (int val : cands) {
        board[r][c] = val;
        if (solve_sequential(board)) return true;
        board[r][c] = 0;
    }
    return false;
}

// -------------------------------------------------------------
// 2. BẢN THỨ HAI: DÙNG HEURISTIC MRV
// -------------------------------------------------------------
long long calls_mrv = 0;

bool find_mrv_empty(const vector<vector<int>>& board, int& best_r, int& best_c, vector<int>& best_cands) {
    int min_cands = 10;
    bool found = false;

    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if (board[r][c] == 0) {
                found = true;
                vector<int> cands = get_candidates(board, r, c);
                int count = cands.size();
                if (count < min_cands) {
                    min_cands = count;
                    best_r = r;
                    best_c = c;
                    best_cands = cands;
                    if (count <= 1) return true;
                }
            }
        }
    }
    return found;
}

bool solve_mrv(vector<vector<int>>& board) {
    calls_mrv++;

    int r, c;
    vector<int> cands;
    if (!find_mrv_empty(board, r, c, cands)) return true;

    for (int val : cands) {
        board[r][c] = val;
        if (solve_mrv(board)) return true;
        board[r][c] = 0;
    }
    return false;
}

int main() {
    int empty_count = 0;
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if (GRID_INIT[r][c] == 0) empty_count++;
        }
    }
    cout << "So o trong ban dau: " << empty_count << "\n";

    // Chay ban Quet tuan tu
    vector<vector<int>> b1 = GRID_INIT;
    auto t0 = chrono::high_resolution_clock::now();
    solve_sequential(b1);
    auto t1 = chrono::high_resolution_clock::now();
    double t_seq = chrono::duration<double>(t1 - t0).count();

    // Chay ban MRV
    vector<vector<int>> b2 = GRID_INIT;
    t0 = chrono::high_resolution_clock::now();
    solve_mrv(b2);
    t1 = chrono::high_resolution_clock::now();
    double t_mrv = chrono::duration<double>(t1 - t0).count();

    bool same = (b1 == b2);

    cout << "Ban quet tuan tu: " << calls_seq << " loi goi ham, " << t_seq << "s\n";
    cout << "Ban MRV: " << calls_mrv << " loi goi ham, " << t_mrv << "s\n";
    cout << "Loi giai tim duoc co giong nhau khong: " << (same ? "CO" : "KHONG") << "\n";

    cout << "\nBan co hoan chinh:\n";
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            cout << b1[r][c] << " ";
        }
        cout << "\n";
    }

    return 0;
}