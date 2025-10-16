local function blankfunction(...)
    return ...
end

local cloneref = cloneref or blankfunction

local Raw_Version = "1.5.4"
local Script_Version = tostring(Raw_Version.."-TOM")

getgenv().Game = cloneref and cloneref(game) or game
getgenv().cloneref = cloneref
wait()
if not getgenv().Game:IsLoaded() then
   getgenv().Game.Loaded:Wait()
end
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId

local NotifyLib = loadstring(getgenv().Game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
local set_fps = setfpscap or setfps
getgenv().SetFPSCap = set_fps

function notify(notif_type, msg, duration)
   NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration))
end
wait(0.1)
getgenv().notify = notify

local function Service_Wrap(serviceName)
    if cloneref then
        return cloneref(getgenv().Game:GetService(serviceName))
    else
        return getgenv().Game:GetService(serviceName)
    end
end
wait(0.1)
getgenv().Service_Wrap = Service_Wrap

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
        return getgenv().notify("Error", "You cannot target yourself!", 6)
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
getgenv().HumanoidRootPart = getgenv().Character:WaitForChild("HumanoidRootPart") or getgenv().Character:FindFirstChild("HumanoidRootPart", true)
getgenv().Humanoid = getgenv().Character:WaitForChild("Humanoid") or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid")
getgenv().Head = getgenv().Character:WaitForChild("Head") or getgenv().Character:FindFirstChild("Head")
local Anti_Ragdoll_Active = false
local Inf_Stamina_Active = false

wait(0.2)
-- This is here to automatically fix the warning messages in the console, so you don't have to respawn to apply it.
-- Your welcome.
if getgenv().Character:FindFirstChild("Character Initializer") then
    getgenv().Character:FindFirstChild("Character Initializer").Disabled = true
end
local function Dynamic_Character_Updater(character)
	getgenv().Character = character or getgenv().LocalPlayer.Character
	task.wait(0.3)
	local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 5)
	getgenv().HumanoidRootPart = (hrp and hrp:IsA("BasePart")) and hrp

	local hum = character:FindFirstChildOfClass("Humanoid")
	getgenv().Humanoid = (hum and hum:IsA("Humanoid")) and hum

	local head = character:FindFirstChild("Head")
	getgenv().Head = (head and head:IsA("BasePart")) and head

    if getgenv().Character:FindFirstChild("Character Initializer") then
        getgenv().Character:FindFirstChild("Character Initializer").Disabled = true
    end
end

Dynamic_Character_Updater(getgenv().Character)
task.wait(0.2)
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(1)
	Dynamic_Character_Updater(newCharacter)
	getgenv().LocalPlayer.CharacterAdded:Wait()
	task.wait(0.5)
	getgenv().Character = newCharacter
    local HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
    local Humanoid = newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:FindFirstChildOfClass("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
	getgenv().HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5) or HumanoidRootPart
	getgenv().Humanoid = newCharacter:FindFirstChild("Humanoid") or newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:WaitForChild("Humanoid", 5) or Humanoid
	getgenv().Head = newCharacter:FindFirstChild("Head") or newCharacter:WaitForChild("Head", 5)
    wait(0.2)
    -- Here to fix warning messages being rapidly spammed in the console.
    if newCharacter:FindFirstChild("Character Initializer", true) then
        getgenv().notify("Info", "Re-disabling Character Initializer LocalScript.", 5)
        newCharacter:FindFirstChild("Character Initializer", true).Disabled = true
    end
end)

local Remote_Events = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events", true)
local General_Folder = getgenv().LocalPlayer:FindFirstChild("General", true)
local General_Folder_RE = Remote_Events:FindFirstChild("General", true)
local Update_Setting_RE = General_Folder_RE:FindFirstChild("Update_Settings", true)
local Crate_System_V2 = getgenv().ReplicatedStorage:FindFirstChild("Crate_System_V2", true)
local Crate_System_Remote_Events = Crate_System_V2:FindFirstChild("Remote_Events", true)
local Open_Crate_RE = Crate_System_Remote_Events:FindFirstChild("Open_Crate", true)
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or getgenv().LocalPlayer

-- This is here to prevent spam errors in the console, you're welcome.
for _, v in ipairs(Players:GetDescendants()) do
	if v:IsA("ScreenGui") and string.find(v.Name, "Height_Meter_V2") then
		for _, k in ipairs(v:GetDescendants()) do
			if k:IsA("LocalScript") and k.Name == "LocalScript" then
				k:Destroy()
			end
		end
	end
end

-- Fixes the other errors in the console.
if getgenv().PlayerGui:FindFirstChild("Client_Side_GUI", true) then
    local Client_Side_GUI = getgenv().PlayerGui:FindFirstChild("Client_Side_GUI", true)
	local Temporary_LocalScript = Client_Side_GUI:FindFirstChild("Temporary", true)

    if Temporary_LocalScript then
	    Temporary_LocalScript.Disabled = true
    end
