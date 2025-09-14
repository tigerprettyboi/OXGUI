-- Modern Roblox GUI Library
-- สร้างโดย Claude สำหรับการใช้งานที่ง่ายและสวยงาม

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Library = {}
Library.__index = Library

-- สี Theme หลัก
local Theme = {
    Background = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(100, 150, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(180, 180, 180),
    Success = Color3.fromRGB(100, 255, 150),
    Warning = Color3.fromRGB(255, 200, 100),
    Error = Color3.fromRGB(255, 100, 100)
}

-- Animation Settings
local AnimationInfo = {
    Fast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Medium = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
}

-- สร้าง UI Elements
local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Secondary
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.5
    stroke.Parent = parent
    return stroke
end

local function createGradient(parent, colors)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors or {
        ColorSequenceKeypoint.new(0, Theme.Background),
        ColorSequenceKeypoint.new(1, Theme.Secondary)
    })
    gradient.Rotation = 45
    gradient.Parent = parent
    return gradient
end

-- สร้าง Drop Shadow Effect
local function createShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent.Parent
    
    createCorner(shadow, 12)
    return shadow
end

-- Main Library Functions
function Library.new(options)
    local self = setmetatable({}, Library)
    
    options = options or {}
    self.title = options.title or "Modern GUI"
    self.size = options.size or UDim2.new(0, 500, 0, 400)
    self.position = options.position or UDim2.new(0.5, -250, 0.5, -200)
    
    -- สร้าง Main GUI
    self.gui = Instance.new("ScreenGui")
    self.gui.Name = "ModernGUI_" .. math.random(1000, 9999)
    self.gui.Parent = CoreGui
    self.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    self.main = Instance.new("Frame")
    self.main.Name = "MainFrame"
    self.main.Size = self.size
    self.main.Position = self.position
    self.main.BackgroundColor3 = Theme.Background
    self.main.BackgroundTransparency = 0.05
    self.main.BorderSizePixel = 0
    self.main.ClipsDescendants = true
    self.main.Parent = self.gui
    
    createCorner(self.main, 12)
    createStroke(self.main, Theme.Accent, 2)
    createShadow(self.main)
    
    -- Title Bar
    self.titleBar = Instance.new("Frame")
    self.titleBar.Name = "TitleBar"
    self.titleBar.Size = UDim2.new(1, 0, 0, 40)
    self.titleBar.Position = UDim2.new(0, 0, 0, 0)
    self.titleBar.BackgroundColor3 = Theme.Secondary
    self.titleBar.BackgroundTransparency = 0.1
    self.titleBar.BorderSizePixel = 0
    self.titleBar.Parent = self.main
    
    createCorner(self.titleBar, 8)
    createGradient(self.titleBar)
    
    -- Title Text
    self.titleText = Instance.new("TextLabel")
    self.titleText.Name = "TitleText"
    self.titleText.Size = UDim2.new(1, -100, 1, 0)
    self.titleText.Position = UDim2.new(0, 15, 0, 0)
    self.titleText.BackgroundTransparency = 1
    self.titleText.Text = self.title
    self.titleText.TextColor3 = Theme.Text
    self.titleText.TextScaled = true
    self.titleText.TextXAlignment = Enum.TextXAlignment.Left
    self.titleText.Font = Enum.Font.GothamBold
    self.titleText.Parent = self.titleBar
    
    -- Toggle Button
    self.toggleBtn = Instance.new("TextButton")
    self.toggleBtn.Name = "ToggleButton"
    self.toggleBtn.Size = UDim2.new(0, 30, 0, 30)
    self.toggleBtn.Position = UDim2.new(1, -40, 0, 5)
    self.toggleBtn.BackgroundColor3 = Theme.Accent
    self.toggleBtn.BackgroundTransparency = 0.2
    self.toggleBtn.BorderSizePixel = 0
    self.toggleBtn.Text = "−"
    self.toggleBtn.TextColor3 = Theme.Text
    self.toggleBtn.TextScaled = true
    self.toggleBtn.Font = Enum.Font.GothamBold
    self.toggleBtn.Parent = self.titleBar
    
    createCorner(self.toggleBtn, 6)
    
    -- Content Frame
    self.content = Instance.new("Frame")
    self.content.Name = "Content"
    self.content.Size = UDim2.new(1, -20, 1, -60)
    self.content.Position = UDim2.new(0, 10, 0, 50)
    self.content.BackgroundTransparency = 1
    self.content.BorderSizePixel = 0
    self.content.Parent = self.main
    
    -- Tab Container
    self.tabContainer = Instance.new("Frame")
    self.tabContainer.Name = "TabContainer"
    self.tabContainer.Size = UDim2.new(1, 0, 0, 35)
    self.tabContainer.Position = UDim2.new(0, 0, 0, 0)
    self.tabContainer.BackgroundColor3 = Theme.Secondary
    self.tabContainer.BackgroundTransparency = 0.3
    self.tabContainer.BorderSizePixel = 0
    self.tabContainer.Parent = self.content
    
    createCorner(self.tabContainer, 6)
    
    -- Tab Content
    self.tabContent = Instance.new("Frame")
    self.tabContent.Name = "TabContent"
    self.tabContent.Size = UDim2.new(1, 0, 1, -45)
    self.tabContent.Position = UDim2.new(0, 0, 0, 45)
    self.tabContent.BackgroundTransparency = 1
    self.tabContent.BorderSizePixel = 0
    self.tabContent.Parent = self.content
    
    -- สร้าง ScrollingFrame สำหรับ content
    self.scrollFrame = Instance.new("ScrollingFrame")
    self.scrollFrame.Name = "ScrollFrame"
    self.scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    self.scrollFrame.Position = UDim2.new(0, 0, 0, 0)
    self.scrollFrame.BackgroundTransparency = 1
    self.scrollFrame.BorderSizePixel = 0
    self.scrollFrame.ScrollBarThickness = 6
    self.scrollFrame.ScrollBarImageColor3 = Theme.Accent
    self.scrollFrame.Parent = self.tabContent
    
    -- Layout สำหรับ tabs
    self.tabLayout = Instance.new("UIListLayout")
    self.tabLayout.FillDirection = Enum.FillDirection.Horizontal
    self.tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    self.tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.tabLayout.Padding = UDim.new(0, 5)
    self.tabLayout.Parent = self.tabContainer
    
    -- เก็บ tabs และ variables
    self.tabs = {}
    self.currentTab = nil
    self.isMinimized = false
    self.isDragging = false
    self.isResizing = false
    
    -- เพิ่ม Resize Handle
    self:addResizeHandle()
    
    -- เพิ่ม Event Handlers
    self:setupEventHandlers()
    
    return self
