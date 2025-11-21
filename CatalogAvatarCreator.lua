if not game:IsLoaded() then game.Loaded:Wait() end

if getgenv().CatalogAvatarCreator_Script_Menu_Loaded then
    return 
end

getgenv().CatalogAvatarCreator_Script_Menu_Loaded = true

local function service_wrap(s)
    if cloneref then
        return cloneref(game:GetService(s))
    else
        return game:GetService(s)
    end
end
repeat task.wait() until service_wrap
local MarketplaceService = service_wrap("MarketplaceService")
local game_name = MarketplaceService:GetProductInfo(game.PlaceId).Name
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/cerberus.lua"))()
local Window = Library.new(tostring(game_name))
local HomeTab = Window:Tab("Home")
local AvatarSection = HomeTab:Section("Character")
local PlayersSection = HomeTab:Section("Players")
local PrivServerSection = HomeTab:Section("Private Server")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local get_conns = getconnections or get_signal_cons or blankfunction
local LogService = cloneref and cloneref(game:GetService("LogService")) or game:GetService("LogService")
getgenv().logging_disabled = getgenv().logging_disabled or false
getgenv().disabled_conns = getgenv().disabled_conns or {}
wait(0.2)
getgenv().toggle_logging = function(state)
    if state then
        getgenv().logging_disabled = true
        for _, conn in next, get_conns(LogService.MessageOut) do
            if conn then
                table.insert(getgenv().disabled_conns, conn)
                conn:Disable()
            end
        end
    else
        for _, conn in next, getgenv().disabled_conns do
            if conn.Enable then
                conn:Enable()
            end
        end
        getgenv().logging_disabled = false
        getgenv().disabled_conns = {}
    end
