if not game:IsLoaded() then
    game.Loaded:Wait()
end
repeat task.wait() until game.Players and game.Players.LocalPlayer

local Flames_API = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua"))()
local NotifyLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"
))()
local Workspace, VirtualUser, HttpService, AssetService, Players, SoundService, ReplicatedStorage, Teams, vc_internal, vc_service
local Script_Version = "V2.2.7-SWFL"
local g = getgenv()
getgenv().ConstantUpdate_Checker_Live = true

if getgenv().SouthwestFlorida_Hub_Executed then
    return 
end

getgenv().SouthwestFlorida_Hub_Executed = true

getgenv().notify = getgenv().notify or function(title, msg, dur)
   local fixed_title = format_title(title)

   NotifyLib:External_Notification(fixed_title, tostring(msg), tonumber(dur))
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

for _, name in ipairs({
    "Workspace",
    "VirtualUser",
    "HttpService",
    "AssetService",
    "Players",
    "SoundService",
    "ReplicatedStorage",
    "Teams",
    "VoiceChatInternal",
    "VoiceChatService"
}) do
    local service = Flames_API.Service(name)

    if name == "Workspace" then
        Workspace = service
    elseif name == "VirtualUser" then
        VirtualUser = service
    elseif name == "HttpService" then
        HttpService = service
    elseif name == "AssetService" then
        AssetService = service
    elseif name == "Players" then
        Players = service
    elseif name == "SoundService" then
        SoundService = service
    elseif name == "ReplicatedStorage" then
        ReplicatedStorage = service
    elseif name == "Teams" then
        Teams = service
    elseif name == "VoiceChatInternal" then
        vc_internal = service
    elseif name == "VoiceChatService" then
        vc_service = service
    end
end

if not Players then
    Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players") or game.Players
end

if not g.LocalPlayer then
    g.LocalPlayer = Players.LocalPlayer
end
local LocalPlayer = g.LocalPlayer or game.Players.LocalPlayer

g.get_char = g.get_char or function(Player)
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
if not g.get_human then
    g.get_human = function(Player)
        local char = g.get_char(Player)
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

if not g.get_root then
    g.get_root = function(Player)
        local char = g.get_char(Player)
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

if not g.get_head then
    g.get_head = function(Player)
        local char = g.get_char(Player)
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

wait(0.1)
g.Service_Wrap = g.Service_Wrap or function(name)
    name = tostring(name)

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

local special_colors = {
    {167.00000524520874, 42.000001296401024, 43.00000123679638},
    {213.00000250339508, 213.00000250339508, 213.00000250339508},
    {57.00000040233135, 64.00000378489494, 72.00000330805779},
    {0, 0, 0},
    {14.000000115484, 75.00000312924385, 130.0000074505806},
}

local function lerp(a, b, t)
    return a + (b - a) * t
end

local function generate_steps(from, to, steps)
    local out = {}
    for i = 0, steps do
        local t = i / steps
        table.insert(out, {
            lerp(from[1], to[1], t),
            lerp(from[2], to[2], t),
            lerp(from[3], to[3], t),
        })
    end
    return out
end

getgenv().free_colors = getgenv().free_colors or {}

