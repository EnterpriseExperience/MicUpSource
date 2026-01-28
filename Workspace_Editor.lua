local coregui = getgenv().CoreGui or game:GetService("CoreGui")
local UserInputService = getgenv().UserInputService or game:GetService("UserInputService")
getgenv().flameshub_workspace_descendant_hooked = getgenv().flameshub_workspace_descendant_hooked or false
getgenv().cached_parts_in_workspace_flames_hub_editor = getgenv().cached_parts_in_workspace_flames_hub_editor or {}
getgenv().workspaceeditor_objects = getgenv().workspaceeditor_objects or {}
getgenv().workspaceeditor_esp = getgenv().workspaceeditor_esp or {}
getgenv().WorkspaceEditor_EspAllModelsEnabled = getgenv().WorkspaceEditor_EspAllModelsEnabled or false
getgenv().WorkspaceEditor_EspAllPartsEnabled = getgenv().WorkspaceEditor_EspAllPartsEnabled or false
getgenv().WorkspaceEditor_XrayAllPartsEnabled = getgenv().WorkspaceEditor_XrayAllPartsEnabled or false
getgenv().workspaceeditor_transparency_cache = getgenv().workspaceeditor_transparency_cache or {}
getgenv().WorkspaceEditor_CollisionToggleEnabled = getgenv().WorkspaceEditor_CollisionToggleEnabled or false
local transparency_cache = getgenv().workspaceeditor_transparency_cache
local cache = getgenv().cached_parts_in_workspace_flames_hub_editor
local objectbuttons = getgenv().workspaceeditor_objects
local espmap = getgenv().workspaceeditor_esp
local defaultColor = Color3.fromRGB(30,30,30)
local selectedColor = Color3.fromRGB(60,120,255)
getgenv().selected_objects_currently = getgenv().selected_objects_currently or {}
getgenv().selectedButtons = getgenv().selectedButtons or {}
getgenv().workspaceeditor_xray_cache = getgenv().workspaceeditor_xray_cache or {}
getgenv().ws_safe_cache = getgenv().ws_safe_cache or {}
getgenv().ws_xray_active = getgenv().ws_xray_active or {}

if coregui:FindFirstChild("Workspace_Editor_GUI_Flames_Hub") and coregui:FindFirstChild("Workspace_Editor_GUI_Flames_Hub"):IsA("ScreenGui") then
   coregui:FindFirstChild("Workspace_Editor_GUI_Flames_Hub").Enabled = true
   return 
end

task.wait(0.2)

local function snapshot(part)
   if ws_safe_cache[part] then return end
   ws_safe_cache[part] = {
      t = part.Transparency,
      c = part.CanCollide
   }
end

local function restore(part)
   local data = ws_safe_cache[part]
   if not data then return end
   part.Transparency = data.t
   part.CanCollide = data.c
end

local function hide_part(part)
   snapshot(part)
   part.Transparency = 1
   part.CanCollide = false
end

local function unhide_part(part)
   restore(part)
end

local gui = Instance.new("ScreenGui")
gui.Name = "Workspace_Editor_GUI_Flames_Hub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = coregui

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.35, 0.45)
main.Position = UDim2.fromScale(0.02, 0.25)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local originalSize = main.Size
if getgenv().dragify then dragify(main) end

local topbar = Instance.new("Frame", main)
topbar.Size = UDim2.fromScale(1, 0.12)
topbar.BackgroundColor3 = Color3.fromRGB(20,20,20)
topbar.BorderSizePixel = 0
Instance.new("UICorner", topbar).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", topbar)
title.Size = UDim2.fromScale(0.7, 1)
title.Position = UDim2.fromScale(0.03, 0)
title.BackgroundTransparency = 1
title.Text = "Life Together RP - Workspace Editor"
title.Font = Enum.Font.GothamBlack
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)

local closebtn = Instance.new("TextButton", topbar)
closebtn.Size = UDim2.fromScale(0.12, 0.6)
closebtn.Position = UDim2.fromScale(0.85, 0.2)
closebtn.Text = "X"
closebtn.TextScaled = true
closebtn.Font = Enum.Font.GothamBlack
closebtn.BackgroundColor3 = Color3.fromRGB(170,50,50)
closebtn.TextColor3 = Color3.new(1,1,1)
closebtn.BorderSizePixel = 0
Instance.new("UICorner", closebtn)

