if not game:IsLoaded() then game.Loaded:Wait() end

local parent_main_gui = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui())
local g = getgenv()

if not getgenv().GlobalEnvironmentFramework_Initialized then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua'))()
    wait(0.1)
    getgenv().GlobalEnvironmentFramework_Initialized = true
end

local executor_string = nil

local function executor_contains(substr)
    if type(executor_string) ~= "string" then
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

function low_level_executor()
   if executor_contains("solara") then return true end
   if executor_contains("jjsploit") then return true end
   if executor_contains("xeno") then return true end
   return false
end

if game.PlaceId ~= 205224386 then
    if getgenv().notify then
        return getgenv().notify("Error", "This is not Hide And Seek Extreme!", 10)
    else
        return 
    end
end

local low_level_exec = low_level_executor()

if getgenv().CoreGui then
    for _, v in ipairs(getgenv().CoreGui:GetChildren()) do
        if v.Name:lower():find("turtle") then
            v:Destroy()
        end
    end
else
    for _, v in ipairs(game.CoreGui:GetChildren()) do
        if v.Name:lower():find("turtle") then
            v:Destroy()
        end
    end
end

if parent_main_gui then
    for _, v in ipairs(parent_main_gui:GetChildren()) do
        if v.Name:lower():find("turtle") then
            v:Destroy()
        end
    end
end
wait(0.6)
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/ParadiseRPScript/refs/heads/main/Turtle_UI_Remake.lua"))()
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
local Main = lib:Window("Main")
local Players_Tab = lib:Window("Players")
local Extras = lib:Window("Extras")
local Audio = lib:Window("Music/Audio")
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

getgenv().randomString = getgenv().randomString or function()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

local cmdp = getgenv().Players or Players or game.Players
local cmdlp = cmdp.LocalPlayer

function findplr(args)
    local tbl = cmdp:GetPlayers()

    if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
        return getgenv().notify("Error", "You cannot target yourself.", 5)
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

getgenv().AllClipboards = getgenv().AllClipboards or setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
getgenv().httprequest_Init = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
get_http = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
getgenv().queueteleport = getgenv().queueteleport or (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
queueteleport = getgenv().queueteleport

local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local p = LocalPlayer
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local RepS = ReplicatedStorage
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Modules = ReplicatedStorage:FindFirstChild("Modules") or ReplicatedStorage:WaitForChild("Modules", 5)
local mods = Modules

getgenv().get_char = getgenv().get_char or function(Player)
    if not Player or not Player:IsA("Player") then return nil end

    local current_char
    local diedconn
    local added_conn

    local function hookchar(char)
        current_char = char

        if diedconn then diedconn:Disconnect() end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            diedconn = hum.Died:Once(function()
                current_char = nil
            end)
        end
    end

    if Player.Character and Player.Character.Parent then
        hookchar(Player.Character)
    end

    added_conn = Player.CharacterAdded:Connect(hookchar)

    while not current_char do
        task.wait()
        local char = Player.Character
        if char and char.Parent then
            hookchar(char)
        end
    end

    return current_char
end
wait(0.5)
if not getgenv().get_human then
    getgenv().get_human = function(Player)
        local char = getgenv().get_char(Player)
        if not char then return nil end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then return hum end

        local hum_conn
        hum_conn = char.ChildAdded:Connect(function(c)
            if c:IsA("Humanoid") then
                hum = c
                hum_conn:Disconnect()
            end
        end)

        local died = false
        local h = char:FindFirstChildOfClass("Humanoid")
        if h then
            h.Died:Connect(function()
                died = true
            end)
        end

        while not hum and not died do
            task.wait()
        end

        if hum_conn then hum_conn:Disconnect() end

        return (not died) and hum or nil
    end
end

if not getgenv().get_root then
    getgenv().get_root = function(Player)
        local char = getgenv().get_char(Player)
        if not char then return nil end

        local root = char:FindFirstChild("HumanoidRootPart")
                or char:FindFirstChild("UpperTorso")
                or char:FindFirstChild("Torso")
        if root then return root end

        local targets = {
            HumanoidRootPart = true,
            UpperTorso = true,
            Torso = true
        }

        local died = false
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Died:Connect(function() died = true end)
        end

        local added_conn
        added_conn = char.ChildAdded:Connect(function(c)
            if targets[c.Name] then
                root = c
                added_conn:Disconnect()
            end
        end)

        while not root and not died do
            task.wait()
        end

        if added_conn then added_conn:Disconnect() end

        return (not died) and root or nil
    end
end

if not getgenv().get_head then
    getgenv().get_head = function(Player)
        local char = getgenv().get_char(Player)
        if not char then return nil end

        local head = char:FindFirstChild("Head")
        if head then return head end

        local died = false
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Died:Connect(function() died = true end)
        end

        local added_conn
        added_conn = char.ChildAdded:Connect(function(c)
            if c.Name == "Head" then
                head = c
                added_conn:Disconnect()
            end
        end)

        while not head and not died do
            task.wait()
        end

        if added_conn then added_conn:Disconnect() end

        return (not died) and head or nil
    end
end

getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer or game.Players.LocalPlayer
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
wait(0.5)
local Workspace = getgenv().Workspace
local LocalPlayer = getgenv().LocalPlayer or getgenv().Players.LocalPlayer
local ReplicatedStorage = getgenv().ReplicatedStorage
local ws = getgenv().Workspace
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
        return getgenv().notify("Error", "Player: "..tostring(user).." does not exist.", 6)
    end

    if not WHITELIST[user.Name] then
        WHITELIST[user.Name] = true
        getgenv().notify("Success", tostring(user.Name).." has been added to the whitelist.", 5)
    else
        getgenv().notify("Warning", tostring(user.Name).." is already in the whitelist.", 5)
    end
end
wait(0.1)
function remove_whitelist_plr(user)
    if not user or not user.Name then
        return getgenv().notify("Error", "Player: "..tostring(user).." does not exist.", 6)
    end

    if WHITELIST[user.Name] then
        WHITELIST[user.Name] = nil
        getgenv().notify("Success", tostring(user.Name).." has been removed from the whitelist.", 5)
    else
        getgenv().notify("Warning", tostring(user.Name).." is not in the whitelist.", 5)
    end
end

local players = Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local local_plr = players.LocalPlayer
getgenv().player_esp = getgenv().player_esp or false

local function create_highlight(target, color)
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.Parent = target
    return h
end

local function create_label(target, text, color)
    if target:FindFirstChild("esp_label") then
        return target.esp_label
    end

    local b = Instance.new("BillboardGui")
    b.Name = "esp_label"
    b.Size = UDim2.new(0,150,0,50)
    b.AlwaysOnTop = true
    b.LightInfluence = 0
    b.MaxDistance = 5000
    b.StudsOffset = Vector3.new(0, 2.5, 0)
    b.Parent = target

    local t = Instance.new("TextLabel")
    t.Name = "TextLabel"
    t.Size = UDim2.new(1,0,1,0)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = color
    t.TextScaled = true
    t.Font = Enum.Font.GothamBold
    t.Parent = b

    return b
end

local function clear_esp(char)
    local h = char:FindFirstChild("esp_highlight")
    if h then h:Destroy() end

    local head = char:FindFirstChild("Head")
    if head then
        local lbl = head:FindFirstChild("esp_label")
        if lbl then lbl:Destroy() end
    end
end

local function apply_esp(plr, it_name)
    local char = plr.Character
    if not char then return end

    local head = char:FindFirstChild("Head")
    if not head then return end

    local is_it = tostring(plr.Name) == it_name
    local col = is_it and Color3.fromRGB(40,90,255) or Color3.fromRGB(255,50,50)
    local h = char:FindFirstChild("esp_highlight")
    if not h then
        h = create_highlight(char, col)
        h.Name = "esp_highlight"
    else
        h.FillColor = col
        h.OutlineColor = col
    end

    local b = head:FindFirstChild("esp_label")

    if not b then
        b = create_label(head, is_it and "IT/Seeker" or plr.Name, col)
    else
        local t = b:FindFirstChild("TextLabel")
        if t then
            t.Text = is_it and "IT/Seeker" or plr.Name
            t.TextColor3 = col
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.2)

        if getgenv().player_esp then
            local it_name = tostring(It_Val.Value)

            for _, plr in ipairs(players:GetPlayers()) do
                if plr ~= local_plr then
                    apply_esp(plr, it_name)
                end
            end
        else
            for _, plr in ipairs(players:GetPlayers()) do
                if plr.Character then
                    clear_esp(plr.Character)
                end
            end
        end
    end
