local ok, response = pcall(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/The_Lanes_Loader.lua'))()
end)

if not ok then
    warn("An unexpected error occurred: "..tostring(response))
    return warn("Something unexpected occurred while trying to load from branch: main.")
end
