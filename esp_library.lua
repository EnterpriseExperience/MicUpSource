-- // table
local esplib = getgenv().esplib
if not esplib then
    esplib = {
        box = {
            enabled = true,
            type = "normal", -- normal, corner
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
            from = "mouse", -- mouse, head, top, bottom, center
        },
    }
    getgenv().esplib = esplib
end

local espinstances = {}
local espfunctions = {}

-- // services
local run_service = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local user_input_service = cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")
local workspace = Workspace
local camera = workspace.CurrentCamera

-- // functions
local function get_bounding_box(instance)
    local min, max = Vector2.new(math.huge, math.huge), Vector2.new(-math.huge, -math.huge)
    local onscreen = false

    if instance:IsA("Model") then
        for _, p in ipairs(instance:GetChildren()) do
            if p:IsA("BasePart") then
                local size = (p.Size / 2) * esplib.box.padding
                local cf = p.CFrame
                for _, offset in ipairs({
                    Vector3.new( size.X,  size.Y,  size.Z),
                    Vector3.new(-size.X,  size.Y,  size.Z),
                    Vector3.new( size.X, -size.Y,  size.Z),
                    Vector3.new(-size.X, -size.Y,  size.Z),
                    Vector3.new( size.X,  size.Y, -size.Z),
                    Vector3.new(-size.X,  size.Y, -size.Z),
                    Vector3.new( size.X, -size.Y, -size.Z),
                    Vector3.new(-size.X, -size.Y, -size.Z),
                }) do
                    local pos, visible = camera:WorldToViewportPoint(cf:PointToWorldSpace(offset))
                    if visible then
                        local v2 = Vector2.new(pos.X, pos.Y)
                        min = min:Min(v2)
                        max = max:Max(v2)
                        onscreen = true
                    end
                end
            elseif p:IsA("Accessory") then
                local handle = p:FindFirstChild("Handle")
                if handle and handle:IsA("BasePart") then
                    local size = (handle.Size / 2) * esplib.box.padding
                    local cf = handle.CFrame
                    for _, offset in ipairs({
                        Vector3.new( size.X,  size.Y,  size.Z),
                        Vector3.new(-size.X,  size.Y,  size.Z),
                        Vector3.new( size.X, -size.Y,  size.Z),
                        Vector3.new(-size.X, -size.Y,  size.Z),
                        Vector3.new( size.X,  size.Y, -size.Z),
                        Vector3.new(-size.X,  size.Y, -size.Z),
                        Vector3.new( size.X, -size.Y, -size.Z),
                        Vector3.new(-size.X, -size.Y, -size.Z),
                    }) do
                        local pos, visible = camera:WorldToViewportPoint(cf:PointToWorldSpace(offset))
                        if visible then
                            local v2 = Vector2.new(pos.X, pos.Y)
                            min = min:Min(v2)
                            max = max:Max(v2)
                            onscreen = true
                        end
                    end
                end
            end
        end
    elseif instance:IsA("BasePart") then
        local size = (instance.Size / 2)
        local cf = instance.CFrame
        for _, offset in ipairs({
            Vector3.new( size.X,  size.Y,  size.Z),
            Vector3.new(-size.X,  size.Y,  size.Z),
            Vector3.new( size.X, -size.Y,  size.Z),
            Vector3.new(-size.X, -size.Y,  size.Z),
            Vector3.new( size.X,  size.Y, -size.Z),
            Vector3.new(-size.X,  size.Y, -size.Z),
            Vector3.new( size.X, -size.Y, -size.Z),
            Vector3.new(-size.X, -size.Y, -size.Z),
        }) do
            local pos, visible = camera:WorldToViewportPoint(cf:PointToWorldSpace(offset))
            if visible then
                local v2 = Vector2.new(pos.X, pos.Y)
                min = min:Min(v2)
                max = max:Max(v2)
                onscreen = true
            end
        end
    end

    return min, max, onscreen
end

