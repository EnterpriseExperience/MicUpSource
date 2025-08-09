repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer
wait()
local Flames_API = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua"))()
local Workspace, VirtualUser, HttpService, AssetService, Players, SoundService, ReplicatedStorage, Teams, vc_internal, vc_service
local Script_Version = "V1.2.1-SWFL"

for _, name in ipairs({
    "Workspace",
    "VirtualUser",
    "HttpService",
    "AssetService",
    "Players",
    "SoundService",
    "ReplicatedStorage",
    "Teams",
    "VoiceChatInternal",
    "VoiceChatService"
}) do
    local service = Flames_API.Service(name)

    if name == "Workspace" then
        Workspace = service
    elseif name == "VirtualUser" then
        VirtualUser = service
    elseif name == "HttpService" then
        HttpService = service
    elseif name == "AssetService" then
        AssetService = service
    elseif name == "Players" then
        Players = service
    elseif name == "SoundService" then
        SoundService = service
    elseif name == "ReplicatedStorage" then
        ReplicatedStorage = service
    elseif name == "Teams" then
        Teams = service
    elseif name == "VoiceChatInternal" then
        vc_internal = service
    elseif name == "VoiceChatService" then
        vc_service = service
    end
end

local WAIT = wait
local Wait = wait
local Cars = Workspace:FindFirstChild('Cars') or Workspace:WaitForChild("Cars", 3)
local loadCharRemote = ReplicatedStorage:FindFirstChild('loadCharRemote')
local TeamEvent = ReplicatedStorage:FindFirstChild('TeamEvent')
local SpawnCar = ReplicatedStorage:FindFirstChild('SpawnCar')
local Song_Control_Event = ReplicatedStorage:WaitForChild("songControlEvent")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character and Character:FindFirstChildWhichIsA('Humanoid') or Character:WaitForChild('Humanoid', 3)
local Head = Character and Character:FindFirstChild("Head") or Character:WaitForChild("Head", 3)
local HumanoidRootPart = Character and Character:FindFirstChild('HumanoidRootPart') or Humanoid.RootPart or Character:WaitForChild('HumanoidRootPart', 1)
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") or LocalPlayer:FindFirstChildOfClass("PlayerGui")
local PlayerScripts = LocalPlayer:FindFirstChildOfClass('PlayerScripts')
local GC = getconnections or get_signal_cons
http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local function Dynamic_Character_Updater(character)
    Character = character or LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    task.wait(0.3)
    local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3)
    HumanoidRootPart = (hrp and hrp:IsA("BasePart")) and hrp

    local hum = character:FindFirstChildOfClass("Humanoid")
    Humanoid = (hum and hum:IsA("Humanoid")) and hum

    local head = character:FindFirstChild("Head")
    Head = (head and head:IsA("BasePart")) and head
end

Dynamic_Character_Updater(Character)
task.wait(0.2)
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(1)
    Dynamic_Character_Updater(newCharacter)
    LocalPlayer.CharacterAdded:Wait()
    task.wait(0.5)
    Character = newCharacter
    HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
    Humanoid = newCharacter:FindFirstChild("Humanoid") or newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
    Head = newCharacter:FindFirstChild("Head") or newCharacter:WaitForChild("Head", 5)
    wait(0.2)
    if getgenv().JumpCooldown_Bypass or getgenv().JumpCooldown_Bypass == true then
        local Jump_2 = newCharacter:FindFirstChild('JumpCooldown2')
        if not Jump_2 then
            getgenv().NoJumpCooldownToggle:Set(false)
            return notify("Failure:", "JumpCooldown2 does not exist in Character!", 5)
        end
        local Jump = newCharacter:FindFirstChild('JumpCooldown')
        if not Jump then
            getgenv().NoJumpCooldownToggle:Set(false)
            return notify("Failure:", "JumpCooldown does not exist in Character!", 5)
        end
        wait()
        if Jump_2 and Jump_2:IsA("LocalScript") then
            newCharacter:FindFirstChild("JumpCooldown2").Disabled = true
            wait(0.2)
            newCharacter:FindFirstChild('JumpCooldown2'):Destroy()
        end
        if Jump and Jump:IsA("LocalScript") then
            newCharacter:FindFirstChild('JumpCooldown'):Destroy()
        end
    else
        warn("[LOG]:", "JumpCooldown is not enabled!")
    end
end)

wait()
getgenv().All_Teams = getgenv().All_Teams or {}

for _, team in pairs(Teams:GetChildren()) do
    table.insert(getgenv().All_Teams, team.Name)
end
wait(0.3)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary'))()

local function retrieve_executor()
    local name
    if identifyexecutor then
        name = identifyexecutor()
    end
    return { Name = name or 'Unknown Executor' }
end

local function return_correct_executor()
    local details = retrieve_executor()
    return string.format('%s', details.Name)
end
wait(0.1)
local executor_Name = return_correct_executor()

local vc_internal = cloneref and cloneref(game:GetService('VoiceChatInternal')) or game:GetService('VoiceChatInternal')
local vc_service = cloneref and cloneref(game:GetService('VoiceChatService')) or game:GetService('VoiceChatService')

if getgenv().voiceChat_Check then
    warn('...')
else
    getgenv().voiceChat_Check = true
    wait()
    local reconnecting = false
    local retryDuration = 4
    local maxAttempts = 500

    local function unsuspend()
        if reconnecting then
            return warn('Voice Chat Is Still Reconnecting.')
        end
        reconnecting = true

        local attempts = 0
        while attempts < maxAttempts do
            local VoiceChatInternal = cloneref and cloneref(game:GetService('VoiceChatInternal')) or game:GetService('VoiceChatInternal')
            local VoiceChatService = cloneref and cloneref(game:GetService('VoiceChatService')) or game:GetService('VoiceChatService')

            VoiceChatInternal:Leave()
            wait(0.2)
            VoiceChatService:rejoinVoice()
            wait(0.1)
            VoiceChatService:joinVoice()
            wait(0.3)
            VoiceChatInternal:Leave()
            task.wait(0.3)
            VoiceChatService:rejoinVoice()
            VoiceChatService:joinVoice()
            wait(0.5)
            if vc_internal.StateChanged ~= Enum.VoiceChatState.Ended then
                print('Successfully reconnected to voice chat!')
                reconnecting = false
                return
            end

            attempts = attempts + 1
            wait(retryDuration)
        end

        warn('Failed to reconnect after ' .. maxAttempts .. ' attempts.')
        reconnecting = false
    end

    local function onVoiceChatStateChanged(_, newState)
        if newState == Enum.VoiceChatState.Ended and not reconnecting then
            print('Voice chat disconnected, attempting to reconnect...')
            unsuspend()
        end
    end

    vc_internal.StateChanged:Connect(onVoiceChatStateChanged)
end

local IMAGE_ID = 0

if vc_internal.StateChanged == Enum.VoiceChatState.Ended then
    vc_internal:Leave()
    vc_internal:Leave()
    task.wait(0.1)
    vc_service:rejoinVoice()
    vc_service:joinVoice()
    wait()
    vc_internal:Leave()
    wait(0.2)
    vc_service:rejoinVoice()
    vc_service:joinVoice()
    task.wait(0.2)
    vc_service:rejoinVoice()
