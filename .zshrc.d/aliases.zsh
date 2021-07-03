alias monitors='xrandr -q | grep " connected" | cut -d ' ' -f1'

alias fname="fc-query -f '%{family[0]}\n'"

alias rmdirs="find ./* -maxdepth 0 -type d | sudo xargs rm -rf"
alias mkzips="find ./* -maxdepth 0 -type d | xargs -I{} zip -r {}.zip {}"
alias unzips="find ./* -maxdepth 0 -name \*.zip | xargs -I{} unzip {} -d ."
alias rmzips="find ./* -maxdepth 0 -name \*.zip | xargs rm -rf"

alias grepcmd='echo ${(k)aliases} ${(k)builtins} $(ls /bin) | sed -e "s/\s\+/\n/g" | grep -i'

alias del='_del(){ mv "$1" ~/.trash}; _del'

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dotfiles-add="dotfiles ls-files | xargs -I{} git --git-dir=$HOME/.dotfiles --work-tree=$HOME add {}"

alias tmuxk="tmux ls | grep : | cut -d. -f1 | awk '{print substr(\$1, 0, length(\$1)-1)}' | xargs kill"

alias lblk="lsblk -f -o name,fstype,size,label,mountpoint,uuid"

alias git-log="git log --graph --full-history --all --color --pretty=format:'%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s'"

alias sudo="sudo "
alias dus="du -sh * | sort -rh"
