if not game:IsLoaded() then game.Loaded:Wait() end

if getgenv().ParkourObbyMenuLoaded then
    return 
end

getgenv().ParkourObbyMenuLoaded = true

local g = getgenv() or _G

g.Game = cloneref and cloneref(game) or game

if not getgenv().GlobalEnvironmentFramework_Initialized then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
    wait(0.1)
    getgenv().GlobalEnvironmentFramework_Initialized = true
end

g.get_jobid = function()
    return game.JobId
end

g.get_placeid = function()
    return game.PlaceId
end

local id = g.get_jobid()
local place = g.get_placeid()

g.JobID = id
g.PlaceID = place

g.Service_Wrap = g.Service_Wrap or function(service)
    if cloneref then
        return cloneref(game:GetService(service))
    else
        return game:GetService(service)
    end
end
wait(0.5)
local function init_services()
    local services = {
        "Players",
        "Workspace",
        "Lighting",
        "ReplicatedStorage",
        "TweenService",
        "RunService",
        "MaterialService",
        "ReplicatedFirst",
        "Teams",
        "StarterPack",
        "StarterPlayer",
        "VoiceChatInternal",
        "VoiceChatService",
        "CoreGui",
        "SoundService",
        "StarterGui",
        "MarketplaceService",
        "TeleportService",
        "Chat",
        "AssetService",
        "HttpService",
        "UserInputService",
        "TextChatService",
        "ContextActionService",
        "GuiService",
        "PhysicsService",
        "VRService"
    }

    for _, serviceName in pairs(services) do
        g[serviceName] = cloneref and cloneref(game:GetService(serviceName)) or game:GetService(serviceName)
    end
end

init_services()

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/ParadiseRPScript/refs/heads/main/Turtle_UI_Remake.lua"))()
local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
local Main = lib:Window("Main")
local Parkour_Tab = lib:Window("Parkour")
local Extras = lib:Window("Extras")
local valid_titles = {
    success = "Success",
    info = "Info",
    warning = "Warning",
    error = "Error"
}

local function format_title(str)
    if typeof(str) ~= "string" then
        return "Info"
    end

    local key = str:lower()
    return valid_titles[key] or "Info"
end

getgenv().notify = getgenv().notify or function(title, msg, dur)
    local fixed_title = format_title(title)
    NotifyLib:External_Notification(fixed_title, tostring(msg), tonumber(dur))
end

getgenv().randomString = getgenv().randomString or function()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

local function find_in_localplayer(search_value, search_type)
    local lp = getgenv().LocalPlayer
    if not lp then return nil end

    local containers = { lp }
    if lp:FindFirstChild("PlayerGui") then table.insert(containers, lp.PlayerGui) end
    if lp:FindFirstChild("Backpack") then table.insert(containers, lp.Backpack) end
    if lp.Character then table.insert(containers, lp.Character) end
    if lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid") then
        table.insert(containers, lp.Character)
    end

    search_value = tostring(search_value):lower()
    local exact = nil

    for _, container in ipairs(containers) do
        for _, obj in ipairs(container:GetDescendants()) do
            local name = obj.Name:lower()

            if search_type == "name" then
                if name == search_value then
                    exact = obj
                    break
                end
            elseif search_type == "contains" then
                if name:find(search_value) then
                    return obj
                end
            elseif search_type == "class" then
                if obj.ClassName:lower() == search_value then
                    return obj
                end
            end
        end
        if exact then break end
    end

    if search_type == "name" and not exact then
        for _, container in ipairs(containers) do
            for _, obj in ipairs(container:GetDescendants()) do
                local name = obj.Name:lower()
                if name:find(search_value) then
                    return obj
                end
            end
        end
    end

    return exact
end

