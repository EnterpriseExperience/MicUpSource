local function safe_service(s)
    if cloneref then
        return cloneref(game:GetService(s))
    else
        return game:GetService(s)
    end
end
local Players = safe_service("Players")
local CoreGui = safe_service("CoreGui")
local Debris = safe_service("Debris")
local UserInputService = safe_service("UserInputService")
local RunService = safe_service("RunService")
pcall(function() sethiddenproperty(workspace, "StreamOutBehavior", Enum.StreamOutBehavior.Default) end)
local Config = {
    AreaSize = 10000,
    Radius = 1024,
    Slices = 2,
    RateLimit = 10,
    Timeout = 20,
    MaxRetries = 5,
    Passes = 1,
    GrowthThreshold = 5,
    GrowthCheckInterval = 1,
    IdleScaleDivisor = 400,
    MaxIdleMultiplier = 6,
    MinMonitorTime = 2
}

pcall(function() Config.Radius = gethiddenproperty(workspace, "StreamingTargetRadius") or Config.Radius end)
local function DescendantAdded(Object)
    if Object:IsA("Model") then
        Object.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
    end
end

local function make_draggable(frame)
	local dragging = false
	local drag_start = nil
	local start_pos = nil

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			drag_start = UserInputService:GetMouseLocation()
			start_pos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	RunService.RenderStepped:Connect(function()
		if dragging then
			local mouse_pos = UserInputService:GetMouseLocation()
			local delta = mouse_pos - drag_start
			local target = UDim2.new(
				start_pos.X.Scale,
				start_pos.X.Offset + delta.X,
				start_pos.Y.Scale,
				start_pos.Y.Offset + delta.Y
			)
			frame.Position = frame.Position:Lerp(target, 0.2)
		end
	end)
end

game.DescendantAdded:Connect(DescendantAdded)
for _, Descendant in ipairs(game:GetDescendants()) do DescendantAdded(Descendant) end
local LocalPlayer = Players.LocalPlayer
local GuiName = "Streamer7"
if CoreGui:FindFirstChild(GuiName) then CoreGui[GuiName]:Destroy() end
local IsRunning = false
local StopRequested = false
local Queue = {}
local ActiveVisuals = {}
local StatusLabel
local ActionButton
local TargetCFrame
local StatusData = {
    State = "Idle",
    PassIndex = 0,
    TotalPasses = Config.Passes,
    TotalJobs = 0,
    Completed = 0,
    Failed = 0,
    Retries = 0,
    InQueue = 0,
    InFlight = 0
}

local function ResetStatusCounters(TotalJobs)
    StatusData.TotalJobs = TotalJobs or 0
    StatusData.Completed = 0
    StatusData.Failed = 0
    StatusData.Retries = 0
    StatusData.InQueue = TotalJobs or 0
    StatusData.InFlight = 0
end

RunService.Heartbeat:Connect(function()
    if not IsRunning or not TargetCFrame then
        return
    end

    local Character = LocalPlayer.Character
    if Character and Character.PrimaryPart then
        Character:PivotTo(TargetCFrame)
    end
end)

local function UpdateStatus(StateText)
    if StateText then
        StatusData.State = StateText
    end

    local TotalJobs = StatusData.TotalJobs
    local ProgressPercent = 0

    if TotalJobs > 0 then
        ProgressPercent = math.clamp(math.floor((StatusData.Completed / TotalJobs) * 100), 0, 100)
    end

    if StatusLabel then
        StatusLabel.Text = string.format(
            [[<b>Status:</b> %s
            <b>Pass:</b> %d/%d
            <b>Progress:</b> %d%% (%d/%d)
            <b>Waiting:</b> %d queue | %d pending
            <b>Retries:</b> %d | <b>Failures:</b> %d]],
            StatusData.State,
            math.clamp(StatusData.PassIndex, 0, StatusData.TotalPasses),
            StatusData.TotalPasses,
            ProgressPercent,
            StatusData.Completed,
            StatusData.TotalJobs,
            StatusData.InQueue,
            StatusData.InFlight,
            StatusData.Retries,
            StatusData.Failed
        )
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GuiName
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui
ScreenGui.Enabled = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 220)
MainFrame.Position = UDim2.new(0, 20, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 32)
TitleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "Streamer7"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 16
TitleLabel.Parent = MainFrame

StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 1, -80)
StatusLabel.Position = UDim2.new(0, 10, 0, 40)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 13
StatusLabel.TextWrapped = true
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextYAlignment = Enum.TextYAlignment.Top
StatusLabel.RichText = true
StatusLabel.Parent = MainFrame
UpdateStatus("Idle")

