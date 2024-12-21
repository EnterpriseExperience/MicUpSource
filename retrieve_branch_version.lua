-- [[

	-- ^^ Always working to bring the best products ^^ --
	-- This is our second whole shitting patch for this script, to choose between keybinds and no keybinds.

-- ]]

local version_build_config = "V6.6.7-C"
local no_config_build = "V6.2.6.2"
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/lobox920/Notification-Library/Main/Library.lua"))()
task.wait()
if getgenv().setup_loaded_already_script then
	return NotificationLibrary:SendNotification("Error", "Setup is already running!", 7)
end
wait(0.2)
if getgenv().SCRIPT_EXECUTED or getgenv().SCRIPT_EXECUTED == true then
	getgenv().getLoopKick = false
    wait(0.2)
    getgenv().SCRIPT_EXECUTED = false
    getgenv().SCRIPT_EXECUTED = false
    getgenv().Invis_Loaded = false
    getgenv().GetLoopRunning = false
    getgenv().GetLoopRunning = false
    getgenv().LmaoGetMuted = false
    getgenv().css_digital = false
end

local function run_emote_config()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta'))()
end

local function run_no_keybind_config()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-no-config-setting'))()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZACKS_EASY_HUB"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "ZACKS_EASY_HUB"
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.Position = UDim2.new(0, 0, 0, 0)
Frame.BackgroundTransparency = 0.2
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.Parent = ScreenGui

local Label = Instance.new("TextLabel")
Label.Name = "ZACKS_EASY_HUB"
Label.Text = "Select Your Config"
Label.Size = UDim2.new(0.5, 0, 0.1, 0)
Label.Position = UDim2.new(0.25, 0, 0.2, 0)
Label.BackgroundTransparency = 1
Label.TextColor3 = Color3.fromRGB(237, 0, 0)
Label.TextScaled = true
Label.Font = Enum.Font.SourceSansBold
Label.Parent = Frame

local Button1 = Instance.new("TextButton")
Button1.Name = "ZACKS_EASY_HUB"
Button1.Text = "Emotes/Keybinds Included"
Button1.Size = UDim2.new(0.4, 0, 0.1, 0)
Button1.Position = UDim2.new(0.3, 0, 0.4, 0)
Button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button1.TextColor3 = Color3.fromRGB(7, 238, 0)
Button1.TextScaled = true
Button1.Font = Enum.Font.SourceSansBold
Button1.Parent = Frame

local Button2 = Instance.new("TextButton")
Button2.Name = "ZACKS_EASY_HUB"
Button2.Text = "I do not want emote/keybinds"
Button2.Size = UDim2.new(0.4, 0, 0.1, 0)
Button2.Position = UDim2.new(0.3, 0, 0.55, 0)
Button2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button2.TextColor3 = Color3.fromRGB(12, 0, 220)
Button2.TextScaled = true
Button2.Font = Enum.Font.SourceSansBold
Button2.Parent = Frame

Button1.MouseButton1Click:Connect(function()
	Button1.Text = "Loading Keybinds Script..."
	getgenv().setup_loaded_already_script = false
	wait(0.2)
	Button1.Text = "Done!"
	wait(0.4)
	ScreenGui:Destroy()
	wait()
	run_emote_config()
end)

Button2.MouseButton1Click:Connect(function()
	Button2.Text = "Loading No Keybinds Version..."
	getgenv().setup_loaded_already_script = false
	wait(0.2)
	Button2.Text = "Done!"
	wait(0.4)
	ScreenGui:Destroy()
	wait()
	run_no_keybind_config()
end)
wait()
getgenv().setup_loaded_already_script = true