end)

local Game_Objects = Workspace:FindFirstChild("GameObjects") or Workspace:WaitForChild("GameObjects", 10)
local Player_Data = getgenv().LocalPlayer:FindFirstChild("PlayerData", true) or LocalPlayer:WaitForChild("PlayerData", 10)
local It_LocalPlr_Value = Player_Data and Player_Data:FindFirstChild("It", true) or Player_Data:WaitForChild("It", 5)
local InGame_LocalPlr_Value = Player_Data and Player_Data:FindFirstChild("InGame", true) or Player_Data:WaitForChild("InGame", 5)
local Is_Seeking = Game_Data and Game_Data:FindFirstChild("ItSeeking", true) or Game_Data:WaitForChild("ItSeeking", 5)
local Selecting_Map = Game_Data and Game_Data:FindFirstChild("SelectingMap", true) or Game_Data:WaitForChild("SelectingMap", 5)
local Selecting_It = Game_Data and Game_Data:FindFirstChild("SelectingIt", true) or Game_Data:WaitForChild("SelectingIt", 5)
local Showing_EndGame_GUI = Game_Data and Game_Data:FindFirstChild("ShowingEndGameGui", true) or Game_Data:WaitForChild("ShowingEndGameGui", 5)
local Total_Hiders = Game_Data and Game_Data:FindFirstChild("StartingAmountOfHiders", true) or Game_Data:WaitForChild("StartingAmountOfHiders", 5)
local Stopping_Game = Game_Data and Game_Data:FindFirstChild("StoppingGame", true) or Game_Data:WaitForChild("StoppingGame", 5)
local Map_Selection = Game_Data and Game_Data:FindFirstChild("MapSelection", true) or Game_Data:WaitForChild("MapSelection", 5)
local Chosen_Map = Map_Selection and Map_Selection:FindFirstChild("NameLabelValue", true) or Map_Selection:WaitForChild("NameLabelValue", 5)
local Animation_Replication = ReplicatedStorage:FindFirstChild("AnimationReplication", true) or ReplicatedStorage:WaitForChild("AnimationReplication", 5)
local Place_Glue_RE = Animation_Replication and Animation_Replication:FindFirstChild("PlaceGlue", true) or Animation_Replication:WaitForChild("PlaceGlue", 5)
local Play_Sound_Boombox_RE = Animation_Replication and Animation_Replication:FindFirstChild("PlaySoundBoombox", true) or Animation_Replication:WaitForChild("PlaySoundBoombox", 5)
local Stop_Sound_Boombox_FE = Animation_Replication and Animation_Replication:FindFirstChild("StopSoundBoombox", true) or Animation_Replication:WaitForChild("StopSoundBoombox", 5)
wait(0.2)
function find_all_players_no_whitelist()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = get_char(player) or player.Character
            local myChar = getgenv().Character or get_char(LocalPlayer or game.Players.LocalPlayer) or game.Players.LocalPlayer.Character
            if char and myChar and char:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
                myChar:PivotTo(char.HumanoidRootPart.CFrame + Vector3.new(0, 1.5, 0))
                task.wait(0.1)
            end
        end
    end
