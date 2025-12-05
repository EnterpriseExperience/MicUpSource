-- [[ ADVANCED USERS ONLY ]] --

--[[
	getgenv().AllClipboards("text you want to copy here")

	-- [INFO] --
	Includes: Supported function(s) for setclipboard, which checks if the clipboard functions are available and allows you to set the users clipboard to what ever you put in it.
--]]

--[[ 
	getgenv().httprequest_Init(payload json table or something here)

	-- [INFO] --
	Includes: Supported function(s) for httprequest, which lets you to make HTTP requests to URLs like: Discord, Roblox, etc.
--]]

--[[
	getgenv().queueteleport("loadstring here")

	-- [INFO] --
	Includes: Supported function(s) for queueteleport, which lets you make scripts auto-execute on rejoin/server-hop, if set correctly with a boolean flag (e.g: getgenv().RejoinExecuted = true).
--]]

if not game:IsLoaded() then
   game.Loaded:Wait()
end
local g = getgenv()
g.flames_api = g.flames_api or {}
local flames_api = g.flames_api
local get_gc = getconnections or get_signal_cons

g.get_or_set = g.get_or_set or function(name, value)
	if rawget and rawset then
		local existing = rawget(g, name)
		if existing == nil then
			rawset(g, name, value)
			return value
		end
		return existing
	end

	local existing = g[name]

	if existing == nil then
		g[name] = value
		return value
	end

	return existing
end

local function get_exec()
	local name
	if identifyexecutor then
		name = identifyexecutor()
	end
	return { Name = name or "Unknown Executor"}
end

local function detectexc()
	local executor = get_exec()
	return string.format("%s", executor.Name)
end

local executordet = detectexc()

g.low_level_executor = g.low_level_executor or function()
	if executordet == "Solara" or string.find(executordet, "JJSploit") or executordet == "Xeno" then
		return true
	else
		return false
	end
end

local SafeGet

if setmetatable then
	local services = setmetatable({}, {
		__index = function(self, index)
			local svc = game.GetService(game, index)
			if cloneref and svc then
				svc = cloneref(svc)
			end
			if svc then
				self[index] = svc
			end
			return svc
		end
	})

	SafeGet = function(service)
		return services[service]
	end
else
	SafeGet = function(service)
		if cloneref then
			return cloneref(game:GetService(service))
		else
			return game:GetService(service)
		end
	end
end

g.findplayerchild = g.findplayerchild or function(plr, target)
	if not plr or not target then return nil end
	target = tostring(target):lower()

	local class
	if target == "playergui" then
		class = "PlayerGui"
	elseif target == "playerscripts" then
		class = "PlayerScripts"
	elseif target == "backpack" then
		class = "Backpack"
	end

	local obj
	if class then
		obj = plr:FindFirstChildOfClass(class)
		if not obj then
			obj = plr:FindFirstChildWhichIsA(class)
		end
		if obj then return obj end
	else
		for _, c in ipairs(plr:GetChildren()) do
			if c.Name:lower() == target then
				return c
			end
		end
	end

	local conn
	conn = plr.ChildAdded:Connect(function(c)
		if class then
			if c:IsA(class) then
				obj = c
				conn:Disconnect()
			end
		else
			if c.Name:lower() == target then
				obj = c
				conn:Disconnect()
			end
		end
	end)

	while not obj do
		task.wait()
		if class then
			local a = plr:FindFirstChildOfClass(class)
			if not a then
				a = plr:FindFirstChildWhichIsA(class)
			end
			if a then
				obj = a
				conn:Disconnect()
				break
			end
		else
			for _, c in ipairs(plr:GetChildren()) do
				if c.Name:lower() == target then
					obj = c
					conn:Disconnect()
					break
				end
			end
		end
	end

	return obj
end

get_or_set("LocalPlayer", SafeGet("Players").LocalPlayer)
get_or_set("SafeGet", SafeGet)
get_or_set("safe_wrapper", SafeGet)
get_or_set("Safe_Wrapper", SafeGet)
get_or_set("Service_Wrap", SafeGet)
get_or_set("Service_Wrapper", SafeGet)

local NotifyLib = loadstring(game:HttpGet(
   "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"
))()

