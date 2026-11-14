-- aaauto | Modular Keyless Loader
-- Single entry point. Modules are loaded in a fixed, explicit order.
local BASE_URL = "https://raw.githubusercontent.com/kong1chogun-hash/aauto/main/"
local MODULE_PATHS = {
    Config = "src/Config.lua",
    Functions = "src/Functions.lua",
    UI = "src/UI.lua",
    Macro = "src/Macro.lua",
    AutoFarm = "src/AutoFarm.lua",
    Discord = "src/Discord.lua",
    Main = "src/main.lua",
}

local function loadModule(name, path)
    local ok, source = pcall(function()
        return game:HttpGet(BASE_URL .. path)
    end)
    assert(ok, "[aaauto] Download failed (" .. name .. "): " .. tostring(source))
    assert(type(source) == "string" and #source > 0, "[aaauto] Empty module: " .. name)

    local chunk, compileError = loadstring(source, "@aaauto/" .. path)
    assert(type(chunk) == "function", "[aaauto] Compile failed (" .. name .. "): " .. tostring(compileError))

    local ran, result = pcall(chunk)
    assert(ran, "[aaauto] Module initialization failed (" .. name .. "): " .. tostring(result))
    return result
end

local context = {
    Version = "0.2.0",
    Modules = {},
}

local LOAD_ORDER = {"Config", "Functions", "UI", "AutoFarm", "Macro", "Discord", "Main"}
for _, name in ipairs(LOAD_ORDER) do
    context.Modules[name] = loadModule(name, MODULE_PATHS[name])
end

assert(type(context.Modules.Main) == "table" and type(context.Modules.Main.Start) == "function",
    "[aaauto] Main module must return a table with Start(context)")

local started, result = pcall(context.Modules.Main.Start, context)
assert(started, "[aaauto] Startup failed: " .. tostring(result))
return result
