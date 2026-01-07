-- [[ let me help you out here 'Gaze' ]] --
-- [[ ChatGPT is lame, just like the code you made my boy ]] --

local Screen = setmetatable({}, {
    __index= function(_, key)
        local cam= workspace.CurrentCamera
        local size= cam and cam.ViewportSize or Vector2.new(1920, 1080)

        if key== "Width" then
            return size.X
        elseif key== "Height" then
            return size.Y
        elseif key== "Size" then
            return size
        end
    end
})
local g = getgenv() or _G or {}
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
getgenv().workspace = Workspace
local Screen = workspace.CurrentCamera.ViewportSize
local all_clipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

function scale(axis, value)
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    local baseWidth, baseHeight = 1920, 1080
    local scaleFactor = isMobile and 2 or 1.5

    if axis == "X" then
        return value * (Screen.X / baseWidth) * scaleFactor
    elseif axis == "Y" then
        return value * (Screen.Y / baseHeight) * scaleFactor
    end
end

getgenv().missing = getgenv().missing or function(t, f, fallback)
    if type(f) == t then return f end
    return fallback 
end

cloneref = missing("function", cloneref, function(...) return ... end)
wait(0.2)
getgenv().get_or_set = getgenv().get_or_set or function(name, value)
    if rawget and rawset then
        local existing = rawget(getgenv(), name)
        if existing == nil then
            rawset(getgenv(), name, value)
            return value
        end
        return existing
    end

    local existing = getgenv()[name]

    if existing == nil then
        getgenv()[name] = value
        return value
    end

    return existing
end

local function safe_wrapper()
    return getgenv().get_or_set("_service_proxy", setmetatable({}, {
        __index = function(_, name)
            local existing = getgenv()[name]
            if existing ~= nil then
                return existing
            end

            local svc = game:GetService(name)
            if cloneref then
                svc = cloneref(svc)
            end

            return getgenv().get_or_set(name, svc)
        end
    }))
end

repeat task.wait() until type(safe_wrapper) == "function"

local Services = getgenv().get_or_set("Services", setmetatable({}, {
    __index = function(_, name)
        local existing = getgenv()[name]
        if existing ~= nil then
            return existing
        end

        local svc = game:GetService(name)
        if cloneref then
            svc = cloneref(svc)
        end

        return getgenv().get_or_set(name, svc)
    end
}))

function getRoot(char)
	if char and char:FindFirstChildOfClass("Humanoid") then
		return char:FindFirstChildOfClass("Humanoid").RootPart
   elseif not char then
		return nil
	end
end

local Players = Services.Players
local RunService = Services.RunService
local UserInputService = Services.UserInputService
local TweenService = Services.TweenService
local AvatarEditorService = Services.AvatarEditorService
local HttpService = Services.HttpService
local player = Players.LocalPlayer
local LocalPlayer = player
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid") or character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 50)
local lastPosition = character.PrimaryPart and character.PrimaryPart.Position or Vector3.new()

if not getgenv().character_added_conn_watcher then
    getgenv().character_added_conn_watcher = true
    wait(0.1)
    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        humanoid = newCharacter:WaitForChild("Humanoid")
        lastPosition = character.PrimaryPart and character.PrimaryPart.Position or Vector3.new()
    end)
end

getgenv().Settings = getgenv().Settings or {}
wait(0.1)
getgenv().Settings["Stop Emote When Moving"] = true
getgenv().Settings["Fade In"]     = 0.1
getgenv().Settings["Fade Out"]    = 0.1
getgenv().Settings["Weight"]      = 1
getgenv().Settings["Speed"]       = 1
getgenv().Settings["Allow Invisible  "]    = true
getgenv().Settings["Time Position"] = 0
getgenv().Settings["Freeze On Finish"] = false
getgenv().Settings["Looped"] = true
getgenv().Settings["Stop Other Animations On Play"] = true

local savedEmotes = {}
local SAVE_FILE = "FlamesEmotes_NewNEWN3WSaved.json"
local function loadSavedEmotes()
    local success, data = pcall(function()
        if readfile and isfile and isfile(SAVE_FILE) then
            return HttpService:JSONDecode(readfile(SAVE_FILE))
        end
        return {}
    end)
    if success and type(data) == "table" then
        savedEmotes = data
    else
        savedEmotes = {}
    end

    for _, v in ipairs(savedEmotes) do
        if not v.AnimationId then
            if v.AssetId then
                v.AnimationId = "rbxassetid://" .. tostring(v.AssetId)
            else
                v.AnimationId = "rbxassetid://" .. tostring(v.Id)
            end
        end
        if v.Favorite == nil then
            v.Favorite = false
        end
    end
end

local function saveEmotesToData()
    pcall(function()
        if writefile then -- no need for an 'if' check retard, you already have it in a pcall function, it's safe regardless.
            writefile(SAVE_FILE, HttpService:JSONEncode(savedEmotes)) -- ChatGPT made this shit bro.
        end
    end)
end

loadSavedEmotes()
local CurrentTrack = nil

