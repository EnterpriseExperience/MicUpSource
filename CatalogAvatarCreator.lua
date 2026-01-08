if not game:IsLoaded() then game.Loaded:Wait() end

if getgenv().CatalogAvatarCreator_Script_Menu_Loaded then
    return 
end

getgenv().CatalogAvatarCreator_Script_Menu_Loaded = true

local g = getgenv()

if not getgenv().GlobalEnvironmentFramework_Initialized then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua'))()
    wait(0.1)
    getgenv().GlobalEnvironmentFramework_Initialized = true
end

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
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LumUILibrary.lua"))()
local Window = Library.new(tostring(game_name).." - Control Panel")
local HomeTab = Window:Tab("Home")
local ReanimationTab = Window:Tab("Reanimation")
local UITab = Window:Tab("UI")
local AvatarSection = HomeTab:Section("Character")
local PlayersSection = HomeTab:Section("Players")
local PrivServerSection = HomeTab:Section("Private Server")
local R6AnimationsSection = ReanimationTab:Section("R6 Animations")
local UISection = UITab:Section("UI")
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
local TweenService = service_wrap("TweenService")

function close_menu()
    closeWindow()
    getgenv().CatalogAvatarCreator_Script_Menu_Loaded = false
end

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
local Save_Fit_RE = Events_Folder and Events_Folder:FindFirstChild("SavedOutfitsRemote", true)
local Upd_Plr_Status = Events_Folder and Events_Folder:FindFirstChild("UpdatePlayerStatus", true)
local IsPriv_RF = Events_Folder and Events_Folder:FindFirstChild("GetIsVIPServer", true)
local ApplyPose_RE = Events_Folder and Events_Folder:FindFirstChild("ApplyPose", true)
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

function save_current_avatar(name)
    local args = {
        [1] = {
            ["OutfitName"] = tostring(name);
            ["Configs"] = {};
            ["Action"] = "CreateNewOutfit";
        };
    }

    Save_Fit_RE:InvokeServer(unpack(args))
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

function disable_reanimation()
    local ohTable1 = {}

    ApplyPose_RE:FireServer(ohTable1)
    wait(0.3)
    local okhum = get_human(LocalPlayer)
    local okchar = get_char(LocalPlayer)

    if okhum then
        okhum:ChangeState(Enum.HumanoidStateType.Dead)
    else
        okchar:BreakJoints()
    end
end
wait(0.2)
function self_walking_reanimation_legs(toggle)
    local angle = 0
    
    if toggle then
        getgenv().self_walking_legs = true
        task.spawn(function()
            local t = 0
            while getgenv().self_walking_legs == true do
                t += 0.07

                local pose = {
                    ["Right Hip"] = {
                        C0 = CFrame.new(1, -1, math.sin(t) * 6),
                        C1 = CFrame.new(0.5, 1, 0)
                    },
                    ["Left Hip"] = {
                        C0 = CFrame.new(-1, -1, math.sin(t + 1) * 6),
                        C1 = CFrame.new(-0.5, 1, 0)
                    }
                }

                ApplyPose_RE:FireServer(pose)
                task.wait(0.03)
            end
        end)
    else
        getgenv().self_walking_legs = false
        repeat task.wait() until not getgenv().self_walking_legs
        wait(0.5)
        if not getgenv().self_walking_legs then
            disable_reanimation()
        end
    end
end

