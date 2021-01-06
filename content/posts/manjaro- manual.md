---
title: "manjaro- manual"
date: 2019-07-20T10:12:00+08:00
draft: false
---
修改软件源
sudo pacman-mirrors -i -c China -m rank
sudo pacman -Syyu
打开pamac-manager，开启aur

安装中文字体，否则有些程序会乱码（比如wps，vlc）
pacman -S wqy-zenhei ttf-fireflysung

安装输入法
sudo pacman -S fcitx-im #默认全部安装
sudo pacman -S fcitx-configtool
sudo pacman -S fcitx-sogoupinyin
sudo nano ~/.xprofile

    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"

用户目录改英文
export LANG=en_US
xdg-user-dirs-gtk-update
export LANG=zh_CN

oh-my-zsh
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

vim ~/.zshrc
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

 source ~/.zshrc

修改字体优先级
/etc/fonts/conf.d/65-nonlatin.conf

清除Gnome占用IDEA的快捷键 Ctrl + Alt + Left
gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-left
['<Control><Alt>Left']