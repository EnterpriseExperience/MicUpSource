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
	wait(0.2)
	Dynamic_Character_Updater(newCharacter)
end)
wait(0.2)
local has_hookfunction = typeof(hookfunction) == "function"
local has_hookmetamethod = typeof(hookmetamethod) == "function"
local has_getmetatable = typeof(getmetatable) == "function"
local has_setmetatable = typeof(setmetatable) == "function"

if getgenv().advanced_workaround_method == nil then
    getgenv().advanced_workaround_method = false
end

print("hookfunction:", has_hookfunction)
print("hookmetamethod:", has_hookmetamethod)
print("getmetatable:", has_getmetatable)
print("setmetatable:", has_setmetatable)
print("getgenv().advanced_workaround_method:", getgenv().advanced_workaround_method)

if not getgenv().advanced_workaround_method and has_hookfunction and has_hookmetamethod and has_getmetatable then
    print("Advanced exploit detected, using bypass method.")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/ParadiseRPScript/refs/heads/main/quick_workaround_rspy.lua"))()
    wait(0.1)
    getgenv().advanced_workaround_method = true
elseif not (has_hookfunction or has_hookmetamethod or has_getmetatable or has_setmetatable) then
    warn("No advanced level exploit detected, skipping..")
    wait(0.1)
    getgenv().advanced_workaround_method = true
elseif getgenv().advanced_workaround_method == true then
    warn("Advanced level exploit already reviewed and secured.")
    wait(0.1)
end
wait(0.5)
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
-- and they are called down here.
LocalPlayer_loaded()
render_safe()

Rayfield = load_rayfield()

