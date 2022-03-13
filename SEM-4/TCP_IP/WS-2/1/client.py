#client
import socket

s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
serverAddr=((socket.gethostname(),9999))


s.sendto(b'',serverAddr)

data,addr = s.recvfrom(1024)

f = open (data.decode(), "wb")



data,addr = s.recvfrom(1024)
try:
    while data:
        f.write(data)
        s.settimeout(2)
        data,addr = s.recvfrom(1024)
except socket.timeout:
    print("done")
    f.close()
    s.close()
