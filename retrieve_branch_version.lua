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
    
    wait(0.2)
    local vc_service = cloneref and cloneref(game:GetService("VoiceChatService")) or game:GetService("VoiceChatService")
    local enabled_vc = vc_service:IsVoiceEnabledForUserIdAsync(game.Players.LocalPlayer.UserId)
    local Notification
    wait(0.3)
    -- This is a decent Notification Library, as it includes features such as: 'Warnings', 'Errors', and other useful techniques and functions.
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
    -- [] -->> Make sure the script it's self does not get executed more then once, when executed, they will need to click the Re-Execute GUI button to restart the script. <<-- [] --
    if SCRIPT_EXECUTED or getgenv().SCRIPT_EXECUTED and not _G.SCRIPT_EXECUTED == true then  
        return Notification:Notify("Heads Up!", "Zacks Easy Hub is already running!", 5)
    end
    pcall(function() getgenv().SCRIPT_EXECUTED = true end)
    wait(0.3)
    if enabled_vc == true  then
        Notification:Notify("Success!", "Connected with VC successfully!", 3)
    elseif (enabled_vc == false and (not game.PlaceId == 6884319169)) or (not game.PlaceId == 15546218972) then
        Notification:Notify("Success!", "Connected.", 5)
    elseif enabled_vc == false and game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        return Notification:Notify("Sorry!", "Unable to load Zacks Easy Hub (No VC)", 5)
    else
        Notification:Notify("Passed.", "Unknown error occurred.", 5)
    end
    wait()
    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local StarterGui = cloneref and cloneref(game:GetService("StarterGui")) or game:GetService("StarterGui")

    local watchedPlayers = {"L0CKED_1N1", "CHEATING_B0SS"}
    local specialPlayer = "alt_acc9996"
    local support_team = {"Ixgale7530", "starsorbitspace", "goldgoldgoldBlazn", "euigwerergre", "o7rssuk"}

    local function isWatchedPlayer(playerName)
        for _, name in ipairs(watchedPlayers) do
            if playerName == name then
                return true
            end
        end
        return false
    end

    local function isSupportTeam(playerName)
        for _, name in ipairs(support_team) do
            if playerName == name then
                return true
            end
        end
        return false
    end

    local function make_title(player, text, color, transparency)
        local function applyToCharacter(character)
            task.wait(0.5)
            local head = character:FindFirstChild("Head")
            if not head then return end
            if head:FindFirstChild("ZacksEasyBillboard") then return end

            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "ZacksEasyBillboard"
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
            textLabel.Text = text
            textLabel.Parent = background
        end

        if player.Character then
            applyToCharacter(player.Character)
        end
        player.CharacterAdded:Connect(applyToCharacter)
    end

    local function assignTitle(player)
        if isWatchedPlayer(player.Name) then
            make_title(player, "👑 Zacks Easy Hub | KING 👑", Color3.fromRGB(196, 40, 28), 0)
        elseif player.Name == specialPlayer then
            make_title(player, "👧 Zacks Easy Hub | Daughter 👧", Color3.fromRGB(89, 34, 89), 0.3)
        elseif isSupportTeam(player.Name) then
            make_title(player, "⚒️ Zacks Easy Hub | Support ⚒️", Color3.fromRGB(52, 142, 64), 0.1)
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        assignTitle(player)
    end

    Players.PlayerAdded:Connect(function(player)
        task.wait(1)
        assignTitle(player)
    end)
    wait(0.3)
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

    local function executor_details()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
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
            "ContextActionService",
            "GuiService"
        }

        for _, serviceName in pairs(services) do
            getgenv()[serviceName] = cloneref and cloneref(getgenv().Game:GetService(serviceName)) or getgenv().Game:GetService(serviceName)
        end
    end
    wait()
    init_services()
    wait(0.2)
    getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
    getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
    getgenv().LocalPlayer = getgenv().Players.LocalPlayer
    getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack")
    getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui")
    getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
    getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
    getgenv().HumanoidRootPart = getgenv().Character:WaitForChild("HumanoidRootPart") or getgenv().Character:FindFirstChild("HumanoidRootPart")
    getgenv().Humanoid = getgenv().Character:WaitForChild("Humanoid") or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid")
    getgenv().Head = getgenv().Character:WaitForChild("Head") or getgenv().Character:FindFirstChild("Head")
    wait(0.2)
    if not getgenv().maps_loaded or getgenv().maps_loaded == false then
        local function insert_id_asset(asset_ID, Parent)
            local modelId = 'rbxassetid://'..asset_ID
            local mapModel = loadstring("return game:GetObjects('" .. modelId .. "')[1]")()

            if mapModel and mapModel:IsA("Model") then
                mapModel.Parent = Parent
            else
                warn("Failed to load and insert Zacks Easy Hub | Crossroads Map Model.")
            end
        end

        insert_id_asset('85211877443756', game:GetService("Workspace"))
        wait()
        insert_id_asset('126578094071541', game:GetService("Workspace"))
        wait()
        getgenv().maps_loaded = true
    else
        warn("Maps have already been loaded.")
    end
    wait(0.3)
    -- We can utilize this to teleport back to the same CFrame, as per when the script started, since we need to reset the Character when the script is fully loaded to fix other potential issues.
    getgenv().StartedScriptCFrame = getgenv().Character:FindFirstChild("HumanoidRootPart").Position

    -- Initialize Character Updater, fixing any issues with Humanoid, HumanoidRootPart, or even if the Character dies and respawns, essentially making sure the Character is always defined correctly.
    local function Dynamic_Character_Updater(character)
        getgenv().Character = character
        getgenv().HumanoidRootPart = character:WaitForChild("HumanoidRootPart") or character:FindFirstChild("HumanoidRootPart")
        getgenv().Humanoid = character:WaitForChild("Humanoid") or character:FindFirstChildWhichIsA("Humanoid")
    end

    -- Update Character Model(s) components, since we need to make sure the live updates are saved correctly (Especially when the Character components are updated as well).
    Dynamic_Character_Updater(getgenv().Character)
    getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        Dynamic_Character_Updater(newCharacter)
        wait(0.2)
        if getgenv().changed_color_menu_ui and getgenv().changed_imaging_coloring_ui and getgenv().LocalPlayer:WaitForChild("PlayerGui", 1):FindFirstChild("Menu") then
            local Menu_GUI = getgenv().LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("Menu")
            local Home_Button = Menu_GUI:FindFirstChild("HomeButton")
            local Home_Image_Button = Home_Button:FindFirstChild("ImageButton")
            local Background = Menu_GUI:FindFirstChild("Background")
            local Scrolling_Frame = Background:FindFirstChild("ScrollingFrame")
            
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("TextButton") or v:IsA("TextLabel") then
                    v.TextColor3 = Color3.fromRGB(0, 0, 0)
                end
            end
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("ImageButton") or v:IsA("ImageLabel") then
                    v.ImageColor3 = getgenv().changed_imaging_coloring_ui
                end
            end
            wait()
            Home_Image_Button.BackgroundTransparency = 0.3
            Home_Image_Button.BackgroundColor3 = getgenv().changed_color_menu_ui
            Home_Image_Button.ImageColor3 = getgenv().changed_imaging_coloring_ui
            Home_Image_Button.Position = UDim2.new(0, 0, 0.7, 0)
            Background.BackgroundColor3 = getgenv().changed_color_menu_ui
            wait()
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("TextLabel") or v:IsA("TextButton") then
                    v.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                end
            end
            wait()
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("Frame") then
                    if v:IsA("TextLabel") or v:IsA("TextButton") then
                        v.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                    end
                end
            end
            wait(0.1)
            for _, v in ipairs(Scrolling_Frame:GetDescendants()) do
                if v:IsA("TextLabel") then
                    v.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                end
            end
        elseif not getgenv().changed_color_menu_ui and getgenv().LocalPlayer:WaitForChild("PlayerGui", 1):WaitForChild("Menu", 1) then
            local Menu_GUI = getgenv().LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("Menu")
            local Home_Button = Menu_GUI:FindFirstChild("HomeButton")
            local Home_Image_Button = Home_Button:FindFirstChild("ImageButton")
            local Background = Menu_GUI:FindFirstChild("Background")
            local Scrolling_Frame = Background:FindFirstChild("ScrollingFrame")
            
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("TextButton") or v:IsA("TextLabel") then
                    v.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("ImageButton") or v:IsA("ImageLabel") then
                    v.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            wait()
            Home_Image_Button.BackgroundTransparency = 0.3
            Home_Image_Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            Home_Image_Button.ImageColor3 = Color3.fromRGB(255, 255, 255)
            Home_Image_Button.Position = UDim2.new(0, 0, 0.7, 0)
            Background.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            wait()
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("TextLabel") or v:IsA("TextButton") then
                    v.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                end
            end
            wait()
            for _, v in ipairs(Background:GetDescendants()) do
                if v:IsA("Frame") then
                    if v:IsA("TextLabel") or v:IsA("TextButton") then
                        v.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                    end
                end
            end
            wait(0.1)
            for _, v in ipairs(Scrolling_Frame:GetDescendants()) do
                if v:IsA("TextLabel") then
                    v.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                end
            end
        end
    end)

    getgenv().check_marketplace_has_gamepass = function(userid, GamePassID)
        if getgenv().MarketplaceService:UserOwnsGamePassAsync(userid, tonumber(GamePassID)) then
            return true
        else
            getgenv().notify("Failure:", "You do not own this GamePass.", 5)
            return false
        end
    end

    if getmetatable and setmetatable and hookmetamethod and hookfunction then
        print("Advanced exploit detected, using bypass method.")
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/ParadiseRPScript/refs/heads/main/quick_workaround_rspy.lua'))()
        wait(0.1)
        getgenv().advanced_workaround_method = true
    elseif not (getmetatable or setmetatable or hookmetamethod or hookfunction) then
        wait(0.1)
        getgenv().advanced_workaround_method = true
        warn("No advanced level exploit detected, skipping..")
    elseif getgenv().advanced_workaround_method or getgenv().advanced_workaround_method == true then
        wait(0.1)
        warn("Advanced level exploit already reviewed and secured.")
    end

    local vc_inter = getgenv().VoiceChatInternal
    local vc_service = getgenv().VoiceChatService
    
    if getgenv().voiceChat_Check then
        warn("Voice Chat already initialized.")
    else
        getgenv().voiceChat_Check = true 
    
        local vc_internal = getgenv().VoiceChatInternal
        local vc_service = getgenv().VoiceChatService
        local reconnecting = false
        local retry_time = 3
        local maximum_attempts = 500
        local last_prompted_attempt = os.time()
        local maximum_cooldown = 3
        
        local function unsuspend()
            if reconnecting then return warn("Voice Chat Is Still Reconnecting.") end
            if os.time() - last_prompted_attempt < maximum_cooldown then
                return warn("Cooldown active. Please wait before retrying.")
            end
            
            reconnecting = true
            last_prompted_attempt = os.time()
            local attempts = 0
            
            while attempts < maximum_attempts do
                local VoiceChatInternal = cloneref and cloneref(game:GetService("VoiceChatInternal")) or game:GetService("VoiceChatInternal")
                local VoiceChatService = cloneref and cloneref(game:GetService("VoiceChatService")) or game:GetService("VoiceChatService")
                
                print("Attempting to reconnect to voice chat... Attempt:", attempts + 1)
                wait()
                local success = vc_internal:JoinByGroupIdToken("", false, true)
    
                if success then
                    reconnecting = false
                    return
                else
                    warn("Unable to properly Bypass Voice Chat.")
                end
                
                attempts = attempts + 1
                wait(retry_time)
            end
            
            warn("Failed to reconnect after " .. maximum_attempts .. " attempts. Entering cooldown.")
            reconnecting = false
        end
        
        local function onVoiceChatStateChanged(_, newState)
            if newState == Enum.VoiceChatState.Ended and not reconnecting then
                print("Voice chat disconnected, attempting to reconnect...")
                unsuspend()
            end
        end
        
        vc_internal.StateChanged:Connect(onVoiceChatStateChanged)
    end
    
    if vc_inter.StateChanged == Enum.VoiceChatState.Ended then
        if getgenv().notify then
            getgenv().notify("Alert!", "You are suspended, attempting to reconnect you...", 5)
        else
            warn("[Alert-Warning-Box]: You are suspended, attempting to reconnect to Voice Chat...")
        end
        task.wait(.2)
        local success = vc_internal:JoinByGroupIdToken("", false, true)
        if success then
            print("Bypassed Voice Chat.")
        else
            warn("Unable to properly Bypass Voice Chat.")
        end
    end
    wait(0.2)
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
    wait()
    if not getgenv().StarterPlayer.CharacterUseJumpPower or getgenv().StarterPlayer.CharacterUseJumpPower == false then
        getgenv().StarterPlayer.CharacterUseJumpPower = true
        task.wait(.3)
    else
        print("CharacterUseJumpPower: "..tostring(getgenv().StarterPlayer.CharacterUseJumpPower))
    end

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
    wait(0.2)
    if getgenv().emotes_bypassed then
        warn("Emotes are already bypassed.")
    else
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Emote_Bypass_Script.lua'))()
        getgenv().emotes_bypassed = true
    end
    wait(0.1)
    -- Correctly initialize our Folder we put into Workspace, since we can use this for later in the script as well.
    if game:GetService("Workspace"):FindFirstChild("PartStorage") then
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
            local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
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
    wait(0.1)
    -- This is a full setup for Rayfield, which is why my script is able to work on any executor.
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

    function connect_tp_tool()
        local speaker = getgenv().LocalPlayer
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
    if getgenv().AutomaticallyRunSystemBroken == true then
        warn("Already ran System Broken automatically.")
    else
        local fileName = "System_Broken_Setting.txt"

        if isfile(fileName) then
            local fileContent = readfile(fileName)
            fileContent = fileContent:gsub("%s+", "")
            
            if fileContent == "True" then
                getgenv().AutomaticallyRunSystemBroken = true
                loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/refs/heads/main/plus_source.lua"))()
            elseif fileContent == "False" then
                getgenv().AutomaticallyRunSystemBroken = false
                warn("Not enabled in Configuration.")
            else
                warn("Invalid file content: " .. fileContent)
            end
        else
            writefile("System_Broken_Setting.txt", "False")
        end
    end
    wait()
    if getgenv().AutomaticallyRunSystemBroken then
        warn("User has already seen 'System Broken' screen.")
    elseif getgenv().AutomaticallyRunSystemBroken == false then
        warn("User has already selected 'False'.")
    elseif getgenv().AutomaticallyRunSystemBroken == nil then
        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") or LocalPlayer:FindFirstChildWhichIsA("PlayerGui")

        local gui = Instance.new("ScreenGui")
        gui.Parent = PlayerGui
        gui.ResetOnSpawn = false

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 400, 0, 200)
        frame.Position = UDim2.new(0.5, -200, 0.5, -100)
        frame.BackgroundTransparency = 0.3
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        frame.BorderSizePixel = 0
        frame.Parent = gui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0.3, 0)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "Would you like to automatically run System Broken when loading Zacks Easy Hub?"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.Parent = frame

        local yesButton = Instance.new("TextButton")
        yesButton.Size = UDim2.new(0.4, 0, 0.3, 0)
        yesButton.Position = UDim2.new(0.1, 0, 0.6, 0)
        yesButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        yesButton.Text = "Yes"
        yesButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        yesButton.Font = Enum.Font.GothamBold
        yesButton.TextScaled = true
        yesButton.Parent = frame

        local yesCorner = Instance.new("UICorner")
        yesCorner.CornerRadius = UDim.new(0, 8)
        yesCorner.Parent = yesButton

        local noButton = Instance.new("TextButton")
        noButton.Size = UDim2.new(0.4, 0, 0.3, 0)
        noButton.Position = UDim2.new(0.5, 0, 0.6, 0)
        noButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        noButton.Text = "No"
        noButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        noButton.Font = Enum.Font.GothamBold
        noButton.TextScaled = true
        noButton.Parent = frame

        local user_selected_option = nil

        local noCorner = Instance.new("UICorner")
        noCorner.CornerRadius = UDim.new(0, 8)
        noCorner.Parent = noButton

        yesButton.MouseButton1Click:Connect(function()
            getgenv().AutomaticallyRunSystemBroken = true
            writefile("System_Broken_Setting.txt", "True")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/refs/heads/main/plus_source.lua"))()
            gui:Destroy()
            wait(0.2)
            user_selected_option = 1
        end)

        noButton.MouseButton1Click:Connect(function()
            getgenv().AutomaticallyRunSystemBroken = false
            writefile("System_Broken_Setting.txt", "False")
            gui:Destroy()
            wait(0.2)
            user_selected_option = 2
        end)

        repeat wait() until user_selected_option ~= nil
    end
    wait(0.1)
    local fileName = "TP_Tool_Setting.txt"

    if isfile(fileName) then
        local fileContent = readfile(fileName)
        fileContent = fileContent:gsub("%s+", "")
        
        if fileContent == "True" then
            getgenv().Automatically_Run_TP_Tool = true
            local Players = getgenv().Players
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
            wait(0.1)
            getgenv().keeping_tp_tool = true
        elseif fileContent == "False" then
            getgenv().Automatically_Run_TP_Tool = false
            warn("Not enabled in Configuration.")
        else
            warn("Invalid file content: " .. fileContent)
        end
    else
        writefile("TP_Tool_Setting.txt", "False")
    end
    wait()
    if getgenv().Automatically_Run_TP_Tool then
        warn("User has already seen 'System Broken' screen.")
    elseif getgenv().Automatically_Run_TP_Tool == false then
        warn("User has already selected 'False'.")
    elseif getgenv().Automatically_Run_TP_Tool == nil then
        local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") or LocalPlayer:FindFirstChildWhichIsA("PlayerGui")

        local gui = Instance.new("ScreenGui")
        gui.Parent = PlayerGui
        gui.ResetOnSpawn = false

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 400, 0, 200)
        frame.Position = UDim2.new(0.5, -200, 0.5, -100)
        frame.BackgroundTransparency = 0.3
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        frame.BorderSizePixel = 0
        frame.Parent = gui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0.3, 0)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "Would you like to automatically have the TP Tool when excuting Zacks Easy Hub?"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.Parent = frame

        local yesButton = Instance.new("TextButton")
        yesButton.Size = UDim2.new(0.4, 0, 0.3, 0)
        yesButton.Position = UDim2.new(0.1, 0, 0.6, 0)
        yesButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        yesButton.Text = "Yes"
        yesButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        yesButton.Font = Enum.Font.GothamBold
        yesButton.TextScaled = true
        yesButton.Parent = frame

        local yesCorner = Instance.new("UICorner")
        yesCorner.CornerRadius = UDim.new(0, 8)
        yesCorner.Parent = yesButton

        local noButton = Instance.new("TextButton")
        noButton.Size = UDim2.new(0.4, 0, 0.3, 0)
        noButton.Position = UDim2.new(0.5, 0, 0.6, 0)
        noButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        noButton.Text = "No"
        noButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        noButton.Font = Enum.Font.GothamBold
        noButton.TextScaled = true
        noButton.Parent = frame

        local user_selected_option = nil

        local noCorner = Instance.new("UICorner")
        noCorner.CornerRadius = UDim.new(0, 8)
        noCorner.Parent = noButton

        yesButton.MouseButton1Click:Connect(function()
            getgenv().Automatically_Run_TP_Tool = true
            writefile("TP_Tool_Setting.txt", "True")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/refs/heads/main/plus_source.lua"))()
            gui:Destroy()
            wait(0.2)
            user_selected_option = 1
        end)

        noButton.MouseButton1Click:Connect(function()
            getgenv().Automatically_Run_TP_Tool = false
            writefile("TP_Tool_Setting.txt", "False")
            gui:Destroy()
            wait(0.2)
            user_selected_option = 2
        end)

        repeat wait() until user_selected_option ~= nil
    end
    wait(0.1)
    if getgenv().Automatically_Run_TP_Tool == true then
        connect_tp_tool()
    else
        warn("User does not want to run TP Tool.")
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
    if executor_Name == "Solara" or executor_Name == "Sonar" then
        Window = Rayfield:CreateWindow({
            Name = "⭐ Zacks Easy Hub ⭐ | V9.6.6 | "..tostring(executor_Name),
            LoadingTitle = "Enjoy, "..tostring(getgenv().LocalPlayer),
            LoadingSubtitle = "Zacks Easy Hub | ON TOP!",
            ConfigurationSaving = {
                Enabled = false,
                FolderName = "ConfigurationZacksEasyHub",
                FileName = "ZacksEasyHub"
            },
            Discord = {
                Enabled = false,
                Invite = "zackseasyhub",
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
            Name = "⭐ Zacks Easy Hub ⭐ | V9.6.6 | "..tostring(executor_Name),
            LoadingTitle = "Enjoy, "..tostring(game.Players.LocalPlayer),
            LoadingSubtitle = "Zacks Easy Hub | ON TOP!",
            ConfigurationSaving = {
                Enabled = false,
                FolderName = "ConfigurationZacksEasyHub",
                FileName = "ZacksEasyHub"
            },
            Discord = {
                Enabled = true,
                Invite = "zackseasyhub",
                RememberJoins = true
            },
            KeySystem = false,
            KeySettings = {
                Title = "Zacks Easy Key System",
                Subtitle = "Welcome, "..tostring(getgenv().LocalPlayer),
                Note = "This key is easy (No pun intended).",
                FileName = "ZEH_Admin_Key",
                SaveKey = true,
                GrabKeyFromSite = false,
                Key = {"ZACKSEASYHUB_2025"}
            }
        })
    end
    wait()
    --getgenv().notify("Heads Up!", "We have now defaulted to Infinite Premium [mine].", 7)
    wait(0.1)
    -- [] -->> Initialize our Tabs and Sections <<-- [] --
    local Tab1 = Window:CreateTab("🏡 Home 🏡", getgenv().image_use_zacks)
    local Section1 = Tab1:CreateSection("||| 🏡 Home 🏡 Section |||")

    local Tab21
    local Section21
    local Tab10
    local Section10
    local Tab11
    local Section11
    wait(0.2)
    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        Tab11 = Window:CreateTab("🚪 Booths 🚪", getgenv().image_use_zacks)
        Section11 = Tab11:CreateSection("||| 🚪 Booths 🚪 Section |||")
    else
        Tab11 = nil
        Section11 = nil
    end
    wait(0.2)
    local Tab2 = Window:CreateTab("🧍 LocalPlayer 🧍", getgenv().image_use_zacks)
    local Section2 = Tab2:CreateSection("||| 🧍 LocalPlayer 🧍 Section |||")

    local Tab13 = Window:CreateTab("👩‍👩‍👧‍👦 Players 👩‍👩‍👧‍👦", getgenv().image_use_zacks)
    local Section13 = Tab13:CreateSection("||| 👩‍👩‍ Players 👩‍👩‍ Section |||")

    local Tab22 = Window:CreateTab("📏 Baseplate 📏", getgenv().image_use_zacks)
    local Section22 = Tab22:CreateSection("||| 📏‍ Baseplate 📏‍ Section |||")

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        Tab10 = Window:CreateTab("🦿 Teleports 🦿", getgenv().image_use_zacks)
        Section10 = Tab10:CreateSection("||| 🦿 Teleports 🦿 Section |||")
    else
        Tab10 = nil
        Section10 = nil
        warn("Not loading Teleports, not 'MIC UP' or 'MIC UP 17+'.")
    end
    wait(0.2)
    Tab18 = Window:CreateTab("🗺️ Map 🗺️", getgenv().image_use_zacks)
    Section18 = Tab18:CreateSection("||| 🗺️ Map 🗺️ Section |||")

    if getgenv().LocalPlayer:FindFirstChildOfClass("AudioDeviceInput") then
        Tab21 = Window:CreateTab("🎤 VC 🎤", getgenv().image_use_zacks)
        Section21 = Tab21:CreateSection("||| 🎤 VC 🎤 Section |||")
    else
        Tab21 = Window:CreateTab("🎙️ VoiceChat 🎙️", getgenv().image_use_zacks)
        Section21 = Tab21:CreateSection("||| 🎙️ VoiceChat 🎙️ Section |||")
    end
    wait()
    Tab4 = Window:CreateTab("💬 Chat 💬", getgenv().image_use_zacks)
    Section4 = Tab4:CreateSection("||| 💬 Chat 💬 Section |||")

    Tab5 = Window:CreateTab("🤖 Exploits 🤖", getgenv().image_use_zacks)
    Section5 = Tab5:CreateSection("||| 🤖 Exploits 🤖 Section |||")

    Tab16 = Window:CreateTab("🌎 Universal 🌎", getgenv().image_use_zacks)
    Section16 = Tab16:CreateSection("||| 🌎 Global 🌎 Section |||")

    local Tab7 = Window:CreateTab("❓ Whitelist ❓", getgenv().image_use_zacks)
    local Section7 = Tab7:CreateSection("||| ❓ Whitelist ❓ Section |||")

    Tab17 = Window:CreateTab("🕺 Animations 🕺", getgenv().image_use_zacks)
    Section17 = Tab17:CreateSection("||| 🕺 Animations 🕺 Section |||")

    Tab9 = Window:CreateTab("💡 Lighting 💡", getgenv().image_use_zacks)
    Section9 = Tab9:CreateSection("||| 💡 Lighting 💡 Section |||")

    Tab12 = Window:CreateTab("🏃‍♂️ Emotes 🏃‍♂️", getgenv().image_use_zacks)
    Section12 = Tab12:CreateSection("||| 🏃‍♂️ Emotes 🏃‍♂️ Section |||")

    local Tab19 = Window:CreateTab("👁️ Visuals 👁️", getgenv().image_use_zacks)
    local Section19 = Tab19:CreateSection("||| 👁️ Visuals 👁️ Section |||")
    wait()
    Tab14 = Window:CreateTab("💫 CopyAnimation 💫", getgenv().image_use_zacks)
    Section14 = Tab14:CreateSection("||| 💫 Copy Animation 💫 Section |||")

    Tab15 = Window:CreateTab("📝 Settings 📝", getgenv().image_use_zacks)
    Section15 = Tab15:CreateSection("||| 📝 Settings 📝 Section |||")

    Tab20 = Window:CreateTab("📜 Config 📜", getgenv().image_use_zacks)
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
    local GameFolder = getgenv().Workspace:FindFirstChild("Game")
    local GetTeleportPart = GameFolder and GameFolder:FindFirstChild("Teleport")
    local AssetService = getgenv().AssetService
    local Asset_Service_Duplicate = getgenv().AssetService
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
    local TeleportService = game:GetService("TeleportService")
    local VirtualUser = game:GetService("VirtualUser")

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
            for i, v in pairs(GC(game:GetService("Players").LocalPlayer.Idled)) do
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
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
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
        if getgenv().Humanoid.RigType == Enum.HumanoidRigType.R15 then
            return true
        else
            return getgenv().Humanoid.RigType == Enum.HumanoidRigType.R6 or false
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
            for i = 1, 25 do
                ReadyToPlay:FireServer()
            end
        end
    else
        warn("Not on Cellmates (VC)")
    end
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
    local cmdp = game.Players
    local cmdlp = cmdp.LocalPlayer

    function findplr(args)
        local tbl = game:GetService("Players"):GetPlayers()

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
    local safeEmotes = {
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
    wait(0.4)
    getgenv().PlayAnyEmote = Tab2:CreateDropdown({
    Name = "Play Emote",
    Options = safeEmotes,
    CurrentOption = "Shuffle",
    MultipleOptions = false,
    Flag = "choose_an_emote",
    Callback = function(emote_picked)
        local emoteToPlay = type(emote_picked) == "table" and emote_picked[1] or tostring(emote_picked)

        if getgenv().Character:FindFirstChildWhichIsA("Humanoid") then
            getgenv().Humanoid:PlayEmote(emoteToPlay)
        end
    end,})
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
            
            local OldCF = Character:FindFirstChild("HumanoidRootPart").CFrame
            
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
                local OldCF = getgenv().HumanoidRootPart.CFrame
            
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
                        getgenv().HumanoidRootPart.CFrame = stall:GetPivot()
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
            wait(0.1)
            getgenv().StallClaimToggle:Set(false)
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
            if not getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("ANTI_VOID_BASEPLATE") then
                return getgenv().notify("Passed.", "Anti Void Part was already destroyed.", 5)
            else
                getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("ANTI_VOID_BASEPLATE"):Destroy()
            end
        end
    end,})
    wait(0.2)
    if getgenv().Workspace:FindFirstChild("ANTI_VOID_BASEPLATE") then
        getgenv().AntiVoidPlayer:Set(false)
        getgenv().anti_void_player = false
        getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("ANTI_VOID_BASEPLATE"):Destroy()
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
        local Workspace = getgenv().Workspace
        local PartStorage = Workspace:FindFirstChild("PartStorage")
        wait(0.3)
        local Baseplate_AntiVoid = PartStorage:FindFirstChild("ANTI_VOID_BASEPLATE")

        Baseplate_AntiVoid.Transparency = transBasePlate
    end,})

    getgenv().Change_Map_Color = Tab2:CreateColorPicker({
    Name = "Anti Void BasePlate Color",
    Color = Color3.fromRGB(107, 50, 124),
    Flag = "PickThatBasePlateColor",
    Callback = function(AntiVoid_Color)
        local Workspace = getgenv().Workspace
        local PartStorage = Workspace:FindFirstChild("PartStorage")
        wait(0.2)
        local Baseplate_AntiVoid = PartStorage:FindFirstChild("ANTI_VOID_BASEPLATE")
        
        Baseplate_AntiVoid.Color = AntiVoid_Color
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
            local Baseplate_AntiVoid = PartStorage and PartStorage:FindFirstChild("ANTI_VOID_BASEPLATE")
            
            if not Baseplate_AntiVoid then
                getgenv().RainbowAntiVoidBasePlate:Set(false)
                getgenv().parts_rainbow_anti_void = false
                return getgenv().notify("Failure", "Anti Void Part does not exist!")
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
    wait(0.1)
    getgenv().AntiVoidPlayer:Set(false)
    wait(0.1)
    getgenv().Baseplate_Exists = false
    getgenv().AntiVoidTransparency = nil
    getgenv().Change_Map_Color = nil
    
    local Workspace = getgenv().Workspace
    local PartStorage = Workspace:FindFirstChild("PartStorage")
    
    local function create_frame()
        if not getgenv().Rayfield.Main.Elements:FindFirstChild("\240\159\167\141 LocalPlayer \240\159\167\141"):FindFirstChild("Anti Void BasePlate Transparency") then
            warn("Not detected Frame's yet.")
        else
            getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Transparency"].Visible = true
            getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Color"].Visible = true
            getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Rainbow Anti Void Baseplate"].Visible = true
        end
    end
    
    local function remove_frame()
        if not getgenv().Rayfield.Main.Elements:FindFirstChild("\240\159\167\141 LocalPlayer \240\159\167\141"):FindFirstChild("Anti Void BasePlate Transparency") then
            warn("Not detected Frame's yet.")
        else
            getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Transparency"].Visible = false
            getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Color"].Visible = false
            getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Rainbow Anti Void Baseplate"].Visible = false
        end
    end

    if getgenv().Baseplate_Exists == false then
        getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Transparency"].Visible = false
        getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Color"].Visible = false
        getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Rainbow Anti Void Baseplate"].Visible = false
    elseif getgenv().Baseplate_Exists or getgenv().Baseplate_Exists == true then
        getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Transparency"].Visible = true
        getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Anti Void BasePlate Color"].Visible = true
        getgenv().Rayfield.Main.Elements["\240\159\167\141 LocalPlayer \240\159\167\141"]["Rainbow Anti Void Baseplate"].Visible = true
    end
    wait()
    local function check_anti_void_part()
        local baseplate = PartStorage and PartStorage:FindFirstChild("ANTI_VOID_BASEPLATE")
        if baseplate and not getgenv().Baseplate_Exists then
            getgenv().Baseplate_Exists = true
            create_frame()
        elseif not baseplate and getgenv().Baseplate_Exists then
            getgenv().Baseplate_Exists = false
            remove_frame()
        end
    end

    if PartStorage then
        PartStorage.ChildAdded:Connect(function(child)
            if child.Name == "ANTI_VOID_BASEPLATE" then
                check_anti_void_part()
            end
        end)
    
        PartStorage.ChildRemoved:Connect(function(child)
            if child.Name == "ANTI_VOID_BASEPLATE" then
                check_anti_void_part()
            end
        end)
    end
    
    check_anti_void_part()
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
    if getgenv().no_baseplate_collision or getgenv().no_baseplate_collision == true then
        getgenv().BaseplateCollisionToggle:Set(false)
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
    CurrentValue = 0,
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

    for _, v in ipairs(getgenv().Workspace:FindFirstChild("TERRAIN_EDITOR"):GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency == 1 then
            getgenv().TransparencySelectorForBaseplate:Set(0)
        end
    end
    wait()
    getgenv().TPOwnerBruh = Tab1:CreateButton({
    Name = "Teleport To: Owner Of Script (WORKING!)",
    Callback = function()
        local Owner_Found = getgenv().Players:FindFirstChild("L0CKED_1N1") or getgenv().Players:FindFirstChild("CHEATING_B0SS")

        if Owner_Found then
            getgenv().Character:PivotTo(Owner_Found.Character:GetPivot())
        else
            return getgenv().notify("Failure:", "Unable to teleport to owner, player not found.", 5)
        end
    end,})

    getgenv().ViewOwnerBruh = Tab1:CreateToggle({
    Name = "View: Owner Of Script",
    CurrentValue = false,
    Flag = "viewOwner",
    Callback = function(viewingOwner)
        if viewingOwner then
            getgenv().spectateOwner = true
            local OwnerName = "L0CKED_1N1" or "CHEATING_B0SS"
            local Workspace = getgenv().Workspace
            local Camera = Workspace:FindFirstChild("Camera")
            if not getgenv().Players:FindFirstChild(OwnerName) then
                getgenv().ViewOwnerBruh:Set(false)
                wait(0.1)
                getgenv().Camera = getgenv().Character or getgenv().Humanoid
            end
        
            if getgenv().Players:FindFirstChild(OwnerName) then
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
                    "SourceSans",
                }

                local Folder = getgenv().Workspace:FindFirstChild("Booth")

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
            local HumanoidRootPart = getgenv().HumanoidRootPart
            
            local function findPlrBooth(player)
                for _, booth in pairs(Workspace.Booth:GetChildren()) do
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
            local Folder = getgenv().Workspace.Booth
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

        getgenv().BoothNoclipperCollision = Tab11:CreateToggle({
        Name = "Booths Collisions",
        CurrentValue = false,
        Flag = "NoClippingBooths",
        Callback = function(noclip_the_booths)
            if noclip_the_booths then
                for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" then
                        v.CanCollide = true
                    end
                end
            else
                for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" then
                        v.CanCollide = false
                    end
                end
            end
        end,})
        wait()
        for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
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
            for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" and v.Name ~= "Edit" then
                    v.Transparency = transparency_value_booths
                end
            end
            task.wait()
            for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
                if v:IsA("TextLabel") then
                    v.TextTransparency = transparency_value_booths
                end
            end
            task.wait()
            if transparency_value_booths == 1 then
                for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Activate") then
                        v:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt").Enabled = false
                    end
                end
            else
                for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Activate") then
                        v:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt").Enabled = true
                    end
                end
            end
        end,})
        wait()
        for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "Activate" and v.Name ~= "Username" and v.Name ~= "Edit" then
                v.Transparency = transparency_value_booths
            end
        end
        task.wait()
        for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
            if v:IsA("TextLabel") then
                v.TextTransparency = transparency_value_booths
            end
        end
        wait(0.1)
        for _, v in ipairs(getgenv().Workspace.Booth:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Activate") then
                v:FindFirstChild("Activate"):FindFirstChildOfClass("ProximityPrompt").Enabled = true
            end
        end
        wait()
        if getgenv().MarketplaceService:UserOwnsGamePassAsync(getgenv().LocalPlayer.UserId, 951459548) then
            getgenv().CopyAPlayersAv = Tab2:CreateInput({
            Name = "Copy Player Avatar",
            PlaceholderText = "Player",
            RemoveTextAfterFocusLost = true,
            Callback = function(copyUserAvatar)
                local findAPlayerToCopy = findplr(copyUserAvatar)

                if not getgenv().PlayerGui:FindFirstChild("Menu") then
                    return getgenv().notify("Failure", "Menu was not found, probably removed.", 5)
                else
                    getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundColor3 = Color3.new(0.168627, 0.521569, 0.552941)
                    getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundTransparency = 0
                    getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").Text = "Yes"
                end
                wait()
                if not findAPlayerToCopy then
                    local args = {
                        [1] = tostring(copyUserAvatar)
                    }

                    getgenv().ReplicatedStorage:WaitForChild("ModifyUsername"):FireServer(unpack(args))
                    return 
                end
                wait()
                local args = {
                    [1] = tostring(copyUserAvatar)
                }

                getgenv().ReplicatedStorage:WaitForChild("ModifyUsername"):FireServer(unpack(args))
                wait(0.5)
                local args = {
                    [1] = tostring(findAPlayerToCopy)
                }
                
                getgenv().ReplicatedStorage:WaitForChild("ModifyUserEvent"):FireServer(unpack(args))
            end,})

            getgenv().GoBackToNormalAvatar = Tab2:CreateButton({
            Name = "Change Back To Regular Avatar",
            Callback = function()
                if not getgenv().PlayerGui:FindFirstChild("Menu") then
                    return getgenv().notify("Failure", "Menu GUI not found in PlayerGui, probably removed.", 5)
                end
                wait()
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundColor3 = Color3.new(0.184314, 0.184314, 0.184314)
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").BackgroundTransparency = 0.9
                getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").Text = "No"
                wait(0.1)
                if getgenv().PlayerGui:FindFirstChild("Menu"):WaitForChild("Background"):WaitForChild("ModifyUser"):WaitForChild("Toggle"):WaitForChild("Toggle"):WaitForChild("TextButton").Text == "Yes" then
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
                    getgenv().ReplicatedStorage:FindFirstChild("ToggleDisallowEvent"):FireServer()
                    wait(0.3)
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
            warn("Player does not own the GamePass (Admin).")
        end
    else
        warn("Did not load these Booth tabs [2].")
    end

    getgenv().AntiSit_Func = Tab2:CreateToggle({
    Name = "Anti Sit",
    CurrentValue = false,
    Flag = "noSittingDown",
    Callback = function(theSitDownAntiToggle)
        if theSitDownAntiToggle then
            getgenv().disabled_sit_function = true
            getgenv().Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        else
            getgenv().disabled_sit_function = false
            getgenv().Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        end
    end,})
    wait()
    if getgenv().disabled_sit_function or getgenv().disabled_sit_function == true then
        getgenv().AntiSit_Func:Set(false)
    end
    wait(0.1)
    getgenv().SendOwnNotification = Tab1:CreateInput({
    Name = "Send Your Own Notification",
    CurrentValue = "Text Here",
    PlaceholderText = "Message",
    RemoveTextAfterFocusLost = true,
    Flag = "SendNotifMessage",
    Callback = function(Notif_Sender)
        getgenv().GuiService:SendNotification({
            Title = tostring("Zacks Easy Hub:"),
            Text = tostring(Notif_Sender),
        })
    end,})
    wait()
    local RunService = getgenv().RunService
    local Players = getgenv().Players
    local UserInputService = getgenv().UserInputService
    local Player = getgenv().LocalPlayer
    local Character = getgenv().Character
    local RootPart = getgenv().HumanoidRootPart

    local isHoldingJump = false
    local isHoldingKey = false

    if not getgenv().CFrameSpeed then
        getgenv().CFrameSpeed = {
            Enabled = false,
            Speed = 1.5,
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

    getgenv().CFrameSpeedSlider = Tab2:CreateSlider({
    Name = "CFrame WalkSpeed Set Speed",
    Range = {1, 25},
    Increment = 1,
    CurrentValue = 2,
    Flag = "DirectCFrameSpeedEditor",
    Callback = function(newSpeed)
        getgenv().CFrameSpeed.Speed = newSpeed
    end,})

    if getgenv().Humanoid.UseJumpPower then
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
            if getgenv().CFrameSpeed.Enabled and isHoldingKey and RootPart then
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
                    RootPart.CFrame = RootPart.CFrame + (Humanoid.MoveDirection * getgenv().CFrameSpeed.Speed)
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

        getgenv().CFrame_Jump_Connection_Started = RunService.RenderStepped:Connect(function()
            if getgenv().CFrameJump.Enabled and isHoldingJump and RootPart then
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    if Humanoid.UseJumpPower then
                        RootPart.CFrame = RootPart.CFrame + Vector3.new(0, getgenv().CFrameJump.JumpPower, 0)
                    else
                        RootPart.CFrame = RootPart.CFrame + Vector3.new(0, getgenv().CFrameJump.JumpHeight, 0)
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
    Name = "CFrame Speed (With Keybind)",
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

    getgenv().MenuUIColorMICUP = Tab20:CreateColorPicker({
    Name = "MIC UP Menu UI Color Changer",
    Color = Color3.fromRGB(255,255,255),
    Flag = "MICUPsMenuColorChangerColorPicker",
    Callback = function(color_to_change)
        local newest_UI_color_updated = color_to_change
        wait(0.1)
        getgenv().changed_color_menu_ui = newest_UI_color_updated
        wait(0.2)
        local Menu_GUI = getgenv().LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("Menu")
        local Home_Button = Menu_GUI:FindFirstChild("HomeButton")
        local Home_Image_Button = Home_Button:FindFirstChild("ImageButton")
        local Background = Menu_GUI:FindFirstChild("Background")
        local Scrolling_Frame = Background:FindFirstChild("ScrollingFrame")

        Home_Image_Button.BackgroundColor3 = color_to_change
        Background.BackgroundColor3 = color_to_change
    end,})

    getgenv().MenuImageColorMICUP = Tab20:CreateColorPicker({
    Name = "MIC UP Menu Image Color Changer",
    Color = Color3.fromRGB(255,255,255),
    Flag = "TheImageColorsForMenuMICUP",
    Callback = function(new_image_coloring)
        local newest_image_color = new_image_coloring
        wait(0.1)
        getgenv().changed_imaging_coloring_ui = newest_image_color
        wait(0.2)
        local Menu_GUI = getgenv().LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("Menu")
        local Home_Button = Menu_GUI:FindFirstChild("HomeButton")
        local Home_Image_Button = Home_Button:FindFirstChild("ImageButton")
        local Background = Menu_GUI:FindFirstChild("Background")
        local Scrolling_Frame = Background:FindFirstChild("ScrollingFrame")
        
        for _, v in ipairs(Background:GetDescendants()) do
            if v:IsA("ImageButton") or v:IsA("ImageLabel") then
                v.ImageColor3 = new_image_coloring
            end
        end
        wait()
        Home_Image_Button.BackgroundTransparency = 0.3
        Home_Image_Button.BackgroundColor3 = getgenv().changed_color_menu_ui
        Home_Image_Button.ImageColor3 = Color3.fromRGB(255, 255, 255)
        Home_Image_Button.Position = UDim2.new(0, 0, 0.7, 0)
        Background.BackgroundColor3 = getgenv().changed_color_menu_ui
    end,})

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

            if getgenv().HumanoidRootPart then
                getgenv().HumanoidRootPart.Anchored = false
            end

            if getgenv().Humanoid:GetStateEnabled(Enum.HumanoidStateType.Seated, false) then
                getgenv().Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
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
        local Players = getgenv().Players
        local RunService = getgenv().RunService
        local LocalPlayer = getgenv().LocalPlayer
        local Character = getgenv().Character
        local humanoid = getgenv().Humanoid
        local HumanoidRootPart = getgenv().HumanoidRootPart
        
        local VOID_THRESHOLD = -50
        local UNVOID_THRESHOLD = 0
        
        local function noSitFunc()
            getgenv().Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        end
        
        local function antiVoidLoop()
            OrgDestroyHeight = getgenv().Workspace.FallenPartsDestroyHeight

            getgenv().antiVoidLoop = getgenv().RunService.Stepped:Connect(function()
                local root = getgenv().HumanoidRootPart
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

            if getgenv().antiVoidLoop then
                getgenv().antiVoidLoop:Disconnect()
                getgenv().antiVoidLoop = nil
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
        if spinSpeed and spinSpeed <= 200 then
            local Spin = Instance.new("BodyAngularVelocity")
            Spin.Name = "Spinning"
            Spin.Parent = HumanoidRootPart
            Spin.MaxTorque = Vector3.new(0, math.huge, 0)
            Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
        elseif spinSpeed and spinSpeed >= 200 then
            getgenv().notify("Limit Reached!", "We lowered speed, because you would be flung.", 5)
            wait(0.2)
            if not getgenv().HumanoidRootPart:FindFirstChild("Spinning") then
                local Spin = Instance.new("BodyAngularVelocity")
                Spin.Name = "Spinning"
                Spin.Parent = HumanoidRootPart
                Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                Spin.AngularVelocity = Vector3.new(0,200,0)
            else
                HumanoidRootPart:FindFirstChild("Spinning").AngularVelocity = Vector3.new(0,200,0)
            end
        elseif spinSpeed <= 200 and getgenv().HumanoidRootPart:FindFirstChild("Spinning") then
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

    if getgenv().MarketplaceService:UserOwnsGamePassAsync(getgenv().LocalPlayer.UserId, 951459548) then
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

                local humanoid = getgenv().Humanoid
                if humanoid then
                    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                        track:Stop()
                    end
                end

                task.wait(0.2)

                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
                Animate.walk:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Walk
                Animate.run:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Run
                Animate.jump:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Jump
                Animate.climb:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Climb
                Animate.fall:FindFirstChildOfClass("Animation").AnimationId = "http://www.roblox.com/asset/?id=" .. Zombie_Fall
            end
            wait()
            disguise_anims(getgenv().Character)
        end,})
    else
        warn("User does not own GamePass, skipping.")
    end
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
        local speakerRoot = speaker.Character and speaker.Character:FindFirstChild("HumanoidRootPart")
        
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
            for _, animTrack in pairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
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
            local ToWalkWhileEmoting = type(selectedEmote) == "table" and selectedEmote[1] or tostring(selectedEmote)

            if getgenv().Character:FindFirstChild("Animate") then
                if getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == true then
                    getgenv().Humanoid.WalkSpeed = 0
                    wait(1)
                    reset_walk_while_emoting()
                    wait(1.2)
                    getgenv().Humanoid:PlayEmote(ToWalkWhileEmoting)
                    wait(2)
                    getgenv().Humanoid.WalkSpeed = 16
                else
                    warn("Proceed with walk while emoting.")
                end
            else
                reset_walk_while_emoting()
                return getgenv().notify("Failure!", "'Animate' LocalScript not found!", 5)
            end
            wait()
            if getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == true then
                getgenv().Humanoid.WalkSpeed = 0
                wait(0.8)
                getgenv().Humanoid:PlayEmote(ToWalkWhileEmoting)
            elseif not getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == false then
                getgenv().Humanoid.WalkSpeed = 0
                wait(1)
                getgenv().Humanoid:PlayEmote(ToWalkWhileEmoting)
                wait(0.1)
                getgenv().HumanoidRootPart.Anchored = true
                wait()
                getgenv().Character:FindFirstChild("Animate").Disabled = true
                wait(0.3)
                getgenv().HumanoidRootPart.Anchored = false
            end
        end,})

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
            getgenv().Humanoid.WalkSpeed = 0
            wait(0.2)
            getgenv().Humanoid:ChangeState(3)
            wait(0.9)
            getgenv().Humanoid.WalkSpeed = 16
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
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                getgenv().Humanoid:ChangeState(3)
            end
            wait()
            getgenv().HumanoidRootPart.Anchored = true
            wait(0.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = MichaelJackson_Speed
            wait(0.1)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):PlayEmoteAndGetAnimTrackById(4391208058)
            wait(0.2)
            getgenv().Character:FindFirstChild("Animate").Disabled = true
            wait(0.1)
            getgenv().HumanoidRootPart.Anchored = false
        else
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                getgenv().Humanoid:ChangeState(3)
            end
            wait()
            getgenv().HumanoidRootPart.Anchored = true
            wait()
            getgenv().Character:FindFirstChild("Animate").Disabled = false
            task.wait(.2)
            getgenv().Character:FindFirstChildWhichIsA("Humanoid"):ChangeState(3)
            wait(0.2)
            getgenv().Humanoid.WalkSpeed = 16
            wait(0.2)
            getgenv().HumanoidRootPart.Anchored = false
        end
    end,})

    getgenv().Owner_Animations = Tab2:CreateToggle({
    Name = "Zacks Owner Animations (Applies every respawn)",
    CurrentValue = false,
    Flag = "LoadZacksOwnerAnims",
    Callback = function(apply_to_respawn_anims)
        if apply_to_respawn_anims then
            getgenv().ownerAnimsEnabled = true
            local LocalPlayer = getgenv().LocalPlayer
            
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

                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
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

                local humanoid = getgenv().Humanoid
                if humanoid then
                    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                        track:Stop()
                    end
                end

                task.wait(0.2)

                Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
                Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
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
        else
            getgenv().ownerAnimsEnabled = false
            getgenv().ownerAnimsEnabled = false
            wait()
            local humanoid = getgenv().Humanoid
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
        end
    end,})

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
            local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
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
            local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
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
            local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
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
            local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
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
            local HumanoidRootPart = getgenv().HumanoidRootPart
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
                local Remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
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
        
                    local player = game.Players.LocalPlayer
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

    getgenv().WhitelistOtherScriptUser = Tab7:CreateInput({
    Name = "Whitelist Script/ZEH User",
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
    wait()
    if getgenv().List_GUI_Loaded then
        warn("Listing's GUI already loaded.")
    else
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/PublicScriptsOnRobloxExploiting/refs/heads/main/ClimbRaceSim.lua'))()
        wait()
        getgenv().List_GUI_Loaded = true
    end
    wait()
    local validCommands = {"?bring", "?kill", "?jump", "?gravity", "?teleport", "?stuck", "?unstuck", "?freeze", "?unfreeze", "?noclip", "?clip", "?speed", "?sit", "?jp", "?cmds"}
    
    getgenv().AdminCommands = {
        ["bring"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end,
        
        ["kill"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0
            end
        end,
        
        ["jump"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end,
        
        ["gravity"] = function(_, value)
            game.Workspace.Gravity = tonumber(value) or 196.2
        end,
        
        ["teleport"] = function(player, targetName)
            local target = game.Players:FindFirstChild(targetName)
            if player and target and player.Character and target.Character then
                player.Character:MoveTo(target.Character.HumanoidRootPart.Position)
            end
        end,
        
        ["stuck"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = true
            end
        end,

        ["unstuck"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
            end
        end,
        
        ["freeze"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character:FindFirstChild("HumanoidRootPart").Anchored = true
            end
        end,

        ["unfreeze"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character:FindFirstChild("HumanoidRootPart").Anchored = false
            end
        end,
        
        ["noclip"] = function(player, state)
            if player and player.Character then
                for _, part in ipairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end,

        ["clip"] = function(player, state)
            if player and player.Character then
                for _, part in ipairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end,

        ["mute"] = function(player)
            if player and player:FindFirstChildOfClass("AudioDeviceInput") then
                player:FindFirstChildOfClass("AudioDeviceInput").Muted = true
            end
        end,

        ["unmute"] = function(player)
            if player and player:FindFirstChildOfClass("AudioDeviceInput") then
                player:FindFirstChildOfClass("AudioDeviceInput").Muted = false
            end
        end,
        
        ["speed"] = function(player, speed)
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = tonumber(speed) or 16
            end
        end,
        
        ["sit"] = function(player)
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Sit = true
            end
        end,
        
        ["jp"] = function(player, jumpPower)
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = tonumber(jumpPower) or 50
            end
        end,
        
        ["cmds"] = function()
            getgenv().PlayerGui:FindFirstChild("CommandListGUI").Enabled = true
        end
    }

    getgenv().Whitelists = {
        ["L0CKED_1N1"] = true,
        ["CHEATING_B0SS"] = true,
        ["Chick7nn"] = true,
        ["Nearoux"] = true,
        ["Ferdinand273738"] = true,
        ["lerks_alt"] = true,
        ["2x2x2x2x2x2841"] = true,
    }

    getgenv().TextChatService.MessageReceived:Connect(function(message)
        if not message.TextSource then
            warn("No message.TextSource located. [This check is here to prevent an error].")
        else
            local sender = message.TextSource.Name
            local text = message.Text

            if text == "?cmds" and getgenv().Whitelists[sender] then
                getgenv().AdminCommands["cmds"]()
            end
        end
    end)

    if getgenv().Whitelists[getgenv().LocalPlayer.Name] then
        warn("This user is whitelisted, proceeding...")
    else
        getgenv().TextChatService.MessageReceived:Connect(function(message)
            local sender = message.TextSource.Name
            local text = message.Text

            local senderPlayer = game.Players:FindFirstChild(sender)
            if not senderPlayer then return end

            if text:sub(1, 1) == "?" then
                local args = text:split(" ")
                local command = args[1]:sub(2)
                local targetName = args[2] or ""
                local extraArg = args[3]

                local targetPlayer = game.Players:FindFirstChild(targetName)

                if getgenv().AdminCommands[command] then
                    if targetPlayer then
                        getgenv().AdminCommands[command](targetPlayer, extraArg)
                    else
                        warn("Player not found: " .. targetName)
                    end
                else
                    warn("Unknown command: " .. command)
                end
            end
        end)
    end

    if game.PlaceId == 97399198116506 then 
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
            local player = game.Players.LocalPlayer
    
            local function disableConnectionsForPropertiesAndEvents(character)
                local humanoid = character:WaitForChild("Humanoid")
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
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
                        print("Disabled connections for:", object.Name, property)
                    else
                        print("Could not find signal for:", object.Name, property)
                    end
                end
    
                local stateChangedConnections = getconnections(humanoid.StateChanged)
                for _, connection in ipairs(stateChangedConnections) do
                    connection:Disable()
                end
                print("Disabled StateChanged connections for Humanoid.")
            end
    
            local function disableDescendantAddedChecks(character)
                local connections = getconnections(character.DescendantAdded)
                for _, connection in ipairs(connections) do
                    connection:Disable()
                end
                print("Disabled DescendantAdded checks for:", character.Name)
            end
    
            local function disableChildAddedChecks(character)
                local connections = getconnections(character.ChildAdded)
                for _, connection in ipairs(connections) do
                    connection:Disable()
                end
                print("Disabled ChildAdded checks for:", character.Name)
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
                    getgenv().Oldest_AntiBoothStealer_CF = Character:WaitForChild("HumanoidRootPart").CFrame
                end
            
                local function getStall()
                    for _, v in pairs(getgenv().Workspace.Booth:GetChildren()) do
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
                        else
                            warn("Oldest_AntiBoothStealer_CF is nil, unable to teleport back!")
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
            
                getgenv().Booth = nil
                return 
            end            
        end,})

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
            getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = OldCF
        end,})
    elseif executor_Name == "MacSploit" and game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
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
            getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame = OldCF
        end,})
    else
        warn("Did not load these Booth tabs [6].")
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

    if getgenv().copyAllWhitelistedAnims or getgenv().copyAllWhitelistedAnims == true then
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
            if game:GetService("Workspace"):FindFirstChild("SoccerField") then
                local BasePlate = game:GetService("Workspace"):FindFirstChild("SoccerField"):FindFirstChild("Baseplate")
                local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                BasePlate.Transparency = BasePlateMICUPTransparency
                Texture_Bruh.Transparency = BasePlateMICUPTransparency
            elseif game:GetService("Workspace"):FindFirstChild("BasePlate") then
                local BasePlate
                wait(0.2)
                if getgenv().Workspace:FindFirstChild("Baseplate") then
                    BasePlate = getgenv().Workspace:FindFirstChild("BasePlate") or getgenv().Workspace:FindFirstChild("Baseplate")

                    BasePlate.Transparency = BasePlateMICUPTransparency
                elseif not getgenv().Workspace:FindFirstChild("Baseplate") then
                    BasePlate = getgenv().Workspace:FindFirstChild("BasePlate")

                    BasePlate.Transparency = BasePlateMICUPTransparency
                end
            elseif game:GetService("Workspace"):FindFirstChild("Game") then
                if getgenv().Workspace:FindFirstChild("Baseplate") then
                    local BasePlate_0 = getgenv().Workspace:FindFirstChild("Baseplate")
                    local BasePlate_1 = getgenv().Workspace:FindFirstChild("Game"):FindFirstChild("Baseplate")

                    BasePlate_0.Transparency = BasePlateMICUPTransparency
                    BasePlate_1.Transparency = BasePlateMICUPTransparency
                    Baseplate_1:FindFirstChild("Texture").Transparency = BasePlateMICUPTransparency
                elseif not getgenv().Workspace:FindFirstChild("Baseplate") then
                    BasePlate = game:GetService("Workspace"):FindFirstChild("Game"):FindFirstChild("Baseplate")
                    local Texture_Bruh = BasePlate:FindFirstChildOfClass("Texture")

                    BasePlate.Transparency = BasePlateMICUPTransparency
                    Texture_Bruh.Transparency = BasePlateMICUPTransparency
                end
            elseif getgenv().Workspace:FindFirstChild("Baseplate") then
                local Base_plate = getgenv().Workspace:FindFirstChild("Baseplate")

                Base_plate.Transparency = BasePlateMICUPTransparency
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

    getgenv().RestoreToOriginalColors = Tab18:CreateButton({
    Name = "Reset/Restore Map Color",
    Callback = function()
        for part, originalColor in pairs(getgenv().OriginalColors) do
            if part and part.Parent then
                part.Color = originalColor
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
                if not getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == false then
                    getgenv().Character:FindFirstChild("Animate").Disabled = true
                else
                    warn("Animate LocalScript is already disabled.")
                end
                wait(0.2)
                getgenv().HumanoidRootPart.Anchored = false
            else
                getgenv().HumanoidRootPart.Anchored = false
                wait(0.1)
                if not getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == false then
                    getgenv().Character:FindFirstChild("Animate").Disabled = true
                else
                    warn("Animate LocalScript is already disabled.")
                end
            end
        else
            return getgenv().notify("Error:", tostring(err), 5)
        end
    end,})

    getgenv().StopEmoteLooping = Tab12:CreateButton({
    Name = "Stop Loop Emoting",
    Callback = function()
        if getgenv().Character:FindFirstChild("Animate").Disabled or getgenv().Character:FindFirstChild("Animate").Disabled == true then
            getgenv().Character:FindFirstChild("Animate").Disabled = false
        else
            warn("Animate LocalScript is not disabled.")
        end
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
        if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
            getgenv().Humanoid:ChangeState(3)
            getgenv().Humanoid:ChangeState(3)
        end
        wait(0.3)
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

    getgenv().GraphicsEnhancer = Tab16:CreateToggle({
    Name = "Graphics Enhancer",
    CurrentValue = false,
    Flag = "GraphicsEnhancerToggling",
    Callback = function(new_graphics_toggle)
        if new_graphics_toggle then
            getgenv().graphics_upper = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/PublicScriptsOnRobloxExploiting/refs/heads/main/GraphicsEnhancer.lua"))()
        else
            getgenv().graphics_upper = false
            wait()
            getgenv().graphics_upper = false
            wait(0.1)
            resetLightingSettings()
        end
    end,})
    wait(0.1)
    if getgenv().graphics_upper or getgenv().graphics_upper == true then
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
        local hum = getgenv().Humanoid
        if hum then
            hum.PlatformStand = false
        end
        running = false
    end

    local function fuck()
        if running then return end
        running = true

        local plr = getgenv().LocalPlayer
        local hrp = getgenv().HumanoidRootPart
        local hum = getgenv().Humanoid
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
            if heartConn then
                heartConn:Disconnect()
                heartConn = nil
            end
            stop()
            wait(1)
            getgenv().loaded_face_bang = true
            wait(0.1)
            if heartConn then
                heartConn:Disconnect()
            end
        end

        if enabled then
            getgenv().loaded_face_bang = true
            wait(0.1)
            if heartConn then
                heartConn:Disconnect()
            end

            heartConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
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
            if heartConn then
                heartConn:Disconnect()
                heartConn = nil
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
    Range = {1, 60},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "faceBangingSpeedSet",
    Callback = function(set_face_fuck_speed)
        speed = set_face_fuck_speed / 2
    end,})

    getgenv().Distance_Face_Bang = Tab16:CreateSlider({
    Name = "Face F**k Distance",
    Range = {1, 30},
    Increment = 1,
    Suffix = "",
    CurrentValue = 1,
    Flag = "faceBangingDistance",
    Callback = function(max_distance)
        distSlider = max_distance
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
            elseif reset_bool == false then
                getgenv().Character:FindFirstChild("HumanoidRootPart").CanCollide = false
                getgenv().Character:FindFirstChild("LowerTorso").CanCollide = false
                getgenv().Character:FindFirstChild("UpperTorso").CanCollide = false
            else
                return warn("Invalid input BoolValue.")
            end
        end

        if noclip_toggle then
            getgenv().ez_noclip_use = true
            while getgenv().ez_noclip_use == true do
            wait()
                reset_collide(false)
            end
        else
            getgenv().ez_noclip_use = false
            getgenv().ez_noclip_use = false
            wait(0.5)
            getgenv().Humanoid.WalkSpeed = 0
            getgenv().HumanoidRootPart.Anchored = false
            wait(0.7)
            reset_collide(true)
            wait(0.3)
            getgenv().Humanoid:ChangeState(3)
            wait(1)
            getgenv().Humanoid.WalkSpeed = 16
        end
    end,})
    wait()
    if game.PlaceId == 135275461271957 or game.PlaceId == 78589782053833 then
        getgenv().PlayerGui:FindFirstChild("Notification"):Destroy()
    end

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
            getgenv().non_fly_use = true
            while getgenv().non_fly_use == true do
            wait()
                reset_collide(false)
            end
        else
            getgenv().non_fly_use = false
            getgenv().non_fly_use = false
            getgenv().non_fly_use = false
            reset_collide(true)
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
                            firetouchinterest(v, getgenv().HumanoidRootPart, 1)
                            wait()
                            firetouchinterest(v, getgenv().HumanoidRootPart, 0)
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
            
            if lastFrame and lastFrame[1] then
                humanoidRootPart.CFrame = lastFrame[1]
            end
            wait(.1)
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
        if getgenv().checked_function_elevator then
            warn("We checked elevator stuff")
        else
            local Elevator = getgenv().Workspace:FindFirstChild("Elevator")
            local Obby_Folder = getgenv().Workspace:FindFirstChild("Obby")
            local Low_Model = Obby_Folder:FindFirstChild("Low")
            local function resize_part(part, size, position)
                local position = position
                local size = size
                local part = getgenv().Workspace:FindFirstChild(part)

                part.CFrame = position
                part.Size = size
            end
            resize_part("Elevator", Vector3.new(45, 284, 34), CFrame.new(58.5813599, 139.712708, 225, -1, 0, 0, 0, 1, 0, 0, 0, -1))
            wait(0.3)
            local obby_clone = Low_Model:Clone()
            obby_clone.Parent = getgenv().Workspace:FindFirstChild("PartStorage")
            Elevator.Parent = getgenv().Workspace:FindFirstChild("PartStorage")
            wait(0.3)
            if getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("Elevator") then
                Elevator = getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("Elevator")
            else
                warn("Didn't find 'Elevator' in PartStorage [game.Workspace/workspace], Falling back.")
                task.wait()
                Elevator = getgenv().Workspace:FindFirstChild("Elevator")
            end
            wait(0.2)
            getgenv().checked_function_elevator = true
        end
        wait(0.3)
        local elevator
        wait(0.2)
        if getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("Elevator") then
            elevator = getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("Elevator")
        else
            elevator = getgenv().Workspace:FindFirstChild("Elevator")
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

        getgenv().ElevatorColorChanger = Tab1:CreateColorPicker({
        Name = "Elevator Color",
        Color = Color3.fromRGB(159, 161, 172),
        Flag = "ColorPicker1",
        Callback = function(theElevatorColor)
            if elevator.Color then
                elevator.Color = theElevatorColor
            else
                local ConvertBrickColor = theElevatorColor
                wait()
                if ConvertBrickColor then
                    local BrickColor_Returned = BrickColor.new(ConvertBrickColor)
                elseif not ConvertBrickColor then
                    getgenv().ElevatorColorChanger:Set(255, 255, 255)
                else
                    return getgenv().notify("Failed!", "BrickColor or Color3 expected, got nothing.", 6)
                end
                wait(0.1)
                elevator.BrickColor = BrickColor_Returned
            end
        end,})

        getgenv().collisionForElevator = Tab1:CreateToggle({
        Name = "Elevator Collision (Tower - Float Up Part)",
        CurrentValue = false,
        Flag = "toggleElevatorCollide",
        Callback = function(elevatorCollide)
            if elevatorCollide then
                local Remember_CFrame = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame
                getgenv().old_remember_the_cframe = Remember_CFrame
                wait(0.2)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(61.8545914, 5.14999866, 195.52623)
                wait(0.3)
                if getgenv().HumanoidRootPart.Anchored == false then
                    getgenv().HumanoidRootPart.Anchored = true
                end
                wait(0.1)
                elevator.CanTouch = true
                elevator.CanQuery = true
                wait(0.2)
                getgenv().HumanoidRootPart.Anchored = false
                wait(0.2)
                getgenv().HumanoidRootPart.CFrame = getgenv().old_remember_the_cframe
                wait(0.2)
                if getgenv().old_remember_the_cframe then
                    getgenv().old_remember_the_cframe = nil
                end
            else
                if getgenv().HumanoidRootPart.Anchored or getgenv().HumanoidRootPart.Anchored == true then
                    getgenv().HumanoidRootPart.Anchored = false
                end
                wait(0.2)
                elevator.CanCollide = false
                elevator.CanQuery = false
                elevator.CanTouch = false
                wait(0.1)
                getgenv().HumanoidRootPart.CFrame = CFrame.new(61.8545914, 5.14999866, 195.52623)
            end
        end,})
    else
        getgenv().checked_function_elevator = true
        wait(0.1)
        warn("Skipping Elevator Section.")
    end

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
                    if getgenv().check_marketplace_has_gamepass(getgenv().LocalPlayer.UserId, 951459548) then
                        local args = {
                            [1] = "Hoverboard"
                        }
                        
                        getgenv().ReplicatedStorage:WaitForChild("ToolEvent"):FireServer(unpack(args))
                    else
                        getgenv().notify("Failure", "Cannot pickup Hoverboard, GamePass not owned.", 6)
                    end
                    wait(0.3)
                    if getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Hoverboard") then
                        getgenv().LocalPlayer:FindFirstChildOfClass("Backpack"):FindFirstChild("Hoverboard").Parent = getgenv().Character
                    end
                    wait(0.5)
                    local player = getgenv().LocalPlayer
                    local character = getgenv().Character
                    local humanoidRootPart = getgenv().HumanoidRootPart
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
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoidRootPart = getgenv().HumanoidRootPart
                    local Humanoid = getgenv().Humanoid

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
            local humanoidRootPart = getgenv().HumanoidRootPart
            local Humanoid = getgenv().Humanoid

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
                getgenv().Humanoid.PlatformStand = false
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
                wait(0.1)
                getgenv().Camera.CameraSubject = getgenv().Character
            end
        end,})

        if getgenv().viewing_booth or getgenv().viewing_booth == true then
            getgenv().viewing_booth = false
            getgenv().viewBooth:Set(false)
            getgenv().Camera.CameraSubject = getgenv().Character
        end

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
            local Avatar_UI = getgenv().Workspace:FindFirstChild("PartStorage"):FindFirstChild("AvatarUI")
            local Like_Button = Avatar_UI:FindFirstChild("LikeButton") or Avatar_UI:WaitForChild("LikeButton")
            local Click_Detector_Input = Like_Button:FindFirstChild("ClickDetector")

            if likeLol then
                if fireclickdetector then
                    getgenv().alrLike = true
                    while getgenv().alrLike == true do
                    wait(0.6)
                        fireclickdetector(Click_Detector_Input, 999)
                    end
                else
                    getgenv().alrLike = false
                    return getgenv().notify("Error:", "Your executor does not support 'fireclickdetector'", 7)
                end
            else
                getgenv().alrLike = false
                wait(0.3)
                getgenv().alrLike = false
                wait(0.4)
                getgenv().alrLike = false
            end
        end,})

        if getgenv().alrLike or getgenv().alrLike == true then
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
        if getgenv().Disliking or getgenv().Disliking == true then
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

            if getgenv().plr_music_menu or getgenv().plr_music_menu == true then
                getgenv().plr_music_menu = false
                getgenv().Music_Player:Set(false)
            end
        else
            warn("'firesignal' unsupported, not loading In-Game music functions.")
        end
    else
        warn("Not MIC UP or MIC UP 17+, not loading In-Game music functions.")
    end

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        if fireclickdetector then
            local function findFriendPlayer()
                local Local_Player = getgenv().LocalPlayer
                for _, player in ipairs(getgenv().Players:GetPlayers()) do
                    if player ~= Local_Player and Local_Player:IsFriendsWith(player.UserId) then
                        return player
                    end
                end
                return nil
            end
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
                    
                    local friend_find = findFriendPlayer()
                    
                    if not friend_find then
                        getgenv().WhitelistFriendPlr:Set(false)
                        getgenv().Like_Friends = false
                        return getgenv().notify("Error:", "You have '0' friends in this server!", 6)
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
                                getgenv().WhitelistFriendPlr:Set(false)
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

            if getgenv().Like_Friends or getgenv().Like_Friends == true then
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

        getgenv().defaulting_keybind_for_muting_microphone = "LeftControl"
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

    if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
        getgenv().DelInventory = Tab5:CreateButton({
        Name = "Delete Inventory",
        Callback = function()
            local Replicated_Storage = getgenv().ReplicatedStorage
            local Delete_Inv_RemoteEvent = Replicated_Storage:WaitForChild("DeleteInventory") or Replicated_Storage:FindFirstChild("DeleteInventory")
            
            Delete_Inv_RemoteEvent:FireServer()
        end,})

        if not getgenv().check_marketplace_has_gamepass(getgenv().LocalPlayer.UserId, 951459548) then
            warn("LocalPlayer does not own this GamePass.")
            getgenv().notify("Skipped:", "You do not own the 'Admin' GamePass.", 5)
        else
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
        end
    else
        warn("Not on MIC UP, not loading these features.")
    end

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
        getgenv().sending_async(".")
        task.wait(0.2)
        getgenv().sending_async(".")
        task.wait(0.2)
        getgenv().sending_async(".")
        task.wait(0.2)
        getgenv().sending_async(".")
        task.wait(0.2)
        getgenv().sending_async("/cls")
    end,})

    getgenv().color_for_esp_value = Color3.fromRGB(255, 255, 255)
    getgenv().RAINBOW_MODE = false
    wait()
    getgenv().EspBox = Tab19:CreateToggle({
    Name = "Box",
    CurrentValue = false,
    Flag = "TogglingBoxESP",
    Callback = function(box_Esp)
        if box_Esp then
            getgenv().ESPEnabled = true

            local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
            local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
            local LocalPlayer = Players.LocalPlayer
            getgenv().espObjects = {}
            
            local function hsvToRgb(h, s, v)
                local i = math.floor(h * 6)
                local f = h * 6 - i
                local p = v * (1 - s)
                local q = v * (1 - f * s)
                local t = v * (1 - (1 - f) * s)
            
                i = i % 6
                if i == 0 then return Color3.new(v, t, p) 
                elseif i == 1 then return Color3.new(q, v, p) 
                elseif i == 2 then return Color3.new(p, v, t) 
                elseif i == 3 then return Color3.new(p, q, v) 
                elseif i == 4 then return Color3.new(t, p, v) 
                elseif i == 5 then return Color3.new(v, p, q) end
            end
            
            local function createESP(player)
                if player ~= LocalPlayer then
                    local character = player.Character
                    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESP"
                    billboard.Adornee = character:FindFirstChild("HumanoidRootPart")
                    billboard.Size = UDim2.new(4, 0, 5, 0)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    billboard.AlwaysOnTop = true
            
                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = getgenv().color_for_esp_value
                    frame.BackgroundTransparency = 0.5
                    frame.BorderSizePixel = 0
                    frame.Parent = billboard
            
                    billboard.Parent = character
                    getgenv().espObjects[player] = frame
                end
            end
            
            local function removeESP(player)
                if getgenv().espObjects[player] then
                    getgenv().espObjects[player]:Destroy()
                    getgenv().espObjects[player] = nil
                end
            end
            
            local function onCharacterAdded(player)
                task.wait(1)
                if getgenv().ESPEnabled then
                    createESP(player)
                end
            end
            
            local function onPlayerAdded(player)
                player.CharacterAdded:Connect(function()
                    onCharacterAdded(player)
                end)
                player.CharacterRemoving:Connect(function()
                    removeESP(player)
                end)
            end
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    onPlayerAdded(player)
                    if player.Character then
                        createESP(player)
                    end
                end
            end
            
            Players.PlayerAdded:Connect(onPlayerAdded)
            Players.PlayerRemoving:Connect(removeESP)
            
            task.spawn(function()
                local hue = 0
                while true do
                    task.wait(0.05)
                    if getgenv().ESPEnabled then
                        local color = getgenv().RAINBOW_MODE and hsvToRgb(hue, 1, 1) or getgenv().color_for_esp_value
                        for player, frame in pairs(getgenv().espObjects) do
                            if frame then
                                frame.BackgroundColor3 = color
                            end
                        end
                        hue = (hue + 0.01) % 1
                    end
                end
            end)
        else
            getgenv().ESPEnabled = false
            getgenv().ESPEnabled = false

            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                if player.Character then
                    local esp = player.Character:FindFirstChild("ESP")
                    if esp then
                        esp:Destroy()
                        esp:Destroy()
                        esp:Destroy()
                    end
                end
            end
        end
    end,})
    wait()
    local result_get = getgenv().otherFuncCheck(Other_Check)

    if result_get == true then
        getgenv().TracersToggleMain = Tab19:CreateToggle({
        Name = "Tracers",
        CurrentValue = false,
        Flag = "tracersOnActive",
        Callback = function(runTracersScript)
            if runTracersScript then
                getgenv().TRACERS_ESP_ENABLED = true
                getgenv().tracerLines = getgenv().tracerLines or {}

                local runService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
                local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
                local workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
                local camera = workspace.CurrentCamera

                local function removeTracer(player)
                    if getgenv().tracerLines[player] then
                        if getgenv().tracerLines[player] then
                            getgenv().tracerLines[player]:Remove()
                        end
                        getgenv().tracerLines[player] = nil
                    end
                end

                local function createTracer(player)
                    if not getgenv().TRACERS_ESP_ENABLED then return end
                    if not player.Character then return end

                    local char = player.Character
                    local rootPart = char:FindFirstChild("HumanoidRootPart")
                    if not rootPart then return end

                    local tracer = Drawing.new("Line")
                    tracer.Thickness = 2
                    tracer.Color = getgenv().color_for_esp_value
                    tracer.Visible = false

                    getgenv().tracerLines[player] = tracer
                end

                local function updateTracers()
                    if not getgenv().TRACERS_ESP_ENABLED then
                        for _, tracer in pairs(getgenv().tracerLines) do
                            if tracer then tracer:Remove() end
                        end
                        table.clear(getgenv().tracerLines)
                        return
                    end
                
                    for player, tracer in pairs(getgenv().tracerLines) do
                        local char = player.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local rootPart = char.HumanoidRootPart
                            local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                
                            if onScreen then
                                tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                                tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                                tracer.Visible = true
                
                                if getgenv().RAINBOW_MODE then
                                    local hue = tick() % 5 / 5
                                    tracer.Color = Color3.fromHSV(hue, 1, 1)
                                else
                                    tracer.Color = getgenv().color_for_esp_value
                                end
                            else
                                tracer.Visible = false
                            end
                        else
                            tracer.Visible = false
                        end
                    end
                end

                local function onPlayerAdded(player)
                    player.CharacterAdded:Connect(function()
                        repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        createTracer(player)
                    end)
                end

                for _, player in ipairs(players:GetPlayers()) do
                    if player ~= players.LocalPlayer then
                        onPlayerAdded(player)
                        if player.Character then createTracer(player) end
                    end
                end

                getgenv().tracerPlayerAddedConnection = players.PlayerAdded:Connect(onPlayerAdded)
                getgenv().tracerPlayerRemovingConnection = players.PlayerRemoving:Connect(removeTracer)

                getgenv().tracerUpdateConnection = runService.RenderStepped:Connect(updateTracers)
            else
                getgenv().TRACERS_ESP_ENABLED = false

                if getgenv().tracerLines then
                    for _, tracer in pairs(getgenv().tracerLines) do
                        if tracer then
                            pcall(function()
                                tracer.Visible = false
                                tracer:Remove()
                            end)
                        end
                    end
                    table.clear(getgenv().tracerLines)
                end

                if getgenv().tracerLines then
                    getgenv().tracerLines = nil
                end
                wait()
                if getgenv().tracerUpdateConnection then
                    pcall(function()
                        getgenv().tracerUpdateConnection:Disconnect()
                    end)
                    getgenv().tracerUpdateConnection = nil
                end

                if getgenv().tracerPlayerAddedConnection then
                    pcall(function()
                        getgenv().tracerPlayerAddedConnection:Disconnect()
                    end)
                    getgenv().tracerPlayerAddedConnection = nil
                end

                if getgenv().tracerPlayerRemovingConnection then
                    pcall(function()
                        getgenv().tracerPlayerRemovingConnection:Disconnect()
                    end)
                    getgenv().tracerPlayerRemovingConnection = nil
                end
                wait(0.4)
                local result_fullscreen = UserSettings():GetService("UserGameSettings"):InFullScreen()
                local GuiService = cloneref and cloneref(game:GetService("GuiService")) or game:GetService("GuiService")
                
                if result_fullscreen == false then
                    GuiService:ToggleFullscreen()
                    wait(1.2)
                    GuiService:ToggleFullscreen()
                end
            end
        end,})
    else
        warn("❌ - Drawing - ❌ | Unsupported, Tracer's is not able to load due to 'Drawing' being unsupported.")
    end
    wait()
    getgenv().RainbowMode = Tab19:CreateToggle({
    Name = "Rainbow Mode (For ESP)",
    CurrentValue = false,
    Flag = "rainbowModeActive",
    Callback = function(doRainbowFunc)
        if doRainbowFunc then
            getgenv().RAINBOW_MODE = true
        else
            getgenv().RAINBOW_MODE = false
        end
    end,})
    wait(0.2)
    if getgenv().RAINBOW_MODE or getgenv().RAINBOW_MODE == true then
        getgenv().RainbowMode:Set(false)
    end

    getgenv().ESPColorPicker = Tab19:CreateColorPicker({
    Name = "ESP Color",
    Color = Color3.fromRGB(255,255,255),
    Flag = "ChangeESPColorVal",
    Callback = function(esp_color_selected)
        getgenv().color_for_esp_value = esp_color_selected
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
                wait(0.1)
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
                    if getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool") then
                        getgenv().LocalPlayer:WaitForChild("Backpack"):FindFirstChild("Teleport Tool"):Destroy()
                    end
                    wait()
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
        Name = "TP To Crossroads Map (Only for Zacks Easy Hub users)",
        Callback = function()
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanooid:ChangeState(3)
                task.wait(.2)
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Crossroad"):GetPivot())
            else
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Crossroad"):GetPivot())
            end
        end,})

        getgenv().TeleportToModernHouseMap = Tab10:CreateButton({
        Name = "TP To Modern House Map (Only for Zacks Easy Hub users)",
        Callback = function()
            if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
                getgenv().Humanoid:ChangeState(3)
                task.wait(.4)
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Grass_Modern_Model_Baseplate"):GetPivot() * CFrame.new(0, 1190, 0))
            else
                getgenv().Character:PivotTo(getgenv().Workspace:FindFirstChild("Grass_Modern_Model_Baseplate"):GetPivot() * CFrame.new(0, 1190, 0))
            end
        end,})

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

        getgenv().TPToAStore = Tab10:CreateButton({
        Name = "TP To Store",
        Callback = function()
            local PreDefined_CFrame = CFrame.new(-94.0359421, 5.24999952, 29.9133148)

            getgenv().HumanoidRootPart.CFrame = PreDefined_CFrame
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

    getgenv().InfYield = Tab5:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        if getgenv().inf_yield_side then
            return getgenv().notify("Alert!", "Infinite Yield has already been loaded.", 6)
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

    getgenv().ResetSpeed = Tab2:CreateButton({
    Name = "Reset WalkSpeed",
    Callback = function()
        getgenv().Humanoid.WalkSpeed = 16
        getgenv().WalkSpeedSliding:Set(16)
    end,})

    if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
        getgenv().notify("Returned", "Found Method: JumpPower", 6)
        getgenv().JumpPowerSlider = Tab2:CreateSlider({
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
        getgenv().HeightJumpPowerSliding = Tab2:CreateSlider({
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

    if getgenv().Humanoid.UseJumpPower or getgenv().Humanoid.UseJumpPower == true then
        getgenv().ResetJumpPowerButton = Tab2:CreateButton({
        Name = "Reset JumpPower",
        Callback = function()
            getgenv().Humanoid.JumpPower = 50
            getgenv().JumpPowerSlider:Set(50)
        end,})
    else
        getgenv().ResetJumpHeightVal = Tab2:CreateButton({
        Name = "Reset JumpHeight",
        Callback = function()
            getgenv().Humanoid.JumpHeight = 7
            getgenv().HeightJumpPowerSliding:Set(7)
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

    getgenv().ResetGrav = Tab2:CreateButton({
    Name = "Reset Gravity",
    Callback = function()
        getgenv().Workspace.Gravity = 196.2
        getgenv().GravSliding:Set(196.2)
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
    Name = "Anti Bang/TP (Method 3, They Die To)",
    Callback = function()
        local OldDestroy_Height = getgenv().Workspace.FallenPartsDestroyHeight
        local voidPosition = Vector3.new(-499, -499, -499)
        local Workspace = getgenv().Workspace
        local HumanoidRP = getgenv().HumanoidRootPart
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
            local HumanoidRP = getgenv().HumanoidRootPart
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
            local HumanoidRootPart = getgenv().HumanoidRootPart
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
    if getgenv().AmbientChangerEnabled or getgenv().AmbientChangerEnabled == true then
        getgenv().AmbientChangerEnabled:Set(false)
    end

    getgenv().AmbientChooser = Tab9:CreateColorPicker({
    Name = "Ambient Color",
    Color = Color3.fromRGB(70, 70, 70),
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
    if getgenv().setFireWorksOn or getgenv().setFireWorksOn == true then
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
    if getgenv().SpookyMoon or getgenv().SpookyMoon == true then
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
    if getgenv().SpookSun or getgenv().SpookSun == true then
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
            for _, v in pairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
                v:AdjustSpeed(speed)
            end
        else
            for _, v in pairs(getgenv().Humanoid:GetPlayingAnimationTracks()) do
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
    if getgenv().slowMotion or getgenv().slowMotion == true then
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
    wait()
    if getgenv().doFreezeToggle or getgenv().doFreezeToggle == true then
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
    if getgenv().fastToggle or getgenv().fastToggle == true then
        getgenv().FastestEmotes:Set(false)
        getgenv().fastToggle = false
    end
    wait()
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

    getgenv().MuteAllBruh = Tab21:CreateToggle({
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
                    local audiodeviceinput = user:FindFirstChild("AudioDeviceInput")

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

    getgenv().ResetButton = Tab15:CreateButton({
    Name = "Reset",
    Callback = function()
        if getgenv().Character and getgenv().Character:FindFirstChild("Humanoid") then
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

            if #servers > 0 then
                getgenv().TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], getgenv().LocalPlayer)
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

    getgenv().ReExecuteGUI = Tab15:CreateButton({
    Name = "Re-Execute/Reload Script/GUI",
    Callback = function()
        getgenv().getLoopKick = false
        wait()
        getgenv().SCRIPT_EXECUTED = false
        getgenv().SCRIPT_EXECUTED = false
        getgenv().SCRIPT_EXECUTED = false
        getgenv().SCRIPT_EXECUTED = false
        getgenv().SCRIPT_EXECUTED = false
        wait(0.1)
        getgenv().Invis_Loaded = false
        getgenv().css_digital = false
        wait(0.2)
        getgenv().Rayfield:Destroy()
        wait(0.8)
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua')))()
    end,})

    getgenv().DestroyGUIScript = Tab15:CreateButton({
    Name = "Destroy GUI/Script",
    Callback = function()
        getgenv().getLoopKick = false
        wait()
        getgenv().SCRIPT_EXECUTED = false
        wait()
        getgenv().SCRIPT_EXECUTED = false
        wait(0.1)
        getgenv().Invis_Loaded = false
        getgenv().GetLoopRunning = false
        getgenv().GetLoopRunning = false
        getgenv().LmaoGetMuted = false
        getgenv().css_digital = false
        wait(0.2)
        if getgenv().Rayfield then
            getgenv().Rayfield:Destroy()
        else
            warn("Rayfield does not exist, or is already destroyed.")
        end
    end,})

    getgenv().UnmuteAPlayer = Tab21:CreateInput({
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

    if getgenv().runningEnabled or getgenv().runningEnabled == true then
        getgenv().ShiftToRun:Set(false)
        wait(0.2)
        getgenv().Humanoid.WalkSpeed = 14
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

            Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
            Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
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

            Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_1
            Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. Knight_Idle_2
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
        local Animate = Character:FindFirstChild("Animate")
        Animate.Disabled = true
        wait()
        Animate.Disabled = false
        local animtrack = getgenv().Humanoid:GetPlayingAnimationTracks()
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
    wait()
    local Trip_Settings = {
        Keybind_Trip = Enum.KeyCode.V,
        Keybind_FakeOut = Enum.KeyCode.R
    }
    wait()
    local function keycode_convert(keyString)
        return Enum.KeyCode[keyString] or nil
    end
    wait()
    local UserInputService = getgenv().UserInputService
    
    getgenv().Reverse_Keybind = Enum.KeyCode.F
    getgenv().Freeze_Keybind = Enum.KeyCode.V

    local ConfigFileName = "EmoteConfig.json"
    
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
        ["Key: Tab"] = Enum.KeyCode.Tab,
        ["Key: CapsLock"] = Enum.KeyCode.CapsLock,
        ["Key: Space"] = Enum.KeyCode.Space,
        ["Key: Enter"] = Enum.KeyCode.Return,
        ["Key: Backspace"] = Enum.KeyCode.Backspace,
        ["Key: Delete"] = Enum.KeyCode.Delete,
        ["Key: Insert"] = Enum.KeyCode.Insert,
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
        ["Numpad: Enter"] = Enum.KeyCode.KeypadEnter,
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
            return warn("Invalid slot selection:", slotName)
        end

        selectedSlot = Slots_Table[slotName]
        getgenv().notify("Success:", "Selected Slot: " .. slotName .. " (KeyCode: " .. tostring(selectedSlot) .. ")", 6)
    end,})

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

        Emote_Keybinds_Configuration[selectedSlot] = emote
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

    getgenv().SaveEmoteConfig = Tab15:CreateButton({
    Name = "Save Emote Configuration",
    Callback = function()
        local function write_configuration()
            local config = {
                Emote_Keybinds_Configuration = {},
                Emote_Speed_Configuration = {}
            }
        
            for key, value in pairs(Emote_Keybinds_Configuration) do
                config.Emote_Keybinds_Configuration[tostring(key)] = value
            end
        
            for key, value in pairs(Emote_Speed_Configuration) do
                config.Emote_Speed_Configuration[tostring(key)] = value
            end
        
            local jsonData = game:GetService("HttpService"):JSONEncode(config)
            writefile(ConfigFileName, jsonData)
            getgenv().notify("Success:", "Emote configuration has been saved!", 5)
        end
        
        write_configuration()
    end,})

    getgenv().LoadEmoteConfig = Tab15:CreateButton({
    Name = "Load Emote Configuration",
    Callback = function()
        local function Initialize_Configuration()
            if isfile(ConfigFileName) then
                local jsonData = readfile(ConfigFileName)
                local config = game:GetService("HttpService"):JSONDecode(jsonData)

                Emote_Keybinds_Configuration = {}
                Emote_Speed_Configuration = {}
        
                for key, value in pairs(config.Emote_Keybinds_Configuration) do
                    local key_press = Enum.KeyCode[key:match("Enum.KeyCode.(%w+)")]
                    if key_press then
                        Emote_Keybinds_Configuration[key_press] = value
                    end
                end
        
                for key, value in pairs(config.Emote_Speed_Configuration) do
                    local speed_key_code = Enum.KeyCode[key:match("Enum.KeyCode.(%w+)")]
                    if speed_key_code then
                        Emote_Speed_Configuration[speed_key_code] = value
                    end
                end
                wait()
                getgenv().notify("Success:", "Emote configuration has been loaded!", 5)
            else
                getgenv().notify("Error:", "No saved configuration found!", 5)
            end
        end
        
        Initialize_Configuration()
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

    local function input_start(input, entered)
        if not getgenv().EmoteSystemEnabled or entered then return end

        local emote = Emote_Keybinds_Configuration[input.KeyCode]
        if emote and getgenv().Humanoid then
            getgenv().Humanoid:PlayEmote(emote)
        end
    end

    local speedToggle = 1

    local function input_connecting(input, other)
        if not getgenv().EmoteSystemEnabled or other then return end

        if input.KeyCode == getgenv().Reverse_Keybind then
            speedToggle = (speedToggle == 1) and -1 or 1
            Emote_Speed_Configuration[getgenv().Reverse_Keybind] = speedToggle
            getgenv().emoting_actions(speedToggle)
        elseif input.KeyCode == getgenv().Freeze_Keybind then
            getgenv().emoting_actions(0)
        else
            local speed = Emote_Speed_Configuration[input.KeyCode]
            if speed and getgenv().Humanoid then
                getgenv().emoting_actions(tonumber(speed))
            end
        end
    end

    function emote_system(state)
        getgenv().EmoteSystemEnabled = state
    end

    getgenv().BoundConnections["EmoteInput"] = UserInputService.InputBegan:Connect(input_connecting)
    getgenv().BoundConnections["EmoteTrigger"] = UserInputService.InputBegan:Connect(input_start)
    wait()
    getgenv().Trip_Keybind = Tab15:CreateInput({  
    Name = "Trip Keybind",
    CurrentValue = "N",
    PlaceholderText = "Keybind Here",
    RemoveTextAfterFocusLost = true,
    Flag = "TrippingOverKeybind",
    Callback = function(KeyForTripping)
        local new_keycode = keycode_convert(string.upper(KeyForTripping))
        wait()
        if new_keycode then
            Trip_Settings.Keybind_Trip = new_keycode
        else
            warn("Invalid keybind for Trip:", KeyForTripping)
        end
    end,})
    
    getgenv().FakeOut_Keybind = Tab15:CreateInput({
    Name = "Fake Out Keybind",
    CurrentValue = "R",
    PlaceholderText = "Keybind Here",
    RemoveTextAfterFocusLost = true,
    Flag = "FakingOutKeybind",
    Callback = function(key_for_fake_out)
        local updated_key = keycode_convert(string.upper(key_for_fake_out))
        wait()
        if updated_key then
            Trip_Settings.Keybind_FakeOut = updated_key
        else
            warn("Invalid keybind for Fake Out:", key_for_fake_out)
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
                wait(2)
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
            "System_Broken_Title", "Huge_Baseplate", "Animation_Fall", "Mute_Boomboxes_Cellmates_VC_Game_Setting",
            "System_Broken", "Emote_Keybinds", "Animation_Climb", "Death_On_Load",
            "Mute_Music_Volume_Cellmates_VC_Game_Setting", "Custom_Animation_Package_System",
            "Infinite_Yield_Premium", "System_Broken_Text_Title", "Animation_Idle", "Old_Materials",
            "Animation_Jump", "Anti_Suspend_VC", "Performance_Statistics", "Mute_Sound_Effects_Cellmates_VC_Game_Setting",
            "Fully_Loaded_Message", "Fully_Loaded_Messaging", "Animation_Run", "Script_Clock_Time_GUI",
            "Title_Toggle_UI", "Animation_Walk", "keep_tp_tool", "AntiAFK"
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
    
    getgenv().IdleAnimToSet = Tab20:CreateDropdown({
    Name = "Idle Animation",
    Options = {"Zombie", "Catwalk Glam", "Elder", "Cartoony", "Adidas", "Werewolf", "Vampire", "Astronaut", "Superhero", "Knight", "Mage", "Ninja", "Toy", "NFL", "No Boundaries", "Oldschool", "Pirate", "Levitation", "Bubbly", "Robot", "Wicked Popular", "Bold", "Stylish", "Rthro"},
    CurrentOption = "",
    MultipleOptions = false,
    Flag = "IdleAnimDropdownList",
    Callback = function(dropSelectedForAnim)
        if getgenv().using_custom_animation_packages or getgenv().using_custom_animation_packages == true then
            print("Dropdown Selection Type:", typeof(dropSelectedForAnim))
            
            if typeof(dropSelectedForAnim) == "table" then
                dropSelectedForAnim = dropSelectedForAnim[1]
            end

            getgenv().Easies_Configuration["Animation_Idle"] = tostring(dropSelectedForAnim)
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
    CurrentValue = readConfigValue("Fully_Loaded_Message") or "Zacks Easy Hub - Winning!",
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
    Name = "Zacks System Broken (Auto-Load)",
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

    getgenv().EmoteSystemEnabled = false
    wait()
    getgenv().ToggleEmoteKeybinds = Tab20:CreateToggle({
    Name = "Emote Keybinds",
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
    --[[wait(0.2)
    getgenv().Easies_Configuration["Fully_Loaded_Message"] = "Zacks Easy Hub - On TOP!"
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
        warn("Already viewed and injected 'Zacks Easy Hub'")
    else
        if game.PlaceId == 6884319169 or game.PlaceId == 15546218972 then
            GuiService:SendNotification({
                Title = "Please wait...",
                Text = "Attaching Zacks Easy Hub into MIC UP 🔊...",
            })
            wait(0.3)
            if not getgenv().Has_Died_Func then
                if setfpscap then
                    setfpscap(0)
                    wait(0.5)
                    print("Injecting Zacks Easy Hub...")
                    wait(0.5)
                    getgenv().emoting_actions(0)
                    wait(0.2)
                    getgenv().emoting_actions()
                    wait(0.5)
                    getgenv().Humanoid.Health = 0
                    wait(0.1)
                    getgenv().Has_Died_Func = true
                    wait(0.3)
                    getgenv().Is_ZEH_Attached = true
                    wait(1)
                    setfpscap(999)
                    wait()
                    getgenv().output_already_viewed = true
                else
                    getgenv().Humanoid.Health = 0
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
                Text = "Hooking and injecting into this experience...",
            })
            wait(0.8)
            if setfpscap then
                setfpscap(1)
                wait(0.5)
                print("Injecting Zacks Easy Hub...")
                wait(1)
                getgenv().emoting_actions(0)
                getgenv().emoting_actions(0)
                wait(1)
                getgenv().Is_ZEH_Attached = true
                getgenv().Has_Died_Func = true
                getgenv().output_already_viewed = true
                wait(0.6)
                setfpscap(999)
            end
        end
    end
    wait(0.4)
    if getgenv().seen_output_zeh then
        warn("Already seen notification output.")
    else
        if getgenv().Is_ZEH_Attached or getgenv().Is_ZEH_Attached == true then
            GuiService:SendNotification({
                Title = "Successful.",
                Text = "Successfully injected into experience.",
            })
        else
            GuiService:SendNotification({
                Title = "Failure!",
                Text = "Could not allocate memory to inject into!",
            })
        end
        wait()
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
