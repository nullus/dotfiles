function gettext -d "Wrap gettext to use default Python version"
    set -lx PYENV_VERSION system
    command gettext $argv
end