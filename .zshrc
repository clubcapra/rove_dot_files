
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
key[Control-Backspace]="^H"
key[Control-Delete]="^[[3;5~^[[3;5~"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"   ]] && bindkey -- "${key[Control-Left]}"   backward-word
[[ -n "${key[Control-Right]}"  ]] && bindkey -- "${key[Control-Right]}"  forward-word
[[ -n "${key[Control-Backspace]}"  ]] && bindkey -- "${key[Control-Backspace]}"  backward-kill-word
[[ -n "${key[Control-Delete]}"  ]] && bindkey -- "${key[Control-Delete]}"  kill-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# The following lines were added by compinstall

# zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
autoload -Uz promptinit
promptinit
prompt fire red white red black

. ~/.bash_aliases
#if [[ -f "/home/nvidia/.rove_aliases" ]]; then
#	. /home/nvidia/.rove_aliases
#	echo Rove aliases sourced
#fi
. ~/.rove_aliases
echo Rove aliases sourced

function editalias() {
    if [[ $# -eq 0 ]]; then
        cp ~/.bash_aliases ~/.bash_aliases.bkp
        nano ~/.bash_aliases
        . ~/.bash_aliases
        echo "Use 'editalias -r' to revert."
    elif [[ $1 = "-h" ]]; then
        echo "editalias [-h|-r]"
        echo "-h : Help"
        echo "-r : Revert"
    elif [[ $1 = '-r' ]]; then
        mv -i ~/.bash_aliases.bkp ~/.bash_aliases
		. ~/.bash_aliases
    fi
}

function roveedit() {
    if [[ $# -eq 0 ]]; then
	if [[ -f ~/.rove_aliases ]]; then
            cp ~/.rove_aliases ~/.rove_aliases.bkp
        fi
        nano ~/.rove_aliases
        . ~/.rove_aliases
        echo "Use 'roveedit -r' to revert."
    elif [[ $1 = "-h" ]]; then
        echo "roveedit [-h|-r|-c]"
        echo "-h : Help"
        echo "-r : Revert"
    elif [[ $1 = '-r' ]]; then
        mv -i ~/.rove_aliases.bkp ~/.rove_aliases
	. ~/.rove_aliases
	rm -f ~/.rove_aliases.bkp
    fi
}

function editzsh() {
    if [[ $# -eq 0 ]]; then
        cp ~/.zshrc ~/.zshrc.bkp
        nano ~/.zshrc
        . ~/.zshrc
        echo "Use 'editzsh -r' to revert"
    elif [[ $1 = "-h" ]]; then
        echo "editalias [-h|-r]"
        echo "-h : Help"
        echo "-r : Revert"
    elif [[ $1 = '-r' ]]; then
        mv -i ~/.zshrc.bkp ~/.zshrc
        . ~/.zshrc
        rm -f ~/.zshrc.bkp
    fi
}


