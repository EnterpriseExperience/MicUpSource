if getgenv().hidden_loaded then return end
getgenv().hidden_loaded = true

local g = getgenv()

function randomString()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32,126))
    end
    return table.concat(array)
end

local function make_round(obj, radius)
    local uic = Instance.new("UICorner")
    uic.CornerRadius = UDim.new(0, radius)
    uic.Parent = obj
end

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
local valid_titles = {success="Success",info="Info",warning="Warning",error="Error",succes="Success",sucess="Success",eror="Error",erorr="Error",warnin="Warning"}
local function format_title(str)
    if typeof(str)~="string" then return "Info" end
    local key=str:lower()
    return valid_titles[key] or "Info"
end
getgenv().notify=getgenv().notify or function(title,msg,dur)
    local fixed_title=format_title(title)
    NotifyLib:External_Notification(fixed_title,tostring(msg),tonumber(dur))
end

local uis=game:GetService("UserInputService")
function dragify(Frame)
    dragToggle=nil
    dragSpeed=0.15
    dragInput=nil
    dragStart=nil
    dragPos=nil
    function updateInput(input)
        Delta=input.Position-dragStart
        Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+Delta.X,startPos.Y.Scale,startPos.Y.Offset+Delta.Y)
        game:GetService("TweenService"):Create(Frame,TweenInfo.new(0.15),{Position=Position}):Play()
    end
    Frame.InputBegan:Connect(function(input)
        if (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) and uis:GetFocusedTextBox()==nil then
            dragToggle=true
            dragStart=input.Position
            startPos=Frame.Position
            input.Changed:Connect(function()
                if input.UserInputState==Enum.UserInputState.End then
                    dragToggle=false
                end
            end)
        end
    end)
    Frame.InputChanged:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
            dragInput=input
        end
    end)
    uis.InputChanged:Connect(function(input)
        if input==dragInput and dragToggle then
            updateInput(input)
        end
    end)
end

local core_gui = game:GetService("CoreGui")
local cg = core_gui
local players_srv = game:GetService("Players")
local fake_name = "@Hidden"
local fake_image = "rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420"

getgenv().hidden_settings=getgenv().hidden_settings or {enabled=false,conns={},players_frame=nil,leaderboard_frame=nil}
local hidden=getgenv().hidden_settings
local hidden_person = g.hidden_person or {}
g.hidden_person = hidden_person
hidden_person.conns = hidden_person.conns or {}
local fakeName_fallback = fake_name
local fakeImg_fallback = fake_image

local function find_settings_root()
    for _,v in ipairs(core_gui:GetDescendants()) do
        local n=v.Name:lower()
        if n:find("settingsclip") and v:IsA("Frame") then
            return v
        end
    end
    return nil
end

local function find_inner_frame(parent)
    if not parent then return nil end
    for _,v in ipairs(parent:GetDescendants()) do
        if v.Name:lower():find("viewinner") then
            return v
        end
    end
    return nil
end

local function find_players_frame(frame)
    if not frame then return nil end
    for _,v in ipairs(frame:GetChildren()) do
        if v:IsA("Frame") and v.Name:lower()=="players" then
            return v
        end
    end
    return nil
end

local function find_leaderboard_frame()
    return core_gui:FindFirstChild("PlayerList")
end

local function find_initial_view_frame()
    local roblox_gui = core_gui:FindFirstChild("RobloxGui")
    if roblox_gui then
        local container = roblox_gui:FindFirstChild("Container")
        if container then
            local maincontainer = container:FindFirstChild("MainContainer")
            if maincontainer then
                local init = maincontainer:FindFirstChild("InitialView")
                if init and init:IsA("Frame") then
                    return init
                end
            end
        end
    end
    for _,v in ipairs(core_gui:GetDescendants()) do
        local n=v.Name:lower()
        if n:find("initialview") and v.Parent and v.Parent.Name:lower():find("maincontainer") then
            return v
        end
    end
    return nil
end

local function find_top_frame(insidewhat)
    if not insidewhat then return nil end
    for _, v in ipairs(insidewhat:GetDescendants()) do
        if v.Name:lower():find("top") and v:IsA("Frame") then
            return v
        end
    end
    return nil
end

local function apply_hidden_to_players()
    if not hidden.players_frame then return end
    for _,v in ipairs(hidden.players_frame:GetDescendants()) do
        local n = v.Name:lower()
        if n:sub(1,11) == "playerlabel" then
            for _,c in ipairs(v:GetDescendants()) do
                if c:IsA("TextLabel") then
                    c.Text=fake_name
                    if not hidden.conns[c] then
                        hidden.conns[c] = c:GetPropertyChangedSignal("Text"):Connect(function()
                            if hidden.enabled then c.Text=fake_name end
                        end)
                    end
                elseif c:IsA("ImageLabel") then
                    c.Image=fake_image
                    if not hidden.conns[c] then
                        hidden.conns[c] = c:GetPropertyChangedSignal("Image"):Connect(function()
                            if hidden.enabled then c.Image=fake_image end
                        end)
                    end
                end
            end
        end
    end
