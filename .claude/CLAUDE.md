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
