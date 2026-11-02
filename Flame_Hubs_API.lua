--[[
	╔══════════════════════════════════════════╗
	║          ADVANCED USERS ONLY             ║
	╚══════════════════════════════════════════╝
	┌─ AllClipboards ──────────────────────────────────────────────────────────┐
	│  g.AllClipboards("Text / String")                                        │
	│                                                                          │
	│  Resolves and calls the available clipboard setter for the               │
	│  current executor environment. Covers setclipboard and all               │
	│  known executor-specific equivalents.                                    │
	└──────────────────────────────────────────────────────────────────────────┘

	┌─ httprequest_Init ────────────────────────────────────────────────────────┐
	│  g.httprequest_Init({ Url = "...", Method = "POST", Body = "..." })       │
	│                                                                           │
	│  Resolves the available HTTP request function and dispatches              │
	│  the provided payload. Compatible with Discord webhooks,                  │
	│  Roblox endpoints, and general external URLs.                             │
	└───────────────────────────────────────────────────────────────────────────┘

	┌─ queueteleport ───────────────────────────────────────────────────────────┐
	│  g.queueteleport("loadstring(game:HttpGet('...'))()")                     │
	│                                                                           │
	│  Queues a script for execution on the next teleport or rejoin.            │
	│  Use a boolean guard (e.g. g.RejoinExecuted) to prevent loops.            │
	└───────────────────────────────────────────────────────────────────────────┘
]]

if not game:IsLoaded() then game.Loaded:Wait() end
local function valid_t(t) if t and typeof(t) == "table" then return t end; return false end
local In_Studio = false
local g
-- [[ Really secure checking below. ]] --
if game:GetService("RunService"):IsStudio() then -- studio-side checking, obviously we cannot run in Roblox Studio.
    g = valid_t(_G) or {}
    In_Studio = true
else
    g = valid_t(getgenv and getgenv()) or valid_t(_G) or {} -- always a valid fallback no matter what.
end
wait(0.1)
local blank_F = g.blank_function or g.blankfunction or function(...) return ... end
local cloneref = typeof(cloneref) == "function" and cloneref or function(instance) return instance end
-- [[ Should no longer break in Roblox Studio. 😈🚬 ]] --
local http_game
if In_Studio then
    http_game = blank_F
else
    http_game = (g["game"] or game)["HttpGet"]
    g.http_get = function(url) return http_game(game, url) end
end
wait(0.1)
g.flames_api = g.flames_api or {}
local flames_api = g.flames_api
local get_gc = getconnections or get_signal_cons
g.get_or_set = g.get_or_set or function(name, value)
	if rawget and rawset and typeof(rawget) == "function" and typeof(rawset) == "function" then
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

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

local function get_exec()
	local name
	if identifyexecutor and typeof(identifyexecutor) == "function" then name = identifyexecutor() end
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
if setmetatable and typeof(setmetatable) == "function" then
    local services = setmetatable({}, {
        __index = function(self, index)
            local ok, svc = pcall(function() return game.GetService(game, index) end)
            if not ok or not svc then return nil end
            if cloneref and typeof(cloneref) == "function" then
                local cloned_ok, cloned = pcall(cloneref, svc)
                if cloned_ok and cloned then svc = cloned end
            end
            if rawset and typeof(rawset) == "function" then rawset(self, index, svc) end
            return svc
        end
    })

    SafeGet = function(service) return services[service] end
else
    SafeGet = function(service)
        if cloneref and typeof(cloneref) == "function" and not In_Studio then
            local ok, result = pcall(function() return cloneref(game:GetService(service)) end)
            if ok and result then return result end
        end
        local ok, result = pcall(function() return game:GetService(service) end)
        return ok and result or nil
    end
end