end

local function apply_hidden_to_leaderboard()
    if not hidden.leaderboard_frame then return end
    for _,v in ipairs(hidden.leaderboard_frame:GetDescendants()) do
        local n = v.Name:lower()

        if n:find("player") or n:find("entry") then
            if v:IsA("TextLabel") then
                v.Text = fake_name
                if not hidden.conns[v] then
                    hidden.conns[v] = v:GetPropertyChangedSignal("Text"):Connect(function()
                        if hidden.enabled then v.Text = fake_name end
                    end)
                end
            elseif v:IsA("ImageLabel") then
                v.Image = fake_image
                if not hidden.conns[v] then
                    hidden.conns[v] = v:GetPropertyChangedSignal("Image"):Connect(function()
                        if hidden.enabled then v.Image = fake_image end
                    end)
                end
            end
        end
    end
end

local function apply_hidden_to_topframe()
    local init = find_initial_view_frame()
    if not init then return end
    local top = find_top_frame(init)
    if not top then return end
    for _,v in ipairs(top:GetDescendants()) do
        local lower = v.Name:lower()
        if v:IsA("TextLabel") and (lower:find("playernamelabel") or lower=="playernamelabel") then
            v.Text = fake_name
            if not hidden.conns[v] then
                hidden.conns[v] = v:GetPropertyChangedSignal("Text"):Connect(function()
                    if hidden.enabled then
                        v.Text = fake_name
                    end
                end)
            end
        elseif v:IsA("ImageLabel") and (lower:find("avatarhead") or lower:find("avatarheadshot")) then
            v.Image = fake_image
            if not hidden.conns[v] then
                hidden.conns[v] = v:GetPropertyChangedSignal("Image"):Connect(function()
                    if hidden.enabled then
                        v.Image = fake_image
                    end
                end)
            end
        end
    end
end

local function card_root()
    local r = cg:FindFirstChild("RobloxGui")
    if not r then return nil end
    for _,v in ipairs(r:GetDescendants()) do
        local n = v.Name:lower()
        if n:find("personcard") or n:find("cardcontent") then
            return v
        end
    end
    return nil
end

local function fix_card(c)
    for _,v in ipairs(c:GetDescendants()) do
        local n = v.Name:lower()
        if v:IsA("TextLabel") and (n:find("name") or n:find("handle") or n:find("username") or n:find("display")) then
            v.Text = fakeName_fallback
            if not hidden_person.conns[v] then
                hidden_person.conns[v] = v:GetPropertyChangedSignal("Text"):Connect(function()
                    if hidden.enabled then v.Text = fakeName_fallback end
                end)
            end
        elseif v:IsA("ImageLabel") and (n:find("avatar") or n:find("thumb") or n:find("image")) then
            v.Image = fakeImg_fallback
            if not hidden_person.conns[v] then
                hidden_person.conns[v] = v:GetPropertyChangedSignal("Image"):Connect(function()
                    if hidden.enabled then v.Image = fakeImg_fallback end
                end)
            end
        end
    end
end

g.apply_personcard_fallback = g.apply_personcard_fallback or function()
    if not hidden.enabled then return end
    local root = card_root()
    if root then
        fix_card(root)
    end
end

if not hidden_person.conns["dyn"] then
    hidden_person.conns["dyn"] = cg.DescendantAdded:Connect(function(d)
        if not hidden.enabled then return end
        local n = d.Name:lower()
        if n:find("personcard") or n:find("cardcontent") or n:find("avatar") or n:find("name") then
            task.defer(function()
                g.apply_personcard_fallback()
            end)
        end
    end)
end

local function apply_hidden_to_dropdown()
    local core = game:GetService("CoreGui")
    local drop = core:FindFirstChild("PlayerList", true)
    if not drop then return end

    for _,v in ipairs(drop:GetDescendants()) do
        local n = v.Name:lower()
        if n:find("displayname") then
            if v:IsA("TextLabel") then
                v.Text = fake_name
                if not hidden.conns[v] then
                    hidden.conns[v] = v:GetPropertyChangedSignal("Text"):Connect(function()
                        if hidden.enabled then v.Text = fake_name end
                    end)
                end
            end
        elseif n=="avatarimage" or n:find("avatarimage") then
            if v:IsA("ImageLabel") then
                v.Image = fake_image
                if not hidden.conns[v] then
                    hidden.conns[v] = v:GetPropertyChangedSignal("Image"):Connect(function()
                        if hidden.enabled then v.Image = fake_image end
                    end)
                end
            end
        end
    end
