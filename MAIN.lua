-- Premium Roblox GUI Library
-- Designed for elegance and simplicity
-- Created with smooth animations and professional styling

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Animation configs
local TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local FAST_TWEEN = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Color scheme
local Colors = {
    Background = Color3.fromRGB(15, 15, 20),
    Secondary = Color3.fromRGB(25, 25, 35),
    Accent = Color3.fromRGB(100, 120, 255),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(180, 180, 190),
    Success = Color3.fromRGB(50, 200, 100),
    Warning = Color3.fromRGB(255, 170, 50),
    Danger = Color3.fromRGB(255, 80, 80)
}

-- Utility functions
local function CreateGradient(colorStart, colorStop, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, colorStart),
        ColorSequenceKeypoint.new(1, colorStop)
    }
    gradient.Rotation = rotation or 45
    return gradient
end

local function CreateCorner(radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    return corner
end

local function CreateStroke(color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(40, 40, 50)
    stroke.Thickness = thickness or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return stroke
end

local function CreateDropShadow(parent, size, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "DropShadow"
    shadow.Parent = parent
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or 0.8
    shadow.Size = UDim2.new(1, size or 10, 1, size or 10)
    shadow.Position = UDim2.new(0, -(size or 10)/2, 0, -(size or 10)/2)
    shadow.ZIndex = parent.ZIndex - 1
    CreateCorner(12).Parent = shadow
end

-- Main Library Functions
function Library:CreateWindow(config)
    local WindowConfig = {
        Title = config.Title or "Premium GUI",
        Size = config.Size or UDim2.new(0, 500, 0, 350),
        Theme = config.Theme or "Dark",
        Draggable = config.Draggable ~= false
    }
    
    -- Main GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PremiumGUI_" .. math.random(1000, 9999)
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Colors.Background
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.Size = WindowConfig.Size
    MainFrame.Position = UDim2.new(0.5, -WindowConfig.Size.X.Offset/2, 0.5, -WindowConfig.Size.Y.Offset/2)
    MainFrame.ZIndex = 10
    
    CreateCorner(12).Parent = MainFrame
    CreateStroke(Color3.fromRGB(60, 60, 80), 1).Parent = MainFrame
    CreateDropShadow(MainFrame, 15, 0.7)
    
    -- Gradient background
    local mainGradient = CreateGradient(Colors.Background, Color3.fromRGB(20, 25, 35), 135)
    mainGradient.Parent = MainFrame
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Colors.Secondary
    TitleBar.BackgroundTransparency = 0.2
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.ZIndex = 11
    
    CreateCorner(12).Parent = TitleBar
    CreateStroke(Color3.fromRGB(70, 70, 90), 1).Parent = TitleBar
    
    local titleGradient = CreateGradient(Color3.fromRGB(30, 35, 45), Color3.fromRGB(20, 25, 35), 90)
    titleGradient.Parent = TitleBar
    
    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "TitleText"
    TitleText.Parent = TitleBar
    TitleText.BackgroundTransparency = 1
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 15, 0, 0)
    TitleText.Text = WindowConfig.Title
    TitleText.TextColor3 = Colors.Text
    TitleText.TextScaled = true
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Font = Enum.Font.GothamBold
    TitleText.ZIndex = 12
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundColor3 = Colors.Danger
    CloseButton.BackgroundTransparency = 0.3
    CloseButton.Size = UDim2.new(0, 30, 0, 25)
    CloseButton.Position = UDim2.new(1, -40, 0, 7.5)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Colors.Text
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.ZIndex = 12
    
    CreateCorner(6).Parent = CloseButton
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleBar
    MinimizeButton.BackgroundColor3 = Colors.Warning
    MinimizeButton.BackgroundTransparency = 0.3
    MinimizeButton.Size = UDim2.new(0, 30, 0, 25)
    MinimizeButton.Position = UDim2.new(1, -75, 0, 7.5)
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Colors.Text
    MinimizeButton.TextScaled = true
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.ZIndex = 12
    
    CreateCorner(6).Parent = MinimizeButton
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Size = UDim2.new(0, 150, 1, -50)
    TabContainer.Position = UDim2.new(0, 10, 0, 45)
    TabContainer.ZIndex = 11
    
    -- Tab List
    local TabList = Instance.new("ScrollingFrame")
    TabList.Name = "TabList"
    TabList.Parent = TabContainer
    TabList.BackgroundTransparency = 1
    TabList.Size = UDim2.new(1, 0, 1, 0)
    TabList.Position = UDim2.new(0, 0, 0, 0)
    TabList.ScrollBarThickness = 3
    TabList.ScrollBarImageColor3 = Colors.Accent
    TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabList.ZIndex = 11
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabList
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundColor3 = Colors.Secondary
    ContentContainer.BackgroundTransparency = 0.4
    ContentContainer.Size = UDim2.new(1, -180, 1, -50)
    ContentContainer.Position = UDim2.new(0, 170, 0, 45)
    ContentContainer.ZIndex = 11
    
    CreateCorner(8).Parent = ContentContainer
    CreateStroke(Color3.fromRGB(50, 50, 70), 1).Parent = ContentContainer
    
    local contentGradient = CreateGradient(Color3.fromRGB(18, 22, 30), Color3.fromRGB(25, 30, 40), 180)
    contentGradient.Parent = ContentContainer
    
    -- Dragging functionality
    if WindowConfig.Draggable then
        local dragging = false
        local dragStart = nil
        local startPos = nil
        
        TitleBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
    
    -- Window methods
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    -- Close functionality
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, FAST_TWEEN, {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(MainFrame, FAST_TWEEN, {BackgroundTransparency = 1}):Play()
        wait(0.15)
        ScreenGui:Destroy()
    end)
    
    -- Minimize functionality
    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        if not minimized then
            TweenService:Create(MainFrame, TWEEN_INFO, {Size = UDim2.new(0, WindowConfig.Size.X.Offset, 0, 40)}):Play()
            minimized = true
        else
            TweenService:Create(MainFrame, TWEEN_INFO, {Size = WindowConfig.Size}):Play()
            minimized = false
        end
    end)
    
    function Window:CreateTab(name, icon)
        local Tab = {}
        
        -- Tab Button
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabList
        TabButton.BackgroundColor3 = Colors.Secondary
        TabButton.BackgroundTransparency = 0.3
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Text = (icon and icon .. " " or "") .. name
        TabButton.TextColor3 = Colors.SubText
        TabButton.TextScaled = true
        TabButton.Font = Enum.Font.Gotham
        TabButton.ZIndex = 12
        
        CreateCorner(6).Parent = TabButton
        CreateStroke(Color3.fromRGB(40, 40, 60), 1).Parent = TabButton
        
        -- Tab Content
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name .. "Content"
        TabContent.Parent = ContentContainer
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = Colors.Accent
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.ZIndex = 12
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Parent = TabContent
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 8)
        
        -- Auto-resize canvas
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab button functionality
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, tab in pairs(Window.Tabs) do
                tab.Content.Visible = false
                TweenService:Create(tab.Button, FAST_TWEEN, {
                    BackgroundTransparency = 0.3,
                    TextColor3 = Colors.SubText
                }):Play()
            end
            
            -- Show current tab
            TabContent.Visible = true
            Window.CurrentTab = Tab
            TweenService:Create(TabButton, FAST_TWEEN, {
                BackgroundTransparency = 0.1,
                TextColor3 = Colors.Text
            }):Play()
        end)
        
        -- Hover effects
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                TweenService:Create(TabButton, FAST_TWEEN, {BackgroundTransparency = 0.2}):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                TweenService:Create(TabButton, FAST_TWEEN, {BackgroundTransparency = 0.3}):Play()
            end
        end)
        
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Layout = ContentLayout
        
        -- Tab methods
        function Tab:CreateToggle(config)
            local ToggleConfig = {
                Name = config.Name or "Toggle",
                Description = config.Description or "",
                Default = config.Default or false,
                Callback = config.Callback or function() end
            }
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = ToggleConfig.Name .. "Toggle"
            ToggleFrame.Parent = TabContent
            ToggleFrame.BackgroundColor3 = Colors.Secondary
            ToggleFrame.BackgroundTransparency = 0.2
            ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
            ToggleFrame.ZIndex = 13
            
            CreateCorner(8).Parent = ToggleFrame
            CreateStroke(Color3.fromRGB(60, 60, 80), 1).Parent = ToggleFrame
            
            local toggleGradient = CreateGradient(Color3.fromRGB(25, 30, 40), Color3.fromRGB(30, 35, 45), 90)
            toggleGradient.Parent = ToggleFrame
            
            -- Toggle Text
            local ToggleText = Instance.new("TextLabel")
            ToggleText.Name = "ToggleText"
            ToggleText.Parent = ToggleFrame
            ToggleText.BackgroundTransparency = 1
            ToggleText.Size = UDim2.new(1, -70, 0.6, 0)
            ToggleText.Position = UDim2.new(0, 15, 0, 5)
            ToggleText.Text = ToggleConfig.Name
            ToggleText.TextColor3 = Colors.Text
            ToggleText.TextScaled = true
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left
            ToggleText.Font = Enum.Font.GothamBold
            ToggleText.ZIndex = 14
            
            -- Toggle Description
            if ToggleConfig.Description ~= "" then
                local ToggleDesc = Instance.new("TextLabel")
                ToggleDesc.Name = "ToggleDesc"
                ToggleDesc.Parent = ToggleFrame
                ToggleDesc.BackgroundTransparency = 1
                ToggleDesc.Size = UDim2.new(1, -70, 0.4, 0)
                ToggleDesc.Position = UDim2.new(0, 15, 0.6, 0)
                ToggleDesc.Text = ToggleConfig.Description
                ToggleDesc.TextColor3 = Colors.SubText
                ToggleDesc.TextScaled = true
                ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
                ToggleDesc.Font = Enum.Font.Gotham
                ToggleDesc.ZIndex = 14
            end
            
            -- Toggle Switch
            local ToggleSwitch = Instance.new("Frame")
            ToggleSwitch.Name = "ToggleSwitch"
            ToggleSwitch.Parent = ToggleFrame
            ToggleSwitch.BackgroundColor3 = ToggleConfig.Default and Colors.Success or Color3.fromRGB(60, 60, 70)
            ToggleSwitch.Size = UDim2.new(0, 45, 0, 20)
            ToggleSwitch.Position = UDim2.new(1, -60, 0.5, -10)
            ToggleSwitch.ZIndex = 14
            
            CreateCorner(10).Parent = ToggleSwitch
            
            -- Toggle Circle
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Name = "ToggleCircle"
            ToggleCircle.Parent = ToggleSwitch
            ToggleCircle.BackgroundColor3 = Colors.Text
            ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
            ToggleCircle.Position = ToggleConfig.Default and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
            ToggleCircle.ZIndex = 15
            
            CreateCorner(8).Parent = ToggleCircle
            CreateDropShadow(ToggleCircle, 4, 0.6)
            
            -- Toggle functionality
            local toggled = ToggleConfig.Default
            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.Text = ""
            ToggleButton.ZIndex = 16
            
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                -- Animate switch
                TweenService:Create(ToggleSwitch, TWEEN_INFO, {
                    BackgroundColor3 = toggled and Colors.Success or Color3.fromRGB(60, 60, 70)
                }):Play()
                
                TweenService:Create(ToggleCircle, TWEEN_INFO, {
                    Position = toggled and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                }):Play()
                
                -- Callback
                ToggleConfig.Callback(toggled)
            end)
            
            -- Hover effects
            ToggleButton.MouseEnter:Connect(function()
                TweenService:Create(ToggleFrame, FAST_TWEEN, {BackgroundTransparency = 0.1}):Play()
            end)
            
            ToggleButton.MouseLeave:Connect(function()
                TweenService:Create(ToggleFrame, FAST_TWEEN, {BackgroundTransparency = 0.2}):Play()
            end)
            
            return {
                SetValue = function(value)
                    toggled = value
                    TweenService:Create(ToggleSwitch, TWEEN_INFO, {
                        BackgroundColor3 = toggled and Colors.Success or Color3.fromRGB(60, 60, 70)
                    }):Play()
                    TweenService:Create(ToggleCircle, TWEEN_INFO, {
                        Position = toggled and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
                    }):Play()
                end,
                GetValue = function()
                    return toggled
                end
            }
        end
        
        function Tab:CreateButton(config)
            local ButtonConfig = {
                Name = config.Name or "Button",
                Description = config.Description or "",
                Callback = config.Callback or function() end
            }
            
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Name = ButtonConfig.Name .. "Button"
            ButtonFrame.Parent = TabContent
            ButtonFrame.BackgroundColor3 = Colors.Accent
            ButtonFrame.BackgroundTransparency = 0.1
            ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
            ButtonFrame.Text = ""
            ButtonFrame.ZIndex = 13
            
            CreateCorner(8).Parent = ButtonFrame
            CreateStroke(Color3.fromRGB(120, 140, 255), 1).Parent = ButtonFrame
            
            local buttonGradient = CreateGradient(Colors.Accent, Color3.fromRGB(80, 100, 235), 45)
            buttonGradient.Parent = ButtonFrame
            
            -- Button Text
            local ButtonText = Instance.new("TextLabel")
            ButtonText.Name = "ButtonText"
            ButtonText.Parent = ButtonFrame
            ButtonText.BackgroundTransparency = 1
            ButtonText.Size = UDim2.new(1, -20, 1, 0)
            ButtonText.Position = UDim2.new(0, 10, 0, 0)
            ButtonText.Text = ButtonConfig.Name
            ButtonText.TextColor3 = Colors.Text
            ButtonText.TextScaled = true
            ButtonText.Font = Enum.Font.GothamBold
            ButtonText.ZIndex = 14
            
            -- Button functionality
            ButtonFrame.MouseButton1Click:Connect(function()
                -- Click animation
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {Size = UDim2.new(1, -4, 0, 36)}):Play()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                
                ButtonConfig.Callback()
            end)
            
            -- Hover effects
            ButtonFrame.MouseEnter:Connect(function()
                TweenService:Create(ButtonFrame, FAST_TWEEN, {BackgroundTransparency = 0.05}):Play()
            end)
            
            ButtonFrame.MouseLeave:Connect(function()
                TweenService:Create(ButtonFrame, FAST_TWEEN, {BackgroundTransparency = 0.1}):Play()
            end)
        end
        
        function Tab:CreateSection(name)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = name .. "Section"
            SectionFrame.Parent = TabContent
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Size = UDim2.new(1, 0, 0, 30)
            SectionFrame.ZIndex = 13
            
            local SectionText = Instance.new("TextLabel")
            SectionText.Name = "SectionText"
            SectionText.Parent = SectionFrame
            SectionText.BackgroundTransparency = 1
            SectionText.Size = UDim2.new(1, 0, 1, 0)
            SectionText.Text = name
            SectionText.TextColor3 = Colors.Accent
            SectionText.TextScaled = true
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            SectionText.Font = Enum.Font.GothamBold
            SectionText.ZIndex = 14
            
            local SectionLine = Instance.new("Frame")
            SectionLine.Name = "SectionLine"
            SectionLine.Parent = SectionFrame
            SectionLine.BackgroundColor3 = Colors.Accent
            SectionLine.BackgroundTransparency = 0.5
            SectionLine.Size = UDim2.new(1, 0, 0, 1)
            SectionLine.Position = UDim2.new(0, 0, 1, -1)
            SectionLine.ZIndex = 13
        end
        
        Table.insert(Window.Tabs, Tab)
        
        -- Auto-select first tab
        if #Window.Tabs == 1 then
            TabButton.MouseButton1Click:Fire()
        end
        
        return Tab
    end
    
    return Window
end

return Library
