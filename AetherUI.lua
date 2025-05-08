-- AetherUI.lua (Complete Enhanced Version)
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
    ActiveColor = Color3.fromRGB(90, 90, 110),
    SliderColor = Color3.fromRGB(100, 100, 120),
    Transparency = 0.3,
    BlurSize = 12,
    TabSize = UDim2.new(0, 80, 0, 25),
    ElementSpacing = 35
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
    local window = {tabs = {}, activeTab = nil, elements = {}}
    
    -- Window settings
    local windowName = options.Name or "AetherUI Window"
    local windowSize = options.Size or UDim2.new(0.4, 0, 0, 400)
    local windowPos = options.Position or UDim2.new(0.5, 0, 0.5, 0)

    -- Create main frame
    local main = Instance.new("Frame")
    main.Name = windowName
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Position = windowPos
    main.Size = windowSize
    main.BackgroundColor3 = theme.MainColor
    main.BackgroundTransparency = theme.Transparency
    main.BorderSizePixel = 0
    main.Parent = gui
    
    window.main = main
    table.insert(windows, window)

    -- Window styling
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

    -- Tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(1, -20, 0, 30)
    tabContainer.Position = UDim2.new(0, 10, 0, 10)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = main

    local tabLayout = Instance.new("UIListLayout", tabContainer)
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 5)
    
    -- Content container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "Content"
    contentContainer.Size = UDim2.new(1, -20, 1, -50)
    contentContainer.Position = UDim2.new(0, 10, 0, 50)
    contentContainer.BackgroundTransparency = 1
    contentContainer.ClipsDescendants = true
    contentContainer.Parent = main

    -- Set up input connection if not already exists
    if not inputConnection then
        inputConnection = UserInputService.InputBegan:Connect(handleUIInput)
    end

    -- === Tab System ===
    function window:AddTab(tabName)
        local tab = {name = tabName, elements = {}}
        
        -- Tab button
        local tabButton = Instance.new("TextButton")
        tabButton.Size = theme.TabSize
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = theme.ButtonColor
        tabButton.TextColor3 = theme.TextColor
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 12
        tabButton.AutoButtonColor = false
        tabButton.Parent = tabContainer
        
        -- Tab content frame
        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = contentContainer

        -- Tab activation logic
        local function activate()
            if window.activeTab then
                window.activeTab.content.Visible = false
                window.activeTab.button.BackgroundColor3 = theme.ButtonColor
            end
            window.activeTab = tab
            tabContent.Visible = true
            tabButton.BackgroundColor3 = theme.ActiveColor
        end

        tabButton.MouseButton1Click:Connect(activate)
        
        -- Styling
        Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)
        
        -- Hover effects
        tabButton.MouseEnter:Connect(function()
            if window.activeTab ~= tab then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = theme.HoverColor
                }):Play()
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if window.activeTab ~= tab then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = theme.ButtonColor
                }):Play()
            end
        end)
        
        tab.button = tabButton
        tab.content = tabContent
        table.insert(self.tabs, tab)
        
        -- Activate first tab
        if #self.tabs == 1 then
            activate()
        end
        
        return tab
    end

    -- === Enhanced Slider ===
    function window:AddSlider(tab, options)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, 0, 0, 60)
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.Parent = tab.content

        -- Auto-position based on existing elements
        sliderFrame.Position = UDim2.new(0, 0, 0, #tab.elements * theme.ElementSpacing)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 20)
        label.Text = options.Text or "Slider"
        label.TextColor3 = theme.TextColor
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = sliderFrame

        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, 0, 0, 4)
        track.Position = UDim2.new(0, 0, 0, 30)
        track.BackgroundColor3 = theme.ButtonColor
        track.Parent = sliderFrame
        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(0.5, 0, 1, 0)
        fill.BackgroundColor3 = theme.SliderColor
        fill.Parent = track
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 50, 0, 20)
        valueLabel.Position = UDim2.new(1, -50, 0, 30)
        valueLabel.Text = tostring(options.Default or options.Min or 0)
        valueLabel.TextColor3 = theme.TextColor
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.TextSize = 12
        valueLabel.BackgroundTransparency = 1
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = sliderFrame

        local minMaxContainer = Instance.new("Frame")
        minMaxContainer.Size = UDim2.new(1, 0, 0, 12)
        minMaxContainer.Position = UDim2.new(0, 0, 0, 40)
        minMaxContainer.BackgroundTransparency = 1
        minMaxContainer.Parent = sliderFrame

        local minLabel = Instance.new("TextLabel")
        minLabel.Text = tostring(options.Min or 0)
        minLabel.TextColor3 = theme.TextColor
        minLabel.Font = Enum.Font.Gotham
        minLabel.TextSize = 10
        minLabel.BackgroundTransparency = 1
        minLabel.TextXAlignment = Enum.TextXAlignment.Left
        minLabel.Parent = minMaxContainer

        local maxLabel = Instance.new("TextLabel")
        maxLabel.Text = tostring(options.Max or 100)
        maxLabel.TextColor3 = theme.TextColor
        maxLabel.Font = Enum.Font.Gotham
        maxLabel.TextSize = 10
        maxLabel.AnchorPoint = Vector2.new(1, 0)
        maxLabel.Position = UDim2.new(1, 0, 0, 0)
        maxLabel.BackgroundTransparency = 1
        maxLabel.TextXAlignment = Enum.TextXAlignment.Right
        maxLabel.Parent = minMaxContainer

        -- Initialize slider value
        local minValue = options.Min or 0
        local maxValue = options.Max or 100
        local defaultValue = options.Default or minValue
        local step = options.Step or 1

        local function setValue(value)
            value = math.clamp(value, minValue, maxValue)
            if step > 1 then
                value = math.floor(value / step) * step
            end
            valueLabel.Text = tostring(value)
            fill.Size = UDim2.new((value - minValue) / (maxValue - minValue), 0, 1, 0)
            if options.Callback then options.Callback(value) end
        end

        setValue(defaultValue)

        -- Slider interaction
        local dragging = false
        local connection

        track.InputBegan:Connect(function(input)
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
                        local value = minValue + (maxValue - minValue) * (relativeX / track.AbsoluteSize.X)
                        setValue(value)
                    end
                end)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                if connection then connection:Disconnect() end
            end
        end)

        table.insert(tab.elements, sliderFrame)
        return sliderFrame
    end

    -- === Button Element ===
    function window:AddButton(tab, text, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 0, 30)
        button.Position = UDim2.new(0, 0, 0, #tab.elements * theme.ElementSpacing)
        button.Text = text
        button.BackgroundColor3 = theme.ButtonColor
        button.TextColor3 = theme.TextColor
        button.Font = Enum.Font.Gotham
        button.TextSize = 12
        button.AutoButtonColor = false
        button.Parent = tab.content

        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

        -- Hover effects
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

        table.insert(tab.elements, button)
        return button
    end

    -- === Toggle Element ===
    function window:AddToggle(tab, options)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, 0, 0, 30)
        toggleFrame.Position = UDim2.new(0, 0, 0, #tab.elements * theme.ElementSpacing)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.Parent = tab.content

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.Text = options.Text or "Toggle"
        label.TextColor3 = theme.TextColor
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = toggleFrame

        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0.3, 0, 0.8, 0)
        toggleButton.Position = UDim2.new(0.7, 0, 0.1, 0)
        toggleButton.Text = options.Default and "ON" or "OFF"
        toggleButton.BackgroundColor3 = options.Default and theme.ActiveColor or theme.ButtonColor
        toggleButton.TextColor3 = theme.TextColor
        toggleButton.Font = Enum.Font.Gotham
        toggleButton.TextSize = 12
        toggleButton.AutoButtonColor = false
        toggleButton.Parent = toggleFrame

        Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

        toggleButton.MouseButton1Click:Connect(function()
            options.Default = not options.Default
            toggleButton.Text = options.Default and "ON" or "OFF"
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = options.Default and theme.ActiveColor or theme.ButtonColor
            }):Play()
            if options.Callback then options.Callback(options.Default) end
        end)

        table.insert(tab.elements, toggleFrame)
        return toggleFrame
    end

    -- === Label Element ===
    function window:AddLabel(tab, text)
        local labelFrame = Instance.new("Frame")
        labelFrame.Size = UDim2.new(1, 0, 0, 20)
        labelFrame.Position = UDim2.new(0, 0, 0, #tab.elements * theme.ElementSpacing)
        labelFrame.BackgroundTransparency = 1
        labelFrame.Parent = tab.content

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Text = text
        label.TextColor3 = theme.TextColor
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = labelFrame

        table.insert(tab.elements, labelFrame)
        return labelFrame
    end

    -- === Destroy Method ===
    function window:Destroy()
        for _, tab in pairs(self.tabs) do
            for _, element in pairs(tab.elements) do
                element:Destroy()
            end
            if tab.button then tab.button:Destroy() end
            if tab.content then tab.content:Destroy() end
        end
        
        if self.main then
            self.main:Destroy()
        end
        
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
