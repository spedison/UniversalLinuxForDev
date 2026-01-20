#!/usr/bin/env bash
set -euo pipefail

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
    graphviz
    latexmk
    tth
    openssh
    make
    cmake
    gcc
    shellcheck
    gh
    httppie
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
)

LOG_FILE="$HOME/brew_install.log"
BREW_ENV_LOADED=0

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
        if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        elif [[ -d "/opt/homebrew/bin" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        BREW_ENV_LOADED=1
    fi
}

# 2. Verificar se o brew está instalado
if ! command -v brew &>/dev/null; then
    log "Homebrew não encontrado. Instalando..."

    export HOMEBREW_PREFIX="$HOME/homebrew"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
    export HOMEBREW_CACHE="$HOME/.cache/homebrew"
    
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    HOME_BREW=$HOME/homebrew/bin/brew
    CMD_LINE="$HOME_BREW shellenv"
    CMD_EVAL="eval \"\$($CMD_LINE)\""
    #
    #BREW_SHELLENV='eval "$('$HOME_BREW' shellenv)"'

    
    # Adiciona o brew ao PATH após instalação (para sistemas baseados em Linux)
    if [[ -x "$HOME/homebrew/bin/brew" ]]; then
        $CMD_EVAL
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
for cmd in "${!apps[@]}"; do
    pkg="${apps[$cmd]}"

    if which "$cmd" &>/dev/null; then
        success "$cmd já existe no sistema. $pkg não será instalado."
    else
        log "$cmd não encontrado. Instalando $pkg via brew..."
        brew install "$pkg" >> "$LOG_FILE" 2>&1 && success "$pkg instalado com sucesso." || error "Falha ao instalar $pkg."
    fi
done

log "--------------------------------------------------"
log "Fim da execução: $(date)"
log "--------------------------------------------------"

success "Script finalizado com sucesso. Veja o log completo em: $LOG_FILE"
