-- [[ This file is quite huge, so if you get a PARSER LOCAL LIMIT, don't be so surprised. ]] --
getgenv().Game = cloneref and cloneref(game) or game
wait()
if not getgenv().Game:IsLoaded() then
   getgenv().Game.Loaded:Wait()
end
local NotifyLib = loadstring(getgenv().Game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId
local set_fps = setfpscap or setfps
getgenv().SetFPSCap = set_fps

function notify(notif_type, msg, duration)
   NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration))
end
wait(0.1)
getgenv().notify = notify

if setfpscap or setfps then
   set_fps(250)
end
wait()
if getgenv().PlaceID ~= 13967668166 then
   return NotifyLib:External_Notification("Error", "This is not Life Together RP! You cannot run this here!", 6)
end
wait()
local Raw_Version = "V4.9.0"
local Script_Creator = "computerbinaries"
local Announcement_Message = "Improved checking for 'antioutfitstealer' + fixed the hashtag loop issue, and added aliases for 'rgbphone'."
local displayTimeMax = 20
task.wait(0.1)
getgenv().Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub = getgenv().Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub or false
local Script_Version = tostring(Raw_Version).."-LifeAdmin"
getgenv().Script_Version_GlobalGenv = Script_Version
getgenv().Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")

local function Service_Wrap(service)
   if cloneref then
      return cloneref(game:GetService(service))
   else
      return game:GetService(service)
   end
end
wait(0.1)
getgenv().Service_Wrap = Service_Wrap

if not getgenv().performance_stats then
   getgenv().notify("Info", "Loading Performance Statistics GUI...", 5)
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/OrionLibraryReWrittenCelery/refs/heads/main/grab_file_performance"))()
   wait(3)
   if getgenv().performance_stats then
      getgenv().notify("Success", "Loaded Performance Statistics GUI.", 5)
   else
      getgenv().notify("Warning", "Not sure if we we're able to load Performance Statistics GUI or not.", 8)
   end
end

wait()
if getgenv().LifeTogether_RP_ScriptHub_Loaded then
   return NotifyLib:External_Notification("Warning", "You already have Life Together RP (Script Hub) loaded, you cannot load both the Admin and Script Hub due to unexpected issues.", 9)
end

if getgenv().LifeTogetherRP_Admin and getgenv().Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub == false then
   getgenv().LifeTogetherRP_Admin = false
   return getgenv().notify("Error", "Life Together RP Admin appears to not have loaded correctly, try re-running the script and trying again.", 6)
elseif getgenv().LifeTogetherRP_Admin and getgenv().Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub then
   return getgenv().notify("Warning", "Life Together RP Admin is already running!", 5)
end
wait(0.3)
getgenv().LifeTogetherRP_Admin = true
getgenv().TextChatService = Service_Wrap("TextChatService")
getgenv().Players = Service_Wrap("Players")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer or getgenv().Game.Players.LocalPlayer or game.Players.LocalPlayer
getgenv().StarterGui = Service_Wrap("StarterGui") or cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui") or getgenv().Game:GetService("StarterGui")

getgenv().ChatMessageHooks = getgenv().ChatMessageHooks or {}
wait(0.1) -- always load properly.
if not getgenv().ChatMessageConnection then
   getgenv().ChatMessageConnection = getgenv().TextChatService.MessageReceived:Connect(function(msg)
      if not msg.TextSource then return end
      local sender = getgenv().Players:GetPlayerByUserId(msg.TextSource.UserId)
      if not (sender and msg.Text) then return end

      for _, fn in ipairs(getgenv().ChatMessageHooks) do
         local ok, err = pcall(fn, sender, msg)
         if not ok then
            getgenv().notify("Error", "[TextChatService_Message_Conn_Error]: "..tostring(err), 11)
         end
      end
   end)
end

local function make_input_normal(str)
   if type(str) ~= "string" then
      str = tostring(str or "")
   end

   local okLower, lowered = pcall(string.lower, str)
   if not okLower then
      lowered = tostring(str)
   end

   local cleaned = {}
   for i = 1, #lowered do
      local c = lowered:sub(i, i)
      if c:match("[%w]") then
         table.insert(cleaned, c)
      end
   end

   return table.concat(cleaned)
end

task.defer(function()
   local ok, name = pcall(function()
      return identifyexecutor and identifyexecutor() or "Unknown Executor"
   end)
   executor_Name = ok and tostring(name) or "Unknown Executor"

   task.wait(0.1)

   executor_Name = make_input_normal(executor_Name)
end)

local Allowed_Executors = {
   ["Volcano"] = true,
   ["Wave"] = false,
   ["Zenith"] = true,
   ["Delta"] = false,
   ["CodeX"] = false,
   ["Velocity"] = false,
   ["Bunni"] = true,
   ["Swift"] = true,
   ["Sirhurt"] = true,
   ["KRNL"] = false,
   ["Potassium"] = true,
   ["Macsploit"] = false,
   ["Seliware"] = true,
   ["Hydrogen"] = false,
   ["Lx63"] = false,
   ["Cryptic"] = false,
   ["Arceus"] = false,
   ["Vega"] = false,
   ["Synapse"] = false,
   ["Valex"] = false,
   ["Nucleus"] = false,
   ["Opiumware"] = false,
}

local function allowed_executor()
   local normalizedExec = make_input_normal(executor_Name or "")
   for allowedName, isAllowed in pairs(Allowed_Executors) do
      if isAllowed and normalizedExec:find(make_input_normal(allowedName), 1, true) then
         return true
      end
   end
   return false
end

function startCooldownSystem()
   if getgenv().TextChatAntiBanApplied then
      local CooldownTime = 10
      local Chat = Enum.CoreGuiType.Chat
      getgenv().CooldownActive = getgenv().CooldownActive or false
      getgenv().HashtagCount = getgenv().HashtagCount or 0

      local function startCooldown(duration)
         if getgenv().CooldownActive then
            return getgenv().notify("Warning", "Your TextChat cooldown is still currently active.", 6)
         end
         getgenv().CooldownActive = true
         getgenv().notify("Info", "Cooldown has now started for: " .. duration .. " seconds.", 8)

         task.delay(duration, function()
            getgenv().CooldownActive = false
            getgenv().HashtagCount = 0
            if not replicatesignal then
               getgenv().notify("Error", "Your executor does not (unfortunately) support 'replicatesignal', cannot unsuspend Chat.", 10)
            else
               replicatesignal(getgenv().TextChatService.UpdateChatTimeout, getgenv().LocalPlayer.UserId, 0, 10)
            end
            getgenv().StarterGui:SetCoreGuiEnabled(Chat, true)
            getgenv().notify("Success", "Chat is now re-enabled, cooldown has stopped.", 7)
         end)
      end

      getgenv().TextChatService.MessageReceived:Connect(function(msg)
         local source = msg.TextSource
         if not source then return end
         local player = getgenv().Players:GetPlayerByUserId(source.UserId)
         if player ~= getgenv().LocalPlayer then return end

         local text = msg.Text
         if text and text:match("^#+$") then
            getgenv().HashtagCount += 1
            if getgenv().HashtagCount >= 4 then
               getgenv().StarterGui:SetCoreGuiEnabled(Chat, false)
               startCooldown(CooldownTime)
               getgenv().notify("Warning", "Chat disabled temporarily, too many filtered messages have been sent (possible risk of ban).", 10)
            end
         end
      end)
   else
      getgenv().notify("Info", "Skipping this part, hook not applied.", 3)
   end
end

local function safe_chat_hookin()
	if not hookmetamethod or not getnamecallmethod then
		return getgenv().notify("Warning", "Your executor does not support hookmetamethod or getnamecallmethod.", 5)
	end
	if not allowed_executor() then
		return getgenv().notify("Warning", "Executor not allowed for chat protection hook.", 5)
	end
	if getgenv().TextChatAntiBanApplied then
		return getgenv().notify("Info", "TextChatAntiBan hook already applied.", 5)
	end

	local okService, TextChatService = pcall(function()
		return cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")
	end)
	if not okService or not TextChatService then
		return getgenv().notify("Warning", "TextChatService not found; cannot apply hook.", 5)
	end

	local oldNamecall, oldIndex

	local function hookMetatable()
		local ok, err = pcall(function()
			oldNamecall = hookmetamethod(TextChatService, "__namecall", newcclosure(function(self, ...)
				local method = getnamecallmethod()
				if method == "SendAsync" and getgenv().CooldownActive then
					getgenv().notify("Warning", "You cannot send messages during cooldown.", 6)
					return nil
				end
				return oldNamecall(self, ...)
			end))

			oldIndex = hookmetamethod(TextChatService, "__index", newcclosure(function(self, key)
				if key == "SendAsync" and getgenv().CooldownActive then
					return function()
						getgenv().notify("Warning", "Chat disabled during cooldown.", 6)
						return nil
					end
				end
				return oldIndex(self, key)
			end))
		end)

		if not ok then
			getgenv().notify("Error", "Failed to hook metatable safely: " .. tostring(err), 8)
			return false
		end
		return true
	end

   local hookApplied = hookMetatable()
   if hookApplied then
      getgenv().TextChatAntiBanApplied = true
      getgenv().notify("Success", "TextChatService hook successfully applied.", 6)
      startCooldownSystem()
   else
      getgenv().notify("Warning", "Hook attempt failed or blocked by executor sandbox.", 6)
   end
end

task.defer(function()
	if allowed_executor() then
		safe_chat_hookin()
	else
		getgenv().notify("Warning", "Executor not allowed to apply SendAsync hook.", 6)
	end
end)

local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local API_URL = "https://flameshub-worker.flameshub.workers.dev/api/flameshub"
local httprequest = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local watchedUserIds = {
   [7712000520] = true,
   [7740121604] = true,
}

local function httpRequestSafe(opts)
   if not httprequest then return end
   local ok, res = pcall(function()
      return httprequest({
         Url = opts.url,
         Method = opts.method or "GET",
         Headers = opts.headers,
         Body = opts.body,
      })
   end)
   if not ok or not res then return nil end
   res.Body = res.Body or res.body
   res.StatusCode = res.StatusCode or res.status_code

   return res
end

local function safeJsonDecode(body)
   if not body or type(body) ~= "string" then return {} end
   local ok, decoded = pcall(HttpService.JSONDecode, HttpService, body)
   return ok and decoded or {}
end

local function apiList()
   local res = httpRequestSafe({ url = API_URL .. "/list" })
   return res and safeJsonDecode(res.Body) or {}
end

local function apiSet(payload)
   return httpRequestSafe({
      url = API_URL .. "/set",
      method = "POST",
      headers = { ["Content-Type"] = "application/json" },
      body = HttpService:JSONEncode(payload),
   })
end

local function apiDelete(userId)
   return httpRequestSafe({
      url = API_URL .. "/delete",
      method = "POST",
      headers = { ["Content-Type"] = "application/json" },
      body = HttpService:JSONEncode({ userId = userId }),
   })
end

local function createBillboard(player)
   if not player or not player.Character then return end
   local head = player.Character:FindFirstChild("Head") or player.Character:WaitForChild("Head", 5)
   if not head then return end

   local existing = head:FindFirstChild("FlamesHubBillboard")
   if existing then existing:Destroy() end

   local billboard = Instance.new("BillboardGui")
   billboard.Name = "FlamesHubBillboard"
   billboard.Adornee = head
   billboard.Size = UDim2.new(0, 200, 0, 50)
   billboard.StudsOffset = Vector3.new(0, 2.5, 0)
   billboard.AlwaysOnTop = true
   billboard.Parent = head

   local label = Instance.new("TextLabel")
   label.Size = UDim2.new(1, 0, 1, 0)
   label.BackgroundTransparency = 0.2
   label.TextScaled = true
   label.Font = Enum.Font.GothamBold
   label.TextStrokeTransparency = 0
   label.Parent = billboard

   local corner = Instance.new("UICorner")
   corner.CornerRadius = UDim.new(0, 8)
   corner.Parent = label

   if watchedUserIds[player.UserId] then
      label.Text = "🔥 FLAMES HUB | OWNER 🔥"
      label.TextColor3 = Color3.fromRGB(255, 255, 255)
      label.BackgroundColor3 = Color3.fromRGB(0, 16, 176)
   else
      label.Text = "🔥 FLAMES HUB | CLIENT 🔥"
      label.TextColor3 = Color3.fromRGB(0, 0, 0)
      label.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
      if label and label.Visible then
         label.Visible = false
      end
   end
end

task.spawn(function()
   apiSet({ userId = LocalPlayer.UserId, state = "enable" })
   while task.wait(10) do
      apiSet({ userId = LocalPlayer.UserId, state = "enable" })
   end
end)

Players.PlayerRemoving:Connect(function(plr)
   if plr == LocalPlayer then
      apiDelete(LocalPlayer.UserId)
   end
end)

task.spawn(function()
   while task.wait(5) do
      local list = apiList()
      for uid, payload in pairs(list) do
         local userId = tonumber(uid)
         if userId then
            local player = getgenv().Players:GetPlayerByUserId(userId)
            if player then
               task.spawn(createBillboard, player)
            end
         end
      end
   end
end)

Players.PlayerAdded:Connect(function(plr)
   plr.CharacterAdded:Connect(function()
      task.wait(1)
      createBillboard(plr)
   end)
end)

LocalPlayer.CharacterAdded:Connect(function(char)
   task.wait(1)
   createBillboard(LocalPlayer)
end)

task.spawn(function()
   while task.wait(3) do
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
         local head = LocalPlayer.Character:WaitForChild("Head", 3)

         if not head:FindFirstChild("FlamesHubBillboard") then
            createBillboard(LocalPlayer)
         end
      end
   end
end)
task.wait(0.2)
local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
task.wait(0.2)
getgenv().StarterGui = StarterGui

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
task.wait(0.2)
function owner_joined(Name)
   getgenv().notify("Info", "The owner of the Life Together Admin Commands and Script Hub scripts has joined the server! Username: "..tostring(Name), 8)
end

getgenv().randomString = function()
   local length = math.random(10,20)
   local array = {}
   for i = 1, length do
      array[i] = string.char(math.random(32, 126))
   end
   return table.concat(array)
end

local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local GroupId = getgenv().Game.CreatorId
local staffRoles = {
   "Admin", "Technical Assistance", "Developer A", "Technical Lead", "Finance", "Owner", "QA Lead", "Creator"
}

local function isStaffRole(role)
	for _, staff in ipairs(staffRoles) do
		if role:lower():find(staff) then
			return true
		end
	end
	return false
end

if GroupId and GroupId > 0 and LocalPlayer:IsInGroup(GroupId) then
	local role = LocalPlayer:GetRoleInGroup(GroupId)
	if isStaffRole(role) then
		LocalPlayer:Kick("\n\nRolewatch\nYou are in the group with a staff role: \"" .. role .. "\"")
      wait(0.2)
      while true do end
	end
end
wait(0.2)
local cmdp = cloneref and cloneref(getgenv().Game:GetService("Players")) or getgenv().Game:GetService("Players")
local cmdlp = cmdp.LocalPlayer

function getHum(char)
   if not char then return nil end

   local hum = char:FindFirstChildWhichIsA("Humanoid")

   if not hum then
      hum = char:WaitForChild("Humanoid", 5)
   end

   if hum and hum:IsDescendantOf(workspace) then
      return hum
   end

   return nil
end
wait(0.1)
getgenv().getHuman = getHum

function getRoot(char)
   rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
   return rootPart
end
wait(0.1)
getgenv().getRoot = getRoot
wait()
function findplr(args)
   local tbl = cmdp:GetPlayers()

   if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName or args == cmdlp then
      return 
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
         if v ~= cmdlp and v.Character and (v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair")) then
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
            local vRootPart = getgenv().getRoot(v.Character)
            local cmdlpRootPart = getgenv().getRoot(cmdlp.Character)
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
            local vRootPart = getgenv().getRoot(v.Character)
            local cmdlpRootPart = getgenv().getRoot(cmdlp.Character)
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

   if typeof(args) ~= "string" or args == "" then
      return nil
   end

   for _, v in pairs(tbl) do
      if v ~= cmdlp then
         local name, display = v.Name:lower(), v.DisplayName:lower()
         if name:find(args:lower()) or display:find(args:lower()) then
            return v
         end
      end
   end
end
wait(0.1)
getgenv().findplr = findplr

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
      "PhysicsService",
      "ScriptContext"
   }

   for _, serviceName in pairs(services) do
      getgenv()[serviceName] = cloneref and cloneref(getgenv().Game:GetService(serviceName)) or getgenv().Game:GetService(serviceName)
   end
   wait(0.1)
   if getgenv().StarterPlayer:FindFirstChildOfClass("StarterPlayerScripts") then
      getgenv().StarterPlayerScripts = getgenv().StarterPlayer:FindFirstChildOfClass("StarterPlayerScripts") or getgenv().StarterPlayer:FindFirstChildWhichIsA("StarterPlayerScripts")
   end
   if getgenv().StarterPlayer:FindFirstChildOfClass("StarterCharacterScripts") then
      getgenv().StarterCharacterScripts = getgenv().StarterPlayer:FindFirstChildOfClass("StarterCharacterScripts") or getgenv().StarterPlayer:FindFirstChildWhichIsA("StarterCharacterScripts")
   end
end
wait()
init_services()
task.wait()
local HttpService = cloneref and cloneref(getgenv().Game:GetService("HttpService")) or getgenv().Game:GetService("HttpService")
local Players = cloneref and cloneref(getgenv().Game:GetService("Players")) or getgenv().Game:GetService("Players")
local RunService = cloneref and cloneref(getgenv().Game:GetService("RunService")) or getgenv().Game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = cloneref and cloneref(getgenv().Game:GetService("ReplicatedStorage")) or getgenv().Game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(getgenv().Game:GetService("Workspace")) or getgenv().Game:GetService("Workspace")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Core = Modules:WaitForChild("Core")
local Game = Modules:WaitForChild("Game")
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
local CCTV = require(Game:FindFirstChild("CCTV"))
local Tween = require(Core:FindFirstChild("Tween"))
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local CCTV = require(Game:FindFirstChild("CCTV"))
wait(0.1)
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
wait()
local FireReparented_Folder
task.wait(0.3)
function create_script_fire_folder()
   if not getgenv().StarterGui:FindFirstChild("FireTemporaryReparentFolder") then
      FireReparented_Folder = Instance.new("Folder")
      FireReparented_Folder.Name = "FireTemporaryReparentFolder"
      FireReparented_Folder.Parent = getgenv().StarterGui
   else
      FireReparented_Folder = getgenv().StarterGui:FindFirstChild("FireTemporaryReparentFolder")
   end
end
task.wait(0.2)
create_script_fire_folder()
wait()
function change_vehicle_color(Color, Vehicle)
   send_remote("vehicle_color", Color, Vehicle)
end

function sit_in_vehicle(Vehicle)
   if not Vehicle then return getgenv().notify("Error", "You do not have a Vehicle! spawn one.", 5) end

   getgenv().Get("sit", Vehicle)
   wait(0.1)
   if Vehicle:FindFirstChild("VehicleSeat") then
      Vehicle:FindFirstChild("VehicleSeat"):Sit(getgenv().Humanoid)
   else
      return getgenv().notify("Error", "Unable to sit in Vehicle, missing VehicleSeat!", 5)
   end
end

function spawn_any_vehicle(Vehicle)
   getgenv().Get("spawn_vehicle", Vehicle)
end

local function get_vehicle()
   for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
      if v.owner.Value == getgenv().LocalPlayer then
         return v
      end
   end

   return nil
end
wait(0.2)
getgenv().get_vehicle = get_vehicle

local function Get_Char(Player)
   if not Player or not Player.Character then
      local Char = nil
      local conn
      conn = Player.CharacterAdded:Connect(function(c)
         Char = c
      end)

      repeat task.wait() until Char or not Player.Parent
      if conn then conn:Disconnect() end
      return Char
   end
   return Player.Character
end

wait(0.1)
getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
getgenv().Camera = getgenv().Workspace.CurrentCamera
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait() or Get_Char(getgenv().LocalPlayer)
wait(0.1)
for _, v in ipairs(getgenv().PlayerGui:GetDescendants()) do
   if v:IsA("Frame") and v.Name == "SidebarButtonHolder" and string.find(v.Parent.Name, "OpenPhone") then
      v.Position = UDim2.new(0.925, 0, 0.35, 0)
   end
end
wait()
for _, v in ipairs(getgenv().PlayerGui:GetDescendants()) do
   if v:IsA("Frame") and v.Name == "VehicleSpeedFrame" then
      if v:FindFirstChild("Slider"):FindFirstChild("Title") then
         local Title = v:FindFirstChild("Slider"):FindFirstChild("Title")

         Title.TextScaled = false
         Title.TextSize = 21
         Title.TextColor3 = Color3.fromRGB(0, 255, 0)
         Title.Text = "SPEED (Hello from: Flames Hub)!"
      end
   end
end
wait()
getgenv().notify("Success", "SPOOFING NOTIFICATION COUNTERS...", 5)

local gui = getgenv().PlayerGui
local TweenService = getgenv().TweenService
getgenv().RainbowTopBar = true
local PhoneClock = gui:FindFirstChild("PhoneClock", true)
local TopBar_Icons = PhoneClock and PhoneClock.Parent:FindFirstChildOfClass("Frame")
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

getgenv().notify("Success", "STARTING RGB HUE COLOR CYCLE ON PHONE...", 5)

local function cycle_color()
   local hue = 0
   while getgenv().RainbowTopBar do
      if not PhoneClock or not TopBar_Icons then break end

      if hue > 1 then hue = 0 end
      local color = Color3.fromHSV(hue, 1, 1)

      if PhoneClock:IsA("TextLabel") then
         TweenService:Create(PhoneClock, tweenInfo, {TextColor3 = color}):Play()
      end

      for _, obj in ipairs(TopBar_Icons:GetChildren()) do
         if obj:IsA("ImageLabel") then
            TweenService:Create(obj, tweenInfo, {ImageColor3 = color}):Play()
         end
      end

      hue = hue + 0.02
      task.wait(0.05)
   end
end

task.spawn(cycle_color)

function update_counter_notif_label(label, input_number)
   local Inputted_Number = tostring(input_number)
   label.Text = Inputted_Number

   if label.Parent and label.Parent:IsA("Frame") then
      if not label.Parent.Visible then
         label.Parent.Visible = true
      end
   end

   label.TextScaled = true

   if not label.Visible then
      label.Visible = true
   end
end

function toggle_flash_priv_server_time(toggle)
   if toggle == true then
      getgenv().Send("time_toggle", true)
      task.wait(0.2)
      getgenv().ChangingTime_Fast_FE = true
      while getgenv().ChangingTime_Fast_FE == true do
      task.wait(0)
         getgenv().Send("change_time", 4.5)
         task.wait(0)
         getgenv().Send("change_time", 5.5)
         task.wait(0)
         getgenv().Send("change_time", 12)
         task.wait(0)
         getgenv().Send("change_time", 18.5)
         task.wait(0)
         getgenv().Send("change_time", 23)
      end
   elseif toggle == false then
      getgenv().ChangingTime_Fast_FE = false
      repeat task.wait() until getgenv().ChangingTime_Fast_FE == false
      getgenv().Send("time_toggle", false)
   end
end

local function setup_label(label, targetText)
   label.Text = targetText

   if label.Parent and label.Parent:IsA("Frame") then
      label.Parent.Visible = true

      if label.Parent.Name == "SumNotificationCount" then
         label.Parent.Size = UDim2.new(0.4, 0, 0.4, 0)
      end
   end

   local connection = label:GetPropertyChangedSignal("Text"):Connect(function()
      if label.Text ~= targetText then
         update_counter_notif_label(label, targetText)
      end
   end)

   return connection
end

local function wait_for_single(name)
   local label
   repeat
      label = gui:FindFirstChild(name, true)
      task.wait()
   until label and label:IsA("TextLabel")
   return label
end

getgenv().notify("Success", "STARTED RGB HUE COLOR CYCLE.", 5)

local function wait_for_multiple(name)
   local results = {}
   repeat
      results = {}
      for _, v in ipairs(gui:GetDescendants()) do
         if v:IsA("TextLabel") and v.Name == name then
            table.insert(results, v)
         end
      end
      task.wait()
   until #results > 0
   return results
end

local counter_label = wait_for_single("SumNotificationCountLabel")
getgenv().ActivelyChanging_CounterLabel = setup_label(counter_label, "999+")

local notif_labels = wait_for_multiple("AppNotificationCountLabel")
getgenv().ActivelyChanging_NotifCountingLabel = {}
for _, label in ipairs(notif_labels) do
   table.insert(getgenv().ActivelyChanging_NotifCountingLabel, setup_label(label, "999+"))
end

gui.DescendantAdded:Connect(function(obj)
   if obj:IsA("TextLabel") then
      if obj.Name == "SumNotificationCountLabel" then
         if getgenv().ActivelyChanging_CounterLabel then
            getgenv().ActivelyChanging_CounterLabel:Disconnect()
         end
         getgenv().ActivelyChanging_CounterLabel = setup_label(obj, "999+")
      elseif obj.Name == "AppNotificationCountLabel" then
         table.insert(getgenv().ActivelyChanging_NotifCountingLabel, setup_label(obj, "999+"))
      end
   end
end)
wait(0.1)
getgenv().notify("Success", "Spoofed notification counter numbers.", 5)
wait(0.1)
getgenv().LocalPlayer.OnTeleport:Connect(function(State)
   if (not getgenv().TeleportCheck_Admin) and getgenv().queueteleport then
      getgenv().TeleportCheck_Admin = true
      queueteleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_RP_Admin.lua')))()")
   end
end)

wait(0.3)
if not getgenv().Players then
   warn("getgenv().Players was not detected, fixing...")
   getgenv().Players = Service_Wrap("Players")
end
if not getgenv().ReplicatedStorage then
   warn("getgenv().ReplicatedStorage was not detected, fixing...")
   getgenv().ReplicatedStorage = Service_Wrap("ReplicatedStorage")
end
if not getgenv().TextChatService then
   warn("getgenv().TextChatService was not detected, fixing...")
   getgenv().TextChatService = Service_Wrap("TextChatService")
end
if not getgenv().Workspace then
   warn("getgenv().Workspace was not detected, fixing...")
   getgenv().Workspace = Service_Wrap("Workspace")
end
if not getgenv().Lighting then
   warn("getgenv().Lighting was not detected, fixing...")
   getgenv().Lighting = Service_Wrap("Lighting")
end
if not getgenv().LocalPlayer then
   warn("getgenv().LocalPlayer was not detected, fixing...")
   task.wait()
   getgenv().LocalPlayer = getgenv().Players.LocalPlayer or Service_Wrap("Players").LocalPlayer
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

wait()
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
wait(0.1)
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

   local maxTries = 40
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
      if not get_vehicle() then return end

      spawn_any_vehicle(tostring(get_vehicle().Name))
   end
   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      if not get_vehicle() then return end

      spawn_any_vehicle(tostring(get_vehicle().Name))
   end
end

local Players = cloneref and cloneref(getgenv().Game:GetService("Players")) or getgenv().Game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Owners = {
   ["L0CKED_1N1"] = true,
   ["CHEATING_B0SS"] = true,
}
getgenv().ShowTitle = getgenv().ShowTitle or true
local TITLE_TEXT = "🔥 Flames Hub | Owner 🔥"
local TITLE_COLOR = Color3.fromRGB(196, 40, 28)
local NOTE_TEXT = "Talk to me if you ever need support with the script 👍."
local NOTE_COLOR = Color3.fromRGB(255, 255, 255)

local function createBillboard_Support(player)
   if player == LocalPlayer then return end
   if not Owners[player.Name] then return end

   local character = player.Character or player.CharacterAdded:Wait()
   local head = character:WaitForChild("Head", 1)
   if not head then return warn("Could not find Head for: " .. tostring(player.Name)) end

   if head:FindFirstChild("CustomTitle") then
      head.CustomTitle:Destroy()
   end

   local billboard = Instance.new("BillboardGui")
   billboard.Name = "CustomTitle"
   billboard.Adornee = head
   billboard.Size = UDim2.new(0, 300, 0, 110)
   billboard.StudsOffset = Vector3.new(0, 6, 0)
   billboard.AlwaysOnTop = true
   billboard.Parent = head

   local noteBox = Instance.new("Frame")
   noteBox.Size = UDim2.new(1, 0, 0.4, 0)
   noteBox.Position = UDim2.new(0, 0, 0, 0)
   noteBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
   noteBox.BackgroundTransparency = 0.3
   noteBox.Parent = billboard

   local noteCorner = Instance.new("UICorner")
   noteCorner.CornerRadius = UDim.new(0, 8)
   noteCorner.Parent = noteBox

   local note = Instance.new("TextLabel")
   note.Size = UDim2.new(1, -10, 1, -4)
   note.Position = UDim2.new(0, 5, 0, 2)
   note.BackgroundTransparency = 1
   note.Text = NOTE_TEXT
   note.TextColor3 = NOTE_COLOR
   note.Font = Enum.Font.GothamSemibold
   note.TextScaled = true
   note.TextWrapped = true
   note.Parent = noteBox

   local titleBox = Instance.new("Frame")
   titleBox.Size = UDim2.new(1, 0, 0.6, 0)
   titleBox.Position = UDim2.new(0, 0, 0.4, 0)
   titleBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
   titleBox.BackgroundTransparency = 0.2
   titleBox.Parent = billboard

   local titleCorner = Instance.new("UICorner")
   titleCorner.CornerRadius = UDim.new(0, 10)
   titleCorner.Parent = titleBox

   local title = Instance.new("TextLabel")
   title.Size = UDim2.new(1, -10, 1, -4)
   title.Position = UDim2.new(0, 5, 0, 2)
   title.BackgroundTransparency = 1
   title.Text = TITLE_TEXT
   title.TextColor3 = TITLE_COLOR
   title.Font = Enum.Font.GothamBold
   title.TextScaled = true
   title.TextWrapped = true
   title.Parent = titleBox
   title.Name = "ToggleTitle"

   billboard.Enabled = true
   title.Visible = getgenv().ShowTitle
end

local function refreshTitles()
   for _, player in ipairs(Players:GetPlayers()) do
      createBillboard_Support(player)
   end
end

refreshTitles()

Players.PlayerAdded:Connect(function(p)
   p.CharacterAdded:Connect(function()
      p.CharacterAdded:Wait()
      createBillboard_Support(p)
   end)
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TitleToggleUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = getgenv().Game.CoreGui end

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 140, 0, 40)
Button.Position = UDim2.new(1, -150, 1, -50)
Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 16
Button.TextScaled = true
Button.Text = "Hide Owner Title"
Button.Parent = ScreenGui
Button.AutoButtonColor = true
if Button.Visible then
   Button.Visible = false
end

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Button

Button.MouseButton1Click:Connect(function()
   getgenv().ShowTitle = not getgenv().ShowTitle
   Button.Text = getgenv().ShowTitle and "Hide Owner Title" or "Show Owner Title"

   for _, player in ipairs(Players:GetPlayers()) do
      local char = player.Character
      if char and char:FindFirstChild("Head") then
         local gui = char.Head:FindFirstChild("CustomTitle")
         if gui then
            local toggleTitle = gui:FindFirstChild("ToggleTitle")
            if toggleTitle then
               toggleTitle.Visible = getgenv().ShowTitle
            end
         end
      end
   end
end)

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

   local maxTries = 40
   for i = 1, maxTries do
      local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
      local isSitting = targetHumanoid and targetHumanoid.Sit
      if isSitting then break end

      MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.1, 0))
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
      if not get_vehicle() then return end

      spawn_any_vehicle(tostring(get_vehicle().Name))
   end
   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      if not get_vehicle() then return end

      spawn_any_vehicle(tostring(get_vehicle().Name))
   end
