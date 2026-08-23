// C++ (bai37.cpp)
#include <iostream>

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int n;
    if (!(cin >> n) || n <= 0) return 0;

    int so_chan = 0, so_le = 0, so_am = 0;

    for (int i = 0; i < n; ++i) {
        long long x;
        cin >> x;

        // Dùng x % 2 == 0 để nhận cả số chẵn âm và 0
        if (x % 2 == 0) {
            so_chan++;
        } else {
            so_le++;
        }

        if (x < 0) {
            so_am++;
        }
    }

    cout << "chan " << so_chan << ", le " << so_le << ", am " << so_am << "\n";
    return 0;
}