local function load_script_from_url(url)
    local success, code = pcall(function()
        return game:HttpGet(url, true)
    end)

    if not success or not code or code == "" then
        warn("Failed to fetch script from: "..tostring(url))
        return false
    end

    local func, err = loadstring(code)
    if not func then
        warn("Loadstring failed: "..tostring(err))
        return false
    end

    pcall(func)
    return true
end

load_script_from_url("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_Admin_Obf.lua")
