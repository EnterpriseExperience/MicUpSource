getgenv().Game = cloneref and cloneref(game) or game
wait()
if not getgenv().Game:IsLoaded() then
   getgenv().Game.Loaded:Wait()
end

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/Notification_Lib.lua"))()
local Handler_API = "https://raw.githubusercontent.com/EnterpriseExperience/FakeChatGUI/main/handler.lua"
local Configuration_API = "https://raw.githubusercontent.com/EnterpriseExperience/RushTeam/main/configuration.lua"
local config_path = "Flames_BerryAve_Admin_Config.json"
local Raw_Version = "V1.2.0"
local Script_Creator = "computerbinaries"
local Announcement_Message = "."
local displayTimeMax = 30
local cmdsString = [[
   {prefix}rgbcar - Enables RGB/Rainbow Vehicle (FE).
   {prefix}unrgbcar - Disables RGB/RainbowVehicle.
   {prefix}hlspam - Flashes your Headlights (FE).
   {prefix}unhlspam - Disables headlight flasher.
   {prefix}fly Speed - Enables Fly (FE).
   {prefix}unfly - Disables Fly.
   {prefix}spawn CarName - Spawns the requested Vehicle (FE).
   {prefix}spawnhouse HouseName - Allows you to spawn a house (FE).
   {prefix}delhouse - Deletes/removes your house (FE).
   {prefix}tphouse Player - Teleports you to the target players house (FE).
   {prefix}jobspam - Enables Job Spammer (FE).
   {prefix}unjobspam - Disables Job Spammer (FE).
   {prefix}gotohouse - Teleports you to your house (if you have one, FE).
   {prefix}lockcar - Locks your Vehicle (FE).
   {prefix}unlockcar - Unlocks your Vehicle (FE).
   {prefix}despawn - Despawns your currently spawned Vehicle (FE).
   {prefix}cmds - Lists/shows all the available commands.
]]
wait(0.1)
getgenv().cmdsString = cmdsString

local function decodeHTMLEntities(str)
   return str:gsub("&gt;", ">")
            :gsub("&lt;", "<")
            :gsub("&amp;", "&")
            :gsub("&quot;", '"')
            :gsub("&#39;", "'")
end
wait(0.1)
getgenv().decodeHTMLEntities = decodeHTMLEntities

local function retrieve_executor()
   local name
   if identifyexecutor then
      name = identifyexecutor()
   end
   return { Name = name or "Unknown Executor" }
end

local function identify_executor()
   local executorDetails = retrieve_executor()
   return tostring(executorDetails.Name)
end

wait(0.1)
local executor_string = identify_executor()

local function executor_contains(substr)
   if type(executor_string) ~= "string" then
      return false
   end

   return string.find(string.lower(executor_string), string.lower(substr), 1, true) ~= nil
end

if executor_contains("LX63") then
   function notify(notif_type, msg, duration)
      NotifyLib:StarterGui_Notify(tostring(notif_type), tostring(msg), tonumber(duration))
   end
   wait(0.1)
   getgenv().notify = notify
else
   function notify(notif_type, msg, duration)
      NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration))
   end
   wait(0.1)
   getgenv().notify = notify
end

if not executor_contains("LX63") then
   local set_fps = setfpscap or setfps

   if setfpscap or setfps then
      set_fps(999)
   end
end
wait()
if getgenv().Game.PlaceId ~= 8481844229 then
   return NotifyLib:External_Notification("Error", "This is not Berry Avenue RP! You cannot run this here!", 6)
end
task.wait(0.1)
getgenv().Script_Loaded_Correctly_BerryAve_Admin_Flames_Hub = getgenv().Script_Loaded_Correctly_BerryAve_Admin_Flames_Hub or false
local Script_Version = tostring(Raw_Version).."-BerryAveAdmin"
getgenv().Script_Version_GlobalGenv = Script_Version

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

if not getgenv().PreRequisites_Loaded then
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Zacks_Easy_Hub/refs/heads/main/other_actors.lua'))()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Zacks_Easy_Hub/refs/heads/main/TextChatServce.lua'))()
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Zacks_Easy_Hub/refs/heads/main/feedback_handler.lua'))()
   wait(0.2)
   getgenv().PreRequisites_Loaded = true
end

wait()

if getgenv().BerryAvenue_Admin and getgenv().Script_Loaded_Correctly_BerryAve_Admin_Flames_Hub == false then
   getgenv().BerryAvenue_Admin = false
   return getgenv().notify("Error", "Berry Avenue Admin appears to not have loaded correctly, try re-running the script and trying again.", 6)
elseif getgenv().BerryAvenue_Admin and getgenv().Script_Loaded_Correctly_BerryAve_Admin_Flames_Hub then
   return getgenv().notify("Warning", "Berry Avenue Admin is already running!", 5)
end
wait(0.3)
local function isProperty(inst, prop)
	local s, r = pcall(function() return inst[prop] end)
	if not s then return nil end
	return r
end
wait(0.1)
getgenv().isProperty = isProperty

local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local fileName = "BerryAvenue_Admin_Configuration.json"
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

