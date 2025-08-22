local Flames_API = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua'))()
local Raw_Version = "V1.0.9"
local Script_Version = tostring(Raw_Version).."-DE"
local Character = Flames_API.Character
local Humanoid = Flames_API.Humanoid
local HumanoidRootPart = Flames_API.HumanoidRootPart
local ReplicatedStorage = Flames_API.Service("ReplicatedStorage")
local Players = Flames_API.Service("Players")
local Workspace = Flames_API.Service("Workspace")
local RunService = Flames_API.Service("RunService")
local TweenService = Flames_API.Service("TweenService")
local Vehicles = Workspace:FindFirstChild("Vehicles") or Workspace:WaitForChild("Vehicles", 3) or nil
local LocalPlayer = Flames_API.LocalPlayer
local Remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:WaitForChild("Remotes", 3) or nil
local CustomPurchase_RF = Remotes and Remotes:FindFirstChild("CustomizationPurchase") or Emotes:WaitForChild("CustomizationPurchase", 3) or nil
local Game_Folder = Workspace:FindFirstChild("Game") or Workspace:WaitForChild("Game", 3) or nil
local Races = Game_Folder and Game_Folder:FindFirstChild("Races") or Game_Folder and Game_Folder:WaitForChild("Races", 3) or nil
local LocalSession = Races and Races:FindFirstChild("LocalSession") or Races and Races:WaitForChild("LocalSession", 3) or nil
local RaceStart_RE = Remotes and Remotes:FindFirstChild("RaceStartTimeTrial") or Remotes and Remotes:WaitForChild("RaceStartTimeTrial", 3) or nil
local Teleport_RE = Remotes and Remotes:FindFirstChild("Teleport") or Remotes and Remotes:WaitForChild("Teleport", 3) or nil
local Checkpoint_RF = Remotes and Remotes:FindFirstChild("RaceCheckpoint") or Remotes and Remotes:WaitForChild("RaceCheckpoint", 3) or nil

function notify(Title, Content, Time)
    if not Time or Time == nil then
        Time = 5
    end

    if not Title then
        Title = "Alert:"
    end

    Flames_API.notify(tostring(Title), tostring(Content), tonumber(Time))
end

getgenv().notify = notify

getgenv().convert_color3 = function(r, g, b)
    return Color3.new(r/255, g/255, b/255)
end

local colors = {
   Color3.new(0.6392157077789307, 0.6352941393852234, 0.6470588445663452),
   Color3.new(0.4588235318660736, 0, 0),
   Color3.new(0.20000000298023224, 0.3450980484485626, 0.5098039507865906),
   Color3.new(0.06666667014360428, 0.06666667014360428, 0.06666667014360428),
   Color3.new(1, 0.6901960968971252, 0),
   Color3.new(0.1568627506494522, 0.1568627506494522, 0.1568627506494522),
   Color3.new(0.8313725590705872, 0, 0),
   Color3.new(0.1725490242242813, 0.3960784375667572, 0.11372549086809158),
   Color3.new(0, 0.125490203499794, 0.3764705955982208),
   Color3.new(0.3803921639919281, 0.3764705955982208, 0.3843137323856354),
   Color3.new(0.9725490212440491, 0.9725490212440491, 0.9725490212440491),
   Color3.new(0.6274510025978088, 0.5176470875740051, 0.30980393290519714),
   Color3.new(1, 0.8352941274642944, 0),
   Color3.new(0.8352941274642944, 0.45098039507865906, 0.239215686917305),
   Color3.new(0.03529411926865578, 0.5372549295425415, 0.8117647171020508),
   Color3.new(0.9098039269447327, 0.3137255012989044, 0.0313725508749485),
   Color3.new(0.33725491166114807, 0.1411764770746231, 0.1411764770746231),
   Color3.new(0.3137255012989044, 0.529411792755127, 0.25882354378700256),
   Color3.new(0.15294118225574493, 0.27450981736183167, 0.1764705926179886),
   Color3.new(0.8549019694328308, 0.5215686559677124, 0.2549019753932953),
   Color3.new(0.48235294222831726, 0, 0.48235294222831726),
   Color3.new(0.4156862795352936, 0.6117647290229797, 0.886274516582489),
   Color3.new(0.41960784792900085, 0.19607843458652496, 0.48627451062202454),
   Color3.new(0.48627451062202454, 0.3607843220233917, 0.27450981736183167),
   Color3.new(0, 1, 0),
   Color3.new(0, 0, 0)
}

