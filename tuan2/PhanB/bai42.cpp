#include <iostream>
#include <vector>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false); cin.tie(NULL);
    int n, k;
    if (cin >> n >> k) {
        if (k > n || k <= 0) return 0;
        vector<long long> a(n);
        for (int i = 0; i < n; i++) cin >> a[i];
        long long s = 0;
        for (int i = 0; i < k; i++) s += a[i];
        long long max_sum = s;
        int best_start = 0;
        for (int i = k; i < n; i++) {
            s += a[i] - a[i - k];
            if (s > max_sum) {
                max_sum = s;
                best_start = i - k + 1;
            }
        }
        cout << "tong " << max_sum << ", bat dau tai vi tri " << best_start + 1 << "\n";
    }
    return 0;
}