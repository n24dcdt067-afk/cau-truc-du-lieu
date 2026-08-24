#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false); cin.tie(NULL);
    int n;
    if (cin >> n) {
        vector<long long> a(n);
        for (int i = 0; i < n; i++) cin >> a[i];
        long long best = a[0], max_prod = a[0], min_prod = a[0];
        for (int i = 1; i < n; i++) {
            if (a[i] < 0) swap(max_prod, min_prod);
            max_prod = max(a[i], max_prod * a[i]);
            min_prod = min(a[i], min_prod * a[i]);
            best = max(best, max_prod);
        }
        cout << best << "\n";
    }
    return 0;
}