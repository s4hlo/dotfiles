# Lazy nvm, sourced by .bashrc and .zshrc.
# Sourcing nvm.sh costs ~220ms per shell, so put the newest installed node on
# PATH right away and only load nvm itself the first time `nvm` is called.

export NVM_DIR="$HOME/.nvm"

_nvm_script=
for _f in "$NVM_DIR/nvm.sh" /usr/share/nvm/nvm.sh; do
    if [ -s "$_f" ]; then
        _nvm_script=$_f
        break
    fi
done
unset _f

if [ -n "$_nvm_script" ]; then
    _node_ver=$(command ls "$NVM_DIR/versions/node" 2>/dev/null | sort -V | tail -n 1)
    [ -n "$_node_ver" ] && export PATH="$NVM_DIR/versions/node/$_node_ver/bin:$PATH"
    unset _node_ver

    nvm() {
        unset -f nvm
        . "$_nvm_script"
        nvm "$@"
    }
else
    unset _nvm_script
fi
