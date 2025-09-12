-- OXGUI Library v2.0 - Ultra Modern Edition
-- Premium GUI Library for Roblox with Advanced Animations & Modern Design
-- Created for https://raw.githubusercontent.com/tigerprettyboi/OXGUI/refs/heads/main/MAIN.lua

local OXGUI = {}
OXGUI.__index = OXGUI

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variables
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Advanced Tween Presets
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local quickTween = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local smoothTween = TweenInfo.new(0.6, Enum.EasingStyle.Expo, Enum.EasingDirection.Out)
local bounceIn = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Modern Color Palette (Glassmorphism Style)
local Colors = {
    Background = Color3.fromRGB(15, 15, 20),
    Surface = Color3.fromRGB(25, 25, 35),
    Glass = Color3.fromRGB(40, 40, 55),
    Primary = Color3.fromRGB(138, 43, 226),
    Secondary = Color3.fromRGB(50, 50, 70),
    Accent = Color3.fromRGB(255, 20, 147),
    Text = Color3.fromRGB(240, 240, 245),
    TextSecondary = Color3.fromRGB(180, 180, 190),
    Success = Color3.fromRGB(0, 255, 127),
    Warning = Color3.fromRGB(255, 165, 0),
    Error = Color3.fromRGB(255, 69, 96),
    Gradient1 = Color3.fromRGB(138, 43, 226),
    Gradient2 = Color3.fromRGB(255, 20, 147),
    Shadow = Color3.fromRGB(0, 0, 0)
}