if typeof(Rayfield) == "table" and Rayfield.CreateWindow then
    Window = Rayfield:CreateWindow({
        Name = "🏠 Life Together RP 🏠 | 1.2.1-LIFE | "..tostring(executor_Name),
        LoadingTitle = "Welcome, "..tostring(game.Players.LocalPlayer),
        LoadingSubtitle = "LifeTogether | Hub.",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "LifeTogether-Config",
            FileName = "Life_Together_ScriptHub"
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
wait(1)
if executor_Name == "Xeno" or executor_Name == "Solara" then
    return getgenv().notify("FAILURE:", "Xeno/Solara cannot run this script!", 10)
end
if string.find(executor_Name, "JJSploit") then
    return getgenv().notify("FAILURE:", "JJSploit cannot run this script!", 10)
end
task.wait(1)
-- tab and section content section.
local Tab1 = Window:CreateTab("🏡 Main 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Main 🏡 |")
local Tab2 = Window:CreateTab("🧍 Player 🧍", 0)
local Section2 = Tab2:CreateSection("| 🧍 Player/Character Content 🧍 |")
local Tab3 = Window:CreateTab("⭐ Extras ⭐", 0)
local Section3 = Tab3:CreateSection("| ⭐ Extra Content ⭐ |")
local Tab4 = Window:CreateTab("🏎️ Vehicle 🏎️", 0)
local Section4 = Tab4:CreateSection("| 🏎️ Vehicle Content 🏎️ |")
local Tab5 = Window:CreateTab("📱 Phone 📱", 0)
local Section4 = Tab5:CreateSection("| 📱 Phone Section 📱 |")

local Modules = ReplicatedStorage:FindFirstChild("Modules")
local Core = Modules:FindFirstChild("Core")
local Game = Modules:FindFirstChild("Game")
local Phone = require(Game:FindFirstChild("Phone"))
local Network = require(Core:FindFirstChild("Net"))
wait(0.3)
function send_function(arg1, arg2, arg3)
    if arg1 and arg2 and arg3 then
        Network.get(arg1, arg2, arg3)
    elseif arg1 and arg2 then
        Network.get(arg1, arg2)
    elseif arg1 then
        Network.get(arg1)
    end
end

function send_remote(arg1, arg2, arg3)
    if arg1 and arg2 and arg3 then
        Network.send(arg1, arg2, arg3)
    elseif arg1 and arg2 then
        Network.send(arg1, arg2)
    elseif arg1 then
        Network.send(arg1)
    end
end
wait(0.2)
function sit_in_vehicle(Vehicle)
    if not Vehicle then return getgenv().notify("Failure:", "You do not have a Vehicle! spawn one.", 5) end

    send_function("sit", Vehicle)
    wait(0.1)
    if Vehicle:FindFirstChild("VehicleSeat") then
        Vehicle:FindFirstChild("VehicleSeat"):Sit(getgenv().Humanoid)
    else
        return getgenv().notify("Failure:", "Unable to sit in Vehicle, missing VehicleSeat!", 5)
    end
end

function spawn_any_vehicle(Vehicle)
    send_function("spawn_vehicle", Vehicle)
end

local function get_vehicle()
    for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
        if v.owner.Value == getgenv().LocalPlayer then
            return v
        end
    end

    return nil
end

-- This isn't FE, and I'm not sure if I can even make it FE.
--[[local InvisibleMode

function FE_InvisGamePass(Boolean)
   getgenv().LocalPlayer_Invisible = Boolean

   if Boolean == true then
      for _, v in ipairs(getgc(true)) do
         if typeof(v) == "table" and rawget(v, "enabled") and rawget(v, "loaded") then
            InvisibleMode = v
            break
         end
      end

      if InvisibleMode then
         if typeof(InvisibleMode.loaded) == "function" then
            pcall(InvisibleMode.loaded)
            task.wait(0.2)
         end

         if typeof(InvisibleMode.enabled) == "table" and typeof(InvisibleMode.enabled.set) == "function" then
            InvisibleMode.enabled.set(true)
         end
      end
      task.wait()
      Boolean = true
   elseif Boolean == false then
      for _, v in ipairs(getgc(true)) do
         if typeof(v) == "table" and rawget(v, "enabled") and rawget(v, "loaded") then
            InvisibleMode = v
            break
         end
      end

      if InvisibleMode and typeof(InvisibleMode.enabled) == "table" and typeof(InvisibleMode.enabled.set) == "function" then
         InvisibleMode.enabled.set(false)
      end
      task.wait()
      Boolean = false
   else
      return 
   end
end--]]

function lock_vehicle(Vehicle)
   send_function("lock_vehicle", Vehicle)
end

function change_vehicle_color(Color, Vehicle)
   send_remote("vehicle_color", Color, Vehicle)
end

function change_RP_Name(New_Name)
   send_remote("roleplay_name", tostring(New_Name))
end

function change_bio(New_Bio)
    send_remote("bio", tostring(New_Bio))
end

function vehicle_tp(Vehicle, Character)
    if not Vehicle then return getgenv().notify("Failure:", "No vehicle found!", 5) end

    if Vehicle then
        Vehicle:PivotTo(Character:GetPivot())
    end
end

function set_lifesnap_snap_text(New_Text)
    send_function("filter_snapblox_textbox", tostring(New_Text))
end

function set_lifesnap_snap_time(Time)
    if Time == "inf" then
        send_remote("set_snapblox_time", -1 or 9e9)
    else
        send_remote("set_snapblox_time", tonumber(Time))
    end
end

function change_phone_wallpaper(Wallpaper_Number)
    send_function("set_wallpaper", tonumber(Wallpaper_Number))
end

function loop_change_wallpaper_phone(Boolean)
    getgenv().loop_change_phone_wallpaper = Boolean

    if Boolean == true then
        while getgenv().loop_change_phone_wallpaper == true do
        wait()
            change_phone_wallpaper(1)
            task.wait()
            change_phone_wallpaper(2)
            task.wait()
            change_phone_wallpaper(3)
            task.wait()
            change_phone_wallpaper(4)
            task.wait()
            change_phone_wallpaper(5)
            task.wait()
            change_phone_wallpaper(6)
            task.wait()
            change_phone_wallpaper(7)
            task.wait()
            change_phone_wallpaper(8)
            task.wait()
            change_phone_wallpaper(9)
        end
    elseif Boolean == false then
        Boolean = false
        getgenv().loop_change_phone_wallpaper = false
    end
end

function change_phone_color(New_Color)
    send_remote("phone_color", New_Color)
end

function get_tool(Tool_Name)
    send_remote("get_tool", tostring(Tool_Name))
end

function remove_tools()
    send_remote("delete_tool")
end

function RGB_Phone(Boolean)
    getgenv().RGB_Rainbow_Phone = Boolean

    local colors = {
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(128, 128, 128),
        Color3.fromRGB(0, 0, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(255, 165, 0),
        Color3.fromRGB(139, 69, 19),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(50, 205, 50),
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 155, 172),
        Color3.fromRGB(128, 0, 128),
    }

    if Boolean == true then
        while getgenv().RGB_Rainbow_Phone == true do
        wait(0.3)
            for _, color in ipairs(colors) do
                if getgenv().RGB_Rainbow_Phone ~= true then return end
                wait(0.2)
                change_phone_color(color)
            end
        end
    elseif Boolean == false then
        Boolean = false
        getgenv().RGB_Rainbow_Phone = false
        wait(0.3)
        change_phone_color(Color3.fromRGB(255, 255, 255))
    end
end

function set_call_notifications(Boolean)
    if Boolean == true then
        send_remote("notification_setting", "PhoneApp", true)
    elseif Boolean == false then
        send_remote("notification_setting", "PhoneApp", false)
    else
        return 
    end
end

function flashlight(Toggle)
    getgenv().Flashlight_Enabled = Toggle

    if Toggle == true then
        send_remote("flashlight", true)
        getgenv().Flashlight_Enabled = true
    elseif Toggle == false then
        send_remote("flashlight", false)
        getgenv().Flashlight_Enabled = false
    else
        return
    end
end

function Toggle_Phone(Boolean)
    if Boolean == true then
        Phone.holding.set(true)
    elseif Boolean == false then
        Phone.holding.set(false)
    else
        return 
    end
end

function server_admin_tp(Player)
    send_remote("server_admin_teleport_to_player", Player)
end

function show_notification(Title, Text, Method, Image)
    if Method == "Normal" and not Image then
        Phone.show_notification(tostring(Title), tostring(Text))
    elseif Method == "Warning" then
        Phone.show_notification(
            tostring(Title),
            tostring(Text),
            nil,
            "rbxassetid://13828984843"
        )
    end
end

local Workspace = cloneref(game:GetService("Workspace"))
local vehicles_folder = Workspace:WaitForChild("Vehicles")
local run_service = cloneref(game:GetService("RunService"))

getgenv().rainbow_highlight_mode = false
local default_fill_color = Color3.fromRGB(75, 94, 60)
local default_outline_color = Color3.fromRGB(255, 255, 255)

local vehicle_ESP_Connection = {}

local function apply_highlight(vehicle)
    local highlight = vehicle:FindFirstChildOfClass("Highlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "VehicleESP"
        highlight.Parent = vehicle
    end
    highlight.FillTransparency = 0.4
    highlight.OutlineTransparency = 0
    highlight.FillColor = default_fill_color
    highlight.OutlineColor = default_outline_color
end

local function clear_all_highlights()
    for _, vehicle in ipairs(vehicles_folder:GetChildren()) do
        local hl = vehicle:FindFirstChildOfClass("Highlight")
        if hl then
            hl:Destroy()
        end
    end
end

local function start_vehicle_esp()
    for _, vehicle in ipairs(vehicles_folder:GetChildren()) do
        if vehicle:IsA("Model") then
            apply_highlight(vehicle)
        end
    end

    vehicle_ESP_Connection.added = vehicles_folder.ChildAdded:Connect(function(child)
        if child:IsA("Model") then
            task.wait(0.1)
            apply_highlight(child)
        end
    end)

    vehicle_ESP_Connection.removed = vehicles_folder.ChildRemoved:Connect(function(child)
        local hl = child:FindFirstChildOfClass("Highlight")
        if hl then
            hl:Destroy()
        end
    end)

    vehicle_ESP_Connection.rainbow = task.spawn(function()
        while true do
            if not vehicle_ESP_Connection then break end
            local t = tick()
            local hue = (t % 5) / 5
            local rainbow = Color3.fromHSV(hue, 1, 1)
            if getgenv().rainbow_highlight_mode then
                for _, vehicle in ipairs(vehicles_folder:GetChildren()) do
                    local hl = vehicle:FindFirstChildOfClass("Highlight")
                    if hl then
                        hl.FillColor = rainbow
                    end
                end
            end
            task.wait(0.03)
        end
    end)
end
wait(0.2)
local function stop_vehicle_esp()
    if not vehicle_ESP_Connection then return end
    for _, conn in pairs(vehicle_ESP_Connection) do
        if typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        elseif typeof(conn) == "thread" then
            vehicle_ESP_Connection = {}
            clear_all_highlights()
        end
    end
    wait(0.1)
    vehicle_ESP_Connection = nil
    clear_all_highlights()
end

function highlight_all_cars(Toggle)
    if Toggle == true then
        start_vehicle_esp()
    elseif Toggle == false then
        stop_vehicle_esp()
    else
        return 
    end
end

function toggle_siren_sound(Boolean, Vehicle)
    for _, v in pairs(getgenv().Workspace.Vehicles:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("owner").Value == game.Players.LocalPlayer then
            Vehicle = v
        end
    end
    wait(0.2)
    if not Vehicle then return getgenv().notify("Failure:", "Please spawn a vehicle before using this!") end

    if Boolean == true then
        for _, v in pairs(getgenv().Workspace.Vehicles:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("owner").Value == game.Players.LocalPlayer then
                Vehicle = v
            end
        end
        wait(0.2)
        if not Vehicle then return getgenv().notify("Failure:", "Please spawn a vehicle before using this!") end
        wait(0.1)
        Vehicle:FindFirstChild("VehicleSeat"):FindFirstChild("Siren").Volume = 1
    elseif Boolean == false then
        for _, v in pairs(getgenv().Workspace.Vehicles:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("owner").Value == game.Players.LocalPlayer then
                Vehicle = v
            end
        end
        wait(0.2)
        if not Vehicle then return getgenv().notify("Failure:", "Please spawn a vehicle before using this!") end
        wait(0.1)
        Vehicle:FindFirstChild("VehicleSeat"):FindFirstChild("Siren").Volume = 0
    else
        return 
    end
end

function toggle_walk(Boolean)
    getgenv().walking_control = Boolean

    if Boolean == true then
        send_remote("walk_option_enabled", true)
        send_remote("toggle_walk")
        getgenv().walking_control = true
    elseif Boolean == false then
        send_remote("walk_option_enabled", false)
        send_remote("remove_sprint_multiplier")
        send_remote("toggle_walk")
        getgenv().walking_control = false
    else
        return 
    end
end

function create_kill_part()
    if getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)") then return end
    task.wait(0.1)
    local Kill_Model_Script = Instance.new("Model")
    Kill_Model_Script.Name = "Kill_Model_Script(KEEP)"
    Kill_Model_Script.Parent = getgenv().Workspace
    task.wait(0.1)
    local Kill_Part = Instance.new("Part")
    Kill_Part.Name = "SCRIPT_KILLPART_VOID"
    Kill_Part.Anchored = true
    Kill_Part.CanCollide = false
    Kill_Part.Size = Vector3.new(10, 10, 10)
    Kill_Part.CFrame = CFrame.new(0, -470, 0)
    Kill_Part.Parent = Kill_Model_Script
end

function create_void_part()
    if getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)") then return end
    task.wait(0.1)
    local Kill_Model_Script = Instance.new("Model")
    Kill_Model_Script.Name = "Void_Model_Script(KEEP)"
    Kill_Model_Script.Parent = getgenv().Workspace
    task.wait(0.1)
    local Kill_Part = Instance.new("Part")
    Kill_Part.Name = "SCRIPT_VOIDPART_VOID"
    Kill_Part.Anchored = true
    Kill_Part.CanCollide = false
    Kill_Part.Size = Vector3.new(10, 10, 10)
    Kill_Part.CFrame = CFrame.new(9e9, 9e9, 9e9)
    Kill_Part.Parent = Kill_Model_Script
end

if not getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)") then
    create_kill_part()
end
if not getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)") then
    create_void_part()
end

function vehicle_kill_player(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    local targetChar = TargetPlayer.Character
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end

    local Old_CF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

    local voidPart = getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)")
    if not voidPart then create_kill_part() voidPart = getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)") end
    local voidCF = voidPart:FindFirstChild("SCRIPT_KILLPART_VOID") and voidPart:FindFirstChild("SCRIPT_KILLPART_VOID").CFrame
    if not voidCF then return end

    local MyPlayer = game.Players.LocalPlayer
    local MyChar = getgenv().Character or MyPlayer.Character
    local MyHumanoid = getgenv().Humanoid or MyChar:FindFirstChildWhichIsA("Humanoid")
    local MyBus = nil

    for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == MyPlayer then
            if v:FindFirstChild("VehicleSeat") then
                MyBus = v
                break
            end
        end
    end

    if not MyBus then return warn("No owned SchoolBus found") end
    local seat = MyBus:FindFirstChild("VehicleSeat")
    if seat and MyHumanoid then
        MyChar:PivotTo(seat.CFrame)
        task.wait(0.2)
        seat:Sit(MyHumanoid)
    end

    local maxTries = 30
    for i = 1, maxTries do
        local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
        local isSitting = targetHumanoid and targetHumanoid.Sit
        if isSitting then break end

        MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.3, 0))
        task.wait(0.2)
    end
    wait(0.1)
    MyBus:PivotTo(voidCF)
    wait(0.4)
    local myHRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
    if getgenv().Humanoid.Sit then
        getgenv().Humanoid:ChangeState(3)
        wait(0.1)
        myHRP.CFrame = Old_CF
        wait(0.5)
        spawn_any_vehicle("Chiron")
    end
    if myHRP then
        myHRP.CFrame = Old_CF
        wait(0.5)
        spawn_any_vehicle("Chiron")
    end
