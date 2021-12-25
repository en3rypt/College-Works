import socket
import time
s = socket.socket()
host = socket.gethostname()

s.bind((host,9999))

s.listen(1)

print('waiting for connections!')

c,addr = s.accept()
name = c.recv(1024).decode()
print(f"connected with {name}")
while True:
    msg = c.recv(1024).decode()
    if msg:
        reply = ' '.join(format(ord(x), 'b') for x in msg)
        c.send(reply.encode())
    else:
        print(f"Connection closed for {name}")
        c.close()
        break