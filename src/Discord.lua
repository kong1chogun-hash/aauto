-- aaauto Discord reporter interface
-- No webhook, token, or external endpoint is bundled.
-- Network reporting is not implemented in this scaffold.
local Discord = {}

function Discord.Init(settings)
    return {
        Enabled = settings and settings.Enabled == true,
        ReportMode = settings and settings.ReportMode or "EndOfRun",
        RareDropAlert = settings and settings.RareDropAlert == true,
        Status = "Not connected",
    }
end

return Discord
