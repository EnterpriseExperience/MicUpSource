if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().TheLanesScript_Hub_Loaded then
    if getgenv().notify then
        return getgenv().notify("Warning", "The Lanes | Script Hub is already loaded.", 6)
    else
        return warn("The Lanes | Script Hub is already loaded.")
    end
end

getgenv().TheLanesScript_Hub_Loaded = true
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Notify_Lib.lua"))()
getgenv().notify = getgenv().notify or function(notif_type, msg, duration) NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration)) end
if game.PlaceId ~= 1333478699 then
    if getgenv().notify then
        return getgenv().notify("Error", "This is not The Lanes!", 10)
    else
        return warn("This is not The Lanes!")
    end
end

if not getgenv().GlobalEnvironmentFramework_Initialized then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Global_Environment.lua"))()
   wait(0.1)
   getgenv().GlobalEnvironmentFramework_Initialized = true
end

getgenv().safe_func = function(...)
    for i = 1, select("#", ...) do
        local f = select(i, ...)
        if typeof(f) == "function" then
            return f
        end
    end
    return function() end
end

local function function_exists(func) return typeof(func) == "function" end
local TextChatService = getgenv().TextChatService or cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")
local Workspace = getgenv().Workspace or cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Players = getgenv().Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local ReplicatedStorage = getgenv().ReplicatedStorage or cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local LocalPlayer = getgenv().LocalPlayer or Players.LocalPlayer
local channel = TextChatService:FindFirstChild("RBXGeneral", true)
local queue_tp = safe_func(
    queue_on_teleport,
    syn and syn.queue_on_teleport,
    fluxus and fluxus.queue_on_teleport
)
local set_clip_board = safe_func(
    setclipboard,
    toclipboard,
    set_clipboard,
    Clipboard and Clipboard.set
)
getgenv().TheLanes_Debugging_Mode_Enabled = getgenv().TheLanes_Debugging_Mode_Enabled or false
getgenv().Flames_Bowling_Animations = {}

local executor_string = nil
local function executor_contains(substr)
    if typeof(executor_string) ~= "string" then
        return false
    end
    return string.find(string.lower(executor_string), string.lower(substr), 1, true) ~= nil
end

local function retrieve_executor()
    local name
    if identifyexecutor then
        name = identifyexecutor()
    end
    return { Name = name or "Unknown Executor" }
end

local function identify_executor()
    local executorinfo = retrieve_executor()
    return tostring(executorinfo.Name)
end

executor_string = identify_executor()

local function get_lplr()
    local players = getgenv().Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players") or game.Players
    local lplr = getgenv().LocalPlayer or players.LocalPlayer or game.Players.LocalPlayer

    return lplr
end

local function get_char()
    local players = getgenv().Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players") or game.Players
    local lplr = getgenv().LocalPlayer or players.LocalPlayer
    local find_character = getgenv().Character or lplr.Character or getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait() or players.LocalPlayer.CharacterAdded:Wait() or lplr.CharacterAdded:Wait()

    return find_character
end

local function get_root()
    local rootpart = getgenv().HumanoidRootPart or character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3) or getgenv().Character:WaitForChild("HumanoidRootPart", 5)

    return rootpart
end

function low_level_executor()
    if executor_contains("solara") then return true end
    if executor_contains("jjsploit") then return true end
    if executor_contains("xeno") then return true end
    return false
end

getgenv().FlamesLibrary = getgenv().FlamesLibrary or {}
getgenv().FlamesLibrary._connections = getgenv().FlamesLibrary._connections or {}
getgenv().FlamesLibrary.connect = function(name, connection)
	getgenv().FlamesLibrary._connections[name] = getgenv().FlamesLibrary._connections[name] or {}
	table.insert(getgenv().FlamesLibrary._connections[name], connection)
	return connection
end

getgenv().FlamesLibrary.disconnect = function(name)
	local list = getgenv().FlamesLibrary._connections[name]

	if list then
		for _, item in ipairs(list) do
			if typeof(item) == "RBXScriptConnection" then
				item:Disconnect()
			elseif type(item) == "thread" then
				pcall(task.cancel, item)
			end
		end
		getgenv().FlamesLibrary._connections[name] = nil
	end
end

getgenv().FlamesLibrary.spawn = function(name, mode, func, ...)
	if not name or not mode or type(func) ~= "function" then
		return 
	end

	if getgenv().FlamesLibrary._connections[name] then
		getgenv().FlamesLibrary.disconnect(name)
	end

	getgenv().FlamesLibrary._connections[name] = {}

	local thread

	if mode == "spawn" then
		thread = task.spawn(func, ...)
	elseif mode == "defer" then
		thread = task.defer(func, ...)
	elseif mode == "delay" then
		local delay_time = ...
		thread = task.delay(delay_time, func)
	elseif mode == "wrap" then
		thread = coroutine.create(func)
		coroutine.resume(thread, ...)
	else
        -- don't really need a warning --
		-- warn("Invalid spawn mode / argument: "..tostring(mode))
		return
	end

	table.insert(getgenv().FlamesLibrary._connections[name], thread)
	return thread
end

getgenv().FlamesLibrary.is_thread_alive = function(input)
    local lib = getgenv().FlamesLibrary

    if type(input) == "thread" then
        local ok, status = pcall(coroutine.status, input)
        if not ok then
            return false
        end
        return status ~= "dead"
    end

    if type(input) == "string" then
        local list = lib._connections[input]
        if not list then
            return false
        end

        for _, item in ipairs(list) do
            if type(item) == "thread" then
                local ok, status = pcall(coroutine.status, item)
                if ok and status ~= "dead" then
                    return true
                end
            end
        end

        return false
    end

    return false
end

getgenv().FlamesLibrary.is_alive = function(name)
    local lib = getgenv().FlamesLibrary
    local list = lib._connections[name]

    if not list then
        return false
    end

    for _, item in ipairs(list) do
        if typeof(item) == "RBXScriptConnection" then
            if item.Connected then
                return true
            end
        elseif type(item) == "thread" then
            if lib.is_thread_alive(item) then
                return true
            end
        end
    end

    return false
end

getgenv().FlamesLibrary.cleanup_all = function()
	for name in pairs(getgenv().FlamesLibrary._connections) do
		getgenv().FlamesLibrary.disconnect(name)
	end
end

local function keycode_to_string(keycode)
    if typeof(keycode) ~= "EnumItem" then
        return nil
    end

    if keycode.EnumType == Enum.KeyCode then
        return keycode.Name
    end

    return nil
end

local function string_to_keycode(key)
    if typeof(key) ~= "string" then
        return nil
    end

    return Enum.KeyCode[key]
end

getgenv().Flames_Bowling_Configuration = getgenv().Flames_Bowling_Configuration or {
    maxPlayers = 4,
    playerJoinMode = "REQUEST",
    useBarriers = false,
    scoringMode = "STANDARD"
}
getgenv().Flames_Keybind_Configuration = getgenv().Flames_Keybind_Configuration or {
    unlock_camera = Enum.KeyCode.F,
    unlock_camera_string = "F"
}
wait(0.1)
getgenv().Flames_Keybind_Configuration.unlock_camera_string = keycode_to_string(getgenv().Flames_Keybind_Configuration.unlock_camera)
local function get_config() return getgenv().Flames_Bowling_Configuration end
local function find_game_over_RF()
    local cache = getgenv().game_over_arcade_RF
    if cache and cache:IsA("RemoteFunction") then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("gameover") then
            getgenv().game_over_arcade_RF = v
            return v
        end
    end

    return nil
end

if not getgenv().game_over_arcade_RF then task.spawn(function() find_game_over_RF() end) end

local function find_arcade_helper_module_script()
    local cache = getgenv().arcade_helper_modulescript
    if cache and cache:IsA("ModuleScript") then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("arcade") and v.Name:lower():find("helper") then
            getgenv().arcade_helper_modulescript = v
            return v
        end
    end

    return nil
end

if not getgenv().arcade_helper_modulescript then task.spawn(function() find_arcade_helper_module_script() end) end
wait(0.1)
getgenv().mod_arcade_high_score = function()
    local Arcade_Remote_Function = getgenv().game_over_arcade_RF
    if not Arcade_Remote_Function then
        return getgenv().notify("Error", "Could not locate RemoteFunction: 'gameOver' to modify high-score.", 7) 
    end
    local mod = require(getgenv().arcade_helper_modulescript)
    local new_val = 999999999
    local args
    local ok, response = pcall(function()
        mod["MAXIMUM_SCORE"] = new_val
    end)

    if not ok then
        print("[src/helpers/arcade-helper.ts:5] Unable to modify numeric data 'MAXIMUM_SCORE', modification was rejected by the client sender")
    end

    if not low_level_executor() then
        args = {
            "AsteroidBlaster",
            99999 -- the highest it can go, if you set it any higher, it just errors: "Invalid parameter #2 for async remote 'gameOver': got 100000".
        }
    else
        args = {
            "AsteroidBlaster",
            new_val
        }
    end

    local ok, response = pcall(function() Arcade_Remote_Function:InvokeServer(unpack(args)) end)

    if not ok then
        return getgenv().notify("Error", "An error occurred while setting maximum Arcade high-score: "..tostring(response), 25)
    else
        return getgenv().notify("Success", "Successfully modified high-score to the highest amount possible.", 8)
    end
end

getgenv().get_bowling_lanes_folder = function()
    local cached = getgenv().bowling_folder_found
    if cached and cached:IsA("Folder") then
        return cached
    end
    wait(0.1)
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("bowl") and v.Name:lower():find("lane") then
            getgenv().bowling_folder_found = v
            return v
        end
    end

    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("bowl") and v.Name:lower():find("lane") then
            getgenv().bowling_folder_found = v
            return v
        end
    end
    
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("bowl") and v.Name:lower():find("lane") then
            getgenv().bowling_folder_found = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().bowling_folder_found then task.spawn(function() get_bowling_lanes_folder() end) end
wait(0.1)
getgenv().get_currently_open_lane = function()
	local claimed_lane_ids = {}
    local cached = getgenv().bowling_folder_found
    if not cached then
        return getgenv().notify("Error", "We could not find the Folder 'BowlingLanes', you cannot use this at this time.", 10)
    end

	for _, player in ipairs(Players:GetPlayers()) do
		local lane_id = player:GetAttribute("BowlingLaneId")
		if lane_id ~= nil then
			claimed_lane_ids[lane_id] = true
		end
	end

	for _, obj in ipairs(cached:GetDescendants()) do
		if obj:IsA("Model") then
			local lane_id = obj:GetAttribute("LaneId")
			if lane_id ~= nil and not claimed_lane_ids[lane_id] then
				return obj
			end
		end
	end

	return nil
end
wait(0.2)
getgenv().are_all_lanes_occupied = function()
	local cached = getgenv().bowling_folder_found
	if not cached then
		return false
	end

	local claimed_lane_ids = {}
	local total_lanes = 0

	for _, player in ipairs(Players:GetPlayers()) do
		local lane_id = player:GetAttribute("BowlingLaneId")
		if lane_id ~= nil then
			claimed_lane_ids[lane_id] = true
		end
	end

	for _, obj in ipairs(cached:GetDescendants()) do
		if obj:IsA("Model") then
			local lane_id = obj:GetAttribute("LaneId")
			if lane_id ~= nil then
				total_lanes = total_lanes + 1

				if not claimed_lane_ids[lane_id] then
					return false
				end
			end
		end
	end

	return total_lanes > 0
end

