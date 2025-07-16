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
wait(0.5)
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
wait(0.2)
init_services()
wait(0.5)
local lib = loadstring(getgenv().Game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/ParadiseRPScript/refs/heads/main/Turtle_UI_Remake.lua"))()
local Main = lib:Window("Main")
local Players_Tab = lib:Window("Players")
local Extras = lib:Window("Extras")
local Audio = lib:Window("Music/Audio")

getgenv().notify = function(Title, Content, Time)
   local Image = "7201212960"

   getgenv().StarterGui:SetCore("SendNotification", {
      Title = tostring(Title);
      Text = tostring(Content);
      Duration = tonumber(Time);
      Icon = "rbxassetid://"..Image;
   })
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
        return getgenv().notify("[Error]:", "You cannot target yourself.", 5)
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
wait()
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
if getgenv().performance_stats then
    warn("Performance stats checked.")
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/OrionLibraryReWrittenCelery/refs/heads/main/grab_file_performance"))()
    wait(0.1)
    getgenv().performance_stats = true
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
   wait(0.2)
	getgenv().Character = character
	wait(0.3)
	getgenv().HumanoidRootPart = SafeGetHRP(character)
	getgenv().Humanoid = SafeGetHumanoid(character)
	getgenv().Head = SafeGetHead(character)
   wait(0.3)
   if character:FindFirstChild("Humanoid") then
      print("Character has loaded, and it's Humanoid is initialized and loaded as well!")
      character:FindFirstChild("Humanoid").JumpPower = 50
      character:FindFirstChild("Humanoid").JumpHeight = 7
   else
      warn("Character has not loaded or does not have an existing Humanoid, switching to getgenv() method...")
      wait(1)
      getgenv().Humanoid.JumpPower = 50
      getgenv().Humanoid.JumpHeight = 7
   end
end

Dynamic_Character_Updater(getgenv().Character)
wait(0.2)
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
   task.wait(0.2)
   Dynamic_Character_Updater(newCharacter)
   repeat wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
   wait(0.6)
   getgenv().HumanoidRootPart = SafeGetHRP(newCharacter)
   getgenv().Humanoid = SafeGetHumanoid(newCharacter)
   getgenv().Head = SafeGetHead(newCharacter)
   wait(0.2)
   if newCharacter:FindFirstChild("Humanoid") then
      newCharacter:FindFirstChild("Humanoid").JumpHeight = 7
      newCharacter:FindFirstChild("Humanoid").JumpPower = 50
   else
      warn("newCharacter has not loaded it's Humanoid yet, failure!, switching to getgenv().Humanoid method instead...")
   end
   getgenv().Humanoid.JumpHeight = 7
   getgenv().Humanoid.JumpPower = 50
   Dynamic_Character_Updater(newCharacter)
end)
wait(0.2)
local has_hookfunction = typeof(hookfunction) == "function"
if not has_hookfunction then warn("[ERROR]:", "HOOKFUNCTION UNSUPPORTED!") end
local has_hookmetamethod = typeof(hookmetamethod) == "function"
if not has_hookfunction then warn("[ERROR]:", "HOOKMETAMETHOD UNSUPPORTED!") end
local has_getmetatable = typeof(getmetatable) == "function"
if not has_hookfunction then warn("[ERROR]:", "GETMETATABLE UNSUPPORTED!") end
local has_setmetatable = typeof(setmetatable) == "function"
if not has_hookfunction then warn("[ERROR]:", "SETMETATABLE UNSUPPORTED!") end

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
local ws = getgenv().Workspace

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
wait(0.1)
LocalPlayer_loaded()
render_safe()
wait(0.2)
local Game_Data = ReplicatedStorage:FindFirstChild("GameData")
local It_Val = Game_Data:FindFirstChild("It")
wait(0.2)
local function is_LocalPlayer_It()
    if It_Val.Value == getgenv().LocalPlayer or It_Val.Value == getgenv().LocalPlayer.Name then
        return true
    else
        return false
    end

    return nil
