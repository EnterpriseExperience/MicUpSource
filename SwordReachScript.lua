local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local PhantomForcesWindow = Library:NewWindow("Universal sword reach")
local KillingCheats = PhantomForcesWindow:NewSection("Kill Options")
local hitboxSize = 30
local hitboxActive = false
local colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 0)}

if not getgenv().InitializedAdonisAdmin_Bypass then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()
    wait(0.1)
    getgenv().InitializedAdonisAdmin_Bypass = true
end
wait(0.3)
if not getgenv().GlobalEnvironmentFramework_Initialized then
   loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
   wait(0.1)
   getgenv().GlobalEnvironmentFramework_Initialized = true
end
wait(1)
local function ModifyHitbox(size)
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if not char then return end

    local tool = nil
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Tool") then
            tool = v
            break
        end
    end

    if not tool then
        getgenv().notify("Error", "You need a Tool!", 3)
        return
    end

    hitboxActive = size > 1

    if hitboxActive then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://413861777"
        sound.Parent = game:GetService("SoundService")
        sound:Play()

        local handle = tool:FindFirstChild("Handle")
        if handle then
            handle.Massless = true
            handle.Transparency = 1
            handle.Size = Vector3.new(size, size, size)

            local selectionBox = Instance.new("SelectionBox", handle)
            selectionBox.Adornee = handle

            spawn(function()
                local index = 1
                while hitboxActive do
                    selectionBox.Color3 = colors[index]
                    index = (index % #colors) + 1
                    wait(0.5)
                end
                selectionBox:Destroy()
            end)
        end
    else
        if tool and tool:FindFirstChild("Handle") then
            local handle = tool.Handle
            handle.Size = Vector3.new(1, 1, 1)
            for _, v in pairs(handle:GetChildren()) do
                if v:IsA("SelectionBox") then
                    v:Destroy()
                end
            end
        end
    end
end

KillingCheats:CreateButton("Increase Hitbox", function()
    hitboxSize = hitboxSize + 5
    ModifyHitbox(hitboxSize)
    getgenv().notify("Info", "New Hitbox size: "..tostring(hitboxSize), 5)
end)

KillingCheats:CreateButton("Decrease Hitbox", function()
    if hitboxSize > 5 then
        hitboxSize = hitboxSize - 5
        ModifyHitbox(hitboxSize)
    end
    getgenv().notify("Info", "New Hitbox size: "..tostring(hitboxSize), 5)
end)

KillingCheats:CreateButton("Reset Hitbox", function()
    hitboxSize = 1
    ModifyHitbox(hitboxSize)
    getgenv().notify("Info", "New Hitbox size: "..tostring(hitboxSize), 5)
end)
