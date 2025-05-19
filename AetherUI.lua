-- // GANG HUB MODULAR GUI CORE WITH GLASSY BUBBLE & TWEEN LOADER // --

local validKey = "gang-hub-op"
local discordInvite = "yourdiscord" -- discord.gg/yourdiscord
local keyFile = "GangHubKey.txt"

local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local sg = game:GetService("StarterGui")
local http = game:GetService("HttpService")
local players = game:GetService("Players")
local player = players.LocalPlayer

-- Prevent double execution
if getgenv().GangHubLoaded then return end
getgenv().GangHubLoaded = true

-- UTILITIES

local function notify(title, text, duration)
    pcall(function()
        sg:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

-- KEY SYSTEM

local function readKey()
    local success, data = pcall(function()
        return readfile and readfile(keyFile) or nil
    end)
    if success and data then return data else return nil end
end

local function saveKey(key)
    if writefile then
        pcall(function()
            writefile(keyFile, key)
        end)
    end
end

local function promptKey()
    -- Key GUI
    local screen = Instance.new("ScreenGui")
    screen.Name = "GangHubKeyPrompt"
    screen.ResetOnSpawn = false
    screen.Parent = game.CoreGui

    local bg = Instance.new("Frame", screen)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    bg.BackgroundTransparency = 0.6

    local frame = Instance.new("Frame", bg)
    frame.Size = UDim2.new(0, 350, 0, 160)
    frame.Position = UDim2.new(0.5, -175, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
    frame.BorderSizePixel = 0
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 18)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.new(1,1,1)
    title.TextSize = 22
    title.Text = "Enter Gang Hub Key"

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0, 300, 0, 40)
    input.Position = UDim2.new(0.5, -150, 0, 60)
    input.BackgroundColor3 = Color3.fromRGB(40,40,40)
    input.TextColor3 = Color3.new(1,1,1)
    input.TextSize = 20
    input.ClearTextOnFocus = false
    input.PlaceholderText = "Your Key Here"
    input.Text = ""

    local errorLabel = Instance.new("TextLabel", frame)
    errorLabel.Size = UDim2.new(1, -20, 0, 20)
    errorLabel.Position = UDim2.new(0, 10, 0, 110)
    errorLabel.BackgroundTransparency = 1
    errorLabel.Font = Enum.Font.Gotham
    errorLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
    errorLabel.TextSize = 16
    errorLabel.Text = ""

    local submit = Instance.new("TextButton", frame)
    submit.Size = UDim2.new(0, 140, 0, 35)
    submit.Position = UDim2.new(0.5, -70, 0, 135)
    submit.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    submit.TextColor3 = Color3.new(1,1,1)
    submit.Font = Enum.Font.GothamSemibold
    submit.TextSize = 18
    submit.Text = "Submit"
    local submitCorner = Instance.new("UICorner", submit)
    submitCorner.CornerRadius = UDim.new(0, 10)

    submit.MouseEnter:Connect(function()
        ts:Create(submit, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90,90,90)}):Play()
    end)
    submit.MouseLeave:Connect(function()
        ts:Create(submit, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(70,70,70)}):Play()
    end)

    local function checkKey()
        if input.Text == validKey then
            saveKey(input.Text)
            notify("Gang Hub", "Key Accepted!", 3)
            screen:Destroy()
            spawn(function()
                wait(0.1)
                GangHub:Init()
            end)
        else
            errorLabel.Text = "Invalid Key, try again."
        end
    end

    submit.MouseButton1Click:Connect(checkKey)
    input.FocusLost:Connect(function(enterPressed)
        if enterPressed then checkKey() end
    end)
end

-- CONFIG SYSTEM (save/load toggle, slider, dropdown values)

local configFile = "GangHubConfig.json"
local config = {}

local function saveConfig()
    if writefile then
        pcall(function()
            writefile(configFile, http:JSONEncode(config))
        end)
    end
end

local function loadConfig()
    if readfile then
        local success, data = pcall(function()
            return readfile(configFile)
        end)
        if success and data then
            local ok, decoded = pcall(function()
                return http:JSONDecode(data)
            end)
            if ok and decoded then
                config = decoded
            end
        end
    end
