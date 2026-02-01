
sudo dnf install gnome-tweaks
sudo dnf install gnome-extensions-app
  
dnf search   cursor-theme 2> /dev/null | grep -E "^ [a-z]" | cut -f 1 -d "." | xargs -n 10 sudo dnf -y install
dnf search   icon-theme 2> /dev/null | grep -E "^ [a-z]" | cut -f 1 -d "." | xargs -n 10 sudo dnf -y install
  
gsettings set org.gnome.desktop.interface cursor-theme 'breeze_cursors'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-purple'
gsettings set org.gnome.desktop.interface cursor-size 128
gsettings set org.gnome.desktop.interface locate-pointer true
