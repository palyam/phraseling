# 🚀 Phraseling - GitHub Deployment Guide

This guide walks you through deploying Phraseling to GitHub with Homebrew integration.

## 📋 Prerequisites

- GitHub account
- Git installed locally
- Basic command line knowledge

## 🏗 Repository Setup

### 1. Create Main Repository

1. **Go to GitHub** and create a new repository:
   - Name: `phraseling`
   - Description: `Transform text with local AI - Private, Fast, Free`
   - Public repository
   - Initialize with README: ❌ (we have our own)

2. **Clone and setup**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/phraseling.git
   cd phraseling

   # Copy all files from our build
   cp -r /Users/jp/phraseling/* .

   # Update USERNAME placeholders
   find . -type f -name "*.sh" -o -name "*.rb" -o -name "*.md" | xargs sed -i '' 's/USERNAME/YOUR_ACTUAL_USERNAME/g'

   # Initial commit
   git add .
   git commit -m "🎉 Initial release: Phraseling v1.0.0

   ✨ Features:
   - Local AI-powered text rephrasing
   - Mac Shortcuts integration
   - Multiple prompt styles
   - Daily log rotation
   - Homebrew distribution
   - One-line installer

   🔒 100% Private | ⚡ Lightning Fast | 💰 Free Forever"

   git push origin main
   ```

### 2. Create Homebrew Tap Repository

1. **Create another repository**:
   - Name: `homebrew-phraseling`
   - Description: `Homebrew tap for Phraseling`
   - Public repository

2. **Setup tap structure**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/homebrew-phraseling.git
   cd homebrew-phraseling

   # Create Formula directory
   mkdir -p Formula

   # Copy the formula
   cp /Users/jp/phraseling/Formula/phraseling.rb Formula/

   # Update USERNAME in formula
   sed -i '' 's/USERNAME/YOUR_ACTUAL_USERNAME/g' Formula/phraseling.rb

   git add .
   git commit -m "Add Phraseling formula"
   git push origin main
   ```

## 🏷 Create First Release

### 1. Tag and Release Main Repository

```bash
cd phraseling

# Create and push tag
git tag v1.0.0
git push origin v1.0.0

# GitHub Actions will automatically create the release
# Or create manually on GitHub with the binary and shortcut files
```

### 2. Update Homebrew Formula with SHA256

```bash
# Get SHA256 of the release tarball
curl -sL https://github.com/YOUR_USERNAME/phraseling/archive/refs/tags/v1.0.0.tar.gz | sha256sum

# Update Formula/phraseling.rb with the actual SHA256
cd ../homebrew-phraseling
vim Formula/phraseling.rb

# Replace SHA256_HASH_HERE with actual hash
# Commit and push
git add Formula/phraseling.rb
git commit -m "Update SHA256 for v1.0.0 release"
git push origin main
```

## 🌐 Domain Setup (Optional)

### For `install.phraseling.com`:

**Option 1: GitHub Pages Redirect**
```bash
# In your main phraseling repository
mkdir docs
echo '<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="refresh" content="0; url=https://raw.githubusercontent.com/YOUR_USERNAME/phraseling/main/install.sh">
    <title>Phraseling Installer</title>
</head>
<body>
    <p>Redirecting to Phraseling installer...</p>
    <p>If not redirected, <a href="https://raw.githubusercontent.com/YOUR_USERNAME/phraseling/main/install.sh">click here</a></p>
</body>
</html>' > docs/index.html

git add docs/
git commit -m "Add installer redirect page"
git push origin main

# Enable GitHub Pages in repository settings
# Point your domain to GitHub Pages
```

**Option 2: Direct File Hosting**
Host `install.sh` directly at your domain.

## ✅ Testing Installation

### Test Homebrew Installation

```bash
# Test the tap
brew tap YOUR_USERNAME/phraseling
brew install phraseling

# Verify it works
phraseling --version
phraseling "test message"
```

### Test One-line Installer

```bash
# Test the installer (update URL if needed)
curl -fsSL https://install.phraseling.com | bash

# Or test with GitHub raw URL
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/phraseling/main/install.sh | bash
```

## 📊 Distribution URLs

After deployment, users can install with:

### Homebrew (Primary Method)
```bash
brew tap YOUR_USERNAME/phraseling
brew install phraseling
```

### One-line Install
```bash
curl -fsSL https://install.phraseling.com | bash
```

### Manual Install
```bash
# Download binary
curl -L -o phraseling https://github.com/YOUR_USERNAME/phraseling/releases/latest/download/phraseling
chmod +x phraseling
mv phraseling /usr/local/bin/
```

## 🔄 Update Process

For new releases:

1. **Update version** in `bin/phraseling`
2. **Commit changes**: `git commit -m "Bump version to v1.0.1"`
3. **Create tag**: `git tag v1.0.1`
4. **Push tag**: `git push origin v1.0.1`
5. **Update Homebrew formula** with new SHA256
6. **Test installation** on clean system

## 🎯 Marketing & Distribution

### Launch Checklist

- ✅ Repository created and public
- ✅ Homebrew tap functional
- ✅ One-line installer working
- ✅ Documentation complete
- ✅ Installation tested on clean Mac

### Promotion Channels

1. **Developer Communities**
   - Post on Hacker News
   - Share on Reddit r/MacOS, r/commandline
   - Dev.to article
   - Product Hunt launch

2. **Social Media**
   - Twitter/X thread with demo
   - LinkedIn post
   - YouTube demo video

3. **Technical Content**
   - Blog post about local AI
   - Comparison with cloud alternatives
   - Tutorial videos

## 📈 Analytics

Consider adding (optional):
- GitHub Stars tracking
- Download counters
- Usage analytics (privacy-focused)
- Community Discord

## 🔒 Security

- Never commit API keys or secrets
- Use GitHub secrets for sensitive data
- Review all dependencies
- Keep dependencies updated

## 🆘 Troubleshooting

### Common Issues

**Formula validation errors:**
```bash
brew audit Formula/phraseling.rb
brew test phraseling
```

**Installation failures:**
- Check SHA256 matches release
- Verify all URLs are correct
- Test on clean macOS system

**Permission issues:**
- Ensure all scripts have proper permissions
- Check PATH configuration

---

## 📞 Support

After deployment:
- Monitor GitHub Issues
- Respond to user feedback
- Update documentation as needed
- Plan future features

**Your Phraseling is now ready for the world! 🚀**