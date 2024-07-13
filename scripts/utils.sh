install_package() {
    package=$1
    if dpkg -l | grep -q "^ii  $package "; then
        echo " ✅ - $package is already installed."
    else
        sudo apt install -y $package
        echo " ✅ - $package installation finished"
    fi
}

ask_and_execute() {
    local prompt_message=$1
    local script_path=$2
    local setup_function=$3

    while true; do
        read -p "$prompt_message? (y/n): " yn
        case $yn in
        [Yy]*) 
            . $script_path
            $setup_function
            return 0
            ;;
        [Nn]*) 
            echo " 🟡 Skipping $prompt_message"
            return 1
            ;;
        esac
    done
}
