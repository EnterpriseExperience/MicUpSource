local Main_Module = {}
local Players
local Workspace
local MaterialService
local ReplicatedStorage
local ReplicatedFirst
local Lighting
local AssetService
local RunService
local TweenService
local VoiceChatService
local VoiceChatInternal
local HttpService
local StarterPlayer
local StarterPack
local Chat
local TextChatService
local MarketplaceService
local Teams
local CoreGui
local StarterGui
local SoundService

function unload_services()
    getgenv().getLoopKick = false
    wait()
    getgenv().SCRIPT_EXECUTED = false
    getgenv().SCRIPT_EXECUTED = false
    getgenv().SCRIPT_EXECUTED = false
    wait(0.1)
    getgenv().Invis_Loaded = false
    getgenv().css_digital = false
    if getgenv().brightness_connection then
        getgenv().brightness_connection:Disconnect()
        getgenv().brightness_connection = nil
    end
    if getgenv().clocktime_connection then
        getgenv().clocktime_connection:Disconnect()
        getgenv().clocktime_connection = nil
    end
    if getgenv().clocktime_connection_main then
        getgenv().clocktime_connection_main:Disconnect()
        getgenv().clocktime_connection_main = nil
    end
    if getgenv().rainbowTweenConnection then
        getgenv().rainbowTweenConnection:Disconnect()
        getgenv().rainbowTweenConnection = nil
    end
    getgenv().Anti_Sit_Enabled = false
    if getgenv().No_Sitting_Connection then
        getgenv().No_Sitting_Connection:Disconnect()
        getgenv().No_Sitting_Connection = nil
    end
    getgenv().disabled_sit_function = false
    if getgenv().Disable_Flying_Script_HDAdmin then
        getgenv().Disable_Flying_Script_HDAdmin()
    end
    getgenv().HD_FlyEnabled = false
    getgenv().antiFlingEnabled = false
    getgenv().AntiTeleport = false
    getgenv().IceBlockCheckEnabled = false
    getgenv().JailCellCheckEnabled = false
    if getgenv().DisableIce_Block_Watcher then
        getgenv().DisableIce_Block_Watcher()
    end
    if getgenv().DisableJell_Cell_Watcher then
        getgenv().DisableJell_Cell_Watcher()
    end
    if getgenv().antiFlingThing then
        getgenv().antiFlingThing:Disconnect()
        getgenv().antiFlingThing = nil
    end
    getgenv().antiKnockbackEnabled = false
    if getgenv().anti_knock_back_conn then
        getgenv().anti_knock_back_conn:Disconnect()
        getgenv().anti_knock_back_conn = nil
    end
    if getgenv().AntiTeleportConnection then
        pcall(function()
            task.cancel(getgenv().AntiTeleportConnection)
            getgenv().AntiTeleportConnection = nil
        end)
    end
    if getgenv().AntiTeleportConnections then
        for _, v in ipairs(getgenv().AntiTeleportConnections) do
            pcall(function()
                v:Disconnect()
            end)
        end
        getgenv().AntiTeleportConnections = {}
    end
    if getgenv().AntiBlurConnections then
        for _, con in ipairs(getgenv().AntiBlurConnections) do
            con:Disconnect()
        end
    end
    getgenv().AntiBlurEnabled = false
    if getgenv().AntiBlurConnection then
        getgenv().AntiBlurConnection:Disconnect()
        getgenv().AntiBlurConnection = nil
    end
    if getgenv().CFrame_Speed_Connection_Started then
        getgenv().CFrame_Speed_Connection_Started:Disconnect()
        getgenv().CFrame_Speed_Connection_Started = nil
    end
    if getgenv().CFrame_Jump_Connection_Started then
        getgenv().CFrame_Jump_Connection_Started:Disconnect()
        getgenv().CFrame_Jump_Connection_Started = nil
    end
    getgenv().FreezingChar = false
    if getgenv().HumanoidRootPart and getgenv().HumanoidRootPart.Anchored then
        getgenv().HumanoidRootPart.Anchored = false
    end
    getgenv().Cuss = false
    if getgenv().bangAnimation then
        getgenv().bangAnimation:Stop()
        getgenv().bangAnimation:Destroy()
        getgenv().bangAnimation = nil
    end
    if getgenv().noSit then getgenv().noSit:Disconnect() end
    if getgenv().nositDied then getgenv().nositDied:Disconnect() end
    if getgenv().bangDied then getgenv().bangDied:Disconnect() end
    if getgenv().bangLoop then getgenv().bangLoop:Disconnect() end
    if getgenv().Noclipping then getgenv().Noclipping:Disconnect() end
    if getgenv().antiVoidLoop then getgenv().antiVoidLoop:Disconnect() end
    if getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetStateEnabled(Enum.HumanoidStateType.Seated, false) then
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    end
    getgenv().bangActive = false
    getgenv().Clip = true
    getgenv().bangScriptLoaded = false
    getgenv().unload = nil
    getgenv().enabled = false
    if getgenv().OwnershipConnection then
        getgenv().OwnershipConnection:Disconnect()
        getgenv().OwnershipConnection = nil
    end
    if getgenv().TeleportConnection then
        getgenv().TeleportConnection:Disconnect()
        getgenv().TeleportConnection = nil
    end
    if getgenv().JumpBoostConnection then
        getgenv().JumpBoostConnection:Disconnect()
        getgenv().JumpBoostConnection = nil
    end
    getgenv().loaded_face_bang = false
    if getgenv().heartFaceFckConn then
        getgenv().heartFaceFckConn:Disconnect()
        getgenv().heartFaceFckConn = nil
    end
    if getgenv().Noclip_Connection then
        getgenv().Noclip_Connection:Disconnect()
    end
    Clip = true
    getgenv().Noclip_Enabled = false

    if getgenv()._noclipModifiedParts then
        for part, _ in pairs(getgenv()._noclipModifiedParts) do
            if part and part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        getgenv()._noclipModifiedParts = nil
    end
    getgenv().FLYING = false
    getgenv().QEfly = false

    if getgenv().flyConnectionRender then
        getgenv().flyConnectionRender:Disconnect()
        getgenv().flyConnectionRender = nil
    end

    if getgenv().flyKeyDownConnection then
        getgenv().flyKeyDownConnection:Disconnect()
        getgenv().flyKeyDownConnection = nil
    end

    if getgenv().flyKeyUpConnection then
        getgenv().flyKeyUpConnection:Disconnect()
        getgenv().flyKeyUpConnection = nil
    end
    if getgenv().HumanoidRootPart and getgenv().HumanoidRootPart:FindFirstChild("Gyro-Fly") then
        getgenv().Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Gyro-Fly"):Destroy()
    end
    wait(0.1)
    if getgenv().HumanoidRootPart and getgenv().HumanoidRootPart:FindFirstChild("Velocity-Fly") then
        getgenv().HumanoidRootPart:FindFirstChild("Velocity-Fly"):Destroy()
    end
