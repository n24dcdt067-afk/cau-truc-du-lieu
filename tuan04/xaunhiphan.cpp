#include <iostream>
#include <vector>
#include <string>

bool xau_ke_tiep(std::vector<int>& x) {
    int i = static_cast<int>(x.size()) - 1;
    // Quét từ phải sang, xóa các số 1 về 0
    while (i >= 0 && x[i] == 1) {
        x[i] = 0;
        --i;
    }
    // Hết: mọi chữ số đều là 1
    if (i < 0) {
        return false;
    }
    // Đổi chữ số 0 đầu tiên thành 1
    x[i] = 1;
    return true;
}

std::vector<std::string> liet_ke_xau(int n) {
    std::vector<int> x(n, 0);
    std::vector<std::string> ds;

    auto to_str = [](const std::vector<int>& v) {
        std::string s = "";
        for (int bit : v) s += std::to_string(bit);
        return s;
    };

    ds.push_back(to_str(x));
    while (xau_ke_tiep(x)) {
        ds.push_back(to_str(x));
    }
    return ds;
}

int main() {
    int n = 3;
    std::vector<std::string> ket_qua = liet_ke_xau(n);
    for (const auto& s : ket_qua) {
        std::cout << s << " ";
    }
    return 0;
}