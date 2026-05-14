class IosMcpServer < Formula
  desc "MCP server for controlling iOS simulators and apps via XCUITest"
  homepage "https://github.com/lastlookdev/ios-mcp-server"
  url "https://github.com/lastlookdev/ios-mcp-server/archive/refs/tags/0.1.1.tar.gz"
  sha256 "975de88002635da988b1a6c26e4a6eb14c097755ba54f6032e69010620052736"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/ios-mcp-server"
    bin.install ".build/release/ios-mcp-server_IOSMCPServer.bundle"
  end

  def post_install
    ohai "Run 'ios-mcp-server install' to start as a background service"
    ohai "Or run 'ios-mcp-server' to start in foreground"
  end

  def caveats
    <<~EOS
      To start the server as a background service and add to Claude Code and Codex:
        ios-mcp-server install

      To remove:
        ios-mcp-server uninstall

      To check status:
        ios-mcp-server status
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/ios-mcp-server help")
  end
end