end
wait(0.1)
local function request_vehicle()
    for _, v in pairs(Cars:GetChildren()) do
        if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
            return v
        end
    end
    return nil
end
wait(0.1)
local Player_Vehicle = request_vehicle()
wait(0.1)
local Body
wait(0.1)
if Player_Vehicle then
    Body = Player_Vehicle:FindFirstChild("Body")
else
    Body = nil
end
wait(0.1)
local Window = Rayfield:CreateWindow({
    Name = 'SWFL Hub | '..tostring(Script_Version)..' | '..tostring(executor_Name),
    LoadingTitle = 'Enjoy, '..tostring(LocalPlayer),
    LoadingSubtitle = 'SWFL Hub.',
    ConfigurationSaving = {
        Enabled = false,
        FolderName = 'Config-SWFL',
        FileName = 'Config-SWFLScriptHub',
    },
    Discord = {
        Enabled = false,
        Invite = '',
        RememberJoins = false,
    },
    KeySystem = false,
    KeySettings = {
        Title = 'None',
        Subtitle = 'No key system is provided.',
        Note = '...',
        FileName = 'Key',
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = { 'None' },
    },
})
wait()
function notify(title, content, duration)
    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(duration),
        Image = tonumber(IMAGE_ID),
        Actions = {
            Ignore = {
                Name = 'Okay.',
                Callback = function()
                    print('...')
                end,
            },
        },
    })
end
wait(0.1)
getgenv().notify = notify
wait()
local Tab1 = Window:CreateTab('🏡 Home 🏡', IMAGE_ID)
local Section1 = Tab1:CreateSection('||| 🏡 Home 🏡 Section |||')
local Tab2 = Window:CreateTab('🧍 LocalPlayer 🧍', IMAGE_ID)
local Section2 = Tab2:CreateSection('||| 🧍 LocalPlayer 🧍 Section |||')
local Tab3 = Window:CreateTab('🚗 Vehicle 🚗', IMAGE_ID)
local Section3 = Tab3:CreateSection('||| 🚗 Vehicle 🚗 Section |||')
local Tab4 = Window:CreateTab('🔥‍ Car Mods 🔥', IMAGE_ID)
local Section4 = Tab4:CreateSection('||| 🔥‍ Modifications 🔥‍ Section |||')
local Tab5 = Window:CreateTab('🤖‍ Exploits 🤖', IMAGE_ID)
local Section5 = Tab5:CreateSection('||| 🤖‍ Exploits 🤖‍ Section |||')
local Tab6 = Window:CreateTab('🦿 Teleports 🦿', IMAGE_ID)
local Section6 = Tab6:CreateSection('||| 🦿 Teleports 🦿 Section |||')
wait(0.1)
if PlayerScripts:FindFirstChild("TireSmokeHandler") then
    notify("Hold On:", "Disabling LocalScript...", 6)
    wait(0.2)
    PlayerScripts:FindFirstChild("TireSmokeHandler").Disabled = true
    wait(0.3)
    if PlayerScripts:FindFirstChild("TireSmokeHandler").Disabled or PlayerScripts:FindFirstChild("TireSmokeHandler").Disabled == true then
        notify("Success:", "Disabled LocalScript successfully (hooked).", 5)
    end
end
wait(0.1)
getgenv().antiAFK_Toggle = Tab1:CreateToggle({
Name = 'Anti AFK',
CurrentValue = false,
Flag = 'AntiAFKToggleIdling',
Callback = function(toggleTheAntiAFK)
    wait(0.5)
    if toggleTheAntiAFK then
        if getgenv().AntiAFK_Connection then
            getgenv().AntiAFK_Connection:Disconnect()
            getgenv().AntiAFK_Connection = nil
        end

        if getgenv().AntiAFK_Connections then
            for _, conn in pairs(getgenv().AntiAFK_Connections) do
                conn:Disconnect()
            end
            getgenv().AntiAFK_Connections = nil
        end

        getgenv().Use_GetConnections = not getgenv().Use_GetConnections
        getgenv().Use_VirtualUser = not getgenv().Use_VirtualUser

        local function disableAFKUsingGetConnections()
            if GC then
                getgenv().Use_GetConnections = true
                getgenv().Use_VirtualUser = false
                getgenv().AntiAFK_Connections = {}
                for _, v in pairs(GC(LocalPlayer.Idled)) do
                    if v.Disable then
                        v:Disable()
                    elseif v.Disconnect then
                        v:Disconnect()
                    end
                    table.insert(getgenv().AntiAFK_Connections, v)
                end
            end
        end

        local function disableAFKUsingVirtualUser()
            getgenv().Use_VirtualUser = true
            getgenv().Use_GetConnections = false
            wait()
            getgenv().AntiAFK_Connection = LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
        wait(0.1)
        if ReplicatedStorage:FindFirstChild('AfkEvent') then
            ReplicatedStorage:FindFirstChild('AfkEvent').Parent = SoundService
        end
        wait(0.1)
        if PlayerScripts:FindFirstChild('afkEnable') then
            PlayerScripts:FindFirstChild('afkEnable').Disabled = true
            PlayerScripts:FindFirstChild('afkEnable'):FindFirstChild('afkCheck2').Disabled = true
            PlayerScripts:FindFirstChild('afkEnable'):FindFirstChild('afkCheck3').Disabled = true
            wait(0.3)
            PlayerScripts:FindFirstChild('afkEnable').Parent = SoundService
        end
        wait(0.1)
        if GC then
            disableAFKUsingGetConnections()
        else
            disableAFKUsingVirtualUser()
        end
    else
        if getgenv().AntiAFK_Connection then
            getgenv().AntiAFK_Connection:Disconnect()
            getgenv().AntiAFK_Connection = nil
        end

        if getgenv().AntiAFK_Connections then
            for _, conn in pairs(getgenv().AntiAFK_Connections) do
                conn:Disconnect()
            end
            getgenv().AntiAFK_Connections = nil
        end
        wait(0.1)
        if SoundService:FindFirstChild('AfkEvent') then
            SoundService:FindFirstChild('AfkEvent').Parent = ReplicatedStorage
        end
        wait(0.1)
        SoundService:FindFirstChild('afkEnable').Parent = PlayerScripts
    end
end,})
wait()
if getgenv().Use_Getconnections or getgenv().Use_VirtualUser then
    getgenv().antiAFK_Toggle:Set(false)
end
wait()
getgenv().NoWalkingOrJumpingSounds = Tab2:CreateToggle({
Name = 'Disable Footstep/Walking Sounds',
CurrentValue = false,
Flag = 'NoMoreWalkingSounds',
Callback = function(doCharacterSounds)
    if doCharacterSounds then
        SoundService:FindFirstChild("Footsteps").Volume = 0
        for _, v in ipairs(SoundService:FindFirstChild("Footsteps"):GetDescendants()) do
            if v:IsA("Sound") then
                v.Volume = 0
            end
        end
    else
        SoundService:FindFirstChild("Footsteps").Volume = 1
        for _, v in ipairs(SoundService:FindFirstChild("Footsteps"):GetDescendants()) do
            if v:IsA("Sound") then
                v.Volume = 1
            end
        end
    end
end,})
wait()
if SoundService:FindFirstChild("Footsteps"):FindFirstChild("Basalt").Volume == 0 then
    getgenv().NoWalkingOrJumpingSounds:Set(false)
    wait(0.2)
    SoundService:FindFirstChild("Footsteps").Volume = 1
    for _, v in ipairs(SoundService:FindFirstChild("Footsteps"):GetDescendants()) do
        if v:IsA("Sound") then
            v.Volume = 1
        end
    end
