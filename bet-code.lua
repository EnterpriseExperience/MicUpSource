--[[
    ['Current Visual Layout' of this script includes]:
    ------------------------
    A. Updates now a days usually include stabilization, performance and bug fixes.
    B. If you distribute, advertise, etc, this product's source, e.g: using the source on script's you make, you MUST include my credit, otherwise you will be forced to shut it down.
    C. Do not obfuscate my script, as this project is open source and the compatibility will not hold up while obfuscated, since this script is over 6,000+ lines long.
    D. You must abide by the 'User Agreement' and 'Guidelines' when utilizing this script [You can find this in our Discord.]
    E. We are advancing soon to new game's and products.
--]]

wait(0.3)
local vc_service = game:GetService("VoiceChatService")
local enabled_vc = vc_service:IsVoiceEnabledForUserIdAsync(game.Players.LocalPlayer.UserId)
wait(0.5)
-- This is a decent Notification Library, as it includes features such as: 'Warnings', 'Errors', and other useful techniques and functions.
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/rwetyrweyeywy/refs/heads/main/get_notify.lua"))()
-- [] -->> Make sure the script it's self does not get executed more then once, when executed, they will need to click the Re-Execute GUI button to restart the script. <<-- [] --
if SCRIPT_EXECUTED or getgenv().SCRIPT_EXECUTED and not _G.SCRIPT_EXECUTED == true then
    -- I want to keep the 2 notifications, it make's it more easier for observing details without trying to compact it into 1 big title screen.
    Notification.Notify("Heads Up!", "Zacks Easy Hub is already running!", "rbxassetid://93594537601787", {
        Duration = 7.5,       
        Main = {
            Rounding = true,
        }
    });
    wait(0.2)
    Notification.Notify("Notification:", "Try clicking Re-Execute GUI instead.", "rbxassetid://93594537601787", {
        Duration = 7.5,       
        Main = {
            Rounding = true,
        }
    });
    -- Wait 6 seconds so the user has time to see it (unlike waiting like 3 seconds or something).
end
pcall(function() getgenv().SCRIPT_EXECUTED = true end)
wait(0.3)
if enabled_vc == true then
    Notification.Notify("Success!", "Connected with VoiceChat successfully!", "rbxassetid://93594537601787", {
        Duration = 5,       
        Main = {
            Rounding = true,
        }
    });
    print("[Zacks_Easy_Hub_OUTPUT]: "..game.Players.LocalPlayer.Name.." has Voice Chat.")
else
    Notification.Notify("Unable to load.", "VoiceChat is not enabled on this account!", "rbxassetid://93594537601787", {
        Duration = 5,
        Main = {
            Rounding = true,
        }
    });
    wait(0.2)
    Notification.Notify("Heads Up!", "The game will kick you!", "rbxassetid://93594537601787", {
        Duration = 5,
        Main = {
            Rounding = true,
        }
    });
    return 
end

-- These down here are actually quite useful as it also preserves a lot of room to, since defining local variables usually should stay inside the function, because the main gui wrapper, is inside a function, these can be used outside of the function as well.
getgenv().Game = game
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId

getgenv().Service_Wrap = function(serviceName)
    if cloneref then
        return cloneref(getgenv().Game:GetService(serviceName))
    else
        return getgenv().Game:GetService(serviceName)
    end
end

getgenv().randomString = function()
    local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

-- These below this line are being wrapped in the function above (as you can see), essentially making them useful anywhere in the script, local variables but quite more advanced.
getgenv().Players = getgenv().Service_Wrap("Players")
getgenv().ReplicatedStorage = getgenv().Service_Wrap("ReplicatedStorage")
getgenv().StarterPlayer = getgenv().Service_Wrap("StarterPlayer")
getgenv().StarterPack = getgenv().Service_Wrap("StarterPack")
getgenv().Chat = getgenv().Service_Wrap("Chat")
getgenv().Workspace = getgenv().Service_Wrap("Workspace")
getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
getgenv().TeleportService = getgenv().Service_Wrap("TeleportService")
getgenv().TweenService = getgenv().Service_Wrap("TweenService")
getgenv().HttpService = getgenv().Service_Wrap("HttpService")
getgenv().AssetService = getgenv().Service_Wrap("AssetService")
getgenv().MaterialService = getgenv().Service_Wrap("MaterialService")
getgenv().RunService = getgenv().Service_Wrap("RunService")
getgenv().Lighting = getgenv().Service_Wrap("Lighting")
getgenv().MarketplaceService = getgenv().Service_Wrap("MarketplaceService")
getgenv().ReplicatedFirst = getgenv().Service_Wrap("ReplicatedFirst")
getgenv().Teams = getgenv().Service_Wrap("Teams")
getgenv().VoiceChatInternal = getgenv().Service_Wrap("VoiceChatInternal")
getgenv().VoiceChatService = getgenv().Service_Wrap("VoiceChatService")
getgenv().TextChatService = getgenv().Service_Wrap("TextChatService")
getgenv().UserInputService = getgenv().Service_Wrap("UserInputService")
getgenv().StarterGui = getgenv().Service_Wrap("StarterGui")
getgenv().CoreGui = getgenv().Service_Wrap("CoreGui")
getgenv().SoundService = getgenv().Service_Wrap("SoundService")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui")
getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
getgenv().HumanoidRootPart = getgenv().Character:WaitForChild("HumanoidRootPart") or getgenv().Character:FindFirstChild("HumanoidRootPart")
getgenv().Humanoid = getgenv().Character:WaitForChild("Humanoid") or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid")
getgenv().Head = getgenv().Character:WaitForChild("Head") or getgenv().Character:FindFirstChild("Humanoid")
getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
getgenv().httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
-- Don't mind this, I don't actually use this, but it's to make sure 'getgenv().httprequest_Init' can be defined outside and inside the script, since I'm not exactly sure about these types of local variables (non-service local variables).
get_http = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
getgenv().queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
queueteleport = getgenv().queueteleport

-- We can utilize this to teleport back to the same CFrame, as per when the script started, since we need to reset the Character when the script is fully loaded to fix other potential issues.
getgenv().StartedScriptCFrame = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

-- Initialize Character Updater, fixing any issues with Humanoid, HumanoidRootPart, or even if the Character dies and respawns, essentially making sure the Character is always defined correctly.
local function updateCharacterComponents(character)
    warn("Resolving Character problems.")
    getgenv().Character = character
    getgenv().HumanoidRootPart = character:WaitForChild("HumanoidRootPart") or character:FindFirstChild("HumanoidRootPart")
    getgenv().Humanoid = character:WaitForChild("Humanoid") or character:FindFirstChildWhichIsA("Humanoid")
end

-- Update Character Model(s) components, since we need to make sure the live updates are saved correctly (Especially when the Character components are updated as well).
updateCharacterComponents(getgenv().Character)
warn("Updated Character properties.")
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    warn("Fixing Character issues.")
    updateCharacterComponents(newCharacter)
end)

-- Voice chat already loaded check, keeping performance as stable as possible, as sometimes the check can duplicate, so we do not want our performance being unstabilized by 1 singular line of code.
local vc_inter = game:GetService("VoiceChatInternal")
local vc_service = game:GetService("VoiceChatService")

if getgenv().voiceChat_Check then
    warn("Voice Chat already initialized.")
else
    getgenv().voiceChat_Check = true
    local reconnecting = false
    local retryCooldown = 4
    local function onVoiceChatStateChanged(oldState, newState)
        if newState == Enum.VoiceChatState.Ended and not reconnecting then
            reconnecting = true
            task.spawn(function()
                wait(retryCooldown)
                local success, err = pcall(function()
                    vc_service:joinVoice()
                end)
                if not success then
                    warn("Error while rejoining voice chat:", err)
                end
                reconnecting = false
            end)
        end
    end

    vc_inter.StateChanged:Connect(onVoiceChatStateChanged)
end

-- [] -->> Correctly allocate Character's HumanoidRootPart | Essentially correctly loading the BasePart of the Character [Thanks: Infinite Yield] <<-- [] --
function getRoot(char)
    rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end



-- Define alternate functions to be used later, this set's CharacterUseJumpPower in 'game:GetService('StarterPlayer')', to 'True', so we can use JumpPower on Character if needed.
getgenv().StarterPlayer.CharacterUseJumpPower = true
task.wait(.3)

-- [] -->> Check supported functions in the current executor, that are necessary for the script. <<-- [] --
if getgenv().has_checked_funcs then
    print("Functions Checking | True") 
else
    getgenv().checkNecessaryFunctions = function()
        if cloneref then
            print("cloneref [Success]")
        else
            warn("cloneref [Failed]")
        end
        
        if writefile then
            print("writefile [Success]")
        else
            warn("writefile [Failed]")
        end

        if readfile then
            print("readfile [Success]")
        else
            warn("readfile [Failed]")
        end

        if delfile then
            print("delfile [delete-file] [Success]")
        else
            warn("delfile [delete-file] [Failed]")
        end

        if AllClipboards then
            print("setclipboard [Success]")
        else
            warn("setclipboard [Failed]")
        end

        if httprequest_Init then
            print("httprequest [Success]")
        else
            warn("httprequest [Failed]")
        end
    end

    -- Only check if the game is loaded correctly, else, just repeat wait() until the game is loaded, then run said task.
    if getgenv().Game:IsLoaded() then
        getgenv().checkNecessaryFunctions()
        task.wait()
        getgenv().has_checked_funcs = true
    else
        repeat wait() until getgenv().Game:IsLoaded()
        getgenv().checkNecessaryFunctions()
        task.wait()
        getgenv().has_checked_funcs = true
    end
end
wait(0.2)
-- Performance issue fixing start about here, since we are setting different settings for our Lighting, and checking if 'setfpscap' function exists in the current environment/executor, since this is a useful function for performance.
if setfpscap then
    if getgenv().setup_fps_performance then
        warn("Setup for performance has already been ran.")
    else
        setfpscap(999)
        if game:GetService("MaterialService").Use2022Materials == false then
            warn("Setup - MaterialService")
        else
            game:GetService("MaterialService").Use2022Materials = false
        end
        getgenv().Lighting.GlobalShadows = false
        getgenv().Lighting.Brightness = 2
        getgenv().Lighting.Technology = Enum.Technology.Compatibility
        getgenv().Lighting.ClockTime = 12
    end
else
    warn("setfpscap is unsupported, alternating...")
    wait(0.2)
    if game:GetService("MaterialService").Use2022Materials == false then
        warn("Setup - MaterialService")
    else
        game:GetService("MaterialService").Use2022Materials = false
    end
    getgenv().Lighting.GlobalShadows = false
    getgenv().Lighting.Brightness = 2
    getgenv().Lighting.Technology = Enum.Technology.Compatibility
    getgenv().Lighting.ClockTime = 11
end
wait(0.2)
-- [] -->> Check if the selected experience/game is MIC UP | Ensuring they do not run Zacks Easy Hub outside of MIC UP 🔊 or MIC UP 🔊 17+ <<-- [] --
if getgenv().PlaceID == 6884319169 then
    print(tostring(game:GetService("MarketplaceService"):GetProductInfo(6884319169).Name))
elseif getgenv().PlaceID == 15546218972 then
    print(tostring(game:GetService("MarketplaceService"):GetProductInfo(15546218972).Name))
else
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FULLSCREEN_TP_GUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.IgnoreGuiInset = true
    screenGui.Enabled = true
    screenGui.ResetOnSpawn = false
    
    local fullScreenFrame = Instance.new("Frame")
    fullScreenFrame.Size = UDim2.new(1, 0, 1, 0)
    fullScreenFrame.Position = UDim2.new(0, 0, 0, 0)
    fullScreenFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    fullScreenFrame.BorderSizePixel = 0
    fullScreenFrame.Parent = screenGui
    fullScreenFrame.Visible = true
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
    textLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
    textLabel.BackgroundTransparency = 1
    -- Yes, this has changed a ton, and how it checks above has changed as well as the teleporting down below these lines.
    textLabel.Text = "You are now being teleported to MIC UP 🔊, this game is unsupported."
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = fullScreenFrame
    wait(0.7) -- Like waiting 0.7 seconds might actually work, I never usually wait(1), only because the task can be shortened to it's minimum with things like this, but still wait a little bit.
    getgenv().TeleportCheck = false
    getgenv().LocalPlayer.OnTeleport:Connect(function(State)
        if (not getgenv().TeleportCheck) and getgenv().queueteleport then
            getgenv().TeleportCheck = true
            queueteleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta')))()")
        end
    end)
    wait()
    getgenv().TeleportService:Teleport(6884319169, getgenv().LocalPlayer)
end
wait(0.3)
    -- Don't even mess with this dumb shit, the loading screen has been through to much, but keep the checks, since it can run down performance if you remove the loading screen check, and potentially drop frames.
    if getgenv().loading_screen_data then
        print("Already Seen Loading Screen")
    else
        local player = getgenv().LocalPlayer
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = player:WaitForChild("PlayerGui")
        screenGui.IgnoreGuiInset = true
        
        local blurEffect = Instance.new("BlurEffect")
        blurEffect.Parent = game.Lighting
        blurEffect.Size = 20
        
        local loadingFrame = Instance.new("Frame")
        loadingFrame.Size = UDim2.new(1, 0, 1, 0)
        loadingFrame.BackgroundTransparency = 1
        loadingFrame.Position = UDim2.new(0, 0, 0, 0)
        loadingFrame.Parent = screenGui
        
        local image = Instance.new("ImageLabel")
        image.Size = UDim2.new(0.25, 0, 0.25, 0)
        image.Position = UDim2.new(0.5, 0, 0.5, 0)
        image.AnchorPoint = Vector2.new(0.5, 0.5)
        image.Image = "rbxassetid://93594537601787"
        image.BackgroundTransparency = 1
        image.Parent = loadingFrame
        
        local aspectConstraint = Instance.new("UIAspectRatioConstraint")
        aspectConstraint.AspectRatio = 1
        aspectConstraint.Parent = image
        
        local elapsedTime = 0
        local zoomSpeed = 1.2
        local maxSize = 0.35
        local minSize = 0.25
        
        while elapsedTime < 8 do
            local scale = minSize + (math.abs(math.sin(elapsedTime * zoomSpeed)) * (maxSize - minSize))
            image.Size = UDim2.new(scale, 0, scale, 0)
        
            image.Position = UDim2.new(0.5, 0, 0.5, 0)
            
            elapsedTime = elapsedTime + getgenv().RunService.Heartbeat:Wait()
        end
        
        screenGui:Destroy()
        blurEffect:Destroy()
    end
    wait()
    getgenv().loading_screen_data = true
    wait(0.1)
    -- Correctly initialize our Folder we put into Workspace, since we can use this for later in the script as well.
    if getgenv().Workspace:FindFirstChild("PartStorage") then
        print("Already found Folder")
    else
        local NewFolder = Instance.new("Folder")
        NewFolder.Name = "PartStorage"
        NewFolder.Parent = game:GetService("Workspace")
    end

    -- Check our BasePlate, by using a GUI created by the script, to correctly initialize an anti-void measure, which stretches extremely far.
    wait(0.2)
    function do_baseplate_check()
        local screenGui = Instance.new("ScreenGui") 
        screenGui.IgnoreGuiInset = true
        screenGui.Name = "BASEPLATE_LOADING"
        screenGui.Parent = getgenv().LocalPlayer:WaitForChild("PlayerGui")
        
        local fullScreenFrame = Instance.new("Frame")
        fullScreenFrame.Size = UDim2.new(1, 0, 1, 0)
        fullScreenFrame.Position = UDim2.new(0, 0, 0, 0)
        fullScreenFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        fullScreenFrame.BackgroundTransparency = 0.3
        fullScreenFrame.Parent = screenGui
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "LABEL_BASEPLATE"
        textLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
        textLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "Current Status: <font color=\"rgb(255,0,0)\">Frozen</font>\n--------------\n🎇 Zacks Easy Hub 🎇\n----------------------------\nIs creating a Baseplate,\n\nPlease wait until this screen disappears."
        textLabel.RichText = true
        textLabel.TextColor3 = Color3.fromRGB(163, 162, 165)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = fullScreenFrame
        wait(0.2)
        -- Terrain modifying for our BasePlate, yes, I do understand this is very big and freezes the player, fuck you, it's big and works.
        local Terrain = getgenv().Workspace.Terrain

        Terrain:FillBlock(CFrame.new(66, -10, 72.5), Vector3.new(13000, 16, 13000), Enum.Material.Asphalt) -- Go to hell and burn if you think im not using: 'Vector3.new(13000, 16, 13000)' combined with the current Material: 'Asphalt'.
        wait(0.3)
        -- Check if the GUI we created exists, and once the player is not frozen anymore, destroy the GUI and let the player continue unfrozen.
        if getgenv().PlayerGui:FindFirstChild("BASEPLATE_LOADING") then
            local bruh_GUI = getgenv().PlayerGui:FindFirstChild("BASEPLATE_LOADING")
            bruh_GUI:FindFirstChildOfClass("Frame"):FindFirstChildOfClass("TextLabel").Text = "Current Status: <font color=\"rgb(0, 238, 0)\">Not Frozen</font>\n--------------\n🎇 Zacks Easy Hub 🎇\n----------------------------\nEnjoy your anti-void/BasePlate."
            wait(0.7) -- We'll make this slightly faster, just to preserve people's time [I guess.]
            -- Believe me, I still realize I did not need to say they we're unfrozen, but some people aren't the smartest, so fuck you.
            bruh_GUI:Destroy()
        else
            warn("GUI does not exist, skipping...") -- I could have added a check here, but I didn't so, go fist yourself.
        end
        getgenv().passed_baseplate_check = true
    end

    -- Correctly observe if the BasePlate is loaded or has already been loaded, and then continue.
    if getgenv().passed_baseplate_check then
        warn("Baseplate has already been checked.")
    else
        do_baseplate_check()
    end
    task.wait(0.1)
