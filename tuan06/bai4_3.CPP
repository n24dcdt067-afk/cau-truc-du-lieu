#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <iomanip>
#include <algorithm>

using namespace std;

// Dữ liệu mô hình ngôn ngữ 2 từ
map<string, map<string, double>> LM = {
    {"em", {{"học", 0.52}, {"đi", 0.48}}},
    {"học", {{"bài", 0.40}, {"toán", 0.35}, {"vẽ", 0.25}}},
    {"đi", {{"chợ", 0.58}, {"bơi", 0.22}, {"ngủ", 0.20}}}
};

// 1. Liệt kê toàn bộ câu độ dài 3 bắt đầu bằng "em"
void liet_ke_toan_bo() {
    cout << "--- 1. LIET KE TOAN BO CAU DO DAI 3 BAT DAU BANG 'EM' ---\n";
    string best_sent = "";
    double max_p = -1.0;

    for (auto const& [w2, p1] : LM["em"]) {
        for (auto const& [w3, p2] : LM[w2]) {
            double p = p1 * p2;
            string sent = "em " + w2 + " " + w3;
            cout << "Cau: '" << sent << "' | Xac suat: " << fixed << setprecision(4) << p << "\n";
            if (p > max_p) {
                max_p = p;
                best_sent = sent;
            }
        }
    }
    cout << "=> Cau tot nhat: '" << best_sent << "' | Xac suat: " << fixed << setprecision(4) << max_p << "\n\n";
}

// 2. Giải mã tham lam
void giai_ma_tham_lam() {
    cout << "--- 2. GIAI MA THAM LAM ---\n";
    vector<string> cau = {"em"};
    double score = 1.0;

    while (cau.size() < 3) {
        string curr = cau.back();
        string best_next = "";
        double max_p = -1.0;
        for (auto const& [next_w, p] : LM[curr]) {
            if (p > max_p) {
                max_p = p;
                best_next = next_w;
            }
        }
        score *= max_p;
        cau.push_back(best_next);
    }
    cout << "Ket qua tham lam: '" << cau[0] << " " << cau[1] << " " << cau[2] 
         << "' | Diem: " << fixed << setprecision(4) << score << "\n\n";
}

// 3. Giải mã theo chùm (Beam Search)
void beam_search(int k) {
    struct BeamItem {
        vector<string> words;
        double score;
    };

    vector<BeamItem> beam = {{ {"em"}, 1.0 }};

    for (int step = 0; step < 2; step++) {
        vector<BeamItem> candidates;
        for (const auto& item : beam) {
            string last_w = item.words.back();
            for (auto const& [next_w, p] : LM[last_w]) {
                vector<string> next_words = item.words;
                next_words.push_back(next_w);
                candidates.push_back({next_words, item.score * p});
            }
        }
        sort(candidates.begin(), candidates.end(), [](const BeamItem& a, const BeamItem& b) {
            return a.score > b.score;
        });
        if (candidates.size() > (size_t)k) {
            candidates.resize(k);
        }
        beam = candidates;
    }

    cout << "Chum k = " << k << ": '" << beam[0].words[0] << " " << beam[0].words[1] << " " << beam[0].words[2]
         << "' | Xac suat: " << fixed << setprecision(4) << beam[0].score << "\n";
}

