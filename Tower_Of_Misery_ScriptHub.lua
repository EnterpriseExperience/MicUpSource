getgenv().Game = game
getgenv().JobID = getgenv().Game.JobId
getgenv().PlaceID = getgenv().Game.PlaceId

getgenv().Service_Wrap = function(serviceName)
    if cloneref then
        return cloneref(getgenv().Game:GetService(serviceName))
    else
        return getgenv().Game:GetService(serviceName)
    end
end

local function getExecutor()
    local name
    if identifyexecutor then
        name = identifyexecutor()
    end
    return { Name = name or "Unknown Executor"}
end

local function executor_details()
    local executorDetails = getExecutor()
    return string.format("%s", executorDetails.Name)
end

local executor_Name = executor_details()

getgenv().print_executor = function()
    local function retrieve_executor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function identify_executor()
        local executorDetails = retrieve_executor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_string = identify_executor()

    return print(executor_string)
end

getgenv().warn_executor = function()
    local function retrieve_executor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end

    local function identify_executor()
        local executorDetails = retrieve_executor()
        return string.format("%s", executorDetails.Name)
    end
    wait(0.1)
    local executor_string = identify_executor()

    return warn(executor_string)
end

function randomString()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

getgenv().randomString = function()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

local cmdp = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local cmdlp = cmdp.LocalPlayer

function findplr(args)
    local tbl = cmdp:GetPlayers()

    if args == "me" or args == cmdlp.Name or args == cmdlp.DisplayName then
        return getgenv().notify("Failure!", "You cannot target yourself!", 6)
    end

    if args == "random" then
        local validPlayers = {}
        for _, v in pairs(tbl) do
            if v ~= cmdlp then
                table.insert(validPlayers, v)
            end
        end
        return #validPlayers > 0 and validPlayers[math.random(1, #validPlayers)] or nil
    end

    if args == "new" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.AccountAge < 30 and v ~= cmdlp then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "old" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.AccountAge > 30 and v ~= cmdlp then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "bacon" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= cmdlp and (v.Character:FindFirstChild("Pal Hair") or v.Character:FindFirstChild("Kate Hair")) then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "friend" then
        local friendList = {}
        for _, v in pairs(tbl) do
            if v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                table.insert(friendList, v)
            end
        end
        return #friendList > 0 and friendList[math.random(1, #friendList)] or nil
    end

    if args == "notfriend" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if not v:IsFriendsWith(cmdlp.UserId) and v ~= cmdlp then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "ally" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.Team == cmdlp.Team and v ~= cmdlp then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "enemy" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v.Team ~= cmdlp.Team and v ~= cmdlp then
                table.insert(vAges, v)
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "near" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= cmdlp and v.Character and cmdlp.Character then
                local vRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                local cmdlpRootPart = cmdlp.Character:FindFirstChild("HumanoidRootPart")
                if vRootPart and cmdlpRootPart then
                    local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
                    if distance < 30 then
                        table.insert(vAges, v)
                    end
                end
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    if args == "far" then
        local vAges = {}
        for _, v in pairs(tbl) do
            if v ~= cmdlp and v.Character and cmdlp.Character then
                local vRootPart = v.Character:FindFirstChild("HumanoidRootPart")
                local cmdlpRootPart = cmdlp.Character:FindFirstChild("HumanoidRootPart")
                if vRootPart and cmdlpRootPart then
                    local distance = (vRootPart.Position - cmdlpRootPart.Position).magnitude
                    if distance > 30 then
                        table.insert(vAges, v)
                    end
                end
            end
        end
        return #vAges > 0 and vAges[math.random(1, #vAges)] or nil
    end

    for _, v in pairs(tbl) do
        if (v.Name:lower():find(args:lower()) or v.DisplayName:lower():find(args:lower())) and v ~= cmdlp then
            return v
        end
    end
end