function gun_idle_cool_anim(toggle)
    if toggle then
        getgenv().gun_animation_idle_animation = true

        task.spawn(function()
            local t = 0
            while getgenv().gun_animation_idle_animation do
                t += 0.045

                local pose = {
                    ["RootJoint"] = {
                        C0 = CFrame.new(
                            0, 
                            0.1 * math.sin(t/4), 
                            0
                        ) * CFrame.Angles(
                            0,
                            math.sin(t/8) * 0.2,
                            0
                        ),
                        C1 = CFrame.new(0,0,0)
                    },

                    ["Neck"] = {
                        C0 = CFrame.new(0, 1, 0)
                            * CFrame.Angles(
                                math.sin(t/12)*0.05,
                                math.sin(t/6)*0.25,
                                0
                            ),
                        C1 = CFrame.new(0, -0.5, 0)
                    },

                    ["Right Shoulder"] = {
                        C0 = CFrame.new(1, 0.75, 0)
                            * CFrame.Angles(
                                -0.2 + math.sin(t/4)*0.1,
                                math.sin(t/7)*0.1,
                                math.sin(t/6)*0.05
                            ),
                        C1 = CFrame.new(0.5, -0.75, 0)
                    },

                    ["Left Shoulder"] = {
                        C0 = CFrame.new(-1, 0.75, 0)
                            * CFrame.Angles(
                                -0.2 + math.sin(t/4 + 1)*0.1,
                                math.sin(t/7 + 2)*0.1,
                                math.sin(t/6 + 1)*0.05
                            ),
                        C1 = CFrame.new(-0.5, -0.75, 0)
                    },

                    ["Right Hip"] = {
                        C0 = CFrame.new(
                            1,
                            -1,
                            0.05 * math.sin(t/5)
                        ) * CFrame.Angles(
                            math.sin(t/7)*0.05,
                            0,
                            math.sin(t/10)*0.05
                        ),
                        C1 = CFrame.new(0.5, 1, 0)
                    },

                    ["Left Hip"] = {
                        C0 = CFrame.new(
                            -1,
                            -1,
                            0.05 * math.sin(t/5 + 1)
                        ) * CFrame.Angles(
                            math.sin(t/7 + 1)*0.05,
                            0,
                            math.sin(t/10 + 2)*0.05
                        ),
                        C1 = CFrame.new(-0.5, 1, 0)
                    }
                }

                ApplyPose_RE:FireServer(pose)
                task.wait(0.03)
            end
        end)
    else
        getgenv().gun_animation_idle_animation = false
        repeat task.wait() until not getgenv().gun_animation_idle_animation
        wait(0.5)
        if not getgenv().gun_animation_idle_animation then
            disable_reanimation()
        end
    end
end

function float_idle(toggle)
    if toggle then
        getgenv().float_idle = true

        task.spawn(function()
            local t = 0
            while getgenv().float_idle == true do
                t += 0.05

                local hover = math.sin(t/4) * 3
                local tilt  = math.sin(t/6) * 0.05

                local pose = {
                    ["RootJoint"] = {
                        C0 = CFrame.new(0, hover, 0) 
                            * CFrame.Angles(0, 0, tilt),
                        C1 = CFrame.new(0,0,0)
                    },

                    ["Neck"] = {
                        C0 = CFrame.new(0, 1, 0)
                            * CFrame.Angles(
                                math.sin(t/10)*0.05,
                                math.sin(t/8)*0.2,
                                0
                            ),
                        C1 = CFrame.new(0,-0.5,0)
                    },

                    ["Left Shoulder"] = {
                        C0 = CFrame.new(-1, 0.5 + hover*0.3, 0)
                            * CFrame.Angles(
                                -0.15 + math.sin(t/4)*0.1,
                                0,
                                math.sin(t/7)*0.08
                            ),
                        C1 = CFrame.new(0.5,0.5,0)
                    },

                    ["Right Shoulder"] = {
                        C0 = CFrame.new(1, 0.5 + hover*0.3, 0)
                            * CFrame.Angles(
                                -0.15 + math.sin(t/4 + 1)*0.1,
                                0,
                                math.sin(t/7 + 2)*0.08
                            ),
                        C1 = CFrame.new(-0.5,0.5,0)
                    },

                    ["Left Hip"] = {
                        C0 = CFrame.new(-1, -1 + hover*0.4, 0)
                            * CFrame.Angles(
                                math.sin(t/6)*0.07,
                                0,
                                math.sin(t/8)*0.05
                            ),
                        C1 = CFrame.new(-0.5,1,0)
                    },

                    ["Right Hip"] = {
                        C0 = CFrame.new(1, -1 + hover*0.4, 0)
                            * CFrame.Angles(
                                math.sin(t/6 + 1)*0.07,
                                0,
                                math.sin(t/8 + 2)*0.05
                            ),
                        C1 = CFrame.new(0.5,1,0)
                    }
                }

                ApplyPose_RE:FireServer(pose)
                task.wait(0.03)
            end
        end)
    else
        getgenv().float_idle = false
        repeat task.wait() until not getgenv().float_idle
        wait(0.5)
        if not getgenv().float_idle then
            disable_reanimation()
        end
    end
end

function reset_reanimation()
    local ohTable1 = {}

    ApplyPose_RE:FireServer(ohTable1)
    wait(0.3)
    local okhum = get_human(LocalPlayer)
    local okchar = get_char(LocalPlayer)

    if okhum then
        okhum:ChangeState(Enum.HumanoidStateType.Dead)
    else
        okchar:BreakJoints()
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

