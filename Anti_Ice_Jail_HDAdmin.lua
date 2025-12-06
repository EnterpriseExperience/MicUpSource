if not game:IsLoaded() then game.Loaded:Wait() end

local Flames_API = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua'))()
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local TeleportService = cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local UIS = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

function notify(title,msg,dur)
    Flames_API.notify(tostring(title),tostring(msg),tonumber(dur))
end

getgenv().notify = getgenv().notify or notify
getgenv().AntiIceJailEnabled = true
if getgenv().notify then
    getgenv().notify("Success", "Loaded Anti-Ice/Anti-Jail HD Admin script, press R to toggle.", 15)
end

local function dorejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId,LocalPlayer)
end

local JailCellConnection
local IceBlockConnection
local FreezeCheckConnection

local function startwatchers()
    if JailCellConnection then JailCellConnection:Disconnect() end
    if IceBlockConnection then IceBlockConnection:Disconnect() end
    if FreezeCheckConnection then FreezeCheckConnection:Disconnect() end

    JailCellConnection = workspace.DescendantAdded:Connect(function(d)
        if getgenv().AntiIceJailEnabled and d:IsA("Model") and d.Name == LocalPlayer.Name.."'s JailCell" then
            dorejoin()
        end
    end)

    IceBlockConnection = workspace.DescendantAdded:Connect(function(d)
        if getgenv().AntiIceJailEnabled and d:IsA("Part") and d.Name == LocalPlayer.Name.."'s FreezeBlock" then
            dorejoin()
        end
    end)

    FreezeCheckConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().AntiIceJailEnabled then return end
        local c = LocalPlayer.Character
        if c and IsFullyFrozen and IsFullyFrozen() then
            dorejoin()
        end
    end)
end

startwatchers()

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.R then
        getgenv().AntiIceJailEnabled = not getgenv().AntiIceJailEnabled
        if getgenv().AntiIceJailEnabled then
            getgenv().notify("Anti-Ice/Jail","Enabled",4)
            startwatchers()
        else
            getgenv().notify("Anti-Ice/Jail","Disabled",4)
        end
    end
end)

if queue_on_teleport then
    queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Anti_Ice_Jail_HDAdmin.lua'))()")
end