getgenv().AllClipboards = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
getgenv().httprequest_Init = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
get_http = getgenv().httprequest_Init or (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
getgenv().queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
queueteleport = getgenv().queueteleport

local function init_services()
    local services = {
        "Players",
        "Workspace",
        "Lighting",
        "ReplicatedStorage",
        "TweenService",
        "RunService",
        "MaterialService",
        "ReplicatedFirst",
        "Teams",
        "StarterPack",
        "StarterPlayer",
        "VoiceChatInternal",
        "VoiceChatService",
        "CoreGui",
        "SoundService",
        "StarterGui",
        "MarketplaceService",
        "TeleportService",
        "Chat",
        "AssetService",
        "HttpService",
        "UserInputService",
        "TextChatService",
        "ContextActionService",
        "GuiService",
        "PhysicsService"
    }

    for _, serviceName in pairs(services) do
        getgenv()[serviceName] = cloneref and cloneref(getgenv().Game:GetService(serviceName)) or getgenv().Game:GetService(serviceName)
    end
end
wait()
init_services()
task.wait()
local HttpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")
local Workspace = cloneref and cloneref(game:GetService("Workspace")) or game:GetService("Workspace")

if getgenv().AllClipboards then
    getgenv().AllClipboards("https://github.com/EnterpriseExperience/MicUpSource/releases -- check all my current patch notes and new updates/releases.")
end

wait(0.3)
if not getgenv().Players then
    warn("getgenv().Players was not detected, fixing...")
    getgenv().Players = getgenv().Service_Wrap("Players")
end
if not getgenv().ReplicatedStorage then
    warn("getgenv().ReplicatedStorage was not detected, fixing...")
    getgenv().ReplicatedStorage = getgenv().Service_Wrap("ReplicatedStorage")
end
if not getgenv().TextChatService then
    warn("getgenv().TextChatService was not detected, fixing...")
    getgenv().TextChatService = getgenv().Service_Wrap("TextChatService")
end
if not getgenv().Workspace then
    warn("getgenv().Workspace was not detected, fixing...")
    getgenv().Workspace = getgenv().Service_Wrap("Workspace")
end
if not getgenv().Lighting then
    warn("getgenv().Lighting was not detected, fixing...")
    getgenv().Lighting = getgenv().Service_Wrap("Lighting")
end

task.wait(0.2)
getgenv().Terrain = getgenv().Workspace.Terrain or getgenv().Workspace:FindFirstChild("Terrain")
getgenv().Camera = getgenv().Workspace.Camera or getgenv().Workspace:FindFirstChild("Camera")
getgenv().LocalPlayer = getgenv().Players.LocalPlayer
getgenv().Backpack = getgenv().LocalPlayer:WaitForChild("Backpack") or getgenv().LocalPlayer:FindFirstChild("Backpack") or getgenv().LocalPlayer:FindFirstChildOfClass("Backpack") or getgenv().LocalPlayer:FindFirstChildWhichIsA("Backpack")
getgenv().PlayerGui = getgenv().LocalPlayer:WaitForChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChild("PlayerGui") or getgenv().LocalPlayer:FindFirstChildOfClass("PlayerGui") or getgenv().LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
getgenv().PlayerScripts = getgenv().LocalPlayer:WaitForChild("PlayerScripts") or getgenv().LocalPlayer:FindFirstChild("PlayerScripts")
getgenv().Character = getgenv().LocalPlayer.Character or getgenv().LocalPlayer.CharacterAdded:Wait()
getgenv().HumanoidRootPart = getgenv().Character:WaitForChild("HumanoidRootPart") or getgenv().Character:FindFirstChild("HumanoidRootPart")
getgenv().Humanoid = getgenv().Character:WaitForChild("Humanoid") or getgenv().Character:FindFirstChildWhichIsA("Humanoid") or getgenv().Character:FindFirstChild("Humanoid")
getgenv().Head = getgenv().Character:WaitForChild("Head") or getgenv().Character:FindFirstChild("Head")
local Anti_Ragdoll_Active = false
local Inf_Stamina_Active = false

wait(0.2)

local function Dynamic_Character_Updater(character)
	getgenv().Character = character or getgenv().LocalPlayer.Character
	task.wait(0.3)
	local hrp = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart", 3)
	getgenv().HumanoidRootPart = (hrp and hrp:IsA("BasePart")) and hrp

	local hum = character:FindFirstChildOfClass("Humanoid")
	getgenv().Humanoid = (hum and hum:IsA("Humanoid")) and hum

	local head = character:FindFirstChild("Head")
	getgenv().Head = (head and head:IsA("BasePart")) and head
end

Dynamic_Character_Updater(getgenv().Character)
task.wait(0.2)
getgenv().LocalPlayer.CharacterAdded:Connect(function(newCharacter)
	task.wait(1)
	Dynamic_Character_Updater(newCharacter)
	getgenv().LocalPlayer.CharacterAdded:Wait()
	task.wait(0.5)
	getgenv().Character = newCharacter
	getgenv().HumanoidRootPart = newCharacter:FindFirstChild("HumanoidRootPart") or newCharacter:WaitForChild("HumanoidRootPart", 5)
	getgenv().Humanoid = newCharacter:FindFirstChild("Humanoid") or newCharacter:FindFirstChildWhichIsA("Humanoid") or newCharacter:WaitForChild("Humanoid", 5)
	getgenv().Head = newCharacter:FindFirstChild("Head") or newCharacter:WaitForChild("Head", 5)
end)

local Remote_Events = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events")
local General_Folder = Remote_Events:FindFirstChild("General")
local Update_Setting_RE = General_Folder:FindFirstChild("Update_Settings")
local Crate_System_V2 = getgenv().ReplicatedStorage:FindFirstChild("Crate_System_V2")
local Crate_System_Remote_Events = Crate_System_V2:FindFirstChild("Remote_Events")
local Open_Crate_RE = Crate_System_Remote_Events:FindFirstChild("Open_Crate")
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

for _, v in ipairs(Players:GetDescendants()) do
	if v:IsA("ScreenGui") and string.find(v.Name, "Height_Meter_V2") then
		for _, k in ipairs(v:GetDescendants()) do
			if k:IsA("LocalScript") and k.Name == "LocalScript" then
				k:Destroy()
			end
		end
	end
end

local function bypass_anticheat()
    return(function(...)local F={"\052\080\055\077\084\119\105\070\052\103\050\110\084\082\051\070\052\121\068\083\084\080\118\061","\068\074\121\088\082\047\100\048\121\098\101\065\086\048\103\050\077\118\061\061","\111\117\087\102\052\049\083\057\111\087\061\061";"\052\119\051\112\084\106\113\061";"\052\108\050\057\055\056\110\057\097\080\051\117\098\055\065\053\101\069\099\061";"\103\109\102\113\055\108\065\053\103\105\090\105\104\055\055\103","\055\082\105\070\097\082\055\043\113\108\068\102\065\082\055\056\065\082\055\099\113\118\061\061","\073\105\089\075\052\077\102\054\050\119\052\068\055\121\065\043\118\116\061\061","\121\054\067\057\084\119\068\102\104\072\061\061","\052\121\090\043\084\106\113\061","\097\082\050\110\084\082\116\061";"\065\053\072\043\055\054\047\061","\104\076\102\118\065\121\113\054\055\053\105\050\122\106\102\043";"\073\082\067\112\073\080\054\102\065\082\105\070\052\121\068\083\084\080\118\061","\084\107\108\080\052\077\067\043\098\077\090\108\084\103\055\116";"\104\102\050\049\068\082\110\069\104\105\102\078\103\119\055\055\065\109\113\061","\065\082\067\107\065\076\090\057\084\119\097\061";"\098\102\089\083\109\119\065\120\097\053\087\043\109\056\068\051\047\069\101\061";"\122\080\110\110\097\087\061\061","\097\106\068\043\073\103\081\053";"","\077\057\071\120\085\068\054\069\079\110\097\089\054\087\061\061";"\109\102\050\081\122\053\057\053\122\055\057\083\047\103\081\075\101\103\081\108";"\084\069\113\061";"\084\099\102\086\103\109\108\107\103\076\065\053\101\121\089\081","\098\119\065\053\104\082\078\077\101\119\087\106\111\047\101\054\068\087\061\061","\121\054\067\070\052\121\068\110\065\082\105\117\084\082\047\061","\084\069\108\061","\052\080\054\110\065\082\050\083";"\065\082\105\117\084\082\047\061";"\109\077\051\108\047\069\065\098\103\053\065\083\084\077\110\081\052\106\099\061","\055\107\090\078\055\056\087\043\050\076\105\103\098\076\065\108","\097\119\055\070\084\106\052\102";"\086\051\111\114\056\056\077\066\100\073\101\061";"\065\082\067\100\065\103\054\117\052\121\113\061";"\065\103\081\116\122\103\050\115","\122\053\102\077\052\118\061\061","\047\082\067\069\101\082\102\073\050\055\068\075\104\103\055\043\118\056\101\061";"\121\054\067\053\122\116\061\061";"\122\080\067\100\122\080\105\077","\111\087\061\061","\084\082\055\100","\118\080\116\054\104\055\089\111\050\077\054\122\050\102\050\113\047\069\113\061";"\052\106\050\054\122\087\061\061","\052\080\105\070\052\118\061\061";"\084\103\105\077\073\072\061\061","\097\119\105\100\052\082\067\070";"\073\099\078\081\084\069\102\100\073\054\089\099\097\103\077\061";"\097\080\055\077\084\103\055\077\122\121\068\110\122\119\051\102","\121\054\067\078\052\103\120\061","\098\107\047\080\073\121\057\082\111\108\070\086\055\103\120\061"}for a,V in ipairs({{26628-26627;-155086-(-155137)},{934275-934274,-672875+672901},{-740228-(-740255),-463296-(-463347)}})do while V[-577245-(-577246)]<V[-587688-(-587690)]do F[V[819408+-819407]],F[V[458126-458124]],V[-156324+156325],V[593099-593097]=F[V[-144594+144596]],F[V[199284-199283]],V[789180-789179]+(-418896-(-418897)),V[-494149-(-494151)]-(340008-340007)end end local function a(a)return F[a-(-243996-(-294247))]end do local a=table.insert local V={C=246028+-245967,s=-999638-(-999681);O=119298-119236,["\043"]=-637035-(-637085),["\051"]=378627-378578;p=-457145-(-457192),w=274966-274928;K=-154824+154835;["\053"]=-1001500-(-1001539),H=924059-924059,a=-389530+389558,["\054"]=-115665-(-115718);o=323777-323763;h=-551883-(-551913),["\050"]=340517+-340504;J=521526+-521468;M=-48050-(-48102),r=-949673-(-949683),l=953553-953549,V=-888278-(-888320);g=-334130-(-334152),N=984488-984444;k=35405-35354,E=-129655+129658,B=-1027799-(-1027830),y=250792-250769;I=-478028+478054,T=-1040014+1040041,F=-355048-(-355093);["\057"]=-699156-(-699197);x=-662967-(-663023);u=864675+-864641;q=254720-254712,d=87871+-87825,t=-386063+386111,j=852873+-852818,Y=352670+-352669,A=690919+-690890;["\047"]=-314646+314666;L=235789+-235782;Q=834257-834200,["\052"]=-991706+991731,W=-63315-(-63347),f=-1038481-(-1038518),["\055"]=-699755-(-699776),v=-237539-(-237555);U=-602228-(-602288);S=-450673+450713;X=-91894-(-91909),e=301809+-301797,P=750291+-750237,["\048"]=148213-148154;b=14909-14891,m=623160-623141,Z=-611427-(-611436);["\056"]=-437275-(-437310),G=464718-464655,R=66434-66428,z=37782+-37758;i=984626-984621;c=334088-334052,n=982339+-982306,["\049"]=-747418+747420;D=-992057+992074}local Y=F local Z=string.len local I=string.char local s=type local n=table.concat local N=math.floor local x=string.sub for F=988525-988524,#Y,321693-321692 do local y=Y[F]if s(y)=="\115\116\114\105\110\103"then local s=Z(y)local r={}local T=19699+-19698 local f=61389-61389 local A=-552256-(-552256)while T<=s do local F=x(y,T,T)local Y=V[F]if Y then f=f+Y*(-399949-(-400013))^((37958-37955)-A)A=A+(753451+-753450)if A==-963182+963186 then A=107597+-107597 local F=N(f/(-517757+583293))local V=N((f%(215314-149778))/(-511488+511744))local Y=f%(774188-773932)a(r,I(F,V,Y))f=448766-448766 end elseif F=="\061"then a(r,I(N(f/(182161-116625))))if T>=s or x(y,T+(-287493+287494),T+(24341+-24340))~="\061"then a(r,I(N((f%(984345-918809))/(-382511+382767))))end break end T=T+(808722-808721)end Y[F]=n(r)end end end return(function(F,Y,Z,I,s,n,N,f,y,k,d,X,x,V,E,w,A,r,J,T)r,f,A,J,w,x,k,E,X,y,d,T,V=function()T=(409705-409704)+T y[T]=913419+-913418 return T end,function(F)for a=316294-316293,#F,836137-836136 do y[F[a]]=(-435957+435958)+y[F[a]]end if Z then local V=Z(true)local Y=s(V)Y[a(327434+-277148)],Y[a(452886+-402621)],Y[a(-19490-(-69766))]=F,A,function()return-857505+1117831 end return V else return I({},{[a(1003897+-953632)]=A;[a(-245767+296053)]=F,[a(683739+-633463)]=function()return-258309+518635 end})end end,function(F)local a,V=355581+-355580,F[-377028+377029]while V do y[V],a=y[V]-(-474265-(-474266)),a+(-761885-(-761886))if 70398-70398==y[V]then y[V],x[V]=nil,nil end V=F[a]end end,function(F)y[F]=y[F]-(19465+-19464)if y[F]==-214046+214046 then y[F],x[F]=nil,nil end end,function(F,a)local Y=f(a)local Z=function(...)return V(F,{...},a,Y)end return Z end,{},function(F,a)local Y=f(a)local Z=function(Z,I,s,n,N)return V(F,{Z,I,s;n,N},a,Y)end return Z end,function(F,a)local Y=f(a)local Z=function(Z,I)return V(F,{Z;I},a,Y)end return Z end,function(F,a)local Y=f(a)local Z=function(Z,I,s,n)return V(F,{Z;I;s,n},a,Y)end return Z end,{},function(F,a)local Y=f(a)local Z=function(Z,I,s)return V(F,{Z;I;s},a,Y)end return Z end,-1039158-(-1039158),function(V,Z,I,s)local z,g,j,M,R,W,S,y,l,C,v,A,T,B,q,U,D,b,p,e,O,u,f,t,N,K,G,Q,m,c,L,i,H,h while V do if V<9502216-805353 then if V<-736917+5888010 then if V<-719660+2682625 then if V<-185194+1271731 then if V<-511269+1008640 then if V<-13657-(-180499)then if V<148771-29506 then R=nil f=nil l={}p=r()m=a(180458+-130172)K=nil H=r()M=a(702902+-652627)x[p]=l f=nil Q=k(651363+10257625,{p,G;B,C})l=r()S={}x[l]=Q V=F[a(285169-234911)]Q={}x[H]=Q q=nil Q=F[M]b=x[H]u=a(718951-668698)C=J(C)D={[m]=b;[u]=q}M=Q(S,D)N={}K=a(605828-555557)R=a(-997277-(-1047568))x[A]=M Q=d(-158584+5849077,{H,p;h,G;B;l})C=r()H=J(H)h=J(h)z=nil v=nil z=-764445+28403315809735 h=a(945284+-894985)p=J(p)B=J(B)x[T]=Q t=nil x[C]=f l=J(l)f=F[R]G=J(G)t=F[K]G=x[A]B=x[T]v=B(h,z)K=G[v]G=w(-576458+10183639,{A,T;C})R=f(t,K,G)T=J(T)x[C]=R A=J(A)C=J(C)else V=-301315+301316 C=x[I[197319-197318]]K=a(-287878+338138)R=x[I[-292327-(-292329)]]G=29409377230802-(-742828)t=R(K,G)N=C[t]f[V]=N N=true R=a(565762+-515500)V=60522-60520 f[V]=N V=x[I[-273019+273022]]C=F[R]R={C(f)}N={V(y,Y(R))}N={Y(N)}V=F[a(399495+-349205)]end else e=v==h L=e V=6465284-(-723992)end else if V<-272291+1135940 then T=x[I[304499-304496]]f=-1019543-(-1019544)y=T~=f V=y and 17087230-806721 or 8670997-(-191811)else f=a(699190+-648934)T=F[f]f=a(159039-108780)V=F[a(-697143+747426)]y=T[f]f=x[I[937472+-937471]]T={y(f)}N={Y(T)}end end else if V<914787+751536 then if V<1910099-360535 then if V<1688161-331419 then K=B U=a(183163-132866)e=F[U]U=a(-365523-(-415786))L=e[U]e=L(y,K)K=nil L=x[I[-79234+79240]]U=L()p=e+U l=p+R p=-554718-(-554974)z=l%p p=f[T]U=-82425+82426 R=z V=231333+9086770 e=R+U L=A[e]l=p..L f[T]=l else e=x[T]V=e and 1188566-833477 or 7107400-(-81876)L=e end else B=a(-20781+71043)G=F[B]N=G V=-5137+11710948 end else if V<-949674+2791466 then i=V g=-232278+232279 O=u[g]g=false q=O==g V=q and 7397070-(-101072)or 7597965-(-920082)j=q else S=not M p=p+H l=p<=Q l=S and l S=p>=Q S=M and S l=S or l S=4480060-(-723789)V=l and S l=13501554-202477 V=V or l end end end else if V<-926147+4705311 then if V<286476+2631964 then if V<1805487-(-967490)then if V<758985+1313921 then f=724808+8733256 N=4624258-648687 T=a(-1030344+1080644)y=T^f V=N-y N=a(-6987-(-57261))y=V V=N/y N={V}V=F[a(798638+-748353)]else T=x[I[-1043119-(-1043120)]]A=-755076-(-755077)C=863516-863514 f=T(A,C)T=-734795+734796 y=f==T N=y V=y and 9529967-(-733263)or 621324+4602263 end else N=a(-482802+533063)A=a(-700969+751263)G=d(5761669-(-896),{})V=F[N]y=x[I[-521150+521154]]K=a(-568968+619256)f=F[A]t=F[K]K={t(G)}t=-584113+584115 R={Y(K)}C=R[t]A=f(C)f=a(-359090-(-409370))T=y(A,f)y={T()}N=V(Y(y))T=x[I[385909-385904]]V=T and 16620928-545746 or 5644810-(-650360)y=N N=T end else if V<1000659+2404123 then V=true V=V and-715712+16870740 or 558924+5715594 else V=true y=Z T=r()C=r()f=a(39183-(-11114))K=X(11746844-348837,{C})x[T]=V A=r()N=F[f]t=a(-409003-(-459291))f=a(284551-234296)V=N[f]f=r()x[f]=V V=E(-218442+6500584,{})x[A]=V V=false x[C]=V R=F[t]t=R(K)V=t and-392624+15001514 or 610754+15696915 N=t end end else if V<4349742-(-12377)then if V<3704286-(-216507)then A=nil V=10397786-(-878628)t=nil R=nil else V=x[I[-508525+508532]]V=V and 7396326-(-776370)or 829242+14976220 end else if V<-136564+4541653 then V=x[I[-357785+357795]]T=x[I[881851-881840]]y[V]=T V=x[I[267694+-267682]]T={V(y)}N={Y(T)}V=F[a(71374-21072)]else W=-960979+960979 b=-212778+212779 M=a(1009045-958773)H=r()x[H]=L N=F[M]S=-101756+101856 M=a(426496-376223)V=N[M]M=-904493-(-904494)c=101226-91226 D=-228932-(-229187)N=V(M,S)M=r()x[M]=N S=-603581+603581 u=-266217-(-266219)V=x[t]N=V(S,D)S=r()x[S]=N D=537348-537347 V=x[t]m=x[M]N=V(D,m)D=r()x[D]=N N=x[t]m=N(b,u)N=558974+-558973 V=m==N q=a(-866548+916842)m=r()u=a(636056+-585789)x[m]=V i=F[q]N=a(-748525+798805)O=x[t]g={O(W,c)}q=i(Y(g))i=a(-773373-(-823640))V=a(539666-489396)j=q..i V=l[V]b=u..j u=a(681919-631631)V=V(l,N,b)b=r()j=X(2185780-93726,{t;H;B,f,T,p;m,b,M,D;S;G})x[b]=V N=F[u]u={N(j)}V={Y(u)}u=V V=x[m]V=V and-891734+14871427 or 11038230-383461 end end end end else if V<5589567-(-1008980)then if V<495954+5439192 then if V<5183836-(-507956)then if V<5684337-310767 then if V<4307403-(-897967)then l=p S=l z[l]=S l=nil V=1818578-(-141339)else T=x[I[-908273-(-908275)]]f=x[I[928709-928706]]y=T==f N=y V=10937393-674163 end else T=Z[-492157-(-492159)]V=x[I[1042307+-1042306]]y=Z[702281+-702280]f=V V=f[T]V=V and 16411057-1039814 or 16509335-431839 end else if V<5907959-65479 then N=4712015-(-906661)T=a(255123-204834)f=225698+2783487 y=T^f V=N-y N=a(-151130+201407)y=V V=N/y N={V}V=F[a(7514-(-42778))]else y=a(-928700+978954)N=a(694972+-644671)V=F[N]N=F[y]y=a(103000+-52746)F[y]=V y=a(-662992+713293)F[y]=N V=13195666-(-760862)y=x[I[364039-364038]]T=y()end end else if V<181373+6112434 then if V<7314658-1032848 then if V<718149+5376517 then N={}V=F[a(693234-642939)]else V=d(-85927+9463089,{A})e={V()}V=F[a(881441+-831177)]N={Y(e)}end else N=a(266422+-216135)y=a(-271462+321746)V=F[N]N=V(y)V=F[a(381333-331051)]N={}end else if V<-195186+6704713 then V=4835180-911561 x[I[-118260+118265]]=N y=nil else H=not Q L=L+U N=L<=e N=H and N H=L>=e H=Q and H N=H or N H=3621769-(-1021655)V=N and H N=-440241+1916963 V=V or N end end end else if V<8462371-643047 then if V<-891644+8122604 then if V<6961112-(-110890)then if V<-771281+7414659 then t=not R f=f+C T=f<=A T=t and T t=f>=A t=R and t T=t or T t=-931981+17703674 V=T and t T=-353178+4721180 V=V or T else b=J(b)M=J(M)m=J(m)S=J(S)u=nil V=5739141-(-803492)H=J(H)D=J(D)end else x[T]=L V=x[T]V=V and-224522+15586494 or-1033903+17194454 end else if V<7480876-193541 then x[T]=N V=-364473+7039209 else g=607060-607058 V=7788329-(-729718)O=u[g]g=x[b]q=O==g j=q end end else if V<139299+8142604 then if V<8834065-905574 then q=-21908+21909 V=11028864-914606 i=u[q]j=i else y=a(590761-540474)V=F[y]f=568416+-568416 T=x[I[-397994+398002]]y=V(T,f)V=-442055+16247517 end else if V<7701184-(-844802)then N=j V=i V=7989542-736137 else z=a(1088449-1038193)h=F[z]z=a(-797717-(-847979))v=h[z]G=v V=12943117-(-927607)end end end end end else if V<-861304+14743090 then if V<9942434-(-544251)then if V<-219951+9602835 then if V<8718048-(-485363)then if V<155678+8753333 then if V<-981050+9857726 then f=-266798-(-266837)T=x[I[536514+-536511]]y=T*f T=-845673+845930 V=1425756-809187 N=y%T x[I[-968337+968340]]=N else V=-975837+10951564 end else U=a(-78958-(-129252))H=a(370587-320333)V=F[U]Q=F[H]U=V(Q)V=a(405145+-354844)F[V]=U V=8942865-40512 end else if V<-484907+9817651 then z=not h B=B+v K=B<=G K=z and K z=B>=G z=h and z K=z or K z=-743132+2003328 V=K and z K=-129933+3927808 V=V or K else V=13406705-(-549823)end end else if V<222691+9910710 then if V<9208382-(-793452)then if V<10721786-819426 then C=a(-702287+752581)y=Z[942024-942023]T={n(-838818+838820,Y(Z))}B=25356595747214-453487 V={Y(T)}N=a(-43531-(-93809))f=V V=F[N]N=V()A=N N=F[C]C=N(y)R=x[I[466813-466812]]t=x[I[553754-553752]]G=a(458911-408632)K=t(G,B)N=R[K]V=C==N V=V and 687289+-541152 or 921920+13703036 else V=true V=V and 15613690-253773 or 5592559-(-449322)end else W=-537201+537202 x[T]=j g=x[D]O=g+W q=u[O]i=v+q q=-855819-(-856075)V=i%q v=V V=6097414-(-577322)O=x[S]q=h+O O=994367-994111 i=q%O h=i end else if V<11111057-856403 then Q=#z p=-870465-(-870466)l=f(p,Q)S=482971+-482970 p=R(z,l)Q=x[h]M=p-S H=t(M)l=nil Q[p]=H V=14086145-(-645861)p=nil else V=N and-593986+3441762 or 1007952+2915667 end end end else if V<433695+11015401 then if V<443063+10903978 then if V<-587280+11677907 then if V<-7734+10745195 then i=x[T]V=i and-503815+8395126 or 10201273-87015 j=i else y=x[I[-930151+930152]]N=#y y=684472-684472 V=N==y V=V and 11123070-(-228834)or-147996+1068587 end else V=F[a(753925-703673)]N={T}end else if V<10465341-(-930527)then f=-319480-(-319553)T=x[I[67689-67687]]y=T*f T=246579+35080046656666 N=y+T y=35184371760417-(-328415)V=N%y x[I[342054+-342052]]=V V=820544+8042264 y=x[I[-695935-(-695938)]]T=729629+-729628 N=y~=T else V=true N={}x[I[-949909-(-949910)]]=V V=F[a(-940004-(-990297))]end end else if V<12370787-(-682109)then if V<-699520+12509275 then U=a(207179+-156885)l=X(-466480+2440496,{})G=r()x[G]=N v=531644+-531579 V=x[t]B=328309-328306 N=V(B,v)B=r()x[B]=N V=-163931+163931 v=V z=a(-107539-(-157827))N=F[z]z={N(l)}V=979857-979857 h=V V={Y(z)}z=V N=632514+-632512 V=z[N]N=a(-223345-(-273606))l=V V=F[N]p=x[f]e=F[U]U=e(l)e=a(650661+-600381)L=p(U,e)p={L()}N=V(Y(p))p=r()V=-619907+7162540 x[p]=N N=599298-599297 L=x[B]e=L L=-433846-(-433847)U=L L=-254722+254722 Q=U<L L=N-U else N={}V=F[a(704924+-654667)]end else if V<-84774+13657169 then p=#z Q=919359-919359 l=p==Q V=696520+9437960 else V=B N=G V=G and 12044723-338912 or-941610+2554312 end end end end else if V<708965+15086083 then if V<13949692-(-1007575)then if V<265020+14355197 then if V<15016155-673345 then if V<14026811-66214 then V=true V=V and 5748792-(-166129)or 775344+11188841 else j=x[T]V=j and 716413-(-1018549)or 915953+6337452 N=j end else R=x[C]V=17008399-700730 N=R end else if V<-56099+14719060 then V=x[I[941534+-941531]]N={V(y,Y(T))}N={Y(N)}V=F[a(-946734-(-997003))]else Q=43995-43995 p=#z l=p==Q V=l and-835133-(-939892)or 10448783-314303 end end else if V<492622+14872588 then if V<16089303-728957 then U=884255-884254 V=x[t]Q=-633773-(-633779)e=V(U,Q)V=a(739044+-688743)Q=a(-128499-(-178800))F[V]=e U=F[Q]Q=-181713+181715 V=U>Q V=V and 547641+8500722 or-602776+16372216 else V=231558+16177871 end else if V<15429040-(-138774)then V=11064676-(-211738)else Q=a(1002230-951929)V=F[Q]Q=a(770925-720671)F[Q]=V V=534297+8368056 end end end else if V<15623552-(-616820)then if V<870354+15233567 then if V<16486902-409445 then if V<-482767+16502475 then f=x[I[17892+-17883]]T=401133-401132 A=f V={}y=V f=-166525-(-166526)C=f f=-317112-(-317112)V=684845+5957461 R=C<f f=T-C else V=6976726-681556 f=x[I[-906376+906382]]T=f==y N=T end else C=-329830+35184372418662 V={}x[I[-700232+700234]]=V N=x[I[-892243-(-892246)]]A=N N=T%C t=-896058-(-896313)x[I[-972837-(-972841)]]=N R=T%t K=a(-387515-(-437812))t=184156-184154 C=R+t x[I[530925-530920]]=C t=F[K]K=a(-407643+457911)B=-1017793+1017794 R=t[K]V=363688+8954415 t=R(y)R=a(-614563+664861)v=B f[T]=R R=-429052+429202 K=-931568-(-931569)G=t B=182335+-182335 h=v<B B=K-v end else if V<16931335-771272 then V=9652679-(-323048)else V=true V=618279+5656239 end end else if V<16381205-72749 then if V<15398319-(-892216)then T=x[I[-537779+537782]]G=-510072-(-510074)f=582821+-582789 v=-588613-(-588626)y=T%f A=x[I[62650-62646]]t=x[I[881508+-881506]]l=x[I[193633+-193630]]z=l-y l=-658106-(-658138)h=z/l B=v-h K=G^B R=t/K C=A(R)A=-411912+4295379208 f=C%A C=-144689-(-144691)K=-801899+801900 G=-175396+175652 A=C^y T=f/A A=x[I[250113+-250109]]V=-1024080+1944671 t=T%K K=491819+4294475477 R=t*K C=A(R)A=x[I[-50739+50743]]R=A(T)t=875456+-809920 f=C+R C=-782824+848360 A=f%C R=f-A C=R/t t=-170353+170609 R=A%t f=nil K=A-R t=K/G G=-489576+489832 K=C%G v=-695017+695273 A=nil T=nil B=C-K G=B/v B={R;t;K,G}C=nil t=nil G=nil x[I[353413+-353412]]=B y=nil K=nil R=nil else t=a(-366801-(-417073))R=N N=F[t]K=a(-144379+194635)t=a(-173312-(-223585))V=N[t]t=r()x[t]=V N=F[K]K=a(297700-247434)V=N[K]B=V h=a(-52131-(-102387))v=F[h]K=V V=v and 513158+8062000 or 14153386-282662 G=v end else if V<871825+15884337 then p=J(p)l=nil h=nil G=J(G)z=nil R=nil K=nil R=a(1011765-961493)f=J(f)B=J(B)f=nil C=J(C)A=J(A)v=nil G=a(-729902-(-780199))t=J(t)T=J(T)T=nil A=r()t=a(-58327+108599)z={}h=r()x[A]=T v={}l=354975+-354974 T=r()x[T]=f C=F[R]R=a(934882+-884601)f=C[R]C=r()x[C]=f R=F[t]t=a(-563831+614104)f=R[t]p=879320+-879064 K=a(-873170+923426)B=r()t=F[K]K=a(-369960-(-420219))Q=p R=t[K]K=F[G]G=a(-749498-(-799794))t=K[G]p=207720-207719 K=917490+-917490 G=r()x[G]=K H=p K=718309-718307 x[B]=K p=-699588+699588 K={}M=H<p x[h]=v p=l-H V=1300355-(-659562)v=-301625-(-301625)else G=-27970+28225 K=-157244+157244 T=f V=x[I[280722+-280721]]t=V(K,G)V=5990845-(-651461)y[T]=t T=nil end end end end end end end V=#s return Y(N)end return(w(-372556+4142678,{}))(Y(N))end)(getfenv and getfenv()or _ENV,unpack or table[a(-770446+820708)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
end

local function tween_tp(place)
   local TweenService = getgenv().TweenService

   for i,v in pairs(getgenv().Workspace:GetDescendants()) do
      if v.Name == place and v:IsA("BasePart") then
         if getgenv().Character:FindFirstChildOfClass('Humanoid') and getgenv().Character:FindFirstChildOfClass('Humanoid').SeatPart then
            getgenv().Character:FindFirstChildOfClass('Humanoid').Sit = false
            wait(.1)
         end
         wait(0.1)
         TweenService:Create(getgenv().Character:FindFirstChild("HumanoidRootPart"), TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = v.CFrame}):Play()
      end
   end
end

local Crate_Types = {
	["Trail_Crate_1"] = true,
	["Trail_Crate_2"] = true,
	["Trail_Crate_3"] = true,
	["Trail_Crate_4"] = true,
	["Effect_Crate_1"] = true,
	["Effect_Crate_2"] = true,
	["Effect_Crate_3"] = true,
	["Effect_Crate_4"] = true,
	["Emote_Crate_1"] = true,
	["Emote_Crate_2"] = true,
	["Emote_Crate_3"] = true,
	["Emote_Crate_4"] = true,
}

local function Open_Crate(Crate_Type)
	if not Crate_Types[Crate_Type] then return end

	Open_Crate_RE:FireServer()
end

local function disable_logging_metrics(toggle)
	if toggle == true then
		local Send_Ads_Analytics = Remote_Events:FindFirstChild("Send_Ads_Analytics")
		local Postie = getgenv().ReplicatedStorage:FindFirstChild("Postie")
		local AdMonitorEvents = getgenv().ReplicatedStorage:FindFirstChild("AdMonitorEvents")
		local Bloxbiz_Remotes = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes")
		local UserIdling_RE = Bloxbiz_Remotes:FindFirstChild("UserIdlingEvent")

		if Send_Ads_Analytics then
			Send_Ads_Analytics.Parent = getgenv().AssetService
		end
		if Postie:FindFirstChild("Sent") then
			Postie:FindFirstChild("Sent"):Destroy()
		end
		if AdMonitorEvents:FindFirstChild("LogImpression") then
			AdMonitorEvents:FindFirstChild("LogImpression"):Destroy()
		end
		if UserIdling_RE then
			UserIdling_RE.Parent = getgenv().SoundService
		end
	elseif toggle == false then
		if getgenv().AssetService:FindFirstChild("Send_Ads_Analytics") then
			getgenv().AssetService:FindFirstChild("Send_Ads_Analytics").Parent = getgenv().ReplicatedStorage:FindFirstChild("Remote_Events")
		end
		if getgenv().SoundService:FindFirstChild("UserIdlingEvent") then
			getgenv().SoundService:FindFirstChild("UserIdlingEvent").Parent = getgenv().ReplicatedStorage:FindFirstChild("BloxbizRemotes")
		end
	else
		return 
	end
end

local All_Towers = {}

local function get_all_towers()
	for _, v in ipairs(getgenv().Workspace:FindFirstChild("Tower"):GetDescendants()) do
		if v:IsA("Model") and string.find(v.Name, "Floor") then
			table.insert(All_Towers, v)
		end
	end

	return 
end

local function collect_session_rewards()
	if Remote_Events:FindFirstChild("Collect_Session_Reward") then
        local args = {
            200
        }

        Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
        local args = {
            100
        }

        Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
        local args = {
            50
        }

        Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
        local args = {
            300
        }

        Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
        local args = {
            400
        }

        Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
        local args = {
            500
        }

        Remote_Events:WaitForChild("Collect_Session_Reward"):FireServer(unpack(args))
	end
end

local function delete_other_fake_tower()
    local ws = getgenv().Workspace or workspace
    local Top_Section = ws:FindFirstChild("Top_Section")
    if not Top_Section then warn("Top_Section not found") end

    local Practice_Stage = Top_Section and Top_Section:FindFirstChild("Practice_Stage")
    if not Practice_Stage then warn("Practice_Stage not found") end

    local Container = Practice_Stage and Practice_Stage:FindFirstChild("Container")
    if not Container then warn("Container not found") end

    local Floor1 = Container and Container:FindFirstChild("Floor #1")
    if not Floor1 then warn("Floor #1 not found") end

    local Reach = Floor1 and Floor1:FindFirstChild("Reach Detector")
    local Pass = Floor1 and Floor1:FindFirstChild("Pass Detector")

    if Reach then
        Reach:Destroy()
    end

    if Pass then
        Pass:Destroy()
    end
end

local function GodMode(toggle)
	local General_Folder = getgenv().LocalPlayer:FindFirstChild("General")
	local Temporary_Immunity = General_Folder:FindFirstChild("Temporary_Immunity")

	if toggle == true then
        Update_Setting_RE:FireServer(30, false)
		Temporary_Immunity.Value = true
	elseif toggle == false then
		Temporary_Immunity.Value = false
	else
		return 
	end
end

local function Give_Arcade_Points(number_of_points)
    for i = 1, number_of_points do
        local args = {
            "Zombie_Slayer"
        }

        Remote_Events:WaitForChild("Add_Arcade_Points"):FireServer(unpack(args))
    end
end

local function Spectate(toggle)
	local General_Folder = getgenv().LocalPlayer:FindFirstChild("General")
	local Spectate = General_Folder:FindFirstChild("Spectating")

	if toggle == true then
		Spectate.Value = true
	elseif toggle == false then
		Spectate.Value = false
	else
		return 
	end
end

local function Touched_Door()
	local General_Folder = getgenv().LocalPlayer:FindFirstChild("General")
	local Door_Touched = General_Folder:FindFirstChild("DoorTouched")

	if Door_Touched >= 15 then
		return true
	elseif Door_Touched == 0 then
		return false
	else
		return warn("[DEBUG]:", "Not sure if RewardDoor has been touched or not.")
	end
end

local function collect_all()
    Update_Setting_RE:FireServer(30, false)
    wait(0.2)
    if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value >= 70 then return end
    for _, v in ipairs(getgenv().Workspace:FindFirstChild("Tower"):GetDescendants()) do
        if v:FindFirstChild("Pass Detector") then
            GodMode(true)
            wait(0.2)
            tween_tp("Pass Detector")
        end
    end
end

local function enable_in_game_catalog(toggle)
    if toggle == true then
        getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = true
    elseif toggle == false then
        getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = false
    else
        return 
    end
end

local Shop_Folder = getgenv().ReplicatedStorage:WaitForChild("Remote_Functions"):WaitForChild("Shop")

local function Purchase_Mutator(Mutator)
    if not Shop_Folder then return end

    if Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)) then
        Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)):InvokeServer()
    end
