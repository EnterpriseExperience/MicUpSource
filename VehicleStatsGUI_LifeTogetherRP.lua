local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Vehicles = getgenv().Workspace:FindFirstChild("Vehicles")
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/Notification_Lib.lua"))()
if getgenv().Vehicle_Stats_GUI_Active then
    return 
end

wait()
getgenv().Vehicle_Stats_GUI_Active = true
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
    return getgenv().notify("Error", "Vehicles Folder not found in Workspace!", 5)
end

getgenv().get_color_name = function(color)
	if not color or typeof(color) ~= "Color3" then
		return "Unknown"
	end

	local colors = {
		{"White",1,242,243,243},
		{"Grey",2,161,165,162},
		{"Light yellow",3,249,233,153},
		{"Brick yellow",5,215,197,154},
		{"Light green (Mint)",6,194,218,184},
		{"Light reddish violet",9,232,186,200},
		{"Pastel Blue",11,128,187,219},
		{"Light orange brown",12,203,132,66},
		{"Nougat",18,204,142,105},
		{"Bright red",21,196,40,28},
		{"Med. reddish violet",22,196,112,160},
		{"Bright blue",23,13,105,172},
		{"Bright yellow",24,245,205,48},
		{"Earth orange",25,98,71,50},
		{"Black",26,27,42,53},
		{"Dark grey",27,109,110,108},
		{"Dark green",28,40,127,71},
		{"Medium green",29,161,196,140},
		{"Lig. Yellowich orange",36,243,207,155},
		{"Bright green",37,75,151,75},
		{"Dark orange",38,160,95,53},
		{"Light bluish violet",39,193,202,222},
		{"Transparent",40,236,236,236},
		{"Tr. Red",41,205,84,75},
		{"Tr. Lg blue",42,193,223,240},
		{"Tr. Blue",43,123,182,232},
		{"Tr. Yellow",44,247,241,141},
		{"Light blue",45,180,210,228},
		{"Tr. Flu. Reddish orange",47,217,133,108},
		{"Tr. Green",48,132,182,141},
		{"Tr. Flu. Green",49,248,241,132},
		{"Phosph. White",50,236,232,222},
		{"Light red",100,238,196,182},
		{"Medium red",101,218,134,122},
		{"Medium blue",102,110,153,202},
		{"Light grey",103,199,193,183},
		{"Bright violet",104,107,50,124},
		{"Br. yellowish orange",105,226,155,64},
		{"Bright orange",106,218,133,65},
		{"Bright bluish green",107,0,143,156},
		{"Earth yellow",108,104,92,67},
		{"Bright bluish violet",110,67,84,147},
		{"Tr. Brown",111,191,183,177},
		{"Medium bluish violet",112,104,116,172},
		{"Tr. Medi. reddish violet",113,229,173,200},
		{"Med. yellowish green",115,199,210,60},
		{"Med. bluish green",116,85,165,175},
		{"Light bluish green",118,183,215,213},
		{"Br. yellowish green",119,164,189,71},
		{"Lig. yellowish green",120,217,228,167},
		{"Med. yellowish orange",121,231,172,88},
		{"Br. reddish orange",123,211,111,76},
		{"Bright reddish violet",124,146,57,120},
		{"Light orange",125,234,184,146},
		{"Tr. Bright bluish violet",126,165,165,203},
		{"Gold",127,220,188,129},
		{"Dark nougat",128,174,122,89},
		{"Silver",131,156,163,168},
		{"Neon orange",133,213,115,61},
		{"Neon green",134,216,221,86},
		{"Sand blue",135,116,134,157},
		{"Sand violet",136,135,124,144},
		{"Medium orange",137,224,152,100},
		{"Sand yellow",138,149,138,115},
		{"Earth blue",140,32,58,86},
		{"Earth green",141,39,70,45},
		{"Tr. Flu. Blue",143,207,226,247},
		{"Sand blue metallic",145,121,136,161},
		{"Sand violet metallic",146,149,142,163},
		{"Sand yellow metallic",147,147,135,103},
		{"Dark grey metallic",148,87,88,87},
		{"Black metallic",149,22,29,50},
		{"Light grey metallic",150,171,173,172},
		{"Sand green",151,120,144,130},
		{"Sand red",153,149,121,119},
		{"Dark red",154,123,46,47},
		{"Tr. Flu. Yellow",157,255,246,123},
		{"Tr. Flu. Red",158,225,164,194},
		{"Gun metallic",168,117,108,98},
		{"Dark stone grey",199,99,95,98},
		{"Medium stone grey",194,163,162,165},
		{"Light stone grey",208,229,228,223},
		{"Really black",1003,17,17,17},
		{"Really red",1004,255,0,0},
		{"Deep orange",1005,255,176,0},
		{"Alder",1006,180,128,255},
		{"Dusty Rose",1007,163,75,75},
		{"Olive",1008,193,190,66},
		{"New Yeller",1009,255,255,0},
		{"Really blue",1010,0,0,255},
		{"Navy blue",1011,0,32,96},
		{"Deep blue",1012,33,84,185},
		{"Cyan",1013,4,175,236},
		{"CGA brown",1014,170,85,0},
		{"Magenta",1015,170,0,170},
		{"Pink",1016,255,102,204},
		{"Deep orange",1017,255,175,0},
		{"Teal",1018,18,238,212},
		{"Toothpaste",1019,0,255,255},
		{"Lime green",1020,0,255,0},
		{"Camo",1021,58,125,21},
		{"Grime",1022,127,142,100},
		{"Lavender",1023,140,91,159},
		{"Pastel light blue",1024,175,221,255},
		{"Pastel orange",1025,255,201,201},
		{"Pastel violet",1026,177,167,255},
		{"Pastel blue-green",1027,159,243,233},
		{"Pastel green",1028,204,255,204},
		{"Pastel yellow",1029,255,255,204},
		{"Pastel brown",1030,255,204,153},
		{"Royal purple",1031,98,37,209},
		{"Hot pink",1032,255,0,191},
	}

	local closest, closestDist = "Unknown", math.huge
	local r, g, b = color.R * 255, color.G * 255, color.B * 255

	for _, c in ipairs(colors) do
		local _, _, R, G, B = unpack(c)
		local dist = (R - r)^2 + (G - g)^2 + (B - b)^2
		if dist < closestDist then
			closestDist = dist
			closest = c[1]
		end
	end

	return closest
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
if not getgenv().get_vehicle then
    getgenv().get_vehicle = get_vehicle
