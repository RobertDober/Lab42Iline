#!/usr/bin/env zsh

export session_name=Lab42VimBaseTools
export home_dir=${Lab42VimBaseTools:-~/.vim/bundle/Lab42VimBaseTools}

function main {
        new_session
        new_window vim
        open_vi $home_dir
        send_keys ':colorscheme github'

        new_window 'vi autoload'
        open_vi 'autoload' ':set background=dark' ':colorscheme solarized'

        new_window test
        send_keys './vimtest'

        new_window 'vi test'
        open_vi test

        new_window etc
}

source ~/bin/tmux/tmux-commands.zsh