local function LoadTrack(id)
    if CurrentTrack then 
        CurrentTrack:Stop(getgenv().Settings["Fade Out"]) 
    end
    local animId
    local ok, result = pcall(function() 
        return game:GetObjects("rbxassetid://" .. tostring(id)) -- not safe.
    end)
    if ok and result and #result > 0 then
        local anim = result[1]
        if anim:IsA("Animation") then
            animId = anim.AnimationId
        else
            animId = "rbxassetid://" .. tostring(id)
        end
    else
        animId = "rbxassetid://" .. tostring(id)
    end
    local newAnim = Instance.new("Animation")
    newAnim.AnimationId = animId
    local newTrack = humanoid:LoadAnimation(newAnim)
    newTrack.Priority = Enum.AnimationPriority.Action4
    local weight = getgenv().Settings["Weight"]
    if weight == 0 then weight = 0.001 end
    if getgenv().Settings["Stop Other Animations On Play"] then
        for _,t in pairs(humanoid.Animator:GetPlayingAnimationTracks())do
            if t.Priority ~= Enum.AnimationPriority.Action4 then
                t:Stop()
            end
        end
    end
    newTrack:Play(getgenv().Settings["Fade In"], weight, getgenv().Settings["Speed"])
    CurrentTrack = newTrack 
    CurrentTrack.TimePosition = math.clamp(getgenv().Settings["Time Position"], 0, 1) * (CurrentTrack.Length or 1)
    CurrentTrack.Priority = Enum.AnimationPriority.Action4
    CurrentTrack.Looped = getgenv().Settings["Looped"]
    return newTrack
end

if not getgenv().run_service_gaze_emotes_check then -- added for protection, because the original owner seemed retarded.
    getgenv().run_service_gaze_emotes_check = true
    wait()
    RunService.RenderStepped:Connect(function() -- can break client execution, halt execution, or lag the user if executed more than once.
        if getgenv().Settings["Looped"] and CurrentTrack and CurrentTrack.IsPlaying then
            CurrentTrack.Looped = getgenv().Settings["Looped"]
        end

        if character:FindFirstChild("HumanoidRootPart") then
            local root = character.HumanoidRootPart
            if getgenv().Settings["Stop Emote When Moving"] and CurrentTrack and CurrentTrack.IsPlaying then
                local moved = (root.Position - lastPosition).Magnitude > 0.1
                local jumped = humanoid and humanoid:GetState() == Enum.HumanoidStateType.Jumping
                if moved or jumped then
                    CurrentTrack:Stop(getgenv().Settings["Fade Out"])
                    CurrentTrack = nil
                end
            end

            lastPosition = root.Position
        end
    end)
end

local CoreGui = Services.CoreGui
local gui = Instance.new("ScreenGui")
gui.Name = "FlamesEmoteGUI"
gui.Parent = CoreGui
gui.Enabled = false
gui.DisplayOrder = 999

local function createGradient(parent, colorSequence) -- nice so it does fucking nothing.
    return 
    -- ???
end

getgenv().createCorner = getgenv().createCorner or function(parent, cornerRadius)
    if not parent then return end -- safety.

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, cornerRadius)
    corner.Parent = parent
    return corner
end

local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, scale("X", 600), 0, scale("Y", 400))
mainContainer.Position = UDim2.new(0.5, -scale("X", 400), 0.5, -scale("Y", 250))
mainContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainContainer.Active = true
mainContainer.Draggable = true
mainContainer.Parent = gui
createCorner(mainContainer, 12)

local g = Instance.new("UIGradient")
g.Color = ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
g.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,0.05),NumberSequenceKeypoint.new(1,0.1)}
g.Parent=mainContainer

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, scale("Y", 36))
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "🔥 Flames Emotes 🔥"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = mainContainer
createCorner(title, 8)

local catalogTabBtn = Instance.new("TextButton")
catalogTabBtn.Size = UDim2.new(0.3, 0, 0, scale("Y", 24))
catalogTabBtn.Position = UDim2.new(0.05, 0, 0, scale("Y", 40))
catalogTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
catalogTabBtn.Text = "Catalog"
catalogTabBtn.TextColor3 = Color3.new(1, 1, 1)
catalogTabBtn.Font = Enum.Font.GothamBold
catalogTabBtn.TextScaled = true
catalogTabBtn.Parent = mainContainer
createCorner(catalogTabBtn, 6)

local savedTabBtn = Instance.new("TextButton")
savedTabBtn.Size = UDim2.new(0.3, 0, 0, scale("Y", 24))
savedTabBtn.Position = UDim2.new(0.35, 0, 0, scale("Y", 40))
savedTabBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
savedTabBtn.Text = "Saved"
savedTabBtn.TextColor3 = Color3.new(1, 1, 1)
savedTabBtn.Font = Enum.Font.GothamBold
savedTabBtn.TextScaled = true
savedTabBtn.Parent = mainContainer
createCorner(savedTabBtn, 6)

local divider = Instance.new("Frame")
divider.Size = UDim2.new(0, scale("X", 2), 1, -scale("Y", 70))
divider.Position = UDim2.new(0.6, -scale("X", 1), 0, scale("Y", 70))
divider.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
divider.Parent = mainContainer
createCorner(divider, 1)

local catalogFrame = Instance.new("Frame")
catalogFrame.Size = UDim2.new(0.6, -scale("X", 10), 1, -scale("Y", 70))
catalogFrame.Position = UDim2.new(0, scale("X", 5), 0, scale("Y", 70))
catalogFrame.BackgroundTransparency = 1
catalogFrame.Visible = true
catalogFrame.Parent = mainContainer

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0.6, -scale("X", 8), 0, scale("Y", 28))
searchBox.Position = UDim2.new(0, scale("X", 8), 0, 0)
searchBox.PlaceholderText = "Search..."
searchBox.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
searchBox.TextColor3 = Color3.new(1, 1, 1)
searchBox.Font = Enum.Font.Gotham
searchBox.TextScaled = true
searchBox.ClearTextOnFocus = false
searchBox.Text = ""
searchBox.Parent = catalogFrame
createCorner(searchBox, 6)

