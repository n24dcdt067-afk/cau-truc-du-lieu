// C++ (bai38.cpp)
#include <iostream>
#include <vector>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    if (!(cin >> n) || n <= 0) return 0;

    vector<long long> a(n);
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
    }

    bool strict_inc = true; // Tăng nghiêm ngặt (a[i] < a[i+1])
    bool non_dec = true;    // Không giảm (a[i] <= a[i+1])

    for (int i = 0; i < n - 1; ++i) {
        if (a[i] >= a[i + 1]) strict_inc = false;
        if (a[i] > a[i + 1]) non_dec = false;
        if (!strict_inc && !non_dec) break; // Thoát sớm nếu cả hai đều sai
    }

    cout << (strict_inc ? "YES" : "NO") << " — " 
         << (non_dec ? "YES" : "NO") << "\n";

    return 0;
}