-- [[

	-- ^^ Always working to bring the best products ^^ --

-- ]]

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
    wait(.3)
    local CoreGui = game:GetService("CoreGui")

	if CoreGui:FindFirstChild("HiddenUI") then
		local Hide = CoreGui:FindFirstChild("HiddenUI")
		local Rayfield = Hide:FindFirstChild("Rayfield")
		if Hide and Rayfield then
			Rayfield:Destroy()
		end
	elseif CoreGui:FindFirstChild("Rayfield") then
		local rayfield = CoreGui:FindFirstChild("Rayfield")
		if rayfield then
			rayfield:Destroy()
		end
	elseif not CoreGui:FindFirstChild("HiddenUI") then
		warn("HiddenUI is not directly accessible or it may be a function.")
	end
end

local function run_emote_config()
	httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

	local updated_build_config = "https://cdn.jsdelivr.net/gh/EnterpriseExperience/MicUpSource@main/v6-beta"

	if not httprequest then
		warn("Your executor does not support HTTP requests. Use Solara, Synapse Z, Swift, or another compatible executor.")
		wait(0.3)
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta'))()
		return
	end

	local function fetchSource(url)
		local response
		if httprequest then
			response = httprequest({Url = url, Method = "GET"})
		else
			warn("No HTTP request function found.")
			wait()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta'))()
			return
		end
		return response and response.Body
	end

	local source = fetchSource(updated_build_config)
	if not source then
		warn("Failed to fetch the source.")
		return
	end

	local fileName = "zacks_easy_hub_config.lua"
	writefile(fileName, source)

	wait(0.5)
	if pcall(readfile, fileName) then
		print("Success - writefile/success")
	else
		warn("Error writing file.")
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-beta'))()
	end
end

local function run_no_keybind_config()
	httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

	local updated_no_config_build = "https://cdn.jsdelivr.net/gh/EnterpriseExperience/MicUpSource@main/v6-no-config-setting"

	if not httprequest then
		warn("Your executor does not support HTTP requests. Use Solara, Synapse Z, Swift, or another compatible executor.")
		wait(0.3)
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-no-config-setting'))()
		return
	end

	local function fetchSource(url)
		local response
		if httprequest then
			response = httprequest({Url = url, Method = "GET"})
		else
			warn("No HTTP request function found.")
			wait()
			loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-no-config-setting'))()
			return
		end
		return response and response.Body
	end

	local source = fetchSource(updated_no_config_build)
	if not source then
		warn("Failed to fetch the source.")
		return
	end

	local fileName = "zacks_easy_hub_no_config.lua"
	writefile(fileName, source)

	wait(0.5)
	if pcall(readfile, fileName) then
		print("Success - writefile/success")
	else
		warn("Error writing file.")
		loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/v6-no-config-setting'))()
	end
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
	run_emote_config()
	wait(0.3)
	local fileName = "zacks_easy_hub_config.lua"
	local success, fileContent = pcall(readfile, fileName)

	if success and fileContent then
		local chunk, err = loadstring(fileContent)
		if chunk then
			ScreenGui:Destroy()
			chunk()
		else
			warn("Error compiling the file content:", err)
		end
	else
		warn("Failed to read the file:", fileName)
	end
end)

Button2.MouseButton1Click:Connect(function()
	run_no_keybind_config()
	wait(0.3)
	local fileName = "zacks_easy_hub_no_config.lua"
	local success, fileContent = pcall(readfile, fileName)

	if success and fileContent then
		local chunk, err = loadstring(fileContent)
		if chunk then
			ScreenGui:Destroy()
			chunk()
		else
			warn("Error compiling the file content:", err)
		end
	else
		warn("Failed to read the file:", fileName)
	end
end)
