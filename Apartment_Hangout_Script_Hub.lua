if not game:IsLoaded() then
   local msg_instance = Instance.new("Message")
   local hint_instance = Instance.new("Hint")

   msg_instance.Text = "Flames Hub is waiting for the current experience to load fully."
   hint_instance.Text = "Flames Hub is currently waiting for the game to load."
   if workspace and workspace:IsDescendantOf(game) then
      msg_instance.Parent = workspace
      hint_instance.Parent = workspace
   end
   game.Loaded:Wait()
   if game.Players then
      local ok, response = pcall(function()
         game.Players:CreateLocalPlayer()
      end)

      if not ok then
         if getgenv().notify then
            getgenv().notify("Warning", "Could not create LocalPlayer, response: "..tostring(response), 12)
         else
            warn("Could not create LocalPlayer because: "..tostring(response))
         end
         if not game.Players.LocalPlayer then
            if not getgenv().LocalPlayer then
               local localplayer = game.Players.LocalPlayer or game.Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
               getgenv().LocalPlayer = localplayer
            end
         end
      else
         if getgenv().notify then
            getgenv().notify("Success", "Got response: "..tostring(response), 6)
         else
            print("Created LocalPlayer, got response: "..tostring(response))
         end
      end
   end
end
wait(0.1)
local g = getgenv()

if getgenv().Apartment_Hangout_Script_Hub_Abuser then
   if getgenv().notify then
      return getgenv().notify("Warning", "Flames Hub | Apartment Hangout Hub, is already running!", 10)
   else
      return warn("Flames Hub | Apartment Hangout Hub, is already running.")
   end
end

getgenv().Apartment_Hangout_Script_Hub_Abuser = true

function close_menu()
   closeWindow()
   getgenv().Apartment_Hangout_Script_Hub_Abuser = false
end

if not getgenv().GlobalEnvironmentFramework_Initialized then
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua'))()
   wait(0.1)
   getgenv().GlobalEnvironmentFramework_Initialized = true
end
wait(0.3)
getgenv().type_checker_function = getgenv().type_checker_function or function(what, what_type) return typeof(what) == "Instance" and what:IsA(what_type) or false end
getgenv().input_to_string = getgenv().input_to_string or function(input_value) return typeof(input_value) == "string" and input_value or tostring(input_value) end
getgenv().service_cache = getgenv().service_cache or {}
getgenv().service_wrap = function(name)
   local cache = getgenv().service_cache
   if cache[name] then
      return cache[name]
   end

   local ok, svc = pcall(function()
      local s = game:GetService(name)
      return cloneref and cloneref(s) or s
   end)

   if not ok or not svc then
      return nil
   end

   if rawset then
      rawset(cache, name, svc)
   else
      cache[name] = svc
   end

   return svc
end

repeat task.wait() until service_wrap
wait(0.2)
local MarketplaceService = service_wrap("MarketplaceService")
local game_name = MarketplaceService:GetProductInfo(game.PlaceId).Name
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LumUILibrary.lua"))()
local Window = Library.new(tostring(game_name).." - Control Panel")
local HomeTab = Window:Tab("Home")
local UITab = Window:Tab("UI")
local Home_Section = HomeTab:Section("Main")
local UISection = UITab:Section("UI")
local Players = getgenv().Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local get_conns = getconnections or get_signal_cons or blankfunction
local replicate_sig_func = replicatesignal or replicate_signal or DeltaSignal
local set_hid_func = sethiddenproperty or set_hidden_property or set_hidden_prop or sethiddenprop
getgenv().FlamesLibrary = getgenv().FlamesLibrary or {}
getgenv().FlamesLibrary._connections = getgenv().FlamesLibrary._connections or {}
getgenv().FlamesLibrary.connect = function(name, connection)
	getgenv().FlamesLibrary._connections[name] = getgenv().FlamesLibrary._connections[name] or {}
	table.insert(getgenv().FlamesLibrary._connections[name], connection)
	return connection
end

