local urls = {
    "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_Admin_Obf.lua",
    "https://pastebin.com/raw/azPSzEjH",
    "https://pastefy.app/SiDMhe47/raw"
}

local rq = request 
    or http_request 
    or (syn and syn.request) 
    or (http and http.request) 
    or (fluxus and fluxus.request)

local function load_script(code)
    local f = loadstring(code)
    if f then 
        f()
        return true
    end
end

local function try_request(url)
    if not rq then return false end

    local ok, res = pcall(function()
        return rq({Url = url, Method = "GET"})
    end)

    if not ok or not res then return false end

    local body = res.Body or res.body or res.ResponseBody or res.response or res

    if type(body) ~= "string" then return false end

    return load_script(body)
end

local function try_httpget(url)
    local ok, body = pcall(function()
        return game:HttpGet(url)
    end)

    if ok and type(body) == "string" then
        return load_script(body)
    end

    return false
end

local success = false

for _, url in ipairs(urls) do
    if try_request(url) then 
        success = true
        break
    end

    if try_httpget(url) then
        success = true
        break
    end
end

if not success then
    warn("Failed to load script.")
end
