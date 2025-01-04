-- [[

	-- #FREEPRODUCTSONTOP --
	-- THIS IS MY SOURCE CODE BITCH, FUCKING CREDITS HERE: https://discord.gg/VJh3kkYzBn --
	-- Now shout out the script that gave yall what you wanted, TURN THE HOLY FUCK UP FOR 2025 WITH YO BITCH ASS! --

-- ]]
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/lobox920/Notification-Library/Main/Library.lua"))()

if game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Version_Selector_ScreenGui") then
	return NotificationLibrary:SendNotification("Error", "Setup is already running!", 7)
end

local version_build_config = "V6.7.9-C"
local no_config_build = "V6.3.8.2"
task.wait()
if getgenv().setup_loaded_already_script then
	return NotificationLibrary:SendNotification("Error", "Setup is already running!", 7)
end
wait(0.3)
getgenv().setup_loaded_already_script = true

local function run_emote_config()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta'))()
end

local function run_no_keybind_config()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-no-config-setting'))()
end

getgenv().setup_loaded_already_script = true

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Version_Selector_ScreenGui"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "Version_Selector_Frame"
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.Position = UDim2.new(0, 0, 0, 0)
Frame.BackgroundTransparency = 0.1
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.Parent = ScreenGui

local Label = Instance.new("TextLabel")
Label.Name = "Version_Selector"
Label.Text = "Select Version"
Label.Size = UDim2.new(0.5, 0, 0.100000001, 0)
Label.Position = UDim2.new(0.25, 0, 0.200000003, 0)
Label.BackgroundTransparency = 0.5
Label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextScaled = true
Label.Font = Enum.Font.SourceSansBold
Label.Parent = Frame

local Label1 = Instance.new("TextLabel")
Label1.Name = "Config_Build"
Label1.Text = "Build Version: V6.7.9-C\n[Status: ✅]"
Label1.Size = UDim2.new(0.5, 0, 0.100000001, 0)
Label1.Position = UDim2.new(0.25, 0, 0.300000012, 0)
Label1.BackgroundTransparency = 1
Label1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Label1.TextColor3 = Color3.fromRGB(255, 255, 255)
Label1.TextScaled = true
Label1.Font = Enum.Font.SourceSansBold
Label1.Parent = Frame

local Label2 = Instance.new("TextLabel")
Label2.Name = "No_Config_Build"
Label2.Text = "Build Version: V6.3.8.2\n[Status: ✅]"
Label2.Size = UDim2.new(0.5, 0, 0.100000001, 0)
Label2.Position = UDim2.new(0.25, 0, 0.5, 0)
Label2.BackgroundTransparency = 1
Label2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Label2.TextColor3 = Color3.fromRGB(255, 255, 255)
Label2.TextScaled = true
Label2.Font = Enum.Font.SourceSansBold
Label2.Parent = Frame

local Button1 = Instance.new("TextButton")
Button1.Name = "Run_Config_Build"
Button1.Text = "Run Keybinds Build."
Button1.Size = UDim2.new(0.400000006, 0, 0.100000001, 0)
Button1.Position = UDim2.new(0.300000012, 0, 0.400000006, 0)
Button1.BackgroundTransparency = 0.5
Button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button1.TextColor3 = Color3.fromRGB(255, 255, 255)
Button1.TextScaled = true
Button1.Font = Enum.Font.SourceSansBold
Button1.Parent = Frame

local Button2 = Instance.new("TextButton")
Button2.Name = "Run_No_Config_Build"
Button2.Text = "Run No-Keybinds Build."
Button2.Size = UDim2.new(0.400000006, 0, 0.100000001, 0)
Button2.Position = UDim2.new(0.300000012, 0, 0.600000024, 0)
Button2.BackgroundTransparency = 0.5
Button2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button2.TextColor3 = Color3.fromRGB(255, 255, 255)
Button2.TextScaled = true
Button2.Font = Enum.Font.SourceSansBold
Button2.Parent = Frame

Button1.MouseButton1Click:Connect(function()
	Button1.Text = "Loading Keybinds Version..."
	wait(0.2)
	getgenv().setup_loaded_already_script = false
	ScreenGui:Destroy()
	wait()
	run_emote_config()
end)

Button2.MouseButton1Click:Connect(function()
	Button2.Text = "Loading No Keybinds Version..."
	wait(0.2)
	getgenv().setup_loaded_already_script = false
	ScreenGui:Destroy()
	wait()
	run_no_keybind_config()
end)
