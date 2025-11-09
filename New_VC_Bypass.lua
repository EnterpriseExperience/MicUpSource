local function safe_wrap(serv)
    if cloneref then
        return cloneref(game:FindService(serv))
    else
        return game:FindService(serv)
    end
end

local vc_inter = safe_wrap("VoiceChatInternal")
local vc_service = safe_wrap("VoiceChatService")

if not vc_inter or not vc_service then
    warn("VoiceChatInternal is unavailable or has been removed/deprecated from Roblox.")
end

local reconnecting = false
local retry_dur = 3

local function unsuspend()
    if reconnecting then return end
    reconnecting = true
    task.wait(2)
    pcall(function()
        if vc_inter.JoinByGroupIdToken then
            vc_inter:JoinByGroupIdToken("", false, true)
            vc_inter:Leave()
            task.wait(0.2)
        end
        if vc_service.rejoinVoice then
            vc_service:rejoinVoice()
            vc_service:rejoinVoice()
            task.wait(0.1)
        end
        if vc_service.joinVoice then
            vc_service:joinVoice()
        end
    end)
    reconnecting = false
end

local function is_signal(x)
    if not x then return false end
    local ok, ty = pcall(function() return typeof and typeof(x) end)
    if ok and ty == "RBXScriptSignal" then return true end
    local ok2, conn = pcall(function() return x.Connect end)
    return ok2 and type(conn) == "function"
end

local function safe_connect(signal, fn)
    if not is_signal(signal) then return false, "not a signal" end
    local ok, err = pcall(function() signal:Connect(fn) end)
    return ok, err
end

local lp_mod
pcall(function() lp_mod = vc_inter.LocalPlayerModerated end)
local ok, err = safe_connect(lp_mod, unsuspend)
if not ok then end

local state_changed
pcall(function() state_changed = vc_inter.StateChanged end)
local ok2, err2 = safe_connect(state_changed, function(_, new_state)
    if new_state == Enum.VoiceChatState.Ended and not reconnecting then
        task.wait(retry_dur)
        unsuspend()
    end
end)

if not ok2 then
    if not reconnecting then
        pcall(unsuspend)
    end
end

getgenv().voicechat_check = true
