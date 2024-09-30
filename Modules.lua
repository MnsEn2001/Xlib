local Xlib = {}

local LG = {"Eng", "Thai"}
local currentLanguageIndex = 1
local currentLanguage = "Eng"
local Windows = {}
local Tabs = {}
local Sections = {}
local Buttons = {}
local Toggles = {}
local Dropdowns = {}
local Sliders = {}
local TextBoxes = {}


local TweenService = game:GetService("TweenService")

function Xlib:MakeWindow(settings)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Xlib_Gui"
    ScreenGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = settings.Name or "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, -25)
    MainFrame.Size = UDim2.new(0.7, 0, 0.7, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundTransparency = 1

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TitleBar.BorderSizePixel = 0

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = settings.Name or "Xlib GUI"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TabL = Instance.new("ScrollingFrame")
    TabL.Name = "TabL"
    TabL.Parent = MainFrame
    TabL.Size = UDim2.new(0.3, 0, 1, -45)
    TabL.Position = UDim2.new(0, 0, 0, 35)
    TabL.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabL.BorderSizePixel = 0
    TabL.BorderColor3 = Color3.fromRGB(100, 100, 100)
    TabL.ScrollBarThickness = 3

    local UIListLayout_L = Instance.new("UIListLayout")
    UIListLayout_L.Parent = TabL
    UIListLayout_L.FillDirection = Enum.FillDirection.Vertical
    UIListLayout_L.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_L.VerticalAlignment = Enum.VerticalAlignment.Top
    UIListLayout_L.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_L.Padding = UDim.new(0, 5)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = TabL
    UIPadding.PaddingTop = UDim.new(0, 10)
    

    UIListLayout_L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabL.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_L.AbsoluteContentSize.Y + 20)
    end)
    
    local TabR = Instance.new("Frame")
    TabR.Name = "TabR"
    TabR.Parent = MainFrame
    TabR.Size = UDim2.new(0.7, 0, 1, -20)
    TabR.Position = UDim2.new(0.3, 0, 0, 35)
    TabR.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabR.BorderSizePixel = 0

    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Parent = TabR
    Description.Size = UDim2.new(1, 0, 0, 230) -- ปรับขนาดให้เหมาะสม
    Description.Position = UDim2.new(0, 0, 0, 20) -- ห่างจากด้านบนลงมา 10 หน่วย
    Description.Text = currentLanguage == "Eng" and
                    "Welcome to Script XHub\n\n" ..
                    "If you are interested in purchasing premium scripts\n" ..
                    "you can join our Discord XHub.\n\n" .. 
                    "Discord Group : https://discord.gg/StxhWJE4pb"
                or
                    "ยินดีต้อนรับสู่ สคริปต์ XHub\n\n" ..
                    "หากคุณสนใจในการซื้อสคริปต์พรีเมียม\n" ..
                    "คุณสามารถเข้าร่วม Discord XHub ของเราได้\n\n" ..
                    "กลุ่ม ดิสคอร์ด : https://discord.gg/StxhWJE4pb"
                   
    Description.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description.TextSize = 16
    Description.Font = Enum.Font.SourceSansBold
    Description.TextWrapped = true
    Description.BackgroundTransparency = 1
    Description.TextYAlignment = Enum.TextYAlignment.Top

    local CopyButton = Instance.new("TextButton")
    CopyButton.Name = "CopyButton"
    CopyButton.Parent = Description
    CopyButton.Size = UDim2.new(0.5, 0, 0, 25)
    CopyButton.Position = UDim2.new(0.5, 10, 1, -20) -- กำหนดให้ห่างจากด้านล่างขึ้นมา 10 หน่วย
    CopyButton.AnchorPoint = Vector2.new(0.5, 1) -- ยึดตำแหน่งกึ่งกลางด้านล่าง
    CopyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyButton.Text = currentLanguage == "Eng" and
                    "Copy link Discord"
                or
                    "คักลอกลิ้งค์ ดิสคอร์ด"
                    
    CopyButton.TextSize = 16
    CopyButton.Font = Enum.Font.GothamBold
    CopyButton.BackgroundTransparency = 0.8

    local Discord_Icon = Instance.new("ImageLabel")
    Discord_Icon.Name = "Icon"
    Discord_Icon.Parent = CopyButton
    Discord_Icon.Size = UDim2.new(0, 16, 0, 16) -- ขนาดของไอคอน
    Discord_Icon.Position = UDim2.new(0.5, -77, 0.5, 0) -- ตำแหน่งให้อยู่ตรงกลาง
    Discord_Icon.AnchorPoint = Vector2.new(0.5, 0.5) -- ยึดจุดกลางของไอคอน
    Discord_Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Discord_Icon.BackgroundTransparency = 1
    Discord_Icon.Image = settings.Icon or "rbxassetid://4483345998"
    
    -- ลิงก์ Discord ที่ต้องการคัดลอก
    local discordLink = "https://discord.gg/StxhWJE4pb"
    
    local function NotifyUser(title, text)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {
                Title = title,
                Text = text,
                Duration = 5
            })
        end)
    end

    -- ฟังก์ชันการคัดลอกลิงค์เมื่อคลิกปุ่ม
    CopyButton.MouseButton1Click:Connect(function()
        setclipboard(discordLink)  -- คัดลอกลิงค์ไปยังคลิปบอร์ด
        NotifyUser("Copied to Clipboard", discordLink)
    end)
    
    local Language = Instance.new("TextButton")
    Language.Name = "Language"
    Language.Parent = TitleBar
    Language.Size = UDim2.new(0, 40, 0, 35)
    Language.Position = UDim2.new(1, -100, 0, 18)
    Language.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    Language.BackgroundTransparency = 1
    Language.BorderSizePixel = 0
    Language.Text = "      " .. LG[currentLanguageIndex]
    Language.TextColor3 = Color3.fromRGB(255, 255, 255)
    Language.TextSize = 16
    Language.Font = Enum.Font.SourceSansBold
    Language.AnchorPoint = Vector2.new(1, 0.5)
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = TitleBar
    Icon.Size = UDim2.new(0, 14, 0, 14)
    Icon.Position = UDim2.new(1, -140, 0, 6)
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7733965249"

    local function switchLanguage()
        currentLanguageIndex = currentLanguageIndex == 1 and 2 or 1
        currentLanguage = LG[currentLanguageIndex]
        Language.Text = "      " .. LG[currentLanguageIndex]
        
        Description.Text = currentLanguageIndex == 1 and 
                        "Welcome to Script XHub\n\n" ..
                        "If you are interested in purchasing premium scripts\n" ..
                        "you can join our Discord XHub.\n\n" .. 
                        "Discord Group : https://discord.gg/StxhWJE4pb"
                    or
                        "ยินดีต้อนรับสู่ สคริปต์ XHub\n\n" ..
                        "หากคุณสนใจในการซื้อสคริปต์พรีเมียม\n" ..
                        "คุณสามารถเข้าร่วม Discord XHub ของเราได้\n\n" ..
                        "กลุ่ม ดิสคอร์ด : https://discord.gg/StxhWJE4pb"
                        
        CopyButton.Text = currentLanguageIndex == 1 and 
                        "Copy link Discord"
                    or
                        "คักลอกลิ้งค์ ดิสคอร์ด"
                        
        -- อัปเดตข้อความใน Tabs
        for _, sw in ipairs(Tabs) do
            sw.TabFrame.Text = string.rep("     ", 2) .. (currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th)
        end
        
        -- อัปเดตข้อความใน Sections
        for _, sw in ipairs(Sections) do
            sw.Section.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end
        
        -- อัปเดตข้อความใน Buttons
        for _, sw in ipairs(Buttons) do
            sw.Button.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end
    
        -- อัปเดตข้อความใน Toggles
        for _, sw in ipairs(Toggles) do
            sw.Toggle.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end
    
        -- อัปเดตข้อความใน Dropdowns
        for _, sw in ipairs(Dropdowns) do
            if sw.value then
                local selectedIndex = table.find(sw.settings.Options_Eng, sw.value)
                sw.Dropdown.Text = currentLanguage == "Eng" and sw.value or sw.settings.Options_Th[selectedIndex]
            else
                sw.Dropdown.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
            end
            
            for i, optionButton in ipairs(sw.OptionButtons) do
                optionButton.Text = currentLanguage == "Eng" and sw.settings.Options_Eng[i] or sw.settings.Options_Th[i]
            end
        end
        
        -- อัปเดตข้อความใน Sliders
        for _, sw in ipairs(Sliders) do
            sw.SliderTitle.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end
        
        -- อัปเดตข้อความใน TextBoxes
        for _, sw in ipairs(TextBoxes) do
            sw.TextBoxTitle.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end
    end
    
    Language.MouseButton1Click:Connect(switchLanguage)

    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleBar
    MinimizeButton.Size = UDim2.new(0, 30, 0, 35)  -- กรอบขนาดเดิม
    MinimizeButton.Position = UDim2.new(1, -40, 0, 16)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
    
    -- สร้าง ImageLabel สำหรับไอคอนใน MinimizeButton
    local MinimizeIcon = Instance.new("ImageLabel")
    MinimizeIcon.Name = "MinimizeIcon"
    MinimizeIcon.Parent = MinimizeButton
    MinimizeIcon.Size = UDim2.new(0, 25, 0, 25)  -- ไอคอนขนาด 25x25
    MinimizeIcon.Position = UDim2.new(0.5, -12.5, 0.5, -12.5)  -- ศูนย์กลางของไอคอน
    MinimizeIcon.Image = "rbxassetid://7734000129"
    MinimizeIcon.BackgroundTransparency = 1  -- ซ่อนพื้นหลังของไอคอน
    
    local images_MinimizeButton = {
        "rbxassetid://7734000129",
        "rbxassetid://7734006080",
        "rbxassetid://7734006080",
        "rbxassetid://7734000129",
    }
    
    local currentMinimizeImageIndex = 1
    
    local function toggleIcon_MinimizeButton()
        while true do
            MinimizeIcon.Image = images_MinimizeButton[currentMinimizeImageIndex]
            
            wait(1)
    
            currentMinimizeImageIndex = currentMinimizeImageIndex + 1
            if currentMinimizeImageIndex > #images_MinimizeButton then
                currentMinimizeImageIndex = 1
            end
        end
    end
    
    spawn(toggleIcon_MinimizeButton)
    
    -- สำหรับ CloseButton
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.Size = UDim2.new(0, 30, 0, 35)  -- กรอบขนาดเดิม
    CloseButton.Position = UDim2.new(1, -5, 0, 16)
    CloseButton.BackgroundTransparency = 1
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    
    -- สร้าง ImageLabel สำหรับไอคอนใน CloseButton
    local CloseIcon = Instance.new("ImageLabel")
    CloseIcon.Name = "CloseIcon"
    CloseIcon.Parent = CloseButton
    CloseIcon.Size = UDim2.new(0, 25, 0, 25)  -- ไอคอนขนาด 25x25
    CloseIcon.Position = UDim2.new(0.5, -12.5, 0.5, -12.5)  -- ศูนย์กลางของไอคอน
    CloseIcon.Image = "rbxassetid://7743878857"
    CloseIcon.BackgroundTransparency = 1  -- ซ่อนพื้นหลังของไอคอน
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local UnderBar = Instance.new("Frame")
    UnderBar.Name = "UnderBar"
    UnderBar.Parent = MainFrame
    UnderBar.Size = UDim2.new(0.3, 0, 0, 30) -- Full width of MainFrame
    UnderBar.Position = UDim2.new(0, 0, 1, -15) -- Positioned at the bottom
    UnderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    UnderBar.BorderSizePixel = 0
    
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer -- ดึงข้อมูลผู้เล่นปัจจุบัน
    
    -- รูปโปรไฟล์
    local ProfileImage = Instance.new("ImageLabel")
    ProfileImage.Name = "ProfileImage"
    ProfileImage.Parent = UnderBar
    ProfileImage.Size = UDim2.new(0, 40, 0, 40)
    ProfileImage.AnchorPoint = Vector2.new(0.5, 0.5) -- Adjust anchor point to center
    ProfileImage.Position = UDim2.new(0.15, 0, 0.5, -5) -- Centered horizontally (15% from left) and vertically
    ProfileImage.BackgroundTransparency = 1
    
    -- ชื่อผู้เล่น
    local PlayerNameLabel = Instance.new("TextLabel")
    PlayerNameLabel.Name = "PlayerNameLabel"
    PlayerNameLabel.Parent = UnderBar
    PlayerNameLabel.Size = UDim2.new(0, 100, 0, 30)
    PlayerNameLabel.AnchorPoint = Vector2.new(0, 0.5) -- Center vertically
    PlayerNameLabel.Position = UDim2.new(0.3, 0, 0.5, 0) -- Position it to the right of ProfileImage
    PlayerNameLabel.BackgroundTransparency = 1
    PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerNameLabel.TextSize = 16
    PlayerNameLabel.Font = Enum.Font.SourceSansBold
    PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- ฟังก์ชันสำหรับดึงข้อมูลผู้ใช้
    local function UpdateUserInfo()
        local userId = player.UserId
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size100x100
        local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
        if isReady then
            ProfileImage.Image = content
        end
        PlayerNameLabel.Text = " :  " .. player.Name
    end
    UpdateUserInfo()
    
    
    local MinimizedIcon = Instance.new("ImageButton")
    MinimizedIcon.Name = "MinimizedIcon"
    MinimizedIcon.Parent = ScreenGui
    MinimizedIcon.Size = UDim2.new(0, 30, 0, 30)
    MinimizedIcon.Position = UDim2.new(0, 10, 0, 30)
    MinimizedIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizedIcon.BackgroundTransparency = 1
    MinimizedIcon.Image = settings.Icon or "rbxassetid://7743871575"
    MinimizedIcon.Visible = false

    MinimizeButton.MouseButton1Click:Connect(function()
        if MainFrame.Visible then
            MainFrame.Visible = false
            MinimizedIcon.Visible = true
        else
            MainFrame.Visible = true
            MinimizedIcon.Visible = false
        end
    end)
    
    -- Add drag functionality to the MainFrame
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Add drag functionality to the MinimizedIcon with click detection
    local draggingIcon, dragInputIcon, dragStartIcon, startPosIcon
    local clickTime = 0.2
    local startClickTime
    local moved = false

    local function updateIcon(input)
        local delta = input.Position - dragStartIcon
        MinimizedIcon.Position = UDim2.new(startPosIcon.X.Scale, startPosIcon.X.Offset + delta.X, startPosIcon.Y.Scale, startPosIcon.Y.Offset + delta.Y)
        moved = true
    end

    MinimizedIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingIcon = true
            dragStartIcon = input.Position
            startPosIcon = MinimizedIcon.Position
            startClickTime = tick()
            moved = false
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingIcon = false
                    if not moved and tick() - startClickTime <= clickTime then
                        MainFrame.Visible = true
                        MinimizedIcon.Visible = false
                    end
                end
            end)
        end
    end)

    MinimizedIcon.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInputIcon = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInputIcon and draggingIcon then
            updateIcon(input)
        end
    end)
    
    local startPosition = UDim2.new(0.5, 0, 0.5, -25)
    local minimizedIconStartPosition = UDim2.new(0, 10, 0, 30)
    
    local clickInterval = 0.2
    local tapCount = 0
    local lastTapTime = 0
    local function onScreenTap()
        local currentTime = tick()
        if tapCount == 0 or currentTime - lastTapTime <= clickInterval then
            tapCount = tapCount + 1
        else
            tapCount = 1
        end
        lastTapTime = currentTime
    
        if tapCount == 3 then
            MainFrame.Position = startPosition
            MinimizedIcon.Position = minimizedIconStartPosition
            tapCount = 0
        end
    end
    
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            onScreenTap()
        end
    end)
    
    table.insert(Windows, {MainFrame = MainFrame, Language = Language, TabL = TabL, TabR = TabR, Description = Description, settings = settings})
    
    return {
        MainFrame = MainFrame,
        Language = Language,
        TabL = TabL,
        TabR = TabR,
        Description = Description
    }
