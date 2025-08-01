getgenv().Game = game
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId
local Script_Version = "V2.4.6-LifeAdmin"

if getgenv().LifeTogetherRP_Admin then
   return 
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
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
wait(0.2)
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

wait()
function vehicle_bring_player(TargetPlayer)
   if not TargetPlayer or not TargetPlayer.Character then return end
   local targetChar = TargetPlayer.Character
   local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
   if not targetHRP then return end

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
	wait(0.2)
	Dynamic_Character_Updater(newCharacter)
end)
wait(0.5)
local success, response = pcall(function()
   local Net = require(getgenv().Core:FindFirstChild("Net"))

   Net.get("spawn_vehicle", "SVJ")
   wait(3)

   return get_vehicle()
end)

if success and response then
   print("[✅] This script CAN run in this executor! Got successful response: "..tostring(response).." [✅]")
   wait(1)
   if get_vehicle() and getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
      getgenv().Humanoid:ChangeState(3)
      wait(0.2)
      require(getgenv().Core:FindFirstChild("Net")).get("spawn_vehicle", "SVJ")
   elseif get_vehicle() and getgenv().Humanoid.Sit == false then
      require(getgenv().Core:FindFirstChild("Net")).get("spawn_vehicle", "SVJ")
   end
else
   warn("[❌] | Vehicle spawn failed | Failed Response | [❌]")
   if not success then
      notify("Failure:", "This script does not work on this executor!", 8)
      return notify("Error:", "You cannot run this script, we're sorry!", 10)
   end
end
wait()
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
   ["Name"] = "Server-Admin",
   ["Bio"] = "Developer",
}--]]
wait()
local fileName = "LifeTogether_Admin_Configuration.json"

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
         wait(0)
         for _, color in ipairs(colors) do
            wait(0)
            if getgenv().Rainbow_Others_Vehicle ~= true then return end
            if get_other_vehicle(Player):GetAttribute("locked") == true then
               
            end
            change_vehicle_color(color, Player)
         end
      end
   elseif Boolean == false then
      getgenv().Rainbow_Others_Vehicle = false
      Boolean = false
   end
end
wait()
local Old_Skintone = getgenv().Character:FindFirstChild("Body Colors").TorsoColor3

function rainbow_skin(boolean)
   if boolean == true then
      getgenv().RainbowSkin_FE = true
      while getgenv().RainbowSkin_FE == true do
         wait()
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
            wait()
         end
      end
   else
      getgenv().RainbowSkin_FE = false
      wait(1)
      repeat task.wait() until getgenv().RainbowSkin_FE == false
      if getgenv().RainbowSkin_FE == false then
         notify("Success:", "Disabling Rainbow Skin...", 5)
         wait(0.5)
         send_remote("skin_tone", Old_Skintone)
      end
   end
end

local function savePrefix(newPrefix)
    if writefile then
        local data = { prefix = newPrefix }
        writefile(fileName, HttpService:JSONEncode(data))
    else
        warn("Your executor does not support 'writefile'")
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
    wait(0.1)
    getgenv().loaded_anti_report = true
end

local function stop_rainbow_skin()
   getgenv().RainbowSkin_FE = false
   wait(0.3)
   notify("Heads Up:", "Waiting until loop is fully disabled and resetting skintone...", 5)
   wait(3)
   if getgenv().RainbowSkin_FE == false then
      notify("Hang On:", "Loop is disabled, resetting skintone...", 5)
      wait()
      send_remote("skin_tone", Old_Skintone)
      wait(0.2)
      send_remote("skin_tone", Old_Skintone)
      wait(0.2)
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

function change_phone_color(New_Color)
   send_remote("phone_color", New_Color)