end

local function touch_door()
    Update_Setting_RE:FireServer(30, false)
    wait(0.1)
    repeat task.wait() until getgenv().LocalPlayer.General.CoinsEarned.Value >= 70
    repeat task.wait() until getgenv().Workspace:FindFirstChild("Tower") and getgenv().Workspace:FindFirstChild("Top_Section")
    if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value >= 70 then
        delete_other_fake_tower()
        local Reward_Door = getgenv().Workspace:FindFirstChild("Top_Section"):FindFirstChild("Hallway"):FindFirstChild("RewardDoor")

        GodMode(true)
        wait(0.3)
        tween_tp("RewardDoor")
    end
end

local ws = getgenv().Workspace or workspace
local Top_Section = ws:FindFirstChild("Top_Section")
if not Top_Section then warn("Top_Section not found") end

local Practice_Stage = Top_Section and Top_Section:FindFirstChild("Practice_Stage")
if not Practice_Stage then warn("Practice_Stage not found") end

local Container = Practice_Stage and Practice_Stage:FindFirstChild("Container")
if not Container then warn("Container not found") end

local Floor1 = Container and Container:FindFirstChild("Floor #1")
if not Floor1 then warn("Floor #1 not found") end

local Reach = Floor1 and Floor1:FindFirstChild("Reach Detector")
local Pass = Floor1 and Floor1:FindFirstChild("Pass Detector")

