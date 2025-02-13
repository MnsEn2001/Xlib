local HttpService = game:GetService("HttpService")

-- ฟังก์ชันสำหรับรันสคริปต์จาก URL
local function Run_Script(Key, Version)
    local url = "http://110.77.189.82:7044/Run" -- เปลี่ยน URL เป็น IP ของโฮสต์
    local success, response = pcall(function()
        return game:HttpGet(url) -- ใช้ HttpGet เพื่อดึงข้อมูล
    end)

    if success then
        local decodeSuccess, data = pcall(function()
            return HttpService:JSONDecode(response) -- แปลงข้อมูล JSON เป็นตาราง
        end)

        if decodeSuccess and type(data) == "table" and data.script then
            local scriptContent = data.script -- คาดว่าข้อมูล JSON มีฟิลด์ `script`

            -- สามารถใช้งาน Key และ Version ในการประมวลผลเพิ่มเติมหรือตรวจสอบได้ที่นี่
            print("Running script with Key:", Key, "and Version:", Version)

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

-- เรียกใช้ฟังก์ชันและส่งค่าของ _G.Key และ _G.Version
Run_Script(_G.Key, _G.Version)  -- ส่งทั้ง _G.Key และ _G.Version
