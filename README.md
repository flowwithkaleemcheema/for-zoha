# A Field for Zoha

An interactive apology. It opens on a dark, empty field at night; every tap
grows a sunflower where your finger lands, and each of the first seven carries
one line of the apology. As the field fills, the sky lifts from midnight to
sunrise, and a letter arrives on paper. The field is saved to `localStorage`,
so it is still standing on the next visit.

The flowers are drawn live on a canvas, not images: 21 petals over 13
(Fibonacci, as real sunflowers are), with the seed head laid out on the
137.5-degree golden-angle spiral.

## Files

| file | what it is |
| --- | --- |
| `field-for-zoha.html` | the source — page body only, no `<head>` |
| `build.sh` | wraps that body into a standalone `index.html` |
| `index.html` | generated; the page GitHub Pages serves |
| `robots.txt` | keeps the page out of search results |

Edit `field-for-zoha.html`, then run `./build.sh` and commit both files.

No build tooling, no dependencies. Fonts come from Google Fonts; everything
else is self-contained.