for i = 1, #special_colors do
    local a = special_colors[i]
    local b = special_colors[(i % #special_colors) + 1]
    local steps = generate_steps(a, b, 20)
    for _, c in ipairs(steps) do
        table.insert(getgenv().free_colors, c)
    end
end

local colors = {
    {0,0,0},
    {87.00000241398811,53.00000064074993,115.00000074505806},
    {194.00000363588333,0,36.00000165402889},
    {229.00000154972076,233.00000131130219,229.00000154972076},
    {227.00000166893005,91.00000217556953,1.0000000591389835},
    {137.00000703334808,1.0000000591389835,1.0000000591389835},
    {232.00000137090683,232.00000137090683,232.00000137090683},
    {33.00000183284283,75.00000312924385,152.0000061392784},
    {103.0000014603138,106.00000128149986,111.00000098347664},
    {255,0,225.8773899078369},
    {83.81617605686188,255,0},
    {254.2897117137909,255,0},
}

local function find_RE(name, place)
    name = name:lower()

    if not place then
        place = game.ReplicatedStorage
    end

    local function scan_for_re(obj)
        for _, v in ipairs(obj:GetChildren()) do
            if v:IsA("RemoteEvent") and v.Name:lower():find(name) then
                return v
            end

            local found = scan_for_re(v)
            if found then
                return found
            end
        end
    end

    return scan_for_re(place)
end

local function find_RF(name, place)
    name = name:lower()

    if not place then
        place = game.ReplicatedStorage
    end

    local function scan_for_rf(obj)
        for _, v in ipairs(obj:GetChildren()) do
            if v:IsA("RemoteFunction") and v.Name:lower():find(name) then
                return v
            end

            local found = scan_for_rf(v)
            if found then
                return found
            end
        end
    end

    return scan_for_rf(place)
end

local function get_FE_ColorPart(vehicle)
    if not vehicle then return nil end

    local propFE = vehicle:FindFirstChild("Prop_FE", true)
    if not propFE then return nil end

    for _, v in ipairs(vehicle:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("color") then
            return v, propFE
        end
    end

    return nil, propFE
end

local function find_folder(name, place)
    name = tostring(name):lower()
    place = place or workspace

    local function scan(obj)
        for _, v in ipairs(obj:GetChildren()) do
            if v:IsA("Folder") and v.Name:lower():find(name) then
                return v
            end
            local found = scan(v)
            if found then
                return found
            end
        end
    end

    return scan(place)
end

function low_level_executor()
    if executor_Name == "Solara" or string.find(executor_Name, "JJSploit") or executor_Name == "Xeno" then
        return true
    else
        return false
    end
end

local WAIT = wait
local Wait = wait
local Cars = find_folder("Cars")
local Player_Cars = find_folder("PlayerCars", ReplicatedStorage or game.ReplicatedStorage)
local loadCharRemote = find_RE("loadChar")
local TeamEvent = find_RE('TeamEvent')
local SpawnCar = find_RE('SpawnCar')
local Settings_Remote = find_RE("settings")
local Song_Control_Event = find_RE("songcontrol")
local LocalPlayer = g.LocalPlayer or game.Players.LocalPlayer
local Character = get_char(LocalPlayer)
local Humanoid = get_human(LocalPlayer)
local Head = get_head(LocalPlayer)
local HumanoidRootPart = get_root(LocalPlayer)
local PlayerGui = g.PlayerGui or Flames_API.PlayerGui
local PlayerScripts = LocalPlayer:FindFirstChildOfClass('PlayerScripts') or LocalPlayer:WaitForChild("PlayerScripts", 5)
local GC = getconnections or get_signal_cons

get_or_set("SoundService", g.SoundService or cloneref and cloneref(game:GetService("SoundService")) or game:GetService("SoundService"))

http_req = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

if not getgenv().GunModsSecureBypassInitialized then
    local function try_hookfunction()
        if not hookfunction then
            return false
        end

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Modules = ReplicatedStorage:WaitForChild("Modules")
        local RemoteHandler = require(Modules:WaitForChild("RemoteHandler"))

        local RemoteHandler__Fire; RemoteHandler__Fire = hookfunction(RemoteHandler.Fire, function(name, ...)
            if name == "SecureSettings" then
                return
            end
            return RemoteHandler__Fire(name, ...)
        end)

        return true
    end

    local function try_getgc()
        if not getgc or not debug or not debug.getinfo then
            return false
        end

        local targets = { "RemoteHandler" }
        local found_table

        for _, target in ipairs(targets) do
            for _, obj in ipairs(getgc(true)) do
                if typeof(obj) == "table" then
                    local any_func
                    for _, v in pairs(obj) do
                        if typeof(v) == "function" then
                            any_func = v
                            break
                        end
                    end

                    if any_func then
                        local info = debug.getinfo(any_func)
                        if info and info.source and info.source:find(target) then
                            found_table = obj
                            break
                        end
                    end
                end
            end
            if found_table then break end
        end

        if not found_table then
            return false
        end

        if typeof(found_table.Fire) == "function" then
            found_table.Fire = function(...)
                return
            end
        end

        if typeof(found_table.Invoke) == "function" then
            found_table.Invoke = function(...)
                return
            end
        end

        return true
    end

    local function try_mt_hook()
        if not getrawmetatable or not setreadonly then
            return false
        end

        local meta = getrawmetatable(game)
        if not meta then
            return false
        end

        local backup = meta.__namecall

        setreadonly(meta, false)

        local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
        local target_remote = remotes:FindFirstChild("SecureSettings")

        meta.__namecall = function(self, ...)
            local method = getnamecallmethod()

            if self == target_remote and (method == "FireServer" or method == "InvokeServer") then
                return
            end

            return backup(self, ...)
        end

        setreadonly(meta, true)

        return true
    end

    if not try_hookfunction() and not try_getgc() then
        try_mt_hook()
    end

    getgenv().GunModsSecureBypassInitialized = true
end

local function footstep_sounds()
    if not SoundService then
        getgenv().notify("Error", "SoundService not found.", 5)
        return nil
    end

    for _, v in ipairs(SoundService:GetDescendants()) do
        if v:IsA("SoundGroup") and v.Name:lower():find("foot") then
            return v
        end
    end

    return nil
end

wait()
getgenv().All_Teams = getgenv().All_Teams or {}

for _, team in pairs(Teams:GetChildren()) do
    table.insert(getgenv().All_Teams, team.Name)
end
wait(0.3)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary'))()
getgenv().job_hooked = getgenv().job_hooked or false
getgenv().job_hook_map = getgenv().job_hook_map or {}
getgenv().job_respawn_conn = getgenv().job_respawn_conn or nil
getgenv().job_humanoid_died_conn = getgenv().job_humanoid_died_conn or nil
local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local local_player = players.LocalPlayer
local get_conns_func = getconnections or get_signal_cons
local function get_char_local(plr)
    return plr.Character or plr:FindFirstChild("pChar") or plr:WaitForChild("Character", 3)
end

local function apply_hooks()
    if getgenv().job_hooked then return end
    local char = get_char_local(local_player)
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    getgenv().job_hook_map = {}

    for _, con in ipairs(get_conns_func(hrp.Touched)) do
        if con and con.Function then
            local original = hookfunction(con.Function, function(...)
                return original(...)
            end)
            getgenv().job_hook_map[con] = original
        end
    end

    for _, con in ipairs(get_conns_func(hrp.TouchEnded)) do
        if con and con.Function then
            local original = hookfunction(con.Function, function(...)
                return original(...)
            end)
            getgenv().job_hook_map[con] = original
        end
    end

    for _, con in ipairs(get_conns_func(hum.HealthChanged)) do
        if con and con.Function then
            local original = hookfunction(con.Function, function(...)
                return original(...)
            end)
            getgenv().job_hook_map[con] = original
        end
    end

    getgenv().job_hooked = true
    if g and g.notify then g.notify("Success", "job spoof active.", 5) end

    if getgenv().job_humanoid_died_conn then
        pcall(function() getgenv().job_humanoid_died_conn:Disconnect() end)
        getgenv().job_humanoid_died_conn = nil
    end
    getgenv().job_humanoid_died_conn = hum.Died:Connect(function()
        if g and g.notify then g.notify("Info", "Humanoid died, hooks will reapply on respawn.", 5) end
    end)
end

local function remove_hooks()
    if not getgenv().job_hooked then return end

    for con, original in pairs(getgenv().job_hook_map) do
        pcall(function()
            hookfunction(con.Function, original)
        end)
    end

    getgenv().job_hook_map = {}
    getgenv().job_hooked = false

    if g and g.notify then g.notify("Info", "job spoof disabled.", 5) end

    if getgenv().job_humanoid_died_conn then
        pcall(function() getgenv().job_humanoid_died_conn:Disconnect() end)
        getgenv().job_humanoid_died_conn = nil
    end
end

getgenv().job_toggle = getgenv().job_toggle or function(state)
    if state then
        apply_hooks()

        if getgenv().job_respawn_conn then
            pcall(function() getgenv().job_respawn_conn:Disconnect() end)
            getgenv().job_respawn_conn = nil
        end
        getgenv().job_respawn_conn = local_player.CharacterAdded:Connect(function()
            wait(0.1)
            if getgenv().job_hooked then
                apply_hooks()
            end
        end)
    else
        remove_hooks()

        if getgenv().job_respawn_conn then
            pcall(function() getgenv().job_respawn_conn:Disconnect() end)
            getgenv().job_respawn_conn = nil
        end
    end
end

local vc_internal = cloneref and cloneref(game:GetService('VoiceChatInternal')) or game:GetService('VoiceChatInternal')
local vc_service = cloneref and cloneref(game:GetService('VoiceChatService')) or game:GetService('VoiceChatService')

if not getgenv().voiceChat_Check then
    getgenv().voiceChat_Check = true
    local reconnecting = false
    local retryDuration = 4
    local maxAttempts = 500

    local function unsuspend()
        if reconnecting then
            return 
        end
        reconnecting = true

        local attempts = 0
        while attempts < maxAttempts do
            local VoiceChatInternal = cloneref and cloneref(game:GetService('VoiceChatInternal')) or game:GetService('VoiceChatInternal')
            local VoiceChatService = cloneref and cloneref(game:GetService('VoiceChatService')) or game:GetService('VoiceChatService')

            VoiceChatInternal:Leave()
            wait(0.2)
            VoiceChatService:rejoinVoice()
            wait(0.1)
            VoiceChatService:joinVoice()
            wait(0.3)
            VoiceChatInternal:Leave()
            task.wait(0.3)
            VoiceChatService:rejoinVoice()
            VoiceChatService:joinVoice()
            wait(0.5)
            if vc_internal.StateChanged ~= Enum.VoiceChatState.Ended then
                reconnecting = false
                return
            end

            attempts = attempts + 1
            wait(retryDuration)
        end

        reconnecting = false
    end

    local function onVoiceChatStateChanged(_, newState)
        if newState == Enum.VoiceChatState.Ended and not reconnecting then
            unsuspend()
        end
    end

    vc_internal.StateChanged:Connect(onVoiceChatStateChanged)
end

local IMAGE_ID = 0

if vc_internal.StateChanged == Enum.VoiceChatState.Ended then
    vc_internal:Leave()
    vc_internal:Leave()
    task.wait(0.1)
    vc_service:rejoinVoice()
    vc_service:joinVoice()
    wait()
    vc_internal:Leave()
    wait(0.2)
    vc_service:rejoinVoice()
    vc_service:joinVoice()
    task.wait(0.2)
    vc_service:rejoinVoice()
end

local function FindInChassisInterface(targetName)
    local screenGui = PlayerGui:FindFirstChild("A-Chassis Interface")
    if not screenGui then return nil end

    targetName = tostring(targetName):lower()

    local function scan(obj)
        for _, child in ipairs(obj:GetChildren()) do
            if child.Name:lower():find(targetName) then
                return child
            end
            local found = scan(child)
            if found then return found end
        end
    end

    return scan(screenGui)
end

local function request_vehicle()
    local lp = LocalPlayer

    if Player_Cars then
        for _, v in ipairs(Player_Cars:GetChildren()) do
            if v.Name == lp.Name and v.Value then
                return v.Value
            end
        end
    end

    if Cars and #Cars:GetChildren() > 0 then
        for _, v in ipairs(Cars:GetChildren()) do
            local pl = v:FindFirstChild("PlayerLoc")
            if pl and pl.Value == lp then
                return v
            end
        end
    end

    return nil
end

local function is_car_locked()
    local val = g.LocalPlayer:FindFirstChild("Locked") or game.Players.LocalPlayer:FindFirstChild("Locked")

    if val and val.Value == true then
        return true
    elseif val and val.Value == false then
        return false
    else
        return "error"
    end
end

local function get_body_from_vehicle()
    local main_vehicle = request_vehicle()
    if not main_vehicle then return nil end
    local target = "body"

    local function scan_car(obj)
        for _, v in ipairs(obj:GetChildren()) do
            if v.Name:lower():find(target) then
                return v
            end
            local found = scan_car(v)
            if found then return found end
        end
    end

    return scan_car(main_vehicle)
end

local function get_part_from_vehicle(part)
    local car = request_vehicle()
    if not car then return nil end

    part = part:lower()

    for _, v in ipairs(car:GetDescendants()) do
        if v.Name:lower():find(part) then
            return v
        end
    end

    return nil
end

local Window = Rayfield:CreateWindow({
    Name = 'Flames Hub | SWFL Hub | '..tostring(Script_Version)..' | '..tostring(executor_Name),
    LoadingTitle = 'Enjoy, '..tostring(LocalPlayer),
    LoadingSubtitle = 'SWFL Hub.',
    ConfigurationSaving = {
        Enabled = false,
        FolderName = 'Config-SWFL',
        FileName = 'Config-SWFLScriptHub',
    },
    Discord = {
        Enabled = false,
        Invite = '',
        RememberJoins = false,
    },
    KeySystem = false,
    KeySettings = {
        Title = 'None',
        Subtitle = 'No key system is provided.',
        Note = '...',
        FileName = 'Key',
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = { 'None' },
    },
})
wait()
function notify_rf(title, content, duration)
    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(duration),
        Image = tonumber(IMAGE_ID),
        Actions = {
            Ignore = {
                Name = 'Okay.',
                Callback = function()
                    print('...')
                end,
            },
        },
    })
end
wait()
local Tab1 = Window:CreateTab('🏡 Home 🏡', IMAGE_ID)
local Section1 = Tab1:CreateSection('||| 🏡 Home 🏡 Section |||')
local Tab2 = Window:CreateTab('🧍 LocalPlayer 🧍', IMAGE_ID)
local Section2 = Tab2:CreateSection('||| 🧍 LocalPlayer 🧍 Section |||')
local Tab3 = Window:CreateTab('🚗 Vehicle 🚗', IMAGE_ID)
local Section3 = Tab3:CreateSection('||| 🚗 Vehicle 🚗 Section |||')
local Tab4 = Window:CreateTab('🔥‍ Car Mods 🔥', IMAGE_ID)
local Section4 = Tab4:CreateSection('||| 🔥‍ Modifications 🔥‍ Section |||')
local Tab5 = Window:CreateTab('🤖‍ Exploits 🤖', IMAGE_ID)
local Section5 = Tab5:CreateSection('||| 🤖‍ Exploits 🤖‍ Section |||')
local Tab6 = Window:CreateTab('🦿 Teleports 🦿', IMAGE_ID)
local Section6 = Tab6:CreateSection('||| 🦿 Teleports 🦿 Section |||')

if PlayerScripts:FindFirstChild("TireSmokeHandler") then
    notify("Info", "Disabling LocalScript...", 5)
    wait(0.2)
    PlayerScripts:FindFirstChild("TireSmokeHandler").Disabled = true
end

getgenv().antiAFK_Toggle = Tab1:CreateToggle({
Name = 'Anti AFK',
CurrentValue = false,
Flag = 'AntiAFKToggleIdling',
Callback = function(toggleTheAntiAFK)
    wait(0.5)
    if toggleTheAntiAFK then
        if getgenv().AntiAFK_Connection then
            getgenv().AntiAFK_Connection:Disconnect()
            getgenv().AntiAFK_Connection = nil
        end

        if getgenv().AntiAFK_Connections then
            for _, conn in pairs(getgenv().AntiAFK_Connections) do
                conn:Disconnect()
            end
            getgenv().AntiAFK_Connections = nil
        end

        getgenv().Use_GetConnections = not getgenv().Use_GetConnections
        getgenv().Use_VirtualUser = not getgenv().Use_VirtualUser

        local function disableAFKUsingGetConnections()
            if GC then
                getgenv().Use_GetConnections = true
                getgenv().Use_VirtualUser = false
                getgenv().AntiAFK_Connections = {}
                for _, v in pairs(GC(LocalPlayer.Idled)) do
                    if v.Disable then
                        v:Disable()
                    elseif v.Disconnect then
                        v:Disconnect()
                    end
                    table.insert(getgenv().AntiAFK_Connections, v)
                end
            end
        end

        local function disableAFKUsingVirtualUser()
            getgenv().Use_VirtualUser = true
            getgenv().Use_GetConnections = false
            wait()
            getgenv().AntiAFK_Connection = LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end

        if ReplicatedStorage:FindFirstChild('AfkEvent') then
            ReplicatedStorage:FindFirstChild('AfkEvent').Parent = SoundService
        end
        if PlayerScripts:FindFirstChild('afkEnable') then
            PlayerScripts:FindFirstChild('afkEnable').Disabled = true
            PlayerScripts:FindFirstChild('afkEnable'):FindFirstChild('afkCheck2').Disabled = true
            PlayerScripts:FindFirstChild('afkEnable'):FindFirstChild('afkCheck3').Disabled = true
            wait(0.3)
            PlayerScripts:FindFirstChild('afkEnable').Parent = SoundService
        end
        if GC then
            disableAFKUsingGetConnections()
        else
            disableAFKUsingVirtualUser()
        end
    else
        if getgenv().AntiAFK_Connection then
            getgenv().AntiAFK_Connection:Disconnect()
            getgenv().AntiAFK_Connection = nil
        end

        if getgenv().AntiAFK_Connections then
            for _, conn in pairs(getgenv().AntiAFK_Connections) do
                conn:Disconnect()
            end
            getgenv().AntiAFK_Connections = nil
        end
        if SoundService:FindFirstChild('AfkEvent') then
            SoundService:FindFirstChild('AfkEvent').Parent = ReplicatedStorage
        end
        if SoundService:FindFirstChild("afkEnable") then
            SoundService:FindFirstChild('afkEnable').Parent = PlayerScripts
        end
    end
end,})

if getgenv().Use_GetConnections or getgenv().Use_VirtualUser then
    getgenv().antiAFK_Toggle:Set(false)
end

local footsteps_sound = footstep_sounds()

getgenv().WalkingAndJumpingSounds = Tab2:CreateSlider({
Name = 'Footstep Sounds Volume',
Range = {0, 10},
Increment = 0.1,
Suffix = "",
CurrentValue = 1,
Flag = "FootstepSoundSlider",
Callback = function(vol)
    local group = footstep_sounds()
    if not group then
        getgenv().WalkingAndJumpingSounds:Set(1)
        return getgenv().notify("Error", "Footsteps SoundGroup not found.", 5)
    end

    if not footsteps_sound then
        return getgenv().notify("Warning", tostring(footsteps_sound).." was not found.", 5)
    end

    for _, v in ipairs(footsteps_sound:GetChildren()) do
        if v:IsA("Sound") then
            v.Volume = tonumber(vol) or vol
        end
    end
end,})

if footsteps_sound and footsteps_sound:FindFirstChild("Basalt").Volume == 0 then
    getgenv().WalkingAndJumpingSounds:Set(1)
    wait(0.2)
    footsteps_sound.Volume = 1
    for _, v in ipairs(footsteps_sound:GetDescendants()) do
        if v:IsA("Sound") then
            v.Volume = 1
        end
    end
elseif not footsteps_sound then
    getgenv().WalkingAndJumpingSounds:Set(1)
elseif not footsteps_sound:FindFirstChild("Basalt") then
    getgenv().WalkingAndJumpingSounds:Set(1)
end

getgenv().NoJumpCooldownToggle = Tab2:CreateToggle({
Name = 'Disable Jump Cooldown (FE)',
CurrentValue = false,
Flag = 'ezBypassJumpCooldowns',
Callback = function(bypassingJumpCooldown)
    if bypassingJumpCooldown then
        local get_gc_func = getconnections or get_signal_cons

        for _, c in pairs(get_gc_func(get_human(LocalPlayer):GetPropertyChangedSignal("FloorMaterial"))) do
            c:Disable()
        end
    else
        local get_gc_func = getconnections or get_signal_cons

        for _, c in pairs(get_gc_func(get_human(LocalPlayer):GetPropertyChangedSignal("FloorMaterial"))) do
            c:Enable()
        end
    end
end,})

getgenv().RespawnCharacterFast = Tab2:CreateButton({
Name = 'Respawn (FE)',
Callback = function()
    loadCharRemote:FireServer()
end,})

getgenv().ChooseADifferentTeam = Tab1:CreateDropdown({
Name = 'Change Team (FE)',
Options = getgenv().All_Teams,
CurrentOption = 'Team',
MultipleOptions = false,
Flag = 'chooseAnotherTeamRemote',
Callback = function(theTeamChosen)
    local another_team = theTeamChosen and theTeamChosen[1] or theTeamChosen
    local Get_Team = Teams:FindFirstChild(another_team)

    TeamEvent:FireServer(Get_Team.TeamColor)
end,})

getgenv().TeleportToPurchaseCarMenu = Tab6:CreateButton({
Name = 'TP To Purchase Vehicle Menu',
Callback = function()
    local DealershipPart = Workspace:FindFirstChild('DealershipPart')
    if not DealershipPart then return end

    Character:PivotTo(DealershipPart:GetPivot())
end,})

getgenv().MakeJobMoneyAnywhere = Tab2:CreateToggle({
Name = "Make money anywhere from your job (FE).",
CurrentValue = false,
Flag = "MakeMoneyAnywhereFromJob",
Callback = function(ez_job_keeper)
    if ez_job_keeper then
        getgenv().job_toggle(true)
    else
        getgenv().job_toggle(false)
    end
end,})

getgenv().LockVehicleToggle = Tab3:CreateToggle({
Name = "Lock Vehicle (FE)",
CurrentValue = false,
Flag = "LockCurrentVehicleToggle",
Callback = function(locked_vehicle)
    if locked_vehicle then
        if Settings_Remote and Settings_Remote:IsA("RemoteEvent") then
            local args = {
                "Setting",
                "Locked",
                true
            }
            
            Settings_Remote:FireServer(unpack(args))
        end
    else
        if Settings_Remote and Settings_Remote:IsA("RemoteEvent") then
            local args = {
                "Setting",
                "Locked",
                false
            }
            
            Settings_Remote:FireServer(unpack(args))
        end
    end
end,})

if is_car_locked() == true then
    getgenv().LockVehicleToggle:Set(false)
end

--[[getgenv().MoreRainbowCarColors = Tab3:CreateToggle({
Name = "Full Rainbow Vehicle (FE, Needs GamePass)",
CurrentValue = false,
Flag = "MainFullCarColoring",
Callback = function(full_rainbow_fe_car)
    local Player_Vehicle = request_vehicle()
    if not Player_Vehicle then
        getgenv().Full_RGB_Car_Colors = false
        getgenv().MoreRainbowCarColors:Set(false)
        return getgenv().notify("Error", "You have not spawned a vehicle, spawn one!", 5)
    end

    local Vehicle_Color_Part = get_part_from_vehicle("Color")
    local M5_Part = get_part_from_vehicle("M5")
    local Remote = get_part_from_vehicle("Prop_FE")

    if not Vehicle_Color_Part or not M5_Part or not Remote then
        getgenv().Full_RGB_Car_Colors = false
        getgenv().MoreRainbowCarColors:Set(false)
        return getgenv().notify("Error", "Vehicle missing Color, M5, or Prop_FE!", 5)
    end

    if full_rainbow_fe_car then
        getgenv().Full_RGB_Car_Colors = true

        if getgenv().FullRGB_Vehicle_Task then
            pcall(task.cancel, getgenv().FullRGB_Vehicle_Task)
        end

        getgenv().FullRGB_Vehicle_Task = task.spawn(function()
            while task.wait() and getgenv().Full_RGB_Car_Colors == true do
                local veh = request_vehicle()
                if not veh then break end

                local ColorP = get_part_from_vehicle("Color")
                local M5 = get_part_from_vehicle("M5")
                local Remote = get_part_from_vehicle("Prop_FE")

                if not ColorP or not M5 or not Remote then break end

                for _, rgb in ipairs(colors) do
                    if not getgenv().Full_RGB_Car_Colors then
                        break
                    end

                    Remote:FireServer("UpdateColor", ColorP, rgb[1], rgb[2], rgb[3])
                    Remote:FireServer("UpdateColor", M5, rgb[1], rgb[2], rgb[3])
                    task.wait(0.01)
                end
            end

            getgenv().Full_RGB_Car_Colors = false
            pcall(function() getgenv().MoreRainbowCarColors:Set(false) end)
        end)
    else
        getgenv().Full_RGB_Car_Colors = false

        if getgenv().FullRGB_Vehicle_Task then
            pcall(task.cancel, getgenv().FullRGB_Vehicle_Task)
        end

        getgenv().FullRGB_Vehicle_Task = nil
    end
end,})

if getgenv().Full_RGB_Car_Colors then
    getgenv().Full_RGB_Car_Colors = false
    getgenv().MoreRainbowCarColors:Set(false)
end--]]

g._rainbow_lock = g._rainbow_lock or false
g.Rainbow_Vehicle = g.Rainbow_Vehicle or false

local function start_rainbow(propFE, colorPart)
    g.Rainbow_Vehicle = true

    task.spawn(function()
        while g.Rainbow_Vehicle do
            for _, rgb in ipairs(g.free_colors) do
                if not g.Rainbow_Vehicle then break end
                propFE:FireServer("UpdateColor", colorPart, rgb[1], rgb[2], rgb[3])
                task.wait(0)
            end
            task.wait()
        end
    end)
end

local function stop_rainbow()
    g.Rainbow_Vehicle = false
end

g.RainbowCarFE = Tab3:CreateToggle({
Name = "Rainbow Vehicle (FE, No GamePass needed!)",
CurrentValue = false,
Flag = "rainbowCarFEScript",
Callback = function(toggle)
    if g._rainbow_lock then
        return
    end

    local vehicle = request_vehicle()

    if not toggle or not vehicle then
        stop_rainbow()
        g._rainbow_lock = true
        g.RainbowCarFE:Set(false)
        g._rainbow_lock = false
        return
    end

    local colorPart, propFE = get_FE_ColorPart(vehicle)

    if not colorPart or not propFE then
        stop_rainbow()
        g._rainbow_lock = true
        g.RainbowCarFE:Set(false)
        g._rainbow_lock = false
        return g.notify("Error", "Vehicle missing Color part or Prop_FE!", 6)
    end

    start_rainbow(propFE, colorPart)
end,})

if g.Rainbow_Vehicle then
    stop_rainbow()
    g._rainbow_lock = true
    g.RainbowCarFE:Set(false)
    g._rainbow_lock = false
end

getgenv().RemoveRain = Tab1:CreateToggle({
Name = "Remove Rain",
CurrentValue = false,
Flag = "temporarilyRemoveRainToggle",
Callback = function(theRainGone)
    local move_to_where
    local items = {"thunder1","thunder2","thunder3","thunder4","thunder5","thunder6","rainStorage"}
    
    if theRainGone then
        getgenv().swapped_rain_stuff = true
        move_to_where = AssetService

        for _, name in ipairs(items) do
            local obj = Workspace:FindFirstChild(name)
            if obj then obj.Parent = move_to_where end
        end

        local rain_local_script = PlayerScripts:FindFirstChild("RainScript")
        if rain_local_script then rain_local_script.Parent = move_to_where end

        local miscs = ReplicatedStorage:FindFirstChild("Miscs")
        if miscs and miscs:FindFirstChild("Rain") then
            miscs.Rain.Parent = move_to_where
        end
    else
        getgenv().swapped_rain_stuff = false
        wait(0.1)
        move_to_parents = {
            Workspace = Workspace,
            PlayerScripts = PlayerScripts,
            Miscs = ReplicatedStorage:FindFirstChild("Miscs")
        }

        for _, name in ipairs(items) do
            local obj = AssetService:FindFirstChild(name)
            if obj then obj.Parent = move_to_parents.Workspace end
        end

        local rain_script = AssetService:FindFirstChild("RainScript")
        if rain_script then rain_script.Parent = move_to_parents.PlayerScripts end

        local rain = AssetService:FindFirstChild("Rain")
        if rain and move_to_parents.Miscs then rain.Parent = move_to_parents.Miscs end
    end
end,})

if getgenv().swapped_rain_stuff then
    getgenv().RemoveRain:Set(false)
    local workspace_items = {"thunder1","thunder2","thunder3","thunder4","thunder5","thunder6","rainStorage"}

    for _, name in ipairs(workspace_items) do
        local obj = AssetService:FindFirstChild(name)
        if obj then obj.Parent = Workspace end
    end

    local rainScript = AssetService:FindFirstChild("RainScript")
    if rainScript then rainScript.Parent = PlayerScripts end

    local miscs = ReplicatedStorage:FindFirstChild("Miscs")
    local rain = AssetService:FindFirstChild("Rain")
    if rain and miscs then rain.Parent = miscs end
end

getgenv().playable_audio_id = "1"
wait(0.1)
getgenv().PlayAnAudioID = Tab3:CreateInput({
Name = "Set Audio ID",
CurrentValue = "ID Here",
PlaceholderText = "ID Here",
RemoveTextAfterFocusLost = true,
Flag = "audioIDInput",
Callback = function(theAudioID)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        getgenv().PlayAnAudioID:Set("ID Here")
        return getgenv().notify("Error", "Please spawn a Vehicle first.", 6)
    end

    getgenv().playable_audio_id = tostring(theAudioID)
    local OwnID_TextLabel = FindInChassisInterface("ownID")
    local Body = get_body_from_vehicle()
    local radio_tog = get_part_from_vehicle("radioTog")

    OwnID_TextLabel.Text = getgenv().playable_audio_id
    radio_tog.Value = true
end,})

getgenv().PlayAudioID = Tab3:CreateToggle({
Name = "Play Set Audio",
CurrentValue = false,
Flag = "TheAudioPlaying",
Callback = function(whatAudioWePlaying)
    local Player_Vehicle = request_vehicle()
    if not Player_Vehicle then
        getgenv().PlayAudioID:Set(false)
        return getgenv().notify("Error", "Please spawn a Vehicle first.", 6)
    end

    local Body = get_body_from_vehicle()
    if not Body then
        getgenv().PlayAudioID:Set(false)
        return getgenv().notify("Error", "Vehicle missing Body part!", 6)
    end

    local ownIDConfirm = FindInChassisInterface("ownIDConfirm")
    local radio_tog = get_part_from_vehicle("radioTog")

    if whatAudioWePlaying then
        getgenv().ok_boys_lets_play = true
        if ownIDConfirm then
            Song_Control_Event:FireServer(Player_Vehicle, ownIDConfirm, getgenv().playable_audio_id)
        end
    else
        getgenv().ok_boys_lets_play = false
        if radio_tog then radio_tog.Value = false end
        wait(0.1)
        if ownIDConfirm then
            Song_Control_Event:FireServer(Player_Vehicle, ownIDConfirm, "stop")
        end
    end
end,})

getgenv().HornToggledOn = Tab3:CreateToggle({
Name = "Toggle Horn",
CurrentValue = false,
Flag = "hornUpdatingToggle",
Callback = function(theHornEnabled)
    local Player_Vehicle = request_vehicle()

    if theHornEnabled then
        if not Player_Vehicle then
            getgenv().HornToggledOn:Set(false)
            return getgenv().notify("Error", "Please spawn a Vehicle first.", 6)
        end
        
        local horn = get_part_from_vehicle("HornUpdate")

        getgenv().car_horn = true
        if horn and horn:IsA("RemoteEvent") then
            horn:FireServer(true)
        else
            getgenv().car_horn = false
            getgenv().HornToggledOn:Set(false)
            return getgenv().notify("Error", "Horn RemoteEvent not found inside Vehicle.", 5)
        end
    else
        local horn = get_part_from_vehicle("HornUpdate")

        getgenv().car_horn = false
        if horn and horn:IsA("RemoteEvent") then
            horn:FireServer(false)
        end
    end
end,})

local horn_upd = get_part_from_vehicle("HornUpdate")

if getgenv().car_horn or getgenv().car_horn == true then
    getgenv().car_horn = false
    getgenv().HornToggledOn:Set(false)
    wait(0.1)
    if horn_upd and horn_upd:IsA("RemoteEvent") then
        horn_upd:FireServer(false)
    end
end

local Wait_Time
local FuelAmount

getgenv().ModifyFuelAmountToBeRefilled = Tab3:CreateInput({
Name = "Fuel Amount (For Loop)",
CurrentValue = "Fuel",
PlaceholderText = "Amount",
RemoveTextAfterFocusLost = true,
Flag = "ModifyingFuelAmountLooping",
Callback = function(the_fuel_amount)
    FuelAmount = tonumber(the_fuel_amount)
end,})

getgenv().WaitTimeForFuelLoop = Tab3:CreateInput({
Name = "Wait Time (To Refill Fuel)",
CurrentValue = "Number",
PlaceholderText = "Wait Time",
RemoveTextAfterFocusLost = true,
Flag = "ModifyWaitTimeForLoop",
Callback = function(wait_time_here)
    Wait_Time = tonumber(wait_time_here)
end,})

getgenv().RefillCarFuelLoop = Tab3:CreateToggle({
Name = "Refill Car Fuel Loop (Cost Money)",
CurrentValue = false,
Flag = "RefillingVehicleFuelLoop",
Callback = function(refilling_car)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        getgenv().RefillCarFuelLoop:Set(false)
        return getgenv().notify("Error", "Could not find your Vehicle, spawn a vehicle.", 5)
    end

    if not ReplicatedStorage:FindFirstChild("fuelEvent") then
        return getgenv().notify("Error", "This might be patched?: FuelEvent does not exist in ReplicatedStorage!", 10)
    end

    if not ReplicatedStorage:FindFirstChild("PetrolPrice") then
        return getgenv().notify("Error", "PetrolPrice does not exist in RepliatedStorage (broken)!", 5)
    end

    if not ReplicatedStorage:FindFirstChild("DieselPrice") then
        return getgenv().notify("Error", "DieselPrice does not exist in ReplicatedStorage (broken)!", 5) 
    end
    wait()
    if refilling_car and request_vehicle() then
        getgenv().refilling_my_vehicle_fuel = true
        while getgenv().refilling_my_vehicle_fuel == true do
        task.wait(0.3)
            local args = {
                [1] = "requestPurchase",
                [2] = request_vehicle(),
                [3] = tonumber(FuelAmount),
                [4] = ReplicatedStorage:WaitForChild("PetrolPrice"),
                [5] = ReplicatedStorage:WaitForChild("DieselPrice")
            }

            find_RE("fuel"):FireServer(unpack(args))
        end
    elseif not request_vehicle() then
        getgenv().refilling_my_vehicle_fuel = false
    elseif not refilling_car or refilling_car == false then
        getgenv().notify("Info", "Shutting down refilling loop...", 5)
        getgenv().refilling_my_vehicle_fuel = false
        wait(0.5)
        if not getgenv().refilling_my_vehicle_fuel then
            notify("Success", "Successfully shut down refilling loop...", 5)
        end
    end
end,})

getgenv().FuelCarTank = Tab3:CreateInput({
Name = "Car Fuel",
CurrentValue = "Fuel",
PlaceholderText = "Fuel Amount",
RemoveTextAfterFocusLost = true,
Flag = "GetFuelForVehicle",
Callback = function(fuelYouWant)
    if not tonumber(fuelYouWant) then
        return getgenv().notify("Error", "You did not enter in a number.", 6)
    end

    local Player_Vehicle = request_vehicle()
    local fuel_remote = find_RE("fuel")

    if not Player_Vehicle then
        return notify("Error", "You do not have a vehicle spawned!", 5)
    end
    if not fuel_remote then
        return notify("Error", "Fuel RemoteEvent does not exist in ReplicatedStorage!", 5)
    end
    
    if fuel_remote and fuel_remote:IsA("RemoteEvent") then
        local args = {
            [1] = "requestPurchase",
            [2] = Player_Vehicle,
            [3] = tonumber(fuelYouWant),
            [4] = ReplicatedStorage:WaitForChild("PetrolPrice"),
            [5] = ReplicatedStorage:WaitForChild("DieselPrice")
        }

        find_RE("fuel"):FireServer(unpack(args))
    end
end,})

getgenv().StopAllAudios = Tab3:CreateButton({
Name = "Stop All Car Audios",
Callback = function()
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        return getgenv().notify("Error", "Please spawn a Vehicle first.", 6)
    end

    local ownID_TextLabel = FindInChassisInterface("ownID")

    if Song_Control_Event and Song_Control_Event:IsA("RemoteEvent") then
        local args = {
            [1] = Player_Vehicle,
            [2] = get_part_from_vehicle("ownIDConfirm"),
            [3] = "stop"
        }

        Song_Control_Event:FireServer(unpack(args))
    end
    
    if ownID_TextLabel and ownID_TextLabel.Text then
        ownID_TextLabel.Text = ""
    end
end,})

getgenv().Radio_Volume = Tab3:CreateSlider({
Name = "Radio Volume Controller",
Range = {0, 0.9},
Increment = 0.1,
Suffix = "",
CurrentValue = 0.5,
Flag = "radioVolumeSliderControl",
Callback = function(Radio_Volume_Here)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        return 
    end

    if Song_Control_Event and Song_Control_Event:IsA("RemoteEvent") then
        local args = {
            [1] = Player_Vehicle,
            [2] = get_part_from_vehicle("lastVol"),
            [3] = Radio_Volume_Here
        }

        Song_Control_Event:FireServer(unpack(args))
    end
end,})

getgenv().all_lights = getgenv().all_lights or {}

function table_lights()
    local vehicle = request_vehicle()

    if vehicle then
        local lights = get_part_from_vehicle("Lights")

        if lights then
            for _, light in ipairs(lights:GetChildren()) do
                if light:IsA("MeshPart") then
                    table.insert(getgenv().all_lights, light)
                end
            end
        end
    end
end

local function change_light_colors(color)
    local Player_Vehicle = request_vehicle()
    
    for _, light in ipairs(getgenv().all_lights) do
        local args = {
            [1] = "UpdateLight",
            [2] = light,
            [3] = Enum.Material.SmoothPlastic,
            [4] = BrickColor.new(tonumber(color)),
            [5] = 0.015,
            [6] = true,
            [7] = 10,
            [8] = "rbxassetid://8615996420"
        }

        Player_Vehicle:WaitForChild("Lights_FE"):FireServer(unpack(args))
    end
end

getgenv().TheRainbowLights = Tab3:CreateToggle({
Name = "Rainbow Lights (FE)",
CurrentValue = false,
Flag = "UltimateRGBLights",
Callback = function(EnableRainbowLights)
    local Player_Vehicle = request_vehicle()
    local Body = Player_Vehicle:FindFirstChild("Body")
    if not Body then return notify("Error", "'Body' was not found inside Vehicle: "..tostring(request_vehicle().Name).."!", 5) end

    if EnableRainbowLights then
        if not Player_Vehicle then
            getgenv().spamming_rgb_car_lights = false
            getgenv().TheRainbowLights:Set(false)
            return getgenv().notify("Error", "Please spawn a Vehicle first.", 6)
        end
        wait()
        getgenv().spamming_rgb_car_lights = true
        while getgenv().spamming_rgb_car_lights == true do
        wait()
            for _, v in ipairs(Body.Lights:GetDescendants()) do
                if v:IsA("MeshPart") then
                    change_light_colors(1)
                    wait()
                    change_light_colors(21)
                    wait()
                    change_light_colors(23)
                    wait()
                    change_light_colors(26)
                    wait()
                    change_light_colors(22)
                    wait()
                    change_light_colors(25)
                    wait()
                    change_light_colors(37)
                    wait()
                    change_light_colors(104)
                    wait()
                    change_light_colors(193)
                    wait()
                    change_light_colors(327)
                end
            end
        end
    else
        getgenv().spamming_rgb_car_lights = false
        wait()
        getgenv().spamming_rgb_car_lights = false
    end
end,})

if getgenv().spamming_rgb_car_lights or getgenv().spamming_rgb_car_lights == true then
    getgenv().TheRainbowLights:Set(false)
end

getgenv().GetInCar = Tab3:CreateButton({
Name = "Get In Car (from anywhere, spawn vehicle first)",
Callback = function()
    local Player_Vehicle = request_vehicle()
    local prompt_re = find_RE("prompt")

    if not prompt_re then
        return notify("Error", "PromptEvent doesn't exist in ReplicatedStorage! (Patched?)", 5)
    end
    if not Player_Vehicle then
        return getgenv().notify("Error", "Please spawn a Vehicle first.", 6)
    end

    if Character and Character:FindFirstChild("Humanoid") then
        Character:PivotTo(Player_Vehicle:GetPivot())
    else
        notify("Info", "It seems as if your character has not loaded yet!", 5)
        repeat task.wait() until Character and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("HumanoidRootPart")
        wait(0.3)
        Character:PivotTo(Player_Vehicle:GetPivot())
    end

    local args = {
        [1] = "DriveRequest",
        [2] = Player_Vehicle:FindFirstChild("DriveSeat") or Player_Vehicle:WaitForChild("DriveSeat")
    }

    prompt_re:FireServer(unpack(args))
    wait(0.3)
    local args = {
        "TurnOn",
        "Car"
    }

    Player_Vehicle:WaitForChild("IgnitionSoundUpdate", 10):FireServer(unpack(args))
end,})

getgenv().PVPEnabler = Tab2:CreateToggle({
Name = "PVP Switch",
CurrentValue = false,
Flag = "ThePVPSwitchToggle",
Callback = function(pvpEnabled)
    if pvpEnabled then
        local pvp_manager_re = find_RE("pvpmanager")
        local pvp_gui = PlayerGui:FindFirstChild("pvpUI", true) or PlayerGui:WaitForChild("pvpUI", 5)
        local pvp_b

        if pvp_gui and pvp_gui:IsA("ScreenGui") then
            for _, v in ipairs(pvp_gui:GetDescendants()) do
                if v:IsA("TextButton") then
                    pvp_b = v
                end
            end
        else
            getgenv().is_pvp_on = false
            getgenv().PVPEnabler:Set(false)
            return getgenv().notify("Error", "pvpB TextButton not found, try rejoining (patched?).", 7)
        end

        if not HumanoidRootPart:FindFirstChild("jobCharUI") then
            getgenv().PVPEnabler:Set(false)
            return getgenv().notify("Error", "jobCharUI not found, try resetting.", 5)
        end

        if not HumanoidRootPart:FindFirstChild("jobCharUI"):FindFirstChild("Frame") then
            return notify("Error", "Frame was not found inside jobCharUI! (Patched?)", 5)
        end

        if not pvp_manager_re then
            return notify("Error", "'pvpManagerEvent' RemoteEvent was not found in ReplicatedStorage! (Patched?)", 5)
        end

        if not PlayerGui:FindFirstChild("pvpUI") then
            return notify("Error", "pvpUI was not found in PlayerGui! (Patched?)", 5)
        end

        if not PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF") then
            return notify("Error", "pvpF was not found inside pvpUI! (Patched?)", 5)
        end
        getgenv().is_pvp_on = true

        if pvp_manager_re and pvp_manager_re:IsA("RemoteEvent") then
            local pvp_check

            for _, v in ipairs(HumanoidRootPart:GetDescendants()) do
                if v.Name:lower():find("pvpcheck") then
                    pvp_check = v
                end
            end
            wait(0.2)
            local args = {
                [1] = pvp_check
            }

            pvp_manager_re:FireServer(unpack(args))
        end
        wait()
        pvp_b.Text = "DISABLE PVP"
    else
        local pvp_manager_re = find_RE("pvpmanager")
        local pvp_gui = PlayerGui:FindFirstChild("pvpUI", true) or PlayerGui:WaitForChild("pvpUI", 5)
        local pvp_b

        if pvp_gui and pvp_gui:IsA("ScreenGui") then
            for _, v in ipairs(pvp_gui:GetDescendants()) do
                if v:IsA("TextButton") then
                    pvp_b = v
                end
            end
        else
            getgenv().is_pvp_on = false
            return getgenv().notify("Error", "pvpB TextButton not found, try rejoining (patched?).", 7)
        end

        getgenv().is_pvp_on = false
        if pvp_manager_re and pvp_manager_re:IsA("RemoteEvent") then
            local pvp_check

            for _, v in ipairs(HumanoidRootPart:GetDescendants()) do
                if v.Name:lower():find("pvpcheck") then
                    pvp_check = v
                end
            end
            wait(0.3)
            local args = {
                [1] = pvp_check
            }

            pvp_manager_re:FireServer(unpack(args))
        end
        wait(0.1)
        pvp_b.Text = "ENABLE PVP"
    end
end,})

if getgenv().is_pvp_on or getgenv().is_pvp_on == true then
    getgenv().PVPEnabler:Set(false)
    getgenv().is_pvp_on = false
    wait(0.2)
    if PlayerGui:FindFirstChild("pvpUI") and PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF") and PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF"):FindFirstChild("pvpB") then
        PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF"):FindFirstChild("pvpB").Text = "ENABLE PVP"
    end
