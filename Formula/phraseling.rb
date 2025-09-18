class Phraseling < Formula
  desc "Transform text with local AI - Private, Fast, Free"
  homepage "https://github.com/palyam/phraseling"
  url "https://github.com/palyam/phraseling/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "393bbeb16e909a0121fe379fc0e919fae288ead9660d7b403bad3b256af9b1db"
  license "MIT"
  version "1.0.0"

# depends_on "ollama"  # Optional dependency

  def install
    bin.install "bin/phraseling"

    # Install shortcut template for manual setup
    pkgshare.install "shortcuts/Phraseling.shortcut"

    # Install documentation
    doc.install "README.md"
  end

  def post_install
    puts ""
    puts "✨ Phraseling installed successfully!"
    puts ""
    puts "📋 Next steps:"
    puts "1. Install Ollama and a language model:"
    puts "   brew install ollama"
    puts "   ollama pull gpt-oss:latest"
    puts ""
    puts "2. Test the command line tool:"
    puts "   phraseling \"hello world\""
    puts ""
    puts "3. Set up Mac shortcut (optional):"
    puts "   • Open Shortcuts app → Create new shortcut"
    puts "   • Add 'Receive' action (Apps and 2 more from Quick Actions)"
    puts "   • Add 'Run Shell Script' action:"
    puts "     - Script: phraseling \"$1\""
    puts "     - Pass Input: as arguments"
    puts "   • Add 'Stop and output' action (Shell Script Result)"
    puts "   • Configure: Enable Services Menu, Use as Quick Action"
    puts "   • Save as 'Phraseling'"
    puts ""
    puts "⚠️  If shortcut shows 'command not found':"
    puts "   Use full path: #{HOMEBREW_PREFIX}/bin/phraseling \"$1\""
    puts ""
    puts "📖 Full documentation: https://github.com/palyam/phraseling"
    puts ""
  end

  test do
    # Test that the binary exists and shows help
    assert_match "Phraseling v#{version}", shell_output("#{bin}/phraseling --version")
    assert_match "Transform text with local AI", shell_output("#{bin}/phraseling --help")
  end
end