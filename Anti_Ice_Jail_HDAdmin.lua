-- [[ much better / optimized code now. ]] --

if not game:IsLoaded() then game.Loaded:Wait() end
if not getgenv().globalenvironmentframework_initialized then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua'))()
    task.wait(0.1)
    getgenv().globalenvironmentframework_initialized = true
end

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
    if not name or not mode or type(func) ~= "function" then
        return 
    end

    if getgenv().FlamesLibrary._connections[name] then
        getgenv().FlamesLibrary.disconnect(name)
    end

    getgenv().FlamesLibrary._connections[name] = {}

    local thread

    if mode == "spawn" then
        thread = task.spawn(func, ...)
    elseif mode == "defer" then
        thread = task.defer(func, ...)
    elseif mode == "delay" then
        local delay_time = ...
        local args = {select(2, ...)}
        thread = task.delay(delay_time, function()
            func(unpack(args))
        end)
    elseif mode == "wrap" then
        thread = coroutine.create(func)
        coroutine.resume(thread, ...)
    else
        -- don't really need a warning --
        -- warn("Invalid spawn mode / argument: "..tostring(mode))
        return
    end

    table.insert(getgenv().FlamesLibrary._connections[name], thread)
    return thread
end

getgenv().FlamesLibrary.is_thread_alive = function(input) -- works for just about anything, and accepts strings too.
    local lib = getgenv().FlamesLibrary

    if type(input) == "thread" then
        local ok, status = pcall(coroutine.status, input)
        if not ok then
            return false
        end
        return status ~= "dead"
    end

    if type(input) == "string" then
        local list = lib._connections[input]
        if not list then
            return false
        end

        for _, item in ipairs(list) do
            if type(item) == "thread" then
                local ok, status = pcall(coroutine.status, item)
                if ok and status ~= "dead" then
                    return true
                end
            end
        end

        return false
    end

    return false
end

getgenv().FlamesLibrary.is_alive = function(name)
    local lib = getgenv().FlamesLibrary
    local list = lib._connections[name]

    if not list then
        return false
    end

    for _, item in ipairs(list) do
        if typeof(item) == "RBXScriptConnection" then
            if item.Connected then
                return true
            end
        elseif type(item) == "thread" then
            if lib.is_thread_alive(item) then
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

    if getgenv().notify then
        getgenv().notify("Success", "Cleaned up all concurrent threads/connections.", 7)
    end
end

local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local teleportservice = cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
local runservice = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local userinputservice = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local localplayer = getgenv().LocalPlayer or players.LocalPlayer
local function blankfunction(...) return ... end
getgenv().notify = getgenv().notify or blankfunction
getgenv().antiicejailenabled = getgenv().antiicejailenabled or true
if getgenv().notify then getgenv().notify("Success","Loaded Anti-Ice/Anti-Jail HD Admin script, press R to toggle.",15) end
local function rejoinserver()
    if #players:GetPlayers() <= 1 then
		localplayer:Kick("\nRejoining...")
		wait()
		teleportservice:Teleport(game.PlaceId, localplayer)
	else
		teleportservice:TeleportToPlaceInstance(game.PlaceId, game.JobId, localplayer)
	end
end

local function start_watchers()
    getgenv().FlamesLibrary.disconnect("jailcell_watch")
    getgenv().FlamesLibrary.disconnect("iceblock_watch")
    getgenv().FlamesLibrary.disconnect("freezecheck_watch")

    getgenv().FlamesLibrary.connect("jailcell_watch", workspace.DescendantAdded:Connect(function(d)
        if getgenv().antiicejailenabled and d:IsA("Model") and d.Name == localplayer.Name.."'s JailCell" then
            rejoinserver()
        end
    end))

    getgenv().FlamesLibrary.connect("iceblock_watch",workspace.DescendantAdded:Connect(function(d)
        if getgenv().antiicejailenabled and d:IsA("Part") and d.Name == localplayer.Name.."'s FreezeBlock" then
            rejoinserver()
        end
    end))

    getgenv().FlamesLibrary.connect("freezecheck_watch",runservice.Heartbeat:Connect(function()
        if not getgenv().antiicejailenabled then return end
        local character = localplayer.Character
        if character and IsFullyFrozen and IsFullyFrozen() then
            rejoinserver()
        end
    end))
end

start_watchers()

getgenv().FlamesLibrary.connect("toggle_key_watch", userinputservice.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.R then
        getgenv().antiicejailenabled = not getgenv().antiicejailenabled

        if getgenv().antiicejailenabled then
            getgenv().notify("Success","Enabled Anti-Ice/Anti-Jail script.",4)
            start_watchers()
        else
            getgenv().notify("Success","Disabled Anti-Ice/Anti-Jail script.",4)
            getgenv().FlamesLibrary.disconnect("jailcell_watch")
            getgenv().FlamesLibrary.disconnect("iceblock_watch")
            getgenv().FlamesLibrary.disconnect("freezecheck_watch")
        end
    end
end))

if queue_on_teleport then
    queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Anti_Ice_Jail_HDAdmin.lua'))()")
else
    getgenv().antiicejailenabled = false
    getgenv().FlamesLibrary.disconnect("jailcell_watch")
    getgenv().FlamesLibrary.disconnect("iceblock_watch")
    getgenv().FlamesLibrary.disconnect("freezecheck_watch")
    getgenv().FlamesLibrary.disconnect("toggle_key_watch")
    return getgenv().notify("Error","queue_on_teleport functionality is not supported in your executor!",10)
end
