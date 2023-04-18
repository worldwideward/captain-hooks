#!/bin/bash

function requestDirectoryPathFromUser() {

	read -p "Enter the path to your git repo (eg, /home/user/git/myproject ): " repository_path

	while [ -z "$repository_path" ]; do

		read -p "Enter the path to your git repo (eg, /home/user/git/myproject ): " repository_path
	done

	while [ ! -d "$repository_path" ]; do

		echo "[ERROR] This is not a valid directory path"
		echo " "
		read -p "Enter the path to your git repo (eg, /home/user/git/myproject ): " repository_path
	done
}

function requestHookType() {

	while [ -z "$hook_type" ]; do
	
		read -p "Enter the project type where the hook is installed (choose: docker|helm|terraform) " hook_type

		case $hook_type in

			docker|helm|terraform)
				echo "[INFO] Selected hook type: $hook_type"
				;;
			*)
				echo "[ERROR] Hook type not recognized"
				hook_type=""
				;;
		esac
	done
}

function installHook() {

	directory_path=$1
	hook_type="$2.sh"

	pre_commit_hook="$directory_path/.git/hooks/pre-commit"

	hook_file="$PWD/hook.sh"
	
	if [ ! -d $pre_commit_hook ]; then

		cp $hook_file $pre_commit_hook
		sed -i 's/^#"'$hook_type'"/"'$hook_type'"/' $pre_commit_hook
		echo "[INFO] Hook successfully installed"
	else
		rm $pre_commit_hook
		cp $hook_file $pre_commit_hook
		sed -i 's/^#"'$hook_type'"/"'$hook_type'"/' $pre_commit_hook
		echo "[INFO] Hook successfully installed"
	fi
}

requestDirectoryPathFromUser

requestHookType

installHook $repository_path $hook_type