end
wait(0.2)
local WHITELIST = {}
getgenv().WHITELIST = WHITELIST
wait(0.2)
function add_whitelist_plr(user)
    if not user or not user.Name then
        return getgenv().notify("FAILURE:", "Player doesn't exist!", 5)
    end

    if not WHITELIST[user.Name] then
        WHITELIST[user.Name] = true
        getgenv().notify("[WHITELISTED]:", user.Name .. " has been added to the whitelist.", 5)
    else
        getgenv().notify("INFO:", user.Name .. " is already in the whitelist.", 5)
    end
end
wait(0.1)
function remove_whitelist_plr(user)
    if not user or not user.Name then
        return getgenv().notify("FAILURE:", "Player doesn't exist!", 5)
    end

    if WHITELIST[user.Name] then
        WHITELIST[user.Name] = nil
        getgenv().notify("[REMOVED]:", user.Name .. " has been removed from the whitelist.", 5)
    else
        getgenv().notify("INFO:", user.Name .. " is not in the whitelist.", 5)
    end
end
wait(0.3)
local Game_Objects = Workspace:FindFirstChild("GameObjects")
local Player_Data = getgenv().LocalPlayer:FindFirstChild("PlayerData")
local It_LocalPlr_Value = Player_Data:FindFirstChild("It")
local InGame_LocalPlr_Value = Player_Data:FindFirstChild("InGame")
local Is_Seeking = Game_Data:FindFirstChild("ItSeeking")
local Selecting_Map = Game_Data:FindFirstChild("SelectingMap")
local Selecting_It = Game_Data:FindFirstChild("SelectingIt")
local Showing_EndGame_GUI = Game_Data:FindFirstChild("ShowingEndGameGui")
local Total_Hiders = Game_Data:FindFirstChild("StartingAmountOfHiders")
local Stopping_Game = Game_Data:FindFirstChild("StoppingGame")
local Chosen_Map = Game_Data:FindFirstChild("MapSelection"):FindFirstChild("NameLabelValue")
local Animation_Replication = ReplicatedStorage:FindFirstChild("AnimationReplication")
local Place_Glue_RE = Animation_Replication:FindFirstChild("PlaceGlue")
local Play_Sound_Boombox_RE = Animation_Replication:FindFirstChild("PlaySoundBoombox")
local Stop_Sound_Boombox_FE = Animation_Replication:FindFirstChild("StopSoundBoombox")
wait(0.2)
function find_all_players_whitelist()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not WHITELIST[player.Name] then
            local char = player.Character
            local myChar = getgenv().Character
            if char and myChar and char:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
                myChar:PivotTo(char.HumanoidRootPart.CFrame + Vector3.new(0, 1.5, 0))
                task.wait(0.2)
            end
        end
    end
end

function find_all_players_no_whitelist()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            local myChar = getgenv().Character
            if char and myChar and char:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
                myChar:PivotTo(char:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0, 1.5, 0))
                task.wait(0.2)
            end
        end
    end
end

local Remotes = getgenv().ReplicatedStorage:FindFirstChild("Remotes")
local Play_Sound_Others_RE = Remotes:FindFirstChild("PlaySoundOthers")
local espTransparency = 0.3
local Players = getgenv().Players or getgenv().Service_Wrap("Players") or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = getgenv().RunService
local CoreGui = getgenv().Service_Wrap("CoreGui")
local LocalPlayer = Players.LocalPlayer

function getRoot(char)
	if typeof(char) ~= "Instance" or not char:IsA("Model") then
		return nil
	end

	local potentialRoots = {
		"HumanoidRootPart",
		"UpperTorso",
		"Torso"
	}

	for _, partName in ipairs(potentialRoots) do
		local part = char:FindFirstChild(partName)
		if part and part:IsA("BasePart") then
			return part
		end
	end

	return nil
end

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function safe_spot_tp()
    local Lobby = ws:FindFirstChild("Lobby")
    local Base_Plate

    for _, v in pairs(Lobby:GetChildren()) do
        if v:IsA("BasePart") and v.CanCollide == false then
            v.CanCollide = true
        end
    end
    wait(0.1)
    for _, v in pairs(Lobby:GetChildren()) do
        if v:IsA("BasePart") and v.Name == "BasePlate" and v.BrickColor == BrickColor.new("Ghost grey") then
            Base_Plate = v
        end
    end
    wait(0.3)
    getgenv().HumanoidRootPart.CFrame = CFrame.new(Base_Plate.Position + Vector3.new(0, 3, 0))
