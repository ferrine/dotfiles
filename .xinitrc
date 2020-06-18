xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile
# (i3status | while read LINE; do xsetroot -name "$LINE"; done) &
# blueman-applet &
xss-lock -l -- screenlock -n &
unclutter &
sxhkd -m -1&
exec i3
