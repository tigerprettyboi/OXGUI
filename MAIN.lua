-- OXGUI Library v1.0
-- Modern, Clean, and Easy-to-use GUI Library for Roblox
-- Created for https://raw.githubusercontent.com/tigerprettyboi/OXGUI/refs/heads/main/MAIN.lua

local OXGUI = {}
OXGUI.__index = OXGUI

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Tween Presets
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local quickTween = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- Color Palette
local Colors = {
    Background = Color3.fromRGB(20, 20, 25),
    Surface = Color3.fromRGB(30, 30, 40),
    Primary = Color3.fromRGB(100, 120, 255),
    Secondary = Color3.fromRGB(60, 60, 80),
    Text = Color3.fromRGB(220, 220, 225),
    TextSecondary = Color3.fromRGB(160, 160, 170),
    Accent = Color3.fromRGB(120, 140, 255),
    Success = Color3.fromRGB(100, 200, 120),
    Warning = Color3.fromRGB(255, 180, 100),
    Error = Color3.fromRGB(255, 100, 120)
}

-- Create Main Window
function OXGUI.new(title)
    local self = setmetatable({}, OXGUI)
    
    -- Clean up existing GUI
    if PlayerGui:FindFirstChild("OXGUIMain") then
        PlayerGui.OXGUIMain:Destroy()
    end
    
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "OXGUIMain"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.Parent = PlayerGui
    
    -- Create Main Frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Parent = self.ScreenGui
    self.MainFrame.Size = UDim2.new(0, 550, 0, 400)
    self.MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
    self.MainFrame.BackgroundColor3 = Colors.Background
    self.MainFrame.BorderSizePixel = 0
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = self.MainFrame
    
    -- Add drop shadow effect
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Parent = self.MainFrame
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.ZIndex = -1
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 16)
    shadowCorner.Parent = shadow
    
    -- Create Title Bar
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Parent = self.MainFrame
    self.TitleBar.Size = UDim2.new(1, 0, 0, 50)
    self.TitleBar.BackgroundColor3 = Colors.Surface
    self.TitleBar.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = self.TitleBar
    
    -- Title Text
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "TitleLabel"
    self.TitleLabel.Parent = self.TitleBar
    self.TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = title or "OXGUI"
    self.TitleLabel.TextColor3 = Colors.Text
    self.TitleLabel.TextSize = 18
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Parent = self.TitleBar
    self.CloseButton.Size = UDim2.new(0, 30, 0, 30)
    self.CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
    self.CloseButton.BackgroundColor3 = Colors.Error
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Colors.Text
    self.CloseButton.TextSize = 20
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.BorderSizePixel = 0
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = self.CloseButton
    
    -- Content Frame
    self.ContentFrame = Instance.new("Frame")
    self.ContentFrame.Name = "ContentFrame"
    self.ContentFrame.Parent = self.MainFrame
    self.ContentFrame.Size = UDim2.new(1, -20, 1, -70)
    self.ContentFrame.Position = UDim2.new(0, 10, 0, 60)
    self.ContentFrame.BackgroundTransparency = 1
    
    -- Tab System
    self.tabs = {}
    self.currentTab = nil
    
    -- Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Parent = self.ContentFrame
    self.TabContainer.Size = UDim2.new(1, 0, 0, 40)
    self.TabContainer.BackgroundTransparency = 1
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = self.TabContainer
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    
    -- Tab Content Container
    self.TabContentContainer = Instance.new("Frame")
    self.TabContentContainer.Name = "TabContentContainer"
    self.TabContentContainer.Parent = self.ContentFrame
    self.TabContentContainer.Size = UDim2.new(1, 0, 1, -50)
    self.TabContentContainer.Position = UDim2.new(0, 0, 0, 50)
    self.TabContentContainer.BackgroundTransparency = 1
    
    -- Make draggable
    self:MakeDraggable()
    
    -- Close button functionality
    self.CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(self.MainFrame, quickTween, {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.15)
        self.ScreenGui:Destroy()
    end)
    
    -- Hover effects for close button
    self.CloseButton.MouseEnter:Connect(function()
        TweenService:Create(self.CloseButton, quickTween, {BackgroundColor3 = Color3.fromRGB(255, 60, 80)}):Play()
    end)
    
    self.CloseButton.MouseLeave:Connect(function()
        TweenService:Create(self.CloseButton, quickTween, {BackgroundColor3 = Colors.Error}):Play()
    end)
    
    -- Entrance animation
    self.MainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(self.MainFrame, tweenInfo, {Size = UDim2.new(0, 550, 0, 400)}):Play()
    
    return self
