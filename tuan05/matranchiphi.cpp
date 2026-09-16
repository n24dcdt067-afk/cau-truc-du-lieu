#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

const int INF = 1e9;

int n = 5;
vector<vector<int>> c = {
    {0, 10, 9, 22, 23},
    {10, 0, 16, 19, 14},
    {9, 16, 0, 7, 28},
    {22, 19, 7, 0, 8},
    {23, 14, 28, 8, 0}
};

int c_min = INF;

// 1. Che do CO cat nhanh
int nodes_cut = 0;
int min_cost_cut = INF;
vector<int> tour_cut;
vector<int> best_tour_cut;
vector<bool> visited_cut;

void branch_and_bound(int i, int current_cost) {
    nodes_cut++;

    for (int v = 0; v < n; v++) {
        if (!visited_cut[v]) {
            int cost = current_cost + c[tour_cut[i - 1]][v];
            int lower_bound = cost + (n - i) * c_min;

            if (lower_bound < min_cost_cut) {
                tour_cut[i] = v;
                visited_cut[v] = true;

                if (i == n - 1) {
                    nodes_cut++;
                    int total_cost = cost + c[v][tour_cut[0]];
                    if (total_cost < min_cost_cut) {
                        min_cost_cut = total_cost;
                        tour_cut[n] = tour_cut[0];
                        best_tour_cut = tour_cut;
                    }
                } else {
                    branch_and_bound(i + 1, cost);
                }

                visited_cut[v] = false;
            }
        }
    }
}

// 2. Che do KHONG cat nhanh
int nodes_no_cut = 0;
int min_cost_no_cut = INF;
vector<int> tour_nc;
vector<bool> visited_nc;

void backtrack_no_cut(int i, int current_cost) {
    nodes_no_cut++;

    for (int v = 0; v < n; v++) {
        if (!visited_nc[v]) {
            int cost = current_cost + c[tour_nc[i - 1]][v];
            tour_nc[i] = v;
            visited_nc[v] = true;

            if (i == n - 1) {
                nodes_no_cut++;
                int total_cost = cost + c[v][tour_nc[0]];
                if (total_cost < min_cost_no_cut) {
                    min_cost_no_cut = total_cost;
                }
            } else {
                backtrack_no_cut(i + 1, cost);
            }

            visited_nc[v] = false;
        }
    }
}

int main() {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j && c[i][j] < c_min) {
                c_min = c[i][j];
            }
        }
    }

    tour_cut.assign(n + 1, 0);
    visited_cut.assign(n, false);
    visited_cut[0] = true;

    branch_and_bound(1, 0);

    tour_nc.assign(n + 1, 0);
    visited_nc.assign(n, false);
    visited_nc[0] = true;

    backtrack_no_cut(1, 0);

    cout << "Canh re nhat toan ma tran c_min: " << c_min << "\n";
    cout << "Chi phi hanh trinh toi uu: " << min_cost_cut << "\n";
    cout << "Hanh trinh toi uu: ";
    for (int i = 0; i <= n; i++) {
        cout << best_tour_cut[i] << (i == n ? "" : " -> ");
    }
    cout << "\n";
    cout << "So nut khi CO cat nhanh: " << nodes_cut << "\n";
    cout << "So nut khi KHONG cat nhanh: " << nodes_no_cut << "\n";

    return 0;
}