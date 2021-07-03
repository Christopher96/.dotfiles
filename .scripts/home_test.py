import socket
import threading
import time

server = ('192.168.0.10', 1337)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(server)

message = input('-> ')
while message != 'q':
    if message != '':
        s.send(str.encode(message))
        data = s.recv(1024).decode('UTF-8')
        print(str(data))
    message = input('-> ')

shutdown = True
s.close()
