#include <iostream>
#include <vector>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false); cin.tie(NULL);
    int n;
    if (cin >> n) {
        vector<long long> a(n);
        for (int i = 0; i < n; i++) cin >> a[i];
        long long best = a[0], cur = a[0];
        int start_idx = 0, end_idx = 0, temp_start = 0;
        for (int i = 1; i < n; i++) {
            if (cur < 0) { cur = a[i]; temp_start = i; }
            else cur += a[i];
            if (cur > best) { best = cur; start_idx = temp_start; end_idx = i; }
        }
        cout << "tong " << best << ", doan [" << start_idx + 1 << ".." << end_idx + 1 << "]\n";
    }
    return 0;
}