g.findplayerchild = g.findplayerchild or function(plr, target, timeout)
	if not plr or not target then return nil end
	timeout = timeout or 10
	target = tostring(target):lower()
	local class_map = {
		playergui = "PlayerGui",
		playerscripts = "PlayerScripts",
		backpack = "Backpack",
		humanoidrootpart = "HumanoidRootPart",
		humanoid = "Humanoid",
		character = "Model",
	}

	local class = class_map[target]
	local function scan()
		if class then
			local found = plr and plr:FindFirstChildWhichIsA(class) or plr:FindFirstChildOfClass(class)
			if found then return found end
			for _, c in ipairs(plr:GetChildren()) do
				local ok, is_a = pcall(function() return c:IsA(class) end)
				if ok and is_a then return c end
			end
		else
			for _, c in ipairs(plr:GetChildren()) do
				local name_ok, class_ok
				local ok1, n = pcall(function() return c.Name:lower() end)
				local ok2, cn = pcall(function() return c.ClassName:lower() end)
				name_ok = ok1 and n == target
				class_ok = ok2 and cn == target
				if name_ok or class_ok then return c end
			end
		end
		return nil
	end

	local immediate = scan()
	if immediate then return immediate end
	local obj
	local conn
	conn = plr.ChildAdded:Connect(function(c)
		if obj then return end
		if class then
			local ok, is_a = pcall(function() return c:IsA(class) end)
			if ok and is_a then
				obj = c
				conn:Disconnect()
			end
		else
			local ok1, n = pcall(function() return c.Name:lower() end)
			local ok2, cn = pcall(function() return c.ClassName:lower() end)
			if (ok1 and n == target) or (ok2 and cn == target) then
				obj = c
				conn:Disconnect()
			end
		end
	end)

	local elapsed = 0
	local interval = 0.05
	while not obj do
		task.wait(interval)
		elapsed = elapsed + interval
		if elapsed >= timeout then
			if conn then pcall(function() conn:Disconnect() end) end
			return nil
		end

		if not plr or not plr.Parent then
			if conn then pcall(function() conn:Disconnect() end) end
			return nil
		end

		local found = scan()
		if found then
			obj = found
			if conn then pcall(function() conn:Disconnect() end) end
			break
		end
	end
	return obj
end

g.get_or_set("LocalPlayer", SafeGet("Players").LocalPlayer)
g.get_or_set("SafeGet", SafeGet)
g.get_or_set("safe_wrapper", SafeGet)
g.get_or_set("Safe_Wrapper", SafeGet)
g.get_or_set("Service_Wrap", SafeGet)
g.get_or_set("Service_Wrapper", SafeGet)

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
if SafeGet and type(SafeGet) == "function" then g.get_or_set("SafeGet", SafeGet) end
g.isnumber = g.isnumber or function(str)
	if tonumber(str) ~= nil or str == 'inf' or str == '9e9' or str == 'math.huge' then return true end
    return false
end

local valid_titles = {success="Success",info="Info",warning="Warning",error="Error",succes="Success",sucess="Success",eror="Error",erorr="Error",warnin="Warning"}
local function format_title(str)
	if typeof(str) ~= "string" then return "Info" end
	local key = str:lower()
	return valid_titles[key] or "Info"
end

function notify_func(title, msg, dur)
   local fixed_title = format_title(title)
   NotifyLib:External_Notification(fixed_title, tostring(msg), tonumber(dur))
end

g.get_or_set("notify", notify_func)
flames_api.notify = function(title, content, dur)
	local fixed_title = format_title(title)
	NotifyLib:External_Notification(fixed_title, tostring(content), tonumber(dur))
end

-- [[ Advanced thread detector, to potentially protect 'game' referencing on high-end executors with a good current context level. ]] --
local get_thread_identity = missing("function", getthreadidentity or (syn and syn.get_thread_identity) or syn_context_get or getthreadcontext)
if get_thread_identity and typeof(get_thread_identity) == "function" then
    local ok, identity = pcall(get_thread_identity)
    if ok and identity == 8 then
        g.Game = cloneref and typeof(cloneref) == "function" and cloneref(game) or game
    else
        g.Game = game
    end
else
    g.Game = game
end

g.JobID = game.JobId
g.PlaceID = game.PlaceId
flames_api.Service = function(service) return SafeGet(service) end
flames_api.ExecutorName = executordet
g.find_player_gui = g.find_player_gui or function() return g.findplayerchild("PlayerGui") end
flames_api.RandomString = function()
	local length = math.random(10, 50)
	local array = {}
	for i = 1, length do array[i] = string.char(math.random(32, 126)) end
	return table.concat(array)
end
wait(0.1)
g.RandomString = flames_api.RandomString

