-- HttpSpy GUI v1.3.1 for all executors.
-- Final complete version with request function fixes, old HttpPost error fix, and more.

local ok_request_functionality =
    request
    or http_request
    or (syn and syn.request)
    or (http and http.request)
    or (fluxus and fluxus.request)

assert(ok_request_functionality, "Unsupported exploit (no request function found)")
local options = ({...})[1] or { 
    AutoDecode = true, 
    Highlighting = true, 
    SaveLogs = true, 
    CLICommands = true, 
    ShowResponse = true, 
    BlockedURLs = {}, 
    API = true,
    GuiEnabled = true
}
local version = "v1.3.1 updated by: Flames Hub | LLC ©️"
local logname = string.format("%d-%s-log.txt", game.PlaceId, os.date("%d_%m_%y"))

if options.SaveLogs then
    pcall(function()
        writefile(logname, string.format("Http Logs from %s\n\n", os.date("%d/%m/%y")))
    end)
end

local Serializer
pcall(function()
    Serializer = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotDSF/leopard/main/rbx/leopard-syn.lua"))()
    Serializer.UpdateConfig({ highlighting = options.Highlighting })
end)

if not Serializer then
    warn("Failed to load Serializer - some features may not work properly")
    Serializer = {
        Serialize = function(t) return tostring(t) end,
        FormatArguments = function(...) return table.concat({...}, ", ") end
    }
end

local RecentCommit = "Latest changes"
pcall(function()
    RecentCommit = "Updated main.lua" or game.HttpService:JSONDecode(game:HttpGet("https://api.github.com/repos/NotDSF/HttpSpy/commits?per_page=1&path=init.lua"))[1].commit.message
end)

