if not game:IsLoaded() then game.Loaded:Wait() end

if not getgenv().GlobalEnvironmentFramework_Initialized then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
	task.wait(0.1)
	getgenv().GlobalEnvironmentFramework_Initialized = true
end

getgenv().reaction_time_minigame = function()
    getgenv().timing_game = getgenv().timing_game or {}
    local tg = getgenv().timing_game

    local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
    local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

    if tg.renderConn then tg.renderConn:Disconnect() end
    if tg.gui then tg.gui:Destroy() end

    local MAX_WINS = 5
    local MAX_MISSES = 3
    local PURPLE = Color3.fromRGB(170, 85, 255)
    local DARK   = Color3.fromRGB(18, 18, 18)
    local WHITE  = Color3.fromRGB(240, 240, 240)
    local RED    = Color3.fromRGB(200, 60, 60)

    tg.wins = 0
    tg.misses = 0
    tg.speed = 0.6

    local gui = Instance.new("ScreenGui")
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui
    tg.gui = gui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(0.9, 0.32)
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = DARK
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

    local uiScale = Instance.new("UIScale")
    uiScale.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.fromScale(0.9, 0.25)
    bar.Position = UDim2.fromScale(0.05, 0.55)
    bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    bar.Parent = frame
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 14)

    local target = Instance.new("Frame")
    target.Size = UDim2.fromScale(0.12, 1)
    target.BackgroundColor3 = PURPLE
    target.Parent = bar
    Instance.new("UICorner", target).CornerRadius = UDim.new(0, 12)

    local arrow = Instance.new("Frame")
    arrow.Size = UDim2.fromScale(0.05, 1)
    arrow.BackgroundColor3 = WHITE
    arrow.Parent = bar
    Instance.new("UICorner", arrow).CornerRadius = UDim.new(0, 10)

    local feedback = Instance.new("TextLabel")
    feedback.Size = UDim2.fromScale(1, 0.25)
    feedback.Position = UDim2.fromScale(0, 0)
    feedback.BackgroundTransparency = 1
    feedback.TextScaled = true
    feedback.Font = Enum.Font.GothamBold
    feedback.TextColor3 = WHITE
    feedback.Text = "CLICK!"
    feedback.Parent = frame

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.fromScale(0.12, 0.22)
    cancel.Position = UDim2.fromScale(0.88, 0.02)
    cancel.AnchorPoint = Vector2.new(1, 0)
    cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    cancel.Text = "✕"
    cancel.TextScaled = true
    cancel.Font = Enum.Font.GothamBold
    cancel.TextColor3 = WHITE
    cancel.Parent = frame
    Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 12)

    local function flash(text, color)
        feedback.Text = text
        feedback.TextColor3 = color
        task.delay(0.35, function()
            if tg.wins < MAX_WINS and tg.misses < MAX_MISSES then
                feedback.Text = "CLICK!"
                feedback.TextColor3 = WHITE
            end
        end)
    end

    local function cleanup()
        if tg.renderConn then
            tg.renderConn:Disconnect()
        end
        if tg.gui then
            tg.gui:Destroy()
        end
    end

    local function win()
        if getgenv().notify then
            getgenv().notify("Success", "You've won the mini-game, you may now proceed.", 5)
        else
            print("You have won the mini-game.")
        end
        task.delay(0.1, cleanup)
    end

    local function fail(msg)
        if getgenv().notify then
            getgenv().notify("Error", msg or "You did not win the mini-game, you may not proceed.", 5)
        else
            warn(msg or "You have failed the mini-game.")
        end
        task.delay(0.1, cleanup)
    end

    cancel.MouseButton1Click:Connect(function()
        fail("Mini-game cancelled.")
    end)

    local function newTarget()
        target.Position = UDim2.fromScale(math.random(10, 78) / 100, 0)
    end

    newTarget()

    local dir = 1
    local pos = 0

    tg.renderConn = RunService.RenderStepped:Connect(function(dt)
        pos += dt * tg.speed * dir
        if pos >= 0.95 then dir = -1 end
        if pos <= 0 then dir = 1 end
        arrow.Position = UDim2.fromScale(pos, 0)
    end)

    local click = Instance.new("TextButton")
    click.Size = UDim2.fromScale(1, 1)
    click.Position = UDim2.fromScale(0, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.Parent = frame

    click.MouseButton1Click:Connect(function()
        local aMin = arrow.Position.X.Scale
        local aMax = aMin + arrow.Size.X.Scale
        local tMin = target.Position.X.Scale
        local tMax = tMin + target.Size.X.Scale

        local overlap = math.min(aMax, tMax) - math.max(aMin, tMin)

        if overlap > 0 then
            local centerDist = math.abs((aMin + aMax)/2 - (tMin + tMax)/2)
            if centerDist < 0.02 then
                flash("PERFECT", Color3.fromRGB(180, 255, 255))
            else
                flash("GOOD", PURPLE)
            end
            tg.wins += 1
            tg.speed += 0.15
            newTarget()
            if tg.wins >= MAX_WINS then
                win()
            end
        else
            tg.misses += 1
            flash("BAD", RED)
            if tg.misses >= MAX_MISSES then
                fail()
            end
        end
    end)
end
