if not game:IsLoaded() then game.Loaded:Wait() end
if not getgenv().GlobalEnvironmentFramework_Initialized then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
	task.wait(0.1)
	getgenv().GlobalEnvironmentFramework_Initialized = true
end
wait(0.2)
getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set) or blankfunction
getgenv().FlamesLibrary = getgenv().FlamesLibrary or {}
getgenv().FlamesLibrary._connections = getgenv().FlamesLibrary._connections or {}
getgenv().FlamesLibrary.connect = function(name, connection)
	getgenv().FlamesLibrary._connections[name] = getgenv().FlamesLibrary._connections[name] or {}
	table.insert(getgenv().FlamesLibrary._connections[name], connection)
	return connection
end

getgenv().FlamesLibrary.disconnect = function(name)
	local list = getgenv().FlamesLibrary._connections[name]

	if list then
		for _, item in ipairs(list) do
			if typeof(item) == "RBXScriptConnection" then
				item:Disconnect()
			elseif type(item) == "thread" then
				pcall(task.cancel, item)
			end
		end
		getgenv().FlamesLibrary._connections[name] = nil
	end
end

getgenv().FlamesLibrary.spawn = function(name, mode, func, ...)
	getgenv().FlamesLibrary._connections[name] = getgenv().FlamesLibrary._connections[name] or {}

	local thread

	if mode == "spawn" then
		thread = task.spawn(func, ...)
	elseif mode == "defer" then
		thread = task.defer(func, ...)
	elseif mode == "delay" then
		local delay_time = ...
		thread = task.delay(delay_time, func)
	elseif mode == "wrap" then
		thread = coroutine.create(func)
		coroutine.resume(thread, ...)
	else
		return
	end

	table.insert(getgenv().FlamesLibrary._connections[name], thread)
	return thread
end

getgenv().FlamesLibrary.is_thread_alive = function(thread)
	if type(thread) ~= "thread" then
		return false
	end

	local success, status = pcall(coroutine.status, thread)
	if not success then
		return false
	end

	return status ~= "dead"
end

getgenv().FlamesLibrary.is_alive = function(name)
	local list = getgenv().FlamesLibrary._connections[name]

	if not list then
		return false
	end

	for _, item in ipairs(list) do
		if type(item) == "thread" then
			if getgenv().FlamesLibrary.is_thread_alive(item) then
				return true
			end
		end
	end

	return false
end

getgenv().FlamesLibrary.cleanup_all = function()
    for name in pairs(getgenv().FlamesLibrary._connections) do
        getgenv().FlamesLibrary.disconnect(name)
    end
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = "lauude Hub",
    SubTitle = "Created by lauude",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local discord_invite_code = "W8NDmMp4fN"
local function get_discord_invite(input) -- will always return the correct string: 'discord.gg/{input}', so if you just put like 'W8NDmMp4fN', it'll become > 'discord.gg/W8NDmMp4fN'.
    if not input or input == "" then
        return nil
    end

    input = tostring(input)

    local code =
        input:match("discord%.gg/([%w%-_]+)") or
        input:match("discord%.com/invite/([%w%-_]+)") or
        input:match("discordapp%.com/invite/([%w%-_]+)") or
        input:match("^([%w%-_]+)$")

    if code then
        return "discord.gg/" .. code
    end

    return nil