end

local selectedTab = nil
function Xlib:MakeTab(settings)
    local TabFrame = Instance.new("TextButton")
    TabFrame.Name = settings.Name_Eng or "TabFrame"
    TabFrame.Parent = settings.Parent.TabL
    TabFrame.Size = UDim2.new(1, 0, 0, 25)
    TabFrame.Position = UDim2.new(0, 0, 0, #settings.Parent.TabL:GetChildren() * 25)
    TabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabFrame.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabFrame.Text = string.rep("     ", 2) .. (currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th) 
    TabFrame.TextSize = 16
    TabFrame.TextXAlignment = Enum.TextXAlignment.Left
    TabFrame.Font = Enum.Font.GothamBold
    TabFrame.LayoutOrder = #settings.Parent.TabL:GetChildren() + 1
    TabFrame.BackgroundTransparency = 1
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = TabFrame
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.Position = UDim2.new(0, 15, 0.5, -8)
    Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    Icon.BackgroundTransparency = 1
    Icon.Image = settings.Icon or "rbxassetid://4483345998"

    local FrameFunction = Instance.new("ScrollingFrame")
    FrameFunction.Name = "FrameFunction"
    FrameFunction.Parent = settings.Parent.TabR
    FrameFunction.Size = UDim2.new(1, 0, 1, 0)
    FrameFunction.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    FrameFunction.BorderSizePixel = 0
    FrameFunction.BorderColor3 = Color3.fromRGB(100, 100, 100)
    FrameFunction.ScrollBarThickness = 3
    FrameFunction.BackgroundTransparency = 1
    FrameFunction.Visible = false

    local UIListLayout_R = Instance.new("UIListLayout")
    UIListLayout_R.Parent = FrameFunction
    UIListLayout_R.FillDirection = Enum.FillDirection.Vertical
    UIListLayout_R.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_R.VerticalAlignment = Enum.VerticalAlignment.Top
    UIListLayout_R.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_R.Padding = UDim.new(0, 5)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = FrameFunction
    UIPadding.PaddingTop = UDim.new(0, 10)
    
    UIListLayout_R:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        FrameFunction.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_R.AbsoluteContentSize.Y + 20)  -- Add 20 units for the buffer
    end)
    
    
    TabFrame.MouseButton1Click:Connect(function()
        for _, child in pairs(settings.Parent.TabR:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        FrameFunction.Visible = true
        settings.Parent.Description.Visible = false
        
        if selectedTab then
            selectedTab.TabFrame.TextColor3 = Color3.fromRGB(150, 150, 150)
            selectedTab.Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
        end

        TabFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
        Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)

        selectedTab = {TabFrame = TabFrame, Icon = Icon}
    end)

    table.insert(Tabs, {TabFrame = TabFrame, FrameFunction = FrameFunction, settings = settings})

    return {
        TabFrame = TabFrame,
        FrameFunction = FrameFunction
    }
