local http_requesting = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request) or blankfunction

local function isbad(body, code)
    if code == 404 then return true end
    if not body then return true end
    local lower = tostring(body):lower()
    if lower:find("404") then return true end
    return false
end

local function tryload(urls)
    for _, url in ipairs(urls) do
        local ok, res = pcall(function()
            return http_requesting({Url = url, Method = "GET"})
        end)
        if ok and res and not isbad(res.Body, res.StatusCode) then
            local f = loadstring(res.Body)
            if f then f() return true end
        end
    end
end

local function tryload_httpget(urls)
    for _, url in ipairs(urls) do
        local ok, body = pcall(function()
            return game:HttpGet(url)
        end)
        if ok and not isbad(body, nil) then
            local f = loadstring(body)
            if f then f() return true end
        end
    end
end

local urls = {
    "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_Admin_Obf.lua",
    "https://pastebin.com/raw/azPSzEjH",
    "https://pastefy.app/SiDMhe47/raw"
}

local success = false

if http_requesting then
    success = tryload(urls)
end

if not success then
    success = tryload_httpget(urls)
end

if not success then
    return warn("Failed to load script from all URLs.")
end
