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

void danh_gia_loocv(const vector<Mau> &D, const string &ten_do_do,
                    function<double(const vector<double>&, const vector<double>&)> kc_func) {
    int n = D.size();
    int dung = 0;
    vector<string> ds_sai;

    for (int i = 0; i < n; i++) {
        double kc_min = 1e18;
        string du_doan = "";

        for (int j = 0; j < n; j++) {
            if (i == j) continue; // Bỏ qua chính mẫu đang xét
            double dist = kc_func(D[i].x, D[j].x);
            if (dist < kc_min) {
                kc_min = dist;
                du_doan = D[j].nhan;
            }
        }

        if (du_doan == D[i].nhan) {
            dung++;
        } else {
            ds_sai.push_back("Mau " + to_string(D[i].id) + " (that: " + D[i].nhan + ", du doan: " + du_doan + ")");
        }
    }

    double ti_le = (double)dung / n * 100.0;
    cout << fixed << setprecision(2);
    cout << ten_do_do << ": " << dung << "/" << n << " = " << ti_le << "%\n";
    if (ds_sai.empty()) {
        cout << "  -> Khong co mau nao bi sai.\n";
    } else {
        cout << "  -> Cac mau bi sai:\n";
        for (const auto &s : ds_sai) {
            cout << "     " << s << "\n";
        }
    }
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

    cout << "=== KET QUA DANH GIA LOOCV TREN HOA30.TXT ===\n";
    danh_gia_loocv(D, "Euclid", kc_euclid);
    danh_gia_loocv(D, "Manhattan", kc_manhattan);

    return 0;
}