end

getgenv().toggle_spawn_box_visible = getgenv().toggle_spawn_box_visible or false

function toggle_visible_spawn_box(state)
    local ws = getgenv().Workspace or workspace
    local Lobby = ws:FindFirstChild("Lobby")
    if not Lobby or not Lobby:IsA("Model") then return end

    local visible
    if typeof(state) == "boolean" then
        visible = state
        getgenv().toggle_spawn_box_visible = state
    else
        getgenv().toggle_spawn_box_visible = not getgenv().toggle_spawn_box_visible
        visible = getgenv().toggle_spawn_box_visible
    end

    for _, v in ipairs(Lobby:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = visible and 0 or 1
        end
    end

    local status = visible and "VISIBLE" or "INVISIBLE"
    if getgenv().notify then
        getgenv().notify("SPAWN BOX TOGGLE", "Lobby parts are now " .. status, 3)
    end
end

function play_music_others(ID)
    for _, v in ipairs(getgenv().Players:GetChildren()) do
        if v ~= getgenv().LocalPlayer then
            local Target_Char = v.Character or v.CharacterAdded:Wait()
            local Target_HRP = Target_Char and Target_Char:FindFirstChild("HumanoidRootPart") or Target_Char:WaitForChild("HumanoidRootPart", 3)
            if not Target_Char then return getgenv().notify("Failure:", "Player's Character does not exist!", 5) end
            if not Target_HRP then return getgenv().notify("Failure:", "Player's HumanoidRootPart is missing1", 5) end
        
            local args = {
                tonumber(ID),
                {
                    Parent = Target_HRP,
                    Pitch = 1,
                    Volume = 2
                }
            }

            Play_Sound_Others_RE:FireServer(unpack(args))
        end
    end
end

local function is_player_it(p)
	return It_Val and (It_Val.Value == p or It_Val.Value == p.Name)
end

local Is_On_Cooldown = false
local Cooldown_Time = 30
local Cooldown_End_Time = 0

function Try_To_predict_IT_Plr()
    local Players = getgenv().Players
    local LocalPlayer = getgenv().LocalPlayer

    if Is_On_Cooldown then
        local time_left = math.ceil(Cooldown_End_Time - tick())
        if time_left < 1 then time_left = 1 end
        return getgenv().notify("Wait!", "You are on prediction cooldown (" .. time_left .. " seconds left)!", 5)
    end

    Is_On_Cooldown = true
    Cooldown_End_Time = tick() + Cooldown_Time

    local function create_dice_gui()
        local screen = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
        screen.Name = "IT_Predictor_GUI"
        screen.ResetOnSpawn = false

        local frame = Instance.new("Frame", screen)
        frame.Size = UDim2.new(0, 500, 0, 200)
        frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        frame.AnchorPoint = Vector2.new(0.5, 0.5)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.TextScaled = true
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.GothamBold
        label.Text = "Rolling Dice..."

        return screen, label
    end

    local function get_random_player()
        local all_players = Players:GetPlayers()
        if #all_players == 0 then return nil end
        return all_players[math.random(1, #all_players)]
    end

    local gui, label = create_dice_gui()

    local roll_times = 15
    for i = 1, roll_times do
        local temp_player = get_random_player()
        if temp_player then
            label.Text = "🎲 " .. temp_player.Name
        else
            label.Text = "No players..."
        end
        wait(0.1 + i * 0.01)
    end

    local predicted_player = get_random_player()
    if predicted_player and Players:FindFirstChild(predicted_player.Name) then
        label.Text = "🎯 Predicted IT: " .. predicted_player.Name
    else
        label.Text = "⚠️ Prediction Failed (player left)"
    end

    task.delay(3, function()
        if gui then gui:Destroy() end
    end)

    task.delay(Cooldown_Time, function()
        Is_On_Cooldown = false
    end)
end

function ESP(plr)
	task.spawn(function()
		for _, v in pairs(CoreGui:GetChildren()) do
			if v.Name == plr.Name.."_ESP" then
				v:Destroy()
			end
		end

		if not plr.Character or plr == LocalPlayer then return end
		if CoreGui:FindFirstChild(plr.Name.."_ESP") then return end

		local holder = Instance.new("Folder", CoreGui)
		holder.Name = plr.Name.."_ESP"

		repeat task.wait(1) until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")

		for _, part in ipairs(plr.Character:GetChildren()) do
			if part:IsA("BasePart") then
				local box = Instance.new("BoxHandleAdornment")
				box.Name = plr.Name
				box.Parent = holder
				box.Adornee = part
				box.AlwaysOnTop = true
				box.ZIndex = 10
				box.Size = part.Size
				box.Transparency = espTransparency
				box.Color = is_player_it(plr) and BrickColor.new("Bright blue") or BrickColor.new("Bright red")
			end
		end

		if plr.Character:FindFirstChild("Head") then
			local bb = Instance.new("BillboardGui")
			local label = Instance.new("TextLabel")

			bb.Adornee = plr.Character.Head
			bb.Name = plr.Name
			bb.Parent = holder
			bb.Size = UDim2.new(0, 100, 0, 150)
			bb.StudsOffset = Vector3.new(0, 1, 0)
			bb.AlwaysOnTop = true

			label.Parent = bb
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(0, 100, 0, 100)
			label.Position = UDim2.new(0, 0, 0, -50)
			label.Font = Enum.Font.SourceSansSemibold
			label.TextSize = 20
			label.TextStrokeTransparency = 0
			label.TextYAlignment = Enum.TextYAlignment.Bottom
			label.ZIndex = 10

			local itGui = Instance.new("BillboardGui")
			itGui.Name = "IT_Label"
			itGui.Adornee = plr.Character.Head
			itGui.Parent = holder
			itGui.Size = UDim2.new(0, 100, 0, 50)
			itGui.StudsOffset = Vector3.new(0, 2.5, 0)
			itGui.AlwaysOnTop = true

			local itText = Instance.new("TextLabel", itGui)
			itText.Size = UDim2.new(1, 0, 1, 0)
			itText.BackgroundTransparency = 1
			itText.Text = "Seeker/IT"
			itText.Font = Enum.Font.SourceSansBold
			itText.TextSize = 22
			itText.TextColor3 = Color3.fromRGB(100, 255, 200)
			itText.TextStrokeTransparency = 0.3
			itText.Visible = is_player_it(plr)

			local function updateESP()
				if not getgenv().ESPenabled or not holder or not holder.Parent then return end
				if plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
					and LocalPlayer.Character and getRoot(LocalPlayer.Character)
					and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then

					local dist = (getRoot(LocalPlayer.Character).Position - getRoot(plr.Character).Position).Magnitude
					local hp = plr.Character:FindFirstChildOfClass("Humanoid").Health
					label.Text = string.format("Name: %s | Health: %s | Studs: %s", plr.Name, round(hp, 1), round(dist, 1))

					local isIt = is_player_it(plr)
					label.TextColor3 = isIt and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(255, 255, 255)
					itText.Visible = isIt

					for _, adorn in ipairs(holder:GetChildren()) do
						if adorn:IsA("BoxHandleAdornment") then
							adorn.Color = isIt and BrickColor.new("Bright blue") or BrickColor.new("Bright red")
						end
					end
				end
			end

			local renderLoop = RunService.RenderStepped:Connect(updateESP)

			local function rebuild()
				renderLoop:Disconnect()
				holder:Destroy()
				ESP(plr)
			end

			plr.CharacterAdded:Connect(function()
				if getgenv().ESPenabled then rebuild() end
			end)

			plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
				if getgenv().ESPenabled then rebuild() end
			end)
		end
	end)
end

function toggle_ESP(state)
	getgenv().ESPenabled = state

	if state then
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				ESP(p)
			end
		end
		Players.PlayerAdded:Connect(function(p)
			if getgenv().ESPenabled then
				p.CharacterAdded:Wait()
				ESP(p)
			end
		end)
	else
		for _, v in pairs(CoreGui:GetChildren()) do
			if v.Name:match("_ESP$") then
				v:Destroy()
			end
		end
	end
end

function pivot_to_plr(Player)
    if not Player then return end

    local Targets_Char = Player.Character or Player.CharacterAdded:Wait()

    if Targets_Char and Targets_Char:FindFirstChild("Humanoid") then
        getgenv().Character:PivotTo(Targets_Char:GetPivot())
    end
end

local function count_parts(model)
	if not model or not model:IsA("Model") then
		return false
	end

	local partCount = 0

	for _, v in ipairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			partCount += 1
		end
	end

	return partCount
end

function collect_all_coins(method)
    if method == "no_tp" then
        if not firetouchinterest then return getgenv.notify("Failure:", "Your exploit does not support 'firetouchinterest'!", 5) end

        for _, v in pairs(Game_Objects:GetChildren()) do
            if v:IsA("BasePart") and v.Name == "Credit" then
                wait(0.1)
                firetouchinterest(getgenv().HumanoidRootPart, v, 0)
                wait(0.1)
                firetouchinterest(getgenv().HumanoidRootPart, v, 1)
                wait(0.1)
            end
        end
    elseif method == "teleport" then
        for _, v in pairs(Game_Objects:GetChildren()) do
            if v:IsA("BasePart") and v.Name == "Credit" then
                wait()
                getgenv().Character:PivotTo(v:GetPivot())
                wait(0.2)
                getgenv().notify("Hang On:", "Picking up Credit: "..tostring(v), 5)
            end
        end
    else
        return getgenv().notify("Failure:", "Invalid argument specified when calling function.", 5)
    end
end

local Current_ID = 0
wait(0.2)
Audio:Box("(FE): Music", function(text, focuslost)
    if focuslost then
        local id = tonumber(text)
        wait()
        Current_ID = id
    end
end)
wait(0.1)
Audio:Button("Play Music (FE)", function()
    Play_Sound_Boombox_RE:FireServer(Current_ID)
end)
wait(0.1)
Audio:Button("Stop Music", function()
    Stop_Sound_Boombox_FE:FireServer()
end)

Extras:Button("Get Coins (No TP)", function()
    collect_all_coins("no_tp")
end)

Extras:Button("Get Coins (TP)", function()
   local result_parts = count_parts(Game_Objects)

   if result_parts == false then
      return getgenv().notify("Failure:", "GameObjects doesn't exist, try again!", 5)
   elseif result_parts == 0 then
      return getgenv().notify("Failure:", "No Credit's found to collect!", 5)
   elseif result_parts > 0 then
      local Old_CF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame
      wait(0.2)
      collect_all_coins("teleport")
      wait(0.3)
      getgenv().HumanoidRootPart.CFrame = Old_CF
   end
end)

Main:Box("Whitelist Plr:", function(target_whitelist, focuslost)
    local target = findplr(target_whitelist)

    if focuslost and target then
        add_whitelist_plr(target)
    elseif not target then
        return getgenv().notify("Failure:", "Target does not exist!", 5)
    end
end)

Main:Box("Remove Plr:", function(target_remove_whitelist, focuslost)
    local target_unwhitelist = findplr(target_remove_whitelist)

    if focuslost and target_unwhitelist then
        remove_whitelist_plr(target_unwhitelist)
    elseif not target_unwhitelist then
        return getgenv().notify("Failure:", "Target does not exist!", 5)
    end
end)

Main:Button("Find All (No Whitelist)", function()
    if not InGame_LocalPlr_Value.Value then
        return getgenv().notify("Failure:", "You are not currently in-game!", 5)
    end

    if not It_LocalPlr_Value.Value then
        return getgenv().notify("Failure:", "You are not currently IT/seeker!", 5)
    end

    task.wait(0.1)
    find_all_players_no_whitelist()
end)

Main:Button("Find All (Whitelist)", function()
        if not InGame_LocalPlr_Value.Value then
        return getgenv().notify("Failure:", "You are not currently in-game!", 5)
    end

    if not It_LocalPlr_Value.Value then
        return getgenv().notify("Failure:", "You are not currently IT/seeker!", 5)
    end
    task.wait(0.1)
    find_all_players_whitelist()
end)

Players_Tab:Toggle("Timer Flasher", false, function(flashing)
    if flashing then
        local TimerFolder = ReplicatedStorage:WaitForChild("Timer")
        local TimeVisible = TimerFolder:WaitForChild("TimeVisible")
        local Time = TimerFolder:WaitForChild("Time")

        getgenv().FlashTimer = true

        local function getFlashDelay(timeRemaining)
            if timeRemaining >= 20 then
                return 0.5
            elseif timeRemaining >= 10 then
                return 0.3
            elseif timeRemaining >= 5 then
                return 0.15
            elseif timeRemaining >= 1 then
                return 0.08
            else
                return 0.05
            end
        end

        while getgenv().FlashTimer == true do
            local currentTime = Time.Value

            if currentTime <= -0.05 then
                TimeVisible.Value = true
            end

            TimeVisible.Value = not TimeVisible.Value
            wait(getFlashDelay(currentTime))
        end
    else
        getgenv().FlashTimer = false
        wait(0.7)
        local TimerFolder = ReplicatedStorage:WaitForChild("Timer")
        local TimeVisible = TimerFolder:WaitForChild("TimeVisible")

        TimeVisible.Value = true
    end
end)

Players_Tab:Toggle("Player ESP", false, function(esp_enabled)
   if esp_enabled then
      toggle_ESP(true)
   else
      toggle_ESP(false)
   end
end)

Players_Tab:Button("Whos It", function()
   getgenv().notify("Current Seeker:", tostring(It_Val.Value), 5)
end)

Main:Button("Safe Spot TP", function()
    safe_spot_tp()
end)

Extras:Toggle("Visible Spawn", false, function(is_spawn_visible)
    if is_spawn_visible then
        toggle_visible_spawn_box(true)
    else
        toggle_visible_spawn_box(false)
    end
end)

Players_Tab:Slider("WalkSpeed",16,500,16, function(WalkSpeed)
    getgenv().Humanoid.WalkSpeed = WalkSpeed
end)

Players_Tab:Slider("JumpPower",50,500,50, function(New_JP)
    if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
        getgenv().Humanoid.JumpPower = New_JP
    else
        getgenv().Humanoid.JumpHeight = New_JP
    end
end)

Players_Tab:Slider("Gravity",0,300,196, function(New_Gravity)
    getgenv().Workspace.Gravity = New_Gravity
end)

Players_Tab:Box("TP To Player:", function(Target)
    local Player_To_Teleport_To = findplr(Target)

    if not Player_To_Teleport_To then return getgenv().notify("Failure:", "Player does not exist!", 5) end

    pivot_to_plr(Player_To_Teleport_To)
end)

Extras:Toggle("Rainbow Timer", false, function(rainbow_timer_text)
   if rainbow_timer_text then
      local TweenService = getgenv().TweenService
      local RunService = getgenv().RunService

      local Main_GUI = getgenv().PlayerGui:FindFirstChild("MainGui")
      if not Main_GUI then return getgenv().notify("Failure:", "MainGui doesn't exist in PlayerGui!", 5) end
      local Timer_Frame = Main_GUI:FindFirstChild("TimerFrame")
      if not Timer_Frame then return getgenv("Failure:", "TimerFrame doesn't exist in MainGui!", 5) end
      local Time_TextLabel = Timer_Frame:FindFirstChild("Time")
      local TimerText_TextLabel = Timer_Frame:FindFirstChild("TimerText")
      if not TimerText_TextLabel then return getgenv().notify("Failure:", "TimerText TextLabel doesn't exist in Timer_Frame!", 5) end
      if not Time_TextLabel then return getgenv().notify("Failure:", "Timer TextLabel doesn't exist in Timer_Frame!", 5) end
      wait(0.1)
      getgenv().RainbowText = true

      local function tweenToColor(object, color, duration)
         local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
         local tween = TweenService:Create(object, tweenInfo, {TextColor3 = color})
         tween:Play()
         return tween
      end

      coroutine.wrap(function()
         local hue = 0
         while getgenv().RainbowText do
            local color = Color3.fromHSV(hue, 1, 1)

            local tween1 = tweenToColor(Time_TextLabel, color, 0.2)
            local tween2 = tweenToColor(TimerText_TextLabel, color, 0.2)

            tween1.Completed:Wait()

            hue = hue + 0.02
            if hue > 1 then hue = 0 end

            RunService.Heartbeat:Wait()
         end
      end)()
   else
      getgenv().RainbowText = false
      wait(1)
      local Main_GUI = getgenv().PlayerGui:FindFirstChild("MainGui")
      if not Main_GUI then return getgenv().notify("Failure:", "MainGui doesn't exist in PlayerGui!", 5) end
      local Timer_Frame = Main_GUI:FindFirstChild("TimerFrame")
      if not Timer_Frame then return getgenv("Failure:", "TimerFrame doesn't exist in MainGui!", 5) end
      local Time_TextLabel = Timer_Frame:FindFirstChild("Time")
      local TimerText_TextLabel = Timer_Frame:FindFirstChild("TimerText")
      if not TimerText_TextLabel then return getgenv().notify("Failure:", "TimerText TextLabel doesn't exist in Timer_Frame!", 5) end
      if not Time_TextLabel then return getgenv().notify("Failure:", "Timer TextLabel doesn't exist in Timer_Frame!", 5) end

      Time_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
      TimerText_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
   end
end)

Extras:Toggle("Rainbow UI", false, function(rainbow_UI_frames)
   if rainbow_UI_frames then
        local RunService = getgenv().RunService

        local Main_GUI = getgenv().PlayerGui:FindFirstChild("MainGui")
        if not Main_GUI then return getgenv().notify("Failure:", "MainGui doesn't exist in PlayerGui!", 5) end

        local Shop_Frame = Main_GUI:FindFirstChild("ShopFrame")
        if not Shop_Frame then return getgenv().notify("Failure:", "ShopFrame doesn't exist in MainGui!", 5) end

        wait(0.1)
        getgenv().Rainbow_Game_UI = true
        getgenv().OriginalColors = {}

        for _, uiObject in pairs(Shop_Frame:GetDescendants()) do
            if uiObject:IsA("Frame") or uiObject:IsA("TextLabel") or uiObject:IsA("TextButton") then
                getgenv().OriginalColors[uiObject] = {
                    BackgroundColor3 = uiObject.BackgroundColor3
                }
                if uiObject:IsA("TextLabel") or uiObject:IsA("TextButton") then
                    getgenv().OriginalColors[uiObject].TextColor3 = uiObject.TextColor3
                end
            end
        end

        coroutine.wrap(function()
            local hue = 0
            while getgenv().Rainbow_Game_UI do
                local color = Color3.fromHSV(hue, 1, 1)

                for _, uiObject in pairs(Shop_Frame:GetDescendants()) do
                    if uiObject:IsA("Frame") or uiObject:IsA("TextLabel") or uiObject:IsA("TextButton") then
                        uiObject.BackgroundColor3 = color
                        if uiObject:IsA("TextLabel") or uiObject:IsA("TextButton") then
                            uiObject.TextColor3 = color
                        end
                    end
                end

                hue = hue + 0.005
                if hue > 1 then hue = 0 end

                RunService.Heartbeat:Wait()
            end
        end)()
   else
        getgenv().Rainbow_Game_UI = false
        wait(0.1)

        for uiObject, colors in pairs(getgenv().OriginalColors) do
            if uiObject and uiObject.Parent then
                uiObject.BackgroundColor3 = colors.BackgroundColor3
                if uiObject:IsA("TextLabel") or uiObject:IsA("TextButton") then
                    uiObject.TextColor3 = colors.TextColor3
                end
            end
        end

        getgenv().OriginalColors = nil
   end
end)

Extras:Button("Try To Predict IT/Seeker", function()
    Try_To_predict_IT_Plr()
end)

Audio:Box("Music Others", function(music_ID)
    play_music_others(music_ID)
end)

--[[ Bypassed Audios Working As Of: 7/15/2025 -- ]]

-- 133381881709184 -- unleaked
-- 81127387662817 -- unleaked
-- 96502224821858 -- cool unleaked phonk
-- 91233243522140 -- cool unleaked phonk

--[[ Bypassed Audios Working As Of: 7/15/2025 -- ]]