getgenv().flowrgb = getgenv().flowrgb or function(connname,speed,obj,toggle)
    local ts=game:GetService("TweenService")
    local rs=game:GetService("RunService")
    if toggle==false then
        if getgenv()[connname] then
            pcall(function() getgenv()[connname]:Disconnect() end)
            getgenv()[connname]=nil
        end
    else
        if getgenv()[connname] then
            pcall(function() getgenv()[connname]:Disconnect() end)
            getgenv()[connname]=nil
        end
        if not obj then
            return
        end
        local hue=0
        getgenv()[connname]=rs.RenderStepped:Connect(function(dt)
            hue=(hue+(dt*speed))%1
            local col=Color3.fromHSV(hue,1,1)
            if typeof(obj) == "Instance" and obj:IsA("BasePart") then
                obj.Color = col
                pcall(function() obj.BrickColor = BrickColor.new(col) end)
            else
                pcall(function()
                    ts:Create(obj,TweenInfo.new(0.10,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{BackgroundColor3=col}):Play()
                end)
            end
        end)
    end
end

getgenv().find_start_game_RF = function()
    local cached = getgenv().start_game_RF
    if cached and cached:IsA("RemoteFunction") then
        return cached
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("start") and v.Name:lower():find("game") then
            getgenv().start_game_RF = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().start_game_RF then task.spawn(function() getgenv().find_start_game_RF() end) end -- never use 'pcall' for something like this, on some executors it'll just pause execution for a while until it finds it, which is risky.

local function Get_LocalPlayers_Bowling_Ball()
    local player = getgenv().LocalPlayer or getgenv().Players.LocalPlayer or game.Players.LocalPlayer
    if not player then return nil end

    local player_lane_id = player:GetAttribute("BowlingLaneId")
    local resolved_lane_id = player_lane_id
    local resolved_lane_name
    local replicated_lanes = ReplicatedStorage:FindFirstChild("BowlingLanes")
    local bowling_lanes = getgenv().bowling_folder_found or workspace:FindFirstChild("BowlingLanes")

    if replicated_lanes then
        if resolved_lane_id ~= nil then
            for _, model in ipairs(replicated_lanes:GetDescendants()) do
                if model:IsA("Model") then
                    local model_lane_id = model:GetAttribute("LaneId")
                    if model_lane_id ~= nil and tostring(model_lane_id) == tostring(resolved_lane_id) then
                        resolved_lane_name = model.Name
                        break
                    end
                end
            end
        end

        if resolved_lane_id == nil then
            for _, folder in ipairs(replicated_lanes:GetChildren()) do
                if folder:IsA("Folder") then
                    local host_user_id = folder:GetAttribute("HostUserId")
                    if host_user_id ~= nil and tostring(host_user_id) == tostring(player.UserId) then
                        resolved_lane_id = folder.Name
                        break
                    end
                end
            end
        end

        if resolved_lane_name == nil and resolved_lane_id ~= nil then
            for _, model in ipairs(replicated_lanes:GetDescendants()) do
                if model:IsA("Model") then
                    local model_lane_id = model:GetAttribute("LaneId")
                    if model_lane_id ~= nil and tostring(model_lane_id) == tostring(resolved_lane_id) then
                        resolved_lane_name = model.Name
                        break
                    end
                end
            end
        end
    end

    if not bowling_lanes then return nil end
    if resolved_lane_id == nil and resolved_lane_name == nil then return nil end

    if resolved_lane_name then
        local direct_match = bowling_lanes:FindFirstChild(resolved_lane_name, true)
        if direct_match and direct_match:IsA("Model") then
            local ball = direct_match:FindFirstChild("Ball", true)
            if ball and ball:IsA("BasePart") then
                return ball, direct_match
            end
        end
    end

    for _, model in ipairs(bowling_lanes:GetDescendants()) do
        if model:IsA("Model") then
            local model_lane_id = model:GetAttribute("LaneId")
            local lane_id_match = (resolved_lane_id ~= nil and model_lane_id ~= nil and tostring(model_lane_id) == tostring(resolved_lane_id))
            local lane_name_match = (resolved_lane_name ~= nil and model.Name == resolved_lane_name)

            if lane_id_match or lane_name_match then
                local ball = model:FindFirstChild("Ball", true)
                if ball and ball:IsA("BasePart") then
                    return ball, model
                end
            end
        end
    end

    return nil
end

local Character = getgenv().Character or LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait() or getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character or get_char(LocalPlayer, 5)
local HumanoidRootPart = getgenv().HumanoidRootPart or (Character and Character:FindFirstChild("HumanoidRootPart", true)) or (Character and Character:WaitForChild("HumanoidRootPart", 10)) or get_root(LocalPlayer, 5)
getgenv().unlock_char = getgenv().unlock_char or false
wait(0.1)
local function un_anchor()
    local currentCharacter = getgenv().Character or Character
    if not currentCharacter or not currentCharacter.Parent or not currentCharacter:IsDescendantOf(game) then
        local lp = LocalPlayer or getgenv().LocalPlayer
        if not lp then return end
        local newChar = lp.Character or lp.CharacterAdded:Wait()
        Character = newChar
        currentCharacter = newChar
        HumanoidRootPart = nil
    end

    for _, obj in ipairs(currentCharacter:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Anchored then
            obj.Anchored = false
        end
    end

    local hrp = getgenv().HumanoidRootPart or currentCharacter:FindFirstChild("HumanoidRootPart", true) or currentCharacter:WaitForChild("HumanoidRootPart", 2)
    local humanoid = getgenv().Humanoid or currentCharacter:FindFirstChildOfClass("Humanoid") or currentCharacter:WaitForChild("Humanoid", 2)

    if hrp then
        HumanoidRootPart = hrp
    end

    if humanoid then
        humanoid.WalkSpeed = 22.75
    end
end

if getgenv().FlamesLibrary and getgenv().FlamesLibrary.disconnect then getgenv().FlamesLibrary.disconnect("TheLanes_UnlockLoop") end
wait(0.2)
getgenv().FlamesLibrary.spawn("TheLanes_UnlockLoop", "spawn", function()
    while getgenv().unlock_char == true do
        task.wait()
        pcall(un_anchor)
    end
end)
wait(0.1)
if not getgenv().Character_Unlocker_The_Lanes_Connection then
    getgenv().Character_Unlocker_The_Lanes_Connection = true
    getgenv().FlamesLibrary.connect("TheLanes_CharacterAdded", LocalPlayer.CharacterAdded:Connect(function(char)
        Character = char
        HumanoidRootPart = nil

        if char then
            char:WaitForChild("HumanoidRootPart", 5)
            char:WaitForChild("Humanoid", 5)
            pcall(un_anchor)
        end
    end))
end

getgenv().beam_rgb_enabled = getgenv().beam_rgb_enabled or false
getgenv().flowrgb_beam = getgenv().flowrgb_beam or function(connname, speed, beams, toggle)
    local rs = getgenv().RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")

    if getgenv()[connname] then
        pcall(function() getgenv()[connname]:Disconnect() end)
        getgenv()[connname] = nil
    end

    if not toggle then
        return
    end

    local hue = 0
    getgenv()[connname] = rs.RenderStepped:Connect(function(dt)
        hue = (hue + (dt * speed)) % 1
        local col = Color3.fromHSV(hue, 1, 1)
        local seq = ColorSequence.new(col)
        local active_beams = beams
        if typeof(beams) == "function" then
            local ok, result = pcall(beams)
            if ok and typeof(result) == "table" then
                active_beams = result
            else
                active_beams = {}
            end
        end

        for _, beam in ipairs(active_beams or {}) do
            if beam and beam.Parent then
                beam.Color = seq
            end
        end
    end)
end

getgenv().instant_proximity_prompts = function(toggle)
    local Prox_Service = cloneref and cloneref(game:GetService("ProximityPromptService")) or game:GetService("ProximityPromptService")
    local lib = getgenv().FlamesLibrary

    getgenv()._prox_original_durations = getgenv()._prox_original_durations or {}

    if toggle == true then
        if lib.is_alive("instantpp") then
            lib.disconnect("instantpp")
        end

        getgenv().instantly_press_prox_prompts = true
        lib.connect("instantpp",
            Prox_Service.PromptShown:Connect(function(prompt)
                if not getgenv()._prox_original_durations[prompt] then
                    getgenv()._prox_original_durations[prompt] = prompt.HoldDuration
                end

                prompt.HoldDuration = 0
            end)
        )
    elseif toggle == false then
        if lib.is_alive("instantpp") then
            lib.disconnect("instantpp")

            for prompt, duration in pairs(getgenv()._prox_original_durations) do
                if prompt and prompt.Parent then
                    prompt.HoldDuration = duration
                end
            end

            getgenv().instantly_press_prox_prompts = false
            table.clear(getgenv()._prox_original_durations)
        else
            return getgenv().notify("Warning", "Instant ProximityPrompt(S) is not enabled.", 6)
        end
    end
end

local function get_aim_beams()
    local t = {}
    local char = getgenv().Character or getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character
    if not char then return t end

    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("Beam") and v.Name:lower():find("aim") then
            table.insert(t, v)
        end
    end
    return t
end

local function get_camera_module()
    local cached_module = getgenv().Activity_Camera_Module
    if cached_module and cached_module:IsA("ModuleScript") then
        return cached_module
    end

    for _, v in ipairs(getgenv().LocalPlayer:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("camera") then
            local p = v.Parent
            if p and p.Name:lower():find("activity") then
                getgenv().Activity_Camera_Module = v
                return v
            end
        end
    end

    return nil
end
wait(0.1)
if not getgenv().Activity_Camera_Module then task.spawn(function() get_camera_module() end) end
wait(0.1)
local cameraModule
if not low_level_executor() then
    cameraModule = require(getgenv().Activity_Camera_Module)
else
    cameraModule = getgenv().Activity_Camera_Module
end

local function force_release_camera()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local StarterPlayer = getgenv().StarterPlayer or cloneref and cloneref(game:GetService("StarterPlayer")) or game:GetService("StarterPlayer")
    local lp = getgenv().LocalPlayer or game.Players.LocalPlayer or cloneref(game:GetService("Players")).LocalPlayer or game:GetService("Players").LocalPlayer

    pcall(function() cam.CameraType = Enum.CameraType.Custom end) -- pcall(function() incase it's 'CameraType' is already 'Custom'.
    lp.CameraMinZoomDistance = StarterPlayer.CameraMinZoomDistance
    lp.CameraMaxZoomDistance = StarterPlayer.CameraMaxZoomDistance
    if cam.CameraSubject ~= getgenv().Character or cam.CameraSubject ~= getgenv().Humanoid or cam.CameraSubject ~= getgenv().Character:FindFirstChildOfClass("Humanoid") then
        cam.CameraSubject = getgenv().Humanoid or getgenv().Character or getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character or getgenv().Character:WaitForChild("Humanoid", 5) or game.Players.LocalPlayer.Character:WaitForChild("Humanoid", 5)
    end
end

local function unlock_cam()
    local cam = workspace.CurrentCamera
    if cam then
        pcall(function()
            cam.CameraType = Enum.CameraType.Custom
        end)
    end

    if cameraModule and typeof(cameraModule.releaseCamera) == "function" then
        pcall(cameraModule.releaseCamera)
    else
        force_release_camera()
        return 
    end

    if cam.CameraSubject ~= getgenv().Character or cam.CameraSubject ~= getgenv().Humanoid or cam.CameraSubject ~= getgenv().Character:FindFirstChildOfClass("Humanoid") then
        cam.CameraSubject = getgenv().Humanoid or getgenv().Character or getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character or getgenv().Character:WaitForChild("Humanoid", 5) or game.Players.LocalPlayer.Character:WaitForChild("Humanoid", 5)
    end
end

local function lock_cam(cframe, fov, duration) -- not gonna be used tbh.
    cameraModule.controlCamera({
        goalId = "ManualLock",
        cframe = cframe,
        fieldOfView = fov or 70,
        duration = duration or 1
    })
end

getgenv().FlamesLibrary.spawn("cameraUnlockListener", "spawn", function()
    local conn = UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end

        local keybinds = getgenv().Flames_Keybind_Configuration
        if not keybinds then return end

        if input.KeyCode and input.KeyCode.Name == keybinds.unlock_camera_string and getgenv().Unlock_Camera_Toggled then
            unlock_cam()
        end
    end)

    getgenv().FlamesLibrary.connect("cameraUnlockListener", conn)
end)
wait(0.1)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "🎳 | Flames Hub | The Lanes | 🎳",
    Icon = 0,
    LoadingTitle = "🎳 Welcome to, Flames Hub 🔥",
    LoadingSubtitle = "Produced by: Flames Hub",
    ShowText = "FLAMES",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "FlamesHubTheLanes"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "!!!",
        Subtitle = "!!!!!",
        Note = "No method of obtaining the key is provided.",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"."}
    }
})
wait(0.1)
local Tab = Window:CreateTab("🏠 Main 🏠", 0)
local Section = Tab:CreateSection("Main Section")
local Tab_2 = Window:CreateTab("🧍 Character 🧍", 0)
local Section_2 = Tab_2:CreateSection("Character Section")
local Tab_3 = Window:CreateTab("🎳 Ball 🎳", 0)
local Section_3 = Tab_3:CreateSection("Bowling Ball Section")
local Tab_4 = Window:CreateTab("🛠️ Game Config 🛠️", 0)
local Section_4 = Tab_4:CreateSection("Game Setup Configuration")
local Tab_5 = Window:CreateTab("🔨 Config 🔨", 0)
local Section_5 = Tab_5:CreateSection("Configuration and Keybinds Section")
local current_ball
local current_lane