local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(0.2, -scale("X", 4), 0, scale("Y", 28))
refreshBtn.Position = UDim2.new(0.6, scale("X", 4), 0, 0)
refreshBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 220)
refreshBtn.Text = "Refresh"
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.TextScaled = true
refreshBtn.TextColor3 = Color3.new(1, 1, 1)
refreshBtn.Parent = catalogFrame
createCorner(refreshBtn, 6)

local sortBtn = Instance.new("TextButton")
sortBtn.Size = UDim2.new(0.2, -scale("X", 8), 0, scale("Y", 28))
sortBtn.Position = UDim2.new(0.8, scale("X", 4), 0, 0)
sortBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 120)
sortBtn.Text = "Sort: Relevance"
sortBtn.Font = Enum.Font.GothamBold
sortBtn.TextScaled = true
sortBtn.TextColor3 = Color3.new(1, 1, 1)
sortBtn.Parent = catalogFrame
createCorner(sortBtn, 6)

local savedFrame = Instance.new("Frame")
savedFrame.Size = UDim2.new(0.6, -scale("X", 10), 1, -scale("Y", 70))
savedFrame.Position = UDim2.new(0, scale("X", 5), 0, scale("Y", 70))
savedFrame.BackgroundTransparency = 1
savedFrame.Visible = false
savedFrame.Parent = mainContainer

local savedSearch = Instance.new("TextBox")
savedSearch.Size = UDim2.new(1, -scale("X", 16), 0, scale("Y", 28))
savedSearch.Position = UDim2.new(0, scale("X", 8), 0, 0)
savedSearch.PlaceholderText = "Search Saved..."
savedSearch.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
savedSearch.TextColor3 = Color3.new(1, 1, 1)
savedSearch.Font = Enum.Font.Gotham
savedSearch.TextScaled = true
savedSearch.ClearTextOnFocus = false
savedSearch.Text = ""
savedSearch.Parent = savedFrame
createCorner(savedSearch, 6)

local savedScroll = Instance.new("ScrollingFrame")
savedScroll.Size = UDim2.new(1, -scale("X", 16), 1, -scale("Y", 40))
savedScroll.Position = UDim2.new(0, scale("X", 8), 0, scale("Y", 36))
savedScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
savedScroll.ScrollBarThickness = 0
savedScroll.BackgroundTransparency = 1
savedScroll.Parent = savedFrame

local savedEmptyLabel = Instance.new("TextLabel")
savedEmptyLabel.Size = UDim2.new(1, 0, 0, scale("Y", 36))
savedEmptyLabel.Position = UDim2.new(0, 0, 0.5, -scale("Y", 18))
savedEmptyLabel.BackgroundTransparency = 1
savedEmptyLabel.Text = "Sorry I Was Changing Save Files Again 😅"
savedEmptyLabel.TextColor3 = Color3.new(1, 1, 1)
savedEmptyLabel.Font = Enum.Font.GothamBold
savedEmptyLabel.TextScaled = true
savedEmptyLabel.Visible = false
savedEmptyLabel.Parent = savedScroll

local savedLayout = Instance.new("UIGridLayout")
savedLayout.CellSize = UDim2.new(0, scale("X", 120), 0, scale("Y", 200))
savedLayout.CellPadding = UDim2.new(0, scale("X", 8), 0, scale("Y", 8))
savedLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
savedLayout.Parent = savedScroll

local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(0.4, -scale("X", 10), 1, -scale("Y", 70))
settingsFrame.Position = UDim2.new(0.6, scale("X", 5), 0, scale("Y", 70))
settingsFrame.BackgroundTransparency = 1
settingsFrame.Parent = mainContainer

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, scale("Y", 28))
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Settings"
settingsTitle.TextColor3 = Color3.new(1, 1, 1)
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextScaled = true
settingsTitle.Parent = settingsFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -scale("X", 20), 1, -scale("Y", 40))
scrollFrame.Position = UDim2.new(0, scale("X", 10), 0, scale("Y", 30))
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = settingsFrame

local function lockX()
    scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.CanvasPosition.Y)
end

if not getgenv().convas_position_property_changer_watcher then
    getgenv().convas_position_property_changer_watcher = true

    scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(lockX) -- not safe by it's self.
end

local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.Padding = UDim.new(0, 6)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

if not getgenv().property_watcher_list_layout_checker then
    getgenv().property_watcher_list_layout_checker = true

    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
    end)
end

function GetReal(id)
    local ok, obj = pcall(function()
        return game:GetObjects("rbxassetid://"..tostring(id))
    end)
    if ok and obj and #obj > 0 then
        local anim = obj[1]
        if anim:IsA("Animation") and anim.AnimationId ~= "" then
            return tonumber(anim.AnimationId:match("%d+")) -- only ChatGPT does this shit.
        end
    end
end

getgenv().Settings._sliders = {}
getgenv().Settings._toggles = {}

