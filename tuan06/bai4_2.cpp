#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <iomanip>

using namespace std;

struct HoatDong {
    string ten;
    int s; // Thời gian bắt đầu
    int f; // Thời gian kết thúc
    int id;
};

// Kiểm tra hai hoạt động có tương thích không
bool khong_chong_lan(const HoatDong& a, const HoatDong& b) {
    return (a.f <= b.s) || (b.f <= a.s);
}

// 1. Tiêu chí: Kết thúc sớm nhất (EFT)
vector<HoatDong> tham_lam_ket_thuc_som(vector<HoatDong> ds) {
    sort(ds.begin(), ds.end(), [](const HoatDong& a, const HoatDong& b) {
        if (a.f != b.f) return a.f < b.f;
        return a.s < b.s;
    });
    vector<HoatDong> kq;
    int thoi_gian_cuoi = -1;
    for (const auto& hd : ds) {
        if (hd.s >= thoi_gian_cuoi) {
            kq.push_back(hd);
            thoi_gian_cuoi = hd.f;
        }
    }
    return kq;
}

// 2. Tiêu chí: Bắt đầu sớm nhất (EST)
vector<HoatDong> tham_lam_bat_dau_som(vector<HoatDong> ds) {
    sort(ds.begin(), ds.end(), [](const HoatDong& a, const HoatDong& b) {
        if (a.s != b.s) return a.s < b.s;
        return a.f < b.f;
    });
    vector<HoatDong> kq;
    int thoi_gian_cuoi = -1;
    for (const auto& hd : ds) {
        if (hd.s >= thoi_gian_cuoi) {
            kq.push_back(hd);
            thoi_gian_cuoi = hd.f;
        }
    }
    return kq;
}

// 3. Tiêu chí: Ngắn nhất (f - s nhỏ nhất)
vector<HoatDong> tham_lam_ngan_nhat(vector<HoatDong> ds) {
    vector<HoatDong> con_lai = ds;
    vector<HoatDong> kq;
    while (!con_lai.empty()) {
        auto best_it = min_element(con_lai.begin(), con_lai.end(), [](const HoatDong& a, const HoatDong& b) {
            int len_a = a.f - a.s;
            int len_b = b.f - b.s;
            if (len_a != len_b) return len_a < len_b;
            return a.id < b.id;
        });
        HoatDong chon = *best_it;
        kq.push_back(chon);
        vector<HoatDong> tiep_theo;
        for (const auto& hd : con_lai) {
            if (khong_chong_lan(chon, hd)) tiep_theo.push_back(hd);
        }
        con_lai = tiep_theo;
    }
    sort(kq.begin(), kq.end(), [](const HoatDong& a, const HoatDong& b) { return a.s < b.s; });
    return kq;
}

// 4. Tiêu chí: Ít chồng lấn nhất
vector<HoatDong> tham_lam_it_chong_lan(vector<HoatDong> ds) {
    vector<HoatDong> con_lai = ds;
    vector<HoatDong> kq;
    while (!con_lai.empty()) {
        auto dem_xung_dot = [&](const HoatDong& hd) {
            int cnt = 0;
            for (const auto& other : con_lai) {
                if (other.id != hd.id && !khong_chong_lan(hd, other)) cnt++;
            }
            return cnt;
        };

        auto best_it = min_element(con_lai.begin(), con_lai.end(), [&](const HoatDong& a, const HoatDong& b) {
            int c_a = dem_xung_dot(a);
            int c_b = dem_xung_dot(b);
            if (c_a != c_b) return c_a < c_b;
            return a.id < b.id;
        });

        HoatDong chon = *best_it;
        kq.push_back(chon);
        vector<HoatDong> tiep_theo;
        for (const auto& hd : con_lai) {
            if (khong_chong_lan(chon, hd)) tiep_theo.push_back(hd);
        }
        con_lai = tiep_theo;
    }
    sort(kq.begin(), kq.end(), [](const HoatDong& a, const HoatDong& b) { return a.s < b.s; });
    return kq;
}

// 5. Quy hoạch động: Số nhiều nhất thật sự
vector<HoatDong> toi_uu_quy_hoach_dong(vector<HoatDong> ds) {
    sort(ds.begin(), ds.end(), [](const HoatDong& a, const HoatDong& b) { return a.f < b.f; });
    int n = ds.size();
    vector<int> dp(n, 1);
    vector<int> vet(n, -1);

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < i; j++) {
            if (ds[j].f <= ds[i].s && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
                vet[i] = j;
            }
        }
    }

    int max_idx = 0;
    for (int i = 1; i < n; i++) {
        if (dp[i] > dp[max_idx]) max_idx = i;
    }

    vector<HoatDong> kq;
    int curr = max_idx;
    while (curr != -1) {
        kq.push_back(ds[curr]);
        curr = vet[curr];
    }
    reverse(kq.begin(), kq.end());
    return kq;
}

int main() {
    vector<HoatDong> ds = {
        {"H1", 1, 5, 1},  {"H2", 2, 5, 2},  {"H3", 2, 6, 3},  {"H4", 3, 4, 4},
        {"H5", 4, 8, 5},  {"H6", 6, 9, 6},  {"H7", 8, 11, 7}, {"H8", 9, 14, 8},
        {"H9", 11, 13, 9},{"H10", 12, 15, 10}
    };

    struct TestResult {
        string ten;
        vector<HoatDong> kq;
    };

    vector<TestResult> results = {
        {"Ket thuc som nhat", tham_lam_ket_thuc_som(ds)},
        {"Bat dau som nhat",  tham_lam_bat_dau_som(ds)},
        {"Ngan nhat",         tham_lam_ngan_nhat(ds)},
        {"It chong lan nhat", tham_lam_it_chong_lan(ds)},
        {"So nhieu nhat that su", toi_uu_quy_hoach_dong(ds)}
    };

    int toi_uu = results.back().kq.size();

    for (const auto& r : results) {
        cout << left << setw(25) << r.ten << ": [";
        for (size_t i = 0; i < r.kq.size(); i++) {
            cout << r.kq[i].ten << (i + 1 < r.kq.size() ? ", " : "");
        }
        cout << "] (" << r.kq.size() << " hoat dong)";
        if (r.ten == "So nhieu nhat that su") {
            cout << " | Toi uu: --\n";
        } else {
            cout << " | Toi uu: " << (r.kq.size() == (size_t)toi_uu ? "Co" : "Khong") << "\n";
        }
    }

    return 0;
}