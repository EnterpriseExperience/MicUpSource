if not game:IsLoaded() then
   game.Loaded:Wait()
end
wait(0.1)
if not getgenv().GlobalEnvironmentFramework_Initialized then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
   wait(0.1)
   getgenv().GlobalEnvironmentFramework_Initialized = true
end
wait(0.3)
local MarketplaceService = game:GetService("MarketplaceService")
local game_name = MarketplaceService:GetProductInfo(game.PlaceId).Name
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LumUILibrary.lua"))()
local Window = Library.new(tostring(game_name).." - Control Panel")
local HomeTab = Window:Tab("Home")
local ExploitsTab = Window:Tab("Exploits")
local UITab = Window:Tab("UI")
local Home_Section = HomeTab:Section("Home")
local Exploits_Section = ExploitsTab:Section("Exploits")
local UI_Section = UITab:Section("UI")
local g = getgenv()

function close_menu()
   closeWindow()
end

g.get_or_set = g.get_or_set or function(name, value)
   if rawget and rawset then
      local existing = rawget(g, name)
      if existing == nil then
         rawset(g, name, value)
         return value
      end
      return existing
   end

   local existing = g[name]

   if existing == nil then
      g[name] = value
      return value
   end

   return existing
end

g.Game = game
g.JobID = game.JobId
g.PlaceID = game.PlaceId

local function wait_for_datamodel(inst)
   if not inst then return false end

   local attempts = 0
   local maximum_attempts = 300

   while attempts < maximum_attempts do
      if inst.Parent and inst:IsDescendantOf(workspace) then
         return true
      end
      task.wait(0.1)
      attempts += 1
   end

   return false
end
wait(0.1)
get_or_set("wait_for_datamodel", wait_for_datamodel)

local function wait_for_child(parent, name)
   if not parent then return nil end

   local existing = parent:FindFirstChild(name)
   if existing then return existing end

   local ok, obj = pcall(function()
      return parent:WaitForChild(name, math.huge)
   end)

   return ok and obj or nil
end
wait(0.1)
get_or_set("wait_for_child", wait_for_child)

local function wait_for_descendant(parent, name)
   if not parent then return nil end

   local found = parent:FindFirstChild(name, true)
   if found then return found end

   local conn
   local result = nil

   conn = parent.DescendantAdded:Connect(function(d)
      if d.Name == name then
         result = d
         conn:Disconnect()
      end
   end)

   while not result do
      local check = parent:FindFirstChild(name, true)
      if check then
         result = check
         conn:Disconnect()
         break
      end
      task.wait()
   end

   return result
end
wait(0.1)
get_or_set("wait_for_descendant", wait_for_descendant)

local function wait_for_child_safe(parent, name)
   if not parent then return nil end

   local ok, obj = pcall(function()
      return parent:WaitForChild(name, 9e9)
   end)

   if ok and obj then
      return obj
   end

   return nil
end
wait(0.1)
get_or_set("wait_for_child_safe", wait_for_child_safe)

local function retry_find(func, retries, delay)
   for _ = 1, retries do
      local ok, result = pcall(func)
      if ok and result then
         return result
      end
      task.wait(delay)
   end
   return nil
end
wait(0.1)
get_or_set("retry_find", retry_find)

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

      local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
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

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
local valid_titles = {success="Success",info="Info",warning="Warning",error="Error",succes="Success",sucess="Success",eror="Error",erorr="Error",warnin="Warning"}
local function format_title(str)
   if typeof(str)~="string" then return "Info" end
   local key=str:lower()
   return valid_titles[key] or "Info"
