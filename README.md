# dotfiles

## 🔎 Overview

Yet another personal dotfiles repo with my macOS setup. 

## 💡 Usage options

- `--help`
  > Prints usage, aka help message
  ```bash
  ./dotsetup -h
  Usage:
    dotsetup [-h|--help] [-v|--verbose]
    dotsetup [-d|--default]  [--uninstall]
    dotsetup [-n|--dry-run] [-c|--custom]
  ```

- `--verbose`
  > Pass verbose flag to stow
  > Also stops on every dir and asks for confirmation
  > Plus stops before stowing and validate all modules in current dir

- `--dry-run`
  > Pass dry run flag to stow 

- `--default`
  > Use default dir

- `--custom`
  > Add custom modules
  > Recomemded to be used with submodules, which are being ignored by default
  ```bash
  ./dotsetup -c <..> -c <...>
  ```

- `--uninstall`
  > Unstow all specifed dirs (default or custom ones if specified)

## Submodules

### Add submodule

```bash
git submodule add -f https://github.com/<username>/<repo>.git <dir-name>
```

> Don't forget to reset some files to avoid something being accidentally pushed to the repo
```bash
git restore --staged <dir-name>
git restore --staged .gitmodules
```

## 📝 License

All set to go under the [Apache-2.0 License](/LICENSE). Use it, modify it, share it.