end
wait(0.2)
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
      repeat wait() until Boolean == false
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
   local HRP = getgenv().HumanoidRootPart
   local Humanoid = getgenv().Humanoid
   local Camera = getgenv().Camera
   local RunService = getgenv().RunService
   local UserInputService = getgenv().UserInputService

   getgenv().HD_FlyEnabled = true

   FlyKeysDown = {W = false, A = false, S = false, D = false, E = false, Q = false}

   UserInputService.InputBegan:Connect(function(input, gameProcessed)
      if gameProcessed then return end
      local key = input.KeyCode
      if FlyKeysDown[key.Name] ~= nil then
         FlyKeysDown[key.Name] = true
      end
   end)

   UserInputService.InputEnded:Connect(function(input)
      local key = input.KeyCode
      if FlyKeysDown[key.Name] ~= nil then
         FlyKeysDown[key.Name] = false
      end
   end)

   local function GetInputDirection(cam)
      local dir = Vector3.zero
      if FlyKeysDown.W then dir += cam.CFrame.LookVector end
      if FlyKeysDown.S then dir -= cam.CFrame.LookVector end
      if FlyKeysDown.D then dir += cam.CFrame.RightVector end
      if FlyKeysDown.A then dir -= cam.CFrame.RightVector end
      if FlyKeysDown.E then dir += cam.CFrame.UpVector end
      if FlyKeysDown.Q then dir -= cam.CFrame.UpVector end
      return dir.Magnitude > 0 and dir.Unit or Vector3.zero
   end

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

   FlyConnection = RunService.Heartbeat:Connect(function(dt)
      if not getgenv().HD_FlyEnabled then
         bodyGyro:Destroy()
         bodyPos:Destroy()
         Humanoid.PlatformStand = false
         FlyConnection:Disconnect()
         return
      end

      local direction = GetInputDirection(Camera)
      local move = direction * speed * dt

      bodyPos.Position += move
      bodyGyro.CFrame = CFrame.new(HRP.Position, HRP.Position + Camera.CFrame.LookVector)
   end)
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
   mainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
   mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
   mainFrame.BorderSizePixel = 0
   mainFrame.Active = true
   mainFrame.Draggable = true
   mainFrame.Parent = cmdsUI

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

   local padding = Instance.new("UIPadding")
   padding.PaddingTop = UDim.new(0, 5)
   padding.PaddingLeft = UDim.new(0, 5)
   padding.PaddingRight = UDim.new(0, 5)
   padding.PaddingBottom = UDim.new(0, 5)
   padding.Parent = scrollFrame

   local currentPrefix = getgenv().AdminPrefix

   local cmdsString = [[
      {prefix}startrgbcar - Enable RGB Vehicle (flashing Rainbow Vehicle)

      {prefix}stoprgbcar - Disable RGB Vehicle (flashing Rainbow Vehicle)
      
      {prefix}rainbowcar [player] - Makes a players car RGB (FE!)

      {prefix}norainbowcar [player] - Disables the RGB for a player's car (FE!)

      {prefix}unadmin [player] - Removes the player's FE commands (if they're your friend).

      {prefix}admin [player] - Adds the player to the FE commands whitelist (if they're your friend).

      {prefix}startrgbskin - Enable RGB Skin (flashing Rainbow Skintone)

      {prefix}stoprgbskin - Disable RGB Skin (flashing Rainbow Skintone)

      {prefix}startrgbphone - Enable RGB Phone (flashing Rainbow Phone)

      {prefix}stoprgbphone - Disable RGB Phone (flashing Rainbow Phone)

      {prefix}name [new name] - Change RP name

      {prefix}bio [bio] - Change RP bio

      {prefix}fly [speed] - Enable/disable flying

      {prefix}unfly - Disables (Fly) command

      {prefix}noclip - Enables Noclip, letting you walk through everything

      {prefix}clip - Disables Noclip, so you cannot walk through everything

      {prefix}trailer - Gives you the WaterSkies trailer (on any car/vehicle)

      {prefix}notrailer - Removes the WaterSkies trailer (on your current spawned car/vehicle)

      {prefix}autolockcar - Automatically (loop) locks your vehicle/car when there is one spawned

      {prefix}unautolockcar - Turn off/disables the loop that automatically locks your vehicle/car

      {prefix}lockcar - Lock your car

      {prefix}unlockcar - Unlock your car

      {prefix}despawn - Despawn your car

      {prefix}antifling - Fully prevents you from being flung, by other exploiters/cheaters, and fling outfits as well (FULL BYPASS)

      {prefix}unantifling - Disables "antifling" allowing you to also teleport to places and what not like normal

      {prefix}bringcar - Teleport car to you and sit in it

      {prefix}flashname - Enables the flashing of your "Bio" and "Name" (above your head)

      {prefix}noflashname - Disables the flashing of your "Bio" and "Name" (above your head)

      {prefix}nosit / {prefix}antisit - Disable all VehicleSeats and Seats (anti-sit)

      {prefix}resit / {prefix}unantisit - Re-enable all Seats (undo anti-sit)

      {prefix}view [player] - Smooth view's the target's Character

      {prefix}unview - Disables the 'view' command

      {prefix}void [player] - Voids target

      {prefix}kill [player] - Kills target

      {prefix}bring [player] - Brings target

      {prefix}goto [player] - Teleports your Character to the target player

      {prefix}skydive [player] - Skydives target

      {prefix}freepay - Gives you LifePay Premium for free

      {prefix}rejoin / {prefix}rj - Rejoins you, but does NOT execute automatically

      {prefix}caraccel [number] - Modifies your "max_acc" on your car/vehicle

      {prefix}carspeed [number] - Modifies your "max_speed" on your car/vehicle

      {prefix}accel [number] - Modifies your "acc_0_60" on your car/vehicle (take off time/speed)

      {prefix}gotocar - Teleports you straight to your car/vehicle directly

      {prefix}tpcar [player] - Teleports your vehicle/car to the specified target

      {prefix}antihouseban - Prevents you from being banned/kicked/teleported out of houses

      {prefix}unantiban - Turns off 'antihouseban' command completely

      {prefix}spawn [carName] - Spawn any car

      {prefix}prefix [symbol] - Change prefix

      {prefix}inject / {prefix}attach - Secret (???).
   ]]

   cmdsString = string.gsub(cmdsString, "{prefix}", currentPrefix)
   wait(0.1)
   local cmdsText = Instance.new("TextLabel")
   cmdsText.Size = UDim2.new(1, -10, 0, 0)
   cmdsText.Position = UDim2.new(0, 0, 0, 0)
   cmdsText.TextWrapped = true
   cmdsText.TextYAlignment = Enum.TextYAlignment.Top
   cmdsText.TextColor3 = Color3.fromRGB(255, 0, 0)
   cmdsText.TextSize = 18
   cmdsText.BackgroundTransparency = 1
   cmdsText.Font = Enum.Font.GothamBold
   cmdsText.FontSize = Enum.FontSize.Size18
   cmdsText.TextXAlignment = Enum.TextXAlignment.Left
   cmdsText.Text = cmdsString
   cmdsText.Parent = scrollFrame

   local TextService = cloneref and cloneref(game:GetService("TextService")) or game:GetService("TextService")
   local function updateTextSize()
      local textSize = TextService:GetTextSize(
         cmdsText.Text,
         cmdsText.TextSize,
         cmdsText.Font,
         Vector2.new(scrollFrame.AbsoluteSize.X - 20, math.huge)
      )
      cmdsText.Size = UDim2.new(1, -10, 0, textSize.Y)
   end

   task.wait()
   updateTextSize()

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
   label.BackgroundColor3 = Color3.fromRGB(175, 0, 0)
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
      wait(0)
         toggle_name_func(true)
         wait(0)
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
wait()
getgenv().player_admins = getgenv().player_admins or {}
getgenv().friend_checked = getgenv().friend_checked or {}
getgenv().cmds_loaded_plr = getgenv().cmds_loaded_plr or {}
getgenv().Rainbow_Vehicles = getgenv().Rainbow_Vehicles or {}
getgenv().Locked_Vehicles = getgenv().Locked_Vehicles or {}
getgenv().Unlocked_Vehicles = getgenv().Unlocked_Vehicles or {}
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

   local function chat_reply(speaker, msg)
      if channel then
         channel:SendAsync("/w " .. tostring(speaker.DisplayName) .. " " .. msg .. " (this message was automatically sent)")
      end
   end

   TextChatService.MessageReceived:Connect(function(chatMessage)
      local speaker = chatMessage.TextSource
      if not (speaker and speaker.Name ~= localPlayerName and getgenv().player_admins[speaker.Name]) then return end

      local normalizedMessage = trim(chatMessage.Text:lower())
      if normalizedMessage:sub(1, #prefix) ~= prefix then return end

      local command = normalizedMessage:sub(#prefix + 1)
      local playerVehicle = get_other_vehicle(getgenv().Players[speaker.Name])

      if levenshtein(command, "rgbcar") <= 2 then
         if not playerVehicle then
            getgenv().Rainbow_Vehicles[speaker.Name] = false
            return chat_reply(speaker, "you don't got a vehicle")
         end

         getgenv().Rainbow_Vehicles[speaker.Name] = true
         local colors = {
            Color3.fromRGB(255, 255, 255), Color3.fromRGB(128, 128, 128), Color3.fromRGB(0, 0, 0),
            Color3.fromRGB(0, 0, 255), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 255, 255),
            Color3.fromRGB(255, 165, 0), Color3.fromRGB(139, 69, 19), Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(50, 205, 50), Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 155, 172),
            Color3.fromRGB(128, 0, 128),
         }

         task.spawn(function()
            while getgenv().Rainbow_Vehicles[speaker.Name] do
               for _, color in ipairs(colors) do
                  if not getgenv().Rainbow_Vehicles[speaker.Name] then return end
                  local v = get_other_vehicle(getgenv().Players[speaker.Name])
                  if v then
                     change_vehicle_color(color, v)
                  else
                     getgenv().Rainbow_Vehicles[speaker.Name] = false
                  end
                  task.wait(0.1)
               end
            end
         end)
      elseif levenshtein(command, "norgbcar") <= 2 then
         getgenv().Rainbow_Vehicles[speaker.Name] = false
      elseif levenshtein(command, "lockcar") <= 2 then
         if not playerVehicle then
            getgenv().LockLoop_Vehicles[speaker.Name] = false
            return chat_reply(speaker, "you don't got a vehicle")
         end

         getgenv().Unlocked_Vehicles[speaker.Name] = false
         getgenv().Locked_Vehicles[speaker.Name] = true

         task.spawn(function()
            while getgenv().Locked_Vehicles[speaker.Name] do
               task.wait()
               local v = get_other_vehicle(getgenv().Players[speaker.Name])
               if v and not v:GetAttribute("locked") then
                  getgenv().Get("lock_vehicle", v)
               elseif not v then
                  getgenv().Locked_Vehicles[speaker.Name] = false
               end
            end
         end)
      elseif levenshtein(command, "unlockcar") <= 2 then
         if not playerVehicle then
            getgenv().Unlocked_Vehicles[speaker.Name] = false
            return chat_reply(speaker, "you don't got a vehicle")
         end

         getgenv().Locked_Vehicles[speaker.Name] = false
         getgenv().Unlocked_Vehicles[speaker.Name] = true

         task.spawn(function()
            while getgenv().Unlocked_Vehicles[speaker.Name] do
               task.wait()
               local v = get_other_vehicle(getgenv().Players[speaker.Name])
               if v and v:GetAttribute("locked") then
                  getgenv().Get("lock_vehicle", v)
               elseif not v then
                  getgenv().Unlocked_Vehicles[speaker.Name] = false
               end
            end
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

      getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] = true

      --[[local colors = {
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

      while getgenv().Rainbow_Others_Vehicle == true do
         wait(0)
         for _, color in ipairs(colors) do
            wait(0)
            if getgenv().Rainbow_Others_Vehicle ~= true then return end
            change_vehicle_color(color, get_other_vehicle(getgenv().Players[PlayerToRGBCar.Name]))
         end
      end--]]
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

      getgenv().Rainbow_Vehicles[PlayerToRGBCarStop.Name] = false
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
      local flySpeed = tonumber(split[1]) or 100

      if getgenv().HD_FlyEnabled then
         return notify("Failure:", "HD Admin Fly is already enabled!", 5)
      end
      wait(0.2)
      EnableFly(flySpeed)
      notify("Fly", "Fly enabled at speed: " .. flySpeed, 5)
      notify("Controls", "E = up, Q = down, WASD to move", 5)
   elseif cmd == "unfly" then
      DisableFlyScript()
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
   elseif cmd == "despawn" then
      local Current_Car = get_vehicle()
      if not Current_Car then return notify("Failure:", "You do not have a vehicle spawned!", 5) end

      if Current_Car.Name ~= "Chiron" then
         spawn_any_vehicle("Chiron")
         wait(0.2)
         spawn_any_vehicle("Chiron")
      elseif Current_Car.Name == "Chiron" then
         spawn_any_vehicle("Chiron")
      end
   elseif cmd == "trailer" then
      water_skie_trailer(true, get_vehicle())
   elseif cmd == "notrailer" then
      water_skie_trailer(false, get_vehicle())
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
      if getgenv().Anti_Sit_Enabled then
         return notify("Error:", "You've already enabled no-sit!", 5)
      end

      local function handleSeat(seat)
         if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
            seat.CanCollide = false
            seat.Disabled = true
            seat:SetAttribute("Disabled", true)
         end
      end

      local function scanAndHandle(instance)
         handleSeat(instance)
         for _, child in ipairs(instance:GetDescendants()) do
            handleSeat(child)
         end
      end

      notify("Success:", "Successfully enabled 'anti-sit'!", 5)
      getgenv().Anti_Sit_Enabled = true

      for _, v in ipairs(getgenv().Workspace:GetDescendants()) do
         handleSeat(v)
      end

      getgenv().Anti_Sit_Connection = getgenv().Workspace.DescendantAdded:Connect(function(v)
         if getgenv().Anti_Sit_Enabled then
            scanAndHandle(v)
         end
      end)
   elseif cmd == "resit" or cmd == "unantisit" then
      if not getgenv().Anti_Sit_Enabled or getgenv().Anti_Sit_Enabled == false then
         return notify("Failure:", "Anti Sit is not enabled!", 5)
      end

      getgenv().Anti_Sit_Enabled = false

      if getgenv().Anti_Sit_Connection then
         getgenv().Anti_Sit_Connection:Disconnect()
         getgenv().Anti_Sit_Connection = nil
      end

      for _, v in ipairs(Workspace:GetDescendants()) do
         if v:IsA("Seat") or v:IsA("VehicleSeat") then
            v.CanCollide = true
            v.Disabled = false
            v:SetAttribute("Disabled", false)
         end
      end
      wait()
      notify("Success:", "Successfully disabled 'anti-sit'!", 5)
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
               pcall(function()
                  HRP.CFrame = lastCFrame
               end)
            else
               lastCFrame = HRP.CFrame
            end
         end
      end)
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
      pcall(function()
         task.cancel(getgenv().AntiTeleportConnection)
         getgenv().AntiTeleportConnection = nil
      end)
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
   auto_add_friends()
end)

getgenv().Players.PlayerRemoving:Connect(function(Player)
   if getgenv().Rainbow_Vehicles[Player.Name] then
      getgenv().Rainbow_Vehicles[Player.Name] = false
   end
   if getgenv().Locked_Vehicles[Player.Name] then
      getgenv().Locked_Vehicles[Player.Name] = false
   end
   if getgenv().Unlocked_Vehicles[Player.Name] then
      getgenv().Unlocked_Vehicles[Player.Name] = false
   end
end)
