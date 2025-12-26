if not game:IsLoaded() then game.Loaded:Wait() end

if not getgenv().GlobalEnvironmentFramework_Initialized then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
	task.wait(0.1)
	getgenv().GlobalEnvironmentFramework_Initialized = true
end

local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local GRID_SIZE = 5
local TILE_COUNT = GRID_SIZE * GRID_SIZE
local SHOW_TIME = 10
local MAX_MISTAKES = 3
local GREEN = Color3.fromRGB(0, 255, 0)
local BLUE = Color3.fromRGB(30, 70, 120)
local DARK = Color3.fromRGB(20, 20, 20)
local WHITE = Color3.fromRGB(240, 240, 240)
local RED = Color3.fromRGB(150, 0, 0)

if CoreGui:FindFirstChild("MemoryMinigameGUI") then
	CoreGui.MemoryMinigameGUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "MemoryMinigameGUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UDim2.fromScale(0.85, 0.85)
frame.BackgroundColor3 = DARK
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

local aspect = Instance.new("UIAspectRatioConstraint")
aspect.AspectRatio = 1
aspect.Parent = frame

local sizeLimit = Instance.new("UISizeConstraint")
sizeLimit.MaxSize = Vector2.new(520, 520)
sizeLimit.Parent = frame

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0.08, 0)
padding.PaddingBottom = UDim.new(0.04, 0)
padding.PaddingLeft = UDim.new(0.04, 0)
padding.PaddingRight = UDim.new(0.04, 0)
padding.Parent = frame

local cancel = Instance.new("TextButton")
cancel.Size = UDim2.fromScale(0.18, 0.08)
cancel.Position = UDim2.fromScale(0.99, 0.02)
cancel.AnchorPoint = Vector2.new(1, 0)
cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
cancel.Text = "Cancel"
cancel.TextScaled = true
cancel.Font = Enum.Font.GothamBold
cancel.TextColor3 = WHITE
cancel.Parent = frame
Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 12)

local gridFrame = Instance.new("Frame")
gridFrame.BackgroundTransparency = 1
gridFrame.Size = UDim2.fromScale(1, 0.88)
gridFrame.Position = UDim2.fromScale(0, 0.12)
gridFrame.Parent = frame

local grid = Instance.new("UIGridLayout")
grid.CellPadding = UDim2.fromScale(0.03, 0.03)
grid.CellSize = UDim2.fromScale(1 / GRID_SIZE - 0.03, 1 / GRID_SIZE - 0.03)
grid.Parent = gridFrame

local tiles = {}
local pattern = {}
local found = {}
local mistakes = 0

local function notify(title, text)
	if getgenv().notify then
		getgenv().notify(title, text, 5)
	end
end

local function cleanup()
	if gui then
		gui:Destroy()
	end
end

cancel.MouseButton1Click:Connect(function()
	notify("Cancelled", "Mini-game cancelled.")
	cleanup()
end)

for i = 1, TILE_COUNT do
	local btn = Instance.new("TextButton")
	btn.Text = ""
	btn.BackgroundColor3 = BLUE
	btn.AutoButtonColor = false
	btn.Parent = gridFrame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	tiles[i] = btn
end

local function generatePattern()
	local count = math.random(6, 9)
	local used = {}
	while #pattern < count do
		local pick = math.random(1, TILE_COUNT)
		if not used[pick] then
			used[pick] = true
			table.insert(pattern, pick)
		end
	end
end

local function checkWin()
	for _, index in ipairs(pattern) do
		if not found[index] then
			return
		end
	end
	task.delay(0.3, function()
		notify("Success", "You completed the memory mini-game.")
		cleanup()
	end)
end

local function showPattern()
	for _, index in ipairs(pattern) do
		tiles[index].BackgroundColor3 = GREEN
	end
end

local function hidePattern()
	for i, btn in ipairs(tiles) do
		if not found[i] then
			btn.BackgroundColor3 = BLUE
		end
	end
end

local function fail()
	notify("Error", "You failed the memory mini-game.")
	cleanup()
end

local function onTileClicked(index)
	if found[index] then return end
	if table.find(pattern, index) then
		found[index] = true
		tiles[index].BackgroundColor3 = GREEN
		checkWin()
	else
		mistakes += 1
		tiles[index].BackgroundColor3 = RED
		if mistakes >= MAX_MISTAKES then
			fail()
		end
	end
end

for i, btn in ipairs(tiles) do
	btn.MouseButton1Click:Connect(function()
		onTileClicked(i)
	end)
end

generatePattern()
showPattern()
task.delay(SHOW_TIME, hidePattern)
