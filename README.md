# BREN(dan's)DEV(elopment environment)

`brendev` is my personal development environment setup for WSL (Ubuntu) --- though would probably work on linux ubuntu (and maybe other debian distros) as well. It will install my software and config files. To do so run the following


## Setup ("install") brendev

**Clone to `$HOME` folder (`~`)**

```bash
# ↓ Run as is ↓
git clone https://github.com/brendevan/.brendev-wsl $HOME/.brendev-wsl
source $HOME/.brendev-wsl/.bdev.sh
bdev-build
```

**Clone to somewhere else**

```bash
PATH=/path/to/folder  
# ↑ Change path/to/folder to the path of the folder you want to clone into ↑

# ↓ Run as is ↓
git clone https://github.com/brendevan/.brendev-wsl $PATH/.brendev-wsl
source $PATH/.brendev-wsl/.bdev.sh
bdev-setup $PATH
```

## Important files

* `install.sh`: this is the main install script and all software is installed from here (whether in the direct script or by calling other install scripts such as `install_r.sh`). To add more software, do it here. If the install script for a piece of software is more than a handful of lines long, add the instal script to its own folder e.g. `install_whatever.sh` and call it from `install.sh`.

* `dotfiles.sh`: this sets up the dotfiles contained in `/dotfiles`. To add more dotfiles, add them to the `/dotfiles` folder and then create symbolic links in `dotfiles.sh` using the `bdev-link-dotfile $TARGET $LINK` function (see `dotfiles.sh` for context).

* `helper.sh`: defines functions used in the bdev setup/"install". 

* `main.sh`: the *main* setup/"install" script, all other scripts (`install.sh`/`dotfiles.sh`/etc) are called from here. To add additional installation steps, create a `new_step.sh` file which does all the work, and call it from `main.sh` (i.e. keep `main.sh` clean).

* (`.run-log.txt`): this file logs the setup/"install" output.
* (.setup.sh): defines a quick interface to `main.sh`.


## Notes

- A basic note organising tool. Requires a git repo called .notes cloned into the home folder.
- Functionality setup in .bash_aliases