local function get_player_gui(plr)
	if not plr then return nil end
	local pg = plr and plr:FindFirstChildOfClass("PlayerGui") or plr:FindFirstChildWhichIsA("PlayerGui")
	if pg and pg:IsA("PlayerGui") then return pg end
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

g.get_or_set("PlayerGui", g.find_player_gui(game.Players.LocalPlayer))
g.get_or_set("find_player_gui", g.find_player_gui)
g.get_or_set("AllClipboards", setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set))
g.get_or_set("httprequest_Init", (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request)
g.get_or_set("queueteleport", (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport))
g.get_or_set("RandomString", flames_api.RandomString or g.RandomString)
g.get_or_set("randomString", flames_api.RandomString or g.RandomString)
g.get_or_set("randomstring", flames_api.RandomString or g.RandomString)
local Players = SafeGet("Players")
local StarterPlayer = SafeGet("StarterPlayer")
local RunService = SafeGet("RunService")
local LocalPlayer = g.LocalPlayer or Players.LocalPlayer
g.get_or_set("LocalPlayer", LocalPlayer)
flames_api.Players = Players
flames_api.LocalPlayer = LocalPlayer
flames_api.PlaceId = g.PlaceID or game.PlaceId
flames_api.placeid = g.PlaceID or game.PlaceId
flames_api.PlaceID = g.PlaceID or game.PlaceId
flames_api.JobID = g.JobID or game.JobId
flames_api.JobId = g.JobID or game.JobId
flames_api.jobid = g.JobID or game.JobId
flames_api.PlayerGui = get_player_gui(LocalPlayer)
local FlyConnections
local Old_WS_Value = g.isnumber(StarterPlayer.CharacterWalkSpeed)
local Old_JP_Value = g.isnumber(StarterPlayer.CharacterJumpPower)
local Old_JH_Value = g.isnumber(StarterPlayer.CharacterJumpHeight)
wait(0.1)
function Wait_F(t)
    if not t or t <= 0 then RunService.Heartbeat:Wait(); return end
    local ok = pcall(task.wait, t)
    if not ok then RunService.Heartbeat:Wait() end
end
wait(0.1)
local function hb() Wait_F() end
local function wait_for_datamodel(inst)
    if not inst then return false end
    local start_time = os.clock()
    local timeout = Players.RespawnTime + 0.75
    while os.clock() - start_time < timeout do
        local ok, result = pcall(function() return inst.Parent and inst:IsDescendantOf(workspace) and inst:IsDescendantOf(game) end)
        if ok and result then return true end
        hb()
    end
    return false
end
wait(0.1)
g.get_or_set("wait_for_datamodel", wait_for_datamodel)
local function wait_for_child(parent, name, timeout)
    if not parent or not parent:IsDescendantOf(game) then return nil end
    local existing = parent:FindFirstChild(name)
    if existing then return existing end
    timeout = timeout or 10
    local start_time = os.clock()
    local result = nil
    while os.clock() - start_time < timeout do
        if not parent or not parent:IsDescendantOf(game) then break end
        local ok, found = pcall(function() return parent:FindFirstChild(name) end)
        if ok and found then
            result = found
            break
        end
        hb()
    end
    return result
end
wait(0.1)
g.get_or_set("wait_for_child", wait_for_child)
local function wait_for_descendant(parent, name, timeout)
    if not parent or not parent:IsDescendantOf(game) then return nil end
    local found = parent:FindFirstChild(name, true)
    if found then return found end
    timeout = timeout or 10
    local start_time = os.clock()
    local result = nil
    local conn
    pcall(function()
        conn = parent.DescendantAdded:Connect(function(d)
            if d.Name == name then
                result = d
            end
        end)
    end)
    while not result and os.clock() - start_time < timeout do
        if not parent or not parent:IsDescendantOf(game) then break end
        local ok, check = pcall(function() return parent:FindFirstChild(name, true) end)
        if ok and check then
            result = check
            break
        end
        hb()
    end
    pcall(function() if conn then conn:Disconnect() end end)
    return result
end
wait(0.1)
g.get_or_set("wait_for_descendant", wait_for_descendant)
local function wait_for_child_safe(parent, name, timeout)
    if not parent or not parent:IsDescendantOf(game) then return nil end
    local existing = parent:FindFirstChild(name)
    if existing then return existing end
    timeout = timeout or 10
    local start_time = os.clock()
    while os.clock() - start_time < timeout do
        if not parent or not parent:IsDescendantOf(game) then break end
        local ok, found = pcall(function() return parent:FindFirstChild(name) end)
        if ok and found then return found end
        hb()
    end
    return nil
end
g.get_or_set("wait_for_child_safe", wait_for_child_safe)

local function retry_find(func, retries, delay)
    for _ = 1, retries do
        local ok, result = pcall(func)
        if ok and result then return result end
        Wait_F(delay)
    end
    return nil
end
g.get_or_set("retry_find", retry_find)

g.return_char = function(player, timeout)
    if not player or not player:IsA("Player") then return nil end
    timeout = tonumber(timeout) or Players.RespawnTime + 1
    local start = os.clock()
    while os.clock() - start < timeout do
        local char = player.Character
        if char and char:IsDescendantOf(workspace) and char:IsDescendantOf(game) then
            local ok, hum = pcall(function() return char:FindFirstChildOfClass("Humanoid") end)
            if ok and hum and hum.Health > 0 then return char end
        end
        hb()
    end
    return nil
end

g.get_char = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    if not player or not player:IsA("Player") then return nil end
    local char = player.Character
    if char and char:IsDescendantOf(workspace) and char:IsDescendantOf(game) then return char end
    local start = os.clock()
    while os.clock() - start < time_out do
        char = player.Character
        if char and wait_for_datamodel(char) then return char end
        hb()
    end
    return nil
end

g.get_human = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    local char = g.get_char(player, time_out)
    if not char then return nil end
    local existing = char:FindFirstChildOfClass("Humanoid")
    if existing then return existing end
    return wait_for_child_safe(char, "Humanoid", time_out)
end

g.get_root = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    local char = g.get_char(player, time_out)
    if not char then return nil end
    local existing = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if existing then return existing end
    return wait_for_child_safe(char, "HumanoidRootPart", time_out)
        or wait_for_child_safe(char, "UpperTorso", time_out)
        or wait_for_child_safe(char, "Torso", time_out)
end

g.get_head = function(player, time_out)
    time_out = tonumber(time_out) or Players.RespawnTime + 1
    local char = g.get_char(player, time_out)
    if not char then return nil end
    local existing = char:FindFirstChild("Head")
    if existing then return existing end
    return wait_for_child_safe(char, "Head", time_out)
end
wait(0.1)
local function sync_api()
	flames_api.Character = g.Character or g.get_char(LocalPlayer)
	flames_api.Humanoid = g.Humanoid or g.get_human(LocalPlayer)
	flames_api.HumanoidRootPart = g.HumanoidRootPart or g.get_root(LocalPlayer)
	flames_api.Head = g.Head or g.get_head(LocalPlayer)
end

task.spawn(sync_api)
FlyConnections = FlyConnections or {}
g.FlyPart = g.FlyPart or nil
g.FlySpeed = g.FlySpeed or 10
sync_api()

if setmetatable and rawset and typeof(setmetatable) == "function" and typeof(rawset) == "function" then
	setmetatable(flames_api, {
		__index = function(_, key)
			if key == "Character" then return g.get_char(LocalPlayer) or g.Character end
			if key == "Humanoid" then return g.get_human(LocalPlayer) or g.Humanoid end
			if key == "HumanoidRootPart" then return g.get_root(LocalPlayer) or g.HumanoidRootPart end
			if key == "Head" then return g.get_head(LocalPlayer) or g.Head end
		return rawget(flames_api, key)
	end})
else
	flames_api.Character = function()
		return g.get_char(LocalPlayer) or g.Character
	end

	flames_api.Humanoid = function()
		return g.get_human(LocalPlayer) or g.Humanoid
	end

	flames_api.HumanoidRootPart = function()
		return g.get_root(LocalPlayer) or g.HumanoidRootPart
	end

	flames_api.Head = function()
		return g.get_head(LocalPlayer) or g.Head
	end
end

local updating = false
local char_updating = false
local function hook_updates()
	if updating then return end
	updating = true
	task.defer(function()
		if g.Character and g.Character:IsDescendantOf(game or workspace) then sync_api() end
		updating = false
	end)
end

local function update_character_refs()
	if char_updating then return end
	char_updating = true
	local lp = g.LocalPlayer or LocalPlayer or Players.LocalPlayer
	if not lp then char_updating = false; return end
	local char = lp.Character or g.get_char(lp)
	g.Character = char
	local hum = char and char:FindFirstChildOfClass("Humanoid") or g.get_human(lp)
	if not hum or not hum.Parent or not hum:IsDescendantOf(game) then hum = char.ChildAdded:Wait() end
	if hum and hum.Parent and hum:IsDescendantOf(game) and hum:IsA("Humanoid") then g.Humanoid = hum end
	local root = char and char:FindFirstChild("HumanoidRootPart") or g.get_root(lp)
	if not root then root = char.ChildAdded:Wait() end
	g.HumanoidRootPart = root
	local head = char:FindFirstChild("Head")
	if not head then head = char.ChildAdded:Wait() end
	g.Head = head
	char_updating = false
	hook_updates()
end

if not g.Flames_Hub_Dynamic_CharAdded_Checker then
	g.Flames_Hub_Dynamic_CharAdded_Checker = true
	LocalPlayer.CharacterAdded:Connect(function() task.defer(update_character_refs) end)
end

task.defer(update_character_refs)
flames_api.Vehicle = function()
	local character = g.Character or LocalPlayer.Character or g.get_char(LocalPlayer)
	local humanoid = g.Humanoid or character and character:FindFirstChildWhichIsA("Humanoid") or g.get_human(LocalPlayer)
	if humanoid and humanoid.Parent and humanoid:IsDescendantOf(game) and humanoid.SeatPart then
		local Seat_Part = humanoid.SeatPart
		local model = Seat_Part:FindFirstAncestorOfClass("Model")
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
	local character = g.Character or LocalPlayer.Character or g.get_char(LocalPlayer)
	local humanoid = g.Humanoid or character and character:FindFirstChildWhichIsA("Humanoid") or g.get_human(LocalPlayer)
	if humanoid and humanoid.SeatPart then return humanoid.SeatPart end
	return nil
end

flames_api.Fly = function(speed)
	if g.FlyEnabled then flames_api.notify("Error", "Fly is already enabled!", 5); return end
	local HumanoidRootPart = flames_api.HumanoidRootPart
	local Workspace = flames_api.Service("Workspace")
	local StarterPack = flames_api.Service("StarterPack")
	local RunService = flames_api.Service("RunService")
	local UserInputService = flames_api.Service("UserInputService")
	local character = flames_api.Character
	local humanoid = flames_api.Humanoid
	local camera = Workspace.CurrentCamera
	g.FlySpeed = tonumber(speed) or 5
	g.FlyEnabled = g.FlyEnabled or false
	g.StartFly = function()
		if g.FlyEnabled then flames_api.notify("Error", "Fly is already enabled!", 3); return end
		g.FlyEnabled = true
		local dir = {w = false, a = false, s = false, d = false, q = false, e = false}
		local cf = Instance.new("CFrameValue")
		g.FlyPart = Instance.new("Part")
		g.FlyPart.Name = "RUNPART-SURF"
		g.FlyPart.Anchored = true
		g.FlyPart.Parent = StarterPack
		g.FlyPart.CFrame = HumanoidRootPart and HumanoidRootPart.CFrame or CFrame.new()
		FlyConnections.render = RunService.RenderStepped:Connect(function()
			if not g.FlyEnabled or not HumanoidRootPart then return end
			local primaryPart = HumanoidRootPart
			local speed = g.FlySpeed
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

			g.FlyPart.CFrame = CFrame.new(
				g.FlyPart.CFrame.p,
				(camera.CFrame * CFrame.new(0, 0, -100)).p
			)

			local moveDir = CFrame.new(x, y, z)
			cf.Value = cf.Value:lerp(moveDir, 0.2)
			g.FlyPart.CFrame = g.FlyPart.CFrame:lerp(g.FlyPart.CFrame * cf.Value, 0.2)
			primaryPart.CFrame = g.FlyPart.CFrame
			humanoid.PlatformStand = true
		end)

		FlyConnections.inputBegan = UserInputService.InputBegan:Connect(function(input, event)
			if event or not g.FlyEnabled then return end
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

		FlyConnections.InputEnded = UserInputService.InputEnded:Connect(function(input, event)
			if event or not g.FlyEnabled then return end
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

	g.StartFly()
end

flames_api.Unfly = function()
	if not g.FlyEnabled then return end
	g.FlyEnabled = false
	for _, conn in pairs(FlyConnections) do if conn then conn:Disconnect() end end
	FlyConnections = {}
	if g.FlyPart then
		g.FlyPart:Destroy()
		g.FlyPart = nil
	end

    local hum = g.Humanoid or g.get_human(LocalPlayer)
	if hum and hum.Parent and hum:IsDescendantOf(game) then hum.PlatformStand = false end
end

flames_api.FindPlayer = function(args)
    local tbl = Players:GetPlayers()
    if args == "random" then
        local validPlayers = {}
        for _, v in pairs(tbl) do
            if v ~= LocalPlayer then
                table.insert(validPlayers, v)
            end
        end
        return #validPlayers > 0 and validPlayers[math.random(1, #validPlayers)] or nil
    end

    if args == "new" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.AccountAge < 30 and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "old" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.AccountAge > 30 and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "bacon" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= LocalPlayer and g.get_char(v, Players.RespawnTime + 1) and (g.get_char(v, Players.RespawnTime + 1):FindFirstChild("Pal Hair") or g.get_char(v, Players.RespawnTime + 1):FindFirstChild("Kate Hair")) then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "friend" then
        local friendList = {}
        for _, v in pairs(tbl) do
            if v:IsFriendsWith(LocalPlayer.UserId) and v ~= LocalPlayer then
                table.insert(friendList, v)
            end
        end
        return #friendList > 0 and friendList[math.random(1, #friendList)] or nil
    end

    if args == "notfriend" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if not v:IsFriendsWith(LocalPlayer.UserId) and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "ally" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.Team == LocalPlayer.Team and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "enemy" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.Team ~= LocalPlayer.Team and v ~= LocalPlayer then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "near" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= LocalPlayer then
                local vRootPart = g.get_root(v, 1)
                local cmdlpRootPart = g.HumanoidRootPart or g.get_root(LocalPlayer, Players.RespawnTime + 0.75)
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
            if v ~= LocalPlayer then
                local vRootPart = g.get_root(v, Players.RespawnTime + 1)
                local cmdlpRootPart = g.HumanoidRootPart or g.get_root(LocalPlayer, Players.RespawnTime + 1)
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

	if typeof(args) ~= "string" or args == "" then return nil end
	for _, v in pairs(tbl) do
		local name, display = v.Name:lower(), v.DisplayName:lower()
		if name:find(args:lower()) or display:find(args:lower()) then
			if v == LocalPlayer then
				if g.notify and typeof(g.notify) == "function" then g.notify("Error", "You cannot target yourself!", 1) end
				return nil
			end
			return v
		end
	end

	return nil
end
wait(0.1)
flames_api.GoTo = function(playerArg)
	local success, err = pcall(function()
		local Target = flames_api.FindPlayer(playerArg)
		if not Target then return end
        local TargetChar = Target.Character or g.get_char(Target)
		if TargetChar and TargetChar:IsDescendantOf(game or workspace) then
            local char = g.Character or LocalPlayer.Character or g.get_char(LocalPlayer)
            if char and char:IsDescendantOf(game or workspace) then char:PivotTo(TargetChar:GetPivot()) end
		end
	end)
    wait(0.25)
	if not success then g.notify("Error", "[Teleport Error]: "..tostring(err), 3) end
end

flames_api.BypassAdonis = function()
	if g.AdonisBypass_Already_Loaded then return end
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Adonis_Bypass_BACKUP.lua'))()
	wait(0.2)
	g.AdonisBypass_Already_Loaded = true
end

flames_api.WalkSpeed = function(Speed)
	if type(Speed) ~= "number" then return end
	local hum = g.Humanoid or g.get_human(LocalPlayer)
	if not hum or not hum.Parent or not hum:IsDescendantOf(game) then return end
	hum.WalkSpeed = Speed
end

flames_api.JumpPower = function(JP)
	if type(JP) ~= "number" then return end
	pcall(function()
		local hum = g.Humanoid or g.get_human(LocalPlayer)
		if not hum or not hum.Parent or not hum:IsDescendantOf(game) then return end
		if hum.UseJumpPower or hum.UseJumpPower == true then
			hum.JumpPower = JP
		else
			hum.JumpHeight = JP
		end
	end)
end

flames_api.BypassWalkSpeed = function()
	if not get_gc or typeof(get_gc) ~= "function" then g.notify("Error", "Your executor does not support 'getconnections'!", 5); return end
	local humanoid = g.Humanoid or g.get_human(LocalPlayer)
	if not humanoid or not humanoid.Parent or not humanoid:IsDescendantOf(game) then g.notify("Error", "Humanoid not found inside Character at runtime.", 5); return end
	local signal_ws = humanoid:GetPropertyChangedSignal("WalkSpeed")
	local connections_ws = get_gc(signal_ws)
	for _, conn in ipairs(connections_ws) do pcall(function() conn:Disable() end) end
end

flames_api.BypassJumpPower = function()
	if not get_gc or typeof(get_gc) ~= "function" then g.notify("Error", "Your executor does not support 'getconnections'!", 5); return end
	local humanoid = g.Humanoid or g.get_human(LocalPlayer)
	if not humanoid or not humanoid.Parent or not humanoid:IsDescendantOf(game) then g.notify("Error", "Humanoid not found inside Character at runtime.", 5); return end
	local signal_jh = humanoid:GetPropertyChangedSignal("JumpHeight")
	local connections_jh = get_gc(signal_jh)
	for _, conn in ipairs(connections_jh) do pcall(function() conn:Disable() end) end
	local signal_1 = humanoid:GetPropertyChangedSignal("UseJumpPower")
	local connections_1 = get_gc(signal_1)
	for _, conn in ipairs(connections_1) do pcall(function() conn:Disable() end) end
	wait()
	local signal_jp = humanoid:GetPropertyChangedSignal("JumpPower")
	local connections_jp = get_gc(signal_jp)
	for _, conn in ipairs(connections_jp) do pcall(function() conn:Disable() end) end
end

flames_api.BypassWS = function()
	if not hookmetamethod or typeof(hookmetamethod) ~= "function" then g.notify("Error", "'hookmetamethod' is unsupported.", 5); return end
	local hooks = {walkspeed = Old_WS_Value}
	local index
	local newindex
	index = hookmetamethod(game,"__index",function(self,property)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(LocalPlayer.Character) and hooks[property:lower()] then return hooks[property:lower()] end
		return index(self,property)
	end)
	newindex = hookmetamethod(game,"__newindex",function(self,property,value)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(LocalPlayer.Character) and hooks[property:lower()] then return value end
		return newindex(self,property,value)
	end)
end

flames_api.BypassJP = function()
	if not hookmetamethod or typeof(hookmetamethod) ~= "function" then g.notify("Error", "'hookmetamethod' is unsupported.", 5); return end
	local hooks = {
		jumppower = Old_JP_Value,
		jumpheight = Old_JH_Value
	}
	local index
	local newindex
	index = hookmetamethod(game,"__index",function(self,property)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(LocalPlayer.Character) and hooks[property:lower()] then return hooks[property:lower()] end
		return index(self,property)
	end)
	newindex = hookmetamethod(game,"__newindex",function(self,property,value)
		if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(LocalPlayer.Character) and hooks[property:lower()] then return value end
		return newindex(self,property,value)
	end)
end

local service_list = {
	"Players", "Workspace", "Lighting", "ReplicatedStorage", "TweenService",
	"RunService", "MaterialService", "ReplicatedFirst", "Teams", "StarterPack",
	"StarterPlayer", "VoiceChatInternal", "VoiceChatService", "CoreGui", "SoundService",
	"StarterGui", "MarketplaceService", "TeleportService", "Chat", "AssetService",
	"HttpService", "UserInputService", "TextChatService", "ContextActionService",
	"GuiService", "PhysicsService", "TextService", "LogService"
}

for _, service in ipairs(service_list) do flames_api[service] = SafeGet(service) end
return flames_api
