if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId ~= 54865335 then return end
local g = getgenv()
-- [[ you know how fucking long this shit took to get from the ModuleScript, had Grok extract this shit for me just incase. ]] --
local vehicles = {
    '02Camaro', '12C_CanAm', '12C_Spider', '22b', '240SX', '250GTO', '296GTB', '3000GT', '300CDonk', '300CHearse', '300CHearseGT', '300CLimo', '300SRT8', '33Stradale', '33Stradale_25', '360', '370z', '370zBase', '3Series', '400Z', '488Pista', '4C', '500K', '570s', '600LT', '675LT', '718_Spyder', '720s', '720SGT3', '74Camaro', '765LT', '812Superfast', '8C', '8Series', '911_80', '911_GT3RS', '911_Turbo', '911_TurboS', '917K', '917New', '918Police', '918_Spyder', '9300', '930Offroad', 'A110New', 'A2Quattro', 'A7Sportback', 'Absolut', 'ACCobra', 'Accord', 'Aero', 'Alfieri', 'AM4', 'Ambulance', 'AmgGT3', 'AMGGTBlack', 'AMGGTR', 'Antos', 'Apollo', 'ApolloEvo', 'AresS1', 'ArmoredCar', 'Arrow', 'Artura', 'Asterion', 'Aston', 'Atlantic', 'Aventador', 'AventadorGold', 'AventadorSVJ', 'B95', 'Bacalar', 'Batur', 'Bearcat', 'Beast', 'BelAir', 'BendyBus', 'Bentayga', 'BlazerK5', 'Bluebird', 'Bolide', 'BolidePolice', 'Bora', 'BoraR', 'BoxsterS', 'BoxTruck', 'Bread', 'BriishTaxi', 'Bronco', 'Bronco2Door', 'BroncoRacer', 'BRZ_21', 'BRZ_UD', 'C100', 'C2Corvette', 'C500', 'C63_AMG', 'C63_AMG_UD', 'C8Z06', 'California57', 'Camaro', 'Camaro2020', 'Camaro67', 'Camaro82', 'CamaroBumblebee', 'CamaroDonk', 'CamaroRS', 'CamaroRS16', 'Caravan', 'CargoShip', 'CarreraGT', 'CarreraRS', 'Cayenne', 'Cayenne_GTS_21', 'CaymanGT4', 'CaymanGT4RS', 'CaymanR', 'CCGT', 'CCXR', 'CementMixer', 'Centenario', 'Centodieci', 'Challenger', 'Challenger70', 'ChallengerThicc', 'Charger', 'Charger2015', 'Charger70', 'ChargerNew', 'ChargerPursuit', 'ChargerThicc', 'Cherokee', 'Chevelle', 'ChevySS', 'Chiron', 'ChristmasTruck', 'CityBus', 'Civic', 'Cizeta', 'CL500', 'ClassicSedan', 'CLK500', 'CLKGTR', 'CobaltSS', 'CobraR', 'Cobra_UD', 'Coffin', 'Colorado', 'CommodoreUte', 'Continental', 'ContinentalSS', 'Corrado', 'Corvette', 'CorvetteC1', 'CorvetteC2', 'CorvetteC6', 'CorvetteC6_ZR1', 'CorvetteC8', 'CosworthRS500', 'Countach', 'CountachDonk', 'Countach_22', 'Cruiser', 'CruiserSlicktop', 'Cruze', 'CRX', 'CT5V', 'CT5V_2', 'CTSV', 'CTSVCoupe', 'Cullinan', 'CullinanDonk', 'Cutlass442', 'CX75', 'Cybertruck', 'Daytona', 'DB12', 'DBS', 'DBSSuper', 'Defender', 'Demon', 'Dennis', 'Deora', 'Devel16', 'Diablo', 'Dino', 'Divo', 'DMC12', 'DMC12BTTF', 'DoubleDecker', 'DumpTruck', 'EB110', 'ElantraN', 'ElCamino', 'ElDorado', 'ElDorado2', 'Elise', 'Elva', 'Emira', 'Enzo', 'Equinox', 'EquinoxTaxi', 'Escalade', 'Esperante', 'Esprit', 'Essenza', 'eTron', 'EType', 'EventNineteenBus', 'Evija', 'Exige360Cup', 'Explorer', 'F1', 'F1Base', 'F150', 'F150_87', 'F150_87_Pope', 'F1Mclaren', 'F40', 'F40Police', 'F430', 'F50', 'F8', 'FalconUte', 'Fenyr', 'Fiat500', 'Fiata', 'FifthElementTaxi', 'Firebird', 'FireEngine', 'FireF150', 'FirePolice', 'FitSport', 'FJCruiser', 'Fleetwood', 'FleetwoodGhost', 'FocusRS', 'FocusST', 'Freightliner', 'FRS', 'FTO', 'FType', 'Furai', 'FXXKEvo', 'G6', 'G63', 'G70', 'G8', 'G80_Competition', 'G82_M4', 'Galaxie', 'GalaxieNoTree', 'Gallardo', 'GallardoSuper', 'Gemera', 'Genesis', 'Giulia', 'Gladiator', 'GNX', 'GoKart', 'GoldenSleigh', 'Golf', 'GolfCart', 'GolfR', 'GranTurismo', 'Griffith', 'GS350', 'GT', 'GT2RS', 'GT350R', 'GT3RS22', 'GT3RS996', 'GT500', 'GT63S', 'GTISuper', 'GTO', 'GTOJudge', 'GTR', 'GTR50', 'GTRR34', 'GTRNismo23', 'Gullwing', 'GWagon6x6', 'GWagon6x6Taxi_Actual', 'H2', 'H5', 'Hornet', 'Hovercar', 'Hovercar2', 'Hovercar3', 'HTron', 'HuayraRoadster', 'HummerEV', 'HummerLimo', 'HummerLimoDonk', 'Huracan', 'HuracanEVO', 'Hussarya', 'Hyundai', 'I30N', 'i8', 'ID4', 'Imola', 'Impala', 'ImprezaWRXSTI', 'InsigniaGSI', 'IntegraR', 'Intensa', 'Ioniq6', 'IronNight', 'Jeep', 'Jesko', 'JetTruck', 'JPTaxi', 'K5', 'Kenworth', 'Komatsu', 'KrAZ', 'LaFerrari', 'Lancer', 'LancerIX', 'Landcruiser', 'Landrobe', 'LaVoiture', 'Lawnmower', 'Leaf', 'Levorg', 'LFA', 'Limo', 'LolaT70', 'Lonestar', 'LTD', 'LTD_Chicken', 'LTL900', 'LucidAir', 'M12', 'M2CS', 'M3', 'M3Convert', 'M3GTR', 'M3GTR_UD', 'M4', 'M5', 'M500', 'M8', 'Mach1_21', 'Mach1_69', 'MachE', 'Mack', 'MailTruck', 'MarathonTaxi', 'Maverick', 'Maxima', 'MaybachVision', 'Mazda3', 'MC12', 'MC20', 'McGT', 'ME412', 'Megane', 'MercLimo', 'Miata19', 'Miata89', 'MiniCooper', 'Mirage', 'MissionEWagon', 'Mistral', 'Miura', 'ML63AMG', 'Model3', 'Model3Taxi', 'ModelA', 'ModelS', 'ModelSShooting', 'ModelX', 'Monaco', 'MonsterBus', 'MonsterTruck', 'MonsterVan', 'MonteCarloDonk', 'MonteCarloSS', 'MR2', 'MT45', 'MT45Mail', 'Murcielago', 'Mustang', 'MustangGT14', 'MustangGT99', 'MustangSupercar', 'MX30', 'Neon', 'Neoplan', 'NewCityBus', 'Nomad', 'NSX', 'NSX02', 'NSX97', 'NukeTruck', 'NVision', 'OffroadBeetle', 'OldBeetle', 'OldSedan', 'Omologato', 'One:1', 'Onroak', 'Ornament', 'OversizedF150', 'P1', 'P72', 'P924', 'PanameraTurismo', 'Pantera', 'Passat', 'Pete351', 'Pete379', 'Pete379Long', 'Peterbilt', 'Peterbilt387', 'PeterbiltFlatNose', 'Phantom', 'Piano', 'Pickup', 'Plaid', 'Polestar2', 'PoliceCamaro', 'PoliceCharger', 'PoliceCorvette', 'PoliceExplorer', 'PoliceF150', 'PoliceMonaco', 'PoliceRaptor', 'PoliceSenna', 'PoliceTaurus', 'PoliceVan', 'Porsche935', 'Porsche959', 'Porsche959B', 'PorscheRSR', 'PortaPotty', 'Prevost', 'Prius', 'PriusGT', 'ProjectGTP', 'ProjectONE', 'Prowler', 'R8', 'R8Spyder', 'Raesr2', 'Ram1500', 'Ram1500_21', 'RamSRT10', 'Ranger', 'Raptor', 'Rav4', 'RCF', 'RebelTRX', 'Regera', 'Rick', 'RimacCTwo', 'Roadster', 'Roma', 'Royale', 'RS3_22', 'RS5', 'RS6Avant', 'RS7', 'RSQ8', 'RV', 'RX350', 'RX350Bow', 'RX7', 'RX7_UD', 'S1', 'S13', 'S1GT4', 'S1Quattro', 'S209', 'S281', 'S2K', 'S4', 'S65AMG', 'S7', 'S9', 'Sabre', 'SafTLiner', 'Saleen', 'SantaCruz', 'SantasSleigh', 'SC20', 'SchoolBus', 'Schuppan', 'Sedan', 'Senna', 'SennaGTR', 'Sergio', 'Sesto', 'SF90', 'ShelbyDaytona', 'ShortSchoolBus', 'Sian', 'Silverado', 'SilveradoZ71', 'Silverado_Parade', 'Silverado_Pope', 'Silvia', 'Skyline', 'SL65_AMG', 'SLR', 'SLR_SM', 'SLSAMG', 'SmartCar', 'Solus', 'Speed3', 'Speedtail', 'Sport410', 'Sprinter', 'StingerGT', 'Supercoach', 'Supercoach_School', 'Supra', 'SupraMKV', 'SUV', 'SVRoadster', 'T33', 'T50', 'T50SNL', 'T680', 'Tahoe', 'Taurus', 'Taxi', 'Taycan', 'Tazio', 'Terzo', 'TeslaSemi', 'Testarossa', 'ThanosCar', 'Thunderbird', 'TLXTypeS', 'Torsus', 'TowTruck', 'Trabant', 'TrabantGT', 'TrabantTaxi', 'TrabantTrooper', 'Trackhawk', 'TrailblazerSS', 'TransAm77', 'Travego', 'TSX', 'TTMK3', 'TTRS', 'TTSRoadster', 'Tuatara', 'Tucker', 'TylersRealSwatVan', 'TylersSwatVan', 'TypeR', 'TypeR04', 'Typhoon', 'UCChargerPursuit', 'UDSportsCar', 'Undercover', 'UndercoverCharger', 'UndercoverExplorer', 'UndercoverSUV', 'UndercoverTaurus', 'Urus', 'USLimo', 'Utopia', 'Valhalla', 'Valkyrie', 'Valour', 'Van', 'VanSport', 'Vantage', 'Veloster', 'VelosterN', 'Veneno', 'Venom', 'VenomGT', 'Veyron', 'Victor', 'Viper', 'Viper96', 'ViperACR', 'VisionGT', 'Vulcan', 'Walmart', 'WeinerMobile', 'WesternStar', 'WiesmannGT', 'Wraith', 'Wrangler', 'WRX', 'WRX18', 'WRXSedan', 'WRXSTI', 'WS6', 'X3', 'XKRS', 'XRPHEV', 'Z3', 'Z4', 'Zenvo', 'Zerouno', 'ZL1_12', 'ZR1', 'DaytonaSP3', 'R8_GT2', 'ContinentalGT3', 'NSX_Racer', 'ArteonR', 'CayenneDonk', 'EscaladeDonk', 'ChallengerThiccDonk', 'CybertruckDonk', 'ClassicSedanDonk', 'ChironDonk', 'CorvetteC7z06', 'ViperACRSRT10', 'CamaroZL12020', 'HyperX', 'CC850', 'Speedster', 'DP100', 'ExpressVan', 'V6Clio', 'DarkHorse', 'Model3UD', 'CherryPicker', 'EquipmentTruck', 'DOT1500', 'SalterF150', 'DOTF150'
}
-- [[ stfu, I didn't wanna do: getgenv().vehicle_list = getgenv().vehicle_list or vehicles (kill me, it's the same thing anyway). ]] --
getgenv().vehicle_list = vehicles
getgenv().Script_Version_UD = "1.7.1-UD"
g.Game = cloneref and cloneref(game) or game
g.JobID = game.JobId
g.PlaceID = game.PlaceId
getgenv().LoopKilling_Tbl = getgenv().LoopKilling_Tbl or {}

