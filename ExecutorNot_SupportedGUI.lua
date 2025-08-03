local gui = Instance.new("ScreenGui")
gui.Name = "ExecutorInterface"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0.6, 0, 0.6, 0)
frame.Position = UDim2.new(0.2, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0, 0)
frame.Parent = gui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 12)
uicorner.Parent = frame

local exit = Instance.new("TextButton")
exit.Name = "CloseButton"
exit.Size = UDim2.new(0, 30, 0, 30)
exit.Position = UDim2.new(1, -35, 0, 5)
exit.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
exit.Text = "X"
exit.TextScaled = true
exit.Font = Enum.Font.SourceSansBold
exit.TextColor3 = Color3.fromRGB(255, 255, 255)
exit.BorderSizePixel = 0
exit.Parent = frame

local exit_corner = Instance.new("UICorner")
exit_corner.CornerRadius = UDim.new(1, 0)
exit_corner.Parent = exit

local message = Instance.new("TextLabel")
message.Name = "MainMessage"
message.Size = UDim2.new(1, -40, 0, 100)
message.Position = UDim2.new(0, 20, 0.4, -60)
message.BackgroundTransparency = 1
message.Text = "This executor cannot run this script, we are terribly sorry!"
message.TextScaled = true
message.Font = Enum.Font.SourceSansSemibold
message.TextColor3 = Color3.fromRGB(255, 255, 255)
message.Parent = frame

local submessage = Instance.new("TextLabel")
submessage.Name = "CreditLabel"
submessage.Size = UDim2.new(1, -40, 0, 50)
submessage.Position = UDim2.new(0, 20, 0.4, 50)
submessage.BackgroundTransparency = 1
submessage.Text = "Made by: computerbinaries on Discord."
submessage.TextScaled = true
submessage.Font = Enum.Font.SourceSans
submessage.TextColor3 = Color3.fromRGB(180, 180, 180)
submessage.Parent = frame

exit.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
