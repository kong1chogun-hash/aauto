# aaauto

Anime Adventures-only project with a single-entry, modular, keyless loader.

## Run

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/kong1chogun-hash/aauto/main/Loader.lua"))()
```

## Module loading

`Loader.lua` downloads the modules in a fixed order and passes them to `Main.Start(context)`.

- `src/Config.lua` — shared defaults
- `src/Functions.lua` — logging and safe-call helpers
- `src/UI.lua` — initial dark interface shell
- `src/AutoFarm.lua` — Auto Farm controller scaffold (screen-input adapter required)\n- `src/Macro.lua` — macro interface placeholder
- `src/Discord.lua` — opt-in reporter interface placeholder
- `src/main.lua` — application entry point

## Current status

- [x] One-line, keyless loader
- [x] Modular download and initialization
- [x] Existing dashboard/navigation UI retained as a module
- [x] Auto Farm mode/stage controls and start/stop state interface\n- [ ] Verified screen-input adapter and stage navigation\n- [ ] Anime Adventures gameplay automation
- [ ] Unit manager
- [ ] Macro recording and playback
- [ ] Discord end-of-run reports and rare-drop alerts
- [ ] Settings and profile persistence

The Auto Farm page currently stores mode/stage selections and exposes Start/Stop controls, but real gameplay automation is locked until an executor-specific screen-input adapter and the actual game UI flow are verified. No RemoteEvent/RemoteFunction calls are used. Other unfinished modules are interfaces only. This build does not automate gameplay, send Discord messages, or record/play macros. The loader executes Lua source fetched from this repository's `main` branch; review repository changes before running it.
