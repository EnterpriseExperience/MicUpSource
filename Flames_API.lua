-- Usage:

-- local flames_api = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flames_API.lua"))()
-- print(flames_api.ExecutorName)
-- local randomPlayer = flames_api.FindPlayer("random")

-- Flames API arguments:
-- flames_api.FindPlayer("random") -- example of 'FindPlayer', supports: shortening names, displaynames, and usernames. (does not let you target yourself, will be fixed soon, had some issues with that part).
-- flames_api.ExecutorName -- will let you display the executor's current name (just name, not version), works for TextLabels and stuff to, automatically defaults to "Unknown" if somehow not supported or not found, and is automatically a tostring.
-- flames_api.Players -- Players service, any executor that supports "cloneref" it'll automatically sandbox Players into cloneref, if the executor somehow does not support "cloneref", it'll default to regular Players service.
-- flames_api.LocalPlayer -- Should be obvious what this does, get's your LocalPlayer.
-- flames_api.Workspace -- get's Workspace service, defaults to "cloneref" sandbox if supported, if not, it'll default to regular "Workspace" service grabber.
-- flames_api.ReplicatedStorage -- get's ReplicatedStorage service, and just like Players and Workspace, defaults to "cloneref" if supported, if not, just grabs regular ReplicatedStorage service.
-- flames_api.HttpService -- same thing here, same rules
-- flames_api.RunService -- same thing once more.
-- flames_api.RandomString(string) -- when inputting a string it'll randomize it for you automatically.

return function()
    local fullpackage = {}

    getgenv().Game = game
    getgenv().JobID = game.JobId
    getgenv().PlaceID = game.PlaceId

    getgenv().Service_Wrap = function(serviceName)
        if cloneref then
            return cloneref(game:GetService(serviceName))
        else
            return game:GetService(serviceName)
        end
    end

    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor" }
    end

    local function executor_details()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end

    local executor_Name = executor_details()

    getgenv().print_executor = function()
        local function retrieve_executor()
            local name
            if identifyexecutor then
                name = identifyexecutor()
            end
            return { Name = name or "Unknown Executor" }
        end

        local function identify_executor()
            local executorDetails = retrieve_executor()
            return string.format("%s", executorDetails.Name)
        end

        wait(0.1)
        local executor_string = identify_executor()
        return print(executor_string)
    end

    getgenv().warn_executor = function()
        local function retrieve_executor()
            local name
            if identifyexecutor then
                name = identifyexecutor()
            end
            return { Name = name or "Unknown Executor" }
        end

        local function identify_executor()
            local executorDetails = retrieve_executor()
            return string.format("%s", executorDetails.Name)
        end

        wait(0.1)
        local executor_string = identify_executor()
        return warn(executor_string)
    end

    getgenv().randomString = function()
        local length = math.random(10,20)
        local array = {}
        for i = 1, length do
            array[i] = string.char(math.random(32, 126))
        end
        return table.concat(array)
    end

    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    function findplr(args)
        local tbl = Players:GetPlayers()

        if args == "me" or args == LocalPlayer.Name or args == LocalPlayer.DisplayName then
            return
        end

        if args == "random" then
            local validPlayers = {}
            for _, v in pairs(tbl) do
                if v ~= LocalPlayer then
                    table.insert(validPlayers, v)
                end
            end
            return #validPlayers > 0 and validPlayers[math.random(1, #validPlayers)] or nil
        end

        for _, v in pairs(tbl) do
            if (v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower())) and v ~= LocalPlayer then
                return v
            end
        end
    end

    getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    getgenv().httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    get_http = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    getgenv().queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    queueteleport = getgenv().queueteleport

    local function init_services()
        local services = {
            "Players","Workspace","Lighting","ReplicatedStorage","TweenService","RunService","MaterialService",
            "ReplicatedFirst","Teams","StarterPack","StarterPlayer","VoiceChatInternal","VoiceChatService",
            "CoreGui","SoundService","StarterGui","MarketplaceService","TeleportService","Chat","AssetService",
            "HttpService","UserInputService","TextChatService","ContextActionService","GuiService","PhysicsService"
        }
        for _, serviceName in pairs(services) do
            getgenv()[serviceName] = cloneref and cloneref(game:GetService(serviceName)) or game:GetService(serviceName)
        end
    end
    wait()
    init_services()
    task.wait()

    local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
    local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
    local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
    local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")

    getgenv().LocalPlayer = Players.LocalPlayer
    getgenv().Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local function SafeGetHumanoid(char)
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            return hum
        else
            return char:WaitForChild("Humanoid", 5)
        end
    end

    local function SafeGetHead(char)
        local head = char:FindFirstChild("Head")
        if head then
            return head
        else
            return char:WaitForChild("Head", 5)
        end
    end

    local function SafeGetHRP(char)
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            return hrp
        else
            return char:WaitForChild("HumanoidRootPart", 5)
        end
    end

    getgenv().HumanoidRootPart = SafeGetHRP(getgenv().Character)
    getgenv().Humanoid = SafeGetHumanoid(getgenv().Character)
    getgenv().Head = SafeGetHead(getgenv().Character)

    local function Dynamic_Character_Updater(character)
        getgenv().Character = character
        wait(0.3)
        getgenv().HumanoidRootPart = SafeGetHRP(character)
        getgenv().Humanoid = SafeGetHumanoid(character)
        getgenv().Head = SafeGetHead(character)
    end

    Dynamic_Character_Updater(getgenv().Character)

    getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        task.wait(0.2)
        Dynamic_Character_Updater(newCharacter)
        repeat wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
        wait(0.6)
        getgenv().HumanoidRootPart = SafeGetHRP(newCharacter)
        getgenv().Humanoid = SafeGetHumanoid(newCharacter)
        getgenv().Head = SafeGetHead(newCharacter)
        newCharacter:FindFirstChild("Humanoid").JumpHeight = 7
        newCharacter:FindFirstChild("Humanoid").JumpPower = 50
        getgenv().Humanoid.JumpHeight = 7
        getgenv().Humanoid.JumpPower = 50
        Dynamic_Character_Updater(newCharacter)
    end)

    fullpackage.ExecutorName = executor_Name
    fullpackage.FindPlayer = findplr
    fullpackage.RandomString = getgenv().randomString
    fullpackage.Players = Players
    fullpackage.LocalPlayer = LocalPlayer
    fullpackage.Workspace = Workspace
    fullpackage.ReplicatedStorage = ReplicatedStorage
    fullpackage.HttpService = HttpService
    fullpackage.RunService = RunService

    return fullpackage
end