-- Global UI Toggle State
local isUIVisible = true

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
    self.ScreenGui.IgnoreGuiInset = true
    self.ScreenGui.Parent = PlayerGui
    
    -- Create Blur Effect
    self.BlurFrame = Instance.new("Frame")
    self.BlurFrame.Name = "BlurFrame"
    self.BlurFrame.Parent = self.ScreenGui
    self.BlurFrame.Size = UDim2.new(1, 0, 1, 0)
    self.BlurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.BlurFrame.BackgroundTransparency = 0.4
    self.BlurFrame.BorderSizePixel = 0
    self.BlurFrame.ZIndex = 0
    
    -- Create Main Container with Glassmorphism
    self.MainContainer = Instance.new("Frame")
    self.MainContainer.Name = "MainContainer"
    self.MainContainer.Parent = self.ScreenGui
    self.MainContainer.Size = UDim2.new(0, 600, 0, 450)
    self.MainContainer.Position = UDim2.new(0.5, -300, 0.5, -225)
    self.MainContainer.BackgroundColor3 = Colors.Glass
    self.MainContainer.BackgroundTransparency = 0.1
    self.MainContainer.BorderSizePixel = 0
    self.MainContainer.ZIndex = 1
    
    -- Glass Effect Corner
    local glassCorner = Instance.new("UICorner")
    glassCorner.CornerRadius = UDim.new(0, 20)
    glassCorner.Parent = self.MainContainer
    
    -- Glass Stroke
    local glassStroke = Instance.new("UIStroke")
    glassStroke.Parent = self.MainContainer
    glassStroke.Color = Color3.fromRGB(100, 100, 120)
    glassStroke.Thickness = 1
    glassStroke.Transparency = 0.5
    
    -- Animated Background Gradient
    self.GradientFrame = Instance.new("Frame")
    self.GradientFrame.Name = "GradientFrame"
    self.GradientFrame.Parent = self.MainContainer
    self.GradientFrame.Size = UDim2.new(1, 0, 1, 0)
    self.GradientFrame.BackgroundTransparency = 0.7
    self.GradientFrame.BorderSizePixel = 0
    self.GradientFrame.ZIndex = -1
    
    local gradientCorner = Instance.new("UICorner")
    gradientCorner.CornerRadius = UDim.new(0, 20)
    gradientCorner.Parent = self.GradientFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Parent = self.GradientFrame
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Colors.Gradient1),
        ColorSequenceKeypoint.new(1, Colors.Gradient2)
    }
    gradient.Rotation = 45
    
    -- Animate gradient rotation
    spawn(function()
        while self.ScreenGui.Parent do
            for i = 0, 360, 2 do
                if not self.ScreenGui.Parent then break end
                gradient.Rotation = i
                wait(0.05)
            end
        end
    end)
    
    -- Advanced Shadow System
    for i = 1, 3 do
        local shadow = Instance.new("Frame")
        shadow.Name = "Shadow" .. i
        shadow.Parent = self.MainContainer
        shadow.Size = UDim2.new(1, i * 10, 1, i * 10)
        shadow.Position = UDim2.new(0, -i * 5, 0, -i * 5)
        shadow.BackgroundColor3 = Colors.Shadow
        shadow.BackgroundTransparency = 0.8 + (i * 0.05)
        shadow.ZIndex = -i - 1
        
        local shadowCorner = Instance.new("UICorner")
        shadowCorner.CornerRadius = UDim.new(0, 20 + i * 2)
        shadowCorner.Parent = shadow
    end
    
    -- Modern Title Bar with Gradient
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Parent = self.MainContainer
    self.TitleBar.Size = UDim2.new(1, 0, 0, 60)
    self.TitleBar.BackgroundColor3 = Colors.Surface
    self.TitleBar.BackgroundTransparency = 0.3
    self.TitleBar.BorderSizePixel = 0
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 20)
    titleCorner.Parent = self.TitleBar
    
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Parent = self.TitleBar
    titleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
    }
    titleGradient.Rotation = 90
    
    -- Glowing Title Text
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "TitleLabel"
    self.TitleLabel.Parent = self.TitleBar
    self.TitleLabel.Size = UDim2.new(1, -120, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 25, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = title or "OXGUI v2.0"
    self.TitleLabel.TextColor3 = Colors.Text
    self.TitleLabel.TextSize = 20
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Text glow effect
    local titleStroke = Instance.new("UIStroke")
    titleStroke.Parent = self.TitleLabel
    titleStroke.Color = Colors.Primary
    titleStroke.Thickness = 0.5
    titleStroke.Transparency = 0.3
    
    -- Minimize Button
    self.MinimizeButton = Instance.new("TextButton")
    self.MinimizeButton.Name = "MinimizeButton"
    self.MinimizeButton.Parent = self.TitleBar
    self.MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
    self.MinimizeButton.Position = UDim2.new(1, -85, 0.5, -17.5)
    self.MinimizeButton.BackgroundColor3 = Colors.Warning
    self.MinimizeButton.Text = "−"
    self.MinimizeButton.TextColor3 = Colors.Text
    self.MinimizeButton.TextSize = 18
    self.MinimizeButton.Font = Enum.Font.GothamBold
    self.MinimizeButton.BorderSizePixel = 0
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 8)
    minimizeCorner.Parent = self.MinimizeButton
    
    -- Close Button with Glow
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Parent = self.TitleBar
    self.CloseButton.Size = UDim2.new(0, 35, 0, 35)
    self.CloseButton.Position = UDim2.new(1, -45, 0.5, -17.5)
    self.CloseButton.BackgroundColor3 = Colors.Error
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Colors.Text
    self.CloseButton.TextSize = 22
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.BorderSizePixel = 0
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = self.CloseButton
    
    -- Button glow effects
    for _, button in pairs({self.MinimizeButton, self.CloseButton}) do
        local glow = Instance.new("UIStroke")
        glow.Parent = button
        glow.Color = button.BackgroundColor3
        glow.Thickness = 2
        glow.Transparency = 0.7
    end
    
    -- Content Container with Glass Effect
    self.ContentFrame = Instance.new("Frame")
    self.ContentFrame.Name = "ContentFrame"
    self.ContentFrame.Parent = self.MainContainer
    self.ContentFrame.Size = UDim2.new(1, -30, 1, -90)
    self.ContentFrame.Position = UDim2.new(0, 15, 0, 75)
    self.ContentFrame.BackgroundTransparency = 1
    
    -- Tab System
    self.tabs = {}
    self.currentTab = nil
    
    -- Modern Tab Container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Parent = self.ContentFrame
    self.TabContainer.Size = UDim2.new(1, 0, 0, 45)
    self.TabContainer.BackgroundColor3 = Colors.Surface
    self.TabContainer.BackgroundTransparency = 0.2
    self.TabContainer.BorderSizePixel = 0
    
    local tabContainerCorner = Instance.new("UICorner")
    tabContainerCorner.CornerRadius = UDim.new(0, 12)
    tabContainerCorner.Parent = self.TabContainer
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = self.TabContainer
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)
    
    local tabPadding = Instance.new("UIPadding")
    tabPadding.Parent = self.TabContainer
    tabPadding.PaddingTop = UDim.new(0, 8)
    tabPadding.PaddingBottom = UDim.new(0, 8)
    tabPadding.PaddingLeft = UDim.new(0, 8)
    tabPadding.PaddingRight = UDim.new(0, 8)
    
    -- Tab Content Container
    self.TabContentContainer = Instance.new("Frame")
    self.TabContentContainer.Name = "TabContentContainer"
    self.TabContentContainer.Parent = self.ContentFrame
    self.TabContentContainer.Size = UDim2.new(1, 0, 1, -60)
    self.TabContentContainer.Position = UDim2.new(0, 0, 0, 60)
    self.TabContentContainer.BackgroundTransparency = 1
    
    -- Make draggable with smooth animation
    self:MakeDraggable()
    
    -- Button Events with Advanced Animations
    self.CloseButton.MouseButton1Click:Connect(function()
        self:AnimateClose()
    end)
    
    self.MinimizeButton.MouseButton1Click:Connect(function()
        self:ToggleMinimize()
    end)
    
    -- Advanced Hover Effects
    self:SetupButtonHoverEffects()
    
    -- Spectacular Entrance Animation
    self:PlayEntranceAnimation()
    
    -- Setup Right Ctrl Toggle
    self:SetupToggleKey()
    
    return self
