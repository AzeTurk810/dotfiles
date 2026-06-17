-- Made by AzeTurk810
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function () 
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

-- Ekran paylaşımı və portalların Hyprland-ı tanıması üçün mütləqdir
os.execute("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
os.execute("systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland")
os.execute("systemctl --user start xdg-desktop-portal xdg-desktop-portal-hyprland")
os.execute("wl-paste --watch cliphist store &")
os.execute("/usr/lib/xdg-desktop-portal-hyprland &")
os.execute("/usr/lib/xdg-desktop-portal &")
hl.dsp.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
os.execute("pkill -9 awww-daemon")
os.execute("pkill -9 qs")
os.execute("awww-daemon &")
os.execute("qs -p ~/.config/quickshell &")
os.execute("gnome-keyring-daemon --start --components=secrets")
os.execute("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
