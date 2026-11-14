-- aaauto shared utility functions
local Functions = {}

function Functions.Log(message)
    print("[aaauto] " .. tostring(message))
end

function Functions.SafeCall(label, callback, ...)
    local args = {...}
    local ok, result = pcall(function()
        return callback(unpack(args))
    end)
    if not ok then
        warn("[aaauto] " .. tostring(label) .. ": " .. tostring(result))
    end
    return ok, result
end

return Functions
