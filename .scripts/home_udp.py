import socket
import sys
from threading import Thread
import time

host = '127.0.0.1'
port = 1337
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

try:
    s.bind((host, port))
except socket.error as e:
    print(str(e))

def getOS():
    return sys.platform

def callAction(action):
    return {
        'getOS': getOS()
    }.get(action, False)

s.setblocking(False)
quitting = False

def connect():
    while not quitting:
        try:
            data, addr = s.recvfrom(2048)
            if data:
                action = data.decode('UTF-8')
                res = callAction(str(action))
                if res:
                    s.sendto(str.encode(res), addr)
        except socket.error as e:
            pass

thread = Thread(target=connect)
thread.start()

while True:
    cmd = input('-> ')
    if cmd == 'q':
        break

print("Quitting")
quitting = True
s.close()
