# Captain Hooks

Git hooks for DevOps Captains

## Pre-commit hooks

To start using these pre-commit hooks, run the script `install-hook.sh` and follow the instructions.

**sample output**
```bash
./install-hook.sh 
Enter the path to your git repo (eg, /home/user/git/myproject ): /home/user/development/helm/chart
Enter the project type where the hook is installed (choose: docker|helm|terraform) helm
[INFO] Selected hook type: helm
[INFO] Hook successfully installed
```

## How it works

The install script will **copy** the script `hook.sh` to your git repository as `.git/hooks/pre-commit`.

If you already had an existing hook there, sorry but it will be overwritten.

The `hook.sh` script will be configured for your project "type" (helm, docker or terraform, for now). Essentially the install script just uncomments the script from the list:
```bash
scripts=(
#"docker.sh"
#"helm.sh"
#"terraform.sh"
)
```
From then on, everytime you try to commit in the git repository where the hook is installed, the pre-commit script is run, and your commit will be blocked upon failure.

This way you can check into CI/CD with increased confidence!