getgenv().start_Script = function()
wait(0.2)
local currentTime = os.time()
local formattedTime = os.date("%I:%M %p", currentTime)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary'))()
-- [] -->> Comment out unnecessary functions, code, etc <<-- [] --
-- Current UI is automatically hidden, shoutout to Rayfield.
-- [] -->> Initialize Library (Rayfield, BRAND NEW!) <<-- [] --
local Window = Rayfield:CreateWindow({
    Name = "🔥 Zacks Easy Hub 🔥 | V6.7.3-C | Emote Keybinds: True",
    LoadingTitle = "Enjoy ruling MIC UP 🔊",
    LoadingSubtitle = "Zacks Easy Hub | Success.",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil,
       FileName = "Zacks Easy Hub"
    },
    -- [] -->> Discord invite feature is neat. <<-- [] --
    Discord = {
       Enabled = true,
       Invite = "VJh3kkYzBn",
       RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
       Title = "False | No Key System",
       Subtitle = "No Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"None"}
    }
})
wait(0.1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if game.Players.LocalPlayer.Name == "L0CKED_1N1" then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        if getgenv().passed_loaded_jobid_joiner then
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            warn("Already loaded job_id joiner.")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/prisonLifeAdminScript/refs/heads/main/file.js'))()
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            wait(0.1)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            getgenv().passed_loaded_jobid_joiner = true
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        warn("Action denied.")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    end
-- Above here is obvious, stop dick riding me.

-- [] -->> Initialize our Tabs and Sections <<-- [] --
local Tab1 = Window:CreateTab("< / Home >", 7733960981)
local Section1 = Tab1:CreateSection("||| Home Section |||")

local Tab11 = Window:CreateTab("< / Booths >", 7733914390)
local Section11 = Tab11:CreateSection("||| Booths Section |||")

local Tab2 = Window:CreateTab("< / Character >", 7743871002)
local Section2 = Tab2:CreateSection("||| Character [1] Section |||")

local Tab13 = Window:CreateTab("< / Players >", 7743871002)
local Section13 = Tab13:CreateSection("||| Character [2] Section |||")

local Tab10 = Window:CreateTab("< / Teleports >", 7733764327)
local Section10 = Tab10:CreateSection("||| Teleports Section |||")

local Tab4 = Window:CreateTab("< / Chat >", 7734021300)
local Section4 = Tab4:CreateSection("||| Chatting Section |||")

local Tab5 = Window:CreateTab("< / Misc >", 7733954760)
local Section5 = Tab5:CreateSection("||| Extras Section |||")

local Tab16 = Window:CreateTab("< / Universal >", 7733954760)
local Section16 = Tab16:CreateSection("||| Universal Section |||")

local Tab17 = Window:CreateTab("< / Animations >", 7733954760)
local Section17 = Tab17:CreateSection("||| Animation Packages Section |||")

local Tab9 = Window:CreateTab("< / Lighting >", 7734068495)
local Section9 = Tab9:CreateSection("||| Lighting Section |||")

local Tab12 = Window:CreateTab("< / Emotes >", 7743871002)
local Section12 = Tab12:CreateSection("||| / Emoting Section |||")

local Tab14 = Window:CreateTab("< / Copy Anim >", 7743871002)
local Section14 = Tab14:CreateSection("||| / Copy Animation Section |||")

local Tab15 = Window:CreateTab("< / UI >", 7734022107)
local Section15 = Tab15:CreateSection("||| / UI Control Section |||")
wait()
getgenv().material_toggle = function(boolean)
    if boolean == true then
        game:GetService("MaterialService").Use2022Materials = true
    elseif boolean == false then
        game:GetService("MaterialService").Use2022Materials = false
    else
        return getgenv().notify("Failed!", "Not a valid boolean toggle/action.", 6.5)
    end
end
wait()
-- Start searching for the 'Game' Folder located in Workspace, and modify they're "Parent" them somewhere else, and the Part 'Teleport' as well, so we are invincible to that platform game where the soccer thing is.
local GameFolder = getgenv().Workspace:FindFirstChild("Game")
local GetTeleportPart = GameFolder and GameFolder:FindFirstChild("Teleport")
local AssetService = game:GetService("AssetService")
local Asset_Service_Duplicate = game:GetService("AssetService")
-- I fixed this function for resetting lighting, and now starts up automatically.
    function resetLightingSettings()
        -- Check it out, let me know what you think.
        local Lighting = getgenv().Lighting
        local SunRays = Lighting:FindFirstChildOfClass("SunRaysEffect")

        Lighting.ClockTime = 14.5
        wait()
        Lighting.Brightness = 3
        wait()
        if not Lighting:FindFirstChildOfClass("Atmosphere") then
            warn("Atmosphere not found, creating...")
            wait(0.1)
            local Atmosphere = Instance.new("Atmosphere")
            Atmosphere.Name = "Atmosphere"
            Atmosphere.Parent = Lighting
            Atmosphere.Density = 0.3
            Atmosphere.Offset = 0.25
            Atmosphere.Color = Color3.fromRGB(199, 199, 199)
            Atmosphere.Decay = Color3.fromRGB(106, 112, 125)
            Atmosphere.Glare = 0
            Atmosphere.Haze = 0
        else
            print("Atmosphere found, continuing...")
            wait(0.1)
            Lighting.Atmosphere.Density = 0.3
            Lighting.Atmosphere.Offset = 0.25
            Lighting.Atmosphere.Color = Color3.fromRGB(199, 199, 199)
            Lighting.Atmosphere.Decay = Color3.fromRGB(106, 112, 125)
            Lighting.Atmosphere.Glare = 0
            Lighting.Atmosphere.Haze = 0
        end
        wait(0.1)
        if not Lighting:FindFirstChildOfClass("Sky") then
            warn("Sky not found, creating...")
            wait(0.1)
            local Sky = Instance.new("Sky")
            Sky.Name = "Sky"
            Sky.Parent = Lighting
            Sky.MoonAngularSize = 11
            Sky.StarCount = 3000
            Sky.SunAngularSize = 11
        else
            print("Sky found, continuing...")
            wait(0.1)
            Lighting.Sky.MoonAngularSize = 11
            Lighting.Sky.StarCount = 3000
            Lighting.Sky.SunAngularSize = 11
        end
        wait(0.1)
        if not Lighting:FindFirstChildOfClass("BloomEffect") then
            warn("Bloom was not found, creating...")
            wait(0.1)
            local Bloom = Instance.new("BloomEffect")
            Bloom.Name = "Bloom"
            Bloom.Parent = Lighting
            Bloom.Intensity = 1
            Bloom.Enabled = true
            Bloom.Size = 24
            Bloom.Threshold = 2
        else
            print("Found Bloom, continuing...")
            wait(0.1)
            Lighting.Bloom.Intensity = 1
            Lighting.Bloom.Enabled = true
            Lighting.Bloom.Size = 24
            Lighting.Bloom.Threshold = 2
        end
        wait(0.1)
        if not Lighting:FindFirstChildOfClass("DepthOfFieldEffect") then
            warn("DepthOfField not found, creating...")
            wait(0.1)
            local DepthOfField = Instance.new("DepthOfFieldEffect")
            DepthOfField.Name = "DepthOfField"
            DepthOfField.Parent = Lighting
            DepthOfField.Enabled = false
            DepthOfField.FarIntensity = 0.1
            DepthOfField.FocusDistance = 0.05
            DepthOfField.InFocusRadius = 30
            DepthOfField.NearIntensity = 0.75
        else
            print("DepthOfField found, continuing...")
            wait(0.1)
            Lighting.DepthOfField.Enabled = false
            Lighting.DepthOfField.FarIntensity = 0.1
            Lighting.DepthOfField.FocusDistance = 0.05
            Lighting.DepthOfField.InFocusRadius = 30
            Lighting.DepthOfField.NearIntensity = 0.75
        end
        wait(0.1)
        if not Lighting:FindFirstChildOfClass("SunRaysEffect") then
            warn("SunRays was not found, creating...")
            wait(0.1)
            local SunRays = Instance.new("SunRaysEffect")
            SunRays.Name = "SunRays"
            SunRays.Parent = Lighting
            SunRays.Enabled = true
            SunRays.Intensity = 0.01
            SunRays.Spread = 0.1
        else
            print("SunRays found, continuing...")
            wait(0.1)
            Lighting.SunRays.Enabled = true
            Lighting.SunRays.Intensity = 0.01
            Lighting.SunRays.Spread = 0.1
        end
    end
    wait()
    getgenv().LocalPlayer.OnTeleport:Connect(function(State)
        if (not getgenv().TeleportCheck) and getgenv().queueteleport then
            getgenv().TeleportCheck = true
            queueteleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta')))()")
        end
    end)
    wait(0.3)
    resetLightingSettings() -- Call it right here, since we have the upperhand on client shit.
    wait(0.2)
    -- Now we can move past Lighting and focus on that 'Game' and 'Teleport' shit again, and correctly check if the Part 'Teleport' is moved to 'AssetService' (checking if it exists in the Folder still), so we don't run into errors.
    if not GetTeleportPart then
        warn("Part: Teleport = nil | false | null")
    else
        if GameFolder:FindFirstChild("Teleport") then
            local TeleportPart = GameFolder:FindFirstChild("Teleport")
            TeleportPart.Parent = AssetService
        end
    end
    wait(0.3)
    -- Initialize our main notify function, sometimes interferes with Infinite Yield notify function, since it's the same name and shit, idk how that shit works.
        getgenv().notify = function(title, content, duration)
            Rayfield:Notify({
                Title = tostring(title),
                Content = tostring(content),
                Duration = tonumber(duration),
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function() print("...") end
                    },
                },
            })
        end
    -- This just got updated recently to correctly verify if our keybind to mute/unmute is correctly initialized, since last time I tried it without this layer, it started muting x2, and x3 (If they would use Re-Execute GUI/Script, creating layers.)
    if getgenv().muted_self_keybind then
        print("Already loaded mute keybind.")
    else
        local UserInputService = game:GetService("UserInputService")
        
        local Audio_Device_Input = LocalPlayer.AudioDeviceInput

        local isMuted = false
        Audio_Device_Input.Muted = isMuted

        local function onInputBegan(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.RightControl then
                isMuted = not isMuted
                Audio_Device_Input.Muted = isMuted
                if isMuted then
                    getgenv().notify("Success!", "Muted Microphone", 3)
                else
                    getgenv().notify("Success!", "Unmuted Microphone", 3)
                end
            end
        end
        getgenv().UserInputService.InputBegan:Connect(onInputBegan)
        getgenv().muted_self_keybind = true
    end
    wait(0.3)
-- Don't mind this, did it because of Infinite Yield, ok?
local TeleportService = game:GetService("TeleportService")
-- And this to.
PlaceId, JobId = game.PlaceId, game.JobId
-- As well with this, piss off.
queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local TeleportCheck = false -- Fuck you and your teleport check. 'Oh, why didn't he use getgenv().TeleportCheck(), instead of a regular local variable, like with the no configuration script', I will eliminate you from this world.
getgenv().LocalPlayer.OnTeleport:Connect(function(State)
    if (not TeleportCheck) and queueteleport then
        TeleportCheck = true
        queueteleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta')))()") -- K*ll yourself, stop waiting.
    end
end)
    -- [] -->> Set up emote/rizz configuration automatically. <<-- [] --
    local UserInputService = game:GetService("UserInputService")

    getgenv().emoteSpeed = getgenv().emoteSpeed or 1
    getgenv().speedUpSpeed = getgenv().speedUpSpeed or 4
    getgenv().slowDownSpeed = getgenv().slowDownSpeed or 0.1
    getgenv().freezeEmotes = getgenv().freezeEmotes or false
    getgenv().isReversed = getgenv().isReversed or false
    
    getgenv().keybindActions = getgenv().keybindActions or {
        [Enum.KeyCode.One] = 13071993910,
        [Enum.KeyCode.Two] = 14901371589,
        [Enum.KeyCode.Three] = 73683655527605,
        [Enum.KeyCode.Four] = 5230615437,
        [Enum.KeyCode.Five] = 5104377791,
        [Enum.KeyCode.Six] = 13694139364,
        [Enum.KeyCode.Seven] = 7466047578,
        [Enum.KeyCode.Eight] = 13823339506,
        [Enum.KeyCode.Nine] = 3576823880,
        [Enum.KeyCode.Zero] = 15506503658,
        [Enum.KeyCode.Q] = "SlowDown",
        [Enum.KeyCode.E] = "SpeedUp",
        [Enum.KeyCode.V] = "Freeze",
        [Enum.KeyCode.X] = "NormalSpeed",
        [Enum.KeyCode.F] = "Reverse"
    }

    local function adjustEmoteSpeed()
        if getgenv().Humanoid then
            for _, track in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
                track:AdjustSpeed(getgenv().emoteSpeed)
            end
        end
    end

    local function reverseEmotes()
        if getgenv().Humanoid then
            for _, track in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
                track:AdjustSpeed(-1)
            end
        end
    end

    local function playNormalSpeed()
        if getgenv().Humanoid then
            for _, track in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
                track:AdjustSpeed(1)
            end
        end
    end

    local function playEmote(emoteId)
        local character = getgenv().Character
        local humanoid = getgenv().Humanoid
        if humanoid then
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
            wait()
            local animTrack = humanoid:PlayEmoteAndGetAnimTrackById(emoteId)
    
            if animTrack and typeof(animTrack) == "Instance" then
                animTrack:AdjustSpeed(getgenv().emoteSpeed)
            end
        else
            warn("Humanoid not found in Character!")
        end
    end

    local function handleKeybind(action)
        if type(action) == "number" then
            playEmote(action)
        elseif action == "SlowDown" then
            getgenv().emoteSpeed = getgenv().slowDownSpeed
            adjustEmoteSpeed()
        elseif action == "SpeedUp" then
            getgenv().emoteSpeed = getgenv().speedUpSpeed
            adjustEmoteSpeed()
        elseif action == "Freeze" then
            getgenv().emoteSpeed = 0
            adjustEmoteSpeed()
            getgenv().freezeEmotes = true
        elseif action == "NormalSpeed" then
            getgenv().emoteSpeed = 1
            adjustEmoteSpeed()
            getgenv().freezeEmotes = false
        elseif action == "Reverse" then
            if getgenv().isReversed then
                playNormalSpeed()
            else
                reverseEmotes()
            end
            getgenv().isReversed = not getgenv().isReversed
        end
    end

    getgenv().keybindConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        local action = getgenv().keybindActions[input.KeyCode]
        if action then
            handleKeybind(action)
        end
    end)
    wait(0.2)
    getgenv().scriptEnabled = true
wait(0.4)
local TeleportService = game:GetService("TeleportService")

PlaceId, JobId = game.PlaceId, game.JobId

wait(0.1)
if getgenv().AntiAfkScript or getgenv().OtherAntiAfk then
    print("AntiAFK Scripts have already been pre-loaded from last session | skipping...")
    wait(0.2)
    warn("000 >>> 000 >>> nil")
else
    local GC = getconnections or get_signal_cons

    if GC then
        getgenv().AntiAfkScript = true
        wait()
        for i, v in pairs(GC(game:GetService("Players").LocalPlayer.Idled)) do
            if v["Disable"] then
                v["Disable"](v)
                wait()
                Rayfield:Notify({
                    Title = "Idled!",
                    Content = "Disabling Event...",
                    Duration = 7,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function() print("...") end
                        },
                    },
                })
            end
        end
    else
        getgenv().OtherAntiAfk = true
        wait(0.1)
        warn("Your executor does not support 'getconnections'! Using VirtualUser for Anti-AFK.")
        wait()
        Rayfield:Notify({
            Title = "Starting...",
            Content = "AntiAFK (2) is loading with VirtualUser...",
            Duration = 7,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "Okay!",
                    Callback = function() print("...") end
                },
            },
        })

        local VirtualUser = game:GetService("VirtualUser")
        wait()
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            Rayfield:Notify({
                Title = "Idled!",
                Content = "Clicking button...",
                Duration = 7,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function() print("...") end
                    },
                },
            })
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            wait(0.1)
            Rayfield:Notify({
                Title = "Success!",
                Content = "Clicked Button (Anti-Idle)",
                Duration = 7,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function() print("...") end
                    },
                },
            })
        end)
    end

    wait(0.4)
    if getgenv().AntiAfkScript then
        Rayfield:Notify({
            Title = "Success!",
            Content = "AntiAFK (1) has loaded!",
            Duration = 7,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "Okay!",
                    Callback = function() print("...") end
                },
            },
        })
    elseif getgenv().OtherAntiAfk then
        Rayfield:Notify({
            Title = "Success!",
            Content = "AntiAFK (2) has loaded.",
            Duration = 7,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "Okay!",
                    Callback = function() print("...") end
                },
            },
        })
    end

    if getgenv().AntiAfkScript == false and getgenv().OtherAntiAfk == false then
        Rayfield:Notify({
            Title = "Failed!",
            Content = "Could not load any Anti-AFK Scripts.",
            Duration = 7,
            Image = 4483362458,
            Actions = {
                Ignore = {
                    Name = "Okay!",
                    Callback = function() print("...") end
                },
            },
        })
    end
end
wait(0.3)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
wait(0.5)
if getgenv().scripts_init then
    warn("Scripts we're already modified.")
