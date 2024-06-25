# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# -- Custom exports --
export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME="$(/usr/libexec/java_home -v 17)"

# -- Custom PATH mod --
## Brew stuff
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/node@20/bin${PATH+:$PATH}"
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/python@3.12/bin${PATH+:$PATH}"
export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin${PATH+:$PATH}"

## Python 2.X
export PATH="$HOME/.pyenv/versions/2.7.18/bin${PATH+:$PATH}"

## Android platform tools
export PATH="${ANDROID_HOME:-$ANDROID_SDK_ROOT}/emulator${PATH+:$PATH}"
export PATH="${ANDROID_HOME:-$ANDROID_SDK_ROOT}/platform-tools${PATH+:$PATH}"

## Jetbrains toolbox
export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts${PATH+:$PATH}"

## local/bin
export PATH="$HOME/.local/bin${PATH+:$PATH}"

# -- Extensions --
for ext in "$HOME"/.zprofile*.ext; do source "$ext"; done 2>/dev/null
