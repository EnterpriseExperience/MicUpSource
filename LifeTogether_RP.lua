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
wait()
local Emotes = {
    griddy = {
        129149402922241,
        116150478424136,
        91878676494639,
        98318847394332,
    },
    scenario = {110013053670989},
    worm = {
        132950274861655,
        127882676467351,
        77625642316480,
        127068135887882,
        102075861555461,
    },
    zen = {84943987730610},
    glitching = {131961970776128},
    superman = {
        134861929761233,
        93202303625509
    },
    aura = {
        121547391421211,
        78755795767408,
        88425531063616,
        111426928948833,
        84052327668385,
        116826272832592,
        103040723950430,
        85452015445985
    },
    orangejustice = {
        133160900449608,
        110064349530772,
        117638432093760,
        76494145762351,
        84419755287539,
        98578127060782,
    },
    default = {
        80877772569772,
        99818263438846,
        121094705979021,
        128801735413980,
        83559276301867,
        100099256371667,
    },
    koto = {
        91927498467600,
        130655908439646,
        108129969514208,
        121962822800440,
    },
    popular = {
        71302743123422,
        100531085354441,
        113815442881930,
        115719203985051,
        77201116105359,
    },
    billybounce = {
        126516908191316,
        93450937830334,
        131013364061967,
    },
    billyjean = {
        98915045016286
    },
    michaelmyers = {
        103115491327846,
        99068367180942,
        135204931182370,
        84555531182471,
        123102740029981,
        126102210823846,
        78250036534439
    }
}
local EmoteNames = {"griddy", "scenario", "worm", "zen", "glitching", "superman", "aura", "orangejustice", "default", "koto", "popular", "michaelmyers", "billyjean", "billybounce"}
wait(0.2)
local API_URL = "https://flameshub-worker.flameshub.workers.dev/api/flameshub"
local POLL_INTERVAL = 3
local watchedNames = {
   ["L0CKED_1N1"] = true,
   ["CHEATING_B0SS"] = true,
}

local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local httprequest = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)

local function httpRequestSafe(opts)
    if not httprequest then return nil end
    local ok, res = pcall(function() return httprequest(opts) end)
    if not ok or not res then return nil end
    return res
end

local function apiSet(payload)
    local res = httpRequestSafe({
        Url = API_URL .. "/set",
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(payload)
    })
    return res and (res.StatusCode == 200 or res.statusCode == 200)
end

local function apiList()
    local res = httpRequestSafe({ Url = API_URL .. "/list", Method = "GET" })
    if res and (res.StatusCode == 200 or res.statusCode == 200) and res.Body then
        local ok, tbl = pcall(function() return HttpService:JSONDecode(res.Body) end)
        if ok and type(tbl) == "table" then return tbl end
    end
    return {}
end

local function clearBillboardForChar(char)
    if not char then return end
    local head = char:FindFirstChild("Head")
    if head then
        local bb = head:FindFirstChild("FlamesHubBillboard")
        if bb then bb:Destroy() end
    end
end

local function setBillboard(char, text, color)
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    local existing = head:FindFirstChild("FlamesHubBillboard")
    if existing then existing:Destroy() end

    local gui = Instance.new("BillboardGui")
    gui.Name = "FlamesHubBillboard"
    gui.Size = UDim2.new(10,0,1.5,0)
    gui.MaxDistance = math.huge
    gui.AlwaysOnTop = true
    gui.LightInfluence = 0
    gui.StudsOffset = Vector3.new(0,3,0)
    gui.Parent = head

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundColor3 = color
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.3,0)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-10,1,-10)
    label.Position = UDim2.new(0,5,0,5)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Text = text
    label.Parent = frame
end

local function applyForPlayer(plr, payload)
    if not plr or not plr.Character then return end
    clearBillboardForChar(plr.Character)

    if watchedNames[plr.Name] then
        setBillboard(plr.Character,"👑 Flames Hub | OWNER 👑",Color3.fromRGB(0,16,176))
        return
    end

    if type(payload) ~= "table" then return end
    if payload.state == "disable" then return end

    local title = payload.title or "🔥 Flames Hub | CLIENT 🔥"
    local c = payload.color or {255,255,255}
    local color3 = Color3.fromRGB(c[1], c[2], c[3])
    setBillboard(plr.Character, title, color3)
end

local currentStates = {}

local gui = Instance.new("ScreenGui")
gui.Name = "FlamesHubUI"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0,320,0,220)
panel.Position = UDim2.new(1,-330,1,-230)
panel.BackgroundColor3 = Color3.fromRGB(30,30,30)
panel.BorderSizePixel = 0
panel.Parent = gui

local panelCorner = Instance.new("UICorner", panel)
panelCorner.CornerRadius = UDim.new(0,10)

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5,0.5)
shadow.Position = UDim2.new(0.5,0,0.5,0)
shadow.Size = UDim2.new(1,30,1,30)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0,0,0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10,10,118,118)
shadow.Parent = panel

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,24,0,24)
closeBtn.Position = UDim2.new(1,-28,0,4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = panel
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local nameBox = Instance.new("TextBox")
nameBox.Size = UDim2.new(1,-20,0,30)
nameBox.Position = UDim2.new(0,10,0,40)
nameBox.PlaceholderText = "Target username or userId"
nameBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
nameBox.TextColor3 = Color3.fromRGB(255,255,255)
nameBox.Font = Enum.Font.Gotham
nameBox.TextSize = 14
nameBox.Parent = panel
Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0,6)

local titleBox = nameBox:Clone()
titleBox.Position = UDim2.new(0,10,0,80)
titleBox.PlaceholderText = "Title to show"
titleBox.Parent = panel

local selColor = {255,255,255}

local function makeColorBtn(x,text,rgb)
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(0,70,0,26)
   b.Position = UDim2.new(0,x,0,120)
   b.Text = text
   b.Font = Enum.Font.GothamBold
   b.TextSize = 13
   b.BackgroundColor3 = Color3.fromRGB(rgb[1],rgb[2],rgb[3])
   b.TextColor3 = Color3.fromRGB(255,255,255)
   b.Parent = panel
   Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
   b.MouseButton1Click:Connect(function() selColor = rgb end)
end

makeColorBtn(10,"White",{255,255,255})
makeColorBtn(85,"Blue",{0,16,176})
makeColorBtn(160,"Red",{200,30,30})
makeColorBtn(235,"Green",{40,170,40})

local applyBtn = Instance.new("TextButton")
applyBtn.Size = UDim2.new(0,140,0,30)
applyBtn.Position = UDim2.new(0,10,0,160)
applyBtn.Text = "Apply Title"
applyBtn.Font = Enum.Font.GothamBold
applyBtn.TextSize = 14
applyBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
applyBtn.TextColor3 = Color3.fromRGB(255,255,255)
applyBtn.Parent = panel
Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0,6)

local clearBtn = applyBtn:Clone()
clearBtn.Text = "Clear Title"
clearBtn.Position = UDim2.new(0,170,0,160)
clearBtn.Parent = panel

local function resolveTarget(input)
    if not input or input == "" then return nil end
    local n = tonumber(input)
    if n then return Players:GetPlayerByUserId(n) end
    for _,p in ipairs(Players:GetPlayers()) do
        if p.Name:lower() == input:lower() then return p end
    end
    return nil
end

applyBtn.MouseButton1Click:Connect(function()
    local plr = resolveTarget(nameBox.Text)
    if not plr then return end
    local payload = {
        userId = plr.UserId,
        state = "enable",
        title = titleBox.Text ~= "" and titleBox.Text or nil,
        color = selColor
    }
    currentStates[plr.UserId] = payload
    applyForPlayer(plr, payload)
    pcall(function() apiSet(payload) end)
end)

clearBtn.MouseButton1Click:Connect(function()
    local plr = resolveTarget(nameBox.Text)
    if not plr then return end
    local payload = { userId = plr.UserId, state = "disable" }
    currentStates[plr.UserId] = payload
    clearBillboardForChar(plr.Character)
    pcall(function() apiSet(payload) end)
end)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        local payload = currentStates[plr.UserId]
        if payload then applyForPlayer(plr, payload) end
    end)
end)

task.spawn(function()
    while true do
        local states = apiList() or {}
        for id,payload in pairs(states) do
            local uid = tonumber(id)
            if uid then
                if type(payload) ~= "table" then
                payload = { userId = uid, state = payload }
                end
                currentStates[uid] = payload
                local plr = Players:GetPlayerByUserId(uid)
                if plr then applyForPlayer(plr, payload) end
            end
        end
        task.wait(POLL_INTERVAL)
    end
end)
task.wait(0.2)
local Script_Version = "2.2.1-LIFE"

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

if not getgenv().advanced_workaround_method and has_hookfunction and has_hookmetamethod and has_getmetatable and not (executor_Name and executor_Name:lower():find("macsploit")) then
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
elseif executor_Name and executor_Name:lower():find("macsploit") then
    warn("Macsploit detected, skipping...")
    wait(0.1)
    getgenv().advanced_workaround_method = true
end
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
        Name = "🏠 Life Together RP 🏠 | "..tostring(Script_Version).." | "..tostring(executor_Name),
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
wait()
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local Core = Modules:FindFirstChild("Core")
local Game = Modules:FindFirstChild("Game")
local Invisible_Module = require(Game:FindFirstChild("InvisibleMode"))
local Billboard_GUI = require(Game:FindFirstChild("CharacterBillboardGui"))
local PlotMarker = require(Game:FindFirstChild("PlotMarker"))
local Data = require(Core:FindFirstChild("Data"))
local Phone_Module = Game:FindFirstChild("Phone")
local Phone = require(Game:FindFirstChild("Phone"))
local Privacy = require(Core:FindFirstChild("Privacy"))
local AppModules = Phone_Module:FindFirstChild("AppModules")
local Messages = require(AppModules:FindFirstChild("Messages"))
local Network = require(Core:FindFirstChild("Net"))
local AvatarModule = require(AppModules:FindFirstChild("Avatar"))
local CCTV = require(Game:FindFirstChild("CCTV"))
local Tween = require(Core:FindFirstChild("Tween"))
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local CCTV = require(Game:FindFirstChild("CCTV"))
wait(0.2)
getgenv().Modules = Modules
getgenv().Core = Core
getgenv().Game_Folder = Game
getgenv().Net = Network
wait(0.1)
function send_function(...)
   Network.get(...)
end

function send_remote(...)
   Network.send(...)
end
wait(0.1)
getgenv().Get = send_function
getgenv().Send = send_remote
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

function set_invisible(toggle)
    if toggle == true then
        Invisible_Module.enabled.set(true)
    elseif toggle == false then
        Invisible_Module.enabled.set(false)
    else
        return 
    end
end

function invisible_spam(toggle)
    if toggle then
        if getgenv().Spoofed_LifePay_Premium or getgenv().Spoofed_Invisibility then
            getgenv().notify("Heads Up:", "Only you'll see yourself flashing invisibility!", 5)
            task.wait(0.2)
        end
        getgenv().Invisible_Flash = true
        while getgenv().Invisible_Flash == true do
            task.wait(.1)
            set_invisible(true)
            task.wait()
            set_invisible(false)
        end
    else
        getgenv().Invisible_Flash = false
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
        wait(0)
            for _, color in ipairs(colors) do
                if getgenv().RGB_Rainbow_Phone ~= true then return end
                wait(0)
                change_phone_color(color)
            end
        end
    elseif Boolean == false then
        Boolean = false
        getgenv().RGB_Rainbow_Phone = false
        wait(0.4)
        repeat task.wait() until getgenv().RGB_Rainbow_Phone == false
        if getgenv().RGB_Rainbow_Phone == false then
            change_phone_color(Color3.fromRGB(255, 255, 255))
        end
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

local Lighting = cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 0.5)
getgenv().NightVisionEnabled = false

local function ensureColorCorrection(name, props)
    local effect = getgenv().Lighting:FindFirstChild(name)
    if not effect then
        effect = Instance.new("ColorCorrectionEffect")
        effect.Name = name
        effect.Parent = getgenv().Lighting
    end
    for prop, value in pairs(props) do
        effect[prop] = value
    end
    return effect
end

local ccEffects = {
    NightVisionColorCorrection = ensureColorCorrection("NightVisionColorCorrection", {
        Enabled = false,
        Brightness = 0,
        Contrast = -0.1,
        Saturation = -1,
        TintColor = Color3.new(0.6, 1, 0.815686)
    })
}

local vignetteGui = getgenv().PlayerGui:FindFirstChild("VignetteEffect")
if not vignetteGui then
    vignetteGui = Instance.new("ScreenGui")
    vignetteGui.Name = "VignetteEffect"
    vignetteGui.IgnoreGuiInset = true
    vignetteGui.Enabled = false
    vignetteGui.ResetOnSpawn = false
    vignetteGui.Parent = getgenv().PlayerGui
end

local vignetteImage = vignetteGui:FindFirstChildOfClass("ImageLabel")
if not vignetteImage then
    vignetteImage = Instance.new("ImageLabel")
    vignetteImage.Name = "ImageLabel"
    vignetteImage.Active = false
    vignetteImage.BackgroundColor3 = Color3.new(1, 1, 1)
    vignetteImage.BackgroundTransparency = 1
    vignetteImage.BorderColor3 = Color3.new(0, 0, 0)
    vignetteImage.BorderSizePixel = 0
    vignetteImage.Position = UDim2.new(0, 0, 0, 0)
    vignetteImage.Size = UDim2.new(1, 0, 1, 0)
    vignetteImage.Visible = true
    vignetteImage.Image = "rbxassetid://123500368394738"
    vignetteImage.ImageColor3 = Color3.new(1, 1, 1)
    vignetteImage.ImageTransparency = 0
    vignetteImage.ImageRectOffset = Vector2.new(0, 0)
    vignetteImage.ImageRectSize = Vector2.new(0, 0)
    vignetteImage.TileSize = UDim2.new(1, 0, 1, 0)
    vignetteImage.SliceScale = 1
    vignetteImage.SliceCenter = Rect.new(0, 0, 0, 0)
    vignetteImage.ScaleType = Enum.ScaleType.Stretch
    vignetteImage.Parent = vignetteGui
end

getgenv().ToggleNightVision = function(state)
    getgenv().NightVisionEnabled = state
    for _, effect in pairs(ccEffects) do
        effect.Enabled = state
    end
    vignetteGui.Enabled = state
end

function night_vision(toggle)
    if toggle == true then
        getgenv().ToggleNightVision(true)
    elseif toggle == false then
        getgenv().ToggleNightVision(false)
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
    elseif Method == "Error" then
        Phone.show_notification(
            tostring(Title),
            tostring(Text),
            nil,
            "rbxassetid://14930908086"
        )
    end
end

local Workspace = cloneref(game:GetService("Workspace"))
local vehicles_folder = Workspace:WaitForChild("Vehicles")
local run_service = cloneref(game:GetService("RunService"))

