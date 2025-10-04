-- VS Code Style GUI for Roblox - Premium Edition (Fixed)
-- โหลดผ่าน loadstring

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- สร้าง ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VSCodeGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ตรวจสอบว่าใช้ Synapse X หรือ Executor อื่น
pcall(function()
    if syn then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = game:GetService("CoreGui")
    else
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 900, 0, 600)
MainFrame.Position = UDim2.new(0.5, -450, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(37, 37, 38)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleBarCover = Instance.new("Frame")
TitleBarCover.Size = UDim2.new(1, 0, 0, 10)
TitleBarCover.Position = UDim2.new(0, 0, 1, -10)
TitleBarCover.BackgroundColor3 = Color3.fromRGB(37, 37, 38)
TitleBarCover.BorderSizePixel = 0
TitleBarCover.Parent = TitleBar

-- Mac Buttons
local MacButtons = Instance.new("Frame")
MacButtons.Name = "MacButtons"
MacButtons.Size = UDim2.new(0, 70, 0, 40)
MacButtons.Position = UDim2.new(0, 12, 0, 0)
MacButtons.BackgroundTransparency = 1
MacButtons.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 12, 0, 12)
CloseBtn.Position = UDim2.new(0, 0, 0.5, -6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 95, 87)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = ""
CloseBtn.Parent = MacButtons

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 12, 0, 12)
MinBtn.Position = UDim2.new(0, 20, 0.5, -6)
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 189, 68)
MinBtn.BorderSizePixel = 0
MinBtn.Text = ""
MinBtn.Parent = MacButtons

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinBtn

local MaxBtn = Instance.new("TextButton")
MaxBtn.Name = "MaxBtn"
MaxBtn.Size = UDim2.new(0, 12, 0, 12)
MaxBtn.Position = UDim2.new(0, 40, 0.5, -6)
MaxBtn.BackgroundColor3 = Color3.fromRGB(40, 201, 64)
MaxBtn.BorderSizePixel = 0
MaxBtn.Text = ""
MaxBtn.Parent = MacButtons

local MaxCorner = Instance.new("UICorner")
MaxCorner.CornerRadius = UDim.new(1, 0)
MaxCorner.Parent = MaxBtn

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -180, 1, 0)
TitleText.Position = UDim2.new(0, 90, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Visual Studio Code"
TitleText.TextColor3 = Color3.fromRGB(204, 204, 204)
TitleText.TextSize = 13
TitleText.Font = Enum.Font.SourceSans
TitleText.Parent = TitleBar

-- Draggable
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

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Tab Bar
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, 0, 0, 35)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(37, 37, 38)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local ActiveTab = Instance.new("Frame")
ActiveTab.Name = "ActiveTab"
ActiveTab.Size = UDim2.new(0, 180, 1, 0)
ActiveTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ActiveTab.BorderSizePixel = 0
ActiveTab.Parent = TabBar

local TabIcon = Instance.new("TextLabel")
TabIcon.Size = UDim2.new(0, 20, 1, 0)
TabIcon.Position = UDim2.new(0, 12, 0, 0)
TabIcon.BackgroundTransparency = 1
TabIcon.Text = "📄"
TabIcon.TextColor3 = Color3.fromRGB(85, 180, 226)
TabIcon.TextSize = 16
TabIcon.Font = Enum.Font.SourceSans
TabIcon.Parent = ActiveTab

local TabText = Instance.new("TextLabel")
TabText.Size = UDim2.new(1, -50, 1, 0)
TabText.Position = UDim2.new(0, 35, 0, 0)
TabText.BackgroundTransparency = 1
TabText.Text = "main.lua"
TabText.TextColor3 = Color3.fromRGB(204, 204, 204)
TabText.TextSize = 13
TabText.Font = Enum.Font.SourceSans
TabText.TextXAlignment = Enum.TextXAlignment.Left
TabText.Parent = ActiveTab

local ModifiedDot = Instance.new("Frame")
ModifiedDot.Name = "ModifiedDot"
ModifiedDot.Size = UDim2.new(0, 8, 0, 8)
ModifiedDot.Position = UDim2.new(1, -20, 0.5, -4)
ModifiedDot.BackgroundColor3 = Color3.fromRGB(204, 204, 204)
ModifiedDot.BorderSizePixel = 0
ModifiedDot.Parent = ActiveTab

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = ModifiedDot

-- Content Area
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -75)
ContentFrame.Position = UDim2.new(0, 0, 0, 75)
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.BorderSizePixel = 0
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 250, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(37, 37, 38)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = ContentFrame

