# Guide

## Introduction

In order to switch screen session with native commands, `screen` first requires `CTRL-a + d` to exit the current session and then `screen -r {MY_OTHER_SESSION}` to proceed to another session.
This repo provides a couple of commands that allows users to quickly navigate screen sessions from the terminal.

## Features
* No manual exiting required.
* Auto complete session names for you.
* Toggle sessions.

## Set Up
1. Download this repo `git clone git@github.com:scottxhe/switch-screen-session.git`.
2. Source the script by putting this line `source {YOUR_PATH}/switch-screen-session/screen-switch-session.sh`  in your `.bashrc`.
**Note**: For mac users, you would want to make sure that `.basrc` is sourced in `.profile` because each new `screen` tab or a new session seems to load `.profile`, as opposed to `.bashrc` on linux.


## Usage
### Commands
| Command  | Description |
| ------------- |:-------------:|
| ss      | switch to a session or start a new session     |
| st      | toggle to the previous session     |

### Examples
##### Start screen with a new or an exiting session
`ss my-session`


##### Switch to a new or an existing session from the current screen session
`ss my-other-session`

##### Go to the previous session
`st`

##### List all sessions
`ss` this is a shortcut to `screen -ls`

**Note:** You can exit screen with native screen commands.

## Contact
Please feel free to contact me for anything regarding this functionaity. 
