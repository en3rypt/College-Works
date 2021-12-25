arr = ['P', 'T', 'T', 'P', 'T']
n = len(arr)


p = []
t = []
d = []
for i in range(len(arr)):
    if arr[i] == 'P':
        p.append(i)
    else:
        t.append(i)


