local scripts = {
	["Tower Of Misery"] = {
		id = 4954752502,
		link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Tower_Of_Misery_ScriptHub.lua"
	},
	["Ultimate Driving"] = {
		id = 54865335,
		link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Ultimate_Driving_Hub.lua"
	},
	["LifeTogether RP"] = {
		id = 13967668166,
		link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_RP.lua"
	},
	["Hide And Seek Extreme"] = {
		id = 205224386,
		link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Hide_And_Seek_Extreme.lua"
	},
    ["Player or AI"] = {
        id = 95217169945642,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Player_Or_AI.lua"
    },
    ["Main Street RP"] = {
        id = 18753889337,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Main_Street_RP.lua"
    },
    ["Southwest Florida Beta"] = {
        id = 5104202731,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Southwest_Florida.lua"
    },
    ["Driving Empire"] = {
        id = 3351674303,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Driving_Empire.lua"
    },
    ["LifeTogether Admin Commands (FE)"] = {
		id = 13967668166,
		link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_RP_Admin.lua"
	},
}

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
    wait(0.2)
    getgenv().Services_Fully_Initialized = true
end
wait()
if not getgenv().Services_Fully_Initialized or getgenv().Services_Fully_Initialized == false then
    init_services()
end
wait()
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

local function SafeGetHumanoid(char)
	local hum = char:FindFirstChildWhichIsA("Humanoid")

	if hum and hum:IsA("Humanoid") then
		return hum
	else
		return char:WaitForChild("Humanoid", 5)
	end
end

local function SafeGetHead(char)
	local head = char:FindFirstChild("Head")
	if head and head:IsA("BasePart") then
		return head
	else
		return char:WaitForChild("Head", 5)
	end
end

local function SafeGetHRP(char)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp and hrp:IsA("BasePart") then
		return hrp
	else
		return char:WaitForChild("HumanoidRootPart", 5)
	end
end

getgenv().HumanoidRootPart = SafeGetHRP(getgenv().Character)
getgenv().Humanoid = SafeGetHumanoid(getgenv().Character)
getgenv().Head = SafeGetHead(getgenv().Character)
wait(0.2)
local function Dynamic_Character_Updater(character)
	getgenv().Character = character
	wait(0.3)
	getgenv().HumanoidRootPart = SafeGetHRP(character)
	getgenv().Humanoid = SafeGetHumanoid(character)
	getgenv().Head = SafeGetHead(character)
    wait(0.2)
    getgenv().Humanoid.JumpHeight = 7
    character:WaitForChild("Humanoid").JumpHeight = 7
end

Dynamic_Character_Updater(getgenv().Character)
task.wait(0.2)

getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(0.2)
	Dynamic_Character_Updater(newCharacter)
	repeat wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
	wait(0.6)
	getgenv().HumanoidRootPart = SafeGetHRP(newCharacter)
	getgenv().Humanoid = SafeGetHumanoid(newCharacter)
	getgenv().Head = SafeGetHead(newCharacter)
	wait(0.3)
    getgenv().Humanoid.JumpHeight = 7
    newCharacter:WaitForChild("Humanoid", 0.2).JumpHeight = 7
	Dynamic_Character_Updater(newCharacter)
end)
wait(0.3)
local Workspace = getgenv().Workspace
local Players = getgenv().Players
local LocalPlayer = getgenv().LocalPlayer or getgenv().Players.LocalPlayer
local Character = getgenv().Character
local HumanoidRootPart = getgenv().HumanoidRootPart
local Humanoid = getgenv().Humanoid
local ReplicatedStorage = getgenv().ReplicatedStorage
-- future reference of course goes in the middle of no where.
local ws = getgenv().Workspace

local function LocalPlayer_loaded()
   -- just to be safe that the LocalPlayer loaded correctly before initializing the script hub for perfect performance.
   local player = Players.LocalPlayer
   if not player then
      repeat task.wait() until Players.LocalPlayer
      player = Players.LocalPlayer
   end

   if not player.Character or not player.Character:FindFirstChild("Humanoid") then
      player.CharacterAdded:Wait()
      -- surprisingly enough, didn't know Humanoid was the main focus of the Character.
      repeat task.wait() until player.Character:FindFirstChild("Humanoid")
   end