end

local function apply_hidden_to_teamlist()
    local core = game:GetService("CoreGui")
    local list = core:FindFirstChild("PlayerList", true)
    if not list then return end

    for _,v in ipairs(list:GetDescendants()) do
        local n = v.Name:lower()
        if n:find("playerentry_") then
            for _,c in ipairs(v:GetDescendants()) do
                local cn = c.Name:lower()
                if c:IsA("TextLabel") then
                    c.Text = fake_name
                    if not hidden.conns[c] then
                        hidden.conns[c] = c:GetPropertyChangedSignal("Text"):Connect(function()
                            if hidden.enabled then c.Text = fake_name end
                        end)
                    end
                elseif c:IsA("ImageLabel") then
                    c.Image = fake_image
                    if not hidden.conns[c] then
                        hidden.conns[c] = c:GetPropertyChangedSignal("Image"):Connect(function()
                            if hidden.enabled then c.Image = fake_image end
                        end)
                    end
                end
            end
        end
    end
end

local function rebuild_frames()
    hidden.players_frame = nil
    hidden.leaderboard_frame = nil
    local root=find_settings_root()
    if not root then return end
    local inner = find_inner_frame(root)
    if not inner then return end
    hidden.players_frame = find_players_frame(inner)
    hidden.leaderboard_frame = find_leaderboard_frame()
end

local function reapply_all()
    rebuild_frames()
    apply_hidden_to_players()
    apply_hidden_to_teamlist()
    apply_hidden_to_leaderboard()
    apply_hidden_to_dropdown()
    apply_hidden_to_topframe()
    g.apply_personcard_fallback()
end

local function disconnect_all()
    for _,c in pairs(hidden.conns) do
        pcall(function() c:Disconnect() end)
    end
    hidden.conns={}
end

hidden.toggle = function()
    if not hidden.enabled then
        hidden.enabled=true
        getgenv().notify("success", "Streamer Mode (V1.3) is now enabled.", 3)
        reapply_all()
        if hidden.conns["join"] then hidden.conns["join"]:Disconnect() end
        hidden.conns["join"] = players_srv.PlayerAdded:Connect(function()
            task.wait(0.15)
            if hidden.enabled then reapply_all() end
        end)
        if hidden.conns["leave"] then hidden.conns["leave"]:Disconnect() end
        hidden.conns["leave"] = players_srv.PlayerRemoving:Connect(function()
            task.wait(0.15)
            if hidden.enabled then reapply_all() end
        end)
        if hidden.conns["uiupdate"] then hidden.conns["uiupdate"]:Disconnect() end
        hidden.conns["uiupdate"] = core_gui.DescendantAdded:Connect(function(desc)
            if not hidden.enabled then return end
            local n = desc.Name:lower()
            if n:find("player") or n:find("head") or n:find("label") or n:find("settings")
                or n:find("container") or n:find("initial") or n:find("top") or n:find("avatar")
                or n:find("playernamelabel") or n:find("avatarhead") then
                task.wait(0.05)
                reapply_all()
                apply_hidden_to_teamlist()
            end
        end)
    else
        hidden.enabled=false
        getgenv().notify("success", "Streamer Mode (V1.3) is now disabled.", 3)
        disconnect_all()
    end
end

g.toggle_playerlist = function(state)
    g.playerlist_state = state
    local sg = game:GetService("StarterGui")
    pcall(function()
        sg:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, state)
    end)
end

g.disable_playerlist = function()
    g.toggle_playerlist(false)
end

g.enable_playerlist = function()
    g.toggle_playerlist(true)
end

local screen=Instance.new("ScreenGui")
screen.Name="StreamerModeActivatorGUI"
screen.Parent=core_gui
screen.ResetOnSpawn=false

local main=Instance.new("Frame")
main.Parent=screen
main.Size=UDim2.new(0,260,0,150)
main.Position=UDim2.new(0.5,-130,0.35,-75)
main.BackgroundColor3=Color3.fromRGB(25,25,25)
main.BorderSizePixel=0

local corner=Instance.new("UICorner")
corner.CornerRadius=UDim.new(0,12)
corner.Parent=main

dragify(main)

local title=Instance.new("TextLabel")
title.Parent=main
title.Size=UDim2.new(0.75999999, 0, 0, 30)
title.Position=UDim2.new(0,0,0,0)
title.BackgroundTransparency=1
title.Text="Streamer Mode - V1.3."
title.TextColor3=Color3.fromRGB(255,255,255)
title.TextScaled=true
title.Font=Enum.Font.GothamMedium

