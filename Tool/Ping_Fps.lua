repeat wait() until game:IsLoaded() wait(2)

-- Remove existing ScreenGui if it exists
local existingGui = game.CoreGui:FindFirstChild("FpsPingGui")
if existingGui then
    existingGui:Destroy()
end

-- Create new ScreenGui and UI elements
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FpsPingGui"  -- Set a unique name to identify the GUI
local Fps = Instance.new("TextButton")
local Ping = Instance.new("TextButton")

-- Properties:
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Fps.Name = "Fps"
Fps.Parent = ScreenGui
Fps.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fps.BackgroundTransparency = 1.0
Fps.Position = UDim2.new(0.9, 0, 0, 10)  -- Set position at top-right corner
Fps.Size = UDim2.new(0, 125, 0, 25)
Fps.Font = Enum.Font.SourceSans
Fps.TextColor3 = Color3.fromRGB(255, 255, 255)
Fps.TextScaled = true
Fps.TextWrapped = true
Fps.AnchorPoint = Vector2.new(1, 0)  -- Anchor to top-right corner

Ping.Name = "Ping"
Ping.Parent = ScreenGui
Ping.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Ping.BackgroundTransparency = 1.0
Ping.Position = UDim2.new(0.9, 0, 0, 40)  -- Set position under FPS label
Ping.Size = UDim2.new(0, 125, 0, 25)
Ping.Font = Enum.Font.SourceSans
Ping.TextColor3 = Color3.fromRGB(255, 255, 255)
Ping.TextScaled = true
Ping.TextWrapped = true
Ping.AnchorPoint = Vector2.new(1, 0)  -- Anchor to top-right corner

-- Scripts:
local RunService = game:GetService("RunService")
local lastUpdate = 0  -- Variable to track the last update time for FPS
local clickCountFps = 0  -- Counter for FPS clicks
local clickCountPing = 0  -- Counter for Ping clicks
local lastClickTimeFps = 0  -- Time of the last click for FPS
local lastClickTimePing = 0  -- Time of the last click for Ping

-- FPS Script
RunService.RenderStepped:Connect(function(frame)
    if tick() - lastUpdate >= 0.5 then  -- Update every 0.5 seconds
        Fps.Text = ("FPS: " .. math.floor(1 / frame))
        lastUpdate = tick()  -- Reset last update time
    end
end)

-- Ping Script
RunService.RenderStepped:Connect(function()
    local pingValue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    Ping.Text = ("Ping: " .. math.floor(pingValue) .. " ms")
end)

-- Click event to count clicks for FPS
Fps.MouseButton1Click:Connect(function()
    if tick() - lastClickTimeFps > 1 then  -- Reset click count after 2 seconds
        clickCountFps = 0
    end
    clickCountFps = clickCountFps + 1  -- Increment the click counter
    lastClickTimeFps = tick()  -- Update the last click time

    if clickCountFps >= 3 then  -- Check if clicked 3 times within 2 seconds
        Fps:Destroy()  -- Removes FPS label when clicked 3 times
    end
end)

-- Click event to count clicks for Ping
Ping.MouseButton1Click:Connect(function()
    if tick() - lastClickTimePing > 1 then  -- Reset click count after 2 seconds
        clickCountPing = 0
    end
    clickCountPing = clickCountPing + 1  -- Increment the click counter
    lastClickTimePing = tick()  -- Update the last click time

    if clickCountPing >= 3 then  -- Check if clicked 3 times within 2 seconds
        Ping:Destroy()  -- Removes Ping label when clicked 3 times
    end
end)
