import socket

s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind((socket.gethostname(),9999))

print("Server waiting")
BUFFER_SIZE = 1024

file = open('info.txt')
clients = file.readlines()
d = {}
for i in clients:
    si = i.strip('\n').split(':')
    d[si[0]] = float(si[1])
file.close()
msg,cIp=s.recvfrom(1024)
msg = msg.decode()
print("Server is connected with : ",cIp)
if msg not in d:
    d[msg] = 0
    print(f'Account create for {msg}')
else:
    print("Account already exists")
    
while True:
    
    msg,cIp=s.recvfrom(1024)
    name,amt,choice = msg.decode().split(',')
    if choice == '1':
        amt = float(amt)
        if d[name] - amt >0:
            d[name]-=float(amt)
            s.sendto(f'Withdraw successful!\nCurrent balance: {d[name]}'.encode(),cIp)
        else:
            s.sendto('Insufficient funds!'.encode(),cIp)
            
    elif choice == '2':
        d[name] += float(amt)
        s.sendto(f'Deposit successful!\nCurrent balance: {d[name]}'.encode(),cIp)
    else:
        break

file = open('info.txt','w')
for i in d:
    file.write(f'{i}:{d[i]}\n')
file.close()
s.close()

