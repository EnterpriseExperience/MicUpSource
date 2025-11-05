-- FOR ADVANCED USERS: --
-- getgenv().AllClipboards("text you want to copy here") -- Checks if the clipboard functions are available and allows you to let the user copy what ever you put in here.
-- getgenv().httprequest_Init -- For more advanced users, but includes ALL functions for httprequest, and making requests to Discord, and such.
-- getgenv().getgenv().queueteleport -- For more advanced users, but includes queue-teleport functionality, allowing you to make scripts like auto-execute on rejoin scripts, if done correctly of course.

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
wait(0.1)
getgenv().get_char = function(Player)
   if not Player or typeof(Player) ~= "Instance" or not Player:IsA("Player") then
      getgenv().notify("Error", "That is not a Player, or Player entered isn't an actual player.", 5)
      return nil
   end

   local character = Player.Character
   local attempts = 0
   local max_attempts = 25

   while not character and attempts < max_attempts do
      task.wait(0.2)
      character = Player.Character
      attempts += 1
   end

   if not character then
      local ok, newChar = pcall(function()
         return Player.CharacterAdded:Wait()
      end)
      if ok and newChar then
         character = newChar
      end
   end

   if not character then
      getgenv().notify("Error", "Could not fetch Character for: "..tostring(Player or "???"), 6)
      return nil
   end

   return character
end
wait(0.2)
local function SafeGetHumanoid(Player)
   local character = getgenv().get_char(Player)
   if not character then
      return nil
   end

   local humanoid = character:FindFirstChildOfClass("Humanoid")
   local attempts = 0
   local max_attempts = 25

   while not humanoid and attempts < max_attempts do
      task.wait(0.2)
      humanoid = character:FindFirstChildOfClass("Humanoid")
      attempts += 1
   end

   if not humanoid then
      local ok, hum = pcall(function()
         return character:WaitForChild("Humanoid", 5)
      end)
      if ok and hum then
         humanoid = hum
      end
   end

   if not humanoid then
      return nil
   end

   return humanoid
end

local function SafeGetHRP(Player)
   local character = getgenv().get_char(Player)
   if not character then
      return nil
   end

   local root = character:FindFirstChild("HumanoidRootPart")
   local attempts = 0
   local max_attempts = 25

   while not root and attempts < max_attempts do
      task.wait(0.2)
      root = character:FindFirstChild("HumanoidRootPart")
      attempts += 1
   end

   if not root then
      local ok, hrp = pcall(function()
         return character:WaitForChild("HumanoidRootPart", 5)
      end)
      if ok and hrp then
         root = hrp
      end
   end

   if not root then
      return nil
   end

   return root
end

local function SafeGetHead(Player)
   if not Player or typeof(Player) ~= "Instance" or not Player:IsA("Player") then
      getgenv().notify("Error", "Invalid Player provided to get_head.", 5)
      return nil
   end

   local character = getgenv().get_char(Player)
   if not character then
      return nil
   end

   local head = character:FindFirstChild("Head")
   local attempts = 0
   local max_attempts = 25

   while not head and attempts < max_attempts do
      task.wait(0.1)
      head = character:FindFirstChild("Head")
      attempts += 1
   end

   if not head then
      local ok, result = pcall(function()
         return character:WaitForChild("Head", 5)
      end)
      if ok and result then
         head = result
      end
   end

   if not head or not head:IsA("BasePart") then
      return nil
   end

   return head
end

local FlyConnections

FlyConnections = FlyConnections or {}
getgenv().FlyPart = getgenv().FlyPart or nil
getgenv().FlySpeed = getgenv().FlySpeed or 10
flames_api.Character = getgenv().get_char(LocalPlayer)
flames_api.Humanoid = SafeGetHumanoid(LocalPlayer)
flames_api.HumanoidRootPart = SafeGetHRP(LocalPlayer)
flames_api.Head = SafeGetHead(LocalPlayer)

local function Dynamic_Character_Updater(character)
	flames_api.Character = getgenv().get_char(LocalPlayer) or character
	wait(0.3)
	flames_api.Humanoid = SafeGetHumanoid(LocalPlayer)
	flames_api.HumanoidRootPart = SafeGetHRP(LocalPlayer)
	flames_api.Head = SafeGetHead(LocalPlayer)
	flames_api.SeatPart = flames_api.Humanoid and flames_api.Humanoid.SeatPart or nil
end

flames_api.Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local 
Dynamic_Character_Updater(flames_api.Character)

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(0.3)
	Dynamic_Character_Updater(newCharacter)
	repeat wait() until newCharacter:FindFirstChildWhichIsA("Humanoid") and newCharacter:FindFirstChild("HumanoidRootPart")
	wait(0.6)
	flames_api.Humanoid = SafeGetHumanoid(newCharacter)
	flames_api.HumanoidRootPart = SafeGetHRP(newCharacter)
	flames_api.Head = SafeGetHead(newCharacter)
	flames_api.SeatPart = SafeGetHumanoid(newCharacter).SeatPart
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

