import socket


s = socket.socket()
host = socket.gethostname()
print(socket.gethostbyname(host))
s.bind((host,9998))
s.listen(1)


print('server up')
while True:
    print('Ready to serve...')
    c,addr = s.accept()
    try:
        message = c.recv(1024)
        filename = message.split()[1]
        f = open(filename.decode().strip('/').encode())
        outputdata = f.read()
        c.send('\nHTTP/1.1 200 OK\n\n'.encode())
        for i in range(0, len(outputdata)):
            c.send(outputdata[i].encode())
        c.send("\r\n".encode())
        c.close()
    except IOError:
        f = open('404.html')
        outputdata = f.read()
        c.send("\nHTTP/1.1 404 Not Found\n\n".encode())
        for i in range(0, len(outputdata)):
            c.send(outputdata[i].encode())
        c.send("\r\n".encode())
        c.close()

s.close()