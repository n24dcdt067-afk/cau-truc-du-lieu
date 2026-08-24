#include <iostream>
#include <vector>
#include <cmath>
#include <string>
#include <iomanip>

using namespace std;

struct Mau {
    int id;
    double x1, x2;
    string nhan;
};

// 9 mẫu huấn luyện từ Ví dụ 1.8 giáo trình
const vector<Mau> D = {
    {1, 1.4, 0.2, "Setosa"},
    {2, 1.3, 0.2, "Setosa"},
    {3, 1.5, 0.2, "Setosa"},
    {4, 4.7, 1.4, "Versicolor"},
    {5, 4.5, 1.5, "Versicolor"},
    {6, 4.9, 1.5, "Versicolor"},
    {7, 6.0, 2.5, "Virginica"},
    {8, 5.8, 2.2, "Virginica"},
    {9, 6.3, 1.8, "Virginica"}
};

double khoang_cach(double x1, double x2, double u1, double u2) {
    return sqrt((x1 - u1) * (x1 - u1) + (x2 - u2) * (x2 - u2));
}

int main() {
    ios_base::sync_with_stdio(false); cin.tie(NULL);
    double u1, u2;
    if (cin >> u1 >> u2) {
        double kc_min = 1e18;
        string du_doan = "";
        int id_gan_nhat = -1;

        for (const auto &m : D) {
            double d = khoang_cach(u1, u2, m.x1, m.x2);
            if (d < kc_min) {
                kc_min = d;
                du_doan = m.nhan;
                id_gan_nhat = m.id;
            }
        }

        cout << fixed << setprecision(4);
        cout << du_doan << " — lang gieng la mau " << id_gan_nhat << ", khoang cach " << kc_min << "\n";
    }
    return 0;
}