end

function Xlib:MakeSection(settings)
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = settings.Name_Eng or "SectionFrame"
    SectionFrame.Parent = settings.Parent.FrameFunction
    SectionFrame.Size = UDim2.new(1, -15, 0, 30)
    SectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1
    
    local Section = Instance.new("TextLabel")
    Section.Name = settings.Name_Eng or "Section"
    Section.Parent = SectionFrame
    Section.Size = UDim2.new(0, 0, 0, 20)
    Section.Position = UDim2.new(0, 10, 0, 5)
    Section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Section.BorderSizePixel = 1
    Section.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Section.Text = currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th
    Section.TextColor3 = Color3.fromRGB(255, 255, 255)
    Section.TextSize = 16
    Section.Font = Enum.Font.Gotham
    Section.TextXAlignment = Enum.TextXAlignment.Left
    Section.BackgroundTransparency = 1
    
    local uiListLayout = settings.Parent.FrameFunction:FindFirstChild("UIListLayout")
    if not uiListLayout then
        uiListLayout = Instance.new("UIListLayout")
        uiListLayout.Parent = settings.Parent.FrameFunction
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Padding = UDim.new(0, 5)
    end
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = SectionFrame
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.AnchorPoint = Vector2.new(1, 0.5)
    Icon.Position = UDim2.new(1, -10, 0.5, 0)
    Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7733955969"

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = SectionFrame

    table.insert(Sections, {Section = Section, settings = settings})

    local images = {
        "rbxassetid://7733674820",
        "rbxassetid://7733674820",
        "rbxassetid://7733674589",
        "rbxassetid://7733674589",
        "rbxassetid://7733674731",
        "rbxassetid://7733674731",
        "rbxassetid://7733674503",
        "rbxassetid://7733674503",
        "rbxassetid://7733674731",
        "rbxassetid://7733674731",
        "rbxassetid://7733674589",
        "rbxassetid://7733674589",
    }
    
    local currentImageIndex = 1
    local function toggleIcon()
        while true do
            Icon.Image = images[currentImageIndex]
            
            wait(0.3)
            
            currentImageIndex = currentImageIndex + 1
            if currentImageIndex > #images then
                currentImageIndex = 1
            end
        end
    end
    spawn(toggleIcon)

    return {
        Section = Section
    }
