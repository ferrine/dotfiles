xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile
# (i3status | while read LINE; do xsetroot -name "$LINE"; done) &
# blueman-applet &
xss-lock -l -- screenlock -n &
unclutter &
sxhkd -m -1&
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
exec i3