local function loadPrefix()
   local defaultPrefix = "."
   local data = { prefix = defaultPrefix }

   if isfile and isfile(fileName) then
      local success, decoded = pcall(function()
         return HttpService:JSONDecode(readfile(fileName))
      end)

      if success and type(decoded) == "table" and decoded.prefix then
         local prefix = tostring(decoded.prefix)
         if prefix == "symbol" or not isAllowedPrefix(prefix) then
            getgenv().notify("Info", "We've automatically modified your Prefix, it was broken or not an allowed Prefix.", 7)
            decoded.prefix = defaultPrefix
            writefile(fileName, HttpService:JSONEncode(decoded))
            return defaultPrefix
         else
            return prefix
         end
      end
   end

   writefile(fileName, HttpService:JSONEncode(data))
   return defaultPrefix
end
wait(0.1)
getgenv().loadPrefix = loadPrefix

local function savePrefix(newPrefix)
   if writefile then
      local data = { prefix = newPrefix }
      writefile(fileName, HttpService:JSONEncode(data))
   end
end
wait(0.1)
getgenv().savePrefix = savePrefix

local function hasProp(inst, prop)
   return inst and isProperty(inst, prop) ~= nil
end
wait(0.1)
getgenv().hasProp = hasProp

local function setProperty(inst, prop, v)
	local s, _ = pcall(function() inst[prop] = v end)
	return s
end
wait(0.1)
getgenv().setProperty = setProperty

local function safeSet(inst, prop, val)
   if inst and hasProp(inst, prop) then setProperty(inst, prop, val) end
end
wait(0.1)
getgenv().safeSet = safeSet

if not getgenv().All_Services_Initialized then
   local function exec_ls(url)
      local FormattedURL = tostring(url)

      return loadstring(game:HttpGet(FormattedURL))()
   end
   wait(0.1)
   getgenv().exec_ls = exec_ls
   wait(0.6)
   getgenv().notify("Success", "Initializing framework and libraries necessary for Berry Avenue Admin...", 6)
   function exec_lib(Name)
      local Formatted_Library = tostring(Name)

      exec_ls("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/main/"..Formatted_Library)
   end
   wait(0.3)
   exec_lib("GlobalEnv_Framework.lua")
   wait(0.5)
   exec_lib("TextChatService_MessageConnection.lua")
   wait(0.1)
   exec_lib("BillboardGui_Framework.lua")
   wait(0.2)
   exec_lib("TextChatService_Unsuspension_Framework.lua")
   wait(0.2)
   exec_lib("Dex_Explorer_Checker.lua")
   wait(0.2)
   exec_lib("Error_Handler_Framework.lua")
   wait(0.3)
   getgenv().All_Services_Initialized = true
   wait(1)
   if getgenv().All_Services_Initialized then
      getgenv().notify("Success", "Framework and libraries have been initialized.", 6)
   else
      getgenv().notify("Warning", "Not sure if all our Framework has been initialized properly.", 6)
   end
end
wait(0.1)
local ReplicatedStorage = getgenv().ReplicatedStorage
local Packages_Folder = ReplicatedStorage:FindFirstChild("Packages", true) or ReplicatedStorage:WaitForChild("Packages", 5)
local IndexFolder = Packages_Folder:FindFirstChild("_Index", true) or Packages_Folder:WaitForChild("_Index", 5)
local sleit_knick = IndexFolder:FindFirstChild("sleitnick_knit@1.4.4", true) or IndexFolder:WaitForChild("sleitnick_knit@1.4.4", 5)
local KnitModule = sleit_knick:FindFirstChild("knit", true) or sleit_knick:WaitForChild("knit", 5)
local ServicesFolder = KnitModule:FindFirstChild("Services", true) or KnitModule:WaitForChild("Services", 5)
getgenv().ServicesFolder = ServicesFolder
wait(0.2)

local function safeInvoke(remote)
   local ok, result = pcall(function()
      return remote:InvokeServer()
   end)
   if ok and type(result) == "table" then
      return result
   else
      getgenv().notify("Error", "Failed to invoke PlayerService.GetData: "..tostring(result), 10)
      return {}
   end
end

-- define all services and their subfolders before-hand --
if not getgenv()._KnitServices_Initialized then
   for _, service in ipairs(ServicesFolder:GetChildren()) do
      if service:IsA("Folder") then
         local baseName = service.Name
         local RF = service:FindFirstChild("RF", true)
         local RE = service:FindFirstChild("RE", true)

         if RF then
            local rfName = baseName .. "_RF"
            getgenv()[rfName] = RF
         end

         if RE then
            local reName = baseName .. "_RE"
            getgenv()[reName] = RE
         end
      end
   end

   local total = 0
   for name, value in pairs(getgenv()) do
      if typeof(value) == "Instance" and (value:IsA("RemoteEvent") or value:IsA("RemoteFunction")) then
         total += 1
      end
   end

   getgenv().notify("Success", "Knit services initialized ("..total.." remotes)", 5)
   getgenv()._KnitServices_Initialized = true
end

-- service finder function --
getgenv().find_service = function(service_name, subfolder)
   local s = ServicesFolder:FindFirstChild(tostring(service_name) .. "Service", true)
   if not s then
      if getgenv().notify then
         getgenv().notify("Error", "Service not found: " .. tostring(service_name), 5)
      end
      return nil
   end
   if subfolder and (subfolder == "RF" or subfolder == "RE") then
      return s:FindFirstChild(subfolder, true)
   end
   return s
