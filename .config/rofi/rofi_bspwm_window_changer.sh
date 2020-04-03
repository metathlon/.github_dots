#!/bin/bash
nodes=$(bspc query -N -n)
s=$(xtitle ${nodes[@]})

# echo $nodes $s
# rofi -dmenu -format i [[ -n "$s" ]] && bspc node "${nodes[$s]}" -n focused -g -f
rofi -show window
