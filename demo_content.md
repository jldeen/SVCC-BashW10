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
            3. ssh-add [keynamehere]
            3. cat ~/.ssh/keynamehere.pub | ssh [username]@[ip-address-here] -p 222 'umask 0077; mkdir -p .ssh; cat >> .ssh/authorized_keys && echo "Key copied"'

            To connect to your system running Bash on Ubuntu on Windows (server) from your client, run the following:

            ssh username@server-ip-address -p “your-port-here” and you should be able to connect now without a Password

            ** Remember to update your /etc/ssh/sshd_config file, disable PasswordAuthentication, and restart the service by typing sudo service ssh restart

        Colors / Graphics Demo
            Cmatrix
            Toilet
                toilet -f mono12 -F "Hello SVCC!"
        x11 Server Setup
            Run the install script in install folder
            
            Demo x11 Apps
                sudo apt-get install x11-apps
                #list of x11-apps
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
            * Also see settings files under "code" folder in project
