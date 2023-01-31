# Server configuration for LaR experiments
Run the following instructions after configuring the initial user `markX` and programming the connected microcontrollers.

Recommended to also remove read privileges from users' private folders in `/home/` with `chmod go-rwx`.

Made considering the Ubuntu 18.04 LTS system version.

## Install necessary programs
```
sudo apt install guvcview
sudo apt install xfce4 xfce4-goodies
sudo apt remove xscreensaver
```

## Create users
```
sudo useradd -m aluno-grad
sudo passwd aluno-grad
sudo useradd -m exp-a
sudo passwd exp-a
sudo usermod -a -G aluno-grad $USER
sudo usermod -a -G exp-a $USER
sudo usermod -a -G video exp-a
```

## Copy configuration files (one at a time to avoid errors)
```
sudo cp -a home/. /home/
```
```
sudo cp -a etc/. /etc/
```
```
sudo cp -a usr/. /usr/
```

## Change file owners
```
sudo chown -R aluno-grad:aluno-grad /home/aluno-grad/
sudo chown -R exp-a:exp-a /home/exp-a/
```

## Make scripts executable
```
sudo chown root:root /home/exp-a/.local/bin/kill-jtagd
sudo chmod u+s /home/exp-a/.local/bin/kill-jtagd
```

## Install TigerVNC
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

## Create VNC passwords
Manually log in as each user and execute the `vncpasswd` command.
Basta logar manualmente em cada usuário e executar `vncpasswd`.

## Block sensitive files
```
sudo chattr -R +i /home/aluno-grad/.config/autostart/
sudo chattr -R +i /home/aluno-grad/.config/menus/
sudo chattr -R +i /home/aluno-grad/.config/xfce4/
sudo chattr -R +i /home/aluno-grad/.local/share/applications/
sudo chattr +i /home/aluno-grad/.vnc/config
sudo chattr +i /home/aluno-grad/.vnc/passwd
sudo chattr +i /home/aluno-grad/Arquivos/virtual_input.v
sudo chattr +i /home/aluno-grad/Arquivos/virtual_input_pins.csv
```
```
sudo chattr -R +i /home/exp-a/.config/menus/
sudo chattr -R +i /home/exp-a/.config/xfce4/
sudo chattr -R +i /home/exp-a/.local/share/applications/
sudo chattr +i /home/exp-a/.vnc/config
sudo chattr +i /home/exp-a/.vnc/passwd
sudo chattr +i /home/exp-a/Arquivos/virtual_input.v
sudo chattr +i /home/exp-a/Arquivos/virtual_input_pins.csv
```

## Create VNC connections
Substitute `XX` and `YY` for the corresponding numbers set in `/usr/etc/tigervnc/vncserver.users`.
```
sudo systemctl start vncserver@:XX
sudo systemctl enable vncserver@:YY
```

# Post installation steps
- Clone <https://github.com/jvmcarneiro/de2-115-virtual-input> and compile following README.md instructions
- Copy the compiled file to `exp-X` user's `~/.local/bin` folder, modifying serial access permissions with `chown exp-X:dialout` and `chmod g+s`
- Block access to folder `~/.local/bin` with `sudo chattr -R +i`
- Install Quartus 20.1 in `/opt/intelFPGA/` and make the necessary adjustments in order to run ModelSim in Ubuntu environments (modify permissions and parameter values in the executable files; many internet guides explain how to do this)
- Create symbolic links to `quartus` and `vsim` in `/usr/local/bin/`
- Copy `virtual_input.bsf` to `/opt/intelFPGA/20.1/quartus/libraries`
- USBBlaster has already been installed when the `etc/udev/` folder was copied in previous steps 

Once the configuration is complete, you are free to create connections in the Guacamole interface pointing to the VNC addresses.


# Configuring additional Experiment users
1. Replicate the `exp-a` user configuration steps for newly-created `exp-b`, `exp-c`, etc.
1. Modify serial port in `DEFAULT_DEVICE` and desired camera in the `guvcview` command in `de2-115-gui.py` (more details in the [README](https://github.com/jvmcarneiro/de2-115-virtual-input#setting-default-serial-port-and-camera)
1. Compile `de2-115-gui.py`, move to new user's `~/.local/bin/` folder, change ownership and permissions (explained above) and lock folder
1. Modify `Exec` and `Path` fields of `de2-115-gui.desktop` and `exo-file-manager.desktop` files in `~/.local/share/applications/` folder with the new username
1. Modify `Exec` field in `~/.local/share/applications/guvcview.desktop` to `guvcview -d /dev/videoX`, with X according to `v4l2-ctl --list-devices` (blocking the folder with `chattr` when done)
1. Create VNC password with `vncpasswd` logged in with new user and lock file `~/.vnc/passwd`
1. Add connections to `/usr/etc/tigervnc/vncserver.users`
1. Run and enable the desired `vncserver@:` services

In order to create a connection for the admin user `markX`, copy the file `~/.vnc/config` from another user and repeat the last 3 steps from the list above.

# Troubleshooting
The configuration files in this repository reproduce the [instructions for setting up TigerVNC for on demand sessions](https://wiki.archlinux.org/title/TigerVNC#Running_Xvnc_with_XDMCP_for_on_demand_sessions).
This feature, however, is hardware dependent and not always available.

If you, for instance, are not able to simultaneously connect to more than one `aluno-grad` VNC session, your system may not be compatible with this approach and only one connection is allowed per Linux account.
In that case, the alternative is to create new Linux users for each desired connection, following much of the [Configuring additional users section](#configuring-additional-experiment-users), skipping the steps related to the DE2-115 Virtual GUI when configuring virtual connections like the `aluno-grad`.

The downside of this approach, besides the necessary additional configuration, is the fixed computing overhead in comparison to on demand usage.
On the user side, however, the experience will be quite similar.
