n = int(input())
l=['']
for i in range(n):
    s = int(input())
    k = bin(s)
    l.append(k.lstrip('0b'))

maxv=0

