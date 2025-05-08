-- AetherUI.lua (Improved Executor-Safe Version)
local AetherUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Check for existing UI and destroy it
if game.CoreGui:FindFirstChild("AetherUI") then
    game.CoreGui.AetherUI:Destroy()
end

-- === Theme Config ===
local theme = {
    MainColor = Color3.fromRGB(35, 35, 40),
    TextColor = Color3.fromRGB(255, 255, 255),
    ButtonColor = Color3.fromRGB(50, 50, 60),
    HoverColor = Color3.fromRGB(70, 70, 85),
    Transparency = 0.3,
    BlurSize = 12
}

-- === GUI Setup ===
local gui = Instance.new("ScreenGui")
gui.Name = "AetherUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- === Blur Effect ===
local blur = Instance.new("BlurEffect")
blur.Name = "AetherUIBlur"
blur.Size = theme.BlurSize
blur.Parent = game:GetService("Lighting")

-- === Window Management ===
local windows = {}
local isUIVisible = true

-- === Input Handler ===
local inputConnection
local function handleUIInput(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        isUIVisible = not isUIVisible
        for _, window in pairs(windows) do
            window.Visible = isUIVisible
            TweenService:Create(window, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = isUIVisible and theme.Transparency or 1
            }):Play()
        end
        blur.Enabled = isUIVisible
    end
end

-- === Window Function ===
function AetherUI:CreateWindow(options)
    local windowName = options.Name or "AetherUI Window"
    local windowSize = options.Size or UDim2.new(0.8, 0, 0, 60)
    local windowPos = options.Position or UDim2.new(0.5, 0, 1, -40)

    -- Create main window
    local main = Instance.new("Frame")
    main.Name = windowName
    main.AnchorPoint = Vector2.new(0.5, 1)
    main.Position = windowPos
    main.Size = windowSize
    main.BackgroundColor3 = theme.MainColor
    main.BackgroundTransparency = theme.Transparency
    main.BorderSizePixel = 0
    main.Parent = gui

    -- Window styling
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 8)
    layout.Parent = main

    -- Input connection management
    if not inputConnection then
        inputConnection = UserInputService.InputBegan:Connect(handleUIInput)
    end

    -- === Improved Slider ===
    function self:AddSlider(text, min, max, default, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(0, 200, 0, 40)
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Parent = main

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0.5, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = theme.TextColor
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = sliderFrame

        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, -40, 0, 4)
        track.Position = UDim2.new(0, 20, 0.75, 0)
        track.BackgroundColor3 = theme.ButtonColor
        track.Parent = sliderFrame

        local thumb = Instance.new("Frame")
        thumb.Size = UDim2.new(0, 20, 0, 20)
        thumb.AnchorPoint = Vector2.new(0.5, 0.5)
        thumb.Position = UDim2.new((default - min)/(max - min), 0, 0.75, 0)
        thumb.BackgroundColor3 = theme.HoverColor
        thumb.Parent = sliderFrame

        -- Slider interaction
        local dragging = false
        local connection

        thumb.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                connection = RunService.Heartbeat:Connect(function()
                    if dragging then
                        local mouse = UserInputService:GetMouseLocation()
                        local relativeX = math.clamp(
                            mouse.X - track.AbsolutePosition.X,
                            0,
                            track.AbsoluteSize.X
                        )
                        local value = min + (max - min) * (relativeX / track.AbsoluteSize.X)
                        thumb.Position = UDim2.new(relativeX / track.AbsoluteSize.X, 0, 0.75, 0)
                        if callback then callback(math.floor(value)) end
                    end
                end)
            end
        end)

        thumb.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                if connection then
                    connection:Disconnect()
                end
            end
        end)

        UICorner.new(track).CornerRadius = UDim.new(1, 0)
        UICorner.new(thumb).CornerRadius = UDim.new(1, 0)
    end

    -- === Enhanced Unloading ===
    function self:Destroy()
        for _, window in pairs(windows) do
            window:Destroy()
        end
        if inputConnection then
            inputConnection:Disconnect()
        end
        blur:Destroy()
        gui:Destroy()
    end

    table.insert(windows, main)
    return self
end

return AetherUI