end


function Xlib:MakeButton(settings)
    local Button = Instance.new("TextButton")
    Button.Name = settings.Name or "Button"
    Button.Parent = settings.Parent.FrameFunction
    Button.Size = UDim2.new(1, -15, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 1
    Button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Button.Text = currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th
    Button.TextSize = 16
    Button.Font = Enum.Font.Gotham
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1
    
    local uiListLayout = settings.Parent.FrameFunction:FindFirstChild("UIListLayout")
    if not uiListLayout then
        uiListLayout = Instance.new("UIListLayout")
        uiListLayout.Parent = settings.Parent.FrameFunction
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Padding = UDim.new(0, 5)
    end
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = Button
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.AnchorPoint = Vector2.new(1, 0.5)
    Icon.Position = UDim2.new(1, -10, 0.5, 0)
    Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://3944703587"

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        settings.Callback()
    end)

    table.insert(Buttons, {Button = Button, settings = settings})

    return {
        Button = Button
    }
end

function Xlib:MakeToggle(settings)
    local Toggle = Instance.new("TextButton")
    Toggle.Name = "Toggle"
    Toggle.Parent = settings.Parent.FrameFunction
    Toggle.Size = UDim2.new(1, -15, 0, 30)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.BorderSizePixel = 1
    Toggle.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Toggle.Text = currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th
    Toggle.TextSize = 16
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1

    local uiListLayout = settings.Parent.FrameFunction:FindFirstChild("UIListLayout")
    if not uiListLayout then
        uiListLayout = Instance.new("UIListLayout")
        uiListLayout.Parent = settings.Parent.FrameFunction
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Padding = UDim.new(0, 5)
    end
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Toggle
    
    -- Background for the icon
    local IconBackground = Instance.new("Frame")
    IconBackground.Name = "IconBackground"
    IconBackground.Parent = Toggle
    IconBackground.Size = UDim2.new(0, 20, 0, 20)  -- Size of the background
    IconBackground.AnchorPoint = Vector2.new(1, 0.5)
    IconBackground.Position = UDim2.new(1, -10, 0.5, 0)
    IconBackground.BackgroundColor3 = ToggleValue and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    IconBackground.BorderSizePixel = 0
    IconBackground.BackgroundTransparency = 0.25

    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = IconBackground
    Icon.Size = UDim2.new(1, 0, 1, 0)  -- Make it fill the background
    Icon.AnchorPoint = Vector2.new(0.5, 0.5)
    Icon.Position = UDim2.new(0.5, 0, 0.5, 0)  -- Center the icon
    Icon.Image = "rbxassetid://7743878857" -- Default icon
    Icon.BackgroundTransparency = 1  -- Make icon background transparent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 3)
    Corner.Parent = IconBackground
    
    local ToggleValue = settings.Default or false
    Icon.Image = ToggleValue and "rbxassetid://7733715400" or "rbxassetid://7743878857"
    IconBackground.BackgroundColor3 = ToggleValue and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    settings.Callback(ToggleValue)

    Toggle.MouseButton1Click:Connect(function()
        ToggleValue = not ToggleValue
        Icon.Image = ToggleValue and "rbxassetid://7733715400" or "rbxassetid://7743878857"
        IconBackground.BackgroundColor3 = ToggleValue and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        settings.Callback(ToggleValue)
    end)

    table.insert(Toggles, {Toggle = Toggle, settings = settings})

    return {
        Toggle = Toggle
    }
