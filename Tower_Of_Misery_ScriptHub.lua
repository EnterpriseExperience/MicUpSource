if not game:IsLoaded() then game.Loaded:Wait() end

if not getgenv().GlobalEnvironmentFramework_Initialized then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua'))()
    wait(0.1)
    getgenv().GlobalEnvironmentFramework_Initialized = true
end
wait(0.5)
if not getgenv().blankfunction then
    local function blankfunction(...)
        return ...
    end
end
local cloneref = cloneref or blankfunction
local Raw_Version = "2.0.7"
local Script_Version = tostring(Raw_Version.."-TOM")
local g = getgenv()
getgenv().Game = cloneref and cloneref(game) or game
getgenv().cloneref = cloneref or blankfunction
getgenv().JobID = game.JobId
getgenv().PlaceID = game.PlaceId

local valid_titles = {success="Success",info="Info",warning="Warning",error="Error",succes="Success",sucess="Success",eror="Error",erorr="Error",warnin="Warning"}
local function format_title(str)
	if typeof(str) ~= "string" then
		return "Info"
	end

	local key = str:lower()
	return valid_titles[key] or "Info"
end

getgenv().notify = getgenv().notify or function(title, msg, dur)
   local fixed_title = format_title(title)
   NotifyLib:External_Notification(fixed_title, tostring(msg), tonumber(dur))
end

g.Service_Wrap = g.Service_Wrap or function(name)
    name = tostring(name)

    if setmetatable then
        if not g._service_cache then
            g._service_cache = setmetatable({}, {
                __index = function(self, index)
                    local svc = game:GetService(index)

                    if cloneref and svc then
                        svc = cloneref(svc)
                    end

                    self[index] = svc
                    return svc
                end
            })
        end

        return g._service_cache[name]
    end

    local svc = game:GetService(name)

    if cloneref and svc then
        svc = cloneref(svc)
    end

    return svc
end

local function getExecutor()
    local name
    if identifyexecutor then
        name = identifyexecutor()
    end
    return { Name = name or "Unknown Executor"}
end

local function executor_details()
    local executorDetails = getExecutor()
    return string.format("%s", executorDetails.Name)
end

local executor_Name = executor_details()

getgenv().randomString = getgenv().randomString or function()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

local cmdp = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local cmdlp = cmdp.LocalPlayer
getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
getgenv().httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
get_http = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
getgenv().queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
queueteleport = getgenv().queueteleport

local function init_services()
    local services = {
        "Players",
        "Workspace",
        "Lighting",
        "ReplicatedStorage",
        "TweenService",
        "RunService",
        "MaterialService",
        "ReplicatedFirst",
        "Teams",
        "StarterPack",
        "StarterPlayer",
        "VoiceChatInternal",
        "VoiceChatService",
        "CoreGui",
        "SoundService",
        "StarterGui",
        "MarketplaceService",
        "TeleportService",
        "Chat",
        "AssetService",
        "HttpService",
        "UserInputService",
        "TextChatService",
        "ContextActionService",
        "GuiService",
        "PhysicsService"
    }

    for _, serviceName in pairs(services) do
        getgenv()[serviceName] = cloneref and cloneref(getgenv().Game:GetService(serviceName)) or getgenv().Game:GetService(serviceName)
    end
end
wait()
init_services()
task.wait()
local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
task.wait(0.2)
getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain") or getgenv().Workspace:FindFirstChildOfClass("Terrain")
getgenv().Camera = getgenv().Workspace.CurrentCamera or workspace.CurrentCamera or getgenv().Workspace:FindFirstChild("Camera")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer or cloneref and cloneref(game:GetService("Players")).LocalPlayer or game:GetService("Players").LocalPlayer
getgenv().Backpack = getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack") or getgenv().LocalPlayer:WaitForChild("Backpack", 5)
getgenv().PlayerGui = getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui") or getgenv().LocalPlayer:WaitForChild("PlayerGui", 5)
getgenv().PlayerScripts = getgenv().LocalPlayer:FindFirstChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerScripts") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerScripts") or getgenv().LocalPlayer:WaitForChild("PlayerScripts", 5)
local Anti_Ragdoll_Active = false
local Inf_Stamina_Active = false

wait(0.2)
-- This is here to automatically fix the warning messages in the console, so you don't have to respawn to apply it.
-- Your welcome.
local function find_char_init_localscript_main()
    for _, v in ipairs(getgenv().Character:GetDescendants()) do
        if v:IsA("LocalScript") and v.Name:lower():find("char") and v.Name:lower():find("init") then
            return v
        end
    end
    for _, v in ipairs(getgenv().PlayerScripts:GetDescendants()) do

    end
end

if getgenv().Character and getgenv().Character:FindFirstChild("Character Initializer", true) then
    getgenv().Character:FindFirstChild("Character Initializer", true).Disabled = true
end

if not getgenv().CharInitializerUpdaterConns then
    getgenv().CharInitializerUpdaterConns = true

    local function chr_updater(char)
        if not char or not char.Parent then return end
        local init = char:FindFirstChild("Character Initializer", true)
        if init and init:IsA("LocalScript") and init.Enabled ~= false then
            init.Enabled = false
        end
    end

    do
        local c = g.Character or g.LocalPlayer.Character
        if c and c.Parent then
            task.spawn(function()
                chr_updater(c)
            end)
        else
            task.spawn(function()
                repeat task.wait() until g.LocalPlayer.Character and g.LocalPlayer.Character.Parent
                local ch = g.LocalPlayer.Character
                repeat task.wait() until ch:FindFirstChild("Humanoid")
                chr_updater(ch)
            end)
        end
    end

    g.LocalPlayer.CharacterAdded:Connect(function(char)
        if not char or not char.Parent then
            repeat task.wait() until char and char.Parent
        end
        repeat task.wait() until char:FindFirstChild("Humanoid")

        task.spawn(function()
            chr_updater(char)
        end)
    end)
end

