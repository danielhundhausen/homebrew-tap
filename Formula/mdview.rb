class Mdview < Formula
  desc "Preview Markdown files in your default browser"
  homepage "https://github.com/danielhundhausen/mdview"
  url "https://github.com/danielhundhausen/mdview/releases/download/v0.0.7/mdview-0.0.7.tar.gz"
  sha256 "03547c4c091db15d018b768d9d122181611cc355a4fa392a3ce874b6a49f044c"
  license "MIT"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"sample.md").write("# Hello\n\n**Markdown** preview.\n\n```mermaid\nflowchart LR\nA --> B\n```\n\n```js\nconst highlighted = true;\n```\n\nInline $E = mc^2$.\n")
    system bin/"mdview", "--no-open", "--toc", "-o", "sample.html", "sample.md"
    html = (testpath/"sample.html").read
    assert_match '<h1 id="hello" tabindex="-1">Hello', html
    assert_match 'data-heading-id="hello"', html
    assert_match 'data-mdview-headings', html
    assert_match "<strong>Markdown</strong>", html
    assert_match 'data-mdview-mermaid-runtime="12.1.0"', html
    assert_match 'class="diagram-button diagram-expand"', html
    assert_match "diagram-overlay", html
    assert_match 'data-mdview-highlight-runtime="11.12.0"', html
    assert_match 'class="language-js"', html
    assert_match 'aria-label="Copy code"', html
    assert_match 'aria-label="Expand diagram"', html
    assert_match 'data-mdview-math-runtime="3.2.2"', html
    assert_match "mdview 0.0.7", shell_output("#{bin}/mdview --version")
  end
end
