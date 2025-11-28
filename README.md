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

## Useful Tips

### Copying files from another computer

If you have access to another system over SSH (such as a Mac with "Remote Login" enabled), you can copy files and folders from the remote system to your local with the following command. This will recursively bring over any files and folders specified, excluding files which would, within a folder, have been ignored by that folder's `.gitignore` file.

```sh
rsync -avr --no-perms --filter=':- .gitignore' remote-system:~/<PATH>/ ~/<PATH>
```

### Brew

These dotfiles are primarily used on a Mac, with [Homebrew](https://brew.sh). To install supporting tools and CLIs from `brew`, a [`Brewfile`](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f) is provided.

Note: items in the `Brewfile` are installed as part of `./scripts/brew.sh`.

```sh
# Install applications from Homebrew
brew bundle install --file=Brewfile

# Backup a list of installed applications to the Brewfile
# This needs --force to overwrite the current Brewfile
brew bundle dump --no-vscode --file=Brewfile --force
```
