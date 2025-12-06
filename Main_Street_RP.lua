if not game:IsLoaded() then
   game.Loaded:Wait()
end
wait(0.2)
local MarketplaceService = game:GetService("MarketplaceService")
local game_name = MarketplaceService:GetProductInfo(game.PlaceId).Name
local flames_api = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua"))()
wait(0.2)
local Players = flames_api.Service("Players")
local HttpService = flames_api.Service("HttpService")
local LocalPlayer = flames_api.LocalPlayer
local PlayerGui = flames_api.PlayerGui
local ReplicatedStorage = flames_api.Service("ReplicatedStorage")
local StarterGui = flames_api.Service("StarterGui")
local g = getgenv()

getgenv().notify = getgenv().notify or function(title, msg, duration)
   flames_api.notify(title, msg, duration)
end

local colors = {
   "Black",
   "NardoGrey",
   "MidGrey",
   "Silver",
   "LightGrey",
   "Cream",
   "Clay",
   "SandyBiege",
   "SchoolBusYellow",
   "RawOrange",
   "WineRed",
   "Red",
   "BloodOrange",
   "NeonPink",
   "RoseRed",
   "Lavender",
   "BrightGreen",
   "BritishRacingGreen",
   "BottleGreen",
   "Lilac",
   "PaleRose",
   "Bronze",
   "DeepBlue",
   "HazelBrown",
}

local Body_Skintones = {
   "ColorA1",
   "ColorA2",
   "ColorA3",
   "ColorA4",
   "ColorA5",
   "ColorA6",
   "ColorA7",
   "ColorB1",
   "ColorB2",
   "ColorB3",
   "ColorB4",
   "ColorB5",
   "ColorB6",
   "ColorB7",
}