else
    getgenv().notify("Info", "Skipping Temporary logging, Client_Side_GUI not found inside of PlayerGui.", 6)
end

-- Fixes the "Fling Glove" error in the console.
if getgenv().PlayerGui:FindFirstChild("Player Scripts") then
   for _, v in ipairs(getgenv().PlayerGui:FindFirstChild("Player Scripts"):GetChildren()) do
        if v:IsA("Frame") and v.Name == "General" then
            local Main_Frame = v
            local Fling_Glove_UI_LocalScript = v:FindFirstChild("Fling Glove UI", true)

            if Fling_Glove_UI_LocalScript and Fling_Glove_UI_LocalScript:IsA("LocalScript") and Fling_Glove_UI_LocalScript.Disabled then
                v.Disabled = true
            end
        end
    end
end

local function bypass_anticheat()
    if not getfunctionhash then return getgenv().notify("Error", "This will not work for you (missing 'getfunctionhash')!", 6) end
    if not getgc then return getgenv().notify("Error", "This will not work for you (missing 'getgc')!", 5) end
    if not hookfunction then return getgenv().notify("Error", "This will not work for you (missing 'hookfunction')!", 6) end

    if getgenv().AntiCheat_Bypass_Loaded then
        return getgenv().notify("Warning", "You've already bypassed Tower Of Misery's AntiCheat!", 6)
    end

    local hashes = {
        "1e7e28314dd929a6e08f04468ca62e5233c69c41630acfe7c8e46b6c1b4e8436664fdecb8f0e9c498b1b5a0ac5c6c5d9",
        "b89fe06efd2c09de9e141f9a0b3cb705d228c400296d3ee6f9372de82ee7ee7333a9ebc9210cee6c56e7edf619026a74",
        "27a914826949e4e0f1a20310729181ad6c96dc0f769f299ed4eab08bcde94f69216e4c158bd5c3f12a8276211453b4eb",
        "933c9e33b1d8175e9956604a20192cd2926af60bde4acd9ca0679ea6a700fc13572fcc99410c0b0596cfd86927f9fb04",
        "81879f26ee87ac81c2c681a0f791d3668dc31b18e7a9de2a6212745f6de5d36fc60e3f6c2ffaf79442b0839b3a321913",
        "63bb13cebccb96400062b0ece63b541f74533f326aa2be1e466ccfefd94b0264cc859ec99b38576eb99d54598e180c98",
        "38bf0dab847b4c154c0d8e69bc915d845cae003049941b0b0c755bdd903d9bdaddde4c0eaf36da8c8323e7e430ef32f5",
    }

    for i, v in next, getgc() do
        if typeof(v) == "function" and islclosure(v) then
            local hash = getfunctionhash(v)
            for _, h in next, hashes do
                if hash == h then
                    hookfunction(v, function() end)
                    getgenv().notify("Success", "Successfully bypassed Anti-Cheat.", 7)
                    getgenv().AntiCheat_Bypass_Loaded = true
                end
            end
        end
    end
end

local function tp_place(place)
    local TweenService = getgenv().TweenService

    for i,v in pairs(getgenv().Workspace:GetDescendants()) do
        if v.Name == place and v:IsA("BasePart") then
            if getgenv().Humanoid and getgenv().Humanoid.SeatPart then
                getgenv().Humanoid.Sit = false
                getgenv().Humanoid:ChangeState(3)
                wait(.1)
            end
            wait(0.1)
            getgenv().HumanoidRootPart.CFrame = v.CFrame
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