function espfunctions.add_box(instance)
    if not instance or espinstances[instance] and espinstances[instance].box then return end

    local box = {}

    local outline = Drawing.new("Square")
    outline.Thickness = 3
    outline.Filled = false
    outline.Transparency = 1
    outline.Visible = false

    local fill = Drawing.new("Square")
    fill.Thickness = 1
    fill.Filled = false
    fill.Transparency = 1
    fill.Visible = false

    box.outline = outline
    box.fill = fill

    box.corner_fill = {}
    box.corner_outline = {}
    for i = 1, 8 do
        local outline = Drawing.new("Line")
        outline.Thickness = 3
        outline.Transparency = 1
        outline.Visible = false

        local fill = Drawing.new("Line")
        fill.Thickness = 1
        fill.Transparency = 1
        fill.Visible = false
        table.insert(box.corner_fill, fill)

        table.insert(box.corner_outline, outline)
    end

    espinstances[instance] = espinstances[instance] or {}
    espinstances[instance].box = box
end

function espfunctions.remove_box()
    if espinstances then
        for instance, data in pairs(espinstances) do
            if data.box then
                local box = data.box
    
                if box.fill and typeof(box.fill) == "Drawing" then
                    box.fill:Remove()
                end
                if box.outline and typeof(box.outline) == "Drawing" then
                    box.outline:Remove()
                end
    
                if box.corner_fill then
                    for _, obj in ipairs(box.corner_fill) do
                        if typeof(obj) == "Drawing" then
                            obj:Remove()
                        end
                    end
                end
                if box.corner_outline then
                    for _, obj in ipairs(box.corner_outline) do
                        if typeof(obj) == "Drawing" then
                            obj:Remove()
                        end
                    end
                end
    
                data.box = nil
            end
        end
    end
end

function espfunctions.add_healthbar(instance)
    if not instance or espinstances[instance] and espinstances[instance].healthbar then return end
    local outline = Drawing.new("Square")
    outline.Thickness = 1
    outline.Filled = true
    outline.Transparency = 1

    local fill = Drawing.new("Square")
    fill.Filled = true
    fill.Transparency = 1

    espinstances[instance] = espinstances[instance] or {}
    espinstances[instance].healthbar = {
        outline = outline,
        fill = fill,
    }
end

function espfunctions.remove_healthbar()
    if espinstances then
        for instance, data in pairs(espinstances) do
            if data.healthbar then
                local hb = data.healthbar
    
                if hb.outline and typeof(hb.outline) == "Drawing" then
                    hb.outline:Remove()
                end
                if hb.fill and typeof(hb.fill) == "Drawing" then
                    hb.fill:Remove()
                end
    
                data.healthbar = nil
            end
        end
    end
end

function espfunctions.add_name(instance)
    if not instance or espinstances[instance] and espinstances[instance].name then return end
    local text = Drawing.new("Text")
    text.Center = true
    text.Outline = true
    text.Font = 1
    text.Transparency = 1

    espinstances[instance] = espinstances[instance] or {}
    espinstances[instance].name = text
end

function espfunctions.remove_name()
    if espinstances then
        for instance, data in pairs(espinstances) do
            if data.name and typeof(data.name) == "Drawing" then
                data.name:Remove()
                data.name = nil
            end
        end
    end
end

function espfunctions.add_distance(instance)
    if not instance or espinstances[instance] and espinstances[instance].distance then return end
    local text = Drawing.new("Text")
    text.Center = true
    text.Outline = true
    text.Font = 1
    text.Transparency = 1

    espinstances[instance] = espinstances[instance] or {}
    espinstances[instance].distance = text
end

function espfunctions.remove_distance()
    if espinstances then
        for instance, data in pairs(espinstances) do
            if data.distance and typeof(data.distance) == "Drawing" then
                data.distance:Remove()
                data.distance = nil
            end
        end
    end
end

