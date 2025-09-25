-- NexusUI Library - Compact Dark GUI Library
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/NexusUI/main/source.lua"))()

local NexusUI = {}
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ตัวแปรสำหรับจัดการ GUI
local screenGui
local mainFrame
local sidebarFrame
local contentFrame
local titleLabel
local currentTab
local tabs = {}
local isVisible = true

-- สีและธีม
local theme = {
    primary = Color3.fromRGB(20, 20, 25),
    secondary = Color3.fromRGB(25, 25, 30),
    accent = Color3.fromRGB(0, 162, 255),
    text = Color3.fromRGB(255, 255, 255),
    textSecondary = Color3.fromRGB(180, 180, 180),
    success = Color3.fromRGB(76, 175, 80),
    warning = Color3.fromRGB(255, 193, 7),
    danger = Color3.fromRGB(244, 67, 54)
}

-- ฟังก์ชันสร้าง UI Elements
local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(40, 40, 45)
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

-- ฟังก์ชันสร้าง Window หลัก
function NexusUI:CreateWindow(options)
    options = options or {}
    local windowTitle = options.Title or "NexusUI"
    local windowSize = options.Size or {400, 280}
    local toggleKey = options.ToggleKey or Enum.KeyCode.RightControl
    
    -- ลบ GUI เก่าถ้ามี
    if screenGui then
        screenGui:Destroy()
    end
    
    -- สร้าง ScreenGui
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NexusUI"
    screenGui.Parent = playerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    
    -- สร้าง Main Frame
    mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = screenGui
    mainFrame.Size = UDim2.new(0, windowSize[1], 0, windowSize[2])
    mainFrame.Position = UDim2.new(0.5, -windowSize[1]/2, 0.5, -windowSize[2]/2)
    mainFrame.BackgroundColor3 = theme.primary
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    
    createCorner(mainFrame, 10)
    createStroke(mainFrame, Color3.fromRGB(40, 40, 45), 1)
    
    -- สร้าง Sidebar
    sidebarFrame = Instance.new("Frame")
    sidebarFrame.Name = "Sidebar"
    sidebarFrame.Parent = mainFrame
    sidebarFrame.Size = UDim2.new(0, 120, 1, 0)
    sidebarFrame.Position = UDim2.new(0, 0, 0, 0)
    sidebarFrame.BackgroundColor3 = theme.secondary
    sidebarFrame.BorderSizePixel = 0
    
    createCorner(sidebarFrame, 10)
    
    -- สร้าง Title
    titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = sidebarFrame
    titleLabel.Size = UDim2.new(1, -20, 0, 35)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = windowTitle
    titleLabel.TextColor3 = theme.text
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    
    -- สร้าง Content Frame
    contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Parent = mainFrame
    contentFrame.Size = UDim2.new(1, -130, 1, -10)
    contentFrame.Position = UDim2.new(0, 125, 0, 5)
    contentFrame.BackgroundColor3 = theme.primary
    contentFrame.BorderSizePixel = 0
    
    createCorner(contentFrame, 8)
    
    -- สร้าง ScrollingFrame สำหรับ Tabs
    local tabScrollFrame = Instance.new("ScrollingFrame")
    tabScrollFrame.Name = "TabScroll"
    tabScrollFrame.Parent = sidebarFrame
    tabScrollFrame.Size = UDim2.new(1, -10, 1, -55)
    tabScrollFrame.Position = UDim2.new(0, 5, 0, 50)
    tabScrollFrame.BackgroundTransparency = 1
    tabScrollFrame.BorderSizePixel = 0
    tabScrollFrame.ScrollBarThickness = 2
    tabScrollFrame.ScrollBarImageColor3 = theme.accent
    tabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- UI Layout สำหรับ Tabs
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabScrollFrame
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 2)
    
    -- ฟังก์ชัน Toggle GUI
    local function toggleGUI()
        if isVisible then
            local tween = TweenService:Create(
                mainFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }
            )
            tween:Play()
            isVisible = false
        else
            local tween = TweenService:Create(
                mainFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, windowSize[1], 0, windowSize[2]),
                    Position = UDim2.new(0.5, -windowSize[1]/2, 0.5, -windowSize[2]/2)
                }
            )
            tween:Play()
            isVisible = true
        end
    end
    
    -- จัดการ Toggle Key
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == toggleKey then
            toggleGUI()
        end
    end)
    
    -- สร้าง Window Object
    local window = {}
    
    -- ฟังก์ชันสร้าง Tab
    function window:CreateTab(options)
        options = options or {}
        local tabName = options.Name or "Tab"
        local tabIcon = options.Icon or "🏠"
        
        -- สร้าง Tab Button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Parent = tabScrollFrame
        tabButton.Size = UDim2.new(1, -10, 0, 32)
        tabButton.Position = UDim2.new(0, 0, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        tabButton.BackgroundTransparency = 0.5
        tabButton.BorderSizePixel = 0
        tabButton.Text = ""
        tabButton.AutoButtonColor = false
        
        createCorner(tabButton, 6)
        
        -- สร้าง Tab Icon
        local tabIconLabel = Instance.new("TextLabel")
        tabIconLabel.Name = "Icon"
        tabIconLabel.Parent = tabButton
        tabIconLabel.Size = UDim2.new(0, 20, 0, 20)
        tabIconLabel.Position = UDim2.new(0, 8, 0.5, -10)
        tabIconLabel.BackgroundTransparency = 1
        tabIconLabel.Text = tabIcon
        tabIconLabel.TextColor3 = theme.textSecondary
        tabIconLabel.TextSize = 14
        tabIconLabel.Font = Enum.Font.Gotham
        
        -- สร้าง Tab Label
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Name = "Label"
        tabLabel.Parent = tabButton
        tabLabel.Size = UDim2.new(1, -35, 1, 0)
        tabLabel.Position = UDim2.new(0, 30, 0, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = tabName
        tabLabel.TextColor3 = theme.textSecondary
        tabLabel.TextSize = 12
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.Font = Enum.Font.Gotham
        
        -- สร้าง Tab Content
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName .. "Content"
        tabContent.Parent = contentFrame
        tabContent.Size = UDim2.new(1, -10, 1, -10)
        tabContent.Position = UDim2.new(0, 5, 0, 5)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.ScrollBarThickness = 2
        tabContent.ScrollBarImageColor3 = theme.accent
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.Visible = false
        
        -- UI Layout สำหรับ Content
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Parent = tabContent
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 5)
        
        -- ฟังก์ชันเปลี่ยน Tab
        local function selectTab()
            -- Reset ทุก Tab
            for _, tab in pairs(tabs) do
                tab.button.BackgroundTransparency = 0.5
                tab.icon.TextColor3 = theme.textSecondary
                tab.label.TextColor3 = theme.textSecondary
                tab.content.Visible = false
            end
            
            -- เปิดใช้งาน Tab ปัจจุบัน
            tabButton.BackgroundTransparency = 0.1
            tabIconLabel.TextColor3 = theme.accent
            tabLabel.TextColor3 = theme.text
            tabContent.Visible = true
            
            -- Tween Animation
            local tween = TweenService:Create(
                tabButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = theme.accent}
            )
            tween:Play()
            
            currentTab = tabName
        end
        
        -- เชื่อมต่อ Click Event
        tabButton.MouseButton1Click:Connect(selectTab)
        
        -- เก็บข้อมูล Tab
        local tabData = {
            button = tabButton,
            icon = tabIconLabel,
            label = tabLabel,
            content = tabContent,
            layout = contentLayout,
            name = tabName
        }
        
        tabs[tabName] = tabData
        
        -- ตั้ง Tab แรกเป็นค่าเริ่มต้น
        if not currentTab then
            selectTab()
        end
        
        -- อัพเดท Canvas Size
        tabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y)
        contentLayout.Changed:Connect(function()
            tabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y)
        end)
        
        -- สร้าง Tab Object
        local tab = {}
        
        -- ฟังก์ชันสร้าง Toggle
        function tab:CreateToggle(options)
            options = options or {}
            local toggleName = options.Name or "Toggle"
            local defaultValue = options.Default or false
            local callback = options.Callback or function() end
            
            -- สร้าง Toggle Frame
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = "ToggleFrame"
            toggleFrame.Parent = tabContent
            toggleFrame.Size = UDim2.new(1, -10, 0, 35)
            toggleFrame.BackgroundColor3 = theme.secondary
            toggleFrame.BorderSizePixel = 0
            
            createCorner(toggleFrame, 6)
            
            -- สร้าง Toggle Label
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Name = "Label"
            toggleLabel.Parent = toggleFrame
            toggleLabel.Size = UDim2.new(1, -50, 1, 0)
            toggleLabel.Position = UDim2.new(0, 10, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = toggleName
            toggleLabel.TextColor3 = theme.text
            toggleLabel.TextSize = 12
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Font = Enum.Font.Gotham
            
            -- สร้าง Toggle Switch
            local toggleButton = Instance.new("TextButton")
            toggleButton.Name = "Switch"
            toggleButton.Parent = toggleFrame
            toggleButton.Size = UDim2.new(0, 35, 0, 20)
            toggleButton.Position = UDim2.new(1, -40, 0.5, -10)
            toggleButton.BackgroundColor3 = defaultValue and theme.accent or Color3.fromRGB(60, 60, 65)
            toggleButton.BorderSizePixel = 0
            toggleButton.Text = ""
            toggleButton.AutoButtonColor = false
            
            createCorner(toggleButton, 10)
            
            -- สร้าง Toggle Circle
            local toggleCircle = Instance.new("Frame")
            toggleCircle.Name = "Circle"
            toggleCircle.Parent = toggleButton
            toggleCircle.Size = UDim2.new(0, 16, 0, 16)
            toggleCircle.Position = defaultValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            toggleCircle.BackgroundColor3 = theme.text
            toggleCircle.BorderSizePixel = 0
            
            createCorner(toggleCircle, 8)
            
            -- ตัวแปรสถานะ
            local isToggled = defaultValue
            
            -- ฟังก์ชัน Toggle
            local function toggle()
                isToggled = not isToggled
                
                local buttonTween = TweenService:Create(
                    toggleButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = isToggled and theme.accent or Color3.fromRGB(60, 60, 65)}
                )
                
                local circleTween = TweenService:Create(
                    toggleCircle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Position = isToggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}
                )
                
                buttonTween:Play()
                circleTween:Play()
                
                callback(isToggled)
            end
            
            toggleButton.MouseButton1Click:Connect(toggle)
            
            -- อัพเดท Canvas Size
            contentLayout.Changed:Connect(function()
                tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
            end)
            
            return {
                SetValue = function(value)
                    if value ~= isToggled then
                        toggle()
                    end
                end
            }
        end
        
        -- ฟังก์ชันสร้าง Button
        function tab:CreateButton(options)
            options = options or {}
            local buttonName = options.Name or "Button"
            local callback = options.Callback or function() end
            
            -- สร้าง Button
            local button = Instance.new("TextButton")
            button.Name = "Button"
            button.Parent = tabContent
            button.Size = UDim2.new(1, -10, 0, 35)
            button.BackgroundColor3 = theme.secondary
            button.BorderSizePixel = 0
            button.Text = buttonName
            button.TextColor3 = theme.text
            button.TextSize = 12
            button.Font = Enum.Font.Gotham
            button.AutoButtonColor = false
            
            createCorner(button, 6)
            
            -- Hover Effect
            button.MouseEnter:Connect(function()
                local tween = TweenService:Create(
                    button,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = theme.accent}
                )
                tween:Play()
            end)
            
            button.MouseLeave:Connect(function()
                local tween = TweenService:Create(
                    button,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = theme.secondary}
                )
                tween:Play()
            end)
            
            button.MouseButton1Click:Connect(callback)
            
            -- อัพเดท Canvas Size
            contentLayout.Changed:Connect(function()
                tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
            end)
        end
        
        return tab
    end
    
    return window
end

return NexusUI
