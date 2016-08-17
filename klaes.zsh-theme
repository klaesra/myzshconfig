#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell:
#	 * One line.
#	 * VCS info on the right prompt.
#	 * Only shows the path on the left prompt by default.
#	 * Crops the path to a defined length and only shows the path relative to
#		 the current VCS repository root.
#	 * Wears a different color wether the last command succeeded/failed.
#	 * Shows user@hostname if connected through SSH.
#	 * Shows if logged in as root or not.
# ------------------------------------------------------------------------------

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END=%3{'☠ ❯'%}
PROMPT_ROOT_END=❯❯❯
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]

# Set required options.
setopt promptsubst
setopt prompt_subst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Function getting second to last dir level
function second_to_last_level() {
	if [ $(git rev-parse --git-dir 2> /dev/null) ]; then
		cur_repo=$(git rev-parse --show-toplevel | rev | cut -d"/" -f 2 | rev)" "
	else
		cur_repo=""
	fi
}

# Add hook for calling second_to_last_level before each command.
add-zsh-hook precmd second_to_last_level

# Function checking for a .nvmrc file
function nvmrcExists() {
	if [ -f .nvmrc ]; then
		if [[ ! (`node -v` == *`cat .nvmrc`*) ]] ; then
			print -P $FG[128]
			nvm use
		fi
	fi
}

# Add hook for calling nvmrcExists before each command.
add-zsh-hook precmd nvmrcExists

# Add ls call to every cd command
function chpwd() {
	emulate -L zsh
	ls
}

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r "
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b (%a) "
# zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b "

# Define prompts.
PROMPT="
[%*] %{$FX[reset]%}%{$FG[034]%}"'$cur_repo'"%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}%{$fg[yellow]%}"'${vcs_info_msg_0_}'"
%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
