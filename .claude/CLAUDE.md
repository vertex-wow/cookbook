# wow-cookbook

WoW addon recipe cookbook — XML frame definitions and Lua patterns.

## Directory rules

- `_live/` and `_reference/` — **read-only reference**. Never edit or write to these directories. They exist for reading/diffing only.
- `docs/frames/Addons/` — source of truth for addon files. All edits go here.

## Deploying for testing

```bash
dev/install.sh
```

Copies all addons from `docs/*/Addons/` into the local WoW AddOns directory (configured in `dev/config.local.sh`). Run this after making changes, then reload UI in-game.

## Addon structure

Each addon lives in `docs/frames/Addons/<AddonName>__Vertex/` and contains:

- `<AddonName>.xml` — frame definition (the recipe)
- `<AddonName>.lua` — Lua setup code (part of the recipe, documented in README)
- `_harness.lua` — toggle-only slash command; **not** part of the recipe
- `<AddonName>__Vertex.toc` — lists files in load order: XML → Lua → harness

## Documentation rules

- **Addon changes → update the page README.** Any change to code in an `Addons/` folder must be reflected in the corresponding section of `docs/**/README.md`. The README is the recipe; the addon is the live demo.
- **New page content → consider upstream READMEs.** When adding a recipe or section to `docs/**/README.md`, check whether higher-level READMEs need updating. They get progressively more general:
  - `docs/README.md` — bare index; rarely needs touching
  - `README.md` (root) — lists individual recipes by name; add a bullet if adding a new top-level recipe, skip for sub-sections or controls
- **Live demo added → update `docs/demos.md`.** Any new `_harness.lua` in any `Addons/` subdirectory means a new row in the demos table. Assign the next available `/ev#` slot.
- **Demo renumbered → update both.** If a demo's `/ev#` changes, update the `_harness.lua` AND the corresponding row in `docs/demos.md` together.
- **Addon created or modified → run `dev/install.sh`.** After any change to files inside an `Addons/` directory (new addon or edit to existing), run `dev/install.sh` to deploy to the local WoW AddOns directory.