end
wait(0.1)
getgenv().NoJumpCooldownToggle = Tab2:CreateToggle({
Name = 'Disable Jump Cooldown',
CurrentValue = false,
Flag = 'ezBypassJumpCooldowns',
Callback = function(bypassingJumpCooldown)
    if bypassingJumpCooldown then
        getgenv().JumpCooldown_Bypass = true
        local Jump_2 = Character:FindFirstChild('JumpCooldown2')
        if not Jump_2 then
            getgenv().NoJumpCooldownToggle:Set(false)
            return notify("Failure:", "JumpCooldown2 does not exist in Character!", 5)
        end
        local Jump = Character:FindFirstChild('JumpCooldown')
        if not Jump then
            getgenv().NoJumpCooldownToggle:Set(false)
            return notify("Failure:", "JumpCooldown does not exist in Character!", 5)
        end
        wait()
        if Jump_2 and Jump_2:IsA("LocalScript") then
            Character:FindFirstChild("JumpCooldown2").Disabled = true
            wait(0.2)
            Character:FindFirstChild('JumpCooldown2'):Destroy()
        end
        if Jump and Jump:IsA("LocalScript") then
            Character:FindFirstChild('JumpCooldown'):Destroy()
        end
    else
        getgenv().JumpCooldown_Bypass = false
    end
end,})
wait()
if not Character:FindFirstChild('JumpCooldown2') then
    getgenv().NoJumpCooldownToggle:Set(false)
end
wait()
if getgenv().Jump_Connection then
    print('Connection is enabled, disconnecting...')
    wait()
    getgenv().Jump_Connection:Disconnect()
    getgenv().Jump_Connection = nil
end
wait(0.1)
getgenv().RespawnCharacterFast = Tab2:CreateButton({
Name = 'Respawn (fast)',
Callback = function()
    loadCharRemote:FireServer()
end,})

getgenv().ChooseADifferentTeam = Tab1:CreateDropdown({
Name = 'Choose a Team',
Options = getgenv().All_Teams,
CurrentOption = 'Team',
MultipleOptions = false,
Flag = 'chooseAnotherTeamRemote',
Callback = function(theTeamChosen)
    local another_team = theTeamChosen and theTeamChosen[1] or theTeamChosen
    local Get_Team = Teams:FindFirstChild(another_team)

    TeamEvent:FireServer(Get_Team.TeamColor)
end,})

getgenv().TeleportToPurchaseCarMenu = Tab6:CreateButton({
Name = 'Purchase Vehicle Menu',
Callback = function()
    local DealershipPart = Workspace:FindFirstChild('DealershipPart')
    if not DealershipPart then return end

    Character:PivotTo(DealershipPart:GetPivot())
end,})