end


function Xlib:MakeDropdown(settings)
    local Dropdown = Instance.new("TextButton")
    Dropdown.Name = "Dropdown"
    Dropdown.Parent = settings.Parent.FrameFunction
    Dropdown.Size = UDim2.new(1, -15, 0, 30)
    Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Dropdown.BorderSizePixel = 1
    Dropdown.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Dropdown.Text = currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th
    Dropdown.TextSize = 16
    Dropdown.Font = Enum.Font.Gotham
    Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    Dropdown.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1
    
    local uiListLayout = settings.Parent.FrameFunction:FindFirstChild("UIListLayout")
    if not uiListLayout then
        uiListLayout = Instance.new("UIListLayout")
        uiListLayout.Parent = settings.Parent.FrameFunction
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Padding = UDim.new(0, 5)
    end
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = Dropdown
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.AnchorPoint = Vector2.new(1, 0.5)
    Icon.Position = UDim2.new(1, -10, 0.5, 0)
    Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7734091286"

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Dropdown
    
    local DropdownList = Instance.new("ScrollingFrame")
    DropdownList.Name = "DropdownList"
    DropdownList.Parent = settings.Parent.FrameFunction
    DropdownList.Size = UDim2.new(1, -80, 0, 100)
    DropdownList.Position = UDim2.new(0, 0, 0, 0)
    DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    DropdownList.Visible = false
    DropdownList.ScrollBarThickness = 3
    DropdownList.BackgroundTransparency = 1
    DropdownList.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = DropdownList
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = DropdownList
    UIPadding.PaddingTop = UDim.new(0, 10)
    
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        DropdownList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)  -- Add 20 units for the buffer
    end)
    

    local OptionButtons = {}
    local value = nil

    for i, option in ipairs(settings.Options_Eng) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Parent = DropdownList
        OptionButton.Size = UDim2.new(1, -15, 0, 30)
        OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        OptionButton.Text = currentLanguage == "Eng" and option or settings.Options_Th[i]
        OptionButton.TextSize = 16
        OptionButton.Font = Enum.Font.Gotham
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.BorderSizePixel = 0
        OptionButton.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 5)
        Corner.Parent = OptionButton
        
        OptionButton.MouseButton1Click:Connect(function()
            value = option
            settings.Callback(option)
            Dropdown.Text = currentLanguage == "Eng" and option or settings.Options_Th[i] -- Update dropdown button text
            DropdownList.Visible = false
        end)

        table.insert(OptionButtons, OptionButton)
    end

    local DropdownValue = settings.Default or false
    Icon.Image = DropdownValue and "rbxassetid://7733919605" or "rbxassetid://7733717447"

    Dropdown.MouseButton1Click:Connect(function()
        DropdownList.Visible = not DropdownList.Visible
        DropdownValue = not DropdownValue
        Icon.Image = DropdownValue and "rbxassetid://7733919605" or "rbxassetid://7733717447"
    end)

    table.insert(Dropdowns, {Dropdown = Dropdown, OptionButtons = OptionButtons, settings = settings, value = value})

    return {
        Dropdown = Dropdown
    }