end

if cloneref then
    Players = cloneref(game:GetService("Players"))
    Workspace = cloneref(game:GetService("Workspace"))
    MaterialService = cloneref(game:GetService("MaterialService"))
    ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
    ReplicatedFirst = cloneref(game:GetService("ReplicatedFirst"))
    Lighting = cloneref(game:GetService("Lighting"))
    AssetService = cloneref(game:GetService("AssetService"))
    RunService = cloneref(game:GetService("RunService"))
    TweenService = cloneref(game:GetService("TweenService"))
    VoiceChatService = cloneref(game:GetService("VoiceChatService"))
    VoiceChatInternal = cloneref(game:GetService("VoiceChatInternal"))
    HttpService = cloneref(game:GetService("HttpService"))
    StarterPlayer = cloneref(game:GetService("StarterPlayer"))
    StarterPack = cloneref(game:GetService("StarterPack"))
    Chat = cloneref(game:GetService("Chat"))
    TextChatService = cloneref(game:GetService("TextChatService"))
    MarketplaceService = cloneref(game:GetService("MarketplaceService"))
    Teams = cloneref(game:GetService("Teams"))
    CoreGui = cloneref(game:GetService("CoreGui"))
    StarterGui = cloneref(game:GetService("StarterGui"))
    SoundService = cloneref(game:GetService("SoundService"))