end

if not getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)") then
   create_kill_part()
end
if not getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)") then
   create_void_part()
end

if not getgenv().Anti_Idle_Controller_Loaded then
   if getconnections or get_signal_cons then
      getgenv().notify("Info", "Loading Anti-Idle controller...", 5)
      local GC = getconnections or get_signal_cons

      getgenv().Anti_Idle_Controller_Loaded = true
      getgenv().LocalPlayer.Idled:Connect(function()
         wait(2.5)
         for i,v in pairs(GC(getgenv().LocalPlayer.Idled)) do
            if v["Disable"] then
               v["Disable"](v)
            elseif v["Disconnect"] then
               v["Disconnect"](v)
            end
         end
         getgenv().Humanoid:ChangeState(3)
      end)
   end
else
   getgenv().notify("Warning", "You've already loaded our Anti-Idle controller!", 6)
end

local function decodeHTMLEntities(str)
    return str:gsub("&gt;", ">")
              :gsub("&lt;", "<")
              :gsub("&amp;", "&")
              :gsub("&quot;", '"')
              :gsub("&#39;", "'")
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

   local maxTries = 40
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
      if not get_vehicle() then return end

      spawn_any_vehicle(tostring(get_vehicle().Name))
   end

   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      if not get_vehicle() then return end
      
      spawn_any_vehicle(tostring(get_vehicle().Name))
   end
end

wait()
function vehicle_bring_player(TargetPlayer)
   if not TargetPlayer or not TargetPlayer.Character then return end
   local targetChar = TargetPlayer.Character
   local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
   if not targetHRP then return end
   wait(0.2)
   local Old_CF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

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

   local maxTries = 40
   for i = 1, maxTries do
      local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
      local isSitting = targetHumanoid and targetHumanoid.Sit
      if isSitting then break end

      MyBus:PivotTo(targetHRP.CFrame + Vector3.new(0, 0.3, 0))
      task.wait(0.4)
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
      if not get_vehicle() then return end

      spawn_any_vehicle(tostring(get_vehicle().Name))
   end
   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      if not get_vehicle() then return end

      spawn_any_vehicle(tostring(get_vehicle().Name))
   end
end

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

getgenv().walkflinging = getgenv().walkflinging or false
local Animate_Disabled = false
getgenv().HumanoidRootPart = SafeGetHRP(getgenv().Character)
getgenv().Humanoid = SafeGetHumanoid(getgenv().Character)
getgenv().Head = SafeGetHead(getgenv().Character)
wait(0.5)
local function Dynamic_Character_Updater(character)
	getgenv().Character = character
	wait(0.4)
   if getgenv().Character and getgenv().Character:FindFirstChild("Humanoid") then
      getgenv().HumanoidRootPart = SafeGetHRP(character)
      getgenv().Humanoid = SafeGetHumanoid(character)
      getgenv().Head = SafeGetHead(character)
   elseif not getgenv().Character then
      repeat task.wait() until character
      getgenv().Character = character
   end
   local Animate = character:WaitForChild("Animate", 3)
   if Animate_Disabled or Animate_Disabled == true then
      if Animate then
         Animate.Disabled = true
      end
   end
   if getgenv().Is_Currently_Emoting then
      getgenv().notify("Warning", "Emoting was enabled when respawning, we disabled it, don't worry.", 6)
      getgenv().Is_Currently_Emoting = false
      getgenv().Character:WaitForChild("Animate", 1).Disabled = false
   end
   task.wait(0.3)
   if getgenv().Humanoid then
      getgenv().Humanoid.JumpHeight = 7
      getgenv().Humanoid.JumpPower = 50
   else
      getgenv().notify("Error", "It seems we we're unable to update your Humanoid, please reset!", 8)
   end
end

Dynamic_Character_Updater(getgenv().Character)
task.wait(0.2)
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(0.2)
	Dynamic_Character_Updater(newCharacter)
	repeat wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
	wait(0.5)
   getgenv().Character = newCharacter
   if getgenv().walkflinging then
      getgenv().notify("Warning", "WalkFling enabled on death, disabling...", 5)
      getgenv().walkflinging = false
      if getgenv().WalkFlinging_Connection then
         getgenv().WalkFlinging_Connection:Disconnect()
         getgenv().WalkFlinging_Connection = nil
      end
      getgenv().notify("Success", "WalkFling has been disabled.", 5)
   end
   wait(0.2)
	getgenv().HumanoidRootPart = SafeGetHRP(newCharacter)
	getgenv().Humanoid = SafeGetHumanoid(newCharacter)
	getgenv().Head = SafeGetHead(newCharacter)
   wait(0.3)
   if getgenv().Humanoid then
      getgenv().Humanoid.JumpHeight = 7
      getgenv().Humanoid.JumpPower = 50
   elseif getgenv().Character then
      getgenv().Humanoid = SafeGetHumanoid(getgenv().Character)
      wait(0.3)
      getgenv().Humanoid.JumpHeight = 7
   else
      getgenv().notify("Error", "It seems we we're unable to update your Humanoid properly, please reset!", 8)
   end
   if getgenv().Not_Ever_Sitting then
      if getgenv().Humanoid then
         getgenv().Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
      end
      wait()
      getgenv().notify("Warning", "We disabled the sitting function again (anti-sit is enabled).", 5)
   end
   getgenv().Is_Currently_Emoting = false
	wait(0.2)
	Dynamic_Character_Updater(newCharacter)
end)

-- try and outsmart directory wide searching with effective-ness Life Together RP, you'll never patch this Logs disabler, you'd have to remove it other-wise.
-- there is quite literally no where else these dick-heads could put it to beat this system, they'd have to remove it entirely to "patch this".
-- and even if they did, it wouldn't touch my script at all, since I have 'if' checks everywhere, so, they are forced to do 1 thing and 1 thing only (delete it).
local Directories = {
   ["ReplicatedFirst"] = true,
   ["ReplicatedStorage"] = true,
   ["Workspace"] = true,
   ["TweenService"] = true,
   ["SoundService"] = true,
   ["Players"] = true,
   ["Lighting"] = true,
   ["MaterialService"] = true,
   ["Teams"] = true,
   ["StarterGui"] = true,
   ["StarterPack"] = true,
   ["Chat"] = true,
   ["TextChatService"] = true,
   ["StarterPlayer"] = true,
}

-- [[ If you use this code, it'll break the game. ]] --
--[[for serviceName in pairs(Directories) do
   local service = getgenv().Game:GetService(serviceName)
   if service then
      for _, descendant in ipairs(service:GetDescendants()) do
         if descendant:IsA("LocalScript") and descendant.Name:lower():find("logs") then
            descendant.Disabled = true
         end
      end
   end
end--]]

-- [[ Reduces the spammy and un-necessary logging in the game. ]] --
local playerScripts = getgenv().PlayerScripts
if playerScripts then
   local clientBase = playerScripts:FindFirstChild("ClientBase")
   if clientBase then
      local logsScript = clientBase:FindFirstChild("Logs")
      if logsScript and logsScript:IsA("LocalScript") then
         logsScript.Disabled = true
      end
   end
end

-- [[ Disables the StarterPlayerScripts logging LocalScript package. ]] --
local sps = getgenv().StarterPlayerScripts
if sps then
   local package = sps:FindFirstChild("StarterPlayerScripts_Package")
   if package then
      local clientBase = package:FindFirstChild("ClientBase")
      if clientBase then
         local logsScript = clientBase:FindFirstChild("Logs")
         if logsScript and logsScript:IsA("LocalScript") then
            logsScript.Disabled = true
         end
      end
   end
end
wait(0.5)
-- [[ Function to check if the script is supported and works on the current executor. ]] --
local success, response = pcall(function()
   local Net = require(getgenv().Core:FindFirstChild("Net"))

   Net.get("spawn_vehicle", "SVJ")
   wait(3)

   return get_vehicle()
end)

if success and response then
   task.wait(0.5)
   if get_vehicle() and getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
      getgenv().Humanoid:ChangeState(3)
      wait(0.2)
      require(getgenv().Core:FindFirstChild("Net")).get("spawn_vehicle", get_vehicle().Name or "SVJ")
   elseif get_vehicle() and getgenv().Humanoid.Sit == false then
      require(getgenv().Core:FindFirstChild("Net")).get("spawn_vehicle", get_vehicle().Name or "SVJ")
   elseif not get_vehicle() then
      getgenv().notify("Warning", "We did spawn the Vehicle it seems, but it seems like you despawned the Vehicle.", 10)
   elseif not get_vehicle() and getgenv().Humanoid.Sit == true then
      getgenv().Humanoid:ChangeState(3)
      wait(0.2)
      getgenv().notify("Warning", "We did not find your Vehicle, but it seems like it worked.", 5)
   end
else
   if not success then
      getgenv().LifeTogetherRP_Admin = false
      --getgenv().notify("Error", "This script does not work on this executor!", 8)
      return getgenv().notify("Error", "You cannot run this script on this executor, we're sorry! (if you believe this was in error, re-run the script).", 12)
   end
end
wait()
-- [[ Coming Soon ]] --
--[[local Defaults = {
   ["Vehicle"] = "None", -- Or the vehicle name, example: "SVJ".
   ["AntiSit"] = false,
   ["RGBPhone"] = false,
   ["RGBVehicle"] = false,
   ["Noclip"] = false,
   ["AntiHouseBan"] = false,
   ["AntiFling"] = false,
   ["FreePay"] = false,
   ["Vehicle0To60"] = 0.2,
   ["VehicleSpeed"] = 300, -- The default maximum speed for Life Together RP vehicles (when you have LifePay Premium, but can be higher to what ever you want with the script).
   ["VehicleAcceleration"] = 200, -- Just to be clear, this is the vehicle Maximum Acceleration, not the take off time (that's "Vehicle0To60")
   -- These are my two personal setups I use, even though I am not a developer or an admin lol.
   ["Name"] = "DEVELOPER",
   ["Bio"] = "-AURA-",
}--]]
wait()
local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local fileName = "LifeTogether_Admin_Configuration.json"
-- [[ Now we have an allowed Prefix system, so we can correctly modify your Prefix if it's broken. ]] --
local Allowed_Prefixes = {
   "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "=", "_", "+", ",",
   ".", "/", ">", "<", "?", "~", "`", "}", "{", "[", "]", ":", "1", "2", "3", "4", "5", "·", "•", "∙", "⋅", "£"
}
local function isAllowedPrefix(prefix)
   for _, p in ipairs(Allowed_Prefixes) do
      if prefix == p then
         return true
      end
   end
   return false
end
-- [[ Now checks if your Prefix is allowed or not, so we can always check if it's broken or not. ]] --

local function loadPrefix()
   local defaultPrefix = "-"
   local data = { prefix = defaultPrefix }

   if isfile and isfile(fileName) then
      local success, decoded = pcall(function()
         return HttpService:JSONDecode(readfile(fileName))
      end)

      if success and type(decoded) == "table" and decoded.prefix then
         local prefix = tostring(decoded.prefix)
         if prefix == "symbol" or not isAllowedPrefix(prefix) then
            -- [[ Fix the users Prefix if we found that it's broken. ]] --
            getgenv().notify("Warning", "We've automatically modified your Prefix, it was broken or not an allowed Prefix.", 5)
            decoded.prefix = defaultPrefix
            writefile(fileName, HttpService:JSONEncode(decoded))
            return defaultPrefix
         else
            -- [[ Otherwise return the correct Prefix and continue. ]] --
            return prefix
         end
      end
   end

   writefile(fileName, HttpService:JSONEncode(data))
   return defaultPrefix
end

wait(0.1)
local Loaded_Prefix = loadPrefix()
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local HiddenUI = get_hidden_gui and get_hidden_gui() or gethui and gethui()

if HiddenUI then
   for _, v in ipairs(HiddenUI:GetDescendants()) do
      if v:IsA("Frame") and v.Name == "ResizeControls" and v.Parent.Name == "Main" then
         if v.Parent.Parent:IsA("ScreenGui") then
            getgenv().notify("Warning", "Are you using Dex Explorer with our script? I surely hope not, seems like you are... the script is literally open source.", 15)
         end
      end
   end
else
   for _, v in ipairs(CoreGui:GetDescendants()) do
      if v:IsA("Frame") and v.Name == "ResizeControls" and v.Parent.Name == "Main" then
         getgenv().notify("Warning", "Are you using Dex Explorer with our script? I surely hope not, seems like you are... the script is literally open source.", 15)
      end
   end
end

local UserInputService = getgenv().UserInputService
local TweenService = getgenv().TweenService
wait(0.3)
local Admins = {
   [getgenv().LocalPlayer.Name] = true
}
wait()
getgenv().AdminPrefix = loadPrefix() or ";"
if getgenv().IY_LOADED and getgenv().AdminPrefix == ";" then
   getgenv().notify("Warning", "Hey! You have Infinite Yield loaded and your prefix is ; | change it! or it'll make you execute IY's commands!", 13)
elseif getgenv().GET_LOADED_IY and getgenv().AdminPrefix == ";" then
   getgenv().notify("Warning", "Hey! You have Infinite Premium loaded and your prefix is ; | change it! or it'll make you execute IY's commands!", 13)
end
wait(0.2)
print("[Prefix]: Loaded Saved Prefix --> ", tostring(getgenv().AdminPrefix))
wait(0.5)
local Workspace = getgenv().Workspace
local Players = getgenv().Players
local LocalPlayer = getgenv().LocalPlayer or getgenv().Players.LocalPlayer
local Character = getgenv().Character
local HumanoidRootPart = getgenv().HumanoidRootPart
local Humanoid = getgenv().Humanoid
local ReplicatedStorage = getgenv().ReplicatedStorage
local AllCars = {
   "Magic Carpet", "EClass", "TowTruck", "Bicycle", "Fiat500", "Cayenne", "Jetski", "LuggageScooter",
   "MiniCooper", "GarbageTruck", "EScooter", "Monster Truck", "Yacht", "Stingray", "FireTruck", "VespaPizza",
   "VespaPolice", "F150", "Police SUV", "Chiron", "Humvee", "Wrangler", "Box Van", "Ambulance", "Urus", "Tesla",
   "Cybertruck", "RollsRoyce", "GClass", "SVJ", "MX5", "SF90", "Charger SRT", "Evoque", "IceCream Truck",
   "Vespa", "ATV", "Limo", "Tank", "Smart Car", "Beauford", "SchoolBus", "Sprinter", "GolfKart", "TrackHawk",
   "Helicopter", "SnowPlow", "Camper Van", "SWAT Van"
}
local CarMap = {}

for _, name in ipairs(AllCars) do
   CarMap[name:lower()] = name
end

function car_listing_gui()
   local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
   if CoreGui:FindFirstChild("CarListUI") then return end

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "CarListUI"
   ScreenGui.ResetOnSpawn = false
   ScreenGui.IgnoreGuiInset = true
   ScreenGui.Parent = CoreGui

   local isMobile = getgenv().UserInputService.TouchEnabled

   local MainFrame = Instance.new("Frame")
   MainFrame.Size = isMobile and UDim2.new(0, 280, 0, 350) or UDim2.new(0, 350, 0, 450)
   MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset/2, 0.5, -MainFrame.Size.Y.Offset/2)
   MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
   MainFrame.BorderSizePixel = 0
   MainFrame.Active = true
   MainFrame.Parent = ScreenGui

   local UICorner = Instance.new("UICorner")
   UICorner.CornerRadius = UDim.new(0, 15)
   UICorner.Parent = MainFrame

   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -40, 0, 40)
   Title.Position = UDim2.new(0, 10, 0, 0)
   Title.BackgroundTransparency = 1
   Title.Text = "Made by: "..tostring(Script_Creator)
   Title.Font = Enum.Font.GothamBold
   Title.TextSize = 18
   Title.TextColor3 = Color3.fromRGB(255, 255, 255)
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Parent = MainFrame

   local CloseButton = Instance.new("TextButton")
   CloseButton.Size = UDim2.new(0, 30, 0, 30)
   CloseButton.Position = UDim2.new(1, -35, 0, 5)
   CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
   CloseButton.Text = "X"
   CloseButton.Font = Enum.Font.GothamBold
   CloseButton.TextSize = 16
   CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   CloseButton.Parent = MainFrame

   local CloseCorner = Instance.new("UICorner")
   CloseCorner.CornerRadius = UDim.new(0, 8)
   CloseCorner.Parent = CloseButton

   CloseButton.MouseButton1Click:Connect(function()
      ScreenGui:Destroy()
   end)

   local ScrollingFrame = Instance.new("ScrollingFrame")
   ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
   ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
   ScrollingFrame.BackgroundTransparency = 1
   ScrollingFrame.BorderSizePixel = 0
   ScrollingFrame.ScrollBarThickness = 6
   ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
   ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
   ScrollingFrame.Parent = MainFrame

   local UIListLayout = Instance.new("UIListLayout")
   UIListLayout.Parent = ScrollingFrame
   UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
   UIListLayout.Padding = UDim.new(0, 5)

   local UIPadding = Instance.new("UIPadding")
   UIPadding.Parent = ScrollingFrame
   UIPadding.PaddingLeft = UDim.new(0, 5)
   UIPadding.PaddingTop = UDim.new(0, 5)

   for _, name in ipairs(AllCars) do
      local CarButton = Instance.new("TextButton")
      CarButton.Size = UDim2.new(1, -10, 0, 30)
      CarButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
      CarButton.Text = name
      CarButton.Font = Enum.Font.Gotham
      CarButton.TextSize = 16
      CarButton.TextColor3 = Color3.fromRGB(220, 220, 220)
      CarButton.Parent = ScrollingFrame

      local CarCorner = Instance.new("UICorner")
      CarCorner.CornerRadius = UDim.new(0, 10)
      CarCorner.Parent = CarButton

      CarButton.MouseButton1Click:Connect(function()
         if not getgenv().Get then return end
         getgenv().Get("spawn_vehicle", name)
      end)
   end

   local dragging, dragInput, dragStart, startPos

   local function update(input)
      local delta = input.Position - dragStart
      local goal = UDim2.new(
         startPos.X.Scale,
         startPos.X.Offset + delta.X,
         startPos.Y.Scale,
         startPos.Y.Offset + delta.Y
      )
      TweenService:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = goal}):Play()
   end

   MainFrame.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
         dragging = true
         dragStart = input.Position
         startPos = MainFrame.Position

         input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
               dragging = false
            end
         end)
      end
   end)

   MainFrame.InputChanged:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
         dragInput = input
      end
   end)

   UserInputService.InputChanged:Connect(function(input)
      if input == dragInput and dragging then
         update(input)
      end
   end)
end

local function get_other_vehicle(Player)
   for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
      if not v:FindFirstChild("owner") then return getgenv().notify("Error", "There is not an Owner value in this players Vehicle!", 7) end
      if v.owner.Value == Player then
         return v
      end
   end

   return nil
end

function save_outfits_GUI()
   if getgenv().Core:FindFirstChild("OutfitManagerUI") then
      return getgenv().notify("Warning", "You're already running Outfit Manager!", 5)
   end
   if getgenv().LoadedOutfit_Manager_GUI then
      return getgenv().notify("Warning", "You're already running Outfit Manager UI!", 6)
   end

   local g = getgenv()
   local HttpService = g.HttpService
   local LocalPlayer = g.LocalPlayer
   local Character = g.Character
   local Send, Get = g.Send, g.Get
   local FolderName = "lifetogether_admin_savedoutfits"
   local ui_refs = {}

   if not isfolder(FolderName) then makefolder(FolderName) end

   local function getOutfitFiles()
      local files = {}
      for _, f in ipairs(listfiles(FolderName)) do
         if f:match("%.json$") then table.insert(files, f) end
      end
      return files
   end

   local function readOutfitData(file)
      local ok, content = pcall(readfile, file)
      if ok and content and #content > 0 then
         local success, data = pcall(function() return HttpService:JSONDecode(content) end)
         if success and type(data) == "table" then return data end
      end
      return {}
   end

   local function writeOutfitData(name, data)
      if not name or name == "" then return end
      local path = FolderName .. "/" .. name .. ".json"
      writefile(path, HttpService:JSONEncode(data))
   end

   local function deleteOutfit(name)
      local path = FolderName .. "/" .. name .. ".json"
      if isfile(path) then delfile(path) end
   end

   local function clearAvatar()
      local Humanoid = g.Humanoid or (g.Character and g.Character:FindFirstChildOfClass("Humanoid"))
      if not Humanoid then return g.notify("Error", "Humanoid not found!", 5) end
      local desc = Humanoid:GetAppliedDescription()
      if not desc then return g.notify("Error", "Cannot get HumanoidDescription!", 5) end

      local assets = {}
      for _, acc in ipairs(desc:GetAccessories(true)) do
         if acc.AssetId and acc.AssetId > 0 then
            table.insert(assets, {id = acc.AssetId, type = acc.AccessoryType.Name .. "Accessory"})
         end
      end
      if desc.Shirt > 0 then table.insert(assets, {id = desc.Shirt, type = "Shirt"}) end
      if desc.Pants > 0 then table.insert(assets, {id = desc.Pants, type = "Pants"}) end
      if desc.GraphicTShirt > 0 then table.insert(assets, {id = desc.GraphicTShirt, type = "TShirt"}) end
      if desc.Face > 0 then table.insert(assets, {id = desc.Face, type = "Face"}) end
      for _, part in ipairs({"Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg"}) do
         if desc[part] and desc[part] > 0 then table.insert(assets, {id = desc[part], type = part}) end
      end

      g.notify("Info", "Clearing avatar ("..#assets.." assets)...", 3)
      for _, data in ipairs(assets) do
         pcall(function() Get("wear", data.id, data.type) end)
         task.wait(0.2)
      end

      local retries = 0
      while retries < 5 do
         task.wait(0.5)
         local check = Humanoid:GetAppliedDescription():GetAccessories(true)
         if #check == 0 then
            g.notify("Success", "Avatar fully cleared.", 3)
            return true
         end
         for _, acc in ipairs(check) do
            pcall(function() Get("wear", acc.AssetId, acc.AccessoryType.Name .. "Accessory") end)
            task.wait(0.1)
         end
         retries += 1
      end
      g.notify("Warning", "Avatar clear may be incomplete.", 4)
      return true
   end

   local function getAvatarAssets(player)
      if not player.Character then return {}, nil, nil, nil, nil, nil end
      local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
      if not humanoid then return {}, nil, nil, nil, nil, nil end
      local desc = humanoid:GetAppliedDescription()

      local assets = {}
      for _, acc in ipairs(desc:GetAccessories(true)) do
         if acc.AssetId and acc.AssetId > 0 then
            table.insert(assets, {id = acc.AssetId, type = acc.AccessoryType.Name .. "Accessory"})
         end
      end
      if desc.Shirt > 0 then table.insert(assets, {id = desc.Shirt, type = "Shirt"}) end
      if desc.Pants > 0 then table.insert(assets, {id = desc.Pants, type = "Pants"}) end
      if desc.GraphicTShirt > 0 then table.insert(assets, {id = desc.GraphicTShirt, type = "TShirt"}) end
      if desc.Face > 0 then table.insert(assets, {id = desc.Face, type = "Face"}) end
      for _, part in ipairs({"Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg"}) do
         if desc[part] and desc[part] > 0 then table.insert(assets, {id = desc[part], type = part}) end
      end

      local anims = {"Fall","Walk","Run","Jump","Idle","Climb","Swim"}
      local animData = {}
      for _, anim in ipairs(anims) do
         local id = desc[anim.."Animation"]
         if id and id > 0 then table.insert(animData, {id=id,type=anim.."Animation"}) end
      end

      local skinTone = desc.HeadColor or Color3.new(1,1,1)
      local height = desc.HeightScale or 1
      local width = desc.WidthScale or 1
      local age = player:GetAttribute("age")

      return assets, skinTone, height, width, animData, age
   end

   local function wearAssets(tbl)
      for _, data in ipairs(tbl) do
         pcall(function() Get("wear", data.id, data.type) end)
         task.wait(0.25)
      end
   end

   local function promptOutfitName(callback)
      local popup = Instance.new("ScreenGui")
      popup.Name = "OutfitNamePrompt"
      popup.IgnoreGuiInset = true
      popup.ResetOnSpawn = false
      popup.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      popup.Parent = getgenv().CoreGui

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 250, 0, 130)
      frame.Position = UDim2.new(0.5, -125, 0.5, -65)
      frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
      frame.Parent = popup
      Instance.new("UICorner", frame)

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(1, -10, 0, 30)
      title.Position = UDim2.new(0, 5, 0, 5)
      title.BackgroundTransparency = 1
      title.Text = "Enter Outfit Name"
      title.TextColor3 = Color3.new(1, 1, 1)
      title.Font = Enum.Font.GothamBold
      title.TextScaled = true
      title.Parent = frame

      local txt = Instance.new("TextBox")
      txt.PlaceholderText = "Outfit Name"
      txt.Size = UDim2.new(1, -20, 0, 35)
      txt.Position = UDim2.new(0, 10, 0, 40)
      txt.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
      txt.TextColor3 = Color3.new(1, 1, 1)
      txt.Font = Enum.Font.Gotham
      txt.TextScaled = true
      txt.ClearTextOnFocus = true
      txt.Text = ""
      txt.Parent = frame
      Instance.new("UICorner", txt)

      local save_btn = Instance.new("TextButton")
      save_btn.Size = UDim2.new(1, -20, 0, 35)
      save_btn.Position = UDim2.new(0, 10, 0, 85)
      save_btn.Text = "Save"
      save_btn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
      save_btn.TextColor3 = Color3.new(1, 1, 1)
      save_btn.Font = Enum.Font.GothamBold
      save_btn.TextScaled = true
      save_btn.Parent = frame
      Instance.new("UICorner", save_btn)

      save_btn.MouseButton1Click:Connect(function()
         local name = txt.Text:gsub("%s+", "")
         if name ~= "" then
            popup:Destroy()
            task.wait()
            callback(name)
         else
            g.notify("Error", "Enter a valid outfit name.", 5)
         end
      end)
   end

   local function refreshOutfitList()
      local scroller = ui_refs.scroller
      if not scroller then return g.notify("Warning", "Scroller missing from UI.", 5) end

      for _, child in ipairs(scroller:GetChildren()) do
         if child:IsA("Frame") then child:Destroy() end
      end

      for _, file in ipairs(getOutfitFiles()) do
         local name = file:match("([^/\\]+)%.json$")
         local entry = Instance.new("Frame")
         entry.Size = UDim2.new(1,-5,0,35)
         entry.BackgroundColor3 = Color3.fromRGB(35,35,35)
         entry.Parent = scroller
         Instance.new("UICorner", entry)

         local label = Instance.new("TextLabel")
         label.Size = UDim2.new(0.349999994, 0, 1, 0)
         label.BackgroundTransparency = 1
         label.Text = name
         label.TextColor3 = Color3.new(1,1,1)
         label.Font = Enum.Font.Gotham
         label.TextScaled = true
         label.Parent = entry

         local wearBtn = Instance.new("TextButton")
         wearBtn.Size = UDim2.new(0.25, -30, 1, -10)
         wearBtn.Position = UDim2.new(0.5, 40, 0, 7)
         wearBtn.Text = "💾 Wear 💾"
         wearBtn.BackgroundColor3 = Color3.fromRGB(249,232,0)
         wearBtn.TextColor3 = Color3.fromRGB(0,0,0)
         wearBtn.Font = Enum.Font.Gotham
         wearBtn.TextScaled = true
         wearBtn.Parent = entry
         Instance.new("UICorner", wearBtn)

         local renameBtn = Instance.new("TextButton")
         renameBtn.Size = UDim2.new(0.25, -30, 1, -8)
         renameBtn.Position = UDim2.new(0, 180, 0, 7)
         renameBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
         renameBtn.TextColor3 = Color3.new(1, 1, 1)
         renameBtn.Font = Enum.Font.SourceSansBold
         renameBtn.TextScaled = true
         renameBtn.Text = "✏️ Rename ✏️"
         renameBtn.Parent = entry
         renameBtn.LayoutOrder = 2

         local UICorner = Instance.new("UICorner")
         UICorner.CornerRadius = UDim.new(0, 6)
         UICorner.Parent = renameBtn

         renameBtn.MouseButton1Click:Connect(function()
            if g.is_busy_outfit_manager then
               return g.notify("Warning", "Busy, wait!", 4)
            end

            local oldFilePath = file
            if not isfile(oldFilePath) then
               return g.notify("Error", "File not found!", 4)
            end

            promptOutfitName(function(newName)
               if not newName or newName == "" then
                  return g.notify("Error", "Invalid new name!", 4)
               end

               local newFilePath = FolderName .. "/" .. newName .. ".json"
               if isfile(newFilePath) then
                  return g.notify("Error", "A file with that name already exists!", 4)
               end

               local success, err = pcall(function()
                  local content = readfile(oldFilePath)
                  writefile(newFilePath, content)
                  delfile(oldFilePath)
               end)

               if success then
                  g.notify("Success", "Outfit renamed to: " .. newName, 4)
                  refreshOutfitList()
               else
                  g.notify("Error", "Failed to rename: " .. tostring(err), 4)
               end
            end)
         end)

         local delBtn = Instance.new("TextButton")
         delBtn.Size = UDim2.new(0.25, -30, 1, -10)
         delBtn.Position = UDim2.new(0, 380, 0.200000003, 0)
         delBtn.Text = "🗑️"
         delBtn.BackgroundColor3 = Color3.fromRGB(180,40,40)
         delBtn.TextColor3 = Color3.new(1,1,1)
         delBtn.Font = Enum.Font.Gotham
         delBtn.TextScaled = true
         delBtn.Parent = entry
         Instance.new("UICorner", delBtn)

         delBtn.MouseButton1Click:Connect(function()
            g.notify("Warning", "Click again to confirm delete: "..name, 5)
            delBtn.MouseButton1Click:Once(function()
               deleteOutfit(name)
               refreshOutfitList()
               g.notify("Success", "Deleted outfit: "..name, 5)
            end)
         end)

         wearBtn.MouseButton1Click:Connect(function()
            if g.is_busy_outfit_manager then
               return g.notify("Warning", "Busy, wait!", 4)
            end
            g.is_busy_outfit_manager = true

            local data = readOutfitData(file)
            if not data or type(data) ~= "table" then
               g.is_busy_outfit_manager = false
               return g.notify("Error", "Failed to read outfit data!", 5)
            end

            clearAvatar()
            task.wait(0.5)

            local bodyParts = {
               "Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg"
            }
            for _, key in ipairs(bodyParts) do
               local val = data[key]
               if val and val ~= 0 and val ~= "" then
                  pcall(function()
                     Get("wear", val, key)
                  end)
                  task.wait(0.2)
               end
            end

            local clothing = {"Shirt","Pants","GraphicTShirt","Face"}
            for _, key in ipairs(clothing) do
               local val = data[key]
               if val and val ~= 0 and val ~= "" then
                  pcall(function()
                     Get("wear", val, key)
                  end)
                  task.wait(0.2)
               end
            end

            if data.Accessories and type(data.Accessories) == "table" then
               for _, acc in ipairs(data.Accessories) do
                  if acc.AssetId and acc.AccessoryType then
                     pcall(function()
                        Get("wear", acc.AssetId, acc.AccessoryType .. "Accessory")
                     end)
                     task.wait(0.25)
                  end
               end
            end

            if data.SkinTone then
               pcall(function()
                  local c = Color3.new(data.SkinTone[1], data.SkinTone[2], data.SkinTone[3])
                  Send("skin_tone", c)
               end)
               task.wait(0.3)
            end

            if data.HeightScale then
               pcall(function()
                  Send("body_scale", "HeightScale", data.HeightScale * 100)
               end)
            end
            if data.WidthScale then
               pcall(function()
                  Send("body_scale", "WidthScale", data.WidthScale * 100)
               end)
            end

            if data.Age then
               pcall(function()
                  Get("age", tostring(data.Age))
               end)
               task.wait(0.3)
            end

            local animKeys = {
               "FallAnimation","WalkAnimation","RunAnimation",
               "JumpAnimation","IdleAnimation","ClimbAnimation","SwimAnimation"
            }
            for _, key in ipairs(animKeys) do
               local val = data[key]
               if val and val ~= 0 and val ~= "" then
                  pcall(function()
                     Get("wear", val, key)
                  end)
                  task.wait(0.2)
               end
            end

            g.notify("Success", "Outfit applied successfully!", 4)
            g.is_busy_outfit_manager = false
         end)
      end
   end

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "OutfitManagerUI"
   ScreenGui.ResetOnSpawn = false
   ScreenGui.IgnoreGuiInset = true
   ScreenGui.Parent = g.CoreGui
   g.LoadedOutfit_Manager_GUI = true

   local Frame = Instance.new("Frame")
   Frame.Size = UDim2.new(0, 500, 0, 400)
   Frame.Position = UDim2.new(0.5, -250, 0.5, -200)
   Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
   Frame.BorderSizePixel = 0
   Frame.Parent = ScreenGui
   Instance.new("UICorner", Frame)

   local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
   local TweenService = getgenv().TweenService or cloneref(game:GetService("TweenService"))

   local dragging = false
   local drag_start, start_pos

   local smoothness = 0.20

   Frame.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
         dragging = true
         drag_start = input.Position
         start_pos = Frame.Position
         input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
               dragging = false
            end
         end)
      end
   end)

   UserInputService.InputChanged:Connect(function(input)
      if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
         local delta = input.Position - drag_start
         local target = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X, start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
         TweenService:Create(Frame, TweenInfo.new(smoothness, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Position = target }):Play()
      end
   end)

   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1,0,0,35)
   Title.BackgroundTransparency = 1
   Title.Text = "👔 Outfits Manager 👔   "
   Title.TextColor3 = Color3.new(1,1,1)
   Title.Font = Enum.Font.GothamBold
   Title.TextScaled = true
   Title.TextSize = 18
   Title.Parent = Frame

   local CloseButton = Instance.new("TextButton")
   CloseButton.Size = UDim2.new(0,30,0,30)
   CloseButton.Position = UDim2.new(1,-35,0,5)
   CloseButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
   CloseButton.Text = "✖"
   CloseButton.TextColor3 = Color3.fromRGB(196,40,28)
   CloseButton.Font = Enum.Font.GothamBold
   CloseButton.TextSize = 16
   CloseButton.Parent = Frame
   Instance.new("UICorner", CloseButton)

   CloseButton.MouseButton1Click:Connect(function()
      ScreenGui:Destroy()
      g.LoadedOutfit_Manager_GUI = false
   end)

   local SaveButton = Instance.new("TextButton")
   SaveButton.Size = UDim2.new(0.5,-5,0,35)
   SaveButton.Position = UDim2.new(0,5,0,40)
   SaveButton.Text = "💾 Save Outfit 💾"
   SaveButton.BackgroundColor3 = Color3.fromRGB(40,170,90)
   SaveButton.TextColor3 = Color3.new(1,1,1)
   SaveButton.Font = Enum.Font.Gotham
   SaveButton.TextScaled = true
   SaveButton.TextSize = 16
   SaveButton.Parent = Frame
   Instance.new("UICorner", SaveButton)

   local RefreshButton = Instance.new("TextButton")
   RefreshButton.Size = UDim2.new(0.5,-5,0,35)
   RefreshButton.Position = UDim2.new(0.5,0,0,40)
   RefreshButton.Text = "🔁 Refresh 🔁"
   RefreshButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
   RefreshButton.TextColor3 = Color3.new(1,1,1)
   RefreshButton.Font = Enum.Font.Gotham
   RefreshButton.TextScaled = true
   RefreshButton.TextSize = 16
   RefreshButton.Parent = Frame
   Instance.new("UICorner", RefreshButton)

   ui_refs.frame = Frame

   local scroller = Instance.new("ScrollingFrame")
   scroller.Name = "ScrollingFrame"
   scroller.Size = UDim2.new(1,-10,1,-90)
   scroller.Position = UDim2.new(0,5,0,80)
   scroller.BackgroundTransparency = 1
   scroller.BorderSizePixel = 0
   scroller.ScrollBarThickness = 6
   scroller.Parent = Frame

   ui_refs.scroller = scroller

   local UIListLayout = Instance.new("UIListLayout")
   UIListLayout.Padding = UDim.new(0,6)
   UIListLayout.Parent = scroller

   local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
   UIListLayout.Padding = UDim.new(0,6)

   SaveButton.MouseButton1Click:Connect(function()
      if g.is_busy_outfit_manager then
         return g.notify("Warning", "Busy, wait!", 4)
      end
      g.is_busy_outfit_manager = true

      promptOutfitName(function(name)
         local char = Character
         if not char or not char:FindFirstChildOfClass("Humanoid") then
            g.is_busy_outfit_manager = false
            return g.notify("Error", "Character or Humanoid missing!", 4)
         end

         local humanoid = char:FindFirstChildOfClass("Humanoid")
         local desc = humanoid and humanoid:GetAppliedDescription()
         if not desc then
            g.is_busy_outfit_manager = false
            return g.notify("Error", "Failed to get HumanoidDescription!", 4)
         end

         local outfit = {}

         outfit.Accessories = {}
         for _, info in ipairs(desc:GetAccessories(true)) do
            table.insert(outfit.Accessories, {
               AssetId = info.AssetId,
               AccessoryType = info.AccessoryType.Name,
               IsLayered = info.IsLayered
            })
         end

         outfit.Shirt = desc.Shirt
         outfit.Pants = desc.Pants
         outfit.GraphicTShirt = desc.GraphicTShirt
         outfit.Face = desc.Face
         outfit.Head = desc.Head
         outfit.Torso = desc.Torso
         outfit.LeftArm = desc.LeftArm
         outfit.RightArm = desc.RightArm
         outfit.LeftLeg = desc.LeftLeg
         outfit.RightLeg = desc.RightLeg
         outfit.ClimbAnimation = desc.ClimbAnimation
         outfit.FallAnimation = desc.FallAnimation
         outfit.IdleAnimation = desc.IdleAnimation
         outfit.JumpAnimation = desc.JumpAnimation
         outfit.RunAnimation = desc.RunAnimation
         outfit.SwimAnimation = desc.SwimAnimation
         outfit.WalkAnimation = desc.WalkAnimation
         outfit.HeightScale = desc.HeightScale
         outfit.WidthScale = desc.WidthScale

         local hc = desc.HeadColor
         outfit.SkinTone = { hc.R, hc.G, hc.B }

         local age = LocalPlayer:GetAttribute("age")
         if age then
            outfit.Age = tostring(age)
         end

         local jsonData
         local ok, err = pcall(function()
            jsonData = HttpService:JSONEncode(outfit)
         end)

         if not ok or not jsonData then
            g.is_busy_outfit_manager = false
            return g.notify("Error", "Failed to encode outfit data.", 4)
         end

         local filePath = FolderName .. "/" .. name .. ".json"
         local success, writeErr = pcall(function()
            writefile(filePath, jsonData)
         end)

         if not success then
            g.is_busy_outfit_manager = false
            return g.notify("Error", "Failed to save outfit file!", 4)
         end

         g.notify("Success", "Saved outfit: " .. name, 4)
         refreshOutfitList()
         g.is_busy_outfit_manager = false
      end)
   end)

   RefreshButton.MouseButton1Click:Connect(refreshOutfitList)
   refreshOutfitList()
   g.notify("Success","[Outfit Manager UI]: Loaded.",6)
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
      getgenv().notify("Success", "[Enabled]: Rainbow Vehicle.", 4)
      while getgenv().Rainbow_Vehicle == true do
         task.wait(0)
         for _, color in ipairs(colors) do
            task.wait(0)
            if getgenv().Rainbow_Vehicle ~= true then return end
            change_vehicle_color(color, get_vehicle())
         end
      end
   elseif Boolean == false then
      getgenv().Rainbow_Vehicle = false
      Boolean = false
      getgenv().notify("Success", "[Disabled]: Rainbow Vehicle.", 4)
   end
