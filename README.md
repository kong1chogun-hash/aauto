# aaauto

Anime Adventures-only project.

## Quick test

Run this in the supported Luau executor environment:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/kong1chogun-hash/aauto/main/Loader.lua"))()
```

## Current status

- [x] Keyless bootstrap (no key prompt or key validation)
- [x] Initial dark UI shell with violet accent
- [x] Dashboard and navigation pages
- [x] Close button and draggable window
- [ ] Anime Adventures gameplay modules
- [ ] Unit manager
- [ ] Macro recording and playback
- [ ] Discord end-of-run reporter and rare-drop alerts
- [ ] Settings and profile persistence

The current build is an interface foundation, not a completed farming script. The unfinished pages are clearly marked and do not claim to automate gameplay.

## Project layout

- `Loader.lua` — downloads and starts the project entry point.
- `src/main.lua` — keyless UI shell.

## Notes

The loader executes the current contents of this repository's `main` branch. Review changes before running updates.