end

function vehicle_bring_player(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    local targetChar = TargetPlayer.Character
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end

    local Old_CF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

    local voidPart = getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)")
    if not voidPart then create_kill_part() voidPart = getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)") end
    local voidCF = voidPart:FindFirstChild("SCRIPT_KILLPART_VOID") and voidPart:FindFirstChild("SCRIPT_KILLPART_VOID").CFrame
    if not voidCF then return end

    local MyPlayer = game.Players.LocalPlayer
    local MyChar = getgenv().Character or MyPlayer.Character
    local MyHumanoid = getgenv().Humanoid or MyChar:FindFirstChildWhichIsA("Humanoid")
    local MyBus = nil

    for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == MyPlayer then
            if v:FindFirstChild("VehicleSeat") then
                MyBus = v
                break
            end
        end
    end

    if not MyBus then return warn("No owned SchoolBus found") end
    local seat = MyBus:FindFirstChild("VehicleSeat")
    if seat and MyHumanoid then
        MyChar:PivotTo(seat.CFrame)
        task.wait(0.2)
        seat:Sit(MyHumanoid)
    end

    local maxTries = 30
    for i = 1, maxTries do
        local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
        local isSitting = targetHumanoid and targetHumanoid.Sit
        if isSitting then break end

        MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.3, 0))
        task.wait(0.2)
    end
    wait(0.1)
    MyBus:PivotTo(Old_CF)
    wait(0.4)
    local myHRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
    if getgenv().Humanoid.Sit then
        getgenv().Humanoid:ChangeState(3)
        wait(0.1)
        myHRP.CFrame = Old_CF
        wait(0.5)
        spawn_any_vehicle("Chiron")
    end
    if myHRP then
        myHRP.CFrame = Old_CF
        wait(0.5)
        spawn_any_vehicle("Chiron")
    end
end

