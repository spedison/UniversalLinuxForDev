suod dnf -y update

sudo dnf -y upgrade

sudo dnf -y install akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-devel xorg-x11-drv-nvidia-libs \
                    libva-nvidia-driver libva-utils libva-v4l2-request libvala libvala-devel


# Caso apresente problemas e não apresente vídeo, faça o seguintes passos:
# 1) No grub selecione o Fedora Linux mas apete a tecla "e" no lugar de Enter.
# 2) No fim da linha que inicia com <linux ... quiet...> adione o parâmetro <nomodeset> (Deligando o KMS) entrando o modo texto.
# 3) Entre no ptty1 ou 2. Logue e atualize o sistema.
# 4) Reinicie o sistema.
