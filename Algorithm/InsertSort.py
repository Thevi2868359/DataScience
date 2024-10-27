import random 

def insertSort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i-1 
        while j >= 0 and key < arr[j]:
            arr[j+1] = arr[j] 
            j = j -1 
        arr[j+1] = key
    return arr

def main():
    Arr = lambda n:[random.randint(0,100) for i in range(n)]
    arr = Arr(10)
    print(arr)
    
if __name__ == '__main__':
    main()