local Remote_Events = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events", true)
local General_Folder = getgenv().LocalPlayer:FindFirstChild("General", true)
local General_Folder_RE = Remote_Events:FindFirstChild("General", true)
local Update_Setting_RE = General_Folder_RE:FindFirstChild("Update_Settings", true)
local Crate_System_V2 = getgenv().ReplicatedStorage:FindFirstChild("Crate_System_V2", true)
local Crate_System_Remote_Events = Crate_System_V2:FindFirstChild("Remote_Events", true)
local Open_Crate_RE = Crate_System_Remote_Events:FindFirstChild("Open_Crate", true)
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or getgenv().LocalPlayer
-- [[ You're welcome once more, more correctly detects the Height Meter V2 GUI and it's spammy errors. ]] --
function remove_height_meter()
    for _, v in ipairs(Players:GetDescendants()) do
        local n = v.Name:lower()
        if v:IsA("ScreenGui") and n:find("height") and n:find("meter") then
            for _, k in ipairs(v:GetDescendants()) do
                if k:IsA("LocalScript") and k.Name == "LocalScript" then
                    k:Destroy()
                end
            end
        end
    end
end

-- [[ Disables the annoying other errors that come from the Client Side GUI Temporary LocalScript. ]] --
function disable_client_side()
    for _, v in ipairs(getgenv().PlayerGui:GetDescendants()) do
        local n = v.Name:lower()
        if v:IsA("ScreenGui") and n:find("client") and n:find("side") and n:find("gui") then
            local ls = v:FindFirstChild("Temporary", true)
            if ls and ls:IsA("LocalScript") then
                ls.Disabled = true
            end
        end
    end
end

-- [[ I called them down here. ]] --
remove_height_meter()
disable_client_side()

-- [[ Shuts the "Fling Glove" error up in the console. -- ]]
for _, v in ipairs(getgenv().PlayerGui:GetDescendants()) do
    local n = v.Name:lower()
    if v:IsA("Frame") and n:find("general") then
        local ls = v:FindFirstChild("fling") or v:FindFirstChild("Fling Glove UI", true)
        if not ls then
            for _, k in ipairs(v:GetDescendants()) do
                local kn = k.Name:lower()
                if k:IsA("LocalScript") and kn:find("fling") and kn:find("glove") and kn:find("ui") then
                    ls = k
                    break
                end
            end
        end
        
        if ls and ls:IsA("LocalScript") then
            ls.Disabled = true
        end
    end
end

function bypass_anticheat()
    if not hookmetamethod then
        if getgenv().notify then
            return getgenv().notify("Error", "Your executor does not support the Tower Of Misery script hub! (cannot bypass anti-cheat)", 30)
        else
            return warn("Your executor does not support the Tower Of Misery script hub!")
        end
    end
    if getgenv().ac_bypass_already_loaded then
        return getgenv().notify("error", "Anti-Cheat bypass already loaded.", 7)
    end

    getgenv().ac_bypass_already_loaded = true
    local g_r_s = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local g_remote_f = g_r_s.Remote_Functions.General.Exploit_Check
    local g_game_flag = g_r_s:WaitForChild("GAME_IN_PROGRESS")
    local exploit_defense = g_r_s.Game_Assets.ModuleScripts.Exploit_Defense
    local spoof_keys = {
        Activity = true,
        Gravity = true,
        WalkSpeed = true,
        JumpPower = true,
        Record_Kick_Reason = true,
        Teleport = true,
        BodyVelocity = true,
        Exploit_Defense_Loaded = true
    }

    local lp = game:GetService("Players").LocalPlayer
    local earned = lp.General.CoinsEarned

    getgenv().ac_bypass_enabled = true
    getgenv().ac_hook_enabled = true

    local old_namecall
    old_namecall = hookmetamethod(game, "__namecall", function(self, ...)
        if not getgenv().ac_hook_enabled then
            return old_namecall(self, ...)
        end
        if not getgenv().ac_bypass_enabled then
            return old_namecall(self, ...)
        end

        local m = getnamecallmethod()
        if m == "InvokeServer" and self == g_remote_f then
            if getfenv(2).script == exploit_defense then
                local a1 = ...
                if spoof_keys[a1] then
                    return true
                end
            end
        end

        return old_namecall(self, ...)
    end)

    getgenv().game_changing_flag = getgenv().game_changing_flag or g_game_flag.Changed:Connect(function()
        if g_game_flag.Value == true then
            print("set to: true.")
            getgenv().ac_bypass_enabled = true
        else
            wait(0.5)
            print("set to: false.")
            getgenv().ac_bypass_enabled = false
        end
    end)

    getgenv().coins_changing_flag = getgenv().coins_changing_flag or earned.Changed:Connect(function()
        if g_game_flag.Value == false and (earned.Value == 0 or earned.Value <= 1) then
            wait(0.8)
            print("ac bypass enabled again.")
            getgenv().ac_bypass_enabled = true
        end
    end)
end

local function tp_place(place)
    local tw = getgenv().TweenService
    local root = getgenv().HumanoidRootPart

    for _, v in pairs(getgenv().Workspace:GetDescendants()) do
        if v.Name == place and v:IsA("BasePart") then

            if getgenv().Humanoid and getgenv().Humanoid.SeatPart then
                getgenv().Humanoid.Sit = false
                getgenv().Humanoid:ChangeState(3)
                wait(.1)
            end

            if place == "RewardDoor" then
                if game.PlaceId == 4954752502 then
                    root:PivotTo(v.CFrame)
                elseif game.PlaceId == 11829856654 then
                    local info = TweenInfo.new(2, Enum.EasingStyle.Linear)
                    tw:Create(root, info, {CFrame = v.CFrame}):Play()
                end
            end
        end
    end
end

local Crate_Types = {
	["Trail_Crate_1"] = true,
	["Trail_Crate_2"] = true,
	["Trail_Crate_3"] = true,
	["Trail_Crate_4"] = true,
	["Effect_Crate_1"] = true,
	["Effect_Crate_2"] = true,
	["Effect_Crate_3"] = true,
	["Effect_Crate_4"] = true,
	["Emote_Crate_1"] = true,
	["Emote_Crate_2"] = true,
	["Emote_Crate_3"] = true,
	["Emote_Crate_4"] = true,
}