local function is_vip_owner()
    local success, result = pcall(function()
        return IsPriv_RF:InvokeServer()
    end)

    if not success then
        ingame_notify("error", "Remote failed: "..tostring(result), "red", 5)
        return false
    end

    if result == LocalPlayer.UserId then
        return true
    else
        return false
    end
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
            "[Viewing Settings]",
            "[Viewing Catalog]",
            "[Viewing Outfits]"
        }

        getgenv().updating_status_title = true
        while getgenv().updating_status_title == true do
        task.wait(1.8)
            for _, status in ipairs(titles) do
                task.wait(0.2)
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
    local is_priv_server = is_vip_owner()

    if not is_priv_server then
        getgenv().settings_spam = false
        return ingame_notify("error", "you don't own this private server, or it is a public server.", "red", 15)
    end

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

getgenv().owner_of_scripts_items = {
    {87582777827738, "HatAccessory"},
    {92081878279907, "FaceAccessory"},
    {108535717397134, "HairAccessory"},
    {18862883592, "WaistAccessory"},
    {77319962406803, "BackAccessory"},
    {75283135885755, "NeckAccessory"},
    {139970077070888, "NeckAccessory"},
    {133181754969412, "NeckAccessory"},
    {17276993677, "NeckAccessory"},
    {9284648371, "Pants"},
    {8878985472, "Shirt"},
    {238983378, "Face"}
}

getgenv().remove_bundle_heads = function()
    Catalog_Remote:InvokeServer({
        Action = "UpdateHumanDescProperties",
        Properties = {
            Head = 0
        }
    })
end

getgenv().remove_bundle_animations = function()
    Catalog_Remote:InvokeServer({
        Action = "UpdateHumanDescProperties",
        Properties = {
            IdleAnimation = 0,
            WalkAnimation = 0,
            RunAnimation = 0,
            JumpAnimation = 0,
            FallAnimation = 0,
            ClimbAnimation = 0,
            SwimAnimation = 0
        }
    })
end

getgenv().set_animation_fuzzy = function(name, value)
    if typeof(name) ~= "string" then return end
    if typeof(value) ~= "number" then return end

    local n = name:lower()
    local prop

    if n:find("idle") or n:find("mood") then
        prop = "IdleAnimation"
    elseif n:find("walk") then
        prop = "WalkAnimation"
    elseif n:find("run") then
        prop = "RunAnimation"
    elseif n:find("jump") then
        prop = "JumpAnimation"
    elseif n:find("fall") then
        prop = "FallAnimation"
    elseif n:find("climb") then
        prop = "ClimbAnimation"
    elseif n:find("swim") then
        prop = "SwimAnimation"
    end

    if not prop then return end

    Catalog_Remote:InvokeServer({
        Action = "UpdateHumanDescProperties",
        Properties = {
            [prop] = value
        }
    })
end

getgenv().owner_of_scripts_body_colors = {
    Action = "UpdateHumanDescProperties",
    Properties = {
        HeadColor = Color3.new(0.411765, 0.25098, 0.156863),
        TorsoColor = Color3.new(0.411765, 0.25098, 0.156863),
        LeftArmColor = Color3.new(0.411765, 0.25098, 0.156863),
        RightArmColor = Color3.new(0.411765, 0.25098, 0.156863),
        LeftLegColor = Color3.new(0.411765, 0.25098, 0.156863),
        RightLegColor = Color3.new(0.411765, 0.25098, 0.156863)
    }
}

getgenv().owner_of_scripts_body_type_scales = {
    Action = "UpdateHumanDescProperties",
    Properties = {
        BodyTypeScale = 0.95,
        DepthScale = 0.85,
        HeadScale = 1,
        HeightScale = 0.8,
        WidthScale = 0.7,
        ProportionScale = 0.4
    }
}

getgenv().korblox_right_leg_equip_tble = {
	["Id"] = 139607718,
	["Action"] = "TryItem",
	["PropertyName"] = "RightLeg"
}

