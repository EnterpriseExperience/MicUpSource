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
      return getgenv().notify("Warning", "Flames Hub | Apartment Hangout Hub is already loaded!", 6)
   else
      return 
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
getgenv().type_checker_function = function(what, what_type)
   return typeof(what) == "Instance" and what:IsA(what_type) or false
end

getgenv().input_to_string = getgenv().input_to_string or function(input_value)
   return typeof(input_value) == "string" and input_value or tostring(input_value)
end

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
local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
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
	if getgenv().FlamesLibrary._connections[name] then
		for _, conn in ipairs(getgenv().FlamesLibrary._connections[name]) do
			conn:Disconnect()
		end
		getgenv().FlamesLibrary._connections[name] = nil
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
      if not remote_f or not remote_f.ClassName == "RemoteFunction" then
         return getgenv().notify("Error", "RemoteFunction doesn't exist or isn't a RemoteFunction", 8)
      end
      task.wait()
      getgenv().sign_spamming_looping = true
      while getgenv().sign_spamming_looping == true do
      task.wait(0)
         for _, wrd in ipairs(words) do
            task.wait(0)
            local args = {
               tostring(wrd)
            }
            
            remote_f:InvokeServer(unpack(args))
         end
      end
   elseif toggle == false then
      getgenv().sign_spamming_looping = false
   else
      return 
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

getgenv().afk_toggle_func = function(toggle)
   if toggle == true then
      local args = {
         true
      }

      getgenv().find_afk_status_remote_event():FireServer(unpack(args))
   elseif toggle == false then
      local args = {
         false
      }
      
      getgenv().find_afk_status_remote_event():FireServer(unpack(args))
   else
      return 
   end
end

getgenv().afk_toggle_spammer_FE = function(toggle)
   if toggle == true then
      getgenv().afk_spammer_toggled = true
      while getgenv().afk_spammer_toggled == true do
         task.wait(0)
         getgenv().afk_toggle_func(true)
         task.wait(0)
         getgenv().afk_toggle_func(false)
      end
   elseif toggle == false then
      getgenv().afk_spammer_toggled = false
   else
      return 
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

getgenv().device_switcher_input = function(device)
   if device == "PC" then
      getgenv().find_device_changer_remote_event():FireServer("PC")
   elseif device == "Mobile" then
      getgenv().find_device_changer_remote_event():FireServer("Mobile")
   else
      return 
   end
end

getgenv().device_switcher_spammer_toggle_loop = function(toggle)
   if toggle == true then
      getgenv().device_switching_spammer = true
      while getgenv().device_switching_spammer == true do
         task.wait(0)
         getgenv().device_switcher_input("Mobile")
         task.wait(0)
         getgenv().device_switcher_input("PC")
      end
   elseif toggle == false then
      getgenv().device_switching_spammer = false
   else
      return 
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
if not getgenv().found_main_led_panel then
   getgenv().find_led_panel_one()
end
if not getgenv().found_secondary_led_panel then
   getgenv().find_led_panel_two()
end
wait(0.2)
local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
wait(0.1)
getgenv().spam_led_panel_everything = function(toggled)
   if toggled == true then
      if not firesignal then
         getgenv().spamming_led_lights = false
         return getgenv().notify("Error", "'firesignal' is not supported in this executor! You cannot use this!", 10)
      end

      getgenv().spamming_led_lights = true
      while getgenv().spamming_led_lights == true do
      task.wait(0)
         for _, v in ipairs(getgenv().found_main_led_panel:GetDescendants()) do
            if v:IsA("ImageButton") or v:IsA("TextButton") then
               for i,Signal in pairs(Signals) do
                  firesignal(v[Signal])
               end
            end
         end
         task.wait(0)
         for _, v in ipairs(getgenv().found_secondary_led_panel:GetDescendants()) do
            if v:IsA("ImageButton") or v:IsA("TextButton") then
               for i,Signal in pairs(Signals) do
                  firesignal(v[Signal])
               end
            end
         end
      end
   elseif toggled == false then
      getgenv().spamming_led_lights = false
   else
      return 
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
      if getgenv().LocalPlayer:FindFirstChildOfClass("Backpack"):FindFirstChild("Sign") then
         getgenv().LocalPlayer:FindFirstChildOfClass("Backpack"):FindFirstChild("Sign").Parent = getgenv().Character or getgenv().LocalPlayer.Character or game.Players.LocalPlayer.Character
      end

      getgenv().sign_spammer_loop(true)
   else
      getgenv().sign_spammer_loop(false)
   end
end)

if firesignal then
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