local function find_in_place(where_To_search, search_value, search_type)
    local root = where_To_search

    if typeof(root) == "string" then
        local svc = game:GetService(root:gsub("^%l", string.upper))
        if svc then
            root = svc
        else
            root = game:FindFirstChild(root) or getgenv().LocalPlayer
        end
    end

    if not root then
        return nil
    end

    search_value = tostring(search_value):lower()
    local exact = nil

    for _, obj in ipairs(root:GetDescendants()) do
        local name = obj.Name:lower()
        if search_type == "name" then
            if name == search_value then
                exact = obj
                break
            end
        elseif search_type == "contains" then
            if name:find(search_value) then
                return obj
            end
        elseif search_type == "class" then
            if obj.ClassName:lower() == search_value then
                return obj
            end
        end
    end

    if search_type == "name" and not exact then
        for _, obj in ipairs(root:GetDescendants()) do
            local name = obj.Name:lower()
            if name:find(search_value) then
                return obj
            end
        end
    end

    return exact
end

local function get_current_stage()
    local lp = getgenv().LocalPlayer
    if not lp then
        getgenv().notify("Error", "LocalPlayer not found.", 5)
        return nil
    end

    local leaderstats_folder = find_in_localplayer("leaderstats", "name")
    if not leaderstats_folder then
        getgenv().notify("Error", "leaderstats Folder not found in LocalPlayer.", 5)
        return nil
    end

    local stage_val = find_in_localplayer("Stage", "name")
    getgenv().stage_val = stage_val
    if not stage_val then
        getgenv().notify("Error", "Stage Value not found inside leaderstats folder.", 5)
        return nil
    end

    return stage_val.Value
end

local function get_stages_folder_workspace()
    local stages_folder = find_in_place("Workspace", "stages", "contains")

    if stages_folder and stages_folder:IsA("Folder") then
        return stages_folder
    end
end

local HUD_Gui = getgenv().PlayerGui:FindFirstChild("HUD", true)
local MFO_Gui = getgenv().PlayerGui:FindFirstChild("MFO_UI", true)
local Groundbar_Frame
local Prompt_Skip_Frame

for _, v in ipairs(HUD_Gui:GetChildren()) do
    if v:IsA("ImageLabel") then
        local find_name = v.Name:lower()

        if find_name:find("groundbar") or find_name:find("ground") or find_name:find("bar") then
            Groundbar_Frame = v
        end
    end
end

for _, v in ipairs(MFO_Gui:GetChildren()) do
    if v:IsA("ImageLabel") then
        local find_name = v.Name:lower()

        if find_name:find("promptskip") or find_name:find("prompt") or find_name:find("skip") then
            Prompt_Skip_Frame = v
        end
    end
end

function toggle_bottom_frame(state)
    if Groundbar_Frame then
        if state == nil then
            state = true
        end
        Groundbar_Frame.Visible = state
    end
end

function hide_annoying_GUIs(state)
    if state == true then
        if Groundbar_Frame and Groundbar_Frame:IsA("ImageLabel") then
            Groundbar_Frame.Visible = false
        end
        if Prompt_Skip_Frame and Prompt_Skip_Frame:IsA("ImageLabel") then
            Prompt_Skip_Frame.Visible = false
        end
    elseif state == false then
        if Groundbar_Frame and Groundbar_Frame:IsA("ImageLabel") then
            Groundbar_Frame.Visible = true
        end
        if Prompt_Skip_Frame and Prompt_Skip_Frame:IsA("ImageLabel") then
            Prompt_Skip_Frame.Visible = true
        end
    else
        return 
    end
end

local all_stages

local stages_folder = get_stages_folder_workspace()
if stages_folder then
    all_stages = stages_folder
end

getgenv().stage_connection = getgenv().stage_connection or nil
getgenv().CurrentStageValue = getgenv().CurrentStageValue or 0
getgenv().stage_value_object = getgenv().stage_value_object or nil

local function find_stage_object()
    local lp = getgenv().LocalPlayer
    if not lp then return nil end
    local leaderstats = lp:WaitForChild("leaderstats", 10)
    if not leaderstats then return nil end
    local stage_obj = leaderstats:WaitForChild("Stage", 10)
    return stage_obj
end

