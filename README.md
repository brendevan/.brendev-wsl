# BREN(dan's)DEV(elopment environment)

`brendev` is my personal development environment setup for WSL (Ubuntu) --- though would probably work on linux ubuntu as well. It will install my software and config files. To do so run the following

**Clone to `$HOME` folder (`~`)**

```bash
# ↓ Run as is ↓
git clone https://github.com/brendevan/.brendev-wsl $HOME/.brendev-wsl
source $HOME/.brendev-wsl/.bdev.sh
bdev-setup
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