function espfunctions.add_tracer(instance)
    if not instance or espinstances[instance] and espinstances[instance].tracer then return end
    local outline = Drawing.new("Line")
    outline.Thickness = 3
    outline.Transparency = 1

    local fill = Drawing.new("Line")
    fill.Thickness = 1
    fill.Transparency = 1

    espinstances[instance] = espinstances[instance] or {}
    espinstances[instance].tracer = {
        outline = outline,
        fill = fill,
    }
end

function espfunctions.remove_tracer()
    if espinstances then
        for instance, data in pairs(espinstances) do
            if data.tracer then
                local tracer = data.tracer
    
                if tracer.outline and typeof(tracer.outline) == "Drawing" then
                    tracer.outline:Remove()
                end
                if tracer.fill and typeof(tracer.fill) == "Drawing" then
                    tracer.fill:Remove()
                end
    
                data.tracer = nil
            end
        end
    end
end

-- // main thread
run_service.RenderStepped:Connect(function()
    for instance, data in pairs(espinstances) do
        if not instance or not instance.Parent then
            if data.box then
                data.box.outline:Remove()
                data.box.fill:Remove()
                for _, line in ipairs(data.box.corner_fill) do
                    line:Remove()
                end
                for _, line in ipairs(data.box.corner_outline) do
                    line:Remove()
                end
            end
            if data.healthbar then
                data.healthbar.outline:Remove()
                data.healthbar.fill:Remove()
            end
            if data.name then
                data.name:Remove()
            end
            if data.distance then
                data.distance:Remove()
            end
            if data.tracer then
                data.tracer.outline:Remove()
                data.tracer.fill:Remove()
            end
            espinstances[instance] = nil
            continue
        end

        if instance:IsA("Model") and not instance.PrimaryPart then
            continue
        end

        local min, max, onscreen = get_bounding_box(instance)

        if data.box then
            local box = data.box

            if esplib.box.enabled and onscreen then
                local x, y = min.X, min.Y
                local w, h = (max - min).X, (max - min).Y
                local len = math.min(w, h) * 0.25

                if esplib.box.type == "normal" then
                    box.outline.Position = min
                    box.outline.Size = max - min
                    box.outline.Color = esplib.box.outline
                    box.outline.Visible = true

                    box.fill.Position = min
                    box.fill.Size = max - min
                    box.fill.Color = esplib.box.fill
                    box.fill.Visible = true

                    for _, line in ipairs(box.corner_fill) do
                        line.Visible = false
                    end
                    for _, line in ipairs(box.corner_outline) do
                        line.Visible = false
                    end

                elseif esplib.box.type == "corner" then
                    local fill_lines = box.corner_fill
                    local outline_lines = box.corner_outline
                    local fill_color = esplib.box.fill
                    local outline_color = esplib.box.outline

                    local corners = {
                        { Vector2.new(x, y), Vector2.new(x + len, y) },
                        { Vector2.new(x, y), Vector2.new(x, y + len) },

                        { Vector2.new(x + w - len, y), Vector2.new(x + w, y) },
                        { Vector2.new(x + w, y), Vector2.new(x + w, y + len) },

                        { Vector2.new(x, y + h), Vector2.new(x + len, y + h) },
                        { Vector2.new(x, y + h - len), Vector2.new(x, y + h) },

                        { Vector2.new(x + w - len, y + h), Vector2.new(x + w, y + h) },
                        { Vector2.new(x + w, y + h - len), Vector2.new(x + w, y + h) },
                    }

                    for i = 1, 8 do
                        local from, to = corners[i][1], corners[i][2]
                        local dir = (to - from).Unit
                        local oFrom = from - dir
                        local oTo = to + dir

                        local o = outline_lines[i]
                        o.From = oFrom
                        o.To = oTo
                        o.Color = outline_color
                        o.Visible = true

                        local f = fill_lines[i]
                        f.From = from
                        f.To = to
                        f.Color = fill_color
                        f.Visible = true
                    end

                    box.outline.Visible = false
                    box.fill.Visible = false
                end
            else
                box.outline.Visible = false
                box.fill.Visible = false
                for _, line in ipairs(box.corner_fill) do
                    line.Visible = false
                end
                for _, line in ipairs(box.corner_outline) do
                    line.Visible = false
                end
            end
        end

        if data.healthbar then
            local outline, fill = data.healthbar.outline, data.healthbar.fill

            if not esplib.healthbar.enabled or not onscreen then
                outline.Visible = false
                fill.Visible = false
            else
                local humanoid = instance:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local height = max.Y - min.Y
                    local padding = 1
                    local x = min.X - 3 - 1 - padding
                    local y = min.Y - padding
                    local health = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                    local fillheight = height * health

                    outline.Color = esplib.healthbar.outline
                    outline.Position = Vector2.new(x, y)
                    outline.Size = Vector2.new(1 + 2 * padding, height + 2 * padding)
                    outline.Visible = true

                    fill.Color = esplib.healthbar.fill
                    fill.Position = Vector2.new(x + padding, y + (height + padding) - fillheight)
                    fill.Size = Vector2.new(1, fillheight)
                    fill.Visible = true
                else
                    outline.Visible = false
                    fill.Visible = false
                end
            end
        end

        if data.name then
            if esplib.name.enabled and onscreen then
                local text = data.name
                local center_x = (min.X + max.X) / 2
                local y = min.Y - 15

                local name_str = instance.Name
                local humanoid = instance:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local player = players:GetPlayerFromCharacter(instance)
                    if player then
                        name_str = player.Name
                    end
                end

                text.Text = name_str
                text.Size = esplib.name.size
                text.Color = esplib.name.fill
                text.Position = Vector2.new(center_x, y)
                text.Visible = true
            else
                data.name.Visible = false
            end
        end

        if data.distance then
            if esplib.distance.enabled and onscreen then
                local text = data.distance
                local center_x = (min.X + max.X) / 2
                local y = max.Y + 5
                local dist
                if instance:IsA("Model") then
                    if instance.PrimaryPart then
                        dist = (camera.CFrame.Position - instance.PrimaryPart.Position).Magnitude
                    else
                        local part = instance:FindFirstChildWhichIsA("BasePart")
                        if part then
                            dist = (camera.CFrame.Position - part.Position).Magnitude
                        else
                            dist = 999
                        end
                    end
                else
                    dist = (camera.CFrame.Position - instance.Position).Magnitude
                end
                text.Text = tostring(math.floor(dist)) .. "m"
                text.Size = esplib.distance.size
                text.Color = esplib.distance.fill
                text.Position = Vector2.new(center_x, y)
                text.Visible = true
            else
                data.distance.Visible = false
            end
        end

        if data.tracer then
            if esplib.tracer.enabled and onscreen then
                local outline, fill = data.tracer.outline, data.tracer.fill

                local from_pos = Vector2.new()
                local to_pos = Vector2.new()

                if esplib.tracer.from == "mouse" then
                    local mouse_location = user_input_service:GetMouseLocation()
                    from_pos = Vector2.new(mouse_location.X, mouse_location.Y)
                elseif esplib.tracer.from == "head" then
                    local head = instance:FindFirstChild("Head")
                    if head then
                        local pos, visible = camera:WorldToViewportPoint(head.Position)
                        if visible then
                            from_pos = Vector2.new(pos.X, pos.Y)
                        else
                            from_pos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                        end
                    else
                        from_pos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                    end
                elseif esplib.tracer.from == "bottom" then
                    from_pos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                elseif esplib.tracer.from == "center" then
                    from_pos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                else
                    from_pos = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                end

                to_pos = (min + max) / 2

                outline.From = from_pos
                outline.To = to_pos
                outline.Color = esplib.tracer.outline
                outline.Visible = true

                fill.From = from_pos
                fill.To = to_pos
                fill.Color = esplib.tracer.fill
                fill.Visible = true
            else
                data.tracer.outline.Visible = false
                data.tracer.fill.Visible = false
            end
        end
    end
end)

for k, v in pairs(espfunctions) do
    esplib[k] = v
end

return esplib
