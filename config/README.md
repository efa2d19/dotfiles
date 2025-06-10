## 💡 Usage options

- `--help`
  > Prints usage, aka help message
  ```bash
  ./dotsetup -h
  Usage:
      dotsetup [-h|--help]
      dotsetup [--uninstall]
      dotsetup [-a|--all]
      dotsetup [-n|--dry-run]
      dotsetup [-v|--verbose]
      dotsetup [-d|--default]
      dotsetup [-c|--custom] <name_of_relative_module>
  ```

- `--verbose`
  > Pass verbose flag to stow
  > Also stops on every module and asks for confirmation
  > Plus stops before deploying a module to show all packages in current module

- `--dry-run`
  > Pass dry run flag to stow 

- `--all`
  > Use all available modules found in the exec directory

- `--default`
  > Use default module

- `--custom`
  > Add custom module
  ```bash
  ./dotsetup -c <relative-dir-name> -c <another-relative-dir-name>
  ```

- `--uninstall`
  > Uninstall all specifed modules

## Submodules

### Add submodule

```bash
git submodule add -f <git_repo> <module_name>
```

