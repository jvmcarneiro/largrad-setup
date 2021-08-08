#/bin/bash

# Setup users
sudo apt install xfce4 xfce4-goodies
sudo apt install rsync
sudo apt remove xscreensaver

sudo useradd -m aluno-grad
sudo passwd aluno-grad
sudo useradd -m Experimentos
sudo passwd Experimentos
sudo usermod -a -G aluno-grad $USER
sudo usermod -a -G Experimentos $USER

sudo rsync -a home /home
sudo rsync -a etc /etc
sudo rsync -a usr /usr

sudo chattr -R +i /home/aluno-grad/.config/autostart/
sudo chattr -R +i /home/aluno-grad/.config/menus/
sudo chattr -R +i /home/aluno-grad/.config/xfce4/
sudo chattr -R +i /home/aluno-grad/.local/bin/
sudo chattr -R +i /home/aluno-grad/.local/share/applications/
sudo chattr +i /home/aluno-grad/.vnc/config
sudo chattr +i /home/aluno-grad/Arquivos/virtual_input.v
sudo chattr +i /home/aluno-grad/Arquivos/virtual_input_pins.csv
sudo chattr +i /home/aluno-grad/.bash_login
sudo chattr +i /home/aluno-grad/.bash_logout
sudo chattr +i /home/aluno-grad/.bash_profile
sudo chattr +i /home/aluno-grad/.bashrc
sudo chattr +i /home/aluno-grad/.inputrc
sudo chattr +i /home/aluno-grad/.profile

sudo chattr -R +i /home/Experimentos/.config/menus/
sudo chattr -R +i /home/Experimentos/.config/xfce4/
sudo chattr -R +i /home/Experimentos/.local/bin/
sudo chattr -R +i /home/Experimentos/.local/share/applications/
sudo chattr +i /home/Experimentos/.vnc/config
sudo chattr +i /home/Experimentos/Arquivos/virtual_input.v
sudo chattr +i /home/Experimentos/Arquivos/virtual_input_pins.csv
sudo chattr +i /home/Experimentos/.bash_login
sudo chattr +i /home/Experimentos/.bash_logout
sudo chattr +i /home/Experimentos/.bash_profile
sudo chattr +i /home/Experimentos/.bashrc
sudo chattr +i /home/Experimentos/.inputrc
sudo chattr +i /home/Experimentos/.profile



# Install TigerVNC
wget https://downloads.sourceforge.net/project/tigervnc/stable/1.11.0/tigervnc-1.11.0.x86_64.tar.gz?ts=gAAAAABhCzIy4Y8W17wrZCLmodc2ciCW4rUx5Ui5Ap9C0NUqV-gMpB9aXjPxwhwX5TjQJwAoBVuyukkmkoZ3wzI4IKiIuloVIw%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Ftigervnc%2Ffiles%2Fstable%2F1.11.0%2Ftigervnc-1.11.0.x86_64.tar.gz%2Fdownload%3Fuse_mirror%3Dufpr%26use_mirror%3Dufpr%26r%3Dhttps%253A%252F%252Fsourceforge.net%252Fprojects%252Ftigervnc%252Ffiles%252Fstable%252F1.11.0%252F

tar xzf tigervnc-*.tar.gz

cd tigervnc-*
sudo chown -R root:root usr

sudo tar czf usr.tgz usr
sudo tar xzkf usr.tgz -C /

mkdir -p /etc/lightdm
touch /etc/lightdm/lightdm.conf
echo "[XDMCPServer]" | sudo tee -a /etc/lightdm/lightdm.conf > /dev/null
echo "enabled=true" | sudo tee -a /etc/lightdm/lightdm.conf > /dev/null
echo "port=177" | sudo tee -a /etc/lightdm/lightdm.conf > /dev/null

mkdir -p /etc/gdm
touch /etc/gdm/custom.conf
echo "[xmdcp]" | sudo tee -a /etc/gdm/custom.conf > /dev/null
echo "Enabled=true" | sudo tee -a /etc/gdm/custom.conf > /dev/null
echo "Port=177" | sudo tee -a /etc/gdm/custom.conf > /dev/null

sudo systemctl restart lightdm
sudo systemctl restart gdm

sudo systemctl start xvnc.socket
sudo systemctl enable xvnc.socket

sudo -u Experimentos vncpasswd -f <<<"larexp2021" >"/home/Experimentos/.vnc/passwd"
sudo chattr +i /home/Experimentos/.vnc/config
