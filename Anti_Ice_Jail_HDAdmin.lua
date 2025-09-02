if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Flames_API = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua'))()
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local TeleportService = cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local StarterGui = Flames_API.Service("StarterGui")
local LocalPlayer = Players.LocalPlayer
function notify(title, msg, duration)
     StarterGui:SetCore("SendNotification", {
        Title = tostring(title);
        Text = tostring(msg);
        Duration = tonumber(duration);
        Icon = "rbxassetid://0";
     })
end
wait(0.1)
getgenv().notify = notify

local function Rejoin()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end

LocalPlayer.OnTeleport:Connect(function(State)
    if getgenv().queueteleport then
        if not getgenv().Anti_Ice_Jail_AutoRun then
            getgenv().Anti_Ice_Jail_AutoRun = true
            queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Anti_Ice_Jail_HDAdmin.lua'))()")
        end
    else
        return getgenv().notify("Failure:", "Your executor does not support 'queueteleport'!", 5)
    end
end)

local JailCellConnection
getgenv().JailCellCheckEnabled = false
local function EnableJailCellWatcher()
    if JailCellConnection then return end
    getgenv().JailCellCheckEnabled = true

    JailCellConnection = workspace.DescendantAdded:Connect(function(descendant)
        if getgenv().JailCellCheckEnabled and descendant:IsA("Model") and descendant.Name == LocalPlayer.Name.."'s JailCell" then
            Rejoin()
        end
    end)
end

local IceBlockConnection
local FreezeCheckConnection
getgenv().IceBlockCheckEnabled = false
local function EnableIceWatcher()
    if IceBlockConnection or FreezeCheckConnection then return end
    getgenv().IceBlockCheckEnabled = true

    IceBlockConnection = workspace.DescendantAdded:Connect(function(descendant)
        if getgenv().IceBlockCheckEnabled and descendant:IsA("Part") and descendant.Name == LocalPlayer.Name.."'s FreezeBlock" then
            Rejoin()
        end
    end)

    FreezeCheckConnection = RunService.Heartbeat:Connect(function()
        if getgenv().IceBlockCheckEnabled then
            local character = Flames_API.Character
            if character and IsFullyFrozen and IsFullyFrozen() then
                Rejoin()
            end
        end
    end)
end

EnableJailCellWatcher()
EnableIceWatcher()