end
getgenv().notify=getgenv().notify or function(title,msg,dur)
   local fixed_title=format_title(title)
   NotifyLib:External_Notification(fixed_title,tostring(msg),tonumber(dur))
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
      return getgenv().notify("Error", "You cannot target yourself.", 6)
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
wait()
local TweenService = cloneref and cloneref(getgenv().Game:GetService("TweenService")) or getgenv().Game:GetService("TweenService")
local TeleportService = cloneref and cloneref(getgenv().Game:GetService("TeleportService")) or getgenv().Game:GetService("TeleportService")
local UserInputService = cloneref and cloneref(getgenv().Game:GetService("UserInputService")) or getgenv().Game:GetService("UserInputService")
local HttpService = cloneref and cloneref(getgenv().Game:GetService("HttpService")) or getgenv().Game:GetService("HttpService")
local Players = cloneref and cloneref(getgenv().Game:GetService("Players")) or getgenv().Game:GetService("Players")
local RunService = cloneref and cloneref(getgenv().Game:GetService("RunService")) or getgenv().Game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = cloneref and cloneref(getgenv().Game:GetService("ReplicatedStorage")) or getgenv().Game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(getgenv().Game:GetService("Workspace")) or getgenv().Game:GetService("Workspace")
task.wait(0.2)
getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
local ts = TeleportService
local lp = getgenv().LocalPlayer
local char = getgenv().Character
local hum = getgenv().Humanoid
local StarterPlayer = getgenv().StarterPlayer or cloneref and cloneref(getgenv().Game:GetService("StarterPlayer")) or getgenv().Game:GetService("StarterPlayer")
local usesJumpHeight = StarterPlayer.CharacterUseJumpPower
local Remote_Functions = ReplicatedStorage:FindFirstChild("RemoteFunctions")
local Remote_Events = ReplicatedStorage:FindFirstChild("RemoteEvents")
local GetOpponentType = Remote_Functions:WaitForChild("GetOpponentTypeFunction")
local Send_Message_Event = Remote_Events:FindFirstChild("SendMessageEvent")
local Make_Guess_Event = Remote_Events:FindFirstChild("MakeGuessEvent")
local Gui_Main = getgenv().PlayerGui:FindFirstChild("GUI")
local End_Screen_Frame = Gui_Main:FindFirstChild("EndScreenFrame")
local New_Game_Button = End_Screen_Frame:FindFirstChild("NewGameButton")
local Main_Frame = Gui_Main:FindFirstChild("MainFrame")
local Guess_Frame = Main_Frame:FindFirstChild("GuessFrame")
local Opponent_Chat_Frame = Main_Frame:FindFirstChild("ChatFrame")
local Signals = {
   "Activated",
   "MouseButton1Down",
   "MouseButton2Down",
   "MouseButton1Click",
   "MouseButton2Click"
}

function Click_Button(Button)
   if not Button then return end

   if Button:IsA("TextButton") or Button:IsA("ImageButton") then
      for _, signalName in ipairs(Signals) do
         local ok, signal = pcall(function() return Button[signalName] end)
         if ok and typeof(signal) == "RBXScriptSignal" then
            pcall(firesignal, signal)
         end
      end
   else
      getgenv().notify("Error", "That is not a button!", 5)
   end
end

local Messages = {
   "Hello.",
   "How is the weather?",
   "Are you alright?",
   "No.",
   "Yes.",
   "Maybe.",
   "Alright.",
   "Occupied, try again later",
   "What did you say?",
   "I'm sorry, I didn't get that.",
   "Try entering the prompt again.",
   "Would you care to make a review?",
   "Please set a rating.",
   "Please wait before utilizing this.",
   "This was automated.",
   "We're sorry, we're experiencing difficulties reaching our servers right now.",
   "Would you like to leave a comment?",
   "Tell me about yourself.",
   "What's going on?",
   "How's it going?",
   "Greetings.",
   "Thank you.",
   "Roblox is a platform suitable for all players and ages.",
   "Roblox has made lots of innovative changes throughout its years.",
   "Want to learn more?",
   "I see.",
   "Interesting.",
   "Please clarify.",
   "That is beyond my current capabilities.",
   "I am still learning.",
   "System update in progress.",
   "That action is not permitted.",
   "Can you try again?",
   "This will take a moment.",
   "Acknowledged.",
   "Noted.",
   "Understood.",
   "Processing...",
   "Complete.",
   "Please rephrase your query.",
   "That question lacks sufficient context.",
   "Hold on...",
   "Welcome back.",
   "Loading data...",
   "Query not recognized.",
   "Permission denied.",
   "That’s not something I can answer right now.",
   "Let me check that for you.",
   "Sending request...",
   "This request is being processed.",
   "You’re speaking to an AI assistant.",
   "I'm always here to help.",
   "That's confidential.",
   "Unable to provide that detail.",
   "That’s outside my scope.",
   "This response was generated automatically.",
   "You may contact support for more help.",
   "Your input is appreciated.",
   "That depends on various factors.",
   "Let me look into that.",
   "Thanks for asking.",
   "Glad you reached out.",
   "Let’s get started.",
   "You are now connected.",
   "Rebooting interface...",
   "Resetting settings...",
   "Awaiting further instructions.",
   "I do not have access to that.",
   "Check back later.",
   "Temporarily unavailable.",
   "This input violates our policies.",
   "Please contact moderation.",
   "Service is temporarily down.",
   "Hello, user.",
   "Goodbye.",
   "Restart required.",
   "Malfunction detected.",
   "Error code: 417",
   "I'm just a script, but I'm doing my best.",
}

