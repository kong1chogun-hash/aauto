-- aaauto Loader
-- Keyless bootstrap for the aaauto client.
-- This loader downloads only the project entry point from this repository.

local SOURCE_URL = "https://raw.githubusercontent.com/kong1chogun-hash/aauto/main/src/main.lua"

local function fetchSource()
    local ok, source = pcall(function()
        return game:HttpGet(SOURCE_URL)
    end)

    if not ok then
        error("[aaauto] Failed to download client: " .. tostring(source), 0)
    end

    if type(source) ~= "string" or #source == 0 then
        error("[aaauto] Downloaded client is empty.", 0)
    end

    return source
end

local source = fetchSource()
local compile, compileError = loadstring(source, "@aaauto/src/main.lua")

if not compile then
    error("[aaauto] Lua compile error: " .. tostring(compileError), 0)
end

local ok, result = pcall(compile)
if not ok then
    error("[aaauto] Startup error: " .. tostring(result), 0)
end

return result
