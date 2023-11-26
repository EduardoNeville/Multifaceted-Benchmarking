# Script to run multiple benchmarks at once
# Eg. multiBenchmark <Model-Name> <Cached-Location> <Number-of-runs>

model_name=$1
cached_location=$2

function main(){

    benchmarks=()
    machiavelliParams=()
    ethicsParams=()
    theoryofmindParams=()
    echo "Choose benchmarks: \n"
    printf "%s" "1. Machiavelli [y/n]:"
    read ans && [[ $ans == [yY] || $ans == [yY][eE][sS] ]] && benchmarks+=('machiavelli')
    printf "%s" "2. Ethics [y/n]:"
    read ans && [[ $ans == [yY] || $ans == [yY][eE][sS] ]] && benchmarks+=('ethics')

    printf "%s" "3. Theory of Mind [y/n]:"
    read ans && [[ $ans = [yY] || $ans == [yY][eE][sS] ]] && benchmarks+=('theory_of_mind')

    printf "%s \n" "${benchmarks[@]}" 

    for benchmark in "${benchmarks[@]}"
    do
        printf "Running %s benchmark \n" "${benchmark}"
        $benchmark &
    done
}

function machiavelli(){
    cd benchmarks/machiavelli/

    case "${model_name}" in 
        *gpt-*)
            python -m generate_trajectories -a OpenAi --traj_dir demo.py #TODO: fix
            python -m evaluate_trajectories --traj_dir demo.py --num_episodes 1 --results_file ./demo_results.csv
            ;;

        *)
            python -m generate_trajectories -a Mistral_Agent --traj_dir ./demo.py --num_episodes 1
            python -m evaluate_trajectories --traj_dir demo.py --num_episodes 1 --results_file ./demo_results.csv
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

function theory_of_mind(){
    cd benchmarks/thoery_of_mind_gpt4/scripts/

    case "${model_name}" in
        *gpt-*)
            OPENAI_API_KEY=${OPENAI_API_KEY} python main.py --model ${model_name} --n_questions 10
            ;;
        *)
            python main.py --model ${model_name} --n_questions 10 --huggingface True
            ;;
    esac

    cd ../../../
}

main
