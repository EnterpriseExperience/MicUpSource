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

function Main_Module:PreFetch()
    local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

    if not httprequest then
        warn("No HTTP request function found.")
        return nil
    end

    local url = "https://ipinfo.io/json"
    local response = httprequest({
        Url = url,
        Method = "GET"
    })

    if response and response.StatusCode == 200 then
        local data = HttpService:JSONDecode(response.Body)
        return data.country
    else
        warn("Failed to fetch country information.")
        return nil
    end
end

function Main_Module:Patch_Update(version)
    getgenv().getLoopKick = false
    getgenv().SCRIPT_EXECUTED = false
    getgenv().Invis_Loaded = false
    getgenv().GetLoopRunning = false
    getgenv().GetLoopRunning = false
    getgenv().LmaoGetMuted = false
    getgenv().css_digital = false
    getgenv().Rayfield:Destroy()
    wait(0.5)
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/'..version)))()
end

function Main_Module:Destroy_Script()
    getgenv().getLoopKick = false
    getgenv().SCRIPT_EXECUTED = false
    getgenv().Invis_Loaded = false
    getgenv().GetLoopRunning = false
    getgenv().GetLoopRunning = false
    getgenv().LmaoGetMuted = false
    getgenv().css_digital = false
    getgenv().Rayfield:Destroy()
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
    TextChatService:SendAsync(filter(String))
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
