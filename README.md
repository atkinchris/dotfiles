# dotfiles

Collection of dotfiles and helper scripts

## Usage

Clone this repo, and run `./bootstrap.sh`. This will copy all the dotfiles (but not helper scripts) into your home directory.

## Files

The `./bootstrap.sh` script will sync files from this repo to your home directory. It uses a static list of files (`./files.txt`) to explicitly know what to copy. If you add new files to this repo that need to be copied to the home directory, ensure they are added to that list.

This list was built using:

```sh
find . -type f ! -name '*.sh' ! -name '*.md' ! -path './.git/*' > files.txt
```

## Committing Changes

If you've updated your local copies of these files in your home directory, and want to commit them back to this repo, use the following command to copy them over (this is the reverse of what is in `./bootstrap.sh`).

```sh
rsync -avr --no-perms --files-from=files.txt ~ .
```

## VS Code

Visual Studio Code settings are no longer copied automatically, as these are maintained with the sync settings plugin. However, local copies are included here for archiving purposes.

To copy them to the local system, use:

```sh
# Linux
rsync -avr --no-perms ./vscode/ $HOME/.config/Code/User/

# macOS
rsync -avr --no-perms ./vscode/ "$HOME/Library/Application Support/Code/User/"
```
