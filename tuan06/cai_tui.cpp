#include <iostream>
#include <vector>
#include <string>
#include <iomanip>
#include <algorithm>

using namespace std;

int main() {
    int n = 5;
    int W = 11;
    vector<string> ten = {"A", "B", "C", "D", "E"};
    vector<int> w = {2, 3, 4, 5, 7};
    vector<int> v = {3, 7, 9, 12, 16};

    vector<vector<int>> f(n + 1, vector<int>(W + 1, 0));

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= W; j++) {
            f[i][j] = f[i - 1][j];
            if (w[i - 1] <= j) {
                f[i][j] = max(f[i][j], f[i - 1][j - w[i - 1]] + v[i - 1]);
            }
        }
    }

    cout << "Bang f (kich thuoc 6 x 12):\n";
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= W; j++) {
            cout << setw(4) << f[i][j];
        }
        cout << "\n";
    }

    vector<string> chon;
    int j = W;
    for (int i = n; i >= 1; i--) {
        if (f[i][j] != f[i - 1][j]) {
            chon.push_back(ten[i - 1]);
            j -= w[i - 1];
        }
    }
    reverse(chon.begin(), chon.end());

    cout << "Gia tri lon nhat f[5][11]: " << f[n][W] << "\n";
    cout << "Tap do vat duoc chon: ";
    for (int i = 0; i < (int)chon.size(); i++) {
        cout << chon[i] << (i + 1 < (int)chon.size() ? ", " : "\n");
    }

    return 0;
}