
#TODO Filtrar para executar somente em Fedora
sudo dnf install -y \
  gnome-shell-extension-appindicator \
  gnome-extensions-app \
  gnome-tweaks \
  gnome-shell-extension-just-perfection
  
dnf search   cursor-theme 2> /dev/null | grep -E "^ [a-z]" | cut -f 1 -d "." | xargs -n 10 sudo dnf -y install
dnf search   icon-theme 2> /dev/null | grep -E "^ [a-z]" | cut -f 1 -d "." | xargs -n 10 sudo dnf -y install

curl  https://extensions.gnome.org/extension-data/just-perfection-desktopjust-perfection.v36.shell-extension.zip   -o /tmp/shell.zip

gnome-extensions install /tmp/shell.zip

  
gsettings set org.gnome.desktop.interface cursor-theme 'breeze_cursors'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-purple'
gsettings set org.gnome.desktop.interface cursor-size 128
gsettings set org.gnome.desktop.interface locate-pointer true
