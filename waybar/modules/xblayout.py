#!/usr/bin/env -S python3 -u
# vi:syntax=python


import os
import signal

import i3ipc

pri_layout_code = "EN"
sec_layout_code = "AR"
sec_layout_name = "arabic"
input_event_change = "xkb_layout"

sway_sock_path = os.environ["SWAYSOCK"]
sway = i3ipc.Connection(socket_path=sway_sock_path, auto_reconnect=False)


def on_posix_signal(sig, frame):
    sway.main_quit()


signal.signal(signal.SIGHUP, on_posix_signal)
signal.signal(signal.SIGINT, on_posix_signal)
signal.signal(signal.SIGQUIT, on_posix_signal)
signal.signal(signal.SIGTERM, on_posix_signal)

# print the primary layout as it's the default
print(pri_layout_code)


def on_input_change(conn, event):
    if event.change != input_event_change:
        return
    if event.input.xkb_active_layout_name.lower() == sec_layout_name:
        print(sec_layout_code)
    else:
        print(pri_layout_code)


def on_shutdown_or_reload(conn, event):
    conn.main_quit()


sway.on(i3ipc.Event.INPUT, on_input_change)
sway.on(i3ipc.Event.SHUTDOWN, on_shutdown_or_reload)
sway.on(i3ipc.Event.SHUTDOWN_EXIT, on_shutdown_or_reload)
sway.on(i3ipc.Event.SHUTDOWN_RESTART, on_shutdown_or_reload)
sway.on(i3ipc.Event.BARCONFIG_UPDATE, on_shutdown_or_reload)
sway.main()
