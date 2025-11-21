--[[ 
    AESTHETIC GLASS UI LIBRARY 
    Style: Modern, Transparent, Gradient, Animated
]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Setting (Animation Speed/Colors)
local Config = {
	TweenTime = 0.3,
	EasingStyle = Enum.EasingStyle.Quart,
	MainColor = Color3.fromRGB(255, 255, 255), -- สีข้อความหลัก
	AccentColor = Color3.fromRGB(0, 255, 213), -- สีธีม (Cyan Neon)
	GlassColor = Color3.fromRGB(20, 20, 20),   -- สีพื้นหลังกระจก
	Transparency = 0.2                         -- ความโปร่งใส (ยิ่งน้อยยิ่งใส)
}

-- Utility Functions
local function Tween(obj, props, time)
	local info = TweenInfo.new(time or Config.TweenTime, Config.EasingStyle, Enum.EasingDirection.Out)
	local tween = TweenService:Create(obj, info, props)
	tween:Play()
	return tween
end

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		Tween(object, {Position = pos}, 0.1)
	end

	topbarobject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	topbarobject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

-- Create Window Function
function Library:CreateWindow(Settings)
	local WinName = Settings.Name or "UI Library"
	
	-- Main ScreenGui
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "GlassLibrary"
	ScreenGui.ResetOnSpawn = false
	
	-- Check protection
	if syn and syn.protect_gui then
		syn.protect_gui(ScreenGui)
		ScreenGui.Parent = CoreGui
	elseif gethui then
		ScreenGui.Parent = gethui()
	else
		ScreenGui.Parent = CoreGui
	end

	-- Main Frame (The Glass Window)
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 500, 0, 350)
	MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
	MainFrame.BackgroundColor3 = Config.GlassColor
	MainFrame.BackgroundTransparency = Config.Transparency
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true -- Important for effects
	MainFrame.Parent = ScreenGui

	-- Styling: Corners
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = MainFrame

	-- Styling: Gradient Stroke (ขอบเรืองแสงไล่สี)
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Parent = MainFrame
	UIStroke.Thickness = 2
	UIStroke.Transparency = 0.3
	
	local StrokeGradient = Instance.new("UIGradient")
	StrokeGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Config.AccentColor),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255)) -- ไล่สีไปม่วง
	}
	StrokeGradient.Rotation = 45
	StrokeGradient.Parent = UIStroke
	
	-- Animating the Border Rotation
	spawn(function()
		while true do
			local tw = TweenService:Create(StrokeGradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {Rotation = StrokeGradient.Rotation + 360})
			tw:Play()
			tw.Completed:Wait()
		end
	end)

	-- Header / Title
	local Header = Instance.new("Frame")
	Header.Size = UDim2.new(1, 0, 0, 40)
	Header.BackgroundTransparency = 1
	Header.Parent = MainFrame
	
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Text = WinName
	TitleLabel.Size = UDim2.new(1, -20, 1, 0)
	TitleLabel.Position = UDim2.new(0, 20, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.TextColor3 = Config.MainColor
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 18
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = Header

	MakeDraggable(Header, MainFrame)

	-- Container for Elements
	local Container = Instance.new("ScrollingFrame")
	Container.Name = "Container"
	Container.Size = UDim2.new(1, -20, 1, -50)
	Container.Position = UDim2.new(0, 10, 0, 45)
	Container.BackgroundTransparency = 1
	Container.ScrollBarThickness = 2
	Container.ScrollBarImageColor3 = Config.AccentColor
	Container.Parent = MainFrame
	
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Container

	-- Intro Animation
	MainFrame.Transform = CFrame.new(0, 50, 0)
	MainFrame.BackgroundTransparency = 1
	Tween(MainFrame, {BackgroundTransparency = Config.Transparency}, 0.5)
	
	-- Custom Tween for CFrame/Transform needs a wrapper, simpler to use Position/Size pop
	local OriginalSize = MainFrame.Size
	MainFrame.Size = UDim2.new(0,0,0,0)
	Tween(MainFrame, {Size = OriginalSize}, 0.6)

	-- Internal Functions
	local Elements = {}

	function Elements:CreateButton(ButtonSettings)
		local BName = ButtonSettings.Name or "Button"
		local BCallback = ButtonSettings.Callback or function() end

		local ButtonFrame = Instance.new("Frame")
		ButtonFrame.Name = "Button"
		ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonFrame.BackgroundTransparency = 0.95 -- Very subtle background
		ButtonFrame.Parent = Container

		local BtnCorner = Instance.new("UICorner")
		BtnCorner.CornerRadius = UDim.new(0, 6)
		BtnCorner.Parent = ButtonFrame

		local BtnTrigger = Instance.new("TextButton")
		BtnTrigger.Size = UDim2.new(1, 0, 1, 0)
		BtnTrigger.BackgroundTransparency = 1
		BtnTrigger.Text = "  " .. BName
		BtnTrigger.TextColor3 = Config.MainColor
		BtnTrigger.Font = Enum.Font.Gotham
		BtnTrigger.TextSize = 14
		BtnTrigger.TextXAlignment = Enum.TextXAlignment.Left
		BtnTrigger.Parent = ButtonFrame
		
		-- Icon/Indicator
		local Indicator = Instance.new("Frame")
		Indicator.Size = UDim2.new(0, 3, 0, 15)
		Indicator.Position = UDim2.new(0, 0, 0.5, -7.5)
		Indicator.BackgroundColor3 = Config.AccentColor
		Indicator.BackgroundTransparency = 1 -- Hidden by default
		Indicator.Parent = ButtonFrame
		local IndCorner = Instance.new("UICorner")
		IndCorner.CornerRadius = UDim.new(0,4)
		IndCorner.Parent = Indicator

		-- Hover Effects
		BtnTrigger.MouseEnter:Connect(function()
			Tween(ButtonFrame, {BackgroundTransparency = 0.85})
			Tween(Indicator, {BackgroundTransparency = 0})
			Tween(BtnTrigger, {TextTransparency = 0.2})
		end)

		BtnTrigger.MouseLeave:Connect(function()
			Tween(ButtonFrame, {BackgroundTransparency = 0.95})
			Tween(Indicator, {BackgroundTransparency = 1})
			Tween(BtnTrigger, {TextTransparency = 0})
		end)

		BtnTrigger.MouseButton1Click:Connect(function()
			-- Click Animation (Scale punch)
			Tween(ButtonFrame, {Size = UDim2.new(0.98, 0, 0, 33)}, 0.05).Completed:Wait()
			Tween(ButtonFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.05)
			BCallback()
		end)
	end

	function Elements:CreateToggle(ToggleSettings)
		local TName = ToggleSettings.Name or "Toggle"
		local TDefault = ToggleSettings.CurrentValue or false
		local TCallback = ToggleSettings.Callback or function() end
		local TState = TDefault

		local ToggleFrame = Instance.new("Frame")
		ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
		ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleFrame.BackgroundTransparency = 0.95
		ToggleFrame.Parent = Container
		
		local TgCorner = Instance.new("UICorner")
		TgCorner.CornerRadius = UDim.new(0, 6)
		TgCorner.Parent = ToggleFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -50, 1, 0)
		Label.Position = UDim2.new(0, 10, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Text = TName
		Label.TextColor3 = Config.MainColor
		Label.Font = Enum.Font.Gotham
		Label.TextSize = 14
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = ToggleFrame

		-- Switch Visual
		local SwitchBg = Instance.new("Frame")
		SwitchBg.Size = UDim2.new(0, 40, 0, 20)
		SwitchBg.Position = UDim2.new(1, -50, 0.5, -10)
		SwitchBg.BackgroundColor3 = TState and Config.AccentColor or Color3.fromRGB(60,60,60)
		SwitchBg.Parent = ToggleFrame
		
		local SwCorner = Instance.new("UICorner")
		SwCorner.CornerRadius = UDim.new(1, 0)
		SwCorner.Parent = SwitchBg
		
		local Circle = Instance.new("Frame")
		Circle.Size = UDim2.new(0, 16, 0, 16)
		Circle.Position = TState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		Circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Circle.Parent = SwitchBg
		
		local CirCorner = Instance.new("UICorner")
		CirCorner.CornerRadius = UDim.new(1, 0)
		CirCorner.Parent = Circle

		local Button = Instance.new("TextButton")
		Button.Size = UDim2.new(1, 0, 1, 0)
		Button.BackgroundTransparency = 1
		Button.Text = ""
		Button.Parent = ToggleFrame

		local function UpdateToggle()
			TState = not TState
			
			-- Animations
			if TState then
				Tween(SwitchBg, {BackgroundColor3 = Config.AccentColor})
				Tween(Circle, {Position = UDim2.new(1, -18, 0.5, -8)})
			else
				Tween(SwitchBg, {BackgroundColor3 = Color3.fromRGB(60,60,60)})
				Tween(Circle, {Position = UDim2.new(0, 2, 0.5, -8)})
			end
			
			TCallback(TState)
		end

		Button.MouseButton1Click:Connect(UpdateToggle)
	end
	
	-- Auto resize container
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
	end)

	return Elements
end

return Library
