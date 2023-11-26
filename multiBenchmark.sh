# Script to run multiple benchmarks at once
# Eg. multiBenchmark <Model-Name> <Cached-Location> <Number-of-runs>

function main(){
    model_name=$0
    cached_locatin=$1

    benchmarks=()
    machiavelliParams=()
    ethicsParams=()
    echo "Choose benchmarks: \n"
    printf "%s" "1. Machiavelli [y/n]:"
    read ans && [[ $ans == [yY] || $ans == [yY][eE][sS] ]] || benchmarks+=('machiavelli')

    printf "%s" "2. Ethics [y/n]:"
    read ans && [[ $ans == [yY] || $ans == [yY][eE][sS] ]] || benchmarks+=('ethics')

    printf "%s \n" "${benchmarks}" 
}

function machiavelli(){
    cd benchmarks/machiavelli/

    python -m generate_trajectories -a Mistral_Agent

}

main
