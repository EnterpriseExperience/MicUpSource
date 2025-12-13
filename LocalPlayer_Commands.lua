if not game:IsLoaded() then game.Loaded:Wait() end
if not getgenv().GlobalEnvironmentFramework_Initialized then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
   wait(0.1)
   getgenv().GlobalEnvironmentFramework_Initialized = true
end

local Flames_API = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua'))()
local Players = Flames_API.Service("Players")
local TextChatService = Flames_API.Service("TextChatService")
local Workspace = Flames_API.Service("Workspace")
local LocalPlayer = Flames_API.LocalPlayer
local g = getgenv()

getgenv().notify = getgenv().notify or function(title, content, dur)
   Flames_API.notify(title, content, dur)
end
wait(0.3)
getgenv().Commands_Loaded = getgenv().Commands_Loaded or false
if getgenv().Commands_Loaded then
   return getgenv().notify("Error", "[LocalPlayer_Commands DEBUG]: Already loaded.", 10)
end
getgenv().Commands_Loaded = true

local Prefixes_Folder = "CommandUserPrefixes"
local function is_folder(path)
	return isfolder and isfolder(path)
end

local function make_folder(path)
	if makefolder then
		pcall(makefolder, path)
	end
end

local function is_file(path)
	return isfile and isfile(path)
end

local function write_file(path, content)
	if writefile then
		pcall(writefile, path, content)
	end
end

local function read_file(path)
	if readfile then
		local ok, data = pcall(readfile, path)
		if ok then
			return data
		end
	end
	return nil
end

if isfolder then
	if not is_folder(Prefixes_Folder) then
		make_folder(Prefixes_Folder)
	end
else
   getgenv().notify("Error", "[LocalPlayer-Commands]: User prefix's will not save, file system unsupported.", 20)
end

local function userprefix_folder(user)
	if not user then return end
	local path = Prefixes_Folder .. "/" .. tostring(user.UserId)

	if not is_folder(path) then
		make_folder(path)
	end

	return is_folder(path)
end

local function saveprefix(user, prefix)
	if not user then return end
	local path = Prefixes_Folder .. "/" .. user.UserId .. "/prefix.txt"

	write_file(path, prefix)
end

local function loadprefix(user)
	if not user then return end
	local path = Prefixes_Folder .. "/" .. user.UserId .. "/prefix.txt"

	if is_file(path) then
		return read_file(path)
	end

	return nil
end

local Default_Prefix = ";"
local UserPrefixes = {}

local function lpcheck(name)
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

local function split(str)
	local parts = {}
	for word in str:gmatch("%S+") do
		table.insert(parts, word)
	end
	return parts
end

g.get_char = g.get_char or function(Player)
	if not Player or not Player:IsA("Player") then return nil end

	local current_char
	local diedconn
	local added_conn

	local function hookchar(char)
		current_char = char

		if diedconn then diedconn:Disconnect() end

		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			diedconn = hum.Died:Once(function()
				current_char = nil
			end)
		end
	end

	if Player.Character and Player.Character.Parent then
		hookchar(Player.Character)
	end

	added_conn = Player.CharacterAdded:Connect(hookchar)

	while not current_char do
		task.wait()
		local char = Player.Character
		if char and char.Parent then
			hookchar(char)
		end
	end

	return current_char
end

if not g.get_human then
	g.get_human = function(Player)
		local char = g.get_char(Player)
		if not char then return nil end

		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then return hum end

		local hum_conn
		hum_conn = char.ChildAdded:Connect(function(c)
			if c:IsA("Humanoid") then
				hum = c
				hum_conn:Disconnect()
			end
		end)

		local died = false
		local h = char:FindFirstChildOfClass("Humanoid")
		if h then
			h.Died:Connect(function()
				died = true
			end)
		end

		while not hum and not died do
			task.wait()
		end

		if hum_conn then hum_conn:Disconnect() end

		return (not died) and hum or nil
	end
end

local function gethum()
   return g.get_human(LocalPlayer)
end

local function HandleMessage(sender, message)
	if typeof(sender) ~= "Instance" or not sender:IsA("Player") then return end
	if sender == LocalPlayer then return end

	if message:sub(1, 3):lower() == "/e" then
		message = message:gsub("^/e%s*", "")
	end

	local prefix = UserPrefixes[sender.UserId] or Default_Prefix
	if not message:sub(1, #prefix) == prefix then return end

	local args = split(message:sub(#prefix + 1))
	local cmd = args[1] and args[1]:lower()
	local target = args[2]
	local value = tonumber(args[3])

	if cmd == "prefix" and args[2] and #args[2] == 1 then
		UserPrefixes[sender.UserId] = args[2]
		saveprefix(sender, args[2])
		return getgenv().notify("Info", sender.Name.." set their prefix to: "..args[2], 3)
	end

	if not (cmd and target and value and lpcheck(target)) then return end

	local hum = gethum()
	if not hum then return end

	if cmd == "speed" or cmd == "ws" then
		hum.WalkSpeed = value
	elseif cmd == "jumppower" or cmd == "jumpheight" or cmd == "jp" then
		if hum.UseJumpPower then
			hum.JumpPower = value
		else
			hum.JumpHeight = value
		end
	elseif cmd == "hipheight" then
		hum.HipHeight = value
	elseif cmd == "sit" then
		hum.Sit = (value ~= 0)
	elseif cmd == "damage" then
		hum:TakeDamage(value)
	elseif cmd == "gr" or cmd == "gravity" then
		Workspace.Gravity = value
	end
end

getgenv().notify("Info", "[LocalPlayer_Commands]: Initializing command listener...", 5)

TextChatService.MessageReceived:Connect(function(msg)
	local textSource = msg.TextSource
	if not textSource then return end
	local userId = textSource.UserId
	local player = Players:GetPlayerByUserId(userId)
	if player then
		HandleMessage(player, msg.Text)
	end
end)

Players.PlayerAdded:Connect(function(plr)
	local saved = loadprefix(plr)
	if saved then
		UserPrefixes[plr.UserId] = saved
	end
end)

Players.PlayerRemoving:Connect(function(plr)
   UserPrefixes[plr.UserId] = nil
end)

for _, plr in ipairs(Players:GetPlayers()) do
	local saved = loadprefix(plr)
	if saved then
		UserPrefixes[plr.UserId] = saved
	end
end

getgenv().notify("Success", "[LocalPlayer_Commands]: Ready. Waiting for chat commands...", 10)
