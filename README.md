基于网上的 header.vim 做的修改

INSTALLATION
----------
If you use [Vundle](https://github.com/gmarik/vundle.git) you can install this plugin using following Vim command:

    :BundleInstall ButBueatiful/vim-authorinfo

In addition, don't forget put a line `Bundle 'ButBueatiful/vim-authorinfo'` into your _.vimrc_.

If you use [pathogen.vim](https://github.com/tpope/vim-pathogen), you can do install this plugin with these commands:

    cd ~/.vim/bundle
    git clone https://github.com:ButBueatiful/vim-authorinfo.git

You don't use either plugin management systems, copy _autoload_ and _plugin_ directory to your _.vim_ directory.

CONFIGURETION
----------
Add the following line to your .vimrc:
```
let g:authorinfo_author='Yourname'
let g:authorinfo_email='Youremail'
let g:authorinfo_company='Yourcompany'
```
