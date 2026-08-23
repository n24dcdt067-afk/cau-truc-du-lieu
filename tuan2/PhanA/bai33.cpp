#include <iostream>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    long long n;
    if (!(cin >> n) || n <= 0) return 0;

    int count = 0;
    long long sum = 0;

    while (n > 0) {
        sum += n % 10;
        count++;
        n = n / 10;
    }

    cout << count << " " << sum << "\n";
    return 0;
}