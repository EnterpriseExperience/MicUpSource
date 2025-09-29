getgenv().Game = game
wait()
local function safe_wrapper(S)
    if cloneref then
        return cloneref(game:GetService(S))
    else
        return game:GetService(S)
    end
end

local Players = safe_wrapper("Players")
local TweenService = safe_wrapper("TweenService")
local CoreGui = get_hidden_gui and get_hidden_gui() or gethui and gethui() or safe_wrapper("CoreGui")
local StarterGui = safe_wrapper("StarterGui")
local GuiService = safe_wrapper("GuiService")
local Workspace = safe_wrapper("Workspace")
local UserInputService = safe_wrapper("UserInputService")
local NotificationLibrary_External = loadstring(getgenv().Game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()
local Sound_ID_Windows = "rbxassetid://8183296024"
local Sound_ID_iPhone = "rbxassetid://73722479618078"
local Sound_ID_Android = "rbxassetid://17582299860"
local Sound_ID_Universal = "rbxassetid://18595195017"
local Notification_Wrapper = {}

local function Device_Detector()
    local platform = UserInputService:GetPlatform()
    local platformMap = {
        [Enum.Platform.Windows] = "Windows",
        [Enum.Platform.OSX] = "OSX",
        [Enum.Platform.IOS] = "iOS",
        [Enum.Platform.Android] = "Android",
        [Enum.Platform.XBoxOne] = "Xbox One (Console)",
        [Enum.Platform.PS4] = "PS4 (Console)",
        [Enum.Platform.XBox360] = "Xbox 360 (Console)",
        [Enum.Platform.WiiU] = "Wii-U (Console)",
        [Enum.Platform.NX] = "Cisco Nexus",
        [Enum.Platform.Ouya] = "Ouya (Android-Based)",
        [Enum.Platform.AndroidTV] = "Android TV",
        [Enum.Platform.Chromecast] = "Chromecast",
        [Enum.Platform.Linux] = "Linux (Desktop)",
        [Enum.Platform.SteamOS] = "Steam Client",
        [Enum.Platform.WebOS] = "Web-OS",
        [Enum.Platform.DOS] = "DOS",
        [Enum.Platform.BeOS] = "BeOS",
        [Enum.Platform.UWP] = "UWP (Go Back To Web Bro..)",
        [Enum.Platform.PS5] = "PS5 (Console)",
        [Enum.Platform.MetaOS] = "MetaOS",
        [Enum.Platform.None] = "Unknown Device"
    }
    return platformMap[platform] or "Unknown Device"
end

local devicePlatform = Device_Detector()

function Play_Notification_Sound()
    local Notification_Sound

    Notification_Sound = Instance.new("Sound")
    Notification_Sound.Parent = Workspace
    Notification_Sound.Volume = 1
    if devicePlatform == "Windows" then
        Notification_Sound.SoundId = Sound_ID_Windows
    elseif devicePlatform == "iOS" then
        Notification_Sound.SoundId = Sound_ID_iPhone
    elseif devicePlatform == "Android" then
        Notification_Sound.SoundId = Sound_ID_Android
    else
        Notification_Sound.SoundId = Sound_ID_Universal
    end
    task.wait()
    Notification_Sound:Play()

    Notification_Sound.Ended:Connect(function()
        Notification_Sound:Destroy()
    end)
end

function Notification_Wrapper:External_Notification(Type, Content, Time)
    if not Time then
        Time = 5
    end
    wait()
    Play_Notification_Sound()
    NotificationLibrary_External:SendNotification(tostring(Type), tostring(Content), tonumber(Time))
end

function Notification_Wrapper:GuiService_Notify(title, content)
    Play_Notification_Sound()
    GuiService:SendNotification({
        Title = tostring(title),
        Text = tostring(content),
    })
end

function Notification_Wrapper:StarterGui_Notify(title, content, duration)
    Play_Notification_Sound()
    StarterGui:SetCore("SendNotification", {
        Title = tostring(title);
        Text = tostring(content);
        Duration = tonumber(duration);
        Icon = "rbxassetid://0";
    })
end
wait()
function Notification_Wrapper:Rayfield_Notify(title, content, duration)
    if not getgenv().Rayfield then
        return Notification_Wrapper:External_Notification("Error", "To use this you must be running my Rayfield UI Library, which seems to not have been loaded, if you want to use Rayfield UI Library notifier, load one of my script hubs.", 15)
    end

    if getgenv().Rayfield then
        Play_Notification_Sound()
        getgenv().Rayfield:Notify({
            Title = tostring(title),
            Content = tostring(content),
            Duration = tonumber(duration),
            Image = 93594537601787,
            Actions = {
                Ignore = {
                    Name = "Alright.",
                    Callback = function() 
                        print("...") 
                    end
                },
            },
        })
    else
        return 
    end
end

return Notification_Wrapper
