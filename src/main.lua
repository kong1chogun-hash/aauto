--[[
    aaauto - Anime Adventures client shell
    Keyless UI bootstrap.
    This first commit contains the UI foundation only. Gameplay automation,
    macro execution, and Discord reporting are intentionally not wired yet.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local THEME = {
    background = Color3.fromRGB(15, 17, 23),
    panel = Color3.fromRGB(21, 24, 32),
    panel2 = Color3.fromRGB(28, 32, 42),
    border = Color3.fromRGB(47, 53, 67),
    text = Color3.fromRGB(238, 241, 248),
    muted = Color3.fromRGB(145, 153, 171),
    accent = Color3.fromRGB(137, 105, 255),
    accentDark = Color3.fromRGB(83, 63, 166),
    green = Color3.fromRGB(80, 195, 137),
}

local function create(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties or {}) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function round(parent, radius)
    create("UICorner", { CornerRadius = UDim.new(0, radius or 8) }, parent)
end

local function stroke(parent, color, transparency)
    create("UIStroke", {
        Color = color or THEME.border,
        Transparency = transparency or 0,
        Thickness = 1,
    }, parent)
end

local function label(parent, text, size, color, font)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or THEME.text,
        TextSize = size or 14,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Size = UDim2.new(1, 0, 0, 22),
    }, parent)
end

local function getGuiParent()
    if typeof(gethui) == "function" then
        local ok, result = pcall(gethui)
        if ok and result then
            return result
        end
    end
    return CoreGui
end

local guiParent = getGuiParent()
local old = guiParent:FindFirstChild("aaauto")
if old then
    old:Destroy()
end

local screen = create("ScreenGui", {
    Name = "aaauto",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, guiParent)

local window = create("Frame", {
    Name = "Window",
    Size = UDim2.fromOffset(720, 470),
    Position = UDim2.new(0.5, -360, 0.5, -235),
    BackgroundColor3 = THEME.background,
    BorderSizePixel = 0,
}, screen)
round(window, 12)
stroke(window, THEME.border)

local topbar = create("Frame", {
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = THEME.panel,
    BorderSizePixel = 0,
}, window)
round(topbar, 12)

local title = label(topbar, "  aaauto", 17, THEME.text, Enum.Font.GothamBold)
title.Position = UDim2.fromOffset(8, 0)
title.Size = UDim2.new(0, 180, 1, 0)

local subtitle = label(topbar, "ANIME ADVENTURES", 10, THEME.muted, Enum.Font.GothamMedium)
subtitle.Position = UDim2.fromOffset(102, 2)
subtitle.Size = UDim2.new(0, 180, 1, 0)

local close = create("TextButton", {
    Text = "×",
    TextSize = 25,
    Font = Enum.Font.Gotham,
    TextColor3 = THEME.muted,
    BackgroundTransparency = 1,
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.new(1, -46, 0, 3),
}, topbar)
close.MouseButton1Click:Connect(function()
    screen:Destroy()
end)

local sidebar = create("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(12, 60),
    Size = UDim2.new(0, 164, 1, -72),
    BackgroundColor3 = THEME.panel,
    BorderSizePixel = 0,
}, window)
round(sidebar, 10)

local content = create("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(188, 60),
    Size = UDim2.new(1, -200, 1, -72),
    BackgroundColor3 = THEME.panel,
    BorderSizePixel = 0,
}, window)
round(content, 10)

local navTitle = label(sidebar, "  WORKSPACE", 10, THEME.muted, Enum.Font.GothamBold)
navTitle.Position = UDim2.fromOffset(8, 12)
navTitle.Size = UDim2.new(1, -16, 0, 22)

local navItems = {
    "Dashboard",
    "Auto Farm",
    "Unit Manager",
    "Macro",
    "Discord Reporter",
    "Settings",
    "Profiles",
    "About",
}

local pages = {}
local selectedTab
local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        child:Destroy()
    end
end

local function addInfoCard(parent, heading, body, y)
    local card = create("Frame", {
        Position = UDim2.fromOffset(14, y),
        Size = UDim2.new(1, -28, 0, 82),
        BackgroundColor3 = THEME.panel2,
        BorderSizePixel = 0,
    }, parent)
    round(card, 8)
    stroke(card, THEME.border)
    local head = label(card, heading, 14, THEME.text, Enum.Font.GothamBold)
    head.Position = UDim2.fromOffset(14, 9)
    head.Size = UDim2.new(1, -28, 0, 22)
    local desc = label(card, body, 12, THEME.muted)
    desc.Position = UDim2.fromOffset(14, 34)
    desc.Size = UDim2.new(1, -28, 0, 36)
    desc.TextWrapped = true
    desc.TextYAlignment = Enum.TextYAlignment.Top
    return card
end

local function showPage(name)
    selectedTab = name
    clearContent()

    local heading = label(content, name, 20, THEME.text, Enum.Font.GothamBold)
    heading.Position = UDim2.fromOffset(16, 12)
    heading.Size = UDim2.new(1, -32, 0, 30)

    if name == "Dashboard" then
        addInfoCard(content, "Welcome to aaauto", "Keyless startup is enabled. The client opens directly without a key prompt.", 54)
        addInfoCard(content, "Project status", "UI foundation is online. Game automation modules are not connected in this build yet.", 148)
        addInfoCard(content, "Supported game", "Anime Adventures only. No other game modules are loaded.", 242)
    elseif name == "Auto Farm" then
        addInfoCard(content, "Auto Farm", "Module not implemented yet. This page is reserved for Anime Adventures farming controls.", 54)
    elseif name == "Unit Manager" then
        addInfoCard(content, "Unit Manager", "Module not implemented yet. Unit selection and placement controls will be added here.", 54)
    elseif name == "Macro" then
        addInfoCard(content, "Macro system", "Recording and predefined macro playback are planned. No inputs are recorded in this build.", 54)
    elseif name == "Discord Reporter" then
        addInfoCard(content, "End-of-run report", "Discord reporting and rare-drop alerts are planned. No webhook or token is requested or transmitted by this UI shell.", 54)
    elseif name == "Settings" then
        addInfoCard(content, "Interface", "The current build uses a dark theme with a violet accent. Theme controls will be added in a later pass.", 54)
    elseif name == "Profiles" then
        addInfoCard(content, "Profiles", "Profile save/load is not connected yet. No local files are created by this build.", 54)
    elseif name == "About" then
        addInfoCard(content, "aaauto", "Anime Adventures-only project. Keyless loader and initial interface shell.", 54)
        addInfoCard(content, "Safety", "This build does not execute remote game commands or automate gameplay.", 148)
    end
end

for index, name in ipairs(navItems) do
    local button = create("TextButton", {
        Name = name:gsub("%s+", ""),
        Text = "  " .. name,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = THEME.muted,
        BackgroundColor3 = THEME.panel,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(8, 42 + (index - 1) * 39),
        Size = UDim2.new(1, -16, 0, 32),
        AutoButtonColor = false,
    }, sidebar)
    round(button, 7)
    button.MouseButton1Click:Connect(function()
        for _, item in pairs(pages) do
            item.BackgroundColor3 = THEME.panel
            item.TextColor3 = THEME.muted
        end
        button.BackgroundColor3 = THEME.accentDark
        button.TextColor3 = THEME.text
        showPage(name)
    end)
    pages[index] = button
end

pages[1].BackgroundColor3 = THEME.accentDark
pages[1].TextColor3 = THEME.text
showPage("Dashboard")

-- Drag the window using the top bar.
local dragging = false
local dragStart
local startPosition
topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = window.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        window.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

print("[aaauto] UI loaded successfully (keyless build).")
return screen