end

function find_all_players_whitelist()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not WHITELIST[player.Name] then
            local char = get_char(player) or player.Character
            local myChar = getgenv().Character or get_char(LocalPlayer or game.Players.LocalPlayer) or game.Players.LocalPlayer.Character
            if char and myChar and char:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart") then
                myChar:PivotTo(char.HumanoidRootPart.CFrame + Vector3.new(0, 1.5, 0))
                task.wait(0.1)
            end
        end
    end
end

function on_char_added(player, char)
    if not getgenv().FindingAllNonWhitelistedPlayers then return end
    if not (InGame_LocalPlr_Value and InGame_LocalPlr_Value.Value) then return end
    if player == LocalPlayer then return end
    if WHITELIST[player.Name] then return end

    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end

    local myChar = getgenv().Character or get_char(LocalPlayer) or LocalPlayer.Character
    if not myChar then return end

    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return end

    myChar:PivotTo(hrp.CFrame + Vector3.new(0, 1.5, 0))
end

function connect_player(player)
    player.CharacterAdded:Connect(function(char)
        on_char_added(player, char)
    end)
end

getgenv().player_connect_init = getgenv().player_connect_init or false

if not getgenv().player_connect_init then
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if getgenv().FindingAllNonWhitelistedPlayers then
                connect_player(plr)
            end
        end
    end

    Players.PlayerAdded:Connect(function(plr)
        if plr ~= LocalPlayer then
            if getgenv().FindingAllNonWhitelistedPlayers then
                connect_player(plr)
            end
        end
    end)
    wait(0.2)
    getgenv().player_connect_init = true
end

local Remotes = getgenv().ReplicatedStorage:FindFirstChild("Remotes", true) or ReplicatedStorage:WaitForChild("Remotes", 5)
local Play_Sound_Others_RE = Remotes and Remotes:FindFirstChild("PlaySoundOthers") or Remotes:WaitForChild("PlaySoundOthers", 5)
local espTransparency = 0.3
local RunService = getgenv().RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer or game.Players.LocalPlayer

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function safe_spot_tp()
    local Lobby = ws:FindFirstChild("Lobby") or ws:WaitForChild("Lobby", 10)
    local Base_Plate

    if not Lobby then
        return getgenv().notify("Error", "Lobby was not found inside of Workspace (game updated?).", 7)
    end
    
    for _, v in pairs(Lobby:GetChildren()) do
        if v:IsA("BasePart") and v.CanCollide == false then
            v.CanCollide = true
        end
    end

    for _, v in pairs(Lobby:GetChildren()) do
        if v:IsA("BasePart") and v.Name == "BasePlate" and v.BrickColor == BrickColor.new("Ghost grey") then
            Base_Plate = v
        end
    end
    wait(0.3)
    HumanoidRootPart.CFrame = CFrame.new(Base_Plate.Position + Vector3.new(0, 3, 0))
end

getgenv().toggle_spawn_box_visible = getgenv().toggle_spawn_box_visible or false

function toggle_visible_spawn_box(state)
    local ws = getgenv().Workspace or (cloneref and cloneref(game:GetService("Workspace"))) or workspace
    local Lobby = ws:FindFirstChild("Lobby") or ws:WaitForChild("Lobby", 10)

    if not Lobby or not Lobby:IsA("Model") then
        return getgenv().notify("Error", "Lobby was not found inside of Workspace (game updated?).", 7)
    end

    local visible
    if typeof(state) == "boolean" then
        visible = state
        getgenv().toggle_spawn_box_visible = state
    else
        getgenv().toggle_spawn_box_visible = not getgenv().toggle_spawn_box_visible
        visible = getgenv().toggle_spawn_box_visible
    end

    local new_trans = visible and 0 or 1

    for _, v in ipairs(Lobby:GetChildren()) do
        if v:IsA("BasePart") and v.Transparency ~= new_trans then
            v.Transparency = new_trans
        end
    end

    if getgenv().notify then
        getgenv().notify("Success", "Lobby parts are now: "..(visible and "VISIBLE" or "INVISIBLE"), 5)
    end
end

