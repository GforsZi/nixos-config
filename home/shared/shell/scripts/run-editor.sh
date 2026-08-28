#!/usr/bin/env zsh

open_nvim() {
  eval nvim </dev/tty
  zle redisplay
}

zle -N open_nvim
bindkey '^E' open_nvim
