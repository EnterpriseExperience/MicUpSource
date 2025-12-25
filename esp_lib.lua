if getgenv().playeresp_singleton and getgenv().playeresp_singleton.active then
	return getgenv().playeresp_singleton
end
local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local runservice = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local localplayer = players.LocalPlayer
local esp = getgenv().playeresp_singleton or {}
getgenv().playeresp_singleton = esp
esp.active = true
esp.enabled = esp.enabled or false
esp.name_enabled = esp.name_enabled or false
esp.arrow_enabled = esp.arrow_enabled or false
esp.tracked = esp.tracked or {}
esp.connections = esp.connections or {}
esp.render_connection = esp.render_connection or nil

local function getcamera()
	return workspace.CurrentCamera
end

local function safe_remove(o)
	if o and o.Remove then
		o:Remove()
	end
end

local function clear_player(p)
	local d = esp.tracked[p]
	if not d then return end
	safe_remove(d.name)
	safe_remove(d.arrow)
	esp.tracked[p] = nil
end

local function clear_all()
	for p in pairs(esp.tracked) do
		clear_player(p)
	end
end

local function new_text()
	local t = Drawing.new("Text")
	t.Center = true
	t.Outline = true
	t.Size = 15
	t.Color = Color3.fromRGB(255,0,0)
	t.Visible = false
	return t
end

local function new_triangle()
	local t = Drawing.new("Triangle")
	t.Filled = true
	t.Color = Color3.fromRGB(255,255,255)
	t.Visible = false
	return t
end

local function track_player(p)
	if p == localplayer then return end
	if esp.tracked[p] then return end
	esp.tracked[p] = {
		name = new_text(),
		arrow = new_triangle()
	}
end

local function untrack_player(p)
   clear_player(p)
end

if not esp.connections.playeradded then
   esp.connections.playeradded = players.PlayerAdded:Connect(track_player)
end

if not esp.connections.playerremoving then
   esp.connections.playerremoving = players.PlayerRemoving:Connect(untrack_player)
end

if not esp.render_connection then
	esp.render_connection = runservice.RenderStepped:Connect(function()
		if not esp.enabled then return end

		local camera = getcamera()
		if not camera then return end

		local center = camera.ViewportSize / 2

		for p, d in pairs(esp.tracked) do
			local char = p.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")

			if not char or not root or not hum or hum.Health <= 0 then
				d.name.Visible = false
				d.arrow.Visible = false
				continue
			end

			local pos, onscreen = camera:WorldToViewportPoint(root.Position)

			if esp.name_enabled and onscreen then
				local dist = (camera.CFrame.Position - root.Position).Magnitude
				local size = math.clamp(1000 / dist, 10, 30)
				d.name.Text = p.Name
				d.name.Size = size
				d.name.Position = Vector2.new(pos.X, pos.Y)
				d.name.Visible = true
			else
				d.name.Visible = false
			end

			if esp.arrow_enabled and not onscreen then
				local rel = Vector2.new(root.Position.X - camera.CFrame.Position.X, root.Position.Z - camera.CFrame.Position.Z)
				if rel.Magnitude > 0 then
					local dir = rel.Unit
					local dist = 80
					local height = 16
					local width = 16
					local base = dir * dist
					local tip = dir * (dist + height)
					local side = Vector2.new(-dir.Y, dir.X) * (width / 2)

					d.arrow.PointA = center - (base + side)
					d.arrow.PointB = center - (base - side)
					d.arrow.PointC = center - tip
					d.arrow.Visible = true
				else
					d.arrow.Visible = false
				end
			else
				d.arrow.Visible = false
			end
		end
	end)
end

for _, p in ipairs(players:GetPlayers()) do
   track_player(p)
end

function esp.enable()
   esp.enabled = true
end

function esp.disable()
   esp.enabled = false
end

function esp.enable_name()
   esp.name_enabled = true
end

function esp.disable_name()
   esp.name_enabled = false
end

function esp.enable_arrow()
   esp.arrow_enabled = true
end

function esp.disable_arrow()
   esp.arrow_enabled = false
end

return esp