end

getgenv().TPToCar = Tab6:CreateButton({
Name = "Teleport To Car",
Callback = function()
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        return getgenv().notify("Error", "Please spawn a Vehicle first.", 5)
    end

    if Character and Character:FindFirstChild("HumanoidRootPart") then
        Character:PivotTo(request_vehicle():GetPivot())
    end
end,})

local function change_car_settings(setting, new_value)
    local Player_Vehicle = request_vehicle()
    if not Player_Vehicle then
        return getgenv().notify("Error", "Please spawn a Vehicle first.", 5)
    end

    local moduleScript = Player_Vehicle:FindFirstChild("A-Chassis Tune")
    local tried_require = false

    if moduleScript and not low_level_executor() then
        local ok, vehicle_configuration = pcall(require, moduleScript)
        if ok and type(vehicle_configuration) == "table" then
            tried_require = true
            vehicle_configuration[setting] = new_value
            return
        end
    end

    for _, v in next, getgc(true) do
        if type(v) == "table"
            and rawget(v, "TCSEnabled")
            and rawget(v, "TCSLimit")
            and rawget(v, "RDiffPower")
        then
            v[setting] = new_value
        end
    end

    if not tried_require then
        getgenv().notify("Info", "Fallback to 'getgc' override applied.", 5)
    end
