// C++ (bai35.cpp)
#include <iostream>
#include <vector>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    if (!(cin >> n) || n < 2) return 0;

    vector<bool> is_prime(n + 1, true);
    is_prime[0] = is_prime[1] = false;

    for (int p = 2; p * p <= n; ++p) {
        if (is_prime[p]) {
            for (int i = p * p; i <= n; i += p) {
                is_prime[i] = false;
            }
        }
    }

    if (n <= 30) {
        for (int i = 2; i <= n; ++i) {
            if (is_prime[i]) cout << i << " ";
        }
        cout << "\n";
    } else {
        int count = 0;
        long long sum = 0;
        for (int i = 2; i <= n; ++i) {
            if (is_prime[i]) {
                count++;
                sum += i;
            }
        }
        cout << "so luong = " << count << ", tong = " << sum << "\n";
    }

    return 0;
}