if SafeGet and type(SafeGet) == "function" then
	get_or_set("SafeGet", SafeGet)
end

g.isnumber = g.isnumber or function(str)
	if tonumber(str) ~= nil or str == 'inf' or str == '9e9' or str == 'math.huge' then
		return true
	end
end

local valid_titles = {
	success = "Success",
	info = "Info",
	warning = "Warning",
	error = "Error"
}

local function format_title(str)
	if typeof(str) ~= "string" then
		return "Info"
	end

	local key = str:lower()
	return valid_titles[key] or "Info"
end

function notify_func(title, msg, dur)
   local fixed_title = format_title(title)
   NotifyLib:External_Notification(fixed_title, tostring(msg), tonumber(dur))
end

get_or_set("notify", notify_func)

flames_api.notify = function(title, content, dur)
	local fixed_title = format_title(title)
	NotifyLib:External_Notification(fixed_title, tostring(content), tonumber(dur))
end

-- [[ when teleporting via queueteleport : needs to update dynamically, leave these like this. ]] --
getgenv().Game = cloneref and cloneref(game) or game
getgenv().JobID = game.JobId
getgenv().PlaceID = game.PlaceId

flames_api.Service = function(service)
   return SafeGet(service)
end

flames_api.ExecutorName = executor_details()

g.find_player_gui = g.find_player_gui or function()
	return g.findplayerchild("PlayerGui")
end

flames_api.RandomString = function()
	local length = math.random(10, 50)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local function get_player_gui(plr)
	if not plr then return nil end

	local pg = plr:FindFirstChildOfClass("PlayerGui")
	if pg then return pg end

	local added_conn
	added_conn = plr.ChildAdded:Connect(function(c)
		if c:IsA("PlayerGui") then
			pg = c
			if added_conn then added_conn:Disconnect() end
		end
	end)

	local timeout = 10
	while timeout > 0 and not pg do
		task.wait()
		timeout = timeout - 0.03
		local existing = plr:FindFirstChildOfClass("PlayerGui")
		if existing then
			pg = existing
			if added_conn then added_conn:Disconnect() end
			break
		end
	end

	if added_conn then added_conn:Disconnect() end
	return pg
end

