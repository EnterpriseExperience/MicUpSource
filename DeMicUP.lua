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
getgenv().gethui = function()
    return game:GetService("CoreGui")
end
local Window = OrionLib:MakeWindow({Name = "Zacks Easy Hub | "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.." | Executed At: "..formattedTime, IntroText = "Hello, "..game.Players.LocalPlayer.Name, HidePremium = false, SaveConfig = true, ConfigFolder = "MICUP"})
-- IF YOU ARE READING THIS, THIS HUB WILL UNDERGO MASSIVE CHANGES SOON!, UI ALSO SHOULD CHANGE TO! SO YOU HAVE FOUND THIS HINT EARLY!
local Tab1 = Window:MakeTab({
Name = "Home",
Icon = "rbxassetid://7733960981",
PremiumOnly = false
})
local Section1 = Tab1:AddSection({
Name = "Home Page"
})
local Tab2 = Window:MakeTab({
Name = "Character",
Icon = "rbxassetid://7743871002",
PremiumOnly = false
})
local Section2 = Tab2:AddSection({
Name = "Character Tools"
})
local Tab4 = Window:MakeTab({
Name = "Chat Tools",
Icon = "rbxassetid://7734021300",
PremiumOnly = false
})
local Section4 = Tab4:AddSection({
Name = "Tools For Modifying/Manipulating Chat"
})
local Tab5 = Window:MakeTab({
Name = "Fun Tools",
Icon = "rbxassetid://7733954760",
PremiumOnly = false
})
local Section5 = Tab5:AddSection({
Name = "Extra Fun Tools"
})
local Tab9 = Window:MakeTab({
Name = "Lighting",
Icon = "rbxassetid://8997384977",
PremiumOnly = false
})
local Section9 = Tab9:AddSection({
Name = "Lighting And Sky Stuff?"
})
local Tab7 = Window:MakeTab({
Name = "Bypassers",
Icon = "rbxassetid://7733771472",
PremiumOnly = false
})
local Section8 = Tab7:AddSection({
Name = "Bypassing Filters"
})
local Tab6 = Window:MakeTab({
Name = "Information",
Icon = "rbxassetid://7734022107",
PremiumOnly = false
})
local Section6 = Tab6:AddSection({
Name = "Successful Quotes And Info"
})
wait()
-- Removed due to massive lag/crashes/crashing.
wait(0.5)
OrionLib:MakeNotification({
Name = "Hold On.",
Content = "We are modifying Lighting...",
Image = "rbxassetid://4483345998",
Time = 10
})
wait()
local lighting = game:GetService("Lighting")

lighting.ClockTime = 0
wait(0.2)
lighting.ClockTime = 3
wait(0.2)
lighting.ClockTime = 9
wait(0.2)
lighting.Brightness = 3
wait(0.2)
lighting.Brightness = 0
wait(0.2)
lighting.ClockTime = 8
repeat wait() until lighting.ClockTime == 8
if lighting.ClockTime == 8 then
OrionLib:MakeNotification({
    Name = "Success!",
    Content = "We have configured Lighting (for the script)",
    Image = "rbxassetid://4483345998",
    Time = 5
})
else
OrionLib:MakeNotification({
    Name = "Failed!",
    Content = "An error has occurred, we're sorry.",
    Image = "rbxassetid://4483345998",
    Time = 5
})
end
wait()

-- Replaced This retarded version list shit with the GitHub, so go check that you fucking pussy.

local Players = game:GetService("Players")
local whitelist = {}
local player = Players.LocalPlayer

-- Don't mess with these as I am not to sure on them working correctly.

local function addToWhitelist(username)
local foundPlayer = Players:FindFirstChild(username)

if foundPlayer then
    whitelist[foundPlayer.UserId] = true
    wait()
    return OrionLib:MakeNotification({
        Name = "Success!: Whitelisted",
        Content = "Player was successfully whitelisted into table!",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
else
    return print("Player not found: " .. username)
end
end

local function removeFromWhitelist(username)
local foundPlayer = Players:FindFirstChild(username)

if foundPlayer then
    if whitelist[foundPlayer.UserId] then
        whitelist[foundPlayer.UserId] = nil
        wait()
        return OrionLib:MakeNotification({
            Name = "Success!: Removed",
            Content = "Player was successfully removed from whitelist!",
            Image = "rbxassetid://4483345998",
            Time = 10
        })
    else
        return 
    end
else
    return 
end
end
wait()
function ClaimStall1()
local Folder = workspace:WaitForChild("Stalls")
---
local Stall1 = Folder:FindFirstChild("Stall1")
local Stall2 = Folder:FindFirstChild("Stall2")
local Stall3 = Folder:FindFirstChild("Stall3")
local Stall4 = Folder:FindFirstChild("Stall4")
local Stall5 = Folder:FindFirstChild("Stall5")
if Stall1:FindFirstChild("ProxPart") and fireproximityprompt and Stall1.Player.Value ~= whitelist[game.Players[Stall3:FindFirstChild("Player").Value].UserId] then
    local Proximity1 = Stall1:FindFirstChild("ProxPart").ProximityPrompt
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall1:FindFirstChild("ProxPart").Position)
    wait(0.3)
    fireproximityprompt(Proximity1, 10)
    wait(0.5)
    Stall1:WaitForChild("CloseStall"):FireServer()
end
end

function ClaimStall2()
local Folder = workspace:WaitForChild("Stalls")
---
local Stall1 = Folder:FindFirstChild("Stall1")
local Stall2 = Folder:FindFirstChild("Stall2")
local Stall3 = Folder:FindFirstChild("Stall3")
local Stall4 = Folder:FindFirstChild("Stall4")
local Stall5 = Folder:FindFirstChild("Stall5")
if Stall2:FindFirstChild("ProxPart") and fireproximityprompt and Stall2.Player.Value ~= whitelist[game.Players[Stall2:FindFirstChild("Player").Value].UserId] then
    local Proximity2 = Stall2:FindFirstChild("ProxPart").ProximityPrompt
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall2:FindFirstChild("ProxPart").Position)
    wait(0.3)
    fireproximityprompt(Proximity2, 10)
    wait(0.5)
    Stall2:WaitForChild("CloseStall"):FireServer()
end
end

function ClaimStall3()
local Folder = workspace:WaitForChild("Stalls")
---
local Stall1 = Folder:FindFirstChild("Stall1")
local Stall2 = Folder:FindFirstChild("Stall2")
local Stall3 = Folder:FindFirstChild("Stall3")
local Stall4 = Folder:FindFirstChild("Stall4")
local Stall5 = Folder:FindFirstChild("Stall5")
if Stall3:FindFirstChild("ProxPart") and fireproximityprompt and Stall3.Player.Value ~= whitelist[game.Players[Stall3:FindFirstChild("Player").Value].UserId] then
    local Proximity3 = Stall3:FindFirstChild("ProxPart").ProximityPrompt
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall3:FindFirstChild("ProxPart").Position)
    wait(0.3)
    fireproximityprompt(Proximity3, 10)
    wait(0.5)
    Stall3:WaitForChild("CloseStall"):FireServer()
