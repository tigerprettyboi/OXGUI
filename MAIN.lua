-- LuxuryUI Library for Roblox
-- A simple, elegant, semi-transparent black GUI library with tabs, toggle buttons, and corner minimize/expand functionality.
-- Inspired by modern UI designs for ease of use and luxury feel.
-- Usage: 
-- local LuxuryUI = require(path.to.this.module)
-- local gui = LuxuryUI.Create("My UI", {tabs = {"Home", "Settings"}})
-- gui:AddToggle("My Toggle", function(state) print("Toggled:", state) end)
-- gui:AddButton("My Button", "Tab1", function() print("Clicked") end)

local LuxuryUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function CreateFrame(parent, size, pos, color, transparency, radius)
    local frame = Instance.new("Frame")
    frame.Size = size or UDim2.new(0, 400, 0, 300)
    frame.Position = pos or UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = color or Color3.new(0, 0, 0)
    frame.BackgroundTransparency = transparency or 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Transparency = 0.7
    stroke.Thickness = 1
    stroke.Parent = frame
    
    return frame
end

local function MakeDraggable(frame)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function CreateTabButton(name, pos, parent, onClick, isActive)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 100, 1, 0)
    button.Position = pos
    button.BackgroundColor3 = isActive and Color3.new(0.3, 0.3, 0.3) or Color3.new(0.2, 0.2, 0.2)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(onClick)
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        if not isActive then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)}):Play()
        end
    end)
    button.MouseLeave:Connect(function()
        if not isActive then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)}):Play()
        end
    end)
    
    return button
end

local function CreateToggleButton(name, pos, parent, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 0, 30)
    button.Position = pos
    button.BackgroundColor3 = Color3.new(0.8, 0, 0)
    button.BorderSizePixel = 0
    button.Text = "OFF"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    local state = false
    local function toggle()
        state = not state
        button.Text = state and "ON" or "OFF"
        button.BackgroundColor3 = state and Color3.new(0, 0.8, 0) or Color3.new(0.8, 0, 0)
        if callback then callback(state) end
    end
    
    button.MouseButton1Click:Connect(toggle)
    
    return {button = button, toggle = toggle, setState = function(newState) state = newState; toggle() end}
end

