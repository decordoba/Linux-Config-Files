# Linux Config Files
Optimal configuration files for Linux: `.bashrc`, `.gitrc`, `.vimrc`, `.profile`, etc. Tested on Ubuntu 16.

For some time I have been collecting different useful functions and featurs for my Linux terminal environment. Every line in every
one of the files has been written by me or found online. Every line in my files should be explained with heavy comments that 
clarify its purpose and how to use it, even for beginners in a Linux environment. Enjoy!

## .bashrc

### Calls and functions

These are the most important functions and aliases included:

* Organized `ls` aliases: there are 3 basic commands (`ls` or `l`, `ll` and `lll`) whose functionality can be extended with suffixes.
`ll` shows `ls` in long format (one file/folder per line) and `lll` pipes `ll` to `less`.
Add an `a` to them (`lsa` or `la`, `lla`, `llla`) to also include folders and files starting with `.`.
Add a `t` to them (`lst` or `lt`, `llt`, `lllt`) to sort files and folders by date instead of alphabetically.
Add a `g` to them (`lsg` or `lg`, `llg`, `lllg`) to list folders before files.
2 or 3 prefixes can be used at the same time, in any order, to stack behaviours. For example, `llag`, `lsta`, `lllgt`, `latg`, `llgta`, etc.
* Use `..` to run `cd ..`, `...` to run `cd ../..`, etc.
* Optimal screen use: use `screen1`, `screen2`, `screen3` and `screen4` to create a screen prompt, and `s1`, `s2`, `s3` and `s4` to reopen them.
* `space` shows the space taken by the files and folders ONLY in the current folder, and `spacef` shows the space taken by all folders
AND subfolders, which is great to find what is taking most of the space in the drive.
* Shortcuts: `p` is faster to type than `pwd`. And `clr` is faster than `clear`.
* Use `bd` to navigate to the previous folder. Use it again to go back. Really useful when working in two separate folders.
* `p4` pings one of Google's servers to check in an instant if your machine has internet connectivity.
* `tmp` creates a temporary folder (it will disappear on boot) and navigates into it. Great for doing tests without worrying about cleaning up.
* Easy count functions: `lines` counts the lines in a file, and `words` counts the words.
* Get some smart quotes and forget about life for a while with `wisdom` and `asdf`.
* Reload the source file with `src`, instead of doing `. ~/.bashrc` or `source ~/.bashrc`.
* Edit the source file from anywhere running `vsrc` or `bashrc`. Edit the vimrc file from anywhere typing `vimrc`.
* Perform the same action that you would do with a mouse with `click` or `start` (they are equivalent). For example, open a picture with `click my_img.png`.
* Open the file manager for your current location with `fm`.
* `empty` shows all the empty folders. `emptyrm` removes all empty folders.
* `server` creates an HTTP server in `localhost:8000` where all the files in your current folder are shared. Any other machine in your local network
can download any of the files if they access `<your_IP>:8000`. Really useful to share things at home with other people connected to the same WiFi. Beware of security!
Do not use this in a public network or anyone will be able to access your files.
* `getip` shows your IP address after parsing `ifconfig`.
* `alert` is really useful if you run long jobs. Run `python slow_script.py; alert` or `sleep 10; alert` to be informed with a pop-up when the job is over.
* `extract` will extract any file (`.zip`, `.tar`, `.7z`, `.rar`, etc.) and save it into the current folder. Run it with `extract my_file.zip`.
* `repeat` repeats the same command N times. Use it like this: `repeat 10 echo You are so beautiful!`.
* `mkcd` should be a default: makes a new directory and cd's into it. Use it like: `mkcd my_new_folder`.
* `cdn` will cd into the newest folder available, and `cdo` will cd into the oldest. `cdn N` will cd into the Nth newest folder, and `cdo N` will cd into the Nth newest folder.
* `rmn` and `rmo`, `lsn` and `lso`, `lln` and `llo`, and `llln` and `lllo` allow to perform the chosen operation on the Nth newest or oldest folder, similarly to `cdn` and `cdo`.
* `bu` creates a backup of a file in the current folder. Use it like `bu important.cfg`. It can also be configured to save backups into a `.backups` folder.
* Use `calc` to calculate anything from the comand prompt: `calc 2+2`.
* Use `google` to open a browser and google something: `google how many eyes do spiders have`.
* Use `pathlong` and `pathshort` to toggle between seeing the whole path in the prompt or just the current folder, and use `pathline` to create a new line between the path and the $.
* Easily lock or unlock an encrypted hard drive partition with `hdd_lock` and `hdd_unlock`.

### Features and configurations

These are the most important functionality changes and improvements:

* Colored fancy prompt.
* History handled optimally.
* Window size changed dynamically.
* Mistyped paths are corrected on the fly.
* Pathnames expanded, allowing the use of special characters like `*`, `**`, `?`, `+`, `-`, `@` and `!`, with any command (`ls`, `rm`, etc.).
* Protection against pressing Ctrl + D and closing the console by accident.
* Less command configured optimally (exit if text fits the screen, allows colors, etc.).
* `mv` and `cp` are defaulted to interactive mode, which forces the user to confirm before overwritting.
* Completion on TAB is enabled and configured optimally. Case is ignored.
* `ssh` completion is enabled based on the `ssh` config file. A new entry can be added to this file with `addssh`, which allows us to choose
the alias for our connection. For example, if we run `addssh username@hostname myserver`, then the alias `myserver` will be added to the `ssh`
config file, and we will be able to type `ssh m` + TAB which will autocomplete `ssh myserver`, and if we hit ENTER, it will `ssh` into `username@hostname`.
* Vim chosen as default editor.

### List of all new calls
`la, ll, lh, l, s, sl, lll, lst, lat, llt, lht, lt, lllt, lsg, .., ..., ...., ....., ......, s1, s2, s3, screen1, screen2, screen3,
space, spacef, p, bd, p4, tmp, lines, words, asdf, wisdom, clr, src, start, click, fm, empty,
server, getip, alert, extract, repeat, mkcd, bu, calc, google, remindme, addssh`
