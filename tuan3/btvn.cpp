#include <iostream>
#include <vector>
using namespace std;

void sap_xep_chen(vector<int> &a) {
    int n = a.size();
    for (int i = 1; i < n; i++) {
        int x = a[i];
        int j = i - 1;
        while (j >= 0 && a[j] > x) {
            a[j + 1] = a[j];
            j--;
        }
        a[j + 1] = x;
    }
}

int main() {
    vector<int> A = {8, 3, 5, 1, 9, 2};
    cout << "Mang ban dau: ";
    for (int x : A) cout << x << " ";
    cout << "\n";
    
    sap_xep_chen(A);
    
    cout << "Mang sau sap xep: ";
    for (int x : A) cout << x << " ";
    cout << "\n";
    return 0;
}
