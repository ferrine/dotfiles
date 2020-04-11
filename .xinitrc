xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile
# (i3status | while read LINE; do xsetroot -name "$LINE"; done) &
blueman-applet &
unclutter &
sxhkd &
exec i3
