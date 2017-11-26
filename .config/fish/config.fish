# Build using homebrew OpenSSL
set -x LDFLAGS -L(brew --prefix openssl)"/lib"
set -x CFLAGS -I(brew --prefix openssl)"/include"

if status --is-interactive
    # Alias for dotfiles git config
    alias dotfile="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

    # Configure rbenv
    source (rbenv init -|psub)

    # Configure pyenv
    source (pyenv init -|psub)
    source (pyenv virtualenv-init -|psub)

    # Add SSH keys
    if not ssh-add -l >/dev/null
        ssh-add -K -A
    end
end