end
wait()
function RGB_Vehicle_Others(Player, Boolean)
   getgenv().Rainbow_Others_Vehicle = Boolean
   local PlayersName = Player and Player.Name

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
      getgenv().notify("Success", "Enabled Rainbow Vehicle for: "..tostring(Player), 5)
      while getgenv().Rainbow_Others_Vehicle == true do
         task.wait(.2)
         for _, color in ipairs(colors) do
            task.wait(.2)
            if getgenv().Rainbow_Others_Vehicle ~= true then return end
            if get_other_vehicle(Player):GetAttribute("locked") == true then
               return 
            end
            if not Player then
               getgenv().Rainbow_Others_Vehicle = false
               return getgenv().notify("Error", tostring(PlayersName).." has left the game.", 5)
            end
            change_vehicle_color(color, Player)
         end
      end
   elseif Boolean == false then
      getgenv().Rainbow_Others_Vehicle = false
      Boolean = false
   end
end
wait(0.1)
local GameAnalytics
local GA_Client
local GA_Directories = {
   ["ReplicatedFirst"] = true,
   ["ReplicatedStorage"] = true,
   ["Workspace"] = true,
   ["Players"] = true,
   ["Lighting"] = true,
   ["StarterGui"] = true,
   ["StarterPack"] = true,
   ["StarterPlayer"] = true,
}

-- bypass this Life Together RP, I'd love to see you try, I'd update it instantly to if you somehow did, say goodbye to them stupid ass logs lmfao.
if getgenv().ReplicatedStorage:FindFirstChild("GameAnalytics") then
   GameAnalytics = getgenv().ReplicatedStorage:FindFirstChild("GameAnalytics")

   if GameAnalytics:FindFirstChild("GameAnalyticsClient") then
      GA_Client = GameAnalytics:FindFirstChild("GameAnalyticsClient")

      if GA_Client then
         GA_Client:Destroy()
      end
   end
else
   for service in pairs(GA_Directories) do
      local service = getgenv().Game:GetService(service)

      if service then
         for _, descendant in ipairs(service:GetDescendants()) do
            if descendant:IsA("ModuleScript") and descendant.Name:lower():find("GameAnalyticsClient") then
               descendant:Destroy()
            end
         end
      end
   end
end

if getgenv().ReplicatedStorage:FindFirstChild("GameAnalyticsRemoteTime") then
   GameAnalytics = getgenv().ReplicatedStorage:FindFirstChild("GameAnalyticsRemoteTime")

   if GameAnalytics:FindFirstChild("GameAnalyticsRemoteTime") then
      GA_Client = GameAnalytics:FindFirstChild("GameAnalyticsRemoteTime")

      if GA_Client then
         GA_Client:Destroy()
      end
   end
else
   for service in pairs(GA_Directories) do
      local service = getgenv().Game:GetService(service)

      if service then
         for _, descendant in ipairs(service:GetDescendants()) do
            if descendant:IsA("ModuleScript") and descendant.Name:lower():find("GameAnalyticsClient") then
               descendant:Destroy()
            end
         end
      end
   end
end

for i, v in pairs(getgenv().PlayerGui:GetDescendants()) do
   if v:IsA("LocalScript") and v.Name == "kickerstript" then
      if not v.Disabled then
         v.Disabled = true
      end
   end
end

local Old_Skintone = getgenv().Character:FindFirstChild("Body Colors").TorsoColor3

function rainbow_skin(boolean)
   if boolean == true then
      getgenv().notify("Success", "Enabled Rainbow/RGB skintone.", 5)
      getgenv().RainbowSkin_FE = true
      while getgenv().RainbowSkin_FE == true do
         task.wait(.3)
         local colors = {
            Color3.fromRGB(0, 0, 0), Color3.fromRGB(217, 101, 30),
            Color3.fromRGB(93, 171, 195), Color3.fromRGB(49, 34, 21),
            Color3.fromRGB(8, 62, 11), Color3.fromRGB(30, 146, 19),
            Color3.fromRGB(97, 97, 97), Color3.fromRGB(206, 158, 196),
            Color3.fromRGB(14, 25, 43), Color3.fromRGB(63, 17, 126),
            Color3.fromRGB(0, 0, 175), Color3.fromRGB(183, 25, 25),
            Color3.fromRGB(213, 208, 29), Color3.fromRGB(175, 146, 50),
            Color3.fromRGB(202, 28, 120),
         }

         for _, c in ipairs(colors) do
            if not getgenv().RainbowSkin_FE then return end
            send_remote("skin_tone", c)
            task.wait(0.2)
         end
      end
   else
      getgenv().RainbowSkin_FE = false
      wait(1)
      repeat task.wait() until getgenv().RainbowSkin_FE == false
      if getgenv().RainbowSkin_FE == false then
         getgenv().notify("Success", "Disabled Rainbow/RGB skintone.", 5)
         task.wait(0.5)
         getgenv().Send("skin_tone", Old_Skintone)
         getgenv().notify("Success", "Reset SkinTone back to your old SkinTone.", 3)
      end
   end
end

local function savePrefix(newPrefix)
   if writefile then
      local data = { prefix = newPrefix }
      writefile(fileName, HttpService:JSONEncode(data))
   end
end

local Amount_Input = 5

function set_fire_amount_FE(amount)
   amount = tonumber(amount)

   if not amount then
      Amount_Input = 5
      return
   end

   Amount_Input = amount
end

function anti_void()
   local root = getgenv().getRoot(getgenv().Character)
   local oldpos = root.CFrame

   if getgenv().Anti_Void_Falling then
      getgenv().Anti_Void_Falling:Disconnect()
      getgenv().Anti_Void_Falling = nil
   end

   local OrgDestroyHeight = getgenv().Workspace.FallenPartsDestroyHeight
   task.wait(0.2)
   getgenv().Workspace.FallenPartsDestroyHeight = 0/1/0
   task.wait(0.1)
   root.CFrame = CFrame.new(Vector3.new(0, OrgDestroyHeight - 25, 0))
   task.wait(1)
   root.CFrame = oldpos
   task.wait(0.1)
   getgenv().Anti_Void_Falling = getgenv().RunService.Stepped:Connect(function()
      if root and root.Position.Y <= OrgDestroyHeight + 25 then
         root.Velocity = root.Velocity + Vector3.new(0, 250, 0)
      end
   end)
end

function unsuspend_GUI_topbar()
   local CoreGui
   local Players

   if cloneref then
      Players = cloneref(game:GetService("Players"))
      CoreGui = cloneref(game:GetService("CoreGui"))
   else
      Players = game:GetService("Players")
      CoreGui = game:GetService("CoreGui")
   end

   task.wait(0.1)
   local LocalPlayer = Players.LocalPlayer

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "TopBarUI_UNSUSPEND"
   if get_hidden_gui or gethui then
      local hiddenUI = get_hidden_gui or gethui
      ScreenGui.Parent = hiddenUI() or CoreGui
   else
      ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 5)
   end
   ScreenGui.IgnoreGuiInset = true
   ScreenGui.ResetOnSpawn = false

   local UnsuspendTxt_Chat = Instance.new("TextButton")
   UnsuspendTxt_Chat.Name = "UnsuspendTextChat"
   UnsuspendTxt_Chat.Parent = ScreenGui
   UnsuspendTxt_Chat.Size = UDim2.new(0, 100, 0, 30)
   UnsuspendTxt_Chat.Position = UDim2.new(1, -240, 0, 10)
   UnsuspendTxt_Chat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
   UnsuspendTxt_Chat.BorderSizePixel = 0
   UnsuspendTxt_Chat.TextColor3 = Color3.fromRGB(0, 255, 0)
   UnsuspendTxt_Chat.TextScaled = true
   UnsuspendTxt_Chat.Font = Enum.Font.SourceSansBold
   UnsuspendTxt_Chat.Text = "Unsuspend Chat"

   local UICorner = Instance.new("UICorner")
   UICorner.CornerRadius = UDim.new(0, 20)
   UICorner.Parent = UnsuspendTxt_Chat

   local UIContainer = Instance.new("Frame")
   UIContainer.Name = "UIContainer"
   UIContainer.Parent = ScreenGui
   UIContainer.Size = UDim2.new(0, 1105, 0, 40)
   UIContainer.Position = UDim2.new(0.5, -550, 0, 0)
   UIContainer.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
   UIContainer.BackgroundTransparency = 0.2
   UIContainer.BorderSizePixel = 0
   UIContainer.Visible = false

   local UICorner = Instance.new("UICorner")
   UICorner.CornerRadius = UDim.new(0, 8)
   UICorner.Parent = UIContainer

   local UIStroke = Instance.new("UIStroke")
   UIStroke.Color = Color3.fromRGB(0, 0, 0)
   UIStroke.Thickness = 1
   UIStroke.Parent = UIContainer

   getgenv().unsuspend_chat_GUI = true

   UnsuspendTxt_Chat.MouseButton1Click:Connect(function()
      if not replicatesignal then return getgenv().notify("Error", "Your executor does not support 'replicatesignal'!", 6) end

      if replicatesignal then
         replicatesignal(getgenv().TextChatService.UpdateChatTimeout, getgenv().LocalPlayer.UserId, 0, 10)
         getgenv().notify("Success", "Unsuspended TextChat, you may now use your Chat like normal.", 6)
      end
   end)
end

if not getgenv().unsuspend_chat_GUI then
   unsuspend_GUI_topbar()
else
   getgenv().notify("Warning", "You've already loaded Unsuspend TextChat GUI!", 5)
end

local function stop_rainbow_skin()
   getgenv().RainbowSkin_FE = false
   task.wait(0.3)
   notify("Warning", "Waiting until loop is fully disabled and resetting SkinTone...", 5)
   task.wait(3)
   if getgenv().RainbowSkin_FE == false then
      notify("Warning", "Hold On! Loop is disabled, resetting SkinTone...", 5)
      task.wait(0.2)
      getgenv().Send("skin_tone", Old_Skintone)
      task.wait(0.2)
      getgenv().Send("skin_tone", Old_Skintone)
      task.wait(0.2)
      getgenv().Send("skin_tone", Old_Skintone)
   end
end

local function initCooldownHandler()
   local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
   local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
   local CooldownTime = 10
   local Chat = Enum.CoreGuiType.Chat

   getgenv().CooldownActive = getgenv().CooldownActive or false
   getgenv().HashtagCount = getgenv().HashtagCount or 0

   local function startCooldown(duration)
      if getgenv().CooldownActive then
         return getgenv().notify("Warning", "Your TextChat cooldown is still currently active.", 6)
      end
      getgenv().CooldownActive = true
      getgenv().notify("Info", "Cooldown started for: " .. duration .. "s.", 8)

      task.delay(duration, function()
         getgenv().CooldownActive = false
         getgenv().HashtagCount = 0
         pcall(function()
            StarterGui:SetCoreGuiEnabled(Chat, true)
         end)
         getgenv().notify("Success", "Chat re-enabled, cooldown ended.", 7)
      end)
   end

   local function cooldownListener(sender, msg)
      if sender ~= Players.LocalPlayer then return end
      local text = msg.Text
      if text and text:match("^#+$") then
         getgenv().HashtagCount += 1
         if getgenv().HashtagCount >= 4 then
            pcall(function()
               StarterGui:SetCoreGuiEnabled(Chat, false)
            end)
            startCooldown(CooldownTime)
            getgenv().notify("Warning", "Too many filtered messages, chat disabled temporarily (10 seconds).", 10)
         end
      end
   end

   table.insert(getgenv().ChatMessageHooks, cooldownListener)
end

if getgenv().ChatMetaMethodHookApplied then
   initCooldownHandler()
else
   getgenv().notify("Info", "Skipping cooldown handler — hook not applied.", 3)
end

if getgenv().FireParticlesAdded then
   getgenv().notify("Warning", "Connection has already been loaded here.", 5)
else
   local folder = getgenv().StarterGui:WaitForChild("FireTemporaryReparentFolder")
   getgenv().FireParticlesAdded = folder.ChildAdded:Connect(function(particle)
      particle:Destroy()
   end)
end
wait(0.2)
getgenv().SpamFire = false
getgenv().SpamFireLoop = nil
getgenv().DestroyFireConnection = nil
getgenv().HideFireConnection = nil
task.wait(0.1)
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

                     FireParticles.Parent = getgenv().StarterGui:FindFirstChild("FireTemporaryReparentFolder")
                     Sound.Parent = getgenv().StarterGui:FindFirstChild("FireTemporaryReparentFolder")
                  end
               end
            end
         end
      end

      disableFire()

      getgenv().DestroyFireConnection = getgenv().Workspace.ChildAdded:Connect(function()
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
         return getgenv().notify and getgenv().notify("Error", "Flame spamming is already enabled! Disable it before trying it again.", 5)
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
      if not getgenv().SpamFire then
         return getgenv().notify("Error", "Flame spammer is not enabled!", 5)
      end

      getgenv().SpamFire = false
      getgenv().CompletelyHideFlamesComingIn(false)
      getgenv().SpamFire = false
   end
end

local Old_Bio = getgenv().LocalPlayer:GetAttribute("bio") or "DEFAULT"
wait(0.2)
function anti_outfit_copier(toggle)
   if toggle == true then
      if getgenv().anti_outfit_stealer then
         return getgenv().notify("Error", "Anti Outfit Stealer is already enabled!", 5)
      end

      getgenv().notify("Info", "Do NOT change your Bio, this will not work otherwise (it'll auto-change back for you though incase you do)", 15)
      wait()
      local RunService = getgenv().RunService
      getgenv().AntiOutfitStealerConn = nil

      getgenv().ToggleAntiFit_Stealer = function(state)
         if not state then
            getgenv().anti_outfit_stealer = false

            if getgenv().AntiOutfitStealerConn then
               getgenv().AntiOutfitStealerConn:Disconnect()
               getgenv().AntiOutfitStealerConn = nil
            end

            local bio = getgenv().LocalPlayer:GetAttribute("bio")

            if bio and bio ~= "ANTI COPIER ENABLED HERE - THANKS!" then
               getgenv().Send("bio", "ANTI COPIER ENABLED HERE - THANKS!")
               getgenv().notify("Success", "Bio changed, reverted change.", 2)
            else
               getgenv().notify("Warning", "Bio not found, cannot unlock, disabled loop.", 5)
            end
            return 
         else
            getgenv().AutoLockOn = true
         end

         getgenv().AutoLockConnection = getgenv().RunService.Heartbeat:Connect(function()
            local bio = getgenv().LocalPlayer:GetAttribute("bio")

            if bio and bio ~= "ANTI COPIER ENABLED HERE - THANKS!" then
               getgenv().Send("bio", "ANTI COPIER ENABLED HERE - THANKS!")
               getgenv().notify("Success", "Bio changed, reverted change.", 2)
            end
         end)
      end
      wait(0.1)
      getgenv().ToggleAntiFit_Stealer(true)
   elseif toggle == false then
      getgenv().anti_outfit_stealer = false
      getgenv().Send("bio", tostring(Old_Bio))
   else
      return 
   end
end

getgenv().HD_FlyEnabled = false
local FlyConnection
local speed = 75
local FlyKeysDown = {}

function DisableFlyScript()
   if not getgenv().HD_FlyEnabled then
      return getgenv().notify("Warning", "Fly is not enabled!", 5)
   end

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

   if getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
      getgenv().Humanoid.PlatformStand = false
   end
end

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
      93202303625509,
      75684443936987,
      71498318840551,

   },
   aura = {
      121547391421211,
      78755795767408,
      88425531063616,
      111426928948833,
      111499780397123,
      88553023837929,
      120398163328092,
      95412133796590,
      132887675877488,
      95483853291380,
      70921452128720,
      124656572577172,
      107282826166809,
      107357050902519,
      83771892938118,
      84052327668385,
      124573843932871,
      83502723504906,
      77605999050017,
      116826272832592, -- like flippin sexy
      116520353469867,
      103040723950430,
      111474274315212,
      85452015445985,
      106383862917130,
      119895570354822,
      89740608652762,
      138488768673643,
      110077386833639,
      85092320680319,
      89841968488285,
      110559530726888,
      133016747050476,
      108635834286627,
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
      105003458897417,
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
      78250036534439,
   },
   sturdy = {
      122687759897103,
      133826541787717,
      85608190427964,
   },
   louisiana_jigg = {
      75625820126017,
   },
   takethel = {
      112884830175040,
      73593666217037,
      120292213172333,
      133545170540942,
      107451871815376,
      82405492529515,
      71490439912804,
      113855231967763
   },
   electroshuffle = {
      102699471013529,
      96426537876059,
      140499299581464,
   },
   laughitup = {
      139879794862714,
      90599528248903,
   },
   reanimated = {
      88624941199927,
      112989413190899,
   },
   jabba = {
      103538719480738,
      81074563419184,
      116936259925650,
      91111622942605,
      97502008524120,
      78000690242935,
      97263887198327,
      126450121068943,
   },
}

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
   ["michaelbounce"] = "michaelmyers",
   ["nysturdy"] = "sturdy",
   ["newyorksturdy"] = "sturdy",
   ["jiggy"] = "louisiana_jigg",
   ["takel"] = "takethel",
   ["takeanl"] = "takethel",
   ["ldance"] = "takethel",
   ["elecshuffle"] = "electroshuffle",
   ["eshuffle"] = "electroshuffle",
   ["reanimate"] = "reanimated",
   ["donkeylaugh"] = "laughitup",
   ["laughing"] = "laughitup",
   ["fnlaugh"] = "laughitup",
   ["fortnitelaugh"] = "laughitup",
}

function disable_emoting()
   local Humanoid = getgenv().Humanoid
   if not Humanoid then return end

   Humanoid.WalkSpeed = 0
   task.wait(1.1)
   pcall(function()
      for _, v in ipairs(Humanoid:GetPlayingAnimationTracks()) do
         v:Stop()
      end
   end)

   task.wait(0.3)

   local animate = getgenv().Character:FindFirstChild("Animate") or getgenv().Character:WaitForChild("Animate", 1)
   if animate and animate.Disabled then
      animate.Disabled = false
   end

   task.wait(0.5)
   Humanoid.WalkSpeed = 16
   if getgenv().Is_Currently_Emoting then
      getgenv().Is_Currently_Emoting = false
   end
