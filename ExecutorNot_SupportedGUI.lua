local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local uis = game:GetService("UserInputService")
local core = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local http_requesting = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local AllClipboards = setclipboard or toclipboard or set_clipboard or Clipboard and Clipboard.set
if core:FindFirstChild("Current_Context_Not_Supported_GUI") and core:FindFirstChild("Current_Context_Not_Supported_GUI"):IsA("ScreenGui") then return end
local scr = Instance.new("ScreenGui")
scr.Name = "Current_Context_Not_Supported_GUI"
scr.ResetOnSpawn = false
scr.IgnoreGuiInset = true
scr.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
scr.Parent = core

local is_mob = uis.TouchEnabled
local fr = Instance.new("Frame")
fr.Name = "MainFrame"
fr.Size = is_mob and UDim2.new(0.300000012, 0, 0.449999988, 0) or UDim2.new(0.6,0,0.6,0)
fr.Position = is_mob and UDim2.new(0.05,0,0.27,0) or UDim2.new(0.2,0,0.2,0)
fr.BackgroundColor3 = Color3.fromRGB(25,25,25)
fr.BorderSizePixel = 0
fr.Parent = scr

local cr = Instance.new("UICorner")
cr.CornerRadius = UDim.new(0,12)
cr.Parent = fr

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
msg.Text = "This executor cannot run this script, we are terribly sorry!"
msg.TextScaled = true
msg.Font = Enum.Font.SourceSansSemibold
msg.TextColor3 = Color3.fromRGB(255,255,255)
msg.Parent = fr

local sub = Instance.new("TextLabel")
sub.Name = "CreditLabel"
sub.Size = is_mob and UDim2.new(1,-20,0,35) or UDim2.new(1,-40,0,50)
sub.Position = is_mob and UDim2.new(0,10,0.33,40) or UDim2.new(0,20,0.4,50)
sub.BackgroundTransparency = 1
sub.Text = "https://discord.gg/MTYKxQfpNJ"
sub.TextScaled = true
sub.Font = Enum.Font.SourceSans
sub.TextColor3 = Color3.fromRGB(180,180,180)
sub.Parent = fr

local btn = Instance.new("TextButton")
btn.Name = "DiscordButton"
btn.Size = is_mob and UDim2.new(0.55,0,0,28) or UDim2.new(0.45,0,0,38)
btn.Position = is_mob and UDim2.new(0.225,0,0.33,85) or UDim2.new(0.275,0,0.4,105)
btn.BackgroundColor3 = Color3.fromRGB(88,101,242)
btn.Text = "Join Discord"
btn.TextScaled = true
btn.Font = Enum.Font.SourceSansBold
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.BorderSizePixel = 0
btn.Parent = fr

local cr3 = Instance.new("UICorner")
cr3.CornerRadius = UDim.new(0,8)
cr3.Parent = btn

cls.MouseButton1Click:Connect(function()
    scr:Destroy()
end)

btn.MouseButton1Click:Connect(function()
    if http_requesting then
        http_requesting({
            Url = 'http://127.0.0.1:6463/rpc?v=1',
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json',
                Origin = 'https://discord.com'
            },
            Body = HttpService:JSONEncode({
                cmd = 'INVITE_BROWSER',
                nonce = HttpService:GenerateGUID(false),
                args = {code = 'MTYKxQfpNJ'}
            })
        })
    else
        if AllClipboards then AllClipboards("https://discord.gg/MTYKxQfpNJ") end
        if getgenv().notify then getgenv().notify("Success", "Successfully copied Discord link to Clipboard.", 5) end
    end
end)

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
