using StatsBase

# Ham tinh khoang cach Euclidean giua 2 diem
function euclidean_distance(p1, p2)
    return sqrt(sum((p1 .- p2) .^ 2))
end

# Ham du doan KNN
function knn_predict(X_train, y_train, q, k)
    # Tinh khoang cach tu diem q toi tat ca cac diem trong tap train
    distances = [euclidean_distance(q, x) for x in X_train]
    
    # Sap xep mang chi so theo khoang cach tang dan (1-based indexing)
    sorted_indices = sortperm(distances)
    
    # Lay nhan cua K lang gieng gan nhat
    k_nearest_labels = [y_train[i] for i in sorted_indices[1:k]]
    
    # Bo phieu da so (lay mode)
    return mode(k_nearest_labels)
end

# Tap du lieu 2D gom 6 diem voi 2 lop nhan (0 va 1)
X_train = [[1.0, 2.0], [2.0, 3.0], [3.0, 3.0], [6.0, 5.0], [7.0, 7.0], [8.0, 6.0]]
y_train = [0, 0, 0, 1, 1, 1]

q = [2.0, 2.0]
k = 3

pred = knn_predict(X_train, y_train, q, k)

println("Diem truy van q: ", q)
println("Du doan lop (K = ", k, "): ", pred)