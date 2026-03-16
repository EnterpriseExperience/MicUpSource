local VoiceChatService = game:GetService("VoiceChatService")
local VoiceChatInternal = game:GetService("VoiceChatInternal")
local CoreGui = game:GetService("CoreGui")
local MUTED_IMAGE = "rbxasset://textures/ui/VoiceChat/MicLight/Muted.png"
local REJOIN_COUNT = 4
local REJOIN_DELAY = 5
local CurrentlyMuted = true
local TopBarApp = CoreGui:WaitForChild("TopBarApp"):WaitForChild("TopBarApp")
local MicPath = CoreGui:FindFirstChild("toggle_mic_mute", true)
while not MicPath do
	task.wait()
	MicPath = CoreGui:FindFirstChild("toggle_mic_mute", true)
end

local MicContainer = MicPath.Parent

if not getgenv().toggle_mic_muter_icon_found_descendant then
	getgenv().toggle_mic_muter_icon_found_descendant = true
	CoreGui.DescendantAdded:Connect(function(v)
		if v.Name == "toggle_mic_mute" then
			MicPath = v
			MicContainer = v.Parent
		end
	end)
end

local function get_mic_icon(button)
	button = button or MicPath
	if not button then
		return
	end
	return button:FindFirstChild("1", true)
end

local function create_unmute_prompt()
	local label = Instance.new("TextLabel")
	label.Text = "Please unmute your microphone to continue."
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1,0,0.03,0)
	label.AnchorPoint = Vector2.new(0.5,0.5)
	label.Position = UDim2.new(0.5,0,0.5,0)
	label.TextScaled = true
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.Parent = TopBarApp
	return label
end

local function ensure_voice_joined()
	if not VoiceChatService:IsVoiceEnabledForUserIdAsync(game.Players.LocalPlayer.UserId) then
		return
	end
	VoiceChatService:joinVoice()
end

local function cycle_voice_connections()
	local groupId = VoiceChatInternal:GetGroupId()

	VoiceChatInternal:JoinByGroupId(groupId,true)
	VoiceChatService:leaveVoice()

	task.wait()

	for _ = 1, REJOIN_COUNT do
		VoiceChatInternal:JoinByGroupId(groupId,true)
	end

	task.wait(REJOIN_DELAY)

	VoiceChatService:joinVoice()
	VoiceChatInternal:JoinByGroupId(groupId,true)
end

local function replace_mic_button()
	MicPath.Visible = false

	local newMic = MicPath:Clone()
	newMic.Name = "toggle_mic_mute_new"
	newMic.Visible = true
	newMic.Parent = MicContainer

	return newMic
end

local function watch_old_mic(newMic)
	local visibilityConn
	local destroyConn

	visibilityConn = MicPath:GetPropertyChangedSignal("Visible"):Connect(function()
		if MicPath.Visible then
			if newMic then
				newMic:Destroy()
			end
		end
	end)

	destroyConn = MicPath.Destroying:Connect(function()
		if newMic then
			newMic:Destroy()
		end
	end)

	newMic.Destroying:Connect(function()
		if visibilityConn then visibilityConn:Disconnect() end
		if destroyConn then destroyConn:Disconnect() end
	end)
end

local function setup_mic_toggle(newMic)
	local icon = get_mic_icon(newMic)
	while not icon do
		task.wait()
		icon = get_mic_icon(newMic)
	end

	local hitArea = newMic:FindFirstChild("IconHitArea_toggle_mic_mute", true)
	while not hitArea do
		task.wait()
		hitArea = newMic:FindFirstChild("IconHitArea_toggle_mic_mute", true)
	end

	local highlighter = newMic:FindFirstChild("Highlighter", true)

	if highlighter then
		highlighter.Visible = false
	end

	icon.Image = MUTED_IMAGE
	VoiceChatInternal:PublishPause(true)
	CurrentlyMuted = true

	hitArea.MouseEnter:Connect(function()
		if highlighter then
			highlighter.Visible = true
		end
	end)

	hitArea.MouseLeave:Connect(function()
		if highlighter then
			highlighter.Visible = false
		end
	end)

	hitArea.Activated:Connect(function()
		CurrentlyMuted = not CurrentlyMuted
		VoiceChatInternal:PublishPause(CurrentlyMuted)

		if CurrentlyMuted then
			icon.Image = MUTED_IMAGE
		else
			icon.Image = ""
		end
	end)
end

ensure_voice_joined()

local prompt = create_unmute_prompt()
task.wait(2)
prompt:Destroy()

cycle_voice_connections()

local newMic = replace_mic_button()
watch_old_mic(newMic)
setup_mic_toggle(newMic)
