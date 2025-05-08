-- AetherUI.lua (Final Improved Version)
local AetherUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

-- Cleanup previous instances
if game.CoreGui:FindFirstChild("AetherUI") then
    game.CoreGui.AetherUI:Destroy()
end
if Lighting:FindFirstChild("AetherUIBlur") then
    Lighting.AetherUIBlur:Destroy()
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

-- === Main GUI Setup ===
local gui = Instance.new("ScreenGui")
gui.Name = "AetherUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- === Blur Effect ===
local blur = Instance.new("BlurEffect")
blur.Name = "AetherUIBlur"
blur.Size = theme.BlurSize
blur.Enabled = false
blur.Parent = Lighting

-- === Window Management ===
local windows = {}
local isUIVisible = true
local inputConnection

-- === Input Handler ===
local function handleUIInput(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then
        isUIVisible = not isUIVisible
        blur.Enabled = isUIVisible
        
        for _, window in pairs(windows) do
            window.main.Visible = isUIVisible
            TweenService:Create(window.main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                BackgroundTransparency = isUIVisible and theme.Transparency or 1
            }):Play()
        end
    end
end

-- === Window Creation ===
function AetherUI:CreateWindow(options)
    local window = {}
    window.elements = {}
    
    -- Window settings
    local windowName = options.Name or "AetherUI Window"
    local windowSize = options.Size or UDim2.new(0.8, 0, 0, 60)
    local windowPos = options.Position or UDim2.new(0.5, 0, 1, -40)

    -- Create main frame
    local main = Instance.new("Frame")
    main.Name = windowName
    main.AnchorPoint = Vector2.new(0.5, 1)
    main.Position = windowPos
    main.Size = windowSize
    main.BackgroundColor3 = theme.MainColor
    main.BackgroundTransparency = theme.Transparency
    main.BorderSizePixel = 0
    main.Parent = gui
    
    window.main = main
    table.insert(windows, window)

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

    -- Set up input connection if not already exists
    if not inputConnection then
        inputConnection = UserInputService.InputBegan:Connect(handleUIInput)
    end

    -- === Button Element ===
    function window:AddButton(text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 40)
        button.BackgroundColor3 = theme.ButtonColor
        button.BackgroundTransparency = 0.1
        button.Text = text
        button.TextColor3 = theme.TextColor
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.AutoButtonColor = false
        button.Parent = main

        local bcorner = Instance.new("UICorner")
        bcorner.CornerRadius = UDim.new(0, 8)
        bcorner.Parent = button

        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = theme.HoverColor
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = theme.ButtonColor
            }):Play()
        end)

        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
        
        table.insert(self.elements, button)
        return button
    end

    -- === Toggle Element ===
    function window:AddToggle(text, default, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(0, 100, 0, 40)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.Parent = main

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0.5, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = theme.TextColor
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = toggleFrame

        local switch = Instance.new("TextButton")
        switch.Size = UDim2.new(0, 40, 0, 20)
        switch.Position = UDim2.new(1, -50, 0.5, -10)
        switch.BackgroundColor3 = theme.ButtonColor
        switch.Text = default and "ON" or "OFF"
        switch.TextColor3 = theme.TextColor
        switch.Font = Enum.Font.Gotham
        switch.TextSize = 12
        switch.Parent = toggleFrame

        local tcorner = Instance.new("UICorner")
        tcorner.CornerRadius = UDim.new(0, 8)
        tcorner.Parent = switch

        switch.MouseButton1Click:Connect(function()
            default = not default
            switch.Text = default and "ON" or "OFF"
            if callback then callback(default) end
        end)
        
        table.insert(self.elements, toggleFrame)
        return toggleFrame
    end

    -- === Slider Element (Fixed) ===
    function window:AddSlider(text, min, max, default, callback)
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

        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
        Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
        
        table.insert(self.elements, sliderFrame)
        return sliderFrame
    end

    -- === Destroy Method ===
    function window:Destroy()
        for _, element in pairs(self.elements) do
            element:Destroy()
        end
        self.main:Destroy()
        
        -- Remove from windows table
        for i, win in pairs(windows) do
            if win == self then
                table.remove(windows, i)
                break
            end
        end
        
        -- Cleanup input connection if no windows left
        if #windows == 0 and inputConnection then
            inputConnection:Disconnect()
            inputConnection = nil
            blur:Destroy()
            gui:Destroy()
        end
    end

    return window
end

return AetherUI