end

-- MAIN GUI CORE

local GangHub = {}
GangHub.__index = GangHub

function GangHub:Init()
    loadConfig()

    -- Create ScreenGui
    local screen = Instance.new("ScreenGui")
    screen.Name = "GangHub"
    screen.ResetOnSpawn = false
    screen.Parent = game.CoreGui
    screen.IgnoreGuiInset = true

    -- Main frame
    local main = Instance.new("Frame", screen)
    main.Size = UDim2.new(0, 520, 0, 380)
    main.Position = UDim2.new(0.5, -260, 0.5, -190)
    main.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    main.BorderSizePixel = 0
    local mainCorner = Instance.new("UICorner", main)
    mainCorner.CornerRadius = UDim.new(0, 18)
    main.ClipsDescendants = true

    -- Glassy bubble toggle
    local bubble = Instance.new("Frame", screen)
    bubble.Size = UDim2.new(0, 56, 0, 56)
    bubble.Position = UDim2.new(0, 12, 0.7, 0)
    bubble.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bubble.BackgroundTransparency = 0.3
    bubble.BorderSizePixel = 0
    local bubbleCorner = Instance.new("UICorner", bubble)
    bubbleCorner.CornerRadius = UDim.new(1, 0)

    local bubbleBlur = Instance.new("UIBlurEffect", bubble)
    bubbleBlur.Enabled = true
    -- UIBlurEffect only works in lighting, so instead let's fake glass with transparency + gradient

    -- Icon (you can replace with your own image here)
    local icon = Instance.new("TextLabel", bubble)
    icon.Text = "GH"
    icon.Font = Enum.Font.GothamBlack
    icon.TextColor3 = Color3.fromRGB(200, 200, 255)
    icon.TextSize = 28
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.TextStrokeTransparency = 0.7

    local isOpen = false

    local function openMain()
        isOpen = true
        bubble:TweenPosition(UDim2.new(0, 12, 0.5, 0), "Out", "Quad", 0.4, true)
        main:TweenPosition(UDim2.new(0.5, -260, 0.5, -190), "Out", "Quad", 0.4, true)
        main:TweenSize(UDim2.new(0, 520, 0, 380), "Out", "Quad", 0.4, true)
        wait(0.4)
        main.Visible = true
    end
    local function closeMain()
        isOpen = false
        main:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quad", 0.4, true)
        main:TweenPosition(UDim2.new(0, 12, 0.5, 0), "In", "Quad", 0.4, true)
        wait(0.4)
        main.Visible = false
        bubble:TweenPosition(UDim2.new(0, 12, 0.7, 0), "In", "Quad", 0.4, true)
    end

    bubble.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if isOpen then
                closeMain()
            else
                main.Visible = true
                openMain()
            end
        end
    end)

    main.Visible = false
    main.Position = UDim2.new(0, 12, 0.5, 0)
    main.Size = UDim2.new(0, 0, 0, 0)

    -- Title
    local titleLbl = Instance.new("TextLabel", main)
    titleLbl.Size = UDim2.new(1, 0, 0, 42)
    titleLbl.Position = UDim2.new(0, 0, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBlack
    titleLbl.TextColor3 = Color3.fromRGB(190, 190, 255)
    titleLbl.TextSize = 28
    titleLbl.Text = "Gang Hub"

    -- Tabs container (left side)
local tabsFrame = Instance.new("Frame", main)
tabsFrame.Size = UDim2.new(0, 130, 1, -42)
tabsFrame.Position = UDim2.new(0, 0, 0, 42)
tabsFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
tabsFrame.BorderSizePixel = 0

local tabsCorner = Instance.new("UICorner", tabsFrame)
tabsCorner.CornerRadius = UDim.new(0, 10)

local uiList = Instance.new("UIListLayout", tabsFrame)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Padding = UDim.new(0, 4)

-- Pages container
local pagesFolder = Instance.new("Folder", main)
pagesFolder.Name = "Pages"

-- GUI creation API
function GangHub:CreateTab(tabName)
    local tabButton = Instance.new("TextButton", tabsFrame)
    tabButton.Size = UDim2.new(1, -10, 0, 40)
    tabButton.Position = UDim2.new(0, 5, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.TextColor3 = Color3.new(1,1,1)
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.TextSize = 18
    tabButton.Text = tabName

    local tabCorner = Instance.new("UICorner", tabButton)
    tabCorner.CornerRadius = UDim.new(0, 8)

    local page = Instance.new("Frame", pagesFolder)
    page.Name = tabName
    page.Size = UDim2.new(1, -140, 1, -50)
    page.Position = UDim2.new(0, 135, 0, 45)
    page.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    page.BorderSizePixel = 0
    page.Visible = false

    local uiList = Instance.new("UIListLayout", page)
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    uiList.Padding = UDim.new(0, 6)

    tabButton.MouseButton1Click:Connect(function()
        for _, p in ipairs(pagesFolder:GetChildren()) do
            if p:IsA("Frame") then p.Visible = false end
        end
        page.Visible = true
    end)

    return {
        AddButton = function(self, text, callback)
            local button = Instance.new("TextButton", page)
            button.Size = UDim2.new(1, -20, 0, 36)
            button.Position = UDim2.new(0, 10, 0, 0)
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            button.TextColor3 = Color3.new(1,1,1)
            button.Font = Enum.Font.Gotham
            button.TextSize = 16
            button.Text = text

            local corner = Instance.new("UICorner", button)
            corner.CornerRadius = UDim.new(0, 8)

            button.MouseButton1Click:Connect(callback)
        end,

        AddToggle = function(self, text, configKey, callback)
            local toggle = Instance.new("TextButton", page)
            toggle.Size = UDim2.new(1, -20, 0, 36)
            toggle.Position = UDim2.new(0, 10, 0, 0)
            toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            toggle.TextColor3 = Color3.new(1,1,1)
            toggle.Font = Enum.Font.Gotham
            toggle.TextSize = 16
            toggle.Text = "[ OFF ] " .. text

            local corner = Instance.new("UICorner", toggle)
            corner.CornerRadius = UDim.new(0, 8)

            local state = config[configKey] or false
            local function updateText()
                toggle.Text = state and "[ ON  ] " .. text or "[ OFF ] " .. text
            end
            updateText()

            toggle.MouseButton1Click:Connect(function()
                state = not state
                config[configKey] = state
                updateText()
                pcall(callback, state)
                saveConfig()
            end)
        end,

        AddDropdown = function(self, text, options, configKey, callback)
            local container = Instance.new("Frame", page)
            container.Size = UDim2.new(1, -20, 0, 36 + (#options * 30))
            container.Position = UDim2.new(0, 10, 0, 0)
            container.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            container.BorderSizePixel = 0

            local corner = Instance.new("UICorner", container)
            corner.CornerRadius = UDim.new(0, 8)

            local label = Instance.new("TextLabel", container)
            label.Size = UDim2.new(1, 0, 0, 36)
            label.BackgroundTransparency = 1
            label.Text = text .. ": " .. (config[configKey] or "None")
            label.TextColor3 = Color3.new(1,1,1)
            label.Font = Enum.Font.Gotham
            label.TextSize = 16

            for i, option in ipairs(options) do
                local btn = Instance.new("TextButton", container)
                btn.Size = UDim2.new(1, -10, 0, 28)
                btn.Position = UDim2.new(0, 5, 0, 36 + ((i - 1) * 30))
                btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                btn.Text = option
                btn.TextColor3 = Color3.new(1,1,1)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 14

                local btnCorner = Instance.new("UICorner", btn)
                btnCorner.CornerRadius = UDim.new(0, 6)

                btn.MouseButton1Click:Connect(function()
                    config[configKey] = option
                    label.Text = text .. ": " .. option
                    pcall(callback, option)
                    saveConfig()
                end)
            end
        end,
    }
end

-- Finish initializing the UI
function GangHub:Run()
    local saved = readKey()
    if saved == validKey then
        notify("Gang Hub", "Welcome back G.", 3)
        GangHub:Init()
    else
        promptKey()
    end
end

return GangHub
