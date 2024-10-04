log() {
    local content=$1
    local type=$2

    case $type in
        0)
            echo -e "\e[32m[INFO]\e[0m - $content"  # GREEN
            ;;
        1)
            echo -e "\e[33m[WARN]\e[0m - $content"  # YELLOW
            ;;
        2)
            echo -e "\e[31m[ERROR]\e[0m - $content"  # RED
            ;;
        3)
            echo -e "\e[31m[EXIT]\e[0m - $content"  # RED
            ;;
        *)
            echo -e "\e[32m[INFO]\e[0m - $content" # GREEN
            ;;
    esac
}

# Exemplo de como usar a função "log" no seu script

install_package() {
    package=$1
    if dpkg -l | grep -q "^ii  $package "; then
        log "$package is already installed." 0
    else
        # TODO: atualizar o instalador para pacman ao mudar para Arch
        sudo apt install -y $package
        log "$package installation finished" 0
    fi
}

ask_and_execute() {
    local prompt_message=$1
    local script_path=$2
    local setup_function=$3

    while true; do
        read -p "$(echo -e "\e[34m$prompt_message?\e[0m (y/n/q): ")" yn  # Blue for prompt
        case $yn in
        [Yy]*) 
            . $script_path
            $setup_function
            return 0
            ;;
        [Nn]*) 
            log "Skipping $prompt_message" 1
            return 1
            ;;
        [Qq]*) 
            log "Exiting the program." 3
            exit 0
            ;;
        *) 
            log "Invalid input, please enter y, n, or q." 2
            ;;
        esac
    done
} 
