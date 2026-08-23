#include <iostream>
#include <iomanip>
#include <algorithm>

using namespace std;

int main() {
    // Tối ưu hóa luồng I/O chuẩn
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    if (!(cin >> n) || n <= 0) return 0;

    long long first_val;
    cin >> first_val;

    // Dùng long long (64-bit) để tránh tràn số khi n = 10^6, a_i = 10^9
    long long sum = first_val;
    long long min_val = first_val;
    long long max_val = first_val;

    for (int i = 1; i < n; ++i) {
        long long x;
        cin >> x;
        sum += x;
        if (x < min_val) min_val = x;
        if (x > max_val) max_val = x;
    }

    double avg = (double)sum / n;

    // Định dạng số thực 4 chữ số thập phân bằng thư viện <iomanip>
    cout << sum << " " 
         << fixed << setprecision(4) << avg << " " 
         << min_val << " " 
         << max_val << "\n";

    return 0;
}