local main_volume_sound_others = 3
getgenv().main_volume_sound_others = getgenv().main_volume_sound_others or 3
wait(0.2)
function play_music_others(ID)
    for _, v in ipairs(getgenv().Players:GetChildren()) do
        if v ~= getgenv().LocalPlayer then
            local main_target_plr = v or game.Players:FindFirstChild(v.Name)
            local Target_Char = get_char(main_target_plr) or main_target_plr.Character
            local Target_HRP = get_root(main_target_plr) or Target_Char:FindFirstChild("HumanoidRootPart")
            if not Target_Char then return getgenv().notify("Error", "Player's Character does not exist!", 5) end
            if not Target_HRP then return getgenv().notify("Error", "Player's HumanoidRootPart is missing!", 5) end
            
            if Play_Sound_Others_RE and Play_Sound_Others_RE:IsA("RemoteEvent") then
                local args = {
                    tonumber(ID),
                    {
                        Parent = Target_HRP,
                        Pitch = 1,
                        Volume = tonumber(main_volume_sound_others)
                    }
                }

                Play_Sound_Others_RE:FireServer(unpack(args))
            elseif Play_Sound_Others_RE and Play_Sound_Others_RE:IsA("RemoteFunction") then
                local args = {
                    tonumber(ID),
                    {
                        Parent = Target_HRP,
                        Pitch = 1,
                        Volume = tonumber(main_volume_sound_others)
                    }
                }

                Play_Sound_Others_RE:InvokeServer(unpack(args))
                getgenv().notify("Warning", "PlaySoundOthers exists but isn't a RemoteEvent, it's a RemoteFunction, gonna try again.", 10)
            else
                return getgenv().notify("Error", "PlaySoundOthers either doesn't exist or isn't a RemoteEvent/RemoteFunction.", 10)
            end
        end
    end
end

local function is_player_it(p)
	return It_Val and (It_Val.Value == p or It_Val.Value == p.Name)
end

local Is_On_Cooldown = false
local Cooldown_Time = 30
local Cooldown_End_Time = 0

function read_it_chance()
    local t = getgenv().PlayerGui.MainGui.ItSelectionFrame.ChanceLabel.Text
    local n = t:match("(%d+%.?%d*)%%")
    return tonumber(n) or 0
end

function weighted_pick(plrs, my_plr)
    local myc = read_it_chance()
    local c = #plrs
    local total = 100
    local other = math.max(0, total - myc)
    local per = c > 1 and (other / (c - 1)) or 0
    local tbl = {}
    for _,v in ipairs(plrs) do
        if v == my_plr then
            table.insert(tbl,{plr=v,w=myc})
        else
            table.insert(tbl,{plr=v,w=per})
        end
    end
    local s = 0
    for _,v in ipairs(tbl) do s += v.w end
    local r = math.random() * s
    for _,v in ipairs(tbl) do
        r -= v.w
        if r <= 0 then return v.plr end
    end
    return plrs[1]
end

function prediction_confidence(plrs, predicted, my_plr)
    local myc = read_it_chance()
    local c = #plrs
    local total = 100
    local other = math.max(0, total - myc)
    local per = c > 1 and (other / (c - 1)) or 0
    if predicted == my_plr then return myc end
    return per
end