// 4. Thuật toán Viterbi và vét cạn 2^4
void chay_viterbi() {
    cout << "\n--- 4. THUAT TOAN VITERBI CHO CAU 'EM HOC BAI TOAN' ---\n";
    vector<string> states = {"N", "V"};
    map<string, double> pi = {{"N", 0.6}, {"V", 0.4}};
    map<string, map<string, double>> A = {
        {"N", {{"N", 0.35}, {"V", 0.65}}},
        {"V", {{"N", 0.70}, {"V", 0.30}}}
    };
    map<string, map<string, double>> B = {
        {"N", {{"em", 0.35}, {"học", 0.10}, {"bài", 0.40}, {"toán", 0.30}}},
        {"V", {{"em", 0.05}, {"học", 0.45}, {"bài", 0.05}, {"toán", 0.02}}}
    };
    vector<string> obs = {"em", "học", "bài", "toán"};
    int n = obs.size();

    vector<map<string, double>> f(n);
    vector<map<string, string>> backpointer(n);

    // Bước 1
    for (const string& s : states) {
        f[0][s] = pi[s] * B[s][obs[0]];
    }

    // Quy hoạch động từ bước 2 đến n
    for (int t = 1; t < n; t++) {
        for (const string& s : states) {
            double max_val = -1.0;
            string best_prev = "";
            for (const string& prev_s : states) {
                double val = f[t - 1][prev_s] * A[prev_s][s];
                if (val > max_val) {
                    max_val = val;
                    best_prev = prev_s;
                }
            }
            f[t][s] = max_val * B[s][obs[t]];
            backpointer[t][s] = best_prev;
        }
    }

    // In Bảng 4.4
    cout << left << setw(4) << "i" << setw(8) << "Tu" << setw(15) << "f[i][N]" << setw(15) << "f[i][V]"
         << setw(18) << "Nhan truoc N" << "Nhan truoc V\n";
    for (int t = 0; t < n; t++) {
        cout << left << setw(4) << (t + 1)
             << setw(8) << obs[t]
             << setw(15) << fixed << setprecision(6) << f[t]["N"]
             << setw(15) << fixed << setprecision(6) << f[t]["V"]
             << setw(18) << (t == 0 ? "—" : backpointer[t]["N"])
             << (t == 0 ? "—" : backpointer[t]["V"]) << "\n";
    }

    // Lần vết
    string best_last = (f[n - 1]["N"] >= f[n - 1]["V"]) ? "N" : "V";
    double max_final_p = f[n - 1][best_last];
    vector<string> path = {best_last};
    string curr = best_last;
    for (int t = n - 1; t > 0; t--) {
        curr = backpointer[t][curr];
        path.push_back(curr);
    }
    reverse(path.begin(), path.end());

    cout << "\n=> Day nhan toi uu Viterbi: ";
    for (size_t i = 0; i < path.size(); i++) {
        cout << path[i] << (i + 1 < path.size() ? " - " : "");
    }
    cout << " | Xac suat: " << fixed << setprecision(6) << max_final_p << "\n\n";

    // Vét cạn 16 dãy nhãn (2^4) để đối chiếu
    cout << "--- DOI CHIEU BANG VET CAN 2^4 = 16 DAY NHAN ---\n";
    string best_brute = "";
    double max_brute_p = -1.0;

    for (int mask = 0; mask < 16; mask++) {
        vector<string> seq(4);
        for (int b = 0; b < 4; b++) {
            seq[b] = ((mask >> (3 - b)) & 1) ? "V" : "N";
        }
        double p = pi[seq[0]] * B[seq[0]][obs[0]];
        for (int t = 1; t < 4; t++) {
            p *= A[seq[t - 1]][seq[t]] * B[seq[t]][obs[t]];
        }
        string seq_str = seq[0] + " - " + seq[1] + " - " + seq[2] + " - " + seq[3];
        cout << "Day: " << seq_str << " | P = " << fixed << setprecision(6) << p << "\n";
        if (p > max_brute_p) {
            max_brute_p = p;
            best_brute = seq_str;
        }
    }
    cout << "\n=> Nghiem toi uu vet can: " << best_brute << " | Xac suat = " << fixed << setprecision(6) << max_brute_p << "\n";
}

int main() {
    liet_ke_toan_bo();
    giai_ma_tham_lam();

    cout << "--- 3. GIAI MA THEO CHUM (BEAM SEARCH) ---\n";
    beam_search(1);
    beam_search(2);
    beam_search(3);

    chay_viterbi();

    return 0;
}