getgenv().FlamesLibrary.disconnect = function(name)
	local list = getgenv().FlamesLibrary._connections[name]

	if list then
		for _, item in ipairs(list) do
			if typeof(item) == "RBXScriptConnection" then
				item:Disconnect()
			elseif type(item) == "thread" then
				pcall(task.cancel, item)
			end
		end
		getgenv().FlamesLibrary._connections[name] = nil
	end
end

getgenv().FlamesLibrary.spawn = function(name, mode, func, ...)
	getgenv().FlamesLibrary._connections[name] = getgenv().FlamesLibrary._connections[name] or {}

	local thread

	if mode == "spawn" then
		thread = task.spawn(func, ...)
	elseif mode == "defer" then
		thread = task.defer(func, ...)
	elseif mode == "delay" then
      local args = { ... }
      local delay_time = table.remove(args, 1)
      thread = task.delay(delay_time, func, table.unpack(args))
	elseif mode == "wrap" then
		thread = coroutine.create(func)
		coroutine.resume(thread, ...)
	else
      -- don't really need a warning --
		-- warn("Invalid spawn mode / argument: "..tostring(mode))
		return
	end

	table.insert(getgenv().FlamesLibrary._connections[name], thread)
	return thread
end

getgenv().FlamesLibrary.is_thread_alive = function(thread)
	if type(thread) ~= "thread" then
		return false
	end

	local success, status = pcall(coroutine.status, thread)
	if not success then
		return false
	end

	return status ~= "dead" -- die stupid thread!
end

getgenv().FlamesLibrary.is_alive = function(name)
	local list = getgenv().FlamesLibrary._connections[name]

	if not list then
		return false
	end

	for _, item in ipairs(list) do
		if type(item) == "thread" then
			if getgenv().FlamesLibrary.is_thread_alive(item) then
				return true
			end
		elseif typeof(item) == "RBXScriptConnection" then
			if item.Connected then
				return true
			end
		end
	end

	return false
end

getgenv().FlamesLibrary.cleanup_all = function()
	for name in pairs(getgenv().FlamesLibrary._connections) do
		getgenv().FlamesLibrary.disconnect(name)
	end
   if getgenv().notify then
      getgenv().notify("Success", "Cleaned up all concurrent threads/connections.", 7)
   end
end

local words = {
	"yo",
	"wsp",
	"lol",
	"hi",
	"greetings",
	"i guess",
	"bruh",
	"dead serious rn",
	"nah you're not",
	"you cannot be"
}

getgenv().find_sign_tool = function()
   local Character_Main = getgenv().Character or getgenv().LocalPlayer.Character or getgenv().Players.LocalPlayer.Character or game.Players.LocalPlayer.Character

   for _, v in ipairs(LocalPlayer:FindFirstChildOfClass("Backpack"):GetDescendants()) do
      if v:IsA("Tool") and v.Name:lower():find("sign") then
         return v
      end
   end

   for _, v in ipairs(Character_Main:GetDescendants()) do
      if v:IsA("Tool") and v.Name:lower():find("sign") then
         return v
      end
   end

   return nil
end

getgenv().find_sign_remote_F = function()
   local sign_tool = getgenv().find_sign_tool()

   if sign_tool and sign_tool:IsA("Tool") then
      for _, v in ipairs(sign_tool:GetDescendants()) do
         if v:IsA("RemoteFunction") then
            return v
         end
      end
   end

   return nil
end

getgenv().sign_spammer_loop = function(toggle)
   if toggle == true then
      local remote_f = getgenv().find_sign_remote_F()

      if not remote_f or remote_f.ClassName ~= "RemoteFunction" then
         return getgenv().notify("Error", "RemoteFunction doesn't exist or isn't a RemoteFunction", 8)
      end

      getgenv().FlamesLibrary.spawn("sign_spammer_loop","spawn",function()
         while true do
            task.wait(0)
            for _, wrd in ipairs(words) do
               task.wait(0)
               remote_f:InvokeServer(tostring(wrd))
               RunService.Heartbeat:Wait()
            end
         end
      end)
   elseif toggle == false then
      getgenv().FlamesLibrary.disconnect("sign_spammer_loop")
   end
end

