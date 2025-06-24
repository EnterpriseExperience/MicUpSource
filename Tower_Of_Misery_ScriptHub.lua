getgenv().Game = game
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId

getgenv().Service_Wrap = function(serviceName)
    if cloneref then
        return cloneref(getgenv().Game:GetService(serviceName))
    else
        return getgenv().Game:GetService(serviceName)
    end
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

getgenv().print_executor = function()
    local function retrieve_executor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function identify_executor()
        local executorDetails = retrieve_executor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_string = identify_executor()

    return print(executor_string)
end

getgenv().warn_executor = function()
    local function retrieve_executor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function identify_executor()
        local executorDetails = retrieve_executor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_string = identify_executor()

    return warn(executor_string)
end

function randomString()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

getgenv().randomString = function()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

local cmdp = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local cmdlp = cmdp.LocalPlayer

function findplr(args)
    local tbl = cmdp:GetPlayers()

    if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
        return getgenv().notify("Failure!", "You cannot target yourself!", 6)
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

if getgenv().AllClipboards then
    getgenv().AllClipboards("https://github.com/EnterpriseExperience/MicUpSource/releases -- check all my current patch notes and new updates/releases.")
end

wait(0.3)
if not getgenv().Players then
    warn("getgenv().Players was not detected, fixing...")
    getgenv().Players = getgenv().Service_Wrap("Players")
end
if not getgenv().ReplicatedStorage then
    warn("getgenv().ReplicatedStorage was not detected, fixing...")
    getgenv().ReplicatedStorage = getgenv().Service_Wrap("ReplicatedStorage")
end
if not getgenv().TextChatService then
    warn("getgenv().TextChatService was not detected, fixing...")
    getgenv().TextChatService = getgenv().Service_Wrap("TextChatService")
end
if not getgenv().Workspace then
    warn("getgenv().Workspace was not detected, fixing...")
    getgenv().Workspace = getgenv().Service_Wrap("Workspace")
end
if not getgenv().Lighting then
    warn("getgenv().Lighting was not detected, fixing...")
    getgenv().Lighting = getgenv().Service_Wrap("Lighting")
end

task.wait(0.2)
getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
getgenv().HumanoidRootPart = getgenv().Character:WaitForChild("HumanoidRootPart") or getgenv().Character:FindFirstChild("HumanoidRootPart")
getgenv().Humanoid = getgenv().Character:WaitForChild("Humanoid") or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid")
getgenv().Head = getgenv().Character:WaitForChild("Head") or getgenv().Character:FindFirstChild("Head")
local Anti_Ragdoll_Active = false
local Inf_Stamina_Active = false

wait(0.2)

local function Dynamic_Character_Updater(character)
	getgenv().Character = character or getgenv().LocalPlayer.Character
	task.wait(0.3)
	local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3)
	getgenv().HumanoidRootPart = (hrp and hrp:IsA("BasePart")) and hrp

	local hum = character:FindFirstChildOfClass("Humanoid")
	getgenv().Humanoid = (hum and hum:IsA("Humanoid")) and hum

	local head = character:FindFirstChild("Head")
	getgenv().Head = (head and head:IsA("BasePart")) and head
end

Dynamic_Character_Updater(getgenv().Character)
task.wait(0.2)
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(1)
	Dynamic_Character_Updater(newCharacter)
	getgenv().LocalPlayer.CharacterAdded:Wait()
	task.wait(0.5)
	getgenv().Character = newCharacter
	getgenv().HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
	getgenv().Humanoid = newCharacter:FindFirstChild("Humanoid") or newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
	getgenv().Head = newCharacter:FindFirstChild("Head") or newCharacter:WaitForChild("Head", 5)
end)

local Remote_Events = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events")
local General_Folder = Remote_Events:FindFirstChild("General")
local Update_Setting_RE = General_Folder:FindFirstChild("Update_Settings")
local Crate_System_V2 = getgenv().ReplicatedStorage:FindFirstChild("Crate_System_V2")
local Crate_System_Remote_Events = Crate_System_V2:FindFirstChild("Remote_Events")
local Open_Crate_RE = Crate_System_Remote_Events:FindFirstChild("Open_Crate")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

for _, v in ipairs(Players:GetDescendants()) do
	if v:IsA("ScreenGui") and string.find(v.Name, "Height_Meter_V2") then
		for _, k in ipairs(v:GetDescendants()) do
			if k:IsA("LocalScript") and k.Name == "LocalScript" then
				k:Destroy()
			end
		end
	end
end

local function bypass_anticheat()
	local old
	old = hookmetamethod(game, "__namecall", function(self,...)
		local args = {...}
		local method = getnamecallmethod()

		if tostring(self) == "Exploit_Check" then
			args[1] = "Activity"
			args[2] = true
			return old(self,unpack(args))

		end
		return old(self,...)
	end)
end

local function tween_tp(place)
   local TweenService = getgenv().TweenService

   for i,v in pairs(getgenv().Workspace:GetDescendants()) do
      if v.Name == place and v:IsA("BasePart") then
         if getgenv().Character:FindFirstChildOfClass('Humanoid') and getgenv().Character:FindFirstChildOfClass('Humanoid').SeatPart then
            getgenv().Character:FindFirstChildOfClass('Humanoid').Sit = false
            wait(.1)
         end
         wait(0.1)
         TweenService:Create(getgenv().Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = v.CFrame}):Play()
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
		local UserIdling_RE = Bloxbiz_Remotes:FindFirstChild("UserIdlingEvent")

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
	elseif toggle == false then
		if getgenv().AssetService:FindFirstChild("Send_Ads_Analytics") then
			getgenv().AssetService:FindFirstChild("Send_Ads_Analytics").Parent = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events")
		end
		if getgenv().SoundService:FindFirstChild("UserIdlingEvent") then
			getgenv().SoundService:FindFirstChild("UserIdlingEvent").Parent = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes")
		end
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
	end
