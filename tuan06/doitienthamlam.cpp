#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// Hàm giải bằng phương pháp tham lam
pair<int, vector<int>> doi_tien_tham_lam(vector<int> menh_gia, int S) {
    sort(menh_gia.rbegin(), menh_gia.rend());
    vector<int> cach_tra;
    int tong = S;

    for (int c : menh_gia) {
        while (tong >= c) {
            cach_tra.push_back(c);
            tong -= c;
        }
    }
    return { (int)cach_tra.size(), cach_tra };
}

// Hàm giải bằng quy hoạch động (tối ưu số tờ)
pair<int, vector<int>> doi_tien_qhd(const vector<int>& menh_gia, int S) {
    const int INF = 1e9;
    vector<int> dp(S + 1, INF);
    vector<int> vet(S + 1, -1);
    dp[0] = 0;

    for (int i = 1; i <= S; i++) {
        for (int c : menh_gia) {
            if (i >= c && dp[i - c] + 1 < dp[i]) {
                dp[i] = dp[i - c] + 1;
                vet[i] = c;
            }
        }
    }

    vector<int> cach_tra;
    int curr = S;
    while (curr > 0) {
        int c = vet[curr];
        cach_tra.push_back(c);
        curr -= c;
    }
    return { dp[S], cach_tra };
}

void in_cach_tra(const vector<int>& a) {
    for (size_t i = 0; i < a.size(); i++) {
        cout << a[i] << (i + 1 < a.size() ? " + " : "");
    }
}

int main() {
    struct TestCase {
        vector<int> menh_gia;
        int S;
    };

    vector<TestCase> ds_bo = {
        { {1, 4, 6, 9}, 12 },
        { {1, 5, 10, 20, 50}, 85 },
        { {1, 3, 7, 12}, 20 },
        { {1, 2, 5, 10}, 38 },
        { {1, 6, 10}, 12 },
        { {1, 4, 5, 15, 20}, 23 }
    };

    for (size_t i = 0; i < ds_bo.size(); i++) {
        auto [so_to_tl, cach_tl] = doi_tien_tham_lam(ds_bo[i].menh_gia, ds_bo[i].S);
        auto [so_to_dp, cach_dp] = doi_tien_qhd(ds_bo[i].menh_gia, ds_bo[i].S);

        cout << "Bộ " << (i + 1) << ":\n";
        cout << "  Tham lam (" << so_to_tl << " tờ): ";
        in_cach_tra(cach_tl);
        cout << "\n";

        cout << "  Tối ưu   (" << so_to_dp << " tờ): ";
        in_cach_tra(cach_dp);
        cout << "\n";

        cout << "  Tham lam đúng? " << (so_to_tl == so_to_dp ? "Có" : "Không") << "\n\n";
    }

    return 0;
}