ActionButton = Instance.new("TextButton")
ActionButton.Size = UDim2.new(0.9, 0, 0, 35)
ActionButton.AnchorPoint = Vector2.new(0.5, 1)
ActionButton.Position = UDim2.new(0.5, 0, 0.95, 0)
ActionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ActionButton.Text = "START STREAM"
ActionButton.Font = Enum.Font.GothamBold
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.TextSize = 14
ActionButton.Parent = MainFrame
Instance.new("UICorner", ActionButton).CornerRadius = UDim.new(0, 6)

make_draggable(MainFrame)

local function ClearVisuals()
    for _, Visual in ipairs(ActiveVisuals) do
        if Visual and Visual.Parent then
            Visual:Destroy()
        end
    end
    ActiveVisuals = {}
end

local function CreateVisual(Position, Radius)
    local Visual = Instance.new("Part")
    Visual.Name = "StreamVisual"
    Visual.Anchored = true
    Visual.CanCollide = false
    Visual.CastShadow = false
    Visual.Shape = Enum.PartType.Ball
    Visual.Material = Enum.Material.ForceField
    Visual.Size = Vector3.new(Radius * 2, Radius * 2, Radius * 2)
    Visual.Position = Position
    Visual.Color = Color3.fromRGB(255, 150, 0)
    Visual.Transparency = 0.8
    Visual.Parent = workspace
    table.insert(ActiveVisuals, Visual)
    return Visual
end

local function CountAnchoredParts(Parts)
    local Count = 0
    for _, Part in ipairs(Parts) do
        if Part:IsA("BasePart") and Part.Anchored then
            Count += 1
        end
    end
    return Count
end

local function GetPartCount(Position, Radius)
    local Ok, Parts = pcall(function()
        return workspace:GetPartBoundsInRadius(Position, Radius)
    end)

    if Ok and Parts then
        return CountAnchoredParts(Parts)
    end

    return 0
end

local function ComputeIdleAllowance(BaseIdle, PartCount)
    if PartCount <= 0 then
        return BaseIdle
    end

    local ExtraAllowance = math.floor(PartCount / Config.IdleScaleDivisor)
    return math.clamp(BaseIdle + ExtraAllowance, BaseIdle, BaseIdle * Config.MaxIdleMultiplier)
end

local function WaitForStableRegion(Position, Radius, IdleLimit)
    local CheckInterval = Config.GrowthCheckInterval
    local Threshold = math.max(1, Config.GrowthThreshold)
    local StagnantSeconds = 0
    local Elapsed = 0
    local MaxParts = GetPartCount(Position, Radius)
    local LastCount = MaxParts
    local PendingGrowth = 0
    local MinimumObserve = math.max(Config.MinMonitorTime, CheckInterval * 2)
    local DynamicIdle = IdleLimit

    while IsRunning do
        task.wait(CheckInterval)
        Elapsed += CheckInterval

        local Count = GetPartCount(Position, Radius)
        local Delta = math.max(0, Count - LastCount)
        LastCount = Count

        if Delta > 0 then
            PendingGrowth += Delta
            if PendingGrowth >= Threshold then
                MaxParts = math.max(MaxParts, Count)
                PendingGrowth = 0
                StagnantSeconds = 0
                DynamicIdle = ComputeIdleAllowance(IdleLimit, MaxParts)
            else
                StagnantSeconds = math.max(0, StagnantSeconds - CheckInterval * 0.5)
            end
        else
            PendingGrowth = math.max(0, PendingGrowth - Threshold * 0.25)
            StagnantSeconds += CheckInterval
        end

        if Elapsed >= MinimumObserve and StagnantSeconds >= DynamicIdle then
            break
        end
    end

    return MaxParts > 0
end

getgenv().WaitForStableRegion = WaitForStableRegion

local function BuildQueue(OriginPosition)
    Queue = {}
    ClearVisuals()

    local AreaSize = Config.AreaSize
    local Slices = Config.Slices
    local Step = Config.Radius
    local Half = AreaSize / 2
    local MinX, MaxX = OriginPosition.X - Half, OriginPosition.X + Half
    local MinZ, MaxZ = OriginPosition.Z - Half, OriginPosition.Z + Half
    local StartYIndex = -math.floor((Slices - 1) / 2)

    for X = MinX, MaxX, Step do
        for Z = MinZ, MaxZ, Step do
            for SliceIndex = 0, Slices - 1 do
                local YOffset = (StartYIndex + SliceIndex) * (Config.Radius * 0.8)
                local TargetPosition = Vector3.new(X, OriginPosition.Y + YOffset, Z)
                local Visual = CreateVisual(TargetPosition, Config.Radius)
                table.insert(Queue, {
                    Position = TargetPosition,
                    Visual = Visual,
                    Retries = 0
                })
            end
        end
    end

    return #Queue
