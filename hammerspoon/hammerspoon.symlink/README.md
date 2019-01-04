# Hammerspoon

I have written my own version of a Hammerspoon configuration using [zzamboni](https://zzamboni.org/post/my-hammerspoon-configuration-with-commentary/) as inspiration.

It is based mainly around RecursiveBinder used to provide nested shortcuts to many parts of the OS. I have also written several of my own spoons which have been 
merged up to the mainline repo. 

## Get started

1. Install [Hammerspoon](http://www.hammerspoon.org/) first.

2. `git clone --depth 1 https://github.com/snowe2010/dotfiles.git /tmp/dotfiles`

3. `cp /tmp/dotfiles/hammerspoon/hammerspoon.symlink ~/.hammerspoon`

4. Reload the configuration.

5. Look through `init.lua` to figure out what you want to keep or not.

Things you'll need to set up first:

* Hyper and meh keys
* Grid layout
* Keychain entries
* Tunnelblick username and connection name
* Pastebin api keys

## How to use

Just press <kbd>opt</kbd>, plus <kbd>a</kbd> or <kbd>t</kbd> or <kbd>r</kbd>… to start. You can press <kbd>esc</kbd> to exit.

Press <kbd>opt</kbd> + <kbd>f</kbd> to show all <kbd>opt</kbd> related keybindings in a nested navigatable format.

### Screenshots

These screenshots demostrate what awesome-hammerspoon is capable of. Learn more about [built-in Spoons](https://github.com/ashfinal/awesome-hammerspoon/wiki/The-built-in-Spoons).

#### Desktop widgets

<details>
<summary>More details</summary>

![widgets](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-deskwidgets.png)

</details>

#### Window manpulation <kbd>⌥</kbd> + <kbd>R</kbd>

<details>
<summary>More details</summary>

![winresize](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-winresize.gif)

</details>

#### Search something <kbd>⌥</kbd> + <kbd>G</kbd>

<details>
<summary>More details</summary>

![hsearch](https://github.com/ashfinal/bindata/raw/master/screenshots/awesome-hammerspoon-hsearch.gif)

</details>

## Customization

<details>

<summary>More details</summary>

Customization is pretty easy. Just update the `init.lua` file. Comment out what you don't like, change the keybindings if you want, etc.

Adding and removing spoons is really easy. Just comment out the spoons you don't want. If you want a new spoon, just specify it using the SpoonInstall
spoon and supply a config if the spoon demands it. `Install:andUse("<spoonname>", {<config>})`

*Lots of Spoons are located at [official spoon repository](http://www.hammerspoon.org/Spoons/) (you may need a little config before using them).*

Finally press `cmd + ctrl + shift + r` to reload the configuration. Of course, this is configurable as well. 

</details>

## Contribute

<details>
<summary>More details</summary>

- Improve existing Spoons

  A "Spoon" is just a directory, right-click on it -> "Show Package Contents".

  Feel free to file issues or open PRs.

- Create new Spoons

  Some resources you may find helpful:

  [Learn Lua in Y minutes](http://learnxinyminutes.com/docs/lua/)

  [Getting Started with Hammerspoon](http://www.hammerspoon.org/go/)

  [Hammerspoon API Docs](http://www.hammerspoon.org/docs/index.html)

  [hammerspoon/SPOONS.md at master · Hammerspoon/hammerspoon](https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md)

</details>

## Thanks to

<details>
<summary>More details</summary>

[https://github.com/zzamboni/oh-my-hammerspoon](https://github.com/zzamboni/oh-my-hammerspoon)

[https://github.com/scottcs/dot_hammerspoon](https://github.com/scottcs/dot_hammerspoon)

[https://github.com/dharmapoudel/hammerspoon-config](https://github.com/dharmapoudel/hammerspoon-config)

[http://tracesof.net/uebersicht/](http://tracesof.net/uebersicht/)

</details>