else
    Rayfield:Notify({
        Title = "Modifying Scripts...",
        Content = "We are modifying game scripts, hold on...",
        Duration = 7,
        Image = 4483362458,
        Actions = {
           Ignore = {
            Name = "Okay!",
            Callback = function()
                print("...")
            end
           },
        },
    })
    wait(0.2)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("Script") and descendant.Name == "Kill" then
            local parent = descendant.Parent
            local touchInterest = parent:FindFirstChild("TouchInterest")
            if touchInterest then
                touchInterest:Destroy()
            end
            descendant:Destroy()
        end
    end
    wait(0.1)
    getgenv().scripts_init = true
    wait(0.2)
    if getgenv().scripts_init then
        Rayfield:Notify({
            Title = "Success!",
            Content = "We modified necessary scripts, enjoy.",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
    end
end
wait()

local player = getgenv().LocalPlayer

getgenv().whitelist = {}

getgenv().ownerWhitelist = {
    "L0CKED_1N1",
    "Laylay_4kla"
}
wait()
-- [] -->> Functions <<-- [] --
local cmdp = game.Players
local cmdlp = cmdp.LocalPlayer

function findplr(args, tbl)
    if tbl == nil then
        local tbl = game:GetService("Players"):GetPlayers()
        if args == "me" then
            return cmdlp
        elseif args == "random" then 
            return tbl[math.random(1,#tbl)]
        elseif args == "new" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.AccountAge < 30 and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "old" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.AccountAge > 30 and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "bacon" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair") and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "friend" then
            local vAges = {} 
            for _, v in pairs(tbl) do
                if v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            if #vAges > 0 then
                return vAges[math.random(1, #vAges)]
            else
                return nil
            end
        elseif args == "notfriend" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if not v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "ally" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.Team == cmdlp.Team and v ~= cmdlp then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "enemy" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v.Team ~= cmdlp.Team then
                    vAges[#vAges+1] = v
                end
            end
            return vAges[math.random(1,#vAges)]
        elseif args == "near" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v and v ~= cmdlp and v.Character and cmdlp.Character then
                    local vRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                    local cmdlpRootPart = cmdlp.Character:FindFirstChild("HumanoidRootPart")
                    if vRootPart and cmdlpRootPart then
                        local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
                        if distance < 30 then
                            vAges[#vAges + 1] = v
                        end
                    end
                end
            end
            return vAges[math.random(1, #vAges)]
        elseif args == "far" then
            local vAges = {} 
            for _,v in pairs(tbl) do
                if v ~= cmdlp then
                    local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - cmdlp.Character.HumanoidRootPart.Position).magnitude
                    if math > 30 then
                        vAges[#vAges+1] = v
                    end
                end
            end
            return vAges[math.random(1,#vAges)]
        else 
            for _,v in pairs(tbl) do
                if v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower()) then
                    return v
                end
            end
        end
    else
        for _, plr in pairs(tbl) do
            if plr.UserName:lower():find(args:lower()) or plr.DisplayName:lower():find(args:lower()) then
                return plr
            end
        end
    end
end
wait()
function isNumber(str)
    if tonumber(str) ~= nil then
        return true
    end
end
wait()
getgenv().notify = function(title, content, duration, image, level)
    if not image then
        image = tonumber(4483362458)
    end

    if not duration then
        duration = tonumber(6)
    end

    if not title then
        title = "Notification: "
    end

    if not content then
        content = "DEFAULT_MESSAGE_CONTENT"
    end

    if not level or level == 0 then
        title = "Notification:"
    end

    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(duration),
        Image = 4483362458,
        Actions = {
            Ignore = {
            Name = "Alright",
            Callback = function()
                print("...")
            end
            },
        },
    })
end
wait(0.2)
for _, model in pairs(workspace:GetDescendants()) do
    if model:IsA("Model") and model.Name == "AvatarUI" then
        local parent_to = game:GetService("Workspace"):FindFirstChild("PartStorage")
        model.Parent = parent_to
        if model.Parent == parent_to then
            print("True - AvatarUI [Avatar-Screen = 1/single]")
        else
            warn("False - AvatarUI [Unable to identify location./nil] = nil")
        end
    end
end

local StallClaimToggle = Tab11:CreateToggle({
Name = "Claim Any Booth",
CurrentValue = false,
Flag = "StallClaimToggle",
Callback = function(claimAnyBooth)
    if claimAnyBooth then
        getgenv().isToggled = true

        local Folder = getgenv().Workspace.Booth

        local stalls = {
            Folder:FindFirstChild("Booth01"),
            Folder:FindFirstChild("Booth02"),
            Folder:FindFirstChild("Booth03"),
            Folder:FindFirstChild("Booth04"),
            Folder:FindFirstChild("Booth05")
        }

        getgenv().connections = {}

        local function setupProximityPrompt(stall)
            local ProximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
            if ProximityPrompt then
                local function enforceSettings()
                    if getgenv().isToggled then
                        ProximityPrompt.Enabled = true
                        ProximityPrompt.ClickablePrompt = true
                        ProximityPrompt.MaxActivationDistance = 15
                        ProximityPrompt.RequiresLineOfSight = false
                        ProximityPrompt.HoldDuration = 0
                    else
                        ProximityPrompt.Enabled = true
                        ProximityPrompt.ClickablePrompt = true
                        ProximityPrompt.MaxActivationDistance = 10
                        ProximityPrompt.RequiresLineOfSight = true
                        ProximityPrompt.HoldDuration = 1
                    end
                end

                enforceSettings()

                getgenv().connections[ProximityPrompt] = {
                    ProximityPrompt:GetPropertyChangedSignal("Enabled"):Connect(enforceSettings),
                    ProximityPrompt:GetPropertyChangedSignal("ClickablePrompt"):Connect(enforceSettings),
                    ProximityPrompt:GetPropertyChangedSignal("MaxActivationDistance"):Connect(enforceSettings),
                    ProximityPrompt:GetPropertyChangedSignal("RequiresLineOfSight"):Connect(enforceSettings),
                    ProximityPrompt:GetPropertyChangedSignal("HoldDuration"):Connect(enforceSettings)
                }
            end
        end

        for _, stall in ipairs(stalls) do
            if stall then
                setupProximityPrompt(stall)
            end
        end
    else
        getgenv().isToggled = false

        local Folder = getgenv().Workspace.Booth
        
        local stalls = {
            Folder:FindFirstChild("Booth01"),
            Folder:FindFirstChild("Booth02"),
            Folder:FindFirstChild("Booth03"),
            Folder:FindFirstChild("Booth04"),
            Folder:FindFirstChild("Booth05")
        }
        
        for _, stall in ipairs(stalls) do
            if stall then
                local ProximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
                if ProximityPrompt then
                    ProximityPrompt.Enabled = true
                    ProximityPrompt.ClickablePrompt = true
                    ProximityPrompt.MaxActivationDistance = 10
                    ProximityPrompt.RequiresLineOfSight = true
                    ProximityPrompt.HoldDuration = 1
        
                    if getgenv().connections[ProximityPrompt] then
                        for _, conn in ipairs(getgenv().connections[ProximityPrompt]) do
                            conn:Disconnect()
                        end
                        getgenv().connections[ProximityPrompt] = nil
                    end
                end
            end
        end            
    end
end,})

local FixGlitchedScreenBooth = Tab11:CreateButton({
Name = "Fix Glitched Booth Screen (GUI)",
Callback = function()
    for i = 1, 1000 do
        getgenv().ReplicatedStorage:WaitForChild("DeleteBoothOwnership"):FireServer()
    end
    wait(1.2)
    if getgenv().PlayerGui:FindFirstChild("Booth") then
        for _, v in pairs(game.Players.LocalPlayer:FindFirstChild("PlayerGui"):GetChildren()) do
            if v:IsA("ScreenGui") and v.Name == "Booth" then
                print("Found GUI: "..tostring(v.Name)..", Removing...")
                wait(0.1)
                v:Destroy()
            end
        end
    else
        warn(".. - nil")
    end
end,})

local claimRandomBooth = Tab11:CreateButton({
Name = "Claim Random Booth",
Callback = function()
    getgenv().notify("Note:", "Make sure you are not invisible when doing this!", 6.5)
    task.wait(0.2)
    
    local Folder = getgenv().Workspace:FindFirstChild("Booth")
    local Character = getgenv().Character
    
    local function getStall()
        for _, v in pairs(Folder:GetChildren()) do
            local usernameGui = v:FindFirstChild("Username") and v.Username:FindFirstChild("BillboardGui")
            if usernameGui and usernameGui.TextLabel.Text == "Owned by: " .. tostring(LocalPlayer.Name) then
                return v
            end
        end
        return nil
    end
    
    local plr_booth = getStall()
    
    if plr_booth then
        return 
    end
    
    local OldCF = getgenv().HumanoidRootPart.CFrame
    
    local stalls = {
        Folder:FindFirstChild("Booth01"),
        Folder:FindFirstChild("Booth02"),
        Folder:FindFirstChild("Booth03"),
        Folder:FindFirstChild("Booth04"),
        Folder:FindFirstChild("Booth05")
    }
    
    local function setupProximityPrompt(stall)
        if stall then
            local activatePart = stall:FindFirstChild("Activate")
            if activatePart then
                local ProximityPrompt = activatePart:FindFirstChildOfClass("ProximityPrompt")
                if ProximityPrompt then
                    ProximityPrompt.Enabled = true
                    ProximityPrompt.ClickablePrompt = true
                    ProximityPrompt.MaxActivationDistance = 15
                    ProximityPrompt.RequiresLineOfSight = false
                    ProximityPrompt.HoldDuration = 0
                end
            end
        end
    end
    
    local function Claim_A_Booth()
        local OldCF = getgenv().HumanoidRootPart.CFrame
    
        local plr_booth = getStall()
        if plr_booth then
            return
        end

        local stall = stalls[math.random(1, #stalls)]
        if stall then
            setupProximityPrompt(stall)
            task.wait(0.1)

            Character:PivotTo(stall:GetPivot())
            task.wait(0.3)
    
            local ProximityPrompt = stall:FindFirstChild("Activate") and stall.Activate:FindFirstChildOfClass("ProximityPrompt")
            if ProximityPrompt then
                fireproximityprompt(ProximityPrompt)
            end
    
            task.wait(0.2)
    
            local args = {
                [1] = "",
                [2] = "Gray",
                [3] = "SourceSans"
            }
            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))

            task.wait(0.2)
            getgenv().HumanoidRootPart.CFrame = OldCF
            task.wait(0.1)

            plr_booth = getStall()
            if plr_booth then
                return
            end
        end
    end

    local stall = stalls[math.random(1, #stalls)]
    setupProximityPrompt(stall)
    task.wait(0.3)
    Claim_A_Booth()    
end,})

local TPOwnerBruh = Tab1:CreateButton({
Name = "Teleport To: Owner Of Script",
Callback = function()
    local OwnerName = "L0CKED_1N1"
    if not game.Players:FindFirstChild(OwnerName) then return warn("Owner not found!") end

    if game.Players:FindFirstChild(OwnerName) then
        print("Owner Found! Teleporting...")
        task.wait()
        local OwnerOfScript = game.Players:FindFirstChild(OwnerName)
        getgenv().Character:PivotTo(OwnerOfScript.Character:GetPivot())
        task.wait(.5)
        print("Teleported To Script Owner!")
    else
        return 
    end
end,})

local ViewOwnerBruh = Tab1:CreateToggle({
Name = "View: Owner Of Script",
CurrentValue = false,
Flag = "viewOwner",
Callback = function(viewingOwner)
    if viewingOwner then
        getgenv().spectateOwner = true
        local OwnerName = "L0CKED_1N1"
        local Workspace = getgenv().Workspace
        local Camera = Workspace:FindFirstChild("Camera")
        if not getgenv().Players:FindFirstChild(OwnerName) then return warn("Owner not found!") end
    
        if game.Players:FindFirstChild(OwnerName) then
            print("Owner Found! Viewing...")
            task.wait()
            local OwnerOfScript = game.Players:FindFirstChild(OwnerName)
            local Owner_Char = OwnerOfScript.Character
            Camera.CameraSubject = Owner_Char
        else
            return 
        end
    else
        local Workspace = getgenv().Workspace
        local Camera = Workspace:FindFirstChild("Camera")

        getgenv().spectateOwner = false
        wait(0.2)
        Camera.CameraSubject = getgenv().Character
    end
end,})

local coloredBooth = Tab11:CreateToggle({
Name = "Booth Color Changer (FE)",
CurrentValue = false,
Flag = "moveColoredBooth",
Callback = function(boothColors)
    if boothColors then
        local fontsList = {
            "DenkOne",
            "GrenzeGotisch",
            "SourceSans",
            "Creepster",
        }
    
        local function pickRandomFont()
            local randomIndex = math.random(1, #fontsList)
            return fontsList[randomIndex]
        end

        getgenv().lmao_colors = true
        while getgenv().lmao_colors == true do
        wait(0.2)
            local args = {
                [1] = "",
                [2] = "Teal",
                [3] = tostring(pickRandomFont())
            }

            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Red",
                [3] = tostring(pickRandomFont())
            }

            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Gray",
                [3] = tostring(pickRandomFont())
            }

            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Cinder",
                [3] = tostring(pickRandomFont())
            }
            
            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Lace",
                [3] = tostring(pickRandomFont())
            }
            
            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Sun",
                [3] = tostring(pickRandomFont())
            }
            
            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Teal",
                [3] = tostring(pickRandomFont())
            }
            
            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
        end
    else
        getgenv().lmao_colors = false
    end
end,})

local ClaimPlrsBooth = Tab11:CreateInput({
Name = "Claim Someones Booth",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Callback = function(takeThatBooth)
    local Folder = game:GetService("Workspace").Booth
    local find_plr_func_booth = findplr(takeThatBooth)

    getgenv().notify("Note:", "Make sure you are not invisible when doing this!", 6.5)
    task.wait(.2)

    if find_plr_func_booth == getgenv().LocalPlayer then
        getgenv().notify("Success:", "Removed your booth. [LocalPlayer]", 6.5)
        return game:GetService("ReplicatedStorage"):WaitForChild("DeleteBoothOwnership"):FireServer()
    end

    if not find_plr_func_booth then
        return getgenv().notify("Error:", "Player not found!", 6.5)
    end

    local function getStall()
        for i,v in pairs(game:GetService("Workspace").Booth:GetChildren()) do
            if v ~= getgenv().LocalPlayer and v:FindFirstChild("Username"):FindFirstChild("BillboardGui").TextLabel.Text == "Owned by: "..tostring(find_plr_func_booth) then
                return v
            end
        end
        return nil
    end

    local plr_booth = getStall()

    if not plr_booth and find_plr_func_booth then
        return notify("Error:", tostring(find_plr_func_booth).." does not own a booth!", 5)
    end

    local Folder = game:GetService("Workspace").Booth

    local OldCF = getgenv().HumanoidRootPart.CFrame

    local stalls = {
        Folder:FindFirstChild("Booth01"),
        Folder:FindFirstChild("Booth02"),
        Folder:FindFirstChild("Booth03"),
        Folder:FindFirstChild("Booth04"),
        Folder:FindFirstChild("Booth05")
    }

    local function setupProximityPrompt(stall)
        local ProximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
        if ProximityPrompt and not ProximityPrompt.Enabled then
            ProximityPrompt.Enabled = true
            ProximityPrompt.ClickablePrompt = true
            ProximityPrompt.MaxActivationDistance = 15
            ProximityPrompt.RequiresLineOfSight = false
            ProximityPrompt.HoldDuration = 0
        end
    end

    local function Claim_A_Booth()
        local OldCF = getgenv().HumanoidRootPart.CFrame

        local stall = plr_booth
        local ProximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
        if stall then
            setupProximityPrompt(stall)
            wait(0.3)
            Character:PivotTo(stall:GetPivot())
            wait(0.3)
            fireproximityprompt(ProximityPrompt)
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Gray",
                [3] = "SourceSans"
            }
            
            game:GetService("ReplicatedStorage"):WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.2)
            getgenv().HumanoidRootPart.CFrame = OldCF
            wait(0.2)
            notify("Success:", "Claimed "..tostring(find_plr_func_booth).."'s Booth!", 6.5)
            wait(.1)
            if plr_booth then
                return 
            end
        end
    end
    wait(0.2)
    local stall = plr_booth
    setupProximityPrompt(stall)
    wait(0.3)
    Claim_A_Booth()
end,})

local unclaimPlrBooth = Tab11:CreateInput({
Name = "Unclaim A Booth",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Callback = function(unclaimTheirBooth)
    local Folder = getgenv().Workspace.Booth
    local find_plr_func_booth = findplr(unclaimTheirBooth)

    notify("Note:", "Make sure you are not invisible when doing this!", 6.5)
    task.wait(.2)

    if find_plr_func_booth == getgenv().LocalPlayer then
        notify("Success:", "Removed your booth. [LocalPlayer]", 6.5)
        return getgenv().ReplicatedStorage:WaitForChild("DeleteBoothOwnership"):FireServer()
    end

    if not find_plr_func_booth then
        return notify("error:", "Player not found!", 6.5)
    end

    local function getStall()
        for i,v in pairs(getgenv().Workspace.Booth:GetChildren()) do
            if v ~= getgenv().LocalPlayer and v:FindFirstChild("Username"):FindFirstChild("BillboardGui").TextLabel.Text == "Owned by: "..tostring(find_plr_func_booth) then
                return v
            end
        end
        return nil
    end

    local plr_booth = getStall()

    if not plr_booth and find_plr_func_booth then
        return notify("Error", tostring(find_plr_func_booth).." does not own a booth!", 5, 3)
    end

    local Folder = getgenv().Workspace.Booth

    local OldCF = getgenv().HumanoidRootPart.CFrame

    local stalls = {
        Folder:FindFirstChild("Booth01"),
        Folder:FindFirstChild("Booth02"),
        Folder:FindFirstChild("Booth03"),
        Folder:FindFirstChild("Booth04"),
        Folder:FindFirstChild("Booth05")
    }

    local function setupProximityPrompt(stall)
        local ProximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
        if ProximityPrompt and not ProximityPrompt.Enabled then
            ProximityPrompt.Enabled = true
            ProximityPrompt.ClickablePrompt = true
            ProximityPrompt.MaxActivationDistance = 15
            ProximityPrompt.RequiresLineOfSight = false
            ProximityPrompt.HoldDuration = 0
        end
    end

    local function Claim_A_Booth()
        local OldCF = getgenv().HumanoidRootPart.CFrame

        local stall = plr_booth
        local ProximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
        if stall then
            setupProximityPrompt(stall)
            wait(0.3)
            getgenv().Character:PivotTo(stall:GetPivot())
            wait(0.3)
            fireproximityprompt(ProximityPrompt)
            wait(0.2)
            local args = {
                [1] = "",
                [2] = "Gray",
                [3] = "SourceSans"
            }
            
            getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            wait(0.6)
            getgenv().ReplicatedStorage:WaitForChild("DeleteBoothOwnership"):FireServer()
            wait(0.2)
            getgenv().HumanoidRootPart.CFrame = OldCF
            wait(0.2)
            notify("Success:", "Unclaimed "..tostring(find_plr_func_booth).."'s Booth!", 6.5)
            if plr_booth then
                return 
            end
        end
    end
    wait(0.2)
    local stall = plr_booth
    setupProximityPrompt(stall)
    wait(0.3)
    Claim_A_Booth()
end,})

local FrozenChar = Tab2:CreateToggle({
Name = "Freeze Your Character",
CurrentValue = false,
Flag = "AntiMovement",
Callback = function(hasFrozenChar)
    if hasFrozenChar then
        local Character = getgenv().Character
        local Workspace_Service = game:GetService("Workspace") or workspace or cloneref(game:GetService("Workspace"))
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart", true) or Workspace_Service:WaitForChild(LocalPlayer.Name):WaitForChild("HumanoidRootPart", 999)
        getgenv().FreezingChar = true
        if Character and HumanoidRootPart or Character:FindFirstChild("HuamnoidRootPart") then
            if getgenv().FreezingChar == true then
                HumanoidRootPart.Anchored = true
            end
        else
            getgenv().FreezingChar = false
        end
    else
        local Character = getgenv().Character
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("HumanoidRootPart", true)
        if Character and HumanoidRootPart or Character:FindFirstChild("HumanoidRootPart") then
            getgenv().FreezingChar = false
            wait(0.2)
            HumanoidRootPart.Anchored = false
        else
            getgenv().FreezingChar = false
        end
    end
end,})

local WriteOutBooth = Tab11:CreateInput({
Name = "Booth Typing Effect (FE)",
CurrentValue = "",
PlaceholderText = "Text To Type",
RemoveTextAfterFocusLost = true,
Flag = "TypingTextAuto",
Callback = function(TypeEffectStall)
    local Booth_Remote = getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText")

    local function typeText(remote, text, typingSpeed)
        local currentText = ""
        for i = 1, #text do
            currentText = string.sub(text, 1, i)
            local color = "Red"
            local font = "SourceSans"
            remote:FireServer(currentText, color, font)
            remote:FireServer(currentText, color, font)
            remote:FireServer(currentText, color, font)
            task.wait(typingSpeed)
        end
    end

    local textToType = tostring(TypeEffectStall)
    local typingSpeed = 1.1
    typeText(Booth_Remote, textToType, typingSpeed)
end,})
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    if get_http then loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/AdonisAdminFE/refs/heads/main/coding_stuff.lua')))() else warn("Unsupported") end

local ToggleBadWords = Tab11:CreateToggle({
Name = "Bypassed Booth (FE)",
CurrentValue = false,
Flag = "ToggleBadWords",
Callback = function(Cussing)
    if Cussing then
        getgenv().Cuss = true
        while getgenv().Cuss == true do
        wait(0.5)
            local function getStall()
                for i,v in pairs(getgenv().Workspace.Booth:GetChildren()) do
                    if v.User.SurfaceGui.ImageLabel.Image == "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(getgenv().LocalPlayer.UserId).."&width=420&height=420&format=png" then
                        return v
                    end
                end
                return nil
            end
            
            local Booth_Remote = getgenv().ReplicatedStorage:FindFirstChild("UpdateBoothText")
            
            local MyStall = getStall()

            if not MyStall or MyStall == nil then
                getgenv().Cuss = false
                return Rayfield:Notify({
                    Title = "Error: No Booth",
                    Content = "You don't own a booth!",
                    Duration = 7,
                    Image = 4483362458,
                    Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("...")
                        end
                    },
                    },
                })
            end
        
            local colorsList = {
                "Teal",
                "Gray",
                "Red",
            }
        
            local function pickRandomColor()
                local randomIndex = math.random(1, #colorsList)
                return colorsList[randomIndex]
            end
        
            local wordsList = {
                "ɓ׀丅ㄈȟ",
                "ӻȕㄈҟ",
                "ㄈȕ冂丅",
                "ȿȴȕ丅",
                "ҟҟҟ",
                "ŗȇ丅ẳŗȡ",
                "ώȇȇȡ",
                "ώȟόŗȇ",
                "ㄈȕɱ",
                "ɓ׀ɠ ẳȿȿ",
            }
        
            local function pickRandomWord()
                local randomIndex = math.random(1, #wordsList)
                return wordsList[randomIndex]
            end
        
            local fontsList = {
                "DenkOne",
                "GrenzeGotisch",
                "SourceSans"    
            }
        
            local function pickRandomFont()
                local randomIndex = math.random(1, #fontsList)
                return fontsList[randomIndex]
            end
            wait(0.4)
            local args = {
                [1] = tostring(pickRandomWord()),
                [2] = tostring(pickRandomColor()),
                [3] = tostring(pickRandomFont())
            }
                
            Booth_Remote:FireServer(unpack(args))
        end
    else
        getgenv().Cuss = false
    end
end,})

getgenv().bangSpeed = 1
wait(0.1)
local bangPlrSpeedSlider = Tab13:CreateSlider({
Name = "Bang Player Speed",
Range = {0.1, 110},
Increment = 0.1,
Suffix = "",
CurrentValue = 1,
Flag = "bangThatPlayerSpeed",
Callback = function(speedOfPlayerBang)
    getgenv().bangSpeed = tonumber(speedOfPlayerBang)
end,})

local BangPlrInputBox = Tab13:CreateInput({
Name = "Bang Player (Bypassed)",
PlaceholderText = "Target Here",
RemoveTextAfterFocusLost = true,
Callback = function(bangPlayerTarget)
    local real_target_bang = findplr(bangPlayerTarget)
    if getgenv().bangScriptLoaded then
        return 
    end
    
    getgenv().bangScriptLoaded = true
    
    getgenv().enabled = true
    getgenv().unload = false
    wait(0.1)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = Character:WaitForChild("Humanoid")
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    local VOID_THRESHOLD = -50
    local UNVOID_THRESHOLD = 0
    
    local function noSitFunc()
        if humanoid and humanoid.Sit then
            humanoid.Sit = false
        end
    end
    
    local function setupNoSit()
        if getgenv().noSit then getgenv().noSit:Disconnect() end
        if getgenv().nositDied then getgenv().nositDied:Disconnect() end
        
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if humanoid then
            getgenv().noSit = humanoid:GetPropertyChangedSignal("Sit"):Connect(noSitFunc)
        end
        
        local function nositDiedFunc()
            repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            setupNoSit()
        end
        
        getgenv().nositDied = LocalPlayer.CharacterAdded:Connect(nositDiedFunc)
    end
    
    local function antiVoidLoop()
        if HumanoidRootPart then
            if HumanoidRootPart.Position.Y < VOID_THRESHOLD then
                HumanoidRootPart.Anchored = true
            elseif HumanoidRootPart.Position.Y > UNVOID_THRESHOLD then
                HumanoidRootPart.Anchored = false
            end
        end
    end
    
    local function NoclipLoop()
        if getgenv().Clip == false and LocalPlayer.Character then
            for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= getgenv().floatName then
                    child.CanCollide = false
                end
            end
        elseif getgenv().Clip == true and LocalPlayer.Character then
            for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= getgenv().floatName then
                    child.CanCollide = true
                end
            end
        end
    end
    
    local function cleanupConnections()
        if getgenv().noSit then getgenv().noSit:Disconnect() end
        if getgenv().nositDied then getgenv().nositDied:Disconnect() end
        if getgenv().bangDied then getgenv().bangDied:Disconnect() end
        if getgenv().bangLoop then getgenv().bangLoop:Disconnect() end
        if getgenv().Noclipping then getgenv().Noclipping:Disconnect() end
        if getgenv().antiVoidLoop then getgenv().antiVoidLoop:Disconnect() end
    end
    
    function bang_plr_bypass(target)
        cleanupConnections()
    
        local RunService = game:GetService("RunService")
    
        setupNoSit()
    
        getgenv().Clip = false
        getgenv().enabled = true
        getgenv().Noclipping = RunService.Stepped:Connect(NoclipLoop)
        getgenv().antiVoidLoop = RunService.Stepped:Connect(antiVoidLoop)
    
        local bangAnim = Instance.new("Animation")
        bangAnim.AnimationId = "rbxassetid://5918726674"
        local bang = humanoid:LoadAnimation(bangAnim)

        getgenv().bangAnimation = bang
        
        bang:Play(0.1, 1, 1)
    
        getgenv().bangLoop = RunService.Stepped:Connect(function()
            if getgenv().unload then
                cleanupConnections()
                bang:Stop()
                bangAnim:Destroy()
                getgenv().bangScriptLoaded = false
                return 
            end
    
            if bang.Speed ~= getgenv().bangSpeed then
                bang:AdjustSpeed(getgenv().bangSpeed)
            end
    
            if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local bang_char_root = target.Character:FindFirstChild("HumanoidRootPart")
                HumanoidRootPart.CFrame = bang_char_root.CFrame * CFrame.new(0, 0, 1.1)
            end
        end)

        getgenv().bangDied = humanoid.Died:Connect(function()
            bang:Stop()
            bangAnim:Destroy()
            cleanupConnections()
        end)
    end    

    bang_plr_bypass(real_target_bang)
end,})
wait(0.1)
local UnloadBangPlr = Tab13:CreateButton({
Name = "Unload Bang Script (Stop Script)",
Callback = function()
    local function cleanupConnections()
        if getgenv().noSit then getgenv().noSit:Disconnect() end
        if getgenv().nositDied then getgenv().nositDied:Disconnect() end
        if getgenv().bangDied then getgenv().bangDied:Disconnect() end
        if getgenv().bangLoop then getgenv().bangLoop:Disconnect() end
        if getgenv().Noclipping then getgenv().Noclipping:Disconnect() end
        if getgenv().antiVoidLoop then getgenv().antiVoidLoop:Disconnect() end
    
        if getgenv().bangAnimation then
            getgenv().bangAnimation:Stop()
            getgenv().bangAnimation:Destroy()
            getgenv().bangAnimation = nil
        end
    end
    
    function bang_plr_bypass_off()
        cleanupConnections()

        if HumanoidRootPart then
            HumanoidRootPart.Anchored = false
        end

        getgenv().bangActive = false
        getgenv().Clip = true
        getgenv().bangScriptLoaded = false
        getgenv().unload = nil
        getgenv().enabled = false
    end

    wait(0.1)
    bang_plr_bypass_off()    
end,})

local SpinCharBox = Tab2:CreateInput({
Name = "Spin Character",
PlaceholderText = "Speed",
RemoveTextAfterFocusLost = true,
Callback = function(getSpinSpeed)
    local HumanoidRootPart = getgenv().HumanoidRootPart
    local spinSpeed = tonumber(getSpinSpeed)
    if spinSpeed and spinSpeed <= 145 then
        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = HumanoidRootPart
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
    elseif spinSpeed and spinSpeed >= 145 then
        Rayfield:Notify({
            Title = "[OUTPUT]: Limit Reached.",
            Content = "Lowered your speed, because you will be flung.",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
        wait(0.2)
        if not getgenv().HumanoidRootPart:FindFirstChild("Spinning") then
            local Spin = Instance.new("BodyAngularVelocity")
            Spin.Name = "Spinning"
            Spin.Parent = HumanoidRootPart
            Spin.MaxTorque = Vector3.new(0, math.huge, 0)
            Spin.AngularVelocity = Vector3.new(0,145,0)
        else
            HumanoidRootPart:FindFirstChild("Spinning").AngularVelocity = Vector3.new(0,145,0)
        end
    elseif spinSpeed <= 145 and getgenv().HumanoidRootPart:FindFirstChild("Spinning") then
        Rayfield:Notify({
            Title = "[OUTPUT]: Already Spinning",
            Content = "Updated speed instead, detected edited spin.",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
        wait(0.3)
        getgenv().HumanoidRootPart:FindFirstChild("Spinning").AngularVelocity = Vector3.new(0,spinSpeed,0)
    end
end,})

local UnspinNow = Tab2:CreateButton({
Name = "Unspin",
Callback = function()
    for i,v in pairs(getgenv().HumanoidRootPart:GetChildren()) do
        if v.Name == "Spinning" then
            v:Destroy()
        end
    end
end,})

local SubmitNoteBypassToggle = Tab5:CreateToggle({
Name = "Submit Note Bypass",
CurrentValue = false,
Flag = "BypassNoteBoard",
Callback = function(theNote)     
    local Replicated_Storage = getgenv().ReplicatedStorage
    local Submit_Note_Remote = Replicated_Storage:FindFirstChild("SubmitTextEvent") or Replicated_Storage:WaitForChild("SubmitTextEvent")

    if theNote then
        getgenv().crazyNote = true
        while getgenv().crazyNote == true do
        wait(1.5)
            local args = {
                [1] = "ɓ׀丅ㄈȟ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ӻȕㄈҟ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ㄈȕ冂丅"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ȿȴȕ丅"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ҟҟҟ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ŗȇ丅ẳŗȡ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ώȇȇȡ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ώȟόŗȇ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ㄈȕɱ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
            local args = {
                [1] = "ɓ׀ɠ ẳȿȿ"
            }
    
            Submit_Note_Remote:FireServer(unpack(args))
            task.wait(1)
        end
    else
        getgenv().crazyNote = false
    end
end,})

local SubmitNoteInputBypassText = Tab5:CreateInput({
Name = "Note Bypass Input",
PlaceholderText = "Note",
RemoveTextAfterFocusLost = true,
Callback = function(noteToBypass)
    local Replicated_Storage = getgenv().ReplicatedStorage
    local Submit_Note_Remote = Replicated_Storage:FindFirstChild("SubmitTextEvent") or Replicated_Storage:WaitForChild("SubmitTextEvent")

    local letters = {
        set1 = {
            ["a"] = "ẳ",
            ["b"] = "ɓ",
            ["c"] = "ㄈ",
            ["d"] = "ȡ",
            ["e"] = "ȇ",
            ["f"] = "ӻ",
            ["g"] = "ɠ",
            ["h"] = "ȟ",
            ["i"] = "׀",
            ["j"] = "ǰ",
            ["k"] = "ҟ",
            ["l"] = "ȴ",
            ["m"] = "ɱ",
            ["n"] = "冂",
            ["o"] = "ό",
            ["p"] = "ᵽ",
            ["q"] = "ԛ",
            ["r"] = "ŗ",
            ["s"] = "ȿ",
            ["t"] = "丅",
            ["u"] = "ȕ",
            ["v"] = "ѵ",
            ["w"] = "ώ",
            ["x"] = "ẍ",
            ["y"] = "ƴ",
            ["z"] = "ȥ",
        }
    }

    local numbers = {
        set1 = {
            ["0"] = "Θ",
            ["1"] = "Ɩ",
            ["2"] = "ƻ",
            ["3"] = "Ʒ",
            ["4"] = "🄅",
            ["5"] = "Ƽ",
            ["6"] = "Ϭ",
            ["7"] = "🄈",
            ["8"] = "Ȣ",
            ["9"] = "Θ",
        }
    }

    local function convert(text)
        local letters_set = letters["set1"]
        local numbers_set = numbers["set1"]
    
        local converted = ""
        for i = 1, #text do
            local char = text:sub(i, i)
            local lower_char = char:lower()
    
            if char:match("%a") then
                if lettersBypass then
                    converted = converted .. char
                else
                    converted = converted .. (letters_set[lower_char] or char)
                end
            elseif char:match("%d") then
                if numbersBypass then
                    converted = converted .. char
                else
                    converted = converted .. (numbers_set[char] or char)
                end
            else
                converted = converted .. char
            end
        end
        return converted
    end
    task.wait(.7)
    local function send_Remote(msg)
        local Replicated_Storage = getgenv().ReplicatedStorage
        local Submit_Note_Remote = Replicated_Storage:FindFirstChild("SubmitTextEvent") or Replicated_Storage:WaitForChild("SubmitTextEvent")

        local args = {
            [1] = tostring(convert(msg))
        }

        Submit_Note_Remote:FireServer(unpack(args))
    end
    
    send_Remote(noteToBypass)
end,})

local DeletePlrBooth = Tab11:CreateButton({
Name = "Delete Current Booth",
Callback = function()
    for i = 1, 80 do
        getgenv().ReplicatedStorage:WaitForChild("DeleteBoothOwnership"):FireServer()
    end
end,})

local AutoReclaimToggle = Tab11:CreateToggle({
Name = "Anti Booth Stealer",
CurrentValue = false,
Flag = "NoStealingBooths",
Callback = function(boothStolen)
    if boothStolen then
        getgenv().AutoClaimEnabled = true
        getgenv().Booth = nil
        getgenv().OwnershipConnection = nil
        
        function notify(title, content, duration)
            Rayfield:Notify({
                Title = tostring(title or "Notification:"),
                Content = tostring(content or "DEFAULT_MESSAGE_CONTENT"),
                Duration = tonumber(duration or 6),
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Alright",
                        Callback = function()
                            print("...")
                        end
                    },
                },
            })
        end
        
        local function getStall()
            for _, v in pairs(game:GetService("Workspace").Booth:GetChildren()) do
                if v.Username.BillboardGui.TextLabel.Text == "Owned by: " .. LocalPlayer.Name then
                    return v
                end
            end
            return nil
        end
        
        local function claimStall(stall)
            if stall then
                local OldCF = Character:WaitForChild("HumanoidRootPart").CFrame
        
                repeat
                    Character:PivotTo(stall:GetPivot() + Vector3.new(0, 3, 0))
                    task.wait(0.5)
        
                    local proximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
                    if proximityPrompt then
                        fireproximityprompt(proximityPrompt, 25)
                    else
                        warn("ProximityPrompt not found for the booth!")
                    end
        
                    task.wait(0.5)
                until stall.Username.BillboardGui.TextLabel.Text == "Owned by: " .. LocalPlayer.Name or not getgenv().AutoClaimEnabled

                Character:PivotTo(OldCF)
            end
        end
        
        local function monitorOwnership()
            while getgenv().AutoClaimEnabled == true do
                local stall = getStall()
                if stall then
                    getgenv().Booth = stall
        
                    if not getgenv().OwnershipConnection then
                        getgenv().OwnershipConnection = stall.Username.BillboardGui.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
                            if stall.Username.BillboardGui.TextLabel.Text ~= "Owned by: " .. LocalPlayer.Name then
                                claimStall(stall)
                            end
                        end)
                    end
                else
                    print("Reclaiming Stall...")
                    local newStall = getStall()
                    claimStall(newStall)
                end
        
                task.wait(0.6)
            end

            if getgenv().OwnershipConnection then
                getgenv().OwnershipConnection:Disconnect()
                getgenv().OwnershipConnection = nil
            end
        end
        
        local plr_booth = getStall()
        if plr_booth and getgenv().AutoClaimEnabled == true then
            monitorOwnership()
        else
            getgenv().notify("Error:", "No booth found! Claim a booth and toggle this on.", 7.5)
        end        
    else
        getgenv().AutoClaimEnabled = false
        if getgenv().OwnershipConnection then
            getgenv().OwnershipConnection:Disconnect()
        else
            warn("Event not connected.")
        end
        getgenv().OwnershipConnection = nil
        getgenv().Booth = nil
    end
end,})

local RemoveBooths = Tab11:CreateButton({
Name = "Remove Every Booth",
Callback = function()
    local Players = getgenv().Players
    local LocalPlayer = getgenv().LocalPlayer
    local Character = getgenv().Character
    local Humanoid = getgenv().Humanoid
    local HumanoidRootPart = getgenv().HumanoidRootPart
    local GetWorkspace = game:GetService("Workspace")
    local Folder = GetWorkspace:FindFirstChild("Booth") or GetWorkspace:WaitForChild("Booth") 
    
    local Rep_Storage = game:GetService("ReplicatedStorage") or cloneref(game:GetService("ReplicatedStorage")) or game.ReplicatedStorage or game:FindService("ReplicatedStorage")
    local Delete_Booth_Remote = Rep_Storage:FindFirstChild("DeleteBoothOwnership") or Rep_Storage:WaitForChild("DeleteBoothOwnership")
    
    
    local OldCF = getgenv().HumanoidRootPart.CFrame

    local function fireAndUnclaimStall(stall)
        local proximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
        if proximityPrompt then
            proximityPrompt.ClickablePrompt = true
            proximityPrompt.RequiresLineOfSight = false
            proximityPrompt.HoldDuration = 0
            proximityPrompt.MaxActivationDistance = 17
            wait(0.3)
            Character:PivotTo(stall:GetPivot())
            wait(0.1)
            Character:WaitForChild("HumanoidRootPart").Anchored = true
            wait(0.3)
            fireproximityprompt(proximityPrompt, 10)
            wait(0.5)
            Delete_Booth_Remote:FireServer()
            wait(0.2)
            Character:WaitForChild("HumanoidRootPart").Anchored = false
        elseif not proximityPrompt then
            return Rayfield:Notify({
                Title = "Failed!",
                Content = "ProximityPrompt does not exist!",
                Duration = 7,
                Image = 4483362458,
                Actions = {
                   Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("...")
                    end
                   },
                },
            })
        end
    end

    local function unclaimStalls()
        for _, stall in pairs(Folder:GetChildren()) do
            if stall and stall:FindFirstChild("Activate") then
                wait(0.3)
                fireAndUnclaimStall(stall)
            end
        end
    end
    
    wait(0.2)
    unclaimStalls()
    wait(0.3)
    Character:WaitForChild("HumanoidRootPart").CFrame = OldCF
    wait(0.2)
    print("Finished Unclaiming ALL Booths.")
end,})

local CopyAnimAddUser = Tab14:CreateInput({
Name = "Add CopyAnim Whitelist",
PlaceholderText = "User",
RemoveTextAfterFocusLost = true,
Callback = function(thisUserGet)
    local Players = getgenv().Players
    local LocalPlayer = getgenv().LocalPlayer
    local Character = getgenv().Character
    local Humanoid = getgenv().Humanoid
    local HumanoidRootPart = getgenv().HumanoidRootPart
    local Workspace = game:GetService("Workspace")
    getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}

    local bruhUser = findplr(thisUserGet)
    
    local function addPlayerToGlobalTable(player)
        
        if next(getgenv().singlePlayerTable) then
            return Rayfield:Notify({
                Title = "Error: Player Limit",
                Content = "Only one player can be added at a time!",
                Duration = 7,
                Image = 4483362458,
                Actions = {
                   Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("...")
                    end
                   },
                },
            })
        else
            getgenv().singlePlayerTable[player.Name] = player
            wait(0.2)
            if getgenv().singlePlayerTable[player.Name] then
                Rayfield:Notify({
                    Title = "Success!",
                    Content = tostring(player.Name)..", was added to Whitelist!",
                    Duration = 7,
                    Image = 4483362458,
                    Actions = {
                       Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("...")
                        end
                       },
                    },
                })
            elseif not Players[player.Name] then
                return Rayfield:Notify({
                    Title = "[ERROR]: 0",
                    Content = tostring(player)..", does not exist!",
                    Duration = 7,
                    Image = 4483362458,
                    Actions = {
                       Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("...")
                        end
                       },
                    },
                })
            elseif bruhUser == getgenv().LocalPlayer.Name then
                return Rayfield:Notify({
                    Title = "[ERROR]: ?",
                    Content = "You cannot add yourself!",
                    Duration = 7,
                    Image = 4483362458,
                    Actions = {
                       Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("...")
                        end
                       },
                    },
                })
            end
        end
    end
    
    addPlayerToGlobalTable(bruhUser)
end,})

local RemoveCopyAnimPlr = Tab14:CreateInput({
Name = "Remove CopyAnim Whitelist",
PlaceholderText = "User",
RemoveTextAfterFocusLost = true,
Callback = function(CopyAnimPlr)
    local Players = getgenv().Players
    local LocalPlayer = getgenv().LocalPlayer
    local Character = getgenv().Character
    local Humanoid = getgenv().Humanoid
    local HumanoidRootPart = getgenv().HumanoidRootPart
    local Workspace = game:GetService("Workspace")

    getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}

    local dawgUser = findplr(CopyAnimPlr)
    
    local function removePlayerFromGlobalTable(player)
        if getgenv().singlePlayerTable[player.Name] then
            getgenv().singlePlayerTable[player.Name] = nil
            wait(0.2)
            if getgenv().singlePlayerTable[player.Name] == nil then
                Rayfield:Notify({
                    Title = "Success!",
                    Content = tostring(player.Name)..", was removed from the CopyAnim Whitelist!",
                    Duration = 7,
                    Image = 4483362458,
                    Actions = {
                       Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("...")
                        end
                       },
                    },
                })
            else
                return Rayfield:Notify({
                    Title = "[ERROR]: 0",
                    Content = tostring(player)..", does not exist!",
                    Duration = 7,
                    Image = 4483362458,
                    Actions = {
                       Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("...")
                        end
                       },
                    },
                })
            end
        else
            return Rayfield:Notify({
                Title = "[ERROR]: -1",
                Content = tostring(player.Name)..", was not found in CopyAnim Whitelist!",
                Duration = 7,
                Image = 4483362458,
                Actions = {
                   Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("...")
                    end
                   },
                },
            })
        end
    end
    
    removePlayerFromGlobalTable(dawgUser)
end,})

