local env = getgenv()
env.uireg = env.uireg or {}

local function rnd(a)
    return tostring(math.random(100000,999999))..a
end

local function makesignal()
    local r = {}
    r.f = {}
    function r:connect(fn)
        table.insert(self.f,fn)
        return fn
    end
    function r:fire(...)
        for _,v in ipairs(self.f) do
            v(...)
        end
    end
    return r
end

local function canuse()
    return Drawing and Drawing.new
end

local function makedraw(type,props)
    local o = Drawing.new(type)
    for i,v in pairs(props) do
        o[i]=v
    end
    return o
end

local function makerect(x,y,w,h,r,col,vis)
    local o = {}
    o.bg = makedraw("Square",{Position=Vector2.new(x,y),Size=Vector2.new(w,h),Color=col,Filled=true,Visible=vis})
    o.r = r
    return o
end

local function inside(x,y,a,b,c,d)
    return x>=a and x<=a+c and y>=b and y<=b+d
end

local function makewindowdraw()
    local wnd = {}
    wnd.x = 300
    wnd.y = 200
    wnd.w = 350
    wnd.h = 400
    wnd.open = true

    wnd.bg = makedraw("Square",{Position=Vector2.new(wnd.x,wnd.y),Size=Vector2.new(wnd.w,wnd.h),Color=Color3.new(0.15,0.15,0.15),Filled=true,Visible=true})
    wnd.top = makedraw("Square",{Position=Vector2.new(wnd.x,wnd.y),Size=Vector2.new(wnd.w,32),Color=Color3.new(0.25,0.25,0.25),Filled=true,Visible=true})

    wnd.btnclose = makedraw("Square",{Position=Vector2.new(wnd.x+wnd.w-30,wnd.y+4),Size=Vector2.new(25,24),Color=Color3.new(0.9,0.2,0.2),Filled=true,Visible=true})
    wnd.btnmini = makedraw("Square",{Position=Vector2.new(wnd.x+wnd.w-60,wnd.y+4),Size=Vector2.new(25,24),Color=Color3.new(0.9,0.9,0.2),Filled=true,Visible=true})

    wnd.scrollpos = 0
    wnd.items = {}

    wnd.additem = function(text)
        local it = {}
        it.txt = makedraw("Text",{Text=text,Size=18,Color=Color3.new(1,1,1),Visible=true})
        table.insert(wnd.items,it)
    end

    wnd.render = function()
        wnd.bg.Position = Vector2.new(wnd.x,wnd.y)
        wnd.top.Position = Vector2.new(wnd.x,wnd.y)
        wnd.btnclose.Position = Vector2.new(wnd.x+wnd.w-30,wnd.y+4)
        wnd.btnmini.Position = Vector2.new(wnd.x+wnd.w-60,wnd.y+4)

        local off = -wnd.scrollpos + wnd.y + 40
        for _,v in ipairs(wnd.items) do
            v.txt.Position = Vector2.new(wnd.x+10,off)
            v.txt.Visible = inside(v.txt.Position.X,v.txt.Position.Y,wnd.x,wnd.y+32,wnd.w,wnd.h-32)
            off = off + 22
        end
    end

    local uis = game:GetService("UserInputService")

    uis.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            local mx,my = unpack({i.Position.X,i.Position.Y})

            if inside(mx,my,wnd.x+wnd.w-30,wnd.y+4,25,24) then
                wnd.open = false
                wnd.bg.Visible=false
                wnd.top.Visible=false
                wnd.btnclose.Visible=false
                wnd.btnmini.Visible=false
                for _,v in ipairs(wnd.items) do v.txt.Visible=false end
            elseif inside(mx,my,wnd.x+wnd.w-60,wnd.y+4,25,24) then
                wnd.h = 40
            end
        elseif i.UserInputType == Enum.UserInputType.MouseWheel then
            wnd.scrollpos = math.max(0,wnd.scrollpos - i.Position.Z*20)
        end
    end)

    task.spawn(function()
        while true do
            if wnd.open then
                wnd.render()
            end
            task.wait()
        end
    end)

    return wnd
end

local function makewindowcore()
    local sg = Instance.new("ScreenGui")
    sg.Name = rnd("w")
    sg.Parent = game:GetService("CoreGui")

    local f = Instance.new("Frame",sg)
    f.Size = UDim2.new(0,350,0,400)
    f.Position = UDim2.new(0,300,0,200)
    f.BackgroundColor3 = Color3.fromRGB(38,38,38)

    local uc = Instance.new("UICorner",f)
    uc.CornerRadius = UDim.new(0,8)

    local top = Instance.new("Frame",f)
    top.Size = UDim2.new(1,0,0,32)
    top.BackgroundColor3 = Color3.fromRGB(55,55,55)
    Instance.new("UICorner",top).CornerRadius = UDim.new(0,8)

    local btnclose = Instance.new("TextButton",top)
    btnclose.Size = UDim2.new(0,30,0,24)
    btnclose.Position = UDim2.new(1,-34,0,4)
    btnclose.Text = "X"

    local btnmini = Instance.new("TextButton",top)
    btnmini.Size = UDim2.new(0,30,0,24)
    btnmini.Position = UDim2.new(1,-68,0,4)
    btnmini.Text = "-"

    local scroll = Instance.new("ScrollingFrame",f)
    scroll.Position = UDim2.new(0,0,0,32)
    scroll.Size = UDim2.new(1,0,1,-32)
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 4

    local list = Instance.new("UIListLayout",scroll)

    local wnd = {}
    wnd.frame = f
    wnd.additem = function(t)
        local b = Instance.new("TextLabel",scroll)
        b.Size = UDim2.new(1,-10,0,24)
        b.Text = t
    end

    btnclose.MouseButton1Click:Connect(function()
        sg.Enabled = false
    end)

    btnmini.MouseButton1Click:Connect(function()
        f.Size = UDim2.new(0,350,0,40)
    end)

    env.uireg.core = sg
    return wnd
end

local function start()
    if canuse() then
        env.uireg.main = makewindowdraw()
    else
        env.uireg.main = makewindowcore()
    end
end

return {start=start}
