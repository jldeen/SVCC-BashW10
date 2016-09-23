10/02/2016

BASH ON WINDOWS 10 – WINDOWS SUBSYSTEM FOR LINUX DEMO	

    Pre-Reqs
        Basic knowledge of Linux
        Windows 10 Anniversary Update Installed
        Systems Administration / Network Administration Experience

    SETUP BASH ON UBUNTU ON WINDOWS 10	
        Enable Developer Mode, restart, type “bash” to install, press “y”
        Run basic update commands
        Lsb_release -A
        Explain more about WSL / LXSS
	        Files live in %localappdata%\lxsss
	        To reset / completely remove:
		        Lxrun /uninstall /full
	        To reinstall
		        Lxrun /install
        Basic Linx commands demo
	        Vim
	        Touch
	        SSH

        Guide for configuring Password SSH
            1. Edit /etc/ssh/sshd_config and change the listening port. For this demo I used port 222.
            2. Change UsePrivilegeSeparation to ‘no’ (because the implementation of the Windows subsystem for Linux doesn’t provide chroot)
            3. Change PasswordAuthentication to ‘yes’
            4. Add a firewall rule on the Windows side for SSH to your new listening port
            5. sudo ssh-keygen -A
            6. Restart the ssh service: sudo service ssh restart (Ignore the message: “initctl: Unable to connect to Upstart: Failed to connect to socket /com/ubuntu/upstart: Connection refused”)
            7. Test ssh connection locally with verbose mode enabled (verbose mode optional): ssh localhost -p “your-port-here” -v
            8. Test from another system. (All should be working)
            
        Guide for configuring Password-less SSH

            1. Edit /etc/ssh/sshd_config and change the listening port. For this demo I used 222
            2. Change the UsePrivilegeSeparation to ‘no’ (because the implementation of the Windows subsystem for Linux doesn’t provide chroot)
            3. Add a firewall rule on the Windows side for ssh to your new listening port
            4. sudo ssh-keygen -A
            5. Restart the ssh service: sudo service ssh restart (Ignore the message: “initctl: Unable to connect to Upstart: Failed to connect to socket /com/ubuntu/upstart: Connection refused”)
            
            Do this from client machine (system tunneling to Bash on Ubuntu on Windows):
            1. cd ~/.ssh
            2. ssh-keygen -t rsa

            [Pause to complete step 1 on server side]

            3. scp -P “port-goes-here” ~/.ssh/id_rsa.pub username@server-ip-address:~/.ssh
            * Tip – If you have trouble copying the .pub file to your server, you might want to temporarily enable PasswordAuth on the server (using the above instructions) to complete the scp transfer and then disable PasswordAuth promptly after.
            
            [Proceed to complete steps 2 – 5 on server side]

            Do this from server machine (system running Bash on Ubuntu on Windows):
            1. mkdir -p ~/.ssh/
            
            [Pause to complete step 3 on client side]

            2. cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
            3. chmod 700 .ssh
            4. chmod 600 .ssh/authorized_keys
            5. rm .ssh/id_rsa.pub

            To connect to your system running Bash on Ubuntu on Windows (server) from your client, run the following:

            ssh username@server-ip-address -p “your-port-here”
        Colors / Graphics Demo
            Cmatrix
            Toilet
                toilet -f mono12 -F "Hello SVCC!"
        x11 Server Setup
            Install Xming or VcXsrv
                https://sourceforge.net/projects/xming/
                https://sourceforge.net/projects/vcxsrv/

                Can also do via chocolatey
                    https://chocolatey.org/install
                        choco install Xming
                        choco install VcXsrv
            Demo x11 Apps
                install x11-apps
                    http://packages.ubuntu.com/trusty/i386/x11-apps/filelist
                echo 'export DISPLAY=:0' >> ~/.bashrc && . ~/.bashrc
	            sudo sed -i 's$<listen>.*</listen>$<listen>tcp:host=localhost,port=0</listen>$' /etc/dbus-1/session.conf
                
                apps demo
                    xeyes &
                    xclock &
                    xcalc &
                    apt get install xbill
                    PATH=$PATH:/usr/games (environment variable) - temprary addition
                    xbill &
                Fun
                    telnet towel.blinkenlights.nl - watch an ascii version of starwars (works in cmd prompt too, just fun)

                    gtk apps
                        apt-get install gnome-calculator
                        gnome-calculator &

                sudo apt-get install xorg xubuntu-desktop
                xfce4-session
        VS Code Demo
           Settings.json
                //bash
                {"terminal.integrated.shell.windows": "C:\\WINDOWS\\sysnative\\bash.exe",
                }

