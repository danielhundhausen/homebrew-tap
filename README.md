# Daniel's Homebrew tap

## mdview

[mdview](https://github.com/danielhundhausen/mdview) renders Markdown to a
styled, temporary HTML file and opens it in your default browser.

```sh
brew install danielhundhausen/tap/mdview
mdview notes.md
```

Homebrew builds the program from source. On Linux, install `xdg-open` through
your system's package manager to enable browser launching. Use `--no-open`
to render without launching a browser.

```sh
brew test danielhundhausen/tap/mdview
```

MIT license. See [LICENSE](LICENSE).