end

getgenv().BuildQueue = BuildQueue

local function ProcessQueue()
    local RequestsPerSecond = math.max(1, Config.RateLimit)
    local TimeoutSeconds = Config.Timeout
    local WaitTime = 1 / RequestsPerSecond

    while IsRunning and #Queue > 0 do
        local Job = table.remove(Queue, 1)
        StatusData.InQueue = #Queue
        StatusData.InFlight += 1
        UpdateStatus("Streaming chunks...")

        task.spawn(function()
            local function Finalize(Result)
                StatusData.InFlight = math.max(0, StatusData.InFlight - 1)
                if Result == "success" then
                    StatusData.Completed += 1
                elseif Result == "failed" then
                    StatusData.Completed += 1
                    StatusData.Failed += 1
                end
                UpdateStatus()
            end

            if not IsRunning then
                Finalize()
                return
            end

            if Job.Visual and Job.Visual.Parent then
                Job.Visual.Color = Color3.fromRGB(0, 100, 255)
            end

            local StreamFinished = false

            pcall(function()
                local Character = LocalPlayer.Character
                if Character and Character.PrimaryPart then
                    local Target = CFrame.new(Job.Position)
                    Character:PivotTo(Target)
                    TargetCFrame = Target

                    task.spawn(function()
                        pcall(function()
                            LocalPlayer:RequestStreamAroundAsync(Job.Position, TimeoutSeconds)
                        end)
                    end)

                    if WaitForStableRegion(Job.Position, Config.Radius, TimeoutSeconds) then
                        StreamFinished = true
                    end
                else
                    error("Character missing")
                end
            end)

            if StreamFinished then
                if Job.Visual and Job.Visual.Parent then
                    Job.Visual.Color = Color3.fromRGB(0, 255, 0)
                    Job.Visual.Transparency = 0.9
                    Debris:AddItem(Job.Visual, 5)
                end
                getgenv().Streaming_Parts_In_Has_Finished = true
                Finalize("success")
                return
            end

            Job.Retries += 1
            StatusData.Retries += 1

            if Job.Retries < Config.MaxRetries then
                if Job.Visual and Job.Visual.Parent then
                    Job.Visual.Color = Color3.fromRGB(255, 0, 0)
                end
                table.insert(Queue, Job)
                StatusData.InQueue = #Queue
                Finalize()
                UpdateStatus("Retrying chunk...")
            else
                if Job.Visual and Job.Visual.Parent then
                    Job.Visual.Color = Color3.fromRGB(100, 0, 0)
                    Job.Visual.Transparency = 0.5
                    Debris:AddItem(Job.Visual, 10)
                end
                Finalize("failed")
            end
        end)

        task.wait(WaitTime)
    end

    if not IsRunning then
        return
    end

    while StatusData.InFlight > 0 and IsRunning do
        UpdateStatus("Waiting on active chunks...")
        task.wait(0.2)
    end

    if IsRunning then
        UpdateStatus("Complete")
        ActionButton.Text = "START STREAM"
        ActionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        IsRunning = false
    end

    if not IsRunning then
        TargetCFrame = nil
    end
end

getgenv().ProcessQueue = ProcessQueue

local function StartStream()
    if IsRunning then
        StopRequested = true
        IsRunning = false
        Queue = {}
        TargetCFrame = nil
        UpdateStatus("Stopping...")
        ActionButton.Text = "START STREAM"
        ActionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        return
    end

    StopRequested = false
    StatusData.TotalPasses = Config.Passes

    for PassIndex = 1, Config.Passes do
        if StopRequested then break end
        StatusData.PassIndex = PassIndex
        local Character = LocalPlayer.Character
        local Origin = Character and Character:GetPivot().Position or Vector3.new(0, 50, 0)
        UpdateStatus("Generating grid...")
        local TotalJobs = BuildQueue(Origin)
        ResetStatusCounters(TotalJobs)

        if TotalJobs == 0 then
            UpdateStatus("No chunks queued")
            break
        end

        IsRunning = true
        ActionButton.Text = "STOP"
        ActionButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        UpdateStatus("Starting pass...")

        task.spawn(ProcessQueue)
        repeat task.wait(0.1) until not IsRunning or StopRequested
        if Character and Character.PrimaryPart then Character:PivotTo(CFrame.new(Origin)) end
        if StopRequested then break end
    end

    StopRequested = false
    if not IsRunning then TargetCFrame = nil UpdateStatus("Idle") end
end

getgenv().StartStream = StartStream

ActionButton.MouseButton1Click:Connect(StartStream)