getgenv().start_stageupdate = function()
    local stage_obj = find_stage_object()
    if not stage_obj then
        return getgenv().notify("Error", "Stage Value not found.", 5)
    end

    getgenv().stage_value_object = stage_obj
    getgenv().CurrentStageValue = tonumber(stage_obj.Value) or 0

    if getgenv().stage_connection then
        pcall(function() getgenv().stage_connection:Disconnect() end)
        getgenv().stage_connection = nil
    end

    getgenv().stage_connection = stage_obj.Changed:Connect(function()
        getgenv().CurrentStageValue = tonumber(stage_obj.Value) or 0
        if getgenv().stage_label then
            getgenv().stage_label:Set("Current Stage: "..tostring(getgenv().CurrentStageValue), Color3.fromRGB(255,255,255))
        end
    end)
end

getgenv().stop_stageupdate = getgenv().stop_stageupdate or function()
    if getgenv().stage_connection then
        pcall(function()
            getgenv().stage_connection:Disconnect()
        end)
        getgenv().stage_connection = nil
    end
end

local function find_killparts_folder()
    local kill_folder = Workspace:FindFirstChild("kill", true) or Workspace:WaitForChild("kill", 10)

    if kill_folder then
        return kill_folder
    else
        getgenv().notify("Error", "Kill Folder not found inside Workspace.", 5)
        return nil
    end
end

getgenv().Toggle_KillParts = getgenv().Toggle_KillParts or function(Toggled)
    if Toggled == true then
        local bricks_folder = find_killparts_folder()

        if bricks_folder and bricks_folder:IsA("Folder") then
            bricks_folder.Parent = VRService
        end
    elseif Toggled == false then
        local bricks_folder_2 = VRService:FindFirstChild("kill", true)

        if bricks_folder_2 and bricks_folder_2:IsA("Folder") then
            bricks_folder_2.Parent = Workspace or workspace
        end
    else
        return 
    end
end

local Prompt_Skip_Annoyance = find_in_localplayer("PromptSkip", "name") or find_in_localplayer("PromptSkip", "contains")

if Prompt_Skip_Annoyance and Prompt_Skip_Annoyance:IsA("ImageLabel") then
    if Prompt_Skip_Annoyance.Visible then
        Prompt_Skip_Annoyance.Visible = false
    end
end

function skip_stage()
    local current_stage_num = tonumber(getgenv().CurrentStageValue)
    local Next_Stage_Part = current_stage_num and all_stages:FindFirstChild(tostring(current_stage_num + 1))

    if current_stage_num and Next_Stage_Part then
        getgenv().HumanoidRootPart.CFrame = Next_Stage_Part.CFrame + Vector3.new(0, 2, 0)
    end
end

function auto_skip_stages(toggle)
    if toggle == true then
        getgenv().auto_skipping_levels = true

        task.spawn(function()
            while getgenv().auto_skipping_levels == true do
            task.wait(0)
                skip_stage()
            end
        end)
    elseif toggle == false then
        getgenv().auto_skipping_levels = false
    else
        return 
    end
end

getgenv().start_stageupdate()

task.wait(0.1)

local stage_label = Parkour_Tab:Label("Current Stage: "..tostring(getgenv().CurrentStageValue), Color3.fromRGB(255,255,255))
getgenv().stage_label = stage_label

local stage_obj = getgenv().stage_value_object
if stage_obj then
    if getgenv().stage_connection then
        pcall(function() getgenv().stage_connection:Disconnect() end)
    end

    getgenv().stage_connection = stage_obj.Changed:Connect(function()
        getgenv().CurrentStageValue = tonumber(stage_obj.Value) or 0
        getgenv().stage_label:Set("Current Stage: "..tostring(getgenv().CurrentStageValue), Color3.fromRGB(255,255,255))
    end)
end

Parkour_Tab:Button("Skip Stage", function()
    skip_stage()
end)

Main:Toggle("Hide Annoying UI", false, function(toggled)
    hide_annoying_GUIs(toggled)
end)

Extras:Toggle("Auto Skip Stages", false, function(toggle)
    if toggle then
        auto_skip_stages(true)
    else
        auto_skip_stages(false)
    end
end)

Extras:Toggle("No KillParts", false, function(state)
    if state then
        getgenv().Toggle_KillParts(true)
    else
        getgenv().Toggle_KillParts(false)
    end
end)
