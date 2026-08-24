#include <iostream>
#include <vector>
#include <chrono>
#include <random>
#include <algorithm>
#include <iomanip>

using namespace std;
using namespace std::chrono;

void selection_sort(vector<int> &a) {
    int n = a.size();
    for (int i = 0; i < n - 1; i++) {
        int min_idx = i;
        for (int j = i + 1; j < n; j++) {
            if (a[j] < a[min_idx]) min_idx = j;
        }
        swap(a[i], a[min_idx]);
    }
}

int main() {
    vector<int> sizes = {500, 1000, 2000, 4000};
    vector<double> times;
    mt19937 rng(42);

    // Chạy khởi động (warm-up)
    vector<int> warm(100);
    selection_sort(warm);

    for (int n : sizes) {
        double min_t = 1e9;
        for (int r = 0; r < 3; r++) {
            vector<int> a(n);
            for (int i = 0; i < n; i++) a[i] = rng() % 100000;
            auto t0 = steady_clock::now();
            selection_sort(a);
            auto t1 = steady_clock::now();
            double dur = duration<double>(t1 - t0).count();
            min_t = min(min_t, dur);
        }
        times.push_back(min_t);
    }

    cout << fixed << setprecision(6);
    cout << "n\tThoi gian (s)\tTi le T(2n)/T(n)\n";
    for (size_t i = 0; i < sizes.size(); i++) {
        cout << sizes[i] << "\t" << times[i] << "\t";
        if (i > 0) cout << setprecision(2) << times[i] / times[i - 1];
        else cout << "-";
        cout << "\n";
    }
    return 0;
}