getgenv().Game = game
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId
local Raw_Version = "V2.9.3"
task.wait(0.1)
local Script_Version = tostring(Raw_Version).."-LifeAdmin"

if getgenv().LifeTogetherRP_Admin then
   return getgenv().notify("Failure:", "Life Together RP admin is already running!", 5)
end

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

local Players = getgenv().Service_Wrap("Players")
local LocalPlayer = Players.LocalPlayer
local GroupId = getgenv().Game.CreatorId
local staffRoles = {
   "Admin", "Technical Assistance", "Developer A", "Technical Lead", "Finance", "Owner", "QA Lead"
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
local cmdp = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local cmdlp = cmdp.LocalPlayer

function findplr(args)
   local tbl = cmdp:GetPlayers()

   if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
      return warn("Failure!", "You cannot target yourself!")
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
      "PhysicsService"
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
local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
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
function send_function(arg1, arg2, arg3)
   if arg1 and arg2 and arg3 then
      Network.get(arg1, arg2, arg3)
   elseif arg1 and arg2 then
      Network.get(arg1, arg2)
   elseif arg1 then
      Network.get(arg1)
   end
end

function send_remote(arg1, arg2, arg3)
   if arg1 ~= nil and arg2 ~= nil and arg3 ~= nil then
      Network.send(arg1, arg2, arg3)
   elseif arg1 ~= nil and arg2 ~= nil then
      Network.send(arg1, arg2)
   elseif arg1 ~= nil then
      Network.send(arg1)
   end
end
wait(0.1)
getgenv().Get = send_function
getgenv().Send = send_remote
wait()
function change_vehicle_color(Color, Vehicle)
   send_remote("vehicle_color", Color, Vehicle)
end
wait(0.2)
function sit_in_vehicle(Vehicle)
   if not Vehicle then return notify("Failure:", "You do not have a Vehicle! spawn one.", 5) end

   send_function("sit", Vehicle)
   wait(0.1)
   if Vehicle:FindFirstChild("VehicleSeat") then
      Vehicle:FindFirstChild("VehicleSeat"):Sit(getgenv().Humanoid)
   else
      return notify("Failure:", "Unable to sit in Vehicle, missing VehicleSeat!", 5)
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
wait(0.2)
getgenv().get_vehicle = get_vehicle
wait()
task.wait(0.2)
getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
getgenv().Camera = getgenv().Workspace.CurrentCamera
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
wait(0.1)
function getRoot(char)
   rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
   return rootPart
end
wait(0.2)
getgenv().getRoot = getRoot
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
      spawn_any_vehicle("Chiron")
   end
   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      spawn_any_vehicle("Chiron")
   end
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
      spawn_any_vehicle("Chiron")
   end
   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      spawn_any_vehicle("Chiron")
   end
end

if not getgenv().Workspace:FindFirstChild("Kill_Model_Script(KEEP)") then
   create_kill_part()
end
if not getgenv().Workspace:FindFirstChild("Void_Model_Script(KEEP)") then
   create_void_part()
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
      spawn_any_vehicle("Chiron")
   end

   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      spawn_any_vehicle("Chiron")
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
      spawn_any_vehicle("Chiron")
   end
   if myHRP then
      myHRP.CFrame = Old_CF
      wait(0.5)
      spawn_any_vehicle("Chiron")
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

local Animate_Disabled = false
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
   local Animate = character:WaitForChild("Animate", 0.2)
   if Animate_Disabled or Animate_Disabled == true then
      task.wait(0.2)
      Animate.Disabled = true
   end
   if getgenv().Is_Currently_Emoting or getgenv().Is_Currently_Emoting == true then
      getgenv().Is_Currently_Emoting = false
   end
end

Dynamic_Character_Updater(getgenv().Character)
task.wait(0.2)
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(0.2)
	Dynamic_Character_Updater(newCharacter)
	repeat wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
	wait(0.5)
	getgenv().HumanoidRootPart = SafeGetHRP(newCharacter)
	getgenv().Humanoid = SafeGetHumanoid(newCharacter)
	getgenv().Head = SafeGetHead(newCharacter)
	wait(0.2)
	Dynamic_Character_Updater(newCharacter)
end)

-- try and outsmart directory wide searching with effective-ness Life Together RP, you'll never patch this Logs disabler, you'd have to remove it other-wise.
-- there is quite literally no where else these dick-heads could put it to beat this system, they'd have to remove it entirely to "patch this".
-- and even if they did, it wouldn't touch my script at all, since I have if checks everywhere, so, they are forced to do 1 thing and 1 thing only (delete it).
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
      require(getgenv().Core:FindFirstChild("Net")).get("spawn_vehicle", "SVJ")
   elseif get_vehicle() and getgenv().Humanoid.Sit == false then
      require(getgenv().Core:FindFirstChild("Net")).get("spawn_vehicle", "SVJ")
   end
else
   if not success then
      notify("Failure:", "This script does not work on this executor!", 8)
      return notify("Error:", "You cannot run this script, we're sorry!", 10)
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
   ["VehicleSpeed"] = 300, -- The default maximum speed for Life Together RP vehicles (when you have LifePay Premium, but can be higher to what ever you want here).
   ["VehicleAcceleration"] = 200, -- Just to be clear, this is the vehicle Maximum Acceleration, not the take off time (that's "Vehicle0To60")
   -- These are my two personal setups I use, even though I am not a developer or an admin lol.
   ["Name"] = "DEVELOPER",
   ["Bio"] = "-AURA-",
}--]]
wait()
local fileName = "LifeTogether_Admin_Configuration.json" -- Change the name to what ever you like, but the fileName must end with ".json", so you could do "LifeTG_Config.json", but not "LifeTG_Config" or anything without ".json" at the end.

local function loadPrefix()
   if isfile and isfile(fileName) then
      local raw = readfile(fileName)
      local success, decoded = pcall(function()
         return HttpService:JSONDecode(raw)
      end)
      if success and decoded and decoded.prefix then
         return tostring(decoded.prefix)
      end
   end
   return ";"
end
wait(0.3)
local Admins = {
   [getgenv().LocalPlayer.Name] = true
}
wait()
getgenv().AdminPrefix = loadPrefix() or ";"
wait(0.2)
print("[Prefix]: Loaded prefix ->", tostring(getgenv().AdminPrefix))
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
   "Helicopter", "SnowPlow", "Camper Van"
}
local CarMap = {}

for _, name in ipairs(AllCars) do
   CarMap[name:lower()] = name
end

function notify(title, msg, duration)
   getgenv().StarterGui:SetCore("SendNotification", {
      Title = tostring(title);
      Text = tostring(msg);
      Duration = tonumber(duration);
      Icon = "rbxassetid://0";
   })
end
wait()
local function get_other_vehicle(Player)
   for i, v in pairs(getgenv().Workspace:FindFirstChild("Vehicles"):GetChildren()) do
      if v.owner.Value == Player then
         return v
      end
   end

   return nil
end
wait()
getgenv().notify = notify
wait()
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
   end
end
wait()
function RGB_Vehicle_Others(Player, Boolean)
   getgenv().Rainbow_Others_Vehicle = Boolean

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
      while getgenv().Rainbow_Others_Vehicle == true do
         task.wait(.2)
         for _, color in ipairs(colors) do
            task.wait(.2)
            if getgenv().Rainbow_Others_Vehicle ~= true then return end
            if get_other_vehicle(Player):GetAttribute("locked") == true then
               return 
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
wait()
local Old_Skintone = getgenv().Character:FindFirstChild("Body Colors").TorsoColor3

