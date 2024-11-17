local function NotifyUser(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 1
    })
end

local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")

-- ตรวจสอบว่า XlibModule มีอยู่ใน TextChatService หรือไม่
local function getXlibModule()
    local XlibFolder = TextChatService:FindFirstChild("Voice")
    if XlibFolder then
        local XlibModule = XlibFolder:FindFirstChild("VoiceText")
        if XlibModule then
            return XlibModule
        end
    end
    return nil
end
local XlibModule = getXlibModule()

local function loadXlibModule()
    local existingXlibModule = getXlibModule()
    if existingXlibModule then
        existingXlibModule:Destroy()
    end

    -- ตรวจสอบและลบ Xlib_Gui ออกจาก CoreGui ถ้ามีอยู่
    local CoreGui = game:GetService("CoreGui")
    local existingGui = CoreGui:FindFirstChild("Xlib_Gui")
    if existingGui then
        existingGui:Destroy()
    end

    -- โหลดโมดูล Xlib ใหม่จาก URL
    local success, response = pcall(function()
        return game:HttpGet('http://45.141.27.98:7044/Script-Xlib')
    end)

    if success then
        local jsonResponse = HttpService:JSONDecode(response)
        local XlibScript = loadstring(jsonResponse.script)

        if XlibScript then
            print("Xlib loaded successfully.")
            
            -- สร้าง Folder ใน TextChatService เพื่อเก็บ Xlib ไว้
            local XlibFolder = TextChatService:FindFirstChild("Voice") or Instance.new("Folder")
            XlibFolder.Name = "Voice"
            XlibFolder.Parent = TextChatService

            -- สร้างและเก็บ script ไว้ใน ModuleScript
            local NewXlibModule = Instance.new("ModuleScript")
            NewXlibModule.Name = "VoiceText"
            NewXlibModule.Source = jsonResponse.script  -- เก็บ script ไว้ใน Source ของ ModuleScript
            NewXlibModule.Parent = XlibFolder
            
            -- อัพเดตตัวแปร XlibModule
            XlibModule = NewXlibModule
        else
            print("Unable to load Xlib.")
            NotifyUser("XHub", "Unable to load Xlib.", 3)
            return
        end
    else
        print("Can't find the script, please contact admin.")
        return
    end
end

loadXlibModule()


local Xlib
if XlibModule then
    Xlib = loadstring(XlibModule.Source)()
else
    NotifyUser("XHub", "เสียใจด้วยคุณใช้งานผิดวิธี\nSorry, you are using it incorrectly.", 3)
    wait(3)
    local player = game.Players.LocalPlayer
    player:Kick("ขอแสดงความเสียใจ คุณทำผิดขั้นตอน ติดต่อซื้อคีย์ได้ที่ดิสคอร์ด https://discord.gg/StxhWJE4pb\nSorry, you made a mistake. Contact us to buy a key on Discord https://discord.gg/StxhWJE4pb")
end


-- สร้างหน้าต่างจาก Xlib
local Window = Xlib:MakeWindow({
    Name = "เครื่องมือ แฮกเกอร์",
    Icon = "rbxassetid://7743871575"
})

local Tab1 = Xlib:MakeTab({
    Name_Eng = "Tool",
    Name_Th = "เครื่องมือ",
    Icon = "rbxassetid://7743875962",
    Parent = Window
})

Xlib:MakeButton({
    Name_Eng = "Dex Mobile",
    Name_Th = "ดากแดก มือถือ",
    Parent = Tab1,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MnsEn2001/Xlib/refs/heads/main/Tool/DexM.lua"))()
    end
})

Xlib:MakeButton({
    Name_Eng = "Remote Spy",
    Name_Th = "รีโมท สปาย",
    Parent = Tab1,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MnsEn2001/Xlib/refs/heads/main/Tool/Remote_Spy.lua"))()
    end
})

Xlib:MakeButton({
    Name_Eng = "Copy Position",
    Name_Th = "คัดลอก ตำแหน่ง",
    Parent = Tab1,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MnsEn2001/Xlib/refs/heads/main/Tool/Copy_Position.lua"))()
    end
})

Xlib:MakeButton({
    Name_Eng = "FPS Boost",
    Name_Th = "เพิ่ม FPS",
    Parent = Tab1,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MnsEn2001/Xlib/refs/heads/main/Tool/Fps_Boost.lua"))()
    end
})

Xlib:MakeButton({
    Name_Eng = "Ping FPS",
    Name_Th = "ดู ปิง FPS",
    Parent = Tab1,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MnsEn2001/Xlib/refs/heads/main/Tool/Ping_Fps.lua"))()
    end
})

Xlib:MakeButton({
    Name_Eng = "Server Hop",
    Name_Th = "ย้ายเซิร์ฟเวอร์",
    Parent = Tab1,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MnsEn2001/Xlib/refs/heads/main/Tool/Server_Hop.lua"))()
    end
})

Xlib:MakeButton({
    Name_Eng = "Shift Lock",
    Name_Th = "ชิพ ล็อก",
    Parent = Tab1,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MnsEn2001/Xlib/refs/heads/main/Tool/Shiftlock.lua"))()
    end
})
