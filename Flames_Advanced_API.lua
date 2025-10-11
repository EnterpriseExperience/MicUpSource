-- FOR ADVANCED USERS: --
-- Variables.AllClipboards("text you want to copy here") -- Checks if the clipboard functions are available and allows you to let the user copy what ever you put in here.
-- Variables.httprequest_Init -- For more advanced users, but includes ALL functions for httprequest, and making requests to Discord, and such.
-- Variables.queueteleport -- For more advanced users, but includes queue-teleport functionality, allowing you to make scripts like auto-execute on rejoin scripts, if done correctly of course.

local flames_api = {}

local BUILD = "V2.1.1-DEVELOPER"

local Base_URL = "aul.biL_noitacifitoN/niam/sdaeh/sfer/ecruoSpUciM/ecneirepxEesirpretnE/moc.tnetnocresubuhtig.war//:sptth"

local Base_URL_2 = "aul.PUKCAB_ssapyB_sinodA/niam/sdaeh/sfer/ecruoSpUciM/ecneirepxEesirpretnE/moc.tnetnocresubuhtig.war//:sptth"

local function reverse_string(str)
	return string.reverse(str)
end

local Base_URL_Decoded = reverse_string(tostring(Base_URL))

local Base_URL_2_Decoded = reverse_string(tostring(Base_URL_2))

-- [[ ENVIRONMENTAL PROTECTION ]] --

local function get_safe_env()
	local ok, env = pcall(function()
		return (getgenv and getgenv()) or nil
	end)
	if ok and type(env) == "table" then
		return env
	elseif type(_G) == "table" then
		return _G
	else
		return {}
	end
end

-- [[ PER FUNCTION PROTECTION ]] --

local function blankfunction(...)
	return ...
end

local Variables = get_safe_env()
get_safe_env().Variables = Variables

Variables.SafeGame = game

local safe_cloneref = (type(cloneref) == "function" and cloneref) or blankfunction

local safe_setmetatable = (type(setmetatable) == "function" and setmetatable) or function(tbl) return tbl end

local raw_get = (type(rawget) == "function" and rawget) or blankfunction
local raw_set = (type(rawset) == "function" and rawset) or blankfunction
local GetConnections = (type(getconnections) == "function" and getconnections) or (type(get_signal_cons) == "function" and get_signal_cons) or blankfunction

-- [[ SERVICE PROTECTION ]] --

local function safe_getservice(self, name)
	local env_game = raw_get(Variables, "game")

	if env_game and type(env_game.GetService) == "function" then
		local ok, svc = pcall(function()
			return env_game:GetService(name)
		end)
		if ok and svc then
			return safe_cloneref and safe_cloneref(svc) or svc
		end
	end

	if raw_get(Variables, "game") and type(game.GetService) == "function" then
		local ok, svc = pcall(function()
			return game:GetService(name)
		end)
		if ok and svc then
			return safe_cloneref(svc)
		end
	end

	local fake = {
		Name = name,
		IsFake = true,
		GetService = safe_getservice,
	}
	return safe_setmetatable(fake, { __tostring = function() return "FakeService<" .. tostring(name) .. ">" end })
end

-- [[ SAFE GUARD GAME AND INDEXING ]] --

Variables.SafeGame = raw_get(Variables, "game") or safe_setmetatable({
	GetService = safe_getservice,
	FindService = safe_getservice,
	FindFirstChild = blankfunction,
	FindFirstChildOfClass = blankfunction,
	FindFirstChildWhichIsA = blankfunction,
	IsFake = true,
}, {
	__index = function(self, index)
		if index == "Services" then
			self.Services = {}
			return self.Services
		end
		return safe_getservice(self, index)
	end,

	__tostring = function()
		return "SafeGame<DataModel>"
	end
})

-- [[ SAFE GUARD SERVICES VIA INDEXING ]] --

local function safe_newservice(index)
	local svc = nil
	local ok = pcall(function()
		svc = Variables.SafeGame:GetService(index)
	end)
	if ok and svc then
		safe_cloneref(svc)
		return svc
	end
	return nil
end

local function build_safe_services()
	local t = {}
	local mt = {
		__index = function(self, index)
			local new_service = safe_newservice(index)
			if new_service then
				raw_set(self, index, new_service)
				return new_service
			end
			return nil
		end,

		__tostring = function()
			return "SafeServices<Table>"
		end
	}
	return safe_setmetatable(t, mt)
