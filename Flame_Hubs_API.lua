-- Usage:

-- local flames_api = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua"))()

-- Flames API arguments:
-- flames_api.FindPlayer("random") -- example of 'FindPlayer', supports: shortening names, displaynames, and usernames. (does not let you target yourself, will be fixed soon, had some issues with that part).
-- flames_api.ExecutorName() -- will let you display the executor's current name (just name, not version), works for TextLabels and stuff to, automatically defaults to "Unknown" if somehow not supported or not found, and is automatically a tostring.
-- flames_api.Service("Service_Name") -- Service getter, will obviously check if the service even exists before getting it, but will default to "cloneref" sandboxing the service if supported, if not somehow, it'll default to regular service fetcher.
-- flames_api.LocalPlayer -- Should be obvious what this does, get's your LocalPlayer.
-- flames_api.RandomString(string) -- when inputting a string it'll randomize it for you automatically.
-- flames_api.Character -- returns your Character, doesn't matter if you respawn, or what not, it'll always automatically update it.
-- flames_api.HumanoidRootPart -- grabs your HumanoidRootPart (even if you die, respawn, etc).
-- flames_api.Humanoid -- grabs your Humanoid (even if you die, respawn, etc).
-- flames_api.Head -- grabs your Head (even if you die, respawn, etc).
-- flames_api.SeatPart -- grabs your current SeatPart.
-- flames_api.Vehicle() -- uses "SeatPart" to get your Vehicle, and checks the Vehicle to see if it has wheels, and if it's a Model as well.
-- flames_api.GoTo("Player You Want To Teleport To Here") -- usage: flames_api.GoTo("Player") and it will attempt to Pivot your Character to they're Character if the target name is correct and exists.
-- flames_api.WalkSpeed(new_walkspeed_here) -- Allows you to set your WalkSpeed in this API.
-- flames_api.JumpPower(new_jumppower_here) -- Allows you to set your JumpHeight/JumpPower in this API, has detection for JumpHeight AND JumpPower, so if your game uses JumpPower, it'll know, and if JumpHeight, it'll know.
-- flames_api.BypassWalkSpeed() -- Will attempt to use 'getconnections', if supported, to bypass WalkSpeed checks from games (this method only works if the game detects using "GetPropertyChangedSignal")
-- flames_api.BypassJumpPower() -- Will attempt to use 'getconnections', if supported, to bypass JumpHeight/JumPower checks from games (this method only works if the game detects using "GetPropertyChangedSignal")
-- flames_api.JobID() -- returns the current JobID of your current game session/server.
-- flames_api.PlaceID() -- returns the current PlaceID of your current game.
-- EXTRA-1: getgenv().AllClipboards("text you want to copy here") -- Checks if the clipboard functions are available and allows you to let the user copy what ever you put in here.
-- EXTRA-2: getgenv().httprequest_Init -- For more advanced users, but includes ALL functions for httprequest, and making requests to Discord, and such.
-- EXTRA-3: getgenv().getgenv().queueteleport -- For more advanced users, but includes queue-teleport functionality, allowing you to make scripts like auto-execute on rejoin scripts, if done correctly of course.

local flames_api = {}

local function SafeGet(serviceName)
    local ok, service = pcall(function()
        return cloneref and cloneref(game:GetService(serviceName)) or game:GetService(serviceName)
    end)
    return ok and service or nil
end

getgenv().Game = game
getgenv().JobID = game.JobId
getgenv().PlaceID = game.PlaceId

flames_api.Service = function(serviceName)
    return SafeGet(serviceName)
end

local function getExecutor()
	if identifyexecutor then
		return { Name = identifyexecutor() }
	end
	return { Name = "Unknown Executor" }
end

local function executor_details()
	return getExecutor().Name
end

flames_api.ExecutorName = executor_details()

getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
getgenv().httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
getgenv().queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

flames_api.RandomString = function()
	local length = math.random(10, 50)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local Players = SafeGet("Players")
local LocalPlayer = Players.LocalPlayer

flames_api.Players = Players
flames_api.LocalPlayer = LocalPlayer
flames_api.PlaceID = getgenv().PlaceID
flames_api.JobID = getgenv().JobID
flames_api.PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:FindFirstChildWhichIsA("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 3)

local function SafeGetHumanoid(char)
	return char:FindFirstChildWhichIsA("Humanoid") or char:WaitForChild("Humanoid", 5)
end

local function SafeGetHRP(char)
	return char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 5)
end

local function SafeGetHead(char)
	return char:FindFirstChild("Head") or char:WaitForChild("Head", 5)
