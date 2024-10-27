import random


def swapArr(arr, parameter):
    if parameter >= 0:
        arr[parameter], arr[parameter+1] = arr[parameter+1], arr[parameter]
    
    
def bubleSort(arr): #fuction
    for i in range(len(arr)):
        swaped = False
        for j in range(len(arr)-1):
            if arr[j] > arr[j+1]:
                swaped = True 
                swapArr(arr, j) 
        
        if not swaped:
            break
       
    return arr
   
    
def main():
    Arr = lambda n:[random.randint(0,100) for i in range(n)]
    arr = Arr(10)
    print(arr)
    
if __name__ == '__main__':
    main()