#include <iostream>
using namespace std;

long long power_mod(long long a, long long b, long long m) {
    if (m == 1) return 0;
    long long res = 1 % m;
    a %= m;
    while (b > 0) {
        if (b & 1) res = (long long)((__int128)res * a % m);
        a = (long long)((__int128)a * a % m);
        b >>= 1;
    }
    return res;
}

int main() {
    ios_base::sync_with_stdio(false); cin.tie(NULL);
    long long a, b, m;
    if (cin >> a >> b >> m) {
        cout << power_mod(a, b, m) << "\n";
    }
    return 0;
}