local CopyAnimButtonPlr = Tab14:CreateButton({
Name = "CopyAnim Whitelisted Plr",
Callback = function()
    local Players = getgenv().Players
    local LocalPlayer = getgenv().LocalPlayer
    local Character = getgenv().Character
    local Humanoid = getgenv().Humanoid
    local HumanoidRootPart = getgenv().HumanoidRootPart
    local Workspace = game:GetService("Workspace")
    getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}

    function getThatPlr()
        
        for i, v in pairs(Players:GetChildren()) do
            if getgenv().singlePlayerTable[v.Name] then
                return v
            end
        end
        return nil
    end
    
    local thePlayer = getThatPlr()
    
    if thePlayer then
        print("Found Player: "..tostring(thePlayer.Name)..", DisplayName: "..tostring(thePlayer.DisplayName)..", UserID: "..tostring(thePlayer.UserId))
    else
        return Rayfield:Notify({
            Title = "[ERROR]: 0",
            Content = "Player was not found!",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
    end

    local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
    local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
    
    if thePlayer then
        print("Found Player: "..tostring(thePlayer.Name)..", DisplayName: "..tostring(thePlayer.DisplayName)..", UserID: "..tostring(thePlayer.UserId))
    else
        return Rayfield:Notify({
            Title = "[ERROR]: 0",
            Content = "Player was not found!",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
    end
    
    for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
        animTrack:Stop()
    end
    
    local getTheirChar = thePlayer.Character or thePlayer.CharacterAdded:Wait()
    local theirHumanoid = getTheirChar:FindFirstChildWhichIsA('Humanoid') or getTheirChar:WaitForChild('Humanoid')
    
    local function copyAnimations()
        for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
    
        for _, animTrack in pairs(theirHumanoid:GetPlayingAnimationTracks()) do
            if not string.find(animTrack.Animation.AnimationId, "507768375") then
                local copiedAnim = Humanoid:LoadAnimation(animTrack.Animation)
                copiedAnim:Play(0.1, 1, animTrack.Speed)
                copiedAnim.TimePosition = animTrack.TimePosition
    
                task.spawn(function()
                    animTrack.Stopped:Wait()
                    copiedAnim:Stop()
                    copiedAnim:Destroy()
                end)
            end
        end
    end
    
    copyAnimations()
end,})

local LoopCopyTheEmotePlr = Tab14:CreateToggle({
Name = "Loop CopyAnim Whitelist Plr",
CurrentValue = false,
Flag = "DoCopyAnimLoop",
Callback = function(getLoopCopyAnim)
    if getLoopCopyAnim then
        getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}
        
        function getThatPlr()
            for i, v in pairs(Players:GetChildren()) do
                if getgenv().singlePlayerTable[v.Name] then
                    return v
                end
            end
            return nil
        end
        
        local thePlayer = getThatPlr()
        local Character = getgenv().Character
        local Humanoid = getgenv().Humanoid
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local LocalPlayer = getgenv().LocalPlayer
        local player = LocalPlayer
        local Players = getgenv().Players
        local Workspace = getgenv().Workspace
        
        if thePlayer then
            print("Found Player: "..tostring(thePlayer.Name)..", DisplayName: "..tostring(thePlayer.DisplayName)..", UserID: "..tostring(thePlayer.UserId))
        else
            getgenv().copyAllWhitelistedAnims = false
            return getgenv().notify("Error:", "Player was not found!", 7)
        end

        local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
        local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
        
        if thePlayer then
            print("Found Player: "..tostring(thePlayer.Name)..", DisplayName: "..tostring(thePlayer.DisplayName)..", UserID: "..tostring(thePlayer.UserId))
        else
            return getgenv().notify("Error:", "Player not found!", 7)
        end
        
        for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        
        local getTheirChar = thePlayer.Character or thePlayer.CharacterAdded:Wait()
        local theirHumanoid = getTheirChar:FindFirstChildWhichIsA('Humanoid') or getTheirChar:WaitForChild('Humanoid')
        
        local function getAnimationScript(character)
            return character:FindFirstChild("Animate")
        end
        
        local defaultAnimationScript = getAnimationScript(Character)
        
        local function copyAnimations()
            if defaultAnimationScript then
                defaultAnimationScript.Disabled = true
            end
        
            for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
                animTrack:Stop()
            end
        
            for _, animTrack in pairs(theirHumanoid:GetPlayingAnimationTracks()) do
                if not string.find(animTrack.Animation.AnimationId, "507768375") then
                    local copiedAnim = Humanoid:LoadAnimation(animTrack.Animation)
                    copiedAnim:Play(0.1, 1, animTrack.Speed)
                    copiedAnim.TimePosition = animTrack.TimePosition
        
                    task.spawn(function()
                        animTrack.Stopped:Wait()
                        copiedAnim:Stop()
                        copiedAnim:Destroy()
                    end)
                end
            end
        end
        
        getgenv().copyAllWhitelistedAnims = true
        while getgenv().copyAllWhitelistedAnims == true do
        wait(0.1)
            copyAnimations()
        end
    else
        local thePlayer = getThatPlr()
        local Character = getgenv().Character
        local Humanoid = getgenv().Humanoid
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local LocalPlayer = getgenv().LocalPlayer
        local player = LocalPlayer
        local Players = getgenv().Players
        local Workspace = getgenv().Workspace
        
        getgenv().copyAllWhitelistedAnims = false
        wait()
        
        repeat wait() until getgenv().copyAllWhitelistedAnims == false
        wait(0.3)
        
        getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}
        function getThatPlr()
            for i, v in pairs(Players:GetChildren()) do
                if getgenv().singlePlayerTable[v.Name] then
                    return v
                end
            end
            return nil
        end
        
        local thePlayer = getThatPlr()
        
        if thePlayer then
            print("Found Player: " .. tostring(thePlayer.Name) .. ", DisplayName: " .. tostring(thePlayer.DisplayName) .. ", UserID: " .. tostring(thePlayer.UserId))
        else
            return getgenv().notify("Error:", "Player was not found!", 7)
        end
        
        local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
        local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
        local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
        
        if thePlayer then
            print("Found Player: " .. tostring(thePlayer.Name) .. ", DisplayName: " .. tostring(thePlayer.DisplayName) .. ", UserID: " .. tostring(thePlayer.UserId))
        else
            return getgenv().notify("Error:", "Player was not found!", 7)
        end
        
        for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        
        local function stopAnimations()
            for _, animTrack in pairs(GetTheirHumanoid:GetPlayingAnimationTracks()) do
                animTrack:Stop()
            end
        end
        
        for i = 1, 10 do
            stopAnimations()
        end

        local function resetDefaultAnimations()
            local animateScript = Character:FindFirstChild("Animate")
            if animateScript then
                animateScript.Disabled = true
                wait(0.1)
                animateScript.Disabled = false
            end
        end
        
        resetDefaultAnimations()        
    end
end,})

local StopTheEmotes = Tab14:CreateButton({
Name = "Stop All Emotes",
Callback = function()
    getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}

    function getThatPlr()
        
        for i, v in pairs(Players:GetChildren()) do
            if getgenv().singlePlayerTable[v.Name] then
                return v
            end
        end
        return nil
    end

    local thePlayer = getThatPlr()
    
    if thePlayer then
        print("Found Player: "..tostring(thePlayer.Name)..", DisplayName: "..tostring(thePlayer.DisplayName)..", UserID: "..tostring(thePlayer.UserId))
    else
        return Rayfield:Notify({
            Title = "[ERROR]: 0",
            Content = "Player was not found!",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
    end
    
    local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
    local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
    local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
    
    if thePlayer then
        print("Found Player: "..tostring(thePlayer.Name)..", DisplayName: "..tostring(thePlayer.DisplayName)..", UserID: "..tostring(thePlayer.UserId))
    else
        return Rayfield:Notify({
            Title = "[ERROR]: 0",
            Content = "Player was not found!",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
    end
    
    for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
        animTrack:Stop()
    end
    
    local getTheirChar = thePlayer.Character or thePlayer.CharacterAdded:Wait()
    local theirHumanoid = getTheirChar:FindFirstChildWhichIsA('Humanoid') or getTheirChar:WaitForChild('Humanoid')
    
    local function stopAnimations()
        for _, animTrack in pairs(theirHumanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
    end
    
    stopAnimations()
end,})

local PlayEmoteWithIDNum = Tab12:CreateInput({
Name = "Play Emote (ID)",
PlaceholderText = "Enter ID",
RemoveTextAfterFocusLost = true,
Callback = function(getTheIDForEmote)
    local getNumberID = tonumber(getTheIDForEmote) or getTheIDForEmote
    local Humanoid = getgenv().Humanoid
    
    local succ, err = pcall(function()
        Humanoid:PlayEmoteAndGetAnimTrackById(getNumberID)
    end)
    
    if succ then
        Humanoid:PlayEmoteAndGetAnimTrackById(getNumberID)
    else
        return Rayfield:Notify({
            Title = "Error:",
            Content = tostring(err),
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
    end
end,})

local StopTheEmotes = Tab12:CreateButton({
Name = "Stop Emoting",
Callback = function()
    local Humanoid = getgenv().Humanoid

    for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
        animTrack:Stop()
    end
end,})

local quickAvChange = Tab13:CreateToggle({
Name = "Change Avatar Quick [WILL Lag!⚠️]",
CurrentValue = false,
Flag = "quickAvChange",
Callback = function(quickAv)
    if quickAv then
        local players = game:GetService("Players")
        getgenv().ava_switch = true

        local usernames = {
            "DenisDaily",
            "ItsFunneh",
            "Flamingo",
            "KreekCraft",
            "GamingWithKev",
            "RussoTalks",
            "Tofuu",
            "Sketch",
            "AshleytheUnicorn",
            "TanqR",
            "LeahAshe",
            "Thinknoodles",
            "iamSanna",
            "FGTEEV",
            "ZacharyZaxor",
            "Builderman",
            "Roblox",
            "Minitoon",
            "Asimo3089",
            "Badcc",
            "Callmehbob",
            "Loleris",
            "Beeism",
            "MeganPlays",
            "ChadAlly",
            "AussieVixen",
            "Thinknoodles",
            "GDad",
            "SuperShiftery",
            "SimplyBlox",
            "MeganPlays",
            "GoldenGlove",
            "TeraBrite",
        }

        local function gatherCurrentPlayers()
            
            for _, player in ipairs(players:GetPlayers()) do
                table.insert(usernames, player.Name)
            end
        end

        gatherCurrentPlayers()

        while getgenv().ava_switch == true do
            wait()
            for _, username in ipairs(usernames) do
                local args = {
                    [1] = username
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("ModifyUsername"):FireServer(unpack(args))
            end
        end
    else
        getgenv().ava_switch = false
        wait(0.3)
        local args = {
            [1] = tostring(getgenv().LocalPlayer.Name)
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("ModifyUsername"):FireServer(unpack(args))
    end
end,})

local AutoChangingBooth = Tab11:CreateToggle({
Name = "Quick Changing Booth",
CurrentValue = false,
Flag = "ChangingBoothFast",
Callback = function(crazy)
    local Replicated_Storage = game:GetService("ReplicatedStorage") or cloneref(game:GetService("ReplicatedStorage")) or game.ReplicatedStorage or game:FindService("ReplicatedStorage")
    local Booth_Remote = Replicated_Storage:FindFirstChild("UpdateBoothText") or Replicated_Storage:WaitForChild("UpdateBoothText")

    local function getStall()
        for i,v in pairs(game:GetService("Workspace").Booth:GetChildren()) do
            if v.User.SurfaceGui.ImageLabel.Image == "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(getgenv().LocalPlayer.UserId).."&width=420&height=420&format=png" then
                return v
            end
        end
        return nil
    end

    function notify(title, content, time)
        Rayfield:Notify({
            Title = tostring(title),
            Content = tostring(content),
            Duration = tonumber(time),
            Image = 4483362458,
            Actions = {
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
            },
            },
        })
    end
    
    if crazy then
        wait()
        local Stall = getStall()
        
        if not Stall then
            return notify("Error:", "You do not own a Booth, claim one!", 6)
        end

        local write_words = {
            "Zacks Easy Hub [WINNING]!",
            "Join: VJh3kkYzBn",
            "Zacks Easy Hub [WE UP]!",
            "Zacks Easy Hub V6, POWERFUL!",
            "Powering Automation | Scripting",
            "Zacks Easy Hub | WE OP!",
            "Zacks Easy Hub | V6-BETA",
            "Zacks Easy Hub | WE SIGMA",
            "BEST FREE SCRIPT RN!",
            "WE ARE TAKING OVER, JOIN US!",
            "IF YOU DONT JOIN, YOUR NOT SIGMA"
        }

        local function select_words()
            local randomIndex = math.random(1, #write_words)
            return write_words[randomIndex]
        end

        local booth_colors = {
            "Teal",
            "Gray",
            "Red",
        }

        local function color_selector()
            local randomIndex = math.random(1, #booth_colors)
            return booth_colors[randomIndex]
        end

        local booth_fonts = {
            "DenkOne",
            "GrenzeGotisch",
            "SourceSans"    
        }

        local function font_selector()
            local randomIndex = math.random(1, #booth_fonts)
            return booth_fonts[randomIndex]
        end
        
        getgenv().Auto = true
        while getgenv().Auto == true do
        wait()
            local args = {
                [1] = tostring(select_words()),
                [2] = tostring(color_selector()),
                [3] = tostring(font_selector())
            }
                    
            Booth_Remote:FireServer(unpack(args))
        end
    else
        getgenv().Auto = false
    end
end,})

local GraphicsEnhancer = Tab16:CreateButton({
Name = "Graphics Enhancer",
Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/PublicScriptsOnRobloxExploiting/refs/heads/main/GraphicsEnhancer.lua"))()
end,})

local CtrlClickTP = Tab16:CreateToggle({
Name = "Ctrl Click-TP (Hold CTRL and Click)",
CurrentValue = false,
Flag = "CtrlClickTPConnection",
Callback = function(toggleConnectionClickTP)
    if toggleConnectionClickTP then
        if getgenv().TeleportConnection then getgenv().TeleportConnection:Disconnect() end

        local UIS = game:GetService("UserInputService")
        local Player = game.Players.LocalPlayer
        local Mouse = Player:GetMouse()

        function GetCharacter()
            return Player.Character
        end

        function Teleport(pos)
            local Char = GetCharacter()
            if Char then
                Char:MoveTo(pos)
            end
        end

        getgenv().TeleportConnection = UIS.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                Teleport(Mouse.Hit.p)
            end
        end)
    else
        if getgenv().TeleportConnection then
            getgenv().TeleportConnection:Disconnect()
            getgenv().TeleportConnection = nil
        end
    end
end,})

local Backflips = Tab16:CreateButton({
Name = "Backflips (FE)",
Callback = function()
    local ver = "2.15"
    local scriptname = "feFlip"

    local FrontflipKey = Enum.KeyCode.Z
    local BackflipKey = Enum.KeyCode.X
    local AirjumpKey = Enum.KeyCode.C

    local ca = game:GetService("ContextActionService")
    local zeezy = getgenv().LocalPlayer
    local Humanoid = getgenv().Humanoid
    local h = 0.0174533
    local antigrav

    function zeezyFrontflip(act,inp,obj)
        if inp == Enum.UserInputState.Begin then
            getgenv().Humanoid:ChangeState("Jumping")
            wait()
            getgenv().Humanoid.Sit = true
            for i = 1,360 do 
                delay(i/720,function()
                    getgenv().Humanoid.Sit = true
                    getgenv().HumanoidRootPart.CFrame = getgenv().HumanoidRootPart.CFrame * CFrame.Angles(-h,0,0)
                end)
            end
            wait(0.55)
            getgenv().Humanoid.Sit = false
        end
    end

    function zeezyBackflip(act,inp,obj)
        if inp == Enum.UserInputState.Begin then
            getgenv().Humanoid:ChangeState("Jumping")
            wait()
            getgenv().Humanoid.Sit = true
            for i = 1,360 do
                delay(i/720,function()
                    getgenv().Humanoid.Sit = true
                    getgenv().HumanoidRootPart.CFrame = getgenv().HumanoidRootPart.CFrame * CFrame.Angles(h,0,0)
                end)
            end
            wait(0.55)
            getgenv().Humanoid.Sit = false
        end
    end

    function zeezyAirjump(act,inp,obj)
        if inp == Enum.UserInputState.Begin then
            getgenv().Humanoid:ChangeState("Seated")
            wait()
            getgenv().Humanoid:ChangeState("Jumping")	
        end
    end

    ca:BindAction("zeezyFrontflip",zeezyFrontflip,false,FrontflipKey)
    ca:BindAction("zeezyBackflip",zeezyBackflip,false,BackflipKey)
    ca:BindAction("zeezyAirjump",zeezyAirjump,false,AirjumpKey)

    local notifSound = Instance.new("Sound",workspace)
    notifSound.PlaybackSpeed = 1.5
    notifSound.Volume = 0.25
    notifSound.SoundId = "rbxassetid://170765130"
    notifSound.PlayOnRemove = true
    notifSound:Destroy()
    game.StarterGui:SetCore("SendNotification", {Title = "feFlip", Text = "FE Flip loaded successfully!", Icon = "rbxassetid://505845268", Duration = 8, Button1 = "Okay"})
end,})

local InfJumpDoFunc = Tab16:CreateToggle({
Name = "Infinite Jump",
CurrentValue = false,
Flag = "ConnectionInfiJump",
Callback = function(infJumpConnect)
    if infJumpConnect then
        local Player = game:GetService('Players').LocalPlayer
        local UIS = game:GetService('UserInputService')
        
        _G.JumpHeight = 50
        
        function Action(Object, Function)
            if Object ~= nil then
                Function(Object)
            end
        end
        
        getgenv().JumpBoostConnection = UIS.InputBegan:Connect(function(UserInput)
            if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
                Action(Player.Character.Humanoid, function(self)
                    if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                        Action(self.Parent.HumanoidRootPart, function(self)
                            self.Velocity = Vector3.new(0, _G.JumpHeight, 0)
                        end)
                    end
                end)
            end
        end)
    else
        if getgenv().JumpBoostConnection then
            getgenv().JumpBoostConnection:Disconnect()
            getgenv().JumpBoostConnection = nil
        end
    end
end,})

local faceBangScript = Tab16:CreateButton({
Name = "Face F**k Script",
Callback = function()
    if getgenv().loaded_face_bang then
        return notify("Notification:", "Already loaded face f*ck script!", 7.5)
    else
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/bruhlolw/refs/heads/main/face_bang_script.lua'))()
        getgenv().loaded_face_bang = true
    end
end,})

local noclipToggle = Tab2:CreateToggle({
Name = "Noclip",
CurrentValue =  false,
Flag = "toggleNoclipChar",
Callback = function(noclip_toggle)
    function reset_collide(reset_bool)
        if reset_bool == true then
            getgenv().Character:FindFirstChild("LowerTorso").CanCollide = true
            getgenv().Character:FindFirstChild("UpperTorso").CanCollide = true
            getgenv().HumanoidRootPart.CanCollide = true
        elseif reset_bool == false then
            getgenv().Character:FindFirstChild("LowerTorso").CanCollide = false
            getgenv().Character:FindFirstChild("UpperTorso").CanCollide = false
            getgenv().HumanoidRootPart.CanCollide = false
        else
            return warn("Invalid input BoolValue.")
        end
    end

    if noclip_toggle then
        reset_collide(false)
    else
        reset_collide(true)
    end
end,})

local FlyNoclip = Tab16:CreateToggle({
Name = "Noclip Toggle For Fly",
CurrentValue = false,
Flag = "toggleNoclipForFly",
Callback = function(noclipToggleFly)
    function reset_collide(reset_bool)
        if reset_bool == true then
            getgenv().Character:FindFirstChild("LowerTorso").CanCollide = true
            getgenv().Character:FindFirstChild("UpperTorso").CanCollide = true
            getgenv().HumanoidRootPart.CanCollide = true
        elseif reset_bool == false then
            getgenv().Character:FindFirstChild("LowerTorso").CanCollide = false
            getgenv().Character:FindFirstChild("UpperTorso").CanCollide = false
            getgenv().HumanoidRootPart.CanCollide = false
        else
            return warn("Invalid input BoolValue.")
        end
    end

    if noclipToggleFly then
        reset_collide(false)
    else
        reset_collide(true)
    end
end,})

getgenv().flyspeed = 1
getgenv().vehicleflyspeed = 1
local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local SPEED = 0
wait(0.1)
local flySpeedGet = Tab16:CreateSlider({
Name = "Fly Speed",
Range = {1, 50},
Increment = 1,
Suffix = "",
CurrentValue = 1,
Flag = "getflyspeed",
Callback = function(doflyspeed)
    local fly_speed_get = tonumber(doflyspeed)

    getgenv().flyspeed = fly_speed_get
    getgenv().vehicleflyspeed = fly_speed_get
end,})
wait(0.1)
local FlyScript = Tab16:CreateToggle({
Name = "Fly",
CurrentValue = false,
Flag = "flyScriptToggle",
Callback = function(toggleTheFly)
    getgenv().FLYING = false
    getgenv().QEfly = true
    wait(0.1)
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    if toggleTheFly then
        getgenv().FLYING = true
        getgenv().QEfly = true
        getgenv().flyConnectionRender = nil
        getgenv().flyKeyDownConnection = nil
        getgenv().flyKeyUpConnection = nil

        local function getRoot(character)
            return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildOfClass("BasePart")
        end

        local function sFLY(vfly)
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = getRoot(character)
            local humanoid = character:FindFirstChildOfClass("Humanoid")

            if not rootPart or not humanoid then
                return 
            end

            if getgenv().flyKeyDownConnection then getgenv().flyKeyDownConnection:Disconnect() end
            if getgenv().flyKeyUpConnection then getgenv().flyKeyUpConnection:Disconnect() end

            local function FLY()
                getgenv().FLYING = true
                local BG = Instance.new("BodyGyro", rootPart)
                local BV = Instance.new("BodyVelocity", rootPart)

                BG.Name = "Gyro-Fly"
                BV.Name = "Velocity-Fly"
                BG.P = 9e4
                BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                BG.cframe = rootPart.CFrame

                BV.velocity = Vector3.zero
                BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

                getgenv().flyConnectionRender = RunService.RenderStepped:Connect(function()
                    if not getgenv().FLYING then return end

                    if not vfly and humanoid then
                        humanoid.PlatformStand = true
                    end

                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        SPEED = 50
                    elseif SPEED ~= 0 then
                        SPEED = 0
                    end

                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (CONTROL.F + CONTROL.B))
                            + ((workspace.CurrentCamera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p)
                            - workspace.CurrentCamera.CFrame.p)) * SPEED

                        lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R, Q = CONTROL.Q, E = CONTROL.E}
                    else
                        BV.velocity = Vector3.zero
                    end

                    BG.cframe = workspace.CurrentCamera.CFrame
                end)
            end

            getgenv().flyKeyDownConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end

                local key = input.KeyCode
                if key == Enum.KeyCode.W then
                    CONTROL.F = (vfly and getgenv().vehicleflyspeed or getgenv().flyspeed)
                elseif key == Enum.KeyCode.S then
                    CONTROL.B = -(vfly and getgenv().vehicleflyspeed or getgenv().flyspeed)
                elseif key == Enum.KeyCode.A then
                    CONTROL.L = -(vfly and getgenv().vehicleflyspeed or getgenv().flyspeed)
                elseif key == Enum.KeyCode.D then
                    CONTROL.R = (vfly and getgenv().vehicleflyspeed or getgenv().flyspeed)
                elseif getgenv().QEfly and key == Enum.KeyCode.E then
                    CONTROL.Q = (vfly and getgenv().vehicleflyspeed or getgenv().flyspeed) * 2
                elseif getgenv().QEfly and key == Enum.KeyCode.Q then
                    CONTROL.E = -(vfly and getgenv().vehicleflyspeed or getgenv().flyspeed) * 2
                end
            end)

            getgenv().flyKeyUpConnection = UserInputService.InputEnded:Connect(function(input, gameProcessed)
                if gameProcessed then return end

                local key = input.KeyCode
                if key == Enum.KeyCode.W then
                    CONTROL.F = 0
                elseif key == Enum.KeyCode.S then
                    CONTROL.B = 0
                elseif key == Enum.KeyCode.A then
                    CONTROL.L = 0
                elseif key == Enum.KeyCode.D then
                    CONTROL.R = 0
                elseif key == Enum.KeyCode.E then
                    CONTROL.Q = 0
                elseif key == Enum.KeyCode.Q then
                    CONTROL.E = 0
                end
            end)

            FLY()
        end

        sFLY(false)
    else
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local rootPart = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")

        if getgenv().HumanoidRootPart:FindFirstChild("Gyro-Fly") then
            getgenv().HumanoidRootPart:FindFirstChild("Gyro-Fly"):Destroy()
        else
            warn("nil - BodyGyro")
        end
        wait(0.1)
        if getgenv().HumanoidRootPart:FindFirstChild("Velocity-Fly") then
            getgenv().HumanoidRootPart:FindFirstChild("Velocity-Fly"):Destroy()
        else
            warn("nil - BodyVelocity")
        end
        wait(0.2)
        rootPart.Velocity = Vector3.zero
        rootPart.AssemblyLinearVelocity = Vector3.zero
        rootPart.AssemblyAngularVelocity = Vector3.zero

        rootPart.CFrame = CFrame.new(rootPart.Position - Vector3.new(0, 5, 0))

        if humanoid then
            humanoid.PlatformStand = false
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end

        task.wait(0.1)
        if rootPart then
            rootPart.Velocity = Vector3.zero
        end
        wait(0.3)
        getgenv().FLYING = false
        getgenv().QEfly = false

        if getgenv().flyConnectionRender then
            getgenv().flyConnectionRender:Disconnect()
            getgenv().flyConnectionRender = nil
        end

        if getgenv().flyKeyDownConnection then
            getgenv().flyKeyDownConnection:Disconnect()
            getgenv().flyKeyDownConnection = nil
        end

        if getgenv().flyKeyUpConnection then
            getgenv().flyKeyUpConnection:Disconnect()
            getgenv().flyKeyUpConnection = nil
        end
    end
end,})

local default_distance = 20
local teleportDistance = 20
local default_speed = 0.1
local tp_speed = 0.1
wait(0.1)
local glitchSideToSideSpeed = Tab16:CreateSlider({
Name = "Glitch Speed (Less = Faster)",
Range = {0.1, 3},
Increment = 0.1,
Suffix = "",
CurrentValue = 0.5,
Flag = "sideToSpeed",
Callback = function(gotSideSpeed)
    local converted_num = tonumber(gotSideSpeed)

    if converted_num then
        tp_speed = converted_num
    else
        tp_speed = tonumber(default_speed)
    end
end,})

local glitchScriptDistance = Tab16:CreateInput({
Name = "SideToSide Script Distance",
CurrentValue = "20",
PlaceholderText = "Distance Here",
RemoveTextAfterFocusLost = true,
Flag = "TPSideToSideDist",
Callback = function(DistanceNum)
    function convert(input)
        local dist = tonumber(input)
        if dist then
            return dist
        else
            return warn("Invalid Input,\n Usage: convert(string) <-- 'string' is where the string is supposed to go.")
        end
    end

    local converted_num = convert(DistanceNum)
    wait(0.1)
    if converted_num and converted_num ~= "" then
        teleportDistance = converted_num
    else
        teleportDistance = default_distance
    end
end,})

local glitchingSide = Tab16:CreateToggle({
Name = "Glitch Side To Side Script",
CurrentValue = false,
Flag = "GlitchyScript",
Callback = function(toggleBool)
    if toggleBool then
        getgenv().glitchActive = true
    
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local runService = game:GetService("RunService")
        local tp_distance = teleportDistance
        local teleportSpeed = tp_speed
        local toggleConnection
    
        local function toggleTeleportEffect()
            if getgenv().glitchActive then
                getgenv().toggleConnection = runService.RenderStepped:Connect(function()
                    local direction = math.random(1, 2) == 1 and -1 or 1
                    local rightVector = humanoidRootPart.CFrame.RightVector
                    local offset = rightVector * (direction * tp_distance)
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame + offset
                    task.wait(teleportSpeed)
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame - offset
                end)
            end
        end
    
        toggleTeleportEffect()
    else
        if getgenv().toggleConnection then
            getgenv().toggleConnection:Disconnect()
            getgenv().toggleConnection = nil
        end
    end
end,})

getgenv().settings_flashback = {
    Keybind = string.upper("C"),
    Speed = 0.9
}

local keyToFlash = Tab16:CreateInput({
Name = "Flashback Rewind Keybind",
CurrentValue = "C",
PlaceholderText = "Key Here",
RemoveTextAfterFocusLost = true,
Flag = "KeybindFlashback",
Callback = function(keyPressedFlash)
    if getgenv().flashbacks_script then 
        getgenv().notify("Alert!", "Unloading Flashback Rewind to save changes...", 7)
        wait(0.3)
        local runService = game:GetService("RunService") 
    
        if getgenv().flashbacks_script then
            pcall(function()
                runService:UnbindFromRenderStep("FlashbackStep")
                getgenv().frames = nil
                getgenv().flashbacks_script = false
                getgenv().flashback = nil
            end)
        end
        wait(0.4)
        if getgenv().flashback == nil and getgenv().flashbacks_script == false then
            getgenv().settings_flashback.Keybind = string.upper(keyPressedFlash)
            wait(0.1)
            getgenv().notify("Success!", "We unloaded Flashback Rewind and updated keybind!", 7)
            wait(0.2)
            getgenv().notify("Changed.", "New Keybind: "..tostring(string.upper(keyPressedFlash)), 6.8)
        else
            getgenv().notify("Failed!", "Unable to complete process, please reset.", 6)
        end
    else
        getgenv().settings_flashback.Keybind = string.upper(keyPressedFlash)
        wait(0.1)
        getgenv().notify("Success!", "Flashback Rewind Updated To: "..tostring(string.upper(keyPressedFlash)), 7)
    end    
end,})

local FlashbackSpeed = Tab16:CreateSlider({
Name = "Flashback Speed",
Range = {0.7, 5},
Increment = 0.1,
Suffix = "",
CurrentValue = getgenv().settings_flashback.Speed,
Flag = "flashSpeed",
Callback = function(gotSpeedFlashback)
    getgenv().settings_flashback.Speed = tonumber(gotSpeedFlashback)
end,})

-- >> Big Thanks to: sa.ya (Discord)
local flashBackRewindScript = Tab16:CreateButton({
Name = "Flashback Rewind",
Callback = function()
    if getgenv().flashbacks_script then
        return getgenv().notify("Failed", "Flashback Rewind is already running!", 7)
    end

    local key = Enum.KeyCode[getgenv().settings_flashback.Keybind]
    if not Enum.KeyCode[getgenv().settings_flashback.Keybind] then
        return getgenv().notify("Invalid Key!", "KeyCode seems to be invalid, try another one", 7)
    end

    local flashbackLength = 80
    local flashbackSpeed = tonumber(getgenv().settings_flashback.Speed)
    
    getgenv().frames = getgenv().frames or {}
    local frames = getgenv().frames
    
    local uis = game:GetService("UserInputService")
    local player = game:GetService("Players").LocalPlayer
    local runService = game:GetService("RunService")
    
    local function getCharacter()
        return player.Character or player.CharacterAdded:Wait()
    end
    
    local function getHumanoidRootPart(character)
        return character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
    end

    getgenv().flashback = getgenv().flashback or {}
    local flashback = getgenv().flashback
    
    function flashback:Advance(character, humanoidRootPart, humanoid)
        if #frames > flashbackLength * 60 then
            table.remove(frames, 1)
        end
    
        table.insert(frames, {
            humanoidRootPart.CFrame,
            humanoidRootPart.Velocity,
            humanoid:GetState(),
            humanoid.PlatformStand
        })
    end
    
    function flashback:Revert(character, humanoidRootPart, humanoid)
        local frameCount = #frames
        if frameCount == 0 then
            self:Advance(character, humanoidRootPart, humanoid)
            return
        end
    
        for _ = 1, flashbackSpeed do
            table.remove(frames, frameCount)
            frameCount = frameCount - 1
        end
    
        local lastFrame = frames[frameCount]
        table.remove(frames, frameCount)
        
        humanoidRootPart.CFrame = lastFrame[1]
        humanoidRootPart.Velocity = -lastFrame[2]
        humanoid:ChangeState(lastFrame[3])
        humanoid.PlatformStand = lastFrame[4]
    end
    
    local function onRenderStep()
        local character = getCharacter()
        local humanoidRootPart = getHumanoidRootPart(character)
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        
        if not key or typeof(key) ~= "EnumItem" then
            pcall(function()
                runService:UnbindFromRenderStep("FlashbackStep")
                getgenv().frames = nil
                getgenv().flashbacks_script = false
                getgenv().flashback = nil
            end)
            return getgenv().notify("Invalid Key!", "KeyCode seems to be invalid, try another one", 7)
        end
    
        if uis:IsKeyDown(key) then
            flashback:Revert(character, humanoidRootPart, humanoid)
        else
            flashback:Advance(character, humanoidRootPart, humanoid)
        end
    end        
    
    runService:BindToRenderStep("FlashbackStep", 1, onRenderStep)      
    wait(.2)
    getgenv().flashbacks_script = true
end,})

local stopFlashbackScript = Tab16:CreateButton({
Name = "Unload Flashback (Stop Running/Quit)",
Callback = function()
    local runService = game:GetService("RunService") 

    if getgenv().flashbacks_script then
        pcall(function()
            runService:UnbindFromRenderStep("FlashbackStep")
            getgenv().frames = nil
            getgenv().flashbacks_script = false
            getgenv().flashback = nil
        end)
    end
end,})

if getgenv().checked_function_elevator then
    warn("We checked elevator stuff")
else
    local Elevator = workspace:FindFirstChild("Elevator")
    local Obby_Folder = game:GetService("Workspace"):FindFirstChild("Obby")
    local Low_Model = Obby_Folder:FindFirstChild("Low")
    local function resize_part(part, size, position)
        local position = position
        local size = size
        local part = game:GetService("Workspace"):FindFirstChild(part)

        part.CFrame = position
        part.Size = size
    end
    resize_part("Elevator", Vector3.new(45, 284, 34), CFrame.new(58.5813599, 139.712708, 225, -1, 0, 0, 0, 1, 0, 0, 0, -1))
    wait(0.3)
    local obby_clone = Low_Model:Clone()
    obby_clone.Parent = game:GetService("Workspace"):FindFirstChild("PartStorage")
    Elevator.Parent = game:GetService("Workspace"):FindFirstChild("PartStorage")
    wait(0.3)
    if game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("Elevator") then
        Elevator = game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("Elevator")
    else
        warn("Didn't find 'Elevator' in PartStorage [game.Workspace/workspace], Falling back.")
        task.wait()
        Elevator = game:GetService("Workspace"):FindFirstChild("Elevator")
    end
    wait(0.2)
    getgenv().checked_function_elevator = true
end
wait(0.3)
local elevator
wait(0.2)
if game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("Elevator") then
    elevator = game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("Elevator")
else
    elevator = game:GetService("Workspace"):FindFirstChild("Elevator")
end
wait(0.2)
local elevatorModifier = Tab1:CreateToggle({
Name = "Visible Elevator (Tower - Float Up Part)",
CurrentValue = false,
Flag = "toggleElevatorVisibility",
Callback = function(elevToggle)
    if elevToggle then
        elevator.Transparency = 0
    else
        elevator.Transparency = 1
    end
end,})

local collisionForElevator = Tab1:CreateToggle({
Name = "Elevator Collision (Tower - Float Up Part)",
CurrentValue = false,
Flag = "toggleElevatorCollide",
Callback = function(elevatorCollide)
    if elevatorCollide then
        elevator.CanTouch = true
        elevator.CanQuery = true
    else
        elevator.CanCollide = false
        elevator.CanQuery = false
        elevator.CanTouch = false
    end
end,})

local InfoLabelParagraph = Tab13:CreateParagraph({Title = "Information:", Content = "Type 'stop' to stop flying."})
wait()
local InfoLabelParagraph = Tab13:CreateParagraph({Title = "Controls:", Content = "Space = Up | Q = Down"})
wait()
local getHoverboardFlyInput = Tab13:CreateInput({
    Name = "Hoverboard Fly",
    PlaceholderText = "Speed",
    RemoveTextAfterFocusLost = true,
    Callback = function(GetSpeed)
        if tonumber(GetSpeed) then
            local args = {
                [1] = "Hoverboard"
            }
            
            getgenv().ReplicatedStorage:WaitForChild("ToolEvent"):FireServer(unpack(args))
            wait(0.2)
            if getgenv().LocalPlayer.Backpack:FindFirstChild("Hoverboard") then
                getgenv().LocalPlayer.Backpack:FindFirstChild("Hoverboard").Parent = getgenv().Character
            elseif getgenv().Character:FindFirstChild("Hoverboard") then
                warn("Hoverboard is already in Character")
            elseif (not getgenv().LocalPlayer.Backpack:FindFirstChild("Hoverboard") and getgenv().Character:FindFirstChild("Hoverboard")) then
                warn("Hoverboard is nil, and cannot be found! Resetting you...")
                wait(0.3)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").Health = 0
            end
            wait(0.5)
            local player = getgenv().LocalPlayer
            local character = getgenv().Character
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart") or character:FindFirstChild("HumanoidRootPart")
            getgenv().flying = false
            getgenv().speed = tonumber(GetSpeed)
            local bodyGyro = nil
            local bodyVelocity = nil

            local function startFly()
                flying = true
                bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(0, 400000, 0)
                bodyGyro.CFrame = humanoidRootPart.CFrame
                bodyGyro.Parent = humanoidRootPart
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(1e4, 1e4, 1e4)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = humanoidRootPart
                character.Humanoid.PlatformStand = true
            end

            local function updateFly()
                if flying then
                    local moveDirection = Vector3.new(0, 0, 0)
                    local camera = workspace.CurrentCamera
                    local lookVector = camera.CFrame.LookVector
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        moveDirection = moveDirection + lookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                        moveDirection = moveDirection - lookVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                        moveDirection = moveDirection - camera.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                        moveDirection = moveDirection + camera.CFrame.RightVector
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                        moveDirection = moveDirection + Vector3.new(0, 1, 0)
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Q) then
                        moveDirection = moveDirection - Vector3.new(0, 1, 0)
                    end
                    if moveDirection.Magnitude > 0 then
                        bodyVelocity.Velocity = moveDirection.Unit * tonumber(getgenv().speed)
                    else
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                    bodyGyro.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
                end
            end

            game:GetService("RunService").RenderStepped:Connect(function()
                if flying then
                    updateFly()
                end
            end)

            startFly()           
        elseif tostring(GetSpeed) or GetSpeed == "stop" then
            local RunService = game:GetService("RunService")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            
            wait(0.3)
            getgenv().flyLoop = false
            wait(0.2)
            local player = getgenv().LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart") or character:FindFirstChild("HumanoidRootPart")
            local Humanoid = character:FindFirstChildWhichIsA("Humanoid") or character:WaitForChild("Humanoid") or character:FindFirstChildOfClass("Humanoid") or character:FindFirstChild("Humanoid")

            if character:FindFirstChild("Hoverboard") then
                local hover = character:FindFirstChild("Hoverboard")

                hover.Parent = player.Backpack
            end
            wait(0.5)
            local function stopFly()
                if humanoidRootPart:FindFirstChild("BodyGyro") then
                    humanoidRootPart.BodyGyro:Destroy()
                end
                if humanoidRootPart:FindFirstChild("BodyVelocity") then
                    humanoidRootPart.BodyVelocity:Destroy()
                end
                character.Humanoid.PlatformStand = false
                getgenv().flyLoop = false
            end
            wait(0.2)
            stopFly()
        wait(0.3)
        getgenv().ReplicatedStorage:WaitForChild("DeleteInventory"):FireServer()
    elseif tonumber(GetSpeed) and getgenv().flying == true then
        getgenv().speed = tonumber(GetSpeed)
    end
end,})

function notify(title, content, duration, image)
    if not image then
        image = tonumber(4483362458)
    end

    if not duration then
        duration = tonumber(6)
    end

    if not title then
        title = "Notification: "
    end

    if not content then
        content = "DEFAULT_MESSAGE_CONTENT"
    end

    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(duration),
        Image = 4483362458,
        Actions = {
            Ignore = {
            Name = "Alright",
            Callback = function()
                print("...")
            end
            },
        },
    })
end

local viewBooth = Tab11:CreateToggle({
Name = "View Your Booth",
CurrentValue = false,
Flag = "theBoothView",
Callback = function(specBooth)
    local Workspace = getgenv().Workspace
    local function get_booth()
        for i,v in pairs(game:GetService("Workspace").Booth:GetChildren()) do
            if v.User.SurfaceGui.ImageLabel.Image == "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(getgenv().LocalPlayer.UserId).."&width=420&height=420&format=png" then
                return v
            end
        end
        return nil
    end

    local plr_booth = get_booth()

    if not plr_booth then
        return notify("Error: ", "You do not have a booth, claim one!", 6.5)
    end
    wait()
    if specBooth and plr_booth then
        getgenv().viewing_booth = true
        Workspace.CurrentCamera.CameraSubject = plr_booth
    else
        local Workspace = getgenv().Workspace
        getgenv().viewing_booth = false
        wait(0.2)
        Workspace.CurrentCamera.CameraSubject = getgenv().Character
    end
end,})

local TPToBooth = Tab11:CreateButton({
Name = "Teleport To Booth",
Callback = function()
    local Workspace = getgenv().Workspace

    local function get_booth()
        for i,v in pairs(Workspace:FindFirstChild("Booth"):GetChildren()) do
            if v.User.SurfaceGui.ImageLabel.Image == "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(getgenv().LocalPlayer.UserId).."&width=420&height=420&format=png" then
                return v
            end
        end
        return nil
    end

    local plr_booth = get_booth()

    if not plr_booth then
        return notify("Error: ", "You do not have a booth, claim one!", 6.5)
    end
    task.wait()
    getgenv().Character:PivotTo(plr_booth:GetPivot())
end,})

local tpToAvatarUI = Tab1:CreateButton({
Name = "Teleport To Avatar-UI",
Callback = function()
    local Folder = game:GetService("Workspace"):FindFirstChild("PartStorage")
    local Avatar_UI = Folder:FindFirstChild("AvatarUI")
    wait(.1)
    getgenv().Character:PivotTo(Avatar_UI:GetPivot())
end,})

local AutoLikingPlayer = Tab1:CreateToggle({
Name = "[Avatar-UI]: Auto Like Player",
CurrentValue = false,
Flag = "likingPlayerAuto",
Callback = function(likeLol)
    local Avatar_UI = game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("AvatarUI")
    local Like_Button = Avatar_UI:FindFirstChild("LikeButton") or Avatar_UI:WaitForChild("LikeButton")
    local Click_Detector_Input = Like_Button:FindFirstChild("ClickDetector")

    if likeLol then
        if fireclickdetector then
            getgenv().alrLike = true
            while getgenv().alrLike == true do
            wait(1.1)
                fireclickdetector(Click_Detector_Input, 999)
            end
        else
            getgenv().alrLike = false
            return getgenv().notify("Error:", "Your executor does not support 'fireclickdetector'", 7)
        end
    else
        getgenv().alrLike = false
    end
end,})

local dislikePlayersAvatar = Tab1:CreateToggle({
Name = "[Avatar-UI]: Auto Dislike Player",
CurrentValue = false,
Flag = "dislikingEverybody",
Callback = function(dislikeButton)
    local Avatar_UI = game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("AvatarUI")
    local dislikeButton = Avatar_UI:FindFirstChild("DislikeButton") or Avatar_UI:WaitForChild("DislikeButton")
    local Click_Detector_Input = Like_Button:FindFirstChild("ClickDetector")
    
    if dislikeButton then
        if fireclickdetector then
            getgenv().Disliking = true
            while getgenv().Disliking == true do
            wait(1.1)
                fireclickdetector(Click_Detector_Input)
            end
        else
            getgenv().Disliking = false
            return getgenv().notify("Error:", "Your executor does not support 'fireclickdetector'", 7)
        end
    else
        getgenv().Disliking = false
    end
end,})

local function Notify_User(title, content, time)
    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(time),
        Image = 4483362458,
        Actions = {
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
            },
        },
    })
