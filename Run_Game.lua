-- File: Run.lua

local HttpService = game:GetService("HttpService")

local function Run_Script(Key)
    local url = "http://localhost:3000/Run" -- เปลี่ยน URL เป็น IP ของโฮสต์
    local success, response = pcall(function()
        return game:HttpGet(url) -- ใช้ HttpGet เพื่อดึงข้อมูล
    end)

    if success then
        local decodeSuccess, data = pcall(function()
            return HttpService:JSONDecode(response) -- แปลงข้อมูล JSON เป็นตาราง
        end)

        if decodeSuccess and type(data) == "table" and data.script then
            local scriptContent = data.script -- คาดว่าข้อมูล JSON มีฟิลด์ `script`

            -- โหลดและรันสคริปต์ Lua โดยตรง
            local func, err = loadstring(scriptContent)
            if func then
                func() -- เรียกใช้ฟังก์ชันที่โหลดมา
            else
                warn("Failed to load script: " .. tostring(err)) -- แสดงข้อความเตือนเมื่อโหลดไม่สำเร็จ
            end
        else
            warn("Invalid data structure or missing 'script': " .. tostring(data)) -- แสดงข้อผิดพลาดถ้าไม่มีฟิลด์ `script`
        end
    else
        warn("Failed to load script: " .. tostring(response)) -- แสดงข้อความเตือนเมื่อโหลดไม่สำเร็จ
    end
end

-- ใช้ _G.Key ที่ถูกกำหนดในไฟล์อื่น เช่น User_Run.lua
Run_Script(_G.Key)