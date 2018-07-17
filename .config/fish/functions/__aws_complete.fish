function __aws_complete
    if set -q aws_completer_path
        set -lx COMP_SHELL fish
        set -lx COMP_LINE (commandline)
        set -lx PYENV_VERSION system

        eval $aws_completer_path | command sed 's/ $//'
    end
end