end

pcall(function()
    if getgenv().VehicleStatsGUI then
        return 
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
if not getgenv().Send then
    getgenv().Send = send_remote
end
wait(0.2)
function change_vehicle_color(Color, Vehicle)
    send_remote("vehicle_color", Color, Vehicle)
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
UIListLayout.Padding = UDim.new(0, 10)

local VehicleUI = {}

local function CreateEntry(vehicle)
    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1, 0, 0, 190)
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

    local colorLabel = maxAcc:Clone()
    colorLabel.Position = UDim2.new(0, 5, 0, 144)
    colorLabel.Text = "Color: N/A"
    colorLabel.Parent = Holder

    local spawnButton = Instance.new("TextButton")
    spawnButton.Text = "Spawn This Car (With Settings)"
    spawnButton.Size = UDim2.new(1, -20, 0, 20)
    spawnButton.Position = UDim2.new(0, 10, 0, 168)
    spawnButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    spawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    spawnButton.Font = Enum.Font.Gotham
    spawnButton.TextSize = 13
    spawnButton.Parent = Holder

    local spawnCorner = Instance.new("UICorner", spawnButton)
    spawnCorner.CornerRadius = UDim.new(0, 6)

    spawnButton.MouseButton1Click:Connect(function()
        local Vehicle_LocalPlr = get_vehicle()
        if not getgenv().Get then
            getgenv().Get = send_function
        end
        wait(0.3)

        if not Vehicle_LocalPlr then
            getgenv().Get("spawn_vehicle", tostring(vehicle.Name))
        elseif Vehicle_LocalPlr.Name ~= vehicle.Name then
            getgenv().Get("spawn_vehicle", tostring(vehicle.Name))
        end

        wait(0.5)

        Vehicle_LocalPlr = get_vehicle()
        if Vehicle_LocalPlr and Vehicle_LocalPlr.Name == tostring(vehicle.Name) then
            Vehicle_LocalPlr:SetAttribute("max_speed", vehicle:GetAttribute("max_speed"))
            Vehicle_LocalPlr:SetAttribute("max_acc", vehicle:GetAttribute("max_acc"))
            Vehicle_LocalPlr:SetAttribute("acc_0_60", vehicle:GetAttribute("acc_0_60"))
            wait()
            local c = vehicle:GetAttribute("color")
            change_vehicle_color(Color3.new(c.R, c.G, c.B), Vehicle_LocalPlr)
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
        ColorLabel = colorLabel,
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
    local c = vehicle:GetAttribute("color")

    if c and typeof(c) == "Color3" then
        local colorName = getgenv().get_color_name(c)
        ui.ColorLabel.Text = "Color: " .. colorName
    else
        ui.ColorLabel.Text = "Color: N/A"
    end
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