end

local Stop_Music_Player = Tab1:CreateButton({
Name = "Stop In-Game Music",
Callback = function()
    local Local_Player = game:GetService("Players").LocalPlayer
    local Stop_Music_Frame = getgenv().PlayerGui:FindFirstChild("Menu"):FindFirstChild("Background"):FindFirstChild("Music"):FindFirstChild("Stop")
    local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

    if firesignal then
        for _,v in pairs(Stop_Music_Frame:GetDescendants()) do
            if v:IsA("ImageButton") or v:IsA("TextButton") then
                for i,Signal in pairs(Signals) do
                    firesignal(v[Signal])
                end
            end
        end
    else
        return Notify_User("Error:", "Your executor does not support 'firesignal'!", 6)
    end
end,})

local Music_Player = Tab1:CreateButton({
Name = "Shuffle In-Game Music",
Callback = function()
    local Local_Player = game:GetService("Players").LocalPlayer
    local Shuffle_Music_Frame = Local_Player:WaitForChild("PlayerGui"):WaitForChild("Menu"):WaitForChild("Background"):WaitForChild("Music"):WaitForChild("Shuffle")
    local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

    if firesignal then
        for _,v in pairs(Shuffle_Music_Frame:GetDescendants()) do
            if v:IsA("ImageButton") or v:IsA("TextButton") then
                for i,Signal in pairs(Signals) do
                    firesignal(v[Signal])
                end
            end
        end
    else
        return Notify_User("Error:", "Your executor does not support 'firesignal'!", 6)
    end
end,})

