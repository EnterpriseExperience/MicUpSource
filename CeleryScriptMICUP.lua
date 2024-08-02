if game.PlaceId == 6884319169 then
    local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
    local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
    local ProcessStartName = tostring("8.54773254E-2")
    local ScriptProcess = ProcessStartName
    if SCRIPT_EXECUTED and not _G.SCRIPT_EXECUTED == true then
        return Notification:Notify(
            {Title = "Error: ", Description = "Process "..ProcessStartName..", is already running!"},
            {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 10, Type = "option"},
            {Image = "http://www.roblox.com/asset/?id=0", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function() print("") end}
        )
    end
    pcall(function() getgenv().SCRIPT_EXECUTED = true end)

function loadGUI()
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
local currentTime = os.time()
local formattedTime = os.date("%I:%M %p", currentTime)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/OrionCrazyLib.lua')))()
local Window = OrionLib:MakeWindow({Name = "Zacks Easy Hub | "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.." | Executed At: "..formattedTime, IntroText = "Hello, "..game.Players.LocalPlayer.Name, HidePremium = true, SaveConfig = true, ConfigFolder = "MICUp"})
local Tab1 = Window:MakeTab({
	Name = "__HOME_PAGE__",
	Icon = "rbxassetid://7733960981",
	PremiumOnly = false
})
local Section1 = Tab1:AddSection({
	Name = "__MODIFICATIONS_TO_BOOTHS_MAIN__"
})
local Tab2 = Window:MakeTab({
	Name = "__CHARACTER_UTILS__",
	Icon = "rbxassetid://7743871002",
	PremiumOnly = false
})
local Section2 = Tab2:AddSection({
	Name = "__UTILITIES_FOR_CHARACTER_MODIFICATION__"
})
local Tab4 = Window:MakeTab({
	Name = "__COMMUNICATION_TOOLS__",
	Icon = "rbxassetid://7734021300",
	PremiumOnly = false
})
local Section4 = Tab4:AddSection({
	Name = "__UTILITIES_FOR_CHAT_BYPASSING_AND_COMMUNICATION__"
})
local Tab5 = Window:MakeTab({
	Name = "__EXTRA_UTILITIES__",
	Icon = "rbxassetid://7733954760",
	PremiumOnly = false
})
local Section5 = Tab5:AddSection({
	Name = "__PROVIDED_BY_ZACKS_EASY_HUB__ -- EXTRAS"
})
local Tab6 = Window:MakeTab({
	Name = "__CONTEXT/INFO__",
	Icon = "rbxassetid://7734022107",
	PremiumOnly = false
})
local Section6 = Tab6:AddSection({
	Name = "_INFORMATION_AND_SUCCESSFUL_QUOTES_PAGE__"
})
wait()
local Whitelisted = {game.Players.LocalPlayer.Name, "Roblox"}
wait()
	local Players = cloneref(game:GetService("Players"))
	-- Functions --
	local cmdp = Players
	local cmdlp = cmdp.LocalPlayer
	
	function findplr(args, tbl)
		if tbl == nil then
			local tbl = cmdp:GetPlayers()
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
				for _,v in pairs(tbl) do
					if v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
						vAges[#vAges+1] = v
					end
				end
				return vAges[math.random(1,#vAges)]
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
				for _,v in pairs(tbl) do
					if v ~= cmdlp then
						local math = (v.Character:FindFirstChild("HumanoidRootPart").Position - cmdlp.Character.HumanoidRootPart.Position).magnitude
						if math < 30 then
							vAges[#vAges+1] = v
						end
					end
				end
				return vAges[math.random(1,#vAges)]
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
-- Do not remove these lines unless you can fix this part directly under this line (this will break the script in Solara, so it is pointless for now) --

--[[local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    local userInputService = game:GetService("UserInputService")

    local function onKeyPress(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            if game:GetService("CoreGui"):FindFirstChild("Orion") then
                game.CoreGui:FindFirstChild("Orion").Enabled = not game.CoreGui:FindFirstChild("Orion").Enabled
            end
        end
    end
    
    local function onKeyRelease(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            if game:GetService("CoreGui"):FindFirstChild("Orion") then
                game.CoreGui:FindFirstChild("Orion").Enabled = not game.CoreGui:FindFirstChild("Orion").Enabled
            end
        end
    end
    
    userInputService.InputBegan:Connect(onKeyPress)
    userInputService.InputEnded:Connect(onKeyRelease)
wait()--]]
function isNumber(str)
	if tonumber(str) ~= nil then
		return true
	end
end
wait()
Tab1:AddButton({
Name = "Steal Booths",
Callback = function()
local Folder = workspace:WaitForChild("Stalls")
---
local Stall1 = Folder:FindFirstChild("Stall1")
local Stall2 = Folder:FindFirstChild("Stall2")
local Stall3 = Folder:FindFirstChild("Stall3")
local Stall4 = Folder:FindFirstChild("Stall4")
local Stall5 = Folder:FindFirstChild("Stall5")

if Stall1:FindFirstChild("ProxPart") then
    local Proximity1 = Stall1:FindFirstChild("ProxPart").ProximityPrompt
    Proximity1.Enabled = true
    wait()
    Proximity1.HoldDuration = 0
end
if Stall2:FindFirstChild("ProxPart") then
    local Proximity2 = Stall2:FindFirstChild("ProxPart").ProximityPrompt
    Proximity2.Enabled = true
    wait()
    Proximity2.HoldDuration = 0
end
if Stall3:FindFirstChild("ProxPart") then
    local Proximity3 = Stall3:FindFirstChild("ProxPart").ProximityPrompt
    Proximity3.Enabled = true
    wait()
    Proximity3.HoldDuration = 0
end
if Stall4:FindFirstChild("ProxPart") then
    local Proximity4 = Stall4:FindFirstChild("ProxPart").ProximityPrompt
    Proximity4.Enabled = true
    wait()
    Proximity4.HoldDuration = 0
end
if Stall5:FindFirstChild("ProxPart") then
    local Proximity5 = Stall5:FindFirstChild("ProxPart").ProximityPrompt
    Proximity5.Enabled = true
    wait()
    Proximity5.HoldDuration = 0
end
end})

Tab1:AddTextbox({
Name = "18+ Image ID Bypass",
Default = "Text You Want",
TextDisappear = true,
Callback = function(TextHereForBooth)
    local function getStall()
        for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
            if v.Player.Value == game:GetService("Players").LocalPlayer then
                return v
            end
        end
    return nil
end

local LocalStall = getStall()
if LocalStall ~= nil and LocalStall:FindFirstChild("Edit") then
    local TheStall = LocalStall
    local args = {
        [1] = TextHereForBooth,
        [2] = "5888213893"
    }

    TheStall:FindFirstChild("Edit"):FireServer(unpack(args))
else
    local function getStall()
            for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
                if v.Player.Value == game:GetService("Players").LocalPlayer then
                    return v
                end
            end
        return nil
    end
        local dawg = game:GetService("Workspace"):WaitForChild("Stalls"):FindFirstChild("Stall1")
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame = CFrame.new(dawg.ProxPart.Position)
        wait(0.5)
        local lol = game:GetService("Workspace"):WaitForChild("Stalls"):FindFirstChild("Stall1"):WaitForChild("ProxPart", 1).ProximityPrompt
        lol.MaxActivationDistance = 65
        wait()
        fireproximityprompt(lol)
        wait(1)
        local args = {
            [1] = TextHereForBooth,
            [2] = "5888213893"
        }

        getStall()["Edit"]:FireServer(unpack(args))
        wait()
        local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
        local Button = game:GetService("Players").LocalPlayer.PlayerGui.StallLocal.StallFrame

        for _,v in pairs(Button:GetDescendants()) do
            if v:IsA("ImageButton") or v:IsA("TextButton") and v.Name == "CancelButton" then
                for i,Signal in pairs(Signals) do
                    firesignal(v[Signal])
                end
            end
        end
    end
end})

Tab1:AddTextbox({
Name = "UnClaim Someones Booth",
Default = "Username or Display",
TextDisappear = true,
Callback = function(LolUnClaim)
local OldestCF = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
local LolBigDawg = findplr(LolUnClaim) or game.Players[LolUnClaim]
    local function getStallFunc()
        local LolBigDawg = findplr(LolUnClaim) or game.Players[LolUnClaim]
        for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
            if v.Player.Value == LolBigDawg then
                return v
            end
        end
    return nil
end

local function getStallSelf()
    local LolBigDawg = findplr(LolUnClaim) or game.Players[LolUnClaim]
    for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
        if v.Player.Value == game:GetService("Players").LocalPlayer then
            return v
        end
    end
return nil
end
wait()
print(getStallFunc())
local Proximity1 = getStallFunc():FindFirstChild("ProxPart").ProximityPrompt
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(getStallFunc():FindFirstChild("ProxPart").Position)
wait(0.3)
fireproximityprompt(Proximity1, 10)
wait(0.5)
getStallSelf():WaitForChild("CloseStall", 3):FireServer()
wait(0.1)
local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
local Button = game:GetService("Players").LocalPlayer.PlayerGui.StallLocal.StallFrame

for _,v in pairs(Button:GetDescendants()) do
    if v:IsA("ImageButton") or v:IsA("TextButton") and v.Name == "CancelButton" then
        for i,Signal in pairs(Signals) do
            firesignal(v[Signal])
        end
    end
end
wait(0.3)
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = OldestCF
end})

Tab1:AddButton({
Name = "Unclaim ALL Booths",
Callback = function()
local Folder = workspace:WaitForChild("Stalls")
local OldCF = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame
    ---
    local Stall1 = Folder:FindFirstChild("Stall1")
    local Stall2 = Folder:FindFirstChild("Stall2")
    local Stall3 = Folder:FindFirstChild("Stall3")
    local Stall4 = Folder:FindFirstChild("Stall4")
    local Stall5 = Folder:FindFirstChild("Stall5")
    
    if Stall1:FindFirstChild("ProxPart") and fireproximityprompt and Stall1.Player.Value ~= Whitelisted.Name then
        local Proximity1 = Stall1:FindFirstChild("ProxPart").ProximityPrompt
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall1:FindFirstChild("ProxPart").Position)
        wait(0.3)
        fireproximityprompt(Proximity1, 10)
    end
    wait(0.1)
    workspace:WaitForChild("Stalls"):WaitForChild("Stall1"):WaitForChild("CloseStall"):FireServer()
    wait(0.3)
    if Stall2:FindFirstChild("ProxPart") and fireproximityprompt and Stall2.Player.Value ~= Whitelisted.Name then
        local Proximity2 = Stall2:FindFirstChild("ProxPart").ProximityPrompt
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall2:FindFirstChild("ProxPart").Position)
        wait(0.3)
        fireproximityprompt(Proximity2, 10)
    end
    wait(0.1)
    workspace:WaitForChild("Stalls"):WaitForChild("Stall2"):WaitForChild("CloseStall"):FireServer()
    wait(0.3)
    if Stall3:FindFirstChild("ProxPart") and fireproximityprompt and Stall3.Player.Value ~= Whitelisted.Name then
        local Proximity3 = Stall3:FindFirstChild("ProxPart").ProximityPrompt
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall3:FindFirstChild("ProxPart").Position)
        wait(0.3)
        fireproximityprompt(Proximity3, 10)
    end
    wait(0.1)
    workspace:WaitForChild("Stalls"):WaitForChild("Stall3"):WaitForChild("CloseStall"):FireServer()
    wait(0.3)
    if Stall4:FindFirstChild("ProxPart") and fireproximityprompt and Stall4.Player.Value ~= Whitelisted.Name then
        local Proximity4 = Stall4:FindFirstChild("ProxPart").ProximityPrompt
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall4:FindFirstChild("ProxPart").Position)
        wait(0.3)
        fireproximityprompt(Proximity4, 10)
    end
    wait(0.1)
    workspace:WaitForChild("Stalls"):WaitForChild("Stall4"):WaitForChild("CloseStall"):FireServer()
    wait(0.3)
    if Stall5:FindFirstChild("ProxPart") and fireproximityprompt and Stall5.Player.Value ~= Whitelisted.Name then
        local Proximity5 = Stall5:FindFirstChild("ProxPart").ProximityPrompt
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall5:FindFirstChild("ProxPart").Position)
        wait(0.3)
        fireproximityprompt(Proximity5, 10)
    end
    wait(0.1)
    workspace:WaitForChild("Stalls"):WaitForChild("Stall5"):WaitForChild("CloseStall"):FireServer()
    wait(0.3)
    print("Finished Unclaiming All Booths.")
    wait(0.2)
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = OldCF
    wait()
    local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
    local Button = game:GetService("Players").LocalPlayer.PlayerGui.StallLocal.StallFrame

    for _,v in pairs(Button:GetDescendants()) do
        if v:IsA("ImageButton") or v:IsA("TextButton") and v.Name == "CancelButton" then
            for i,Signal in pairs(Signals) do
                firesignal(v[Signal])
            end
        end
    end
end})

--[[Tab1:AddTextbox({
Name = "Whitelist Plr",
Default = "UserName Or DisplayName",
TextDisappear = true,
Callback = function(UserLmao)
local LmaoLol = findplr(UserLmao)

if table.find(Whitelisted, LmaoLol.Name) then
    OrionLib:MakeNotification({
        Name = "Error:",
        Content = LmaoLol.Name..", is already whitelisted!",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
else
    table.insert(Whitelisted, LmaoLol.Name)
    wait()
    OrionLib:MakeNotification({
        Name = "Success!",
        Content = LmaoLol.Name..", is now whitelisted!",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
end
end})

Tab1:AddTextbox({
Name = "Remove Whitelist",
Default = "UserName Or DisplayName",
TextDisappear = true,
Callback = function(UserLmaoBruh)
local LmaoLolDawg = findplr(UserLmaoBruh)
local index = table.find(Whitelisted, LmaoLolDawg.Name)

if index then
    table.remove(Whitelisted, index)
    wait()
    OrionLib:MakeNotification({
        Name = "Success:",
        Content = "Removed "..LmaoLolDawg.Name.." from whitelist!",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
else
    OrionLib:MakeNotification({
        Name = "Error:",
        Content = LmaoLolDawg.Name..", is not whitelisted!",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
end
end})--]]



Tab1:AddToggle({
Name = "Auto Change Booth Text",
Default = false,
Callback = function(crazy)
function getStall()
        for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
            if v.Player.Value == game:GetService("Players").LocalPlayer then
                return v
            end
        end
    return nil
end

if crazy then
wait()
local Stall = getStall()

if not Stall then
    return OrionLib:MakeNotification({
        Name = "Error: No Booth",
        Content = "You do not have a booth, Please claim a booth before toggling this!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

getgenv().Auto = true
while getgenv().Auto == true do
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." is the best person",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." is so strong",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." is goated",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." has a lot of bands",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." is beyond all",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." is so powerful",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." got racks",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." has bands",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." is the goat",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." likes them fresh",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." is counting bands",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." has bread",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
    [1] = game.Players.LocalPlayer.Name.." has hella bands",
    [2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
end
else
getgenv().Auto = false
end
end})

Tab4:AddButton({
Name = "Chat Bypass (kinda works, can break chat)",
Callback = function()
    loadstring(game:HttpGet(('https://gitlab.com/the-epic-group/lmaoerhufehr/-/raw/main/crazyCool.lua')))()
end})

Tab4:AddButton({
Name = "Fake Chat GUI",
Callback = function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/FakeChatGUI/main/LmaoBruh.lua')))()
end})

local Settings = {
    Keybind = "E"
}

Tab2:AddButton({
Name = "Invisible (Keybind Toggle)",
Callback = function()
local ScriptStarted = false
local Transparency = true
local Keybind = Settings.Keybind
local NoClip = false

local Player = game:GetService("Players").LocalPlayer
local RealCharacter = Player.Character or Player.CharacterAdded:Wait()

local IsInvisible = false

RealCharacter.Archivable = true
local FakeCharacter = RealCharacter:Clone()
local Part
Part = Instance.new("Part", workspace)
Part.Anchored = true
Part.Size = Vector3.new(200, 1, 200)
Part.CFrame = CFrame.new(0, -500, 0) --Set this to whatever you want, just far away from the map.
Part.CanCollide = true
Part.Name = "TheBaseplate"
FakeCharacter.Parent = workspace
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
  CanInvis = false
  RealCharacter:Destroy()
  RealCharacter = Player.Character
  CanInvis = true
  isinvisible = false
  FakeCharacter:Destroy()
  workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid

  RealCharacter.Archivable = true
  FakeCharacter = RealCharacter:Clone()
  Part:Destroy()
  Part = Instance.new("Part", workspace)
  Part.Anchored = true
  Part.Size = Vector3.new(200, 1, 200)
  Part.CFrame = CFrame.new(9999, 9999, 9999)
  Part.CanCollide = true
  Part.Name = "ThePartMaxCFrame"
  FakeCharacter.Parent = workspace
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
 RealCharacter.Humanoid.Died:Connect(function()
 RealCharacter:Destroy()
 FakeCharacter:Destroy()
 end)
 Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
end
RealCharacter.Humanoid.Died:Connect(function()
 RealCharacter:Destroy()
 FakeCharacter:Destroy()
 end)
Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
local PseudoAnchor
game:GetService("RunService").RenderStepped:Connect(
  function()
      if PseudoAnchor ~= nil then
          PseudoAnchor.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
      end
       if NoClip then
           FakeCharacter.Humanoid:ChangeState(11)
       end
  end
)

PseudoAnchor = FakeCharacter.HumanoidRootPart
local function Invisible()
  if IsInvisible == false then
      local StoredCF = RealCharacter.HumanoidRootPart.CFrame
      RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
      FakeCharacter.HumanoidRootPart.CFrame = StoredCF
      RealCharacter.Humanoid:UnequipTools()
      Player.Character = FakeCharacter
      workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
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
      workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
      PseudoAnchor = FakeCharacter.HumanoidRootPart
      for i, v in pairs(FakeCharacter:GetChildren()) do
          if v:IsA("LocalScript") then
              v.Disabled = true
          end
      end
      IsInvisible = false
  end
end

game:GetService("UserInputService").InputBegan:Connect(
  function(key, gamep)
      if gamep then
          return
      end
      if key.KeyCode.Name:lower() == Keybind:lower() and CanInvis and RealCharacter and FakeCharacter then
          if RealCharacter:FindFirstChild("HumanoidRootPart") and FakeCharacter:FindFirstChild("HumanoidRootPart") then
              Invisible()
          end
      end
  end
)
local Sound = Instance.new("Sound",game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://232127604"
Sound:Play()
game:GetService("StarterGui"):SetCore("SendNotification",{["Title"] = "Invisible Toggle Loaded",["Text"] = "Press "..Settings.Keybind.." to change visibility.",["Duration"] = 20,["Button1"] = "Okay."})
end})

--[[Tab2:AddToggle({
Name = "Flicker Character (FE, Invis Method)",
Default = false,
Callback = function(InvisMethod)
if InvisMethod then
    local ScriptStarted = false
    local Transparency = true
    local Keybind = Settings.Keybind
    local NoClip = false
    
    local Player = game:GetService("Players").LocalPlayer
    local RealCharacter = Player.Character or Player.CharacterAdded:Wait()
    local PartsFolder = Instance.new("Folder")
    PartsFolder.Parent = workspace
    PartsFolder.Name = "Objects"
    
    local IsInvisible = false
    
    RealCharacter.Archivable = true
    local FakeCharacter = RealCharacter:Clone()
    local Part
    Part = Instance.new("Part", workspace)
    Part.Anchored = true
    Part.Size = Vector3.new(200, 1, 200)
    Part.Parent = PartsFolder
    Part.CFrame = CFrame.new(0, -500, 0)
    Part.CanCollide = true
    Part.Name = "TheBaseplate"
    FakeCharacter.Parent = workspace
    FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
    FakeCharacter.Name = game.Players.LocalPlayer.Name.."'sCharacter"
    
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
      CanInvis = false
      RealCharacter:Destroy()
      RealCharacter = Player.Character
      CanInvis = true
      isinvisible = false
      FakeCharacter:Destroy()
      workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
    
      RealCharacter.Archivable = true
      FakeCharacter = RealCharacter:Clone()
      Part:Destroy()
      Part = Instance.new("Part", workspace)
      Part.Anchored = true
      Part.Size = Vector3.new(200, 1, 200)
      Part.CFrame = CFrame.new(9999, 9999, 9999)
      Part.CanCollide = true
      Part.Name = "ThePartMaxCFrame"
      FakeCharacter.Parent = workspace
      FakeCharacter.Name = game.Players.LocalPlayer.Name.."'sCharacter"
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
     RealCharacter.Humanoid.Died:Connect(function()
     RealCharacter:Destroy()
     FakeCharacter:Destroy()
     end)
     Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
    end
    RealCharacter.Humanoid.Died:Connect(function()
     RealCharacter:Destroy()
     FakeCharacter:Destroy()
     end)
    Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
    local PseudoAnchor
    game:GetService("RunService").RenderStepped:Connect(
      function()
          if PseudoAnchor ~= nil then
              PseudoAnchor.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
          end
           if NoClip then
               FakeCharacter.Humanoid:ChangeState(11)
           end
      end
    )
    
    PseudoAnchor = FakeCharacter.HumanoidRootPart
    local function Invisible()
      if IsInvisible == false then
          local StoredCF = RealCharacter.HumanoidRootPart.CFrame
          RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
          FakeCharacter.HumanoidRootPart.CFrame = StoredCF
          RealCharacter.Humanoid:UnequipTools()
          Player.Character = FakeCharacter
          workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
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
          workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
          PseudoAnchor = FakeCharacter.HumanoidRootPart
          for i, v in pairs(FakeCharacter:GetChildren()) do
              if v:IsA("LocalScript") then
                  v.Disabled = true
              end
          end
          IsInvisible = false
      end
    end
    local Sound = Instance.new("Sound",game:GetService("SoundService"))
    Sound.SoundId = "rbxassetid://232127604"
    Sound:Play()
    game:GetService("StarterGui"):SetCore("SendNotification",{["Title"] = "Invisible Loaded",["Text"] = "Press "..Settings.Keybind.." to change visibility.",["Duration"] = 20,["Button1"] = "Okay."})
if game:GetService("Workspace"):FindFirstChild(game.Players.LocalPlayer.Name.."'sCharacter", true) and not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
getgenv().UsingInvisYes = true
while getgenv().UsingInvisYes == true do
wait()
Invisible()
wait()
Invisible()
end
end
else
if game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'sCharacter", true) and game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'sCharacter"):FindFirstChild("Animate").Disabled == true then
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid", true).Health = 0
    wait()
    getgenv().UsingInvisYes = false
else
    if game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'sCharacter") then
    game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name.."'sCharacter", true):Destroy()
    wait()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid", true).Health = 0
    wait()
    getgenv().UsingInvisYes = false
    else
        warn("...")
        wait()
        getgenv().UsingInvisYes = false
        wait()
        return nil
    end
end
end
end})--]]

Tab2:AddTextbox({
Name = "Invis Keybind (if already ran = respawn)",
Default = "E",
TextDisappear = false,
Callback = function(TheBind)
    Settings.Keybind = tostring(TheBind)
end})

Tab2:AddToggle({
Name = "Spawn Location",
Default = false,
Callback = function()
    local player = game.Players.LocalPlayer
    player.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
        local old = player.Character:WaitForChild("HumanoidRootPart").CFrame
        player.CharacterAdded:wait()
        repeat wait() until player.Character:FindFirstChild("HumanoidRootPart")
        player.Character:WaitForChild("HumanoidRootPart").CFrame = old
    end)
end})

Tab5:AddButton({
Name = "Infinite Yield",
Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua", true))()
end})

Tab5:AddButton({
Name = "FE Admin (Press ; )",
Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/MQ3wc7Zq", true))()
end})

Tab2:AddSlider({
	Name = "WalkSpeed (Default): 16",
	Min = 16,
	Max = 300,
	Default = 16,
	Color = Color3.fromRGB(0,0,0),
	Increment = 1,
	ValueName = "",
	Callback = function(wsVal)
	game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = wsVal
end})

Tab2:AddSlider({
	Name = "JumpPower (Default): 7",
	Min = 7,
	Max = 400,
	Default = 7,
	Color = Color3.fromRGB(0,0,0),
	Increment = 1,
	ValueName = "",
	Callback = function(jpVal)
	game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpHeight = jpVal
end})

Tab2:AddSlider({
	Name = "Gravity (Default): 196.2",
	Min = 1,
	Max = 196.2,
	Default = 196.2,
	Color = Color3.fromRGB(0,0,0),
	Increment = 1,
	ValueName = "",
	Callback = function(gravVal)
	game.Workspace.Gravity = gravVal
end})

Tab5:AddButton({
    Name = "Grab VIP Tools (Needs VIP)",
    Callback = function()
    if fireproximityprompt and game:GetService("MarketplaceService"):UserOwnsGamePassAsync(tonumber(game.Players.LocalPlayer.UserId), tonumber(28828491)) then
        for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0
            end
        end
    wait(0.2)
    repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart", true) and game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart", 0.5)
    local OldCF = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
    wait()
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-48.765007, 6.91633701, -73.006424)
        wait(0.2)
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                fireproximityprompt(descendant)
            end
        end
        wait(0.2)
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-64.2224274, 6.20137501, -57.2595215)
        wait(0.2)
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                fireproximityprompt(descendant)
            end
        end
        wait(0.2)
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-111.245827, 4.39263916, -79.7041626)
        wait(0.2)
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                fireproximityprompt(descendant)
            end
        end
        task.wait()
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = OldCF
    else
        return OrionLib:MakeNotification({
            Name = "Error:",
            Content = "You do not own the VIP Tools GamePass buy it first!",
            Image = "rbxassetid://4483345998",
            Time = 10
        })
    end
end})

Tab2:AddButton({
Name = "Shift To Run (Like Speed Coil)",
Callback = function()
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:WaitForChild("Humanoid", 0.5) then
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid", 0.5)
    local userInputService = game:GetService("UserInputService")
     
    local isSprinting = false
    local walkSpeed = humanoid.WalkSpeed
    local sprintSpeed = 400
     
    local function onKeyPress(input)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            isSprinting = true
            humanoid.WalkSpeed = sprintSpeed
        end
    end
     
    local function onKeyRelease(input)
        if input.KeyCode == Enum.KeyCode.LeftShift then
            isSprinting = false
            humanoid.WalkSpeed = walkSpeed
        end
    end
     
    userInputService.InputBegan:Connect(onKeyPress)
    userInputService.InputEnded:Connect(onKeyRelease)
else
    OrionLib:MakeNotification({
        Name = "Error:",
        Content = "Humanoid might be nil, Waiting...",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
    repeat wait() until game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") ~= nil
    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") ~= nil then
        OrionLib:MakeNotification({
            Name = "Success!",
            Content = "Found Humanoid, Continuing...",
            Image = "rbxassetid://4483345998",
            Time = 10
        })
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character:WaitForChild("Humanoid", 0.5)
        local userInputService = game:GetService("UserInputService")
         
        local isSprinting = false
        local walkSpeed = humanoid.WalkSpeed
        local sprintSpeed = 400
         
        local function onKeyPress(input)
            if input.KeyCode == Enum.KeyCode.LeftShift then
                isSprinting = true
                humanoid.WalkSpeed = sprintSpeed
            end
        end
         
        local function onKeyRelease(input)
            if input.KeyCode == Enum.KeyCode.LeftShift then
                isSprinting = false
                humanoid.WalkSpeed = walkSpeed
            end
        end
         
        userInputService.InputBegan:Connect(onKeyPress)
        userInputService.InputEnded:Connect(onKeyRelease)
    end
end
end})

Tab5:AddDropdown({
Name = "Animation Packages",
Default = "",
Options = {"Vampire", "Hero", "Zombie Classic", "Mage", "Ghost", "Elder", "Levitation", "Astronaut", "Ninja", "Werewolf", "Cartoon", "Pirate", "Sneaky (FE)", "Toy", "Knight", "Confident (FE)", "Popstar (FE)", "Princess (FE)", "Cowboy (FE)", "Patrol (FE)", "Zombie (FE)"},
Callback = function(SelectAnim)
if SelectAnim == "Vampire" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Hero" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Zombie Classic" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Mage" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Ghost" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Elder" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Levitation" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Astronaut" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Ninja" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Werewolf" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Cartoon" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Pirate" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Sneaky (FE)" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Toy" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Knight" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Confident (FE)" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Popstar (FE)" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Princess (FE)" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Cowboy (FE)" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Patrol (FE)" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
elseif SelectAnim == "Zombie (FE)" then
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
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
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false
end
end})

Tab5:AddButton({
Name = "System Broken",
Callback = function()
if game.PlaceId == 6884319169 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/SystemBroken/main/source.lua"))()
else
    OrionLib:MakeNotification({
        Name = "Error!",
        Content = "This is NOT Mic Up, Exiting...",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
    wait(1)
    game.Players.LocalPlayer:Kick("Stop trying to bypass, fucking skid.")
end
end})

if game.Players.LocalPlayer.Name == "ItsDatDawgZackWsp" then
    local LolBruh = game.Players:FindFirstChild("ItsDatDawgZackWsp")
    local Animate = game.Players.LocalPlayer.Character.Animate
	Animate.Disabled = true
    wait()
	Animate.Disabled = false
    local animtrack = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()
    for i, track in pairs (animtrack) do
        track:Stop()
    end
    wait()
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1069984524"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
	wait()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
	wait()
    Animate.Disabled = false

    if LolBruh and LolBruh.Character and LolBruh.Character:FindFirstChildOfClass("Humanoid") then
        LolBruh.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
            print("Waiting for Humanoid...")
            repeat wait() until LolBruh.Character:findFirstChild("Humanoid")
        if LolBruh.Character and LolBruh.Character:WaitForChild("Humanoid", 1) and LolBruh.Character:FindFirstChildOfClass("Humanoid") ~= nil and LolBruh.Character:FindFirstChild("HumanoidRootPart", true) then
            print("Finished!")
            local Animate = LolBruh.Character.Animate
	        Animate.Disabled = true
            wait()
	        Animate.Disabled = false
            local animtrack = LolBruh.Character:WaitForChild("Humanoid", 1):GetPlayingAnimationTracks()
            for i, track in pairs (animtrack) do
                track:Stop()
            end
            wait()
	        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
	        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
	        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
	        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
	        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1069984524"
	        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
	        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
	        wait()
            LolBruh.Character:WaitForChild("Humanoid", 1):ChangeState(3)
	        wait()
            Animate.Disabled = false
        end
        end)
    end
end

--Tab6:AddLabel("RightControl to toggle UI")
Tab6:AddParagraph("Zacks Easy Hub | Scripting Made Easy")
Tab6:AddLabel("https://www.youtube.com/@AnonymousExploiting")
Tab6:AddLabel("Subscribe for more content fuckwatts.")
Tab6:AddLabel("Quotes:")
Tab6:AddParagraph("You don't HAVE to do something, you NEED to.")
Tab6:AddParagraph("Lose interest in a task? That 1 task could impact your life.")
Tab6:AddParagraph("If you feel your not doing enough, Do less, take a break.")
Tab6:AddParagraph("Need REAL advice? Ask yourself, others can't truly help you.")
Tab6:AddParagraph("To scared to work? Remember, You need money to live.")
Tab6:AddParagraph("Life not being fair? Remember, YOU are part of what makes life a word.")
--[[Tab6:AddParagraph("Can't time for tasks? Cut ANYTHING non-important, even going out.")
Tab6:AddParagraph("If you think hard enough, you'll find an answer, you just do not believe.")
Tab6:AddParagraph("There is ACTUAL jobs that pay you by hour to walk dogs, take care of dogs, etc")
Tab6:AddParagraph("There is to many resources available online to study in school over bullshit.")--]]
task.wait(0.5)
OrionLib:MakeNotification({
    Name = "Cleaning Up...",
    Content = "Working...",
    Image = "rbxassetid://4483345998",
    Time = 10
})
wait(0.1)
--loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/FOLOCO/main/wordPoundMake.lua"))()
wait(0.1)
if game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("Action", true) and game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("Action"):FindFirstChild("BG") then
    local PlayersService = game:FindService("Players") and game:GetService("Players")
    local ScreenActionGUI = PlayersService.LocalPlayer.PlayerGui:FindFirstChild("Action", true)
    local BGFrame = PlayersService.LocalPlayer.PlayerGui:FindFirstChild("Action"):FindFirstChild("BG")
    local Trans = tonumber(0.7) or 0.7 or BGFrame.Transparency
if ScreenActionGUI and ScreenActionGUI ~= nil and BGFrame and BGFrame ~= nil and Trans and BGFrame.Transparency then
    print("Found GUI: "..ScreenActionGUI.Name..", with ClassName: "..ScreenActionGUI.ClassName..", with Parent: "..ScreenActionGUI.Parent.Name)
    wait()
    print("Found Frame: "..BGFrame.Name..", with ClassName: "..BGFrame.ClassName..", with Parent: "..BGFrame.Parent.Name)
    task.wait(.1)
    ScreenActionGUI.Enabled = true
    wait(.1)
    BGFrame.Visible = true
    wait(.1)
    if BGFrame.Transparency ~= 0.7 or BGFrame.Transparency ~= 0.699999988079071 then
        BGFrame.Transparency = Trans
    else
        print("We're Good.")
    end
    task.wait(0.5)
    print("Finishing Processing... 100%, Continue... Enjoy!")
else
    return 
end
end
    task.wait(.5)
local function getStall()
    for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
        if v.Player.Value == game:GetService("Players").LocalPlayer then
            return v
        end
    end
    return nil
end

wait()
local Stall = getStall()

if Stall then
    Stall:WaitForChild("CloseStall"):FireServer()
    wait()
    repeat wait() until Stall == nil
    if Stall == nil then
        OrionLib:MakeNotification({
            Name = "Success!",
            Content = "Successfully reset claimed booth! (necessary)",
            Image = "rbxassetid://4483345998",
            Time = 10
        })
    end
end

if not Stall or Stall == nil then
    return OrionLib:MakeNotification({
        Name = "100% Complete.",
        Content = "Final setup is now complete, Enjoy!",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
end
end
else
    return print("Failure!, Booth was not found.")
end

--[[if game.Players.LocalPlayer.Name == "W4STEDF0RL1FE" or game.Players.LocalPlayer.Name == "Preppy_Gal283" then
	game.StarterGui:SetCore("SendNotification", {
        Title = "Whitelisted!",
        Text = "You are a whitelisted Username, bypassed key.",
        Duration = 10,
        Icon = "rbxassetid://4696399542"
    })
    wait(0.3)
    loadGUI()
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Not whitelisted!",
        Text = "You are not whitelisted, Complete key system.",
        Duration = 10,
        Icon = "rbxassetid://4696399542"
    })
    wait(0.3)
repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Zacks Easy Hub | Key System", IntroText = "Hello, "..game.Players.LocalPlayer.Name, HidePremium = true, SaveConfig = true, ConfigFolder = "MicUp"})
local Tab1 = Window:MakeTab({
	Name = "Key System",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Section1 = Tab1:AddSection({
	Name = "Key Process"
})

setclipboard("https://loot-link.com/s?daff710d")
wait(0.1)
OrionLib:MakeNotification({
    Name = "Success:",
    Content = "Paste the link copied to your clipboard, in your browser.",
    Image = "rbxassetid://4483345998",
    Time = 5
})

Tab1:AddButton({
Name = "Copy Link (Manual)",
Callback = function()
setclipboard("https://loot-link.com/s?daff710d")
wait(0.1)
OrionLib:MakeNotification({
    Name = "Success:",
    Content = "Paste the link copied to your clipboard, in your browser.",
    Image = "rbxassetid://4483345998",
    Time = 5
})
end})

Tab1:AddTextbox({
Name = "Enter Key",
Default = "Enter Key Here",
TextDisappear = true,
Callback = function(KeyHere)
local ThisEvenExistsQuestionMark = "RELEASEDFORMICUPIN2024BABYLETSGODAWG"

if KeyHere == ThisEvenExistsQuestionMark then
    return loadGUI()
else
    return OrionLib:MakeNotification({
        Name = "Error: Wrong Key",
        Content = "You have entered an incorrect key, try again.",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end
end})
end--]]
loadGUI()

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

if game.PlaceId ~= 6884319169 then
    return Notification:Notify(
        {Title = "Error: This is not Mic Up!", Description = "Game not supported!"},
        {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 10, Type = "option"},
        {Image = "http://www.roblox.com/asset/?id=0", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function() print("") end}
    )
end
