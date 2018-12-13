# My Dotfiles

These are the dotfiles I use on a regular basis on development machines. They get slowly tweaked over time to fit my needs as I work with new software or on new types of hosts. They get used on MacOS and Linux mostly - I can't speak for how they work on Windows, but in my limited Windows Subsystem for Linux testing, I've noticed strange behavior with vim colorschemes.

## Installation Instructions:

There's lots of different preferred ways to do this, depending on who you ask. Many involve shell scripts and lots of symlinks - this method requires no symlinks or scripts.

** WARNING:** This method may overwrite any existing dotfiles. Make sure you back them up or append .bak to their filenames before following these instructions.

1. `$ cd ~`
2. `$ git init`
3. `$ git remote add origin https://github.com/sfowlr/dotfiles.git`
4. `$ git pull origin master`


