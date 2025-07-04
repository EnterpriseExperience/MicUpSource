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
    local HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
    local Humanoid = newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:FindFirstChildOfClass("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
	getgenv().HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
	getgenv().Humanoid = newCharacter:FindFirstChild("Humanoid") or newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
	getgenv().Head = newCharacter:FindFirstChild("Head") or newCharacter:WaitForChild("Head", 5)
    wait(0.2)
    if getconnections and getgenv().loaded_custom_tp_bypass then
        print("[Custom-TP-Bypass_DEBUG]: Custom TP Bypass has initialized reload from Character respawn, authorizing initialization...")
        wait(0.2)
        for _, conn in pairs(getconnections(HumanoidRootPart:GetPropertyChangedSignal("CFrame"))) do
            conn:Disable()
        end
        for _, conn in pairs(getconnections(HumanoidRootPart:GetPropertyChangedSignal("Position"))) do
            conn:Disable()
        end
    end
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

local function delete_other_fake_tower()
    local ws = getgenv().Workspace or workspace
    local Top_Section = ws:FindFirstChild("Top_Section")
    if not Top_Section then warn("Top_Section not found") end

    local Practice_Stage = Top_Section and Top_Section:FindFirstChild("Practice_Stage")
    if not Practice_Stage then warn("Practice_Stage not found") end

    local Container = Practice_Stage and Practice_Stage:FindFirstChild("Container")
    if not Container then warn("Container not found") end

    local Floor1 = Container and Container:FindFirstChild("Floor #1")
    if not Floor1 then warn("Floor #1 not found") end

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

local function Give_Arcade_Points(number_of_points)
    for i = 1, number_of_points do
        local args = {
            "Zombie_Slayer"
        }

        Remote_Events:WaitForChild("Add_Arcade_Points"):FireServer(unpack(args))
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
            GodMode(true)
            wait(0.2)
            tween_tp("Pass Detector")
        end
    end
end

local function enable_in_game_catalog(toggle)
    if toggle == true then
        getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = true
    elseif toggle == false then
        getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = false
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
    Update_Setting_RE:FireServer(30, false)
    wait(0.1)
    repeat task.wait() until getgenv().LocalPlayer.General.CoinsEarned.Value >= 70
    repeat task.wait() until getgenv().Workspace:FindFirstChild("Tower") and getgenv().Workspace:FindFirstChild("Top_Section")
    if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value >= 70 then
        delete_other_fake_tower()
        local Reward_Door = getgenv().Workspace:FindFirstChild("Top_Section"):FindFirstChild("Hallway"):FindFirstChild("RewardDoor")

        GodMode(true)
        wait(0.3)
        tween_tp("RewardDoor")
    end
end

local ws = getgenv().Workspace or workspace
local Top_Section = ws:FindFirstChild("Top_Section")
if not Top_Section then warn("Top_Section not found") end

local Practice_Stage = Top_Section and Top_Section:FindFirstChild("Practice_Stage")
if not Practice_Stage then warn("Practice_Stage not found") end

local Container = Practice_Stage and Practice_Stage:FindFirstChild("Container")
if not Container then warn("Container not found") end

local Floor1 = Container and Container:FindFirstChild("Floor #1")
if not Floor1 then warn("Floor #1 not found") end

local Reach = Floor1 and Floor1:FindFirstChild("Reach Detector")
local Pass = Floor1 and Floor1:FindFirstChild("Pass Detector")

if Reach then
    Reach:Destroy()
else
    warn("Reach Detector not found")
end

if Pass then
    Pass:Destroy()
else
    warn("Pass Detector not found")
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
        Name = "✅ Tower Of Misery ✅ | 1.2.8-TOM | "..tostring(executor_Name),
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
local AC_Bypass_Loaded = false
wait(0.2)
getgenv().AntiCheat_Bypass = Tab1:CreateButton({
Name = "Anti Cheat Bypass",
Callback = function()
    if not AC_Bypass_Loaded or AC_Bypass_Loaded == false then
        getgenv().notify("Hang On:", "Bypassing anti-cheat...", 5)
        bypass_anticheat()
        wait(0.3)
        AC_Bypass_Loaded = true
        getgenv().notify("Success:", "Bypassed anticheat, do what ever you want!", 5)
    elseif AC_Bypass_Loaded then
        return getgenv().notify("Heads Up:", "You've already loaded anti-cheat bypass!", 5)
    end
    task.wait()
    if not getgenv().loaded_custom_tp_bypass and getconnections then
        getgenv().notify("Hang On:", "Loading Custom TP Bypass...", 5)
        task.wait(0.1)

        local hrp = getgenv().Character and getgenv().Character:WaitForChild("HumanoidRootPart")

        if not hrp then
            return getgenv().notify("Error:", "HumanoidRootPart not found, cannot load TP bypass.", 5)
        end

        local function disconnect_connection(prop)
            for _, conn in pairs(getconnections(hrp.Changed)) do
                if typeof(conn.Function) == "function" then
                    local info = debug.getinfo(conn.Function)
                    if info and info.source and string.find(info.source, prop) then
                        pcall(function() conn:Disable() end)
                    end
                end
            end

            for _, conn in pairs(getconnections(hrp:GetPropertyChangedSignal(prop))) do
                pcall(function() conn:Disable() end)
            end
        end
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

        ScreenGui.Parent = getgenv().PlayerGui

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "FlexLabel"
        TextLabel.Parent = ScreenGui
        TextLabel.AnchorPoint = Vector2.new(0.5, 0)
        TextLabel.Position = UDim2.new(0.5, 0, 0, 2)
        TextLabel.Size = UDim2.new(0.9, 0, 0, 30)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "Custom TP Bypass was made by: weareupthereman_38879 on Discord."
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
        TextLabel.TextScaled = true
        TextLabel.TextWrapped = true

        local UIStroke = Instance.new("UIStroke", TextLabel)
        UIStroke.Color = Color3.new(0, 0, 0)
        UIStroke.Thickness = 1.3

        disconnect_connection("Position")
        disconnect_connection("CFrame")

        task.wait(0.1)
        getgenv().loaded_custom_tp_bypass = true
    elseif getgenv().loaded_custom_tp_bypass then
        return getgenv().notify("Heads Up:", "You already loaded Custom TP Bypass.", 5)
    elseif not getconnections then
        getgenv().loaded_custom_tp_bypass = true
        return getgenv().notify("Error:", "Cannot load Custom TP Bypass, missing 'getconnections'", 5)
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

    if not getgenv().GET_LOADED_IY or getgenv().GET_LOADED_IY == nil then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua'))()
    end
    wait(0.1)
    if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value <= 70 then
        if getgenv().God_ModeLocalPlr then
            getgenv().God_ModeLocalPlr:Set(true)
        end
        GodMode(true)
        wait(0.1)
        collect_all()
        wait(0.3)
        getgenv().execCmd("noclip")
        getgenv().execCmd("fly 3")
        wait(3.5)
        touch_door()
        wait(3)
        getgenv().execCmd("unfly")
        getgenv().execCmd("clip")
        getgenv().execCmd("clip")
        wait(0.5)
        getgenv().execCmd("jump")
    else
        GodMode(true)
        wait(0.2)
        touch_door()
        wait(3)
        getgenv().execCmd("unfly")
        getgenv().execCmd("clip")
        getgenv().execCmd("clip")
        wait(0.5)
        getgenv().execCmd("jump")
    end
end,})

getgenv().AntiChat_Log = Tab3:CreateButton({
Name = "Anti Chat Log (Working!)",
Callback = function()
    if not game:IsLoaded() then
        game.Loaded:wait()
    end

    if not getrawmetatable then
        return getgenv().notify("Failure:", "Your executor does not support 'getrawmetatable'.", 5)
    end
    if not setreadonly then
        return getgenv().notify("Failure:", "Your executor does not support 'setreadonly'", 5)
    end
    if not hookmetamethod then
        return getgenv().notify("Failure:", "Your executor does not support 'hookmetamethod'", 5)
    end
    if not setfflag then
        return getgenv().notify("Failure:", "Your executor does not support 'setfflag'", 5)
    end
    task.wait(3)

    local ACL_LoadTime = tick()
    local NotificationTitle = "[Flame's ACL]"

    local OldCoreTypeSettings = {}
    local WhitelistedCoreTypes = {
        "Chat",
        "All",
        Enum.CoreGuiType.Chat,
        Enum.CoreGuiType.All
    }

    local OldCoreSetting = nil

    local CoreGui = game:GetService("CoreGui")
    local StarterGui = getgenv().StarterGui or game:GetService("StarterGui")
    local TweenService = getgenv().TweenService or game:GetService("TweenService")
    local TextChatService = getgenv().TextChatService or game:GetService("TextChatService")
    local Players = getgenv().Players or game:GetService("Players")
    local Player = getgenv().LocalPlayer or Players.LocalPlayer

    local Notify = function(_Title, _Text , Time)
        StarterGui:SetCore("SendNotification", {Title = _Title, Text = _Text, Icon = "rbxassetid://2541869220", Duration = Time})
    end

    local Tween = function(Object, Time, Style, Direction, Property)
        return TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle[Style], Enum.EasingDirection[Direction]), Property)
    end

    local PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui") do
        if not PlayerGui then
            local Timer = tick() + 5
            repeat task.wait() until Player:FindFirstChildWhichIsA("PlayerGui") or (tick() > Timer)
            PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui") or false
            if not PlayerGui then
                return Notify(NotificationTitle, "Failed to find PlayerGui!", 10)
            end
        end
    end

    if getgenv().AntiChatLogger then
        return Notify(NotificationTitle, "Anti Chat & Screenshot Logger already loaded!", 15)
    else
        getgenv().AntiChatLogger = true
    end

    local Metatable = getrawmetatable(StarterGui)
    setreadonly(Metatable, false)

    local MessageEvent = Instance.new("BindableEvent")

    if hookmetamethod then
        local CoreHook do
            CoreHook = hookmetamethod(StarterGui, "__namecall", newcclosure(function(self, ...)
                local Method = getnamecallmethod()
                local Arguments = {...}
                
                if self == StarterGui and not checkcaller() then
                    if Method == "SetCoreGuiEnabled" then
                        local CoreType = Arguments[1]
                        local Enabled = Arguments[2]
                        
                        if table.find(WhitelistedCoreTypes, CoreType) and Enabled == false then
                            OldCoreTypeSettings[CoreType] = Enabled
                            return 
                        end
                    elseif Method == "SetCore" then
                        local Core = Arguments[1]
                        local Connection = Arguments[2]
                        
                        if Core == "CoreGuiChatConnections" then
                            OldCoreSetting = Connection
                            return
                        end
                    end
                end
                
                return CoreHook(self, ...)
            end))
        end

        if not getgenv().ChattedFix then
            if hookmetamethod then
                getgenv().ChattedFix = true

                local ChattedFix do
                    ChattedFix = hookmetamethod(Player, "__index", newcclosure(function(self, index)
                        if self == Player and tostring(index):lower():match("chatted") and MessageEvent.Event then
                            return MessageEvent.Event
                        end

                        return ChattedFix(self, index)
                    end))
                end

                local AnimateChattedFix = task.spawn(function()
                    local ChattedSignal = false

                    for _, x in next, getgc() do
                        if type(x) == "function" and getfenv(x).script ~= nil and tostring(getfenv(x).script) == "Animate" then
                            if islclosure(x) then
                                local Constants = getconstants(x)

                                for _, v in next, Constants do
                                    if v == "Chatted" then
                                        ChattedSignal = x
                                    end
                                end
                            end
                        end
                    end

                    if ChattedSignal then
                        ChattedSignal()
                    end
                end)
            end
        end
    end

    local EnabledChat = task.spawn(function()
        repeat
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
            task.wait()
        until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
    end)

    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        getgenv().notify("Failure:", "Detected new chat, loading Anti Screenshot...", 5)
        if setfflag then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
                getgenv().notify("Success:", "Just Anti Screenshot was loaded.", 5)
                task.wait(0.2)
                getgenv().notify("Success:", "Because your using the new TextChatService.", 5)
            end)
        else
            getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
        end
        return 
    end

    local PlayerScripts = Player:WaitForChild("PlayerScripts")
    local ChatMain = PlayerScripts:FindFirstChild("ChatMain", true) or false

    if not ChatMain then
        local Timer = tick()
        
        repeat task.wait() until PlayerScripts:FindFirstChild("ChatMain", true) or tick() > (Timer + 3)
        ChatMain = PlayerScripts:FindFirstChild("ChatMain", true)
        
        if not ChatMain then
            getgenv().notify("Failure:", "Did not find ChatMain, loading Anti Screenshot instead...", 5)
            if setfflag then
                pcall(function()
                    setfflag("AbuseReportScreenshot", "False")
                    setfflag("AbuseReportScreenshotPercentage", "0")
                    getgenv().notify("Success:", "Just Anti Screenshot was loaded.", 5)
                    task.wait(0.2)
                    getgenv().notify("Success:", "Because we could not find ChatMain LocalScript.", 5)
                end)
            else
                getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
            end
            return
        end
    end

    local PostMessage = require(ChatMain).MessagePosted

    if not PostMessage then
        getgenv().notify("Failure:", "PostMessage could not be located, loading Anti Screenshot...", 5)
        if setfflag then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
                getgenv().notify("Success:", "Just Anti Screenshot was loaded.", 5)
                task.wait(0.2)
                getgenv().notify("Success:", "Because we could not properly allocate PostMessage ModuleScript.", 5)
            end)
        else
            getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
        end
        return
    end

    local OldFunctionHook; OldFunctionHook = hookfunction(PostMessage.fire, function(self, Message)
        if self == PostMessage then
            MessageEvent:Fire(Message)
            return
        end
        return OldFunctionHook(self, Message)
    end)

    if setfflag then
        pcall(function()
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
        end)
    else
        getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
    end -- To prevent roblox from taking screenshots of your client.

    local Credits = task.spawn(function()
        local UserIds = {
            1414978355
        }
        
        if table.find(UserIds, Player.UserId) then
            return
        end
        
        local Tag = Instance.new("BillboardGui")
        local Title = Instance.new("TextLabel", Tag)
        local Rank = Instance.new("TextLabel", Tag)
        local Gradient = Instance.new("UIGradient", Title)
        
        Tag.Brightness = 2
        Tag.Size = UDim2.new(4, 0, 1, 0)
        Tag.StudsOffsetWorldSpace = Vector3.new(0, 5, 0)
        
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, 0, .6, 0)
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextScaled = true
        
        Rank.AnchorPoint = Vector2.new(.5, 0)
        Rank.BackgroundTransparency = 1
        Rank.Position = UDim2.new(.5, 0, .65, 0)
        Rank.Size = UDim2.new(.75, 0, .5, 0)
        Rank.TextColor3 = Color3.fromRGB(0, 0, 0)
        Rank.TextScaled = true
        Rank.Text = "< Anti Chat-Logger >"
        
        Gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(.75, .75, .75)),
            ColorSequenceKeypoint.new(.27, Color3.new(0, 0, 0)),
            ColorSequenceKeypoint.new(.5, Color3.new(.3, 0, .5)),
            ColorSequenceKeypoint.new(0.78, Color3.new(0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.new(.75, .75, .75))
        })
        Gradient.Offset = Vector2.new(-1, 0)
        
        local GradientTeen = Tween(Gradient, 2, "Circular", "Out", {Offset = Vector2.new(1, 0)})
        
        function PlayAnimation()
            GradientTeen:Play()
            GradientTeen.Completed:Wait()
            Gradient.Offset = Vector2.new(-1, 0)
            task.wait(.75)
            PlayAnimation()
        end
        
        local AddTitle = function(Character)
            repeat task.wait() until Character
            
            local Humanoid = Character and Character:WaitForChild("Humanoid")
            local RootPart = Humanoid and Humanoid.RootPart
            
            if Humanoid then
                Humanoid:GetPropertyChangedSignal("RootPart"):Connect(function()
                    if Humanoid.RootPart then
                        Tag.Adornee = RootPart
                    end
                end)
            end
            
            if RootPart then
                Tag.Adornee = RootPart
            end
        end
        
        task.spawn(PlayAnimation)
        
        for _, x in next, Players:GetPlayers() do
            if table.find(UserIds, x.UserId) then
                Tag.Parent = workspace.Terrain
                Title.Text = x.Name
                AddTitle(x.Character)
                x.CharacterAdded:Connect(AddTitle)
            end
        end
        
        Players.PlayerAdded:Connect(function(x)
            if table.find(UserIds, x.UserId) then
                Tag.Parent = workspace.Terrain
                Title.Text = x.Name
                x.CharacterAdded:Connect(AddTitle)
            end
        end)
        
        Players.PlayerRemoving:Connect(function(x)
            if table.find(UserIds, x.UserId) then
                Tag.Parent = game
            end
        end)
    end)

    for _, x in next, OldCoreTypeSettings do
        if not x then
            StarterGui:SetCore("ChatActive", false)
        end
        StarterGui:SetCoreGuiEnabled(_, x)
    end

    if OldCoreSetting then
        StarterGui:SetCore("CoreGuiChatConnections", OldCoreSetting)
    end

    if StarterGui:GetCore("ChatActive") then
        StarterGui:SetCore("ChatActive", false)
        StarterGui:SetCore("ChatActive", true)
    end

    --Metatable.__namecall = CoreHook
    if CoreHook then
        setmetatable(Metatable, {__namecall = CoreHook}) 
    end
    setreadonly(Metatable, true)

    Notify(NotificationTitle, "Flame's Anti Chat & Screenshot Logger Loaded!", 15)
    print(string.format("Flame's Anti Chat-Logger has loaded in %s seconds.", string.format("%.2f", tostring(tick() - ACL_LoadTime))))
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

