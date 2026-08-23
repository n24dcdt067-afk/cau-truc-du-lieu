#include <iostream>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    long long n;
    if (!(cin >> n) || n < 0) return 0;

    long long left = 0, right = min(n, 1000000000LL);
    bool found = false;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long sq = mid * mid;
        if (sq == n) { found = true; break; }
        if (sq < n) left = mid + 1;
        else right = mid - 1;
    }

    cout << (found ? "YES\n" : "NO\n");
    return 0;
}