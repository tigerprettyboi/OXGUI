-- Modern GUI Library for Roblox
-- Created by Claude - Inspired by Kavo UI
-- Easy to use, modern and sleek design

local ModernLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- สีและธีมสำหรับ UI
local Theme = {
    Primary = Color3.fromRGB(45, 45, 55),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(75, 150, 255),
    AccentHover = Color3.fromRGB(95, 170, 255),
    Background = Color3.fromRGB(25, 25, 35),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(180, 180, 180),
    Success = Color3.fromRGB(75, 200, 130),
    Warning = Color3.fromRGB(255, 200, 75),
    Error = Color3.fromRGB(255, 100, 100)
}

-- ฟังก์ชันสำหรับสร้าง Tween
local function CreateTween(object, properties, duration)
    duration = duration or 0.3
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    return TweenService:Create(object, tweenInfo, properties)
end

-- ฟังก์ชันสำหรับสร้าง Corner Radius
local function AddCorner(parent, size)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, size or 8)
    corner.Parent = parent
    return corner
end

-- ฟังก์ชันสำหรับสร้าง Shadow Effect
local function AddShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 6, 1, 6)
    shadow.Position = UDim2.new(0, -3, 0, 3)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent.Parent
    return shadow
end

-- ฟังก์ชันสำหรับสร้าง Gradient
local function AddGradient(parent, colors)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors or {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
    })
    gradient.Rotation = 90
    gradient.Parent = parent
    return gradient
end

