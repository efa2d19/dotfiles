# -- Remove last login --
printf '\33c\e[3J'

# -- P10K --
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME='powerlevel10k/powerlevel10k'

# zstyle ':omz:update' mode disabled
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# -- zsh setting --
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt NULLGLOB

plugins=(
	evalcache
	git
	magic-enter
	colored-man-pages
	extract
	command-not-found
	history
	history-substring-search
	thefuck
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# -- Custom aliases --

## ls
alias l='eza -lagoL 3 --no-git --no-permissions --smart-group --color-scale=size'
alias lg='eza -lagoL 3 --git --no-permissions --smart-group --color-scale=size'

## JAVA_HOME change
alias java@list='/usr/libexec/java_home -V'
alias java@11='export JAVA_HOME="$(/usr/libexec/java_home -v 11)"'
alias java@17='export JAVA_HOME="$(/usr/libexec/java_home -v 17)"'

## Node change
alias node@20='export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/node@20/bin${PATH+:$PATH}"'
alias node@21='export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/node@21/bin${PATH+:$PATH}"'
alias node@latest='export PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/node/bin${PATH+:$PATH}"'

## Brew
alias brew@upd='brew cu -af --cleanup --include-mas && brew upgrade'
alias brew@dump='brew bundle dump --force'

## MacOS dock stuff
alias dock@reset='defaults write com.apple.dock tilesize -int 60 && killall Dock'
alias dock@lock='defaults write com.apple.dock size-immutable -bool yes && killall Dock'
alias dock@unlock='defaults write com.apple.dock size-immutable -bool no && killall Dock'
alias dock@noanim='defaults write com.apple.dock workspaces-swoosh-animation-off -bool yes'
alias dock@anim='defaults write com.apple.dock workspaces-swoosh-animation-off -bool no'

## adb
alias adb@url='adb wait-for-device && adb shell am start -a android.intent.action.VIEW -d "$(clippaste)"'
alias adb@control='scrcpy -Stw --render-driver=metal --rotation=0 --window-y=00 --window-x=2056 --max-fps=60 --no-audio --power-off-on-close --disable-screensaver &>/dev/null & disown'

alias adb@proxy='adb wait-for-device && adb shell settings put global http_proxy $(ipconfig getifaddr en0):9100'
alias adb@unproxy='adb wait-for-device && adb shell settings put global http_proxy :0'

alias adb@layout='adb wait-for-device && { adb shell setprop debug.layout true && adb shell service call activity 1599295570 }'
alias adb@unlayout='adb wait-for-device && { adb shell setprop debug.layout false && adb shell service call activity 1599295570 }'

alias adb@noanim='adb wait-for-device && { adb shell settings put global window_animation_scale 0; adb shell settings put global transition_animation_scale 0; adb shell settings put global animator_duration_scale 0 }'
alias adb@anim='adb wait-for-device && { adb shell settings put global window_animation_scale 1; adb shell settings put global transition_animation_scale 1; adb shell settings put global animator_duration_scale 1 }'

## Emulator
alias android='emulator @phone -feature -Vulkan &>/dev/null & disown'
alias android@writable='emulator @phone -writable-system -feature -Vulkan &>/dev/null & disown'
alias android@bg='emulator @phone -writable-system -feature -Vulkan -no-window -no-audio &>/dev/null & disown'

## Misc
alias studio@here='studio "$(pwd)"'
alias resetComp='rm ~/.zcompdump*; compinit'

## Git
alias glg='git lgs'
alias glgs='git logs'
alias 'gp!'='gp --no-verify'
alias 'gpf!'='gpf --no-verify'
alias gbc='git_current_branch | tr "\n" "\0" | tee /dev/tty | clipcopy'
alias gai='ga -i'
alias git@update='git fetch --all &>/dev/null && git pull --all &>/dev/null && for remote in "$(git branch -r)"; do if [[ $remote != "->" ]]; then git branch --track "${remote#origin/}" "$remote" 2>&/dev/null; fi; done'
alias git@prune='git fetch --prune && git branch -vv | awk "/: gone]/ && !/^\*/ {print \$1}" | xargs -r git branch -D'

## Misc
alias bat='f() { command bat "$@" 2>/dev/null; [[ $? == 0 ]] || { bati "$@" }; return "$?" }; f'
alias agi='f() { ag --nobreak --noheading "$1" | fzf --delimiter : --with-nth 1,2 --preview="bat --style=numbers --color=always {1} --highlight-line {2}" }; f'

#  -- Custom exports --
export EDITOR='micro'
export GPG_TTY="$(tty)"
export HOMEBREW_BUNDLE_FILE='.brewfile'

## magic-enter
MAGIC_ENTER_GIT_COMMAND='gst -u no'
MAGIC_ENTER_OTHER_COMMAND='l'

## Secretive
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"

## fzf search w/ hidden files
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --no-ignore-vcs --follow --exclude .git --exclude .DS_Store'

## Compilation flags
# export ARCHFLAGS="-arch x86_64"

# -- Eval stuff --
_evalcache zoxide init zsh --cmd=cd
_evalcache thefuck --alias

# -- Extensions --
for ext in "$HOME"/.zshrc*.ext; do source "$ext"; done 2>/dev/null

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