end

getgenv().Network_Sender = function(remoteName, ...)
   local args = {...}
   local remoteInstance = nil

   if typeof(remoteName) ~= "string" then
      return 
   end

   for _, service in ipairs(getgenv().ServicesFolder:GetChildren()) do
      if service:IsA("Folder") then
         local rf = service:FindFirstChild("RF", true)
         local re = service:FindFirstChild("RE", true)

         if rf then
            local found = rf:FindFirstChild(remoteName, true)
            if found then
               remoteInstance = found
               break
            end
         end

         if re and not remoteInstance then
            local found = re:FindFirstChild(remoteName, true)
            if found then
               remoteInstance = found
               break
            end
         end
      end
   end

   if not remoteInstance then
      getgenv().notify("Error", "⚠️ Remote not found in any Knit service ⚠️: "..tostring(remoteName), 65)
      return nil
   end

   if remoteInstance:IsA("RemoteEvent") then
      local ok, err = pcall(function()
         remoteInstance:FireServer(unpack(args))
      end)
      if not ok then
         getgenv().notify("Error", "⚠️ Failed to FireServer ⚠️: "..tostring(err), 5)
      end
   elseif remoteInstance:IsA("RemoteFunction") then
      local ok, result = pcall(function()
         return remoteInstance:InvokeServer(unpack(args))
      end)
      if not ok then
         getgenv().notify("Error", "⚠️ Failed to InvokeServer ⚠️: "..tostring(result), 5)
         return nil
      end

      return result
   else
      getgenv().notify("Error", "⚠️ Found instance is not a RemoteEvent or RemoteFunction ⚠️: "..tostring(remoteInstance), 6)
   end
end
wait(1)
local Plots = {
   "Plot1",
   "Plot2",
   "Plot3",
   "Plot4",
   "Plot5",
   "Plot6",
   "Plot7",
   "Plot8",
   "Plot9",
   "Plot10",
   "Plot11",
   "Plot12",
   "Plot13",
   "Plot14",
   "Plot15",
   "Plot16",
   "Plot17",
   "Plot18",
   "Plot19",
   "Plot20",
   "Plot21",
   "Plot22",
}
wait(0.2)
if not getgenv().AllPlotNames then
   getgenv().AllPlotNames = Plots
end