--// SLIDER CREATOR
-- dead ass?
local function createSlider(name, min, max, default)
    getgenv().Settings[name] = default or min

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, scale("Y", 65))
    container.BackgroundTransparency = 1
    container.Parent = scrollFrame

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bg.Parent = container
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -scale("X", 10), 0, scale("Y", 20))
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = string.format("%s: %.2f", name, getgenv().Settings[name])
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = bg

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.5, -scale("X", 20), 0, scale("Y", 20))
    textBox.Position = UDim2.new(0.5, scale("X", 10), 0, scale("Y", 5))
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox.Text = tostring(getgenv().Settings[name])
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.Gotham
    textBox.TextScaled = true
    textBox.ClearTextOnFocus = false
    textBox.Parent = bg
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -scale("X", 40), 0, scale("Y", 12))
    sliderBar.Position = UDim2.new(0, scale("X", 20), 0, scale("Y", 35))
    sliderBar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    sliderBar.Parent = bg
    Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(0, 6)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(0, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    sliderFill.Parent = sliderBar
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 6)

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, scale("X", 20), 0, scale("Y", 20))
    thumb.AnchorPoint = Vector2.new(0.5, 0.5)
    thumb.Position = UDim2.new(0, 0, 0.5, 0)
    thumb.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    thumb.Parent = sliderBar
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local function tweenVisual(rel)
        local visualRel = math.clamp(rel, 0, 1)
        TweenService:Create(sliderFill, TweenInfo.new(0.15), {Size = UDim2.new(visualRel, 0, 1, 0)}):Play()
        TweenService:Create(thumb, TweenInfo.new(0.15), {Position = UDim2.new(visualRel, 0, 0.5, 0)}):Play()
    end

    local function applyValue(value)
        getgenv().Settings[name] = math.clamp(value, min, max)
        label.Text = string.format("%s: %.2f", name, getgenv().Settings[name])
        textBox.Text = tostring(getgenv().Settings[name])
        local rel = (getgenv().Settings[name] - min) / (max - min)
        tweenVisual(rel)

        if CurrentTrack and CurrentTrack.IsPlaying then
            if name == "Speed" then
                CurrentTrack:AdjustSpeed(getgenv().Settings["Speed"])
            elseif name == "Weight" then
                local weight = getgenv().Settings["Weight"]
                if weight == 0 then weight = 0.001 end
                CurrentTrack:AdjustWeight(weight)
            elseif name == "Time Position" then
                if CurrentTrack.Length > 0 then
                    CurrentTrack.TimePosition = math.clamp(value, 0, 1) * CurrentTrack.Length
                end
            end
        end
    end

    local dragging = false
    local function updateFromInput(input)
        local relX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        local value = math.floor((min + (max - min) * relX) * 100) / 100
        applyValue(value)
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromInput(input)
        end
    end)

    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromInput(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local num = tonumber(textBox.Text)
            if num then
                applyValue(num)
            else
                textBox.Text = tostring(getgenv().Settings[name])
            end
        end
    end)

    getgenv().Settings._sliders[name] = applyValue
    applyValue(getgenv().Settings[name])
end

--// TOGGLE CREATOR
-- he used ChatGPT.
local function createToggle(name)
    getgenv().Settings[name] = getgenv().Settings[name] or false

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, scale("Y", 40))
    container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    container.Parent = scrollFrame
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, -scale("X", 10), 1, 0)
    label.Position = UDim2.new(0, scale("X", 10), 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, scale("X", 60), 0, scale("Y", 24))
    toggleBtn.Position = UDim2.new(1, -scale("X", 70), 0.5, -scale("Y", 12))
    toggleBtn.TextColor3 = Color3.new(1, 1, 1)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextScaled = true
    toggleBtn.Parent = container
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    local function applyVisual(state)
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        getgenv().Settings[name] = not getgenv().Settings[name]
        applyVisual(getgenv().Settings[name])
    end)

    applyVisual(getgenv().Settings[name])
    getgenv().Settings._toggles[name] = applyVisual
end

--// UNIFIED EDIT FUNCTIONS
-- only ChatGPT uses words like "unified" 🙏.
function Settings:EditSlider(targetName, newValue)
    local apply = self._sliders[targetName]
    if apply then
        apply(newValue)
    end
end

function Settings:EditToggle(targetName, newValue)
    local apply = self._toggles[targetName]
    if apply then
        getgenv().Settings[targetName] = newValue
        apply(newValue)
    end
end

local function createButton(name, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, scale("Y", 45))
    container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    container.Parent = scrollFrame
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -scale("X", 20), 1, -scale("Y", 10))
    button.Position = UDim2.new(0, scale("X", 10), 0, scale("Y", 5))
    button.BackgroundColor3 = Color3.fromRGB(0, 120, 250)
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Parent = container
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

    button.MouseButton1Click:Connect(function()
        if typeof(callback) == "function" then
            callback()
        end
    end)

    return button
end

local resetButton = createButton("Reset Settings", function() end)
createToggle("Stop Emote When Moving")
createToggle("Looped")
createSlider("Speed", 0, 5, getgenv().Settings["Speed"])
createSlider("Time Position", 0, 1, getgenv().Settings["Time Position"])
createSlider("Weight", 0, 1, getgenv().Settings["Weight"])
createSlider("Fade In", 0, 2, getgenv().Settings["Fade In"])
createSlider("Fade Out", 0, 2, getgenv().Settings["Fade Out"])
createToggle("Allow Invisible   ")
createToggle("Stop Other Animations On Play")

resetButton.MouseButton1Click:Connect(function()
    Settings:EditToggle("Stop Emote When Moving", true)
    Settings:EditToggle("Stop Other Animations On Play", true)
    Settings:EditSlider("Fade In", 0.1)
    Settings:EditSlider("Fade Out", 0.1)
    Settings:EditSlider("Weight", 1)
    Settings:EditSlider("Speed", 1)
    Settings:EditToggle("Allow Invisible  ", true)
    Settings:EditSlider("Time Position", 0)
    Settings:EditToggle("Freeze On Finish", false)
    Settings:EditToggle("Looped", true)
end)

local originalCollisionStates = {}
local lastFixClipState = getgenv().Settings["Allow Invisible  "]

local function saveCollisionStates()
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part ~= character.PrimaryPart then
            originalCollisionStates[part] = part.CanCollide
        end
    end
end

local function disableCollisionsExceptRootPart()
    if not getgenv().Settings["Allow Invisible  "] then
        return
    end
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part ~= character.PrimaryPart then
            part.CanCollide = false
        end
    end
