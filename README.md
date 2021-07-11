# Guide

## Introduction

[screen](https://www.gnu.org/software/screen/) is a great tool that makes it possible to manage terminal sessions all in one terminal tab. Power users may have found that switching between screen sessions involves a lot of typing over time.
`screen` first requires users to  `CTRL-a + D` to exit the current session and then `screen -r {MY_OTHER_SESSION}` to proceed to another session.
This repo provides several commands that allow users to quickly navigate between screen sessions from the terminal with less typing.

## Features
* No more manual exiting of the current session, it's done automatically.
* Shorter commands to jump into a new session. `si` and `ss` vs `screen -r`.
* Auto complete session names for you.
* Super fast `st` command to quickly jump back and forth between two sessions.
* Use interchangeably with native screen commands.

## Set Up
1. Download this repo `git clone git@github.com:scottxhe/switch-screen-session.git`.
2. Source the script by putting this line `source {YOUR_PATH}/switch-screen-session/screen-switch-session.sh`  in your `.bashrc`.
**Note**: For mac users, you would want to make sure that `.basrc` is sourced in `.profile` because each new `screen` tab or a new session seems to load `.profile`, as opposed to `.bashrc` on linux.


## Usage
### Commands
| Command  | Description |
| ------------- |:-------------:|
| ss      | start a session      |
| si      | switch to another session     |
| st      | toggle to the previous session     |
| sn      | print the current session name     |
| sls      | print all screen session names     |

#### Main Commands
##### ss
In order to switch to a different session, the current session has to be started by the `ss` command which accepts either a new session or an existing session, `ss {SESSION_NAME}`.

##### si
Once a session is started by `ss`, we can use `si` from the terminal of the current session to switch another session. `si {OTHER_SESSION_NAME}`. If that session does not yet exist, you can use the create option to create one before switching, `si -c {NEW_SESSION_NAME}`.

##### st
If you used `si` to switch to the current session from another session, the `st` command, with no argument required, will allow you to toggle between the two sessions.


**Note** You can exit the screen session with native screen commands. As mentioned above, this script should not interfere with your normal way of doing things inside `screen`.

### Maintenance
This script has been tested in Linux(Fedora 32), MacOS(Big Sur), and Windows 12(Git Bash), and It does aim to work across all linux and unix platforms. If you find any issues or have any questions, please feel free to reach out to me via email or create an issue in the Issues section. Thanks! 