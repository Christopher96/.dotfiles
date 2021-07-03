import signal
import subprocess
import socket
import sys
from threading import Thread

host = ""
port = 1337
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

try:
    s.bind((host, port))
except socket.error as e:
    print(str(e))

def getOS():
    return sys.platform

def operateOS(operation):
    os = getOS()
    cmd = ""
    if(os == "linux"):
        if(operation == "restart"):
            cmd = "reboot -f"
        elif(operation == "shutdown"):
            cmd = "poweroff -f"
        elif(operation == "switch"):
            cmd = "grub-reboot 'Windows 7' && reboot now"
    else:
        if(operation == "restart"):
            cmd = "shutdown /t 0" 
        elif(operation == "shutdown"):
            cmd = "shutdown /t 0 /r"
        elif(operation == "switch"):
            cmd = "shutdown /t 0 /r"

    if(cmd != ""):
        p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
        p.wait()
        if(p.poll() == 0):
            return "success"

    return "fail"


def callAction(a):
    if(a == "getOS"):
        return getOS()
    elif(a == "restart"):
        return operateOS("restart")
    elif(a == "shutdown"):
        return operateOS("shutdown")
    elif(a == "switch"):
        return operateOS("switch")
    else:
        return "invalid"

s.listen(5)

while True:
    try: 
        conn, addr = s.accept()
        while True:
                data = conn.recv(1024)
                if not data:
                    break
                action = data.decode('UTF-8').strip()
                res = callAction(action)
                conn.send(str.encode(res))
        conn.close()
    except KeyboardInterrupt:
        break

s.close()
sys.exit(0)