local function GodMode(toggle)
	local Temporary_Immunity = General_Folder:FindFirstChild("Temporary_Immunity", true)
    if not Temporary_Immunity then return getgenv().notify("Error", "Temporary_Immunity doesn't exist in General Folder!", 6) end

	if toggle == true then
        Update_Setting_RE:FireServer(30, false)
		Temporary_Immunity.Value = true
        getgenv().notify("Success", "Godmode has been enabled.", 3)
	elseif toggle == false then
		Temporary_Immunity.Value = false
        getgenv().notify("Success", "Godmode has been disabled.", 3)
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
    if not AC_Bypass_Loaded or AC_Bypass_Loaded == false then
        getgenv().notify("Info", "Bypassing anti-cheat...", 5)
        bypass_anticheat()
        wait(0.3)
        AC_Bypass_Loaded = true
        getgenv().notify("Success", "Bypassed anticheat, do what ever you want!", 5)
    elseif AC_Bypass_Loaded then
        return getgenv().notify("Warning", "You've already loaded anti-cheat bypass!", 5)
    end
    task.wait()
    if not getgenv().loaded_custom_tp_bypass then
        getgenv().notify("Hang On:", "Loading Custom TP Bypass...", 5)
        wait(0.1)
        local StarterGui = getgenv().StarterGui
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "TopBar_Label"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.IgnoreGuiInset = true
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        if syn and syn.protect_gui then
            syn.protect_gui(ScreenGui)
        end

        ScreenGui.Parent = getgenv().CoreGui or getgenv().PlayerGui

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "FlexLabel"
        TextLabel.Parent = ScreenGui
        TextLabel.AnchorPoint = Vector2.new(0.5, 0)
        TextLabel.Position = UDim2.new(0.5, 0, 0, 2)
        TextLabel.Size = UDim2.new(0.9, 0, 0, 30)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "Custom TP Bypass was made by: computerbinaries on Discord."
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
        TextLabel.TextScaled = true
        TextLabel.TextWrapped = true

        local UIStroke = Instance.new("UIStroke", TextLabel)
        UIStroke.Color = Color3.new(0, 0, 0)
        UIStroke.Thickness = 1.3
        task.wait(0.1)
        getgenv().loaded_custom_tp_bypass = true
    else
        return getgenv().notify("Heads Up:", "You already loaded Custom TP Bypass.", 5)
    end
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
    repeat wait() until getgenv().Workspace:FindFirstChild("Tower") and getgenv().Workspace:FindFirstChild("Top_Section")

    wait(0.1)
    if General_Folder:FindFirstChild("CoinsEarned", true).Value <= 70 then
        if getgenv().God_ModeLocalPlr then
            getgenv().God_ModeLocalPlr:Set(true)
        end
        GodMode(true)
        wait(0.1)
        collect_all()
        wait(3.5)
        touch_door()
    else
        GodMode(true)
        wait(0.2)
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
   getgenv().God_ModeLocalPlr:Set(true)
else
    getgenv().God_ModeLocalPlr:Set(false)
end

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
if getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled == true then
    getgenv().InGame_Catalog:Set(true)
    getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = true
else
    getgenv().InGame_Catalog:Set(false)
    getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = false
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
        return getgenv().notify("Error:", "Viewing_Billboard or FreeSpin GUI not found.", 5)
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

local bodyColors = getgenv().Character:FindFirstChild("Body Colors", true)
if not bodyColors then
    getgenv().notify("Success", "no BodyColors on Character.", 5)
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
    local Remote_F = getgenv().ReplicatedStorage:FindFirstChild("Remote_Functions", true)
    if not Remote_F then return getgenv().notify("Error", "Remote_Functions doesn't exist in ReplicatedStorage!", 5) end
    local Shop_Folder = Remote_F:FindFirstChild("Shop", true)
    if not Shop_Folder then return getgenv().notify("Error", "Shop Folder doesn't exist in Remote_Functions!", 5) end

    local function Purchase_Mutator(Mutator)
        if not Shop_Folder then return end

        if Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)) then
            Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)):InvokeServer()
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
        Purchase_Mutator(mutator)
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