end

getgenv().ApplyBestModSettings = Tab4:CreateButton({
Name = "Apply Fastest/Best Car Mods",
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LegoGameSploit/Roblox_Scripts/main/swflrel.lua"))()
end,})

getgenv().ModifySpeedEngage = Tab4:CreateSlider({
Name = "Modify Speed Engage",
Range = {1, 1000},
Increment = 1,
Suffix = "",
CurrentValue = 5,
Flag = "speedingControlVehicle",
Callback = function(TheVehicleSpeed)
    change_car_settings("SpeedEngage", TheVehicleSpeed)
end,})

getgenv().ModifyBrake = Tab4:CreateSlider({
Name = "Modify BrakeForce",
Range = {10, 7500},
Increment = 1,
Suffix = "",
CurrentValue = 1,
Flag = "brakingControllingYourCar",
Callback = function(newValForBraking)
    change_car_settings("BrakeForce", newValForBraking)
end,})

getgenv().ModifyHorsepower = Tab4:CreateSlider({
Name = "Modify Horsepower",
Range = {100, 5000},
Increment = 10,
Suffix = " HP",
CurrentValue = 470,
Flag = "horsepowerControl",
Callback = function(newHP)
    change_car_settings("Horsepower", newHP)
end,})

getgenv().ModifySteerRatio = Tab4:CreateSlider({
Name = "Modify Steering Ratio",
Range = {1, 20},
Increment = 0.1,
Suffix = "",
CurrentValue = 9,
Flag = "steeringRatioControl",
Callback = function(newRatio)
    change_car_settings("SteerRatio", newRatio)
end,})

