xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile
(i3status | while read LINE; do xsetroot -name "$LINE"; done) &
sxhkd &
exec dwm
