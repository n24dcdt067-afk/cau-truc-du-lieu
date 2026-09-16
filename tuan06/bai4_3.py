import itertools

# --- DỮ LIỆU BÀI TOÁN TỪ MỤC D ---
# 1. Mô hình ngôn ngữ 2 từ
LM = {
    "em": {"học": 0.52, "đi": 0.48},
    "học": {"bài": 0.40, "toán": 0.35, "vẽ": 0.25},
    "đi": {"chợ": 0.58, "bơi": 0.22, "ngủ": 0.20}
}

# 2. Tham số Viterbi
states = ['N', 'V']
pi = {'N': 0.6, 'V': 0.4}
A = {
    'N': {'N': 0.35, 'V': 0.65},
    'V': {'N': 0.70, 'V': 0.30}
}
B = {
    'N': {'em': 0.35, 'học': 0.10, 'bài': 0.40, 'toán': 0.30},
    'V': {'em': 0.05, 'học': 0.45, 'bài': 0.05, 'toán': 0.02}
}
words = ["em", "học", "bài", "toán"]

# -------------------------------------------------------------
# PHẦN 1: LIỆT KÊ TẤT CẢ CÂU ĐỘ DÀI 3 BẮT ĐẦU BẰNG "EM"
# -------------------------------------------------------------
def liet_ke_cau():
    print("--- 1. LIỆT KÊ TOÀN BỘ CÂU ĐỘ DÀI 3 BẮT ĐẦU BẰNG 'EM' ---")
    danh_sach = []
    w1 = "em"
    for w2, p1 in LM[w1].items():
        for w3, p2 in LM[w2].items():
            prob = p1 * p2
            cau = f"{w1} {w2} {w3}"
            danh_sach.append((cau, prob))
            print(f"Câu: '{cau}' | Xác suất: {prob:.4f}")
    
    tot_nhat = max(danh_sach, key=lambda x: x[1])
    print(f"=> Câu tốt nhất: '{tot_nhat[0]}' với điểm = {tot_nhat[1]:.4f}\n")
    return tot_nhat

# -------------------------------------------------------------
# PHẦN 2: GIẢI MÃ THAM LAM
# -------------------------------------------------------------
def giai_ma_tham_lam():
    print("--- 2. GIẢI MÃ THAM LAM ---")
    cau = ["em"]
    xac_suat = 1.0
    while len(cau) < 3:
        tu_hien_tai = cau[-1]
        lua_chon = LM[tu_hien_tai]
        tu_tiep = max(lua_chon, key=lua_chon.get)
        xac_suat *= lua_chon[tu_tiep]
        cau.append(tu_tiep)
    res_cau = " ".join(cau)
    print(f"Kết quả tham lam: '{res_cau}' | Điểm: {xac_suat:.4f}\n")
    return res_cau, xac_suat

# -------------------------------------------------------------
# PHẦN 3: GIẢI MÃ THEO CHÙM (BEAM SEARCH) VỚI K = 1, 2, 3
# -------------------------------------------------------------
def beam_search(k):
    # Mỗi chùm lưu: (dãy các từ, xác suất tích lũy)
    beam = [(["em"], 1.0)]
    for _ in range(2):
        ung_vien = []
        for seq, score in beam:
            last_w = seq[-1]
            for next_w, p in LM[last_w].items():
                ung_vien.append((seq + [next_w], score * p))
        # Giữ lại k ứng viên tốt nhất
        beam = sorted(ung_vien, key=lambda x: x[1], reverse=True)[:k]
    
    tot_nhat = beam[0]
    res_cau = " ".join(tot_nhat[0])
    return res_cau, tot_nhat[1]

# -------------------------------------------------------------
# PHẦN 4: THUẬT TOÁN VITERBI VÀ VÉT CẠN 2^4 DÃY NHÃN
# -------------------------------------------------------------
def viterbi(obs):
    print("--- 4. THUẬT TOÁN VITERBI CHO CÂU 'EM HỌC BÀI TOÁN' ---")
    n = len(obs)
    f = [{s: 0.0 for s in states} for _ in range(n)]
    backpointer = [{s: None for s in states} for _ in range(n)]

    # Khởi tạo bước 1 (i = 0 tương ứng từ thứ 1)
    for s in states:
        f[0][s] = pi[s] * B[s][obs[0]]

    # Quy hoạch động bước 2 -> n
    for t in range(1, n):
        for s in states:
            max_prob, best_prev = max(
                (f[t - 1][prev_s] * A[prev_s][s], prev_s) for prev_s in states
            )
            f[t][s] = max_prob * B[s][obs[t]]
            backpointer[t][s] = best_prev

    # In Bảng 4.4 Lưới Viterbi
    print(f"{'i':<3}{'Từ':<8}{'f[i][N]':<14}{'f[i][V]':<14}{'Nhãn trước N':<16}{'Nhãn trước V'}")
    for t in range(n):
        fn_str = f"{f[t]['N']:.6f}"
        fv_str = f"{f[t]['V']:.6f}"
        bp_n = str(backpointer[t]['N']) if backpointer[t]['N'] else "—"
        bp_v = str(backpointer[t]['V']) if backpointer[t]['V'] else "—"
        print(f"{t+1:<3}{obs[t]:<8}{fn_str:<14}{fv_str:<14}{bp_n:<16}{bp_v}")

    # Lần vết chuỗi nhãn tốt nhất
    best_last_state = max(states, key=lambda s: f[n - 1][s])
    max_score = f[n - 1][best_last_state]

    best_path = [best_last_state]
    curr = best_last_state
    for t in range(n - 1, 0, -1):
        curr = backpointer[t][curr]
        best_path.append(curr)
    best_path.reverse()

    print(f"\nDãy nhãn tối ưu Viterbi: {' - '.join(best_path)} | Xác suất: {max_score:.6f}\n")
    return best_path, max_score

def vet_can_viterbi(obs):
    print("--- ĐỐI CHIẾU BẰNG VÉT CẠN TẤT CẢ 2^4 = 16 DÃY NHÃN ---")
    tat_ca_day = list(itertools.product(states, repeat=len(obs)))
    ket_qua = []

    for seq in tat_ca_day:
        p = pi[seq[0]] * B[seq[0]][obs[0]]
        for t in range(1, len(obs)):
            p *= A[seq[t - 1]][seq[t]] * B[seq[t]][obs[t]]
        ket_qua.append((seq, p))

    ket_qua.sort(key=lambda x: x[1], reverse=True)
    for seq, p in ket_qua:
        print(f"Dãy: {' - '.join(seq)} | P = {p:.6f}")

    best_seq, max_p = ket_qua[0]
    print(f"\n=> Nghiệm tối ưu vét cạn: {' - '.join(best_seq)} | Xác suất = {max_p:.6f}\n")


if __name__ == "__main__":
    liet_ke_cau()
    giai_ma_tham_lam()
    
    print("--- 3. GIẢI MÃ THEO CHÙM (BEAM SEARCH) ---")
    for k in [1, 2, 3]:
        c, s = beam_search(k)
        print(f"Chùm k = {k}: '{c}' | Xác suất: {s:.4f}")
    print()

    viterbi(words)
    vet_can_viterbi(words)