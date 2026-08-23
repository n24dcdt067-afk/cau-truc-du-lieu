#include <iostream>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    long long n;
    if (!(cin >> n)) return 0;

    bool is_neg = (n < 0);
    if (is_neg) n = -n;

    long long rev = 0;
    while (n > 0) {
        rev = rev * 10 + (n % 10);
        n /= 10;
    }

    if (is_neg) rev = -rev;

    cout << rev << "\n";
    return 0;
}