if Reach then
    Reach:Destroy()
else
    warn("Reach Detector not found")
end

if Pass then
    Pass:Destroy()
else
    warn("Pass Detector not found")
end

local container = getgenv().Workspace:WaitForChild("Top_Section"):WaitForChild("Practice_Stage"):WaitForChild("Container")

container.ChildAdded:Connect(function(child)
    if child.Name == "Floor #1" then
        child:Destroy()
    end
end)

local function LocalPlayer_loaded()
   local player = Players.LocalPlayer
   if not player then
      repeat task.wait() until Players.LocalPlayer
      player = Players.LocalPlayer
   end

   if not player.Character or not player.Character:FindFirstChild("Humanoid") then
      player.CharacterAdded:Wait()
      repeat task.wait() until player.Character:FindFirstChild("Humanoid")
   end
end

local function render_safe()
   RunService.RenderStepped:Wait()
   task.wait(0.2)
end

local function load_rayfield()
    local attempts = 0
    local maxAttempts = 10
    local success = false
    local result

    repeat
        attempts += 1
        success, result = pcall(function()
            local raw = game:HttpGet("https://raw.githubusercontent.com/LmaoItsCrazyBro/new_main/main/Main_UI.lua")
            local func = loadstring(raw)
            return func()
        end)

        if not success or not result then
            warn("[Rayfield] Load failed (attempt " .. attempts .. "):", result)
            task.wait(1)
        end
    until (success and result) or attempts >= maxAttempts

    return result