end
wait(0.2)
getgenv().toggle_logging(true)
-- saving for later --
-- local title = section:Title("Character") --
-- title:ChangeText("Title") --
local cmdp = service_wrap("Players")
local cmdlp = cmdp.LocalPlayer
local Players = service_wrap("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = service_wrap("ReplicatedStorage")
wait(0.2)
if not getgenv().findplr then
    getgenv().findplr = function(args)
        local tbl = cmdp:GetPlayers()

        if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName or args == cmdlp then
            return 
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
                if v ~= cmdlp and v.Character and (v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair")) then
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
                if v ~= cmdlp then
                    local vRootPart = get_root(v)
                    local cmdlpRootPart = get_root(cmdlp)
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
                if v ~= cmdlp then
                    local vRootPart = get_root(v)
                    local cmdlpRootPart = get_root(cmdlp)
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

        if typeof(args) ~= "string" or args == "" then
            return nil
        end

        for _, v in pairs(tbl) do
            if v ~= cmdlp then
                local name, display = v.Name:lower(), v.DisplayName:lower()
                if name:find(args:lower()) or display:find(args:lower()) then
                    return v
                end
            end
        end
    end
end

local colors = {
    red = Color3.new(1,0,0),
    green = Color3.new(0,1,0),
    blue = Color3.new(0,0,1),
    black = Color3.new(0,0,0),
    white = Color3.new(1,1,1),
    gray = Color3.new(0.5,0.5,0.5),
    lightgray = Color3.new(0.8,0.8,0.8),
    darkgray = Color3.new(0.2,0.2,0.2),
    yellow = Color3.new(1,1,0),
    orange = Color3.new(1,0.5,0),
    brown = Color3.new(0.4,0.26,0.13),
    purple = Color3.new(0.5,0,0.8),
    pink = Color3.new(1,0.4,0.7),
    cyan = Color3.new(0,1,1),
    lime = Color3.new(0.6,1,0),
    gold = Color3.new(1,0.85,0.2),
    toothpaste = Color3.new(0.27,1,0.78),
    magenta = Color3.new(1,0,1),
    indigo = Color3.new(0.29,0,0.51),
    violet = Color3.new(0.56,0,1),
    tan = Color3.new(0.82,0.71,0.55)
}
wait(0.2)
local Popup_Message = ReplicatedStorage:FindFirstChild("ClientPopupMessage", true)
local Catalog_Remote = ReplicatedStorage:FindFirstChild("CatalogGuiRemote", true)
local Remote = Catalog_Remote
local Settings_RF = ReplicatedStorage:FindFirstChild("SettingsRemoteFunction")
local Events_Folder = ReplicatedStorage:FindFirstChild("Events", true)
local Upd_Plr_Status = Events_Folder:FindFirstChild("UpdatePlayerStatus", true)
local g = getgenv()
wait(0.3)
function ingame_notify(title, message, colorName, dur)
    if Popup_Message:IsA("BindableEvent") then
        colorName = tostring(colorName or "green"):lower()
        local colors = {
            green  = "#00ff00",
            red = "#ff0000",
            blue = "#00aaff",
            yellow = "#ffff00",
            orange = "#ffa500",
            purple = "#a020f0",
            pink = "#ff69b4",
            white = "#ffffff",
            gray = "#cccccc"
        }
        local color = colors[colorName] or "#ffffff"
        title = tostring(title or "Notice")
        message = tostring(message or "")
        dur = tonumber(dur or 5)
        local formatted = string.format(
            "<font color=\"%s\">[%s]:</font> %s",
            color,
            title,
            message
        )

        Popup_Message:Fire(formatted, dur)
    end
end

function change_displayname(setting, new_val)
    local ohTable1 = {
        ["Action"] = setting,
        ["DisplayName"] = new_val
    }

    Settings_RF:InvokeServer(ohTable1)
end

local function wait_for_datamodel(inst)
    if not inst then return false end

    local attempts = 0
    while attempts < 100 do
        if inst.Parent and inst:IsDescendantOf(workspace) then
            return true
        end
        task.wait(0.05)
        attempts += 1
    end

    return false
end

local function wait_for_child_safe(parent, name)
    local ok, obj = pcall(function() return parent:WaitForChild(name) end)
    return ok and obj
end

local function retry_find(func, retries, delay)
    for _ = 1, retries do
        local result = func()
        if result then return result end
        task.wait(delay)
    end
    return nil
end

g.get_char = g.get_char or function(Player)
    if not Player or not Player:IsA("Player") then
        ingame_notify("error", "player don't exist: "..tostring(player), "red", 5)
        return nil
    end
    local char = Player.Character
    local attempts = 0
    while (not char or not char.Parent) and attempts < 200 do
        char = Player.Character
        task.wait(0.05)
        attempts += 1
    end
    return char
end

g.get_human = g.get_human or function(Player)
    local char = g.get_char(Player)
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local attempts = 0
    while not hum and attempts < 200 do
        hum = char:FindFirstChildOfClass("Humanoid")
        task.wait(0.05)
        attempts += 1
    end
    return hum
end

g.get_root = g.get_root or function(Player)
    local char = g.get_char(Player)
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart") 
        or char:FindFirstChild("Torso") 
        or char:FindFirstChild("UpperTorso")
    local attempts = 0
    while not root and attempts < 200 do
        root = char:FindFirstChild("HumanoidRootPart") 
            or char:FindFirstChild("Torso") 
            or char:FindFirstChild("UpperTorso")
        task.wait(0.05)
        attempts += 1
    end
    return root
end

g.get_head = g.get_head or function(Player)
    local char = g.get_char(Player)
    if not char then return nil end
    local head = char:FindFirstChild("Head")
    local attempts = 0
    while not head and attempts < 200 do
        head = char:FindFirstChild("Head")
        task.wait(0.05)
        attempts += 1
    end
    return head
end
wait(0.2)
function copy_avatar(player)
    local char = get_char(player)
    local hum = get_human(player)

    if not getgenv().AnimSlots then
        getgenv().AnimSlots = {
            Idle = "IdleAnimation",
            Walk = "WalkAnimation",
            Run = "RunAnimation",
            Jump = "JumpAnimation",
            Fall = "FallAnimation",
            Climb = "ClimbAnimation",
            Swim = "SwimAnimation"
        }
    end

    ingame_notify("success", "copying: "..tostring(player).."'s avatar.", "green", 5)

    local function Wear(id, prop)
        Remote:InvokeServer({Action="TryItem",Id=id,PropertyName=prop})
    end

    local function TakeOff(id)
        Remote:InvokeServer({Action="TakeOffItem",Id=id})
    end

    local function ApplyRig(rig)
        Remote:InvokeServer({Action="ChangeRig",RigType=rig})
    end

    local function ApplyScales(tbl)
        Remote:InvokeServer({Action="UpdateHumanDescProperties",Properties=tbl})
    end

    local function ApplySkin(bc)
        Remote:InvokeServer({
            Action = "UpdateHumanDescProperties",
            Properties = {
                HeadColor = bc.HeadColor3,
                TorsoColor = bc.TorsoColor3,
                LeftArmColor = bc.LeftArmColor3,
                RightArmColor = bc.RightArmColor3,
                LeftLegColor = bc.LeftLegColor3,
                RightLegColor = bc.RightLegColor3,
            }
        })
    end

    local function Clear(desc)
        for _,acc in ipairs(desc:GetAccessories(true)) do
            TakeOff(acc.AssetId)
            task.wait(0.1)
        end
        for _,part in ipairs({"Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg","Face","Shirt","Pants","GraphicTShirt"}) do
            local id = desc[part]
            if typeof(id)=="number" and id>0 then
                TakeOff(id)
                task.wait(0.1)
            end
        end
        for _,slot in pairs(getgenv().AnimSlots) do
            TakeOff(0)
            task.wait(0.1)
        end
        ApplyScales({
            BodyTypeScale=1,
            DepthScale=1,
            HeadScale=1,
            HeightScale=1,
            WidthScale=1,
            ProportionScale=1
        })
    end

    local targetHum = hum
    if not targetHum then return end
    local targetDesc = targetHum:GetAppliedDescription()
    if not targetDesc then return end

    local myHum = get_human(Players.LocalPlayer)
    if not myHum then return end
    local myDesc = myHum:GetAppliedDescription()

    if targetHum.RigType == Enum.HumanoidRigType.R6 then
        ApplyRig(Enum.HumanoidRigType.R6)
    else
        ApplyRig(Enum.HumanoidRigType.R15)
    end
    task.wait(0.2)
    Clear(myDesc)
    task.wait(1)
    for _,part in ipairs({"Head","Torso","LeftArm","RightArm","LeftLeg","RightLeg","Face","Shirt","Pants","GraphicTShirt"}) do
        local id = targetDesc[part]
        if typeof(id)=="number" and id>0 then
            Wear(id,part)
            task.wait(0.1)
        end
    end

    for _,acc in ipairs(targetDesc:GetAccessories(true)) do
        Wear(acc.AssetId,acc.AccessoryType.Name.."Accessory")
        task.wait(0.1)
    end

    if targetHum.RigType == Enum.HumanoidRigType.R15 then
        for _,slot in pairs(getgenv().AnimSlots) do
            local id = targetDesc[slot]
            if id and id>0 then
                Wear(id,slot)
                task.wait(0.1)
            end
        end
    end

    ApplyScales({
        BodyTypeScale = targetDesc.BodyTypeScale or 1,
        DepthScale = targetDesc.DepthScale or 1,
        HeadScale = targetDesc.HeadScale or 1,
        HeightScale = targetDesc.HeightScale or 1,
        WidthScale = targetDesc.WidthScale or 1,
        ProportionScale = targetDesc.ProportionScale or 1
    })

    local bc = char:FindFirstChildOfClass("BodyColors")
    if bc then
        ApplySkin(bc)
    end
end

function make_avatar(targetPlayer, rig_type)
    local userId
    
    if typeof(targetPlayer) == "Instance" and targetPlayer:IsA("Player") then
        userId = targetPlayer.UserId
    else
        userId = tonumber(targetPlayer)
    end

    if not userId then
        return ingame_notify("error", "invalid userId", "red", 10)
    end

    local rig = string.lower(rig_type or "")
    local humanoidRig

    if rig == "r6" then
        humanoidRig = Enum.HumanoidRigType.R6
    elseif rig == "r15" then
        humanoidRig = Enum.HumanoidRigType.R15
    else
        return ingame_notify("error", "provide a valid rigtype lil bro.", "red", 10)
    end

    local data = {
        Action = "MorphIntoPlayer",
        UserId = userId,
        RigType = humanoidRig
    }

    Catalog_Remote:InvokeServer(data)
end

local function rig_to_string(hum)
    if not hum then return nil end
    return hum.RigType == Enum.HumanoidRigType.R6 and "r6" or "r15"
end

function name_changer_premium(toggle)
    local words = {
        "root_access",
        "packet_inject",
        "xor_key",
        "decrypting",
        "init_stealth",
        "spoof_id",
        "kernel_hook",
        "bruteforce",
        "sys_reboot",
        "net_breach",
        "ghost_mode",
        "backdoor_init"
    }

    local index = 1
    local wordCount = #words

    if toggle == true then
        getgenv().name_flasher_premium = true

        task.spawn(function()
            while getgenv().name_flasher_premium == true do
                task.wait(0)
                change_displayname("SetDisplayName", words[index])

                index += 1
                if index > wordCount then
                    index = 1
                end
            end
        end)
    elseif toggle == false then
        getgenv().name_flasher_premium = false
    end
end

function flash_name_title(toggle)
    if toggle == true then
        local titles = {
            "[AFK]",
        }

        getgenv().updating_status_title = true
        while getgenv().updating_status_title == true do
        task.wait()
            for _, status in ipairs(titles) do
                task.wait(0)
                Upd_Plr_Status:FireServer(status)
            end
        end
    elseif toggle == false then
        getgenv().updating_status_title = false
    else
        return 
    end
end

function vip_server_notif_spam(toggle)
    local ohTable1 = {
        ["Action"] = "ToggleGearsEnabled",
        ["Enabled"] = true
    }
    local ohTable2 = {
        ["Action"] = "ToggleGearsEnabled",
        ["Enabled"] = false
    }

    if toggle == true then
        getgenv().settings_spam = true
        while getgenv().settings_spam == true do
        task.wait()
            Settings_RF:InvokeServer(ohTable1)
            task.wait(0)
            Settings_RF:InvokeServer(ohTable2)
        end
    elseif toggle == false then
        getgenv().settings_spam = false
    else
        return 
    end
end

getgenv().saved_colors = getgenv().saved_colors or {}
local function is_r15(hum)
   return hum and hum.RigType == Enum.HumanoidRigType.R15
end
local function is_r6(hum)
   return hum and hum.RigType == Enum.HumanoidRigType.R6
end

local function save_skin()
    local LP = Players.LocalPlayer

    local hum = get_human(LP)
    if not hum then
        return false, nil
    end

    local char = get_char(LP)
    if not char then
        return false, hum.RigType
    end

    local bc = char:FindFirstChildOfClass("BodyColors")
    if not bc then
        return false, rig
    end

    if next(getgenv().saved_colors) ~= nil then
        for k in next, getgenv().saved_colors do
            getgenv().saved_colors[k] = nil
        end
    end

    getgenv().saved_colors.HeadColor3 = bc.HeadColor3
    getgenv().saved_colors.LeftArmColor3 = bc.LeftArmColor3
    getgenv().saved_colors.RightArmColor3 = bc.RightArmColor3
    getgenv().saved_colors.LeftLegColor3 = bc.LeftLegColor3
    getgenv().saved_colors.RightLegColor3 = bc.RightLegColor3
    getgenv().saved_colors.TorsoColor3 = bc.TorsoColor3

    ingame_notify("info", "saved body color(s).", "white", 5)

    return true, rig
end

local function apply_skin()
    if next(getgenv().saved_colors) == nil then return false end

    Remote:InvokeServer({
        Action = "UpdateHumanDescProperties",
        Properties = {
            HeadColor = getgenv().saved_colors.HeadColor3,
            TorsoColor = getgenv().saved_colors.TorsoColor3,
            LeftArmColor = getgenv().saved_colors.LeftArmColor3,
            RightArmColor = getgenv().saved_colors.RightArmColor3,
            LeftLegColor = getgenv().saved_colors.LeftLegColor3,
            RightLegColor = getgenv().saved_colors.RightLegColor3,
        }
    })

    return true
end
wait(0.1)
ingame_notify("wsg bro", "Welcome to: Flames Hub | Catalog Avatar Creator.", "orange", 10)

getgenv().MakeYourselfOwnerOfScript = AvatarSection:Button("Char Into Owner Of Script.", function()
    make_avatar(7712000520, "r6")
    ingame_notify("success", "made you look like me, no glazin shit.", "green", 5)
end)

getgenv().RainbowSkin_ToggleUI = AvatarSection:Toggle("Rainbow Skin (FE)", function(state)
    if state then
        save_skin()
        ingame_notify("info", "saved current skintone and enabled rgb skin.", "white", 5)
        getgenv().Rainbow_Skin_Enabled = true
            while getgenv().Rainbow_Skin_Enabled == true do
            task.wait()
            for name, color in pairs(colors) do
                task.wait(0)
                local ohTable = {
                    ["Action"] = "UpdateHumanDescProperties",
                    ["Properties"] = {
                        ["HeadColor"] = color,
                        ["TorsoColor"] = color,
                        ["LeftArmColor"] = color,
                        ["RightArmColor"] = color,
                        ["LeftLegColor"] = color,
                        ["RightLegColor"] = color
                    }
                }
                Catalog_Remote:InvokeServer(ohTable)
            end
        end
    else
        getgenv().Rainbow_Skin_Enabled = false
        wait(2)
        ingame_notify("success", "disabled RGB skintone.", "green", 5)
        if not getgenv().Rainbow_Skin_Enabled then
            ingame_notify("info", "resetting skintone...", "white", 5)
            apply_skin()
            wait(0.5)
            ingame_notify("success", "reset skintone.", "green", 5)
        end
    end
end)

PlayersSection:TextBox("Copy Avatar (FE)", function(player_user)
    local copy_target = findplr(player_user)
    if not copy_target then
        return ingame_notify("error", "that player don't exist bro.", "red", 10)
    end
    local copy_target_hum = get_human(copy_target)

    ingame_notify("success", "copying: "..tostring(copy_target), "green", 5)
    make_avatar(copy_target, rig_to_string(copy_target_hum))
end)

AvatarSection:Button("Refresh Character (FE)", function()
    local hum = get_human(LocalPlayer)

    make_avatar(LocalPlayer, rig_to_string(hum))
    ingame_notify("success", "refreshed character successfully.", "green", 5)
end)

getgenv().Spam_Name_Toggle = PlayersSection:Toggle("Spam Names (FE)", function(state)
    if state then
        name_changer_premium(true)
    else
        name_changer_premium(false)
    end
end)

getgenv().Flash_Name_Toggle = PlayersSection:Toggle("Spam Titles (FE)", function(state)
    if state then
        flash_name_title(true)
    else
        flash_name_title(false)
    end
end)

getgenv().PrivServerNotificationSpamToggle = PrivServerSection:Toggle("Notification Spam (Blinding, FE)", function(state)
    vip_server_notif_spam(state)
end)