if not getgenv().AllVehicleNames then
   getgenv().AllVehicleNames = {
      "Chevy3100",
      "PumpkinCarriage",
      "ATV",
      "Ambulance",
      "BasketBike",
      "Bug",
      "Bugatti",
      "Bus",
      "C1Barbie",
      "C4Barbie",
      "Caddy",
      "CadillacV16",
      "ChargerBaby",
      "Convertible",
      "ExplorerPolice",
      "Fiat",
      "Firetruck",
      "GWagon",
      "GolfCart",
      "Helicopter",
      "IceCreamVan",
      "Impala",
      "Jeep",
      "KiddyBike",
      "KidsBike",
      "Lambo",
      "Lawnmower",
      "Limo",
      "LittleTikes",
      "MailVan",
      "Merc",
      "Merc107",
      "Model3Baby",
      "Moped",
      "Motorhome",
      "Odyssey",
      "Phantom",
      "Polaris",
      "PoliceBike",
      "PoliceCharger",
      "Porsche",
      "RamRTX",
      "RangeRover",
      "SamuraiBaby",
      "SportBike",
      "Spy",
      "Taxi",
      "Taycan",
      "Tesla",
      "Testa",
      "VWBus",
      "Volkswaggy",
      "Z8"
   }

   getgenv().notify("Success", "Initialized all: "..tostring(#getgenv().AllVehicleNames).." vehicles.", 5)
end

if not getgenv().AllVehicleColors then
   getgenv().AllVehicleColors = {
      Color3.new(0, 0, 0),
      Color3.new(1, 1, 1),
      Color3.new(0.5, 0.5, 0.5),
      Color3.new(0.2, 0.2, 0.2),
      Color3.new(0.8, 0.8, 0.8),
      Color3.new(1, 0, 0),
      Color3.new(0.5, 0, 0),
      Color3.new(1, 0.4, 0.7),
      Color3.new(1, 0.5, 0),
      Color3.new(0.8, 0.3, 0),
      Color3.new(1, 1, 0),
      Color3.new(1, 0.84, 0),
      Color3.new(0, 1, 0),
      Color3.new(0, 0.5, 0),
      Color3.new(0.7, 1, 0),
      Color3.new(0.5, 0.5, 0),
      Color3.new(0, 0, 1),
      Color3.new(0, 0, 0.5),
      Color3.new(0.4, 0.7, 1),
      Color3.new(0, 1, 1),
      Color3.new(0, 0.5, 0.5),
      Color3.new(0.5, 0, 0.5),
      Color3.new(0.6, 0.2, 1),
      Color3.new(1, 0, 1),
      Color3.new(0.4, 0.2, 0),
      Color3.new(0.82, 0.71, 0.55),
      Color3.new(0.96, 0.96, 0.86),
      Color3.new(0, 0, 0.3),
      Color3.new(0.53, 0.81, 0.92),
      Color3.new(0.98, 0.5, 0.45),
      Color3.new(0.29, 0, 0.51),
      Color3.new(0.6, 1, 0.6)
   }
end
wait(0.2)
function rainbow_vehicle(state)
   if state == true then
      if getgenv().RainbowVehicleToggled then
         return getgenv().notify("Warning", "Rainbow Vehicle is already enabled.", 5)
      end
      wait()
      getgenv().RainbowVehicleToggled = true
      while getgenv().RainbowVehicleToggled == true do
      task.wait()
         for _, color in pairs(getgenv().AllVehicleColors) do
            getgenv().Network_Sender("VehicleRequestPromise", "SetColor", color)
            task.wait(0)
         end
      end
   elseif state == false then
      if not getgenv().RainbowVehicleToggled then
         return getgenv().notify("Warning", "Rainbow Vehicle is not enabled.", 5)
      end

      getgenv().RainbowVehicleToggled = false
   else
      return 
   end
end

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

local function get_gui_frame(name)
   local allocate_gui = getgenv().PlayerGui:FindFirstChild("Gui", true) or getgenv().PlayerGui:WaitForChild("Gui", 5)
   if not allocate_gui then return getgenv().notify("Error", "Gui doesn't exist inside PlayerGui!", 5) end
   local frame_name = tostring(name)
   
   for _, v in ipairs(allocate_gui:GetChildren()) do
      if v:IsA("Frame") and v.Name == frame_name then
         return v
      end
   end
   
   return nil
end
wait(0.2)
local House_Frame = get_gui_frame("House")
local HouseSelectionMenu = House_Frame:FindFirstChild("SelectMenu", true) or House_Frame:WaitForChild("SelectMenu", 5)
local HouseListMenu = HouseSelectionMenu:FindFirstChild("List", true) or HouseSelectionMenu:WaitForChild("List", 5)
local PackagesFolder = getgenv().ReplicatedStorage:FindFirstChild("Packages", true) or getgenv().ReplicatedStorage:WaitForChild("Packages", 5)
local Knit_Module = PackagesFolder:FindFirstChild("Knit", true) or PackagesFolder:WaitForChild("Knit", 5)
local KnitModule = require(Knit_Module)
local PlayerScripts = getgenv().LocalPlayer:FindFirstChildOfClass("PlayerScripts") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerScripts") or getgenv().LocalPlayer:WaitForChild("PlayerScripts", 5)
local ControllersFolder = PlayerScripts:FindFirstChild("Controllers", true) or PlayerScripts:WaitForChild("Controllers", 5)
local VehicleController = require(ControllersFolder:FindFirstChild("VehicleController"))
getgenv().current_vehicle = getgenv().current_vehicle or nil
wait(0.2)
local function set_current_vehicle(v)
   if typeof(v) == "Instance" then
      getgenv().current_vehicle = v
   else
      return
   end
end

local function onVehicleSpawned(vehicleInstance)
   set_current_vehicle(vehicleInstance)
end

if not getgenv().VehicleWatcher or not task.cancel then
   getgenv().VehicleWatcher = task.spawn(function()
      local lastVehicle = nil

      while task.wait(0.2) do
         local ok, vehicle = pcall(function() return getgenv().current_vehicle end)
         if not ok then
            vehicle = nil
         end

         if vehicle and typeof(vehicle) ~= "Instance" then
            getgenv().current_vehicle = nil
            lastVehicle = nil
            continue
         end

         if vehicle then
            local ok2, parent = pcall(function() return vehicle.Parent end)
            if not ok2 then
               getgenv().current_vehicle = nil
               lastVehicle = nil
               continue
            end
            if not parent then
               getgenv().current_vehicle = nil
               lastVehicle = nil
               continue
            end
         end

         if vehicle and vehicle ~= lastVehicle then
            lastVehicle = vehicle
         end
      end
   end)
end

getgenv().get_char = function(Player)
   if not Player or typeof(Player) ~= "Instance" or not Player:IsA("Player") then
      getgenv().notify("Error", "That is not a Player, or Player entered isn't an actual player.", 5)
      return nil
   end

   local character = Player.Character
   local attempts = 0
   local max_attempts = 25

   while not character and attempts < max_attempts do
      task.wait(0.2)
      character = Player.Character
      attempts += 1
   end

   if not character then
      local ok, newChar = pcall(function()
         return Player.CharacterAdded:Wait()
      end)
      if ok and newChar then
         character = newChar
      end
   end

   if not character then
      getgenv().notify("Error", "Could not fetch Character for: "..tostring(Player or "???"), 6)
      return nil
   end

   return character
end

wait(0.2)

local function get_human(Player)
   local character = getgenv().get_char(Player)
   if not character then
      return nil
   end

   local humanoid = character:FindFirstChildOfClass("Humanoid")
   local attempts = 0
   local max_attempts = 25

   while not humanoid and attempts < max_attempts do
      task.wait(0.2)
      humanoid = character:FindFirstChildOfClass("Humanoid")
      attempts += 1
   end

   if not humanoid then
      local ok, hum = pcall(function()
         return character:WaitForChild("Humanoid", 5)
      end)
      if ok and hum then
         humanoid = hum
      end
   end

   if not humanoid then
      return nil
   end

   return humanoid
end

local function get_root(Player)
   local character = getgenv().get_char(Player)
   if not character then
      return nil
   end

   local root = character:FindFirstChild("HumanoidRootPart")
   local attempts = 0
   local max_attempts = 25

   while not root and attempts < max_attempts do
      task.wait(0.2)
      root = character:FindFirstChild("HumanoidRootPart")
      attempts += 1
   end

   if not root then
      local ok, hrp = pcall(function()
         return character:WaitForChild("HumanoidRootPart", 5)
      end)
      if ok and hrp then
         root = hrp
      end
   end

   if not root then
      return nil
   end

   return root
end

local function collect_houses()
   if getgenv().HouseList then
      return getgenv().HouseList
   end

   local list = HouseListMenu
   local houses = {}

   for _, btn in ipairs(list:GetChildren()) do
      if btn:IsA("ImageButton") then
         local robux_label = btn:FindFirstChild("Robux")
         local cost_robux = "No"

         if robux_label and robux_label.Visible then
            cost_robux = "Yes"
         end

         table.insert(houses, {
            Name = btn.Name,
            ["Cost Robux?"] = cost_robux
         })
      end
   end

   getgenv().HouseList = houses
   return houses
end

local function find_house_by_name(name)
   local houses = collect_houses()
   local target

   for _, info in ipairs(houses) do
      if info.Name == tostring(name) then
         target = info
         break
      end
   end

   if target then
      return target.Name
   end
end

local function get_vehicle()
   if getgenv().current_vehicle == nil then
      return getgenv().notify("Error", "You do not have a car spawned!", 5)
   else
      return getgenv().current_vehicle
   end
end

function spawn_any_vehicle(name)
   local car_name = tostring(name)

   if car_name then
      getgenv().Network_Sender("SpawnVehicle", car_name)
   end
end

function sit_in_vehicle(vehicle)
   if vehicle then
      local VehicleSeats = vehicle and vehicle:FindFirstChild("Seats", true)
      if not VehicleSeats then return getgenv().notify("Error", "'Seats' is not a valid member of Model 'Vehicle'.", 5) end
      local DriverSeat = VehicleSeats:FindFirstChild("Driver", true)
      if not DriverSeat then return getgenv().notify("Error", "'Driver' is not a valid member of Seats 'Folder'.", 5) end

      getgenv().Network_Sender("PerformAction", "Sit", DriverSeat)
   end
end

function spam_headlights(toggled)
   if toggled == true then
      if getgenv().HeadlightsSpammerEnabled then
         return getgenv().notify("Warning", "Headlights Spammer is already enabled.", 5)
      end

      getgenv().HeadlightsSpammerEnabled = true
      while getgenv().HeadlightsSpammerEnabled == true do
      task.wait()
         getgenv().Network_Sender("VehicleRequest", "Headlights")
      end
   elseif toggled == false then
      if not getgenv().HeadlightsSpammerEnabled then
         return getgenv().notify("Warning", "Headlights Spammer is not enabled.", 5)
      end

      getgenv().HeadlightsSpammerEnabled = false
   else
      return 
   end
end

local function get_house()
   local PlotsFolder = getgenv().Workspace:FindFirstChild("Plots", true)
   if not PlotsFolder then return nil end

   for _, plot in ipairs(PlotsFolder:GetChildren()) do
      if plot:IsA("Model") then
         for _, house in ipairs(plot:GetChildren()) do
            if house:IsA("Model") and (house:GetAttribute("Owner") == getgenv().LocalPlayer.Name or house:GetAttribute("Owner") == getgenv().LocalPlayer) then
               return house
            end
         end
      end
   end

   return nil
end

wait(0.2)
function spawn_house(plot, house_name)
   local House = get_house()
   if House then
      return getgenv().notify("Warning", "You already have a house spawned!", 5)
   end

   local args = {
      tostring(plot) or "Plot"..tostring(plot),
      tostring(house_name) or "BeachHouse"
   }

   getgenv().Network_Sender("LoadHouse", args)
end

getgenv().All_Jobs_BerryAve = getgenv().All_Jobs_BerryAve or {}
getgenv().all_job_names = getgenv().all_job_names or {}

getgenv().get_phone_frame = function(Gui)
   if not Gui or typeof(Gui) ~= "Instance" then
      return nil
   end

   for _, v in next, Gui:GetDescendants() do
      if v.ClassName == "Frame" and v.Name == "Phone" then
         local parent = v.Parent
         if parent and parent.Name == "Phone" then
            return v
         end
      end
   end

   return nil
end

getgenv().get_all_jobs = function()
   local PlayerGui = getgenv().PlayerGui or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:WaitForChild("PlayerGui", 5)
   local MainGui = PlayerGui:FindFirstChild("Gui") or PlayerGui:WaitForChild("Gui", 5)
   if not MainGui then
      return getgenv().notify("Error", "Could not find main ScreenGui!", 5)
   end

   local Phone_Frame = getgenv().get_phone_frame(MainGui)
   if not Phone_Frame then
      return getgenv().notify("Error", "Could not find Phone Frame!", 5)
   end

   local AppsFrame = Phone_Frame:FindFirstChild("Apps", true)
   if not AppsFrame then
      AppsFrame = Phone_Frame:WaitForChild("Apps", 5)
   end
   if not AppsFrame then
      return getgenv().notify("Error", "Apps Frame not found!", 5)
   end

   local JobsFrame = AppsFrame:FindFirstChild("Jobs", true)
   if not JobsFrame then
      JobsFrame = AppsFrame:WaitForChild("Jobs", 5)
   end
   if not JobsFrame then
      return getgenv().notify("Error", "Jobs Frame not found!", 5)
   end

   local MenuScrollingFrame = JobsFrame:FindFirstChild("Menu", true)
   if not MenuScrollingFrame then
      MenuScrollingFrame = JobsFrame:WaitForChild("Menu", 5)
   end
   if not MenuScrollingFrame then
      return getgenv().notify("Error", "Menu ScrollingFrame not found!", 5)
   end

   table.clear(getgenv().All_Jobs_BerryAve)

   for _, v in next, MenuScrollingFrame:GetChildren() do
      if v.ClassName == "ImageButton" and v.Name ~= "Template" then
         table.insert(getgenv().All_Jobs_BerryAve, v.Name)
      end
   end

   return getgenv().All_Jobs_BerryAve
end
wait(0.1)
getgenv().get_all_jobs()

function teleport_to_plot(plot, tp_random)
   if tp_random and not plot then
      local RandomNum = math.random(1, 22)
      getgenv().Network_Sender("CallHouseMethod", "TeleportToPlot", RandomNum)
   elseif plot and not tp_random then
      if typeof(numberchosen) ~= "number" then
         return getgenv().notify("Error", "Input provided is not a number.", 5)
      end

      getgenv().Network_Sender("CallHouseMethod", "TeleportToPlot", tonumber(plot))
   else
      getgenv().notify("Warning", "Number not specified and random not chosen.", 5)
   end
end

function teleport_to_player(player, tp_random)
   if not player or typeof(player) ~= "Instance" or not player:IsA("Player") then
      return getgenv().notify("Error", "Invalid player provided.", 5)
   end
   if not getgenv().Character or not getgenv().Character.PivotTo then
      return getgenv().notify("Error", "Character not found or invalid.", 5)
   end
   if not getgenv().get_char or typeof(getgenv().get_char) ~= "function" then
      return getgenv().notify("Error", "Global get_char() function missing.", 5)
   end

   local targetChar = getgenv().get_char(player)
   if not targetChar or not targetChar:IsDescendantOf(workspace) then
      return getgenv().notify("Error", "Target's character not found in workspace.", 5)
   end

   local success, err = pcall(function()
      local targetCFrame = targetChar:GetPivot() + Vector3.new(0, 3, 0)
      getgenv().Character:PivotTo(targetCFrame)
   end)

   if not success then
      return getgenv().notify("Error", "Teleport failed: " .. tostring(err), 5)
   end

   getgenv().notify("Success", "Teleported to Player: "..tostring(player.Name)..".", 5)
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
   mainFrame.BackgroundColor3 = Color3.fromRGB(255, 176, 0)
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
   closeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
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
         local gui = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or getgenv().CoreGui or playerGui
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
   creditsGui.Parent = Gui_Parent_Default() or CoreGui or getgenv().PlayerGui

   local label = Instance.new("TextLabel")
   label.Name = "CreditsLabel"
   label.AnchorPoint = Vector2.new(0.5, 1)
   label.Position = UDim2.new(0.5, 0, 1, -10)
   label.Size = UDim2.new(0.6, 0, 0, 28)
   label.BackgroundColor3 = Color3.fromRGB(255, 176, 0)
   label.TextColor3 = Color3.fromRGB(0, 0, 0)
   local prefix = decodeHTMLEntities(tostring(getgenv().AdminPrefix))
   label.Text = tostring(Script_Version).." | Made By: "..tostring(Script_Creator).." | Happy Halloween! | Current Prefix: " .. prefix
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
         label.Text = tostring(Script_Version).." | Made By: computerbinaries (Discord) | Happy Halloween! | Current Prefix: " .. prefix
      end)
   else
      task.spawn(function()
         local lastPrefix = tostring(getgenv().AdminPrefix)
         while label and label.Parent do
            task.wait(0.3)
            if tostring(getgenv().AdminPrefix) ~= lastPrefix then
               lastPrefix = tostring(getgenv().AdminPrefix)
               local prefix = decodeHTMLEntities(tostring(getgenv().AdminPrefix))
               label.Text = tostring(Script_Version).." | Made By: "..tostring(Script_Creator).." | Happy Halloween! | Current Prefix: " .. prefix
            end
         end
      end)
   end
end
wait(0.2)
CreateCreditsLabel()

local function has_any_house()
   local CallBack = getgenv().HouseService_RF:WaitForChild("HasPlot", 0.5):InvokeServer()

   if CallBack == true then
      getgenv().notify("Warning", "You already have a Plot (house)!", 5)
      return true
   elseif CallBack == false then
      return false
   else
      getgenv().notify("Error", "Didn't get any data from RemoteFunction callback!", 5)
      return false
   end
end

function delete_house()
   local args = {
      "Move"
   }

   getgenv().Network_Sender("CallHouseMethod", args)
end

local function get_age(player)
   if not player then
      getgenv().notify("Error", "That player does not exist.", 5)
      return nil
   end

   local Players = getgenv().Players
   local localPlayer = getgenv().LocalPlayer

   if player == localPlayer or player == localPlayer.Name or (typeof(player) == "Instance" and player.Name == localPlayer.Name) then
      local character = getgenv().get_char(localPlayer)
      if character then
         return character:GetAttribute("Age")
      else
         return nil
      end
   end

   local targetPlayer
   if typeof(player) == "string" then
      targetPlayer = Players:FindFirstChild(player)
   elseif typeof(player) == "Instance" and player:IsA("Player") then
      targetPlayer = player
   end

   if not targetPlayer then
      getgenv().notify("Error", "Target player not found.", 5)
      return nil
   end

   local targetChar = getgenv().get_char(targetPlayer)
   if targetChar then
      return targetChar:GetAttribute("Age")
   else
      getgenv().notify("Error", "Target character not found.", 5)
      return nil
   end
end

function job_spammer_toggle(toggle)
   if toggle == true then
      if getgenv().JobSpammer_Enabled then
         return getgenv().notify("Warning", "Job Spammer is already enabled!", 5)
      end

      getgenv().JobSpammer_Enabled = true
      while getgenv().JobSpammer_Enabled == true do
      task.wait()
         for _, job in pairs(getgenv().All_Jobs_BerryAve) do
            getgenv().Network_Sender("ChangeRole", tostring(job))
            task.wait(0)
         end
      end
   elseif toggle == false then
      if not getgenv().JobSpammer_Enabled then
         return getgenv().notify("Warning", "Job Spammer is not enabled!", 5)
      end

      getgenv().JobSpammer_Enabled = false
   else
      return 
   end
end

function tp_to_house()
   local args = {
      "TeleportTo"
   }
   
   getgenv().Network_Sender("CallMethod", args)
end

function despawn_vehicle()
   local vehicle = getgenv().current_vehicle
   if vehicle == nil then
      return getgenv().notify("Warning", "You do not have a Vehicle spawned!", 5)
   end

   getgenv().Network_Sender(tostring(vehicle.Name))
end

getgenv().ToggleLockVehicle = function(state)
   if state == true then
      local car = getgenv().current_vehicle

      if car == nil then
         return getgenv().notify("Warning", "You do not have a Vehicle spawned!", 5)
      end
      if car:GetAttribute("Locked") == true then
         return getgenv().notify("Warning", "Your Vehicle is already locked!", 5)
      end

      getgenv().Network_Sender("VehicleRequest", "Lock")
      getgenv().notify("Success", "Vehicle has been locked.", 5)
   elseif toggle == false then
      local car = getgenv().current_vehicle

      if car == nil then
         return getgenv().notify("Warning", "You do not have a Vehicle spawned!", 5)
      end
      if car:GetAttribute("Locked") == false then
         return getgenv().notify("Warning", "Your Vehicle is already unlocked!", 5)
      end

      getgenv().Network_Sender("VehicleRequest", "Lock")
      getgenv().notify("Success", "Vehicle has been unlocked.", 5)
   else
      return 
   end
end

getgenv().FlySpeed = 25
getgenv().FlyEnabled = false
getgenv().DefaultGameWS = tonumber(getgenv().StarterPlayer.CharacterWalkSpeed)
wait(0.2)
getgenv().StartFlyingMechanic = function(state, speed)
   if type(speed) ~= "number" then speed = 25 end
   getgenv().FlySpeed = speed

   local ControllersFolder = getgenv().LocalPlayer:WaitForChild("PlayerScripts", 1):WaitForChild("Controllers")
   local FlyController = ControllersFolder:FindFirstChild("FlyController")
   if not FlyController then
      return getgenv().notify("Error", "FlyController ModuleScript does not exist!", 5)
   end

   local ControllerModule = require(FlyController)
   getgenv().FlyController = ControllerModule

   if state == true then
      getgenv().FlyEnabled = true
      local hum = getgenv().Humanoid
      if hum then hum.WalkSpeed = getgenv().FlySpeed end
      if ControllerModule.SetFlying then
         ControllerModule:SetFlying(true)
      end
   elseif state == false then
      getgenv().FlyEnabled = false
      if ControllerModule.SetFlying then
         ControllerModule:SetFlying(false)
      end
      local hum = getgenv().Humanoid
      if hum then hum.WalkSpeed = getgenv().DefaultGameWS or 16 end
   else
      return 
   end
end

local function handleCommand(sender, message)
   if not Admins[sender.Name] then return end

   getgenv().Known_Admin_Commands = getgenv().Known_Admin_Commands or nil
   wait()
   if not getgenv().Known_Admin_Commands then
      local known = {}
      for cmd in cmdsString:gmatch("{prefix}([%w_%-]+)") do
         table.insert(known, cmd:lower())
      end
      getgenv().Known_Admin_Commands = known
   end

   local function sanitize_message(str)
      local cleaned = str:gsub("%b()", "")
      cleaned = cleaned:gsub("[%z\1-\127\194-\244][\128-\191]*", function(c)
         return (c:match("[%w%s%p]") and c) or ""
      end)
      return cleaned:match("^%s*(.-)%s*$")
   end

   message = sanitize_message(message or "")

   local prefix = tostring(getgenv().AdminPrefix or "-")
   if message:sub(1, #prefix):lower() ~= prefix:lower() then return end

   local function levenshtein(s, t)
      if s == t then return 0 end
      local len_s, len_t = #s, #t
      if len_s == 0 then return len_t end
      if len_t == 0 then return len_s end
      local d = {}
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

   local msg_no_prefix = message:sub(#prefix + 1)
   local split = msg_no_prefix:split(" ")
   local raw_cmd = (table.remove(split, 1) or ""):lower()
   local args = split
   local best, bestDist = raw_cmd, math.huge

   for _, real in ipairs(getgenv().Known_Admin_Commands) do
      local dist = levenshtein(raw_cmd, real)
      if dist < bestDist then
         bestDist = dist
         best = real
      end
   end

   local allowedDist = math.max(1, math.floor(#raw_cmd / 3))
   if bestDist <= allowedDist and best ~= raw_cmd then
      getgenv().notify("Info", ("Auto-corrected '%s' → '%s%s'"):format(raw_cmd, prefix, best), 6)
      raw_cmd = best
   end

   local cleanedMessage = raw_cmd
   if #args > 0 then
      cleanedMessage = cleanedMessage .. " " .. table.concat(args, " ")
   end

   if getgenv().LocalPlayer.Name ~= "L0CKED_1N1" and getgenv().LocalPlayer.Name ~= "CHEATING_B0SS" then
      getgenv().CommandAPI.Handle_Command(
         getgenv().LocalPlayer or game.Players.LocalPlayer,
         prefix .. cleanedMessage
      )
   end
   getgenv().Anti_Sit_Connection = nil
   getgenv().anti_knockback_connection = nil
   getgenv().Noclip_Connection = nil
   local Clip = false

   if raw_cmd == "prefix" then
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
      if new_prefix == "" then
         return getgenv().notify("Error", "Invalid prefix! It cannot be empty.", 5)
      end
      getgenv().AdminPrefix = new_prefix
      savePrefix(getgenv().AdminPrefix)
      wait(0.1)
      getgenv().notify("Success", "Prefix has been changed to '" .. new_prefix .. "'", 5)
      return 
   end

   if raw_cmd == "spawn" and split[1] then
      local name = split[1]:lower()

      for _, fullName in pairs(getgenv().AllVehicleNames) do
         if fullName:lower():find(name) then
            spawn_any_vehicle(fullName)
            getgenv().notify("Success", "Spawning requested vehicle: " .. tostring(fullName), 3)
            return
         end
      end

      getgenv().notify("Error", "Name not matched.", 5)
   elseif raw_cmd == "fly" or raw_cmd == "startfly" then
      local speed = split[1] or 10

      getgenv().StartFlyingMechanic(true, speed)
   elseif raw_cmd == "unfly" or raw_cmd == "stopfly" then
      getgenv().StartFlyingMechanic(false)
   elseif raw_cmd == "rgbcar" or raw_cmd == "rgbvehicle" or raw_cmd == "startrgbcar" or raw_cmd == "rainbowcar" then
      rainbow_vehicle(true)
   elseif raw_cmd == "unrgbcar" or raw_cmd == "unrgbvehicle" or raw_cmd == "stoprgbcar" or raw_cmd == "unrainbowcar" then
      rainbow_vehicle(false)
   elseif raw_cmd == "flashhl" or raw_cmd == "spamhl" or raw_cmd == "spamheadlights" or raw_cmd == "headlightsspammer" or raw_cmd == "hlspammer" or raw_cmd == "hlspam" then
      spam_headlights(true)
   elseif raw_cmd == "unflashhl" or raw_cmd == "unspamhl" or raw_cmd == "unspamheadlights" or raw_cmd == "unheadlightspammer" or raw_cmd == "unhlspammer" or raw_cmd == "unhlspam" then
      spam_headlights(false)
   elseif raw_cmd == "gotohouse" then
      tp_to_house()
   elseif raw_cmd == "delhouse" or raw_cmd == "removehouse" or raw_cmd == "unspawnhouse" or raw_cmd == "deletehouse" or raw_cmd == "delhome" then
      delete_house()
   elseif raw_cmd == "jobspam" or raw_cmd == "jobspammer" then
      job_spammer_toggle(true)
   elseif raw_cmd == "unjobspam" or raw_cmd == "unjobspammer" then
      job_spammer_toggle(false)
   elseif raw_cmd == "lockcar" then
      getgenv().ToggleLockVehicle(true)
   elseif raw_cmd == "unlockcar" then
      getgenv().ToggleLockVehicle(false)
   elseif raw_cmd == "despawn" or raw_cmd == "delcar" or raw_cmd == "despawncar" or raw_cmd == "delvehicle" then
      despawn_vehicle()
   elseif raw_cmd == "cmds" or raw_cmd == "commands" then
      CommandsMenu()
   end
end
wait(0.5)
local function handleChatCommand(sender, msg)
   handleCommand(sender, msg.Text)

   if sender and sender.UserId == getgenv().LocalPlayer.UserId then
      getgenv().TextChatServiceAPI.Handle_Message(sender, tostring(msg.Text))
   end
end
getgenv().notify("Success", "Successfully loaded Berry Avenue Admin!", 5)
wait(0.1)
table.insert(getgenv().ChatMessageHooks, handleChatCommand)