local bodyColors = getgenv().Character:FindFirstChild("Body Colors")
if not bodyColors then
    warn("no Body Colors on chararacter.")
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
    local Shop_Folder = getgenv().ReplicatedStorage:WaitForChild("Remote_Functions"):WaitForChild("Shop")

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

getgenv().Anti_Fog_AndColor_Swap = Tab1:CreateToggle({
Name = "Anti Fog (And Color Swap)",
CurrentValue = false,
Flag = "AntiFogAndColorSwap",
Callback = function(anti_fog_color_swap)
    if anti_fog_color_swap then
        getgenv().anti_fog_and_the_color_swap = true
        local Winner_Val = getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Winner")

        while getgenv().anti_fog_and_the_color_swap == true do
        wait()
            Winner_Val.Value = true
        end
    else
        getgenv().anti_fog_and_the_color_swap = false
        getgenv().anti_fog_and_the_color_swap = false
        wait(0.2)
        local Winner_Val = getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Winner")

        Winner_Val.Value = false
    end
end,})

getgenv().CollectAll_PlayTimeRewards = Tab3:CreateButton({
Name = "Collect All Playtime Rewards",
Callback = function()
    local Session_Rewards_Value = getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Session_Reward_Coins")
    
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
    local Old_Main_Color = getgenv().Character:FindFirstChild("Body Colors").TorsoColor
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

            local remote = getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid")

            for _, color in ipairs(colorCycle) do
                task.wait(.3)
                local payload = {
                    { BodyColor = color }
                }

                remote:FireServer(unpack(payload))
            end
        end
    else
        getgenv().skin_rainbow_loop = false
        getgenv().skin_rainbow_loop = false
        wait(0.3)
        if getgenv().Character:FindFirstChild("Body Colors") then
            getgenv().notify("Hang On:", "Resetting Body Colors...", 5)
            wait(1.2)
            local args = {
                {
                    BodyColor = Old_Main_Color
                }
            }
            getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
            wait(2.5)
            if getgenv().Character:FindFirstChild("Body Colors").TorsoColor == Old_Main_Color then
                return getgenv().notify("Success:", "Reset fully body colors back to default.", 5)
            else
                return getgenv().notify("Alert:", "Could not determine if Body Colors we're reset properly.", 5)
            end
        end
    end
end,})