local minimizebtn = Instance.new("TextButton", topbar)
minimizebtn.Size = UDim2.fromScale(0.12, 0.6)
minimizebtn.Position = UDim2.fromScale(0.72, 0.2)
minimizebtn.Text = "-"
minimizebtn.TextScaled = true
minimizebtn.Font = Enum.Font.GothamBlack
minimizebtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
minimizebtn.TextColor3 = Color3.new(1,1,1)
minimizebtn.BorderSizePixel = 0
Instance.new("UICorner", minimizebtn)

local body = Instance.new("Frame", main)
body.Position = UDim2.fromScale(0, 0.12)
body.Size = UDim2.fromScale(1, 0.88)
body.BackgroundTransparency = 1

local search = Instance.new("TextBox", body)
search.Size = UDim2.fromScale(0.45, 0.08)
search.Text = "Search Workspace..."
search.PlaceholderText = "Search Workspace..."
search.ClearTextOnFocus = true
search.Font = Enum.Font.Gotham
search.TextSize = 13
search.BackgroundColor3 = Color3.fromRGB(35,35,35)
search.TextColor3 = Color3.new(1,1,1)
search.BorderSizePixel = 0
Instance.new("UICorner", search)

local list = Instance.new("ScrollingFrame", body)
list.Position = UDim2.fromScale(0, 0.1)
list.Size = UDim2.fromScale(0.45, 0.9)
list.CanvasSize = UDim2.new()
list.ScrollBarImageTransparency = 0.4
list.BackgroundTransparency = 1
list.BorderSizePixel = 0

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0,6)

local panel = Instance.new("Frame", body)
panel.Position = UDim2.fromScale(0.47, 0.05)
panel.Size = UDim2.fromScale(0.5, 0.9)
panel.BackgroundTransparency = 1

local function xray_on(part)
   snapshot(part)
   part.Transparency = math.clamp(ws_safe_cache[part].t + 0.5, 0, 0.9)
   ws_xray_active[part] = true
end

local function xray_off(part)
   ws_xray_active[part] = nil
   restore(part)
end

local function addesp(obj)
   if espmap[obj] then return end
   local h = Instance.new("Highlight")
   h.FillColor = Color3.fromRGB(0,255,0)
   h.OutlineColor = Color3.fromRGB(0,255,0)
   h.FillTransparency = 0.5
   h.OutlineTransparency = 0
   h.Adornee = obj
   h.Parent = coregui
   espmap[obj] = h
end

local function removeesp(obj)
   if espmap[obj] then
      espmap[obj]:Destroy()
      espmap[obj] = nil
   end
end

local function clearSelection()
   for obj,btn in pairs(selectedButtons) do
      btn.BackgroundColor3 = defaultColor
      selected_objects_currently[obj] = nil
      selectedButtons[obj] = nil
   end
end

local function addobject(obj)
   if objectbuttons[obj] then return end

   local b = Instance.new("TextButton", list)
   b.Size = UDim2.new(1,-6,0,28)
   b.Text = obj.Name
   b.Font = Enum.Font.Gotham
   b.TextSize = 13
   b.BackgroundColor3 = defaultColor
   b.TextColor3 = Color3.new(1,1,1)
   b.BorderSizePixel = 0
   Instance.new("UICorner", b)

   b.MouseButton1Click:Connect(function()
      local ctrl = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)

      if getgenv().selected_objects_currently[obj] then
         getgenv().selected_objects_currently[obj] = nil
         selectedButtons[obj] = nil
         b.BackgroundColor3 = defaultColor
         return
      end

      if not ctrl then
         clearSelection()
      end

      getgenv().selected_objects_currently[obj] = true
      selectedButtons[obj] = b
      b.BackgroundColor3 = selectedColor
   end)

   objectbuttons[obj] = b
end

search:GetPropertyChangedSignal("Text"):Connect(function()
   local txt = search.Text:lower()
   for obj,btn in pairs(objectbuttons) do
      btn.Visible = txt == "" or obj.Name:lower():find(txt,1,true)
   end
end)

local function makebutton(text, y, fn)
   local b = Instance.new("TextButton", panel)
   b.Size = UDim2.fromScale(1, 0.1)
   b.Position = UDim2.fromScale(0, y)
   b.Text = text
   b.Font = Enum.Font.Gotham
   b.TextSize = 14
   b.BackgroundColor3 = Color3.fromRGB(35,35,35)
   b.TextColor3 = Color3.new(1,1,1)
   b.BorderSizePixel = 0
   Instance.new("UICorner", b)
   b.MouseButton1Click:Connect(fn)
   return b
