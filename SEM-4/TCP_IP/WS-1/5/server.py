import socket

from datetime import datetime


def get_time():
    now = datetime.now()
    dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
    time = f"Current Time: {dt_string}"
    return time
    
s = socket.socket()
host = socket.gethostname()

s.bind((host,9999))

s.listen(1)

print('waiting for connections!')

c,addr = s.accept()
name = c.recv(1024).decode()
print(f"connected with {name}")
while True:
        c.send(get_time().encode())
        print(f"Connection closed for {name}")
        c.close()
        break