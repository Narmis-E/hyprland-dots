#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}


export PS1="\[\e[36m\]\[\e[m\]\[\e[37m\] \[\e[m\]\[\e[37m\] \[\e[m\]\[\e[35m\]\W\[\e[m\]\[\e[37m\] \[\e[m\]\[\e[37m\]\`parse_git_branch\`\[\e[m\]\[\e[32m\]󰄾\[\e[m\]\[\e[37m\] \[\e[m\]"

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------
PATH=$PATH:~/.local/bin:/usr/local/bin/:/home/narmis/.cargo/bin
export VISUAL=nvim
export EDITOR="$VISUAL"

# sudo
alias sudo='sudo '

# cinny
alias cinny='~/Downloads/Cinny_desktop-x86_64.AppImage'

# nvim
alias v='nvim'
alias vh="nvim $HOME/.config/hypr/hyprland.conf"
alias vw="nvim $HOME/.config/waybar/config"
alias vf='vifm'
alias sv='sudoedit'

# dnf
alias d='dnf'
alias in='install'

# gomuks
alias g='gomuks'
# ls
TREE_IGNORE="cache|log|logs|node_modules|vendor"

# lazygit
alias lz='lazygit'

alias ls=' exa --group-directories-first --icons'
alias la=' ls -a --icons'
alias ll=' ls --git -l --icons'
alias lal='ls -a -l --icons'
alias lt=' ls --tree -D -L 2 -I ${TREE_IGNORE} --icons'
alias ltt=' ls --tree -D -L 3 -I ${TREE_IGNORE} --icons'
alias lttt=' ls --tree -D -L 4 -I ${TREE_IGNORE} --icons'
alias ltttt=' ls --tree -D -L 5 -I ${TREE_IGNORE} --icons'
################################################################################
neofetch