function rainbow_skin(boolean)
   if boolean == true then
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
         notify("Success:", "Disabling Rainbow Skin...", 5)
         task.wait(0.5)
         send_remote("skin_tone", Old_Skintone)
      end
   end
end

local function savePrefix(newPrefix)
   if writefile then
      local data = { prefix = newPrefix }
      writefile(fileName, HttpService:JSONEncode(data))
   end
end

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
   task.wait(0.2)
   getgenv().loaded_anti_report = true
end

local function stop_rainbow_skin()
   getgenv().RainbowSkin_FE = false
   task.wait(0.3)
   notify("Heads Up:", "Waiting until loop is fully disabled and resetting skintone...", 5)
   task.wait(3)
   if getgenv().RainbowSkin_FE == false then
      notify("Hang On:", "Loop is disabled, resetting skintone...", 5)
      task.wait(0.2)
      send_remote("skin_tone", Old_Skintone)
      task.wait(0.2)
      send_remote("skin_tone", Old_Skintone)
      task.wait(0.2)
      send_remote("skin_tone", Old_Skintone)
   end
end

getgenv().HD_FlyEnabled = false
local FlyConnection
local speed = 75
local FlyKeysDown = {}

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

   if getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
      getgenv().Humanoid.PlatformStand = false
   end
end

