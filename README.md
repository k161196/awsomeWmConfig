## Material and Mouse driven theme for [AwesomeWM 4.3](https://awesomewm.org/)
### Original design by PapyElGringo, I modified it removing sidebar and condensing the bars to a single top panel. 

Note: This fork focuses on streamlining the config and adding some Quality of Life touches to the theme.

An almost desktop environment made with [AwesomeWM](https://awesomewm.org/) following the [Material Design guidelines](https://material.io) with a performant opiniated mouse/keyboard workflow to increase daily productivity and comfort.

[![](./theme/titus-theme/demo.png)](https://www.reddit.com/r/unixporn/comments/anp51q/awesome_material_awesome_workflow/)
*[Click to view in high quality](https://www.reddit.com/r/unixporn/comments/anp51q/awesome_material_awesome_workflow/)*

| Fullscreen   | Rofi Combo Panel | Exit screen   |
|:-------------:|:-------------:|:-------------:|
|![](./theme/titus-theme/fullscreen.png)|![](./theme/titus-theme/panel.png)|![](https://i.imgur.com/rcKOLYQ.png)|

## Installation

### 1) Get all the dependencies

#### Debian-Based

```
sudo apt install awesome fonts-roboto rofi compton i3lock xclip qt5-style-plugins materia-gtk-theme lxappearance xbacklight flameshot nautilus xfce4-power-manager pnmixer network-manager-gnome policykit-1-gnome i3lock-fancy -y
wget -qO- https://git.io/papirus-icon-theme-install | sh
```

#### Arch-Based

```
yay -S awesome rofi picom i3lock-fancy xclip ttf-roboto polkit-gnome materia-theme lxappearance flameshot pnmixer network-manager-applet xfce4-power-manager qt5-styleplugins -y
wget -qO- https://git.io/papirus-icon-theme-install | sh
```

```
sudo snap install alacritty --classic
```

#### Program list

- [AwesomeWM](https://awesomewm.org/) as the window manager - universal package install: awesome
- [Roboto](https://fonts.google.com/specimen/Roboto) as the **font** - Debian: fonts-roboto Arch: ttf-roboto
- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher - universal install: rofi
- [picom](https://github.com/yshui/picom) for the compositor (blur and animations) universal install: picom - Debian users need PPA (`sudo add-apt-repository ppa:regolith-linux/unstable`) _Note: I recommend Compton for Debian Users and the Debian Branch_
- [i3lock](https://github.com/meskarune/i3lock-fancy) the lockscreen application universal install: i3lock-fancy
- [xclip](https://github.com/astrand/xclip) for copying screenshots to clipboard package: xclip
- [gnome-polkit] recommend using the gnome-polkit as it integrates nicely for elevating programs that need root access
- [Materia](https://github.com/nana-4/materia-theme) as GTK theme - Arch Install: materia-theme debian: materia-gtk-theme
- [Papirus Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme Universal Install: wget -qO- https://git.io/papirus-icon-theme-install | sh
- [lxappearance](https://sourceforge.net/projects/lxde/files/LXAppearance/) to set up the gtk and icon theme
- (Laptop) [xbacklight](https://www.x.org/archive/X11R7.5/doc/man/man1/xbacklight.1.html) for adjusting brightness on laptops (disabled by default)
- [flameshot](https://flameshot.js.org/#/) my personal screenshot utility of choice, can be replaced by whichever you want, just remember to edit the apps.lua file
- [pnmixer](https://github.com/nicklan/pnmixer) Audio Tray icon that is in debian repositories and is easily installed on arch through AUR.
- [network-manager-applet](https://gitlab.gnome.org/GNOME/network-manager-applet) nm-applet is a Network Manager Tray display from GNOME.
- [xfce4-power-manager](https://docs.xfce.org/xfce/xfce4-power-manager/start) XFCE4's power manager is excellent and a great way of dealing with sleep, monitor timeout, and other power management features.

### 2) Clone the configuration

Arch-Based Installs
```
git clone https://github.com/k161196/awsomeWmConfig.git ~/.config/awesome
```

Debian-Based Installs
```
git clone --branch main https://github.com/k161196/awsomeWmConfig.git ~/.config/awesome
```

### 3) Set the themes

Start `lxappearance` to active the **icon** theme and **GTK** theme
Note: for cursor theme, edit `~/.icons/default/index.theme` and `~/.config/gtk3-0/settings.ini`, for the change to also show up in applications run as root, copy the 2 files over to their respective place in `/root`.

Recommended Cursors - <https://github.com/keeferrourke/capitaine-cursors>

Set Rofi Theme
```
mkdir -p ~/.config/rofi
cp $HOME/.config/awesome/theme/config.rasi ~/.config/rofi/config.rasi
sed -i '/@import/c\@import "'$HOME'/.config/awesome/theme/sidebar.rasi"' ~/.config/rofi/config.rasi
```

### 4) Same theme for Qt/KDE applications and GTK applications, and fix missing indicators

First install `qt5-style-plugins` (debian) | `qt5-styleplugins` (arch) and add this to the bottom of your `/etc/environment`

```bash
XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2
```

The first variable fixes most indicators (especially electron based ones!), the second tells Qt and KDE applications to use your gtk2 theme set through lxappearance.


### 5) xinput 
    ```
    xinput list
    ```
    select Touchpad replace in app.lua
### 6) Read the documentation

The documentation live within the source code.

The project is split in functional directories and in each of them there is a readme where you can get additional information about the them.

* [Configuration](./configuration) is about all the **settings** available
* [Layout](./layout) hold the **disposition** of all the widgets
* [Module](./module) contain all the **features** available
* [Theme](./theme) hold all the **aesthetic** aspects
* [Widget](./widget) contain all the **widgets** available


clone https://github.com/natnat-mc/brightnessctl.git
make
sudo make install


sudo apt install blueman

To start the Bluetooth service, run this command:

sudo systemctl start bluetooth.service
To make it persistent after reboot, use this command:

sudo systemctl enable bluetooth.service
Finally, check the status of Bluetooth service using:

sudo systemctl status bluetooth.service




## Screen size 

### /etc/X11/xorg.conf.d/10-monitor.conf

```
### /etc/X11/xorg.conf.d/10-monitor.conf
Section "Monitor"
### Monitor Identity - Typically HDMI-0 or DisplayPort-0
    Identifier    "eDP-1"

### Setting Resolution and Modes
## Modeline is usually not required, but you can force resolution w>
    #Option "PreferredMode" "1366x768"
    #Option        "TargetRefresh" "60"

### Positioning the Monitor
## Basic
    #Option "RightOf" "HDMI-1"
## Advanced
    #Option        "Position" "0 0"

## Disable a Monitor

    Option         "Disable" "true"
EndSection


Section "Monitor"
### Monitor Identity - Typically HDMI-0 or DisplayPort-0
    Identifier    "HDMI-1" 

### Setting Resolution and Modes
## Modeline is usually not required, but you can force resolution with it    
    Modeline "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
    Option "PreferredMode" "1920x1080"
    Option        "TargetRefresh" "60"

### Positioning the Monitor
## Basic
    #Option "LeftOf" "eDP-1"    
## Advanced
    #Option        "Position" "1366 0"

## Disable a Monitor
EndSection 


```



clone https://github.com/natnat-mc/brightnessctl.git
make
sudo make install


sudo apt install blueman

To start the Bluetooth service, run this command:

sudo systemctl start bluetooth.service
To make it persistent after reboot, use this command:

sudo systemctl enable bluetooth.service
Finally, check the status of Bluetooth service using:

sudo systemctl status bluetooth.service




## Screen size 

### /etc/X11/xorg.conf.d/10-monitor.conf

```
### /etc/X11/xorg.conf.d/10-monitor.conf
Section "Monitor"
### Monitor Identity - Typically HDMI-0 or DisplayPort-0
    Identifier    "eDP-1"

### Setting Resolution and Modes
## Modeline is usually not required, but you can force resolution w>
    #Option "PreferredMode" "1366x768"
    #Option        "TargetRefresh" "60"

### Positioning the Monitor
## Basic
    #Option "RightOf" "HDMI-1"
## Advanced
    #Option        "Position" "0 0"

## Disable a Monitor

    Option         "Disable" "true"
EndSection


Section "Monitor"
### Monitor Identity - Typically HDMI-0 or DisplayPort-0
    Identifier    "HDMI-1" 

### Setting Resolution and Modes
## Modeline is usually not required, but you can force resolution with it    
    Modeline "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
    Option "PreferredMode" "1920x1080"
    Option        "TargetRefresh" "60"

### Positioning the Monitor
## Basic
    #Option "LeftOf" "eDP-1"    
## Advanced
    #Option        "Position" "1366 0"

## Disable a Monitor
EndSection 


```



```
sudo nano ~/.bash_aliases
alias reduceBrightness="xrandr --output HDMI-1 --brightness 0.5"
alias reduceBrightness1="xrandr --output HDMI-1 --brightness 1"
```

terminal changes
```
starship 
```

```

```


```
sudo nano ~/.bash_aliases
alias reduceBrightness="xrandr --output HDMI-1 --brightness 0.5"
alias reduceBrightness1="xrandr --output HDMI-1 --brightness 1"
alias watch-nvidia="watch -n -1 nvidia-smi"
```

terminal changes
```
starship
curl -sS https://starship.rs/install.sh | sh
eval "$(starship init bash)"
starship preset nerd-font-symbols -o ~/.config/starship.toml
```

```
https://www.nerdfonts.com/
https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
sudo mkdir ~/.fonts
sudo mv *.ttf ~/.fonts
fc-cache -fv

```

```
install nala 
```

```
lazygit 
```

```
falkon browser
```

```
dbever-ce
```

```
https://github.com/TheAssassin/AppImageLauncher/releases/tag/v2.2.0
https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-lite-2.2.0-travis995-0f91801-i386.AppImage
```
```
https://medium.com/@bigdsdojo/utilizing-nvidia-gpu-for-specific-applications-on-linux-a-simple-script-approach-6bb122cc5b3c

```
```
#nv-run
#!/bin/bash

# Check if at least one argument is provided
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <program> [arguments]"
    exit 1
fi

# Get the program name and the arguments
program=$1
shift  # Shift the arguments to remove the first one
arguments="$@"

# Run the program with the NVIDIA GPU
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia $program $arguments
```

```
sudo mv nv-run /usr/local/bin/
sudo chmod +x /usr/local/bin/nv-run
```

```
nv-run alacritty
```
```
watch -n -1 nvidia-smi // check nvidia status
```