function reveal()
   local success, result = pcall(function()
      return GetOpponentType:InvokeServer()
   end)

   if success then
      if result == "Player" then
         getgenv().notify("Success", "Opponent is a Real Player!", 5)
      elseif result == "AI" then
         getgenv().notify("Info", "Opponent is an AI Bot!", 5)
      else
         return getgenv().notify("Error", "Current opponent type is unknown or unexpected: "..tostring(result), 12)
      end
   else
      return getgenv().notify("Error", "Failed to invoke GetOpponentTypeFunction: "..tostring(result), 12)
   end
end

local function determine_AI_or_player()
   local success, result = pcall(function()
      return GetOpponentType:InvokeServer()
   end)

   if success then
      if result == "Player" then
         return "Player"
      elseif result == "AI" then
         return "AI"
      else
         getgenv().notify("Error", "Opponent type is unknown or unexpected: "..tostring(result), 12)
      end
   else
      getgenv().notify("Error", "Failed to invoke GetOpponentTypeFunction: "..tostring(result), 12)
   end

   return nil
end

getgenv().RevealPlrOrAIButton = Home_Section:Button("Reveal (FREE)", function()
   reveal()
end)

getgenv().CorrectlyGuess = Exploits_Section:Button("Correctly Guess (Free)", function()
   local ai_or_real = determine_AI_or_player()
   local AIButton = Guess_Frame:FindFirstChild("AIButton")
   local PlayerButton = Guess_Frame:FindFirstChild("PlayerButton")

   if not firesignal then
      return getgenv().notify("Error", "Your executor cannot run this, missing 'firesignal'!", 5)
   end
   wait(0.1)
   if ai_or_real == "AI" then
      if not firesignal then
         Make_Guess_Event:FireServer("AI")
      else
         Make_Guess_Event:FireServer("AI")
         wait(0.2)
         Click_Button(AIButton)
      end
   elseif ai_or_real == "Player" then
      if not firesignal then
         Make_Guess_Event:FireServer("Player")
      else
         Make_Guess_Event:FireServer("Player")
         wait(0.2)
         Click_Button(PlayerButton)
      end
   else
      return getgenv().notify("Error", "Could not determine opponent type.", 5)
   end
end)

