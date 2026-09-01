#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// Ham kiem tra cap phan tu co tong bang S su dung hai con tro
bool two_pointers_target_sum(vector<int> a, int target, pair<int, int> &result) {
    // Buoc 1: Sap xep mang - O(n log n)
    sort(a.begin(), a.end());

    // Buoc 2: Duyet hai con tro - O(n)
    int left = 0;
    int right = a.size() - 1;

    while (left < right) {
        int current_sum = a[left] + a[right];
        if (current_sum == target) {
            result = {a[left], a[right]};
            return true;
        } else if (current_sum < target) {
            left++;
        } else {
            right--;
        }
    }
    return false;
}

int main() {
    vector<int> A = {8, 3, 5, 1, 9, 2};
    int S = 10; // Vi du tim cap co tong bang 10 (1 + 9 hoac 2 + 8)

    cout << "Mang dau vao: ";
    for (int x : A) cout << x << " ";
    cout << "\nTong can tim S = " << S << "\n";

    pair<int, int> result;
    if (two_pointers_target_sum(A, S, result)) {
        cout << "Ket qua: Tim thay cap (" << result.first << ", " << result.second << ") co tong bang " << S << "\n";
    } else {
        cout << "Ket qua: Khong tim thay cap nao thoa man\n";
    }

    return 0;
}