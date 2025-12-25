local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local runservice = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local userinputservice = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local localplayer = players.LocalPlayer
local esp = {
    enabled = false,
    name_enabled = false,
    arrow_enabled = false
}
local tracked = {}
local connections = {}
local render_connection

local function getcamera()
    return workspace.CurrentCamera
end

local function safe_remove(obj)
    if obj and obj.Remove then
        obj:Remove()
    end
end

local function clear_player(plr)
    local data = tracked[plr]
    if not data then return end

    safe_remove(data.name)
    safe_remove(data.arrow)

    tracked[plr] = nil
end

local function clear_all()
    for plr in pairs(tracked) do
        clear_player(plr)
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

local function track_player(plr)
    if plr == localplayer then return end
    if tracked[plr] then return end

    tracked[plr] = {
        name = new_text(),
        arrow = new_triangle()
    }
end

local function untrack_player(plr)
    clear_player(plr)
end

local function enable()
    if esp.enabled then return end
    esp.enabled = true

    for _, p in ipairs(players:GetPlayers()) do
        track_player(p)
    end

    connections.playeradded = players.PlayerAdded:Connect(track_player)
    connections.playerremoving = players.PlayerRemoving:Connect(untrack_player)

    render_connection = runservice.RenderStepped:Connect(function()
        if not esp.enabled then return end

        local camera = getcamera()
        if not camera then return end

        local center = camera.ViewportSize / 2

        for plr, data in pairs(tracked) do
            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")

            if not char or not root or not hum or hum.Health <= 0 then
                data.name.Visible = false
                data.arrow.Visible = false
                continue
            end

            local pos, onscreen = camera:WorldToViewportPoint(root.Position)

            if esp.name_enabled and onscreen then
                local dist = (camera.CFrame.Position - root.Position).Magnitude
                local size = math.clamp(1 / dist * 1000, 10, 30)
                data.name.Text = plr.Name
                data.name.Size = size
                data.name.Position = Vector2.new(pos.X, pos.Y)
                data.name.Visible = true
            else
                data.name.Visible = false
            end

            if esp.arrow_enabled and not onscreen then
                local rel = (CFrame.new(root.Position, camera.CFrame.Position):PointToObjectSpace(root.Position))
                local dir = Vector2.new(rel.X, rel.Z)
                if dir.Magnitude > 0 then
                    dir = dir.Unit
                    local dist = 80
                    local height = 16
                    local width = 16

                    local base = dir * dist
                    local tip = dir * (dist + height)
                    local side = Vector2.new(-dir.Y, dir.X) * (width / 2)

                    data.arrow.PointA = center - (base + side)
                    data.arrow.PointB = center - (base - side)
                    data.arrow.PointC = center - tip
                    data.arrow.Visible = true
                else
                    data.arrow.Visible = false
                end
            else
                data.arrow.Visible = false
            end
        end
    end)
end

local function disable()
    if not esp.enabled then return end
    esp.enabled = false

    if render_connection then
        render_connection:Disconnect()
        render_connection = nil
    end

    for _, c in pairs(connections) do
        c:Disconnect()
    end
    connections = {}

    clear_all()
end

esp.enable = enable
esp.disable = disable

esp.enable_name = function()
    esp.name_enabled = true
end

esp.disable_name = function()
    esp.name_enabled = false
end

esp.enable_arrow = function()
    esp.arrow_enabled = true
end

esp.disable_arrow = function()
    esp.arrow_enabled = false
end

getgenv().playeresp = esp

return esp
