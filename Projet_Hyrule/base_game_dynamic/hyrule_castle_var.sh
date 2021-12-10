#!/bin/bash

Random=$((1 + $RANDOM % 100))
if [[ $Random -le 50 ]]; then
    rar=1
elif [[ $Random -le 80 ]]; then
    rar=2
elif [[ $Random -le 95 ]]; then
    rar=3
elif [[ $Random -le 99 ]]; then
    rar=4
else
    rar=5
fi

#player selection
while IFS=',' read -r id name hp mp str int def res spd luck race class rarity a
do
    
    if [[ "$rarity" = $rar ]]; then
	player="$name"
	player_max_hp="$hp"
	player_hp="$hp"
	player_str="$str"
    fi   
done <players.csv

#enemy selection
cpt=0
while IFS=',' read -r id name hp mp str int def res spd luck race class rarity a
do
    if [[ "$rarity" = $rar ]]; then
	cpt=$(($cpt+1))
    fi
done < enemies.csv

enm=$((1+$RANDOM % $cpt))
cpt2=1

while IFS=',' read -r id name hp mp str int def res spd luck race class rarity a
do
    if [[ "$rarity" = $rar && $cpt2 = $enm ]]; then
	enemy="$name"
	enemy_max_hp="$hp"
	enemy_hp="$hp"
	enemy_str="$str"
	cpt2=$(($cpt2+1))
    elif [[ $rarity = $rar ]]; then
	cpt2=$(($cpt2+1))
    fi
done < enemies.csv

#boss selection
cpt3=0
while IFS=',' read -r id name hp mp str int def res spd luck race class rarity a
do
    if [[ "$rarity" = $rar ]]; then
	cpt3=$(($cpt3+1))
    fi
done < bosses.csv

bs=$((1+$RANDOM % $cpt3))
cpt4=1
echo $bs
echo $rar
while IFS=',' read -r id name hp mp str int def res spd luck race class rarity a
do
    if [[ "$rarity" = $rar && $cpt4 = $bs ]]; then
	boss="$name"
	boss_max_hp="$hp"
	boss_hp="$hp"
	boss_str="$str"
	cpt4=$(($cpt4+1))
    elif [[ "$rarity" = $rar ]]; then
	cpt4=$(($cpt4+1))
    fi
done < bosses.csv
