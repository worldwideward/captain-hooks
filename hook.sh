#!/bin/bash

# Main hook
#
# link me to .git/hooks/
#

hooks_repo="https://raw.githubusercontent.com/worldwideward/captain-hooks/main"

# Uncomment the required script for your repository
#
scripts=(
#"docker.sh"
#"helm.sh"
#"terraform.sh"
)

echo "[INFO] Pre-commit checks"

exit_code=0

for script in ${scripts[@]}; do

	curl -s $hooks_repo/$script > $script && chmod +x $script
	./$script
	exit_code=$(($exit_code + $?))
	rm $script
done

if [ "$exit_code" -eq 0 ]; then

	echo "[INFO] Checks successful"
	exit 0
else
	echo "[ERROR] Check exited with code $exit_code"
	exit $exit_code
fi