end

local Window

LocalPlayer_loaded()
render_safe()

Rayfield = load_rayfield()

if typeof(Rayfield) == "table" and Rayfield.CreateWindow then
    Window = Rayfield:CreateWindow({
        Name = "✅ Tower Of Misery ✅ | 1.1.9 | "..tostring(executor_Name),
        LoadingTitle = "Welcome, "..tostring(game.Players.LocalPlayer),
        LoadingSubtitle = "TowerOfMisery | Hub.",
        ConfigurationSaving = {
            Enabled = false,
            FolderName = "TOM-Config",
            FileName = "TOMScriptHub"
        },
        Discord = {
            Enabled = false,
            Invite = "",
            RememberJoins = true
        },
        KeySystem = false,
        KeySettings = {
            Title = "None",
            Subtitle = "No key system is provided.",
            Note = "nice hidden dumper skid, it's useless (like you), joking, take a joke, this is open source.",
            FileName = "Key",
            SaveKey = false,
            GrabKeyFromSite = false,
            Key = {""}
        }
    })
else
    warn("[CRITICAL_ERROR]: Rayfield failed to load or is not valid. Returned:", Rayfield)
end
wait(1)
getgenv().notify = function(title, content, duration)
    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(content),
        Duration = tonumber(duration),
        Image = 93594537601787,
        Actions = {
            Ignore = {
                Name = "Okay.",
                Callback = function() 
                    print("...") 
                end
            },
        },
    })
