flatpak uninstall org.virt_manager.virt-manager

#Instala todos os pacotes referentes ao libvirt
dnf search libvirt | grep -E "(^ libvirt|^ virt)" | grep -viE "(java|ruby|perl|vbox)" | cut -f1 -d"." | sort | uniq | xargs -n 100 sudo dnf -y install

#Habilita e executa o serviço
sudo service libvirtd start

sudo service libvirtd enable

service libvirtd status

echo "Adicionar o usuário $USER no grupo LibVirt"