get_or_set("PlayerGui", find_player_gui(game.Players.LocalPlayer))
get_or_set("find_player_gui", find_player_gui)
get_or_set("AllClipboards", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))
get_or_set("httprequest_Init", (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request)
get_or_set("queueteleport", (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport))
get_or_set("RandomString", RandomString)
get_or_set("randomString", RandomString)
get_or_set("randomstring", RandomString)

local Players = SafeGet("Players")
local StarterPlayer = SafeGet("StarterPlayer")
local LocalPlayer = Players.LocalPlayer
get_or_set("LocalPlayer", LocalPlayer)
flames_api.Players = Players
flames_api.LocalPlayer = LocalPlayer
flames_api.PlaceId = getgenv().PlaceID or game.PlaceId
flames_api.placeid = getgenv().PlaceID or game.PlaceId
flames_api.PlaceID = getgenv().PlaceID or game.PlaceId
flames_api.JobID = getgenv().JobID or game.JobId
flames_api.JobId = getgenv().JobID or game.JobId
flames_api.jobid = getgenv().JobID or game.JobId
flames_api.PlayerGui = get_player_gui(LocalPlayer)
local FlyConnections
local Old_WS_Value = isnumber(StarterPlayer.CharacterWalkSpeed)
local Old_JP_Value = isnumber(StarterPlayer.CharacterJumpPower)
local Old_JH_Value = isnumber(StarterPlayer.CharacterJumpHeight)
wait(0.1)
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
wait(0.5)
g.get_human = get_human or function(Player)
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

g.get_root = get_root or function(Player)
	local char = g.get_char(Player)
	if not char then return nil end

	local root = char:FindFirstChild("HumanoidRootPart")
			or char:FindFirstChild("UpperTorso")
			or char:FindFirstChild("Torso")
	if root then return root end

	local targets = {
		HumanoidRootPart = true,
		UpperTorso = true,
		Torso = true
	}

	local died = false
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.Died:Connect(function() died = true end)
	end

	local added_conn
	added_conn = char.ChildAdded:Connect(function(c)
		if targets[c.Name] then
			root = c
			added_conn:Disconnect()
		end
	end)

	while not root and not died do
		task.wait()
	end

	if added_conn then added_conn:Disconnect() end

	return (not died) and root or nil
end

g.get_head = g.get_head or function(Player)
	local char = g.get_char(Player)
	if not char then return nil end

	local head = char:FindFirstChild("Head")
	if head then return head end

	local died = false
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.Died:Connect(function() died = true end)
	end

	local added_conn
	added_conn = char.ChildAdded:Connect(function(c)
		if c.Name == "Head" then
			head = c
			added_conn:Disconnect()
		end
	end)

	while not head and not died do
		task.wait()
	end

	if added_conn then added_conn:Disconnect() end

	return (not died) and head or nil
end

local function sync_api()
	flames_api.Character = g.Character or get_char(g.LocalPlayer or game.Players.LocalPlayer)
	flames_api.Humanoid = g.Humanoid or get_human(g.LocalPlayer or game.Players.LocalPlayer)
	flames_api.HumanoidRootPart = g.HumanoidRootPart or get_root(g.LocalPlayer or game.Players.LocalPlayer)
	flames_api.Head = g.Head or get_head(g.LocalPlayer or game.Players.LocalPlayer)
end

task.spawn(sync_api)

FlyConnections = FlyConnections or {}
getgenv().FlyPart = getgenv().FlyPart or nil
getgenv().FlySpeed = getgenv().FlySpeed or 10
sync_api()

if setmetatable and rawset then
	setmetatable(flames_api, {
		__index = function(_, key)
			if key == "Character" then
				return g.get_char(g.LocalPlayer) or g.Character
			end

			if key == "Humanoid" then
				return g.get_human(g.LocalPlayer) or g.Humanoid
			end

			if key == "HumanoidRootPart" then
				return g.get_root(g.LocalPlayer) or g.HumanoidRootPart
			end

			if key == "Head" then
				return g.get_head(g.LocalPlayer) or g.Head
			end

			return rawget(flames_api, key)
		end
	})
else
	flames_api.Character = function()
		local lp = g.LocalPlayer or getgenv().Players.LocalPlayer or game.Players.LocalPlayer
		return g.get_char(lp) or g.Character
	end

	flames_api.Humanoid = function()
		local lp = g.LocalPlayer or getgenv().Players.LocalPlayer or game.Players.LocalPlayer
		return g.get_human(lp) or g.Humanoid
	end

	flames_api.HumanoidRootPart = function()
		local lp = g.LocalPlayer or getgenv().Players.LocalPlayer or game.Players.LocalPlayer
		return g.get_root(lp) or g.HumanoidRootPart
	end

	flames_api.Head = function()
		local lp = g.LocalPlayer or getgenv().Players.LocalPlayer or game.Players.LocalPlayer
		return g.get_head(lp) or g.Head
	end
end

local updating = false

local function hook_updates()
	if updating then return end
	updating = true

	task.spawn(function()
		while g.Character == nil do task.wait() end
		sync_api()
		updating = false
	end)
end

local function update_character_refs()
	local lp = g.LocalPlayer
	local char

	while true do
		char = g.get_char(lp)
		if char then break end
		task.wait()
	end

	g.Character = char

	while true do
		local hum = g.get_human(lp)
		if hum then
			g.Humanoid = hum
			break
		end
		task.wait()
	end

	while true do
		local root = g.get_root(lp)
		if root then
			g.HumanoidRootPart = root
			break
		end
		task.wait()
	end

	while true do
		local head = g.get_head(lp)
		if head then
			g.Head = head
			break
		end
		task.wait()
	end
end

if not g.Flames_Hub_Dynamic_CharAdded_Checker then
   g.Flames_Hub_Dynamic_CharAdded_Checker = true
	
	g.LocalPlayer.CharacterAdded:Connect(function(char)
		while not (char and char.Parent and (char:FindFirstChild("Humanoid") or char:FindFirstChild("HumanoidRootPart"))) do
			task.wait()
		end

		task.spawn(update_character_refs)
	end)
end

task.spawn(update_character_refs)

flames_api.Vehicle = function()
	local character = flames_api.Character or get_char(flames_api.LocalPlayer or g.LocalPlayer or game.Players.LocalPlayer)
	local humanoid = flames_api.Humanoid or get_human(flames_api.LocalPlayer or g.LocalPlayer or game.Players.LocalPlayer) or character and character:FindFirstChildWhichIsA("Humanoid") or character:WaitForChild("Humanoid", 15)
	local hrp = flames_api.HumanoidRootPart or get_root(flames_api.LocalPlayer or g.LocalPlayer or game.Players.LocalPlayer) or character and character:FindFirstChild("HumanoidRootPart")

	if humanoid and humanoid.SeatPart then
		local seatPart = humanoid.SeatPart
		local model = seatPart:FindFirstAncestorOfClass("Model")

		if model and typeof(model.GetDescendants) == "function" then
			for _, descendant in ipairs(model:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.Name and string.find(descendant.Name:lower(), "wheel") then
					return model
				end
			end
		end
	end

	return nil
end

flames_api.SeatPart = function()
	local character = flames_api.Character or get_char(flames_api.LocalPlayer or g.LocalPlayer or game.Players.LocalPlayer)
	local humanoid = flames_api.Humanoid or get_human(flames_api.LocalPlayer or g.LocalPlayer or game.Players.LocalPlayer) or character and character:FindFirstChildWhichIsA("Humanoid") or character:WaitForChild("Humanoid", 15)

	if humanoid and humanoid.SeatPart then
		return humanoid.SeatPart
	end

	return nil
end

flames_api.Fly = function(speed)
	if getgenv().FlyEnabled then return flames_api.notify("Error", "Fly is already enabled!", 5) end
	local HumanoidRootPart = flames_api.HumanoidRootPart
	local Workspace = flames_api.Service("Workspace")
	local StarterPack = flames_api.Service("StarterPack")
	local RunService = flames_api.Service("RunService")
	local UserInputService = flames_api.Service("UserInputService")
	local character = flames_api.Character
	local humanoid = flames_api.Humanoid
	local camera = Workspace.CurrentCamera
	getgenv().FlySpeed = tonumber(speed) or 5
	getgenv().FlyEnabled = getgenv().FlyEnabled or false

	getgenv().StartFly = function()
		if getgenv().FlyEnabled then return flames_api.notify("Error", "Fly is already enabled!", 5) end
		getgenv().FlyEnabled = true

		local dir = {w = false, a = false, s = false, d = false, q = false, e = false}
		local cf = Instance.new("CFrameValue")

		getgenv().FlyPart = Instance.new("Part")
		getgenv().FlyPart.Name = "RUNPART-SURF"
		getgenv().FlyPart.Anchored = true
		getgenv().FlyPart.Parent = StarterPack
		getgenv().FlyPart.CFrame = HumanoidRootPart and HumanoidRootPart.CFrame or CFrame.new()

		FlyConnections.render = RunService.RenderStepped:Connect(function()
			if not getgenv().FlyEnabled or not HumanoidRootPart then return end
			local primaryPart = HumanoidRootPart
			local speed = getgenv().FlySpeed

			local x, y, z = 0, 0, 0
			if dir.w then z = -1 * speed end
			if dir.a then x = -1 * speed end
			if dir.s then z = 1 * speed end
			if dir.d then x = 1 * speed end
			if dir.q then y = 1 * speed end
			if dir.e then y = -1 * speed end

			for i, v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Velocity = Vector3.new(0, 0, 0)
					v.RotVelocity = Vector3.new(0, 0, 0)
				end
			end

			getgenv().FlyPart.CFrame = CFrame.new(
				getgenv().FlyPart.CFrame.p,
				(camera.CFrame * CFrame.new(0, 0, -100)).p
			)

			local moveDir = CFrame.new(x, y, z)
			cf.Value = cf.Value:lerp(moveDir, 0.2)
			getgenv().FlyPart.CFrame = getgenv().FlyPart.CFrame:lerp(getgenv().FlyPart.CFrame * cf.Value, 0.2)
			primaryPart.CFrame = getgenv().FlyPart.CFrame
			humanoid.PlatformStand = true
		end)

		FlyConnections.inputBegan = UserInputService.InputBegan:Connect(function(input, event)
			if event or not getgenv().FlyEnabled then return end
			local code, codes = input.KeyCode, Enum.KeyCode
			if code == codes.W then dir.w = true
			elseif code == codes.A then dir.a = true
			elseif code == codes.S then dir.s = true
			elseif code == codes.D then dir.d = true
			elseif code == codes.Q then dir.q = true
			elseif code == codes.E then dir.e = true
			elseif code == codes.Space then dir.q = true
			end
		end)

		FlyConnections.inputEnded = UserInputService.InputEnded:Connect(function(input, event)
			if event or not getgenv().FlyEnabled then return end
			local code, codes = input.KeyCode, Enum.KeyCode
			if code == codes.W then dir.w = false
			elseif code == codes.A then dir.a = false
			elseif code == codes.S then dir.s = false
			elseif code == codes.D then dir.d = false
			elseif code == codes.Q then dir.q = false
			elseif code == codes.E then dir.e = false
			elseif code == codes.Space then dir.q = false
			end
		end)
	end

	getgenv().StartFly()
end

flames_api.Unfly = function()
	if not getgenv().FlyEnabled then return end
	
	getgenv().FlyEnabled = false

	for _, conn in pairs(FlyConnections) do
		if conn then conn:Disconnect() end
	end
	FlyConnections = {}

	if getgenv().FlyPart then
		getgenv().FlyPart:Destroy()
		getgenv().FlyPart = nil
	end

	if flames_api.Humanoid then
		flames_api.Humanoid.PlatformStand = false
	end
end

flames_api.FindPlayer = function(args)
	local tbl = Players:GetPlayers()
	local cmdlp = Players.LocalPlayer

	if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
		return warn("[ERROR]:", "You cannot target yourself.")
	end

	if args == "random" then
		local validPlayers = {}
		for _, v in pairs(tbl) do
			if v ~= cmdlp then
				table.insert(validPlayers, v)
			end
		end
		return #validPlayers > 0 and validPlayers[math.random(1, #validPlayers)] or nil
	end

	if args == "new" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if v.AccountAge < 30 and v ~= cmdlp then
				table.insert(vAges, v)
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	if args == "old" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if v.AccountAge > 30 and v ~= cmdlp then
				table.insert(vAges, v)
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	if args == "bacon" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if v ~= cmdlp and (v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair")) then
				table.insert(vAges, v)
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	if args == "friend" then
		local friendList = {}
		for _, v in pairs(tbl) do
			if v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
				table.insert(friendList, v)
			end
		end
		return #friendList > 0 and friendList[math.random(1, #friendList)] or nil
	end

	if args == "notfriend" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if not v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
				table.insert(vAges, v)
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	if args == "ally" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if v.Team == cmdlp.Team and v ~= cmdlp then
				table.insert(vAges, v)
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	if args == "enemy" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if v.Team ~= cmdlp.Team and v ~= cmdlp then
				table.insert(vAges, v)
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	if args == "near" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if v ~= cmdlp and v.Character and cmdlp.Character then
				local vRootPart = v.Character:FindFirstChild("HumanoidRootPart")
				local cmdlpRootPart = cmdlp.Character:FindFirstChild("HumanoidRootPart")
				if vRootPart and cmdlpRootPart then
					local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
					if distance < 30 then
						table.insert(vAges, v)
					end
				end
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	if args == "far" then
		local vAges = {}
		for _, v in pairs(tbl) do
			if v ~= cmdlp and v.Character and cmdlp.Character then
				local vRootPart = v.Character:FindFirstChild("HumanoidRootPart")
				local cmdlpRootPart = cmdlp.Character:FindFirstChild("HumanoidRootPart")
				if vRootPart and cmdlpRootPart then
					local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
					if distance > 30 then
						table.insert(vAges, v)
					end
				end
			end
		end
		return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
	end

	for _, v in pairs(tbl) do
		if (v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower())) and v ~= cmdlp then
			return v
		end
	end
end
wait(0.1)
flames_api.GoTo = function(playerArg)
	local success, err = pcall(function()
		local Target = flames_api.FindPlayer(playerArg)
		if not Target then return end

		if Target.Character and flames_api.Character then
			local TargetChar = Target.Character or Target.CharacterAdded:Wait()
			task.wait(0.1)
			flames_api.Character:PivotTo(TargetChar:GetPivot())
		end
	end)

	if not success then
		getgenv().notify("Error", "[Teleport Error]: "..tostring(err), 5)
	end
end

flames_api.BypassAdonis = function()
	if getgenv().AdonisBypass_Already_Loaded then
		return getgenv().notify("Warning", "You've already loaded Adonis Bypass.", 5)
	end
	
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Adonis_Bypass_BACKUP.lua'))()
	wait(0.2)
	getgenv().AdonisBypass_Already_Loaded = true
end

flames_api.WalkSpeed = function(Speed)
	if type(Speed) ~= "number" then return end
	pcall(function()
		if flames_api.Humanoid then
			flames_api.Humanoid.WalkSpeed = Speed
		end
	end)
end

flames_api.JumpPower = function(JP)
	if type(JP) ~= "number" then return end
	pcall(function()
		if flames_api.Humanoid.UseJumpPower or flames_api.Humanoid.UseJumpPower == true then
			flames_api.Humanoid.JumpPower = JP
		else
			flames_api.Humanoid.JumpHeight = JP
		end
	end)
end

flames_api.BypassWalkSpeed = function()
	if not get_gc then
		return getgenv().notify("Error", "Your executor does not support 'getconnections'!", 5)
	end

	local humanoid = flames_api.Humanoid

	if not humanoid then
		return getgenv().notify("Error", "Humanoid not found inside Character at runtime.", 5)
	end

	local signal = humanoid:GetPropertyChangedSignal("WalkSpeed")
	local connections = get_gc(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
end

flames_api.BypassJumpPower = function()
	if not get_gc then
		return getgenv().notify("Error", "Your executor does not support 'getconnections'!", 5)
	end

	local humanoid = flames_api.Humanoid

	if not humanoid then
		return getgenv().notify("Error", "Humanoid not found inside Character at runtime.", 5)
	end

	local signal = humanoid:GetPropertyChangedSignal("JumpHeight")
	local connections = get_gc(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
	local signal = humanoid:GetPropertyChangedSignal("UseJumpPower")
	local connections = get_gc(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
	wait()
	local signal = humanoid:GetPropertyChangedSignal("JumpPower")
	local connections = get_gc(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
end

flames_api.BypassWS = function()
	if not hookmetamethod then
		return getgenv().notify("Error", "'hookmetamethod' is unsupported.", 5)
	end

	local lp = LocalPlayer
	local hooks = {
		walkspeed = Old_WS_Value
	}
	local index
	local newindex

	index = hookmetamethod(game,"__index",function(self,property)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
			return hooks[property:lower()]
		end
		return index(self,property)
	end)

	newindex = hookmetamethod(game,"__newindex",function(self,property,value)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
			return value
		end
		return newindex(self,property,value)
	end)
end

flames_api.BypassJP = function()
	if not hookmetamethod then
		return getgenv().notify("Error", "'hookmetamethod' is unsupported.", 5)
	end

	local lp = LocalPlayer
	local hooks = {
		jumppower = Old_JP_Value,
		jumpheight = Old_JH_Value
	}
	local index
	local newindex

	index = hookmetamethod(game,"__index",function(self,property)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
			return hooks[property:lower()]
		end
		return index(self,property)
	end)

	newindex = hookmetamethod(game,"__newindex",function(self,property,value)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
			return value
		end
		return newindex(self,property,value)
	end)
end

local service_list = {
	"Players", "Workspace", "Lighting", "ReplicatedStorage", "TweenService",
	"RunService", "MaterialService", "ReplicatedFirst", "Teams", "StarterPack",
	"StarterPlayer", "VoiceChatInternal", "VoiceChatService", "CoreGui", "SoundService",
	"StarterGui", "MarketplaceService", "TeleportService", "Chat", "AssetService",
	"HttpService", "UserInputService", "TextChatService", "ContextActionService",
	"GuiService", "PhysicsService"
}

for _, service in ipairs(service_list) do
	flames_api[service] = SafeGet(service)
end

return flames_api