getgenv().ModifyBrakeBias = Tab4:CreateSlider({
Name = "Modify Brake Bias",
Range = {0, 500},
Increment = 1,
Suffix = "",
CurrentValue = 5,
Flag = "brakeBiasControl",
Callback = function(newBias)
    change_car_settings("BrakeBias", newBias)
end,})

getgenv().ModifyFinalDrive = Tab4:CreateSlider({
Name = "Modify Final Drive Ratio",
Range = {0, 5},
Increment = 0.1,
Suffix = "",
CurrentValue = 0,
Flag = "finalDriveControl",
Callback = function(newDrive)
    change_car_settings("FinalDrive", newDrive)
end,})

getgenv().ModifySuspensionStiffness = Tab4:CreateSlider({
Name = "Modify Suspension Stiffness",
Range = {1000, 20000},
Increment = 100,
Suffix = "",
CurrentValue = 6500,
Flag = "suspensionStiffnessControl",
Callback = function(newStiffness)
    change_car_settings("FSusStiffness", newStiffness)
    change_car_settings("RSusStiffness", newStiffness)
end,})

getgenv().ModifySuspensionDamping = Tab4:CreateSlider({
Name = "Modify Suspension Damping",
Range = {100, 5000},
Increment = 50,
Suffix = "",
CurrentValue = 400,
Flag = "suspensionDampingControl",
Callback = function(newDamping)
    change_car_settings("FSusDamping", newDamping)
    change_car_settings("RSusDamping", newDamping)
end,})

