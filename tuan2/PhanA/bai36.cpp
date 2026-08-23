// C++ (bai36.cpp)
#include <iostream>
#include <climits>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    if (!(cin >> n) || n < 0) return 0;

    long long f = 1;
    bool overflow = false;

    for (int i = 2; i <= n; ++i) {
        // Kiểm tra trước khi nhân để phát hiện tràn số
        if (f > LLONG_MAX / i) {
            overflow = true;
            break;
        }
        f *= i;
    }

    if (overflow) {
        cout << "TRAN SO\n";
    } else {
        cout << f << "\n";
    }

    return 0;
}