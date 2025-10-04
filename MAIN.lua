-- VS Code Style GUI for Roblox
-- โหลดผ่าน loadstring

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- สร้าง ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VSCodeGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ตรวจสอบว่าใช้ Synapse X หรือ Executor อื่น
if syn then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
else
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Frame (หน้าต่างหลัก)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 800, 0, 500)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- เพิ่ม UICorner
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Visual Studio Code - Library"
TitleText.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.SourceSans
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 2.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 2.5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinimizeButton

-- Content Area
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -35)
ContentFrame.Position = UDim2.new(0, 0, 0, 35)
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 50, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = ContentFrame

-- Main Content Area
local MainContent = Instance.new("Frame")
MainContent.Name = "MainContent"
MainContent.Size = UDim2.new(1, -50, 1, -30)
MainContent.Position = UDim2.new(0, 50, 0, 0)
MainContent.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainContent.BorderSizePixel = 0
MainContent.Parent = ContentFrame

-- ScrollingFrame สำหรับเนื้อหา
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -20)
ScrollFrame.Position = UDim2.new(0, 10, 0, 10)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = MainContent

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 5)
ListLayout.Parent = ScrollFrame

-- Status Bar
local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Size = UDim2.new(1, -50, 0, 30)
StatusBar.Position = UDim2.new(0, 50, 1, -30)
StatusBar.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
StatusBar.BorderSizePixel = 0
StatusBar.Parent = ContentFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 1, 0)
StatusText.Position = UDim2.new(0, 10, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Ready"
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 13
StatusText.Font = Enum.Font.SourceSans
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = StatusBar

-- ฟังก์ชันเพิ่มปุ่มในเนื้อหา
local function addButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(200, 200, 200)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSans
    Button.AutoButtonColor = false
    Button.Parent = ScrollFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Parent = Button
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return Button
end

-- ตัวอย่างปุ่ม
addButton("Example Function 1", function()
    StatusText.Text = "Function 1 Executed"
    print("Function 1 clicked")
end)

addButton("Example Function 2", function()
    StatusText.Text = "Function 2 Executed"
    print("Function 2 clicked")
end)

addButton("Example Function 3", function()
    StatusText.Text = "Function 3 Executed"
    print("Function 3 clicked")
end)

-- อัพเดท Canvas Size
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end)

-- ฟังก์ชัน Toggle
local isVisible = false

local function toggleGUI()
    isVisible = not isVisible
    
    if isVisible then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0.5, -400, 0.5, -250)
        }):Play()
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0.5, -400, 1.5, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            if not isVisible then
                MainFrame.Visible = false
            end
        end)
    end
end

-- Close Button Action
CloseButton.MouseButton1Click:Connect(function()
    toggleGUI()
end)

-- Minimize Button Action (ทำแบบเดียวกับ Close)
MinimizeButton.MouseButton1Click:Connect(function()
    toggleGUI()
end)

-- Hover Effects สำหรับปุ่ม Title Bar
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(232, 17, 35)}):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
end)

MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
end)

-- Keybind สำหรับ Toggle (Right Shift)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        toggleGUI()
    end
end)

-- แสดง GUI ตอนเริ่มต้น
wait(0.5)
toggleGUI()

print("VS Code Style GUI Loaded! Press Right Shift to toggle.")

-- Return functions สำหรับการควบคุมจากภายนอก
return {
    Toggle = toggleGUI,
    AddButton = addButton,
    SetStatus = function(text)
        StatusText.Text = text
    end,
    GUI = ScreenGui
}