end

-- เพิ่ม Resize Handle
function Library:addResizeHandle()
    self.resizeHandle = Instance.new("TextButton")
    self.resizeHandle.Name = "ResizeHandle"
    self.resizeHandle.Size = UDim2.new(0, 20, 0, 20)
    self.resizeHandle.Position = UDim2.new(1, -20, 1, -20)
    self.resizeHandle.BackgroundColor3 = Theme.Accent
    self.resizeHandle.BackgroundTransparency = 0.3
    self.resizeHandle.BorderSizePixel = 0
    self.resizeHandle.Text = "⟲"
    self.resizeHandle.TextColor3 = Theme.Text
    self.resizeHandle.TextScaled = true
    self.resizeHandle.Font = Enum.Font.Gotham
    self.resizeHandle.Parent = self.main
    
    createCorner(self.resizeHandle, 4)
end

-- Setup Event Handlers
function Library:setupEventHandlers()
    -- Toggle functionality
    self.toggleBtn.MouseButton1Click:Connect(function()
        self:toggle()
    end)
    
    -- Drag functionality
    local dragStart, startPos
    
    self.titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = true
            dragStart = input.Position
            startPos = self.main.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if self.isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            self.main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        elseif self.isResizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            local newSize = UDim2.new(0, math.max(300, startPos.X + delta.X), 0, math.max(200, startPos.Y + delta.Y))
            self.main.Size = newSize
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isDragging = false
            self.isResizing = false
        end
    end)
    
    -- Resize functionality
    self.resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.isResizing = true
            dragStart = input.Position
            startPos = Vector2.new(self.main.Size.X.Offset, self.main.Size.Y.Offset)
        end
    end)
    
    -- Hover effects
    self:addHoverEffect(self.toggleBtn)
    self:addHoverEffect(self.resizeHandle)
