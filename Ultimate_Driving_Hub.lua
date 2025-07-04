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
    warn("[Ultimate_Driving_Hub]: Waiting for Character to fully load...")
    task.wait(0.2)
    getgenv().Character = character or getgenv().LocalPlayer.Character
    task.wait(0.3)
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3)
    getgenv().HumanoidRootPart = (hrp and hrp:IsA("BasePart")) and hrp

    local hum = character:FindFirstChildOfClass("Humanoid")
    getgenv().Humanoid = (hum and hum:IsA("Humanoid")) and hum

    if Inf_Stamina_Active or Inf_Stamina_Active == true then
        getgenv().inf_stamina = false
        warn("Infinite-Stamina Toggle is [ENABLED], setting Stamina attribute to infinite.")
        task.wait(.3)
        getgenv().inf_stamina = true
        while getgenv().inf_stamina == true do
        wait(.3)
            if hum:GetAttribute("Stamina") then
                hum:SetAttribute("Stamina", 9e9)
            else
                getgenv().inf_stamina = false
                Inf_Stamina_Active = false
                if getgenv().notify then
                    getgenv().notify("Heads Up:", "Unable to properly locate 'Stamina' Attribute in Humanoid.", 5)
                else
                    warn("[Heads Up!]:", "'Stamina' Attribute not found in Humanoid at Character runtime.")
                end
            end
        end
    end

    if Anti_Ragdoll_Active or Anti_Ragdoll_Active == true then
        warn("Anti-Ragdoll Toggle is [ENABLED], removing unpermitted/unnecessary included in-game pre-requisites...")
        task.wait(.3)
        if character and character:FindFirstChild("Humanoid") then
            character:FindFirstChild("RagdollConstraints"):Destroy()
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

local HttpService = getgenv().HttpService or getgenv().Service_Wrap("HttpService")

local carNames = {}
local Owned_Vehicle_Slots = {}

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

    table.clear(carNames)
    for carName, data in pairs(decoded) do
        carNames[carName] = data
        table.insert(Owned_Vehicle_Slots, carName)
    end

    return carNames
end
wait(0.1)
get_car_names()
task.wait()

-- To be input into script hub soon.
--local Gun_Shop_Prompt = getgenv().Workspace:FindFirstChild("_Main"):FindFirstChild("GunGivers"):FindFirstChild("WeaponBuilding"):FindFirstChild("Building"):FindFirstChild("GunShop"):FindFirstChild("ShopPad"):FindFirstChildOfClass("ProximityPrompt")

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

local Players = getgenv().Players
local LocalPlayer = Players.LocalPlayer
local Character = getgenv().Character
local Backpack = getgenv().Backpack
local Old_PVP_Enabled = getgenv().Character:GetAttribute("PVPDamageEnabled")
getgenv().specific_weapon_mod = false
getgenv().all_weapon_mods = false
local User_Configuration = User_Configuration or {}
local guns = {}

for _, v in ipairs(Character:GetChildren()) do
    if v:IsA("Tool") and v:FindFirstChild("Configuration") then
        v.Parent = Backpack
    end
end
task.wait(0.1)
local function get_all_weapons()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Configuration") then
            table.insert(guns, tool)
        end
    end

    return guns
end