end
wait(0.1)
getgenv().disable_emoting_script = disable_emoting
wait()
local lastEmoteTime = 0
wait()
function do_emote(input)
   if tick() - lastEmoteTime < 2 then
      return getgenv().notify("Warning", "Hold On! Emoting is on cooldown, wait a second (literally).", 5)
   end
   lastEmoteTime = tick()

   local Humanoid = getgenv().Humanoid
   if not Humanoid then
      disable_emoting()
      return getgenv().notify("Error", "Humanoid doesn't exist? (Try resetting)", 5)
   end

   local key = input:lower():gsub("%s+", "")
   if Aliases[key] then key = Aliases[key] end

   if getgenv().Is_Currently_Emoting then
      disable_emoting()
   end
   wait(0.3)
   local emoteList = Emotes[key]
   if emoteList then
      getgenv().Is_Currently_Emoting = true
      local choice = emoteList[math.random(1, #emoteList)]
      if not getgenv().Character:FindFirstChild("Animate") then
         getgenv().Is_Currently_Emoting = false
         return getgenv().notify("Error", "Something unexpected happened while trying to emote, try again.", 5)
      end
      if getgenv().Character:FindFirstChild("Animate").Disabled then
         getgenv().notify("Warning", "For some reason, the Animate LocalScript was still disabled, we enabled it (will disable in a second).", 10)
         getgenv().Character:WaitForChild("Animate").Disabled = false
      end
      local ok, track = Humanoid:PlayEmoteAndGetAnimTrackById(choice)
      wait(.1)
      local animate = getgenv().Character:FindFirstChild("Animate", true) or getgenv().Character:WaitForChild("Animate", 5)
      if animate then
         animate.Disabled = true
      end

      if ok and track then
         task.spawn(function()
            local conn
            conn = track.Stopped:Connect(function()
               if conn then conn:Disconnect() end
               if getgenv().Character and getgenv().Character:FindFirstChild("Animate") then
                  local animate = getgenv().Character:WaitForChild("Animate", 3)
                  if animate.Disabled then
                     animate.Disabled = false
                  end
               end
               getgenv().Is_Currently_Emoting = false
            end)
         end)
      else
         if animate and animate.Parent then
            if animate.Disabled then
               getgenv().Character:WaitForChild("Animate", 10).Disabled = false
            end
         end
         getgenv().Is_Currently_Emoting = false
      end
   end
end

function spam_sign_text(toggle)
   local Workspace = getgenv().Workspace
   local Character = getgenv().Character
   local PlacedModels = Workspace:WaitForChild("PlacedModels")
   local LocalPlayer = getgenv().LocalPlayer

   local random_words = {
      "yo","wsg bro","aye","lit","fire","cool","sick","yup",
      "nah","nah bro","bro?","wyd","naw bru","crazy","tuff","wow"
   }

   local function find_tool_partial(toolName)
      if not toolName then return nil end
      local query = toolName:lower()

      for _, v in ipairs(PlacedModels:GetChildren()) do
         if v:IsA("Model") and v.Name:lower() == query then
            local ownerAttr = v:GetAttribute("owner_id")
            if ownerAttr and tostring(ownerAttr) == tostring(LocalPlayer.UserId) then
               return v
            end
         end
      end

      for _, v in ipairs(Character:GetChildren()) do
         if v.Name:lower() == query then
            return v
         end
      end

      return nil
   end

   if toggle == true then
      if getgenv().ToolChanger_FE then return end
      getgenv().ToolChanger_FE = true

      task.spawn(function()
         while getgenv().ToolChanger_FE do
            local tool = find_tool_partial("sign")
            if not tool then
               getgenv().Send("get_tool", "Sign")
               task.wait(0.2)
            else
               for _, word in ipairs(random_words) do
                  if not getgenv().ToolChanger_FE then break end
                  getgenv().Send("change_sign", tool, tostring(word))
                  task.wait(.1)
               end
            end
            task.wait(0)
         end
      end)
   elseif toggle == false then
      getgenv().ToolChanger_FE = false
   else
      return 
   end
end

function change_phone_color(New_Color)
   send_remote("phone_color", New_Color)
end
task.wait(0.2)
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
      getgenv().notify("Success", "Started RGB/Rainbow Phone.", 5)
      while getgenv().RGB_Rainbow_Phone == true do
      task.wait(0)
         for _, color in ipairs(colors) do
            if getgenv().RGB_Rainbow_Phone ~= true then return end
            task.wait(0)
            change_phone_color(color)
         end
      end
   elseif Boolean == false then
      Boolean = false
      getgenv().RGB_Rainbow_Phone = false
      getgenv().notify("Success", "Stopped RGB/Rainbow Phone.", 5)
      task.wait(0.6)
      repeat task.wait() until getgenv().RGB_Rainbow_Phone == false
      if getgenv().RGB_Rainbow_Phone == false then
         change_phone_color(Color3.fromRGB(255, 255, 255))
      end
   end
end

getgenv().Noclip_Enabled = false
getgenv().Noclip_Connection = getgenv().Noclip_Connection or nil
local RunService = getgenv().RunService or game:GetService("RunService")

local function ToggleNoclip(toggle)
   if toggle == true then
      if getgenv().Noclip_Enabled then
         return getgenv().notify("Error", "Noclip already enabled!", 5)
      end

      local function NoclipLoop()
         if getgenv().Character then
            for _, part in ipairs(getgenv().Character:GetDescendants()) do
               if part:IsA("BasePart") and part.CanCollide then
                  part.CanCollide = false
               end
            end
         end
      end

      getgenv().Noclip_Connection = RunService.Stepped:Connect(NoclipLoop)
      getgenv().Noclip_Enabled = true
      getgenv().notify("Success", "Noclip has been enabled.", 5)
   elseif toggle == false then
      if not getgenv().Noclip_Enabled then
         return getgenv().notify("Error", "Noclip not enabled!", 5)
      end
      if getgenv().Noclip_Connection then
         getgenv().Noclip_Connection:Disconnect()
         getgenv().Noclip_Connection = nil
      end

      for _, part in pairs(getgenv().Character:GetDescendants()) do
         if part and part:IsA("BasePart") then
            part.CanCollide = true
         end
      end
      getgenv().Noclip_Enabled = false
      getgenv().notify("Success", "Noclip has been disabled.", 5)
   else
      return getgenv().notify("Error", "Invalid arg, expected true/false", 5)
   end
end

getgenv().Toggleable_Noclip = ToggleNoclip
wait()
local RunService = getgenv().RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")

local function clamp(x,a,b)
   return math.max(a, math.min(b, x))
end

local function stopWalkFlingInternal()
   getgenv().walkflinging = false
   if getgenv().WalkFlinging_Connection then
      getgenv().WalkFlinging_Connection:Disconnect()
      getgenv().WalkFlinging_Connection = nil
   end
   if getgenv().Noclip_Enabled then
      getgenv().Toggleable_Noclip(false)
   else
      getgenv().notify("Warning", "[WalkFling]: You do not have NoClip enabled.", 5)
   end
   getgenv().notify("Success", "WalkFling has been stopped.", 5)
end

local function startWalkFling()
   if getgenv().walkflinging then
      return getgenv().notify("Warning", "You already have WalkFling enabled!", 5)
   end

   getgenv().walkflinging = true
   if not getgenv().Noclip_Enabled then
      getgenv().Toggleable_Noclip(true)
   else
      getgenv().notify("Warning", "[WalkFling]: You already have NoClip enabled.", 5)
   end
   wait()
   getgenv().notify("Success", "Walkfling has been enabled.", 5)

   getgenv().WalkFlinging_Connection = getgenv().RunService.Heartbeat:Connect(function()
      if not getgenv().walkflinging then return getgenv().notify("Warning", "WalkFling has been disabled unexpectedly.", 5) end

      local lp = getgenv().LocalPlayer
      local character = getgenv().Character
      local hrp = getgenv().HumanoidRootPart
      if character and hrp then
         local originalVelocity = hrp.Velocity
         hrp.Velocity = originalVelocity * 10000 + Vector3.new(0, 10000, 0)

         RunService.RenderStepped:Wait()
         if character and hrp then
            hrp.Velocity = originalVelocity
         end

         RunService.Stepped:Wait()
         if character and hrp then
            hrp.Velocity = originalVelocity + Vector3.new(0, 0.1, 0)
         end
      end
   end)
end

getgenv().StartWalkFling = startWalkFling
getgenv().StopWalkFling = stopWalkFlingInternal

getgenv().OrbitConnections = getgenv().OrbitConnections or {}
getgenv().Is_Orbiting = false
getgenv().OrbitSpeed = 1

function set_orbit_speed(new_speed)
   if type(new_speed) == "number" then
      getgenv().OrbitSpeed = new_speed
      getgenv().notify("Info", "Orbit speed set to " .. tostring(new_speed), 4)
   else
      getgenv().notify("Error", "Invalid speed value.", 4)
   end
end

function stop_orbit()
   if not getgenv().Is_Orbiting then
      return getgenv().notify("Warning", "You're not orbiting anyone.", 5)
   end
   for _, conn in pairs(getgenv().OrbitConnections) do
      if typeof(conn) == "RBXScriptConnection" then
         conn:Disconnect()
      end
   end
   table.clear(getgenv().OrbitConnections)
   getgenv().Is_Orbiting = false
   getgenv().notify("Success", "Stopped orbiting Player.", 4)
end

function start_orbit_plr(target, speed, distance)
   if getgenv().Is_Orbiting then
      return getgenv().notify("Warning", "Already orbiting someone!", 4)
   end
   if not target or not target.Character then
      return getgenv().notify("Error", "Target invalid or missing character.", 5)
   end

   local RunService = getgenv().RunService or cloneref(game:GetService("RunService"))
   local getRoot = getgenv().getRoot
   local getHuman = getgenv().getHuman
   local root = getRoot(getgenv().Character)
   local humanoid = getHuman(getgenv().Character)
   local targetRoot = getRoot(target.Character)
   if not root or not humanoid or not targetRoot then
      return getgenv().notify("Error", "Missing root or humanoid, cannot orbit.", 5)
   end

   speed = tonumber(speed) or getgenv().OrbitSpeed or 1
   distance = tonumber(distance) or 3
   getgenv().OrbitSpeed = speed
   getgenv().Is_Orbiting = true

   local rotation = 0

   getgenv().OrbitConnections.Heartbeat = RunService.Heartbeat:Connect(function()
      pcall(function()
         if not getgenv().Is_Orbiting or not target.Character or not targetRoot or not root then
            return
         end
         rotation += getgenv().OrbitSpeed
         root.CFrame = CFrame.new(targetRoot.Position) * CFrame.Angles(0, math.rad(rotation), 0) * CFrame.new(distance, 0, 0)
      end)
   end)

   getgenv().OrbitConnections.RenderStepped = RunService.RenderStepped:Connect(function()
      pcall(function()
         if root and targetRoot then
            root.CFrame = CFrame.new(root.Position, targetRoot.Position)
         end
      end)
   end)

   getgenv().OrbitConnections.Died = humanoid.Died:Connect(stop_orbit)
   getgenv().OrbitConnections.Seated = humanoid.Seated:Connect(function(isSeated)
      if isSeated then stop_orbit() end
   end)

   getgenv().notify("Success", ("Started orbiting %s (Speed: %s, Distance: %s)"):format(tostring(target), tostring(speed), tostring(distance)), 5)
end

function water_skie_trailer(Bool, Vehicle)
   if not Vehicle then
      return notify("Warning", "You do not have a Vehicle spawned!", 5)
   end

   local HasTrailer = Vehicle:FindFirstChild("WaterSkies")

   if Bool == true then
      if HasTrailer then
         return notify("Error", "You already have the WaterSkies trailer.", 5)
      else
         getgenv().Get("add_trailer", Vehicle, "WaterSkies")
      end
   elseif Bool == false then
      if HasTrailer then
         getgenv().Get("add_trailer", Vehicle, "WaterSkies")
      else
         return getgenv().notify("Warning", "You do not have the WaterSkies trailer to take it off!", 5)
      end
   else
      return getgenv().notify("Error", "Invalid toggle value (expected: true/false).", 5)
   end
end
wait()

function EnableFly(speed)
   local player = getgenv().LocalPlayer
   local HRP = getgenv().HumanoidRootPart
   local Humanoid = getgenv().Humanoid
   local Camera = getgenv().Camera
   local RunService = getgenv().RunService
   local UIS = getgenv().UserInputService
   speed = tonumber(speed) or 125

   if getgenv().HD_FlyEnabled then
      return getgenv().notify("Warning", "Fly is already enabled!", 5)
   end
   if getgenv().antiFlingEnabled then
      return getgenv().notify("Error", "You have AntiFling enabled, turn it off first!", 6)
   end
   if getgenv().antiKnockbackEnabled then
      return getgenv().notify("Error", "You have AntiFling enabled, turn it off first!", 6)
   end

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

function create_or_get_blur()
   local Blur_Effect = getgenv().Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect")
   Blur_Effect.Enabled = false
   Blur_Effect.Size = 0
end

getgenv().VehicleStates = getgenv().VehicleStates or {}
wait(0.2)
create_or_get_blur()
if not getgenv().VehicleStates[getgenv().LocalPlayer.Name] then
   getgenv().VehicleStates[getgenv().LocalPlayer.Name] = getgenv().LocalPlayer
end

local Prefix = getgenv().AdminPrefix
local Gui_Parent_Default = get_hidden_gui or gethui
local CoreGui = getgenv().CoreGui or getgenv().PlayerGui
wait(0.1)
local function CommandsMenu()
   if Gui_Parent_Default():FindFirstChild("AdminCommandList_LifeTogether_RP") or CoreGui:FindFirstChild("AdminCommandList_LifeTogether_RP") then
      return getgenv().notify("Warning", "You already have the Commands Menu opened!", 5)
   end
   local cmdsUI = Instance.new("ScreenGui")
   cmdsUI.Name = "AdminCommandList_LifeTogether_RP"
   cmdsUI.ResetOnSpawn = false
   cmdsUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   cmdsUI.Parent = Gui_Parent_Default() or CoreGui

   local mainFrame = Instance.new("Frame")
   mainFrame.Size = UDim2.new(0, 600, 0, 500)
   mainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
   mainFrame.BackgroundColor3 = Color3.fromRGB(249, 214, 46)
   mainFrame.BorderSizePixel = 0
   mainFrame.Active = true
   mainFrame.Draggable = true
   mainFrame.Parent = cmdsUI

   local dragFrame = mainFrame
   local userInputService = getgenv().UserInputService
   local runService = getgenv().RunService
   local dragging = false
   local dragStart
   local startPos
   local currentDelta = Vector2.zero
   local targetDelta = Vector2.zero
   local smoothSpeed = 0.3

   dragFrame.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         dragging = true
         dragStart = Vector2.new(input.Position.X, input.Position.Y)
         startPos = dragFrame.Position

         input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
               dragging = false
            end
         end)
      end
   end)

   userInputService.InputChanged:Connect(function(input)
      if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
         targetDelta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
      end
   end)

   runService.RenderStepped:Connect(function()
      if dragging then
         currentDelta = currentDelta:Lerp(targetDelta, smoothSpeed)
         dragFrame.Position = startPos + UDim2.new(0, currentDelta.X, 0, currentDelta.Y)
      end
   end)

   Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

   local uiStroke = Instance.new("UIStroke")
   uiStroke.Thickness = 1.3
   uiStroke.Color = Color3.fromRGB(255, 255, 255)
   uiStroke.Parent = mainFrame

   local closeButton = Instance.new("TextButton")
   closeButton.Text = "X"
   closeButton.Font = Enum.Font.GothamBold
   closeButton.TextSize = 16
   closeButton.Size = UDim2.new(0, 30, 0, 30)
   closeButton.Position = UDim2.new(1, -35, 0, 5)
   closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
   closeButton.TextColor3 = Color3.fromRGB(196, 40, 28)
   closeButton.Parent = mainFrame

   Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)

   local scrollFrame = Instance.new("ScrollingFrame")
   scrollFrame.Size = UDim2.new(1, -20, 1, -70)
   scrollFrame.Position = UDim2.new(0, 10, 0, 40)
   scrollFrame.BackgroundTransparency = 1
   scrollFrame.ScrollBarThickness = 6
   scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
   scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
   scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
   scrollFrame.Parent = mainFrame

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 6)
   layout.SortOrder = Enum.SortOrder.LayoutOrder
   layout.Parent = scrollFrame

   local padding = Instance.new("UIPadding")
   padding.PaddingTop = UDim.new(0, 5)
   padding.PaddingLeft = UDim.new(0, 5)
   padding.PaddingRight = UDim.new(0, 5)
   padding.PaddingBottom = UDim.new(0, 5)
   padding.Parent = scrollFrame

   local currentPrefix = getgenv().AdminPrefix
   local channel = getgenv().TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")
   local cmdsString = [[
      {prefix}rgbcar - Enables RGB/Rainbow Vehicle (flashing Rainbow Vehicle).
      {prefix}unrgbcar - Disables RGB/Rainbow Vehicle (flashing Rainbow Vehicle).
      {prefix}feedback - Gives you a menu to be able to send me feedback/suggestions/rating for the script!
      {prefix}infyield - Executes Infinite Premium (my Infinite Yield).
      {prefix}spawnfire NUMBER - Spawns fire with a specified number argument.
      {prefix}rainbowcar Player - Makes a players car RGB (FRIENDS ONLY!, FE).
      {prefix}copyav Player (🔥POPULAR FEATURE🔥) - Copies the target players avatar/outfit in full (animations, body, everything! FE!).
      {prefix}norainbowcar Player - Disables the RGB for a players car (FRIENDS ONLY!, FE).
      {prefix}annoyergui - Enables the GUI that lets you pick and toggle annoy players (FE).
      {prefix}startsignspam - Spams the text on your Tool Sign (FE).
      {prefix}stopsignspam - Stops spamming the text on your Tool Sign.
      {prefix}orbit Player Speed Distance - Lets you Orbit around the target Player (FE).
      {prefix}unorbit - Stops orbiting the target Player.
      {prefix}speed Number - Changes your WalkSpeed.
      {prefix}jp Number - Changes your JumpHeight.
      {prefix}grav Number - Changes your Gravity.
      {prefix}orbitspeed NewSpeed - Lets you modify your Orbit speed.
      {prefix}antifitstealer (🔥 #1 FEATURE 🔥) - Allows you to toggle on Anti Outfit Copier (FE, I was forced to add it, I know!!!).
      {prefix}unanticopyfit - Disables Anti Outfit Copier (FE).
      {prefix}outfitsui (🔥POPULAR FEATURE🔥) - Allows you to save how ever many outfits you want with our new GUI.
      {prefix}anticarfling (🔥HOT🔥) - Enables 'anticarfling', preventing you from being flung by Vehicles.
      {prefix}unanticarfling - Disables 'anticarfling' command.
      {prefix}rainbowtime Player NUMBER - Sets your whitelisted friends rainbow car speed.
      {prefix}unadmin player - Removes the player's FE commands (if they're your friend).
      {prefix}admin player - Adds the player to the FE commands whitelist (if they're your friend).
      {prefix}startrgbskin - Enable RGB Skin (flashing Rainbow Skintone).
      {prefix}stoprgbskin - Disable RGB Skin (flashing Rainbow Skintone).
      {prefix}checkpremium player - Checks if a player has premium or not.
      {prefix}rgbphone (🔥HOT🔥) - Enable RGB Phone (flashing Rainbow Phone).
      {prefix}unrgbphone - Disable RGB Phone (flashing Rainbow Phone).
      {prefix}glitchoutfit - Enables the glitching of your outfit (very blinding).
      {prefix}startrgbtool - Enables RGB Tool (FE, Flashing Rainbow Tool).
      {prefix}stoprgbtool - Disables RGB Tool (FE, Flashing Rainbow Tool).
      {prefix}noglitchoutfit - Disables the glitching of your outfit.
      {prefix}flames - Spams fire all over you.
      {prefix}noflames - Disables the spamming of fire.
      {prefix}autonoflames - Deletes flames from your game automatically and completely, reducing lag.
      {prefix}unautohideflames - Disables the auto-hide flames lag reducer.
      {prefix}name NewName - Lets you change your RP name.
      {prefix}bio NewBio - Lets you change your RP bio.
      {prefix}freeemotes - Gives you the Free Emotes GUI.
      {prefix}allcars - Gives you the GUI list that shows all the car names.
      {prefix}noemote - Disables any emote you are currently doing.
      {prefix}griddy - Makes you do the Griddy emote (FE).
      {prefix}scenario - Makes you do the Scenario emote (FE).
      {prefix}superman - Makes you do the Superman emote (FE).
      {prefix}zen - Makes you do the Zen emote (FE).
      {prefix}orangej - Makes you do the Orange Justice emote (FE).
      {prefix}aurafarm - Makes you do an Aura Float emote (FE).
      {prefix}worm - Makes you do The Worm emote (FE).
      {prefix}jabba - Makes you do the Jabba emote (FE).
      {prefix}popular - Makes you do the Popular emote (FE).
      {prefix}defaultd - Makes you do the Default Dance emote (FE).
      {prefix}kotonai - Makes you do the Koto Nai emote (FE).
      {prefix}glitching - Makes you do the Glitching emote (FE).
      {prefix}billyjean - Makes you do the Billie Jean emote (FE).
      {prefix}billybounce - Makes you do the Billy Bounce emote (FE).
      {prefix}michaelmyers - Makes you do the Michael Myers emote (FE).
      {prefix}sturdy - Makes you do the New York Sturdy emote (FE).
      {prefix}eshuffle - Makes you do the Electro Shuffle emote (FE).
      {prefix}takethel - Makes you do the Take The L emote (FE).
      {prefix}laughitup - Makes you do the Donkey Laugh emote (FE).
      {prefix}reanimated - Makes you do the Reanimated emote (FE).
      {prefix}antivoid - Enables anti-void.
      {prefix}unantivoid - Disables anti-void.
      {prefix}alljobs - Repeatedly spams all jobs.
      {prefix}jobsoff - Stops spamming all jobs.
      {prefix}fly Speed - Enable/disable flying.
      {prefix}unfly - Disables (Fly) command.
      {prefix}annoy Player - Spam calls + spam request carries the target player (FE).
      {prefix}unannoy - Disables annoy player system.
      {prefix}fly2 Speed - Enables magic carpet fly (ONLY VISUAL rainbow!).
      {prefix}unfly2 - Disables Fly2/Magic carpet fly (with the client side rainbow).
      {prefix}noclip - Enables Noclip, letting you walk through everything.
      {prefix}clip - Disables Noclip, so you cannot walk through everything.
      {prefix}trailer - Gives you the WaterSkies trailer (on any car/vehicle).
      {prefix}notrailer - Removes the WaterSkies trailer (on your current spawned car/vehicle).
      {prefix}autolockcar - Automatically (loop) locks your vehicle/car when there is one spawned.
      {prefix}unautolockcar - Turn off/disables the loop that automatically locks your vehicle/car.
      {prefix}lockcar - Locks your car.
      {prefix}unlockcar - Unlocks your car.
      {prefix}despawn - Despawns your car.
      {prefix}blacklist Player - Blacklists friends you specify from using the admin commands (even if they are already on).
      {prefix}unblacklist Player - Removes the blacklist from the friend you specified in the 'blacklist' command, allowing them to do ;rgbcar and such again.
      {prefix}antifling - Fully prevents you from being flung, by other exploiters/cheaters, and fling outfits (FULL BYPASS).
      {prefix}unantifling - Disables anti-fling.
      {prefix}bringcar - Teleport car to you and sit in it.
      {prefix}flashname - Enables the flashing of your "Bio" and "Name" (above your head).
      {prefix}noflashname - Disables the flashing of your "Bio" and "Name" (above your head).
      {prefix}flashinvis - Enables the flashing of the invisibility GamePass for you're character (you need to actually own the GamePass).
      {prefix}noflashinvis - Disables the flashing of the invisibility GamePass for you're character (you need to actually own the GamePass).
      {prefix}nosit - Disables all VehicleSeats and Seats.
      {prefix}resit - Re-enables all Seats.
      {prefix}view Player - Smooth view's the target's Character.
      {prefix}unview - Disables the 'view' command.
      {prefix}void Player - Uses the SchoolBus Vehicle to void the target.
      {prefix}kill Player - Uses the SchoolBus Vehicle to kill the target.
      {prefix}bring Player - Uses the SchoolBus Vehicle to bring the target.
      {prefix}goto Player - Teleports your Character to the target player.
      {prefix}skydive Player - Uses the SchoolBus Vehicle to skydive the target.
      {prefix}freepay - Gives you LifePay Premium for free.
      {prefix}rejoin - Rejoins you, but does NOT execute the script automatically.
      {prefix}caraccel Number - Modifies your "max_acc" on your car/vehicle.
      {prefix}carspeed Number - Modifies your "max_speed" on your car/vehicle.
      {prefix}accel Number - Modifies your "acc_0_60" on your car/vehicle (take off time/speed).
      {prefix}turnangle Number - Modifies your "turn_angle" on your car/vehicle (how fast you turn).
      {prefix}gotocar - Teleports you straight to your car/vehicle directly.
      {prefix}tpcar Player - Teleports your vehicle/car to the specified target.
      {prefix}antihouseban - Prevents you from being banned/kicked/teleported out of houses.
      {prefix}unantiban - Turns off 'antihouseban' command.
      {prefix}spawn CarName - Allows you to spawn any Vehicle in the game (FE).
      {prefix}prefix NewPrefixHere - Changes your prefix.
      {prefix}inject - Secret (???).
   ]]

   cmdsString = string.gsub(cmdsString, "{prefix}", currentPrefix)

   for line in string.gmatch(cmdsString, "[^\r\n]+") do
      line = line:match("^%s*(.-)%s*$")
      if line ~= "" then
         local parts = string.split(line, " - ")
         local cmdText = parts[1] or line
         local desc = parts[2] or ""

         local frame = Instance.new("Frame")
         frame.Size = UDim2.new(1, -10, 0, 60)
         frame.BackgroundTransparency = 1
         frame.Parent = scrollFrame

         local label = Instance.new("TextLabel")
         label.AutomaticSize = Enum.AutomaticSize.Y
         label.Size = UDim2.new(1, -110, 0, 20)
         label.Position = UDim2.new(0, 0, 0, 0)
         label.BackgroundTransparency = 1
         label.Font = Enum.Font.GothamSemibold
         label.TextSize = 15
         label.TextColor3 = Color3.fromRGB(0, 0, 0)
         label.TextXAlignment = Enum.TextXAlignment.Left
         label.TextYAlignment = Enum.TextYAlignment.Top
         label.TextWrapped = true
         label.TextScaled = false
         label.RichText = true
         label.Text = cmdText
         label.Parent = frame

         local button = Instance.new("TextButton")
         button.Size = UDim2.new(0, 100, 0, 30)
         button.Position = UDim2.new(1, -100, 0, 15)
         button.Text = "Run"
         button.Font = Enum.Font.GothamBold
         button.TextSize = 14
         button.TextColor3 = Color3.new(1, 1, 1)
         button.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
         button.Parent = frame
         Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

         local commandToSend = cmdText
         local TweenService = getgenv().TweenService
         local UserInputService = getgenv().UserInputService

         local tooltipGui = Instance.new("ScreenGui")
         tooltipGui.Name = "AdminTooltipUI"
         tooltipGui.ResetOnSpawn = false
         tooltipGui.IgnoreGuiInset = true
         tooltipGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
         tooltipGui.DisplayOrder = 9999
         tooltipGui.Parent = CoreGui
         wait()
         local tooltip = Instance.new("TextLabel")
         tooltip.Name = "CommandTooltip"
         tooltip.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
         tooltip.TextColor3 = Color3.new(1, 1, 1)
         tooltip.Font = Enum.Font.GothamSemibold
         tooltip.TextSize = 14
         tooltip.TextWrapped = true
         tooltip.AutomaticSize = Enum.AutomaticSize.XY
         tooltip.BackgroundTransparency = 0.2
         tooltip.Visible = false
         tooltip.ZIndex = 10000
         tooltip.AnchorPoint = Vector2.new(0, 1)
         tooltip.Position = UDim2.new(0, 0, 0, 0)
         tooltip.Parent = tooltipGui

         local corner = Instance.new("UICorner", tooltip)
         corner.CornerRadius = UDim.new(0, 6)
         local padding = Instance.new("UIPadding", tooltip)
         padding.PaddingLeft = UDim.new(0, 6)
         tooltip.TextYAlignment = Enum.TextYAlignment.Top

         local mousePos = Vector2.new()
         getgenv().UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
               mousePos = Vector2.new(input.Position.X, input.Position.Y)
            end
         end)

         local runService = getgenv().RunService
         runService.RenderStepped:Connect(function()
            if tooltip.Visible then
               tooltip.Position = UDim2.fromOffset(mousePos.X + 15, mousePos.Y - 10)
            end
         end)

         local function showTooltip()
            tooltip.Text = desc
            tooltip.Visible = true
            TweenService:Create(tooltip, TweenInfo.new(0.15), {BackgroundTransparency = 0.15, TextTransparency = 0}):Play()
         end

         local function hideTooltip()
            TweenService:Create(tooltip, TweenInfo.new(0.15), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            task.delay(0.15, function()
               if tooltip.BackgroundTransparency >= 0.99 then
                  tooltip.Visible = false
               end
            end)
         end

         label.MouseEnter:Connect(showTooltip)
         label.MouseLeave:Connect(hideTooltip)
         button.MouseEnter:Connect(showTooltip)
         button.MouseLeave:Connect(hideTooltip)

         button.MouseButton1Click:Connect(function()
            if channel then
               channel:SendAsync(commandToSend)
            end
         end)
      end
   end

   closeButton.MouseButton1Click:Connect(function()
      cmdsUI:Destroy()
   end)

   task.spawn(function()
      local fixDelay = 1
      local runService = getgenv().RunService or game:GetService("RunService")
      local playerGui = getgenv().PlayerGui or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

      while task.wait(fixDelay) do
         local gui = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or playerGui
         local menu = gui:FindFirstChild("AdminCommandList_LifeTogether_RP", true)
         if not menu then continue end

         for _, label in ipairs(menu:GetDescendants()) do
            if label:IsA("TextLabel") and label.Text and label.Text ~= "" then
               local parent = label.Parent
               if label.TextScaled or label.Size.Y.Scale > 0 or label.Size.Y.Offset <= 5 then
                  label.TextScaled = false
                  label.TextSize = 15
                  label.AutomaticSize = Enum.AutomaticSize.Y
                  label.Size = UDim2.new(1, -110, 0, 20)
                  label.TextWrapped = true
                  label.RichText = true
                  label.TextColor3 = Color3.fromRGB(0, 0, 0)
                  if parent and parent:IsA("Frame") then
                     parent.AutomaticSize = Enum.AutomaticSize.Y
                  end
               end
               if label.TextTransparency >= 0.9 then
                  label.TextTransparency = 0
               end
            end
         end
      end
   end)
end
wait(0.1)
function CreateCreditsLabel()
   if getgenv().CreditsLabelGui then
      getgenv().CreditsLabelGui:Destroy()
   end

   local creditsGui = Instance.new("ScreenGui")
   creditsGui.Name = "PrefixCreditsGui_LifeTogether"
   creditsGui.ResetOnSpawn = false
   creditsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   creditsGui.Parent = Gui_Parent_Default() or CoreGui

   local label = Instance.new("TextLabel")
   label.Name = "CreditsLabel"
   label.AnchorPoint = Vector2.new(0.5, 1)
   label.Position = UDim2.new(0.5, 0, 1, -10)
   label.Size = UDim2.new(0.6, 0, 0, 28)
   label.BackgroundColor3 = Color3.fromRGB(249, 214, 46)
   label.TextColor3 = Color3.fromRGB(0, 0, 0)
   local prefix = decodeHTMLEntities(tostring(getgenv().AdminPrefix))
   label.Text = tostring(Script_Version).." | Made By: "..tostring(Script_Creator).." on Discord. | Current Prefix: " .. prefix
   label.Font = Enum.Font.GothamBold
   label.TextScaled = true
   label.RichText = false
   label.TextStrokeTransparency = 1
   label.BackgroundTransparency = 0
   label.ZIndex = 10
   label.Parent = creditsGui

   local corner = Instance.new("UICorner")
   corner.CornerRadius = UDim.new(0, 10)
   corner.Parent = label

   getgenv().CreditsLabelGui = creditsGui
   getgenv().CreditsLabelText = label

   if getgenv()._PrefixUpdateConnection then
      getgenv()._PrefixUpdateConnection:Disconnect()
   end

   if typeof(getgenv().AdminPrefix) == "Instance" and getgenv().AdminPrefix:IsA("StringValue") then
      getgenv()._PrefixUpdateConnection = getgenv().AdminPrefix.Changed:Connect(function()
         lastPrefix = tostring(getgenv().AdminPrefix)
         local prefix = decodeHTMLEntities(tostring(getgenv().AdminPrefix))
         label.Text = tostring(Script_Version).." | Made By: "..tostring(Script_Creator).." on Discord. | Current Prefix: " .. prefix
      end)
   else
      task.spawn(function()
         local lastPrefix = tostring(getgenv().AdminPrefix)
         while label and label.Parent do
            task.wait(0.3)
            if tostring(getgenv().AdminPrefix) ~= lastPrefix then
               lastPrefix = tostring(getgenv().AdminPrefix)
               local prefix = decodeHTMLEntities(tostring(getgenv().AdminPrefix))
               label.Text = tostring(Script_Version).." | Made By: "..tostring(Script_Creator).." on Discord. | Current Prefix: " .. prefix
            end
         end
      end)
   end
end
wait(0.2)
CreateCreditsLabel()

local Players = getgenv().Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = getgenv().RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
getgenv().AntiFling_Tracked = getgenv().AntiFling_Tracked or setmetatable({}, { __mode = "k" })
getgenv().AntiFling_Signals = getgenv().AntiFling_Signals or setmetatable({}, { __mode = "k" })
getgenv().AntiFling_Enabled = false
getgenv().AntiFling_SteppedConnection = getgenv().AntiFling_SteppedConnection or nil
getgenv().AntiFling_PlayerAddedConn = getgenv().AntiFling_PlayerAddedConn or nil
getgenv().AntiFling_PlayerRemovingConn = getgenv().AntiFling_PlayerRemovingConn or nil
local tracked = getgenv().AntiFling_Tracked
local signals = getgenv().AntiFling_Signals

getgenv().AntiFling_SafeSetCanCollide = function(part, value)
   if typeof(part) == "Instance" and part:IsA("BasePart") then
      pcall(function()
         if part.CanCollide ~= value then
            part.CanCollide = value
         end
      end)
   end
end

getgenv().AntiFling_Apply = function(part)
   if not (part and part:IsA("BasePart")) or tracked[part] then return end
   tracked[part] = true
   getgenv().AntiFling_SafeSetCanCollide(part, false)

   signals[part] = part:GetPropertyChangedSignal("CanCollide"):Connect(function()
      if part and part.Parent and part.CanCollide ~= false then
         getgenv().AntiFling_SafeSetCanCollide(part, false)
      end
   end)
end

getgenv().AntiFling_ProtectCharacter = function(char)
   if not char then return end

   for _, inst in ipairs(char:GetDescendants()) do
      if inst:IsA("BasePart") then
         getgenv().AntiFling_Apply(inst)
      end
   end

   char.DescendantAdded:Connect(function(inst)
      if inst:IsA("BasePart") then
         getgenv().AntiFling_Apply(inst)
      end
   end)

   char.DescendantRemoving:Connect(function(inst)
      if tracked[inst] then
         if signals[inst] then
            signals[inst]:Disconnect()
            signals[inst] = nil
         end
         tracked[inst] = nil
      end
   end)
end

getgenv().AntiFling_HookPlayer = function(plr)
   if plr == LocalPlayer then return end
   if plr.Character then
      getgenv().AntiFling_ProtectCharacter(plr.Character)
   end
   plr.CharacterAdded:Connect(getgenv().AntiFling_ProtectCharacter)
end

getgenv().EnableAntiFling = function()
   if getgenv().AntiFling_Enabled then
      return getgenv().notify("Error", "Anti Fling is already enabled!", 5)
   end
   getgenv().AntiFling_Enabled = true

   for _, plr in ipairs(Players:GetPlayers()) do
      getgenv().AntiFling_HookPlayer(plr)
   end

   getgenv().AntiFling_PlayerAddedConn = Players.PlayerAdded:Connect(getgenv().AntiFling_HookPlayer)
   getgenv().AntiFling_PlayerRemovingConn = Players.PlayerRemoving:Connect(function(plr)
      if plr == LocalPlayer then return end
      local char = plr.Character
      if not char then return end

      for _, part in ipairs(char:GetDescendants()) do
         if tracked[part] then
            if signals[part] then
               signals[part]:Disconnect()
               signals[part] = nil
            end
            tracked[part] = nil
         end
      end
   end)

   getgenv().AntiFling_SteppedConnection = RunService.Stepped:Connect(function()
      for part in pairs(tracked) do
         if typeof(part) == "Instance" and part:IsA("BasePart") and part.Parent then
            if part.CanCollide ~= false then
               getgenv().AntiFling_SafeSetCanCollide(part, false)
            end
         end
      end
   end)

   if getgenv().notify then
      getgenv().notify("Anti-Fling", "Anti Fling Enabled!", 4)
   end
end

getgenv().DisableAntiFling = function()
   if not getgenv().AntiFling_Enabled then
      return getgenv().notify("Error", "Anti Fling is not enabled!", 5)
   end
   getgenv().AntiFling_Enabled = false

   if getgenv().AntiFling_SteppedConnection then
      getgenv().AntiFling_SteppedConnection:Disconnect()
      getgenv().AntiFling_SteppedConnection = nil
   end
   if getgenv().AntiFling_PlayerAddedConn then
      getgenv().AntiFling_PlayerAddedConn:Disconnect()
      getgenv().AntiFling_PlayerAddedConn = nil
   end
   if getgenv().AntiFling_PlayerRemovingConn then
      getgenv().AntiFling_PlayerRemovingConn:Disconnect()
      getgenv().AntiFling_PlayerRemovingConn = nil
   end

   for part, conn in pairs(signals) do
      if conn.Disconnect then
         pcall(conn.Disconnect, conn)
      end
   end

   table.clear(signals)
   table.clear(tracked)

   if getgenv().notify then
      getgenv().notify("Anti-Fling", "Anti Fling Disabled!", 4)
   end
end

getgenv().Toggle_AntiFling_Boolean_Func = function(toggled)
   if toggled == true then
      getgenv().EnableAntiFling()
   elseif toggled == false then
      getgenv().DisableAntiFling()
   else
      return getgenv().notify("Warning", "[Invalid arguments]: Expected true/false brocaroni and cheese.", 5)
   end
end

function change_RP_Name(New_Name)
   send_remote("roleplay_name", tostring(New_Name))
end

function change_bio(New_Bio)
   send_remote("bio", tostring(New_Bio))
end

local DefaultSpeed = getgenv().StarterPlayer.CharacterWalkSpeed
local DefaultJP = getgenv().StarterPlayer.CharacterJumpHeight
local Old_Workspace_Gravity = getgenv().Workspace.Gravity
wait(0.1)
function change_property(property, new_property_value)
   local properties_allowed_to_be_changed = {
      WalkSpeed = true,
      JumpHeight = true,
      HipHeight = true
   }

   if properties_allowed_to_be_changed[property] and getgenv().Humanoid then
      getgenv().Humanoid[property] = new_property_value
   end
end

function change_gravity_val(new_val)
   if new_val > 300 then
      new_val = 196
   end

   getgenv().Workspace.Gravity = tonumber(new_val) or 196
end

function reset_properties()
   if not getgenv().Humanoid then return end

   getgenv().Humanoid.WalkSpeed = DefaultSpeed or 16
   getgenv().Humanoid.JumpHeight = DefaultJP or 7
   getgenv().Workspace.Gravity = Old_Workspace_Gravity or 196
end

local function rainbow_car()
   RGB_Vehicle(true)
end

local function stop_rainbow_car()
   RGB_Vehicle(false)
end

local function rainbow_others_car(Player)
   RGB_Vehicle_Others(Player, true)
end

local function stop_rainbow_others_car(Player)
   RGB_Vehicle_Others(Player, false)
end

getgenv().VehicleDestroyer_Enabled = getgenv().VehicleDestroyer_Enabled or false
getgenv().VehicleDestroyer_Connections = getgenv().VehicleDestroyer_Connections or {}

local function clearConnections()
	for _, conn in ipairs(getgenv().VehicleDestroyer_Connections) do
		if typeof(conn) == "RBXScriptConnection" then
			pcall(function() conn:Disconnect() end)
		end
	end
	table.clear(getgenv().VehicleDestroyer_Connections)
	getgenv().folderAddedConn = nil
	getgenv().vehiclesChildAddedConn = nil
	getgenv().vehiclesHeartBeatConnection = nil
end

local function disableCollisionIn(folder)
	for _, obj in ipairs(folder:GetDescendants()) do
		if obj:IsA("BasePart") and obj.CanCollide then
			obj.CanCollide = false
		end
	end
end

local function setupFolder(folder)
	disableCollisionIn(folder)

   getgenv().notify("Success", "Anti Vehicle Fling has been enabled.", 5)
	getgenv().vehiclesChildAddedConn = folder.ChildAdded:Connect(function(child)
		if not getgenv().VehicleDestroyer_Enabled then return end

		if child:IsA("BasePart") then
			child.CanCollide = false
		elseif child:IsA("Model") then
			child.DescendantAdded:Connect(function(desc)
				if desc:IsA("BasePart") then
					desc.CanCollide = false
				end
			end)
			disableCollisionIn(child)
		end
	end)
	table.insert(getgenv().VehicleDestroyer_Connections, getgenv().vehiclesChildAddedConn)
end

getgenv().DisableVehicleDestroyer = function()
   if not getgenv().VehicleDestroyer_Enabled then
      return getgenv().notify("Warning", "Anti Vehicle Fling is not enabled!", 5)
   end
   wait(0.1)
	getgenv().VehicleDestroyer_Enabled = false
	clearConnections()
end

function anti_car_fling(toggle)
	if toggle == true then
      if getgenv().VehicleDestroyer_Enabled then
         return getgenv().notify("Warning", "Anti Vehicle Fling is already enabled!", 5)
      end
      wait(0.1)
		getgenv().VehicleDestroyer_Enabled = true
		clearConnections()

		local vehiclesFolder = getgenv().Workspace:FindFirstChild("Vehicles") or getgenv().Workspace:WaitForChild("Vehicles", 5)
		if vehiclesFolder then
			setupFolder(vehiclesFolder)
		end

		getgenv().folderAddedConn = getgenv().Workspace.ChildAdded:Connect(function(child)
			if child.Name == "Vehicles" and child:IsA("Folder") then
				setupFolder(child)
				vehiclesFolder = child
			end
		end)
		table.insert(getgenv().VehicleDestroyer_Connections, getgenv().folderAddedConn)

		getgenv().vehiclesHeartBeatConnection = getgenv().RunService.Heartbeat:Connect(function()
			if not getgenv().VehicleDestroyer_Enabled then return end
			if vehiclesFolder and vehiclesFolder.Parent then
				disableCollisionIn(vehiclesFolder)
			else
				vehiclesFolder = getgenv().Workspace:FindFirstChild("Vehicles")
			end
		end)
		table.insert(getgenv().VehicleDestroyer_Connections, getgenv().vehiclesHeartBeatConnection)
	elseif toggle == false then
		getgenv().DisableVehicleDestroyer()
      getgenv().notify("Success", "Anti Vehicle Fling has been disabled.", 5)
   else
      return 
	end
end

function Enable_Fly_2(speed)
   local speed = tonumber(speed) or 75
   if getgenv().Enabled_Flying then
      return getgenv().notify("Warning", "Fly-2 is already enabled!", 5)
   end

   local g = getgenv()
   getgenv().Enabled_Flying = true

   local RainbowColors = {
      Color3.fromRGB(255,0,0),
      Color3.fromRGB(255,128,0),
      Color3.fromRGB(255,255,0),
      Color3.fromRGB(0,255,0),
      Color3.fromRGB(0,255,255),
      Color3.fromRGB(0,0,255),
      Color3.fromRGB(128,0,255)
   }

   local HRP = g.HumanoidRootPart
   local RunService = g.RunService
   local Player = getgenv().LocalPlayer
   local Character = getgenv().Character
   local Humanoid = getgenv().Humanoid
   local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
   local Debris = cloneref and cloneref(game:GetService("Debris")) or game:GetService("Debris")

   local fly_gyro = Instance.new("BodyGyro")
   fly_gyro.P = 10000
   fly_gyro.MaxTorque = Vector3.new(1,1,1)*1e7
   fly_gyro.CFrame = HRP.CFrame
   fly_gyro.Parent = HRP

   local fly_velocity = Instance.new("BodyVelocity")
   fly_velocity.MaxForce = Vector3.new(1,1,1)*1e7
   fly_velocity.P = 1000
   fly_velocity.Velocity = Vector3.new()
   fly_velocity.Parent = HRP

   local fly_hold = Instance.new("BodyPosition")
   fly_hold.MaxForce = Vector3.new(0,0,0)
   fly_hold.P = 100000
   fly_hold.Position = HRP.Position
   fly_hold.Parent = HRP

   local fly_vertical = 0
   local fly_last_pos = nil
   getgenv().Humanoid.PlatformStand = true

   g.fly2_input_began = UserInputService.InputBegan:Connect(function(input, gpe)
      if gpe then return end
      if input.KeyCode == Enum.KeyCode.Space then fly_vertical = 1 end
      if input.KeyCode == Enum.KeyCode.LeftShift then fly_vertical = -1 end
   end)

   g.fly2_input_ended = UserInputService.InputEnded:Connect(function(input)
      if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then
         fly_vertical = 0
      end
   end)

   g.fly2_heartbeat = RunService.Heartbeat:Connect(function()
      if not g.Enabled_Flying or not HRP or not HRP.Parent then return end

      local camCF = getgenv().Workspace.CurrentCamera.CFrame
      local moveDir = Humanoid.MoveDirection
      local move = Vector3.new(moveDir.X, 0, moveDir.Z)
      local flyY = fly_vertical
      local dir = camCF:VectorToWorldSpace(move)
      local finalDir = (dir + Vector3.new(0, flyY, 0))

      if finalDir.Magnitude > 0 then
         fly_velocity.Velocity = finalDir.Unit * speed
         fly_hold.MaxForce = Vector3.new(0,0,0)
      else
         fly_velocity.Velocity = Vector3.new()
         fly_hold.MaxForce = Vector3.new(1,1,1)*1e7
         fly_hold.Position = HRP.Position
      end

      local _, yaw, _ = camCF:ToOrientation()
      fly_gyro.CFrame = CFrame.new(HRP.Position) * CFrame.Angles(0, yaw, 0)

      local pos = HRP.Position
      if not fly_last_pos or (pos - fly_last_pos).Magnitude > 1 then
         local part = Instance.new("Part")
         part.Anchored = true
         part.CanCollide = false
         part.Material = Enum.Material.Neon
         part.Size = Vector3.new(1,1,(pos - (fly_last_pos or pos)).Magnitude + 2)
         part.CFrame = CFrame.new((fly_last_pos or pos) + ((pos - (fly_last_pos or pos)) / 2), pos)
         part.Color = RainbowColors[math.random(1, #RainbowColors)]
         part.Parent = workspace
         Debris:AddItem(part, 1)
         fly_last_pos = pos
      end
   end)
end

function Disable_Flying()
   local g = getgenv()
   if not g.Enabled_Flying then return getgenv().notify("Error", "Fly-2 is not currently enabled.", 5) end
   g.Enabled_Flying = false
   if g.fly2_heartbeat then g.fly2_heartbeat:Disconnect() g.fly2_heartbeat = nil end
   if g.fly2_input_began then g.fly2_input_began:Disconnect() g.fly2_input_began = nil end
   if g.fly2_input_ended then g.fly2_input_ended:Disconnect() g.fly2_input_ended = nil end
   if getgenv().HumanoidRootPart:FindFirstChild("BodyGyro") then
      getgenv().HumanoidRootPart:FindFirstChild("BodyGyro"):Destroy()
   end
   if getgenv().HumanoidRootPart:FindFirstChild("BodyVelocity") then
      getgenv().HumanoidRootPart:FindFirstChild("BodyVelocity"):Destroy()
   end
   if getgenv().HumanoidRootPart:FindFirstChild("BodyPosition") then
      getgenv().HumanoidRootPart:FindFirstChild("BodyPosition"):Destroy()
   end

   local HRP = g.HumanoidRootPart
   if HRP then HRP.Velocity = Vector3.new() end

   local Player = getgenv().LocalPlayer
   local Character = getgenv().Character
   if Character then
      getgenv().Humanoid.PlatformStand = false
   end
end

function check_premium_player(plr)
   if plr then
      if plr:GetAttribute("is_verified") == true then
         return true
      else
         return false
      end
   end
end

function is_tool_colorable(tool)
   if tool:IsA("Tool") and (tool:GetAttribute("color1") or tool:GetAttribute("Color1")) then
      return true
   else
      return false
   end
end

local function find_backpack_tool()
   for _, v in ipairs(getgenv().Backpack:GetChildren()) do
      if v:IsA("Tool") and (v:GetAttribute("color1") or v:GetAttribute("Color1")) then
         return v
      end
   end

   return nil
end

local function find_character_tool()
   for _, v in ipairs(getgenv().Character:GetChildren()) do
      if v:IsA("Tool") and (v:GetAttribute("color1") or v:GetAttribute("Color1")) then
         return v
      end
   end

   return nil
end

local function find_placed_models_tool()
   for _, v in ipairs(getgenv().Workspace:FindFirstChild("PlacedModels"):GetChildren()) do
      if v:IsA("Tool") and (v:GetAttribute("color1") or v:GetAttribute("Color1")) then
         if v:GetAttribute("owner_id") == getgenv().LocalPlayer.UserId then
            return v
         end
      end
   end

   return nil
end

function rainbow_tool(toggled)
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

   if toggled then
      local tool = find_character_tool() or find_backpack_tool() or find_placed_models_tool()

      if not tool then
         getgenv().Send("get_tool", "Gift")
         getgenv().notify("Warning", "Wait!: We're giving you a colorable Tool...", 5)
         task.wait(0.2)
         tool = find_character_tool() or find_backpack_tool() or find_placed_models_tool()

         if not tool then
            return getgenv().notify("Error", "Tool still not found after giving you the Gift Tool.", 5)
         end

         if tool.Parent == getgenv().Backpack then
            task.wait(0.1)
            tool.Parent = getgenv().Character
         end

         for _, color in ipairs(colors) do
            getgenv().Send("tool_color", tool, "color1", color)
            task.wait()
         end
         return
      end

      if tool.Parent == getgenv().Backpack then
         task.wait(0.1)
         tool.Parent = getgenv().Character
      end

      getgenv().Rainbow_Tools_FE = true
      while getgenv().Rainbow_Tools_FE do
         tool = find_character_tool() or find_backpack_tool() or find_placed_models_tool()
         if not tool then
            getgenv().Rainbow_Tools_FE = false
            return getgenv().notify("Error", "Tool unexpectedly disappeared or was destroyed.", 5)
         end
         if tool.Parent == getgenv().Backpack then
            task.wait(0.1)
            tool.Parent = getgenv().Character
         end
         for _, color in ipairs(colors) do
            if not getgenv().Rainbow_Tools_FE then break end
            getgenv().Send("tool_color", tool, "color1", color)
            task.wait()
         end
      end
   else
      getgenv().Rainbow_Tools_FE = false
   end
end

function toggle_name_func(boolean)
   if boolean == true then
      getgenv().Send("hide_name", true)
   elseif boolean == false then
      getgenv().Send("hide_name", false)
   else
      return notify("Error", "Invalid arguments provided.", 5)
   end
end

wait(0.2)
function flashy_name(Toggle)
   if Toggle == true then
      getgenv().Flashing_Name_Title = true
      while getgenv().Flashing_Name_Title == true do
      wait()
         toggle_name_func(true)
         wait(0.1)
         toggle_name_func(false)
         wait(.1)
      end
   elseif Toggle == false then
      getgenv().Flashing_Name_Title = false
      wait(1.5)
      toggle_name_func(false)
   else
      return notify("Error", "Invalid argument(s) provided.", 5)
   end
end

function infinite_premium()
   if getgenv().GET_LOADED_IY then
      return getgenv().notify("Error", "Infinite Premium has already been loaded.", 5)
   end

   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/refs/heads/main/InfYieldOther.lua'))()
end

function lock_vehicle(Vehicle)
   getgenv().Get("lock_vehicle", Vehicle)
end
wait(0.1)
if getgenv().HasSeen_Loading_Screen then
   print("Already seen loading screen.")
else
   local Blur_Module = require(getgenv().Core:FindFirstChild("Blur"))

   Blur_Module.tween(24, 10)
   wait(0.1)
   local Blur_Effect = getgenv().Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect")
   Blur_Effect.Enabled = true
   wait(0.1)
   local Blur_Module = require(getgenv().Core:FindFirstChild("Blur"))

   Blur_Module.tween(21, 10)
   wait(2.5)

   local gui = Instance.new("ScreenGui")
   gui.Name = getgenv().randomString()
   gui.ResetOnSpawn = false
   gui.IgnoreGuiInset = true
   gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   gui.Parent = getgenv().CoreGui

   local textLabel = Instance.new("TextLabel")
   textLabel.Parent = gui
   textLabel.BackgroundTransparency = 1
   textLabel.Size = UDim2.new(0.45, 0.5, 0.45, 0.10)
   textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
   textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   textLabel.Text = "Welcome to:\n\nFlames Hub | Life Together Admin "..tostring(Raw_Version).."!\n\nEnjoy!!!\nENJOY BEING UNSTOPPABLE!"
   if getgenv().Lighting.ClockTime <= 5 then
      textLabel.TextColor3 = Color3.fromRGB(3, 3, 3)
   elseif getgenv().Lighting.ClockTime >= 9 then
      textLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
   elseif getgenv().Lighting.ClockTime >= 20 then
      textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
   end
   textLabel.Font = Enum.Font.GothamBlack
   textLabel.TextScaled = true
   textLabel.TextTransparency = 1
   textLabel.RichText = false

   local aspect = Instance.new("UIAspectRatioConstraint")
   aspect.AspectRatio = 4.8
   aspect.Parent = textLabel

   local TweenService = getgenv().TweenService
   TweenService:Create(textLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {
      TextTransparency = 0
   }):Play()

   local RunService = getgenv().RunService
   local originalSize = textLabel.Size
   local amplitude = UDim2.new(0.015, 0, 0.0075, 0)
   local frequency = 2

   local function scaleUDim2(udim2, scalar)
      return UDim2.new(
         udim2.X.Scale * scalar,
         udim2.X.Offset * scalar,
         udim2.Y.Scale * scalar,
         udim2.Y.Offset * scalar
      )
   end

   local running = true

   local function updateSize(val)
      textLabel.Size = originalSize + scaleUDim2(amplitude, val)
   end

   local pulseIn = TweenService:Create(textLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
      Size = originalSize + amplitude
   })
   local pulseOut = TweenService:Create(textLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
      Size = originalSize
   })

   task.spawn(function()
      local endTime = tick() + 5
      while tick() < endTime do
         pulseIn:Play()
         pulseIn.Completed:Wait()
         pulseOut:Play()
         pulseOut.Completed:Wait()
      end

      textLabel.Size = originalSize

      TweenService:Create(textLabel, TweenInfo.new(0.5), {
         TextTransparency = 1
      }):Play()

      wait(1.5)
      Blur_Module.tween(0, 5)
      wait(3)
      gui:Destroy()
   end)
   wait(0.2)
   getgenv().HasSeen_Loading_Screen = true
end
wait()
getgenv().player_admins = getgenv().player_admins or {}
getgenv().friend_checked = getgenv().friend_checked or {}
getgenv().cmds_loaded_plr = getgenv().cmds_loaded_plr or {}
getgenv().Rainbow_Vehicles = getgenv().Rainbow_Vehicles or {}
getgenv().Locked_Vehicles = getgenv().Locked_Vehicles or {}
getgenv().Unlocked_Vehicles = getgenv().Unlocked_Vehicles or {}
getgenv().Rainbow_Tasks = getgenv().Rainbow_Tasks or {}
local g = getgenv()
g.Rainbow_Delays         = g.Rainbow_Delays         or {}
g.Rainbow_Indices        = g.Rainbow_Indices        or {}
g.Rainbow_Next           = g.Rainbow_Next           or {}
g.Rainbow_CachedVehicle  = g.Rainbow_CachedVehicle  or {}
g.Rainbow_ActiveCount    = g.Rainbow_ActiveCount    or 0
g.Rainbow_MIN_DELAY      = g.Rainbow_MIN_DELAY      or 0.04
g.Rainbow_Colors = g.Rainbow_Colors or {
   Color3.fromRGB(255,255,255), Color3.fromRGB(128,128,128), Color3.fromRGB(0,0,0),
   Color3.fromRGB(0,0,255),     Color3.fromRGB(0,255,0),     Color3.fromRGB(0,255,255),
   Color3.fromRGB(255,165,0),   Color3.fromRGB(139,69,19),   Color3.fromRGB(255,255,0),
   Color3.fromRGB(50,205,50),   Color3.fromRGB(255,0,0),     Color3.fromRGB(255,155,172),
   Color3.fromRGB(128,0,128),
}
wait(0.2)
local function alreadyCheckedUser(player)
   if not getgenv().friend_checked[player.Name] then
      getgenv().player_admins[player.Name] = player
   end
   if not getgenv().friend_checked[player.Name] then
      getgenv().friend_checked[player.Name] = player
   end
   if not getgenv().cmds_loaded_plr[player.Name] then
      getgenv().cmds_loaded_plr[player.Name] = player
   end
end

local function enable_rgb_for(plr)
   local v = get_other_vehicle(plr)
   if not v then
      getgenv().VehicleStates[plr.Name].rainbow = false
      return false, "you don't have a vehicle"
   end

   if getgenv().VehicleStates[plr.Name].rainbow == true then
      return 
   end

   getgenv().VehicleStates[plr.Name].rainbow = true
   getgenv().Rainbow_Indices[plr.Name] = 0
   local state = getgenv().VehicleStates[plr.Name]

   getgenv().Rainbow_Tasks[plr.Name] = task.spawn(function()
      while state.rainbow do
         local vehicle = get_other_vehicle(plr)
         if not vehicle then
            getgenv().VehicleStates[plr.Name].rainbow = false
            break
         end

         local i = (state.rainbowIndex or 0) + 1
         state.rainbowIndex = i
         local color = g.Rainbow_Colors[(i % #g.Rainbow_Colors) + 1]
         change_vehicle_color(color, vehicle)
         task.wait(0.2)
      end
   end)
end

local function disable_rgb_for(plr)
   if not plr then return getgenv().notify("Error", "Player was not found when trying to disable RGB vehicle!", 5) end
   if not getgenv().VehicleStates[plr.Name] then return end
   if not getgenv().Rainbow_Tasks[plr.Name] then return end

   if getgenv().VehicleStates[plr.Name].rainbow == true then
      getgenv().notify("Success", "Disabling Vehicle states for: "..tostring(plr.Name), 3)
      getgenv().VehicleStates[plr.Name].rainbow = false
   end

   if getgenv().VehicleStates[plr.Name] then
      getgenv().VehicleStates[plr.Name].rainbow = false
   end

   if getgenv().Rainbow_Tasks[plr.Name] then
      task.cancel(getgenv().Rainbow_Tasks[plr.Name])
   end

   if getgenv().Rainbow_Tasks[plr.Name] then
      getgenv().notify("Success", "Disabling Rainbow Task for: "..tostring(plr.Name), 3)
      getgenv().Rainbow_Tasks[plr.Name] = nil
   end
   if getgenv().Rainbow_Indices[plr.Name] then
      getgenv().notify("Success", "Disabling Rainbow Indice for: "..tostring(plr.Name), 3)
      getgenv().Rainbow_Indices[plr.Name] = nil
   end
end
wait(0.1)
getgenv().fully_disable_rgb_plr = disable_rgb_for

local function set_rgb_delay(name, newDelay)
   if type(newDelay) ~= "number" then return false, "invalid time value" end
   if newDelay < g.Rainbow_MIN_DELAY then newDelay = g.Rainbow_MIN_DELAY end
   g.Rainbow_Delays[name] = newDelay
   g.Rainbow_Next[name] = 0
   return true
end

if not getgenv().VehicleStates then
   getgenv().VehicleStates = {}
end

if not getgenv().PreRequisites_Loaded then
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Zacks_Easy_Hub/refs/heads/main/other_actors.lua'))()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Zacks_Easy_Hub/refs/heads/main/TextChatServce.lua'))()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Zacks_Easy_Hub/refs/heads/main/error_handler.lua'))()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Zacks_Easy_Hub/refs/heads/main/feedback_handler.lua'))()
   wait(0.2)
   getgenv().PreRequisites_Loaded = true
