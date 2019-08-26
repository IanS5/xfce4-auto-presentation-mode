# xfce4-auto-presentation-mode.sh

Enable XFCE's presentation mode (i.e. don't sleep or dim the screen) when the active window is full screen.

## Usage

`./xfce4-auto-presentation-mode.sh`

No arguments required!
Usually you want to run this script in the background.
The best way to do this is to start it with XFCE on login, by adding "/bin/bash /path/to/xfce4-auto-presentation-mode.sh" to your startup applications.

see: [XFCE4 Session - Application Autostart](https://docs.xfce.org/xfce/xfce4-session/preferences#application_autostart)

## Required Applications

Aside from coreutils, the only requirements are `xprop` and `xfconf-query`.
If your system can run XFCE, you probably have the necessary applications to run this script.
The full list of applications, with tested version:

- head (tested: (GNU coreutils) 8.31)
- xfconf-query (tested: 4.14.1)
- grep (tested: (GNU grep) 3.3)
- xprop (tested: 1.2.4)

## Shells

xfce4-auto-presentation-mode.sh should work on any POSIX compliant shell.
It has been tested on

- zsh (tested: 5.7.1 (x86_64-pc-linux-gnu))
- bash (tested:  5.0.7 (x86_64-pc-linux-gnu))