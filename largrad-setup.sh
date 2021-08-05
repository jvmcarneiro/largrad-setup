#/bin/bash



# Install TigerVNC
wget https://downloads.sourceforge.net/project/tigervnc/stable/1.11.0/tigervnc-1.11.0.x86_64.tar.gz?ts=gAAAAABhCzIy4Y8W17wrZCLmodc2ciCW4rUx5Ui5Ap9C0NUqV-gMpB9aXjPxwhwX5TjQJwAoBVuyukkmkoZ3wzI4IKiIuloVIw%3D%3D&r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Ftigervnc%2Ffiles%2Fstable%2F1.11.0%2Ftigervnc-1.11.0.x86_64.tar.gz%2Fdownload%3Fuse_mirror%3Dufpr%26use_mirror%3Dufpr%26r%3Dhttps%253A%252F%252Fsourceforge.net%252Fprojects%252Ftigervnc%252Ffiles%252Fstable%252F1.11.0%252F

tar xzf tigervnc-*.tar.gz

cd tigervnc-*
sudo chown -R root:root usr

sudo tar czf usr.tgz usr
sudo tar xzkf usr.tgz -C /



# Setup users
sudo apt install xfce4 xfce4-goodies

sudo useradd -m aluno-grad
sudo passwd aluno-grad
sudo useradd -m Experimentos
sudo passwd Experimentos

# COPY FILES

sudo chattr -R +i /home/aluno-grad/.config/autostart/
sudo chattr -R +i /home/aluno-grad/.config/menus/
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
