import socket
import pickle

c = socket.socket()

try:
    c.connect((socket.gethostname(),9999))
    name = input("Enter your name: ")
    c.send(name.encode())

    while True:
        s = input("Enter the message to be sent: ")
        if s == "quit":
            break
        data_string = pickle.dumps(s)
        c.send(data_string)
        reply = c.recv(1024).decode()
        print(f"Message from Server: {reply}")
        
    c.close() 
    print(f'{name} closed connection')
except ConnectionRefusedError:
    print("No connection could be made because the target machine actively refused it")