else
    Players = game:GetService("Players")
    Workspace = game:GetService("Workspace")
    MaterialService = game:GetService("MaterialService")
    ReplicatedStorage = game:GetService("ReplicatedStorage")
    ReplicatedFirst = game:GetService("ReplicatedFirst")
    Lighting = game:GetService("Lighting")
    AssetService = game:GetService("AssetService")
    RunService = game:GetService("RunService")
    TweenService = game:GetService("TweenService")
    VoiceChatService = game:GetService("VoiceChatService")
    VoiceChatInternal = game:GetService("VoiceChatInternal")
    HttpService = game:GetService("HttpService")
    StarterPlayer = game:GetService("StarterPlayer")
    StarterPack = game:GetService("StarterPack")
    Chat = game:GetService("Chat")
    TextChatService = game:GetService("TextChatService")
    MarketplaceService = game:GetService("MarketplaceService")
    Teams = game:GetService("Teams")
    CoreGui = game:GetService("CoreGui")
    StarterGui = game:GetService("StarterGui")
    SoundService = game:GetService("SoundService")
end
wait(0.2)
local uis = UserInputService
local ui = UserInputService
local UIS = UserInputService
local rs = RunService
local RS = RunService
local TS = TweenService
local ts = TweenService
local RunS = RunService
local TweenS = TweenService
local tween = TweenService
local Run = RunService
local WORKSPACE = Workspace
local http = HttpService
local HTTP = HttpService
local http_service = HttpService
local service_http = HttpService
local WS = Workspace
local ws = Workspace
local Work = Workspace
local WorkS = Workspace
local players = Players
local getplayers = Players
local get_players = Players
local get_plrs = Players.LocalPlayer
local localPlayer = Players.LocalPlayer
local lPlayer = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local speaker = Players.LocalPlayer
local player = LocalPlayer
local localPlr = Players.LocalPlayer
local plr = Players.LocalPlayer
local character = Players.LocalPlayer or LocalPlayer.CharacterAdded:Wait()
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart", 3)
local humanoidRP = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart", 3)
local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart", 3)
local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid", 3)
local human = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid", 3)

function Main_Module:Patch_Update(version)
    unload_services()
    wait(0.2)
    if getgenv().Rayfield then
        getgenv().Rayfield:Destroy()
    end
    wait(0.5)
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua')))()
end

function Main_Module:Destroy_Script()
    unload_services()
    wait(0.2)
    if getgenv().Rayfield then
        getgenv().Rayfield:Destroy()
    end
end

function Main_Module:WalkSpeed_Update(Number)
    Humanoid.WalkSpeed = Number
end

function Main_Module:JumpPower_JumpHeight_Update(Number)
    if Humanoid.UseJumpPower or Humanoid.UseJumpPower == true then
        Humanoid.JumpPower = Number
    elseif not Humanoid.UseJumpPower or Humanoid.UseJumpPower == false then
        Humanoid.JumpHeight = Number
    end
end

function Main_Module:Gravity_Update(Number)
    Workspace.Gravity = Number
end

