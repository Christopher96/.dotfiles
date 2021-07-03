#!/usr/bin/env python3

import i3ipc, os, types, sys

 #Create the Connection object that can be used to send commands and subscribe
 #to events.
i3 = i3ipc.Connection()

def list(object, methods=True):
    for name in dir(object):
        if isinstance(getattr(object, name), types.MethodType):
            if methods == True:
                print(name)
        elif methods == False:
            print(name)

def init_cava():
    output = os.popen('ps aux | grep "'+command+'" | grep -v "grep"').read().strip()
    if not output:
        os.system(command+command_return)
    cava_check()
    
            
# Print the name of the focused window
focused = i3.get_tree().find_focused()

#print('Focused window %s is on workspace %s' % (focused.name, focused.workspace().name))

# Query the ipc for outputs. The result is a list that represents the parsed
# reply of a command like `i3-msg -t get_outputs`.
outputs = i3.get_outputs()

#print('Active outputs:')

#for output in filter(lambda o: o.active, outputs):
#    print(output.name)

# Send a command to be executed synchronously.
i3.command('focus left')

# Take all fullscreen windows out of fullscreen
for container in i3.get_tree().find_fullscreen():
    container.command('fullscreen')

# Define a callback to be called when you switch workspaces.
def on_workspace_focus(self, e):
    cava_check()

# Dynamically name your workspaces after the current window class
def on_window_new(i3, e):
    cava_check()

def on_window_close(i3, e):
    global instance
    if e.container.window_instance == instance:
        init_cava()
    else:
        cava_check()

def scratch_cava():
    global instance
    os.system('i3-msg \'[instance="'+instance+'"] move scratchpad\' >/dev/null 2>&1')

def show_cava(workspace):
    global instance
    os.system('i3-msg \'[instance="'+instance+'"] move workspace '+workspace+', floating disable, border pixel 0\' >/dev/null 2>&1')

def cava_check():
    target_workspace = ""
    for workspace in i3.get_workspaces():
        if workspace["output"] == monitor and workspace["visible"]:
               target_workspace = workspace["name"] 
    if target_workspace:
        for workspace in i3.get_tree().workspaces():
            if target_workspace == workspace.name:
                windows = workspace.leaves()
                active = False
                for window in windows:
                    global instance
                    if window.window_instance == instance:
                        active = True
          #      print(len(windows))
                print(active)
                if len(windows) == 0 and not active:
                    show_cava(target_workspace)
                    print("show")
#                 elif active and len(windows) > 1:
#                     scratch_cava()
                elif len(windows) > 1 and active:
                    print("hide")
                    scratch_cava()

# Subscribe to events
i3.on('window::new', on_window_new)
i3.on('window::close', on_window_close)
i3.on("workspace::focus", on_workspace_focus)

# Start Cava terminal
init_cava()

# Start the main loop and wait for events to come in.
i3.main()