end

-- Setup Toggle Key (Right Ctrl)
function OXGUI:SetupToggleKey()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.RightControl then
            self:ToggleUI()
        end
    end)
end

-- Toggle UI Visibility
function OXGUI:ToggleUI()
    isUIVisible = not isUIVisible
    
    if isUIVisible then
        self.ScreenGui.Enabled = true
        self:PlayEntranceAnimation()
    else
        -- Smooth exit animation
        local exitTween = TweenService:Create(self.MainContainer, smoothTween, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        local blurTween = TweenService:Create(self.BlurFrame, smoothTween, {
            BackgroundTransparency = 1
        })
        
        exitTween:Play()
        blurTween:Play()
        
        exitTween.Completed:Connect(function()
            self.ScreenGui.Enabled = false
        end)
    end
end

-- Spectacular Entrance Animation
function OXGUI:PlayEntranceAnimation()
    -- Initial state
    self.MainContainer.Size = UDim2.new(0, 0, 0, 0)
    self.MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.BlurFrame.BackgroundTransparency = 1
    
    -- Animate blur background
    TweenService:Create(self.BlurFrame, smoothTween, {
        BackgroundTransparency = 0.4
    }):Play()
    
    -- Animate main container with bounce
    TweenService:Create(self.MainContainer, bounceIn, {
        Size = UDim2.new(0, 600, 0, 450),
        Position = UDim2.new(0.5, -300, 0.5, -225)
    }):Play()
    
    -- Animate title with glow pulse
    spawn(function()
        wait(0.3)
        local glowTween = TweenService:Create(self.TitleLabel:FindFirstChild("UIStroke"), TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Transparency = 0
        })
        glowTween:Play()
    end)
end

-- Advanced Button Hover Effects
function OXGUI:SetupButtonHoverEffects()
    local buttons = {
        {self.CloseButton, Colors.Error, Color3.fromRGB(255, 100, 130)},
        {self.MinimizeButton, Colors.Warning, Color3.fromRGB(255, 200, 120)}
    }
    
    for _, buttonData in pairs(buttons) do
        local button, originalColor, hoverColor = buttonData[1], buttonData[2], buttonData[3]
        
        button.MouseEnter:Connect(function()
            TweenService:Create(button, quickTween, {
                BackgroundColor3 = hoverColor,
                Size = UDim2.new(0, 38, 0, 38)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, quickTween, {
                BackgroundColor3 = originalColor,
                Size = UDim2.new(0, 35, 0, 35)
            }):Play()
        end)
    end
end

-- Enhanced Draggable System
function OXGUI:MakeDraggable()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.MainContainer.Position
            
            -- Visual feedback
            TweenService:Create(self.MainContainer, quickTween, {
                BackgroundTransparency = 0.05
            }):Play()
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            self.MainContainer.Position = UDim2.new(
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
            TweenService:Create(self.MainContainer, quickTween, {
                BackgroundTransparency = 0.1
            }):Play()
        end
    end)
end

-- Animated Close
function OXGUI:AnimateClose()
    local closeTween = TweenService:Create(self.MainContainer, smoothTween, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Rotation = 180
    })
    local blurTween = TweenService:Create(self.BlurFrame, smoothTween, {
        BackgroundTransparency = 1
    })
    
    closeTween:Play()
    blurTween:Play()
    
    closeTween.Completed:Connect(function()
        self.ScreenGui:Destroy()
    end)
end

-- Toggle Minimize
function OXGUI:ToggleMinimize()
    if self.MainContainer.Size == UDim2.new(0, 600, 0, 60) then
        -- Restore
        TweenService:Create(self.MainContainer, bounceIn, {
            Size = UDim2.new(0, 600, 0, 450)
        }):Play()
        self.MinimizeButton.Text = "−"
    else
        -- Minimize
        TweenService:Create(self.MainContainer, smoothTween, {
            Size = UDim2.new(0, 600, 0, 60)
        }):Play()
        self.MinimizeButton.Text = "□"
    end
end

