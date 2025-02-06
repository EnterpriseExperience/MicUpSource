--[[
    ['Current Scope - START']: Graphical Data.
        <---------------------------->
        A. Updates now usually only include stabilization, performance and bug fixes.
        B. If you distribute, advertise, or promote this script or use it in any video at all, examples include: using our source on script's you make, you MUST include my credit, otherwise you will be forced to shutdown.
        C. Do not obfuscate my script, as this project is open source and the compatibility will not hold up while obfuscated, since this script is over ~6,970+ lines long.
        D. You must abide by the 'User Agreement' and adhere to our 'Guidelines' and 'Policies' when utilizing our 'ALL-FREE' services [You can find this posted to our Discord.]
        E. We are advancing soon to new game's and going to release more products and services, and have more content coming soon.
        F. We have released a Neighbors script in our Discord: https://discord.gg/VJh3kkYzBn
        G. If you are reading this, we are also releasing an all out universal Admin script that'll also have bypass WalkSpeed, JumpPower, Fly, etc and let you fly and do orbit, etc.
        H. Remember to always chase your dreams! they will always catch back up to you one way or another, I only started this Discord in September of 2024, and it's MASSIVE, with over 1,200 people already.
        <---------------------------->
    ['Current Scope - END']: Graphical Data.
--]]

    --[[
        Animation Packages: Zombie, Catwalk Glam, Elder, Cartoony, Adidas,
        Adidas, Werewolf, Vampire, Astronaut,
        Superhero, Knight, Mage, Ninja,
        Toy, NFL, No Boundaries, Oldschool,
        Pirate, Levitation, Bubbly, Robot,
        Wicked Popular, Bold, Stylish,
        Rthro [default Roblox Animation package]
    --]]

    -- Don't touch this for now, it's just the default for a fallback, not to be edited, because then you won't be able to revert your configuration to the base settings without losing all data.
    local __DEFAULT_CONFIGURATION = {
        -- Use the names above to choose and load custom Animation Packages (they will keep on respawn to).
        Custom_Animation_Package_System = "on",
        Animation_Idle = "Vampire",
        Animation_Walk = "Adidas",
        Animation_Run = "Adidas",
        Animation_Jump = "Zombie",
        Animation_Fall = "Zombie",
        Animation_Climb = "Levitation",
        Death_On_Load = "on",
        AntiAFK = "on",
        Loading_Screen = "on",
        Mute_Boomboxes_Cellmates_VC_Game_Setting = "on", -- Will mute the Boomboxes in the game: "Cellmates (VC)"
        Mute_Music_Volume_Cellmates_VC_Game_Setting = "on", -- Will mute the Music Volume in the game: "Cellmates (VC)"
        Mute_Sound_Effects_Cellmates_VC_Game_Setting = "on", -- Will mute the Sound Effects in the game: "Cellmates (VC)"
        System_Broken_Title = "off",
        System_Broken_Text_Title = "System Broken New Title Here",
        Fully_Loaded_Messaging = "on",
        Fully_Loaded_Message = "Zacks Easy Hub - Winning.", -- Custom message you want to chat when the script fully loads all the way.
        Huge_Baseplate = "on",
        Script_Clock_Time_GUI = "on",
        Anti_Suspend_VC = "on",
        Infinite_Yield_Premium = "on",
        Performance_Statistics = "on",
        Old_Materials = "on",
        System_Broken = "on",
        keep_tp_tool = "off",
    }
    wait(0.2)
    if isfile and isfile("emoteFile.json") then
        print("True - File Exists, deleting...")
        delfile("emoteFile.json")
        wait(0.4)
        print("Deleted.")
    else
        warn("emoteFile.json does not exist. EXIT_STATUS:[0]")
    end
    wait(0.3)
    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function detectExecutor()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_Name = detectExecutor()
    wait(0.3)
    local vc_service = cloneref and cloneref(game:GetService("VoiceChatService")) or game:GetService("VoiceChatService")
    local enabled_vc = vc_service:IsVoiceEnabledForUserIdAsync(game.Players.LocalPlayer.UserId)
    local Notification
    wait(0.5)
    -- This is a decent Notification Library, as it includes features such as: 'Warnings', 'Errors', and other useful techniques and functions.
    if executor_Name == "Nihon" then
        print("Executor Detected: Nihon | Using alternate notification system.")
        httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

        local response = httprequest({
            Url = "https://raw.githubusercontent.com/laagginq/ui-libraries/main/dxhooknotify/src.lua",
            Method = "GET"
        })

        if response and response.StatusCode == 200 then
            Notification = loadstring(response.Body)()
        else
            print("Failed to fetch script:", response.StatusCode)
        end
    else
        Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/rwetyrweyeywy/refs/heads/main/get_notify.lua"))()
    end
    -- [] -->> Make sure the script it's self does not get executed more then once, when executed, they will need to click the Re-Execute GUI button to restart the script. <<-- [] --
    if SCRIPT_EXECUTED or getgenv().SCRIPT_EXECUTED and not _G.SCRIPT_EXECUTED == true then
        -- I want to keep the 2 notifications, it make's it more easier for observing details without trying to compact it into 1 big title screen.
        if executor_Name == "Nihon" then
            return Notification:Notify("Heads Up!", "Zacks Easy Hub is already running!", 7.5)
        else
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
            return
        end
        -- Wait 7 seconds so the user has time to see it (unlike waiting like 3 seconds or something).
    end
    pcall(function() getgenv().SCRIPT_EXECUTED = true end)
    wait(0.3)
    if enabled_vc == true and executor_Name == "Nihon" then
        Notification:Notify("Success!", "Connected with VC successfully!", 5)
    elseif enabled_vc == true and executor_Name ~= "Nihon" then
        Notification.Notify("Success!", "Connected with VoiceChat successfully!", "rbxassetid://93594537601787", {
            Duration = 5,       
            Main = {
                Rounding = true,
            }
        });
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
    wait(0.2)
    if getgenv().clock_script_time then
        warn("Already loaded Clock GUI or user has already clicked 'No'")
    else
        if getgenv().Easies_Configuration["Script_Clock_Time_GUI"] == "on" or getgenv().Easies_Configuration["Script_Clock_Time_GUI"] == "On" or getgenv().Easies_Configuration["Script_Clock_Time_GUI"] == "Enabled" then
            local ClockGUI = Instance.new("ScreenGui")
            local Clock_Frame = Instance.new("ImageLabel")
            local time_label = Instance.new("TextLabel")
            local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart", 1)
            local HRP = humanoidRootPart
            local HumanoidRootPart = humanoidRootPart
            local hrp = humanoidRootPart
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid", 1)
            local human = Humanoid
            local Human = Humanoid
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            local COREGUI = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
            local hiddenUI = get_hidden_gui or gethui

            function randomString()
                local length = math.random(10,20)
                local array = {}
                for i = 1, length do
                    array[i] = string.char(math.random(32, 126))
                end
                return table.concat(array)
            end
            wait(0.1)
            ClockGUI.Name = "Script_Clock_Time_Day_Night"
            ClockGUI.ResetOnSpawn = false
            ClockGUI.Parent = PlayerGui
            ClockGUI.IgnoreGuiInset = true

            Clock_Frame.Name = "Clock_Frame"
            Clock_Frame.Parent = ClockGUI
            Clock_Frame.Active = true
            Clock_Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Clock_Frame.BackgroundTransparency = 1.000
            Clock_Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Clock_Frame.Position = UDim2.new(0.772566795, 0, 0.0113268606, 0)
            Clock_Frame.Size = UDim2.new(0, 249, 0, 46)
            Clock_Frame.Image = "rbxassetid://3570695787"
            Clock_Frame.ImageColor3 = Color3.fromRGB(45, 45, 45)
            Clock_Frame.ScaleType = Enum.ScaleType.Slice
            Clock_Frame.SliceCenter = Rect.new(100, 100, 100, 100)
            Clock_Frame.SliceScale = 0.120

            time_label.Name = "time_label"
            time_label.Parent = Clock_Frame
            time_label.Active = true
            time_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            time_label.BackgroundTransparency = 1.000
            time_label.BorderColor3 = Color3.fromRGB(0, 0, 0)
            time_label.BorderSizePixel = 0
            time_label.Position = UDim2.new(0, 0, -0.00659200316, 0)
            time_label.Size = UDim2.new(0, 249, 0, 46)
            time_label.Font = Enum.Font.Unknown
            time_label.Text = "Detecting Script Time..."
            time_label.TextColor3 = Color3.fromRGB(255, 255, 255)
            time_label.TextScaled = true
            time_label.TextSize = 14.000
            time_label.TextWrapped = true
            
            local Lighting = cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
            local Sky = Lighting:FindFirstChildOfClass("Sky")

            if Sky or Lighting:FindFirstChildOfClass("Sky") then
                Sky.SkyboxBk = "rbxassetid://591058823"
                Sky.SkyboxDn = "rbxassetid://591059876"
                Sky.SkyboxFt = "rbxassetid://591058104"
                Sky.SkyboxLf = "rbxassetid://591057861"
                Sky.SkyboxRt = "rbxassetid://591057625"
                Sky.SkyboxUp = "rbxassetid://591059642"
                Sky.StarCount = 10000
            else
                local Sky_Box = Instance.new("Sky")
                Sky_Box.Name = "Sky"
                Sky_Box.Parent = Lighting
                Sky_Box.SkyboxBk = "rbxassetid://591058823"
                Sky_Box.SkyboxDn = "rbxassetid://591059876"
                Sky_Box.SkyboxFt = "rbxassetid://591058104"
                Sky_Box.SkyboxLf = "rbxassetid://591057861"
                Sky_Box.SkyboxRt = "rbxassetid://591057625"
                Sky_Box.SkyboxUp = "rbxassetid://591059642"
                Sky_Box.StarCount = 10000
            end
            wait(0.2)
            local function OMWZNSF_fake_script()
                local hour = 6
                local minute = 0
                local isPM = false
                getgenv().times_enabled_clock = true

                local Lighting = game:GetService("Lighting")

                local function formatTime(h, m, pm)
                    local period = pm and "PM" or "AM"
                    return string.format("%02d:%02d %s", h, m, period)
                end

                local function updateTime()
                    minute = minute + 1
                    if minute == 60 then
                        minute = 0
                        hour = hour + 1
                    end
                    if hour == 12 and minute == 0 then
                        isPM = not isPM
                    elseif hour == 13 then
                        hour = 1
                    end
                end

                local function updateLighting()
                    local clockHour = hour
                    if isPM and hour ~= 12 then
                        clockHour = clockHour + 12
                    elseif not isPM and hour == 12 then
                        clockHour = 0
                    end
                    Lighting.ClockTime = clockHour + (minute / 60)
                    
                    if Lighting.ClockTime >= 6 and Lighting.ClockTime <= 18 then
                        Lighting.Brightness = 2
                    else
                        Lighting.Brightness = 0.5
                    end
                end

                while getgenv().times_enabled_clock == true do
                    time_label.Text = formatTime(hour, minute, isPM)
                    wait(0.1)
                    updateLighting()
                    wait(1)
                    updateTime()
                end
            end
            coroutine.wrap(OMWZNSF_fake_script)()
            wait(0.3)
            getgenv().clock_script_time = true
        else
            warn("Not enabled in Configuration.")
        end
    end
    wait(0.5)
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

    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function detectExecutor()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_Name = detectExecutor()

    getgenv().randomString = function()
        local length = math.random(10,20)
        local array = {}
        for i = 1, length do
            array[i] = string.char(math.random(32, 126))
        end
        return table.concat(array)
    end

    -- These below this line are being wrapped in the function above (as you can see), essentially making them useful anywhere in the script, local variables but quite more advanced.
    getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    getgenv().httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    -- Don't mind this, I don't actually use this, but it's to make sure 'getgenv().httprequest_Init' can be defined outside and inside the script, since I'm not exactly sure about these types of local variables (non-service local variables).
    get_http = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    getgenv().queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    queueteleport = getgenv().queueteleport

    local function init_services()
        local services = {
            "Players",
            "Workspace",
            "Lighting",
            "ReplicatedStorage",
            "TweenService",
            "RunService",
            "MaterialService",
            "ReplicatedFirst",
            "Teams",
            "StarterPack",
            "StarterPlayer",
            "VoiceChatInternal",
            "VoiceChatService",
            "CoreGui",
            "SoundService",
            "StarterGui",
            "MarketplaceService",
            "TeleportService",
            "Chat",
            "AssetService",
            "HttpService",
            "UserInputService",
            "TextChatService",
            "ContextActionService"
        }

        for _, serviceName in pairs(services) do
            getgenv()[serviceName] = cloneref(getgenv().Game:GetService(serviceName)) or getgenv().Game:GetService(serviceName)
        end
    end

    init_services()
    wait(0.5)
    getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
    getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
    getgenv().LocalPlayer = getgenv().Players.LocalPlayer
    getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui")
    getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
    getgenv().HumanoidRootPart = getgenv().Character:WaitForChild("HumanoidRootPart") or getgenv().Character:FindFirstChild("HumanoidRootPart")
    getgenv().Humanoid = getgenv().Character:WaitForChild("Humanoid") or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid")
    getgenv().Head = getgenv().Character:WaitForChild("Head") or getgenv().Character:FindFirstChild("Head")
    wait(0.2)
    -- We can utilize this to teleport back to the same CFrame, as per when the script started, since we need to reset the Character when the script is fully loaded to fix other potential issues.
    getgenv().StartedScriptCFrame = getgenv().Character:FindFirstChild("HumanoidRootPart").Position

    -- Initialize Character Updater, fixing any issues with Humanoid, HumanoidRootPart, or even if the Character dies and respawns, essentially making sure the Character is always defined correctly.
    local function updateCharacterComponents(character)
        print("Refreshing Character: "..tostring(character))
        getgenv().Character = character
        getgenv().HumanoidRootPart = character:WaitForChild("HumanoidRootPart") or character:FindFirstChild("HumanoidRootPart")
        getgenv().Humanoid = character:WaitForChild("Humanoid") or character:FindFirstChildWhichIsA("Humanoid")
    end

    -- Update Character Model(s) components, since we need to make sure the live updates are saved correctly (Especially when the Character components are updated as well).
    updateCharacterComponents(getgenv().Character)
    print("Refreshed Character Model!: "..tostring(getgenv().Character))
    getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        print("New Character Detected: "..tostring(newCharacter))
        updateCharacterComponents(newCharacter)
    end)

    if executor_Name == "AWP" or executor_Name == "Wave" or executor_Name == "Synapse Z" or executor_Name == "Seliware" or executor_Name == "Nihon" then
        print("Advanced exploit detected, using bypass method. [To actually bypass the security context (a little bit) without running into security errors/issues].")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/ParadiseRPScript/refs/heads/main/quick_workaround_rspy.lua'))()
    else
        warn("No advanced level exploit detected, skipping..")
    end

    -- Voice chat already loaded check, keeping performance as stable as possible, as sometimes the check can duplicate, so we do not want our performance being unstabilized by 1 singular line of code.
    local vc_inter = game:GetService("VoiceChatInternal")
    local vc_service = game:GetService("VoiceChatService")

    if getgenv().voiceChat_Check then
        warn("Voice Chat already initialized.")
    else
        if getgenv().Easies_Configuration["Anti_Suspend_VC"] == "on" or getgenv().Easies_Configuration["Anti_Suspend_VC"] == "On" or getgenv().Easies_Configuration["Anti_Suspend_VC"] == "Enabled" then
            getgenv().voiceChat_Check = true 

            local vc_internal = cloneref and cloneref(game:GetService("VoiceChatInternal")) or game:GetService("VoiceChatInternal")
            local vc_service = cloneref and cloneref(game:GetService("VoiceChatService")) or game:GetService("VoiceChatService")
            
            local reconnecting = false
            local retryDuration = 6
            
            local function forceRejoinVoiceChat()
                if reconnecting then return end
                reconnecting = true
            
                task.spawn(function()
                    local startTime = tick()
            
                    while (tick() - startTime) < retryDuration do
                        wait(0.5)
                        vc_service:RejoinVoice()
                        task.wait()
                        vc_service:JoinVoice()
                    end

                    reconnecting = false
                end)
            end
            
            local function onVoiceChatStateChanged(_, newState)
                if newState == Enum.VoiceChatState.Ended and not reconnecting then
                    forceRejoinVoiceChat()
                end
            end
            
            vc_internal.StateChanged:Connect(onVoiceChatStateChanged)
        else
            warn("Not enabled in Configuration.")
        end
    end

    -- [] -->> Correctly allocate Character's HumanoidRootPart | Essentially correctly loading the BasePart of the Character [Thanks: Infinite Yield] <<-- [] --
    function getRoot(char)
        rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
        return rootPart
    end
    wait(0.2)
    getgenv().getRoot = function(char)
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
        getgenv().checkNecessaryFunctions = function(function_checked)
            if function_checked then
                print("[Zacks_Easy_Hub::OUTPUT_HOOKED]: "..tostring(function_checked).." ||| Success ✅")
            elseif not function_checked or function_checked == nil then
                warn("[Zacks_Easy_Hub::OUTPUT_HOOKED]: "..tostring(function_checked).." ||| Failure ❌")
            else
                warn("[Zacks_Easy_Hub::OUTPUT_HOOKED]: "..tostring(function_checked).." ||| Unknown ❓")
            end
        end

        local GC = getconnections or get_signal_cons

        getgenv().checkNecessaryFunctions(cloneref)
        wait()
        getgenv().checkNecessaryFunctions(httprequest_Init)
        wait()
        getgenv().checkNecessaryFunctions(writefile)
        wait()
        getgenv().checkNecessaryFunctions(readfile)
        wait()
        getgenv().checkNecessaryFunctions(delfile)
        wait()
        getgenv().checkNecessaryFunctions(GC)
        wait()
        getgenv().checkNecessaryFunctions(getgenv().AllClipboards)
        wait(0.1)
        getgenv().has_checked_funcs = true
    end
    wait(0.2)
    -- [] -->> Check if the selected experience/game is MIC UP | Ensuring they do not run Zacks Easy Hub outside of MIC UP 🔊 or MIC UP 🔊 17+ <<-- [] --
    --[[if getgenv().PlaceID == 6884319169 then
        print("\n<--------------------->\nConnected On MIC UP 🔊\n<--------------------->\n")
    elseif getgenv().PlaceID == 15546218972 then
        print("\n<--------------------->\nConnected On MIC UP 🔊 17+\n<--------------------->\n")
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
        fullScreenFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        fullScreenFrame.BorderSizePixel = 0
        fullScreenFrame.Parent = screenGui
        fullScreenFrame.Visible = true
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
        textLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
        textLabel.BackgroundTransparency = 1
        -- Yes, this has changed a ton, and how it checks above has changed as well as the teleporting down below these lines.
        textLabel.Text = "You are now being teleported to MIC UP 🔊, this game is unsupported."
        textLabel.TextColor3 = Color3.fromRGB(7, 0, 255)
        textLabel.TextScaled = false
        textLabel.TextSize = 75
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = fullScreenFrame
        wait(0.5) -- Like waiting 0.7 seconds might actually work, I never usually wait(1), only because the task can be shortened to it's minimum with things like this, but still wait a little bit.
        getgenv().TeleportCheck = false
        getgenv().LocalPlayer.OnTeleport:Connect(function(State)
            if (not getgenv().TeleportCheck) and getgenv().queueteleport then
                getgenv().TeleportCheck = true
                queueteleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua')))()")
            end
        end)
        wait()
        getgenv().TeleportService:Teleport(6884319169, getgenv().LocalPlayer)
    end--]]
    wait(0.3)
        -- Don't even mess with this dumb shit, the loading screen has been through to much, but keep the checks, since it can run down performance if you remove the loading screen check, and potentially drop frames.
        if getgenv().loading_screen_data then
            print("Already Seen Loading Screen")
        else
            if getgenv().Easies_Configuration["Loading_Screen"] == "on" or getgenv().Easies_Configuration["Loading_Screen"] == "On" or getgenv().Easies_Configuration["Loading_Screen"] == "Enabled" then
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
            else
                warn("Not enabled in Configuration.")
            end
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
        wait(0.2)
        -- Check our BasePlate, to correctly initialize an anti-void measure, which stretches extremely far.
        if getgenv().passed_baseplate_check then
            warn("Already loaded BasePlate check.")
        else
            if getgenv().Easies_Configuration["Huge_Baseplate"] == "on" or getgenv().Easies_Configuration["Huge_Baseplate"] == "On" or getgenv().Easies_Configuration["Huge_Baseplate"] == "Enabled" then
                getgenv().passed_baseplate_check = true
                wait(0.2)
                function do_baseplate_check()
                    local screenGui = Instance.new("ScreenGui") 
                    screenGui.IgnoreGuiInset = true
                    screenGui.Name = "BASEPLATE_LOADING"
                    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
                    
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
                    local Terrain = game:GetService("Workspace").Terrain

                    Terrain:FillBlock(CFrame.new(66, -10, 72.5), Vector3.new(13000, 16, 13000), Enum.Material.Asphalt)
                    wait(0.3)
                    if game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("BASEPLATE_LOADING") then
                        local bruh_GUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("BASEPLATE_LOADING")
                        bruh_GUI:FindFirstChildOfClass("Frame"):FindFirstChildOfClass("TextLabel").Text = "Current Status: <font color=\"rgb(0, 238, 0)\">Not Frozen</font>\n--------------\n🎇 Zacks Easy Hub 🎇\n----------------------------\nEnjoy your anti-void/BasePlate."
                        wait(0.7)
                        bruh_GUI:Destroy()
                    else
                        warn("GUI does not exist, skipping...")
                    end
                end

                do_baseplate_check()
                wait(0.2)
                getgenv().passed_baseplate_check = true
            else
                warn("Not enabled in Configuration.")
            end
        end
    wait(0.2)
    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function detectExecutor()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_Name = detectExecutor()
    wait(0.2)
    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end
    
    local function detectExecutor()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_Name = detectExecutor()
    wait(0.1)
    local Rayfield
    wait(0.1)
    if executor_Name == "AWP" then
        print("'AWP' detected, using custom/modified loadstring collector.")
        local response = getgenv().httprequest_Init({
            Url = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary",
            Method = "GET"
        })
        
        if response and response.StatusCode == 200 then
            Rayfield = loadstring(response.Body)()
        else
            print("Failed to fetch script:", response.StatusCode)
        end
    else
        warn("'AWP' not detected, using regular Loadstring collector.")
        Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary'))()
    end
    wait(0.2)
    getgenv().notify = function(title, content, duration)
        Rayfield:Notify({
            Title = tostring(title),
            Content = tostring(content),
            Duration = tonumber(duration),
            Image = 93594537601787,
            Actions = {
                Ignore = {
                    Name = "Okay.",
                    Callback = function() 
                        print("...") 
                    end
                },
            },
        })
    end
    wait(0.2)
    local Workspace
    local Players
    local ReplicatedStorage
    local UserInputService
    wait(0.1)
    if cloneref then
        print("Using cloneref for Muted keybind.")
        Workspace = cloneref(game:GetService("Workspace"))
        Players = cloneref(game:GetService("Players"))
        ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
        UserInputService = cloneref(game:GetService("UserInputService"))
    else
        warn("'cloneref' is unsupported, utilizing normal method of Services.")
        Workspace = game:GetService("Workspace")
        Players = game:GetService("Players")
        ReplicatedStorage = game:GetService("ReplicatedStorage")
        UserInputService = game:GetService("UserInputService")
    end
    wait(0.2)
    local function toggle_mute()
        local player = Players.LocalPlayer
        if not player then return end

        local audioInput = player:FindFirstChildOfClass("AudioDeviceInput")
        if audioInput then
            audioInput.Muted = not audioInput.Muted
            if audioInput.Muted or audioInput.Muted == true then
                getgenv().notify("Success", "Muted Microphone.", 6)
            elseif not audioInput.Muted or audioInput.Muted == false then
                getgenv().notify("Success", "Unmuted Microphone.", 6.5)
            end
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.RightAlt then
            toggle_mute()
        end
    end)
    wait(0.2)
    if getgenv().conveyer_stored then
        warn("Already stored conveyer's")
    else
        local Storage = Workspace:FindFirstChild("PartStorage")
        local CFrames = {
            ["Conveyer_1"] = CFrame.new(203.401642, 12.8743448, -100.937836, 1.4424324e-05, -0.70705986, -0.707153797, 5.9902668e-06, 0.707153738, -0.70705986, 1, 5.9902668e-06, 1.4424324e-05),
            ["Conveyer_2"] = CFrame.new(221.043793, 28.0164795, -104.937843, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            ["Conveyer_3"] = CFrame.new(217.043793, 28.0164833, -113.937866, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07),
            ["Conveyer_4"] = CFrame.new(196.330627, 43.4307442, -113.937851, -3.23057175e-05, 0.707153201, 0.707060337, 1.33812428e-05, 0.707060337, -0.707153201, -1, -1.33812428e-05, -3.23057175e-05)
        }
        wait(0.2)
        for name, cf in pairs(CFrames) do
            for _, v in ipairs(Workspace:GetChildren()) do
                if v:IsA("BasePart") and v.CFrame == cf then
                    v.Name = name
                    v.Parent = Storage
                end
            end
            wait(0.1)
        end
        wait(0.3)
        for _, v in ipairs(Storage:GetChildren()) do
            if v.Name == "Conveyer_1" then
                v.Transparency = 0.3
                v.BrickColor = BrickColor.new("Really black")
            end
        end
        wait(0.1)
        for _, v in ipairs(Storage:GetChildren()) do
            if v.Name == "Conveyer_2" then
                v.Transparency = 0.3
                v.BrickColor = BrickColor.new("Really black")
            end
        end
        wait(0.1)
        for _, v in ipairs(Storage:GetChildren()) do
            if v.Name == "Conveyer_3" then
                v.Transparency = 0.3
                v.BrickColor = BrickColor.new("Really black")
            end
        end
        wait(0.1)
        for _, v in ipairs(Storage:GetChildren()) do
            if v.Name == "Conveyer_4" then
                v.Transparency = 0.3
                v.BrickColor = BrickColor.new("Really black")
            end
        end
        wait(0.2)
        for _, v in ipairs(Workspace:GetChildren()) do
            if v:IsA("MeshPart") and v.CFrame == CFrame.new(170.998001, 58, -113.500031, -1, 0, 0, 0, 1, 0, 0, 0, -1) then
                v.Name = "MeshPart_Floor_Conveyers"
                v.Parent = Workspace:FindFirstChild("PartStorage")
                v.Transparency = 0.3
                v.BrickColor = BrickColor.new("Really black")
            end
        end
    end

    function connect_tp_tool()
        local speaker = game.Players.LocalPlayer
        local TpTool = Instance.new("Tool")
        local IYMouse = speaker:GetMouse()
        TpTool.Name = "Teleport Tool"
        TpTool.RequiresHandle = false
        TpTool.Parent = speaker and speaker:WaitForChild("Backpack")
        TpTool.Activated:Connect(function()
            local Char = speaker.Character or workspace:FindFirstChild(speaker.Name)
            local HRP = Char and Char:FindFirstChild("HumanoidRootPart") or Char:WaitForChild("HumanoidRootPart", 1)
            if not Char or not HRP then
                return warn("Failed to find HumanoidRootPart")
            end
            HRP.CFrame = CFrame.new(IYMouse.Hit.X, IYMouse.Hit.Y + 3, IYMouse.Hit.Z, select(4, HRP.CFrame:components()))
        end)
    end
    wait(0.1)
    if getgenv().Easies_Configuration["keep_tp_tool"] == "on" or getgenv().Easies_Configuration["keep_tp_tool"] == "On" or getgenv().Easies_Configuration["keep_tp_tool"] == "Enabled" then
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        local function onCharacterAdded(Character)
            if not Character then return end
            print("Character Added: " .. LocalPlayer.Name)
            wait(0.1)
            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid", 5)
            if not Humanoid then
                return warn("Humanoid not found, unable to apply TP Tool.")
            end
        
            print("Found Character and Humanoid!")
            wait()
            Humanoid.Died:Connect(function()
                print("LocalPlayer has died. Waiting for respawn...")
            end)
            wait(0.5)
            print("Connecting back to TP Tool...")
            connect_tp_tool()
            print("Connected to TP Tool.")
        end
        
        LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
        
        if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
            onCharacterAdded(LocalPlayer.Character)
        end
    else
        warn("Not enabled in Configuration.")
    end
    wait(0.1)
    if getgenv().Easies_Configuration["System_Broken"] == "on" or getgenv().Easies_Configuration["System_Broken"] == "On" or getgenv().Easies_Configuration["System_Broken"] == "Enabled" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/refs/heads/main/plus_source.lua"))()
    else
        warn("Not enabled in Configuration.")
    end
    wait(0.2)
    local image_id_zacks = 93594537601787
    getgenv().image_use_zacks = image_id_zacks
    local ZEH_Module
    if executor_Name == "Nihon" then
        warn("Nihon detected, using custom loadstring collector.")
        local response = getgenv().httprequest_Init({
            Url = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/zacks_easy_module.lua",
            Method = "GET"
        })
        
        if response and response.StatusCode == 200 then
            ZEH_Module = loadstring(response.Body)()
        else
            print("Failed to fetch script:", response.StatusCode)
        end
    else
        ZEH_Module = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/zacks_easy_module.lua'))()
    end
    wait()
    getgenv().Module_For_ZEH = ZEH_Module
    -- Current UI is automatically hidden, shoutout to Rayfield (and the hiddenUI function.).
    getgenv().AllClipboards("https://discord.gg/VJh3kkYzBn")
    wait()
    local Window 
    wait(0.2)
    if executor_Name == "Solara" then
        Window = Rayfield:CreateWindow({
            Name = "📜 Zacks Easy Hub 📜 | V7.5.9 | "..tostring(executor_Name),
            LoadingTitle = "Enjoy ruling MIC UP 🔊",
            LoadingSubtitle = "Zacks Easy Hub | Success.",
            ConfigurationSaving = {
                Enabled = false,
                FolderName = "ConfigurationZacskEasyHub",
                FileName = "ZacksEasyHub"
            },
            Discord = {
                Enabled = false,
                Invite = "VJh3kkYzBn",
                RememberJoins = false
            },
            KeySystem = false,
            KeySettings = {
                Title = "None",
                Subtitle = "No key system is provided.",
                Note = "...",
                FileName = "Key",
                SaveKey = false,
                GrabKeyFromSite = false,
                Key = {"None"}
            }
        })
    else
        Window = Rayfield:CreateWindow({
            Name = "📜 Zacks Easy Hub 📜 | V7.5.9 | "..tostring(executor_Name),
            LoadingTitle = "Enjoy ruling MIC UP 🔊",
            LoadingSubtitle = "Zacks Easy Hub | Success.",
            ConfigurationSaving = {
                Enabled = false,
                FolderName = "ConfigurationZacskEasyHub",
                FileName = "ZacksEasyHub"
            },
            Discord = {
                Enabled = true,
                Invite = "VJh3kkYzBn",
                RememberJoins = true
            },
            KeySystem = false,
            KeySettings = {
                Title = "None",
                Subtitle = "No key system is provided.",
                Note = "...",
                FileName = "Key",
                SaveKey = false,
                GrabKeyFromSite = false,
                Key = {"None"}
            }
        })
    end

    if not Window then
        getgenv().SCRIPT_EXECUTED = false
        return warn("No Window was created.")
    end
    wait(0.1)
    if getgenv().inf_yield_side then
        getgenv().notify("Alert!", "Infinite Premium (IY-Premium) has already been loaded.", 5)
    else
        if getgenv().Easies_Configuration["Infinite_Yield_Premium"] == "on" or getgenv().Easies_Configuration["Infinite_Yield_Premium"] == "On" or getgenv().Easies_Configuration["Infinite_Yield_Premium"] == "Enabled" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua", true))()
            getgenv().inf_yield_side = true
        else
            warn("Not enabled in Configuration.")
        end
    end
    wait()
    getgenv().notify("Heads Up!", "We have now defaulted to Infinite Premium [mine].", 7)
    wait(0.1)
    -- [] -->> Initialize our Tabs and Sections <<-- [] --
    local Tab1 = Window:CreateTab("> Main", getgenv().image_use_zacks)
    local Section1 = Tab1:CreateSection("||| / Main Section |||")

    local Tab10
    local Section10
    local Tab11
    local Section11
    wait(0.2)
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        Tab11 = Window:CreateTab("> Booths", getgenv().image_use_zacks)
        Section11 = Tab11:CreateSection("||| Booths Section |||")
    else
        Tab11 = nil
        Section11 = nil
    end
    wait(0.2)
    local Tab2 = Window:CreateTab("> LocalPlayer", getgenv().image_use_zacks)
    local Section2 = Tab2:CreateSection("||| LocalPlayer Section |||")

    local Tab13 = Window:CreateTab("> Players", getgenv().image_use_zacks)
    local Section13 = Tab13:CreateSection("||| Players Section |||")

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        Tab10 = Window:CreateTab("> Teleports", getgenv().image_use_zacks)
        Section10 = Tab10:CreateSection("||| Teleports Section |||")
    else
        Tab10 = nil
        Section10 = nil
        warn("Not loading Teleports, not MIC UP or MIC UP 17+.")
    end
    wait(0.2)
    Tab18 = Window:CreateTab("> Map", getgenv().image_use_zacks)
    Section18 = Tab18:CreateSection("||| Map Section |||")

    Tab4 = Window:CreateTab("> Chat", getgenv().image_use_zacks)
    Section4 = Tab4:CreateSection("||| Chatting Section |||")

    Tab5 = Window:CreateTab("> Exploits", getgenv().image_use_zacks)
    Section5 = Tab5:CreateSection("||| Misc Section |||")

    Tab16 = Window:CreateTab("> Universal", getgenv().image_use_zacks)
    Section16 = Tab16:CreateSection("||| Universal Section |||")

    Tab17 = Window:CreateTab("> Anims", getgenv().image_use_zacks)
    Section17 = Tab17:CreateSection("||| Animation Packages Section |||")

    Tab9 = Window:CreateTab("> Lighting", getgenv().image_use_zacks)
    Section9 = Tab9:CreateSection("||| Lighting Section |||")

    Tab12 = Window:CreateTab("> Emotes", getgenv().image_use_zacks)
    Section12 = Tab12:CreateSection("||| Emoting Section |||")

    if executor_Name == "MacSploit" then
        warn("Not loading CopyAnim features. [Unsupported Executor.]")
    else
        Tab14 = Window:CreateTab("> CopyAnim", getgenv().image_use_zacks)
        Section14 = Tab14:CreateSection("||| Copy Animation Section |||")
    end

    Tab15 = Window:CreateTab("> Settings", getgenv().image_use_zacks)
    Section15 = Tab15:CreateSection("||| UI Settings Section |||")
    wait(0.2)
    if getgenv().Easies_Configuration["Old_Materials"] == "on" or getgenv().Easies_Configuration["Old_Materials"] == "On" or getgenv().Easies_Configuration["Old_Materials"] == "Enabled" then
        local MaterialService = cloneref and cloneref(game:GetService("MaterialService")) or game:GetService("MaterialService")

        MaterialService.Use2022Materials = false
        wait(0.2)
        getgenv().loaded_materials = true
    else
        warn("Not enabled in Configuration.")
    end
    wait(0.2)
    getgenv().loaded_materials = true
    wait(0.1)
    -- Start searching for the 'Game' Folder located in Workspace, and modify they're "Parent" them somewhere else, and the Part 'Teleport' as well, so we are invincible to that platform game where the soccer thing is.
    local GameFolder = getgenv().Workspace:FindFirstChild("Game")
    local GetTeleportPart = GameFolder and GameFolder:FindFirstChild("Teleport")
    local AssetService = game:GetService("AssetService")
    local Asset_Service_Duplicate = game:GetService("AssetService")
    -- I fixed this function for resetting lighting, and now starts up automatically.
    function resetLightingSettings()
        -- Check it out, let me know what you think.
        local Lighting = game:GetService("Lighting")
        local SunRays = Lighting:FindFirstChildOfClass("SunRaysEffect")

        Lighting.ClockTime = 14.5
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
            queueteleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua')))()")
        end
    end)
    wait(0.2)
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
    local TeleportService = game:GetService("TeleportService")

    PlaceId, JobId = game.PlaceId, game.JobId
    wait(0.1)
    if getgenv().AntiAfkScript or getgenv().OtherAntiAfk then
        print("AntiAFK Scripts have already been pre-loaded from last session | skipping...")
        wait(0.2)
        warn("000 >>> 000 >>> nil")
    else
        if getgenv().Easies_Configuration["AntiAFK"] == "on" or getgenv().Easies_Configuration["AntiAFK"] == "On" or getgenv().Easies_Configuration["AntiAFK"] == "Enabled" then
            local GC = getconnections or get_signal_cons

            if GC then
                getgenv().AntiAfkScript = true
                wait()
                for i, v in pairs(GC(game:GetService("Players").LocalPlayer.Idled)) do
                    if v["Disable"] then
                        v["Disable"](v)
                        getgenv().notify("Idled!", "Disabling Event...", 7)
                    end
                end
            else
                getgenv().OtherAntiAfk = true
                wait(0.1)
                warn("Your executor does not support 'getconnections'! Using VirtualUser for Anti-AFK.")
                wait()
                getgenv().notify("Starting", "AntiAFK (2) is loading with VirtualUser...", 5)

                local VirtualUser = game:GetService("VirtualUser")
                wait()
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    getgenv().notify("Idled!", "Clicking button...", 5)
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                    wait(0.1)
                    getgenv().notify("Success!", "Clicked Button (Anti-Idle)", 5)
                end)
            end

            wait(0.4)
            if getgenv().AntiAfkScript or getgenv().AntiAfkScript == true then
                getgenv().notify("Success!", "AntiAFK (1) has loaded!", 5)
            elseif getgenv().OtherAntiAfk or getgenv().OtherAntiAfk == true then
                getgenv().notify("Success!", "AntiAFK (2) has loaded.", 5)
            end

            if getgenv().AntiAfkScript == false and getgenv().OtherAntiAfk == false then
                getgenv().notify("Failed!", "Could not load any Anti-AFK Scripts.", 5)
            end
        else
            warn("Not enabled in Configuration.")
        end
    end
    wait(0.3)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    wait(0.5)
    if getgenv().scripts_init then
        warn("Scripts we're already modified.")
    else
        getgenv().notify("Hang On...", "We are removing Kill-Parts for Private Room.", 5)
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
        if getgenv().scripts_init or getgenv().scripts_init == true then
            getgenv().notify("Success", "We have removed the Kill-Parts for Private Room", 5)
        end
    end
    wait()
    local player = getgenv().LocalPlayer

    getgenv().whitelist = {}

    getgenv().ownerWhitelist = {
        "L0CKED_1N1",
        "adorxfleurys",
        "CHEATING_B0SS",
        "lucxd19K5"
    }
    wait()
    if game.PlaceId == 97399198116506 then
        local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
        local EventHandlers = ReplicatedStorage:FindFirstChild("EventHandlers")
        local Teleport_Function = EventHandlers:FindFirstChild("Matchmake")
        local ChangeSetting = EventHandlers:FindFirstChild("ChangeSetting")
        local ReadyToPlay = EventHandlers:FindFirstChild("ReadyToPlay")
        local Matchmaking = EventHandlers:FindFirstChild("Matchmaking")
        local MainMenu = Matchmaking:FindFirstChild("MainMenu")
        local BuyItem = EventHandlers:FindFirstChild("BuyItem")

        if game:IsLoaded() and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            for i = 1, 50 do
                ReadyToPlay:FireServer()
            end
        end
    else
        warn("Not on Cellmates (VC)")
    end
    wait(0.5)
    if game.PlaceId == 97399198116506 then
        if getgenv().Easies_Configuration["Mute_Boomboxes_Cellmates_VC_Game_Setting"] == "on" or getgenv().Easies_Configuration["Mute_Boomboxes_Cellmates_VC_Game_Setting"] == "On" or getgenv().Easies_Configuration["Mute_Boomboxes_Cellmates_VC_Game_Setting"] == "Enabled" then
            if ChangeSetting then
                ChangeSetting:InvokeServer("BoomboxVolume", -5 or 0)
            else
                local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
                local EventHandlers = ReplicatedStorage:FindFirstChild("EventHandlers")
                local ChangeSetting = EventHandlers:FindFirstChild("ChangeSetting")

                ChangeSetting:InvokeServer("BoomboxVolume", -5 or 0)
            end
        else
            warn("Not enabled in Configuration.")
        end
        wait(0.2)
        if getgenv().Easies_Configuration["Mute_Music_Volume_Cellmates_VC_Game_Setting"] == "on" or getgenv().Easies_Configuration["Mute_Music_Volume_Cellmates_VC_Game_Setting"] == "On" or getgenv().Easies_Configuration["Mute_Music_Volume_Cellmates_VC_Game_Setting"] == "Enabled" then
            if ChangeSetting then
                ChangeSetting:InvokeServer("MusicVolume", -5 or 0)
            else
                local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
                local EventHandlers = ReplicatedStorage:FindFirstChild("EventHandlers")
                local ChangeSetting = EventHandlers:FindFirstChild("ChangeSetting")

                ChangeSetting:InvokeServer("MusicVolume", -5 or 0)
            end
        else
            warn("Not enabled in Configuration.")
        end
        wait(0.2)
        if getgenv().Easies_Configuration["Mute_Sound_Effects_Cellmates_VC_Game_Setting"] == "on" or getgenv().Easies_Configuration["Mute_Sound_Effects_Cellmates_VC_Game_Setting"] == "On" or getgenv().Easies_Configuration["Mute_Sound_Effects_Cellmates_VC_Game_Setting"] == "Enabled" then
            if ChangeSetting then
                ChangeSetting:InvokeServer("SFXVolume", -5 or 0)
            else
                local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
                local EventHandlers = ReplicatedStorage:FindFirstChild("EventHandlers")
                local ChangeSetting = EventHandlers:FindFirstChild("ChangeSetting")

                ChangeSetting:InvokeServer("SFXVolume", -5 or 0)
            end
        else
            warn("Not enabled in Configuration.")
        end
    end
    wait()
    -- [] -->> Functions <<-- [] --
    local cmdp = game.Players
    local cmdlp = cmdp.LocalPlayer

    function findplr(args, tbl)
        local tbl = game:GetService("Players"):GetPlayers() or game:GetService("Players"):GetChildren()

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
    end
    wait()
    function isNumber(str)
        if tonumber(str) ~= nil then
            return true
        end
    end
    wait(0.2)
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        if getgenv().reparented_model then
            warn("Already reparented Avatar-UI Model")
        else
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
        end
    else
        warn("User isn't in MIC UP or MIC UP 17+, not loading.")
    end
    wait(0.1)
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().StallClaimToggle = Tab11:CreateToggle({
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

        getgenv().FixGlitchedScreenBooth = Tab11:CreateButton({
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

        getgenv().claimRandomBooth = Tab11:CreateButton({
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
            
            local OldCF = Character:FindFirstChild("HumanoidRootPart").CFrame
            
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

                    if stall then
                        HumanoidRootPart.CFrame = stall:GetPivot()
                    else
                        return getgenv().notify("Error:", "Player's booth was not found", 6)
                    end
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
    else
        warn("Did not load Booth's stuff [1].")
    end

    getgenv().AntiVoidPlayer = Tab2:CreateToggle({
    Name = "Anti Void Baseplate (Goes under Character)",
    CurrentValue = false,
    Flag = "ToggleAntiVoidBasePlate",
    Callback = function(antiVoidFall)
        if antiVoidFall then
            getgenv().anti_void_player = true

            local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
            local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local player = LocalPlayer or Players.LocalPlayer
            local function return_correct_char()
                local character = player.Character or player.CharacterAdded:Wait()
                while character:FindFirstChild("Humanoid") and character.Humanoid.Health <= 0 do
                    character = player.CharacterAdded:Wait()
                end
                return character
            end
            
            local function createBaseplate()
                local baseplate = Instance.new("Part")
                baseplate.Name = "ANTI_VOID_BASEPLATE"
                baseplate.Size = Vector3.new(20, 1, 20)
                baseplate.Anchored = true
                baseplate.CanCollide = true
                baseplate.Material = Enum.Material.Air
                baseplate.Color = Color3.fromRGB(107, 50, 124)
                baseplate.Transparency = 0.6
                baseplate.Parent = Workspace:FindFirstChild("PartStorage")
                return baseplate
            end
            
            local function updateBaseplate()
                local baseplate = createBaseplate()
                local initialY = nil

                while getgenv().anti_void_player == true do
                    local character = return_correct_char()
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        if not initialY then
                            initialY = rootPart.Position.Y - rootPart.Size.Y / 2 - baseplate.Size.Y / 2
                        end
                        local newPos = Vector3.new(rootPart.Position.X, initialY, rootPart.Position.Z)
                        baseplate.Position = newPos
                    end
                    task.wait(0.04)
                end
            end
            
            updateBaseplate()
        else
            getgenv().anti_void_player = false
            getgenv().anti_void_player = false
            wait(0.3)
            getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("ANTI_VOID_BASEPLATE"):Destroy()
        end
    end,})

    getgenv().TPOwnerBruh = Tab1:CreateButton({
    Name = "Teleport To: Owner Of Script",
    Callback = function()
        local OwnerName = "L0CKED_1N1" or "CHEATING_B0SS" or "adorxfleurys"
        if not game.Players:FindFirstChild(OwnerName) then return warn("Owner not found!") end

        if game.Players:FindFirstChild(OwnerName) then
            print("Owner Found! Teleporting...")
            task.wait()
            local OwnerOfScript = game.Players:FindFirstChild(OwnerName)
            getgenv().Character:PivotTo(OwnerOfScript.Character:GetPivot())
            task.wait(.5)
            print("Teleported To Script Owner!")
        else
            return getgenv().notify("Failure", "Unable to successfully locate owner.", 6)
        end
    end,})

    getgenv().ViewOwnerBruh = Tab1:CreateToggle({
    Name = "View: Owner Of Script",
    CurrentValue = false,
    Flag = "viewOwner",
    Callback = function(viewingOwner)
        if viewingOwner then
            getgenv().spectateOwner = true
            local OwnerName = "L0CKED_1N1" or "CHEATING_B0SS" or "adorxfleurys"
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
                return getgenv().notify("Failure!", "Owner not found in current server", 5)
            end
        else
            local Workspace = getgenv().Workspace
            local Camera = Workspace:FindFirstChild("Camera")

            getgenv().spectateOwner = false
            wait(0.2)
            Camera.CameraSubject = getgenv().Character
        end
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().coloredBooth = Tab11:CreateToggle({
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

        getgenv().ClaimPlrsBooth = Tab11:CreateInput({
        Name = "Claim Someones Booth",
        PlaceholderText = "User Here",
        RemoveTextAfterFocusLost = true,
        Callback = function(takeThatBooth)
            local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
            local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
            local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
            
            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            
            local function findPlrBooth(player)
                for _, booth in pairs(Workspace.Booth:GetChildren()) do
                    local usernameLabel = booth:FindFirstChild("Username") and booth.Username:FindFirstChild("BillboardGui") and booth.Username.BillboardGui:FindFirstChild("TextLabel")
                    if usernameLabel and usernameLabel.Text == "Owned by: "..tostring(player) then
                        return booth
                    end
                end
                return nil
            end
            
            getgenv().notify("Note:", "Make sure you are not invisible when doing this!", 6.5)
            task.wait(0.2)
            
            local find_plr_func_booth = findplr(takeThatBooth)
            
            if find_plr_func_booth == LocalPlayer then
                getgenv().notify("Success:", "Removed your booth. [LocalPlayer]", 6.5)
                return ReplicatedStorage:WaitForChild("DeleteBoothOwnership"):FireServer()
            end
            
            if not find_plr_func_booth then
                return getgenv().notify("Error:", "Player not found!", 6.5)
            end
            
            local plr_booth = findPlrBooth(find_plr_func_booth)
            
            if not plr_booth then
                return getgenv().notify("Error:", tostring(find_plr_func_booth).." does not own a booth!", 5)
            end
            
            local OldCF = HumanoidRootPart.CFrame
            
            local function setupProximityPrompt(stall)
                local ProximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
                if ProximityPrompt then
                    ProximityPrompt.Enabled = true
                    ProximityPrompt.ClickablePrompt = true
                    ProximityPrompt.MaxActivationDistance = 15
                    ProximityPrompt.RequiresLineOfSight = false
                    ProximityPrompt.HoldDuration = 0
                end
            end
            
            local function Claim_A_Booth()
                if not plr_booth then return end
            
                setupProximityPrompt(plr_booth)
                task.wait(0.3)
            
                HumanoidRootPart.CFrame = plr_booth:GetPivot()
                task.wait(0.5)
            
                local ProximityPrompt = plr_booth:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
                if ProximityPrompt then
                    fireproximityprompt(ProximityPrompt)
                    task.wait(0.2)
            
                    local args = {"", "Gray", "SourceSans"}
                    ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
            
                    task.wait(0.2)
                    HumanoidRootPart.CFrame = OldCF
                    task.wait(0.2)
            
                    getgenv().notify("Success:", "Claimed "..tostring(find_plr_func_booth).."'s Booth!", 6.5)
                end
            end
            
            task.wait(0.2)
            setupProximityPrompt(plr_booth)
            task.wait(0.3)
            Claim_A_Booth()            
        end,})

        getgenv().unclaimPlrBooth = Tab11:CreateInput({
        Name = "Unclaim A Booth",
        PlaceholderText = "User Here",
        RemoveTextAfterFocusLost = true,
        Callback = function(unclaimTheirBooth)
            local Folder = getgenv().Workspace.Booth
            local find_plr_func_booth = findplr(unclaimTheirBooth)

            getgenv().notify("Note:", "Make sure you are not invisible when doing this!", 6.5)
            task.wait(.2)

            if find_plr_func_booth == getgenv().LocalPlayer then
                getgenv().notify("Success:", "Removed your booth. [LocalPlayer]", 6.5)
                return getgenv().ReplicatedStorage:WaitForChild("DeleteBoothOwnership"):FireServer()
            end

            if not find_plr_func_booth then
                return getgenv().notify("error:", "Player not found!", 6.5)
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
                return getgenv().notify("Error", tostring(find_plr_func_booth).." does not own a booth!", 5, 3)
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
                    getgenv().notify("Success:", "Unclaimed "..tostring(find_plr_func_booth).."'s Booth!", 6.5)
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
    else
        warn("Did not load these Booth tabs [2].")
    end

    getgenv().FrozenChar = Tab2:CreateToggle({
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

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().WriteOutBooth = Tab11:CreateInput({
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
    else
        warn("Did not load this Booth tab [4].")
    end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/AdonisAdminFE/refs/heads/main/coding_stuff.lua')))()
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().ToggleBadWords = Tab11:CreateToggle({
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
                        return getgenv().notify("Failed", "You do not own a Booth, claim one.", 5)
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
                        [3] = "SourceSans"
                    }
                        
                    Booth_Remote:FireServer(unpack(args))
                end
            else
                getgenv().Cuss = false
            end
        end,})
    else
        warn("Did not load this Booth tab [5].")
    end

    getgenv().bangSpeed = 1
    getgenv().bangPlrSpeedSlider = Tab13:CreateSlider({
    Name = "Bang Player Speed",
    Range = {0.1, 110},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "bangThatPlayerSpeed",
    Callback = function(speedOfPlayerBang)
        getgenv().bangSpeed = tonumber(speedOfPlayerBang)
    end,})

    getgenv().BangPlrInputBox = Tab13:CreateInput({
    Name = "Bang Player (Bypassed)",
    PlaceholderText = "Target Here",
    RemoveTextAfterFocusLost = true,
    Callback = function(bangPlayerTarget)
        local real_target_bang = findplr(bangPlayerTarget)
        if getgenv().bangScriptLoaded then
            return getgenv().notify("Failed", "Already loaded bang bypass!", 5)
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
            if getgenv().Humanoid and getgenv().Humanoid.Sit then
                getgenv().Humanoid.Sit = false
            end
        end
        
        local function setupNoSit()
            if getgenv().noSit then getgenv().noSit:Disconnect() end
            if getgenv().nositDied then getgenv().nositDied:Disconnect() end

            if getgenv().Humanoid then
                getgenv().noSit = getgenv().Humanoid:GetPropertyChangedSignal("Sit"):Connect(noSitFunc)
            end
            
            local function nositDiedFunc()
                repeat task.wait() until getgenv().LocalPlayer.Character and getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                setupNoSit()
            end
            
            getgenv().nositDied = getgenv().LocalPlayer.CharacterAdded:Connect(nositDiedFunc)
        end
        
        local function antiVoidLoop()
            if getgenv().HumanoidRootPart then
                if getgenv().HumanoidRootPart.Position.Y < VOID_THRESHOLD then
                    getgenv().HumanoidRootPart.Anchored = true
                elseif getgenv().HumanoidRootPart.Position.Y > UNVOID_THRESHOLD then
                    getgenv().HumanoidRootPart.Anchored = false
                end
            end
        end
        
        local function NoclipLoop()
            if getgenv().Clip == false and getgenv().Character then
                for _, child in pairs(getgenv().Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= getgenv().floatName then
                        child.CanCollide = false
                    end
                end
            elseif getgenv().Clip == true and getgenv().Character then
                for _, child in pairs(getgenv().Character:GetDescendants()) do
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
        
            setupNoSit()
        
            getgenv().Clip = false
            getgenv().enabled = true
            getgenv().Noclipping = getgenv().RunService.Stepped:Connect(NoclipLoop)
            getgenv().antiVoidLoop = getgenv().RunService.Stepped:Connect(antiVoidLoop)
        
            local bangAnim = Instance.new("Animation")
            bangAnim.AnimationId = "rbxassetid://5918726674"
            local bang = humanoid:LoadAnimation(bangAnim)
            bang.Looped = true

            getgenv().bangAnimation = bang
            
            bang:Play(0.1, 1, 1)
        
            getgenv().bangLoop = getgenv().RunService.Stepped:Connect(function()
                if getgenv().unload then
                    cleanupConnections()
                    bang:Stop()
                    bangAnim:Destroy()
                    getgenv().bangScriptLoaded = false
                    return getgenv().notify("Success", "Unloaded bang bypass.", 5)
                end
        
                if bang.Speed ~= getgenv().bangSpeed then
                    bang:AdjustSpeed(getgenv().bangSpeed)
                end
        
                if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local bang_char_root = target.Character:FindFirstChild("HumanoidRootPart")
                    getgenv().HumanoidRootPart.CFrame = bang_char_root.CFrame * CFrame.new(0, 0, 1.1)
                end
            end)

            getgenv().bangDied = getgenv().Humanoid.Died:Connect(function()
                bang:Stop()
                bangAnim:Destroy()
                cleanupConnections()
            end)
        end    

        bang_plr_bypass(real_target_bang)
    end,})
    wait(0.1)
    getgenv().UnloadBangPlr = Tab13:CreateButton({
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

            if getgenv().HumanoidRootPart then
                getgenv().HumanoidRootPart.Anchored = false
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

    getgenv().SpinCharBox = Tab2:CreateInput({
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
            getgenv().notify("Limit Reached!", "We lowered speed, because you would be flung.", 5)
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
            getgenv().notify("Detected.", "Updated speed, detected duplicate spin.", 5)
            wait(0.3)
            getgenv().HumanoidRootPart:FindFirstChild("Spinning").AngularVelocity = Vector3.new(0,spinSpeed,0)
        end
    end,})

    getgenv().UnspinNow = Tab2:CreateButton({
    Name = "Unspin",
    Callback = function()
        for i,v in pairs(getgenv().HumanoidRootPart:GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end
    end,})

    getgenv().SubmitNoteBypassToggle = Tab5:CreateToggle({
    Name = "Submit Note Bypass",
    CurrentValue = false,
    Flag = "BypassNoteBoard",
    Callback = function(theNote)
        local Submit_Note_Remote = getgenv().ReplicatedStorage:FindFirstChild("SubmitTextEvent")

        if theNote then
            getgenv().crazyNote = true
            while getgenv().crazyNote == true do
            task.wait(0.5)
                local args = {
                    [1] = "ɓ׀丅ㄈȟ"
                }
        
                Submit_Note_Remote:FireServer(unpack(args))
            end
        else
            getgenv().crazyNote = false
        end
    end,})

    -- If you fix this let me know, I'm uncertain on how to get the Dropdown argument/callback member, it's that weird system that Rayfield has.

    --[[getgenv().walkingEmoteLoop = Tab2:CreateDropdown({
    Name = "Walk While Emoting",
    Options = {"Shuffle","Piano Hands","Backflip","Levitate","Sleep","Floss"},
    CurrentOption = {"Shuffle"},
    MultipleOptions = false,
    Flag = "GetEmoteOption",
    Callback = function(selectedEmote)
        local emote_ids = {
            ["Shuffle"] = 4391208058,
            ["Piano Hands"] = 16553249658,
            ["Backflip"] = 15694504637,
            ["Levitate"] = 15698511500,
            ["Sleep"] = 4689362868,
            ["Floss"] = 5917570207
        }

        print(getgenv().walkingEmoteLoop.CurrentOption)

        if CurrentOption["Shuffle"] then
            selectedEmote = emote_ids["Shuffle"]
        elseif CurrentOption["Piano Hands"] then
            selectedEmote = emote_ids["Piano Hands"]
        elseif CurrentOption["Backflip"] then
            selectedEmote = emote_ids["Backflip"]
        elseif CurrentOption["Levitate"] then
            selectedEmote = emote_ids["Levitate"]
        elseif CurrentOption["Sleep"] then
            selectedEmote = emote_ids["Sleep"]
        elseif CurrentOption["Floss"] then
            selectedEmote = emote_ids["Floss"]
        else
            return getgenv().notify("Failure!", "Could not determine which emote to select.", 5)
        end
        wait(0.2)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmoteAndGetAnimTrackById(selectedEmote)
        wait(0.2)
        getgenv().Character:FindFirstChild("Animate").Disabled = true
    end,})--]]

    getgenv().StopWalkingPlaceEmote = Tab2:CreateButton({
    Name = "Stop Walking While Emoting",
    Callback = function()
        if getgenv().AnthonyShuffle or getgenv().AnthonyShuffle == true then
            getgenv().AnthonyShuffle:Set(false)
        else
            warn("Option turned off.")
        end
        wait()
        getgenv().Character:FindFirstChild("Animate").Disabled = false
        wait(0.2)
        for _, animTrack in pairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        wait(0.2)
        getgenv().Humanoid:ChangeState(3)
    end,})

    local MichaelJackson_Speed = 120
    local michaelJacksonActive = false

    getgenv().SetWalkSpeedShuffle = Tab2:CreateSlider({
    Name = "Michael Jackson Walk-Speed",
    Range = {5, 500},
    Increment = 1,
    Suffix = "",
    CurrentValue = 120,
    Flag = "MichaelJacksonSpeed",
    Callback = function(get_michael_shuffle_speed)
        MichaelJackson_Speed = get_michael_shuffle_speed
        if michaelJacksonActive then
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = MichaelJackson_Speed
        end
    end,})

    getgenv().AnthonyShuffle = Tab2:CreateToggle({
    Name = "Michael Jackson Walk",
    CurrentValue = false,
    Flag = "DoTheMichael",
    Callback = function(michaelJackson)
        michaelJacksonActive = michaelJackson
        if michaelJackson then
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = MichaelJackson_Speed
            wait(0.1)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmoteAndGetAnimTrackById(4391208058)
            wait(0.2)
            getgenv().Character:FindFirstChild("Animate").Disabled = true
        else
            getgenv().Character:FindFirstChild("Animate").Disabled = false
            wait(0.2)
            getgenv().HumanoidRootPart.Anchored = true
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
            wait(0.4)
            getgenv().Humanoid.WalkSpeed = 16
            wait(0.2)
            getgenv().HumanoidRootPart.Anchored = false
        end
    end,})

    getgenv().SubmitNoteInputBypassText = Tab5:CreateInput({
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

    if game.PlaceId == 97399198116506 then
        getgenv().PauseMainMenu = Tab1:CreateButton({
        Name = "Pause (Go To Main Menu)",
        Callback = function()
            MainMenu:InvokeServer()
        end,})

        getgenv().PurchaseItem = Tab1:CreateInput({
        Name = "Purchase Tool (Specific Name)",
        CurrentValue = "Enter item Name here",
        PlaceholderText = "item Name",
        RemoveTextAfterFocusLost = true,
        Flag = "ItemInputName",
        Callback = function(itemEntered)
            BuyItem:InvokeServer(tostring(itemEntered), "Tools")
        end,})
    else
        warn("Not in Cellmates (VC), not loading these features.")
    end

    if executor_Name ~= "MacSploit" and game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().DeletePlrBooth = Tab11:CreateButton({
        Name = "Delete Current Booth",
        Callback = function()
            for i = 1, 50 do
                getgenv().ReplicatedStorage:FindFirstChild("DeleteBoothOwnership"):FireServer()
            end
        end,})

        getgenv().AutoReclaimToggle = Tab11:CreateToggle({
        Name = "Anti Booth Stealer",
        CurrentValue = false,
        Flag = "NoStealingBooths",
        Callback = function(boothStolen)
            if boothStolen then
                getgenv().AutoClaimEnabled = true
                getgenv().Booth = nil
                getgenv().OwnershipConnection = nil
                local Character = getgenv().Character
                
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
                        local OldCF = getgenv().Character:WaitForChild("HumanoidRootPart").CFrame
                
                        repeat
                            getgenv().Character:PivotTo(stall:GetPivot() + Vector3.new(0, 3, 0))
                            task.wait(0.5)
                
                            local proximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
                            if proximityPrompt then
                                fireproximityprompt(proximityPrompt, 25)
                            else
                                warn("ProximityPrompt not found for the booth!")
                            end
                
                            task.wait(0.5)
                        until stall.Username.BillboardGui.TextLabel.Text == "Owned by: " .. LocalPlayer.Name or not getgenv().AutoClaimEnabled

                        getgenv().Character:PivotTo(OldCF)
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

        getgenv().LoopRemoveAllBooths = Tab11:CreateToggle({
        Name = "Loop Unclaim/Remove Every Booth",
        CurrentValue = false,
        Flag = "LoopGetRidOfAllBooths",
        Callback = function(doLoopUnclaimAll)
            if doLoopUnclaimAll then
                local Players = getgenv().Players
                local LocalPlayer = getgenv().LocalPlayer
                local Character = getgenv().Character
                local Humanoid = getgenv().Humanoid
                local HumanoidRootPart = getgenv().HumanoidRootPart
                local GetWorkspace = game:GetService("Workspace")
                local Folder = GetWorkspace:FindFirstChild("Booth") or GetWorkspace:WaitForChild("Booth") 
                
                local Rep_Storage = game:GetService("ReplicatedStorage") or cloneref(game:GetService("ReplicatedStorage")) or game.ReplicatedStorage or game:FindService("ReplicatedStorage")
                local Delete_Booth_Remote = Rep_Storage:FindFirstChild("DeleteBoothOwnership") or Rep_Storage:WaitForChild("DeleteBoothOwnership")
    
                local OldCF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame
                getgenv().Oldest_CFrame = OldCF
                wait(0.3)
                local function fireAndUnclaimStall(stall)
                    if not getgenv().Oldest_CFrame or getgenv().Oldest_CFrame == nil then
                        getgenv().LoopRemoveAllBooths:Set(false)
                        return getgenv().notify("Failure", "Could not save old Position/CFrame, exiting...", 5)
                    end
                    wait(0.2)
                    local proximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
                    if proximityPrompt then
                        proximityPrompt.ClickablePrompt = true
                        proximityPrompt.RequiresLineOfSight = false
                        proximityPrompt.HoldDuration = 0
                        proximityPrompt.MaxActivationDistance = 17
                        wait(0.2)
                        Character:PivotTo(stall:GetPivot())
                        wait(0.2)
                        fireproximityprompt(proximityPrompt, 999)
                        fireproximityprompt(proximityPrompt, 999)
                        fireproximityprompt(proximityPrompt, 999)
                        wait(0.2)
                        Delete_Booth_Remote:FireServer()
                        Delete_Booth_Remote:FireServer()
                        Delete_Booth_Remote:FireServer()
                        Delete_Booth_Remote:FireServer()
                    elseif not proximityPrompt then
                        getgenv().LoopRemoveAllBooths:Set(false)
                        return getgenv().notify("Failed!", "ProximityPrompt is missing or doesn't exist.", 5)
                    end
                end
    
                local function unclaimStalls()
                    for _, stall in pairs(Folder:GetChildren()) do
                        if stall and stall:FindFirstChild("Activate") then
                            wait()
                            fireAndUnclaimStall(stall)
                        end
                    end
                end
                
                wait()
                getgenv().loop_unclaiming_all_booths = true
                while getgenv().loop_unclaiming_all_booths == true do
                wait(0.1)
                    unclaimStalls()
                end
            else
                getgenv().loop_unclaiming_all_booths = false
                getgenv().loop_unclaiming_all_booths = false
                wait(0.5)
                if not getgenv().loop_unclaiming_all_booths or getgenv().loop_unclaiming_all_booths == false then
                    for i = 1, 10 do
                        getgenv().HumanoidRootPart.CFrame = getgenv().Oldest_CFrame
                        wait(0.4)
                    end
                    wait(0.4)
                    if getgenv().Oldest_CFrame then
                        getgenv().Oldest_CFrame = nil
                    end
                    wait(0.4)
                    if not getgenv().Oldest_CFrame or getgenv().Oldest_CFrame == nil then
                        getgenv().notify("Success", "Finished shutting down loop.", 6)
                    else
                        return getgenv().notify("Failure", "Loop did not shutdown correctly.", 5)
                    end
                end
            end
        end,})

        getgenv().RemoveBooths = Tab11:CreateButton({
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

            local OldCF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

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
                    return getgenv().notify("Failed!", "ProximityPrompt is missing or doesn't exist.", 5)
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
            getgenv().Character:WaitForChild("HumanoidRootPart").CFrame = OldCF
        end,})
    elseif executor_Name == "MacSploit" and game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().DeletePlrBooth = Tab11:CreateButton({
        Name = "Delete Current Booth",
        Callback = function()
            for i = 1, 50 do
                getgenv().ReplicatedStorage:FindFirstChild("DeleteBoothOwnership"):FireServer()
            end
        end,})

        getgenv().RemoveBooths = Tab11:CreateButton({
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

            local OldCF = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

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
                    return getgenv().notify("Failed!", "ProximityPrompt is missing or doesn't exist.", 5)
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
            getgenv().Character:WaitForChild("HumanoidRootPart").CFrame = OldCF
        end,})
    else
        warn("Did not load these Booth tabs [6].")
    end

    if executor_Name == "MacSploit" then
        warn("Unsupported executor 'Macsploit', not loading CopyAnim features.")
    else
        getgenv().CopyAnimAddUser = Tab14:CreateInput({
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
                    return getgenv().notify("Player Limit!", "Only one player can be added at a time!", 5)
                else
                    getgenv().singlePlayerTable[player.Name] = player
                    wait(0.2)
                    if getgenv().singlePlayerTable[player.Name] then
                        getgenv().notify("Success!", tostring(player.Name)..", was added to Whitelist!", 5)
                    elseif not Players[player.Name] then
                        return getgenv().notify("Failure!", tostring(player)..", does not exist!", 5)
                    elseif bruhUser == getgenv().LocalPlayer.Name then
                        return getgenv().notify("Failed!", "You cannot add yourself!", 5)
                    end
                end
            end
            
            addPlayerToGlobalTable(bruhUser)
        end,})

        getgenv().RemoveCopyAnimPlr = Tab14:CreateInput({
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
                        getgenv().notify("Success!", tostring(player.Name)..", was removed from the CopyAnim Whitelist!", 5)
                    else
                        return getgenv().notify("Failed", tostring(player)..", does not exist!", 5)
                    end
                else
                    return getgenv().notify("Failed", tostring(player.Name)..", was not found in CopyAnim Whitelist!", 5)
                end
            end
            
            removePlayerFromGlobalTable(dawgUser)
        end,})

        getgenv().CopyAnimButtonPlr = Tab14:CreateButton({
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
                return getgenv().notify("Failed", "Player was not found!", 5)
            end

            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
            local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
            local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
            
            if thePlayer then
                print("Found Player: "..tostring(thePlayer.Name)..", DisplayName: "..tostring(thePlayer.DisplayName)..", UserID: "..tostring(thePlayer.UserId))
            else
                return getgenv().notify("Failed", "Player was not found!", 5)
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

        getgenv().LoopCopyTheEmotePlr = Tab14:CreateToggle({
        Name = "Loop CopyAnim Whitelist Plr",
        CurrentValue = false,
        Flag = "DoCopyAnimLoop",
        Callback = function(getLoopCopyAnim)
            if getLoopCopyAnim then
                getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}
                
                function getThatPlr()
                    for i, v in pairs(game.Players:GetChildren()) do
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

                local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
                local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
                
                if thePlayer then
                    print(tostring(thePlayer))
                else
                    return getgenv().notify("Error:", "Player not found!", 7)
                end
                
                for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
                    animTrack:Stop()
                end
                
                local getTheirChar = thePlayer.Character or thePlayer.CharacterAdded:Wait()
                local theirHumanoid = getTheirChar:FindFirstChildWhichIsA('Humanoid') or getTheirChar:WaitForChild('Humanoid')
                
                local function getAnimationScript(character)
                    if not character:FindFirstChild("Animate") then
                        return warn("Did not find Animate script for: "..tostring(character))
                    else
                        return character:FindFirstChild("Animate")
                    end
                end
                
                local defaultAnimationScript = getAnimationScript(Character)
                
                local function copyAnimations()
                    if not defaultAnimationScript then
                        warn("Unable to allocate Animate LocalScript.")
                    else
                        defaultAnimationScript.Disabled = true
                    end
                
                    for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
                        animTrack:Stop()
                    end
                
                    for _, animTrack in pairs(theirHumanoid:GetPlayingAnimationTracks()) do
                        if not string.find(animTrack.Animation.AnimationId, "507768375") then
                            local copiedAnim = Humanoid:LoadAnimation(animTrack.Animation)
                            copiedAnim:Play(0.1, 1, animTrack.Speed)
                            copiedAnim:AdjustWeight(9e9)
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
                task.wait(.5)
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
    end
    wait(0.1)
    local time_pos_jerking = 0.6 or tonumber(0.6)
    local jerking_off_speed = 1 or tonumber(1)
    wait(0.1)
    getgenv().JerkOffTimePos = Tab2:CreateSlider({
    Name = "Jerk Off Time Position",
    Range = {0.1, 1},
    Increment = 0.1,
    Suffix = "TimePosition",
    CurrentValue = 0.6,
    Flag = "TimePositioningEditing",
    Callback = function(updateTimePosJerk)
        time_pos_jerking = updateTimePosJerk
    end,})

    getgenv().Jerking_Speed = Tab2:CreateSlider({
    Name = "Jerk Off Speed",
    Range = {0.2, 3},
    Increment = 0.1,
    Suffix = "JerkTheSpeed",
    CurrentValue = 0.6,
    Flag = "SpeedJerkingSpeed",
    Callback = function(jerk_speed)
        jerking_off_speed = jerk_speed
    end,})

    getgenv().JerkOffTool = Tab2:CreateToggle({
    Name = "Jerk Off",
    CurrentValue = false,
    Flag = "JerkingOffBruh",
    Callback = function(getJerkingScript)
        if getJerkingScript then
            if getgenv().Jerking then
                return getgenv().notify("Failure", "Jerk Off Animation already loaded.", 5)
            end
            wait(0.1)
            local LocalPlayer = getgenv().LocalPlayer
            local Character = getgenv().Character
            local Humanoid = getgenv().Humanoid
            wait(0.1)
            getgenv().Jerking = true
            wait(0.1)
            getgenv().JerkAnim = Instance.new("Animation")
            getgenv().JerkAnim.AnimationId = "rbxassetid://698251653"
            getgenv().Jerk = getgenv().Humanoid:LoadAnimation(getgenv().JerkAnim)

            task.spawn(function()
                while getgenv().Jerking == true do
                    task.wait()
                    if not getgenv().Jerking then return end
                    getgenv().Jerk:Play()
                    getgenv().Jerk:AdjustSpeed(jerking_off_speed)
                    getgenv().Jerk.TimePosition = time_pos_jerking
                    task.wait(.1)

                    while getgenv().Jerk.TimePosition < time_pos_jerking do task.wait(.1) end

                    getgenv().Jerk:Stop()
                end
            end)
        else
            getgenv().Jerking = false
            wait(0.1)
            if getgenv().JerkAnim and getgenv().Jerk then
                getgenv().Jerking = false
                wait(0.1)
                getgenv().JerkAnim:Destroy()
                getgenv().Jerk:Destroy()
            else
                return getgenv().notify("Failure!", "Jerk off Animation is not loaded!", 5)
            end
        end
    end,})
    wait(0.1)
    getgenv().MaterialForMap = Tab18:CreateDropdown({
    Name = "Map Material (Can Lag!)",
    Options = {
        "Plastic",
        "Wood",
        "Slate",
        "Concrete",
        "CorrodedMetal",
        "DiamondPlate",
        "Foil",
        "Grass",
        "Ice",
        "Marble",
        "Granite",
        "Brick",
        "Pebble",
        "Sand",
        "Fabric",
        "SmoothPlastic",
        "Metal",
        "WoodPlanks",
        "Cobblestone",
        "Air",
        "Water",
        "Rock",
        "Glacier",
        "Snow",
        "Sandstone",
        "Mud",
        "Basalt",
        "Ground",
        "CrackedLava",
        "Asphalt",
        "LeafyGrass",
        "Salt"
    },
    CurrentOption = "Plastic",
    MultipleOptions = false,
    Flag = "select_materials",
    Callback = function(selected_material)
        if typeof(selected_material) == "table" then
            selected_material = selected_material[1]
        end

        if typeof(selected_material) ~= "string" then
            return warn("Invalid material selected. Expected a string, got: "..typeof(selected_material))
        end

        local materialEnum = Enum.Material[selected_material]
        if not materialEnum then
            return warn("Invalid material: "..tostring(selected_material))
        end

        local function isPartOfCharacter(part)
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character and part:IsDescendantOf(player.Character) then
                    return true
                end
            end
            return false
        end
        wait(0.2)
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if (descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("UnionOperation")) and not isPartOfCharacter(descendant) then
                descendant.Material = materialEnum
            end
        end
    end,})

    getgenv().Change_Map_Transparency = Tab18:CreateSlider({
    Name = "Map Transparency",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0,
    Flag = "MapTransparency",
    Callback = function(Transparent_Map)
        local function isPartOfCharacter(part)
            for _, player in ipairs(getgenv().Players:GetPlayers()) do
                if player.Character and part:IsDescendantOf(player.Character) then
                    return true
                end
            end
            return false
        end
        wait(0.2)
        for _, descendant in ipairs(getgenv().Workspace:GetDescendants()) do
            if (descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("UnionOperation")) and not isPartOfCharacter(descendant) then
                descendant.Transparency = Transparent_Map
            end
        end
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().BasePlate_ColorChange = Tab18:CreateSlider({
        Name = "MIC UP BasePlate Transparency",
        Range = {0, 1},
        Increment = 0.1,
        Suffix = "",
        CurrentValue = 0,
        Flag = "MICUPTransparency",
        Callback = function(BasePlateMICUPTransparency)
            if game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Transparency = BasePlateMICUPTransparency
                Texture_Bruh.Transparency = BasePlateMICUPTransparency
            elseif game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate.Transparency = BasePlateMICUPTransparency
            elseif game:GetService("Workspace"):FindFirstChild("Game") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("Game"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Transparency = BasePlateMICUPTransparency
                Texture_Bruh.Transparency = BasePlateMICUPTransparency
            else
                warn("BasePlate here was not found.")
            end
        end,})
    elseif game.PlaceId == 80080558412215 then
        getgenv().BasePlate_ColorChange = Tab18:CreateSlider({
        Name = "German Hangout BasePlate Transparency",
        Range = {0, 1},
        Increment = 0.1,
        Suffix = "",
        CurrentValue = 0,
        Flag = "MICUPTransparency",
        Callback = function(BasePlateMICUPTransparency)
            if game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Transparency = BasePlateMICUPTransparency
                Texture_Bruh.Transparency = BasePlateMICUPTransparency
            elseif game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate.Transparency = BasePlateMICUPTransparency
            elseif game:GetService("Workspace"):FindFirstChild("Game") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("Game"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Transparency = BasePlateMICUPTransparency
                Texture_Bruh.Transparency = BasePlateMICUPTransparency
            else
                warn("BasePlate here was not found.")
            end
        end,})
    else
        warn("This game is not MIC UP or MIC UP 17+ or German Hangout, BasePlate not being loaded.")
    end

    getgenv().Change_Map_Color = Tab18:CreateColorPicker({
    Name = "Change Map Color (Laggy!)",
    Color = Color3.fromRGB(45, 45, 45),
    Flag = "PickingColorForMap",
    Callback = function(Map_Color)
        local function isPartOfCharacter(part)
            for _, player in ipairs(getgenv().Players:GetPlayers()) do
                if player.Character and part:IsDescendantOf(player.Character) then
                    return true
                end
            end
            return false
        end
        wait(0.2)
        for _, descendant in ipairs(getgenv().Workspace:GetDescendants()) do
            if (descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("UnionOperation")) and not isPartOfCharacter(descendant) then
                descendant.Color = Map_Color
            end
        end
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().BasePlate_ColorChange = Tab18:CreateColorPicker({
        Name = "MIC UP BasePlate Color",
        Color = Color3.fromRGB(255, 0, 0),
        Flag = "PickingColorForMap",
        Callback = function(Base_Color)
            if game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Color = Base_Color
                Texture_Bruh.Color3 = Base_Color
            elseif game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate.Color = Base_Color
            elseif game:GetService("Workspace"):FindFirstChild("Game") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("Game"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Color = Base_Color
                Texture_Bruh.Color3 = Base_Color
            end
        end,})

        getgenv().Baseplate_Size = Tab18:CreateSlider({
        Name = "MIC UP BasePlate Size X",
        Range = {50, 2048},
        Increment = 1,
        Suffix = "",
        CurrentValue = 400,
        Flag = "ChangingBasePlateSized",
        Callback = function(Size_New)
            if game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate_Alt = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate_Alt.Size = Vector3.new(Size_New, BasePlate_Alt.Size.Y, BasePlate_Alt.Size.Z)
            elseif game:GetService("Workspace"):FindFirstChild("Baseplate") then
                local BasePlate_Normal = game:GetService("Workspace"):FindFirstChild("Baseplate")

                if BasePlate_Normal.Transparency == 1 then
                    BasePlate_Normal.Transparency = 0
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(Size_New, BasePlate_Normal.Size.Y, BasePlate_Normal.Size.Z)
                else
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(Size_New, BasePlate_Normal.Size.Y, BasePlate_Normal.Size.Z)
                end
            elseif game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Size = Vector3.new(Size_New, BasePlate.Size.Y, BasePlate.Size.Z)
                Texture_Bruh.Size = Vector3.new(Size_New, BasePlate.Size.Y, BasePlate.Size.Z)
            end
        end,})

        getgenv().Baseplate_Size = Tab18:CreateSlider({
        Name = "MIC UP BasePlate Size Z",
        Range = {50, 2048},
        Increment = 1,
        Suffix = "",
        CurrentValue = 400,
        Flag = "ChangingBaseSize",
        Callback = function(Sized_Z)
            if game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate_Alt = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate_Alt.Size = Vector3.new(BasePlate_Alt.Size.X, BasePlate_Alt.Size.Y, Sized_Z)
            elseif game:GetService("Workspace"):FindFirstChild("Baseplate") then
                local BasePlate_Normal = game:GetService("Workspace"):FindFirstChild("Baseplate")

                if BasePlate_Normal.Transparency == 1 then
                    BasePlate_Normal.Transparency = 0
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(BasePlate_Normal.Size.X, BasePlate_Normal.Size.Y, Sized_Z)
                else
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(BasePlate_Normal.Size.X, BasePlate_Normal.Size.Y, Sized_Z)
                end
            elseif game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Size = Vector3.new(BasePlate.Size.X, BasePlate.Size.Y, Sized_Z)
                Texture_Bruh.Size = Vector3.new(BasePlate.Size.X, BasePlate.Size.Y, Sized_Z)
            end
        end,})
    elseif game.PlaceId == 80080558412215 then
        getgenv().BasePlate_ColorChange = Tab18:CreateColorPicker({
        Name = "German Hangout BasePlate Color",
        Color = Color3.fromRGB(255, 0, 0),
        Flag = "PickingColorForMap",
        Callback = function(Base_Color)
            if game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Color = Base_Color
                Texture_Bruh.Color3 = Base_Color
            elseif game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate.Color = Base_Color
            elseif game:GetService("Workspace"):FindFirstChild("Game") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("Game"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Color = Base_Color
                Texture_Bruh.Color3 = Base_Color
            end
        end,})

        getgenv().Baseplate_Size = Tab18:CreateSlider({
        Name = "German Hangout BasePlate Size X",
        Range = {50, 2048},
        Increment = 1,
        Suffix = "",
        CurrentValue = 400,
        Flag = "ChangingBasePlateSized",
        Callback = function(Size_New)
            if game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate_Alt = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate_Alt.Size = Vector3.new(Size_New, BasePlate_Alt.Size.Y, BasePlate_Alt.Size.Z)
            elseif game:GetService("Workspace"):FindFirstChild("Baseplate") then
                local BasePlate_Normal = game:GetService("Workspace"):FindFirstChild("Baseplate")

                if BasePlate_Normal.Transparency == 1 then
                    BasePlate_Normal.Transparency = 0
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(Size_New, BasePlate_Normal.Size.Y, BasePlate_Normal.Size.Z)
                else
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(Size_New, BasePlate_Normal.Size.Y, BasePlate_Normal.Size.Z)
                end
            elseif game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Size = Vector3.new(Size_New, BasePlate.Size.Y, BasePlate.Size.Z)
                Texture_Bruh.Size = Vector3.new(Size_New, BasePlate.Size.Y, BasePlate.Size.Z)
            end
        end,})

        getgenv().Baseplate_Size = Tab18:CreateSlider({
        Name = "German Hangout BasePlate Size Z",
        Range = {50, 2048},
        Increment = 1,
        Suffix = "",
        CurrentValue = 400,
        Flag = "ChangingBaseSize",
        Callback = function(Sized_Z)
            if game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate_Alt = game:GetService("Workspace"):FindFirstChild("BasePlate")

                BasePlate_Alt.Size = Vector3.new(BasePlate_Alt.Size.X, BasePlate_Alt.Size.Y, Sized_Z)
            elseif game:GetService("Workspace"):FindFirstChild("Baseplate") then
                local BasePlate_Normal = game:GetService("Workspace"):FindFirstChild("Baseplate")

                if BasePlate_Normal.Transparency == 1 then
                    BasePlate_Normal.Transparency = 0
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(BasePlate_Normal.Size.X, BasePlate_Normal.Size.Y, Sized_Z)
                else
                    BasePlate_Normal.CanCollide = true
                    BasePlate_Normal.Size = Vector3.new(BasePlate_Normal.Size.X, BasePlate_Normal.Size.Y, Sized_Z)
                end
            elseif game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Size = Vector3.new(BasePlate.Size.X, BasePlate.Size.Y, Sized_Z)
                Texture_Bruh.Size = Vector3.new(BasePlate.Size.X, BasePlate.Size.Y, Sized_Z)
            end
        end,})
    else
        warn("These BasePlate settings will not load, not MIC UP or German Hangout.")
    end

    getgenv().StopTheEmotes = Tab14:CreateButton({
    Name = "Stop All Emotes",
    Callback = function()
        getgenv().singlePlayerTable = getgenv().singlePlayerTable or {}

        function getThatPlr()
            for i, v in pairs(getgenv().Players:GetChildren()) do
                if getgenv().singlePlayerTable[v.Name] then
                    return v
                end
            end
            return nil
        end

        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local thePlayer = getThatPlr()
        local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
        local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
        local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
        
        if thePlayer then
            local getTheirChar = thePlayer.Character or thePlayer.CharacterAdded:Wait()
            local theirHumanoid = getTheirChar:FindFirstChildWhichIsA('Humanoid') or getTheirChar:WaitForChild('Humanoid')
            
            local function stopAnimations()
                for _, animTrack in pairs(theirHumanoid:GetPlayingAnimationTracks()) do
                    animTrack:Stop()
                end
            end
            
            stopAnimations()
        else
            for _, animTrack in pairs(Humanoid:GetPlayingAnimationTracks()) do
                animTrack:Stop()
            end
            wait(0.2)
            getgenv().notify("Failed", "Player was not found!", 5)
        end
    end,})

    getgenv().PlayEmoteButFrozen = Tab12:CreateInput({
    Name = "Play Emote ID (Loop)",
    PlaceholderText = "Enter ID",
    RemoveTextAfterFocusLost = true,
    Callback = function(idForEmoting)
        local number_id = tonumber(idForEmoting) or idForEmoting

        local succ, err = pcall(function()
            getgenv().Humanoid:PlayEmoteAndGetAnimTrackById(number_id)
        end)
        wait(0.1)
        if succ then
            getgenv().Humanoid:PlayEmoteAndGetAnimTrackById(number_id)
            task.wait(.3)
            if getgenv().HumanoidRootPart.Anchored == false then
                getgenv().HumanoidRootPart.Anchored = true
                wait(0.2)
                getgenv().Character:FindFirstChild("Animate").Disabled = true
                wait(0.2)
                getgenv().HumanoidRootPart.Anchored = false
            else
                getgenv().HumanoidRootPart.Anchored = false
                wait(0.1)
                getgenv().Character:FindFirstChild("Animate").Disabled = true
            end
        else
            return getgenv().notify("Error:", tostring(err), 5)
        end
    end,})

    getgenv().StopEmoteLooping = Tab12:CreateButton({
    Name = "Stop Loop Emoting",
    Callback = function()
        getgenv().Character:FindFirstChild("Animate").Disabled = false
        wait(0.2)
        for _, animTrack in pairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        wait(0.1)
        if getgenv().Humanoid.Sit or getgenv().Humanoid == true then
            getgenv().Humanoid:ChangeState(3)
            getgenv().Humanoid.Jumping = true
        end
        wait(0.2)
        if getgenv().HumanoidRootPart.Anchored or getgenv().HumanoidRootPart.Anchored == true then
            getgenv().FrozenChar:Set(false)
            getgenv().HumanoidRootPart.Anchored = false
            wait(0.2)
            getgenv().Humanoid:ChangeState(3)
        end
    end,})

    getgenv().PlayEmoteWithIDNum = Tab12:CreateInput({
    Name = "Play Emote (ID)",
    PlaceholderText = "Enter ID",
    RemoveTextAfterFocusLost = true,
    Callback = function(getTheIDForEmote)
        local getNumberID = tonumber(getTheIDForEmote) or getTheIDForEmote
        
        local succ, err = pcall(function()
            getgenv().Humanoid:PlayEmoteAndGetAnimTrackById(getNumberID)
        end)
        
        if succ then
            getgenv().Humanoid:PlayEmoteAndGetAnimTrackById(getNumberID)
        else
            return getgenv().notify("Error:", tostring(err), 7)
        end
    end,})

    getgenv().StopTheEmotes = Tab12:CreateButton({
    Name = "Stop Emoting",
    Callback = function()
        for _, animTrack in pairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
    end,})

    function check_GamePass(id)
        local MarketplaceService = game:GetService("MarketplaceService")
        local player = getgenv().LocalPlayer
        local gamePassId = tonumber(id)

        local success, hasPass = pcall(function()
            return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePassId)
        end)

        if success then
            if hasPass then
                print("Player owns the Game Pass! Loading :: Action")
            else
                print("Player does not own the GamePass! Not loading :: Action")
            end
        else
            warn("Error checking Game Pass ownership:", hasPass)
        end
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        if check_GamePass(951459548) then
            getgenv().quickAvChange = Tab13:CreateToggle({
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
        else
            warn("User does not own GamePass - Not loading this option.")
        end
    else
        warn("Not in MIC UP or MIC UP 17+, not loading this part.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().AutoChangingBooth = Tab11:CreateToggle({
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
            
            if crazy then
                wait()
                local Stall = getStall()
                
                if not Stall then
                    return getgenv().notify("Error:", "You do not own a Booth, claim one!", 6)
                end

                local write_words = {
                    "Zacks Easy Hub [WINNING]!",
                    "Join: VJh3kkYzBn",
                    "Zacks Easy Hub [WE UP]!",
                    "Zacks Easy Hub V6, POWERFUL!",
                    "Powering Automation | Scripting",
                    "Zacks Easy Hub | WE OP!",
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
    else
        warn("Did not load this Booth tab [7].")
    end

    getgenv().GraphicsEnhancer = Tab16:CreateButton({
    Name = "Graphics Enhancer",
    Callback = function()
        if getgenv().graphics_upper then
            return getgenv().notify("Failure!", "Graphics Enhancer script is already loaded!", 5)
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/PublicScriptsOnRobloxExploiting/refs/heads/main/GraphicsEnhancer.lua"))()
            getgenv().graphics_upper = true
        end
    end,})

    getgenv().CtrlClickTP = Tab16:CreateToggle({
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
        if getgenv().zeezyEnabled then
            return getgenv().notify("Failure", "Backflips is already loaded.", 5)
        end
        wait()
        if getgenv().loaded_face_bang then
            return getgenv().notify("Failure", "Please switch off Face F**k before using this.", 5)
        end
        wait(0.2)
        local ver = "2.15" 
        local scriptname = "feFlip"
        
        local FrontflipKey = Enum.KeyCode.Z
        local BackflipKey = Enum.KeyCode.X
        local AirjumpKey = Enum.KeyCode.C
        
        local ca = getgenv().ContextActionService
        getgenv().zeezyEnabled = true
        local h = 0.0174533
        
        function zeezyFrontflip(act, inp, obj)
            if not getgenv().zeezyEnabled then return end
            if inp == Enum.UserInputState.Begin then
                getgenv().Humanoid:ChangeState(3)
                wait()
                getgenv().Humanoid.Sit = true
                for i = 1, 360 do 
                    delay(i / 720, function()
                        if not getgenv().zeezyEnabled then return end
                        getgenv().Humanoid.Sit = true
                        getgenv().HumanoidRootPart.CFrame = getgenv().HumanoidRootPart.CFrame * CFrame.Angles(-h, 0, 0)
                    end)
                end
                wait(0.55)
                getgenv().Humanoid.Sit = false
            end
        end
        
        function zeezyBackflip(act, inp, obj)
            if not getgenv().zeezyEnabled then return end
            if inp == Enum.UserInputState.Begin then
                getgenv().Humanoid:ChangeState(3)
                wait()
                getgenv().Humanoid.Sit = true
                for i = 1, 360 do
                    delay(i / 720, function()
                        if not getgenv().zeezyEnabled then return end
                        getgenv().Humanoid.Sit = true
                        getgenv().HumanoidRootPart.CFrame = getgenv().HumanoidRootPart.CFrame * CFrame.Angles(h, 0, 0)
                    end)
                end
                wait(0.55)
                getgenv().Humanoid.Sit = false
            end
        end
        
        function zeezyAirjump(act, inp, obj)
            if not getgenv().zeezyEnabled then return end
            if inp == Enum.UserInputState.Begin then
                getgenv().Humanoid:ChangeState("Seated")
                wait()
                getgenv().Humanoid:ChangeState(3)	
            end
        end
        
        ca:BindAction("zeezyFrontflip", zeezyFrontflip, false, FrontflipKey)
        ca:BindAction("zeezyBackflip", zeezyBackflip, false, BackflipKey)
        ca:BindAction("zeezyAirjump", zeezyAirjump, false, AirjumpKey)
        
        local notifSound = Instance.new("Sound", workspace)
        notifSound.PlaybackSpeed = 1.5
        notifSound.Volume = 0.25
        notifSound.SoundId = "rbxassetid://170765130"
        notifSound.PlayOnRemove = true
        notifSound:Destroy()
        wait(0.2)
        getgenv().notify("Success", "FE Flip loaded successfully!", 6)
        wait()
        game.StarterGui:SetCore("SendNotification", {
            Title = "feFlip", 
            Text = "FE Flip loaded successfully!", 
            Icon = "rbxassetid://505845268", 
            Duration = 8, 
            Button1 = "Okay"
        })
    end,})

    getgenv().TurnOffBackflipsScript = Tab16:CreateButton({
    Name = "Disable Backflips Script",
    Callback = function()
        if getgenv().zeezyEnabled == nil then
            return getgenv().notify("Error:", "BackFlip is not loaded.", 5)
        end
        
        getgenv().zeezyEnabled = false
        wait(0.2)
        local ca = getgenv().ContextActionService
        ca:UnbindAction("zeezyFrontflip")
        ca:UnbindAction("zeezyBackflip")
        ca:UnbindAction("zeezyAirjump")
        wait(0.2)
        getgenv().notify("Success", "FE Flip has been disabled successfully!", 6)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "feFlip",
            Text = "FE Flip disabled successfully!",
            Icon = "rbxassetid://505845268",
            Duration = 8,
            Button1 = "Okay"
        })
    end,})

    getgenv().InfJumpDoFunc = Tab16:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "ConnectionInfiJump",
    Callback = function(infJumpConnect)
        if infJumpConnect then
            local Player = getgenv().LocalPlayer
            local UIS = getgenv().UserInputService
            
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

    getgenv().faceBangScript = Tab16:CreateButton({
    Name = "Face F**k Script (Press: Z)",
    Callback = function()
        if getgenv().loaded_face_bang then
            return getgenv().notify("Notification:", "Already loaded face f*ck script!", 7.5)
        else
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/bruhlolw/refs/heads/main/face_bang_script.lua'))()
            getgenv().loaded_face_bang = true
        end
    end,})

    getgenv().noclipToggle = Tab2:CreateToggle({
    Name = "Noclip",
    CurrentValue =  false,
    Flag = "toggleNoclipChar",
    Callback = function(noclip_toggle)
        function reset_collide(reset_bool)
            if reset_bool == true then
                getgenv().Character:FindFirstChild("HumanoidRootPart").CanCollide = true
                getgenv().Character:FindFirstChild("LowerTorso").CanCollide = true
                getgenv().Character:FindFirstChild("UpperTorso").CanCollide = true
                getgenv().HumanoidRootPart.CanCollide = true
            elseif reset_bool == false then
                getgenv().Character:FindFirstChild("HumanoidRootPart").CanCollide = false
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

    getgenv().FlyNoclip = Tab16:CreateToggle({
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
    getgenv().FlyScript = Tab16:CreateToggle({
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
    getgenv().glitchSideToSideSpeed = Tab16:CreateSlider({
    Name = "Glitch Speed (Less = Faster)",
    Range = {0.1, 3},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0.1,
    Flag = "sideToSpeed",
    Callback = function(gotSideSpeed)
        local converted_num = tonumber(gotSideSpeed)

        tp_speed = converted_num
    end,})

    getgenv().glitchScriptDistance = Tab16:CreateSlider({
    Name = "SideToSide Script Distance",
    Range = {1, 100},
    Increment = 1,
    Suffix = "Distance",
    CurrentValue = 20,
    Flag = "sideToSideDistance",
    Callback = function(DistanceNum)
        teleportDistance = DistanceNum
    end,})

    getgenv().glitchingSide = Tab16:CreateToggle({
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
        Speed = 1.5
    }

    getgenv().keyToFlash = Tab16:CreateInput({
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

    getgenv().FlashbackSpeed = Tab16:CreateSlider({
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
    getgenv().flashBackRewindScript = Tab16:CreateButton({
    Name = "Flashback Rewind",
    Callback = function()
        if getgenv().flashbacks_script then
            return getgenv().notify("Failed", "Flashback Rewind is already running!", 7)
        end

        local key = Enum.KeyCode[getgenv().settings_flashback.Keybind]
        if not Enum.KeyCode[getgenv().settings_flashback.Keybind] then
            return getgenv().notify("Invalid Key!", "KeyCode seems to be invalid, try another one", 6)
        end

        local flashbackLength = 95
        local flashbackSpeed = tonumber(getgenv().settings_flashback.Speed)
        
        getgenv().frames = getgenv().frames or {}
        local frames = getgenv().frames
        
        local uis = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
        local player = getgenv().LocalPlayer
        local runService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
        local humanoid = getgenv().Humanoid
        local character = getgenv().Character
        local humanoidRootPart = getgenv().HumanoidRootPart

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
            local character = getgenv().Character
            local humanoidRootPart = getgenv().HumanoidRootPart
            local humanoid = getgenv().Humanoid
            
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
        
        repeat wait(1) until character and humanoid and humanoidRootPart
        if character and humanoid and humanoidRootPart then
            runService:BindToRenderStep("FlashbackStep", 1, onRenderStep)
        end
        wait(.2)
        getgenv().flashbacks_script = true
    end,})

    getgenv().stopFlashbackScript = Tab16:CreateButton({
    Name = "Unload Flashback (Stop Running/Quit)",
    Callback = function()
        local runService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")

        if getgenv().flashbacks_script then
            pcall(function()
                runService:UnbindFromRenderStep("FlashbackStep")
                getgenv().frames = nil
                getgenv().flashbacks_script = false
                getgenv().flashback = nil
            end)
        else
            return getgenv().notify("Error:", "Flashback Rewind has not been loaded.", 5)
        end
    end,})

    if workspace:FindFirstChild("Elevator") and workspace:FindFirstChild("Obby") then
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
        getgenv().elevatorModifier = Tab1:CreateToggle({
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

        getgenv().collisionForElevator = Tab1:CreateToggle({
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
    else
        getgenv().checked_function_elevator = true
        warn("Skipping Elevator Section.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().InfoLabelParagraph = Tab13:CreateParagraph({Title = "Information:", Content = "Type 'stop' to stop flying."})
        wait()
        getgenv().InfoLabelParagraph = Tab13:CreateParagraph({Title = "Controls:", Content = "Space = Up | Q = Down"})
        wait()
        getgenv().getHoverboardFlyInput = Tab13:CreateInput({
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
    else
        warn("Not MIC UP or MIC UP 17+, not loading Hoverboard Fly")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().viewBooth = Tab11:CreateToggle({
        Name = "View Your Booth",
        CurrentValue = false,
        Flag = "theBoothView",
        Callback = function(specBooth)
            local function get_booth()
                for i,v in pairs(getgenv().Workspace.Booth:GetChildren()) do
                    if v.User.SurfaceGui.ImageLabel.Image == "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(getgenv().LocalPlayer.UserId).."&width=420&height=420&format=png" then
                        return v
                    end
                end
                return nil
            end

            local plr_booth = get_booth()

            if not plr_booth then
                return getgenv().notify("Error:", "You do not have a booth, claim one!", 5)
            end
            wait()
            if specBooth and plr_booth then
                getgenv().viewing_booth = true
                getgenv().Camera.CameraSubject = plr_booth
            else
                getgenv().viewing_booth = false
                wait(0.2)
                getgenv().Camera.CameraSubject = getgenv().Character
            end
        end,})

        getgenv().TPToBooth = Tab11:CreateButton({
        Name = "Teleport To Booth",
        Callback = function()
            local function get_booth()
                for i,v in pairs(getgenv().Workspace.Booth:GetChildren()) do
                    if v.User.SurfaceGui.ImageLabel.Image == "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(getgenv().LocalPlayer.UserId).."&width=420&height=420&format=png" then
                        return v
                    end
                end
                return nil
            end

            local plr_booth = get_booth()

            if not plr_booth then
                return getgenv().notify("Error: ", "You do not have a booth, claim one!", 6.5)
            end
            task.wait()
            getgenv().Character:PivotTo(plr_booth:GetPivot())
        end,})
    else
        warn("Did not load these Booth's [7].")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().tpToAvatarUI = Tab1:CreateButton({
        Name = "Teleport To Avatar-UI",
        Callback = function()
            local Folder = getgenv().Workspace:FindFirstChild("PartStorage")
            local Avatar_UI = Folder:FindFirstChild("AvatarUI")
            wait(.1)
            getgenv().Character:PivotTo(Avatar_UI:GetPivot())
        end,})

        getgenv().AutoLikingPlayer = Tab1:CreateToggle({
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

        getgenv().dislikePlayersAvatar = Tab1:CreateToggle({
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
    else
        warn("User is not in MIC UP or MIC UP 17+, not loading.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        if firesignal then
            getgenv().Stop_Music_Player = Tab1:CreateButton({
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
                    return getgenv().notify("Error:", "Your executor does not support 'firesignal'!", 6)
                end
            end,})

            getgenv().Music_Player = Tab1:CreateButton({
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
                    return getgenv().notify("Error:", "Your executor does not support 'firesignal'!", 6)
                end
            end,})

            getgenv().Music_Player = Tab1:CreateToggle({
            Name = "Loop Shuffle In-Game Music",
            CurrentValue = false,
            Flag = "ToggleInGameMusic",
            Callback = function(ingame_music)
                if ingame_music then
                    getgenv().plr_music_menu = true
                    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
                    local Local_Player = Players.LocalPlayer
                    local PlayerGui = Local_Player and Local_Player:WaitForChild("PlayerGui")
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
                        return getgenv().notify("Error:", "Your executor does not support 'firesignal'!", 6)
                    end
                else
                    local Local_Player = game:GetService("Players").LocalPlayer
                    local PlayerGui = Local_Player:WaitForChild("PlayerGui")
                    local Menu = PlayerGui:WaitForChild("Menu")
                    local Background = Menu:WaitForChild("Background")
                    local Music = Background:WaitForChild("Music")
                    local Stop = Music:WaitForChild("Stop")
                    local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
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
                        return getgenv().notify("Error:", "Your executor does not support 'firesignal'!", 6)
                    end
                end
            end,})
        else
            warn("'firesignal' unsupported, not loading In-Game music functions.")
        end
    else
        warn("Not MIC UP or MIC UP 17+, not loading In-Game music functions.")
    end

    loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/GetOuttaHereLmao/refs/heads/main/get_out_meme.js'))()

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().WhitelistFriendPlr = Tab1:CreateToggle({
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
                    return getgenv().notify("Error:", "You have 0 friends in this server!", 6)
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
    else
        warn("User is not in MIC UP or MIC UP 17+, not loading.")
    end

    getgenv().GotoPlayerBox = Tab13:CreateInput({
    Name = "Goto/TP Player",
    CurrentValue = "",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "TPToPlayerBo",
    Callback = function(get_player_func)
        local tp_pivot_plr = findplr(get_player_func)
        if not tp_pivot_plr then
            return getgenv().notify("Error:", "Player not found or does not exist!", 6)
        end
        task.wait(.2)

        local tp_getpivot_char = tp_pivot_plr.Character

        if tp_getpivot_char then
            getgenv().Character:PivotTo(tp_getpivot_char:GetPivot())
        else
            return getgenv().notify("Error:", "Player: "..tostring(get_player_func).." does not exist!", 5)
        end
    end,})

    getgenv().ViewPlrBox = Tab13:CreateInput({
    Name = "View/Spectate Player",
    CurrentValue = "",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "ViewPlrSpectating",
    Callback = function(do_plr_func)
        local tp_pivot_plr = findplr(do_plr_func)
        
        if not tp_pivot_plr then
            getgenv().Camera.CameraSubject = getgenv().Character
            return getgenv().notify("Error:", "Player not found or does not exist!", 6)
        end
        task.wait(.2)

        local spectate_char = tp_pivot_plr.Character or tp_pivot_plr.CharacterAdded:Wait()

        if spectate_char then
            getgenv().Camera.CameraSubject = spectate_char
        else
            return getgenv().notify("Error:", "Player does not exist!", 5)
        end
    end,})

    getgenv().UnviewPlr = Tab13:CreateButton({
    Name = "Unview/Unspectate Player",
    Callback = function()
        getgenv().Camera.CameraSubject = getgenv().Character
    end,})

    if setfpscap then
        getgenv().settingFPSSetting = Tab1:CreateSlider({
        Name = "Set FPS Cap",
        Range = {0, 999},
        Increment = 1,
        Suffix = "",
        CurrentValue = 999,
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
        getgenv().notify("Failed!", exec.." does not support 'setfpscap'", 5)
    else
        getgenv().notify("Failure!", "Your executor does is garbage and does not support 2 ez functions.", 5)
    end

    getgenv().MutingMyself = Tab1:CreateToggle({
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

    getgenv().DelInventory = Tab5:CreateButton({
    Name = "Delete Inventory",
    Callback = function()
        local Replicated_Storage = getgenv().ReplicatedStorage
        local Delete_Inv_RemoteEvent = Replicated_Storage:WaitForChild("DeleteInventory") or Replicated_Storage:FindFirstChild("DeleteInventory")
        
        Delete_Inv_RemoteEvent:FireServer()
    end,})

    function Tools_Grab_Func()
        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
        local MarketplaceService = cloneref and cloneref(game:GetService("MarketplaceService")) or game:GetService("MarketplaceService")
        local player = Players.LocalPlayer
        local gamepassId = 951459548

        local success, hasPass = pcall(function()
            return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
        end)
        if success and hasPass then
            print(tostring(player.Name).." owns this GamePass, moving on.")
        else
            getgenv().shouldGrabTools = false
            getgenv().shouldGrabTools = false
            getgenv().getEverything:Set(false)
            getgenv().getEverything:Set(false)
            getgenv().getEverything:Set(false)
        end
        wait(0.2)
        local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage") or getgenv().ReplicatedStorage
        local ToolEvent = ReplicatedStorage and ReplicatedStorage:FindFirstChild("ToolEvent") or ReplicatedStorage:WaitForChild("ToolEvent", 3)
        local Randomizer = math.random(5, 9)

        local function PickUp_Tool(Tool)
            ToolEvent:FireServer(tostring(Tool))
        end

        for i = 1, Randomizer do
            PickUp_Tool("Announcer")
            PickUp_Tool("Bag")
            PickUp_Tool("BlowDryer")
            PickUp_Tool("Brick")
            PickUp_Tool("Camera")
            PickUp_Tool("Coil")
            PickUp_Tool("Design")
            PickUp_Tool("Doll")
            PickUp_Tool("FireworkLaunch")
            PickUp_Tool("Firework")
            PickUp_Tool("Fit")
            PickUp_Tool("Gun")
            PickUp_Tool("Horrible")
            PickUp_Tool("Hoverboard")
            PickUp_Tool("Knife")
            PickUp_Tool("Motor")
            PickUp_Tool("Pistol")
            PickUp_Tool("Spray")
            PickUp_Tool("Suitbag")
            PickUp_Tool("Tele")
            PickUp_Tool("Torch")
            PickUp_Tool("Wand")
        end
    end

    getgenv().GrabEverything = Tab5:CreateButton({
    Name = "Grab All Tools",
    Callback = function()
        Tools_Grab_Func()
    end,})

    getgenv().getEverything = Tab5:CreateToggle({
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
            getgenv().shouldGrabTools = false
            wait(0.5)
            Delete_Inv_Event:FireServer()
        end
    end,})

    getgenv().ChatBypassBest = Tab4:CreateButton({
    Name = "Chat Bypass (UserCreation, not up rn)",
    Callback = function()
        --loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/refs/heads/main/UserCreation.lua", true))()
        getgenv().notify("Error:", "The library would close and you would have to rejoin.", 6)
        return getgenv().notify("[Read]:", "Usercreation bypassing is temporarily disabled.", 6)
    end,})
    wait(0.2)
    local textChatService = cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")
    local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")

    local function detectChatVersion() 
        local textChatService = cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")
        
        if textChatService and textChatService.ChatVersion ~= Enum.ChatVersion.LegacyChatService then
            return "TextChatService"
        else
            return "LegacyChatService"
        end
    end
    wait(0.2)
    local chatVersion = detectChatVersion()
    wait(0.2)
    getgenv().sending_async = function(content)
        local chatVersion = detectChatVersion()

        if chatVersion == "LegacyChatService" then
            local chatRemote = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
            if chatRemote and chatRemote:FindFirstChild("SayMessageRequest") then
                chatRemote.SayMessageRequest:FireServer(tostring(content), "All")
            else
                getgenv().notify("Error:", "Could not find SayMessageRequest in DefaultChatSystemChatEvents", 6)
            end
        elseif chatVersion == "TextChatService" then
            local chatChannel = textChatService:FindFirstChild("TextChannels") and textChatService.TextChannels:FindFirstChild("RBXGeneral")
            if chatChannel then
                chatChannel:SendAsync(tostring(content))
            else
                getgenv().notify("Error:", "Could not find RBXGeneral channel in TextChatService", 6)
            end
        else
            return getgenv().notify("Error:", "Could not detect correct chat version/service.", 6)
        end
    end
    wait(0.2)
    getgenv().ClearChatMsgs = Tab4:CreateButton({
    Name = "Clear Chat Messages",
    Callback = function()
        for i = 1, 6 do
            getgenv().sending_async(".")
            getgenv().sending_async(" ")
            task.wait(0.2)
            getgenv().sending_async("/cls")
            task.wait(0.5)
        end
    end,})

    getgenv().GetFakeChatGUI = Tab4:CreateButton({
    Name = "Fake Chat GUI",
    Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/FakeChatGUI/main/LmaoBruh.lua')))()
    end,})

    getgenv().ChatBypassTextInput = Tab4:CreateInput({
    Name = "Chat Bypass Input",
    PlaceholderText = "Text",
    RemoveTextAfterFocusLost = true,
    Callback = function(saveInputFilter)
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
            getgenv().sending_async(tostring(msg))
        end
        wait(0.2)
        sendchat(saveInputFilter)
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().inputBypassTextBooth = Tab11:CreateInput({
        Name = "Booth Text Bypass",
        PlaceholderText = "Text",
        RemoveTextAfterFocusLost = true,
        Callback = function(enteredTextInput)
            local Booth_Remote = getgenv().ReplicatedStorage:FindFirstChild("UpdateBoothText")

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
                    return getgenv().notify("Error:", "You do not have a booth! Claim One", 5)
                else
                    print(tostring(LocalStall))
                end
                wait()
                local args = {
                    [1] = tostring(convert(msg)),
                    [2] = tostring(color_selector()),
                    [3] = "SourceSans"
                }
                        
                Booth_Remote:FireServer(unpack(args))
            end

            send_bypass_config(enteredTextInput)
        end,})
    else
        warn("Did not load this Booth tab [8].")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        local gamePassId = 951459548

        if not getgenv().MarketplaceService:UserOwnsGamePassAsync(getgenv().LocalPlayer.UserId, gamePassId) then
            warn("You do not own the Admin GamePass, not loading Tab: [Character Flicker (FE)]")
        else
            getgenv().DoCharacterFlicking = Tab2:CreateToggle({
            Name = "Character Flicker (FE)",
            CurrentValue = false,
            Flag = "CharFlickeringLmao",
            Callback = function(Flick)
                if Flick then
                    getgenv().CharFlick = true
                    while getgenv().CharFlick == true do
                        task.wait()
                        local Update_Height_Remote = getgenv().ReplicatedStorage:WaitForChild("UpdateHeight")
                        local Update_Depth_Remote = getgenv().ReplicatedStorage:WaitForChild("UpdateDepth")
                        local Update_Width_Remote = getgenv().ReplicatedStorage:WaitForChild("UpdateWidth")

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
                    local Modify_User_Remote = getgenv().ReplicatedStorage:WaitForChild("ModifyUserEvent")
                    local Local_Player = getgenv().LocalPlayer
                    local Local_Plr_Name = Local_Player.Name or tostring(Local_Player.Name)

                    getgenv().CharFlick = false
                    wait(0.3)
                    local args = {
                        [1] = tostring(Local_Plr_Name)
                    }
                    
                    Modify_User_Remote:FireServer(unpack(args))
                end
            end,})
        end
    else
        warn("Not loading this part, not on MIC UP or MIC UP 17+")
    end
    if getgenv().connections_loaded then
        warn("Already loaded connection manager.")
    else
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
        getgenv().connections_loaded = true
    end
    wait()
    local Settings = {
        Keybind = string.upper("C")
    }

    getgenv().GetInvis = Tab2:CreateButton({
    Name = "Invisible",
    Callback = function()
        if getgenv().Invis_Loaded == true or Invis_Loaded and not getgenv().INVIS_DEBUG == true then
            return getgenv().notify("Error:", "Invisible Is Already Loaded!", 6.5)
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
        getgenv().notify("Success!", "Invisible Has Been Loaded!", 7)
        task.wait(.3)
        getgenv().notify("Info:", "Press "..tostring(Settings.Keybind).." to change visibility.", 10)
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().PrivRoomFloor = Tab10:CreateButton({
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

        getgenv().NextToBathrooms = Tab10:CreateButton({
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

        getgenv().TPToBathrooms = Tab10:CreateButton({
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

        getgenv().TPToChilling = Tab10:CreateButton({
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

        getgenv().TPPicnicFirst = Tab10:CreateButton({
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

        getgenv().TPPicnicSecond = Tab10:CreateButton({
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

        getgenv().TPMicFirst = Tab10:CreateButton({
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

        getgenv().TPMicSecond = Tab10:CreateButton({
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

        getgenv().TPMiddleRoomArea = Tab10:CreateButton({
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

        getgenv().TPBoothRows = Tab10:CreateButton({
        Name = "TP To Booth Rows (Table)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(26.7397423, 7.81395245, 86.7164536)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(26.7397423, 7.81395245, 86.7164536)
            end
        end,})

        getgenv().TPToTowerFloatPart = Tab10:CreateButton({
        Name = "TP To Tower (Float Up Part)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(61.3288841, 72.0192184, 215.731613)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(61.3288841, 72.0192184, 215.731613)
            end
        end,})

        getgenv().TPToTowerTop = Tab10:CreateButton({
        Name = "TP To Tower (Top)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(63.2298126, 284.407227, 193.529007)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(63.2298126, 284.407227, 193.529007)
            end
        end,})

        getgenv().TPToHighestPoint = Tab10:CreateButton({
        Name = "TP To Tower (Highest Part)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(58.0468788, 313.312622, 225.215027)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(58.0468788, 313.312622, 225.215027)
            end
        end,})

        getgenv().TPBooth1 = Tab10:CreateButton({
        Name = "TP To Booth-1",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth01")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth01")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth2 = Tab10:CreateButton({
        Name = "TP To Booth-2",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth02")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth02")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth3 = Tab10:CreateButton({
        Name = "TP To Booth-3",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth03")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth03")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth4 = Tab10:CreateButton({
        Name = "TP To Booth-4",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth04")
                Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth04")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth5 = Tab10:CreateButton({
        Name = "TP To Booth-5",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth05")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth05")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPToDonutShop = Tab10:CreateButton({
        Name = "TP To Donut Shop",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-80.8301239, 3.1662631, -82.6656799)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-80.8301239, 3.1662631, -82.6656799)
            end
        end,})

        getgenv().TPSeat1Donut = Tab10:CreateButton({
        Name = "TP To Donut Shop (Seat 1)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-98.4535675, 4.04168415, -96.7826004)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-98.4535675, 4.04168415, -96.7826004)
            end
        end,})

        getgenv().TPSeat1Donut = Tab10:CreateButton({
        Name = "TP To Donut Shop (Seat 2)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-91.7390671, 4.04168415, -90.0620728)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-91.7390671, 4.04168415, -90.0620728)
            end
        end,})

        getgenv().TPTableSeat1 = Tab10:CreateButton({
        Name = "TP To Donut Shop (Table Seat 1)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-102.440971, 4.51146317, -66.6184387)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-102.440971, 4.51146317, -66.6184387)
            end
        end,})

        getgenv().TPTableSeat2 = Tab10:CreateButton({
        Name = "TP To Donut Shop (Table, Seat 2)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-94.6592941, 4.51146317, -74.3931046)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-94.6592941, 4.51146317, -74.3931046)
            end
        end,})

        getgenv().TPBehindCounter = Tab10:CreateButton({
        Name = "TP To Donut Shop (Behind Counter)",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-122.382172, 3.22726321, -83.5359192)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-122.382172, 3.22726321, -83.5359192)
            end
        end,})

        getgenv().TPAboveRelax = Tab10:CreateButton({
        Name = "TP Above Relaxing Room",
        Callback = function()
            wait(0.4)
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-97.4412308, 24.4840164, 121.394676)
            else
                getgenv().HumanoidRootPart.CFrame = CFrame.new(-97.4412308, 24.4840164, 121.394676)
            end
        end,})

        getgenv().TPSubmitNoteBoard = Tab10:CreateButton({
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

        getgenv().TPStageMic = Tab10:CreateButton({
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

        getgenv().TPPrivRoomRoof = Tab10:CreateButton({
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
    else
        warn("Not MIC UP or MIC UP 17+ teleports not being loaded.")
    end

    getgenv().invisKeybindSet = Tab2:CreateInput({
    Name = "Invisible Keybind",
    PlaceholderText = "Keybind Here",
    RemoveTextAfterFocusLost = true,
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
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 or game.PlaceId == 80080558412215 then
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
            print("// << -- Authenticated -- >>")
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
        getgenv().ClickingAllBoards = Tab5:CreateButton({
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

        getgenv().LoopClickAllBoards = Tab5:CreateToggle({
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
    else
        warn("Not MIC UP or MIC UP 17+ or German Hangout (VC), not loading these TicTacToe options.")
    end

    getgenv().InfYield = Tab5:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        if getgenv().inf_yield_side then
            return getgenv().notify("Alert!", "Infinite Yield has already been loaded.", 7)
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua", true))()
            getgenv().notify("Heads Up!", "We have now defaulted to a new Infinite Yield script [mine].", 5)
            getgenv().inf_yield_side = true
        end
    end,})

    getgenv().WalkSpeedSliding = Tab2:CreateSlider({
    Name = "WalkSpeed (Default): 16",
    Range = {16, 450},
    Increment = 1,
    Suffix = "",
    CurrentValue = 16,
    Flag = "walkSpeedValue",
    Callback = function(wsVal)
        getgenv().Humanoid.WalkSpeed = wsVal
    end,})

    if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
        getgenv().notify("Returned", "Found Method: JumpPower", 6)
        local JumpPowerSlider = Tab2:CreateSlider({
        Name = "JumpPower (Default): 50",
        Range = {50, 750},
        Increment = 1,
        Suffix = "",
        CurrentValue = 16,
        Flag = "jpValue",
        Callback = function(jpVal)
            getgenv().Humanoid.JumpPower = jpVal
        end,})
    else
        getgenv().notify("Returned-2", "Found Method: JumpHeight", 6)
        local HeightJumpPowerSliding = Tab2:CreateSlider({
        Name = "JumpHeight (Default): 7",
        Range = {7, 450},
        Increment = 1,
        Suffix = "",
        CurrentValue = 7,
        Flag = "jumpHeightValue",
        Callback = function(jumpHVal)
            getgenv().Humanoid.JumpHeight = jumpHVal
        end,})
    end

    getgenv().GravSliding = Tab2:CreateSlider({
    Name = "Gravity (Default): 196.2",
    Range = {1, 200},
    Increment = 1,
    Suffix = "",
    CurrentValue = 196.2,
    Flag = "GravityValue",
    Callback = function(gravVal)
        getgenv().Workspace.Gravity = gravVal
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().antiBangTPLoop = Tab2:CreateToggle({
        Name = "Anti Bang/TP (Loop Method)",
        CurrentValue = false,
        Flag = "AntiBangTPLooping",
        Callback = function(doAntiTP)
            if getgenv().doTeleport or getgenv().doTeleport == true then
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
    else
        warn("This is not MIC UP or MIC UP 17+, not loading Loop teleport method for Anti-Bang.")
    end

    getgenv().bruhAntiTPMethod3 = Tab2:CreateButton({
    Name = "Anti Bang/TP (Method 3, You Die To)",
    Callback = function()
        local voidPosition = Vector3.new(-499, -499, -499)
        local Workspace = getgenv().Workspace
        local HumanoidRP = getgenv().HumanoidRootPart
        print("Killing...")
        wait(.4)
        HumanoidRP.CFrame = CFrame.new(voidPosition)
    end,})

    getgenv().MethodFourAntiTP = Tab2:CreateToggle({
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

    getgenv().ClockTimeSlider = Tab9:CreateSlider({
    Name = "ClockTime Slider (Default: 14)",
    Range = {0, 24},
    Increment = 1,
    Suffix = "",
    CurrentValue = 14,
    Flag = "SlidingClockTimeSlider",
    Callback = function(slideClockTime)
        local sliding_clocktime = tonumber(slideClockTime)

        getgenv().Lighting.ClockTime = sliding_clocktime
    end,})

    getgenv().ClockTimeSliderReset = Tab9:CreateButton({
    Name = "Reset ClockTime (14)",
    Callback = function()
        getgenv().Lighting.ClockTime = 14
    end,})

    getgenv().BrightnessSlider = Tab9:CreateSlider({
    Name = "Brightness Slider (Default: 3)",
    Range = {0, 10},
    Increment = 1,
    Suffix = "",
    CurrentValue = 3,
    Flag = "SlidingBrightnessSlider",
    Callback = function(slideBrightnessVal)
        local Value_Brightness = tonumber(slideBrightnessVal)

        getgenv().Lighting.Brightness = Value_Brightness
    end,})

    getgenv().ResetBrightness = Tab9:CreateButton({
    Name = "Reset Brightness (3)",
    Callback = function()
        getgenv().Lighting.Brightness = 3
    end,})

    getgenv().RainbowAmbient = Tab9:CreateToggle({
    Name = "Rainbow Ambient",
    CurrentValue = false,
    Flag = "ambientIsRainbowToggle",
    Callback = function(toggleRainbowAmbientInf)
        if toggleRainbowAmbientInf then
            getgenv().AmbientChangerEnabled = true
            wait()
            local TweenService = game:GetService("TweenService")
            local Lighting = game:GetService("Lighting")

            local colors = {
                Color3.fromRGB(255, 165, 0),
                Color3.fromRGB(255, 255, 0),
                Color3.fromRGB(0, 255, 0),
                Color3.fromRGB(128, 0, 128),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(0, 0, 0),
                Color3.fromRGB(0, 0, 255),
                Color3.fromRGB(139, 69, 19),
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(0, 255, 255)
            }
            wait(0.2)
            local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local index = 1
            local connection

            local function changeAmbientColor()
                while getgenv().AmbientChangerEnabled do
                    local targetColor = colors[index]
                    local tween = TweenService:Create(Lighting, tweenInfo, { Ambient = targetColor })
                    tween:Play()
                    tween.Completed:Wait()

                    index = index % #colors + 1
                end
            end

            connection = task.spawn(changeAmbientColor)
            getgenv().AmbientChangerConnection = connection
        else
            if getgenv().AmbientChangerEnabled then
                getgenv().AmbientChangerEnabled = false
                if getgenv().AmbientChangerConnection then
                    task.cancel(getgenv().AmbientChangerConnection)
                    getgenv().AmbientChangerConnection = nil
                end
            end
            getgenv().AmbientChangerEnabled = false
        end
    end,})

    getgenv().AmbientChooser = Tab9:CreateColorPicker({
    Name = "Ambient Color",
    Color = Color3.fromRGB(40, 40, 40),
    Flag = "AmbientChoosingColor",
    Callback = function(color_ambient)
        getgenv().Lighting.Ambient = color_ambient
    end,})

    getgenv().ChooseLightingTechnology = Tab9:CreateDropdown({
    Name = "Lighting Technology",
    Options = {"Compatibility","Future","Legacy","ShadowMap","Unified","Voxel"},
    CurrentOption = {"ShadowMap"},
    MultipleOptions = false,
    Flag = "ChoosingTechnology",
    Callback = function(Tech_Lighting)
        if typeof(Tech_Lighting) == "table" then
            Tech_Lighting = Tech_Lighting[1]
        end

        if typeof(Tech_Lighting) ~= "string" then
            return warn("Invalid Technology Option selected. Expected a string, got: "..typeof(Tech_Lighting))
        end

        local TechnologyEnum = Enum.Technology[Tech_Lighting]
        if not TechnologyEnum then
            return getgenv().notify("Error:", "Invalid material: "..tostring(TechnologyEnum), 5)
        end

        getgenv().Lighting.Technology = Enum.Technology[Tech_Lighting]
    end,})

    getgenv().LightingReset = Tab9:CreateButton({
    Name = "Reset Lighting",
    Callback = function()
        resetLightingSettings()
        wait(0.3)
        if not game:GetService("MaterialService").Use2022Materials or game:GetService("MaterialService").Use2022Materials == false then
            getgenv().material_toggle(true)
        else
            getgenv().notify("True", "'Use2022Materials' is enabled | Continue.", 7)
        end
    end,})

    getgenv().fireworksToggle = Tab9:CreateToggle({
    Name = "FireWorks (Sky)",
    CurrentValue = false,
    Flag = "FireworksInSkyLoop",
    Callback = function(FireWorksCrazy)
        if FireWorksCrazy then
            local Lighting = cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
            Lighting.ClockTime = 1
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

    getgenv().NightTimeButton = Tab9:CreateButton({
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

    getgenv().NightTimeWithLight = Tab9:CreateButton({
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

    getgenv().DayTimeReset = Tab9:CreateButton({
    Name = "DayTime",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.ClockTime = 12
        wait()
        Lighting.Brightness = 1.5
    end,})

    getgenv().SpookyMoonToggle = Tab9:CreateToggle({
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

    getgenv().SpookySunLoop = Tab9:CreateToggle({
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

    getgenv().SpookyNightTimeHalloween = Tab9:CreateButton({
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

    getgenv().emoting_actions = function(speed)
        if speed then
            for _, v in pairs(getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
                v:AdjustSpeed(speed)
            end
        else
            for _, v in pairs(getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
                v:Stop()
            end
        end
    end
    wait(0.1)
    getgenv().slowMotionToggle = Tab12:CreateToggle({
    Name = "Slow Motion Emotes (Loop)",
    CurrentValue = false,
    Flag = "slowMotionAllEmotes",
    Callback = function(slowMotion)
        if slowMotion then
            getgenv().slowMotion = true
            while getgenv().slowMotion == true do
            wait()
                getgenv().emoting_actions(0.2)
            end
        else
            getgenv().slowMotion = false
            wait(0.3)
            getgenv().emoting_actions(1)
            wait(0.1)
            getgenv().emoting_actions()
        end
    end,})

    getgenv().FreezeEmotesToggle = Tab12:CreateToggle({
    Name = "Freeze Emotes",
    CurrentValue = false,
    Flag = "FreezingEveryEmote",
    Callback = function(freezeToggle)
        if freezeToggle then
            getgenv().doFreezeToggle = true
            while getgenv().doFreezeToggle == true do
            wait()
                getgenv().emoting_actions(0)
            end
        else
            getgenv().doFreezeToggle = false
            wait(0.5)
            getgenv().emoting_actions(1)
            wait()
            getgenv().emoting_actions()
        end
    end,})

    getgenv().FastestEmotes = Tab12:CreateToggle({
    Name = "Fast Emotes (Loop)",
    CurrentValue = false,
    Flag = "FastEmotesEveryEmote",
    Callback = function(fastToggle)
        if fastToggle then
            getgenv().fastToggle = true
            while getgenv().fastToggle == true do
            wait()
                getgenv().emoting_actions(70)
            end
        else
            getgenv().fastToggle = false
            wait(0.5)
            getgenv().emoting_actions(1)
            wait()
            getgenv().emoting_actions()
        end
    end,})

    getgenv().StopAllEmotes = Tab12:CreateButton({
    Name = "Stop Playing Emotes",
    Callback = function()
        getgenv().emoting_actions()
    end,})

    getgenv().EmoteSlidingSpeed = Tab12:CreateSlider({
    Name = "Emote Speed Slider",
    Range = {0, 350},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "EmoteSpeedSliding",
    Callback = function(slidingSpeed)
        getgenv().emoting_actions(slidingSpeed)
    end,})

    getgenv().InputSpeedBox = Tab12:CreateInput({
    Name = "Emote Speed",
    PlaceholderText = "Number",
    RemoveTextAfterFocusLost = true,
    Callback = function(inputNum)
        local number_input = tonumber(inputNum)
        getgenv().emoting_actions(number_input)
    end,})

    getgenv().SpeedTheEmoteUp = Tab12:CreateButton({
    Name = "Kinda Fast Emote Speed",
    Callback = function()
        getgenv().emoting_actions(2)
    end,})

    getgenv().GettingFaster = Tab12:CreateButton({
    Name = "Faster Emote Speed",
    Callback = function()
        getgenv().emoting_actions(4.5)
    end,})

    getgenv().BackToNormalSpeed = Tab12:CreateButton({
    Name = "Normal Emote Speed",
    Callback = function()
        getgenv().emoting_actions(1)
    end,})

    getgenv().SlowerEmoteSpeed = Tab12:CreateButton({
    Name = "Slow Emote Speed",
    Callback = function()
        getgenv().emoting_actions(0.5)
    end,})

    getgenv().SlowingTheEmoteDown = Tab12:CreateButton({
    Name = "Slowest Emote Speed",
    Callback = function()
        getgenv().emoting_actions(0.1)
    end,})

    getgenv().ReverseTheEmote = Tab12:CreateButton({
    Name = "Reverse Emote Speed",
    Callback = function()
        getgenv().emoting_actions(-1)
    end,})

    getgenv().FreeEmotesGUI = Tab12:CreateButton({
    Name = "Free Emotes GUI",
    Callback = function()
        getgenv().notify("Free Emotes:", "Press , [comma] to open Free Emotes GUI", 5)
        task.wait(.1)
        getgenv().notify("Open Button:", "Or use the button on the left side of your screen.", 4)
        task.wait()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LmaoItsCrazyBro/qweytguqwebuqt/refs/heads/main/marked_esp_system_ai"))()
    end,})

    getgenv().MuteAllBruh = Tab1:CreateToggle({
    Name = "Mute All",
    CurrentValue = false,
    Flag = "MutingEveryone",
    Callback = function(TheMuteAll)
        if TheMuteAll then
            getgenv().LmaoGetMuted = true
            while getgenv().LmaoGetMuted == true do
            wait()
                getgenv().VoiceChatInternal:SubscribePauseAll(true)
                getgenv().VoiceChatInternal:SubscribePauseAll(true)
            end
        else
            getgenv().LmaoGetMuted = false
            getgenv().LmaoGetMuted = false
            getgenv().LmaoGetMuted = false
            wait(0.3)
            getgenv().VoiceChatInternal:SubscribePauseAll(false)
            getgenv().VoiceChatInternal:SubscribePauseAll(false)
        end
    end,})

    getgenv().MuteAPlayerSpecific = Tab1:CreateInput({
    Name = "Mute Player",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Callback = function(getAUser)
        local derUser = findplr(getAUser)

        if not derUser then
            return getgenv().notify("Failure!", "User was not found.", 5)
        end
        
        getgenv().shouldMute = true
        getgenv().MutedPlayers = getgenv().MutedPlayers or {}
        getgenv().PlayerConnections = getgenv().PlayerConnections or {}

        function MutePlayer(user)
            getgenv().notify("Success!", "Player has been muted", 5)

            while getgenv().shouldMute == true do
            wait()
                local audiodeviceinput = user:FindFirstChild("AudioDeviceInput")

                audiodeviceinput.Muted = true
            end
        end

        if getgenv().shouldMute or getgenv().shouldMute == true then
            local audiodeviceinput = derUser:FindFirstChild("AudioDeviceInput")

            audiodeviceinput.Muted = true
            wait(0.2)
            getgenv().notify("Success", "Player has been muted!", 5)
        else
            getgenv().notify("Success!", "Loop was enabled already, new player muted.", 5)
            wait(0.1)
            MutePlayer(derUser)
        end
    end,})

    getgenv().ResetButton = Tab15:CreateButton({
    Name = "Reset",
    Callback = function()
        if getgenv().Character:FindFirstChild("Humanoid") then
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").Health = 0
        else
            return getgenv().notify("Failed!", "Humanoid does not exist (nil).", 5)
        end
    end,})

    getgenv().RejoinButton = Tab15:CreateButton({
    Name = "Rejoin",
    Callback = function()
        getgenv().TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, getgenv().LocalPlayer)
    end,})

    getgenv().ServerHopButton = Tab15:CreateButton({
    Name = "Server Hop (Roblox broke this!)",
    Callback = function()
        -- Thanks 'Infinite Yield' I am NOT trying to make any of this right now.
        httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        
        if httprequest then
            getgenv().servers = getgenv().servers or {}
            local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
            local body = getgenv().HttpService:JSONDecode(req.Body)

            if body and body.data then
                for i, v in next, body.data do
                    if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                        table.insert(getgenv().servers, 1, v.id)
                    end
                end
            else
                return getgenv().notify("Failed!", "Unable to retrieve any data from game", 5)
            end
        else
            return getgenv().notify("ServerHop", "httprequest is unsupported. [failed].", 5)
        end

        if #servers > 0 then
            getgenv().TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], getgenv().LocalPlayer)
        else
            return getgenv().notify("ServerHop", "Couldn't find a server [failed].", 5)
        end
    end,})

    getgenv().ChangeUILibColor = Tab15:CreateColorPicker({
    Name = "Change UI Color",
    Color = Color3.fromRGB(30, 30, 30),
    Flag = "UIColoringFunc",
    Callback = function(UIColor)
        if not getgenv().Rayfield or getgenv().Rayfield == nil then
            getgenv().notify("Error:", "You are most likely using the regular UI, don't worry.", 5)
        end

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

        changeColors(getgenv().Rayfield, newFrameColor)
    end,})

    getgenv().ReExecuteGUI = Tab15:CreateButton({
    Name = "Re-Execute/Reload Script/GUI",
    Callback = function()
        getgenv().getLoopKick = false
        getgenv().SCRIPT_EXECUTED = false
        getgenv().Invis_Loaded = false
        getgenv().GetLoopRunning = false
        getgenv().GetLoopRunning = false
        getgenv().LmaoGetMuted = false
        getgenv().css_digital = false
        getgenv().Rayfield:Destroy()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua')))()
    end,})

    getgenv().DestroyGUIScript = Tab15:CreateButton({
    Name = "Destroy GUI/Script",
    Callback = function()
        getgenv().getLoopKick = false
        getgenv().SCRIPT_EXECUTED = false
        getgenv().Invis_Loaded = false
        getgenv().GetLoopRunning = false
        getgenv().GetLoopRunning = false
        getgenv().LmaoGetMuted = false
        getgenv().css_digital = false
        getgenv().Rayfield:Destroy()
    end,})

    getgenv().UnmuteAPlayer = Tab1:CreateInput({
    Name = "Unmute Player",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Callback = function(LolPUser)
        local thisUser = findplr(LolPUser)

        if not thisUser then
            getgenv().notify("Failure", "Player was not found.", 5)
        end

        if thisUser then
            function UnmutePlayer(user)
                local AudioDeviceInput = user:FindFirstChildOfClass("AudioDeviceInput")

                if AudioDeviceInput.Muted or AudioDeviceInput.Muted == true then
                    AudioDeviceInput.Muted = false
                end
            end
            wait()
            getgenv().shouldMute = false
            UnmutePlayer(thisUser)
            wait(0.2)
            getgenv().notify("Success", "Player has been unmuted", 5)
        end
    end,})

    getgenv().run_Shift_Speed = 50
    getgenv().walkSpeed = 16

    getgenv().ShifTToRunSpeed = Tab2:CreateInput({
    Name = "Shift_To_Run Speed",
    PlaceholderText = "Enter Speed",
    RemoveTextAfterFocusLost = true,
    Callback = function(get_speed)
        local speed = tonumber(get_speed)
        if speed then
            getgenv().run_Shift_Speed = speed
        else
            warn("Invalid speed input. Please enter a number.")
        end
    end,})

    getgenv().ShiftToRun = Tab2:CreateToggle({
    Name = "Shift To Run",
    CurrentValue = false,
    Flag = "SpeedCoilAlt",
    Callback = function(speedCoil)
        if speedCoil then
            getgenv().runningEnabled = true

            local function setupCharacter(character)
                local humanoid = character:WaitForChild("Humanoid") or character:FindFirstChild("Humanoid")

                local function onShiftPress(input, gameProcessed)
                    if input.KeyCode == Enum.KeyCode.LeftShift and not gameProcessed and getgenv().runningEnabled then
                        humanoid.WalkSpeed = getgenv().run_Shift_Speed
                    end
                end

                local function onShiftRelease(input, gameProcessed)
                    if input.KeyCode == Enum.KeyCode.LeftShift and not gameProcessed and getgenv().runningEnabled then
                        humanoid.WalkSpeed = getgenv().walkSpeed
                    end
                end

                getgenv().UserInputService.InputBegan:Connect(onShiftPress)
                getgenv().UserInputService.InputEnded:Connect(onShiftRelease)

                humanoid.WalkSpeed = getgenv().walkSpeed
            end

            game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
                setupCharacter(character)
            end)

            if getgenv().Character then
                setupCharacter(getgenv().Character)
            end
        else
            getgenv().runningEnabled = false
            if getgenv().Character then
                local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = getgenv().walkSpeed
                end
            end
        end
    end,})

    Zombie_Idle_1 = "10921344533"
    Zombie_Idle_2 = "10921345304"
    Zombie_Walk = "10921355261"
    Zombie_Run = "616163682"
    Zombie_Jump = "10921351278"
    Zombie_Climb = "10921343576"
    Zombie_Fall = "10921350320"
    Catwalk_Idle_1 = "133806214992291"
    Catwalk_Idle_2 = "94970088341563"
    Catwalk_Walk = "109168724482748"
    Catwalk_Run = "81024476153754"
    Catwalk_Jump = "116936326516985"
    Catwalk_Climb = "119377220967554"
    Catwalk_Fall = "92294537340807"
    Elder_Idle_1 = "10921101664"
    Elder_Idle_2 = "10921102574"
    Elder_Walk = "10921111375"
    Elder_Run = "10921104374"
    Elder_Jump = "10921107367"
    Elder_Climb = "10921100400"
    Elder_Fall = "10921105765"
    Cartoony_Idle_1 = "10921071918"
    Cartoony_Idle_2 = "10921072875"
    Cartoony_Walk = "10921082452"
    Cartoony_Run = "10921076136"
    Cartoony_Jump = "10921078135"
    Cartoony_Climb = "10921070953"
    Cartoony_Fall = "10921077030"
    Adidas_Idle_1 = "18537376492"
    Adidas_Idle_2 = "18537371272"
    Adidas_Walk = "18537392113"
    Adidas_Run = "18537384940"
    Adidas_Jump = "18537380791"
    Adidas_Climb = "18537363391"
    Adidas_Fall = "18537367238"
    Werewolf_Idle_1 = "10921330408"
    Werewolf_Idle_2 = "10921333667"
    Werewolf_Walk = "10921342074"
    Werewolf_Run = "10921336997"
    Werewolf_Jump = "1083218792"
    Werewolf_Climb = "10921329322"
    Werewolf_Fall = "10921337907"
    Vampire_Idle_1 = "10921315373"
    Vampire_Idle_2 = "10921316709"
    Vampire_Walk = "10921326949"
    Vampire_Run = "10921320299"
    Vampire_Jump = "10921322186"
    Vampire_Climb = "10921314188"
    Vampire_Fall = "10921321317"
    Astronaut_Idle_1 = "10921034824"
    Astronaut_Idle_2 = "10921036806"
    Astronaut_Walk = "10921046031"
    Astronaut_Run = "10921039308"
    Astronaut_Jump = "10921042494"
    Astronaut_Climb = "10921032124"
    Astronaut_Fall = "10921040576"
    Superhero_Idle_1 = "10921288909"
    Superhero_Idle_2 = "10921290167"
    Superhero_Walk = "10921298616"
    Superhero_Run = "10921291831"
    Superhero_Jump = "10921294559"
    Superhero_Climb = "10921286911"
    Superhero_Fall = "10921293373"
    Knight_Idle_1 = "10921117521"
    Knight_Idle_2 = "10921118894"
    Knight_Walk = "10921127095"
    Knight_Run = "10921121197"
    Knight_Jump = "10921123517"
    Knight_Climb = "10921116196"
    Knight_Fall = "10921122579"
    Mage_Idle_1 = "10921144709"
    Mage_Idle_2 = "10921145797"
    Mage_Walk = "10921152678"
    Mage_Run = "10921148209"
    Mage_Jump = "10921149743"
    Mage_Climb = "10921143404"
    Mage_Fall = "10921148939"
    Ninja_Idle_1 = "10921155160"
    Ninja_Idle_2 = "10921155867"
    Ninja_Walk = "10921162768"
    Ninja_Run = "10921157929"
    Ninja_Jump = "10921160088"
    Ninja_Climb = "10921154678"
    Ninja_Fall = "10921159222"
    Toy_Idle_1 = "10921301576"
    Toy_Idle_2 = "10921302207"
    Toy_Walk = "10921312010"
    Toy_Run = "10921306285"
    Toy_Jump = "10921308158"
    Toy_Climb = "10921300839"
    Toy_Fall = "10921307241"
    NFL_Idle_1 = "92080889861410"
    NFL_Idle_2 = "74451233229259"
    NFL_Walk = "110358958299415"
    NFL_Run = "117333533048078"
    NFL_Jump = "119846112151352"
    NFL_Climb = "134630013742019"
    NFL_Fall = "129773241321032"
    NoBoundaries_Idle_1 = "18747067405"
    NoBoundaries_Idle_2 = "18747063918"
    NoBoundaries_Walk = "18747074203"
    NoBoundaries_Run = "18747070484"
    NoBoundaries_Jump = "18747069148"
    NoBoundaries_Climb = "18747060903"
    NoBoundaries_Fall = "18747062535"
    Oldschool_Idle_1 = "10921230744"
    Oldschool_Idle_2 = "10921232093"
    Oldschool_Walk = "10921244891"
    Oldschool_Run = "10921240218"
    Oldschool_Jump = "10921242013"
    Oldschool_Climb = "10921229866"
    Oldschool_Fall = "10921241244"
    Pirate_Idle_1 = "750781874"
    Pirate_Idle_2 = "750782770"
    Pirate_Walk = "750785693"
    Pirate_Run = "750783738"
    Pirate_Jump = "750782230"
    Pirate_Climb = "750779899"
    Pirate_Fall = "750780242"
    Levitation_Idle_1 = "10921132962"
    Levitation_Idle_2 = "10921133721"
    Levitation_Walk = "10921140719"
    Levitation_Run = "10921135644"
    Levitation_Jump = "10921137402"
    Levitation_Climb = "10921132092"
    Levitation_Fall = "10921136539"
    Bubbly_Idle_1 = "10921054344"
    Bubbly_Idle_2 = "10921055107"
    Bubbly_Walk = "10980888364"
    Bubbly_Run = "10921057244"
    Bubbly_Jump = "10921062673"
    Bubbly_Climb = "10921053544"
    Bubbly_Fall = "10921061530"
    Robot_Idle_1 = "10921248039"
    Robot_Idle_2 = "10921248831"
    Robot_Walk = "10921255446"
    Robot_Run = "10921250460"
    Robot_Jump = "10921252123"
    Robot_Climb = "10921247141"
    Robot_Fall = "10921251156"
    WickedPopular_Idle_1 = "118832222982049"
    WickedPopular_Idle_2 = "76049494037641"
    WickedPopular_Walk = "92072849924640"
    WickedPopular_Run = "72301599441680"
    WickedPopular_Jump = "104325245285198"
    WickedPopular_Climb = "131326830509784"
    WickedPopular_Fall = "121152442762481"
    Bold_Idle_1 = "16738333868"
    Bold_Idle_2 = "16738334710"
    Bold_Walk = "16738340646"
    Bold_Run = "16738337225"
    Bold_Jump = "16738336650"
    Bold_Climb = "16738332169"
    Bold_Fall = "16738333171"
    Stylish_Idle_1 = "10921272275"
    Stylish_Idle_2 = "10921273958"
    Stylish_Walk = "10921283326"
    Stylish_Run = "10921276116"
    Stylish_Jump = "10921279832"
    Stylish_Climb = "10921271391"
    Stylish_Fall = "10921278648"
    Rthro_Idle_1 = "10921259953"
    Rthro_Idle_2 = "10921258489"
    Rthro_Walk = "10921269718"
    Rthro_Run = "10921261968"
    Rthro_Jump = "10921263860"
    Rthro_Climb = "10921257536"
    Rthro_Fall = "10921262864"

    if getgenv().Easies_Configuration["Custom_Animation_Package_System"] == "on" or getgenv().Easies_Configuration["Custom_Animation_Package_System"] == "On" or getgenv().Easies_Configuration["Custom_Animation_Package_System"] == "Enabled" then
        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

        local function findJumpAnimation()
            local animateScript = Character:FindFirstChild("Animate")
            if not animateScript or not animateScript:IsA("LocalScript") then
                return warn("Animate script not found in the Character.")
            end

            local jumpObject = animateScript:FindFirstChild("jump")
            if not jumpObject then
                return warn("Jump object not found in the Animate script.")
            end

            local jumpAnim = jumpObject:FindFirstChildOfClass("Animation")
            if jumpAnim and jumpAnim:IsA("Animation") then
                return jumpAnim
            else
                return warn("Jump Animation not found inside the 'jump' object.")
            end
        end

        local findJumpAnim = findJumpAnimation()
        wait(0.1)
        function run_anims()
            local player = game.Players.LocalPlayer
            if not player then return end

            local character = player.Character or player.CharacterAdded:Wait()
            local Animate = character and character:FindFirstChild("Animate") or character:WaitForChild("Animate", 1.5)

            if not Animate then return end

            Animate.Disabled = true
            wait(0.1)
            Animate.Disabled = false

            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end

            if getgenv().Easies_Configuration["Animation_Idle"] == "Zombie" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Zombie_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Zombie_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Catwalk Glam" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Catwalk_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Catwalk_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Elder" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Elder_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Elder_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Cartoony" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Cartoony_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Cartoony_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Adidas" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Adidas_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Adidas_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Werewolf" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Werewolf_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Werewolf_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Vampire" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Vampire_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Vampire_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Astronaut" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Astronaut_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Astronaut_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Superhero" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Superhero_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Superhero_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Knight" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Knight_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Knight_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Mage" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Mage_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Mage_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Ninja" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Ninja_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Ninja_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Toy" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Toy_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Toy_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "NFL" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..NFL_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..NFL_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "No Boundaries" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..NoBoundaries_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..NoBoundaries_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Oldschool" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Oldschool_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Oldschool_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Pirate" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Pirate_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Pirate_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Levitation" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Levitation_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Levitation_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Bubbly" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Bubbly_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Bubbly_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Robot" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Robot_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Robot_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Wicked Popular" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..WickedPopular_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..WickedPopular_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Bold" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Bold_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Bold_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Stylish" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Stylish_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Stylish_Idle_2
            elseif getgenv().Easies_Configuration["Animation_Idle"] == "Rthro" then
                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Idle_2
            end
            wait(0.1)
            if getgenv().Easies_Configuration["Animation_Walk"] == "Zombie" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Zombie_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Catwalk Glam" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Catwalk_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Elder" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Elder_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Cartoony" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Cartoony_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Adidas" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Adidas_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Werewolf" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Werewolf_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Vampire" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Vampire_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Astronaut" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Astronaut_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Superhero" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Superhero_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Knight" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Knight_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Mage" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Mage_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Ninja" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Ninja_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Toy" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Toy_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "NFL" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NFL_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "No Boundaries" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NoBoundaries_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Oldschool" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Oldschool_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Pirate" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Pirate_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Levitation" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Levitation_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Bubbly" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bubbly_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Robot" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Robot_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Wicked Popular" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..WickedPopular_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Bold" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bold_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Stylish" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Stylish_Walk
            elseif getgenv().Easies_Configuration["Animation_Walk"] == "Rthro" then
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Walk
            end
            wait(0.1)
            if getgenv().Easies_Configuration["Animation_Run"] == "Zombie" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Zombie_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Catwalk Glam" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Catwalk_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Elder" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Elder_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Cartoony" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Cartoony_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Adidas" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Adidas_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Werewolf" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Werewolf_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Vampire" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Vampire_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Astronaut" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Astronaut_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Superhero" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Superhero_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Knight" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Knight_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Mage" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Mage_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Ninja" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Ninja_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Toy" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Toy_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "NFL" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NFL_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "No Boundaries" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NoBoundaries_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Oldschool" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Oldschool_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Pirate" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Pirate_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Levitation" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Levitation_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Bubbly" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bubbly_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Robot" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Robot_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Wicked Popular" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..WickedPopular_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Bold" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bold_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Stylish" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Stylish_Run
            elseif getgenv().Easies_Configuration["Animation_Run"] == "Rthro" then
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Run
            end
            wait(0.1)
            if getgenv().Easies_Configuration["Animation_Jump"] == "Zombie" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Zombie_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Catwalk Glam" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Catwalk_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Elder" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Elder_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Cartoony" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Cartoony_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Adidas" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Adidas_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Werewolf" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Werewolf_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Vampire" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Vampire_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Astronaut" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Astronaut_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Superhero" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Superhero_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Knight" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Knight_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Mage" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Mage_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Ninja" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Ninja_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Toy" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Toy_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "NFL" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NFL_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "No Boundaries" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NoBoundaries_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Oldschool" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Oldschool_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Pirate" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Pirate_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Levitation" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Levitation_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Bubbly" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bubbly_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Robot" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Robot_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Wicked Popular" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..WickedPopular_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Bold" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bold_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Stylish" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Stylish_Jump
            elseif getgenv().Easies_Configuration["Animation_Jump"] == "Rthro" then
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Jump
            end
            wait(0.1)
            if getgenv().Easies_Configuration["Animation_Fall"] == "Zombie" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Zombie_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Catwalk Glam" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Catwalk_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Elder" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Elder_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Cartoony" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Cartoony_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Adidas" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Adidas_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Werewolf" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Werewolf_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Vampire" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Vampire_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Astronaut" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Astronaut_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Superhero" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Superhero_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Knight" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Knight_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Mage" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Mage_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Ninja" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Ninja_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Toy" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Toy_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "NFL" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NFL_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "No Boundaries" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NoBoundaries_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Oldschool" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Oldschool_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Pirate" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Pirate_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Levitation" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Levitation_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Bubbly" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bubbly_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Robot" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Robot_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Wicked Popular" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..WickedPopular_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Bold" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bold_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Stylish" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Stylish_Fall
            elseif getgenv().Easies_Configuration["Animation_Fall"] == "Rthro" then
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Fall
            end
            wait(0.1)
            if getgenv().Easies_Configuration["Animation_Climb"] == "Zombie" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Zombie_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Catwalk Glam" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Catwalk_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Elder" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Elder_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Cartoony" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Cartoony_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Adidas" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Adidas_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Werewolf" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Werewolf_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Vampire" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Vampire_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Astronaut" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Astronaut_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Superhero" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Superhero_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Knight" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Knight_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Mage" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Mage_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Ninja" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Ninja_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Toy" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Toy_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "NFL" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NFL_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "No Boundaries" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..NoBoundaries_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Oldschool" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Oldschool_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Pirate" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Pirate_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Levitation" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Levitation_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Bubbly" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bubbly_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Robot" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Robot_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Wicked Popular" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..WickedPopular_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Bold" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Bold_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Stylish" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Stylish_Climb
            elseif getgenv().Easies_Configuration["Animation_Climb"] == "Rthro" then
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Climb
            end
            wait(0.2)
            if humanoid then
                humanoid:ChangeState(3)
            end
        end
        wait(0.1)
        getgenv().ownerAnimsLoaded = false
        getgenv().ownerAnimsEnabled = true
        wait(0.2)
        function do_anims_func()
            if not getgenv().ownerAnimsEnabled then
                return warn("Owner-Animations are disabled.")
            end

            local player = game.Players.LocalPlayer
            if not player then
                return warn("Player was not found at runtime.")
            end

            player.CharacterAdded:Connect(run_anims)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                run_anims()
            end
        end

        if getgenv().ownerAnimsLoaded then
            warn("Owner-Animations already loaded!")
        elseif not getgenv().ownerAnimsLoaded then
            if typeof(do_anims_func) == "function" then
                do_anims_func()
                getgenv().ownerAnimsLoaded = true
            else
                warn("Error: Animation function is missing!")
            end
        else
            warn("Owner-Animation Packages not loaded, error.")
        end
    else
        warn("Not enabled in Configuration.")
    end
    wait(0.2)
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=109168724482748"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=81024476153754"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=116936326516985"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=119377220967554"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=92294537340807"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=92072849924640"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=72301599441680"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=104325245285198"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=131326830509784"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=121152442762481"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537392113"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537384940"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537380791"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537363391"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537367238"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=110358958299415"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=117333533048078"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=119846112151352"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=134630013742019"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=129773241321032"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738340646"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738337225"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738336650"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738332169"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738333171"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747074203"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747070484"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747069148"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747060903"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747062535"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921255446"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921250460"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921252123"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921247141"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921251156"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616168032"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616163682"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616161997"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616156119"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616157476"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616122287"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616117076"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616115533"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616104706"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616108001"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083473930"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083462077"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083455352"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083439238"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083443587"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707897309"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707861613"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707853694"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707826056"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707829716"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616010382"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616013216"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616008936"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616003713"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616005863"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845403856"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845386501"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845398858"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845392038"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845396048"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616013216"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616010382"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616008936"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616003713"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616005863"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891667138"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891636393"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891627522"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891609353"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891617961"
        wait()
        Animate.Disabled = false
    end)

    create_Button(NinjaAnim, "Ninja Animation Package", function()
        local Animate = getgenv().LocalPlayer.Character.Animate
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656121766"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656118852"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656117878"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656114359"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656115606"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083178339"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083216690"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083218792"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083182000"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083189019"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742640026"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742638842"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742637942"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742636889"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742637151"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750785693"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750783738"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750782230"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750779899"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750780242"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132510133"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132494274"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132489853"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132461372"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132469004"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782843345"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782842708"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782847020"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782843869"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782846423"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=657552124"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=657564596"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=658409194"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=658360781"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=657600338"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1070017263"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1070001516"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1069984524"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1069946257"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1069973677"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212980338"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212980348"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212954642"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1213044953"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212900995"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941028902"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941015281"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941008832"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=940996062"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941000007"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014421541"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014401683"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014394726"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014380606"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014384571"
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
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1151231493"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1150967949"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1150944216"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1148811837"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1148863382"
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
        Animate.idle:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=3489171152"
        Animate.idle:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=3489171152"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=3489174223"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=3489173414"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616161997"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616156119"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616157476"
        wait()
        Animate.Disabled = false
    end)

    getgenv().SystemBroken = Tab5:CreateButton({
    Name = "System Broken",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/main/source"))()
    end,})

    local Trip_Settings = {
        Keybind_Trip = Enum.KeyCode.V,
        Keybind_FakeOut = Enum.KeyCode.R
    }
    wait(0.2)
    -- Might include later for easier access, who knows.
    --getgenv().Current_Trip_Configuration = Tripping_Settings
    wait()
    getgenv().Trip_Keybind = Tab15:CreateKeybind({ 
    Name = "Trip Keybind",
    CurrentKeybind = tostring("V"),
    HoldToInteract = false,
    Flag = "TrippingOverKeybind",
    Callback = function(KeyForTripping)
        if type(KeyForTripping) == "string" and Enum.KeyCode[KeyForTripping] then
            Trip_Settings.Keybind_Trip = Enum.KeyCode[KeyForTripping]
        end
    end,})

    getgenv().FakeOut_Keybind = Tab15:CreateKeybind({
    Name = "Fake Out Keybind",
    CurrentKeybind = tostring("R"),
    HoldToInteract = false,
    Flag = "FakingOutKeybind",
    Callback = function(setKeyForFakeOut)
        if type(setKeyForFakeOut) == "string" and Enum.KeyCode[setKeyForFakeOut] then
            Trip_Settings.Keybind_FakeOut = Enum.KeyCode[setKeyForFakeOut]
        end
    end,})

    getgenv().Trip_Script = Tab15:CreateToggle({
    Name = "Trip",
    CurrentValue = false,
    Flag = "TogglingTrippingFallScript",
    Callback = function(isTripOn)
        if isTripOn then
            local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
            local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
            local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")

            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Character:FindFirstChild("HumanoidRootPart")

            getgenv().Trip_Enabled = true

            local function trip()
                local hum = getgenv().Humanoid
                local root = getgenv().HumanoidRootPart
                hum:ChangeState(0)
                root.Velocity = root.CFrame.LookVector * 30
                wait(3)
                hum:ChangeState(2)
            end

            getgenv().Trip_Connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end

                local keybind = Trip_Settings.Keybind_Trip
            
                if input.KeyCode == keybind then
                    trip()
                end
            end)
        else
            if getgenv().Trip_Connection then
                getgenv().Trip_Connection:Disconnect()
                getgenv().Trip_Connection = nil
            end
            wait()
            getgenv().Trip_Enabled = false
            wait(0.3)
            getgenv().notify("Success", "Successfully disabled Trip Connection.", 5)
        end
    end,})

    getgenv().FakeOutScript = Tab15:CreateToggle({
    Name = "Fake Out",
    CurrentValue = false,
    Flag = "ToggleAbilityFakeOut",
    Callback = function(isFakeOutEnabled)
        if isFakeOutEnabled then
            local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
            local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
            local UserInputService = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")

            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local RootPart = Character:FindFirstChild("HumanoidRootPart")

            getgenv().FakeOut_Enabled = true
            wait(0.1)
            if getgenv().fake_out then
                getgenv().notify("Passed", "Function 'fake_out' already exists.", 5)
            else
                getgenv().fake_out = function()
                    wait(0.4)
                    OrgDestroyHeight = workspace.FallenPartsDestroyHeight
                    wait(0.1)
                    local root = getgenv().HumanoidRootPart
                    local oldpos = root.CFrame
                    workspace.FallenPartsDestroyHeight = 0/1/0
                    root.CFrame = CFrame.new(Vector3.new(0, OrgDestroyHeight - 25, 0))
                    wait(1.3)
                    root.CFrame = oldpos
                    workspace.FallenPartsDestroyHeight = OrgDestroyHeight
                end
            end

            getgenv().FakeOut_Connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end

                local keybind = Trip_Settings.Keybind_FakeOut
                
                if input.KeyCode == keybind then
                    getgenv().fake_out()
                end
            end)
        else
            if getgenv().FakeOut_Connection then
                getgenv().FakeOut_Connection:Disconnect()
                getgenv().FakeOut_Connection = nil
            end
            wait(0.1)
            getgenv().FakeOut_Enabled = false
            wait(0.3)
            getgenv().notify("Success", "Successfully disabled Fake Out Connection.", 5)
        end
    end,})

    getgenv().Reset_ClockTime_GUI = Tab15:CreateButton({
    Name = "Disable Script Clock Time GUI",
    Callback = function()
        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
        local Lighting = cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 0.5)
        local Find_Script_Clock_GUI = PlayerGui:FindFirstChild("Script_Clock_Time_Day_Night")

        if Find_Script_Clock_GUI then
            Find_Script_Clock_GUI:Destroy()
            wait()
            getgenv().clock_script_time = false
            wait()
            getgenv().times_enabled_clock = false
            wait()
            Lighting.ClockTime = 14
            Lighting.Brightness = 3
        else
            return getgenv().notify("Error:", "Script Clock Time GUI not loaded", 6)
        end
    end,})

    if getgenv().camera_zoom_data then
        print("CameraMaxZoomDistance - Data | True")
    else
        getgenv().LocalPlayer.CameraMaxZoomDistance = 800000
        getgenv().camera_zoom_data = true
    end
    wait(0.2)
    print("Getting Requirements... [1 moment.]")
    wait(0.3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/PrivateBecauseYes/refs/heads/main/armsConvert.js", true))()
    wait(0.4)
    if getgenv().Has_Died_Func then
        warn("Already setup death function.")
    else
        if getgenv().Easies_Configuration["Death_On_Load"] == "on" or getgenv().Easies_Configuration["Death_On_Load"] == "On" or getgenv().Easies_Configuration["Death_On_Load"] == "Enabled" then
            getgenv().Humanoid.Health = 0
            getgenv().Has_Died_Func = true
            wait(0.1)
            print("Died Func setup")
        else
            warn("Not enabled in Configuration.")
        end
    end
    wait(0.2)
    if getgenv().SimpleSpyExecuted then
        getgenv().SimpleSpyShutdown()
    else
        warn("SneakySpy is not running!")
    end
    if getgenv().performance_stats then
        warn("Performance stats checked.")
    else
        if getgenv().Easies_Configuration["Performance_Statistics"] == "on" or getgenv().Easies_Configuration["Performance_Statistics"] == "On" or getgenv().Easies_Configuration["Performance_Statistics"] == "Enabled" then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/OrionLibraryReWrittenCelery/refs/heads/main/grab_file_performance"))()
            wait(0.2)
            getgenv().StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
            wait(0.2)
            if getgenv().StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Health) then
                print("Health CoreGuiType.Enabled: True")
            else
                warn("Health CoreGuiType.Enabled: False")
            end
            wait(0.1)
            getgenv().performance_stats = true
        else
            warn("Not enabled in Configuration.")
        end
    end
    wait(0.3)
    if getgenv().fully_loaded_message_script then
        warn("Already loaded fully loaded message.")
    else
        if getgenv().Easies_Configuration["Fully_Loaded_Messaging"] == "on" or getgenv().Easies_Configuration["Fully_Loaded_Messaging"] == "On" or getgenv().Easies_Configuration["Fully_Loaded_Messaging"] == "Enabled" then
            getgenv().sending_async(tostring(getgenv().Easies_Configuration["Fully_Loaded_Message"]))
            getgenv().fully_loaded_message_script = true
        end
    end