local chat_monitor_connection
wait(0.1)
getgenv().AutoReplyChat = Exploits_Section:Toggle("Auto Chat (FE)", function(activated_auto_chat)
   if activated_auto_chat then
      getgenv().chatMonitorEnabled = true
      chat_monitor_connection = nil
      local random_message = Messages[math.random(1, #Messages)]

      if chat_monitor_connection then
         chat_monitor_connection:Disconnect()
      end

      chat_monitor_connection = Opponent_Chat_Frame.ChildAdded:Connect(function(child)
         if getgenv().chatMonitorEnabled and child:IsA("Frame") then
            Send_Message_Event:FireServer(random_message)
         end
      end)
      wait(0.5)
      while getgenv().chatMonitorEnabled == true do
      wait(3)
         Send_Message_Event:FireServer(random_message)
      end
   else
      getgenv().chatMonitorEnabled = false
      wait()
      if chat_monitor_connection then
         chat_monitor_connection:Disconnect()
         chat_monitor_connection = nil
         getgenv().chatMonitorEnabled = false
      else
         getgenv().notify("Error", "'Auto Chat' was not running!", 5)
      end
   end
end)

-- Haven't figured out the correct setup yet, will be put in sometime soon.
--[[Home_Section:Toggle("Auto Play", function(activated_auto_play)
   if firesignal then
      Click_Button(New_Game_Button)
   else
      return getgenv().notify("Error", "Your executor does not support 'firesignal'!", 5)
   end
end)--]]

getgenv().NewGameButtonNotWorking = Exploits_Section:Button("New Game (Broken?)", function()
   Remote_Events:WaitForChild("RequestGameEvent"):FireServer()
end)

getgenv().SendRandomMsg = Home_Section:Button("Random Message (FE)", function()
   local random_message = Messages[math.random(1, #Messages)]

   Send_Message_Event:FireServer(random_message)
end)
wait()
local file_exists = false
local filename = "SmartResponder_Custom.json"
local httpservice = getgenv().HttpService or cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
wait(0.1)
if writefile and readfile and isfile then
   if isfile(filename) then
      file_exists = true
   else
      file_exists = false
      wait(0.2)
      local ok, err = pcall(function()
         writefile(filename, httpservice:JSONEncode({"Hello."}))
      end)
      if not ok then
         getgenv().notify("Error", "Failed to create fallback file: "..tostring(err), 5)
      end
      wait(0.4)
      if isfile(filename) then
         file_exists = true
      else
         getgenv().notify("Error", "Could not writefile to create custom .json file!", 5)
      end
   end
else
   getgenv().notify("Error", "Your executor does not support file operations.", 5)
end
wait(0.1)
Home_Section:TextBox("Add Custom Trigger", function(input)
   if input and input ~= "" then
      local msgs = {}
      if isfile and isfile(filename) then
         msgs = httpservice:JSONDecode(readfile(filename))
      end
      table.insert(msgs, input)
      if writefile then
         writefile(filename, httpservice:JSONEncode(msgs))
      end
      getgenv().notify("Success", "Added trigger: "..tostring(input), 5)
   end
end)

local function get_triggers()
   if isfile and isfile(filename) then
      local ok, data = pcall(function()
         return httpservice:JSONDecode(readfile(filename))
      end)
      if ok and type(data) == "table" and #data > 0 then
         return data
      end
   end
   return {"Hello."}
end

local custom_options = get_triggers()
local dropdown = Home_Section:Dropdown("Custom Triggers")
dropdown:ChangeText("Custom Triggers")

for _, item in ipairs(custom_options) do
   dropdown:Toggle(item, function(state)
      getgenv().notify("Success", "Sent message: "..tostring(state), 6)
      Send_Message_Event:FireServer(tostring(state))
   end)
end

local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local Math_Keywords = {
   ["plus"] = "+", ["minus"] = "-", ["times"] = "*",
   ["multiplied by"] = "*", ["divided by"] = "/",
   ["over"] = "/", ["what's"] = "", ["what is"] = "",
   ["calculate"] = "", ["solve"] = "", ["pi"] = tostring(math.pi),
}

local Greeting_Replies = {
   "Hey, what's up?",
   "Yo, what do you need?",
   "Hello! Got a math problem for me?",
}

local Math_Replies = {
   "The answer is: %s.",
   "Calculated: %s.",
   "That comes out to %s.",
}

local function Normalize_Text(text)
   return text:lower():gsub("%s+", " "):match("^%s*(.-)%s*$")
end

local function Solve_Math(text)
   text = text:lower()
   for word, symbol in pairs(Math_Keywords) do
      text = text:gsub(word, symbol)
   end
   text = text:gsub("[^%d%.%+%-%*/%%^%(%)\n%s]", "")
   text = text:match("[%d%.%+%-%*/%%^%(%)%s]+")
   if not text or #text < 1 then return nil end
   local ok, result = pcall(loadstring, "return " .. text)
   if not ok or type(result) ~= "function" then return nil end
   local ok2, val = pcall(result)
   if ok2 and type(val) == "number" and val == val then
      return tostring(math.round(val * 1e6) / 1e6)
   end
   return nil
end

local Reply_Rules = {
   {
      priority = 1,
      check = function(n)
         return n:find("your name") or n:find("ur name") or n:find("who are you")
      end,
      reply = function()
         return "My name is " .. tostring(Players.LocalPlayer.DisplayName) .. "."
      end
   },
   {
      priority = 2,
      check = function(n)
         return n:match("^hey") or n:match("^hi") or n:match("^yo") or n:find("hello")
      end,
      reply = function()
         return Greeting_Replies[math.random(#Greeting_Replies)]
      end
   },
   {
      priority = 3,
      check = function(n)
         return n:find("how are you") or n:find("how r u") or n:find("u good")
      end,
      reply = function()
         return "Doing good, throw a math problem at me."
      end
   },
   {
      priority = 4,
      check = function(n)
         return n:find("siri") or n:find("alexa") or n:find("gpt") or n:find("bot")
      end,
      reply = function()
         return "Hello, I can solve math problems for you."
      end
   },
   {
      priority = 5,
      check = function(n)
         return n:find("are you real") or n:find("are u real") or n:find("ur a bot")
      end,
      reply = function()
         return "Automated, but I can solve math — try me."
      end
   },
}

local function Get_Smart_Reply(raw_msg)
   local normalized = Normalize_Text(raw_msg)

   table.sort(Reply_Rules, function(a, b) return a.priority < b.priority end)
   for _, rule in ipairs(Reply_Rules) do
      if rule.check(normalized) then
         return rule.reply()
      end
   end

   local math_result = Solve_Math(raw_msg)
   if math_result then
      local template = Math_Replies[math.random(#Math_Replies)]
      return template:format(math_result)
   end

   return nil
end

getgenv().SmartReplyExploit = Exploits_Section:Toggle("Smart Reply (Broken)", function(activated)
   if activated then
      getgenv().Smart_Reply_Enabled = true
      if getgenv().Smart_Reply_Connection then getgenv().Smart_Reply_Connection:Disconnect() end
      local function Handle_Opponent_Message(opponent_message)
         task.spawn(function()
            local bubble_frame = opponent_message:FindFirstChild("OpponentMessageBubble")
            if not bubble_frame then
               opponent_message.ChildAdded:Connect(function(v)
                  if v.Name == "OpponentMessageBubble" then bubble_frame = v end
               end)
               repeat task.wait() until bubble_frame
            end

            local text_label = bubble_frame:FindFirstChild("MessageText")
            if not text_label then
               bubble_frame.ChildAdded:Connect(function(v)
                  if v.Name == "MessageText" then text_label = v end
               end)
               repeat task.wait() until text_label
            end

            local reply = Get_Smart_Reply(text_label.Text)
            if reply then
               Send_Message_Event:FireServer(reply)
               getgenv().notify("Success", "Replied: " .. tostring(reply), 5)
            end
         end)
      end

      getgenv().Smart_Reply_Connection = Opponent_Chat_Frame.ChildAdded:Connect(function(child)
         if not getgenv().Smart_Reply_Enabled then return end
         if child.Name ~= "OpponentMessage" or not child:IsA("Frame") then return end
         Handle_Opponent_Message(child)
      end)

      for _, child in ipairs(Opponent_Chat_Frame:GetChildren()) do
         if child.Name == "OpponentMessage" and child:IsA("Frame") then
            Handle_Opponent_Message(child)
         end
      end
   else
      getgenv().Smart_Reply_Enabled = false
      if getgenv().Smart_Reply_Connection then
         getgenv().Smart_Reply_Connection:Disconnect()
         getgenv().Smart_Reply_Connection = nil
      end
      task.wait(0.2)
      getgenv().notify("Success", "Smart-Responder has been disabled.", 5)
   end
end)

UI_Section:Button("Destroy GUI", function()
   close_menu()
end)