function vehicle_void_player(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    local targetChar = TargetPlayer.Character
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end

    local Old_CF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

    local voidPart = getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)")
    if not voidPart then create_kill_part() voidPart = getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)") end
    local voidCF = voidPart:FindFirstChild("SCRIPT_VOIDPART_VOID") and voidPart:FindFirstChild("SCRIPT_VOIDPART_VOID").CFrame
    if not voidCF then return end

    local MyPlayer = game.Players.LocalPlayer
    local MyChar = getgenv().Character or MyPlayer.Character
    local MyHumanoid = getgenv().Humanoid or MyChar:FindFirstChildWhichIsA("Humanoid")
    local MyBus = nil

    for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == MyPlayer then
            if v:FindFirstChild("VehicleSeat") then
                MyBus = v
                break
            end
        end
    end

    if not MyBus then return warn("No owned SchoolBus found") end
    local seat = MyBus:FindFirstChild("VehicleSeat")
    if seat and MyHumanoid then
        MyChar:PivotTo(seat.CFrame)
        task.wait(0.2)
        seat:Sit(MyHumanoid)
    end

    local maxTries = 50
    for i = 1, maxTries do
        local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
        local isSitting = targetHumanoid and targetHumanoid.Sit
        if isSitting then break end

        MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.3, 0))
        task.wait(0.2)
    end
    wait(0.1)
    MyBus:PivotTo(voidCF)
    wait(0.4)
    local myHRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
    if getgenv().Humanoid.Sit then
        getgenv().Humanoid:ChangeState(3)
        wait(0.1)
        myHRP.CFrame = Old_CF
        wait(0.5)
        spawn_any_vehicle("Chiron")
    end
    if myHRP then
        myHRP.CFrame = Old_CF
        wait(0.5)
        spawn_any_vehicle("Chiron")
    end
end

function RGB_Vehicle(Boolean)
   getgenv().Rainbow_Vehicle = Boolean

    local colors = {
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(128, 128, 128),
        Color3.fromRGB(0, 0, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(255, 165, 0),
        Color3.fromRGB(139, 69, 19),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(50, 205, 50),
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 155, 172),
        Color3.fromRGB(128, 0, 128),
    }

    if Boolean == true then
        while getgenv().Rainbow_Vehicle == true do
            wait(0.3)
            for _, color in ipairs(colors) do
                wait(0.2)
                if getgenv().Rainbow_Vehicle ~= true then return end
                change_vehicle_color(color, get_vehicle())
            end
        end
    elseif Boolean == false then
        getgenv().Rainbow_Vehicle = false
        Boolean = false
    end
end

getgenv().spawn_vehicle = Tab4:CreateDropdown({
Name = "Spawn Vehicle (FE)",
Options = {"Magic Carpet", "EClass", "TowTruck", "Bicycle", "Fiat500", "Cayenne", "Jetski", "LuggageScooter", "MiniCooper", "GarbageTruck", "EScooter", "Monster Truck", "Yacht", "Stingray", "FireTruck", "VespaPizza", "VespaPolice", "F150", "Police SUV", "Chiron", "Humvee", "Wrangler", "Box Van", "Ambulance", "Urus", "Tesla", "Cybertruck", "RollsRoyce", "GClass", "SVJ", "MX5", "SF90", "Charger SRT", "Evoque", "IceCream Truck", "Vespa", "ATV", "Limo", "Tank", "Smart Car", "Beauford", "SchoolBus", "Sprinter", "GolfKart", "TrackHawk", "Helicopter", "SnowPlow", "Camper Van"},
CurrentOption = "",
MultipleOptions = false,
Flag = "vehicle_slot_select",
Callback = function(vehicle_selected)
    local vehicle = typeof(vehicle_selected) == "table" and vehicle_selected[1] or vehicle_selected
    spawn_any_vehicle(vehicle)
end,})

getgenv().Rainbow_Vehicle_Toggle = Tab4:CreateToggle({
Name = "Rainbow Vehicle (FE)",
CurrentValue = false,
Flag = "RainbowCarToggle",
Callback = function(is_car_rainbow)
    if is_car_rainbow then
        RGB_Vehicle(true)
    else
        RGB_Vehicle(false)
    end
end,})

getgenv().RGBPhone_FEToggle = Tab5:CreateToggle({
Name = "Rainbow Phone (FE)",
CurrentValue = false,
Flag = "ToggleRainbowPhone",
Callback = function(rgb_phone_set)
    if rgb_phone_set then
        RGB_Phone(true)
    else
        RGB_Phone(false)
    end
end,})

getgenv().ToggleWalking_InGame = Tab2:CreateToggle({
Name = "Toggle Walk (FE)",
CurrentValue = false,
Flag = "WalkingToggle",
Callback = function(walking_state)
    if walking_state then
        toggle_walk(true)
    else
        toggle_walk(false)
    end
end,})

getgenv().FlashWallpapers = Tab5:CreateToggle({
Name = "Loop Change Wallpapers (FE)",
CurrentValue = false,
Flag = "AllWallpapersToggle",
Callback = function(all_wallpapers)
    if all_wallpapers then
        loop_change_wallpaper_phone(true)
    else
        loop_change_wallpaper_phone(false)
    end
end,})

getgenv().TogglePhoneFE = Tab5:CreateToggle({
Name = "Toggle Phone (FE)",
CurrentValue = false,
Flag = "TogglePhoneScript",
Callback = function(toggle_phone_script)
    if toggle_phone_script then
        Toggle_Phone(true)
    else
        Toggle_Phone(false)
    end
end,})

getgenv().PhoneFlashlightToggle = Tab5:CreateToggle({
Name = "Phone Flashlight (FE)",
CurrentValue = false,
Flag = "PhoneFlashlightToggle",
Callback = function(flashlight_phone)
    if flashlight_phone then
        flashlight(true)
    else
        flashlight(false)
    end
end,})

getgenv().HD_FlyEnabled = false
local FlyConnection
local speed = 100

function DisableFlyScript()
    getgenv().HD_FlyEnabled = false

    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end

    local hrp = getgenv().getRoot(getgenv().Character)
    if hrp:FindFirstChild("ExecutorFlyGyro") then
        hrp.ExecutorFlyGyro:Destroy()
    end
    if hrp:FindFirstChild("ExecutorFlyPosition") then
        hrp.ExecutorFlyPosition:Destroy()
    end

    if getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
    end
end

