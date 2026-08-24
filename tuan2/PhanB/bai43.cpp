#include <iostream>
using namespace std;

long long fib_lap(int n) {
    if (n <= 2) return 1;
    long long a = 1, b = 1;
    for (int i = 3; i <= n; i++) {
        long long c = a + b;
        a = b;
        b = c;
    }
    return b;
}

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    if (cin >> n) {
        if (n > 92) {
            cout << "tran long long\n";
        } else {
            cout << "F = " << fib_lap(n) << "\n";
        }
    }
    return 0;
}