class Mdview < Formula
  desc "Preview Markdown files in your default browser"
  homepage "https://github.com/danielhundhausen/mdview"
  url "https://github.com/danielhundhausen/mdview/releases/download/v0.0.4/mdview-0.0.4.tar.gz"
  sha256 "209417034c92a6db09bb73ca69fc1c3bc8d8fb0f692e9c89d18e433e964c93c0"
  license "MIT"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"sample.md").write("# Hello\n\n**Markdown** preview.\n\n```mermaid\nflowchart LR\nA --> B\n```\n\n```js\nconst highlighted = true;\n```\n")
    system bin/"mdview", "--no-open", "-o", "sample.html", "sample.md"
    html = (testpath/"sample.html").read
    assert_match "<h1>Hello</h1>", html
    assert_match "<strong>Markdown</strong>", html
    assert_match 'data-mdview-mermaid-runtime="12.1.0"', html
    assert_match 'class="diagram-button diagram-expand"', html
    assert_match "diagram-overlay", html
    assert_match 'data-mdview-highlight-runtime="11.12.0"', html
    assert_match 'class="language-js"', html
    assert_match 'aria-label="Copy code"', html
    assert_match 'aria-label="Expand diagram"', html
    assert_match "mdview 0.0.4", shell_output("#{bin}/mdview --version")
  end
end
