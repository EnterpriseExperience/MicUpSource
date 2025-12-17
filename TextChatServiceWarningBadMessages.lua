local uis = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local tcs = cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")
local core = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = getgenv().LocalPlayer or Players.LocalPlayer
local scr = Instance.new("ScreenGui")
scr.Name = "ExecutorInterface"
scr.ResetOnSpawn = false
scr.IgnoreGuiInset = true
if not scr.Enabled then
    pcall(function() scr.Enabled = true end)
end
scr.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
scr.Parent = core

local is_mob = uis.TouchEnabled
local fr = Instance.new("Frame")
fr.Name = "MainFrame"
fr.Size = is_mob and UDim2.new(0.300000012, 0, 0.449999988, 0) or UDim2.new(0.6,0,0.6,0)
fr.Position = is_mob and UDim2.new(0.05,0,0.27,0) or UDim2.new(0.200000003, 405, 0.200000003, 84)
fr.BackgroundColor3 = Color3.fromRGB(25,25,25)
fr.BorderSizePixel = 0
fr.Parent = scr
fr.Visible = false

local cr = Instance.new("UICorner")
cr.CornerRadius = UDim.new(0,12)
cr.Parent = fr

local ar = Instance.new("UIAspectRatioConstraint")
ar.AspectRatio = 1.2
ar.Parent = fr

local cls = Instance.new("TextButton")
cls.Name = "CloseButton"
cls.Size = is_mob and UDim2.new(0,26,0,26) or UDim2.new(0,30,0,30)
cls.Position = is_mob and UDim2.new(1,-30,0,4) or UDim2.new(1,-35,0,5)
cls.BackgroundColor3 = Color3.fromRGB(255,50,50)
cls.Text = "X"
cls.TextScaled = true
cls.Font = Enum.Font.SourceSansBold
cls.TextColor3 = Color3.fromRGB(255,255,255)
cls.BorderSizePixel = 0
cls.Parent = fr

local cr2 = Instance.new("UICorner")
cr2.CornerRadius = UDim.new(1,0)
cr2.Parent = cls

local msg = Instance.new("TextLabel")
msg.Name = "MainMessage"
msg.Size = is_mob and UDim2.new(1,-20,0,70) or UDim2.new(1,-40,0,100)
msg.Position = is_mob and UDim2.new(0,10,0.33,-35) or UDim2.new(0,20,0.4,-60)
msg.BackgroundTransparency = 1
msg.Text = "Saying this and things like it can get you BANNED if somebody reports you! Be careful!"
msg.TextColor3 = Color3.fromRGB(255,70,70)
msg.TextScaled = true
msg.Font = Enum.Font.SourceSansBold
msg.Parent = fr

local tc = Instance.new("UITextSizeConstraint")
tc.MaxTextSize = is_mob and 22 or 32
tc.MinTextSize = 12
tc.Parent = msg

local sub = Instance.new("TextLabel")
sub.Name = "CreditLabel"
sub.Size = is_mob and UDim2.new(1,-20,0,35) or UDim2.new(1,-40,0,50)
sub.Position = is_mob and UDim2.new(0,10,0.33,40) or UDim2.new(0,20,0.4,50)
sub.BackgroundTransparency = 1
sub.Text = "Made by: computerbinaries on Discord."
sub.TextScaled = true
sub.Font = Enum.Font.SourceSans
sub.TextColor3 = Color3.fromRGB(180,180,180)
sub.Parent = fr

local titl = Instance.new("TextLabel")
titl.Name = "CreditLabel"
titl.Size = is_mob and UDim2.new(1,-20,0,35) or UDim2.new(1,-40,0,50)
titl.AnchorPoint = Vector2.new(0.5, 0)
titl.Position = is_mob and UDim2.new(0.5, 0, 0, 45) or UDim2.new(0.5, 0, 0, 50)
titl.BackgroundTransparency = 1
titl.Text = "Flames Hub | Text Chat advisory and warnings."
titl.TextScaled = true
titl.Font = Enum.Font.SourceSans
titl.TextColor3 = Color3.fromRGB(0, 255, 0)
titl.Parent = fr

cls.MouseButton1Click:Connect(function()
    if scr then
        if fr and fr:IsA("Frame") then
            pcall(function() fr.Visible = false end)
        end
    end
end)

local flagged = {
    "fuck","wtf","tf","wdf"
}

if not getgenv().setup_chat_connection_hashtags_stuff then
    tcs.MessageReceived:Connect(function(m)
        if not m.Text then return end
        local sender = Players:GetPlayerByUserId(m.UserId)
        if sender ~= Players.LocalPlayer then return end
        local txt = m.Text:lower()
        if txt:find("#") then return end

        for _, w in ipairs(flagged) do
            if txt:find(w) then
                if fr and fr:IsA("Frame") then
                    task.spawn(function()
                        fr.Visible = true
                        task.wait(10)
                        fr.Visible = false
                    end)
                end
                break
            end
        end
    end)

    wait(0.1)

    getgenv().setup_chat_connection_hashtags_stuff = true
end

local UIS = uis
local function dragify(Frame)
	dragToggle = nil
	dragSpeed = 0.15
	dragInput = nil
	dragStart = nil
	dragPos = nil
	function updateInput(input)
		Delta = input.Position - dragStart
		Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.15), {Position = Position}):Play()
	end
	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	Frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
end

dragify(fr)
