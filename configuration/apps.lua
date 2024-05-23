local filesystem = require 'gears.filesystem'

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
-- local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) .. ' -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'
local rofi_command = 'env /usr/bin/rofi -dpi '
  .. get_dpi()
  .. ' -width '
  .. with_dpi(400)
  .. ' -show drun -theme '
  .. filesystem.get_configuration_dir()
  .. '/configuration/rofiThemes/1.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return {
  -- List of apps to start by default on some actions
  default = {
    -- terminal = 'gnome-terminal',
    terminal = 'nv-run alacritty',
    rofi = rofi_command,
    lock = 'i3lock-fancy',
    quake = 'terminator',
    screenshot = 'flameshot screen -p ~/Pictures',
    region_screenshot = 'flameshot gui -p ~/Pictures',
    delayed_screenshot = 'flameshot screen -p ~/Pictures -d 5000',
    browser = 'nv-run firefox',
    --browser = 'brave-browser',
    devBrowser = 'flatpak run io.gitlab.librewolf-community',
    editor = 'code', -- gui text editor
    social = 'slack',
    game = rofi_command,
    files = 'nautilus',
    music = rofi_command,
    -- settings = 'gnome-control-center', -- gui text editor
    settings = 'env XDG_CURRENT_DESKTOP=GNOME gnome-control-center', -- gui text editor
    -- postman = 'gtk-launch brave-mfmknabcbemhbjkdppkoclnbiogmkllh-Default.desktop',
    postman = 'postman',
    slack = 'gtk-launch slack.desktop',
    -- notion = 'gtk-launch brave-momfioececahhohbolddgklgdgacbedf-Default.desktop',
    notion = 'gtk-launch notion.desktop',
    youtube = 'gtk-launch brave-agimnkijcaahngcdmfeangaknmldooml-Profile_1.desktop',
    chromium = 'chromium-browser',
    chrome = 'google-chrome',
    logseq = 'flatpak run com.logseq.Logseq',
    jira = 'gtk-launch brave-dplnncmfgnlkcegohoadddndggiiljgl-Default.desktop',
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    -- 'compton --config ' .. filesystem.get_configuration_dir() .. '/configuration/compton.conf',
    'nm-applet --indicator', -- wifi
    'pnmixer', -- shows an audiocontrol applet in systray when installed.
    --'blueberry-tray', -- Bluetooth tray icon
    'numlockx on', -- enable numlock
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    'xfce4-power-manager', -- Power manager
    --  'flameshot',
    --  'synology-drive -minimized',
    --  'steam -silent',
    'feh --randomize --bg-fill ~/.wallpapers/scenes/*',
    '/usr/bin/variety',
    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    '~/.config/awesome/configuration/awspawn', -- Spawn "dirty" apps that can linger between sessions
    'xinput set-prop "SYNA7DB5:01 06CB:7DB7 Touchpad" "libinput Tapping Enabled" 1',
    'xinput set-prop "SYNA7DB5:01 06CB:7DB7 Touchpad" "libinput Natural Scrolling Enabled" 1',
    'xinput set-prop "SYNA7DB5:01 06CB:7DB7 Touchpad" "libinput Natural Scrolling Enabled" 1',
  },
}
