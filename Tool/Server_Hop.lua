local function Rejoin()
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    
    ts:Teleport(game.PlaceId, p)
end

-- รันฟังก์ชัน Rejoin ทันทีเมื่อ script ถูกรัน
Rejoin()
