--[[
    ElegantUI - A modern, glassmorphism-style UI Library for Roblox
    เวอร์ชัน: 1.0.0
]]

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local ElegantUI = {}
ElegantUI.__index = ElegantUI

-- สีและสไตล์หลัก (สามารถปรับแต่งได้)
local THEME = {
	BackgroundColor = Color3.fromRGB(25, 25, 25),
	BackgroundTransparency = 0.15,
	
	AccentColor = Color3.fromRGB(100, 160, 255),
	
	StrokeColor = Color3.fromRGB(120, 120, 120),
	StrokeTransparency = 0.5,
	
	ShadowColor = Color3.fromRGB(0, 0, 0),
	ShadowTransparency = 0.6,
	
	TextColor = Color3.fromRGB(240, 240, 240),
	
	CornerRadius = 8,
	StrokeThickness = 1,
}

-- ||----- Utility Functions -----||

local function Create(instanceType, properties)
	local inst = Instance.new(instanceType)
	for prop, value in pairs(properties or {}) do
		inst[prop] = value
	end
	return inst
end

local function ApplyGlassmorphism(frame)
	Create("UICorner", {
		CornerRadius = UDim.new(0, THEME.CornerRadius),
		Parent = frame,
	})
	
	Create("UIStroke", {
		Color = THEME.StrokeColor,
		Transparency = THEME.StrokeTransparency,
		Thickness = THEME.StrokeThickness,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = frame,
	})
	
	Create("UIShadow", {
		Transparency = THEME.ShadowTransparency,
		Color = THEME.ShadowColor,
		Size = 8,
		Offset = Vector2.new(0, 2),
		Parent = frame,
	})
	
	frame.BackgroundColor3 = THEME.BackgroundColor
	frame.BackgroundTransparency = THEME.BackgroundTransparency
	frame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- ซ่อน Border หลัก
	frame.BorderSizePixel = 0
end

local function MakeDraggable(gui)
	local dragging
	local dragInput
	local dragStart
	local startPos

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	RunService.InputBMS:Connect(function(dt)
		if dragging and dragInput then
			local delta = dragInput.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end


-- ||----- Tab Class -----||

local Tab = {}
Tab.__index = Tab

function Tab:AddToggle(text, callback)
	local state = false
	callback = callback or function() end

	local toggleFrame = Create("Frame", {
		Name = "ToggleFrame",
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		Parent = self.Container,
	})

	local label = Create("TextLabel", {
		Name = "Label",
		Size = UDim2.new(0.7, -5, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = THEME.TextColor,
		Font = Enum.Font.SourceSans,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = toggleFrame,
	})

	local switchButton = Create("TextButton", {
		Name = "SwitchButton",
		Size = UDim2.new(0, 50, 0, 20),
		Position = UDim2.new(1, -50, 0.5, -10),
		Text = "",
		BackgroundColor3 = Color3.fromRGB(60, 60, 60),
		Parent = toggleFrame,
	})
	
	Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = switchButton })

	local indicator = Create("Frame", {
		Name = "Indicator",
		Size = UDim2.new(0, 16, 0, 16),
		Position = UDim2.new(0, 2, 0.5, -8),
		BackgroundColor3 = Color3.fromRGB(220, 220, 220),
		BorderSizePixel = 0,
		Parent = switchButton,
	})
	
	Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = indicator })

	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	switchButton.MouseButton1Click:Connect(function()
		state = not state
		
		local indicatorPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		local switchColor = state and THEME.AccentColor or Color3.fromRGB(60, 60, 60)
		
		TweenService:Create(indicator, tweenInfo, { Position = indicatorPos }):Play()
		TweenService:Create(switchButton, tweenInfo, { BackgroundColor3 = switchColor }):Play()
		
		task.spawn(callback, state)
	end)

	return self -- เพื่อให้สามารถ chain function ได้ (ถ้าต้องการ)
end

function Tab:AddDropdown(text, options, callback)
	options = options or {}
	callback = callback or function() end
	local isOpen = false

	local dropdownFrame = Create("Frame", {
		Name = "DropdownFrame",
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		Parent = self.Container,
		ZIndex = 2,
	})

	local label = Create("TextLabel", {
		Name = "Label",
		Size = UDim2.new(0.5, -5, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = THEME.TextColor,
		Font = Enum.Font.SourceSans,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = dropdownFrame,
	})

	local selectedButton = Create("TextButton", {
		Name = "SelectedButton",
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		Text = (options[1] or "Select...") .. " ▼",
		Font = Enum.Font.SourceSans,
		TextSize = 16,
		TextColor3 = THEME.TextColor,
		BackgroundColor3 = THEME.BackgroundColor,
		BackgroundTransparency = 0.2,
		ZIndex = 3,
		Parent = dropdownFrame,
	})
	ApplyGlassmorphism(selectedButton)
	selectedButton:FindFirstChild("UIShadow"):Destroy() -- ไม่ต้องการเงาซ้อน

	local optionsFrame = Create("ScrollingFrame", {
		Name = "OptionsFrame",
		Size = UDim2.new(0.5, 0, 0, math.min(#options * 25, 100)), -- ขนาด 100 คือ max height
		Position = UDim2.new(0.5, 0, 1, 5),
		BackgroundColor3 = THEME.BackgroundColor,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 4,
		Parent = dropdownFrame,
		ScrollBarThickness = 4,
	})
	ApplyGlassmorphism(optionsFrame)

	local listLayout = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 2),
		Parent = optionsFrame,
	})

	for i, optionName in ipairs(options) do
		local optionButton = Create("TextButton", {
			Name = optionName,
			Size = UDim2.new(1, 0, 0, 25),
			Text = "  " .. optionName,
			Font = Enum.Font.SourceSans,
			TextSize = 14,
			TextColor3 = THEME.TextColor,
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = i,
			ZIndex = 5,
			Parent = optionsFrame,
		})
		
		-- Hover Effect
		optionButton.MouseEnter:Connect(function()
			optionButton.BackgroundTransparency = 0.8
			optionButton.BackgroundColor3 = THEME.AccentColor
		end)
		optionButton.MouseLeave:Connect(function()
			optionButton.BackgroundTransparency = 1
		end)

		optionButton.MouseButton1Click:Connect(function()
			selectedButton.Text = optionName .. " ▼"
			isOpen = false
			optionsFrame.Visible = false
			dropdownFrame.ZIndex = 2 -- Reset ZIndex
			task.spawn(callback, optionName)
		end)
	end
	
	selectedButton.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		optionsFrame.Visible = isOpen
		dropdownFrame.ZIndex = isOpen and 10 or 2 -- ทำให้ Dropdown อยู่เหนือสุดตอนเปิด
	end)

	return self
