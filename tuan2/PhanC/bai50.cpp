#include <iostream>
#include <vector>
#include <chrono>
#include <random>
#include <cmath>
#include <iomanip>

using namespace std;
using namespace std::chrono;

double khoang_cach_sq(const vector<double> &u, const vector<double> &v, int d) {
    double s = 0.0;
    for (int k = 0; k < d; k++) {
        double diff = u[k] - v[k];
        s += diff * diff;
    }
    return s;
}

double do_thoi_gian(int n, int d, int q, mt19937 &rng) {
    uniform_real_distribution<double> dist(0.0, 1.0);
    vector<vector<double>> D(n, vector<double>(d));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < d; j++) D[i][j] = dist(rng);
    }

    vector<vector<double>> Q(q, vector<double>(d));
    for (int i = 0; i < q; i++) {
        for (int j = 0; j < d; j++) Q[i][j] = dist(rng);
    }

    auto t0 = steady_clock::now();
    for (int i = 0; i < q; i++) {
        double min_d = 1e18;
        int best_id = -1;
        for (int j = 0; j < n; j++) {
            double cur_d = khoang_cach_sq(Q[i], D[j], d);
            if (cur_d < min_d) {
                min_d = cur_d;
                best_id = j;
            }
        }
    }
    auto t1 = steady_clock::now();
    return duration<double>(t1 - t0).count();
}

int main() {
    int d = 20;
    int q = 1000;
    vector<int> N_list = {1000, 10000, 100000};
    mt19937 rng(42);

    cout << fixed << setprecision(4);
    cout << "Ket qua do C++ (-O2):\n";
    cout << "n\tThoi gian (s)\tTi le T(10n)/T(n)\n";
    
    double prev_t = 0.0;
    for (size_t i = 0; i < N_list.size(); i++) {
        int n = N_list[i];
        double t = do_thoi_gian(n, d, q, rng);
        cout << n << "\t" << t << " s\t";
        if (i > 0) cout << setprecision(2) << t / prev_t;
        else cout << "-";
        cout << "\n";
        cout << fixed << setprecision(4);
        prev_t = t;
    }
    return 0;
}