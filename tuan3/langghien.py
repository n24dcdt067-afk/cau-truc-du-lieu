import math
from collections import Counter

def euclidean_distance(p1, p2):
    return math.sqrt(sum((a - b) ** 2 for a, b in zip(p1, p2)))

def knn_predict(X_train, y_train, q, k):
    # Tinh khoang cach tu diem q toi tat ca cac diem trong tap train
    distances = [euclidean_distance(q, x) for x in X_train]
    
    # Sap xep mang chi so theo khoang cach tang dan
    sorted_indices = sorted(range(len(distances)), key=lambda i: distances[i])
    
    # Lay nhan cua K lang gieng gan nhat
    k_nearest_labels = [y_train[i] for i in sorted_indices[:k]]
    
    # Bo phieu da so (Majority Voting)
    most_common = Counter(k_nearest_labels).most_common(1)
    return most_common[0][0]

if __name__ == "__main__":
    # Tap du lieu 2D gom 6 diem voi 2 lop nhan (0 va 1)
    X_train = [[1, 2], [2, 3], [3, 3], [6, 5], [7, 7], [8, 6]]
    y_train = [0, 0, 0, 1, 1, 1]
    
    q = [2, 2]
    k = 3
    pred = knn_predict(X_train, y_train, q, k)
    print(f"Diem truy van: {q}")
    print(f"Du doan lop (K={k}): {pred}")