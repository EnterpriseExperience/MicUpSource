local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local TextChatService = cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")

getgenv().Commands_Loaded = getgenv().Commands_Loaded or false
if getgenv().Commands_Loaded then
	return warn("[LocalPlayer_Commands DEBUG]: Already loaded.")
end
getgenv().Commands_Loaded = true

local Default_Prefix = ";"
local UserPrefixes = {}

local function Command_LocalPlayer(name)
	if not name then return false end
	local lower = name:lower():gsub("%s+", "")
	local myName = LocalPlayer.Name:lower()
	local myDisplay = LocalPlayer.DisplayName:lower()
	return lower == "me"
		or lower == myName
		or lower == myDisplay
		or myName:sub(1, #lower) == lower
		or myDisplay:sub(1, #lower) == lower
end

local function SplitString(str)
	local parts = {}
	for word in str:gmatch("%S+") do
		table.insert(parts, word)
	end
	return parts
end

local function HandleMessage(sender, message)
	if typeof(sender) ~= "Instance" or not sender:IsA("Player") then return end
	if sender == LocalPlayer then return end

	if message:sub(1, 3):lower() == "/e " then
		message = message:sub(4)
	end

	local prefix = UserPrefixes[sender.UserId] or Default_Prefix
	if not (message:sub(1, #prefix) == prefix) then return end

	local args = SplitString(message:sub(#prefix + 1))
	local cmd = args[1] and args[1]:lower()
	local target = args[2]
	local value = tonumber(args[3])

	if cmd == "prefix" and args[2] and #args[2] == 1 then
		UserPrefixes[sender.UserId] = args[2]
		return warn(sender.Name .. " set their prefix to: " .. args[2])
	end

	if not (cmd and target and value and Command_LocalPlayer(target)) then return end

	if cmd == "speed" or cmd == "ws" then
		Humanoid.WalkSpeed = value
	elseif cmd == "jumppower" or cmd == "jumpheight" or cmd == "jp" then
		if Humanoid.UseJumpPower then
			Humanoid.JumpPower = value
		else
			Humanoid.JumpHeight = value
		end
	elseif cmd == "hipheight" then
		Humanoid.HipHeight = value
    elseif cmd == "gr" or cmd == "gravity" then
        Workspace.Gravity = value
	elseif cmd == "sit" then
		Humanoid.Sit = (value ~= 0)
	end

	print("[LocalPlayer_Commands]: Executed command '" .. cmd .. "' from " .. sender.Name)
end

print("[LocalPlayer_Commands]: Initializing command listener...")

TextChatService.OnIncomingMessage = function(msg)
	local textSource = msg.TextSource
	if not textSource then return end

	local userId = textSource.UserId
	local player = Players:GetPlayerByUserId(userId)
	if player then
		HandleMessage(player, msg.Text)
	end
end

for _, plr in ipairs(Players:GetPlayers()) do
	plr.Chatted:Connect(function(msg)
		HandleMessage(plr, msg)
	end)
end

Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		HandleMessage(plr, msg)
	end)
end)

print("[LocalPlayer_Commands]: Ready. Waiting for chat commands...")
