
'''
def partition(arr,start,end):
    p = start
    pe = arr[p]
    while start < end:
        while start < len(arr) and arr[start]<=pe:
            start+=1
        while arr[end] > pe:
            end-=1

        if (start < end):
            arr[start],arr[end] = arr[end],arr[start]

    arr[end],arr[p] = arr[p],arr[end]
    return end




def quick(arr,start,end):
    if start < end:
        p = partition(arr,start,end)
        quick(arr,start,p-1)
        quick(arr,p+1,end)






arr= [ 10, 7, 8, 9, 1, 5 ]
quick(arr,0,len(arr)-1)
print(arr)


'''

def binary(arr,l,r,x):
    if (l<=r):
        print(1)
        mid = (l+r)//2
        if arr[mid] == x:
            return mid
        elif arr[mid] > x:
            return binary(arr,l,mid-1,x)
        else:
            return binary(arr,mid+1,r,x)
    else:
        return -1


arr = [ 2, 3, 4, 10, 40 ]
k = binary(arr,0,len(arr)-1,10)
print(k)