end
task.wait(1)
local Tab1 = Window:CreateTab("🏡 Main 🏡", 0)
local Section1 = Tab1:CreateSection("| 🏡 Main 🏡 |")
local Tab2 = Window:CreateTab("🧍 Character 🧍", 0)
local Section2 = Tab2:CreateSection("| 🧍 Character Content 🧍 |")
local Tab3 = Window:CreateTab("⭐ Extras ⭐", 0)
local Section3 = Tab3:CreateSection("| ⭐ Extra Content ⭐ |")
wait(0.2)
getgenv().AntiCheat_Bypass = Tab1:CreateButton({
Name = "Anti Cheat Bypass",
Callback = function()
   bypass_anticheat()
end,})

getgenv().DisableLogging_AndMetricsData = Tab1:CreateToggle({
Name = "Disable Logging And Metrics Data",
CurrentValue = false,
Flag = "DisableAllLogsAndMetrics",
Callback = function(logging_toggle)
   if logging_toggle then
      disable_logging_metrics(true)
   else
      disable_logging_metrics(false)
   end
end,})
wait(0.2)
if getgenv().AssetService:FindFirstChild("Send_Ads_Analytics") then
   getgenv().DisableLogging_AndMetricsData:Set(false)
   disable_logging_metrics(false)
   getgenv().notify("Heads Up:", "Disabled AntiLogging, it was enabled at runtime.", 5)