-- Create Modern Tab
function OXGUI:CreateTab(name)
    local tab = {}
    tab.name = name
    tab.elements = {}
    
    -- Modern Tab Button with Glass Effect
    tab.button = Instance.new("TextButton")
    tab.button.Name = name .. "Tab"
    tab.button.Parent = self.TabContainer
    tab.button.Size = UDim2.new(0, 140, 1, 0)
    tab.button.BackgroundColor3 = Colors.Secondary
    tab.button.BackgroundTransparency = 0.3
    tab.button.Text = name
    tab.button.TextColor3 = Colors.TextSecondary
    tab.button.TextSize = 14
    tab.button.Font = Enum.Font.GothamMedium
    tab.button.BorderSizePixel = 0
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = tab.button
    
    local tabStroke = Instance.new("UIStroke")
    tabStroke.Parent = tab.button
    tabStroke.Color = Colors.Primary
    tabStroke.Thickness = 1
    tabStroke.Transparency = 0.8
    
    -- Tab Content with Glass Scrolling Frame
    tab.content = Instance.new("ScrollingFrame")
    tab.content.Name = name .. "Content"
    tab.content.Parent = self.TabContentContainer
    tab.content.Size = UDim2.new(1, 0, 1, 0)
    tab.content.BackgroundColor3 = Colors.Surface
    tab.content.BackgroundTransparency = 0.2
    tab.content.BorderSizePixel = 0
    tab.content.ScrollBarThickness = 8
    tab.content.ScrollBarImageColor3 = Colors.Primary
    tab.content.CanvasSize = UDim2.new(0, 0, 0, 0)
    tab.content.Visible = false
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 12)
    contentCorner.Parent = tab.content
    
    local contentStroke = Instance.new("UIStroke")
    contentStroke.Parent = tab.content
    contentStroke.Color = Color3.fromRGB(80, 80, 100)
    contentStroke.Thickness = 1
    contentStroke.Transparency = 0.6
    
    -- Content Layout
    tab.layout = Instance.new("UIListLayout")
    tab.layout.Parent = tab.content
    tab.layout.SortOrder = Enum.SortOrder.LayoutOrder
    tab.layout.Padding = UDim.new(0, 10)
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.Parent = tab.content
    contentPadding.PaddingTop = UDim.new(0, 15)
    contentPadding.PaddingBottom = UDim.new(0, 15)
    contentPadding.PaddingLeft = UDim.new(0, 15)
    contentPadding.PaddingRight = UDim.new(0, 15)
    
    -- Enhanced Tab Click Event
    tab.button.MouseButton1Click:Connect(function()
        self:SwitchTab(tab)
    end)
    
    -- Advanced Hover Effects
    tab.button.MouseEnter:Connect(function()
        if self.currentTab ~= tab then
            TweenService:Create(tab.button, quickTween, {
                BackgroundTransparency = 0.1,
                Size = UDim2.new(0, 145, 1, 2)
            }):Play()
            TweenService:Create(tab.button:FindFirstChild("UIStroke"), quickTween, {
                Transparency = 0.3
            }):Play()
        end
    end)
    
    tab.button.MouseLeave:Connect(function()
        if self.currentTab ~= tab then
            TweenService:Create(tab.button, quickTween, {
                BackgroundTransparency = 0.3,
                Size = UDim2.new(0, 140, 1, 0)
            }):Play()
            TweenService:Create(tab.button:FindFirstChild("UIStroke"), quickTween, {
                Transparency = 0.8
            }):Play()
        end
    end)
    
    -- Update canvas size
    tab.layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tab.content.CanvasSize = UDim2.new(0, 0, 0, tab.layout.AbsoluteContentSize.Y + 30)
    end)
    
    self.tabs[name] = tab
    
    -- Auto-select first tab
    if #self.tabs == 1 then
        self:SwitchTab(tab)
    end
    
    return tab
end

-- Enhanced Tab Switching
function OXGUI:SwitchTab(tab)
    -- Animate out all tabs
    for _, t in pairs(self.tabs) do
        t.content.Visible = false
        TweenService:Create(t.button, quickTween, {
            BackgroundTransparency = 0.3,
            TextColor3 = Colors.TextSecondary
        }):Play()
        TweenService:Create(t.button:FindFirstChild("UIStroke"), quickTween, {
            Transparency = 0.8
        }):Play()
    end
    
    -- Animate in selected tab
    tab.content.Visible = true
    self.currentTab = tab
    TweenService:Create(tab.button, quickTween, {
        BackgroundTransparency = 0,
        TextColor3 = Colors.Text
    }):Play()
    TweenService:Create(tab.button:FindFirstChild("UIStroke"), quickTween, {
        Transparency = 0.2
    }):Play()
end

