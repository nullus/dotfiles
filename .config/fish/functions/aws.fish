function aws -d "Wrap AWS CLI to use default Python version"
    set -lx PYENV_VERSION system
    command aws $argv
end