local SidebarHeader = Instance.new("Frame")
SidebarHeader.Size = UDim2.new(1, 0, 0, 35)
SidebarHeader.BackgroundColor3 = Color3.fromRGB(37, 37, 38)
SidebarHeader.BorderSizePixel = 0
SidebarHeader.Parent = Sidebar

local SidebarTitle = Instance.new("TextLabel")
SidebarTitle.Size = UDim2.new(1, -20, 1, 0)
SidebarTitle.Position = UDim2.new(0, 10, 0, 0)
SidebarTitle.BackgroundTransparency = 1
SidebarTitle.Text = "EXPLORER"
SidebarTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SidebarTitle.TextSize = 11
SidebarTitle.Font = Enum.Font.SourceSansBold
SidebarTitle.TextXAlignment = Enum.TextXAlignment.Left
SidebarTitle.Parent = SidebarHeader

local FileTree = Instance.new("ScrollingFrame")
FileTree.Name = "FileTree"
FileTree.Size = UDim2.new(1, 0, 1, -35)
FileTree.Position = UDim2.new(0, 0, 0, 35)
FileTree.BackgroundTransparency = 1
FileTree.BorderSizePixel = 0
FileTree.ScrollBarThickness = 4
FileTree.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
FileTree.CanvasSize = UDim2.new(0, 0, 0, 0)
FileTree.Parent = Sidebar

local TreeLayout = Instance.new("UIListLayout")
TreeLayout.SortOrder = Enum.SortOrder.LayoutOrder
TreeLayout.Padding = UDim.new(0, 2)
TreeLayout.Parent = FileTree

-- Editor Area
local EditorFrame = Instance.new("Frame")
EditorFrame.Name = "EditorFrame"
EditorFrame.Size = UDim2.new(1, -250, 1, -30)
EditorFrame.Position = UDim2.new(0, 250, 0, 0)
EditorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EditorFrame.BorderSizePixel = 0
EditorFrame.Parent = ContentFrame

local LineNumbers = Instance.new("Frame")
LineNumbers.Name = "LineNumbers"
LineNumbers.Size = UDim2.new(0, 50, 1, 0)
LineNumbers.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LineNumbers.BorderSizePixel = 0
LineNumbers.Parent = EditorFrame

local CodeScroll = Instance.new("ScrollingFrame")
CodeScroll.Name = "CodeScroll"
CodeScroll.Size = UDim2.new(1, -50, 1, 0)
CodeScroll.Position = UDim2.new(0, 50, 0, 0)
CodeScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CodeScroll.BorderSizePixel = 0
CodeScroll.ScrollBarThickness = 8
CodeScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
CodeScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
CodeScroll.Parent = EditorFrame

local CodeLayout = Instance.new("UIListLayout")
CodeLayout.SortOrder = Enum.SortOrder.LayoutOrder
CodeLayout.Padding = UDim.new(0, 0)
CodeLayout.Parent = CodeScroll

-- Status Bar
local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Size = UDim2.new(1, 0, 0, 30)
StatusBar.Position = UDim2.new(0, 0, 1, -30)
StatusBar.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
StatusBar.BorderSizePixel = 0
StatusBar.Parent = ContentFrame

local StatusLeft = Instance.new("TextLabel")
StatusLeft.Size = UDim2.new(0.5, -10, 1, 0)
StatusLeft.Position = UDim2.new(0, 10, 0, 0)
StatusLeft.BackgroundTransparency = 1
StatusLeft.Text = "Ready"
StatusLeft.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLeft.TextSize = 13
StatusLeft.Font = Enum.Font.SourceSans
StatusLeft.TextXAlignment = Enum.TextXAlignment.Left
StatusLeft.Parent = StatusBar

local StatusRight = Instance.new("TextLabel")
StatusRight.Size = UDim2.new(0.5, -10, 1, 0)
StatusRight.Position = UDim2.new(0.5, 0, 0, 0)
StatusRight.BackgroundTransparency = 1
StatusRight.Text = "Lua  •  UTF-8  •  Ln 1, Col 1"
StatusRight.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusRight.TextSize = 13
StatusRight.Font = Enum.Font.SourceSans
StatusRight.TextXAlignment = Enum.TextXAlignment.Right
StatusRight.Parent = StatusBar

-- Run Button
local RunButton = Instance.new("TextButton")
RunButton.Name = "RunButton"
RunButton.Size = UDim2.new(0, 80, 0, 28)
RunButton.Position = UDim2.new(1, -90, 0, 6)
RunButton.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
RunButton.BorderSizePixel = 0
RunButton.Text = "▶ Run"
RunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RunButton.TextSize = 13
RunButton.Font = Enum.Font.SourceSansBold
RunButton.Parent = TitleBar

