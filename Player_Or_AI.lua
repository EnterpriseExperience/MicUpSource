getgenv().Game = game
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId
wait(0.2)
local library = loadstring(getgenv().Game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
wait()
getgenv().Service_Wrap = function(serviceName)
    if cloneref then
        return cloneref(getgenv().Game:GetService(serviceName))
    else
        return getgenv().Game:GetService(serviceName)
    end
end

getgenv().notify = function(Title, Content, Duration)
   local StarterGui = getgenv().Service_Wrap("StarterGui")
   task.wait()
   StarterGui:SetCore("SendNotification", {
      Title = tostring(Title);
      Text = tostring(Content);
      Duration = tonumber(Duration);
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

function low_level_executor()
   if executor_Name == "Solara" or string.find(executor_Name, "JJSploit") or executor_Name == "Xeno" then
      getgenv().notify("Failure:", "This feature isn't supported on this executor.", 5)
      return false
   else
      return true
   end
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
wait()
local TweenService = cloneref and cloneref(game:GetService("TweenService")) or game:GetService("TweenService")
local TeleportService = cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
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
wait(0.1)
Dynamic_Character_Updater(getgenv().Character)
task.wait(0.1)
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

local Main_Window = library:CreateWindow("Main")
local Players_Window = library:CreateWindow("Players")
local Extras_Window = library:CreateWindow("Extras")
local Main_Folder = Main_Window:CreateFolder("Main")
local Players_Folder = Players_Window:CreateFolder("Players")
local Extras_Folder = Extras_Window:CreateFolder("Extras")
local ts = TeleportService
local lp = getgenv().LocalPlayer
local char = getgenv().Character
local hum = getgenv().Humanoid
local StarterPlayer = getgenv().StarterPlayer or cloneref and cloneref(game:GetService("StarterPlayer")) or game:GetService("StarterPlayer")
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
local Opponent_Chat_Frame = Main_Frame:FindFirstChild("OpponentChatFrame")
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
         local signal = rawget(Button, signalName)
         if typeof(signal) == "RBXScriptSignal" then
            pcall(firesignal, signal)
         end
      end
   else
      getgenv().notify("Failure:", "This is not a button!", 5)
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
         getgenv().notify("Result:", "Opponent is a Real Player!", 5)
      elseif result == "AI" then
         getgenv().notify("result;", "Opponent is an AI Bot!", 5)
      else
         warn("Opponent type is unknown or unexpected:", result)
      end
   else
      warn("Failed to invoke GetOpponentTypeFunction:", result)
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
         warn("Opponent type is unknown or unexpected:", result)
      end
   else
      warn("Failed to invoke GetOpponentTypeFunction:", result)
   end

   return nil
end

Main_Folder:Button("Reveal (Free)",function()
   reveal()
end)

Extras_Folder:Button("Correctly Guess (Free)", function()
   local ai_or_real = determine_AI_or_player()
   local AIButton = Guess_Frame:FindFirstChild("AIButton")
   local PlayerButton = Guess_Frame:FindFirstChild("PlayerButton")

   if not firesignal then
      return getgenv().notify("Failure:", "Your executor cannot run this, missing 'firesignal'!", 5)
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
      return getgenv().notify("Failure:", "Could not determine opponent type.", 5)
   end
end)

local chat_monitor_connection
wait(0.1)
Players_Folder:Toggle("Auto Chat (FE)", function(activated_auto_chat)
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
         getgenv().notify("Failure:", "'Auto Chat' was not running!", 5)
      end
   end
end)

-- Haven't figured out the correct setup yet, will be put in sometime soon.
--[[Main_Folder:Toggle("Auto Play", function(activated_auto_play)
   if firesignal then
      Click_Button(New_Game_Button)
   else
      return getgenv().notify("Cannot Use:", "Your executor does not support 'firesignal'!", 5)
   end
end)--]]

Extras_Folder:Button("New Game (Broken)", function()
   Remote_Events:WaitForChild("RequestGameEvent"):FireServer()
end)

Main_Folder:Button("Random Message (FE)", function()
   local random_message = Messages[math.random(1, #Messages)]

   Send_Message_Event:FireServer(random_message)
end)

local reply_monitor_connection

Players_Folder:Toggle("Smart Reply (FE)", function(activated_auto_reply)
   if activated_auto_reply then
      getgenv().smartResponderEnabled = true
      getgenv().smartResponderConnection = nil

      local function normalize(text)
         return text:lower():gsub("[%p%c]", "")
      end

      local function solveMathFromText(text)
         text = text:lower()

         text = text:gsub("plus", "+")
         text = text:gsub("minus", "-")
         text = text:gsub("times", "*")
         text = text:gsub("multiplied by", "*")
         text = text:gsub("divided by", "/")
         text = text:gsub("over", "/")
         text = text:gsub("equals", "=")
         text = text:gsub("what's", "")
         text = text:gsub("what is", "")
         text = text:gsub("calculate", "")
         text = text:gsub("solve", "")
         text = text:gsub("x", "*")

         text = text:gsub("[^%d%+%-%*/%^%.%=()%s]", "")
         text = text:match("[0-9%+%-%*/%^%.=()%s]+")

         if not text then return end

         if text:match("=") and text:match("x") then
            local lhs, rhs = text:match("(.+)%s*=%s*(.+)")
            if lhs and rhs then
               local val = tonumber(rhs)
               if val then
                  local expr = lhs:gsub("x", "")
                  local num = tonumber(expr)
                  if num then
                     local x = val - num
                     return "x = " .. tostring(x)
                  end
               end
            end
         end

         local success, result = pcall(function()
            return loadstring("return " .. text)()
         end)

         if success and type(result) == "number" then
            return tostring(result)
         end
      end

      local function getSmartReply(message)
         local normalized = normalize(message)

         if normalized:match("^(yo+)%s") or normalized:find("hello") or normalized:find("hi") or normalized:find("hey") then
            return "Hello, how are you doing?"
         end

         if normalized:find("siri") or normalized:find("alexa") then
            return "Hello, how may I assist you today? math problems?"
         end

         if normalized:find("how are you") or normalized:find("how r u") then
            return "I'm doing well, give me a math problem to solve."
         end

         local mathAnswer = solveMathFromText(message)
         if mathAnswer then
            return "The answer is: " .. mathAnswer
         end

         if normalized:find("are you real") or normalized:find("are u real") then
            return "I'm real, but automated using scripts, give me a math problem."
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

         return Messages[math.random(1, #Messages)]
      end

      if getgenv().smartResponderConnection then
         getgenv().smartResponderConnection:Disconnect()
      end

      getgenv().smartResponderConnection = Opponent_Chat_Frame.ChildAdded:Connect(function(child)
         if not getgenv().smartResponderEnabled then return end

         wait(0.1)
         local textLabel = child:FindFirstChild("MessageText")
         if textLabel and textLabel:IsA("TextLabel") then
            local msg = textLabel.Text
            local reply = getSmartReply(msg)
            if reply then
               Send_Message_Event:FireServer(reply)
               getgenv().notify("[SmartResponder]:", "Successfully Replied with: "..tostring(reply), 5)
            end
         end
      end)
   else
      getgenv().smartResponderEnabled = false
      wait()
      if getgenv().smartResponderConnection then
         getgenv().smartResponderConnection:Disconnect()
         getgenv().smartResponderConnection = nil
      end
      wait(0.2)
      getgenv().notify("Success:", "Disconnected Smart Responder!", 5)
   end
end)