end

Variables.Services = build_safe_services()

-- [[ thank you: Infinite Yield (improved checking) ]] --
local function isNumber(str)
	if type(str) ~= "string" and type(str) ~= "number" then return false end
	if tonumber(str) ~= nil or str == "inf" then
		return true
	end
	return false
end

-- [[ TASK.WAIT .VS. WAIT --> os.clock() | FALLBACK ]] --

local function get_wait()
	if task and task.wait then
		return task.wait
	elseif wait then
		return wait
	else
		return function(t)
			local start = os.clock()
			while os.clock() - start < (t or 0) do end
		end
	end
end

local safe_wait = get_wait

-- [[ TASK.DELAY .VS. DELAY --> task.spawn | FALLBACK ]] --

local function wait_delay(TimeToWait, func)
	if not isNumber(TimeToWait) then
		TimeToWait = tonumber(TimeToWait) or 0
	end

	if typeof(func) == "function" then
		if task and task.delay then
			task.delay(TimeToWait, func)
		elseif delay then
			delay(TimeToWait, func)
		else
			task.spawn(function()
				task.wait(TimeToWait)
				func()
			end)
		end
	end
end

-- [[ PER ENVIRONMENTAL WAIT SELECTION ]] --

local function choose_wait()
	if task and task.wait then
		return task.wait
	elseif wait then
		return wait
	else
		return function(t)
			local t0 = os.clock()
			while os.clock() - t0 < (t or 0) do end
		end
	end
end

-- [[ ENVIRONMENTAL DELAY SELECTION | is_Function --> function()? ]] --
-- >> new_wait(1, true, function() print('FUNCTION = true') end) << --

local function new_wait(seconds, is_Function, functionality)
	local func_selected = choose_wait()
	local sec = tonumber(seconds) or 0

	if not is_Function then
		func_selected(sec)
	else
		wait_delay(sec, functionality)
	end
end

-- [[ SERVICE GUARD | V2 ]] --

local function SafeGet(serviceName)
	if type(serviceName) ~= "string" then
		return Variables.SafeGame
	end

	Variables.Services = Variables.Services or {}

	local existing = raw_get(Variables.Services, serviceName)
	if existing and not existing.IsFake then
		return safe_cloneref(existing)
	end

	local service

	local ok1, res1 = pcall(function()
		return safe_cloneref(Variables.SafeGame:GetService(serviceName))
	end)
	if ok1 and res1 then
		service = res1
	end

	if not service then
		local ok2, res2 = pcall(function()
			return Variables.SafeGame:FindService(serviceName)
		end)
		if ok2 and res2 then
			if typeof(res2) == "Instance" then
				service = safe_cloneref(res2)
			else
				service = res2
			end
		end
	end

	if not service then
		service = safe_setmetatable({
			Name = serviceName,
			IsFake = true,
			GetService = SafeGet,
		}, {
			__tostring = function()
				return "FakeService<" .. tostring(serviceName) .. ">"
			end
		})
	end

	if rawget and rawset then
		if not raw_get(Variables.Services, serviceName) then
			raw_set(Variables.Services, serviceName, service)
		end
	end

	return service
end

Variables.JobID = Variables.SafeGame.JobId
Variables.PlaceID = Variables.SafeGame.PlaceId
safe_wait()
local httpget =
	(typeof(game.HttpGet) == "function" and game.HttpGet)
	or (typeof(game.HttpGetAsync) == "function" and game.HttpGetAsync)
	or request
	or http_request
	or (syn and syn.request)
	or (http and http.request)
	or (fluxus and fluxus.request)
	or nil

local function safe_httpget(url)
   local ok, res = pcall(function()
		if typeof(httpget) == "function" then
			return httpget(game, url)
		elseif typeof(httpget) == "table" and httpget.request then
			return httpget.request({ Url = url, Method = "GET" }).Body
		elseif typeof(httpget) == "function" and not pcall(function() return game end) then
			local r = httpget({ Url = url, Method = "GET" })
			return (r and r.Body) or r
		end
	end)
	if ok and res then
		return res
	end
	return ""
end

local NotifyLib = loadstring(safe_httpget(Base_URL_Decoded))()
new_wait(0.1, false)
function notify(notif_type, msg, duration)
	local validTypes = {Error=true, Success=true, Info=true, Warning=true}
	local t = tostring(notif_type)
	if not validTypes[t] then
		t = "Info"
	end
	NotifyLib:External_Notification(t, tostring(msg), tonumber(duration))
