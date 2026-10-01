class Mdview < Formula
  desc "Preview Markdown files in your default browser"
  homepage "https://github.com/danielhundhausen/mdview"
  url "https://github.com/danielhundhausen/mdview/releases/download/v0.0.1/mdview-0.0.1.tar.gz"
  sha256 "91850e70038005622ef145e8247051e3758d40cb5c793eae0e7a86929db743b8"
  license "MIT"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"sample.md").write("# Hello\n\n**Markdown** preview.\n")
    system bin/"mdview", "--no-open", "-o", "sample.html", "sample.md"
    html = (testpath/"sample.html").read
    assert_match "<h1>Hello</h1>", html
    assert_match "<strong>Markdown</strong>", html
    assert_match "mdview 0.0.1", shell_output("#{bin}/mdview --version")
  end
end