local Music_Player = Tab1:CreateToggle({
Name = "Loop Shuffle In-Game Music",
CurrentValue = false,
Flag = "ToggleInGameMusic",
Callback = function(ingame_music)
    if ingame_music then
        getgenv().plr_music_menu = true
        local Local_Player = game:GetService("Players").LocalPlayer
        local PlayerGui = Local_Player:WaitForChild("PlayerGui")
        local Menu = PlayerGui:WaitForChild("Menu")
        local Background = Menu:WaitForChild("Background")
        local Music = Background:WaitForChild("Music")
        local Stop = Music:WaitForChild("Stop")
        local Shuffle_Music_Frame = Music:WaitForChild("Shuffle")
        local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
        
        if firesignal then
            while getgenv().plr_music_menu == true do
            task.wait(1)
                for _,v in pairs(Shuffle_Music_Frame:GetDescendants()) do
                    if v:IsA("ImageButton") or v:IsA("TextButton") then
                        for i,Signal in pairs(Signals) do
                            firesignal(v[Signal])
                        end
                    end
                end
            end
        else
            return Notify_User("Error:", "Your executor does not support 'firesignal'!", 6)
        end
    else
        local Local_Player = game:GetService("Players").LocalPlayer
        local PlayerGui = Local_Player:WaitForChild("PlayerGui")
        local Menu = PlayerGui:WaitForChild("Menu")
        local Background = Menu:WaitForChild("Background")
        local Music = Background:WaitForChild("Music")
        local Stop = Music:WaitForChild("Stop")
        getgenv().plr_music_menu = false
        task.wait(0.3)
        if firesignal then
            for _,v in pairs(Stop:GetDescendants()) do
                if v:IsA("ImageButton") or v:IsA("TextButton") then
                    for i,Signal in pairs(Signals) do
                        firesignal(v[Signal])
                    end
                end
            end
        else
            return 
        end
    end
end,})

local WhitelistFriendPlr = Tab1:CreateToggle({
Name = "[Avatar-UI]: Only Like Friend",
CurrentValue = false,
Flag = "LikingOnlyFriends",
Callback = function(myFriendsLiked)
    if myFriendsLiked then
        local Avatar_UI = game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("AvatarUI")
        local Like_Button = Avatar_UI:FindFirstChild("LikeButton") or Avatar_UI:WaitForChild("LikeButton")
        local Click_Detector_Input = Like_Button:FindFirstChild("ClickDetector")
        local Avatar_Part_UI = Avatar_UI:WaitForChild("AvatarUI")
        local Image_Label = Avatar_Part_UI:WaitForChild("SurfaceGui"):WaitForChild("ImageLabel")
        
        local Local_Player = getgenv().LocalPlayer
        
        local friend_find = findplr("friend")
        
        if not friend_find then
            getgenv().Like_Friends = false
            return Notify_User("Error:", "You have 0 friends in this server!", 6)
        end
        
        function like_friend_only(user)
            if user then
                local expectedURL = "rbxthumb://type=Avatar&id=" .. tostring(user.UserId) .. "&w=420&h=420"
                if Image_Label.Image == expectedURL then
                    fireclickdetector(Click_Detector_Input, 999)
                    return true
                end
            end
            return false
        end
        
        if friend_find then
            getgenv().Like_Friends = true
            while getgenv().Like_Friends == true do
                wait()
                local liked = like_friend_only(friend_find)
                if not liked then
                    getgenv().Like_Friends = false
                end
            end
        else
            getgenv().Like_Friends = false
        end
    else
        getgenv().Like_Friends = false
    end
end,})

local GotoPlayerBox = Tab13:CreateInput({
Name = "Goto/TP Player",
CurrentValue = "",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Flag = "TPToPlayerBo",
Callback = function(get_player_func)
    local tp_pivot_plr = findplr(get_player_func)
    if not tp_pivot_plr then
        return Notify_User("Error:", "Player not found or does not exist!", 6)
    end
    task.wait(.2)

    local tp_getpivot_char = tp_pivot_plr.Character

    if tp_getpivot_char then
        getgenv().Character:PivotTo(tp_getpivot_char:GetPivot())
    else
        return 
    end
end,})

local ViewPlrBox = Tab13:CreateInput({
Name = "View/Spectate Player",
CurrentValue = "",
PlaceholderText = "User Here",
RemoveTextAfterFocusLost = true,
Flag = "ViewPlrSpectating",
Callback = function(do_plr_func)
    local tp_pivot_plr = findplr(do_plr_func)
    local Workspace = game:GetService("Workspace") or cloneref(game:GetService("Workspace"))
    local Camera = Workspace:FindFirstChild("Camera")
    
    if not tp_pivot_plr then
        return Notify_User("Error:", "Player not found or does not exist!", 6)
    end
    task.wait(.2)

    local spectate_char = tp_pivot_plr.Character

    if spectate_char then
        Camera.CameraSubject = spectate_char
    else
        return 
    end
end,})

local UnviewPlr = Tab13:CreateButton({
Name = "Unview/Unspectate Player",
Callback = function()
    local Workspace = game:GetService("Workspace") or cloneref(game:GetService("Workspace"))
    local Camera = Workspace:FindFirstChild("Camera")

    Camera.CameraSubject = getgenv().Character
end,})

if setfpscap then
    local settingFPSSetting = Tab1:CreateSlider({
    Name = "Set FPS Cap",
    Range = {0, 999},
    Increment = 1,
    Suffix = "",
    CurrentValue = 180,
    Flag = "FPSSetterSliding",
    Callback = function(fps_to_set)
        local exec = identifyexecutor()
        local fps_cap = setfpscap
    
        if fps_cap and exec then
            setfpscap(fps_to_set)
        end
    end,})
elseif identifyexecutor then
    local exec = identifyexecutor()
    warn(exec.." does not support 'setfpscap'")
else
    warn("Your executor does not support 'identifyexecutor', and it does not support 'setfpscap' [Garbage Executor.]")
end

local MutingMyself = Tab1:CreateToggle({
Name = "Mute Yourself",
CurrentValue = false,
Flag = "IJustMutedMyself",
Callback = function(muteYou)
    if muteYou then
        getgenv().muting = true
        if getgenv().muting == true then
            getgenv().LocalPlayer.AudioDeviceInput.Muted = true
        end
    else
        getgenv().muting = false
        wait()
        getgenv().LocalPlayer.AudioDeviceInput.Muted = false
    end
end,})

local DelInventory = Tab5:CreateButton({
Name = "Delete Inventory",
Callback = function()
    local Replicated_Storage = getgenv().ReplicatedStorage
    local Delete_Inv_RemoteEvent = Replicated_Storage:WaitForChild("DeleteInventory") or Replicated_Storage:FindFirstChild("DeleteInventory")
    
    Delete_Inv_RemoteEvent:FireServer()
end,})

function Tools_Grab_Func()
    -- [[ <> Old Method <> [In Use.] ]] --
    ----------------------------
    if firesignal then
        
        getgenv().PlayerGui = getgenv().PlayerGui or getgenv().LocalPlayer:WaitForChild("PlayerGui")
        local Menu_Frame = Player_Gui:WaitForChild("Menu") or Player_Gui:FindFirstChild("Menu")
        local Background_Frame = Menu_Frame:WaitForChild("Background") or Menu_Frame:FindFirstChild("Background")
        local Tool_Frame = Background_Frame:WaitForChild("Tool") or Background_Frame:FindFirstChild("Tool")
        local Scrolling_Frame_Tool_Menu = Tool_Frame:WaitForChild("ScrollingFrame") or Tool_Frame:FindFirstChild("ScrollingFrame")

        function send_signal_connection(signal_parent)
            if not firesignal then return warn("'firesignal' is unsupported on this executor! [missing: 'firesignal']") end

            local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

            for _,v in pairs(signal_parent:GetDescendants()) do
                if v:IsA("ImageButton") or v:IsA("TextButton") then
                    for i,Signal in pairs(Signals) do
                        firesignal(v[Signal])
                    end
                else
                    return 
                end
            end
        end

        for i, v in pairs(Scrolling_Frame_Tool_Menu:GetDescendants()) do
            if v:IsA("Frame") or v:FindFirstChildOfClass("Frame") or v:FindFirstChildWhichIsA("Frame") or v.ClassName == "Frame" then
                send_signal_connection(v)
            end
        end
    else
        --[[local gamePassId = 951459548

        local function verify_pass()
            local success, hasPass = pcall(function()
                return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(getgenv().LocalPlayer.UserId, gamePassId)
            end)
            if success then
                return hasPass
            else
                warn("Error checking game pass ownership:", hasPass)
                return false
            end
        end

        local check_gamepass = verify_pass()

        if not check_gamepass then
            getgenv().shouldGrabTools = false
            return Notify_User("Error:", "You don't have the required 'Admin' GamePass!", 6)
        end--]]

        local Rep_Storage = game:GetService("ReplicatedStorage")
        local Tool_Event = Rep_Storage:FindFirstChild("ToolEvent") or Rep_Storage:WaitForChild("ToolEvent")

        Tool_Event:FireServer("Bag")
        Tool_Event:FireServer("Brick")
        Tool_Event:FireServer("Camera")
        Tool_Event:FireServer("Coil")
        Tool_Event:FireServer("Doll")
        Tool_Event:FireServer("Fit")
        Tool_Event:FireServer("Gun")
        Tool_Event:FireServer("Horrible")
        Tool_Event:FireServer("Hoverboard")
        Tool_Event:FireServer("Knife")
        Tool_Event:FireServer("Motor")
        Tool_Event:FireServer("Pistol")
        Tool_Event:FireServer("Spray")
        Tool_Event:FireServer("Suitbag")
        Tool_Event:FireServer("Tele")
        Tool_Event:FireServer("Torch")
        Tool_Event:FireServer("Vehicle")
        Tool_Event:FireServer("Wand")

        Notify_User("Alert!:", "If this did not work, you are affected by MIC UP's new changes.", 7)
    end
    ----------------------------
    -- [[ <> New Method <> ]] --
    ----------------------------
    --[[ or game.Players
    
    local Player_Gui = LocalPlayer:WaitForChild("PlayerGui") or LocalPlayer:FindFirstChild("PlayerGui")
    local Menu_Frame = Player_Gui:WaitForChild("Menu") or Player_Gui:FindFirstChild("Menu")
    local Background_Frame = Menu_Frame:WaitForChild("Background") or Menu_Frame:FindFirstChild("Background")
    local Tool_Frame = Background_Frame:WaitForChild("Tool") or Background_Frame:FindFirstChild("Tool")
    local Scrolling_Frame_Tool_Menu = Tool_Frame:WaitForChild("ScrollingFrame") or Tool_Frame:FindFirstChild("ScrollingFrame")

    function send_signal_connection(signal_parent)
        if not firesignal then return warn("'firesignal' is unsupported on this executor! [missing: 'firesignal']") end

        local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

        for _,v in pairs(signal_parent:GetDescendants()) do
            if v:IsA("ImageButton") or v:IsA("TextButton") then
                for i,Signal in pairs(Signals) do
                    firesignal(v[Signal])
                end
            else
                return 
            end
        end
    end

    for i, v in pairs(Scrolling_Frame_Tool_Menu:GetDescendants()) do
        if v:IsA("Frame") or v:FindFirstChildOfClass("Frame") or v:FindFirstChildWhichIsA("Frame") or v.ClassName == "Frame" then
            send_signal_connection(v)
        end
    end--]]
end

local GrabEverything = Tab5:CreateButton({
Name = "Grab All Tools",
Callback = function()
    Tools_Grab_Func()
end,})

local getEverything = Tab5:CreateToggle({
Name = "Loop Grab All Tools",
CurrentValue = false,
Flag = "grabbedAllThat",
Callback = function(grabFreeTools)
    if grabFreeTools then
        getgenv().shouldGrabTools = true
        while getgenv().shouldGrabTools == true do
        task.wait()
            Tools_Grab_Func()
        end
    else
        local Rep_Storage = getgenv().ReplicatedStorage
        local Delete_Inv_Event = Rep_Storage:WaitForChild("DeleteInventory") or Rep_Storage:FindFirstChild("DeleteInventory")
        getgenv().shouldGrabTools = false
        wait(0.5)
        Delete_Inv_Event:FireServer()
    end
end,})

local ChatBypassBest = Tab4:CreateButton({
Name = "Chat Bypass (UserCreation, not up rn)",
Callback = function()
    --loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/refs/heads/main/UserCreation.lua", true))()
    Notify_User("Error:", "The library would close and you would have to rejoin.", 6)
    return Notify_User("[Read]:", "Usercreation bypassing is temporarily disabled.", 6)
end,})

local ClearChatMsgs = Tab4:CreateButton({
Name = "Clear Chat Messages",
Callback = function()
    local TextChatService = getgenv().TextChatService
        
    local chat = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
        
    local function sendchat(msg)
        chat:SendAsync(msg)
    end
    
    for i = 1, 8 do
        sendchat(" ")
    end
end,})

local GetFakeChatGUI = Tab4:CreateButton({
Name = "Fake Chat GUI",
Callback = function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/FakeChatGUI/main/LmaoBruh.lua')))()
end,})

local ChatBypassTextInput = Tab4:CreateInput({
Name = "Chat Bypass Input",
PlaceholderText = "Text",
RemoveTextAfterFocusLost = true,
Callback = function(saveInputFilter)
    local chat = getgenv().TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

    local letters = {
        set1 = {
            ["a"] = "ẳ",
            ["b"] = "ɓ",
            ["c"] = "ㄈ",
            ["d"] = "ȡ",
            ["e"] = "ȇ",
            ["f"] = "ӻ",
            ["g"] = "ɠ",
            ["h"] = "ȟ",
            ["i"] = "׀",
            ["j"] = "ǰ",
            ["k"] = "ҟ",
            ["l"] = "ȴ",
            ["m"] = "ɱ",
            ["n"] = "冂",
            ["o"] = "ό",
            ["p"] = "ᵽ",
            ["q"] = "ԛ",
            ["r"] = "ŗ",
            ["s"] = "ȿ",
            ["t"] = "丅",
            ["u"] = "ȕ",
            ["v"] = "ѵ",
            ["w"] = "ώ",
            ["x"] = "ẍ",
            ["y"] = "ƴ",
            ["z"] = "ȥ",
        }
    }

    local numbers = {
        set1 = {
            ["0"] = "Θ",
            ["1"] = "Ɩ",
            ["2"] = "ƻ",
            ["3"] = "Ʒ",
            ["4"] = "🄅",
            ["5"] = "Ƽ",
            ["6"] = "Ϭ",
            ["7"] = "🄈",
            ["8"] = "Ȣ",
            ["9"] = "Θ",
        }
    }

    local function convert(text)
        local letters_set = letters["set1"]
        local numbers_set = numbers["set1"]
    
        local converted = ""
        for i = 1, #text do
            local char = text:sub(i, i)
            local lower_char = char:lower()
    
            if char:match("%a") then
                if lettersBypass then
                    converted = converted .. char
                else
                    converted = converted .. (letters_set[lower_char] or char)
                end
            elseif char:match("%d") then
                if numbersBypass then
                    converted = converted .. char
                else
                    converted = converted .. (numbers_set[char] or char)
                end
            else
                converted = converted .. char
            end
        end
        return converted
    end
    wait(.2)
    local function sendchat(msg)
        chat:SendAsync(convert(msg))
    end

    sendchat(saveInputFilter)
end,})

local inputBypassTextBooth = Tab11:CreateInput({
Name = "Booth Text Bypass",
PlaceholderText = "Text",
RemoveTextAfterFocusLost = true,
Callback = function(enteredTextInput)
    local TextChatService = getgenv().TextChatService
    
    local Rep_Storage = getgenv().ReplicatedStorage
    local Booth_Remote = Rep_Storage:FindFirstChild("UpdateBoothText") or Rep_Storage:WaitForChild("UpdateBoothText")

    local letters = {
        set1 = {
            ["a"] = "ẳ",
            ["b"] = "ɓ",
            ["c"] = "ㄈ",
            ["d"] = "ȡ",
            ["e"] = "ȇ",
            ["f"] = "ӻ",
            ["g"] = "ɠ",
            ["h"] = "ȟ",
            ["i"] = "׀",
            ["j"] = "ǰ",
            ["k"] = "ҟ",
            ["l"] = "ȴ",
            ["m"] = "ɱ",
            ["n"] = "冂",
            ["o"] = "ό",
            ["p"] = "ᵽ",
            ["q"] = "ԛ",
            ["r"] = "ŗ",
            ["s"] = "ȿ",
            ["t"] = "丅",
            ["u"] = "ȕ",
            ["v"] = "ѵ",
            ["w"] = "ώ",
            ["x"] = "ẍ",
            ["y"] = "ƴ",
            ["z"] = "ȥ",
        }
    }

    local numbers = {
        set1 = {
            ["0"] = "Θ",
            ["1"] = "Ɩ",
            ["2"] = "ƻ",
            ["3"] = "Ʒ",
            ["4"] = "🄅",
            ["5"] = "Ƽ",
            ["6"] = "Ϭ",
            ["7"] = "🄈",
            ["8"] = "Ȣ",
            ["9"] = "Θ",
        }
    }

    local function convert(text)
        local letters_set = letters["set1"]
        local numbers_set = numbers["set1"]
    
        local converted = ""
        for i = 1, #text do
            local char = text:sub(i, i)
            local lower_char = char:lower()
    
            if char:match("%a") then
                if lettersBypass then
                    converted = converted .. char
                else
                    converted = converted .. (letters_set[lower_char] or char)
                end
            elseif char:match("%d") then
                if numbersBypass then
                    converted = converted .. char
                else
                    converted = converted .. (numbers_set[char] or char)
                end
            else
                converted = converted .. char
            end
        end
        return converted
    end

    local booth_colors = {
        "Teal",
        "Gray",
        "Red",
    }

    local function color_selector()
        local randomIndex = math.random(1, #booth_colors)
        return booth_colors[randomIndex]
    end

    local booth_fonts = {
        "DenkOne",
        "GrenzeGotisch",
        "SourceSans"    
    }

    local function font_selector()
        local randomIndex = math.random(1, #booth_fonts)
        return booth_fonts[randomIndex]
    end

    wait(.2)
    local function send_bypass_config(msg)
        local function getStall()
            for i,v in pairs(getgenv().Workspace.Booth:GetChildren()) do
                if v.User.SurfaceGui.ImageLabel.Image == "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(getgenv().LocalPlayer.UserId).."&width=420&height=420&format=png" then
                    return v
                end
            end
            return nil
        end

        local LocalStall = getStall()
        
        if not LocalStall then
            return Rayfield:Notify({
                Title = "Error: No Booth",
                Content = "You do not own a booth!",
                Duration = 7,
                Image = 4483362458,
                Actions = {
                   Ignore = {
                    Name = "Okay!",
                    Callback = function()
                        print("...")
                    end
                   },
                },
            })
        else
            print(tostring(LocalStall))
        end
        wait()
        local args = {
            [1] = tostring(convert(msg)),
            [2] = tostring(color_selector()),
            [3] = tostring(font_selector())
        }
                
        Booth_Remote:FireServer(unpack(args))
    end

    send_bypass_config(enteredTextInput)
end,})

local DoCharacterFlicking = Tab2:CreateToggle({
Name = "Character Flicker (FE)",
CurrentValue = false,
Flag = "CharFlickeringLmao",
Callback = function(Flick)
    if Flick then
        getgenv().CharFlick = true
        while getgenv().CharFlick == true do
            task.wait()
            local Rep_Storage = getgenv().ReplicatedStorage
            local Update_Height_Remote = Rep_Storage:WaitForChild("UpdateHeight") or Rep_Storage:FindFirstChild("UpdateHeight")
            local Update_Depth_Remote = Rep_Storage:WaitForChild("UpdateDepth") or Rep_Storage:FindFirstChild("UpdateDepth")
            local Update_Width_Remote = Rep_Storage:WaitForChild("UpdateWidth") or Rep_Storage:FindFirstChild("UpdateWidth")

            local args = {
                [1] = 0
            }
            
            Update_Height_Remote:FireServer(unpack(args))
            wait()
            local args = {
                [1] = 0
            }
            
            Update_Depth_Remote:FireServer(unpack(args))
            wait()
            local args = {
                [1] = 0
            }
            
            Update_Width_Remote:FireServer(unpack(args))
            wait()
            local args = {
                [1] = 1
            }
            
            Update_Height_Remote:FireServer(unpack(args))
            wait()
            local args = {
                [1] = 1
            }
            
            Update_Depth_Remote:FireServer(unpack(args))
            wait()
            local args = {
                [1] = 1
            }
            
            Update_Width_Remote:FireServer(unpack(args))
        end
    else
        local Rep_Storage = game:GetService("ReplicatedStorage")
        local Modify_User_Remote = Rep_Storage:WaitForChild("ModifyUserEvent") or Rep_Storage:FindFirstChild("ModifyUserEvent")
        
        local Local_Player = getgenv().LocalPlayer
        local Local_Plr_Name = Local_Player.Name or tostring(Local_Player.Name)

        getgenv().CharFlick = false
        wait(1)
        repeat wait() until getgenv().CharFlick == false
        wait(0.3)
        local args = {
            [1] = tostring(Local_Plr_Name)
        }
        
        Modify_User_Remote:FireServer(unpack(args))
    end
end,})
wait()
print("Loading Connection Manager... :[Waiting On Response]:")
wait(.3)
local startEvent = Instance.new("BindableEvent")
startEvent.Name = "ConnectEvent"
startEvent.Parent = game:GetService("ReplicatedStorage")
wait(.1)
local disconnectEvent = Instance.new("BindableEvent")
disconnectEvent.Name = "DisconnectEvent"
disconnectEvent.Parent = game:GetService("ReplicatedStorage")
wait(0.2)
if startEvent and disconnectEvent then
    print("Loaded Connection Manager! -[200 : Success]-")
else
    warn("UNABLE TO LOAD CONNECTION MANAGER, BAD_REQUESTED_RESPONSE")
end
wait()
local Settings = {
    Keybind = "C"
}

local GetInvis = Tab2:CreateButton({
Name = "Invisible",
Callback = function()
    if getgenv().Invis_Loaded == true or Invis_Loaded and not getgenv().INVIS_DEBUG == true then
        return Notify_User("Error:", "Invisible Is Already Loaded!", 6.5)
    end

    local UserIds = {
        6132973250,
        4437551748,
        7054509230
    }
    
    pcall(function() getgenv().Invis_Loaded = true end)
    
    local ScriptStarted = false
    local Transparency = true
    local Keybind = Settings.Keybind
    local NoClip = true
    
    local Player = getgenv().LocalPlayer
    local RealCharacter = Player.Character or Player.CharacterAdded:Wait()
    
    local IsInvisible = false
    
    RealCharacter.Archivable = true

    local FakeCharacter = RealCharacter:Clone()
    local Workspace_Service = getgenv().Workspace

    local Part
    Part = Instance.new("Part", Workspace_Service)
    Part.Anchored = true
    Part.Size = Vector3.new(200, 1, 200)
    Part.CFrame = CFrame.new(9999, 50, 999)
    Part.CanCollide = true
    Part.Name = "BasePart"
    
    FakeCharacter.Parent = Workspace_Service
    FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
    
    for i, v in pairs(RealCharacter:GetChildren()) do
        if v:IsA("LocalScript") then
            local clone = v:Clone()
            clone.Disabled = true
            clone.Parent = FakeCharacter
        end
    end

    if Transparency then
        for i, v in pairs(FakeCharacter:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0.5
            end
        end
    end

    local CanInvis = true

    function RealCharacterDied()
        local Workspace_Service = getgenv().Workspace

        CanInvis = false
        RealCharacter:Destroy()
        RealCharacter = getgenv().Character
        CanInvis = true
        isinvisible = false
        FakeCharacter:Destroy()
        getgenv().Workspace.CurrentCamera.CameraSubject = RealCharacter:WaitForChild("Humanoid")
        
        RealCharacter.Archivable = true
        FakeCharacter = RealCharacter:Clone()
        Part:Destroy()
        Part = Instance.new("Part", Workspace_Service)
        Part.Anchored = true
        Part.Size = Vector3.new(200, 1, 200)
        Part.CFrame = CFrame.new(999, 999, 999)
        Part.CanCollide = true
        Part.Name = "MeshPart"
        FakeCharacter.Parent = Workspace_Service
        FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
        
        for i, v in pairs(RealCharacter:GetChildren()) do
            if v:IsA("LocalScript") then
                local clone = v:Clone()
                clone.Disabled = true
                clone.Parent = FakeCharacter
            end
        end

        if Transparency then
            for i, v in pairs(FakeCharacter:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Transparency = 0.8
                end
            end
        end

        RealCharacter.Humanoid.Died:Connect(function()
            getgenv().Invis_Loaded = false
            RealCharacter:Destroy()
            FakeCharacter:Destroy()
        end)
        Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
    end

    RealCharacter.Humanoid.Died:Connect(function()
        getgenv().Invis_Loaded = false
        RealCharacter:Destroy()
        FakeCharacter:Destroy()
    end)

    Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)

    local Run_Service = game:GetService("RunService")
    local PseudoAnchor
    Run_Service.RenderStepped:Connect(function()
        if PseudoAnchor ~= nil then
            PseudoAnchor.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
        end
        if NoClip then
            for i, v in pairs(FakeCharacter:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
    
    PseudoAnchor = FakeCharacter.HumanoidRootPart
    local function Invisible()
        if IsInvisible == false then
            local StoredCF = RealCharacter.HumanoidRootPart.CFrame
            RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
            FakeCharacter.HumanoidRootPart.CFrame = StoredCF
            RealCharacter.Humanoid:UnequipTools()
            Player.Character = FakeCharacter
            Workspace_Service.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
            PseudoAnchor = RealCharacter.HumanoidRootPart
            for i, v in pairs(FakeCharacter:GetChildren()) do
                if v:IsA("LocalScript") then
                    v.Disabled = false
                end
            end

            IsInvisible = true
        else
            local StoredCF = FakeCharacter.HumanoidRootPart.CFrame
            FakeCharacter.HumanoidRootPart.CFrame = RealCharacter.HumanoidRootPart.CFrame
            
            RealCharacter.HumanoidRootPart.CFrame = StoredCF
            
            FakeCharacter.Humanoid:UnequipTools()
            Player.Character = RealCharacter
            Workspace_Service.CurrentCamera.CameraSubject = RealCharacter.Humanoid
            PseudoAnchor = FakeCharacter.HumanoidRootPart
            for i, v in pairs(FakeCharacter:GetChildren()) do
                if v:IsA("LocalScript") then
                    v.Disabled = true
                end
            end

            IsInvisible = false
        end
    end

    local User_Input_Service = game:GetService("UserInputService")
    local Sound_Service = game:GetService("SoundService")
    
    User_Input_Service.InputBegan:Connect(function(key, gamep)
        if gamep then
            return
        end
        if key.KeyCode.Name:lower() == Keybind:lower() and CanInvis and RealCharacter and FakeCharacter then
            if RealCharacter:FindFirstChild("HumanoidRootPart") and FakeCharacter:FindFirstChild("HumanoidRootPart") then
                Invisible()
            end
        end
    end)
    local Sound = Instance.new("Sound",Sound_Service)
    Sound.SoundId = "rbxassetid://232127604"
    Sound:Play()
    Notify_User("Success!", "Invisible Has Been Loaded!", 7)
    task.wait(.3)
    Notify_User("Info:", "Press "..tostring(Settings.Keybind).." to change visibility.", 10)
end,})

local PrivRoomFloor = Tab10:CreateButton({
Name = "TP To Private Room (Inside)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(4220.82275, 2.76511836, 60.7681046)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(4220.82275, 2.76511836, 60.7681046)
    end
end,})

local NextToBathrooms = Tab10:CreateButton({
Name = "TP To Room Next To Bathrooms",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(-108.536659, 5.38924313, 135.303314)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(-108.536659, 5.38924313, 135.303314)
    end
end,})

local TPToBathrooms = Tab10:CreateButton({
Name = "TP To Bathrooms",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(-72.3955917, 5.09832525, 93.0914459)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(-72.3955917, 5.09832525, 93.0914459)
    end
end,})

local TPToChilling = Tab10:CreateButton({
Name = "TP To Chill Spot",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(228.970184, 5.75081444, -21.5613441)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(228.970184, 5.75081444, -21.5613441)
    end
end,})

local TPPicnicFirst = Tab10:CreateButton({
Name = "TP To Picnic (Seat 1)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(85.846756, 3.61196709, -29.8345909)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(85.846756, 3.61196709, -29.8345909)
    end
end,})

local TPPicnicSecond = Tab10:CreateButton({
Name = "TP To Picnic (Seat 2)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(76.6581955, 3.61196709, -29.8332996)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(76.6581955, 3.61196709, -29.8332996)
    end
end,})

local TPMicFirst = Tab10:CreateButton({
Name = "TP To Stage (Mic 1)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
        HumanoidRootPart.CFrame = CFrame.new(39.2528572, 7.80023623, -67.7634125)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
        HumanoidRootPart.CFrame = CFrame.new(39.2528572, 7.80023623, -67.7634125)
    end
end,})

local TPMicSecond = Tab10:CreateButton({
Name = "TP To Stage (Mic 2)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(14.8289356, 7.80023623, -67.7656097)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart

        HumanoidRootPart.CFrame = CFrame.new(14.8289356, 7.80023623, -67.7656097)
    end
end,})

local TPMiddleRoomArea = Tab10:CreateButton({
Name = "TP To Middle Room (Tent)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(70.9464493, 5.62692404, 24.2968006)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(70.9464493, 5.62692404, 24.2968006)
    end
end,})

local TPBoothRows = Tab10:CreateButton({
Name = "TP To Booth Rows (Table)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(26.7397423, 7.81395245, 86.7164536)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(26.7397423, 7.81395245, 86.7164536)
    end
end,})

local TPToTowerFloatPart = Tab10:CreateButton({
Name = "TP To Tower (Float Up Part)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(61.3288841, 72.0192184, 215.731613)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(61.3288841, 72.0192184, 215.731613)
    end
end,})

local TPToTowerTop = Tab10:CreateButton({
Name = "TP To Tower (Top)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(63.2298126, 284.407227, 193.529007)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(63.2298126, 284.407227, 193.529007)
    end
end,})

local TPToHighestPoint = Tab10:CreateButton({
Name = "TP To Tower (Highest Part)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(58.0468788, 313.312622, 225.215027)
    else 
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(58.0468788, 313.312622, 225.215027)
    end
end,})

local TPBooth1 = Tab10:CreateButton({
Name = "TP To Booth-1",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth01")
        Character:PivotTo(Booth:GetPivot())
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth01")
        Character:PivotTo(Booth:GetPivot())
    end
end,})

local TPBooth2 = Tab10:CreateButton({
Name = "TP To Booth-2",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth02")
        Character:PivotTo(Booth:GetPivot())
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth02")
        Character:PivotTo(Booth:GetPivot())
    end
end,})

local TPBooth3 = Tab10:CreateButton({
Name = "TP To Booth-3",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth03")
        Character:PivotTo(Booth:GetPivot())
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth03")
        Character:PivotTo(Booth:GetPivot())
    end
end,})

local TPBooth4 = Tab10:CreateButton({
Name = "TP To Booth-4",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth04")
        Character:PivotTo(Booth:GetPivot())
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth04")
        Character:PivotTo(Booth:GetPivot())
    end
end,})

local TPBooth5 = Tab10:CreateButton({
Name = "TP To Booth-5",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth05")
        Character:PivotTo(Booth:GetPivot())
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
        local Workspace = game:GetService("Workspace")
        local Booth_Folder = Workspace:FindFirstChild("Booth")
        local Booth = Booth_Folder:FindFirstChild("Booth05")
        Character:PivotTo(Booth:GetPivot())
    end
end,})

local TPToDonutShop = Tab10:CreateButton({
Name = "TP To Donut Shop",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-80.8301239, 3.1662631, -82.6656799)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-80.8301239, 3.1662631, -82.6656799)
    end
end,})

local TPSeat1Donut = Tab10:CreateButton({
Name = "TP To Donut Shop (Seat 1)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-98.4535675, 4.04168415, -96.7826004)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-98.4535675, 4.04168415, -96.7826004)
    end
end,})

local TPSeat1Donut = Tab10:CreateButton({
Name = "TP To Donut Shop (Seat 2)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-91.7390671, 4.04168415, -90.0620728)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-91.7390671, 4.04168415, -90.0620728)
    end
end,})

local TPTableSeat1 = Tab10:CreateButton({
Name = "TP To Donut Shop (Table Seat 1)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-102.440971, 4.51146317, -66.6184387)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-102.440971, 4.51146317, -66.6184387)
    end
end,})

local TPTableSeat2 = Tab10:CreateButton({
Name = "TP To Donut Shop (Table, Seat 2)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-94.6592941, 4.51146317, -74.3931046)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-94.6592941, 4.51146317, -74.3931046)
    end
end,})

local TPBehindCounter = Tab10:CreateButton({
Name = "TP To Donut Shop (Behind Counter)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-122.382172, 3.22726321, -83.5359192)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-122.382172, 3.22726321, -83.5359192)
    end
end,})

local TPAboveRelax = Tab10:CreateButton({
Name = "TP Above Relaxing Room",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-97.4412308, 24.4840164, 121.394676)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-97.4412308, 24.4840164, 121.394676)
    end
end,})

local TPSubmitNoteBoard = Tab10:CreateButton({
Name = "TP To Submit Note Board",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(58.6107864, 4.99999857, 245.690369)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(58.6107864, 4.99999857, 245.690369)
    end
end,})

local TPStageMic = Tab10:CreateButton({
Name = "TP To Stage Mic",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-61.6848221, 10.0853853, 229.676834)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(-61.6848221, 10.0853853, 229.676834)
    end
end,})