getgenv().find_afk_status_remote_event = function()
   local cached = getgenv().afk_status_remote_event_found
   if cached and cached:IsA("RemoteEvent") then
      return cached
   end

   for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
      if v:IsA("RemoteEvent") and v.Name:lower():find("afk") then
         getgenv().afk_status_remote_event_found = v
         return v
      end
   end

   return nil
end
wait(0.1)
if not getgenv().afk_status_remote_event_found then pcall(function() getgenv().find_afk_status_remote_event() end)

getgenv().afk_toggle_func = function(toggle)
   local found_afk_status_updater_RE = getgenv().afk_status_remote_event_found or getgenv().find_afk_status_remote_event()
   if not found_afk_status_updater_RE or not found_afk_status_updater_RE:IsA("RemoteEvent") then
      if getgenv().notify then
         return getgenv().notify("Error", "AFK RemoteEvent status updater not found or is not a RemoteEvent.", 6)
      end
   end

   if toggle == true then
      local args = {
         true
      }

      found_afk_status_updater_RE:FireServer(unpack(args))
   elseif toggle == false then
      local args = {
         false
      }
      
      found_afk_status_updater_RE:FireServer(unpack(args))
   else
      return 
   end
end

getgenv().afk_toggle_spammer_FE = function(toggle)
   if toggle == true then
      getgenv().FlamesLibrary.spawn("afk_toggle_spammer_FE","spawn",function()
         while true do
            task.wait(0)
            getgenv().afk_toggle_func(true)
            task.wait(0)
            getgenv().afk_toggle_func(false)
         end
      end)
   elseif toggle == false then
      getgenv().FlamesLibrary.disconnect("afk_toggle_spammer_FE")
   end
end

getgenv().find_device_changer_remote_event = function()
   local cached = getgenv().device_changer_remote_event_found
   if cached and cached:IsA("RemoteEvent") then
      return cached
   end

   for _, v in ipairs(getgenv().ReplicatedStorage:GetDescendants()) do
      if v:IsA("RemoteEvent") and v.Name:lower():find("device") then
         getgenv().device_changer_remote_event_found = v
         return v
      end
   end

   return nil
end
wait(0.1)
if not getgenv().device_changer_remote_event_found then pcall(function() getgenv().find_device_changer_remote_event() end)

getgenv().device_switcher_input = function(device)
   local device_changer_switcher_RE = getgenv().device_changer_remote_event_found or getgenv().find_device_changer_remote_event()
   if not device_changer_remote_event_found or not device_changer_remote_event_found:IsA("RemoteEvent") then
      return getgenv().notify("Error", "Device Changer RemoteEvent not found or is not a RemoteEvent.", 6)
   end

   if device == "PC" then
      device_changer_remote_event_found:FireServer("PC")
   elseif device == "Mobile" then
      device_changer_remote_event_found:FireServer("Mobile")
   else
      return 
   end
end

getgenv().device_switcher_spammer_toggle_loop = function(toggle)
   if toggle == true then
      getgenv().FlamesLibrary.spawn("device_switcher_spammer_toggle_loop","spawn",function()
         while true do
            task.wait()
            getgenv().device_switcher_input("Mobile")
            task.wait()
            getgenv().device_switcher_input("PC")
         end
      end)
   elseif toggle == false then
      getgenv().FlamesLibrary.disconnect("device_switcher_spammer_toggle_loop")
   end
end
wait(0.2)
if not getgenv().destroyed_admin_led_panel_barrier then
   for _, v in ipairs(workspace:GetDescendants()) do
      if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") and v:FindFirstChildOfClass("Script") then
         local Script_Found = v:FindFirstChildOfClass("Script")

         if Script_Found and Script_Found.Name:lower():find("group") then
            if Script_Found.Parent:FindFirstChildOfClass("TouchTransmitter") then
               Script_Found.Parent:FindFirstChildOfClass("TouchTransmitter"):Destroy()
            end
            Script_Found.Parent.CanCollide = false
         end
      end
   end
   wait(0.1)
   getgenv().destroyed_admin_led_panel_barrier = true
end

