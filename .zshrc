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

setopt HIST_IGNORE_ALL_DUPS
bindkey -e
setopt CORRECT
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
WORDCHARS=${WORDCHARS//[\/]}
zstyle ':zim:git' aliases-prefix 'g'
zstyle ':zim:input' double-dot-expand yes
zstyle ':zim:termtitle' format '%1~'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=240'

# most instead of less
if type most >/dev/null 2>&1; then
    export MANPAGER="most -s"
fi


if type nvim >/dev/null 2>&1; then
    # use nvim as editior
    export EDITOR="nvim --"
    alias vim=nvim
else
    if type vim >/dev/null 2>&1; then
        # use vim as editior
        export EDITOR="vim --"
    fi
fi

# Go
if [[ -d /usr/local/go ]]; then
    export PATH=/usr/local/go/bin:$PATH
fi

if type go >/dev/null 2>&1; then
    export PATH="$HOME/go/bin:$PATH"
    export GOPROXY=direct
fi

# Cargo
if type cargo >/dev/null 2>&1; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi


if [[ -d $HOME/.local/bin ]]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# Machine specific
if [ -f ~/.zsh_machine ]; then
    . ~/.zsh_machine
fi

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

if type thefuck &>/dev/null; then
    eval $(thefuck --alias huh)
fi

fpath+=~/.zfunc

# ------------------
# Initialize modules
# ------------------

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  # Download zimfw script if missing.
  command mkdir -p ${ZIM_HOME}
  if (( ${+commands[curl]} )); then
    command curl -fsSL -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    command wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export PATH="$HOME/.poetry/bin:$PATH"
