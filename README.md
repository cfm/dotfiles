# dotfiles

## To bootstrap dotfiles

```sh-session
$ git clone https://github.com/cfm/dotfiles.git
$ mv dotfiles/.git .
$ git checkout -- .gitignore
$ git reset --hard
```

## To bootstrap GPG keyring

```sh-session
$ KEYID=0x0F786C3435E961244B69B9EC07AD35D378D10BA0
$ gpg --recv-key $KEYID
$ gpg --edit-key $KEYID  # trust ultimately
```

* In Qubes, I suppose I could seed the keyring and `trustdb` in the
  template-level `/etc/skel`.


## To bootstrap a disposable VM for development

```sh-session
$ wget https://raw.githubusercontent.com/cfm/dotfiles/main/Makefile
$ make dev-dispvm
```