local function Open_Crate(Crate_Type)
	if not Crate_Types[Crate_Type] then return end

	Open_Crate_RE:FireServer()
end

local function disable_logging_metrics(toggle)
	if toggle == true then
		local Send_Ads_Analytics = Remote_Events:FindFirstChild("Send_Ads_Analytics")
		local Postie = getgenv().ReplicatedStorage:FindFirstChild("Postie")
		local AdMonitorEvents = getgenv().ReplicatedStorage:FindFirstChild("AdMonitorEvents")
		local Bloxbiz_Remotes = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes")
		local UserIdling_RE = Bloxbiz_Remotes and Bloxbiz_Remotes:FindFirstChild("UserIdlingEvent")

		if Send_Ads_Analytics then
			Send_Ads_Analytics.Parent = getgenv().AssetService
		end
		if Postie:FindFirstChild("Sent") then
			Postie:FindFirstChild("Sent"):Destroy()
		end
		if AdMonitorEvents:FindFirstChild("LogImpression") then
			AdMonitorEvents:FindFirstChild("LogImpression"):Destroy()
		end
		if UserIdling_RE then
			UserIdling_RE.Parent = getgenv().SoundService
		end
        getgenv().notify("Success", "In-Game metrics logging data has been disabled.", 5)
	elseif toggle == false then
		if getgenv().AssetService:FindFirstChild("Send_Ads_Analytics") then
			getgenv().AssetService:FindFirstChild("Send_Ads_Analytics").Parent = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events")
		end
		if getgenv().SoundService:FindFirstChild("UserIdlingEvent") then
			getgenv().SoundService:FindFirstChild("UserIdlingEvent").Parent = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes")
		end
        getgenv().notify("Success", "In-Game metrics logging data has been re-enabled.", 5)
	else
		return 
	end
end

local All_Towers = {}

local function get_all_towers()
	for _, v in ipairs(getgenv().Workspace:FindFirstChild("Tower"):GetDescendants()) do
		if v:IsA("Model") and string.find(v.Name, "Floor") then
			table.insert(All_Towers, v)
		end
	end

	return 
end

local function collect_session_rewards()
	if Remote_Events:FindFirstChild("Collect_Session_Reward") then
		local args = {
		    200
		}

		Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
		local args = {
		    100
		}

		Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
		local args = {
		    50
		}

		Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
		local args = {
		    300
		}

		Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
		local args = {
		    400
		}

		Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
		local args = {
		    500
		}

		Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
    else
        return getgenv().notify("Error", "Remote_Events Folder could not be found in ReplicatedStorage!", 6)
	end
end

local function delete_other_fake_tower()
    local ws = getgenv().Workspace or workspace
    local Top_Section = ws:FindFirstChild("Top_Section")
    if not Top_Section then getgenv().notify("Error", "Top_Section not found", 5) end

    local Practice_Stage = Top_Section and Top_Section:FindFirstChild("Practice_Stage")
    if not Practice_Stage then getgenv().notify("Error", "Practice_Stage not found", 5) end

    local Container = Practice_Stage and Practice_Stage:FindFirstChild("Container")
    if not Container then getgenv().notify("Error", "Container not found", 5) end

    local Floor1 = Container and Container:FindFirstChild("Floor #1")
    if not Floor1 then getgenv().notify("Error", "Floor #1 not found", 5) end

    local Reach = Floor1 and Floor1:FindFirstChild("Reach Detector")
    local Pass = Floor1 and Floor1:FindFirstChild("Pass Detector")

    if Reach then
        Reach:Destroy()
    end

    if Pass then
        Pass:Destroy()
    end
end

local function find_top_section()
    for _, v in ipairs(getgenv().Workspace:GetChildren()) do
        if v:IsA("Model") and v.Name:lower():find("top") and v.Name:lower():find("section") then
            return v
        end
    end

    return nil
end

local function find_tower_model()
    for _, v in ipairs(getgenv().Workspace:GetChildren()) do
        if v:IsA("Model") and v.Name:lower():find("tower") then
            return v
        end
    end

    return nil
end

local function find_top_hallway_model()
    local top_section_main = find_top_section()

    if top_section_main then
        for _, v in ipairs(top_section_main:GetDescendants()) do
            if v:IsA("Model") and v.Name:lower():find("hallway") then
                return v
            end
        end
    end
    
    return nil
end

local function GodMode(toggle)
	local Temporary_Immunity = General_Folder:FindFirstChild("Temporary_Immunity", true)
    if not Temporary_Immunity then return getgenv().notify("Error", "Temporary_Immunity doesn't exist in General Folder!", 6) end

	if toggle == true then
        Update_Setting_RE:FireServer(30, false)
		Temporary_Immunity.Value = true
	elseif toggle == false then
		Temporary_Immunity.Value = false
	else
		return 
	end
end

local function Give_Arcade_Points(number_of_points)
    if not Remote_Events:FindFirstChild("Add_Arcade_Points") then
        return getgenv().notify("Error", "Add_Arcade_Points does not exist in Remote_Events!", 6)
    end

    for i = 1, number_of_points do
        local args = {
            "Zombie_Slayer"
        }

        Remote_Events:FindFirstChild("Add_Arcade_Points", true):FireServer(unpack(args))
    end
end

local function Spectate(toggle)
    if not General_Folder then return getgenv().notify("Error", "General Folder not found inside LocalPlayer!", 5) end
	local Spectate = General_Folder:FindFirstChild("Spectating", true)
    if not Spectate then return getgenv().notify("Error", "Spectate Value not found inside of General Folder!", 6) end

	if toggle == true then
		Spectate.Value = true
	elseif toggle == false then
		Spectate.Value = false
	else
		return 
	end
end

local function Touched_Door()
	local Door_Touched = General_Folder:FindFirstChild("DoorTouched")

	if Door_Touched >= 15 then
		return true
	elseif Door_Touched == 0 then
		return false
	else
		return getgenv().notify("Warning", "Not sure if RewardDoor has been touched or not.", 5)
	end
