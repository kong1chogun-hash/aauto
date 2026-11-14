-- aaauto Auto Farm controller scaffold.
-- Uses an explicitly supplied screen-input adapter only; never calls game remotes.
local AutoFarm = {}

function AutoFarm.Init(settings, context)
    local config = {
        Enabled = settings and settings.Enabled == true,
        Mode = settings and settings.Mode or "Story",
        Stage = settings and settings.Stage or "",
        Repeat = settings and settings.Repeat == true,
        MaxRuns = math.max(1, tonumber(settings and settings.MaxRuns) or 1),
    }
    local status = "Idle"
    local running = false
    local adapter = context and context.InputAdapter

    local controller = {}

    function controller.GetConfig()
        local copy = {}
        for key, value in pairs(config) do copy[key] = value end
        return copy
    end

    function controller.SetMode(mode)
        local allowed = {
            ["Story"] = true,
            ["Infinite"] = true,
            ["Event / Portal"] = true,
            ["Legend Stages"] = true,
        }
        if allowed[mode] then config.Mode = mode end
        return config.Mode
    end

    function controller.SetStage(stage)
        config.Stage = tostring(stage or ""):sub(1, 100)
        return config.Stage
    end

    function controller.GetStatus()
        return status
    end

    function controller.Start()
        if running then return false, "Already running" end
        if config.Stage == "" then
            status = "Select a stage first"
            return false, status
        end
        if type(adapter) ~= "table"
            or type(adapter.Click) ~= "function"
            or type(adapter.PressKey) ~= "function" then
            status = "Input adapter missing — automation locked"
            return false, status
        end
        -- Deliberately fail closed until the adapter and game UI flow are reviewed.
        status = "Adapter detected — stage flow not configured"
        return false, status
    end

    function controller.Stop()
        running = false
        status = "Stopped"
        return true
    end

    return controller
end

return AutoFarm
