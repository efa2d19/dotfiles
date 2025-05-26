# -- Homebrew --
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1

# -- Custom exports --
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
export GPG_TTY="$(tty)"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME="$(/usr/libexec/java_home -v 21)"

## magic-enter
MAGIC_ENTER_GIT_COMMAND='gst -u no'
MAGIC_ENTER_OTHER_COMMAND='l'

## Secretive
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

## fzf search w/ hidden files
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --no-ignore-vcs --follow --exclude .git --exclude .DS_Store'

## Compilation flags
# export ARCHFLAGS="-arch x86_64"

# -- Custom PATH mod --

## Brew stuff
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/coreutils/libexec/gnubin${PATH+:$PATH}"
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/node/bin${PATH+:$PATH}"
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/python3/bin${PATH+:$PATH}"
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin${PATH+:$PATH}"

## Android platform tools
export PATH="${ANDROID_HOME:-$ANDROID_SDK_ROOT}/emulator${PATH+:$PATH}"
export PATH="${ANDROID_HOME:-$ANDROID_SDK_ROOT}/platform-tools${PATH+:$PATH}"

## local/bin
export PATH="$HOME/.local/bin${PATH+:$PATH}"

# -- Extensions --
for ext in "$HOME"/.zprofile*.ext; do source "$ext"; done 2>/dev/null
