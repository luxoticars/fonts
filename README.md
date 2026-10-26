# @luxoticars/fonts

The Luxoticars brand typeface, as files a consumer's build serves from its own domain.

Not published to npm. Install from Git, pinned to a tag:

```sh
pnpm add github:luxoticars/fonts#v0.1.0
```

## Use

```css
@import "@luxoticars/fonts/fonts.css";
```

or import it from your entry file (`import "@luxoticars/fonts/fonts.css"`). Your bundler
hashes the two `.woff2` files and serves them from your own origin. That means no CORS,
no CSP change and no extra connection.

`fonts.css` defines `--font-futura` and `--font-futura-bold`, the variables
`@luxoticars/ui` reads. Preload the weight your first screen uses, with `crossorigin`.

## What is in it now

| File | Weight | Size |
|---|---|---|
| `src/files/jost-400.woff2` | 400 | ~12 KB |
| `src/files/jost-700.woff2` | 700 | ~14 KB |

Jost is SIL OFL 1.1 (`licenses/Jost-OFL.txt`) and is a stand-in until a Futura web
licence is bought. The CSS family name is the neutral `Luxoticars Brand`, so changing the
files does not change any consumer. To regenerate the files: `scripts/build-jost.sh`.

## Changing the font

1. Replace the files (never edit one in place, consumers cache them for a year).
2. Keep the `Luxoticars Brand` family name and the two variables.
3. Cut a new tag. A variable font is a new tag too: one `font-weight: 100 900` face.
4. If the files carry a commercial licence, check the licence text for domain and
   pageview limits before tagging, and keep this repository private.
