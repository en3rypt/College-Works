import socket

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
serverAddr=((external_IP,9999))
name = input('Enter name:')
s.sendto(name.encode(),serverAddr)
reply,cIp=s.recvfrom(1024)
print(reply.decode())

while True:
    print("\n\n1. Withdraw\n2. Deposit\n3.Current balance\n4.Exit")
    choice = int(input("Enter your choice: "))
    if choice == 1:
        amt = input("Enter amount to withdraw: ")
        if amt.isdecimal():
            s.sendto(f'{name},{amt},{choice}'.encode(),serverAddr)
            reply,cIp=s.recvfrom(1024)
            print(reply.decode())
        
        else:
            print("\nInvalid Entry!")
            continue
    elif choice == 2:
        amt = input("Enter amount to deposit: ")
        if amt.isdecimal():
            s.sendto(f'{name},{amt},{choice}'.encode(),serverAddr)
            reply,cIp=s.recvfrom(1024)
            print(reply.decode())
        else:
            print("\nInvalid Entry!")
            continue
    elif choice == 3:
        s.sendto(f'{name},{0},{choice}'.encode(),serverAddr)
        reply,cIp=s.recvfrom(1024)
        print(reply.decode())
        
    
    elif choice == 4:
        s.sendto(f'{name},{0},{choice}'.encode(),serverAddr)
        reply,cIp=s.recvfrom(1024)
        print(reply.decode())
        break
    
    else:
        print("\nEnter correct choice")
'''

elif choice == 3:
        s.sendto(f'{name},{0},{choice}'.encode(),serverAddr)
        reply,cIp=s.recvfrom(1024)
        print(reply.decode())
    elif choice == 4:
        s.sendto(f'{name},{amt},{choice}'.encode(),serverAddr)
        reply,cIp=s.recvfrom(1024)
        print(reply.decode())
        break





import socket

clientSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
serverAddr=((socket.gethostname(),9999))
while True:
    msgeToServer = input("Enter your message to server")
    if msgeToServer == 'o':
        break
    clientSocket.sendto((msgeToServer+'1').encode(), serverAddr)

    msgeFromServer = clientSocket.recvfrom(1024)
    print('Message from server', msgeFromServer[0].decode())
'''