getgenv().MoreRainbowCarColors = Tab3:CreateToggle({
Name = "Full Rainbow Car (FE, Needs GamePass)",
CurrentValue = false,
Flag = "MainFullCarColoring",
Callback = function(full_rainbow_fe_car)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        getgenv().Full_RGB_Car_Colors = false
        getgenv().MoreRainbowCarColors:Set(false)
        return getgenv().notify("Failure:", "You have not spawned a vehicle, spawn one!", 5)
    end

    if full_rainbow_fe_car then
        getgenv().Full_RGB_Car_Colors = true
        while getgenv().Full_RGB_Car_Colors == true do
        wait()
            local args = {
                [1] = 'UpdateColor',
                [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                [3] = 0,
                [4] = 0,
                [5] = 0,
            }

            Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
            wait()
            local args = {
                [1] = 'UpdateColor',
                [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                [3] = 87.00000241398811,
                [4] = 53.00000064074993,
                [5] = 115.00000074505806,
            }

            Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
            wait()
            local args = {
                [1] = 'UpdateColor',
                [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                [3] = 194.00000363588333,
                [4] = 0,
                [5] = 36.00000165402889,
            }

            Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
            wait()
            local args = {
                [1] = 'UpdateColor',
                [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                [3] = 229.00000154972076,
                [4] = 233.00000131130219,
                [5] = 229.00000154972076,
            }

            Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
            wait()
            local args = {
                [1] = 'UpdateColor',
                [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                [3] = 227.00000166893005,
                [4] = 91.00000217556953,
                [5] = 1.0000000591389835,
            }

            Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
            wait()
            local args = {
                [1] = 'UpdateColor',
                [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                137.00000703334808,
                1.0000000591389835,
                1.0000000591389835,
            }

            Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
            wait()
            local args = {
                [1] = "UpdateColor",
                [2] = Player_Vehicle:WaitForChild("Body"):WaitForChild("Main"):WaitForChild("Color"),
                [3] = 232.00000137090683,
                [4] = 232.00000137090683,
                [5] = 232.00000137090683
            }

            Player_Vehicle:WaitForChild("Prop_FE"):FireServer(unpack(args))
            wait()
            local args = {
                [1] = "UpdateColor",
                [2] = Player_Vehicle:WaitForChild("Body"):WaitForChild("Main"):WaitForChild("Color"),
                [3] = 33.00000183284283,
                [4] = 75.00000312924385,
                [5] = 152.0000061392784
            }

            Player_Vehicle:WaitForChild("Prop_FE"):FireServer(unpack(args))
            wait()
            local args = {
                [1] = "UpdateColor",
                [2] = Player_Vehicle:WaitForChild("WE1"):WaitForChild("M5"),
                [3] = 103.0000014603138,
                [4] = 106.00000128149986,
                [5] = 111.00000098347664
            }

            Player_Vehicle:WaitForChild("Prop_FE"):FireServer(unpack(args))
            wait()
            local args = {
                [1] = "UpdateColor",
                [2] = Player_Vehicle:WaitForChild("Body"):WaitForChild("Main"):WaitForChild("Color"),
                [3] = 255,
                [4] = 0,
                [5] = 225.8773899078369
            }

            Player_Vehicle:WaitForChild("Prop_FE"):FireServer(unpack(args))
            wait()
            local args = {
                [1] = "UpdateColor",
                [2] = Player_Vehicle:WaitForChild("WE1"):WaitForChild("M5"),
                [3] = 83.81617605686188,
                [4] = 255,
                [5] = 0
            }

            Player_Vehicle:WaitForChild("Prop_FE"):FireServer(unpack(args))
            wait()
            local args = {
                [1] = "UpdateColor",
                [2] = Player_Vehicle:WaitForChild("WE1"):WaitForChild("M5"),
                [3] = 254.2897117137909,
                [4] = 255,
                [5] = 0
            }

            Player_Vehicle:WaitForChild("Prop_FE"):FireServer(unpack(args))
        end
    end
end,})

getgenv().RainbowCarFE = Tab3:CreateToggle({
Name = 'Rainbow Car (FE, No GamePass needed!)',
CurrentValue = false,
Flag = 'rainbowCarFEScript',
Callback = function(theUltimateRainbowVehicle)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()
    
    if theUltimateRainbowVehicle then
        if not Player_Vehicle then
            getgenv().RainbowCarFE:Set(false)
            return getgenv().notify("Failure", "Please spawn a Vehicle first.", 6)
        end
        wait()
        getgenv().Rainbow_Vehicle = true
        while getgenv().Rainbow_Vehicle == true do
            wait()
            if Player_Vehicle and Player_Vehicle:FindFirstChild('Body') then
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 0,
                    [4] = 0,
                    [5] = 0,
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 147.00000643730164,
                    [4] = 31.000000052154064,
                    [5] = 25.000000409781933
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 167.00000524520874,
                    [4] = 42.000001296401024,
                    [5] = 43.00000123679638
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 229.00000154972076,
                    [4] = 230.00000149011612,
                    [5] = 224.000001847744
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 213.00000250339508,
                    [4] = 213.00000250339508,
                    [5] = 213.00000250339508
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 157.0000058412552,
                    [4] = 160.00000566244125,
                    [5] = 162.00000554323196
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 57.00000040233135,
                    [4] = 64.00000378489494,
                    [5] = 72.00000330805779
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 21.000000648200512,
                    [4] = 39.00000147521496,
                    [5] = 79.00000289082527
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
                wait()
                local args = {
                    [1] = 'UpdateColor',
                    [2] = Player_Vehicle:FindFirstChild('Body'):FindFirstChild('Main'):FindFirstChild('Color'),
                    [3] = 14.000000115484,
                    [4] = 75.00000312924385,
                    [5] = 130.0000074505806
                }

                Player_Vehicle:FindFirstChild('Prop_FE'):FireServer(unpack(args))
            else
                getgenv().RainbowCarFE:Set(false)
            end
        end
    else
        getgenv().Rainbow_Vehicle = false
        wait(0.1)
        getgenv().Rainbow_Vehicle = false
        wait(0.1)
        getgenv().Rainbow_Vehicle = false
    end
end,})
wait()
if getgenv().Rainbow_Vehicle or getgenv().Rainbow_Vehicle == true then
    getgenv().RainbowCarFE:Set(false)
end

getgenv().RemoveRain = Tab1:CreateToggle({
Name = "Remove Rain",
CurrentValue = false,
Flag = "temporarilyRemoveRainToggle",
Callback = function(theRainGone)
    if theRainGone then
        getgenv().swapped_rain_stuff = true
        wait()
        if Workspace:FindFirstChild("thunder1") then
            Workspace:FindFirstChild("thunder1").Parent = AssetService
        end
        if Workspace:FindFirstChild("thunder2") then
            Workspace:FindFirstChild("thunder2").Parent = AssetService
        end
        if Workspace:FindFirstChild("thunder3") then
            Workspace:FindFirstChild("thunder3").Parent = AssetService
        end
        if Workspace:FindFirstChild("thunder4") then
            Workspace:FindFirstChild("thunder4").Parent = AssetService
        end
        if Workspace:FindFirstChild("thunder5") then
            Workspace:FindFirstChild("thunder5").Parent = AssetService
        end
        if Workspace:FindFirstChild("thunder6") then
            Workspace:FindFirstChild("thunder6").Parent = AssetService
        end
        if Workspace:FindFirstChild("rainStorage") then
            Workspace:FindFirstChild("rainStorage").Parent = AssetService
        end
        if PlayerScripts:FindFirstChild("RainScript") then
            PlayerScripts:FindFirstChild("RainScript").Parent = AssetService
        end
        if ReplicatedStorage:FindFirstChild("Miscs") and ReplicatedStorage:FindFirstChild("Miscs"):FindFirstChild("Rain") then
            ReplicatedStorage:FindFirstChild("Miscs"):FindFirstChild("Rain").Parent = AssetService
        end
    else
        getgenv().swapped_rain_stuff = false
        wait(0.1)
        if AssetService:FindFirstChild("thunder1") then
            AssetService:FindFirstChild("thunder1").Parent = Workspace
        end
        if AssetService:FindFirstChild("thunder2") then
            AssetService:FindFirstChild("thunder2").Parent = Workspace
        end
        if AssetService:FindFirstChild("thunder3") then
            AssetService:FindFirstChild("thunder3").Parent = Workspace
        end
        if AssetService:FindFirstChild("thunder4") then
            AssetService:FindFirstChild("thunder4").Parent = Workspace
        end
        if AssetService:FindFirstChild("thunder5") then
            AssetService:FindFirstChild("thunder5").Parent = Workspace
        end
        if AssetService:FindFirstChild("thunder6") then
            AssetService:FindFirstChild("thunder6").Parent = Workspace
        end
        if AssetService:FindFirstChild("rainStorage") then
            AssetService:FindFirstChild("rainStorage").Parent = Workspace
        end
        if AssetService:FindFirstChild("RainScript") then
            AssetService:FindFirstChild("RainScript").Parent = PlayerScripts
        end
        if AssetService:FindFirstChild("Rain") then
            AssetService:FindFirstChild("Rain").Parent = ReplicatedStorage:FindFirstChild("Miscs")
        end
    end
end,})
wait()
if getgenv().swapped_rain_stuff or getgenv().swapped_rain_stuff == true then
    getgenv().RemoveRain:Set(false)
    if AssetService:FindFirstChild("thunder1") then
        AssetService:FindFirstChild("thunder1").Parent = Workspace
    end
    if AssetService:FindFirstChild("thunder2") then
        AssetService:FindFirstChild("thunder2").Parent = Workspace
    end
    if AssetService:FindFirstChild("thunder3") then
        AssetService:FindFirstChild("thunder3").Parent = Workspace
    end
    if AssetService:FindFirstChild("thunder4") then
        AssetService:FindFirstChild("thunder4").Parent = Workspace
    end
    if AssetService:FindFirstChild("thunder5") then
        AssetService:FindFirstChild("thunder5").Parent = Workspace
    end
    if AssetService:FindFirstChild("thunder6") then
        AssetService:FindFirstChild("thunder6").Parent = Workspace
    end
    if AssetService:FindFirstChild("rainStorage") then
        AssetService:FindFirstChild("rainStorage").Parent = Workspace
    end
    if AssetService:FindFirstChild("RainScript") then
        AssetService:FindFirstChild("RainScript").Parent = PlayerScripts
    end
    if AssetService:FindFirstChild("Rain") then
        AssetService:FindFirstChild("Rain").Parent = ReplicatedStorage:FindFirstChild("Miscs")
    end
end

getgenv().playable_audio_id = "1"
wait(0.1)
getgenv().PlayAnAudioID = Tab3:CreateInput({
Name = "Set Audio ID",
CurrentValue = "ID Here",
PlaceholderText = "ID Here",
RemoveTextAfterFocusLost = true,
Flag = "audioIDInput",
Callback = function(theAudioID)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        getgenv().PlayAnAudioID:Set("ID Here")
        return getgenv().notify("Failure", "Please spawn a Vehicle first.", 6)
    end

    getgenv().playable_audio_id = tostring(theAudioID)
    local AChassis_GUI = PlayerGui:FindFirstChild("A-Chassis Interface")
    local Radio_UI = AChassis_GUI:FindFirstChild("RadioUI")
    local ownRadio_Frame = Radio_UI:FindFirstChild("ownRadio")
    local ownID_TextLabel = ownRadio_Frame:FindFirstChild("ownID")
    ownID_TextLabel.Text = getgenv().playable_audio_id
    if not request_vehicle():FindFirstChild("Body") then
        return notify("Failure:", "Body was not found inside: "..tostring(request_vehicle().Name).." (broken)!", 5)
    end

    if not request_vehicle():FindFirstChild("Body"):FindFirstChild("campos") then
        return notify("Failure:", "'campos' was not found inside Body inside: "..tostring(request_vehicle().Name).."!", 5)
    end

    request_vehicle():WaitForChild("Body"):WaitForChild("campos"):WaitForChild("radioTog").Value = true
end,})

getgenv().PlayAudioID = Tab3:CreateToggle({
Name = "Play Set Audio",
CurrentValue = false,
Flag = "TheAudioPlaying",
Callback = function(whatAudioWePlaying)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if whatAudioWePlaying then
        if not Player_Vehicle then
            getgenv().PlayAudioID:Set(false)
            return getgenv().notify("Failure", "Please spawn a Vehicle first.", 6)
        end
        wait()
        getgenv().ok_boys_lets_play = true
        local args = {
            [1] = Player_Vehicle,
            [2] = Player_Vehicle:WaitForChild("Body"):WaitForChild("campos"):WaitForChild("ownIDConfirm"),
            [3] = getgenv().playable_audio_id
        }

        ReplicatedStorage:WaitForChild("songControlEvent"):FireServer(unpack(args))
    else
        getgenv().ok_boys_lets_play = false
        Player_Vehicle:WaitForChild("Body"):WaitForChild("campos"):WaitForChild("radioTog").Value = false
        wait(0.1)
        local args = {
            [1] = Player_Vehicle,
            [2] = Player_Vehicle:WaitForChild("Body"):WaitForChild("campos"):WaitForChild("ownIDConfirm"),
            [3] = "stop"
        }

        ReplicatedStorage:WaitForChild("songControlEvent"):FireServer(unpack(args))
    end
end,})

getgenv().HornToggledOn = Tab3:CreateToggle({
Name = "Toggle Horn",
CurrentValue = false,
Flag = "hornUpdatingToggle",
Callback = function(theHornEnabled)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if theHornEnabled then
        if not Player_Vehicle then
            getgenv().HornToggledOn:Set(false)
            return getgenv().notify("Failure", "Please spawn a Vehicle first.", 6)
        end
        wait()
        getgenv().car_horn = true
        Player_Vehicle:WaitForChild("HornUpdate"):FireServer(true)
    else
        getgenv().car_horn = false
        Player_Vehicle:WaitForChild("HornUpdate"):FireServer(false)
    end
end,})
wait()
if getgenv().car_horn or getgenv().car_horn == true then
    getgenv().car_horn = false
    getgenv().HornToggledOn:Set(false)
    wait(0.1)
    if Player_Vehicle then
        Player_Vehicle:WaitForChild("HornUpdate"):FireServer(false)
    end
end

local Wait_Time
local FuelAmount
wait()
getgenv().ModifyFuelAmountToBeRefilled = Tab3:CreateInput({
Name = "Fuel Amount (For Loop)",
CurrentValue = "Fuel",
PlaceholderText = "Amount",
RemoveTextAfterFocusLost = true,
Flag = "ModifyingFuelAmountLooping",
Callback = function(the_fuel_amount)
    FuelAmount = tonumber(the_fuel_amount)
end,})

getgenv().WaitTimeForFuelLoop = Tab3:CreateInput({
Name = "Wait Time (To Refill Fuel)",
CurrentValue = "Number",
PlaceholderText = "Wait Time",
RemoveTextAfterFocusLost = true,
Flag = "ModifyWaitTimeForLoop",
Callback = function(wait_time_here)
    Wait_Time = tonumber(wait_time_here)
end,})

getgenv().RefillCarFuelLoop = Tab3:CreateToggle({
Name = "Refill Car Fuel Loop (Cost Money)",
CurrentValue = false,
Flag = "RefillingVehicleFuelLoop",
Callback = function(refilling_car)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        getgenv().RefillCarFuelLoop:Set(false)
        return getgenv().notify("Failure", "Could not find your Vehicle, spawn a vehicle.", 5)
    end

    if not ReplicatedStorage:FindFirstChild("fuelEvent") then
        getgenv().notify("Failure:", "This might be patched!, read below:", 5)
        return getgenv().notify("Failure:", "FuelEvent does not exist in ReplicatedStorage!", 5)
    end

    if not ReplicatedStorage:FindFirstChild("PetrolPrice") then
        return getgenv().notify("Failure:", "PetrolPrice does not exist in RepliatedStorage (broken)!", 5)
    end

    if not ReplicatedStorage:FindFirstChild("DieselPrice") then
        return getgenv().notify("Failure:", "DieselPrice does not exist in ReplicatedStorage (broken)!", 5) 
    end
    wait()
    if refilling_car and request_vehicle() then
        getgenv().refilling_my_vehicle_fuel = true
        while getgenv().refilling_my_vehicle_fuel == true do
        wait(0.6)
            local args = {
                [1] = "requestPurchase",
                [2] = request_vehicle(),
                [3] = tonumber(FuelAmount),
                [4] = ReplicatedStorage:WaitForChild("PetrolPrice"),
                [5] = ReplicatedStorage:WaitForChild("DieselPrice")
            }

            ReplicatedStorage:WaitForChild("fuelEvent"):FireServer(unpack(args))
        end
    elseif not request_vehicle() then
        getgenv().refilling_my_vehicle_fuel = false
        wait(0.3)
        getgenv().refilling_my_vehicle_fuel = false
        wait(0.3)
        getgenv().refilling_my_vehicle_fuel = false
        wait(0.5)
        for i = 1, 500 do
            getgenv().refilling_my_vehicle_fuel = false
        end
    elseif not refilling_car or refilling_car == false then
        getgenv().notify("Hang On:", "Shutting down refilling loop...", 5)
        getgenv().refilling_my_vehicle_fuel = false
        wait(0.3)
        getgenv().refilling_my_vehicle_fuel = false
        wait(0.3)
        getgenv().refilling_my_vehicle_fuel = false
        wait(0.5)
        for i = 1, 50 do
            getgenv().refilling_my_vehicle_fuel = false
        end
        wait(0.3)
        notify("Success:", "Successfully shut down refilling loop...", 5)
    end
end,})

getgenv().FuelCarTank = Tab3:CreateInput({
Name = "Car Fuel",
CurrentValue = "Fuel",
PlaceholderText = "Fuel Amount",
RemoveTextAfterFocusLost = true,
Flag = "GetFuelForVehicle",
Callback = function(fuelYouWant)
    if not tonumber(fuelYouWant) then
        return getgenv().notify("Failure", "You did not enter in a number.", 6)
    end
    wait()
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        return notify("Failure:", "You do not have a vehicle spawned!", 5)
    end

    if not ReplicatedStorage:FindFirstChild("fuelEvent") then
        return notify("Failure:", "fuelEvent does not exist in ReplicatedStorage!", 5)
    end
    wait()
    local args = {
        [1] = "requestPurchase",
        [2] = Player_Vehicle,
        [3] = tonumber(fuelYouWant),
        [4] = ReplicatedStorage:WaitForChild("PetrolPrice"),
        [5] = ReplicatedStorage:WaitForChild("DieselPrice")
    }

    ReplicatedStorage:WaitForChild("fuelEvent"):FireServer(unpack(args))
end,})

getgenv().StopAllAudios = Tab3:CreateButton({
Name = "Stop All Car Audios",
Callback = function()
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        return getgenv().notify("Failure", "Please spawn a Vehicle first.", 6)
    end
    wait()
    local AChassis_GUI = PlayerGui:FindFirstChild("A-Chassis Interface")
    local Radio_UI = AChassis_GUI:FindFirstChild("RadioUI")
    local ownRadio_Frame = Radio_UI:FindFirstChild("ownRadio")
    local ownID_TextLabel = ownRadio_Frame:FindFirstChild("ownID")
    wait()
    local args = {
        [1] = Player_Vehicle,
        [2] = Player_Vehicle:WaitForChild("Body"):WaitForChild("campos"):WaitForChild("ownIDConfirm"),
        [3] = "stop"
    }

    ReplicatedStorage:WaitForChild("songControlEvent"):FireServer(unpack(args))
    wait(0.1)
    ownID_TextLabel.Text = ""
end,})

getgenv().Radio_Volume = Tab3:CreateSlider({
Name = "Radio Volume Controller",
Range = {0, 0.9},
Increment = 0.1,
Suffix = "",
CurrentValue = 0.5,
Flag = "radioVolumeSliderControl",
Callback = function(Radio_Volume_Here)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        return 
    end
    wait()
    local args = {
        [1] = Player_Vehicle,
        [2] = Player_Vehicle:WaitForChild("Body"):WaitForChild("campos"):WaitForChild("lastVol"),
        [3] = Radio_Volume_Here
    }

    Song_Control_Event:FireServer(unpack(args))
end,})

getgenv().all_lights = getgenv().all_lights or {}
wait(0.2)
function table_lights()
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end

    local vehicle = request_vehicle()

    if vehicle then
        local lights = vehicle:FindFirstChild("Body") and vehicle.Body:FindFirstChild("Lights")

        if lights then
            for _, light in ipairs(lights:GetChildren()) do
                if light:IsA("MeshPart") then
                    table.insert(getgenv().all_lights, light)
                end
            end
        end
    end
end

wait(0.1)
local function change_light_colors(color)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()
    
    for _, light in ipairs(getgenv().all_lights) do
        local args = {
            [1] = "UpdateLight",
            [2] = light,
            [3] = Enum.Material.SmoothPlastic,
            [4] = BrickColor.new(tonumber(color)),
            [5] = 0.015,
            [6] = true,
            [7] = 10,
            [8] = "rbxassetid://8615996420"
        }

        Player_Vehicle:WaitForChild("Lights_FE"):FireServer(unpack(args))
    end
end

getgenv().TheRainbowLights = Tab3:CreateToggle({
Name = "Rainbow Lights (FE)",
CurrentValue = false,
Flag = "UltimateRGBLights",
Callback = function(EnableRainbowLights)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()
    local Body = Player_Vehicle:FindFirstChild("Body")
    if not Body then return notify("Failure:", "'Body' was not found inside Vehicle: "..tostring(request_vehicle().Name).."!", 5) end

    if EnableRainbowLights then
        if not Player_Vehicle then
            getgenv().spamming_rgb_car_lights = false
            getgenv().TheRainbowLights:Set(false)
            return getgenv().notify("Failure", "Please spawn a Vehicle first.", 6)
        end
        wait()
        getgenv().spamming_rgb_car_lights = true
        while getgenv().spamming_rgb_car_lights == true do
        wait()
            for _, v in ipairs(Body.Lights:GetDescendants()) do
                if v:IsA("MeshPart") then
                    change_light_colors(1)
                    wait()
                    change_light_colors(21)
                    wait()
                    change_light_colors(23)
                    wait()
                    change_light_colors(26)
                    wait()
                    change_light_colors(22)
                    wait()
                    change_light_colors(25)
                    wait()
                    change_light_colors(37)
                    wait()
                    change_light_colors(104)
                    wait()
                    change_light_colors(193)
                    wait()
                    change_light_colors(327)
                end
            end
        end
    else
        getgenv().spamming_rgb_car_lights = false
        wait()
        getgenv().spamming_rgb_car_lights = false
    end
end,})

if getgenv().spamming_rgb_car_lights or getgenv().spamming_rgb_car_lights == true then
    getgenv().TheRainbowLights:Set(false)
end

getgenv().GetInCar = Tab3:CreateButton({
Name = "Get In Car (from anywhere, spawn vehicle first)",
Callback = function()
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not ReplicatedStorage:FindFirstChild("PromptEvent") then
        return notify("Failure:", "PromptEvent doesn't exist in ReplicatedStorage! (Patched?)", 5)
    end

    if not Player_Vehicle then
        return getgenv().notify("Failure", "Please spawn a Vehicle first.", 6)
    end
    wait()
    if Character and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("HumanoidRootPart") then
        Character:PivotTo(Player_Vehicle:GetPivot())
    else
        notify("Hang On:", "It seems as if your character has not loaded yet!", 5)
        repeat wait() until Character and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("HumanoidRootPart")
        wait(0.3)
        Character:PivotTo(Player_Vehicle:GetPivot())
    end
    wait(0.3)
    local args = {
        [1] = "DriveRequest",
        [2] = request_vehicle():FindFirstChild("DriveSeat") or request_vehicle():WaitForChild("DriveSeat")
    }

    ReplicatedStorage:WaitForChild("PromptEvent"):FireServer(unpack(args))
end,})

getgenv().PVPEnabler = Tab2:CreateToggle({
Name = "PVP Switch",
CurrentValue = false,
Flag = "ThePVPSwitchToggle",
Callback = function(pvpEnabled)
    if pvpEnabled then
        if not HumanoidRootPart:FindFirstChild("jobCharUI") then
            getgenv().PVPEnabler:Set(false)
            return getgenv().notify("Failure", "jobCharUI not found, try resetting.", 5)
        end

        if not HumanoidRootPart:FindFirstChild("jobCharUI"):FindFirstChild("Frame") then
            return notify("Failure:", "Frame was not found inside jobCharUI! (Patched?)", 5)
        end

        if not ReplicatedStorage:FindFirstChild("pvpManagerEvent") then
            return notify("Failure:", "'pvpManagerEvent' RemoteEvent was not found in ReplicatedStorage! (Patched?)", 5)
        end

        if not PlayerGui:FindFirstChild("pvpUI") then
            return notify("Failure:", "pvpUI was not found in PlayerGui! (Patched?)", 5)
        end

        if not PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF") then
            return notify("Failure:", "pvpF was not found inside pvpUI! (Patched?)", 5)
        end
        wait()
        getgenv().is_pvp_on = true
        wait()
        local args = {
            [1] = HumanoidRootPart:FindFirstChild("jobCharUI"):FindFirstChild("Frame"):FindFirstChild("pvpCheck")
        }

        ReplicatedStorage:WaitForChild("pvpManagerEvent"):FireServer(unpack(args))
        wait()
        PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF"):FindFirstChild("pvpB").Text = "DISABLE PVP"
    else
        getgenv().is_pvp_on = false
        wait()
        local args = {
            [1] = HumanoidRootPart:FindFirstChild("jobCharUI"):FindFirstChild("Frame"):FindFirstChild("pvpCheck")
        }

        ReplicatedStorage:WaitForChild("pvpManagerEvent"):FireServer(unpack(args))
        wait(0.1)
        PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF"):FindFirstChild("pvpB").Text = "ENABLE PVP"
    end
end,})
wait()
if getgenv().is_pvp_on or getgenv().is_pvp_on == true then
    getgenv().PVPEnabler:Set(false)
    getgenv().is_pvp_on = false
    wait(0.2)
    if PlayerGui:FindFirstChild("pvpUI") and PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF") and PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF"):FindFirstChild("pvpB") then
        PlayerGui:FindFirstChild("pvpUI"):FindFirstChild("pvpF"):FindFirstChild("pvpB").Text = "ENABLE PVP"
    end
end

getgenv().TPToCar = Tab6:CreateButton({
Name = "Teleport To Car",
Callback = function()
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()

    if not Player_Vehicle then
        return getgenv().notify("Failure", "Please spawn a Vehicle first.", 5)
    end
    wait()
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        Character:PivotTo(request_vehicle():GetPivot())
    end
end,})

local function change_car_settings(setting, new_value)
    local function request_vehicle()
        for _, v in pairs(Cars:GetChildren()) do
            if v:FindFirstChild('PlayerLoc').Value == LocalPlayer then
                return v
            end
        end
        return nil
    end
    wait(0.1)
    local Player_Vehicle = request_vehicle()
    local requireSupported = true
    local success, result = pcall(function()
        return require
    end)

    if not success or type(result) ~= "function" then
        requireSupported = false
    end

    if not requireSupported then
        warn("Your exploit does not support 'require' for non-Roblox ModuleScripts.")
        return getgenv().notify("Failure", "Your exploit does not support 'require'.", 5)
    end

    if not Player_Vehicle then
        warn("No car found for the player.")
        return getgenv().notify("Failure", "Please spawn a Vehicle first.", 5)
    end

    local moduleScript = Player_Vehicle:FindFirstChild("A-Chassis Tune")
    wait()
    if not moduleScript then
        warn("No ModuleScript found in Vehicle.")
        return getgenv().notify("Failure", "Unable to properly allocate ModuleScript inside of Vehicle.", 7)
    end

    local vehicle_configuration = nil
    success, vehicle_configuration = pcall(require, moduleScript)
    if not success then
        warn("Failed to require the ModuleScript: ", vehicle_configuration)
        return getgenv().notify("Failure", "Unknown error occurred when rying to pcall vehicle configuration.", 7)
    end
    wait()
    vehicle_configuration.TCSEnabled = true
    vehicle_configuration.TCSThreshold = 3
    vehicle_configuration.TCSGradient = 3
    vehicle_configuration.TCSLimit = 0.1
    vehicle_configuration.RDiffSlipThres = 30
    vehicle_configuration.RDiffPower = 15
    vehicle_configuration.ABSEnabled = false
    vehicle_configuration[setting] = new_value
end

getgenv().ApplyBestModSettings = Tab4:CreateButton({
Name = "Apply Fastest/Best Car Mods",
Callback = function()
    change_car_settings("TCSEnabled", true)
    change_car_settings("SpeedEngage", 1000)
    change_car_settings("TCSThreshold", 3)
    change_car_settings("TCSGradient", 3)
    change_car_settings("TCSLimit", 0.1)
    change_car_settings("RDiffSlipThres", 30)
    change_car_settings("RDiffPower", 15)
    change_car_settings("ABSEnabled", false)
    change_car_settings("BrakeForce", 7500)
    change_car_settings("BrakeBias", 25)
    change_car_settings("PBrakeForce", 150000)
    change_car_settings("EBrakeForce", 50000)
    change_car_settings("Horsepower", 4000)
    change_car_settings("RPreCompress", 0.9)
    change_car_settings("FPreCompress", 0.9)
    change_car_settings("FinalDrive", 350)
    change_car_settings("RevAccel", 3000)
end,})

getgenv().ModifySpeedEngage = Tab4:CreateSlider({
Name = "Modify Speed Engage",
Range = {1, 1000},
Increment = 1,
Suffix = "",
CurrentValue = 5,
Flag = "speedingControlVehicle",
Callback = function(TheVehicleSpeed)
    change_car_settings("SpeedEngage", TheVehicleSpeed)
end,})

getgenv().ModifyBrake = Tab4:CreateSlider({
Name = "Modify BrakeForce",
Range = {10, 7500},
Increment = 1,
Suffix = "",
CurrentValue = 1,
Flag = "brakingControllingYourCar",
Callback = function(newValForBraking)
    change_car_settings("BrakeForce", newValForBraking)
end,})

getgenv().ModifyHorsepower = Tab4:CreateSlider({
Name = "Modify Horsepower",
Range = {100, 5000},
Increment = 10,
Suffix = " HP",
CurrentValue = 470,
Flag = "horsepowerControl",
Callback = function(newHP)
    change_car_settings("Horsepower", newHP)
end,})

getgenv().ModifySteerRatio = Tab4:CreateSlider({
Name = "Modify Steering Ratio",
Range = {1, 20},
Increment = 0.1,
Suffix = "",
CurrentValue = 9,
Flag = "steeringRatioControl",
Callback = function(newRatio)
    change_car_settings("SteerRatio", newRatio)
end,})

getgenv().ModifyBrakeBias = Tab4:CreateSlider({
Name = "Modify Brake Bias",
Range = {0, 500},
Increment = 1,
Suffix = "",
CurrentValue = 5,
Flag = "brakeBiasControl",
Callback = function(newBias)
    change_car_settings("BrakeBias", newBias)
end,})

getgenv().ModifyFinalDrive = Tab4:CreateSlider({
Name = "Modify Final Drive Ratio",
Range = {0, 5},
Increment = 0.1,
Suffix = "",
CurrentValue = 0,
Flag = "finalDriveControl",
Callback = function(newDrive)
    change_car_settings("FinalDrive", newDrive)
end,})

getgenv().ModifySuspensionStiffness = Tab4:CreateSlider({
Name = "Modify Suspension Stiffness",
Range = {1000, 20000},
Increment = 100,
Suffix = "",
CurrentValue = 6500,
Flag = "suspensionStiffnessControl",
Callback = function(newStiffness)
    change_car_settings("FSusStiffness", newStiffness)
    change_car_settings("RSusStiffness", newStiffness)
end,})

getgenv().ModifySuspensionDamping = Tab4:CreateSlider({
Name = "Modify Suspension Damping",
Range = {100, 5000},
Increment = 50,
Suffix = "",
CurrentValue = 400,
Flag = "suspensionDampingControl",
Callback = function(newDamping)
    change_car_settings("FSusDamping", newDamping)
    change_car_settings("RSusDamping", newDamping)
end,})

getgenv().ModifyPreCompress = Tab4:CreateSlider({
Name = "Modify Pre-Compression",
Range = {0, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.675,
Flag = "preCompressControl",
Callback = function(newPreComp)
    change_car_settings("FPreCompress", newPreComp)
    change_car_settings("RPreCompress", newPreComp)
end,})

getgenv().ModifySteerSpeed = Tab4:CreateSlider({
Name = "Modify Steering Speed",
Range = {1, 750},
Increment = 1,
Suffix = "",
CurrentValue = 3,
Flag = "steeringSpeedControl",
Callback = function(newSteerSpeed)
    change_car_settings("SteerSpeed", newSteerSpeed)
end,})

getgenv().ModifySteerMaxTorque = Tab4:CreateSlider({
Name = "Modify Steering Max Torque",
Range = {10, 10000},
Increment = 5,
Suffix = "",
CurrentValue = 500,
Flag = "steerMaxTorqueControl",
Callback = function(newSteerTorque)
    change_car_settings("SteerMaxTorque", newSteerTorque)
end,})

getgenv().ModifyAckerman = Tab4:CreateSlider({
Name = "Modify Ackerman Steering",
Range = {0, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.9,
Flag = "ackermanControl",
Callback = function(newAckerman)
    change_car_settings("Ackerman", newAckerman)
end,})

getgenv().ModifyWeightDistribution = Tab4:CreateSlider({
Name = "Modify Weight Distribution",
Range = {40, 60},
Increment = 1,
Suffix = "%",
CurrentValue = 54,
Flag = "weightDistControl",
Callback = function(newWeightDist)
    change_car_settings("WeightDist", newWeightDist)
end,})

getgenv().ModifyTorqueVectoring = Tab4:CreateSlider({
Name = "Modify Torque Vectoring",
Range = {-1, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = -0.15,
Flag = "torqueVectorControl",
Callback = function(newTorqueVec)
    change_car_settings("TorqueVector", newTorqueVec)
end,})

getgenv().ModifySuperchargerBoost = Tab4:CreateSlider({
Name = "Modify Supercharger Boost",
Range = {0, 50},
Increment = 1,
Suffix = " PSI",
CurrentValue = 13,
Flag = "superchargerBoostControl",
Callback = function(newBoost)
    change_car_settings("S_Boost", newBoost)
end,})

getgenv().ModifySuperchargerEfficiency = Tab4:CreateSlider({
Name = "Modify Supercharger Efficiency",
Range = {0, 20},
Increment = 0.1,
Suffix = "",
CurrentValue = 8.5,
Flag = "superchargerEfficiencyControl",
Callback = function(newEfficiency)
    change_car_settings("S_Efficiency", newEfficiency)
end,})

getgenv().ModifyTurboBoost = Tab4:CreateSlider({
Name = "Modify Turbo Boost",
Range = {0, 50},
Increment = 1,
Suffix = " PSI",
CurrentValue = 10,
Flag = "turboBoostControl",
Callback = function(newTurboBoost)
    change_car_settings("T_Boost", newTurboBoost)
end,})

getgenv().ModifyTurboEfficiency = Tab4:CreateSlider({
Name = "Modify Turbo Efficiency",
Range = {0, 20},
Increment = 0.1,
Suffix = "",
CurrentValue = 5,
Flag = "turboEfficiencyControl",
Callback = function(newTurboEff)
    change_car_settings("T_Efficiency", newTurboEff)
end,})

getgenv().ModifyTurboSize = Tab4:CreateSlider({
Name = "Modify Turbo Size",
Range = {10, 200},
Increment = 5,
Suffix = "",
CurrentValue = 80,
Flag = "turboSizeControl",
Callback = function(newTurboSize)
    change_car_settings("T_Size", newTurboSize)
end,})

getgenv().ModifyWeight = Tab4:CreateSlider({
Name = "Modify Weight",
Range = {1000, 10000},
Increment = 50,
Suffix = " lbs",
CurrentValue = 3000,
Flag = "weightControl",
Callback = function(newWeight)
    change_car_settings("Weight", newWeight)
end,})

getgenv().ModifyWeightScaling = Tab4:CreateSlider({
Name = "Modify Weight Scaling",
Range = {0, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.02,
Flag = "weightScalingControl",
Callback = function(newWeightScale)
    change_car_settings("WeightScaling", newWeightScale)
end,})

getgenv().ModifyFlywheel = Tab4:CreateSlider({
Name = "Modify Flywheel",
Range = {100, 5000},
Increment = 100,
Suffix = "",
CurrentValue = 500,
Flag = "flywheelControl",
Callback = function(newFlywheel)
    change_car_settings("Flywheel", newFlywheel)
end,})

getgenv().ModifyRevAcceleration = Tab4:CreateSlider({
Name = "Modify Rev Acceleration",
Range = {50, 10000},
Increment = 1,
Suffix = "",
CurrentValue = 250,
Flag = "revAccelerationControl",
Callback = function(newRevAccel)
    change_car_settings("RevAccel", newRevAccel)
end,})

getgenv().ModifyRevBounce = Tab4:CreateSlider({
Name = "Modify Rev Bounce",
Range = {100, 5000},
Increment = 100,
Suffix = "",
CurrentValue = 500,
Flag = "revBounceControl",
Callback = function(newRevBounce)
    change_car_settings("RevBounce", newRevBounce)
end,})

getgenv().ModifyThrottleAcceleration = Tab4:CreateSlider({
Name = "Modify Throttle Acceleration",
Range = {0.01, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.05,
Flag = "throttleAccelerationControl",
Callback = function(newThrottleAccel)
    change_car_settings("ThrotAccel", newThrottleAccel)
end,})

getgenv().ModifyThrottleDeceleration = Tab4:CreateSlider({
Name = "Modify Throttle Deceleration",
Range = {0.01, 1},
Increment = 0.01,
Suffix = "",
CurrentValue = 0.2,
Flag = "throttleDecelerationControl",
Callback = function(newThrottleDecel)
    change_car_settings("ThrotDecel", newThrottleDecel)
end,})

getgenv().ModifyInclineCompensation = Tab4:CreateSlider({
Name = "Modify Incline Compensation",
Range = {0.5, 5},
Increment = 0.1,
Suffix = "",
CurrentValue = 1.2,
Flag = "inclineCompControl",
Callback = function(newInclineComp)
    change_car_settings("InclineComp", newInclineComp)
end,})

getgenv().Infinite_Yield_Premium = Tab5:CreateButton({
Name = "Infinite Yield Premium",
Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua', true))()
end,})

getgenv().FOV_Slider = Tab5:CreateSlider({
Name = "Field Of View (FOV)",
Range = {5, 120},
Increment = 1,
Suffix = "",
CurrentValue = 75,
Flag = "theFOVValueEditor",
Callback = function(New_FOV_Value)
    if Workspace then
        Workspace.CurrentCamera.FieldOfView = New_FOV_Value
    end
end,})
wait()
LocalPlayer.CameraMaxZoomDistance = 999999
wait()
getgenv().checkForGui = function()
    local player = LocalPlayer
    local playerGui = PlayerGui

    if not playerGui then
        return
    end

    playerGui.ChildAdded:Connect(function(child)
        if child:IsA("ScreenGui") and child.Name == "FULLSCREEN_GUI" then
            child:Destroy()
        end
    end)

    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") and gui.Name == "FULLSCREEN_GUI" then
            gui:Destroy()
        end
    end
end

getgenv().checkForGui()
