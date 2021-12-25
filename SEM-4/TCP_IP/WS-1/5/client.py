import socket

c = socket.socket()

try:
    c.connect((socket.gethostname(),9999))
    name = input("Enter your name: ")
    c.send(name.encode())

    while True:
        reply = c.recv(1024).decode()
        print(reply)
        c.close() 
        print(f'{name} closed connection')
        break
except ConnectionRefusedError:
    print("No connection could be made because the target machine actively refused it")