getgenv().HDAdminFly_Speed = Tab2:CreateSlider({
Name = "HD Admin Fly Speed",
Range = {75, 300},
Increment = 1,
Suffix = "",
CurrentValue = 50,
Flag = "EditFlySpeedHDAdmin",
Callback = function(HDAdminFlySpeed_Edit)
    speed = tonumber(HDAdminFlySpeed_Edit)
end,})
wait(0.1)
getgenv().HDAdminFly = Tab2:CreateToggle({
Name = "HD Admin Fly (FE!)",
CurrentValue = false,
Flag = "FlyHDAdmin",
Callback = function(toggle_hd_fly)
    if toggle_hd_fly then
        getgenv().notify("Note:", "E = Fly Up | Q = Fly Down.", 10)
        getgenv().HD_FlyEnabled = true
        getgenv().HD_FlySpeed = tonumber(speed)
        speed = getgenv().HD_FlySpeed

        local Players = getgenv().Players
        local RunService = getgenv().RunService
        local UserInputService = getgenv().UserInputService
        local Workspace = getgenv().Workspace

        local LocalPlayer = getgenv().LocalPlayer
        repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        local Character = getgenv().Character
        local HRP = getgenv().getRoot(getgenv().Character)
        local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        local Camera = getgenv().Camera

        local KeysDown = {
            W = false,
            A = false,
            S = false,
            D = false,
            E = false,
            Q = false,
        }

        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            local key = input.KeyCode
            if KeysDown[key.Name] ~= nil then
                KeysDown[key.Name] = true
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            local key = input.KeyCode
            if KeysDown[key.Name] ~= nil then
                KeysDown[key.Name] = false
            end
        end)

        local function GetInputDirection(cam)
            local dir = Vector3.zero
            if KeysDown.W then dir += cam.CFrame.LookVector end
            if KeysDown.S then dir -= cam.CFrame.LookVector end
            if KeysDown.D then dir += cam.CFrame.RightVector end
            if KeysDown.A then dir -= cam.CFrame.RightVector end
            if KeysDown.E then dir += cam.CFrame.UpVector end
            if KeysDown.Q then dir -= cam.CFrame.UpVector end
            return dir.Magnitude > 0 and dir.Unit or Vector3.zero
        end

        local function ToggleFly()
            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            bodyGyro.P = 4000
            bodyGyro.D = 150
            bodyGyro.CFrame = HRP.CFrame
            bodyGyro.Name = "ExecutorFlyGyro"
            bodyGyro.Parent = HRP

            local bodyPos = Instance.new("BodyPosition")
            bodyPos.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bodyPos.P = 7500
            bodyPos.D = 1000
            bodyPos.Position = HRP.Position
            bodyPos.Name = "ExecutorFlyPosition"
            bodyPos.Parent = HRP

            Humanoid.PlatformStand = true

            FlyConnection = RunService.Heartbeat:Connect(function(dt)
                if not getgenv().HD_FlyEnabled then
                    bodyGyro:Destroy()
                    bodyPos:Destroy()
                    Humanoid.PlatformStand = false
                    FlyConnection:Disconnect()
                    return
                end

                local direction = GetInputDirection(Camera)
                local move = direction * getgenv().HD_FlySpeed * dt

                bodyPos.Position += move
                bodyGyro.CFrame = CFrame.new(HRP.Position, HRP.Position + Camera.CFrame.LookVector)
            end)
        end

        ToggleFly()
    else
        DisableFlyScript()
    end
end,})

getgenv().BlockAllCallNotifications = Tab5:CreateToggle({
Name = "Block All Call Notifications (FE)",
CurrentValue = false,
Flag = "BlockAllIncomingCallsNotifs",
Callback = function(block_all_call_notifs)
    if block_all_call_notifs then
        set_call_notifications(true)
    else
        set_call_notifications(false)
    end
end,})

getgenv().ChangePhoneColor = Tab5:CreateColorPicker({
Name = "Change Phone Color (FE)",
Color = Color3.fromRGB(0, 0, 0),
Flag = "PhoneColorPicker",
Callback = function(new_color_for_phone)
    change_phone_color(new_color_for_phone)
end,})

getgenv().LockVehicle_FE = Tab4:CreateToggle({
Name = "Lock Vehicle (FE)",
CurrentValue = false,
Flag = "LockVehicleScriptFE",
Callback = function(is_vehicle_locked)
    if is_vehicle_locked then
        lock_vehicle(get_vehicle())
    else
        lock_vehicle(get_vehicle())
    end
end,})

getgenv().changeRPName_FE = Tab2:CreateInput({
Name = "Change RP Name (FE)",
PlaceholderText = "New Name Here",
RemoveTextAfterFocusLost = true,
Callback = function(new_name_input)
    change_RP_Name(new_name_input)
end})

getgenv().ChangeRPBio_FE = Tab2:CreateInput({
Name = "Change RP Bio (FE)",
PlaceholderText = "New Bio Here",
RemoveTextAfterFocusLost = true,
Callback = function(new_bio_input)
    change_bio(new_bio_input)
end,})

getgenv().Vehicle_TP_FE = Tab4:CreateInput({
Name = "Vehicle TP (FE, Bypasses Range Limitations)",
PlaceholderText = "Player Here (can be shortened)",
RemoveTextAfterFocusLost = true,
Callback = function(vehicle_tp_user)
    local UserTo_TP_To = findplr(vehicle_tp_user)
    if not UserTo_TP_To then return show_notification("Error:", "Player not found or does not exist.", "Warning") end
    local Target_Character = UserTo_TP_To.Character or UserTo_TP_To.CharacterAdded:Wait()
    if not Target_Character then
        show_notification("Hang On:", "Player has not respawned yet.", "Normal")
        wait(0.2)
        repeat wait() until UserTo_TP_To.Character and UserTo_TP_To.Character:FindFirstChild("Humanoid")
    end

    vehicle_tp(get_vehicle(), Target_Character)
end,})

getgenv().SitIn_Vehicle_FE = Tab4:CreateButton({
Name = "Sit In Vehicle",
Callback = function()
    local My_Vehicle = get_vehicle()
    if not My_Vehicle then return show_notification("Error:", "No car, spawn one!", "Warning") end

    sit_in_vehicle(My_Vehicle)
end,})

getgenv().server_admin_teleport = Tab2:CreateInput({
Name = "Server Admin TP (Broken)",
PlaceholderText = "User Here, can he shortened",
RemoveTextAfterFocusLost = true,
Callback = function(player_to_tp_to)
    local Target_Plr = findplr(player_to_tp_to)
    if not Target_Plr then return show_notification("Error:", "Player does not exist!", "Warning") end
    
    server_admin_tp(Target_Plr)
end,})

getgenv().Unrestrict_All_Tools = Tab3:CreateButton({
Name = "Unrestrict All Tools (FE, Take them through airport security)",
Callback = function()
    remove_tools()
    wait(0.2)
    for _, v in ipairs(ReplicatedStorage:FindFirstChild("ToolInformation"):GetDescendants()) do
        if v:IsA("Tool") and v:GetAttribute("IsAirportRestricted") == true then
            v:SetAttribute("IsAirportRestricted", false)
        end
    end
    wait(0.2)
    local Map = getgenv().Workspace:FindFirstChild("Map")
    local Airport = Map:FindFirstChild("Airport")
    if not Airport:FindFirstChild("Main") then return end
    local Main = Airport:FindFirstChild("Main")
    if not Main:FindFirstChild("AirportInterior") then return end
    local AirportInterior = Main:FindFirstChild("AirportInterior")
    if not AirportInterior:FindFirstChild("Other") then return end
    local Other = AirportInterior:FindFirstChild("Other")
    if not Other:FindFirstChild("MetalDetector") then return end
    local MetalDetector = Other:FindFirstChild("MetalDetector")
    if not MetalDetector:FindFirstChild("RemoveRadius") then return end
    local RemoveRadius_Part = MetalDetector:FindFirstChild("RemoveRadius")
    if not RemoveRadius_Part:FindFirstChildOfClass("TouchTransmitter") then return end
    if RemoveRadius_Part:FindFirstChildWhichIsA("TouchTransmitter") then
        RemoveRadius_Part:FindFirstChildOfClass("TouchTransmitter"):Destroy()
    end
end,})

