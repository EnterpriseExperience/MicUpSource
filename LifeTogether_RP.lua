if not game:IsLoaded() then game.Loaded:Wait() end

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
wait(0.1)
NotifyLib:External_Notification("Warning", "This script hub has been deprecated and is no longer available, running the new Admin script.", 30)
loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_RP_Admin.lua'))()