function anti_report_func()
    if setfflag then
        pcall(function()
            setfflag("AbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotPercentage", "0")
            setfflag("DFFlagAbuseReportScreenshot", "False")
            setfflag("AbuseReportScreenshotType", "0")
            setfflag("AbuseReportDialogScreenshot", "False")
            setfflag("ScreenshotReportEnabled", "False")
            setfflag("DFLogScreenshotSender", "False")
            setfflag("ScreenshotSubmitPercentage", "0")
            setfflag("EnableBugReporting", "False")
            setfflag("EnableInternalBugReporting", "False")
            setfflag("EnableSilentModeForAbuseReport", "True")
            setfflag("CrashUploadToBacktraceToBacktracePercentage", "0")
            setfflag("CrashUploadToBacktracePercentage", "0")
            setfflag("CrashUploadToBacktraceWindows", "False")
            setfflag("UserReportedCrashUpload", "False")
            setfflag("EnableTraceLogging", "False")
            setfflag("DFLogEnableTraceLogging", "False")
            setfflag("TaskSchedulerEnableLuaGCLog", "False")
            setfflag("DFLogUploadHttpPerformance", "False")
            setfflag("UploadMemoryStats", "False")
            setfflag("UploadImproperShutdownTelemetry", "False")
        end)
        wait()
        print("[Success]:", "Anti Report (__SETUP) has been successfully loaded.")
    else
        warn("[Error]:", "Your executor does not support 'setfflag' to run this!")
    end
end

if getgenv().loaded_anti_report then
    warn("Already loaded anti-report utility!")
else
    anti_report_func()
    wait(0.1)
    getgenv().loaded_anti_report = true
end

getgenv().rainbow_highlight_mode = getgenv().rainbow_highlight_mode or false
getgenv().vehicle_ESP_Connection = getgenv().vehicle_ESP_Connection or {}
getgenv().vehicle_ESP_Active = getgenv().vehicle_ESP_Active or false
local vehicle_folder = getgenv().Workspace:FindFirstChild("Vehicles") or getgenv().Workspace:WaitForChild("Vehicles", 1) or getgenv().Service_Wrap("Workspace"):WaitForChild("Vehicles", 1)

local default_fill_color = Color3.fromRGB(75, 94, 60)
local default_outline_color = Color3.fromRGB(255, 255, 255)

local function apply_highlight(vehicle)
    local highlight = vehicle:FindFirstChild("VehicleESP")
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
        local hl = vehicle:FindFirstChild("VehicleESP")
        if hl then
            hl:Destroy()
        end
    end
end

local function ensure_conn_table()
    if type(getgenv().vehicle_ESP_Connection) ~= "table" then
        getgenv().vehicle_ESP_Connection = {}
    end
    return getgenv().vehicle_ESP_Connection
end

local function start_vehicle_esp()
    local conns = ensure_conn_table()

    if getgenv().vehicle_ESP_Active then return end
    getgenv().vehicle_ESP_Active = true

    for _, vehicle in ipairs(vehicles_folder:GetChildren()) do
        if vehicle:IsA("Model") then
            apply_highlight(vehicle)
        end
    end

    if conns.added and typeof(conns.added) == "RBXScriptConnection" then conns.added:Disconnect() end
    if conns.removed and typeof(conns.removed) == "RBXScriptConnection" then conns.removed:Disconnect() end

    conns.added = vehicles_folder.ChildAdded:Connect(function(child)
        if child:IsA("Model") then
            task.wait(0.1)
            apply_highlight(child)
        end
    end)

    conns.removed = vehicles_folder.ChildRemoved:Connect(function(child)
        local hl = child:FindFirstChild("VehicleESP")
        if hl then
            hl:Destroy()
        end
    end)

    conns.rainbow_active = true
    task.spawn(function()
        while getgenv().vehicle_ESP_Active and conns.rainbow_active do
            if getgenv().rainbow_highlight_mode then
                local t = tick()
                local hue = (t % 5) / 5
                local rainbow = Color3.fromHSV(hue, 1, 1)
                for _, vehicle in ipairs(vehicles_folder:GetChildren()) do
                    local hl = vehicle:FindFirstChild("VehicleESP")
                    if hl then
                        hl.FillColor = rainbow
                    end
                end
            end
            task.wait(0.03)
        end
    end)
end

local function stop_vehicle_esp()
    local conns = ensure_conn_table()
    if not getgenv().vehicle_ESP_Active then return end

    if conns.added and typeof(conns.added) == "RBXScriptConnection" then conns.added:Disconnect() end
    if conns.removed and typeof(conns.removed) == "RBXScriptConnection" then conns.removed:Disconnect() end

    conns.added = nil
    conns.removed = nil
    conns.rainbow_active = false
    getgenv().vehicle_ESP_Active = false

    clear_all_highlights()
end

function highlight_all_cars(Toggle)
    if Toggle == true then
        start_vehicle_esp()
    elseif Toggle == false then
        stop_vehicle_esp()
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
        if not Vehicle:FindFirstChild("VehicleSeat"):FindFirstChild("Siren") then
            return getgenv().notify("Failure:", "Sirens do not exist on this vehicle!", 5)
        end
        wait(0.1)
        Vehicle:FindFirstChild("VehicleSeat"):FindFirstChild("Siren").Volume = 1
    elseif Boolean == false then
        for _, v in pairs(getgenv().Workspace.Vehicles:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("owner").Value == game.Players.LocalPlayer then
                Vehicle = v
            end
        end
        wait(0.2)
        if not Vehicle then return getgenv().notify("Failure:", "Please spawn a vehicle before using this!", 5) end
        if not Vehicle:FindFirstChild("VehicleSeat"):FindFirstChild("Siren") then return getgenv().notify("Failure:", "Sirens do not seem to exist on this vehicle!", 5) end
        wait(0.1)
        Vehicle:FindFirstChild("VehicleSeat"):WaitForChild("Siren").Volume = 0
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

    local MyPlayer = getgenv().LocalPlayer
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

    local maxTries = 100
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

    local MyPlayer = getgenv().LocalPlayer
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

    local maxTries = 100
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

local running_destroy_vehicles = false

function destroy_all_vehicles()
    if running_destroy_vehicles then return getgenv().notify("Failure:", "Destroy All Vehicles is already running!", 5) end
    running_destroy_vehicles = true

    local Players = getgenv().Players
    local LocalPlayer = getgenv().LocalPlayer
    local Character = getgenv().Character
    local Humanoid = getgenv().Humanoid
    local HRP = getgenv().HumanoidRootPart

    if not Character or not Humanoid or not HRP then
        running_destroy_vehicles = false
        return getgenv().notify("Failure:", "Missing Character, Humanoid, or HumanoidRootPart", 5)
    end

    local voidPart = getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)")
    if not voidPart then
        create_kill_part()
        voidPart = getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)")
    end

    local voidCF = voidPart:FindFirstChild("SCRIPT_KILLPART_VOID") and voidPart:FindFirstChild("SCRIPT_KILLPART_VOID").CFrame
    if not voidCF then
        running_destroy_vehicles = false
        return getgenv().notify("Failure:", "Kill part missing", 5)
    end

    local vehicles = getgenv().Workspace:FindFirstChild("Vehicles")
    if not vehicles then
        running_destroy_vehicles = false
        return getgenv().notify("Failure:", "Vehicles folder not found", 5)
    end

    local valid_vehicles = {}

    for _, vehicle in ipairs(vehicles:GetChildren()) do
        if vehicle:IsA("Model") then
            local owner = vehicle:FindFirstChild("owner")
            if owner and owner:IsA("ObjectValue") and owner.Value then
                local isLocked = vehicle:GetAttribute("locked")
                if isLocked ~= true then
                    local seat = vehicle:FindFirstChildWhichIsA("VehicleSeat")
                    if seat and not seat.Occupant then
                        table.insert(valid_vehicles, {model = vehicle, seat = seat})
                    end
                end
            end
        end
    end

    if #valid_vehicles == 0 then
        running_destroy_vehicles = false
        return getgenv().notify("Failure:", "No valid vehicles found to destroy.", 5)
    end

    local oldCF = HRP.CFrame

    for _, entry in ipairs(valid_vehicles) do
        local vehicle = entry.model
        local seat = entry.seat

        Character:PivotTo(seat.CFrame)
        task.wait(0.2)
        seat:Sit(Humanoid)
        task.wait(0.4)
        vehicle:PivotTo(voidCF)
        task.wait(0.5)
    end

    wait(0.1)
    Humanoid:ChangeState(3)
    task.wait(0.1)
    HRP.CFrame = oldCF
    wait()
    running_destroy_vehicles = false
end

function bring_player_to_player(TargetPlayer, DestinationPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    if not DestinationPlayer or not DestinationPlayer.Character then return end

    local targetChar = TargetPlayer.Character
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    local destinationHRP = DestinationPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP or not destinationHRP then return end

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
    wait(0.1)
    if not MyBus then
    spawn_any_vehicle("SchoolBus")
    wait(0.5)
        for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == MyPlayer then
                if v:FindFirstChild("VehicleSeat") then
                    MyBus = v
                    break
                end
            end
        end
    end
    local seat = MyBus:FindFirstChild("VehicleSeat")
    if seat and MyHumanoid then
        MyChar:PivotTo(seat.CFrame)
        task.wait(0.2)
        seat:Sit(MyHumanoid)
    end

    local maxTries = 100
    for i = 1, maxTries do
        local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
        local isSitting = targetHumanoid and targetHumanoid.Sit
        if isSitting then break end

        MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.3, 0))
        task.wait(0.2)
    end
    wait(0.3)
    MyBus:PivotTo(destinationHRP.CFrame + Vector3.new(0, 0.5, 0))
    wait(0.5)
    spawn_any_vehicle("SchoolBus")
    wait(0.4)

    local myHRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
    if getgenv().Humanoid.Sit then
        getgenv().Humanoid:ChangeState(3)
        wait(0.2)
        myHRP.CFrame = Old_CF
        wait(0.4)
        spawn_any_vehicle("Chiron")
    end
    if myHRP then
        myHRP.CFrame = Old_CF
        wait(0.4)
        spawn_any_vehicle("Chiron")
    end
end

function vehicle_skydive_player(TargetPlayer)
    if not TargetPlayer or not TargetPlayer.Character then return end
    local targetChar = TargetPlayer.Character
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end

    local Old_CF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

    local skydive_pos = Vector3.new(-250.02537536621094, 4000.80411911010742, 194.1149139404297)
    local skydive_cf = CFrame.new(skydive_pos)

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

    local maxTries = 100
    for i = 1, maxTries do
        local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
        local isSitting = targetHumanoid and targetHumanoid.Sit
        if isSitting then break end

        MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.3, 0))
        task.wait(0.2)
    end

    wait(0.1)
    MyBus:PivotTo(skydive_cf)
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

task.wait(0.1)

getgenv().SpamFire = false
getgenv().SpamFireLoop = nil
getgenv().DestroyFireConnection = nil
getgenv().HideFireConnection = nil

getgenv().CompletelyHideFlamesComingIn = function(toggle)
    if toggle == true then
        if getgenv().DestroyFireConnection then
            getgenv().DestroyFireConnection:Disconnect()
            getgenv().DestroyFireConnection = nil
        end
        task.wait()
        local function disableFire()
            for i, v in ipairs(workspace:GetChildren()) do
                if v:IsA("Model") and v.Name == "Fire" then
                    local FireModel = v

                    if FireModel:FindFirstChild("Fire") then
                        local FirePart = FireModel:FindFirstChildOfClass("Part")

                        if FirePart:FindFirstChildOfClass("ParticleEmitter") then
                            local FireParticles = FirePart:FindFirstChildOfClass("ParticleEmitter")
                            local Sound = FirePart:FindFirstChildOfClass("Sound")

                            FireParticles.Enabled = false
                            FireParticles.Brightness = 0
                            FireParticles.Transparency = NumberSequence.new(1)
                            FireParticles.Size = NumberSequence.new(0)
                            FireParticles.LightEmission = 0
                            FireParticles.LightInfluence = 0
                            Sound.Playing = false
                            Sound.Volume = 0
                        end
                    end
                end
            end
        end

        disableFire()

        getgenv().DestroyFireConnection = getgenv().Workspace.ChildAdded:Connect(function(model)
            disableFire()
        end)
    elseif toggle == false then
        if getgenv().DestroyFireConnection then
            getgenv().DestroyFireConnection:Disconnect()
            getgenv().DestroyFireConnection = nil
        end
        getgenv().SpamFire = false
    end
end

getgenv().spamming_flames = function(toggle)
    if toggle == true then
        if getgenv().SpamFire then
            return getgenv().notify and getgenv().notify("Failure:", "Flame spam is already enabled!", 5)
        end

        getgenv().CompletelyHideFlamesComingIn(true)
        task.wait(0.2)
        getgenv().SpamFire = true

        if not getgenv().SpamFireLoop then
            getgenv().SpamFireLoop = task.spawn(function()
                while getgenv().SpamFire do
                    task.wait(.2)
                    pcall(function()
                        getgenv().Send("request_fire")
                    end)
                end

                getgenv().SpamFireLoop = nil
            end)
        end
    elseif toggle == false then
        getgenv().SpamFire = false
        getgenv().CompletelyHideFlamesComingIn(false)
    end
end

local Aliases = {
   ["orange justice"] = "orangejustice",
   ["orange_justice"] = "orangejustice",
   ["orangej"] = "orangejustice",
   ["default dance"] = "default",
   ["defaultdance"] = "default",
   ["kotonai"] = "koto",
   ["pop"] = "popular",
   ["glitch"] = "glitching",
   ["buggingout"] = "glitching",
   ["glitchingout"] = "glitching",
   ["glitched"] = "glitching",
   ["vibrating"] = "glitching",
   ["shaking"] = "glitching",
   ["aurafarming"] = "aura",
   ["aurafloating"] = "aura",
   ["aurafloat"] = "aura",
   ["aurafarm"] = "aura",
   ["billyb"] = "billybounce",
   ["billybouncing"] = "billybounce",
   ["bbounce"] = "billybounce",
   ["michaelmyer"] = "michaelmyers",
   ["michaelbounce"] = "michaelmyers"
}

function do_emote(input)
   local Humanoid = getgenv().Humanoid
   if not Humanoid then return end

   local key = input:lower():gsub("%s+", "")
   if Aliases[key] then key = Aliases[key] end

   local emoteList = Emotes[key]
   if emoteList then
      getgenv().Is_Currently_Emoting = true
      local choice = emoteList[math.random(1, #emoteList)]
      local ok, track = Humanoid:PlayEmoteAndGetAnimTrackById(choice)

      local animate = getgenv().Character:FindFirstChild("Animate")
      if animate then
         animate.Disabled = true
      end

      if ok and track then
         task.spawn(function()
            track.Stopped:Wait()
            if animate and animate.Parent then
               animate.Disabled = false
            end
            getgenv().Is_Currently_Emoting = false
         end)
      else
         if animate and animate.Parent then
            animate.Disabled = false
         end
         getgenv().Is_Currently_Emoting = false
      end
   end
end

function disable_emoting()
    local Humanoid = getgenv().Humanoid
    if not Humanoid then return end

    Humanoid.WalkSpeed = 0
    task.wait(1)

    pcall(function()
        for _, v in ipairs(Humanoid:GetPlayingAnimationTracks()) do
            v:Stop()
        end
    end)

    task.wait(0.2)

    local animate = getgenv().Character:FindFirstChild("Animate")
    if animate then
        animate.Disabled = false
    end

    task.wait(0.4)
    Humanoid.WalkSpeed = 16
    getgenv().Is_Currently_Emoting = false
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

    local MyPlayer = getgenv().LocalPlayer
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

    local maxTries = 100
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

function free_emotes()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LmaoItsCrazyBro/qweytguqwebuqt/refs/heads/main/marked_esp_system_ai"))()
end

getgenv().void_loop_enabled = false
wait()
function start_void_loop(TargetPlayer)
    if getgenv().VoidLoopRunning then return end
    getgenv().VoidLoopRunning = true

    task.spawn(function()
        while getgenv().void_loop_enabled == true do
            repeat task.wait(0.2) until TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart")

            local Old_CF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

            local voidPart = getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)")
            if not voidPart then create_kill_part() voidPart = getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)") end
            local voidCF = voidPart:FindFirstChild("SCRIPT_VOIDPART_VOID") and voidPart:FindFirstChild("SCRIPT_VOIDPART_VOID").CFrame
            if not voidCF then return warn("Void CF missing") end

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

            if not MyBus then
                spawn_any_vehicle("SchoolBus")
                task.wait(1)
                continue
            end

            local seat = MyBus:FindFirstChild("VehicleSeat")
            if seat and MyHumanoid then
                MyChar:PivotTo(seat.CFrame)
                task.wait(0.2)
                seat:Sit(MyHumanoid)
            end

            local maxTries = 100
            for i = 1, maxTries do
                local targetHumanoid = TargetPlayer.Character and TargetPlayer.Character:FindFirstChildOfClass("Humanoid")
                if targetHumanoid and targetHumanoid.Sit then break end

                local targetHRP = TargetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not targetHRP then break end
                MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.3, 0))
                task.wait(0.2)
            end

            task.wait(0.1)
            MyBus:PivotTo(voidCF)

            task.wait(0.4)
            local myHRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
            if getgenv().Humanoid and getgenv().Humanoid.Sit then
                getgenv().Humanoid:ChangeState(3)
                task.wait(0.1)
                myHRP.CFrame = Old_CF
                task.wait(0.5)
                spawn_any_vehicle("Chiron")
            elseif myHRP then
                myHRP.CFrame = Old_CF
                task.wait(0.5)
                spawn_any_vehicle("Chiron")
            end

            repeat task.wait(0.5)
            until not (TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") and TargetPlayer.Character.Humanoid.Health > 0)
        end

        getgenv().VoidLoopRunning = false
    end)
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
            wait(0)
            for _, color in ipairs(colors) do
                wait(0)
                if getgenv().Rainbow_Vehicle ~= true then return end
                change_vehicle_color(color, get_vehicle())
            end
        end
    elseif Boolean == false then
        getgenv().Rainbow_Vehicle = false
        Boolean = false
    end