getgenv().VehicleVoid = Tab3:CreateInput({
Name = "Vehicle Void Player (FE)",
PlaceholderText = "User Here, can be shortened",
RemoveTextAfterFocusLost = true,
Callback = function(user_to_void)
    local target = findplr(user_to_void)
    if not target then return getgenv().notify("Failure:", "User does not seem to exist.", 5) end

    if target and target.Character then
        spawn_any_vehicle("SchoolBus")
        wait(1)
        vehicle_void_player(target)
    elseif target == getgenv().LocalPlayer or target == getgenv().LocalPlayer.Name then
        return getgenv().notify("Failure:", "You cannot void yourself (wtf).", 5)
    end
end,})

getgenv().VehicleBring = Tab1:CreateInput({
Name = "Vehicle Bring Player (FE)",
PlaceholderText = "User Here, can be shortened",
RemoveTextAfterFocusLost = true,
Callback = function(user_to_bring)
    local target = findplr(user_to_bring)
    if not target then return getgenv().notify("Failure:", "User does not seem to exist.", 5) end

    if target and target.Character then
        spawn_any_vehicle("SchoolBus")
        wait(1)
        vehicle_bring_player(target)
    elseif target == getgenv().LocalPlayer or target == getgenv().LocalPlayer.Name then
        return getgenv().notify("Failure:", "You cannot void yourself (wtf).", 5)
    end
end,})

getgenv().VehicleKill = Tab3:CreateInput({
Name = "Vehicle Kill Player (FE)",
PlaceholderText = "User Here, can be shortened",
RemoveTextAfterFocusLost = true,
Callback = function(user_to_kill)
    local target = findplr(user_to_kill)
    if not target then return getgenv().notify("Failure:", "User does not seem to exist.", 5) end

    if target and target.Character then
        spawn_any_vehicle("SchoolBus")
        wait(1)
        vehicle_kill_player(target)
    elseif target == getgenv().LocalPlayer or target == getgenv().LocalPlayer.Name then
        return getgenv().notify("Failure:", "You cannot kill yourself (wtf).", 5)
    end
end,})

getgenv().GetJetpack_Free_FE = Tab3:CreateButton({
Name = "Give Jetpack (FE, Free)",
Callback = function()
    get_tool("Jetpack")
end,})

getgenv().GetRocketLauncher = Tab3:CreateButton({
Name = "Give RocketLauncher (FE, Free)",
Callback = function()
    get_tool("RocketLauncher")
end,})

getgenv().VehicleHighlightESP = Tab3:CreateToggle({
Name = "Vehicle Highlight ESP",
CurrentValue = false,
Flag = "HighlightAllVehiclesESP",
Callback = function(highlight_ESP)
    if highlight_ESP then
        highlight_all_cars(true)
    else
        highlight_all_cars(false)
    end
end,})

getgenv().RainbowModeHighlight_ESP = Tab3:CreateToggle({
Name = "Rainbow Highlight (for Vehicle ESP)",
CurrentValue = false,
Flag = "RainbowRGBHighlights",
Callback = function(rgb_highlight_toggle)
    if rgb_highlight_toggle then
        getgenv().rainbow_highlight_mode = true
    else
        getgenv().rainbow_highlight_mode = false
    end
end,})

local Tool_Folder = getgenv().ReplicatedStorage:FindFirstChild("ToolInformation")

local tool_name_map = {}
local tool_options = {}

if Tool_Folder then
    for _, tool in ipairs(Tool_Folder:GetChildren()) do
        if tool:IsA("Tool") then
            tool_name_map[tool.Name] = tool
            table.insert(tool_options, tool.Name)
        end
    end
end

getgenv().GiveAnyToolAllTools = Tab3:CreateDropdown({
Name = "Tool Giver (FE)",
Options = tool_options,
CurrentOption = "",
MultipleOptions = false,
Flag = "tool_slot_select",
Callback = function(tool_name)
    if typeof(tool_name) == "table" then
        tool_name = tool_name[1]
    end

    if typeof(tool_name) ~= "string" then
        return warn("Invalid tool selection: Expected string, got:", typeof(tool_name))
    end

    local tool_instance = tool_name_map[tool_name]
    if not tool_instance then
        return warn("Tool not found:", tool_name)
    end

    local success, err = pcall(function()
        get_tool(tool_instance)
    end)

    if success then
        getgenv().notify("Success:", "Gave tool: '" .. tool_name .. "'", 5)
    else
        getgenv().notify("Error:", "Tool give failed: " .. tostring(err), 5)
    end
end,})

getgenv().RainbowSkin_FEScript = Tab2:CreateToggle({
Name = "Rainbow Skin (FE, Broken)",
CurrentValue = false,
Flag = "RainbowSkinScript_FE",
Callback = function(rgb_skintone)
    if rgb_skintone then
        getgenv().RainbowSkin_FE = true
        while getgenv().RainbowSkin == true do
        local Modules = getgenv().ReplicatedStorage:FindFirstChild("Modules")
        local Lmao = require(Modules:FindFirstChild("Core"):FindFirstChild("Net"))
        wait()
            Lmao.send("skin_tone", Color3.new(0.8500000238418579, 0.8500000238418579, 0.8500000238418579))
            wait()
            Lmao.send("skin_tone", Color3.new(0.8500000238418579, 0.3966667056083679, 0.11666665971279144))
            wait()
            Lmao.send("skin_tone", Color3.new(0.3638349175453186, 0.6686696410179138, 0.7637255787849426))
            wait()
            Lmao.send("skin_tone", Color3.new(0, 0, 0))
            wait()
            Lmao.send("skin_tone", Color3.new(0.19117647409439087, 0.13404327630996704, 0.08350235968828201))
            wait()
            Lmao.send("skin_tone", Color3.new(0.033901963382959366, 0.24215689301490784, 0.04600980877876282))
            wait()
            Lmao.send("skin_tone", Color3.new(0.12131961435079575, 0.5754902362823486, 0.07776893675327301))
            wait()
            Lmao.send("skin_tone", Color3.new(0.3794117867946625, 0.3794117867946625, 0.3794117867946625))
            wait()
            Lmao.send("skin_tone", Color3.new(0.8068628311157227, 0.6216811537742615, 0.770487904548645))
            wait()
            Lmao.send("skin_tone", Color3.new(0.05588236078619957, 0.09727669507265091, 0.16764706373214722))
            wait()
            Lmao.send("skin_tone", Color3.new(0.24702320992946625, 0.06928697973489761, 0.49705883860588074))
            wait()
            Lmao.send("skin_tone", Color3.new(0, 0, 0.6852942109107971))
            wait()
            Lmao.send("skin_tone", Color3.new(0.7166667580604553, 0.09728507697582245, 0.09728507697582245))
            wait()
            Lmao.send("skin_tone", Color3.new(0.8382353782653809, 0.8149511218070984, 0.11642158776521683))
            wait()
            Lmao.send("skin_tone", Color3.new(0.6852942109107971, 0.5726871490478516, 0.19625794887542725))
            wait()
            Lmao.send("skin_tone", Color3.new(0.7911765575408936, 0.10878676921129227, 0.47140946984291077))
        end
    else
        getgenv().RainbowSkin_FE = false
        getgenv().RainbowSkin_FE = false
    end
end,})