end

local function restoreCollisionStates()
    for part, canCollide in pairs(originalCollisionStates) do
        if part and part.Parent then
            part.CanCollide = canCollide
        end
    end
    originalCollisionStates = {}
end

saveCollisionStates()

if not getgenv().local_heartbeat_allow_invis_connection_watcher then
    local connection

    connection = RunService.Stepped:Connect(function() -- what the hell even is this 😭😭🙏
        if character and character.Parent then
            local currentFixClip = getgenv().Settings["Allow Invisible  "]
            if lastFixClipState ~= currentFixClip then
                if currentFixClip then
                    saveCollisionStates()
                    disableCollisionsExceptRootPart()
                else
                    restoreCollisionStates()
                end
                lastFixClipState = currentFixClip
            elseif currentFixClip then
                disableCollisionsExceptRootPart()
            end
        else
            restoreCollisionStates()
            if connection then
                connection:Disconnect() -- ok.
            end
        end
    end)
end

if not getgenv().allow_invis_local_connection_char_added_watcher then
    getgenv().allow_invis_local_connection_char_added_watcher = true

    player.CharacterAdded:Connect(function(newCharacter)
        restoreCollisionStates()
        character = newCharacter
        humanoid = newCharacter:WaitForChild("Humanoid")
        saveCollisionStates()
        lastFixClipState = getgenv().Settings["Allow Invisible  "]
        if connection then
            connection:Disconnect()
        end
        connection = RunService.Stepped:Connect(function()
            if character and character.Parent then
                local currentFixClip = getgenv().Settings["Allow Invisible  "]
                if lastFixClipState ~= currentFixClip then
                    if currentFixClip then
                        saveCollisionStates()
                        disableCollisionsExceptRootPart()
                    else
                        restoreCollisionStates()
                    end
                    lastFixClipState = currentFixClip
                elseif currentFixClip then
                    disableCollisionsExceptRootPart()
                end
            else
                restoreCollisionStates()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end)
end

local sortModes = {
    {Enum.CatalogSortType.Relevance, "Relevance"},
    {Enum.CatalogSortType.PriceHighToLow, "Price High→Low"},
    {Enum.CatalogSortType.PriceLowToHigh, "Price Low→High"},
    {Enum.CatalogSortType.MostFavorited, "Most Favorited"},
    {Enum.CatalogSortType.RecentlyCreated, "Recently Created"},
    {Enum.CatalogSortType.Bestselling, "Bestselling"},
}
local currentSortIndex = 1
local currentKeyword = ""
local currentPages = nil
local currentPageNumber = 1

local function getPages(keyword)
    local params = CatalogSearchParams.new()
    params.SearchKeyword = keyword or ""
    params.CategoryFilter = Enum.CatalogCategoryFilter.None
    params.SalesTypeFilter = Enum.SalesTypeFilter.All
    params.AssetTypes = { Enum.AvatarAssetType.EmoteAnimation }
    params.IncludeOffSale = true
    params.SortType = sortModes[currentSortIndex][1]
    params.Limit = 10
    local ok, pages = pcall(function()
        return AvatarEditorService:SearchCatalog(params)
    end)
    if not ok then
        return nil
    end
    return pages
end

local function createCard(item)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, scale("X", 120), 0, scale("Y", 180))
    card.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    createCorner(card, 8)
    local thumbId = item.AssetId or item.Id
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, -scale("X", 10), 0, scale("Y", 90))
    img.Position = UDim2.new(0, scale("X", 5), 0, scale("Y", 5))
    img.BackgroundTransparency = 1
    img.ScaleType = Enum.ScaleType.Fit
    pcall(function()
        img.Image = "rbxthumb://type=Asset&id=" .. tonumber(thumbId) .. "&w=150&h=150"
    end)
    img.Parent = card
    createCorner(img, 6)
    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(1, -scale("X", 10), 0, scale("Y", 28))
    name.Position = UDim2.new(0, scale("X", 5), 0, scale("Y", 100))
    name.BackgroundTransparency = 1
    name.Text = item.Name or "Unknown"
    name.TextScaled = true
    name.TextWrapped = true
    name.Font = Enum.Font.GothamBold
    name.TextColor3 = Color3.new(1, 1, 1)
    name.Parent = card

    local url = "https://www.roblox.com/catalog/" .. tonumber(item.Id)
    local copyLinkButton = Instance.new("TextButton")
    copyLinkButton.Parent = card
    copyLinkButton.Size = UDim2.new(0, scale("X", 36), 0, scale("Y", 36))
    copyLinkButton.Position = UDim2.new(1, -scale("X", 42), 0, scale("Y", 5))
    copyLinkButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    copyLinkButton.Text = "🛒🔗"
    copyLinkButton.Font = Enum.Font.GothamBold
    copyLinkButton.TextScaled = true
    copyLinkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyLinkButton.AutoButtonColor = false
    createCorner(copyLinkButton, 8)

    copyLinkButton.MouseButton1Click:Connect(function()
        if not all_clipboards then
            copyLinkButton.Text = "❌"
            return
        end

        all_clipboards(url)
        copyLinkButton.Text = "✅"
        copyLinkButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
        task.wait(0.7)
        copyLinkButton.Text = "🛒🔗" -- this retard has a shopping cart emoji in here with a copy link emoji.
        copyLinkButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    local playBtn = Instance.new("TextButton")
    playBtn.Size = UDim2.new(0.45, -scale("X", 5), 0, scale("Y", 24))
    playBtn.Position = UDim2.new(0, scale("X", 5), 1, -scale("Y", 29))
    playBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
    playBtn.Text = "Play"
    playBtn.Font = Enum.Font.GothamBold
    playBtn.TextScaled = true
    playBtn.TextColor3 = Color3.new(1, 1, 1)
    playBtn.Parent = card
    createCorner(playBtn, 6)
    playBtn.MouseButton1Click:Connect(function()
        LoadTrack(thumbId)
    end)

    local saveBtn = Instance.new("TextButton")
    saveBtn.Size = UDim2.new(0.45, -scale("X", 5), 0, scale("Y", 24))
    saveBtn.Position = UDim2.new(0.55, 0, 1, -scale("Y", 29))
    saveBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
    saveBtn.Text = "Save"
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.TextScaled = true
    saveBtn.TextColor3 = Color3.new(1, 1, 1)
    saveBtn.Parent = card
    wait(0.1)
    createCorner(saveBtn, 6)

    saveBtn.MouseButton1Click:Connect(function()
        local alreadySaved = false

        for _, saved in ipairs(savedEmotes) do
            if saved.Id == item.Id then
                alreadySaved = true
                break
            end
        end

        if not alreadySaved then
            function GetReal(id)
                local ok, obj = pcall(function()
                    return game:GetObjects("rbxassetid://"..tostring(id))
                end)

                if not ok or not obj or #obj == 0 then return end

                local target = obj[1]
                if target:IsA("Animation") and target.AnimationId ~= "" then
                    return tonumber(target.AnimationId:match("%d+"))
                elseif target:FindFirstChildOfClass("Animation") then
                    local anim = target:FindFirstChildOfClass("Animation")
                    return tonumber(anim.AnimationId:match("%d+"))
                end
            end
            table.insert(savedEmotes, {
                Id = item.Id,
                AssetId = thumbId,
                Name = item.Name or "Unknown",
                AnimationId = "rbxassetid://" .. GetReal(thumbId),
                Favorite = false
            })
            saveEmotesToData()
            saveBtn.Text = "Saved!"
            saveBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            task.wait(1)
            saveBtn.Text = "Save"
            saveBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
        else
            saveBtn.Text = "Already"
            task.wait(0.7)
            saveBtn.Text = "Save"
        end
    end)
    return card
end

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -scale("X", 16), 1, -scale("Y", 100))
scroll.Position = UDim2.new(0, scale("X", 8), 0, scale("Y", 36))
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.Parent = catalogFrame