-- ฟังก์ชันหลักสำหรับสร้าง Window
function ModernLib:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "Modern GUI"
    local windowSize = config.Size or UDim2.new(0, 550, 0, 400)
    
    -- สร้าง ScreenGui หลัก
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernLib_" .. windowTitle
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = PlayerGui
    
    -- สร้าง Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = windowSize
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    AddCorner(MainFrame, 12)
    AddShadow(MainFrame)
    
    -- Header Bar
    local HeaderBar = Instance.new("Frame")
    HeaderBar.Name = "HeaderBar"
    HeaderBar.Size = UDim2.new(1, 0, 0, 50)
    HeaderBar.BackgroundColor3 = Theme.Primary
    HeaderBar.BorderSizePixel = 0
    HeaderBar.Parent = MainFrame
    
    AddCorner(HeaderBar, 12)
    
    -- ปิดมุมล่างของ Header
    local HeaderBottom = Instance.new("Frame")
    HeaderBottom.Size = UDim2.new(1, 0, 0, 12)
    HeaderBottom.Position = UDim2.new(0, 0, 1, -12)
    HeaderBottom.BackgroundColor3 = Theme.Primary
    HeaderBottom.BorderSizePixel = 0
    HeaderBottom.Parent = HeaderBar
    
    -- Title Label
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = windowTitle
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = HeaderBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 10)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = HeaderBar
    
    AddCorner(CloseButton, 6)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -50)
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 2)
    TabList.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -150, 1, -50)
    ContentContainer.Position = UDim2.new(0, 150, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame
    
    -- ระบบลาก Window
    local dragging = false
    local dragStart, startPos
    
    HeaderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            CreateTween(MainFrame, {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            }, 0.1):Play()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Close Button Function
    CloseButton.MouseButton1Click:Connect(function()
        CreateTween(MainFrame, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Hover Effects
    CloseButton.MouseEnter:Connect(function()
        CreateTween(CloseButton, {BackgroundColor3 = Color3.fromRGB(255, 120, 120)}):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        CreateTween(CloseButton, {BackgroundColor3 = Theme.Error}):Play()
    end)
    
    local WindowLib = {
        MainFrame = MainFrame,
        TabContainer = TabContainer,
        ContentContainer = ContentContainer,
        Tabs = {}
    }
    
    -- ฟังก์ชันสำหรับสร้าง Tab
    function WindowLib:CreateTab(config)
        config = config or {}
        local tabName = config.Name or "Tab"
        local tabIcon = config.Icon or "📋"
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "Tab_" .. tabName
        TabButton.Size = UDim2.new(1, -20, 0, 35)
        TabButton.BackgroundColor3 = Theme.Primary
        TabButton.BorderSizePixel = 0
        TabButton.Text = " " .. tabIcon .. "  " .. tabName
        TabButton.TextColor3 = Theme.TextDim
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Font = Enum.Font.Gotham
        TabButton.Parent = TabContainer
        
        AddCorner(TabButton, 6)
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "Content_" .. tabName
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Theme.Accent
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)
        ContentList.Parent = TabContent
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingAll = UDim.new(0, 15)
        ContentPadding.Parent = TabContent
        
        -- Auto-resize canvas
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 30)
        end)
        
        -- Tab Selection Logic
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(WindowLib.Tabs) do
                CreateTween(tab.Button, {
                    BackgroundColor3 = Theme.Primary,
                    TextColor3 = Theme.TextDim
                }):Play()
                tab.Content.Visible = false
            end
            
            CreateTween(TabButton, {
                BackgroundColor3 = Theme.Accent,
                TextColor3 = Theme.Text
            }):Play()
            TabContent.Visible = true
        end)
        
        -- Hover Effects
        TabButton.MouseEnter:Connect(function()
            if TabContent.Visible then return end
            CreateTween(TabButton, {BackgroundColor3 = Theme.Secondary}):Play()
        end)
        
        TabButton.MouseLeave:Connect(function()
            if TabContent.Visible then return end
            CreateTween(TabButton, {BackgroundColor3 = Theme.Primary}):Play()
        end)
        
        local TabLib = {
            Button = TabButton,
            Content = TabContent,
            Name = tabName
        }
        
        WindowLib.Tabs[tabName] = TabLib
        
        -- Select first tab
        if #WindowLib.Tabs == 1 then
            TabButton.MouseButton1Click:Fire()
        end
        
        -- ฟังก์ชันสำหรับสร้าง Button
        function TabLib:CreateButton(config)
            config = config or {}
            local buttonText = config.Text or "Button"
            local callback = config.Callback or function() end
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 0, 35)
            Button.BackgroundColor3 = Theme.Accent
            Button.BorderSizePixel = 0
            Button.Text = buttonText
            Button.TextColor3 = Theme.Text
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = TabContent
            
            AddCorner(Button, 6)
            
            Button.MouseButton1Click:Connect(callback)
            
            Button.MouseEnter:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Theme.AccentHover}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(Button, {BackgroundColor3 = Theme.Accent}):Play()
            end)
            
            return Button
        end
        
        -- ฟังก์ชันสำหรับสร้าง Toggle
        function TabLib:CreateToggle(config)
            config = config or {}
            local toggleText = config.Text or "Toggle"
            local defaultState = config.Default or false
            local callback = config.Callback or function() end
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            ToggleFrame.BackgroundColor3 = Theme.Primary
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            AddCorner(ToggleFrame, 6)
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = toggleText
            ToggleLabel.TextColor3 = Theme.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 40, 0, 20)
            ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleButton.BackgroundColor3 = defaultState and Theme.Success or Theme.Secondary
            ToggleButton.BorderSizePixel = 0
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame
            
            AddCorner(ToggleButton, 10)
            
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
            ToggleCircle.Position = defaultState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            ToggleCircle.BackgroundColor3 = Theme.Text
            ToggleCircle.BorderSizePixel = 0
            ToggleCircle.Parent = ToggleButton
            
            AddCorner(ToggleCircle, 8)
            
            local isToggled = defaultState
            
            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                
                CreateTween(ToggleButton, {
                    BackgroundColor3 = isToggled and Theme.Success or Theme.Secondary
                }):Play()
                
                CreateTween(ToggleCircle, {
                    Position = isToggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                }):Play()
                
                callback(isToggled)
            end)
            
            return {
                Frame = ToggleFrame,
                SetValue = function(value)
                    isToggled = value
                    ToggleButton.BackgroundColor3 = isToggled and Theme.Success or Theme.Secondary
                    ToggleCircle.Position = isToggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                end,
                GetValue = function()
                    return isToggled
                end
            }
        end
        
        -- ฟังก์ชันสำหรับสร้าง Slider
        function TabLib:CreateSlider(config)
            config = config or {}
            local sliderText = config.Text or "Slider"
            local minValue = config.Min or 0
            local maxValue = config.Max or 100
            local defaultValue = config.Default or minValue
            local callback = config.Callback or function() end
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = "SliderFrame"
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = Theme.Primary
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent
            
            AddCorner(SliderFrame, 6)
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -60, 0, 20)
            SliderLabel.Position = UDim2.new(0, 15, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = sliderText
            SliderLabel.TextColor3 = Theme.Text
            SliderLabel.TextSize = 14
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -60, 0, 5)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(defaultValue)
            ValueLabel.TextColor3 = Theme.Accent
            ValueLabel.TextSize = 14
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.Parent = SliderFrame
            
            local SliderTrack = Instance.new("Frame")
            SliderTrack.Size = UDim2.new(1, -30, 0, 6)
            SliderTrack.Position = UDim2.new(0, 15, 1, -15)
            SliderTrack.BackgroundColor3 = Theme.Secondary
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Parent = SliderFrame
            
            AddCorner(SliderTrack, 3)
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
            SliderFill.BackgroundColor3 = Theme.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderTrack
            
            AddCorner(SliderFill, 3)
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(0, 16, 0, 16)
            SliderButton.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -8, 0.5, -8)
            SliderButton.BackgroundColor3 = Theme.Text
            SliderButton.BorderSizePixel = 0
            SliderButton.Text = ""
            SliderButton.Parent = SliderTrack
            
            AddCorner(SliderButton, 8)
            
            local currentValue = defaultValue
            local dragging = false
            
            local function updateSlider(value)
                currentValue = math.clamp(value, minValue, maxValue)
                local percentage = (currentValue - minValue) / (maxValue - minValue)
                
                CreateTween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, 0.1):Play()
                CreateTween(SliderButton, {Position = UDim2.new(percentage, -8, 0.5, -8)}, 0.1):Play()
                
                ValueLabel.Text = tostring(math.floor(currentValue))
                callback(currentValue)
            end
            
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    CreateTween(SliderButton, {Size = UDim2.new(0, 20, 0, 20)}, 0.1):Play()
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local trackSize = SliderTrack.AbsoluteSize.X
                    local mouseX = input.Position.X - SliderTrack.AbsolutePosition.X
                    local percentage = math.clamp(mouseX / trackSize, 0, 1)
                    local value = minValue + (percentage * (maxValue - minValue))
                    updateSlider(value)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
                    dragging = false
                    CreateTween(SliderButton, {Size = UDim2.new(0, 16, 0, 16)}, 0.1):Play()
                end
            end)
            
            return {
                Frame = SliderFrame,
                SetValue = function(value)
                    updateSlider(value)
                end,
                GetValue = function()
                    return currentValue
                end
            }
        end
        
        -- ฟังก์ชันสำหรับสร้าง Label
        function TabLib:CreateLabel(config)
            config = config or {}
            local labelText = config.Text or "Label"
            
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Size = UDim2.new(1, 0, 0, 25)
            Label.BackgroundTransparency = 1
            Label.Text = labelText
            Label.TextColor3 = Theme.Text
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Font = Enum.Font.Gotham
            Label.Parent = TabContent
            
            return {
                Label = Label,
                SetText = function(text)
                    Label.Text = text
                end
            }
        end
        
        return TabLib
    end
    
    return WindowLib
end

return ModernLib
