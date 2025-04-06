# If no "$HOME" environment variable is available, set one in the /tmp folder
if [[ -z "$HOME" ]]; then
    HOME=/tmp
fi

# You may need to manually set your language environment
LANG='en_US.UTF-8'
export LANG

# Preferred language order
LC_ALL="$LANG"
export LC_ALL

znap_main() {
    # ZSH
    ZSH_ROOT_DIR="$HOME"/.local/share/zsh

    # Znap
    ZNAP_ROOT_DIR="$ZSH_ROOT_DIR"/znap
    ZNAP_REPOSITORIES_DIR="$ZNAP_ROOT_DIR"/repositories
    ZNAP_PLUGINS_DIR="$ZNAP_ROOT_DIR"/plugins

    ZSH="$ZNAP_REPOSITORIES_DIR/ohmyzsh/ohmyzsh"
    export ZSH

    if [ ! -d "$ZNAP_ROOT_DIR" ]; then
      mkdir -p -v "$ZNAP_ROOT_DIR"
    fi

    local znap_git_repository_url
    znap_git_repository_url="https://github.com/marlonrichert/zsh-snap.git"

    # Download Znap, if it's not there yet.
    if [[ -r "$ZNAP_ROOT_DIR"/znap/znap.zsh ]]; then
        local git_clone_args
        git_clone_args=(
            --depth 1
            --
            "$znap_git_repository_url"
            "$ZNAP_ROOT_DIR"/znap
        )

        git clone "${git_clone_args[@]}"
    fi

    # Znap
    source "$ZNAP_ROOT_DIR"/znap/znap.zsh

    # Change repositories and plugins directories
    zstyle ':znap:*' repos-dir "$ZNAP_REPOSITORIES_DIR"
    zstyle ':znap:*' plugins-dir "$ZNAP_PLUGINS_DIR"

    # Load Oh My Zsh
    znap source ohmyzsh/ohmyzsh

    # znap source sorin-ionescu/prezto modules/{environment,history}
    znap source marlonrichert/zsh-edit

    # Load `zsh-completions` plugin
    znap source zsh-users/zsh-completions

    # Load `zsh-autosuggestions`
    ZSH_AUTOSUGGEST_STRATEGY=( history )
    znap source zsh-users/zsh-autosuggestions

    # Load `zsh-syntax-highlighting`
    ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
    znap source zsh-users/zsh-syntax-highlighting

    # Set OMZ theme 
    # ZSH_THEME="agnoster"
    ZSH_THEME="afowler"

    # Load Oh My Zsh
    source "$ZSH"/oh-my-zsh.sh

    # Load `zsh-histdb`
    # znap source larkery/zsh-histdb

    # Colors
    znap source marlonrichert/zcolors
    znap eval   marlonrichert/zcolors "zcolors ${(q)LS_COLORS}"
    znap eval trapd00r/LS_COLORS "$( whence -a dircolors gdircolors ) -b LS_COLORS"

    # Load `pyenv` when needed
    znap function _pyenv pyenv              'eval "$( pyenv init - --no-rehash )"'
    compctl -K    _pyenv pyenv

    # Load `pip` when needed
    znap function _pip_completion pip       'eval "$( pip completion --zsh )"'
    compctl -K    _pip_completion pip

    # Load `pipx` when needed
    znap function _python_argcomplete pipx  'eval "$( register-python-argcomplete pipx  )"'
    complete -o nospace -o default -o bashdefault \
               -F _python_argcomplete pipx

    # Load `pipenv` when needed
    znap function _pipenv pipenv            'eval "$( pipenv --completion )"'
    compdef       _pipenv pipenv

    # Lazy load `sdkman`
    SDKMAN_DIR="$HOME/.sdkman"
    export SDKMAN_DIR
    znap function _sdk sdk 'source "$SDKMAN_DIR/bin/sdkman-init.sh"'
    compdef _sdk sdk

    # Load `emsdk` when needed
    znap function _emsdk emsdk 'source "$EMSDK_PATH"/emsdk_env.sh'
    compdef _emsdk emsdk

    # Load `zoxide` when needed
    # See: https://github.com/ajeetdsouza/zoxide
    znap function _zoxide zoxide 'eval "$( zoxide init zsh --cmd cd )"'
    compctl -K    _zoxide zoxide

    # Load `tmuxinator` when needed
    znap function _tmuxinator tmuxinator 'eval "$( tmuxinator completion zsh )"'
    compctl -K    _tmuxinator tmuxinator

    # Load `tmuxinator` when needed
    znap function _tmuxinator tmuxinator 'eval "$( tmuxinator completion zsh )"'
    compctl -K    _tmuxinator tmuxinator
}

znap_main