end
wait(0.1)
Variables.notify = notify
wait(0.1)
flames_api.notify = Variables.notify or notify
flames_api.Service = function(serviceName)
   return SafeGet(serviceName)
end

local function getExecutor()
	if identifyexecutor then
		return { Name = identifyexecutor() }
	end
	return { Name = "Unknown Executor" }
end

local function executor_details()
	return getExecutor().Name
end

flames_api.ExecutorName = executor_details()
new_wait(0.1, false)
Variables.ExecutorName = flames_api.ExecutorName
Variables.AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
Variables.httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
Variables.queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

flames_api.RandomString = function()
	local length = math.random(10, 50)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local Players = SafeGet("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
   Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
   LocalPlayer = Players.LocalPlayer
	Variables.LocalPlayer = LocalPlayer or SafeGet("Players").LocalPlayer
end
new_wait(0.1, false)
flames_api.Players = Players
flames_api.LocalPlayer = Variables.LocalPlayer
flames_api.PlaceID = Variables.PlaceID
flames_api.JobID = Variables.JobID
flames_api.PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:FindFirstChildWhichIsA("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)

local function SafeGetHumanoid(char)
	return char:FindFirstChildWhichIsA("Humanoid") or char:WaitForChild("Humanoid", 5)
end

local function SafeGetHRP(char)
	return char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 5)
end

local function SafeGetHead(char)
	return char:FindFirstChild("Head") or char:WaitForChild("Head", 5)
end

local function SafeGetChar(player)
	if not player then return end

	return player.Character or player.CharacterAdded:Wait(5)
end

local FlyConnections

FlyConnections = FlyConnections or {}
Variables.FlyPart = Variables.FlyPart or nil
Variables.FlySpeed = Variables.FlySpeed or 10
Variables.Character = SafeGetChar(Variables.LocalPlayer)
Variables.HumanoidRootPart = SafeGetHRP(SafeGetChar(Variables.LocalPlayer))
Variables.Humanoid = SafeGetHumanoid(SafeGetChar(Variables.LocalPlayer))
Variables.Head = SafeGetHead(SafeGetChar(Variables.LocalPlayer))
wait(0.5)
local function Dynamic_Character_Updater(character)
	Variables.Character = character
	new_wait(0.5, false)
   if Variables.Character and Variables.Character:FindFirstChild("Humanoid") then
      Variables.HumanoidRootPart = SafeGetHRP(character)
      Variables.Humanoid = SafeGetHumanoid(character)
      Variables.Head = SafeGetHead(character)
   elseif not Variables.Character then
      repeat safe_wait() until character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart")
      Variables.Character = character
		Variables.Humanoid = Variables.Character:WaitForChild("Humanoid", 3)
		Variables.HumanoidRootPart = Variables.Character:WaitForChild("HumanoidRootPart", 5)
		Variables.Head = Variables.Character:WaitForChild("Head", 5)
	else
		Variables.Character = SafeGetChar(Variables.LocalPlayer)
		Variables.Humanoid = SafeGetHumanoid(SafeGetChar(Variables.LocalPlayer))
		Variables.HumanoidRootPart = SafeGetHRP(SafeGetChar(Variables.LocalPlayer))
		Variables.Head = SafeGetHead(SafeGetChar(Variables.LocalPlayer))
   end
	new_wait(0.2, false)
	flames_api.Character = Variables.Character
	flames_api.Humanoid = Variables.Humanoid
	flames_api.HumanoidRootPart = Variables.HumanoidRootPart
	flames_api.Head = Variables.Head
end

Dynamic_Character_Updater(Variables.Character)
new_wait(0.2, false)
Variables.LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	new_wait(0.2, false)
	Dynamic_Character_Updater(newCharacter)
	repeat safe_wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
	new_wait(0.5, false)
   Variables.Character = newCharacter
   new_wait(0.3, false)
   if not Variables.Humanoid then -- no way.
		Variables.Humanoid = Variables.Character:WaitForChild("Humanoid", 5) -- safe fallback.
   elseif Variables.Character then
      Variables.Humanoid = SafeGetHumanoid(Variables.Character) -- super safe fallback.
	else
		Variables.Humanoid = Variables.Character:WaitForChild("Humanoid", 60) -- super SUPER safe fallback ofc.
   end
	new_wait(0.3, false)
	Dynamic_Character_Updater(newCharacter)
end)