local RunCorner = Instance.new("UICorner")
RunCorner.CornerRadius = UDim.new(0, 4)
RunCorner.Parent = RunButton

-- Variables
local scriptFunctions = {}
local lineCount = 0
local currentFunction = nil

-- Functions
local function addCodeLine(text, color)
    lineCount = lineCount + 1
    
    local LineNum = Instance.new("TextLabel")
    LineNum.Name = "Line"..lineCount
    LineNum.Size = UDim2.new(1, 0, 0, 20)
    LineNum.Position = UDim2.new(0, 0, 0, (lineCount - 1) * 20)
    LineNum.BackgroundTransparency = 1
    LineNum.Text = tostring(lineCount)
    LineNum.TextColor3 = Color3.fromRGB(133, 133, 133)
    LineNum.TextSize = 13
    LineNum.Font = Enum.Font.Code
    LineNum.TextXAlignment = Enum.TextXAlignment.Right
    LineNum.Parent = LineNumbers
    
    local CodeLine = Instance.new("TextLabel")
    CodeLine.Name = "CodeLine"..lineCount
    CodeLine.Size = UDim2.new(1, 0, 0, 20)
    CodeLine.BackgroundTransparency = 1
    CodeLine.Text = "  " .. text
    CodeLine.TextColor3 = color or Color3.fromRGB(220, 220, 220)
    CodeLine.TextSize = 13
    CodeLine.Font = Enum.Font.Code
    CodeLine.TextXAlignment = Enum.TextXAlignment.Left
    CodeLine.LayoutOrder = lineCount
    CodeLine.Parent = CodeScroll
    
    return CodeLine
end

local function clearCode()
    lineCount = 0
    for _, child in pairs(LineNumbers:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    for _, child in pairs(CodeScroll:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end

local function displayFunctionCode(funcData)
    clearCode()
    StatusLeft.Text = "Viewing: " .. funcData.name
    currentFunction = funcData
    
    addCodeLine("-- " .. funcData.description, Color3.fromRGB(106, 153, 85))
    addCodeLine("", Color3.fromRGB(220, 220, 220))
    addCodeLine("local function " .. funcData.name .. "()", Color3.fromRGB(220, 220, 170))
    addCodeLine("    -- Click 'Run' to execute", Color3.fromRGB(106, 153, 85))
    addCodeLine("    " .. funcData.description, Color3.fromRGB(206, 145, 120))
    addCodeLine("end", Color3.fromRGB(220, 220, 170))
    addCodeLine("", Color3.fromRGB(220, 220, 220))
    addCodeLine(funcData.name .. "()", Color3.fromRGB(220, 220, 170))
    
    CodeScroll.CanvasSize = UDim2.new(0, 0, 0, lineCount * 20 + 20)
    StatusRight.Text = "Lua  •  UTF-8  •  Ln " .. lineCount .. ", Col 1"
end

local function addFileToTree(icon, name, callback, order)
    local FileItem = Instance.new("TextButton")
    FileItem.Name = name
    FileItem.Size = UDim2.new(1, -10, 0, 28)
    FileItem.BackgroundColor3 = Color3.fromRGB(37, 37, 38)
    FileItem.BorderSizePixel = 0
    FileItem.Text = ""
    FileItem.AutoButtonColor = false
    FileItem.LayoutOrder = order or 0
    FileItem.Parent = FileTree
    
    local FileIcon = Instance.new("TextLabel")
    FileIcon.Size = UDim2.new(0, 25, 1, 0)
    FileIcon.Position = UDim2.new(0, 15, 0, 0)
    FileIcon.BackgroundTransparency = 1
    FileIcon.Text = icon
    FileIcon.TextSize = 14
    FileIcon.Font = Enum.Font.SourceSans
    FileIcon.Parent = FileItem
    
    local FileName = Instance.new("TextLabel")
    FileName.Size = UDim2.new(1, -45, 1, 0)
    FileName.Position = UDim2.new(0, 40, 0, 0)
    FileName.BackgroundTransparency = 1
    FileName.Text = name
    FileName.TextColor3 = Color3.fromRGB(204, 204, 204)
    FileName.TextSize = 13
    FileName.Font = Enum.Font.SourceSans
    FileName.TextXAlignment = Enum.TextXAlignment.Left
    FileName.Parent = FileItem
    
    FileItem.MouseEnter:Connect(function()
        FileItem.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
    
    FileItem.MouseLeave:Connect(function()
        FileItem.BackgroundColor3 = Color3.fromRGB(37, 37, 38)
    end)
    
    FileItem.MouseButton1Click:Connect(function()
        if callback then
            TabText.Text = name
            TabIcon.Text = icon
            callback()
        end
    end)
    
    return FileItem
end

local function updateFileTree()
    for _, child in pairs(FileTree:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    addFileToTree("📁", "src", nil, 1)
    
    for i, funcData in ipairs(scriptFunctions) do
        addFileToTree("📄", funcData.name .. ".lua", function()
            displayFunctionCode(funcData)
        end, i + 1)
    end
    
    FileTree.CanvasSize = UDim2.new(0, 0, 0, #scriptFunctions * 30 + 100)
end

local function addFunction(name, description, callback)
    table.insert(scriptFunctions, {
        name = name,
        description = description,
        callback = callback
    })
end

local isVisible = false

local function toggleGUI()
    isVisible = not isVisible
    
    if isVisible then
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(0.5, -450, -1, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0.5, -450, 0.5, -300)
        }):Play()
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0.5, -450, 1.5, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            if not isVisible then
                MainFrame.Visible = false
            end
        end)
    end
end

-- Button Actions
CloseBtn.MouseButton1Click:Connect(function()
    toggleGUI()
end)

MinBtn.MouseButton1Click:Connect(function()
    toggleGUI()
end)

MaxBtn.MouseButton1Click:Connect(function()
    if MainFrame.Size == UDim2.new(0, 900, 0, 600) then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0.95, 0, 0.95, 0),
            Position = UDim2.new(0.025, 0, 0.025, 0)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 900, 0, 600),
            Position = UDim2.new(0.5, -450, 0.5, -300)
        }):Play()
    end
