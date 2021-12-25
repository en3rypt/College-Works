
def find_co_prime(a,n):
    if  n%a == 0:
        return False
    else:
        i=2
        while i< a and i<n:
            if a%i == 0 and n%i == 0:
                return False
            i+=1
        
    return True
            
            


n = int(input())
for i in range(n-1  , -1 , -1):
    print()
    if find_co_prime(i,n):
        print(i)
        break