if not g.GlobalEnvironmentFramework_Initialized then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Global_Environment.lua"))()
   wait(0.1)
   g.GlobalEnvironmentFramework_Initialized = true
end

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Notify_Lib.lua"))()
local valid_titles = {success="Success",info="Info",warning="Warning",error="Error",succes="Success",sucess="Success",eror="Error",erorr="Error",warnin="Warning"}
local function format_title(str)
   if typeof(str)~="string" then return "Info" end
   local key=str:lower()
   return valid_titles[key] or "Info"
end

g.notify=g.notify or function(title,msg,dur)
   local fixed_title=format_title(title)
   NotifyLib:External_Notification(fixed_title,tostring(msg),tonumber(dur))
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

local function find_blocked_music_folder()
    local cache = getgenv().blocked_music_folder_found
    if cache and cache.Parent and cache:IsA("Folder") and cache:IsDescendantOf(getgenv().ReplicatedStorage) then
        return cache
    end

    for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("block") and v.Name:lower():find("music") then
            getgenv().blocked_music_folder_found = v
            return v
        end
    end

    return nil
end

if not getgenv().blocked_music_folder_found then pcall(find_blocked_music_folder) end
task.wait(0.1)
g.clear_folder_children = function()
    local folder = getgenv().blocked_music_folder_found
    if not folder then return end
    for _, v in ipairs(folder:GetChildren()) do
        if v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue") then
            pcall(function() v.Parent = nil end)
        end
    end
end
task.wait(0.25)
g.clear_folder_children()

