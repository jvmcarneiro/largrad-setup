# Configuração de máquina para experimentos do LaR
Rodar instruções abaixo após configurar usuário inicial `markX`.
Feito para Ubuntu 18.04 LTS.

## Instalar programas necessários
```
sudo apt install guvcview
sudo apt install xfce4 xfce4-goodies
sudo apt remove xscreensaver
```

## Criar usuários
```
sudo useradd -m aluno-grad
sudo passwd aluno-grad
sudo useradd -m exp-a
sudo passwd exp-a
sudo usermod -a -G aluno-grad $USER
sudo usermod -a -G exp-a $USER
sudo usermod -a -G video exp-a
```

## Copiar arquivos de configuração (um de cada vez para evitar erros)
```
sudo rsync -a home /
```
```
sudo rsync -a etc /
```
```
sudo rsync -a usr /
```

## Trocar donos dos arquivos
```
sudo chown -R aluno-grad:aluno-grad /home/aluno-grad/
sudo chown -R exp-a:exp-a /home/exp-a/
```

## Instalar TigerVNC
```
wget https://sourceforge.net/projects/tigervnc/files/stable/1.11.0/tigervnc-1.11.0.x86_64.tar.gz
```
```
tar xzf tigervnc-*.tar.gz
cd tigervnc-*64
sudo chown -R root:root usr
sudo tar czf usr.tgz usr
sudo tar xzkf usr.tgz -C /
```

## Criar senhas VNC
```
sudo -u aluno-grad vncpasswd -f <<<"largrad" >"/home/aluno-grad/.vnc/passwd"
```
```
sudo -u exp-a vncpasswd -f <<<"larexpa2021" >"/home/exp-a/.vnc/passwd"
```
Caso não funcione, basta logar manualmente em cada usuário e executar `vncpasswd`.

## Bloquear arquivos sensíveis
```
sudo chattr -R +i /home/aluno-grad/.config/autostart/
sudo chattr -R +i /home/aluno-grad/.config/menus/
sudo chattr -R +i /home/aluno-grad/.config/xfce4/
sudo chattr -R +i /home/aluno-grad/.local/share/applications/
sudo chattr +i /home/aluno-grad/.vnc/config
sudo chattr +i /home/aluno-grad/.vnc/passwd
sudo chattr +i /home/aluno-grad/Arquivos/virtual_input.v
sudo chattr +i /home/aluno-grad/Arquivos/virtual_input_pins.csv
sudo chattr +i /home/aluno-grad/.bash_login
sudo chattr +i /home/aluno-grad/.bash_logout
sudo chattr +i /home/aluno-grad/.bash_profile
sudo chattr +i /home/aluno-grad/.bashrc
sudo chattr +i /home/aluno-grad/.inputrc
sudo chattr +i /home/aluno-grad/.profile
```
```
sudo chattr -R +i /home/exp-a/.config/menus/
sudo chattr -R +i /home/exp-a/.config/xfce4/
sudo chattr -R +i /home/exp-a/.local/share/applications/
sudo chattr +i /home/exp-a/.vnc/config
sudo chattr +i /home/exp-a/.vnc/passwd
sudo chattr +i /home/exp-a/Arquivos/virtual_input.v
sudo chattr +i /home/exp-a/Arquivos/virtual_input_pins.csv
sudo chattr +i /home/exp-a/.bash_login
sudo chattr +i /home/exp-a/.bash_logout
sudo chattr +i /home/exp-a/.bash_profile
sudo chattr +i /home/exp-a/.bashrc
sudo chattr +i /home/exp-a/.inputrc
sudo chattr +i /home/exp-a/.profile
```

## Criar conexões VNC (XX sendo o número correspondente)
```
sudo systemctl start vncserver@:XX
sudo systemctl enable vncserver@:XX
```

# Pós configuração
- Clonar `https://github.com/jvmcarneiro/de2-115-virtual-input`, configurar porta serial desejada e compilar segundo instruções no README.md
- Copiar arquivo compilado para `~/.local/bin` dos usuários `exp-X`, modificando permissões para acessar serial com `chown exp-X:dialout` e `chmod g+s`
- Bloquear acesso à pasta `~/.local/bin` com `sudo chattr -R +i`
- Instalar Quartus 20.1 em `/opt/intelFPGA/` e mudar as configurações necessárias para rodar o ModelSim (modificar permissões e parâmetros dos executáveis; muitos guias na internet explicam como fazer)
- Copiar `virtual_input.bsf` para `/opt/intelFPGA/20.1/quartus/libraries`
- USBBlaster já foi instalado ao copiar a pasta `etc/udev/` nos passos anteriores 

Concluída a configuração basta criar conexões na interface Guacamole apontando para os novos servidores VNC.


# Configurando outros usuários de experimentos
- Replicar comandos do usuário `exp-a` acima para `exp-b`, `exp-c`, etc.
- Modificar `DEFAULT_DEVICE` em `de2-115-gui.py`
- Compilar `de2-115-gui.py`, mover para `~/.local/bin/`, mudar donos e permissões (explicado acima) e bloquear pasta
- Modificar campos `Exec` e `Path` dos arquivos `de2-115-gui.desktop` e `exo-file-manager.desktop` na pasta `~/.local/share/applications/` com o novo nome de usuário
- Modificar campo `Exec` em `~/.local/share/applications/guvcview.desktop` para `guvcview -d /dev/videoX`, com X de acordo com `v4ls-ctl --list-devices` (bloqueando a pasta com `chattr` ao concluir)
- Criar senha VNC com `vncpasswd` logado com novo usuário e bloquear arquivo `~/.vnc/passwd`
- Adicionar conexões em `/usr/etc/tigervnc/vncserver.users`
- Rodar e habilitar serviços `vncserver@:` desejados

Repetir últimos 3 passos para criar conexão VNC do usuário `markX` do sistema.

