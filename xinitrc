xrdb ~/.Xresources
xmodmap ~/.Xmodmap
xset -b

#exec awesome
unclutter -idle 3 -root &
exec i3