local min_btn = Instance.new("TextButton")
min_btn.Parent = main
min_btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
min_btn.Size=UDim2.new(0,30,0,30)
min_btn.Position=UDim2.new(1,-60,0,0)
min_btn.Text = "-"
min_btn.TextScaled = true
min_btn.TextColor3=Color3.fromRGB(255,255,255)
min_btn.BackgroundTransparency=0.3

make_round(min_btn, 8)

local close_btn = Instance.new("TextButton")
close_btn.Parent = main
close_btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
close_btn.Size=UDim2.new(0,30,0,30)
close_btn.Position=UDim2.new(1,-30,0,0)
close_btn.Text = "X"
close_btn.TextScaled = true
close_btn.TextColor3=Color3.fromRGB(255,255,255)
close_btn.BackgroundTransparency=0.3

make_round(close_btn, 8)

local toggle_btn = Instance.new("TextButton")
toggle_btn.Parent = main
toggle_btn.Size = UDim2.new(0.8,0,0,40)
toggle_btn.Position = UDim2.new(0.1,0,0.45,0)
toggle_btn.Text = "Enable NameHider-V1.3."
toggle_btn.TextScaled = true
toggle_btn.TextColor3 = Color3.fromRGB(255,255,255)
toggle_btn.BackgroundColor3 = Color3.fromRGB(40,40,40)

make_round(toggle_btn, 8)

local top_toggle = Instance.new("TextButton")
top_toggle.Parent = screen
top_toggle.Size = UDim2.new(0,140,0,28)
top_toggle.Position = UDim2.new(0.5,-70,0,5)
top_toggle.Text = "Toggle UI."
top_toggle.TextColor3 = Color3.fromRGB(255,255,255)
top_toggle.BackgroundColor3 = Color3.fromRGB(35,35,35)
local topcorner = Instance.new("UICorner")
topcorner.CornerRadius=UDim.new(0,8)
topcorner.Parent = top_toggle

local function set_minimized(state)
    for _, child in ipairs(main:GetChildren()) do
        if child ~= title and child ~= min_btn and child ~= close_btn then
            if child:IsA("GuiObject") then
                child.Visible = not state
            end
        end
    end
end

local minimized = false
local tween = game:GetService("TweenService")

g.vim_clone = g.vim_clone or nil
g.esc_open = g.esc_open or false

g.make_vim_clone = g.make_vim_clone or function()
    if not g.vim_clone then
        local base = cloneref(game:GetService("VirtualInputManager"))
        local new = base:Clone()
        new.Name = "NEWEST_SERVICE_BASE"
        g.vim_clone = new
    end
end

g.press_escape = g.press_escape or function()
    g.make_vim_clone()
    g.vim_clone:SendKeyEvent(true, Enum.KeyCode.Escape, false, game)
    g.vim_clone:SendKeyEvent(false, Enum.KeyCode.Escape, false, game)
end

g.check_escmenu = g.check_escmenu or function()
    local cg = game:GetService("CoreGui")
    local s = cg:FindFirstChild("RobloxGui")
    if not s then return false end
    local shield = s:FindFirstChild("SettingsClippingShield")
    if not shield then return false end
    local inner = shield:FindFirstChild("SettingsShield")
    if not inner then return false end

    return inner.Visible
end

g.toggle_escmenu = g.toggle_escmenu or function(state)
    local opened = g.check_escmenu()

    if state == nil then
        if opened then
            g.press_escape()
            g.esc_open = false
        else
            g.press_escape()
            g.esc_open = true
        end
        return
    end

    if state and not opened then
        g.press_escape()
        g.esc_open = true
    elseif not state and opened then
        g.press_escape()
        g.esc_open = false
    end
end

min_btn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        set_minimized(true)
        min_btn.Text = "+"
        tween:Create(main, TweenInfo.new(0.25), {Size = UDim2.new(0,260,0,30)}):Play()
    else
        min_btn.Text = "-"
        tween:Create(main, TweenInfo.new(0.25), {Size = UDim2.new(0,260,0,150)}):Play()
        task.wait()
        set_minimized(false)
    end
end)

close_btn.MouseButton1Click:Connect(function()
    main.Visible = false
end)

toggle_btn.MouseButton1Click:Connect(function()
    hidden.toggle()
    if hidden.enabled then
        toggle_btn.Text = "Disable NameHider-V1.3."
    else
        toggle_btn.Text = "Enable NameHider-V1.3."
    end
    g.toggle_playerlist(false)
    wait(0.3)
    g.toggle_playerlist(true)
    g.toggle_escmenu(false)
end)

top_toggle.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

main.Visible = false

toggle_btn.Text = (hidden.enabled and "Disable NameHider-V1.3." or "Enable NameHider-V1.3.")
