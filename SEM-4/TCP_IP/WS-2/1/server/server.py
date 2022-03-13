import socket

s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.bind((socket.gethostname(),9999))

print("Server waiting")
BUFFER_SIZE = 1024
while True:
    msc,cIp=s.recvfrom(1024)
    print("Server is6 connected with : ",cIp)
    
    file = input('enter file name:')
    s.sendto(file.encode(),cIp)
    f = open(file,'rb')
    l = f.read(BUFFER_SIZE)
    while l:
        s.sendto(l,cIp)
        l = f.read(BUFFER_SIZE)
    print('Send over!')
 

s.close()