end


function Xlib:MakeSlider(settings)
    local Slider = Instance.new("Frame")
    Slider.Name = "Slider"
    Slider.Parent = settings.Parent.FrameFunction
    Slider.Size = UDim2.new(1, -15, 0, 60)
    Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Slider.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1

    local uiListLayout = settings.Parent.FrameFunction:FindFirstChild("UIListLayout")
    if not uiListLayout then
        uiListLayout = Instance.new("UIListLayout")
        uiListLayout.Parent = settings.Parent.FrameFunction
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Padding = UDim.new(0, 5)
    end

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Slider

    local SliderTitle = Instance.new("TextLabel")
    SliderTitle.Parent = Slider
    SliderTitle.Size = UDim2.new(0, 0, 0, 20) -- เริ่มต้นที่ความกว้าง 0
    SliderTitle.Position = UDim2.new(0, 20, 0, 5)
    SliderTitle.AnchorPoint = Vector2.new(0, 0)
    SliderTitle.BackgroundTransparency = 1
    SliderTitle.Text = currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th
    SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderTitle.TextSize = 16
    SliderTitle.Font = Enum.Font.Gotham
    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left -- ชิดซ้าย
    
    -- ฟังก์ชันอัปเดตขนาดตามข้อความ
    local function updateSliderTitleSize()
        local textSize = SliderTitle.TextBounds.X -- คำนวณความกว้างของข้อความ
        SliderTitle.Size = UDim2.new(0, textSize + 15, 0, 20) -- อัปเดตขนาด
    end
    
    -- เรียกใช้งานฟังก์ชันหลังจากตั้งค่า Text
    updateSliderTitleSize()

    local Line = Instance.new("Frame")
    Line.Parent = Slider
    Line.Size = UDim2.new(0.9, 0, 0, 2)
    Line.Position = UDim2.new(0.05, 0, 0.7, 0)
    Line.AnchorPoint = Vector2.new(0, 0)
    Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local Knob = Instance.new("ImageButton")
    Knob.Name = "Knob"
    Knob.Image = "rbxassetid://7733749837" -- ไอคอนเริ่มต้น
    Knob.Parent = Line
    Knob.Size = UDim2.new(0, 25, 0, 25)
    Knob.AnchorPoint = Vector2.new(0, 0.15) -- ตั้งให้กึ่งกลาง
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BackgroundTransparency = 1
    Knob.ImageColor3 = Color3.fromRGB(255, 255, 255)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Knob

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = Slider
    ValueLabel.Size = UDim2.new(0, 20, 0, 20)
    ValueLabel.Position = UDim2.new(0.9, -10, 0, 5)
    ValueLabel.AnchorPoint = Vector2.new(0, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(settings.Default or settings.Min)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 16
    ValueLabel.Font = Enum.Font.Gotham

    -- คำนวณค่าของสไลเดอร์จากตำแหน่งของ Knob โดยใช้ Min และ Max ที่กำหนดไว้
    local function updateValueFromKnobPosition()
        local percent = math.clamp((Knob.Position.X.Scale), 0, 1)
        local value = math.floor((settings.Max - settings.Min) * percent + settings.Min)
        ValueLabel.Text = tostring(value)
        settings.Callback(value)
        
        for i, sliderData in ipairs(Sliders) do
            if sliderData.Slider == Slider then
                sliderData.value = value
            end
        end
    end

    -- ตำแหน่งก่อนหน้าของ Knob สำหรับตรวจจับการลากซ้ายหรือขวา
    local previousX

    Knob.MouseButton1Down:Connect(function()
        local userInputService = game:GetService("UserInputService")
        local dragInput, mouseMove, mouseUp
        local isDragging = true
    
        -- ตั้งค่าไอคอนเริ่มต้นเมื่อเริ่มลาก
        Knob.Image = "rbxassetid://7733749837"

        local function updateKnobPosition(inputPosition)
            local newX = math.clamp(inputPosition.X - Line.AbsolutePosition.X, 0, Line.AbsoluteSize.X)
            Knob.Position = UDim2.new(newX / Line.AbsoluteSize.X, -9, 0, -8)
            
            -- ตรวจสอบการลากว่ากำลังลากไปทางไหน
            if previousX then
                if newX < previousX then
                    -- ลากไปทางซ้าย
                    Knob.Image = "rbxassetid://7733720701"
                elseif newX > previousX then
                    -- ลากไปทางขวา
                    Knob.Image = "rbxassetid://7733919682"
                end
            end

            previousX = newX
            updateValueFromKnobPosition()
        end

        -- ตรวจจับการเคลื่อนไหวของเมาส์และการสัมผัสหน้าจอ
        mouseMove = userInputService.InputChanged:Connect(function(input)
            if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateKnobPosition(input.Position)
            end
        end)
    
        -- หยุดการลากเมื่อปล่อยเมาส์หรือปล่อยการสัมผัส
        mouseUp = userInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                isDragging = false
                mouseMove:Disconnect()
                mouseUp:Disconnect()
                -- เมื่อหยุดลาก เปลี่ยนกลับเป็นไอคอนเริ่มต้น
                Knob.Image = "rbxassetid://7733749837"
            end
        end)
    end)
    
    local defaultPercent = (settings.Default - settings.Min) / (settings.Max - settings.Min)
    Knob.Position = UDim2.new(defaultPercent, -9, 0, -8)
    ValueLabel.Text = tostring(settings.Default)
    settings.Callback(settings.Default)

    table.insert(Sliders, {Slider = Slider, Knob = Knob, SliderTitle = SliderTitle, ValueLabel = ValueLabel, settings = settings, value = settings.Default})

    return {
        Slider = Slider,
        Knob = Knob,
        SliderTitle = SliderTitle,
        ValueLabel = ValueLabel
    }
