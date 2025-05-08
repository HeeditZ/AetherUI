-- AetherUI.lua (Executor-safe)

local AetherUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local guiParent = (gethui and gethui()) or game.CoreGui

-- === Theme Config ===
local theme = {
    MainColor = Color3.fromRGB(35, 35, 40),
    TextColor = Color3.fromRGB(255, 255, 255),
    ButtonColor = Color3.fromRGB(50, 50, 60),
    HoverColor = Color3.fromRGB(70, 70, 85),
    Transparency = 0.3
}

-- === Blur Effect ===
local blur = Instance.new("BlurEffect")
blur.Size = 12
blur.Parent = Lighting

-- === GUI Setup ===
local gui = Instance.new("ScreenGui")
gui.Name = "AetherUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = guiParent

-- === Window Function ===
function AetherUI:CreateWindow(options)
    -- Default values
    local windowName = options.Name or "AetherUI Window"
    local windowSize = options.Size or UDim2.new(0.8, 0, 0, 60)
    local windowPos = options.Position or UDim2.new(0.5, 0, 1, -10)

    -- === Create the Main Window ===
    local main = Instance.new("Frame")
    main.Name = windowName
    main.AnchorPoint = Vector2.new(0.5, 1)
    main.Position = windowPos
    main.Size = windowSize
    main.BackgroundColor3 = theme.MainColor
    main.BackgroundTransparency = theme.Transparency
    main.BorderSizePixel = 0
    main.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 8)
    layout.Parent = main

    -- === Open/Close Animation ===
    local isOpen = true

    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.K then
            isOpen = not isOpen
            local goal = { Size = isOpen and UDim2.new(0.8, 0, 0, 60) or UDim2.new(0.8, 0, 0, 0) }
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
            blur.Enabled = isOpen
        end
    end)

    -- === API to Add UI Elements ===
    function self:AddButton(text, callback)
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
    end

    function self:AddToggle(text, default, callback)
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
    end

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

        local slider = Instance.new("TextButton")
        slider.Size = UDim2.new(1, -40, 0, 10)
        slider.Position = UDim2.new(0, 20, 0.5, -5)
        slider.BackgroundColor3 = theme.ButtonColor
        slider.Text = ""
        slider.Parent = sliderFrame

        local thumb = Instance.new("Frame")
        thumb.Size = UDim2.new(0, 20, 0, 20)
        thumb.BackgroundColor3 = theme.HoverColor
        thumb.BorderSizePixel = 0
        thumb.Parent = slider

        local scorner = Instance.new("UICorner")
        scorner.CornerRadius = UDim.new(0, 10)
        scorner.Parent = thumb

        thumb.Position = UDim2.new((default - min) / (max - min), 0, 0, 0)

        slider.MouseButton1Drag:Connect(function(input)
            local newX = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
            thumb.Position = UDim2.new(newX / slider.AbsoluteSize.X, 0, 0, 0)
            local value = min + (max - min) * (newX / slider.AbsoluteSize.X)
            if callback then callback(value) end
        end)
    end

    return self
end

return AetherUI
