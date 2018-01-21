# Build using homebrew OpenSSL
if type -q brew
    set -x LDFLAGS -L(brew --prefix openssl)"/lib"
    set -x CFLAGS -I(brew --prefix openssl)"/include"
end

if status --is-interactive
    # Alias for dotfiles git config
    alias dotfile="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

    # Configure rbenv
    if type -q rbenv
        source (rbenv init -|psub)
    end

    if test -e ~/.pyenv/bin
        # Configure for local .pyenv
        set -x PYENV_ROOT ~/.pyenv
        set PATH $PYENV_ROOT/bin $PATH
    end

    # Configure pyenv
    if type -q pyenv
        source (pyenv init -|psub)
        source (pyenv virtualenv-init -|psub)
    end

    # Add SSH keys
    if not ssh-add -l >/dev/null
        set _ssh_add_args ""
        if test (uname -s) = "Darwin"
            set _ssh_add_args $_ssh_add_args -K
        end
        ssh-add $_ssh_add_args -A
    end

    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end
