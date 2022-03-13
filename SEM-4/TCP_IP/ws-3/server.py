import socket
import threading
serverAddr=(('0.0.0.0',9999))
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
print("Server socket created")
BUFFER_SIZE = 1024

s.bind(serverAddr)

file = open('info.txt')
clients = file.readlines()
d = {}
for i in clients:
    si = i.strip('\n').split(':')
    d[si[0]] = float(si[1])
file.close()



def handle_client():
    
        
    while True:
        
        msg,cIp=s.recvfrom(1024)
        try:
            name,amt,choice = msg.decode().split(',')
        except ValueError:
            
            msg = msg.decode()
            print("Server is connected with : ",cIp)
            if msg not in d:
                d[msg] = 0
                s.sendto(f'[BANK]:New Account created for {msg}'.encode(),cIp)
            else:
                s.sendto(f"[BANK]:Account already exists for user {msg}".encode(),cIp)
            continue
        if choice == '1':
            amt = float(amt)
            if d[name] - amt >0:
                d[name]-=float(amt)
                s.sendto(f'[BANK]:Withdraw successful!\nCurrent balance: {d[name]}'.encode(),cIp)
            else:
                s.sendto('[BANK]:Insufficient funds!'.encode(),cIp)
            continue  
        elif choice == '2':
            d[name] += float(amt)
            s.sendto(f'[BANK]:Deposit successful!\nCurrent balance: {d[name]}'.encode(),cIp)
            continue
        elif choice == '3':
            s.sendto(f'[BANK]:Current balance: {d[name]}'.encode(),cIp)
            continue
        elif choice =='4':
            s.sendto(f'[BANK]:Thank you, have a great day!'.encode(),cIp)
            continue
        else:
            break

        file = open('info.txt','w')
        for i in d:
            file.write(f'{i}:{d[i]}\n')
        file.close()
        s.close()
        
    '''while True:
        
        print('listening')
        msg,cIp=s.recvfrom(1024)
        print(msg)
        msg = msg.decode()
        try:
            name,amt,choice = msg.split(',')
        except ValueError:
            print("Server is connected with : ",cIp)
            if msg not in d:
                d[msg] = 0
                print(f'Account created for {msg}')
            else:
                print("Account already exists")
            continue
        if choice == '1':
            amt = float(amt)
            if d[name] - amt >=0:
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
        s.close()'''
def start():
    while(True):
        
        thread = threading.Thread(target = handle_client())
        thread.start()
        
start()



'''

if choice == '1':
            amt = float(amt)
            if d[name] - amt >=0:
                d[name]-=float(amt)
                s.sendto(f'[BANK]: Withdraw successful!\nCurrent balance: {d[name]}'.encode(),cIp)
            else:
                s.sendto('[BANK]: Insufficient funds!'.encode(),cIp)
                
        elif choice == '2':
            d[name] += float(amt)
            s.sendto(f'[BANK]: Deposit successful!\nCurrent balance: {d[name]}'.encode(),cIp)
        elif choice == '3':
            s.sendto(f'[BANK]: Current balance: {d[name]}'.encode(),cIp)
        elif choice == '4':
            s.sendto(f'[BANK]: Thank you! Have a great Day!'.encode(),cIp)
        else:
            break

import socket
import threading
serverAddr=((socket.gethostname(),9999))
serverSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
print("Server socket created")

serverSocket.bind(serverAddr)

def handle_client():
    connected = True
    while connected:
        msge, addr = serverSocket.recvfrom(1024)
        print(addr)
        m = msge.decode()
        print("Message from Client"+m[len(m)-1]+":"+m[0:len(m)-1])
        #replyToClient = input("Enter your reply to client"+m[len(m)-1]+":")
        serverSocket.sendto(msge[0:len(msge)-1], addr)
        
def start():
    while(True):
        thread = threading.Thread(target = handle_client())
        thread.start()
        
start()
'''
