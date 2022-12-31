#!/bin/bash

HOSTNAME=""

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
PURPLE=$(tput setaf 13) 
NC=$(tput sgr0)

# Custom prompt
parse_git_branch() {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ "$branch" == "" ]]; then
    echo ""
  else
    echo -e " \001${CYAN}\002($branch)\001${NC}\002"
  fi
}

exit_code() {
  if [[ "$?" == "0" ]]; then
    echo -e "\001${GREEN}\002✔\001${NC}\002"
  else
    echo -e "\001${RED}\002✘\001${NC}\002"
  fi
}

hostname() {
  if [[ "$HOSTNAME" == "" ]]; then
    echo ""
  else
    echo -e " \001${PURPLE}\002[${HOSTNAME}]\001${NC}\002"
  fi
}

export PS1="\$(exit_code)\$(hostname) \W\$(parse_git_branch) ✗ "

