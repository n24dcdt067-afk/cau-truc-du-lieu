#include <iostream>
#include <vector>
#include <fstream>
#include <cmath>
#include <string>
#include <iomanip>
#include <functional>

using namespace std;

struct Mau {
    int id;
    vector<double> x;
    string nhan;
};

double kc_euclid(const vector<double> &u, const vector<double> &v) {
    double tong = 0.0;
    for (size_t k = 0; k < u.size(); k++) {
        double diff = u[k] - v[k];
        tong += diff * diff;
    }
    return sqrt(tong);
}

double kc_manhattan(const vector<double> &u, const vector<double> &v) {
    double tong = 0.0;
    for (size_t k = 0; k < u.size(); k++) {
        tong += abs(u[k] - v[k]);
    }
    return tong;
}

pair<string, int> phan_loai(const vector<double> &u, const vector<Mau> &D, 
                            function<double(const vector<double>&, const vector<double>&)> kc_func, 
                            int skip_id = -1) {
    double kc_min = 1e18;
    string du_doan = "";
    int id_gan_nhat = -1;

    for (const auto &m : D) {
        if (m.id == skip_id) continue;
        double dist = kc_func(u, m.x);
        if (dist < kc_min) {
            kc_min = dist;
            du_doan = m.nhan;
            id_gan_nhat = m.id;
        }
    }
    return {du_doan, id_gan_nhat};
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    ifstream f("hoa30.txt");
    if (!f.is_open()) {
        cerr << "Khong the mo tep hoa30.txt\n";
        return 1;
    }

    int n, d;
    f >> n >> d;
    vector<Mau> D(n);
    for (int i = 0; i < n; i++) {
        D[i].id = i + 1;
        D[i].x.resize(d);
        for (int j = 0; j < d; j++) f >> D[i].x[j];
        f >> D[i].nhan;
    }
    f.close();

    // 1. Phân loại mẫu mới (6.5, 3.0, 5.5, 2.0)
    vector<double> u = {6.5, 3.0, 5.5, 2.0};
    auto res_e = phan_loai(u, D, kc_euclid);
    auto res_m = phan_loai(u, D, kc_manhattan);
    cout << "Mau (6.5, 3.0, 5.5, 2.0):\n";
    cout << "Euclid   : " << res_e.first << " (mau " << res_e.second << ")\n";
    cout << "Manhattan: " << res_m.first << " (mau " << res_m.second << ")\n\n";

    // 2. Danh gia bo mot mau
    int dung_e = 0, dung_m = 0;
    for (const auto &m : D) {
        auto pe = phan_loai(m.x, D, kc_euclid, m.id);
        if (pe.first == m.nhan) dung_e++;

        auto pm = phan_loai(m.x, D, kc_manhattan, m.id);
        if (pm.first == m.nhan) dung_m++;
        else cout << "Manhattan du doan sai mau " << m.id << " (" << m.nhan << " -> " << pm.first << ", gan mau " << pm.second << ")\n";
    }

    cout << fixed << setprecision(2);
    cout << "Do chinh xac Euclid   : " << dung_e << "/" << n << " = " << (double)dung_e / n * 100 << "%\n";
    cout << "Do chinh xac Manhattan: " << dung_m << "/" << n << " = " << (double)dung_m / n * 100 << "%\n";

    return 0;
}