#!/bin/bash

if ! command -v gum &> /dev/null; then
  echo "Error: Gum is not installed. Please install it from https://github.com/charmbracelet/gum."
  exit 1
fi

delete_sessions() {
  for session in "$@"; do
    echo "Deleting session: $session"
    zellij delete-session "$session"
  done
}

sessions=()

zellij_output=$(zellij ls | sed 's/\x1b\[[0-9;]*m//g')

while IFS= read -r line; do
  if [[ "$line" =~ ^([^\[]+)\s*\[([^\]]+)\] ]]; then
    session_name="${BASH_REMATCH[1]}"
    creation_time="${BASH_REMATCH[2]}"

    session_name=$(echo "$session_name" | xargs)
    sessions+=("$session_name | $creation_time")
  fi
done <<< "$zellij_output"

selected_sessions=$(printf '%s\n' "${sessions[@]}" | gum choose --no-limit --header "Select sessions to delete")

if [[ -n "$selected_sessions" ]]; then
  delete_list=()
  while IFS= read -r session; do
    delete_list+=("$(echo "$session" | cut -d '|' -f1 | xargs)")
  done <<< "$selected_sessions"

  if gum confirm "Delete these sessions?"; then
    delete_sessions "${delete_list[@]}"
  else
    echo "Cancelled"
  fi
fi
