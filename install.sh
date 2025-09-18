#!/bin/bash

# Phraseling - One-line installer
# Usage: curl -fsSL https://install.phraseling.com | bash

set -e

REPO_URL="https://github.com/USERNAME/phraseling"
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="phraseling"
VERSION="1.0.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}✨ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "Phraseling is designed for macOS only."
        exit 1
    fi
}

# Check if we have required tools
check_dependencies() {
    print_status "Checking dependencies..."

    if ! command -v curl &> /dev/null; then
        print_error "curl is required but not installed."
        exit 1
    fi

    print_success "Dependencies OK"
}

# Install or check Homebrew
install_homebrew() {
    if command -v brew &> /dev/null; then
        print_success "Homebrew already installed"
        return
    fi

    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    print_success "Homebrew installed"
}

# Install Ollama
install_ollama() {
    if command -v ollama &> /dev/null; then
        print_success "Ollama already installed"
        return
    fi

    print_status "Installing Ollama..."

    # Try Homebrew first
    if command -v brew &> /dev/null; then
        brew install ollama
    else
        # Fallback to direct install
        curl -fsSL https://ollama.ai/install.sh | sh
    fi

    print_success "Ollama installed"
}

# Download and install Phraseling
install_phraseling() {
    print_status "Installing Phraseling..."

    # Create install directory
    mkdir -p "$INSTALL_DIR"

    # Download the main script
    curl -fsSL "$REPO_URL/raw/main/bin/phraseling" -o "$INSTALL_DIR/$SCRIPT_NAME"
    chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

    # Add to PATH if not already there
    add_to_path

    print_success "Phraseling installed to $INSTALL_DIR/$SCRIPT_NAME"
}

# Add install directory to PATH
add_to_path() {
    local shell_config=""
    local shell_name=$(basename "$SHELL")

    case "$shell_name" in
        "bash")
            shell_config="$HOME/.bash_profile"
            [[ -f "$HOME/.bashrc" ]] && shell_config="$HOME/.bashrc"
            ;;
        "zsh")
            shell_config="$HOME/.zshrc"
            ;;
        "fish")
            shell_config="$HOME/.config/fish/config.fish"
            ;;
        *)
            print_warning "Unknown shell: $shell_name. Please add $INSTALL_DIR to your PATH manually."
            return
            ;;
    esac

    # Check if PATH is already set
    if grep -q "$INSTALL_DIR" "$shell_config" 2>/dev/null; then
        return
    fi

    print_status "Adding $INSTALL_DIR to PATH in $shell_config"

    if [[ "$shell_name" == "fish" ]]; then
        echo "set -gx PATH $INSTALL_DIR \$PATH" >> "$shell_config"
    else
        echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$shell_config"
    fi

    # Add to current session
    export PATH="$INSTALL_DIR:$PATH"
}

# Download AI model
setup_model() {
    print_status "Setting up AI model..."

    # Start Ollama if not running
    if ! pgrep -x "ollama" > /dev/null; then
        print_status "Starting Ollama service..."
        ollama serve &
        sleep 3
    fi

    # Download default model
    print_status "Downloading language model (this may take a few minutes)..."
    ollama pull gpt-oss:latest

    print_success "AI model ready"
}

# Download Mac shortcut
install_shortcut() {
    local shortcut_dir="$HOME/Downloads"
    local shortcut_file="Phraseling.shortcut"

    print_status "Downloading Mac shortcut..."

    curl -fsSL "$REPO_URL/raw/main/shortcuts/$shortcut_file" -o "$shortcut_dir/$shortcut_file"

    print_success "Mac shortcut downloaded to $shortcut_dir/$shortcut_file"

    # Attempt to open it
    if command -v open &> /dev/null; then
        print_status "Opening shortcut for import..."
        open "$shortcut_dir/$shortcut_file"
    fi
}

# Test installation
test_installation() {
    print_status "Testing installation..."

    if command -v phraseling &> /dev/null; then
        local test_result=$(phraseling --version 2>/dev/null || echo "failed")
        if [[ "$test_result" == *"Phraseling"* ]]; then
            print_success "Installation test passed"
            return 0
        fi
    fi

    print_error "Installation test failed"
    print_warning "Try running: source ~/.zshrc (or ~/.bash_profile)"
    return 1
}

# Show completion message
show_completion() {
    echo ""
    echo -e "${PURPLE}🎉 Phraseling Installation Complete!${NC}"
    echo ""
    echo -e "${BLUE}📋 Next Steps:${NC}"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. Test the tool: phraseling \"hello world\""
    echo "3. Import the Mac shortcut (should open automatically)"
    echo "4. Assign a keyboard shortcut in System Settings"
    echo ""
    echo -e "${BLUE}📖 Quick Start:${NC}"
    echo "• Basic usage: phraseling \"your text here\""
    echo "• Different styles: phraseling --style=casual \"text\""
    echo "• Help: phraseling --help"
    echo "• View logs: phraseling --log"
    echo ""
    echo -e "${BLUE}🎨 Available Styles:${NC}"
    echo "• professional (default) - Clear, polished business writing"
    echo "• casual - Friendly, conversational tone"
    echo "• formal - Academic or official document style"
    echo ""
    echo -e "${GREEN}Transform your text with local AI! ✨${NC}"
    echo ""
}

# Main installation flow
main() {
    echo -e "${PURPLE}✨ Phraseling Installer v$VERSION${NC}"
    echo -e "${BLUE}Transform text with local AI - Private, Fast, Free${NC}"
    echo ""

    check_macos
    check_dependencies

    print_status "Starting installation..."

    # Core installations
    install_homebrew
    install_ollama
    install_phraseling

    # Setup
    setup_model
    install_shortcut

    # Test
    test_installation

    # Done
    show_completion
}

# Handle errors
trap 'print_error "Installation failed. Please check the error messages above."' ERR

# Run main installation
main "$@"