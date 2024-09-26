job_setup() {
    # This config is very volatile
    . ~/dotfiles/scripts/utils.sh
    
    install_package dbeaver
    install_package gh

    echo "\e[32m[INFO]\e[0m - \e[33mSome apps must be installed direct via .deb in the official sources:\e[0m"
    echo " "
    echo "\e[36m - Insomnia\e[0m"
    echo "\e[36m - Pritunl\e[0m"
    echo "\e[36m - Discord\e[0m"
    echo " "
}