end


-- ||----- Window Class -----||

function ElegantUI.new(title)
	local self = setmetatable({}, ElegantUI)
	
	self.Tabs = {}
	self.ActiveTab = nil
	self.Title = title or "ElegantUI"

	-- 1. Create ScreenGui
	self.ScreenGui = Create("ScreenGui", {
		Name = "ElegantUIScreenGui",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})

	-- 2. Create Main Window Frame
	self.Window = Create("Frame", {
		Name = "MainWindow",
		Size = UDim2.new(0, 450, 0, 300),
		Position = UDim2.new(0.5, -225, 0.5, -150),
		Parent = self.ScreenGui,
	})
	ApplyGlassmorphism(self.Window)
	MakeDraggable(self.Window)

	-- 3. Create Title Bar
	local titleBar = Create("TextLabel", {
		Name = "TitleBar",
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
		Font = Enum.Font.SourceSansSemibold,
		Text = self.Title,
		TextSize = 18,
		TextColor3 = THEME.TextColor,
		Parent = self.Window,
	})
	
	-- เส้นแบ่งใต้ Title
	Create("Frame", {
		Name = "TitleSeparator",
		Size = UDim2.new(1, -20, 0, 1),
		Position = UDim2.new(0.5, -((450-20)/2), 0, 30),
		BackgroundColor3 = THEME.StrokeColor,
		BackgroundTransparency = THEME.StrokeTransparency,
		BorderSizePixel = 0,
		Parent = self.Window,
	})

	-- 4. Create Tab Container
	self.TabContainer = Create("Frame", {
		Name = "TabContainer",
		Size = UDim2.new(1, -20, 0, 30),
		Position = UDim2.new(0.5, -((450-20)/2), 0, 40),
		BackgroundTransparency = 1,
		Parent = self.Window,
	})
	
	Create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 5),
		Parent = self.TabContainer,
	})

	-- 5. Create Content Container
	self.ContentContainer = Create("Frame", {
		Name = "ContentContainer",
		Size = UDim2.new(1, -20, 1, -85), -- 30(Title) + 10(Padding) + 30(Tabs) + 15(Padding)
		Position = UDim2.new(0.5, -((450-20)/2), 0, 85),
		BackgroundTransparency = 1,
		Parent = self.Window,
	})
	
	-- 6. Padding ภายใน Content
	Create("UIPadding", {
		PaddingTop = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
		Parent = self.ContentContainer,
	})

	return self
end

function ElegantUI:AddTab(name)
	local tab = setmetatable({}, Tab)
	
	-- Create Tab Page (Content Frame)
	local tabPage = Create("Frame", {
		Name = name .. "Page",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Visible = false,
		Parent = self.ContentContainer,
	})
	
	Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 10),
		Parent = tabPage,
	})

	tab.Page = tabPage
	tab.Container = tabPage -- ที่สำหรับใส่ Components
	tab.Name = name

	-- Create Tab Button
	local tabButton = Create("TextButton", {
		Name = name .. "Button",
		Size = UDim2.new(0, 80, 1, 0),
		Text = name,
		Font = Enum.Font.SourceSans,
		TextSize = 16,
		TextColor3 = THEME.TextColor,
		BackgroundColor3 = THEME.BackgroundColor,
		BackgroundTransparency = 0.5, -- สีจาง (Idle)
		LayoutOrder = #self.Tabs + 1,
		Parent = self.TabContainer,
	})
	ApplyGlassmorphism(tabButton)
	tabButton:FindFirstChild("UIShadow"):Destroy() -- ไม่ต้องการเงา
	
	tab.Button = tabButton
	
	-- Logic การสลับ Tab
	local function activateTab()
		-- Deactivate แท็บเก่า
		if self.ActiveTab then
			self.ActiveTab.Page.Visible = false
			self.ActiveTab.Button.BackgroundTransparency = 0.5 -- สีจาง (Idle)
			self.ActiveTab.Button.TextColor3 = THEME.TextColor
		end
		
		-- Activate แท็บใหม่
		tab.Page.Visible = true
		tab.Button.BackgroundTransparency = 0.2 -- สีเข้ม (Active)
		tab.Button.TextColor3 = THEME.AccentColor
		
		self.ActiveTab = tab
	end
	
	tabButton.MouseButton1Click:Connect(activateTab)
	
	table.insert(self.Tabs, tab)
	
	-- ถ้าเป็นแท็บแรก ให้เปิดใช้งานเลย
	if #self.Tabs == 1 then
		activateTab()
	end
	
	return tab
end

function ElegantUI:Destroy()
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
	
	-- Clear references
	for k in pairs(self) do
		self[k] = nil
	end
	setmetatable(self, nil)
end


return ElegantUI