local TPPrivRoomRoof = Tab10:CreateButton({
Name = "TP To Private Room (Roof)",
Callback = function()
    wait(0.4)
    if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
        getgenv().Humanoid:ChangeState(3)
        task.wait(.2)
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(4220.37842, 23.5336628, 61.3636169)
    else
        local HumanoidRootPart = getgenv().HumanoidRootPart
    
        HumanoidRootPart.CFrame = CFrame.new(4220.37842, 23.5336628, 61.3636169)
    end
end,})

local invisKeybindSet = Tab2:CreateInput({
Name = "Invisible Keybind",
PlaceholderText = "Keybind Here",
RemoveTextAfterFocusLost = false,
Callback = function(TheBind)
    Settings.Keybind = tostring(TheBind)
    local Humanoid = getgenv().Humanoid
end,})

-- // Save this for later, because we can use this code to individually grab the Tic Tac Toe Model's and rename them and Parent them to a different Folder, will introduce this probably in the next couple updates.
-- // 12/16/2024 - 12:56 PM (EST) Edited.
--[[local models = {}
for _, obj in pairs(workspace:GetChildren()) do
    if obj:IsA("Model") and obj.Name == "Tic Tac Toe" then
        table.insert(models, obj)
    end
end

local folder = workspace:FindFirstChild("SelectedTicTacToe") or Instance.new("Folder")
folder.Name = "SelectedTicTacToe"
folder.Parent = workspace

for i, model in ipairs(models) do
    model.Name = "TicTac-" .. i
    model.Parent = folder
end--]]
wait(0.2)
for _, model in pairs(workspace:GetDescendants()) do
    if model:IsA("Model") and model.Name == "Tic Tac Toe" then
        local parent_to = game:GetService("Workspace"):FindFirstChild("PartStorage")
        model.Parent = parent_to
        if model.Parent == parent_to then
            print("True - Tic Tac Toe [Board(s) = 3]")
        else
            warn("False - Tic Tac Toe [Unable to identify location./nil] = nil")
        end
    end
end
wait(0.2)
if getgenv().tic_tac then
    print("// << -- valid -- >>")
    warn("// <-- Even though you likely returned the correct table/boolean/BoolValue [getgenv().tic_tac] <.here.>, it still works so, fuck off, I'll fix it when I feel like it -->")
else
    if game:GetService("Workspace"):FindFirstChild("PartStorage"):FindFirstChild("Tic Tac Toe") then
        print("Table Found: Tic Tac Toe [Boards(x3) ~= nil]")
        print("// Cached return value. --")
        warn("/#/ <<-- game:GetService('Workspace'):WaitForChild('PartStorage'):WaitForChild('Tic Tac Toe') ~= nil // .. We're not returning nil here, since we have correctly allocated table in our local startup. [initialization stage.]\nnever-the-less, do not acquire wrong memory table\nresulting in not-so-necessary errors appearing out of nowhere, since 'Tic Tac Toe' is located in just Workspace and has duplicates with the same 'Name' and 'ClassName'.")
    else
        warn("// Returning nil here, causing our functions to essentially eradicate themselves due to our selfishness of trying to prioritize performance over having a brain // :: \n So why now have it error out and not fix it like normal? Fuck you Solara, 60 FPS capped retard.")
        function clickAllTheDetectors()
            local clickDetectors = {}
    
            for _, model in pairs(workspace:GetDescendants()) do
                if model:IsA("Model") and model.Name == "Tic Tac Toe" then
                    for _, part in pairs(model:GetDescendants()) do
                        if part:IsA("Part") then
                            local clickDetector = part:FindFirstChildOfClass("ClickDetector")
                            if clickDetector then
                                table.insert(clickDetectors, clickDetector)
                            end
                        end
                    end
                end
            end
            
            for _, clickDetector in pairs(clickDetectors) do
                clickDetector.MaxActivationDistance = 99999
                fireclickdetector(clickDetector, 9999)
                fireclickdetector(clickDetector, 9999)
                fireclickdetector(clickDetector, 9999)
            end
        end
    end
end

function click_all_alt()
    local PartStorage = game.Workspace.PartStorage
    local TicTacToe = PartStorage:FindFirstChild("Tic Tac Toe")
    if TicTacToe then
        for _, v in ipairs(TicTacToe:GetDescendants()) do
            if v:IsA("ClickDetector") then
                fireclickdetector(v, 999)
            end
        end
    end
end
-- Validate for dear god, I hate the Tic Tac Toe shit, and I hate the No Rizz Config version of this script to.
wait(0.3)
local ClickingAllBoards = Tab5:CreateButton({
Name = "Click All TicTacToe Boards",
Callback = function()
    local PartStorage = game.Workspace.PartStorage
    local TicTacToeBoards = PartStorage:GetChildren()
    
    for _, board in ipairs(TicTacToeBoards) do
        if board.Name == "Tic Tac Toe" then
            for _, v in ipairs(board:GetDescendants()) do
                if v:IsA("ClickDetector") then
                    fireclickdetector(v, 999)
                end
            end
        end
    end
end,})

local LoopClickAllBoards = Tab5:CreateToggle({
Name = "Click All TicTacToe Boards (Loop)",
CurrentValue = false,
Flag = "loopClickingAllBoards",
Callback = function(ClickAll)
    if ClickAll then
        getgenv().doAllClicks = true
        while getgenv().doAllClicks do
            wait(0.9)
            local PartStorage = game.Workspace.PartStorage
            local TicTacToeBoards = PartStorage:GetChildren()

            for _, board in ipairs(TicTacToeBoards) do
                if board.Name == "Tic Tac Toe" then
                    for _, v in ipairs(board:GetDescendants()) do
                        if v:IsA("ClickDetector") then
                            fireclickdetector(v, 999)
                        end
                    end
                end
            end
        end
    else
        getgenv().doAllClicks = false
    end
end,})

local InfYield = Tab5:CreateButton({
Name = "Infinite Yield",
Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end,})

local WalkSpeedSliding = Tab2:CreateSlider({
Name = "WalkSpeed (Default): 16",
Range = {16, 450},
Increment = 1,
Suffix = "",
CurrentValue = 16,
Flag = "walkSpeedValue",
Callback = function(wsVal)
    local Humanoid = getgenv().Humanoid
    
    if Humanoid then
        Humanoid.WalkSpeed = wsVal
    end
end,})

if getgenv().Character:FindFirstChildWhichIsA("Humanoid").UseJumpPower == true then
    Rayfield:Notify({
        Title = "Success!",
        Content = "JumpPower is enabled, continuing...",
        Duration = 7,
        Image = 4483362458,
        Actions = {
           Ignore = {
            Name = "Okay!",
            Callback = function()
                print("...")
            end
           },
        },
    })
    wait()
    local JumpPowerSliding = Tab2:CreateSlider({
    Name = "JumpPower (Default): 50",
    Range = {50, 500},
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    Flag = "jpValue",
    Callback = function(jpVal)
        local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
    
        if Humanoid then
            Humanoid.JumpPower = jpVal
        end
    end,})
    wait()
else
    Rayfield:Notify({
        Title = "Detection!",
        Content = "UseJumpPower is disabled, switching...",
        Duration = 7,
        Image = 4483362458,
        Actions = {
           Ignore = {
            Name = "Okay!",
            Callback = function()
                print("...")
            end
           },
        },
    })
    wait(.2)
    local JumpingHeightSliding = Tab2:CreateSlider({
    Name = "JumpHeight (Default): 7",
    Range = {7, 400},
    Increment = 1,
    Suffix = "",
    CurrentValue = 7,
    Flag = "JumpingHeightValue",
    Callback = function(jumpHeight)
        local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:WaitForChild("Humanoid")
    
        if Humanoid then
            Humanoid.JumpHeight = jumpHeight
        end
    end,})
end

local GravSliding = Tab2:CreateSlider({
Name = "Gravity (Default): 196.2",
Range = {1, 200},
Increment = 1,
Suffix = "",
CurrentValue = 196.2,
Flag = "GravityValue",
Callback = function(gravVal)
    local GetWorkspace = getgenv().Workspace
    GetWorkspace.Gravity = gravVal
end,})

local antiBangTPLoop = Tab2:CreateToggle({
Name = "Anti Bang/TP (Loop Method)",
CurrentValue = false,
Flag = "AntiBangTPLooping",
Callback = function(doAntiTP)
if getgenv().doTeleport == true then
    getgenv().doTeleport = false
end
wait(0.5)
if doAntiTP then
    local Workspace = getgenv().Workspace
    local HumanoidRP = getgenv().HumanoidRootPart

    if HumanoidRP and HumanoidRP ~= nil then
        getgenv().doTeleport = true
        while getgenv().doTeleport == true do
        wait()
            HumanoidRP.CFrame = CFrame.new(4213.66602, 2.76511836, 67.6830292)
        end
    else
        warn("HumanoidRootPart was destroyed or is nil!")
        wait()
        getgenv().doTeleport = false
    end
else
    getgenv().doTeleport = false
    wait(.1)
    repeat wait() until getgenv().doTeleport == false
    wait(0.3)
    local Workspace = getgenv().Workspace
    local HumanoidRP = getgenv().HumanoidRootPart
    print("Teleporting Back...")
    wait()
    HumanoidRP.CFrame = CFrame.new(36.5316811, 4.99999952, 24.585743)
end
end,})

local bruhAntiTPMethod3 = Tab2:CreateButton({
Name = "Anti Bang/TP (Method 3, You Die To)",
Callback = function()
    local voidPosition = Vector3.new(-499, -499, -499)
    local Workspace = getgenv().Workspace
    local HumanoidRP = getgenv().HumanoidRootPart
    print("Killing...")
    wait(.4)
    HumanoidRP.CFrame = CFrame.new(voidPosition)
end,})

local MethodFourAntiTP = Tab2:CreateToggle({
Name = "Anti Bang/TP (Method 4, Void Method)",
CurrentValue = false,
Flag = "AntiTPMethod4",
Callback = function(getLoopTpToVoid)
    if getLoopTpToVoid then
        local putPositionTo = Vector3.new(-84385288, 69380040, 174817648)
        local Workspace = getgenv().Workspace
        local HumanoidRP = getgenv().HumanoidRootPart
            getgenv().loopTPToVoid = true
            while getgenv().loopTPToVoid == true do
            wait()
                HumanoidRP.CFrame = CFrame.new(putPositionTo)
            end
        else
            getgenv().loopTPToVoid = false
        wait()
        repeat wait() until getgenv().loopTPToVoid == false
        local HumanoidRootPart = getgenv().HumanoidRootPart
        HumanoidRootPart.CFrame = CFrame.new(36.5316811, 4.99999952, 24.585743)
    end
end,})

getgenv().material_toggle(true)
wait(0.2)
local LightingReset = Tab9:CreateButton({
Name = "Reset Lighting",
Callback = function()
    resetLightingSettings()
    wait(0.3)
    getgenv().material_toggle(false)
end,})

local fireworksToggle = Tab9:CreateToggle({
Name = "FireWorks (Sky)",
CurrentValue = false,
Flag = "FireworksInSkyLoop",
Callback = function(FireWorksCrazy)
if FireWorksCrazy then
    local Lighting = game:GetService("Lighting") or cloneref(game:GetService("Lighting"))
    Lighting.ClockTime = 1
    wait()
    Lighting.Brightness = 2
    wait()
    getgenv().setFireWorksOn = true
    while getgenv().setFireWorksOn == true do
    wait()
    local player = getgenv().LocalPlayer
    local Lighting = game:GetService("Lighting")
    
    local function createFirework(position)
        local firework = Instance.new("Part")
        firework.Size = Vector3.new(1, 1, 1)
        firework.Position = position
        firework.Anchored = true
        firework.CanCollide = false
        firework.Material = Enum.Material.Neon
        firework.Parent = workspace
    
        local explosion = Instance.new("ParticleEmitter")
        explosion.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(math.random(), math.random(), math.random())),
            ColorSequenceKeypoint.new(0.5, Color3.new(math.random(), math.random(), math.random())),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
        })
        explosion.Size = NumberSequence.new(2, 0)
        explosion.Lifetime = NumberRange.new(0.5, 1)
        explosion.Rate = 150
        explosion.Speed = NumberRange.new(75, 150)
        explosion.SpreadAngle = Vector2.new(180, 180)
        explosion.Parent = firework
    
        local light = Instance.new("PointLight")
        light.Brightness = 300
        light.Range = 200
        light.Color = Color3.new(1, 1, 1)
        light.Parent = firework
    
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://272537961"
        sound.Volume = 2.5
        sound.Parent = firework
        sound:Play()
    
        wait(0.1)
        explosion:Emit(200)
        wait(1)
        firework:Destroy()
    end
    
    local function launchFireworks()
        local xOffset = math.random(-50, 50)
        local yOffset = math.random(50, 100)
        local zOffset = math.random(-50, 50)
        local position = Vector3.new(xOffset, 50 + yOffset, zOffset)
    
        createFirework(position)
        wait(math.random(1, 2))
    end
    
    launchFireworks()
end
else
    getgenv().setFireWorksOn = false
    wait(0.5)
    resetLightingSettings()
end
end,})

local NightTimeButton = Tab9:CreateButton({
Name = "NightTime",
Callback = function()
    local Lighting = game:GetService("Lighting")
    if Lighting.ClockTime <= 1 then
        Lighting.ClockTime = 0
        wait()
        Lighting.Brightness = 0
    else
        resetLightingSettings()
        wait(0.2)
        Lighting.ClockTime = 0
        wait()
        Lighting.Brightness = 0
    end
end,})

local NightTimeWithLight = Tab9:CreateButton({
Name = "NightTime (With Night-Light)",
Callback = function()
local Lighting = game:GetService("Lighting")
if Lighting.ClockTime <= 2 then
    Lighting.ClockTime = 1
    wait()
    Lighting.Brightness = 2
else
    resetLightingSettings()
    wait(0.2)
    Lighting.ClockTime = 0
    wait()
    Lighting.Brightness = 0
end
end,})

local DayTimeReset = Tab9:CreateButton({
Name = "DayTime",
Callback = function()
    local Lighting = game:GetService("Lighting")
    Lighting.ClockTime = 12
    wait()
    Lighting.Brightness = 1.5
end,})

local SpookyMoonToggle = Tab9:CreateToggle({
Name = "Spooky Moon",
CurrentValue = false,
Flag = "SpookyMoonLooping",
Callback = function(moonCrazy)
local Lighting = game:GetService("Lighting") 
if moonCrazy then
    getgenv().SpookyMoon = true
    local sky = Lighting:FindFirstChildOfClass("Sky")

    local function smoothTransition()
        local Lighting = game:GetService("Lighting") 
        Lighting.ClockTime = 0
        for i = 1, 60, 0.5 do
            sky.MoonAngularSize = i
            wait(0.05)
        end
        for i = 60, 1, -0.5 do
            sky.MoonAngularSize = i
            wait(0.05)
        end
    end

    while getgenv().SpookyMoon == true do
        wait()
        smoothTransition()
    end
else
    local Lighting = game:GetService("Lighting")
    local sky = Lighting:FindFirstChildOfClass("Sky")
    wait(0.5)
    getgenv().SpookyMoon = false
    wait(1)
    getgenv().SpookyMoon = false
    wait(1)
    getgenv().SpookyMoon = false
    wait(3)
    resetLightingSettings()
    wait(0.3)
    sky.MoonAngularSize = 11
    wait(0.6)
    Lighting.ClockTime = 5
    wait(0.5)
    Lighting.ClockTime = 14
end
end,})

local SpookySunLoop = Tab9:CreateToggle({
Name = "Spooky Sun",
CurrentValue = false,
Flag = "SpookySunDayTime",
Callback = function(sunSpooky)
if sunSpooky then
    getgenv().SpookSun = true
    local Lighting = game:GetService("Lighting") 
    local sky = Lighting:FindFirstChildOfClass("Sky")

    local function smoothTransition()
        local Lighting = game:GetService("Lighting") 
        local sky = Lighting:FindFirstChildOfClass("Sky")
        Lighting.ClockTime = 14

        for i = 1, 60, 0.5 do
            sky.SunAngularSize = i
            wait(0.05)
        end
        for i = 60, 1, -0.5 do
            sky.SunAngularSize = i
            wait(0.05)
        end
    end
    
    while getgenv().SpookSun == true do
        wait()
        smoothTransition()
    end
else
    local Lighting = game:GetService("Lighting")
    local sky = Lighting:FindFirstChildOfClass("Sky")
    wait(0.5)
    getgenv().SpookSun = false
    wait(1)
    getgenv().SpookSun = false
    wait(0.5)
    getgenv().SpookSun = false
    wait(1.5)
    resetLightingSettings()
end
end,})