getgenv().MuteSiren_Sounds = Tab1:CreateToggle({
Name = "Mute Sirens On Car",
CurrentValue = false,
Flag = "MutedSirensScript",
Callback = function(muting_sirens)
    if muting_sirens then
        toggle_siren_sound(true, get_vehicle())
    else
        toggle_siren_sound(false, get_vehicle())
    end
end,})

getgenv().FECar_Bouncer_GUI = Tab1:CreateButton({
Name = "Car Bouncer GUI (FE)",
Callback = function()
    if getgenv().CarBouncer_GUI_Loaded then
        return getgenv().notify("Heads Up:", "Already loaded Car Bouncer GUI!", 5)
    end
    local Players = getgenv().Players
	local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
	local RunService = getgenv().RunService
	local GuiService = cloneref and cloneref(game:GetService("GuiService")) or game:GetService("GuiService")
	local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
	local Mouse = LocalPlayer:GetMouse()
	local Toggled = false
	local Force = 10
	local Speed = 0.5
	local CharacterAdded
	local Seated = false
	local Force2 = 108*Force
	local Speed2 = 108*Speed
	local Settings = {}
	local LastSeatPart
	local CoreGuiAccessible = pcall(function()
		CoreGui:FindFirstChild("")
	end)
	local function CreateGUI()
		local ScreenGUI = Instance.new("ScreenGui")
		local Frame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIGradient = Instance.new("UIGradient")
		local BOUNCE_Power = Instance.new("TextLabel")
		local Switch = Instance.new("ImageButton")
		local Frame2 = Instance.new("Frame")
		local JumpHeightButton = Instance.new("TextButton")
		local JumpSpeedButton = Instance.new("TextButton")
		local Frame3 = Instance.new("Frame")
		local CarHighestImage = Instance.new("ImageLabel")
		local SpeedImage = Instance.new("ImageLabel")
		local JumpHeightDown = false
		local SpeedJumpDown = false
		ScreenGUI.ResetOnSpawn = false
		ScreenGUI.IgnoreGuiInset = false
		Frame.Parent = ScreenGUI
		Frame.Size = UDim2.new(0, 540, 0, 241)
		Frame.Visible = true
		Frame.Position = UDim2.new(0.8, -270, 0.8, -120)
		Frame.BackgroundColor3 = Color3.new(1, 1, 1)
		Frame.Draggable = true
		Frame.Active = true
		UICorner.Parent = Frame
		UIGradient.Parent = Frame
		UIGradient.Enabled = true
		UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(147, 147, 147)), ColorSequenceKeypoint.new(0.0104, Color3.fromRGB(90, 90, 90)), ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 185, 185))})
		BOUNCE_Power.Parent = Frame
		BOUNCE_Power.Text = "BOUNCE"
		BOUNCE_Power.Font = Enum.Font.Arial
		BOUNCE_Power.TextColor3 = Color3.fromRGB(172, 172, 172)
		BOUNCE_Power.TextSize = 28
		BOUNCE_Power.BackgroundTransparency = 1
		BOUNCE_Power.Position = UDim2.new(0.05, 0, 0.05, 0)
		BOUNCE_Power.Size = UDim2.new(0, 100, 0, 50)
		Switch.Parent = Frame
		Switch.Rotation = 180
		Switch.Position = UDim2.new(0.025, 0, 0.3, 0)
		Switch.Size = UDim2.new(0, 108, 0, 145)
		Switch.BackgroundTransparency = 1
		Switch.Image = "rbxassetid://16053972983"
		Frame2.Parent = Frame
		Frame2.Size = UDim2.new(0, 2, 0.9, 0)
		Frame2.BorderSizePixel = 0
		Frame2.BackgroundColor3 = Color3.new(0, 0, 0)
		Frame2.Position = UDim2.new(0.8, 0, 0.05, 0)
		Frame3.Parent = Frame
		Frame3.Size = UDim2.new(0, 2, 0.9, 0)
		Frame3.BorderSizePixel = 0
		Frame3.BackgroundColor3 = Color3.new(0, 0, 0)
		Frame3.Position = UDim2.new(0.45, 0, 0.05, 0)
		JumpHeightButton.Parent = Frame
		JumpHeightButton.BorderSizePixel = 0
		JumpHeightButton.Size = UDim2.new(0.2, 0, 0.05, 0)
		JumpHeightButton.Position = UDim2.new(0.7, 0, 0.4, 12)
		JumpHeightButton.Text = ""
		JumpHeightButton.BackgroundColor3 = Color3.new(1, 1, 1)
		JumpSpeedButton.Parent = Frame
		JumpSpeedButton.BorderSizePixel = 0
		JumpSpeedButton.Size = UDim2.new(0.2, 0, 0.05, 0)
		JumpSpeedButton.Position = UDim2.new(0.35, 0, 0.4, 12)
		JumpSpeedButton.Text = ""
		JumpSpeedButton.BackgroundColor3 = Color3.new(1, 1, 1)
		CarHighestImage.Parent = Frame
		CarHighestImage.Size = UDim2.new(0, 48, 0, 48)
		CarHighestImage.Position = UDim2.new(0.7, 0, 0, 0)
		CarHighestImage.BackgroundTransparency = 1
		CarHighestImage.Image = "rbxassetid://16055947290"
		SpeedImage.Parent = Frame
		SpeedImage.Size = UDim2.new(0, 32, 0, 32)
		SpeedImage.Position = UDim2.new(0.35, 0, 0, 16)
		SpeedImage.BackgroundTransparency = 1
		SpeedImage.Image = "rbxassetid://13492318225"
		SpeedImage.ImageColor3 = Color3.new(0, 0, 0)
		JumpHeightButton.MouseButton1Down:Connect(function()
			JumpHeightDown = true
		end)
		JumpSpeedButton.MouseButton1Down:Connect(function()
			SpeedJumpDown = true
		end)
		Frame.MouseMoved:Connect(function(x, y)
			if JumpHeightDown then
				JumpHeightButton.Position = UDim2.new(0.7, 0, 0, math.clamp((y-Frame.AbsolutePosition.Y)-GuiService:GetGuiInset().Y, 50, 216))
				Settings[LastSeatPart]["Force"] = Force2/JumpHeightButton.Position.Y.Offset
				Settings[LastSeatPart]["JumpHeightY"] = JumpHeightButton.Position.Y.Offset
			end
			if SpeedJumpDown then
				JumpSpeedButton.Position = UDim2.new(0.35, 0, 0, math.clamp((y-Frame.AbsolutePosition.Y)-GuiService:GetGuiInset().Y, 50, 216))
				Settings[LastSeatPart]["Speed"] = Speed2/JumpSpeedButton.Position.Y.Offset
				Settings[LastSeatPart]["SpeedJumpY"] = JumpSpeedButton.Position.Y.Offset
			end
		end)
		JumpHeightButton.MouseButton1Up:Connect(function()
			JumpHeightDown = false
		end)
		Mouse.Button1Up:Connect(function()
			JumpHeightDown = false
			SpeedJumpDown = false
		end)
		JumpSpeedButton.MouseButton1Up:Connect(function()
			SpeedJumpDown = false
		end)
		Switch.Activated:Connect(function()
			if Switch.Rotation == 180 then
				Switch.Rotation = 0
				Settings[LastSeatPart]["Toggled"] = true
				BOUNCE_Power.TextColor3 = Color3.new(1/3, 1, 0)
			else
				Settings[LastSeatPart]["Toggled"] = false
				Switch.Rotation = 180
				BOUNCE_Power.TextColor3 = Color3.fromRGB(172, 172, 172)
			end
		end)
		return ScreenGUI, BOUNCE_Power, Switch, JumpHeightButton
	end
	local function InitalizePlayer(Player)
		LocalPlayer = Player
		local Gui, BOUNCE_Power, Switch, JumpHeightButton = CreateGUI()
		Mouse = Player:GetMouse()
		Gui.Enabled = false
		if CharacterAdded then
			CharacterAdded:Disconnect()
		end
		local function InitalizeCharacter(Character)
			local function InitalizeHumanoid(Humanoid)
				local function seated()
					local SeatPart = Humanoid.SeatPart
					if SeatPart then
						Seated = true
						if SeatPart:IsA("Seat") and not string.find(string.lower(SeatPart.Name), "drive") then
							return
						end
						for _, check in pairs(SeatPart.Parent:GetChildren()) do
							if not (check == SeatPart) then
								if Settings[check] then
									SeatPart = check
									break
								end
							end
						end
						local Setting = Settings[SeatPart]
						if not Setting then
							local NewSetting = {
								["Force"] = Force,
								["JumpHeightY"] = 108,
								["Speed"] = Speed,
								["SpeedJumpY"] = 108,
								["Toggled"] = false
							}
							Setting = NewSetting
							Settings[SeatPart] = NewSetting
							task.spawn(function()
								task.wait(0)
								local CSeatPart = SeatPart
								while true do
									if Settings[CSeatPart]["Toggled"] then
										local new = (CSeatPart.CFrame*Vector3.new(Settings[CSeatPart]["Force"], 0, 0))-CSeatPart.Position
										CSeatPart.AssemblyAngularVelocity = CSeatPart.AssemblyAngularVelocity+new
										task.wait(Settings[CSeatPart]["Speed"])
									end
									if not CSeatPart:IsDescendantOf(game) then
										Settings[CSeatPart] = nil
										break
									end
									task.wait(0)
								end
							end)
						end
						LastSeatPart = SeatPart
						if Setting["Toggled"] then
							Switch.Rotation = 0
							BOUNCE_Power.TextColor3 = Color3.new(1/3, 1, 0)
						else
							Switch.Rotation = 180
							BOUNCE_Power.TextColor3 = Color3.fromRGB(172, 172, 172)
						end
						JumpHeightButton.Position = UDim2.new(0.7, 0, 0, Setting["JumpHeightY"])
						Gui.Enabled = true
					elseif LastSeatPart then
						Seated = false
						Gui.Enabled = false
					end
				end
				seated()
				Humanoid:GetPropertyChangedSignal("SeatPart"):Connect(seated)
			end
			local function InitalizeChild(v)
				if v:IsA("Humanoid") then
					task.spawn(InitalizeHumanoid, v)
				end
			end
			for _, v in pairs(Character:GetChildren()) do
				InitalizeChild(v)
			end
			Character.ChildAdded:Connect(InitalizeChild)
		end
		local function InitalizePlayerGui(PlayerGui)
			if CoreGuiAccessible then
				Gui.Parent = CoreGui
			else
				Gui.Parent = PlayerGui
			end
		end
		local function InitalizeChildInPlayerInstance(v)
			if v:IsA("PlayerGui") then
				InitalizePlayerGui(v)
			end
		end
		if Player.Character then
			InitalizeCharacter(Player.Character)
		end
		for _, v in pairs(Player:GetChildren()) do
			InitalizeChildInPlayerInstance(v)
		end
		Player.ChildAdded:Connect(InitalizeChildInPlayerInstance)
		CharacterAdded = Player.CharacterAdded:Connect(InitalizeCharacter)
	end
	Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
		InitalizePlayer(Players.LocalPlayer)
	end)
	InitalizePlayer(LocalPlayer)
	local function InitalizeNetBypass()
		if sethiddenproperty then
			sethiddenproperty(LocalPlayer, "SimulationRadius", 100)
		else
			pcall(function()
				LocalPlayer.SimulationRadius = 100
			end)
		end
		local ReturnFakeEntityVelocity = true
		local ForceEntityVelocity = true
		RunService.Heartbeat:Connect(function()
			if ReturnFakeEntityVelocity == true then
				for seat, v in pairs(Settings) do
					if v["Toggled"] and not Seated then
						local returnfakevel = seat.AssemblyLinearVelocity
						seat.AssemblyLinearVelocity = Vector3.zero
						RunService.RenderStepped:Wait()
						seat.AssemblyLinearVelocity = returnfakevel
					end
				end
			end 
		end)
		task.wait(0.45)
		RunService.Heartbeat:Connect(function()
			if ForceEntityVelocity == true then
				for seat, v in pairs(Settings) do
					if v["Toggled"] and not Seated then
						local forcerealvel = seat.AssemblyLinearVelocity
						seat.AssemblyLinearVelocity = Vector3.new(35, 0, 0)
						RunService.RenderStepped:Wait()
						seat.AssemblyLinearVelocity = forcerealvel
					end
				end
			end
		end)
		task.wait(0.65)
		ReturnFakeEntityVelocity = false
	end
	local BindableFunction = Instance.new("BindableFunction")
	local Fired = false
	BindableFunction.OnInvoke = function(Name)
		if Name == "Yes" and not Fired then
			Fired = true
			InitalizeNetBypass()
		end
	end
	getgenv().StarterGui:SetCore("SendNotification", {
		Title = "Net Bypass",
		Text = "Do you want Net Bypass applied? One advantage is that even if you get out of your vehicle, it can still be bouncing.",
		Button1 = "Yes",
		Button2 = "No",
		Duration = 15,
		Callback = BindableFunction,
	})
end,})