flames_api.notify = function(title, content, duration)
   flames_api.Service("StarterGui"):SetCore("SendNotification", {
      Title = tostring(title);
      Text = tostring(content);
      Duration = tonumber(duration);
   })
end

flames_api.Fly = function(speed)
	if getgenv().FlyEnabled then return flames_api.notify("Failure:", "Fly is already enabled!", 5) end
	local HumanoidRootPart = flames_api.HumanoidRootPart
	local Workspace = flames_api.Service("Workspace")
	local StarterPack = flames_api.Service("StarterPack")
	local RunService = flames_api.Service("RunService")
	local UserInputService = flames_api.Service("UserInputService")
	local character = flames_api.Character
	local humanoid = flames_api.Humanoid
	local camera = Workspace.CurrentCamera
	getgenv().FlySpeed = tonumber(speed) or 5
	getgenv().FlyEnabled = getgenv().FlyEnabled or false

	getgenv().StartFly = function()
		if getgenv().FlyEnabled then return flames_api.notify("Failure:", "Fly is already enabled!", 5) end
		getgenv().FlyEnabled = true

		local dir = {w = false, a = false, s = false, d = false, q = false, e = false}
		local cf = Instance.new("CFrameValue")

		getgenv().FlyPart = Instance.new("Part")
		getgenv().FlyPart.Name = "RUNPART-SURF"
		getgenv().FlyPart.Anchored = true
		getgenv().FlyPart.Parent = StarterPack
		getgenv().FlyPart.CFrame = HumanoidRootPart and HumanoidRootPart.CFrame or CFrame.new()

		FlyConnections.render = RunService.RenderStepped:Connect(function()
			if not getgenv().FlyEnabled or not HumanoidRootPart then return end
			local primaryPart = HumanoidRootPart
			local speed = getgenv().FlySpeed

			local x, y, z = 0, 0, 0
			if dir.w then z = -1 * speed end
			if dir.a then x = -1 * speed end
			if dir.s then z = 1 * speed end
			if dir.d then x = 1 * speed end
			if dir.q then y = 1 * speed end
			if dir.e then y = -1 * speed end

			for i, v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Velocity = Vector3.new(0, 0, 0)
					v.RotVelocity = Vector3.new(0, 0, 0)
				end
			end

			getgenv().FlyPart.CFrame = CFrame.new(
				getgenv().FlyPart.CFrame.p,
				(camera.CFrame * CFrame.new(0, 0, -100)).p
			)

			local moveDir = CFrame.new(x, y, z)
			cf.Value = cf.Value:lerp(moveDir, 0.2)
			getgenv().FlyPart.CFrame = getgenv().FlyPart.CFrame:lerp(getgenv().FlyPart.CFrame * cf.Value, 0.2)
			primaryPart.CFrame = getgenv().FlyPart.CFrame
			humanoid.PlatformStand = true
		end)

		FlyConnections.inputBegan = UserInputService.InputBegan:Connect(function(input, event)
			if event or not getgenv().FlyEnabled then return end
			local code, codes = input.KeyCode, Enum.KeyCode
			if code == codes.W then dir.w = true
			elseif code == codes.A then dir.a = true
			elseif code == codes.S then dir.s = true
			elseif code == codes.D then dir.d = true
			elseif code == codes.Q then dir.q = true
			elseif code == codes.E then dir.e = true
			elseif code == codes.Space then dir.q = true
			end
		end)

		FlyConnections.inputEnded = UserInputService.InputEnded:Connect(function(input, event)
			if event or not getgenv().FlyEnabled then return end
			local code, codes = input.KeyCode, Enum.KeyCode
			if code == codes.W then dir.w = false
			elseif code == codes.A then dir.a = false
			elseif code == codes.S then dir.s = false
			elseif code == codes.D then dir.d = false
			elseif code == codes.Q then dir.q = false
			elseif code == codes.E then dir.e = false
			elseif code == codes.Space then dir.q = false
			end
		end)
	end

	getgenv().StartFly()
end

flames_api.Unfly = function()
	if not getgenv().FlyEnabled then return end
	
	getgenv().FlyEnabled = false

	for _, conn in pairs(FlyConnections) do
		if conn then conn:Disconnect() end
	end
	FlyConnections = {}

	if getgenv().FlyPart then
		getgenv().FlyPart:Destroy()
		getgenv().FlyPart = nil
	end

	if flames_api.Humanoid then
		flames_api.Humanoid.PlatformStand = false
	end
end

flames_api.FindPlayer = function(args)
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

flames_api.BypassAdonis = function()
	if getgenv().AdonisBypass_Already_Loaded then
		return 
	end
	wait()

	loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Adonis_Bypass_BACKUP.lua'))()
	wait(0.2)
	getgenv().AdonisBypass_Already_Loaded = true
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
