if game.PlaceId ~= 54865335 then return warn("Not the right game lil bro.") end

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
local Vehicles_LocalPlayer_Folder = LocalPlayer:FindFirstChild("Vehicles")
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Main_Folder = Workspace:FindFirstChild("_Main")
local Vehicles_Folder = Main_Folder and Main_Folder:FindFirstChild("Vehicles")
local Events = ReplicatedStorage:FindFirstChild("Events")
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local VehicleCustomizationsData = Modules:FindFirstChild("VehicleCustomizationsData")
local Vehicle_Change_RF = VehicleCustomizationsData:FindFirstChild("WriteVehicleChanges")
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
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
getgenv().HumanoidRootPart = getgenv().Character:WaitForChild("HumanoidRootPart") or getgenv().Character:FindFirstChild("HumanoidRootPart")
getgenv().Humanoid = getgenv().Character:WaitForChild("Humanoid") or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid")
getgenv().Head = getgenv().Character:WaitForChild("Head") or getgenv().Character:FindFirstChild("Head")
local Anti_Ragdoll_Active = false

wait(0.2)

local function Dynamic_Character_Updater(character)
    warn("[Ultimate_Driving_Hub]: Waiting for Character to fully load...")
    task.wait(0.2)
    getgenv().Character = character or getgenv().LocalPlayer.Character
    task.wait(0.3)
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3)
    getgenv().HumanoidRootPart = (hrp and hrp:IsA("BasePart")) and hrp

    local hum = character:FindFirstChildOfClass("Humanoid")
    getgenv().Humanoid = (hum and hum:IsA("Humanoid")) and hum

    if Anti_Ragdoll_Active or Anti_Ragdoll_Active == true then
        warn("Anti-Ragdoll Toggle is [ENABLED], removing unpermitted/unnecessary included in-game pre-requisites...")
        task.wait(.3)
        if character and character:FindFirstChild("Humanoid") then
            character:FindFirstChild("RagdollConstraints"):Destroy()
            if getgenv().LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("RagdollClient") then
                getgenv().LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("RagdollClient").Parent = getgenv().SoundService
            end
            if getgenv().StarterPlayer:FindFirstChild("StarterPlayerScripts"):FindFirstChild("RagdollClient") then
                getgenv().StarterPlayer:FindFirstChild("StarterPlayerScripts"):FindFirstChild("RagdollClient").Parent = getgenv().TweenService
            end
            if Modules:FindFirstChild("Ragdoll") then
                Modules:FindFirstChild("Ragdoll").Parent = getgenv().AssetService
            end
        end
    end

    local head = character:FindFirstChild("Head")
    getgenv().Head = (head and head:IsA("BasePart")) and head
end

Dynamic_Character_Updater(getgenv().Character)
task.wait(0.2)
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(1)
    warn("[Ultimate_Driving_Hub]: New Character being added, pre-fetching and initializing.")
    Dynamic_Character_Updater(newCharacter)
    getgenv().LocalPlayer.CharacterAdded:Wait()
    task.wait(0.5)
    getgenv().Character = newCharacter
    getgenv().HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
    getgenv().Humanoid = newCharacter:FindFirstChild("Humanoid") or newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
    getgenv().Head = newCharacter:FindFirstChild("Head") or newCharacter:WaitForChild("Head", 5)
end)
task.wait(0.2)

local carNames = {}
local HttpService = getgenv().HttpService or getgenv().Service_Wrap("HttpService")
task.wait(0.2)
function get_car_names()
    local vehicleDataValue = getgenv().LocalPlayer:FindFirstChild("Values")
        and getgenv().LocalPlayer.Values:FindFirstChild("ExtraLeaderStats")
        and getgenv().LocalPlayer.Values.ExtraLeaderStats:FindFirstChild("VehicleData")

    if not vehicleDataValue or not vehicleDataValue:IsA("StringValue") then
        return {}
    end

    local success, decoded = pcall(function()
        return HttpService:JSONDecode(vehicleDataValue.Value)
    end)

    if not success or typeof(decoded) ~= "table" then
        return {}
    end

    for carName, _ in pairs(decoded) do
        table.insert(carNames, carName)
    end

    return carNames
end

local all_vehicles = get_car_names()

