# Guide

## Introudction

`screen` is a great tool that makes it possible to manage tabs and sessions all in one terminal window. Power users may find that switching between screen sessions involes a lot of typing.
`screen` requires users to  `CTRL-a + D`  first to exit the current session and then `screen -r {MY_OTHER_SESSION}` to proceed to another session.
This repo provides serveral commands that allow users to quickly navigate between screen sessions from the terminal.
## Set Up
1. Download this repo `git clone git@github.com:scottxhe/switch-screen-session.git`.
2. Source the script by putting this line `source {YOUR_PATH}/switch-screen-seesion/screen-switch-session.sh`  in your `.bashrc`.
**Note**: For mac users, you would want to make sure that `.basrc` is sourced in `.profile` because each new `screen` tab or a new session seems to load `.profile`, as opposed to `.bashrc` on linux.

## Usage
### Commands
| Command  | Description |
| ------------- |:-------------:|
| ss      | start a session      |
| si      | switch to another session     |
| st      | toggle to the previous seesion     |
| sn      | print the current session name     |
| sls      | print all screen session names     |

#### Main Commands
##### ss
In order to swith to a different session, the current session has to be started by the `ss` command which accpet either a new session or an existing session, `ss {SESSION_NAME}`.

##### si
Once a session is opend by `ss`, we can use `si` from the terminal of the current session to switch another session. `si {OTHER_SESSION_NAME}`. If that session does not yet exist, you can use the create option to create one before switching, `si -c {NEW_SESSION_NAME}`.

##### st
If you used `si` to switch to the current session from another session, the `st` command with no arugment will allow you to toggle between the two sessions.


**Note** You can exit the screen session with native screen commands. As mentioned above, this sript should not interfare with your normal way of doing things inside `screen`.