end

wait(0.5)
function change_lifesnap_title(text, color)
    local LifeSnap_Title = getgenv().PlayerGui:FindFirstChild("Phone"):FindFirstChild("LifeSnap"):FindFirstChild("MasterFrame").Holder.Snapblox.TitleGreyFrame.Frame.Title
    if not LifeSnap_Title then
        text = ""
        return warn("function change_lifesnap_title [ERROR]:", "LifeSnap_Title does not exist!")
    end

    LifeSnap_Title.Text = tostring(text)
    LifeSnap_Title.TextColor3 = color
end

if getgenv().PlayerGui:FindFirstChild("Phone"):FindFirstChild("LifeSnap") then
    change_lifesnap_title("-FlamesHub On TOP!-", Color3.fromRGB(50, 205, 0))
else
    warn("LifeSnap doesn't exist in Phone!")
end
wait(0.1)
getgenv().Humanoid.JumpHeight = 7
wait(0.1)
getgenv().spawn_vehicle = Tab4:CreateDropdown({
Name = "Spawn Vehicle (FE)",
Options = {"SWAT Van", "Magic Carpet", "EClass", "TowTruck", "Bicycle", "Fiat500", "Cayenne", "Jetski", "LuggageScooter", "MiniCooper", "GarbageTruck", "EScooter", "Monster Truck", "Yacht", "Stingray", "FireTruck", "VespaPizza", "VespaPolice", "F150", "Police SUV", "Chiron", "Humvee", "Wrangler", "Box Van", "Ambulance", "Urus", "Tesla", "Cybertruck", "RollsRoyce", "GClass", "SVJ", "MX5", "SF90", "Charger SRT", "Evoque", "IceCream Truck", "Vespa", "ATV", "Limo", "Tank", "Smart Car", "Beauford", "SchoolBus", "Sprinter", "GolfKart", "TrackHawk", "Helicopter", "SnowPlow", "Camper Van"},
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

getgenv().FlashInvisiblity_Toggle = Tab2:CreateToggle({
Name = "Flash Invisiblity (FE)",
CurrentValue = false,
Flag = "ToggleFlashInvisiblity",
Callback = function(flash_invisible)
    if flash_invisible then
        invisible_spam(true)
    else
        invisible_spam(false)
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

local Has_Spoofed_Invis
local Has_Spoofed_LifePay
getgenv().Spoofed_LifePay_Premium = getgenv().Spoofed_LifePay_Premium or false
getgenv().Spoofed_Invisibility = getgenv().Spoofed_Invisibility or false
wait(0.1)
if getgenv().Spoofed_Invisibility or getgenv().Spoofed_Invisibility == true then
    Has_Spoofed_Invis = true
else
    Has_Spoofed_Invis = false
end
wait(0.1)
if getgenv().Spoofed_LifePay_Premium or getgenv().Spoofed_LifePay_Premium == true then
    Has_Spoofed_LifePay = true
else
    Has_Spoofed_LifePay = false
end
wait(0.2)
getgenv().SpoofInvis = Tab2:CreateButton({
Name = "Spoof Invisibility GamePass (free Invisibility)",
Callback = function()
    if Has_Spoofed_Invis or Has_Spoofed_Invis == true then
        return getgenv().notify("Failure:", "You've already ran the Invisibility spoofer!", 5)
    end

    wait(0.1)
    if not debug.getupvalue then return show_notification("[Error]:", "Not unsupported in your exploit!", "Error") end

    debug.getupvalue(Data.initiate, 2)("invisible_bought", true)
    wait(0.3)
    getgenv().notify("Success!", "Check the 'Eye' icon at the top left of the screen!", 5)
    wait()
    getgenv().notify("Warning:", "People can still see you even with 'Invisibility' enabled! (sadly)", 5)
end,})

getgenv().SpoofLifePay = Tab2:CreateButton({
Name = "Spoof LifePay (free premium perks, items, cars, etc)",
Callback = function()
    if Has_Spoofed_LifePay or Has_Spoofed_LifePay == true then
        return getgenv().notify("Failure:", "You've already ran the LifePay spoofer!", 5)
    end

    wait(0.1)
    if not debug.getupvalue then return show_notification("[Error]:", "Not unsupported in your exploit!", "Error") end

    local update = debug.getupvalue(Data.initiate, 2)
    update("is_verified", true)
    wait(0.2)
    getgenv().notify("Heads Up:", "Unfortunately premium houses despawn after spawning them with this.", 5)
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

local VEHICLE_NAME = "SchoolBus"
local FLING_SPEED = 200
local ANGULAR_FORCE = Vector3.new(200, 200, 200)
local REJOIN_TIMEOUT = 30
local REJOIN_POLL_RATE = 0.1

getgenv().CarFlingEnabled = false
getgenv().CarFlingConnection = nil

function disable_car_fling()
    getgenv().CarFlingEnabled = false
    if getgenv().CarFlingConnection then
        getgenv().CarFlingConnection:Disconnect()
        getgenv().CarFlingConnection = nil
    end
    getgenv().notify("Success:", "Car Fling has been disabled.", 5)
end

function toggle_car_fling(target_player)
    if getgenv().CarFlingEnabled then
        disable_car_fling()
        return getgenv().notify("Error:", "Car fling already running. Disabling.", 5)
    end

    spawn_any_vehicle(VEHICLE_NAME)
    task.wait(1)

    local vehicle
    for i = 1, 50 do
        for _, v in ipairs(Workspace.Vehicles:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == LocalPlayer then
                vehicle = v
                break
            end
        end
        if vehicle then break end
        task.wait(0.1)
    end

    if not vehicle then
        return getgenv().notify("Failure:", "Could not find owned SchoolBus!", 5)
    end

    if vehicle:GetAttribute("locked") == false then
        lock_vehicle(vehicle)
    end

    if not vehicle.PrimaryPart then
        local root = vehicle:FindFirstChild("Chassis") or vehicle:FindFirstChildWhichIsA("BasePart")
        if root then
            vehicle.PrimaryPart = root
        end
    end

    local seat = vehicle:FindFirstChildWhichIsA("VehicleSeat", true)
    if seat and getgenv().Humanoid then
        getgenv().Character:PivotTo(seat.CFrame * CFrame.new(0, 2, 0))
        task.wait(0.2)
        for i = 1, 10 do
            seat:Sit(getgenv().Humanoid)
            if seat.Occupant == getgenv().Humanoid then break end
            task.wait(0.1)
        end
    else
        return getgenv().notify("Failure:", "Seat not found or no Humanoid!", 5)
    end

    for _, part in ipairs(vehicle:GetDescendants()) do
        if part:IsA("BasePart") then
            local name = part.Name:lower()
            if not string.find(name, "wheel") and not string.find(name, "tire") then
                part.CanCollide = false
            end
        end
    end

    getgenv().CarFlingEnabled = true
    getgenv().notify("Success:", "🚗 Car Fling enabled on: " .. tostring(target_player.Name), 5)

    target_player.CharacterAdded:Connect(function()
        getgenv().notify("Info:", "Target respawned. Retargeting...", 3)
    end)

    getgenv().CarFlingConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().CarFlingEnabled then return end

        if not Players:FindFirstChild(target_player.Name) then
            local rejoined = false
            for i = 1, REJOIN_TIMEOUT / REJOIN_POLL_RATE do
                if Players:FindFirstChild(target_player.Name) then
                    rejoined = true
                    target_player = Players:FindFirstChild(target_player.Name)
                    break
                end
                task.wait(REJOIN_POLL_RATE)
            end

            if not rejoined then
                getgenv().notify("Shutdown:", "Player did not return. Stopping fling.", 5)
                return disable_car_fling()
            end
        end

        local char = target_player.Character
        local targetHRP = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if not targetHRP or not humanoid or not vehicle or not vehicle:IsDescendantOf(Workspace) then return end

        if humanoid.SeatPart then
            humanoid.Sit = false
        end

        local direction = (targetHRP.Position - vehicle:GetPivot().Position).Unit

        vehicle:PivotTo(targetHRP.CFrame * CFrame.new(0, 2, 0))

        if vehicle.PrimaryPart then
            vehicle.PrimaryPart.AssemblyLinearVelocity = direction * FLING_SPEED
            vehicle.PrimaryPart.AssemblyAngularVelocity = Vector3.new(100, 100, 100)
        end

        targetHRP.AssemblyLinearVelocity = direction * FLING_SPEED + Vector3.new(0, 100, 0)
        targetHRP.AssemblyAngularVelocity = ANGULAR_FORCE
    end)
end

getgenv().Car_Fling_FE = Tab3:CreateInput({
Name = "Car Fling Plr (FE, Broken!)",
PlaceholderText = "User Here, can shorten",
RemoveTextAfterFocusLost = true,
Callback = function(car_fling_plr)
    local Target_Car_Fling = findplr(car_fling_plr)

    if not Target_Car_Fling then
        return getgenv().notify("Failure:", tostring(car_fling_plr).." does not exist!", 5)
    end

    if Target_Car_Fling.Character and Target_Car_Fling.Character:FindFirstChild("Humanoid") and getgenv().Character then
        toggle_car_fling(Target_Car_Fling)
    end
end,})

getgenv().FreeEmotesGUI = Tab2:CreateButton({
Name = "Free Emotes GUI (UGC Emotes Supported!)",
Callback = function()
    free_emotes()
end,})

getgenv().StopCar_FlingScript = Tab3:CreateButton({
Name = "Stop/Shutdown Car Fling",
Callback = function()
    disable_car_fling()
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

local AntiSit_WasEnabled = false
local Anti_Sit_Connection
wait(0.1)
getgenv().Anti_Sit_Func = Tab2:CreateToggle({
Name = "Anti Sit (FE, Fully Fixed!)",
CurrentValue = false,
Flag = "AntiSitScriptFunc",
Callback = function(is_antisit_enabled)
    if is_antisit_enabled then
        local is_enabled = require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.get()

        getgenv().Not_Ever_Sitting = true
        AntiSit_WasEnabled = true

        if not is_enabled or is_enabled == false then
            Phone.show_notification("Failure:", "NoSit/AntiSit is already enabled!")
            return notify("Failure:", "NoSit/AntiSit is already enabled!", 5)
        end

        getgenv().notify("Success:", "Anti-Sit/No-Sit is now enabled!", 5)
        Phone.show_notification("Success:", "AntiSit/NoSit is now enabled!")
        wait(0.2)
        while getgenv().Not_Ever_Sitting == true do
        task.wait()
            require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(false)
        end
    else
        AntiSit_WasEnabled = false
        local is_enabled = require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.get()
      
        if is_enabled or is_enabled == true then
            Phone.show_notification("Failure:", "Sitting is already enabled!")
            return notify("Failure:", "Sitting is already enabled!", 5)
        end

        getgenv().Not_Ever_Sitting = false
        wait(1)
        require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(true)
        wait(0.1)
        notify("Success:", "Sitting is now enabled!", 5)
        Phone.show_notification("Success:", "Sitting is now enabled!")
    end
end,})
wait(0.2)
local Phone_GUI = getgenv().PlayerGui:FindFirstChild("Phone")
if not Phone_GUI then
    if getgenv().NoNotifications_Phone then
        getgenv().NoNotifications_Phone:Set(false)
    end
    getgenv().notify("Failure:", "Phone GUI does not exist in LocalPlayer's PlayerGui!", 5)
end
local Settings_Gui_Phone = Phone_GUI:FindFirstChild("Settings")
if not Settings_Gui_Phone then
    if getgenv().NoNotifications_Phone then
        getgenv().NoNotifications_Phone:Set(false)
    end
    getgenv().notify("Failure:", "Settings GUI does not exist in Phone GUI!", 5)
end
local Master_Frame = Settings_Gui_Phone:FindFirstChild("MasterFrame")
if not Master_Frame then
    if getgenv().NoNotifications_Phone then
        getgenv().NoNotifications_Phone:Set(false)
    end
    getgenv().notify("Failure:", "MasterFrame : Frame does not exist in Settings-Phone GUI!", 5)
end
local Holder_Frame = Master_Frame:FindFirstChild("Holder")
if not Holder_Frame then
    if getgenv().NoNotifications_Phone then
        getgenv().NoNotifications_Phone:Set(false)
    end
end
local Settings_Frame = Holder_Frame:FindFirstChild("Settings")
if not Settings_Frame then
    if getgenv().NoNotifications_Phone then
        getgenv().NoNotifications_Phone:Set(false)
    end
end
local SettingsSliderFrame = Settings_Frame:FindFirstChild("SettingsSliderFrame")
if not SettingsSliderFrame then
    if getgenv().NoNotifications_Phone then
        getgenv().NoNotifications_Phone:Set(false)
    end
end

local all_buttons_parent = SettingsSliderFrame:FindFirstChild("SettingsNotificationsHolder")
if not all_buttons_parent then
    if getgenv().NoNotifications_Phone then
        getgenv().NoNotifications_Phone:Set(false)
    end
    getgenv().notify("Error:", "This was probably patched, cannot find SettingsNotifsHolder", 5)
end

local App_Modules = Phone_Module:FindFirstChild("AppModules")
local Phone_Module = getgenv().Game_Folder:FindFirstChild("Phone")
local Games = App_Modules:FindFirstChild("Games")
local All_Apps = {}
local all_buttons_tbl = {}

local function FindModule(folder, name)
    local found = folder:FindFirstChild(name)
    if not found then
        warn("Missing module:", name)
    end
    return found
end

local function collect_all_buttons()
    for _, v in ipairs(all_buttons_parent:GetChildren()) do
        if v:IsA("TextButton") then
            table.insert(all_buttons_tbl, v)
        end
    end
end

local function isColorClose(color1, color2, tolerance)
    tolerance = tolerance or 2
    return math.abs(color1.R - color2.R) < tolerance / 255 and
        math.abs(color1.G - color2.G) < tolerance / 255 and
        math.abs(color1.B - color2.B) < tolerance / 255
end

local function isEnabled(button)
    local toggleFrame = button:FindFirstChild("NotificationsToggle")
    if toggleFrame and toggleFrame:IsA("Frame") then
        return isColorClose(toggleFrame.BackgroundColor3, Color3.fromRGB(110, 220, 95))
    end
    return false
end

if type(all_buttons_tbl) == "table" and next(all_buttons_tbl) == nil then
    collect_all_buttons()
end

local Old_WorkspaceFallen_Destroy_Height = getgenv().Workspace.FallenPartsDestroyHeight
wait()
local preset_modules = {
    ["Balloon Game"] = FindModule(Games, "Balloon Game"),
    ["Bouncy Bird"] = FindModule(Games, "Bouncy Bird"),
    ["Monster Slayer"] = FindModule(Games, "Monster Slayer"),
    ["Pocket Cookies"] = FindModule(Games, "Pocket Cookies"),
    ["Stacking Blocks"] = FindModule(Games, "Stacking Blocks"),
}

for _, v in ipairs(App_Modules:GetChildren()) do
    table.insert(All_Apps, v)
end
wait(0.3)
getgenv().NoNotifications_Phone = Tab5:CreateToggle({
Name = "No Phone Notifications",
CurrentValue = false,
Flag = "DisableNotifsForPhone",
Callback = function(phone_notifs_off)
    if phone_notifs_off then
        wait(0.1)
        local Phone_Module = getgenv().Game_Folder:FindFirstChild("Phone")
        local App_Modules = Phone_Module:FindFirstChild("AppModules")
        local Games = App_Modules:FindFirstChild("Games")
        local Games_Module = require(App_Modules:FindFirstChild("Games"))
        getgenv().Notifications_Off = true
        if not firesignal then
            if getgenv().NoNotifications_Phone then
                getgenv().NoNotifications_Phone:Set(false)
            end
            return getgenv().notify("Error:", "You cannot use this! 'firesignal' not supported!", 5)
        end

        function FireButtonEvent(button)
            local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
            if button and (button:IsA("ImageButton") or button:IsA("TextButton")) then
                for _, signal in pairs(Signals) do
                    if button[signal] then
                        local success, err = pcall(function()
                            firesignal(button[signal])
                        end)
                        if not success then
                            warn("Failed to fire:", signal, err)
                        end
                    end
                end
            else
                warn("Invalid button:", button)
            end
        end

        task.wait(0.3)

        for _, button in ipairs(all_buttons_tbl) do
            if isEnabled(button) then
                FireButtonEvent(button)
            end
        end
        wait(0.1)
        while getgenv().Notifications_Off == true do
        wait(0.3)
            for _, app in pairs(All_Apps) do
                getgenv().Send("clear_notification_log", tostring(app.Name))
                getgenv().Send("notification_settings", "Messages", false)
                getgenv().Send("notification_settings", "LifeSnap", false)
                getgenv().Send("notification_settings", "PhoneApp", false)
                getgenv().Send("notification_settings", "Home", false)
                getgenv().Send("notification_settings", "Matcher", false)
            end
        end
    else
        getgenv().Notifications_Off = false
        getgenv().Notifications_Off = false
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

getgenv().DisableNotificationsScript = Tab1:CreateButton({
Name = "Disable Notifications",
Callback = function()
    print("Disabled notifications successfully.")
    getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub = true
end,})

getgenv().EnableNotificationsScript = Tab1:CreateButton({
Name = "Enable Notifications",
Callback = function()
    print("Enabled notifications successfully.")
    getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub = false
end,})

getgenv().IgnoreNotifications_Disable = Tab1:CreateToggle({
Name = "Toggle notification visibility (enable/disable notifs)",
CurrentValue = getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub,
Flag = "IgnoreNotificationsInstead",
Callback = function(notificatios_enabled)
    if notifications_enabled then
        getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub = false
    else
        getgenv().Is_ActivelyIgnoring_NotAllowing_Notifications_Flames_Hub = true
    end
end,})

local Rain = require(getgenv().LocalPlayer:FindFirstChildOfClass("PlayerScripts"):FindFirstChild("RainScript"):FindFirstChild("Rain", true)) or require(getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerScripts"):FindFirstChild("RainScript"):FindFirstChild("Rain"))
local rainbowConnection
task.wait(0.2)
getgenv().startRainbow = function()
    if rainbowConnection then rainbowConnection:Disconnect() end
    
    local hue = 0
    rainbowConnection = getgenv().RunService.RenderStepped:Connect(function(deltaTime)
        hue = (hue + deltaTime * 0.1) % 1
        Rain:SetColor(Color3.fromHSV(hue, 1, 1))
    end)
end
task.wait(0.2)
getgenv().stopRainbow = function()
    local Rain = require(getgenv().LocalPlayer:FindFirstChildOfClass("PlayerScripts"):FindFirstChild("RainScript"):FindFirstChild("Rain", true)) or require(getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerScripts"):FindFirstChild("RainScript"):FindFirstChild("Rain"))
    if not Rain then return getgenv().notify("Failure:", "Rain ModuleScript doesn't exist (destroyed?)", 5) end
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end
    Rain:Disable()
    Rain:SetColor(Color3.fromRGB(255, 255, 255))
    Rain:SetVolume(0.2)
    Rain:SetTransparency(0)
end
task.wait(0.1)
getgenv().RainbowRain_NotFE = Tab3:CreateToggle({
Name = "Rainbow Rain (Not FE, Working!)",
CurrentValue = false,
Flag = "NotFERainbowRain",
Callback = function(rainbow_rain_toggle)
    if rainbow_rain_toggle then
        local RunService = getgenv().RunService
        local Rain_Script = getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerScripts"):FindFirstChild("RainScript")
        local Rain_Module = Rain_Script:FindFirstChild("Rain") or Rain_Script:WaitForChild("Rain", 3)
        if not Rain_Module then
            return getgenv().notify("Failure:", "Rain ModuleScript was not found!", 5)
        end
        local Rain = require(Rain_Module)
        wait(0.1)
        getgenv().Rainbow_Rain = true
        wait()
        Rain:Enable()
        Rain:SetVolume(0.8)
        Rain:SetDirection(Vector3.new(0, -1, 0))
        Rain:SetTransparency(0)
        getgenv().startRainbow()
    else
        getgenv().stopRainbow()
    end
end,})
task.wait(0.2)
if getgenv().Rainbow_Rain or getgenv().Rainbow_Rain == true then
    getgenv().Rainbow_Rain = false
    getgenv().RainbowRain_NotFE:Set(false)
    getgenv().stopRainbow()
end

local Players = rawget and rawget(getgenv(), "Players")
    or getgenv().Players
    or getgenv().Service_Wrap("Players")
    or (cloneref and cloneref(game:GetService("Players")))
    or game:GetService("Players")

local Char = require(Core:WaitForChild("Char"))

local function is_empty(desc, slot)
    return not desc[slot] or desc[slot] == "" or desc[slot] == "0"
end

local function unequip_slot(desc, slot)
    if not is_empty(desc, slot) then
        for id in string.gmatch(desc[slot], "[^,]+") do
            getgenv().Get("wear", tonumber(id), slot)
            task.wait(0.3)
        end
    end
end

local AccessorySlots = {
    "BackAccessory","ShouldersAccessory","FrontAccessory","WaistAccessory",
    "NeckAccessory","HairAccessory","HatAccessory","FaceAccessory",
    "Shirt","Pants",
}

getgenv().OutfitBusy = getgenv().OutfitBusy or false
getgenv().OutfitToken = getgenv().OutfitToken or 0

local function change_outfit(notify_title, notify_msg, success_msg, items, desc)
    local myToken = tick()
    getgenv().OutfitToken = myToken

    if getgenv().OutfitBusy then
        return getgenv().notify("Hang On:", "Already changing outfit, please wait...", 5)
    end
    getgenv().OutfitBusy = true

    getgenv().notify(notify_title, notify_msg, 5)

    if desc then
        for _, slot in ipairs(AccessorySlots) do
            if myToken ~= getgenv().OutfitToken then
                getgenv().notify("Cancelled", "Switched to new request.", 5)
                getgenv().OutfitBusy = false
                return
            end
            unequip_slot(desc, slot)
            task.wait(0.3)
        end
    end

    task.wait(0.2)
    for _, v in ipairs(items) do
        if myToken ~= getgenv().OutfitToken then
            getgenv().notify("Cancelled", "Switched to new request.", 5)
            getgenv().OutfitBusy = false
            return
        end

        if v[1] == "wear" then
            getgenv().Get("wear", v[2], v[3])
        elseif v[1] == "remote" then
            getgenv().Send(v[2], v[3], v[4])
        elseif v[1] == "wearBatch" then
            getgenv().Get("batch_wear", v[2])
        elseif v[1] == "code" then
            getgenv().Get("code", v[2], v[3])
        end
        task.wait(0.8)
    end

    getgenv().notify("Success:", success_msg, 5)
    getgenv().OutfitBusy = false
end

getgenv().StealPlayerItemsOffAvatar = Tab3:CreateInput({
Name = "Steal Players Avatar Items (FE)",
CurrentValue = "User Here",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Flag = "StealAllOfAPlayersItemsFE",
Callback = function(PlayerToStealFrom)
    local TargetAvatar = findplr(PlayerToStealFrom)
    if not TargetAvatar then
        return getgenv().notify("Failure:", "Player does not exist.", 5)
    end

    local userId = TargetAvatar.UserId
    local desc = Char.get_desc_from_id(userId)
    if not desc then
        return getgenv().notify("Failure:", "Could not fetch description.", 5)
    end

    local items = {}

    if not is_empty(desc, "Shirt") then
        table.insert(items, {"code", tonumber(desc.Shirt), "Shirt"})
    end
    if not is_empty(desc, "Pants") then
        table.insert(items, {"code", tonumber(desc.Pants), "Pants"})
    end
    if not is_empty(desc, "GraphicTShirt") then
        table.insert(items, {"code", tonumber(desc.GraphicTShirt), "ShirtGraphic"})
    end

    for _, slot in ipairs({
        "BackAccessory","ShouldersAccessory","FrontAccessory","WaistAccessory",
        "NeckAccessory","HairAccessory","HatAccessory","FaceAccessory"
    }) do
        local val = desc[slot]
        if not is_empty(desc, slot) then
            for id in string.gmatch(val, "[^,]+") do
                table.insert(items, {"code", tonumber(id), slot})
            end
        end
    end

    if not is_empty(desc, "Face") then
        table.insert(items, {"code", tonumber(desc.Face), "Face"})
    end

    local AnimationSlots = {
        "ClimbAnimation","FallAnimation","IdleAnimation","JumpAnimation",
        "RunAnimation","SwimAnimation","WalkAnimation"
    }
    local anims = {}
    for _, slot in ipairs(AnimationSlots) do
        if not is_empty(desc, slot) then
            table.insert(anims, {tonumber(desc[slot]), slot, true})
        end
    end
    if #anims > 0 then
        table.insert(items, {"wearBatch", anims})
    end

    change_outfit(
        "Hold On:",
        "Copying ".. TargetAvatar.Name .."'s avatar...",
        "Successfully copied ".. TargetAvatar.Name .."'s avatar!",
        items,
        desc
    )
end,})

local Anti_Teleport_Toggled_Saved = false
wait(0.1)
getgenv().AntiTeleport_Univ = Tab2:CreateToggle({
Name = "Anti Teleport",
CurrentValue = false,
Flag = "AntiTeleportToggleUniversal",
Callback = function(anti_teleport_toggle)
    if anti_teleport_toggle then
        getgenv().AntiTeleport = true
        getgenv().AntiTeleportConnection = nil
        Anti_Teleport_Toggled_Saved = true

        local Players = getgenv().Players
        local RunService = getgenv().RunService
        local LocalPlayer = getgenv().LocalPlayer
        repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        local Character = getgenv().Character
        local HRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
        local lastCFrame = HRP.CFrame

        local maxDistance = 5
        local checkInterval = 0.05

        getgenv().AntiTeleportConnection = task.spawn(function()
            while task.wait(checkInterval) do
                if not getgenv().AntiTeleport then
                    lastCFrame = HRP.CFrame
                    continue
                end

                if LocalPlayer.Character ~= Character then
                    Character = LocalPlayer.Character
                    HRP = getgenv().HumanoidRootPart
                    lastCFrame = HRP.CFrame
                end

                if (HRP.Position - lastCFrame.Position).Magnitude > maxDistance then
                    warn("[Anti-Teleport_DEBUG]: Teleport detected. Reverting.")
                    pcall(function()
                        HRP.CFrame = lastCFrame
                    end)
                else
                    lastCFrame = HRP.CFrame
                end
            end
        end)
    else
        getgenv().AntiTeleport = false
        Anti_Teleport_Toggled_Saved = false

        pcall(function()
            task.cancel(getgenv().AntiTeleportConnection)
            getgenv().AntiTeleportConnection = nil
        end)
    end
end,})
wait(0.2)
local PlotAreas = {}

for _, v in ipairs(getgenv().Workspace:GetDescendants()) do
    if v:IsA("BasePart") and v.Name == "PlotArea" then
        table.insert(PlotAreas, v)
    end
end
wait(0.1)
getgenv().AutoAntiBan_House = Tab1:CreateToggle({
Name = "Anti Ban/Kick From Houses",
CurrentValue = false,
Flag = "NoBanningOrKickingFromHomes",
Callback = function(anti_ban_kick_from_homes)
    if anti_ban_kick_from_homes then
        if Anti_Teleport_Toggled_Saved == true then
            notify(".", ".", 0.2)
        else
            getgenv().AntiTeleport_Univ:Set(true)
        end
        wait()
        getgenv().never_banned_houses = true
        while getgenv().never_banned_houses == true do
        wait()
            for _, v in ipairs(PlotAreas) do
                v.CanCollide = false
            end
        end
    else
        getgenv().never_banned_houses = false
        wait(0.1)
        if Anti_Teleport_Toggled_Saved == true then
            getgenv().AntiTeleport_Univ:Set(true)
        else
            getgenv().AntiTeleport_Univ:Set(false)
        end
    end
end,})

local RunService = getgenv().RunService
local Players = getgenv().Players
local Workspace = getgenv().Workspace
local LocalPlayer = getgenv().LocalPlayer
local IYMouse = LocalPlayer:GetMouse()

local function getRoot(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

local function make_fling_parts(root)
    if not root then return nil end
    local bav = Instance.new("BodyAngularVelocity")
    bav.Name = (randomString and randomString() or "bav_fling")
    bav.AngularVelocity = Vector3.new(90000, 90000, 90000)
    bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bav.P = math.huge
    bav.Parent = root

    local bv = Instance.new("BodyVelocity")
    bv.Name = (randomString and randomString() or "bv_fling")
    bv.Velocity = Vector3.new(0,0,0)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent = root

    return { root = root, bav = bav, bv = bv }
end

local function safe_disconnect(c)
    if not c then return end
    if type(c) == "table" or type(c) == "userdata" then
        pcall(function() c:Disconnect() end)
    end
end

getgenv().FlingPlayerStop = function()
    safe_disconnect(getgenv().MainLoop); getgenv().MainLoop = nil
    safe_disconnect(getgenv().FlyLoop); getgenv().FlyLoop = nil
    safe_disconnect(getgenv().CamChanged); getgenv().CamChanged = nil
    safe_disconnect(getgenv()._fling_local_char_conn); getgenv()._fling_local_char_conn = nil
    safe_disconnect(getgenv()._fling_target_char_conn); getgenv()._fling_target_char_conn = nil

    if getgenv()._fling_parts then
        local root = getgenv()._fling_parts.root
        if root and root:IsDescendantOf(game) then
            for _, c in ipairs(root:GetChildren()) do
                if c:IsA("BodyAngularVelocity") or c:IsA("BodyVelocity") then
                    pcall(function() c:Destroy() end)
                end
            end
        end
        getgenv()._fling_parts = nil
    end

    getgenv().Workspace.CurrentCamera.CameraSubject = getgenv().Humanoid or getgenv().Character or getgenv().Character:FindFirstChildWhichIsA("Humanoid")
    require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(true)

    if getgenv().notify then pcall(getgenv().notify, "Stopped:", "Fling disabled.", 5) end
    getgenv()._fling_target = nil
end

getgenv().FlingPlayerLockOn = function(target, distance, lDelay)
    local plr = target
    if type(plr) == "string" then
        if findplr then plr = findplr(plr) else plr = Players:FindFirstChild(plr) end
    end
    if not plr or not plr:IsA("Player") then
        return getgenv().notify and getgenv().notify("Failure:", "Player does not exist.", 5)
    end

    distance = tonumber(distance) or 0
    lDelay = tonumber(lDelay) or 0.12

    getgenv().FlingPlayerStop()
    task.wait(0.04)

    getgenv()._fling_target = plr
    getgenv().CONTROL = getgenv().CONTROL or {F=0,B=0,L=0,R=0,Q=0,E=0}
    getgenv().FLYING = getgenv().FLYING or false
    getgenv().FLING_PUSH_SPEED = getgenv().FLING_PUSH_SPEED or 80
    getgenv().FLING_UPWARD = getgenv().FLING_UPWARD or 18
    getgenv().FLING_OVERRIDE_FLY = (getgenv().FLING_OVERRIDE_FLY == nil) and true or getgenv().FLING_OVERRIDE_FLY
    getgenv()._last_cam_fix = getgenv()._last_cam_fix or 0

    local function attach()
        safe_disconnect(getgenv().MainLoop); getgenv().MainLoop = nil
        safe_disconnect(getgenv().CamChanged); getgenv().CamChanged = nil

        local lastFollow = 0
        local followThrottle = lDelay

        getgenv().MainLoop = RunService.Stepped:Connect(function()
            local myChar = getgenv().Character or (LocalPlayer and LocalPlayer.Character)
            local myRoot = getgenv().HumanoidRootPart or (myChar and getRoot(myChar))
            local myHum = getgenv().Humanoid or (myChar and myChar:FindFirstChildOfClass("Humanoid"))
            local camera = (getgenv().Workspace and getgenv().Workspace.CurrentCamera) or Workspace.CurrentCamera
            local pl = getgenv()._fling_target

            if not pl or not pl.Character or not myChar or not myRoot or not myHum then
                return
            end

            if not getgenv()._fling_parts or getgenv()._fling_parts.root ~= myRoot then
                if getgenv()._fling_parts then
                    pcall(function()
                        if getgenv()._fling_parts.bav then getgenv()._fling_parts.bav:Destroy() end
                        if getgenv()._fling_parts.bv then getgenv()._fling_parts.bv:Destroy() end
                    end)
                    getgenv()._fling_parts = nil
                end
                getgenv()._fling_parts = make_fling_parts(myRoot)
            end

            local targetRoot = getRoot(pl.Character)
            if not targetRoot or targetRoot.Position.Y <= -1000 then
                return
            end

            if (getgenv().FLING_OVERRIDE_FLY or not getgenv().FLYING) then
                if followThrottle <= 0 or (tick() - lastFollow) >= followThrottle then
                    local targetHum = pl.Character and pl.Character:FindFirstChildOfClass("Humanoid")
                    local targetRoot = getRoot(pl.Character)

                    if targetRoot and targetHum then
                        local velocityThreshold = 0.1
                        local isMoving = targetRoot.Velocity.Magnitude > velocityThreshold

                        local newCFrame
                        if isMoving then
                            local front_offset = 5 * targetRoot.CFrame.LookVector
                            newCFrame = CFrame.new(targetRoot.Position + front_offset, targetRoot.Position)
                        else
                            newCFrame = targetRoot.CFrame
                        end

                        pcall(function()
                            myRoot.CFrame = newCFrame
                        end)
                    end

                    lastFollow = tick()
                end
            end

            if camera and camera.CameraSubject ~= pl.Character and (tick() - (getgenv()._last_cam_fix or 0) > 0.12) then
                pcall(function()
                    camera.CameraSubject = pl.Character
                    getgenv()._last_cam_fix = tick()
                end)
            end

            if not getgenv()._fling_bambam then
                local myChar = getgenv().Character or LocalPlayer.Character
                local root = getRoot(myChar)
                for _, child in pairs(myChar:GetDescendants()) do
                    if child:IsA("BasePart") then
                        child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
                        child.CanCollide = false
                        child.Massless = true
                        child.Velocity = Vector3.new(0,0,0)
                    end
                end

                local bambam = Instance.new("BodyAngularVelocity")
                bambam.Name = randomString and randomString() or "bambam_fling"
                bambam.Parent = root
                bambam.AngularVelocity = Vector3.new(0,99999,0)
                bambam.MaxTorque = Vector3.new(0, math.huge, 0)
                bambam.P = math.huge

                getgenv()._fling_bambam = bambam
                getgenv()._flinging = true

                local humanoid = myChar:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    getgenv()._fling_died_conn = humanoid.Died:Connect(function()
                        getgenv()._flinging = false
                        if getgenv()._fling_bambam then
                            pcall(function() getgenv()._fling_bambam:Destroy() end)
                            getgenv()._fling_bambam = nil
                        end
                    end)
                end
            end

            if getgenv()._fling_bambam and getgenv()._flinging then
                local bambam = getgenv()._fling_bambam
                bambam.AngularVelocity = Vector3.new(0,99999,0)
                task.delay(0.2, function()
                    if bambam then pcall(function() bambam.AngularVelocity = Vector3.new(0,0,0) end) end
                end)
            end
        end)

        local _changing_camera = false
        local camRef = getgenv().Workspace.CurrentCamera

        getgenv().CamChanged = camRef:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            if _changing_camera then return end
            local pl = getgenv()._fling_target
            if not pl or not pl.Character then return end
            if tick() - (getgenv()._last_cam_fix or 0) < 0.12 then return end

            _changing_camera = true
            pcall(function()
                camRef.CameraSubject = pl.Character
                getgenv()._last_cam_fix = tick()
            end)
            _changing_camera = false
        end)
    end

    attach()

    safe_disconnect(getgenv()._fling_local_char_conn)
    getgenv()._fling_local_char_conn = LocalPlayer.CharacterAdded:Connect(function()
        task.wait()
        if getgenv()._fling_target then task.defer(attach) end
    end)

    safe_disconnect(getgenv()._fling_target_char_conn)
    getgenv()._fling_target_char_conn = plr.CharacterAdded:Connect(function()
        task.wait()
        if getgenv()._fling_target == plr then task.defer(attach) end
    end)

    if getgenv().notify then pcall(getgenv().notify, "Success:", "Locking onto "..plr.Name.." (auto reattach enabled)", 5) end
end
task.wait(0.1)
getgenv().FlingPlayer_FE = Tab3:CreateInput({
Name = "Fling Player (auto locks to)",
CurrentValue = "User Here",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Flag = "FlingPlayerWithAutoLockAntiVoidEtc",
Callback = function(PlayerToFling_FE)
    local PlayerTo_FindForFling = findplr(PlayerToFling_FE)
    if not PlayerTo_FindForFling then return getgenv().notify("Failure:", "Player does not exist.", 5) end
    
    getgenv().CurrentlyFlinging_ThisPlr = PlayerTo_FindForFling
    require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(false)
    getgenv().Workspace.FallenPartsDestroyHeight = 0
    task.wait(0.3)
    getgenv().FlingPlayerLockOn(PlayerTo_FindForFling, 0, 0)
end,})

getgenv().DisableFlingPlayerFE = Tab3:CreateButton({
Name = "Fully Shutdown/Disable Fling Player",
Callback = function()
    getgenv().FlingPlayerStop()
    wait(0.1)
    getgenv().Humanoid.Health = 0
    getgenv().CurrentlyFlinging_ThisPlr = nil
end,})

getgenv().Players.PlayerRemoving:Connect(function(Player)
    if getgenv().CurrentlyFlinging_ThisPlr == Player then
        getgenv().FlingPlayerStop()
        task.wait(0.2)
        getgenv().Humanoid.Health = 0
        getgenv().CurrentlyFlinging_ThisPlr = nil
    else
        return 
    end
end)

getgenv().DestroyFlameParticlesNoLag = Tab2:CreateToggle({
Name = "Destroy Flames",
CurrentValue = false,
Flag = "CompletelyDestroyFlamesConn",
Callback = function(destroying_flames)
    if destroying_flames then
        if getgenv().DestroyParticlesConnection then
            getgenv().DestroyFlameParticlesNoLag:Set(false)
            getgenv().CompletelyHideFlamesComingIn(false)
            return getgenv().notify("Failure:", "Something happened (toggled to fast? toggled twice?)", 5)
        end

        getgenv().CompletelyHideFlamesComingIn(true)
    else
        getgenv().CompletelyHideFlamesComingIn(false)
    end
end,})

getgenv().FlamSpamAbsoluteChaos = Tab2:CreateToggle({
Name = "Flame Spam (FE)",
CurrentValue = false,
Flag = "AbsoluteFlamesSpamFE",
Callback = function(spamming_fire)
    if spamming_fire then
        getgenv().spamming_flames(true)
    else
        getgenv().spamming_flames(false)
    end
end,})

getgenv().FrozenChar = Tab2:CreateToggle({
Name = "Freeze Your Character",
CurrentValue = false,
Flag = "AntiMovement",
Callback = function(hasFrozenChar)
    if hasFrozenChar then
        local Character = getgenv().Character
        local Workspace_Service = getgenv().Workspace
        local HumanoidRootPart = getgenv().HumanoidRootPart
        getgenv().FreezingChar = true
        if Character and HumanoidRootPart or Character:FindFirstChild("HuamnoidRootPart") then
            if getgenv().FreezingChar == true then
                HumanoidRootPart.Anchored = true
            end
        else
            getgenv().FreezingChar = false
        end
    else
        local Character = getgenv().Character
        local HumanoidRootPart = getgenv().HumanoidRootPart
        if Character and HumanoidRootPart or Character:FindFirstChild("HumanoidRootPart") then
            getgenv().FreezingChar = false
            wait(0.1)
            HumanoidRootPart.Anchored = false
        else
            getgenv().FreezingChar = false
        end
    end
end,})

wait()
getgenv().AntiFlingToggle = Tab2:CreateToggle({
Name = "Anti Fling",
CurrentValue = false,
Flag = "AntiFlingAbsolutelyInsane",
Callback = function(EnableAntiFlingScript)
    if EnableAntiFlingScript then
        if getgenv().antiFlingEnabled or getgenv().antiFlingEnabled == true then
            return getgenv().notify("Failure:", "Anti Fling is already enabled!", 5)
        end

        getgenv().antiFlingEnabled = true
        getgenv().antiKnockbackEnabled = true

        local RunService = getgenv().RunService
        local Players = getgenv().Players
        local lp = getgenv().LocalPlayer

        local function cleanUpForces()
            local hrp = getgenv().HumanoidRootPart
            if not hrp then return end

            for _, obj in ipairs(hrp:GetChildren()) do
                if obj:IsA("BodyMover") or obj:IsA("VectorForce") or obj:IsA("Torque") or obj:IsA("LinearVelocity") then
                    obj:Destroy()
                end
            end
        end

        getgenv().notify("Success:", "Enabled anti-fling, you will not be able to be flung.", 5)

        local function onHeartbeat()
            if not (getgenv().antiKnockbackEnabled or getgenv().antiFlingEnabled) then return end

            local hrp = getgenv().HumanoidRootPart
            local humanoid = lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
            if not hrp or not humanoid then return end

            local maxSpeed = 60
            local maxAngularSpeed = 70

            if hrp.Velocity.Magnitude > maxSpeed then
                hrp.Velocity = hrp.Velocity.Unit * maxSpeed
            end

            if hrp.AssemblyLinearVelocity.Magnitude > maxSpeed then
                hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity.Unit * maxSpeed
            end

            if hrp.RotVelocity.Magnitude > maxAngularSpeed then
                hrp.RotVelocity = Vector3.zero
            end

            if hrp.AssemblyAngularVelocity.Magnitude > maxAngularSpeed then
                hrp.AssemblyAngularVelocity = Vector3.zero
            end

            if humanoid.PlatformStand then
                humanoid.PlatformStand = false
            end
            wait()
            cleanUpForces()
        end

        if getgenv().anti_knockback_connection then
            getgenv().anti_knockback_connection:Disconnect()
            getgenv().anti_knockback_connection = nil
        end
        wait(0.2)
        getgenv().anti_knockback_connection = RunService.Heartbeat:Connect(onHeartbeat)
    else
        getgenv().antiFlingEnabled = false
        getgenv().antiKnockbackEnabled = false

        getgenv().notify("Success:", "Disabled anti-fling", 5)

        if getgenv().anti_knockback_connection then
            getgenv().anti_knockback_connection:Disconnect()
            getgenv().anti_knockback_connection = nil
        end
    end
end,})

getgenv().HD_FlyEnabled = false
local FlyConnection
local speed = 100
getgenv().HD_Admin_Fly_Speed = speed

function DisableFlyScript()
    getgenv().HD_FlyEnabled = false

    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end

    if getgenv().PlayerGui:FindFirstChild("FlyControls") then
        getgenv().PlayerGui:FindFirstChild("FlyControls"):Destroy()
    end

    local hrp = getgenv().HumanoidRootPart
    if hrp:FindFirstChild("ExecutorFlyGyro") then
        hrp.ExecutorFlyGyro:Destroy()
    end
    if hrp:FindFirstChild("ExecutorFlyPosition") then
        hrp.ExecutorFlyPosition:Destroy()
    end

    if getgenv().Humanoid or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid") or getgenv().Character:FindFirstChildOfClass("Humanoid") then
        getgenv().Humanoid.PlatformStand = false
    end
end

function EnableFly(speed)
    local player = getgenv().LocalPlayer
    local HRP = getgenv().HumanoidRootPart
    local Humanoid = getgenv().Humanoid
    local Camera = getgenv().Camera
    local RunService = getgenv().RunService
    local UIS = getgenv().UserInputService
    speed = tonumber(speed) or 125

    if not (HRP and Humanoid and Camera) then return end

    getgenv().HD_FlyEnabled = true
    local vertical = 0

    local function createMobileFlyButtons()
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "FlyControls"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.IgnoreGuiInset = true
        ScreenGui.Parent = getgenv().PlayerGui

        local function makeArrowButton(name, position, text)
            local btn = Instance.new("TextButton")
            btn.Name = name
            btn.Text = text
            btn.Size = UDim2.new(0, 60, 0, 60)
            btn.Position = position
            btn.AnchorPoint = Vector2.new(1, 1)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextScaled = true
            btn.BorderSizePixel = 0
            btn.AutoButtonColor = true
            btn.BackgroundTransparency = 0.2
            btn.Parent = ScreenGui
            return btn
        end

        local upBtn = makeArrowButton("FlyUp", UDim2.new(1, -20, 1, -140), "↑")
        local downBtn = makeArrowButton("FlyDown", UDim2.new(1, -20, 1, -70), "↓")

        upBtn.MouseButton1Down:Connect(function()
            vertical = 1
        end)
        upBtn.MouseButton1Up:Connect(function()
            vertical = 0
        end)
        downBtn.MouseButton1Down:Connect(function()
            vertical = -1
        end)
        downBtn.MouseButton1Up:Connect(function()
            vertical = 0
        end)

        return ScreenGui
    end

    local isTouch = UIS.TouchEnabled or UIS.KeyboardEnabled == false
    local mobileGui
    if isTouch then
        mobileGui = createMobileFlyButtons()
    end

    UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.E then vertical = 1 end
        if input.KeyCode == Enum.KeyCode.Q then vertical = -1 end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.Q then
            vertical = 0
        end
    end)

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

    FlyConnection = RunService.RenderStepped:Connect(function(dt)
        if not getgenv().HD_FlyEnabled then
            bodyGyro:Destroy()
            bodyPos:Destroy()
            Humanoid.PlatformStand = false
            FlyConnection:Disconnect()
            if mobileGui then mobileGui:Destroy() end
            return
        end

        local moveDir = Humanoid.MoveDirection
        local movement = moveDir * speed
        local verticalMove = Vector3.new(0, vertical * speed, 0)
        bodyPos.Position = HRP.Position + movement + verticalMove
        bodyGyro.CFrame = CFrame.new(HRP.Position, HRP.Position + Camera.CFrame.LookVector)
    end)
end
wait(0.2)
getgenv().HDAdminFly_Speed = Tab2:CreateSlider({
Name = "HD Admin Fly Speed",
Range = {75, 300},
Increment = 1,
Suffix = "",
CurrentValue = 50,
Flag = "EditFlySpeedHDAdmin",
Callback = function(HDAdminFlySpeed_Edit)
    speed = tonumber(HDAdminFlySpeed_Edit)
    getgenv().HD_Admin_Fly_Speed = tonumber(HDAdminFlySpeed_Edit)
end,})
wait(0.1)
getgenv().HDAdminFly = Tab2:CreateToggle({
Name = "HD Admin Fly (FE!)",
CurrentValue = false,
Flag = "FlyHDAdmin",
Callback = function(toggle_hd_fly)
    if toggle_hd_fly then
        local UserInputService = getgenv().UserInputService

        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            getgenv().notify("Note:", "Use the controls menu to fly up and down.", 10)
        elseif UserInputService.KeyboardEnabled then
            getgenv().notify("Note:", "E = Fly Up | Q = Fly Down.", 10)
        else
            getgenv().notify("Failure:", "What device are you even on bro?", 5)
        end
    
        EnableFly(getgenv().HD_Admin_Fly_Speed)
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
        getgenv().loop_turn_off_notifications = true
        while getgenv().loop_turn_off_notifications == true do
        wait()
            set_call_notifications(true)
        end
    else
        getgenv().loop_turn_off_notifications = false
        wait(1)
        if getgenv().loop_turn_off_notifications == false then
            getgenv().notify("Success:", "Disabling 'Black All Call Notifs'...", 5)
            wait()
            set_call_notifications(false)
            wait(0.2)
            getgenv().notify("Success:", "Successfully disabled 'Black Call Notifs'.", 5)
        else
            getgenv().notify("Waiting:", "Waiting until loop is fully turned off.", 5)
            repeat task.wait() until getgenv().loop_turn_off_notifications == false

            if getgenv().loop_turn_off_notifications == false then
                getgenv().notify("Success:", "Disabling 'Black All Call Notifs'...", 5)
                wait()
                set_call_notifications(false)
                wait(0.2)
                getgenv().notify("Success:", "Successfully disabled 'Black Call Notifs'.", 5)
            end
        end
    end
end,})

getgenv().ChangePhoneColor = Tab5:CreateColorPicker({
Name = "Change Phone Color (FE)",
Color = Color3.fromRGB(0, 0, 0),
Flag = "PhoneColorPicker",
Callback = function(new_color_for_phone)
    change_phone_color(new_color_for_phone)
end,})

getgenv().CarLockLoopRunning = false
wait()
getgenv().LockVehicle_FE = Tab4:CreateToggle({
Name = "Lock Vehicle (FE)",
CurrentValue = false,
Flag = "LockVehicleScriptFE",
Callback = function(car_locked)
    if car_locked then
        if getgenv().CarLockLoopRunning then return end

        getgenv().my_car_locked = true
        getgenv().CarLockLoopRunning = true

        task.spawn(function()
            while getgenv().my_car_locked == true do
                wait(0.1)
                local vehicle = get_vehicle()

                if vehicle then
                    if vehicle:GetAttribute("locked") == false then
                        lock_vehicle(vehicle)
                    end
                else
                    local Vehicle = get_vehicle()

                    getgenv().my_car_locked = false
                    getgenv().CarLockLoopRunning = false
                    getgenv().LockVehicle_FE:Set(false)
                    task.wait(0.6)
                    lock_vehicle(Vehicle)
                    getgenv().notify("Heads Up:", "Disabled loop — vehicle was destroyed or despawned.", 5)
                    return 
                end
            end

            getgenv().CarLockLoopRunning = false
        end)
    else
        getgenv().my_car_locked = false
        wait(0.2)
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

getgenv().NightVision_ClientSide = Tab3:CreateToggle({
Name = "NightVision (Not FE)",
CurrentValue = false,
Flag = "NightVisionCurrentlyEnabled",
Callback = function(night_vision_enabled)
    if night_vision_enabled then
        night_vision(true)
    else
        night_vision(false)
    end
end,})

getgenv().SitIn_Vehicle_FE = Tab4:CreateButton({
Name = "Sit In Vehicle",
Callback = function()
    local My_Vehicle = get_vehicle()
    if not My_Vehicle then return getgenv().notify("Error:", "No car, spawn one!", 5) end

    if not My_Vehicle:FindFirstChild("VehicleSeat") then
        return getgenv().notify("Failure:", "The vehicle spawned does not have a Vehicle Seat!", 5)
    end

    sit_in_vehicle(My_Vehicle)
end,})

getgenv().server_admin_teleport = Tab2:CreateInput({
Name = "(VIP-SERVER ONLY): Server Admin TP Plr",
PlaceholderText = "User Here, can be shortened",
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
    local ScanRadius_Part = MetalDetector:FindFirstChild("ScanRadius")
    if not RemoveRadius_Part:FindFirstChildOfClass("TouchTransmitter") then return end
    if not ScanRadius_Part:FindFirstChildOfClass("TouchTransmitter") then return end
    if RemoveRadius_Part:FindFirstChildWhichIsA("TouchTransmitter") then
        RemoveRadius_Part:FindFirstChildOfClass("TouchTransmitter"):Destroy()
    end
    if ScanRadius_Part:FindFirstChildWhichIsA("TouchTransmitter") then
        ScanRadius_Part:FindFirstChildOfClass("TouchTransmitter"):Destroy()
    end
end,})

local Animations_Table = {
    {
        619535091,
        "ClimbAnimation",
        true
    },
    {
        619535616,
        "FallAnimation",
        true
    },
    {
        619535834,
        "IdleAnimation",
        true
    },
    {
        619536283,
        "JumpAnimation",
        true
    },
    {
        619536621,
        "RunAnimation",
        true
    },
    {
        619537096,
        "SwimAnimation",
        true
    },
    {
        619537468,
        "WalkAnimation",
        true
    }
}

local function is_empty(desc, slot)
    local v = desc and desc[slot]
    return (not v or v == "" or v == "0")
end

local function unequip_slot(desc, slot)
    if not is_empty(desc, slot) then
        for id in string.gmatch(desc[slot], "[^,]+") do
            getgenv().Get("wear", tonumber(id), slot)
            task.wait(0.2)
        end
    end
end

local desc = getgenv().Humanoid and getgenv().Humanoid:FindFirstChildWhichIsA("HumanoidDescription")

local AccessorySlots = {
    "BackAccessory",
    "ShouldersAccessory",
    "FrontAccessory",
    "WaistAccessory",
    "NeckAccessory",
    "HairAccessory",
    "HatAccessory",
    "FaceAccessory",
    "Shirt",
    "Pants",
}

local function change_outfit(notify_title, notify_msg, success_msg, items)
    getgenv().notify(notify_title, notify_msg, 5)

    if desc then
        for _, slot in ipairs(AccessorySlots) do
            getgenv().notify("Hang On:", "Unequipping old accessories...", 5)
            unequip_slot(desc, slot)
            task.wait(0.3)
        end
    end
    task.wait(0.2)
    for _, v in ipairs(items) do
        if v[1] == "wear" then
            getgenv().Get("wear", v[2], v[3])
        elseif v[1] == "remote" then
            getgenv().Send(v[2], v[3], v[4])
        elseif v[1] == "wearBatch" then
            getgenv().Get("batch_wear", v[2])
        elseif v[1] == "code" then
            getgenv().Get("code", v[2], v[3])
        end
        task.wait(0.8)
    end

    getgenv().notify("Success:", success_msg, 5)
end

getgenv().ChangeIntoOwnerFit1 = Tab1:CreateButton({
Name = "Change Into Owner (Mine, Outfit 1)",
Callback = function()
    change_outfit(
        "Hold On:", "Wearing Owner Outfit 1...",
        "Successfully wore Owner Outfit 1.",
        {
            {"code", 114590304845243, "Pants"},
            {"code", 16045355146, "Shirt"},
            {"remote", "skin_tone", Color3.fromRGB(120, 65, 38)},
            {"wearBatch", Animations_Table},
            {"code", 98831355295667, "HairAccessory"},
            {"code", 10430104072, "Hat"},
            {"code", 10678423, "Face"},
            {"code", 13734096288, "FaceAccessory"},
            {"code", 17652885791, "ShoulderAccessory"},
            {"code", 79729101518083, "ShoulderAccessory"},
            {"code", 76070025258274, "ShoulderAccessory"},
            {"remote", "body_scale", "HeightScale", 100},
            {"remote", "body_scale", "WidthScale", 100}
        }
    )
end,})

getgenv().ChangeIntoOwnerFit2 = Tab1:CreateButton({
Name = "Change Into Owner (Mine, Outfit 2)",
Callback = function()
    change_outfit(
        "Hang On:", "Wearing Owner Outfit 2...",
        "Successfully wore Owner Outfit 2.",
        {
            {"code", 11532061305, "Pants"},
            {"code", 6267476410, "Shirt"},
            {"remote", "skin_tone", Color3.fromRGB(120, 65, 38)},
            {"wearBatch", Animations_Table},
            {"code", 15056056442, "Hat"},
            {"code", 87719366970131, "HairAccessory"},
            {"code", 13265134760, "FaceAccessory"},
            {"code", 15655024838, "Hat"},
            {"code", 150182378, "Face"},
            {"code", 14123983540, "FaceAccessory"},
            {"code", 17223945302, "NeckAccessory"},
            {"code", 18312780078, "BackAccessory"},
            {"code", 80104766014684, "WaistAccessory"},
            {"code", 84418052877367, "RightLeg"},
            {"code", 124343282827669, "LeftLeg"},
            {"code", 92757812011061, "Torso"},
            {"code", 99519402284266, "RightArm"},
            {"code", 115905570886697, "LeftArm"},
            {"remote", "body_scale", "HeightScale", 105},
            {"remote", "body_scale", "WidthScale", 95}
        }
    )
end,})
wait(0.2)
local function is_empty(desc, slot)
    local v = desc and desc[slot]
    return (not v or v == "" or v == "0")
end

local function split_ids(str)
    local t = {}
    for id in string.gmatch(str, "[^,]+") do
        table.insert(t, tonumber(id))
    end
    return t
end

local AccessorySlots = {
    "BackAccessory","ShouldersAccessory","FrontAccessory",
    "WaistAccessory","NeckAccessory","HairAccessory",
    "HatAccessory","FaceAccessory","Shirt","Pants"
}

local function snapshot_outfit()
    local desc = getgenv().Humanoid and getgenv().Humanoid:GetAppliedDescription()
    local snapshot = {}
    if desc then
        for _, slot in ipairs(AccessorySlots) do
            if not is_empty(desc, slot) then
                snapshot[slot] = split_ids(desc[slot])
            end
        end

        if desc.Face and desc.Face ~= 0 then
            snapshot["Face"] = {desc.Face}
        end
        if desc.Head and desc.Head ~= 0 then
            snapshot["Head"] = {desc.Head}
        end
    end
    return snapshot
end

local function unequip_all()
    local desc = getgenv().Humanoid:GetAppliedDescription()
    if desc then
        for _, slot in ipairs(AccessorySlots) do
            if not is_empty(desc, slot) then
                for _, id in ipairs(split_ids(desc[slot])) do
                    getgenv().Get("wear", id, slot)
                    task.wait(0.15)
                end
            end
        end
    end
end

local function restore_outfit(snapshot)
    for slot, ids in pairs(snapshot) do
        for _, id in ipairs(ids) do
            getgenv().Send("code", id, slot)
            task.wait(0.2)
        end
    end
end

local OldSnapshot
local JumpPower_Old, JumpHeight_Old
local CurrentAge = AvatarModule.age.get()

getgenv().CatInvisGlitchOutfit = Tab2:CreateToggle({
Name = "Cat Invisible Glitch Outfit (FE)",
CurrentValue = false,
Flag = "CatInvisGlitchOutfitWearFEFunc",
Callback = function(using_cat_glitch_outfit)
    if using_cat_glitch_outfit then
        OldSnapshot = snapshot_outfit()
        CurrentAge = AvatarModule.age.get()
        JumpPower_Old = getgenv().Humanoid.JumpPower
        JumpHeight_Old = getgenv().Humanoid.JumpHeight
        wait(0.2)
        getgenv().Get("save_outfit")
        wait(0.5)
        unequip_all()
        task.wait(0.3)
        getgenv().Send("code", 116433640227939, "JacketAccessory")
        task.wait(0.2)
        getgenv().Send("hide_name", true)
        task.wait(0.2)
        getgenv().Get("age", "baby")
        task.wait(0.2)
        getgenv().Send("code", 15093053680, "DynamicHead")
        getgenv().Humanoid.JumpPower = 0
        getgenv().Humanoid.JumpHeight = 0
    else
        getgenv().notify("Success:", "Disabling Cat Glitch, restoring avatar, please WAIT...", 5)

        if OldSnapshot then
            restore_outfit(OldSnapshot)
        end
        wait(2.5)
        getgenv().Send("wear", 15093053680, "DynamicHead")
        getgenv().Send("wear", 116433640227939, "JacketAccessory")
        getgenv().Humanoid.JumpPower = JumpPower_Old
        getgenv().Humanoid.JumpHeight = JumpHeight_Old
        getgenv().Get("age", CurrentAge)
        getgenv().Send("hide_name", false)
    end
end,})
wait(0.2)
if getgenv().LockHouseLoopRunning or getgenv().LockHouseLoopRunning == true then
    getgenv().LockHouseLoopRunning = false
end
if getgenv().my_home_locked or getgenv().my_home_locked == true then
    getgenv().my_home_locked = false
end
wait()
getgenv().LockHouse_FE = Tab1:CreateToggle({
Name = "Lock House (FE)",
CurrentValue = false,
Flag = "LockHouseScriptFE",
Callback = function(house_locked)
    if house_locked then
        if getgenv().LockHouseLoopRunning then return end
        wait(0.1)
        getgenv().my_home_locked = true
        getgenv().LockHouseLoopRunning = true

        task.spawn(function()
            local lastLockedState = true

            while getgenv().my_home_locked == true do
                wait(0.2)
                for _, plot in pairs(PlotMarker.class.objects) do
                    local owner = plot.states.owner.get()

                    if owner == game.Players.LocalPlayer then
                        local isLocked = plot.states.locked.get()

                        if isLocked == false and lastLockedState == true then
                            send_remote("lock_home", plot.instance)
                            lastLockedState = false
                        elseif isLocked == true then
                            lastLockedState = true
                        end
                    end
                end
            end

            getgenv().LockHouseLoopRunning = false
        end)
    else
        getgenv().my_home_locked = false
    end
end,})
wait(0.1)
if getgenv().my_home_locked or getgenv().my_home_locked == true then
    getgenv().my_home_locked = false
    getgenv().LockHouse_FE:Set(false)
end

local ReplicatedStorage = getgenv().ReplicatedStorage
local Workspace = getgenv().Workspace
local LocalPlayer = getgenv().LocalPlayer
local House_Options = {}
local House_IDToPlot = {}

local function GetHouseDropdownOptions()
    local map = Workspace:FindFirstChild("Map")
    local house_plots = map and map:FindFirstChild("HousePlots")
    if not house_plots then return {} end

    for _, plot in ipairs(house_plots:GetChildren()) do
        if plot:IsA("Model") and plot:FindFirstChild("owner") and plot:FindFirstChild("built_house") then
            local house_value = plot.built_house.Value
            if not house_value then
                continue
            end

            local house_name = house_value.Name

            if plot.owner.Value == LocalPlayer then
                house_name = house_name .. " (Your House)"
            end

            local unique_id = tostring(plot:GetDebugId())
            local dropdown_name = house_name .. " [" .. unique_id .. "]"

            table.insert(House_Options, dropdown_name)
            House_IDToPlot[unique_id] = plot
        end
    end

    return House_Options
end

local house_options = GetHouseDropdownOptions()

local function GetCCTVFromHouseModel(house_model)
    if not house_model then
        return getgenv().notify("Failure:", "No house model provided", 5)
    end

    local exterior = house_model:FindFirstChild("Exterior")
    if not exterior then
        return getgenv().notify("Failure:", "Missing 'Exterior' in house model: " .. house_model.Name, 5)
    end

    local cams = exterior:FindFirstChild("SecurityCameras")
    if not cams then
        return getgenv().notify("Failure:", "Missing 'SecurityCameras' in Exterior of: " .. house_model.Name, 5)
    end

    local cam = cams:FindFirstChild("SecurityCamera")
    if not cam then
        return getgenv().notify("Failure:", "Missing 'SecurityCamera' in SecurityCameras of: " .. house_model.Name, 5)
    end

    local red_dot = cam:FindFirstChild("RedDot")
    if not red_dot then
        return getgenv().notify("Failure:", "Missing 'RedDot' in SecurityCamera of: " .. house_model.Name, 5)
    end

    return red_dot, cams
end

getgenv().ViewAnyHousesCCTVCameras = Tab1:CreateDropdown({
Name = "View Any House's CCTV Camera(s)",
Options = house_options,
CurrentOption = "",
MultipleOptions = false,
Flag = "house_reddot_slot_select",
Callback = function(selected_option)
    local selected_str = typeof(selected_option) == "table" and selected_option[1] or selected_option
    local house_id = selected_str:match("%[(.-)%]$")
    local plot = House_IDToPlot[house_id]

    if not plot then
        return getgenv().notify("Failure:", "Could not find plot for: " .. tostring(selected_option), 5)
    end

    local house_model = plot.built_house.Value
    if not house_model then
        return getgenv().notify("Failure:", "built_house has no value for plot: " .. plot.Name, 5)
    end

    local red_dot, camera_folder = GetCCTVFromHouseModel(house_model)
    if not red_dot or not camera_folder then return end

    send_remote("replication_focus", red_dot)
    wait(0.1)
    CCTV.start(camera_folder)
end,})
wait(0.1)
getgenv().RefreshCCTVDropdown = Tab1:CreateButton({
Name = "🔄 Refresh CCTV Dropdown 🔄",
Callback = function()
    table.clear(House_Options)
    table.clear(House_IDToPlot)

    local new_options = GetHouseDropdownOptions()
    wait(0.1)
    getgenv().ViewAnyHousesCCTVCameras:Refresh(new_options)
end,})

getgenv().UnviewCCTVCamera = Tab1:CreateButton({
Name = "Unview CCTV Camera",
Callback = function()
    CCTV.stop()
    send_remote("restore_replication_focus")
end,})

getgenv().DoAnEmote = Tab2:CreateDropdown({
Name = "Do An Emote (FE)",
Options = EmoteNames,
CurrentOption = "",
MultipleOptions = false,
Flag = "SelectAnEmoteToPlay",
Callback = function(dance_emote)
    local selected_str = typeof(dance_emote) == "table" and dance_emote[1] or dance_emote

    if typeof(selected_str) == "string" or type(selected_str) == "string" then
        do_emote(selected_str)
    else
        return getgenv().notify("Failure:", "This is most likely being worked on.", 5)
    end
end,})

getgenv().stopEmotingScript = Tab2:CreateButton({
Name = "Stop Emoting",
Callback = function()
    disable_emoting()
end,})

getgenv().Hiding_NameLoop = Tab2:CreateToggle({
Name = "Hide/Unhide Name Loop (FE)",
CurrentValue = false,
Flag = "HidingNameCoolLoop",
Callback = function(hiding_name_looping)
    if hiding_name_looping then
        getgenv().cool_naming_loop_hiding = true
        while getgenv().cool_naming_loop_hiding == true do
        wait()
            getgenv().Send("hide_name", true)
            wait(0.1)
            getgenv().Send("hide_name", false)
        end
    else
        getgenv().cool_naming_loop_hiding = false
        getgenv().cool_naming_loop_hiding = false
        wait(1)
        if getgenv().cool_naming_loop_hiding == false then
            getgenv().Send("hide_name", false)
        else
            getgenv().notify("Hang On:", "The loop has not shutdown yet, waiting...", 5)
            wait(3)
            if getgenv().cool_naming_loop_hiding == false then
                getgenv().notify("Success:", "Shut down loop, enabling name...", 5)
                wait()
                getgenv().Send("hide_name", false)
                wait(0.3)
                getgenv().notify("Success:", "Enabled name visual setting.", 5)
            end
        end
    end
end,})

function disableRainbowEffect()
    getgenv().rainbow_flashlight_enabled = false
    if getgenv().heartbeatConnection then
        getgenv().heartbeatConnection:Disconnect()
        getgenv().heartbeatConnection = nil
    end
    getgenv().notify("Success:", "Rainbow Flashlight effect has been disabled!", 5)
end
wait(0.2)
getgenv().RainbowFlashlight_NotFE = Tab2:CreateToggle({
Name = "Smooth Rainbow Flashlight (Not FE!)",
CurrentValue = false,
Flag = "SmootheningFlashlightColoring",
Callback = function(smooth_RGB_flashlight)
    if smooth_RGB_flashlight then
        local Phone_GUI = getgenv().PlayerGui:FindFirstChild("Phone") or getgenv().PlayerGui:FindFirstChild("Phone", true) or getgenv().PlayerGui:WaitForChild("Phone", 3)
        if not Phone_GUI then return notify("Failure:", "Phone GUI not found in PlayerGui! (maybe patched?)", 5) end
        local Phone_Settings = Phone_GUI:FindFirstChild("Settings")
        if not Phone_Settings then return notify("Failure:", "Phone Settings Frame not found in Phone GUI! (maybe patched?)", 5) end
        local Master_Frame = Phone_Settings:FindFirstChild("MasterFrame")
        if not Master_Frame then return notify("Failure:", "Master Frame not found in Phone Settings Frame! (maybe patched?)", 5) end
        local Holder_Frame = Master_Frame:FindFirstChild("Holder")
        if not Master_Frame then return notify("Failure:", "Holder Frame not found in Master Frame (maybe patched?)", 5) end
        local Settings_Frame = Holder_Frame:FindFirstChild("Settings")
        if not Settings_Frame then return notify("Failure:", "Settings Frame not found in Holder Frame! (maybe patched?)", 5) end
        local Settings_SliderFrame = Settings_Frame:FindFirstChild("SettingsSliderFrame")
        if not Settings_SliderFrame then return notify("Failure:", "Settings Frame not found in Settings Frame! (maybe patched?)", 5) end
        local Settings_Main_Options = Settings_SliderFrame:FindFirstChild("SettingsMainOptions")
        if not Settings_Main_Options then return notify("Failure:", "Settings Main Frame not found in Slider Frame! (maybe patched?)", 5) end
        local Flashlight_SettingsOption = Settings_Main_Options:FindFirstChild("FlashlightSettingsOption")
        if not Flashlight_SettingsOption then return notify("Failure:", "Flashlight Option not found in Settings Main Options! (maybe patched?)", 5) end
        local Notifications_ToggleFlashlight = Flashlight_SettingsOption:FindFirstChild("NotificationsToggle")
        if not Notifications_ToggleFlashlight then return notify("Failure:", "Flashlight Toggle not found in Flashlight Option Frame! (maybe patched?)", 5) end
        wait(0.3)
        local ts = getgenv().TweenService
        local rs = getgenv().RunService
        getgenv().heartbeatConnection = nil
        getgenv().rainbow_flashlight_enabled = true

        if Notifications_ToggleFlashlight.BackgroundColor3 == Color3.new(110, 220, 95) then
            warn("Flashlight already enabled.")
        elseif Notifications_ToggleFlashlight.BackgroundColor3 == Color3.fromRGB(110, 220, 95) then
            warn("Flashlight already enabled.")
        elseif Notifications_ToggleFlashlight.BackgroundColor3 == Color3.new(221, 221, 221) then
            getgenv().Send("flashlight", true)
        elseif Notifications_ToggleFlashlight.BackgroundColor3 == Color3.fromRGB(221, 221, 221) then
            getgenv().Send("flashlight", true)
        end

        local flashlight = getgenv().HumanoidRootPart:FindFirstChild("Flashlight")
        if not flashlight or not flashlight:IsA("SpotLight") then
            return getgenv().notify("Error:", "Flashlight/SpotLight doesn't exist in HumanoidRootPart!", 5)
        end
        flashlight.Brightness = 10

        getgenv().heartbeatConnection = rs.Heartbeat:Connect(function()
            if getgenv().rainbow_flashlight_enabled then
                local hue = (tick() * 10) % 360
                local color = Color3.fromHSV(hue / 360, 1, 1)

                local tween = ts:Create(flashlight, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    Color = color
                })
                tween:Play()
            else
                flashlight.Color = Color3.fromRGB(255, 255, 255)
            end
        end)
    else
        disableRainbowEffect()
    end
end,})

getgenv().BeEveryJob = Tab2:CreateToggle({
Name = "Job Spammer (FE)",
CurrentValue = false,
Flag = "JobSpammerEzPz",
Callback = function(spamming_jobs)
    if spamming_jobs then
        getgenv().Every_Job = true
        while getgenv().Every_Job == true do
        task.wait(0)
            getgenv().Send("job", "Police")
            task.wait()
            getgenv().Send("job", "Firefighter")
            task.wait()
            getgenv().Send("job", "Baker")
            task.wait()
            getgenv().Send("job", "Pizza Worker")
            task.wait()
            getgenv().Send("job", "Janitor")
            task.wait()
            getgenv().Send("job", "Mechanic")
            task.wait()
            getgenv().Send("job", "Barista")
            task.wait()
            getgenv().Send("job", "Doctor")
            task.wait()
            getgenv().Send("job", "Prisoner")
            task.wait()
            getgenv().Send("job", "Nurse")
            task.wait()
            getgenv().Send("job", "Student")
            task.wait()
            getgenv().Send("job", "Teacher")
            task.wait()
            getgenv().Send("job", "Principal")
            task.wait()
            getgenv().Send("job", "Lifeguard")
            task.wait()
            getgenv().Send("job")
        end
    else
        getgenv().Every_Job = false
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

-- I don't think this will ever work lmao.
--[[getgenv().View_Plr_SmoothTween = Tab3:CreateInput({
Name = "View Player (Smooth)",
PlaceholderText = "User Here, can be shortened",
RemoveTextAfterFocusLost = true,
Callback = function(user_to_view)
    local target_to_view = findplr(user_to_view)
    if not target_to_view then return notify("Failure:", "User does not seem to exist.", 5) end

    local Cam = require(getgenv().Core:FindFirstChild("Cam"))
    local Ambulance = getgenv().Vehicles:FindFirstChild("Ambulance")

    local part = Ambulance:FindFirstChild("Base")
    Cam.tween_to_character(1)
end,})--]]

-- This is broken right now, and is currently being worked on.
--[[getgenv().LoopVehicleVoid_PlrFE = Tab3:CreateInput({
Name = "Loop Vehicle Void Player (FE)",
PlaceholderText = "User Here, can be shortened",
RemoveTextAfterFocusLost = true,
Callback = function(loop_void_this_plr)
    local void_loop_plr = findplr(loop_void_this_plr)
    if not void_loop_plr then return show_notification("Error:", "Player does not exist!", "Warning") end

    getgenv().void_loop_enabled = true
    start_void_loop(void_loop_plr)
end,})

getgenv().TurnOffLoopVehicleVoid = Tab3:CreateButton({
Name = "Disable Vehicle Void Loop",
Callback = function()
    getgenv().void_loop_enabled = false
    getgenv().void_loop_enabled = false
end,})--]]

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
        return getgenv().notify("Failure:", "You cannot Bring yourself (wtf).", 5)
    end
end,})

getgenv().VehicleBring = Tab3:CreateButton({
Name = "Destroy All Vehicles (FE)",
Callback = function()
    destroy_all_vehicles()
end,})

getgenv().VehicleSkydive = Tab1:CreateInput({
Name = "Vehicle Skydive Player (FE)",
PlaceholderText = "User Here, can be shortened",
RemoveTextAfterFocusLost = true,
Callback = function(user_to_skydive)
    local target = findplr(user_to_skydive)
    if not target then return getgenv().notify("Failure:", "User does not seem to exist.", 5) end

    if target and target.Character then
        spawn_any_vehicle("SchoolBus")
        wait(1)
        vehicle_skydive_player(target)
    elseif target == getgenv().LocalPlayer or target == getgenv().LocalPlayer.Name then
        return getgenv().notify("Failure:", "You cannot Skydive yourself (wtf).", 5)
    end
end,})

getgenv().VehiclePlayerToPlr2 = Tab1:CreateInput({
Name = "Vehicle TP Player1 to Player2",
PlaceholderText = "User1, User2 (comma separated)",
RemoveTextAfterFocusLost = true,
Callback = function(inputText)
    local splitNames = {}
    for name in string.gmatch(inputText, "([^,]+)") do
        table.insert(splitNames, name:match("^%s*(.-)%s*$"))
    end

    if #splitNames < 2 then
        return show_notification("Error:", "You must enter both Player1 and Player2 names separated by a comma!", "Warning")
    end

    local player1, player2 = splitNames[1], splitNames[2]

    local Target1 = findplr(player1)
    if not Target1 then
        return show_notification("Error:", "Player1 does not exist!", "Warning")
    end

    local Target2 = findplr(player2)
    if not Target2 then
        return show_notification("Error:", "Player2 does not exist!", "Warning")
    end

    bring_player_to_player(Target1, Target2)
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
        return getgenv().notify("Failure:", "You cannot Kill yourself (wtf).", 5)
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

getgenv().Accel0To60 = Tab4:CreateSlider({
Name = "Accel 0 To 60",
Range = {0.1, 10},
Increment = 0.1,
Suffix = "",
CurrentValue = 0.2,
Flag = "Edit0To60ValueCar",
Callback = function(new_accel_val)
    local Vehicle = get_vehicle()

    if not Vehicle then return show_notification("Failure:", "Please spawn a vehicle!", "Warning") end

    for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
        if v.owner.Value == getgenv().LocalPlayer then
            v:SetAttribute("acc_0_60", new_accel_val)
        end
    end
end,})

getgenv().SpeedModifier = Tab4:CreateSlider({
Name = "Vehicle Speed",
Range = {5, 500},
Increment = 5,
Suffix = "",
CurrentValue = 80,
Flag = "EditSpeedOnVehicle",
Callback = function(new_speed_val)
    local Vehicle = get_vehicle()

    if not Vehicle then return show_notification("Failure:", "Please spawn a vehicle!", "Warning") end

    for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
        if v.owner.Value == getgenv().LocalPlayer then
            v:SetAttribute("speed", new_speed_val)
            v:SetAttribute("max_speed", new_speed_val)
        end
    end
end,})

getgenv().AccelModifier = Tab4:CreateSlider({
Name = "Acceleration Modifier",
Range = {5, 250},
Increment = 5,
Suffix = "",
CurrentValue = 75,
Flag = "EditMaxAccelOnVehicle",
Callback = function(new_max_accel_val)
    local Vehicle = get_vehicle()

    if not Vehicle then return show_notification("Failure:", "Please spawn a vehicle!", "Warning") end

    for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
        if v.owner.Value == getgenv().LocalPlayer then
            v:SetAttribute("max_accel", new_max_accel_val)
        end
    end
end,})

-- Don't worry I'm working on it.
--[[getgenv().AutomaticallyPost_Story = Tab5:CreateInput({
Name = "Automatically Post Snap (FE)",
PlaceholderText = "User,Text to post",
RemoveTextAfterFocusLost = true,
Callback = function(input)
    if not firesignal then 
        return show_notification("[Error]:", "Your exploit does not support 'firesignal'", "Warning") 
    end

    local is_holding_phone = Phone.holding.get()
    local Holding_WaitTime = 2
    local Was_Holding = false
    local NonHolding_WaitTime = 0.5

    if is_holding_phone or is_holding_phone == true then
        Phone.holding.set(false)
        Was_Holding = true
    else
        Was_Holding = false
    end
    if Was_Holding == true then
        wait(Holding_WaitTime)
    else
        wait(NonHolding_WaitTime)
    end
    local split = string.split(input, ",")
    local targetName = split[1] and split[1]:gsub("^%s*(.-)%s*$", "%1")
    local text_to_post_snap = split[2] and split[2]:gsub("^%s*(.-)%s*$", "%1")

    if not targetName or targetName == "" or not text_to_post_snap or text_to_post_snap == "" then
        return show_notification("[Error]:", "Please enter both a user and text, separated by a comma.", "Warning")
    end

    local PlrTo_SendTo = findplr(targetName)
    if not PlrTo_SendTo then 
        return show_notification("[Error]:", "Target does not exist or was not found.", "Warning") 
    end

    wait(0.2)
    Phone.holding.set(true)
    wait(0.5)
    Phone.apps.LifeSnap.open()
    wait(0.3)
    local PlayerGui = getgenv().PlayerGui
    local Phone_Gui = PlayerGui:FindFirstChild("Phone")
    if not Phone_Gui then return show_notification("[Error]:", "Phone GUI not found.", "Warning") end
    local LifeSnap = Phone_Gui:FindFirstChild("LifeSnap")
    local MasterFrame = LifeSnap:FindFirstChild("MasterFrame")
    local Holder = MasterFrame:FindFirstChild("Holder")
    local Snapblox = Holder:FindFirstChild("Snapblox")
    local SnapbloxScreenSlider = Snapblox:FindFirstChild("SnapbloxScreenSlider")
    local Snapblox_Snaps = SnapbloxScreenSlider:FindFirstChild("SnapbloxSnaps")
    local SnapbloxSnaps_Frame = Snapblox_Snaps:FindFirstChild("Frame")
    local Snapblox_CameraChange = SnapbloxSnaps_Frame:FindFirstChild("SnapbloxChangeToCameraButton")
    local Snapblox_Contacts = SnapbloxScreenSlider:FindFirstChild("SnapbloxContacts")
    local SendToConfirmation_Frame = Snapblox_Contacts:FindFirstChild("SendToConfirmation")
    local SnapConfirm_SendButton = SendToConfirmation_Frame:FindFirstChild("SnapConfirmSendButton")
    local Scrolling_FrameContacts = Snapblox_Contacts:FindFirstChild("ScrollingFrame")
    local Snapblox_RecentsSend = Scrolling_FrameContacts:FindFirstChild("SnapbloxRecentsSend")
    local Snap_BloxRecents_Send_Holder = Snapblox_RecentsSend:FindFirstChild("SnapbloxRecentsSendHolder")
    local SnapbloxCameraHolder = SnapbloxScreenSlider:FindFirstChild("SnapbloxCameraHolder")
    local SnapbloxSendButtons = SnapbloxCameraHolder:FindFirstChild("SnapbloxSendButtons")
    local PictureSettings = SnapbloxCameraHolder:FindFirstChild("PictureSettings")
    local TimeSelectorFrame = PictureSettings:FindFirstChild("TimeSelectorFrame")
    local TimeSelector = SnapbloxCameraHolder:FindFirstChild("TimeSelector")
    local InfSnap_Time = TimeSelector:FindFirstChild("SnapbloxTimeButtons")["10"]
    local Snap_Time = TimeSelectorFrame:FindFirstChild("TimeSelectorButton")
    local Edit_Text = PictureSettings:FindFirstChild("EditSnapbloxText"):FindFirstChild("EditSnapbloxTextButton")
    local Text_Holder_Button = SnapbloxCameraHolder:FindFirstChild("SnapbloxTextHolder"):FindFirstChild("SnapbloxTextBox")
    local Take_Pic = SnapbloxCameraHolder:FindFirstChild("TakeSnapButton")
    local Send_To_Button = SnapbloxSendButtons:FindFirstChild("SnapbloxSendButton")
    local App_BackButton = Holder:FindFirstChild("AppBackButton")
    local App_HomeButton = Holder:FindFirstChild("AppHomeButton")

    local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

    local function get_sendToTarget(user)
        for _, v in ipairs(Snap_BloxRecents_Send_Holder:GetChildren()) do
            if v:IsA("TextButton") and v.Name == "Contact" and v:FindFirstChild("TextLabel") then
                if string.lower(v.TextLabel.Text) == string.lower(user.Name) then
                    return v
                end
            end
        end
        return nil
    end
    wait(0.1)
    local function click(button)
        for _, signal in ipairs(Signals) do
            if button and button[signal] then
                firesignal(button[signal])
            end
        end
    end
    wait()
    click(Take_Pic)
    wait(0.2)
    click(Edit_Text)
    wait(0.2)
    Text_Holder_Button.Text = text_to_post_snap
    wait(0.3)
    click(Snap_Time)
    wait(0.3)
    click(InfSnap_Time)
    wait(0.5)
    click(Send_To_Button)
    wait(0.5)
    local User_TextButton = get_sendToTarget(PlrTo_SendTo)
    if not User_TextButton then
        return show_notification("[Error]:", "Couldn't find the target user in Snap contacts.", "Warning")
    end
    click(User_TextButton)
    wait(0.5)
    click(SnapConfirm_SendButton)
    wait(0.1)
    show_notification("Success", "Snap sent successfully to "..PlrTo_SendTo.Name, "Success")
    wait(1)
    click(Snapblox_CameraChange)
    wait(1)
    Phone.holding.set(false)
end,})--]]

local CurrentlyCalling_ObjValue = getgenv().LocalPlayer:FindFirstChild("InCallWith", true) or getgenv().LocalPlayer:WaitForChild("InCallWith", 3)
task.wait(0.3)
getgenv().SpamCall_PlayerFE = Tab5:CreateInput({
Name = "Spam Call Player (FE)",
PlaceholderText = "Player Here",
RemoveTextAfterFocusLost = true,
Callback = function(spam_callin_plr)
    local Calling_Target = findplr(spam_callin_plr)
    if not Calling_Target then return show_notification("Error:", "Player does not exist!", "Warning") end
    wait(0.1)

    if Calling_Target then
        getgenv().notify("Heads Up:", "This works even when the player blocks you!", 5)
    end
    wait()
    if CurrentlyCalling_ObjValue.Value then
        for _, v in ipairs(getgenv().Players:GetPlayers()) do
            if v ~= getgenv().LocalPlayer then -- If you think about it, it's necessary lmao.
                getgenv().Send("end_call", v)
            end
        end
    end
    wait()
    getgenv().spam_calling_the_player = true
    while getgenv().spam_calling_the_player == true do
    wait()
        getgenv().Send("request_call", Calling_Target)
        wait()
        getgenv().Send("end_call", Calling_Target)
    end
end,})

getgenv().StopSpamCallinPlr = Tab5:CreateButton({
Name = "Stop Spam Calling Player",
Callback = function()
    getgenv().spam_calling_the_player = false
    repeat wait() until not getgenv().spam_calling_the_player or getgenv().spam_calling_the_player == false
    if getgenv().spam_calling_the_player == false then
        for _, v in ipairs(getgenv().Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                getgenv().Send("end_call", v)
            end
        end
    else
        getgenv().notify("Waiting:", "Loop is not disabled yet, waiting...", 5)
        repeat task.wait() until not getgenv().spam_calling_the_player or getgenv().spam_calling_the_player == false
        if getgenv().spam_calling_the_player == false then
            for _, v in ipairs(getgenv().Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    getgenv().Send("end_call", v)
                end
            end
        end
    end
end,})

getgenv().DeclineAll_CallsFE = Tab5:CreateToggle({
Name = "Block/Decline All Calls (FE)",
CurrentValue = false,
Flag = "BlockAnyIncomingCalls",
Callback = function(block_any_new_calls)
    if block_any_new_calls then
        getgenv().decline_all_calls_fe = true
        while getgenv().decline_all_calls_fe == true do
        task.wait(0)
            for _, v in ipairs(getgenv().Players:GetPlayers()) do
                if v ~= getgenv().LocalPlayer then
                    getgenv().Send("end_call", v)
                    task.wait()
                end
            end
            task.wait(.2)
            for _, v in ipairs(getgenv().Players:GetPlayers()) do
                if v ~= getgenv().LocalPlayer then
                    getgenv().Send("end_call", v)
                    task.wait()
                end
            end
        end
    else
        getgenv().decline_all_calls_fe = false
    end
end,})

getgenv().TurnAngleModifier = Tab4:CreateSlider({
Name = "Turn Angle Modifier",
Range = {10, 200},
Increment = 5,
Suffix = "",
CurrentValue = 30,
Flag = "EditTurnAngleOnVehicle",
Callback = function(new_turn_angle_val)
    local Vehicle = get_vehicle()
    if not Vehicle then return show_notification("Failure:", "Please spawn a vehicle!", "Warning") end

    for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
        if v.owner.Value == getgenv().LocalPlayer then
            v:SetAttribute("turn_angle", new_turn_angle_val)
        end
    end
end,})
wait(0.1)
local Old_Skintone = getgenv().Character:FindFirstChild("Body Colors").TorsoColor3
wait(0.3)
getgenv().RainbowSkin_FEScript = Tab2:CreateToggle({
Name = "Rainbow Skin (FE)",
CurrentValue = false,
Flag = "RainbowSkinScript_FE",
Callback = function(rgb_skintone)
    if rgb_skintone then
        getgenv().RainbowSkin_FE = true
        while getgenv().RainbowSkin_FE == true do
        task.wait(0)
            send_remote("skin_tone", Color3.fromRGB(0, 0, 0))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(217, 101, 30))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(93, 171, 195))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(49, 34, 21))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(8, 62, 11))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(30, 146, 19))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(97, 97, 97))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(206, 158, 196))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(14, 25, 43))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(63, 17, 126))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(0, 0, 175))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(183, 25, 25))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(213, 208, 29))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(175, 146, 50))
            task.wait(.1)
            send_remote("skin_tone", Color3.fromRGB(202, 28, 120))
        end
    else
        getgenv().RainbowSkin_FE = false
        wait(0.3)
        getgenv().notify("Heads Up:", "Waiting until loop is fully disabled and resetting skintone...", 5)
        repeat task.wait() until not getgenv().RainbowSkin_FE or getgenv().RainbowSkin_FE == false
        wait(3)
        if getgenv().RainbowSkin_FE == false then
            getgenv().notify("Hang On:", "Loop is disabled resetting skintone...", 5)
            wait()
            getgenv().Send("skin_tone", Old_Skintone)
            wait(0.2)
            getgenv().Send("skin_tone", Old_Skintone)
            wait(0.2)
            getgenv().Send("skin_tone", Old_Skintone)
        else
            notify("Waiting:", "Waiting for the Rainbow Skin loop to shutdown...", 5)
            repeat task.wait() until not getgenv().RainbowSkin_FE or getgenv().RainbowSkin_FE == false
            wait(5)
            getgenv().notify("Hang On:", "Loop shutdown, resetting skintone to normal...", 5)
            wait()
            getgenv().Send("skin_tone", Old_Skintone)
            wait(0.2)
            getgenv().Send("skin_tone", Old_Skintone)
            wait(0.2)
            getgenv().Send("skin_tone", Old_Skintone)
            wait(0.5)
            getgenv().notify("Success:", "Skintone should be normal now!", 5)
        end
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
wait(0.2)
function Notify(message, duration)
    local function safe_wrapper(S)
        if cloneref then
            return cloneref(game:GetService(S))
        else
            return game:GetService(S)
        end
    end

    local Players = safe_wrapper("Players")
    local TweenService = safe_wrapper("TweenService")
    local CoreGui = get_hidden_gui and get_hidden_gui() or gethui and gethui() or safe_wrapper("CoreGui")

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
    Frame.Size = UDim2.new(0, 400, 0, 60)
    Frame.Position = UDim2.new(0, 20, 0, 100)
    Frame.Parent = NotificationGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame

    local Icon = Instance.new("ImageLabel")
    Icon.Name = "ErrorIcon"
    Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0, 10, 0.5, -20)
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Image = "rbxasset://textures/ui/Emotes/ErrorIcon.png"
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Name = "ErrorText"
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 60, 0, 0)
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json")
    Label.Text = message
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 20
    Label.TextWrapped = true
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
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
    getgenv().ConstantUpdate_Checker_Live = true
    while getgenv().ConstantUpdate_Checker_Live do
        task.wait(1)

        local success, latestVersionInfo = pcall(function()
            local versionJson = game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Script_Versions_JSON?cachebust=" .. tick())
            return HttpService:JSONDecode(versionJson)
        end)

        if success and latestVersionInfo then
            if Script_Version ~= latestVersionInfo.LifeTogether_Admin_Version then
                getgenv().ConstantUpdate_Checker_Live = false
                Notify("JUST UPDATED: Rejoin and re-execute the Loadstring to update!", 20)
                break
            end
        end
    end
end)
