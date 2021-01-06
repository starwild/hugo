---
title: "Emacs 使用精要"
date: 2018-03-16T11:36:43+08:00
draft: false
---
使用emacs的daemon模式快速使用emacsclient -nw 启动emacs
```bash
# alias emacs
alias emacsd='emacs --daemon'
alias e='emacsclient -t'
alias ec='emacsclient -c'

# run emacs daemon
[[ -z $(ps -C 'emacs --daemon' -o pid=) ]] && emacsd

# add kill emacs function
function kill-emacs(){
    emacsclient -e "(kill-emacs)"
    emacs_pid=$( ps -C 'emacs --daemon' -o pid= )
    if [[ -n "${emacs_pid}" ]];then
        kill -9 "${emacs_pid}"
    fi
}

```