-- Ultra Modern Toggle Button
function OXGUI:CreateToggle(tab, text, defaultValue, callback)
    local toggle = {}
    toggle.value = defaultValue or false
    toggle.callback = callback
    
    -- Modern Toggle Container with Glass Effect
    toggle.container = Instance.new("Frame")
    toggle.container.Name = "ToggleContainer"
    toggle.container.Parent = tab.content
    toggle.container.Size = UDim2.new(1, 0, 0, 55)
    toggle.container.BackgroundColor3 = Colors.Glass
    toggle.container.BackgroundTransparency = 0.2
    toggle.container.BorderSizePixel = 0
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggle.container
    
    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Parent = toggle.container
    toggleStroke.Color = toggle.value and Colors.Success or Colors.Secondary
    toggleStroke.Thickness = 1.5
    toggleStroke.Transparency = 0.4
    
    -- Gradient Background
    local toggleGradient = Instance.new("UIGradient")
    toggleGradient.Parent = toggle.container
    toggleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
    }
    toggleGradient.Rotation = 90
    
    -- Modern Toggle Label
    toggle.label = Instance.new("TextLabel")
    toggle.label.Name = "ToggleLabel"
    toggle.label.Parent = toggle.container
    toggle.label.Size = UDim2.new(1, -120, 1, 0)
    toggle.label.Position = UDim2.new(0, 20, 0, 0)
    toggle.label.BackgroundTransparency = 1
    toggle.label.Text = text
    toggle.label.TextColor3 = Colors.Text
    toggle.label.TextSize = 15
    toggle.label.Font = Enum.Font.GothamMedium
    toggle.label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Ultra Modern Switch Circle with Gradient
    toggle.switchCircle = Instance.new("Frame")
    toggle.switchCircle.Name = "SwitchCircle"
    toggle.switchCircle.Parent = toggle.switchBg
    toggle.switchCircle.Size = UDim2.new(0, 26, 0, 26)
    toggle.switchCircle.Position = toggle.value and UDim2.new(1, -28, 0.5, -13) or UDim2.new(0, 2, 0.5, -13)
    toggle.switchCircle.BackgroundColor3 = Colors.Text
    toggle.switchCircle.BorderSizePixel = 0
    
    local switchCircleCorner = Instance.new("UICorner")
    switchCircleCorner.CornerRadius = UDim.new(0, 13)
    switchCircleCorner.Parent = toggle.switchCircle
    
    local circleGradient = Instance.new("UIGradient")
    circleGradient.Parent = toggle.switchCircle
    circleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 230, 240))
    }
    circleGradient.Rotation = 45
    
    -- Circle shadow
    local circleShadow = Instance.new("UIStroke")
    circleShadow.Parent = toggle.switchCircle
    circleShadow.Color = Color3.fromRGB(0, 0, 0)
    circleShadow.Thickness = 1
    circleShadow.Transparency = 0.8
    
    -- Toggle Function with Advanced Animation
    function toggle:Toggle()
        self.value = not self.value
        
        -- Animate switch background
        TweenService:Create(self.switchBg, smoothTween, {
            BackgroundColor3 = self.value and Colors.Success or Colors.Secondary
        }):Play()
        
        TweenService:Create(switchGlow, smoothTween, {
            Color = self.value and Colors.Success or Colors.Secondary
        }):Play()
        
        TweenService:Create(toggleStroke, smoothTween, {
            Color = self.value and Colors.Success or Colors.Secondary
        }):Play()
        
        -- Animate switch circle with bounce
        TweenService:Create(self.switchCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = self.value and UDim2.new(1, -28, 0.5, -13) or UDim2.new(0, 2, 0.5, -13)
        }):Play()
        
        -- Pulse effect on toggle
        local pulseTween = TweenService:Create(self.container, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
            Size = UDim2.new(1, 4, 0, 57)
        })
        pulseTween:Play()
        
        if self.callback then
            self.callback(self.value)
        end
    end
    
    -- Enhanced Click Event
    local clickable = Instance.new("TextButton")
    clickable.Parent = toggle.container
    clickable.Size = UDim2.new(1, 0, 1, 0)
    clickable.BackgroundTransparency = 1
    clickable.Text = ""
    
    clickable.MouseButton1Click:Connect(function()
        toggle:Toggle()
    end)
    
    -- Premium Hover Effects
    clickable.MouseEnter:Connect(function()
        TweenService:Create(toggle.container, quickTween, {
            BackgroundTransparency = 0.1,
            Size = UDim2.new(1, 2, 0, 57)
        }):Play()
        TweenService:Create(toggleStroke, quickTween, {
            Transparency = 0.2
        }):Play()
    end)
    
    clickable.MouseLeave:Connect(function()
        TweenService:Create(toggle.container, quickTween, {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(1, 0, 0, 55)
        }):Play()
        TweenService:Create(toggleStroke, quickTween, {
            Transparency = 0.4
        }):Play()
    end)
    
    return toggle
