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

    # MacOS specific configuration
    if test (uname -s) = "Darwin"
        # For sudo-ing
        if not test "$SSH_AUTH_SOCK" -a -r "$SSH_AUTH_SOCK"
            set -x SSH_AUTH_SOCK (find /private/tmp -user $USER -name Listeners -print0 2>/dev/null | xargs -0 stat -f "%m %N" | sort -rn | head -1 | cut -f 2- -d \ )
        end

        # Add SSH keys
        if not ssh-add -l >/dev/null
            ssh-add -K -A
        end
    end

    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end