flames_api.Vehicle = function()
	local humanoid = flames_api.Humanoid or Variables.Character:FindFirstChildWhichIsA("Humanoid") or Variables.Humanoid

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

flames_api.Fly = function(speed)
	if Variables.FlyEnabled then return flames_api.notify("Warning", "Fly is already enabled!", 5) end
	local HumanoidRootPart = flames_api.HumanoidRootPart
	local Workspace = flames_api.Service("Workspace")
	local StarterPack = flames_api.Service("StarterPack")
	local RunService = flames_api.Service("RunService")
	local UserInputService = flames_api.Service("UserInputService")
	local character = flames_api.Character
	local humanoid = flames_api.Humanoid
	local camera = Workspace.CurrentCamera
	Variables.FlySpeed = tonumber(speed) or 5
	Variables.FlyEnabled = Variables.FlyEnabled or false

	Variables.StartFly = function()
		if Variables.FlyEnabled then return flames_api.notify("Warning", "Fly is already enabled!", 5) end
		Variables.FlyEnabled = true

		local dir = {w = false, a = false, s = false, d = false, q = false, e = false}
		local cf = Instance.new("CFrameValue")

		Variables.FlyPart = Instance.new("Part")
		Variables.FlyPart.Name = "RUNPART-SURF"
		Variables.FlyPart.Anchored = true
		Variables.FlyPart.Parent = StarterPack
		Variables.FlyPart.CFrame = HumanoidRootPart and HumanoidRootPart.CFrame or CFrame.new()

		FlyConnections.render = RunService.RenderStepped:Connect(function()
			if not Variables.FlyEnabled or not HumanoidRootPart then return end
			local primaryPart = HumanoidRootPart
			local speed = Variables.FlySpeed

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

			Variables.FlyPart.CFrame = CFrame.new(
				Variables.FlyPart.CFrame.p,
				(camera.CFrame * CFrame.new(0, 0, -100)).p
			)

			local moveDir = CFrame.new(x, y, z)
			cf.Value = cf.Value:lerp(moveDir, 0.2)
			Variables.FlyPart.CFrame = Variables.FlyPart.CFrame:lerp(Variables.FlyPart.CFrame * cf.Value, 0.2)
			primaryPart.CFrame = Variables.FlyPart.CFrame
			humanoid.PlatformStand = true
		end)

		FlyConnections.inputBegan = UserInputService.InputBegan:Connect(function(input, event)
			if event or not Variables.FlyEnabled then return end
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
			if event or not Variables.FlyEnabled then return end
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

	Variables.StartFly()
end

flames_api.Unfly = function()
	if not Variables.FlyEnabled then return end
	
	Variables.FlyEnabled = false

	for _, conn in pairs(FlyConnections) do
		if conn then conn:Disconnect() end
	end
	FlyConnections = {}

	if Variables.FlyPart then
		Variables.FlyPart:Destroy()
		Variables.FlyPart = nil
	end

	if flames_api.Humanoid then
		flames_api.Humanoid.PlatformStand = false
	end
end

flames_api.FindPlayer = function(args)
	local tbl = Players:GetPlayers()
	local cmdlp = flames_api.LocalPlayer

	local function isSelfTarget(arg)
		if not arg then return false end
		if typeof(arg) == "Instance" and arg:IsA("Player") then
			return arg == cmdlp
		elseif typeof(arg) == "string" then
			local name = arg:lower()
			return name == cmdlp.Name:lower() or name == cmdlp.DisplayName:lower() or name == "me" or name == "myself" or name == "LocalPlayer"
		end
		return false
	end
	if isSelfTarget(args) then
		flames_api.notify("Warning", "You cannot target yourself.", 5)
		return nil
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
		if not Target then return flames_api.notify("Error", "That player does not exist or you typed the name incorrectly!", 5) end

		if Target.Character and flames_api.Character then
			local TargetChar = Target.Character or Target.CharacterAdded:Wait()
			task.wait(0.1)
			flames_api.Character:PivotTo(TargetChar:GetPivot())
		end
	end)

	if not success then
		flames_api.notify("Warning", "[Teleport Error]: "..tostring(err), 8)
	end
end