local layout = Instance.new("UIGridLayout", scroll)
layout.CellSize = UDim2.new(0, scale("X", 120), 0, scale("Y", 180))
layout.CellPadding = UDim2.new(0, scale("X", 8), 0, scale("Y", 8))

local emptyLabel = Instance.new("TextLabel", scroll)
emptyLabel.Size = UDim2.new(1, 0, 0, scale("Y", 36))
emptyLabel.Position = UDim2.new(0, 0, 0.5, -scale("Y", 18))
emptyLabel.BackgroundTransparency = 1
emptyLabel.Text = "Nothing Silly Here :3 (except me)"
emptyLabel.TextColor3 = Color3.new(1, 1, 1)
emptyLabel.Font = Enum.Font.GothamBold
emptyLabel.TextScaled = true
emptyLabel.Visible = false

local prevBtn = Instance.new("TextButton", catalogFrame)
prevBtn.Size = UDim2.new(0.4, -scale("X", 6), 0, scale("Y", 32))
prevBtn.Position = UDim2.new(0, scale("X", 4), 1, -scale("Y", 36))
prevBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
prevBtn.Text = "< Prev"
prevBtn.Font = Enum.Font.GothamBold
prevBtn.TextScaled = true
prevBtn.TextColor3 = Color3.new(1, 1, 1)
createCorner(prevBtn, 6)

local nextBtn = Instance.new("TextButton", catalogFrame)
nextBtn.Size = UDim2.new(0.4, -scale("X", 6), 0, scale("Y", 32))
nextBtn.Position = UDim2.new(0.6, scale("X", 2), 1, -scale("Y", 36))
nextBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
nextBtn.Text = "Next >"
nextBtn.Font = Enum.Font.GothamBold
nextBtn.TextScaled = true
nextBtn.TextColor3 = Color3.new(1, 1, 1)
createCorner(nextBtn, 6)

local pageBox = Instance.new("TextBox", catalogFrame)
pageBox.Size = UDim2.new(0.2, 0, 0, scale("Y", 32))
pageBox.Position = UDim2.new(0.4, scale("X", 2), 1, -scale("Y", 36))
pageBox.BackgroundTransparency = 1
pageBox.Font = Enum.Font.Gotham
pageBox.TextScaled = true
pageBox.TextColor3 = Color3.new(1, 1, 1)
pageBox.Text = "1 / Enter page"

local pageNotif = Instance.new("TextLabel", catalogFrame)
pageNotif.Size = UDim2.new(0.3, 0, 0, scale("Y", 24))
pageNotif.Position = UDim2.new(0.35, 0, 1, -scale("Y", 68))
pageNotif.BackgroundTransparency = 1
pageNotif.TextColor3 = Color3.fromRGB(255, 120, 80)
pageNotif.Font = Enum.Font.Gotham
pageNotif.TextScaled = true
pageNotif.Text = ""
pageNotif.Visible = false

local function updateNavVisibility()
    prevBtn.Visible = (currentPageNumber > 1)
    if currentPages and typeof(currentPages.IsFinished) == "boolean" then
        nextBtn.Visible = not currentPages.IsFinished
    else
        nextBtn.Visible = true
    end
end

