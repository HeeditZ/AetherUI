# AetherUI – Next lvl GUI Library for Roblox

AetherUI is a sleek, customizable, and modular GUI library designed for Roblox executors. With **rounded edges**, **blur effects**, and **smooth animations**, it allows you to easily create and manage UI windows with buttons, toggles, sliders, and more. 

## Features:
- **Works on executors ( Main feature )**: Works in Roblox executors like Synapse, Krnl, Fluxus, and more.
- **Customizable Theme**: Easily change the window and element colors.
- **Blur Effect**: Create a sleek, modern UI with built-in blur.
- **Modular UI Elements**: Add buttons, toggles, sliders, and other controls on the fly.
- **Smooth Animations**: Open and close windows with smooth transition animations.

## Example Code:
```lua
local AetherUI = loadstring(game:HttpGet("https://yourlink.com/AetherUI.lua"))()

-- Create a window
local Window = AetherUI:CreateWindow({
    Name = "AetherUI Example Window",
    Size = UDim2.new(0.8, 0, 0, 100),
    Position = UDim2.new(0.5, 0, 1, -20)
})

-- Add a button
Window:AddButton("Click Me", function()
    print("Button Pressed!")
end)

-- Add a toggle
Window:AddToggle("Enable Feature", true, function(state)
    print("Feature is now", state and "enabled" or "disabled")
end)

-- Add a slider
Window:AddSlider("Adjust Volume", 0, 100, 50, function(value)
    print("Volume set to", value)
end)
