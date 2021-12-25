n = int(input())
x = list(str(n))

swaps = 0
min1 = n
flag = True
i1 = i2 = -1
gc = 0

while flag and gc<100:
        for i in range(len(x)-1):
                a = int(x[i])
                b = int(x[i+1])
                if abs(a-b) == 1:
                        if a>b:
                                x[i],x[i+1] = x[i+1],x[i]
                                swaps+=1
                        else:
                                j = i-1
                                if j>=0 and j<len(x):
                                        c = int(x[j])
                                        d = b
                                        if c>d:
                                                x[i],x[i+1] = x[i+1],x[i]
                                                swaps+=1

        y = int(''.join(x))
        if y < min1:
                min1 = y
        else:
                gc+=1
        flag = False
        for i in range(len(x)-1):
                a = int(x[i])
                b = int(x[i+1])
                if abs(a-b) == 1:
                        flag = True
                        break
print(swaps,y)