local Vehicle_Calipers = {"FL", "FR", "RL", "RR"}

local function Get_Vehicle()
    local Vehicles = Workspace:FindFirstChild("Vehicles") or Workspace:WaitForChild("Vehicles", 3) or nil
    local model = Vehicles:FindFirstChild(LocalPlayer.Name)

    return model and model:GetAttribute("VehicleId") or nil
end

local function Get_Vehicle_Model()
    local Vehicles = Workspace:FindFirstChild("Vehicles") or Workspace:WaitForChild("Vehicles", 3) or nil
    local model = Vehicles:FindFirstChild(LocalPlayer.Name)

    return model or nil
end

function Fire_F(RemoteF, Args)
    if not RemoteF then return notify("Failure:", "RemoteFunction not provided!") end

    RemoteF:InvokeServer(unpack(Args))
end

function Fire_E(RemoteE, Args)
    if not RemoteE then return notify("Failure:", "RemoteEvent not provided!") end

    RemoteE:FireServer(unpack(Args))
end

function change_car_color(color)
    local Vehicle = Get_Vehicle()
    if not Vehicle then return end

    local args = {
        "Paint",
        "Primary",
        Get_Vehicle(),
        {
            Color = color,
            Reflectance = 0
        }
    }
    
    Fire_F(CustomPurchase_RF, args)
end

function change_rim_color(color)
    local Vehicle = Get_Vehicle()
    if not Vehicle then return end

    for i, caliper in pairs(Vehicle_Calipers) do
        local args = {
            "Paint",
            "WheelRim"..caliper,
            Get_Vehicle(),
            {
                Color = color,
                Reflectance = 0
            }
        }
        
        Fire_F(CustomPurchase_RF, args)
    end
end

function change_headlights_color(color)
    local Vehicle = Get_Vehicle()
    if not Vehicle then return end

    local args = {
        "Paint",
        "Headlights",
        Get_Vehicle(),
        {
            Color = color
        }
    }

    Fire_F(CustomPurchase_RF, args)
end

function change_interior_color(color)
    local Vehicle = Get_Vehicle()
    if not Vehicle then return end

    local args = {
        "Paint",
        "Interior",
        Get_Vehicle(),
        {
            Color = color
        }
    }

    Fire_F(CustomPurchase_RF, args)
end

function change_caliper_color(color)
    local Vehicle = Get_Vehicle()
    if not Vehicle then return end

    for i, caliper in pairs(Vehicle_Calipers) do
        local args = {
            "Paint",
            "WheelCaliper"..caliper,
            Get_Vehicle(),
            {
                Color = color
            }
        }

        Fire_F(CustomPurchase_RF, args)
    end
end

function change_nitro_color(color)
    local Vehicle = Get_Vehicle()
    if not Vehicle then return end

    local args = {
        "Paint",
        "NitrousPrimary",
        Get_Vehicle(),
        {
            Color = color
        }
    }
    local args_2 = {
        "Paint",
        "NitrousSecondary",
        Get_Vehicle(),
        {
            Color = color
        }
    }

    Fire_F(CustomPurchase_RF, args)
    Fire_F(CustomPurchase_RF, args_2)
end

-- Not in use right now, costs money, but we'll see how I implement it.
function change_suspension(Suspension)
    local Vehicle = Get_Vehicle()
    if not Vehicle then return end

    local args = {
        "Suspension",
        "Height",
        Get_Vehicle(),
        {
            RL = tonumber(Suspension),
            RR = tonumber(Suspension),
            FR = tonumber(Suspension),
            FL = tonumber(Suspension)
        }
    }
    
    Fire_F(CustomPurchase_RF, args)
end

local function get_executor()
    local name
    if identifyexecutor then
        name = identifyexecutor()
    end

    return { Name = name or "Unknown Executor"}
end

local function detect_executor()
    local executor_details = get_executor()
    return string.format("%s", executor_details.Name)
end
wait(0.1)
local executor_Name = detect_executor()

function low_level_executor()
    if executor_Name == "Solara" or string.find(executor_Name, "JJSploit") or executor_Name == "Xeno" then
        return true
    else
        return false
    end
end

