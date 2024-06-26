#!/usr/bin/env zsh

local deps_list=(
	'SwitchAudioSource'
	'terminal-notifier'
)

local lock_file='/tmp/inputmute_lock'
mkdir "$lock_file" 2>/dev/null || { exit 0 }

function teardown() {
	rmdir "$lock_file" 2>/dev/null
}

trap 'teardown' EXIT INT

function check_deps() {
	[[ ${#@} != 0 ]] || { echo '[!] check_deps :: none passed' && exit 2 }

	local failed

	for dep in "$@"; do
		type "$dep" &>/dev/null || { echo "[!] No $dep installed" && failed=1 }
	done

	[[ -z $failed ]] || { exit 1 }
}

function main() {
	check_deps "${deps_list[@]}"

	terminal-notifier \
		-title 'InputMute' \
		-message "$(SwitchAudioSource -m toggle -t input)" 
}

main
