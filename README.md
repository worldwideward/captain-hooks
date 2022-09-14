# Captain Hooks

Git hooks for DevOps Captains

## Pre-commit hooks

To start using these pre-commit hooks, save the file below as `.git/hooks/pre-commit` and make it executable.

```bash
#!/bin/bash
#
# link me to .git/hooks/
#
hooks_repo="https://raw.githubusercontent.com/worldwideward/captain-hooks/main"

scripts=(
"terraform.sh"
#"talisman.sh" - doesn't work yet :(
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
```
