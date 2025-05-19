-- ✅ FULL GANG HUB SYSTEM — WITH KEY SYSTEM, DISCORD, GUI CORE, TABS & PREVENT DOUBLE LOAD --

-- // CONFIGURATION // --
local validKey = "gang-hub-op"
local discordInvite = "yourdiscord" -- no https://
local keyFile = "GangHubKey.txt"

-- // SERVICES // --
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local hs = game:GetService("HttpService")
local sg = game:GetService("StarterGui")

-- // DOUBLE LOAD CHECK // --
if getgenv().GangHubLoaded then return end
getgenv().GangHubLoaded = true

-- // NOTIFICATION UTIL // --
local function notify(title, text, duration)
    pcall(function()
        sg:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

-- // GUI CORE LIB // --
local Gui = {}
Gui.__index = Gui

function Gui:CreateWindow(title)
    local screen = Instance.new("ScreenGui", game.CoreGui)
    screen.Name = "GangHub"
    screen.ResetOnSpawn = false
    screen.IgnoreGuiInset = true

    local main = Instance.new("Frame", screen)
    main.Size = UDim2.new(0, 500, 0, 350)
    main.Position = UDim2.new(0.5, -250, 0.5, -175)
    main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

    local titleLbl = Instance.new("TextLabel", main)
    titleLbl.Size = UDim2.new(1, 0, 0, 30)
    titleLbl.Position = UDim2.new(0, 0, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.Text = title or "Gang Hub"
    titleLbl.TextSize = 18

    local tabs = {}
    function Gui:CreateTab(tabName)
        local tab = {}
        local btn = Instance.new("TextButton", main)
        btn.Size = UDim2.new(0, 100, 0, 30)
        btn.Position = UDim2.new(0, #tabs * 100, 0, 30)
        btn.Text = tabName
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        local content = Instance.new("Frame", main)
        content.Position = UDim2.new(0, 0, 0, 60)
        content.Size = UDim2.new(1, 0, 1, -60)
        content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        content.Visible = false
        Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.content.Visible = false
            end
            content.Visible = true
        end)

        tab.content = content
        tab.Buttons = {}

        function tab:CreateButton(opt)
            local b = Instance.new("TextButton", content)
            b.Size = UDim2.new(0, 150, 0, 30)
            b.Position = UDim2.new(0, 10, 0, 10 + (#tab.Buttons * 40))
            b.Text = opt.Text or "Button"
            b.Font = Enum.Font.Gotham
            b.TextSize = 14
            b.TextColor3 = Color3.new(1, 1, 1)
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

            b.MouseButton1Click:Connect(function()
                pcall(opt.Callback or function() end)
            end)

            table.insert(tab.Buttons, b)
        end

        table.insert(tabs, tab)
        return tab
    end

    return setmetatable({}, Gui)
end

-- // GUI KEY SYSTEM // --
local function launchKeySystem()
    local screen = Instance.new("ScreenGui", game.CoreGui)
    screen.Name = "KeySystem"
    screen.ResetOnSpawn = false
    screen.IgnoreGuiInset = true

    local frame = Instance.new("Frame", screen)
    frame.Size = UDim2.new(0, 350, 0, 200)
    frame.Position = UDim2.new(0.5, -175, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.Text = "🔐 Enter Your Key"
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamSemibold
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 20

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.8, 0, 0, 40)
    box.Position = UDim2.new(0.1, 0, 0.3, 0)
    box.PlaceholderText = "Key here..."
    box.Text = ""
    box.Font = Enum.Font.Gotham
    box.TextSize = 16
    box.TextColor3 = Color3.new(1, 1, 1)
    box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

    local verify = Instance.new("TextButton", frame)
    verify.Size = UDim2.new(0.5, 0, 0, 35)
    verify.Position = UDim2.new(0.25, 0, 0.6, 0)
    verify.Text = "Verify"
    verify.Font = Enum.Font.GothamBold
    verify.TextSize = 14
    verify.TextColor3 = Color3.new(1, 1, 1)
    verify.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", verify).CornerRadius = UDim.new(0, 10)

    local joinDiscord = Instance.new("TextButton", frame)
    joinDiscord.Size = UDim2.new(0.5, 0, 0, 30)
    joinDiscord.Position = UDim2.new(0.25, 0, 0.85, 0)
    joinDiscord.Text = "Join Discord"
    joinDiscord.Font = Enum.Font.Gotham
    joinDiscord.TextSize = 13
    joinDiscord.TextColor3 = Color3.new(1, 1, 1)
    joinDiscord.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
    Instance.new("UICorner", joinDiscord).CornerRadius = UDim.new(0, 10)

    joinDiscord.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/" .. discordInvite)
        notify("Discord", "Invite copied to clipboard!", 4)
    end)

    verify.MouseButton1Click:Connect(function()
        if box.Text == validKey then
            writefile(keyFile, box.Text)
            notify("Success", "Correct key, loading...", 3)
            screen:Destroy()
            wait(0.5)

            local window = Gui:CreateWindow("Gang Hub")
            local tab = window:CreateTab("Combat")
            tab:CreateButton({Text = "Kill Aura", Callback = function() print("Aura") end})
        else
            verify.Text = "Invalid!"
            task.wait(1)
            verify.Text = "Verify"
        end
    end)
end

-- AUTO LOAD OR KEY SYSTEM --
if isfile(keyFile) and readfile(keyFile) == validKey then
    local window = Gui:CreateWindow("Gang Hub")
    local tab = window:CreateTab("Combat")
    tab:CreateButton({Text = "Kill Aura", Callback = function() print("Aura") end})
else
    launchKeySystem()
end
