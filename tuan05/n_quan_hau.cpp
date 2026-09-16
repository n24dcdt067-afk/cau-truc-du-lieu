#include <iostream>
#include <vector>

using namespace std;

int n;
int so_nut = 0;
int so_loi_giai = 0;
vector<int> x;
vector<int> loi_giai_dau;
vector<bool> cot, cheo1, cheo2;

void dat_hau(int i) {
    so_nut++; // Moi lan goi de quy tinh la mot nut duoc duyet[cite: 1]

    if (i == n) {
        so_loi_giai++;
        if (so_loi_giai == 1) {
            loi_giai_dau = x;
        }
        return;
    }

    for (int j = 0; j < n; j++) {
        if (!cot[j] && !cheo1[i + j] && !cheo2[i - j + n]) {
            x[i] = j;
            cot[j] = cheo1[i + j] = cheo2[i - j + n] = true;

            dat_hau(i + 1);

            // Hoan tac trang thai[cite: 1]
            cot[j] = cheo1[i + j] = cheo2[i - j + n] = false;
        }
    }
}

int main() {
    cout << "Nhap n: ";
    if (!(cin >> n) || n <= 0) return 0;

    x.assign(n, 0);
    cot.assign(n, false);
    cheo1.assign(2 * n, false);
    cheo2.assign(2 * n, false);

    dat_hau(0);

    cout << "So nut da duyet: " << so_nut << "\n";
    cout << "So loi giai: " << so_loi_giai << "\n";
    cout << "Ban co cua loi giai dau tien:\n";

    if (so_loi_giai > 0) {
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                if (loi_giai_dau[r] == c) cout << "Q ";
                else cout << ". ";
            }
            cout << "\n";
        }
    } else {
        cout << "Khong co loi giai hop le.\n";
    }

    return 0;
}