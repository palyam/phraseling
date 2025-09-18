# ✨ Phraseling

> Transform any text instantly with local AI - no internet required, completely private

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/platform-macOS-lightgrey)](https://www.apple.com/macos/)
[![Powered by Ollama](https://img.shields.io/badge/powered%20by-Ollama-blue)](https://ollama.ai)

Phraseling is a powerful command-line tool that uses local AI models to instantly improve your text. Perfect for emails, documents, code comments, or any text that needs a professional touch.

## ✨ Features

- 🔒 **100% Private** - Everything runs locally, your text never leaves your machine
- ⚡ **Lightning Fast** - Instant text transformation with local AI models
- 🎨 **Multiple Styles** - Professional, casual, formal writing modes
- 🔗 **Mac Integration** - Works seamlessly with any Mac app via shortcuts
- 💰 **Free Forever** - No subscriptions, no API costs
- 🛠 **Highly Configurable** - Custom models, prompts, and styles

## 🚀 Quick Start

### Option 1: Homebrew (Recommended)

```bash
# Add our tap
brew tap palyam/phraseling

# Install
brew install phraseling

# Pull an AI model
ollama pull gpt-oss:latest

# Test it out
phraseling "hey whats up how r u doing"
```

### Option 2: One-line Install

```bash
curl -fsSL https://install.phraseling.com | bash
```

That's it! The installer handles everything: Homebrew, Ollama, models, and Mac shortcuts.

## 📖 Usage

### Command Line

```bash
# Basic usage
phraseling "your text here"

# Different styles
phraseling --style=professional "casual text here"
phraseling --style=casual "very formal business text here"
phraseling --style=formal "hey buddy whats up"

# Different models
phraseling --model=llama2 "text to rephrase"
phraseling --model=codellama "code comment to improve"

# View options
phraseling --help
phraseling --config
phraseling --log
```

### Mac Shortcuts Integration

1. **Create the shortcut manually**:
   - Open the **Shortcuts** app on your Mac
   - Click **"+"** to create a new shortcut
   - Add **"Receive"** action → Set to **"Apps and 2 more"** from **"Quick Actions"**
   - Add **"Run Shell Script"** action with these settings:
     - **Script**: `phraseling "$1"`
     - **Shell**: `zsh...`
     - **Input**: `Shortcut Input`
     - **Pass Input**: `as arguments`
     - **Run as Administrator**: ✓ (checked)
   - Add **"Stop and output"** action → Set to **"Shell Script Result"**

2. **Configure shortcut settings**:
   - **Details tab**:
     - ✓ Show in Share Sheet
     - ✓ Show in Spotlight
     - ✓ Use as Quick Action
     - ✓ Services Menu
     - ✓ Provide Output
     - **Run with**: `⌃⌥Q` (or your preferred shortcut)

   - **Privacy tab**:
     - ✓ Allow Running When Locked
     - ✓ Allow this shortcut to access **Shell**

3. **Save and use**:
   - Save the shortcut as **"Phraseling"**
   - Select text in any app
   - Press your keyboard shortcut (`⌃⌥Q`)
   - Text gets replaced with improved version

> **Note**: Due to macOS security restrictions, shortcut files cannot be auto-imported during installation.

### Examples

**Input:** `hey can u check this out and let me know what u think`

**Output:** `Could you please review this and share your thoughts?`

---

**Input:** `The business had an overview meeting today with the Data Privacy Team`

**Output:** `Today, the business met with the Data Privacy Team for an overview session.`

## 🔧 Configuration

Phraseling stores configuration in `~/.phraseling/config`:

```bash
# Default model to use
MODEL="gpt-oss:latest"

# Default prompt style
PROMPT_STYLE="professional"
```

View current settings:
```bash
phraseling --config
```

## 📝 Available Models

Any Ollama model works! Popular choices:

```bash
# Lightweight and fast
ollama pull llama2

# Code-focused
ollama pull codellama

# Larger, higher quality
ollama pull gpt-oss:latest

# Specialized models
ollama pull mistral
ollama pull neural-chat
```

## 🎨 Prompt Styles

- **`professional`** (default) - Clear, polished business writing
- **`casual`** - Friendly, conversational tone
- **`formal`** - Academic or official document style

## 📊 Logging

Phraseling keeps a daily log of all operations:

```bash
# View today's log
phraseling --log

# Clear log
phraseling --clear-log
```

Logs are automatically cleaned daily and stored in `~/.phraseling/rephraser.log`.

## 🛠 Advanced Usage

### Custom Prompts

Edit the source code to add your own prompt styles:

```bash
# Find the script
which phraseling

# Edit the generate_prompt function
vim $(which phraseling)
```

### Integration with Other Tools

```bash
# Pipe text
echo "some text" | xargs phraseling

# From file
phraseling "$(cat draft.txt)"

# In shell scripts
IMPROVED_TEXT=$(phraseling "$ORIGINAL_TEXT")
```

## 🔍 Troubleshooting

### Common Issues

**"Command not found"**
```bash
# Make sure it's in your PATH
echo $PATH
source ~/.zshrc

# Or install via Homebrew
brew install palyam/phraseling/phraseling
```

**"Ollama not found"**
```bash
# Install Ollama
brew install ollama

# Or download from https://ollama.ai
```

**"No AI model found"**
```bash
# Download a model
ollama pull gpt-oss:latest

# List available models
ollama list
```

**Mac shortcut not working**
1. Recreate the shortcut manually in Shortcuts app
2. Check System Settings → Privacy & Security → Automation
3. Ensure Shortcuts app has necessary permissions
4. Verify the shell script is correct: `echo "$1" | xargs phraseling`

### Debug Mode

```bash
# Check configuration
phraseling --config

# View logs
phraseling --log

# Test with verbose output
set -x
phraseling "test text"
set +x
```

## 🏗 Development

### Repository Structure

```
phraseling/
├── bin/
│   └── phraseling                # Main executable
├── shortcuts/
│   └── Phraseling.shortcut       # Mac shortcut template
├── Formula/
│   └── phraseling.rb             # Homebrew formula
├── install.sh                   # One-line installer
├── README.md                    # This file
└── LICENSE                      # MIT license
```

### Building from Source

```bash
# Clone repository
git clone https://github.com/palyam/phraseling.git
cd phraseling

# Make executable
chmod +x bin/phraseling

# Install locally
cp bin/phraseling /usr/local/bin/

# Test
phraseling --version
```

### Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📋 Requirements

- **macOS** 12.0 or later
- **Ollama** (automatically installed)
- **At least 4GB RAM** (for AI models)
- **2GB disk space** (for models)

## 📈 Homebrew + GitHub Integration

**Yes, Homebrew works perfectly with GitHub!** Here's how:

### 🍺 How Homebrew + GitHub Works

1. **Main Repository**: `github.com/palyam/phraseling`
   - Contains your source code and releases
   - Users download from here

2. **Homebrew Tap**: `github.com/palyam/homebrew-phraseling`
   - Contains the Formula (recipe) for installation
   - Points to releases in your main repository

3. **Installation Flow**:
   ```bash
   brew tap palyam/phraseling        # Adds your tap
   brew install phraseling             # Downloads from GitHub & installs
   ```

### 🚀 Deployment Steps

1. **Create main repository**: `phraseling`
2. **Create tap repository**: `homebrew-phraseling`
3. **Push code and create release**: GitHub handles the rest!

## 🤝 Support

- 📚 **Documentation**: See this README
- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/palyam/phraseling/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/palyam/phraseling/discussions)

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Ollama](https://ollama.ai) - For making local AI accessible
- [Homebrew](https://brew.sh) - For excellent package management
- The open-source AI community

---

**⭐ If you find this useful, please star the repository!**

*Transform your text with local AI - Private, Fast, Free* ✨