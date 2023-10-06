# Make working with conda and poetry easier!

This script automates the setup of development environments where you use poetry
within conda environments.
It automates following steps:
1. It looks for a `env.yml` file and creates or updates the environment
2. It configures poetry to not use a venv for the current project
3. It activates the environment, installs, and updates the poetry project.

## HowTo
To use this script simply download it and put it in your project next to
your env.yml and pyproject.toml.
Then run:
```bash
source ./dev-setup.sh
```
And wait for the script to finish.
You don't have to activate the environment after running this script.
