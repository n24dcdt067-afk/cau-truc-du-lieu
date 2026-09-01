#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <numeric>
#include <map>

using namespace std;

// Ham tinh khoang cach Euclidean giua 2 diem da chieu
double euclidean_distance(const vector<double>& p1, const vector<double>& p2) {
    double sum = 0.0;
    for (size_t i = 0; i < p1.size(); i++) {
        sum += (p1[i] - p2[i]) * (p1[i] - p2[i]);
    }
    return sqrt(sum);
}

// Ham du doan nhan bang KNN
int knn_predict(const vector<vector<double>>& X_train, const vector<int>& y_train, const vector<double>& q, int k) {
    int n = X_train.size();
    vector<double> distances(n);
    for (int i = 0; i < n; i++) {
        distances[i] = euclidean_distance(q, X_train[i]);
    }

    // Tao mang chi so 0, 1, ..., n-1
    vector<int> indices(n);
    iota(indices.begin(), indices.end(), 0);

    // Sap xep mang chi so dua theo khoang cach tang dan
    sort(indices.begin(), indices.end(), [&distances](int i1, int i2) {
        return distances[i1] < distances[i2];
    });

    // Dem tan suat nhan cua K lang gieng gan nhat
    map<int, int> vote_count;
    for (int i = 0; i < k; i++) {
        int label = y_train[indices[i]];
        vote_count[label]++;
    }

    // Tim nhan co so phieu cao nhat
    int best_label = -1;
    int max_votes = -1;
    for (auto const& [label, count] : vote_count) {
        if (count > max_votes) {
            max_votes = count;
            best_label = label;
        }
    }
    return best_label;
}

int main() {
    // Tap du lieu huan luyen 2D gom 6 diem voi 2 lop (0 va 1)
    vector<vector<double>> X_train = {
        {1.0, 2.0}, {2.0, 3.0}, {3.0, 3.0},
        {6.0, 5.0}, {7.0, 7.0}, {8.0, 6.0}
    };
    vector<int> y_train = {0, 0, 0, 1, 1, 1};

    vector<double> q = {2.0, 2.0};
    int k = 3;

    int pred = knn_predict(X_train, y_train, q, k);

    cout << "Diem truy van q: (" << q[0] << ", " << q[1] << ")\n";
    cout << "Du doan lop (K=" << k << "): " << pred << "\n";

    return 0;
}