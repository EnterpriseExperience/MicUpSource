local function safe_wrapper(S)
    if cloneref then
        return cloneref(game:GetService(S))
    else
        return game:GetService(S)
    end
end

local Players = safe_wrapper("Players")
local TweenService = safe_wrapper("TweenService")
local CoreGui = get_hidden_gui and get_hidden_gui() or gethui and gethui() or safe_wrapper("CoreGui")
local GuiService = safe_wrapper("GuiService")
local Notification_API = {}

-- [[ "SendNotification_Internal" has a content input, and a time/duration input, but with no message content input, just a title and a duration/time input. ]]--
-- [[ "SendNotification_External" has a a Title, and a Content message input, but has no duration/time input. ]] --

local NotificationGui = Instance.new("ScreenGui")
NotificationGui.Name = "CustomErrorGui"
NotificationGui.ResetOnSpawn = false
NotificationGui.Parent = CoreGui
task.wait()
function Notification_API:SendNotification_Internal(message, duration)
    duration = duration or 5

    local Frame = Instance.new("Frame")
    Frame.Name = "ErrorMessage"
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.3
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0, 400, 0, 60)
    Frame.Position = UDim2.new(0, 20, 0, 100)
    Frame.Parent = NotificationGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame

    local Icon = Instance.new("ImageLabel")
    Icon.Name = "ErrorIcon"
    Icon.AnchorPoint = Vector2.new(0, 0.5)
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0, Frame.Position.X.Offset + 10, 0, Frame.Position.Y.Offset + Frame.Size.Y.Offset/2)
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Image = "rbxasset://textures/ui/Emotes/ErrorIcon.png"
    Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Icon.Parent = NotificationGui

    local Label = Instance.new("TextLabel")
    Label.Name = "ErrorText"
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 60, 0, 0)
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    Label.Text = message
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 20
    Label.TextStrokeTransparency = 1
    Label.TextWrapped = true
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextYAlignment = Enum.TextYAlignment.Center
    Label.Parent = Frame

    Frame.BackgroundTransparency = 1
    Icon.ImageTransparency = 1
    Label.TextTransparency = 1
    TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0.3}):Play()
    TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
    TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    task.delay(duration, function()
        if Frame and Frame.Parent then
            TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Icon, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
            TweenService:Create(Label, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            task.wait(0.35)
            Frame:Destroy()
            Icon:Destroy()
        end
    end)
end

function Notification_API:SendNotification_External(Title, Content)
    GuiService:SendNotification({
        Title = tostring(Title),
        Text = tostring(Content),
    })
end

return Notification_API