local isLoading = false
-- [[ dumb ass re-defined RunService when he didn't need to. ]] --
local function showPage(pages)
    if isLoading then return end
    isLoading = true

    pageBox.Text = "Loading..."
    -- more like 'let ChatGPT code'.
    RunService.RenderStepped:Wait() -- let UI update.

    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local currentList = nil
    local ok, got = pcall(function() return pages:GetCurrentPage() end)

    if ok then
        currentList = got
    else
        pageBox.Text = "ERROR"
        isLoading = false
        return
    end

    if currentList and #currentList > 0 then
        emptyLabel.Visible = false
        for _, item in ipairs(currentList) do
            createCard(item).Parent = scroll
            RunService.RenderStepped:Wait() -- optional: spread creation over frames, ChatGPT is also optional bro.
        end
    else
        emptyLabel.Visible = true
    end

    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 8)
    pageBox.Text = tostring(currentPageNumber) .. " / Enter page"
    updateNavVisibility()
    isLoading = false
end
local function fetchPagesTo(targetPage)
local pages = getPages(currentKeyword)
if not pages then return nil end
for i = 2, targetPage do
    if pages.IsFinished then break end
        local ok, err = pcall(function()
            pages:AdvanceToNextPageAsync() -- that's how they do it, eh?
        end)

        if not ok then break end
    end
    return pages
end

local function doNewSearch(keyword)
    currentKeyword = keyword or ""
    currentPageNumber = 1
    pageBox.Text = "Loading..."
    
    currentPages = getPages(currentKeyword)
    if currentPages then
        showPage(currentPages)
    end
end

refreshBtn.MouseButton1Click:Connect(function()
    doNewSearch(searchBox.Text)
end)

searchBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        doNewSearch(searchBox.Text)
    end
end)

sortBtn.MouseButton1Click:Connect(function()
    currentSortIndex = currentSortIndex % #sortModes + 1
    sortBtn.Text = "Sort: " .. sortModes[currentSortIndex][2]
    doNewSearch(currentKeyword)
end)

-- [[ this dumb ass also re-defined UserInputService ]] --
local function goNextPage()
	if not currentPages or currentPages.IsFinished then return end
	local ok, err = pcall(function()
		currentPages:AdvanceToNextPageAsync()
	end)
	if ok then
		currentPageNumber += 1
		showPage(currentPages)
	else
		local targetPage = currentPageNumber + 1
		local fresh = fetchPagesTo(targetPage)
		if fresh then
			currentPages = fresh
			currentPageNumber = math.min(targetPage, currentPageNumber + 1)
			showPage(currentPages)
		end
	end
end

local function goPrevPage()
	if not currentPages or currentPageNumber <= 1 then return end
	local ok, err = pcall(function()
		currentPages:AdvanceToPreviousPageAsync()
	end)
	if ok then
		currentPageNumber = math.max(1, currentPageNumber - 1)
		showPage(currentPages)
	else
		local targetPage = math.max(1, currentPageNumber - 1)
		local fresh = fetchPagesTo(targetPage)
		if fresh then
			currentPages = fresh
			currentPageNumber = targetPage
			showPage(currentPages)
		end
	end
end

