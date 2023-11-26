# Script to run multiple benchmarks at once
# Eg. multiBenchmark <Model-Name> <Cached-Location> <Number-of-runs>

model_name=$0
cached_locatin=$1

function main(){

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

    case "${model_name}" in 
        *gpt-*)
            python -m generate_trajectories -a OpenAi --traj_dir #TODO: fix
            python -m evaluate_trajectories --traj_dir  # ^^
            ;;

        *)
            python -m generate_trajectories -a Mistral_Agent --traj_dir
            python -m evaluate_trajectories -a Mistral_Agent --traj_dir
            ;;
    esac

    cd ../../
}

function ethics(){
    cd benchmarks/ethics/

    case "${model_name}" in 
        *gpt-*)
            OPENAI_API_KEY=${OPENAI_API_KEY} evaluate.py --model ${model_name}
            ;;

        *)
            python benchmarks/ethics/evaluate.py --model ${model_name} 
            ;;
    esac

    cd ../../
}

function llm_rules(){


    
}

main
