local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Vehicles = getgenv().Workspace:FindFirstChild("Vehicles")
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/Notification_Lib.lua"))()

wait()

function notify(notif_type, msg, duration)
   NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration))
end
wait(0.1)
if not getgenv().notify then
   getgenv().notify = notify
end
wait(0.2)
local function get_other_vehicle(Player)
   for i, v in pairs(Workspace:FindFirstChild("Vehicles"):GetChildren()) do
      if v.owner.Value == Player then
         return v
      end
   end

   return nil
end

if not Vehicles then
   return warn("Vehicles folder not found.")
end

local function get_vehicle()
   for i, v in pairs(Workspace:FindFirstChild("Vehicles"):GetChildren()) do
      if v.owner.Value == LocalPlayer then
         return v
      end
   end

   return nil
end
wait(0.2)
getgenv().get_vehicle = get_vehicle

pcall(function()
   if getgenv().VehicleStatsGUI then
      getgenv().VehicleStatsGUI:Destroy()
   end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VehicleStatsGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local Modules = ReplicatedStorage:FindFirstChild("Modules")
local Core = Modules:FindFirstChild("Core")
local Game = Modules:FindFirstChild("Game")
local Network = require(Core:FindFirstChild("Net"))

getgenv().VehicleStatsGUI = ScreenGui
function send_function(...)
   Network.get(...)
end

function send_remote(...)
   Network.send(...)
end
wait(0.1)
if not getgenv().Get then
   getgenv().Get = send_function
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 20, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Text = "Vehicle Stats Viewer"
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame
local CloseCorner = Instance.new("UICorner", CloseButton)
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseButton.MouseButton1Click:Connect(function()
   getgenv().VehicleStatsActive = false
   ScreenGui:Destroy()
end)

local Scroller = Instance.new("ScrollingFrame")
Scroller.Size = UDim2.new(1, -20, 1, -50)
Scroller.Position = UDim2.new(0, 10, 0, 40)
Scroller.BackgroundTransparency = 1
Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroller.ScrollBarThickness = 6
Scroller.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout", Scroller)
UIListLayout.Padding = UDim.new(0, 8)

local VehicleUI = {}

local function CreateEntry(vehicle)
   local Holder = Instance.new("Frame")
   Holder.Size = UDim2.new(1, 0, 0, 170)
   Holder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
   Holder.Parent = Scroller
   local Corner = Instance.new("UICorner", Holder)
   Corner.CornerRadius = UDim.new(0, 10)

   local name = Instance.new("TextLabel")
   name.Text = "Vehicle: " .. tostring(vehicle.Name)
   name.Size = UDim2.new(1, -10, 0, 20)
   name.Position = UDim2.new(0, 5, 0, 5)
   name.BackgroundTransparency = 1
   name.TextColor3 = Color3.fromRGB(255, 255, 255)
   name.Font = Enum.Font.GothamMedium
   name.TextSize = 14
   name.TextXAlignment = Enum.TextXAlignment.Left
   name.Parent = Holder

   local playerLabel = Instance.new("TextLabel")
   playerLabel.Text = "Player Name: N/A"
   playerLabel.Size = UDim2.new(1, -10, 0, 18)
   playerLabel.Position = UDim2.new(0, 5, 0, 24)
   playerLabel.BackgroundTransparency = 1
   playerLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
   playerLabel.Font = Enum.Font.Gotham
   playerLabel.TextSize = 13
   playerLabel.TextXAlignment = Enum.TextXAlignment.Left
   playerLabel.Parent = Holder

   local maxAcc = Instance.new("TextLabel")
   maxAcc.Text = "Max Acceleration: N/A"
   maxAcc.Size = UDim2.new(1, -10, 0, 18)
   maxAcc.Position = UDim2.new(0, 5, 0, 44)
   maxAcc.BackgroundTransparency = 1
   maxAcc.TextColor3 = Color3.fromRGB(180, 180, 180)
   maxAcc.Font = Enum.Font.Gotham
   maxAcc.TextSize = 13
   maxAcc.TextXAlignment = Enum.TextXAlignment.Left
   maxAcc.Parent = Holder

   local turnAngle = maxAcc:Clone()
   turnAngle.Position = UDim2.new(0, 5, 0, 104)
   turnAngle.Text = "Turn Angle: N/A"
   turnAngle.Parent = Holder

   local lockedStatus = maxAcc:Clone()
   lockedStatus.Position = UDim2.new(0, 5, 0, 124)
   lockedStatus.Text = "Locked: N/A"
   lockedStatus.Parent = Holder

   local maxSpeed = maxAcc:Clone()
   maxSpeed.Position = UDim2.new(0, 5, 0, 64)
   maxSpeed.Text = "Max Speed: N/A"
   maxSpeed.Parent = Holder

   local acc60 = maxAcc:Clone()
   acc60.Position = UDim2.new(0, 5, 0, 84)
   acc60.Text = "Acceleration (0 To 60): N/A"
   acc60.Parent = Holder

   local spawnButton = Instance.new("TextButton")
   spawnButton.Text = "Spawn This Car (With Settings)"
   spawnButton.Size = UDim2.new(1, -20, 0, 20)
   spawnButton.Position = UDim2.new(0, 10, 0, 148)
   spawnButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
   spawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   spawnButton.Font = Enum.Font.Gotham
   spawnButton.TextSize = 13
   spawnButton.Parent = Holder

   local spawnCorner = Instance.new("UICorner", spawnButton)
   spawnCorner.CornerRadius = UDim.new(0, 6)

   spawnButton.MouseButton1Click:Connect(function()
      local Vehicle_LocalPlr = get_vehicle()
      getgenv().Get = send_function
      wait(0.3)
      if Vehicle_LocalPlr.Name ~= vehicle.Name then
         getgenv().Get("spawn_vehicle", tostring(vehicle.Name))
      end
      wait(0.5)
      if Vehicle_LocalPlr and Vehicle_LocalPlr.Name == tostring(vehicle.Name) then
         Vehicle_LocalPlr:SetAttribute("max_speed", vehicle:GetAttribute("max_speed"))
         Vehicle_LocalPlr:SetAttribute("max_acc", vehicle:GetAttribute("max_acc"))
         Vehicle_LocalPlr:SetAttribute("acc_0_60", vehicle:GetAttribute("acc_0_60"))
      elseif not Vehicle_LocalPlr then
         getgenv().Get("spawn_vehicle", tostring(vehicle.Name))
         wait(1)
         local Vehicle_LocalPlayer = get_vehicle()
         Vehicle_LocalPlayer:SetAttribute("max_speed", vehicle:GetAttribute("max_speed"))
         Vehicle_LocalPlayer:SetAttribute("max_acc", vehicle:GetAttribute("max_acc"))
         Vehicle_LocalPlayer:SetAttribute("acc_0_60", vehicle:GetAttribute("acc_0_60"))
      end
   end)

   VehicleUI[vehicle] = {
      Frame = Holder,
      MaxAcc = maxAcc,
      MaxSpeed = maxSpeed,
      Acc60 = acc60,
      TurnAngle = turnAngle,
      LockedStatus = lockedStatus,
      PlayerLabel = playerLabel,
      SpawnButton = spawnButton
   }

   local ownerName = vehicle:GetAttribute("OwnerName")

   if ownerName and typeof(ownerName) == "string" then
      playerLabel.Text = "Player Name: " .. ownerName
   else
      local Owners_Name = vehicle:FindFirstChild("owner")

      if Owners_Name and Owners_Name:IsA("ObjectValue") then
         local value = Owners_Name.Value

         if value and value:IsA("Player") then
            playerLabel.Text = "Player Name: " .. value.Name
         elseif value then
            playerLabel.Text = "Player Name: " .. tostring(value)
         else
            playerLabel.Text = "Player Name: ???"
         end
      else
         playerLabel.Text = "Player Name: ???"
      end
   end

   task.wait()
   Scroller.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

local function Validate_Model(model)
   return model:IsA("Model") and model:FindFirstChild("Base") ~= nil
end

local function UpdateStatistics(vehicle)
   local ui = VehicleUI[vehicle]
   if not ui then return end

   local acc = math.floor(tonumber(vehicle:GetAttribute("max_acc")) or 0)
   local speed = math.floor(tonumber(vehicle:GetAttribute("max_speed")) or 0)
   local acc60 = math.floor(tonumber(vehicle:GetAttribute("acc_0_60")) or 0)
   local turnangle = math.floor(tonumber(vehicle:GetAttribute("turn_angle")) or 0)
   local locked = vehicle:GetAttribute("locked")

   ui.MaxAcc.Text = "Max Acceleration: " .. (acc or "N/A")
   ui.MaxSpeed.Text = "Max Speed: " .. (speed or "N/A")
   ui.Acc60.Text = "Acceleration (0 To 60): " .. (acc60 or "N/A")
   ui.TurnAngle.Text = "Turn Angle: " .. (turnangle or "N/A")
   ui.LockedStatus.Text = "Locked: " .. tostring(locked)
end

for _, model in ipairs(Vehicles:GetChildren()) do
   if model:IsA("Model") and Validate_Model(model) then
      CreateEntry(model)
   end
end

Vehicles.ChildAdded:Connect(function(model)
   task.delay(0.1, function()
      if model:IsA("Model") and Validate_Model(model) then
         CreateEntry(model)
      end
   end)
end)

getgenv().VehicleStatsActive = true

task.spawn(function()
   while getgenv().VehicleStatsActive and task.wait(0.1) do
      for vehicle, _ in pairs(VehicleUI) do
         if vehicle.Parent ~= Vehicles then
            VehicleUI[vehicle].Frame:Destroy()
            VehicleUI[vehicle] = nil
            Scroller.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
         else
            UpdateStatistics(vehicle)
         end
      end
   end
end)
