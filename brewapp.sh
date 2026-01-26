#!/usr/bin/env bash
##set -euo pipefail

# 1. Lista de apps a instalar via brew
apps=(
    ca-certificates
    git
    htop
    bat
    fzf
    vim
    vint
    vimtutor-sequel
    ripgrep
    tree
    tmux
    tpm
    wget
    jq
    zoxide
    mc
    unzip
    nmap
    gnupg
    openssl
    whois
    iperf3
    tcpdump
    imagemagick
    webp
    latexml
    tth
    openssh
    make
    cmake
    gcc
    shellcheck
    gh
    httpie
    fd
    duf
    procs
    bottom
    rust
    rust-parallel
    rust-analyzer
    rust-script
    cargo-about
    cargo-all-features
    go
    google-java-format
    parallel
    fzf
    ripgrep
    node
    python
    shellcheck
    ctags
    distrobox
)

LOG_FILE="$HOME/brew_install.log"
BREW_ENV_LOADED=0
export NONINTERACTIVE=1
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew/"
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_CACHE="$HOME/.cache/homebrew"
export HOME_BREW="$HOMEBREW_PREFIX/bin/brew"

export INSTALL_HOMEBREW_PREFIX="$HOMEBREW_PREFIX"
export INSTALL_HOMEBREW_REPOSITORY="$HOMEBREW_REPOSITORY"
export INSTALL_HOMEBREW_CELLAR="$HOMEBREW_CELLAR"

export CMD_LINE="$HOME_BREW shellenv"
export CMD_EVAL="eval \"\$($CMD_LINE)\""

# Cores para mensagens
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Funções de Logs
log() {
    echo -e "${YELLOW}[INFO]${RESET} $1"
    echo "[INFO] $1" >> "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[OK]${RESET} $1"
    echo "[OK] $1" >> "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${RESET} $1"
    echo "[ERROR] $1" >> "$LOG_FILE"
}

# Função que carrega ou não variáveis do Brew
load_brew_env() {
    if [[ $BREW_ENV_LOADED -eq 0 ]]; then
        if [[ -d "$HOMEBREW_HOME/homebrew/bin" ]]; then
            eval "$($HOMEBREW_HOME/homebrew/bin/brew shellenv)"
        fi
        BREW_ENV_LOADED=1
    fi
}

# 2. Verificar se o brew está instalado
if ! command -v $HOME_BREW &>/dev/null; then
    log "Homebrew não encontrado. Instalando..."
    git clone https://github.com/Homebrew/brew "$HOMEBREW_PREFIX/Homebrew"
    mkdir -p "$HOMEBREW_PREFIX"/{bin,Cellar}
    ln -s "$HOMEBREW_PREFIX/Homebrew/bin/brew" "$HOMEBREW_PREFIX/bin/brew"
    eval "$($HOME_BREW shellenv)"
    $HOME_BREW update --force --quiet
    chmod -R go-w "$HOMEBREW_PREFIX/share/zsh"
    ### NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    #
    #BREW_SHELLENV='eval "$('$HOME_BREW' shellenv)"'

    # Adiciona o brew ao PATH após instalação (para sistemas baseados em Linux)
    if [[ -x "$HOME_BREW" ]]; then
        $HOME_BREW shellenv
        echo "$CMD_EVAL" >> "$HOME/.bashrc"
        echo "$CMD_EVAL" >> "$HOME/.zshrc"
    else
        error "Não foi possível encontrar o path do Homebrew após a instalação."
        exit 1
    fi

    success "Homebrew instalado com sucesso."
else
    success "Homebrew já está instalado."
fi


log "--------------------------------------------------"
log "Início da execução: $(date)"
log "Host: $(hostname)"
log "Usuário: $USER"
log "--------------------------------------------------"

# 3. Instalação dos apps
for cmd in "${apps[@]}"; do
    log "Processando App = $cmd"
    EXISTE_APP=$($HOME_BREW list "$cmd" 2> /dev/null | wc -l)
    log " App existe = $EXISTE_APP "
    if [[ $EXISTE_APP -ge 1 ]]; then
        success "$cmd já existe no sistema. $cmd não será instalado."
    else
        log "$cmd não encontrado. Instalando $cmd via brew..."
        $HOME_BREW install "$cmd" >> "$LOG_FILE" 2>&1 && success "$cmd instalado com sucesso." || error "Falha ao instalar $cmd."
    fi
done

log "--------------------------------------------------"
log "Fim da execução: $(date)"
log "--------------------------------------------------"

success "Script finalizado com sucesso. Veja o log completo em: $LOG_FILE"