getgenv().find_led_panel_one = function()
   local cached = getgenv().found_main_led_panel
   if cached and cached:IsA("BasePart") then
      return cached
   end

   for _, v in ipairs(workspace:GetDescendants()) do
      if v:IsA("BasePart") and v.Name:lower():find("led") and v.Name:lower():find("panel") and v.Position == Vector3.new(127.619423, 89.7881927, -9.43470478) then
         getgenv().found_main_led_panel = v
         return v
      end
   end

   return nil
end

getgenv().find_led_panel_two = function()
   local cached = getgenv().found_secondary_led_panel
   if cached and cached:IsA("BasePart") then
      return cached
   end

   for _, v in ipairs(workspace:GetDescendants()) do
      if v:IsA("BasePart") and v.Name:lower():find("led") and v.Name:lower():find("panel") and v.Position == Vector3.new(122.49067687988281, 89.78819274902344, -9.434704780578613) then
         getgenv().found_secondary_led_panel = v
         return v
      end
   end

   return nil
end
wait(0.2)
-- [[ let them run in 'pcall' and let Roblox take the wheel. ]] --
if not getgenv().found_main_led_panel then pcall(function() getgenv().find_led_panel_one() end) end
if not getgenv().found_secondary_led_panel then pcall(function() getgenv().find_led_panel_two() end) end
wait(0.2)
local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
wait(0.1)
getgenv().spam_led_panel_everything = function(toggled)
   if toggled == true then
      if not firesignal then
         return getgenv().notify("Error", "'firesignal' is not supported in this executor! You cannot use this!", 10)
      end

      getgenv().FlamesLibrary.spawn("spam_led_panel_everything","spawn",function() -- finally, back to where we should have already been.
         while true do
            task.wait(0)
            for _, v in ipairs(getgenv().found_main_led_panel:GetDescendants()) do
               if v:IsA("ImageButton") or v:IsA("TextButton") then
                  for _, Signal in pairs(Signals) do
                     firesignal(v[Signal])
                  end
               end
            end
            task.wait(0)
            for _, v in ipairs(getgenv().found_secondary_led_panel:GetDescendants()) do
               if v:IsA("ImageButton") or v:IsA("TextButton") then
                  for _, Signal in pairs(Signals) do
                     firesignal(v[Signal])
                  end
               end
            end
         end
      end)
   elseif toggled == false then
      getgenv().FlamesLibrary.disconnect("spam_led_panel_everything")
   end
end

getgenv().Device_Spammer_Toggle_UI = Home_Section:Toggle("Device Spammer (FE)", function(state)
   if state then
      getgenv().device_switcher_spammer_toggle_loop(true)
   else
      getgenv().device_switcher_spammer_toggle_loop(false)
   end
end)

getgenv().AFK_Toggle_Loop_Toggle = Home_Section:Toggle("AFK Spammer (FE)", function(state)
   if state then
      getgenv().afk_toggle_spammer_FE(true)
   else
      getgenv().afk_toggle_spammer_FE(false)
   end
end)

getgenv().sign_spammer_toggle_UI = Home_Section:Toggle("Sign Spammer (FE)", function(state)
   if state then
      getgenv().FlamesLibrary.spawn("sign_tool_holder","spawn",function() -- ensures your Sign (Tool) stays inside your Character so long as you have the loop on. 🔥
         while true do
            task.wait(0)
            local backpack = getgenv().LocalPlayer:FindFirstChildOfClass("Backpack")
            local char = getgenv().Character or getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character

            if backpack and char then
               local sign = backpack:FindFirstChild("Sign")
               if sign and sign:IsA("Tool") then
                  sign.Parent = char
               end
            end
         end
      end)

      getgenv().sign_spammer_loop(true)
   else
      getgenv().FlamesLibrary.disconnect("sign_tool_holder") -- ez
      getgenv().sign_spammer_loop(false)
   end
end)

if firesignal and typeof(firesignal) == "function" then -- REAL checking only found in Flames Hub 😎💪🔥.
   getgenv().Led_Spammer_Admin_Panel = Home_Section:Toggle("Stage LED Spammer (FE)", function(state)
      if state then
         getgenv().spam_led_panel_everything(true)
      else
         getgenv().spam_led_panel_everything(false)
      end
   end)
end

UISection:Button("Destroy GUI", function()
   close_menu()
end)
