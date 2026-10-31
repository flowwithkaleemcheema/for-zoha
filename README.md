# A Field for Zoha

An interactive apology. It opens on a dark, empty field at night; every tap
grows a sunflower where your finger lands, and each of the first seven carries
one line of the apology. As the field fills, the sky lifts from midnight to
sunrise, and a letter arrives on paper. The field is saved to `localStorage`,
so it is still standing on the next visit.

The flowers are drawn live on a canvas, not images: 21 petals over 13
(Fibonacci, as real sunflowers are), with the seed head laid out on the
137.5-degree golden-angle spiral.

## Half a Moon (her birthday, 1 November)

`birthday/` is the birthday page. On 1 November 2026 the moon is at last
quarter, exactly half lit, and the page is built around that: the dark half is
still whole, it just isn't lit yet. She steps outside under that moon, blows out
one candle (tap, or really blow into the microphone), and sends up eight paper
lanterns, each carrying one wish for her year. Then every light in the sky
gathers into her name, a string of lights joins the two houses on the two
hills (lit from both ends, meeting in the middle), a music box plays Happy
Birthday, and a letter arrives on lantern paper. Before midnight on her
birthday the opening shows a countdown. The moon, lanterns, candle and sunflower
are drawn live on canvas, and the music is synthesised, so there are no assets.

## Files

| file | what it is |
| --- | --- |
| `field-for-zoha.html` | the source — page body only, no `<head>` |
| `build.sh` | wraps that body into a standalone `index.html` |
| `index.html` | generated; the page GitHub Pages serves |
| `birthday.html` | the birthday page source, body only |
| `birthday/index.html` | generated; served at `/for-zoha/birthday/` |
| `robots.txt` | keeps the page out of search results |

Edit `field-for-zoha.html` or `birthday.html`, then run `./build.sh` and commit
the source and the generated page together.

No build tooling, no dependencies. Fonts come from Google Fonts; everything
else is self-contained.
