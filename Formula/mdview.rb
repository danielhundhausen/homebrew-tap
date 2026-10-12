class Mdview < Formula
  desc "Preview Markdown files in your default browser"
  homepage "https://github.com/danielhundhausen/mdview"
  url "https://github.com/danielhundhausen/mdview/releases/download/v0.0.3/mdview-0.0.3.tar.gz"
  sha256 "f85e213cb20722ae6ad0105db90c65dde7d6ab1b8f27a2a89afaaf6a8d81cae3"
  license "MIT"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"sample.md").write("# Hello\n\n**Markdown** preview.\n\n```mermaid\nflowchart LR\nA --> B\n```\n")
    system bin/"mdview", "--no-open", "-o", "sample.html", "sample.md"
    html = (testpath/"sample.html").read
    assert_match "<h1>Hello</h1>", html
    assert_match "<strong>Markdown</strong>", html
    assert_match 'data-mdview-mermaid-runtime="12.1.0"', html
    assert_match 'class="diagram-button diagram-expand"', html
    assert_match "diagram-overlay", html
    assert_match "mdview 0.0.3", shell_output("#{bin}/mdview --version")
  end
end