getgenv().ResetBody_Colors = Tab2:CreateButton({
Name = "Reset Body Colors (FE)",
Callback = function()
    local args = {
        {
            BodyColor = Old_Body_Colors.TorsoColor3
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.HeadColor3
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.LeftArmColor3
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.RightArmColor3
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.LeftLegColor3
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
    wait(0.1)
    args = {
        {
            BodyColor = Old_Body_Colors.RightLegColor3
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
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
        getgenv().layered_painting_autofarm = true
        while getgenv().layered_painting_autofarm == true do

        task.wait()
            for _, v in ipairs(getgenv().Workspace:FindFirstChild("Top_Section").Layer_Painting.Clear:GetChildren()) do
                if v:IsA("BasePart") then
                    task.wait()
                    getgenv().Character:PivotTo(v:GetPivot() * CFrame.new(0, 5, 0))
                end
            end
        end
    else
        getgenv().layered_painting_autofarm = false
        getgenv().layered_painting_autofarm = false
    end
end,})

getgenv().UnlimitedPoints_ReGen = Tab2:CreateToggle({
Name = "Loop Generate Arcade Points (FE)",
CurrentValue = false,
Flag = "KeepGeneratingPointsEz",
Callback = function(anypoints_i_want)
    if anypoints_i_want then
        getgenv().unlimited_number_of_points = true
        while getgenv().unlimited_number_of_points == true do
        wait(0.3)
            local args = {
                "Zombie_Slayer"
            }

            getgenv().ReplicatedStorage:WaitForChild("Remote_Events"):WaitForChild("Add_Arcade_Points"):FireServer(unpack(args))
            task.wait(0.2)
            local args = {
                "Layer_Painting"
            }

            getgenv().ReplicatedStorage:WaitForChild("Remote_Events"):WaitForChild("Add_Arcade_Points"):FireServer(unpack(args))
            task.wait(0.2)
            local args = {
                "Rocket_Blocks"
            }

            getgenv().ReplicatedStorage:WaitForChild("Remote_Events"):WaitForChild("Add_Arcade_Points"):FireServer(unpack(args))
        end
    else
        getgenv().unlimited_number_of_points = false
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
if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Spectating").Value == true then
    Spectate(true)
    getgenv().SpectatePlayers:Set(true)
else
    Spectate(false)
    getgenv().SpectatePlayers:Set(false)
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