end

-- Make GUI Draggable
function OXGUI:MakeDraggable()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            self.MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Create Tab
function OXGUI:CreateTab(name)
    local tab = {}
    tab.name = name
    tab.elements = {}
    
    -- Tab Button
    tab.button = Instance.new("TextButton")
    tab.button.Name = name .. "Tab"
    tab.button.Parent = self.TabContainer
    tab.button.Size = UDim2.new(0, 120, 1, 0)
    tab.button.BackgroundColor3 = Colors.Secondary
    tab.button.Text = name
    tab.button.TextColor3 = Colors.TextSecondary
    tab.button.TextSize = 14
    tab.button.Font = Enum.Font.Gotham
    tab.button.BorderSizePixel = 0
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab.button
    
    -- Tab Content Frame
    tab.content = Instance.new("ScrollingFrame")
    tab.content.Name = name .. "Content"
    tab.content.Parent = self.TabContentContainer
    tab.content.Size = UDim2.new(1, 0, 1, 0)
    tab.content.BackgroundColor3 = Colors.Surface
    tab.content.BorderSizePixel = 0
    tab.content.ScrollBarThickness = 6
    tab.content.ScrollBarImageColor3 = Colors.Primary
    tab.content.CanvasSize = UDim2.new(0, 0, 0, 0)
    tab.content.Visible = false
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = tab.content
    
    -- Content Layout
    tab.layout = Instance.new("UIListLayout")
    tab.layout.Parent = tab.content
    tab.layout.SortOrder = Enum.SortOrder.LayoutOrder
    tab.layout.Padding = UDim.new(0, 8)
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.Parent = tab.content
    contentPadding.PaddingTop = UDim.new(0, 10)
    contentPadding.PaddingBottom = UDim.new(0, 10)
    contentPadding.PaddingLeft = UDim.new(0, 10)
    contentPadding.PaddingRight = UDim.new(0, 10)
    
    -- Tab Click Event
    tab.button.MouseButton1Click:Connect(function()
        self:SwitchTab(tab)
    end)
    
    -- Hover effects
    tab.button.MouseEnter:Connect(function()
        if self.currentTab ~= tab then
            TweenService:Create(tab.button, quickTween, {BackgroundColor3 = Colors.Primary}):Play()
            TweenService:Create(tab.button, quickTween, {TextColor3 = Colors.Text}):Play()
        end
    end)
    
    tab.button.MouseLeave:Connect(function()
        if self.currentTab ~= tab then
            TweenService:Create(tab.button, quickTween, {BackgroundColor3 = Colors.Secondary}):Play()
            TweenService:Create(tab.button, quickTween, {TextColor3 = Colors.TextSecondary}):Play()
        end
    end)
    
    -- Update canvas size when content changes
    tab.layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tab.content.CanvasSize = UDim2.new(0, 0, 0, tab.layout.AbsoluteContentSize.Y + 20)
    end)
    
    self.tabs[name] = tab
    
    -- Auto-select first tab
    if #self.tabs == 1 then
        self:SwitchTab(tab)
    end
    
    return tab
end

