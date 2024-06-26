cd ~

# ensures my computer does not die
tmux new -d "yes 'get-battery Percent; sleep 10' | bash"

gnome_schema=org.gnome.desktop.interface
gsettings set $gnome_schema gtk-theme 'Nordic'

export MOZ_ENABLE_WAYLAND=1
export GDK_SCALE="$WS_GDK_SCALE"

# Log WLR errors and logs to the hyprland log. Recommended
export HYPRLAND_LOG_WLR=1

# Tell XWayland to use a cursor theme
export XCURSOR_THEME=Bibata-Modern-Classic

# Set a cursor size
export XCURSOR_SIZE=24

# Example IME Support: fcitx
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export SDL_IM_MODULE=fcitx
# export GLFW_IM_MODULE=ibus

export LIBVA_DRIVER_NAME=nvidia
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1

exec Hyprland