end

local function GodMode(toggle)
	local General_Folder = getgenv().LocalPlayer:FindFirstChild("General")
	local Temporary_Immunity = General_Folder:FindFirstChild("Temporary_Immunity")

	if toggle == true then
      Update_Setting_RE:FireServer(30, false)
		Temporary_Immunity.Value = true
	elseif toggle == false then
		Temporary_Immunity.Value = false
	else
		return 
	end
end

local function Spectate(toggle)
	local General_Folder = getgenv().LocalPlayer:FindFirstChild("General")
	local Spectate = General_Folder:FindFirstChild("Spectating")

	if toggle == true then
		Spectate.Value = true
	elseif toggle == false then
		Spectate.Value = false
	else
		return 
	end
end

local function Touched_Door()
	local General_Folder = getgenv().LocalPlayer:FindFirstChild("General")
	local Door_Touched = General_Folder:FindFirstChild("DoorTouched")

	if Door_Touched >= 15 then
		return true
	elseif Door_Touched == 0 then
		return false
	else
		return warn("[DEBUG]:", "Not sure if RewardDoor has been touched or not.")
	end
end

local function collect_all()
   Update_Setting_RE:FireServer(30, false)
   wait(0.2)
   if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value >= 70 then return end
   for _, v in ipairs(getgenv().Workspace:FindFirstChild("Tower"):GetDescendants()) do
      if v:FindFirstChild("Pass Detector") then
         tween_tp("Pass Detector")
      end
   end
end

local function touch_door()
   Update_Setting_RE:FireServer(30, false)
   wait(0.1)
   repeat task.wait() until getgenv().LocalPlayer.General.CoinsEarned.Value >= 70
   repeat task.wait() until getgenv().Workspace:FindFirstChild("Tower") and getgenv().Workspace:FindFirstChild("Top_Section")
   if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value >= 70 then
      local Reward_Door = getgenv().Workspace:FindFirstChild("Top_Section"):FindFirstChild("Hallway"):FindFirstChild("RewardDoor")

      tween_tp("RewardDoor")
   end
end

local Top_Section = getgenv().Workspace:FindFirstChild("Top_Section")
local Practice_Stage = Top_Section:FindFirstChild("Practice_Stage")
local Container = Practice_Stage:FindFirstChild("Container")

if Container:FindFirstChild("Floor #1") and Container:FindFirstChild("Reach Detector") and Container:FindFirstChild("Pass Detector") then
   Container:FindFirstChild("Floor #1"):FindFirstChild("Reach Detector"):Destroy()
   Container:FindFirstChild("Floor #1"):FindFirstChild("Pass Detector"):Destroy()
else
    warn("Floor #1 or Reach Detector or Pass Detector not found, skipping...")
end

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
            local raw = game:HttpGet("https://raw.githubusercontent.com/LmaoItsCrazyBro/new_main/main/Main_UI.lua")
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
        Name = "✅ Tower Of Misery ✅ | 1.0.9 | "..tostring(executor_Name),
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
getgenv().notify = function(title, content, duration)
    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(duration),
        Image = 93594537601787,
        Actions = {
            Ignore = {
                Name = "Okay.",
                Callback = function() 
                    print("...") 
                end
            },
        },
    })
end
task.wait(1)
local Tab1 = Window:CreateTab("🏡 Main 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Main 🏡 |")
local Tab2 = Window:CreateTab("🧍 Character 🧍", 0)
local Section2 = Tab2:CreateSection("| 🧍 Character Content 🧍 |")
local Tab3 = Window:CreateTab("⭐ Extras ⭐", 0)
local Section3 = Tab3:CreateSection("| ⭐ Extra Content ⭐ |")
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
   getgenv().DisableLogging_AndMetricsData:Set(false)
   disable_logging_metrics(false)
   getgenv().notify("Heads Up:", "Disabled AntiLogging, it was enabled at runtime.", 5)
end

getgenv().Auto_Win = Tab1:CreateButton({
Name = "Auto Win",
Callback = function()
   repeat wait() until getgenv().Workspace:FindFirstChild("Tower") and getgenv().Workspace:FindFirstChild("Top_Section")
   if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value <= 70 then
      collect_all()
      wait(3.6)
      touch_door()
   else
      touch_door()
   end
end,})

getgenv().God_ModeLocalPlr = Tab2:CreateToggle({
Name = "GodMode",
CurrentValue = false,
Flag = "GodmodeValue",
Callback = function(real_godmode)
   if real_godmode then
      GodMode(true)
   else
      GodMode(false)
   end
end,})
wait(0.2)
if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Temporary_Immunity").Value == true then
   GodMode(false)
   getgenv().God_ModeLocalPlr:Set(false)
   getgenv().notify("Heads Up:", "Turned off GodMode, it was enabled at runtime.", 5)
end

getgenv().CollectAll_PlayTimeRewards = Tab3:CreateButton({
Name = "Collect All Playtime Rewards",
Callback = function()
   collect_session_rewards()
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
if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Spectating").Value == true then
   Spectate(false)
   getgenv().SpectatePlayers:Set(false)
   getgenv().notify("Heads Up:", "Disabled Spectate, it was enabled at runtime.", 5)
end
