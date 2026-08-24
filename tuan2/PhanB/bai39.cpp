#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

long long cach2(const vector<int> &a) {
    int n = a.size();
    long long best = a[0];
    for (int i = 0; i < n; i++) {
        long long s = 0;
        for (int j = i; j < n; j++) {
            s += a[j];
            if (s > best) {
                best = s;
            }
        }
    }
    return best;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    if (cin >> n) {
        vector<int> a(n);
        for (int i = 0; i < n; i++) cin >> a[i];
        cout << cach2(a) << "\n";
    }
    return 0;
}