nextBtn.MouseButton1Click:Connect(goNextPage)
prevBtn.MouseButton1Click:Connect(goPrevPage)
-- [[ you don't have to print that shit buddy. ]] --
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Right then
        goNextPage()
    elseif input.KeyCode == Enum.KeyCode.Left then
        goPrevPage()
    end
end)

pageBox.FocusLost:Connect(function(enterPressed)
    if not enterPressed then return end
    local text = pageBox.Text:gsub("%s+", "")
    local num = tonumber(text:match("%d+"))
    if not num or num < 1 then
        pageNotif.Text = "Invalid page number"
        pageNotif.Visible = true
        task.delay(2, function() if pageNotif then pageNotif.Visible = false end end)
        pageBox.Text = "Page " .. tostring(currentPageNumber)
        return
    end
    local targetPage = math.floor(num)
    if targetPage == currentPageNumber then
        pageBox.Text = "Page " .. tostring(currentPageNumber)
        return
    end

    pageBox.Text = "Loading..."
    local ok, pages = pcall(function()
        return fetchPagesTo(targetPage)
    end)

    if not ok or not pages then
        pageNotif.Text = "Unable to fetch page"
        pageNotif.Visible = true
        task.delay(2, function() if pageNotif then pageNotif.Visible = false end end)
        pageBox.Text = "Page " .. tostring(currentPageNumber)
        return
    end

    currentPages = pages
    currentPageNumber = math.max(1, targetPage)
    showPage(currentPages)
end)

catalogTabBtn.MouseButton1Click:Connect(function()
    catalogFrame.Visible = true
    savedFrame.Visible = false
    catalogTabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
    savedTabBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
end)

local function createSavedCard(item)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, scale("X", 120), 0, scale("Y", 200))
    card.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    createCorner(card, 8)
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(1, -scale("X", 10), 0, scale("Y", 90))
    img.Position = UDim2.new(0, scale("X", 5), 0, scale("Y", 5))
    img.BackgroundTransparency = 1
    img.ScaleType = Enum.ScaleType.Fit
    img.Image = "rbxthumb://type=Asset&id=11768914234&w=150&h=150"
    img.Parent = card
    createCorner(img, 6)
    local name = Instance.new("TextLabel")
    name.Size = UDim2.new(1, -scale("X", 10), 0, scale("Y", 28))
    name.Position = UDim2.new(0, scale("X", 5), 0, scale("Y", 100))
    name.BackgroundTransparency = 1
    name.Text = item.Name or "Unknown"
    name.TextScaled = true
    name.TextWrapped = true
    name.Font = Enum.Font.GothamBold
    name.TextColor3 = Color3.new(1, 1, 1)
    name.Parent = card
    local playBtn = Instance.new("TextButton")
    playBtn.Size = UDim2.new(0.45, -scale("X", 5), 0, scale("Y", 24))
    playBtn.Position = UDim2.new(0, scale("X", 5), 1, -scale("Y", 29))
    playBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
    playBtn.Text = "Play"
    playBtn.Font = Enum.Font.GothamBold
    playBtn.TextScaled = true
    playBtn.TextColor3 = Color3.new(1, 1, 1)
    playBtn.Parent = card
    createCorner(playBtn, 6)
    playBtn.MouseButton1Click:Connect(function()
        LoadTrack(item.Id)
    end)

    local removeBtn = Instance.new("TextButton")
    removeBtn.Size = UDim2.new(0.45, -scale("X", 5), 0, scale("Y", 24))
    removeBtn.Position = UDim2.new(0.55, 0, 1, -scale("Y", 29))
    removeBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
    removeBtn.Text = "Remove"
    removeBtn.Font = Enum.Font.GothamBold
    removeBtn.TextScaled = true
    removeBtn.TextColor3 = Color3.new(1, 1, 1)
    removeBtn.Parent = card
    createCorner(removeBtn, 6)
    
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, scale("X", 40), 0, scale("Y", 24))
    copyBtn.Position = UDim2.new(0.5, -scale("X", 20), 0, scale("Y", 5))
    copyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
    copyBtn.Text = "Copy AnimId"
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextScaled = true
    copyBtn.TextColor3 = Color3.new(1, 1, 1)
    copyBtn.Parent = card
    createCorner(copyBtn, 6)

    copyBtn.MouseButton1Click:Connect(function()
        if all_clipboards then
            all_clipboards(item.AnimationId:gsub("rbxassetid://", ""))
        end

        copyBtn.Text = "Copied!"
        task.wait(0.7)
        copyBtn.Text = "Copy AnimId"
    end)

    local favBtn = Instance.new("TextButton")
    favBtn.Size = UDim2.new(0, scale("X", 24), 0, scale("Y", 24))
    favBtn.Position = UDim2.new(1, -scale("X", 30), 0, scale("Y", 5))
    favBtn.Text = item.Favorite and "★" or "☆"
    favBtn.Font = Enum.Font.GothamBold
    favBtn.TextScaled = true
    favBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
    favBtn.BackgroundTransparency = 1
    favBtn.Parent = card
    favBtn.MouseButton1Click:Connect(function()
        item.Favorite = not item.Favorite
        favBtn.Text = item.Favorite and "★" or "☆"
        saveEmotesToData()
    end)

    removeBtn.MouseButton1Click:Connect(function()
        for i, saved in ipairs(savedEmotes) do
            if saved.Id == item.Id then
                table.remove(savedEmotes, i)
                saveEmotesToData()
                refreshSavedTab()
                break
            end
        end
    end)

    return card
end

function refreshSavedTab()
    for _, child in ipairs(savedScroll:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    local text = (savedSearch.Text or ""):lower()
    local results = {}
    for _, item in ipairs(savedEmotes) do
        if text == "" or (item.Name and item.Name:lower():find(text)) then
            table.insert(results, item)
        end
    end
    table.sort(results, function(a, b)
        if a.Favorite ~= b.Favorite then
            return a.Favorite
        else
            return false
        end
    end)
    if #results > 0 then
        savedEmptyLabel.Visible = false
        for _, item in ipairs(results) do
            createSavedCard(item).Parent = savedScroll
        end
    else
        savedEmptyLabel.Visible = true
    end
    savedScroll.CanvasSize = UDim2.new(0, 0, 0, savedLayout.AbsoluteContentSize.Y + 8)
end

if not getgenv().saved_search_property_changed_signal_watcher_conn then
    getgenv().saved_search_property_changed_signal_watcher_conn = true

    savedSearch:GetPropertyChangedSignal("Text"):Connect(refreshSavedTab)
end

savedTabBtn.MouseButton1Click:Connect(function()
    catalogFrame.Visible = false
    savedFrame.Visible = true
    catalogTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    savedTabBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
    refreshSavedTab()
end)

local function doNewSearchInitial()
    doNewSearch("")
end

doNewSearchInitial()

local targetGui = gui
local function toggleGui()
    targetGui.Enabled = not targetGui.Enabled
end

local screonGui = Instance.new("ScreenGui")
screonGui.Name = "ToggleButtonGui"
screonGui.ResetOnSpawn = false
screonGui.Parent = CoreGui
screonGui.Enabled = true
local btn = Instance.new("TextButton")
btn.Parent = screonGui
btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
btn.Text = "F"
btn.TextColor3 = Color3.fromRGB(0, 0, 0)
btn.Font = Enum.Font.GothamSemibold
btn.TextScaled = true
btn.Size = UDim2.new(0, 50, 0, 50)
btn.Position = UDim2.new(0, 20, 0.5, -50)
btn.AnchorPoint = Vector2.new(0, 0.5)
btn.Active = true
pcall(function() btn.Draggable = true end) -- what the fuck.
local aspect = Instance.new("UIAspectRatioConstraint")
aspect.Parent = btn
aspect.AspectRatio = 1
local corner = Instance.new("UICorner")
corner.Parent = btn
corner.CornerRadius = UDim.new(0, 12)
btn.MouseButton1Click:Connect(toggleGui)

UserInputService.InputBegan:Connect(function(input, gameProcessed) -- definitely ChatGPT, the dumb ass who made this was retarded enough to keep it in.
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.F then
        toggleGui()
    end
end)

gui.Enabled = true -- ???
refreshSavedTab() 
