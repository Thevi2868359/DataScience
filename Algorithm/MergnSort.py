def mergnSort(arr):
    if len(arr) > 1:
        mid = (len(arr)) // 2
        arr_left = arr[:mid]
        arr_right = arr[mid:]

        mergnSort(arr_left)
        mergnSort(arr_right)

        i = j = v = 0
        while i < len(arr_left) and j < len(arr_left):
            if arr_left[i] < arr_right[j]:
                arr[v] = arr_left[i]
                i += 1
            else:
                arr[v] = arr_right[j]
                j += 1
            v += 1

        while i < len(arr_left):
            arr[v] = arr_left[i]
            i += 1
            v += 1

        while j < len(arr_right):
            arr[v] = arr_right[j]
            j += 1
            v += 1
    return arr
