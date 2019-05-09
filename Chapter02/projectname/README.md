## 生成空模块 dummy

```
$ mkdir -p local/dummy
$ touch local/dummy/__init__.py
$ echo '{"name": "dummy", "installable": False}' >\
local/dummy/__manifest__.py
```


## .gitignore文件内容


```
# dotfiles, with exceptions:
.*
!.gitignore
# python compiled files
*.py[co]
# emacs backup files
*~
# not tracked subdirectories
/env/
/src/
/filestore/
/logs/
```