peco_select_history() {
  local selected_history

  if command -v tac >/dev/null 2>&1; then
    selected_history=$(fc -l -n 1 | tac | peco --query "$LBUFFER")
  else
    selected_history=$(fc -l -n 1 | tail -r | peco --query "$LBUFFER")
  fi

  if [[ -n "$selected_history" ]]; then
    BUFFER="$selected_history"
    CURSOR=${#BUFFER}
  fi

  zle clear-screen
}

zle -N peco_select_history
bindkey '^r' peco_select_history

peco-src() {
  local selected_dir

  selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [[ -n "$selected_dir" ]]; then
    BUFFER="cd ${(q)selected_dir}"
    zle accept-line
  fi

  zle clear-screen
}

zle -N peco-src
bindkey '^]' peco-src
