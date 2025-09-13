-- OXGUI - Modern GUI Library for Roblox
-- Created with sleek dark transparent design

local OXGUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Theme Configuration
local Theme = {
    Primary = Color3.fromRGB(15, 15, 15),
    Secondary = Color3.fromRGB(25, 25, 25),
    Accent = Color3.fromRGB(100, 255, 150),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 180),
    Border = Color3.fromRGB(40, 40, 40),
    Hover = Color3.fromRGB(35, 35, 35),
    Transparency = 0.1
}

-- Animation Settings
local AnimationSpeed = 0.3
local EasingStyle = Enum.EasingStyle.Quart
local EasingDirection = Enum.EasingDirection.Out

-- Utility Functions
local function CreateTween(object, properties, duration)
    duration = duration or AnimationSpeed
    local tweenInfo = TweenInfo.new(duration, EasingStyle, EasingDirection)
    local tween = TweenService:Create(object, tweenInfo, properties)
    return tween
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.5
    stroke.Parent = parent
    return stroke
end

local function CreateShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent.Parent
    return shadow
end

-- Main Library
function OXGUI:CreateWindow(config)
    config = config or {}
    local windowName = config.Name or "OXGUI Window"
    local windowSize = config.Size or UDim2.new(0, 500, 0, 400)
    
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "OXGUI_" .. windowName
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = PlayerGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = windowSize
    mainFrame.Position = UDim2.new(0.5, -windowSize.X.Offset/2, 0.5, -windowSize.Y.Offset/2)
    mainFrame.BackgroundColor3 = Theme.Primary
    mainFrame.BackgroundTransparency = Theme.Transparency
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    CreateCorner(mainFrame, 12)
    CreateStroke(mainFrame, Theme.Border, 1)
    CreateShadow(mainFrame)
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Theme.Secondary
    titleBar.BackgroundTransparency = Theme.Transparency
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    CreateCorner(titleBar, 12)
    
    -- Title Text
    local titleText = Instance.new("TextLabel")
    titleText.Name = "Title"
    titleText.Size = UDim2.new(1, -100, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = windowName
    titleText.TextColor3 = Theme.Text
    titleText.TextSize = 16
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.GothamBold
    titleText.Parent = titleBar
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0, 5)
    closeButton.BackgroundColor3 = Theme.Secondary
    closeButton.BackgroundTransparency = 0.3
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = Theme.Text
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    
    CreateCorner(closeButton, 6)
    
    -- Close Button Animation
    closeButton.MouseEnter:Connect(function()
        CreateTween(closeButton, {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}):Play()
    end)
    
    closeButton.MouseLeave:Connect(function()
        CreateTween(closeButton, {BackgroundColor3 = Theme.Secondary}):Play()
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        CreateTween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.2):Play()
        wait(0.2)
        screenGui:Destroy()
    end)
    
    -- Tab Container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 150, 1, -50)
    tabContainer.Position = UDim2.new(0, 10, 0, 50)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame
    
    -- Content Container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, -170, 1, -60)
    contentContainer.Position = UDim2.new(0, 160, 0, 50)
    contentContainer.BackgroundColor3 = Theme.Secondary
    contentContainer.BackgroundTransparency = Theme.Transparency + 0.1
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainFrame
    
    CreateCorner(contentContainer, 8)
    CreateStroke(contentContainer, Theme.Border, 1)
    
    -- Tab System
    local tabs = {}
    local currentTab = nil
    
    local Window = {}
    
    function Window:CreateTab(config)
        config = config or {}
        local tabName = config.Name or "Tab"
        local tabIcon = config.Icon or ""
        
        -- Tab Button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Size = UDim2.new(1, 0, 0, 35)
        tabButton.Position = UDim2.new(0, 0, 0, #tabs * 40)
        tabButton.BackgroundColor3 = Theme.Secondary
        tabButton.BackgroundTransparency = 0.5
        tabButton.BorderSizePixel = 0
        tabButton.Text = ""
        tabButton.AutoButtonColor = false
        tabButton.Parent = tabContainer
        
        CreateCorner(tabButton, 6)
        
        -- Tab Icon (if provided)
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, -10, 1, 0)
        tabLabel.Position = UDim2.new(0, 10, 0, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = (tabIcon ~= "" and tabIcon .. " " or "") .. tabName
        tabLabel.TextColor3 = Theme.TextSecondary
        tabLabel.TextSize = 14
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.Font = Enum.Font.Gotham
        tabLabel.Parent = tabButton
        
        -- Tab Content
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName .. "Content"
        tabContent.Size = UDim2.new(1, -20, 1, -20)
        tabContent.Position = UDim2.new(0, 10, 0, 10)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.ScrollBarThickness = 4
        tabContent.ScrollBarImageColor3 = Theme.Accent
        tabContent.ScrollBarImageTransparency = 0.3
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.Visible = false
        tabContent.Parent = contentContainer
        
        -- Layout for tab content
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 8)
        layout.Parent = tabContent
        
        local padding = Instance.new("UIPadding")
        padding.PaddingAll = UDim.new(0, 5)
        padding.Parent = tabContent
        
        -- Tab functionality
        local function selectTab()
            -- Deselect all tabs
            for _, tab in pairs(tabs) do
                CreateTween(tab.button, {BackgroundTransparency = 0.5}):Play()
                CreateTween(tab.label, {TextColor3 = Theme.TextSecondary}):Play()
                tab.content.Visible = false
            end
            
            -- Select current tab
            CreateTween(tabButton, {BackgroundTransparency = 0.2}):Play()
            CreateTween(tabLabel, {TextColor3 = Theme.Text}):Play()
            tabContent.Visible = true
            currentTab = tabName
        end
        
        tabButton.MouseButton1Click:Connect(selectTab)
        
        -- Hover effects
        tabButton.MouseEnter:Connect(function()
            if currentTab ~= tabName then
                CreateTween(tabButton, {BackgroundTransparency = 0.3}):Play()
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if currentTab ~= tabName then
                CreateTween(tabButton, {BackgroundTransparency = 0.5}):Play()
            end
        end)
        
        -- Store tab
        local tab = {
            button = tabButton,
            label = tabLabel,
            content = tabContent,
            name = tabName
        }
        
        table.insert(tabs, tab)
        
        -- Select first tab
        if #tabs == 1 then
            selectTab()
        end
        
        -- Tab object
        local Tab = {}
        
        function Tab:CreateToggle(config)
            config = config or {}
            local toggleName = config.Name or "Toggle"
            local defaultValue = config.Default or false
            local callback = config.Callback or function() end
            
            -- Toggle Container
            local toggleContainer = Instance.new("Frame")
            toggleContainer.Name = toggleName .. "Toggle"
            toggleContainer.Size = UDim2.new(1, 0, 0, 40)
            toggleContainer.BackgroundColor3 = Theme.Secondary
            toggleContainer.BackgroundTransparency = 0.3
            toggleContainer.BorderSizePixel = 0
            toggleContainer.Parent = tabContent
            
            CreateCorner(toggleContainer, 6)
            
            -- Toggle Label
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(1, -60, 1, 0)
            toggleLabel.Position = UDim2.new(0, 15, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = toggleName
            toggleLabel.TextColor3 = Theme.Text
            toggleLabel.TextSize = 14
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.Parent = toggleContainer
            
            -- Toggle Switch Background
            local switchBg = Instance.new("Frame")
            switchBg.Size = UDim2.new(0, 40, 0, 20)
            switchBg.Position = UDim2.new(1, -50, 0.5, -10)
            switchBg.BackgroundColor3 = defaultValue and Theme.Accent or Theme.Border
            switchBg.BorderSizePixel = 0
            switchBg.Parent = toggleContainer
            
            CreateCorner(switchBg, 10)
            
            -- Toggle Switch Circle
            local switchCircle = Instance.new("Frame")
            switchCircle.Size = UDim2.new(0, 16, 0, 16)
            switchCircle.Position = defaultValue and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
            switchCircle.BackgroundColor3 = Theme.Text
            switchCircle.BorderSizePixel = 0
            switchCircle.Parent = switchBg
            
            CreateCorner(switchCircle, 8)
            
            -- Toggle Button
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(1, 0, 1, 0)
            toggleButton.BackgroundTransparency = 1
            toggleButton.Text = ""
            toggleButton.Parent = toggleContainer
            
            -- Toggle State
            local toggled = defaultValue
            
            -- Toggle Function
            local function toggle()
                toggled = not toggled
                
                local bgColor = toggled and Theme.Accent or Theme.Border
                local circlePos = toggled and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2)
                
                CreateTween(switchBg, {BackgroundColor3 = bgColor}):Play()
                CreateTween(switchCircle, {Position = circlePos}):Play()
                
                callback(toggled)
            end
            
            toggleButton.MouseButton1Click:Connect(toggle)
            
            -- Hover Effect
            toggleButton.MouseEnter:Connect(function()
                CreateTween(toggleContainer, {BackgroundTransparency = 0.1}):Play()
            end)
            
            toggleButton.MouseLeave:Connect(function()
                CreateTween(toggleContainer, {BackgroundTransparency = 0.3}):Play()
            end)
            
            return {
                SetValue = function(value)
                    if toggled ~= value then
                        toggle()
                    end
                end,
                GetValue = function()
                    return toggled
                end
            }
        end
        
        function Tab:CreateButton(config)
            config = config or {}
            local buttonName = config.Name or "Button"
            local callback = config.Callback or function() end
            
            -- Button Container
            local buttonContainer = Instance.new("TextButton")
            buttonContainer.Name = buttonName .. "Button"
            buttonContainer.Size = UDim2.new(1, 0, 0, 35)
            buttonContainer.BackgroundColor3 = Theme.Secondary
            buttonContainer.BackgroundTransparency = 0.3
            buttonContainer.BorderSizePixel = 0
            buttonContainer.Text = ""
            buttonContainer.AutoButtonColor = false
            buttonContainer.Parent = tabContent
            
            CreateCorner(buttonContainer, 6)
            
            -- Button Label
            local buttonLabel = Instance.new("TextLabel")
            buttonLabel.Size = UDim2.new(1, -20, 1, 0)
            buttonLabel.Position = UDim2.new(0, 10, 0, 0)
            buttonLabel.BackgroundTransparency = 1
            buttonLabel.Text = buttonName
            buttonLabel.TextColor3 = Theme.Text
            buttonLabel.TextSize = 14
            buttonLabel.TextXAlignment = Enum.TextXAlignment.Center
            buttonLabel.Font = Enum.Font.Gotham
            buttonLabel.Parent = buttonContainer
            
            -- Button Events
            buttonContainer.MouseButton1Click:Connect(function()
                CreateTween(buttonContainer, {BackgroundTransparency = 0.1}, 0.1):Play()
                wait(0.1)
                CreateTween(buttonContainer, {BackgroundTransparency = 0.3}, 0.1):Play()
                callback()
            end)
            
            buttonContainer.MouseEnter:Connect(function()
                CreateTween(buttonContainer, {BackgroundTransparency = 0.2}):Play()
            end)
            
            buttonContainer.MouseLeave:Connect(function()
                CreateTween(buttonContainer, {BackgroundTransparency = 0.3}):Play()
            end)
        end
        
        function Tab:CreateSlider(config)
            config = config or {}
            local sliderName = config.Name or "Slider"
            local minValue = config.Min or 0
            local maxValue = config.Max or 100
            local defaultValue = config.Default or minValue
            local callback = config.Callback or function() end
            
            -- Slider Container
            local sliderContainer = Instance.new("Frame")
            sliderContainer.Name = sliderName .. "Slider"
            sliderContainer.Size = UDim2.new(1, 0, 0, 50)
            sliderContainer.BackgroundColor3 = Theme.Secondary
            sliderContainer.BackgroundTransparency = 0.3
            sliderContainer.BorderSizePixel = 0
            sliderContainer.Parent = tabContent
            
            CreateCorner(sliderContainer, 6)
            
            -- Slider Label
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
            sliderLabel.Position = UDim2.new(0, 15, 0, 5)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = sliderName
            sliderLabel.TextColor3 = Theme.Text
            sliderLabel.TextSize = 14
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Font = Enum.Font.Gotham
            sliderLabel.Parent = sliderContainer
            
            -- Value Label
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0.3, -15, 0, 20)
            valueLabel.Position = UDim2.new(0.7, 0, 0, 5)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(defaultValue)
            valueLabel.TextColor3 = Theme.Accent
            valueLabel.TextSize = 14
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.Parent = sliderContainer
            
            -- Slider Track
            local sliderTrack = Instance.new("Frame")
            sliderTrack.Size = UDim2.new(1, -30, 0, 4)
            sliderTrack.Position = UDim2.new(0, 15, 1, -15)
            sliderTrack.BackgroundColor3 = Theme.Border
            sliderTrack.BorderSizePixel = 0
            sliderTrack.Parent = sliderContainer
            
            CreateCorner(sliderTrack, 2)
            
            -- Slider Fill
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
            sliderFill.BackgroundColor3 = Theme.Accent
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderTrack
            
            CreateCorner(sliderFill, 2)
            
            -- Slider Thumb
            local sliderThumb = Instance.new("Frame")
            sliderThumb.Size = UDim2.new(0, 12, 0, 12)
            sliderThumb.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -6, 0.5, -6)
            sliderThumb.BackgroundColor3 = Theme.Text
            sliderThumb.BorderSizePixel = 0
            sliderThumb.Parent = sliderTrack
            
            CreateCorner(sliderThumb, 6)
            
            -- Slider Input
            local sliderInput = Instance.new("TextButton")
            sliderInput.Size = UDim2.new(1, 0, 1, 0)
            sliderInput.BackgroundTransparency = 1
            sliderInput.Text = ""
            sliderInput.Parent = sliderTrack
            
            local currentValue = defaultValue
            local dragging = false
            
            local function updateSlider(value)
                value = math.clamp(value, minValue, maxValue)
                currentValue = value
                
                local percentage = (value - minValue) / (maxValue - minValue)
                sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                sliderThumb.Position = UDim2.new(percentage, -6, 0.5, -6)
                valueLabel.Text = tostring(math.floor(value * 100) / 100)
                
                callback(value)
            end
            
            sliderInput.MouseButton1Down:Connect(function()
                dragging = true
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            sliderInput.MouseMoved:Connect(function()
                if dragging then
                    local mouse = UserInputService:GetMouseLocation()
                    local trackPos = sliderTrack.AbsolutePosition.X
                    local trackSize = sliderTrack.AbsoluteSize.X
                    local relativePos = (mouse.X - trackPos) / trackSize
                    relativePos = math.clamp(relativePos, 0, 1)
                    
                    local newValue = minValue + (maxValue - minValue) * relativePos
                    updateSlider(newValue)
                end
            end)
            
            return {
                SetValue = function(value)
                    updateSlider(value)
                end,
                GetValue = function()
                    return currentValue
                end
            }
        end
        
        function Tab:CreateTextbox(config)
            config = config or {}
            local textboxName = config.Name or "Textbox"
            local placeholder = config.Placeholder or "Enter text..."
            local callback = config.Callback or function() end
            
            -- Textbox Container
            local textboxContainer = Instance.new("Frame")
            textboxContainer.Name = textboxName .. "Textbox"
            textboxContainer.Size = UDim2.new(1, 0, 0, 60)
            textboxContainer.BackgroundColor3 = Theme.Secondary
            textboxContainer.BackgroundTransparency = 0.3
            textboxContainer.BorderSizePixel = 0
            textboxContainer.Parent = tabContent
            
            CreateCorner(textboxContainer, 6)
            
            -- Textbox Label
            local textboxLabel = Instance.new("TextLabel")
            textboxLabel.Size = UDim2.new(1, -20, 0, 20)
            textboxLabel.Position = UDim2.new(0, 10, 0, 5)
            textboxLabel.BackgroundTransparency = 1
            textboxLabel.Text = textboxName
            textboxLabel.TextColor3 = Theme.Text
            textboxLabel.TextSize = 14
            textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
            textboxLabel.Font = Enum.Font.Gotham
            textboxLabel.Parent = textboxContainer
            
            -- Text Input
            local textInput = Instance.new("TextBox")
            textInput.Size = UDim2.new(1, -20, 0, 25)
            textInput.Position = UDim2.new(0, 10, 0, 25)
            textInput.BackgroundColor3 = Theme.Primary
            textInput.BackgroundTransparency = 0.2
            textInput.BorderSizePixel = 0
            textInput.Text = ""
            textInput.PlaceholderText = placeholder
            textInput.TextColor3 = Theme.Text
            textInput.PlaceholderColor3 = Theme.TextSecondary
            textInput.TextSize = 13
            textInput.Font = Enum.Font.Gotham
            textInput.Parent = textboxContainer
            
            CreateCorner(textInput, 4)
            CreateStroke(textInput, Theme.Border, 1)
            
            -- Textbox Events
            textInput.Focused:Connect(function()
                CreateTween(textInput, {BackgroundTransparency = 0.1}):Play()
            end)
            
            textInput.FocusLost:Connect(function(enterPressed)
                CreateTween(textInput, {BackgroundTransparency = 0.2}):Play()
                if enterPressed then
                    callback(textInput.Text)
                end
            end)
            
            return {
                SetText = function(text)
                    textInput.Text = text
                end,
                GetText = function()
                    return textInput.Text
                end
            }
        end
        
        function Tab:CreateSection(config)
            config = config or {}
            local sectionName = config.Name or "Section"
            
            -- Section Container
            local sectionContainer = Instance.new("Frame")
            sectionContainer.Name = sectionName .. "Section"
            sectionContainer.Size = UDim2.new(1, 0, 0, 30)
            sectionContainer.BackgroundTransparency = 1
            sectionContainer.Parent = tabContent
            
            -- Section Label
            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Size = UDim2.new(1, -20, 1, 0)
            sectionLabel.Position = UDim2.new(0, 10, 0, 0)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Text = sectionName
            sectionLabel.TextColor3 = Theme.Accent
            sectionLabel.TextSize = 16
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.Parent = sectionContainer
            
            -- Section Line
            local sectionLine = Instance.new("Frame")
            sectionLine.Size = UDim2.new(1, -20, 0, 1)
            sectionLine.Position = UDim2.new(0, 10, 1, -5)
            sectionLine.BackgroundColor3 = Theme.Accent
            sectionLine.BackgroundTransparency = 0.7
            sectionLine.BorderSizePixel = 0
            sectionLine.Parent = sectionContainer
        end
        
        return Tab
    end
    
    -- Window intro animation
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(mainFrame, {Size = windowSize}, 0.5):Play()
    
    return Window
end

-- Notification System
function OXGUI:Notification(config)
    config = config or {}
    local title = config.Title or "Notification"
    local text = config.Text or "This is a notification"
    local duration = config.Duration or 3
    
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "OXGUI_Notification"
    notifGui.Parent = PlayerGui
    
    local notifFrame = Instance.new("Frame")
    notifFrame.Size = UDim2.new(0, 300, 0, 80)
    notifFrame.Position = UDim2.new(1, 10, 0, 50)
    notifFrame.BackgroundColor3 = Theme.Primary
    notifFrame.BackgroundTransparency = Theme.Transparency
    notifFrame.BorderSizePixel = 0
    notifFrame.Parent = notifGui
    
    CreateCorner(notifFrame, 8)
    CreateStroke(notifFrame, Theme.Border, 1)
    CreateShadow(notifFrame)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Theme.Text
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = notifFrame
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 0, 40)
    textLabel.Position = UDim2.new(0, 10, 0, 25)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Theme.TextSecondary
    textLabel.TextSize = 12
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextWrapped = true
    textLabel.Parent = notifFrame
    
    -- Animation
    CreateTween(notifFrame, {Position = UDim2.new(1, -310, 0, 50)}):Play()
    
    -- Auto dismiss
    task.spawn(function()
        wait(duration)
        CreateTween(notifFrame, {Position = UDim2.new(1, 10, 0, 50)}):Play()
        wait(0.3)
        notifGui:Destroy()
    end)
    
    -- Click to dismiss
    local dismissButton = Instance.new("TextButton")
    dismissButton.Size = UDim2.new(1, 0, 1, 0)
    dismissButton.BackgroundTransparency = 1
    dismissButton.Text = ""
    dismissButton.Parent = notifFrame
    
    dismissButton.MouseButton1Click:Connect(function()
        CreateTween(notifFrame, {Position = UDim2.new(1, 10, 0, 50)}):Play()
        wait(0.3)
        notifGui:Destroy()
    end)
end

-- Destroy function
function OXGUI:Destroy(windowName)
    local gui = PlayerGui:FindFirstChild("OXGUI_" .. windowName)
    if gui then
        gui:Destroy()
    end
end

-- Get theme colors
function OXGUI:GetTheme()
    return Theme
end

-- Set custom theme
function OXGUI:SetTheme(newTheme)
    for key, value in pairs(newTheme) do
        if Theme[key] then
            Theme[key] = value
        end
    end
end

return OXGUI