end

makebutton("Hide / UnHide", 0.06, function()
   for obj in pairs(getgenv().selected_objects_currently) do
      for _,v in ipairs(obj:IsA("Model") and obj:GetDescendants() or {obj}) do
         if v:IsA("BasePart") then
            if v.Transparency < 1 then
               hide_part(v)
            else
               unhide_part(v)
            end
         end
      end
   end
end)

makebutton("X-Ray / Un-Xray (Selected)", 0.20, function()
   for obj in pairs(getgenv().selected_objects_currently) do
      for _,v in ipairs(obj:IsA("Model") and obj:GetDescendants() or {obj}) do
         if v:IsA("BasePart") then
            if not ws_xray_active[v] then
               xray_on(v)
            else
               xray_off(v)
            end
         end
      end
   end
end)

makebutton("Toggle Collision (Selected)", 0.34, function()
   getgenv().WorkspaceEditor_CollisionToggleEnabled = not getgenv().WorkspaceEditor_CollisionToggleEnabled
   for obj in pairs(getgenv().selected_objects_currently) do
      for _,v in ipairs(obj:IsA("Model") and obj:GetDescendants() or {obj}) do
         if v:IsA("BasePart") then
            v.CanCollide = getgenv().WorkspaceEditor_CollisionToggleEnabled
         end
      end
   end
end)

makebutton("X-Ray ALL Parts", 0.50, function()
   getgenv().WorkspaceEditor_XrayAllPartsEnabled = not getgenv().WorkspaceEditor_XrayAllPartsEnabled

   for _,v in ipairs(workspace:GetDescendants()) do
      if v:IsA("BasePart") then
         if getgenv().WorkspaceEditor_XrayAllPartsEnabled then
            if not ws_xray_active[v] then
               xray_on(v)
            end
         else
            if ws_xray_active[v] then
               xray_off(v)
            end
         end
      end
   end
end)

makebutton("Toggle ESP for selected", 0.64, function()
   for obj in pairs(getgenv().selected_objects_currently) do
      if espmap[obj] then removeesp(obj) else addesp(obj) end
   end
end)

makebutton("Toggle ESP for ALL Models", 0.78, function()
   getgenv().WorkspaceEditor_EspAllModelsEnabled = not getgenv().WorkspaceEditor_EspAllModelsEnabled
   for _,v in ipairs(workspace:GetDescendants()) do
      if v:IsA("Model") then
         if getgenv().WorkspaceEditor_EspAllModelsEnabled then addesp(v) else removeesp(v) end
      end
   end
end)

makebutton("Toggle ESP for ALL Parts", 0.92, function()
   getgenv().WorkspaceEditor_EspAllPartsEnabled = not getgenv().WorkspaceEditor_EspAllPartsEnabled
   for _,v in ipairs(workspace:GetDescendants()) do
      if v:IsA("BasePart") then
         if getgenv().WorkspaceEditor_EspAllPartsEnabled then addesp(v) else removeesp(v) end
      end
   end
end)

minimizebtn.MouseButton1Click:Connect(function()
   body.Visible = not body.Visible
   main.Size = body.Visible and originalSize or UDim2.fromScale(originalSize.X.Scale, 0.12)
   minimizebtn.Text = body.Visible and "-" or "+"
end)

closebtn.MouseButton1Click:Connect(function()
   gui.Enabled = false
end)

if not getgenv().flameshub_workspace_descendant_hooked then
   getgenv().flameshub_workspace_descendant_hooked = true
   workspace.DescendantAdded:Connect(function(obj)
      task.wait()
      if cache[obj] then return end
      if obj:IsA("BasePart") or obj:IsA("Model") then
         cache[obj] = true
         addobject(obj)
      end
   end)

   workspace.DescendantRemoving:Connect(function(obj)
      ws_safe_cache[obj] = nil
      ws_xray_active[obj] = nil
   end)
end

task.defer(function()
   for _,v in ipairs(workspace:GetDescendants()) do
      if v:IsA("BasePart") or v:IsA("Model") then
         cache[v] = true
         addobject(v)
      end
   end
end)

if getgenv().notify then
   getgenv().notify("Success", "workspace editor loaded correctly", 6)
end
