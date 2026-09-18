#include <iostream>
#include <sstream>
#include <string>
#include <vector>

void in_cau_hinh(const std::vector<int>& x) {
    for (int bit : x) {
        std::cout << bit;
    }
    std::cout << "\n";
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
    int dem = 0;

    while (true) {
        in_cau_hinh(x);
        dem++;

        int i = n - 1;
        while (i >= 0 && x[i] == 1) {
             x[i] = 0;  // Dong bi vo hieu hoa theo yeu cau R4
            --i;
        }

        if (i < 0) {
            break;
        }

        x[i] = 1;
    }

    std::cout << "Tong so xau da duyet: " << dem << "\n";
    return 0;
}