function LuxuryUI.Create(title, config)
    config = config or {}
    local tabs = config.tabs or {"Home"}
    
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = title or "LuxuryUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    local mainFrame = CreateFrame(screenGui, UDim2.new(0, 400, 0, 300))
    MakeDraggable(mainFrame)
    
    -- Title bar
    local titleBar = CreateFrame(mainFrame, UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 0), Color3.new(0, 0, 0), 0.2, 0)
    titleBar.BackgroundTransparency = 0.1
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = titleBar
    
    -- Tab bar
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -20, 0, 40)
    tabFrame.Position = UDim2.new(0, 10, 0, 50)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Parent = mainFrame
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -20, 1, -100)
    contentContainer.Position = UDim2.new(0, 10, 0, 100)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFrame
    
    local tabButtons = {}
    local contentFrames = {}
    local currentTabIndex = 1
    
    for i, tabName in ipairs(tabs) do
        local tabButton = CreateTabButton(tabName, UDim2.new(0, (i-1) * 110, 0, 0), tabFrame, function()
            -- Switch tab
            for j = 1, #tabButtons do
                local btn = tabButtons[j]
                local cont = contentFrames[j]
                local isActive = (j == i)
                btn.BackgroundColor3 = isActive and Color3.new(0.3, 0.3, 0.3) or Color3.new(0.2, 0.2, 0.2)
                cont.Visible = isActive
            end
            currentTabIndex = i
        end, i == 1)
        table.insert(tabButtons, tabButton)
        
        local content = CreateFrame(contentContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, -(i-1)*10, 0, 0), nil, 1)
        content.Visible = (i == 1)
        table.insert(contentFrames, content)
    end
    
    -- Minimize/Expand button (top-right corner functionality)
    local minButton = Instance.new("TextButton")
    minButton.Size = UDim2.new(0, 30, 0, 30)
    minButton.Position = UDim2.new(1, -40, 0, 5)
    minButton.BackgroundTransparency = 1
    minButton.Text = "-"
    minButton.TextColor3 = Color3.new(1, 1, 1)
    minButton.TextScaled = true
    minButton.Font = Enum.Font.GothamBold
    minButton.Parent = mainFrame
    
    local isMinimized = false
    minButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            -- Minimize to corner
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 30, 0, 30),
                Position = UDim2.new(1, -40, 0, 20)  -- Top-right corner
            }):Play()
            minButton.Text = "+"
            titleBar.Visible = false
            tabFrame.Visible = false
            contentContainer.Visible = false
        else
            -- Expand
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 400, 0, 300),
                Position = UDim2.new(0.5, -200, 0.5, -150)
            }):Play()
            minButton.Text = "-"
            titleBar.Visible = true
            tabFrame.Visible = true
            contentContainer.Visible = true
        end
    end)
    
    -- Corner resize (simple drag from bottom-right corner)
    local resizeHandle = Instance.new("Frame")
    resizeHandle.Size = UDim2.new(0, 10, 0, 10)
    resizeHandle.Position = UDim2.new(1, -10, 1, -10)
    resizeHandle.BackgroundColor3 = Color3.new(1, 1, 1)
    resizeHandle.BackgroundTransparency = 0.5
    resizeHandle.BorderSizePixel = 0
    resizeHandle.Parent = mainFrame
    
    local cornerCorner = Instance.new("UICorner")
    cornerCorner.CornerRadius = UDim.new(1, 0)
    cornerCorner.Parent = resizeHandle
    
    local resizing = false
    local resizeStart = nil
    local startSize = nil
    local startPos = nil
    
    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizeStart = input.Position
            startSize = mainFrame.Size
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizeStart
            local newWidth = math.max(200, startSize.X.Offset + delta.X)
            local newHeight = math.max(150, startSize.Y.Offset + delta.Y)
            mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
    
    local ui = {
        gui = screenGui,
        frame = mainFrame,
        AddTab = function(self, name)
            local newIndex = #tabs + 1
            table.insert(tabs, name)
            local tabButton = CreateTabButton(name, UDim2.new(0, (newIndex-1) * 110, 0, 0), tabFrame, function()
                -- Similar switch logic
                for j = 1, #tabButtons do
                    local btn = tabButtons[j]
                    local cont = contentFrames[j]
                    local isActive = (j == newIndex)
                    btn.BackgroundColor3 = isActive and Color3.new(0.3, 0.3, 0.3) or Color3.new(0.2, 0.2, 0.2)
                    cont.Visible = isActive
                end
                currentTabIndex = newIndex
            end, false)
            table.insert(tabButtons, tabButton)
            
            local content = CreateFrame(contentContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, -(newIndex-1)*10, 0, 0), nil, 1)
            content.Visible = false
            table.insert(contentFrames, content)
            
            return content
        end,
        AddToggle = function(self, name, pos, callback)
            local currentContent = contentFrames[currentTabIndex]
            return CreateToggleButton(name, pos or UDim2.new(0, 10, 0, 10 + (#currentContent:GetChildren() * 40)), currentContent, callback)
        end,
        AddButton = function(self, name, pos, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -20, 0, 30)
            button.Position = pos or UDim2.new(0, 10, 0, 10 + (#contentFrames[currentTabIndex]:GetChildren() * 40))
            button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            button.BorderSizePixel = 0
            button.Text = name
            button.TextColor3 = Color3.new(1, 1, 1)
            button.TextScaled = true
            button.Font = Enum.Font.Gotham
            button.Parent = contentFrames[currentTabIndex]
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = button
            
            button.MouseButton1Click:Connect(callback)
            
            return button
        end,
        Minimize = function(self)
            minButton.MouseButton1Click:Fire()
        end,
        Destroy = function(self)
            screenGui:Destroy()
        end
    }
    
    return ui
end

return LuxuryUI