end
end

function ClaimStall4()
local Folder = workspace:WaitForChild("Stalls")
---
local Stall1 = Folder:FindFirstChild("Stall1")
local Stall2 = Folder:FindFirstChild("Stall2")
local Stall3 = Folder:FindFirstChild("Stall3")
local Stall4 = Folder:FindFirstChild("Stall4")
local Stall5 = Folder:FindFirstChild("Stall5")
if Stall4:FindFirstChild("ProxPart") and fireproximityprompt and Stall4.Player.Value ~= whitelist[game.Players[Stall4:FindFirstChild("Player").Value].UserId] then
    local Proximity4 = Stall4:FindFirstChild("ProxPart").ProximityPrompt
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall4:FindFirstChild("ProxPart").Position)
    wait(0.3)
    fireproximityprompt(Proximity4, 10)
    wait(0.5)
    Stall4:WaitForChild("CloseStall"):FireServer()
end
end

function ClaimStall5()
local Folder = workspace:WaitForChild("Stalls")
---
local Stall1 = Folder:FindFirstChild("Stall1")
local Stall2 = Folder:FindFirstChild("Stall2")
local Stall3 = Folder:FindFirstChild("Stall3")
local Stall4 = Folder:FindFirstChild("Stall4")
local Stall5 = Folder:FindFirstChild("Stall5")
if Stall5:FindFirstChild("ProxPart") and fireproximityprompt and Stall5.Player.Value ~= whitelist[game.Players[Stall5:FindFirstChild("Player").Value].UserId] then
    local Proximity5 = Stall5:FindFirstChild("ProxPart").ProximityPrompt
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall5:FindFirstChild("ProxPart").Position)
    wait(0.3)
    fireproximityprompt(Proximity5, 10)
    wait(0.5)
    Stall5:WaitForChild("CloseStall"):FireServer()
end
end
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
function isNumber(str)
if tonumber(str) ~= nil then
    return true
end
end
wait()
Tab1:AddButton({
Name = "Steal Any Booth (Go To It)",
Callback = function()
local Folder = workspace:WaitForChild("Stalls")

local function setupProximityPrompt(stall)
    if stall:FindFirstChild("ProxPart") then
        local ProximityPrompt = stall:FindFirstChild("ProxPart").ProximityPrompt
        ProximityPrompt.Enabled = true
        wait()
        ProximityPrompt.HoldDuration = 0

        ProximityPrompt:GetPropertyChangedSignal("Enabled"):Connect(function()
            if not ProximityPrompt.Enabled then
                ProximityPrompt.Enabled = true
            end
        end)
    end
end

local stalls = {
    Folder:FindFirstChild("Stall1"),
    Folder:FindFirstChild("Stall2"),
    Folder:FindFirstChild("Stall3"),
    Folder:FindFirstChild("Stall4"),
    Folder:FindFirstChild("Stall5")
}

for _, stall in ipairs(stalls) do
    if stall then
        setupProximityPrompt(stall)
    end
end    
end})

Tab7:AddToggle({
Name = "Auto Claim/Steal Booth (for hackers?)",
Default = false,
Callback = function(AutoClaimStand)
if AutoClaimStand then
getgenv().ClaimTheStand = true
while getgenv().ClaimTheStand == true do
wait()
local Folder = workspace:WaitForChild("Stalls")
---
local Stall1 = Folder:FindFirstChild("Stall1")
local Stall2 = Folder:FindFirstChild("Stall2")
local Stall3 = Folder:FindFirstChild("Stall3")
local Stall4 = Folder:FindFirstChild("Stall4")
local Stall5 = Folder:FindFirstChild("Stall5")

if Stall1:FindFirstChild("Icon"):FindFirstChild("Decal").Texture ~= "rbxthumb://type=Asset&id=5888213893&w=420&h=420" then
local Proximity1 = Stall1:FindFirstChild("ProxPart").ProximityPrompt
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall1:FindFirstChild("ProxPart").Position)
wait(0.3)
fireproximityprompt(Proximity1, 15)
wait()
local TheStall = LocalStall
local args = {
    [1] = "Stolen By: "..game.Players.LocalPlayer.Name,
    [2] = "5888213893"
}

Stall1:FindFirstChild("Edit"):FireServer(unpack(args))
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
else
print("Somebody bypassed the image with a script, claiming a different one...")
wait()
local Proximity2 = Stall2:FindFirstChild("ProxPart").ProximityPrompt
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Stall2:FindFirstChild("ProxPart").Position)
wait(0.3)
fireproximityprompt(Proximity2, 15)
wait()
for i, v in pairs(game.Players:GetPlayers()) do
    v.Character:FindFirstChild("HumanoidRootPart").Transparency = 1
end
wait()
local TheStall = Stall2
local args = {
    [1] = "Stolen By: "..game.Players.LocalPlayer.Name,
    [2] = "5888213893"
}

Stall2:FindFirstChild("Edit"):FireServer(unpack(args))
wait()
for i, v in pairs(game.Players:GetPlayers()) do
    v.Character:FindFirstChild("HumanoidRootPart").Transparency = 1
end
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
wait(0.1)
workspace:WaitForChild("Stalls"):WaitForChild("Stall2"):WaitForChild("CloseStall"):FireServer()
end
else
getgenv().ClaimTheStand = false
end
end})