getgenv().Rainbow_FE_Skin = Tab2:CreateToggle({
Name = "Rainbow Skin (FE)",
CurrentValue = false,
Flag = "FERainbowSkinScript",
Callback = function(rainbow_loop)
    local Old_Main_Color = getgenv().Character:FindFirstChild("Body Colors", true).TorsoColor
    local Bloxbiz_Remotes = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes", true)
    if not Bloxbiz_Remotes then
        getgenv().Rainbow_FE_Skin:Set(false)
        getgenv().skin_rainbow_loop = false
        return getgenv().notify("Error", "BloxbizRemotes Folder was not found in ReplicatedStorage!", 5)
    end
    local remote = Bloxbiz_Remotes:FindFirstChild("CatalogOnApplyToRealHumanoid", true)
    if not remote then
        getgenv().Rainbow_FE_Skin:Set(false)
        getgenv().skin_rainbow_loop = false
        return getgenv().notify("Error", "SkinTone Changer Remote was not found in BloxbizRemotes Folder!", 6)
    end
    if not Old_Main_Color then
        getgenv().skin_rainbow_loop = false
        getgenv().Rainbow_FE_Skin:Set(false)
        return getgenv().notify("Error", "We we're not able to find your TorsoColor!", 5)
    end

    wait()
    if rainbow_loop then
        getgenv().skin_rainbow_loop = true
        while getgenv().skin_rainbow_loop == true do
        wait()
            local colorCycle = {
                Color3.fromRGB(17, 17, 17),
                Color3.fromRGB(101, 67, 33),
                Color3.fromRGB(0, 102, 204),
                Color3.fromRGB(0, 153, 0),
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(128, 128, 128),
                Color3.fromRGB(255, 255, 0),
                Color3.fromRGB(255, 165, 0),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(128, 0, 128),
                Color3.fromRGB(255, 105, 180),
                Color3.fromRGB(0, 255, 255)
            }

            for _, color in ipairs(colorCycle) do
                task.wait(.3)
                local payload = {
                    { BodyColor = color }
                }

                remote:FireServer(unpack(payload))
            end
        end
    else
        local Bloxbiz_Remotes = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes", true)
        if not Bloxbiz_Remotes then
            getgenv().Rainbow_FE_Skin:Set(false)
            getgenv().skin_rainbow_loop = false
            return getgenv().notify("Error", "BloxbizRemotes Folder was not found in ReplicatedStorage!", 5)
        end
        local remote = Bloxbiz_Remotes:FindFirstChild("CatalogOnApplyToRealHumanoid", true)
        if not remote then
            getgenv().Rainbow_FE_Skin:Set(false)
            getgenv().skin_rainbow_loop = false
            return getgenv().notify("Error", "SkinTone Changer Remote was not found in BloxbizRemotes Folder!", 6)
        end
        
        getgenv().skin_rainbow_loop = false
        wait(0.3)
        if getgenv().Character:FindFirstChild("Body Colors", true) then
            getgenv().notify("Info", "Resetting Body Colors...", 5)
            wait(1.2)
            local args = {
                {
                    BodyColor = Old_Main_Color
                }
            }
            remote:FireServer(unpack(args))
            wait(2.5)
            if getgenv().Character:FindFirstChild("Body Colors", true).TorsoColor == Old_Main_Color then
                return getgenv().notify("Success", "Reset fully body colors back to default.", 5)
            else
                return getgenv().notify("Warning", "Could not determine if Body Colors we're reset properly.", 5)
            end
        end
    end
end,})

getgenv().ResetBody_Colors = Tab2:CreateButton({
Name = "Reset Body Colors (FE)",
Callback = function()
    local Bloxbiz_Remotes = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes", true)
    if not Bloxbiz_Remotes then
        getgenv().Rainbow_FE_Skin:Set(false)
        getgenv().skin_rainbow_loop = false
        return getgenv().notify("Error", "BloxbizRemotes Folder was not found in ReplicatedStorage!", 5)
    end
    local remote = Bloxbiz_Remotes:FindFirstChild("CatalogOnApplyToRealHumanoid", true)
    if not remote then
        getgenv().Rainbow_FE_Skin:Set(false)
        getgenv().skin_rainbow_loop = false
        return getgenv().notify("Error", "SkinTone Changer Remote was not found in BloxbizRemotes Folder!", 6)
    end

    local args = {
        {
            BodyColor = Old_Body_Colors.TorsoColor3
        }
    }
    remote:FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.HeadColor3
        }
    }
    remote:FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.LeftArmColor3
        }
    }
    remote:FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.RightArmColor3
        }
    }
    remote:FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.LeftLegColor3
        }
    }
    remote:FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.RightLegColor3
        }
    }
    remote:FireServer(unpack(args))
end,})

getgenv().GiveArcade_Points_Other = Tab2:CreateInput({
Name = "Give Arcade Points (FE)",
PlaceholderText = "Number Here",
RemoveTextAfterFocusLost = true,
Callback = function(Number_Points)
    local Number_Of_Points_Input = tonumber(Number_Points)

    if Number_Of_Points_Input then
        getgenv().notify("Hang On:", "Giving you "..tostring(Number_Points).." points.", 5)
        Give_Arcade_Points(Number_Points)
    else
        return getgenv().notify("Failure:", tostring(Number_Points).." isn't a number!", 5)
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
    getgenv().notify("Hang On:", "Enabling AntiFog, it was enabled before initialization.", 5)
    getgenv().Anti_Fog_AndColor_Swap:Set(true)
else
    getgenv().anti_fog_and_the_color_swap = false
    getgenv().Anti_Fog_AndColor_Swap:Set(false)
end
task.wait()
if getgenv().skin_rainbow_loop == true then
    getgenv().notify("Hang On:", "Enabling RainbowSkinFE, it was enabled before initialization.", 5)
    getgenv().Rainbow_FE_Skin:Set(true)
else
    getgenv().skin_rainbow_loop = false
    getgenv().Rainbow_FE_Skin:Set(false)
end
wait(0.1)
if getgenv().unlimited_number_of_points == true then
    getgenv().notify("Hang On:", "Enabling UnlimitedArcadePoints, it was enabled before load.", 5)
    getgenv().UnlimitedPoints_ReGen:Set(true)
else
    getgenv().UnlimitedPoints_ReGen:Set(false)
    getgenv().unlimited_number_of_points = false
end