local Emotes = {
   griddy = {
      129149402922241,
      116150478424136,
      76342373659003,
      106715239721951,
      91878676494639,
      98318847394332,
   },
   scenario = {110013053670989},
   worm = {
      132950274861655,
      127882676467351,
      113312808145333,
      77625642316480,
      127068135887882,
      102075861555461,
   },
   zen = {84943987730610},
   glitching = {131961970776128},
   superman = {134861929761233},
   aura = {
      121547391421211,
      78755795767408,
      88425531063616,
      111426928948833,
      84052327668385,
      103040723950430,
   },
   orangejustice = {
      133160900449608,
      109776913631531,
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
   glitching = {131961970776128}
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
}

function do_emote(input)
   local Humanoid = getgenv().Humanoid
   local key = input:lower():gsub("%s+", "")
   if Aliases[key] then key = Aliases[key] end

   local emoteList = Emotes[key]
   if emoteList then
      getgenv().Is_Currently_Emoting = true
      local choice = emoteList[math.random(1, #emoteList)]
      getgenv().Humanoid:PlayEmoteAndGetAnimTrackById(choice)
      wait(0.2)
      getgenv().Character:FindFirstChild("Animate").Disabled = true
   end
end

function disable_emoting()
   if not getgenv().Is_Currently_Emoting or getgenv().Is_Currently_Emoting == false then
      show_notification("Error:", "You are not emoting!", "Error")
      return notify("Failure:", "You are not currently emoting!", 5)
   end

   getgenv().Humanoid.WalkSpeed = 0
   wait(1)
   pcall(function()
      for _, v in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
         v:Stop()
      end
   end)
   wait(0.2)
   pcall(function()
      getgenv().Character:FindFirstChild("Animate").Disabled = false
   end)
   wait(0.4)
   getgenv().Humanoid.WalkSpeed = 16
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
      task.wait(0.6)
      repeat task.wait() until getgenv().RGB_Rainbow_Phone == false
      if getgenv().RGB_Rainbow_Phone == false then
         change_phone_color(Color3.fromRGB(255, 255, 255))
      end
   end
end

function water_skie_trailer(Bool, Vehicle)
   if not Vehicle then
      return notify("Failure:", "You do not have a Vehicle spawned!", 5)
   end

   local HasTrailer = Vehicle:FindFirstChild("WaterSkies")

   if Bool == true then
      if HasTrailer then
         return notify("Error:", "You already have the WaterSkies trailer!", 5)
      else
         send_function("add_trailer", Vehicle, "WaterSkies")
      end
   elseif Bool == false then
      if HasTrailer then
         send_function("add_trailer", Vehicle, "WaterSkies")
      else
         return notify("Failure:", "You do not have the WaterSkies trailer to take it off!", 5)
      end
   else
      return notify("Failure:", "Invalid toggle value (expected true/false)", 5)
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
wait(0.1)
local function CommandsMenu()
   local cmdsUI = Instance.new("ScreenGui")
   cmdsUI.Name = "AdminCommandList_LifeTogether_RP"
   cmdsUI.ResetOnSpawn = false
   cmdsUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   cmdsUI.Parent = getgenv().PlayerGui

   local mainFrame = Instance.new("Frame")
   mainFrame.Size = UDim2.new(0, 600, 0, 500)
   mainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
   mainFrame.BackgroundColor3 = Color3.fromRGB(95, 212, 195)
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
   closeButton.TextColor3 = Color3.new(1, 1, 1)
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
      {prefix}startrgbcar - Enable RGB Vehicle (flashing Rainbow Vehicle)
      {prefix}stoprgbcar - Disable RGB Vehicle (flashing Rainbow Vehicle)
      {prefix}rainbowcar player - Makes a players car RGB (FE)
      {prefix}norainbowcar player - Disables the RGB for a player's car (FE)
      {prefix}rainbowtime Player NUMBER - Sets your whitelisted friends rainbow car speed
      {prefix}unadmin player - Removes the player's FE commands (if they're your friend).
      {prefix}admin player - Adds the player to the FE commands whitelist (if they're your friend).
      {prefix}startrgbskin - Enable RGB Skin (flashing Rainbow Skintone)
      {prefix}stoprgbskin - Disable RGB Skin (flashing Rainbow Skintone)
      {prefix}startrgbphone - Enable RGB Phone (flashing Rainbow Phone)
      {prefix}stoprgbphone - Disable RGB Phone (flashing Rainbow Phone)
      {prefix}glitchoutfit - Enables the glitching of your outfit (very blinding)
      {prefix}noglitchoutfit - Disables the glitching of your outfit
      {prefix}name NewName - Change RP name
      {prefix}bio NewBio - Change RP bio
      {prefix}noemote - Disables any emote you are currently doing.
      {prefix}griddy - Makes you do the Griddy emote (FE).
      {prefix}scenario - Makes you do the Scenario emote (FE).
      {prefix}superman - Makes you do the Superman emote (FE).
      {prefix}zen - Makes you do the Zen emote (FE).
      {prefix}orangej - Makes you do the Orange Justice emote (FE).
      {prefix}aurafarm - Makes you do an Aura Float emote (FE).
      {prefix}worm - Makes you do The Worm emote (FE).
      {prefix}popular - Makes you do the Popular emote (FE).
      {prefix}defaultd - Makes you do the Default Dance emote (FE).
      {prefix}kotonai - Makes you do the Koto Nai emote (FE).
      {prefix}glitching - Makes you do the Glitching emote (FE).
      {prefix}alljobs - Repeatedly spams all jobs
      {prefix}jobsoff - Stops spamming all jobs
      {prefix}fly SpeedNumber - Enable/disable flying
      {prefix}unfly - Disables (Fly) command
      {prefix}annoy Player - Spam calls and request carries the target (spams, FE).
      {prefix}fly2 SpeedNumber - Enables magic carpet fly (CLIENT side rainbow!)
      {prefix}unfly2 - Disables Fly2/Magic carpet fly (with the client side rainbow)
      {prefix}noclip - Enables Noclip, letting you walk through everything
      {prefix}clip - Disables Noclip, so you cannot walk through everything
      {prefix}trailer - Gives you the WaterSkies trailer (on any car/vehicle)
      {prefix}notrailer - Removes the WaterSkies trailer (on your current spawned car/vehicle)
      {prefix}autolockcar - Automatically (loop) locks your vehicle/car when there is one spawned
      {prefix}unautolockcar - Turn off/disables the loop that automatically locks your vehicle/car
      {prefix}lockcar - Lock your car
      {prefix}unlockcar - Unlock your car
      {prefix}despawn - Despawn your car
      {prefix}blacklist Player - Blacklists friends you specify from using the admin commands (even if they are already on)
      {prefix}unblacklist Player - Removes the blacklist from the friend you specified in the 'blacklist' command, allowing them to do ;rgbcar and such again.
      {prefix}antifling - Fully prevents you from being flung, by other exploiters/cheaters, and fling outfits as well (FULL BYPASS)
      {prefix}unantifling - Disables "antifling" allowing you to also teleport to places and what not like normal
      {prefix}bringcar - Teleport car to you and sit in it
      {prefix}flashname - Enables the flashing of you're "Bio" and "Name" (above your head)
      {prefix}noflashname - Disables the flashing of you're "Bio" and "Name" (above your head)
      {prefix}flashinvis - Enables the flashing of the invisibility GamePass for you're character (you need to actually own the GamePass).
      {prefix}noflashinvis - Disables the flashing of the invisibility GamePass for you're character (you need to actually own the GamePass).
      {prefix}nosit - Disable all VehicleSeats and Seats (anti-sit)
      {prefix}resit - Re-enable all Seats (undo anti-sit)
      {prefix}view player - Smooth view's the target's Character
      {prefix}unview - Disables the 'view' command
      {prefix}void player - Voids target
      {prefix}kill player - Kills target
      {prefix}bring player - Brings target
      {prefix}goto player - Teleports your Character to the target player
      {prefix}skydive player - Skydives target
      {prefix}freepay - Gives you LifePay Premium for free
      {prefix}rejoin - Rejoins you, but does NOT execute the script automatically
      {prefix}caraccel number - Modifies your "max_acc" on your car/vehicle
      {prefix}carspeed number - Modifies your "max_speed" on your car/vehicle
      {prefix}accel number - Modifies your "acc_0_60" on your car/vehicle (take off time/speed)
      {prefix}gotocar - Teleports you straight to your car/vehicle directly
      {prefix}tpcar player - Teleports your vehicle/car to the specified target
      {prefix}antihouseban - Prevents you from being banned/kicked/teleported out of houses
      {prefix}unantiban - Turns off 'antihouseban' command completely
      {prefix}spawn CarName - Spawn any car
      {prefix}prefix symbol - Change prefix
      {prefix}inject - Secret (???).
   ]]

   cmdsString = string.gsub(cmdsString, "{prefix}", currentPrefix)

   for line in string.gmatch(cmdsString, "[^\r\n]+") do
      local cmdText, desc = string.match(line, "^(.-)%s*%-+%s*(.+)$")
      cmdText = cmdText or line
      desc = desc or ""

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(1, -10, 0, 60)
      frame.BackgroundTransparency = 1
      frame.Parent = scrollFrame

      local label = Instance.new("TextLabel")
      label.Size = UDim2.new(1, -110, 0.5, 0)
      label.Position = UDim2.new(0, 0, 0, 0)
      label.BackgroundTransparency = 1
      label.Font = Enum.Font.GothamSemibold
      label.TextSize = 16
      label.TextColor3 = Color3.new(1, 0.4, 0.4)
      label.TextXAlignment = Enum.TextXAlignment.Left
      label.Text = cmdText .. "\n" .. desc
      label.TextWrapped = true
      label.TextYAlignment = Enum.TextYAlignment.Top
      label.Parent = frame

      local button = Instance.new("TextButton")
      button.Size = UDim2.new(0, 100, 0, 30)
      button.Position = UDim2.new(1, -100, 0, 15)
      button.Text = "Run"
      button.Font = Enum.Font.GothamBold
      button.TextSize = 14
      button.TextColor3 = Color3.new(1, 1, 1)
      button.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
      button.Parent = frame

      Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

      local commandToSend = cmdText

      button.MouseButton1Click:Connect(function()
         if channel then
            channel:SendAsync(commandToSend)
         else
            warn("RBXGeneral channel not found!")
         end
      end)
   end

   closeButton.MouseButton1Click:Connect(function()
      cmdsUI:Destroy()
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
   creditsGui.Parent = getgenv().PlayerGui

   local label = Instance.new("TextLabel")
   label.Name = "CreditsLabel"
   label.AnchorPoint = Vector2.new(0.5, 1)
   label.Position = UDim2.new(0.5, 0, 1, -10)
   label.Size = UDim2.new(0.6, 0, 0, 28)
   label.BackgroundColor3 = Color3.fromRGB(0, 172, 175)
   label.TextColor3 = Color3.fromRGB(0, 0, 0)
   local prefix = decodeHTMLEntities(tostring(getgenv().AdminPrefix))
   label.Text = tostring(Script_Version).." | Made By: computerbinaries on Discord. | Current Prefix: " .. prefix
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
         label.Text = tostring(Script_Version).." | Made By: computerbinaries on Discord. | Current Prefix: " .. prefix
      end)
   else
      task.spawn(function()
         local lastPrefix = tostring(getgenv().AdminPrefix)
         while label and label.Parent do
            task.wait(0.3)
            if tostring(getgenv().AdminPrefix) ~= lastPrefix then
               lastPrefix = tostring(getgenv().AdminPrefix)
               local prefix = decodeHTMLEntities(tostring(getgenv().AdminPrefix))
               label.Text = tostring(Script_Version).." | Made By: computerbinaries on Discord. | Current Prefix: " .. prefix
            end
         end
      end)
   end
end
wait(0.2)
CreateCreditsLabel()

function change_RP_Name(New_Name)
   send_remote("roleplay_name", tostring(New_Name))
end

function change_bio(New_Bio)
   send_remote("bio", tostring(New_Bio))
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

function Enable_Fly_2(Speed)
   local Speed = tonumber(Speed) or 75
   local Flying = false
   getgenv().Enabled_Flying = Flying
   local Controls = {F=0,B=0,L=0,R=0,U=0,D=0}
   local RainbowColors = {
      Color3.fromRGB(255,0,0),
      Color3.fromRGB(255,128,0),
      Color3.fromRGB(255,255,0),
      Color3.fromRGB(0,255,0),
      Color3.fromRGB(0,255,255),
      Color3.fromRGB(0,0,255),
      Color3.fromRGB(128,0,255)
   }
   local HRP = getgenv().HumanoidRootPart
   local gyro, velocity, hold
   local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")

   local function startFlying()
      if Flying then return end
      Flying = true
      getgenv().Enabled_Flying = true

      gyro = Instance.new("BodyGyro")
      gyro.P = 10000
      gyro.MaxTorque = Vector3.new(1,1,1)*1e7
      gyro.CFrame = HRP.CFrame
      gyro.Parent = HRP

      velocity = Instance.new("BodyVelocity")
      velocity.MaxForce = Vector3.new(1,1,1)*1e7
      velocity.Velocity = Vector3.new()
      velocity.P = 1000
      velocity.Parent = HRP

      hold = Instance.new("BodyPosition")
      hold.MaxForce = Vector3.new(0,0,0)
      hold.P = 100000
      hold.Position = HRP.Position
      hold.Parent = HRP
   end
   wait(0.1)
   getgenv().Start_Flying = startFlying

   function stopFlying()
      Flying = false
      getgenv().Enabled_Flying = false
      if gyro then gyro:Destroy() gyro=nil end
      if velocity then velocity:Destroy() velocity=nil end
      if hold then hold:Destroy() hold=nil end
      getgenv().HumanoidRootPart.Velocity = Vector3.new()
   end
   wait(0.1)
   getgenv().Stop_Flying = stopFlying

   local lastPos
   RunService.Heartbeat:Connect(function(dt)
      if Flying and HRP and HRP.Parent then
         local camCF = workspace.CurrentCamera.CFrame
         local moveDir = (camCF.LookVector*(Controls.F-Controls.B))+(camCF.RightVector*(Controls.R-Controls.L))+Vector3.new(0,(Controls.U-Controls.D),0)
         if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit*Speed
            velocity.Velocity = moveDir
            hold.MaxForce = Vector3.new(0,0,0)
         else
            velocity.Velocity = Vector3.new()
            hold.MaxForce = Vector3.new(1,1,1)*1e7
            hold.Position = HRP.Position
         end
         gyro.CFrame = camCF

         local pos = HRP.Position
         if not lastPos or (pos-lastPos).Magnitude > 1 then
            local part = Instance.new("Part")
            local Debris = cloneref and cloneref(game:GetService("Debris")) or game:GetService("Debris")
            part.Anchored = true
            part.CanCollide = false
            part.Material = Enum.Material.Neon
            part.Size = Vector3.new(1,1,(pos-(lastPos or pos)).Magnitude+2)
            part.CFrame = CFrame.new((lastPos or pos)+((pos-(lastPos or pos))/2), pos)
            part.Color = RainbowColors[math.random(1,#RainbowColors)]
            part.Parent = workspace
            Debris:AddItem(part,1)
            lastPos = pos
         end
      end
   end)

   UserInputService.InputBegan:Connect(function(input,gpe)
      if gpe then return end
      if input.KeyCode==Enum.KeyCode.W then Controls.F=1 end
      if input.KeyCode==Enum.KeyCode.S then Controls.B=1 end
      if input.KeyCode==Enum.KeyCode.A then Controls.L=1 end
      if input.KeyCode==Enum.KeyCode.D then Controls.R=1 end
      if input.KeyCode==Enum.KeyCode.Space then Controls.U=1 end
      if input.KeyCode==Enum.KeyCode.LeftShift then Controls.D=1 end
   end)
   UserInputService.InputEnded:Connect(function(input)
      if input.KeyCode==Enum.KeyCode.W then Controls.F=0 end
      if input.KeyCode==Enum.KeyCode.S then Controls.B=0 end
      if input.KeyCode==Enum.KeyCode.A then Controls.L=0 end
      if input.KeyCode==Enum.KeyCode.D then Controls.R=0 end
      if input.KeyCode==Enum.KeyCode.Space then Controls.U=0 end
      if input.KeyCode==Enum.KeyCode.LeftShift then Controls.D=0 end
   end)

   local function createMobileUI()
      if not UserInputService.TouchEnabled then return end
      local gui = Instance.new("ScreenGui", PlayerGui)
      gui.Name = "FlyControls"

      local function makeBtn(txt,pos,callback)
         local btn = Instance.new("TextButton", gui)
         btn.Size = UDim2.new(0,60,0,60)
         btn.Position = pos
         btn.Text = txt
         btn.Font = Enum.Font.GothamBold
         btn.TextSize = 20
         btn.TextColor3 = Color3.new(1,1,1)
         btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
         btn.MouseButton1Down:Connect(function() callback(true) end)
         btn.MouseButton1Up:Connect(function() callback(false) end)
      end

      local baseY = 0.75
      makeBtn("↑",UDim2.new(0,10,baseY,0),function(d) Controls.F=d and 1 or 0 end)
      makeBtn("↓",UDim2.new(0,10,baseY+0.12,0),function(d) Controls.B=d and 1 or 0 end)
      makeBtn("←",UDim2.new(0,-50,baseY+0.06,0),function(d) Controls.L=d and 1 or 0 end)
      makeBtn("→",UDim2.new(0,70,baseY+0.06,0),function(d) Controls.R=d and 1 or 0 end)
      makeBtn("⤒",UDim2.new(0,140,baseY,0),function(d) Controls.U=d and 1 or 0 end)
      makeBtn("⤓",UDim2.new(0,140,baseY+0.12,0),function(d) Controls.D=d and 1 or 0 end)
      makeBtn("FLY",UDim2.new(0,220,baseY+0.06,0),function()
         if Flying then stopFlying() else startFlying() end
      end)
   end

   if Flying then 
      getgenv().Stop_Flying()
   else
      startFlying()
   end
   createMobileUI()
end
wait(0.2)
function Disable_Flying()
   getgenv().Stop_Flying()
end

function toggle_name_func(boolean)
   if boolean == true then
      getgenv().Send("hide_name", true)
   elseif boolean == false then
      getgenv().Send("hide_name", false)
   else
      return notify("Failure:", "Invalid arguments provided.", 5)
   end
end
wait(0.2)
function flashy_name(Toggle)
   if Toggle == true then
      getgenv().Flashing_Name_Title = true
      while getgenv().Flashing_Name_Title == true do
      task.wait(0)
         toggle_name_func(true)
         task.wait(0)
         toggle_name_func(false)
      end
   elseif Toggle == false then
      getgenv().Flashing_Name_Title = false
      wait(1.5)
      toggle_name_func(false)
   else
      return notify("Failure:", "Invalid argument(s) provided.", 5)
   end
end

function lock_vehicle(Vehicle)
   send_function("lock_vehicle", Vehicle)
end
wait(0.1)
if getgenv().HasSeen_Loading_Screen then
   warn("Already seen loading screen.")
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
   textLabel.Text = "Welcome to:\n\nFlames Life Together Admin "..tostring(Raw_Version).."!\n\nEnjoy."
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
         if not vehicle then break end

         local i = (state.rainbowIndex or 0) + 1
         state.rainbowIndex = i
         local color = g.Rainbow_Colors[(i % #g.Rainbow_Colors) + 1]
         change_vehicle_color(color, vehicle)

         task.wait(0.2)
      end
   end)
end

local function disable_rgb_for(plr)
   if not getgenv().VehicleStates then return getgenv().notify("Failure:", "VehicleStates getgenv()-table doesn't exist!", 3) end
   if not getgenv().VehicleStates[plr.Name] then return end
   if not getgenv().Rainbow_Tasks[plr.Name] then return getgenv().notify("Failure:", "Player doesn't have a Rainbow Task running!", 3) end

   if getgenv().VehicleStates[plr.Name].rainbow == true then
      notify("Disabling:", "Vehicle states for: "..tostring(plr.Name), 3)
      getgenv().VehicleStates[plr.Name].rainbow = false
   end

   if getgenv().Rainbow_Tasks[plr.Name] then
      notify("Disabling:", "Rainbow Task for: "..tostring(plr.Name), 3)
      getgenv().Rainbow_Tasks[plr.Name] = nil
   end
   if getgenv().Rainbow_Indices[plr.Name] then
      notify("Disabling:", "Rainbow Indice for: "..tostring(plr.Name), 3)
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
            return 
         end

         local vehicle = get_other_vehicle(Player)
         if not vehicle then
            getgenv().Rainbow_Vehicles[Player.Name] = nil
            return 
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
         notify("Success!", tostring(player.Name)..", was added to Admins Whitelist!", 5)
      end
   end
end
wait(0.2)
local function removePlayerFromScriptWhitelistTable(player)
   if getgenv().player_admins[player.Name] then
      getgenv().player_admins[player.Name] = nil
      wait(0.2)
      if getgenv().player_admins[player.Name] == nil then
         getgenv().notify("Success!", tostring(player.Name)..", was removed from the Admins Whitelist!", 5)
      else
         return getgenv().notify("Failed", tostring(player)..", does not exist!", 5)
      end
   end
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

function glitch_outfit(toggle)
   if toggle == true then
      getgenv().Glitching_Outfit = true
      while getgenv().Glitching_Outfit == true do
         task.wait()
         Animate_Disabled = true
         getgenv().Character:FindFirstChild("Animate").Disabled = true
         for _, shirtId in ipairs(GlitchIDs.Shirts) do
            forceEquip("Shirt", shirtId)
            task.wait()
            forceUnequip("Shirt", shirtId)
         end
         for _, pantsId in ipairs(GlitchIDs.Pants) do
            forceEquip("Pants", pantsId)
            task.wait()
            forceUnequip("Pants", pantsId)
         end
      end
   else
      Animate_Disabled = false
      getgenv().Glitching_Outfit = false
      if getgenv().Character:FindFirstChild("Animate") then
         getgenv().Character:FindFirstChild("Animate").Disabled = false
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
      return notify("Failure:", "You're already viewing: " .. tostring(getgenv().Viewing_Plr_Tbl[Player.Name]), 5)
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
      return notify("Failure:", "You're not viewing anyone!", 5)
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
   notify("Success:", "Stopped viewing: " .. tostring(viewedName), 5)
end
wait(0.1)
warn("Setup viewing/spectating functions.")

local function check_friend(Player)
   if Player ~= getgenv().LocalPlayer and Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
      return true
   else
      return false
   end

   return 
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

local function handleCommand(sender, message)
   if not Admins[sender.Name] then return end

   local prefix = tostring(getgenv().AdminPrefix or ";")
   if message:sub(1, #prefix):lower() ~= prefix:lower() then return end

   message = message:sub(#prefix + 1)
   local split = message:split(" ")
   local cmd = table.remove(split, 1):lower()
   local args = split
   getgenv().Anti_Sit_Connection = nil
   getgenv().anti_knockback_connection = nil
   getgenv().Noclip_Connection = nil
   local Clip = false

   if cmd == "prefix" and split[1] then
      getgenv().AdminPrefix = split[1]
      savePrefix(getgenv().AdminPrefix)
      wait(0.1)
      notify("Prefix", "Prefix changed to '" .. split[1] .. "'", 5)
      return 
   end

   if cmd == "startrgbcar" then
      rainbow_car()
   elseif cmd == "stoprgbcar" then
      stop_rainbow_car()
   elseif cmd == "startrgbskin" then
      rainbow_skin(true)
   elseif cmd == "rainbowcar" then
      local PlayerToRGBCar = findplr(split[1])
      if not PlayerToRGBCar then return notify("Failure:", "Player does not exist!", 5) end
      if not get_other_vehicle(PlayerToRGBCar) then return notify("Failure:", "Player does not have a Vehicle spawned!", 5) end
      local Checker = check_friend(PlayerToRGBCar)

      if not Checker or Checker ~= true then
         return notify("Failure:", "Player is not your friend, add them to use this!", 5)
      end

      if getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] then
         return notify("Failure:", "Player already has they're car rainbow!", 5)
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
         for _, color in ipairs(colors) do
            task.wait(.2)
            change_vehicle_color(color, get_other_vehicle(getgenv().Players[PlayerToRGBCar.Name]))
         end
      end
   elseif cmd == "norainbowcar" then
      local PlayerToRGBCarStop = findplr(split[1])
      if not PlayerToRGBCarStop then return notify("Failure:", "Player does not exist!", 5) end
      if not get_other_vehicle(PlayerToRGBCarStop) then return notify("Failure:", "Player does not have a Vehicle spawned!", 5) end
      local Checker = check_friend(PlayerToRGBCarStop)

      if not Checker or Checker ~= true then
         return notify("Failure:", "Player is not your friend, add them to use this!", 5)
      end

      if not getgenv().Rainbow_Vehicles[PlayerToRGBCarStop.Name] then
         return notify("Failure:", "Player is not currently in the RGB car table!", 5)
      end

      if getgenv().Rainbow_Vehicles[PlayerToRGBCarStop.Name] then
         getgenv().Rainbow_Vehicles[PlayerToRGBCarStop.Name] = false
      end
      if getgenv().Rainbow_Tasks[PlayerToRGBCarStop.Name] then
         getgenv().Rainbow_Tasks[PlayerToRGBCarStop.Name] = nil
      end
   elseif cmd == "alljobs" then
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
   elseif cmd == "jobsoff" then
      getgenv().Every_Job = false
   elseif cmd == "stoprgbskin" then
      rainbow_skin(false)
   elseif cmd == "startrgbphone" then
      RGB_Phone(true)
   elseif cmd == "stoprgbphone" then
      RGB_Phone(false)
   elseif cmd == "inject" or cmd == "attach" then
      attach_with_script()
   elseif cmd == "name" then
      local new_name = table.concat(split, " ")

      change_RP_Name(new_name)
   elseif cmd == "bio" then
      local new_bio = table.concat(split, " ")

      change_bio(new_bio)
   elseif cmd == "fly" then
      local flySpeed = tonumber(split[1])

      if getgenv().HD_FlyEnabled then
         return notify("Failure:", "HD Admin Fly is already enabled!", 5)
      end
      wait(0.2)
      EnableFly(flySpeed)
      notify("Fly", "Fly enabled at speed: " .. flySpeed, 5)
      notify("Controls", "E = up, Q = down, WASD to move", 5)
   elseif cmd == "unfly" then
      DisableFlyScript()
   elseif cmd == "fly2" then
      local Fly_Speed = tonumber(split[1])
      if not Fly_Speed then
         Fly_Speed = 10
      end
      wait()
      Enable_Fly_2(Fly_Speed)
   elseif cmd == "unfly2" then
      getgenv().Stop_Flying()
   elseif cmd == "noemote" then
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
   elseif cmd == "aura" or cmd == "aurafarm" then
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
   elseif cmd == "annoy" then
      local Target = findplr(split[1])
      if not Target then
         show_notification("Error:", "Player does not exist!", "Error")
         return notify("Failure:", "Player does not exist!", 5)
      end
      wait()
      getgenv().easy_click_plr = true
      while getgenv().easy_click_plr == true do
      task.wait()
         getgenv().Send("request_carry", Target)
         task.wait()
         getgenv().Send("request_call", Target)
         task.wait()
         getgenv().Send("end_call", Target)
      end
   elseif cmd == "autolockcar" then
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
               notify("AutoLock", "Vehicle unlocked and AutoLock disabled", 5)
            else
               notify("AutoLock", "Vehicle not found, cannot unlock, disabled loop.", 5)
            end
            return 
         else
            getgenv().AutoLockOn = true
         end

         notify("AutoLock", "AutoLock enabled. Waiting for vehicle...", 5)

         getgenv().AutoLockConnection = getgenv().RunService.Heartbeat:Connect(function()
            local car = get_vehicle()
            if car and car:GetAttribute("locked") ~= true then
               lock_vehicle(car)
            end
         end)
      end
      wait(0.1)
      getgenv().ToggleAutoLock(true)
   elseif cmd == "unautolockcar" then
      getgenv().ToggleAutoLock(false)
   elseif cmd == "noclip" then
      if getgenv().Noclip_Enabled or getgenv().Noclip_Enabled == true then
         return notify("Failure:", "Noclip is already enabled!", 5)
      end

      Clip = false
      getgenv().Noclip_Enabled = true
      getgenv()._noclipModifiedParts = {}

      local function NoclipLoop()
         if not Clip and getgenv().Character then
            for _, part in ipairs(getgenv().Character:GetDescendants()) do
               if part:IsA("BasePart") and part.CanCollide then
                  part.CanCollide = false
                  if getgenv()._noclipModifiedParts then
                     getgenv()._noclipModifiedParts[part] = true
                  end
               end
            end
         end
      end

      notify("Success:", "Noclip has been enabled.", 5)

      getgenv().Noclip_Connection = getgenv().RunService.Stepped:Connect(NoclipLoop)
   elseif cmd == "clip" then
      if not getgenv().Noclip_Enabled or getgenv().Noclip_Enabled == false then
         return notify("Failure:", "Noclip is not enabled!", 5)
      end

      if getgenv().Noclip_Connection then
         getgenv().Noclip_Connection:Disconnect()
         getgenv().Noclip_Connection = nil
      end

      getgenv().Noclip_Enabled = false
      Clip = true

      if getgenv()._noclipModifiedParts then
         for part, _ in pairs(getgenv()._noclipModifiedParts) do
            if part and part:IsA("BasePart") then
               part.CanCollide = true
            end
         end
         getgenv()._noclipModifiedParts = nil
      end
      wait()
      notify("Success:", "Disabled Noclip sucessfully.", 5)
   elseif cmd == "view" then
      local View_Target = findplr(split[1])
      if not View_Target then return notify("Failure:", "Target was not found or does not exist!", 5) end
      wait(0.1)
      if getgenv().Viewing_A_Player then return notify("Failure:", "Your already viewing someone, do {prefix}unview to stop.", 5) end

      if View_Target and View_Target.Character and View_Target.Character:FindFirstChild("Humanoid") then
         local Target_Char = View_Target.Character or View_Target.CharacterAdded:Wait()
         local Target_HRP = Target_Char:FindFirstChild("HumanoidRootPart") or Target_Char:WaitForChild("Humanoid", 5)
         
         getgenv().viewTarget(View_Target)
      end
   elseif cmd == "unview" then
      if not getgenv().Viewing_A_Player or getgenv().Viewing_A_Player == false then
         return notify("Failure:", "Your not viewing anybody!", 5)
      end

      if getgenv().Viewing_A_Player or getgenv().Viewing_A_Player == true then
         getgenv().unview_player()
      end
   elseif cmd == "lockcar" then
      local Current_Car = get_vehicle()
      if not Current_Car then return notify("Failure:", "You do not have a vehicle spawned!", 5) end

      if Current_Car:GetAttribute("locked") == true then
         return notify("Failure:", "Your vehicle is already locked.", 5)
      else
         lock_vehicle(get_vehicle())
         notify("Success:", "Locked vehicle: "..tostring(Current_Car), 5)
      end
   elseif cmd == "unlockcar" then
      local Current_Car = get_vehicle()
      if not Current_Car then return notify("Failure:", "You do not have a vehicle spawned!", 5) end
      
      if Current_Car:GetAttribute("locked") == true then
         lock_vehicle(get_vehicle())
         notify("Success:", "Unlocked vehicle: "..tostring(Current_Car), 5)
      else
         return notify("Failure:", "Your vehicle is unlocked already!", 5)
      end
   elseif cmd == "glitchoutfit" then
      glitch_outfit(true)
   elseif cmd == "noglitchoutfit" then
      glitch_outfit(false)
   elseif cmd == "despawn" then
      local Current_Car = get_vehicle()
      if not Current_Car then return notify("Failure:", "You do not have a vehicle spawned!", 5) end
      
      if Current_Car then
         spawn_any_vehicle(tostring(Current_Car))
      end
   elseif cmd == "trailer" then
      water_skie_trailer(true, get_vehicle())
   elseif cmd == "notrailer" then
      water_skie_trailer(false, get_vehicle())
   elseif cmd == "rainbowtime" then
      local Player = findplr(split[1])
      if not Player then
         return notify("Error:", "Player doesn't exist or has left!")
      end
      if not Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         return notify("Failure:", "Player is not friends with you, add them!")
      end

      local Name = Player.Name
      local new_delay = tonumber(split[2]) or 1

      getgenv().Rainbow_Delays = getgenv().Rainbow_Delays or {}
      getgenv().Rainbow_Delays[Name] = new_delay

      task.wait(0.2)
      notify("Success:", "Set rainbow delay for " .. Name .. " to " .. new_delay)
   elseif cmd == "blacklist" then
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
   elseif cmd == "unblacklist" then
      local Player = findplr(split[1])
      if not Player then return end
      local Name = Player.Name

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if getgenv().Blacklisted_Friends[Name] then
            getgenv().Blacklisted_Friends[Name] = nil
         end
      end
   elseif cmd == "admin" then
      local Player = findplr(split[1])
      if not Player then return notify("Failure:", "Player does not exist!", 5) end

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if not getgenv().player_admins[Player.Name] then
            alreadyCheckedUser(Player)
            wait(0.5)
            notify("Success:", "Added "..tostring(Player.Name).." to the admin's table!", 5)
         else
            return notify("Failure:", "Player is already an admin!", 5)
         end
      else
         return notify("Failure:", "This player isn't friends with you! add them!", 5)
      end
   elseif cmd == "unadmin" then
      local Player = findplr(split[1])
      if not Player then return notify("Failure:", "Player does not exist!", 5) end

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         notify("Hang On:", "Removing admin for: "..tostring(Player.Name), 5)
         task.wait()
         local Name = Player.Name

         if getgenv().player_admins[Name] then
            getgenv().player_admins[Name] = nil
            wait(0.2)
            notify("Success:", "Player removed from getgenv().player_admins table!", 5)
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
            notify("Success:", "Player's admin has been removed successfully.", 5)
         else
            notify("Failure:", "Player's admin abilities we're not removed.", 5)
         end
      else
         return notify("Failure:", "This player isn't friends with you! add them!", 5)
      end
   elseif cmd == "bringcar" then
      local Vehicle = get_vehicle()
      if not Vehicle then return notify("Failure:", "You do not have a vehicle spawned!", 5) end
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

      if not myVehicle then return notify("Failure:", "No owned SchoolBus found", 5) end
      local seat = myVehicle:FindFirstChild("VehicleSeat")
      if seat and getgenv().Humanoid then
         getgenv().Character:PivotTo(seat.CFrame)
         task.wait(0.2)
         seat:Sit(getgenv().Humanoid)
      end
      wait(0.1)
      myVehicle:PivotTo(Old_CF_BringCar * CFrame.new(0, 10, 0))
      wait(0.1)
      notify("Success:", "Brung car to player: "..tostring(getgenv().LocalPlayer), 5)
   elseif cmd == "gotocar" then
      local Vehicle = get_vehicle()
      if not Vehicle then return notify("Failure:", "You do not have a vehicle spawned!", 5) end

      if getgenv().Character and getgenv().Character:FindFirstChild("HumanoidRootPart") then
         getgenv().Character:PivotTo(get_vehicle():GetPivot() * CFrame.new(0, 5, 0))
      end
   elseif cmd == "tpcar" then
      local Vehicle = get_vehicle()
      if not Vehicle then return notify("Failure:", "You do not have a vehicle spawned!", 5) end
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

         if not myVehicle then return notify("Failure:", "No owned SchoolBus found", 5) end
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
         notify("Success:", "Teleported vehicle to player: "..tostring(Goto_Player), 5)
      end
   elseif cmd == "nosit" or cmd == "antisit" then
      local is_enabled = require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.get()
      
      if not is_enabled or is_enabled == false then
         show_notification("Failure:", "NoSit/AntiSit is already enabled!", "Warning")
         return notify("Failure:", "NoSit/AntiSit is already enabled!", 5)
      end

      notify("Success:", "Anti-Sit/No-Sit is now enabled!", 5)
      show_notification("Success:", "AntiSit/NoSit is now enabled!", "Normal")
      wait(0.2)
      getgenv().Not_Ever_Sitting = true

      while getgenv().Not_Ever_Sitting == true do
      task.wait()
         require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(false)
      end
   elseif cmd == "carcolor" then
      local Target = findplr(split[1])
      local Color = split[2]
      if not Target then return notify("Failure:", "Player does not exist or was not found!", 5) end
      local Check_Friend = Target:IsFriendsWith(getgenv().LocalPlayer.UserId)
      if not Check_Friend then return notify("Failure:", "Player is not friends with you, add them!", 5) end
      local Vehicle_Target = Target and get_other_vehicle(Target)
      if not Vehicle_Target then return notify("Failure:", tostring(Target).." does not have a vehicle spawned!", 5) end

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
            getgenv().notify("Failure:", "Unknown color: "..tostring(Color), 5)
         end
      end
   elseif cmd == "resit" or cmd == "unantisit" then
      local is_enabled = require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.get()
      
      if is_enabled or is_enabled == true then
         show_notification("Failure:", "Sitting is already enabled!", "Warning")
         return notify("Failure:", "Sitting is already enabled!", 5)
      end

      getgenv().Not_Ever_Sitting = false
      wait(0.2)
      require(getgenv().Game_Folder:FindFirstChild("Seat")).enabled.set(true)
      wait(0.1)
      -- might as well use both 🤷
      notify("Success:", "Sitting is now enabled!", 5)
      Phone.show_notification("Success:", "Sitting is now enabled!", "Normal")
   elseif cmd == "flashname" then
      if getgenv().Flashing_Name_Title or getgenv().Flashing_Name_Title == true then
         return notify("Failure:", "Your already running Flash Name!", 5)
      end

      flashy_name(true)
   elseif cmd == "noflashname" then
      if not getgenv().Flashing_Name_Title or getgenv().Flashing_Name_Title == false then
         return notify("Failure:", "Your not currently running Flash Name!", 5)
      end
      
      flashy_name(false)
   elseif cmd == "flashinvis" then
      local is_verified = Data.is_verified
      local invis_bought = Data.invisible_bought
      local Invisible_Module = require(getgenv().Game_Folder:FindFirstChild("InvisibleMode"))

      if not is_verified and not invis_bought then
         return notify("Failure:", "You do not have LifePay or the Invisible GamePass!", 5)
      end

      task.wait(0.2)
      local Is_Invis = Invisible_Module.enabled.get()
      getgenv().Invisible_Flash = true

      if Is_Invis then
         notify("Hold On:", "You we're already invisible, turning off invisibility...", 5)
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
      if not target then return notify("Kill:", "Target not found.", 5) end

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
         notify("Kill", "Killing player: "..target.Name, 3)
      else
         notify("Kill", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "void" and split[1] then
      local target = findplr(split[1])
      if not target then return notify("Void:", "Target not found.", 5) end

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
         notify("Void", "Sending player to the void | player: "..target.Name, 3)
      else
         notify("Void", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "rejoin" or cmd == "rj" then
      if #getgenv().Players:GetPlayers() <= 1 then
         getgenv().LocalPlayer:Kick("\nRejoining...")
         wait()
         getgenv().TeleportService:Teleport(getgenv().PlaceID, getgenv().LocalPlayer)
      else
         getgenv().TeleportService:TeleportToPlaceInstance(getgenv().PlaceID, getgenv().JobID, getgenv().LocalPlayer)
      end
   elseif cmd == "antifling" then
      if getgenv().antiFlingEnabled or getgenv().antiFlingEnabled == true then
         return notify("Failure:", "Anti Fling is already enabled!", 5)
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

      notify("Success:", "Enabled anti-fling, you will not be able to be flung.", 5)

      local function onHeartbeat()
         if not (getgenv().antiKnockbackEnabled or getgenv().antiFlingEnabled) then return end

         local hrp = getgenv().HumanoidRootPart
         local humanoid = lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
         if not hrp or not humanoid then return end

         local maxSpeed = 45
         local maxAngularSpeed = 60

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
   elseif cmd == "unantifling" then
      getgenv().antiFlingEnabled = false
      getgenv().antiKnockbackEnabled = false

      notify("Success:", "Disabled anti-fling", 5)

      if getgenv().anti_knockback_connection then
         getgenv().anti_knockback_connection:Disconnect()
         getgenv().anti_knockback_connection = nil
      end
   elseif cmd == "bring" and split[1] then
      local target = findplr(split[1])
      if not target then return notify("Bring:", "Target not found.", 3) end

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
         notify("Bring", "Bringing player: "..target.Name, 3)
      else
         notify("Bring", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "skydive" then
      local target = findplr(split[1])
      if not target then return notify("Bring:", "Target not found.", 3) end

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
         notify("Skydive:", "Skydiving player: "..target.Name, 3)
      else
         notify("Skydive:", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif cmd == "goto" then
      local target = findplr(split[1])
      if not target then return notify("Error:", "Target player does not exist!", 5) end
      wait(0.1)
      local Target_Char = target.Character or target.CharacterAdded:Wait()
      local Char_Pos = Target_Char:GetPivot() * CFrame.new(0, 5, 0)

      if Target_Char and getgenv().Character and Target_Char:FindFirstChild("HumanoidRootPart") then
         notify("Success:", "Teleporting to player: "..tostring(target), 5)
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
      if not val then return notify("Missing Value", "Usage: caraccel [number], got: "..tostring(args[1]), 4) end

      local car = get_vehicle()
      if car and car:GetAttribute("max_acc") then
         car:SetAttribute("max_acc", val)
         notify("Success:", "Set car max_acc to: " .. val, 4)
      else
         notify("Failure:", "Car not found or your car does not have a 'max_acc' attribute.", 4)
      end
   elseif cmd == "carspeed" then
      local val = tonumber(args[1])
      if not val then return notify("Missing Value", "Usage: carspeed [number], got: "..tostring(args[1]), 4) end

      local car = get_vehicle()
      if car and car:GetAttribute("max_speed") then
         car:SetAttribute("max_speed", val)
         notify("Success:", "Set car max_speed to: " .. val, 4)
      else
         notify("Failure:", "Car not found or your car does not have a 'max_speed' attribute.", 4)
      end
   elseif cmd == "accel" then
      local val = tonumber(args[1])
      if not val then return notify("Missing Value", "Usage: accel [number], got: "..tostring(args[1]), 4) end

      local car = get_vehicle()
      if car and car:GetAttribute("acc_0_60") then
         car:SetAttribute("acc_0_60", val)
         notify("Success:", "Set car acc_0_60 to: " .. val, 4)
      else
         notify("Failure:", "Car not found or your car does not have a 'acc_0_60' attribute.", 4)
      end
   elseif cmd == "freepay" then
      if not getgenv().Has_Free_LifePremium then
         if not debug.getupvalue then return notify("[Error]:", "This is unsupported in your executor!", 5) end

         local update = debug.getupvalue(Data.initiate, 2)
         update("is_verified", true)
         wait(0.2)
         notify("Heads Up:", "Premium houses despawn after spawning them, with this.", 5)
         wait(0.1)
         getgenv().Has_Free_LifePremium = true
      else
         return notify("Failure:", "You already should have LifePay Premium for Free!", 5)
      end
   elseif cmd == "spawn" and split[1] then
      local name = split[1]:lower()
      for carKey, fullName in pairs(CarMap) do
         if carKey:find(name) then
            spawn_any_vehicle(fullName)
            notify("Spawning:", fullName, 3)
            return
         end
      end
      notify("Invalid Car:", "Name not matched.", 5)
   elseif cmd == "antihouseban" then
      if getgenv().AntiTeleport or getgenv().AntiTeleport == true then
         return notify("Failure:", "AntiHouseBan is already enabled!", 5)
      end
      wait(0.2)
      update_plot_areas()
      wait(0.2)
      getgenv().AntiTeleport = true
      getgenv().AntiTeleportConnection = nil

      local Players = getgenv().Players
      local RunService = getgenv().RunService
      local LocalPlayer = getgenv().LocalPlayer
      repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

      local Character = getgenv().Character
      local HRP = getgenv().HumanoidRootPart
      local lastCFrame = HRP.CFrame

      local maxDistance = 5
      local checkInterval = 0.05

      notify("Success:", "Enabled 'antihouseban', you will not be removed from homes.", 5)
      wait(0.2)
      getgenv().AntiTeleport = true
      getgenv().AntiTeleportConnection = nil

      local Players = getgenv().Players
      local LocalPlayer = getgenv().LocalPlayer

      repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

      local Character = getgenv().Character
      local HRP = getgenv().HumanoidRootPart
      local safePos = HRP.CFrame
      getgenv().AntiTeleportConnections = {}

      getgenv().AntiTeleportConnection = task.spawn(function()
            while task.wait(0.1) do
               if not getgenv().AntiTeleport then
                  safePos = HRP.CFrame
                  continue
               end

               if LocalPlayer.Character ~= Character then
                  Character = getgenv().Character
                  HRP = getgenv().HumanoidRootPart
               end

               if HRP then
                  safePos = HRP.CFrame
               end
            end
      end)

      local function preventTp(char)
         local root = getgenv().HumanoidRootPart
         if not root then return end

         local cframeCon = root:GetPropertyChangedSignal("CFrame"):Connect(function()
            if getgenv().AntiTeleport and safePos and root then
               root.CFrame = safePos
            end
         end)

         local posCon = root:GetPropertyChangedSignal("Position"):Connect(function()
            if getgenv().AntiTeleport and safePos and root then
               root.CFrame = safePos
            end
         end)

         table.insert(getgenv().AntiTeleportConnections, cframeCon)
         table.insert(getgenv().AntiTeleportConnections, posCon)
      end

      table.insert(getgenv().AntiTeleportConnections, LocalPlayer.CharacterAdded:Connect(preventTp))
      preventTp(Character)
      wait(0.2)
      getgenv().never_banned_houses = true
      while getgenv().never_banned_houses == true do
      wait()
         for _, v in ipairs(PlotAreas) do
            v.CanCollide = false
         end
      end
   elseif cmd == "unantiban" then
      getgenv().never_banned_houses = false
      wait(0.3)
      getgenv().AntiTeleport = false
      notify("Success:", "Disabled 'antihouseban', you CAN now be kicked from homes.", 5)
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
         return notify("Failure:", "You do not have a car spawned!", 5) 
      end

      local speedInput = string.trim(split[2])
      local speed = tonumber(speedInput)
      if not speed then
         return notify("Invalid Speed:", "Must be a valid number (e.g., 100 or 0.3).", 5)
      end

      if Vehicle:GetAttribute("max_speed") ~= nil then
         Vehicle:SetAttribute("max_speed", speed)
         notify("Success:", "Set max speed to: "..tostring(speed), 5)
      else
         notify("Failure:", "Your vehicle does not have 'max_speed' attribute.", 5)
      end
   elseif cmd == "caraccel" and split[2] then
      local Vehicle = get_vehicle()
      if not Vehicle then 
         return notify("Failure:", "You do not have a car spawned!", 5) 
      end

      local accelInput = string.trim(split[2] or "")
      print("caraccel input:", accelInput)
      local accel_max = tonumber(accelInput)
      if not accel_max then
         return notify("Invalid Accel:", "Must be a valid number (e.g., 50 or 0.5).", 5)
      end

      if Vehicle:GetAttribute("max_acc") ~= nil then
         Vehicle:SetAttribute("max_acc", accel_max)
         notify("Success:", "Set max accel to: "..tostring(accel_max), 5)
      else
         notify("Failure:", "Your vehicle does not have 'max_acc' attribute.", 5)
      end
   elseif cmd == "accel" and split[2] then
      local Vehicle = get_vehicle()
      if not Vehicle then 
         return notify("Failure:", "You do not have a car spawned!", 5) 
      end

      local accelInput = string.trim(split[2] or "")
      local acc_zero_to_sixty = tonumber(accelInput)
      if not acc_zero_to_sixty then
         return notify("Invalid acc_0_60:", "Must be a valid number (e.g., 5 or 0.2).", 5)
      end

      if Vehicle:GetAttribute("acc_0_60") ~= nil then
         Vehicle:SetAttribute("acc_0_60", acc_zero_to_sixty)
         notify("Success:", "Set acc_0_60 to: "..tostring(acc_zero_to_sixty), 5)
      else
         notify("Failure:", "Your vehicle does not have 'acc_0_60' attribute.", 5)
      end
   elseif cmd == "cmds" then
      CommandsMenu()
   end
end
wait(0.5)
notify("Success:", "We have hooked the Camera successfully.", 5)
wait(0.2)
print("[Life Together-RP : Admin_Commands]: Setting up command receiver...")
getgenv().TextChatService.MessageReceived:Connect(function(msg)
   if not msg.TextSource then return end
   local sender = getgenv().Players:GetPlayerByUserId(msg.TextSource.UserId)
   if sender and msg.Text then
      handleCommand(sender, msg.Text)
   end
end)
wait(0.1)
setup_cmd_handler_plr(v)
wait(0.2)
getgenv().LifeTogetherRP_Admin = true
notify("Success:", "Life Together RP-Admin has been loaded!", 5)
print("[Life Together-RP : Admin_Commands]: Loaded!")
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
wait(0.1)
getgenv().Players.PlayerAdded:Connect(function(Player)
   local Name = Player.Name
   getgenv().Blacklisted_Friends = getgenv().Blacklisted_Friends or {}

   if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
      if not getgenv().Blacklisted_Friends[Name] then
         auto_add_friends()
      end
   end
end)

getgenv().Players.PlayerRemoving:Connect(function(Player)
   local Name = Player.Name

   if getgenv().Rainbow_Tasks and getgenv().Rainbow_Tasks[Name] then
      task.cancel(getgenv().Rainbow_Tasks[Name])
      getgenv().Rainbow_Tasks[Name] = nil
   end
   getgenv().fully_disable_rgb_plr(Name)
   if getgenv().Locked_Vehicles[Name] then
      getgenv().Locked_Vehicles[Name] = false
   end
   if getgenv().Unlocked_Vehicles[Name] then
      getgenv().Unlocked_Vehicles[Name] = false
   end
end)