if not all_vehicles or #all_vehicles == 0 then
    local args = {
        "VehiclePurchase",
        {
            "ClassicSedanDonk",
            getgenv().Workspace:WaitForChild("_Main"):WaitForChild("VehicleShops"):WaitForChild("VehicleShop"),
            true,
            false
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
end
task.wait(1)
local function spawn_vehicle(name)
    if type(name) ~= "string" then return warn(tostring(name).." is not a string!") end

    local args = {
        "VehicleSpawn",
        {
            tostring(name),
            "QuickSpawn",
            false
        }
    }
    
    getgenv().ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("RemoteFunction"):InvokeServer(unpack(args))
end

local Rayfield

local function retrieve_vehicle()
    local humanoid = getgenv().Character and getgenv().Character:FindFirstChildWhichIsA("Humanoid")
    local seatPart = humanoid and humanoid.SeatPart
    local vehicle = seatPart and seatPart.Parent

    if not vehicle then
        spawn_vehicle(randomly_selected_vehicle)
        wait(0.5)
        humanoid = getgenv().Character and getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        seatPart = humanoid and humanoid.SeatPart
        vehicle = seatPart and seatPart.Parent
        return vehicle
    else
        return vehicle
    end
end

local function Is_In_Race()
    local error_exited = false

    if executor_Name == "Solara" or executor_Name == "Xeno" or string.find(executor_Name, "JJSploit") then
        local racesOngoing = getgenv().ReplicatedStorage:FindFirstChild("ReplicatedData") and getgenv().ReplicatedStorage.ReplicatedData:FindFirstChild("RacesOngoing")
        if not racesOngoing then return false end

        for _, race in pairs(racesOngoing:GetChildren()) do
            local racers = race:FindFirstChild("ActiveRacers")
            if racers and racers:FindFirstChild(game.Players.LocalPlayer.Name) then
                return true
            end
        end
        return false
    else
        local Modules = getgenv().ReplicatedStorage:FindFirstChild("Modules")
        if not Modules then return false end

        local playerRaceModule = Modules:FindFirstChild("PlayerIsInRace")
        if not playerRaceModule then return false end

        local Player_In_Race = require(playerRaceModule)
        return Player_In_Race()
    end
end

local function get_random_vehicle()
    local every_owned_car = get_car_names()

    if #every_owned_car == 0 then
        return nil
    end

    return every_owned_car[math.random(1, #every_owned_car)]
end

local randomly_selected_vehicle = get_random_vehicle()

local Vehicle = retrieve_vehicle()
local Vehicle_Name
if not Vehicle then
    spawn_vehicle(randomly_selected_vehicle)
    Vehicle = retrieve_vehicle()
    task.wait(0.5)
    Vehicle_Name = Vehicle.Name
else
    math.randomseed(tick())
    Vehicle = Vehicle
    Vehicle_Name = Vehicle.Name
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
        Name = "✨ Ultimate Driving ✨ | 1.0.4 | "..tostring(executor_Name),
        LoadingTitle = "Welcome, "..tostring(game.Players.LocalPlayer),
        LoadingSubtitle = "Ultimate Driving | Hub.",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "UltimateDrivingHub-Config",
            FileName = "UltimateDrivingScriptHub"
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
            Note = "nice hidden dumper skid, it's useless (like you)",
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
local Tab2 = Window:CreateTab("🧍 LocalPlayer 🧍", 0)
local Section2 = Tab2:CreateSection("| 🧍 LocalPlayer 🧍 |")
local Tab3 = Window:CreateTab("⭐ Extras ⭐", 0)
local Section3 = Tab3:CreateSection("| ⭐ Extra Content ⭐ |")
local Tab4 = Window:CreateTab("🚗 Vehicle 🚗", 0)
local Section4 = Tab4:CreateSection("| 🚗 Vehicle 🚗 |")
local current_car_tint_color = Color3.new(0, 0, 0)
local current_car_tint_transparency = 1

getgenv().CarTintColor = Tab4:CreateColorPicker({
Name = "Car Tint Color",
Color = Color3.fromRGB(0, 0, 0),
Flag = "PickingCarTintColor",
Callback = function(car_tint_color)
    local current_car = retrieve_vehicle()
    if current_car then
        local args = {
            tostring(current_car.Name),
            {
                ColorTint = car_tint_color,
                TransparencyTint = current_car_tint_transparency
            }
        }

        Vehicle_Change_RF:InvokeServer(unpack(args))
    else
        return getgenv().notify("Failure:", "Please spawn a vehicle before using this.", 5)
    end
    task.wait(.5)
    current_car_tint_color = car_tint_color
end,})

getgenv().CarTintTransparency = Tab4:CreateSlider({
Name = "Car Tint Transparency",
Range = {0, 1},
Increment = 0.1,
Suffix = "",
CurrentValue = 1,
Flag = "SliderCarTintTransparency",
Callback = function(car_tint_transparency)
    local current_car = retrieve_vehicle()
    if current_car then
        local args = {
            tostring(current_car.Name),
            {
                ColorTint = Color3.fromRGB(0, 0, 0),
                TransparencyTint = tonumber(car_tint_transparency)
            }
        }

        Vehicle_Change_RF:InvokeServer(unpack(args))
    else
        return getgenv().notify("Failure:", "Please spawn a vehicle before using this.", 5)
    end
    task.wait(.5)
    current_car_tint_transparency = car_tint_transparency
end,})

if writefile and delfile and loadfile then
    getgenv().Save_Car_Config = Tab4:CreateButton({
    Name = "Save Car Config",
    Callback = function()
        local data = {
            TintColor = {
                R = current_car_tint_color.R,
                G = current_car_tint_color.G,
                B = current_car_tint_color.B
            },
            TintTransparency = current_car_tint_transparency
        }

        local json = HttpService:JSONEncode(data)
        task.wait(.3)
        writefile("car_config.json", json)
    end,})

    getgenv().Delete_Car_Config = Tab4:CreateButton({
    Name = "Delete Car Config",
    Callback = function()
        if isfile("car_tint_config.json") then
            delfile("car_tint_config.json")
        end
    end,})

    getgenv().Load_Car_Config = Tab4:CreateButton({
    Name = "Load Car Config",
    Callback = function()
        if isfile("car_tint_config.json") then
            local contents = readfile("car_tint_config.json")
            local data = HttpService:JSONDecode(contents)

            current_car_tint_color = Color3.new(data.TintColor.R, data.TintColor.G, data.TintColor.B)
            current_car_tint_transparency = data.TintTransparency
            task.wait(.3)
            local args = {
                tostring(Vehicle.Name),
                {
                    ColorTint = current_car_tint_color,
                    TransparencyTint = current_car_tint_transparency
                }
            }

            Vehicle_Change_RF:InvokeServer(unpack(args))
        end
    end,})
else
    warn("Didn't load these options, writefile/del/loadfile is unsupported.")
end

getgenv().AntiRagdoll = Tab2:CreateToggle({
Name = "Anti Ragdoll",
CurrentValue = false,
Flag = "FullAntiRagdoll",
Callback = function(anti_ragdoll)
    if anti_ragdoll then
        getgenv().Anti_Ragdoll_Enabled = true
        Anti_Ragdoll_Active = true
        task.wait(.3)
        if getgenv().Character and getgenv().Character:FindFirstChild("Humanoid") and getgenv().Humanoid then
            if getgenv().Character:FindFirstChild("RagdollConstraints") then
                getgenv().Character:FindFirstChild("RagdollConstraints"):Destroy()
            end
            if getgenv().LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("RagdollClient") then
                getgenv().LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("RagdollClient").Parent = getgenv().SoundService
            end
            if getgenv().StarterPlayer:FindFirstChild("StarterPlayerScripts"):FindFirstChild("RagdollClient") then
                getgenv().StarterPlayer:FindFirstChild("StarterPlayerScripts"):FindFirstChild("RagdollClient").Parent = getgenv().TweenService
            end
            if Modules:FindFirstChild("Ragdoll") then
                Modules:FindFirstChild("Ragdoll").Parent = getgenv().AssetService
            end
        end
    else
        getgenv().Anti_Ragdoll_Enabled = false
        getgenv().Anti_Ragdoll_Enabled = false
        Anti_Ragdoll_Active = false
        Anti_Ragdoll_Active = false
        task.wait(.3)
        if getgenv().SoundService:FindFirstChild("RagdollClient") then
            getgenv().SoundService:FindFirstChild("RagdollClient").Parent = getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
        end
        if getgenv().TweenService:FindFirstChild("RagdollClient") then
            getgenv().TweenService:FindFirstChild("RagdollClient").Parent = getgenv().StarterPlayer:FindFirstChild("StarterPlayerScripts")
        end
        if getgenv().AssetService:FindFirstChild("Ragdoll") then
            getgenv().AssetService:FindFirstChild("Ragdoll").Parent = Modules
        end
    end
end,})
wait(0.2)
if getgenv().Anti_Ragdoll_Enabled == true then
    getgenv().notify("Heads Up:", "Turned off AntiRagdoll it was enabled at runtime.", 5)
    getgenv().Anti_Ragdoll_Enabled = false
    getgenv().AntiRagdoll:Set(false)
end

getgenv().Rainbow_FE_Car = Tab4:CreateToggle({
Name = "Rainbow Car (FE)",
CurrentValue = false,
Flag = "RainbowFECarScript",
Callback = function(rainbow_car)
    if rainbow_car then
        local colors = {
            Black = {
                ColorPrimary = Color3.new(0, 0, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Teal = {
                ColorPrimary = Color3.fromRGB(0, 128, 128),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Green = {
                ColorPrimary = Color3.fromRGB(0, 255, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Blue = {
                ColorPrimary = Color3.fromRGB(0, 0, 255),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Red = {
                ColorPrimary = Color3.fromRGB(255, 0, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Yellow = {
                ColorPrimary = Color3.fromRGB(255, 255, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Orange = {
                ColorPrimary = Color3.fromRGB(255, 165, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Camo = {
                ColorPrimary = Color3.fromRGB(102, 102, 51),
                ColorSecondary = Color3.fromRGB(34, 34, 17),
                ReflectancePrimary = 0.1,
                WrapPrimary = 3
            }
        }

        getgenv().rainbow_vehicle = true
        while getgenv().rainbow_vehicle == true do
        task.wait()
            for name, preset in pairs(colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    Vehicle_Change_RF:InvokeServer(current_car.Name, preset)
                else
                    getgenv().rainbow_vehicle = false
                    getgenv().Rainbow_FE_Car:Set(false)
                    return getgenv().notify("Failure:", "Please spawn a vehicle before using this.", 5)
                end
            end
        end
    else
        getgenv().rainbow_vehicle = false
        getgenv().rainbow_vehicle = false
    end
end,})
wait(0.2)
if getgenv().rainbow_vehicle == true then
    getgenv().notify("Heads Up:", "Disabled Rainbow Car, it was enabled at runtime.", 5)
    getgenv().rainbow_vehicle = false
    getgenv().Rainbow_FE_Car:Set(false)
end

getgenv().Rainbow_Tint_FE = Tab4:CreateToggle({
Name = "Rainbow Tint (FE)",
CurrentValue = false,
Flag = "RainbowFlashingTint",
Callback = function(best_rainbow_tint)
    if best_rainbow_tint then
        local tint_colors = {
            Pink = Color3.fromRGB(255, 105, 180),
            Purple = Color3.fromRGB(128, 0, 128),
            Green = Color3.fromRGB(0, 255, 0),
            Black = Color3.fromRGB(0, 0, 0),
            White = Color3.fromRGB(255, 255, 255),
            Grey = Color3.fromRGB(128, 128, 128),
            Orange = Color3.fromRGB(255, 165, 0),
            Yellow = Color3.fromRGB(255, 255, 0),
            Camo = Color3.fromRGB(102, 102, 51),
            Brown = Color3.fromRGB(139, 69, 19)
        }

        getgenv().rainbow_tinting_car = true
        while getgenv().rainbow_tinting_car == true do
        task.wait()
            for name, color in pairs(tint_colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    local args = {
                        tostring(current_car.Name),
                        {
                            ColorTint = color,
                            TransparencyTint = 0
                        }
                    }

                    Vehicle_Change_RF:InvokeServer(unpack(args))
                elseif not tint_colors then
                    getgenv().Rainbow_Tint_FE:Set(false)
                else
                    getgenv().rainbow_tinting_car = false
                    getgenv().Rainbow_Tint_FE:Set(false)
                    return getgenv().notify("Failure:", "Please spawn a vehicle before using this.", 5)
                end
            end
        end
    else
        getgenv().rainbow_tinting_car = false
        getgenv().rainbow_tinting_car = false
    end
end,})
wait(0.2)
if getgenv().rainbow_tinting_car == true then
    getgenv().notify("Heads Up:", "Disabled Rainbow Tint, it was enabled at runtime.", 5)
    getgenv().rainbow_tinting_car = false
    getgenv().Rainbow_Tint_FE:Set(false)
end

getgenv().Rainbow_Vehicle_Underglow = Tab4:CreateToggle({
Name = "Rainbow Vehicle Underglow (FE)",
CurrentValue = false,
Flag = "RainbowUnderglow",
Callback = function(rainbow_underglow)
    if rainbow_underglow then
        getgenv().rainbow_vehicle_underglow = true
        while getgenv().rainbow_vehicle_underglow == true do
        task.wait()
            local underglow_colors = {
                Pink = Color3.fromRGB(255, 105, 180),
                Purple = Color3.fromRGB(128, 0, 128),
                Green = Color3.fromRGB(0, 255, 0),
                Black = Color3.fromRGB(0, 0, 0),
                White = Color3.fromRGB(255, 255, 255),
                Grey = Color3.fromRGB(128, 128, 128),
                Orange = Color3.fromRGB(255, 165, 0),
                Yellow = Color3.fromRGB(255, 255, 0),
                Camo = Color3.fromRGB(102, 102, 51),
                Brown = Color3.fromRGB(139, 69, 19)
            }

            for name, color in pairs(underglow_colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    local args = {
                        current_car.Name,
                        {
                            ColorUnderglow = color,
                            EnabledUnderglow = true
                        }
                    }

                    Vehicle_Change_RF:InvokeServer(unpack(args))
                else
                    getgenv().rainbow_vehicle_underglow = false
                    getgenv().Rainbow_Vehicle_Underglow:Set(false)
                    return getgenv().notify("Failure:", "Please spawn a vehicle before using this.", 5)
                end
            end
        end
    else
        getgenv().rainbow_vehicle_underglow = false
        getgenv().rainbow_vehicle_underglow = false
    end
end,})
wait(0.2)
if getgenv().rainbow_vehicle_underglow == true then
    getgenv().notify("Heads Up:", "Disabled Rainbow Underglow, it was enabled at runtime.", 5)
    getgenv().rainbow_vehicle_underglow = false
    getgenv().Rainbow_Vehicle_Underglow:Set(false)
end

getgenv().Rainbow_Tires_FE = Tab4:CreateToggle({
Name = "Rainbow Tires (FE)",
CurrentValue = false,
Flag = "RainbowFETiresScript",
Callback = function(Rainbow_Tires_Main)
    if Rainbow_Tires_Main then
        local wheel_colors = {
            Pink = Color3.fromRGB(255, 105, 180),
            Purple = Color3.fromRGB(128, 0, 128),
            Green = Color3.fromRGB(0, 255, 0),
            Black = Color3.fromRGB(0, 0, 0),
            White = Color3.fromRGB(255, 255, 255),
            Grey = Color3.fromRGB(128, 128, 128),
            Orange = Color3.fromRGB(255, 165, 0),
            Yellow = Color3.fromRGB(255, 255, 0),
            Camo = Color3.fromRGB(102, 102, 51),
            Brown = Color3.fromRGB(139, 69, 19)
        }

        getgenv().RainbowTires_Script = true
        while getgenv().RainbowTires_Script == true do
        task.wait()
            for name, color in pairs(wheel_colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    local args = {
                        current_car.Name,
                        {
                            ColorWheels = color
                        }
                    }
                    Vehicle_Change_RF:InvokeServer(unpack(args))
                else
                    getgenv().RainbowTires_Script = false
                    getgenv().Rainbow_Tires_FE:Set(false)
                    return getgenv().notify("Failure:", "Please spawn a vehicle before using this.", 5)
                end
            end
        end
    else
        getgenv().RainbowTires_Script = false
        getgenv().RainbowTires_Script = false
    end
end,})
wait(0.2)
if getgenv().RainbowTires_Script == true then
    getgenv().notify("Heads Up:", "Disabled Rainbow Tires, it was enabled at runtime.", 5)
    getgenv().RainbowTires_Script = false
    getgenv().Rainbow_Tires_FE:Set(false)
end

for _, v in pairs(all_vehicles) do
    local Any_Car = v
end

local Owned_Vehicle_Slots = {}

for _, car in pairs(carNames) do
    table.insert(Owned_Vehicle_Slots, car)
end
wait()
local vehicle_selected = nil

getgenv().Spawn_Vehicle_Plr = Tab3:CreateDropdown({
Name = "Spawn Vehicle",
Options = Owned_Vehicle_Slots,
CurrentOption = "",
MultipleOptions = false,
Flag = "vehicle_slot",
Callback = function(vehicle_slot_picker)
    if typeof(vehicle_slot_picker) == "table" then
        vehicle_slot_picker = vehicle_slot_picker[1]
        wait(0.3)
        print("Selected Vehicle: "..tostring(vehicle_slot_picker))
    end
    wait(0.2)
    vehicle_selected = carNames[vehicle_slot_picker]
    wait(0.3)
    print("Spawning Vehicle: "..tostring(vehicle_slot_picker))
    spawn_vehicle(vehicle_slot_picker)
end,})

getgenv().Delete_Vehicle = Tab3:CreateButton({
Name = "Delete Current Vehicle",
Callback = function()
    local Events_Folder = getgenv().ReplicatedStorage:FindFirstChild("Events")
    local Delete_Car_Remote = Events_Folder:FindFirstChild("RemoteEvent")
    local LocalPlayer = getgenv().LocalPlayer
    local Values_Folder = LocalPlayer:FindFirstChild("Values")
    local References_Folder = Values_Folder:FindFirstChild("References")
    local Vehicle_Seat_Car = References_Folder:FindFirstChild("CarSeat").Value

    Delete_Car_Remote:FireServer("VehicleDelete", { Vehicle_Seat_Car.Parent })
end,})

getgenv().ClaimAllRewards = Tab3:CreateButton({
Name = "Claim All Rewards",
Callback = function()
    local IsClaimedFiveMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay5Mins"):GetAttribute("Claimed")
    local IsClaimedTenMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay10Mins"):GetAttribute("Claimed")
    local IsClaimedFifteenMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay15Mins"):GetAttribute("Claimed")
    local IsClaimedThirtyMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay30Mins"):GetAttribute("Claimed")
    local IsClaimedSixtyMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay60Mins"):GetAttribute("Claimed")

    if IsClaimedFiveMins then
        getgenv().notify("[Already Claimed]:", "Skipping 5 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay5Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success:", "Successfully claimed 5 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedTenMins then
        getgenv().notify("[Already Claimed]:", "Skipping 10 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay10Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
                task.wait()
        getgenv().notify("Success:", "Successfully claimed 10 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedFifteenMins then
        getgenv().notify("[Already Claimed]:", "Skipping 15 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay15Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success:", "Successfully claimed 15 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedThirtyMins then
        getgenv().notify("[Already Claimed]:", "Skipping 30 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay30Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success:", "Successfully claimed 30 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedSixtyMins then
        getgenv().notify("[Already Claimed]:", "Skipping 60 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay60Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success:", "Successfully claimed 60 minute reward!", 5)
    end
end,})

if executor_Name ~= "Solara" and executor_Name ~= "Xeno" then
    if not string.find(executor_Name, "JJSploit") then
        local current_vehicle = retrieve_vehicle()
        if not current_vehicle then
            spawn_vehicle(randomly_selected_vehicle)
        end
        local Chassis_Core = current_vehicle:FindFirstChild("Chassis: Core")
        local Tuning_Components_Folder = Chassis_Core:FindFirstChild("Tuning Components")
        local Engine_Module_Script = require(Tuning_Components_Folder:FindFirstChild("Engine"))

        Engine_Module_Script.Enabled = true
        task.wait(0.3)
        getgenv().Mod_Engine_HorsePower = Tab1:CreateSlider({
        Name = "HorsePower",
        Range = {5, 750},
        Increment = 1,
        Suffix = "",
        CurrentValue = 5,
        Flag = "EngineHorsepowerModifier",
        Callback = function(Desired_Horsepower)
            local current_vehicle = retrieve_vehicle()

            if current_vehicle then
                Engine_Module_Script.Horsepower = Desired_Horsepower
            end
        end,})

        getgenv().Mod_Engine_PeakRPM = Tab1:CreateSlider({
        Name = "Peak RPM",
        Range = {2000, 20000},
        Increment = 10,
        Suffix = "",
        CurrentValue = 4000,
        Flag = "EnginePeakRPMModifier",
        Callback = function(Desired_PeakRPM)
            local current_vehicle = retrieve_vehicle()

            if current_vehicle then
                Engine_Module_Script.PeakRPM = Desired_PeakRPM
            end
        end,})

        getgenv().Mod_Engine_Braking = Tab1:CreateSlider({
        Name = "Braking",
        Range = {1000, 99999},
        Increment = 100,
        Suffix = "",
        CurrentValue = 2500,
        Flag = "EngineBrakingModifier",
        Callback = function(Desired_BrakePower)
            local current_vehicle = retrieve_vehicle()

            if current_vehicle then
                Engine_Module_Script.Braking = Desired_BrakePower
            end
        end,})

        getgenv().Mod_Engine_RevAccel = Tab1:CreateSlider({
        Name = "Rev Acceleration",
        Range = {100, 99999},
        Increment = 50,
        Suffix = "",
        CurrentValue = 100,
        Flag = "EngineRevAccelModifier",
        Callback = function(Desired_RevAccel)
            local current_vehicle = retrieve_vehicle()

            if current_vehicle then
                Engine_Module_Script.RevAccel = Desired_RevAccel
            end
        end,})

        getgenv().Mod_Engine_ThrotAccel = Tab1:CreateSlider({
        Name = "Throttle Acceleration",
        Range = {0.1, 1},
        Increment = 0.1,
        Suffix = "",
        CurrentValue = 0.5,
        Flag = "EngineThrottleAccelModifier",
        Callback = function(Desired_ThrotAccel)
            local current_vehicle = retrieve_vehicle()

            if current_vehicle then
                Engine_Module_Script.ThrotAccel = Desired_ThrotAccel
            end
        end,})

        getgenv().Mod_Engine_CurveMult = Tab1:CreateSlider({
        Name = "Curve Multiplier",
        Range = {0.2, 2},
        Increment = 0.1,
        Suffix = "",
        CurrentValue = 0.4,
        Flag = "EngineCurveMultiplierModifier",
        Callback = function(Desired_CurveMult)
            local current_vehicle = retrieve_vehicle()

            if current_vehicle then
                Engine_Module_Script.CurveMult = Desired_CurveMult
            end
        end,})
    else
        getgenv().notify("Heads Up:", "JJSploit does not support Car Mods with this script!", 5)
    end
else
    getgenv().notify("Heads Up:", "Solara/Xeno does not support Car Mods with this script!", 5)
end

getgenv().Vehicle_TP_Player = Tab3:CreateInput({
Name = "Vehicle TP To Player (bypasses range limitations)",
PlaceholderText = "User",
RemoveTextAfterFocusLost = true,
Callback = function(player_to_TP_to)
    local Player_To_TP = findplr(player_to_TP_to)

    if not Player_To_TP then return getgenv().notify("Failure:", "Player was not found!", 5) end
    task.wait(.3)
    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Vehicles_LocalPlayer_Folder = LocalPlayer:FindFirstChild("Vehicles")
    local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
    local Main_Folder = Workspace:FindFirstChild("_Main")
    local Vehicles_Folder = Main_Folder and Main_Folder:FindFirstChild("Vehicles")

    local function retrieve_vehicle()
        if not Vehicles_Folder or not Vehicles_LocalPlayer_Folder then return nil end
        local objectValue = Vehicles_LocalPlayer_Folder:FindFirstChildOfClass("ObjectValue")
        if not objectValue then return nil end
        for _, v in ipairs(Vehicles_Folder:GetChildren()) do
            if v:IsA("Model") and v.Name == tostring(objectValue.Value) then
                return v
            end
        end
        return nil
    end

    local Vehicle = retrieve_vehicle()
    local PlayerName = tostring(Player_To_TP)
    local TargetPlayer = Players:FindFirstChild(PlayerName)

    if Vehicle and TargetPlayer and TargetPlayer.Character then
        local charPivot = TargetPlayer.Character:GetPivot()
        local newCFrame = charPivot + Vector3.new(0, 15, 0)
        
        Vehicle:PivotTo(newCFrame)
    elseif not Vehicle then
        return getgenv().notify("Failure:", "Please spawn a vehicle to use this feature!", 5)
    else
        return getgenv().notify("Failure:", "Target or Target's Character does not exist!", 5)
    end
end,})

getgenv().Inf_Yield = Tab3:CreateButton({
Name = "Infinite Yield",
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end,})

getgenv().System_Broken = Tab3:CreateButton({
Name = "System Broken",
Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/LmaoItsCrazyBro/new_main/refs/heads/main/System_Broken.lua'))()
end,})
