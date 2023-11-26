#!usr/bin/bash

# Script to run multiple benchmarks at once

benchmarks=('machiavelli' 'ethics')

store_benchmarks=()
function main($0, $1){
    echo "Choose benchmarks: \n"
    echo "1. Machiavelli [y/n] \n"
    echo "2. Ethics [y/n] \n"
    echo "3. \n"


}

function machiavelli($model_name, $runs){
    cd benchmarks/machiavelli/

    python -m generate_trajectories -a 
}