end

local function collect_all()
    if not Update_Setting_RE then return getgenv().notify("Error", "Update Setting RemoteEvent was not found!", 5) end

    local General = getgenv().LocalPlayer:FindFirstChild("General", true)
    if not General then return getgenv().notify("Error", "General Folder was not found inside LocalPlayer!", 5) end
    local Coins_Earned_Val = General:FindFirstChild("CoinsEarned", true)
    if not Coins_Earned_Val then return getgenv().notify("Error", "CoinsEarned Value was not found inside of General Folder!", 6) end
    local Tower = getgenv().Workspace:FindFirstChild("Tower", true)
    if not Tower then return getgenv().notify("Error", "Tower Model was not found inside of Workspace!", 6) end

    Update_Setting_RE:FireServer(30, false)
    wait(0.2)
    if Coins_Earned_Val.Value >= 70 then return end
    for _, v in ipairs(getgenv().Workspace:FindFirstChild("Tower"):GetDescendants()) do
        if v:FindFirstChild("Pass Detector") then
            GodMode(true)
            wait(0.2)
            tp_place("Pass Detector")
        end
    end
end

local function enable_in_game_catalog(toggle)
    local Catalog = getgenv().PlayerGui:FindFirstChild("IngameCatalog", true)
    if not Catalog then return getgenv().notify("Error", "We could not find the InGame Catalog inside PlayerGui!", 6) end

    if toggle == true then
        Catalog.Enabled = true
    elseif toggle == false then
        Catalog.Enabled = false
    else
        return 
    end
end

local Shop_Folder = getgenv().ReplicatedStorage:WaitForChild("Remote_Functions"):WaitForChild("Shop")

local function Purchase_Mutator(Mutator)
    if not Shop_Folder then return end

    if Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)) then
        Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)):InvokeServer()
    end
end

local function touch_door()
    local Top_Sec = getgenv().Workspace:FindFirstChild("Top_Section", true)
    if not Top_Sec then return getgenv().notify("Error", "Top_Section was not found inside of Workspace!", 5) end
    local Hallway_Model = Top_Sec:FindFirstChild("Hallway", true)
    if not Hallway_Model then return getgenv().notify("Error", "Hallway Model was not found in Top_Section!", 5) end
    if not Update_Setting_RE then return getgenv().notify("Error", "Update Setting RemoteEvent was not found in ReplicatedStorage!", 5) end
    if not General_Folder then return getgenv().notify("Error", "General Folder was not found inside of LocalPlayer!", 5) end

    Update_Setting_RE:FireServer(30, false)
    wait(0.1)
    repeat task.wait() until General_Folder:FindFirstChild("CoinsEarned", true).Value >= 70
    repeat task.wait() until getgenv().Workspace:FindFirstChild("Tower") and getgenv().Workspace:FindFirstChild("Top_Section")
    if General_Folder:FindFirstChild("CoinsEarned", true) and General_Folder:FindFirstChild("CoinsEarned", true).Value >= 70 then
        delete_other_fake_tower()
        GodMode(true)
        wait(0.3)
        tp_place("RewardDoor")
    end
end

local ws = getgenv().Workspace or workspace
local Top_Section = ws:FindFirstChild("Top_Section", true)
if not Top_Section then getgenv().notify("Info", "Top_Section not found", 3) end

local Practice_Stage = Top_Section and Top_Section:FindFirstChild("Practice_Stage", true)
if not Practice_Stage then getgenv().notify("Info", "Practice_Stage not found", 3) end

local Container = Practice_Stage and Practice_Stage:FindFirstChild("Container", true)
if not Container then getgenv().notify("Info", "Container not found", 3) end

local Floor1 = Container and Container:FindFirstChild("Floor #1", true)
if not Floor1 then getgenv().notify("Info", "Floor #1 not found", 3) end

local Reach = Floor1 and Floor1:FindFirstChild("Reach Detector", true)
local Pass = Floor1 and Floor1:FindFirstChild("Pass Detector", true)

if Reach then
    Reach:Destroy()
else
    getgenv().notify("Info", "[Skipping]: Reach Detector not found", 3)
end

if Pass then
    Pass:Destroy()
else
    getgenv().notify("Info", "[Skipping]: Pass Detector not found", 3)
end

local container = getgenv().Workspace:WaitForChild("Top_Section"):WaitForChild("Practice_Stage"):WaitForChild("Container")

container.ChildAdded:Connect(function(child)
    if child.Name == "Floor #1" then
        child:Destroy()
    end
end)

local function LocalPlayer_loaded()
   local player = Players.LocalPlayer
   if not player then
      repeat task.wait() until Players.LocalPlayer
      player = Players.LocalPlayer
   end

   if not player.Character or not player.Character:FindFirstChild("Humanoid") then
      player.CharacterAdded:Wait()
      repeat task.wait() until player.Character:FindFirstChild("Humanoid")
   end
end

local function render_safe()
   RunService.RenderStepped:Wait()
   task.wait(0.2)
end

local function load_rayfield()
    local attempts = 0
    local maxAttempts = 10
    local success = false
    local result

    repeat
        attempts += 1
        success, result = pcall(function()
            local raw = game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary")
            local func = loadstring(raw)
            return func()
        end)

        if not success or not result then
            warn("[Rayfield] Load failed (attempt " .. attempts .. "):", result)
            task.wait(1)
        end
    until (success and result) or attempts >= maxAttempts

    return result
end

local Window

LocalPlayer_loaded()
render_safe()

Rayfield = load_rayfield()

