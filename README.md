# omarchy-about-animated

An animated version of the Omarchy **About** screen — the same ASCII logo, the
same three fastfetch boxes, and a slow accent-coloured sheen sweeping across
the mark.

<img src="assets/preview.gif" alt="Animated Omarchy About screen" width="742">

It is a renderer, not a replacement: it reads the exact art from
`~/.config/omarchy/branding/about.txt` and the exact output of
`fastfetch --logo none`, so every detail and every theme stays intact.

## Features

- **Stock layout** — same logo, same Hardware / Software / Age-Uptime-Update
  boxes, same app id (`org.omarchy.about`), so Omarchy's float / centre / size
  rule still applies.
- **Theme aware** — the sheen uses the active theme's `accent` colour and
  updates live when you switch themes.
- **Live logo editing** — `Style → About → Edit Text` / `Set From Image`
  still works; the open window reloads the art and resizes itself.
- **No clipped rows** — the float window is resized until the terminal grid
  hugs the content.
- **Tiny** — one Python file, no third-party packages. Needs `python3`,
  `fastfetch` and `hyprctl`.

## Requirements

- Omarchy 4.x (Hyprland, foot, fastfetch)
- Python 3.10+

## Install

```bash
git clone https://github.com/sachingubhaju/omarchy-about-animated.git
cd omarchy-about-animated
./install.sh
```

The installer copies `omarchy-about-animated` and `omarchy-about` into
`~/.local/bin`.

## Open it

```bash
omarchy-about
```

or bind it yourself:

```
bind = SUPER, A, exec, omarchy-about
```

## Make it the About screen

Add the overrides from [`menu/omarchy-menu.jsonc`](menu/omarchy-menu.jsonc) to
`~/.config/omarchy/extensions/omarchy-menu.jsonc`, then run:

```bash
omarchy menu refresh
```

That replaces the stock static About and makes the logo editor reopen the
animated window. Nothing else in the menu is touched.

## Customise

### Logo

Any art works — it is the same file the stock About uses.

- Menu: `Style → About → Edit Text` / `Set From Image` / `Default`
- CLI:

  ```bash
  ${EDITOR:-nano} ~/.config/omarchy/branding/about.txt
  ```

The open About window reloads the file as soon as it changes.

### Spacing and speed

Edit the constants at the top of `bin/omarchy-about-animated`:

| Constant     | Meaning                                    | Default |
| ------------ | ------------------------------------------ | ------- |
| `LOGO_INSET` | blank rows above and below the logo        | `2`     |
| `GAP`        | columns between the logo and the boxes     | `6`     |
| `FPS`        | animation frame rate                       | `24`    |

The sheen itself lives in `paint()`: `2.2` is its speed and `** 6` is the
sharpness of the glint.

## How it works

Every frame the script draws the logo, appends the boxes from
`fastfetch --logo none`, and writes both with absolute cursor positioning under
a synchronized update (`\033[?2026h`), so the terminal never flickers.

At startup it asks Hyprland for its own window geometry, works out the cell
size, and resizes the float until the grid matches the content.

## Uninstall

```bash
rm ~/.local/bin/omarchy-about-animated ~/.local/bin/omarchy-about
```

Then remove the three `style.about.*` / `about` entries from
`~/.config/omarchy/extensions/omarchy-menu.jsonc` and run
`omarchy menu refresh`.

## Notes

- `omarchy branding about …` ends by launching the *static* About. Run
  `omarchy-about` afterwards; it closes the static window first.
- Tested on Omarchy 4.0.6, Hyprland 0.56.2, foot 1.28.0.
- Community project, not affiliated with Omarchy.

## License

MIT — see [LICENSE](LICENSE).
