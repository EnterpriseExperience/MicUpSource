local Ask_GUI = Instance.new("ScreenGui")
local FullScreen_Question = Instance.new("Frame")
local Question = Instance.new("TextLabel")
local TextButton_Roundify_12px = Instance.new("ImageLabel")
local LabelTitleButton = Instance.new("TextLabel")
local NoAnswer = Instance.new("TextButton")
local TextButton_Roundify_12px_2 = Instance.new("ImageLabel")
local LabelTitleButton_2 = Instance.new("TextLabel")
local YesAnswer = Instance.new("TextButton")

Ask_GUI.Name = "Ask_GUI"
Ask_GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Ask_GUI.Enabled = false
Ask_GUI.ResetOnSpawn = false
Ask_GUI.IgnoreGuiInset = true

FullScreen_Question.Name = "FullScreen_Question"
FullScreen_Question.Parent = Ask_GUI
FullScreen_Question.Active = true
FullScreen_Question.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FullScreen_Question.BackgroundTransparency = 0.400
FullScreen_Question.BorderColor3 = Color3.fromRGB(0, 0, 0)
FullScreen_Question.BorderSizePixel = 0
FullScreen_Question.Position = UDim2.new(-9.55914743e-08, 0, 0, 0)
FullScreen_Question.Size = UDim2.new(0, 2553, 0, 796)

Question.Name = "Question"
Question.Parent = FullScreen_Question
Question.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Question.BackgroundTransparency = 1.000
Question.BorderColor3 = Color3.fromRGB(0, 0, 0)
Question.BorderSizePixel = 0
Question.Position = UDim2.new(0.175952047, 0, 0.0263819098, 0)
Question.Size = UDim2.new(0, 1033, 0, 523)
Question.Font = Enum.Font.SourceSansBold
Question.Text = "Would you like a Emote Configuration GUI?"
Question.TextColor3 = Color3.fromRGB(255, 255, 255)
Question.TextSize = 45.000
Question.TextWrapped = true
Question.TextYAlignment = Enum.TextYAlignment.Top

TextButton_Roundify_12px.Name = "TextButton_Roundify_12px"
TextButton_Roundify_12px.Parent = FullScreen_Question
TextButton_Roundify_12px.Active = true
TextButton_Roundify_12px.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_Roundify_12px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_Roundify_12px.BackgroundTransparency = 1.000
TextButton_Roundify_12px.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextButton_Roundify_12px.Position = UDim2.new(0.557562411, 0, 0.810929656, 0)
TextButton_Roundify_12px.Selectable = true
TextButton_Roundify_12px.Size = UDim2.new(0, 374, 0, 135)
TextButton_Roundify_12px.Image = "rbxassetid://3570695787"
TextButton_Roundify_12px.ImageColor3 = Color3.fromRGB(0, 0, 0)
TextButton_Roundify_12px.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_12px.SliceCenter = Rect.new(100, 100, 100, 100)
TextButton_Roundify_12px.SliceScale = 0.120

LabelTitleButton.Name = "LabelTitleButton"
LabelTitleButton.Parent = TextButton_Roundify_12px
LabelTitleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LabelTitleButton.BackgroundTransparency = 1.000
LabelTitleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
LabelTitleButton.BorderSizePixel = 0
LabelTitleButton.Position = UDim2.new(0, 0, -0.00365939667, 0)
LabelTitleButton.Size = UDim2.new(0, 374, 0, 135)
LabelTitleButton.Font = Enum.Font.SourceSansBold
LabelTitleButton.Text = "No"
LabelTitleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
LabelTitleButton.TextScaled = true
LabelTitleButton.TextSize = 14.000
LabelTitleButton.TextWrapped = true

NoAnswer.Name = "NoAnswer"
NoAnswer.Parent = TextButton_Roundify_12px
NoAnswer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NoAnswer.BackgroundTransparency = 1.000
NoAnswer.BorderColor3 = Color3.fromRGB(0, 0, 0)
NoAnswer.BorderSizePixel = 0
NoAnswer.Size = UDim2.new(0, 374, 0, 135)
NoAnswer.Font = Enum.Font.SourceSans
NoAnswer.Text = "..."
NoAnswer.TextColor3 = Color3.fromRGB(0, 0, 0)
NoAnswer.TextSize = 1.000