end

-- Ultra Modern Button with Gradient
function OXGUI:CreateButton(tab, text, callback)
    local button = {}
    button.callback = callback
    
    -- Premium Button Container
    button.container = Instance.new("Frame")
    button.container.Name = "ButtonContainer"
    button.container.Parent = tab.content
    button.container.Size = UDim2.new(1, 0, 0, 50)
    button.container.BackgroundTransparency = 1
    
    -- Modern Button Frame with Gradient
    button.frame = Instance.new("TextButton")
    button.frame.Name = "Button"
    button.frame.Parent = button.container
    button.frame.Size = UDim2.new(1, 0, 1, 0)
    button.frame.BackgroundColor3 = Colors.Primary
    button.frame.Text = text
    button.frame.TextColor3 = Colors.Text
    button.frame.TextSize = 15
    button.frame.Font = Enum.Font.GothamBold
    button.frame.BorderSizePixel = 0
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = button.frame
    
    -- Button Gradient
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Parent = button.frame
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Colors.Primary),
        ColorSequenceKeypoint.new(1, Colors.Accent)
    }
    buttonGradient.Rotation = 45
    
    -- Button Glow
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Parent = button.frame
    buttonStroke.Color = Colors.Primary
    buttonStroke.Thickness = 2
    buttonStroke.Transparency = 0.5
    
    -- Animate gradient rotation
    spawn(function()
        while button.frame.Parent do
            for i = 0, 360, 5 do
                if not button.frame.Parent then break end
                buttonGradient.Rotation = i
                wait(0.05)
            end
        end
    end)
    
    -- Enhanced Click Event with Ripple Effect
    button.frame.MouseButton1Click:Connect(function()
        if button.callback then
            button.callback()
        end
        
        -- Create ripple effect
        local ripple = Instance.new("Frame")
        ripple.Name = "Ripple"
        ripple.Parent = button.frame
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.BackgroundColor3 = Colors.Text
        ripple.BackgroundTransparency = 0.7
        ripple.BorderSizePixel = 0
        
        local rippleCorner = Instance.new("UICorner")
        rippleCorner.CornerRadius = UDim.new(1, 0)
        rippleCorner.Parent = ripple
        
        -- Animate ripple
        local rippleTween = TweenService:Create(ripple, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(2, 0, 2, 0),
            Position = UDim2.new(-0.5, 0, -0.5, 0),
            BackgroundTransparency = 1
        })
        
        rippleTween:Play()
        rippleTween.Completed:Connect(function()
            ripple:Destroy()
        end)
        
        -- Button press animation
        TweenService:Create(button.frame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
            Size = UDim2.new(1, -4, 1, -4),
            Position = UDim2.new(0, 2, 0, 2)
        }):Play()
    end)
    
    -- Premium Hover Effects
    button.frame.MouseEnter:Connect(function()
        TweenService:Create(button.frame, quickTween, {
            Size = UDim2.new(1, 4, 1, 4),
            Position = UDim2.new(0, -2, 0, -2)
        }):Play()
        TweenService:Create(buttonStroke, quickTween, {
            Transparency = 0.2,
            Thickness = 3
        }):Play()
    end)
    
    button.frame.MouseLeave:Connect(function()
        TweenService:Create(button.frame, quickTween, {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        TweenService:Create(buttonStroke, quickTween, {
            Transparency = 0.5,
            Thickness = 2
        }):Play()
    end)
    
    return button
end

-- Modern Label with Glow Effect
function OXGUI:CreateLabel(tab, text)
    local label = {}
    
    label.container = Instance.new("Frame")
    label.container.Name = "LabelContainer"
    label.container.Parent = tab.content
    label.container.Size = UDim2.new(1, 0, 0, 35)
    label.container.BackgroundTransparency = 1
    
    label.frame = Instance.new("TextLabel")
    label.frame.Name = "Label"
    label.frame.Parent = label.container
    label.frame.Size = UDim2.new(1, 0, 1, 0)
    label.frame.BackgroundTransparency = 1
    label.frame.Text = text
    label.frame.TextColor3 = Colors.TextSecondary
    label.frame.TextSize = 14
    label.frame.Font = Enum.Font.Gotham
    label.frame.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Subtle text glow
    local labelStroke = Instance.new("UIStroke")
    labelStroke.Parent = label.frame
    labelStroke.Color = Colors.Primary
    labelStroke.Thickness = 0.5
    labelStroke.Transparency = 0.8
    
    function label:SetText(newText)
        self.frame.Text = newText
    end
    
    return label
end

-- Create Modern Slider
function OXGUI:CreateSlider(tab, text, min, max, defaultValue, callback)
    local slider = {}
    slider.min = min or 0
    slider.max = max or 100
    slider.value = defaultValue or min or 0
    slider.callback = callback
    
    -- Slider Container
    slider.container = Instance.new("Frame")
    slider.container.Name = "SliderContainer"
    slider.container.Parent = tab.content
    slider.container.Size = UDim2.new(1, 0, 0, 70)
    slider.container.BackgroundColor3 = Colors.Glass
    slider.container.BackgroundTransparency = 0.2
    slider.container.BorderSizePixel = 0
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 12)
    sliderCorner.Parent = slider.container
    
    local sliderStroke = Instance.new("UIStroke")
    sliderStroke.Parent = slider.container
    sliderStroke.Color = Colors.Primary
    sliderStroke.Thickness = 1
    sliderStroke.Transparency = 0.6
    
    -- Slider Label
    slider.label = Instance.new("TextLabel")
    slider.label.Name = "SliderLabel"
    slider.label.Parent = slider.container
    slider.label.Size = UDim2.new(1, -40, 0, 25)
    slider.label.Position = UDim2.new(0, 20, 0, 5)
    slider.label.BackgroundTransparency = 1
    slider.label.Text = text
    slider.label.TextColor3 = Colors.Text
    slider.label.TextSize = 14
    slider.label.Font = Enum.Font.GothamMedium
    slider.label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Value Label
    slider.valueLabel = Instance.new("TextLabel")
    slider.valueLabel.Name = "ValueLabel"
    slider.valueLabel.Parent = slider.container
    slider.valueLabel.Size = UDim2.new(0, 60, 0, 25)
    slider.valueLabel.Position = UDim2.new(1, -70, 0, 5)
    slider.valueLabel.BackgroundTransparency = 1
    slider.valueLabel.Text = tostring(slider.value)
    slider.valueLabel.TextColor3 = Colors.Accent
    slider.valueLabel.TextSize = 13
    slider.valueLabel.Font = Enum.Font.GothamBold
    slider.valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    -- Slider Track
    slider.track = Instance.new("Frame")
    slider.track.Name = "SliderTrack"
    slider.track.Parent = slider.container
    slider.track.Size = UDim2.new(1, -40, 0, 6)
    slider.track.Position = UDim2.new(0, 20, 0, 40)
    slider.track.BackgroundColor3 = Colors.Secondary
    slider.track.BorderSizePixel = 0
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 3)
    trackCorner.Parent = slider.track
    
    -- Slider Fill
    slider.fill = Instance.new("Frame")
    slider.fill.Name = "SliderFill"
    slider.fill.Parent = slider.track
    slider.fill.Size = UDim2.new((slider.value - slider.min) / (slider.max - slider.min), 0, 1, 0)
    slider.fill.BackgroundColor3 = Colors.Primary
    slider.fill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = slider.fill
    
    -- Slider Thumb
    slider.thumb = Instance.new("Frame")
    slider.thumb.Name = "SliderThumb"
    slider.thumb.Parent = slider.track
    slider.thumb.Size = UDim2.new(0, 16, 0, 16)
    slider.thumb.Position = UDim2.new((slider.value - slider.min) / (slider.max - slider.min), -8, 0.5, -8)
    slider.thumb.BackgroundColor3 = Colors.Text
    slider.thumb.BorderSizePixel = 0
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(0, 8)
    thumbCorner.Parent = slider.thumb
    
    local thumbStroke = Instance.new("UIStroke")
    thumbStroke.Parent = slider.thumb
    thumbStroke.Color = Colors.Primary
    thumbStroke.Thickness = 2
    thumbStroke.Transparency = 0.3
    
    -- Slider Functionality
    local dragging = false
    
    function slider:UpdateValue(newValue)
        self.value = math.clamp(newValue, self.min, self.max)
        local percentage = (self.value - self.min) / (self.max - self.min)
        
        TweenService:Create(self.fill, quickTween, {
            Size = UDim2.new(percentage, 0, 1, 0)
        }):Play()
        
        TweenService:Create(self.thumb, quickTween, {
            Position = UDim2.new(percentage, -8, 0.5, -8)
        }):Play()
        
        self.valueLabel.Text = tostring(math.round(self.value))
        
        if self.callback then
            self.callback(self.value)
        end
    end
    
    slider.track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local percentage = (input.Position.X - slider.track.AbsolutePosition.X) / slider.track.AbsoluteSize.X
            slider:UpdateValue(slider.min + percentage * (slider.max - slider.min))
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local percentage = (input.Position.X - slider.track.AbsolutePosition.X) / slider.track.AbsoluteSize.X
            slider:UpdateValue(slider.min + percentage * (slider.max - slider.min))
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return slider
end

