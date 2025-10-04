local Library = {}

-- สร้าง Window หลัก
function Library:CreateWindow(config)
    local Window = {}
    
    local title = config.Title or "GUI"
    local subtitle = config.Subtitle or ""
    
    -- สร้าง ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MacStyleGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.CoreGui
    
    -- สร้าง Main Frame (หน้าต่างหลัก)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame
    
    -- สร้าง Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleBar
    
    -- ปุ่ม Mac (สีแดง, เหลือง, เขียว)
    local function createDot(color, position)
        local Dot = Instance.new("Frame")
        Dot.Size = UDim2.new(0, 12, 0, 12)
        Dot.Position = UDim2.new(0, position, 0, 19)
        Dot.BackgroundColor3 = color
        Dot.BorderSizePixel = 0
        Dot.Parent = TitleBar
        
        local DotCorner = Instance.new("UICorner")
        DotCorner.CornerRadius = UDim.new(1, 0)
        DotCorner.Parent = Dot
        
        return Dot
    end
    
    createDot(Color3.fromRGB(255, 95, 87), 15)
    createDot(Color3.fromRGB(255, 189, 68), 35)
    createDot(Color3.fromRGB(40, 201, 64), 55)
    
    -- ไอคอนด้านซ้าย (Hamburger Menu)
    local MenuIcon = Instance.new("ImageLabel")
    MenuIcon.Size = UDim2.new(0, 20, 0, 20)
    MenuIcon.Position = UDim2.new(0, 80, 0, 15)
    MenuIcon.BackgroundTransparency = 1
    MenuIcon.Image = "rbxassetid://3926305904"
    MenuIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
    MenuIcon.ImageRectOffset = Vector2.new(644, 364)
    MenuIcon.ImageRectSize = Vector2.new(36, 36)
    MenuIcon.Parent = TitleBar
    
    -- ไอคอนลูกศร (Chevron)
    local ChevronIcon = Instance.new("ImageLabel")
    ChevronIcon.Size = UDim2.new(0, 18, 0, 18)
    ChevronIcon.Position = UDim2.new(0, 105, 0, 16)
    ChevronIcon.BackgroundTransparency = 1
    ChevronIcon.Image = "rbxassetid://3926305904"
    ChevronIcon.ImageColor3 = Color3.fromRGB(180, 180, 180)
    ChevronIcon.ImageRectOffset = Vector2.new(324, 364)
    ChevronIcon.ImageRectSize = Vector2.new(36, 36)
    ChevronIcon.Parent = TitleBar
    
    -- Title Text (ใหญ่)
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -140, 0, 20)
    TitleLabel.Position = UDim2.new(0, 130, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    TitleLabel.TextSize = 15
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    -- Subtitle Text (เล็ก)
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Size = UDim2.new(1, -140, 0, 16)
    SubtitleLabel.Position = UDim2.new(0, 130, 0, 28)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = subtitle
    SubtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
    SubtitleLabel.TextSize = 12
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.Parent = TitleBar
    
    -- สร้าง Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 180, 1, -50)
    Sidebar.Position = UDim2.new(0, 0, 0, 50)
    Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    
    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 10)
    SidebarCorner.Parent = Sidebar
    
    -- ScrollingFrame สำหรับ Tabs
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Size = UDim2.new(1, -10, 1, -10)
    TabList.Position = UDim2.new(0, 5, 0, 5)
    TabList.BackgroundTransparency = 1
    TabList.BorderSizePixel = 0
    TabList.ScrollBarThickness = 4
    TabList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    TabList.Parent = Sidebar
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 3)
    TabListLayout.Parent = TabList
    
    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -190, 1, -60)
    ContentArea.Position = UDim2.new(0, 185, 0, 55)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame
    
    -- ทำให้ลากได้
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    Window.CurrentTab = nil
    Window.Tabs = {}
    
    -- ฟังก์ชันสร้าง Tab
    function Window:NewTab(tabName, iconId)
        local Tab = {}
        
        -- สร้างปุ่ม Tab
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.BorderSizePixel = 0
        TabButton.Text = ""
        TabButton.Parent = TabList
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton
        
        -- ไอคอน
        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 20, 0, 20)
        Icon.Position = UDim2.new(0, 10, 0.5, -10)
        Icon.BackgroundTransparency = 1
        Icon.Image = iconId or ""
        Icon.ImageColor3 = Color3.fromRGB(180, 180, 180)
        Icon.Parent = TabButton
        
        -- ข้อความ Tab
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Size = UDim2.new(1, -40, 1, 0)
        TabLabel.Position = UDim2.new(0, 35, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.Text = tabName
        TabLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabLabel.TextSize = 13
        TabLabel.Font = Enum.Font.Gotham
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Parent = TabButton
        
        -- สร้าง Content สำหรับ Tab นี้
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabName .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
        TabContent.Visible = false
        TabContent.Parent = ContentArea
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.Parent = TabContent
        
        -- เมื่อคลิกที่ Tab
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                tab.Label.TextColor3 = Color3.fromRGB(180, 180, 180)
                tab.Icon.ImageColor3 = Color3.fromRGB(180, 180, 180)
                tab.Content.Visible = false
            end
            
            TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end)
        
        -- ถ้าเป็น Tab แรก ให้แสดงทันที
        if #Window.Tabs == 0 then
            TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Label = TabLabel
        Tab.Icon = Icon
        table.insert(Window.Tabs, Tab)
        
        -- ฟังก์ชันสร้าง Button
        function Tab:NewButton(buttonText, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -10, 0, 35)
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.BorderSizePixel = 0
            Button.Text = buttonText
            Button.TextColor3 = Color3.fromRGB(220, 220, 220)
            Button.TextSize = 13
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabContent
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button
            
            Button.MouseButton1Click:Connect(function()
                Button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                wait(0.1)
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                callback()
            end)
            
            return Button
        end
        
        -- ฟังก์ชันสร้าง Toggle
        function Tab:NewToggle(toggleText, default, callback)
            local toggled = default or false
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -10, 0, 35)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = toggleText
            ToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            ToggleLabel.TextSize = 13
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
            ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(60, 60, 60)
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            local ToggleBtnCorner = Instance.new("UICorner")
            ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
            ToggleBtnCorner.Parent = ToggleButton
            
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
            ToggleCircle.Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.BorderSizePixel = 0
            ToggleCircle.Parent = ToggleButton
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = ToggleCircle
            
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                game:GetService("TweenService"):Create(
                    ToggleButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = toggled and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(60, 60, 60)}
                ):Play()
                
                game:GetService("TweenService"):Create(
                    ToggleCircle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}
                ):Play()
                
                callback(toggled)
            end)
            
            return ToggleButton
        end
        
        -- ฟังก์ชันสร้าง Label
        function Tab:NewLabel(labelText)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 0, 30)
            Label.BackgroundTransparency = 1
            Label.Text = labelText
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.TextSize = 13
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = TabContent
            
            return Label
        end
        
        return Tab
    end
    
    return Window
end

return Library
