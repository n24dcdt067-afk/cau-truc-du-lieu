def sap_xep_chen(a):
    n = len(a)
    for i in range(1, n):
        x = a[i]
        j = i - 1
        while j >= 0 and a[j] > x:
            a[j + 1] = a[j]
            j -= 1
        a[j + 1] = x
    return a

if __name__ == "__main__":
    A = [8, 3, 5, 1, 9, 2]
    print("Mang ban dau:", A)
    sap_xep_chen(A)
    print("Mang sau sap xep:", A)
