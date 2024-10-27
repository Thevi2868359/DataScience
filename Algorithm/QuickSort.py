def Sulution(arr, left, right):
    i = left -1
    for j in range(left, right):
        if arr[j] < arr[right]:
            i +=1 
            arr[i], arr[j] = arr[j], arr[i]
            
    arr[i+1], arr[right] = arr[right], arr[i+1]
    return i+1

def quickSort(arr, left, right):
    if left < right:
        pi = Sulution(arr, left, right)
        
        quickSort(arr, left, pi-1)
        quickSort(arr, pi+1, right)