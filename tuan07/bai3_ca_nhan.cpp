#include <iostream>
#include <sstream>
#include <string>
#include <vector>

int thu(int i, int n, std::vector<int>& x, std::vector<bool>& da_dung) {
    if (i == n) {
        int p = 3; // Thay 2 bang p trong R0 (Ca s = 6)
        if (x[0] != p) return 0;
        for (int j = 0; j < n; ++j) {
            if (j > 0) std::cout << " ";
            std::cout << x[j];
        }
        std::cout << "\n";
        return 1;
    }

    int dem = 0;
    for (int v = 1; v <= n; ++v) {
        if (!da_dung[v]) {
            x[i] = v;
            da_dung[v] = true;
            dem += thu(i + 1, n, x, da_dung);
            da_dung[v] = false; // Hoan tac
        }
    }
    return dem;
}

int main() {
    std::cout << "MSSV: N24DCDT067 | Ma ca: 6\n";
    std::cout << "Nhap n (1..8):\n";
    std::string dong;
    std::getline(std::cin, dong);
    std::istringstream bo_doc(dong);
    int n;
    char du;
    if (!(bo_doc >> n) || (bo_doc >> du) || n < 1 || n > 8) {
        std::cout << "Du lieu khong hop le.\n";
        return 0;
    }

    std::vector<int> x(n, 0);
    std::vector<bool> da_dung(n + 1, false);
    int dem = thu(0, n, x, da_dung);
    std::cout << "So hoan vi dat: " << dem << "\n";
    return 0;
}