Tab7:AddButton({
Name = "Anti Stand Stealer (for hackers)",
Callback = function()
local player = game.Players.LocalPlayer

local function getStall()
    for i, v in pairs(workspace.Stalls:GetChildren()) do
        if v:FindFirstChild("Player") and v.Player.Value == player then
            return v
        end
    end
    return nil
end

local function fireProximityPrompt(prompt)
    if prompt then
        fireproximityprompt(prompt)
    end
end

local function makeCharacterInvisible(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
            part.CanCollide = false
        end
    end
end

local function makeCharacterVisible(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 0
            part.CanCollide = true
        end
    end
end

local function makeAllPlayersInvisible()
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            makeCharacterInvisible(otherPlayer.Character)
        end
    end
end

local function makeAllPlayersVisible()
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            makeCharacterVisible(otherPlayer.Character)
        end
    end
end

local function monitorPlayerStall()
    local ownedStall = getStall()

    if ownedStall then
        local icon = ownedStall:FindFirstChild("Icon")
        if icon and icon:FindFirstChild("Decal") then
            local decal = icon.Decal

            decal:GetPropertyChangedSignal("Texture"):Connect(function()
                makeAllPlayersInvisible()
                wait(0.3)
                local proximityPrompt = ownedStall:FindFirstChild("ProxPart").ProximityPrompt
                fireProximityPrompt(proximityPrompt)
                wait(0.3)
                makeAllPlayersVisible()
            end)
        end
    end
end

monitorPlayerStall()    
end})

Tab1:AddToggle({
Name = "Note Bypass (not working!?)",
Default = false,
Callback = function(CrazyAhText)
if CrazyAhText then
getgenv().AighDawg = true
while getgenv().AighDawg == true do
wait()
local args = {
[1] = "yooo"
}

game:GetService("ReplicatedStorage"):WaitForChild("SubmitNote"):FireServer(unpack(args))
end
else
getgenv().AighDawg = false
end
end})

Tab2:AddToggle({
Name = "Freeze YOUR Character (FE)",
Default = false,
Callback = function(freezeChar)
if freezeChar then
getgenv().FreezingChar = true
if getgenv().FreezingChar == true then
game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true
end
else
getgenv().FreezingChar = false
wait()
game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = false
end
end})

Tab5:AddButton({
Name = "Players Invisible Fix",
Callback = function()
local function makeCharacterVisible(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 0
        end
    end
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer and player.Character then
        makeCharacterVisible(player.Character)
    end
end
wait()
local function makePartInvisible(part)
    part.Transparency = 1
end

local function makeHumanoidRootPartInvisible(character)
    local player = game.Players:GetPlayerFromCharacter(character)
    if player and player ~= game.Players.LocalPlayer then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            makePartInvisible(humanoidRootPart)
        end
    end
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        makeHumanoidRootPartInvisible(player.Character)
    end
end
end})

local BadWordsToggle = Tab7:AddToggle({
Name = "Bad Words Cycle (Patched!)",
Default = false,
Callback = function(Cussing)
if Cussing then
getgenv().Cuss = true
while getgenv().Cuss == true do
wait(1)
local function getStall()
for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
    if v.Player.Value == game:GetService("Players").LocalPlayer then
        return v
    end
end
return nil
end

if getStall() == nil then
getgenv().Cuss = false
wait()
OrionLib:MakeNotification({
    Name = "Error: No Booth!",
    Content = "Claim a Booth, Waiting...",
    Image = "rbxassetid://4483345998",
    Time = 10
})
wait(0.2)
repeat wait() until getStall() ~= nil and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
if getStall() ~= nil and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") then
    getgenv().Cuss = true
end
end

local letters = {
["A"] = "🅰", ["a"] = "🅰", ["B"] = "🅱", ["b"] = "🅱", ["C"] = "🅲", ["c"] = "🅲", ["D"] = "🅳", ["d"] = "🅳", ["E"] = "🅴", ["e"] = "🅴", ["F"] = "🅵", ["f"] = "🅵", ["G"] = "🅶", ["g"] = "🅶", ["H"] = "🅷", ["h"] = "🅷", ["I"] = "🅸", ["i"] = "🅸", ["J"] = "🅹", ["j"] = "🅹", ["K"] = "🅺", ["k"] = "🅺", ["L"] = "🅻", ["l"] = "🅻", ["M"] = "🅼", ["m"] = "🅼", ["N"] = "🅽", ["n"] = "🅽", ["O"] = "🅾", ["o"] = "🅾", ["P"] = "🅿", ["p"] = "🅿", ["Q"] = "🆀", ["q"] = "🆀", ["R"] = "🆁", ["r"] = "🆁", ["S"] = "🆂", ["s"] = "🆂", ["T"] = "🆃", ["t"] = "🆃", ["U"] = "🆄", ["u"] = "🆄", ["V"] = "🆅", ["v"] = "🆅", ["W"] = "🆆", ["w"] = "🆆", ["X"] = "🆇", ["x"] = "🆇", ["Y"] = "🆈", ["y"] = "🆈", ["Z"] = "🆉", ["z"] = "🆉", [" "] = " "
}

local function replace(str, find_str, replace_str) 
local escaped_find_str = find_str:gsub("[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") 
return str:gsub(escaped_find_str, replace_str) 
end

local function filter(message)
for search, replacement in pairs(letters) do
    message = replace(message, search, replacement)
end
return message
end

local function sendChat(msg)
local args = {
    [1] = filter(msg),
    [2] = "5888213893"
}

getStall():FindFirstChild("Edit"):FireServer(unpack(args))
end
wait()
sendChat("Fuck")
wait(1)
sendChat("Bitch")
wait(1)
sendChat("Retard")
wait(1)
sendChat("Asshole")
wait(1)
sendChat("Autism")
wait(1)
sendChat("Black")
wait(1)
sendChat("Nigga")
wait(1)
sendChat("Nigger")
wait(1)
sendChat("Cunt")
wait(1)
sendChat("Asswipe")
wait(1)
sendChat("Butt")
wait(1)
sendChat("Pussy")
wait(1)
sendChat("Coochie")
wait(1)
sendChat("Sex")
wait(1)
sendChat("Cuck")
wait(1)
sendChat("Cuckold")
wait(1)
sendChat("Porn")
wait(1)
sendChat("Hentai")
wait(1)
sendChat("Suck Dick")
wait(1)
sendChat("Kill Yourself")
wait(1)
sendChat("Rape")
wait(1)
sendChat("sexual abuse")
wait(1)
sendChat("Anal")
wait(1)
sendChat("Tight Pussy")
wait(1)
sendChat("Petite Asian Bitch")
wait(1)
sendChat("Raped before 12")
wait(1)
sendChat("Choke on a cock")
wait(1)
sendChat("Big Ballsack")
wait(1)
sendChat("Klu Klux Klan")
wait(1)
sendChat("Lick my nuts")
end
else
getgenv().Cuss = false
end
end})

local TextboxBoothBypass = Tab7:AddTextbox({
Name = "Booth Bypasser (Patched! Reworking)",
Default = "Text Here",
TextDisappear = true,
Callback = function(TextToBypass)
local function getStall()
for i,v in pairs(game:GetService("Workspace").Stalls:GetChildren()) do
    if v.Player.Value == game:GetService("Players").LocalPlayer then
        return v
    end
end
return nil
end

local letters = {
["A"] = "🅰", ["a"] = "🅰", ["B"] = "🅱", ["b"] = "🅱", ["C"] = "🅲", ["c"] = "🅲", ["D"] = "🅳", ["d"] = "🅳", ["E"] = "🅴", ["e"] = "🅴", ["F"] = "🅵", ["f"] = "🅵", ["G"] = "🅶", ["g"] = "🅶", ["H"] = "🅷", ["h"] = "🅷", ["I"] = "🅸", ["i"] = "🅸", ["J"] = "🅹", ["j"] = "🅹", ["K"] = "🅺", ["k"] = "🅺", ["L"] = "🅻", ["l"] = "🅻", ["M"] = "🅼", ["m"] = "🅼", ["N"] = "🅽", ["n"] = "🅽", ["O"] = "🅾", ["o"] = "🅾", ["P"] = "🅿", ["p"] = "🅿", ["Q"] = "🆀", ["q"] = "🆀", ["R"] = "🆁", ["r"] = "🆁", ["S"] = "🆂", ["s"] = "🆂", ["T"] = "🆃", ["t"] = "🆃", ["U"] = "🆄", ["u"] = "🆄", ["V"] = "🆅", ["v"] = "🆅", ["W"] = "🆆", ["w"] = "🆆", ["X"] = "🆇", ["x"] = "🆇", ["Y"] = "🆈", ["y"] = "🆈", ["Z"] = "🆉", ["z"] = "🆉", [" "] = " "
}

local function replace(str, find_str, replace_str) 
local escaped_find_str = find_str:gsub("[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") 
return str:gsub(escaped_find_str, replace_str) 
end

local function filter(message)
for search, replacement in pairs(letters) do
    message = replace(message, search, replacement)
end
return message
end

local function sendChat(msg)
local args = {
    [1] = filter(msg),
    [2] = "5888213893"
}
    
getStall():FindFirstChild("Edit"):FireServer(unpack(args))
end

sendChat(TextToBypass)

if getStall() ==  nil then
OrionLib:MakeNotification({
    Name = "Error: No Booth",
    Content = "You do not have a booth, Claim a booth, Waiting...",
    Image = "rbxassetid://4483345998",
    Time = 5
})
wait(0.5)
repeat wait() until getStall() ~= nil and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
if getStall() ~= nil then
    sendChat(TextToBypass)
end
end
end})

Tab4:AddTextbox({
Name = "Chat Bypass (Patched! Reworking)",
Default = "Bypass Text",
TextDisappear = true,
Callback = function(Bypass)
local letters = {
    ["A"] = "🅰", ["a"] = "🅰", ["B"] = "🅱", ["b"] = "🅱", ["C"] = "🅲", ["c"] = "🅲", ["D"] = "🅳", ["d"] = "🅳", ["E"] = "🅴", ["e"] = "🅴", ["F"] = "🅵", ["f"] = "🅵", ["G"] = "🅶", ["g"] = "🅶", ["H"] = "🅷", ["h"] = "🅷", ["I"] = "🅸", ["i"] = "🅸", ["J"] = "🅹", ["j"] = "🅹", ["K"] = "🅺", ["k"] = "🅺", ["L"] = "🅻", ["l"] = "🅻", ["M"] = "🅼", ["m"] = "🅼", ["N"] = "🅽", ["n"] = "🅽", ["O"] = "🅾", ["o"] = "🅾", ["P"] = "🅿", ["p"] = "🅿", ["Q"] = "🆀", ["q"] = "🆀", ["R"] = "🆁", ["r"] = "🆁", ["S"] = "🆂", ["s"] = "🆂", ["T"] = "🆃", ["t"] = "🆃", ["U"] = "🆄", ["u"] = "🆄", ["V"] = "🆅", ["v"] = "🆅", ["W"] = "🆆", ["w"] = "🆆", ["X"] = "🆇", ["x"] = "🆇", ["Y"] = "🆈", ["y"] = "🆈", ["Z"] = "🆉", ["z"] = "🆉", [" "] = " "
}

local function replace(str, find_str, replace_str) 
    local escaped_find_str = find_str:gsub("[%-%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") 
    return str:gsub(escaped_find_str, replace_str) 
end

local function filter(message)
    for search, replacement in pairs(letters) do
        message = replace(message, search, replacement)
    end
    return message
end

local function SendMSG(msg)
    local TextChat = game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

    TextChat:SendAsync(filter(msg))
end

SendMSG(Bypass)
end})

Tab7:AddTextbox({
Name = "18+ Booth Bypass",
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
wait()
if fireproximityprompt and getStallFunc() ~= nil and getStallFunc() ~= whitelist[game.Players[LolUnClaim.Player.Value].UserId] then
local Players = game:GetService("Players")

local function makeInvisible(character)
if character then
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("SurfaceGui") then
            part.Transparency = 1
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end
end
end

local localPlayer = Players.LocalPlayer

for _, player in pairs(Players:GetPlayers()) do
if player ~= localPlayer and player.Character then
    makeInvisible(player.Character)
end
end
local Proximity1 = getStallFunc():FindFirstChild("ProxPart").ProximityPrompt
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(getStallFunc():FindFirstChild("ProxPart").Position)
wait(0.3)
fireproximityprompt(Proximity1, 10)
wait(0.5)
getStallSelf():WaitForChild("CloseStall", 2):FireServer()
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
wait()
local Players = game:GetService("Players")

local function makeInvisible(character)
if character then
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("SurfaceGui") then
            part.Transparency = 1
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
end
end

local localPlayer = Players.LocalPlayer

for _, player in pairs(Players:GetPlayers()) do
if player ~= localPlayer and player.Character then
    makeInvisible(player.Character)
end
end
wait()
local Players = game:GetService("Players")

local function makeInvisible(character)
if character then
    for _, part in pairs(character:GetDescendants()) do
        if part:FindFirstChild("HumanoidRootPart") then
            part.Transparency = 1
        end
    end
end
end

local localPlayer = Players.LocalPlayer

for _, player in pairs(Players:GetPlayers()) do
if player ~= localPlayer and player.Character then
    makeInvisible(player.Character)
end
end
wait(0.3)
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = OldestCF
else
return 
end
end})

Tab1:AddButton({
Name = "Unclaim ALL Booths",
Callback = function()
local Folder = workspace:WaitForChild("Stalls")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local OldCF = localPlayer.Character:WaitForChild("HumanoidRootPart", 1).CFrame
local whitelist = {}

local function makeInvisible(character)
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("SurfaceGui") then
                part.Transparency = 1
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end

local function makeAllPlayersInvisible()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            makeInvisible(player.Character)
        end
    end
end

local function fireAndUnclaimStall(stall)
    local proximityPrompt = stall:FindFirstChild("ProxPart").ProximityPrompt
    if proximityPrompt then
        localPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(stall:FindFirstChild("ProxPart").Position)
        wait(0.3)
        fireproximityprompt(proximityPrompt, 10)
        wait(0.5)
        stall:WaitForChild("CloseStall"):FireServer()
    end
end

local function unclaimStalls()
    for _, stall in pairs(Folder:GetChildren()) do
        if stall:FindFirstChild("ProxPart") and stall:FindFirstChild("Player") then
            local owner = stall.Player.Value
            fireAndUnclaimStall(stall)
        end
    end
    wait(0.3)
end

local function cancelAllButtons()
    local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
    local StallFrame = localPlayer.PlayerGui:FindFirstChild("StallLocal"):FindFirstChild("StallFrame")

    for _, v in pairs(StallFrame:GetDescendants()) do
        if (v:IsA("ImageButton") or v:IsA("TextButton")) and v.Name == "CancelButton" then
            for _, signal in pairs(Signals) do
                firesignal(v[signal])
            end
        end
    end
end

makeAllPlayersInvisible()
unclaimStalls()
wait(0.1)
localPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = OldCF
wait(0.5)
cancelAllButtons()
wait(0.3)
print("Finished Unclaiming All Booths.")
end})

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
[1] = game.Players.LocalPlayer.Name.." is a nice person",
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
[1] = game.Players.LocalPlayer.Name.." has a ton of cash",
[2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
[1] = game.Players.LocalPlayer.Name.." is on top",
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
[1] = game.Players.LocalPlayer.Name.." got diamonds",
[2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
[1] = game.Players.LocalPlayer.Name.." has stacks",
[2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
[1] = game.Players.LocalPlayer.Name.." is the king",
[2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
[1] = game.Players.LocalPlayer.Name.." likes the paper",
[2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
wait()
local args = {
[1] = game.Players.LocalPlayer.Name.." is counting cash",
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
[1] = game.Players.LocalPlayer.Name.." has cash",
[2] = ""
}

Stall:WaitForChild("Edit"):FireServer(unpack(args))
end
else
getgenv().Auto = false
end
end})

Tab1:AddToggle({
Name = "Auto Like Player",
Default = false,
Callback = function(likeLol)
if likeLol then
getgenv().alrLike = true
while getgenv().alrLike == true do
wait()
fireclickdetector(workspace.AvatarUI.LikeButton.ClickDetector)
end
else
getgenv().alrLike = false
end
end})

Tab1:AddToggle({
Name = "Shuffle Voices",
Default = false,
Callback = function(voices)
if voices then
getgenv().shuffleVoices = true
while getgenv().shuffleVoices == true do
wait()
local args = {
[1] = "Normal"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Chorus"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Darling"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Demon"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Elf"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Fun"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Low"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Reverb"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
wait()
local args = {
[1] = "Normal"
}

game:GetService("ReplicatedStorage"):WaitForChild("VEffect"):FireServer(unpack(args))
end
else
getgenv().shuffleVoices = false
end
end})

Tab1:AddToggle({
Name = "Mute Yourself",
Default = false,
Callback = function(muteYou)
if muteYou then
getgenv().muting = true
if getgenv().muting == true then
game:GetService("Players").LocalPlayer.AudioDeviceInput.Muted = true
end
else
getgenv().muting = false
wait()
game:GetService("Players").LocalPlayer.AudioDeviceInput.Muted = false
end
end})

Tab2:AddToggle({
Name = "Hoverboard Spam (FE)",
Default = false,
Callback = function(hoverBoard)
if hoverBoard then
getgenv().HoverboardRide = true
while getgenv().HoverboardRide == true do
wait()
local args = {
[1] = "XHoverboard",
[2] = "Hoverboard"
}

game:GetService("ReplicatedStorage"):WaitForChild("Hoverboard"):FireServer(unpack(args))
wait()
local args = {
[1] = tonumber(game.Players.LocalPlayer.UserId)
}

game:GetService("ReplicatedStorage"):WaitForChild("StopAction"):FireServer(unpack(args))
end
else
getgenv().HoverboardRide = false
wait()
local args = {
[1] = tonumber(game.Players.LocalPlayer.UserId)
}

game:GetService("ReplicatedStorage"):WaitForChild("StopAction"):FireServer(unpack(args))
end
end})

Tab2:AddToggle({
Name = "Spam All Tools (FE)",
Default = false,
Callback = function(spamTools)
if spamTools then
getgenv().ToolSpam = true
while getgenv().ToolSpam == true do
wait()
local args = {
[1] = "ThrowBrick",
[2] = "Brick"
}

game:GetService("ReplicatedStorage"):WaitForChild("Throw"):FireServer(unpack(args))
wait()
local args = {
[1] = "ThrowDrink",
[2] = "Drink"
}

game:GetService("ReplicatedStorage"):WaitForChild("Throw"):FireServer(unpack(args))
wait()
local args = {
[1] = "ThrowPaperBanknote",
[2] = "Paper"
}

game:GetService("ReplicatedStorage"):WaitForChild("Throw"):FireServer(unpack(args))
wait()
local args = {
[1] = "XBag",
[2] = "Bag"
}

game:GetService("ReplicatedStorage"):WaitForChild("Drink"):FireServer(unpack(args))
wait()
local args = {
[1] = "XBagZ",
[2] = "Suitbag"
}

game:GetService("ReplicatedStorage"):WaitForChild("Drink"):FireServer(unpack(args))
wait()
local args = {
[1] = "XBurger",
[2] = "Burger"
}

game:GetService("ReplicatedStorage"):WaitForChild("Drink"):FireServer(unpack(args))
wait()
local args = {
[1] = "XPhone",
[2] = "Baddiephone"
}

game:GetService("ReplicatedStorage"):WaitForChild("Drink"):FireServer(unpack(args))
wait()
local args = {
[1] = "XTea",
[2] = "Tea"
}

game:GetService("ReplicatedStorage"):WaitForChild("Drink"):FireServer(unpack(args))
wait()
local args = {
[1] = tonumber(game.Players.LocalPlayer.UserId)
}

game:GetService("ReplicatedStorage"):WaitForChild("StopAction"):FireServer(unpack(args))
end
else
getgenv().ToolSpam = false
end
end})

Tab1:AddToggle({
Name = "Auto Dislike Player",
Default = false,
Callback = function(dislikeButton)
if dislikeButton then
getgenv().Disliking = true
while getgenv().Disliking == true do
wait()
fireclickdetector(workspace.AvatarUI.DislikeButton.ClickDetector)
end
else
getgenv().Disliking = false
end
end})

Tab4:AddButton({
Name = "Chat Bypass (Patched!)",
Callback = function()
return OrionLib:MakeNotification({
    Name = "Sorry!",
    Content = "This part is undergoing reworking",
    Image = "rbxassetid://4483345998",
    Time = 10
})
end})

Tab4:AddButton({
Name = "Fake Chat GUI (Still Working)",
Callback = function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/FakeChatGUI/main/LmaoBruh.lua')))()
end})

-- You cannot bypass the current system, but reworking soon for people that own the GamePass and want to mess with the system. (Soon!)

--[[Tab4:AddToggle({
Name = "(FE) Character Flicker",
Default = false,
Callback = function(Flick)
if Flick and game:GetService("MarketplaceService"):UserOwnsGamePassAsync(tonumber(game.Players.LocalPlayer.UserId), tonumber(28828491)) then
getgenv().Flicker = true
while getgenv().Flicker == true do
wait()

end
else
getgenv().Flicker = false
end
end})--]]

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
Part.CFrame = CFrame.new(999, 999, 999) -- I don't understand why the fucking BasePlate keeps spawning on the old CFrame, despite me updating the CFrame constantly, but it never goes anywhere else.
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
Part.CFrame = CFrame.new(999, 999, 999)
Part.CanCollide = true
Part.Name = "Secondary BasePlate"
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
game:GetService("StarterGui"):SetCore("SendNotification",{["Title"] = "Invisible Toggle Loaded",["Text"] = "Press "..Settings.Keybind.." to change visibility.",["Duration"] = 10,["Button1"] = "Okay."})
end})

--[[Tab2:AddToggle({
Name = "Flicker Character (FE, Invis Method)",
Default = false,
Callback = function(InvisMethod)
if InvisMethod then
getgenv().UseInvisMethod = true
local Player = game:GetService("Players").LocalPlayer
local RealCharacter = Player.Character or Player.CharacterAdded:Wait()
local IsInvisible = false
local FakeCharacter
local Part

local function CreateBaseplate()
    if not workspace:FindFirstChild("BasePlate") then
        Part = Instance.new("Part")
        Part.Anchored = true
        Part.Size = Vector3.new(200, 1, 200)
        Part.CFrame = CFrame.new(999, 999, 999)
        Part.CanCollide = true
        Part.Name = "BasePlate"
        Part.Parent = workspace
    else
        Part = workspace.BasePlate
    end
end

local function CreateFakeCharacter()
    if not FakeCharacter then
        RealCharacter.Archivable = true
        FakeCharacter = RealCharacter:Clone()
        FakeCharacter.Parent = workspace
        FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
        
        for _, v in pairs(RealCharacter:GetChildren()) do
            if v:IsA("LocalScript") then
                local clone = v:Clone()
                clone.Disabled = true
                clone.Parent = FakeCharacter
            end
        end
        
        for _, v in pairs(FakeCharacter:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0.5
            end
        end
    end
end

local function ToggleVisibility()
    if not FakeCharacter or not RealCharacter then
        return
    end

    if IsInvisible == false then
        local StoredCF = RealCharacter.HumanoidRootPart.CFrame
        RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
        FakeCharacter.HumanoidRootPart.CFrame = StoredCF
        Player.Character = FakeCharacter
        workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
        IsInvisible = true
    else
        local StoredCF = FakeCharacter.HumanoidRootPart.CFrame
        FakeCharacter.HumanoidRootPart.CFrame = RealCharacter.HumanoidRootPart.CFrame
        RealCharacter.HumanoidRootPart.CFrame = StoredCF
        Player.Character = RealCharacter
        workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
        IsInvisible = false
    end
end

CreateBaseplate()
CreateFakeCharacter()

while getgenv().UseInvisMethod == true do
    ToggleVisibility()
    wait(0.2)
end
else
getgenv().UseInvisMethod = false
end
end})--]]

Tab2:AddTextbox({
Name = "Invis Keybind (if already ran = respawn)",
Default = "E",
TextDisappear = false,
Callback = function(TheBind)
Settings.Keybind = tostring(TheBind)
end})

Tab5:AddButton({
Name = "Solve All TicTacToe Boards",
Callback = function()
local OldCF = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
local function interactWithClickDetectorInAllBoards(detectorNumber)
for _, board in pairs(workspace:GetChildren()) do
    if board:IsA("Model") and board.Name == "Tic Tac Toe" then
        local partName = "Detector" .. tostring(detectorNumber)
        local part = board:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            local clickDetector = part:FindFirstChildOfClass("ClickDetector")
            if clickDetector then
                game.Players.LocalPlayer.Character:PivotTo(clickDetector.Parent:GetPivot())
                wait()
                print("ClickDetector in Part: " .. partName .. ", in board: " .. board.Name)
                wait()
                fireclickdetector(clickDetector, 10)
                wait()
            else
                print("ClickDetector not found in part " .. partName .. " in board " .. board.Name)
            end
        else
            print("Part " .. partName .. " not found in board " .. board.Name)
        end
    end
end
end

interactWithClickDetectorInAllBoards(1)
wait()
interactWithClickDetectorInAllBoards(2)
wait()
interactWithClickDetectorInAllBoards(3)
wait()
interactWithClickDetectorInAllBoards(4)
wait()
interactWithClickDetectorInAllBoards(5)
wait()
interactWithClickDetectorInAllBoards(6)
wait()
interactWithClickDetectorInAllBoards(7)
wait()
interactWithClickDetectorInAllBoards(8)
wait()
interactWithClickDetectorInAllBoards(9)
wait(1)
game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = OldCF
end})

Tab5:AddButton({
Name = "Infinite Yield",
Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua", true))()
end})

Tab5:AddButton({
Name = "FE Admin (Press ; )",
Callback = function()
if fireproximityprompt and cloneref then
loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/AdonisAdminFE/main/AdminFE.lua", true))()
else
return OrionLib:MakeNotification({
    Name = "Error: Not Capable",
    Content = "Your exploit cannot run this script, hence errors",
    Image = "rbxassetid://4483345998",
    Time = 10
})
end
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
    local HoldDuration = {}

    for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local OldHoldDuration = v.HoldDuration
            table.insert(HoldDuration, OldHoldDuration)
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
    wait()
    local index = 1
    for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            v.HoldDuration = HoldDuration[index]
            index = index + 1
        end
    end
else
    return OrionLib:MakeNotification({
        Name = "Error:",
        Content = "You do not own the VIP Tools GamePass buy it first!",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
end
end})

local lighting = game:GetService("Lighting")
local savedSettings
local settings = {}

local function saveSettings()
if savedSettings then
    return 
end

savedSettings = {
    SunRays = lighting:FindFirstChildOfClass("SunRaysEffect"),
    Sky = lighting:FindFirstChildOfClass("Sky"),
    Bloom = lighting:FindFirstChildOfClass("BloomEffect"),
    DepthOfField = lighting:FindFirstChildOfClass("DepthOfFieldEffect"),
    Atmosphere = lighting:FindFirstChildOfClass("Atmosphere")
}

settings = {
    SunRays = {
        Intensity = savedSettings.SunRays.Intensity,
        Spread = savedSettings.SunRays.Spread,
        Enabled = savedSettings.SunRays.Enabled
    },
    Sky = {
        CelestialBodiesShown = savedSettings.Sky.CelestialBodiesShown,
        MoonAngularSize = savedSettings.Sky.MoonAngularSize,
        SunAngularSize = savedSettings.Sky.SunAngularSize,
        SkyboxBk = savedSettings.Sky.SkyboxBk,
        SkyboxDn = savedSettings.Sky.SkyboxDn,
        SkyboxFt = savedSettings.Sky.SkyboxFt,
        SkyboxLf = savedSettings.Sky.SkyboxLf,
        SkyboxRt = savedSettings.Sky.SkyboxRt,
        SkyboxUp = savedSettings.Sky.SkyboxUp,
        StarCount = savedSettings.Sky.StarCount
    },
    Bloom = {
        Intensity = savedSettings.Bloom.Intensity,
        Size = savedSettings.Bloom.Size,
        Threshold = savedSettings.Bloom.Threshold,
        Enabled = savedSettings.Bloom.Enabled
    },
    DepthOfField = {
        FarIntensity = savedSettings.DepthOfField.FarIntensity,
        FocusDistance = savedSettings.DepthOfField.FocusDistance,
        InFocusRadius = savedSettings.DepthOfField.InFocusRadius,
        NearIntensity = savedSettings.DepthOfField.NearIntensity,
        Enabled = savedSettings.DepthOfField.Enabled
    },
    Atmosphere = {
        Color = savedSettings.Atmosphere.Color,
        Decay = savedSettings.Atmosphere.Decay,
        Density = savedSettings.Atmosphere.Density,
        Glare = savedSettings.Atmosphere.Glare,
        Haze = savedSettings.Atmosphere.Haze,
        Offset = savedSettings.Atmosphere.Offset,
    }
}
end

-- Function to reset settings to the saved state
local function resetSettings()
if not savedSettings then
    return 
end

local lighting = game:GetService("Lighting")

if lighting:FindFirstChildOfClass("SunRaysEffect") then
    local sunRays = lighting:FindFirstChildOfClass("SunRaysEffect")
    sunRays.Intensity = settings.SunRays.Intensity
    sunRays.Spread = settings.SunRays.Spread
    sunRays.Enabled = settings.SunRays.Enabled
end

if lighting:FindFirstChildOfClass("Sky") then
    local sky = lighting:FindFirstChildOfClass("Sky")
    sky.CelestialBodiesShown = settings.Sky.CelestialBodiesShown
    sky.MoonAngularSize = settings.Sky.MoonAngularSize
    sky.SunAngularSize = settings.Sky.SunAngularSize
    sky.SkyboxBk = settings.Sky.SkyboxBk
    sky.SkyboxDn = settings.Sky.SkyboxDn
    sky.SkyboxFt = settings.Sky.SkyboxFt
    sky.SkyboxLf = settings.Sky.SkyboxLf
    sky.SkyboxRt = settings.Sky.SkyboxRt
    sky.SkyboxUp = settings.Sky.SkyboxUp
    sky.StarCount = settings.Sky.StarCount
end

if lighting:FindFirstChildOfClass("BloomEffect") then
    local bloom = lighting:FindFirstChildOfClass("BloomEffect")
    bloom.Intensity = settings.Bloom.Intensity
    bloom.Size = settings.Bloom.Size
    bloom.Threshold = settings.Bloom.Threshold
    bloom.Enabled = settings.Bloom.Enabled
end

if lighting:FindFirstChildOfClass("DepthOfFieldEffect") then
    local depthOfField = lighting:FindFirstChildOfClass("DepthOfFieldEffect")
    depthOfField.FarIntensity = settings.DepthOfField.FarIntensity
    depthOfField.FocusDistance = settings.DepthOfField.FocusDistance
    depthOfField.InFocusRadius = settings.DepthOfField.InFocusRadius
    depthOfField.NearIntensity = settings.DepthOfField.NearIntensity
    depthOfField.Enabled = settings.DepthOfField.Enabled
end

if lighting:FindFirstChildOfClass("Atmosphere") then
    local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")
    atmosphere.Color = settings.Atmosphere.Color
    atmosphere.Decay = settings.Atmosphere.Decay
    atmosphere.Density = settings.Atmosphere.Density
    atmosphere.Glare = settings.Atmosphere.Glare
    atmosphere.Haze = settings.Atmosphere.Haze
    atmosphere.Offset = settings.Atmosphere.Offset
end
end
wait()
saveSettings()
wait()
if saveSettings() then
print("Saved Settings Successfully!")
else
warn("Failure! Could not successfully save Lighting settings.")
end
wait()
local function resetSettings()
local lighting = game:GetService("Lighting")

-- Reset SunRays
if lighting:FindFirstChildOfClass("SunRaysEffect") then
    local sunRays = lighting:FindFirstChildOfClass("SunRaysEffect")
    sunRays.Intensity = settings.SunRays.Intensity
    sunRays.Spread = settings.SunRays.Spread
    sunRays.Enabled = settings.SunRays.Enabled
end

-- Reset Sky
if lighting:FindFirstChildOfClass("Sky") then
    local sky = lighting:FindFirstChildOfClass("Sky")
    sky.CelestialBodiesShown = settings.Sky.CelestialBodiesShown
    sky.MoonAngularSize = settings.Sky.MoonAngularSize
    sky.SunAngularSize = settings.Sky.SunAngularSize
    sky.SkyboxBk = settings.Sky.SkyboxBk
    sky.SkyboxDn = settings.Sky.SkyboxDn
    sky.SkyboxFt = settings.Sky.SkyboxFt
    sky.SkyboxLf = settings.Sky.SkyboxLf
    sky.SkyboxRt = settings.Sky.SkyboxRt
    sky.SkyboxUp = settings.Sky.SkyboxUp
    sky.StarCount = settings.Sky.StarCount
end

-- Reset Bloom
if lighting:FindFirstChildOfClass("BloomEffect") then
    local bloom = lighting:FindFirstChildOfClass("BloomEffect")
    bloom.Intensity = settings.Bloom.Intensity
    bloom.Size = settings.Bloom.Size
    bloom.Threshold = settings.Bloom.Threshold
    bloom.Enabled = settings.Bloom.Enabled
end

-- Reset DepthOfField
if lighting:FindFirstChildOfClass("DepthOfFieldEffect") then
    local depthOfField = lighting:FindFirstChildOfClass("DepthOfFieldEffect")
    depthOfField.FarIntensity = settings.DepthOfField.FarIntensity
    depthOfField.FocusDistance = settings.DepthOfField.FocusDistance
    depthOfField.InFocusRadius = settings.DepthOfField.InFocusRadius
    depthOfField.NearIntensity = settings.DepthOfField.NearIntensity
    depthOfField.Enabled = settings.DepthOfField.Enabled
end

-- Reset Atmosphere
if lighting:FindFirstChildOfClass("Atmosphere") then
    local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")
    atmosphere.Color = settings.Atmosphere.Color
    atmosphere.Decay = settings.Atmosphere.Decay
    atmosphere.Density = settings.Atmosphere.Density
    atmosphere.Glare = settings.Atmosphere.Glare
    atmosphere.Haze = settings.Atmosphere.Haze
    atmosphere.Offset = settings.Atmosphere.Offset
end
end

Tab9:AddButton({
Name = "Reset Lighting",
Callback = function()
resetSettings()
end})

Tab9:AddButton({
Name = "NightTime",
Callback = function()
game:GetService("Lighting").ClockTime = 0
wait()
game:GetService("Lighting").Brightness = 0
end})

Tab9:AddButton({
Name = "NightTime (With Night-Light)",
Callback = function()
game:GetService("Lighting").ClockTime = 1
wait()
game:GetService("Lighting").Brightness = 2
end})

Tab9:AddButton({
Name = "DayTime",
Callback = function()
game:GetService("Lighting").ClockTime = 14
wait()
game:GetService("Lighting").Brightness = 3
end})

Tab9:AddButton({
Name = "Spooky DayTime (smoke, broken)",
Callback = function()
game:GetService("Lighting").ClockTime = 8
wait()
game:GetService("Lighting").Brightness = 0

local function addSmokeToPart(part)
local Players = game:GetService("Players"):GetChildren()

if part:IsA("BasePart") and part.Parent ~= Players.Character then
    local smoke = Instance.new("Smoke")
    smoke.Name = "SpookySmoke"
    smoke.Opacity = 0.5
    smoke.RiseVelocity = 2
    smoke.Size = 6
    smoke.Color = Color3.fromRGB(161, 165, 162)
    smoke.Parent = part
end
end

local function addSmokeToEverything()
local Players = game:GetService("Players"):GetChildren()

for _, obj in pairs(workspace:GetDescendants()) do
    if obj.Parent ~= Players.Character then
        addSmokeToPart(obj)
    end
end
end 

addSmokeToEverything()
end})

Tab9:AddToggle({
Name = "Spooky Moon",
Default = false,
Callback = function(moonCrazy)
if moonCrazy then
    getgenv().SpookyMoon = true
    local sky = game:GetService("Lighting"):FindFirstChildOfClass("Sky")

    local function smoothTransition()
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
    getgenv().SpookyMoon = false
end
end})

Tab9:AddButton({
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
end})

Tab9:AddButton({
Name = "Remove Spooky DayTime",
Callback = function()
local function removeSmokeFromPart(part)
local smoke = part:FindFirstChild("SpookySmoke")
if smoke then
    smoke:Destroy()
end
end

local function removeSmokeFromEverything()
for _, obj in pairs(workspace:GetDescendants()) do
    removeSmokeFromPart(obj)
end
end

removeSmokeFromEverything()
end})

Tab1:AddButton({
Name = "Submit Note Bypass (not working)",
Callback = function()
local PartToTp = workspace:FindFirstChild("SubmitNote")
local Character = game:GetService("Players").LocalPlayer.Character
local HRP = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart")

HRP.CFrame = CFrame.new(PartToTp.Position)
wait(0.3)
HRP.Anchored = true
wait(0.5)
fireproximityprompt(PartToTp.Activate)
wait(0.2)
game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SubmitNote"):FindFirstChild("Frame"):FindFirstChild("TextBox").Text = "ӻȕㄈҟ ȟόȇ"
wait(0.2)
local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

for _,v in pairs(game.Players.LocalPlayer.PlayerGui:FindFirstChild("SubmitNote"):FindFirstChild("Frame"):GetDescendants()) do
if v:IsA("ImageButton") or v:IsA("TextButton") then
    for i,Signal in pairs(Signals) do
        firesignal(v[Signal])
    end
end
end
wait(0.3)
HRP.Anchored = false
end})

Tab1:AddButton({
Name = "Mute All",
Callback = function()
for i, v in pairs(game:GetService("Players"):GetChildren()) do
    if v:FindFirstChild("AudioDeviceInput") and v ~= game.Players.LocalPlayer then
        v:FindFirstChild("AudioDeviceInput").Muted = true
    end
end
end})

Tab1:AddButton({
Name = "UnMute All",
Callback = function()
for i, v in pairs(game:GetService("Players"):GetChildren()) do
    if v:FindFirstChild("AudioDeviceInput") and v ~= game.Players.LocalPlayer then
        v:FindFirstChild("AudioDeviceInput").Muted = false
    end
end
end})

Tab1:AddTextbox({
Name = "Mute Player",
Default = "UserName Or DisplayName",
TextDisappear = true,
Callback = function(thisUser)
local derUser = findplr(thisUser)

if derUser then
derUser:FindFirstChild("AudioDeviceInput").Muted = true
end
end})

Tab5:AddButton({
Name = "Reload Script",
Callback = function()
getgenv().SCRIPT_EXECUTED = false
wait()
game:GetService("CoreGui"):FindFirstChild("Orion"):Destroy()
wait(1)
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/TheMICUPSource.lua')))()
end})

Tab5:AddButton({
Name = "Destroy Script",
Callback = function()
getgenv().SCRIPT_EXECUTED = false
wait()
game:GetService("CoreGui"):FindFirstChild("Orion"):Destroy()
end})

Tab1:AddTextbox({
Name = "Unmute Player",
Default = "UserName Or DisplayName",
TextDisappear = true,
Callback = function(duhUser)
local duhDuhUser = findplr(duhUser)

if duhDuhUser then
    duhDuhUser:FindFirstChild("AudioDeviceInput").Muted = false
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
wait(1)
table.insert(List, game.Players.LocalPlayer.UserId)
end
end})

--[[Tab2:AddToggle({
Name = "Set Waypoint Here",
Default = false,
Callback = function(setWayPoint)
if setWayPoint then
getgenv().WPName = true
if getgenv().WPName == true then
    local NewInfYielding = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua", true))()
    wait(0.5)
    NewInfYielding.execCmd("setwaypoint ZACKS_EASY_HUB_CONFIG")
    wait(0.5)
    NewInfYielding.execCmd("spawn")
end
else
getgenv().WPName = false
wait()
local NewInf = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/main/InfYieldOther.lua", true))()
wait(0.5)
NewInf.execCmd("dwp ZACKS_EASY_HUB_CONFIG")
wait(0.1)
NewInf.execCmd("nospawn")
wait(0.1)
NewInf.execCmd("nospawnpoint")
end
end})--]]

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
end
wait(1)
loadGUI()
wait(0.3)
print("Running...")
wait()
local function makeCharacterVisible(character)
for _, part in pairs(character:GetDescendants()) do
    if part:IsA("BasePart") then
        part.Transparency = 0
        part.CanCollide = false
    end
end
end

for _, player in pairs(game.Players:GetPlayers()) do
if player ~= game.Players.LocalPlayer and player.Character then
    makeCharacterVisible(player.Character)
end
end
wait()
local function makePartInvisible(part)
part.Transparency = 1
part.CanCollide = false
end

local function makeHumanoidRootPartInvisible(character)
local player = game.Players:GetPlayerFromCharacter(character)
if player and player ~= game.Players.LocalPlayer then
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        makePartInvisible(humanoidRootPart)
    end
end
end

for _, player in pairs(game.Players:GetPlayers()) do
if player.Character then
    makeHumanoidRootPartInvisible(player.Character)
end
end
wait(1)
local player = game:GetService("Players").LocalPlayer
player.CameraMaxZoomDistance = 800000
wait(1)
print(tostring(player.CameraMaxZoomDistance))
wait()
print("Successfully ran!")

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

if game.PlaceId ~= 6884319169 then
return Notification:Notify(
    {Title = "Error: This is not Mic Up!", Description = "Game not supported!"},
    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 10, Type = "option"},
    {Image = "http://www.roblox.com/asset/?id=0", ImageColor = Color3.fromRGB(255, 84, 84), Callback = function() print("") end}
)
end