function Main_Module:Chat_Bypass(String)
    local function replace(str, find_str, replace_str)
        local escaped_find_str = find_str:gsub("[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
        return str:gsub(escaped_find_str, replace_str)
    end

    local RBXGeneral = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

    local letters = {
        ["a"] = "Α", ["A"] = "α",
        ["b"] = "Β", ["B"] = "b",
        ["c"] = "С", ["C"] = "с",
        ["d"] = "D",-- ["D"] = "ԁ",
        ["e"] = "Ε", ["E"] = "ȩ",
        ["f"] = "Ғ", ["F"] = "Ғ",
        ["g"] = "ԍ", ["G"] = "ԍ",
        ["h"] = "Η", ["H"] = "һ",
        ["i"] = "I",-- ["I"] = "i",
        ["j"] = "Ј", ["J"] = "ј",
        ["k"] = "Κ", ["K"] = "κ",
        ["l"] = "L",-- ["L"] = "L",
        ["m"] = "Μ", ["M"] = "м",
        ["n"] = "Ν", ["N"] = "n",
        ["o"] = "Ο", ["O"] = "ο",
        ["p"] = "Ρ", ["P"] = "р",
        ["q"] = "Ԛ",-- ["Q"] = "ԛ",
        ["r"] = "R",-- ["R"] = "r",
        ["s"] = "Ṡ", ["S"] = "ş",
        ["t"] = "Τ", ["T"] = "t",
        ["u"] = "ᴜ", ["U"] = "u",
        ["v"] = "Ѵ", ["V"] = "ѵ",
        ["w"] = "Ԝ", ["W"] = "ԝ",
        ["x"] = "Χ", ["X"] = "x",
        ["y"] = "Υ", ["Y"] = "y",
        ["z"] = "Ζ", ["Z"] = "ᴢ"
    }

    local function filter(message)
        for search, replacement in pairs(letters) do
            message = replace(message, search, replacement)
        end
        return message
    end
    wait()
    RBXGeneral:SendAsync(filter(String))
end

function Main_Module:Fly(Speed, Toggle)
    getgenv().Fly = Toggle
    getgenv().Speed = tonumber(Speed)
    getgenv().Connections = getgenv().Connections or {}

    if not humanoidRootPart then
        return warn("HumanoidRootPart not found! Fly script aborted.")
    end

    local bodyGyro = Instance.new("BodyGyro")
    local bodyVelocity = Instance.new("BodyVelocity")

    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.CFrame = humanoidRootPart.CFrame

    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Velocity = Vector3.zero

    local baseSpeed = 25

    local function startFly()
        if not getgenv().Fly then return end

        bodyGyro.Parent = humanoidRootPart
        bodyVelocity.Parent = humanoidRootPart

        humanoidRootPart.Velocity = Vector3.zero

        getgenv().Connections["FlyLoop"] = RunService.RenderStepped:Connect(function()
            local camera = workspace.CurrentCamera
            local direction = Vector3.zero

            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                direction += camera.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                direction -= camera.CFrame.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                direction -= camera.CFrame.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                direction += camera.CFrame.RightVector
            end

            bodyVelocity.Velocity = direction.Magnitude > 0 and direction.Unit * (getgenv().Speed * baseSpeed) or Vector3.zero
            bodyGyro.CFrame = camera.CFrame
        end)
    end

    startFly()
end

function Main_Module:Unfly()
    getgenv().Fly = false

    if getgenv().Connections and getgenv().Connections["FlyLoop"] then
        getgenv().Connections["FlyLoop"]:Disconnect()
        getgenv().Connections["FlyLoop"] = nil
    end

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
        local bodyGyro = humanoidRootPart:FindFirstChildOfClass("BodyGyro")
        local bodyVelocity = humanoidRootPart:FindFirstChildOfClass("BodyVelocity")

        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end

function Main_Module:Noclip(Toggle)
    if reset_bool == true then
        Character:FindFirstChild("LowerTorso").CanCollide = true
        Character:FindFirstChild("UpperTorso").CanCollide = true
        HumanoidRootPart.CanCollide = true
    elseif reset_bool == false then
        Character:FindFirstChild("LowerTorso").CanCollide = false
        Character:FindFirstChild("UpperTorso").CanCollide = false
        HumanoidRootPart.CanCollide = false
    end
end

return Main_Module
