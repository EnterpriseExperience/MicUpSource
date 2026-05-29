if not game:IsLoaded() then game.Loaded:Wait() end
local g = getgenv()
local scriptstoload = {
    ["Tower Of Misery"] = {
        id = 4954752502,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Tower_Of_Misery_ScriptHub.lua"
    },
    ["Ultimate Driving"] = {
        id = 54865335,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Ultimate_Driving.lua"
    },
    ["LifeTogether RP"] = { -- bora bora & ski resort.
        id = {13967668166, 99644611200703, 99154507657228},
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Life_Together_Admin.lua"
    },
    ["Hide And Seek Extreme"] = {
        id = 205224386,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Hide_And_Seek_Extreme.lua"
    },
    ["Apartment Hangout Spot"] = {
        id = 108873247414429,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Apartment_Hangout_Script_Hub.lua"
    },
    ["The Lanes"] = {
        id = 1333478699,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/The_Lanes.lua"
    },
    ["Player or AI"] = {
        id = 95217169945642,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Player_Or_AI.lua"
    },
    ["Main Street RP"] = {
        id = 18753889337,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Main_Street_RP.lua"
    },
    ["Southwest Florida Beta"] = {
        id = 5104202731,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Southwest_Florida_BETA.lua"
    },
    ["Driving Empire"] = {
        id = 3351674303,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Driving_Empire.lua"
    },
    ["Berry Avenue RP"] = {
        id = 8481844229,
        link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Berry_Ave_Admin.lua"
    },
    ["Mega Fun Obby"] = {
        id = 12996397,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Mega_Fun_Obby.lua"
    },
    ["Catalog Avatar Creator"] = {
        id = 7041939546,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/CatalogAvatarCreator.lua"
    },
    ["Tower Of Hell"] = {
        id = 1962086868,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Tower_Of_Hell_Script_Hub.lua"
    },
    ["Car Driving Ultimate"] = {
        id = 11145865512,
        link = "https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Car_Driving_Ultimate.lua"
    }
}

g.Game = cloneref and cloneref(game) or game
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Notify_Lib.lua"))()
wait(0.2)
g.notify = g.notify or function(notif_type, msg, duration)
    NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration))
end

local function matcheswhat(tpplaces, togo)
    if typeof(tpplaces) == "number" then
        return tpplaces == togo
    elseif typeof(tpplaces) == "table" then
        for _, id in ipairs(tpplaces) do
            if id == togo then
                return true
            end
        end
    end
    return false
end

local function load_str(url)
    if not url then return end
    if typeof(url) ~= "string" then return end

    loadstring(game:HttpGet(url))()
end
wait(0.1)
for name, all_scripts in pairs(scriptstoload) do
    if matcheswhat(all_scripts.id, game.PlaceId) then
        if matcheswhat(scriptstoload["LifeTogether RP"].id, game.PlaceId) then
            if not getgenv().LifeTogetherRP_Admin then
                return load_str(scriptstoload["LifeTogether RP"].link)
            else
                return getgenv().notify("Warning", "You have already loaded the Life Together script.", 10)
            end
        end

        load_str(all_scripts.link)
        return
    end
end

local rf = loadstring(game:HttpGet("https://raw.githubusercontent.com/dudeididntliterally/Backup_Repo/refs/heads/main/Rayfield_UI.lua"))()
local window = rf:CreateWindow({
    Name = "Flames Hub | 🏠 Script Hub Loader 🏠",
    LoadingTitle = "Welcome, "..tostring(game.Players.LocalPlayer),
    LoadingSubtitle = "...",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "ScriptHub-Config",
        FileName = "ScriptHubLoader_Hub"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "cmon mane...",
        Subtitle = "nah, no key system.",
        Note = "ok?",
        FileName = "hey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {""}
    }
})
wait(0.1)
g.Buttons = g.Buttons or {}
local Tab1 = window:CreateTab("🏡 Scripts 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Scripts Section 🏡 |")
local Tab2 = window:CreateTab("🎮 Game TPs 🎮", 0)
local Section2 = Tab2:CreateSection("| 🎮 Scripts Section 🎮 |")
wait(0.2)
getgenv().FlamesHubUniversal = Tab1:CreateButton({
Name = "Flames Hub (Universal)",
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua"))()
end,})

getgenv().FlamesHubUniversal = Tab1:CreateButton({
Name = "Condo Games Destroyer",
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/CondoGamesRuiner.lua"))()
end,})

for name, dude in pairs(scriptstoload) do
    local strname = name:gsub("%W", "_")

    getgenv().Buttons[strname] = Tab1:CreateButton({
    Name = name,
    Callback = function()
        if not dude.id or not dude.link then
            return 
        end

        if game.PlaceId == dude.id then
            loadstring(game:HttpGet(dude.link))
        else
            return 
        end
    end,})
end

for name, schnawg in pairs(scriptstoload) do
    if name ~= "LifeTogether Admin Commands (FE)" then
        getgenv()[name] = Tab2:CreateButton({
        Name = "TP to game: "..name,
        Callback = function()
            local idkok = type(schnawg.id) == "table" and schnawg.id[1] or schnawg.id
            if not idkok then return end

            local function funcok()
                if type(schnawg.id) == "number" then
                    return game.PlaceId == schnawg.id
                end
                for _, v in ipairs(schnawg.id) do
                    if game.PlaceId == v then
                        return true
                    end
                end
                return false
            end

            if funcok() then
                return 
            end

            game.TeleportService:Teleport(idkok, game.Players.LocalPlayer)
        end,})
    end
end
