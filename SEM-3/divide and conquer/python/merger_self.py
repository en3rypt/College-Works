
def merge(arr,temp,left,mid,right):
    
    i = left
    j = mid+1
    k = left
    count = 0
    while i<=mid and j<=right:
        if arr[i] <=arr[j]:
            temp[k] = arr[i]
            i+=1
        else:
            count+= mid-i+1
            temp[k] = arr[j]
            j+=1
        k+=1

    while i<=mid:
        temp[k]=arr[i]
        i+=1
        k+=1
    while j<=right:
        temp[k] = arr[j]
        j+=1
        k+=1

    for i in range(left,right+1):
        arr[i] = temp[i]
    return count
        
def mergeSort(arr,temp,left,right):

    count=0
    if left<right:
        mid = (left+right)//2
        count+=mergeSort(arr,temp,left,mid)
        count+=mergeSort(arr,temp,mid+1,right)
        count+=merge(arr,temp,left,mid,right)
    return count
        
        

arr = [1, 20,7, 6, 4, 5]
n = mergeSort(arr,[0]*len(arr),0,len(arr)-1)
print(arr)
print(n)