else
   getgenv().notify("Warning", "Pre-Requisites and requirements already loaded.", 5)
end
wait(0.1)
local function setup_cmd_handler_plr(player)
   local TextChatService = getgenv().TextChatService
   local prefix = ";"
   local localPlayerName = getgenv().LocalPlayer.Name
   local channel = TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")

   local function trim(str)
      return str:match("^%s*(.-)%s*$")
   end

   local function levenshtein(s, t)
      local d = {}
      local len_s, len_t = #s, #t
      for i = 0, len_s do d[i] = {[0] = i} end
      for j = 0, len_t do d[0][j] = j end

      for i = 1, len_s do
         for j = 1, len_t do
            local cost = (s:sub(i,i) == t:sub(j,j)) and 0 or 1
            d[i][j] = math.min(
               d[i-1][j] + 1,
               d[i][j-1] + 1,
               d[i-1][j-1] + cost
            )
         end
      end
      return d[len_s][len_t]
   end

   local function chat_reply(speakerName, msg)
      local channel = TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")
      
      channel:SendAsync("/w " .. speakerName .. " " .. msg .. " (this message was automatically sent)")
   end

   TextChatService.MessageReceived:Connect(function(chatMessage)
      local speaker = chatMessage.TextSource
      if not (speaker and speaker.Name ~= localPlayerName and getgenv().player_admins[speaker.Name]) then return end

      local normalizedMessage = trim(chatMessage.Text:lower())
      if normalizedMessage:sub(1, #prefix) ~= prefix then return end

      local command = normalizedMessage:sub(#prefix + 1)
      local playerVehicle = get_other_vehicle(getgenv().Players[speaker.Name])

      if not getgenv().Players[speaker.Name]:IsFriendsWith(getgenv().LocalPlayer.UserId) then return end
      wait(0.2)
      local Name = speaker and speaker.Name

      getgenv().VehicleStates[Name] = getgenv().VehicleStates[Name] or {
         locked = false,
         unlocked = false,
         rainbow = false,
      }

      if levenshtein(command, "rgbcar") <= 2 then
         local Player = getgenv().Players[speaker.Name]
         if not Player then
            return getgenv().notify("Error", "This player does not exist!", 5)
         end

         local vehicle = get_other_vehicle(Player)
         if not vehicle then
            getgenv().Rainbow_Vehicles[Player.Name] = nil
            return getgenv().notify("Error", "The player doesn't have a car spawned!", 5)
         end

         enable_rgb_for(Player)
      elseif levenshtein(command:split(" ")[1], "rgbtime") <= 2 then
         local parts = command:split(" ")
         local delayStr = parts[2]
         local newDelay = tonumber(delayStr)

         if not newDelay then
            return 
         end

         if newDelay < 0.1 then
            newDelay = 0.1
         end

         local name = getgenv().Players[speaker.Name].Name
         g.Rainbow_Delays[name] = newDelay
         g.Rainbow_Next[name] = time()
      elseif levenshtein(command, "norgbcar") <= 2 then
         disable_rgb_for(getgenv().Players[speaker.Name])
      elseif levenshtein(command, "lockcar") <= 2 then
         if not playerVehicle then
            getgenv().LockLoop_Vehicles[speaker.Name] = false
            return 
         end

         if getgenv().Locked_Vehicles[speaker.Name] then
            return 
         end

         getgenv().Unlocked_Vehicles[speaker.Name] = false
         wait(0.1)
         getgenv().Locked_Vehicles[speaker.Name] = true

         local player = getgenv().Players[speaker.Name]
         if not player then
            getgenv().Locked_Vehicles[speaker.Name] = false
         end

         local v = get_other_vehicle(player)

         if v and not v:GetAttribute("locked") then
            getgenv().Get("lock_vehicle", v)
         elseif not v then
            getgenv().Locked_Vehicles[speaker.Name] = false
         end
      elseif levenshtein(command, "unlockcar") <= 2 then
         if not playerVehicle then
            getgenv().Unlocked_Vehicles[speaker.Name] = false
            return 
         end

         if getgenv().Unlocked_Vehicles[speaker.Name] then
            return 
         end

         getgenv().Locked_Vehicles[speaker.Name] = false
         wait(0.1)
         getgenv().Unlocked_Vehicles[speaker.Name] = true

         local player = getgenv().Players[speaker.Name]
         if not player then
            getgenv().Unlocked_Vehicles[speaker.Name] = false
         end

         local v = get_other_vehicle(player)
         if v and v:GetAttribute("locked") then
            getgenv().Get("lock_vehicle", v)
         elseif not v then
            getgenv().Unlocked_Vehicles[speaker.Name] = false
         end
      elseif levenshtein(command, "trailer") <= 2 then
         local player = getgenv().Players[speaker.Name]

         if not playerVehicle then
            getgenv().Unlocked_Vehicles[speaker.Name] = false
            return 
         end

         local Vehicle = get_other_vehicle(player)

         if not Vehicle then
            return 
         end

         if Vehicle:FindFirstChild("WaterSkies") then
            return 
         end
         wait(0.1)
         water_skie_trailer(true, Vehicle)
      elseif levenshtein(command, "notrailer") <= 2 then
         local player = getgenv().Players[speaker.Name]

         if not playerVehicle then
            getgenv().Unlocked_Vehicles[speaker.Name] = false
            return 
         end

         local Vehicle = get_other_vehicle(player)

         if not Vehicle then
            return 
         end

         if not Vehicle:FindFirstChild("WaterSkies") then
            return 
         end

         water_skie_trailer(false, Vehicle)
      elseif command:sub(1, 5) == "check" then
         if getgenv().Check_Cooldown then return end

         getgenv().Check_Cooldown = true
         task.delay(15, function()
            getgenv().Check_Cooldown = false
         end)

         local args = command:split(" ")
         local checkTargetName = args[2]
         if not checkTargetName or #checkTargetName <= 0 then
            return warn("Target player invalid: "..tostring(checkTargetName))
         end

         local target = findplr(checkTargetName)
         if not target then
            return warn("Could not find: "..tostring(target))
         end

         local isVerified = target:GetAttribute("is_verified")
         local generalChannel = getgenv().TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")
         if generalChannel then
            if isVerified == true then
               generalChannel:SendAsync("Player: " .. target.DisplayName .. " has premium.")
            else
               generalChannel:SendAsync("Player: " .. target.DisplayName .. " does not have premium.")
            end
         end
      elseif levenshtein(command, "cmds") <= 2 then
         if getgenv().Is_OnCooldown then return end

         getgenv().Is_OnCooldown = true
         getgenv().Wait_Time_Cooldown = 30

         getgenv().TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral"):SendAsync(
            ";lockcar | ;rgbcar | ;norgbcar | ;unlockcar | ;check Player | ;trailer | ;notrailer | ;rgbtime NUMBER"
         )

         task.delay(getgenv().Wait_Time_Cooldown, function()
            getgenv().Is_OnCooldown = false
         end)
      end
   end)
end

local function addPlayerToScriptWhitelistTable(player)
   if not getgenv().player_admins[player.Name] then
      getgenv().player_admins[player.Name] = player
      wait(0.3)
      if getgenv().player_admins[player.Name] then
         getgenv().notify("Success", tostring(player.Name)..", was added to Admins Whitelist.", 5)
      end
   end
end
wait(0.2)
local function removePlayerFromScriptWhitelistTable(player)
   if getgenv().player_admins[player.Name] then
      getgenv().player_admins[player.Name] = nil
      wait(0.2)
      if getgenv().player_admins[player.Name] == nil then
         getgenv().notify("Success", tostring(player.Name).." was removed from the Admins Whitelist!", 5)
      else
         return getgenv().notify("Error", tostring(player)..", does not exist.", 5)
      end
   end
end

local Original_Age = getgenv().LocalPlayer:GetAttribute("age")
task.wait(0.1)

function copy_plr_avatar(Player)
   local Players = getgenv().Players
   if getgenv().is_copying_avatar_already_flames then
      return getgenv().notify("Warning", "Avatar copier is already in progress, please wait!", 6)
   end
   getgenv().is_copying_avatar_already_flames = true

   local function clearAvatar()
      local Humanoid = getgenv().Humanoid or (getgenv().Character and getgenv().Character:FindFirstChildOfClass("Humanoid"))
      if not Humanoid then
         getgenv().notify("Error", "Humanoid not found, cannot clear avatar.", 5)
         return false
      end

      local desc = Humanoid:GetAppliedDescription()
      if not desc then
         getgenv().notify("Error", "Could not get applied HumanoidDescription.", 5)
         return false
      end

      local assets = {}
      for _, acc in ipairs(desc:GetAccessories(true)) do
         if acc.AssetId and acc.AssetId > 0 then
            table.insert(assets, {id = acc.AssetId, type = acc.AccessoryType.Name .. "Accessory"})
         end
      end
      if desc.Shirt > 0 then table.insert(assets, {id = desc.Shirt, type = "Shirt"}) end
      if desc.Pants > 0 then table.insert(assets, {id = desc.Pants, type = "Pants"}) end
      if desc.GraphicTShirt > 0 then table.insert(assets, {id = desc.GraphicTShirt, type = "TShirt"}) end
      if desc.Face > 0 then table.insert(assets, {id = desc.Face, type = "Face"}) end

      local bodyParts = {"Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}
      for _, part in ipairs(bodyParts) do
         if desc[part] and desc[part] > 0 then
            table.insert(assets, {id = desc[part], type = part})
         end
      end

      getgenv().notify("Info", "Clearing avatar (" .. #assets .. " assets)...", 3)
      for _, data in ipairs(assets) do
         pcall(function() getgenv().Get("wear", data.id, data.type) end)
         task.wait(0.2)
      end

      local retries = 0
      while retries < 5 do
         task.wait(0.5)
         local check = Humanoid:GetAppliedDescription():GetAccessories(true)
         if #check == 0 then
            getgenv().notify("Success", "Avatar fully cleared.", 3)
            return true
         end
         for _, acc in ipairs(check) do
            pcall(function()
               getgenv().Get("wear", acc.AssetId, acc.AccessoryType.Name .. "Accessory")
            end)
            task.wait(0.1)
         end
         retries += 1
      end

      getgenv().notify("Warning", "Avatar clear may be incomplete after retries.", 4)
      return true
   end

   local function getAvatarAssets(player)
      if not player.Character then return {}, nil, nil, nil, nil, nil end
      local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
      if not humanoid then return {}, nil, nil, nil, nil, nil end
      local desc = humanoid:GetAppliedDescription()

      local assets = {}
      for _, acc in ipairs(desc:GetAccessories(true)) do
         if acc.AssetId and acc.AssetId > 0 then
            table.insert(assets, {id = acc.AssetId, type = acc.AccessoryType.Name .. "Accessory"})
         end
      end
      if desc.Shirt > 0 then table.insert(assets, {id = desc.Shirt, type = "Shirt"}) end
      if desc.Pants > 0 then table.insert(assets, {id = desc.Pants, type = "Pants"}) end
      if desc.GraphicTShirt > 0 then table.insert(assets, {id = desc.GraphicTShirt, type = "TShirt"}) end
      if desc.Face > 0 then table.insert(assets, {id = desc.Face, type = "Face"}) end

      local bodyParts = {"Head", "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg"}
      for _, part in ipairs(bodyParts) do
         if desc[part] and desc[part] > 0 then
            table.insert(assets, {id = desc[part], type = part})
         end
      end

      local anims = {"Fall", "Walk", "Run", "Jump", "Idle", "Climb", "Swim"}
      local animData = {}
      for _, anim in ipairs(anims) do
         local id = desc[anim.."Animation"]
         if id and id > 0 then
            table.insert(animData, {id = id, type = anim.."Animation"})
         end
      end

      local skinTone = desc.HeadColor or Color3.new(1,1,1)
      local height = desc.HeightScale or 1
      local width = desc.WidthScale or 1
      local age = player:GetAttribute("age")

      return assets, skinTone, height, width, animData, age
   end

   local function wearAssets(tbl)
      for _, data in ipairs(tbl) do
         pcall(function()
            getgenv().Get("wear", data.id, data.type)
         end)
         task.wait(0.25)
      end
   end

   local function copyAvatar(target)
      if not target or not target.Character then
         getgenv().notify("Warning", "Target not found or no character.", 4)
         return
      end

      local Text = "ANTI COPIER ENABLED HERE - THANKS!"
      local current_bio = target:GetAttribute("bio")

      if current_bio == Text then
         return getgenv().notify("Warning", "This player has anti outfit stealer on, sorry!", 5)
      end
      wait()
      if not clearAvatar() then
         getgenv().is_copying_avatar_already_flames = false
         return getgenv().notify("Warning", "Something unexpected happened when trying to clear your Avatar.", 6)
      end

      task.wait(0.5)

      local targetAssets, skinTone, height, width, animData, age = getAvatarAssets(target)
      if not targetAssets or #targetAssets == 0 then
         getgenv().notify("Warning", "Target currently has 0 wearable assets, stopping early.", 5)
         getgenv().is_copying_avatar_already_flames = false
         return 
      end

      getgenv().notify("Info", "Copying avatar from: "..target.Name.."...", 5)
      wearAssets(targetAssets)

      if skinTone then
         pcall(function()
            getgenv().Send("skin_tone", skinTone)
         end)
      end

      if age then
         pcall(function()
            getgenv().Get("age", tostring(age))
         end)
         task.wait(0.3)
      end

      if height then
         pcall(function()
            getgenv().Send("body_scale", "HeightScale", height * 100)
         end)
      end
      if width then
         pcall(function()
            getgenv().Send("body_scale", "WidthScale", width * 100)
         end)
      end

      if animData and #animData > 0 then
         for _, anim in ipairs(animData) do
            pcall(function()
               getgenv().Get("wear", anim.id, anim.type)
            end)
            task.wait(0.2)
         end
      end

      if age then
         pcall(function()
            getgenv().Get("age", tostring(age))
         end)
         task.wait(0.2)
      end

      getgenv().notify("Success", "Copied full avatar from: " .. target.Name, 5)
   end

   pcall(copyAvatar, Player)
   getgenv().is_copying_avatar_already_flames = false
end

function annoyance_GUI()
   local Players = getgenv().Players
   local LocalPlayer = getgenv().LocalPlayer
   local CoreGui = getgenv().CoreGui
   local UserInputService = getgenv().UserInputService

   if CoreGui:FindFirstChild("AnnoyGUI") then
      CoreGui.AnnoyGUI:Destroy()
   end

   getgenv().AnnoyList = {}
   getgenv().group_chatting_users = {}
   getgenv().Creating_Groups = false

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "AnnoyGUI"
   ScreenGui.Parent = CoreGui
   ScreenGui.ResetOnSpawn = false

   local Frame = Instance.new("Frame")
   Frame.Size = UDim2.new(0, 300, 0, 400)
   Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
   Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
   Frame.BorderSizePixel = 0
   Frame.Parent = ScreenGui
   Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

   local TitleBar = Instance.new("Frame")
   TitleBar.Size = UDim2.new(1, 0, 0, 35)
   TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
   TitleBar.BorderSizePixel = 0
   TitleBar.Parent = Frame
   Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -35, 1, 0)
   Title.Position = UDim2.new(0, 10, 0, 0)
   Title.Text = "Annoy / Group Spam Menu | Made By: "..tostring(Script_Creator).." on Discord."
   Title.TextColor3 = Color3.fromRGB(255, 255, 255)
   Title.BackgroundTransparency = 1
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Font = Enum.Font.GothamBold
   Title.TextScaled = true
   Title.TextSize = 14
   Title.Parent = TitleBar

   local CloseBtn = Instance.new("TextButton")
   CloseBtn.Size = UDim2.new(0, 25, 0, 25)
   CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
   CloseBtn.Text = "X"
   CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
   CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
   CloseBtn.Font = Enum.Font.GothamBold
   CloseBtn.TextScaled = true
   CloseBtn.TextSize = 14
   CloseBtn.Parent = TitleBar
   Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

   CloseBtn.MouseButton1Click:Connect(function()
      ScreenGui:Destroy()
      getgenv().easy_click_plr = false
      getgenv().Creating_Groups = false
   end)

   local dragging, dragStart, startPos
   TitleBar.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         dragging = true
         dragStart = input.Position
         startPos = Frame.Position
      end
   end)
   TitleBar.InputEnded:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         dragging = false
      end
   end)
   UserInputService.InputChanged:Connect(function(input)
      if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
         local delta = input.Position - dragStart
         Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
         )
      end
   end)

   local PlayerList = Instance.new("ScrollingFrame")
   PlayerList.Size = UDim2.new(1, -10, 1, -45)
   PlayerList.Position = UDim2.new(0, 5, 0, 40)
   PlayerList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
   PlayerList.BorderSizePixel = 0
   PlayerList.ScrollBarThickness = 6
   PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
   PlayerList.Parent = Frame
   Instance.new("UICorner", PlayerList).CornerRadius = UDim.new(0, 10)

   local UIListLayout = Instance.new("UIListLayout")
   UIListLayout.Parent = PlayerList
   UIListLayout.Padding = UDim.new(0, 5)

   local function ToggleAnnoy(plr, btn)
      if getgenv().easy_click_plr and getgenv().easy_click_target == plr.Name then
         getgenv().easy_click_plr = false
         btn.Text = "Annoy Off"
         btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
      else
         getgenv().easy_click_target = plr.Name
         getgenv().easy_click_plr = true
         btn.Text = "Annoy On"
         btn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
         task.spawn(function()
            while getgenv().easy_click_plr and getgenv().easy_click_target == plr.Name do
               task.wait(0)
               getgenv().Send("request_carry", plr.Name)
               task.wait(0)
               getgenv().Send("request_call", plr.Name)
               task.wait(0)
               getgenv().Send("end_call", plr.Name)
            end
         end)
      end
   end

   local function ToggleGroupSpam(plr, btn)
      if table.find(getgenv().group_chatting_users, plr.Name) then
         table.remove(getgenv().group_chatting_users, table.find(getgenv().group_chatting_users, plr.Name))
         btn.Text = "Group Spam Off"
         btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
         if #getgenv().group_chatting_users == 0 then
            getgenv().Creating_Groups = false
         end
      else
         table.insert(getgenv().group_chatting_users, plr.Name)
         btn.Text = "Group Spam On"
         btn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
         getgenv().Creating_Groups = true

         task.spawn(function()
            while getgenv().Creating_Groups == true do
               task.wait(.4)
               local userIds = {}

               for _, name in ipairs(getgenv().group_chatting_users) do
                  local success, userId = pcall(function()
                     return Players:GetUserIdFromNameAsync(name)
                  end)
                  if success and userId then
                     table.insert(userIds, userId)
                  end
               end

               if #userIds == 1 then
                  local others = {}
                  for _, other in ipairs(Players:GetPlayers()) do
                     if other.Name ~= getgenv().group_chatting_users[1] and other ~= LocalPlayer then
                        table.insert(others, other)
                     end
                  end

                  for i = #others, 2, -1 do
                     local j = math.random(i)
                     others[i], others[j] = others[j], others[i]
                  end

                  for i = 1, math.min(3, #others) do
                     table.insert(userIds, others[i].UserId)
                  end
               end

               if #userIds > 0 then
                  getgenv().Get("new_group", userIds)
               end
            end
         end)
      end
   end

   local function createPlayerEntry(plr)
      if plr == LocalPlayer then return end

      local Container = Instance.new("Frame")
      Container.Size = UDim2.new(1, -5, 0, 110)
      Container.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
      Container.BorderSizePixel = 0
      Container.Parent = PlayerList
      Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

      local NameLabel = Instance.new("TextLabel")
      NameLabel.Size = UDim2.new(1, -10, 0, 20)
      NameLabel.Position = UDim2.new(0, 5, 0, 5)
      NameLabel.Text = "DisplayName: " .. plr.DisplayName
      NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
      NameLabel.BackgroundTransparency = 1
      NameLabel.TextXAlignment = Enum.TextXAlignment.Left
      NameLabel.Font = Enum.Font.Gotham
      NameLabel.TextSize = 13
      NameLabel.Parent = Container

      local UserLabel = Instance.new("TextLabel")
      UserLabel.Size = UDim2.new(1, -10, 0, 20)
      UserLabel.Position = UDim2.new(0, 5, 0, 25)
      UserLabel.Text = "Username: " .. plr.Name
      UserLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
      UserLabel.BackgroundTransparency = 1
      UserLabel.TextXAlignment = Enum.TextXAlignment.Left
      UserLabel.Font = Enum.Font.Gotham
      UserLabel.TextSize = 12
      UserLabel.Parent = Container

      local IdLabel = Instance.new("TextLabel")
      IdLabel.Size = UDim2.new(1, -10, 0, 20)
      IdLabel.Position = UDim2.new(0, 5, 0, 45)
      IdLabel.Text = "UserId: " .. tostring(plr.UserId)
      IdLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
      IdLabel.BackgroundTransparency = 1
      IdLabel.TextXAlignment = Enum.TextXAlignment.Left
      IdLabel.Font = Enum.Font.Gotham
      IdLabel.TextSize = 12
      IdLabel.Parent = Container

      local AnnoyButton = Instance.new("TextButton")
      AnnoyButton.Size = UDim2.new(0, 110, 0, 20)
      AnnoyButton.Position = UDim2.new(0, 10, 0, 70)
      AnnoyButton.Text = "Annoy Off"
      AnnoyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
      AnnoyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      AnnoyButton.Font = Enum.Font.GothamBold
      AnnoyButton.TextScaled = true
      AnnoyButton.TextSize = 13
      AnnoyButton.Parent = Container
      Instance.new("UICorner", AnnoyButton).CornerRadius = UDim.new(0, 6)

      AnnoyButton.MouseButton1Click:Connect(function()
         ToggleAnnoy(plr, AnnoyButton)
      end)

      local GroupButton = Instance.new("TextButton")
      GroupButton.Size = UDim2.new(0, 110, 0, 20)
      GroupButton.Position = UDim2.new(0, 140, 0, 70)
      GroupButton.Text = "Group Spam Off"
      GroupButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
      GroupButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      GroupButton.Font = Enum.Font.GothamBold
      GroupButton.TextScaled = true
      GroupButton.TextSize = 13
      GroupButton.Parent = Container
      Instance.new("UICorner", GroupButton).CornerRadius = UDim.new(0, 6)

      GroupButton.MouseButton1Click:Connect(function()
         ToggleGroupSpam(plr, GroupButton)
      end)

      PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
   end

   local function refreshPlayerList()
      for _, child in ipairs(PlayerList:GetChildren()) do
         if child:IsA("Frame") then
            child:Destroy()
         end
      end
      for _, plr in ipairs(Players:GetPlayers()) do
         createPlayerEntry(plr)
      end
   end

   Players.PlayerAdded:Connect(refreshPlayerList)
   Players.PlayerRemoving:Connect(refreshPlayerList)

   refreshPlayerList()
end

local Hum = getgenv().Humanoid
local HD = Hum:FindFirstChild("HumanoidDescription")
local GlitchIDs = {
   Shirts = {6028801590, 11595159513},
   Pants  = {6028804735, 11595172734}
}

local function isWearing(desc, slot, id)
   return desc and tostring(desc[slot]) == tostring(id)
end

local function forceEquip(slot, id)
   if not isWearing(HD, slot, id) then
      getgenv().Get("code", id, slot)
   end
end

local function forceUnequip(slot, id)
   if isWearing(HD, slot, id) then
      getgenv().Get("wear", id, slot)
   end
end

function feedback_GUI()
   if getgenv().FeedbackCooldown then
      return getgenv().notify("Warning", "You must wait before sending a Feedback request again! (" .. (getgenv().FeedbackTimeLeft or 0) .. "s left)", 5)
   end
   if getgenv().CoreGui:FindFirstChild("FeedbackUI") then
      return getgenv().notify("Error", "Feedback GUI is already loaded, close it first!", 5)
   end

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "FeedbackUI"
   ScreenGui.ResetOnSpawn = false
   ScreenGui.Parent = getgenv().CoreGui

   local Frame = Instance.new("Frame")
   Frame.Size = UDim2.new(0, 350, 0, 200)
   Frame.Position = UDim2.new(0.5, -175, 0.5, -100)
   Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
   Frame.BorderSizePixel = 0
   Frame.Active = true
   Frame.Draggable = true
   Frame.Parent = ScreenGui

   local UICorner = Instance.new("UICorner")
   UICorner.CornerRadius = UDim.new(0, 12)
   UICorner.Parent = Frame

   local UIStroke = Instance.new("UIStroke")
   UIStroke.Thickness = 2
   UIStroke.Color = Color3.fromRGB(90, 90, 90)
   UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
   UIStroke.Parent = Frame

   local Title = Instance.new("TextLabel")
   Title.Size = UDim2.new(1, -40, 0, 40)
   Title.Position = UDim2.new(0, 10, 0, 0)
   Title.BackgroundTransparency = 1
   Title.Text = "Submit Feedback"
   Title.TextColor3 = Color3.fromRGB(255, 255, 255)
   Title.Font = Enum.Font.GothamBold
   Title.TextSize = 20
   Title.TextXAlignment = Enum.TextXAlignment.Left
   Title.Parent = Frame

   local CloseBtn = Instance.new("TextButton")
   CloseBtn.Size = UDim2.new(0, 30, 0, 30)
   CloseBtn.Position = UDim2.new(1, -35, 0, 5)
   CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
   CloseBtn.Text = "X"
   CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
   CloseBtn.Font = Enum.Font.GothamBold
   CloseBtn.TextSize = 18
   CloseBtn.Parent = Frame

   local CloseCorner = Instance.new("UICorner")
   CloseCorner.CornerRadius = UDim.new(0, 6)
   CloseCorner.Parent = CloseBtn

   CloseBtn.MouseButton1Click:Connect(function()
      ScreenGui:Destroy()
   end)

   local TextBox = Instance.new("TextBox")
   TextBox.Size = UDim2.new(1, -20, 0, 100)
   TextBox.Position = UDim2.new(0, 10, 0, 50)
   TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
   TextBox.Text = ""
   TextBox.PlaceholderText = "Type your feedback here..."
   TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
   TextBox.Font = Enum.Font.Gotham
   TextBox.TextSize = 16
   TextBox.ClearTextOnFocus = false
   TextBox.TextWrapped = true
   TextBox.MultiLine = true
   TextBox.Parent = Frame

   local TBcorner = Instance.new("UICorner")
   TBcorner.CornerRadius = UDim.new(0, 8)
   TBcorner.Parent = TextBox

   local SendBtn = Instance.new("TextButton")
   SendBtn.Size = UDim2.new(0.5, -15, 0, 40)
   SendBtn.Position = UDim2.new(0.5, -((0.5 * 350)/2), 1, -45)
   SendBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 250)
   SendBtn.Text = "Send Feedback"
   SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
   SendBtn.Font = Enum.Font.GothamBold
   SendBtn.TextSize = 18
   SendBtn.TextScaled = true
   SendBtn.Parent = Frame

   local CooldownLabel = Instance.new("TextLabel")
   CooldownLabel.Size = UDim2.new(1, 0, 0, 20)
   CooldownLabel.Position = UDim2.new(0, 0, 1, -20)
   CooldownLabel.BackgroundTransparency = 1
   CooldownLabel.Text = ""
   CooldownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
   CooldownLabel.Font = Enum.Font.Gotham
   CooldownLabel.TextSize = 14
   CooldownLabel.TextScaled = true
   CooldownLabel.Parent = Frame

   local SendCorner = Instance.new("UICorner")
   SendCorner.CornerRadius = UDim.new(0, 8)
   SendCorner.Parent = SendBtn

   SendBtn.MouseButton1Click:Connect(function()
      local msg = TextBox.Text
      if msg == "" or msg:match("^%s*$") then
         SendBtn.Text = "Enter feedback text!"
         task.wait(1)
         SendBtn.Text = "Send Feedback"
         return 
      end

      pcall(function()
         getgenv().Feedback_API.Feedback_Handler(getgenv().LocalPlayer, msg)
      end)

      getgenv().FeedbackCooldown = true
      getgenv().FeedbackTimeLeft = 60

      task.spawn(function()
         while getgenv().FeedbackTimeLeft > 0 do
            CooldownLabel.Text = "Cooldown: " .. tostring(getgenv().FeedbackTimeLeft) .. "s"
            task.wait(1)
            getgenv().FeedbackTimeLeft -= 1
         end

         CooldownLabel.Text = ""
      end)

      task.delay(60, function()
         getgenv().FeedbackCooldown = false
      end)

      ScreenGui:Destroy()
   end)