end

local NoClip_Loop = nil
local Clip = false

local function NoclipLoop()
    if Clip == false and getgenv().Character ~= nil then
        for _, child in pairs(getgenv().Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end

getgenv().Auto_Win = Tab1:CreateButton({
Name = "Auto Win",
Callback = function()
    repeat wait() until getgenv().Workspace:FindFirstChild("Tower") and getgenv().Workspace:FindFirstChild("Top_Section")
    if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("CoinsEarned").Value <= 70 then
        if getgenv().God_ModeLocalPlr then
            getgenv().God_ModeLocalPlr:Set(true)
        end
        NoClip_Loop = getgenv().RunService.Stepped:Connect(NoclipLoop)
        GodMode(true)
        wait(0.1)
        collect_all()
        wait(3.6)
        touch_door()
    else
        GodMode(true)
        NoClip_Loop = getgenv().RunService.Stepped:Connect(NoclipLoop)
        wait(0.2)
        touch_door()
    end
end,})

getgenv().God_ModeLocalPlr = Tab2:CreateToggle({
Name = "GodMode",
CurrentValue = false,
Flag = "GodmodeValue",
Callback = function(real_godmode)
   if real_godmode then
      GodMode(true)
   else
      GodMode(false)
   end
end,})
wait(0.2)
if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Temporary_Immunity").Value == true then
   GodMode(false)
   getgenv().God_ModeLocalPlr:Set(false)
   getgenv().notify("Heads Up:", "Turned off GodMode, it was enabled at runtime.", 5)
end

getgenv().InGame_Catalog = Tab2:CreateToggle({
Name = "In-Game Catalog (FE, Free Items)",
CurrentValue = false,
Flag = "InGameCatalogItems",
Callback = function(avatar_items_catalog)
    if avatar_items_catalog then
        enable_in_game_catalog(true)
    else
        enable_in_game_catalog(false)
    end
end,})
wait(0.2)
if getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled == true then
    getgenv().InGame_Catalog:Set(false)
    getgenv().PlayerGui:FindFirstChild("IngameCatalog").Enabled = false
    wait(0.1)
    getgenv().notify("Heads Up:", "Disabled In-Game Catalog, it was enabled at runtime.", 5)
end

local Old_GUIs_States = {}

local function get_old_gui_states()
    for _, v in ipairs(getgenv().PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") then
            Old_GUIs_States[v] = v.Enabled
        end
    end
end

local function restore_old_guis()
    for gui, wasEnabled in pairs(Old_GUIs_States) do
        if gui and gui:IsA("ScreenGui") then
            gui.Enabled = wasEnabled
        end
    end
end

get_old_gui_states()
wait(0.6)

--[[getgenv().Inf_Coins = Tab3:CreateToggle({
Name = "Infinite Coins (WORKING!, USE BEFORE PATCH!)",
CurrentValue = false,
Flag = "InfCoinsFEWorking",
Callback = function(inf_coins_regen)
    local General = getgenv().LocalPlayer:FindFirstChild("General")
    local Viewing_Billboard = General and General:FindFirstChild("Viewing_Billboard")
    local Free_Spin_Alert = getgenv().PlayerGui:FindFirstChild("Free_Spin_Received")

    if not Viewing_Billboard or not Free_Spin_Alert then
        getgenv().redeem_all_spins = false
        getgenv().Inf_Coins:Set(false)
        return getgenv().notify("Error:", "Viewing_Billboard or FreeSpin GUI not found.", 5)
    end

    if inf_coins_regen then
        getgenv().redeem_all_spins = true
        while getgenv().redeem_all_spins do
            wait(3)
            Viewing_Billboard.Value = true
            wait(3)
            Free_Spin_Alert.Enabled = true
            wait(2)
            Viewing_Billboard.Value = false
            wait(2)
            restore_old_guis()
        end
    else
        getgenv().redeem_all_spins = false
        wait(0.9)
        Free_Spin_Alert.Enabled = false
        Viewing_Billboard.Value = false
        restore_old_guis()
    end
end,})--]]

getgenv().PurchaseAll_Mutators = Tab1:CreateButton({
Name = "Purchase All Mutators",
Callback = function()
    local Shop_Folder = getgenv().ReplicatedStorage:WaitForChild("Remote_Functions"):WaitForChild("Shop")

    local function Purchase_Mutator(Mutator)
        if not Shop_Folder then return end

        if Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)) then
            Shop_Folder:FindFirstChild("Purchase: "..tostring(Mutator)):InvokeServer()
        end
    end

    local Mutators = {
        "Fog Clouds",
        "Color Swap",
        "Quick Spawn",
        "Night Mode",
        "High Speed",
        "Low Gravity"
    }

    for _, mutator in ipairs(Mutators) do
        Purchase_Mutator(mutator)
    end
end,})

