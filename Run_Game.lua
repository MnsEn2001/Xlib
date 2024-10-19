local function Run_Script(Key)
    local url = "http://37.114.46.39:6191/Run"
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        print("Response received: ", response) -- เพิ่มการแสดงข้อมูล response

        local decodeSuccess, data = pcall(function()
            return HttpService:JSONDecode(response) -- แปลงข้อมูล JSON เป็นตาราง
        end)

        if decodeSuccess and type(data) == "table" and data.script then
            local scriptContent = data.script
            local func, err = loadstring(scriptContent)
            if func then
                func()
            else
                warn("Failed to load script: " .. tostring(err))
            end
        else
            warn("Invalid data structure or missing 'script': " .. tostring(data))
        end
    else
        warn("Failed to load script: " .. tostring(response))
    end
end