end

local Old_Shirt = getgenv().Humanoid:FindFirstChild("HumanoidDescription").Shirt
local Old_Pants = getgenv().Humanoid:FindFirstChild("HumanoidDescription").Pants
wait(0.1)
function glitch_outfit(toggle)
   if toggle == true then
      getgenv().Glitching_Outfit = true
      while getgenv().Glitching_Outfit == true do
         task.wait()
         for _, shirtId in ipairs(GlitchIDs.Shirts) do
            forceEquip("Shirt", shirtId)
            task.wait()
            forceUnequip("Shirt", shirtId)
         end
         wait(0.1)
         for _, pantsId in ipairs(GlitchIDs.Pants) do
            forceEquip("Pants", pantsId)
            task.wait()
            forceUnequip("Pants", pantsId)
         end
      end
   else
      getgenv().Glitching_Outfit = false
      wait(1)
      repeat task.wait() until getgenv().Glitching_Outfit == false
      if getgenv().Glitching_Outfit == false then
         getgenv().Send("code", Old_Shirt, "Shirt")
         wait(0)
         getgenv().Send("code", Old_Pants, "Pants")
      end
   end
end
wait()
function check_friends()
   for _, v in ipairs(getgenv().Players:GetPlayers()) do
      if v ~= getgenv().LocalPlayer and v:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         alreadyCheckedUser(v)
      end
   end
end
wait(0.1)
function auto_add_friends()
   for _, v in ipairs(getgenv().Players:GetPlayers()) do
      if v ~= getgenv().LocalPlayer and v:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         check_friends()
         addPlayerToScriptWhitelistTable(v)
      end
   end
end
wait(0.1)
auto_add_friends()

local originalCFrame
local originalCameraType
if getgenv().PlayerControls == nil then
   local PlayerModule = require(getgenv().PlayerScripts:WaitForChild("PlayerModule"))
   getgenv().PlayerControls = PlayerModule:GetControls()
end
wait(0.1)
getgenv().Viewing_Plr_Tbl = getgenv().Viewing_Plr_Tbl or {}
wait(0.1)
getgenv().viewTarget = function(Player)
   if getgenv().Viewing_A_Player then
      if getgenv().Viewing_Plr_Tbl[Player.Name] then
         return getgenv().notify("Error", "You're already viewing: " .. tostring(getgenv().Viewing_Plr_Tbl[Player.Name]), 5)
      else
         return getgenv().notify("Error", "You're already viewing a Player.", 5)
      end
   end

   if Player.Character and Player.Character:FindFirstChild("Humanoid") then
      local Target_Char = Player.Character or Player.CharacterAdded:Wait()

      getgenv().Camera.CameraSubject = Target_Char:FindFirstChildWhichIsA("Humanoid") or Target_Char:WaitForChild("Humanoid", 3)
      wait(0.1)
      getgenv().Viewing_A_Player = true
      wait()
      getgenv().Viewing_Plr_Tbl[Player.Name] = {
         Name = Player.Name,
         DisplayName = Player.DisplayName,
         UserId = Player.UserId,
         Character = Target_Char,
         Humanoid = Target_Char:FindFirstChildWhichIsA("Humanoid") or Target_Char:WaitForChild("Humanoid", 3),
         HumanoidRootPart = Target_Char:FindFirstChild("HumanoidRootPart") or Target_Char:WaitForChild("HumanoidRootPart", 3)
      }
   end
end
wait(0.1)
getgenv().unview_player = function()
   if not getgenv().Viewing_A_Player then
      return getgenv().notify("Error", "You're not viewing anyone.", 5)
   end

   if getgenv().Humanoid or getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
      getgenv().Camera.CameraSubject = getgenv().Humanoid
   else
      getgenv().Camera.CameraSubject = getgenv().Character
   end

   local viewedName
   for name, data in pairs(getgenv().Viewing_Plr_Tbl) do
      viewedName = data.DisplayName or name
      break
   end

   getgenv().Viewing_A_Player = false
   getgenv().Viewing_Plr_Tbl = {}
   getgenv().notify("Success", "Stopped viewing: " .. tostring(viewedName), 5)
end
wait(0.1)
getgenv().notify("Success", "[CAMERA-HOOK]: Initialized spectating functionality successfully.", 5)

local function check_friend(Player)
   if Player ~= getgenv().LocalPlayer and Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
      return true
   else
      return false
   end

   return 
end

function spam_create_groups(toggle)
   if toggle == true then
      local Players = getgenv().Players
      getgenv().group_chatting_users = getgenv().group_chatting_users or {}
      getgenv().Creating_Groups = true

      while getgenv().Creating_Groups do
         task.wait()
         for _, name in ipairs(getgenv().group_chatting_users) do
            local success, userId = pcall(function()
               return Players:GetUserIdFromNameAsync(name)
            end)
            
            if success and userId then
               getgenv().Get("new_group", userId)
            end
         end
      end
   elseif toggle == false then
      getgenv().Creating_Groups = false
   else
      return 
   end
end

