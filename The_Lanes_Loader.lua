if not getgenv().GlobalEnvironmentFramework_Initialized then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua'))()
    wait(0.1)
    getgenv().GlobalEnvironmentFramework_Initialized = true
end
wait(0.2)
if getgenv().notify then
    getgenv().notify("Info", "Checking request status...", 2.5)
end
local req = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local url = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/The_Lanes.lua"
local function normal_retry()
    local success, err = pcall(function()
        local source = game:HttpGet(url)
        if getgenv().notify then
            getgenv().notify("Success", "Loading from main branch: Flames Hub | The Lanes.", 6)
        end
        loadstring(source)()
    end)
    return success, err
end

local function req_retry()
    if not req then return false, "no request function" end
    local response = req({
        Url = url,
        Method = "GET"
    })
    if not response then
        return false, "no response"
    end
    local body = response.Body or response.body
    if not body then
        return false, "no response body"
    end
    return pcall(function()
        loadstring(body)()
    end)
end

local function directexec()
    if not req then return false, "no request function" end
    local response = req({
        Url = url,
        Method = "GET"
    })
    if not response then
        return false, "no response"
    end
    local body = response.Body or response.body
    if not body then
        return false, "no response body"
    end
    local fn, compile_err = loadstring(body)
    if not fn then
        return false, compile_err
    end
    return pcall(fn)
end

local success, err = normal_retry()

if not success then
    if req then
        success, err = req_retry()
        if not success then
            success, err = directexec()
        end
    else
        for _ = 1, 2 do
            success, err = normal_retry()
            if success then break end
        end
    end
end

if success then
    if getgenv().notify then
        getgenv().notify("Success", "Loading from main branch: Flames Hub | The Lanes.", 6)
    end
else
    if getgenv().notify then
        getgenv().notify("Error", "All methods failed, response: "..tostring(err), 20)
    else
        warn("All retry methods failed:", err)
    end
end
