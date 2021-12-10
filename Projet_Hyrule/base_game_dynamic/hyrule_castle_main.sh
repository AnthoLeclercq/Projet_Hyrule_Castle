#!/bin/bash
. hyrule_castle_fonc.sh
. hyrule_castle_var.sh

echo "You enter the Tower of $boss. You will have to fight his soldiers to reach the summit and defeat him. Good luck, $player."

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

for floor_nb in `seq 1 10`;
do	
    if [[ $player_hp -gt 0 ]]; then
	
	#Adaptation for boss fight
	if [[ $floor_nb = 10 ]]; then
	    enemy_max_hp=$boss_max_hp
	    enemy_hp=$boss_hp
	    enemy_str=$boss_str
	    enemy=$boss
	    echo -e "\n\n\n======================================================= WELCOME TO THE FINAL FLOOR ======================================================="
	    echo -e "You finally arrived in front of $boss. Well done!"
	    echo "Try to survive."
	else
	    enemy_hp=$enemy_max_hp
	    enemy_str=$enemy_str
	    enemy=$enemy
	    echo -e "\n\n\n======================================================= WELCOME TO THE FLOOR $floor_nb ======================================================="
	    echo "A wild $enemy appears."
	fi
	
	#Launch enemy fight
	while [[ $player_hp -gt 0 && $enemy_hp -gt 0 ]]; do

	    echo -e "\n============================== FIGHT $floor_nb ==============================="

	    echo -e "\n${RED}$enemy${NC}"
	    --hp_display $enemy_hp $enemy_max_hp

	    echo -e "\n${GREEN}$player${NC}"
	    --hp_display $player_hp $player_max_hp
	    
	    #Player turn
	    echo -e "\nWhat do you want to do?"
	    echo "1- Attack | 2- Heal"
	    act=0
	    while [[ $act != 1 ]]; do
		read -s -n 1 action
		if [[ $action = "1" ]]; then
		    enemy_hp=$(--attack $player_str $enemy_hp)
		    echo -e "\nYour attack dealt $player_str damages."
		    act=1
		elif [[ $action = "2" && $player_hp != $player_max_hp ]]; then
		    player_hp=$(--heal $player_hp $player_max_hp)
		    echo -e "\nYou used heal."
		    act=1
		elif [[ $action = "2" && $player_hp = $player_max_hp ]]; then
		    echo "Oh sweet summer child, your heatlh is already full. Don't be cringe."
		    echo "1- Attack"
		else
		    echo "Wrong input. Are you dumb ?"
		    echo "1- Attack | 2- Heal"
		fi
	    done
	    
	    #Enemy turn    
	    if [[ $enemy_hp -gt 0 ]]; then
		player_hp=$(--get_dmg $enemy_str $player_hp)
		echo -e "\n$enemy attacked and dealt $enemy_str damages."
		sleep 2
	    fi
	done

	#Fight is over
	
	if [[ $player_hp -le 0 ]]; then
	    echo "You died. Next time, chose your actions better."
	fi 
	if [[ $enemy_hp -le 0 ]]; then
	    if [[ $floor_nb = 10 ]]; then
		echo "You proved that you are a hero. Zelda likes you."
	    else    
		echo -e "Congratulations, you defeated $enemy! Navi will teleport you to the next floor."
		read -s -p "Press enter when you are ready." 
	    fi
	fi
    fi
done
