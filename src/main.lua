-- aaauto application entry point
local Main = {}

function Main.Start(context)
    local modules = context.Modules
    assert(type(modules.Config) == "table", "[aaauto] Config module missing")
    assert(type(modules.UI) == "table" and type(modules.UI.Start) == "function",
        "[aaauto] UI module missing")

    local app = modules.UI.Start(context)
    if modules.Functions and modules.Functions.Log then
        modules.Functions.Log("Started version " .. tostring(context.Version))
    else
        print("[aaauto] Started version " .. tostring(context.Version))
    end

    -- These modules expose their interfaces but remain inactive until implemented.
    context.Runtime = {
        AutoFarm = modules.AutoFarm and modules.AutoFarm.Init(modules.Config.AutoFarm, context),
        Macro = modules.Macro and modules.Macro.Init(modules.Config.Macro),
        Discord = modules.Discord and modules.Discord.Init(modules.Config.Discord),
    }
    return app
end

return Main
