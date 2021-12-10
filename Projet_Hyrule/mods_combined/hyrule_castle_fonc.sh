
#!/bin/bash

--attack() {
    
    echo $(($2-$1))
    
}

--heal() {

    if [[ $1 -lt $(($2/2)) ]]; then
	echo $(($1+($2/2)))
    elif [[ $1 -ge $(($2/2)) ]]; then
	echo $2
    fi
}

--get_dmg() {

    echo $(($2-$1))

}
	
--hp_display() {

    cpt_hp=""
    for hpi in `seq 1 $1`;do
	cpt_hp=$cpt_hp"I"
    done

 
    for hpt in `seq $(($1+1)) $2`;do
	cpt_hp=$cpt_hp"_"
    done

    echo $cpt_hp  "$1 / $2"

}
