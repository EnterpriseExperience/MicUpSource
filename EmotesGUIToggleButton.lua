if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local player

if not Players.LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    player = Players.LocalPlayer
else
    player = Players.LocalPlayer
end

local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local PlayerGui = player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui", 5)
local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ToggleEmotesGui"
toggleGui.ResetOnSpawn = false
toggleGui.Parent = CoreGui
toggleGui.IgnoreGuiInset = true

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0.5, -90)
toggleButton.AnchorPoint = Vector2.new(0, 0.5)
toggleButton.Text = "[Emotes: OFF]"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 24
toggleButton.TextScaled = true
toggleButton.Parent = toggleGui

local emotesGui = CoreGui:FindFirstChild("Emotes") or PlayerGui:FindFirstChild("Emotes")

if not emotesGui then
    if getgenv().notify then
        return getgenv().notify("Error", "Emotes GUI not found inside of CoreGui or PlayerGui!")
    else
        return 
    end
end

local function updateButtonState()
    if emotesGui.Enabled then
        toggleButton.Text = "[Emotes: ON]"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        toggleButton.Text = "[Emotes: OFF]"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end

local function toggleEmotes()
    emotesGui.Enabled = not emotesGui.Enabled
    updateButtonState()
end

toggleButton.MouseButton1Click:Connect(toggleEmotes)

game:GetService("UserInputService").TouchTap:Connect(function(touchPositions, gameProcessedEvent)
    if not gameProcessedEvent and toggleButton and toggleButton.Visible then
        for _, touchPosition in pairs(touchPositions) do
            if toggleButton.AbsolutePosition.X <= touchPosition.X and 
               touchPosition.X <= toggleButton.AbsolutePosition.X + toggleButton.AbsoluteSize.X and 
               toggleButton.AbsolutePosition.Y <= touchPosition.Y and 
               touchPosition.Y <= toggleButton.AbsolutePosition.Y + toggleButton.AbsoluteSize.Y then
                toggleEmotes()
            end
        end
    end
end)

emotesGui:GetPropertyChangedSignal("Enabled"):Connect(updateButtonState)
updateButtonState()
