local Flames_API = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua'))()
local Players = Flames_API.Service("Players")
local TextChatService = Flames_API.Service("TextChatService")
local Workspace = Flames_API.Service("Workspace")
local LocalPlayer = Flames_API.LocalPlayer
local Character = Flames_API.Character
local Humanoid = Flames_API.Humanoid
local HumanoidRootPart = Flames_API.HumanoidRootPart

getgenv().Commands_Loaded = getgenv().Commands_Loaded or false
if getgenv().Commands_Loaded then
	return warn("[LocalPlayer_Commands DEBUG]: Already loaded.")
end
getgenv().Commands_Loaded = true

local Prefixes_Folder = "CommandUserPrefixs"

local function safe_isfolder(path)
	return typeof(isfolder) == "function" and isfolder(path) or false
end

local function safe_makefolder(path)
	if typeof(makefolder) == "function" then
		pcall(makefolder, path)
	end
end

local function safe_isfile(path)
	return typeof(isfile) == "function" and isfile(path) or false
end

local function safe_writefile(path, content)
	if typeof(writefile) == "function" then
		pcall(writefile, path, content)
	end
end

local function safe_readfile(path)
	if typeof(readfile) == "function" then
		local ok, data = pcall(readfile, path)
		if ok then return data end
	end
	return nil
end

if typeof(isfolder) == "function" then
	if not safe_isfolder(Prefixes_Folder) then
		safe_makefolder(Prefixes_Folder)
	end
else
	warn("[LocalPlayer-Commands]:", "User prefix's will not save, file system unsupported.")
end

local function user_prefix_folder(user)
	if not user then return end
	local path = Prefixes_Folder.."/"..tostring(user.Name)
	if not safe_isfolder(path) then
		safe_makefolder(path)
	end
	return safe_isfolder(path)
end

local function save_user_prefix(user, prefix)
	if not user then return end
	local path = Prefixes_Folder.."/"..user.Name.."/prefix.txt"
	safe_writefile(path, prefix)
end

local function load_user_prefix(user)
	if not user then return end
	local path = Prefixes_Folder.."/"..user.Name.."/prefix.txt"
	if safe_isfile(path) then
		return safe_readfile(path)
	end
	return nil
end

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
		save_user_prefix(sender, args[2])
		return print(sender.Name .. " set their prefix to: " .. args[2])
	end

	if not (cmd and target and value and Command_LocalPlayer(target)) then return end
	if not Humanoid then return end

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
	elseif cmd == "sit" then
		Humanoid.Sit = (value ~= 0)
	elseif cmd == "damage" then
		Humanoid:TakeDamage(value)
	elseif cmd == "gr" or cmd == "gravity" then
		Workspace.Gravity = value
	end

	print("[LocalPlayer_Commands]: Executed command '" .. cmd .. "' from " .. sender.Name)
end

print("[LocalPlayer_Commands]: Initializing command listener...")

if TextChatService and TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
	TextChatService.OnIncomingMessage = function(msg)
		local textSource = msg.TextSource
		if not textSource then return end
		local userId = textSource.UserId
		local player = Players:GetPlayerByUserId(userId)
		if player then
			HandleMessage(player, msg.Text)
		end
	end
end

Players.PlayerAdded:Connect(function(plr)
	local saved = load_user_prefix(plr)
	if saved then
		UserPrefixes[plr.UserId] = saved
	end
	plr.Chatted:Connect(function(msg)
		HandleMessage(plr, msg)
	end)
end)

for _, plr in ipairs(Players:GetPlayers()) do
	local saved = load_user_prefix(plr)
	if saved then
		UserPrefixes[plr.UserId] = saved
	end
	plr.Chatted:Connect(function(msg)
		HandleMessage(plr, msg)
	end)
end

print("[LocalPlayer_Commands]: Ready. Waiting for chat commands...")
