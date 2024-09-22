local Xlib = {}

local LG = {"Eng", "Thai"}
local currentLanguageIndex = 1
local currentLanguage = "Eng"
local Tabs = {}
local Sections = {}
local Buttons = {}
local Toggles = {}
local Dropdowns = {}
local Sliders = {}
local TextBoxes = {}

function Xlib:MakeWindow(settings)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Xlib_Gui"
    ScreenGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = settings.Name or "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
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
    TabL.Size = UDim2.new(0.3, 0, 1, -20)
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
        TabL.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_L.AbsoluteContentSize.Y)
    end)

    local TabR = Instance.new("ScrollingFrame")
    TabR.Name = "TabR"
    TabR.Parent = MainFrame
    TabR.Size = UDim2.new(0.7, 0, 1, -20)
    TabR.Position = UDim2.new(0.3, 0, 0, 35)
    TabR.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabR.BorderSizePixel = 0
    TabR.BorderColor3 = Color3.fromRGB(100, 100, 100)
    TabR.ScrollBarThickness = 3

    local UIListLayout_R = Instance.new("UIListLayout")
    UIListLayout_R.Parent = TabR
    UIListLayout_R.FillDirection = Enum.FillDirection.Vertical
    UIListLayout_R.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_R.VerticalAlignment = Enum.VerticalAlignment.Top
    UIListLayout_R.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_R.Padding = UDim.new(0, 5)
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = TabR
    UIPadding.PaddingTop = UDim.new(0, 10)

    local Language = Instance.new("TextButton")
    Language.Name = "Language"
    Language.Parent = TitleBar
    Language.Size = UDim2.new(0, 25, 0, 25)
    Language.Position = UDim2.new(1, -100, 0, 18)
    Language.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    Language.BackgroundTransparency = 1
    Language.BorderSizePixel = 0
    Language.Text = LG[currentLanguageIndex]
    Language.TextColor3 = Color3.fromRGB(255, 255, 255)
    Language.TextScaled = true
    Language.TextSize = 24
    Language.Font = Enum.Font.SourceSansBold
    Language.AnchorPoint = Vector2.new(1, 0.5)
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = TitleBar
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.Position = UDim2.new(1, -145, 0, 6)
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7733965249"

    local function switchLanguage()
        currentLanguageIndex = currentLanguageIndex == 1 and 2 or 1
        currentLanguage = LG[currentLanguageIndex]
        Language.Text = LG[currentLanguageIndex]

        for _, sw in ipairs(Tabs) do
            sw.TabFrame.Text = string.rep("    ", 2) .. (currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th)
        end
        
        for _, sw in ipairs(Sections) do
            sw.Section.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end
        
        for _, sw in ipairs(Buttons) do
            sw.Button.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end

        for _, sw in ipairs(Toggles) do
            sw.Toggle.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th
        end

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
        
        for _, sw in ipairs(Sliders) do
            sw.SliderTitle.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th  -- อัปเดต SliderTitle ตามภาษา
        end
        
        for _, sw in ipairs(TextBoxes) do
            sw.TextBoxTitle.Text = currentLanguage == "Eng" and sw.settings.Name_Eng or sw.settings.Name_Th  -- อัปเดต SliderTitle ตามภาษา
        end
    end

    Language.MouseButton1Click:Connect(switchLanguage)

    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleBar
    MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
    MinimizeButton.Position = UDim2.new(1, -40, 0, 16)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Image = "rbxassetid://7734051594"
    MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)

    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Position = UDim2.new(1, -5, 0, 16)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Image = "rbxassetid://7743878857"
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local MinimizedIcon = Instance.new("ImageButton")
    MinimizedIcon.Name = "MinimizedIcon"
    MinimizedIcon.Parent = ScreenGui
    MinimizedIcon.Size = UDim2.new(0, 30, 0, 30)
    MinimizedIcon.Position = UDim2.new(0, 10, 0, 80)
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
    
    local startPosition = UDim2.new(0.5, 0, 0.5, 0)
    local minimizedIconStartPosition = UDim2.new(0, 10, 0, 10)
    
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

    return {
        MainFrame = MainFrame,
        Language = Language,
        TabL = TabL,
        TabR = TabR
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
    TabFrame.Text = string.rep("    ", 2) .. (currentLanguage == "Eng" and settings.Name_Eng or settings.Name_Th) 
    TabFrame.TextSize = 16
    TabFrame.TextXAlignment = Enum.TextXAlignment.Left
    TabFrame.Font = Enum.Font.GothamBold
    TabFrame.LayoutOrder = #settings.Parent.TabL:GetChildren() + 1
    TabFrame.BackgroundTransparency = 1
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = TabFrame
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.Position = UDim2.new(0, 5, 0.5, -8)
    Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    Icon.BackgroundTransparency = 1
    Icon.Image = settings.Icon or "rbxassetid://4483345998"

    
    local FrameFunction = Instance.new("Frame")
    FrameFunction.Size = UDim2.new(1, 0, 1, 0)
    FrameFunction.BackgroundTransparency = 1
    FrameFunction.Parent = settings.Parent.TabR
    FrameFunction.Visible = false
    
    TabFrame.MouseButton1Click:Connect(function()
        for _, child in pairs(settings.Parent.TabR:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        FrameFunction.Visible = true

        if selectedTab then
            selectedTab.TabFrame.TextColor3 = Color3.fromRGB(150, 150, 150)
            selectedTab.Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
        end

        TabFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
        Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)

        selectedTab = {TabFrame = TabFrame, Icon = Icon}
    end)

    table.insert(Tabs, {TabFrame = TabFrame, settings = settings})

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
    Icon.Image = "rbxassetid://7734006080"

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = SectionFrame

    table.insert(Sections, {Section = Section, settings = settings})

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
    Icon.Image = "rbxassetid://7733955906"

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
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = Toggle
    Icon.Size = UDim2.new(0, 16, 0, 16)
    Icon.AnchorPoint = Vector2.new(1, 0.5)
    Icon.Position = UDim2.new(1, -10, 0.5, 0)
    Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://7734091286" -- ไอคอนเริ่มต้น

    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = Icon
    Stroke.Thickness = 0
    Stroke.Color = Color3.fromRGB(255, 255, 255)
    Stroke.Transparency = 0.5

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Toggle
    
    local ToggleValue = settings.Default or false
    Icon.Image = ToggleValue and "rbxassetid://7743873539" or "rbxassetid://7734091286"

    Toggle.MouseButton1Click:Connect(function()
        ToggleValue = not ToggleValue
        Icon.Image = ToggleValue and "rbxassetid://7743873539" or "rbxassetid://7734091286"
        
        if ToggleValue then
            settings.Callback(ToggleValue)
        end
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
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

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
    Knob.Image = "rbxassetid://7733723321" -- ไอคอนเริ่มต้น
    Knob.Parent = Line
    Knob.Size = UDim2.new(0, 25, 0, 25)
    Knob.AnchorPoint = Vector2.new(0, 0.15) -- ตั้งให้กึ่งกลาง
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BackgroundTransparency = 0.8
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
        Knob.Image = "rbxassetid://7733723321"

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
                Knob.Image = "rbxassetid://7733723321"
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

return {
    Xlib = Xlib
}