-- Switch Tab
function OXGUI:SwitchTab(tab)
    -- Hide all tabs
    for _, t in pairs(self.tabs) do
        t.content.Visible = false
        TweenService:Create(t.button, quickTween, {BackgroundColor3 = Colors.Secondary}):Play()
        TweenService:Create(t.button, quickTween, {TextColor3 = Colors.TextSecondary}):Play()
    end
    
    -- Show selected tab
    tab.content.Visible = true
    self.currentTab = tab
    TweenService:Create(tab.button, quickTween, {BackgroundColor3 = Colors.Primary}):Play()
    TweenService:Create(tab.button, quickTween, {TextColor3 = Colors.Text}):Play()
end

-- Create Toggle Button
function OXGUI:CreateToggle(tab, text, defaultValue, callback)
    local toggle = {}
    toggle.value = defaultValue or false
    toggle.callback = callback
    
    -- Toggle Container
    toggle.container = Instance.new("Frame")
    toggle.container.Name = "ToggleContainer"
    toggle.container.Parent = tab.content
    toggle.container.Size = UDim2.new(1, 0, 0, 45)
    toggle.container.BackgroundColor3 = Colors.Background
    toggle.container.BorderSizePixel = 0
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggle.container
    
    -- Toggle Label
    toggle.label = Instance.new("TextLabel")
    toggle.label.Name = "ToggleLabel"
    toggle.label.Parent = toggle.container
    toggle.label.Size = UDim2.new(1, -80, 1, 0)
    toggle.label.Position = UDim2.new(0, 15, 0, 0)
    toggle.label.BackgroundTransparency = 1
    toggle.label.Text = text
    toggle.label.TextColor3 = Colors.Text
    toggle.label.TextSize = 14
    toggle.label.Font = Enum.Font.Gotham
    toggle.label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Toggle Switch Background
    toggle.switchBg = Instance.new("Frame")
    toggle.switchBg.Name = "SwitchBackground"
    toggle.switchBg.Parent = toggle.container
    toggle.switchBg.Size = UDim2.new(0, 50, 0, 25)
    toggle.switchBg.Position = UDim2.new(1, -65, 0.5, -12.5)
    toggle.switchBg.BackgroundColor3 = toggle.value and Colors.Success or Colors.Secondary
    toggle.switchBg.BorderSizePixel = 0
    
    local switchBgCorner = Instance.new("UICorner")
    switchBgCorner.CornerRadius = UDim.new(0, 12.5)
    switchBgCorner.Parent = toggle.switchBg
    
    -- Toggle Switch Circle
    toggle.switchCircle = Instance.new("Frame")
    toggle.switchCircle.Name = "SwitchCircle"
    toggle.switchCircle.Parent = toggle.switchBg
    toggle.switchCircle.Size = UDim2.new(0, 21, 0, 21)
    toggle.switchCircle.Position = toggle.value and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
    toggle.switchCircle.BackgroundColor3 = Colors.Text
    toggle.switchCircle.BorderSizePixel = 0
    
    local switchCircleCorner = Instance.new("UICorner")
    switchCircleCorner.CornerRadius = UDim.new(0, 10.5)
    switchCircleCorner.Parent = toggle.switchCircle
    
    -- Toggle Function
    function toggle:Toggle()
        self.value = not self.value
        
        -- Animate switch
        TweenService:Create(self.switchBg, quickTween, {
            BackgroundColor3 = self.value and Colors.Success or Colors.Secondary
        }):Play()
        
        TweenService:Create(self.switchCircle, quickTween, {
            Position = self.value and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
        }):Play()
        
        if self.callback then
            self.callback(self.value)
        end
    end
    
    -- Click Event
    local clickable = Instance.new("TextButton")
    clickable.Parent = toggle.container
    clickable.Size = UDim2.new(1, 0, 1, 0)
    clickable.BackgroundTransparency = 1
    clickable.Text = ""
    
    clickable.MouseButton1Click:Connect(function()
        toggle:Toggle()
    end)
    
    -- Hover Effects
    clickable.MouseEnter:Connect(function()
        TweenService:Create(toggle.container, quickTween, {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
    end)
    
    clickable.MouseLeave:Connect(function()
        TweenService:Create(toggle.container, quickTween, {BackgroundColor3 = Colors.Background}):Play()
    end)
    
    return toggle
end

-- Create Button
function OXGUI:CreateButton(tab, text, callback)
    local button = {}
    button.callback = callback
    
    -- Button Frame
    button.frame = Instance.new("TextButton")
    button.frame.Name = "Button"
    button.frame.Parent = tab.content
    button.frame.Size = UDim2.new(1, 0, 0, 40)
    button.frame.BackgroundColor3 = Colors.Primary
    button.frame.Text = text
    button.frame.TextColor3 = Colors.Text
    button.frame.TextSize = 14
    button.frame.Font = Enum.Font.GothamMedium
    button.frame.BorderSizePixel = 0
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button.frame
    
    -- Click Event
    button.frame.MouseButton1Click:Connect(function()
        if button.callback then
            button.callback()
        end
        
        -- Click animation
        local originalSize = button.frame.Size
        TweenService:Create(button.frame, TweenInfo.new(0.1), {Size = UDim2.new(1, -4, 0, 38)}):Play()
        wait(0.1)
        TweenService:Create(button.frame, TweenInfo.new(0.1), {Size = originalSize}):Play()
    end)
    
    -- Hover Effects
    button.frame.MouseEnter:Connect(function()
        TweenService:Create(button.frame, quickTween, {BackgroundColor3 = Colors.Accent}):Play()
    end)
    
    button.frame.MouseLeave:Connect(function()
        TweenService:Create(button.frame, quickTween, {BackgroundColor3 = Colors.Primary}):Play()
    end)
    
    return button
end

-- Create Label
function OXGUI:CreateLabel(tab, text)
    local label = {}
    
    label.frame = Instance.new("TextLabel")
    label.frame.Name = "Label"
    label.frame.Parent = tab.content
    label.frame.Size = UDim2.new(1, 0, 0, 30)
    label.frame.BackgroundTransparency = 1
    label.frame.Text = text
    label.frame.TextColor3 = Colors.TextSecondary
    label.frame.TextSize = 13
    label.frame.Font = Enum.Font.Gotham
    label.frame.TextXAlignment = Enum.TextXAlignment.Left
    
    function label:SetText(newText)
        self.frame.Text = newText
    end
    
    return label
end

-- Notification System
function OXGUI:Notify(title, message, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Parent = self.ScreenGui
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(1, -320, 0, 20)
    notification.BackgroundColor3 = Colors.Surface
    notification.BorderSizePixel = 0
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notification
    
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Parent = notification
    notifTitle.Size = UDim2.new(1, -20, 0, 25)
    notifTitle.Position = UDim2.new(0, 10, 0, 5)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = title
    notifTitle.TextColor3 = Colors.Text
    notifTitle.TextSize = 14
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local notifMessage = Instance.new("TextLabel")
    notifMessage.Parent = notification
    notifMessage.Size = UDim2.new(1, -20, 0, 45)
    notifMessage.Position = UDim2.new(0, 10, 0, 25)
    notifMessage.BackgroundTransparency = 1
    notifMessage.Text = message
    notifMessage.TextColor3 = Colors.TextSecondary
    notifMessage.TextSize = 12
    notifMessage.Font = Enum.Font.Gotham
    notifMessage.TextXAlignment = Enum.TextXAlignment.Left
    notifMessage.TextWrapped = true
    
    -- Entrance animation
    notification.Position = UDim2.new(1, 0, 0, 20)
    TweenService:Create(notification, tweenInfo, {Position = UDim2.new(1, -320, 0, 20)}):Play()
    
    -- Auto remove
    wait(duration)
    TweenService:Create(notification, tweenInfo, {Position = UDim2.new(1, 0, 0, 20)}):Play()
    wait(0.3)
    notification:Destroy()
end

return OXGUI
