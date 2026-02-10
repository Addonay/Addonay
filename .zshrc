# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/addo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

alias ls="lsd -1lFhL --header --group-dirs=first --date=relative --blocks=name,size,date --hyperlink=auto"
alias la="lsd -1lFhLA --header --group-dirs=first --date=relative --blocks=name,size,date --hyperlink=auto"
alias bat="bat -P"

eval "$(starship init zsh)"

eval "$(zoxide init zsh --cmd cd)"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# aliases
alias so="source ~/.zshrc"
alias oc="opencode"
alias cc="claude"
alias p="pwd | wl-copy"
alias -g c="| wl-copy"
alias cls="clear"
alias nz="nvim ~/.zshrc"
alias py="python3"
alias z='zed --add'
alias zz='z ~/.zshrc'
alias cj='uvsh \
  && uv add ipykernel \
  && jupyter kernelspec remove python3 -y \
  && rm -rf ~/.local/share/jupyter/kernels/python3 \
  && source .venv/bin/activate \
  && uv run python -m ipykernel install --user \
  && echo "Jupyter kernel for Python 3 has been set up with the current virtual environment"'

# does uv init, uv venv, activates, then same as cz
alias uvi='uv init \
  && uv venv \
  && source .venv/bin/activate \
  && uv add ipykernel \
  && cj \
  && mkdir -p .zed \
  && ln -sf "$(pwd)/.venv/bin/python" .zed/python \
  && echo .zed >> .gitignore'

alias uvsh="source .venv/bin/activate"
alias uva='uv add'
alias sp="du -sh * | sort -rh"
alias all="rm -rf -- * .[^.]*"
alias buna="bun add"
alias bux="bunx --bun"
alias bush="bunx --bun shadcn-svelte@latest"
alias bundo="bun install && bun run dev --open"
alias bunad="bun add -d"
alias bunag="bun add -g"
alias bund="bun i && bun run dev"
alias bunc="bunx convex dev"
alias bunsha="bux shadcn-svelte@latest add"
# functions
mkdirp() {
  mkdir -p "$1" && cd "$1"
}

gp() {
    git add . &&
    git commit -m "$1" &&
    git push
}
gc() {
    git add . &&
    git commit -m "$1"
}

bunsv() {
  if [ -z "$1" ]; then
    echo "Error: Please provide a project name as an argument"
    return 1
  fi
  bux sv create --template minimal --types ts --install bun "$1" \
    && cd "$1" \
    && git init \
    && git add -A \
    && git commit -m 'Initial commit'
  echo "SvelteKit project '$1' has been successfully created"
}

# Disk‐usage summary (your custom awk function)
alias space="find . -type d \( -name \".venv\" -o -name \".next\" -o -name \"node_modules\" -o -name \".svelte-kit\" \) -prune -exec du -sm {} \; 2>/dev/null | awk '
BEGIN {
    FS=\"\\t\";
    venv_count=0; next_count=0; node_modules_count=0; svelte_kit_count=0;
    venv_size=0; next_size=0; node_modules_size=0; svelte_kit_size=0;
    total_count=0; total_size=0;
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
    } else if(name==\".svelte-kit\") {
        svelte_kit_count++;
        svelte_kit_size+=size
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
    printf \"%-20s space: %s\\n\", sprintf(\".svelte-kit: %d\", svelte_kit_count), format_size(svelte_kit_size);
    printf \"%-20s space: %s\\n\", sprintf(\"Total: %d\", total_count), format_size(total_size)
}'"

export NODE_OPTIONS="--max-old-space-size=1536"


# bun completions
[ -s "/home/addo/.bun/_bun" ] && source "/home/addo/.bun/_bun"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/addo/.lmstudio/bin"
# End of LM Studio CLI section

# pnpm
export PNPM_HOME="/home/addo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
# export PATH="/opt/zig-master:$PATH"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source /home/addo/.daytona.completion_script.zsh
export KAGGLE_API_TOKEN="KGAT_44a763b8070402e1d3fe6c424c6c9fdb"