TextButton_Roundify_12px_2.Name = "TextButton_Roundify_12px"
TextButton_Roundify_12px_2.Parent = FullScreen_Question
TextButton_Roundify_12px_2.Active = true
TextButton_Roundify_12px_2.AnchorPoint = Vector2.new(0.5, 0.5)
TextButton_Roundify_12px_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_Roundify_12px_2.BackgroundTransparency = 1.000
TextButton_Roundify_12px_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextButton_Roundify_12px_2.Position = UDim2.new(0.198071137, 0, 0.810929656, 0)
TextButton_Roundify_12px_2.Selectable = true
TextButton_Roundify_12px_2.Size = UDim2.new(0, 374, 0, 135)
TextButton_Roundify_12px_2.Image = "rbxassetid://3570695787"
TextButton_Roundify_12px_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
TextButton_Roundify_12px_2.ScaleType = Enum.ScaleType.Slice
TextButton_Roundify_12px_2.SliceCenter = Rect.new(100, 100, 100, 100)
TextButton_Roundify_12px_2.SliceScale = 0.120

LabelTitleButton_2.Name = "LabelTitleButton"
LabelTitleButton_2.Parent = TextButton_Roundify_12px_2
LabelTitleButton_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LabelTitleButton_2.BackgroundTransparency = 1.000
LabelTitleButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
LabelTitleButton_2.BorderSizePixel = 0
LabelTitleButton_2.Position = UDim2.new(0, 0, 0.00374801061, 0)
LabelTitleButton_2.Size = UDim2.new(0, 374, 0, 135)
LabelTitleButton_2.Font = Enum.Font.SourceSansBold
LabelTitleButton_2.Text = "Yes"
LabelTitleButton_2.TextColor3 = Color3.fromRGB(0, 255, 0)
LabelTitleButton_2.TextScaled = true
LabelTitleButton_2.TextSize = 14.000
LabelTitleButton_2.TextWrapped = true

YesAnswer.Name = "YesAnswer"
YesAnswer.Parent = TextButton_Roundify_12px_2
YesAnswer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
YesAnswer.BackgroundTransparency = 1.000
YesAnswer.BorderColor3 = Color3.fromRGB(0, 0, 0)
YesAnswer.BorderSizePixel = 0
YesAnswer.Position = UDim2.new(0, 0, -0.0148148146, 0)
YesAnswer.Size = UDim2.new(0, 374, 0, 135)
YesAnswer.Font = Enum.Font.SourceSans
YesAnswer.Text = "..."
YesAnswer.TextColor3 = Color3.fromRGB(0, 0, 0)
YesAnswer.TextSize = 1.000

local function LOKR_fake_script() 
	local script = Instance.new('LocalScript', Question)

	local label = script.Parent
	
	label.Text = "Would you like a Emote Configuration GUI? Includes:\n1. Change Keybinds For Emotes/Speed/Etc\n2. Change Speed For Keybinds\n3. Unload Keybinds Script (Disables It)\n4. Ability To Save Emote Keybinds To File\n5. Loading Keybinds Config File"
end
coroutine.wrap(LOKR_fake_script)()
local function PKWSFU_fake_script()
	local script = Instance.new('LocalScript', NoAnswer)

	script.Parent.MouseButton1Click:Connect(function()
		local GUI = script.Parent.Parent.Parent.Parent
		local label = script.Parent.Parent.Parent.Question
		
		label.Text = "Okay!\n-----\nRemoving This Screen..."
		wait(0.6)
		GUI:Destroy()
	end)
end
coroutine.wrap(PKWSFU_fake_script)()
local function SDCH_fake_script()
	local script = Instance.new('LocalScript', YesAnswer)

	script.Parent.MouseButton1Click:Connect(function()
		local label = script.Parent.Parent.Parent.Question
		local GUI = script.Parent.Parent.Parent.Parent
		
		label.Text = "Okay!\n-----\nLoading Emote Configuration Manager/GUI..."
		wait(0.7)
		GUI:Destroy()
	end)
end
coroutine.wrap(SDCH_fake_script)()
local function OTVCL_fake_script()
	local script = Instance.new('LocalScript', Ask_GUI)

	if game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Ask_GUI") then
		return 
	end
end
coroutine.wrap(OTVCL_fake_script)()
