-- [[ This method is OLD, use/see: https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/New_VC_Bypass.lua ]] --

local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
local valid_titles = {
    success = "Success",
    info = "Info",
    warning = "Warning",
    error = "Error"
}

local function format_title(a)
    if typeof(a) ~= "string" then
        return "Info"
    end
    local k = a:lower()
    return valid_titles[k] or "Info"
end

getgenv().notify = getgenv().notify or function(a,b,c)
    local t = format_title(a)
    NotifyLib:External_Notification(t, tostring(b), tonumber(c))
end

local link = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/New_VC_Bypass.lua"
local clip = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

if clip then
    clip(tostring(link))
    notify("Success", "Copied New VC bypass code link to clipboard.", 10)
elseif not clip then
    if writefile then
        writefile("New_VC_Bypass_Link.txt", tostring(link))
        notify("Success", "Saved VC bypass link to Workspace folder.", 10)
    else
        notify("Error", "Unable to copy or save file.", 10)
        return notify("Info", "Link: https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/New_VC_Bypass.lua", 35)
    end
end