end

-- Toggle GUI
function Library:toggle()
    self.isMinimized = not self.isMinimized
    local targetSize = self.isMinimized and UDim2.new(0, self.main.Size.X.Offset, 0, 40) or self.size
    local buttonText = self.isMinimized and "□" or "−"
    
    TweenService:Create(self.main, AnimationInfo.Medium, {Size = targetSize}):Play()
    TweenService:Create(self.toggleBtn, AnimationInfo.Fast, {Rotation = self.isMinimized and 180 or 0}):Play()
    
    self.toggleBtn.Text = buttonText
    self.content.Visible = not self.isMinimized
    self.resizeHandle.Visible = not self.isMinimized
end

-- เพิ่ม Hover Effect
function Library:addHoverEffect(element)
    element.MouseEnter:Connect(function()
        TweenService:Create(element, AnimationInfo.Fast, {BackgroundTransparency = 0}):Play()
    end)
    
    element.MouseLeave:Connect(function()
        TweenService:Create(element, AnimationInfo.Fast, {BackgroundTransparency = 0.2}):Play()
    end)
end

-- สร้าง Tab
function Library:addTab(name, icon)
    local tab = {}
    
    -- Tab Button
    tab.button = Instance.new("TextButton")
    tab.button.Name = name .. "Tab"
    tab.button.Size = UDim2.new(0, 100, 1, -10)
    tab.button.Position = UDim2.new(0, 0, 0, 5)
    tab.button.BackgroundColor3 = Theme.Secondary
    tab.button.BackgroundTransparency = 0.5
    tab.button.BorderSizePixel = 0
    tab.button.Text = (icon or "📁") .. " " .. name
    tab.button.TextColor3 = Theme.TextSecondary
    tab.button.TextScaled = true
    tab.button.Font = Enum.Font.Gotham
    tab.button.Parent = self.tabContainer
    
    createCorner(tab.button, 4)
    
    -- Tab Content Frame
    tab.content = Instance.new("Frame")
    tab.content.Name = name .. "Content"
    tab.content.Size = UDim2.new(1, 0, 1, 0)
    tab.content.Position = UDim2.new(0, 0, 0, 0)
    tab.content.BackgroundTransparency = 1
    tab.content.BorderSizePixel = 0
    tab.content.Visible = false
    tab.content.Parent = self.scrollFrame
    
    -- Layout สำหรับ tab content
    tab.layout = Instance.new("UIListLayout")
    tab.layout.FillDirection = Enum.FillDirection.Vertical
    tab.layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tab.layout.SortOrder = Enum.SortOrder.LayoutOrder
    tab.layout.Padding = UDim.new(0, 5)
    tab.layout.Parent = tab.content
    
    -- Tab Click Event
    tab.button.MouseButton1Click:Connect(function()
        self:selectTab(name)
    end)
    
    self:addHoverEffect(tab.button)
    
    self.tabs[name] = tab
    
    -- Select first tab automatically
    if not self.currentTab then
        self:selectTab(name)
    end
    
    return tab
end