local function get_specific_weapon(weapon_name)
    for _, v in ipairs(getgenv().Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == weapon_name and v:FindFirstChild("Configuration") then
            return v
        end
    end

    return nil
end

local function get_weapon()
    for _, v in ipairs(getgenv().Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Configuration") then
            return v
        end
    end

    return nil
end

local function mod_weapon(gun)
    local weapon = get_specific_weapon(gun)
    if not weapon then return end
    local Gun_Config = weapon:FindFirstChild("Configuration")

    while getgenv().specific_weapon_mod == true do
    task.wait()
        if Gun_Config:FindFirstChild("FireMode") then
            Gun_Config.FireMode.Value = "Automatic"
        end
        Gun_Config.AmmoCapacity = 9e9
        Gun_Config.HitDamage = 9e9
        Gun_Config.MaxSpread = 0
        Gun_Config.RecoilDecay = 1
        Gun_Config.RecoilMax = 0
        Gun_Config.ShotCooldown = 0
        Gun_Config.TotalRecoilMax = 0
        if weapon:GetAttribute("Ammo") then
            weapon:SetAttribute("Ammo", 9e9)
        end
    end
end

local function mod_all_guns()
    local all_weapons = get_all_weapons()
    for _, tool in ipairs(all_weapons) do
        if not tool then return end
        local Gun_Config = tool:FindFirstChild("Configuration")

        if Gun_Config:FindFirstChild("FireMode") then
            Gun_Config.FireMode.Value = "Automatic"
        end
        Gun_Config.AmmoCapacity.Value = 9e9
        Gun_Config.HitDamage.Value = 9e9
        Gun_Config.MaxSpread.Value = 0
        Gun_Config.RecoilDecay.Value = 1
        Gun_Config.RecoilMax.Value = 0
        Gun_Config.ShotCooldown.Value = 0
        Gun_Config.TotalRecoilMax.Value = 0
        if tool:GetAttribute("Ammo") then
            tool:SetAttribute("Ammo", 9e9)
        end
    end
    wait(0.2)
    return 
end

local function buy_weapon(gun_name)
    local args = {
        "ToolEvent",
        {
            "Purchase",
            {
                tostring(gun_name)
            }
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
    return 
end

local function switch_team(team_name)
    getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("Data"):WaitForChild("ResetBounty"):InvokeServer()
    wait(0.3)
    local args = {
        tostring(team_name)
    }

    getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("Admin"):WaitForChild("ChangeTeam"):InvokeServer(unpack(args))
    return 
end

function Can_Damage()
    if executor_Name == "Solara" or executor_Name == "Xeno" or string.find(executor_Name, "JJSploit") then
        local BOUNTY_THRESHOLD = getgenv().ReplicatedStorage:WaitForChild("GameSettings"):WaitForChild("BountyLevels"):GetAttribute("Level_Fine")
        local TOOL_KEYS = {
            IsWeapon = "IsWeapon"
        }
        local Weapons = {
            ["Desert Eagle"] = { IsWeapon = true },
            ["Pistol"] = { IsWeapon = true },
            ["Bizon"] = { IsWeapon = true },
            ["AUG"] = { IsWeapon = true },
            ["M16"] = { IsWeapon = true },
            ["MP5"] = { IsWeapon = true },
            ["UZI"] = { IsWeapon = true },
            ["P90"] = { IsWeapon = true },
            ["SCAR"] = { IsWeapon = true },
            ["SPAS-12"] = { IsWeapon = true },
            ["Scout"] = { IsWeapon = true },
            ["Sawed Off"] = { IsWeapon = true },
            ["FAMAS"] = { IsWeapon = true },
            ["Barrett"] = { IsWeapon = true },
            ["G36C"] = { IsWeapon = true },
            ["MP7"] = { IsWeapon = true },
            ["AA12"] = { IsWeapon = true },
            ["M249"] = { IsWeapon = true },
            ["Vector"] = { IsWeapon = true },
            ["Explosive Sniper"] = { IsWeapon = true },
            ["Minigun"] = { IsWeapon = true },
            ["AK"] = { IsWeapon = true },
            ["TEC-9"] = { IsWeapon = true },
        }

        local function CanDamagePlayer(attacker, target, tool)
            if not (target and target:GetAttribute("PvP_Active")) then
                warn("[Error]:", "PvP is not enabled, got: false.")
                return false
            end

            if tool and Weapons[tool.Name] and Weapons[tool.Name][TOOL_KEYS.IsWeapon] == false then
                warn("None of the weapons in the table appear to be an actual weapon, how did you even get this error?")
                return false
            end

            local attacker_team = attacker.Team and attacker.Team.Name or ""
            local target_team = target.Team and target.Team.Name or ""

            local is_attacker_criminal = attacker_team == "Criminal"
            local is_other_criminal = target_team == "Criminal"

            if attacker_team == "Police" then
                local stats = target:FindFirstChild("leaderstats")
                if is_other_criminal then
                    return "KILL"
                end
                if stats and stats:FindFirstChild("Bounty") and stats.Bounty.Value >= BOUNTY_THRESHOLD then
                    return "FINE"
                end
            elseif is_attacker_criminal and (is_other_criminal or target_team == "Police") then
                return "KILL"
            end

            return false
        end

        return CanDamagePlayer
    else
        local ReplicatedStorage = getgenv().ReplicatedStorage
        local Modules = ReplicatedStorage:FindFirstChild("Modules")
        local Can_Damage = require(Modules:FindFirstChild("CanDamagePlayer"))
        local Damage_Enabled = Can_Damage()

        return Damage_Enabled
    end
end

local function kill_player(player)
    if not player or not player:IsDescendantOf(game.Players) then return end

    local char = getgenv().Character
    local lp = getgenv().LocalPlayer
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local backpack = lp:FindFirstChildWhichIsA("Backpack")
    local weapon_hit = getgenv().ReplicatedStorage:WaitForChild("WeaponsSystem"):WaitForChild("Network"):WaitForChild("WeaponHit")

    local victim_char = player.Character or player.CharacterAdded:Wait()
    local victim_hum = victim_char:FindFirstChild("Humanoid")
    local victim_hrp = victim_char:FindFirstChild("HumanoidRootPart")

    if not victim_hrp or not victim_hum then return end

    if lp.Team.Name ~= "Criminal" then
        if getgenv().notify then
            getgenv().notify("Failure:", "Please become a Criminal to use this!", 5)
        end
        return
    end

    local equipped_correctly = false
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Configuration") then
            hum:EquipTool(tool)
            repeat task.wait() until char:FindFirstChild(tool.Name)
            equipped_correctly = true
            break
        end
    end

    if not equipped_correctly then
        if getgenv().notify then
            getgenv().notify("Error:", "No valid gun in backpack.", 5)
        end
        return
    end

    local equipped_tool = char:FindFirstChildWhichIsA("Tool")
    if not equipped_tool then return end

    for i = 1, 100 do
        task.wait()
        local args = {
            equipped_tool,
            {
                p = vector.create(1795.986328125, 59.66236877441406, 5395.9365234375),
                pid = 1,
                origin = vector.create(1787.1165771484375, 60.78240966796875, 5399.0166015625),
                part = victim_hrp or victim_char:FindFirstChild("Hitbox"),
                d = 9.455890655517578,
                maxDist = 9.389322280883789,
                h = victim_hum,
                m = Enum.Material.Plastic,
                n = vector.create(-0.008076800033450127, 0.9968878626823425, 0.07841799408197403),
                t = 0.28342804913539854,
                sid = 8
            }
        }
        weapon_hit:FireServer(unpack(args))
    end
end

local script_errors = {}

local function write_error_log_file(filepath, new_error)
    if writefile and readfile then
        local old_content = ""
        local success, result = pcall(function()
            old_content = readfile(filepath)
        end)

        local updated_log = (old_content ~= "" and (old_content .. "\n") or "") .. new_error
        writefile(filepath, updated_log)
    else
        warn("writefile() or readfile() are unsupported, low level executor detected! Your executor: " .. tostring(executor_Name))
    end
end

if isfile("UltimateDriving_ErrorLog.txt") then
    warn("Skipping writefile error log part...")
else
    write_error_log_file("UltimateDriving_ErrorLog.txt", "[]")
end
task.wait(0.2)
local error_logs_file = "UltimateDriving_ErrorLog.txt"

local function Is_In_Race()
    local error_exited = false

    if error_exited then
        return warn("[DEBUG]:", "local function 'Is_In_Race()' | Exited with errors when ran last-time.")
    end

    if executor_Name == "Solara" or executor_Name == "Xeno" or string.find(executor_Name, "JJSploit") then
        local racesOngoing = getgenv().ReplicatedStorage:FindFirstChild("ReplicatedData") and getgenv().ReplicatedStorage.ReplicatedData:FindFirstChild("RacesOngoing")
        if not racesOngoing then 
            error_exited = true
            table.insert(script_errors, '[Stack Begin]: "RacesOnGoing" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            write_error_log_file(error_logs_file, '[Stack Begin]: "RacesOnGoing" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            warn("[DEBUG]:", "An error occurred, please check the logs file 'UltimateDriving_ErrorLog.txt' in your 'workspace' Folder where-ever your executor is located for more information.")
            return false
        end

        for _, race in pairs(racesOngoing:GetChildren()) do
            local racers = race:FindFirstChild("ActiveRacers")
            if racers and racers:FindFirstChild(game.Players.LocalPlayer.Name) then
                return true
            end
        end
        return false
    else
        local Modules = getgenv().ReplicatedStorage:FindFirstChild("Modules")
        if not Modules then
            error_exited = true
            table.insert(script_errors, '[Stack Begin]: "Modules" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            write_error_log_file(error_logs_file, '[Stack Begin]: "Modules" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            warn("[DEBUG]:", "An error occurred, please check the logs file: 'UltimateDriving_ErrorLog.txt' in your 'workspace' Folder where-ever your executor is located for more information.")
            return false
        end

        local playerRaceModule = Modules:FindFirstChild("PlayerIsInRace")
        if not playerRaceModule then
            error_exited = true
            table.insert(script_errors, '[Stack Begin]: "PlayerIsInRace" is not a valid member of Folder "Modules" :[Stack End]')
            write_error_log_file(error_logs_file, '[Stack Begin]: "PlayerIsInRace" is not a valid member of Folder "Modules" :[Stack End]')
            warn("[DEBUG]:", "An error occurred, please check the logs file: 'UltimateDriving_ErrorLog.txt' in your 'workspace' Folder where-ever your executor is located for more information.")
            return false
        end

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
        Name = "✅ Ultimate Driving ✅ | 1.2.6 | "..tostring(executor_Name),
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
local Tab5 = Window:CreateTab("🔫 Weapon 🔫", 0)
local Section5 = Tab5:CreateSection("| 🔫 Weapons Stuff 🔫 |")
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

getgenv().InfStamina_FE = Tab2:CreateToggle({
Name = "Infinite Stamina (FE)",
CurrentValue = false,
Flag = "InfStaminaScript",
Callback = function(inf_stamina)
    if inf_stamina then
        local Players = getgenv().Players
        local LocalPlayer = getgenv().LocalPlayer
        local Character = getgenv().Character
        local Humanoid = getgenv().Humanoid
        local Modules = LocalPlayer:FindFirstChild("Modules")
        local Managers_Folder = Modules:FindFirstChild("Managers")
        local Sprint_Manager = require(Managers_Folder:FindFirstChild("SprintManager"))
        local Stamina_Attribute = Humanoid:GetAttribute("Stamina")
        if not Stamina_Attribute then
            getgenv().inf_stamina = false
            return warn("Unable to return Stamina value Attribute!") 
        end
        wait(0.2)
        getgenv().inf_stamina = true
        Inf_Stamina_Active = true

        if Stamina_Attribute then
            while getgenv().inf_stamina == true do
            task.wait()
                Humanoid:SetAttribute("Stamina", 9e9)
            end
        end
    else
        getgenv().inf_stamina = false
        getgenv().inf_stamina = false
        if getgenv().Humanoid:GetAttribute("Stamina") then
            getgenv().Humanoid:SetAttribute("Stamina", 100)
            return getgenv().notify("Success:", "Sprint stamina successfully reset to 100.", 5)
        else
            return getgenv().notify("Failure:", "Stamina Attribute was not found in Humanoid!", 5)
        end
    end
end,})
wait(0.2)
if getgenv().inf_stamina == true then
    getgenv().inf_stamina = false
    getgenv().InfStamina_FE:Set(false)
    getgenv().notify("Heads Up:", "Turned off InfiniteStamina, it was enabled at runtime.", 5)
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
            if getgenv().ReplicatedStorage:FindFirstChild("WeaponsSystem"):FindFirstChild("Libraries"):FindFirstChild("Ragdoll") then
                getgenv().ReplicatedStorage:FindFirstChild("WeaponsSystem"):FindFirstChild("Libraries"):FindFirstChild("Ragdoll").Parent = getgenv().ReplicatedFirst or game:GetService("ReplicatedFirst")
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

local shift_to_run_connection
getgenv().run_Shift_Speed = 50
getgenv().walkSpeed = 16
getgenv().runningEnabled = false

getgenv().ShifTToRunSpeed = Tab2:CreateInput({
Name = "Shift_To_Run Speed",
PlaceholderText = "Enter Speed",
RemoveTextAfterFocusLost = true,
Callback = function(get_speed)
    local speed = tonumber(get_speed)
    if speed then
        getgenv().run_Shift_Speed = speed
    else
        warn("Invalid speed input. Please enter a number.")
    end
end,})
wait(0.2)
getgenv().ShiftToRun = Tab2:CreateToggle({
Name = "Shift To Run (broken right now)",
CurrentValue = false,
Flag = "SpeedCoilAlt",
Callback = function(shifting_run)
    getgenv().runningEnabled = shifting_run

    if shift_to_run_connection then
        shift_to_run_connection:Disconnect()
        shift_to_run_connection = nil
    end

    if shifting_run then
        local UIS = getgenv().UserInputService
        local Players = getgenv().Players
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local humanoid = character:WaitForChild("Humanoid")
        local shiftHeld = false

        shift_to_run_connection = getgenv().RunService.Heartbeat:Connect(function()
            if getgenv().runningEnabled and humanoid then
                if shiftHeld then
                    humanoid.WalkSpeed = getgenv().run_Shift_Speed
                else
                    humanoid.WalkSpeed = getgenv().walkSpeed
                end
            end
        end)

        UIS.InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.LeftShift and not gameProcessed and getgenv().runningEnabled then
                shiftHeld = true
            end
        end)

        UIS.InputEnded:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.LeftShift and not gameProcessed and getgenv().runningEnabled then
                shiftHeld = false
            end
        end)

        player.CharacterAdded:Connect(function(newChar)
            character = newChar
            humanoid = character:WaitForChild("Humanoid")
        end)
    else
        if shift_to_run_connection then
            shift_to_run_connection:Disconnect()
            shift_to_run_connection = nil
        end
        wait(0.2)
        local character = getgenv().Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = getgenv().walkSpeed
            end
        end
    end
end,})
wait(0.2)
if getgenv().runningEnabled == true then
    if shift_to_run_connection then
        shift_to_run_connection:Disconnect()
        shift_to_run_connection = nil
    end
    getgenv().Character:WaitForChild("Humanoid").WalkSpeed = getgenv().walkSpeed or 16
    getgenv().runningEnabled = false
    getgenv().ShiftToRun:Set(false)
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
                    return getgenv().notify("Failure:", "Vehicle has been destroyed or de-spawned, please spawn one.", 5)
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

getgenv().Kill_Player_FE = Tab5:CreateInput({
Name = "Kill Player (FE)",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Callback = function(player_to_eliminate)
    local Target_To_Kill = findplr(player_to_eliminate)

    if not Target_To_Kill then return getgenv().notify("Failure:", "Player does not seem to exist.", 5) end
    wait(0.2)
    if Target_To_Kill.Team == getgenv().Teams.Citizen then
        getgenv().notify("Heads Up:", "Player is a Civilian, they MAY not die or take damage.", 5)
    end
    task.wait()
    kill_player(Target_To_Kill)
    wait(0.5)
    getgenv().Character:FindFirstChildWhichIsA("Humanoid"):UnequipTools()
end,})

getgenv().KillCrims = Tab5:CreateButton({
Name = "Kill Criminals (FE)",
Callback = function()
    local Players = getgenv().Players
    local Teams = getgenv().Teams
    local LocalPlayer = getgenv().LocalPlayer

    local crim_targets = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Team == Teams:FindFirstChild("Criminal") and player ~= LocalPlayer then
            table.insert(crim_targets, player)
        end
    end

    for i, player in ipairs(crim_targets) do
        kill_player(player)
    end

    if #crim_targets > 0 then
        local hum = getgenv().Character:FindFirstChildWhichIsA("Humanoid")

        if hum then
            hum:UnequipTools()
        end
    end
end,})

getgenv().KillCops = Tab5:CreateButton({
Name = "Kill Police (FE)",
Callback = function()
    local Players = getgenv().Players
    local Teams = getgenv().Teams
    local LocalPlayer = getgenv().LocalPlayer

    local cop_targets = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Team == Teams:FindFirstChild("Police") and player ~= LocalPlayer then
            table.insert(cop_targets, player)
        end
    end

    for i, player in ipairs(cop_targets) do
        kill_player(player)
    end

    if #cop_targets > 0 then
        local hum = getgenv().Character:FindFirstChildWhichIsA("Humanoid")

        if hum then
            hum:UnequipTools()
        end
    end
end,})

local function loop_kill_addon(target, toggled)
    if not target then 
        return warn("Target or Target's Character does not appear to exist.") 
    end

    if target.Team and target.Team.Name == "Civilian" then
        getgenv().notify("Heads Up:", "Player is a Civilian, they MAY not die or take damage.", 5)
    end

    getgenv().looping_kills = true

    coroutine.wrap(function()
        while getgenv().looping_kills == true and toggled == true do
            task.wait()

            if not target or not target:IsDescendantOf(game.Players) then
                getgenv().looping_kills = false
                getgenv().Humanoid:UnequipTools()
                return getgenv().notify("Heads Up:", "Turned off LoopKill, player left or does not exist.", 5)
            end

            if not target.Character then
                local success, char = pcall(function()
                    return target.CharacterAdded:Wait()
                end)
                if success then
                    target.Character = char
                    wait(0.2)
                end
            end

            if target.Character and target.Character:FindFirstChild("Humanoid") then
                kill_player(target)
            end
        end
    end)()
end

getgenv().ModAll_Weapons = Tab5:CreateToggle({
Name = "Mod All Guns (lower level executors method)",
CurrentValue = false,
Flag = "ModifyingAllWeapons",
Callback = function(modded_weapons_all)
    if modded_weapons_all then
        getgenv().modded_weapons_all_of_them = true
        while getgenv().modded_weapons_all_of_them == true do
        wait(0.5)
            mod_all_guns()
        end
    else
        getgenv().modded_weapons_all_of_them = false
        getgenv().modded_weapons_all_of_them = false
    end
end,})

getgenv().InfAmmo_AllGuns = Tab5:CreateButton({
Name = "Infinite Ammo (Advanced Method, Any Weapon)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_namecall = mt.__namecall

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if method == "GetAttribute" and tostring(args[1]) == "Ammo" then
                return 9e9
            end

            return old_namecall(self, unpack(args))
        end)
    else
        return getgenv().notify("Failure:", "Your executor cannot run this, sorry.", 5)
    end
end,})

getgenv().NoRecoil_NameCall = Tab5:CreateButton({
Name = "No Recoil (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "RecoilMin" or name == "RecoilMax" then
                    return 0
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Failure:", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().NoSpread_IndexMethod = Tab5:CreateButton({
Name = "No Spread (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "MaxSpread" then
                    return 0
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Failure:", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().HighDamage_IndexMethod = Tab5:CreateButton({
Name = "Mod Hit Damage (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "HitDamage" then
                    return 500
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Failure:", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().FireModeMod_IndexMethod = Tab5:CreateButton({
Name = "Automatic Weapons (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "FireMode" then
                    return "Automatic"
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Failure:", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().AllGunMods_IndexMethod = Tab5:CreateButton({
Name = "Mod All Guns (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_namecall = mt.__namecall

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if method == "GetAttribute" and tostring(args[1]) == "Ammo" then
                return 9e9
            end

            return old_namecall(self, unpack(args))
        end)
        wait(0.2)
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "AmmoCapacity" then
                    return 9e9
                elseif name == "RecoilMin" or name == "RecoilMax" or name == "MaxSpread" then
                    return 0
                elseif name == "HitDamage" then
                    return 500
                elseif name == "FireMode" then
                    return "Automatic"
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Failure:", "Your executor does not support this, sorry.", 5)
    end
end,})

local Weapons = {
    ["Desert Eagle"] = { IsWeapon = true },
    ["Pistol"] = { IsWeapon = true },
    ["Bizon"] = { IsWeapon = true },
    ["AUG"] = { IsWeapon = true },
    ["M16"] = { IsWeapon = true },
    ["MP5"] = { IsWeapon = true },
    ["UZI"] = { IsWeapon = true },
    ["P90"] = { IsWeapon = true },
    ["SCAR"] = { IsWeapon = true },
    ["SPAS-12"] = { IsWeapon = true },
    ["Scout"] = { IsWeapon = true },
    ["Sawed Off"] = { IsWeapon = true },
    ["FAMAS"] = { IsWeapon = true },
    ["Barrett"] = { IsWeapon = true },
    ["G36C"] = { IsWeapon = true },
    ["MP7"] = { IsWeapon = true },
    ["AA12"] = { IsWeapon = true },
    ["M249"] = { IsWeapon = true },
    ["Vector"] = { IsWeapon = true },
    ["Explosive Sniper"] = { IsWeapon = true },
    ["Minigun"] = { IsWeapon = true },
    ["AK"] = { IsWeapon = true },
    ["TEC-9"] = { IsWeapon = true },
}

local Weapon_Options = {}
for name, _ in pairs(Weapons) do
    table.insert(Weapon_Options, name)
end
task.wait()
local selected_weapon = nil

getgenv().ModAWeapon = Tab5:CreateDropdown({
Name = "Mod A Weapon (works for lower level executors)",
Options = Weapon_Options,
CurrentOption = "",
MultipleOptions = false,
Flag = "weapon_slot_select",
Callback = function(chosen_gun)
    selected_weapon = chosen_gun
    local Result_Weapon = getgenv().Backpack:FindFirstChild(chosen_gun)
    if not Result_Weapon then return getgenv().notify("Failure:", "Weapon was not found in your Backpack/inventory!", 5) end
    
    if Result_Weapon then
        mod_weapon(selected_weapon)
    end
end,})

getgenv().PvPSetting = Tab2:CreateToggle({
Name = "PvP",
CurrentValue = false,
Flag = "PvPToggle",
Callback = function(is_pvp_on)
    if is_pvp_on then
        getgenv().pvp_damage_value = true
        local Character = getgenv().Character
        local PvP_Attribute = Character:GetAttribute("PVPDamageEnabled")
        if PvP_Attribute == nil then
            getgenv().pvp_damage_value = false
            getgenv().PvPSetting:Set(false)
            return getgenv().notify("Error:", "PvP Attribute was not found in Character, cannot set PvP.", 5)
        end

        if getgenv().pvp_damage_value == true then
            Character:SetAttribute("PVPDamageEnabled", true)
        end
    else
        getgenv().pvp_damage_value = false
        if getgenv().Character:GetAttribute("PVPDamageEnabled") and getgenv().Character:GetAttribute("PVPDamageEnabled") == true then
            getgenv().Character:SetAttribute("PVPDamageEnabled", false)
        end
    end
end,})
wait(0.3)
if Old_PVP_Enabled == true then
    warn("PVP was enabled before, re-enabling...")
    getgenv().PvPSetting:Set(true)
    getgenv().Character:SetAttribute("PVPDamageEnabled", true)
else
    warn("PVP was disabled before, disabling...")
    getgenv().PvPSetting:Set(false)
    getgenv().Character:SetAttribute("PVPDamageEnabled", false)
end

getgenv().LoopKill_Plr = Tab5:CreateInput({
Name = "LoopKill Player (FE)",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Callback = function(plr_to_loopkill)
    local Plr_LoopKill = findplr(plr_to_loopkill)

    if not Plr_LoopKill then return getgenv().notify("Failure:", "Player does not seem to exist.", 5) end
    wait(0.2)
    loop_kill_addon(Plr_LoopKill, true)
    wait(0.2)
    Plr_LoopKill.CharacterAdded:Connect(function(their_new_character)
        if their_new_character and their_new_character:FindFirstChild("Humanoid") then
            kill_player(Plr_LoopKill)
        end
    end)
end,})

getgenv().StopLoopKill = Tab5:CreateButton({
Name = "Shutdown/Stop LoopKill",
Callback = function()
    getgenv().looping_kills = false
    getgenv().Character:FindFirstChildWhichIsA("Humanoid"):UnequipTools()
    wait(0.4)
    if not getgenv().looping_kills then
        getgenv().notify("Success:", "LoopKill has been successfully stopped.", 5)
        return 
    else
        getgenv().notify("Failure:", "Could not properly shutdown LoopKill!", 5)
        return 
    end
end,})

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

local Owned_Vehicle_Slots = {}
table.clear(Owned_Vehicle_Slots)

for name, _ in pairs(carNames) do
    table.insert(Owned_Vehicle_Slots, name)
end
wait()
local vehicle_selected = nil

getgenv().Spawn_Vehicle_Plr = Tab3:CreateDropdown({
Name = "Spawn A Vehicle",
Options = Owned_Vehicle_Slots,
CurrentOption = "",
MultipleOptions = false,
Flag = "vehicle_slot",
Callback = function(vehicle_slot_picker)
    if typeof(vehicle_slot_picker) == "table" then
        vehicle_slot_picker = vehicle_slot_picker[1]
    end

    vehicle_selected = carNames[vehicle_slot_picker]
    task.wait(.3)
    spawn_vehicle(vehicle_slot_picker)
end,})

getgenv().Delete_Vehicle = Tab3:CreateButton({
Name = "Delete Current Vehicle",
Callback = function()
    local Events_Folder = getgenv().ReplicatedStorage:FindFirstChild("Events")
    local Delete_Car_Remote = Events_Folder:FindFirstChild("RemoteEvent")
    local LocalPlayer = getgenv().LocalPlayer
    local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
    local SeatPart = Humanoid.SeatPart
    local Values_Folder = LocalPlayer:FindFirstChild("Values")
    local References_Folder = Values_Folder:FindFirstChild("References")
    local Vehicle_Seat_Car = References_Folder:FindFirstChild("CarSeat").Value

    if not SeatPart or not SeatPart.Parent then
        return getgenv().notify("Failure:", "You are NOT sitting in a Vehicle to delete it.", 5)
    end

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
