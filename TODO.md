* Setup codium .dotfiles (settings, snippets, shortcuts? json files) from bash script?

* Setup codium extensions from bash script

* Switch on windows from code to codium

* Install r packages (renv?)

* rstan, cmdstanr, others?

* radian customisation (prompt, startup message)

* fonts?

* IF BUILD STARTS TO TAKE TO LONG: add checks to installs to see if stuff already exists, display what exists next to the terminal progress list item (e.g. `- apt packages (all already installed OR 18 of 23 already installed)`)

* probably should clean up once reasonably stable in structure (e.g.  better installation process, better bdev function structure/names)

* migrate all setup scripts into `bdev.sh`, where functions define different parts of the bdev-setup

```bash
# Example: 
bdev-install-vscode-extensions () {
  code to install extensions and print msgs etc here
}
```
...then we can move stuff like vscode extensions list (currently in `vscode.sh`) into its own file (e.g. `.code_extensions`)


* Add in `bdev-update-r` alias which updates r and packages. Then in main install script only install missing packages

* Add msg's for system packages (like R packages)

* Add .radian_profile to dotfiles