function Try_To_predict_IT_Plr()
    local LocalPlayer = getgenv().LocalPlayer
    if Is_On_Cooldown then
        local t = math.ceil(Cooldown_End_Time - tick())
        if t < 1 then t = 1 end
        return getgenv().notify("Warning", "You are on prediction cooldown ("..t.." seconds left).", 10)
    end
    Is_On_Cooldown = true
    Cooldown_End_Time = tick() + Cooldown_Time

    local function mk_gui()
        local s = Instance.new("ScreenGui", getgenv().PlayerGui)
        s.Name = "IT_Predictor_GUI"
        s.ResetOnSpawn = false
        local f = Instance.new("Frame",s)
        f.Size = UDim2.new(0,700,0,340)
        f.Position = UDim2.new(0.5,0,0.5,0)
        f.AnchorPoint = Vector2.new(0.5,0.5)
        f.BackgroundColor3 = Color3.fromRGB(30,30,30)
        f.BackgroundTransparency = 0.05
        f.BorderSizePixel = 0
        local cr = Instance.new("UICorner",f)
        cr.CornerRadius = UDim.new(0,26)
        local l = Instance.new("TextLabel",f)
        l.Size = UDim2.new(1,0,1,0)
        l.TextScaled = true
        l.BackgroundTransparency = 1
        l.TextColor3 = Color3.fromRGB(255,255,255)
        l.Font = Enum.Font.GothamBold
        l.Text = "Rolling Dice..."
        return s,l
    end

    local plrs = Players:GetPlayers()
    local g,l = mk_gui()

    for i=1,15 do
        local r = plrs[math.random(1,#plrs)]
        l.Text = "🎲 "..tostring(r.DisplayName).." 🎲"
        wait(0.1 + i*0.01)
    end

    local final = weighted_pick(plrs,LocalPlayer)
    local conf = prediction_confidence(plrs,final,LocalPlayer)
    local pct = string.format("%.2f",conf)

    if final then
        l.Text = "🎯 Predicted IT: "..tostring(final.DisplayName).."  ("..pct.."%) 🎯"
    else
        l.Text = "⚠️ Prediction Failed ⚠️"
    end

    task.delay(3,function()
        if g then g:Destroy() end
    end)

    task.delay(Cooldown_Time,function()
        Is_On_Cooldown = false
    end)
end

local players = Players
local run_service = game:GetService("RunService")
local local_player = players.LocalPlayer

local function is_it(p)
    return is_player_it and is_player_it(p)
end

function pivot_to_plr(Player)
    if not Player then return end

    local Targets_Char = get_char(Player) or Player.Character

    if Targets_Char and Targets_Char:FindFirstChild("Humanoid") then
        Character:PivotTo(Targets_Char:GetPivot())
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

getgenv().autocoin_conn = nil
getgenv().autocoin_lastcf = nil

function collect_all_coins(method)
    if method == "no_tp" then
        if not firetouchinterest then
            return getgenv().notify("Error", "Your exploit does not support 'firetouchinterest'!", 6)
        end

        for _, obj in Game_Objects:GetDescendants() do
            if obj.Name == "Credit" or obj:FindFirstChildOfClass("TouchTransmitter") then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    firetouchinterest(HumanoidRootPart, part, 0) task.wait()
                    firetouchinterest(HumanoidRootPart, part, 1)
                end
            end
        end
    elseif method == "teleport" then
        for _, v in pairs(Game_Objects:GetChildren()) do
            if v:IsA("BasePart") and v.Name:lower():find("credit") then
                wait(0.1)
                Character:PivotTo(v:GetPivot())
            end
        end
    else
        return getgenv().notify("Error", "Invalid argument specified when calling function.", 6)
    end
end

local function autocoin_handle()
    local val

    if Game_Data and Game_Data:FindFirstChild("GameRunning") then
        val = Game_Data:FindFirstChild("GameRunning").Value
    else
        val = InGame_LocalPlr_Value.Value
    end

    if val == true then
        local char = getgenv().Character or get_char(LocalPlayer) or LocalPlayer.Character
        local hrp = get_root(LocalPlayer) or getgenv().HumanoidRootPart or char:FindFirstChild("HumanoidRootPart")
        if not hrp then return getgenv().notify("Error", "HumanoidRootPart missing (try resetting).", 5) end
        getgenv().autocoin_lastcf = hrp.CFrame
        task.wait(0.1)
        collect_all_coins("no_tp")
        task.wait(0.15)
        if getgenv().autocoin_lastcf then
            hrp.CFrame = getgenv().autocoin_lastcf
        end
        getgenv().autocoin_lastcf = nil
    else
        task.wait(0.7)
        if getgenv().autocoin_lastcf then
            local char = getgenv().Character or get_char(LocalPlayer) or LocalPlayer.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = getgenv().autocoin_lastcf
            end
        end
        getgenv().autocoin_lastcf = nil
    end
end

local function handle_in_game_changed()
    if Game_Data and Game_Data:FindFirstChild("GameRunning").Value == true then
        task.wait(0.1)
        collect_all_coins("no_tp")
    end
end

getgenv().Current_ID = getgenv().Current_ID or 0
wait(0.2)
getgenv().Main_Audio_Input = Audio:Box("Music (FE):", function(text, focuslost)
    if focuslost then
        local id = tonumber(text)
        getgenv().Current_ID = id
    end
end)

getgenv().Main_Audio_Input:Set(getgenv().Current_ID or 0)
getgenv().new_boombox_main_volume = getgenv().new_boombox_main_volume or 0.5
getgenv().boombox_sound = nil

local function find_boombox()
    local root = getgenv().HumanoidRootPart or get_root(LocalPlayer)
    if not root then return end

    for _, v in ipairs(root:GetChildren()) do
        if v:IsA("Sound") and v.Name:lower():find("boombox") then
            return v
        end
    end
end

local function does_boombox_sound_exist()
    local root = getgenv().HumanoidRootPart or get_root(LocalPlayer)
    if not root then
        return false
    end

    for _, v in ipairs(root:GetChildren()) do
        if v:IsA("Sound") and v.Name:lower():find("boombox") then
            return v
        end
    end

    return false
end

local function is_playing_music()
    local root_part = getgenv().HumanoidRootPart or get_root(LocalPlayer) or getgenv().Character:FindFirstChild("HumanoidRootPart")

    for _, v in ipairs(root_part:GetChildren()) do
        if v:IsA("Sound") and v.Name:lower():find("boombox") then
            if v.Playing then
                return true
            end
        end
    end

    return nil
end

task.spawn(function()
    while true do
        task.wait(0.2)

        local bb = find_boombox()
        if bb and bb ~= getgenv().boombox_sound then
            getgenv().boombox_sound = bb
            bb.Volume = getgenv().new_boombox_main_volume
        end
    end
end)

Audio:Slider("Boombox Vol",0,10,tonumber(getgenv().new_boombox_main_volume) or 0.5,function(newv)
    getgenv().new_boombox_main_volume = newv
    if getgenv().boombox_sound then
        getgenv().boombox_sound.Volume = newv
    end
end)

Audio:Button("Play Music (FE)", function()
    local sound = find_boombox()
    if sound and sound.Playing then
        return getgenv().notify("Warning", "You're already playing music!", 5)
    end

    local ok, response = pcall(function()
        Play_Sound_Boombox_RE:FireServer(Current_ID)
    end)

    if not ok then
        return getgenv().notify("Error", "Error playing song: "..tostring(response), 15)
    end

    task.delay(0.2, function()
        local updated = does_boombox_sound_exist()
        if updated then
            updated.Volume = getgenv().new_boombox_main_volume
            getgenv().notify("Success", "Now playing: "..tostring(Current_ID), 5)
        end
    end)
end)

Audio:Button("Stop Music", function()
    Stop_Sound_Boombox_FE:FireServer()
end)

Extras:Button("Get Coins (No TP)", function()
    local result_parts = count_parts(Game_Objects)

    if result_parts == false then
        return getgenv().notify("Error", "GameObjects doesn't exist, try again!", 5)
    elseif result_parts == 0 then
        return getgenv().notify("Error", "No Credit's found to collect!", 5)
    elseif result_parts > 0 then
        collect_all_coins("no_tp")
    end
end)

Extras:Button("Get Coins (TP)", function()
    local result_parts = count_parts(Game_Objects)

    if result_parts == false then
        return getgenv().notify("Error", "GameObjects doesn't exist, try again!", 5)
    elseif result_parts == 0 then
        return getgenv().notify("Error", "No Credit's found to collect!", 5)
    elseif result_parts > 0 then
        local Old_CF = Character:FindFirstChild("HumanoidRootPart").CFrame
        wait(0.2)
        collect_all_coins("teleport")
        wait(0.3)
        HumanoidRootPart.CFrame = Old_CF
    end
end)

Extras:Toggle("Auto Get Coins", getgenv().AutoCollectingCoins_Fast or false, function(state)
    if state then
        if getgenv().autocoin_conn then
            pcall(function() getgenv().autocoin_conn:Disconnect() end)
        end
        if getgenv().autocoin_conn2 then
            pcall(function() getgenv().autocoin_conn2:Disconnect() end)
        end
        getgenv().AutoCollectingCoins_Fast = true

        local gamerunning_flag = Game_Data:FindFirstChild("GameRunning")
        local selecting_it_flag = Game_Data:FindFirstChild("SelectingIt")
        local selecting_map_flag = Game_Data:FindFirstChild("SelectingMap")

        if gamerunning_flag.Value == true then
            autocoin_handle()
        end

        getgenv().autocoin_conn = gamerunning_flag.Changed:Connect(function(v)
            if v == true then
                autocoin_handle()
            end
        end)

        getgenv().autocoin_conn2 = selecting_it_flag.Changed:Connect(function(v)
            if v == true and selecting_map_flag.Value == false then
                collect_all_coins("no_tp")
            end
        end)
    else
        if getgenv().autocoin_conn then
            pcall(function() getgenv().autocoin_conn:Disconnect() end)
        end
        if getgenv().autocoin_conn2 then
            pcall(function() getgenv().autocoin_conn2:Disconnect() end)
        end
        getgenv().AutoCollectingCoins_Fast = false
        getgenv().autocoin_conn = nil
        getgenv().autocoin_conn2 = nil
        getgenv().autocoin_lastcf = nil
    end
end)

function handle_autoplay()
    task.wait(0.3)

    local result_parts = count_parts(Game_Objects)

    if result_parts == false then
        return getgenv().notify("Error", "GameObjects doesn't exist, try again!", 5)
    elseif result_parts == 0 then
        safe_spot_tp()
        return
    elseif result_parts > 0 then
        collect_all_coins("no_tp")
        task.wait(0.6)

        local new_count = count_parts(Game_Objects)
        if new_count == 0 then
            safe_spot_tp()
        end
    end
end

Extras:Toggle("Auto Play (FE)", getgenv().AutoPlaying_Game or false, function(auto_playing)
    if auto_playing then
        if getgenv().autoplay_conn then pcall(function() getgenv().autoplay_conn:Disconnect() end) end
        local gamerunning_flag = Game_Data:FindFirstChild("GameRunning")
        getgenv().AutoPlaying_Game = true

        if gamerunning_flag.Value == true then
            handle_autoplay()
        end

        getgenv().autoplay_conn = gamerunning_flag.Changed:Connect(function(v)
            if v == true then
                handle_autoplay()
            end
        end)
    else
        if getgenv().autoplay_conn then
            pcall(function() getgenv().autoplay_conn:Disconnect() end)
        end
        getgenv().AutoPlaying_Game = false
        getgenv().autoplay_conn = nil
    end
end)

Main:Box("Whitelist:", function(target_whitelist, focuslost)
    if not focuslost then return end
    if not target_whitelist or target_whitelist == "" then
        return getgenv().notify("Error", "You must type a player name!", 5)
    end

    local target = findplr(target_whitelist)

    if target then
        add_whitelist_plr(target)
    else
        getgenv().notify("Error", target_whitelist.." does not exist!", 5)
    end
end)

Main:Box("Unwhitelist:", function(target_remove_whitelist, focuslost)
    if not focuslost then return end
    if not target_remove_whitelist or target_remove_whitelist == "" then
        return getgenv().notify("Error", "You must type a player name!", 5)
    end

    local target_unwhitelist = findplr(target_remove_whitelist)

    if target_unwhitelist then
        remove_whitelist_plr(target_unwhitelist)
    else
        getgenv().notify("Error", target_remove_whitelist.." does not exist!", 5)
    end
end)

Main:Button("Find All (No Whitelist)", function()
    if not InGame_LocalPlr_Value.Value then
        return getgenv().notify("Error", "You are not currently in-game!", 5)
    end
    if not It_LocalPlr_Value.Value then
        return getgenv().notify("Error", "You are not the IT/seeker!", 5)
    end

    task.wait(0.1)
    find_all_players_no_whitelist()
end)

Main:Button("Find All (Whitelist)", function()
    if not InGame_LocalPlr_Value.Value then
        return getgenv().notify("Error", "You are not currently in-game!", 5)
    end

    if not It_LocalPlr_Value.Value then
        return getgenv().notify("Error", "You are not the IT/seeker!", 5)
    end
    task.wait(0.1)
    find_all_players_whitelist()
end)

Main:Toggle("Find All (Loop)", false, function(state)
    if state then
        getgenv().FindingAllNonWhitelistedPlayers = true
        getgenv().FindAllConnections = {}

        for _, plr in ipairs(Players:GetPlayers()) do
            connect_player(plr)
        end

        local joinConn = Players.PlayerAdded:Connect(function(plr)
            connect_player(plr)
        end)

        table.insert(getgenv().FindAllConnections, joinConn)
    else
        getgenv().FindingAllNonWhitelistedPlayers = false
        if getgenv().FindAllConnections then
            for _, c in ipairs(getgenv().FindAllConnections) do
                pcall(function() c:Disconnect() end)
            end
        end
        getgenv().FindAllConnections = nil
    end
end)

Players_Tab:Toggle("Timer Flasher", false, function(flashing)
    if flashing then
        local TimerFolder = ReplicatedStorage:FindFirstChild("Timer", true) or ReplicatedStorage:WaitForChild("Timer", 5)
        if not TimerFolder then
            getgenv().FlashTimer = false
            return getgenv().notify("Error", "TimerFolder was not found inside ReplicatedStorage.", 5)
        end
        local TimeVisible = TimerFolder and TimerFolder:FindFirstChild("TimeVisible", true) or TimerFolder:WaitForChild("TimeVisible", 5)
        if not TimeVisible then
            getgenv().FlashTimer = false
            return getgenv().notify("Error", "TimeVisible was not found inside TimerFolder.", 5)
        end
        local Time = TimerFolder:FindFirstChild("Time", true) or TimerFolder:WaitForChild("Time", 5)
        if not Time then
            getgenv().FlashTimer = false
            return getgenv().notify("Error", "Time was not found inside TimerFolder.", 5)
        end

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
        local TimerFolder = ReplicatedStorage:FindFirstChild("Timer", true) or ReplicatedStorage:WaitForChild("Timer", 5)
        if not TimerFolder then
            return getgenv().notify("Error", "TimerFolder was not found inside ReplicatedStorage.", 5)
        end
        local TimeVisible = TimerFolder and TimerFolder:FindFirstChild("TimeVisible", true) or TimerFolder:WaitForChild("TimeVisible", 5)
        if not TimeVisible then
            return getgenv().notify("Error", "TimeVisible was not found inside TimerFolder.", 5)
        end

        TimeVisible.Value = true
    end
end)

Players_Tab:Button("Whos IT", function()
    local stored = tostring(It_Val.Value)
    local plr = players:FindFirstChild(stored)

    if plr then
        getgenv().notify("Success", "Name: "..plr.Name.." | DisplayName: "..tostring(plr.DisplayName), 10)
    else
        getgenv().notify("Error", "Nobody seems to be it, got result: "..tostring(stored).." with found result: "..tostring(plr), 15)
    end
end)

Main:Button("Safe Spot TP", function()
    safe_spot_tp()
end)

Players_Tab:Button("View Self", function()
    local Cur_Camera = getgenv().Camera or getgenv().Workspace.CurrentCamera or workspace.CurrentCamera

    Cur_Camera.CameraSubject = getgenv().Character or getgenv().Humanoid or get_char(LocalPlayer or game.Players.LocalPlayer) or get_human(LocalPlayer or game.Players.LocalPlayer) or game.Players.LocalPlayer.Character
end)

Players_Tab:Button("View IT", function()
    local Cur_Camera = getgenv().Camera or getgenv().Workspace.CurrentCamera or workspace.CurrentCamera
    local stored = tostring(It_Val.Value)
    local plr = players:FindFirstChild(stored)
    local their_char = plr.Character or get_human(plr) or get_char(plr)

    if plr and their_char then
        Cur_Camera.CameraSubject = their_char
    end
end)

Players_Tab:Toggle("Player ESP", getgenv().player_esp or false, function(state)
    getgenv().player_esp = state
end)

Extras:Toggle("Visible Spawn", getgenv().toggle_spawn_box_visible or false, function(is_spawn_visible)
    if is_spawn_visible then
        toggle_visible_spawn_box(true)
    else
        toggle_visible_spawn_box(false)
    end
end)

Players_Tab:Slider("WalkSpeed",16,500,16, function(WalkSpeed)
    pcall(function()
        getgenv().Humanoid.WalkSpeed = WalkSpeed
    end)
end)

Players_Tab:Slider("JumpPower",50,500,50, function(New_JP)
    if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
        pcall(function()
            getgenv().Humanoid.JumpPower = New_JP
        end)
    else
        pcall(function()
            getgenv().Humanoid.JumpHeight = New_JP
        end)
    end
end)

Players_Tab:Slider("Gravity",0,300,196, function(New_Gravity)
    getgenv().Workspace.Gravity = New_Gravity
end)

Players_Tab:Slider("FOV",0,120,math.floor((getgenv().Camera.FieldOfView or 70)+0.5), function(new_fov)
    new_fov = math.floor(new_fov)
    local camera_current = getgenv().Camera or getgenv().Workspace.CurrentCamera or workspace.CurrentCamera
    camera_current.FieldOfView = new_fov
end)

Players_Tab:Box("Goto Plr:", function(Target)
    local Player_To_Teleport_To = findplr(Target)

    if not Player_To_Teleport_To then return end

    pivot_to_plr(Player_To_Teleport_To)
end)

Extras:Toggle("Rainbow Timer", getgenv().RainbowText or false, function(rainbow_timer_text)
    if rainbow_timer_text then
        local TweenService = getgenv().TweenService
        local RunService = getgenv().RunService

        local Main_GUI = getgenv().PlayerGui:FindFirstChild("MainGui", true)
        if not Main_GUI then return getgenv().notify("Error", "MainGui doesn't exist in PlayerGui!", 5) end
        local Timer_Frame = Main_GUI and Main_GUI:FindFirstChild("TimerFrame") or Main_GUI:WaitForChild("TimerFrame", 5)
        if not Timer_Frame then return getgenv("Error", "TimerFrame doesn't exist in MainGui!", 5) end
        local Time_TextLabel = Timer_Frame and Timer_Frame:FindFirstChild("Time", true) or Timer_Frame:WaitForChild("Time", 5)
        if not Time_TextLabel then return getgenv().notify("Error", "Timer TextLabel doesn't exist in Timer_Frame!", 5) end
        local TimerText_TextLabel = Timer_Frame and Timer_Frame:FindFirstChild("TimerText", true) or Timer_Frame:WaitForChild("TimerText", 5)
        if not TimerText_TextLabel then return getgenv().notify("Error", "TimerText TextLabel was not found in Timer_Frame!", 5) end
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
        local Main_GUI = getgenv().PlayerGui:FindFirstChild("MainGui", true)
        if not Main_GUI then return getgenv().notify("Error", "MainGui doesn't exist in PlayerGui!", 5) end
        local Timer_Frame = Main_GUI and Main_GUI:FindFirstChild("TimerFrame") or Main_GUI:WaitForChild("TimerFrame", 5)
        if not Timer_Frame then return getgenv("Error", "TimerFrame doesn't exist in MainGui!", 5) end
        local Time_TextLabel = Timer_Frame and Timer_Frame:FindFirstChild("Time", true) or Timer_Frame:WaitForChild("Time", 5)
        if not Time_TextLabel then return getgenv().notify("Error", "Timer TextLabel doesn't exist in Timer_Frame!", 5) end
        local TimerText_TextLabel = Timer_Frame and Timer_Frame:FindFirstChild("TimerText", true) or Timer_Frame:WaitForChild("TimerText", 5)
        if not TimerText_TextLabel then return getgenv().notify("Error", "TimerText TextLabel was not found in Timer_Frame!", 5) end

        Time_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TimerText_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

Extras:Toggle("Rainbow UI", getgenv().Rainbow_Game_UI or false, function(rainbow_UI_frames)
    if rainbow_UI_frames then
        local RunService = getgenv().RunService
        local Main_GUI = getgenv().PlayerGui:FindFirstChild("MainGui", true)
        if not Main_GUI then return getgenv().notify("Error", "MainGui doesn't exist in PlayerGui!", 5) end
        local Shop_Frame = Main_GUI:FindFirstChild("ShopFrame", true) or Main_GUI:WaitForChild("ShopFrame", 5)
        if not Shop_Frame then return getgenv().notify("Error", "ShopFrame doesn't exist in MainGui!", 5) end

        wait(0.1)
        getgenv().Rainbow_Game_UI = true

        local elements = Shop_Frame:GetDescendants()
        local hue = 0

        coroutine.wrap(function()
            while getgenv().Rainbow_Game_UI do
                local color = Color3.fromHSV(hue, 1, 1)

                for _, uiObject in ipairs(elements) do
                    if uiObject:IsA("Frame") then
                        uiObject.BackgroundColor3 = color
                    elseif uiObject:IsA("TextLabel") or uiObject:IsA("TextButton") then
                        uiObject.BackgroundColor3 = color
                        uiObject.TextColor3 = color
                    elseif uiObject:IsA("ImageLabel") and uiObject.Name:lower():find("characterlabel") then
                        uiObject.BackgroundColor3 = color
                        uiObject.ImageColor3 = color
                    end
                end

                hue = hue + 0.01
                if hue > 1 then hue = 0 end

                task.wait(0.05)
            end
        end)()
    else
        getgenv().Rainbow_Game_UI = false
        wait(0.1)

        if not getgenv().OriginalColors or not next(getgenv().OriginalColors) then
            getgenv().OriginalColors = nil
            return
        end

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

Extras:Button("IY", function()
    if getgenv().IY_LOADED then
        return getgenv().notify("Error", "You've already loaded Infinite Yield.", 5)
    end
    if getgenv().GET_LOADED_IY then
        return getgenv().notify("Error", "You've already loaded Infinite Premium.", 5)
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

Audio:Slider("Sound Vol (FE)", 0.1,10,tonumber(getgenv().main_volume_sound_others) or 3, function(New_Vol)
    main_volume_sound_others = New_Vol
    getgenv().main_volume_sound_others = New_Vol
end)

local play_music_others_sound_id = 0

Audio:Box("Play Music", function(music_ID)
    play_music_others_sound_id = music_ID
    play_music_others(music_ID)
end)

Audio:Toggle("Play Music Loop", false, function(toggled)
    if toggled then
        getgenv().playing_sound_others_FE = true
        while getgenv().playing_sound_others_FE == true do
        task.wait(0.1)
            play_music_others(play_music_others_sound_id)
        end
    else
        getgenv().playing_sound_others_FE = false
    end
end)

if not low_level_exec then
    local market_mod = mods and mods:FindFirstChild("MarketplaceAPI", true) or mods:WaitForChild("MarketplaceAPI", 5)
    local req_market_mod = require(market_mod)
    g.market_api = req_market_mod
    wait(0.3)
    local market_stuff = {
        g.market_api.GamepassIds.Yeti,
        g.market_api.GamepassIds.Boombox,
        g.market_api.GamepassIds.TripleCoinValue,
        g.market_api.GamepassIds.ItChanceMultiplier
    }

    for _, product in ipairs(market_stuff) do
        g.market_api.SetCache(product, true)
    end
end
