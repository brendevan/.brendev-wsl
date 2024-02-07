# Things to do

In no particular order (or coherence):

* Install okular

* Setup codium .dotfiles (settings, snippets, shortcuts? json files) from bash script?

* Setup codium extensions from bash script

* Switch on windows from code to codium

* Look into renv for rpackage management

* radian customisation (prompt, startup message)

* fonts?

* Update functionality: 
  
  - Add option to only install what isn't already installed (e.g. bdev-build --no-update)? Display what exists next to the terminal progress list item (e.g. `- apt packages (all already installed OR 18 of 23 already installed)`)

  - Add in `bdev-update-r` alias which updates r and packages. Then in main install script only install missing packages. Create bdev-update which updates everything if not installed and installs otherwise. 
  
  - bdev-build then only installs and doesn't update.

* Clean up aliases (especially bdev stuff)

* KEYBINDINGS: 
    - Figure out how to remove all keybindings in vscode and start fresh
    - Windows: remap CAPSLOCK to f13, this is then the termanal key (F13 + 1 = zsh; f13+2 = r terminal; etc)

* Add bdev module which checks connection on wsl2 and runs wsl-fix-connection if wsl-test-connection returns "Offline"

* INLA r package currently failing to install via  bdev-build. Fix this.

* Build message: 

  - Add msg's for system packages (like R packages)
  - Change r packages messages so that if updated it displays `oldversion -> newversion` e.g. `remotes (2.4.0.0 -> 2.4.2.1)`


* terra r package seems to install fine, but does not that i don't have the dependencies: libgdal32  libproj25. add these to system packages if this becomes a problem (i haven't tried to use terra yet)