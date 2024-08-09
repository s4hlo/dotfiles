install_package() {
    package=$1
    if dpkg -l | grep -q "^ii  $package "; then
        echo "\e[32m[INFO]\e[0m - $package is already installed."  # Green for installed
    else
        sudo apt install -y $package
        echo "\e[32m[INFO]\e[0m - $package installation finished"  # Green for success
    fi
}

ask_and_execute() {
    local prompt_message=$1
    local script_path=$2
    local setup_function=$3

    while true; do
        read -p "$(echo "\e[34m$prompt_message?\e[0m (y/n/q): ")" yn  # Blue for prompt
        case $yn in
        [Yy]*) 
            . $script_path
            $setup_function
            return 0
            ;;
        [Nn]*) 
            echo "\e[33m[WARN]\e[0m - Skipping $prompt_message"  # Yellow for warning
            return 1
            ;;
        [Qq]*) 
            echo "\e[31m[EXIT]\e[0m - Exiting the program."  # Red for exit
            exit 0
            ;;
        *) 
            echo "\e[31m[ERROR]\e[0m - Invalid input, please enter y, n, or q."  # Red for error
            ;;
        esac
    done
}