if typeof(Rayfield) == "table" and Rayfield.CreateWindow then
    Window = Rayfield:CreateWindow({
        Name = "✅ Tower Of Misery ✅ | "..tostring(Script_Version).." | "..tostring(executor_Name),
        LoadingTitle = "Welcome, "..tostring(game.Players.LocalPlayer),
        LoadingSubtitle = "TowerOfMisery | Hub.",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "TOM-Config",
            FileName = "TOMScriptHub"
        },
        Discord = {
            Enabled = false,
            Invite = "",
            RememberJoins = true
        },
        KeySystem = false,
        KeySettings = {
            Title = "None",
            Subtitle = "No key system is provided.",
            Note = "nice hidden dumper skid, it's useless (like you), joking, take a joke, this is open source.",
            FileName = "Key",
            SaveKey = false,
            GrabKeyFromSite = false,
            Key = {""}
        }
    })
else
    warn("[CRITICAL_ERROR]: Rayfield failed to load or is not valid. Returned:", Rayfield)
end
wait(1)
local Tab1 = Window:CreateTab("🏡 Main 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Main 🏡 |")
local Tab2 = Window:CreateTab("🧍 Character 🧍", 0)
local Section2 = Tab2:CreateSection("| 🧍 Character Content 🧍 |")
local Tab3 = Window:CreateTab("⭐ Extras ⭐", 0)
local Section3 = Tab3:CreateSection("| ⭐ Extra Content ⭐ |")
local AC_Bypass_Loaded = false
wait(0.2)
getgenv().AntiCheat_Bypass = Tab1:CreateButton({
Name = "Anti Cheat Bypass",
Callback = function()
    bypass_anticheat()
end,})

getgenv().DisableLogging_AndMetricsData = Tab1:CreateToggle({
Name = "Disable Logging And Metrics Data",
CurrentValue = false,
Flag = "DisableAllLogsAndMetrics",
Callback = function(logging_toggle)
    if logging_toggle then
        disable_logging_metrics(true)
    else
        disable_logging_metrics(false)
    end
end,})
wait(0.2)
if getgenv().AssetService:FindFirstChild("Send_Ads_Analytics") then
   getgenv().DisableLogging_AndMetricsData:Set(true)
end

local NoClip_Loop = nil
local Clip = false

