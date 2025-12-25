local esplib = getgenv().esplib
if not esplib then
    esplib = {
        enabled = true,

        box = {
            enabled = true,
            type = "normal",
            padding = 1.15,
            fill = Color3.new(1,1,1),
            outline = Color3.new(0,0,0),
        },

        healthbar = {
            enabled = true,
            fill = Color3.new(0,1,0),
            outline = Color3.new(0,0,0),
        },

        name = {
            enabled = true,
            fill = Color3.new(1,1,1),
            size = 13,
        },

        distance = {
            enabled = true,
            fill = Color3.new(1,1,1),
            size = 13,
        },

        tracer = {
            enabled = true,
            fill = Color3.new(1,1,1),
            outline = Color3.new(0,0,0),
            from = "mouse",
        },
    }

    getgenv().esplib = esplib
end

local espinstances = {}
local espfunctions = {}

local run_service = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local user_input_service = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local workspace = Workspace
local camera = workspace.CurrentCamera

local render_connection

local function safe_remove(obj)
    if obj and obj.Remove then
        obj:Remove()
    end
end

local function clear_instance(instance)
    local data = espinstances[instance]
    if not data then return end

    if data.box then
        safe_remove(data.box.fill)
        safe_remove(data.box.outline)
        for _, v in ipairs(data.box.corner_fill or {}) do
            safe_remove(v)
        end
        for _, v in ipairs(data.box.corner_outline or {}) do
            safe_remove(v)
        end
    end

    if data.healthbar then
        safe_remove(data.healthbar.fill)
        safe_remove(data.healthbar.outline)
    end

    safe_remove(data.name)
    safe_remove(data.distance)

    if data.tracer then
        safe_remove(data.tracer.fill)
        safe_remove(data.tracer.outline)
    end

    espinstances[instance] = nil
end

function espfunctions.clear()
    for instance in pairs(espinstances) do
        clear_instance(instance)
    end
end

function espfunctions.disable()
    esplib.enabled = false
    if render_connection then
        render_connection:Disconnect()
        render_connection = nil
    end
    espfunctions.clear()
end

function espfunctions.enable()
    if esplib.enabled and render_connection then return end
    esplib.enabled = true

    render_connection = run_service.RenderStepped:Connect(function()
        if not esplib.enabled then return end

        for instance in pairs(espinstances) do
            if not instance or not instance.Parent then
                clear_instance(instance)
            end
        end

        for instance, data in pairs(espinstances) do
            if not instance.Parent then continue end

            local min = Vector2.new(math.huge, math.huge)
            local max = Vector2.new(-math.huge, -math.huge)
            local onscreen = false

            local function process_part(part)
                local size = (part.Size / 2) * esplib.box.padding
                local cf = part.CFrame
                for _, off in ipairs({
                    Vector3.new( size.X,  size.Y,  size.Z),
                    Vector3.new(-size.X,  size.Y,  size.Z),
                    Vector3.new( size.X, -size.Y,  size.Z),
                    Vector3.new(-size.X, -size.Y,  size.Z),
                    Vector3.new( size.X,  size.Y, -size.Z),
                    Vector3.new(-size.X,  size.Y, -size.Z),
                    Vector3.new( size.X, -size.Y, -size.Z),
                    Vector3.new(-size.X, -size.Y, -size.Z),
                }) do
                    local pos, vis = camera:WorldToViewportPoint(cf:PointToWorldSpace(off))
                    if vis then
                        local v = Vector2.new(pos.X, pos.Y)
                        min = min:Min(v)
                        max = max:Max(v)
                        onscreen = true
                    end
                end
            end

            if instance:IsA("Model") then
                for _, v in ipairs(instance:GetDescendants()) do
                    if v:IsA("BasePart") then
                        process_part(v)
                    end
                end
            elseif instance:IsA("BasePart") then
                process_part(instance)
            end

            if not onscreen then
                if data.box then
                    data.box.fill.Visible = false
                    data.box.outline.Visible = false
                end
                if data.healthbar then
                    data.healthbar.fill.Visible = false
                    data.healthbar.outline.Visible = false
                end
                if data.name then data.name.Visible = false end
                if data.distance then data.distance.Visible = false end
                if data.tracer then
                    data.tracer.fill.Visible = false
                    data.tracer.outline.Visible = false
                end
                continue
            end

            local size = max - min
            local center = (min + max) / 2

            if data.box and esplib.box.enabled then
                data.box.outline.Position = min
                data.box.outline.Size = size
                data.box.outline.Color = esplib.box.outline
                data.box.outline.Visible = true

                data.box.fill.Position = min
                data.box.fill.Size = size
                data.box.fill.Color = esplib.box.fill
                data.box.fill.Visible = true
            end

            if data.name and esplib.name.enabled then
                data.name.Text = instance.Name
                data.name.Size = esplib.name.size
                data.name.Color = esplib.name.fill
                data.name.Position = Vector2.new(center.X, min.Y - 15)
                data.name.Visible = true
            end

            if data.distance and esplib.distance.enabled then
                local part = instance:IsA("Model") and instance.PrimaryPart or instance
                if part then
                    local d = (camera.CFrame.Position - part.Position).Magnitude
                    data.distance.Text = tostring(math.floor(d)) .. "m"
                    data.distance.Size = esplib.distance.size
                    data.distance.Color = esplib.distance.fill
                    data.distance.Position = Vector2.new(center.X, max.Y + 5)
                    data.distance.Visible = true
                end
            end

            if data.tracer and esplib.tracer.enabled then
                local from = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                if esplib.tracer.from == "mouse" then
                    local m = user_input_service:GetMouseLocation()
                    from = Vector2.new(m.X, m.Y)
                end

                data.tracer.outline.From = from
                data.tracer.outline.To = center
                data.tracer.outline.Color = esplib.tracer.outline
                data.tracer.outline.Visible = true

                data.tracer.fill.From = from
                data.tracer.fill.To = center
                data.tracer.fill.Color = esplib.tracer.fill
                data.tracer.fill.Visible = true
            end
        end
    end)
end

function espfunctions.add_box(instance)
    if not instance then return end
    espinstances[instance] = espinstances[instance] or {}
    if espinstances[instance].box then return end

    espinstances[instance].box = {
        outline = Drawing.new("Square"),
        fill = Drawing.new("Square"),
        corner_fill = {},
        corner_outline = {},
    }
end

function espfunctions.add_name(instance)
    espinstances[instance] = espinstances[instance] or {}
    if espinstances[instance].name then return end
    local t = Drawing.new("Text")
    t.Center = true
    t.Outline = true
    espinstances[instance].name = t
end

function espfunctions.add_distance(instance)
    espinstances[instance] = espinstances[instance] or {}
    if espinstances[instance].distance then return end
    local t = Drawing.new("Text")
    t.Center = true
    t.Outline = true
    espinstances[instance].distance = t
end

function espfunctions.add_tracer(instance)
    espinstances[instance] = espinstances[instance] or {}
    if espinstances[instance].tracer then return end
    espinstances[instance].tracer = {
        outline = Drawing.new("Line"),
        fill = Drawing.new("Line"),
    }
end

for k, v in pairs(espfunctions) do
    esplib[k] = v
end

if esplib.enabled then
    espfunctions.enable()
end

return esplib