end

local function render_safe()
   -- blame Noclip RunService loops existing, not me.
   RunService.RenderStepped:Wait()
   task.wait(0.2)
   -- yes also leave the task.wait(0.2) here, if you don't you'll start to run into performance issues, I've already tried without it.
end

local function load_rayfield()
    local attempts = 0
    local maxAttempts = 10
    local success = false
    local result

    repeat
        attempts += 1
        success, result = pcall(function()
            -- no fully internal function anymore, some exploits didn't like using internal functionality to load UI, would trip up errors about blocked URL's.
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
-- and they are called down here.
LocalPlayer_loaded()
render_safe()

Rayfield = load_rayfield()

if typeof(Rayfield) == "table" and Rayfield.CreateWindow then
    Window = Rayfield:CreateWindow({
        Name = "🏠 Script Hub Loader 🏠 | "..tostring(executor_Name),
        LoadingTitle = "Welcome, "..tostring(game.Players.LocalPlayer),
        LoadingSubtitle = "Scripts | Hub.",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "ScriptHub-Config",
            FileName = "ScriptHubLoader_Hub"
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
            Note = "This is open source, why enable this?",
            FileName = "Key",
            SaveKey = false,
            GrabKeyFromSite = false,
            Key = {""}
        }
    })
else
    warn("[CRITICAL_ERROR]: Rayfield failed to load or is not valid. Returned:", Rayfield)
end
wait(0.2)
getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub = getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub or false
wait(0.1)
function notify(title, content, duration)
    if getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub then
        print("The user has chosen to ignore notifications (has turned them off).")
    else
        Rayfield:Notify({
            Title = tostring(title),
            Content = tostring(content),
            Duration = tonumber(duration),
            Image = 93594537601787,
            Actions = {
                Ignore = {
                    Name = "Alright.",
                    Callback = function() 
                        print("...") 
                    end
                },
            },
        })
    end
end
wait(0.1)
getgenv().notify = notify
getgenv().Buttons = getgenv().Buttons or {}

local Tab1 = Window:CreateTab("🏡 Scripts 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Scripts Section 🏡 |")
local Tab2 = Window:CreateTab("🎮 Game TPs 🎮", 0)
local Section2 = Tab2:CreateSection("| 🎮 Scripts Section 🎮 |")
wait(0.2)
local function sanitize(name)
    return name:gsub("%W", "_")
end

getgenv().FlamesHubUniversal = Tab1:CreateButton({
Name = "Flames Hub (Universal)",
Callback = function()
    loadstring(getgenv().Game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua"))()
end,})

for name, data in pairs(scripts) do
    local key = sanitize(name)
    local d = data

    getgenv().Buttons[key] = Tab1:CreateButton({
    Name = name,
    Callback = function()
        getgenv().GameName = name

        if not d.id or not d.link then
            getgenv().notify("Failure:", "Script data for '" .. name .. "' is invalid.", 5)
            return
        end

        if getgenv().PlaceID == d.id then
            local ok, res = pcall(function()
                local src = getgenv().Game:HttpGet(d.link)
                local f = loadstring(src)
                if not f then error("loadstring returned nil") end
                return f()
            end)
            if not ok then
                getgenv().notify("Execution error:", tostring(res), 7)
            else
                if p and p.DestroyGui then
                    p:DestroyGui()
                end
            end
        else
            getgenv().notify("Failure:", "You're not in the correct game: " .. name .. ".", 5)
        end
    end,})
end

for name, data in pairs(scripts) do
    if name ~= "LifeTogether Admin Commands (FE)" then
        getgenv()[tostring(name)] = Tab2:CreateButton({
        Name = "Teleport To: " .. name,
        Callback = function()
            if data.id then
                getgenv().TeleportService:Teleport(data.id, lp)
            else
                getgenv().notify("Failure:", "No place ID for " .. name, 5)
            end
        end,})
    end
end
