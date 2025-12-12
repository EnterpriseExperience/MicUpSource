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

load_script("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_Admin_Obf.lua")
