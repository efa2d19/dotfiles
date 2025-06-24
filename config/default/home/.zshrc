# -- P10K --
[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && {
    # Instant sticky
    printf "\e[H\e[${LINES}B"
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
}

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
setopt EXTENDED_GLOB

plugins=(
    command-not-found
    evalcache
    extract
    git
    history
    history-substring-search
    magic-enter
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# -- Sticky prompt on precmd --
function make_prompt_bottom_sticky() {
    printf "\e[${LINES}B"
}
add-zsh-hook precmd make_prompt_bottom_sticky

# -- Custon clear keybind --
function custom_clear() {
    printf "\e[H\e[2J\e[${LINES}B"
    zle .reset-prompt
    zle -R
    printf '\e[3J'
}
zle -N custom_clear
bindkey '^L' custom_clear

# -- viins --
bindkey -M viins '^[^?' backward-kill-word
bindkey -M viins '^[b' backward-word
bindkey -M viins '^[f' forward-word

# -- Plugins settings --

## vi-mode
VI_MODE_SET_CURSOR=true

## magic-enter
MAGIC_ENTER_GIT_COMMAND='gst -u no'
MAGIC_ENTER_OTHER_COMMAND='l'

# -- Custom aliases --

## ls
alias l='eza -lagoL 3 --no-git --no-permissions --smart-group --color-scale=size'
alias lg='eza -lagoL 3 --git --no-permissions --smart-group --color-scale=size'

## JAVA_HOME change
alias java@list='/usr/libexec/java_home -V'

## Brew
alias brew@upd='brew cu -af --cleanup --include-mas && brew upgrade'
alias brew@dump='brew bundle dump --formula --tap --force --file="${HOME}/.brewfile"; brew bundle dump --cask --mas --force --file="${HOME}/.caskfile"'
alias brew@cleanup='brew bundle --cleanup --force --file <(cat "${HOME}/.brewfile" "${HOME}/.caskfile")'

## Misc
alias resetComp='rm ~/.zcompdump*; compinit'

## Git
alias glg='git lgs'
alias glgs='git logs'
alias 'gp!'='gp --no-verify'
alias 'gpf!'='gpf --no-verify'
alias gbc='git_current_branch | tr "\n" "\0" | tee "$(tty)" | clipcopy'
alias git@prune='git fetch --prune && git branch -vv | awk "/: gone]/ && !/^\*/ {print \$1}" | xargs -r git branch -D'

## fzf
alias fzf_='fzf --preview-window "right:$(( $(tput cols) / 4 * 3 )):border-vertical" --bind "ctrl-\\:change-preview-window($(( $(tput cols) / 5 ))|$(( $(tput cols) / 4 * 3 )))"'

# -- Eval stuff --
_evalcache zoxide init zsh --cmd=cd
_evalcache fzf --zsh

# -- Extensions --
for ext in "$HOME"/.zshrc*.ext; do source "$ext"; done 2>/dev/null

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