local debounce = false
getgenv().FlamesLibrary.connect("folder_cleanup_added", getgenv().blocked_music_folder_found.ChildAdded:Connect(function(v)
    if not (v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue")) then return end
    if debounce then return end
    debounce = true
    task.defer(function()
        g.clear_folder_children()
        debounce = false
    end)
end))

getgenv().active_friends_online = getgenv().active_friends_online or true
getgenv().FlamesLibrary.spawn("friends_online_loop", "spawn", function()
    local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = g.LocalPlayer or Players.LocalPlayer
    local fw = getgenv().FlamesLibrary.wait

    while getgenv().active_friends_online == true do
        pcall(function() LocalPlayer:SetAttribute("FriendsInServer", 5) end)
        fw(0)
    end
end)

if not getgenv().Activated_Print_Bypass_Leaderboard_Annoying_Loop then
    if hookfunction then
        getgenv().Activated_Print_Bypass_Leaderboard_Annoying_Loop = true
        local old_print
        old_print = hookfunction(print, function(...)
            local trace = debug.traceback("", 2)
            if trace:find("LeaderboardManager") then return end
            old_print(...)
        end)
        getgenv().notify("Success", "Bypassed LeaderboardManager annoying print spam (hooked).", 5)
    else
        getgenv().Activated_Print_Bypass_Leaderboard_Annoying_Loop = true
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

getgenv().randomString = getgenv().randomString or function()
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
        return getgenv().notify("Error", "You cannot target yourself!", 6)
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
local LocalPlayer = getgenv().LocalPlayer or Players.LocalPlayer
local Vehicles_LocalPlayer_Folder = LocalPlayer:FindFirstChild("Vehicles")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local Main_Folder = Workspace:FindFirstChild("_Main") or Workspace:WaitForChild("_Main", 5)
local Vehicles_Folder = Main_Folder and Main_Folder:FindFirstChild("Vehicles") or Main_Folder:WaitForChild("Vehicles", 5)
local Events = ReplicatedStorage:FindFirstChild("Events")
local Modules = ReplicatedStorage:FindFirstChild("Modules")
local VehicleCustomizationsData = Modules:FindFirstChild("VehicleCustomizationsData")
local Vehicle_Change_RF = VehicleCustomizationsData:FindFirstChild("WriteVehicleChanges")
wait(0.3)
getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
local Anti_Ragdoll_Active = false
local Inf_Stamina_Active = false
local HttpService = getgenv().HttpService or getgenv().Service_Wrap("HttpService")
local carNames = {}
local Owned_Vehicle_Slots = {}

function get_car_names()
    local vehicleDataValue = getgenv().LocalPlayer:FindFirstChild("Values")
        and getgenv().LocalPlayer.Values:FindFirstChild("ExtraLeaderStats")
        and getgenv().LocalPlayer.Values.ExtraLeaderStats:FindFirstChild("VehicleData")

    if not vehicleDataValue or not vehicleDataValue:IsA("StringValue") then
        return {}
    end

    local success, decoded = pcall(function()
        return HttpService:JSONDecode(vehicleDataValue.Value)
    end)

    if not success or typeof(decoded) ~= "table" then
        return {}
    end

    table.clear(carNames)
    for carName, data in pairs(decoded) do
        carNames[carName] = data
        table.insert(Owned_Vehicle_Slots, carName)
    end

    return carNames
end
wait(0.1)
get_car_names()

-- [[ To be added into the script hub soon. ]] --
-- local Gun_Shop_Prompt = workspace:FindFirstChild("_Main"):FindFirstChild("GunGivers"):FindFirstChild("WeaponBuilding"):FindFirstChild("Building"):FindFirstChild("GunShop"):FindFirstChild("ShopPad"):FindFirstChildOfClass("ProximityPrompt")

local all_vehicles = get_car_names()
if not all_vehicles or #all_vehicles == 0 then
    local args = {
        "VehiclePurchase",
        {
            "ClassicSedanDonk",
            Main_Folder:WaitForChild("VehicleShops"):WaitForChild("VehicleShop"),
            true,
            false
        }
    }
    ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
end

wait(1)

local function spawn_vehicle(name)
    if type(name) ~= "string" then
        return 
    end

    local args = {
        "VehicleSpawn",
        {
            tostring(name),
            "QuickSpawn",
            false
        }
    }
    
    ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("RemoteFunction"):InvokeServer(unpack(args))
end

local Rayfield
local function retrieve_vehicle()
    for _, v in ipairs(Vehicles_Folder:GetChildren()) do
        local vals = v:FindFirstChild("Values", true)
        if vals and vals:GetAttribute("Owner") == LocalPlayer.Name then
            return v
        end
    end
end

local char_pvp = getgenv().Character or LocalPlayer.Character or get_char(LocalPlayer, 10)
local Old_PVP_Enabled = char_pvp:GetAttribute("PVPDamageEnabled")
getgenv().specific_weapon_mod = false
getgenv().all_weapon_mods = false
local User_Configuration = User_Configuration or {}
local guns = {}

for _, v in ipairs(Character:GetChildren()) do
    if v:IsA("Tool") and v:FindFirstChild("Configuration") then
        v.Parent = Backpack
    end
end
task.wait(0.1)
local function get_all_weapons()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Configuration") then
            table.insert(guns, tool)
        end
    end

    return guns
end

local function get_specific_weapon(weapon_name)
    for _, v in ipairs(getgenv().Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == weapon_name and v:FindFirstChild("Configuration") then
            return v
        end
    end

    return nil
end

function low_level_executor()
    if executor_Name == "Solara" or string.find(executor_Name, "JJSploit") or executor_Name == "Xeno" then
        return true
    else
        return false
    end
end

local function get_weapon()
    for _, v in ipairs(getgenv().Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Configuration") then
            return v
        end
    end

    return nil
end

local function mod_weapon(gun)
    local weapon = get_specific_weapon(gun)
    if not weapon then return end
    local Gun_Config = weapon:FindFirstChild("Configuration")

    while getgenv().specific_weapon_mod == true do
    task.wait()
        if Gun_Config:FindFirstChild("FireMode") then
            Gun_Config.FireMode.Value = "Automatic"
        end
        Gun_Config.AmmoCapacity = 9e9
        Gun_Config.HitDamage = 9e9
        Gun_Config.MaxSpread = 0
        Gun_Config.RecoilDecay = 1
        Gun_Config.RecoilMax = 0
        Gun_Config.ShotCooldown = 0
        Gun_Config.TotalRecoilMax = 0
        if weapon:GetAttribute("Ammo") then
            weapon:SetAttribute("Ammo", 9e9)
        end
    end
end

local function mod_all_guns()
    local all_weapons = get_all_weapons()
    for _, tool in ipairs(all_weapons) do
        if not tool then return end
        local Gun_Config = tool:FindFirstChild("Configuration")

        if Gun_Config:FindFirstChild("FireMode") then
            Gun_Config.FireMode.Value = "Automatic"
        end
        Gun_Config.AmmoCapacity.Value = 9e9
        Gun_Config.HitDamage.Value = 9e9
        Gun_Config.MaxSpread.Value = 0
        Gun_Config.RecoilDecay.Value = 1
        Gun_Config.RecoilMax.Value = 0
        Gun_Config.ShotCooldown.Value = 0
        Gun_Config.TotalRecoilMax.Value = 0
        if tool:GetAttribute("Ammo") then
            tool:SetAttribute("Ammo", 9e9)
        end
    end
    wait(0.2)
    return 
end

local function buy_weapon(gun_name)
    local args = {
        "ToolEvent",
        {
            "Purchase",
            {
                tostring(gun_name)
            }
        }
    }
    getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
    return 
end

local function switch_team(team_name)
    getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("Data"):WaitForChild("ResetBounty"):InvokeServer()
    wait(0.3)
    local args = {
        tostring(team_name)
    }

    getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("Admin"):WaitForChild("ChangeTeam"):InvokeServer(unpack(args))
    return 
end

function Can_Damage()
    if executor_Name == "Solara" or executor_Name == "Xeno" or string.find(executor_Name, "JJSploit") then
        local BOUNTY_THRESHOLD = getgenv().ReplicatedStorage:WaitForChild("GameSettings"):WaitForChild("BountyLevels"):GetAttribute("Level_Fine")
        local TOOL_KEYS = {
            IsWeapon = "IsWeapon"
        }
        local Weapons = {
            ["Desert Eagle"] = { IsWeapon = true },
            ["Pistol"] = { IsWeapon = true },
            ["Bizon"] = { IsWeapon = true },
            ["AUG"] = { IsWeapon = true },
            ["M16"] = { IsWeapon = true },
            ["MP5"] = { IsWeapon = true },
            ["UZI"] = { IsWeapon = true },
            ["P90"] = { IsWeapon = true },
            ["SCAR"] = { IsWeapon = true },
            ["SPAS-12"] = { IsWeapon = true },
            ["Scout"] = { IsWeapon = true },
            ["Sawed Off"] = { IsWeapon = true },
            ["FAMAS"] = { IsWeapon = true },
            ["Barrett"] = { IsWeapon = true },
            ["G36C"] = { IsWeapon = true },
            ["MP7"] = { IsWeapon = true },
            ["AA12"] = { IsWeapon = true },
            ["M249"] = { IsWeapon = true },
            ["Vector"] = { IsWeapon = true },
            ["Explosive Sniper"] = { IsWeapon = true },
            ["Minigun"] = { IsWeapon = true },
            ["AK"] = { IsWeapon = true },
            ["TEC-9"] = { IsWeapon = true },
        }

        local function CanDamagePlayer(attacker, target, tool)
            if not (target and target:GetAttribute("PvP_Active")) then
                getgenv().notify("Error", "PvP is not enabled, got: false.", 5)
                return false
            end

            if tool and Weapons[tool.Name] and Weapons[tool.Name][TOOL_KEYS.IsWeapon] == false then
                getgenv().notify("Error", "None of the weapons in the table appear to be an actual weapon, how did you even get this error?", 15)
                return false
            end

            local attacker_team = attacker.Team and attacker.Team.Name or ""
            local target_team = target.Team and target.Team.Name or ""

            local is_attacker_criminal = attacker_team == "Criminal"
            local is_other_criminal = target_team == "Criminal"

            if attacker_team == "Police" then
                local stats = target:FindFirstChild("leaderstats")
                if is_other_criminal then
                    return "KILL"
                end
                if stats and stats:FindFirstChild("Bounty") and stats.Bounty.Value >= BOUNTY_THRESHOLD then
                    return "FINE"
                end
            elseif is_attacker_criminal and (is_other_criminal or target_team == "Police") then
                return "KILL"
            end

            return false
        end

        return CanDamagePlayer
    else
        local ReplicatedStorage = getgenv().ReplicatedStorage
        local Modules = ReplicatedStorage:FindFirstChild("Modules")
        local Can_Damage = require(Modules:FindFirstChild("CanDamagePlayer"))
        local Damage_Enabled = Can_Damage()

        return Damage_Enabled
    end
end

getgenv().kill_player = function(player)
    if not player or not player:IsDescendantOf(game.Players) then return end
    local char = Character
    local lp = LocalPlayer
    local hum = Humanoid
    local backpack = getgenv().LocalPlayer:FindFirstChildOfClass("Backpack")
    local weapon_hit = ReplicatedStorage:FindFirstChild("WeaponHit", true)
    local victim_char = player.Character or get_char(player, 7)
    local victim_hum = victim_char and victim_char:FindFirstChildOfClass("Humanoid") or get_human(player, 5)
    local victim_hrp = victim_char and victim_char:FindFirstChild("HumanoidRootPart") or get_root(player, 5)
    if not victim_hrp or not victim_hum then return end
    if lp.Team.Name ~= "Criminal" then
        if getgenv().notify then
            getgenv().notify("Warning", "Please become a Criminal to use this!", 5)
        end
        return
    end

    local equipped_tool = char and char:FindFirstChildWhichIsA("Tool")
    if not equipped_tool then
        local chosen_tool = nil

        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute("Weapon") == true then
                chosen_tool = tool
                break
            end
        end

        if chosen_tool then
            hum:EquipTool(chosen_tool)
            local timeout = 0
            repeat task.wait() timeout += 1 until char:FindFirstChild(chosen_tool.Name) or timeout > 30
            if char:FindFirstChild(chosen_tool.Name) then
                equipped_tool = chosen_tool
            end
        end
    end

    if not equipped_tool then
        if getgenv().notify then
            getgenv().notify("Error", "No valid gun in backpack.", 5)
        end
        return
    end

    for i = 1, 100 do
        task.wait()
        weapon_hit:FireServer(
            equipped_tool,
            {
                p = vector.create(1795.986328125, 59.66236877441406, 5395.9365234375),
                pid = 1,
                origin = vector.create(1787.1165771484375, 60.78240966796875, 5399.0166015625),
                part = victim_hrp,
                d = 9.455890655517578,
                maxDist = 9.389322280883789,
                h = victim_hum,
                m = Enum.Material.Plastic,
                n = vector.create(-0.008076800033450127, 0.9968878626823425, 0.07841799408197403),
                t = 0.28342804913539854,
                sid = 8
            }
        )
    end
end

local script_errors = {}
local function write_error_log_file(filepath, new_error)
    if writefile and readfile then
        local old_content = ""
        local success, result = pcall(function()
            old_content = readfile(filepath)
        end)

        local updated_log = (old_content ~= "" and (old_content .. "\n") or "") .. new_error
        writefile(filepath, updated_log)
    else
        notify("Error", "writefile() or readfile() are unsupported, low level executor detected! Your executor: "..tostring(executor_Name), 10)
    end
end

if isfile then
    if not isfile("UltimateDriving_ErrorLog.txt") then
        write_error_log_file("UltimateDriving_ErrorLog.txt", "[]")
    end
end
task.wait(0.2)
local error_logs_file = "UltimateDriving_ErrorLog.txt"
local function Is_In_Race()
    local error_exited = false

    if error_exited then
        return notify("Error", "local function 'Is_In_Race()' | Exited with errors when ran last-time.", 7)
    end

    if executor_Name == "Solara" or executor_Name == "Xeno" or string.find(executor_Name, "JJSploit") then
        local racesOngoing = getgenv().ReplicatedStorage:FindFirstChild("ReplicatedData") and getgenv().ReplicatedStorage.ReplicatedData:FindFirstChild("RacesOngoing")
        if not racesOngoing then 
            error_exited = true
            table.insert(script_errors, '[Stack Begin]: "RacesOnGoing" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            write_error_log_file(error_logs_file, '[Stack Begin]: "RacesOnGoing" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            warn("[DEBUG]:", "An error occurred, please check the logs file 'UltimateDriving_ErrorLog.txt' in your 'workspace' Folder where-ever your executor is located for more information.")
            return false
        end

        for _, race in pairs(racesOngoing:GetChildren()) do
            local racers = race:FindFirstChild("ActiveRacers")
            if racers and racers:FindFirstChild(game.Players.LocalPlayer.Name) then
                return true
            end
        end
        return false
    else
        local Modules = getgenv().ReplicatedStorage:FindFirstChild("Modules")
        if not Modules then
            error_exited = true
            table.insert(script_errors, '[Stack Begin]: "Modules" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            write_error_log_file(error_logs_file, '[Stack Begin]: "Modules" is not a valid member of ReplicatedStorage "ReplicatedStorage" :[Stack End]')
            warn("[DEBUG]:", "An error occurred, please check the logs file: 'UltimateDriving_ErrorLog.txt' in your 'workspace' Folder where-ever your executor is located for more information.")
            return false
        end

        local playerRaceModule = Modules:FindFirstChild("PlayerIsInRace")
        if not playerRaceModule then
            error_exited = true
            table.insert(script_errors, '[Stack Begin]: "PlayerIsInRace" is not a valid member of Folder "Modules" :[Stack End]')
            write_error_log_file(error_logs_file, '[Stack Begin]: "PlayerIsInRace" is not a valid member of Folder "Modules" :[Stack End]')
            warn("[DEBUG]:", "An error occurred, please check the logs file: 'UltimateDriving_ErrorLog.txt' in your 'workspace' Folder where-ever your executor is located for more information.")
            return false
        end

        local Player_In_Race = require(playerRaceModule)
        return Player_In_Race()
    end
end

local function get_random_vehicle()
    local every_owned_car = get_car_names()

    if #every_owned_car == 0 then
        return nil
    end

    return every_owned_car[math.random(1, #every_owned_car)]
end

local randomly_selected_vehicle = get_random_vehicle()

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
            local raw = game:HttpGet("https://sirius.menu/rayfield")
            local func = loadstring(raw)
            return func()
        end)

        if not success or not result then
            getgenv().notify("Error", "[Rayfield]: Load failed (attempt "..tostring(attempts).."):"..tostring(result), 10)
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
        Name = "🔫 Ultimate Driving 🚬 | "..tostring(getgenv().Script_Version_UD).." | "..tostring(executor_Name),
        LoadingTitle = "Welcome, "..tostring(game.Players.LocalPlayer),
        LoadingSubtitle = "Ultimate Driving | Hub.",
        Theme = "Default",
        ToggleUIKeybind = "K",
        DisableRayfieldPrompts = true,
        DisableBuildWarnings = true,
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "UltimateDrivingHub-Config",
            FileName = "UltimateDrivingScriptHub"
        },
        Discord = {
            Enabled = false,
            Invite = "",
            RememberJoins = true
        },
        KeySystem = false,
        KeySettings = {
            Title = "None",
            Subtitle = "No key system is provided.",
            Note = "yo",
            FileName = "Key",
            SaveKey = false,
            GrabKeyFromSite = false,
            Key = {""}
        }
    })
else
    return getgenv().notify("Error", "Rayfield failed to load or is not valid. Returned: "..tostring(Rayfield), 15)
end
task.wait(1)
local Tab1 = Window:CreateTab("🏡 Main 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Main 🏡 |")
local Tab2 = Window:CreateTab("🧍 Character 🧍", 0)
local Section2 = Tab2:CreateSection("| 🧍 Character Content 🧍 |")
local Tab5 = Window:CreateTab("🔫 Weapon 🔫", 0)
local Section5 = Tab5:CreateSection("| 🔫 Weapons Stuff 🔫 |")
local Tab3 = Window:CreateTab("⭐ Extras ⭐", 0)
local Section3 = Tab3:CreateSection("| ⭐ Extra Content ⭐ |")
local Tab4 = Window:CreateTab("🚗 Vehicle 🚗", 0)
local Section4 = Tab4:CreateSection("| 🚗 Vehicle 🚗 |")
local current_car_tint_color = Color3.new(0, 0, 0)
local current_car_tint_transparency = 1
local Low_Level_Exploit = low_level_executor()

-- [[ Not sure what I used this for, I'll figure it out later. ]] --
--[[
if Low_Level_Exploit == false then
    local Prompt_Data = require(getgenv().ReplicatedStorage:findFirstChild("ResourceLibrary"):FindFirstChild("Tables").PromptData)
end
--]]

getgenv().CarTintColor = Tab4:CreateColorPicker({
Name = "Car Tint Color",
Color = Color3.fromRGB(0, 0, 0),
Flag = "PickingCarTintColor",
Callback = function(car_tint_color)
    local current_car = retrieve_vehicle()
    if current_car then
        local args = {
            tostring(current_car.Name),
            {
                ColorTint = car_tint_color,
                TransparencyTint = current_car_tint_transparency
            }
        }

        Vehicle_Change_RF:InvokeServer(unpack(args))
    else
        return getgenv().notify("Error", "Please spawn a vehicle before using this.", 5)
    end
    task.wait(.2)
    current_car_tint_color = car_tint_color
end,})

getgenv().CarTintTransparency = Tab4:CreateSlider({
Name = "Car Tint Transparency",
Range = {0, 1},
Increment = 0.1,
Suffix = "",
CurrentValue = 1,
Flag = "SliderCarTintTransparency",
Callback = function(car_tint_transparency)
    local current_car = retrieve_vehicle()
    if current_car then
        local args = {
            tostring(current_car.Name),
            {
                ColorTint = Color3.fromRGB(0, 0, 0),
                TransparencyTint = tonumber(car_tint_transparency)
            }
        }

        Vehicle_Change_RF:InvokeServer(unpack(args))
    else
        return getgenv().notify("Error", "Please spawn a vehicle before using this.", 6)
    end
    task.wait(.5)
    current_car_tint_transparency = car_tint_transparency
end,})

if writefile and delfile and loadfile then
    getgenv().Save_Car_Config = Tab4:CreateButton({
    Name = "Save Car Config",
    Callback = function()
        local data = {
            TintColor = {
                R = current_car_tint_color.R,
                G = current_car_tint_color.G,
                B = current_car_tint_color.B
            },
            TintTransparency = current_car_tint_transparency
        }

        local json = HttpService:JSONEncode(data)
        task.wait(.3)
        writefile("car_config.json", json)
    end,})

    getgenv().Delete_Car_Config = Tab4:CreateButton({
    Name = "Delete Car Config",
    Callback = function()
        if isfile("car_tint_config.json") then
            delfile("car_tint_config.json")
        end
    end,})

    getgenv().Load_Car_Config = Tab4:CreateButton({
    Name = "Load Car Config",
    Callback = function()
        if isfile("car_tint_config.json") then
            local contents = readfile("car_tint_config.json")
            local data = HttpService:JSONDecode(contents)
            current_car_tint_color = Color3.new(data.TintColor.R, data.TintColor.G, data.TintColor.B)
            current_car_tint_transparency = data.TintTransparency
            task.wait(.3)
            local args = {
                tostring(Vehicle.Name),
                {
                    ColorTint = current_car_tint_color,
                    TransparencyTint = current_car_tint_transparency
                }
            }

            Vehicle_Change_RF:InvokeServer(unpack(args))
        end
    end,})
else
    warn("Didn't load these options, writefile/del/loadfile is unsupported.")
end

local function apply_inf_stamina(humanoid)
    if not humanoid then return end
    getgenv().FlamesLibrary.spawn("inf_stamina_loop", "spawn", function()
        while getgenv().inf_stamina == true do
            task.wait(0)
            pcall(function() humanoid:SetAttribute("Stamina", 9e9) end)
        end
    end)
end

getgenv().InfStamina_FE = Tab2:CreateToggle({
Name = "Infinite Stamina (FE)",
CurrentValue = getgenv().inf_stamina or false,
Flag = "InfStaminaScript",
Callback = function(inf_stamina)
    if inf_stamina then
        local char = getgenv().Character or getgenv().LocalPlayer.Character or get_char(getgenv().LocalPlayer, 10)
        local humanoid = getgenv().Humanoid or char and char:FindFirstChildOfClass("Humanoid") or get_human(getgenv().LocalPlayer, 10)
        local stamina_attribute = humanoid and humanoid:GetAttribute("Stamina")
        if stamina_attribute == nil then
            getgenv().inf_stamina = false
            return warn("Unable to return Stamina value Attribute!")
        end
        task.wait(0.2)
        getgenv().inf_stamina = true
        apply_inf_stamina(humanoid)

        getgenv().FlamesLibrary.connect("inf_stamina_char_added", getgenv().LocalPlayer.CharacterAdded:Connect(function(new_char)
            getgenv().FlamesLibrary.spawn("inf_stamina_char_spawn", "delay", 0.3, function()
                if not new_char then
                    repeat task.wait() until new_char and new_char:FindFirstChild("Humanoid")
                end
                local new_humanoid = new_char:WaitForChild("Humanoid", 5)
                getgenv().Humanoid = new_humanoid
                if not new_humanoid or not new_humanoid:GetAttribute("Stamina") then return warn("Unable to return Stamina value Attribute!") end
                getgenv().FlamesLibrary.disconnect("inf_stamina_loop")
                task.wait(0.1)
                apply_inf_stamina(new_humanoid)
            end)
        end))
    else
        getgenv().inf_stamina = false
        getgenv().FlamesLibrary.disconnect("inf_stamina_loop")
        getgenv().FlamesLibrary.disconnect("inf_stamina_char_added")
        getgenv().FlamesLibrary.disconnect("inf_stamina_char_spawn")
        task.wait(0.25)
        local humanoid = getgenv().Humanoid or getgenv().Character:FindFirstChildOfClass("Humanoid") or get_human(LocalPlayer, 10)
        if humanoid and humanoid:GetAttribute("Stamina") then
            pcall(function() humanoid:SetAttribute("Stamina", 100) end)
            return getgenv().notify("Success", "Sprint stamina successfully reset to 100.", 5)
        else
            return getgenv().notify("Error", "Stamina Attribute was not found in Humanoid!", 5)
        end
    end
end,})

local function has_disabled_property(instance)
    local ok, result = pcall(function() return typeof(instance.Disabled) == "boolean" end)
    return ok and result
end

local function disable_script(script_instance, target_parent)
    if not script_instance then return end
    if script_instance:IsA("LocalScript") or has_disabled_property(script_instance) then
        script_instance.Disabled = true
    end
    script_instance.Parent = target_parent
end

local function apply_anti_ragdoll()
    local char = getgenv().Character
    if not (char and char:FindFirstChildOfClass("Humanoid") and getgenv().Humanoid) then return end

    if char:FindFirstChild("RagdollConstraints") then
        char:FindFirstChild("RagdollConstraints"):Destroy()
    end

    local ragdoll_client = getgenv().LocalPlayer.PlayerScripts:FindFirstChild("RagdollClient")
    if ragdoll_client then
        disable_script(ragdoll_client, getgenv().SoundService)
    end

    local starter_ragdoll_client = getgenv().StarterPlayer.StarterPlayerScripts:FindFirstChild("RagdollClient")
    if starter_ragdoll_client then
        disable_script(starter_ragdoll_client, getgenv().TweenService)
    end

    if getgenv().ReplicatedStorage:FindFirstChild("WeaponsSystem")
        and getgenv().ReplicatedStorage.WeaponsSystem:FindFirstChild("Libraries")
        and getgenv().ReplicatedStorage.WeaponsSystem.Libraries:FindFirstChild("Ragdoll") then
        disable_script(getgenv().ReplicatedStorage.WeaponsSystem.Libraries.Ragdoll, game:GetService("ReplicatedFirst"))
    end

    if Modules:FindFirstChild("Ragdoll") then
        disable_script(Modules.Ragdoll, getgenv().AssetService)
    end

    if getgenv().ReplicatedFirst:FindFirstChild("Ragdoll") then
        disable_script(getgenv().ReplicatedFirst.Ragdoll, getgenv().AssetService)
    end
end

local function revert_anti_ragdoll()
    if getgenv().SoundService:FindFirstChild("RagdollClient") then
        local s = getgenv().SoundService.RagdollClient
        s.Disabled = false
        s.Parent = getgenv().LocalPlayer.PlayerScripts
    end

    if getgenv().TweenService:FindFirstChild("RagdollClient") then
        local s = getgenv().TweenService.RagdollClient
        s.Disabled = false
        s.Parent = getgenv().StarterPlayer.StarterPlayerScripts
    end

    if getgenv().AssetService:FindFirstChild("Ragdoll") then
        local s = getgenv().AssetService.Ragdoll
        if has_disabled_property(s) then
            s.Disabled = false
        end
        s.Parent = Modules
    end
end

getgenv().AntiRagdoll = Tab2:CreateToggle({
Name = "Anti Ragdoll",
CurrentValue = getgenv().Anti_Ragdoll_Enabled or false,
Flag = "FullAntiRagdoll",
Callback = function(anti_ragdoll)
    if anti_ragdoll then
        getgenv().Anti_Ragdoll_Enabled = true

        getgenv().FlamesLibrary.connect("anti_ragdoll_char_added", getgenv().LocalPlayer.CharacterAdded:Connect(function(char)
            getgenv().FlamesLibrary.spawn("anti_ragdoll_char_spawn", "delay", 0.3, function()
                getgenv().Character = char
                getgenv().Humanoid = char:WaitForChild("Humanoid", 5)
                apply_anti_ragdoll()
            end)
        end))

        getgenv().FlamesLibrary.spawn("anti_ragdoll_init", "delay", 0.3, function()
            apply_anti_ragdoll()
        end)
    else
        getgenv().Anti_Ragdoll_Enabled = false

        getgenv().FlamesLibrary.disconnect("anti_ragdoll_char_added")
        getgenv().FlamesLibrary.disconnect("anti_ragdoll_char_spawn")
        getgenv().FlamesLibrary.disconnect("anti_ragdoll_init")

        task.wait(0.25)
        revert_anti_ragdoll()
    end
end,})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Vehicles_Folder = workspace:FindFirstChild("_Main"):FindFirstChild("Vehicles")
local g = getgenv()
g.vehicle_fly = g.vehicle_fly or false
g.vehicle_fly_speed = g.vehicle_fly_speed or 3
g.vehiclefly_conns = g.vehiclefly_conns or {}
g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
g.vehiclefly_noclip = g.vehiclefly_noclip or false
g.vehiclefly_collisions = g.vehiclefly_collisions or {}
g.vehiclefly_springs = g.vehiclefly_springs or {}
local is_mobile = UserInputService.TouchEnabled
local Control_Module
if is_mobile then
   Control_Module = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
end

local function Retrieve_Vehicle()
   for _, v in ipairs(Vehicles_Folder:GetChildren()) do
      local vals = v:FindFirstChild("Values", true)
      if vals and vals:GetAttribute("Owner") == LocalPlayer.Name then
         return v
      end
   end
end

local function Get_Seat(Car)
   return Car:FindFirstChildWhichIsA("VehicleSeat", true)
end

g.cleanup = function()
   if g.vehiclefly_conns.render then
      pcall(function() g.vehiclefly_conns.render:Disconnect() end)
      g.vehiclefly_conns.render = nil
   end
   if g.vehiclefly_conns.down then
      pcall(function() g.vehiclefly_conns.down:Disconnect() end)
      g.vehiclefly_conns.down = nil
   end
   if g.vehiclefly_conns.up then
      pcall(function() g.vehiclefly_conns.up:Disconnect() end)
      g.vehiclefly_conns.up = nil
   end

   if g.vehiclefly_bv then
      pcall(function() g.vehiclefly_bv.Velocity = Vector3.zero end)
      pcall(function() g.vehiclefly_bv:Destroy() end)
      g.vehiclefly_bv = nil
   end

   if g.vehiclefly_bg then
      pcall(function() g.vehiclefly_bg:Destroy() end)
      g.vehiclefly_bg = nil
   end
end

g.enable_vehicle_noclip = function()
   if g.vehiclefly_noclip then return end
   g.vehiclefly_noclip = true
   g.vehiclefly_collisions = {}
   local Car = Retrieve_Vehicle()
   if not Car then return end

   for _, v in ipairs(Car:GetDescendants()) do
      if v:IsA("BasePart") then
         g.vehiclefly_collisions[v] = v.CanCollide
         v.CanCollide = false
      end
   end
end

g.disable_vehicle_noclip = function()
   if not g.vehiclefly_noclip then return end
   g.vehiclefly_noclip = false

   for Part, State in pairs(g.vehiclefly_collisions) do
      if Part and Part.Parent then
         Part.CanCollide = State
      end
   end
   g.vehiclefly_collisions = {}
end

g.disable_springs = function(Car)
   g.vehiclefly_springs = {}
   for _, v in ipairs(Car:GetDescendants()) do
      if v:IsA("SpringConstraint") then
         g.vehiclefly_springs[v] = {
            Free_Length = v.FreeLength,
            Stiffness = v.Stiffness,
            Damping = v.Damping,
         }
         pcall(function()
            v.Stiffness = 0
            v.Damping = 0
            v.FreeLength = v.CurrentLength
         end)
      end
   end
end

g.restore_springs = function()
   for Spring, Data in pairs(g.vehiclefly_springs) do
      if Spring and Spring.Parent then
         pcall(function()
            Spring.FreeLength = Data.Free_Length
            Spring.Stiffness = Data.Stiffness
            Spring.Damping = Data.Damping
         end)
      end
   end
   g.vehiclefly_springs = {}
end

g.start_vehicle_fly = function()
   if g.vehiclefly_bg or g.vehiclefly_bv then return end
   local Car = Retrieve_Vehicle()
   if not Car then return end
   local Seat = Get_Seat(Car)
   if not Seat then return end
   local Weight_Part = Car:FindFirstChild("#Weight", true)
   local Physics_Root = Weight_Part or Seat
   local Drag_Force = Seat:FindFirstChild("DragForce")
   local Boost_Force = Seat:FindFirstChild("BoostForce")
   local Float_Force = Seat:FindFirstChild("FloatForce")
   if Drag_Force then Drag_Force.Force = Vector3.zero end
   if Boost_Force then Boost_Force.Force = Vector3.zero end
   if Float_Force then Float_Force.Position = Seat.Position end

   g.disable_springs(Car)

   local Bg = Instance.new("BodyGyro")
   Bg.P = 3e4
   Bg.D = 1e3
   Bg.MaxTorque = Vector3.new(0, 9e9, 0)
   Bg.CFrame = Physics_Root.CFrame
   Bg.Parent = Physics_Root

   local Bv = Instance.new("BodyVelocity")
   Bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
   Bv.Velocity = Vector3.zero
   Bv.Parent = Physics_Root

   g.vehiclefly_bg = Bg
   g.vehiclefly_bv = Bv

   g.vehiclefly_conns.render = RunService.Heartbeat:Connect(function()
      if not g.vehicle_fly or not Physics_Root.Parent then
         Bv.Velocity = Vector3.zero
         g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
         return
      end

      Physics_Root.AssemblyAngularVelocity = Vector3.zero

      if Float_Force then Float_Force.Position = Seat.Position end
      if Drag_Force then Drag_Force.Force = Vector3.zero end
      if Boost_Force then Boost_Force.Force = Vector3.zero end

      local Cam = workspace.CurrentCamera

      if is_mobile then
         Bg.CFrame = Cam.CFrame
         local Mv = Control_Module:GetMoveVector()
         local Vel = Vector3.zero
         if Mv.X ~= 0 then Vel = Vel + Cam.CFrame.RightVector * (Mv.X * (45 * g.vehicle_fly_speed)) end
         if Mv.Z ~= 0 then Vel = Vel - Cam.CFrame.LookVector * (Mv.Z * (45 * g.vehicle_fly_speed)) end
         Bv.Velocity = Vel
      else
         local Look = Cam.CFrame.LookVector
         local Yaw = math.atan2(-Look.X, -Look.Z)
         Bg.CFrame = CFrame.new(Physics_Root.Position) * CFrame.Angles(0, Yaw, 0)

         local c = g.vehiclefly_control
         local Forward = (c.f or 0) + (c.b or 0)
         local Right = (c.l or 0) + (c.r or 0)
         local Up = (c.q or 0) + (c.e or 0)

         Bv.Velocity = (
            Cam.CFrame.LookVector * Forward +
            Cam.CFrame.RightVector * Right +
            Vector3.new(0, Up, 0)
         ) * (45 * g.vehicle_fly_speed)
      end
   end)

   if not is_mobile then
      g.vehiclefly_conns.down = UserInputService.InputBegan:Connect(function(i, gp)
         if gp then return end
         if i.KeyCode == Enum.KeyCode.W then g.vehiclefly_control.f = 1  end
         if i.KeyCode == Enum.KeyCode.S then g.vehiclefly_control.b = -1 end
         if i.KeyCode == Enum.KeyCode.A then g.vehiclefly_control.l = -1 end
         if i.KeyCode == Enum.KeyCode.D then g.vehiclefly_control.r = 1  end
         if i.KeyCode == Enum.KeyCode.Q then g.vehiclefly_control.q = -1 end
         if i.KeyCode == Enum.KeyCode.E then g.vehiclefly_control.e = 1  end
      end)

      g.vehiclefly_conns.up = UserInputService.InputEnded:Connect(function(i)
         if i.KeyCode == Enum.KeyCode.W then g.vehiclefly_control.f = 0 end
         if i.KeyCode == Enum.KeyCode.S then g.vehiclefly_control.b = 0 end
         if i.KeyCode == Enum.KeyCode.A then g.vehiclefly_control.l = 0 end
         if i.KeyCode == Enum.KeyCode.D then g.vehiclefly_control.r = 0 end
         if i.KeyCode == Enum.KeyCode.Q then g.vehiclefly_control.q = 0 end
         if i.KeyCode == Enum.KeyCode.E then g.vehiclefly_control.e = 0 end
      end)
   end
end

g.stop_vehicle_fly = function()
   g.vehicle_fly = false
   g.restore_springs()
   g.disable_vehicle_noclip()
   g.cleanup()
   g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
end
task.wait(0.25)
getgenv().Vehicle_Fly_Script = Tab4:CreateToggle({
Name = "Vehicle Fly (FE)",
CurrentValue = getgenv().vehicle_fly or false,
Flag = "VehicleFlyFunctionalityToggle",
Callback = function(toggle_v_fly)
    if toggle_v_fly then
        g.vehicle_fly = true
        g.enable_vehicle_noclip()
        g.start_vehicle_fly()
    else
        getgenv().stop_vehicle_fly()
    end
end,})

if not getgenv().WalkSpeed_Has_Been_Applied then
    getgenv().WalkSpeed_Has_Been_Applied = true
    local lp = g.Players.LocalPlayer
    getgenv().hooks = {
        walkspeed = 16,
        jumppower = 50
    }
    local index
    local newindex

    index = hookmetamethod(game, "__index", function(self, property)
        if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and getgenv().hooks[property:lower()] then
            return getgenv().hooks[property:lower()]
        end
        return index(self, property)
    end)

    newindex = hookmetamethod(game, "__newindex", function(self, property, value)
        if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and getgenv().hooks[property:lower()] then
            return
        end
        return newindex(self, property, value)
    end)
end

getgenv().run_shift_speed = getgenv().run_shift_speed or 50
getgenv().walk_speed = getgenv().walk_speed or 16
getgenv().running_enabled = getgenv().running_enabled or false
local function get_human_here(plr)
    local c = getgenv().Character or plr.Character or get_char(plr)
    if not c then return nil end
    return c:FindFirstChildOfClass("Humanoid")
end

local function setup_shift_to_run()
    getgenv().FlamesLibrary.disconnect("shift_input_began")
    getgenv().FlamesLibrary.disconnect("shift_input_end")
    getgenv().FlamesLibrary.disconnect("shift_char_added")

    local shift_held = false

    getgenv().FlamesLibrary.connect("shift_input_began", getgenv().UserInputService.InputBegan:Connect(function(i, gp)
        if gp or not getgenv().running_enabled then return end
        if i.KeyCode == Enum.KeyCode.LeftShift then
            shift_held = true
            getgenv().hooks.walkspeed = getgenv().run_shift_speed
            local hum = get_human_here(getgenv().LocalPlayer)
            if hum then hum.WalkSpeed = getgenv().run_shift_speed end
        end
    end))

    getgenv().FlamesLibrary.connect("shift_input_end", getgenv().UserInputService.InputEnded:Connect(function(i, gp)
        if gp or not getgenv().running_enabled then return end
        if i.KeyCode == Enum.KeyCode.LeftShift then
            shift_held = false
            getgenv().hooks.walkspeed = getgenv().walk_speed
            local hum = get_human_here(getgenv().LocalPlayer)
            if hum then hum.WalkSpeed = getgenv().walk_speed end
        end
    end))

    getgenv().FlamesLibrary.connect("shift_char_added", getgenv().LocalPlayer.CharacterAdded:Connect(function(new_char)
        getgenv().FlamesLibrary.spawn("shift_char_spawn", "delay", 0.3, function()
            getgenv().Character = new_char
        end)
    end))
end

local function disable_shift_to_run()
    getgenv().FlamesLibrary.disconnect("shift_input_began")
    getgenv().FlamesLibrary.disconnect("shift_input_end")
    getgenv().FlamesLibrary.disconnect("shift_char_added")
    getgenv().FlamesLibrary.disconnect("shift_char_spawn")
    getgenv().hooks.walkspeed = getgenv().walk_speed
end

getgenv().ShiftToRunSpeed = Tab2:CreateInput({
Name = "Shift To Run Speed",
PlaceholderText = "Enter Speed",
RemoveTextAfterFocusLost = true,
Callback = function(get_speed)
    local s = tonumber(get_speed)
    if s then
        getgenv().run_shift_speed = s
        if getgenv().running_enabled then
            getgenv().hooks.walkspeed = s
        end
    end
end,})

getgenv().ShiftToRun = Tab2:CreateToggle({
Name = "Shift To Run",
CurrentValue = getgenv().running_enabled or false,
Flag = "SpeedCoilAlt",
Callback = function(state)
    getgenv().running_enabled = state
    if state then
        setup_shift_to_run()
    else
        disable_shift_to_run()
    end
end,})

g.AntiFling_Enabled = g.AntiFling_Enabled or false
g.antifling_parts_cache = g.antifling_parts_cache or {}
local lib = getgenv().FlamesLibrary
local _uid = 0
local function make_key(prefix, inst) _uid = _uid + 1 return prefix .. "_" .. tostring(inst):gsub("[^%w]", "") .. "_" .. _uid end
local function is_wheel_model(obj) local parent = obj.Parent return parent and (parent.Name == "Wheels" or parent.Name == "WheelsVisible") end
local function process_part(part)
    if not part:IsA("BasePart") then return end
    if g.antifling_parts_cache[part] then return end
    if is_wheel_model(part) then return end
    part.CanCollide = false
    g.antifling_parts_cache[part] = true

    local key = make_key("AntiFling_PartCleanup", part)
    lib.connect(key, part.AncestryChanged:Connect(function()
        if not part:IsDescendantOf(game) then
            g.antifling_parts_cache[part] = nil
            lib.disconnect(key)
        end
    end))
end

local function process_vehicle(model)
    if not model or not model.Parent then
        local elapsed = 0
        repeat task.wait(0.5) elapsed = elapsed + 0.5 until (model and model.Parent) or elapsed >= 10
        if not model or not model.Parent then return end
    end

    for _, inst in ipairs(model:GetDescendants()) do
        if inst:IsA("BasePart") then
            process_part(inst)
        end
    end

    lib.connect(make_key("AntiFling_DescAdded", model), model.DescendantAdded:Connect(function(desc)
        if not g.AntiFling_Enabled then return end
        if desc:IsA("BasePart") then
            process_part(desc)
        end
    end))
end

local function setup_vehicles_folder(folder)
    for _, child in ipairs(folder:GetChildren()) do
        if child:IsA("Model") then
            process_vehicle(child)
        elseif child:IsA("BasePart") then
            process_part(child)
        end
    end

    if lib.is_alive("AntiFling_ChildAdded") then
        lib.disconnect("AntiFling_ChildAdded")
    end

    lib.connect("AntiFling_ChildAdded", folder.ChildAdded:Connect(function(child)
        if not g.AntiFling_Enabled then return end
        if child:IsA("Model") then
            process_vehicle(child)
        elseif child:IsA("BasePart") then
            process_part(child)
        end
    end))

    if g.notify then
        g.notify("Success", "Flames Hub | Anti Vehicle Fling enabled.", 5)
    end
end

local function clear_all()
    g.AntiFling_Enabled = false
    table.clear(g.antifling_parts_cache)
    lib.cleanup_all()
end

g.anti_fling = function(state)
    if state == true then
        if g.AntiFling_Enabled then
            return 
        end

        g.AntiFling_Enabled = true
        table.clear(g.antifling_parts_cache)

        local main = Workspace:FindFirstChild("_Main")
        local vehicles_folder = main and main:FindFirstChild("Vehicles")
        if vehicles_folder then
            setup_vehicles_folder(vehicles_folder)
        end

        lib.connect("AntiFling_FolderWatch", Workspace.DescendantAdded:Connect(function(child)
            if not g.AntiFling_Enabled then return end
            if child.Name == "Vehicles" and child:IsA("Folder") and child.Parent and child.Parent.Name == "_Main" then
                setup_vehicles_folder(child)
            end
        end))
    elseif state == false then
        if not g.AntiFling_Enabled then
            return 
        end

        clear_all()

        if g.notify then
            g.notify("Success", "Flames Hub | Anti Vehicle Fling disabled.", 5)
        end
    end
end

getgenv().AntiFling = Tab4:CreateToggle({
Name = "Anti Vehicle Fling",
CurrentValue = g.AntiFling_Enabled or false,
Flag = "AntiVehicleFling",
Callback = function(state)
    g.anti_fling(state)
end,})

getgenv().Rainbow_FE_Car = Tab4:CreateToggle({
Name = "Rainbow Car (FE)",
CurrentValue = false,
Flag = "RainbowFECarScript",
Callback = function(rainbow_car)
    if rainbow_car then
        local colors = {
            Black = {
                ColorPrimary = Color3.new(0, 0, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Teal = {
                ColorPrimary = Color3.fromRGB(0, 128, 128),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Green = {
                ColorPrimary = Color3.fromRGB(0, 255, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Blue = {
                ColorPrimary = Color3.fromRGB(0, 0, 255),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Red = {
                ColorPrimary = Color3.fromRGB(255, 0, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Yellow = {
                ColorPrimary = Color3.fromRGB(255, 255, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Orange = {
                ColorPrimary = Color3.fromRGB(255, 165, 0),
                ColorSecondary = Color3.new(0, 0, 0),
                ReflectancePrimary = 0,
                WrapPrimary = -1
            },
            Camo = {
                ColorPrimary = Color3.fromRGB(102, 102, 51),
                ColorSecondary = Color3.fromRGB(34, 34, 17),
                ReflectancePrimary = 0.1,
                WrapPrimary = 3
            }
        }

        getgenv().rainbow_vehicle = true
        while getgenv().rainbow_vehicle == true do
        task.wait(0)
            for name, preset in pairs(colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    Vehicle_Change_RF:InvokeServer(current_car.Name, preset)
                else
                    getgenv().rainbow_vehicle = false
                    getgenv().Rainbow_FE_Car:Set(false)
                    return getgenv().notify("Error", "Vehicle has been destroyed or de-spawned, please spawn one.", 5)
                end
            end
        end
    else
        getgenv().rainbow_vehicle = false
        getgenv().rainbow_vehicle = false
    end
end,})

getgenv().Kill_Player_FE = Tab5:CreateInput({
Name = "Kill Player (FE)",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Callback = function(player_to_eliminate)
    local Target_To_Kill = findplr(player_to_eliminate)

    if not Target_To_Kill then return getgenv().notify("Error", "Player does not seem to exist.", 5) end
    if Target_To_Kill:GetAttribute("PvP_Active") == false then getgenv().notify("Warning", "This Player has PvP OFF! They may not die.", 6) end
    wait(0.2)
    if Target_To_Kill.Team == getgenv().Teams.Citizen then
        getgenv().notify("Warning", "Player is a Civilian, they MAY not die or take damage.", 5)
    end
    task.wait()
    kill_player(Target_To_Kill)
    wait(0.5)
    if getgenv().Humanoid and getgenv().Humanoid.Parent then
        pcall(function() getgenv().Humanoid:UnequipTools() end)
    end
end,})

getgenv().KillCrims = Tab5:CreateButton({
Name = "Kill Criminals (FE)",
Callback = function()
    local Players = getgenv().Players
    local Teams = getgenv().Teams
    local LocalPlayer = getgenv().LocalPlayer

    local crim_targets = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Team == Teams:FindFirstChild("Criminal") and player ~= LocalPlayer then
            table.insert(crim_targets, player)
        end
    end

    for i, player in ipairs(crim_targets) do
        kill_player(player)
    end

    if #crim_targets > 0 then
        local hum = getgenv().Character:FindFirstChildWhichIsA("Humanoid")

        if hum then
            hum:UnequipTools()
        end
    end
end,})

getgenv().KillCops = Tab5:CreateButton({
Name = "Kill Police (FE)",
Callback = function()
    local Players = getgenv().Players
    local Teams = getgenv().Teams
    local LocalPlayer = getgenv().LocalPlayer

    local cop_targets = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Team == Teams:FindFirstChild("Police") and player ~= LocalPlayer then
            table.insert(cop_targets, player)
        end
    end

    for i, player in ipairs(cop_targets) do
        kill_player(player)
    end

    if #cop_targets > 0 then
        local hum = getgenv().Character:FindFirstChildWhichIsA("Humanoid")

        if hum then
            hum:UnequipTools()
        end
    end
end,})

local function loop_kill_addon(target, toggled)
    if not target then  return warn("Target does not exist or has left the game.")  end
    if target.Team and target.Team.Name == "Civilian" then getgenv().notify("Warning", "Player is a Civilian, they MAY not die or take damage.", 5) end

    getgenv().looping_kills = true
    coroutine.wrap(function()
        while getgenv().looping_kills == true and toggled == true do
            task.wait(.1)
            if not target or not target:IsDescendantOf(game.Players) then
                getgenv().looping_kills = false
                getgenv().Humanoid:UnequipTools()
                return getgenv().notify("Info", "Turned off LoopKill, player left or does not exist.", 5)
            end

            if not target.Character or not target.Character.Parent then
                repeat task.wait() until target.Character
            end

            if target.Character and target.Character:FindFirstChild("Humanoid") then
                kill_player(target)
            end
        end
    end)()
end

getgenv().ModAll_Weapons = Tab5:CreateToggle({
Name = "Mod All Guns (lower level executors method)",
CurrentValue = false,
Flag = "ModifyingAllWeapons",
Callback = function(modded_weapons_all)
    if modded_weapons_all then
        getgenv().modded_weapons_all_of_them = true
        while getgenv().modded_weapons_all_of_them == true do
        wait(0.5)
            mod_all_guns()
        end
    else
        getgenv().modded_weapons_all_of_them = false
        getgenv().modded_weapons_all_of_them = false
    end
end,})

getgenv().InfAmmo_AllGuns = Tab5:CreateButton({
Name = "Infinite Ammo (Advanced Method, Any Weapon)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_namecall = mt.__namecall

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if method == "GetAttribute" and tostring(args[1]) == "Ammo" then
                return 9e9
            end

            return old_namecall(self, unpack(args))
        end)
    else
        return getgenv().notify("Error", "Your executor cannot run this, sorry.", 5)
    end
end,})

getgenv().NoRecoil_NameCall = Tab5:CreateButton({
Name = "No Recoil (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "RecoilMin" or name == "RecoilMax" then
                    return 0
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Error", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().NoSpread_IndexMethod = Tab5:CreateButton({
Name = "No Spread (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "MaxSpread" then
                    return 0
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Error", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().HighDamage_IndexMethod = Tab5:CreateButton({
Name = "Mod Hit Damage (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "HitDamage" then
                    return 500
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Error", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().FireModeMod_IndexMethod = Tab5:CreateButton({
Name = "Automatic Weapons (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "FireMode" then
                    return "Automatic"
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Error", "Your executor does not support this, sorry.", 5)
    end
end,})

getgenv().AllGunMods_IndexMethod = Tab5:CreateButton({
Name = "Mod All Guns (Advanced Method, Works Better)",
Callback = function()
    if getrawmetatable and setreadonly and newcclosure then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_namecall = mt.__namecall

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}

            if method == "GetAttribute" and tostring(args[1]) == "Ammo" then
                return 9e9
            end

            return old_namecall(self, unpack(args))
        end)
        wait(0.2)
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local old_index = mt.__index

        mt.__index = newcclosure(function(self, key)
            if typeof(self) == "Instance" and key == "Value" then
                local name = self.Name

                if name == "AmmoCapacity" then
                    return 9e9
                elseif name == "RecoilMin" or name == "RecoilMax" or name == "MaxSpread" then
                    return 0
                elseif name == "HitDamage" then
                    return 500
                elseif name == "FireMode" then
                    return "Automatic"
                end
            end

            return old_index(self, key)
        end)
    else
        return getgenv().notify("Error", "Your executor does not support this, sorry.", 5)
    end
end,})

local Weapons = {
    ["Desert Eagle"] = { IsWeapon = true },
    ["Pistol"] = { IsWeapon = true },
    ["Bizon"] = { IsWeapon = true },
    ["AUG"] = { IsWeapon = true },
    ["M16"] = { IsWeapon = true },
    ["MP5"] = { IsWeapon = true },
    ["UZI"] = { IsWeapon = true },
    ["P90"] = { IsWeapon = true },
    ["SCAR"] = { IsWeapon = true },
    ["SPAS-12"] = { IsWeapon = true },
    ["Scout"] = { IsWeapon = true },
    ["Sawed Off"] = { IsWeapon = true },
    ["FAMAS"] = { IsWeapon = true },
    ["Barrett"] = { IsWeapon = true },
    ["G36C"] = { IsWeapon = true },
    ["MP7"] = { IsWeapon = true },
    ["AA12"] = { IsWeapon = true },
    ["M249"] = { IsWeapon = true },
    ["Vector"] = { IsWeapon = true },
    ["Explosive Sniper"] = { IsWeapon = true },
    ["Minigun"] = { IsWeapon = true },
    ["AK"] = { IsWeapon = true },
    ["TEC-9"] = { IsWeapon = true },
}

local Weapon_Options = {}
for name, _ in pairs(Weapons) do
    table.insert(Weapon_Options, name)
end
task.wait()
local selected_weapon = nil

getgenv().ModAWeapon = Tab5:CreateDropdown({
Name = "Mod A Weapon (works for lower level executors)",
Options = Weapon_Options,
CurrentOption = "",
MultipleOptions = false,
Flag = "weapon_slot_select",
Callback = function(chosen_gun)
    selected_weapon = chosen_gun
    local Result_Weapon = getgenv().Backpack:FindFirstChild(chosen_gun)
    if not Result_Weapon then return getgenv().notify("Error", "Weapon was not found in your Backpack/inventory!", 5) end
    
    if Result_Weapon then
        mod_weapon(selected_weapon)
    end
end,})

getgenv().PvPSetting = Tab2:CreateToggle({
Name = "PvP",
CurrentValue = getgenv().pvp_damage_value or false,
Flag = "PvPToggle",
Callback = function(is_pvp_on)
    if is_pvp_on then
        getgenv().pvp_damage_value = true
        local char_pvp = getgenv().Character or LocalPlayer.Character or get_char(LocalPlayer, 10)
        local PvP_Attribute = char_pvp:GetAttribute("PVPDamageEnabled")
        if PvP_Attribute == nil then
            getgenv().pvp_damage_value = false
            getgenv().PvPSetting:Set(false)
            return getgenv().notify("Error", "PvP Attribute was not found in Character, cannot set PvP.", 5)
        end

        if getgenv().pvp_damage_value == true then
            char_pvp:SetAttribute("PVPDamageEnabled", true)
        end
    else
        getgenv().pvp_damage_value = false
        local char_pvp = getgenv().Character or LocalPlayer.Character or get_char(LocalPlayer, 10)
        local PvP_Attribute = char_pvp:GetAttribute("PVPDamageEnabled")
        if PvP_Attribute == true then
            getgenv().Character:SetAttribute("PVPDamageEnabled", false)
        end
    end
end,})
wait(0.25)
pcall(function() getgenv().Character:SetAttribute("PvPDamageEnabled", getgenv().pvp_damage_value or false) end)

getgenv().looping_kills = true
getgenv().LoopKill_Plr = Tab5:CreateInput({
Name = "LoopKill Player (FE)",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Callback = function(plr_to_loopkill)
    local Plr_LoopKill = findplr(plr_to_loopkill)
    if not Plr_LoopKill then
        return getgenv().notify("Error", "Player does not seem to exist.", 5)
    end

    getgenv().looping_kills = true
    if getgenv().LoopKilling_Tbl[Plr_LoopKill] then
        pcall(function()
            getgenv().LoopKilling_Tbl[Plr_LoopKill]:Disconnect()
        end)
        getgenv().LoopKilling_Tbl[Plr_LoopKill] = nil
    end

    if Plr_LoopKill:GetAttribute("PvP_Active") == false then getgenv().notify("Warning", "This Player has turned off PvP! They may not die.", 6) end
    task.wait(0.25)
    loop_kill_addon(Plr_LoopKill, true)
    local debounce = false
    getgenv().LoopKilling_Tbl[Plr_LoopKill] = Plr_LoopKill.CharacterAdded:Connect(function(char)
        if not getgenv().looping_kills then return end
        if debounce then return end
        debounce = true
        if Plr_LoopKill:GetAttribute("PvP_Active") == false then getgenv().notify("Warning", "This Player has turned off PvP! They may not die.", 6) end

        if not char then repeat task.wait() until char and char.Parent end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            task.wait(0.2)
            kill_player(Plr_LoopKill)
        end

        task.delay(1, function()
            debounce = false
        end)
    end)
end,})

getgenv().StopLoopKill = Tab5:CreateButton({
Name = "Shutdown/Stop LoopKill",
Callback = function()
    if not getgenv().looping_kills then
        return getgenv().notify("Warning", "Loop-Kill is not enabled!", 5)
    end

    getgenv().looping_kills = false

    for plr, conn in pairs(getgenv().LoopKilling_Tbl) do
        pcall(function()
            conn:Disconnect()
        end)
        getgenv().LoopKilling_Tbl[plr] = nil
    end

    if getgenv().Humanoid and getgenv().Humanoid.Parent then
        getgenv().Humanoid:UnequipTools()
    end

    getgenv().notify("Success", "Stopped Loop-Kill loop!", 5)
end,})

getgenv().Rainbow_Tint_FE = Tab4:CreateToggle({
Name = "Rainbow Tint (FE)",
CurrentValue = getgenv().rainbow_tinting_car or false,
Flag = "RainbowFlashingTint",
Callback = function(best_rainbow_tint)
    if best_rainbow_tint then
        local tint_colors = {
            Pink = Color3.fromRGB(255, 105, 180),
            Purple = Color3.fromRGB(128, 0, 128),
            Green = Color3.fromRGB(0, 255, 0),
            Black = Color3.fromRGB(0, 0, 0),
            White = Color3.fromRGB(255, 255, 255),
            Grey = Color3.fromRGB(128, 128, 128),
            Orange = Color3.fromRGB(255, 165, 0),
            Yellow = Color3.fromRGB(255, 255, 0),
            Camo = Color3.fromRGB(102, 102, 51),
            Brown = Color3.fromRGB(139, 69, 19)
        }

        if not (typeof(Vehicle_Change_RF) == "Instance" and Vehicle_Change_RF:IsA("RemoteFunction")) then
            getgenv().rainbow_tinting_car = false
            getgenv().Rainbow_Tint_FE:Set(false)
            return 
        end

        getgenv().rainbow_tinting_car = true
        while getgenv().rainbow_tinting_car == true do
        task.wait()
            for name, color in pairs(tint_colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    local args = {
                        tostring(current_car.Name),
                        {
                            ColorTint = color,
                            TransparencyTint = 0
                        }
                    }

                    Vehicle_Change_RF:InvokeServer(unpack(args))
                elseif not tint_colors then
                    getgenv().Rainbow_Tint_FE:Set(false)
                else
                    getgenv().rainbow_tinting_car = false
                    getgenv().Rainbow_Tint_FE:Set(false)
                    return getgenv().notify("Error", "Please spawn a vehicle before using this.", 5)
                end
            end
        end
    else
        getgenv().rainbow_tinting_car = false
        getgenv().rainbow_tinting_car = false
    end
end,})

getgenv().Rainbow_Vehicle_Underglows = Tab4:CreateToggle({
Name = "Rainbow Vehicle Underglow (FE)",
CurrentValue = getgenv().rainbow_vehicle_underglow or false,
Flag = "RainbowUnderglow",
Callback = function(rainbow_underglow)
    if rainbow_underglow then
        if not (typeof(Vehicle_Change_RF) == "Instance" and Vehicle_Change_RF:IsA("RemoteFunction")) then
            getgenv().rainbow_vehicle_underglow = false
            getgenv().Rainbow_Vehicle_Underglows:Set(false)
            return 
        end

        getgenv().rainbow_vehicle_underglow = true
        while getgenv().rainbow_vehicle_underglow == true do
        task.wait()
            local underglow_colors = {
                Pink = Color3.fromRGB(255, 105, 180),
                Purple = Color3.fromRGB(128, 0, 128),
                Green = Color3.fromRGB(0, 255, 0),
                Black = Color3.fromRGB(0, 0, 0),
                White = Color3.fromRGB(255, 255, 255),
                Grey = Color3.fromRGB(128, 128, 128),
                Orange = Color3.fromRGB(255, 165, 0),
                Yellow = Color3.fromRGB(255, 255, 0),
                Camo = Color3.fromRGB(102, 102, 51),
                Brown = Color3.fromRGB(139, 69, 19)
            }

            for name, color in pairs(underglow_colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    local args = {
                        current_car.Name,
                        {
                            ColorUnderglow = color,
                            EnabledUnderglow = true
                        }
                    }

                    Vehicle_Change_RF:InvokeServer(unpack(args))
                else
                    getgenv().rainbow_vehicle_underglow = false
                    getgenv().Rainbow_Vehicle_Underglows:Set(false)
                    return getgenv().notify("Error", "Please spawn a vehicle before using this.", 5)
                end
            end
        end
    else
        getgenv().rainbow_vehicle_underglow = false
        getgenv().rainbow_vehicle_underglow = false
    end
end,})

getgenv().Rainbow_Tires_FE = Tab4:CreateToggle({
Name = "Rainbow Tires (FE)",
CurrentValue = getgenv().RainbowTires_Script or false,
Flag = "RainbowFETiresScript",
Callback = function(Rainbow_Tires_Main)
    if Rainbow_Tires_Main then
        local wheel_colors = {
            Pink = Color3.fromRGB(255, 105, 180),
            Purple = Color3.fromRGB(128, 0, 128),
            Green = Color3.fromRGB(0, 255, 0),
            Black = Color3.fromRGB(0, 0, 0),
            White = Color3.fromRGB(255, 255, 255),
            Grey = Color3.fromRGB(128, 128, 128),
            Orange = Color3.fromRGB(255, 165, 0),
            Yellow = Color3.fromRGB(255, 255, 0),
            Camo = Color3.fromRGB(102, 102, 51),
            Brown = Color3.fromRGB(139, 69, 19)
        }

        if not (typeof(Vehicle_Change_RF) == "Instance" and Vehicle_Change_RF:IsA("RemoteFunction")) then
            getgenv().RainbowTires_Script = false
            getgenv().Rainbow_Tires_FE:Set(false)
            return 
        end

        getgenv().RainbowTires_Script = true
        while getgenv().RainbowTires_Script == true do
        task.wait(.1)
            for name, color in pairs(wheel_colors) do
                local current_car = retrieve_vehicle()
                if current_car then
                    local args = {
                        current_car.Name,
                        {
                            ColorWheels = color
                        }
                    }
                    Vehicle_Change_RF:InvokeServer(unpack(args))
                else
                    getgenv().RainbowTires_Script = false
                    getgenv().Rainbow_Tires_FE:Set(false)
                    return getgenv().notify("Error", "Please spawn a vehicle before using this.", 5)
                end
            end
        end
    else
        getgenv().RainbowTires_Script = false
        getgenv().RainbowTires_Script = false
    end
end,})

local Owned_Vehicle_Slots = {}
table.clear(Owned_Vehicle_Slots)

for name, _ in pairs(carNames) do
    table.insert(Owned_Vehicle_Slots, name)
end
wait()
local vehicle_selected = nil
local dropdown_ready = false
getgenv().Spawn_Vehicle_Plr = Tab3:CreateDropdown({
Name = "Spawn A Vehicle",
Options = Owned_Vehicle_Slots,
CurrentOption = Owned_Vehicle_Slots[1] or "",
MultipleOptions = false,
Flag = "vehicle_slot",
Callback = function(vehicle_slot_picker)
    if not dropdown_ready then
        dropdown_ready = true
        return
    end

    if typeof(vehicle_slot_picker) == "table" then
        vehicle_slot_picker = vehicle_slot_picker[1]
    end

    if not vehicle_slot_picker or vehicle_slot_picker == "" then return end

    vehicle_selected = carNames[vehicle_slot_picker]

    if not vehicle_selected then
        return notify("Error", "No vehicle found for: " .. tostring(vehicle_slot_picker), 5)
    end

    task.wait(0.3)
    spawn_vehicle(vehicle_slot_picker)
end,})

getgenv().Delete_Vehicle = Tab3:CreateButton({
Name = "Delete Current Vehicle",
Callback = function()
    local Events_Folder = getgenv().ReplicatedStorage:FindFirstChild("Events")
    if not Events_Folder then
        return getgenv().notify("Error", "Events Folder was not found inside ReplicatedStorage.", 6)
    end
    local Delete_Car_Remote = Events_Folder:FindFirstChild("RemoteEvent")
    if not Delete_Car_Remote then
        return getgenv().notify("Error", "Delete Vehicle RemoteEvent was not found in Events Folder.", 6)
    end
    local LocalPlayer = g.LocalPlayer or getgenv().LocalPlayer or game.Players.LocalPlayer
    local Humanoid = get_human(LocalPlayer) or g.Humanoid
    if not Humanoid then
        return getgenv().notify("Error", "Humanoid was not found at runtime, try resetting.", 5)
    end
    local SeatPart = Humanoid and Humanoid.SeatPart
    local Values_Folder = LocalPlayer:FindFirstChild("Values")
    if not Values_Folder then
        return getgenv().notify("Error", "Values Folder was not found inside of LocalPlayer.", 6)
    end
    local References_Folder = Values_Folder and Values_Folder:FindFirstChild("References")
    if not References_Folder then
        return getgenv().notify("Error", "References Folder was not found inside of Values Folder.", 6)
    end
    local Vehicle_Seat_Car = References_Folder and References_Folder:FindFirstChild("CarSeat").Value
    if not Vehicle_Seat_Car then
        return getgenv().notify("Error", "CarSeat Value was not found inside of References Folder.", 5)
    end

    if not SeatPart or not SeatPart.Parent then
        return getgenv().notify("Error", "You are NOT sitting in a Vehicle to delete it.", 5)
    end

    Delete_Car_Remote:FireServer("VehicleDelete", { Vehicle_Seat_Car.Parent })
end,})

getgenv().ClaimAllRewards = Tab3:CreateButton({
Name = "Claim All Rewards",
Callback = function()
    local IsClaimedFiveMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay5Mins"):GetAttribute("Claimed")
    local IsClaimedTenMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay10Mins"):GetAttribute("Claimed")
    local IsClaimedFifteenMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay15Mins"):GetAttribute("Claimed")
    local IsClaimedThirtyMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay30Mins"):GetAttribute("Claimed")
    local IsClaimedSixtyMins = getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay60Mins"):GetAttribute("Claimed")

    if IsClaimedFiveMins then
        getgenv().notify("Info", "Skipping 5 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay5Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success", "Successfully claimed 5 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedTenMins then
        getgenv().notify("Info", "Skipping 10 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay10Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success", "Successfully claimed 10 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedFifteenMins then
        getgenv().notify("Info", "Skipping 15 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay15Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success", "Successfully claimed 15 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedThirtyMins then
        getgenv().notify("Info", "Skipping 30 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay30Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success", "Successfully claimed 30 minute reward!", 5)
    end
    task.wait(.2)
    if IsClaimedSixtyMins then
        getgenv().notify("Info", "Skipping 60 Minutes Reward...", 5)
    else
        local args = {
            "QuestClaim",
            {
                getgenv().LocalPlayer:WaitForChild("Quests"):WaitForChild("Daily"):WaitForChild("QuestPlay60Mins")
            }
        }
        
        getgenv().ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        task.wait()
        getgenv().notify("Success", "Successfully claimed 60 minute reward!", 5)
    end
end,})

local function get_tuning_module(module_name)
    local current_vehicle = retrieve_vehicle()
    if not current_vehicle then return nil end
    local chassis = current_vehicle:FindFirstChild("Chassis: Core")
    if not chassis then return nil end
    local tuning = chassis:FindFirstChild("Tuning Components")
    if not tuning then return nil end
    local module = tuning:FindFirstChild(module_name)
    if not module then return nil end
    return require(module)
end

local sliders_ready = false
task.wait(0.5)
sliders_ready = true

if executor_Name ~= "Solara" and executor_Name ~= "Xeno" then
    if not string.find(executor_Name, "JJSploit") then
        local current_vehicle = retrieve_vehicle()
        if not current_vehicle then
            spawn_vehicle(randomly_selected_vehicle)
        end
        task.wait(0.3)
        local function detect_vehicle_name(real)
            local low = real:lower()
            for _, v in ipairs(vehicles) do
                if low:find(v:lower()) then
                    return v
                end
            end
        end

        local function read_components_folder()
            local veh = retrieve_vehicle()
            if not veh then return nil end
            local chassis = veh:FindFirstChild("Chassis: Core")
            if not chassis then return nil end
            local comps = chassis:FindFirstChild("Tuning Components")
            return comps
        end

        local function get_fast_values(module)
            local fast = {}
            local ok, data = pcall(require, module)
            if not ok or type(data) ~= "table" then return nil end
            for k, v in pairs(data) do
                if typeof(v) == "number" then
                    fast[k] = v * 4
                elseif typeof(v) == "boolean" then
                    fast[k] = true
                elseif typeof(v) == "table" then
                    local t2 = {}
                    for x, y in pairs(v) do
                        if typeof(y) == "number" then
                            t2[x] = y * 4
                        else
                            t2[x] = y
                        end
                    end
                    fast[k] = t2
                else
                    fast[k] = v
                end
            end
            return fast
        end

        local function apply_fast_settings(fast)
            for _, gc in next, getgc(true) do
                if type(gc) == "table" then
                    for k, v in pairs(fast) do
                        if rawget(gc, k) ~= nil then
                            rawset(gc, k, v)
                        end
                    end
                end
            end
        end

        getgenv().Apply_Best_Vehicle_Settings = Tab1:CreateButton({
        Name = "Auto Best Settings (WIP, NOT DONE YET / BETA!)",
        Callback = function()
            local veh = retrieve_vehicle()
            if not veh then
                return getgenv().notify("Error", "Spawn a vehicle first.", 6)
            end

            local found = detect_vehicle_name(veh.Name)
            if not found then
                return getgenv().notify("Error", "Unknown vehicle, add it to the table.", 6)
            end

            local comps = read_components_folder()
            if not comps then
                return getgenv().notify("Error", "Tuning folder missing.", 6)
            end

            for _, module in ipairs(comps:GetChildren()) do
                if module:IsA("ModuleScript") then
                    local fast = get_fast_values(module)
                    if fast then
                        apply_fast_settings(fast)
                    end
                end
            end
        end,})

        getgenv().Mod_Engine_HorsePower = Tab1:CreateSlider({
        Name = "HorsePower",
        Range = {5, 750},
        Increment = 1,
        Suffix = "",
        CurrentValue = 5,
        Flag = "EngineHorsepowerModifier",
        Callback = function(Desired_Horsepower)
            local current_vehicle = retrieve_vehicle()
            local Chassis_Core = current_vehicle:FindFirstChild("Chassis: Core")
            local Tuning_Components_Folder = Chassis_Core:FindFirstChild("Tuning Components")
            local Engine_Module_Script = require(Tuning_Components_Folder:FindFirstChild("Engine"))

            if current_vehicle then
                Engine_Module_Script.Horsepower = Desired_Horsepower
            end
        end,})

        getgenv().Mod_Engine_PeakRPM = Tab1:CreateSlider({
        Name = "Peak RPM",
        Range = {2000, 20000},
        Increment = 10,
        Suffix = "",
        CurrentValue = 4000,
        Flag = "EnginePeakRPMModifier",
        Callback = function(Desired_PeakRPM)
            local current_vehicle = retrieve_vehicle()
            local Chassis_Core = current_vehicle:FindFirstChild("Chassis: Core")
            local Tuning_Components_Folder = Chassis_Core:FindFirstChild("Tuning Components")
            local Engine_Module_Script = require(Tuning_Components_Folder:FindFirstChild("Engine"))

            if current_vehicle then
                Engine_Module_Script.PeakRPM = Desired_PeakRPM
            end
        end,})

        getgenv().Mod_Engine_Braking = Tab1:CreateSlider({
        Name = "Braking",
        Range = {1000, 99999},
        Increment = 100,
        Suffix = "",
        CurrentValue = 2500,
        Flag = "EngineBrakingModifier",
        Callback = function(Desired_BrakePower)
            local current_vehicle = retrieve_vehicle()
            local Chassis_Core = current_vehicle:FindFirstChild("Chassis: Core")
            local Tuning_Components_Folder = Chassis_Core:FindFirstChild("Tuning Components")
            local Engine_Module_Script = require(Tuning_Components_Folder:FindFirstChild("Engine"))

            if current_vehicle then
                Engine_Module_Script.Braking = Desired_BrakePower
            end
        end,})

        getgenv().Mod_Engine_RevAccel = Tab1:CreateSlider({
        Name = "Rev Acceleration",
        Range = {100, 99999},
        Increment = 50,
        Suffix = "",
        CurrentValue = 100,
        Flag = "EngineRevAccelModifier",
        Callback = function(Desired_RevAccel)
            local current_vehicle = retrieve_vehicle()
            local Chassis_Core = current_vehicle:FindFirstChild("Chassis: Core")
            local Tuning_Components_Folder = Chassis_Core:FindFirstChild("Tuning Components")
            local Engine_Module_Script = require(Tuning_Components_Folder:FindFirstChild("Engine"))

            if current_vehicle then
                Engine_Module_Script.RevAccel = Desired_RevAccel
            end
        end,})

        getgenv().Mod_Engine_ThrotAccel = Tab1:CreateSlider({
        Name = "Throttle Acceleration",
        Range = {0.1, 1},
        Increment = 0.1,
        Suffix = "",
        CurrentValue = 0.5,
        Flag = "EngineThrottleAccelModifier",
        Callback = function(Desired_ThrotAccel)
            local current_vehicle = retrieve_vehicle()
            local Chassis_Core = current_vehicle:FindFirstChild("Chassis: Core")
            local Tuning_Components_Folder = Chassis_Core:FindFirstChild("Tuning Components")
            local Engine_Module_Script = require(Tuning_Components_Folder:FindFirstChild("Engine"))

            if current_vehicle then
                Engine_Module_Script.ThrotAccel = Desired_ThrotAccel
            end
        end,})

        getgenv().Mod_Engine_CurveMult = Tab1:CreateSlider({
        Name = "Curve Multiplier",
        Range = {0.2, 2},
        Increment = 0.1,
        Suffix = "",
        CurrentValue = 0.4,
        Flag = "EngineCurveMultiplierModifier",
        Callback = function(Desired_CurveMult)
            local current_vehicle = retrieve_vehicle()
            local Chassis_Core = current_vehicle:FindFirstChild("Chassis: Core")
            local Tuning_Components_Folder = Chassis_Core:FindFirstChild("Tuning Components")
            local Engine_Module_Script = require(Tuning_Components_Folder:FindFirstChild("Engine"))

            if current_vehicle then
                Engine_Module_Script.CurveMult = Desired_CurveMult
            end
        end,})
    else
        getgenv().notify("Warning", "JJSploit does not work with Car Mods on this script!", 5)
    end
else
    getgenv().notify("Warning", "Solara/Xeno does not work with Car Mods on this script!", 5)
end

getgenv().Vehicle_TP_Player = Tab3:CreateInput({
Name = "Vehicle TP To Player (can bypass range limitations)",
PlaceholderText = "User",
RemoveTextAfterFocusLost = true,
Callback = function(player_to_TP_to)
    local Player_To_TP = findplr(player_to_TP_to)

    if not Player_To_TP then return getgenv().notify("Error", "Player was not found.", 5) end
    task.wait(.3)
    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = g.LocalPlayer or Players.LocalPlayer
    local Vehicles_LocalPlayer_Folder = LocalPlayer:FindFirstChild("Vehicles")
    local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
    local Main_Folder = Workspace:FindFirstChild("_Main")
    local Vehicles_Folder = Main_Folder and Main_Folder:FindFirstChild("Vehicles")
    if not Vehicles_Folder then
        return getgenv().notify("Error", "Vehicles Folder does not exist in _Main", 5)
    end
    local Vehicle = retrieve_vehicle()
    local PlayerName = tostring(Player_To_TP)
    local TargetPlayer = Players:FindFirstChild(PlayerName)

    if Vehicle and TargetPlayer and TargetPlayer.Character then
        local charPivot = get_char(TargetPlayer):GetPivot()
        local newCFrame = charPivot + Vector3.new(0, 15, 0)
        
        Vehicle:PivotTo(newCFrame)
    elseif not Vehicle then
        return getgenv().notify("Error", "Please spawn a vehicle to use this feature!", 5)
    else
        return getgenv().notify("Error", "Target or Target's Character does not exist!", 5)
    end
end,})

getgenv().Inf_Yield = Tab3:CreateButton({
Name = "Infinite Yield",
Callback = function()
    if getgenv().GET_LOADED_IY then
        return getgenv().notify("Warning", "You already have Infinite Premium loaded, you may not load IY (will cause issues).", 15)
    end
    if getgenv().IY_LOADED then
        return getgenv().notify("Warning", "Infinite Yield is already loaded.")
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end,})

getgenv().System_Broken = Tab3:CreateButton({
Name = "System Broken",
Callback = function()
    if getgenv().GUI_Loaded then
        return getgenv().notify("Warning", "System Broken is already loaded.", 5)
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/System_Broken.lua"))()
end,})
