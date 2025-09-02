    -- THIS PROJECT ISN'T MANAGED ANYMORE, I QUIT SINCE THEN! This project was to much to handle and I don't want to have my life interrupted by thousands of users looking for support all day everyday, interrupts my real life ultimately.
    -- There wasn't any updates before I quit, and someone tried to "expose me", which didn't go well for them lmao, why would it? also, they wouldn't have they're script hub (which just IP logs, and hardware logs, and they work with RATTERS), sooo..
    -- People claim this was wrote with ChatGPT, if you believe it was wrote with ChatGPT go test it, but it's 13K lines of code, why would any of this junk be wrote with ChatGPT?
    -- This code is VERY unorganized and garbage, I don't know what the FUCK I was doing with this code, but I must have been high when writing it, but I am NOT re-writing any of this code, fuck that shit.
    -- Enjoy it anyway, I never actually cared for the script, but I did write it so, and it's sort of stable, barely has any issues, and supports every executor, so I guess it worked out somewhat.
    -- I might fix the code up, but I haven't worked on this shit in a while so, I'm not sure.
    -- Also, any other script hub with Booth features, just skidded mine, this script came out before ANY of the other scripts, this script actually REALISTICALLY released all the way back in March of 2024.
    -- Because I see a lot of scripts and script hubs that have these Booth features, and sure enough, they are obfuscated, and seem to work JUST how mine work, that's fucking suspicious, don't you think?
    -- I wrote this script myself, and I don't plan on utilizing ChatGPT, why would I? scripting in Roblox is fairly easy, and doesn't take much skill, unlike languages like C# that might take a bit more time to learn or JavaScript, or even Java.
    -- I plan to release an API sort of script soon, which will allow you to have anticheat bypasses and stuff and secure services and shit but with 1 singular Loadstring, and ESP and what not to.
    -- Stay tuned, even though I quit doing all of this bullshit.
    
    -- Do you even fuckin need this? no you don't.
    --[[
        Animation Packages: Zombie, Catwalk Glam, Elder, Cartoony, Adidas,
        Adidas Community Package, Werewolf, Vampire, Astronaut,
        Superhero, Knight, Mage, Ninja,
        Toy, NFL, No Boundaries, Oldschool,
        Pirate, Levitation, Bubbly, Robot,
        Wicked Popular, Bold, Stylish,
        Rthro [default Roblox Animation package]
    --]]
    wait(1) -- Believe it or not, this actually helps when loading the script, stops people from spamming it, so it can load correctly and smoothly.
    print("1")
    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"} -- Alternates to "Unknown Executor" if the name isn't found, the only reason I kept this was because people on executors like JJSploit, or Zorara, we're having some issues in the beginning, and it would produce string errors, but this fixed it, and I kept it ever since, long time ago.
    end

    local function detectExecutor() -- Really cool function, does the hard work for us, erases the version part of the executors name so we can ACTUALLY match the name and make support for all different types of things.
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    wait()
    local Module = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/zacks_easy_module.lua'))()
    local Version = Module:Get_Current_Version()
    wait(0.1)
    local Script_Version = Version
    local executor_Name = detectExecutor()
    wait(0.1)
    print("2") -- And throughout the beginning of the script there might be these random print statements, don't mind them, it's just my way of debugging, like if something doesn't load, then I'll count my steps back and see where it stopped loading at or what not.
    wait(0.2)
    -- Because I mean, sometimes the errors don't exactly show where the issue is, so print statements everywhere helps identify where the issue is located at or around what area.
    local vc_service = cloneref and cloneref(game:GetService("VoiceChatService")) or game:GetService("VoiceChatService") -- This wasn't exactly necessary, but I decided to leave it in to keep safety a priority.
    local enabled_vc = vc_service:IsVoiceEnabledForUserIdAsync(game.Players.LocalPlayer.UserId) -- This was to make sure users know if they have VoiceChat, because apparently some of them miss that part of Roblox.
    local Notification
    wait(0.3)
    -- This is a decent Notification Library, as it includes features such as: 'Warnings', 'Errors', and other useful functions.
    httprequest_loader = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

    local response = httprequest_loader({
        Url = "https://raw.githubusercontent.com/laagginq/ui-libraries/main/dxhooknotify/src.lua",
        Method = "GET"
    })
    -- Before you ask, yes, this works for every executor, and it is really good for when you don't want to use Loadstring ;) plus it's fully internal, and I guarantee it bypasses most anticheats to ;)
    -- Definitely doesn't bypass Football Fusion or popular anticheats or anything, that'd be wrong of me to publicly release a bypass for loading UI libraries and scripts fully internally and bypassed.
    -- You get what I'm saying, now go fuck off and skid it.

    getgenv().SCRIPT_EXECUTED = getgenv().SCRIPT_EXECUTED or false
    getgenv().All_TheWay_Loaded_FLAMES_HUB_GETGENV_VALUE = getgenv().All_TheWay_Loaded_FLAMES_HUB_GETGENV_VALUE or false

    if (getgenv().SCRIPT_EXECUTED == true) and (getgenv().All_TheWay_Loaded_FLAMES_HUB_GETGENV_VALUE == false) then
        if not getgenv().notify then
            getgenv().notify = function(title, content, duration)
                local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
                StarterGui:SetCore("SendNotification", {
                    Title = tostring(title),
                    Text = tostring(content),
                    Duration = tonumber(duration),
                    Icon = "rbxassetid://0"
                })
            end
        end

        getgenv().notify("CRITICAL:", "Flames Hub seems to have failed to load last time, re-running...", 5)
        task.wait(0.2)
        getgenv().notify("Alert:", "If Flames Hub does not fix itself, it's probably down!", 5)

        task.wait(0.1)
        getgenv().SCRIPT_EXECUTED = false
        task.wait(0.3)

        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua"))()
    end
    wait(0.2)
    if response and response.StatusCode == 200 then
        Notification = loadstring(response.Body)()
        -- This is actually believe it or not a very neat system, I'll tell you why, when utilizing Loadstring, some people execute HTTP loggers/HTTP spies, and when utilizing this, you can put in an anti HTTP Loadstring loader, and this'll still work like normal, go test it.
    else
        print("Failed to fetch script:", response.StatusCode)
    end
    -- [] -->> Make sure the script it's self does not get executed more then once, when executed, they will need to click the Re-Execute GUI button to restart the script. <<-- [] --
    if SCRIPT_EXECUTED or getgenv().SCRIPT_EXECUTED and not _G.SCRIPT_EXECUTED == true then  
        return Notification:Notify("Heads Up!", "Flames Hub is already running!", 5)
    end

    pcall(function() getgenv().SCRIPT_EXECUTED = true end)
    -- Sometimes would fuck up, but that's because I accidentally removed the "not _G.SCRIPT_EXECUTED == true" part, didn't know it was necessary, so oops.
    wait(0.3)
    print("3")
    if enabled_vc == true then -- This just retrieves that response you get when you called "IsVoiceEnabledForUserIdAsync(game.Players.LocalPlayer.UserId)", even though I don't know why I have to match it to a Boolean, but ok.
        Notification:Notify("Success!", "Connected with VC successfully!", 3)
    elseif (enabled_vc == false and (not game.PlaceId == 6884319169)) or (not game.PlaceId == 15546218972) then
        Notification:Notify("Success!", "Connected.", 5)
    elseif enabled_vc == false and game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        return Notification:Notify("Sorry!", "Unable to load Flames Hub (No VC)", 5)
    else
        Notification:Notify("Passed.", "Unknown error occurred.", 5) -- I actually have no idea when or why I added this, but I guess I kept it, so it might be necessary, I don't know man.
    end
    wait()
    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")
    -- And these are necessary since we haven't even loaded the "getgenv()" services yet, so keep these as cloneref, because believe it or not, some shitty sploits don't support "cloneref", it's retarded.
    print("4")
    local watchedPlayers = {"L0CKED_1N1", "CHEATING_B0SS"}
    local specialPlayer = "alt_acc9996"
    local all_beta_testers = {"Chick7nn", "LIL_RT228", "CrimGameHolder"}
    -- Only whitelisted people allowed here, and if you want to I guess you can put your own names, I mean go ahead.

    local function isWatchedPlayer(playerName)
        for _, name in ipairs(watchedPlayers) do
            if playerName == name then
                return true -- Same here with what I said below.
            end
        end
        return false
    end
    print("5")

    function low_level_executor()
        if executor_Name == "Solara" or string.find(executor_Name, "JJSploit") or executor_Name == "Xeno" then
            warn("Failure:", "This feature isn't supported on this executor.")
            return false
        else
            return true
        end
    end

    local low_level_executor_result = low_level_executor()

    local function beta_tester(player)
        for _, name in ipairs(all_beta_testers) do
            if player == name then
                return true -- Never really cared about these, but I figured I don't have another way of doing this stupid shitty system better, so I kept this shit.
            end
        end
        return false
    end

    print("6")
    wait()
    print("7")
    wait()
    local function make_title(player, text, color, transparency)
        -- This matches the color for the Title because of how the colors on Billboards work, so I decided to make a check for it instead, I'm not trying to set that shit up manually otherwise.
        local function applyToCharacter(character)
            task.wait(0.5)
            if color == Color3.fromRGB(255, 255, 255) then
                local head = character:FindFirstChild("Head")
                if not head then return warn("Head does not exist!") end
                if head:FindFirstChild("FlamesHubBillboard") then return end

                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "FlamesHubBillboard"
                billboardGui.Size = UDim2.new(10, 0, 1.5, 0)
                billboardGui.MaxDistance = math.huge
                billboardGui.LightInfluence = 0
                billboardGui.StudsOffset = Vector3.new(0, 3, 0)
                billboardGui.AlwaysOnTop = true
                billboardGui.Parent = head

                local background = Instance.new("Frame")
                background.Size = UDim2.new(1, 0, 1, 0)
                background.BackgroundTransparency = transparency
                background.BackgroundColor3 = color
                background.BorderSizePixel = 0
                background.Parent = billboardGui

                local uiCorner = Instance.new("UICorner")
                uiCorner.CornerRadius = UDim.new(0.3, 0)
                uiCorner.Parent = background

                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, -10, 1, -10)
                textLabel.Position = UDim2.new(0, 5, 0, 5)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.GothamBold
                textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                textLabel.Text = text -- If you change this, it won't do anything since it's in the function, and the function is called below when matching the names.
                textLabel.Parent = background
            else
                local head = character:FindFirstChild("Head")
                if head:FindFirstChild("FlamesHubBillboard") then return end

                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "FlamesHubBillboard"
                billboardGui.Size = UDim2.new(10, 0, 1.5, 0)
                billboardGui.MaxDistance = math.huge
                billboardGui.LightInfluence = 0
                billboardGui.StudsOffset = Vector3.new(0, 3, 0)
                billboardGui.AlwaysOnTop = true
                billboardGui.Parent = head

                local background = Instance.new("Frame")
                background.Size = UDim2.new(1, 0, 1, 0)
                background.BackgroundTransparency = transparency
                background.BackgroundColor3 = color
                background.BorderSizePixel = 0
                background.Parent = billboardGui

                local uiCorner = Instance.new("UICorner")
                uiCorner.CornerRadius = UDim.new(0.3, 0)
                uiCorner.Parent = background

                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, -10, 1, -10)
                textLabel.Position = UDim2.new(0, 5, 0, 5)
                textLabel.BackgroundTransparency = 1
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.GothamBold
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                textLabel.Text = text -- Don't change this shit, it won't update, modify it below.
                textLabel.Parent = background
            end
        end

        if player.Character and player.Character:FindFirstChild("Humanoid") then
            applyToCharacter(player.Character) -- And keep this otherwise, when you respawn, it'll bug out completely, I forgot to add it before, and that's where I fucked up.
        end
        print("8")
        player.CharacterAdded:Connect(applyToCharacter)
    end

    local function assign(player)
        -- If you want a Title, update it below, I and the people below don't really play MIC UP or any game anymore, so you can do what ever you want with it lol.
        if isWatchedPlayer(player.Name) then
            make_title(player, "👑 Flames Hub | KING 👑", Color3.fromRGB(196, 40, 28), 0)
        elseif beta_tester(player.Name) then
            make_title(player, "✨ Flames Hub | BETA-PLAYER ✨", Color3.fromRGB(0, 0, 0), 0.1)
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        assign(player)
    end

    Players.PlayerAdded:Connect(function(player)
        task.wait(1) -- Roblox sucks for making us do this bullshit, if you don't have this, the player's Character seems to just fucking disappear and apparently in Roblox's eyes, never loaded.
        -- Like the fuck?
        assign(player)
    end)
    wait()
    print("9")
    wait(0.3)
    -- These down here are actually quite useful as it also preserves a lot of room to, since defining local variables usually should stay inside the function, because the main gui wrapper, is inside a function, these can be used outside of the function as well.
    getgenv().Game = game
    getgenv().JobID = getgenv().Game.JobId
    getgenv().PlaceID = getgenv().Game.PlaceId

    -- And you can also use this anywhere, even outside of the script, while having the script running, you can do like "getgenv().Service_Wrap("Workspace")", and it should work.
    -- You can do like: "local Workspace = getgenv().Service_Wrap("Workspace")" and it should work normally.
    getgenv().Service_Wrap = function(serviceName)
        if cloneref then
            return cloneref(getgenv().Game:GetService(serviceName))
        else
            return getgenv().Game:GetService(serviceName)
        end
    end

    print("10")

    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function executor_details()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    print("11")
    wait()
    local executor_Name = executor_details()

    getgenv().print_executor = function()
        local function retrieve_executor()
            local name
            if identifyexecutor then
                name = identifyexecutor()
            end
            return { Name = name or "Unknown Executor"}
        end
    
        local function identify_executor()
            local executorDetails = retrieve_executor()
            return string.format("%s", executorDetails.Name)
        end
        wait(0.1)
        local executor_string = identify_executor()

        return print(executor_string)
    end

    print("12")

    function randomString()
        local length = math.random(10,20)
        local array = {}
        for i = 1, length do
            array[i] = string.char(math.random(32, 126))
        end
        return table.concat(array)
    end

    getgenv().randomString = function()
        local length = math.random(10,20)
        local array = {}
        for i = 1, length do
            array[i] = string.char(math.random(32, 126))
        end
        return table.concat(array)
    end

    print("13")

    -- These below this line are being wrapped in the function above (as you can see), essentially making them useful anywhere in the script, local variables but quite more advanced.
    getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    getgenv().httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    -- Don't mind this, I don't actually use this, but it's to make sure 'getgenv().httprequest_Init' can be defined outside and inside the script, since I'm not exactly sure about these types of local variables (non-service local variables).
    get_http = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    getgenv().queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    queueteleport = getgenv().queueteleport

    local Flames_API = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua'))()
    wait(0.1)
    print("14")

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
            "ContextActionService",
            "GuiService",
            "PhysicsService"
        }
        -- I do use all of these by the way, people said it's ChatGPT, but I use all of these, these are all in use, this is a huge script, go check it.
        -- The only one I probably don't use is ReplicatedFirst, but I most likely do.
        -- Or maybe it's Teams, but other then that, I use all of these, like ContextActionService, it's for the Free Emotes GUI.

        for _, serviceName in pairs(services) do
            -- And this is just for putting the services into a "getgenv()" global variable, so it can be used anywhere in the script, and outside of the script to.
            getgenv()[serviceName] = cloneref and cloneref(getgenv().Game:GetService(serviceName)) or getgenv().Game:GetService(serviceName)
        end
    end
    wait()
    print("15")
    wait()
    init_services()
    wait(0.2)
    -- I use all of these to, check my script, these come in handy, because like I stated before, they can be used outside of the script.
    if not getgenv().Players then
        warn("getgenv().Players was not detected, fixing...")
        getgenv().Players = getgenv().Service_Wrap("Players")
    end
    if not getgenv().ReplicatedStorage then
        warn("getgenv().ReplicatedStorage was not detected, fixing...")
        getgenv().ReplicatedStorage = getgenv().Service_Wrap("ReplicatedStorage")
    end
    if not getgenv().TextChatService then
        warn("getgenv().TextChatService was not detected, fixing...")
        getgenv().TextChatService = getgenv().Service_Wrap("TextChatService")
    end
    if not getgenv().Workspace then
        warn("getgenv().Workspace was not detected, fixing...")
        getgenv().Workspace = getgenv().Service_Wrap("Workspace")
    end
    if not getgenv().Lighting then
        warn("getgenv().Lighting was not detected, fixing...")
        getgenv().Lighting = getgenv().Service_Wrap("Lighting")
    end

    local Use_Jump_Power = false

    task.wait(0.2)
    getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
    getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
    getgenv().LocalPlayer = Flames_API.LocalPlayer
    getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
    getgenv().PlayerGui = Flames_API.PlayerGui
    getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
    getgenv().Character = Flames_API.Character
    getgenv().HumanoidRootPart = Flames_API.HumanoidRootPart
    getgenv().Humanoid = Flames_API.Humanoid
    getgenv().Head = Flames_API.Head
    wait(0.2)
    local function Dynamic_Character_Updater(character)
        getgenv().Character = character or getgenv().LocalPlayer.Character
        task.wait(0.3)
        local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3)
        getgenv().HumanoidRootPart = (hrp and hrp:IsA("BasePart")) and hrp

        local hum = character:FindFirstChildOfClass("Humanoid")
        getgenv().Humanoid = (hum and hum:IsA("Humanoid")) and hum

        local head = character:FindFirstChild("Head")
        getgenv().Head = (head and head:IsA("BasePart")) and head
    end

    Dynamic_Character_Updater(getgenv().Character)
    task.wait(0.2)
    getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        task.wait(0.5)
        warn("[Flames Hub]: New Character added, pre-fetching and initializing.")
        Dynamic_Character_Updater(newCharacter)
        getgenv().LocalPlayer.CharacterAdded:Wait()
        task.wait(0.5)
        getgenv().Character = newCharacter
        getgenv().HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
        getgenv().Humanoid = newCharacter:FindFirstChild("Humanoid") or newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
        getgenv().Head = newCharacter:FindFirstChild("Head") or newCharacter:WaitForChild("Head", 5)
    end)

    if getgenv().advanced_workaround_method == false and getmetatable and setmetatable and hookmetamethod and hookfunction then
        print("Advanced exploit detected, using bypass method.")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/ParadiseRPScript/refs/heads/main/quick_workaround_rspy.lua'))()
        wait(0.1)
        getgenv().advanced_workaround_method = true
    elseif not (getmetatable or setmetatable or hookmetamethod or hookfunction) then
        wait(0.1)
        getgenv().advanced_workaround_method = true
        warn("No advanced level exploit detected, skipping..")
    elseif getgenv().advanced_workaround_method == true then
        wait(0.1)
        warn("Advanced level exploit already reviewed and secured.")
    end

    local vc_inter = getgenv().VoiceChatInternal
    local vc_service = getgenv().VoiceChatService

    if getgenv().voicechat_check then
        warn("Voice Chat already initialized.")
    else
        local reconnecting = false
        local retry_dur = 3

        local function unsuspend()
            if reconnecting then return warn("STILL TRYING TO RECONNECT TO VC! WAITING!") end
            reconnecting = true

            task.wait(2)
            pcall(function()
                vc_inter:JoinByGroupIdToken("", false, true)
                vc_inter:Leave()
                task.wait(0.2)
                vc_service:rejoinVoice()
                vc_service:rejoinVoice()
                task.wait(0.1)
                vc_service:joinVoice()
            end)

            reconnecting = false
        end

        vc_inter.LocalPlayerModerated:Connect(unsuspend)

        vc_inter.StateChanged:Connect(function(_, newState)
            if newState == Enum.VoiceChatState.Ended and not reconnecting then
                task.wait(retry_dur)
                unsuspend()
            end
        end)

        getgenv().voicechat_check = true
    end
    wait(0.2)
    -- [] -->> Correctly allocate Character's HumanoidRootPart | Essentially correctly loading the BasePart of the Character [Thanks: Infinite Yield] <<-- [] --
    function getRoot(char)
        rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
        return rootPart
    end
    wait(0.2)
    getgenv().getRoot = getRoot
    wait()
    -- [] -->> Check supported functions in the current executor, that are necessary for the script. <<-- [] --
    if getgenv().has_checked_funcs then
        print("Functions Checking | True") 
    else
        getgenv().checkNecessaryFunctions = function(function_checked)
            if function_checked then
                print("[Flames_Hub::OUTPUT_HOOKED]: "..tostring(function_checked).." ||| Success ✅")
            elseif not function_checked or function_checked == nil then
                warn("[Flames_Hub::OUTPUT_HOOKED]: "..tostring(function_checked).." ||| Failure ❌")
            else
                warn("[Flames_Hub::OUTPUT_HOOKED]: "..tostring(function_checked).." ||| Unknown ❓")
            end
        end

        getgenv().otherFuncCheck = function(function_checked)
            if function_checked then
                return true
            elseif not function_checked or function_checked == nil then
                return false
            else
                return nil
            end
        end

        local GC = getconnections or get_signal_cons
        local Other_Check = Drawing

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
        getgenv().checkNecessaryFunctions(Other_Check)
        wait()
        getgenv().checkNecessaryFunctions(getgenv().AllClipboards)
        wait(0.1)
        getgenv().has_checked_funcs = true
    end
    wait(0.1)
    -- Correctly initialize our Folder we put into Workspace, since we can use this for later in the script as well.
    if getgenv().Workspace:FindFirstChild("PartStorage") then
        print("Already found Folder")
    else
        local NewFolder = Instance.new("Folder")
        NewFolder.Name = "PartStorage"
        NewFolder.Parent = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
    end
    wait(0.2)
    -- Check our BasePlate, to correctly initialize an anti-void measure, which stretches extremely far.
    if getgenv().passed_baseplate_check then
        warn("Already loaded BasePlate check.")
    else
        function do_baseplate_check()
            local Workspace = getgenv().Workspace
            local TerrainFolder = Workspace:FindFirstChild("TERRAIN_EDITOR") or Instance.new("Folder", Workspace)
            TerrainFolder.Name = "TERRAIN_EDITOR"
            
            local position = Vector3.new(66, -10, 72.5)
            local size = Vector3.new(20000, 20, 20000)
            local maxPartSize = 2048
            local material = Enum.Material.Asphalt
            local color = Color3.fromRGB(50, 50, 50)
            local transparency = 0
            
            local function createPart(pos, partSize)
                local part = Instance.new("Part")
                part.Size = partSize
                part.Position = pos
                part.Anchored = true
                part.Material = material
                part.Color = color
                part.Transparency = transparency
                part.Parent = TerrainFolder
                return part
            end
            
            if size.X > maxPartSize or size.Z > maxPartSize then
                local divisionsX = math.ceil(size.X / maxPartSize)
                local divisionsZ = math.ceil(size.Z / maxPartSize)
                
                local partSize = Vector3.new(size.X / divisionsX, size.Y, size.Z / divisionsZ)
            
                for i = 0, divisionsX - 1 do
                    for j = 0, divisionsZ - 1 do
                        local offsetX = (i - (divisionsX / 2)) * partSize.X + (partSize.X / 2)
                        local offsetZ = (j - (divisionsZ / 2)) * partSize.Z + (partSize.Z / 2)
                        createPart(position + Vector3.new(offsetX, 0, offsetZ), partSize)
                    end
                end
            else
                createPart(position, size)
            end
        end
        wait(0.2)
        do_baseplate_check()
        wait(0.1)
        getgenv().passed_baseplate_check = true
    end
    wait(0.2)
    if getgenv().emotes_bypassed then
        warn("Emotes are already bypassed.")
    else
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Emote_Bypass_Script.lua'))()
        getgenv().emotes_bypassed = true
    end
    wait(0.5)
    local TextChatService = getgenv().Service_Wrap("TextChatService")
    local TextChannels = TextChatService:FindFirstChild("TextChannels")
    local RBXGeneral = TextChannels:FindFirstChild("RBXGeneral")

    RBXGeneral:DisplaySystemMessage("You are now running:")
    wait(1.7)
    RBXGeneral:DisplaySystemMessage("Flames Hub, with version:")
    wait(1.8)
    RBXGeneral:DisplaySystemMessage(tostring(Script_Version))
    wait(1.5)
    RBXGeneral:DisplaySystemMessage("Welcome, "..tostring(game.Players.LocalPlayer).." | We hope you enjoy scripting.")
    wait(0.5)
    -- This is a full advanced setup for Rayfield, which is why my UI is able to work on any executor.
    local Rayfield = nil
    local MAX_ATTEMPTS = 5
    local WAIT_BETWEEN_ATTEMPTS = 1

    for attempt = 1, MAX_ATTEMPTS do
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/GetUILibrary"))()
        end)

        if success and result then
            Rayfield = result
            print("Rayfield loaded successfully on attempt:", attempt)
            break
        else
            warn("Rayfield load failed on attempt:", attempt, "Error:", result)
            task.wait(WAIT_BETWEEN_ATTEMPTS)
        end
    end

    if not Rayfield then
        warn("[CRITICAL_ERROR]: Failed to load Rayfield after multiple attempts.")
    end
    wait(0.5)
    -- This can be used anytime while using the script by executing the following: getgenv().notify("Welcome", "Your content here.", 6)
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
    wait(0.1)
    -- I made sure to include these since Material saving isn't exactly easy, so it saves right here.
    if getgenv().OriginalMaterials then
        local function restoreOriginalMaterials()
            for part, properties in pairs(getgenv().OriginalMaterials) do
                if part then
                    part.Material = properties.Material
                    part.Reflectance = properties.Reflectance
                end
            end

            getgenv().OriginalMaterials = nil -- Don't notice a wait() in between? lol
        end

        restoreOriginalMaterials()
    end -- Notice how there isn't an else statement? yeah I think you can guess why.
    wait(0.2)
    local Workspace = getgenv().Workspace
    wait()
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        if getgenv().conveyer_stored then
            warn("Already stored conveyer's")
        else
            local Storage = Workspace:FindFirstChild("PartStorage")
            local CFrames = { -- All official working CFrame's for the conveyer (the one you go up and it's like a circular platform).
                ["Conveyer_1"] = CFrame.new(203.401642, 12.8743448, -100.937836, 1.4424324e-05, -0.70705986, -0.707153797, 5.9902668e-06, 0.707153738, -0.70705986, 1, 5.9902668e-06, 1.4424324e-05),
                ["Conveyer_2"] = CFrame.new(221.043793, 28.0164795, -104.937843, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                ["Conveyer_3"] = CFrame.new(217.043793, 28.0164833, -113.937866, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07),
                ["Conveyer_4"] = CFrame.new(196.330627, 43.4307442, -113.937851, -3.23057175e-05, 0.707153201, 0.707060337, 1.33812428e-05, 0.707060337, -0.707153201, -1, -1.33812428e-05, -3.23057175e-05)
            }
            wait(0.2)
            -- This is the code to Parent them to our PartStorage Folder, because I truly think it's convenient to do so.
            for name, cf in pairs(CFrames) do
                for _, v in ipairs(Workspace:GetChildren()) do
                    if v:IsA("BasePart") and v.CFrame == cf then
                        v.Name = name
                        v.Parent = Storage
                    end
                end
                wait(0.1)
            end
            wait(0.1)
            local Lighting = getgenv().Lighting
            local Storage = getgenv().Workspace:FindFirstChild("PartStorage")

            getgenv().boolean_connection_clocktime_watchdog = true
            getgenv().clocktime_connection_main = nil

            local function updateConveyors()
                if getgenv().boolean_connection_clocktime_watchdog and Lighting.ClockTime < 3 then
                    if Storage then
                        for _, v in ipairs(Storage:GetChildren()) do
                            if v:IsA("BasePart") and v.Name == "Conveyer_1" then
                                v.Transparency = 0.1
                                v.BrickColor = BrickColor.new("Institutional white")
                            end
                        end
                        for _, v in ipairs(Storage:GetChildren()) do
                            if v:IsA("BasePart") and v.Name == "Conveyer_2" then
                                v.Transparency = 0.1
                                v.BrickColor = BrickColor.new("Institutional white")
                            end
                        end
                        for _, v in ipairs(Storage:GetChildren()) do
                            if v:IsA("BasePart") and v.Name == "Conveyer_3" then
                                v.Transparency = 0.1
                                v.BrickColor = BrickColor.new("Institutional white")
                            end
                        end
                        for _, v in ipairs(Storage:GetChildren()) do
                            if v:IsA("BasePart") and v.Name == "Conveyer_4" then
                                v.Transparency = 0.1
                                v.BrickColor = BrickColor.new("Institutional white")
                            end
                        end
                    end
                else
                    for _, v in ipairs(Storage:GetChildren()) do
                        if v:IsA("BasePart") and v.Name == "Conveyer_1" then
                            v.Transparency = 0.3
                            v.BrickColor = BrickColor.new("Really black")
                        end
                    end
                    for _, v in ipairs(Storage:GetChildren()) do
                        if v:IsA("BasePart") and v.Name == "Conveyer_2" then
                            v.Transparency = 0.3
                            v.BrickColor = BrickColor.new("Really black")
                        end
                    end
                    for _, v in ipairs(Storage:GetChildren()) do
                        if v:IsA("BasePart") and v.Name == "Conveyer_3" then
                            v.Transparency = 0.3
                            v.BrickColor = BrickColor.new("Really black")
                        end
                    end
                    for _, v in ipairs(Storage:GetChildren()) do
                        if v:IsA("BasePart") and v.Name == "Conveyer_4" then
                            v.Transparency = 0.3
                            v.BrickColor = BrickColor.new("Really black")
                        end
                    end
                end
            end

            getgenv().ToggleClockTimeCheck = function(state)
                getgenv().boolean_connection_clocktime_watchdog = state

                if state then
                    if not getgenv().clocktime_connection_main then
                        getgenv().clocktime_connection_main = Lighting:GetPropertyChangedSignal("ClockTime"):Connect(updateConveyors)
                    end

                    updateConveyors()
                else
                    if getgenv().clocktime_connection_main then
                        getgenv().clocktime_connection_main:Disconnect()
                        getgenv().clocktime_connection_main = nil
                    end
                end
            end

            getgenv().ToggleClockTimeCheck(true)
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
            for _, v in ipairs(getgenv().Workspace:GetChildren()) do
                if v:IsA("MeshPart") and v.CFrame == CFrame.new(170.998001, 58, -113.500031, -1, 0, 0, 0, 1, 0, 0, 0, -1) then
                    v.Name = "MeshPart_Floor_Conveyers"
                    v.Parent = getgenv().Workspace:FindFirstChild("PartStorage")
                    v.Transparency = 0.3
                    v.BrickColor = BrickColor.new("Really black")
                end
            end
            wait(0.1)
            getgenv().conveyer_stored = true
        end
    else
        warn("Not on 'MIC UP' or 'MIC UP 17+', not converting 'MeshPart's' and 'BaseParts'.")
    end
    wait()
    if getgenv().Players.RespawnTime == 0 then
        warn("Players.RespawnTime is already 0")
    else
        getgenv().Players.RespawnTime = 0
        wait(0.1)
        print("Set 'RespawnTime' to 0 successfully.")
    end
    wait()
    
    wait()
    function connect_tp_tool()
        local speaker = getgenv().LocalPlayer
        local TpTool = Instance.new("Tool")
        local IYMouse = speaker:GetMouse()
        TpTool.Name = "Teleport Tool"
        TpTool.RequiresHandle = false
        TpTool.Parent = speaker and speaker:WaitForChild("Backpack")
        TpTool.Activated:Connect(function()
            local Char = speaker.Character
            local HRP = getgenv().getRoot(Char)
            if not Char or not HRP then
                return warn("Failed to find HumanoidRootPart")
            end
            HRP.CFrame = CFrame.new(IYMouse.Hit.X, IYMouse.Hit.Y + 3, IYMouse.Hit.Z, select(4, HRP.CFrame:components()))
        end)
    end
    wait(0.1)
    local fileName = "System_Broken_Setting.txt"
    local file_2 = "TP_Tool_Setting.txt"

    if delfile and isfile and isfile(fileName) then
        delfile(fileName)
    end
    if delfile and isfile and isfile(file_2) then
        delfile(file_2)
    end
    wait(0.2)
    local image_id_flames = 93594537601787
    getgenv().image_flames_hub = image_id_flames
    local Flames_Module = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua'))()
    wait()
    getgenv().Module_For_Flames_Hub = Flames_Module

    getgenv().AllClipboards("https://github.com/EnterpriseExperience/MicUpSource/releases <-- make sure to stay updated.")
    wait()
    local Window 
    wait(0.2)
    if executor_Name == "Solara" or executor_Name == "Sonar" or executor_Name == "Xeno" or executor_Name == "Macsploit" then
        Window = Rayfield:CreateWindow({
            Name = "👽 Flames Hub 👽 | "..tostring(Script_Version).." | "..tostring(executor_Name),
            LoadingTitle = "Enjoy, "..tostring(getgenv().LocalPlayer),
            LoadingSubtitle = "Flames Hub | Wassup!",
            ConfigurationSaving = {
                Enabled = false,
                FolderName = "ConfigurationFlamesHub",
                FileName = "FlamesHub"
            },
            Discord = {
                Enabled = false,
                Invite = "",
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
    else
        Window = Rayfield:CreateWindow({
            Name = "👽 Flames Hub 👽 | "..tostring(Script_Version).." | "..tostring(executor_Name),
            LoadingTitle = "Enjoy, "..tostring(game.Players.LocalPlayer),
            LoadingSubtitle = "Flames Hub | Wassup!",
            ConfigurationSaving = {
                Enabled = false,
                FolderName = "ConfigurationFlamesHub",
                FileName = "FlamesHub"
            },
            Discord = {
                Enabled = false,
                Invite = "",
                RememberJoins = true
            },
            KeySystem = false,
            KeySettings = {
                Title = "Flames Key System",
                Subtitle = "Welcome, "..tostring(getgenv().LocalPlayer),
                Note = "Hello!",
                FileName = "Admin_Key",
                SaveKey = true,
                GrabKeyFromSite = false,
                Key = {"REKT_2025"}
            }
        })
    end
    wait()
    --getgenv().notify("Heads Up!", "We have now defaulted to Infinite Premium [mine].", 7)
    wait(0.1)
    -- [] -->> Initialize our Tabs and Sections <<-- [] --
    local Tab1 = Window:CreateTab("🏡 Home 🏡", getgenv().image_flames_hub)
    local Section1 = Tab1:CreateSection("||| 🏡 Home 🏡 Section |||")

    local Tab21
    local Section21
    local Tab10
    local Section10
    local Tab11
    local Section11
    wait(0.2)
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        Tab11 = Window:CreateTab("🚪 Booths 🚪", getgenv().image_flames_hub)
        Section11 = Tab11:CreateSection("||| 🚪 Booths 🚪 Section |||")
    else
        Tab11 = nil
        Section11 = nil
    end
    wait(0.2)
    local Tab2 = Window:CreateTab("🧍 LocalPlayer 🧍", getgenv().image_flames_hub)
    local Section2 = Tab2:CreateSection("||| 🧍 LocalPlayer 🧍 Section |||")

    local Tab13 = Window:CreateTab("👩‍👩‍👧‍👦 Players 👩‍👩‍👧‍👦", getgenv().image_flames_hub)
    local Section13 = Tab13:CreateSection("||| 👩‍👩‍ Players 👩‍👩‍ Section |||")

    local Tab22 = Window:CreateTab("📏 Baseplate 📏", getgenv().image_flames_hub)
    local Section22 = Tab22:CreateSection("||| 📏‍ Baseplate 📏‍ Section |||")

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        Tab10 = Window:CreateTab("🦿 Teleports 🦿", getgenv().image_flames_hub)
        Section10 = Tab10:CreateSection("||| 🦿 Teleports 🦿 Section |||")
    else
        Tab10 = nil
        Section10 = nil
        warn("Not loading Teleports, not 'MIC UP' or 'MIC UP 17+'.")
    end
    wait(0.2)
    Tab18 = Window:CreateTab("🗺️ Map 🗺️", getgenv().image_flames_hub)
    Section18 = Tab18:CreateSection("||| 🗺️ Map 🗺️ Section |||")

    if getgenv().LocalPlayer:FindFirstChildOfClass("AudioDeviceInput") then
        Tab21 = Window:CreateTab("🎤 VC 🎤", getgenv().image_flames_hub)
        Section21 = Tab21:CreateSection("||| 🎤 VC 🎤 Section |||")
    else
        Tab21 = Window:CreateTab("🎙️ VoiceChat 🎙️", getgenv().image_flames_hub)
        Section21 = Tab21:CreateSection("||| 🎙️ VoiceChat 🎙️ Section |||")
    end
    wait()
    Tab4 = Window:CreateTab("💬 Chat 💬", getgenv().image_flames_hub)
    Section4 = Tab4:CreateSection("||| 💬 Chat 💬 Section |||")

    Tab5 = Window:CreateTab("🤖 Exploits 🤖", getgenv().image_flames_hub)
    Section5 = Tab5:CreateSection("||| 🤖 Exploits 🤖 Section |||")

    Tab16 = Window:CreateTab("🌎 Universal 🌎", getgenv().image_flames_hub)
    Section16 = Tab16:CreateSection("||| 🌎 Global 🌎 Section |||")

    local Tab7 = Window:CreateTab("❓ Whitelist ❓", getgenv().image_flames_hub)
    local Section7 = Tab7:CreateSection("||| ❓ Whitelist ❓ Section |||")

    Tab17 = Window:CreateTab("🕺 Animations 🕺", getgenv().image_flames_hub)
    Section17 = Tab17:CreateSection("||| 🕺 Animations 🕺 Section |||")

    Tab9 = Window:CreateTab("💡 Lighting 💡", getgenv().image_flames_hub)
    Section9 = Tab9:CreateSection("||| 💡 Lighting 💡 Section |||")

    Tab12 = Window:CreateTab("🏃‍♂️ Emotes 🏃‍♂️", getgenv().image_flames_hub)
    Section12 = Tab12:CreateSection("||| 🏃‍♂️ Emotes 🏃‍♂️ Section |||")

    local Tab19 = Window:CreateTab("👁️ Visuals 👁️", getgenv().image_flames_hub)
    local Section19 = Tab19:CreateSection("||| 👁️ Visuals 👁️ Section |||")
    wait()
    Tab14 = Window:CreateTab("💫 CopyAnimation 💫", getgenv().image_flames_hub)
    Section14 = Tab14:CreateSection("||| 💫 Copy Animation 💫 Section |||")

    Tab15 = Window:CreateTab("📝 Settings 📝", getgenv().image_flames_hub)
    Section15 = Tab15:CreateSection("||| 📝 Settings 📝 Section |||")

    Tab20 = Window:CreateTab("📜 Config 📜", getgenv().image_flames_hub)
    Section20 = Tab20:CreateSection("||| 📜 Configuration 📜 Section |||")
    wait(0.2)
    if getgenv().LocalPlayer.Name == "L0CKED_1N1" or getgenv().LocalPlayer.Name == "CHEATING_B0SS" then
        local MaterialService = cloneref and cloneref(game:GetService("MaterialService")) or game:GetService("MaterialService")

        MaterialService.Use2022Materials = false
        wait(0.2)
        getgenv().loaded_materials = true
    end
    wait(0.1)
    -- Start searching for the 'Game' Folder located in Workspace, and modify they're "Parent" them somewhere else, and the Part 'Teleport' as well, so we are invincible to that platform game where the soccer thing is.
    local GameFolder
    local GetTeleportPart
    local AssetService = getgenv().AssetService
    local Asset_Service_Duplicate = getgenv().AssetService

    if getgenv().Game.PlaceId == 6884319169 or getgenv().Game.PlaceId == 15546218972 then
        GameFolder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Game")
        GetTeleportPart = GameFolder and GameFolder:FindFirstChild("Teleport")
    else
        warn("Not In MIC UP!")
        GameFolder = nil
        GetTeleportPart = nil
    end
    -- I fixed this function for resetting lighting, and now starts up automatically.
    
    getgenv().reset_all_lighting_settings_to_default = function()
        local Lighting = getgenv().Lighting
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

    function resetLightingSettings()
        if not getgenv().Lighting:FindFirstChildOfClass("Atmosphere") then
            local Atmosphere = Instance.new("Atmosphere")
            Atmosphere.Density = 0.3
            Atmosphere.Parent = getgenv().Lighting
            Atmosphere.Offset = 0.25
            Atmosphere.Color = Color3.fromRGB(199, 199, 199)
            Atmosphere.Decay = Color3.fromRGB(106, 112, 125)
            Atmosphere.Glare = 0
            Atmosphere.Haze = 0
        else
            getgenv().Lighting:FindFirstChildOfClass("Atmosphere").Density = 0.3
            getgenv().Lighting:FindFirstChildOfClass("Atmosphere").Offset = 0.25
            getgenv().Lighting:FindFirstChildOfClass("Atmosphere").Color = Color3.fromRGB(199, 199, 199)
            getgenv().Lighting:FindFirstChildOfClass("Atmosphere").Decay = Color3.fromRGB(106, 112, 125)
            getgenv().Lighting:FindFirstChildOfClass("Atmosphere").Glare = 0
            getgenv().Lighting:FindFirstChildOfClass("Atmosphere").Haze = 0
        end
        wait()
        if not getgenv().Lighting:FindFirstChildOfClass("Sky") then
            local Sky = Instance.new("Sky")
            Sky.MoonAngularSize = 11
            Sky.Parent = getgenv().Lighting
            Sky.CelestialBodiesShown = true
            Sky.MoonTextureId = "rbxassetid://6444320592"
            Sky.SkyboxBk = "rbxassetid://6444884337"
            Sky.SkyboxDn = "rbxassetid://6444884785"
            Sky.SkyboxFt = "rbxassetid://6444884337"
            Sky.SkyboxLf = "rbxassetid://6444884337"
            Sky.SkyboxRt = "rbxassetid://6444884337"
            Sky.SkyboxUp = "rbxassetid://6412503613"
            Sky.StarCount = 3000
            Sky.SunAngularSize = 11
            Sky.SunTextureId = "rbxassetid://6196665106"
        else
            getgenv().Lighting:FindFirstChildOfClass("Sky").MoonAngularSize = 11
            getgenv().Lighting:FindFirstChildOfClass("Sky").CelestialBodiesShown = true
            getgenv().Lighting:FindFirstChildOfClass("Sky").MoonTextureId = "rbxassetid://6444320592"
            getgenv().Lighting:FindFirstChildOfClass("Sky").SkyboxBk = "rbxassetid://6444884337"
            getgenv().Lighting:FindFirstChildOfClass("Sky").SkyboxDn = "rbxassetid://6444884785"
            getgenv().Lighting:FindFirstChildOfClass("Sky").SkyboxFt = "rbxassetid://6444884337"
            getgenv().Lighting:FindFirstChildOfClass("Sky").SkyboxLf = "rbxassetid://6444884337"
            getgenv().Lighting:FindFirstChildOfClass("Sky").SkyboxRt = "rbxassetid://6444884337"
            getgenv().Lighting:FindFirstChildOfClass("Sky").SkyboxUp = "rbxassetid://6412503613"
            getgenv().Lighting:FindFirstChildOfClass("Sky").StarCount = 3000
            getgenv().Lighting:FindFirstChildOfClass("Sky").SunAngularSize = 11
            getgenv().Lighting:FindFirstChildOfClass("Sky").SunTextureId = "rbxassetid://6196665106"
        end
        wait()
        if not getgenv().Lighting:FindFirstChildOfClass("BloomEffect") then
            local Bloom = Instance.new("BloomEffect")
            Bloom.Enabled = true
            Bloom.Parent = getgenv().Lighting
            Bloom.Intensity = 1
            Bloom.Size = 24
            Bloom.Threshold = 2
        else
            getgenv().Lighting:FindFirstChildOfClass("BloomEffect").Enabled = true
            getgenv().Lighting:FindFirstChildOfClass("BloomEffect").Intensity = 1
            getgenv().Lighting:FindFirstChildOfClass("BloomEffect").Size = 24
            getgenv().Lighting:FindFirstChildOfClass("BloomEffect").Threshold = 2
        end
        wait()
        if not getgenv().Lighting:FindFirstChildOfClass("DepthOfFieldEffect") then
            local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect")
            DepthOfFieldEffect.Enabled = false
            DepthOfFieldEffect.Parent = getgenv().Lighting
            DepthOfFieldEffect.FarIntensity = 0.1
            DepthOfFieldEffect.FocusDistance = 0.05
            DepthOfFieldEffect.InFocusRadius = 30
            DepthOfFieldEffect.NearIntensity = 0.75
        else
            getgenv().Lighting:FindFirstChildOfClass("DepthOfFieldEffect").Enabled = false
            getgenv().Lighting:FindFirstChildOfClass("DepthOfFieldEffect").FarIntensity = 0.1
            getgenv().Lighting:FindFirstChildOfClass("DepthOfFieldEffect").FocusDistance = 0.05
            getgenv().Lighting:FindFirstChildOfClass("DepthOfFieldEffect").InFocusRadius = 30
            getgenv().Lighting:FindFirstChildOfClass("DepthOfFieldEffect").NearIntensity = 0.75
        end
        wait()
        if not getgenv().Lighting:FindFirstChildOfClass("SunRaysEffect") then
            local SunRaysEffect = Instance.new("SunRaysEffect")
            SunRaysEffect.Enabled = true
            SunRaysEffect.Parent = getgenv().Lighting
            SunRaysEffect.Intensity = 0.01
            SunRaysEffect.Spread = 0.1
        else
            getgenv().Lighting:FindFirstChildOfClass("SunRaysEffect").Enabled = true
            getgenv().Lighting:FindFirstChildOfClass("SunRaysEffect").Intensity = 0.01
            getgenv().Lighting:FindFirstChildOfClass("SunRaysEffect").Spread = 0.1
        end
        wait()
        if not getgenv().Lighting:FindFirstChildOfClass("ColorCorrectionEffect") then
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
            ColorCorrectionEffect.Brightness = 0.1
            ColorCorrectionEffect.Contrast = 0.15
            ColorCorrectionEffect.Enabled = false
            ColorCorrectionEffect.Saturation = 0.25
            ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255)
        else
            getgenv().Lighting:FindFirstChildOfClass("ColorCorrectionEffect").Brightness = 0.1
            getgenv().Lighting:FindFirstChildOfClass("ColorCorrectionEffect").Contrast = 0.15
            getgenv().Lighting:FindFirstChildOfClass("ColorCorrectionEffect").Enabled = false
            getgenv().Lighting:FindFirstChildOfClass("ColorCorrectionEffect").Saturation = 0.25
            getgenv().Lighting:FindFirstChildOfClass("ColorCorrectionEffect").TintColor = Color3.fromRGB(255, 255, 255)
        end
        wait()
        getgenv().Lighting.ClockTime = 14
        getgenv().Lighting.Brightness = 3
        getgenv().Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        getgenv().Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
        getgenv().Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
        getgenv().Lighting.EnvironmentDiffuseScale = 1
        getgenv().Lighting.EnvironmentSpecularScale = 1
        getgenv().Lighting.GlobalShadows = true
        getgenv().Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
        getgenv().Lighting.ShadowSoftness = 0.2
        getgenv().Lighting.Technology = Enum.Technology.Compatibility
        getgenv().Lighting.FogColor = Color3.fromRGB(192, 192, 192)
        getgenv().Lighting.FogEnd = 100000
        getgenv().Lighting.FogStart = 0
        getgenv().Lighting:SetAttribute("UseCurrentLighting", false)
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
    local TeleportService = cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
    local VirtualUser = cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")

    PlaceId, JobId = game.PlaceId, game.JobId
    wait(0.1)
    if getgenv().AntiAfkScript or getgenv().OtherAntiAfk then
        print("AntiAFK Scripts have already been pre-loaded from last session | skipping...")
        wait(0.2)
        warn("000 >>> 000 >>> nil")
    else
        local GC = getconnections or get_signal_cons

        if GC then
            getgenv().OtherAntiAfk = false
            getgenv().AntiAfkScript = true
            wait()
            for i, v in pairs(GC(getgenv().LocalPlayer.Idled)) do
                if v["Disable"] then
                    v["Disable"](v)
                    getgenv().notify("Idled!", "Disabling Event...", 7)
                end
            end
        else
            getgenv().AntiAfkScript = false
            getgenv().OtherAntiAfk = true
            wait(0.1)
            warn("Your executor does not support 'getconnections'! Using VirtualUser for Anti-AFK.")
            wait()
            getgenv().notify("Starting", "AntiAFK (2) is loading with VirtualUser...", 5)
            wait()
            getgenv().LocalPlayer.Idled:Connect(function()
                getgenv().notify("Idled!", "Clicking button...", 5)
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                wait(0.1)
                getgenv().notify("Success!", "Clicked Button (Anti-Idle)", 5)
            end)
        end

        wait(0.2)
        if getgenv().AntiAfkScript or getgenv().AntiAfkScript == true then
            getgenv().notify("Success!", "AntiAFK (1) has loaded!", 5)
        elseif not getgenv().AntiAfkScript or getgenv().AntiAfkScript == false and getgenv().OtherAntiAfk or getgenv().OtherAntiAfk == true then
            getgenv().notify("Success!", "AntiAFK (2) has loaded.", 5)
        end

        if getgenv().AntiAfkScript == false and getgenv().OtherAntiAfk == false then
            getgenv().notify("Failed!", "Could not load any Anti-AFK Scripts.", 5)
        end
    end
    wait(0.1)
    getgenv().r15_or_r6 = function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R15 then
            return true
        else
            return getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 or false
        end
    end
    wait(0.3)
    local ReplicatedStorage = getgenv().ReplicatedStorage
    wait(0.5)
    if getgenv().scripts_init then
        warn("Scripts we're already modified.")
    else
        if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
            getgenv().notify("Hang On...", "We are removing Kill-Parts for Private Room.", 5)
            wait(0.2)
            for _, descendant in pairs(getgenv().Workspace:GetDescendants()) do
                if descendant:IsA("Script") and descendant.Name == "Kill" then
                    local parent = descendant.Parent
                    local touchInterest = parent:FindFirstChild("TouchInterest")
                    if touchInterest then
                        touchInterest:Destroy()
                    end
                    descendant:Destroy()
                end
            end
            wait(0.2)
            getgenv().scripts_init = true
        else
            warn("Skipping this part, not on MIC UP.")
            getgenv().scripts_init = true
        end
        wait(0.2)
        if getgenv().scripts_init or getgenv().scripts_init == true then
            getgenv().notify("Success", "We have removed the Kill-Parts for Private Room", 5)
        end
    end
    wait()
    local Workspace = getgenv().Workspace
    local SoccerField = Workspace:FindFirstChild("SoccerField")
    if SoccerField then
        local BasePlate = SoccerField:FindFirstChild("Baseplate")
        wait(0.1)
        if BasePlate then
            local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")
            BasePlate.Transparency = 1
            if Texture_Bruh then
                Texture_Bruh.Transparency = 1
            end
        else
            warn("Baseplate not found inside SoccerField.")
        end
    end
    task.wait(.1)
    local GameFolder = Workspace:FindFirstChild("Game")
    if GameFolder then
        local BasePlate_1 = GameFolder:FindFirstChild("Baseplate")
        if BasePlate_1 then
            local Texture_Bruh_1 = BasePlate_1:FindFirstChildOfClass("Texture")
            BasePlate_1.Transparency = 1
            if Texture_Bruh_1 then
                Texture_Bruh_1.Transparency = 1
            end
        else
            warn("Baseplate not found inside Game.")
        end
    else
        warn("Neither SoccerField nor Game exist in Workspace.")
    end
    wait()
    local player = getgenv().LocalPlayer
    getgenv().whitelist = {}
    getgenv().ownerWhitelist = {
        "L0CKED_1N1",
        "CHEATING_B0SS"
    }
    wait(0.5)
    --[[if game.PlaceId == 97399198116506 then
        if isSettingEnabled("Mute_Boomboxes_Cellmates_VC_Game_Setting") then
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
        if isSettingEnabled("Mute_Music_Volume_Cellmates_VC_Game_Setting") then
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
        if isSettingEnabled("Mute_Sound_Effects_Cellmates_VC_Game_Setting") then
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
    end--]]
    wait()
    -- [] -->> Functions <<-- [] --
    local cmdp = getgenv().Players
    local cmdlp = getgenv().LocalPlayer or cmdp.LocalPlayer

    function findplr(args)
        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players") or getgenv().Players
        local tbl = Players:GetPlayers()

        if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
            return getgenv().notify("Failure!", "You cannot target yourself!", 6)
        end

        if args == "random" then
            local validPlayers = {}
            for _, v in pairs(tbl) do
                if v ~= cmdlp then
                    table.insert(validPlayers, v)
                end
            end
            return #validPlayers > 0 and validPlayers[math.random(1, #validPlayers)] or nil
        end

        if args == "new" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v.AccountAge < 30 and v ~= cmdlp then
                    table.insert(vAges, v)
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        if args == "old" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v.AccountAge > 30 and v ~= cmdlp then
                    table.insert(vAges, v)
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        if args == "bacon" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v ~= cmdlp and (v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair")) then
                    table.insert(vAges, v)
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        if args == "friend" then
            local friendList = {}
            for _, v in pairs(tbl) do
                if v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                    table.insert(friendList, v)
                end
            end
            return #friendList > 0 and friendList[math.random(1, #friendList)] or nil
        end

        if args == "notfriend" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if not v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                    table.insert(vAges, v)
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        if args == "ally" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v.Team == cmdlp.Team and v ~= cmdlp then
                    table.insert(vAges, v)
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        if args == "enemy" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v.Team ~= cmdlp.Team and v ~= cmdlp then
                    table.insert(vAges, v)
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        if args == "near" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v ~= cmdlp and v.Character and cmdlp.Character then
                    local vRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                    local cmdlpRootPart = cmdlp.Character:FindFirstChild("HumanoidRootPart")
                    if vRootPart and cmdlpRootPart then
                        local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
                        if distance < 30 then
                            table.insert(vAges, v)
                        end
                    end
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        if args == "far" then
            local vAges = {}
            for _, v in pairs(tbl) do
                if v ~= cmdlp and v.Character and cmdlp.Character then
                    local vRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                    local cmdlpRootPart = cmdlp.Character:FindFirstChild("HumanoidRootPart")
                    if vRootPart and cmdlpRootPart then
                        local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
                        if distance > 30 then
                            table.insert(vAges, v)
                        end
                    end
                end
            end
            return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
        end

        for _, v in pairs(tbl) do
            if (v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower())) and v ~= cmdlp then
                return v
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
    -- AntiLag modified exclusively by Flames Hub
    if not getgenv().AbsoluteAntiLagFlamesHub then
        local Terrain = getgenv().Terrain
        local Lighting = getgenv().Lighting
        local Workspace = getgenv().Workspace

        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 0

        local function optimize(child)
            if child:IsA("BasePart") and child.Name ~= "Terrain" then
                child.Material = Enum.Material.Plastic
                child.Reflectance = 0
            elseif child:IsA("Texture") then
                child:Destroy()
            elseif child:IsA("ParticleEmitter") or child:IsA("Smoke") then
                child.Enabled = false
            elseif child:IsA("Explosion") then
                child.Visible = false
            end
        end

        for _, child in pairs(Workspace:GetDescendants()) do
            optimize(child)
        end
        wait(0.1)
        getgenv().AbsoluteAntiLagFlamesHub = true
    else
        warn("Anti-Lag already loaded for Flames Hub!")
    end
    wait()
    local safeEmotes = {
        "DearALICE - Ariana",
        "The Weeknd Starboy Strut",
        "The Weeknd Opening Night",
        "Robot M3GAN",
        "M3GAN's Dance",
        "Rasputin – Boney M.",
        "Thanos Happy Jump",
        "Thanos Happy Jump - Squid Game",
        "Young-hee Head Spin - Squid Game",
        "TWICE Takedown",
        "NBA Monster Dunk",
        "Stray Kids Walkin On Water",
        "TWICE Strategy",
        "Fashion Spin",
        "Sleep",
        "Olivia Rodrigo Head Bop",
        "Sturdy Dance - Ice Spice",
        "Victory Dance",
        "Elton John - Heart Shuffle",
        "Bored",
        "Chappell Roan HOT TO GO!",
        "High Wave",
        "Mae Stephens - Piano Hands",
        "Disagree",
        "Line Dance",
        "Agree",
        "Yungblud Happier Jump",
        "Sad",
        "HUGO Let's Drive!",
        "Show Dem Wrists - KSI",
        "Shy",
        "Floss Dance",
        "Tommy - Archer",
        "Wake Up Call - KSI",
        "Fashion Roadkill",
        "Paris Hilton - Sliving For The Groove",
        "Greatest",
        "Happy",
        "Cower",
        "Fast Hands",
        "Cuco - Levitate",
        "Bone Chillin' Bop",
        "Festive Dance",
        "Sidekicks - George Ezra",
        "Baby Queen - Face Frame",
        "Beckon",
        "Zombie",
        "Godlike",
        "Curtsy",
        "Alo Yoga Pose - Lotus Position",
        "Dancin' Shoes - Twenty One Pilots",
        "Confused",
        "Elton John - Heart Skip",
        "HIPMOTION - Amaarae",
        "Monkey",
        "KATSEYE - Touch",
        "Baby Queen - Bouncy Twirl",
        "Rock Out - Bebe Rexha",
        "d4vd - Backflip",
        "Rock On",
        "Team USA Breaking Emote",
        "Uprise - Tommy Hilfiger",
        "Wanna play?",
        "Baby Queen - Air Guitar & Knee Slide",
        "TWICE Feel Special",
        "Wisp - air guitar",
        "Secret Handshake Dance",
        "HOLIDAY Dance - Lil Nas X (LNX)",
        "Old Town Road Dance - Lil Nas X (LNX)",
        "Frosty Flair - Tommy Hilfiger",
        "Rock n Roll",
        "Jumping Wave",
        "Sol de Janeiro - Samba",
        "Baby Queen - Strut",
        "Baby Queen - Dramatic Bow",
        "Hero Landing",
        "Bodybuilder",
        "V Pose - Tommy Hilfiger",
        "Boxing Punch - KSI",
        "Quiet Waves",
        "Baby Dance",
        "Top Rock",
        "Nicki Minaj Starships",
        "Dave's Spin Move - Glass Animals",
        "TWICE LIKEY",
        "TWICE I GOT YOU part 2",
        "Tantrum",
        "Rock Guitar - Royal Blood",
        "Elton John - Elevate",
        "ericdoa - dance",
        "Imagine Dragons - \"Bones\" Dance",
        'GloRilla - "Tomorrow" Dance',
        "Take Me Under - Zara Larsson",
        "Olivia Rodrigo Fall Back to Float",
        "Get Out",
        "Haha",
        "It Ain't My Fault - Zara Larsson",
        "High Hands",
        "Jawny - Stomp",
        "Power Blast",
        "Alo Yoga Pose - Warrior II",
        "Hips Poppin' - Zara Larsson",
        "Y",
        "Elton John - Rock Out",
        "Nicki Minaj Boom Boom Boom",
        "Flowing Breeze",
        "Mean Mug - Tommy Hilfiger",
        "Samba",
        "Fashion Klossette - Runway my way",
        "NBA WNBA Fadeaway",
        "Swish",
        "Robot",
        "TWICE I GOT YOU part 1",
        "Beauty Touchdown",
        "Floor Rock Freeze - Tommy Hilfiger",
        "Cha Cha",
        "Alo Yoga Pose - Triangle",
        "Dizzy",
        "Break Dance",
        "Fishing",
        "Sticker Dance Move - NCT 127",
        "Paris Hilton - Iconic IT-Grrrl",
        "Side to Side",
        "Tommy K-Pop Mic Drop",
        "Mini Kong",
        "Jacks",
        "Up and Down - Twenty One Pilots",
        "Rolling Stones Guitar Strum",
        "Idol",
        "AOK - Tai Verdes",
        "Boom Boom Clap - George Ezra",
        "Celebrate",
        "Celebrate",
        "Rock Star - Royal Blood",
        "Around Town",
        "The Zabb",
        "Elton John - Still Standing",
        "TMNT Dance",
        "Flex Walk",
        "Paris Hilton - Checking My Angles",
        "Tree",
        "Dolphin Dance",
        "Air Guitar",
        "Drummer Moves - Twenty One Pilots",
        "Ay-Yo Dance Move - NCT 127",
        "Saturday Dance - Twenty One Pilots",
        "Swan Dance",
        "Kick It Dance Move - NCT 127",
        "Fancy Feet",
        "SpongeBob Imaginaaation 🌈",
        "Lasso Turn - Tai Verdes",
        "Elton John - Cat Man",
        "Dorky Dance",
        "Rise Above - The Chainsmokers",
        "Shuffle",
        "Arm Twist",
        "Twirl",
        "T",
        "Rodeo Dance - Lil Nas X (LNX)",
        "Louder",
        "Super Charge",
        "Mean Girls Dance Break",
        "Sneaky",
        "Cobra Arms - Tai Verdes",
        "Shrek Roar",
        "Air Dance",
        "On The Outside - Twenty One Pilots",
        "Block Partier",
        "Chill Vibes - George Ezra",
        "Fashionable",
        "Jumping Cheer",
        "Drum Solo - Royal Blood",
        "Elton John - Piano Jump",
        "Keeping Time",
        "Olivia Rodrigo good 4 u",
        "Cartwheel - George Ezra",
        "Panini Dance - Lil Nas X (LNX)",
        "Paris Hilton Sanasa",
        "Drum Master - Royal Blood",
        "Salute",
        "Tilt",
        "Applaud",
        "Hello",
        "Shrug",
        "Point2",
        "Stadium",
        "Stray Kids Walkin On Water"
    }
    wait(0.2)
    print("Loaded emotes names table.")
    wait(0.2)
    getgenv().CopyURLLinkToUpdatesLink = Tab1:CreateButton({
    Name = "Copy Link To See Latest Updates",
    Callback = function()
        if getgenv().AllClipboards then
            getgenv().AllClipboards("https://github.com/EnterpriseExperience/MicUpSource/releases")
            getgenv().notify("Success:", "Paste the link copied onto your browser to view all recent updates!", 5)
        else
            warn("https://github.com/EnterpriseExperience/MicUpSource/releases")
            getgenv().notify("Failure:", "Posted the link in Developer Console, couldn't copy.", 6)
        end
    end,})

    function check_r15()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R15 then
            return true
        else
            return getgenv().notify("Failure:", "You do not seem to be R15.", 5)
        end
    end
    getgenv().is_r15_checker = check_r15
    local is_r15 = check_r15()
    wait(0.4)
    getgenv().PlayAnyEmote = Tab2:CreateDropdown({
    Name = "Play Emote",
    Options = safeEmotes,
    CurrentOption = "Shuffle",
    MultipleOptions = false,
    Flag = "choose_an_emote",
    Callback = function(emote_picked)
        local emoteToPlay = type(emote_picked) == "table" and emote_picked[1] or tostring(emote_picked)

        if getgenv().Humanoid and is_r15 == true then
            getgenv().Humanoid:PlayEmote(emoteToPlay)
        elseif not getgenv().Humanoid.RigType == Enum.HumanoidRigType.R15 then
            return getgenv().notify("Failure:", "You are not R15!", 5)
        end
    end,})
    wait(0.1)
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        Players = getgenv().Players
        Workspace = getgenv().Workspace
        UserInputService = getgenv().UserInputService
        RunService = getgenv().RunService
        ReplicatedStorage = getgenv().ReplicatedStorage
        TweenService = getgenv().TweenService
        LocalPlayer = getgenv().LocalPlayer
        HttpService = getgenv().HttpService

        local ghostEnabled = false
        local originalCharacter
        local ghostClone
        local originalCFrame
        local originalAnimateScript
        local updateConnection

        local ghostOriginalHipHeight

        local cloneSize = 1
        local cloneWidth = 1

        local ghostOriginalSizes = {}
        local ghostOriginalMotorCFrames = {}
        wait(0.1)
        local body_parts = {
            "Head", "UpperTorso", "LowerTorso",
            "LeftUpperArm", "LeftLowerArm", "LeftHand",
            "RightUpperArm", "RightLowerArm", "RightHand",
            "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
            "RightUpperLeg", "RightLowerLeg", "RightFoot"
        }
        wait(0.1)
        getgenv().StallClaimToggle = Tab11:CreateToggle({
        Name = "Claim Any Booth",
        CurrentValue = false,
        Flag = "StallClaimToggle",
        Callback = function(claimAnyBooth)
            if claimAnyBooth then
                getgenv().isToggled = true

                local Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")

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

                local Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                
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
            local Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
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

            local function get_plr_stall(Name)
                for _, v in pairs(Folder:GetChildren()) do
                    local usernameGui = v:FindFirstChild("Username") and v.Username:FindFirstChild("BillboardGui")
                    if usernameGui and usernameGui.TextLabel.Text == "Owned by: " .. tostring(Name) then
                        return v
                    end
                end
                return nil
            end
            
            local plr_booth = getStall()
            
            if plr_booth then
                return getgenv().notify("Failure", "You already own a Booth!", 5)
            end
            
            local OldCF = getgenv().getRoot(getgenv().Character).CFrame
            
            local stalls = {
                Folder:FindFirstChild("Booth01"),
                Folder:FindFirstChild("Booth02"),
                Folder:FindFirstChild("Booth03"),
                Folder:FindFirstChild("Booth04"),
                Folder:FindFirstChild("Booth05")
            }
            
            local function setupProximityPrompt(stall)
                if not stall then return end

                local usernameObj = stall:FindFirstChild("Username")
                local user_stuff = usernameObj and usernameObj:FindFirstChild("BillboardGui")
                local textlabel_bruh = user_stuff and user_stuff:FindFirstChild("TextLabel")

                local retrieve_username = nil
                if textlabel_bruh and textlabel_bruh:IsA("TextLabel") and textlabel_bruh.Text then
                    retrieve_username = textlabel_bruh.Text:match("Owned by: (.+)")
                end

                if retrieve_username and getgenv().boothWhitelistingPlayer and getgenv().boothWhitelistingPlayer[retrieve_username] then
                    return getgenv().notify("Failure", "This player is Booth Whitelisted, try again.", 6)
                end

                wait()
                getgenv().StallClaimToggle:Set(true)
            end
            
            local function Claim_A_Booth()
                local OldCF = getgenv().Character:FindFirstChildWhichIsA("Humanoid").CFrame
            
                local plr_booth = getStall()
                if plr_booth then
                    return notify("Failure", "You already own a Booth!", 6)
                end

                local stall = stalls[math.random(1, #stalls)]
                if stall then
                    setupProximityPrompt(stall)
                    getgenv().StallClaimToggle:Set(true)
                    task.wait(0.1)

                    if stall then
                        getgenv().Character:FindFirstChildWhichIsA("Humanoid").CFrame = stall:GetPivot()
                    else
                        return getgenv().notify("Error:", "Player's Booth was not found", 6)
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
                    getgenv().getRoot(getgenv().Character).CFrame = OldCF
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
            wait(0.1)
            getgenv().StallClaimToggle:Set(false)
        end,})
    else
        warn("Did not load Booth's stuff [1].")
    end

    if getgenv().PlaceID == 6884319169 or getgenv().PlaceID == 15546218972 then
        getgenv().FreeReanimationGUI = Tab1:CreateButton({
        Name = "Free Reanimations GUI (Best Anim Speed = 110-125)",
        Callback = function()
            loadstring(getgenv().Game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/OpenSource_Reanim_Free.lua'))()
        end,})
    end

    local esplib = loadstring(getgenv().Game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/esp_library.lua"))()

    getgenv().AntiVoidPlayer = Tab2:CreateToggle({
    Name = "Anti Void Baseplate (Goes under Character)",
    CurrentValue = false,
    Flag = "ToggleAntiVoidBasePlate",
    Callback = function(antiVoidFall)
        if antiVoidFall then
            getgenv().keepMyPlateOn = true 
            getgenv().plateBelowMeOffset = -6
            getgenv().letItFollow = true

            local wrkspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
            local plyrs = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
            local uis = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
            local me = plyrs.LocalPlayer

            local floatSpeed = 0.2
            local upPressed = false
            local downPressed = false

            local function getMyCharacter()
                local char = me.Character or me.CharacterAdded:Wait()
                while char:FindFirstChild("Humanoid") and char.Humanoid.Health <= 0 do
                    char = me.CharacterAdded:Wait()
                end
                return char
            end

            local function putThingUnderMe()
                if getgenv().myPlateThingy then
                    getgenv().myPlateThingy:Destroy()
                end

                local char = getgenv().Character
                local root = getgenv().getRoot(getgenv().Character)
                if not root then return end

                local flatThing = Instance.new("Part")
                flatThing.Name = "ANTI_VOID_BASEPLATE"
                flatThing.Size = Vector3.new(20, 1, 20)
                flatThing.Anchored = true
                flatThing.CanCollide = true
                flatThing.Material = Enum.Material.SmoothPlastic
                flatThing.Color = Color3.fromRGB(107, 50, 124)
                flatThing.Transparency = 0.6

                flatThing.Position = root.Position + Vector3.new(0, getgenv().plateBelowMeOffset or -6, 0)
                flatThing.Parent = workspace

                getgenv().myPlateThingy = flatThing
                return flatThing
            end

            uis.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                if input.KeyCode == Enum.KeyCode.E then
                    upPressed = true
                elseif input.KeyCode == Enum.KeyCode.Q then
                    downPressed = true
                end
            end)

            uis.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.E then
                    upPressed = false
                elseif input.KeyCode == Enum.KeyCode.Q then
                    downPressed = false
                end
            end)

            local function keepItInPlace()
                local plate = putThingUnderMe()

                while getgenv().keepMyPlateOn do
                    local char = getMyCharacter()
                    local root = char and getgenv().getRoot(getgenv().Character)
                    if root and plate then
                        if getgenv().letItFollow then
                            if upPressed then
                                getgenv().plateBelowMeOffset = getgenv().plateBelowMeOffset + floatSpeed
                            elseif downPressed then
                                getgenv().plateBelowMeOffset = getgenv().plateBelowMeOffset - floatSpeed
                            end

                            local howFar = getgenv().plateBelowMeOffset
                            plate.Position = Vector3.new(
                                root.Position.X,
                                root.Position.Y + howFar,
                                root.Position.Z
                            )
                        end
                    end
                    task.wait(0.04)
                end

                if plate then
                    plate:Destroy()
                end
            end

            task.spawn(keepItInPlace)
        else
            getgenv().keepMyPlateOn = false 
            if getgenv().myPlateThingy then
                getgenv().myPlateThingy:Destroy() 
                getgenv().myPlateThingy = nil 
            end
            getgenv().letItFollow = false
        end
    end,})
    wait(0.2)
    if getgenv().Workspace:FindFirstChild("ANTI_VOID_BASEPLATE") then
        if getgenv().AntiVoidPlayer then
            getgenv().AntiVoidPlayer:Set(false)
        else
            warn("getgenv().AntiVoidPlayer doesn't exist in Rayfield UI Library!")
        end
        getgenv().keepMyPlateOn = false
        if getgenv().Character:FindFirstChild("ANTI_VOID_BASEPLATE") then
            getgenv().Character:FindFirstChild("ANTI_VOID_BASEPLATE"):Destroy()
        else
            warn("ANTI_VOID_BASEPLATE was not found inside Character!")
        end
        if getgenv().myPlateThingy then
            getgenv().myPlateThingy = nil
        end
        getgenv().letItFollow = false
    end
    wait(0.1)
    getgenv().AntiVoidTransparency = Tab2:CreateSlider({ 
    Name = "Anti Void BasePlate Transparency",
    Range = {0, 0.9},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0.6,
    Flag = "SlidingTransBasePlate",
    Callback = function(transBasePlate)
        if getgenv().myPlateThingy then
            local Baseplate_AntiVoid = getgenv().myPlateThingy

            Baseplate_AntiVoid.Transparency = transBasePlate
        end
    end,})

    getgenv().Change_Map_Color = Tab2:CreateColorPicker({
    Name = "Anti Void BasePlate Color",
    Color = Color3.fromRGB(107, 50, 124),
    Flag = "PickThatBasePlateColor",
    Callback = function(AntiVoid_Color)
        if getgenv().myPlateThingy then
            local Baseplate_AntiVoid = getgenv().myPlateThingy
            
            Baseplate_AntiVoid.Color = AntiVoid_Color
        end
    end,})

    getgenv().RainbowAntiVoidBasePlate = Tab2:CreateToggle({
    Name = "Rainbow Anti Void Baseplate",
    CurrentValue = false,
    Flag = "GetRainbowPartLmao",
    Callback = function(GetRainbowStateAntiVoid)
        if GetRainbowStateAntiVoid then
            getgenv().parts_rainbow_anti_void = true
            getgenv().parts_rainbow_anti_void = true
            getgenv().rainbowTweenConnection = nil
            
            local TweenService = getgenv().TweenService
            local Workspace = getgenv().Workspace
            local PartStorage = Workspace:FindFirstChild("PartStorage")
            if not PartStorage then return getgenv().notify("Failure:", "PartStorage does not exist in Workspace.", 5) end
            local Baseplate_AntiVoid = getgenv().myPlateThingy

            if not getgenv().myPlateThingy then
                return getgenv().notify("Failure:", "Anti Void Baseplate does not exist.", 5)
            end
            
            if not Baseplate_AntiVoid then
                getgenv().RainbowAntiVoidBasePlate:Set(false)
                getgenv().parts_rainbow_anti_void = false
                return getgenv().notify("Failure", "Anti Void Part does not exist!", 5)
            end
            
            local colors = {
                Color3.fromRGB(0, 0, 255),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(0, 255, 0),
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(0, 0, 0),
                Color3.fromRGB(255, 165, 0),
                Color3.fromRGB(0, 255, 255),
                Color3.fromRGB(255, 255, 0),
                Color3.fromRGB(139, 69, 19)
            }
            
            local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local index = 1
            
            local function cycleColor()
                if not getgenv().parts_rainbow_anti_void then
                    return getgenv().notify("Stopped", "AntiVoid BasePlate rainbow loop disabled.", 6)
                end
            
                local nextIndex = (index % #colors) + 1
                local goal = { Color = colors[nextIndex] }
            
                local tween = TweenService:Create(Baseplate_AntiVoid, tweenInfo, goal)
                tween:Play()

                if getgenv().rainbowTweenConnection then
                    getgenv().rainbowTweenConnection:Disconnect()
                end
            
                getgenv().rainbowTweenConnection = tween.Completed:Connect(function()
                    if getgenv().parts_rainbow_anti_void then
                        index = nextIndex
                        cycleColor()
                    else
                        getgenv().rainbowTweenConnection:Disconnect()
                        getgenv().rainbowTweenConnection = nil
                    end
                end)
            end
            
            cycleColor()
        else
            getgenv().parts_rainbow_anti_void = false
            wait()
            if getgenv().rainbowTweenConnection then
                getgenv().rainbowTweenConnection:Disconnect()
                getgenv().rainbowTweenConnection = nil
            end
        end
    end,})
    if getgenv().parts_rainbow_anti_void == true then
        getgenv().AntiVoidPlayer:Set(false)
        if getgenv().rainbowTweenConnection then
            getgenv().rainbowTweenConnection:Disconnect()
            getgenv().rainbowTweenConnection = nil
        end
    end
    task.wait(0.2)
    if getgenv().AntiVoidPlayer then
        getgenv().AntiVoidPlayer:Set(false)
    end
    wait(0.1)
    getgenv().Baseplate_Exists = false
    if getgenv().AntiVoidTransparency then
        getgenv().AntiVoidTransparency = nil
    end
    if getgenv().Change_Map_Color then
        getgenv().Change_Map_Color = nil
    end
    wait()
    getgenv().RainbowBaseplate_Speed_Value = getgenv().RainbowBaseplate_Speed_Value or 0.5
    getgenv().RainbowSpeed = getgenv().RainbowSpeed or 2

    getgenv().RainbowBaseplateSliderSpeed = Tab22:CreateSlider({
    Name = "Rainbow Baseplate Speed",
    Range = {0, 6},
    Increment = 1,
    Suffix = "",
    CurrentValue = tonumber(getgenv().RainbowSpeed),
    Flag = "ezSmoothColorTransitioning",
    Callback = function(flashingButSmoothening)
        getgenv().RainbowSpeed = flashingButSmoothening
    end,})

    getgenv().SmoothTweenBaseplateRainbow = Tab22:CreateToggle({
    Name = "Rainbow Baseplate",
    CurrentValue = false,
    Flag = "enableSmoothTweeningRainbowBaseplate",
    Callback = function(turnOnRGBPart)
        if turnOnRGBPart then
            local TweenService = getgenv().TweenService
            local Workspace = getgenv().Workspace
            local TerrainFolder = Workspace:FindFirstChild("TERRAIN_EDITOR") or Instance.new("Folder", Workspace)
            TerrainFolder.Name = "TERRAIN_EDITOR"

            getgenv().smooth_rainbow = true

            local colors = {
                Color3.fromRGB(0, 255, 255),
                Color3.fromRGB(0, 0, 0),
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(128, 128, 128),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(255, 105, 180),
                Color3.fromRGB(75, 0, 130),
                Color3.fromRGB(50, 205, 50),
                Color3.fromRGB(255, 20, 147),
                Color3.fromRGB(138, 54, 15),
                Color3.fromRGB(191, 64, 191),
                Color3.fromRGB(255, 215, 0),
                Color3.fromRGB(255, 140, 0)
            }

            local colorIndex = 1

            local function applyTweenColor(part, newColor)
                local tweenInfo = TweenInfo.new(getgenv().RainbowSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local tween = TweenService:Create(part, tweenInfo, { Color = newColor })
                tween:Play()
            end

            local function updateColors()
                while getgenv().smooth_rainbow == true do
                    local newColor = colors[colorIndex]
                    for _, v in ipairs(TerrainFolder:GetDescendants()) do
                        if v:IsA("BasePart") then
                            applyTweenColor(v, newColor)
                        end
                    end
                    colorIndex = (colorIndex % #colors) + 1
                    task.wait(getgenv().RainbowSpeed)
                end
            end

            task.spawn(updateColors)
        else
            getgenv().smooth_rainbow = false
            wait(0.1)
            getgenv().smooth_rainbow = false
            wait(0.3)
            for i = 1, 20 do
                getgenv().smooth_rainbow = false
            end
        end
    end,})

    getgenv().BaseplateCollisionToggle = Tab22:CreateToggle({
    Name = "Baseplate Collision",
    CurrentValue = false,
    Flag = "ToggleBaseplateCollision",
    Callback = function(parts_collision)
        if parts_collision then
            local Workspace = getgenv().Workspace
            local TerrainFolder = Workspace:FindFirstChild("TERRAIN_EDITOR") or Instance.new("Folder", Workspace)
            TerrainFolder.Name = "TERRAIN_EDITOR"
            getgenv().no_baseplate_collision = true
            for _, v in ipairs(TerrainFolder:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        else
            getgenv().no_baseplate_collision = false
            wait(0.2)
            local Workspace = getgenv().Workspace
            local TerrainFolder = Workspace:FindFirstChild("TERRAIN_EDITOR") or Instance.new("Folder", Workspace)
            TerrainFolder.Name = "TERRAIN_EDITOR"
            for _, v in ipairs(TerrainFolder:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end,})
    wait(0.1)
    if getgenv().no_baseplate_collision == true then
        getgenv().BaseplateCollisionToggle:Set(false)
        getgenv().no_baseplate_collision = false
    end

    getgenv().ColorPickerForBaseplate = Tab22:CreateColorPicker({
    Name = "Baseplate Color Picker",
    Color = Color3.fromRGB(60, 60, 60),
    Flag = "TerrainPartColorChooser",
    Callback = function(colorTheySelected)
        local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
        local TerrainFolder = Workspace:FindFirstChild("TERRAIN_EDITOR") or Instance.new("Folder", Workspace)
        TerrainFolder.Name = "TERRAIN_EDITOR"

        local targetColor = colorTheySelected
        local convert_target_color = BrickColor.new(targetColor)

        for _, v in ipairs(TerrainFolder:GetDescendants()) do
            if v:IsA("BasePart") then
                v.BrickColor = convert_target_color
            end
        end
    end,})

    getgenv().TransparencySelectorForBaseplate = Tab22:CreateSlider({
    Name = "Baseplate Transparency",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "transSelectorForBaseplate",
    Callback = function(sliderTransparencySelected)
        local Workspace = getgenv().Workspace
        local TerrainFolder = Workspace:FindFirstChild("TERRAIN_EDITOR") or Instance.new("Folder", Workspace)
        TerrainFolder.Name = "TERRAIN_EDITOR"

        local Transparency_Selected = sliderTransparencySelected

        for _, v in ipairs(TerrainFolder:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = Transparency_Selected
            end
        end
    end,})
    wait()
    print("Loading MIC UP Features...")
    wait()
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().coloredBooth = Tab11:CreateToggle({
        Name = "Booth Color Changer (FE)",
        CurrentValue = false,
        Flag = "moveColoredBooth",
        Callback = function(boothColors)
            if boothColors then
                local fontsList = {
                    "SourceSans",
                }

                local Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")

                local function getStall()
                    for _, v in pairs(Folder:GetChildren()) do
                        local usernameGui = v:FindFirstChild("Username") and v.Username:FindFirstChild("BillboardGui")
                        if usernameGui and usernameGui.TextLabel.Text == "Owned by: " .. tostring(getgenv().LocalPlayer.Name) then
                            return v
                        end
                    end
                    return nil
                end

                local booth_exists = getStall()
                local booth_text_more_colors

                if booth_exists then
                    booth_text_more_colors = getStall():FindFirstChild("Text"):FindFirstChild("SurfaceGui"):FindFirstChild("TextLabel").Text
                    getgenv().other_booth_texting_bruh = tostring(booth_text_more_colors)
                else
                    booth_text_more_colors = ""
                    getgenv().other_booth_texting_bruh = tostring(booth_text_more_colors)
                end
                wait()
                local function pickRandomFont()
                    local randomIndex = math.random(1, #fontsList)
                    return fontsList[randomIndex]
                end

                getgenv().lmao_colors = true
                while getgenv().lmao_colors == true do
                wait(0.4)
                    local args = {
                        [1] = getgenv().other_booth_texting_bruh,
                        [2] = "Teal",
                        [3] = tostring(pickRandomFont())
                    }

                    getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
                    wait(0.2)
                    local args = {
                        [1] = getgenv().other_booth_texting_bruh,
                        [2] = "Red",
                        [3] = tostring(pickRandomFont())
                    }

                    getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
                    wait(0.2)
                    local args = {
                        [1] = getgenv().other_booth_texting_bruh,
                        [2] = "Gray",
                        [3] = tostring(pickRandomFont())
                    }

                    getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
                    wait(0.2)
                    local args = {
                        [1] = getgenv().other_booth_texting_bruh,
                        [2] = "Cinder",
                        [3] = tostring(pickRandomFont())
                    }
                    
                    getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
                    wait(0.2)
                    local args = {
                        [1] = getgenv().other_booth_texting_bruh,
                        [2] = "Lace",
                        [3] = tostring(pickRandomFont())
                    }
                    
                    getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
                    wait(0.2)
                    local args = {
                        [1] = getgenv().other_booth_texting_bruh,
                        [2] = "Sun",
                        [3] = tostring(pickRandomFont())
                    }
                    
                    getgenv().ReplicatedStorage:WaitForChild("UpdateBoothText"):FireServer(unpack(args))
                    wait(0.2)
                    local args = {
                        [1] = getgenv().other_booth_texting_bruh,
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
            local Players = getgenv().Players
            local ReplicatedStorage = getgenv().ReplicatedStorage
            local Workspace = getgenv().Workspace
            local LocalPlayer = getgenv().LocalPlayer
            local Character = getgenv().Character
            local HumanoidRootPart = getgenv().getRoot(getgenv().Character)
            
            local function findPlrBooth(player)
                for _, booth in pairs(Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
                    local usernameLabel = booth:FindFirstChild("Username") and booth.Username:FindFirstChild("BillboardGui") and booth.Username.BillboardGui:FindFirstChild("TextLabel")
                    if usernameLabel and usernameLabel.Text == "Owned by: "..tostring(player) then
                        return booth
                    end
                end
                return nil
            end
            wait()
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
            local Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
            local find_plr_func_booth = findplr(unclaimTheirBooth)

            if getgenv().boothWhitelistingPlayer and getgenv().boothWhitelistingPlayer[find_plr_func_booth] then
                return getgenv().notify("Failure", "This user is on the Booth Whitelist!", 6)
            end

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
                for i,v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
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

            local Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")

            local OldCF = getgenv().Character:FindFirstChildWhichIsA("Humanoid").CFrame

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
                local OldCF = getgenv().Character:FindFirstChildWhichIsA("Humanoid").CFrame

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
                    getgenv().getRoot(getgenv().Character).CFrame = OldCF
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

        getgenv().BoothNoclipperCollision = Tab11:CreateToggle({
        Name = "Booths Collisions",
        CurrentValue = false,
        Flag = "NoClippingBooths",
        Callback = function(noclip_the_booths)
            if noclip_the_booths then
                for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
                    if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" then
                        v.CanCollide = true
                    end
                end
            else
                for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
                    if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" then
                        v.CanCollide = false
                    end
                end
            end
        end,})
        wait()
        for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" then
                v.CanCollide = true
            end
        end
        wait()
        getgenv().BoothTransparency = Tab11:CreateSlider({
        Name = "Booth Transparency",
        Range = {0, 1},
        Increment = 0.1,
        Suffix = "",
        CurrentValue = 0,
        Flag = "booth_transparency_values",
        Callback = function(transparency_value_booths)
            for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" and v.Name ~= "Edit" then
                    v.Transparency = transparency_value_booths
                end
            end
            task.wait()
            for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
                if v:IsA("TextLabel") then
                    v.TextTransparency = transparency_value_booths
                end
            end
            task.wait()
            if transparency_value_booths == 1 then
                for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Activate") then
                        v:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt").Enabled = false
                    end
                end
            else
                for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Activate") then
                        v:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt").Enabled = true
                    end
                end
            end
        end,})
        wait(0.1)
        if getgenv().Workspace:FindFirstChild("Map") then
            if getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth") then
                for _, v in ipairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Activate") then
                        v:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt").Enabled = true
                    end
                end
            else
                warn("Booth doesn't exist in Map in Workspace!")
            end
        else
            warn("Map doesn't exist in Workspace!")
        end
        wait()
        getgenv().CopyAPlayersAv = Tab2:CreateInput({
        Name = "Copy Player Avatar",
        PlaceholderText = "Player",
        RemoveTextAfterFocusLost = true,
        Callback = function(copyUserAvatar)
            local findAPlayerToCopy = findplr(copyUserAvatar)
            if not getgenv().PlayerGui:FindFirstChild("Menu") then return end
            local CopyToggleToButton = getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle")
            -- Bet you ain't never seen a proper check like this in other MIC UP scripts, it ACTUALLY checks if your allowing users to copy your avatar, and sets it for you if it's disabled/off, and if it is on, it does nothing :)
            if CopyToggleToButton:FindFirstChild("TextButton") and CopyToggleToButton:FindFirstChild("TextButton").Text == "No" and firesignal then
                local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
                local CopyToggleToButton = getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle")

                for _,v in pairs(CopyToggleToButton:GetDescendants()) do
                    if v:IsA("ImageButton") or v:IsA("TextButton") then
                        for i,Signal in pairs(Signals) do
                            firesignal(v[Signal])
                        end
                    end
                end
            elseif not firesignal and CopyToggleToButton:FindFirstChild("TextButton") and CopyToggleToButton:FindFirstChild("TextButton").Text == "No" then
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundColor3 = Color3.new(0.168627, 0.521569, 0.552941)
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundTransparency = 0
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").Text = "Yes"
                getgenv().ReplicatedStorage:FindFirstChild("ToggleDisallowEvent"):FireServer()
            end
            wait(0.2)
            if not findAPlayerToCopy and CopyToggleToButton:FindFirstChild("TextButton") and CopyToggleToButton:FindFirstChild("TextButton").Text == "Yes" then
                local args = {
                    [1] = tostring(copyUserAvatar)
                }

                getgenv().ReplicatedStorage:WaitForChild("ModifyUsername"):FireServer(unpack(args))
            elseif CopyToggleToButton:FindFirstChild("TextButton") and CopyToggleToButton:FindFirstChild("TextButton").Text == "Yes" then
                local args = {
                    [1] = tostring(findAPlayerToCopy)
                }
                
                getgenv().ReplicatedStorage:WaitForChild("ModifyUserEvent"):FireServer(unpack(args))
            end
        end,})

        getgenv().GoBackToNormalAvatar = Tab2:CreateButton({
        Name = "Change Back To Regular Avatar",
        Callback = function()
            if not getgenv().PlayerGui:FindFirstChild("Menu") then
                return getgenv().notify("Failure", "Menu GUI not found in PlayerGui, probably removed.", 5)
            end
            wait()
            local CopyToggleToButton = getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle")
            
            if firesignal and CopyToggleToButton:FindFirstChild("TextButton") and CopyToggleToButton:FindFirstChild("TextButton").Text == "Yes" then
                local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
                local CopyToggleToButton = getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle")

                for _,v in pairs(CopyToggleToButton:GetDescendants()) do
                    if v:IsA("ImageButton") or v:IsA("TextButton") then
                        for i,Signal in pairs(Signals) do
                            firesignal(v[Signal])
                        end
                    end
                end
            elseif not firesignal and CopyToggleToButton:FindFirstChild("TextButton") and CopyToggleToButton:FindFirstChild("TextButton").Text == "Yes" then -- Bet you all those other scripts don't make checks like these.
                getgenv().ReplicatedStorage:FindFirstChild("ToggleDisallowEvent"):FireServer()
                wait(0.1)
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundColor3 = Color3.fromRGB(47, 47, 47)
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundTransparency = 0.9
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").Text = "No"
            end
            wait(0.1)
            if CopyToggleToButton:FindFirstChild("TextButton").Text == "Yes" then
                getgenv().ReplicatedStorage:FindFirstChild("ToggleDisallowEvent"):FireServer()
                wait(0.1)
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundColor3 = Color3.fromRGB(47, 47, 47)
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundTransparency = 0.9
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").Text = "No"
                wait(0.5)
                local args = {
                    [1] = tostring(getgenv().LocalPlayer.Name)
                }
                
                getgenv().ReplicatedStorage:WaitForChild("ModifyUsername"):FireServer(unpack(args))
                wait(0.3)
                local args = {
                    [1] = tostring(getgenv().LocalPlayer.Name)
                }
                
                getgenv().ReplicatedStorage:WaitForChild("ModifyUserEvent"):FireServer(unpack(args))
            else
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundColor3 = Color3.fromRGB(47, 47, 47)
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundTransparency = 0.9
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").Text = "No"
                wait(0.5)
                local args = {
                    [1] = tostring(getgenv().LocalPlayer.Name)
                }
                
                getgenv().ReplicatedStorage:WaitForChild("ModifyUsername"):FireServer(unpack(args))
                local args = {
                    [1] = tostring(getgenv().LocalPlayer.Name)
                }
                
                getgenv().ReplicatedStorage:WaitForChild("ModifyUserEvent"):FireServer(unpack(args))
            end
        end,})
    else
        warn("Did not load these Booth tabs [2].")
    end

    getgenv().WalkSpeedBypass = Tab1:CreateButton({
    Name = "[AntiCheats]: WalkSpeed/JumpPower Bypass",
    Callback = function()
        if hookmetamethod then
            getgenv().notify("Wait.", "We are initializing the WalkSpeed bypass...", 5)
            wait(0.3)
            local lp = game:FindService("Players").LocalPlayer
            local hooks = {
                walkspeed = 16,
                jumppower = 50
            }
            local index
            local newindex

            index = hookmetamethod(game,"__index",function(self,property)
                if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
                    return hooks[property:lower()]
                end
                return index(self,property)
            end)

            newindex = hookmetamethod(game,"__newindex",function(self,property,value)
                if not checkcaller() and self:IsA("Humanoid") and self:IsDescendantOf(lp.Character) and hooks[property:lower()] then
                    return value
                end
                return newindex(self,property,value)
            end)
            wait(0.1)
            getgenv().notify("Success!", "Successfully applied WalkSpeed anti-cheat bypass.")
        else
            return getgenv().notify("Failure:", "Your exploit is unsupported, and cannot use WalkSpeed Bypass.", 5)
        end
    end,})

    getgenv().WalkSpeedSpooferBypass = Tab1:CreateButton({
    Name = "[AntiCheats]: Full WalkSpeed Spoofer and Bypass",
    Callback = function()
        if not hookmetamethod then
            return getgenv().notify("Failure:", "Your exploit does not support 'hookmetamethod'!", 5)
        end
        if not cloneref then
            return getgenv().notify("Failure:", "Your exploit does not support 'cloneref'", 5)
        end
        wait(0.2)
        if hookmetamethod and cloneref then
            getgenv().notify("Waiting:", "Initiating spoof and bypass process...", 5)
            task.wait(0.3)
            local WalkSpeedSpoof = getgenv().WalkSpeedSpoof
            local Disable = WalkSpeedSpoof and WalkSpeedSpoof.Disable
            if Disable then
                Disable()
            end

            local cloneref = cloneref or function(...)
                return ...
            end

            local WalkSpeedSpoof = {}

            local Players = cloneref(game:GetService("Players"))
            if not Players.LocalPlayer then
                Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            end
            local lp = cloneref(Players.LocalPlayer)

            local split = string.split

            local GetDebugIdHandler = Instance.new("BindableFunction")
            local TempHumanoid = Instance.new("Humanoid")

            local cachedhumanoids = {}

            local CurrentHumanoid
            local newindexhook
            local indexhook

            function GetDebugIdHandler.OnInvoke(obj: Instance): string
                return obj:GetDebugId()
            end

            local function GetDebugId(obj: Instance): string
                return GetDebugIdHandler:Invoke(obj)
            end

            local function GetWalkSpeed(obj: any): number
                TempHumanoid.WalkSpeed = obj
                return TempHumanoid.WalkSpeed
            end

            function cachedhumanoids:cacheHumanoid(DebugId: string,Humanoid: Humanoid)
                cachedhumanoids[DebugId] = {
                    currentindex = indexhook(Humanoid,"WalkSpeed"),
                    lastnewindex = nil
                }
                return self[DebugId]
            end

            indexhook = hookmetamethod(game,"__index",function(self,index)
                if not checkcaller() and typeof(self) == "Instance" then
                    if self:IsA("Humanoid") then
                        local DebugId = GetDebugId(self)
                        local cached = cachedhumanoids[DebugId]

                        if self:IsDescendantOf(lp.Character) or cached then
                            if type(index) == "string" then
                                local cleanindex = split(index,"\0")[1]

                                if cleanindex == "WalkSpeed" then
                                    if not cached then
                                        cached = cachedhumanoids:cacheHumanoid(DebugId,self)
                                    end

                                    if not (CurrentHumanoid and CurrentHumanoid:IsDescendantOf(game)) then
                                        CurrentHumanoid = cloneref(self)
                                    end

                                    return cached.lastnewindex or cached.currentindex
                                end
                            end
                        end
                    end
                end

                return indexhook(self,index)
            end)

            newindexhook = hookmetamethod(game,"__newindex",function(self,index,newindex)
                if not checkcaller() and typeof(self) == "Instance" then
                    if self:IsA("Humanoid") then
                        local DebugId = GetDebugId(self)
                        local cached = cachedhumanoids[DebugId]

                        if self:IsDescendantOf(lp.Character) or cached then
                            if type(index) == "string" then
                                local cleanindex = split(index,"\0")[1]

                                if cleanindex == "WalkSpeed" then
                                    if not cached then
                                        cached = cachedhumanoids:cacheHumanoid(DebugId,self)
                                    end

                                    if not (CurrentHumanoid and CurrentHumanoid:IsDescendantOf(game)) then
                                        CurrentHumanoid = cloneref(self)
                                    end
                                    cached.lastnewindex = GetWalkSpeed(newindex)
                                    return CurrentHumanoid.WalkSpeed
                                end
                            end
                        end
                    end
                end
                
                return newindexhook(self,index,newindex)
            end)

            function WalkSpeedSpoof:Disable()
                WalkSpeedSpoof:RestoreWalkSpeed()
                hookmetamethod(game,"__index",indexhook)
                hookmetamethod(game,"__newindex",newindexhook)
                GetDebugIdHandler:Destroy()
                TempHumanoid:Destroy()
                table.clear(WalkSpeedSpoof)
                getgenv().WalkSpeedSpoof = nil
            end

            function WalkSpeedSpoof:GetHumanoid()
                return CurrentHumanoid or (function()
                    local char = lp.Character
                    local Humanoid = char and char:FindFirstChildWhichIsA("Humanoid") or nil
                    
                    if Humanoid then
                        cachedhumanoids:cacheHumanoid(Humanoid:GetDebugId(),Humanoid)
                        return cloneref(Humanoid)
                    end
                end)()
            end

            function WalkSpeedSpoof:SetWalkSpeed(speed)
                local Humanoid = WalkSpeedSpoof:GetHumanoid()

                if Humanoid then
                    local connections = {}
                    local function AddConnectionsFromSignal(Signal)
                        for i,v in getconnections(Signal) do
                            if v.State then
                                v:Disable()
                                table.insert(connections,v)
                            end
                        end
                    end
                    AddConnectionsFromSignal(Humanoid.Changed)
                    AddConnectionsFromSignal(Humanoid:GetPropertyChangedSignal("WalkSpeed"))
                    Humanoid.WalkSpeed = speed
                    for i,v in connections do
                        v:Enable()
                    end
                end
            end

            function WalkSpeedSpoof:RestoreWalkSpeed()
                local Humanoid = WalkSpeedSpoof:GetHumanoid()
                
                if Humanoid then
                    local cached = cachedhumanoids[Humanoid:GetDebugId()]

                    if cached then
                        WalkSpeedSpoof:SetWalkSpeed(cached.lastnewindex or cached.currentindex)
                    end
                end
            end

            getgenv().WalkSpeedSpoof = WalkSpeedSpoof
            wait(0.2)
            getgenv().notify("Done!", "Successfully loaded WalkSpeed spoof and bypass.", 5)
        end
    end,})

    local function disable_connection(propertyName)
        local signal = getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPropertyChangedSignal(propertyName)
        for _, conn in ipairs(getconnections(signal)) do
            conn:Disable()
        end
    end

    getgenv().CameraMaxZoomDistance = Tab5:CreateSlider({
    Name = "Max Zoom Distance",
    Range = {25, 100000},
    Increment = 1,
    Suffix = "",
    CurrentValue = 500,
    Flag = "EditMaxZoomDistance",
    Callback = function(max_zoom_distance)
        getgenv().LocalPlayer.CameraMaxZoomDistance = max_zoom_distance
    end,})

    getgenv().CameraMinZoomDistance = Tab5:CreateSlider({
    Name = "Min Zoom Distance",
    Range = {0.5, 500},
    Increment = 0.5,
    Suffix = "",
    CurrentValue = 0.5,
    Flag = "MinZoomDistanceEditing",
    Callback = function(min_zoom_distance)
        getgenv().LocalPlayer.CameraMinZoomDistance = min_zoom_distance
    end,})

    getgenv().Spoof_Zoom_Script = Tab5:CreateToggle({
    Name = "Spoof MaxZoomDistance",
    CurrentValue = false,
    Flag = "SpoofingZoomLoop",
    Callback = function(zoom_spoofed)
        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
        local Old_Min_Zoom_Distance = Players.LocalPlayer.CameraMinZoomDistance
        local Old_Max_Zoom_Distance = Players.LocalPlayer.CameraMaxZoomDistance
        wait(0.1)
        if zoom_spoofed then
           getgenv().inf_zoom_always = true
            while getgenv().inf_zoom_always == true do
            task.wait()
                getgenv().LocalPlayer.CameraMinZoomDistance = 0
                getgenv().LocalPlayer.CameraMaxZoomDistance = 1000000
            end
        else
            getgenv().inf_zoom_always = false
            getgenv().LocalPlayer.CameraMinZoomDistance = Old_Min_Zoom_Distance
            getgenv().LocalPlayer.CameraMaxZoomDistance = Old_Max_Zoom_Distance
        end
    end,})

    getgenv().Spoof_Custom_Anims = Tab5:CreateToggle({
    Name = "Allow Custom Animations",
    CurrentValue = false,
    Flag = "CustomAnimPackagesSpoof",
    Callback = function(anims_spoofed)
        if anims_spoofed then
            getgenv().are_animations_spoofed = true
            while getgenv().are_animations_spoofed == true do
            wait()
                getgenv().StarterPlayer.AllowCustomAnimations = true
            end
        else
            getgenv().are_animations_spoofed = false
            wait(0.3)
            if getgenv().are_animations_spoofed == false then
                getgenv().notify("Hang On:", "Resetting AllowCustomAnimations...", 5)
                getgenv().StarterPlayer.AllowCustomAnimations = false
                wait(1)
                if getgenv().StarterPlayer.AllowCustomAnimations == false then
                    getgenv().notify("Success:", "AllowCustomAnimations has been disabled.", 5)
                end
            else
                getgenv().notify("Hold On:", "Waiting for loop to shutdown to disable AllowCustomAnimations.", 5)
                wait(2)
                if getgenv().are_animations_spoofed == false then
                    getgenv().notify("Success:", "Resetting AllowCustomAnimations...", 5)
                    getgenv().StarterPlayer.AllowCustomAnimations = false
                end
            end
        end
    end,})

    getgenv().JumpingConnectionsBypass = Tab1:CreateButton({
    Name = "[AntiCheats]: JumpPower/JumpHeight Bypass (Connections method)",
    Callback = function()
        if getconnections then
            disable_connection("JumpPower")
            disable_connection("JumpHeight")
            getgenv().notify("Success:", "Disabled connections for JumpPower/JumpHeight!", 5)
        else
            return getgenv().notify("Failure:", "Your executor does not support 'getconnections'!", 5)
        end
    end,})

    getgenv().GravityConnectionsBypass = Tab1:CreateButton({
    Name = "Gravity Bypass (Connections method)",
    Callback = function()
        if getconnections then
            getgenv().notify("Wait:", "Disabling Gravity connections...", 5)
            task.wait(0.3)
            local function grav_connections()
                for _, conn in ipairs(getconnections(getgenv().Workspace:GetPropertyChangedSignal("Gravity"))) do
                    conn:Disable()
                end
            end
            
            wait(0.3)
            grav_connections()
            wait(0.3)
            getgenv().notify("Success:", "We have applied Gravity bypass (disabled connection).", 5)
        end
    end,})

    getgenv().JumpingHeartbeatConnections = Tab1:CreateButton({
    Name = "[AntiCheats]: WalkSpeed/JumpPower/JumpHeight Bypass (Heartbeat)",
    Callback = function()
        if getrawmetatable and newcclosure then
            getgenv().notify("Wait:", "Loading Heartbeat bypass...", 5)
            task.wait(0.3)
            local spoofedWalkSpeed = 16
            local spoofedJumpPower = 50
            local spoofedJumpHeight = 7.2

            local mt = getrawmetatable(game)
            setreadonly(mt, false)

            local oldIndex = mt.__index
            mt.__index = newcclosure(function(self, key)
                if typeof(self) == "Instance" and self:IsA("Humanoid") then
                    if key == "WalkSpeed" then
                        return spoofedWalkSpeed
                    elseif key == "JumpPower" then
                        return spoofedJumpPower
                    elseif key == "JumpHeight" then
                        return spoofedJumpHeight
                    end
                end
                return oldIndex(self, key)
            end)
            wait(0.2)
            getgenv().notify("Success:", "Successfully loaded Heartbeat bypass.", 5)
        else
            return getgenv().notify("Failure:", "Your executor does not support 'getrawmetatable' or 'newcclosure'!", 5)
        end
    end,})

    getgenv().FlyBypassConnections = Tab1:CreateButton({
    Name = "[AntiCheats]: Fly Bypass (Connections method)",
    Callback = function()
        if getconnections then
            getgenv().notify("Wait:", "Loading Fly Bypass, disabling connections...", 5)
            task.wait(0.3)
            local physicsInstances = {
                BodyVelocity = true,
                BodyGyro = true,
                BodyPosition = true,
                BodyForce = true,
                BodyAngularVelocity = true,
                AlignPosition = true,
                AlignOrientation = true,
                VectorForce = true,
                RocketPropulsion = true
            }

            local function disable_signal_conns(instance, signal_string)
                local signal = instance[signal_string]
                if typeof(signal) == "RBXScriptSignal" then
                    for _, conn in ipairs(getconnections(signal)) do
                        conn:Disable()
                    end
                end
            end

            local function patch_char(char)
                disable_signal_conns(char, "DescendantAdded")
                disable_signal_conns(getgenv().getRoot(getgenv().Character), "DescendantAdded")

                for _, v in ipairs(char:GetDescendants()) do
                    disable_signal_conns(v, "ChildAdded")
                end
            end

            if getgenv().LocalPlayer.Character then
                getgenv().notify("Loading...", "Now patching up Character connections...", 5)
                task.wait(0.5)
                patch_char(getgenv().Character)
                wait(0.3)
                getgenv().notify("Success:", "We have successfully applied Fly Bypass.", 5)
            else
                return getgenv().notify("Failure:", "It seems as if your Character hasn't loaded, wait!", 5)
            end
        else
            return getgenv().notify("Failure:", "Your executor does not support 'getconnections'!", 5)
        end
    end,})

    local Anti_Sit_Connection
    wait(0.1)
    getgenv().AntiSit_Func = Tab2:CreateToggle({
    Name = "Anti Sit",
    CurrentValue = false,
    Flag = "noSittingDown",
    Callback = function(theSitDownAntiToggle)
        getgenv().No_Sitting_Connection = nil

        if theSitDownAntiToggle then
            local function handle_seat(seat)
                if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
                    seat.CanCollide = false
                    seat.Disabled = true
                    seat:SetAttribute("Disabled", true)
                end
            end
            wait()
            getgenv().Anti_Sit_Enabled = true
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            task.wait(0.1)
            getgenv().No_Sitting_Connection = getgenv().Workspace.DescendantAdded:Connect(function(v)
                if getgenv().Anti_Sit_Enabled then
                    handle_seat(v)
                end
            end)
        else
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            getgenv().Anti_Sit_Enabled = false

            if getgenv().No_Sitting_Connection then
                getgenv().No_Sitting_Connection:Disconnect()
                getgenv().No_Sitting_Connection = nil
            end
            wait(0.2)
            for _, v in ipairs(getgenv().Workspace:GetDescendants()) do
                if v:IsA("Seat") or v:IsA("VehicleSeat") then
                    v.CanCollide = true
                    v.Disabled = false
                    v:SetAttribute("Disabled", false)
                end
            end
        end
    end,})
    wait()
    if getgenv().disabled_sit_function == true then
        getgenv().AntiSit_Func:Set(false)
        getgenv().disabled_sit_function = false
    end

    getgenv().HD_FlyEnabled = false
    local FlyConnection
    local speed = 50

    function DisableFlyScript()
        getgenv().HD_FlyEnabled = false

        if FlyConnection then
            FlyConnection:Disconnect()
            FlyConnection = nil
        end

        local hrp = getgenv().getRoot(getgenv().Character) or getgenv().HumanoidRootPart
        if hrp:FindFirstChild("ExecutorFlyGyro") then
            hrp.ExecutorFlyGyro:Destroy()
        end
        if hrp:FindFirstChild("ExecutorFlyPosition") then
            hrp.ExecutorFlyPosition:Destroy()
        end

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
        end
    end
    wait(0.1)
    getgenv().Disable_Flying_Script_HDAdmin = DisableFlyScript

    local HDAdmin_Found = false
    local HDAdmin_Directory = nil
    local flyEnabled = false
    wait(0.2)
    function search_for_HDAdmin_Module()
        for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
            if v:IsA("Folder") and v.Name == "HDAdminClient" then
                HDAdmin_Directory = v
                HDdmin_Found = true
            end
        end
        wait()
        for _, k in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
            if k:IsA("Folder") and k.Name == "HDAdminHDClient" then
                HDAdmin_Directory = k
                HDdmin_Found = true
            end
        end
        wait()
        for _, v in ipairs(getgenv().Workspace:GetChildren()) do
            if v:IsA("Folder") and v.Name == "HDAdminClient" then
                HDAdmin_Directory = v
                HDdmin_Found = true
            end
        end
        wait()
        for _, k in ipairs(getgenv().Workspace:GetDescendants()) do
            if k:IsA("Folder") and k.Name == "HDAdminHDClient" then
                HDAdmin_Directory = k
                HDdmin_Found = true
            end
        end
    end
    wait()
    search_for_HDAdmin_Module()
    wait(0.1)
    local anti_fling_toggle_saved = false
    local anti_teleport_toggle_saved = false
    wait(0.2)
    getgenv().HDAdminFly = Tab2:CreateToggle({
    Name = "HD Admin Fly (FE!)",
    CurrentValue = false,
    Flag = "FlyHDAdmin",
    Callback = function(toggle_hd_fly)
        if toggle_hd_fly then
            if getgenv().antiFlingEnabled == true then
                anti_fling_toggle_saved = true
                if getgenv().AntiFlingToggle then
                    getgenv().AntiFlingToggle:Set(false)
                    getgenv().notify("Alert:", "Turned off Anti Fling for 'Fly' to work properly.", 6)
                else
                    return getgenv().notify("Error:", "Please disable 'Anti Fling' for 'Fly' to work properly", 6)
                end
            else
                anti_fling_toggle_saved = false
            end
            wait()
            if getgenv().AntiTeleport == true then
                anti_teleport_toggle_saved = true
                if getgenv().AntiTeleport_Univ then
                    getgenv().AntiTeleport_Univ:Set(false)
                    getgenv().notify("Alert:", "Turned off Anti Teleport for 'Fly' to work properly.", 6)
                else
                    return getgenv().notify("Error:", "Please disable 'Anti Teleport' for 'Fly' to work properly.", 6)
                end
            else
                anti_fling_toggle_saved = false
            end

            local xeno_level_executor = low_level_executor()

            if HDAdmin_Found == false and xeno_level_executor == true then
                getgenv().notify("Note:", "E = Fly Up | Q = Fly Down.", 10)
                getgenv().HD_FlyEnabled = true

                local Players = getgenv().Players
                local RunService = getgenv().RunService
                local UserInputService = getgenv().UserInputService
                local Workspace = getgenv().Workspace

                local LocalPlayer = getgenv().LocalPlayer
                repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                local Character = getgenv().Character
                local HRP = getgenv().getRoot(getgenv().Character)
                local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                local Camera = getgenv().Camera

                local KeysDown = {
                    W = false,
                    A = false,
                    S = false,
                    D = false,
                    E = false,
                    Q = false,
                }

                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    local key = input.KeyCode
                    if KeysDown[key.Name] ~= nil then
                        KeysDown[key.Name] = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    local key = input.KeyCode
                    if KeysDown[key.Name] ~= nil then
                        KeysDown[key.Name] = false
                    end
                end)

                local function GetInputDirection(cam)
                    local dir = Vector3.zero
                    if KeysDown.W then dir += cam.CFrame.LookVector end
                    if KeysDown.S then dir -= cam.CFrame.LookVector end
                    if KeysDown.D then dir += cam.CFrame.RightVector end
                    if KeysDown.A then dir -= cam.CFrame.RightVector end
                    if KeysDown.E then dir += cam.CFrame.UpVector end
                    if KeysDown.Q then dir -= cam.CFrame.UpVector end
                    return dir.Magnitude > 0 and dir.Unit or Vector3.zero
                end

                local function ToggleFly()
                    local bodyGyro = Instance.new("BodyGyro")
                    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                    bodyGyro.P = 4000
                    bodyGyro.D = 150
                    bodyGyro.CFrame = HRP.CFrame
                    bodyGyro.Name = "ExecutorFlyGyro"
                    bodyGyro.Parent = HRP

                    local bodyPos = Instance.new("BodyPosition")
                    bodyPos.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                    bodyPos.P = 7500
                    bodyPos.D = 1000
                    bodyPos.Position = HRP.Position
                    bodyPos.Name = "ExecutorFlyPosition"
                    bodyPos.Parent = HRP

                    Humanoid.PlatformStand = true

                    FlyConnection = RunService.Heartbeat:Connect(function(dt)
                        if not getgenv().HD_FlyEnabled then
                            bodyGyro:Destroy()
                            bodyPos:Destroy()
                            Humanoid.PlatformStand = false
                            FlyConnection:Disconnect()
                            return
                        end

                        local direction = GetInputDirection(Camera)
                        local move = direction * speed * dt

                        bodyPos.Position += move
                        bodyGyro.CFrame = CFrame.new(HRP.Position, HRP.Position + Camera.CFrame.LookVector)
                    end)
                end

                ToggleFly()
            elseif HDAdmin_Found == true and xeno_level_executor == false then
                local function toggleFly()
                    getgenv().HD_FlyEnabled = true
                    getgenv().HD_FlySpeed = 100
                    local speed = getgenv().HD_FlySpeed
                    local FlyModule = require(HDAdmin_Directory:WaitForChild("Modules"):WaitForChild("FlyCommand"))
                    local main = MainFramework:CheckInitialized()

                    if not flyEnabled then
                        main.commandSpeeds[playerName] = speed
                        main.commandsActive[playerName] = true
                        FlyModule:Fly(playerName)
                        flyEnabled = true
                    else
                        main.commandsActive[playerName] = false
                        FlyModule:Fly(playerName)
                        flyEnabled = false
                    end
                end
                wait()
                toggleFly()
            elseif HDAdmin_Found == false then
                getgenv().notify("Note:", "E = Fly Up | Q = Fly Down.", 10)
                getgenv().HD_FlyEnabled = true
                speed = 75

                local Players = getgenv().Players
                local RunService = getgenv().RunService
                local UserInputService = getgenv().UserInputService
                local Workspace = getgenv().Workspace

                local LocalPlayer = getgenv().LocalPlayer
                repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                local Character = getgenv().Character
                local HRP = getgenv().getRoot(getgenv().Character)
                local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                local Camera = getgenv().Camera

                local KeysDown = {
                    W = false,
                    A = false,
                    S = false,
                    D = false,
                    E = false,
                    Q = false,
                }

                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    local key = input.KeyCode
                    if KeysDown[key.Name] ~= nil then
                        KeysDown[key.Name] = true
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    local key = input.KeyCode
                    if KeysDown[key.Name] ~= nil then
                        KeysDown[key.Name] = false
                    end
                end)

                local function GetInputDirection(cam)
                    local dir = Vector3.zero
                    if KeysDown.W then dir += cam.CFrame.LookVector end
                    if KeysDown.S then dir -= cam.CFrame.LookVector end
                    if KeysDown.D then dir += cam.CFrame.RightVector end
                    if KeysDown.A then dir -= cam.CFrame.RightVector end
                    if KeysDown.E then dir += cam.CFrame.UpVector end
                    if KeysDown.Q then dir -= cam.CFrame.UpVector end
                    return dir.Magnitude > 0 and dir.Unit or Vector3.zero
                end

                local function ToggleFly()
                    local bodyGyro = Instance.new("BodyGyro")
                    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                    bodyGyro.P = 4000
                    bodyGyro.D = 150
                    bodyGyro.CFrame = HRP.CFrame
                    bodyGyro.Name = "ExecutorFlyGyro"
                    bodyGyro.Parent = HRP

                    local bodyPos = Instance.new("BodyPosition")
                    bodyPos.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                    bodyPos.P = 7500
                    bodyPos.D = 1000
                    bodyPos.Position = HRP.Position
                    bodyPos.Name = "ExecutorFlyPosition"
                    bodyPos.Parent = HRP

                    Humanoid.PlatformStand = true

                    FlyConnection = RunService.Heartbeat:Connect(function(dt)
                        if not getgenv().HD_FlyEnabled then
                            bodyGyro:Destroy()
                            bodyPos:Destroy()
                            Humanoid.PlatformStand = false
                            FlyConnection:Disconnect()
                            return
                        end

                        local direction = GetInputDirection(Camera)
                        local move = direction * speed * dt

                        bodyPos.Position += move
                        bodyGyro.CFrame = CFrame.new(HRP.Position, HRP.Position + Camera.CFrame.LookVector)
                    end)
                end

                ToggleFly()
            end
        else
            DisableFlyScript()
            wait(0.2)
            if anti_fling_toggle_saved == true then
                if getgenv().AntiFlingToggle then
                    getgenv().notify("Alert:", "Turning 'Anti Fling' back on, it was enabled before.", 5)
                    getgenv().AntiFlingToggle:Set(true)
                    anti_fling_toggle_saved = false
                end
            end
            if anti_teleport_toggle_saved == true then
                if getgenv().AntiTeleport_Univ then
                    getgenv().notify("Alert:", "Turning 'Anti Teleport' back on, it was enabled before.", 5)
                    getgenv().AntiTeleport_Univ:Set(true)
                    anti_teleport_toggle_saved = false
                end
            end
        end
    end,})

    getgenv().HDAdminFly_Speed = Tab2:CreateSlider({
    Name = "HD Admin Fly Speed",
    Range = {50, 500},
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    Flag = "EditFlySpeedHDAdmin",
    Callback = function(HDAdminFlySpeed_Edit)
        speed = HDAdminFlySpeed_Edit
        wait()
        getgenv().HD_FlySpeed = speed
    end,})

    wait(0.1)
    getgenv().SendOwnNotification = Tab1:CreateInput({
    Name = "Send Your Own Notification",
    CurrentValue = "Text Here",
    PlaceholderText = "Message",
    RemoveTextAfterFocusLost = true,
    Flag = "SendNotifMessage",
    Callback = function(Notif_Sender)
        getgenv().GuiService:SendNotification({
            Title = tostring("Flames Hub:"),
            Text = tostring(Notif_Sender),
        })
    end,})
    wait()
    local RunService = getgenv().RunService
    local Players = getgenv().Players
    local UserInputService = getgenv().UserInputService
    local Player = getgenv().LocalPlayer
    local Character = getgenv().Character
    local RootPart = getgenv().Character:FindFirstChildWhichIsA("Humanoid")

    local isHoldingJump = false
    local isHoldingKey = false

    if not getgenv().CFrameSpeed then
        getgenv().CFrameSpeed = {
            Enabled = false,
            Speed = 2,
            Keybind = Enum.KeyCode.LeftShift
        }
    end

    if not getgenv().CFrameJump then
        getgenv().CFrameJump = {
            Enabled = false,
            JumpPower = nil,
            JumpHeight = nil,
            Keybind = Enum.KeyCode.Space
        }

        local Character = getgenv().Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            if Humanoid.UseJumpPower then
                getgenv().CFrameJump.JumpPower = 2
            else
                getgenv().CFrameJump.JumpHeight = 2
            end
        end
    end

    wait(0.2)

    local JailCellConnection
    getgenv().JailCellCheckEnabled = false

    local function DisableJailCellWatcher()
        getgenv().JailCellCheckEnabled = false
        if JailCellConnection then
            JailCellConnection:Disconnect()
            JailCellConnection = nil
        end
    end
    wait(0.1)
    getgenv().DisableJell_Cell_Watcher = DisableJailCellWatcher

    local FreezeCheckConnection
    local IceBlockConnection
    getgenv().IceBlockCheckEnabled = false

    local function DisableIceWatcher()
        getgenv().IceBlockCheckEnabled = false
        if IceBlockConnection then
            IceBlockConnection:Disconnect()
            IceBlockConnection = nil
        end
        if FreezeCheckConnection then
            FreezeCheckConnection:Disconnect()
            FreezeCheckConnection = nil
        end
    end
    wait(0.1)
    getgenv().DisableIce_Block_Watcher = DisableIceWatcher

    getgenv().AddAutoAntiIceJailCell = Tab16:CreateButton({
    Name = "Auto-Run Anti Ice/Jail (Leave manually to stop)",
    Callback = function()
        if getgenv().Loaded_Check_For_Anti_Ice_Jail then
            return getgenv().notify("Heads Up:", "You already loaded auto-run anti ice/jail!", 6)
        end
        task.wait(0.2)
        getgenv().notify("Heads Up!:", "You MUST leave manually and rejoin to disable/stop this script.", 5)
        getgenv().Loaded_Check_For_Anti_Ice_Jail = true
        getgenv().LocalPlayer.OnTeleport:Connect(function(State)
            if (not getgenv().Anti_Ice_Jail_AutoRun) and getgenv().queueteleport then
                getgenv().Anti_Ice_Jail_AutoRun = true
                queueteleport("loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Anti_Ice_Jail_HDAdmin.lua')))()")
            else
                return getgenv().notify("Failure:", "Your executor does not support 'queueteleport'!", 6)
            end
        end)
    end,})

    getgenv().AntiJailCell = Tab16:CreateToggle({
    Name = "Anti Jail Cell (HD Admin)",
    CurrentValue = false,
    Flag = "AntiJailCellConnection",
    Callback = function(AntiJailHDAdmin)
        if AntiJailHDAdmin then
            local TeleportService = cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
            local LocalPlayer = getgenv().LocalPlayer
            local PlaceID = game.PlaceId
            local JobID = game.JobId

            getgenv().JailCellCheckEnabled = false

            local function Rejoin()
                TeleportService:TeleportToPlaceInstance(PlaceID, JobID, LocalPlayer)
            end

            local function EnableJailCellWatcher()
                if JailCellConnection then return end
                getgenv().JailCellCheckEnabled = true

                JailCellConnection = workspace.DescendantAdded:Connect(function(descendant)
                    if not getgenv().JailCellCheckEnabled then return end
                    if descendant:IsA("Model") and descendant.Name == LocalPlayer.Name.."'s JailCell" then
                        Rejoin()
                    end
                end)
            end

            EnableJailCellWatcher()
        else
            DisableJailCellWatcher()
        end
    end,})

    getgenv().AntiIceBlock = Tab16:CreateToggle({
    Name = "Anti Ice/Freeze (HD Admin)",
    CurrentValue = false,
    Flag = "AntiIceBlockConnection",
    Callback = function(AntiIceHDAdmin)
        if AntiIceHDAdmin then
            local TeleportService = cloneref and cloneref(game:GetService("TeleportService")) or game:GetService("TeleportService")
            local Players = getgenv().Players
            local RunService = getgenv().RunService

            local LocalPlayer = getgenv().LocalPlayer or Players.LocalPlayer
            local PlaceID = game.PlaceId
            local JobID = game.JobId

            local function Rejoin()
                TeleportService:TeleportToPlaceInstance(PlaceID, JobID, LocalPlayer)
            end

            local function IsFullyFrozen()
                local character = LocalPlayer.Character
                if not character then return false end

                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if not humanoid then return false end

                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        if not part.Anchored then
                            return false
                        end
                    end
                end

                return true
            end

            local function EnableIceWatcher()
                if IceBlockConnection then return end
                getgenv().IceBlockCheckEnabled = true

                IceBlockConnection = workspace.DescendantAdded:Connect(function(descendant)
                    if not getgenv().IceBlockCheckEnabled then return end
                    if descendant:IsA("Part") and descendant.Name == LocalPlayer.Name.."'s FreezeBlock" then
                        Rejoin()
                    end
                end)

                FreezeCheckConnection = RunService.Heartbeat:Connect(function()
                    if not getgenv().IceBlockCheckEnabled then return end

                    local character = LocalPlayer.Character
                    if character and IsFullyFrozen() then
                        Rejoin()
                    end
                end)
            end

            EnableIceWatcher()
        else
            DisableIceWatcher()
        end
    end,})

    local anti_knockback_connection
    getgenv().anti_knock_back_conn = anti_knockback_connection
    local antiKnockbackEnabled = false

    getgenv().AntiFlingToggle = Tab16:CreateToggle({
    Name = "Anti Fling",
    CurrentValue = false,
    Flag = "AntiFlingAbsolutelyInsane",
    Callback = function(EnableAntiFlingScript)
        if EnableAntiFlingScript then
            getgenv().antiFlingEnabled = true
            getgenv().antiKnockbackEnabled = true

            local RunService = getgenv().RunService
            local Players = getgenv().Players
            local lp = getgenv().LocalPlayer

            local function getHRP()
                local char = getgenv().Character
                return char and char:FindFirstChild("HumanoidRootPart") or getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            end

            local function cleanUpForces()
                local hrp = getHRP()
                if not hrp then return end

                for _, obj in ipairs(hrp:GetChildren()) do
                    if obj:IsA("BodyMover") or obj:IsA("VectorForce") or obj:IsA("Torque") or obj:IsA("LinearVelocity") then
                        obj:Destroy()
                    end
                end
            end

            local function onHeartbeat()
                if not (getgenv().antiKnockbackEnabled or getgenv().antiFlingEnabled) then return end

                local hrp = getHRP()
                local humanoid = lp.Character and lp.Character:FindFirstChildWhichIsA("Humanoid")
                if not hrp or not humanoid then return end

                local maxSpeed = 45
                local maxAngularSpeed = 60

                if hrp.Velocity.Magnitude > maxSpeed then
                    hrp.Velocity = hrp.Velocity.Unit * maxSpeed
                end

                if hrp.AssemblyLinearVelocity.Magnitude > maxSpeed then
                    hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity.Unit * maxSpeed
                end

                if hrp.RotVelocity.Magnitude > maxAngularSpeed then
                    hrp.RotVelocity = Vector3.zero
                end

                if hrp.AssemblyAngularVelocity.Magnitude > maxAngularSpeed then
                    hrp.AssemblyAngularVelocity = Vector3.zero
                end

                if humanoid.PlatformStand then
                    humanoid.PlatformStand = false
                end

                cleanUpForces()
            end

            if getgenv().anti_knock_back_conn then
                getgenv().anti_knock_back_conn:Disconnect()
                getgenv().anti_knock_back_conn = nil
            end
            wait(0.2)
            getgenv().anti_knock_back_conn = RunService.Heartbeat:Connect(onHeartbeat)
        else
            getgenv().antiFlingEnabled = false

            if getgenv().antiFlingThing then
                getgenv().antiFlingThing:Disconnect()
                getgenv().antiFlingThing = nil
            end
            antiKnockbackEnabled = false
            if getgenv().anti_knock_back_conn then
                getgenv().anti_knock_back_conn:Disconnect()
                getgenv().anti_knock_back_conn = nil
            end
        end
    end,})

    local original_parents = {}

    local function perform_scan()
        local results = {}

        for _, obj in ipairs(getgenv().Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (string.match(obj.Name:upper(), "KILLPART") or string.match(obj.Name:upper(), "KILL")) then
                original_parents[obj] = obj.Parent
                table.insert(results, obj)
            end
        end

        return results
    end

    getgenv().KillPartsToggle = Tab16:CreateToggle({
    Name = "Toggle Kill Parts (Works for most obbies)",
    CurrentValue = false,
    Flag = "KillPartsTogglingScript",
    Callback = function(ToggleTheKillParts)
        if ToggleTheKillParts then
            local VRService = getgenv().Service_Wrap("VRService")
            local Results = perform_scan()

            for _, part in ipairs(Results) do
                part.Parent = VRService
            end
        else
            local VRService = getgenv().Service_Wrap("VRService")
            
            for part, parent in pairs(original_parents) do
                if part and parent then
                    part.Parent = parent
                end
            end
        end
    end,})

    if game.PlaceId == 83312952548612 then
        getgenv().FastTogglePart = Tab16:CreateToggle({
        Name = "Toggle Obby Button [Fast]",
        CurrentValue = false,
        Flag = "FastToggleButtonForObby",
        Callback = function(fast_toggling_obby)
            if fast_toggling_obby then
                local Workspace = getgenv().Workspace
                local Player = getgenv().LocalPlayer
                local Character = getgenv().Character
                local HumanoidRootPart = getgenv().getRoot(getgenv().Character)
                getgenv().Gudock_Part_Touching = true

                if not Workspace:FindFirstChild("Gudock") then
                    getgenv().FastTogglePart:Set(false)
                    return getgenv().notify("Failure:", "Gudock button for the obby doesn't seem to exist.", 5)
                end
            
                local Gudock_Part = Workspace:FindFirstChild("Gudock")

                if Gudock_Part then
                    while getgenv().Gudock_Part_Touching == true do
                        for _, v in ipairs(Gudock_Part:GetDescendants()) do
                            if v:IsA("TouchTransmitter") and firetouchinterest then
                                firetouchinterest(v.Parent, HumanoidRootPart, 0)
                                task.wait()
                                firetouchinterest(v.Parent, HumanoidRootPart, 1)
                            end
                        end
                        task.wait()
                    end
                end
            else
                getgenv().Gudock_Part_Touching = false
                getgenv().Gudock_Part_Touching = false
            end
        end,})
    else
        warn("You do not seem to be on Troll Is A Pinning Tower 2, not running 'Toggle Obby Button [Fast]'.")
    end

    getgenv().AntiTeleport_Univ = Tab16:CreateToggle({
    Name = "Anti Teleport",
    CurrentValue = false,
    Flag = "AntiTeleportToggleUniversal",
    Callback = function(anti_teleport_toggle)
        if anti_teleport_toggle then
            getgenv().AntiTeleport = true
            getgenv().AntiTeleportConnection = nil

            local Players = getgenv().Players
            local LocalPlayer = getgenv().LocalPlayer

            repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

            local Character = getgenv().Character
            local HRP = getgenv().getRoot(Character)
            local safePos = HRP.CFrame
            getgenv().AntiTeleportConnections = {}

            getgenv().AntiTeleportConnection = task.spawn(function()
                while task.wait(0.1) do
                    if not getgenv().AntiTeleport then
                        safePos = HRP.CFrame
                        continue
                    end

                    if LocalPlayer.Character ~= Character then
                        Character = getgenv().Character
                        HRP = getgenv().getRoot(Character)
                    end

                    if HRP then
                        safePos = HRP.CFrame
                    end
                end
            end)

            local function preventTp(char)
                local root = getgenv().HumanoidRootPart
                if not root then return end

                local cframeCon = root:GetPropertyChangedSignal("CFrame"):Connect(function()
                    if getgenv().AntiTeleport and safePos and root then
                        root.CFrame = safePos
                    end
                end)

                local posCon = root:GetPropertyChangedSignal("Position"):Connect(function()
                    if getgenv().AntiTeleport and safePos and root then
                        root.CFrame = safePos
                    end
                end)

                table.insert(getgenv().AntiTeleportConnections, cframeCon)
                table.insert(getgenv().AntiTeleportConnections, posCon)
            end

            table.insert(getgenv().AntiTeleportConnections, LocalPlayer.CharacterAdded:Connect(preventTp))
            preventTp(Character)
        else
            getgenv().AntiTeleport = false

            pcall(function()
                task.cancel(getgenv().AntiTeleportConnection)
                getgenv().AntiTeleportConnection = nil
            end)

            if getgenv().AntiTeleportConnections then
                for _, v in ipairs(getgenv().AntiTeleportConnections) do
                    pcall(function()
                        v:Disconnect()
                    end)
                end
                getgenv().AntiTeleportConnections = {}
            end
        end
    end,})

    getgenv().AntiBlurUniversal = Tab16:CreateToggle({
    Name = "Anti Blur",
    CurrentValue = false,
    Flag = "AntiBlurUniversalToggle",
    Callback = function(anti_blur_toggle)
        if anti_blur_toggle then
            if getgenv().AntiBlurConnections then
                for _, con in ipairs(getgenv().AntiBlurConnections) do con:Disconnect() end
            end

            getgenv().AntiBlurEnabled = true
            getgenv().AntiBlurConnections = {}

            local Workspace = getgenv().Workspace
            local Lighting = getgenv().Lighting
            local Camera = getgenv().Camera or Workspace.CurrentCamera

            local function trackConnection(conn)
                table.insert(getgenv().AntiBlurConnections, conn)
            end

            local function RemoveBlurIfPresent(obj)
                if obj:IsA("BlurEffect") then
                    obj:Destroy()
                end
            end

            local function WatchForBlurRecursive(container)
                if not container or typeof(container) ~= "Instance" then return end

                RemoveBlurIfPresent(container)

                for _, child in ipairs(container:GetChildren()) do
                    WatchForBlurRecursive(child)
                end

                local added = container.ChildAdded:Connect(function(child)
                    if not getgenv().AntiBlurEnabled then return end
                    RemoveBlurIfPresent(child)
                    WatchForBlurRecursive(child)
                end)

                trackConnection(added)
            end

            local function SetupAntiBlur()
                for _, con in ipairs(getgenv().AntiBlurConnections) do
                    con:Disconnect()
                end

                table.clear(getgenv().AntiBlurConnections)

                if not getgenv().AntiBlurEnabled then return end

                WatchForBlurRecursive(Camera)
                WatchForBlurRecursive(Lighting)
                WatchForBlurRecursive(Workspace)

                local camChange = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
                    Camera = Workspace.CurrentCamera
                    WatchForBlurRecursive(Camera)
                end)

                trackConnection(camChange)
            end

            getgenv().ToggleAntiBlur = function(state)
                getgenv().AntiBlurEnabled = (state ~= false)
                SetupAntiBlur()
            end

            SetupAntiBlur()
        else
            getgenv().AntiBlurEnabled = false
            getgenv().AntiBlurEnabled = false
            if getgenv().AntiBlurConnection then
                getgenv().AntiBlurConnection:Disconnect()
                getgenv().AntiBlurConnection = nil
            end
        end
    end,})

    getgenv().CFrameSpeedSlider = Tab2:CreateSlider({
    Name = "CFrame WalkSpeed Set Speed",
    Range = {1, 25},
    Increment = 1,
    CurrentValue = 2,
    Flag = "DirectCFrameSpeedEditor",
    Callback = function(newSpeed)
        getgenv().CFrameSpeed.Speed = newSpeed
    end,})

    if getgenv().Character:FindFirstChildWhichIsA("Humanoid").UseJumpPower then
        getgenv().JumpPowerSpeedSlider = Tab2:CreateSlider({
        Name = "Set CFrame JumpPower",
        Range = {1, 30},
        Increment = 1,
        CurrentValue = 1,
        Flag = "JPAuraCFrameMethod",
        Callback = function(value)
            getgenv().CFrameJump.JumpPower = value
        end,})
    else
        getgenv().JumpHeightSpeedSlider = Tab2:CreateSlider({
        Name = "Set CFrame JumpHeight",
        Range = {1, 40},
        Increment = 1,
        CurrentValue = 1,
        Flag = "JumpHeightCFrameMethod",
        Callback = function(value)
            getgenv().CFrameJump.JumpHeight = value
        end,})
    end

    getgenv().ResetCFrameSpeedSlider = Tab2:CreateButton({
    Name = "Reset CFrame WalkSpeed Speed",
    Callback = function()
        getgenv().CFrameSpeedSlider:Set(1)
        wait(0.2)
        getgenv().CFrameSpeed.Speed = 1
    end,})

    getgenv().CFrameSpeedUp = Tab2:CreateKeybind({
    Name = "CFrame Speed Key",
    CurrentKeybind = "LeftShift",
    HoldToInteract = false,
    Flag = "GetCFrameSpeedKeyCode",
    Callback = function(key)
        if typeof(key) == "string" and Enum.KeyCode[key] then
            getgenv().CFrameSpeed.Keybind = Enum.KeyCode[key]
        else
            getgenv().CFrameSpeed.Keybind = Enum.KeyCode.LeftShift
        end
    end,})

    local function startMovementLoop()
        if getgenv().CFrame_Speed_Connection_Started then
            getgenv().CFrame_Speed_Connection_Started:Disconnect()
        end

        getgenv().CFrame_Speed_Connection_Started = RunService.RenderStepped:Connect(function()
            if getgenv().CFrameSpeed.Enabled and isHoldingKey and getgenv().HumanoidRootPart then
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

                if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
                    getgenv().HumanoidRootPart.CFrame = getgenv().HumanoidRootPart.CFrame + (Humanoid.MoveDirection * getgenv().CFrameSpeed.Speed)
                end
            end
        end)
    end

    local function stopMovementLoop()
        if getgenv().CFrame_Speed_Connection_Started then
            getgenv().CFrame_Speed_Connection_Started:Disconnect()
            getgenv().CFrame_Speed_Connection_Started = nil
        end
    end

    local function startJumpLoop()
        if getgenv().CFrame_Jump_Connection_Started then
            getgenv().CFrame_Jump_Connection_Started:Disconnect()
        end

        getgenv().CFrame_Jump_Connection_Started = getgenv().RunService.RenderStepped:Connect(function()
            if getgenv().CFrameJump.Enabled and isHoldingJump and getgenv().HumanoidRootPart then
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    if Humanoid.UseJumpPower then
                        getgenv().HumanoidRootPart.CFrame = getgenv().HumanoidRootPart.CFrame + Vector3.new(0, getgenv().CFrameJump.JumpPower, 0)
                    else
                        getgenv().HumanoidRootPart.CFrame = getgenv().HumanoidRootPart.CFrame + Vector3.new(0, getgenv().CFrameJump.JumpHeight, 0)
                    end
                end
            end
        end)
    end

    local function stopJumpLoop()
        if getgenv().CFrame_Jump_Connection_Started then
            getgenv().CFrame_Jump_Connection_Started:Disconnect()
            getgenv().CFrame_Jump_Connection_Started = nil
        end
    end

    Player.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter
        RootPart = Character:WaitForChild("HumanoidRootPart")

        if getgenv().CFrameSpeed.Enabled then
            startMovementLoop()
        end

        if getgenv().CFrameJump.Enabled then
            startJumpLoop()
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            if input.KeyCode == getgenv().CFrameJump.Keybind then
                isHoldingJump = true
            elseif input.KeyCode == getgenv().CFrameSpeed.Keybind then
                isHoldingKey = true
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == getgenv().CFrameJump.Keybind then
            isHoldingJump = false
        elseif input.KeyCode == getgenv().CFrameSpeed.Keybind then
            isHoldingKey = false
        end
    end)

    getgenv().JPCFrameToggle = Tab2:CreateToggle({
    Name = "JumpPower CFrame",
    CurrentValue = false,
    Flag = "JPToggleForCFrame",
    Callback = function(state)
        getgenv().CFrameJump.Enabled = state
        if state then
            startJumpLoop()
        else
            stopJumpLoop()
        end
    end,})

    getgenv().CFrameSpeedToggle = Tab2:CreateToggle({
    Name = "CFrame Speed (Keybind)",
    CurrentValue = false,
    Flag = "CFrameSpeedingScript",
    Callback = function(state)
        getgenv().CFrameSpeed.Enabled = state
        if state then
            startMovementLoop()
        else
            stopMovementLoop()
        end
    end,})
    wait(0.2)
    stopMovementLoop()
    wait(0.1)
    getgenv().FrozenChar = Tab2:CreateToggle({
    Name = "Freeze Your Character",
    CurrentValue = false,
    Flag = "AntiMovement",
    Callback = function(hasFrozenChar)
        if hasFrozenChar then
            local Character = getgenv().Character
            local Workspace_Service = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
            local HumanoidRootPart = getgenv().getRoot(Character) or getgenv().HumanoidRootPart
            getgenv().FreezingChar = true
            if Character and HumanoidRootPart or Character:FindFirstChild("HuamnoidRootPart") then
                if getgenv().FreezingChar == true then
                    HumanoidRootPart.Anchored = true
                end
            else
                getgenv().FrozenChar:Set(false)
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
                        for i,v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
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

    getgenv().unload_bang_function = function()
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

            if getgenv().Character:FindFirstChild("HumanoidRootPart") then
                getgenv().getRoot(getgenv().Character).Anchored = false
            end

            if getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetStateEnabled(Enum.HumanoidStateType.Seated, false) then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            end
            wait()
            getgenv().bangActive = false
            getgenv().Clip = true
            getgenv().bangScriptLoaded = false
            getgenv().unload = nil
            getgenv().enabled = false
        end
        wait(0.1)
        bang_plr_bypass_off()
    end

    getgenv().ViewRandomPlayer = Tab13:CreateToggle({
    Name = "View/Spectate Random Player",
    CurrentValue = false,
    Flag = "SpectatingRandomPlr",
    Callback = function(spectating_random)
        if spectating_random then
            local others = {}

            for _, p in ipairs(getgenv().Players:GetPlayers()) do
                local char = p.Character
                if p ~= getgenv().LocalPlayer and char and char:FindFirstChild("Humanoid") then
                    table.insert(others, p)
                end
            end

            if #others > 0 then
                local target = others[math.random(1, #others)]
                local target_humanoid = target.Character and target.Character:FindFirstChildWhichIsA("Humanoid")

                if target and target_humanoid then
                    getgenv().Camera.CameraSubject = target.Character
                end
            else
                warn("No valid players to view.")
            end
        else
            getgenv().Camera.CameraSubject = getgenv().Character or getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        end
    end,})

    getgenv().TPToRandomPlayer = Tab13:CreateButton({
    Name = "TP To Random Player",
    Callback = function()
        local others = {}

        for _, p in ipairs(getgenv().Players:GetPlayers()) do
            local char = p.Character
            if p ~= getgenv().LocalPlayer and char and char:FindFirstChild("HumanoidRootPart") then
                table.insert(others, p)
            end
        end

        if #others > 0 then
            local target = others[math.random(1, #others)]
            local targetHRP = target.Character and target.Character:FindFirstChild("HumanoidRootPart")

            if target and target.Character and targetHRP then
                getgenv().Character:PivotTo(target.Character)
            end
        else
            warn("No valid players to teleport to.")
        end
    end,})

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

    getgenv().r15_or_r6 = function(humanoid)
        if typeof(humanoid) ~= "Instance" or not humanoid:IsA("Humanoid") then
            if typeof(getgenv().Character:FindFirstChildWhichIsA("Humanoid")) ~= "Instance" or not getgenv().Character:FindFirstChildWhichIsA("Humanoid"):IsA("Humanoid") then
                return warn("Invalid or no Humanoid argument was passed, and Humanoid is also invalid!")
            end
            humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        end

        local rig_type = humanoid.RigType

        if rig_type == Enum.HumanoidRigType.R15 then
            return true
        elseif rig_type == Enum.HumanoidRigType.R6 then
            return false
        else
            return "Unknown"
        end
    end
    wait(0.2)
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
        local Players = getgenv().Players
        local RunService = getgenv().RunService
        local LocalPlayer = getgenv().LocalPlayer
        local Character = getgenv().Character
        local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        local HumanoidRootPart = getgenv().getRoot(getgenv().Character)
        
        local VOID_THRESHOLD = -50
        local UNVOID_THRESHOLD = 0
        
        local function noSitFunc()
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        end
        
        local function antiVoidLoop()
            OrgDestroyHeight = getgenv().Workspace.FallenPartsDestroyHeight

            getgenv().antiVoidLoop = getgenv().RunService.Stepped:Connect(function()
                local root = getgenv().getRoot(getgenv().Character)
                if root and root.Position.Y <= OrgDestroyHeight + 25 then
                    root.Velocity = root.Velocity + Vector3.new(0, 250, 0)
                end
            end)
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
            if getgenv().nositDied then getgenv().nositDied:Disconnect() end
            if getgenv().bangDied then getgenv().bangDied:Disconnect() end
            if getgenv().bangLoop then getgenv().bangLoop:Disconnect() end
            if getgenv().Noclipping then getgenv().Noclipping:Disconnect() end
            if getgenv().antiVoidLoop then getgenv().antiVoidLoop:Disconnect() end
        end
        
        function bang_plr_bypass(target)
            cleanupConnections()
        
            noSitFunc()
        
            getgenv().Clip = false
            getgenv().enabled = true
            getgenv().Noclipping = getgenv().RunService.Stepped:Connect(NoclipLoop)
            wait()
            local Result = getgenv().r15_or_r6()
            local bangAnim
            local bang

            if Result == true then
                bangAnim = Instance.new("Animation")
                bangAnim.AnimationId = "rbxassetid://5918726674"
                bang = humanoid:LoadAnimation(bangAnim)
                bang.Looped = true
            else
                bangAnim = Instance.new("Animation")
                bangAnim.AnimationId = "rbxassetid://148840371"
                bang = humanoid:LoadAnimation(bangAnim)
                bang.Looped = true
            end
            wait(0.1)
            getgenv().bangAnimation = bang
            
            bang:Play(0.1, 1, 1)

            if not target then
                getgenv().unload_bang_function()
                return getgenv().notify("Failure", "Player was not found!", 5)
            end

            if not target.Character then
                getgenv().unload_bang_function()
                return getgenv().notify("Failure", "Target's Character was not found!", 5)
            end
        
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
                    getgenv().getRoot(getgenv().Character).CFrame = bang_char_root.CFrame * CFrame.new(0, 0, 1.1)
                end
            end)

            getgenv().bangDied = getgenv().Character:FindFirstChildWhichIsA("Humanoid").Died:Connect(function()
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

            if getgenv().antiVoidLoop then
                getgenv().antiVoidLoop:Disconnect()
                getgenv().antiVoidLoop = nil
            end
        end
        
        function bang_plr_bypass_off()
            cleanupConnections()

            if getgenv().Character:FindFirstChild("HumanoidRootPart") then
                getgenv().getRoot(getgenv().Character).Anchored = false
            end
            
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Seated, true)
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
        local HumanoidRootPart = getgenv().getRoot(getgenv().Character)
        local spinSpeed = tonumber(getSpinSpeed)
        if spinSpeed and spinSpeed <= 200 then
            local Spin = Instance.new("BodyAngularVelocity")
            Spin.Name = "Spinning"
            Spin.Parent = HumanoidRootPart
            Spin.MaxTorque = Vector3.new(0, math.huge, 0)
            Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
        elseif spinSpeed and spinSpeed >= 200 then
            getgenv().notify("Limit Reached!", "We lowered speed, because you would be flung.", 5)
            wait(0.2)
            if not getgenv().getRoot(getgenv().Character):FindFirstChild("Spinning") then
                local Spin = Instance.new("BodyAngularVelocity")
                Spin.Name = "Spinning"
                Spin.Parent = HumanoidRootPart
                Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                Spin.AngularVelocity = Vector3.new(0,200,0)
            else
                HumanoidRootPart:FindFirstChild("Spinning").AngularVelocity = Vector3.new(0,200,0)
            end
        elseif spinSpeed <= 200 and getgenv().getRoot(getgenv().Character):FindFirstChild("Spinning") then
            getgenv().notify("Detected.", "Updated speed, detected duplicate spin.", 5)
            wait(0.3)
            getgenv().getRoot(getgenv().Character):FindFirstChild("Spinning").AngularVelocity = Vector3.new(0,spinSpeed,0)
        end
    end,})

    getgenv().UnspinNow = Tab2:CreateButton({
    Name = "Unspin",
    Callback = function()
        for i,v in pairs(getgenv().getRoot(getgenv().Character):GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end
    end,})

    getgenv().CharIntoOwnerOfScript = Tab2:CreateButton({
    Name = "Char Into: Owner Of Script",
    Callback = function()
        getgenv().ReplicatedStorage:FindFirstChild("ModifyUsername"):FireServer("L0CKED_1N1")
        wait(0.3)
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

        local function disguise_anims(character)
            if not character then return warn("Character not found!") end
            local Animate = character:FindFirstChild("Animate")
            if not Animate then return warn("Animate script is missing!") end

            Animate.Disabled = true
            task.wait(0.1)
            Animate.Disabled = false

            local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end

            task.wait(0.2)

            Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
            Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
            Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Walk
            Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Run
            Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Jump
            Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Climb
            Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Fall
        end
        wait()
        disguise_anims(getgenv().Character)
    end,})
    wait()
    local Players = getgenv().Players
    local RunService = getgenv().RunService
    
    local speaker = Players.LocalPlayer
    
    local whitelistedPlayers = {
        [652891519] = true,
        [4201949699] = true,
        [7592162677] = true
    }
    
    local bangAnimations = {
        ["rbxassetid://148840371"] = true,
        ["rbxassetid://5918726674"] = true,
        ["rbxassetid://507768375"] = true
    }
    
    local function isWhitelisted(player)
        return player and whitelistedPlayers[player.UserId]
    end
    
    local function isPlayingBangAnimation(humanoid)
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation and bangAnimations[track.Animation.AnimationId] then
                return true
            end
        end
        return false
    end
    
    local function isBangingWhitelistedPlayer()
        local speakerRoot = getgenv().getRoot(getgenv().Character)
        
        if not speakerRoot then return false end
    
        for _, player in pairs(Players:GetPlayers()) do
            if isWhitelisted(player) then
                local targetRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local offset = speakerRoot.Position - targetRoot.Position
                    if math.abs(offset.X) < 2 and math.abs(offset.Y) < 2 and math.abs(offset.Z) < 2 then
                        return true
                    end
                end
            end
        end
        return false
    end
    
    local function monitorBangAttempts()
        while true do
            task.wait(0.1)
    
            local humanoid = speaker.Character and speaker.Character:FindFirstChildWhichIsA("Humanoid")
            if not humanoid then continue end
    
            if isPlayingBangAnimation(humanoid) and isBangingWhitelistedPlayer() then
                humanoid.Health = 0
            end
        end
    end
    
    local function onCharacterAdded(character)
        task.wait(1)
        monitorBangAttempts()
    end
    
    speaker.CharacterAdded:Connect(onCharacterAdded)
    
    task.spawn(monitorBangAttempts)

    if not getgenv().Character:FindFirstChild("Animate") then
        warn("'Animate' LocalScript not found inside of Character at runtime!")
    else
        function reset_walk_while_emoting()
            getgenv().Character:FindFirstChild("Animate").Disabled = false
            wait(0.1)
            for _, animTrack in pairs(getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
                animTrack:Stop()
            end
        end
        wait(0.2)
        local Emotes = {
            "NBA Monster Dunk",
            "Stray Kids Walkin On Water",
            "TWICE Strategy",
            "Fashion Spin",
            "Sleep",
            "Olivia Rodrigo Head Bop",
            "Sturdy Dance - Ice Spice",
            "Victory Dance",
            "Elton John - Heart Shuffle",
            "Bored",
            "Chappell Roan HOT TO GO!",
            "High Wave",
            "Mae Stephens - Piano Hands",
            "Disagree",
            "Line Dance",
            "Agree",
            "Yungblud Happier Jump",
            "Sad",
            "HUGO Let's Drive!",
            "Show Dem Wrists - KSI",
            "Shy",
            "Floss Dance",
            "Tommy - Archer",
            "Wake Up Call - KSI",
            "Fashion Roadkill",
            "Paris Hilton - Sliving For The Groove",
            "Greatest",
            "Happy",
            "Cower",
            "Fast Hands",
            "Cuco - Levitate",
            "Bone Chillin' Bop",
            "Festive Dance",
            "Sidekicks - George Ezra",
            "Baby Queen - Face Frame",
            "Beckon",
            "Zombie",
            "Godlike",
            "Curtsy",
            "Alo Yoga Pose - Lotus Position",
            "Dancin' Shoes - Twenty One Pilots",
            "Confused",
            "Elton John - Heart Skip",
            "HIPMOTION - Amaarae",
            "Monkey",
            "KATSEYE - Touch",
            "Baby Queen - Bouncy Twirl",
            "Rock Out - Bebe Rexha",
            "d4vd - Backflip",
            "Rock On",
            "Team USA Breaking Emote",
            "Uprise - Tommy Hilfiger",
            "Wanna play?",
            "Baby Queen - Air Guitar & Knee Slide",
            "TWICE Feel Special",
            "Wisp - air guitar",
            "Secret Handshake Dance",
            "HOLIDAY Dance - Lil Nas X (LNX)",
            "Old Town Road Dance - Lil Nas X (LNX)",
            "Frosty Flair - Tommy Hilfiger",
            "Rock n Roll",
            "Jumping Wave",
            "Sol de Janeiro - Samba",
            "Baby Queen - Strut",
            "Baby Queen - Dramatic Bow",
            "Hero Landing",
            "Bodybuilder",
            "V Pose - Tommy Hilfiger",
            "Boxing Punch - KSI",
            "Quiet Waves",
            "Baby Dance",
            "Top Rock",
            "Nicki Minaj Starships",
            "Dave's Spin Move - Glass Animals",
            "TWICE LIKEY",
            "TWICE I GOT YOU part 2",
            "Tantrum",
            "Rock Guitar - Royal Blood",
            "Elton John - Elevate",
            "ericdoa - dance",
            "Imagine Dragons - \"Bones\" Dance",
            'GloRilla - "Tomorrow" Dance',
            "Take Me Under - Zara Larsson",
            "Olivia Rodrigo Fall Back to Float",
            "Get Out",
            "Haha",
            "It Ain't My Fault - Zara Larsson",
            "High Hands",
            "Jawny - Stomp",
            "Power Blast",
            "Alo Yoga Pose - Warrior II",
            "Hips Poppin' - Zara Larsson",
            "Y",
            "Elton John - Rock Out",
            "Nicki Minaj Boom Boom Boom",
            "Flowing Breeze",
            "Mean Mug - Tommy Hilfiger",
            "Samba",
            "Fashion Klossette - Runway my way",
            "NBA WNBA Fadeaway",
            "Swish",
            "Robot",
            "TWICE I GOT YOU part 1",
            "Beauty Touchdown",
            "Floor Rock Freeze - Tommy Hilfiger",
            "Cha Cha",
            "Alo Yoga Pose - Triangle",
            "Dizzy",
            "Break Dance",
            "Fishing",
            "Sticker Dance Move - NCT 127",
            "Paris Hilton - Iconic IT-Grrrl",
            "Side to Side",
            "Tommy K-Pop Mic Drop",
            "Mini Kong",
            "Jacks",
            "Up and Down - Twenty One Pilots",
            "Rolling Stones Guitar Strum",
            "Idol",
            "AOK - Tai Verdes",
            "Boom Boom Clap - George Ezra",
            "Celebrate",
            "Celebrate",
            "Rock Star - Royal Blood",
            "Around Town",
            "The Zabb",
            "Elton John - Still Standing",
            "TMNT Dance",
            "Flex Walk",
            "Paris Hilton - Checking My Angles",
            "Tree",
            "Dolphin Dance",
            "Air Guitar",
            "Drummer Moves - Twenty One Pilots",
            "Ay-Yo Dance Move - NCT 127",
            "Saturday Dance - Twenty One Pilots",
            "Swan Dance",
            "Kick It Dance Move - NCT 127",
            "Fancy Feet",
            "SpongeBob Imaginaaation 🌈",
            "Lasso Turn - Tai Verdes",
            "Elton John - Cat Man",
            "Dorky Dance",
            "Rise Above - The Chainsmokers",
            "Shuffle",
            "Arm Twist",
            "Twirl",
            "T",
            "Rodeo Dance - Lil Nas X (LNX)",
            "Louder",
            "Super Charge",
            "Mean Girls Dance Break",
            "Sneaky",
            "Cobra Arms - Tai Verdes",
            "Shrek Roar",
            "Air Dance",
            "On The Outside - Twenty One Pilots",
            "Block Partier",
            "Chill Vibes - George Ezra",
            "Fashionable",
            "Jumping Cheer",
            "Drum Solo - Royal Blood",
            "Elton John - Piano Jump",
            "Keeping Time",
            "Olivia Rodrigo good 4 u",
            "Cartwheel - George Ezra",
            "Panini Dance - Lil Nas X (LNX)",
            "Paris Hilton Sanasa",
            "Drum Master - Royal Blood",
            "Salute",
            "Tilt",
            "Applaud",
            "Hello",
            "Shrug",
            "Point2",
            "Stadium",
            "Stray Kids Walkin On Water"
        }
        wait()
        getgenv().walkingEmoteLoop = Tab2:CreateDropdown({
        Name = "Walk While Emoting",
        Options = Emotes,
        CurrentOption = "Shuffle",
        MultipleOptions = false,
        Flag = "GetEmoteOption",
        Callback = function(selectedEmote)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
                return getgenv().notify("Failure:", "You have to be in R15 to use this!", 5)
            end

            local ToWalkWhileEmoting = type(selectedEmote) == "table" and selectedEmote[1] or tostring(selectedEmote)

            if getgenv().Character:FindFirstChild("Animate") then
                if getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == true then
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
                    for _, v in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks(getgenv().Humanoid)) do
                        v.Looped = true
                    end
                    wait(1)
                    reset_walk_while_emoting()
                    wait(1.2)
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmote(ToWalkWhileEmoting)
                    wait(2)
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
                else
                    warn("Proceed with walk while emoting.")
                end
            else
                reset_walk_while_emoting()
                return getgenv().notify("Failure!", "'Animate' LocalScript not found!", 5)
            end
            wait()
            if getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
                wait(0.8)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmote(ToWalkWhileEmoting)
                wait()
                for _, v in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks(getgenv().Humanoid)) do
                    v.Looped = true
                end
            elseif not getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == false then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
                wait(1)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmote(ToWalkWhileEmoting)
                wait()
                for _, v in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks(getgenv().Humanoid)) do
                    v.Looped = true
                end
                wait(0.1)
                getgenv().getRoot(getgenv().Character).Anchored = true
                wait()
                getgenv().Character:FindFirstChild("Animate").Disabled = true
                wait(0.3)
                getgenv().getRoot(getgenv().Character).Anchored = false
            end
        end,})

        getgenv().StopWalkingPlaceEmote = Tab2:CreateButton({
        Name = "Stop Walking While Emoting",
        Callback = function()
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
                return getgenv().notify("Failure:", "You have to be in R15 to use this!", 5)
            end

            if getgenv().AnthonyShuffle == true then
                getgenv().AnthonyShuffle:Set(false)
            else
                warn("Option turned off.")
            end
            wait()
            getgenv().Character:FindFirstChild("Animate").Disabled = false
            wait(0.2)
            for _, animTrack in pairs(getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
                animTrack:Stop()
            end
            wait(0.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
            wait(0.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
            wait(0.9)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
        end,})
    end

    local MichaelJackson_Speed = 120
    local michaelJacksonActive = false

    getgenv().SetWalkSpeedShuffle = Tab2:CreateSlider({
    Name = "Michael Jackson Walk-Speed",
    Range = {10, 500},
    Increment = 1,
    Suffix = "",
    CurrentValue = 100,
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
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then 
                michaelJacksonActive = false
                if getgenv().AnthonyShuffle then
                    getgenv().AnthonyShuffle:Set(false)
                end
                return getgenv().notify("Failure:", "You must be R15 to use this!", 5)
            end

            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
            end
            wait()
            getgenv().getRoot(getgenv().Character).Anchored = true
            wait(0.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = MichaelJackson_Speed
            wait(0.1)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmoteAndGetAnimTrackById(4391208058)
            wait(0.2)
            getgenv().Character:FindFirstChild("Animate").Disabled = true
            wait(0.1)
            getgenv().getRoot(getgenv().Character).Anchored = false
        else
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
            end
            wait()
            getgenv().getRoot(getgenv().Character).Anchored = true
            wait()
            getgenv().Character:FindFirstChild("Animate").Disabled = false
            task.wait(.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
            wait(0.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
            wait(0.2)
            getgenv().getRoot(getgenv().Character).Anchored = false
        end
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().Owner_Animations = Tab2:CreateToggle({
        Name = "Flames Animations (Applies every respawn)",
        CurrentValue = false,
        Flag = "LoadFlamesOwnerAnims",
        Callback = function(apply_to_respawn_anims)
            if apply_to_respawn_anims then
                if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then 
                    if getgenv().Owner_Animations then
                        getgenv().Owner_Animations:Set(false)
                    end
                    return getgenv().notify("Failure:", "You must be R15 to use this!", 5)
                end
                getgenv().ownerAnimsEnabled = true
                local LocalPlayer = getgenv().LocalPlayer
                
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
                getgenv().getRoot(getgenv().Character).Anchored = false
                wait(1)
                local function run_anims(character)
                    if not character then return warn("Character not found!") end
                    local Animate = character:FindFirstChild("Animate")
                    if not Animate then return warn("Animate script is missing!") end

                    Animate.Disabled = true
                    task.wait(0.1)
                    Animate.Disabled = false

                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                            track:Stop()
                        end
                    end

                    task.wait(0.2)

                    Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
                    Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
                    Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Walk
                    Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Run
                    Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Jump
                    Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Climb
                    Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Fall
                end

                getgenv().ownerAnimsEnabled = true
                wait(0.1)
                local function onCharacterAdded(character)
                    if getgenv().ownerAnimsEnabled then
                        task.wait(1)
                        run_anims(character)
                    else
                        warn("Animations are disabled.")
                    end
                end

                if LocalPlayer.Character then
                    onCharacterAdded(LocalPlayer.Character)
                end

                LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

                local function run_anims(character)
                    if not character then return warn("Character not found!") end
                    local Animate = character:FindFirstChild("Animate")
                    if not Animate then return warn("Animate script is missing!") end

                    Animate.Disabled = true
                    task.wait(0.1)
                    Animate.Disabled = false

                    local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid then
                        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                            track:Stop()
                        end
                    end

                    task.wait(0.2)

                    Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
                    Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
                    Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Walk
                    Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Run
                    Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Jump
                    Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Climb
                    Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Fall
                end

                local function onCharacterAdded(character)
                    if getgenv().ownerAnimsEnabled then
                        task.wait(1)
                        run_anims(character)
                    else
                        warn("Animations are disabled.")
                    end
                end
                wait(1.5)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16

                if LocalPlayer.Character then
                    onCharacterAdded(LocalPlayer.Character)
                end

                LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
            else
                getgenv().ownerAnimsEnabled = false
                getgenv().ownerAnimsEnabled = false
                if getgenv().Character:FindFirstChildWhichIsA("Humanoid") and getgenv().Character:FindFirstChild("HumanoidRootPart") then
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
                    getgenv().getRoot(getgenv().Character).Anchored = false
                    wait(1.5)
                    local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid then
                        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                            track:Stop()
                        end
                    end
                    wait(1.5)
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
                end
            end
        end,})
        wait(0.3)
        if getgenv().ownerAnimsEnabled == true then
            getgenv().Owner_Animations:Set(false)
            getgenv().ownerAnimsEnabled = false
        end
    else
        warn("User does not seem to be in MIC UP or MIC UP 17+, not loading custom owner animations toggle.")
    end
    wait(0.2)
    if game.PlaceId == 17274762379 then
        local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        local RemoteEvents = Remotes and Remotes:FindFirstChild("RemoteEvents")
        local animationHandlerEvent = RemoteEvents and RemoteEvents:FindFirstChild("animationHandlerEvent")
        local RemoteFunctions = Remotes or Remotes:FindFirstChild("RemoteFunctions")
        local OnInviteRequest = RemoteFunctions:FindFirstChild("OnInviteRequest")
        local Codes = RemoteFunctions:FindFirstChild("Codes")

        getgenv().Play_Anim_Stuff = Tab2:CreateDropdown({ 
        Name = "Play Animation",
        Options = {
            "Travis Estrela", "Boogie Bomb", "Crazy Fee", "Electro Swing", "Flos", "Hype", 
            "Smooth Moves", "The Robot", "Macarena", "Boneless", "Twist", "Reanimated", 
            "Orange Justice", "Belly Dance", "Beggin", "Brooklyn", "Conga", "Conga2", 
            "Dboy Stepdance", "Dumb Feet", "Fast Hops", "Gangdamn Style", "Heel Toe Toprock", 
            "Hip Hop 1", "Hip Hop Arm Wave", "Hip Hop Arms Dance", "Hip Hop Rib Bop", 
            "Hip Hop Robot V1", "Hip Hop Snake", "Hip-Hop Dancing", "I'm Diamond", 
            "Jabba Switchaway", "Kazotsky Kick", "Last Forever", "Pop Lock", "Pull Up", 
            "Raise The Roof", "Rollie", "Salsa Dancing V1", "Salsa Dancing V2", 
            "Salsa Dancing V3", "Salsa Dancing V4", "Salsa Dancing V5", "Salsa Dancing V6", 
            "Salsa Dancing V7", "Salsa Dancing V8", "Salsa Dancing V9", "Savage Love", 
            "Scenario", "Showstopper", "Sign Shuffle", "Space", "Spike", "Spongebob", 
            "Take The L", "Wanna See Me", "Pumpernickel", "Freestylin", "Electro Shuffle", 
            "Default Dance", "Inf Dab", "Ride The Pony", "Worm", "Yeet", "T-Pose", 
            "Best mates", "breakdown", "Sit 1", "Sit 2", "Sit 3", "Sit 4", "Sit 5", 
            "Sit 6", "Sit 7", "Sit 8", "Sit 9", "Sit 10", "Funky Pocoto", "Higher", 
            "Interestelar", "Travis Rock", "Tira o Pé", "Mimic", "Hands Up", "Wandinha", 
            "Neymar", "Say So", "Vybe Love", "Rackless", "Sleek", "Disco Night", 
            "Breakdance", "Robotic Moves", "Anita Bang", "Moon Walk", "Blood Pop", 
            "The Weeknd", "Very Sneaky", "Lebron James", "Halloween Ballin", "Olha a Onda", 
            "Tyla Dance", "Hey Now!", "Dançante", "Art Master", "Controller Crew", 
            "Ballestic", "Mio Honda", "Popsmoke", "2002", "Dababy", "Cheers", "Vibe Slide", 
            "Sleepy", "Fanciful", "Lil Uzi", "Snoop Daw", "Rock'n'Roll", "Super Shy", 
            "Road Shuffle", "Perfection", "Popular Vibe", "Emote_HolidayDance_LilNasX", 
            "Blackflip", "Embrace it", "Sidekicks", "Red Dance", "Denys Final", "Olivia", 
            "Jump Cheerleader", "SideToSide", "HipsPoppin", "HipMotion", "Meditate", 
            "Bounce When She Walk", "Bones", "LoopGang", "PaniniDance", "RapperDance", 
            "Cute Lil Dance", "AintMyFault", "HighHands2", "True hearts", "FeetUp", 
            "BoomBoomClap", "CobraArms", "Cupid's Arrow", "Twirl", "BoxingPunch", 
            "ChickenWing", "TreeEmote", "EmoteLouder", "Automotivo", "Party3", 
            "ChillGuitar", "Engineer", "Curtsy", "Lil Dance 2", "BabyDance", 
            "Dont Copy My Flow", "Lisa Rockstar", "HB combined", "Light Out", 
            "Last Forever 2", "Nicki", "Twice1", "Poki", "DanceShut", "Keep Up", 
            "Twice2", "Touch", "BomDance", "TopEmote", "BrooklynPop", "RainLoop", 
            "Rockout2", "WannaRock", "Bye Bye Bye", "Minee", "Mamushi", "Snake 1", 
            "Here!", "Angry!", "EverybodyMe", "Alibi", "Alors On", "La Mama", "Cartwheel", 
            "Wait!", "Tyla2", "JraCosta", "Celebrate", "Pac Party", "Sway", "KeySequence", 
            "CuteDance4", "Dance2816", "FabricJun", "WavePass", "RebDance", "CuteJump", 
            "HorsFlow", "PhoneDancing", "RockRage", tostring("7 Rings"), tostring("9mm Big Bang!"), 
            "ChaplinDance", "GrandmaDance!", "Mal Con!", "CarolinaStep", "CrackStyle", 
            "WinditLoop", "Couve Flow", "ThrowRight", "SummerCome", "Company Jig", 
            "DanceImediate", "Cope V1", "IHeardMoves", "CrazyForm V2", "LeftRightSequence", 
            "BowBowDance", "Culture Dance", "Cupid V1", "LeafFlow", "Watchmeme", 
            "DanceTyu", "FootSequence", "FootShalf", "FootShalf V2", "Gingle", "Tringle", 
            "BubbleFall", "FS V2", "FamousStyle", "FamousStyle V2", "CoolFuunyDance", 
            "ArmsDelay", "LightFamous", "LikePretty", "Get Funky V1", "Get Loose", 
            "NoNoHigh", "Get Funky V2", "Get Funky V3", "HatchBack", "How Sweet", 
            "How Like Kick", "HilarieSwag", "HilarieFeet", "Hide Vibe", "Hype Pop", 
            "MysteriousLoop", "Im HipHop!", "TrueDanceSwag", "UnderlineFeet", "FeetSwagBro!", 
            "JumpAround!", "KawaiiSturdy", "Kawaii!", "Keep Calm Swag!", "Paldal", 
            "LiaStyle!", "Living Large", "LofiAtchim", "CuteStick", tostring("13 Fever"), 
            "One Time Victory", "Robot Dance V2", "Rodeo", "Believer", "YesYesYes!", 
            "SkullBreakDance", "SlapHappy", "Slapp"
        },
        CurrentOption = "Travis Estrela",
        MultipleOptions = false,
        Flag = "AnimationsDropdownListing",
        Callback = function(anim_play)
            local Remotes = getgenv().ReplicatedStorage:FindFirstChild("Remotes")
            local RemoteEvents = Remotes:FindFirstChild("RemoteEvents")
            local animationHandlerEvent = RemoteEvents:FindFirstChild("animationHandlerEvent")

            function play_anim_normally(arg, name)
                local args = {
                    [1] = arg,
                    [2] = name
                }

                animationHandlerEvent:FireServer(unpack(args))
            end

            play_anim_normally("play", tostring(anim_play))
        end,})

        getgenv().RedeemCodes = Tab5:CreateButton({
        Name = "Redeem All Codes",
        Callback = function()
            local Remotes = getgenv().ReplicatedStorage:FindFirstChild("Remotes")
            local RemoteFunctions = Remotes or Remotes:FindFirstChild("RemoteFunctions")
            local Codes = RemoteFunctions:FindFirstChild("Codes")

            Codes:InvokeServer("3mvisits")
        end,})

        getgenv().InvitePlayerParty = Tab5:CreateInput({
        Name = "Invite Player",
        PlaceholderText = "User",
        RemoveTextAfterFocusLost = true,
        Callback = function(player_entered)
            local found_this_plr = findplr(player_entered)
            local Remotes = getgenv().ReplicatedStorage:FindFirstChild("Remotes")
            local RemoteFunctions = Remotes or Remotes:FindFirstChild("RemoteFunctions")
            local OnInviteRequest = RemoteFunctions:FindFirstChild("OnInviteRequest")

            if not found_this_plr then
                return getgenv().notify("Failure", "Player was not found or does not exist.", 6)
            end

            function return_fire(player)
                local arguments = {
                    [1] = {
                        ["Method"] = "OnPlayerInvite",
                        ["Target"] = tostring(player)
                    }
                }

                OnInviteRequest:InvokeServer(unpack(arguments))
            end

            return_fire(found_this_plr)
        end,})

        if require then
            getgenv().SendYourOwnDialogue = Tab2:CreateInput({
            Name = "Custom Dialogue Message",
            PlaceholderText = "User Here",
            RemoveTextAfterFocusLost = true,
            Callback = function(text_to_display)
                local PlayerScripts = getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
                local ClientEvent = PlayerScripts:FindFirstChild("ClientEvent")
                local module = require(ClientEvent:FindFirstChild("DialogueModule"))

                if executor_Name == "Solara" or string.find(executor_Name, "JJSploit") or executor_Name == "Xeno" then
                    return getgenv().notify("Failure:", "This feature isn't supported on this executor.", 5)
                end

                getgenv().notify("Alert!", "If it gives you an error it means you can't do it.", 6)

                module.Speak(getgenv().LocalPlayer, {
                    RealName = tostring(game.Players.LocalPlayer.Name),
                    Texter = "John",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    HigherUp = false,
                    Shake = { Enabled = true, Intensity = 5, Lifetime = 0.5 },
                    Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 1, 0)),
                    TypeSpeed = 0.05
                })                
            end,})
        else
            warn("'Require' is not supported on this executor.")
        end

        getgenv().WhitelistSpamPlr = Tab5:CreateInput({
        Name = "Add Spam Invite Whitelist",
        PlaceholderText = "User Here",
        RemoveTextAfterFocusLost = true,
        Callback = function(player_focus_bruh)
            local Remotes = getgenv().ReplicatedStorage:FindFirstChild("Remotes")
            local RemoteEvents = Remotes and Remotes:FindFirstChild("RemoteEvents")
            local animationHandlerEvent = RemoteEvents and RemoteEvents:FindFirstChild("animationHandlerEvent")
            local RemoteFunctions = Remotes or Remotes:FindFirstChild("RemoteFunctions")
            local OnInviteRequest = RemoteFunctions:FindFirstChild("OnInviteRequest")
            local Codes = RemoteFunctions:FindFirstChild("Codes")
            local bruh_get_player = findplr(player_focus_bruh)

            if not bruh_get_player then
                return getgenv().notify("Failure", "Player was not found or does not exist.", 6)
            end

            local Players = getgenv().Players
            local LocalPlayer = getgenv().LocalPlayer
            local Character = getgenv().Character
            local Humanoid = getgenv().Humanoid
            local HumanoidRootPart = getgenv().getRoot(getgenv().Character)
            local Workspace = getgenv().Workspace
            getgenv().SpamWhitelistTable = getgenv().SpamWhitelistTable or {}
            
            local function addPlayerToGlobalTable(player)
                if next(getgenv().SpamWhitelistTable) then
                    return getgenv().notify("Player Limit!", "Only one player can be added at a time!", 5)
                else
                    getgenv().SpamWhitelistTable[player.Name] = player
                    wait(0.2)
                    if getgenv().SpamWhitelistTable[player.Name] then
                        getgenv().notify("Success!", tostring(player.Name)..", was added to Spam Invite Whitelist!", 5)
                    elseif not Players[player.Name] then
                        return getgenv().notify("Failure!", tostring(player)..", does not exist!", 5)
                    elseif bruh_get_player == getgenv().LocalPlayer then
                        return getgenv().notify("Failed!", "You cannot add yourself!", 5)
                    end
                end
            end
            
            addPlayerToGlobalTable(bruh_get_player)
        end,})

        getgenv().RemoveSpamPlrWhitelist = Tab5:CreateButton({
        Name = "Remove Spam Invite Plr",
        Callback = function()
            for playerName in pairs(getgenv().SpamWhitelistTable) do
                getgenv().SpamWhitelistTable[playerName] = nil
            end
            getgenv().SpamWhitelistTable = {}
        end,})

        getgenv().SpamInvitePlr = Tab5:CreateToggle({
        Name = "Spam Invite Whitelisted Player",
        CurrentValue = false,
        Flag = "SpamInvitingPlrLoop",
        Callback = function(looping_the_plr)
            if looping_the_plr then
                local Remotes = getgenv().ReplicatedStorage:FindFirstChild("Remotes")
                local RemoteEvents = Remotes and Remotes:FindFirstChild("RemoteEvents")
                local animationHandlerEvent = RemoteEvents and RemoteEvents:FindFirstChild("animationHandlerEvent")
                local RemoteFunctions = Remotes or Remotes:FindFirstChild("RemoteFunctions")
                local OnInviteRequest = RemoteFunctions:FindFirstChild("OnInviteRequest")
                local Codes = RemoteFunctions:FindFirstChild("Codes")
                local player
                wait(0.1)
                for playerName in pairs(getgenv().SpamWhitelistTable) do
                    if playerName then
                        player = getgenv().SpamWhitelistTable[playerName]
                    else
                        player = nil
                    end
                end
                wait(0.2)
                function return_fire(player)
                    local arguments = {
                        [1] = {
                            ["Method"] = "OnPlayerInvite",
                            ["Target"] = tostring(player)
                        }
                    }

                    OnInviteRequest:InvokeServer(unpack(arguments))
                end

                getgenv().get_spamming_func_plr = true
                while getgenv().get_spamming_func_plr == true do
                wait()
                    return_fire(found_this_plr)
                end
            else
                getgenv().get_spamming_func_plr = false
            end
        end,})

        getgenv().AntiRagdollScript = Tab2:CreateToggle({
        Name = "Anti Ragdoll (BETA)",
        CurrentValue = false,
        Flag = "ToggleOnAntiRag",
        Callback = function(check_ragdoll_scripts)
            if check_ragdoll_scripts then
                getgenv().ragdollScript = true
                getgenv().ragdollScriptDisabled = true
                wait(0.2)
                function disable_ragdoll()
                    getgenv().Character:FindFirstChild("ragdoll"):Destroy()
                end

                function do_anims_func()
                    if not getgenv().ragdollScriptDisabled then
                        return warn("Anti Ragdoll is disabled.")
                    end
        
                    local player = getgenv().LocalPlayer
                    if not player then
                        return warn("Player was not found at runtime.")
                    end
        
                    player.CharacterAdded:Connect(run_anims)
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                        disable_ragdoll()
                    end
                end
        
                if getgenv().ragdollScript then
                    warn("Anti Ragdoll already loaded!")
                elseif not getgenv().ragdollScript then
                    if typeof(do_anims_func) == "function" then
                        do_anims_func()
                        getgenv().ragdollScript = true
                    else
                        warn("Error: Ragdoll script is missing!")
                    end
                else
                    warn("Anti Ragdoll not loaded, error.")
                end
            else
                getgenv().ragdollScript = false
                getgenv().ragdollScriptDisabled = false
            end
        end,})
    else
        warn("User is not on MushYO! 🔊, not putting these here.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().AddBoothWhitelistPlr = Tab7:CreateInput({
        Name = "Add Player to Booth Whitelist",
        CurrentValue = "User",
        PlaceholderText = "User",
        RemoveTextAfterFocusLost = true,
        Flag = "BoothWhitelistingAddingUser",
        Callback = function(getThisPlayer)
            getgenv().boothWhitelistingPlayer = getgenv().boothWhitelistingPlayer or {}

            local bruhUser = findplr(getThisPlayer)

            if not bruhUser then
                return getgenv().notify("Failure", "Player was not found.", 6)
            end

            wait(0.2)
            local function addPlayerToBoothTable(player)
                getgenv().boothWhitelistingPlayer[player.Name] = player
                wait(0.3)
                if getgenv().boothWhitelistingPlayer[player.Name] then
                    getgenv().notify("Success!", tostring(player.Name)..", was added to Booth Whitelist!", 5)
                end
            end
            
            addPlayerToBoothTable(bruhUser)
        end,})

        getgenv().RemoveBoothWhitelistPlr = Tab7:CreateInput({
        Name = "Remove Plr From Booth Whitelist",
        CurrentValue = "User",
        PlaceholderText = "User Here",
        RemoveTextAfterFocusLost = true,
        Flag = "BoothWhitelistingRemoveUser",
        Callback = function(RemoveBoothWhitelist)
            getgenv().boothWhitelistingPlayer = getgenv().boothWhitelistingPlayer or {}

            local dawgUser = findplr(RemoveBoothWhitelist)
            
            local function removePlayerFromBoothTable(player)
                if getgenv().boothWhitelistingPlayer[player.Name] then
                    getgenv().boothWhitelistingPlayer[player.Name] = nil
                    wait(0.2)
                    if getgenv().boothWhitelistingPlayer[player.Name] == nil then
                        getgenv().notify("Success!", tostring(player.Name)..", was removed from the Booth Whitelist!", 5)
                    else
                        return getgenv().notify("Failed", tostring(player)..", does not exist!", 5)
                    end
                else
                    return getgenv().notify("Failed", tostring(player.Name)..", was not found in Booth Whitelist!", 5)
                end
            end
            
            removePlayerFromBoothTable(dawgUser)
        end,})
    else
        warn("[FALLBACK]: Not in MIC UP or MIC UP 17+, not loading Booth Whitelisting features.")
    end

    getgenv().WhitelistOtherScriptUser = Tab7:CreateInput({
    Name = "Whitelist Script/Flames User",
    CurrentValue = "User",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "AddingOtherScriptWhitelistUser",
    Callback = function(addThatUserHere)
        getgenv().script_whitelist_player = getgenv().script_whitelist_player or {}

        local bruhUser = findplr(addThatUserHere)

        if not bruhUser then
            return getgenv().notify("Failure", "Player was not found.", 6)
        end

        wait(0.2)
        local function addPlayerToScriptWhitelistTable(player)
            getgenv().script_whitelist_player[player.Name] = player
            wait(0.3)
            if getgenv().script_whitelist_player[player.Name] then
                getgenv().notify("Success!", tostring(player.Name)..", was added to Script Whitelist!", 5)
            end
        end
        
        addPlayerToScriptWhitelistTable(bruhUser)
    end,})

    getgenv().RemoveWhitelistScriptUser = Tab7:CreateInput({
    Name = "Remove Whitelist Script User",
    CurrentValue = "User",
    PlaceholderText = "User Here",
    RemoveTextAfterFocusLost = true,
    Flag = "RemovingScriptWhitelistUser",
    Callback = function(removeThatUserOverHere)
        getgenv().script_whitelist_player = getgenv().script_whitelist_player or {}

        local bruhUser = findplr(removeThatUserOverHere)

        if not bruhUser then
            return getgenv().notify("Failure", "Player was not found.", 6)
        end

        wait(0.2)
        local function removePlayerFromScriptWhitelistTable(player)
            if getgenv().script_whitelist_player[player.Name] then
                getgenv().script_whitelist_player[player.Name] = nil
                wait(0.2)
                if getgenv().script_whitelist_player[player.Name] == nil then
                    getgenv().notify("Success!", tostring(player.Name)..", was removed from the Script Whitelist!", 5)
                else
                    return getgenv().notify("Failed", tostring(player)..", does not exist!", 5)
                end
            else
                return getgenv().notify("Failed", tostring(player.Name)..", was not found in Script Whitelist!", 5)
            end
        end
        
        removePlayerFromScriptWhitelistTable(bruhUser)
    end,})

    if game.PlaceId == 97399198116506 then
        local ReplicatedStorage = getgenv().ReplicatedStorage
        local EventHandlers = ReplicatedStorage:FindFirstChild("EventHandlers")
        local Teleport_Function = EventHandlers:FindFirstChild("Matchmake")
        local ChangeSetting = EventHandlers:FindFirstChild("ChangeSetting")
        local ReadyToPlay = EventHandlers:FindFirstChild("ReadyToPlay")
        local Matchmaking = EventHandlers:FindFirstChild("Matchmaking")
        local MainMenu = Matchmaking:FindFirstChild("MainMenu")
        local BuyItem = EventHandlers:FindFirstChild("BuyItem")

        if game:IsLoaded() and getgenv().Character and getgenv().Character:FindFirstChild("Humanoid") then
            for i = 1, 25 do
                ReadyToPlay:FireServer()
            end
        end
        wait(0.3)
        getgenv().PauseMainMenu = Tab1:CreateButton({
        Name = "Pause (Go To Main Menu)",
        Callback = function()
            if MainMenu then
                MainMenu:InvokeServer()
            end
        end,})
    
        getgenv().PurchaseItem = Tab1:CreateInput({
        Name = "Purchase Tool (Specific Name)",
        CurrentValue = "Enter item Name here",
        PlaceholderText = "item Name",
        RemoveTextAfterFocusLost = true,
        Flag = "ItemInputName",
        Callback = function(itemEntered)
            if BuyItem then
                BuyItem:InvokeServer(tostring(itemEntered), "Tools")
            end
        end,})

        local detect_gc = getconnections or get_signal_cons
    
        if getgenv().bypassed_setup_anti_cheat then
            warn("Bypass AntiCheat For: Cellmates VC has already loaded.")
        elseif getgenv().bypassed_setup_anti_cheat == false and detect_gc then
            local player = getgenv().LocalPlayer
    
            local function disableConnectionsForPropertiesAndEvents(character)
                local humanoid = character:WaitForChild("Humanoid")
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                local detect_gc = getconnections or get_signal_cons
    
                local properties = {
                    {object = game.Workspace, property = "Gravity"},
                    {object = humanoid, property = "UseJumpPower"},
                    {object = humanoid, property = "JumpPower"},
                    {object = humanoid, property = "WalkSpeed"},
                    {object = humanoid, property = "HipHeight"},
                    {object = humanoid, property = "JumpHeight"},
                    {object = humanoidRootPart, property = "Position"},
                    {object = humanoidRootPart, property = "CFrame"},
                    {object = humanoidRootPart, property = "Velocity"},
                    {object = humanoidRootPart, property = "Size"},
                    {object = humanoidRootPart, property = "CanTouch"},
                }
    
                for _, propData in ipairs(properties) do
                    local object = propData.object
                    local property = propData.property
    
                    if object and object:GetPropertyChangedSignal(property) then
                        local connections = getconnections(object:GetPropertyChangedSignal(property))
                        for _, connection in ipairs(connections) do
                            connection:Disable()
                        end
                    else
                        getgenv().notify("Failure:", "Could not find signal: "..tostring(property)..", for: "..tostring(object.Name), 5)
                    end
                end
    
                local stateChangedConnections = getconnections(humanoid.StateChanged)
                for _, connection in ipairs(stateChangedConnections) do
                    connection:Disable()
                end
            end
    
            local function disableDescendantAddedChecks(character)
                local connections = getconnections(character.DescendantAdded)
                for _, connection in ipairs(connections) do
                    connection:Disable()
                end
            end
    
            local function disableChildAddedChecks(character)
                local connections = getconnections(character.ChildAdded)
                for _, connection in ipairs(connections) do
                    connection:Disable()
                end
            end
    
            local function setupCharacter(character)
                wait(0.2)
                character:WaitForChild("Humanoid", 0.4)
                disableConnectionsForPropertiesAndEvents(character)
                disableDescendantAddedChecks(character)
                disableChildAddedChecks(character)
            end
    
            local function monitorCharacter()
                if player.Character then
                    wait()
                    setupCharacter(player.Character)
                end
    
                player.CharacterAdded:Connect(function(character)
                    wait()
                    character:WaitForChild("Humanoid")
                    setupCharacter(character)
                end)
            end
    
            wait()
            monitorCharacter()
            getgenv().bypassed_setup_anti_cheat = true
        else
            warn("'getconnections' is not supported on this executor!")
        end
    else
        warn("Not in Cellmates (VC), not loading these features.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().DeletePlrBooth = Tab11:CreateButton({
        Name = "Delete Current Booth",
        Callback = function()
            for i = 1, 3 do
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

                if not getgenv().Oldest_AntiBoothStealer_CF then
                    getgenv().Oldest_AntiBoothStealer_CF = getgenv().getRoot(getgenv().Character).CFrame
                end
            
                local function getStall()
                    for _, v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
                        if v.Username.BillboardGui.TextLabel.Text == "Owned by: " .. getgenv().LocalPlayer.Name then
                            return v
                        end
                    end
                    return nil
                end

                local has_stall_exists = getStall()
                local booth_text

                if has_stall_exists then
                    booth_text = getStall():FindFirstChild("Text"):FindFirstChild("SurfaceGui"):FindFirstChild("TextLabel").Text
                    getgenv().text_for_booth = tostring(booth_text)
                else
                    booth_text = ""
                    getgenv().text_for_booth = tostring(booth_text)
                end
                wait()
                local function claimStall(stall)
                    if stall then
                        getgenv().StallClaimToggle:Set(true)
                        repeat
                            if not getgenv().AutoClaimEnabled then return end

                            Character:PivotTo(stall:GetPivot() + Vector3.new(0, 3, 0))
                            task.wait(0.5)
            
                            local proximityPrompt = stall:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt")
                            if proximityPrompt then
                                fireproximityprompt(proximityPrompt, 25)
                            else
                                warn("ProximityPrompt not found for the booth!")
                            end
            
                            task.wait(0.5)
                        until stall.Username.BillboardGui.TextLabel.Text == "Owned by: " .. getgenv().LocalPlayer.Name or not getgenv().AutoClaimEnabled

                        if getgenv().Oldest_AntiBoothStealer_CF then
                            Character:PivotTo(getgenv().Oldest_AntiBoothStealer_CF)
                            wait(0.1)
                            getgenv().StallClaimToggle:Set(false)
                            getgenv().ReplicatedStorage:FindFirstChild("UpdateBoothText"):FireServer(getgenv().text_for_booth, "Cinder", "SourceSans")
                            wait(0.2)
                            getgenv().text_for_booth = nil
                        end
                    end
                end
            
                local function monitorOwnership()
                    while getgenv().AutoClaimEnabled do
                        local stall = getStall()
                        if stall then
                            getgenv().Booth = stall
                            wait()
                            getgenv().OwnershipConnection = stall.Username.BillboardGui.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
                                if stall.Username.BillboardGui.TextLabel.Text ~= "Owned by: " .. getgenv().LocalPlayer.Name then
                                    claimStall(stall)
                                end
                            end)
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
                if plr_booth and getgenv().AutoClaimEnabled then
                    monitorOwnership()
                else
                    getgenv().AutoReclaimToggle:Set(false)
                    return getgenv().notify("Error:", "No booth found! Claim a booth and toggle this on.", 7.5)
                end
            else
                getgenv().AutoClaimEnabled = false
            
                if getgenv().OwnershipConnection then
                    getgenv().OwnershipConnection:Disconnect()
                    getgenv().OwnershipConnection = nil
                else
                    warn("Event not connected.")
                end
                
                if getgenv().Booth then
                    getgenv().Booth = nil
                end
                return 
            end            
        end,})
        wait(0.3)
        if getgenv().AutoClaimEnabled == true then
            getgenv().AutoClaimEnabled = false
            getgenv().AutoReclaimToggle:Set(false)
            if getgenv().Booth then
                getgenv().Booth = nil
            end
            if getgenv().OwnershipConnection then
                getgenv().OwnershipConnection:Disconnect()
                getgenv().OwnershipConnection = nil
            else
                warn("Event not connected.")
            end
        end

        getgenv().RainbowBoothClientSide = Tab11:CreateToggle({
        Name = "Rainbow Booth (Client Side)",
        CurrentValue = false,
        Flag = "BoothBeingRainbowClientSide",
        Callback = function(booth_rainbow_not_fe)
            if booth_rainbow_not_fe then
                local function retrieve_booth()
                    for _, v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
                        if v.Username.BillboardGui.TextLabel.Text == "Owned by: " .. getgenv().LocalPlayer.Name then
                            return v
                        end
                    end
                    return nil
                end

                local has_stall_exists = retrieve_booth()

                if not has_stall_exists then
                    getgenv().booth_colors_rgb_not_fe = false
                    getgenv().RainbowBoothClientSide:Set(false)
                    return getgenv().notify("Failure!", "No Booth found, please claim one and try again.", 5)
                end
                wait()
                getgenv().booth_colors_rgb_not_fe = true
                while getgenv().booth_colors_rgb_not_fe == true do
                wait()
                    local Workspace = getgenv().Workspace

                    local function cycle_colors(objects)
                        local colors = {
                            "Black", "Really red", "White", "Bright blue",
                            "New Yeller", "Toothpaste", "Royal purple", "Hot pink"
                        }
                        
                        while getgenv().booth_colors_rgb_not_fe == true do
                            for _, color in ipairs(colors) do
                                for _, part in ipairs(objects) do
                                    if part:IsA("BasePart") then
                                        part.BrickColor = BrickColor.new(color)
                                    end
                                end
                                task.wait(0.5)
                            end
                        end
                    end

                    if has_stall_exists then
                        local baseParts = {}
                        for _, v in ipairs(has_stall_exists:GetDescendants()) do
                            if v:IsA("BasePart") then
                                table.insert(baseParts, v)
                            end
                        end
                        task.spawn(cycle_colors, baseParts)
                    end
                end
            else
                local function retrieve_booth()
                    for _, v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
                        if v.Username.BillboardGui.TextLabel.Text == "Owned by: " .. getgenv().LocalPlayer.Name then
                            return v
                        end
                    end
                    return nil
                end

                local has_stall_exists = retrieve_booth()
                wait()
                getgenv().booth_colors_rgb_not_fe = false
                getgenv().booth_colors_rgb_not_fe = false
                getgenv().booth_colors_rgb_not_fe = false
                wait()
                if has_stall_exists then
                    for _, part in ipairs(has_stall_exists:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.BrickColor = BrickColor.new("Black")
                        end
                    end
                else
                    warn("Booth did not exist when turning off loop.")
                end
            end
        end,})
        wait()
        if getgenv().booth_colors_rgb_not_fe == true then
            getgenv().booth_colors_rgb_not_fe = false
            getgenv().RainbowBoothClientSide:Set(false)
        end
        wait(0.3)
        getgenv().DeleteOldCFrameConnection = Tab11:CreateButton({
        Name = "Delete Old CFrame (Anti-Booth Stealer)",
        Callback = function()
            if getgenv().Oldest_AntiBoothStealer_CF then
                getgenv().Oldest_AntiBoothStealer_CF = nil
            end
        end,})
        wait()
        if getgenv().Oldest_AntiBoothStealer_CF then
            getgenv().Oldest_AntiBoothStealer_CF = nil
        end
        wait()
        getgenv().LoopRemoveAllBooths = Tab11:CreateToggle({
        Name = "Loop Unclaim/Remove Every Booth",
        CurrentValue = false,
        Flag = "LoopGetRidOfAllBooths",
        Callback = function(doLoopUnclaimAll)
            if doLoopUnclaimAll then
                local Players = getgenv().Players
                local LocalPlayer = getgenv().LocalPlayer
                local Character = getgenv().Character
                local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
                local GetWorkspace = game:GetService("Workspace")
                local Folder = GetWorkspace:FindFirstChild("Map"):FindFirstChild("Booth") or GetWorkspace:FindFirstChild("Map"):WaitForChild("Booth") 
                
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
                        getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = getgenv().Oldest_CFrame
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
            local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            local GetWorkspace = getgenv().Workspace
            local Folder = GetWorkspace:FindFirstChild("Map"):FindFirstChild("Booth") or GetWorkspace:FindFirstChild("Map"):WaitForChild("Booth") 
            local Rep_Storage = getgenv().ReplicatedStorage
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
            getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = OldCF
        end,})

        getgenv().DeletePlrBooth = Tab11:CreateButton({
        Name = "Delete Current Booth",
        Callback = function()
            for i = 1, 20 do
                getgenv().ReplicatedStorage:FindFirstChild("DeleteBoothOwnership"):FireServer()
            end
        end,})

        getgenv().RemoveBooths = Tab11:CreateButton({
        Name = "Remove Every Booth",
        Callback = function()
            local Players = getgenv().Players
            local LocalPlayer = getgenv().LocalPlayer
            local Character = getgenv().Character
            local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            local GetWorkspace = getgenv().Workspace
            local Folder = GetWorkspace:FindFirstChild("Map"):FindFirstChild("Booth") or GetWorkspace:FindFirstChild("Map"):WaitForChild("Booth") 
            
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
            getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = OldCF
        end,})

        -- I plan to add more MAYBE soon.
        if executor_Name == "AWP" or executor_Name == "Zenith" or executor_Name == "Velocity" or executor_Name == "Wave" or executor_Name == "Swift" or executor_Name == "Ascendant" or executor_Name == "Sirhurt" then
            local Module_Require = require(getgenv().ReplicatedStorage:WaitForChild("Menu"):FindFirstChild("AI"):FindFirstChild("Constants"))

            -- Basically just gets rid of the AI generator delay, because this ModuleScript controls the delay entirely client-sided, so it also gets rid of that stupid timer, so when you open the Menu, you can do it yourself instead of having to have a script to do it for you.
            Module_Require["GENERATION_DELAY"] = 0
            if Module_Require["GENERATION_DELAY"] == 0 then
                print("Successfully set AI Generation Delay to 0!")
            else
                warn("Not an error, probably a mistake though, must have not changed or wasn't checked correctly.")
            end
        else
            warn("We we're not able to edit the cooldown of the AI generation section of the Menu, executor is not a whitelisted executor.")
        end
    else
        warn("Did not load these tabs [6].")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().ai_input_generator = Tab5:CreateInput({
        Name = "AI Input Generator (No Cooldown)",
        CurrentValue = "Input",
        PlaceholderText = "Input",
        RemoveTextAfterFocusLost = false,
        Flag = "AIGeneratorQuestion",
        Callback = function(ai_inputtedhere)
            local Premade_Input = tostring(ai_inputtedhere)
            wait(0.3)
            getgenv().ReplicatedStorage:WaitForChild("Menu"):FindFirstChild("AI"):FindFirstChild("MeshEvent"):FireServer(Premade_Input, Vector3.new(getgenv().Character:FindFirstChild("HumanoidRootPart").Position.X, getgenv().Character:FindFirstChild("HumanoidRootPart").Position.Y, getgenv().Character:FindFirstChild("HumanoidRootPart").Position.Z))
        end,})
    end

    getgenv().RemoveAllLaserEyes = Tab13:CreateToggle({
    Name = "Remove All Laser Eyes (Laggy Accessory people wear)",
    CurrentValue = false,
    Flag = "RemovingAllLaggyAccessories",
    Callback = function(doRemoveAnyLaserEyes)
        if doRemoveAnyLaserEyes then
            local skybox = game.Players:FindFirstChild("Solid Black Skybox")

            if skybox then
                skybox:Destroy()
            end
            wait(0.1)
            getgenv().removing_any_laser_eyes = true
            while getgenv().removing_any_laser_eyes == true do
            wait(0.6)
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player.Character then
                        for _, item in pairs(player.Character:GetChildren()) do
                            if item:IsA("Accessory") and item.Name == "Accessory (cooleyes)" then
                                item:Destroy()
                            end
                        end
                    end
                end
            end
        else
            getgenv().removing_any_laser_eyes = false
            getgenv().removing_any_laser_eyes = false
            getgenv().removing_any_laser_eyes = false
        end
    end,})
    
    getgenv().CopyAnimAddUser = Tab14:CreateInput({
    Name = "Add CopyAnim Whitelist",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Callback = function(thisUserGet)
        local Players = getgenv().Players
        local LocalPlayer = getgenv().LocalPlayer
        local Character = getgenv().Character
        local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
        local Workspace = getgenv().Workspace
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
        local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
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
        local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
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
        
        -- This looks so ChatGPT, but I wrote this a long fucking time ago, thought I was cooking, but I really didn't.
        local getTheirChar = thePlayer.Character or thePlayer.CharacterAdded:Wait()
        local theirHumanoid = getTheirChar:FindFirstChildWhichIsA('Humanoid') or getTheirChar:WaitForChild('Humanoid')
        
        -- And this is just from Infinite Yield, so go cry and whine about it dickface.
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
            
            -- I rewrote this dumb ass function from my Booth finder, where it's able to know if you have a Booth or not.
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
            local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            local LocalPlayer = getgenv().LocalPlayer
            local player = LocalPlayer
            local Players = getgenv().Players
            local Workspace = getgenv().Workspace

            local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
            local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
            
            if not thePlayer then
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
            local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
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
            
            if not thePlayer then
                return getgenv().notify("Error:", "Player was not found!", 7)
            end
            
            local Humanoid = Character:FindFirstChildWhichIsA("Humanoid") or Character:WaitForChild("Humanoid")
            local TheirCharacter = thePlayer.Character or thePlayer.CharacterAdded:Wait()
            local GetTheirHumanoid = TheirCharacter:FindFirstChildWhichIsA("Humanoid") or TheirCharacter:WaitForChild("Humanoid")
            
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
    wait(0.2)
    if getgenv().copyAllWhitelistedAnims == true then
        getgenv().copyAllWhitelistedAnims = false
        getgenv().copyAllWhitelistedAnims = false
        getgenv().LoopCopyTheEmotePlr:Set(false)
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
    Suffix = "Speed",
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
            local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            wait(0.1)
            getgenv().Jerking = true
            wait(0.1)
            getgenv().JerkAnim = Instance.new("Animation")
            getgenv().JerkAnim.AnimationId = (getgenv().r15_or_r6(getgenv().Character:FindFirstChildWhichIsA("Humanoid")) == true) and "rbxassetid://698251653" or "rbxassetid://168268306"
            getgenv().Jerk = getgenv().Character:FindFirstChildWhichIsA("Humanoid"):LoadAnimation(getgenv().JerkAnim)

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

    if not getgenv().OriginalMaterials then
        getgenv().OriginalMaterials = {}

        local function save_original_material()
            getgenv().OriginalMaterials = {}

            for _, v in pairs(getgenv().Workspace:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                    getgenv().OriginalMaterials[v] = { Material = v.Material, Reflectance = v.Reflectance }
                end
            end
        end

        save_original_material()
    else
        warn("Already have original materials! Materials Table: "..tostring(getgenv().OriginalMaterials))
    end
    wait(0.2)
    local HttpService = getgenv().HttpService
    wait(0.1)
    getgenv().OriginalMaterials = {}

    local function find_character_skip(part)
        local model = part:FindFirstAncestorOfClass("Model")
        if model and game.Players:GetPlayerFromCharacter(model) then
            return true
        end
        return false
    end
    
    local function set_new_materials(newMaterial)
        if not newMaterial or typeof(newMaterial) ~= "EnumItem" then
            return getgenv().notify("Failure", "Invalid material detected, try again.", 5)
        end
    
        for _, part in ipairs(getgenv().Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not find_character_skip(part) then
                if not getgenv().OriginalMaterials[part] then
                    getgenv().OriginalMaterials[part] = part.Material
                end
                part.Material = newMaterial
                part.Reflectance = 0
            end
        end
    end

    local function default_materials()
        for part, originalMaterial in pairs(getgenv().OriginalMaterials) do
            if part and part:IsA("BasePart") then
                part.Material = originalMaterial
            end
        end
        getgenv().OriginalMaterials = {}
        getgenv().notify("Success", "Materials have been reset to default.", 5)
    end
    wait(0.1)
    getgenv().MaterialForMap = Tab18:CreateDropdown({
    Name = "Map Material",
    Options = {
        "Plastic", "Wood", "Slate", "Concrete", "CorrodedMetal", "DiamondPlate",
        "Foil", "Grass", "Ice", "Marble", "Granite", "Brick", "Pebble", "Sand",
        "ForceField", "Fabric", "SmoothPlastic", "Metal", "WoodPlanks",
        "Cobblestone", "Air", "Water", "Rock", "Glacier", "Snow", "Sandstone",
        "Mud", "Basalt", "Ground", "CrackedLava", "Asphalt", "LeafyGrass", "Salt"
    },
    CurrentOption = "Plastic",
    MultipleOptions = false,
    Flag = "select_materials",
    Callback = function(selected_material)
        if typeof(selected_material) == "table" then
            selected_material = selected_material[1]
        end
        if typeof(selected_material) ~= "string" then
            return warn("Invalid material selected. Expected a string, got: " .. typeof(selected_material))
        end
        wait(0.1)
        local materialEnum = Enum.Material[selected_material]
        wait()
        if not materialEnum then
            return warn("Invalid material: " .. tostring(selected_material))
        end
        set_new_materials(materialEnum)
    end,})

    getgenv().ResetMaterialButton = Tab18:CreateButton({
    Name = "Reset Map Material",
    Callback = function()
        default_materials()
    end,})    
    wait()
    getgenv().OriginalTransparency = {}

    local function existing_character(part)
        local model = part:FindFirstAncestorOfClass("Model")
        return model and game.Players:GetPlayerFromCharacter(model) ~= nil or getgenv().Players:GetPlayerFromCharacter(model) ~= nil
    end
    
    local function set_new_transparency(newTransparency)
        if type(newTransparency) ~= "number" or newTransparency < 0 or newTransparency > 1 then
            return getgenv().notify("Failure", "Invalid transparency value. Must be between 0 and 1.", 5)
        end
    
        for _, part in ipairs(getgenv().Workspace:GetDescendants()) do
            if (part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("UnionOperation")) and not existing_character(part) then
                if getgenv().OriginalTransparency[part] == nil then
                    getgenv().OriginalTransparency[part] = part.Transparency
                end
                part.Transparency = newTransparency
            end
        end
    end
    
    local function default_transparency()
        for part, originalTransparency in pairs(getgenv().OriginalTransparency) do
            if part and part:IsA("BasePart") then
                part.Transparency = originalTransparency
            end
        end
    end
    
    getgenv().MapTransparencySliding = Tab18:CreateSlider({
    Name = "Map Transparency",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0,
    Flag = "MapTransparencyLevel",
    Callback = function(ezNewTransparency)
        set_new_transparency(ezNewTransparency)
    end,})

    getgenv().ResetMapTransparencyToDefault = Tab18:CreateButton({
    Name = "Reset Map Transparency",
    Callback = function()
        default_transparency()
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
            local Workspace = getgenv().Workspace
            local Map = Workspace:FindFirstChild("Map")
            if Map then
                local Important = Map:FindFirstChild("Important")
                wait(0.1)
                if Important then
                    local Baseplate_Folder = Important:FindFirstChild("Baseplate")

                    if Baseplate_Folder then
                        local Baseplate_Part = Baseplate_Folder:FindFirstChild("Baseplate")

                        if Baseplate_Part then
                            Baseplate_Part.Transparency = BasePlateMICUPTransparency
                        else
                            warn("Baseplate Part not found inside of Baseplate Folder.")
                        end
                    else
                        warn("Baseplate Folder not found inside of Important Folder.")
                    end
                else
                    warn("Important Folder not found inside of Map.")
                end

                return 
            else
                warn("Map Folder not found inside of Workspace.")
            end
            task.wait(.1)
            local Map_Folder = Workspace:FindFirstChild("Map")
            local GameFolder = Map_Folder:FindFirstChild("Game")
            local Important_Folder = Map_Folder:FindFirstChild("Important")
            local Baseplate_Folder = Important_Folder:FindFirstChild("Baseplate")
            local Baseplate_Part = Baseplate_Folder:FindFirstChild("Baseplate")
            if GameFolder and Baseplate_Folder then
                local BasePlate_1 = Baseplate_Part
                if BasePlate_1 then
                    BasePlate_1.Transparency = BasePlateMICUPTransparency
                else
                    warn("Baseplate not found inside Game.")
                end
            else
                warn("Neither Baseplate Folder nor the Game Folder exist in the Map Folder in Workspace.")
            end
        end,})
        wait(0.2)
        if getgenv().Workspace:FindFirstChild("Map") then
            local Map_Folder = getgenv().Workspace:FindFirstChild("Map")
            local Important_Folder = Map_Folder:FindFirstChild("Important")
            local Baseplate_Folder = Important_Folder:FindFirstChild("Baseplate")
            local Baseplate_Part = Baseplate_Folder:FindFirstChild("Baseplate")
            local BasePlate = Baseplate_Part

            if BasePlate then
                BasePlate.Transparency = 1
            else
                warn("BasePlate does not exist!")
            end
        elseif getgenv().Workspace:FindFirstChild("RoomExtra") then
            if getgenv().Workspace:FindFirstChild("RoomExtra"):FindFirstChild("Baseplate") then
                for _, v in ipairs(getgenv().Workspace:FindFirstChild("RoomExtra"):GetDescendants()) do
                    if v:FindFirstChild("Baseplate") then
                        v.Transparency = 1
                    else
                        warn("BasePlate_1 (Regular MIC UP Baseplate) does not exist.")
                    end
                end
            end
        else
            warn("BasePlate here was not found.")
        end
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
            elseif getgenv().Workspace:FindFirstChild("Baseplate") then
                local Base_plate = getgenv().Workspace:FindFirstChild("Baseplate")

                Base_plate.Transparency = BasePlateMICUPTransparency
            else
                warn("BasePlate here was not found.")
            end
        end,})
    else
        warn("This game is not MIC UP or MIC UP 17+ or German Hangout, BasePlate not being loaded.")
    end

    if not getgenv().OriginalColors then
        getgenv().OriginalColors = {}

        local function isPartOfCharacter(part)
            for _, player in ipairs(getgenv().Players:GetPlayers()) do
                if player.Character and part:IsDescendantOf(player.Character) then
                    return true
                end
            end
            return false
        end

        for _, descendant in ipairs(getgenv().Workspace:GetDescendants()) do
            if (descendant:IsA("BasePart") or descendant:IsA("MeshPart") or descendant:IsA("UnionOperation")) and not isPartOfCharacter(descendant) then
                getgenv().OriginalColors[descendant] = descendant.Color
            end
        end
    end
    wait(0.1)
    getgenv().Change_Map_Color = Tab18:CreateColorPicker({
    Name = "Change Map Color (Tiny Spike)",
    Color = Color3.fromRGB(45, 45, 45),
    Flag = "PickingColorForMap",
    Callback = function(Map_Color)
        for part, _ in pairs(getgenv().OriginalColors) do
            if part and part.Parent then
                part.Color = Map_Color
            end
        end
    end,})

    local function find_mic_up_baseplate()
        local Workspace = getgenv().Workspace
        local Map = Workspace:FindFirstChild("Map")
        if Map then
            local Important = Map:FindFirstChild("Important")
            wait(0.1)
            if Important then
                local Baseplate_Folder = Important:FindFirstChild("Baseplate")

                if Baseplate_Folder then
                    local Baseplate_Part = Baseplate_Folder:FindFirstChild("Baseplate")

                    if Baseplate_Part then
                        return Baseplate_Part
                    else
                        warn("Baseplate Part not found inside of Baseplate Folder.")
                    end
                else
                    warn("Baseplate Folder not found inside of Important Folder.")
                end
            else
                warn("Important Folder not found inside of Map.")
            end

            return 
        else
            warn("Map Folder not found inside of Workspace.")
        end

        return nil
    end

    local function find_mic_up_baseplate_2()
        local Workspace = getgenv().Workspace
        local Room_Extra = Workspace:FindFirstChild("RoomExtra")

        if Room_Extra then
            for _, v in ipairs(Room_Extra:GetChildren()) do
                if v:IsA("BasePart") then
                    print(v)
                end
            end
        end
    end

    local Found_Baseplate = false
    getgenv().Has_Found_Successfully_Baseplate = Found_Baseplate
    getgenv().Found_Baseplates = getgenv().Found_Baseplates or {}
    getgenv().Baseplate_OriginalColors = getgenv().Baseplate_OriginalColors or {}

    task.wait(0.1)

    local function find_baseplate()
        for _, v in ipairs(getgenv().Workspace:GetDescendants()) do
            if v:IsA("BasePart") and string.find(v.Name:lower(), "baseplate") then
                Found_Baseplate = true
                getgenv().Has_Found_Successfully_Baseplate = true
                table.insert(getgenv().Found_Baseplates, v)
                if not getgenv().Baseplate_OriginalColors[v] then
                    getgenv().Baseplate_OriginalColors[v] = v.Color
                end
                return v
            end
        end
        return nil
    end

    function save_old_baseplate_color()
        if getgenv().Has_Found_Successfully_Baseplate then
            for _, baseplate in ipairs(getgenv().Found_Baseplates) do
                if baseplate and baseplate:IsA("BasePart") then
                    getgenv().Baseplate_OriginalColors[baseplate] = baseplate.Color
                end
            end
        end
    end
    wait(0.2)
    getgenv().RainbowBaseplate_Universal = Tab18:CreateToggle({
    Name = "Rainbow Baseplate (Universal)",
    CurrentValue = false,
    Flag = "RainbowBaseplate_UniversalWorking",
    Callback = function(Always_Rainbow_Baseplate_Ez)
        if Always_Rainbow_Baseplate_Ez then
            local find_baseplate_func = find_baseplate()
            if not find_baseplate_func then
                getgenv().rainbow_universal_baseplate_ez = false
                getgenv().RainbowBaseplate_Universal:Set(false)
                return getgenv().notify("Failure:", "Could not find a Baseplate in the current experience!", 5)
            end

            local TweenService = getgenv().TweenService
            local Workspace = getgenv().Workspace
            local Terrain
            getgenv().rainbow_universal_baseplate_ez = true

            local colors = {
                Color3.fromRGB(0, 255, 255),
                Color3.fromRGB(0, 0, 0),
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(128, 128, 128),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(255, 105, 180),
                Color3.fromRGB(75, 0, 130),
                Color3.fromRGB(50, 205, 50),
                Color3.fromRGB(255, 20, 147),
                Color3.fromRGB(138, 54, 15),
                Color3.fromRGB(191, 64, 191),
                Color3.fromRGB(255, 215, 0),
                Color3.fromRGB(255, 140, 0)
            }

            local colorIndex = 1

            local function applyTweenColor(part, newColor)
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                local tween = TweenService:Create(part, tweenInfo, { Color = newColor })
                tween:Play()
            end

            local function updateColors()
                while getgenv().rainbow_universal_baseplate_ez == true do
                    local newColor = colors[colorIndex]
                    applyTweenColor(find_baseplate_func, newColor)
                    colorIndex = (colorIndex % #colors) + 1
                    task.wait(1)
                end
            end

            task.spawn(updateColors)
        else
            getgenv().rainbow_universal_baseplate_ez = false
            wait(0.1)
            getgenv().rainbow_universal_baseplate_ez = false
            wait(0.3)
            for i = 1, 10 do
                getgenv().rainbow_universal_baseplate_ez = false
            end
            wait(0.5)
            local Original_Color_Baseplate = save_old_baseplate_color()
            local find_baseplate_func = find_baseplate()

            find_baseplate_func.Color = Original_Color_Baseplate
        end
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().BasePlate_ColorChange = Tab18:CreateColorPicker({
        Name = "MIC UP BasePlate Color",
        Color = Color3.fromRGB(255, 0, 0),
        Flag = "PickingColorForMap",
        Callback = function(Base_Color)
            local Mic_Up_Baseplate = find_mic_up_baseplate()
            
            if Mic_Up_Baseplate then
                Mic_Up_Baseplate.Color = Base_Color
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
            local Baseplate_Local = find_mic_up_baseplate_2()
            
            if Baseplate_Local then
                Baseplate_Local.Size = Vector3.new(Size_New, Baseplate_Local.Size.Y, Baseplate_Local.Size.Z)
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
            local Baseplate_Local_Z = find_mic_up_baseplate_2()
            
            if Baseplate_Local_Z then
                Baseplate_Local.Size = Vector3.new(Baseplate_Local_Z.Size.X, Baseplate_Local_Z.Size.Y, Sized_Z)
            end
        end,})
    elseif game.PlaceId == 136162036182779 then
        local Shared = getgenv().ReplicatedStorage:FindFirstChild("Shared")
        local Communication = Shared and Shared:FindFirstChild("Communication")
        local Remote = Communication and Communication:FindFirstChild("Remote")
        local Focus_RF = Remote and Remote:FindFirstChild("Focus")

        function change_AFK(boolean)
            if boolean == true then
                Focus_RF:InvokeServer(true) -- Sets AFK visibility tag to false, so basically people cannot see the "AFK" tag.
            elseif boolean == false then
                Focus_RF:InvokeServer(false) -- Sets AFK visibility tag to true, basically letting other people see the "AFK" tag.
            else
                return -- Don't do anything if incorrect arguments are entered/passed (duh).
            end
        end
        wait(0.2)
        function flash_AFK_title(toggle)
            if toggle == true then
                getgenv().flashing_AFK_Title_Toggle = true
                while getgenv().flashing_AFK_Title_Toggle == true do
                task.wait()
                    change_AFK(false)
                    task.wait(0)
                    change_AFK(true)
                end
            elseif toggle == false then
                getgenv().flashing_AFK_Title_Toggle = false
                getgenv().flashing_AFK_Title_Toggle = false
            else
                return 
            end
        end

        getgenv().BasePlate_ColorChange = Tab18:CreateColorPicker({
        Name = "German Hangout BasePlate Color",
        Color = Color3.fromRGB(255, 0, 0),
        Flag = "PickingColorForMap",
        Callback = function(Base_Color)
            local Map = getgenv().Workspace:FindFirstChild("Map")
            if Map then
                local Lobby_Folder = Map:FindFirstChild("Lobby")

                if Lobby_Folder then
                    local Baseplate_Part = Lobby_Folder:FindFirstChild("Baseplate")

                    if Baseplate_Part then
                        Baseplate_Part.Color = Base_Color
                    end
                end
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
            local Map = getgenv().Workspace:FindFirstChild("Map")
            if Map then
                local Lobby_Folder = Map:FindFirstChild("Lobby")

                if Lobby_Folder then
                    local Baseplate_Part = Lobby_Folder:FindFirstChild("Baseplate")

                    if Baseplate_Part then
                        Baseplate_Part.Size = Vector3.new(Size_New, Baseplate_Part.Size.Y, Baseplate_Part.Size.Z)
                    end
                end
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
            local Map = getgenv().Workspace:FindFirstChild("Map")
            if Map then
                local Lobby_Folder = Map:FindFirstChild("Lobby")

                if Lobby_Folder then
                    local Baseplate_Part = Lobby_Folder:FindFirstChild("Baseplate")

                    if Baseplate_Part then
                        Baseplate_Part.Size = Vector3.new(Baseplate_Part.Size.X, Baseplate_Part.Size.Y, Sized_Z)
                    end
                end
            end
        end,})

        getgenv().Flash_AFK_Title_Toggle = Tab2:CreateToggle({
        Name = "Flash AFK Title (FE, German Hangout)",
        CurrentValue = false,
        Flag = "GermanHangoutAFKFlashFE",
        Callback = function(GermanHangout_AFK_Title_Enabled)
            if GermanHangout_AFK_Title_Enabled then
                flash_AFK_title(true)
            else
                flash_AFK_title(false)
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
            getgenv().notify("Failed:", "Player was not found!", 5)
        end
    end,})

    --[[getgenv().PlayEmoteButFrozen = Tab12:CreateDropdown({
    Name = "Play Emote (Loop)",
    Options = safeEmotes,
    CurrentOption = "Shuffle",
    MultipleOptions = false,
    Flag = "LoopingPlayEmote",
    Callback = function(idForEmoting)
        if getgenv().Humanoid.RigType == Enum.HumanoidRigType.R6 then return getgenv().notify("[Error]:", "You must be R15 to play emotes!", 5) end
        wait()
        local emoteToLoopDo = type(idForEmoting) == "table" and idForEmoting[1] or tostring(idForEmoting)
        local Players = getgenv().Players
        local AvatarEditorService = getgenv().Service_Wrap("AvatarEditorService")
        local LocalPlayer = getgenv().LocalPlayer
        local Character = getgenv().Character
        local Humanoid = getgenv().Humanoid
        local Description = Humanoid:FindFirstChildOfClass("HumanoidDescription") or Instance.new("HumanoidDescription", Humanoid)

        local function PlayEmoteByCatalogName(emoteName)
            local params = CatalogSearchParams.new()
            params.SearchKeyword = emoteName
            params.AssetTypes = { Enum.AvatarAssetType.EmoteAnimation }
            params.SortType = Enum.CatalogSortType.Relevance
            params.IncludeOffSale = true
            params.Limit = 120

            local success, result = pcall(function()
                return AvatarEditorService:SearchCatalog(params)
            end)

            if not success or not result then
                return 
            end

            local page
            if typeof(result) == "Instance" and result:IsA("Pages") and result.IsFinished then
                page = result
            elseif typeof(result) == "table" then
                page = result
            else
                return 
            end

            local emotes = page:GetCurrentPage() or page

            if not emotes or #emotes == 0 then
                return
            end

            local match
            for _, emote in ipairs(emotes) do
                if emote.Name:lower() == emoteName:lower() then
                    match = emote
                    break
                end
            end

            match = match or emotes[1]

            if not match then
                return
            end

            local id = match.Id
            local name = match.Name

            if LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                return getgenv().notify("Failure:", "R6 Rigs cannot play Emote's, please be R15!", 5)
            end

            local success2 = pcall(function()
                return Humanoid:PlayEmoteAndGetAnimTrackById(id)
            end)

            if not success2 then
                Description:AddEmote(name, id)
                Humanoid:PlayEmoteAndGetAnimTrackById(id)
            end
        end

        PlayEmoteByCatalogName(emoteToLoopDo)
        wait(0.1)
        for _, v in ipairs(getgenv().Humanoid:GetPlayingAnimationTracks(getgenv().Humanoid)) do
            v.Looped = true
        end
    end,})--]]
    print("30")
    getgenv().StopEmoteLooping = Tab12:CreateButton({
    Name = "Stop Loop Emoting",
    Callback = function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You have to be in R15 to use this!", 5)
        end

        if getgenv().Character:FindFirstChild("Animate") and getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == true then
            getgenv().Character:FindFirstChild("Animate").Disabled = false
        end
        wait(0.2)
        for _, animTrack in pairs(getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
        wait(0.1)
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        end
        wait(0.2)
        if getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored or getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored == true then
            getgenv().FrozenChar:Set(false)
            getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
            wait(0.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        end
    end,})

    print("31")

    getgenv().PlayEmoteWithIDNum = Tab12:CreateInput({
    Name = "Play Emote (ID, works with UGC emotes!)",
    PlaceholderText = "Enter ID",
    RemoveTextAfterFocusLost = true,
    Callback = function(getTheIDForEmote)
        if getgenv().Humanoid.RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You have to be in R15 to use this!", 5)
        end

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

    print("32")

    getgenv().StopTheEmotes = Tab12:CreateButton({
    Name = "Stop Emoting",
    Callback = function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You have to be in R15 to use this!", 5)
        end

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        end
        wait(0.3)
        for _, animTrack in pairs(getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
            animTrack:Stop()
        end
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().quickAvChange = Tab13:CreateToggle({
        Name = "Change Avatar Quick [WILL Lag!⚠️]",
        CurrentValue = false,
        Flag = "quickAvChange",
        Callback = function(quickAv)
            if quickAv then
                local players = getgenv().Players
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
                        
                        getgenv().ReplicatedStorage:WaitForChild("ModifyUsername"):FireServer(unpack(args))
                    end
                end
            else
                getgenv().ava_switch = false
                wait(0.3)
                local args = {
                    [1] = tostring(getgenv().LocalPlayer.Name)
                }
                
                getgenv().ReplicatedStorage:WaitForChild("ModifyUsername"):FireServer(unpack(args))
            end
        end,})
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
                    "Flames Hub [WINNING]!",
                    "Join: VJh3kkYzBn",
                    "Flames Hub [WE UP]!",
                    "Flames Hub V6, POWERFUL!",
                    "Powering Automation | Scripting",
                    "Flames Hub | WE OP!",
                    "Flames Hub | WE SIGMA",
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

    getgenv().GraphicsEnhancer = Tab9:CreateToggle({
    Name = "Graphics Enhancer",
    CurrentValue = false,
    Flag = "GraphicsEnhancerToggling",
    Callback = function(new_graphics_toggle)
        if new_graphics_toggle then
            wait(1)
            getgenv().graphics_upper = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/PublicScriptsOnRobloxExploiting/refs/heads/main/GraphicsEnhancer.lua"))()
        else
            wait(0.5)
            getgenv().graphics_upper = false
            wait()
            getgenv().graphics_upper = false
            wait(0.1)
            resetLightingSettings()
            wait(0.5)
        end
    end,})
    wait(0.1)
    if getgenv().graphics_upper == true then
        getgenv().graphics_upper = false
        getgenv().GraphicsEnhancer:Set(false)
        wait(0.3)
        resetLightingSettings()
    end
    wait()
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
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                wait()
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit = true
                for i = 1, 360 do 
                    delay(i / 720, function()
                        if not getgenv().zeezyEnabled then return end
                        getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit = true
                        getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.Angles(-h, 0, 0)
                    end)
                end
                wait(0.55)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit = false
            end
        end
        
        function zeezyBackflip(act, inp, obj)
            if not getgenv().zeezyEnabled then return end
            if inp == Enum.UserInputState.Begin then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                wait()
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit = true
                for i = 1, 360 do
                    delay(i / 720, function()
                        if not getgenv().zeezyEnabled then return end
                        getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit = true
                        getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.Angles(h, 0, 0)
                    end)
                end
                wait(0.55)
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit = false
            end
        end
        
        function zeezyAirjump(act, inp, obj)
            if not getgenv().zeezyEnabled then return end
            if inp == Enum.UserInputState.Begin then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState("Seated")
                wait()
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)	
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
            Duration = 5,
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

    getgenv().ForceFullyRejoinVC = Tab21:CreateButton({
    Name = "Force Rejoin VC",
    Callback = function()
        getgenv().VoiceChatInternal:Leave()
        wait(0.2)
        getgenv().VoiceChatService:rejoinVoice()
        getgenv().VoiceChatService:rejoinVoice()
        wait(0.1)
        getgenv().VoiceChatService:joinVoice()
        wait(0.3)
        getgenv().VoiceChatInternal:Leave()
        task.wait(.3)
        getgenv().VoiceChatService:rejoinVoice()
        getgenv().VoiceChatService:joinVoice()
    end,})

    getgenv().LeaveVCToFix = Tab21:CreateButton({
    Name = "Leave VC (Should fix some VC connection issues)",
    Callback = function()
        getgenv().VoiceChatInternal:Leave()
        getgenv().VoiceChatInternal:Leave()
    end,})

    getgenv().joinTheVoiceChatFederalMethod = Tab21:CreateButton({
    Name = "Join Voice Chat (Federal Method)",
    Callback = function()
        getgenv().VoiceChatInternal:JoinByGroupIdToken('', false, true)
        getgenv().VoiceChatInternal:JoinByGroupId('', false)
    end,})

    getgenv().RejoinVCFederalMethod = Tab21:CreateButton({
    Name = "Rejoin Voice Chat (Federal Method)",
    Callback = function()
        getgenv().VoiceChatInternal:JoinByGroupIdToken("", false, true)
    end,})

    getgenv().SetPrioritySpeaker = Tab21:CreateButton({
    Name = "Become Priority Speaker",
    Callback = function()
        getgenv().VoiceChatInternal:PublishPause(false)
        wait(0.1)
        getgenv().VoiceChatInternal:SetSpeakerDevice('Default', '')
    end,})

    getgenv().RegularJoinVC = Tab21:CreateButton({
    Name = "Join Voice Chat (Regular Method)",
    Callback = function()
        getgenv().VoiceChatService:joinVoice()
        getgenv().VoiceChatService:joinVoice()
    end,})

    getgenv().RegularRejoinVoiceFunction = Tab21:CreateButton({
    Name = "Rejoin Voice Chat (Regular Method)",
    Callback = function()
        getgenv().VoiceChatService:rejoinVoice()
        getgenv().VoiceChatService:joinVoice()
        getgenv().VoiceChatService:rejoinVoice()
    end,})

    getgenv().BreakVCToFix = Tab21:CreateButton({
    Name = "Fix Voice Chat (Break Method)",
    Callback = function()
        for i = 1, 4 do
            getgenv().VoiceChatInternal:Leave()
            getgenv().VoiceChatService:rejoinVoice()
            getgenv().VoiceChatService:rejoinVoice()
            getgenv().VoiceChatService:joinVoice()
            getgenv().VoiceChatInternal:Leave()
            getgenv().VoiceChatService:rejoinVoice()
            getgenv().VoiceChatInternal:Leave()
            task.wait()
            getgenv().VoiceChatService:joinVoice()
            getgenv().VoiceChatService:rejoinVoice()
        end
    end,})
    wait()
    local UserInputService = getgenv().UserInputService

    local running = false
    local fKey = Enum.KeyCode.Z
    local speed = 1
    local distSlider = 3
    local conn
    local heartConn
    wait()

    local function stop()
        getgenv().loaded_face_bang = false
        if conn then
            conn:Disconnect()
            conn = nil
        end
        local hum = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.PlatformStand = false
        end
        running = false
    end

    local function fuck()
        if running then return end
        running = true

        local plr = getgenv().LocalPlayer
        local hrp = getgenv().Character:FindFirstChild("HumanoidRootPart") or getgenv().Character:WaitForChild("HumanoidRootPart")
        local hum = getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:WaitForChild("Humanoid")
        local closest, dist = nil, math.huge

        getgenv().loaded_face_bang = true

        for _, target in ipairs(game:GetService('Players'):GetPlayers()) do
            if target ~= plr and target.Character then
                local head = target.Character:FindFirstChild('Head')
                if head then
                    local d = (head.Position - hrp.Position).Magnitude
                    if d < dist then
                        closest = target
                        dist = d
                    end
                end
            end
        end

        if not closest or not hrp then
            running = false
            return
        end

        hum.PlatformStand = true
        local head = closest.Character:FindFirstChild("Head")
        local init = true
        local out = true
        local min = -0.9
        local base = 2
        local last = tick()
        local prog = 0

        conn = getgenv().RunService.Heartbeat:Connect(function()
            hrp.Velocity = Vector3.new(0, 0, 0)
            local back = head.CFrame * CFrame.new(0, 0, 1)
            local front = head.CFrame * CFrame.new(0, 0, -1)
            local bPos = back.Position
            local fPos = front.Position
            local dir = (bPos - fPos).Unit
            local max = -distSlider

            if init then
                local pos = bPos + dir * max
                hrp.CFrame = CFrame.new(pos + Vector3.new(0, 0.5, 0))
                init = false
                last = tick()
                return
            end

            local now = tick()
            local dt = now - last
            last = now

            local spd = base * (speed or 1)

            if out then
                prog = math.min(1, prog + dt * spd)
            else
                prog = math.max(0, prog - dt * spd)
            end

            local curr = min + (max - min) * prog
            local target = bPos + dir * curr
            local pos = hrp.Position
            local new = pos:Lerp(target, 0.5) + Vector3.new(0, 0.5, 0)
            local hCF = head.CFrame
            hrp.CFrame = CFrame.new(new) * (hCF - hCF.Position) * CFrame.Angles(0, math.rad(180), 0)

            if prog >= 1 or prog <= 0 then
                out = not out
            end
        end)
    end

    wait()
    if heartConn then
        heartConn:Disconnect()
    end

    local function modify_key(newKey)
        fKey = newKey
    end

    getgenv().faceBangScript = Tab16:CreateToggle({
    Name = "Face F**k Script (Press Key)",
    CurrentValue = false,
    Flag = "FaceFuckingToggle",
    Callback = function(face_Bang_Animation)
        local enabled = face_Bang_Animation

        if getgenv().loaded_face_bang then
            getgenv().loaded_face_bang = false
            wait()
            if getgenv().heartFaceFckConn then
                getgenv().heartFaceFckConn:Disconnect()
                getgenv().heartFaceFckConn = nil
            end
            stop()
            wait(1)
            getgenv().loaded_face_bang = true
            wait(0.1)
            if getgenv().heartFaceFckConn then
                getgenv().heartFaceFckConn:Disconnect()
                getgenv().heartFaceFckConn = nil
            end
        end

        if enabled then
            getgenv().loaded_face_bang = true
            wait(0.1)
            if getgenv().heartFaceFckConn then
                getgenv().heartFaceFckConn:Disconnect()
                getgenv().heartFaceFckConn = nil
            end

            getgenv().heartFaceFckConn = getgenv().UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == fKey then
                    fuck()
                end
            end)
            task.wait()
            UserInputService.InputEnded:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == fKey then
                    stop()
                end
            end)
        else
            getgenv().loaded_face_bang = false
            wait()
            if getgenv().heartFaceFckConn then
                getgenv().heartFaceFckConn:Disconnect()
                getgenv().heartFaceFckConn = nil
            end
            stop()
        end
    end,})

    getgenv().Change_Face_Bang_Keybind = Tab16:CreateKeybind({
    Name = "Face F**k Keybind",
    CurrentKeybind = "Z",
    HoldToInteract = false,
    Flag = "faceBangingKeybind",
    Callback = function(new_face_bang_keycode)
        if not new_face_bang_keycode or new_face_bang_keycode == "" then
            new_face_bang_keycode = getgenv().Change_Face_Bang_Keybind.CurrentKeybind
            if not new_face_bang_keycode then
                return warn("No valid keybind found.")
            end
        end

        if typeof(new_face_bang_keycode) == "EnumItem" then
            fKey = new_face_bang_keycode
        elseif typeof(new_face_bang_keycode) == "string" then
            local foundKey = Enum.KeyCode[new_face_bang_keycode:upper()]
            if foundKey then
                fKey = foundKey
            else
                warn("Invalid keybind:", new_face_bang_keycode)
            end
        else
            warn("Unexpected keybind type:", typeof(new_face_bang_keycode))
        end
    end,})

    getgenv().Face_Bang_Speed = Tab16:CreateSlider({
    Name = "Face F**k Speed",
    Range = {1, 100},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "faceBangingSpeedSet",
    Callback = function(set_face_fuck_speed)
        speed = set_face_fuck_speed / 2
    end,})

    getgenv().Distance_Face_Bang = Tab16:CreateSlider({
    Name = "Face F**k Distance",
    Range = {1, 60},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "faceBangingDistance",
    Callback = function(max_distance)
        distSlider = max_distance
    end,})

    wait(0.2)
    getgenv().noclipToggle = Tab2:CreateToggle({
    Name = "Noclip",
    CurrentValue =  false,
    Flag = "toggleNoclipChar",
    Callback = function(noclip_toggle)
        getgenv().Noclip_Connection = nil

        if noclip_toggle then
            Clip = false
            getgenv().Noclip_Enabled = true
            getgenv()._noclipModifiedParts = {}

            local function NoclipLoop()
                if not Clip and getgenv().Character then
                    for _, part in ipairs(getgenv().Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                            getgenv()._noclipModifiedParts[part] = true
                        end
                    end
                end
            end

            getgenv().Noclip_Connection = RunService.Stepped:Connect(NoclipLoop)
        else
            if getgenv().Noclip_Connection then
                getgenv().Noclip_Connection:Disconnect()
            end
            Clip = true
            getgenv().Noclip_Enabled = false

            if getgenv()._noclipModifiedParts then
                for part, _ in pairs(getgenv()._noclipModifiedParts) do
                    if part and part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
                getgenv()._noclipModifiedParts = nil
            end
        end
    end,})
    wait()
    if game.PlaceId == 135275461271957 or game.PlaceId == 78589782053833 then
        if getgenv().PlayerGui:FindFirstChild("Notification") then
            getgenv().PlayerGui:FindFirstChild("Notification"):Destroy()
        end
    end
    wait()
    getgenv().FlyNoclip = Tab16:CreateToggle({
    Name = "Noclip Toggle For Fly",
    CurrentValue = false,
    Flag = "toggleNoclipForFly",
    Callback = function(noclipToggleFly)
        if noclipToggleFly then
            if getgenv().Noclip_Enabled then
                getgenv().FlyNoclip:Set(false)
                return getgenv().notify("Failure:", "Noclip is already enabled.", 5)
            else
                getgenv().noclipToggle:Set(true)
            end
        end
    end,})

    if game.PlaceId == 135275461271957 or game.PlaceId == 78589782053833 then
        getgenv().CollectAllFootballs = Tab1:CreateToggle({
        Name = "Collect All Footballs",
        CurrentValue = false,
        Flag = "DoAllFootballs",
        Callback = function(supportForAllFootballs)
            if supportForAllFootballs then
                getgenv().doing_all_footballs_ez = true
                while getgenv().doing_all_footballs_ez == true do
                wait(0.4)
                    for _, v in ipairs(getgenv().Workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name == "Football" then
                            firetouchinterest(v, getgenv().Character:FindFirstChild("HumanoidRootPart"), 1)
                            wait()
                            firetouchinterest(v, getgenv().Character:FindFirstChild("HumanoidRootPart"), 0)
                        end
                    end
                end
            else
                getgenv().doing_all_footballs_ez = false
                getgenv().doing_all_footballs_ez = false
            end
        end,})
    end

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
        if getgenv().antiFlingEnabled == true then
            anti_fling_toggle_saved = true
            if getgenv().AntiFlingToggle then
                getgenv().AntiFlingToggle:Set(false)
                getgenv().notify("Alert:", "Turned off Anti Fling for 'Fly' to work properly.", 6)
            else
                return getgenv().notify("Error:", "Please disable 'Anti Fling' for 'Fly' to work properly", 6)
            end
        end
        wait()
        if getgenv().AntiTeleport == true then
            anti_teleport_toggle_saved = true
            if getgenv().AntiTeleport_Univ then
                getgenv().AntiTeleport_Univ:Set(false)
                getgenv().notify("Alert:", "Turned off Anti Teleport for 'Fly' to work properly.", 6)
            else
                return getgenv().notify("Error:", "Please disable 'Anti Teleport' for 'Fly' to work properly.", 6)
            end
        end

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
                local character = getgenv().Character
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
            local player = getgenv().LocalPlayer
            local character = getgenv().Character
            local rootPart = getgenv().HumanoidRootPart
            local humanoid = getgenv().Humanoid

            if anti_teleport_toggle_saved == true then
                if getgenv().AntiFlingToggle then
                    getgenv().notify("Alert:", "Turning 'Anti Teleport' back on, it was enabled before.", 5)
                    getgenv().AntiFlingToggle:Set(true)
                    anti_fling_toggle_saved = false
                end
            end

            if anti_fling_toggle_saved == true then
                if getgenv().AntiFlingToggle then
                    getgenv().notify("Alert:", "Turning 'Anti Fling' back on, it was enabled before.", 5)
                    getgenv().AntiFlingToggle:Set(true)
                    anti_fling_toggle_saved = false
                end
            end

            if getgenv().Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Gyro-Fly") then
                getgenv().Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Gyro-Fly"):Destroy()
            else
                warn("nil - BodyGyro")
            end
            wait(0.1)
            if getgenv().Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Velocity-Fly") then
                getgenv().Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Velocity-Fly"):Destroy()
            else
                warn("nil - BodyVelocity")
            end
            wait(0.2)
            rootPart.Velocity = Vector3.zero
            rootPart.AssemblyLinearVelocity = Vector3.zero
            rootPart.AssemblyAngularVelocity = Vector3.zero

            rootPart.CFrame = CFrame.new(rootPart.Position - Vector3.new(0, 10, 0))

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
            local character = getgenv().Character
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
        Speed = 1.7
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
        local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        local character = getgenv().Character
        local humanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

        getgenv().flashback = getgenv().flashback or {}
        local flashback = getgenv().flashback
        
        function flashback:Advance(character, humanoidRootPart, humanoid)
            if #frames > flashbackLength * 60 then
                table.remove(frames, 1)
            end

            if getgenv().Character:FindFirstChild("HumanoidRootPart") then
                table.insert(frames, {
                    humanoidRootPart.CFrame,
                    humanoidRootPart.Velocity,
                    humanoid:GetState(),
                    humanoid.PlatformStand
                })
            end
        end
        
        function flashback:Revert(character, humanoidRootPart, humanoid)
            if getgenv().Character:FindFirstChild("HumanoidRootPart") and getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
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
                
                if lastFrame and lastFrame[1] then
                    getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = lastFrame[1]
                end
                wait(.3)
                if lastFrame and lastFrame[2] then
                    getgenv().Character:FindFirstChild("HumanoidRootPart").Velocity = -lastFrame[2]
                else
                    warn("LastFrame[2] not detected at runtime, skipping...")
                end
                if lastFrame and lastFrame[3] then
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(lastFrame[3])
                else
                    warn("LastFrame[3] not detected at runtime, skipping...")
                end
                if lastFrame and lastFrame[4] then
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = lastFrame[4]
                else
                    warn("LastFrame[4] not detected at runtime, skipping...")
                end
            end
        end
        
        local function onRenderStep()
            if getgenv().Character:FindFirstChild("HumanoidRootPart") and getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
                local character = getgenv().Character
                local humanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
                local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                
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
        end        
        
        repeat wait(0.5) until character and humanoid and humanoidRootPart
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

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().InfoLabelParagraph = Tab13:CreateParagraph({Title = "Information:", Content = "Type 'stop' to stop flying."})
        wait()
        getgenv().InfoLabelParagraph_2 = Tab13:CreateParagraph({Title = "Controls:", Content = "Space = Up | Q = Down"})
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
                    wait(0.3)
                    if getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Hoverboard") then
                        getgenv().LocalPlayer:FindFirstChildOfClass("Backpack"):FindFirstChild("Hoverboard").Parent = getgenv().Character
                    elseif getgenv().Character:FindFirstChild("Hoverboard") then
                        warn("Already in Character.")
                    else
                        getgenv().getHoverboardFlyInput:Set(false)
                        return getgenv().notify("Failure:", "Hoverboard was not found in Backpack or Character, disabling...", 5)
                    end
                    wait(0.5)
                    local player = getgenv().LocalPlayer
                    local character = getgenv().Character
                    local humanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
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

                    getgenv().RunService.RenderStepped:Connect(function()
                        if flying then
                            updateFly()
                        end
                    end)

                    startFly()           
                elseif tostring(GetSpeed) or GetSpeed == "stop" then
                    local RunService = getgenv().RunService
                    local ReplicatedStorage = getgenv().ReplicatedStorage
                    
                    wait(0.3)
                    getgenv().flyLoop = false
                    wait(0.2)
                    local player = getgenv().LocalPlayer
                    local character = getgenv().Character
                    local humanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
                    local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")

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

        getgenv().HoverboardFlyStopFlying = Tab13:CreateButton({
        Name = "Stop Hoverboard Flying",
        Callback = function()
            local RunService = getgenv().RunService
            local ReplicatedStorage = getgenv().ReplicatedStorage
            
            wait(0.3)
            getgenv().flyLoop = false
            wait(0.2)
            local player = getgenv().LocalPlayer
            local character = getgenv().Character
            local humanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")

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
                getgenv().Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
                getgenv().flyLoop = false
            end
            wait(0.2)
            stopFly()
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
                for i,v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
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
                wait(0.1)
                getgenv().Camera.CameraSubject = getgenv().Character
            end
        end,})
        wait(0.1)
        if getgenv().viewing_booth == true then
            getgenv().viewing_booth = false
            getgenv().viewBooth:Set(false)
            getgenv().Camera.CameraSubject = getgenv().Character
        end

        getgenv().TPToBooth = Tab11:CreateButton({
        Name = "Teleport To Booth",
        Callback = function()
            local function get_booth()
                for i,v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
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
            local Avatar_UI = getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("AvatarUI")
            local Like_Button = Avatar_UI:FindFirstChild("LikeButton") or Avatar_UI:WaitForChild("LikeButton")
            local Click_Detector_Input = Like_Button:FindFirstChild("ClickDetector")

            if likeLol then
                if fireclickdetector then
                    getgenv().alrLike = true
                    while getgenv().alrLike == true do
                    wait(0.5)
                        fireclickdetector(Click_Detector_Input)
                    end
                else
                    getgenv().alrLike = false
                    return getgenv().notify("Error:", "Your executor does not support 'fireclickdetector'", 7)
                end
            else
                getgenv().alrLike = false
                wait(0.3)
                getgenv().alrLike = false
            end
        end,})
        wait()
        if getgenv().alrLike == true then
            getgenv().alrLike = false
            getgenv().AutoLikingPlayer:Set(false)
        end

        getgenv().dislikePlayersAvatar = Tab1:CreateToggle({
        Name = "[Avatar-UI]: Auto Dislike Player",
        CurrentValue = false,
        Flag = "dislikingEverybody",
        Callback = function(dislikeButton)
            if dislikeButton then
                local Avatar_UI = getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("AvatarUI")
                local dislikingButton = Avatar_UI:FindFirstChild("DislikeButton") or Avatar_UI:WaitForChild("DislikeButton")
                local Click_Detector_Input = dislikingButton:FindFirstChild("ClickDetector")
                
                if fireclickdetector then
                    getgenv().Disliking = true
                    while getgenv().Disliking == true do
                    wait(0.9)
                        fireclickdetector(Click_Detector_Input)
                    end
                else
                    getgenv().Disliking = false
                    return getgenv().notify("Error:", "Your executor does not support 'fireclickdetector'", 7)
                end
            else
                getgenv().Disliking = false
                wait(0.2)
                getgenv().Disliking = false
                wait(1.2)
                for i = 1, 40 do
                    getgenv().Disliking = false
                end
            end
        end,})
        wait(0.2)
        if getgenv().Disliking == true then
            getgenv().Disliking = false
            getgenv().dislikePlayersAvatar:Set(false)
        end
    else
        warn("User is not in MIC UP or MIC UP 17+, not loading.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        if firesignal then
            getgenv().Stop_Music_Player = Tab1:CreateButton({
            Name = "Stop In-Game Music",
            Callback = function()
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
                local Shuffle_Music_Frame = getgenv().LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Menu"):WaitForChild("Background"):WaitForChild("Music"):WaitForChild("Shuffle")
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
                    local Players = getgenv().Players
                    local Local_Player = getgenv().LocalPlayer
                    local Menu = getgenv().PlayerGui:WaitForChild("Menu")
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
                    wait(1)
                    local Local_Player = getgenv().LocalPlayer
                    local Menu = getgenv().PlayerGui:WaitForChild("Menu")
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
            wait()
            if getgenv().plr_music_menu == true then
                getgenv().plr_music_menu = false
                getgenv().Music_Player:Set(false)
            end
        else
            warn("'firesignal' unsupported, not loading In-Game music functions.")
        end
    else
        warn("Not MIC UP or MIC UP 17+, not loading In-Game music functions.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 and executor_Name ~= "Ronix" then
        if fireclickdetector then
            local function find_real_friend()
                for _, v in ipairs(game.Players:GetPlayers()) do
                    if v:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                        return v
                    end
                end
                return nil
            end

            local friend_find = find_real_friend()
            wait(0.1)
            getgenv().WhitelistFriendPlr = Tab1:CreateToggle({
            Name = "[Avatar-UI]: Auto Like Friends",
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
                    
                    if not friend_find then
                        getgenv().WhitelistFriendPlr:Set(false)
                        getgenv().Like_Friends = false
                        return getgenv().notify("Error:", "You have '0' friends in this server!", 6)
                    end
                    
                    function like_friend_only(user)
                        if user then
                            local expectedURL = "rbxthumb://type=Avatar&id=" .. tostring(user.UserId) .. "&w=420&h=420"
                            if Image_Label.Image == expectedURL then
                                fireclickdetector(Click_Detector_Input)
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
                        end
                    else
                        getgenv().Like_Friends = false
                        wait(0.2)
                        getgenv().Like_Friends = false
                    end
                else
                    getgenv().Like_Friends = false
                    wait(0.2)
                    getgenv().Like_Friends = false
                end
            end,})
            wait()
            if getgenv().Like_Friends == true then
                getgenv().Like_Friends = false
                getgenv().WhitelistFriendPlr:Set(false)
            end
        else
            warn("Your executor does not support 'fireclickdetector'.")
        end
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
        getgenv().notify("Failure!", "Your executor does is garbage.", 5)
    end

    if getgenv().LocalPlayer:FindFirstChildOfClass("AudioDeviceInput") then
        getgenv().MutingMyself = Tab21:CreateToggle({
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

        getgenv().defaulting_keybind_for_muting_microphone = "M"
        wait()
        getgenv().EzMuteKeybind = Tab21:CreateDropdown({
        Name = "Mute Keybind",
        Options = {"Q","E", "R", "T", "Y", "U", "I", "O", "P", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M", "Comma", "Period", "Question", "Semicolon", "Colon", "LeftAlt", "RightAlt", "LeftControl", "RightControl", "LeftBracket", "RightBracket", "BackSlash", "Pipe", "LeftCurly", "RightCurly", "Underscore", "Minus", "LeftParenthesis", "RightParenthesis", "Asterisk", "Slash", "GreaterThan", "LessThan", "Backquote", "At", "Equals", "Caret", "Hash", "Dollar", "Percent", "Ampersand", "Quote", "QuotedDouble", "Plus", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "Print", "Help", "Compose", "Menu", "Euro", "ButtonX", "ButtonA", "ButtonY", "ButtonB", "ButtonR1", "ButtonL1", "ButtonL2", "ButtonR2", "ButtonL3", "ButtonStart", "ButtonSelect", "DPadLeft", "DPadRight", "DPadUp", "DPadDown", "Thumbstick1", "Thumbstick2"},
        CurrentOption = tostring(getgenv().defaulting_keybind_for_muting_microphone),
        MultipleOptions = false,
        Flag = "theMuteKeybindUsing",
        Callback = function(theNewKeybindToSet)
            if typeof(theNewKeybindToSet) == "table" then
                theNewKeybindToSet = theNewKeybindToSet[1]
            end

            if typeof(theNewKeybindToSet) == "string" and Enum.KeyCode[theNewKeybindToSet] then
                getgenv().other_mute_keybind_enum_saved = Enum.KeyCode[theNewKeybindToSet]
                getgenv().defaulting_keybind_for_muting_microphone = theNewKeybindToSet
            else
                warn("Invalid keybind selection.")
            end
        end,})
        wait(0.2)
        if not getgenv().defaulting_keybind_for_muting_microphone then
            getgenv().defaulting_keybind_for_muting_microphone = tostring(getgenv().defaulting_keybind_for_muting_microphone)
        end

        local keybindString = getgenv().defaulting_keybind_for_muting_microphone

        if Enum.KeyCode[keybindString] then
            getgenv().other_mute_keybind_enum_saved = Enum.KeyCode[keybindString]
        else
            warn("Invalid keybind string:", keybindString)
            getgenv().other_mute_keybind_enum_saved = Enum.KeyCode.RightControl
        end

        local Workspace, Players, ReplicatedStorage, UserInputService

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

        if getgenv().already_loaded_mute_keybind then
            warn("Already initialized mute keybind.")
        else
            local function toggle_mute()
                local player = Players.LocalPlayer
                if not player then return end

                if player:FindFirstChildOfClass("AudioDeviceInput") then
                    local audioInput = player:FindFirstChildOfClass("AudioDeviceInput")
                    if audioInput then
                        audioInput.Muted = not audioInput.Muted
                        getgenv().notify("Success", audioInput.Muted and "Muted Microphone." or "Unmuted Microphone.", 6)
                    end
                elseif getgenv().VoiceChatInternal then
                    getgenv().VoiceChatInternal:SubscribePause(player.UserId, not getgenv().VoiceChatInternal:IsSubscribePaused(player.UserId))
                    wait(0.1)
                    local vc_result_paused = getgenv().VoiceChatInternal:IsSubscribePaused(player.UserId)
                    getgenv().notify("Success", vc_result_paused and "Muted Microphone." or "Unmuted Microphone.", 6)
                else
                    warn("Voice Chat is either not turned on or is not enabled in the current game | Cannot load 'Mute Keybind'.")
                end
            end

            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                if input.KeyCode == getgenv().other_mute_keybind_enum_saved then
                    toggle_mute()
                end
            end)

            wait(0.1)
            getgenv().already_loaded_mute_keybind = true
        end
    end

    print("33")

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().DelInventory = Tab5:CreateButton({
        Name = "Delete Inventory",
        Callback = function()
            local Replicated_Storage = getgenv().ReplicatedStorage
            local Delete_Inv_RemoteEvent = Replicated_Storage:WaitForChild("DeleteInventory") or Replicated_Storage:FindFirstChild("DeleteInventory")
            
            Delete_Inv_RemoteEvent:FireServer()
        end,})

        function Tools_Grab_Func()
            local Players = getgenv().Players
            local MarketplaceService = cloneref and cloneref(game:GetService("MarketplaceService")) or game:GetService("MarketplaceService")
            local player = Players.LocalPlayer
            local gamepassId = 951459548

            local success, hasPass = pcall(function()
                return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId) or MarketplaceService:PlayerOwnsAsset(getgenv().LocalPlayer, gamepassId)
            end)
            if success and hasPass then
                print(tostring(player.Name).." owns this GamePass, moving on.")
            else
                getgenv().shouldGrabTools = false
                getgenv().shouldGrabTools = false
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
    else
        warn("Not on MIC UP, not loading these features.")
    end

    getgenv().AntiChatSpy = Tab4:CreateToggle({
    Name = "Anti Chat Spy",
    CurrentValue = false,
    Flag = "EnableAntiChatSpySpamLogs",
    Callback = function(enabling_anti_chat_spy)
        if enabling_anti_chat_spy then
            getgenv().anti_chat_spy = true
            while getgenv().anti_chat_spy == true do
            task.wait()
                getgenv().Players:Chat(randomString())
            end
        else
            getgenv().anti_chat_spy = false
        end
    end,})

    if hookfunction and hookmetamethod then
        getgenv().ChatBypassBest = Tab4:CreateButton({
        Name = "Anti Chat Log/Anti Screenshot",
        Callback = function()
            if not game:IsLoaded() then
                game.Loaded:wait()
            end

            task.wait(3)

            local ACL_LoadTime = tick()
            local NotificationTitle = "Anthony's ACL"

            local OldCoreTypeSettings = {}
            local WhitelistedCoreTypes = {
                "Chat",
                "All",
                Enum.CoreGuiType.Chat,
                Enum.CoreGuiType.All
            }

            local OldCoreSetting = nil

            local CoreGui = game:GetService("CoreGui")
            local StarterGui = getgenv().StarterGui or game:GetService("StarterGui")
            local TweenService = getgenv().TweenService or game:GetService("TweenService")
            local TextChatService = getgenv().TextChatService or game:GetService("TextChatService")
            local Players = getgenv().Players or game:GetService("Players")
            local Player = getgenv().LocalPlayer or Players.LocalPlayer

            local Notify = function(_Title, _Text , Time)
                StarterGui:SetCore("SendNotification", {Title = _Title, Text = _Text, Icon = "rbxassetid://2541869220", Duration = Time})
            end

            local Tween = function(Object, Time, Style, Direction, Property)
                return TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle[Style], Enum.EasingDirection[Direction]), Property)
            end

            local PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui") do
                if not PlayerGui then
                    local Timer = tick() + 5
                    repeat task.wait() until Player:FindFirstChildWhichIsA("PlayerGui") or (tick() > Timer)
                    PlayerGui = Player:FindFirstChildWhichIsA("PlayerGui") or false
                    if not PlayerGui then
                        return Notify(NotificationTitle, "Failed to find PlayerGui!", 10)
                    end
                end
            end

            if getgenv().AntiChatLogger then
                return Notify(NotificationTitle, "Anti Chat & Screenshot Logger already loaded!", 15)
            else
                getgenv().AntiChatLogger = true
            end

            local Metatable = getrawmetatable(StarterGui)
            setreadonly(Metatable, false)

            local MessageEvent = Instance.new("BindableEvent")

            if hookmetamethod then
                local CoreHook do
                    CoreHook = hookmetamethod(StarterGui, "__namecall", newcclosure(function(self, ...)
                        local Method = getnamecallmethod()
                        local Arguments = {...}
                        
                        if self == StarterGui and not checkcaller() then
                            if Method == "SetCoreGuiEnabled" then
                                local CoreType = Arguments[1]
                                local Enabled = Arguments[2]
                                
                                if table.find(WhitelistedCoreTypes, CoreType) and Enabled == false then -- Thanks Harun for correcting me on the second argument
                                    OldCoreTypeSettings[CoreType] = Enabled
                                    return
                                end
                            elseif Method == "SetCore" then
                                local Core = Arguments[1]
                                local Connection = Arguments[2]
                                
                                if Core == "CoreGuiChatConnections" then
                                    OldCoreSetting = Connection
                                    return
                                end
                            end
                        end
                        
                        return CoreHook(self, ...)
                    end))
                end

                if not getgenv().ChattedFix then
                    if hookmetamethod then
                        getgenv().ChattedFix = true

                        local ChattedFix do
                            ChattedFix = hookmetamethod(Player, "__index", newcclosure(function(self, index)
                                if self == Player and tostring(index):lower():match("chatted") and MessageEvent.Event then
                                    return MessageEvent.Event
                                end

                                return ChattedFix(self, index)
                            end))
                        end

                        local AnimateChattedFix = task.spawn(function()
                            local ChattedSignal = false

                            for _, x in next, getgc() do
                                if type(x) == "function" and getfenv(x).script ~= nil and tostring(getfenv(x).script) == "Animate" then
                                    if islclosure(x) then
                                        local Constants = getconstants(x)

                                        for _, v in next, Constants do
                                            if v == "Chatted" then
                                                ChattedSignal = x
                                            end
                                        end
                                    end
                                end
                            end

                            if ChattedSignal then
                                ChattedSignal()
                            end
                        end)
                    end
                end
            end

            local EnabledChat = task.spawn(function()
                repeat
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
                    task.wait()
                until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
            end)

            if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                getgenv().notify("Failure:", "Detected new chat, loading Anti Screenshot...", 5)
                if setfflag then
                    pcall(function()
                        setfflag("AbuseReportScreenshot", "False")
                        setfflag("AbuseReportScreenshotPercentage", "0")
                        getgenv().notify("Success:", "Just Anti Screenshot was loaded.", 5)
                        task.wait(0.2)
                        getgenv().notify("Success:", "Because your using the new TextChatService.", 5)
                    end)
                else
                    getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
                end
                return 
            end

            local PlayerScripts = Player:WaitForChild("PlayerScripts")
            local ChatMain = PlayerScripts:FindFirstChild("ChatMain", true) or false

            if not ChatMain then
                local Timer = tick()
                
                repeat task.wait() until PlayerScripts:FindFirstChild("ChatMain", true) or tick() > (Timer + 3)
                ChatMain = PlayerScripts:FindFirstChild("ChatMain", true)
                
                if not ChatMain then
                    getgenv().notify("Failure:", "Did not find ChatMain, loading Anti Screenshot instead...", 5)
                    if setfflag then
                        pcall(function()
                            setfflag("AbuseReportScreenshot", "False")
                            setfflag("AbuseReportScreenshotPercentage", "0")
                            getgenv().notify("Success:", "Just Anti Screenshot was loaded.", 5)
                            task.wait(0.2)
                            getgenv().notify("Success:", "Because we could not find ChatMain LocalScript.", 5)
                        end)
                    else
                        getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
                    end
                    return
                end
            end

            local PostMessage = require(ChatMain).MessagePosted

            if not PostMessage then
                getgenv().notify("Failure:", "PostMessage could not be located, loading Anti Screenshot...", 5)
                if setfflag then
                    pcall(function()
                        setfflag("AbuseReportScreenshot", "False")
                        setfflag("AbuseReportScreenshotPercentage", "0")
                        getgenv().notify("Success:", "Just Anti Screenshot was loaded.", 5)
                        task.wait(0.2)
                        getgenv().notify("Success:", "Because we could not properly allocate PostMessage ModuleScript.", 5)
                    end)
                else
                    getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
                end
                return
            end

            local OldFunctionHook; OldFunctionHook = hookfunction(PostMessage.fire, function(self, Message)
                if self == PostMessage then
                    MessageEvent:Fire(Message)
                    return
                end
                return OldFunctionHook(self, Message)
            end)

            if setfflag then
                pcall(function()
                    setfflag("AbuseReportScreenshot", "False")
                    setfflag("AbuseReportScreenshotPercentage", "0")
                end)
            else
                getgenv().notify("Warning:", "Your executor does not support 'fflag' to run this!", 6)
            end -- To prevent roblox from taking screenshots of your client.

            local Credits = task.spawn(function()
                local UserIds = {
                    1414978355
                }
                
                if table.find(UserIds, Player.UserId) then
                    return
                end
                
                local Tag = Instance.new("BillboardGui")
                local Title = Instance.new("TextLabel", Tag)
                local Rank = Instance.new("TextLabel", Tag)
                local Gradient = Instance.new("UIGradient", Title)
                
                Tag.Brightness = 2
                Tag.Size = UDim2.new(4, 0, 1, 0)
                Tag.StudsOffsetWorldSpace = Vector3.new(0, 5, 0)
                
                Title.BackgroundTransparency = 1
                Title.Size = UDim2.new(1, 0, .6, 0)
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                
                Rank.AnchorPoint = Vector2.new(.5, 0)
                Rank.BackgroundTransparency = 1
                Rank.Position = UDim2.new(.5, 0, .65, 0)
                Rank.Size = UDim2.new(.75, 0, .5, 0)
                Rank.TextColor3 = Color3.fromRGB(0, 0, 0)
                Rank.TextScaled = true
                Rank.Text = "< Anti Chat-Logger >"
                
                Gradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(.75, .75, .75)),
                    ColorSequenceKeypoint.new(.27, Color3.new(0, 0, 0)),
                    ColorSequenceKeypoint.new(.5, Color3.new(.3, 0, .5)),
                    ColorSequenceKeypoint.new(0.78, Color3.new(0, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.new(.75, .75, .75))
                })
                Gradient.Offset = Vector2.new(-1, 0)
                
                local GradientTeen = Tween(Gradient, 2, "Circular", "Out", {Offset = Vector2.new(1, 0)})
                
                function PlayAnimation()
                    GradientTeen:Play()
                    GradientTeen.Completed:Wait()
                    Gradient.Offset = Vector2.new(-1, 0)
                    task.wait(.75)
                    PlayAnimation()
                end
                
                local AddTitle = function(Character)
                    repeat task.wait() until Character
                    
                    local Humanoid = Character and Character:WaitForChild("Humanoid")
                    local RootPart = Humanoid and Humanoid.RootPart
                    
                    if Humanoid then
                        Humanoid:GetPropertyChangedSignal("RootPart"):Connect(function()
                            if Humanoid.RootPart then
                                Tag.Adornee = RootPart
                            end
                        end)
                    end
                    
                    if RootPart then
                        Tag.Adornee = RootPart
                    end
                end
                
                task.spawn(PlayAnimation)
                
                for _, x in next, Players:GetPlayers() do
                    if table.find(UserIds, x.UserId) then
                        Tag.Parent = workspace.Terrain
                        Title.Text = x.Name
                        AddTitle(x.Character)
                        x.CharacterAdded:Connect(AddTitle)
                    end
                end
                
                Players.PlayerAdded:Connect(function(x)
                    if table.find(UserIds, x.UserId) then
                        Tag.Parent = workspace.Terrain
                        Title.Text = x.Name
                        x.CharacterAdded:Connect(AddTitle)
                    end
                end)
                
                Players.PlayerRemoving:Connect(function(x)
                    if table.find(UserIds, x.UserId) then
                        Tag.Parent = game
                    end
                end)
            end)

            for _, x in next, OldCoreTypeSettings do
                if not x then
                    StarterGui:SetCore("ChatActive", false)
                end
                StarterGui:SetCoreGuiEnabled(_, x)
            end

            if OldCoreSetting then
                StarterGui:SetCore("CoreGuiChatConnections", OldCoreSetting)
            end

            if StarterGui:GetCore("ChatActive") then
                StarterGui:SetCore("ChatActive", false)
                StarterGui:SetCore("ChatActive", true)
            end

            --Metatable.__namecall = CoreHook
            if CoreHook then
                setmetatable(Metatable, {__namecall = CoreHook}) 
            end
            setreadonly(Metatable, true)

            Notify(NotificationTitle, "Anti Chat & Screenshot Logger Loaded!", 15)
            print(string.format("AnthonyIsntHere's Anti Chat-Logger has loaded in %s seconds.", string.format("%.2f", tostring(tick() - ACL_LoadTime))))
        end,})
    else
        getgenv().notify("Warning:", "Your executor does not support hookfunction or hookmetamethod.", 5)
        warn("Hookmetamethod or hookfunction not supported, skipping anti chat log/anti screenshot.")
    end
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
        for i = 1, 5 do
            getgenv().sending_async(".")
        end
        for i = 1, 300 do
            getgenv().Players:Chat("???????????")
        end
        task.wait(0.3)
        getgenv().sending_async("/cls")
    end,})

    getgenv().color_for_esp_value = Color3.fromRGB(255, 255, 255)
    getgenv().RAINBOW_MODE = false
    wait()
    if Drawing then
        local ESP_Boxes = {}
        local Connections = {}
        local RenderConnection = nil
        local BOX_ESP_ENABLED = true

        local function init_box_lines()
            return {
                TL = Drawing.new("Line"),
                TR = Drawing.new("Line"),
                BL = Drawing.new("Line"),
                BR = Drawing.new("Line"),
            }
        end

        local function delete_box(box)
            if box then
                for _, line in pairs(box) do
                    if line and line.Remove then
                        line:Remove()
                    elseif line and line.Destroy then
                        line:Destroy()
                    end
                end
            end
        end

        local function remove_box_esp(player)
            delete_box(ESP_Boxes[player])
            ESP_Boxes[player] = nil
        end

        local function refresh_box(player, box)
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character and character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 0.3)
            if not hrp then
                delete_box(box)
                ESP_Boxes[player] = nil
                return
            end

            local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            if not onScreen then
                for _, line in pairs(box) do
                    line.Visible = false
                end
                return
            end

            local sizeY = 3
            local height = 80
            local width = 80

            local topLeft = Vector2.new(pos.X - width, pos.Y - height)
            local topRight = Vector2.new(pos.X + width, pos.Y - height)
            local bottomLeft = Vector2.new(pos.X - width, pos.Y + height)
            local bottomRight = Vector2.new(pos.X + width, pos.Y + height)

            box.TL.From = topLeft
            box.TL.To = topRight

            box.TR.From = topRight
            box.TR.To = bottomRight

            box.BR.From = bottomRight
            box.BR.To = bottomLeft

            box.BL.From = bottomLeft
            box.BL.To = topLeft

            for _, line in pairs(box) do
                line.Color = Color3.fromRGB(255, 0, 0)
                line.Thickness = 1
                line.Visible = true
            end
        end

        local function box_esp_main(player)
            if player == LocalPlayer then return end
            if ESP_Boxes[player] then return end

            local function handle_char(char)
                if ESP_Boxes[player] then
                    delete_box(ESP_Boxes[player])
                end
                ESP_Boxes[player] = init_box_lines()

                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    local conn = hum.Died:Connect(function()
                        delete_box(ESP_Boxes[player])
                        ESP_Boxes[player] = nil
                    end)
                    table.insert(Connections, conn)
                end
            end

            if player.Character then
                handle_char(player.Character)
            end

            local conn = player.CharacterAdded:Connect(handle_char)
            table.insert(Connections, conn)
        end

        local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")

        -- You don't really need this, we don't really care for configuration that much right now.
        getgenv().esplib = {
            box = {
                enabled = true, -- Not necessary either especially, and that goes for healthbar, name, etc.
                type = "normal",
                padding = 1.15,
                fill = Color3.new(1,1,1), -- Filler options tbh.
                outline = Color3.new(0,0,0),
            },
            healthbar = {
                enabled = true,
                fill = Color3.new(0,1,0),
                outline = Color3.new(0,0,0),
            },
            name = {
                enabled = true,
                fill = Color3.new(1,1,1),
                size = 16,
            },
            distance = {
                enabled = true,
                fill = Color3.new(1,1,1),
                size = 150,
            },
            tracer = {
                enabled = true,
                fill = Color3.new(1,1,1),
                outline = Color3.new(0,0,0),
                from = "mouse",
            },
        }

        getgenv().EspBox = Tab19:CreateToggle({
        Name = "Box",
        CurrentValue = false,
        Flag = "TogglingBoxESP",
        Callback = function(box_Esp)
            if box_Esp then
                for _, player in pairs(getgenv().Players:GetPlayers()) do
                    -- Added partial checks to ensure everything is properly initialized first, before actually loading, ensuring we run into 0 errors.
                    if player ~= getgenv().LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                        wait(0.5)
                        local character = player.Character or player.CharacterAdded:Wait() -- Actually wait for the Character to load, unlike other ESP menu's.

                        esplib.add_box(character)
                    end
                end

                getgenv().Players.PlayerAdded:Connect(function(player)
                    player.CharacterAdded:Connect(function(char)
                        player.CharacterAdded:Wait()
                        repeat wait() until char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart")
                        task.wait(0.5)
                        if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                            esplib.add_box(char)
                        end
                    end)
                end)
            else
                -- to be honest, smarter than a bunch of other scripts, like Infinite Yield who don't do this for some reason, so it never turns off fully if someone joins again (or resets and respawns).
                wait(0.1)
                esplib.remove_box()
                wait(0.2)
                esplib.remove_box()
                wait(0.2)
                esplib.remove_box()
            end
        end,})
    else
        warn("❌ - Drawing - ❌ | Unsupported, ESP is not able to initialize due to 'Drawing' being unsupported or unavailable.") -- Also not a prominent option to display public warnings about ESP.
    end

    local highlights = {}
    local connections = {}
    local highlight_color = Color3.fromRGB(255, 255, 255)
    local rainbow_connection

    local function Highlight(player)
        if player == LocalPlayer then return end
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        if highlights[player] and highlights[player].Adornee == char then return end

        if highlights[player] then
            highlights[player]:Destroy()
            highlights[player] = nil
        end

        local hl = Instance.new("Highlight")
        hl.Name = "ESP_Highlight" -- Not a secure name at all for ESP, since game's can search the "game" DataModel for the string: "ESP" or "esp", and kick you if found.
        hl.Adornee = char
        hl.FillColor = highlight_color
        hl.OutlineColor = Color3.fromRGB(255, 255, 255) -- Default to white to preserve user personalization's and preferences.
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Not always recommended, but recommended since it works more than other options.
        hl.Parent = char -- nil sometimes, parented to Workspace but usually not helpful in games like Bad Business which put Character's in other Folders and not directly in Workspace.
        highlights[player] = hl
    end

    local function RemoveHighlight(player)
        if highlights[player] then
            highlights[player]:Destroy()
            highlights[player] = nil
        end
        -- should add extra security here.
    end

    wait(0.2)
    -- just wrap both in the same function, you'll be fine ( [ clear_highlights(), and: disconnect_all() ] )
    local function disconnect_all()
        for _, conn in ipairs(connections) do
            if conn.Disconnect then conn:Disconnect() end
        end
        table.clear(connections)
    end

    local function clear_highlights()
        for _, hl in pairs(highlights) do
            if hl and hl.Destroy then -- tbh, I will admit ChatGPT wrote that part, never needed a check for destroying Highlight ESP.
                hl:Destroy()
            end
        end
        -- actually ensure ESP is cleared out fully, since you don't need leftover table highlights when disabling Highlight ESP, since Highlight ESP is weird.
        -- since it's not made using the Drawing API, basically.
        table.clear(highlights)
    end

    function shutdown_esp()
        disconnect_all()
        clear_highlights()
        if rainbow_connection then
            rainbow_connection:Disconnect()
            rainbow_connection = nil
        end
    end

    getgenv().Name_DrawingESP = Tab19:CreateToggle({
    Name = "Name ESP",
    CurrentValue = false,
    Flag = "MainESP_Name",
    Callback = function(esp_name_ESP)
        if esp_name_ESP then
            for _, player in pairs(getgenv().Players:GetPlayers()) do
                if player ~= getgenv().LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                    wait(0.5)
                    local character = player.Character or player.CharacterAdded:Wait()

                    esplib.add_name(character)
                end
            end

            getgenv().Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(char)
                    player.CharacterAdded:Wait()
                    repeat wait() until char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart")
                    task.wait(0.5)
                    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                        esplib.add_name(char)
                    end
                end)
            end)
        else
            -- add checks here to ensure user does not still have Name ESP loaded on-screen, since Drawing Library on other executors, like Solara tend to bug out often.
            wait(0.1)
            esplib.remove_name()
            wait(0.2)
            esplib.remove_name()
            wait(0.2)
            esplib.remove_name()
        end
    end,})

    getgenv().Distance_DrawingESP = Tab19:CreateToggle({
    Name = "Distance ESP",
    CurrentValue = false,
    Flag = "MainESP_Distance",
    Callback = function(esp_distance_ESP)
        if esp_distance_ESP then
            for _, player in pairs(getgenv().Players:GetPlayers()) do
                if player ~= getgenv().LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                    wait(0.5)
                    local character = player.Character or player.CharacterAdded:Wait()

                    esplib.add_distance(character)
                end
            end

            getgenv().Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(char)
                    player.CharacterAdded:Wait()
                    repeat wait() until char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart")
                    task.wait(0.5)
                    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                        esplib.add_distance(char)
                    end
                end)
            end)
        else
            -- also add extra assurance here, since Drawing API is weird on other executors.
            wait(0.1)
            esplib.remove_distance()
            wait(0.2)
            esplib.remove_distance()
            wait(0.2)
            esplib.remove_distance()
        end
    end,})



    wait(0.2)
    getgenv().HighlightESP_Drawing = Tab19:CreateToggle({
    Name = "Highlight",
    CurrentValue = false,
    Flag = "ToggleHighlightESP",
    Callback = function(ez_highlight_esp)
        wait(0.4)
        if ez_highlight_esp then
            local Players = getgenv().Players
            local LocalPlayer = getgenv().LocalPlayer
            local RunService = getgenv().RunService

            local function onCharacterAdded(player, character)
                local function tryAdd()
                    if character:FindFirstChild("HumanoidRootPart") then
                        Highlight(player)
                    else
                        local attempts = 0
                        local connection
                        connection = RunService.RenderStepped:Connect(function()
                            attempts += 1
                            if character:FindFirstChild("HumanoidRootPart") then
                                Highlight(player)
                                connection:Disconnect()
                            elseif attempts > 20 then
                                connection:Disconnect()
                            end
                        end)
                        table.insert(connections, connection)
                    end
                end

                tryAdd()

                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local conn = humanoid.Died:Connect(function()
                        RemoveHighlight(player)
                    end)
                    table.insert(connections, conn)
                end
            end

            local function onPlayerAdded(player)
                if player == LocalPlayer then return end

                if player.Character then
                    onCharacterAdded(player, player.Character)
                end

                local conn = player.CharacterAdded:Connect(function(char)
                    onCharacterAdded(player, char)
                end)
                table.insert(connections, conn)
            end

            local function onPlayerRemoving(player)
                RemoveHighlight(player)
            end

            for _, p in ipairs(Players:GetPlayers()) do
                onPlayerAdded(p)
            end

            table.insert(connections, Players.PlayerAdded:Connect(onPlayerAdded))
            table.insert(connections, Players.PlayerRemoving:Connect(onPlayerRemoving))
        else
            shutdown_esp()
        end
    end,})

    getgenv().RainbowMode = Tab19:CreateToggle({
    Name = "Rainbow Mode (For Highlight ESP)",
    CurrentValue = false,
    Flag = "rainbowModeActive",
    Callback = function(doRainbowFunc)
        if doRainbowFunc then
            getgenv().RAINBOW_MODE = true
            local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
            local hue = 0

            rainbow_connection = RunService.RenderStepped:Connect(function()
                hue = (hue + 0.005) % 1
                local color = Color3.fromHSV(hue, 1, 1)

                for _, hl in pairs(highlights) do
                    if hl and hl:IsA("Highlight") then
                        hl.FillColor = color
                        hl.OutlineColor = color
                    end
                end
            end)
        else
            getgenv().RAINBOW_MODE = false
            if rainbow_connection then
                rainbow_connection:Disconnect()
                rainbow_connection = nil
            end
        end
    end,})
    wait(0.2)
    if getgenv().RAINBOW_MODE == true then
        getgenv().RainbowMode:Set(false)
        getgenv().RAINBOW_MODE = false
    end

    getgenv().HighlightColorPicker = Tab19:CreateColorPicker({
    Name = "Highlight Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "ChangeHighlightColorVal",
    Callback = function(esp_color_selected)
        for _, hl in pairs(highlights) do
            if hl and hl:IsA("Highlight") then
                hl.FillColor = newColor
            end
        end
    end,})

    getgenv().GetFakeChatGUI = Tab4:CreateButton({
    Name = "Fake Chat GUI",
    Callback = function()
        if getgenv().FakeChat_Loaded then
            return getgenv().notify("Failure", "Fake Chat GUI has already been loaded!", 5)
        elseif getgenv().FakeChat_Loaded == false then
            loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/FakeChatGUI/main/LmaoBruh.lua')))()
            wait(0.1)
            getgenv().FakeChat_Loaded = true
        else
            warn("Unknown operation/nil or bad call occurred.")
        end
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
                    for i,v in pairs(getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth"):GetChildren()) do
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
    else
        warn("Not loading this part, not on MIC UP or MIC UP 17+")
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

        -- Don't know why I have this here.
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
                getgenv().Invis_Loaded = false
                getgenv().Invis_Loaded = false
                RealCharacter:Destroy()
                FakeCharacter:Destroy()
            end)
            Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
        end

        RealCharacter.Humanoid.Died:Connect(function()
            getgenv().Invis_Loaded = false
            getgenv().Invis_Loaded = false
            getgenv().Invis_Loaded = false
            RealCharacter:Destroy()
            FakeCharacter:Destroy()
        end)

        Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)

        local Run_Service = getgenv().RunService
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
                if getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool") then
                    getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool"):Destroy()
                end
                wait(0.3)
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
                if getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool") then
                    getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool"):Destroy()
                end
                wait(0.1)
                local StoredCF
                if FakeCharacter and FakeCharacter:FindFirstChild("Humanoid") and FakeCharacter:FindFirstChild("HumanoidRootPart") then
                    StoredCF = FakeCharacter:FindFirstChild("HumanoidRootPart").CFrame
                end
                if FakeCharacter and FakeCharacter:FindFirstChild("Humanoid") and FakeCharacter:FindFirstChild("HumanoidRootPart") then
                    FakeCharacter:FindFirstChild("HumanoidRootPart").CFrame = RealCharacter:FindFirstChild("HumanoidRootPart").CFrame
                elseif not FakeCharacter:FindFirstChild("HumanoidRootPart") then
                    FakeCharacter:WaitForChild("HumanoidRootPart", 1).CFrame = RealCharacter:WaitForChild("HumanoidRootPart", 0.5).CFrame
                end
                
                RealCharacter:WaitForChild("HumanoidRootPart", 0.5).CFrame = StoredCF
                
                FakeCharacter:FindFirstChildWhichIsA("Humanoid"):UnequipTools()
                Player.Character = RealCharacter
                getgenv().Camera.CameraSubject = RealCharacter:FindFirstChildWhichIsA("Humanoid")
                PseudoAnchor = FakeCharacter:WaitForChild("HumanoidRootPart", 0.5)
                for i, v in pairs(FakeCharacter:GetChildren()) do
                    if v:IsA("LocalScript") then
                        v.Disabled = true
                    end
                end

                IsInvisible = false
            end
        end

        local User_Input_Service = getgenv().UserInputService
        local Sound_Service = getgenv().SoundService
        
        User_Input_Service.InputBegan:Connect(function(key, gamep)
            if gamep then
                return 
            end
            if key.KeyCode.Name:lower() == Keybind:lower() and CanInvis and RealCharacter and FakeCharacter then
                if RealCharacter:FindFirstChild("HumanoidRootPart") and FakeCharacter:FindFirstChild("HumanoidRootPart") then
                    if getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool") then
                        getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool"):Destroy()
                    end
                    wait(1)
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
    wait(0.1)
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().TeleportToCrossroadsMap = Tab10:CreateButton({
        Name = "TP To Crossroads Map (Only for Flames Hub users)",
        Callback = function()
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Crossroad"):GetPivot())
            else
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Crossroad"):GetPivot())
            end
        end,})

        getgenv().TeleportToModernHouseMap = Tab10:CreateButton({
        Name = "TP To Modern House Map (Only for Flames Hub users)",
        Callback = function()
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.3)
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Grass_Modern_Model_Baseplate"):GetPivot() * CFrame.new(0, 695, 0))
            else
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Grass_Modern_Model_Baseplate"):GetPivot() * CFrame.new(0, 695, 0))
            end
        end,})

        --[[getgenv().Prison_Life_Map_TP = Tab10:CreateButton({
        Name = "TP To Prison Life (Only for Flames Hub users)",
        Callback = function()
            local Workspace = getgenv().Workspace
            local Prison_Life_Map = Workspace:FindFirstChild("Prison_Life")
            if not Prison_Life_Map then
                return getgenv().notify("Failure", "Did not find allocated Prison_Life Map.", 5)
            end
            local Prison_Spawn = Prison_Life_Map:FindFirstChild("Prison_spawn")
            if not Prison_Spawn then
                return getgenv().notify("Failure", "Did not find allocated Prison_Spawn Part.", 5)
            end
            local Nexus_Prison_Spawn = Prison_Spawn:FindFirstChild("Nexus")
            if not Nexus_Prison_Spawn then
                return getgenv().notify("Failure", "Did not find allocated Nexus Script Spawn.", 5)
            end
            wait()
            local Main_Script_Spawn = Nexus_Prison_Spawn:FindFirstChild("Script_Spawn")

            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.3)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = Main_Script_Spawn.CFrame
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = Main_Script_Spawn.CFrame
            end
        end,})

        getgenv().Teleport_To_VIBE_NYC_Map = Tab10:CreateButton({
        Name = "TP To VIBE NYC Map (Only for Flames Hub users)",
        Callback = function()
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.3)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-6959.81445, 3374.51855, -8968.93848)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-6959.81445, 3374.51855, -8968.93848)
            end
        end,})--]]

        getgenv().PrivRoomFloor = Tab10:CreateButton({
        Name = "TP To Private Room (Inside)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(4220.82275, 2.76511836, 60.7681046)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(4220.82275, 2.76511836, 60.7681046)
            end
        end,})

        getgenv().NextToBathrooms = Tab10:CreateButton({
        Name = "TP To Room Next To Bathrooms",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(-108.536659, 5.38924313, 135.303314)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(-108.536659, 5.38924313, 135.303314)
            end
        end,})

        getgenv().TPToBathrooms = Tab10:CreateButton({
        Name = "TP To Bathrooms",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(-72.3955917, 5.09832525, 93.0914459)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(-72.3955917, 5.09832525, 93.0914459)
            end
        end,})

        getgenv().TPToChilling = Tab10:CreateButton({
        Name = "TP To Chill Spot",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(228.970184, 5.75081444, -21.5613441)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(228.970184, 5.75081444, -21.5613441)
            end
        end,})

        getgenv().TPToAStore = Tab10:CreateButton({
        Name = "TP To Store",
        Callback = function()
            local PreDefined_CFrame = CFrame.new(-94.0359421, 5.24999952, 29.9133148)

            getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = PreDefined_CFrame
        end,})

        getgenv().TPPicnicFirst = Tab10:CreateButton({
        Name = "TP To Picnic (Seat 1)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(85.846756, 3.61196709, -29.8345909)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(85.846756, 3.61196709, -29.8345909)
            end
        end,})

        getgenv().TPPicnicSecond = Tab10:CreateButton({
        Name = "TP To Picnic (Seat 2)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(76.6581955, 3.61196709, -29.8332996)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(76.6581955, 3.61196709, -29.8332996)
            end
        end,})

        getgenv().TPMicFirst = Tab10:CreateButton({
        Name = "TP To Stage (Mic 1)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
                HumanoidRootPart.CFrame = CFrame.new(39.2528572, 7.80023623, -67.7634125)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
                HumanoidRootPart.CFrame = CFrame.new(39.2528572, 7.80023623, -67.7634125)
            end
        end,})

        getgenv().TPMicSecond = Tab10:CreateButton({
        Name = "TP To Stage (Mic 2)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(14.8289356, 7.80023623, -67.7656097)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")

                HumanoidRootPart.CFrame = CFrame.new(14.8289356, 7.80023623, -67.7656097)
            end
        end,})

        getgenv().TPMiddleRoomArea = Tab10:CreateButton({
        Name = "TP To Middle Room (Tent)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
                HumanoidRootPart.CFrame = CFrame.new(70.9464493, 5.62692404, 24.2968006)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
                HumanoidRootPart.CFrame = CFrame.new(70.9464493, 5.62692404, 24.2968006)
            end
        end,})

        getgenv().TPBoothRows = Tab10:CreateButton({
        Name = "TP To Booth Rows (Table)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(26.7397423, 7.81395245, 86.7164536)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(26.7397423, 7.81395245, 86.7164536)
            end
        end,})

        getgenv().TPToTowerFloatPart = Tab10:CreateButton({
        Name = "TP To Tower (Float Up Part)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(61.3288841, 72.0192184, 215.731613)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(61.3288841, 72.0192184, 215.731613)
            end
        end,})

        getgenv().TPToTowerTop = Tab10:CreateButton({
        Name = "TP To Tower (Top)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(63.2298126, 284.407227, 193.529007)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(63.2298126, 284.407227, 193.529007)
            end
        end,})

        getgenv().TPToHighestPoint = Tab10:CreateButton({
        Name = "TP To Tower (Highest Part)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(58.0468788, 313.312622, 225.215027)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(58.0468788, 313.312622, 225.215027)
            end
        end,})

        getgenv().TPBooth1 = Tab10:CreateButton({
        Name = "TP To Booth-1",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth01")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth01")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth2 = Tab10:CreateButton({
        Name = "TP To Booth-2",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth02")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth02")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth3 = Tab10:CreateButton({
        Name = "TP To Booth-3",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth03")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth03")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth4 = Tab10:CreateButton({
        Name = "TP To Booth-4",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth04")
                Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth04")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPBooth5 = Tab10:CreateButton({
        Name = "TP To Booth-5",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth05")
                getgenv().Character:PivotTo(Booth:GetPivot())
            else
                local Booth_Folder = getgenv().Workspace:FindFirstChild("Map"):FindFirstChild("Booth")
                local Booth = Booth_Folder:FindFirstChild("Booth05")
                getgenv().Character:PivotTo(Booth:GetPivot())
            end
        end,})

        getgenv().TPToDonutShop = Tab10:CreateButton({
        Name = "TP To Donut Shop",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-80.8301239, 3.1662631, -82.6656799)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-80.8301239, 3.1662631, -82.6656799)
            end
        end,})

        getgenv().TPSeat1Donut = Tab10:CreateButton({
        Name = "TP To Donut Shop (Seat 1)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-98.4535675, 4.04168415, -96.7826004)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-98.4535675, 4.04168415, -96.7826004)
            end
        end,})

        getgenv().TPSeat1Donut = Tab10:CreateButton({
        Name = "TP To Donut Shop (Seat 2)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-91.7390671, 4.04168415, -90.0620728)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-91.7390671, 4.04168415, -90.0620728)
            end
        end,})

        getgenv().TPTableSeat1 = Tab10:CreateButton({
        Name = "TP To Donut Shop (Table Seat 1)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-102.440971, 4.51146317, -66.6184387)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-102.440971, 4.51146317, -66.6184387)
            end
        end,})

        getgenv().TPTableSeat2 = Tab10:CreateButton({
        Name = "TP To Donut Shop (Table, Seat 2)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-94.6592941, 4.51146317, -74.3931046)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-94.6592941, 4.51146317, -74.3931046)
            end
        end,})

        getgenv().TPBehindCounter = Tab10:CreateButton({
        Name = "TP To Donut Shop (Behind Counter)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-122.382172, 3.22726321, -83.5359192)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-122.382172, 3.22726321, -83.5359192)
            end
        end,})

        getgenv().TPAboveRelax = Tab10:CreateButton({
        Name = "TP Above Relaxing Room",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-97.4412308, 24.4840164, 121.394676)
            else
                getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-97.4412308, 24.4840164, 121.394676)
            end
        end,})

        getgenv().TPSubmitNoteBoard = Tab10:CreateButton({
        Name = "TP To Submit Note Board",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
                HumanoidRootPart.CFrame = CFrame.new(58.6107864, 4.99999857, 245.690369)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
                HumanoidRootPart.CFrame = CFrame.new(58.6107864, 4.99999857, 245.690369)
            end
        end,})

        getgenv().TPStageMic = Tab10:CreateButton({
        Name = "TP To Stage Mic",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
                HumanoidRootPart.CFrame = CFrame.new(-61.6848221, 10.0853853, 229.676834)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
                HumanoidRootPart.CFrame = CFrame.new(-61.6848221, 10.0853853, 229.676834)
            end
        end,})

        getgenv().TPPrivRoomRoof = Tab10:CreateButton({
        Name = "TP To Private Room (Roof)",
        Callback = function()
            wait(0.4)
            if getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit or getgenv().Character:FindFirstChildWhichIsA("Humanoid").Sit == true then
                getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
                task.wait(.2)
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
                HumanoidRootPart.CFrame = CFrame.new(4220.37842, 23.5336628, 61.3636169)
            else
                local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            
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
    end,})

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 or game.PlaceId == 80080558412215 then
        local partStorage = getgenv().Workspace:FindFirstChild("PartStorage")

        while not partStorage do
            task.wait(0.5)
            partStorage = getgenv().Workspace:FindFirstChild("PartStorage")
        end
        
        local boardCount = 0
        local boards = {}

        local partStorage = getgenv().Workspace:FindFirstChild("PartStorage")
        if not partStorage then
            return warn("PartStorage folder not found in Workspace!")
        end

        for _, model in ipairs(getgenv().Workspace:GetChildren()) do
            if model:IsA("Model") and model.Name == "Tic Tac Toe" then
                boardCount = boardCount + 1
                model.Name = "Tic Tac Toe " .. boardCount
                model.Parent = partStorage
                boards[boardCount] = model
                print("Moved and renamed:", model.Name)
            end
        end

        function clickBoard(boardName)
            local board = partStorage:FindFirstChild(boardName)
            if board then
                local clicked = false
                for _, v in ipairs(board:GetDescendants()) do
                    if v:IsA("ClickDetector") then
                        v.MaxActivationDistance = 9999
                        wait()
                        fireclickdetector(v)
                        clicked = true
                    end
                end
                task.wait()
                if not clicked then
                    warn("No ClickDetector found in " .. boardName)
                end
            else
                warn("Board not found: " .. boardName)
            end
        end

        getgenv().ClickingAllBoards = Tab5:CreateButton({
        Name = "Click All TicTacToe Boards",
        Callback = function()
            boardCount = 0
            for _, model in ipairs(partStorage:GetChildren()) do
                if model:IsA("Model") and model.Name:find("Tic Tac Toe") then
                    boardCount = boardCount + 1
                end
            end
            wait()
            for i = 1, boardCount do
                clickBoard("Tic Tac Toe " .. i)
                wait(0.1)
            end
        end,})

        getgenv().LoopClickAllBoards = Tab5:CreateToggle({
        Name = "Click All TicTacToe Boards (Loop)",
        CurrentValue = false,
        Flag = "loopClickingAllBoards",
        Callback = function(ClickAll)
            getgenv().doAllClicks = ClickAll
            while getgenv().doAllClicks == true do
                for i = 1, boardCount do
                    clickBoard("Tic Tac Toe " .. i)
                end
                wait(0.5)
            end
        end,})

        getgenv().TicTacToeBoardOne = Tab5:CreateButton({
        Name = "Click TicTacToe Board 1",
        Callback = function()
            clickBoard("Tic Tac Toe 1")
        end,})

        getgenv().TicTacToeBoardTwo = Tab5:CreateButton({
        Name = "Click TicTacToe Board 2",
        Callback = function()
            clickBoard("Tic Tac Toe 2")
        end,})

        getgenv().TicTacToeBoardThree = Tab5:CreateButton({
        Name = "Click TicTacToe Board 3",
        Callback = function()
            clickBoard("Tic Tac Toe 3")
        end,})
    else
        warn("Not MIC UP or MIC UP 17+ or German Hangout (VC), not loading these TicTacToe options.")
    end

    getgenv().InfYield_Premium = Tab5:CreateButton({
    Name = "Infinite Premium (Infinite Yield Upgraded/Modified).",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua'))()
    end,})

    getgenv().InfYield_Regular = Tab5:CreateButton({
    Name = "Infinite Yield (Regular/Normal).",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end,})

    local Old_JumpPower_JumpHeight
    local Old_WalkSpeed = getgenv().Humanoid.WalkSpeed or getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed
    local Old_HipHeight = getgenv().Humanoid.HipHeight or getgenv().Character:FindFirstChildWhichIsA("Humanoid").HipHeight
    local Old_Gravity = getgenv().Workspace.Gravity

    if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
        Old_JumpPower_JumpHeight = getgenv().Humanoid.JumpPower or getgenv().Character:FindFirstChildWhichIsA("Humanoid").JumpPower
    else
        Old_JumpPower_JumpHeight = getgenv().Humanoid.JumpHeight or getgenv().Character:FindFirstChildWhichIsA("Humanoid").JumpHeight
    end
    wait(0.5)
    getgenv().WalkSpeedSliding = Tab2:CreateSlider({
    Name = "WalkSpeed (Default): "..tostring(Old_WalkSpeed),
    Range = {16, 450},
    Increment = 1,
    Suffix = "",
    CurrentValue = Old_WalkSpeed,
    Flag = "walkSpeedValue",
    Callback = function(wsVal)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = wsVal
    end,})

    getgenv().ResetSpeed = Tab2:CreateButton({
    Name = "Reset WalkSpeed",
    Callback = function()
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WalkSpeed
        getgenv().WalkSpeedSliding:Set(Old_WalkSpeed)
    end,})

    getgenv().JumpPowerSlider = Tab2:CreateSlider({
    Name = "JumpPower/JumpHeight (Default): "..tostring(Old_JumpPower_JumpHeight),
    Range = {50, 750},
    Increment = 1,
    Suffix = "",
    CurrentValue = Old_JumpPower_JumpHeight,
    Flag = "jpValue",
    Callback = function(jpVal)
        if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
            getgenv().Humanoid.JumpPower = jpVal
        else
            getgenv().Humanoid.JumpHeight = jpVal
        end
    end,})

    getgenv().ResetJumpPowerButton = Tab2:CreateButton({
    Name = "Reset JumpPower/JumpHeight (Default): "..tostring(Old_JumpPower_JumpHeight),
    Callback = function()
        if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").JumpPower = Old_JumpPower_JumpHeight
        else
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").JumpHeight = Old_JumpPower_JumpHeight
        end
        getgenv().JumpPowerSlider:Set(Old_JumpPower_JumpHeight)
    end,})

    getgenv().HipHeightSliding = Tab2:CreateSlider({
    Name = "HipHeight, (Default): "..tostring(Old_HipHeight),
    Range = {1, 300},
    Increment = 1,
    Suffix = "",
    CurrentValue = Old_HipHeight,
    Flag = "HipHeightValue",
    Callback = function(hipValue)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").HipHeight = hipValue
    end,})

    getgenv().GravSliding = Tab2:CreateSlider({
    Name = "Gravity (Default): "..tostring(Old_Gravity),
    Range = {1, 200},
    Increment = 1,
    Suffix = "",
    CurrentValue = Old_Gravity,
    Flag = "GravityValue",
    Callback = function(gravVal)
        getgenv().Workspace.Gravity = gravVal
    end,})

    getgenv().ResetGrav = Tab2:CreateButton({
    Name = "Reset Gravity",
    Callback = function()
        getgenv().Workspace.Gravity = Old_Gravity
        getgenv().GravSliding:Set(Old_Gravity)
    end,})
    wait()
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
                local HumanoidRP = getgenv().Character:FindFirstChild("HumanoidRootPart")

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
                local HumanoidRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
                print("Teleporting Back...")
                wait()
                HumanoidRP.CFrame = CFrame.new(36.5316811, 4.99999952, 24.585743)
            end
        end,})
    else
        warn("This is not MIC UP or MIC UP 17+, not loading Loop teleport method for Anti-Bang.")
    end

    getgenv().bruhAntiTPMethod3 = Tab2:CreateButton({
    Name = "Anti Bang/TP (Method 3, They Die To)",
    Callback = function()
        local OldDestroy_Height = getgenv().Workspace.FallenPartsDestroyHeight
        local voidPosition = Vector3.new(-499, -499, -499)
        local Workspace = getgenv().Workspace
        local HumanoidRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
        wait(.4)
        getgenv().Workspace.FallenPartsDestroyHeight = 0/1/0
        HumanoidRP.CFrame = CFrame.new(voidPosition)
        wait(0.3)
        getgenv().Workspace.FallenPartsDestroyHeight = OldDestroy_Height
    end,})

    getgenv().MethodFourAntiTP = Tab2:CreateToggle({
    Name = "Anti Bang/TP (Method 4, Void Method)",
    CurrentValue = false,
    Flag = "AntiTPMethod4",
    Callback = function(getLoopTpToVoid)
        local OldDestroyH = getgenv().Workspace.FallenPartsDestroyHeight

        if getLoopTpToVoid then
            local putPositionTo = Vector3.new(-84385288, 69380040, 174817648)
            local Workspace = getgenv().Workspace
            local HumanoidRP = getgenv().Character:FindFirstChild("HumanoidRootPart")
            getgenv().Workspace.FallenPartsDestroyHeight = 0/1/0
            wait(0.2)
            getgenv().loopTPToVoid = true
            while getgenv().loopTPToVoid == true do
            wait()
                getgenv().Workspace.FallenPartsDestroyHeight = 0/1/0
                HumanoidRP.CFrame = CFrame.new(putPositionTo)
            end
        else
            getgenv().loopTPToVoid = false
            wait()
            repeat wait() until getgenv().loopTPToVoid == false
            local HumanoidRootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            HumanoidRootPart.CFrame = CFrame.new(36.5316811, 4.99999952, 24.585743)
            wait(0.3)
            getgenv().Workspace.FallenPartsDestroyHeight = OldDestroyH
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
    wait()
    if getgenv().Lighting.ClockTime ~= 14 then
        getgenv().ClockTimeSlider:Set(14)
        getgenv().Lighting.ClockTime = 14
    end
    wait()
    getgenv().ClockTimeSliderReset = Tab9:CreateButton({
    Name = "Reset ClockTime (14)",
    Callback = function()
        getgenv().ClockTimeSlider:Set(14)
        getgenv().Lighting.ClockTime = 14
    end,})

    getgenv().LockCurrentClockTime = Tab9:CreateToggle({
    Name = "Lock Current ClockTime",
    CurrentValue = false,
    Flag = "LockCurrentClockTimeValue",
    Callback = function(locked_clocktime_value)
        if locked_clocktime_value then
            local Lighting = getgenv().Lighting
            local Current_ClockTime = Lighting.ClockTime

            getgenv().Locking_ClockTime_Toggle_Enabled = true
            while getgenv().Locking_ClockTime_Toggle_Enabled == true do
            task.wait()
                Lighting.ClockTime = Current_ClockTime
            end
        else
            getgenv().Locking_ClockTime_Toggle_Enabled = false
            getgenv().Locking_ClockTime_Toggle_Enabled = false
        end
    end,})

    getgenv().lock_brightness = false
    getgenv().lock_clocktime = false
    getgenv().clocktime_value = 0
    getgenv().brightness_value = 0
    getgenv().clocktime_connection = nil
    getgenv().brightness_connection = nil

    function start_clocktime_lock()
        if not getgenv().clocktime_connection then
            getgenv().clocktime_connection = getgenv().RunService.RenderStepped:Connect(function()
                if getgenv().lock_clocktime then
                    getgenv().Lighting.ClockTime = getgenv().clocktime_value
                end
            end)
        end
    end
    task.wait(0.1)
    getgenv().Start_ClockTime_Lock_Loop = start_clocktime_lock

    function stop_clocktime_lock()
        if getgenv().clocktime_connection then
            getgenv().clocktime_connection:Disconnect()
            getgenv().clocktime_connection = nil
        end
    end
    task.wait(0.1)
    getgenv().Stop_ClockTime_Lock_Loop = stop_clocktime_lock

    function start_brightness_lock()
        if not getgenv().brightness_connection then
            getgenv().brightness_connection = getgenv().RunService.RenderStepped:Connect(function()
                if getgenv().lock_brightness then
                    getgenv().Lighting.Brightness = getgenv().brightness_value
                end
            end)
        end
    end

    function stop_brightness_lock()
        if getgenv().brightness_connection then
            getgenv().brightness_connection:Disconnect()
            getgenv().brightness_connection = nil
        end
    end

    getgenv().LockClockTime_Input = Tab9:CreateSlider({
    Name = "Lock ClockTime",
    Range = {0, 24},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = tonumber(getgenv().clocktime_value),
    Flag = "LockingClockTimeSliderValue",
    Callback = function(locked_clocktime_slider_value)
        getgenv().clocktime_value = tonumber(locked_clocktime_slider_value)
        getgenv().lock_clocktime = true
    end,})

    getgenv().ToggleClockTimeLockSliderLoop = Tab9:CreateToggle({
    Name = "ClockTime Lock Loop (Slider)",
    CurrentValue = false,
    Flag = "LockedClockTimeViaSliderInput",
    Callback = function(Slider_ClockTime_Locked_Loop)
        if Slider_ClockTime_Locked_Loop then
            getgenv().Start_ClockTime_Lock_Loop()
        else
            getgenv().Stop_ClockTime_Lock_Loop()
        end
    end,})

    getgenv().LockBrightness_Input = Tab9:CreateSlider({
    Name = "Lock Brightness",
    Range = {0, 25},
    Increment = 0.5,
    Suffix = "",
    CurrentValue = tonumber(getgenv().brightness_value),
    Flag = "LockingBrightnessSliderValue",
    Callback = function(locked_brightness_slider_value)
        getgenv().brightness_value = tonumber(locked_brightness_slider_value)
        getgenv().lock_brightness = true
    end,})

    getgenv().ToggleBrightnessLockSliderLoop = Tab9:CreateToggle({
    Name = "Brightness Lock Loop (Slider)",
    CurrentValue = false,
    Flag = "LockedBrightnessViaSliderInput",
    Callback = function(Slider_Brightness_Locked_Loop)
        if Slider_Brightness_Locked_Loop then
            start_brightness_lock()
        else
            stop_brightness_lock()
        end
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
    wait(0.1)
    if getgenv().Lighting.Brightness ~= 3 then
        getgenv().BrightnessSlider:Set(3)
        getgenv().Lighting.Brightness = 3
    end

    getgenv().ResetBrightness = Tab9:CreateButton({
    Name = "Reset Brightness (3)",
    Callback = function()
        getgenv().BrightnessSlider:Set(3)
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
            local TweenService = getgenv().TweenService
            local Lighting = getgenv().Lighting

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
    wait()
    if getgenv().AmbientChangerEnabled == true then
        getgenv().AmbientChangerEnabled:Set(false)
    end

    getgenv().AmbientChooser = Tab9:CreateColorPicker({
    Name = "Ambient Color",
    Color = getgenv().Lighting.Ambient,
    Flag = "AmbientChoosingColor",
    Callback = function(color_ambient)
        getgenv().Lighting.Ambient = color_ambient
    end,})
    wait()
    if getgenv().Lighting.Ambient ~= Color3.fromRGB(70, 70, 70) then
        getgenv().AmbientChooser:Set(Color3.fromRGB(70, 70, 70))
        getgenv().Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    end

    getgenv().ResetAmbient = Tab9:CreateButton({
    Name = "Reset Ambient",
    Callback = function()
        getgenv().AmbientChooser:Set(Color3.fromRGB(70, 70, 70))
        getgenv().RainbowAmbient:Set(false)
        wait(0.1)
        getgenv().Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    end})

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

    if not getgenv().Lighting.Technology == Enum.Technology.Compatibility then
        getgenv().Lighting.Technology = Enum.Technology.Compatibility
    end

    getgenv().use_new_meterials = function(toggle)
        if toggle == true then
            getgenv().MaterialService.Use2022Materials = true
        elseif toggle == false then
            getgenv().MaterialService.Use2022Materials = false
        else
            getgenv().notify("Failure", "You provided an unknown or incorrect argument.", 6)
            return warn("Unknown argument provided.")
        end
    end

    getgenv().LightingReset = Tab9:CreateButton({
    Name = "Reset Lighting",
    Callback = function()
        resetLightingSettings()
        wait(0.3)
        if getgenv().MaterialService.Use2022Materials or getgenv().MaterialService.Use2022Materials == true then
            getgenv().notify("True", "'Use2022Materials' is enabled | Continue.", 7)
        else
            getgenv().material_toggle(true)
        end
    end,})

    getgenv().fireworksToggle = Tab9:CreateToggle({
    Name = "FireWorks (Sky)",
    CurrentValue = false,
    Flag = "FireworksInSkyLoop",
    Callback = function(FireWorksCrazy)
        if FireWorksCrazy then
            local Lighting = getgenv().Lighting
            Lighting.ClockTime = 1
            Lighting.Brightness = 2
            wait()
            getgenv().setFireWorksOn = true
            while getgenv().setFireWorksOn == true do
            wait()
                local player = getgenv().LocalPlayer

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
                    sound.Volume = 4
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
    wait()
    if getgenv().setFireWorksOn == true then
        getgenv().fireworksToggle:Set(false)
        getgenv().setFireWorksOn = false
    end
    wait()
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
            local sky
            wait(0.2)
            if Lighting:FindFirstChildOfClass("Sky") then
                sky = Lighting:FindFirstChildOfClass("Sky")
            else
                sky = Instance.new("Sky")
                sky.Name = "Sky"
                sky.Parent = Lighting
                sky.MoonAngularSize = 11
            end
            wait(0.2)
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
            local Lighting = getgenv().Lighting
            local sky = Lighting:FindFirstChildOfClass("Sky")
            getgenv().SpookyMoon = false
            getgenv().SpookyMoon = false
            getgenv().SpookyMoon = false
            repeat wait(5) until getgenv().SpookyMoon == false
            if getgenv().SpookyMoon == false then
                resetLightingSettings()
                wait(0.3)
                sky.MoonAngularSize = 11
                wait(0.3)
                Lighting.ClockTime = 14
            end
        end
    end,})
    wait()
    if getgenv().SpookyMoon == true then
        getgenv().SpookyMoonToggle:Set(false)
    end

    getgenv().SpookySunLoop = Tab9:CreateToggle({
    Name = "Spooky Sun",
    CurrentValue = false,
    Flag = "SpookySunDayTime",
    Callback = function(sunSpooky)
        if sunSpooky then
            getgenv().SpookSun = true
            local Lighting = getgenv().Lighting
            local sky
            wait(0.2)
            if Lighting:FindFirstChildOfClass("Sky") then
                sky = Lighting:FindFirstChildOfClass("Sky")
            else
                sky = Instance.new("Sky")
                sky.Name = "Sky"
                sky.Parent = Lighting
                sky.MoonAngularSize = 11
            end
            wait()
            local function smoothTransition()
                local Lighting = getgenv().Lighting
                local sky
                wait(0.2)
                if sky then
                    sky = Lighting:FindFirstChildOfClass("Sky")
                else
                    sky = Instance.new("Sky")
                    sky.Name = "Sky"
                    sky.Parent = Lighting
                    sky.SunAngularSize = 11
                    getgenv().SpookySunLoop:Set(false)
                end
                wait()
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
            repeat wait(5) until getgenv().SpookSun == false
            if getgenv().SpookSun == false then
                resetLightingSettings()
            else
                getgenv().SpookSun = false
                getgenv().SpookSun = false
                resetLightingSettings()
            end
            wait(0.1)
            resetLightingSettings()
        end
    end,})
    wait()
    if getgenv().SpookSun == true then
        getgenv().SpookySunLoop:Set(false)
        getgenv().SpookSun = false
    end

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
    getgenv().doFreezeToggle = false
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
            getgenv().slowMotion = false
        end
    end,})
    wait()
    getgenv().slowMotion = false
    wait(0.2)
    if getgenv().slowMotion == true then
        getgenv().slowMotionToggle:Set(false)
        getgenv().slowMotion = false
    end
    wait()
    getgenv().doFreezeToggle = false
    wait()
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
            getgenv().doFreezeToggle = false
        end
    end,})
    wait(0.1)
    if getgenv().doFreezeToggle == true then
        getgenv().FreezeEmotesToggle:Set(false)
        getgenv().doFreezeToggle = false
    end

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
            getgenv().fastToggle = false
        end
    end,})
    wait(0.1)
    if getgenv().fastToggle == true then
        getgenv().FastestEmotes:Set(false)
        getgenv().fastToggle = false
    end
    wait()
    getgenv().StopAllEmotes = Tab12:CreateButton({
    Name = "Stop Playing Emotes",
    Callback = function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You have to be in R15 to use this!", 5)
        end

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

    getgenv().MuteAllBruh = Tab21:CreateToggle({
    Name = "Mute All",
    CurrentValue = false,
    Flag = "MutingEveryone",
    Callback = function(TheMuteAll)
        if TheMuteAll then
            local enabled_vc = vc_service:IsVoiceEnabledForUserIdAsync(getgenv().LocalPlayer.UserId)

            if not enabled_vc or enabled_vc == false then
                return getgenv().notify("Failure:", "Your account does not have VoiceChat!", 5)
            end

            getgenv().LmaoGetMuted = true
            while getgenv().LmaoGetMuted == true do
            wait()
                getgenv().VoiceChatInternal:SubscribePauseAll(true)
                getgenv().VoiceChatInternal:SubscribePauseAll(true)
            end
        else
            getgenv().LmaoGetMuted = false
            getgenv().LmaoGetMuted = false
            wait(0.3)
            getgenv().VoiceChatInternal:SubscribePauseAll(false)
            getgenv().VoiceChatInternal:SubscribePauseAll(false)
        end
    end,})

    getgenv().MuteAPlayerSpecific = Tab21:CreateInput({
    Name = "Mute Player",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Callback = function(getAUser)
        local derUser = findplr(getAUser)
        local enabled_vc = vc_service:IsVoiceEnabledForUserIdAsync(getgenv().LocalPlayer.UserId)

        if not enabled_vc or enabled_vc == false then
            return getgenv().notify("Failure:", "Your account does not have VoiceChat!", 5)
        end

        if not derUser then
            return getgenv().notify("Failure!", "User was not found.", 6)
        end
        wait(0.1)
        getgenv().shouldMute = true
        getgenv().MutedPlayers = getgenv().MutedPlayers or {}
        getgenv().PlayerConnections = getgenv().PlayerConnections or {}

        function MutePlayer(user)
            getgenv().notify("Success!", "Player has been muted", 5)

            if user:FindFirstChildOfClass("AudioDeviceInput") then
                while getgenv().shouldMute == true do
                wait()
                    local audiodeviceinput = user:FindFirstChildOfClass("AudioDeviceInput")

                    audiodeviceinput.Muted = true
                end
            else
                while getgenv().shouldMute == true do
                wait()
                    getgenv().VoiceChatInternal:SubscribePause(user.UserId, true)
                end
            end
        end

        if getgenv().shouldMute or getgenv().shouldMute == true then
            getgenv().notify("Success!", "Loop was enabled already, new player muted.", 5)
            wait(0.1)
            MutePlayer(derUser)
        elseif not getgenv().shouldMute or getgenv().shouldMute == false then
            if derUser:FindFirstChildOfClass("AudioDeviceInput") then
                local audiodeviceinput = derUser:FindFirstChildOfClass("AudioDeviceInput")

                audiodeviceinput.Muted = true
                wait(0.2)
                getgenv().notify("Success", "Player has been muted!", 5)
            else
                getgenv().VoiceChatInternal:SubscribePause(derUser.UserId, true)
            end
        else
            return getgenv().notify("Unknown Error:", "Could not determine loop status.", 6)
        end
    end,})

    getgenv().ResetButton = Tab2:CreateButton({
    Name = "Reset",
    Callback = function()
        if getgenv().Character and getgenv().Character:FindFirstChildOfClass("Humanoid") then
            getgenv().Humanoid.Health = 0
        else
            return getgenv().notify("Failed!", "Humanoid doesn't exist, please wait for a respawn!", 5)
        end
    end,})

    getgenv().RejoinButton = Tab15:CreateButton({
    Name = "Rejoin",
    Callback = function()
        getgenv().TeleportService:TeleportToPlaceInstance(getgenv().PlaceID, getgenv().JobID, getgenv().LocalPlayer)
    end,})

    if executor_Name == "Solara" then
        warn("Cannot load 'ServerHop' on 'Solara'.")
    else
        getgenv().ServerHopButton = Tab15:CreateButton({
        Name = "ServerHop",
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

            if #getgenv().servers > 0 then
                getgenv().TeleportService:TeleportToPlaceInstance(game.PlaceId, getgenv().servers[math.random(1, #getgenv().servers)], getgenv().LocalPlayer)
            else
                return getgenv().notify("ServerHop", "Couldn't find a server [failed].", 5)
            end
        end,})
    end

    if getgenv().Rayfield then
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
    else
        warn("Custom UI was not loaded properly.")
    end

    local Module = loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/zacks_easy_module.lua'))()
    local Version = Module:Get_Current_Version()
    wait(0.3)
    getgenv().ReExecuteGUI = Tab1:CreateButton({
    Name = "Re-Execute/Reload Script/GUI",
    Callback = function()
        getgenv().notify("Hang On:", "Loading update: "..tostring(Version), 5)
        Module:Patch_Update()
    end,})
    wait(0.1)
    getgenv().DestroyGUIScript = Tab1:CreateButton({
    Name = "Destroy GUI/Script",
    Callback = function()
        Module:Destroy_Script()
    end,})

    getgenv().UnmuteAPlayer = Tab21:CreateInput({
    Name = "Unmute Player",
    PlaceholderText = "User",
    RemoveTextAfterFocusLost = true,
    Callback = function(LolPUser)
        local thisUser = findplr(LolPUser)
        local enabled_vc = vc_service:IsVoiceEnabledForUserIdAsync(game.Players.LocalPlayer.UserId)

        if not enabled_vc or enabled_vc == false then
            return getgenv().notify("Failure:", "Your account does not have VoiceChat!", 5)
        end

        if not thisUser then
            getgenv().notify("Failure", "Player was not found.", 5)
        end

        if thisUser then
            function UnmutePlayer(user)
                if user and user:FindFirstChildOfClass("AudioDeviceInput") then
                    local AudioDeviceInput = user:FindFirstChildOfClass("AudioDeviceInput")

                    if AudioDeviceInput.Muted or AudioDeviceInput.Muted == true then
                        AudioDeviceInput.Muted = false
                    end
                else
                    getgenv().VoiceChatInternal:SubscribePause(user.UserId, true)
                end
            end
            wait()
            getgenv().shouldMute = false
            UnmutePlayer(thisUser)
            wait(0.2)
            getgenv().notify("Success", "Player has been unmuted", 5)
        end
    end,})
    wait()
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
    wait(0.7)
    if getgenv().runningEnabled == true then
        getgenv().ShiftToRun:Set(false)
        wait(0.2)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end

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

    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = getgenv().LocalPlayer
    wait()
    local Easy_Configuration_Table = {
        ["Animation_Idle"] = "Knight",
        ["Animation_Walk"] = "Zombie",
        ["Animation_Run"] = "Zombie",
        ["Animation_Jump"] = "Superhero",
        ["Animation_Fall"] = "Adidas",
        ["Animation_Climb"] = "Bold",
    }
    wait()
    getgenv().Easies_Configuration = Easy_Configuration_Table
    getgenv().ownerAnimsLoaded = false
    getgenv().ownerAnimsEnabled = false

    if getgenv().ownerAnimsEnabled == false then
        warn("Not running loop, owner animations are disabled.")
    else
        local function run_anims(character)
            if not character then return warn("Character not found!") end
            local Animate = character:FindFirstChild("Animate")
            if not Animate then return warn("Animate script is missing!") end

            Animate.Disabled = true
            task.wait(0.1)
            Animate.Disabled = false

            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end

            task.wait(0.2)

            Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
            Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
            Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Walk
            Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Run
            Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Jump
            Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Climb
            Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Fall
        end

        getgenv().ownerAnimsEnabled = true
        wait(0.1)
        local function onCharacterAdded(character)
            if getgenv().ownerAnimsEnabled then
                task.wait(1)
                run_anims(character)
            else
                warn("Animations are disabled.")
            end
        end

        if LocalPlayer.Character then
            onCharacterAdded(LocalPlayer.Character)
        end

        LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

        local function run_anims(character)
            if not character then return warn("Character not found!") end
            local Animate = character:FindFirstChild("Animate")
            if not Animate then return warn("Animate script is missing!") end

            Animate.Disabled = true
            task.wait(0.1)
            Animate.Disabled = false

            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end

            task.wait(0.2)

            Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
            Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
            Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Walk
            Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Run
            Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Jump
            Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Climb
            Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Fall
        end

        local function onCharacterAdded(character)
            if getgenv().ownerAnimsEnabled then
                task.wait(1)
                run_anims(character)
            else
                warn("Animations are disabled.")
            end
        end

        if LocalPlayer.Character then
            onCharacterAdded(LocalPlayer.Character)
        end

        LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
    end
    wait(0.2)
    function create_Button(localName, Name, callback) 
        local localName = Tab17:CreateButton({
            Name = tostring(Name),
            Callback = callback
        })
    end

    function refresh_anims()
        local Char = getgenv().Character
        local Human = getgenv().Humanoid
        local Animate = getgenv().Character:FindFirstChild("Animate", true) or getgenv().Character:WaitForChild("Animate", 5)

        if not Human or not Animate then
            return getgenv().notify('Failure:', 'Failed to get Animate LocalScript or Humanoid!', 5)
        end
        if Animate then
            Animate.Disabled = true
        end
        wait(0.1)
        for _, v in ipairs(Human:GetPlayingAnimationTracks()) do
            v:Stop()
        end
        wait(0.1)
        Animate.Disabled = false
    end

    local apply_anims_delay = 2

    wait(0.2)
    create_Button(CatWalkGlamAnim, "'Catwalk Glam' Animation Package", function()
        local StarterPlayer = getgenv().Service_Wrap("StarterPlayer")

        if not StarterPlayer.AllowCustomAnimations or StarterPlayer.AllowCustomAnimations == false then
            StarterPlayer.AllowCustomAnimations = true
            refresh_anims()
        end
        wait(1)
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate", 3)
        local Old_WS = getgenv().Humanoid.WalkSpeed

        if getgenv().Humanoid.RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end
        
        getgenv().Humanoid.WalkSpeed = 0
        getgenv().HumanoidRootPart.Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=133806214992291"
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=94970088341563"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=109168724482748"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=81024476153754"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=116936326516985"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=119377220967554"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=92294537340807"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(WickedPopularAnim, "'Wicked Popular' Animation Package", function()
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=118832222982049"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=76049494037641"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=92072849924640"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=72301599441680"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=104325245285198"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=131326830509784"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=121152442762481"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(RThroAnim, "RThro Animation Package", function()
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        Rthro_Idle_1 = "10921259953"
        Rthro_Idle_2 = "10921258489"
        Rthro_Walk = "10921269718"
        Rthro_Run = "10921261968"
        Rthro_Jump = "10921263860"
        Rthro_Climb = "10921257536"
        Rthro_Fall = "10921262864"

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Idle_1
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Idle_1
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Walk
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Run
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Jump
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Climb
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id="..Rthro_Fall
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Humanoid.WalkSpeed = Old_WS
    end)

    create_Button(adidasAnim, "Adidas Animation Package", function()
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate", 3)
        local Old_WS = getgenv().Humanoid.WalkSpeed

        if getgenv().Humanoid.RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = getgenv().Humanoid

        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=18537376492"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=18537371272"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537392113"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537384940"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537380791"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537363391"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18537367238"
        wait(0.1)
        getgenv().Humanoid:ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Humanoid.WalkSpeed = Old_WS
    end)

    create_Button(NFLAnim, "NFL Animation Package", function()
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().HumanoidRootPart.Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=92080889861410"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=74451233229259"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=110358958299415"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=117333533048078"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=119846112151352"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=134630013742019"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=129773241321032"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(BoldAnim, "Bold Animation Package", function()
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=16738333868"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=16738334710"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738340646"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738337225"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738336650"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738332169"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=16738333171"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(noBoundariesAnim, "No Boundaries Animation Package", function()
        wait(0.7)
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=18747067405"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=18747063918"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747074203"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747070484"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747069148"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747060903"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=18747062535"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(robotAnim, "Robot Animation Package", function()
        wait(0.7)
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed
        
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=10921248039"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=10921248831"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921255446"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921250460"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921252123"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921247141"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=10921251156"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(zombieAnim, "Zombie Animation Package", function()
        wait(0.7)
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().Character:FindFirstChild("Animate")

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=616158929"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=616160636"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616168032"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616163682"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616161997"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616156119"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616157476"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(HeroAnim, "Hero Animation Package", function()
        wait(0.7)
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().Character:FindFirstChild("Animate")

        if not Animate then return getgenv().notify("Failure:", "Animate LocalScript does not exist in Character!", 5) end

        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=616111295"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=616113536"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616122287"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616117076"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616115533"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616104706"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616108001"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = Old_WS
    end)

    create_Button(vampireAnim, "Vampire Animation Package", function()
        wait(0.7)
        local player = getgenv().LocalPlayer
        local character = getgenv().Character
        local Animate = character:WaitForChild("Animate")
        local Old_WS = character:FindFirstChildWhichIsA("Humanoid").WalkSpeed

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().Character:FindFirstChild("Animate")
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=1083445855"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=1083450166"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083473930"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083462077"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083455352"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083439238"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083443587"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(mageAnim, "Mage Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().Character:FindFirstChild("Animate")
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=707742142"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=707855907"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707897309"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707861613"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707853694"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707826056"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=707829716"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(ghostAnim, "(FE) Ghost Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().Character:FindFirstChild("Animate")
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().Character:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=616006778"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=616008087"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616010382"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616013216"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616008936"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616003713"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616005863"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(elderAnim, "Elder Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().Character:FindFirstChild("Animate")
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=845397899"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=845400520"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845403856"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845386501"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845398858"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845392038"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=845396048"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(LevitationAnim, "Levitation Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=616006778"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=616008087"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616013216"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616010382"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616008936"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616003713"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=616005863"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(AstronautAnim, "Astronaut Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=891621366"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=891633237"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891667138"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891636393"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891627522"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891609353"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=891617961"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(NinjaAnim, "Ninja Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=656117400"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=656118341"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656121766"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656118852"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656117878"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656114359"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=656115606"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(WerewolfAnim, "Werewolf Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=1083195517"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=1083214717"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083178339"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083216690"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083218792"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083182000"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1083189019"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(CartoonAnim, "Cartoon Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=742637544"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=742638445"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742640026"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742638842"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742637942"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742636889"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=742637151"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(PirateAnim, "Pirate Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=750781874"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=750782770"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750785693"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750783738"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750782230"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750779899"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=750780242"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(SneakyFEAnim, "(FE) Sneaky Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=1132473842"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=1132477671"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132510133"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132494274"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132489853"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132461372"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1132469004"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(ToyAnim, "Toy Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=782841498"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=782845736"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782843345"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782842708"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782847020"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782843869"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=782846423"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(KnightAnim, "Knight Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=657595757"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=657568135"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=657552124"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=657564596"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=658409194"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=658360781"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=657600338"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(ConfidentFEAnim, "(FE) Confident Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=1069977950"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=1069987858"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1070017263"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1070001516"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1069984524"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1069946257"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1069973677"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(PopstarFEAnim, "(FE) Popstar Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=1212900985"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=1212900985"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212980338"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212980348"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212954642"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1213044953"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1212900995"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(PrincessFEAnim, "(FE) Princess Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=941003647"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=941013098"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941028902"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941015281"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941008832"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=940996062"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=941000007"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(CowboyFEAnim, "(FE) Cowboy Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=1014390418"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=1014398616"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014421541"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014401683"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014394726"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014380606"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1014384571"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(PatrolFEAnim, "(FE) Patrol Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().LocalPlayer.Character.Animate
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
        for i, track in pairs (animtrack) do
            track:Stop()
        end
        wait()
        Animate.idle:FindFirstChild("Animation1").AnimationId = "http://www.roblox.com/asset/?id=1149612882"
        Animate.idle:FindFirstChild("Animation2").AnimationId = "http://www.roblox.com/asset/?id=1150842221"
        Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1151231493"
        Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1150967949"
        Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1150944216"
        Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1148811837"
        Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=1148863382"
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)

    create_Button(ZombieFEAnim, "(FE) Zombie Animation Package", function()
        if getgenv().Character:FindFirstChildWhichIsA("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            return getgenv().notify("Failure:", "You must be in R15 to use animation packages.", 6)
        end
        wait(0.7)
        local Animate = getgenv().Character:FindFirstChild("Animate")
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 0
        getgenv().Character:FindFirstChild("HumanoidRootPart").Anchored = false
        wait(apply_anims_delay)
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
        wait(0.1)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
        wait(0.3)
        Animate.Disabled = false
        wait(apply_anims_delay)
        getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
    end)
    -- Also, all of these animations do NOT jump, because while moving, jumping causes issues, and it should also stop you from walking when applying an animation, and it also has a delay to, because of how buggy the animations can be.

    getgenv().SystemBroken = Tab5:CreateButton({
    Name = "System Broken",
    Callback = function()
        -- I modified this whole shit myself, people have copied my System Broken, and to that I say, go to hell!
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/refs/heads/main/source"))()
    end,})
    wait()
    local Trip_Settings = {
        Keybind_Trip = Enum.KeyCode.V,
        Keybind_FakeOut = Enum.KeyCode.R
    }
    wait()
    local function keycode_convert(keyString)
        return Enum.KeyCode[keyString] or Enum.KeyCode[keyString:upper()] or nil
    end
    wait()
    local UserInputService = getgenv().UserInputService
    
    getgenv().Reverse_Keybind = Enum.KeyCode.F
    getgenv().Freeze_Keybind = Enum.KeyCode.V

    local ConfigFileName = "EmoteConfig.json"

    getgenv().Emote_Keybinds_Configuration = getgenv().Emote_Keybinds_Configuration or {}
    getgenv().Emote_Speed_Configuration = getgenv().Emote_Speed_Configuration or {}
    
    local Emote_Keybinds_Configuration = {  
        [Enum.KeyCode.One] = "Rise Above - The Chainsmokers",
        [Enum.KeyCode.Two] = "BLACKPINK Shut Down - Part 2",
        [Enum.KeyCode.Three] = "Fashion Roadkill",
        [Enum.KeyCode.Four] = "Beckon",
        [Enum.KeyCode.Five] = "Hero Landing",
        [Enum.KeyCode.Six] = "Man City Scorpion Kick",
        [Enum.KeyCode.Seven] = "Flowing Breeze",
        [Enum.KeyCode.Eight] = "Tommy - Archer",
        [Enum.KeyCode.Nine] = "Point2",
    }
    
    local Emote_Speed_Configuration = {
        [Enum.KeyCode.Q] = 0.1,
        [Enum.KeyCode.E] = 4,
        [Enum.KeyCode.X] = 1
    }

    local Slots_Table = { 
        ["Number/Key: 1"] = Enum.KeyCode.One,
        ["Number/Key: 2"] = Enum.KeyCode.Two,
        ["Number/Key: 3"] = Enum.KeyCode.Three,
        ["Number/Key: 4"] = Enum.KeyCode.Four,
        ["Number/Key: 5"] = Enum.KeyCode.Five,
        ["Number/Key: 6"] = Enum.KeyCode.Six,
        ["Number/Key: 7"] = Enum.KeyCode.Seven,
        ["Number/Key: 8"] = Enum.KeyCode.Eight,
        ["Number/Key: 9"] = Enum.KeyCode.Nine,
        ["Number/Key: 0"] = Enum.KeyCode.Zero,
        -- Anything past here for emote keybinds is considered retarded, and you gotta have Autism if you use anything past here.
        ["Function Key: F1"] = Enum.KeyCode.F1,
        ["Function Key: F2"] = Enum.KeyCode.F2,
        ["Function Key: F3"] = Enum.KeyCode.F3,
        ["Function Key: F4"] = Enum.KeyCode.F4,
        ["Function Key: F5"] = Enum.KeyCode.F5,
        ["Function Key: F6"] = Enum.KeyCode.F6,
        ["Function Key: F7"] = Enum.KeyCode.F7,
        ["Function Key: F8"] = Enum.KeyCode.F8,
        ["Function Key: F9"] = Enum.KeyCode.F9,
        ["Function Key: F10"] = Enum.KeyCode.F10,
        ["Function Key: F11"] = Enum.KeyCode.F11,
        ["Function Key: F12"] = Enum.KeyCode.F12,
        ["Key: A"] = Enum.KeyCode.A,
        ["Key: B"] = Enum.KeyCode.B,
        ["Key: C"] = Enum.KeyCode.C,
        ["Key: D"] = Enum.KeyCode.D,
        ["Key: E"] = Enum.KeyCode.E,
        ["Key: F"] = Enum.KeyCode.F,
        ["Key: G"] = Enum.KeyCode.G,
        ["Key: H"] = Enum.KeyCode.H,
        ["Key: I"] = Enum.KeyCode.I,
        ["Key: J"] = Enum.KeyCode.J,
        ["Key: K"] = Enum.KeyCode.K,
        ["Key: L"] = Enum.KeyCode.L,
        ["Key: M"] = Enum.KeyCode.M,
        ["Key: N"] = Enum.KeyCode.N,
        ["Key: O"] = Enum.KeyCode.O,
        ["Key: P"] = Enum.KeyCode.P,
        ["Key: Q"] = Enum.KeyCode.Q,
        ["Key: R"] = Enum.KeyCode.R,
        ["Key: S"] = Enum.KeyCode.S,
        ["Key: T"] = Enum.KeyCode.T,
        ["Key: U"] = Enum.KeyCode.U,
        ["Key: V"] = Enum.KeyCode.V,
        ["Key: W"] = Enum.KeyCode.W,
        ["Key: X"] = Enum.KeyCode.X,
        ["Key: Y"] = Enum.KeyCode.Y,
        ["Key: Z"] = Enum.KeyCode.Z,
        ["Key: Shift"] = Enum.KeyCode.LeftShift,
        ["Key: Ctrl"] = Enum.KeyCode.LeftControl,
        ["Key: Alt"] = Enum.KeyCode.LeftAlt,
        ["Key: Right Shift"] = Enum.KeyCode.RightShift,
        ["Key: Right Ctrl"] = Enum.KeyCode.RightControl,
        ["Key: Right Alt"] = Enum.KeyCode.RightAlt,
        ["Key: Escape"] = Enum.KeyCode.Escape,
        ["Key: Tab"] = Enum.KeyCode.Tab, -- I hope you die if you use this.
        ["Key: CapsLock"] = Enum.KeyCode.CapsLock,
        ["Key: Space"] = Enum.KeyCode.Space,
        ["Key: Enter"] = Enum.KeyCode.Return,
        ["Key: Backspace"] = Enum.KeyCode.Backspace,
        ["Key: Delete"] = Enum.KeyCode.Delete,
        ["Key: Insert"] = Enum.KeyCode.Insert,
        -- If you use "Home", "End", "PageUp", "PageDown" or any of the fucking arrow keys, who are you and what the hell are you thinking? nobody is using these bum ass keycodes.
        ["Key: Home"] = Enum.KeyCode.Home,
        ["Key: End"] = Enum.KeyCode.End,
        ["Key: PageUp"] = Enum.KeyCode.PageUp,
        ["Key: PageDown"] = Enum.KeyCode.PageDown,
        ["Arrow Key: Up"] = Enum.KeyCode.Up,
        ["Arrow Key: Down"] = Enum.KeyCode.Down,
        ["Arrow Key: Left"] = Enum.KeyCode.Left,
        ["Arrow Key: Right"] = Enum.KeyCode.Right,
        ["Numpad: 0"] = Enum.KeyCode.KeypadZero,
        ["Numpad: 1"] = Enum.KeyCode.KeypadOne,
        ["Numpad: 2"] = Enum.KeyCode.KeypadTwo,
        ["Numpad: 3"] = Enum.KeyCode.KeypadThree,
        ["Numpad: 4"] = Enum.KeyCode.KeypadFour,
        ["Numpad: 5"] = Enum.KeyCode.KeypadFive,
        ["Numpad: 6"] = Enum.KeyCode.KeypadSix,
        ["Numpad: 7"] = Enum.KeyCode.KeypadSeven,
        ["Numpad: 8"] = Enum.KeyCode.KeypadEight,
        ["Numpad: 9"] = Enum.KeyCode.KeypadNine,
        ["Numpad: Plus"] = Enum.KeyCode.KeypadPlus,
        ["Numpad: Minus"] = Enum.KeyCode.KeypadMinus,
        ["Numpad: Multiply"] = Enum.KeyCode.KeypadMultiply,
        ["Numpad: Divide"] = Enum.KeyCode.KeypadDivide,
        ["Numpad: Enter"] = Enum.KeyCode.KeypadEnter, -- What the fuck?
        ["Numpad: Dot"] = Enum.KeyCode.KeypadPeriod,
        ["Mouse: Left Click"] = Enum.UserInputType.MouseButton1,
        ["Mouse: Right Click"] = Enum.UserInputType.MouseButton2,
        ["Mouse: Middle Click"] = Enum.UserInputType.MouseButton3,
        ["Controller: A"] = Enum.KeyCode.ButtonA,
        ["Controller: B"] = Enum.KeyCode.ButtonB,
        ["Controller: X"] = Enum.KeyCode.ButtonX,
        ["Controller: Y"] = Enum.KeyCode.ButtonY,
        ["Controller: L1"] = Enum.KeyCode.ButtonL1,
        ["Controller: R1"] = Enum.KeyCode.ButtonR1,
        ["Controller: L2"] = Enum.KeyCode.ButtonL2,
        ["Controller: R2"] = Enum.KeyCode.ButtonR2,
        ["Controller: L3"] = Enum.KeyCode.ButtonL3,
        ["Controller: R3"] = Enum.KeyCode.ButtonR3,
        ["Controller: Start"] = Enum.KeyCode.ButtonStart,
        ["Controller: Select"] = Enum.KeyCode.ButtonSelect,
        ["Controller: D-Pad Up"] = Enum.KeyCode.DPadUp,
        ["Controller: D-Pad Down"] = Enum.KeyCode.DPadDown,
        ["Controller: D-Pad Left"] = Enum.KeyCode.DPadLeft,
        ["Controller: D-Pad Right"] = Enum.KeyCode.DPadRight,
        ["Controller: Left Stick"] = Enum.KeyCode.Thumbstick1,
        ["Controller: Right Stick"] = Enum.KeyCode.Thumbstick2,
    }
    
    Emote_Speed_Configuration[getgenv().Freeze_Keybind] = 0
    Emote_Speed_Configuration[getgenv().Reverse_Keybind] = -1

    local Slots_Options = {}
    for name, _ in pairs(Slots_Table) do
        table.insert(Slots_Options, name)
    end
    wait()
    local selectedSlot = nil

    getgenv().PickASlot = Tab15:CreateDropdown({
    Name = "Choose a Keybind (To assign the Emote to)",
    Options = Slots_Options,
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "select_slot",
    Callback = function(slotName)
        if typeof(slotName) == "table" then
            slotName = slotName[1]
        end

        if typeof(slotName) ~= "string" or not Slots_Table[slotName] then
            return -- Lazy fix for small performance but you can go to hell.
        end

        selectedSlot = Slots_Table[slotName]
        -- And another lazy fix, unnecessary, so go to hell (x2)
        --getgenv().notify("Success:", "Selected Slot: " .. slotName .. " (Keybind: " .. tostring(selectedSlot) .. ")", 6)
    end,})

    -- I remember when I tried to put a text next to the emote like: "[NEW]: " but that doesn't work because we use "getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmote(emote_name)" <-- but using this you need the actual name of the emote and the fucking emote isn't named "[NEW]: NBA Master Dunk", like wtf?
    local Emotes = {
        "NBA Monster Dunk",
        "Stray Kids Walkin On Water",
        "TWICE Strategy",
        "Sleep",
        "Olivia Rodrigo Head Bop",
        "Sturdy Dance - Ice Spice",
        "Victory Dance",
        "Elton John - Heart Shuffle",
        "Bored",
        "Chappell Roan HOT TO GO!",
        "High Wave",
        "Mae Stephens - Piano Hands",
        "Disagree",
        "Line Dance",
        "Agree",
        "BLACKPINK Shut Down - Part 2",
        "Yungblud Happier Jump",
        "Sad",
        "HUGO Let's Drive!",
        "Show Dem Wrists - KSI",
        "Shy",
        "Floss Dance",
        "Tommy - Archer",
        "Wake Up Call - KSI",
        "Fashion Roadkill",
        "Paris Hilton - Sliving For The Groove",
        "Greatest",
        "Happy",
        "Cower",
        "Fast Hands",
        "Cuco - Levitate",
        "Bone Chillin' Bop",
        "Festive Dance",
        "Sidekicks - George Ezra",
        "Baby Queen - Face Frame",
        "Beckon",
        "Zombie",
        "Godlike",
        "Curtsy",
        "Alo Yoga Pose - Lotus Position",
        "Dancin' Shoes - Twenty One Pilots",
        "Confused",
        "Elton John - Heart Skip",
        "HIPMOTION - Amaarae",
        "Monkey",
        "KATSEYE - Touch",
        "Baby Queen - Bouncy Twirl",
        "Rock Out - Bebe Rexha",
        "d4vd - Backflip",
        "Rock On",
        "Team USA Breaking Emote",
        "Uprise - Tommy Hilfiger",
        "Wanna play?",
        "Baby Queen - Air Guitar & Knee Slide",
        "TWICE Feel Special",
        "Wisp - air guitar",
        "Secret Handshake Dance",
        "HOLIDAY Dance - Lil Nas X (LNX)",
        "Old Town Road Dance - Lil Nas X (LNX)",
        "Frosty Flair - Tommy Hilfiger",
        "Rock n Roll",
        "Jumping Wave",
        "Sol de Janeiro - Samba",
        "Baby Queen - Strut",
        "Baby Queen - Dramatic Bow",
        "Hero Landing",
        "Bodybuilder",
        "V Pose - Tommy Hilfiger",
        "Boxing Punch - KSI",
        "Quiet Waves",
        "Baby Dance",
        "Top Rock",
        "Nicki Minaj Starships",
        "Dave's Spin Move - Glass Animals",
        "TWICE LIKEY",
        "TWICE I GOT YOU part 2",
        "Tantrum",
        "Rock Guitar - Royal Blood",
        "Elton John - Elevate",
        "ericdoa - dance",
        "Imagine Dragons - \"Bones\" Dance",
        'GloRilla - "Tomorrow" Dance',
        "Take Me Under - Zara Larsson",
        "Olivia Rodrigo Fall Back to Float",
        "Get Out",
        "Haha",
        "It Ain't My Fault - Zara Larsson",
        "High Hands",
        "Jawny - Stomp",
        "Power Blast",
        "Alo Yoga Pose - Warrior II",
        "Hips Poppin' - Zara Larsson",
        "Y",
        "Elton John - Rock Out",
        "Nicki Minaj Boom Boom Boom",
        "Flowing Breeze",
        "Mean Mug - Tommy Hilfiger",
        "Samba",
        "Fashion Klossette - Runway my way",
        "NBA WNBA Fadeaway",
        "Swish",
        "Robot",
        "TWICE I GOT YOU part 1",
        "Beauty Touchdown",
        "Floor Rock Freeze - Tommy Hilfiger",
        "Cha Cha",
        "Alo Yoga Pose - Triangle",
        "Dizzy",
        "Break Dance",
        "Fishing",
        "Sticker Dance Move - NCT 127",
        "Paris Hilton - Iconic IT-Grrrl",
        "Side to Side",
        "Tommy K-Pop Mic Drop",
        "Mini Kong",
        "Jacks",
        "Up and Down - Twenty One Pilots",
        "Rolling Stones Guitar Strum",
        "Idol",
        "AOK - Tai Verdes",
        "Boom Boom Clap - George Ezra",
        "Celebrate",
        "Celebrate",
        "Rock Star - Royal Blood",
        "Around Town",
        "The Zabb",
        "Elton John - Still Standing",
        "TMNT Dance",
        "Flex Walk",
        "Paris Hilton - Checking My Angles",
        "Tree",
        "Dolphin Dance",
        "Air Guitar",
        "Drummer Moves - Twenty One Pilots",
        "Ay-Yo Dance Move - NCT 127",
        "Saturday Dance - Twenty One Pilots",
        "Swan Dance",
        "Kick It Dance Move - NCT 127",
        "Fancy Feet",
        "SpongeBob Imaginaaation 🌈",
        "Lasso Turn - Tai Verdes",
        "Elton John - Cat Man",
        "Dorky Dance",
        "Rise Above - The Chainsmokers",
        "Shuffle",
        "Arm Twist",
        "Twirl",
        "T",
        "Rodeo Dance - Lil Nas X (LNX)",
        "Louder",
        "Super Charge",
        "Mean Girls Dance Break",
        "Sneaky",
        "Cobra Arms - Tai Verdes",
        "Shrek Roar",
        "Air Dance",
        "On The Outside - Twenty One Pilots",
        "Block Partier",
        "Chill Vibes - George Ezra",
        "Fashionable",
        "Jumping Cheer",
        "Drum Solo - Royal Blood",
        "Elton John - Piano Jump",
        "Keeping Time",
        "Olivia Rodrigo good 4 u",
        "Cartwheel - George Ezra",
        "Panini Dance - Lil Nas X (LNX)",
        "Paris Hilton Sanasa",
        "Drum Master - Royal Blood",
        "Salute",
        "Tilt",
        "Applaud",
        "Hello",
        "Shrug",
        "Point2",
        "Stadium",
    }

    getgenv().SelectAnEmote = Tab15:CreateDropdown({
    Name = "Choose an Emote",
    Options = Emotes,
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "select_emote",
    Callback = function(emote)
        if typeof(emote) == "table" then
            emote = emote[1]
        end
        
        if typeof(emote) ~= "string" then
            return warn("Invalid emote selection: Expected a string, got:", typeof(emote))
        end

        if not selectedSlot then
            return warn("Please select a slot first before choosing an emote!")
        end

        UpdateEmoteKeybind(selectedSlot, emote)
        getgenv().notify("Success:", "Assigned emote: '" .. emote .. "' to keybind: " .. tostring(selectedSlot), 6)
    end,})

    getgenv().Emote_Speed_Editor_Config = Tab15:CreateSlider({
    Name = "Speed Up Emote Speed",
    Range = {0, 80},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "changingTheConfigEmoteSpeed",
    Callback = function(emoteSpeedConfigSlider)
        Emote_Speed_Configuration[Enum.KeyCode.E] = tonumber(emoteSpeedConfigSlider)
        getgenv().emoting_actions(tonumber(emoteSpeedConfigSlider))
    end,})

    getgenv().Emote_Slow_Down_Speed_Config = Tab15:CreateSlider({
    Name = "Slow Down Emote Speed",
    Range = {0, 0.9},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0.9,
    Flag = "changingSlowDownConfig",
    Callback = function(emoteSlowDownConfig)
        Emote_Speed_Configuration[Enum.KeyCode.Q] = tonumber(emoteSlowDownConfig)
        getgenv().emoting_actions(tonumber(emoteSlowDownConfig))
    end,})

    local ConfigFileName = "EmoteConfig.json"
    wait()
    getgenv().SaveEmoteConfig = Tab15:CreateButton({
    Name = "Save Emote Configuration",
    Callback = function()
        local function save_emote_configuration()
            local data = {}
            for key, emote in pairs(getgenv().Emote_Keybinds_Configuration) do
                local keyName = tostring(key):match("Enum%.KeyCode%.(.+)")
                if keyName then
                    data[keyName] = emote
                end
            end
            writefile(ConfigFileName, HttpService:JSONEncode(data))
            getgenv().notify("Success:", "Emote Configuration Saved!", 5)
        end
    end,})

    getgenv().LoadEmoteConfig = Tab15:CreateButton({
    Name = "Load Emote Configuration",
    Callback = function()
        function Init_Emote_Configuration()
            local ConfigFileName = "EmoteConfig.json"

            if isfile(ConfigFileName) then
                local jsonData = readfile(ConfigFileName)
                local data = HttpService:JSONDecode(jsonData)

                table.clear(getgenv().Emote_Keybinds_Configuration)

                for keyName, emote in pairs(data) do
                    local keyEnum = Enum.KeyCode[keyName]
                    if keyEnum then
                        getgenv().Emote_Keybinds_Configuration[keyEnum] = emote
                        getgenv().notify("Loaded:", "Key: " .. keyName .. " -> Emote: " .. emote, 5)
                    else
                        getgenv().notify("Warning:", "Invalid KeyCode: " .. keyName, 5)
                    end
                end
                getgenv().notify("Success:", "Loaded Emote Configuration from: " .. tostring(ConfigFileName), 5)
            else
                getgenv().notify("Failed:", "Emote Configuration was not found.", 5)
            end
        end
        wait()
        Init_Emote_Configuration()
    end,})

    getgenv().DeleteEmoteConfig = Tab15:CreateButton({
    Name = "Delete Emote Configuration",
    Callback = function()
        local function erase_config()
            if isfile(ConfigFileName) then
                delfile(ConfigFileName)
                getgenv().notify("Success:", "Deleted Emote Configuration!", 5)
            else
                getgenv().notify("Error:", "No configuration file found!", 5)
            end
        end     
        
        erase_config()
    end,})
    wait()
    getgenv().EmoteSystemEnabled = true
    getgenv().BoundConnections = {}

    local speedToggle = 1

    local function input_connecting(input, other)
        if not getgenv().EmoteSystemEnabled or other then return end

        if input.KeyCode == getgenv().Reverse_Keybind then
            speedToggle = (speedToggle == 1) and -1 or 1
            Emote_Speed_Configuration[getgenv().Reverse_Keybind] = speedToggle
            getgenv().emoting_actions(speedToggle)
        elseif input.KeyCode == getgenv().Freeze_Keybind then
            getgenv().emoting_actions(0)
        end
    end

    function emote_system(state)
        getgenv().EmoteSystemEnabled = state
    end

    getgenv().BoundConnections["EmoteInput"] = UserInputService.InputBegan:Connect(input_connecting)
    wait()
    getgenv().Trip_Keybind = Tab15:CreateDropdown({
    Name = "Trip Keybind",
    -- I must have been smoking something or some shit when writing this code, what the hell is "Euro"? I must have really dug into Roblox's keycode API, because what the hell is ButtonStart??? 😭😭
    Options = {"Q","E","R","T","Y","U","I","O","P","F","G","H","J","K","L","Z","X","C","V","B","N","M",
               "Comma","Period","Question","Semicolon","Colon","LeftAlt","RightAlt","LeftControl",
               "RightControl","LeftBracket","RightBracket","BackSlash","Pipe","LeftCurly",
               "RightCurly","Underscore","Minus","LeftParenthesis","RightParenthesis","Asterisk",
               "Slash","GreaterThan","LessThan","Backquote","At","Equals","Caret","Hash","Dollar",
               "Percent","Ampersand","Quote","QuotedDouble","Plus","F1","F2","F3","F4","F5","F6",
               "F7","F8","F9","F10","F11","F12","Print","Help","Compose","Menu","Euro","ButtonX",
               "ButtonA","ButtonY","ButtonB","ButtonR1","ButtonL1","ButtonL2","ButtonR2","ButtonL3",
               "ButtonStart","ButtonSelect","DPadLeft","DPadRight","DPadUp","DPadDown","Thumbstick1", "Thumbstick2"},
    CurrentOption = "N",
    MultipleOptions = false,
    Flag = "TrippingOverKeybind",
    Callback = function(KeyForTripping)
        local new_keycode = Enum.KeyCode[KeyForTripping[1]]
        if new_keycode then
            Trip_Settings.Keybind_Trip = new_keycode
        end
    end,})
    
    getgenv().FakeOut_Keybind = Tab15:CreateDropdown({
    Name = "Fake Out Keybind",
    Options = {"Q","E","R","T","Y","U","I","O","P","F","G","H","J","K","L","Z","X","C","V","B","N","M",
               "Comma","Period","Question","Semicolon","Colon","LeftAlt","RightAlt","LeftControl",
               "RightControl","LeftBracket","RightBracket","BackSlash","Pipe","LeftCurly",
               "RightCurly","Underscore","Minus","LeftParenthesis","RightParenthesis","Asterisk",
               "Slash","GreaterThan","LessThan","Backquote","At","Equals","Caret","Hash","Dollar",
               "Percent","Ampersand","Quote","QuotedDouble","Plus","F1","F2","F3","F4","F5","F6",
               "F7","F8","F9","F10","F11","F12","Print","Help","Compose","Menu","Euro","ButtonX",
               "ButtonA","ButtonY","ButtonB","ButtonR1","ButtonL1","ButtonL2","ButtonR2","ButtonL3",
               "ButtonStart","ButtonSelect","DPadLeft","DPadRight","DPadUp","DPadDown","Thumbstick1", "Thumbstick2"},
    CurrentOption = "R",
    MultipleOptions = false,
    Flag = "FakingOutKeybind",
    Callback = function(key_for_fake_out)
        local newest_keycode = Enum.KeyCode[key_for_fake_out[1]]
        if newest_keycode then
            Trip_Settings.Keybind_FakeOut = newest_keycode
        end
    end,})
    
    getgenv().Trip_Script = Tab15:CreateToggle({
    Name = "Trip",
    CurrentKeybind = "T",
    HoldToInteract = false,
    Flag = "TripKeybindMain",
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
                local hum = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
                local root = getgenv().Character:FindFirstChild("HumanoidRootPart")
                hum:ChangeState(0)
                root.Velocity = root.CFrame.LookVector * 30
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
    wait()
    if getgenv().Trip_Enabled == true then
        getgenv().Trip_Enabled = false
        getgenv().Trip_Script:Set(false)
    end
    wait()
    local HttpService = getgenv().HttpService
    wait()
    local function del_ez_Config()
        if isfolder("executor_configs/") then
            delfolder("executor_configs/")
            getgenv().notify("Success.", "Configuration Folder has been deleted.", 6)
        else
            getgenv().notify("Failure.", "No saved Configuration Folder to delete.", 6)
        end
    end

    function load_ez_Config()
        local saveDirectory = "executor_configs/"
        local configTable = {}

        local configKeys = {
            "Huge_Baseplate", "Animation_Fall", "System_Broken", "Emote_Keybinds",
            "Animation_Climb", "Death_On_Load", "Custom_Animation_Package_System",
            "Infinite_Yield_Premium", "Animation_Idle", "Old_Materials",
            "Animation_Jump", "Anti_Suspend_VC", "Performance_Statistics",
            "Fully_Loaded_Message", "Fully_Loaded_Messaging", "Animation_Run", 
            "Script_Clock_Time_GUI", "Animation_Walk", "keep_tp_tool", "AntiAFK"
        }

        for _, key in ipairs(configKeys) do
            local filePath = saveDirectory .. key .. ".json"
            
            if isfile(filePath) then
                local fileContent = readfile(filePath)
                local decodedData = HttpService:JSONDecode(fileContent)

                configTable[key] = decodedData[key]
            else
                configTable[key] = "off"
            end
        end
    end

    function readConfigValue(key)
        local filePath = "executor_configs/" .. key .. ".json"

        if isfile(filePath) then
            local fileContent = readfile(filePath)
            local decodedData = HttpService:JSONDecode(fileContent)

            local value = decodedData[key]

            return value == "on"
        else
            return false
        end
    end

    function getAnimation(animationType)
        local filePath = "executor_configs/" .. animationType .. ".json"

        if isfile(filePath) then
            local fileContent = readfile(filePath)
            local decodedData = HttpService:JSONDecode(fileContent)

            return decodedData[animationType]
        else
            return "Zombie"
        end
    end
    wait()
    getgenv().TurnOffBoothMenuGUI = Tab20:CreateToggle({
    Name = "Toggle Booth GUI/Menu (When claiming a Booth)",
    CurrentValue = false,
    Flag = "TurnOffTheBoothGUIThing",
    Callback = function(toggledBoothMenuGUIVisibility)
        if toggledBoothMenuGUIVisibility then
            getgenv().turned_off_booth_GUI = true
            while getgenv().turned_off_booth_GUI == true do
            wait()
                if getgenv().PlayerGui:FindFirstChild("Booth") and getgenv().PlayerGui:FindFirstChild("Booth").Enabled then
                    getgenv().PlayerGui:FindFirstChild("Booth").Enabled = false
                end
            end
        else
            getgenv().turned_off_booth_GUI = false
            wait(0.3)
            if getgenv().PlayerGui:FindFirstChild("Booth") then
                getgenv().PlayerGui:FindFirstChild("Booth"):Destroy()
            end
        end
    end,})
    wait(0.2)
    if getgenv().turned_off_booth_GUI == true then
        getgenv().TurnOffBoothMenuGUI:Set(false)
        getgenv().turned_off_booth_GUI = false
    end

    getgenv().DeleteYourCustomConfigurationZEH = Tab20:CreateButton({
    Name = "Delete Easy Configuration",
    Callback = function()
        del_ez_Config()
    end,})

    getgenv().LoadEzConfigurationSettings = Tab20:CreateButton({
    Name = "Load Easy Configuration",
    Callback = function()
        load_ez_Config()
    end,})

    --[[getgenv().CustomAnimPackageSetting = Tab20:CreateToggle({
    Name = "Use Custom Animation Package System",
    CurrentValue = readConfigValue("Custom_Animation_Package_System") or false,
    Flag = "TurningOnTheAnimationPackagesCustom",
    Callback = function(animPackageCustoms)
        getgenv().using_custom_animation_packages = animPackageCustoms
        getgenv().Easies_Configuration["Custom_Animation_Package_System"] = animPackageCustoms and "on" or "off"
    end,})

    idle_anim_selected = nil
    walk_anim_selected = nil
    run_anim_selected = nil
    jump_anim_selected = nil
    fall_anim_selected = nil
    climb_anim_selected = nil
    wait()
    getgenv().IdleAnimToSet = Tab20:CreateDropdown({
    Name = "Idle Animation",
    Options = {"Zombie", "Catwalk Glam", "Elder", "Cartoony", "Adidas", "Werewolf", "Vampire", "Astronaut", "Superhero", "Knight", "Mage", "Ninja", "Toy", "NFL", "No Boundaries", "Oldschool", "Pirate", "Levitation", "Bubbly", "Robot", "Wicked Popular", "Bold", "Stylish", "Rthro"},
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "IdleAnimDropdownList",
    Callback = function(dropSelectedForAnim)
        if getgenv().using_custom_animation_packages or getgenv().using_custom_animation_packages == true then
            if typeof(dropSelectedForAnim) == "table" then
                dropSelectedForAnim = dropSelectedForAnim[1]
            end
            wait()
            idle_anim_selected = dropSelectedForAnim
        else
            getgenv().notify("Failure", "Use Custom Animation Packages is not enabled.", 6)
        end
    end,})

    getgenv().WalkAnimToSet = Tab20:CreateDropdown({
    Name = "Walk Animation",
    Options = {"Zombie", "Catwalk Glam", "Elder", "Cartoony", "Adidas", "Werewolf", "Vampire", "Astronaut", "Superhero", "Knight", "Mage", "Ninja", "Toy", "NFL", "No Boundaries", "Oldschool", "Pirate", "Levitation", "Bubbly", "Robot", "Wicked Popular", "Bold", "Stylish", "Rthro"},
    CurrentOption = getAnimation("Animation_Walk"),
    MultipleOptions = false,
    Flag = "WalkAnimationDropdownList",
    Callback = function(selectedWalkAnim)
        if getgenv().using_custom_animation_packages or getgenv().using_custom_animation_packages == true then
            print("Dropdown Selection Type:", typeof(selectedWalkAnim))
            
            if typeof(selectedWalkAnim) == "table" then
                selectedWalkAnim = selectedWalkAnim[1]
            end

            save_anim_config(tostring(selectedWalkAnim), "Walk")
            wait(0.1)
            getgenv().Easies_Configuration["Animation_Walk"] = tostring(selectedWalkAnim)
        else
            getgenv().notify("Failure", "Use Custom Animation Packages is not enabled.", 6)
        end
    end,})

    getgenv().RunAnimToSet = Tab20:CreateDropdown({
    Name = "Run Animation",
    Options = {"Zombie", "Catwalk Glam", "Elder", "Cartoony", "Adidas", "Werewolf", "Vampire", "Astronaut", "Superhero", "Knight", "Mage", "Ninja", "Toy", "NFL", "No Boundaries", "Oldschool", "Pirate", "Levitation", "Bubbly", "Robot", "Wicked Popular", "Bold", "Stylish", "Rthro"},
    CurrentOption = getAnimation("Animation_Run"),
    MultipleOptions = false,
    Flag = "RunAnimationDropdownList",
    Callback = function(selectedRunAnim)
        if getgenv().using_custom_animation_packages or getgenv().using_custom_animation_packages == true then
            print("Dropdown Selection Type:", typeof(selectedRunAnim))
            
            if typeof(selectedRunAnim) == "table" then
                selectedRunAnim = selectedRunAnim[1]
            end

            save_anim_config(tostring(selectedRunAnim), "Run")
            getgenv().Easies_Configuration["Animation_Run"] = tostring(selectedRunAnim)
        else
            getgenv().notify("Failure", "Use Custom Animation Packages is not enabled.", 6)
        end
    end,})

    getgenv().JumpAnimToSet = Tab20:CreateDropdown({
    Name = "Jump Animation",
    Options = {"Zombie", "Catwalk Glam", "Elder", "Cartoony", "Adidas", "Werewolf", "Vampire", "Astronaut", "Superhero", "Knight", "Mage", "Ninja", "Toy", "NFL", "No Boundaries", "Oldschool", "Pirate", "Levitation", "Bubbly", "Robot", "Wicked Popular", "Bold", "Stylish", "Rthro"},
    CurrentOption = getAnimation("Animation_Jump"),
    MultipleOptions = false,
    Flag = "JumpAnimationDropdownList",
    Callback = function(selectedJumpAnim)
        if getgenv().using_custom_animation_packages or getgenv().using_custom_animation_packages == true then
            print("Dropdown Selection Type:", typeof(selectedJumpAnim))
            
            if typeof(selectedJumpAnim) == "table" then
                selectedJumpAnim = selectedJumpAnim[1]
            end

            save_anim_config(tostring(selectedJumpAnim), "Jump")
            getgenv().Easies_Configuration["Animation_Jump"] = tostring(selectedJumpAnim)
        else
            getgenv().notify("Failure", "Use Custom Animation Packages is not enabled.", 6)
        end
    end,})

    getgenv().FallAnimToSet = Tab20:CreateDropdown({
    Name = "Fall Animation",
    Options = {"Zombie", "Catwalk Glam", "Elder", "Cartoony", "Adidas", "Werewolf", "Vampire", "Astronaut", "Superhero", "Knight", "Mage", "Ninja", "Toy", "NFL", "No Boundaries", "Oldschool", "Pirate", "Levitation", "Bubbly", "Robot", "Wicked Popular", "Bold", "Stylish", "Rthro"},
    CurrentOption = getAnimation("Animation_Fall"),
    MultipleOptions = false,
    Flag = "FallAnimationDropdownList",
    Callback = function(selectedFallAnim)
        if getgenv().using_custom_animation_packages or getgenv().using_custom_animation_packages == true then
            print("Dropdown Selection Type:", typeof(selectedFallAnim))
            
            if typeof(selectedFallAnim) == "table" then
                selectedFallAnim = selectedFallAnim[1]
            end

            save_anim_config(tostring(selectedFallAnim), "Fall")
            getgenv().Easies_Configuration["Animation_Fall"] = tostring(selectedFallAnim)
        else
            getgenv().notify("Failure", "Use Custom Animation Packages is not enabled.", 6)
        end
    end,})

    getgenv().ClimbAnimToSet = Tab20:CreateDropdown({
    Name = "Climb Animation",
    Options = {"Zombie", "Catwalk Glam", "Elder", "Cartoony", "Adidas", "Werewolf", "Vampire", "Astronaut", "Superhero", "Knight", "Mage", "Ninja", "Toy", "NFL", "No Boundaries", "Oldschool", "Pirate", "Levitation", "Bubbly", "Robot", "Wicked Popular", "Bold", "Stylish", "Rthro"},
    CurrentOption = getAnimation("Animation_Climb"),
    MultipleOptions = false,
    Flag = "ClimbAnimationDropdownList",
    Callback = function(selectedClimbAnim)
        if getgenv().using_custom_animation_packages or getgenv().using_custom_animation_packages == true then
            print("Dropdown Selection Type:", typeof(selectedClimbAnim))
            
            if typeof(selectedClimbAnim) == "table" then
                selectedClimbAnim = selectedClimbAnim[1]
            end

            save_anim_config(tostring(selectedClimbAnim), "Climb")
            getgenv().Easies_Configuration["Animation_Climb"] = tostring(selectedClimbAnim)
        else
            getgenv().notify("Failure", "Use Custom Animation Packages is not enabled.", 6)
        end
    end,})

    getgenv().DieUponLoad = Tab20:CreateToggle({
    Name = "Reset When Loading Script",
    CurrentValue = readConfigValue("Death_On_Load") or false,
    Flag = "ResettingWhenLoadingScript",
    Callback = function(dieWhenLoadingScript)
        getgenv().die_upon_loading = dieWhenLoadingScript
        getgenv().Easies_Configuration["Death_On_Load"] = dieWhenLoadingScript and "on" or "off"
    end,})

    getgenv().AntiAFKSetting = Tab20:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = readConfigValue("AntiAFK") or false,
    Flag = "AntiAFKIsEnabled",
    Callback = function(antiAfkScriptOn)
        getgenv().anti_afk_toggle = antiAfkScriptOn
        getgenv().Easies_Configuration["AntiAFK"] = antiAfkScriptOn and "on" or "off"
    end,})

    getgenv().LoadingScreenEnabled = Tab20:CreateToggle({
    Name = "Loading Screen",
    CurrentValue = readConfigValue("Loading_Screen") or false,
    Flag = "LoadingScreenCheckedOn",
    Callback = function(loadTheScreenImage)
        getgenv().Load_Screen = loadTheScreenImage
        getgenv().Easies_Configuration["Loading_Screen"] = loadTheScreenImage and "on" or "off"
    end,})

    getgenv().MuteAllBoomboxesCellmatesVC = Tab20:CreateToggle({
    Name = "Mute All Boomboxes (Cellmates VC)",
    CurrentValue = readConfigValue("Mute_Boomboxes_Cellmates_VC_Game_Setting") or false,
    Flag = "mutingAllTheBoomboxesCellmates",
    Callback = function(boomboxesMutedToggle)
        getgenv().boomboxes_on = boomboxesMutedToggle
        getgenv().Easies_Configuration["Mute_Boomboxes_Cellmates_VC_Game_Setting"] = boomboxesMutedToggle and "on" or "off"
    end,})

    getgenv().MuteTheMusicCellmatesVC = Tab20:CreateToggle({
    Name = "Mute Music (Cellmates VC)",
    CurrentValue = readConfigValue("Mute_Music_Volume_Cellmates_VC_Game_Setting") or false,
    Flag = "MutingAllTheMusicCellmates",
    Callback = function(cellmatesVCMusicToggle)
        getgenv().music_mute_configured = cellmatesVCMusicToggle
        getgenv().Easies_Configuration["Mute_Music_Volume_Cellmates_VC_Game_Setting"] = cellmatesVCMusicToggle and "on" or "off"
    end,})

    getgenv().MuteAllSFXCellmatesVC = Tab20:CreateToggle({
    Name = "Mute Sound Effects (Cellmates VC)",
    CurrentValue = readConfigValue("Mute_Sound_Effects_Cellmates_VC_Game_Setting") or false,
    Flag = "MutingSFXSoundsCellmates",
    Callback = function(isSFXEnabledCellmatesVC)
        getgenv().sfx_sounds_on = isSFXEnabledCellmatesVC
        getgenv().Easies_Configuration["Mute_Sound_Effects_Cellmates_VC_Game_Setting"] = isSFXEnabledCellmatesVC and "on" or "off"
    end,})

    getgenv().fullyLoadedMsg = Tab20:CreateToggle({
    Name = "Chat - Fully Loaded Message",
    CurrentValue = readConfigValue("Fully_Loaded_Messaging") or false,
    Flag = "FullyLoadMessageText",
    Callback = function(msgToFullyLoad)
        getgenv().IsFullLoadedMessage = msgToFullyLoad
        getgenv().Easies_Configuration["Fully_Loaded_Messaging"] = msgToFullyLoad and "on" or "off"
    end,})

    getgenv().textForFullyLoadedMessage = Tab20:CreateInput({
    Name = "Fully Loaded Message",
    CurrentValue = readConfigValue("Fully_Loaded_Message") or "Flames Hub - Winning!",
    PlaceholderText = "Text Here",
    RemoveTextAfterFocusLost = true,
    Flag = "toStringForFullLoadedMsg",
    Callback = function(theFullLoadedMsg)
        getgenv().Easies_Configuration["Fully_Loaded_Message"] = tostring(theFullLoadedMsg)
    end,})

    getgenv().hugeBasePlateOn = Tab20:CreateToggle({
    Name = "Huge Baseplate",
    CurrentValue = readConfigValue("Huge_Baseplate") or false,
    Flag = "HugeBaseplateToggled",
    Callback = function(baseplateBigToggled)
        getgenv().biggest_baseplate_yes = baseplateBigToggled
        getgenv().Easies_Configuration["Huge_Baseplate"] = baseplateBigToggled and "on" or "off"
    end,})

    getgenv().clocksTimeDayNight = Tab20:CreateToggle({
    Name = "Script Clock Time GUI",
    CurrentValue = readConfigValue("Script_Clock_Time_GUI") or false,
    Flag = "ScriptLoadClockTimeGUI",
    Callback = function(clockTimeGUIEnabled)
        getgenv().day_night_cycle_script_gui = clockTimeGUIEnabled
        getgenv().Easies_Configuration["Script_Clock_Time_GUI"] = clockTimeGUIEnabled and "on" or "off"
    end,})

    getgenv().AntiSuspendVCAuto = Tab20:CreateToggle({
    Name = "Anti Suspend VC (Auto)",
    CurrentValue = readConfigValue("Anti_Suspend_VC") or false,
    Flag = "AntiAutoSuspendVC",
    Callback = function(autoUnsuspendVC)
        getgenv().haha_never_suspend = autoUnsuspendVC
        getgenv().Easies_Configuration["Anti_Suspend_VC"] = autoUnsuspendVC and "on" or "off"
    end,})

    getgenv().InfYieldPrem = Tab20:CreateToggle({
    Name = "Infinite Yield Premium",
    CurrentValue = readConfigValue("Infinite_Yield_Premium") or false,
    Flag = "InfYieldPremOn",
    Callback = function(EnabledInfYieldPremium)
        getgenv().new_modified_inf_yield = EnabledInfYieldPremium
        getgenv().Easies_Configuration["Infinite_Yield_Premium"] = EnabledInfYieldPremium and "on" or "off"
    end,})

    getgenv().PerformanceStats = Tab20:CreateToggle({
    Name = "Performance Statistics",
    CurrentValue = readConfigValue("Performance_Statistics") or false,
    Flag = "PerformanceStatsGUI",
    Callback = function(hasPerformanceStatsEnabled)
        getgenv().performance_is_toggled = hasPerformanceStatsEnabled
        getgenv().Easies_Configuration["Performance_Statistics"] = hasPerformanceStatsEnabled and "on" or "off"
    end,})

    getgenv().OldMaterialUsingVal = Tab20:CreateToggle({
    Name = "Old Materials (Materials Before 2022)",
    CurrentValue = readConfigValue("Old_Materials") or false,
    Flag = "HasSwitchedOldMaterialsOn",
    Callback = function(hasOldMaterials)
        getgenv().utilizing_old_stuff_materials = hasOldMaterials
        getgenv().Easies_Configuration["Old_Materials"] = hasOldMaterials and "on" or "off"
    end,})

    getgenv().sysBroken_Other_Mod = Tab20:CreateToggle({
    Name = "Flames System Broken (Auto-Load)",
    CurrentValue = readConfigValue("System_Broken") or false,
    Flag = "SystemBrokenBeingLoaded",
    Callback = function(hasEnabledSysBroken)
        getgenv().usingOldSysBroken = hasEnabledSysBroken
        getgenv().Easies_Configuration["System_Broken"] = hasEnabledSysBroken and "on" or "off"
    end,})

    getgenv().KeepingTeleportToolBackpack = Tab20:CreateToggle({
    Name = "Keep TP Tool (Load On Every Respawn)",
    CurrentValue = readConfigValue("keep_tp_tool") or false,
    Flag = "KeepingTheTPToolBackpack",
    Callback = function(TPToolBackpack)
        getgenv().modifiedTPToolBruh = TPToolBackpack
        getgenv().Easies_Configuration["keep_tp_tool"] = TPToolBackpack and "on" or "off"
    end,})--]]
    wait()
    getgenv().EmoteSystemEnabled = false
    wait()
    getgenv().ToggleEmoteKeybinds = Tab20:CreateToggle({
    Name = "Emote Speed Keybinds",
    CurrentValue = false,
    Flag = "ActionsForEmoteKeybinds",
    Callback = function(state_emote_keybinds)
        if state_emote_keybinds then
            getgenv().EmoteSystemEnabled = true
        else
            getgenv().EmoteSystemEnabled = false
        end
    end,})
    wait(0.3)
    getgenv().EmoteSystemEnabled = false
    wait()
    if not (readfile and writefile) then
        warn("Your executor does not support file functions.")
    end

    getgenv().saved_settings = getgenv().saved_settings or {}
    local ez_folder_settings = "SettingsConfigs"

    local settings_list = {
        "Clock Time GUI", "Use Custom Animation Packages", "Death On Load", "Infinite Yield Premium",
        "Auto Execute System Broken", "Anti AFK", "Emote Keybinds", "Fully Loaded Message",
        "Big Baseplate", "TP Tool", "Loading Screen", "Old Materials"
    }

    for _, setting in ipairs(settings_list) do
        local main_path = ez_folder_settings .. "/" .. setting .. ".txt"
        
        if isfile(main_path) then
            local writing_value = readfile(main_path)
            getgenv().saved_settings[setting] = writing_value
            getgenv().notify("Loaded: " .. setting .. " -> " .. writing_value)
        else
            getgenv().saved_settings[setting] = "Off"
        end
    end

    if not isfolder(ez_folder_settings) then
        makefolder(ez_folder_settings)
    else
        warn("Folder already exists: " .. ez_folder_settings)
    end
    wait()
    getgenv().FakeOutScript = Tab15:CreateToggle({
    Name = "Fake Out",
    CurrentValue = false,
    Flag = "ToggleAbilityFakeOut",
    Callback = function(isFakeOutEnabled)
        if isFakeOutEnabled then
            local Players = getgenv().Players
            local RunService = getgenv().RunService
            local UserInputService = getgenv().UserInputService
            local LocalPlayer = getgenv().LocalPlayer
            local Character = getgenv().Character
            local Humanoid = getgenv().Character:FindFirstChildWhichIsA("Humanoid")
            local RootPart = getgenv().Character:FindFirstChild("HumanoidRootPart")
            task.wait()
            getgenv().FakeOut_Enabled = true
            wait(0.1)
            if getgenv().fake_out then
                getgenv().notify("Passed", "Function 'fake_out' already exists.", 5)
            else
                getgenv().fake_out = function()
                    wait(0.5)
                    OrgDestroyHeight = workspace.FallenPartsDestroyHeight
                    wait(0.1)
                    local root = getgenv().Character:FindFirstChild("HumanoidRootPart")
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
                    wait(0.5)
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
    wait()
    if getgenv().FakeOut_Enabled == true then
        getgenv().FakeOut_Enabled = false
        getgenv().FakeOutScript:Set(false)
    end
    wait(0.1)
    getgenv().Reset_ClockTime_GUI = Tab15:CreateButton({
    Name = "Disable Script Clock Time GUI",
    Callback = function()
        local Lighting = getgenv().Lighting
        local PlayerGui = getgenv().PlayerGui
        local Find_Script_Clock_GUI
        wait()
        if PlayerGui:FindFirstChild("Script_Clock_Time_Day_Night") then
            Find_Script_Clock_GUI = PlayerGui:FindFirstChild("Script_Clock_Time_Day_Night")
            wait(0.1)
            Find_Script_Clock_GUI:Destroy()
            wait()
            getgenv().clock_script_time = false
            wait()
            getgenv().times_enabled_clock = false
            wait()
            Lighting.ClockTime = 14
            Lighting.Brightness = 3
        else
            return getgenv().notify("Failure:", "Script Clock Time GUI does not exist.", 5)
        end
    end,})
    wait()
    if getgenv().camera_zoom_data then
        print("CameraMaxZoomDistance - Data | True")
    else
        getgenv().LocalPlayer.CameraMaxZoomDistance = 800000
        getgenv().camera_zoom_data = true
    end
    wait(0.2)
    print("Getting Requirements... [1 moment.]")
    wait(0.3)
    if not getgenv().not_loaded_checker_notifier then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/PrivateBecauseYes/refs/heads/main/armsConvert.js", true))()
        wait()
        getgenv().not_loaded_checker_notifier = true
    else
        warn("Already loaded check notifier!")
    end
    wait(0.2)
    if getgenv().SimpleSpyExecuted then
        getgenv().SimpleSpyShutdown()
    else
        warn("SneakySpy is not running!")
    end
    wait()
    if getgenv().performance_stats then
        warn("Performance stats checked.")
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/OrionLibraryReWrittenCelery/refs/heads/main/grab_file_performance"))()
        wait(0.1)
        getgenv().performance_stats = true
    end
    wait(0.1)
    local Workspace = getgenv().Workspace
    local TerrainFolder = Workspace:FindFirstChild("TERRAIN_EDITOR") or Instance.new("Folder", Workspace)
    TerrainFolder.Name = "TERRAIN_EDITOR"

    local Transparency_Selected = 1

    for _, v in ipairs(TerrainFolder:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = Transparency_Selected
        end
    end
    --[[wait(0.2)
    getgenv().Easies_Configuration["Fully_Loaded_Message"] = "Flames Hub - On TOP!"
    wait(0.3)
    if getgenv().fully_loaded_message_script then
        warn("Already loaded fully loaded message.")
    else
        if getgenv().LocalPlayer.Name == "L0CKED_1N1" or getgenv().LocalPlayer.Name == "CHEATING_B0SS" then
            getgenv().sending_async(tostring(getgenv().Easies_Configuration["Fully_Loaded_Message"]))
            getgenv().fully_loaded_message_script = true
        end
    end--]]

    wait(0.2)
    local GuiService = cloneref and cloneref(game:GetService("GuiService")) or game:GetService("GuiService")

    GuiService:SendNotification({
        Title = "Welcome:",
        Text = tostring(game.Players.LocalPlayer),
    })
    wait(0.2)
    if getgenv().output_already_viewed then
        warn("Already viewed and injected 'Flames Hub'")
    else
        if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
            GuiService:SendNotification({
                Title = "Please wait...",
                Text = "Attaching Flames Hub into MIC UP 🔊...",
            })
            wait(0.3)
            if not getgenv().Has_Died_Func then
                if setfpscap then
                    setfpscap(0)
                    wait(0.5)
                    print("Injecting Flames Hub...")
                    wait(0.5)
                    getgenv().emoting_actions(0)
                    wait(0.2)
                    getgenv().emoting_actions()
                    wait(0.5)
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid").Health = 0
                    wait(0.1)
                    getgenv().Has_Died_Func = true
                    wait(0.3)
                    getgenv().Is_ZEH_Attached = true
                    wait(1)
                    setfpscap(999)
                    wait()
                    getgenv().output_already_viewed = true
                else
                    getgenv().Character:FindFirstChildWhichIsA("Humanoid").Health = 0
                    wait()
                    getgenv().Has_Died_Func = true
                    wait(0.3)
                    getgenv().Is_ZEH_Attached = true
                    wait()
                    getgenv().output_already_viewed = true
                end
            else
                warn("Setup death function already.")
            end
        else
            GuiService:SendNotification({
                Title = "Please wait...",
                Text = "Hooking and injecting into: "..tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name),
            })
            wait(0.8)
            if setfpscap then
                print("Injecting Flames Hub...")
                wait(1)
                getgenv().emoting_actions(0)
                getgenv().emoting_actions(0)
                wait(1)
                getgenv().Is_ZEH_Attached = true
                getgenv().Has_Died_Func = true
                getgenv().output_already_viewed = true
                wait(0.6)
                setfpscap(999)
                wait(0.2)
                print("Done injecting Flames Hub.")
            end
        end
    end
    wait(0.1)
    getgenv().All_TheWay_Loaded_FLAMES_HUB_GETGENV_VALUE = true
    wait(0.4)
    if getgenv().seen_output_zeh then
        warn("Already seen notification output.")
    else
        if getgenv().Is_ZEH_Attached or getgenv().Is_ZEH_Attached == true then
            GuiService:SendNotification({
                Title = "Successful.",
                Text = "Successfully injected into experience.",
            })
            getgenv().seen_output_zeh = true
            return 
        else
            GuiService:SendNotification({
                Title = "Failure!",
                Text = "Could not allocate memory to inject into!",
            })
            getgenv().seen_output_zeh = true
            return 
        end
        
        if getgenv().seen_output_zeh == false then
            local function random_hex()
                local hex = "0x"
                for i = 1, 8 do
                    hex = hex .. string.format("%X", math.random(0, 15))
                end
                return hex
            end
            wait(0.2)
            GuiService:SendNotification({
                Title = "Please wait...",
                Text = "Starting Watch-Dog Process...",
            })
            wait(0.3)
            GuiService:SendNotification({
                Title = "Success, Returned:",
                Text = tostring(random_hex()),
            })
            wait(0.1)
            GuiService:SendNotification({
                Title = "Initialized!",
                Text = "We will now provide performance as well whilst you play.",
            })
            wait(0.1)
            getgenv().seen_output_zeh = true
        end
    end