getgenv().Anti_Fog_AndColor_Swap = Tab1:CreateToggle({
Name = "Anti Fog (And Color Swap)",
CurrentValue = false,
Flag = "AntiFogAndColorSwap",
Callback = function(anti_fog_color_swap)
    if anti_fog_color_swap then
        getgenv().anti_fog_and_the_color_swap = true
        local Winner_Val = getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Winner")

        while getgenv().anti_fog_and_the_color_swap == true do
        wait()
            Winner_Val.Value = true
        end
    else
        getgenv().anti_fog_and_the_color_swap = false
        getgenv().anti_fog_and_the_color_swap = false
        wait(0.2)
        local Winner_Val = getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Winner")

        Winner_Val.Value = false
    end
end,})

getgenv().CollectAll_PlayTimeRewards = Tab3:CreateButton({
Name = "Collect All Playtime Rewards",
Callback = function()
    local Session_Rewards_Value = getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Session_Reward_Coins")
    collect_session_rewards()
    --[[local Crate_System_GUI = getgenv().PlayerGui:FindFirstChild("Crate_System_UI")
    local UI = Crate_System_GUI:FindFirstChild("UI")
    local HUD = UI:FindFirstChild("HUD")
    local Tabs = HUD:FindFirstChild("Tabs")
    local Session_Reard_v2 = Tabs:FindFirstChild("Session_Reward_v2")
    local TextLabel = Session_Reward_v2:FindFirstChild("CanvasGroup"):FindFirstChild("TextLabel")
    local Old_Text = TextLabel.Text
    wait(0.2)
    collect_session_rewards()
    wait(0.2)
    TextLabel.Text = "0/100"--]]
end,})

getgenv().GiveArcade_Points_50 = Tab2:CreateButton({
Name = "Give 50 Arcade Points",
Callback = function()
    Give_Arcade_Points(50)
end,})

getgenv().GiveArcade_Points_100 = Tab2:CreateButton({
Name = "Give 100 Arcade Points",
Callback = function()
    Give_Arcade_Points(100)
end,})

getgenv().GiveArcade_Points_1000 = Tab2:CreateButton({
Name = "Give 1000 Arcade Points",
Callback = function()
    Give_Arcade_Points(1000)
end,})

getgenv().Rainbow_FE_Skin = Tab2:CreateToggle({
Name = "Rainbow Skin (FE)",
CurrentValue = false,
Flag = "FERainbowSkinScript",
Callback = function(rainbow_loop)
    local Old_Main_Color = getgenv().Character:FindFirstChild("Body Colors").TorsoColor
    wait()
    if rainbow_loop then
        getgenv().skin_rainbow_loop = true
        while getgenv().skin_rainbow_loop == true do
        wait()
            local colorCycle = {
                Color3.fromRGB(17, 17, 17),
                Color3.fromRGB(101, 67, 33),
                Color3.fromRGB(0, 102, 204),
                Color3.fromRGB(0, 153, 0),
                Color3.fromRGB(255, 255, 255),
                Color3.fromRGB(128, 128, 128),
                Color3.fromRGB(255, 255, 0),
                Color3.fromRGB(255, 165, 0),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(128, 0, 128),
                Color3.fromRGB(255, 105, 180),
                Color3.fromRGB(0, 255, 255)
            }

            local remote = getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid")

            for _, color in ipairs(colorCycle) do
                task.wait(.3)
                local payload = {
                    { BodyColor = color }
                }

                remote:FireServer(unpack(payload))
            end
        end
    else
        getgenv().skin_rainbow_loop = false
        getgenv().skin_rainbow_loop = false
        wait(0.3)
        if getgenv().Character:FindFirstChild("Body Colors") then
            getgenv().notify("Hang On:", "Resetting Body Colors...", 5)
            wait(1.2)
            local args = {
                {
                    BodyColor = Old_Main_Color
                }
            }
            getgenv().ReplicatedStorage:WaitForChild("BloxbizRemotes"):WaitForChild("CatalogOnApplyToRealHumanoid"):FireServer(unpack(args))
            wait(1)
            if getgenv().Character:FindFirstChild("Body Colors").TorsoColor == Old_Main_Color then
                return getgenv().notify("Success:", "Reset fully body colors back to default.", 5)
            else
                return getgenv().notify("Alert:", "Could not determine if Body Colors we're reset properly.", 5)
            end
        end
    end
end,})
wait(0.2)
if getgenv().skin_rainbow_loop == true then
    getgenv().Rainbow_FE_Skin:Set(false)
    getgenv().skin_rainbow_loop = false
    getgenv().notify("Heads Up:", "Disabled RainbowSkinFE, it was enabled at runtime.", 5)
end

getgenv().GiveArcade_Points_Other = Tab2:CreateInput({
Name = "Give Arcade Points",
PlaceholderText = "Number Here",
RemoveTextAfterFocusLost = true,
Callback = function(Number_Points)
    local Number_Of_Points_Input = tonumber(Number_Points)

    if Number_Of_Points_Input then
        Give_Arcade_Points(Number_Points)
    else
        return getgenv().notify("Failure:", tostring(Number_Points).." isn't a number!", 5)
    end
end,})

getgenv().SpectatePlayers = Tab3:CreateToggle({
Name = "Spectate",
CurrentValue = false,
Flag = "SpectatingValChange",
Callback = function(spectating_plrs)
   if spectating_plrs then
      Spectate(true)
   else
      Spectate(false)
   end
end,})
wait(0.2)
if getgenv().LocalPlayer:FindFirstChild("General"):FindFirstChild("Spectating").Value == true then
   Spectate(false)
   getgenv().SpectatePlayers:Set(false)
   getgenv().notify("Heads Up:", "Disabled Spectate, it was enabled at runtime.", 5)
end