getgenv().find_TS_notifications_module = function()
    local cached = getgenv().TS_notifications_module_main
    if cached and cached:IsA("ModuleScript") then
        return cached
    end

    for _, v in ipairs(getgenv().LocalPlayer:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("notifications") then
            local l = v.Parent
            local p = l.Name:lower()
            if l and l:IsA("Folder") and p:find("notifications") then
                getgenv().TS_notifications_module_main = v
                return v
            end
        end
    end

    return nil
end
wait(0.1)
if not getgenv().TS_notifications_module_main then task.spawn(function() find_TS_notifications_module() end) end

getgenv().find_constants_for_bowling = function()
    local cache = getgenv().bowling_constants_module
    if cache and cache:IsA("ModuleScript") then
        return cache
    end

    for _, v in ipairs(getgenv().LocalPlayer:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("constants") then
            local o = v.Parent
            local k = o.Name:lower()
            if o and k:find("bowling") and o:IsA("Folder") then
                getgenv().bowling_constants_module = v
                return v
            end
        end
    end

    return nil
end
wait(0.1)
if not getgenv().bowling_constants_module then task.spawn(function() find_constants_for_bowling() end) end

getgenv().find_TS_models_notifications_module = function()
    local cache = getgenv().replicated_storage_ts_notifications_module
    if cache and cache:IsA("ModuleScript") and cache:IsDescendantOf(game) then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("notification") then
            local u = v.Parent
            local r = u.Name:lower()

            if u and u:IsA("Folder") and r:find("notifications") then
                getgenv().replicated_storage_ts_notifications_module = v
                return v
            end
        end
    end

    return nil
end
wait(0.1)
if not getgenv().replicated_storage_ts_notifications_module then task.spawn(function() find_TS_models_notifications_module() end) end

getgenv().in_game_notification = function(text)
    if not low_level_executor() then
        pcall(function()
            local notify_module = require(getgenv().find_TS_notifications_module)
            local notify_keys_module = require(getgenv().bowling_constants_module)
            local notify_type_module = require(getgenv().replicated_storage_ts_notifications_module)

            if notify_module and notify_keys_module then
                notify_module.addNotification({
                    ["key"] = notify_keys_module.Request,
                    ["text"] = tostring(text),
                    ["type"] = notify_type_module.Success
                })
            end
        end)
    end
end

local function lane_id_matches(model, local_lane_id)
    if not model or not model:IsA("Model") then return false end
    local model_lane_id = model:GetAttribute("LaneId")
    if model_lane_id == nil or local_lane_id == nil then return false end
    return tostring(model_lane_id) == tostring(local_lane_id)
end

local function is_valid_returned_ball_part(obj)
    if not obj or not obj:IsA("BasePart") then return false end
    local collision_sound = obj:FindFirstChild("CollisionSound")
    local dynamic_sound = obj:FindFirstChild("DynamicSound")
    local ball_mesh = obj:FindFirstChild("BallMesh")
    return collision_sound and collision_sound:IsA("Sound")
        and dynamic_sound and dynamic_sound:IsA("Sound")
        and ball_mesh and ball_mesh:IsA("MeshPart")
end

local function is_live_ball(ball)
    return ball and ball:IsA("BasePart") and ball.Parent and ball:IsDescendantOf(game)
end

local function find_returned_ball_for_local_lane()
    local bowling_folder = getgenv().bowling_folder_found or (getgenv().get_bowling_lanes_folder and getgenv().get_bowling_lanes_folder())
    if not bowling_folder then return nil, nil end

    local local_lane_id = LocalPlayer:GetAttribute("BowlingLaneId")
    if local_lane_id == nil then return nil, nil end

    for _, lane_model in ipairs(bowling_folder:GetDescendants()) do
        if lane_model:IsA("Model") and lane_id_matches(lane_model, local_lane_id) then
            local returned_folder = lane_model:FindFirstChild("ReturnedBalls", true)
            if returned_folder and returned_folder:IsA("Folder") then
                for _, obj in ipairs(returned_folder:GetDescendants()) do
                    if is_valid_returned_ball_part(obj) then
                        return obj, lane_model
                    end
                end
            end
        end
    end

    return nil, nil
end

local ok, response = pcall(function()
    getgenv().in_game_notification("Welcome to Flames Hub, "..tostring(getgenv().LocalPlayer.DisplayName), 15)
end)

if not ok then
    print("[src/shared/games/notifications/notifications.tsx] Failed to produce notification prompt - error")
end

local function attach_removal_watcher(ball)
    getgenv().FlamesLibrary.disconnect("ball_removal_watch")
    getgenv().FlamesLibrary.connect("ball_removal_watch", ball.AncestryChanged:Connect(function(_, parent)
        if not parent then
            current_ball = nil
            current_lane = nil
        end
    end))
end

local function refresh_ball()
    local ball, lane = Get_LocalPlayers_Bowling_Ball()

    if not is_live_ball(ball) then
        ball, lane = find_returned_ball_for_local_lane()
    end

    if is_live_ball(ball) then
        current_ball = ball
        current_lane = lane
        attach_removal_watcher(ball)
    else
        current_ball = nil
        current_lane = nil
    end
end

local function start_ball_tracker()
    getgenv().FlamesLibrary.disconnect("ball_descendant_listener")

    local folder = getgenv().bowling_folder_found or (getgenv().get_bowling_lanes_folder and getgenv().get_bowling_lanes_folder())
    if not folder then
        current_ball = nil
        current_lane = nil
        return
    end

    local connection = folder.DescendantAdded:Connect(function(obj)
        if obj.Name == "Ball" or obj.Name == "ReturnedBalls" or obj.Name == "BallMesh" or obj.Name == "CollisionSound" or obj.Name == "DynamicSound" then
            getgenv().FlamesLibrary.spawn("ball_refresh_thread", "spawn", function()
                refresh_ball()
            end)
        end
    end)

    getgenv().FlamesLibrary.connect("ball_descendant_listener", connection)
    refresh_ball()
end

getgenv().FlamesLibrary.spawn("ball_tracker_init", "spawn", function()
    start_ball_tracker()
end)

local Current_Ball_Label = Tab_3:CreateLabel("Current Ball: "..tostring(current_ball or "None"), 0, Color3.fromRGB(40, 40, 40), false)

getgenv().FlamesLibrary.spawn("ball_label_updater", "spawn", function()
    while true do
        if Current_Ball_Label then
            local ball_name = current_ball and current_ball.Name or "None"
            if not ball_name:lower():find("ball") then
                Current_Ball_Label:Set("Current Ball: Temp-Ball", 0, Color3.fromRGB(40, 40, 40), false)
            else
                Current_Ball_Label:Set("Current Ball: "..ball_name, 0, Color3.fromRGB(40, 40, 40), false)
            end
        end
        task.wait(0.2)
    end
end)

getgenv().ball_weight_enabled = getgenv().ball_weight_enabled or false
getgenv().default_ball_props = getgenv().default_ball_props or nil
getgenv().modify_ball_weight = function(enable)
    if not current_ball then return end

    if enable then
        if not getgenv().default_ball_props then
            getgenv().default_ball_props = current_ball.CustomPhysicalProperties
        end

        local props = current_ball.CustomPhysicalProperties
        if props then
            current_ball.CustomPhysicalProperties = PhysicalProperties.new(
                props.Density * 1.08,
                props.Friction,
                props.Elasticity,
                props.FrictionWeight,
                props.ElasticityWeight
            )
        end
    else
        if getgenv().default_ball_props then
            current_ball.CustomPhysicalProperties = getgenv().default_ball_props
        end
    end
end

local function find_player_scripts_bowling_helper_module()
    local cache = getgenv().player_scripts_bowling_helper
    if cache and cache:IsA("ModuleScript") then
        return cache
    end

    for _, v in ipairs(getgenv().LocalPlayer:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("bowling") and v.Name:lower():find("helper") then
            getgenv().player_scripts_bowling_helper = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().player_scripts_bowling_helper then task.spawn(function() find_player_scripts_bowling_helper_module() end) end

local function find_points_text_label()
    local cache = getgenv().points_and_lane_text_label
    if cache and cache:IsA("TextLabel") and cache.Parent then
        return cache
    end

    for _, v in ipairs(PlayerGui:GetDescendants()) do
        if v:IsA("ImageButton") and v.BackgroundColor3 == Color3.fromRGB(246, 18, 255) then
            local frame = v.Parent
            if frame and frame:IsA("Frame") then
                local nameLower = frame.Name:lower()

                if nameLower:find("1") or nameLower:find("2") then
                    for _, child in ipairs(frame:GetDescendants()) do
                        if child:IsA("TextLabel") and child.Text:match("Lane") then
                            getgenv().points_and_lane_text_label = child
                            return child
                        end
                    end
                end
            end
        end
    end

    return nil
end
wait(0.1)
if not getgenv().points_and_lane_text_label then task.spawn(function() find_points_text_label() end) end

local function get_points_in_text_label(label)
    if not label then return end
    local text = label.Text or getgenv().points_and_lane_text_label
    local pts = tonumber(text:match("(%d+)%s*pts"))

    return pts
end

getgenv().get_is_my_turn = function()
    if not getgenv().player_scripts_bowling_helper then return false end
    local module = require(getgenv().player_scripts_bowling_helper)
    local getReplicationFolderFromLaneId = module and module.getReplicationFolderFromLaneId
    local function islocalplayerturn(lane_id)
        if not getReplicationFolderFromLaneId or typeof(getReplicationFolderFromLaneId) ~= "function" then
            getgenv().notify("Error", "Function not loaded or found: getReplicationFolderFromLaneId (broken / patched?)", 15)
            return false
        end
        local folder = getReplicationFolderFromLaneId(lane_id)
        if not folder then
            return false
        end
        return folder:GetAttribute("CurrentUserId") == getgenv().LocalPlayer.UserId
    end

    local bowling_lane_id = getgenv().LocalPlayer:GetAttribute("BowlingLaneId")
    if not bowling_lane_id then
        return false
    end

    return islocalplayerturn(bowling_lane_id) and true or false
end

local function update_lane_state()
    if getgenv().LocalPlayer:GetAttribute("BowlingLaneId") ~= nil then
        getgenv().is_currently_playing_in_a_lane = "playing"
    else
        getgenv().is_currently_playing_in_a_lane = "not_playing"
    end
end
wait(0.1)
if not getgenv().FlamesLibrary.is_alive("has_left_playing_lane_tracker") then
	update_lane_state()

	getgenv().FlamesLibrary.connect(
		"has_left_playing_lane_tracker",
		getgenv().LocalPlayer:GetAttributeChangedSignal("BowlingLaneId"):Connect(function()
			update_lane_state()
		end)
	)
end

local function find_ts_module_script_bowling()
    local cache = getgenv().signals_module_script_for_bowling_folder
    if cache and cache:IsA("ModuleScript") then
        return cache
    end

    for _, v in ipairs(getgenv().LocalPlayer:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("signals") then
            local p = v.Parent
            local n = p.Name:lower()
            if p and p:IsA("Folder") and n:find("bowling") then
                getgenv().signals_module_script_for_bowling_folder = v
                return v
            end
        end
    end

    return nil
end
wait(0.1)
if not getgenv().signals_module_script_for_bowling_folder then pcall(find_ts_module_script_bowling) end
wait(0.1)
if not low_level_executor() then
    local bowlingSignalsModule = require(getgenv().signals_module_script_for_bowling_folder)
    local bowlingSignals = bowlingSignalsModule.bowlingSignals
    local STAND_OFFSET = 0.08
    local AIM_OFFSET = 0.58
    local BALL_SPEED = 89.4
    local BALL_SPIN = 0

    getgenv().AutoBowl = function()
        local bowlingSignalsModule = require(getgenv().signals_module_script_for_bowling_folder)
        local bowlingSignals = bowlingSignalsModule.bowlingSignals
        local STAND_OFFSET = 0.08
        local AIM_OFFSET = 0.58
        local BALL_SPEED = 89.4
        local BALL_SPIN = 0

        bowlingSignals.launchBowlingBall:Fire(
            STAND_OFFSET,
            AIM_OFFSET,
            BALL_SPEED,
            BALL_SPIN
        )
    end
end
wait(0.1)
getgenv().launch_bowling_shot = function()
    if low_level_executor() then
        return getgenv().notify("Error", "Your executor cannot run this, no proper 'require' support.", 6)
    end

    local bowlingSignalsModule = require(getgenv().signals_module_script_for_bowling_folder)
    local bowlingSignals = bowlingSignalsModule.bowlingSignals
    local STAND_OFFSET = 0.08
    local AIM_OFFSET = 0.57
    local BALL_SPEED = 89.4
    local BALL_SPIN = 0
    local get_sig = getgenv().get_is_my_turn()
    task.wait() -- a little wait in between each use.
    if getgenv().LocalPlayer:GetAttribute("BowlingLaneId") and get_sig == true and getgenv().is_currently_playing_in_a_lane == "playing" then
        if getgenv().AutoBowl then
            getgenv().AutoBowl()
        end
    elseif get_sig == false then
        return 
    end

    -- [[ not in use for now ]] --
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.Q then
            getgenv().AutoBowl()
        end
    end)
end
wait(0.1)
getgenv().launch_bowling_shot()

getgenv().retry_open_lane_toggle = function(state)
    if state == true then
        if getgenv().FlamesLibrary.is_alive("retry_open_lane") then
            return
        end
        
        getgenv().FlamesLibrary.spawn("retry_open_lane", "spawn", function()
            local found_lane
            
            while true do
                task.wait(1)
                local ok, result = pcall(function()
                    return getgenv().get_currently_open_lane()
                end)
                
                if ok and result and result:IsA("Model") and result:IsDescendantOf(game) then
                    found_lane = result
                    break
                end
            end
            
            if found_lane then
                local lane_id = found_lane:GetAttribute("LaneId")
                
                if lane_id then
                    start_bowling_at_lane(lane_id)
                    
                    local begin_game_RF = getgenv().start_game_RF or getgenv().find_start_game_RF()
                    if begin_game_RF and begin_game_RF:IsA("RemoteFunction") then
                        pcall(function()
                            begin_game_RF:InvokeServer(lane_id)
                        end)
                    elseif not begin_game_RF then
                        begin_game_RF = ReplicatedStorage:FindFirstChild("startGame", true)

                        pcall(function()
                            begin_game_RF:InvokeServer(lane_id)
                        end)
                    end
                end
            end
        end)
    elseif state == false then
        if getgenv().FlamesLibrary.is_alive("retry_open_lane") then
            getgenv().FlamesLibrary.disconnect("retry_open_lane")
        end
    else
        return 
    end
end
wait(0.1)
getgenv().auto_farm_toggle = function(toggle)
    if toggle == true then
        getgenv().automatically_farming_bowling_games = true
        getgenv().automatically_farming_watching_game_done = true
        if getgenv().FlamesLibrary.is_alive("auto_farm_currently_enabled") then getgenv().FlamesLibrary.disconnect("auto_farm_currently_enabled") end
        wait(0.1)
        getgenv().FlamesLibrary.spawn("auto_farm_currently_enabled", "spawn", function()
            while getgenv().automatically_farming_bowling_games == true do
            task.wait(0.15)
                local get_sig = getgenv().get_is_my_turn()
                if get_sig == true and getgenv().is_currently_playing_in_a_lane == "playing" then
                    getgenv().launch_bowling_shot()
                end
            end
        end)
        task.wait()
        getgenv().FlamesLibrary.spawn("auto_farm_watching_game_done", "spawn", function()
            while getgenv().automatically_farming_watching_game_done == true do
                task.wait(0.15)
                local verify_pts = get_points_in_text_label(getgenv().points_and_lane_text_label)
                local Bowling_Lane_ID = getgenv().LocalPlayer:GetAttribute("BowlingLaneId")

                if verify_pts and verify_pts > 298 then
                    if Bowling_Lane_ID then
                        if getgenv().exit_game_RF and getgenv().exit_game_RF:IsA("RemoteFunction") then
                            getgenv().exit_game_RF:InvokeServer(Bowling_Lane_ID)
                        elseif not getgenv().exit_game_RF then
                            getgenv().exit_game_RF = ReplicatedStorage:FindFirstChild("leaveGame", true)
                        end
                        wait(0.2)
                        local ok, response = pcall(function()
                            getgenv().are_all_lanes_occupied()
                        end)

                        if not ok then
                            return getgenv().notify("Warning", "No lanes are currently open, try again later.", 7)
                        end

                        local begin_game_RF = getgenv().start_game_RF or getgenv().find_start_game_RF()
                        local res
                        repeat
                            task.wait(1)
                            local ok = pcall(function()
                                res = getgenv().get_currently_open_lane()
                            end)
                        until ok and res and res:IsA("Model") and res:IsDescendantOf(game)

                        if res and res.Parent and res:IsDescendantOf(game) then
                            if getgenv().notify then
                                getgenv().notify("Success", "Teleporting to open lane...", 5)
                            end
                            wait(0.2)
                            if getgenv().Character then
                                local laneCFrame = res:GetPivot()
                                local backwardsOffset = -laneCFrame.LookVector * 75

                                pcall(function() getgenv().Character:PivotTo(laneCFrame + backwardsOffset) end)
                            end
                        end

                        if res and res:IsA("Model") and res:IsDescendantOf(game) then
                            local convert_to_string = res:GetAttribute("LaneId")

                            start_bowling_at_lane(convert_to_string)
                            wait(0.3)
                            local ok, response = pcall(function() begin_game_RF:InvokeServer(convert_to_string) end)

                            if not ok then
                                if getgenv().notify then
                                    return getgenv().notify("Error", "An unexpected error occurred while calling RemoteFunction 'startGame', got response: "..tostring(response), 30)
                                else
                                    return 
                                end
                            else
                                if getgenv().notify then
                                    getgenv().notify("Success", "Game: "..tostring(convert_to_string).." has been started successfully.", 6)
                                end
                            end
                        elseif not res or res.ClassName ~= "Model" then
                            if getgenv().notify then
                                return getgenv().notify("Error", tostring(res).." was not found or is not a Model!", 6)
                            else
                                return 
                            end
                        end
                    end
                end
            end
        end)
    elseif toggle == false then
        getgenv().automatically_farming_bowling_games = false
        getgenv().automatically_farming_watching_game_done = false
        if getgenv().FlamesLibrary.is_alive("auto_farm_currently_enabled") then
            getgenv().FlamesLibrary.disconnect("auto_farm_currently_enabled")
        end
        if getgenv().FlamesLibrary.is_alive("auto_farm_watching_game_done") then
            getgenv().FlamesLibrary.disconnect("auto_farm_watching_game_done")
        end
    else
        return 
    end
end

local function find_bowling_helper_module()
    local cache = getgenv().found_bowling_helper_module_script
    if cache and cache:IsA("ModuleScript") then
        return cache
    end
    
    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("bowling") and v.Name:lower():find("helper") then
            getgenv().found_bowling_helper_module_script = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().found_bowling_helper_module_script then task.spawn(function() find_bowling_helper_module() end) end

getgenv().find_create_game_RF = function()
    local cached = getgenv().create_game_RF
    if cached and cached:IsA("RemoteFunction") then
        return cached 
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("create") and v.Name:lower():find("game") then
            getgenv().create_game_RF = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().create_game_RF then task.spawn(function() getgenv().find_create_game_RF() end) end

local function find_bowling_anims_folder()
    local cache = getgenv().bowling_animations_folder
    if cache and cache:IsA("Folder") then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("bowling") and v.Name:lower():find("animation") then
            getgenv().bowling_animations_folder = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().bowling_animations_folder then task.spawn(function() find_bowling_anims_folder() end) end
wait(0.1)
getgenv().apply_free_animations = function()
    local folder = getgenv().bowling_animations_folder or find_bowling_anims_folder()
    if not folder then return end

    for _, v in ipairs(folder:GetChildren()) do
        if v:IsA("Configuration") and v:GetAttribute("coins") and v:GetAttribute("coins") ~= nil then
            pcall(function() v:SetAttribute("coins", 0) end)
        end
    end
end
wait(0.2)
getgenv().apply_free_animations()

if getgenv().bowling_animations_folder then
    for _, v in ipairs(getgenv().bowling_animations_folder:GetChildren()) do
        if v:IsA("Configuration") then
            local coins = v:GetAttribute("coins")

            if coins ~= nil then
                table.insert(getgenv().Flames_Bowling_Animations, {
                    name = v.Name,
                    coins = coins,
                    instance = v
                })
            end
        end
    end
end

getgenv().bowling_anim_toggle = getgenv().bowling_anim_toggle or false
getgenv().bowling_anim_slug = getgenv().bowling_anim_slug or "slide"
wait(0.1)
getgenv().apply_anim_override_hook = function(toggled, slug)
    getgenv().bowling_anim_toggle = toggled

    if slug then
        getgenv().bowling_anim_slug = slug
    end
end

getgenv().find_configure_ten_pin_game_RF = function()
    local cached = getgenv().ten_pin_game_RF
    if cached and cached:IsA("RemoteFunction") then
        return cached
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("config") and v.Name:lower():find("tenpin") then
            getgenv().ten_pin_game_RF = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().ten_pin_game_RF then task.spawn(function() getgenv().find_configure_ten_pin_game_RF() end) end

getgenv().find_leave_game_RF = function()
    local cached = getgenv().exit_game_RF
    if cached and cached:IsA("RemoteFunction") then
        return cached
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteFunction") and v.Name:lower():find("leave") and v.Name:lower():find("game") then
            getgenv().exit_game_RF = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().exit_game_RF then task.spawn(function() getgenv().find_leave_game_RF() end) end

getgenv().bowling_pins_highlight_ESP = function(toggle)
    local state = getgenv().bowling_pins_esp_state or {cache = {}, monitorConn = nil, removeConn = nil, heartbeatConn = nil}
    getgenv().bowling_pins_esp_state = state
    getgenv().highlight_pins_enabled = (toggle ~= false)
    local cache = state.cache
    local function create_highlight(target)
        if not (target:IsA("BasePart") or target:IsA("Model")) then return end
        if cache[target] then return end

        local highlight = Instance.new("Highlight")
        highlight.Adornee = target
        highlight.FillColor = Color3.fromRGB(255, 100, 100)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillTransparency = 0.65
        highlight.OutlineTransparency = 0
        highlight.Parent = target

        cache[target] = highlight
    end

    local function remove_highlight(target)
        if cache[target] then
            cache[target]:Destroy()
            cache[target] = nil
        end
    end

    local function is_pin(instance)
        local name = instance.Name:lower()
        return name:match("^pin%d+$") ~= nil
    end

    local function highlight_pin_instance(pinObj)
        if pinObj:IsA("Model") then
            create_highlight(pinObj)
            return
        end

        if pinObj:IsA("BasePart") then
            create_highlight(pinObj)
        end
    end

    local function remove_pin_instance(pinObj)
        if pinObj:IsA("Model") then
            remove_highlight(pinObj)
            return
        end

        if pinObj:IsA("BasePart") then
            remove_highlight(pinObj)
        end
    end

    local function scan_model(model)
        for _, descendant in ipairs(model:GetDescendants()) do
            if is_pin(descendant) then
                highlight_pin_instance(descendant)
            end
        end
    end

    local bowling_lanes = getgenv().bowling_folder_found or workspace:WaitForChild("BowlingLanes")

    if toggle == false then
        for _, highlight in pairs(cache) do
            highlight.Enabled = false
        end
        return
    end

    scan_model(bowling_lanes)

    if not state.monitorConn then
        state.monitorConn = bowling_lanes.DescendantAdded:Connect(function(desc)
            if is_pin(desc) and getgenv().highlight_pins_enabled then
                highlight_pin_instance(desc)
            end
        end)
    end

    if not state.removeConn then
        state.removeConn = bowling_lanes.DescendantRemoving:Connect(function(desc)
            if is_pin(desc) then
                remove_pin_instance(desc)
            end
        end)
    end

    if not state.heartbeatConn then
        state.heartbeatConn = RunService.Heartbeat:Connect(function()
            for part, highlight in pairs(cache) do
                if not part.Parent then
                    remove_highlight(part)
                else
                    highlight.Enabled = getgenv().highlight_pins_enabled
                end
            end
        end)
    end
end

local function start_bowling_at_lane(lane)
    local cached = getgenv().create_game_RF
    if not cached then
        return getgenv().notify("Error", "Could not find 'createGame' RemoteFunction when trying to create a game.", 8)
    end
    local config_ten_pin_game = getgenv().ten_pin_game_RF or getgenv().find_configure_ten_pin_game_RF()
    if not config_ten_pin_game then
        return getgenv().notify("Error", "Could not find 'configureTenPinGame' RemoteFunction when trying to set the game rules.", 7)
    end
    local all_lanes_took = getgenv().are_all_lanes_occupied()
    if all_lanes_took then
        return getgenv().notify("Error", "All lanes are currently occupied, try again later.", 7)
    end

    local config_args = {
        tostring(lane),
        {
            maxPlayers = 4,
            playerJoinMode = "REQUEST",
            useBarriers = false,
            scoringMode = "STANDARD"
        }
    }
    wait(0.2)
    local args = {
        tostring(lane),
        "TEN_PIN"
    }

    local ok, response = pcall(function() cached:InvokeServer(unpack(args)) end)

    if not ok then
        return getgenv().notify("Error", "An unexpected error occurred when trying to create game: "..tostring(response), 25)
    end
    wait(0.4)
    local ok, response = pcall(function() config_ten_pin_game:InvokeServer(unpack(config_args)) end)

    if not ok then
        return getgenv().notify("Error", "An unexpected error occurred when trying to configure game: "..tostring(response), 25)
    end
end

local function start_bowling_with_config(lane)
    local create_game = getgenv().create_game_RF
    if not create_game then
        return getgenv().notify("Error", "Could not find 'createGame' RemoteFunction when trying to create a game.", 8)
    end

    local configure_game = getgenv().ten_pin_game_RF or getgenv().find_configure_ten_pin_game_RF()
    if not configure_game then
        return getgenv().notify("Error", "Could not find 'configureTenPinGame' RemoteFunction when trying to set the game rules.", 7)
    end

    if getgenv().are_all_lanes_occupied() then
        return getgenv().notify("Error", "All lanes are currently occupied, try again later.", 7)
    end

    local cfg = getgenv().Flames_Bowling_Configuration or {}
    local config_args = {
        tostring(lane),
        {
            maxPlayers = tonumber(cfg.maxPlayers) or 4,
            playerJoinMode = tostring(cfg.playerJoinMode or "REQUEST"),
            useBarriers = (cfg.useBarriers == true),
            scoringMode = tostring(cfg.scoringMode or "STANDARD")
        }
    }

    local create_args = { tostring(lane), "TEN_PIN" }

    task.wait(0.2)
    local ok_create, create_err = pcall(function()
        create_game:InvokeServer(unpack(create_args))
    end)
    if not ok_create then
        return getgenv().notify("Error", "An unexpected error occurred when trying to create game: " .. tostring(create_err), 25)
    end

    task.wait(0.4)
    local ok_config, config_err = pcall(function()
        configure_game:InvokeServer(unpack(config_args))
    end)
    if not ok_config then
        return getgenv().notify("Error", "An unexpected error occurred when trying to configure game: " .. tostring(config_err), 25)
    end
end
wait(0.2)
getgenv().Start_Default_Game = Tab:CreateButton({
Name = "Start game with set configuration (FE)",
Callback = function()
    local ok, response = pcall(function()
        getgenv().are_all_lanes_occupied()
    end)

    if not ok then
        return getgenv().notify("Warning", "No lanes are currently open, try again later.", 7)
    end

    local begin_game_RF = getgenv().start_game_RF or getgenv().find_start_game_RF()
    local res = getgenv().get_currently_open_lane()

    if res and res.Parent and res:IsDescendantOf(game) then
        getgenv().notify("Success", "Teleporting to open lane...", 5)
        wait(0.2)
        if getgenv().Character then
            local laneCFrame = res:GetPivot()
            local backwardsOffset = -laneCFrame.LookVector * 75

            pcall(function() getgenv().Character:PivotTo(laneCFrame + backwardsOffset) end)
        end
    end

    if res and res:IsA("Model") and res:IsDescendantOf(game) then
        local convert_to_string = res:GetAttribute("LaneId")

        start_bowling_with_config(convert_to_string)
        wait(0.3)
        local ok, response = pcall(function() begin_game_RF:InvokeServer(convert_to_string) end)

        if not ok then
            return getgenv().notify("Error", "An unexpected error occurred while calling RemoteFunction 'startGame', got response: "..tostring(response), 30)
        else
            getgenv().notify("Success", "Game: "..tostring(convert_to_string).." has been started successfully.", 6)
        end
    elseif not res or res.ClassName ~= "Model" then
        return getgenv().notify("Error", tostring(res).." was not found or is not a Model!", 6)
    end
end,})

local function set_unlock_keybind(key)
    getgenv().Unlock_Keybind_Configuration:Set(key)
    getgenv().Flames_Keybind_Configuration.unlock_camera_string = key
    getgenv().Flames_Keybind_Configuration.unlock_camera = Enum.KeyCode[key]
    getgenv().notify(
        "Success",
        "Keybind for unlock_cam() changed to: "..key,
        3.5
    )
end

getgenv().Unlock_Cam_Toggle = Tab:CreateButton({
Name = "Unlock Camera (working!)",
Callback = function()
    local ok, response = pcall(function()
        unlock_cam()
    end)

    if not ok then
        return getgenv().notify("Error", "An unexpected error occurred while calling 'unlock_cam', got response: "..tostring(response), 20)
    end
end,})

getgenv().Unlock_Keybind_Configuration = Tab_5:CreateKeybind({
Name = "Unlock Camera Keybind",
CurrentKeybind = getgenv().Flames_Keybind_Configuration.unlock_camera_string or "F",
HoldToInteract = false,
Flag = "ChangeUnlockCameraKeybindToggle",
Callback = function()
    wait(0.12)
    if not getgenv().Unlock_Camera_Toggled then return end
    local set_key = getgenv().Unlock_Keybind_Configuration.CurrentKeybind or keycode_to_string(getgenv().Unlock_Keybind_Configuration.CurrentKeybind)
    wait(0.2)
    local converted_keycode = string_to_keycode(set_key)

    if set_key and converted_keycode then
        getgenv().Flames_Keybind_Configuration.unlock_camera = converted_keycode
        getgenv().Flames_Keybind_Configuration.unlock_camera_string = set_key
        wait(0.2)
        if getgenv().Flames_Keybind_Configuration.unlock_camera == converted_keycode then
            if not getgenv().print_notification_keybind_change then
                print("[src/client/interface.client.tsx:98] Keybind published to (main) from (client) as data: "..tostring(converted_keycode))
                getgenv().print_notification_keybind_change = true
            end
        end
    else
        return getgenv().notify("Error", "An unexpected error occurred when setting data "..tostring(set_key).." | "..tostring(converted_keycode).." | value entered to: 'unlock_camera_string' was / is: "..tostring(set_key), 30)
    end

    unlock_cam()
end,})

getgenv().Unlock_Camera_Toggle_Keybind = Tab_5:CreateToggle({
Name = "Toggle Use Unlock Camera Keybind",
CurrentValue = getgenv().Unlock_Camera_Toggled or false,
Flag = "UnlockCameraKeybindInUse",
Callback = function(is_keybind_enabled)
    if is_keybind_enabled then
        getgenv().Unlock_Camera_Toggled = true
    else
        getgenv().Unlock_Camera_Toggled = false
    end
end,})

getgenv().Start_Default_Game = Tab:CreateButton({
Name = "Start default game (FE)",
Callback = function()
    local ok, response = pcall(function()
        getgenv().are_all_lanes_occupied()
    end)

    if not ok then
        return getgenv().notify("Warning", "No lanes are currently open, try again later.", 7)
    end

    local begin_game_RF = getgenv().start_game_RF or getgenv().find_start_game_RF()
    local res = getgenv().get_currently_open_lane()

    if res and res.Parent and res:IsDescendantOf(game) then
        getgenv().notify("Success", "Teleporting to open lane...", 3)
        wait(0.2)
        if getgenv().Character then
            local laneCFrame = res:GetPivot()
            local backwardsOffset = -laneCFrame.LookVector * 75

            pcall(function() getgenv().Character:PivotTo(laneCFrame + backwardsOffset) end)
        end
    end

    if res and res:IsA("Model") and res:IsDescendantOf(game) then
        local convert_to_string = res:GetAttribute("LaneId")

        start_bowling_at_lane(convert_to_string)
        wait(0.3)
        local ok, response = pcall(function() begin_game_RF:InvokeServer(convert_to_string) end)

        if not ok then
            return getgenv().notify("Error", "An unexpected error occurred while calling RemoteFunction 'startGame', got response: "..tostring(response), 30)
        else
            getgenv().notify("Success", "Game: "..tostring(convert_to_string).." has been started successfully.", 6)
        end
    elseif not res or res.ClassName ~= "Model" then
        return getgenv().notify("Error", tostring(res).." was not found or is not a Model!", 6)
    end
end,})

getgenv().Flames_Bowling_Configuration.maxPlayers = getgenv().Flames_Bowling_Configuration.maxPlayers or 4
getgenv().MaxPlayers_For_Games = Tab_4:CreateSlider({
Name = "Set Max Players (FE)",
Range = {1, 5},
Increment = 1,
Suffix = "",
CurrentValue = tonumber(getgenv().Flames_Bowling_Configuration.maxPlayers) or 4,
Flag = "BowlingConfigMaxPlayersSlider",
Callback = function(max_plrs_val)
    getgenv().Flames_Bowling_Configuration.maxPlayers = tonumber(max_plrs_val) or 4
end,})
wait(0.2)
getgenv().MaxPlayers_For_Games:Set(tonumber(getgenv().Flames_Bowling_Configuration.maxPlayers) or 4)

getgenv().Flames_Bowling_Configuration.playerJoinMode = getgenv().Flames_Bowling_Configuration.playerJoinMode or "REQUEST"
getgenv().MaxPlayers_For_Games = Tab_4:CreateDropdown({
Name = "Set Player Join Type (FE)",
Options = {"REQUEST", "FRIENDS", "OPEN"},
CurrentOption = {getgenv().Flames_Bowling_Configuration.playerJoinMode},
MultipleOptions = false,
Flag = "SetPlayerJoiningModeForGames",
Callback = function(join_type)
    local selected = join_type

    if typeof(selected) == "table" then
        selected = selected[1]
    end

    if typeof(selected) ~= "string" then
        return getgenv().notify("Error", "Invalid playerJoinMode selection.", 5)
    end

    getgenv().Flames_Bowling_Configuration.playerJoinMode = selected
end,})

getgenv().Flames_Bowling_Configuration.useBarriers = getgenv().Flames_Bowling_Configuration.useBarriers or false
getgenv().Set_Use_Barriers = Tab_4:CreateToggle({
Name = "Set Use Barriers (FE)",
CurrentValue = getgenv().Flames_Bowling_Configuration.useBarriers or false,
Flag = "UseBarriersToggleForGames",
Callback = function(using_barriers)
    if using_barriers then
        getgenv().Flames_Bowling_Configuration.useBarriers = true
    else
        getgenv().Flames_Bowling_Configuration.useBarriers = false
    end
end,})

getgenv().Flames_Bowling_Configuration.scoringMode = getgenv().Flames_Bowling_Configuration.scoringMode or "STANDARD"
getgenv().MaxPlayers_For_Games = Tab_4:CreateDropdown({
Name = "Set Scoring Type (FE)",
Options = {"STANDARD", "WORLD"},
CurrentOption = {getgenv().Flames_Bowling_Configuration.scoringMode},
MultipleOptions = false,
Flag = "SetScoringModeForGames",
Callback = function(scoring_mode)
    local selected = scoring_mode
    if typeof(selected) == "table" then selected = selected[1] end
    if typeof(selected) ~= "string" then return getgenv().notify("Error", "Invalid scoringMode selection.", 5) end
    if selected == "WORLD" then
        getgenv().MaxPlayers_For_Games:Set({"STANDARD"})
        selected = "STANDARD"
        getgenv().notify("Error", "The game will break with the selection: 'WORLD', we changed it back to 'STANDARD' for you (they don't support it yet).", 25)
    end
    wait(0.2)
    getgenv().Flames_Bowling_Configuration.scoringMode = selected
end,})

getgenv().Mod_Arcade_Points = Tab:CreateButton({
Name = "Mod Arcade Points (FE)",
Callback = function()
    getgenv().mod_arcade_high_score()
end,})

getgenv().RGB_Bowling_Ball = Tab_3:CreateToggle({
Name = "RGB Bowling Ball",
CurrentValue = getgenv().RGB_Bowling_Ball_Enabled or false,
Flag = "BowlingBallSwitchingColorsNotFE",
Callback = function(rgb_ball)
    getgenv().RGB_Bowling_Ball_Enabled = rgb_ball
    local function is_valid_rgb_ball(ball)
        return ball and typeof(ball) == "Instance" and ball:IsA("BasePart") and ball.Name == "Ball" and ball.Parent and ball:IsDescendantOf(game)
    end
    local function get_ball_mesh(ball)
        if not is_valid_rgb_ball(ball) then
            return nil
        end
        local mesh = ball:FindFirstChildWhichIsA("MeshPart")
        if mesh then
            return mesh
        end
        return ball:FindFirstChildWhichIsA("MeshPart", true)
    end
    local function set_ball_visual_state(ball, enabled)
        if not is_valid_rgb_ball(ball) then
            return
        end
        local mesh = get_ball_mesh(ball)
        if enabled then
            pcall(function() ball.Transparency = 0 end)
            if mesh then
                pcall(function() mesh.Transparency = 1 end)
            end
        else
            pcall(function() ball.Transparency = 1 end)
            if mesh then
                pcall(function() mesh.Transparency = 0 end)
            end
        end
    end

    if rgb_ball then
        local last_target = nil
        getgenv().FlamesLibrary.spawn("RGB_Bowling_Ball_Monitor", "spawn", function()
            while getgenv().RGB_Bowling_Ball_Enabled == true do
                local target = is_valid_rgb_ball(current_ball) and current_ball or nil
                if target ~= last_target then
                    if last_target then
                        set_ball_visual_state(last_target, false)
                    end
                    if target then
                        set_ball_visual_state(target, true)
                        getgenv().flowrgb("RGB_Bowling_Ball_Conn", 1.5, target, true)
                        getgenv().RGB_Bowling_Ball_LastTarget = target
                    else
                        getgenv().flowrgb("RGB_Bowling_Ball_Conn", 1.5, nil, false)
                        getgenv().RGB_Bowling_Ball_LastTarget = nil
                    end
                    last_target = target
                end
                task.wait(0.2)
            end
            if last_target then
                set_ball_visual_state(last_target, false)
                getgenv().RGB_Bowling_Ball_LastTarget = nil
            end
            getgenv().flowrgb("RGB_Bowling_Ball_Conn", 0.6, nil, false)
        end)
    else
        if getgenv().FlamesLibrary and getgenv().FlamesLibrary.disconnect then
            getgenv().FlamesLibrary.disconnect("RGB_Bowling_Ball_Monitor")
        end
        local fallback_ball = getgenv().RGB_Bowling_Ball_LastTarget or current_ball
        if is_valid_rgb_ball(fallback_ball) then
            set_ball_visual_state(fallback_ball, false)
        end
        getgenv().RGB_Bowling_Ball_LastTarget = nil
        getgenv().flowrgb("RGB_Bowling_Ball_Conn", 0.6, nil, false)
    end
end,})

local function find_physics_module()
    local cached = getgenv().bowling_physics_module_found
    if cached and cached:IsA("ModuleScript") then
        return cached
    end

    for _, v in ipairs(getgenv().LocalPlayer:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name:lower():find("bowl") and v.Name:lower():find("physic") then
            getgenv().bowling_physics_module_found = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().bowling_physics_module_found then task.spawn(function() find_physics_module() end) end
getgenv().force_straight_bowl = getgenv().force_straight_bowl or false
getgenv().force_no_spin_enabled = getgenv().force_no_spin_enabled or false
getgenv().bowl_only_strikes_man = getgenv().bowl_only_strikes_man or false
getgenv().bowl_strike_aim_offset = getgenv().bowl_strike_aim_offset or 0.57
getgenv().force_bowl_speed_enabled = getgenv().force_bowl_speed_enabled or false
getgenv().forced_bowl_speed = getgenv().forced_bowl_speed or 90
getgenv().force_stand_offset_enabled = getgenv().force_stand_offset_enabled or false
getgenv().forced_bowl_stand_offset = tonumber(getgenv().forced_bowl_stand_offset) or 3
getgenv().bowl_right_step_offset = tonumber(getgenv().bowl_right_step_offset) or 2
getgenv().force_heavier_ball_enabled = getgenv().force_heavier_ball_enabled or false
getgenv().extra_ball_weight_lbs = tonumber(getgenv().extra_ball_weight_lbs) or 5
getgenv().zooming_hook_setup_for_client = getgenv().zooming_hook_setup_for_client or false

if not getgenv().zooming_hook_setup_for_client then
    if hookfunction and getgc then
        getgenv().zooming_hook_setup_for_client = true
        local scroll_delta = 0
        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseWheel then
                scroll_delta = -input.Position.Z
            end
        end)

        for _, v in pairs(getgc(true)) do
            if type(v) == "table" then
                local ok, val = pcall(function() return rawget(v, "getZoomDelta") end)
                if ok and type(val) == "function" then
                    hookfunction(val, function(p43)
                        local delta = scroll_delta
                        scroll_delta = 0
                        return delta
                    end)
                    break
                end
            end
        end
    else
        getgenv().zooming_hook_setup_for_client = true
    end
end

local function install_perform_bowl_hook()
    if not hookfunction then
        return false, "missing hookfunction"
    end

    local players = getgenv().Players or game:GetService("Players")
    local lp = getgenv().LocalPlayer or players.LocalPlayer
    local moduleScript = getgenv().bowling_physics_module_found or (find_physics_module and find_physics_module()) or lp.PlayerScripts.TS.games.bowling["bowling-physics"]
    local bowlingPhysics = require(moduleScript)

    if getgenv()._PerformBowl_MainHooked and getgenv()._PerformBowl_MainOld then
        bowlingPhysics.performBowl = getgenv()._PerformBowl_MainOld
        getgenv()._PerformBowl_MainOld = nil
        getgenv()._PerformBowl_MainHooked = false
        getgenv()._oldPerformBowl = nil
        getgenv()._performBowlHooked = false
    end

    local old
    old = hookfunction(bowlingPhysics.performBowl, newcclosure(function(laneId, standOffset, aimOffset, speed, spin, animCfg)
        if getgenv().bowling_anim_toggle and animCfg then
            animCfg.animationSlug = getgenv().bowling_anim_slug or animCfg.animationSlug
        end

        if getgenv().bowling_preset_lock_enabled then
            aimOffset = tonumber(getgenv().bowl_strike_aim_offset) or aimOffset
        end

        if getgenv().force_stand_offset_enabled then
            standOffset = tonumber(getgenv().forced_bowl_stand_offset) or standOffset
        end
        standOffset = (tonumber(standOffset) or 0) + (tonumber(getgenv().bowl_right_step_offset) or 0)

        if getgenv().bowl_only_strikes_man then
            aimOffset = tonumber(getgenv().bowl_strike_aim_offset) or aimOffset
            spin = 0
        elseif getgenv().force_straight_bowl or getgenv().force_no_spin_enabled or getgenv().bowling_preset_lock_enabled then
            spin = 0
        end

        if getgenv().force_bowl_speed_enabled then
            speed = tonumber(getgenv().forced_bowl_speed) or speed
        end
        if getgenv().force_heavier_ball_enabled then
            speed = math.max(1, (tonumber(speed) or 0) - (tonumber(getgenv().extra_ball_weight_lbs) or 0))
        end

        return old(laneId, standOffset, aimOffset, speed, spin, animCfg)
    end))

    getgenv()._PerformBowl_MainOld = old
    getgenv()._PerformBowl_MainHooked = true
    getgenv()._oldPerformBowl = old
    getgenv()._performBowlHooked = true
    return true
end

local function ensure_perform_bowl_hook_active()
    if getgenv()._PerformBowl_MainHooked and getgenv()._PerformBowl_MainOld then
        return true
    end
    if not hookfunction then
        return false, "missing hookfunction"
    end
    return install_perform_bowl_hook()
end

local function uninstall_perform_bowl_hook()
    local old = getgenv()._PerformBowl_MainOld -- already hooked?
    if not old then
        getgenv()._PerformBowl_MainHooked = false
        getgenv()._performBowlHooked = false
        return true
    end

    local players = getgenv().Players or game:GetService("Players")
    local lp = getgenv().LocalPlayer or players.LocalPlayer
    local moduleScript = getgenv().bowling_physics_module_found or (find_physics_module and find_physics_module()) or lp.PlayerScripts.TS.games.bowling["bowling-physics"]
    local success, bowlingPhysics = pcall(function()
        return require(moduleScript)
    end)
    
    if success then
        bowlingPhysics.performBowl = old
    else
        getgenv()._PerformBowl_MainOld = nil
        getgenv()._PerformBowl_MainHooked = false
        getgenv()._oldPerformBowl = nil
        getgenv()._performBowlHooked = false
        return getgenv().notify("Your executor does not support 'require'!", 6)
    end

    getgenv()._PerformBowl_MainOld = nil
    getgenv()._PerformBowl_MainHooked = false
    getgenv()._oldPerformBowl = nil
    getgenv()._performBowlHooked = false
    return true
end

local BOWLING_PRESET_LOCK_VALUES = {
    speed = 87.4,
    aimOffset = 0.57,
    standOffset = 0.08,
    rightStepOffset = 0.07,
    extraWeight = 8
}

local function apply_bowling_preset_lock_values()
    getgenv().force_bowl_speed_enabled = true
    getgenv().forced_bowl_speed = BOWLING_PRESET_LOCK_VALUES.speed
    getgenv().bowl_strike_aim_offset = BOWLING_PRESET_LOCK_VALUES.aimOffset
    getgenv().force_stand_offset_enabled = true
    getgenv().forced_bowl_stand_offset = BOWLING_PRESET_LOCK_VALUES.standOffset
    getgenv().bowl_right_step_offset = BOWLING_PRESET_LOCK_VALUES.rightStepOffset
    getgenv().force_heavier_ball_enabled = true
    getgenv().extra_ball_weight_lbs = BOWLING_PRESET_LOCK_VALUES.extraWeight
    getgenv().force_straight_bowl = true
    getgenv().force_no_spin_enabled = true
end

local function start_bowling_preset_lock_loop()
    if getgenv().FlamesLibrary and getgenv().FlamesLibrary.is_alive and getgenv().FlamesLibrary.spawn then
        if not getgenv().FlamesLibrary.is_alive("TheLanes_BowlingPresetLockLoop") then
            getgenv().FlamesLibrary.spawn("TheLanes_BowlingPresetLockLoop", "spawn", function()
                while getgenv().bowling_preset_lock_enabled == true do
                    task.wait(0.1)
                    apply_bowling_preset_lock_values()
                end
            end)
        end
        return
    end

    if getgenv()._bowlingPresetLoopRunning then
        return
    end
    -- [[ I think the code below here is unnecessary. ]] --
    --[[
        getgenv()._bowlingPresetLoopRunning = true
        task.spawn(function()
            while getgenv().bowling_preset_lock_enabled == true do
                task.wait(0.1)
                apply_bowling_preset_lock_values()
            end
            getgenv()._bowlingPresetLoopRunning = false
        end)
    --]]
end

getgenv().toggle_bowling_preset_lock = function(state)
    local enabled = state
    if enabled == nil then
        enabled = not (getgenv().bowling_preset_lock_enabled == true)
    else
        enabled = (state == true)
    end

    if enabled then
        local ok, err = ensure_perform_bowl_hook_active()
        if not ok then
            if getgenv().notify then
                getgenv().notify("Error", "Preset hook failed: "..tostring(err), 10)
            end
            return false, err
        end

        getgenv().bowling_preset_lock_enabled = true
        getgenv()._preset_prev_force_straight_bowl = getgenv().force_straight_bowl
        getgenv()._preset_prev_force_no_spin_enabled = getgenv().force_no_spin_enabled
        apply_bowling_preset_lock_values()
        start_bowling_preset_lock_loop()

        if getgenv().Force_Stand_Offset and getgenv().Force_Stand_Offset.Set then
            pcall(function() getgenv().Force_Stand_Offset:Set(true) end)
        end
        if getgenv().Force_Stand_Offset_Value and getgenv().Force_Stand_Offset_Value.Set then
            pcall(function() getgenv().Force_Stand_Offset_Value:Set(BOWLING_PRESET_LOCK_VALUES.standOffset) end)
        end
        if getgenv().Right_Step_Offset and getgenv().Right_Step_Offset.Set then
            pcall(function() getgenv().Right_Step_Offset:Set(BOWLING_PRESET_LOCK_VALUES.rightStepOffset) end)
        end
        if getgenv().Force_Heavier_Ball and getgenv().Force_Heavier_Ball.Set then
            pcall(function() getgenv().Force_Heavier_Ball:Set(true) end)
        end
        if getgenv().Extra_Ball_Weight and getgenv().Extra_Ball_Weight.Set then
            pcall(function() getgenv().Extra_Ball_Weight:Set(BOWLING_PRESET_LOCK_VALUES.extraWeight) end)
        end

        if getgenv().notify then
            getgenv().notify("Success", "Bowling preset lock enabled.", 6)
        end
        return true
    end

    getgenv().bowling_preset_lock_enabled = false
    getgenv().force_bowl_speed_enabled = false
    getgenv().force_stand_offset_enabled = false
    getgenv().bowl_right_step_offset = 0
    getgenv().force_heavier_ball_enabled = false
    getgenv().extra_ball_weight_lbs = 0
    if getgenv()._preset_prev_force_straight_bowl ~= nil then
        getgenv().force_straight_bowl = getgenv()._preset_prev_force_straight_bowl
        getgenv()._preset_prev_force_straight_bowl = nil
    else
        getgenv().force_straight_bowl = false
    end
    if getgenv()._preset_prev_force_no_spin_enabled ~= nil then
        getgenv().force_no_spin_enabled = getgenv()._preset_prev_force_no_spin_enabled
        getgenv()._preset_prev_force_no_spin_enabled = nil
    else
        getgenv().force_no_spin_enabled = false
    end

    if getgenv().Force_Stand_Offset and getgenv().Force_Stand_Offset.Set then
        pcall(function() getgenv().Force_Stand_Offset:Set(false) end)
    end
    if getgenv().Right_Step_Offset and getgenv().Right_Step_Offset.Set then
        pcall(function() getgenv().Right_Step_Offset:Set(0) end)
    end
    if getgenv().Force_Heavier_Ball and getgenv().Force_Heavier_Ball.Set then
        pcall(function() getgenv().Force_Heavier_Ball:Set(false) end)
    end
    if getgenv().Extra_Ball_Weight and getgenv().Extra_Ball_Weight.Set then
        pcall(function() getgenv().Extra_Ball_Weight:Set(0) end)
    end

    local ok, err = pcall(uninstall_perform_bowl_hook)
    if not ok then
        if getgenv().notify then
            getgenv().notify("Warning", "Preset disabled, hook restore failed: "..tostring(err), 10)
        end
        return false, err
    end

    if getgenv().notify then
        getgenv().notify("Success", "Bowling preset lock disabled and hook restored.", 6)
    end
    return true
end
wait(0.1)
getgenv().BowlOnlyStrikes = Tab_3:CreateToggle({
Name = "Bowl Strikes (FE)",
CurrentValue = getgenv().bowling_preset_lock_enabled or false,
Flag = "BowlingOnlyStrikesEasily",
Callback = function(bowling_strikes_easily)
    if bowling_strikes_easily then
        local function get_random_module()
            for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("ModuleScript") then
                    local h = v.Parent
                    if h and h:IsA("Folder") then
                        return v
                    end
                end
            end
        end

        local found_random_mod = get_random_module()
        task.wait()
        local ok, response = pcall(function()
            require(found_random_mod)
        end)

        if not ok then
            return getgenv().notify("Error", "We apologize, but, you cannot use this, your executor does not support: 'require'!", 12)
        else
            if not getgenv().notification_for_automatically_bowling_sent then
                print("[src/shared/helpers/shop-helper.ts:17] Data transmitted successfully to version 0264277 (main)")
                getgenv().notification_for_automatically_bowling_sent = true
            end
        end
        task.wait(0.1) -- don't make a big delay for the users who have (actual) 'require' function support.
        pcall(function() getgenv().NoBall_SpinEz_Strikes:Set(false) end)
        pcall(function() getgenv().Force_Stand_Offset:Set(false) end)
        pcall(function() getgenv().Edit_Strike_Aim_Offset:Set(0.57) end)
        pcall(function() getgenv().Edit_Bowling_Speed_Offset:Set(89.4) end)
        pcall(function() getgenv().Force_Stand_Offset:Set(false) end)
        pcall(function() getgenv().Force_Stand_Offset_Value:Set(0.08) end)
        pcall(function() getgenv().Right_Step_Offset:Set(0.07) end)
        pcall(function() getgenv().Force_Heavier_Ball:Set(false) end)
        pcall(function() getgenv().Extra_Ball_Weight:Set(8) end)
        pcall(function() getgenv().BowlStrikes_EveryTime:Set(false) end)
        wait(0.3)
        getgenv().toggle_bowling_preset_lock(true)
        wait(0.2)
        getgenv().modify_ball_weight(true)
    else
        getgenv().toggle_bowling_preset_lock(false)
        wait(0.2)
        getgenv().modify_ball_weight(false)
    end
end,})

getgenv().NoBall_SpinEz_Strikes = Tab_3:CreateToggle({
Name = "No Ball Spin (FE)",
CurrentValue = getgenv().force_straight_bowl or false,
Flag = "EzNoBallSpinWorking",
Callback = function(no_ball_spin_toggled)
    if not hookfunction then
        getgenv().force_straight_bowl = false
        getgenv().NoBall_SpinEz_Strikes:Set(false)
        return getgenv().notify("Error", "You cannot run this, missing function: 'hookfunction'.", 10)
    end

    local ok, err = install_perform_bowl_hook()
    if not ok then
        getgenv().force_straight_bowl = false
        getgenv().NoBall_SpinEz_Strikes:Set(false)
        return getgenv().notify("Error", "No Ball Spin hook failed: "..tostring(err), 10)
    end

    getgenv().force_straight_bowl = no_ball_spin_toggled
    getgenv().force_no_spin_enabled = no_ball_spin_toggled
end,})

getgenv().bowl_strike_aim_offset = tonumber(getgenv().bowl_strike_aim_offset) or 0.57
getgenv().Edit_Strike_Aim_Offset = Tab_3:CreateSlider({
Name = "Bowling Aim Offset",
Range = {-1, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = getgenv().bowl_strike_aim_offset or 0.57,
Flag = "BowlStrikeAimOffsetDynamic",
Callback = function(new_offset)
    getgenv().bowl_strike_aim_offset = tonumber(new_offset) or 0
end,})

getgenv().forced_bowl_speed = tonumber(getgenv().forced_bowl_speed) or 90
getgenv().Edit_Bowling_Speed_Offset = Tab_3:CreateSlider({
Name = "Bowling Speed",
Range = {25, 500},
Increment = 0.1,
Suffix = "",
CurrentValue = getgenv().forced_bowl_speed or 90,
Flag = "BowlStrikeSpeedDynamic",
Callback = function(new_speed)
    getgenv().forced_bowl_speed = tonumber(new_speed) or 0
end,})

getgenv().force_stand_offset_enabled = getgenv().force_stand_offset_enabled or false
getgenv().Force_Stand_Offset = Tab_3:CreateToggle({
Name = "Force Stand Offset (FE)",
CurrentValue = getgenv().force_stand_offset_enabled or false,
Flag = "ForceStandOffsetToggle",
Callback = function(v)
    if v then
        local ok, err = ensure_perform_bowl_hook_active()
        if not ok then
            getgenv().force_stand_offset_enabled = false
            getgenv().Force_Stand_Offset:Set(false)
            return getgenv().notify("Error", "Stand Offset hook failed: "..tostring(err), 10)
        end
    end
    getgenv().force_stand_offset_enabled = v
end,})

getgenv().forced_bowl_stand_offset = tonumber(getgenv().forced_bowl_stand_offset) or 0
getgenv().Force_Stand_Offset_Value = Tab_3:CreateSlider({
Name = "Stand Offset Lock",
Range = {-6, 6},
Increment = 0.01,
Suffix = "",
CurrentValue = getgenv().forced_bowl_stand_offset or 0,
Flag = "ForceStandOffsetValue",
Callback = function(v)
    getgenv().forced_bowl_stand_offset = tonumber(v) or 0
end,})

getgenv().bowl_right_step_offset = tonumber(getgenv().bowl_right_step_offset) or 0
getgenv().Right_Step_Offset = Tab_3:CreateSlider({
Name = "Right Step Offset",
Range = {-3, 3},
Increment = 0.01,
Suffix = "",
CurrentValue = getgenv().bowl_right_step_offset or 0,
Flag = "BowlRightStepOffset",
Callback = function(v)
    if tonumber(v) ~= 0 then
        local ok, err = ensure_perform_bowl_hook_active()
        if not ok then
            getgenv().bowl_right_step_offset = 0
            getgenv().Right_Step_Offset:Set(0)
            return getgenv().notify("Error", "Right step hook failed: "..tostring(err), 10)
        end
    end
    getgenv().bowl_right_step_offset = tonumber(v) or 0
end,})

getgenv().force_heavier_ball_enabled = getgenv().force_heavier_ball_enabled or false
getgenv().Force_Heavier_Ball = Tab_3:CreateToggle({
Name = "Heavier Ball Effect (FE)",
CurrentValue = getgenv().force_heavier_ball_enabled or false,
Flag = "ForceHeavierBallEffect",
Callback = function(v)
    if v then
        local ok, err = ensure_perform_bowl_hook_active()
        if not ok then
            getgenv().force_heavier_ball_enabled = false
            getgenv().Force_Heavier_Ball:Set(false)
            return getgenv().notify("Error", "Heavier Ball hook failed: "..tostring(err), 10)
        end
    end
    getgenv().force_heavier_ball_enabled = v
end,})

getgenv().extra_ball_weight_lbs = tonumber(getgenv().extra_ball_weight_lbs) or 0
getgenv().Extra_Ball_Weight = Tab_3:CreateSlider({
Name = "Extra Ball Weight (lbs)",
Range = {0, 8},
Increment = 0.01,
Suffix = "",
CurrentValue = getgenv().extra_ball_weight_lbs or 0,
Flag = "ExtraBallWeightLbs",
Callback = function(v)
    if tonumber(v) ~= 0 then
        local ok, err = ensure_perform_bowl_hook_active()
        if not ok then
            getgenv().extra_ball_weight_lbs = 0
            getgenv().Extra_Ball_Weight:Set(0)
            return getgenv().notify("Error", "Ball weight hook failed: "..tostring(err), 10)
        end
    end
    getgenv().extra_ball_weight_lbs = tonumber(v) or 0
end,})

local Recommended_Aim_Offset = Tab_3:CreateLabel("Recommended Aim Offset: 0.56", 0, Color3.fromRGB(40, 40, 40), false)
local Recommended_Bowling_Speed = Tab_3:CreateLabel("Recommended Bowling Speed: 89", 0, Color3.fromRGB(40, 40, 40), false)

getgenv().BowlStrikes_EveryTime = Tab_3:CreateToggle({
Name = "Bowl with set Offset and Speed (FE)",
CurrentValue = getgenv().bowl_only_strikes_man or false,
Flag = "BowlLiterallyOnlyStrikes",
Callback = function(bowling_strikes)
    if not hookfunction then
        getgenv().BowlStrikes_EveryTime:Set(false)
        getgenv().force_straight_bowl = false
        getgenv().bowl_only_strikes_man = false
        return getgenv().notify("Error", "Your executor cannot run this, missing function: 'hookfunction'.", 8)
    end

    local ok, err = install_perform_bowl_hook()
    if not ok then
        getgenv().bowl_only_strikes_man = false
        getgenv().BowlStrikes_EveryTime:Set(false)
        return getgenv().notify("Error", "No Ball Spin hook failed: "..tostring(err), 10)
    end

    getgenv().bowl_only_strikes_man = bowling_strikes
    if bowling_strikes then
        getgenv().force_bowl_speed_enabled = true
        getgenv().force_straight_bowl = false
    else
        getgenv().bowl_only_strikes_man = false
    end
end,})

getgenv().Leave_Current_Game = Tab:CreateButton({
Name = "Leave Current Lane (FE)",
Callback = function()
    local main = getgenv().exit_game_RF
    if not main then
        return getgenv().notify("Error", "An error occurred when trying to find 'leaveGame' RemoteFunction | Not Found.", 8)
    end
    local current_lane_id = LocalPlayer:GetAttribute("BowlingLaneId")
    if not current_lane_id then
        return getgenv().notify("Warning", "You're not currently in a game.", 7)
    end

    local ok, response = pcall(function() main:InvokeServer(current_lane_id) end)
    if not ok then
        return getgenv().notify("Error", "An unexpected error occurred while calling 'leaveGame' RemoteFunction, got response: "..tostring(response), 25)
    else
        getgenv().notify("Success", "Left game: "..tostring(current_lane_id), 10)
    end
end,})

getgenv().Pins_Highlight_ESP = Tab:CreateToggle({
Name = "Pins ESP",
CurrentValue = getgenv().highlight_pins_enabled or false,
Flag = "PinsToggleableESP",
Callback = function(pins_esp_toggle)
    if pins_esp_toggle then
        getgenv().bowling_pins_highlight_ESP(true)
    else
        getgenv().bowling_pins_highlight_ESP(false)
    end
end,})

getgenv().Character_Unlocker_Free_Move_FE = Tab_2:CreateToggle({
Name = "Character Unlocker (Free Move, FE)",
CurrentValue = getgenv().unlock_char or false,
Flag = "UnlockCharacterEvenOnRespawnWhenBowling",
Callback = function(unlock)
    getgenv().unlock_char = unlock
    if getgenv().FlamesLibrary.is_alive("TheLanes_UnlockLoop") then
        getgenv().FlamesLibrary.disconnect("TheLanes_UnlockLoop")
    end

    if unlock then
        getgenv().FlamesLibrary.spawn("TheLanes_UnlockLoop", "spawn", function()
            while getgenv().unlock_char == true do
                task.wait()
                pcall(un_anchor)
            end
        end)
    else
        getgenv().unlock_char = false
        getgenv().FlamesLibrary.disconnect("TheLanes_UnlockLoop")
    end
end,})

getgenv().animation_names = {}
getgenv().animation_lookup = {}

for _, data in ipairs(getgenv().Flames_Bowling_Animations or {}) do
    table.insert(getgenv().animation_names, data.name)
    getgenv().animation_lookup[data.name] = data
end

local default_animation = getgenv().bowling_anim_slug

if not getgenv().animation_lookup[default_animation] then
    default_animation = getgenv().animation_names[1]
end

getgenv().PickBowlAnimation = Tab_2:CreateDropdown({
Name = "Set Bowling Animation (FE, FREE!)",
Options = getgenv().animation_names,
CurrentOption = {default_animation},
MultipleOptions = false,
Flag = "SelectingBowlAnimationFE",
Callback = function(anim_selected)
    local selected_name = anim_selected[1]
    local selected_data = getgenv().animation_lookup[selected_name]

    if selected_data then
        getgenv().Selected_Bowling_Animation = selected_name
        getgenv().Selected_Bowling_Animation_Instance = selected_data.instance
        getgenv().Selected_Bowling_Animation_Coins = selected_data.coins

        if getgenv().apply_anim_override_hook and typeof(getgenv().apply_anim_override_hook) == "function" then
            getgenv().apply_anim_override_hook(true, selected_name)
        else
            getgenv().bowling_anim_slug = selected_name
            getgenv().bowling_anim_toggle = true
        end
    end
end,})

getgenv().Instant_ProximityPrompts_Toggle = Tab_2:CreateToggle({
Name = "Instant Proximity Prompt(S)",
CurrentValue = getgenv().instantly_press_prox_prompts or false,
Flag = "InstantProxPromptsFlames",
Callback = function(enabled)
    getgenv().instant_proximity_prompts(enabled)
end,})

local function get_aim_beam_main(char)
    local get_char = char
        or getgenv().Character
        or (getgenv().LocalPlayer and getgenv().LocalPlayer.Character)
        or game.Players.LocalPlayer.Character

    if not get_char then
        return nil
    end

    for _, v in ipairs(get_char:GetChildren()) do
        if v:IsA("Beam") and v.Name:lower():find("aim") then
            return v
        end
    end

    return nil
end

getgenv().apply_beam_width = function()
    local beam = get_aim_beam_main()
    if not beam then return end

    local value = getgenv().Edit_Beam_Width
        and getgenv().Edit_Beam_Width.CurrentValue

    if typeof(value) ~= "number" then return end

    beam.Width0 = value
    beam.Width1 = value
end

getgenv().FlamesLibrary.spawn("aimBeamWatcher", "spawn", function()
    local lp = getgenv().LocalPlayer or Players.LocalPlayer or getgenv().Players.LocalPlayer or game.Players.LocalPlayer

    local function watch_character(char)
        if not char then return end
        task.defer(apply_beam_width)

        getgenv().FlamesLibrary.connect("aimBeamChildAdded_"..char:GetDebugId(), char.ChildAdded:Connect(function(child) -- very VERY safe btw.
            if child:IsA("Beam") and child.Name:lower():find("aim") then
                task.wait()
                apply_beam_width()
            end
        end))
    end

    if lp.Character or getgenv().Character or game.Players.LocalPlayer.Character then
        watch_character(lp.Character or getgenv().Character or getgenv().Players.LocalPlayer.Character or getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character)
    end

    getgenv().FlamesLibrary.connect("aimBeamCharacterAdded", lp.CharacterAdded:Connect(watch_character))
end)

local current_beam = get_aim_beam_main()
local default_width = 0.2
if current_beam and current_beam:IsA("Beam") then
    default_width = tonumber(current_beam.Width0) or 0.2
end
task.wait(0.2)
getgenv().Edit_Beam_Width = Tab:CreateSlider({
Name = "Edit AimBeam Width",
Range = {0, 10},
Increment = 0.1,
Suffix = "",
CurrentValue = getgenv().aim_beam_editing_width_sizes or default_width,
Flag = "AimBeamWidthModifications",
Callback = function(new_beam_width)
    local aim_beam = get_aim_beam_main()
    if not aim_beam then
        return 
    end

    if not aim_beam:IsA("Beam") then
        return getgenv().notify("Error", "AimBeam was found, but is not a Beam.", 3)
    end
    if not aim_beam:IsDescendantOf(game) then
        return getgenv().notify("Error", "AimBeam is no longer in the game.", 3)
    end

    if aim_beam then
        aim_beam.Width0 = new_beam_width
        aim_beam.Width1 = new_beam_width
        getgenv().aim_beam_editing_width_sizes = new_beam_width
    end
end,})

local rainbow_colors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 60, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 180, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(180, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 255, 127),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(0, 180, 255),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(60, 0, 255),
    Color3.fromRGB(139, 0, 255),
    Color3.fromRGB(180, 0, 255),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(255, 0, 180),
    Color3.fromRGB(255, 0, 127),
    Color3.fromRGB(255, 0, 60),
}

getgenv().Rainbow_RGB_Beam = Tab:CreateToggle({
Name = "RGB AimBeam",
CurrentValue = getgenv().beam_rgb_enabled or false,
Flag = "RainbowAimBeamNotFE",
Callback = function(rgb_beam)
    if getgenv().path2d_rgb_conn then
        pcall(function() getgenv().path2d_rgb_conn:Disconnect() end)
        getgenv().path2d_rgb_conn = nil
    end
    if rgb_beam then
        getgenv().beam_rgb_enabled = true
        getgenv().flowrgb_beam("AimBeamRGBConn", 0.5, get_aim_beams, getgenv().beam_rgb_enabled)
        local rs = cloneref(game:GetService("RunService"))
        local Players = cloneref(game:GetService("Players"))
        local color_timer = 0
        getgenv().path2d_rgb_conn = rs.RenderStepped:Connect(function(dt)
            color_timer = (color_timer + dt * 2) % #rainbow_colors
            local index = math.floor(color_timer)
            local next_index = (index + 1) % #rainbow_colors
            local alpha = color_timer - index
            local col = rainbow_colors[index + 1]:Lerp(rainbow_colors[next_index + 1], alpha)
            local Player_Gui = getgenv().PlayerGui or Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local Main_GUI = Player_Gui and Player_Gui:FindFirstChild("ReactGui")
            if not Main_GUI then return end
            for _, v in ipairs(Main_GUI:GetDescendants()) do
                if v:IsA("Path2D") and v.Parent and v.Parent.Name == "Minimap" and v.Parent.Parent and v.Parent.Parent.Name == "Aim" then
                    v.Color3 = col
                end
            end
        end)
    else
        getgenv().beam_rgb_enabled = false
        getgenv().flowrgb_beam("AimBeamRGBConn", 0.5, {}, false)
    end
end,})

-- for debugging --
local function Dump_Ball_Contents(ball)
    if not ball then return end
    if not set_clip_board then
        return getgenv().notify("Error", "setclipboard does not work on your executor!", 6)
    end
    local output = {}
    local function format_value(v)
        local t = typeof(v)
        if t == "Vector3" then
            return string.format("Vector3(%.6f, %.6f, %.6f)", v.X, v.Y, v.Z)
        elseif t == "Vector2" then
            return string.format("Vector2(%.6f, %.6f)", v.X, v.Y)
        elseif t == "CFrame" then
            local c = {v:GetComponents()}
            return string.format("CFrame(%.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f, %.6f)", c[1], c[2], c[3], c[4], c[5], c[6], c[7], c[8], c[9], c[10], c[11], c[12])
        elseif t == "Color3" then
            return string.format("Color3(%.6f, %.6f, %.6f)", v.R, v.G, v.B)
        elseif t == "BrickColor" then
            return tostring(v.Number) .. ":" .. tostring(v.Name)
        elseif t == "UDim2" or t == "UDim" or t == "Rect" then
            return tostring(v)
        elseif t == "EnumItem" then
            return tostring(v)
        elseif t == "Instance" then
            return v:GetFullName()
        elseif t == "PhysicalProperties" then
            return string.format("PhysicalProperties(Density=%.6f,Friction=%.6f,Elasticity=%.6f,FrictionWeight=%.6f,ElasticityWeight=%.6f)", v.Density, v.Friction, v.Elasticity, v.FrictionWeight, v.ElasticityWeight)
        else
            return tostring(v)
        end
    end

    local common_props = {"Name", "ClassName", "Archivable", "Parent"}
    local basepart_props = {"Anchored", "CanCollide", "CanTouch", "CanQuery", "Massless", "Size", "Position", "CFrame", "Orientation", "Rotation", "Velocity", "RotVelocity", "AssemblyLinearVelocity", "AssemblyAngularVelocity", "Color", "BrickColor", "Material", "MaterialVariant", "Transparency", "Reflectance", "CollisionGroup", "CustomPhysicalProperties", "RootPriority"}
    local meshpart_props = {"MeshId", "TextureID", "RenderFidelity"}
    local sound_props = {"SoundId", "Volume", "PlaybackSpeed", "TimePosition", "TimeLength", "Looped", "PlayOnRemove", "EmitterSize", "RollOffMode", "RollOffMinDistance", "RollOffMaxDistance", "Playing"}
    local model_props = {"PrimaryPart", "WorldPivot"}
    local attachment_props = {"Position", "Orientation", "Axis", "SecondaryAxis", "WorldPosition", "WorldOrientation", "Visible"}
    local specialmesh_props = {"MeshType", "MeshId", "TextureId", "Scale"}
    local function recurse(obj, prefix)
        prefix = prefix or ""
        table.insert(output, prefix .. obj:GetFullName() .. " | Class=" .. obj.ClassName)

        for _, p in ipairs(common_props) do
            local ok, val = pcall(function() return obj[p] end)
            if ok then
                table.insert(output, prefix .. "  Property:" .. tostring(p) .. "=" .. format_value(val))
            end
        end

        if obj:IsA("BasePart") then
            for _, p in ipairs(basepart_props) do
                local ok, val = pcall(function() return obj[p] end)
                if ok then
                    table.insert(output, prefix .. "  Property:" .. tostring(p) .. "=" .. format_value(val))
                end
            end
        end

        if obj:IsA("MeshPart") then
            for _, p in ipairs(meshpart_props) do
                local ok, val = pcall(function() return obj[p] end)
                if ok then
                    table.insert(output, prefix .. "  Property:" .. tostring(p) .. "=" .. format_value(val))
                end
            end
        end

        if obj:IsA("Sound") then
            for _, p in ipairs(sound_props) do
                local ok, val = pcall(function() return obj[p] end)
                if ok then
                    table.insert(output, prefix .. "  Property:" .. tostring(p) .. "=" .. format_value(val))
                end
            end
        end

        if obj:IsA("Model") then
            for _, p in ipairs(model_props) do
                local ok, val = pcall(function() return obj[p] end)
                if ok then
                    table.insert(output, prefix .. "  Property:" .. tostring(p) .. "=" .. format_value(val))
                end
            end
        end

        if obj:IsA("Attachment") then
            for _, p in ipairs(attachment_props) do
                local ok, val = pcall(function() return obj[p] end)
                if ok then
                    table.insert(output, prefix .. "  Property:" .. tostring(p) .. "=" .. format_value(val))
                end
            end
        end

        if obj:IsA("SpecialMesh") then
            for _, p in ipairs(specialmesh_props) do
                local ok, val = pcall(function() return obj[p] end)
                if ok then
                    table.insert(output, prefix .. "  Property:" .. tostring(p) .. "=" .. format_value(val))
                end
            end
        end

        local attrs = obj:GetAttributes()
        for prop_name, val in pairs(attrs) do
            table.insert(output, prefix .. "  Attribute:" .. tostring(prop_name) .. "=" .. format_value(val))
        end

        for _, child in ipairs(obj:GetChildren()) do
            recurse(child, prefix .. "  ")
        end
    end

    recurse(ball)
    local result = table.concat(output, "\n")
    pcall(function() set_clip_board(result) end)
end

getgenv().CopyAllBowlingBallParts = Tab:CreateButton({
Name = "Copy All Bowling Ball parts and properties (everything)",
Callback = function()
    local ball = Get_LocalPlayers_Bowling_Ball()

    if not ball then
        return getgenv().notify("Error", "Ball doesn't exist or was not found.", 6)
    end
    if not set_clip_board then
        return getgenv().notify("Error", "setclipboard does not work on your executor!", 6)
    end

    Dump_Ball_Contents(ball)
    getgenv().notify("Success", "Copied Bowling Ball properties and it's descendants/children from: "..tostring(ball), 15)
end,})

getgenv().CopyBowlingBallFullPathLoc = Tab:CreateButton({
Name = "[DEBUG]: Copy Bowling Ball Full Path",
Callback = function()
    local ball = Get_LocalPlayers_Bowling_Ball()

    if not ball then
        return getgenv().notify("Error", "Ball doesn't exist or was not found.", 6)
    end
    if not set_clip_board then
        return getgenv().notify("Error", "setclipboard does not work on your executor!", 6)
    end

    set_clip_board(tostring(ball:GetFullName()))
    getgenv().notify("Success", "Copied: "..tostring(ball).."'s Path to your clipboard!", 15)
end,})

getgenv().CopyBowlingBallFullPathLoc = Tab:CreateButton({
Name = "[DEBUG]: Copy Bowling Ball Folder",
Callback = function()
    local folder = getgenv().bowling_folder_found or (getgenv().get_bowling_lanes_folder and getgenv().get_bowling_lanes_folder())

    if not folder then
        return getgenv().notify("Error", "Bowling Folder doesn't exist or was not found.", 6)
    end
    if not set_clip_board then
        return getgenv().notify("Error", "setclipboard does not work on your executor!", 6)
    end

    set_clip_board(folder:GetFullName())
    getgenv().notify("Success", "Copied Bowling Ball Folder: "..tostring(folder).."'s Path to your clipboard!", 15)
end,})
