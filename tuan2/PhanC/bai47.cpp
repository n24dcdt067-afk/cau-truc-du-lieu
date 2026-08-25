#include <iostream>
#include <vector>
#include <fstream>
#include <cmath>
#include <string>
#include <iomanip>

using namespace std;

struct Mau {
    int id;
    vector<double> x;
    string nhan;
};

double khoang_cach(const vector<double> &u, const vector<double> &v) {
    double tong = 0.0;
    for (size_t k = 0; k < u.size(); k++) {
        double diff = u[k] - v[k];
        tong += diff * diff;
    }
    return sqrt(tong);
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    ifstream f("hoa30.txt");
    if (!f.is_open()) {
        cout << "Loi: Khong mo duoc hoa30.txt\n";
        return 1;
    }

    int n, d;
    f >> n >> d;
    vector<Mau> D(n);
    for (int i = 0; i < n; i++) {
        D[i].id = i + 1;
        D[i].x.resize(d);
        for (int j = 0; j < d; j++) {
            f >> D[i].x[j];
        }
        f >> D[i].nhan;
    }
    f.close();

    vector<double> u(d);
    while (cin >> u[0]) {
        for (int j = 1; j < d; j++) {
            cin >> u[j];
        }

        double kc_min = 1e18;
        string du_doan = "";
        int id_gan_nhat = -1;

        for (const auto &m : D) {
            double dist = khoang_cach(u, m.x);
            if (dist < kc_min) {
                kc_min = dist;
                du_doan = m.nhan;
                id_gan_nhat = m.id;
            }
        }

        cout << fixed << setprecision(4);
        cout << du_doan << " — mau " << id_gan_nhat << ", khoang cach " << kc_min << "\n";
    }

    return 0;
}