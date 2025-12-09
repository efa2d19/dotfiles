# -- Settings --

## smoother rendering
POSTEDIT=$'\n\n\e[2A'

## autoupdate
zstyle ':z4h:' auto-update      'no'
zstyle ':z4h:' auto-update-days '14'

## prompt
zstyle ':z4h:' start-tmux command tmux -u new -A -D -t zsh
zstyle ':z4h:' prompt-at-bottom 'yes'

## misc
zstyle ':z4h:' term-shell-integration      'yes'
zstyle ':z4h:bindkey' keyboard             'mac'
zstyle ':z4h:autosuggestions' forward-char 'accept'
zstyle ':z4h:fzf-complete' recurse-dirs    'no'

## direnv integration
zstyle ':z4h:direnv' enable 'no'

## ssh teleportation
zstyle ':z4h:ssh:*' enable  'no'

# -- Install custom --
z4h install ohmyzsh/ohmyzsh || return
z4h install hlissner/zsh-autopair || return

# -- Init --
z4h init || return

# -- Custom path --
path=(
    ~/.local/bin
    ## brew stuff
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/node/bin
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/python3/bin
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin
    ## gnu
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/coreutils/libexec/gnubin
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/gnu-tar/libexec/gnubin
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/grep/libexec/gnubin
    ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/gawk/libexec/gnubin
    ## adb
    ${ANDROID_HOME:-$ANDROID_SDK_ROOT}/emulator
    ${ANDROID_HOME:-$ANDROID_SDK_ROOT}/platform-tools
    $path
)

# -- Custom exports --
export GPG_TTY="$(tty)"
export HOMEBREW_NO_ANALYTICS=1
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME="$(/usr/libexec/java_home -v 21)"

## Secretive
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

## fzf search w/ hidden files
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --no-ignore-vcs --follow --exclude .git --exclude .DS_Store'

## fzf preview scroll binds
export FZF_DEFAULT_OPTS='--bind ctrl-alt-k:preview-up,ctrl-alt-j:preview-down'

# -- Plugins settings --

## magic-enter
MAGIC_ENTER_GIT_COMMAND='gst -u no'
MAGIC_ENTER_OTHER_COMMAND='l'

# -- Plugins --
z4h load hlissner/zsh-autopair
z4h load ohmyzsh/ohmyzsh/plugins/magic-enter
z4h load ohmyzsh/ohmyzsh/plugins/git
z4h source ohmyzsh/ohmyzsh/lib/git.zsh
z4h source ohmyzsh/ohmyzsh/lib/clipboard.zsh

# -- Keybinds --
z4h bindkey z4h-cd-back     Option+H   # cd into the previous directory
z4h bindkey z4h-cd-forward  Option+L   # cd into the next directory
z4h bindkey z4h-cd-up       Option+K   # cd into the parent directory
z4h bindkey z4h-cd-down     Option+J   # cd into a child directory
z4h bindkey z4h-accept-line Enter      # newline instead PS2
z4h bindkey z4h-eof Ctrl+D             # transient prompt ssh

# -- Autoload functions --
autoload -Uz zmv

# -- Custom aliases --

## sudo
alias _='sudo'

## ls
alias l='eza -lagoL 3 --no-git --no-permissions --smart-group --color-scale=size'
alias lg='eza -lagoL 3 --git --no-permissions --smart-group --color-scale=size'

## JAVA_HOME
alias java@list='/usr/libexec/java_home -V'

## brew
alias brew@upd='brew cu -af --cleanup && brew upgrade'
alias brew@dump='brew bundle dump --formula --tap --force --file="${HOME}/.brewfile"; brew bundle dump --cask --mas --force --file="${HOME}/.caskfile"'
alias brew@cleanup='brew bundle --cleanup --force --file <(cat "${HOME}/.brewfile" "${HOME}/.caskfile")'

## misc
alias resetComp='rm ~/.zcompdump*; compinit'

## git
alias glg='git lgs'
alias glgs='git logs'
alias 'gp!'='gp --no-verify'
alias 'gpf!'='gpf --no-verify'
alias gbc='git_current_branch | tee "$(tty)" | tr "\n" "\0" | clipcopy'
alias git@prune='git fetch --prune && git branch -vv | awk "/: gone]/ && !/^\*/ {print \$1}" | xargs -r git branch -D'

## fzf
alias fzf_='fzf --preview-window "right:$(( $(tput cols) / 4 * 3 )):border-vertical" --bind "ctrl-\\:change-preview-window($(( $(tput cols) / 5 ))|$(( $(tput cols) / 4 * 3 )))"'

# -- zsh setting --

## default
setopt glob_dots
setopt no_auto_menu

## transient prompt ssh
setopt ignore_eof

## custom
setopt nullglob
setopt extended_glob
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups

# -- Extensions --
for ext in "$HOME"/.zshrc*.ext; do z4h source "$ext"; done 2>/dev/null