local Ages = {
   "Baby",
   "Child",
   "Teen",
   "Adult"
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LumUILibrary.lua"))()
local Window = Library.new(tostring(game_name).." - Control Panel")
local PlayersTab = Window:Tab("Players")
local VehicleTab = Window:Tab("Vehicle")
local UITab = Window:Tab("UI")
local Player = PlayersTab:Section("Players")
local Vehicle = VehicleTab:Section("Vehicle")
local UI = UITab:Section("UI")
local Network = ReplicatedStorage:FindFirstChild("Network")
local Vehicle_Color = Network:FindFirstChild("Vehicles_SetColorRequest")
local Vehicle_Rims = Network:FindFirstChild("Vehicles_SetRimsRequest")
local Vehicle_Trails = Network:FindFirstChild("Vehicles_SetTrailRequest")
local Vehicle_Wraps = Network:FindFirstChild("Vehicles_SetWrapRequest")
local Lock_Car = Network:FindFirstChild("Vehicles_InvokeControlRequest")
local Skintone = Network:FindFirstChild("Avatar_SetToneRequest")
local Age = Network:FindFirstChild("Avatar_SetAgeRequest")
local Avatar_Change = Network:FindFirstChild("Avatar_ToggleAssetsRequest")
local Request_Player = Network:FindFirstChild("Animation_InvokePoseRequest")
local Owner_Outfit_IDs = {
   ["Pants"] = 18236856447,
   ["Shirt"] = 16045355146,
   ["Face"] = 10678423,
   ["HairAccessory"] = 17756326340,
   ["HeadAccessory"] = 12873121215,
   ["Skintone"] = "ColorA6",
   ["FaceAccessory"] = 13734096288,
   ["NeckAccessory"] = 137021886332998,
   ["FrontAccessory"] = 119724315554604,
   ["BackAccessory"] = 18197327746,
   ["WaistAccessory"] = 18862883592,
}

function close_menu()
   closeWindow()
end

local function safe_wait(...)
   local current = ReplicatedStorage

   for _, part in pairs({...}) do
      current = current:WaitForChild(part, 5)
      if not current then
         return getgenv().notify("Error", "Missing: "..tostring(part), 6)
      end
   end

   return current
end

getgenv().cars_cache = getgenv().cars_cache or {}
getgenv().owner_index = getgenv().owner_index or {}
getgenv().car_index_inited = getgenv().car_index_inited or false
local HttpService = getgenv().HttpService or cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = getgenv().Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local cars_cache = getgenv().cars_cache
local owner_index = getgenv().owner_index
local function usernamefromdisplayname(displayname)
   for _, p in ipairs(Players:GetPlayers()) do
      if string.lower(p.DisplayName) == string.lower(displayname) then
         return p.Name
      end
   end
   return nil
end

local function indexcar(model)
   local raw = model:GetAttribute("56")
   if not raw then return end
   local ok, decoded = pcall(function() return HttpService:JSONDecode(raw) end)
   if not ok or not decoded.Owner then return end
   owner_index[string.lower(decoded.Owner)] = model
end

local function removecar(model)
   for owner, m in pairs(owner_index) do
      if m == model then
         owner_index[owner] = nil
      end
   end
end

if not getgenv().car_index_inited then
   getgenv().car_index_inited = true

   for _, v in ipairs(workspace:GetDescendants()) do
      if v:IsA("Model") and v:GetAttribute("56") then
         cars_cache[v] = true
         indexcar(v)
      end
   end

   workspace.DescendantAdded:Connect(function(obj)
      if obj:IsA("Model") and obj:GetAttribute("56") then
         cars_cache[obj] = true
         indexcar(obj)
      end
   end)

   workspace.DescendantRemoving:Connect(function(obj)
      if cars_cache[obj] then
         cars_cache[obj] = nil
         removecar(obj)
      end
   end)
end

local function carbyusername(nameordisplayname)
   local resolved = usernamefromdisplayname(nameordisplayname) or nameordisplayname
   local m = owner_index[string.lower(resolved)]
   if m then return m end
   getgenv().notify("Error", "Car not found for: "..tostring(nameordisplayname), 6)
   return nil
end

local function return_correct_age()
   local Menus_GUI = PlayerGui:FindFirstChild("Menus")
   if not Menus_GUI then return notify("Error", "Menus GUI doesn't exist inside PlayerGui!", 5) end

   local Avatar = Menus_GUI:FindFirstChild("Avatar")
   if not Avatar then return notify("Error", "Avatar Frame doesn't exist inside Menus GUI!", 5) end

   local Menus_Frame = Avatar:FindFirstChild("Menus")
   if not Menus_Frame then return notify("Error", "Menus Frame doesn't exist inside Avatar Frame!", 5) end

   local Body_Frame_1 = Menus_Frame:FindFirstChild("Body")
   if not Body_Frame_1 then return notify("Error", "Body_Frame_1 doesn't exist inside Menus Frame!", 5) end

   local Body_Frame_2 = Body_Frame_1:FindFirstChild("Body")
   if not Body_Frame_2 then return notify("Error", "Body_Frame_2 doesn't exist inside Body_Frame_1!", 5) end

   local Ages_Frame = Body_Frame_2:FindFirstChild("Ages")
   if not Ages_Frame then return notify("Error", "Ages Frame doesn't exist inside Body_Frame_2!", 5) end

   for _, ageName in ipairs(Ages) do
      local ageButton = Ages_Frame:FindFirstChild(ageName)
      if ageButton and ageButton:FindFirstChild("Body") then
         local bg = ageButton.Body:FindFirstChild("Background")
         if bg then
            local uiStroke = bg:FindFirstChild("UIStroke")
            if uiStroke and typeof(uiStroke.Enabled) == "boolean" and uiStroke.Enabled then
               return ageName
            end
         end
      end
   end

   return notify("Error", "No age selection has UIStroke enabled.", 5)
end

local function shouldLockCar(carModel)
   local raw = carModel:GetAttribute("47")
   if not raw then
      return true
   end

   local success, decoded = pcall(function()
      return HttpService:JSONDecode(raw)
   end)

   if success and typeof(decoded) == "table" then
      return decoded.IsLocked ~= true
   end

   return true
end

local rims_path = safe_wait("Assets", "Content", "Vehicles", "Rims")
local AllRims = {}

if rims_path then
   for _, rim in ipairs(rims_path:GetChildren()) do
      if rim:IsA("Model") and string.find(rim.Name:lower(), "rimpremium") then
         table.insert(AllRims, rim.Name)
      end
   end
else
   return notify("Error", "Rims not found.", 5)
end

local wraps_path = safe_wait("Assets", "Content", "Vehicles", "Wraps")
local AllWraps = {}

if wraps_path then
   for _, wrap in ipairs(wraps_path:GetChildren()) do
      if wrap:IsA("SurfaceAppearance") and string.find(wrap.Name:lower(), "wrap") then
         table.insert(AllWraps, wrap.Name)
      end
   end
   if #AllWraps == 0 then
      getgenv().notify("Error", "No valid wraps found.", 5)
   end
else
   getgenv().notify("Error", "Wraps not found.", 5)
end

local trails_path = safe_wait("Assets", "Content", "Vehicles", "Trails")
local AllTrails = {}

if trails_path then
   for _, trail in ipairs(trails_path:GetChildren()) do
      if trail:IsA("Part") and string.find(trail.Name:lower(), "trail") then
         table.insert(AllTrails, trail.Name)
      end
   end
   if #AllTrails == 0 then
      getgenv().notify("Error", "No valid trails found.", 5)
   end
else
   getgenv().notify("Error", "Trails not found.", 5)
end

Vehicle:Toggle("Rainbow Vehicle (FE)", function(RGBVehicle)
   if RGBVehicle then
      getgenv().RGB_Vehicle = true
      getgenv().notify("Success", "Rainbow Vehicle is now enabled.", 5)
      wait(0.1)
      while getgenv().RGB_Vehicle == true do
      task.wait()
         for _, color in ipairs(colors) do
            local args = {
               "Primary",
               color
            }

            Vehicle_Color:FireServer(unpack(args))
            task.wait()
         end
      end
   else
      getgenv().RGB_Vehicle = false
      getgenv().notify("Success", "Rainbow Vehicle is now disabled.", 5)
   end
end)

Vehicle:Toggle("Flash Rims (FE)", function(RimsFlashing)
   if RimsFlashing then
      getgenv().Flashing_Rims = true
      getgenv().notify("Success", "Flashing Rims is now enabled.", 5)
      wait(0.1)
      while getgenv().Flashing_Rims == true do
      wait()
         for _, rim in ipairs(AllRims) do
            task.wait(.1)
            Vehicle_Rims:FireServer(rim)
         end
      end
   else
      getgenv().Flashing_Rims = false
      getgenv().notify("Success", "Flash Rims is now disabled.", 5)
   end
end)

Vehicle:Toggle("Flash Trail (FE)", function(TrailsFlashing)
   if TrailsFlashing then
      getgenv().Flashing_Trails = true
      getgenv().notify("Success", "Flashing Trail is now enabled.", 5)
      wait(0.1)
      while getgenv().Flashing_Trails == true do
      wait()
         for _, trail in ipairs(AllTrails) do
            task.wait(.1)
            Vehicle_Trails:FireServer(trail)
         end
      end
   else
      getgenv().Flashing_Trails = false
      getgenv().notify("Success", "Flashing Trail is now disabled.", 5)
   end
end)

Vehicle:Toggle("Flash Wrap (FE)", function(WrapsFlashing)
   if WrapsFlashing then
      getgenv().Flashing_Wraps = true
      getgenv().notify("Success", "Flashing Wraps is now enabled.", 5)
      wait(0.1)
      while getgenv().Flashing_Wraps == true do
      wait()
         for _, wrap in ipairs(AllWraps) do
            task.wait(.1)
            Vehicle_Wraps:FireServer(wrap)
         end
      end
   else
      getgenv().Flashing_Wraps = false
      getgenv().notify("Success", "Flashing Wraps is now disabled.", 5)
   end
end)

Vehicle:Toggle("Lock Car (FE)", function(locking_car)
   if locking_car then
      if getgenv().lockedcar_thread and task.cancel then
         return
      end

      getgenv().Locked_Car = true
      getgenv().lockedcar_cancel = false
      getgenv().lockedcar_thread = task.spawn(function()
         while getgenv().Locked_Car and not getgenv().lockedcar_cancel do
            task.wait(0.2)

            local mycar = CarByUsername(tostring(LocalPlayer.DisplayName))
            if not mycar then
               getgenv().Locked_Car = false
               break
            end

            if shouldLockCar(mycar) then
               Lock_Car:FireServer("ToggleLock")
            end
         end
      end)
   else
      getgenv().Locked_Car = false
      getgenv().lockedcar_cancel = true
      if getgenv().lockedcar_thread then
         task.cancel(getgenv().lockedcar_thread)
      end
      getgenv().lockedcar_thread = nil
   end
end)

Player:Toggle("Rainbow Skin (FE)", function(RGB_Skin)
   if RGB_Skin then
      getgenv().Rainbow_Skin_Enabled = true
      while getgenv().Rainbow_Skin_Enabled == true do
      task.wait(.1)
         for _, skintone in ipairs(Body_Skintones) do
         task.wait(.1)
            Skintone:FireServer(skintone)
         end
      end
   else
      getgenv().Rainbow_Skin_Enabled = false
      repeat wait() until getgenv().Rainbow_Skin_Enabled == false
      wait(1)
      if getgenv().Rainbow_Skin_Enabled == false then
         Skintone:FireServer()
      end
   end
end)

local Correct_Age = return_correct_age()
wait(0.2)
Player:Toggle("Loop Age (FE)", function(Looping_Age)
   if Looping_Age then
      getgenv().Looping_Age_Setter = true
      while getgenv().Looping_Age_Setter == true do
      task.wait(.1)
         for _, age in ipairs(Ages) do
         task.wait(.1)
            Age:FireServer(age)
         end
      end
   else
      getgenv().Looping_Age_Setter = false
      wait(0.3)
      Age:FireServer(Correct_Age)
   end
end)

Player:Button("Owner Outfit (FE)", function()
   for key, id in pairs(Owner_Outfit_IDs) do
      if typeof(id) == "number" then
         local args = {
            {
               {
                  Key = key,
                  Identification = id
               }
            }
         }

         local success, result = pcall(function()
            return Avatar_Change:InvokeServer(unpack(args))
         end)

         if success then
            notify("Success", tostring(key) .. tostring(id), 5)
         else
            notify("Info", tostring(key)..": "..tostring(result), 10)
            notify("Error", "Failed to apply owner outfit (see notification above).", 6)
         end
         task.wait(0.1)
      elseif typeof(id) == "string" and key == "Skintone" then
         Skintone:FireServer(id)
      end
   end
end)

Player:TextBox("Spam Carry Request Player", function(target_interact_loop, focuslost)
   local target = flames_api.findplr(target_interact_loop)
   local playerName = target and target.Name
   
   if target then
      getgenv().loop_request_carry = true
      while getgenv().loop_request_carry == true do
      task.wait(0)
         if playerName and playerName ~= LocalPlayer.Name then
            local emotes = {
               "Characters_Emotes_Joint_CarryBack_Invokee",
               "Characters_Emotes_Joint_CarryHurt_Invokee",
               "Characters_Emotes_Joint_Hug_Invokee",
               "Characters_Emotes_Joint_Handshake_Invokee",
               "Characters_Emotes_Joint_CarryShoulders_Invokee"
            }

            for _, emote in ipairs(emotes) do
               Request_Player:FireServer(playerName, emote)
               task.wait(.1)
            end
         end
      end
   else
      return notify("Error", "Player/Target was not found.", 5)
   end
end)

Player:Button("Stop Requesting", function()
   getgenv().loop_request_carry = false
end)

UI:Button("Destroy GUI", function()
   close_menu()
end)