function attach_with_script()
   local Methods = {
      "Secret",
      "Sneaky",
      "Private",
      "Normal",
      "Bypass",
      "External",
      "Internal",
      "Rage",
      "Silent",
      "Source",
      "MainClass",
      "Class_C",
      "Performance",
      "Non-Closure",
      "Encoded",
      "Bytecode",
      "Obfuscated"
   }
   wait(0.2)
   local Attached = false
   getgenv().Script_Was_Attached_Successfully = Attached
   local Old_Text = getgenv().CreditsLabelText.Text
   wait(0.5)
   for i = 1, 3 do
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Starting]: Attaching."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Starting]: Attaching.."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Starting]: Attaching..."
   end
   wait(0.2)
   Attached = true
   wait(0.2)
   if Attached == true then
      getgenv().CreditsLabelText.Text = "[Starting]: Getting requirements."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Starting]: Getting requirements.."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Starting]: Getting requirements..."
      wait(0.5)
      getgenv().CreditsLabelText.Text = "[Success]: Got requirements successfully!"
      wait(0.6)
      for i = 1, 3 do
         wait(0.6)
         getgenv().CreditsLabelText.Text = "[Initializing]: Collecting prerequisites."
         wait(0.6)
         getgenv().CreditsLabelText.Text = "[Initializing]: Collecting prerequisites.."
         wait(0.6)
         getgenv().CreditsLabelText.Text = "[Initializing]: Collecting prerequisites..."
      end
   end
   wait(0.5)
   for i = 1, 8 do
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Finalizing]: Collecting prerequisites."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Finalizing]: Collecting prerequisites.."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Finalizing]: Collecting prerequisites..."
   end
   wait(0.4)
   for i = 1, 4 do
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Finishing]: Selecting method."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Finishing]: Selecting method.."
      wait(0.6)
      getgenv().CreditsLabelText.Text = "[Finishing]: Selecting method..."
   end
   wait(0.5)
   local function ChooseMethod()
      return Methods[math.random(1, #Methods)]
   end
   wait()
   getgenv().CreditsLabelText.Text = "[Finished]: Method: "..tostring(ChooseMethod())
   wait(0.7)
   getgenv().CreditsLabelText.Text = "Attached."
   wait(0.8)
   getgenv().CreditsLabelText.Text = Old_Text
end
wait(0.1)
local PlotAreas = {}
wait(0.1)
function update_plot_areas()
   for _, v in ipairs(getgenv().Workspace:GetDescendants()) do
      if v:IsA("BasePart") and v.Name == "PlotArea" then
         table.insert(PlotAreas, v)
      end
   end
end
wait()
savePrefix(getgenv().AdminPrefix)
wait()
update_plot_areas()
local AutoLockOn = false
local AutoLockConnection = nil
local Workspace = getgenv().Workspace
local TweenService = getgenv().TweenService
local CoreGui = getgenv().CoreGui
local RunService = getgenv().RunService
local UserInputService = getgenv().UserInputService

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TemporaryBanner_GUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Name = "BannerFrame"
frame.AnchorPoint = Vector2.new(0.5, 0)
frame.Position = UDim2.new(0.5, 0, 0, 20)
frame.Size = UDim2.new(0.6, 0, 0, 48)
frame.BackgroundTransparency = 0
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 1.5
stroke.Transparency = 0.25

local label = Instance.new("TextLabel")
label.Name = "BannerText"
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.new(0.5, 0, 0.5, 0)
label.Size = UDim2.new(0.95, 0, 0.9, 0)
label.BackgroundTransparency = 1
label.Text = tostring(Announcement_Message)
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.RichText = false
label.TextWrapped = true
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.Parent = frame

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0)
shadow.Position = UDim2.new(0.5, 0, 0, 24)
shadow.Size = UDim2.new(0.62, 0, 0, 56)
shadow.Image = "rbxassetid://5059716102"
shadow.BackgroundTransparency = 1
shadow.ImageTransparency = 0.8
shadow.ZIndex = frame.ZIndex - 1
shadow.Parent = screenGui
shadow.Visible = false

local function clamp(n, lo, hi)
   if n < lo then return lo end
   if n > hi then return hi end
   return n
end

local function updatePosition()
   local cam = Workspace.CurrentCamera
   if not cam then return end
   local vw, vh = cam.ViewportSize.X, cam.ViewportSize.Y
   local widthScale = clamp(0.6, 0.4, 0.8)

   local heightPx = clamp(math.floor(vh * 0.07), 36, 72)

   frame.Size = UDim2.new(widthScale, 0, 0, heightPx)

   local topOffset = math.max(12, math.floor(vh * 0.03))
   frame.Position = UDim2.new(0.5, 0, 0, topOffset)
   shadow.Position = UDim2.new(0.5, 0, 0, topOffset + math.floor(heightPx/2))
   shadow.Size = UDim2.new(widthScale + 0.02, 0, 0, heightPx + 12)
end

updatePosition()

local renderConn
local camConn

if RunService and RunService.RenderStepped then
   renderConn = RunService.RenderStepped:Connect(function() end)
end

local cam = Workspace.CurrentCamera
if cam then
   camConn = cam:GetPropertyChangedSignal("ViewportSize"):Connect(updatePosition)
end

frame.BackgroundTransparency = 1
label.TextTransparency = 1
shadow.ImageTransparency = 1

local appearInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenService:Create(frame, appearInfo, {BackgroundTransparency = 0}):Play()
TweenService:Create(label, appearInfo, {TextTransparency = 0}):Play()
shadow.Visible = false
TweenService:Create(shadow, appearInfo, {ImageTransparency = 0.8}):Play()

local displayTime = displayTimeMax
delay(displayTime, function()
   local fadeInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
   local t1 = TweenService:Create(frame, fadeInfo, {BackgroundTransparency = 1})
   local t2 = TweenService:Create(label, fadeInfo, {TextTransparency = 1})
   local t3 = TweenService:Create(shadow, fadeInfo, {ImageTransparency = 1})

   t1:Play(); t2:Play(); t3:Play()
   t1.Completed:Wait()

   pcall(function()
      if renderConn and renderConn.Disconnect then renderConn:Disconnect() end
      if camConn and camConn.Disconnect then camConn:Disconnect() end
      screenGui:Destroy()
   end)
end)

pcall(function()
   getgenv().LocalPlayer:SetSuperSafeChat(false)
   getgenv().LocalPlayer.CameraMaxZoomDistance = 100000
   getgenv().LocalPlayer.CameraMinZoomDistance = 0.5
   wait()
   if getgenv().LocalPlayer.CameraMaxZoomDistance > 90000 then
      getgenv().notify("Success", "Set CameraMaxZoomDistance to: "..tostring(getgenv().LocalPlayer.CameraMaxZoomDistance), 7)
   else
      getgenv().notify("Warning", "We we're not able to correctly set CameraMaxZoomDistance!", 5)
   end
   if getgenv().LocalPlayer.CameraMinZoomDistance < 5 then
      getgenv().notify("Success", "Set CameraMinZoomDistance to: "..tostring(getgenv().LocalPlayer.CameraMinZoomDistance), 7)
   else
      getgenv().notify("Warning", "We we're not able to correctly set CameraMinZoomDistance!", 5)
   end
   wait(0.1)
   if getgenv().StarterPlayer.CharacterUseJumpPower then
      getgenv().Humanoid.JumpPower = 50
      getgenv().notify("Success", "Spoofed JumpPower to: "..tostring(getgenv().Humanoid.JumpPower))
   else
      getgenv().Humanoid.JumpHeight = 7
      getgenv().notify("Success", "Spoofed JumpHeight to: "..tostring(getgenv().Humanoid.JumpHeight))
   end
   getgenv().StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
   if getgenv().LocalPlayer.Name == "L0CKED_1N1" or getgenv().LocalPlayer.Name == "CHEATING_B0SS" then
      getgenv().StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
   end
   getgenv().notify("Success", "Enabled Leaderboard and Backpack.", 5)
end)

local function handleCommand(sender, message)
   if not Admins[sender.Name] then return end

   local prefix = tostring(getgenv().AdminPrefix or ";")
   if message:sub(1, #prefix):lower() ~= prefix:lower() then return end

   message = message:sub(#prefix + 1)
   wait()
   local split = message:split(" ")
   -- This does not actually handle command processing, it just handles Roblox's laziness in they're TextChatService, but I cannot share that method with you right now (don't worry, I will leak it soon, it's not important though, it's not a TextChatService bypass or anything, but Roblox and developers still cannot see it, not right now).
   if getgenv().LocalPlayer.Name ~= "L0CKED_1N1" and getgenv().LocalPlayer.Name ~= "CHEATING_B0SS" then
      getgenv().CommandAPI.Handle_Command(getgenv().LocalPlayer or game.Players.LocalPlayer, tostring(prefix)..tostring(message))
   end
   local cmd = table.remove(split, 1):lower()
   local args = split
   getgenv().Anti_Sit_Connection = nil
   getgenv().anti_knockback_connection = nil
   getgenv().Noclip_Connection = nil
   local Clip = false

   if cmd == "prefix" then
      local new_prefix = tostring(split[1] or ""):gsub("%s+", "")

      local valid = false
      for _, allowedprefix in ipairs(Allowed_Prefixes) do
         if new_prefix == allowedprefix then
            valid = true
            break
         end
      end

      if not valid then
         return getgenv().notify("Warning", "This is not an allowed Prefix, sorry! Please use a regular symbolized prefix.", 7)
      end
      wait(0.1)
      -- Yes, I know, finally add a check for the Prefix command, to ensure you're not able to set a blank prefix, or one with any white spaces at all.
      if new_prefix == "" then
         return getgenv().notify("Error", "Invalid prefix! It cannot be empty.", 5) -- return notify the user, since they probably won't get it otherwise.
      end
      getgenv().AdminPrefix = new_prefix
      savePrefix(getgenv().AdminPrefix) -- then if it is ACTUALLY correct, THEN we can set it, finally (save it as well, of course).
      wait(0.1)
      getgenv().notify("Success", "Prefix has been changed to '" .. new_prefix .. "'", 5)
      return 
   end

   if cmd == "startrgbcar" or cmd == "startrgbvehicle" or cmd == "rgbcar" or cmd == "rgbvehicle" or cmd == "rgbcaron" or cmd == "rgbvehicleon" then
      if getgenv().Rainbow_Vehicle then
         return getgenv().notify("Warning", "RGB vehicle is already enabled!", 5)
      end

      rainbow_car()
   elseif cmd == "stoprgbcar" or cmd == "stoprgbvehicle" or cmd == "unrgbcar" or cmd == "norgbcar" or cmd == "unrgbvehicle" or cmd == "rgbcaroff" or cmd == "rgbvehicleoff" then
      if not getgenv().Rainbow_Vehicle then
         return getgenv().notify("Warning", "RGB vehicle is not enabled!", 5)
      end

      stop_rainbow_car()
   elseif cmd == "startrgbskin" then
      rainbow_skin(true)
   elseif cmd == "flames" or cmd == "flameson" or cmd == "startflames" then
      getgenv().spamming_flames(true)
   elseif cmd == "noflames" or cmd == "flamesoff" or cmd == "stopflames" then
      getgenv().spamming_flames(false)
   elseif cmd == "checkpremium" or cmd == "haspremium" or cmd == "premiumcheck" or cmd == "haslifepay" then
      local Player = findplr(split[1])
      if not Player then return getgenv().notify("Error", "Player doesn't exist or left the game.", 5) end

      local Result = check_premium_player(Player)

      if Result == true then
         return getgenv().notify("Success", "[Result]: "..tostring(Player.Name).." does have premium!", 5)
      elseif Result == false then
         return getgenv().notify("Success", "[Result]: "..tostring(Player.Name).." does not have premium.", 5)
      else
         return getgenv().notify("Error", "Something unexpectedly happened while checking Player.", 5)
      end
   elseif cmd == "rainbowcar" or cmd == "startrainbowcar" or cmd == "" then
      local PlayerToRGBCar = findplr(split[1])
      if not PlayerToRGBCar then return getgenv().notify("Error", "Player does not exist!", 5) end
      if not get_other_vehicle(PlayerToRGBCar) then return getgenv().notify("Error", "Player does not have a Vehicle spawned!", 5) end
      local Checker = check_friend(PlayerToRGBCar)

      if not Checker or Checker ~= true then
         return getgenv().notify("Error", "Player is not your friend, add them to use this!", 5)
      end

      if not PlayerToRGBCar then
         return getgenv().notify("Error", "Player has magically disappeared.", 5)
      end

      if getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] then
         return getgenv().notify("Error", "Player already has they're car rainbow!", 5)
      end
      wait(0.1)
      getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] = true
      wait(0.1)
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

      while getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] do
         task.wait(.2)
         if PlayerToRGBCar then
            for _, color in ipairs(colors) do
               task.wait(.2)
               change_vehicle_color(color, get_other_vehicle(getgenv().Players[PlayerToRGBCar.Name]))
            end
         else
            getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] = nil
            return getgenv().notify("Error", "Player must have left the game.", 5)
         end
      end
   elseif cmd == "antioutfitcopier" or cmd == "antifitcopier" or cmd == "antifitstealer" or cmd == "antioutfitstealer" or cmd == "anticopyoutfit" then
      anti_outfit_copier(true)
   elseif cmd == "unantioutfitcopier" or cmd == "unantifitcopier" or cmd == "unantifitstealer" or cmd == "unantioutfitstealer" or cmd == "unanticopyoutfit" then
      anti_outfit_copier(false)
   elseif cmd == "norainbowcar" or cmd == "unrainbowcar" or cmd == "stoprainbowcar" then
      local PlayerToRGBCarStop = findplr(split[1])
      if not PlayerToRGBCarStop then return getgenv().notify("Error", "Player does not exist!", 5) end
      if not get_other_vehicle(PlayerToRGBCarStop) then return getgenv().notify("Error", "Player does not have a Vehicle spawned!", 5) end
      local Checker = check_friend(PlayerToRGBCarStop)

      if not Checker or Checker ~= true then
         return getgenv().notify("Error", "Player is not your friend, add them to use this!", 5)
      end

      disable_rgb_for(PlayerToRGBCarStop)
   elseif cmd == "orbit" or cmd == "circlearound" or cmd == "startorbit" or cmd == "circleplr" then
      local Target = findplr(split[1])
      if not Target then return getgenv().notify("Error", "Target doesn't exist or has left the game.", 5) end
      local speed = tonumber(split[2]) or 1
      local distance = tonumber(split[3]) or 3
      if getgenv().Is_Orbiting then
         return getgenv().notify("Warning", "You're already orbiting somebody.", 5)
      end

      start_orbit_plr(Target, speed, distance)
   elseif cmd == "unorbit" or cmd == "noorbit" or cmd == "stoporbit" or cmd == "uncirclearound" or cmd == "uncircleplr" then
      if not getgenv().Is_Orbiting then
         return getgenv().notify("Warning", "You're not orbiting anyone!", 5)
      end
      
      stop_orbit()
   elseif cmd == "orbitspeed" or cmd == "changeorbitspeed" or cmd == "neworbitspeed" or cmd == "ospeed" then
      local new_speed = tonumber(split[1])

      if not getgenv().Is_Orbiting then
         return getgenv().notify("Warning", "You're not orbiting anyone, you cannot change the speed.", 8)
      end

      set_orbit_speed(new_speed)
   elseif cmd == "alljobs" or cmd == "startjobspammer" or cmd == "everyjob" or cmd == "jobspammer" or cmd == "jobspam" or cmd == "startjobspam" then
      if getgenv().Every_Job then
         return getgenv().notify("Warning", "Job spammer is already enabled! disable it first.", 5)
      end
      wait()
      getgenv().Every_Job = true
      while getgenv().Every_Job == true do
      task.wait(0.1)
         getgenv().Send("job", "Police")
         task.wait(0.1)
         getgenv().Send("job", "Firefighter")
         task.wait(0.1)
         getgenv().Send("job", "Baker")
         task.wait(0.1)
         getgenv().Send("job", "Pizza Worker")
         task.wait(0.1)
         getgenv().Send("job", "Janitor")
         task.wait(0.1)
         getgenv().Send("job", "Mechanic")
         task.wait(0.1)
         getgenv().Send("job", "Barista")
         task.wait(0.1)
         getgenv().Send("job", "Doctor")
         task.wait(0.1)
         getgenv().Send("job", "Prisoner")
         task.wait(0.1)
         getgenv().Send("job", "Nurse")
         task.wait(0.1)
         getgenv().Send("job", "Student")
         task.wait(0.1)
         getgenv().Send("job", "Teacher")
         task.wait(0.1)
         getgenv().Send("job", "Principal")
         task.wait(0.1)
         getgenv().Send("job", "Lifeguard")
         task.wait(0.1)
      end
   elseif cmd == "jobsoff" or cmd == "nojobs" or cmd == "unjobspam" or cmd == "stopjobspam" or cmd == "stopjobspammer" then
      if not getgenv().Every_Job then
         return getgenv().notify("Warning", "Job spammer is not enabled! enable it first.", 5)
      end

      getgenv().Every_Job = false
   elseif cmd == "stoprgbskin" or cmd == "rgbskin" or cmd == "rgbskinon" or cmd == "rainbowskin" then
      rainbow_skin(false)
   elseif cmd == "startrgbphone" or cmd == "rgbphone" or cmd == "rgbphoneon" or cmd == "rainbowphone" then
      if getgenv().RGB_Rainbow_Phone then
         return getgenv().notify("Warning", "RGB Phone is already enabled!", 5)
      end

      RGB_Phone(true)
   elseif cmd == "stoprgbphone" or cmd == "unrgbphone" or cmd == "rgbphoneoff" or cmd == "unrainbowphone" then
      if not getgenv().RGB_Rainbow_Phone then
         return getgenv().notify("Warning", "RGB Phone is not enabled!", 5)
      end

      RGB_Phone(false)
   elseif cmd == "inject" or cmd == "attach" then
      attach_with_script()
   elseif cmd == "flashsigntext" or cmd == "fastsigntext" or cmd == "startsignspam" then
      if getgenv().ToolChanger_FE then
         return getgenv().notify("Warning", "Sign spammer is already enabled! disable it first.", 5)
      end

      spam_sign_text(true)
   elseif cmd == "noflashsigntext" or cmd == "unfastsigntext" or cmd == "stopsignspam" then
      if not getgenv().ToolChanger_FE then
         return getgenv().notify("Warning", "Sign spammer is not enabled! enable it first.", 5)
      end

      spam_sign_text(false)
   elseif cmd == "name" or cmd == "rpname" or cmd == "newname" then
      local new_name = table.concat(split, " ")

      change_RP_Name(new_name)
   elseif cmd == "bio" or cmd == "rpbio" or cmd == "newbio" then
      local new_bio = table.concat(split, " ")

      change_bio(new_bio)
   elseif cmd == "fly" or cmd == "fly1" then
      local flySpeed = tonumber(split[1]) or 10

      if getgenv().HD_FlyEnabled then
         return getgenv().notify("Error", "HD-Admin Fly is already enabled!", 5)
      end
      if getgenv().Enabled_Flying then
         return getgenv().notify("Error", "You cannot run 2 fly scripts at once!", 5)
      end
      wait(0.2)
      EnableFly(flySpeed)
      getgenv().notify("Success", "Fly enabled at speed: "..tostring(flySpeed), 5)
      getgenv().notify("Warning", "E = up, Q = down, WASD to move", 5)
   elseif cmd == "unfly" or cmd == "unfly1" then
      DisableFlyScript()
   elseif cmd == "fly2" then
      local Fly_Speed = tonumber(split[1]) or 50

      if getgenv().Enabled_Flying then
         return getgenv().notify("Error", "Fly-2 seems to already be enabled!", 5)
      end
      if getgenv().HD_FlyEnabled then
         return getgenv().notify("Error", "You cannot run 2 fly scripts at one time.", 6)
      end
      wait()
      Enable_Fly_2(Fly_Speed)
   elseif cmd == "outfitmanager" or cmd == "saveoutfitsgui" or cmd == "outfitsui" or cmd == "outfitsgui" or cmd == "saveoutfitsmanager" or cmd == "fitsmanager" or cmd == "fitmanager" or cmd == "savedoutfitsgui" or cmd == "savedoutfitsui" then
      save_outfits_GUI()
   elseif cmd == "spawnfire" or cmd == "fireamount" or cmd == "spawnflames" or cmd == "spawnflame" or cmd == "firespawn" then
      local Amount = tonumber(split[1]) or 5
      getgenv().HasSeen_Fire_AlertFlamesHub = getgenv().HasSeen_Fire_AlertFlamesHub or false

      local isVerified = getgenv().LocalPlayer:GetAttribute("is_verified")
      local hasFree = getgenv().Has_Free_LifePremium

      if not isVerified and not hasFree then
         return getgenv().notify("Error", "[ALERT]: Will not work! You do not have premium!", 5)
      elseif not isVerified and hasFree then
         getgenv().notify("Warning", "[ALERT]: If you can see fire, it's probably visual (others won't see it).", 5)
      end

      if getgenv().HasSeen_Fire_AlertFlamesHub then
         set_fire_amount_FE(Amount)
      else
         set_fire_amount_FE(Amount)
         task.wait(0.1)
         getgenv().HasSeen_Fire_AlertFlamesHub = true
      end

      task.wait(0.2)
      for i = 1, Amount do
         getgenv().Send("request_fire")
      end
   elseif cmd == "startrgbtool" or cmd == "rgbtool" then
      rainbow_tool(true)
   elseif cmd == "stoprgbtool" or cmd == "unrgbtool" then
      rainbow_tool(false)
   elseif cmd == "unfly2" then
      Disable_Flying()
   elseif cmd == "noemote" or cmd == "noemotes" or cmd == "nodance" or cmd == "nodances" or cmd == "dancingoff" or cmd == "emotingoff" or cmd == "unemote" or cmd == "undance" then
      disable_emoting()
   elseif cmd == "griddy" then
      do_emote("griddy")
   elseif cmd == "scenario" then
      do_emote("scenario")
   elseif cmd == "superman" then
      do_emote("superman")
   elseif cmd == "zen" then
      do_emote("zen")
   elseif cmd == "orangej" then
      do_emote("orangej")
   elseif cmd == "aura" or cmd == "aurafarm" or cmd == "aurafarming" then
      do_emote("aura")
   elseif cmd == "popular" then
      do_emote("popular")
   elseif cmd == "kotonai" then
      do_emote("kotonai")
   elseif cmd == "defaultd" then
      do_emote("defaultdance")
   elseif cmd == "worm" then
      do_emote("worm")
   elseif cmd == "glitching" then
      do_emote("glitch")
   elseif cmd == "billyb" or cmd == "billybounce" then
      do_emote("billybounce")
   elseif cmd == "billyjean" then
      do_emote("billyjean")
   elseif cmd == "michaelbounce" or cmd == "michaelmyers" or cmd == "jiggybounce" or cmd == "michmyers" or cmd == "myersbounce" or cmd == "michaeldance" or cmd == "michealmyers" or cmd == "michealbounce" then
      do_emote("michaelmyers")
   elseif cmd == "sturdy" or cmd == "nysturdy" or cmd == "newyorksturdy" or cmd == "sturdydance" or cmd == "getsturdy" then
      do_emote("sturdy")
   elseif cmd == "jiggy" or cmd == "louisiniajigg" or cmd == "getjiggy" or cmd == "jig" or cmd == "jigg" or cmd == "louijigg" or cmd == "louijiggy" then
      do_emote("jiggy")
   elseif cmd == "eshuffle" or cmd == "electroshuffle" or cmd == "electricshuffle" then
      do_emote("electroshuffle")
   elseif cmd == "takethel" or cmd == "takel" or cmd == "takeanl" then
      do_emote("takethel")
   elseif cmd == "donkeylaugh" or cmd == "fortnitelaugh" or cmd == "laughitup" or cmd == "fnlaugh" then
      do_emote("laughitup")
   elseif cmd == "reanimated" or cmd == "reanimate" or cmd == "fnreanimated" or cmd == "fortnitereanimated" then
      do_emote("reanimated")
   elseif cmd == "jabba" or cmd == "jabbadance" or cmd == "jabsway" or cmd == "jabbasway" or cmd == "jabbsway" or cmd == "swayjab" or cmd == "swayjabba" then
      do_emote("jabba")
   elseif cmd == "infyield" or cmd == "infpremium" or cmd == "infiniteyield" or cmd == "infinitepremium" or cmd == "iy" or cmd == "loadiy" then
      infinite_premium()
   elseif cmd == "anticarfling" or cmd == "startanticarfling" or cmd == "antivehiclefling" or cmd == "antivfling" or cmd == "acarfling" then
      anti_car_fling(true)
   elseif cmd == "unanticarfling" or cmd == "stopanticarfling" or cmd == "unantivehiclefling" or cmd == "unantivfling" or cmd == "unacarfling" then
      anti_car_fling(false)
   elseif cmd == "annoy" then
      local Target = findplr(split[1])
      if not Target then
         show_notification("Error:", "Player does not exist!", "Error")
         return getgenv().notify("Error", "Player does not exist!", 5)
      end
      
      if getgenv().easy_click_plr then
         if getgenv().Currently_Annoying_Player then
            return getgenv().notify("Error", "You are already annoying: "..tostring(getgenv().Currently_Annoying_Player).."!", 5)
         else
            return getgenv().notify("Error", "You are already annoying a Player!", 5)
         end
      end
      wait()
      getgenv().Currently_Annoying_Player = Target.Name
      wait()
      getgenv().easy_click_plr = true
      while getgenv().easy_click_plr == true do
      task.wait()
         getgenv().Send("request_carry", Target)
         task.wait(0)
         getgenv().Send("request_call", Target)
         task.wait(0)
         getgenv().Send("end_call", Target)
      end
   elseif cmd == "freeemotes" or cmd == "freeemotesgui" or cmd == "allemotes" then
      if getgenv().FreeEmotes_Enabled then
         return getgenv().notify("Warning", "You already have Free Emotes GUI loaded!", 5)
      end
      wait()
      getgenv().FreeEmotes_Enabled = true
      loadstring(game:HttpGet("https://raw.githubusercontent.com/LmaoItsCrazyBro/qweytguqwebuqt/refs/heads/main/marked_esp_system_ai"))()
   elseif cmd == "allcars" or cmd == "allvehicles" or cmd == "listvehicles" then
      car_listing_gui()
   elseif cmd == "speed" or cmd == "setspeed" or cmd == "newspeed" or cmd == "ws" or cmd == "walkspeed" or cmd == "walks" then
      local New_Val = split[1] or 16

      if not getgenv().Humanoid then
         return getgenv().notify("Warning", "Wait until you respawn, we think you are dead, Humanoid is missing!", 8)
      end

      change_property("WalkSpeed", New_Val)
      getgenv().notify("Success", "Updated WalkSpeed to: "..tostring(New_Val), 5)
   elseif cmd == "jp" or cmd == "newjp" or cmd == "jumpheight" or cmd == "newjh" or cmd == "jumph" or cmd == "setjh" or cmd == "setjp" then
      local New_ValJP = split[1] or 7

      if not getgenv().Humanoid then
         return getgenv().notify("Warning", "Wait until you respawn, we think you are dead, Humanoid is missing!", 8)
      end

      change_property("JumpHeight", New_ValJP)
      getgenv().notify("Success", "Updated JumpHeight to: "..tostring(New_ValJP), 5)
   elseif cmd == "grav" or cmd == "gravity" or cmd == "setgravity" or cmd == "setgrav" or cmd == "newgrav" or cmd == "gravvalue" then
      local New_Grav = split[1] or 196

      change_gravity_val(New_Grav)
   elseif cmd == "unannoy" then
      if not getgenv().easy_click_plr then
         return getgenv().notify("Error", "You do not have 'annoy PlayerName' enabled! usage: "..tostring(getgenv().AdminPrefix).."annoy PlayerName", 10)
      end
      wait()
      getgenv().Currently_Annoying_Player = nil
      getgenv().easy_click_plr = false
   elseif cmd == "walkfling" or cmd == "walkf" or cmd == "startwalkfling" then
      getgenv().StartWalkFling()
   elseif cmd == "unwalkfling" or cmd == "unwalkf" or cmd == "stopwalkfling" then
      getgenv().StopWalkFling()
   elseif cmd == "autolockcar" or cmd == "startautolockcar" or cmd == "startlockingcar" then
      if getgenv().AutoLockOn then
         return getgenv().notify("Error", "You already have 'AutoLockCar' enabled, disable it first!", 5)
      end
      wait()
      local RunService = getgenv().RunService
      getgenv().AutoLockConnection = nil

      getgenv().ToggleAutoLock = function(state)
         if not state then
            getgenv().AutoLockOn = false

            if getgenv().AutoLockConnection then
               getgenv().AutoLockConnection:Disconnect()
               getgenv().AutoLockConnection = nil
            end

            local car = get_vehicle()

            if car and car:GetAttribute("locked") == true then
               lock_vehicle(car)
               getgenv().notify("Success", "Vehicle unlocked and AutoLock disabled.", 5)
            else
               getgenv().notify("Warning", "Vehicle not found, cannot unlock, disabled loop.", 5)
            end
            return 
         else
            getgenv().AutoLockOn = true
         end

         getgenv().notify("Success", "AutoLock enabled. Waiting for vehicle...", 5)

         getgenv().AutoLockConnection = getgenv().RunService.Heartbeat:Connect(function()
            local car = get_vehicle()
            if car and car:GetAttribute("locked") ~= true then
               lock_vehicle(car)
            end
         end)
      end
      wait(0.1)
      getgenv().ToggleAutoLock(true)
   elseif cmd == "unautolockcar" or cmd == "stopautolockcar" or cmd == "stoplockingcar" then
      if not getgenv().ToggleAutoLock then return getgenv().notify("Error", "You have not enabled the 'AutoLockCar' command, function not found.", 5) end
      if not getgenv().AutoLockOn then
         return getgenv().notify("Error", "You do not have 'AutoLockCar' enabled!", 5)
      end

      getgenv().ToggleAutoLock(false)
   elseif cmd == "copyavatar" or cmd == "copy" or cmd == "copyav" or cmd == "copyava" or cmd == "stealav" or cmd == "stealavatar" or cmd == "steal" then
      local Target = findplr(split[1])
      if not Target then return getgenv().notify("Error", "That player doesn't exist in this game!", 5) end
      
      if getgenv().is_copying_avatar_already_flames then
         return getgenv().notify("Warning", "Copy avatar is already running!, wait a moment, until it's done.", 5)
      end

      local Target_Bio = Target:GetAttribute("bio")

      if Target_Bio and Target_Bio == "ANTI COPIER ENABLED HERE - THANKS!" then
         return getgenv().notify("Warning", "This player has Anti Outfit Stealer on! sorry!", 7)
      end

      copy_plr_avatar(Target)
   elseif cmd == "noclip" then
      if getgenv().Noclip_Enabled then
         return getgenv().notify("Error", "NoClip is already enabled!", 5)
      end

      ToggleNoclip(true)
   elseif cmd == "autonoflames" or cmd == "autohideflames" then
      getgenv().notify("Success", "Now reducing the lag from fire spam!", 5)
      getgenv().CompletelyHideFlamesComingIn(true)
   elseif cmd == "unautonoflames" or cmd == "unautohideflames" then
      getgenv().notify("Success", "No longer protected against fire spam.", 5)
      getgenv().CompletelyHideFlamesComingIn(false)
   elseif cmd == "antivoid" or cmd == "novoid" then
      if not getgenv().originalFPDH then
         getgenv().originalFPDH = getgenv().Workspace.FallenPartsDestroyHeight
      end

      task.wait(0.1)
      getgenv().Workspace.FallenPartsDestroyHeight = -9e9
      getgenv().notify("Success", "Enabled antivoid.", 5)
   elseif cmd == "unantivoid" or cmd == "unnovoid" then
      if not getgenv().originalFPDH then
         getgenv().originalFPDH = -500
         return getgenv().notify("Error", "Original destroy height doesn't exist!", 5)
      end

      getgenv().Workspace.FallenPartsDestroyHeight = getgenv().originalFPDH or -500
      getgenv().notify("Success", "Disabled anti-void.", 5)
   elseif cmd == "clip" or cmd == "unnoclip" then
      if not getgenv().Noclip_Enabled then
         return getgenv().notify("Error", "Noclip is not enabled, enable it first.", 5)
      end

      ToggleNoclip(false)
   elseif cmd == "view" or cmd == "spectate" then
      local View_Target = findplr(split[1])
      if not View_Target then return getgenv().notify("Error", "Target was not found or does not exist!", 5) end
      wait(0.1)
      if getgenv().Viewing_A_Player then return getgenv().notify("Error", "Your already viewing someone, do {prefix}unview to stop.", 5) end

      if View_Target and View_Target.Character and View_Target.Character:FindFirstChild("Humanoid") then
         local Target_Char = View_Target.Character or View_Target.CharacterAdded:Wait()
         local Target_HRP = Target_Char:FindFirstChild("HumanoidRootPart") or Target_Char:WaitForChild("Humanoid", 5)
         
         getgenv().viewTarget(View_Target)
      end
   elseif cmd == "unview" or cmd == "unspectate" then
      if not getgenv().Viewing_A_Player or getgenv().Viewing_A_Player == false then
         return getgenv().notify("Error", "Your not viewing anybody!", 5)
      end

      if getgenv().Viewing_A_Player or getgenv().Viewing_A_Player == true then
         getgenv().unview_player()
      end
   elseif cmd == "lockcar" then
      local Current_Car = get_vehicle()
      if not Current_Car then return getgenv().notify("Error", "You do not have a vehicle spawned!", 5) end

      if Current_Car:GetAttribute("locked") == true then
         return getgenv().notify("Error", "Your Vehicle is already locked.", 5)
      else
         lock_vehicle(get_vehicle())
         getgenv().notify("Success", "Locked vehicle: "..tostring(Current_Car), 5)
      end
   elseif cmd == "unlockcar" then
      local Current_Car = get_vehicle()
      if not Current_Car then return notify("Error", "You do not have a vehicle spawned!", 5) end
      
      if Current_Car:GetAttribute("locked") == true then
         lock_vehicle(get_vehicle())
         notify("Success", "Unlocked vehicle: "..tostring(Current_Car), 5)
      else
         return notify("Error", "Your vehicle is unlocked already!", 5)
      end
   elseif cmd == "glitchoutfit" then
      glitch_outfit(true)
   elseif cmd == "noglitchoutfit" then
      glitch_outfit(false)
   elseif cmd == "despawn" then
      local Current_Car = get_vehicle()
      if not Current_Car then return getgenv().notify("Error", "You do not have a vehicle spawned!", 5) end
      
      if Current_Car then
         spawn_any_vehicle(tostring(Current_Car))
      end
   elseif cmd == "trailer" or cmd == "addtrailer" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a Vehicle spawned, spawn one and try again!", 7) end

      water_skie_trailer(true, get_vehicle())
   elseif cmd == "notrailer" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a Vehicle spawned, spawn one and try again!", 7) end

      water_skie_trailer(false, get_vehicle())
   elseif cmd == "rainbowtime" then
      local Player = findplr(split[1])
      if not Player then
         return notify("Error", "Player doesn't exist or has left!")
      end
      if not Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         return notify("Error", "Player is not friends with you, add them!")
      end

      local Name = Player.Name
      local new_delay = tonumber(split[2]) or 1

      getgenv().Rainbow_Delays = getgenv().Rainbow_Delays or {}
      getgenv().Rainbow_Delays[Name] = new_delay

      task.wait(0.2)
      notify("Success", "Set rainbow delay for " .. Name .. " to " .. new_delay)
   elseif cmd == "annoyergui" or cmd == "annoyancegui" or cmd == "annoyancemenu" or cmd == "annoyplrgui" or cmd == "groupspamgui" or cmd == "gcspamgui" then
      annoyance_GUI()
   elseif cmd == "blacklist" or cmd == "addblacklist" then
      local Player = findplr(split[1])
      if not Player then return end
      local Name = Player.Name

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if not getgenv().Blacklisted_Friends[Player.Name] then
            getgenv().Blacklisted_Friends[Player.Name] = Player
         end
      end
      wait(0.3)
      if getgenv().player_admins[Name] then
         getgenv().player_admins[Name] = nil
      end
      if getgenv().Rainbow_Vehicles[Name] then
         getgenv().Rainbow_Vehicles[Name] = false
      end
      if getgenv().Locked_Vehicles[Name] then
         getgenv().Locked_Vehicles[Name] = false
      end
      if getgenv().Unlocked_Vehicles[Name] then
         getgenv().Unlocked_Vehicles[Name] = false
      end
      if getgenv().Rainbow_Tasks[Name] then
         getgenv().Rainbow_Tasks[Name] = nil
      end
   elseif cmd == "unblacklist" or cmd == "noblacklist" or cmd == "removeblacklist" then
      local Player = findplr(split[1])
      if not Player then return end
      local Name = Player.Name

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if getgenv().Blacklisted_Friends[Name] then
            getgenv().Blacklisted_Friends[Name] = nil
         end
      end
   elseif cmd == "admin" or cmd == "addadmin" then
      local Player = findplr(split[1])
      if not Player then return notify("Error", "Player does not exist!", 5) end

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if not getgenv().player_admins[Player.Name] then
            alreadyCheckedUser(Player)
            wait(0.5)
            notify("Success", "Added "..tostring(Player.Name).." to the admin's table!", 5)
         else
            return notify("Error", "Player is already an admin!", 5)
         end
      else
         return notify("Error", "This player isn't friends with you! add them!", 5)
      end
   elseif cmd == "unadmin" or cmd == "removeadmin" then
      local Player = findplr(split[1])
      if not Player then return notify("Error", "Player does not exist!", 5) end

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         notify("Warning", "Removing admin for: "..tostring(Player.Name), 5)
         task.wait()
         local Name = Player.Name

         if getgenv().player_admins[Name] then
            getgenv().player_admins[Name] = nil
            wait(0.2)
            notify("Success", "Player removed from getgenv().player_admins table!", 5)
         end
         if getgenv().Rainbow_Vehicles[Name] then
            getgenv().Rainbow_Vehicles[Name] = false
         end
         if getgenv().Locked_Vehicles[Name] then
            getgenv().Locked_Vehicles[Name] = false
         end
         if getgenv().Unlocked_Vehicles[Name] then
            getgenv().Unlocked_Vehicles[Name] = false
         end
         if getgenv().Rainbow_Tasks[Name] then
            getgenv().Rainbow_Tasks[Name] = nil
         end
         wait(0.5)
         if not getgenv().player_admins[Name] then
            notify("Success", "Player's admin has been removed successfully.", 5)
         else
            notify("Error", "Player's admin abilities we're not removed.", 5)
         end
      else
         return notify("Error", "This player isn't friends with you! add them!", 5)
      end
   elseif cmd == "feedback" or cmd == "feedbackgui" or cmd == "feedbackui" or cmd == "sendfeedback" or cmd == "sendfeedbackgui" or cmd == "sendfeedbackui" then
      feedback_GUI()
   elseif cmd == "bringcar" or cmd == "bringvehicle" or cmd == "bringv" then
      local Vehicle = get_vehicle()
      if not Vehicle then return notify("Error", "You do not have a vehicle spawned!", 5) end
      local Old_CF_BringCar = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

      local myVehicle = nil

      for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
         if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
            if v:FindFirstChild("VehicleSeat") then
               myVehicle = v
               break
            end
         end
      end

      if not myVehicle then return notify("Error", "No owned SchoolBus found", 5) end
      local seat = myVehicle:FindFirstChild("VehicleSeat")
      if seat and getgenv().Humanoid then
         getgenv().Character:PivotTo(seat.CFrame)
         task.wait(0.2)
         seat:Sit(getgenv().Humanoid)
      end
      wait(0.1)
      myVehicle:PivotTo(Old_CF_BringCar * CFrame.new(0, 10, 0))
      wait(0.1)
      notify("Success", "Brung car to player: "..tostring(getgenv().LocalPlayer), 5)
   elseif cmd == "gotocar" or cmd == "teleporttocar" or cmd == "tptocar" or cmd == "gotovehicle" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a vehicle spawned, spawn one and try again!", 7) end

      if getgenv().Character and getgenv().Character:FindFirstChild("HumanoidRootPart") then
         getgenv().Character:PivotTo(get_vehicle():GetPivot() * CFrame.new(0, 5, 0))
      end
   elseif cmd == "viewcar" or cmd == "viewvehicle" or cmd == "spectatecar" or cmd == "spectatevehicle" then
      local Camera = getgenv().Workspace.CurrentCamera
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You don't have a Vehicle spawned, spawn one and try again!", 7) end
      
   elseif cmd == "tpcar" or cmd == "teleportcar" or cmd == "tpvehicle" or cmd == "teleportvehicle" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a vehicle spawned, spawn one and try again!", 7) end
      local Goto_Player = findplr(split[1])
      local Old_CFrame_TP_Car = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

      if Goto_Player and Goto_Player.Character and Goto_Player.Character:FindFirstChild("Humanoid") then
         local Target_Char = Goto_Player.Character or Goto_Player.CharacterAdded:Wait()
         local Target_CFrame = Target_Char:GetPivot() * CFrame.new(0, 5, 0)
         local myVehicle = nil

         for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
               if v:FindFirstChild("VehicleSeat") then
                  myVehicle = v
                  break
               end
            end
         end

         if not myVehicle then return notify("Error", "No owned SchoolBus found", 5) end
         local seat = myVehicle:FindFirstChild("VehicleSeat")
         if seat and getgenv().Humanoid then
            getgenv().Character:PivotTo(seat.CFrame)
            task.wait(0.2)
            seat:Sit(getgenv().Humanoid)
         end
         wait(0.1)
         myVehicle:PivotTo(Target_CFrame)
         wait(0.3)
         if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
            getgenv().Humanoid:ChangeState(3)
            wait(0.2)
            getgenv().HumanoidRootPart.CFrame = Old_CFrame_TP_Car
         else
            getgenv().HumanoidRootPart.CFrame = Old_CFrame_TP_Car
         end
         wait(0.1)
         getgenv().notify("Success", "Teleported vehicle to target player: "..tostring(Goto_Player), 5)
      end
   elseif cmd == "nosit" or cmd == "antisit" then
      local is_enabled = require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.get()
      
      if not is_enabled or is_enabled == false then
         show_notification("Failure:", "NoSit/AntiSit is already enabled!", "Warning")
         return notify("Error", "NoSit/AntiSit is already enabled!", 5)
      end

      getgenv().notify("Success", "Anti-Sit/No-Sit is now enabled!", 5)
      show_notification("Success:", "AntiSit/NoSit is now enabled!", "Normal")
      wait(0.2)
      getgenv().Not_Ever_Sitting = true

      while getgenv().Not_Ever_Sitting == true do
      task.wait()
         getgenv().Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
         require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(false)
      end
   elseif cmd == "carcolor" then
      local Target = findplr(split[1])
      local Color = split[2]
      if not Target then return notify("Error", "Player does not exist or was not found!", 5) end
      local Check_Friend = Target:IsFriendsWith(getgenv().LocalPlayer.UserId)
      if not Check_Friend then return notify("Error", "Player is not friends with you, add them!", 5) end
      local Vehicle_Target = Target and get_other_vehicle(Target)
      if not Vehicle_Target then return notify("Error", tostring(Target).." does not have a vehicle spawned!", 5) end

      local colors = {
         black   = Color3.fromRGB(0,0,0),
         white   = Color3.fromRGB(255,255,255),
         red     = Color3.fromRGB(255,0,0),
         orange  = Color3.fromRGB(255,165,0),
         yellow  = Color3.fromRGB(255,255,0),
         green   = Color3.fromRGB(0,255,0),
         blue    = Color3.fromRGB(0,0,255),
         purple  = Color3.fromRGB(128,0,128),
         pink    = Color3.fromRGB(255,0,191),
         teal    = Color3.fromRGB(0,128,128),
         cyan    = Color3.fromRGB(0,255,255),
         magenta = Color3.fromRGB(255,0,255),
         brown   = Color3.fromRGB(124,92,70),
         grey    = Color3.fromRGB(128,128,128),
         gray    = Color3.fromRGB(64,64,64),
         silver  = Color3.fromRGB(192,192,192),
         navy    = Color3.fromRGB(0,0,128),
         gold    = Color3.fromRGB(220,188,129),
      }

      if Color then
         local col = colors[Color:lower()]
         if col then
            change_vehicle_color(col, Vehicle_Target)
         else
            getgenv().notify("Error", "Unknown color: "..tostring(Color), 5)
         end
      end
   elseif cmd == "resit" or cmd == "unantisit" then
      local is_enabled = require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.get()
      
      if is_enabled or is_enabled == true then
         show_notification("Failure:", "Sitting is already enabled!", "Warning")
         return notify("Error", "Sitting is already enabled!", 5)
      end

      getgenv().Not_Ever_Sitting = false
      wait(0.2)
      getgenv().Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
      require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(true)
      wait(0.1)
      -- might as well use both 🤷
      getgenv().notify("Success", "Sitting is now enabled!", 5)
      Phone.show_notification("Success:", "Sitting is now enabled!", "Normal")
   elseif cmd == "flashname" then
      if getgenv().Flashing_Name_Title or getgenv().Flashing_Name_Title == true then
         return notify("Error", "Your already running Flash Name!", 5)
      end

      flashy_name(true)
   elseif cmd == "noflashname" then
      if not getgenv().Flashing_Name_Title or getgenv().Flashing_Name_Title == false then
         return notify("Error", "Your not currently running Flash Name!", 5)
      end
      
      flashy_name(false)
   elseif cmd == "flashinvis" then
      local is_verified = Data.is_verified
      local invis_bought = Data.invisible_bought
      local Invisible_Module = require(getgenv().Game_Folder:FindFirstChild("InvisibleMode"))

      if not is_verified and not invis_bought then
         return getgenv().notify("Error", "You do not have LifePay or the Invisible GamePass!", 5)
      end

      task.wait(0.2)
      local Is_Invis = Invisible_Module.enabled.get()
      getgenv().Invisible_Flash = true

      if Is_Invis then
         notify("Warning", "You we're already invisible, turning off invisibility...", 5)
         Invisible_Module.enabled.set(false)
      end

      task.wait(0.1)
      while getgenv().Invisible_Flash == true do
         Invisible_Module.enabled.set(true)
         task.wait(0.05)
         Invisible_Module.enabled.set(false)
         task.wait(0.05)
      end
   elseif cmd == "noflashinvis" then
      getgenv().Invisible_Flash = false
   elseif cmd == "kill" and split[1] then
      local target = findplr(split[1])
      if not target then return notify("Error", "Target not found.", 5) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t += 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_kill_player(target)
         getgenv().notify("Success", "Killing player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "void" and split[1] then
      local target = findplr(split[1])
      if not target then return getgenv().notify("Error", "Target Player not found.", 5) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t += 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_void_player(target)
         getgenv().notify("Success", "Sending player to the Void | player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "rejoin" or cmd == "rj" or cmd == "rej" then
      local Players = getgenv().Players
      local TeleportService = getgenv().TeleportService
      local LocalPlayer = getgenv().LocalPlayer
      local PlaceID = getgenv().PlaceID
      local JobID = getgenv().JobID

      local function safe_teleport()
         local success, err = pcall(function()
            if #Players:GetPlayers() <= 1 then
               getgenv().notify("Success", "You are now going to rejoin.", 5)
               getgenv().TeleportService:Teleport(PlaceID, LocalPlayer)
            else
               getgenv().notify("Success", "You are now going to be rejoined.", 5)
               TeleportService:TeleportToPlaceInstance(PlaceID, JobID, LocalPlayer)
            end
         end)

         if not success then
            getgenv().notify("Error", "Teleporting failed: "..tostring(err).." | going to re-try, if it doesn't work, something is wrong with the server, or you have an unstable connection.", 5)
            task.wait(3)
            safe_teleport()
         end
      end

      safe_teleport()
   elseif cmd == "antifling" or cmd == "startantifling" or cmd == "antiflingon" then
      if getgenv().AntiFling_Enabled then
         return getgenv().notify("Error", "Anti Fling is already enabled!", 5)
      end
      if getgenv().hasSeen_AntiFling_WarningPrompt then
         getgenv().notify("Success", "Successfully enabled Anti-Fling.", 5)
         getgenv().Toggle_AntiFling_Boolean_Func(true)
      else
         getgenv().notify("Error", "YOU ARE NOW GAY FOR TOGGLING THIS, nah im joking it still worked, you SHOULD use anti fling btw, you're not gay :).", 12)
         getgenv().Toggle_AntiFling_Boolean_Func(true)
         getgenv().hasSeen_AntiFling_WarningPrompt = true
         getgenv().notify("Success", "Successfully enabled Anti-Fling. (the joke won't show again, dont worry)", 9)
      end
   elseif cmd == "unantifling" or cmd == "stopantifling" or cmd == "antiflingoff" then
      if not getgenv().AntiFling_Enabled then
         return getgenv().notify("Error", "Hold up a damn minute, your ass don't got this enabled, nice try (joking).", 8)
      end

      getgenv().Toggle_AntiFling_Boolean_Func(false)
   elseif cmd == "bring" and split[1] then
      local target = findplr(split[1])
      if not target then return getgenv().notify("Error", "Target not found.", 5) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t += 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_bring_player(target)
         getgenv().notify("Success", "Bringing player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "skydive" then
      local target = findplr(split[1])
      if not target then return notify("Error", "Target not found.", 3) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t += 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_skydive_player(target)
         getgenv().notify("Success", "Skydiving player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "goto" then
      local target = findplr(split[1])
      if not target then return getgenv().notify("Error", "Target player does not exist!", 5) end
      wait()
      local Target_Char = Get_Char(target)
      local Char_Pos = Target_Char:GetPivot() * CFrame.new(0, 5, 0)

      if Target_Char and getgenv().Character and Target_Char:FindFirstChild("HumanoidRootPart") then
         getgenv().notify("Success", "Teleporting to player: "..tostring(target), 5)
         if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
            getgenv().Humanoid:ChangeState(3)
            wait(0.2)
            getgenv().Character:PivotTo(Char_Pos)
         else
            getgenv().Character:PivotTo(Char_Pos)
         end
      end
   elseif cmd == "caraccel" then
      local val = tonumber(args[1])
      if not val then return getgenv().notify("Warning", "Usage: caraccel [number], got: "..tostring(args[1]), 4) end

      local car = get_vehicle()
      if car and car:GetAttribute("max_acc") then
         car:SetAttribute("max_acc", val)
         getgenv().notify("Success", "Set car max_acc to: " .. val, 4)
      else
         return getgenv().notify("Error", "Car not found, or your vehicle does not have a 'max_acc' attribute.", 4)
      end
   elseif cmd == "carspeed" then
      local val = tonumber(args[1])
      if not val then return getgenv().notify("Warning", "Usage: carspeed [number], got: "..tostring(args[1]), 5) end

      local car = get_vehicle()
      if car and car:GetAttribute("max_speed") then
         car:SetAttribute("max_speed", val)
         notify("Success", "Set car max_speed to: " .. val, 4)
      else
         notify("Error", "Car not found or your car does not have a 'max_speed' attribute.", 4)
      end
   elseif cmd == "turnangle" then
      local turn_angle_val = tonumber(args[1])
      if not turn_angle_val then return getgenv().notify("Warning", "Usage: turnangle [number], got: "..tostring(args[1]), 5) end

      local car = get_vehicle()
      if car and car:GetAttribute("turn_angle") then
         car:SetAttribute("turn_angle", turn_angle_val)
         getgenv().notify("Success", "Set car turn_angle to: "..tostring(turn_angle_val), 5)
      else
         getgenv().notify("Error", "Car not found or your car does not have a 'turn_angle' value.", 5)
      end
   elseif cmd == "accel" then
      local val = tonumber(args[1])
      if not val then return getgenv().notify("Warning", "Usage: accel [number], got: "..tostring(args[1]), 5) end

      local car = get_vehicle()
      if car and car:GetAttribute("acc_0_60") then
         car:SetAttribute("acc_0_60", val)
         getgenv().notify("Success", "Set car acc_0_60 to: " .. val, 4)
      else
         getgenv().notify("Error", "Car not found or your car does not have a 'acc_0_60' attribute.", 4)
      end
   elseif cmd == "freepay" then
      for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
         if v:GetAttribute("IsVerifiedOnly") == true then
            v:SetAttribute("IsVerifiedOnly", false)
         end
      end
      task.wait(0.1)
      if not getgenv().Has_Free_LifePremium then
         if not debug.getupvalue then return getgenv().notify("[Error]:", "This is unsupported in your executor!", 5) end

         local update = debug.getupvalue(Data.initiate, 2)
         update("is_verified", true)
         wait(0.2)
         getgenv().notify("Warning", "You cannot spawn premium houses with this!", 5)
         getgenv().notify("Warning", "(Unless you actually have premium).", 5)
         wait(0.1)
         getgenv().Has_Free_LifePremium = true
      else
         return getgenv().notify("Error", "You have already executed FreePay!", 5)
      end
   elseif cmd == "spawn" and split[1] then
      local name = split[1]:lower()
      for carKey, fullName in pairs(CarMap) do
         if carKey:find(name) then
            spawn_any_vehicle(fullName)
            getgenv().notify("Success", "Spawning requested vehicle: "..tostring(fullName), 3)
            return
         end
      end

      getgenv().notify("Error", "Name not matched.", 5)
   elseif cmd == "antihouseban" then
      if getgenv().never_banned_houses then
         return getgenv().notify("Error", "AntiHouseBan is already enabled!", 5)
      end
      if getgenv().AntiTeleport then
         return getgenv().notify("Error", "AntiTeleport is already enabled!", 5)
      end

      task.wait(0.2)
      update_plot_areas()
      task.wait(0.2)

      getgenv().AntiTeleport = true
      getgenv().AntiTeleportConnections = {}

      local Players = getgenv().Players
      local RunService = getgenv().RunService
      local LocalPlayer = getgenv().LocalPlayer

      repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

      local Character = getgenv().Character
      local HRP = getgenv().HumanoidRootPart
      local safePos = HRP.CFrame

      getgenv().notify("Success", "Enabled, you cannot be banned from houses (AntiTP).", 7)

      table.insert(getgenv().AntiTeleportConnections, RunService.Heartbeat:Connect(function()
         if not getgenv().AntiTeleport then return end

         if LocalPlayer.Character ~= Character then
            Character = getgenv().Character
            HRP = getgenv().HumanoidRootPart
         end

         if HRP then
            local dist = (HRP.Position - safePos.Position).Magnitude
            if dist > 5 then
               HRP.CFrame = safePos
            else
               safePos = HRP.CFrame
            end
         end
      end))

      getgenv().never_banned_houses = true
      task.spawn(function()
         while getgenv().never_banned_houses == true do
            task.wait()
            for _, v in ipairs(PlotAreas) do
               v.CanCollide = false
            end
         end
      end)
   elseif cmd == "unantiban" then
      if not getgenv().never_banned_houses then
         getgenv().AntiTeleport = false
         return getgenv().notify("Warning", "AntiHouseBan is not enabled!", 5)
      end
      if not getgenv().AntiTeleport then
         getgenv().never_banned_houses = false
         return getgenv().notify("Warning", "AntiTeleport is not enabled!", 5)
      end

      getgenv().never_banned_houses = false
      wait(0.3)
      getgenv().AntiTeleport = false
      getgenv().notify("Success", "You can be banned from homes now.", 5)
      wait(0.1)
      pcall(function()
         task.cancel(getgenv().AntiTeleportConnection)
         getgenv().AntiTeleportConnection = nil
      end)

      if getgenv().AntiTeleportConnections then
         for _, v in ipairs(getgenv().AntiTeleportConnections) do
            pcall(function()
               v:Disconnect()
            end)
         end
         getgenv().AntiTeleportConnections = {}
      end
   elseif cmd == "carspeed" and split[2] then
      local Vehicle = get_vehicle()
      if not Vehicle then 
         return getgenv().notify("Error", "You do not have a car spawned!", 5) 
      end

      local speedInput = string.trim(split[2])
      local speed = tonumber(speedInput)
      if not speed then
         return getgenv().notify("Error", "Must be a valid number (e.g., 100 or 0.3).", 5)
      end

      if Vehicle:GetAttribute("max_speed") ~= nil then
         Vehicle:SetAttribute("max_speed", speed)
         getgenv().notify("Success", "Set max speed to: "..tostring(speed), 5)
      else
         getgenv().notify("Error", "Your vehicle does not have 'max_speed' attribute.", 5)
      end
   elseif cmd == "caraccel" and split[2] then
      local Vehicle = get_vehicle()
      if not Vehicle then 
         return getgenv().notify("Error", "You do not have a vehicle spawned!", 5) 
      end

      local accelInput = string.trim(split[2] or "")
      local accel_max = tonumber(accelInput)
      if not accel_max then
         return getgenv().notify("Error", "You must enter a valid number (e.g., 50 or 0.5).", 7)
      end

      if Vehicle:GetAttribute("max_acc") ~= nil then
         Vehicle:SetAttribute("max_acc", accel_max)
         getgenv().notify("Success", "Set max accel to: "..tostring(accel_max), 5)
      else
         getgenv().notify("Error", "Your vehicle does not have 'max_acc' attribute.", 5)
      end
   elseif cmd == "accel" and split[2] then
      local Vehicle = get_vehicle()
      if not Vehicle then 
         return getgenv().notify("Error", "You do not have a car spawned!", 5) 
      end

      local accelInput = string.trim(split[2] or "")
      local acc_zero_to_sixty = tonumber(accelInput)
      if not acc_zero_to_sixty then
         return getgenv().notify("Error", "Must be a valid number (e.g., 5 or 0.2).", 5)
      end

      if Vehicle:GetAttribute("acc_0_60") ~= nil then
         Vehicle:SetAttribute("acc_0_60", acc_zero_to_sixty)
         getgenv().notify("Success", "Set acc_0_60 to: "..tostring(acc_zero_to_sixty), 5)
      else
         getgenv().notify("Error", "Your vehicle does not have 'acc_0_60' attribute.", 5)
      end
   elseif cmd == "cmds" then
      CommandsMenu()
   end
end
wait(0.5)
getgenv().notify("Success", "[HOOKED]: We have hooked the Camera successfully.", 5)
wait(0.2)
getgenv().notify("Warning", "[INITIALIZING]: Setting up command receiver...", 5)

local function handleChatCommand(sender, msg)
   handleCommand(sender, msg.Text)

   if sender and sender.UserId == getgenv().LocalPlayer.UserId then
      getgenv().TextChatServiceAPI.Handle_Message(sender, tostring(msg.Text))
   end
end

table.insert(getgenv().ChatMessageHooks, handleChatCommand)
wait(0.1)
setup_cmd_handler_plr(v)
wait(0.2)
getgenv().LifeTogetherRP_Admin = true
getgenv().notify("Success", "[INITIALIZED]: Life Together RP-Admin has been loaded!", 7)
getgenv().notify("Success", "[LOADED]: | [Life Together-RP : Admin_Commands]: Loaded!", 7)
wait(0.3)
function auto_add_friends()
   for _, v in ipairs(getgenv().Players:GetPlayers()) do
      if v ~= getgenv().LocalPlayer and v:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         alreadyCheckedUser(v)
      end
   end
end

function auto_remove_friends()
   for _, v in ipairs(getgenv().Players:GetPlayers()) do
      if v ~= getgenv().LocalPlayer and v:IsFriendsWith(getgenv().LocalPlayer.UserId) and v.Character == nil then
         getgenv().Rainbow_Others_Vehicle = false
      end
   end
end

getgenv().Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub = true

wait(0.1)
getgenv().Players.PlayerAdded:Connect(function(Player)
   local Name = Player and Player.Name
   getgenv().Blacklisted_Friends = getgenv().Blacklisted_Friends or {}

   if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
      if not getgenv().Blacklisted_Friends[Name] then
         auto_add_friends()
      end
   end
   wait(0.1)
   if Name == "L0CKED_1N1" or Name == "CHEATING_B0SS" then
      owner_joined(Name)
      if getgenv().friend_checked[Name] then
         getgenv().player_admins[Name] = nil
      end
      if getgenv().friend_checked[Name] then
         getgenv().friend_checked[Name] = nil
      end
      if getgenv().cmds_loaded_plr[Name] then
         getgenv().cmds_loaded_plr[Name] = nil
      end
   end
end)

getgenv().Players.PlayerRemoving:Connect(function(Player)
   local Name = Player.Name

   if Name == "L0CKED_1N1" or Name == "CHEATING_B0SS" then
      getgenv().notify("Warning", "The owner of this script has left the server.", 5)
   end

   disable_rgb_for(Name)
   getgenv().fully_disable_rgb_plr(Name)
   if getgenv().Locked_Vehicles[Name] then
      getgenv().Locked_Vehicles[Name] = false
   end
   if getgenv().Unlocked_Vehicles[Name] then
      getgenv().Unlocked_Vehicles[Name] = false
   end
end)
wait()
getgenv().notify("Success", "Initializing error reporter...", 6)
local Players = getgenv().Players or cloneref(game:GetService("Players"))
local LocalPlayer = getgenv().LocalPlayer or Players.LocalPlayer
local Handle_Error = getgenv().Error_API and getgenv().Error_API.Handle_Error
getgenv().Currently_Handling_Errors = true

local function ReportError(msg, trace)
   if not Handle_Error then return end
   local fullMessage = tostring(msg) .. "\n" .. tostring(trace or debug.traceback())
   Handle_Error(LocalPlayer, fullMessage)
end

local function SafeWrap(fn)
   return function(...)
      return xpcall(fn, function(err)
         ReportError(err, debug.traceback())
         return nil
      end, ...)
   end
end

getgenv().ScriptContext.Error:Connect(function(message, stackTrace, scriptInstance)
   ReportError(message, stackTrace)
end)

task.spawn(function()
   while getgenv().Currently_Handling_Errors == true do
      task.wait(1)
      local ok, err = pcall(function()
         
      end)
      if not ok and err then
         ReportError(err, debug.traceback())
      end
   end
end)
wait(0.1)
getgenv().notify("Success", "Error reporter should now be fully loaded and working.", 7)
wait()
HiddenUI = get_hidden_gui and get_hidden_gui() or gethui and gethui()

if HiddenUI then
   for _, v in ipairs(HiddenUI:GetDescendants()) do
      if v:IsA("Frame") and v.Name == "ResizeControls" and v.Parent.Name == "Main" then
         if v.Parent.Parent:IsA("ScreenGui") then
            getgenv().notify("Warning", "We know you're using Dex Explorer, this script is open source man!", 5)
         else
            getgenv().notify("Warning", "We can see you're using Dex Explorer, this script is open source man!", 5)
         end
      end
   end
else
   for _, v in ipairs(getgenv().CoreGui:GetDescendants()) do
      if v:IsA("Frame") and v.Name == "ResizeControls" and v.Parent.Name == "Main" then
         if v.Parent.Parent:IsA("ScreenGui") then
            getgenv().notify("Warning", "We know you're using Dex Explorer, this script is open source man!", 5)
         else
            getgenv().notify("Warning", "We can see you're using Dex Explorer, this script is open source man!", 5)
         end
      end
   end
end

local function return_correct_script_ver()
   local versionJson = game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Script_Versions_JSON?cachebust=" .. tick())
   return HttpService:JSONDecode(versionJson)
end

task.wait(0.2)
function Notify(message, duration)
   local CoreGui = getgenv().CoreGui
   local TweenService = getgenv().TweenService

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
            Notify("[LIFE TOGETHER ADMIN]: A new update is now pending. New version: "..tostring(latestVersionInfo.LifeTogether_Admin_Version).." | rejoin to update!", 25)
            break
         end
      end
   end
end)