local function NoclipLoop()
    if Clip == false and getgenv().Character ~= nil then
        for _, child in pairs(getgenv().Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end

wait(0.1)
getgenv().Auto_Win = Tab1:CreateButton({
Name = "Auto Win",
Callback = function()
    local find_top_model = find_top_section()
    local find_top_main = find_top_hallway_model()
    local find_tower_main_model = find_tower_model()
    local General_Folder_Main = General_Folder
    local Coins_Earned_Value_Main

    if not General_Folder_Main then
        for _, v in ipairs(LocalPlayer:GetDescendants()) do
            if v:IsA("Folder") and v.Name:lower():find("general") then
                General_Folder_Main = v
                break
            end
        end
    end

    if not General_Folder_Main then
        return getgenv().notify("Error", "Could not find CoinsEarned value anywhere!", 7)
    end

    for _, v in ipairs(General_Folder_Main:GetDescendants()) do
        if (v:IsA("IntValue") or v:IsA("NumberValue")) and v.Name:lower():find("coins") and v.Name:lower():find("earn") then
            Coins_Earned_Value_Main = v
            break
        end
    end

    repeat task.wait() until Workspace:FindFirstChild("Tower") and Workspace:FindFirstChild("Top_Section")
    task.wait(0.1)

    local coins_value = Coins_Earned_Value_Main and Coins_Earned_Value_Main.Value or 0

    if coins_value <= 70 then
        if getgenv().God_ModeLocalPlr then
            getgenv().God_ModeLocalPlr:Set(true)
        end
        GodMode(true)
        task.wait(0.1)
        collect_all()
        task.wait(3.5)
    else
        collect_all()
        wait(3.5)
        GodMode(true)
        task.wait(0.2)
    end

    local function find_reward_door()
        for _, v in ipairs(find_top_main:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("reward") and v.Name:lower():find("door") then
                return v
            end
        end
    end

    local door = find_reward_door() or find_top_main:FindFirstChild("RewardDoor")
    if not door then return end

    local root = getgenv().HumanoidRootPart or get_root(LocalPlayer) or getgenv().Character and getgenv().Character:WaitForChild("HumanoidRootPart", 5)
    if not root then return end

    if game.PlaceId == 4954752502 then
        root:PivotTo(door.CFrame)
    elseif game.PlaceId == 11829856654 then
        local tween_s = getgenv().TweenService or cloneref and cloneref(game:GetService("TweenService")) or game:GetService("TweenService")
        local tween_i = TweenInfo.new(2, Enum.EasingStyle.Linear)
        tween_s:Create(root, tween_i, {CFrame = door.CFrame}):Play()
    end

    task.wait(0.5)
    touch_door()
	workspace.CurrentCamera:Remove()
	wait(1.2)
	workspace.CurrentCamera.CameraSubject = getgenv().Humanoid or getgenv().Character or get_human(LocalPlayer) or get_char(LocalPlayer)
	workspace.CurrentCamera.CameraType = "Custom"
	getgenv().LocalPlayer.CameraMinZoomDistance = 0.5
	getgenv().LocalPlayer.CameraMaxZoomDistance = 400
	getgenv().LocalPlayer.CameraMode = "Classic"
    if getgenv().Head then
	    getgenv().Head.Anchored = false
    elseif not getgenv().Head then
        local new_head = get_head and get_head(LocalPlayer) or getgenv().Character:WaitForChild("Head", 3)

        new_head.Anchored = false
    end
end,})

getgenv().God_ModeLocalPlr = Tab2:CreateToggle({
Name = "GodMode",
CurrentValue = false,
Flag = "GodmodeValue",
Callback = function(real_godmode)
    if real_godmode then
        GodMode(true)
        getgenv().notify("Success", "Godmode has been enabled.", 3)
    else
        GodMode(false)
        getgenv().notify("Success", "Godmode has been disabled.", 3)
    end
end,})
wait(0.2)
if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Temporary_Immunity").Value == true then
    getgenv().God_ModeLocalPlr:Set(true)
else
    getgenv().God_ModeLocalPlr:Set(false)
end

local function find_in_game_catalog()
    for _, v in ipairs(getgenv().PlayerGui:GetDescendants()) do
        if v:IsA("ScreenGui") and v.Name:lower():find("catalog") then
            return v
        end
    end

    return nil
end

local catalog_gui = find_in_game_catalog()

if catalog_gui then
    getgenv().InGame_Catalog = Tab2:CreateToggle({
    Name = "In-Game Catalog (FE, Free Items)",
    CurrentValue = false,
    Flag = "InGameCatalogItems",
    Callback = function(avatar_items_catalog)
        if avatar_items_catalog then
            enable_in_game_catalog(true)
        else
            enable_in_game_catalog(false)
        end
    end,})
    wait(0.2)
    if getgenv().PlayerGui:FindFirstChild("IngameCatalog") and getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled == true and getgenv().PlayerGui:FindFirstChild("IngameCatalog"):IsA("ScreenGui") then
        getgenv().InGame_Catalog:Set(true)
        getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = true
    elseif not getgenv().PlayerGui:FindFirstChild("IngameCatalog") then
        getgenv().InGame_Catalog:Set(false)
    end
end

local Old_GUIs_States = {}

local function get_old_gui_states()
    for _, v in ipairs(getgenv().PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") then
            Old_GUIs_States[v] = v.Enabled
        end
    end
end

local function restore_old_guis()
    for gui, wasEnabled in pairs(Old_GUIs_States) do
        if gui and gui:IsA("ScreenGui") then
            gui.Enabled = wasEnabled
        end
    end
end

get_old_gui_states()
wait(0.6)

--[[getgenv().Inf_Coins = Tab3:CreateToggle({
Name = "Infinite Coins (WORKING!, USE BEFORE PATCH!)",
CurrentValue = false,
Flag = "InfCoinsFEWorking",
Callback = function(inf_coins_regen)
    local General = getgenv().LocalPlayer:FindFirstChild("General")
    local Viewing_Billboard = General and General:FindFirstChild("Viewing_Billboard")
    local Free_Spin_Alert = getgenv().PlayerGui:FindFirstChild("Free_Spin_Received")

    if not Viewing_Billboard or not Free_Spin_Alert then
        getgenv().redeem_all_spins = false
        getgenv().Inf_Coins:Set(false)
        return getgenv().notify("Error", "Viewing_Billboard or FreeSpin GUI not found.", 5)
    end

    if inf_coins_regen then
        getgenv().redeem_all_spins = true
        while getgenv().redeem_all_spins do
            wait(3)
            Viewing_Billboard.Value = true
            wait(3)
            Free_Spin_Alert.Enabled = true
            wait(2)
            Viewing_Billboard.Value = false
            wait(2)
            restore_old_guis()
        end
    else
        getgenv().redeem_all_spins = false
        wait(0.9)
        Free_Spin_Alert.Enabled = false
        Viewing_Billboard.Value = false
        restore_old_guis()
    end
end,})--]]

local function find_body_colors_ez()
    for _, v in ipairs(getgenv().Character:GetDescendants()) do
        if v:IsA("BodyColors") then
            return v
        end
    end

    return nil
end
wait(0.3)
local bodyColors = find_body_colors_ez()
if not bodyColors then
    getgenv().notify("Success", "no BodyColors on Character.", 5)
end

local function save_current_skintone()
    local body_colors = find_body_colors_ez()
    if not body_colors then
        return getgenv().notify("Error", "Could not find BodyColors!", 5)
    end

    getgenv().Saved_BodyColors = {
        HeadColor = body_colors.HeadColor.Color,
        LeftArmColor = body_colors.LeftArmColor.Color,
        RightArmColor = body_colors.RightArmColor.Color,
        LeftLegColor = body_colors.LeftLegColor.Color,
        RightLegColor = body_colors.RightLegColor.Color,
        TorsoColor = body_colors.TorsoColor.Color
    }

    return getgenv().notify("Success", "Saved current BodyColors!", 5)
end

if bodyColors then
    save_current_skintone()
end

local Old_Body_Colors = {
    HeadColor3     = bodyColors.HeadColor3,
    LeftArmColor3  = bodyColors.LeftArmColor3,
    RightArmColor3 = bodyColors.RightArmColor3,
    LeftLegColor3  = bodyColors.LeftLegColor3,
    RightLegColor3 = bodyColors.RightLegColor3,
    TorsoColor3    = bodyColors.TorsoColor3
}

getgenv().PurchaseAll_Mutators = Tab1:CreateButton({
Name = "Purchase All Mutators",
Callback = function()
    local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")

    local function deep_find_folder(root, target)
        local function scan(obj)
            for _, v in ipairs(obj:GetChildren()) do
                if v:IsA("Folder") and v.Name:lower():find(target) then
                    return v
                end
                local f = scan(v)
                if f then
                    return f
                end
            end
        end
        return scan(root)
    end

    local function find_shop_folder()
        local remote_root = ReplicatedStorage:FindFirstChild("Remote_Functions")
        if not remote_root then return nil end
        return deep_find_folder(remote_root, "shop")
    end

    local Shop_Folder = find_shop_folder()

    local function purchase_mutator(name)
        if not Shop_Folder then return end
        for _, v in ipairs(Shop_Folder:GetDescendants()) do
            if v:IsA("RemoteFunction") and v.Name == "Purchase: " .. tostring(name) then
                v:InvokeServer()
            end
        end
    end

    local Mutators = {
        "Fog Clouds",
        "Color Swap",
        "Quick Spawn",
        "Night Mode",
        "High Speed",
        "Low Gravity"
    }

    for _, mutator in ipairs(Mutators) do
        purchase_mutator(mutator)
    end
end,})

wait(0.1)
getgenv().Anti_Fog_AndColor_Swap = Tab1:CreateToggle({
Name = "Anti Fog (And Color Swap)",
CurrentValue = false,
Flag = "AntiFogAndColorSwap",
Callback = function(anti_fog_color_swap)
    if anti_fog_color_swap then
        local Winner_Val = General_Folder:FindFirstChild("Winner", true)

        if not Winner_Val then
            getgenv().Anti_Fog_AndColor_Swap:Set(false)
            getgenv().anti_fog_and_the_color_swap = false
            return getgenv().notify("Error", "Winner Value doesn't exist in General Folder!", 5)
        end

        wait(0.1)
        getgenv().anti_fog_and_the_color_swap = true
        while getgenv().anti_fog_and_the_color_swap == true do
        task.wait(0)
            Winner_Val.Value = true
        end
    else
        local Winner_Val = General_Folder:FindFirstChild("Winner", true)

        if not Winner_Val then
            getgenv().Anti_Fog_AndColor_Swap:Set(false)
            getgenv().anti_fog_and_the_color_swap = false
            return getgenv().notify("Error", "Winner Value doesn't exist in General Folder!", 5)
        end
        wait(0.1)
        getgenv().anti_fog_and_the_color_swap = false
        Winner_Val.Value = false
        getgenv().anti_fog_and_the_color_swap = false
    end
end,})

getgenv().CollectAll_PlayTimeRewards = Tab3:CreateButton({
Name = "Collect All Playtime Rewards",
Callback = function()
    collect_session_rewards()
end,})

getgenv().GiveArcade_Points_50 = Tab2:CreateButton({
Name = "Give 50 Arcade Points (FE)",
Callback = function()
    Give_Arcade_Points(50)
end,})

getgenv().GiveArcade_Points_100 = Tab2:CreateButton({
Name = "Give 100 Arcade Points (FE)",
Callback = function()
    Give_Arcade_Points(100)
end,})

getgenv().GiveArcade_Points_1000 = Tab2:CreateButton({
Name = "Give 1000 Arcade Points (FE)",
Callback = function()
    Give_Arcade_Points(1000)
end,})

local function find_bloxbiz_folder()
    for _, v in ipairs(getgenv().ReplicatedStorage:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("bloxbiz") and v.Name:lower():find("remotes") then
            return v
        end
    end
    
    return nil
end

local function find_catalog_apply_hum_RE()
    local blox_biz_folder = find_bloxbiz_folder()
    
    if blox_biz_folder then
        for _, v in ipairs(blox_biz_folder:GetDescendants()) do
            if v:IsA("RemoteEvent") and v.Name:lower():find("catalog") and v.Name:lower():find("apply") and v.Name:lower():find("humanoid") then
                return v
            end
        end
    end
    
    return nil
end

getgenv().Rainbow_FE_Skin = Tab2:CreateToggle({
Name = "Rainbow Skin (FE)",
CurrentValue = false,
Flag = "FERainbowSkinScript",
Callback = function(rainbow_loop)
    local bc = find_body_colors_ez()
    if not bc then
        getgenv().Rainbow_FE_Skin:Set(false)
        getgenv().skin_rainbow_loop = false
        return getgenv().notify("Error", "Could not find your BodyColors", 5)
    end

    if rainbow_loop then
        getgenv().Saved_BodyColors = {
            bc.HeadColor.Color,
            bc.LeftArmColor.Color,
            bc.RightArmColor.Color,
            bc.LeftLegColor.Color,
            bc.RightLegColor.Color,
            bc.TorsoColor.Color
        }

        local bloxbiz = find_bloxbiz_folder()
        if not bloxbiz then
            getgenv().Rainbow_FE_Skin:Set(false)
            getgenv().skin_rainbow_loop = false
            return getgenv().notify("Error", "BloxbizRemotes Folder not found", 5)
        end

        local remote = find_catalog_apply_hum_RE()
        if not remote then
            getgenv().Rainbow_FE_Skin:Set(false)
            getgenv().skin_rainbow_loop = false
            return getgenv().notify("Error", "SkinTone Changer Remote not found", 6)
        end
        wait(0.2)
        getgenv().skin_rainbow_loop = true

        local cycle = {
            Color3.fromRGB(17,17,17),
            Color3.fromRGB(101,67,33),
            Color3.fromRGB(0,102,204),
            Color3.fromRGB(0,153,0),
            Color3.fromRGB(255,255,255),
            Color3.fromRGB(128,128,128),
            Color3.fromRGB(255,255,0),
            Color3.fromRGB(255,165,0),
            Color3.fromRGB(255,0,0),
            Color3.fromRGB(128,0,128),
            Color3.fromRGB(255,105,180),
            Color3.fromRGB(0,255,255)
        }

        task.spawn(function()
            while getgenv().skin_rainbow_loop == true do
                task.wait(0)
                for _, c in ipairs(cycle) do
                    if not getgenv().skin_rainbow_loop then break end
                    task.wait(.2)
                    remote:FireServer({ BodyColor = c })
                end
            end
        end)
    else
        getgenv().skin_rainbow_loop = false
        task.wait(0.5)

        local bc_main = find_body_colors_ez()
        local old_colors = getgenv().Saved_BodyColors
        if bc_main and old_colors then
            local bloxbiz = find_bloxbiz_folder()
            local remote = find_catalog_apply_hum_RE()
            if bloxbiz and remote then
                getgenv().notify("Info", "Resetting Body Colors...", 5)
                task.wait(1)
                for _, col in ipairs(old_colors) do
                    remote:FireServer({ BodyColor = col })
                    task.wait(0.1)
                end
                task.wait(2)
                return getgenv().notify("Success", "Restored original Body Colors.", 5)
            end
        end
    end
end,})

getgenv().ResetBody_Colors = Tab2:CreateButton({
Name = "Reset Body Colors (FE)",
Callback = function()
    local old_colors = getgenv().Saved_BodyColors
    if not old_colors then
        return getgenv().notify("Error", "No saved BodyColors found. Enable Rainbow Skin first!", 5)
    end

    local bc = find_body_colors_ez()
    if not bc then
        return getgenv().notify("Error", "Could not find your BodyColors", 5)
    end

    local bloxbiz = find_bloxbiz_folder()
    local remote = find_catalog_apply_hum_RE()
    if not bloxbiz or not remote then
        return getgenv().notify("Error", "BloxbizRemotes or SkinTone Remote not found", 6)
    end

    for _, col in ipairs(old_colors) do
        remote:FireServer({ BodyColor = col })
        task.wait(0.1)
    end

    getgenv().notify("Success", "Restored original Body Colors", 5)
end,})

getgenv().GiveArcade_Points_Other = Tab2:CreateInput({
Name = "Give Arcade Points (FE)",
PlaceholderText = "Number Here",
RemoveTextAfterFocusLost = true,
Callback = function(Number_Points)
    local Number_Of_Points_Input = tonumber(Number_Points)

    if Number_Of_Points_Input then
        getgenv().notify("Info", "Giving you "..tostring(Number_Points).." points.", 5)
        Give_Arcade_Points(Number_Points)
    else
        return getgenv().notify("Error", tostring(Number_Points).." is invalid or isn't a number!", 5)
    end
end,})

getgenv().layered_painting_auto = Tab1:CreateToggle({
Name = "Layered Painting Auto-Farm",
CurrentValue = false,
Flag = "LayeredPaintingAutoFarmSquares",
Callback = function(layer_paint)
    if layer_paint then
        local Top_Section = getgenv().Workspace:FindFirstChild("Top_Section", true)
        if not Top_Section then
            getgenv().layered_painting_auto:Set(false)
            getgenv().layered_painting_autofarm = false
            return getgenv().notify("Error", "Top_Section was not found in Workspace!", 5)
        end
        local Layer_Painting_Model = Top_Section:FindFirstChild("Layer_Painting", true)
        if not Layer_Painting_Model then
            getgenv().layered_painting_auto:Set(false)
            getgenv().layered_painting_autofarm = false
            return getgenv().notify("Error", "Layer Painting Model was not found in Top_Section!", 5)
        end
        local Clear_Part = Layer_Painting_Model:FindFirstChild("Clear", true)
        if not Clear_Part then
            getgenv().layered_painting_auto:Set(false)
            getgenv().layered_painting_autofarm = false
            return getgenv().notify("Error", "Clear Part was not found in Layer Painting Model!", 5)
        end

        getgenv().layered_painting_autofarm = true
        while getgenv().layered_painting_autofarm == true do
        task.wait(0)
            for _, v in ipairs(Clear_Part:GetChildren()) do
                if v:IsA("BasePart") then
                    task.wait(0)
                    getgenv().Character:PivotTo(v:GetPivot() * CFrame.new(0, 5, 0))
                end
            end
        end
    else
        getgenv().layered_painting_autofarm = false
    end
end,})

getgenv().UnlimitedPoints_ReGen = Tab2:CreateToggle({
Name = "Loop Generate Arcade Points (FE)",
CurrentValue = false,
Flag = "KeepGeneratingPointsEz",
Callback = function(anypoints_i_want)
    if anypoints_i_want then
        local Remote_E = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events", true)
        if not Remote_E then
            getgenv().unlimited_number_of_points = false
            getgenv().UnlimitedPoints_ReGen:Set(false)
            return getgenv().notify("Error", "Remote_Events Folder was not found inside of ReplicatedStorage!", 6)
        end
        local Add_Arcade_Points = Remote_E:FindFirstChild("Add_Arcade_Points", true)
        if not Add_Arcade_Points then
            getgenv().unlimited_number_of_points = false
            getgenv().UnlimitedPoints_ReGen:Set(false)
            return getgenv().notify("Error", "Add_Arcade_Points Folder was not found inside of Remote_Events Folder!", 7)
        end

        if Add_Arcade_Points and Add_Arcade_Points:IsA("RemoteEvent") then
            getgenv().unlimited_number_of_points = true
            while getgenv().unlimited_number_of_points == true do
            wait(0.3)
                local args = {
                    "Zombie_Slayer"
                }

                Add_Arcade_Points:FireServer(unpack(args))
                task.wait(0.2)
                local args = {
                    "Layer_Painting"
                }

                Add_Arcade_Points:FireServer(unpack(args))
                task.wait(0.2)
                local args = {
                    "Rocket_Blocks"
                }

                Add_Arcade_Points:FireServer(unpack(args))
            end
        else
            getgenv().UnlimitedPoints_ReGen:Set(false)
            wait(0.3)
            getgenv().unlimited_number_of_points = false
        end
    else
        getgenv().unlimited_number_of_points = false
    end
end,})

getgenv().SpectatePlayers = Tab3:CreateToggle({
Name = "Spectate",
CurrentValue = false,
Flag = "SpectatingValChange",
Callback = function(spectating_plrs)
    if spectating_plrs then
        Spectate(true)
    else
        Spectate(false)
    end
end,})
wait(0.2)
if General_Folder then
    if General_Folder:FindFirstChild("Spectating", true).Value == true then
        Spectate(true)
        getgenv().SpectatePlayers:Set(true)
    else
        Spectate(false)
        getgenv().SpectatePlayers:Set(false)
    end
end
wait(0.5)
if getgenv().anti_fog_and_the_color_swap == true then
    getgenv().notify("Info", "Enabling AntiFog, it was enabled before initialization.", 5)
    getgenv().Anti_Fog_AndColor_Swap:Set(true)
else
    getgenv().anti_fog_and_the_color_swap = false
    getgenv().Anti_Fog_AndColor_Swap:Set(false)
end
task.wait()
if getgenv().skin_rainbow_loop == true then
    getgenv().notify("Info", "Enabling RainbowSkinFE, it was enabled before initialization.", 5)
    getgenv().Rainbow_FE_Skin:Set(true)
else
    getgenv().skin_rainbow_loop = false
    getgenv().Rainbow_FE_Skin:Set(false)
end
wait(0.1)
if getgenv().unlimited_number_of_points == true then
    getgenv().notify("Info", "Enabling UnlimitedArcadePoints, it was enabled before load.", 5)
    getgenv().UnlimitedPoints_ReGen:Set(true)
else
    getgenv().UnlimitedPoints_ReGen:Set(false)
    getgenv().unlimited_number_of_points = false
end