-- Advanced Notification System with Multiple Styles
function OXGUI:Notify(title, message, duration, notificationType)
    duration = duration or 4
    notificationType = notificationType or "info"
    
    local notificationColors = {
        info = {Colors.Primary, Colors.Accent},
        success = {Colors.Success, Color3.fromRGB(120, 255, 150)},
        warning = {Colors.Warning, Color3.fromRGB(255, 200, 120)},
        error = {Colors.Error, Color3.fromRGB(255, 120, 150)}
    }
    
    local colors = notificationColors[notificationType] or notificationColors.info
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Parent = self.ScreenGui
    notification.Size = UDim2.new(0, 350, 0, 90)
    notification.Position = UDim2.new(1, -370, 0, 30)
    notification.BackgroundColor3 = Colors.Surface
    notification.BackgroundTransparency = 0.1
    notification.BorderSizePixel = 0
    notification.ZIndex = 1000
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 12)
    notifCorner.Parent = notification
    
    local notifStroke = Instance.new("UIStroke")
    notifStroke.Parent = notification
    notifStroke.Color = colors[1]
    notifStroke.Thickness = 2
    notifStroke.Transparency = 0.3
    
    -- Notification Gradient
    local notifGradient = Instance.new("UIGradient")
    notifGradient.Parent = notification
    notifGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, colors[1]),
        ColorSequenceKeypoint.new(1, colors[2])
    }
    notifGradient.Rotation = 45
    notifGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(1, 0.9)
    }
    
    -- Title with glow
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Parent = notification
    notifTitle.Size = UDim2.new(1, -30, 0, 30)
    notifTitle.Position = UDim2.new(0, 15, 0, 10)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = title
    notifTitle.TextColor3 = Colors.Text
    notifTitle.TextSize = 16
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local titleStroke = Instance.new("UIStroke")
    titleStroke.Parent = notifTitle
    titleStroke.Color = colors[1]
    titleStroke.Thickness = 1
    titleStroke.Transparency = 0.5
    
    -- Message
    local notifMessage = Instance.new("TextLabel")
    notifMessage.Parent = notification
    notifMessage.Size = UDim2.new(1, -30, 0, 40)
    notifMessage.Position = UDim2.new(0, 15, 0, 35)
    notifMessage.BackgroundTransparency = 1
    notifMessage.Text = message
    notifMessage.TextColor3 = Colors.TextSecondary
    notifMessage.TextSize = 13
    notifMessage.Font = Enum.Font.Gotham
    notifMessage.TextXAlignment = Enum.TextXAlignment.Left
    notifMessage.TextWrapped = true
    
    -- Progress Bar
    local progressBg = Instance.new("Frame")
    progressBg.Parent = notification
    progressBg.Size = UDim2.new(1, 0, 0, 3)
    progressBg.Position = UDim2.new(0, 0, 1, -3)
    progressBg.BackgroundColor3 = Colors.Secondary
    progressBg.BorderSizePixel = 0
    
    local progressFill = Instance.new("Frame")
    progressFill.Parent = progressBg
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    progressFill.BackgroundColor3 = colors[1]
    progressFill.BorderSizePixel = 0
    
    -- Entrance animation with bounce
    notification.Position = UDim2.new(1, 0, 0, 30)
    TweenService:Create(notification, bounceIn, {
        Position = UDim2.new(1, -370, 0, 30)
    }):Play()
    
    -- Progress animation
    TweenService:Create(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 1, 0)
    }):Play()
    
    -- Auto remove with smooth exit
    spawn(function()
        wait(duration)
        local exitTween = TweenService:Create(notification, smoothTween, {
            Position = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1
        })
        exitTween:Play()
        exitTween.Completed:Connect(function()
            notification:Destroy()
        end)
    end)
end

return OXGUI Switch Background
    toggle.switchBg = Instance.new("Frame")
    toggle.switchBg.Name = "SwitchBackground"
    toggle.switchBg.Parent = toggle.container
    toggle.switchBg.Size = UDim2.new(0, 60, 0, 30)
    toggle.switchBg.Position = UDim2.new(1, -80, 0.5, -15)
    toggle.switchBg.BackgroundColor3 = toggle.value and Colors.Success or Colors.Secondary
    toggle.switchBg.BorderSizePixel = 0
    
    local switchBgCorner = Instance.new("UICorner")
    switchBgCorner.CornerRadius = UDim.new(0, 15)
    switchBgCorner.Parent = toggle.switchBg
    
    -- Switch glow effect
    local switchGlow = Instance.new("UIStroke")
    switchGlow.Parent = toggle.switchBg
    switchGlow.Color = toggle.value and Colors.Success or Colors.Secondary
    switchGlow.Thickness = 2
    switchGlow.Transparency = 0.6
    
    -- Ultra Modern