getgenv().ModifyPreCompress = Tab4:CreateSlider({
Name = "Modify Pre-Compression",
Range = {0, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.675,
Flag = "preCompressControl",
Callback = function(newPreComp)
    change_car_settings("FPreCompress", newPreComp)
    change_car_settings("RPreCompress", newPreComp)
end,})

getgenv().ModifySteerSpeed = Tab4:CreateSlider({
Name = "Modify Steering Speed",
Range = {1, 750},
Increment = 1,
Suffix = "",
CurrentValue = 3,
Flag = "steeringSpeedControl",
Callback = function(newSteerSpeed)
    change_car_settings("SteerSpeed", newSteerSpeed)
end,})

getgenv().ModifySteerMaxTorque = Tab4:CreateSlider({
Name = "Modify Steering Max Torque",
Range = {10, 10000},
Increment = 5,
Suffix = "",
CurrentValue = 500,
Flag = "steerMaxTorqueControl",
Callback = function(newSteerTorque)
    change_car_settings("SteerMaxTorque", newSteerTorque)
end,})

getgenv().ModifyAckerman = Tab4:CreateSlider({
Name = "Modify Ackerman Steering",
Range = {0, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.9,
Flag = "ackermanControl",
Callback = function(newAckerman)
    change_car_settings("Ackerman", newAckerman)
end,})

getgenv().ModifyWeightDistribution = Tab4:CreateSlider({
Name = "Modify Weight Distribution",
Range = {40, 60},
Increment = 1,
Suffix = "%",
CurrentValue = 54,
Flag = "weightDistControl",
Callback = function(newWeightDist)
    change_car_settings("WeightDist", newWeightDist)
end,})

getgenv().ModifyTorqueVectoring = Tab4:CreateSlider({
Name = "Modify Torque Vectoring",
Range = {-1, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = -0.15,
Flag = "torqueVectorControl",
Callback = function(newTorqueVec)
    change_car_settings("TorqueVector", newTorqueVec)
end,})

getgenv().ModifySuperchargerBoost = Tab4:CreateSlider({
Name = "Modify Supercharger Boost",
Range = {0, 50},
Increment = 1,
Suffix = " PSI",
CurrentValue = 13,
Flag = "superchargerBoostControl",
Callback = function(newBoost)
    change_car_settings("S_Boost", newBoost)
end,})

getgenv().ModifySuperchargerEfficiency = Tab4:CreateSlider({
Name = "Modify Supercharger Efficiency",
Range = {0, 20},
Increment = 0.1,
Suffix = "",
CurrentValue = 8.5,
Flag = "superchargerEfficiencyControl",
Callback = function(newEfficiency)
    change_car_settings("S_Efficiency", newEfficiency)
end,})

getgenv().ModifyTurboBoost = Tab4:CreateSlider({
Name = "Modify Turbo Boost",
Range = {0, 50},
Increment = 1,
Suffix = " PSI",
CurrentValue = 10,
Flag = "turboBoostControl",
Callback = function(newTurboBoost)
    change_car_settings("T_Boost", newTurboBoost)
end,})

getgenv().ModifyTurboEfficiency = Tab4:CreateSlider({
Name = "Modify Turbo Efficiency",
Range = {0, 20},
Increment = 0.1,
Suffix = "",
CurrentValue = 5,
Flag = "turboEfficiencyControl",
Callback = function(newTurboEff)
    change_car_settings("T_Efficiency", newTurboEff)
end,})

getgenv().ModifyTurboSize = Tab4:CreateSlider({
Name = "Modify Turbo Size",
Range = {10, 200},
Increment = 5,
Suffix = "",
CurrentValue = 80,
Flag = "turboSizeControl",
Callback = function(newTurboSize)
    change_car_settings("T_Size", newTurboSize)
end,})

getgenv().ModifyWeight = Tab4:CreateSlider({
Name = "Modify Weight",
Range = {1000, 10000},
Increment = 50,
Suffix = " lbs",
CurrentValue = 3000,
Flag = "weightControl",
Callback = function(newWeight)
    change_car_settings("Weight", newWeight)
end,})

getgenv().ModifyWeightScaling = Tab4:CreateSlider({
Name = "Modify Weight Scaling",
Range = {0, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.02,
Flag = "weightScalingControl",
Callback = function(newWeightScale)
    change_car_settings("WeightScaling", newWeightScale)
end,})

getgenv().ModifyFlywheel = Tab4:CreateSlider({
Name = "Modify Flywheel",
Range = {100, 5000},
Increment = 100,
Suffix = "",
CurrentValue = 500,
Flag = "flywheelControl",
Callback = function(newFlywheel)
    change_car_settings("Flywheel", newFlywheel)
end,})

getgenv().ModifyRevAcceleration = Tab4:CreateSlider({
Name = "Modify Rev Acceleration",
Range = {50, 10000},
Increment = 1,
Suffix = "",
CurrentValue = 250,
Flag = "revAccelerationControl",
Callback = function(newRevAccel)
    change_car_settings("RevAccel", newRevAccel)
end,})

getgenv().ModifyRevBounce = Tab4:CreateSlider({
Name = "Modify Rev Bounce",
Range = {100, 5000},
Increment = 100,
Suffix = "",
CurrentValue = 500,
Flag = "revBounceControl",
Callback = function(newRevBounce)
    change_car_settings("RevBounce", newRevBounce)
end,})

getgenv().ModifyThrottleAcceleration = Tab4:CreateSlider({
Name = "Modify Throttle Acceleration",
Range = {0.01, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.05,
Flag = "throttleAccelerationControl",
Callback = function(newThrottleAccel)
    change_car_settings("ThrotAccel", newThrottleAccel)
end,})

getgenv().ModifyThrottleDeceleration = Tab4:CreateSlider({
Name = "Modify Throttle Deceleration",
Range = {0.01, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.2,
Flag = "throttleDecelerationControl",
Callback = function(newThrottleDecel)
    change_car_settings("ThrotDecel", newThrottleDecel)
end,})

getgenv().ModifyInclineCompensation = Tab4:CreateSlider({
Name = "Modify Incline Compensation",
Range = {0.5, 5},
Increment = 0.1,
Suffix = "",
CurrentValue = 1.2,
Flag = "inclineCompControl",
Callback = function(newInclineComp)
    change_car_settings("InclineComp", newInclineComp)
end,})

getgenv().Infinite_Yield_Premium = Tab5:CreateButton({
Name = "Infinite Yield Premium",
Callback = function()
    if getgenv().GET_LOADED_IY then
        return 
    end
    if getgenv().IY_LOADED then
        return getgenv().notify("Error", "You already have Infinite Yield (regular) running, you cannot run this.", 10)
    end

    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua', true))()
end,})

getgenv().FOV_Slider = Tab5:CreateSlider({
Name = "Field Of View (FOV)",
Range = {5, 120},
Increment = 1,
Suffix = "",
CurrentValue = 75,
Flag = "theFOVValueEditor",
Callback = function(New_FOV_Value)
    if Workspace then
        Workspace.CurrentCamera.FieldOfView = New_FOV_Value
    end
end,})

if LocalPlayer.CameraMaxZoomDistance <= 99999 then
    getgenv().notify("Info", "Setting CameraMaxZoomDistance...", 5)
    LocalPlayer.CameraMaxZoomDistance = 999999
    wait(1)
    if LocalPlayer.CameraMaxZoomDistance >= 99999 then
        getgenv().notify("Success", "CameraMaxZoomDistance has been maximized.", 5)
    end
end

function Notify(message, duration)
    local CoreGui = CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
    local TweenService = TweenService or SafeGet("TweenService") or safe_wrapper("TweenService") or cloneref and cloneref(game:GetService("TweenService")) or game:GetService("TweenService")

    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "CustomErrorGui"
    NotificationGui.ResetOnSpawn = false
    NotificationGui.Parent = CoreGui
    duration = duration or 5

    local Frame = Instance.new("Frame")
    Frame.Name = "ErrorMessage"
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.3
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0, 500, 0, 120)
    Frame.Position = UDim2.new(0, 20, 0, 100)
    Frame.Parent = NotificationGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame

    local Icon = Instance.new("ImageLabel")
    Icon.Name = "ErrorIcon"
    Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0, 15, 0.5, -25)
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Image = "rbxasset://textures/ui/Emotes/ErrorIcon.png"
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Name = "ErrorText"
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 80, 0, 10)
    Label.Size = UDim2.new(1, -90, 1, -20)
    Label.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json")
    Label.Text = message
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 20
    Label.TextWrapped = true
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Top
    Label.Parent = Frame

    Frame.BackgroundTransparency = 1
    Icon.ImageTransparency = 1
    Label.TextTransparency = 1
    TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.3}):Play()
    TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    task.delay(duration, function()
        if Frame and Frame.Parent then
            TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
            TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            task.wait(0.35)
            Frame:Destroy()
            NotificationGui:Destroy()
        end
    end)
end

task.spawn(function()
    while getgenv().ConstantUpdate_Checker_Live do
        task.wait(1)

        local success, latestVersionInfo = pcall(function()
            local versionJson = game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/Script_Versions_JSON?cachebust=" .. tick())
            return HttpService:JSONDecode(versionJson)
        end)

        if success and latestVersionInfo then
            if Script_Version ~= latestVersionInfo.Southwest_Florida_Hub_Version then
                getgenv().ConstantUpdate_Checker_Live = false
                Notify("[SWFL HUB]: do NOT rejoin! An update is now out! Update version: "..tostring(latestVersionInfo.Southwest_Florida_Hub_Version).." | re-executing automatically...", 30)
                getgenv().SouthwestFlorida_Hub_Executed = false
                wait(3)
                loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Southwest_Florida.lua'))()
                break
            end
        end
    end
end)