local SpookyNightTimeHalloween = Tab9:CreateButton({
Name = "Spooky NightTime (Halloween Style)",
Callback = function()
    local light = game:GetService("Lighting")

    light.Ambient = Color3.new(0, 0, 0)
    light.Brightness = 0
    light.ColorShift_Bottom = Color3.new(0, 0, 0)
    light.ColorShift_Top = Color3.new(0, 0, 0)
    light.GlobalShadows = true
    light.ShadowSoftness = 0.3
    light.Technology = Enum.Technology.Compatibility
    light.ClockTime = 3.5
    light.FogColor = Color3.new(0, 0, 0)
    light.FogEnd = 500
    light.FogStart = 500
    light.Bloom.Enabled = true
    light.Bloom.Intensity = 20
    light.Bloom.Size = 10
    light.Bloom.Threshold = 2
    light.DepthOfField.Enabled = false
    light.SunRays.Enabled = true
    light.SunRays.Intensity = 1
    light.SunRays.Spread = 3
end,})

local slowMotionToggle = Tab12:CreateToggle({
Name = "Slow Motion Emotes (Loop)",
CurrentValue = false,
Flag = "slowMotionAllEmotes",
Callback = function(slowMotionToggle)
    if slowMotionToggle then
        getgenv().slowMotionToggle = true
        while getgenv().slowMotionToggle == true do
        wait()
            local Humanoid = getgenv().Humanoid
            local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:AdjustSpeed(0.3)
            end
        end
    else
        getgenv().slowMotionToggle = false
        wait(0.5)
        local Humanoid = getgenv().Humanoid
        local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
        for _, v in pairs(ActiveTracks) do
            v:AdjustSpeed(1)
        end
        wait()
        for i,v in next, Humanoid:GetPlayingAnimationTracks() do
            v:Stop()
        end
    end
end,})

local FreezeEmotesToggle = Tab12:CreateToggle({
Name = "Freeze Emotes",
CurrentValue = false,
Flag = "FreezingEveryEmote",
Callback = function(freezeToggle)
    if freezeToggle then
        getgenv().doFreezeToggle = true
        while getgenv().doFreezeToggle == true do
        wait()
            local Humanoid = getgenv().Humanoid
            local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:AdjustSpeed(0)
            end
        end
    else
        getgenv().doFreezeToggle = false
        wait(0.5)
        local Humanoid = getgenv().Humanoid
        local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
        for _, v in pairs(ActiveTracks) do
            v:AdjustSpeed(1)
        end
        wait()
        for i,v in next, Humanoid:GetPlayingAnimationTracks() do
            v:Stop()
        end
    end
end,})

local FastestEmotes = Tab12:CreateToggle({
Name = "Fast Emotes (Loop)",
CurrentValue = false,
Flag = "FastEmotesEveryEmote",
Callback = function(fastToggle)
    if fastToggle then
        getgenv().fastToggle = true
        while getgenv().fastToggle == true do
        wait()
            local Humanoid = getgenv().Humanoid
            local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
            for _, v in pairs(ActiveTracks) do
                v:AdjustSpeed(70)
            end
        end
    else
        getgenv().fastToggle = false
        wait(0.5)
        local Humanoid = getgenv().Humanoid
        local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
        for _, v in pairs(ActiveTracks) do
            v:AdjustSpeed(1)
        end
        wait()
        for i,v in next, Humanoid:GetPlayingAnimationTracks() do
            v:Stop()
        end
    end
end,})

local StopAllEmotes = Tab12:CreateButton({
Name = "Stop Playing Emotes",
Callback = function()
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for i,v in next, Humanoid:GetPlayingAnimationTracks() do
        v:Stop()
    end
end,})

local EmoteSlidingSpeed = Tab12:CreateSlider({
Name = "Emote Speed Slider",
Range = {0, 300},
Increment = 1,
Suffix = "",
CurrentValue = 1,
Flag = "EmoteSpeedSliding",
Callback = function(slidingSpeed)
    local getEmoteNum = tonumber(slidingSpeed) or slidingSpeed
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(getEmoteNum)
    end
end,})

local InputSpeedBox = Tab12:CreateInput({
Name = "Emote Speed",
PlaceholderText = "Number",
RemoveTextAfterFocusLost = true,
Callback = function(inputNum)
    local getNumberInput = tonumber(inputNum)
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(getNumberInput)
    end
end,})

local SpeedTheEmoteUp = Tab12:CreateButton({
Name = "Kinda Fast Emote Speed",
Callback = function()
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(2)
    end
end,})

local GettingFaster = Tab12:CreateButton({
Name = "Faster Emote Speed",
Callback = function()
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(4.5)
    end
end,})

local BackToNormalSpeed = Tab12:CreateButton({
Name = "Normal Emote Speed",
Callback = function()
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(1)
    end
end,})

local SlowerEmoteSpeed = Tab12:CreateButton({
Name = "Slow Emote Speed",
Callback = function()
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(0.5)
    end
end,})

local SlowingTheEmoteDown = Tab12:CreateButton({
Name = "Super Slow Emote Speed",
Callback = function()
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(0.1)
    end
end,})

local ReverseTheEmote = Tab12:CreateButton({
Name = "Reverse Emote Speed",
Callback = function()
    local Humanoid = getgenv().Humanoid
    local ActiveTracks = Humanoid:GetPlayingAnimationTracks()
    for _, v in pairs(ActiveTracks) do
        v:AdjustSpeed(-1)
    end
end,})

local FreeEmotesGUI = Tab12:CreateButton({
Name = "Free Emotes GUI",
Callback = function()
    getgenv().notify("Free Emotes:", "Press , [comma] to open Free Emotes GUI", 5)
    task.wait(.1)
    getgenv().notify("Open Button:", "Or use the button on the left side of your screen.", 4)
    task.wait()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/LmaoItsCrazyBro/qweytguqwebuqt/refs/heads/main/marked_esp_system_ai"))()
end,})

local MuteAllBruh = Tab1:CreateToggle({
Name = "Mute All",
CurrentValue = false,
Flag = "MutingEveryone",
Callback = function(TheMuteAll)
    if TheMuteAll then
        getgenv().LmaoGetMuted = true
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= getgenv().LocalPlayer then
                local audio = v:FindFirstChild("AudioDeviceInput")
                if audio then
                    audio.Muted = true
                end
            end
        end
    else
        getgenv().LmaoGetMuted = false
        wait(0.2)
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= getgenv().LocalPlayer then
                local audio = v:FindFirstChild("AudioDeviceInput")
                if audio then
                    audio.Muted = false
                end
            end
        end
    end
end,})

local MuteAPlayerSpecific = Tab1:CreateInput({
Name = "Mute Player",
PlaceholderText = "User",
RemoveTextAfterFocusLost = true,
Callback = function(getAUser)
    local derUser = findplr(getAUser)
    
    if derUser then
        getgenv().shouldMute = true
    
        local function monitorPlayerAudio(player)
            local audioDevice = player:FindFirstChild("AudioDeviceInput")
            if audioDevice then
                if getgenv().shouldMute == true then
                    audioDevice.Muted = true
                end

                if property == "Muted" and getgenv().shouldMute == true and not audioDevice.Muted then
                    audioDevice.Muted = true
                    wait()
                    Rayfield:Notify({
                        Title = "Success!",
                        Content = tostring(derUser).." was muted successfully!",
                        Duration = 7,
                        Image = 4483362458,
                        Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("...")
                            end
                            },
                        },
                    })
                end
            end
        end
    
        monitorPlayerAudio(derUser)
    else
        getgenv().shouldMute = false
        return Rayfield:Notify({
            Title = "Error: Not Found",
            Content = tostring(getAUser).." was not found!",
            Duration = 7,
            Image = 4483362458,
            Actions = {
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
            },
            },
        })
    end
end,})

ResetButton = Tab15:CreateButton({
Name = "Reset",
Callback = function()
    local Humanoid = getgenv().Humanoid
    wait()
    if getgenv().LocalPlayer.Character and getgenv().Character and getgenv().Character:FindFirstChildWhichIsA("Humanoid") and getgenv().Humanoid and Humanoid then
        Humanoid.Health = 0
    end
end,})

RejoinButton = Tab15:CreateButton({
Name = "Rejoin",
Callback = function()
    local TeleportService = getgenv().TeleportService
    local JobId = game.JobId
    local PlaceId = game.PlaceId
    wait()
    TeleportService:TeleportToPlaceInstance(PlaceId, JobId, getgenv().LocalPlayer)
end,})

ServerHopButton = Tab15:CreateButton({
Name = "Server Hop (Roblox broke this!)",
Callback = function()
    -- Thanks 'Infinite Yield' I am NOT trying to make any of this right now.
    httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    local PlaceId = game.PlaceId
    
    local JobId = game.JobId
    local TeleportService = game:GetService("TeleportService")
    local HttpService = game:GetService("HttpService")
    
    if httprequest then
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
        local body = HttpService:JSONDecode(req.Body)

        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end
    else
        return print("Serverhop", "httprequest is unsupported.")
    end

    if #servers > 0 then
        getgenv().TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], getgenv().LocalPlayer)
    else
        return print("Serverhop", "Couldn't find a server.")
    end
end,})

ChangeUILibColor = Tab15:CreateColorPicker({
Name = "Change UI Color",
Color = Color3.fromRGB(30, 30, 30),
Flag = "UIColoringFunc",
Callback = function(UIColor)
    local rayfield = getgenv().Rayfield

    local function changeColors(object, frameColor)
        if object and object:IsA("ScreenGui") then
            for _, descendant in pairs(object:GetDescendants()) do
                if descendant:IsA("Frame") then
                    descendant.BackgroundColor3 = frameColor
                end
            end
        else
            warn("Rayfield ScreenGui not found!")
        end
    end

    local newFrameColor = UIColor

    changeColors(rayfield, newFrameColor)
end,})

ReExecuteGUI = Tab15:CreateButton({
Name = "Re-Execute GUI",
Callback = function()
    getgenv().getLoopKick = false
    getgenv().SCRIPT_EXECUTED = false
    getgenv().SCRIPT_EXECUTED = false
    getgenv().Invis_Loaded = false
    getgenv().GetLoopRunning = false
    getgenv().GetLoopRunning = false
    getgenv().LmaoGetMuted = false
    getgenv().css_digital = false
    Rayfield:Destroy()
    wait(0.5)
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta')))()
end,})

DestroyGUIScript = Tab15:CreateButton({
Name = "Destroy GUI/Script",
Callback = function()
    getgenv().getLoopKick = false
    wait(0.2)
    getgenv().SCRIPT_EXECUTED = false
    getgenv().SCRIPT_EXECUTED = false
    getgenv().Invis_Loaded = false
    getgenv().GetLoopRunning = false
    getgenv().GetLoopRunning = false
    getgenv().LmaoGetMuted = false
    getgenv().css_digital = false
    wait(.3)
    Rayfield:Destroy()
end,})

UnmuteAPlayer = Tab1:CreateInput({
Name = "Unmute Player",
PlaceholderText = "User",
RemoveTextAfterFocusLost = true,
Callback = function(LolPUser)
    local thisUser = findplr(LolPUser)

    if thisUser then
        getgenv().shouldMute = false
    
        local function monitorPlayerAudio(player)
            local audioDevice = thisUser:FindFirstChild("AudioDeviceInput")
            if audioDevice then
                if getgenv().shouldMute == false then
                    audioDevice.Muted = false
                end

                if property == "Muted" and getgenv().shouldMute == false and audioDevice.Muted then
                    audioDevice.Muted = false
                    wait()
                    Rayfield:Notify({
                        Title = "Success!",
                        Content = tostring(thisUser).." was unmuted successfully!",
                        Duration = 7,
                        Image = 4483362458,
                        Actions = {
                           Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("...")
                            end
                           },
                        },
                    })
                end
            end
        end
    
        monitorPlayerAudio(thisUser)    
    else
        getgenv().shouldMute = false
        return Rayfield:Notify({
            Title = "Error: Not Found",
            Content = tostring(LolPUser).." was not found!",
            Duration = 7,
            Image = 4483362458,
            Actions = {
               Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
               },
            },
        })
    end
end,})

getgenv().run_Shift_Speed = 450
wait(0.2)
ShifTToRunSpeed = Tab2:CreateInput({
Name = "Shift_To_Run Speed",
PlaceholderText = "Speed",
RemoveTextAfterFocusLost = true,
Callback = function(get_speed)
    getgenv().run_Shift_Speed = tonumber(get_speed)

    local player = getgenv().LocalPlayer
    if getgenv().runningEnabled and player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = getgenv().run_Shift_Speed
        end
    end
end,})
wait(0.1)
ShiftToRun = Tab2:CreateToggle({
Name = "Shift To Run",
CurrentValue = false,
Flag = "SpeedCoilAlt",
Callback = function(speedCoil)
    if speedCoil then
        getgenv().runningEnabled = true
        
        local player = game.Players.LocalPlayer
        local walkSpeed = 16
        
        local function setupCharacter(character)
            local humanoid = character:WaitForChild("Humanoid") or character:FindFirstChild("Humanoid")
            
            local function onShiftPress(input, gameProcessed)
                if input.KeyCode == Enum.KeyCode.LeftShift and not gameProcessed and getgenv().runningEnabled then
                    humanoid.WalkSpeed = getgenv().run_Shift_Speed
                end
            end
        
            local function onShiftRelease(input, gameProcessed)
                if input.KeyCode == Enum.KeyCode.LeftShift and not gameProcessed and getgenv().runningEnabled then
                    humanoid.WalkSpeed = walkSpeed
                end
            end
        
            game:GetService("UserInputService").InputBegan:Connect(onShiftPress)
            game:GetService("UserInputService").InputEnded:Connect(onShiftRelease)
        
            humanoid.WalkSpeed = walkSpeed
        end
        
        player.CharacterAdded:Connect(function(character)
            setupCharacter(character)
        end)
        
        if player.Character then
            setupCharacter(player.Character)
        end
    else
        local player = getgenv().LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = getgenv().Humanoid
    
        humanoid.WalkSpeed = 16
        getgenv().runningEnabled = false
    end
end,})    

function run_anims() 
    local player = game.Players:FindFirstChild("L0CKED_1N1")
    if not player then return end

    print("Found Owner: L0CKED_1N1")

    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:FindFirstChild("Animate") or character:WaitForChild("Animate", 1.5)

    if not Animate then return end

    Animate.Disabled = true
    wait(0.1)
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    wait(0.2)
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=133806214992291"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=94970088341563"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=16738336650"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=16738332169"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=129773241321032"
    wait(0.2)
    if humanoid then
        humanoid:ChangeState(3)
    end
end

function do_anims_func()
    local player = game.Players:FindFirstChild("L0CKED_1N1")
    if not player then
        warn("Owner was not found: L0CKED_1N1")
        return 
    end

    player.CharacterAdded:Connect(run_anims)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
        run_anims()
    end
end

if getgenv().ownerAnimsLoaded == nil then
    getgenv().ownerAnimsLoaded = false
end

if getgenv().LocalPlayer.Name == "L0CKED_1N1" and getgenv().ownerAnimsLoaded then 
    warn("Owner-Animations already loaded!")
elseif getgenv().LocalPlayer.Name == "L0CKED_1N1" and not getgenv().ownerAnimsLoaded then
    if typeof(do_anims_func) == "function" then
        do_anims_func()
        getgenv().ownerAnimsLoaded = true
    else
        warn("Error: Animation function is missing!")
    end
else
    warn("Owner-Animation Packages not loaded, not owner.")
end

function create_Button(localName, Name, callback) 
    local localName = Tab17:CreateButton({
        Name = tostring(Name),
        Callback = callback
    })
end

create_Button(CatWalkGlamAnim, "[NEW] 'Catwalk Glam' Animation Package", function()
    local player = getgenv().LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:WaitForChild("Animate")

    if not Animate then return end

    Animate.Disabled = true
    task.wait()
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=133806214992291"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=94970088341563"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=109168724482748"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=81024476153754"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=116936326516985"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=119377220967554"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=92294537340807"
    task.wait()
    Animate.Disabled = false
end)

create_Button(WickedPopularAnim, "[NEW] 'Wicked Popular' Animation Package", function()
    local player = getgenv().LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:WaitForChild("Animate")

    if not Animate then return end

    Animate.Disabled = true
    task.wait()
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=118832222982049"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=76049494037641"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=92072849924640"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=72301599441680"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=104325245285198"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=131326830509784"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=121152442762481"
    task.wait()
    Animate.Disabled = false
end)

create_Button(adidasAnim, "Adidas Animation Package", function()
    local player = getgenv().LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:WaitForChild("Animate")

    if not Animate then return end

    Animate.Disabled = true
    task.wait()
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=18537376492"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=18537371272"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=18537392113"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=18537384940"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=18537380791"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=18537363391"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=18537367238"
    task.wait()
    Animate.Disabled = false
end)

create_Button(NFLAnim, "NFL Animation Package", function()
    local player = getgenv().LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:WaitForChild("Animate")

    if not Animate then return end

    Animate.Disabled = true
    task.wait()
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=92080889861410"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=74451233229259"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=110358958299415"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=117333533048078"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=119846112151352"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=134630013742019"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=129773241321032"
    task.wait()
    Animate.Disabled = false
end)

create_Button(BoldAnim, "Bold Animation Package", function()
    local player = getgenv().LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:WaitForChild("Animate")

    if not Animate then return end

    Animate.Disabled = true
    task.wait()
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=16738333868"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=16738334710"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=16738340646"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=16738337225"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=16738336650"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=16738332169"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=16738333171"
    task.wait()
    Animate.Disabled = false
end)

create_Button(noBoundariesAnim, "No Boundaries Animation Package", function()
    local player = getgenv().LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:WaitForChild("Animate")

    if not Animate then return end

    Animate.Disabled = true
    task.wait()
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=18747067405"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=18747063918"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=18747074203"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=18747070484"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=18747069148"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=18747060903"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=18747062535"
    task.wait()
    Animate.Disabled = false
end)

create_Button(robotAnim, "Robot Animation Package", function()
    local player = getgenv().LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local Animate = character:WaitForChild("Animate")

    if not Animate then return end

    Animate.Disabled = true
    task.wait()
    Animate.Disabled = false

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
    end

    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=10921248039"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=10921248831"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=10921255446"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=10921250460"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=10921252123"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=10921247141"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=10921251156"
    task.wait()
    Animate.Disabled = false
end)

create_Button(zombieAnim, "Zombie Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
    wait()
    Animate.Disabled = false
end)

create_Button(HeroAnim, "Hero Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
    wait()
    Animate.Disabled = false
end)

create_Button(vampireAnim, "Vampire Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
    wait()
    Animate.Disabled = false
end)

create_Button(mageAnim, "Mage Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
    wait()
    Animate.Disabled = false
end)

create_Button(ghostAnim, "(FE) Ghost Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
    wait()
    Animate.Disabled = false
end)

create_Button(elderAnim, "Elder Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
    wait()
    Animate.Disabled = false
end)

create_Button(LevitationAnim, "Levitation Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
    wait()
    Animate.Disabled = false
end)

create_Button(AstronautAnim, "Astronaut Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
    wait()
    Animate.Disabled = false
end)

create_Button(NinjaAnim, "Ninja Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
    wait()
    Animate.Disabled = false
end)

create_Button(WerewolfAnim, "Werewolf Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
    wait()
    Animate.Disabled = false
end)

create_Button(CartoonAnim, "Cartoon Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
    wait()
    Animate.Disabled = false
end)

create_Button(PirateAnim, "Pirate Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
    wait()
    Animate.Disabled = false
end)

create_Button(SneakyFEAnim, "(FE) Sneaky Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1132473842"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1132477671"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1132510133"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1132494274"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1132489853"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1132461372"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1132469004"
    wait()
    Animate.Disabled = false
end)

create_Button(ToyAnim, "Toy Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
    wait()
    Animate.Disabled = false
end)

create_Button(KnightAnim, "Knight Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"
    wait()
    Animate.Disabled = false
end)

create_Button(ConfidentFEAnim, "(FE) Confident Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1069977950"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1069987858"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1070017263"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1070001516"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1069984524"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1069946257"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1069973677"
    wait()
    Animate.Disabled = false
end)

create_Button(PopstarFEAnim, "(FE) Popstar Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980338"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980348"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1212954642"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1213044953"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1212900995"
    wait()
    Animate.Disabled = false
end)

create_Button(PrincessFEAnim, "(FE) Princess Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=941003647"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=941013098"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=941028902"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=941015281"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=941008832"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=940996062"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=941000007"
    wait()
    Animate.Disabled = false
end)

create_Button(CowboyFEAnim, "(FE) Cowboy Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1014390418"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1014398616"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1014421541"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1014401683"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1014394726"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1014380606"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1014384571"
    wait()
    Animate.Disabled = false
end)

create_Button(PatrolFEAnim, "(FE) Patrol Animation Package", function()
    local Animate = getgenv().LocalPlayer.Character.Animate
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1149612882"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1151231493"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1150967949"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1150944216"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1148863382"
    wait()
    Animate.Disabled = false
end)

create_Button(ZombieFEAnim, "(FE) Zombie Animation Package", function()
    local Animate = getgenv().Character:FindFirstChild("Animate")
    Animate.Disabled = true
    wait()
    Animate.Disabled = false
    local animtrack = getgenv().Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=3489171152"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=3489171152"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=3489174223"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=3489173414"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
    wait()
    Animate.Disabled = false
end)

SystemBroken = Tab5:CreateButton({
Name = "System Broken",
Callback = function()
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/main/source"))()
    else
        Rayfield:Notify({
            Title = "Error!",
            Content = "This is NOT Mic Up, Exiting...",
            Duration = 7,
            Image = 4483362458,
            Actions = {
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("...")
                end
            },
            },
        })
        wait(1)
        getgenv().LocalPlayer:Kick("This is not MIC UP, Please join MIC UP.")
    end
end,})

ScriptOwnersLabel = Tab15:CreateParagraph({Title = "Script Owner:", Content = "M1RD3RCAUGHT [Deleted] | ItsYoDawgWsgGng | [Deleted]"})
wait()
MadeEasy = Tab15:CreateParagraph({Title = "Zacks Easy Hub", Content = "Scripting Made Easy"})
YouTube_Plug = Tab15:CreateParagraph({Title = "Zacks Easy Hub", Content = "https://www.youtube.com/@AnonymousExploiting"})
Discord_Plug = Tab15:CreateParagraph({Title = "Zacks Easy Hub", Content = "https://discord.gg/VJh3kkYzBn"})
JoinDiscordLabel = Tab15:CreateParagraph({Title = "Zacks Easy Hub", Content = "Join the discord for juicy updates, and maybe giveaways."})
Release_Date = Tab15:CreateParagraph({Title = "Zacks Easy Hub", Content = "V6 Released On: 11/5/2024"})
Scammers = Tab15:CreateParagraph({Title = "Zacks Easy Hub", Content = "If you bought this, you got scammed."})
ScriptIsOpen_Source = Tab15:CreateParagraph({Title = "Zacks Easy Hub", Content = "This script is open source, but still credit me."}) 
end
wait(0.4)
getgenv().start_Script()
task.wait()
print("Running...")
wait(0.2)
if getgenv().camera_zoom_data then
    print("CameraMaxZoomDistance - Data | True")
else
    getgenv().camera_zoom_data = false
    wait(0.5)
    getgenv().LocalPlayer.CameraMaxZoomDistance = 800000
    getgenv().camera_zoom_data = true
    wait(0.1)
end
wait(0.2)
print("Getting Requirements... [1 moment.]")
wait(0.3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/PrivateBecauseYes/refs/heads/main/armsConvert.js", true))()
wait(0.4)
if getgenv().Has_Died_Func then
    warn("Already setup death function.")
else
    getgenv().Humanoid.Health = 0
    getgenv().Has_Died_Func = true
    wait(0.1)
    print("Died Func setup")
end
wait(0.3)
print("Successfully ran!")
task.wait()
print("YEAH! Zacks Easy Hub [ON TOP!]")
wait(0.5)
if getgenv().performance_stats then
    warn("Performance stats checked.")
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/OrionLibraryReWrittenCelery/refs/heads/main/grab_file_performance"))()
    wait(0.2)
    local coreGuiTypeNames = {
        ["inventory"] = Enum.CoreGuiType.Backpack,
        ["leaderboard"] = Enum.CoreGuiType.PlayerList,
        ["emotes"] = Enum.CoreGuiType.EmotesMenu
    }
    
    for _, enumItem in ipairs(Enum.CoreGuiType:GetEnumItems()) do
        if enumItem == Enum.CoreGuiType.Health and enumItem ~= Enum.CoreGuiType.SelfView then
            game:GetService("StarterGui"):SetCoreGuiEnabled(enumItem, false)
        end
    end
    wait(0.1)
    if game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Health) then
        print("Health CoreGuiType.Enabled: True")
    else
        warn("Health CoreGuiType.Enabled: False")
    end
    wait(0.1)
    getgenv().performance_stats = true
end
