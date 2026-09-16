#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <numeric>

using namespace std;

struct Item {
    char name;
    int w;
    int v;
};

int n = 6;
int W = 14;
vector<Item> items;

double tinh_can(int i, int current_w, int current_v) {
    if (current_w >= W) return 0.0;
    double b = current_v;
    int remain_w = W - current_w;
    for (int j = i; j < n; j++) {
        if (items[j].w <= remain_w) {
            remain_w -= items[j].w;
            b += items[j].v;
        } else {
            b += items[j].v * ((double)remain_w / items[j].w);
            break;
        }
    }
    return b;
}

// 1. Che do CO cat nhanh
int so_nut_co_cat = 0;
int max_v_co_cat = 0;
vector<int> x, best_x;

void thu_co_cat(int i, int current_w, int current_v) {
    so_nut_co_cat++;

    if (current_v > max_v_co_cat) {
        max_v_co_cat = current_v;
        best_x = x;
    }

    if (i == n) return;

    // Nhanh 1: Lay do vat i
    if (current_w + items[i].w <= W) {
        x[i] = 1;
        if (tinh_can(i + 1, current_w + items[i].w, current_v + items[i].v) > max_v_co_cat) {
            thu_co_cat(i + 1, current_w + items[i].w, current_v + items[i].v);
        }
        x[i] = 0;
    }

    // Nhanh 2: Khong lay do vat i
    if (tinh_can(i + 1, current_w, current_v) > max_v_co_cat) {
        x[i] = 0;
        thu_co_cat(i + 1, current_w, current_v);
    }
}

// 2. Che do KHONG cat nhanh
int so_nut_khong_cat = 0;
int max_v_khong_cat = 0;

void thu_khong_cat(int i, int current_w, int current_v) {
    so_nut_khong_cat++;

    if (current_v > max_v_khong_cat) {
        max_v_khong_cat = current_v;
    }

    if (i == n) return;

    // Nhanh lay do vat i
    if (current_w + items[i].w <= W) {
        thu_khong_cat(i + 1, current_w + items[i].w, current_v + items[i].v);
    }

    // Nhanh khong lay do vat i
    thu_khong_cat(i + 1, current_w, current_v);
}

int main() {
    items = {
        {'A', 4, 19},
        {'B', 7, 25},
        {'C', 3, 7},
        {'D', 3, 8},
        {'E', 3, 9},
        {'F', 10, 21}
    };

    // Sap xep do vat theo ti le v/w giam dan
    sort(items.begin(), items.end(), [](const Item& a, const Item& b) {
        return (double)a.v / a.w > (double)b.v / b.w;
    });

    x.assign(n, 0);
    best_x.assign(n, 0);

    thu_co_cat(0, 0, 0);
    thu_khong_cat(0, 0, 0);

    cout << "Thu tu xet sau khi sap xep: ";
    for (int i = 0; i < n; i++) {
        cout << items[i].name << (i == n - 1 ? "" : ", ");
    }
    cout << "\nGia tri lon nhat: " << max_v_co_cat << "\n";
    cout << "Tap do vat duoc chon: {";
    bool first = true;
    for (int i = 0; i < n; i++) {
        if (best_x[i] == 1) {
            if (!first) cout << ", ";
            cout << items[i].name;
            first = false;
        }
    }
    cout << "}\n";

    cout << "So nut CO cat nhanh: " << so_nut_co_cat << "\n";
    cout << "So nut KHONG cat nhanh: " << so_nut_khong_cat << "\n";
    cout << "So lan giam: " << (double)so_nut_khong_cat / so_nut_co_cat << "\n";

    return 0;
}