end
local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "home" }),
    Movement = Window:AddTab({ Title = "Movement", Icon = "gauge" }),
    Roles = Window:AddTab({ Title = "Roles", Icon = "shield" }),
    Tasks = Window:AddTab({ Title = "Tasks", Icon = "list" }),
    Auto = Window:AddTab({ Title = "Auto", Icon = "bot" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

getgenv().find_killer_folder_in_ws = function()
    local cache = getgenv().killers_folder_holder_found
    if cache and cache.Parent and cache:IsA("Folder") and cache:IsDescendantOf(workspace) then
        return cache
    end

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Folder") and v.Name:lower():find("killer") and v.Name:lower():find("folder") then
            getgenv().killers_folder_holder_found = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().killers_folder_holder_found then task.spawn(function() getgenv().find_killer_folder_in_ws() end) end

getgenv().find_task_remote_two_Remote_Event = function()
    local cache = getgenv().task_two_Remote_Event_found
    if cache and cache:IsA("RemoteEvent") then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("task") and v.Name:lower():find("2") then
            getgenv().task_two_Remote_Event_found = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().task_two_Remote_Event_found then task.spawn(function() getgenv().find_task_remote_two_Remote_Event() end) end

getgenv().find_task_one_Remote_Event = function()
    local cache = getgenv().task_one_main_Remote_Event_found
    if cache and cache:IsA("RemoteEvent") then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local name = v.Name:lower()

            if name:find("task") and name:find("remote") and not name:find("task2") then
                getgenv().task_one_main_Remote_Event_found = v
                return v
            end
        end
    end

    return nil
end
wait(0.1)
if not getgenv().task_one_main_Remote_Event_found then task.spawn(function() getgenv().find_task_one_Remote_Event() end) end

getgenv().ui_notifier = function(title, description, duration)
    if not title then title = "" end
    if not duration or not typeof(duration) == "number" then duration = 5 end
    if not description then description = "" end

    pcall(function() Fluent:Notify({Title = tostring(title), Content = tostring(description), Duration = duration}) end)
end

local plr = getgenv().LocalPlayer or getgenv().Players.LocalPlayer
local mouse = plr:GetMouse()
getgenv().kill_esp = function(name)
    local tag_name = name:gsub("Highlight", "Tag")
    local killer_folder = getgenv().killers_folder_holder_found
    if not killer_folder then return end

    for _, inst in ipairs(killer_folder:GetChildren()) do
        if (inst:IsA("Highlight") and inst.Name == name)
        or (inst:IsA("BillboardGui") and inst.Name == tag_name) then
            pcall(function() inst:Destroy() end)
        end
    end
end

Tabs.Home:AddParagraph({
    Title = "Created by lauude",
    Content = "User: " .. plr.Name .. "\nStatus: Running\nTheme: Amethyst"
})

Tabs.Home:AddButton({
Title = "Copy Discord Link",
Description = tostring(get_discord_invite(discord_invite_code)),
Callback = function()
    if getgenv().AllClipboards and typeof(getgenv().AllClipboards) == "function" then
        pcall(function() getgenv().AllClipboards(tostring(get_discord_invite(discord_invite_code))) end)
        getgenv().ui_notifier("Clipboard", "Link copied!", 5)
    else
        getgenv().ui_notifier("Error", "Could not use Clipboard functionality (unsupported).", 5)
        getgenv().ui_notifier("DISCORD", tostring(get_discord_invite(discord_invite_code)), 10)
    end
end})

getgenv().loopspeed = getgenv().loopspeed or false
getgenv().current_walk_speed_slider_value = getgenv().current_walk_speed_slider_value or 50
Tabs.Movement:AddSlider("Speed", {Title = "Speed Changer", Default = tonumber(getgenv().StarterPlayer.CharacterWalkSpeed), Min = 1, Max = 500, Rounding = 1}):OnChanged(function(v) -- safer because it lets users know what the default value ACTUALLY is.
    getgenv().current_walk_speed_slider_value = tonumber(v)
end)

Tabs.Movement:AddToggle("LoopSpeed", {Title = "Enable Speed", Default = getgenv().loopspeed or false}):OnChanged(function(v) -- safe, because it saves your global toggled state.
    getgenv().loopspeed = v
    getgenv().FlamesLibrary.disconnect("speed_loop")

    if v then
        getgenv().FlamesLibrary.spawn("speed_loop", "spawn", function()
            while getgenv().loopspeed do
                pcall(function()
                    if getgenv().Character and getgenv().Character.Parent and getgenv().Humanoid and getgenv().Character:FindFirstChildOfClass("Humanoid") then
                        getgenv().Humanoid.WalkSpeed = getgenv().current_walk_speed_slider_value
                    end
                end)
                task.wait(0)
            end
        end)
    else
        pcall(function() getgenv().Humanoid.WalkSpeed = tonumber(getgenv().StarterPlayer.CharacterWalkSpeed) end)
    end
end)

Tabs.Movement:AddButton({
Title = "Get Click TP Tool",
Callback = function()
    -- [[ properly checked in all areas. ]] --
    local lp = getgenv().LocalPlayer
    local backpack = lp:FindFirstChildOfClass("Backpack")
    local char = getgenv().Character or lp.Character or get_char(lp, 10)
    if (backpack and backpack:FindFirstChild("Click Teleport"))
    or (char and char:FindFirstChild("Click Teleport")) then
        return
    end

    pcall(function()
        local click_tp_tool = (backpack and backpack:FindFirstChild("Click Teleport")) or (char and char:FindFirstChild("Click Teleport")) or Instance.new("Tool") -- just to be extra safe.
        click_tp_tool.RequiresHandle = false
        click_tp_tool.Name = "Click Teleport"

        getgenv().FlamesLibrary.disconnect("click_tp_activate")
        getgenv().FlamesLibrary.connect("click_tp_activate", click_tp_tool.Activated:Connect(function()
            if getgenv().Character and getgenv().Character.Parent and getgenv().Character:IsDescendantOf(workspace) then
                getgenv().Character:MoveTo(mouse.Hit.p + Vector3.new(0, 3, 0))
            end
        end))

        if backpack and click_tp_tool.Parent ~= backpack then click_tp_tool.Parent = backpack end
    end)
end})

getgenv().noclip_enabled = getgenv().noclip_enabled or false
getgenv().noclip_parts = getgenv().noclip_parts or {}
local function refresh_parts()
    table.clear(getgenv().noclip_parts)
    local Character = getgenv().Character or LocalPlayer.Character or get_char(LocalPlayer, 10)
    if not Character then return end

    for _, inst in ipairs(Character:GetDescendants()) do
        if inst:IsA("BasePart") then
            table.insert(getgenv().noclip_parts, inst)
        end
    end
end

getgenv().suspect_player_Remote_Event_finder = function()
    local cache = getgenv().suspect_player_RE
    if cache and cache:IsA("RemoteEvent") then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("suspect") then
            getgenv().suspect_player_RE = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().suspect_player_RE then task.spawn(function() getgenv().suspect_player_Remote_Event_finder() end) end

local function get_current_killer_player_obj()
    local killer_folder = getgenv().killers_folder_holder_found
    if not killer_folder then return nil end

    for _, model in ipairs(killer_folder:GetChildren()) do
        if model and model ~= getgenv().Character and model:IsA("Model") then
            local player_obj = getgenv().Players:FindFirstChild(model.Name)

            if player_obj and player_obj:IsA("Player") then
                return player_obj
            end
        end
    end

    return nil
end

getgenv().vote_player_boolean_Remote_Event_finder = function()
    local cache = getgenv().vote_player_boolean_Remote_Event_found
    if cache and cache:IsA("RemoteEvent") then
        return cache
    end

    for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("vote") and v.Name:lower():find("player") and v.Name:lower():find("remote") then
            getgenv().vote_player_boolean_Remote_Event_found = v
            return v
        end
    end

    return nil
end
wait(0.1)
if not getgenv().vote_player_boolean_Remote_Event_found then task.spawn(function() getgenv().vote_player_boolean_Remote_Event_finder() end) end

getgenv().always_voting_out_killer = function(toggled)
    local remote = getgenv().suspect_player_RE or getgenv().suspect_player_Remote_Event_finder()
    if not remote then
        getgenv().always_voting_the_killer_out = false
        return getgenv().ui_notifier("Error", "Failed to find SuspectPlayer RemoteEvent.", 6)
    end

    local remote_boolean = getgenv().vote_player_boolean_Remote_Event_found or getgenv().vote_player_boolean_Remote_Event_finder()
    if not remote_boolean then
        getgenv().always_voting_the_killer_out = false
        return getgenv().ui_notifier("Error", "Failed to find VotePlayer Boolean RemoteEvent.", 6)
    end

    if toggled then
        getgenv().always_voting_the_killer_out = true
        getgenv().FlamesLibrary.spawn("always_vote_the_killer_easily", "spawn", function()
            while getgenv().always_voting_the_killer_out == true do
                task.wait()
                local current_killer = get_current_killer_player_obj()
                if current_killer then
                    remote:FireServer(current_killer)
                    remote_boolean:FireServer(true)
                end
            end
        end)
    else
        getgenv().always_voting_the_killer_out = false
        getgenv().FlamesLibrary.disconnect("always_vote_the_killer_easily")
    end
end

local function noclip_step()
    local parts = getgenv().noclip_parts
    for i = 1, #parts do
        local part = parts[i]
        if part and part.Parent and part.CanCollide then
            pcall(function() part.CanCollide = false end)
        end
    end
end

getgenv().toggle_noclip = function(state)
    if state then
        if getgenv().noclip_enabled then return end
        refresh_parts()

        getgenv().FlamesLibrary.disconnect("noclip_loop")
        wait(0.1) -- hold up.
        getgenv().noclip_enabled = true
        getgenv().FlamesLibrary.connect("noclip_loop", RunService.Stepped:Connect(noclip_step))
    else
        if not getgenv().noclip_enabled then return end
        getgenv().FlamesLibrary.disconnect("noclip_loop")

        for i = 1, #getgenv().noclip_parts do
            local part = getgenv().noclip_parts[i]
            if part and part.Parent then
                pcall(function() part.CanCollide = true end)
            end
        end

        table.clear(getgenv().noclip_parts)
        getgenv().noclip_enabled = false
    end
end

Tabs.Roles:AddToggle("AlwaysVoteKiller", {Title = "Automatically Vote-Out Killer (FE)", Default = getgenv().always_voting_the_killer_out or false}):OnChanged(function(v)
    getgenv().always_voting_out_killer(v)
end)

getgenv().noclip_enabled = getgenv().noclip_enabled or false
Tabs.Movement:AddToggle("nc", {Title = "Noclip", Default = getgenv().noclip_enabled or false}):OnChanged(function(v)
    getgenv().toggle_noclip(v) -- much safer now.
end)

getgenv().killer_esp = getgenv().killer_esp or false
getgenv().killer_esp_id = getgenv().killer_esp_id or 0
Tabs.Roles:AddToggle("kesp", {Title = "Killer ESP", Default = getgenv().killer_esp}):OnChanged(function(v)
    getgenv().killer_esp = v
    getgenv().killer_esp_id += 1

    local current_id = getgenv().killer_esp_id
    local folder = getgenv().killers_folder_holder_found
    if folder then
        for _, model in ipairs(folder:GetChildren()) do
            if model:IsA("Model") then
                local h = model:FindFirstChild("KillerHighlight")
                if h then h:Destroy() end

                local t = model:FindFirstChild("KillerTag")
                if t then t:Destroy() end
            end
        end
    end

    if not v then return end
    task.spawn(function()
        while getgenv().killer_esp and current_id == getgenv().killer_esp_id do
            local killer_folder = getgenv().killers_folder_holder_found

            if killer_folder then
                for _, model in ipairs(killer_folder:GetChildren()) do
                    if model ~= getgenv().Character and model:IsA("Model") then
                        local highlight = model:FindFirstChild("KillerHighlight")

                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "KillerHighlight"
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.Parent = model
                        else
                            highlight.Parent = model
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

getgenv().innocent_esp = getgenv().innocent_esp or false
getgenv().innocent_esp_id = getgenv().innocent_esp_id or 0
Tabs.Roles:AddToggle("iesp", {Title = "Innocent ESP", Default = getgenv().innocent_esp}):OnChanged(function(v)
    getgenv().innocent_esp = v
    getgenv().innocent_esp_id += 1

    local current_id = getgenv().innocent_esp_id

    for _, player in ipairs(getgenv().Players:GetPlayers()) do
        if player ~= getgenv().LocalPlayer then
            local char = player.Character
            if char then
                local h = char:FindFirstChild("InnocentHighlight")
                if h then h:Destroy() end
            end
        end
    end

    if not v then return end

    task.spawn(function()
        while getgenv().innocent_esp and current_id == getgenv().innocent_esp_id do
            local killer_folder = getgenv().killers_folder_holder_found

            for _, player in ipairs(getgenv().Players:GetPlayers()) do
                if player ~= getgenv().LocalPlayer then
                    local char = player.Character or get_char(player, 3)

                    if char then
                        local is_killer = killer_folder and char:IsDescendantOf(killer_folder)

                        if not is_killer then
                            local highlight = char:FindFirstChild("InnocentHighlight")

                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Name = "InnocentHighlight"
                                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                highlight.Parent = char
                            else
                                highlight.Parent = char
                            end
                        end
                    end
                end
            end

            task.wait(1)
        end
    end)
end)

local function refresh_tasks() -- also doesn't look like ChatGPT anymore.
    pcall(function()
        local Character = getgenv().Character
        local task_folder = workspace:FindFirstChild("TaskFolder")
        if not task_folder then return end

        for _, part in ipairs(task_folder:GetChildren()) do
            if part:IsA("BasePart") then
                Tabs.Tasks:AddButton({
                Title = "TP: " .. part.Name,
                Callback = function()
                    pcall(function()
                        local Character = getgenv().Character or getgenv().LocalPlayer.Character or get_char(LocalPlayer, 10)
                        local root_part = getgenv().HumanoidRootPart or Character and Character:FindFirstChild("HumanoidRootPart") or get_root(LocalPlayer, 10)
                        pcall(function() if root_part and root_part.Parent then root_part.CFrame = part.CFrame + Vector3.new(0, 3, 0) end end) -- safe + checked.
                    end)
                end})
            end
        end
    end)
end

getgenv().anti_afk = getgenv().anti_afk or true
Tabs.Tasks:AddButton({Title = "Refresh Tasks", Callback = refresh_tasks})

Tabs.Tasks:AddButton({Title = "Do Task (FE)", Callback = function()
    pcall(function() getgenv().task_two_Remote_Event_found:FireServer("Activated") end)
end})

Tabs.Tasks:AddButton({Title = "Finish One Task (FE)", Callback = function()
    pcall(function() getgenv().task_two_Remote_Event_found:FireServer("Activated") end)
    pcall(function() getgenv().task_one_main_Remote_Event_found:FireServer(true) end)
end})

Tabs.Tasks:AddToggle("auto_completer", {Title = "Automatically Complete Tasks (FE) MONEY FARMER!", Default = getgenv().doing_all_tasks_easily or false}):OnChanged(function(v)
    getgenv().doing_all_tasks_easily = v
    getgenv().FlamesLibrary.disconnect("easily_finishing_all_tasks")
    if not v then return end

    if v then
        getgenv().FlamesLibrary.spawn("easily_finishing_all_tasks", "spawn", function()
            while getgenv().doing_all_tasks_easily == true do
            task.wait(0)
                pcall(function() getgenv().task_one_main_Remote_Event_found:FireServer(true) end)
            end
        end)
    else
        getgenv().doing_all_tasks_easily = false
        getgenv().FlamesLibrary.disconnect("easily_finishing_all_tasks")
    end
end)

Tabs.Auto:AddToggle("afk", {Title = "AntiAFK", Default = getgenv().anti_afk or true}):OnChanged(function(v)
    getgenv().anti_afk = v
    getgenv().FlamesLibrary.disconnect("anti_afk_conn")
    if not v then return end

    getgenv().FlamesLibrary.connect("anti_afk_conn", getgenv().LocalPlayer.Idled:Connect(function()
        pcall(function()
            local vu = getgenv().VirtualUser or cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser") -- always protect VirtualUser service, as some games (could even be this one), sometimes can detect it and ban you.
            local cam = workspace.CurrentCamera

            vu:Button2Down(Vector2.new(0,0), cam.CFrame)
            task.wait(0.1)
            vu:Button2Up(Vector2.new(0,0), cam.CFrame)
        end)
    end))
end)

Tabs.Auto:AddButton({
Title = "Rejoin Server",
Callback = function()
    -- [[ also safer now, and always allows for rejoins. ]] --
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)
end})

Tabs.Auto:AddButton({
Title = "Server Hop",
Callback = function()
    -- [[ fixed + safer. ]] --
    pcall(function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
        local body = HttpService:JSONDecode(req)

        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer) end) -- just incase a server is full call it with 'pcall'.
        else
            return getgenv().ui_notifier("ServerHop", "Couldn't find a server.", 5)
        end
    end)
end})

local player_drop = Tabs.Auto:AddDropdown("playertp", {Title = "Select Player", Values = {}, Multi = false})
local function update_players() -- doesn't look like ChatGPT anymore lol.
    pcall(function()
        local list = {}
        local lp = getgenv().LocalPlayer

        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= lp then
                table.insert(list, player.Name)
            end
        end

        player_drop:SetValues(list)
    end)
end

update_players()
-- [[ safe + prevents memory leaks (so when you re-execute the script you won't stack connections, which is bad). ]] --
getgenv().FlamesLibrary.connect("player_added_conn", Players.PlayerAdded:Connect(update_players))
getgenv().FlamesLibrary.connect("player_removing_conn", Players.PlayerRemoving:Connect(update_players))

player_drop:OnChanged(function(val)
    pcall(function()
        local target = Players:FindFirstChild(val)
        if target and target.Character and target.Character.Parent then
            local get_their_char = target.Character or get_char(target, 3) -- wouldn't recommend anything over 5, will stall the script (because it'll wait for longer).
            local get_their_root = get_their_char:FindFirstChild("HumanoidRootPart") or get_root(target, 3) -- wouldn't recommend anything over 5, will stall the script (because it'll wait for longer).

            getgenv().HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end)
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("lauudeHub")
SaveManager:SetFolder("lauudeHub/configs")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