-- Select Tab
function Library:selectTab(name)
    for tabName, tab in pairs(self.tabs) do
        if tabName == name then
            tab.button.BackgroundTransparency = 0.1
            tab.button.TextColor3 = Theme.Text
            tab.content.Visible = true
            self.currentTab = tabName
        else
            tab.button.BackgroundTransparency = 0.5
            tab.button.TextColor3 = Theme.TextSecondary
            tab.content.Visible = false
        end
    end
end

-- เพิ่ม Button
function Library:addButton(tabName, text, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Size = UDim2.new(1, -20, 0, 35)
    button.BackgroundColor3 = Theme.Accent
    button.BackgroundTransparency = 0.2
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Theme.Text
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.Parent = tab.content
    
    createCorner(button, 6)
    self:addHoverEffect(button)
    
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
        
        -- Click animation
        TweenService:Create(button, AnimationInfo.Fast, {BackgroundColor3 = Theme.Success}):Play()
        wait(0.1)
        TweenService:Create(button, AnimationInfo.Fast, {BackgroundColor3 = Theme.Accent}):Play()
    end)
    
    return button
end

-- เพิ่ม Toggle
function Library:addToggle(tabName, text, default, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = text .. "Toggle"
    toggleFrame.Size = UDim2.new(1, -20, 0, 35)
    toggleFrame.BackgroundColor3 = Theme.Secondary
    toggleFrame.BackgroundTransparency = 0.3
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = tab.content
    
    createCorner(toggleFrame, 6)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = toggleFrame
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 35, 0, 25)
    toggle.Position = UDim2.new(1, -40, 0.5, -12.5)
    toggle.BackgroundColor3 = default and Theme.Success or Theme.Error
    toggle.BackgroundTransparency = 0.2
    toggle.BorderSizePixel = 0
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = Theme.Text
    toggle.TextScaled = true
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = toggleFrame
    
    createCorner(toggle, 4)
    self:addHoverEffect(toggle)
    
    local isToggled = default
    
    toggle.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggle.Text = isToggled and "ON" or "OFF"
        toggle.BackgroundColor3 = isToggled and Theme.Success or Theme.Error
        
        if callback then callback(isToggled) end
    end)
    
    return toggle
end

-- เพิ่ม Slider
function Library:addSlider(tabName, text, min, max, default, callback)
    local tab = self.tabs[tabName]
    if not tab then return end
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = text .. "Slider"
    sliderFrame.Size = UDim2.new(1, -20, 0, 50)
    sliderFrame.BackgroundColor3 = Theme.Secondary
    sliderFrame.BackgroundTransparency = 0.3
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = tab.content
    
    createCorner(sliderFrame, 6)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Theme.Text
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = sliderFrame
    
    local sliderBG = Instance.new("Frame")
    sliderBG.Size = UDim2.new(1, -20, 0, 6)
    sliderBG.Position = UDim2.new(0, 10, 1, -15)
    sliderBG.BackgroundColor3 = Theme.Background
    sliderBG.BorderSizePixel = 0
    sliderBG.Parent = sliderFrame
    
    createCorner(sliderBG, 3)
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Theme.Accent
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBG
    
    createCorner(sliderFill, 3)
    
    local value = default
    
    sliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local function updateSlider()
                local mouse = Players.LocalPlayer:GetMouse()
                local percent = math.clamp((mouse.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * percent)
                
                sliderFill.Size = UDim2.new(percent, 0, 1, 0)
                label.Text = text .. ": " .. value
                
                if callback then callback(value) end
            end
            
            updateSlider()
            
            local connection
            connection = UserInputService.InputChanged:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider()
                end
            end)
            
            local connection2
            connection2 = UserInputService.InputEnded:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseButton1 then
                    connection:Disconnect()
                    connection2:Disconnect()
                end
            end)
        end
    end)
    
    return sliderFrame
end

-- Destroy GUI
function Library:destroy()
    if self.gui then
        self.gui:Destroy()
    end
end

return Library