getgenv().reset_humanoid_desc = function()
    Catalog_Remote:InvokeServer({
        Action = "UpdateHumanDescProperties",
        Properties = {
            Head = 0,
            Torso = 0,
            LeftArm = 0,
            RightArm = 0,
            LeftLeg = 0,
            RightLeg = 0,
            Face = 0,
            Shirt = 0,
            Pants = 0,
            GraphicTShirt = 0,
            HeadColor = Color3.new(1,1,1),
            TorsoColor = Color3.new(1,1,1),
            LeftArmColor = Color3.new(1,1,1),
            RightArmColor = Color3.new(1,1,1),
            LeftLegColor = Color3.new(1,1,1),
            RightLegColor = Color3.new(1,1,1),
            BodyTypeScale = 0,
            DepthScale = 0,
            HeadScale = 0,
            HeightScale = 0,
            WidthScale = 0,
            ProportionScale = 0,
            IdleAnimation = 0,
            WalkAnimation = 0,
            RunAnimation = 0,
            JumpAnimation = 0,
            FallAnimation = 0,
            ClimbAnimation = 0,
            SwimAnimation = 0,
            HatAccessory = 0,
            HairAccessory = 0,
            FaceAccessory = 0,
            NeckAccessory = 0,
            WaistAccessory = 0,
            BackAccessory = 0,
            FrontAccessory = 0
        }
    })
end

AvatarSection:Button("Char Into Owner Of Script.", function()
    if not getgenv().Humanoid.RigType == Enum.HumanoidRigType.R15 then
        return ingame_notify("error", "you need to be r15 to do this.", "green", 10)
    end

    getgenv().reset_humanoid_desc()
    task.wait(0.6)

    for _, item in ipairs(getgenv().owner_of_scripts_items) do
        Catalog_Remote:InvokeServer({
            Action = "TryItem",
            Id = item[1],
            PropertyName = item[2]
        })
        task.wait(0.15)
    end

    task.wait(0.25)
    Catalog_Remote:InvokeServer(getgenv().owner_of_scripts_body_colors)
    task.wait(0.25)
    Catalog_Remote:InvokeServer({
        Action = "TryBundle",
        BundleId = 808195
    })

    task.wait(0.4)
    Catalog_Remote:InvokeServer(getgenv().owner_of_scripts_body_type_scales)
    wait(0.3)
    task.wait(0.3)
    getgenv().remove_bundle_animations()
    task.wait(0.2)
    getgenv().remove_bundle_heads()
    wait(0.3)
    ingame_notify("success", "applying animations...", "green", 5)
    wait()
    getgenv().set_animation_fuzzy("walk", 0)
    wait(0.2)
    getgenv().set_animation_fuzzy("walk", 619537468)
    wait(0.1)
    getgenv().set_animation_fuzzy("run", 619536621)
    wait(0.1)
    getgenv().set_animation_fuzzy("idle", 734327140)
    wait(0.1)
    getgenv().set_animation_fuzzy("jump", 619542888)
    wait(0.1)
    getgenv().set_animation_fuzzy("fall", 619541867)
    wait(0.1)
    Catalog_Remote:InvokeServer(getgenv().korblox_right_leg_equip_tble)

    ingame_notify("success", "Applied all accessories.", "green", 5)
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
            wait(1)
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
    local copy_target_char = copy_target.Character or get_char(copy_target)
    if not copy_target_char then return ingame_notify("error", "players character doesn't exist anymore.", "red", 6) end
    local copy_target_hum = copy_target_char:FindFirstChildWhichIsA("Humanoid") or copy_target_char:WaitForChild("Humanoid", 3) or get_human(copy_target)

    ingame_notify("success", "copying: "..tostring(copy_target), "green", 5)
    copy_avatar(copy_target)
    --make_avatar(copy_target, rig_to_string(copy_target_hum))
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

getgenv().SelfWalkingLegs_Anim = R6AnimationsSection:Toggle("Self Walking Anim (FE)", function(state)
    self_walking_reanimation_legs(state)
end)

getgenv().Gun_Idle_Animation = R6AnimationsSection:Toggle("Gun Idle (Kinda Broken, FE)", function(state)
    gun_idle_cool_anim(state)
end)

getgenv().Float_Idle_Animation = R6AnimationsSection:Toggle("Float Idle (FE)", function(state)
    float_idle(state)
end)

PlayersSection:TextBox("Save Current Outfit", function(curname)
    save_current_avatar(curname)
    ingame_notify("success", "saved outfit: "..tostring(curname), "green", 10)
end)

getgenv().WearAllPlrsOutfits = PlayersSection:Toggle("Wear Everyones Outfits (Loop, FE)", function(state)
    if state then
        getgenv().wearing_everyones_outfits = true
        while getgenv().wearing_everyones_outfits == true do
        task.wait(3)
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer then
                    local theirhum = get_human(v)
                    local theirrig = rig_to_string(theirhum)

                    if theirhum then
                        make_avatar(v, theirrig)
                    end
                end
            end
        end
    else
        getgenv().wearing_everyones_outfits = false
    end
end)

UISection:Button("Destroy GUI", function()
    close_menu()
end)
