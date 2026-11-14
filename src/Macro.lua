-- aaauto macro module interface
-- Recording/playback is not implemented in this scaffold.
local Macro = {}

function Macro.Init(settings)
    return {
        Enabled = settings and settings.Enabled == true,
        Mode = settings and settings.Mode or "Manual",
        Status = "Not implemented",
    }
end

return Macro