flames_api.BypassAdonis = function()
	if Variables.AdonisBypass_Already_Loaded then
		return flames_api.notify("Warning", "You've already loaded the Adonis Anti-Cheat Bypass!", 7)
	end

	wait()

	loadstring(Variables.SafeGame:HttpGet(Base_URL_2_Decoded))()
	wait(0.2)
	Variables.AdonisBypass_Already_Loaded = true
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
	if type(JP) ~= "number" then return flames_api.notify("Warning", "That is not a number!", 4) end

	local StarterPlayer = SafeGet("StarterPlayer")
	local CharacterUseJumpPowerCheck = StarterPlayer.CharacterUseJumpPower

	pcall(function()
		if CharacterUseJumpPowerCheck then
			flames_api.Humanoid.JumpPower = JP
		else
			flames_api.Humanoid.JumpHeight = JP
		end
	end)
end

flames_api.BuildVersion = function()
	if not BUILD then return flames_api.notify("Error", "Build variable seems to have been erased?", 6) end

	flames_api.notify("Info", "You are running version/build: "..tostring(BUILD), 5)
end

flames_api.BypassWalkSpeed = function()
	if not GetConnections then
		return flames_api.notify("Error", "Your executor does not support 'getconnections'!", 5)
	end

	local humanoid = flames_api.Humanoid

	if not humanoid then
		return 
	end

	local signal = humanoid:GetPropertyChangedSignal("WalkSpeed")
	local connections = GetConnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
end

flames_api.BypassJumpPower = function()
	if not GetConnections then
		return flames_api.notify("Error", "Your executor does not support 'getconnections'!", 5)
	end

	local humanoid = flames_api.Humanoid

	if not humanoid then
		return 
	end

	local signal = humanoid:GetPropertyChangedSignal("JumpHeight")
	local connections = GetConnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
	local signal = humanoid:GetPropertyChangedSignal("UseJumpPower")
	local connections = GetConnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
	wait()
	local signal = humanoid:GetPropertyChangedSignal("JumpPower")
	local connections = GetConnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
end

flames_api.HookSpeed = function()
	if not hookmetamethod then return flames_api.notify("Error", "Your executor does not support 'hookmetamethod'!", 6) end

	local Original_WalkSpeed = SafeGet("StarterPlayer").CharacterWalkSpeed
	local Character = Variables.Character
	local hooks = {
		walkspeed = tonumber(Original_WalkSpeed) or 16,
	}
	local index
	local newindex

	index = hookmetamethod(game,"__index",function(self,property)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(Character) and hooks[property:lower()] then
			return hooks[property:lower()]
		end
		return index(self,property)
	end)

	newindex = hookmetamethod(game,"__newindex",function(self,property,value)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(Character) and hooks[property:lower()] then
			return value
		end
		return newindex(self,property,value)
	end)
end

flames_api.HookJP = function()
	if not hookmetamethod then return flames_api.notify("Error", "Your executor does not support 'hookmetamethod'!", 6) end

	local Original_JumpPower = SafeGet("StarterPlayer").CharacterJumpPower
	local Original_JumpHeight = SafeGet("StarterPlayer").CharacterJumpHeight
	local Character = Variables.Character
	local hooks = {
		jumppower = tonumber(Original_JumpPower) or 50,
		jumpheight = tonumber(Original_JumpHeight) or 7
	}
	local index
	local newindex

	index = hookmetamethod(game,"__index",function(self,property)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(Character) and hooks[property:lower()] then
			return hooks[property:lower()]
		end
		return index(self,property)
	end)

	newindex = hookmetamethod(game,"__newindex",function(self,property,value)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(Character) and hooks[property:lower()] then
			return value
		end
		return newindex(self,property,value)
	end)
end

local serviceList = {
	"Players", "Workspace", "Lighting", "ReplicatedStorage", "TweenService",
	"RunService", "MaterialService", "ReplicatedFirst", "Teams", "StarterPack",
	"StarterPlayer", "VoiceChatInternal", "VoiceChatService", "CoreGui", "SoundService",
	"StarterGui", "MarketplaceService", "TeleportService", "Chat", "AssetService",
	"HttpService", "UserInputService", "TextChatService", "ContextActionService",
	"GuiService", "PhysicsService"
}

for _, serviceName in ipairs(serviceList) do
	flames_api[serviceName] = SafeGet(serviceName)
end

return flames_api
