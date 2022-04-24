local filesystem = require('gears.filesystem')

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) .. ' -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return {
  -- List of apps to start by default on some actions
  default = {
    -- terminal = 'terminator',
    -- terminal = 'kitty',
    terminal = 'gnome-terminal',
    rofi = rofi_command,
    lock = 'i3lock-fancy',
    quake = 'terminator',
    screenshot = 'flameshot screen -p ~/Pictures',
    region_screenshot = 'flameshot gui -p ~/Pictures',
    delayed_screenshot = 'flameshot screen -p ~/Pictures -d 5000',
    browser = 'brave-browser',
    chrome = 'google-chrome-stable',
    postman = 'gtk-launch brave-mfmknabcbemhbjkdppkoclnbiogmkllh-Default.desktop',
    notion = 'gtk-launch brave-momfioececahhohbolddgklgdgacbedf-Default.desktop',
    youtube = 'gtk-launch brave-agimnkijcaahngcdmfeangaknmldooml-Profile_1.desktop',
    -- editor = 'gedit', -- gui text editor
    editor = 'code', -- gui text editor
    settings = 'gnome-control-center', -- gui text editor
    
    social = 'discord',
    game = rofi_command,
    files = 'nautilus',
    music = rofi_command 
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    'compton --config ' .. filesystem.get_configuration_dir() .. '/configuration/compton.conf',
    'nm-applet --indicator', -- wifi
    'pnmixer', -- shows an audiocontrol applet in systray when installed.
    --'blueberry-tray', -- Bluetooth tray icon
    'numlockx on', -- enable numlock
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    'xfce4-power-manager', -- Power manager
     'flameshot',
     'synology-drive -minimized',
    --  'steam -silent',
    'feh --randomize --bg-fill ~/.wallpapers/*',
    -- '/usr/bin/variety',
    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    '~/.config/awesome/configuration/awspawn', -- Spawn "dirty" apps that can linger between sessions
    'xinput set-prop "SYNA32AD:00 06CB:CD50 Touchpad" "libinput Tapping Enabled" 1',
    'xinput set-prop "SYNA32AD:00 06CB:CD50 Touchpad" "libinput Natural Scrolling Enabled" 1',
    'xinput set-prop "SYNA32AD:00 06CB:CD50 Touchpad" "libinput Natural Scrolling Enabled" 1'
  }
}