local success, err = pcall(function()
    local clonef = clonefunction
    local format = clonef(string.format)
    local gsub = clonef(string.gsub)
    local match = clonef(string.match)
    local append = clonef(appendfile)
    local Type = clonef(type)
    local crunning = clonef(coroutine.running)
    local cwrap = clonef(coroutine.wrap)
    local cresume = clonef(coroutine.resume)
    local cyield = clonef(coroutine.yield)
    local Pcall = clonef(pcall)
    local Pairs = clonef(pairs)
    local Error = clonef(error)
    local getnamecallmethod = clonef(getnamecallmethod)
    local blocked = options.BlockedURLs
    local enabled = true
    local reqfunc = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
    local libtype = syn and "syn" or "http"
    local hooked = {}
    local proxied = {}
    local methods = {
        HttpGet = not syn,
        HttpGetAsync = not syn,
        GetObjects = true
    }

    local OnRequest = Instance.new("BindableEvent")
    local HttpSpyGui = Instance.new("ScreenGui")
    HttpSpyGui.Name = "HttpSpyGui"
    HttpSpyGui.DisplayOrder = 999
    HttpSpyGui.ResetOnSpawn = false
    HttpSpyGui.Parent = game:GetService("CoreGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0.45, 0, 0.55, 0)
    MainFrame.Position = UDim2.new(0.275, 0, 0.225, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    MainFrame.BorderSizePixel = 1
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = HttpSpyGui

    local dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragStart = input.Position
            startPos = MainFrame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                    dragStart = nil
                end
            end)
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragStart then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 2
    TitleBar.Parent = MainFrame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TitleBar

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -200, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = "HttpSpy "..version
    TitleText.TextColor3 = Color3.fromRGB(220, 220, 220)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 14
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.ZIndex = 3
    TitleText.Parent = TitleBar

    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(0, 180, 1, 0)
    ButtonContainer.Position = UDim2.new(1, -185, 0, 0)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = TitleBar

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 60, 0, 22)
    ToggleButton.Position = UDim2.new(0, 0, 0.5, -11)
    ToggleButton.Text = "Disable"
    ToggleButton.Font = Enum.Font.Gotham
    ToggleButton.TextSize = 12
    ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    ToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.AutoButtonColor = false
    ToggleButton.ZIndex = 3
    ToggleButton.Parent = ButtonContainer

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 4)
    ToggleCorner.Parent = ToggleButton

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 22, 0, 22)
    MinimizeButton.Position = UDim2.new(0, 65, 0.5, -11)
    MinimizeButton.Text = "_"
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.TextSize = 16
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    MinimizeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.AutoButtonColor = false
    MinimizeButton.ZIndex = 3
    MinimizeButton.Parent = ButtonContainer

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 4)
    MinimizeCorner.Parent = MinimizeButton

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 22, 0, 22)
    CloseButton.Position = UDim2.new(0, 92, 0.5, -11)
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 14
    CloseButton.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
    CloseButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    CloseButton.BorderSizePixel = 0
    CloseButton.AutoButtonColor = false
    CloseButton.ZIndex = 3
    CloseButton.Parent = ButtonContainer

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton

    local MinimizedIcon = Instance.new("TextButton")
    MinimizedIcon.Size = UDim2.new(0, 40, 0, 40)
    MinimizedIcon.Position = UDim2.new(0.5, -20, 0, 10)
    MinimizedIcon.Text = "H"
    MinimizedIcon.Font = Enum.Font.GothamBold
    MinimizedIcon.TextSize = 20
    MinimizedIcon.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    MinimizedIcon.TextColor3 = Color3.fromRGB(220, 220, 220)
    MinimizedIcon.BorderSizePixel = 1
    MinimizedIcon.BorderColor3 = Color3.fromRGB(60, 60, 60)
    MinimizedIcon.AutoButtonColor = false
    MinimizedIcon.Visible = false
    MinimizedIcon.ZIndex = 999
    MinimizedIcon.Parent = HttpSpyGui

    local MinimizedCorner = Instance.new("UICorner")
    MinimizedCorner.CornerRadius = UDim.new(0, 6)
    MinimizedCorner.Parent = MinimizedIcon

    local iconDragInput, iconDragStart, iconStartPos
    MinimizedIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            iconDragStart = input.Position
            iconStartPos = MinimizedIcon.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                    iconDragStart = nil
                end
            end)
        end
    end)

    MinimizedIcon.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and iconDragStart then
            local delta = input.Position - iconDragStart
            MinimizedIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y)
        end
    end)

    local function safeHover(button, enterColor, leaveColor)
        pcall(function()
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = enterColor
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = leaveColor
            end)
        end)
    end

    safeHover(MinimizeButton, Color3.fromRGB(100, 100, 100), Color3.fromRGB(80, 80, 80))
    safeHover(CloseButton, Color3.fromRGB(150, 50, 50), Color3.fromRGB(120, 40, 40))
    safeHover(ToggleButton, Color3.fromRGB(100, 100, 100), enabled and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(120, 40, 40))
    safeHover(MinimizedIcon, Color3.fromRGB(50, 50, 50), Color3.fromRGB(35, 35, 35))

    local isMinimized = false
    pcall(function()
        MinimizeButton.MouseButton1Click:Connect(function()
            isMinimized = not isMinimized
            MainFrame.Visible = not isMinimized
            MinimizedIcon.Visible = isMinimized
            
            if isMinimized then
                local mainFramePos = MainFrame.Position
                MinimizedIcon.Position = UDim2.new(mainFramePos.X.Scale, mainFramePos.X.Offset + MainFrame.AbsoluteSize.X/2 - 20, 0, 10)
            else
                MainFrame.Position = MinimizedIcon.Position - UDim2.new(0, MainFrame.AbsoluteSize.X/2 - 20, 0, 0)
            end
        end)
    end)

    pcall(function()
        MinimizedIcon.MouseButton1Click:Connect(function()
            isMinimized = false
            MainFrame.Visible = true
            MinimizedIcon.Visible = false
            MainFrame.Position = MinimizedIcon.Position - UDim2.new(0, MainFrame.AbsoluteSize.X/2 - 20, 0, 0)
        end)
    end)

    pcall(function()
        CloseButton.MouseButton1Click:Connect(function()
            if __namecall then
                hookmetamethod(game, "__namecall", __namecall)
            end
            
            if __request then
                hookfunction(reqfunc, __request)
            end
            
            HttpSpyGui:Destroy()
            
            getgenv().HttpSpy = nil
        end)
    end)

    pcall(function()
        ToggleButton.MouseButton1Click:Connect(function()
            enabled = not enabled
            ToggleButton.Text = enabled and "Disable" or "Enable"
            ToggleButton.BackgroundColor3 = enabled and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(120, 40, 40)
        end)
    end)

    local LogsFrame = Instance.new("ScrollingFrame")
    LogsFrame.Size = UDim2.new(1, -10, 1, -70)
    LogsFrame.Position = UDim2.new(0, 5, 0, 35)
    LogsFrame.BackgroundTransparency = 1
    LogsFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    LogsFrame.ScrollBarThickness = 6
    LogsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    LogsFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    LogsFrame.Parent = MainFrame

    local LogsLayout = Instance.new("UIListLayout")
    LogsLayout.Padding = UDim.new(0, 8)
    LogsLayout.Parent = LogsFrame

    local ControlBar = Instance.new("Frame")
    ControlBar.Size = UDim2.new(1, 0, 0, 30)
    ControlBar.Position = UDim2.new(0, 0, 1, -30)
    ControlBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ControlBar.BorderSizePixel = 0
    ControlBar.Parent = MainFrame

    local ClearButton = Instance.new("TextButton")
    ClearButton.Size = UDim2.new(0, 80, 0, 22)
    ClearButton.Position = UDim2.new(0, 10, 0.5, -11)
    ClearButton.Text = "Clear Logs"
    ClearButton.Font = Enum.Font.Gotham
    ClearButton.TextSize = 12
    ClearButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ClearButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    ClearButton.BorderSizePixel = 0
    ClearButton.AutoButtonColor = false
    ClearButton.Parent = ControlBar

    local ClearCorner = Instance.new("UICorner")
    ClearCorner.CornerRadius = UDim.new(0, 4)
    ClearCorner.Parent = ClearButton

    safeHover(ClearButton, Color3.fromRGB(80, 80, 80), Color3.fromRGB(60, 60, 60))

    pcall(function()
        ClearButton.MouseButton1Click:Connect(function()
            local children = LogsFrame:GetChildren()
            for i = #children, 1, -1 do
                local child = children[i]
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end
            requestCount = 0
            RequestCount.Text = "Requests: 0"
        end)
    end)

    local FilterBox = Instance.new("TextBox")
    FilterBox.Size = UDim2.new(0.5, 0, 0.7, 0)
    FilterBox.Position = UDim2.new(0.5, -100, 0.15, 0)
    FilterBox.PlaceholderText = "Filter requests..."
    FilterBox.Text = ""
    FilterBox.Font = Enum.Font.Gotham
    FilterBox.TextSize = 12
    FilterBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    FilterBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    FilterBox.BorderSizePixel = 0
    FilterBox.Parent = ControlBar

    local UICornerFilter = Instance.new("UICorner")
    UICornerFilter.CornerRadius = UDim.new(0, 4)
    UICornerFilter.Parent = FilterBox

    local RequestCount = Instance.new("TextLabel")
    RequestCount.Size = UDim2.new(0, 100, 1, 0)
    RequestCount.Position = UDim2.new(1, -110, 0, 0)
    RequestCount.Text = "Requests: 0"
    RequestCount.Font = Enum.Font.Gotham
    RequestCount.TextSize = 12
    RequestCount.BackgroundTransparency = 1
    RequestCount.TextColor3 = Color3.fromRGB(180, 180, 180)
    RequestCount.TextXAlignment = Enum.TextXAlignment.Right
    RequestCount.Parent = ControlBar

    local requestCount = 0
    local function updateRequestCount()
        requestCount = requestCount + 1
        RequestCount.Text = "Requests: "..requestCount
    end

    local function printf(text, isResponse)
        if options.SaveLogs then
            pcall(function()
                append(logname, gsub(text, "%\27%[%d+m", ""))
            end)
        end
        
        if not options.GuiEnabled then return end

        local cleanText = text:gsub("\27%[[%d;]+m", "")

        task.spawn(function()
            pcall(function()
                local logEntry = Instance.new("Frame")
                logEntry.Size = UDim2.new(1, -10, 0, 0)
                logEntry.Position = UDim2.new(0, 5, 0, 0)
                logEntry.BackgroundTransparency = 1
                logEntry.AutomaticSize = Enum.AutomaticSize.Y
                logEntry.Parent = LogsFrame
                
                local bg = Instance.new("Frame")
                bg.Size = UDim2.new(1, 0, 1, 0)
                bg.BackgroundColor3 = isResponse and Color3.fromRGB(30, 45, 30) or Color3.fromRGB(45, 30, 30)
                bg.BackgroundTransparency = 0.9
                bg.BorderSizePixel = 0
                bg.Parent = logEntry
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 6)
                corner.Parent = bg
                
                local copyButton = Instance.new("TextButton")
                copyButton.Size = UDim2.new(0, 50, 0, 18)
                copyButton.Position = UDim2.new(1, -55, 0, 5)
                copyButton.Text = "Copy"
                copyButton.Font = Enum.Font.Gotham
                copyButton.TextSize = 11
                copyButton.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
                copyButton.TextColor3 = Color3.fromRGB(220, 220, 220)
                copyButton.BorderSizePixel = 0
                copyButton.AutoButtonColor = false
                copyButton.Parent = logEntry
                
                local copyCorner = Instance.new("UICorner")
                copyCorner.CornerRadius = UDim.new(0, 4)
                copyCorner.Parent = copyButton
                
                safeHover(copyButton, Color3.fromRGB(90, 90, 120), Color3.fromRGB(70, 70, 100))
                
                pcall(function()
                    copyButton.MouseButton1Click:Connect(function()
                        setclipboard(cleanText)
                        copyButton.Text = "Copied!"
                        task.wait(1)
                        copyButton.Text = "Copy"
                    end)
                end)
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -60, 0, 0)
                label.Position = UDim2.new(0, 10, 0, 5)
                label.Text = cleanText
                label.TextColor3 = Color3.fromRGB(240, 240, 240)
                label.BackgroundTransparency = 1
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Top
                label.TextWrapped = true
                label.Font = Enum.Font.Code
                label.TextSize = 13
                label.AutomaticSize = Enum.AutomaticSize.Y
                label.Parent = logEntry
                
                local timeText = Instance.new("TextLabel")
                timeText.Size = UDim2.new(1, -60, 0, 15)
                timeText.Position = UDim2.new(0, 10, 1, -20)
                timeText.Text = os.date("%H:%M:%S")
                timeText.TextColor3 = Color3.fromRGB(180, 180, 180)
                timeText.BackgroundTransparency = 1
                timeText.TextXAlignment = Enum.TextXAlignment.Left
                timeText.Font = Enum.Font.Gotham
                timeText.TextSize = 10
                timeText.Parent = logEntry

                if FilterBox.Text == "" then
                    task.wait()
                    LogsFrame.CanvasPosition = Vector2.new(0, LogsFrame.AbsoluteCanvasSize.Y)
                end
                
                updateRequestCount()
            end)
        end)
    end

    pcall(function()
        FilterBox:GetPropertyChangedSignal("Text"):Connect(function()
            local filterText = string.lower(FilterBox.Text)
            
            for _, logEntry in ipairs(LogsFrame:GetChildren()) do
                if logEntry:IsA("Frame") then
                    local label = logEntry:FindFirstChildOfClass("TextLabel")
                    if label and label.Text then
                        logEntry.Visible = filterText == "" or string.find(string.lower(label.Text), filterText, 1, true) ~= nil
                    end
                end
            end
        end)
    end)

    local function ConstantScan(constant)
        for i,v in Pairs(getgc(true)) do
            if type(v) == "function" and islclosure(v) and getfenv(v).script == getfenv(saveinstance).script and table.find(debug.getconstants(v), constant) then
                return v;
            end;
        end;
    end;

    local function DeepClone(tbl, cloned)
        cloned = cloned or {};

        for i,v in Pairs(tbl) do
            if Type(v) == "table" then
                cloned[i] = DeepClone(v);
                continue;
            end;
            cloned[i] = v;
        end;

        return cloned;
    end;

    local __namecall, __request;
    __namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod();

        if methods[method] then
            printf("game:"..method.."("..Serializer.FormatArguments(...)..")\n\n");
        end;

        return __namecall(self, ...);
    end));

    __request = hookfunction(reqfunc, newcclosure(function(req) 
        if Type(req) ~= "table" then return __request(req); end;
        
        local RequestData = DeepClone(req);
        if not enabled then
            return __request(req);
        end;

        if Type(RequestData.Url) ~= "string" then return __request(req) end;

        if not options.ShowResponse then
            printf(libtype..".request("..Serializer.Serialize(RequestData)..")\n\n");
            return __request(req);
        end;

        local t = crunning();
        cwrap(function() 
            if RequestData.Url and blocked[RequestData.Url] then
                printf(libtype..".request("..Serializer.Serialize(RequestData)..") -- blocked url\n\n");
                return cresume(t, {});
            end;

            if RequestData.Url then
                local Host = string.match(RequestData.Url, "https?://(%w+.%w+)/");
                if Host and proxied[Host] then
                    RequestData.Url = gsub(RequestData.Url, Host, proxied[Host], 1);
                end; 
            end;

            OnRequest:Fire(RequestData);

            local ok, ResponseData = Pcall(__request, RequestData);
            if not ok then
                Error(ResponseData, 0);
            end;

            local BackupData = {};
            for i,v in Pairs(ResponseData) do
                BackupData[i] = v;
            end;

            local headers = BackupData.Headers
            if headers and headers["Content-Type"] and match(headers["Content-Type"], "application/json") and options.AutoDecode then
                local body = BackupData.Body;
                local ok, res = Pcall(game.HttpService.JSONDecode, game.HttpService, body);
                if ok then
                    BackupData.Body = res;
                end;
            end;

            printf(libtype..".request("..Serializer.Serialize(RequestData)..")\n\n", false);
            printf("Response Data: "..Serializer.Serialize(BackupData).."\n\n", true);
            cresume(t, hooked[RequestData.Url] and hooked[RequestData.Url](ResponseData) or ResponseData);
        end)();
        return cyield();
    end));

    if request then
        replaceclosure(request, reqfunc);
    end;

    if syn and syn.websocket then
        local WsConnect, WsBackup = debug.getupvalue(syn.websocket.connect, 1);
        WsBackup = hookfunction(WsConnect, function(...) 
            printf("syn.websocket.connect("..Serializer.FormatArguments(...)..")\n\n");
            return WsBackup(...);
        end);
    end;

    if syn and syn.websocket then
        local HttpGet;
        HttpGet = hookfunction(getupvalue(ConstantScan("ZeZLm2hpvGJrD6OP8A3aEszPNEw8OxGb"), 2), function(self, ...) 
            printf("game.HttpGet(game, "..Serializer.FormatArguments(...)..")\n\n");
            return HttpGet(self, ...);
        end);

        local HttpPost;
        HttpPost = hookfunction(getupvalue(ConstantScan("gpGXBVpEoOOktZWoYECgAY31o0BlhOue"), 2), function(self, ...) 
            printf("game.HttpPost(game, "..Serializer.FormatArguments(...)..")\n\n");
            return HttpPost(self, ...);
        end);
    end

    for method, enabled in pairs(methods) do
        if enabled and typeof(game[method]) == "function" then
            local b
            b = hookfunction(game[method], newcclosure(function(self, ...)
                printf("game."..method.."(game, "..Serializer.FormatArguments(...)..")\n\n")
                return b(self, ...)
            end))
        end
    end

    if not debug.info(2, "f") then
        printf("You are running an outdated version.\n");
    end;

    task.spawn(function()
        printf("HttpSpy "..version.." (Original Creator: https://github.com/NotDSF)\nChange Logs:\n\t"..RecentCommit.."\nLogs are automatically being saved to: "..(options.SaveLogs and logname or "(You aren't saving logs, enable SaveLogs if you want to save logs)").."\n\n")
    end)

    if not options.API then return end

    local API = {}
    API.OnRequest = OnRequest.Event

    function API:HookSynRequest(url, hook) 
        hooked[url] = hook
    end

    function API:ProxyHost(host, proxy) 
        proxied[host] = proxy
    end

    function API:RemoveProxy(host) 
        if not proxied[host] then
            error("host isn't proxied", 0)
        end
        proxied[host] = nil
    end

    function API:UnHookSynRequest(url) 
        if not hooked[url] then
            error("url isn't hooked", 0)
        end
        hooked[url] = nil
    end

    function API:BlockUrl(url) 
        blocked[url] = true
    end

    function API:WhitelistUrl(url) 
        blocked[url] = false
    end

    function API:ToggleGui(visible)
        HttpSpyGui.Enabled = visible
        options.GuiEnabled = visible
    end

    function API:SetGuiPosition(position)
        MainFrame.Position = position
    end

    function API:SetGuiSize(size)
        MainFrame.Size = size
    end

    return API
end)

if not success and err then
    warn("HttpSpy initialization failed: "..tostring(err))
    if rconsoleprint then
        rconsoleprint("@@RED@@")
        rconsoleprint("HttpSpy initialization error: "..tostring(err).."\n")
    end
    return nil
end
