# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/addo2/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
alias pn="pnpm"
alias ptsh="poetry init --no-interaction && poetry shell"
alias pt="poetry"
alias cls="clear"
alias py="python3"
export PATH=$PATH:/bin:/usr/bin
export PATH=$PATH:~/.local/bin
export PATH="/etc/poetry/bin:$PATH"
. "/home/addo2/.deno/env"
source /home/addo2/.local/share/bash-completion/completions/deno.bash
eval "$(uv generate-shell-completion bash)"
alias uvi="uv init && uv venv && source .venv/bin/activate"
alias uvsh="source .venv/bin/activate"
alias any='/home/addo2/AnythingLLMDesktop/start'
alias pnn="pnpm create next app@latest"
alias pnv="pn create vite@latest"
alias pnd="pn i && pn dev"
alias all="rm -rf .[!.]* *"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias bunn="bun create next-app@latest --ts --app --src-dir --turbopack --use-bun --eslint --tailwind --skip-install --yes"
alias bund="bun install && bun --bun run dev"
alias bunv="bun create vite@latest"
alias buns="bun run build && bun run start"
alias buno="bun outdated"
alias bunu="bun update"
alias buna="bun add"
alias bux="bunx --bun"
alias bush="bunx --bun shadcn@latest"
alias buncn="bunx --bun nuxi@latest init --packageManager bun --gitInit"
alias bunma="bunx --bun nuxi@latest module add"


alias olr="ollama run llama3.2:1b"
export PATH="/home/addo2/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/addo2/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"


alias c='code -r'
alias w='windsurf -r'

alias space="find . -type d \( -name \".venv\" -o -name \".next\" -o -name \"node_modules\" \) -prune -exec du -sm {} \; 2>/dev/null | awk '
BEGIN {
    FS=\"\\t\";
    venv_count=0; next_count=0; node_modules_count=0;
    venv_size=0; next_size=0; node_modules_size=0;
    total_count=0; total_size=0
}
{
    size=\$1;
    split(\$2, a, \"/\");
    name=a[length(a)];
    if(name==\".venv\") {
        venv_count++;
        venv_size+=size
    } else if(name==\".next\") {
        next_count++;
        next_size+=size
    } else if(name==\"node_modules\") {
        node_modules_count++;
        node_modules_size+=size
    };
    total_count++;
    total_size+=size
}
function format_size(size) {
    if (size > 1000) {
        return sprintf(\"%.2fgb\", size / 1000.0)
    } else {
        return sprintf(\"%dmb\", size)
    }
}
END {
    printf \"%-20s space: %s\\n\", sprintf(\".venv: %d\", venv_count), format_size(venv_size);
    printf \"%-20s space: %s\\n\", sprintf(\".next: %d\", next_count), format_size(next_size);
    printf \"%-20s space: %s\\n\", sprintf(\"node_modules: %d\", node_modules_count), format_size(node_modules_size);
    printf \"%-20s space: %s\\n\", sprintf(\"Total: %d\", total_count), format_size(total_size)
}'"
# Hello world comment from original file