end

local function Dynamic_Character_Updater(character)
	flames_api.Character = character
	wait(0.3)
	flames_api.Humanoid = SafeGetHumanoid(character)
	flames_api.HumanoidRootPart = SafeGetHRP(character)
	flames_api.Head = SafeGetHead(character)
	flames_api.SeatPart = flames_api.Humanoid and flames_api.Humanoid.SeatPart or nil
end

flames_api.Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
Dynamic_Character_Updater(flames_api.Character)

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(0.3)
	Dynamic_Character_Updater(newCharacter)
	repeat wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
	wait(0.6)
	flames_api.Humanoid = SafeGetHumanoid(newCharacter)
	flames_api.HumanoidRootPart = SafeGetHRP(newCharacter)
	flames_api.Head = SafeGetHead(newCharacter)
	flames_api.SeatPart = Humanoid.SeatPart
	wait(0.2)
	Dynamic_Character_Updater(newCharacter)
end)

flames_api.Vehicle = function()
	local character = flames_api.Character
	local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
	local hrp = character and character:FindFirstChild("HumanoidRootPart")

	if humanoid and humanoid.SeatPart then
		local seatPart = humanoid.SeatPart
		local model = seatPart:FindFirstAncestorOfClass("Model")

		if model and typeof(model.GetDescendants) == "function" then
			for _, descendant in ipairs(model:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.Name and string.find(descendant.Name:lower(), "wheel") then
					return model
				end
			end
		end
	end

	return nil
end

flames_api.FindPlayer = function(arg)
	local tbl = Players:GetPlayers()
	local cmdlp = Players.LocalPlayer

	if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
		return warn("[ERROR]:", "You cannot target yourself.")
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
wait(0.1)
flames_api.GoTo = function(playerArg)
	local success, err = pcall(function()
		local Target = flames_api.FindPlayer(playerArg)
		if not Target then return end

		if Target.Character and flames_api.Character then
			local TargetChar = Target.Character or Target.CharacterAdded:Wait()
			task.wait(0.1)
			flames_api.Character:PivotTo(TargetChar:GetPivot())
		end
	end)
	if not success then
		warn("[GoTo_Error]: " .. tostring(err))
	end
end

flames_api.WalkSpeed = function(Speed)
	if type(Speed) ~= "number" then return end
	pcall(function()
		if flames_api.Humanoid then
			flames_api.Humanoid.WalkSpeed = Speed
		end
	end)
end

flames_api.JumpPower = function(JP)
	if type(JP) ~= "number" then return end
	pcall(function()
		if flames_api.Humanoid.UseJumpPower or flames_api.Humanoid.UseJumpPower == true then
			flames_api.Humanoid.JumpPower = JP
		else
			flames_api.Humanoid.JumpHeight = JP
		end
	end)
end

flames_api.BypassWalkSpeed = function()
	if not getconnections then
		return warn("[ERROR]:", "Your executor does not support 'getconnections'!")
	end

	local humanoid = flames_api.Humanoid

	if not humanoid then
		return warn("[ERROR]:", "Humanoid not found inside Character at runtime.")
	end

	local signal = humanoid:GetPropertyChangedSignal("WalkSpeed")
	local connections = getconnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
end

flames_api.BypassJumpPower = function()
	if not getconnections then
		return warn("[ERROR]:", "Your executor does not support 'getconnections'!")
	end

	local humanoid = flames_api.Humanoid

	if not humanoid then
		return warn("[ERROR]:", "Humanoid not found inside Character at runtime.")
	end

	local signal = humanoid:GetPropertyChangedSignal("JumpHeight")
	local connections = getconnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
	local signal = humanoid:GetPropertyChangedSignal("UseJumpPower")
	local connections = getconnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
	wait()
	local signal = humanoid:GetPropertyChangedSignal("JumpPower")
	local connections = getconnections(signal)
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disable()
		end)
	end
end

local serviceList = {
	"Players", "Workspace", "Lighting", "ReplicatedStorage", "TweenService",
	"RunService", "MaterialService", "ReplicatedFirst", "Teams", "StarterPack",
	"StarterPlayer", "VoiceChatInternal", "VoiceChatService", "CoreGui", "SoundService",
	"StarterGui", "MarketplaceService", "TeleportService", "Chat", "AssetService",
	"HttpService", "UserInputService", "TextChatService", "ContextActionService",
	"GuiService", "PhysicsService"
}

for _, serviceName in ipairs(serviceList) do
	flames_api[serviceName] = SafeGet(serviceName)
end

return flames_api
