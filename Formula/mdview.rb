class Mdview < Formula
  desc "Preview Markdown files in your default browser"
  homepage "https://github.com/danielhundhausen/mdview"
  url "https://github.com/danielhundhausen/mdview/releases/download/v0.0.8/mdview-0.0.8.tar.gz"
  sha256 "eb8c805564abe4fe4994713993e62897138c92977ed9a0ebc9e906cb315e51cb"
  license "MIT"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"sample.md").write <<~MARKDOWN
      # Hello

      **Markdown** preview.

      ```mermaid
      flowchart LR
      A --> B
      ```

      ```js
      const highlighted = true;
      ```

      Inline $E = mc^2$.
    MARKDOWN
    system bin/"mdview", "--no-open", "--toc", "-o", "sample.html", "sample.md"
    html = (testpath/"sample.html").read
    assert_match '<h1 id="hello" tabindex="-1">Hello', html
    assert_match 'data-heading-id="hello"', html
    assert_match "data-mdview-headings", html
    assert_match "<strong>Markdown</strong>", html
    assert_match 'data-mdview-mermaid-runtime="12.1.0"', html
    assert_match 'class="diagram-button diagram-expand"', html
    assert_match "diagram-overlay", html
    assert_match 'data-mdview-highlight-runtime="11.12.0"', html
    assert_match 'class="language-js"', html
    assert_match 'aria-label="Copy code"', html
    assert_match 'aria-label="Expand diagram"', html
    assert_match 'data-mdview-math-runtime="3.2.2"', html
    assert_match "mdview 0.0.8", shell_output("#{bin}/mdview --version")
  end
end
