# Build using homebrew OpenSSL

if type -q brew
    if not set -q  __brew_prefix_openssl
        set -U __brew_prefix_openssl (brew --prefix openssl)
    end

    set -gx LDFLAGS "-L$__brew_prefix_openssl/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib -L/usr/local/opt/qt/lib"
    set -gx CPPFLAGS "-I$__brew_prefix_openssl/include -I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include -I/usr/local/opt/qt/include"
    set -gx PKG_CONFIG_PATH "/usr/local/opt/zlib/lib/pkgconfig:/usr/local/opt/sqlite/lib/pkgconfig:/usr/local/opt/qt/lib/pkgconfig"

    # Prefer OpenSSL installed by homebrew, Qt
    set PATH "$__brew_prefix_openssl/bin" "/usr/local/opt/qt/bin" $PATH

    # Add to PATH for homebrew
    set PATH "/usr/local/sbin" $PATH
end

if status --is-interactive
    # Alias for dotfiles git config
    alias dotfile="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

    # Configure rbenv
    if type -q rbenv
        source (rbenv init -|psub)
    end

    if test -e ~/.pyenv; and not set -q PYENV_ROOT
        # Configure for local .pyenv
        set -gx PYENV_ROOT ~/.pyenv
        if test -e $PYENV_ROOT/bin
            set PATH $PYENV_ROOT/bin $PATH
        end
        source (pyenv init -|psub)
        source (pyenv virtualenv-init -|psub)
    end

    if test -d /usr/local/opt/gettext/bin
        set PATH $PATH /usr/local/opt/gettext/bin
    end

    # Add AWS completions
    if not set -q aws_completer_path
        set -g aws_completer_path (type -P aws_completer ^/dev/null)
    end
    complete --command aws --no-files --arguments '(__aws_complete)'

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

    define_aws_profile admin yellow

    # Puppet install
    test -d /opt/puppetlabs/bin ; and set -x PATH $PATH "/opt/puppetlabs/bin"

    # Activate iTerm2 shell integration
    test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end
