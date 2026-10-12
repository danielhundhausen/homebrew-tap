class Mdview < Formula
  desc "Preview Markdown files in your default browser"
  homepage "https://github.com/danielhundhausen/mdview"
  url "https://github.com/danielhundhausen/mdview/releases/download/v0.0.2/mdview-0.0.2.tar.gz"
  sha256 "47fad92a5970b042cbcd266da2689048b1a38ffebf3323d8dc15a9cb9217d815"
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
    assert_match "mdview 0.0.2", shell_output("#{bin}/mdview --version")
  end
end
