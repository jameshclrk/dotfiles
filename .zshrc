# If tbsm is installed, launch a wayland session of sway
if type tbsm > /dev/null 2>&1; then
    if [[ $XDG_VTNR -le 2 ]]; then
        if [[ ! $XDG_SESSION_TYPE == "wayland" ]]; then
            tbsm 1
            exit
        fi
    fi
fi

# Windows BS
if [[ -f /proc/version ]]; then
    if grep --quiet Microsoft /proc/version; then
        # From agross/dotfiles@83b572
        if [[ "$(umask)" == '000' ]]; then
            umask 022
        fi
        # If using Windows and Docker is installed in WSL:
        # tell Docker that the host is a TCP port (to Windows) :)
        if type docker >/dev/null 2>&1; then
            export DOCKER_HOST=tcp://localhost:2375
        fi
    fi
fi

# Make sure zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug && \
        source ~/.zplug/init.zsh && \
        zplug update
else
    source ~/.zplug/init.zsh
fi

## begin zplug ##
zplug "zplug/zplug"
# Theme
zplug 'dracula/zsh', as:theme

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"

# For node
zplug "tj/n", use:"bin/n", as:command

# oh-my-zsh features
zplug "lib/completion", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh

# scripts
# cli fuzzy finder
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
# better diff interface
zplug "so-fancy/diff-so-fancy", as:command, use:"third_party/build_fatpack/diff-so-fancy"
# ping interface
zplug "denilsonsa/prettyping", as:command, use:"prettyping"
# tldr for man pages
zplug "dbrgn/tealdeer", as:command, from:gh-r, use:"*x86_64*", rename-to:tldr
# system monitor
zplug "cjbassi/gotop", as:command, from:gh-r, use:"*linux_amd64.tgz"
# Ultimate Plumber
zplug "akavel/up", as:command, from:gh-r, use:"*up"
# ls alternative
zplug "ogham/exa", as:command, from:gh-r, use:"*linux-x86_64*"
# find alternative
zplug "sharkdp/fd", as:command, from:gh-r, use:"*x86_64-unknown-linux-musl*"
# cat alternative
zplug "sharkdp/bat", as:command, from:gh-r, use:"*x86_64*linux-gnu*"
# grep alternative
zplug "BurntSushi/ripgrep", as:command, from:gh-r, use:"*x86_64*linux*"
# CSV cli toolkit
zplug "BurntSushi/xsv", as:command, from:gh-r, use:"*x86_64-unknown-linux*"

# Install plugins that are not installed
if ! zplug check --verbose; then
    zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load
## end zplug ##

# Misc zsh config
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

# Highlighting rules
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=240

alias ls='ls --color -lh --group-directories-first -N'

# most instead of less
if type most >/dev/null 2>&1; then
    export MANPAGER="most -s"
fi

if type vim >/dev/null 2>&1; then
    # use vim as editior
    export EDITOR="vim --"
fi

# Go
if [[ -d /usr/local/go ]]; then
    export PATH=/usr/local/go/bin:$PATH
    export PATH=$HOME/go/bin:$PATH
fi

# Cargo
if type cargo >/dev/null 2>&1; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PROMPT="%{$fg_bold[red]%}(%M) ${PROMPT}"
fi

autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn '\e]2;%1~\a'
}

function xterm_title_preexec () {
	print -Pn "\e]2;${(q)1}\a"
}

if [[ "$TERM" == (screen*|xterm*|rxvt*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# Machine specific
if [ -f ~/.zsh_machine ]; then
    . ~/.zsh_machine
fi