end

function Xlib:MakeTextbox(settings)
    local TextBoxFrame = Instance.new("Frame")
    TextBoxFrame.Name = settings.Name_Eng or "TextBoxFrame"
    TextBoxFrame.Parent = settings.Parent.FrameFunction
    TextBoxFrame.Size = UDim2.new(1, -15, 0, 30)
    TextBoxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TextBoxFrame.LayoutOrder = #settings.Parent.FrameFunction:GetChildren() + 1
    
    local uiListLayout = settings.Parent.FrameFunction:FindFirstChild("UIListLayout")
    if not uiListLayout then
        uiListLayout = Instance.new("UIListLayout")
        uiListLayout.Parent = settings.Parent.FrameFunction
        uiListLayout.FillDirection = Enum.FillDirection.Vertical
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Padding = UDim.new(0, 5)
    end
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = TextBoxFrame
    
    local TextBoxTitle = Instance.new("TextLabel")
    TextBoxTitle.Parent = TextBoxFrame
    TextBoxTitle.Size = UDim2.new(0, 0, 0, 20)
    TextBoxTitle.Position = UDim2.new(0, 10, 0, 5)
    TextBoxTitle.BackgroundTransparency = 1
    TextBoxTitle.Text = currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th
    TextBoxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBoxTitle.TextSize = 16
    TextBoxTitle.Font = Enum.Font.Gotham
    TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local function updateTextBoxTitleSize()
        local textSize = TextBoxTitle.TextBounds.X
        TextBoxTitle.Size = UDim2.new(0, textSize + 15, 0, 20)
    end
    
    updateTextBoxTitleSize()
    
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = TextBoxFrame
    TextBox.Size = UDim2.new(0, 130, 0, 20)
    TextBox.Position = UDim2.new(1, -140, 0, 5)
    TextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TextBox.Text = settings.Default or ""
    TextBox.TextSize = 16
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.BorderSizePixel = 0
    TextBox.TextWrapped = true
    TextBox.TextScaled = false
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = TextBox
    
    TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            settings.Callback(TextBox.Text)
        end
    end)
    
    table.insert(TextBoxes, {TextBox = TextBox, TextBoxTitle = TextBoxTitle, settings = settings})
    
    return {
        TextBoxFrame = TextBoxFrame,
        TextBox = TextBox,
        TextBoxTitle = TextBoxTitle
    }
end

return Xlib
