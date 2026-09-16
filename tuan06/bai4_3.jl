using Printf

# --- DỮ LIỆU BÀI TOÁN TỪ MỤC D ---
# 1. Mô hình ngôn ngữ 2 từ
const LM = Dict(
    "em" => Dict("học" => 0.52, "đi" => 0.48),
    "học" => Dict("bài" => 0.40, "toán" => 0.35, "vẽ" => 0.25),
    "đi" => Dict("chợ" => 0.58, "bơi" => 0.22, "ngủ" => 0.20)
)

# 2. Tham số Viterbi (1 tương ứng N, 2 tương ứng V)
const states = ["N", "V"]
const pi_prob = [0.6, 0.4] # [pi(N), pi(V)]
const A_matrix = [
    0.35 0.65;  # N -> N, N -> V
    0.70 0.30   # V -> N, V -> V
]

const B_dict = [
    Dict("em" => 0.35, "học" => 0.10, "bài" => 0.40, "toán" => 0.30), # Nhãn N (1)
    Dict("em" => 0.05, "học" => 0.45, "bài" => 0.05, "toán" => 0.02)  # Nhãn V (2)
]

const words = ["em", "học", "bài", "toán"]

# -------------------------------------------------------------
# 1. LIỆT KÊ TOÀN BỘ CÂU ĐỘ DÀI 3 BẮT ĐẦU BẰNG "EM"
# -------------------------------------------------------------
function liet_ke_toan_bo()
    println("--- 1. LIỆT KÊ TOÀN BỘ CÂU ĐỘ DÀI 3 BẮT ĐẦU BẰNG 'EM' ---")
    best_sent = ""
    max_p = -1.0

    for (w2, p1) in LM["em"]
        for (w3, p2) in LM[w2]
            p = p1 * p2
            sent = "em $w2 $w3"
            @printf("Câu: '%s' | Xác suất: %.4f\n", sent, p)
            if p > max_p
                max_p = p
                best_sent = sent
            end
        end
    end
    @printf("=> Câu tốt nhất: '%s' | Điểm = %.4f\n\n", best_sent, max_p)
end

# -------------------------------------------------------------
# 2. GIẢI MÃ THAM LAM
# -------------------------------------------------------------
function giai_ma_tham_lam()
    println("--- 2. GIẢI MÃ THAM LAM ---")
    cau = ["em"]
    score = 1.0

    while length(cau) < 3
        curr = cau[end]
        next_words = LM[curr]
        best_w = ""
        max_p = -1.0
        for (w, p) in next_words
            if p > max_p
                max_p = p
                best_w = w
            end
        end
        score *= max_p
        push!(cau, best_w)
    end
    @printf("Kết quả tham lam: '%s' | Điểm: %.4f\n\n", join(cau, " "), score)
end

# -------------------------------------------------------------
# 3. GIẢI MÃ THEO CHÙM (BEAM SEARCH)
# -------------------------------------------------------------
function beam_search(k::Int)
    beam = [(["em"], 1.0)]

    for step in 1:2
        candidates = Tuple{Vector{String}, Float64}[]
        for (seq, sc) in beam
            last_w = seq[end]
            for (next_w, p) in LM[last_w]
                push!(candidates, (vcat(seq, [next_w]), sc * p))
            end
        end
        sort!(candidates, by = x -> x[2], rev = true)
        beam = candidates[1:min(k, length(candidates))]
    end

    @printf("Chùm k = %d: '%s' | Xác suất: %.4f\n", k, join(beam[1][1], " "), beam[1][2])
end

# -------------------------------------------------------------
# 4. THUẬT TOÁN VITERBI VÀ VÉT CẠN 2^4 = 16 DÃY NHÃN
# -------------------------------------------------------------
function chay_viterbi()
    println("\n--- 4. THUẬT TOÁN VITERBI CHO CÂU 'EM HỌC BÀI TOÁN' ---")
    n = length(words)
    f = zeros(Float64, n, 2)
    backpointer = zeros(Int, n, 2)

    # Bước 1 (chỉ số Julia từ 1)
    for s in 1:2
        f[1, s] = pi_prob[s] * B_dict[s][words[1]]
    end

    # Quy hoạch động các bước tiếp theo
    for t in 2:n
        for s in 1:2
            max_val = -1.0
            best_prev = 0
            for prev_s in 1:2
                val = f[t - 1, prev_s] * A_matrix[prev_s, s]
                if val > max_val
                    max_val = val
                    best_prev = prev_s
                end
            end
            f[t, s] = max_val * B_dict[s][words[t]]
            backpointer[t, s] = best_prev
        end
    end

    # In Bảng 4.4 Lưới Viterbi
    @printf("%-4s%-8s%-15s%-15s%-18s%-18s\n", "i", "Từ", "f[i][N]", "f[i][V]", "Nhãn trước N", "Nhãn trước V")
    for t in 1:n
        bp_n_str = (t == 1) ? "—" : states[backpointer[t, 1]]
        bp_v_str = (t == 1) ? "—" : states[backpointer[t, 2]]
        @printf("%-4d%-8s%-15.6f%-15.6f%-18s%-18s\n", t, words[t], f[t, 1], f[t, 2], bp_n_str, bp_v_str)
    end

    # Lần vết chuỗi nhãn tối ưu
    best_last = (f[n, 1] >= f[n, 2]) ? 1 : 2
    max_p = f[n, best_last]
    path = [best_last]
    curr = best_last

    for t in n:-1:2
        curr = backpointer[t, curr]
        push!(path, curr)
    end
    reverse!(path)

    nhan_str = join([states[s] for s in path], " - ")
    @printf("\n=> Dãy nhãn tối ưu Viterbi: %s | Xác suất: %.6f\n\n", nhan_str, max_p)

    # Vét cạn 2^4 = 16 dãy nhãn để đối chiếu
    println("--- ĐỐI CHIẾU BẰNG VÉT CẠN 2^4 = 16 DÃY NHÃN ---")
    best_brute_seq = ""
    max_brute_p = -1.0

    for mask in 0:15
        # Bit 0 là N (1), bit 1 là V (2)
        seq = [((mask >> (3 - b)) & 1) + 1 for b in 0:3]
        p = pi_prob[seq[1]] * B_dict[seq[1]][words[1]]
        for t in 2:4
            p *= A_matrix[seq[t - 1], seq[t]] * B_dict[seq[t]][words[t]]
        end

        seq_text = join([states[s] for s in seq], " - ")
        @printf("Dãy: %s | P = %.6f\n", seq_text, p)
        if p > max_brute_p
            max_brute_p = p
            best_brute_seq = seq_text
        end
    end
    @printf("\n=> Nghiệm tối ưu vét cạn: %s | Xác suất = %.6f\n", best_brute_seq, max_brute_p)
end

function main()
    liet_ke_toan_bo()
    giai_ma_tham_lam()

    println("--- 3. GIẢI MÃ THEO CHÙM (BEAM SEARCH) ---")
    beam_search(1)
    beam_search(2)
    beam_search(3)

    chay_viterbi()
end

main()