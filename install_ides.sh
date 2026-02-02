#!/bin/bash

# IDEs da JetBrains

# Este diretório pode ser alterado.
# Aqui podemos usar para um único disco.
HOME_IDES=$HOME/.local/IDES
# Para poder compartilhar entre sistemas operacionais
# HOME_IDES=/mnt/dados/IDES

# CLion
cd $HOME
FILE_P=CLion-2025.3.1
FILE_L=clion-2025.3.1
wget https://download-cdn.jetbrains.com/cpp/$FILE_P.tar.gz
gunzip $FILE_P.tar.gz
cd $HOME_IDES
tar -xvf ~/$FILE_P.tar
ln -s $HOME_IDES/$FILE_L $HOME/.local/share/clion
echo 'export PATH=$PATH:/home/spedison/.local/share/clion/bin' >> ~/.bashrc
rm $HOME/$FILE_P.tar

#GoLand
cd ~
FILE_P=goland-2025.3
FILE_U=GoLand-2025.3
wget https://download-cdn.jetbrains.com/go/$FILE_P.tar.gz
gunzip $FILE_P.tar.gz
cd $HOME_IDES
tar -xvf ~/$FILE_P.tar
ln -s $HOME_IDES/$FILE_U ~/.local/share/goland
echo 'export PATH=$PATH:/home/spedison/.local/share/goland/bin' >> ~/.bashrc
rm ~/$FILE_P.tar

#IntelliJ
cd ~
export FILE_P=idea-2025.3.1
export FILE_U=idea-IU-253.29346.138
wget https://download-cdn.jetbrains.com/idea/$FILE_P.tar.gz
gunzip $FILE_P.tar.gz
cd $HOME_IDES
tar -xvf ~/$FILE_P.tar

# ele me fez o favor de quebrar o Script alterando o nome do diretorio interno diferente do arquivo compactado
export FILE_PN=$(ls -1 | grep -i  "idea-iu")
ln -s $HOME_IDES/$FILE_U $HOME/.local/share/intellij
ln -s $HOME/.local/share/intellij/bin/idea  $HOME/.local/share/intellij/bin/intellij
echo 'export PATH=$PATH:$HOME/.local/share/intellij/bin' >> $HOME/.bashrc
rm ~/$FILE_P.tar

#PyCharm
cd ~
FILE_P=pycharm-2025.3.1
wget https://download-cdn.jetbrains.com/python/$FILE_P.tar.gz
gunzip $FILE_P.tar.gz
cd $HOME_IDES
tar -xvf ~/$FILE_P.tar
ln -s $HOME_IDES/$FILE_P ~/.local/share/pycharm
echo 'export PATH=$PATH:$HOME/.local/share/pycharm/bin' >> ~/.bashrc
rm ~/$FILE_P.tar

#RustRover
cd ~
FILE_P=RustRover-2025.3.1
wget https://download-cdn.jetbrains.com/rustrover/$FILE_P.tar.gz
gunzip $FILE_P.tar.gz
cd $HOME_IDES
tar -xvf ~/$FILE_P.tar
ln -s $HOME_IDES/$FILE_P ~/.local/share/rustrover
echo 'export PATH=$PATH:$HOME/.local/share/rustrover/bin' >> ~/.bashrc
rm ~/$FILE_P.tar