end)

RunButton.MouseButton1Click:Connect(function()
    if currentFunction and currentFunction.callback then
        StatusLeft.Text = "Executing: " .. currentFunction.name
        pcall(currentFunction.callback)
        task.wait(1)
        StatusLeft.Text = "Completed: " .. currentFunction.name
    else
        StatusLeft.Text = "No function selected"
    end
end)

-- Hover Effects
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 115, 107)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 95, 87)}):Play()
end)

MinBtn.MouseEnter:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 209, 88)}):Play()
end)

MinBtn.MouseLeave:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 189, 68)}):Play()
end)

MaxBtn.MouseEnter:Connect(function()
    TweenService:Create(MaxBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 221, 84)}):Play()
end)

MaxBtn.MouseLeave:Connect(function()
    TweenService:Create(MaxBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 201, 64)}):Play()
end)

RunButton.MouseEnter:Connect(function()
    TweenService:Create(RunButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 142, 234)}):Play()
end)

RunButton.MouseLeave:Connect(function()
    TweenService:Create(RunButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 122, 204)}):Play()
end)

-- Keybind
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        toggleGUI()
    end
end)

-- Show Welcome
local function showWelcome()
    clearCode()
    addCodeLine("--[[", Color3.fromRGB(106, 153, 85))
    addCodeLine("    Welcome to VS Code Style GUI", Color3.fromRGB(106, 153, 85))
    addCodeLine("    Created for Roblox Executors", Color3.fromRGB(106, 153, 85))
    addCodeLine("", Color3.fromRGB(106, 153, 85))
    addCodeLine("    Press Right Shift to toggle", Color3.fromRGB(106, 153, 85))
    addCodeLine("    Click files to view code", Color3.fromRGB(106, 153, 85))
    addCodeLine("    Click Run to execute", Color3.fromRGB(106, 153, 85))
    addCodeLine("--]]", Color3.fromRGB(106, 153, 85))
    addCodeLine("", Color3.fromRGB(220, 220, 220))
    addCodeLine("print('Welcome!')", Color3.fromRGB(220, 220, 170))
    CodeScroll.CanvasSize = UDim2.new(0, 0, 0, lineCount * 20 + 20)
end

task.spawn(function()
    task.wait(0.5)
    toggleGUI()
    showWelcome()
    print("VS Code GUI Loaded!")
    print("Press Right Shift to toggle")
end)

-- Return API
return {
    Toggle = toggleGUI,
    AddFunction = function(name, description, callback)
        addFunction(name, description, callback)
        updateFileTree()
        StatusLeft.Text = "Added: " .. name
    end,
    SetStatus = function(text)
        StatusLeft.Text = text
    end,
    ClearFunctions = function()
        scriptFunctions = {}
        updateFileTree()
        clearCode()
        StatusLeft.Text = "Functions cleared"
    end,
    ShowWelcome = showWelcome,
    GUI = ScreenGui
}