local function LocalPlayer_loaded()
    local player = Players.LocalPlayer
    if not player then
        repeat task.wait() until Players.LocalPlayer
        player = Players.LocalPlayer
    end

    if not player.Character or not player.Character:FindFirstChild("Humanoid") then
        player.CharacterAdded:Wait()
        repeat task.wait() until player.Character:FindFirstChild("Humanoid")
    end
end

local function render_safe()
    RunService.RenderStepped:Wait()
    task.wait(0.2)
end

local function load_rayfield()
    local attempts = 0
    local maxAttempts = 10
    local success = false
    local result

    repeat
        attempts += 1
        success, result = pcall(function()
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
LocalPlayer_loaded()
render_safe()

Rayfield = load_rayfield()

if typeof(Rayfield) == "table" and Rayfield.CreateWindow then
    Window = Rayfield:CreateWindow({
        Name = "🏎️Driving Empire🏎️ | "..tostring(Script_Version).." | "..tostring(executor_Name),
        LoadingTitle = "Welcome, "..tostring(LocalPlayer),
        LoadingSubtitle = "Driving Empire | Hub.",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "DrivingEmpire-Config",
            FileName = "DrivingEmpire_ScriptHub"
        },
        Discord = {
            Enabled = false,
            Invite = "",
            RememberJoins = false
        },
        KeySystem = false,
        KeySettings = {
            Title = "None",
            Subtitle = "No key system is provided.",
            Note = "lmao.",
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
function R_Notify(title, content, duration)
    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(duration),
        Image = 0,
        Actions = {
            Ignore = {
                Name = "Okay.",
                Callback = function()
                print("...")
                end
            },
        },
    })
end
wait(0.2)
local Tab1 = Window:CreateTab("🏡 Main 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Main 🏡 |")
local Tab2 = Window:CreateTab("⭐ Extras ⭐", 0)
local Section2 = Tab2:CreateSection("| ⭐ Extra Content ⭐ |")
local Tab3 = Window:CreateTab("🏎️ Vehicle 🏎️", 0)
local Section3 = Tab3:CreateSection("| 🏎️ Vehicle Content 🏎️ |")
wait(0.2)
getgenv().RainbowVehicleToggle = Tab3:CreateToggle({
Name = "Rainbow Vehicle (FE)",
CurrentValue = false,
Flag = "RainbowCarFEToggle",
Callback = function(Rainbow_Vehicle_Enabled)
    if Rainbow_Vehicle_Enabled then
        getgenv().Rainbow_Vehicle_Toggle = true
        while getgenv().Rainbow_Vehicle_Toggle == true do
        task.wait()
            for _, color_change in pairs(colors) do
                change_car_color(color_change)
                task.wait()
            end
        end
    else
        getgenv().Rainbow_Vehicle_Toggle = false
    end
end,})

getgenv().RainbowRimsToggle = Tab3:CreateToggle({
Name = "Rainbow Rims (FE)",
CurrentValue = false,
Flag = "RainbowRimsFEToggle",
Callback = function(Rainbow_Rims_Enabled)
    if Rainbow_Rims_Enabled then
        getgenv().Rainbow_Rims_Toggle = true
        while getgenv().Rainbow_Rims_Toggle == true do
        task.wait()
            for _, color_change in pairs(colors) do
                change_rim_color(color_change)
                task.wait()
            end
        end
    else
        getgenv().Rainbow_Rims_Toggle = false
    end
end,})

getgenv().RainbowHeadlightsToggle = Tab3:CreateToggle({
Name = "Rainbow Headlights (FE)",
CurrentValue = false,
Flag = "RainbowHeadlightsFEToggle",
Callback = function(Rainbow_Headlights_Enabled)
    if Rainbow_Headlights_Enabled then
        getgenv().Rainbow_Headlights_Toggle = true
        while getgenv().Rainbow_Headlights_Toggle == true do
        task.wait()
            for _, color_change in pairs(colors) do
                change_headlights_color(color_change)
                task.wait()
            end
        end
    else
        getgenv().Rainbow_Headlights_Toggle = false
    end
end,})

getgenv().RainbowInteriorToggle = Tab3:CreateToggle({
Name = "Rainbow Interior (FE)",
CurrentValue = false,
Flag = "RainbowInteriorFEToggle",
Callback = function(Rainbow_Interior_Enabled)
    if Rainbow_Interior_Enabled then
        getgenv().Rainbow_Interior_Toggle = true
        while getgenv().Rainbow_Interior_Toggle == true do
        task.wait()
            for _, color_change in pairs(colors) do
                change_interior_color(color_change)
                task.wait()
            end
        end
    else
        getgenv().Rainbow_Interior_Toggle = false
    end
end,})

getgenv().RainbowCalipersToggle = Tab3:CreateToggle({
Name = "Rainbow Calipers (FE)",
CurrentValue = false,
Flag = "RainbowCalipersFEToggle",
Callback = function(Rainbow_Calipers_Enabled)
    if Rainbow_Calipers_Enabled then
        getgenv().Rainbow_Calipers_Toggle = true
        while getgenv().Rainbow_Calipers_Toggle == true do
        task.wait()
            for _, color_change in pairs(colors) do
                change_caliper_color(color_change)
                task.wait()
            end
        end
    else
        getgenv().Rainbow_Calipers_Toggle = false
    end
end,})

getgenv().RainbowNitroToggle = Tab3:CreateToggle({
Name = "Rainbow Nitro (FE)",
CurrentValue = false,
Flag = "RainbowNitroFEToggle",
Callback = function(Rainbow_Nitro_Enabled)
    if Rainbow_Nitro_Enabled then
        getgenv().Rainbow_Nitro_Toggle = true
        while getgenv().Rainbow_Nitro_Toggle == true do
        task.wait()
            for _, color_change in pairs(colors) do
                change_nitro_color(color_change)
                task.wait()
            end
        end
    else
        getgenv().Rainbow_Nitro_Toggle = false
    end
end,})

local Result = low_level_executor()

if Result == false then
    getgenv().TurnRadius = Tab1:CreateSlider({ 
    Name = "Turn Radius",
    Range = {0, 250},
    Increment = 1,
    Suffix = "",
    CurrentValue = 30,
    Flag = "SlidingTurnRadiusValue",
    Callback = function(Turn_Radius)
        local Vehicle = Get_Vehicle_Model()
        if not Vehicle then
            return 
        end
        local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
        if not Tuning_Module_S then return end
        local Req_TuneModule = require(Tuning_Module_S)
        if not Req_TuneModule then return end

        Req_TuneModule["TurnRadius"] = tonumber(Turn_Radius)
    end,})

    getgenv().TurnSpeed = Tab1:CreateSlider({ 
    Name = "Turn Speed",
    Range = {0, 20},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "SlidingTurnSpeedValue",
    Callback = function(Turn_Speed)
        local Vehicle = Get_Vehicle_Model()
        if not Vehicle then
            return 
        end
        local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
        if not Tuning_Module_S then return end
        local Req_TuneModule = require(Tuning_Module_S)
        if not Req_TuneModule then return end

        Req_TuneModule["TurnSpeed"] = tonumber(Turn_Speed)
    end,})

    getgenv().BrakeTorque = Tab1:CreateSlider({ 
    Name = "Brake Torque",
    Range = {50, 100000},
    Increment = 100,
    Suffix = "",
    CurrentValue = 5000,
    Flag = "SlidingBrakeTorqueValue",
    Callback = function(Brake_Torque)
        local Vehicle = Get_Vehicle_Model()
        if not Vehicle then
            return 
        end
        local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
        if not Tuning_Module_S then return end
        local Req_TuneModule = require(Tuning_Module_S)
        if not Req_TuneModule then return end

        Req_TuneModule["BrakeTorque"] = tonumber(Brake_Torque)
    end,})

    getgenv().EngineTop = Tab1:CreateSlider({ 
    Name = "Engine Top",
    Range = {100, 25000},
    Increment = 5,
    Suffix = "",
    CurrentValue = 5000,
    Flag = "SlidingEngineTopValue",
    Callback = function(Engine_Top)
        local Vehicle = Get_Vehicle_Model()
        if not Vehicle then
            return 
        end
        local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
        if not Tuning_Module_S then return end
        local Req_TuneModule = require(Tuning_Module_S)
        if not Req_TuneModule then return end

        Req_TuneModule["EngineTop"] = tonumber(Engine_Top)
    end,})

    getgenv().Turbo = Tab1:CreateToggle({ 
    Name = "Turbo",
    CurrentValue = false,
    Flag = "TurboChargersVehicleToggle",
    Callback = function(Turbo_Enabled)
        if Turbo_Enabled then
            getgenv().Turbo_Chargers_Enabled = true
            local Vehicle = Get_Vehicle_Model()
            if not Vehicle then
                return notify("Failure:", "No Vehicle available, spawn one!")
            end
            local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
            if not Tuning_Module_S then return notify("Failure:", "No Vehicle available, spawn one!") end
            local Req_TuneModule = require(Tuning_Module_S)
            if not Req_TuneModule then return notify("Failure:", "No Vehicle available, spawn one!") end

            Req_TuneModule["Turbo"] = true
        else
            getgenv().Turbo_Chargers_Enabled = false
            local Vehicle = Get_Vehicle_Model()
            if not Vehicle then
                return notify("Failure:", "No Vehicle available, spawn one!")
            end
            local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
            if not Tuning_Module_S then return notify("Failure:", "No Vehicle available, spawn one!") end
            local Req_TuneModule = require(Tuning_Module_S)
            if not Req_TuneModule then return notify("Failure:", "No Vehicle available, spawn one!") end

            Req_TuneModule["Turbo"] = false
        end
    end,})

    getgenv().Superchargers = Tab1:CreateToggle({ 
    Name = "Supercharger",
    CurrentValue = false,
    Flag = "SuperChargersVehicleToggle",
    Callback = function(Supercharger_Enabled)
        if Supercharger_Enabled then
            getgenv().Supercharger_Chargers_Enabled = true
            local Vehicle = Get_Vehicle_Model()
            if not Vehicle then
                return notify("Failure:", "No Vehicle available, spawn one!")
            end
            local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
            if not Tuning_Module_S then return notify("Failure:", "No Vehicle available, spawn one!") end
            local Req_TuneModule = require(Tuning_Module_S)
            if not Req_TuneModule then return notify("Failure:", "No Vehicle available, spawn one!") end

            Req_TuneModule["SuperCharger"] = true
        else
            getgenv().Supercharger_Chargers_Enabled = false
            local Vehicle = Get_Vehicle_Model()
            if not Vehicle then
                return notify("Failure:", "No Vehicle available, spawn one!")
            end
            local Tuning_Module_S = Vehicle and Vehicle:FindFirstChild("Tune") or Vehicle and Vehicle:WaitForChild("Tune", 3)
            if not Tuning_Module_S then return notify("Failure:", "No Vehicle available, spawn one!") end
            local Req_TuneModule = require(Tuning_Module_S)
            if not Req_TuneModule then return notify("Failure:", "No Vehicle available, spawn one!") end

            Req_TuneModule["SuperCharger"] = false
        end
    end,})
else
    warn("Vehicle modification not enabled, low level executor detected.")
end
wait(0.2)
local StartPosition = CFrame.new(4940.19775, 61.0195084, -1933.99927)
local EndPosition   = CFrame.new(1827.3407, 61.0150146, -658.946655)

local function TP(cframe)
    local car = Get_Vehicle_Model()
    if car and car.PrimaryPart then
        car:SetPrimaryPartCFrame(cframe)
    end
end

local function DriveForward(duration, speed)
    local car = Get_Vehicle_Model()
    if not car then return end
    local Weight = car:FindFirstChild("Weight")
    if not Weight then return end

    Weight.Anchored = false
    Weight.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * speed
    task.wait(duration)
    Weight.AssemblyLinearVelocity = Vector3.new(0,0,0)
end

local function VelocityTP(cframe)
    local car = Get_Vehicle_Model()
    if not car or not car.PrimaryPart then
        getgenv().AutoFarm_Running = false
        return
    end
    local TeleportSpeed = 300
    local BodyGyro = Instance.new("BodyGyro", car.PrimaryPart)
    BodyGyro.P = 3000
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.CFrame = car.PrimaryPart.CFrame
    local BodyVelocity = Instance.new("BodyVelocity", car.PrimaryPart)
    BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BodyVelocity.Velocity = CFrame.new(car.PrimaryPart.Position, cframe.Position).LookVector * TeleportSpeed

    wait((car.PrimaryPart.Position - cframe.Position).Magnitude / TeleportSpeed)
    BodyVelocity.Velocity = Vector3.new()
    wait(0.1)
    BodyVelocity:Destroy()
    BodyGyro:Destroy()
end
wait(0.2)
getgenv().AutoFarm_Running = false

local function StartAutoFarm()
    getgenv().AutoFarm_Running = true
    task.spawn(function()
        while getgenv().AutoFarm_Running == true do
            pcall(function()
                local car = Get_Vehicle_Model()
                if not car then return end
                DriveForward(1, math.random(250,600))
                car:SetPrimaryPartCFrame(EndPosition + Vector3.new(0,3,0))

                DriveForward(1, math.random(250,600))
                car:SetPrimaryPartCFrame(StartPosition + Vector3.new(0,3,0))
            end)
            task.wait(0.5)
        end
    end)
end

local function PushCarForward(speed, duration)
    local car = Get_Vehicle_Model()
    if not car or not car.PrimaryPart then return end

    local Weight = car:FindFirstChild("Weight")
    if not Weight then return end
    Weight.Anchored = false
    Weight.AssemblyLinearVelocity = car.PrimaryPart.CFrame.LookVector * speed
    task.wait(duration or 0.5)
    Weight.AssemblyLinearVelocity = Vector3.new(0,5,0)
end

local function StopAutoFarm()
    getgenv().AutoFarm_Running = false
    local car = Get_Vehicle_Model()
    if car then
        local Weight = car:FindFirstChild("Weight")
        if Weight then
            Weight.AssemblyLinearVelocity = Vector3.new(0,0,0)
        end
    end
end
wait(0.2)
getgenv().AutoFarm_VehicleMethod = Tab1:CreateToggle({
Name = "Auto Farm (Method 1, BYPASSES NEW LIMIT/DELAY!)",
CurrentValue = false,
Flag = "EzAutoFarmMethod1",
Callback = function(auto_farm_1)
    local car = Get_Vehicle_Model()
    if not Get_Vehicle() then
        StopAutoFarm()
        getgenv().Auto_Farm_Enabled = false
        getgenv().AutoFarm_VehicleMethod:Set(false)
        return R_Notify("Failure:", "Spawn a Vehicle before using this!", 5)
    end

    if not car then
        StopAutoFarm()
        getgenv().Auto_Farm_Enabled = false
        getgenv().AutoFarm_VehicleMethod:Set(false)
        return R_Notify("Failure:", "Spawn a Vehicle before using this!", 5)
    end

    R_Notify("Heads Up:", "This even works in Private Servers!", 5)
    R_Notify("Alert:", "If it seems like you're not earning anymore, just wait!", 5)

    if auto_farm_1 then
        getgenv().Auto_Farm_Enabled = true
        StartAutoFarm()
    else
        getgenv().Auto_Farm_Enabled = false
        StopAutoFarm()
    end
end,})

function enable_anti_afk()
    local GC = getconnections or get_signal_cons

    if GC then
        for i,v in pairs(GC(LocalPlayer.Idled)) do
            if v["Disable"] then
                v["Disable"](v)
            elseif v["Disconnect"] then
                v["Disconnect"](v)
            end
        end
        task.wait(0.2)
        getgenv().Anti_AFK_1 = true
    else
        local VirtualUser = cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")
        getgenv().Anti_AFK_2 = true
        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end

-- I have something else planned with this, not yet though.
function enable_anti_afk_alt2()
    getgenv().Anti_AFK_Toggled = true
    while getgenv().Anti_AFK_Toggled == true do
        task.wait(30)
        if Character and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("HumanoidRootPart") then
            Humanoid:Move(Vector3.new(0,0,0), false)
        end
    end
end

-- To be continued...
local function TweenCarTo(cframe, time)
    local car = Get_Vehicle_Model()
    if not car or not car.PrimaryPart then return end

    local weight = car:FindFirstChild("Weight")
    if weight then weight.Anchored = true end

    local tweenInfo = TweenInfo.new(time or 2, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(car.PrimaryPart, tweenInfo, {CFrame = cframe})
    tween:Play()
    tween.Completed:Wait()

    if weight then weight.Anchored = false end
end

local function MoveCarThrough(target, speed)
    local car = Get_Vehicle_Model()
    if not car or not car.PrimaryPart then return end
    local weight = car:FindFirstChild("Weight")
    if not weight then return end

    weight.Anchored = false

    local direction = (target.Position - car.PrimaryPart.Position).Unit
    weight.AssemblyLinearVelocity = direction * (speed or 250)

    repeat
        task.wait()
    until (car.PrimaryPart.Position - target.Position).Magnitude < 15

    weight.AssemblyLinearVelocity = Vector3.new(0,0,0)
end

getgenv().Anti_AFK_1 = Tab2:CreateButton({
Name = "Anti AFK",
Callback = function()
    enable_anti_afk()
    wait(0.5)
    if getgenv().Anti_AFK_1 or getgenv().Anti_AFK_1 == true then
        R_Notify("Success:", "Enabled AntiAFK Bypass 1 (Best Method)", 5)
    elseif getgenv().Anti_AFK_2 or getgenv().Anti_AFK_2 == true then
        R_Notify("Success:", "Enabled AntiAFK Bypass 2 (Clicking Method)", 5)
    else
        return R_Notify("Failure:", "No AntiAFK scripts we're enabled!", 5)
    end
end,})

-- [[ I have something planned with this soon, you'll see... ]] --
--[[getgenv().Anti_AFK_2 = Tab1:CreateButton({
Name = "Anti AFK (Method 2)",
Callback = function()
    enable_anti_afk_alt2()
end,})--]]

getgenv().Drag_Race_Farm = Tab2:CreateToggle({
Name = "Drag Race Farm (EZ MONEY!)",
CurrentValue = false,
Flag = "DragRacingFarm",
Callback = function(drag_race_auto_farm)
    if drag_race_auto_farm then
        getgenv().Drag_Race_Farm_Enabled = true

        if getgenv().Rainbow_Vehicle_Toggle or getgenv().Rainbow_Vehicle_Toggle == true then
            getgenv().Rainbow_Vehicle_Toggle = false
            wait(0.2)
            getgenv().RainbowVehicleToggle:Set(false)
        end

        if getgenv().Rainbow_Rims_Toggle or getgenv().Rainbow_Rims_Toggle == true then
            getgenv().Rainbow_Rims_Toggle = false
            wait(0.2)
            getgenv().RainbowRimsToggle:Set(false)
        end

        if getgenv().Rainbow_Calipers_Toggle or getgenv().Rainbow_Calipers_Toggle == true then
            getgenv().Rainbow_Calipers_Toggle = false
            wait(0.2)
            getgenv().RainbowCalipersToggle:Set(false)
        end

        if getgenv().Highway_Farm_Enabled or getgenv().Highway_Farm_Enabled == true then
            getgenv().Highway_Farm_Enabled = false
            wait(0.2)
            getgenv().Highway_Race_Farm:Set(false)
        end

        if not Get_Vehicle() then
            getgenv().Drag_Race_Farm_Enabled = false
            getgenv().Drag_Race_Farm:Set(false)
            return R_Notify("Failure:", "Spawn a Vehicle before using this!", 5)
        end

        local car = Get_Vehicle_Model()
        if not car then
            getgenv().Drag_Race_Farm_Enabled = false
            getgenv().Drag_Race_Farm:Set(false)
            return R_Notify("Failure:", "Spawn a Vehicle before using this!", 5)
        end

        local Weight = car:FindFirstChild("Weight") or car:WaitForChild("Weight", 3)
        if not Weight then
            getgenv().Drag_Race_Farm_Enabled = false
            getgenv().Drag_Race_Farm:Set(false)
            return R_Notify("Error:", "Weight not found inside of Vehicle!", 5)
        end

        while getgenv().Drag_Race_Farm_Enabled == true do
            local Drag_Race = LocalSession:FindFirstChild("Drag")

            if not Get_Vehicle() then
                getgenv().Drag_Race_Farm_Enabled = false
                getgenv().Drag_Race_Farm:Set(false)
                return R_Notify("Failure:", "Spawn a Vehicle before using this!", 5)
            end

            if not Drag_Race then
                local args1 = {
                    "drag",
                    [5] = false,
                    [6] = "Drag Race Teleport Button"
                }
                Fire_E(Teleport_RE, args1)
                task.wait(5)
                local args2 = {
                    "Drag",
                    "RaceGoal"
                }
                Fire_E(RaceStart_RE, args2)
                wait(0.1)
                local DragRace = LocalSession:FindFirstChild("Drag")
                if DragRace then
                    local Checkpoints = DragRace:FindFirstChild("Checkpoints")
                    if Checkpoints then
                        local Checkpoint_1 = Checkpoints:FindFirstChild("1")
                        local Finish_Part = DragRace:FindFirstChild("Finish")
                        if Checkpoint_1 and Finish_Part and Get_Vehicle_Model() then
                            wait(16)
                            MoveCarThrough(Checkpoint_1, 800)
                            task.wait(0.5)
                            MoveCarThrough(Finish_Part, 800)
                        end
                    end
                end
            else
                wait(5)
            end
        end
    else
        getgenv().Drag_Race_Farm_Enabled = false
    end
end,})

getgenv().Highway_Race_Farm = Tab2:CreateToggle({
Name = "Auto Farm Highway Race (Broken!)",
CurrentValue = false,
Flag = "Highway_Racing_AutoFarm_Ez",
Callback = function(highway_farming)
    if highway_farming then
        getgenv().Highway_Farm_Enabled = true

        if not Get_Vehicle() then
            getgenv().Highway_Farm_Enabled = false
            getgenv().Highway_Race_Farm:Set(false)
            return R_Notify("Failure:", "Spawn a Vehicle before using this!", 5)
        end

        local car = Get_Vehicle_Model()
        if not car then
            getgenv().Highway_Farm_Enabled = false
            getgenv().Highway_Race_Farm:Set(false)
            return R_Notify("Failure:", "Spawn a Vehicle before using this!", 5)
        end

        local Weight = car:FindFirstChild("Weight") or car:WaitForChild("Weight", 3)
        if not Weight then
            getgenv().Highway_Farm_Enabled = false
            getgenv().Highway_Race_Farm:Set(false)
            return R_Notify("Error:", "Weight not found inside of Vehicle!", 5)
        end

        while getgenv().Highway_Farm_Enabled == true do
            local Drag_Race = LocalSession:FindFirstChild("Drag")

            if not Get_Vehicle() then
                getgenv().Highway_Farm_Enabled = false
                getgenv().Highway_Race_Farm:Set(false)
                return 
            end

            if not Drag_Race then
                local args = {
                    "highway",
                    [5] = false,
                    [6] = "Highway Race Teleport Button"
                }
                Fire_E(Teleport_RE, args)
                task.wait(3)
                local args2 = {
                    "Highway",
                    "NoOne"
                }
                Fire_E(RaceStart_RE, args2)
                wait(0.1)
                local HighwayRace = LocalSession:FindFirstChild("Highway")
                if HighwayRace then
                    local Checkpoints = HighwayRace:FindFirstChild("Checkpoints")
                    if Checkpoints then
                        local Checkpoint_1 = Checkpoints:FindFirstChild("1")
                        local Checkpoint_2 = Checkpoints:FindFirstChild("2")
                        local Checkpoint_3 = Checkpoints:FindFirstChild("3")
                        local Checkpoint_4 = Checkpoints:FindFirstChild("4")
                        local Checkpoint_5 = Checkpoints:FindFirstChild("5")
                        local Checkpoint_6 = Checkpoints:FindFirstChild("6")
                        local Checkpoint_7 = Checkpoints:FindFirstChild("7")
                        local Checkpoint_8 = Checkpoints:FindFirstChild("8")
                        local Finish_Part = HighwayRace:FindFirstChild("Finish")
                        if Checkpoint_1 and Finish_Part and Get_Vehicle_Model() then
                            wait(17.5)
                            MoveCarThrough(Checkpoint_1, 600)
                            task.wait(1.5)
                            MoveCarThrough(Checkpoint_2, 600)
                            task.wait(5)
                            MoveCarThrough(Checkpoint_3, 600)
                            task.wait(1.5)
                            MoveCarThrough(Checkpoint_4, 600)
                            task.wait(1.5)
                            MoveCarThrough(Checkpoint_5, 600)
                            task.wait(1.5)
                            MoveCarThrough(Checkpoint_6, 600)
                            task.wait(1.5)
                            MoveCarThrough(Checkpoint_7, 600)
                            task.wait(1.5)
                            MoveCarThrough(Checkpoint_8, 600)
                            task.wait(1.5)
                            MoveCarThrough(Finish_Part, 600)
                        end
                    end
                end
            else
                wait(3)
            end
        end
    end
end,})
