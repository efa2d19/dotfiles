# dotfiles

## 🔎 Overview

Yet another personal dotfiles repo

## 💡 Usage options

- `make`
  > Executes all script below, aka `make all`

- `make brew`
  > Checks if brew is installed, otherwise installs it using online installer

- `make pkg`
  > Installs brew formulaes, casks, and mas apps\
  > Also see: make brew-pkg, make brew-apps

- `make brew-pkg`
  > Installs brew formulaes and taps from Brewfile

- `make brew-apps`
  > Installs brew casks and mas apps from Caskfile

- `make ensure-stow`
  > Checks if stow is installed, otherwise installs one using brew\
  > Also see: make brew

- `make link`
  > Links default configs in verbose mode

- `make unlink`
  > Unlikns default configs in verbose mode

- `make sys`
  > Sets up default system settings\
  > With NO_SYSTEM_RENAME env doesn't rename pc\
  > Other envs: COMPUTER_NAME, LANGUAGES, LOCALE, MEASUREMENT_UNITS

- `make dock`
  > Removes all items in dock and adds default ones

- `make zsh`
  > Checks if oh-my-zsh is installed, otherwise installs it with p10k and some plugins

- `make xcode-clt`
  > Installs xcode clt

## 📝 License

All set to go under the [Apache-2.0 License](/LICENSE). Use it, modify it, share it.
