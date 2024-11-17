local function NotifyUser(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 1
    })
end

local player = game:GetService("Players").LocalPlayer
local position = player.Character.HumanoidRootPart.Position
setclipboard(tostring(position))
NotifyUser("XHub", "คัดลอกตำแหน่งสำเร็จ", 3)
