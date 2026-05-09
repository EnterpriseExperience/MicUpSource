if not game:IsLoaded() then
   local msg_instance = Instance.new("Message")
   local hint_instance = Instance.new("Hint")
   msg_instance.Text = "Flames Hub is waiting for the current experience to load fully."
   hint_instance.Text = "Flames Hub is currently waiting for the game to load."

   if typeof(workspace) == "Instance" and workspace.Parent == game then
      msg_instance.Parent = workspace
      hint_instance.Parent = workspace
   end

   game.Loaded:Wait()
   task.wait(0.1)
   msg_instance:Destroy()
   hint_instance:Destroy()
end

local g = getgenv()
local Raw_Version = "V8.9.3"
g.Script_Version = tostring(Raw_Version).."-LifeAdmin"
local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
local localPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
g.colors = g.colors or {
   Color3.fromRGB(255,255,255),
   Color3.fromRGB(128,128,128),
   Color3.fromRGB(0,0,0),
   Color3.fromRGB(0,0,255),
   Color3.fromRGB(0,255,0),
   Color3.fromRGB(0,255,255),
   Color3.fromRGB(255,165,0),
   Color3.fromRGB(139,69,19),
   Color3.fromRGB(255,255,0),
   Color3.fromRGB(50,205,50),
   Color3.fromRGB(255,0,0),
   Color3.fromRGB(255,155,172),
   Color3.fromRGB(128,0,128),
}
g.LocalPlayer = g.LocalPlayer or localPlayer

if not g.GlobalEnvironmentFramework_Initialized then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"))()
	wait(0.1)
	g.GlobalEnvironmentFramework_Initialized = true
end
wait(0.25)
if not g.LifeTogether_Actual_Flames_Hub_Running_Functioning_Currently_On_Client then
   if g.notify then
      g.notify("Success", "Got LocalPlayer: "..tostring(g.LocalPlayer), 5)
   end
end
wait(0.1)
local has_gethui = (typeof(get_hui) == "function") or (typeof(g.get_hui) == "function")
local has_gethidden = (typeof(get_hidden_gui) == "function") or (typeof(g.get_hidden_gui) == "function")
g.found_image_button_for_yt_music_player = g.found_image_button_for_yt_music_player or nil
local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

if not g.yt_music_player_loaded_flames_hub then
   g.yt_music_player_loaded_flames_hub = true
   loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/yt_music_player_backup.lua'))()

   local function try_to_find_music_plr(v)
      if v:IsA("ScreenGui") then
         local imgBtn = v:FindFirstChildOfClass("ImageButton")
         if imgBtn and imgBtn.Image:find("83758613781843") then
            g.found_image_button_for_yt_music_player = v
            local frame = v:FindFirstChildOfClass("Frame")
            if frame then
               frame.Visible = false
               frame.Draggable = true
            end
         end
      end
   end

   for _, v in ipairs(CoreGui:GetChildren()) do try_to_find_music_plr(v) end
   if not g.found_image_button_for_yt_music_player then
      local conn
      conn = CoreGui.ChildAdded:Connect(function(v)
         try_to_find_music_plr(v)
         if g.found_image_button_for_yt_music_player then
            conn:Disconnect()
         end
      end)
   end
end

if not has_gethui and not has_gethidden and not g.roblox_hidden_gui_location then
   local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
   g.roblox_hidden_gui_location = g.roblox_hidden_gui_location or nil

   if not g.roblox_hidden_gui_location then
      for _, v in ipairs(CoreGui:GetChildren()) do
         if v:IsA("ScreenGui") and v.Name == "RobloxGui" then
            g.roblox_hidden_gui_location = v
         end
      end
   end

   g.get_hui = function()
      if g.roblox_hidden_gui_location and g.roblox_hidden_gui_location:IsA("ScreenGui") then
         return g.roblox_hidden_gui_location
      else
         return CoreGui
      end
   end

   g.get_hidden_gui = function()
      if g.roblox_hidden_gui_location and g.roblox_hidden_gui_location:IsA("ScreenGui") then
         return g.roblox_hidden_gui_location
      else
         return CoreGui
      end
   end
end

local verify_file = "is_verified_in_Flames_Hub.txt"
local Insert = table.insert

-- [[ for the Command Handler, because it can check if there is a number in a string (like a command you send). ]] -- 
g.Is_Integer_In_Str = g.Is_Integer_In_Str or function(str)
   if type(str) == "number" then
      return str % 1 == 0
   end

   if type(str) == "string" then
      return str:match("^-?%d+$") ~= nil
   end

   return false
end

-- [[ NEW!: makes it way fucking easier to find attributes. ]] --
g._attr_cache = g._attr_cache or {}
g.attr_cached_fuzzy = g.attr_cached_fuzzy or function(obj, search)
   if not obj or not obj.Parent then return nil end

   local cache = g._attr_cache[obj]

   if cache then
      for name, value in pairs(cache) do
         if name:lower():find(search:lower(), 1, true) then
            return value
         end
      end
      return nil
   end

   local ok, attrs = pcall(function()
      return obj:GetAttributes()
   end)

   if not ok or not attrs then return nil end

   g._attr_cache[obj] = attrs

   for name, value in pairs(attrs) do
      if name:lower():find(search:lower(), 1, true) then
         return value
      end
   end

   return nil
end

g.attr_main_checker = g.attr_main_checker or function(obj, attr, expected) -- really just used for things like the LocalPlayer's attributes tbh, probably just gonna use my fuzzy searcher + cacher though.
   local ok, result = pcall(function()
      return obj:GetAttribute(attr)
   end)
   return ok and result == expected
end

g.isProperty = g.isProperty or function(inst, prop)
	local s, r = pcall(function() return inst[prop] end)
	if not s then return nil end
	return r
end

g.hasProp = g.hasProp or function(inst, prop)
   return inst and isProperty(inst, prop) ~= nil
end

g.setProperty = g.setProperty or function(inst, prop, v)
	local s, _ = pcall(function() inst[prop] = v end)
	return s
end

g.safeSet = g.safeSet or function(inst, prop, val)
   if inst and hasProp(inst, prop) then setProperty(inst, prop, val) end
end

local function isVerified()
   if not isfile then return false end
   if not isfile(verify_file) then return false end
   local content = readfile(verify_file)
   return type(content) == "string" and content:lower():find("true") ~= nil
end

local function setVerified()
   if writefile then
      writefile(verify_file, "true")
   end
end

local function waitForGuiGone()
   local CoreGui = g.CoreGui or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
   while CoreGui:FindFirstChild("MemoryMinigameGUI") do
      task.wait()
   end
end

g.disabled_global_value_correctly = g.disabled_global_value_correctly or function(input)
   local ok, result = pcall(function()
      return input
   end)

   if not ok then
      return true
   end

   return not result
end
wait(0.45)
g.Start_Actual_Flames_Hub_Script = function()
   g.LifeTogether_Actual_Flames_Hub_Running_Functioning_Currently_On_Client = true
   local userid = game.Players.LocalPlayer.UserId
   local http = g.HttpService or cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
   local lib = g.FlamesLibrary
   getgenv().lib = getgenv().FlamesLibrary -- necessary for some reason.
   local lib_attempts = 0
   local lib_max_attempts = 15
   while (not lib or type(lib) ~= "table") and lib_attempts < lib_max_attempts do
      task.wait(0.5)
      lib_attempts = lib_attempts + 1
      lib = g.FlamesLibrary
   end
   if not lib or type(lib) ~= "table" then
      g.notify("Error", "FlamesLibrary failed to load, title system cannot continue.", 10)
      return
   end
   local function mask_unique_id(id)
      if not id then return nil end
      local parts = string.split(id, "-")
      local out = {}

      for i = 1, #parts do
         if i <= 2 then
            out[i] = parts[i]
         else
            out[i] = string.rep("*", #parts[i])
         end
      end

      return table.concat(out, "-")
   end

   function create_flames_hub_unique_id(target_user_id)
      local file_name = "flames_hub_unique_ID.txt"

      if userid ~= target_user_id then
         return nil
      end

      if isfile and isfile(file_name) then
         local id = readfile and readfile(file_name)
         if id and id ~= "" then
            return id
         end
      end

      local new_id = http:GenerateGUID(false)
      pcall(function() writefile(file_name, new_id) end)

      return new_id
   end

   function get_flames_hub_unique_id()
      local file_name = "flames_hub_unique_ID.txt"

      if isfile and isfile(file_name) then
         local id = readfile and readfile(file_name)
         if id and id ~= "" then
            return id
         end
      end

      return nil
   end

   function create_masked_flames_hub_unique_server_id(target_user_id)
      local raw = create_flames_hub_unique_id(target_user_id)
      return mask_unique_id(raw)
   end

   function get_masked_flames_hub_unique_id()
      local raw = get_flames_hub_unique_id()
      return mask_unique_id(raw)
   end

   local Chat = (cloneref and cloneref(game:GetService("Chat"))) or game:GetService("Chat")
   local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
   local me = Players.LocalPlayer or game:GetService("Players").LocalPlayer
   local TextChatService = cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")
   local ws_connect = (syn and syn.websocket and syn.websocket.connect) or (WebSocket and WebSocket.connect) or (websocket and websocket.connect)
   local http_req = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)

   g.will_tag = g.will_tag or function(text)
      local filtered
      local success, response = pcall(function()
         filtered = Chat:FilterStringForBroadcast(text, me)
      end)
      if not success then print(tostring(response)) return true end
      return filtered ~= text
   end

   --[[local HttpService = g.HttpService or cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
   if not g.FlamesHub_WebSocket_Server_Already_Initialized_For_Internal_Use_Life_Together_RP then
      g.FlamesHub_WebSocket_Server_Already_Initialized_For_Internal_Use_Life_Together_RP = true
      g.ws_main_reactor_connector = g.ws_main_reactor_connector or nil
      g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set = g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set or false
      local function connect_to_public_server()
         if g.FlamesHub_Reconnecting then return end
         g.FlamesHub_Reconnecting = true
         local ok, result
         local max_retries = 1

         for attempt = 1, max_retries do
            ok, result = pcall(function()
               g.ws_main_reactor_connector = ws_connect("ws://WebSocket_IP_Here:Port_You_Set_On_Your_Server")
            end)

            if ok then break end
            if getgenv().notify then getgenv().notify("Warning", "Flames Hub | Server Connection attempt: "..tostring(attempt).."/"..tostring(max_retries).." failed, re-trying...", 1.5) end
            warn(("FlamesHub: Connection attempt %d/%d failed: %s"):format(attempt, max_retries, tostring(result)))

            if attempt < max_retries then
               g.FlamesHub_Retry_Delay = math.min((g.FlamesHub_Retry_Delay or 0.15) * 2, 30)
               task.wait(g.FlamesHub_Retry_Delay)
            end
         end

         if not ok then
            warn("FlamesHub: All " .. max_retries .. " connection attempts failed. Giving up.")
            g.FlamesHub_Reconnecting = false
            return
         end

         g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set = true
         g.FlamesHub_Retry_Delay = 0.15
         g.FlamesHub_Reconnecting = false

         pcall(function()
            g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
               type  = "auth",
               token = "Your_Auth_Key(Setup_On_Server)",
               user  = game.Players.LocalPlayer.Name
            }))

            g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
               type   = "join",
               server = game.JobId,
               user   = game.Players.LocalPlayer.Name
            }))
         end)

         if g.ws_main_reactor_connector then
            g.ws_main_reactor_connector.OnClose:Connect(function()
               g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set = false
               g.FlamesHub_Retry_Delay = math.min((g.FlamesHub_Retry_Delay or 0.15) * 2, 30)
               task.wait(g.FlamesHub_Retry_Delay)
               --connect_to_public_server() -- you can uncomment it out once you have your WebSocket server setup.
               print("Gave up.")
            end)
         end
      end

      connect_to_public_server()

      g.Send_Main_Log = function(data)
         if not g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set then return end
         if not g.ws_main_reactor_connector then return end
         local join_command = "```game:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. game.PlaceId .. ", '" .. game.JobId .. "', game.Players.LocalPlayer)```"
         g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
            type = "post",
            hook = "warn",
            user = game.Players.LocalPlayer.Name,
            text = "embed",
            embed = {
               content = "[log]: " .. os.date("%Y-%m-%d %H:%M:%S"),
               embeds = {{
                  title = "Logged Execution:",
                  description = "An execution was caught from the Admin.",
                  color = 3091754,
                  fields = {
                     { name = "UserName",        value = tostring(game.Players.LocalPlayer.Name),                              inline = true  },
                     { name = "DisplayName",      value = tostring(game.Players.LocalPlayer.DisplayName or ""),                inline = true  },
                     { name = "UserID",           value = tostring(game.Players.LocalPlayer.UserId),                          inline = true  },
                     { name = "Script Version",   value = tostring(g.Script_Version or "?"),                          inline = true  },
                     { name = "Packet",           value = tostring(data.packet or "?"),                                       inline = false },
                     { name = "Place-ID",         value = tostring(game.PlaceId),                                             inline = false },
                     { name = "Job-ID",           value = tostring(game.JobId),                                               inline = false },
                     { name = "Executor Name",    value = tostring(data.executor or "?"),                                     inline = false },
                     { name = "Device",           value = tostring(data.device or "?"),                                       inline = false },
                     { name = "Flames UUID",      value = tostring(data.uuid or "?"),                                         inline = false },
                     { name = "HWID",             value = tostring(data.hwid or "?"),                                         inline = false },
                     { name = "Join Server",      value = join_command,                                                       inline = false },
                     { name = "Player Count",     value = #g.Players:GetPlayers() .. "/" .. g.Players.MaxPlayers, inline = false },
                     { name = "Current Players",  value = tostring(data.current_players or "?"),                              inline = false },
                     { name = "Full Server?",     value = g.is_server_full() and "Yes" or "No",                      inline = false },
                  },
                  timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
               }}
            }
         }))
      end

      g.Send_Main_Alert = function(sender, message)
         if not g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set then return end
         if not g.ws_main_reactor_connector then return end
         g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
            type = "post",
            hook = "alert",
            user = game.Players.LocalPlayer.Name,
            text = "embed",
            embed = {
               embeds = {{
                  title = "Chat Logged:",
                  description = "A chat message was logged from the Life Together Admin Commands script.",
                  color = 10181046,
                  fields = {
                     { name = "Sender UserName", value = tostring(sender.Name),              inline = true  },
                     { name = "DisplayName",     value = tostring(sender.DisplayName or ""), inline = true  },
                     { name = "UserID",          value = tostring(sender.UserId),            inline = true  },
                     { name = "Message",         value = tostring(message or ""),            inline = false },
                     { name = "Time (UTC)",      value = os.date("!%Y-%m-%d %H:%M:%S"),     inline = true  },
                     { name = "Script Version",  value = tostring(g.Script_Version), inline = true },
                  }
               }}
            }
         }))
      end

      g.Send_Main_Warn = function(sender, message)
         if not g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set then return end
         if not g.ws_main_reactor_connector then return end
         g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
            type = "post",
            hook = "issues",
            user = game.Players.LocalPlayer.Name,
            text = "embed",
            embed = {
               embeds = {{
                  title = "Flames Server | Chat Log:",
                  description = "A message was logged from the Flames Hub | WebSocket Server.",
                  color = 10181046,
                  fields = {
                     { name = "Sender UserName", value = tostring(game.Players.LocalPlayer.Name),              inline = true  },
                     { name = "DisplayName",     value = tostring(game.Players.LocalPlayer.DisplayName or ""), inline = true  },
                     { name = "UserID",          value = tostring(game.Players.LocalPlayer.UserId),            inline = true  },
                     { name = "Message",         value = tostring(message or ""),            inline = false },
                     { name = "Time (UTC)",      value = os.date("!%Y-%m-%d %H:%M:%S"),     inline = true  },
                     { name = "Script Version",  value = tostring(g.Script_Version), inline = true },
                     { name = "Server ID",       value = tostring(game.JobId),              inline = true  },
                  }
               }}
            }
         }))
      end

      g.Send_Main_Axer_Chat = function(sender, message)
         if not g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set then return end
         if not g.ws_main_reactor_connector then return end
         g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
            type = "post",
            hook = "axerchat",
            user = game.Players.LocalPlayer.Name,
            text = "embed",
            embed = {
               embeds = {{
                  title = "Axer Chat:",
                  description = "A message was sent from the Axer Chat script.",
                  color = 10181046,
                  fields = {
                     { name = "Sender UserName", value = tostring(game.Players.LocalPlayer.Name),              inline = true  },
                     { name = "DisplayName",     value = tostring(game.Players.LocalPlayer.DisplayName or ""), inline = true  },
                     { name = "UserID",          value = tostring(game.Players.LocalPlayer.UserId),            inline = true  },
                     { name = "Message",         value = tostring(message or ""),            inline = false },
                     { name = "Time (UTC)",      value = os.date("!%Y-%m-%d %H:%M:%S"),     inline = true  },
                     { name = "Script Version",  value = tostring(g.Script_Version), inline = true },
                     { name = "Server ID",       value = tostring(game.JobId),              inline = true  },
                  }
               }}
            }
         }))
      end

      g.Send_Main_Issues = function(text)
         if not g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set then return end
         if not g.ws_main_reactor_connector then return end
         g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
            type = "post",
            hook = "warnings",
            user = game.Players.LocalPlayer.Name,
            text = "embed",
            embed = {
               content = tostring(text or "")
            }
         }))
      end

      g.Send_Main_Warns = function(sender, command)
         if not g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set then return end
         if not g.ws_main_reactor_connector then return end
         g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
            type = "post",
            hook = "warns",
            user = game.Players.LocalPlayer.Name,
            text = "embed",
            embed = {
               embeds = {{
                  title = "Command Logged:",
                  description = "A Command was executed from the Life Together Admin Commands script.",
                  color = 10181046,
                  fields = {
                     { name = "Sender UserName", value = tostring(game.Players.LocalPlayer.Name),              inline = true  },
                     { name = "DisplayName",     value = tostring(game.Players.LocalPlayer.DisplayName or ""), inline = true  },
                     { name = "UserID",          value = tostring(game.Players.LocalPlayer.UserId),            inline = true  },
                     { name = "Command",         value = tostring(command or ""),            inline = false },
                     { name = "Time (UTC)",      value = os.date("!%Y-%m-%d %H:%M:%S"),     inline = true  },
                     { name = "Script Version",  value = tostring(g.Script_Version), inline = true },
                  }
               }}
            }
         }))
      end

      g.Send_Main_Feedback = function(player, message, feedback_type)
         if not g.Connected_To_Current_Flames_Hub_WebSocket_Server_Already_Set then return end
         if not g.ws_main_reactor_connector then return end
         local type_colors = {
            feedback    = 4360181,
            issue       = 13158400,
            report      = 10027008,
            bug         = 9109504,
         }

         g.ws_main_reactor_connector:Send(HttpService:JSONEncode({
            type = "post",
            hook = "feedback",
            user = game.Players.LocalPlayer.Name,
            text = "embed",
            embed = {
               embeds = {{
                  title = feedback_type:gsub("^%l", string.upper),
                  description = "A message was received from the script.",
                  color = type_colors[feedback_type] or 4360181,
                  fields = {
                     { name = "Type",           value = tostring(feedback_type:gsub("^%l", string.upper)), inline = true  },
                     { name = "UserName",       value = tostring(player.Name),                             inline = true  },
                     { name = "DisplayName",    value = tostring(player.DisplayName or ""),                inline = true  },
                     { name = "UserID",         value = tostring(player.UserId),                           inline = false },
                     { name = "Message",        value = tostring(message or ""),                           inline = false },
                     { name = "Time (UTC)",     value = os.date("!%Y-%m-%d %H:%M:%S"),                    inline = true  },
                     { name = "Script Version", value = tostring(g.Script_Version),     inline = true  },
                     { name = "Job-ID",         value = tostring(game.JobId),                             inline = true  },
                     { name = "Place-ID",       value = tostring(game.PlaceId),                           inline = false },
                     { name = "Executor",       value = tostring(identifyexecutor and identifyexecutor() or "Unknown"), inline = true },
                  }
               }}
            }
         }))
      end
   end--]]

   --[[if not g.FlamesLibrary.is_alive("AxerChat_Finder") then
      g.FlamesLibrary.spawn("AxerChat_Finder", "spawn", function()
         local Lib = g.FlamesLibrary
         local Sent_Messages = {}
         local Sent_Messages_Count = 0
         local MAX_SENT = 500

         while not g.Axer_Chat_Screen_Gui_Located do
            for _, Gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
               local Name = Gui.Name:lower()
               if Name:find("axer") and Name:find("chat") then
                  local Success, Result = pcall(function()
                     return Gui.AxerMain.ChatPanel.ScrollingFrame
                  end)
                  if Success and Result then
                     g.Axer_Chat_Screen_Gui_Located = Gui
                     g.Axer_Chat_Scrolling_Frame_Located = Result
                     break
                  end
               end
            end
            if not g.Axer_Chat_Screen_Gui_Located then
               Lib.wait(0.25)
            end
         end

         local Scrolling_Frame = g.Axer_Chat_Scrolling_Frame_Located
         local Local_Player = game.Players.LocalPlayer
         g.FlamesLibrary.connect("AxerChat_MessageListener", Scrolling_Frame.ChildAdded:Connect(function(Child)
            if not Child:IsA("TextButton") then return end
            if Child.Text == "Button" or Child.Text == "" then Child:GetPropertyChangedSignal("Text"):Wait() end
            local Raw_Text = Child.Text
            local Bold_Name, Message = Raw_Text:match("^(.-):%s*(.+)$")
            if not Bold_Name then return end
            Bold_Name = Bold_Name:gsub("<[^>]+>", ""):match("^%s*(.-)%s*$")
            
            if Bold_Name:lower() ~= Local_Player.DisplayName:lower() and Bold_Name:lower() ~= Local_Player.Name:lower() then return end
            if not Message then return warn("Message not found on: "..tostring(Raw_Text)) end

            local Unique_Key = Raw_Text .. "_" .. tostring(Child)
            if Sent_Messages[Unique_Key] then return warn("UniqueKey already sent") end
            if Sent_Messages_Count > MAX_SENT then
               Sent_Messages = {}
               Sent_Messages_Count = 0
            end
            Sent_Messages[Unique_Key] = true
            Sent_Messages_Count += 1

            local ok, response = pcall(function()
               g.Send_Main_Axer_Chat(Local_Player.Name, Message)
            end)

            if ok then
               warn("Memory tracking is currently disabled. Please use Stats.MemoryTrackingEnabled to check before calling this function.")
            else
               warn("Memory[1] tracking is currently disabled. Please use Stats.MemoryTrackingEnabled to check before calling this function.")
            end
         end))
      end)
   end--]]

   g.check_anti_stealer = function(target_name, callback)
      local lib = g.FlamesLibrary
      local HttpService = g.HttpService or cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
      local resolved = false

      lib.spawn("anti_stealer_check_timeout", "delay", 5, function()
         if not resolved then
            resolved = true
            callback(false, true)
         end
      end)

      if g.ws_main_reactor_connector then
         lib.connect("anti_stealer_check_result", g.ws_main_reactor_connector.OnMessage:Connect(function(raw)
            local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
            if not ok or type(data) ~= "table" then return end
            if data.type ~= "anti_stealer_check_result" then return end
            if data.target ~= target_name then return end
            if not resolved then
               resolved = true
               lib.disconnect("anti_stealer_check_timeout")
               lib.disconnect("anti_stealer_check_result")
               callback(data.protected, false)
            end
         end))

         g.ws_main_reactor_connector:Send(HttpService:JSONEncode{
            type = "check_anti_stealer",
            target = target_name
         })
      end
   end

   -- [[ causing many issues, as you can see. ]] --
   --[[if not g.AlreadySpoofed_Incoming_Message_Watcher_In_Flames_Hub_Anti_Tag_System then
      g.AlreadySpoofed_Incoming_Message_Watcher_In_Flames_Hub_Anti_Tag_System = true
      if g.notify then
         g.notify("Success", "Flames Hub | Anti-HashTag V2 — has been initialized!", 15)
      end

      TextChatService.OnIncomingMessage = function(message)
         local props = Instance.new("TextChatMessageProperties")
         local textsource = message.TextSource

         if textsource then
            local player = Players:GetPlayerByUserId(textsource.UserId)
            if player == me then
               if will_tag(message.Text) then
                  if g.notify then
                     g.notify("Warning", "Message blocked by: Flames Hub | Anti-Hashtag V2 — it would have hashtagged!", 10)
                  end
                  error("Saved from hashtags!")
               end
            end
         end

         props.Text = message.Text
         return props
      end
   end--]]
   --[[local FIREBASE_PROJECT = "user-outfits-backup"
   local FIREBASE_KEY = "AIzaSyDpxaTpjNQVDoeXp9IyleGU7ErIwBXgaDY"
   g.coins_firestore_url = function(username) return "https://firestore.googleapis.com/v1/projects/" .. FIREBASE_PROJECT .. "/databases/(default)/documents/coins/" .. username .. "?key=" .. FIREBASE_KEY end
   g.get_coins_firebase = function(username, callback)
      local ok, result = pcall(function()
         return http_req({
            Url = g.coins_firestore_url(username),
            Method = "GET",
            Headers = {["Content-Type"] = "application/json"}
         })
      end)
      if not ok or not result or result.StatusCode ~= 200 then
         callback(0)
         return
      end
      local ok2, data = pcall(function() return HttpService:JSONDecode(result.Body) end)
      if not ok2 or not data or not data.fields or not data.fields.coins then
         callback(0)
         return
      end
      local coins = tonumber(data.fields.coins.integerValue) or 0
      callback(coins)
   end

   g.set_coins_firebase = function(username, coins, callback)
      local body = HttpService:JSONEncode({
         fields = {
            coins = {integerValue = math.floor(coins)},
            last_updated = {integerValue = os.time()}
         }
      })
      local ok, result = pcall(function()
         return http_req({
            Url = g.coins_firestore_url(username),
            Method = "PATCH",
            Headers = {["Content-Type"] = "application/json"},
            Body = body
         })
      end)
      if callback then callback(ok and result and result.StatusCode == 200) end
   end

   g.add_coins_firebase = function(username, amount, callback)
      g.get_coins_firebase(username, function(current)
         g.set_coins_firebase(username, current + amount, callback)
      end)
   end

   g.subtract_coins_firebase = function(username, amount, callback)
      g.get_coins_firebase(username, function(current)
         local new_amount = math.max(0, current - amount)
         g.set_coins_firebase(username, new_amount, callback)
      end)
   end

   g.spend_coins_firebase = function(username, amount, callback)
      g.get_coins_firebase(username, function(current)
         if current < amount then
            if callback then callback(false, current) end
            return
         end
         local new_amount = current - amount
         g.set_coins_firebase(username, new_amount, function(success)
            if callback then callback(success, new_amount) end
         end)
      end)
   end
   wait(0.25)
   g.get_coins_leaderboard_firebase = function(limit, callback)
      local ok, result = pcall(function()
         return http_req({
            Url = "https://firestore.googleapis.com/v1/projects/" .. FIREBASE_PROJECT .. "/databases/(default)/documents/coins?key=" .. FIREBASE_KEY .. "&pageSize=300",
            Method = "GET",
            Headers = {["Content-Type"] = "application/json"}
         })
      end)

      if not ok or not result or result.StatusCode ~= 200 then
         callback(nil, true)
         return
      end

      local ok2, data = pcall(function() return HttpService:JSONDecode(result.Body) end)
      if not ok2 or not data or not data.documents then
         callback({}, false)
         return
      end

      local board = {}
      for _, doc in ipairs(data.documents) do
         local username = doc.name:match("/([^/]+)$")
         local coins = 0
         if doc.fields and doc.fields.coins then
            coins = tonumber(doc.fields.coins.integerValue or doc.fields.coins.doubleValue) or 0
         end
         if coins > 0 then
            table.insert(board, {username = username, coins = coins})
         end
      end

      table.sort(board, function(a, b) return a.coins > b.coins end)

      local trimmed = {}
      for i = 1, math.min(limit or 10, #board) do
         table.insert(trimmed, board[i])
      end

      callback(trimmed, false)
   end

   g.leaderboard_cache = g.leaderboard_cache or nil
   g.leaderboard_last_request = g.leaderboard_last_request or 0
   g.get_coins_leaderboard = function(limit, callback)
      local now = tick()
      local cached_count = g.leaderboard_cache and #g.leaderboard_cache or 0
      if g.leaderboard_cache and now - g.leaderboard_last_request < 300 then
         callback(g.leaderboard_cache, false)
         return
      end
      g.leaderboard_last_request = now
      g.get_coins_leaderboard_firebase(limit, function(board, timed_out)
         if not timed_out and board then
            g.leaderboard_cache = board
         end
         callback(board, timed_out)
      end)
   end

   g.LEADERBOARD_POSITION = g.LEADERBOARD_POSITION or Vector3.new(30.1766968, 10.070322, 7.32687426)
   g.LEADERBOARD_REFRESH_RATE = g.LEADERBOARD_REFRESH_RATE or 120
   g.build_leaderboard = function()
      local existing = workspace:FindFirstChild("LEADER_BOARD_Flames_Hub")
      if existing then existing:Destroy() end
      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      local Part = Instance.new("Part")
      Part.Name = "LEADER_BOARD_Flames_Hub"
      Part.Size = Vector3.new(6, 8, 0.1)
      Part.CFrame = CFrame.new(g.LEADERBOARD_POSITION)
      Part.Rotation = Vector3.new(180, 46.5, 180)
      Part.Anchored = true
      Part.CanCollide = false
      Part.Material = Enum.Material.SmoothPlastic
      Part.Color = Color3.fromRGB(20, 20, 20)
      Part.Parent = workspace

      local Surface = Instance.new("SurfaceGui")
      Surface.Face = Enum.NormalId.Front
      Surface.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
      Surface.PixelsPerStud = 50
      Surface.AlwaysOnTop = true
      Surface.Adornee = Part
      Surface.Parent = CoreGui

      local Header = Instance.new("TextLabel")
      Header.Size = UDim2.new(1, 0, 0, 50)
      Header.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
      Header.TextColor3 = Color3.fromRGB(255, 215, 0)
      Header.Text = "Flames Leaderboard"
      Header.TextScaled = true
      Header.Font = Enum.Font.GothamBold
      Header.BorderSizePixel = 0
      Header.Parent = Surface

      local List = Instance.new("ScrollingFrame")
      List.Size = UDim2.new(1, 0, 1, -50)
      List.Position = UDim2.new(0, 0, 0, 50)
      List.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
      List.ScrollBarThickness = 4
      List.CanvasSize = UDim2.new(0, 0, 0, 0)
      List.AutomaticCanvasSize = Enum.AutomaticSize.Y
      List.BorderSizePixel = 0
      List.Parent = Surface

      local Layout = Instance.new("UIListLayout")
      Layout.SortOrder = Enum.SortOrder.LayoutOrder
      Layout.Parent = List

      return Part, List
   end

   local function populate_list(List)
      g.get_coins_leaderboard(30, function(board, timed_out)
         if timed_out or not board then return end
         for _, Child in List:GetChildren() do
            if Child:IsA("Frame") then Child:Destroy() end
         end

         for Rank, Entry in ipairs(board) do
            local Row = Instance.new("Frame")
            Row.Size = UDim2.new(1, 0, 0, 36)
            Row.BackgroundColor3 = Rank % 2 == 0 and Color3.fromRGB(28, 28, 28) or Color3.fromRGB(38, 38, 38)
            Row.BorderSizePixel = 0
            Row.LayoutOrder = Rank
            Row.Parent = List

            local Rank_Label = Instance.new("TextLabel")
            Rank_Label.Size = UDim2.new(0.12, 0, 1, 0)
            Rank_Label.BackgroundTransparency = 1
            Rank_Label.TextColor3 = Rank <= 3 and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(180, 180, 180)
            Rank_Label.Text = "#" .. Rank
            Rank_Label.TextScaled = true
            Rank_Label.Font = Enum.Font.GothamBold
            Rank_Label.Parent = Row

            local Name_Label = Instance.new("TextLabel")
            Name_Label.Size = UDim2.new(0.6, 0, 1, 0)
            Name_Label.Position = UDim2.new(0.12, 0, 0, 0)
            Name_Label.BackgroundTransparency = 1
            Name_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Name_Label.Text = Entry.username
            Name_Label.TextScaled = true
            Name_Label.Font = Enum.Font.Gotham
            Name_Label.TextXAlignment = Enum.TextXAlignment.Left
            Name_Label.Parent = Row

            local Coins_Label = Instance.new("TextLabel")
            Coins_Label.Size = UDim2.new(0.28, 0, 1, 0)
            Coins_Label.Position = UDim2.new(0.72, 0, 0, 0)
            Coins_Label.BackgroundTransparency = 1
            Coins_Label.TextColor3 = Color3.fromRGB(255, 215, 0)
            Coins_Label.Text = tostring(Entry.coins)
            Coins_Label.TextScaled = true
            Coins_Label.Font = Enum.Font.Code
            Coins_Label.Parent = Row
         end
      end)
   end

   g.Active_Part = g.Active_Part or nil
   g.Active_List = g.Active_List or nil
   g.setup_leaderboard_from_leaderstats = function()
      if g.Active_Part and g.Active_Part.Parent then g.Active_Part:Destroy() end
      local part, list = g.build_leaderboard()
      if not part or not list then return end
      g.Active_Part = part
      g.Active_List = list
      populate_list(g.Active_List)
      local Lib = g.FlamesLibrary
      Lib.connect("leaderboard_ancestry", g.Active_Part.AncestryChanged:Connect(function(_, Parent)
         if Parent == nil then
            Lib.disconnect("leaderboard_refresh")
            Lib.spawn("leaderboard_rebuild", "spawn", g.setup_leaderboard_from_leaderstats)
         end
      end))

      Lib.connect("leaderboard_refresh", RunService.Heartbeat:Connect((function()
         local Last_Refresh = os.clock()
         return function()
            if os.clock() - Last_Refresh >= g.LEADERBOARD_REFRESH_RATE then
               Last_Refresh = os.clock()
               populate_list(g.Active_List)
            end
         end
      end)()))
   end

   g.sync_leaderstats_if_exists = function(player)
      g.get_coins_firebase(player.Name, function(coins)
         if coins == 0 then return end
         local leaderstats = player:FindFirstChild("leaderstats")
         if not leaderstats then
            leaderstats = Instance.new("Folder")
            leaderstats.Name = "leaderstats"
            leaderstats.Parent = player
         end

         local stat = leaderstats:FindFirstChild("Coins")
         if not stat then
            stat = Instance.new("IntValue")
            stat.Name = "Coins"
            stat.Parent = leaderstats
         end

         stat.Value = coins
      end)
   end

   g.get_coins_firebase(LocalPlayer.Name, function(coins)
      if coins == 0 then
         g.set_coins_firebase(LocalPlayer.Name, 5, function()
            g.sync_leaderstats_if_exists(LocalPlayer)
         end)
      else
         g.sync_leaderstats_if_exists(LocalPlayer)
      end
   end)

   for _, player in ipairs(Players:GetPlayers()) do
      getgenv().FlamesLibrary.spawn("coins_sync_" .. player.Name, "spawn", function()
         g.sync_leaderstats_if_exists(player)
      end)
   end

   getgenv().FlamesLibrary.connect("coins_player_added", Players.PlayerAdded:Connect(function(player)
      getgenv().FlamesLibrary.spawn("coins_sync_" .. player.Name, "spawn", function()
         g.sync_leaderstats_if_exists(player)
      end)
   end))

   getgenv().FlamesLibrary.spawn("coins_sync_loop", "spawn", function()
      while true do
         task.wait(45)
         for _, player in ipairs(Players:GetPlayers()) do
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats and leaderstats:FindFirstChild("Coins") then
               g.get_coins_firebase(player.Name, function(coins)
                  local stat = leaderstats:FindFirstChild("Coins")
                  if stat then stat.Value = coins end
               end)
            end
         end
      end
   end)
   if getgenv().FlamesLibrary then getgenv().FlamesLibrary.spawn("leaderboard_init", "spawn", g.setup_leaderboard_from_leaderstats) end
   getgenv().FlamesLibrary.spawn("coins_passive_income", "spawn", function()
      while true do
         task.wait(120)
         g.add_coins_firebase(LocalPlayer.Name, 3, function(success)
            getgenv().notify("Success", "You've been awarded +3 coins for using Flames Hub!", 3)
            pcall(function() TextChatService:FindFirstChild("RBXGeneral", true):DisplaySystemMessage('Make sure to join the Flames Hub Discord!: https://discord.gg/MTYKxQfpNJ') end)
         end)
      end
   end)--]]

   g.Memory_Mini_Game_GUI = function()
      local g = getgenv()
      local Players = cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      local GRID_SIZE = 5
      local TILE_COUNT = GRID_SIZE * GRID_SIZE
      local SHOW_TIME = 10
      local MAX_MISTAKES = 3
      local GREEN = Color3.fromRGB(0, 255, 0)
      local BLUE = Color3.fromRGB(30, 70, 120)
      local DARK = Color3.fromRGB(20, 20, 20)
      local WHITE = Color3.fromRGB(240, 240, 240)
      local RED = Color3.fromRGB(150, 0, 0)
      if g.memory_mini_game_cooldown and tick() - g.memory_mini_game_cooldown < 30 then
         local remaining = math.ceil(30 - (tick() - g.memory_mini_game_cooldown))
         if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
         return
      end

      if CoreGui:FindFirstChild("MemoryMinigameGUI") then CoreGui.MemoryMinigameGUI:Destroy() end
      local gui = Instance.new("ScreenGui")
      gui.Name = "MemoryMinigameGUI"
      gui.IgnoreGuiInset = true
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local frame = Instance.new("Frame")
      frame.AnchorPoint = Vector2.new(0.5, 0.5)
      frame.Position = UDim2.fromScale(0.5, 0.5)
      frame.Size = UDim2.fromScale(0.85, 0.85)
      frame.BackgroundColor3 = DARK
      frame.Parent = gui
      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

      local aspect = Instance.new("UIAspectRatioConstraint")
      aspect.AspectRatio = 1
      aspect.Parent = frame

      local size_limit = Instance.new("UISizeConstraint")
      size_limit.MaxSize = Vector2.new(520, 520)
      size_limit.Parent = frame

      local padding = Instance.new("UIPadding")
      padding.PaddingTop = UDim.new(0.08, 0)
      padding.PaddingBottom = UDim.new(0.04, 0)
      padding.PaddingLeft = UDim.new(0.04, 0)
      padding.PaddingRight = UDim.new(0.04, 0)
      padding.Parent = frame

      local cancel = Instance.new("TextButton")
      cancel.Size = UDim2.fromScale(0.18, 0.08)
      cancel.Position = UDim2.fromScale(0.99, 0.02)
      cancel.AnchorPoint = Vector2.new(1, 0)
      cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      cancel.Text = "Cancel"
      cancel.TextScaled = true
      cancel.Font = Enum.Font.GothamBold
      cancel.TextColor3 = WHITE
      cancel.Parent = frame
      Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 12)

      local grid_frame = Instance.new("Frame")
      grid_frame.BackgroundTransparency = 1
      grid_frame.Size = UDim2.fromScale(1, 0.88)
      grid_frame.Position = UDim2.fromScale(0, 0.12)
      grid_frame.Parent = frame

      local grid = Instance.new("UIGridLayout")
      grid.CellPadding = UDim2.fromScale(0.03, 0.03)
      grid.CellSize = UDim2.fromScale(1 / GRID_SIZE - 0.03, 1 / GRID_SIZE - 0.03)
      grid.Parent = grid_frame

      local tiles = {}
      local pattern = {}
      local found = {}
      local mistakes = 0
      local input_locked = true
      local function cleanup() if gui then gui:Destroy() end end
      cancel.MouseButton1Click:Connect(function()
         if g.notify then g.notify("Info", "Mini-game cancelled.", 3) end
         cleanup()
      end)

      for i = 1, TILE_COUNT do
         local btn = Instance.new("TextButton")
         btn.Text = ""
         btn.BackgroundColor3 = BLUE
         btn.AutoButtonColor = false
         btn.Parent = grid_frame
         Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
         tiles[i] = btn
      end

      local function generate_pattern()
         local count = math.random(6, 9)
         local used = {}
         while #pattern < count do
            local pick = math.random(1, TILE_COUNT)
            if not used[pick] then
               used[pick] = true
               table.insert(pattern, pick)
            end
         end
      end

      local function check_win()
         for _, index in ipairs(pattern) do
            if not found[index] then return end
         end
         task.delay(0.02, function()
            g.memory_mini_game_cooldown = tick()
            if g.notify then
               g.notify("Success", "You completed the memory mini-game.", 5)
            end
            cleanup()
         end)
      end

      local function show_pattern()
         for _, index in ipairs(pattern) do
            tiles[index].BackgroundColor3 = GREEN
         end
      end

      local function hide_pattern()
         for i, btn in ipairs(tiles) do
            if not found[i] then
               btn.BackgroundColor3 = BLUE
            end
         end
         input_locked = false
      end

      local function fail()
         if g.notify then
            g.notify("Error", "You failed the memory mini-game.", 5)
         end
         cleanup()
      end

      local function on_tile_clicked(index)
         if input_locked then return end
         if found[index] then return end
         if table.find(pattern, index) then
            found[index] = true
            tiles[index].BackgroundColor3 = GREEN
            check_win()
         else
            mistakes = mistakes + 1
            tiles[index].BackgroundColor3 = RED
            if mistakes >= MAX_MISTAKES then
               fail()
            end
         end
      end

      for i, btn in ipairs(tiles) do
         btn.MouseButton1Click:Connect(function()
            on_tile_clicked(i)
         end)
      end

      generate_pattern()
      show_pattern()
      task.delay(SHOW_TIME, hide_pattern)
   end

   g.reaction_time_minigame = function()
      g.timing_game = g.timing_game or {}
      local tg = g.timing_game
      if tg.renderConn then tg.renderConn:Disconnect() end
      if tg.gui then tg.gui:Destroy() end
      if g.reaction_minigame_cooldown and tick() - g.reaction_minigame_cooldown < 30 then
         local remaining = math.ceil(30 - (tick() - g.reaction_minigame_cooldown))
         if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
         return
      end

      local MAX_WINS = 5
      local MAX_MISSES = 3
      local PURPLE = Color3.fromRGB(170, 85, 255)
      local DARK = Color3.fromRGB(18, 18, 18)
      local WHITE = Color3.fromRGB(240, 240, 240)
      local RED = Color3.fromRGB(200, 60, 60)
      tg.wins = 0
      tg.misses = 0
      tg.speed = 0.6

      local gui = Instance.new("ScreenGui")
      gui.Name = "ReactionTimeMinigame"
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

      local ui_scale = Instance.new("UIScale")
      ui_scale.Parent = frame

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
      cancel.Size = UDim2.new(0.0399999991, 0, 0.219999999, 0)
      cancel.Position = UDim2.new(1, 0, 0.00100000005, 0)
      cancel.AnchorPoint = Vector2.new(1, 0)
      cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      cancel.Text = "X"
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
         if tg.renderConn then tg.renderConn:Disconnect() end
         if tg.gui then tg.gui:Destroy() end
      end

      local function win()
         g.reaction_minigame_cooldown = tick()
         if g.notify then
            g.notify("Success", "You've won the mini-game.", 5)
         end
         task.delay(0.1, cleanup)
      end

      local function fail(msg)
         if g.notify then
            g.notify("Error", msg or "You failed the mini-game.", 5)
         end
         task.delay(0.1, cleanup)
      end

      cancel.MouseButton1Click:Connect(function()
         if g.notify then g.notify("Info", "Mini-game cancelled.", 3) end
         cleanup()
      end)

      local function new_target()
         target.Position = UDim2.fromScale(math.random(10, 78) / 100, 0)
      end

      new_target()

      local dir = 1
      local pos = 0

      tg.renderConn = RunService.RenderStepped:Connect(function(dt)
         pos = pos + dt * tg.speed * dir
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
         local a_min = arrow.Position.X.Scale
         local a_max = a_min + arrow.Size.X.Scale
         local t_min = target.Position.X.Scale
         local t_max = t_min + target.Size.X.Scale
         local overlap = math.min(a_max, t_max) - math.max(a_min, t_min)

         if overlap > 0 then
            local center_dist = math.abs((a_min + a_max) / 2 - (t_min + t_max) / 2)
            if center_dist < 0.02 then
               flash("PERFECT", Color3.fromRGB(180, 255, 255))
            else
               flash("GOOD", PURPLE)
            end
            tg.wins = tg.wins + 1
            tg.speed = tg.speed + 0.15
            new_target()
            if tg.wins >= MAX_WINS then
               win()
            end
         else
            tg.misses = tg.misses + 1
            flash("BAD", RED)
            if tg.misses >= MAX_MISSES then
               fail()
            end
         end
      end)
   end

   g.keypad_minigame = function()
      if g.keypad_minigame_cooldown and tick() - g.keypad_minigame_cooldown < 25 then
         local remaining = math.ceil(25 - (tick() - g.keypad_minigame_cooldown))
         if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
         return
      end

      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      local DARK = Color3.fromRGB(18, 18, 18)
      local WHITE = Color3.fromRGB(240, 240, 240)
      local GREEN = Color3.fromRGB(0, 220, 100)
      local RED = Color3.fromRGB(200, 60, 60)
      local YELLOW = Color3.fromRGB(255, 200, 0)
      local GREY = Color3.fromRGB(40, 40, 40)
      local CODE_LENGTH = 4
      local MAX_ATTEMPTS = 5
      local secret_code = {}
      local current_input = {}
      local attempts = 0
      local game_over = false
      for i = 1, CODE_LENGTH do table.insert(secret_code, math.random(0, 9)) end
      if CoreGui:FindFirstChild("KeypadMinigame") then CoreGui.KeypadMinigame:Destroy() end
      local gui = Instance.new("ScreenGui")
      gui.Name = "KeypadMinigame"
      gui.IgnoreGuiInset = true
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 300, 0, 420)
      frame.AnchorPoint = Vector2.new(0.5, 0.5)
      frame.Position = UDim2.fromScale(0.5, 0.5)
      frame.BackgroundColor3 = DARK
      frame.Parent = gui
      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
      Instance.new("UIStroke", frame).Color = Color3.fromRGB(60, 60, 60)

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(1, 0, 0, 40)
      title.Position = UDim2.new(0, 0, 0, 10)
      title.BackgroundTransparency = 1
      title.Text = "KEYPAD HACK"
      title.TextColor3 = YELLOW
      title.Font = Enum.Font.GothamBold
      title.TextSize = 18
      title.Parent = frame

      local attempts_label = Instance.new("TextLabel")
      attempts_label.Size = UDim2.new(1, 0, 0, 24)
      attempts_label.Position = UDim2.new(0, 0, 0, 48)
      attempts_label.BackgroundTransparency = 1
      attempts_label.Text = "Attempts: " .. MAX_ATTEMPTS
      attempts_label.TextColor3 = WHITE
      attempts_label.Font = Enum.Font.Gotham
      attempts_label.TextSize = 13
      attempts_label.Parent = frame

      local display = Instance.new("Frame")
      display.Size = UDim2.new(0.8, 0, 0, 50)
      display.Position = UDim2.new(0.1, 0, 0, 78)
      display.BackgroundColor3 = GREY
      display.Parent = frame
      Instance.new("UICorner", display).CornerRadius = UDim.new(0, 10)

      local display_label = Instance.new("TextLabel")
      display_label.Size = UDim2.new(1, 0, 1, 0)
      display_label.BackgroundTransparency = 1
      display_label.Text = "_ _ _ _"
      display_label.TextColor3 = GREEN
      display_label.Font = Enum.Font.Code
      display_label.TextSize = 24
      display_label.Parent = display

      local feedback_label = Instance.new("TextLabel")
      feedback_label.Size = UDim2.new(1, 0, 0, 24)
      feedback_label.Position = UDim2.new(0, 0, 0, 134)
      feedback_label.BackgroundTransparency = 1
      feedback_label.Text = ""
      feedback_label.TextColor3 = WHITE
      feedback_label.Font = Enum.Font.Gotham
      feedback_label.TextSize = 12
      feedback_label.Parent = frame

      local cancel = Instance.new("TextButton")
      cancel.Size = UDim2.new(0, 28, 0, 28)
      cancel.Position = UDim2.new(1, -34, 0, 6)
      cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      cancel.Text = "X"
      cancel.TextScaled = true
      cancel.Font = Enum.Font.GothamBold
      cancel.TextColor3 = WHITE
      cancel.Parent = frame
      Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)
      local function cleanup() if gui then gui:Destroy() end end
      local function update_display()
         local parts = {}
         for i = 1, CODE_LENGTH do
            if current_input[i] then
               table.insert(parts, tostring(current_input[i]))
            else
               table.insert(parts, "_")
            end
         end
         display_label.Text = table.concat(parts, " ")
      end

      local function get_feedback(guess)
         local correct_pos = 0
         local correct_num = 0
         local secret_used = {}
         local guess_used = {}

         for i = 1, CODE_LENGTH do
            if guess[i] == secret_code[i] then
               correct_pos = correct_pos + 1
               secret_used[i] = true
               guess_used[i] = true
            end
         end

         for i = 1, CODE_LENGTH do
            if not guess_used[i] then
               for j = 1, CODE_LENGTH do
                  if not secret_used[j] and guess[i] == secret_code[j] then
                     correct_num = correct_num + 1
                     secret_used[j] = true
                     break
                  end
               end
            end
         end

         return correct_pos, correct_num
      end

      local function win()
         g.keypad_minigame_cooldown = tick()
         if g.notify then
            g.notify("Success", "Keypad cracked!.", 30)
         end
         task.delay(0.5, cleanup)
      end

      local function fail()
         if g.notify then
            g.notify("Error", "Keypad locked out!.", 5)
         end
         task.delay(0.5, cleanup)
      end

      local function submit()
         if #current_input < CODE_LENGTH then return end
         if game_over then return end

         local correct_pos, correct_num = get_feedback(current_input)

         if correct_pos == CODE_LENGTH then
            game_over = true
            display_label.TextColor3 = GREEN
            feedback_label.Text = "ACCESS GRANTED"
            feedback_label.TextColor3 = GREEN
            win()
            return
         end

         attempts = attempts + 1
         attempts_label.Text = "Attempts: " .. (MAX_ATTEMPTS - attempts)
         feedback_label.Text = correct_pos .. " correct position  |  " .. correct_num .. " correct number"
         feedback_label.TextColor3 = YELLOW
         current_input = {}
         update_display()

         if attempts >= MAX_ATTEMPTS then
            game_over = true
            display_label.TextColor3 = RED
            feedback_label.Text = "ACCESS DENIED"
            feedback_label.TextColor3 = RED
            fail()
         end
      end

      local button_grid = Instance.new("Frame")
      button_grid.Size = UDim2.new(0.85, 0, 0, 220)
      button_grid.Position = UDim2.new(0.075, 0, 0, 165)
      button_grid.BackgroundTransparency = 1
      button_grid.Parent = frame

      local grid_layout = Instance.new("UIGridLayout")
      grid_layout.CellSize = UDim2.new(0.3, 0, 0, 52)
      grid_layout.CellPadding = UDim2.new(0.033, 0, 0, 6)
      grid_layout.SortOrder = Enum.SortOrder.LayoutOrder
      grid_layout.Parent = button_grid

      local button_order = {7, 8, 9, 4, 5, 6, 1, 2, 3}
      for _, num in ipairs(button_order) do
         local btn = Instance.new("TextButton")
         btn.Text = tostring(num)
         btn.Font = Enum.Font.GothamBold
         btn.TextSize = 20
         btn.TextColor3 = WHITE
         btn.BackgroundColor3 = GREY
         btn.LayoutOrder = num
         btn.Parent = button_grid
         Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

         btn.MouseButton1Click:Connect(function()
            if game_over then return end
            if #current_input >= CODE_LENGTH then return end
            table.insert(current_input, num)
            update_display()
            if #current_input == CODE_LENGTH then
               task.delay(0.1, submit)
            end
         end)
      end

      local zero_btn = Instance.new("TextButton")
      zero_btn.Text = "0"
      zero_btn.Font = Enum.Font.GothamBold
      zero_btn.TextSize = 20
      zero_btn.TextColor3 = WHITE
      zero_btn.BackgroundColor3 = GREY
      zero_btn.LayoutOrder = 10
      zero_btn.Parent = button_grid
      Instance.new("UICorner", zero_btn).CornerRadius = UDim.new(0, 10)

      zero_btn.MouseButton1Click:Connect(function()
         if game_over then return end
         if #current_input >= CODE_LENGTH then return end
         table.insert(current_input, 0)
         update_display()
         if #current_input == CODE_LENGTH then
            task.delay(0.1, submit)
         end
      end)

      local clear_btn = Instance.new("TextButton")
      clear_btn.Text = "CLR"
      clear_btn.Font = Enum.Font.GothamBold
      clear_btn.TextSize = 14
      clear_btn.TextColor3 = WHITE
      clear_btn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
      clear_btn.LayoutOrder = 11
      clear_btn.Parent = button_grid
      Instance.new("UICorner", clear_btn).CornerRadius = UDim.new(0, 10)

      clear_btn.MouseButton1Click:Connect(function()
         if game_over then return end
         current_input = {}
         update_display()
         feedback_label.Text = ""
      end)

      cancel.MouseButton1Click:Connect(function()
         if g.notify then g.notify("Info", "Keypad cancelled.", 3) end
         cleanup()
      end)

      update_display()
   end

   g.hacking_minigame = function()
      if g.hacking_minigame_cooldown and tick() - g.hacking_minigame_cooldown < 30 then
         local remaining = math.ceil(30 - (tick() - g.hacking_minigame_cooldown))
         if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
         return
      end

      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
      local DARK = Color3.fromRGB(10, 10, 10)
      local GREEN = Color3.fromRGB(0, 255, 100)
      local DIM_GREEN = Color3.fromRGB(0, 100, 40)
      local WHITE = Color3.fromRGB(240, 240, 240)
      local RED = Color3.fromRGB(200, 60, 60)
      local YELLOW = Color3.fromRGB(255, 200, 0)
      local GRID_COLS = 8
      local GRID_ROWS = 6
      local SEQUENCE_LENGTH = 4
      local TIME_LIMIT = 20
      local chars = {"A","B","C","D","E","F","1","2","3","4","5","6","7","8","9","0"}
      local grid_data = {}
      local target_sequence = {}
      local current_sequence = {}
      local selected_col = nil
      local select_row = true
      local game_over = false
      local time_left = TIME_LIMIT
      local render_conn = nil
      local timer_conn = nil

      for row = 1, GRID_ROWS do
         grid_data[row] = {}
         for col = 1, GRID_COLS do
            grid_data[row][col] = chars[math.random(1, #chars)]
         end
      end

      local start_col = math.random(1, GRID_COLS)
      local cur_col = start_col
      local picking_col = true
      local cur_row = nil

      for i = 1, SEQUENCE_LENGTH do
         if picking_col then
            cur_row = math.random(1, GRID_ROWS)
            table.insert(target_sequence, grid_data[cur_row][cur_col])
            picking_col = false
         else
            cur_col = math.random(1, GRID_COLS)
            table.insert(target_sequence, grid_data[cur_row][cur_col])
            picking_col = true
         end
      end

      if CoreGui:FindFirstChild("HackingMinigame") then CoreGui.HackingMinigame:Destroy() end
      local gui = Instance.new("ScreenGui")
      gui.Name = "HackingMinigame"
      gui.IgnoreGuiInset = true
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 520, 0, 480)
      frame.AnchorPoint = Vector2.new(0.5, 0.5)
      frame.Position = UDim2.fromScale(0.5, 0.5)
      frame.BackgroundColor3 = DARK
      frame.Parent = gui
      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
      local stroke = Instance.new("UIStroke", frame)
      stroke.Color = GREEN
      stroke.Thickness = 1.5

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(0.6, 0, 0, 36)
      title.Position = UDim2.new(0, 10, 0, 6)
      title.BackgroundTransparency = 1
      title.Text = "// BREACH PROTOCOL //"
      title.TextColor3 = GREEN
      title.Font = Enum.Font.Code
      title.TextSize = 16
      title.TextXAlignment = Enum.TextXAlignment.Left
      title.Parent = frame

      local timer_label = Instance.new("TextLabel")
      timer_label.Size = UDim2.new(0.3, 0, 0, 36)
      timer_label.Position = UDim2.new(0.65, -40, 0, 6)
      timer_label.BackgroundTransparency = 1
      timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
      timer_label.TextColor3 = YELLOW
      timer_label.Font = Enum.Font.Code
      timer_label.TextSize = 16
      timer_label.TextXAlignment = Enum.TextXAlignment.Right
      timer_label.Parent = frame

      local cancel = Instance.new("TextButton")
      cancel.Size = UDim2.new(0, 28, 0, 28)
      cancel.Position = UDim2.new(1, -34, 0, 6)
      cancel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      cancel.Text = "X"
      cancel.TextScaled = true
      cancel.Font = Enum.Font.GothamBold
      cancel.TextColor3 = WHITE
      cancel.Parent = frame
      Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

      local seq_label = Instance.new("TextLabel")
      seq_label.Size = UDim2.new(1, -20, 0, 22)
      seq_label.Position = UDim2.new(0, 10, 0, 44)
      seq_label.BackgroundTransparency = 1
      seq_label.Text = "TARGET: " .. table.concat(target_sequence, "  ")
      seq_label.TextColor3 = YELLOW
      seq_label.Font = Enum.Font.Code
      seq_label.TextSize = 14
      seq_label.TextXAlignment = Enum.TextXAlignment.Left
      seq_label.Parent = frame

      local progress_label = Instance.new("TextLabel")
      progress_label.Size = UDim2.new(1, -20, 0, 22)
      progress_label.Position = UDim2.new(0, 10, 0, 64)
      progress_label.BackgroundTransparency = 1
      progress_label.Text = "INPUT:  "
      progress_label.TextColor3 = GREEN
      progress_label.Font = Enum.Font.Code
      progress_label.TextSize = 14
      progress_label.TextXAlignment = Enum.TextXAlignment.Left
      progress_label.Parent = frame

      local hint_label = Instance.new("TextLabel")
      hint_label.Size = UDim2.new(1, -20, 0, 18)
      hint_label.Position = UDim2.new(0, 10, 0, 86)
      hint_label.BackgroundTransparency = 1
      hint_label.Text = "Select from highlighted column"
      hint_label.TextColor3 = DIM_GREEN
      hint_label.Font = Enum.Font.Code
      hint_label.TextSize = 11
      hint_label.TextXAlignment = Enum.TextXAlignment.Left
      hint_label.Parent = frame

      local grid_frame = Instance.new("Frame")
      grid_frame.Size = UDim2.new(1, -20, 0, GRID_ROWS * 46)
      grid_frame.Position = UDim2.new(0, 10, 0, 112)
      grid_frame.BackgroundTransparency = 1
      grid_frame.Parent = frame

      local cell_buttons = {}
      local function cleanup()
         if render_conn then render_conn:Disconnect() end
         if timer_conn then timer_conn:Disconnect() end
         if gui then gui:Destroy() end
      end

      local function update_progress()
         local parts = {}
         for _, v in ipairs(current_sequence) do
            table.insert(parts, v)
         end
         progress_label.Text = "INPUT:  " .. table.concat(parts, "  ")
      end

      local function win()
         game_over = true
         g.hacking_minigame_cooldown = tick()
         if g.notify then
            g.notify("Success", "Breach successful!.", 5)
         end
         task.delay(0.5, cleanup)
      end

      local function fail(msg)
         game_over = true
         if g.notify then
            g.notify("Error", msg or "Breach failed!", 5)
         end
         task.delay(0.5, cleanup)
      end

      local function check_sequence()
         if #current_sequence < SEQUENCE_LENGTH then return end
         for i = 1, SEQUENCE_LENGTH do
            if current_sequence[i] ~= target_sequence[i] then
               fail("Wrong sequence!")
               return
            end
         end
         win()
      end

      local function highlight_cells()
         for row = 1, GRID_ROWS do
            for col = 1, GRID_COLS do
               local btn = cell_buttons[row] and cell_buttons[row][col]
               if not btn then continue end
               if select_row then
                  if selected_col and col == selected_col then
                     btn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
                     btn.TextColor3 = GREEN
                  else
                     btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                     btn.TextColor3 = DIM_GREEN
                  end
               else
                  if selected_col and row == selected_col then
                     btn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
                     btn.TextColor3 = GREEN
                  else
                     btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                     btn.TextColor3 = DIM_GREEN
                  end
               end
            end
         end
         if select_row then
            hint_label.Text = "Select from highlighted COLUMN " .. (selected_col or "?")
         else
            hint_label.Text = "Select from highlighted ROW " .. (selected_col or "?")
         end
      end

      for row = 1, GRID_ROWS do
         cell_buttons[row] = {}
         for col = 1, GRID_COLS do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 56, 0, 38)
            btn.Position = UDim2.new(0, (col - 1) * 62, 0, (row - 1) * 44)
            btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            btn.TextColor3 = DIM_GREEN
            btn.Font = Enum.Font.Code
            btn.TextSize = 16
            btn.Text = grid_data[row][col]
            btn.Parent = grid_frame
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            cell_buttons[row][col] = btn

            btn.MouseButton1Click:Connect(function()
               if game_over then return end
               local valid = false
               if select_row and selected_col and col == selected_col then
                  valid = true
               elseif not select_row and selected_col and row == selected_col then
                  valid = true
               elseif selected_col == nil then
                  valid = true
               end

               if not valid then return end

               table.insert(current_sequence, grid_data[row][col])
               update_progress()

               if select_row then
                  selected_col = row
                  select_row = false
               else
                  selected_col = col
                  select_row = true
               end

               highlight_cells()
               check_sequence()
            end)
         end
      end

      cancel.MouseButton1Click:Connect(function()
         if g.notify then g.notify("Info", "Hack cancelled.", 3) end
         cleanup()
      end)

      selected_col = start_col
      highlight_cells()
      update_progress()

      local elapsed = 0
      timer_conn = RunService.Heartbeat:Connect(function(dt)
         if game_over then return end
         elapsed = elapsed + dt
         time_left = TIME_LIMIT - elapsed
         if time_left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up! -5 coins.")
            return
         end
         local mins = math.floor(time_left / 60)
         local secs = math.floor(time_left % 60)
         timer_label.Text = string.format("%02d:%02d", mins, secs)
         if time_left <= 5 then
            timer_label.TextColor3 = RED
         end
      end)
   end

   g.safe_cracker_minigame = function()
      if g.safe_cracker_cooldown and tick() - g.safe_cracker_cooldown < 30 then
         local remaining = math.ceil(30 - (tick() - g.safe_cracker_cooldown))
         if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
         return
      end

      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      local RunService = cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
      local DARK = Color3.fromRGB(12, 10, 8)
      local GOLD = Color3.fromRGB(200, 160, 40)
      local DIM_GOLD = Color3.fromRGB(80, 60, 10)
      local WHITE = Color3.fromRGB(240, 240, 240)
      local RED = Color3.fromRGB(200, 60, 60)
      local GREEN = Color3.fromRGB(60, 200, 100)
      local SEQUENCE_COUNT = 3
      local NOTCH_COUNT = 20
      local TIME_LIMIT = 30
      local TARGET_WINDOW = 1.2
      local targets = {}
      for i = 1, SEQUENCE_COUNT do table.insert(targets, math.random(1, NOTCH_COUNT)) end
      local current_step = 1
      local dial_angle = 0
      local dial_speed = 90
      local spin_dir = 1
      local game_over = false
      local elapsed = 0
      local timer_conn = nil
      local render_conn = nil
      if CoreGui:FindFirstChild("SafeCrackerGUI") then CoreGui.SafeCrackerGUI:Destroy() end
      local gui = Instance.new("ScreenGui")
      gui.Name = "SafeCrackerGUI"
      gui.IgnoreGuiInset = true
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 380, 0, 440)
      frame.AnchorPoint = Vector2.new(0.5, 0.5)
      frame.Position = UDim2.fromScale(0.5, 0.5)
      frame.BackgroundColor3 = DARK
      frame.BorderSizePixel = 0
      frame.Parent = gui
      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
      local fstroke = Instance.new("UIStroke", frame)
      fstroke.Color = GOLD
      fstroke.Thickness = 1.5

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(0.75, 0, 0, 36)
      title.Position = UDim2.new(0, 12, 0, 6)
      title.BackgroundTransparency = 1
      title.Text = "// SAFE CRACKER //"
      title.TextColor3 = GOLD
      title.Font = Enum.Font.Code
      title.TextSize = 15
      title.TextXAlignment = Enum.TextXAlignment.Left
      title.Parent = frame

      local timer_label = Instance.new("TextLabel")
      timer_label.Size = UDim2.new(0.25, -40, 0, 36)
      timer_label.Position = UDim2.new(0.65, -10, 0, 6)
      timer_label.BackgroundTransparency = 1
      timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
      timer_label.TextColor3 = GOLD
      timer_label.Font = Enum.Font.Code
      timer_label.TextSize = 15
      timer_label.TextXAlignment = Enum.TextXAlignment.Right
      timer_label.Parent = frame

      local cancel = Instance.new("TextButton")
      cancel.Size = UDim2.new(0, 28, 0, 28)
      cancel.Position = UDim2.new(1, -34, 0, 8)
      cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
      cancel.Text = "X"
      cancel.TextScaled = true
      cancel.Font = Enum.Font.GothamBold
      cancel.TextColor3 = WHITE
      cancel.BorderSizePixel = 0
      cancel.Parent = frame
      Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

      local step_label = Instance.new("TextLabel")
      step_label.Size = UDim2.new(1, -20, 0, 22)
      step_label.Position = UDim2.new(0, 10, 0, 42)
      step_label.BackgroundTransparency = 1
      step_label.Text = "Step 1 of " .. SEQUENCE_COUNT .. "  —  Target: " .. targets[1]
      step_label.TextColor3 = GOLD
      step_label.Font = Enum.Font.Code
      step_label.TextSize = 13
      step_label.TextXAlignment = Enum.TextXAlignment.Left
      step_label.Parent = frame

      local hint_label = Instance.new("TextLabel")
      hint_label.Size = UDim2.new(1, -20, 0, 18)
      hint_label.Position = UDim2.new(0, 10, 0, 64)
      hint_label.BackgroundTransparency = 1
      hint_label.Text = "Click when the marker lands on the target notch"
      hint_label.TextColor3 = DIM_GOLD
      hint_label.Font = Enum.Font.Code
      hint_label.TextSize = 11
      hint_label.TextXAlignment = Enum.TextXAlignment.Left
      hint_label.Parent = frame

      local dial_holder = Instance.new("Frame")
      dial_holder.Size = UDim2.new(0, 240, 0, 240)
      dial_holder.AnchorPoint = Vector2.new(0.5, 0)
      dial_holder.Position = UDim2.new(0.5, 0, 0, 96)
      dial_holder.BackgroundTransparency = 1
      dial_holder.Parent = frame

      local dial_bg = Instance.new("Frame")
      dial_bg.Size = UDim2.fromScale(1, 1)
      dial_bg.BackgroundColor3 = Color3.fromRGB(28, 24, 16)
      dial_bg.BorderSizePixel = 0
      dial_bg.Parent = dial_holder
      Instance.new("UICorner", dial_bg).CornerRadius = UDim.new(0.5, 0)
      local dstroke = Instance.new("UIStroke", dial_bg)
      dstroke.Color = GOLD
      dstroke.Thickness = 2

      local notch_labels = {}
      for i = 1, NOTCH_COUNT do
         local angle = (i - 1) * (360 / NOTCH_COUNT)
         local rad = math.rad(angle - 90)
         local nx = 0.5 + math.cos(rad) * 0.42
         local ny = 0.5 + math.sin(rad) * 0.42
         local lbl = Instance.new("TextLabel")
         lbl.Size = UDim2.new(0, 22, 0, 18)
         lbl.AnchorPoint = Vector2.new(0.5, 0.5)
         lbl.Position = UDim2.new(nx, 0, ny, 0)
         lbl.BackgroundTransparency = 1
         lbl.Text = tostring(i)
         lbl.Font = Enum.Font.Code
         lbl.TextSize = 10
         lbl.TextColor3 = DIM_GOLD
         lbl.Parent = dial_holder
         notch_labels[i] = lbl
      end

      local marker = Instance.new("Frame")
      marker.Size = UDim2.new(0, 6, 0, 30)
      marker.AnchorPoint = Vector2.new(0.5, 1)
      marker.Position = UDim2.new(0.5, 0, 0.08, 0)
      marker.BackgroundColor3 = WHITE
      marker.BorderSizePixel = 0
      marker.Parent = dial_holder
      Instance.new("UICorner", marker).CornerRadius = UDim.new(0, 3)

      local click_btn = Instance.new("TextButton")
      click_btn.Size = UDim2.new(0, 120, 0, 42)
      click_btn.AnchorPoint = Vector2.new(0.5, 0)
      click_btn.Position = UDim2.new(0.5, 0, 0, 354)
      click_btn.BackgroundColor3 = Color3.fromRGB(38, 30, 10)
      click_btn.Text = "CRACK"
      click_btn.Font = Enum.Font.GothamBold
      click_btn.TextSize = 15
      click_btn.TextColor3 = GOLD
      click_btn.BorderSizePixel = 0
      click_btn.Parent = frame
      Instance.new("UICorner", click_btn).CornerRadius = UDim.new(0, 10)
      Instance.new("UIStroke", click_btn).Color = GOLD

      local feedback = Instance.new("TextLabel")
      feedback.Size = UDim2.new(1, -20, 0, 22)
      feedback.Position = UDim2.new(0, 10, 0, 406)
      feedback.BackgroundTransparency = 1
      feedback.Text = ""
      feedback.TextColor3 = GREEN
      feedback.Font = Enum.Font.Code
      feedback.TextSize = 13
      feedback.TextXAlignment = Enum.TextXAlignment.Center
      feedback.Parent = frame

      local function cleanup()
         if render_conn then render_conn:Disconnect() end
         if timer_conn then timer_conn:Disconnect() end
         if gui then gui:Destroy() end
      end

      local function get_current_notch()
         local normalized = dial_angle % 360
         local notch = math.round(normalized / (360 / NOTCH_COUNT)) % NOTCH_COUNT
         if notch == 0 then notch = NOTCH_COUNT end
         return notch
      end

      local function update_notch_colors()
         local cur = get_current_notch()
         local tgt = targets[current_step]
         for i, lbl in ipairs(notch_labels) do
            if i == tgt then
               lbl.TextColor3 = GOLD
            elseif i == cur then
               lbl.TextColor3 = WHITE
            else
               lbl.TextColor3 = DIM_GOLD
            end
         end
      end

      local function win()
         game_over = true
         g.safe_cracker_cooldown = tick()
         if g.notify then g.notify("Success", "Safe cracked!", 5) end
         task.delay(0.5, cleanup)
      end

      local function fail(msg)
         game_over = true
         if g.notify then g.notify("Error", msg or "Safe locked!", 5) end
         task.delay(0.5, cleanup)
      end

      click_btn.MouseButton1Click:Connect(function()
         if game_over then return end
         local cur = get_current_notch()
         local tgt = targets[current_step]
         local diff = math.abs(cur - tgt)
         local within = diff <= 1 or diff >= NOTCH_COUNT - 1

         if within then
            feedback.Text = "Notch: " .. tgt .. " hit!"
            feedback.TextColor3 = GREEN
            current_step = current_step + 1
            spin_dir = spin_dir * -1
            dial_speed = dial_speed + 20

            if current_step > SEQUENCE_COUNT then
               win()
            else
               step_label.Text = "Step " .. current_step .. " of " .. SEQUENCE_COUNT .. "  —  Target: " .. targets[current_step]
            end
         else
            feedback.Text = "✗ Missed! Got notch: " .. cur
            feedback.TextColor3 = RED
            fail("Wrong notch! -5 coins.")
         end
      end)

      cancel.MouseButton1Click:Connect(function()
         if g.notify then g.notify("Info", "Safe cracker cancelled.", 3) end
         cleanup()
      end)

      render_conn = RunService.RenderStepped:Connect(function(dt)
         if game_over then return end
         dial_angle = dial_angle + dial_speed * dt * spin_dir
         update_notch_colors()
      end)

      local time_elapsed = 0
      timer_conn = RunService.Heartbeat:Connect(function(dt)
         if game_over then return end
         time_elapsed = time_elapsed + dt
         local left = TIME_LIMIT - time_elapsed
         if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up! -5 coins.")
            return
         end
         local mins = math.floor(left / 60)
         local secs = math.floor(left % 60)
         timer_label.Text = string.format("%02d:%02d", mins, secs)
         if left <= 5 then timer_label.TextColor3 = RED end
      end)
   end

   g.wire_cutter_minigame = function()
      if g.wire_cutter_cooldown and tick() - g.wire_cutter_cooldown < 30 then
         local remaining = math.ceil(30 - (tick() - g.wire_cutter_cooldown))
         if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
         return
      end

      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      local DARK = Color3.fromRGB(12, 12, 14)
      local WHITE = Color3.fromRGB(240, 240, 240)
      local MUTED = Color3.fromRGB(120, 120, 130)
      local RED = Color3.fromRGB(220, 60, 60)
      local GREEN = Color3.fromRGB(60, 200, 100)
      local YELLOW = Color3.fromRGB(230, 200, 50)
      local BLUE = Color3.fromRGB(80, 140, 240)
      local ORANGE = Color3.fromRGB(230, 130, 40)
      local WHITE_W = Color3.fromRGB(200, 200, 200)
      local TIME_LIMIT = 25
      local WIRE_COLORS = {
         {name = "Red",    color = RED},
         {name = "Green",  color = GREEN},
         {name = "Yellow", color = YELLOW},
         {name = "Blue",   color = BLUE},
         {name = "Orange", color = ORANGE},
         {name = "White",  color = WHITE_W},
      }
      local WIRE_COUNT = 5
      local wires = {}
      local used = {}
      while #wires < WIRE_COUNT do
         local pick = math.random(1, #WIRE_COLORS)
         if not used[pick] then
            used[pick] = true
            table.insert(wires, {name = WIRE_COLORS[pick].name, color = WIRE_COLORS[pick].color, cut = false})
         end
      end

      local clues = {}
      local safe_wire = math.random(1, WIRE_COUNT)
      local positions = {"first", "second", "third", "fourth", "fifth"}
      local clue_types = {}

      for i = 1, WIRE_COUNT do
         if i ~= safe_wire then
            local t = math.random(1, 3)
            if t == 1 then
               table.insert(clue_types, {wire = i, type = "color", text = "Do NOT cut the " .. wires[i].name .. " wire"})
            elseif t == 2 then
               table.insert(clue_types, {wire = i, type = "position", text = "The " .. positions[i] .. " wire is dangerous"})
            else
               table.insert(clue_types, {wire = i, type = "both", text = "Avoid the " .. positions[i] .. " (" .. wires[i].name .. ") wire"})
            end
         end
      end

      local shown_clues = {}
      local indices = {}
      for i = 1, #clue_types do indices[i] = i end
      for i = #indices, 2, -1 do
         local j = math.random(1, i)
         indices[i], indices[j] = indices[j], indices[i]
      end
      for i = 1, math.min(3, #clue_types) do
         table.insert(shown_clues, clue_types[indices[i]])
      end

      local game_over = false
      local timer_conn = nil
      if CoreGui:FindFirstChild("WireCutterGUI") then CoreGui.WireCutterGUI:Destroy() end
      local gui = Instance.new("ScreenGui")
      gui.Name = "WireCutterGUI"
      gui.IgnoreGuiInset = true
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 400, 0, 480)
      frame.AnchorPoint = Vector2.new(0.5, 0.5)
      frame.Position = UDim2.fromScale(0.5, 0.5)
      frame.BackgroundColor3 = DARK
      frame.BorderSizePixel = 0
      frame.Parent = gui
      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
      local fstroke = Instance.new("UIStroke", frame)
      fstroke.Color = Color3.fromRGB(60, 60, 70)
      fstroke.Thickness = 1

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(0.75, 0, 0, 36)
      title.Position = UDim2.new(0, 12, 0, 6)
      title.BackgroundTransparency = 1
      title.Text = "// WIRE CUTTER //"
      title.TextColor3 = GREEN
      title.Font = Enum.Font.Code
      title.TextSize = 15
      title.TextXAlignment = Enum.TextXAlignment.Left
      title.Parent = frame

      local timer_label = Instance.new("TextLabel")
      timer_label.Size = UDim2.new(0.2, 0, 0, 36)
      timer_label.Position = UDim2.new(0.72, 0, 0, 6)
      timer_label.BackgroundTransparency = 1
      timer_label.Text = "00:" .. string.format("%02d", TIME_LIMIT)
      timer_label.TextColor3 = YELLOW
      timer_label.Font = Enum.Font.Code
      timer_label.TextSize = 15
      timer_label.TextXAlignment = Enum.TextXAlignment.Right
      timer_label.Parent = frame

      local cancel = Instance.new("TextButton")
      cancel.Size = UDim2.new(0, 28, 0, 28)
      cancel.Position = UDim2.new(1, -34, 0, 8)
      cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
      cancel.Text = "X"
      cancel.TextScaled = true
      cancel.Font = Enum.Font.GothamBold
      cancel.TextColor3 = WHITE
      cancel.BorderSizePixel = 0
      cancel.Parent = frame
      Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

      local clue_header = Instance.new("TextLabel")
      clue_header.Size = UDim2.new(1, -20, 0, 20)
      clue_header.Position = UDim2.new(0, 10, 0, 44)
      clue_header.BackgroundTransparency = 1
      clue_header.Text = "Intel:"
      clue_header.TextColor3 = MUTED
      clue_header.Font = Enum.Font.Code
      clue_header.TextSize = 12
      clue_header.TextXAlignment = Enum.TextXAlignment.Left
      clue_header.Parent = frame

      for i, clue in ipairs(shown_clues) do
         local clue_lbl = Instance.new("TextLabel")
         clue_lbl.Size = UDim2.new(1, -20, 0, 18)
         clue_lbl.Position = UDim2.new(0, 10, 0, 44 + i * 20)
         clue_lbl.BackgroundTransparency = 1
         clue_lbl.Text = "• " .. clue.text
         clue_lbl.TextColor3 = WHITE
         clue_lbl.Font = Enum.Font.Code
         clue_lbl.TextSize = 11
         clue_lbl.TextXAlignment = Enum.TextXAlignment.Left
         clue_lbl.Parent = frame
      end

      local wire_start_y = 44 + (#shown_clues + 2) * 20
      local function cleanup()
         if timer_conn then timer_conn:Disconnect() end
         if gui then gui:Destroy() end
      end

      local function win()
         game_over = true
         g.wire_cutter_cooldown = tick()
         if g.notify then g.notify("Success", "Wire cut! Defused!", 5) end
         task.delay(0.5, cleanup)
      end

      local function fail(msg)
         game_over = true
         if g.notify then g.notify("Error", msg or "Wrong wire!", 5) end
         task.delay(0.5, cleanup)
      end

      for i, wire in ipairs(wires) do
         local wire_row = Instance.new("Frame")
         wire_row.Size = UDim2.new(1, -20, 0, 48)
         wire_row.Position = UDim2.new(0, 10, 0, wire_start_y + (i - 1) * 56)
         wire_row.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
         wire_row.BorderSizePixel = 0
         wire_row.Parent = frame
         Instance.new("UICorner", wire_row).CornerRadius = UDim.new(0, 8)
         Instance.new("UIStroke", wire_row).Color = Color3.fromRGB(40, 40, 50)

         local pos_lbl = Instance.new("TextLabel")
         pos_lbl.Size = UDim2.new(0, 20, 1, 0)
         pos_lbl.Position = UDim2.new(0, 8, 0, 0)
         pos_lbl.BackgroundTransparency = 1
         pos_lbl.Text = tostring(i)
         pos_lbl.Font = Enum.Font.Code
         pos_lbl.TextSize = 12
         pos_lbl.TextColor3 = MUTED
         pos_lbl.Parent = wire_row

         local wire_line = Instance.new("Frame")
         wire_line.Size = UDim2.new(0, 180, 0, 8)
         wire_line.AnchorPoint = Vector2.new(0, 0.5)
         wire_line.Position = UDim2.new(0, 30, 0.5, 0)
         wire_line.BackgroundColor3 = wire.color
         wire_line.BorderSizePixel = 0
         wire_line.Parent = wire_row
         Instance.new("UICorner", wire_line).CornerRadius = UDim.new(0.5, 0)

         local name_lbl = Instance.new("TextLabel")
         name_lbl.Size = UDim2.new(0, 60, 1, 0)
         name_lbl.Position = UDim2.new(0, 216, 0, 0)
         name_lbl.BackgroundTransparency = 1
         name_lbl.Text = wire.name
         name_lbl.Font = Enum.Font.Code
         name_lbl.TextSize = 12
         name_lbl.TextColor3 = wire.color
         name_lbl.Parent = wire_row

         local cut_btn = Instance.new("TextButton")
         cut_btn.Size = UDim2.new(0, 52, 0, 30)
         cut_btn.AnchorPoint = Vector2.new(1, 0.5)
         cut_btn.Position = UDim2.new(1, -8, 0.5, 0)
         cut_btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
         cut_btn.Text = "CUT"
         cut_btn.Font = Enum.Font.GothamBold
         cut_btn.TextSize = 12
         cut_btn.TextColor3 = WHITE
         cut_btn.BorderSizePixel = 0
         cut_btn.Parent = wire_row
         Instance.new("UICorner", cut_btn).CornerRadius = UDim.new(0, 6)
         Instance.new("UIStroke", cut_btn).Color = Color3.fromRGB(70, 70, 80)

         local wire_index = i
         cut_btn.MouseButton1Click:Connect(function()
            if game_over then return end
            if wire_index == safe_wire then
               wire_line.Size = UDim2.new(0, 80, 0, 8)
               local gap = Instance.new("Frame")
               gap.Size = UDim2.new(0, 20, 0, 8)
               gap.AnchorPoint = Vector2.new(0, 0.5)
               gap.Position = UDim2.new(0, 115, 0.5, 0)
               gap.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
               gap.BorderSizePixel = 0
               gap.Parent = wire_row
               cut_btn.Text = getgenv().Flames_Hub_Emojis and tostring(getgenv().Flames_Hub_Emojis["Checkmark"])
               cut_btn.TextColor3 = GREEN
               win()
            else
               cut_btn.TextColor3 = RED
               cut_btn.Text = "X"
               fail("Wrong wire cut!")
            end
         end)
      end

      cancel.MouseButton1Click:Connect(function()
         if g.notify then g.notify("Info", "Wire cutter cancelled.", 3) end
         cleanup()
      end)

      local time_elapsed = 0
      timer_conn = game:GetService("RunService").Heartbeat:Connect(function(dt)
         if game_over then return end
         time_elapsed = time_elapsed + dt
         local left = TIME_LIMIT - time_elapsed
         if left <= 0 then
            timer_label.Text = "00:00"
            fail("Time's up! -5 coins.")
            return
         end
         local mins = math.floor(left / 60)
         local secs = math.floor(left % 60)
         timer_label.Text = string.format("%02d:%02d", mins, secs)
         if left <= 5 then timer_label.TextColor3 = RED end
      end)
   end

   g.simon_says_minigame = function()
      if g.simon_says_cooldown and tick() - g.simon_says_cooldown < 30 then
         local remaining = math.ceil(30 - (tick() - g.simon_says_cooldown))
         if g.notify then g.notify("Warning", "You must wait " .. remaining .. " seconds before playing again.", 5) end
         return
      end

      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      local TweenService = cloneref and cloneref(game:GetService("TweenService")) or game:GetService("TweenService")
      local DARK = Color3.fromRGB(14, 14, 18)
      local WHITE = Color3.fromRGB(240, 240, 240)
      local MUTED = Color3.fromRGB(100, 100, 110)
      local RED = Color3.fromRGB(220, 60, 60)
      local ROUNDS_TO_WIN = 5
      local BUTTONS = {
         {name = "Red",    color = Color3.fromRGB(200, 50, 50),   dim = Color3.fromRGB(60, 15, 15)},
         {name = "Green",  color = Color3.fromRGB(50, 200, 90),   dim = Color3.fromRGB(15, 60, 25)},
         {name = "Blue",   color = Color3.fromRGB(60, 120, 220),  dim = Color3.fromRGB(15, 35, 70)},
         {name = "Yellow", color = Color3.fromRGB(220, 200, 40),  dim = Color3.fromRGB(65, 58, 10)},
      }
      local sequence = {}
      local player_index = 1
      local round = 0
      local accepting_input = false
      local game_over = false
      if CoreGui:FindFirstChild("SimonSaysGUI") then CoreGui.SimonSaysGUI:Destroy() end
      local gui = Instance.new("ScreenGui")
      gui.Name = "SimonSaysGUI"
      gui.IgnoreGuiInset = true
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 340, 0, 400)
      frame.AnchorPoint = Vector2.new(0.5, 0.5)
      frame.Position = UDim2.fromScale(0.5, 0.5)
      frame.BackgroundColor3 = DARK
      frame.BorderSizePixel = 0
      frame.Parent = gui
      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
      Instance.new("UIStroke", frame).Color = Color3.fromRGB(50, 50, 60)

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(0.75, 0, 0, 36)
      title.Position = UDim2.new(0, 12, 0, 6)
      title.BackgroundTransparency = 1
      title.Text = "// SIMON SAYS //"
      title.TextColor3 = Color3.fromRGB(180, 180, 220)
      title.Font = Enum.Font.Code
      title.TextSize = 15
      title.TextXAlignment = Enum.TextXAlignment.Left
      title.Parent = frame

      local cancel = Instance.new("TextButton")
      cancel.Size = UDim2.new(0, 28, 0, 28)
      cancel.Position = UDim2.new(1, -34, 0, 8)
      cancel.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
      cancel.Text = "X"
      cancel.TextScaled = true
      cancel.Font = Enum.Font.GothamBold
      cancel.TextColor3 = WHITE
      cancel.BorderSizePixel = 0
      cancel.Parent = frame
      Instance.new("UICorner", cancel).CornerRadius = UDim.new(0, 6)

      local status_label = Instance.new("TextLabel")
      status_label.Size = UDim2.new(1, -20, 0, 22)
      status_label.Position = UDim2.new(0, 10, 0, 44)
      status_label.BackgroundTransparency = 1
      status_label.Text = "Watch the sequence..."
      status_label.TextColor3 = MUTED
      status_label.Font = Enum.Font.Code
      status_label.TextSize = 12
      status_label.TextXAlignment = Enum.TextXAlignment.Center
      status_label.Parent = frame

      local round_label = Instance.new("TextLabel")
      round_label.Size = UDim2.new(1, -20, 0, 20)
      round_label.Position = UDim2.new(0, 10, 0, 66)
      round_label.BackgroundTransparency = 1
      round_label.Text = "Round 0 / " .. ROUNDS_TO_WIN
      round_label.TextColor3 = MUTED
      round_label.Font = Enum.Font.Code
      round_label.TextSize = 11
      round_label.TextXAlignment = Enum.TextXAlignment.Center
      round_label.Parent = frame

      local grid = Instance.new("Frame")
      grid.Size = UDim2.new(0, 260, 0, 260)
      grid.AnchorPoint = Vector2.new(0.5, 0)
      grid.Position = UDim2.new(0.5, 0, 0, 100)
      grid.BackgroundTransparency = 1
      grid.Parent = frame

      local btn_refs = {}
      local positions = {
         UDim2.new(0, 0, 0, 0),
         UDim2.new(0, 136, 0, 0),
         UDim2.new(0, 0, 0, 136),
         UDim2.new(0, 136, 0, 136),
      }
      local function cleanup()
         if gui then gui:Destroy() end
      end

      local function win()
         game_over = true
         g.simon_says_cooldown = tick()
         if g.notify then g.notify("Success", "Simon says well done!", 5) end
         task.delay(0.5, cleanup)
      end

      local function fail(msg)
         game_over = true
         if g.notify then g.notify("Error", msg or "Wrong button!", 5) end
         task.delay(0.3, cleanup)
      end

      local function flash_button(index, duration, callback)
         local b = btn_refs[index]
         if not b then if callback then callback() end return end
         b.BackgroundColor3 = BUTTONS[index].color
         task.delay(duration, function()
            b.BackgroundColor3 = BUTTONS[index].dim
            if callback then task.delay(0.1, callback) end
         end)
      end

      local function play_sequence(step, callback)
         if step > #sequence then
            if callback then callback() end
            return
         end
         flash_button(sequence[step], 0.4, function()
            task.delay(0.15, function()
               play_sequence(step + 1, callback)
            end)
         end)
      end

      local function start_round()
         if game_over then return end
         round = round + 1
         round_label.Text = "Round " .. round .. " / " .. ROUNDS_TO_WIN
         status_label.Text = "Watch..."
         status_label.TextColor3 = MUTED
         accepting_input = false
         player_index = 1
         table.insert(sequence, math.random(1, 4))
         task.delay(0.6, function()
            play_sequence(1, function()
               if not game_over then
                  accepting_input = true
                  status_label.Text = "Your turn! Repeat the sequence"
                  status_label.TextColor3 = WHITE
               end
            end)
         end)
      end

      for i, data in ipairs(BUTTONS) do
         local btn = Instance.new("TextButton")
         btn.Size = UDim2.new(0, 120, 0, 120)
         btn.Position = positions[i]
         btn.BackgroundColor3 = data.dim
         btn.Text = data.name
         btn.Font = Enum.Font.GothamBold
         btn.TextSize = 14
         btn.TextColor3 = WHITE
         btn.BorderSizePixel = 0
         btn.AutoButtonColor = false
         btn.Parent = grid
         Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
         btn_refs[i] = btn

         local idx = i
         btn.MouseButton1Click:Connect(function()
            if game_over or not accepting_input then return end
            flash_button(idx, 0.2, nil)
            if sequence[player_index] == idx then
               player_index = player_index + 1
               if player_index > #sequence then
                  accepting_input = false
                  if round >= ROUNDS_TO_WIN then
                     win()
                  else
                     status_label.Text = "Correct! Next round..."
                     status_label.TextColor3 = Color3.fromRGB(60, 200, 100)
                     task.delay(0.8, start_round)
                  end
               end
            else
               fail("Wrong button! -5 coins.")
            end
         end)
      end

      cancel.MouseButton1Click:Connect(function()
         if g.notify then g.notify("Info", "Simon Says cancelled.", 3) end
         cleanup()
      end)

      start_round()
   end

   g.open_minigame_menu = function()
      local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
      if CoreGui:FindFirstChild("MinigameMenuGUI") and CoreGui:FindFirstChild("MinigameMenuGUI"):IsA("ScreenGui") then CoreGui.MinigameMenuGUI:FindFirstChildOfClass("Frame").Visible = true return end
      local DARK        = Color3.fromRGB(18, 18, 18)
      local SURFACE     = Color3.fromRGB(26, 26, 26)
      local BORDER      = Color3.fromRGB(50, 50, 50)
      local WHITE       = Color3.fromRGB(240, 240, 240)
      local MUTED       = Color3.fromRGB(140, 140, 140)
      local GOLD        = Color3.fromRGB(255, 200, 50)
      local GREEN_C     = Color3.fromRGB(60, 180, 100)
      local RED_C       = Color3.fromRGB(200, 70, 70)
      local YELLOW_C    = Color3.fromRGB(220, 160, 30)
      local GAMES = {
         {
            name        = "Memory Grid",
            sub         = "Memorize the pattern, then tap the tiles",
            difficulty  = "Easy",
            diff_color  = GREEN_C,
            win_coins   = "+3",
            loss_coins  = "-5",
            desc        = "A 5x5 grid lights up 6-9 tiles for 10 seconds. Memorize their positions, then click every highlighted tile before making 3 mistakes.",
            fn          = function() g.Memory_Mini_Game_GUI() end,
         },
         {
            name        = "Reaction Time",
            sub         = "Land the moving bar in the zone 5 times successfully",
            difficulty  = "Medium",
            diff_color  = YELLOW_C,
            win_coins   = "+15",
            loss_coins  = "-5",
            desc        = "A bar bounces left and right at increasing speed. Click when it overlaps the purple target zone. Hit it 5 times to win — miss 3 and it's over.",
            fn          = function() g.reaction_time_minigame() end,
         },
         {
            name        = "Keypad Hack",
            sub         = "Crack the 4-digit code in 5 attempts",
            difficulty  = "Master",
            diff_color  = RED_C,
            win_coins   = "+30",
            loss_coins  = "-10",
            desc        = "A secret 4-digit code is generated. Enter your guess and receive hints — correct position vs. correct number. Deduce the code in 5 attempts or get locked out.",
            fn          = function() g.keypad_minigame() end,
         },
         {
            name        = "Breach Protocol",
            sub         = "Input the target sequence from the grid",
            difficulty  = "Medium",
            diff_color  = YELLOW_C,
            win_coins   = "+5",
            loss_coins  = "-5",
            desc        = "A Cyberpunk-style matrix grid. Alternate selecting columns and rows to build a 4-character sequence matching the target. You have 20 seconds before the breach fails.",
            fn          = function() g.hacking_minigame() end,
         },
         {
            name        = "Safe Cracker",
            sub         = "Hit 3 target notches on the spinning dial",
            difficulty  = "Hard",
            diff_color  = RED_C,
            win_coins   = "+12",
            loss_coins  = "-5",
            desc        = "A dial spins at increasing speed across 20 notches. Click CRACK when the marker lands on the target notch for each of 3 steps. One wrong click and the safe locks.",
            fn          = function() g.safe_cracker_minigame() end,
         },
         {
            name        = "Wire Cutter",
            sub         = "Cut the correct wire using the intel clues",
            difficulty  = "Easy",
            diff_color  = GREEN_C,
            win_coins   = "+10",
            loss_coins  = "-5",
            desc        = "Five wires are presented with partial intel clues about which ones are dangerous. Deduce the safe wire and cut it before the timer runs out.",
            fn          = function() g.wire_cutter_minigame() end,
         },
         {
            name        = "Simon Says",
            sub         = "Repeat the color sequence 5 rounds in a row",
            difficulty  = "Medium",
            diff_color  = YELLOW_C,
            win_coins   = "+10",
            loss_coins  = "-5",
            desc        = "Four colored buttons flash a growing sequence each round. Watch carefully then repeat it back in order. One wrong press and you lose. Survive 5 rounds to win.",
            fn          = function() g.simon_says_minigame() end,
         },
      }

      local gui = Instance.new("ScreenGui")
      gui.Name = "MinigameMenuGUI"
      gui.IgnoreGuiInset = true
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local outer = Instance.new("Frame")
      outer.AnchorPoint = Vector2.new(0.5, 0.5)
      outer.Position = UDim2.fromScale(0.5, 0.5)
      outer.Size = UDim2.new(0, 360, 0, 520)
      outer.BackgroundColor3 = DARK
      outer.BorderSizePixel = 0
      outer.Parent = gui
      Instance.new("UICorner", outer).CornerRadius = UDim.new(0, 14)

      local stroke = Instance.new("UIStroke", outer)
      stroke.Color = BORDER
      stroke.Thickness = 1

      local header = Instance.new("Frame")
      header.Size = UDim2.new(1, 0, 0, 42)
      header.BackgroundColor3 = SURFACE
      header.BorderSizePixel = 0
      header.Parent = outer

      local hcorner = Instance.new("UICorner", header)
      hcorner.CornerRadius = UDim.new(0, 14)

      local hfix = Instance.new("Frame")
      hfix.Size = UDim2.new(1, 0, 0.5, 0)
      hfix.Position = UDim2.fromScale(0, 0.5)
      hfix.BackgroundColor3 = SURFACE
      hfix.BorderSizePixel = 0
      hfix.Parent = header

      local title_lbl = Instance.new("TextLabel")
      title_lbl.Size = UDim2.new(1, -90, 1, 0)
      title_lbl.Position = UDim2.new(0, 14, 0, 0)
      title_lbl.BackgroundTransparency = 1
      title_lbl.Text = "Flames Hub Mini-Games | Earn Coins"
      title_lbl.TextScaled = true
      title_lbl.Font = Enum.Font.GothamBold
      title_lbl.TextSize = 14
      title_lbl.TextColor3 = WHITE
      title_lbl.TextXAlignment = Enum.TextXAlignment.Left
      title_lbl.Parent = header

      dragify(outer)

      local minimized = false
      local content_frame
      local function make_header_btn(text, x_offset)
         local btn = Instance.new("TextButton")
         btn.Size = UDim2.new(0, 34, 0, 24)
         btn.Position = UDim2.new(1, x_offset, 0.5, -12)
         btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
         btn.Text = text
         btn.TextColor3 = MUTED
         btn.Font = Enum.Font.GothamBold
         btn.TextSize = 13
         btn.BorderSizePixel = 0
         btn.Parent = header
         Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
         return btn
      end

      local close_btn    = make_header_btn("X", -45)
      local minimize_btn = make_header_btn("-", -80)
      close_btn.MouseButton1Click:Connect(function() gui:FindFirstChildOfClass("Frame").Visible = false end)
      local function build_content()
         if content_frame then content_frame:Destroy() end
         content_frame = Instance.new("ScrollingFrame")
         content_frame.Size = UDim2.new(1, 0, 1, -42)
         content_frame.Position = UDim2.new(0, 0, 0, 42)
         content_frame.BackgroundTransparency = 1
         content_frame.BorderSizePixel = 0
         content_frame.ScrollBarThickness = 3
         content_frame.CanvasSize = UDim2.new(0, 0, 0, 0)
         content_frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
         content_frame.Parent = outer

         local list = Instance.new("UIListLayout")
         list.Padding = UDim.new(0, 8)
         list.SortOrder = Enum.SortOrder.LayoutOrder
         list.Parent = content_frame

         local pad = Instance.new("UIPadding")
         pad.PaddingTop = UDim.new(0, 10)
         pad.PaddingBottom = UDim.new(0, 10)
         pad.PaddingLeft = UDim.new(0, 10)
         pad.PaddingRight = UDim.new(0, 10)
         pad.Parent = content_frame

         for i, picked_game in ipairs(GAMES) do
            local card = Instance.new("Frame")
            card.Size = UDim2.new(1, 0, 0, 110)
            card.BackgroundColor3 = SURFACE
            card.BorderSizePixel = 0
            card.LayoutOrder = i
            card.Parent = content_frame
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

            local cstroke = Instance.new("UIStroke", card)
            cstroke.Color = BORDER
            cstroke.Thickness = 0.5

            local name_lbl = Instance.new("TextLabel")
            name_lbl.Size = UDim2.new(1, -110, 0, 20)
            name_lbl.Position = UDim2.new(0, 12, 0, 10)
            name_lbl.BackgroundTransparency = 1
            name_lbl.Text = picked_game.name
            name_lbl.Font = Enum.Font.GothamBold
            name_lbl.TextSize = 13
            name_lbl.TextColor3 = WHITE
            name_lbl.TextXAlignment = Enum.TextXAlignment.Left
            name_lbl.Parent = card

            local diff_lbl = Instance.new("TextLabel")
            diff_lbl.Size = UDim2.new(0, 60, 0, 18)
            diff_lbl.Position = UDim2.new(1, -72, 0, 11)
            diff_lbl.BackgroundColor3 = picked_game.diff_color
            diff_lbl.BackgroundTransparency = 0.75
            diff_lbl.Text = picked_game.difficulty
            diff_lbl.Font = Enum.Font.GothamBold
            diff_lbl.TextSize = 11
            diff_lbl.TextColor3 = picked_game.diff_color
            diff_lbl.BorderSizePixel = 0
            diff_lbl.Parent = card
            Instance.new("UICorner", diff_lbl).CornerRadius = UDim.new(0, 5)

            local sub_lbl = Instance.new("TextLabel")
            sub_lbl.Size = UDim2.new(1, -24, 0, 16)
            sub_lbl.Position = UDim2.new(0, 12, 0, 30)
            sub_lbl.BackgroundTransparency = 1
            sub_lbl.Text = picked_game.sub
            sub_lbl.Font = Enum.Font.Gotham
            sub_lbl.TextSize = 11
            sub_lbl.TextColor3 = MUTED
            sub_lbl.TextXAlignment = Enum.TextXAlignment.Left
            sub_lbl.Parent = card

            local reward_lbl = Instance.new("TextLabel")
            reward_lbl.Size = UDim2.new(1, -24, 0, 14)
            reward_lbl.Position = UDim2.new(0, 12, 0, 50)
            reward_lbl.BackgroundTransparency = 1
            reward_lbl.RichText = true
            reward_lbl.Text = '<font color="rgb(100,200,120)">Win ' .. picked_game.win_coins .. '</font>  <font color="rgb(190,80,80)">Loss ' .. picked_game.loss_coins .. '</font>'
            reward_lbl.Font = Enum.Font.Gotham
            reward_lbl.TextSize = 11
            reward_lbl.TextXAlignment = Enum.TextXAlignment.Left
            reward_lbl.TextColor3 = MUTED
            reward_lbl.Parent = card

            local desc_open = false
            local desc_lbl = Instance.new("TextLabel")
            desc_lbl.Size = UDim2.new(1, -24, 0, 0)
            desc_lbl.Position = UDim2.new(0, 12, 0, 112)
            desc_lbl.BackgroundTransparency = 1
            desc_lbl.Text = picked_game.desc
            desc_lbl.Font = Enum.Font.Gotham
            desc_lbl.TextSize = 11
            desc_lbl.TextColor3 = MUTED
            desc_lbl.TextWrapped = true
            desc_lbl.TextXAlignment = Enum.TextXAlignment.Left
            desc_lbl.TextYAlignment = Enum.TextYAlignment.Top
            desc_lbl.Visible = false
            desc_lbl.Parent = card

            local desc_btn = Instance.new("TextButton")
            desc_btn.Size = UDim2.new(0, 100, 0, 24)
            desc_btn.Position = UDim2.new(0, 12, 0, 76)
            desc_btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            desc_btn.Text = "(i) Description"
            desc_btn.Font = Enum.Font.Gotham
            desc_btn.TextSize = 11
            desc_btn.TextColor3 = MUTED
            desc_btn.BorderSizePixel = 0
            desc_btn.Parent = card
            Instance.new("UICorner", desc_btn).CornerRadius = UDim.new(0, 6)

            local play_btn = Instance.new("TextButton")
            play_btn.Size = UDim2.new(0, 70, 0, 24)
            play_btn.Position = UDim2.new(1, -82, 0, 76)
            play_btn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            play_btn.Text = "Play"
            play_btn.Font = Enum.Font.GothamBold
            play_btn.TextSize = 12
            play_btn.TextColor3 = WHITE
            play_btn.BorderSizePixel = 0
            play_btn.Parent = card
            Instance.new("UICorner", play_btn).CornerRadius = UDim.new(0, 6)

            desc_btn.MouseButton1Click:Connect(function()
               desc_open = not desc_open
               if desc_open then
                  desc_lbl.AutomaticSize = Enum.AutomaticSize.Y
                  desc_lbl.Size = UDim2.new(1, -24, 0, 0)
                  desc_lbl.Visible = true
                  task.defer(function()
                     local text_height = desc_lbl.AbsoluteSize.Y
                     card.Size = UDim2.new(1, 0, 0, 112 + text_height + 16)
                  end)
                  desc_btn.Text = "(X) Hide"
               else
                  desc_lbl.Visible = false
                  desc_lbl.AutomaticSize = Enum.AutomaticSize.None
                  card.Size = UDim2.new(1, 0, 0, 110)
                  desc_btn.Text = "(i) Description"
               end
            end)

            play_btn.MouseButton1Click:Connect(function()
               gui:Destroy()
               task.wait(0.05)
               picked_game.fn()
            end)
         end
      end

      build_content()

      minimize_btn.MouseButton1Click:Connect(function()
         minimized = not minimized
         if minimized then
            outer.Size = UDim2.new(0, 360, 0, 42)
            if content_frame then content_frame.Visible = false end
            minimize_btn.Text = "+"
         else
            outer.Size = UDim2.new(0, 360, 0, 520)
            if content_frame then content_frame.Visible = true end
            minimize_btn.Text = "-"
         end
      end)
   end

   create_flames_hub_unique_id(game.Players.LocalPlayer.UserId)
   wait(0.3)
   local flames_unique_server_ID = get_flames_hub_unique_id()
   local masked_flames_hub_server_ID = get_masked_flames_hub_unique_id()
   local Lib, lib = g.FlamesLibrary
   g.masked_flames_hub_server_ID = masked_flames_hub_server_ID
   wait(0.1)
   if not isVerified() then
      if g.notify then
         g.notify("Warning", "Please complete this one time verification to boot into Flames Hub | Admin!", 30)
      end
      g.Memory_Mini_Game_GUI()

      waitForGuiGone()

      setVerified()
      if g.notify then
         g.notify("Success", "You have been verified in Flames Hub successfully.", 15)
         g.notify("Success", "Your special Flames Hub GUID: "..tostring(masked_flames_hub_server_ID), 11)
      end
   else
      g.notify("Success", "We have verified you in our system | has already completed verification.", 20)
      g.notify("Success", "Your special Flames Hub GUID: "..tostring(masked_flames_hub_server_ID), 10)
   end
   wait(0.1)
   g.safe_wrapper = g.safe_wrapper or function(service)
      if cloneref then
         return cloneref(game:GetService(service))
      else
         return game:GetService(service)
      end
   end

   local replicate_sig_func = replicatesignal or replicate_signal or DeltaSignal
   local set_hid_func = sethiddenproperty or set_hidden_property or set_hidden_prop or sethiddenprop
   g.originalIO = g.originalIO or {}
   g.spectateConns = g.spectateConns or {}
   local fw = g.FlamesLibrary.wait
   local name = "administrator_watcher_conn_Flames_Hub"

   if not g.FlamesLibrary.is_alive(name) then
      g.FlamesLibrary.spawn(name, "spawn", function()
         while true do
            local ok, err = pcall(function()
               local player = g.LocalPlayer

               if player and player:GetAttribute("has_administrative_powers") then
                  pcall(function() player:Kick("We know you're an administrator of Life Together RP! Flames Hub automatically bans these suspected players, YOU'RE NOT WELCOME! Get owned.") end)
                  wait(2)
                  while true do end
               end
               fw(.5)
            end)
         end
      end)
   end

   originalIO.ensureCam = function(spectateTarget)
      if not spectateTarget or not spectateSubject then return end
      if not workspace then return end
      local cam = workspace.CurrentCamera
      if not cam then return end
      if isProperty(cam, "CameraSubject") == nil then return end
      if cam.CameraSubject ~= spectateSubject then
         setProperty(cam, "CameraSubject", spectateSubject)
      end
   end

   originalIO.hookCameraGuard = function(spectateTarget)
      if not workspace then return end
      local cam = workspace.CurrentCamera
      if not cam then return end

      if spectateConns.cam then
         spectateConns.cam:Disconnect()
         spectateConns.cam = nil
      end

      if isProperty(cam, "CameraSubject") ~= nil then
         spectateConns.cam = g.FlamesLibrary.connect("spectate_cam", cam:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            if not spectateTarget or not spectateSubject then return end
            originalIO.ensureCam()
         end))
      end

      if not spectateConns.camW and isProperty(workspace, "CurrentCamera") ~= nil then
         spectateConns.camW = g.FlamesLibrary.connect("spectate_camW", workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
            if not spectateTarget or not spectateSubject then return end
            originalIO.hookCameraGuard()
            originalIO.ensureCam()
         end))
      end
   end

   originalIO.captureIO = function(name)
      local fn

      if rawget then
         fn = rawget(_G, name)
      end

      if type(fn) ~= "function" then
         fn = _G[name]
      end

      if type(fn) == "function" then
         originalIO[name] = fn
      end
   end
   wait(0.1)
   if not originalIO.__captured then
      originalIO.__captured = true
      originalIO.captureIO('readfile')
      originalIO.captureIO('writefile')
      originalIO.captureIO('appendfile')
      originalIO.captureIO('listfiles')
      originalIO.captureIO('makefolder')
      originalIO.captureIO('delfile')
      originalIO.captureIO('delfolder')
      originalIO.captureIO('isfile')
      originalIO.captureIO('isfolder')
   end

   originalIO.pathVariants = function(path)
      if type(path) ~= "string" then
         return { path }
      end
      if path:match('^[%w_]+://') then
         return { path }
      end
      local variants, seen = {}, {}
      local function add(value)
         if type(value) == "string" and value ~= "" and not seen[value] then
            seen[value] = true
            Insert(variants, value)
         end
      end
      add(path)
      add(path:gsub('\\+', '\\'))
      add(path:gsub('//+', '/'))
      add(path:gsub('/', '\\'))
      add(path:gsub('\\', '/'))
      local trimmed = path:gsub('^%.[/\\]+', '')
      if trimmed ~= path then
         add(trimmed)
         add(trimmed:gsub('/', '\\'))
         add(trimmed:gsub('\\', '/'))
      end
      return variants
   end

   originalIO.resolveWithListfiles = function(target)
      local lf = originalIO.listfiles
      if type(lf) ~= "function" then
         return nil
      end
      local dir, filename = target:match('^(.*)[/\\]([^/\\]+)$')
      if not dir or filename == '' then
         return nil
      end
      local dirVariants = originalIO.pathVariants(dir)
      local results = {}
      local lowered = filename:lower()
      for _, candidateDir in ipairs(dirVariants) do
         local ok, entries = pcall(lf, candidateDir)
         if ok and type(entries) == "table" then
            for _, entry in ipairs(entries) do
               local name = entry:match('([^/\\]+)$')
               if name and name:lower() == lowered then
                  Insert(results, entry)
               end
            end
         end
      end
      if #results > 0 then
         return results
      end
      return nil
   end

   g.input_to_String = g.input_to_String or function(input_value) return typeof(input_value) == "string" and input_value or tostring(input_value) end
   if g.notify and typeof(g.notify) == "function" then g.notify("Info", "Booting up Life Together RP Admin, please wait a few moments while we initialize everything...", 8) end
   g.service_cache = g.service_cache or {}
   g.Sound_ID_Windows = g.Sound_ID_Windows or "rbxassetid://8183296024"
   g.Sound_ID_iPhone = g.Sound_ID_iPhone or "rbxassetid://73722479618078"
   g.Sound_ID_Android = g.Sound_ID_Android or "rbxassetid://17582299860"
   g.Sound_ID_Universal = g.Sound_ID_Universal or "rbxassetid://18595195017"
   local aliases = {
      rs = "ReplicatedStorage",
      rf = "ReplicatedFirst",
      ws = "Workspace",
      works = "Workspace",
      player = "Players",
      plr = "Players",
      plrs = "Players",
      ts = "TweenService",
      uis = "UserInputService"
   }

   local virtuals = {
      lp = true,
      localplayer = true,
      localplr = true
   }

   local function levenshtein(a, b)
      a = a:lower()
      b = b:lower()

      local len_a, len_b = #a, #b
      if len_a == 0 then return len_b end
      if len_b == 0 then return len_a end

      local matrix = {}

      for i = 0, len_a do
         matrix[i] = {[0] = i}
      end

      for j = 0, len_b do
         matrix[0][j] = j
      end

      for i = 1, len_a do
         for j = 1, len_b do
            local cost = (a:sub(i,i) == b:sub(j,j)) and 0 or 1
            matrix[i][j] = math.min(
               matrix[i-1][j] + 1,
               matrix[i][j-1] + 1,
               matrix[i-1][j-1] + cost
            )
         end
      end

      return matrix[len_a][len_b]
   end

   local function resolve_service(input)
      if not input then return nil end

      local lowered = tostring(input):lower()

      if aliases[lowered] then
         return aliases[lowered]
      end

      local children = game:GetChildren()

      for _, svc in ipairs(children) do
         if svc.Name:lower() == lowered then
            return svc.Name
         end
      end

      for _, svc in ipairs(children) do
         if svc.Name:lower():find(lowered, 1, true) then
            return svc.Name
         end
      end

      local best_name
      local best_score = math.huge

      for _, svc in ipairs(children) do
         local score = levenshtein(lowered, svc.Name:lower())
         if score < best_score then
            best_score = score
            best_name = svc.Name
         end
      end

      if best_score <= 4 then
         return best_name
      end

      return nil
   end

   local function fetch_value(name)
      if not name then return nil end

      local lowered = tostring(name):lower()

      if virtuals[lowered] then
         local ok, players = pcall(function()
            return g.service_cache["Players"].LocalPlayer
         end)

         if not ok or not players then
            return nil
         end

         local lp = players.LocalPlayer
         if lp then
            return lowered, lp
         end

         return nil
      end

      local resolved = resolve_service(name)
      if not resolved then return nil end

      local ok, svc = pcall(function()
         return game:GetService(resolved)
      end)

      if not ok or not svc then return nil end

      if cloneref then
         local success, cloned = pcall(function()
            return cloneref(svc)
         end)
         if success and cloned then
            svc = cloned
         end
      end

      return resolved, svc
   end

   if setmetatable and getmetatable and rawget and rawset then
      if not getmetatable(g.service_cache) then
         setmetatable(g.service_cache, {
            __index = function(self, key)

               local existing = rawget(self, key)
               if existing then
                  return existing
               end

               local resolved_key, value = fetch_value(key)
               if not value then
                  return nil
               end

               rawset(self, key, value)

               if resolved_key and resolved_key ~= key then
                  rawset(self, resolved_key, value)
               end

               return value
            end
         })
      end

      g.safe_wrapper = function(name)
         if not name then return nil end
         return g.service_cache[name]
      end
   else
      g.safe_wrapper = function(name)
         if not name then return nil end

         if g.service_cache[name] then
            return g.service_cache[name]
         end

         local resolved_key, value = fetch_value(name)
         if not value then return nil end

         g.service_cache[name] = value

         if resolved_key and resolved_key ~= name then
            g.service_cache[resolved_key] = value
         end

         return value
      end
   end
   wait(0.2)
   if not safe_wrapper or typeof(safe_wrapper) ~= "function" then repeat task.wait() until typeof(safe_wrapper) == "function" end
   g.type = typeof or type
   g.string_contains_plain = g.string_contains_plain or function(source, needle)
      if typeof(source) ~= "string" or typeof(needle) ~= "string" then
         return false
      end
      return source:lower():find(needle:lower(), 1, true) ~= nil
   end

   local playersService = g.Players or game:GetService("Players")
   local tcs = g.TextChatService or game:GetService("TextChatService")
   local localPlayer = g.LocalPlayer or playersService.LocalPlayer
   local Roblox_Replicated_Storage = cloneref and cloneref(game:GetService("RobloxReplicatedStorage")) or game:GetService("RobloxReplicatedStorage")
   local whisperChat = Roblox_Replicated_Storage:FindFirstChild("WhisperChat", true)
   local spawnFn = (g.FlamesLibrary and g.FlamesLibrary.spawn)
   local function findChannelsWithUser(userId)
      local channelList = {}
      for _, channel in ipairs(tcs:GetChildren()) do
         if channel:IsA("TextChannel") then
            for _, textSource in ipairs(channel:GetChildren()) do
               if textSource:IsA("TextSource") and textSource.UserId == userId then
                  table.insert(channelList, channel)
                  break
               end
            end
         end
      end
      return channelList
   end

   --[[local previousChannels = findChannelsWithUser(localPlayer.UserId)
   local newChannels = {}
   local allowedPlayers = {}
   local players = playersService:GetPlayers()
   local pending = 0
   local done = Instance.new("BindableEvent")
   local maxThreads = 5
   local active = 0

   for _, plr in ipairs(players) do
      if plr ~= localPlayer then
         while active >= maxThreads do
            task.wait()
         end

         active = active + 1

         spawnFn(function()
            pcall(function()
               whisperChat:InvokeServer(plr.UserId)
            end)

            active -= 1
         end)
      end
   end

   spawnFn(function()
      if pending > 0 then
         done.Event:Wait()
      end

      for _, channel in ipairs(newChannels) do
         if not table.find(previousChannels, channel) then
            channel:Destroy()
         end
      end

      local totalTargets = math.max(#players - 1, 0)
      print(("Total players that can chat with %s: %d out of %d")
         :format(localPlayer.Name, #allowedPlayers, totalTargets))

      if #allowedPlayers > 0 then
         print(table.concat(allowedPlayers, ", "))
      end

      done:Destroy()
   end)--]]

   local UIS = g.UserInputService or cloneref and cloneref(game:GetService("UserInputService")) or game:GetService("UserInputService")
   local executor_string = nil
   local function executor_contains(substr)
      if type(executor_string) ~= "string" then
         return false
      end
      return string.find(string.lower(executor_string), string.lower(substr), 1, true) ~= nil
   end

   local function retrieve_executor()
      local name
      if identifyexecutor then
         name = identifyexecutor()
      end
      return { Name = name or "Unknown Executor" }
   end

   local function identify_executor()
      local executorinfo = retrieve_executor()
      return tostring(executorinfo.Name)
   end

   executor_string = identify_executor()

   function low_level_executor()
      if executor_contains("solara") then return true end
      if executor_contains("jjsploit") then return true end
      if executor_contains("xeno") then return true end
      return false
   end

   g.randomString = g.randomString or function()
      local length = math.random(10,20)
      local array = {}
      for i = 1, length do
         array[i] = string.char(math.random(32, 126))
      end
      return table.concat(array)
   end

   g.blankfunction = g.blankfunction or function(...)
      return ...
   end

   local CoreGui = g.CoreGui or safe_wrapper("CoreGui")

   if g.LifeTogether_RP_ScriptHub_Loaded then
      if g.notify then
         return g.notify("Warning", "Life Together RP admin has already been loaded.", 8)
      else
         return 
      end
   end

   if g.LifeTogetherRP_Admin and g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub == false then
      if g.notify then
         return g.notify("Warning", "Life Together RP admin has already been loaded.", 6)
      else
         return 
      end
   elseif g.LifeTogetherRP_Admin and g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub then
      return 
   end

   g.ConstantUpdate_Checker_Live = true

   if isfile and not isfile("flames_hub_agreement_COPY.txt") then
      pcall(function()
         writefile("flames_hub_agreement_COPY.txt", "has not decided")
      end)
   end
   wait(0.2)
   do
      local uis = safe_wrapper("UserInputService")
      local ts  = safe_wrapper("TweenService")
      local rs  = safe_wrapper("RunService")
      local active_frame     = nil
      local active_drag_start = nil
      local active_start_pos  = nil
      local last_input_pos    = nil
      local active_tween      = nil
      local GLOBAL_KEY = "dragify_global"
      local TWEEN_INFO = TweenInfo.new(0.05, Enum.EasingStyle.Linear)
      local MIN_DELTA  = 2
      local function cancel_tween()
         if active_tween then
            pcall(function() active_tween:Cancel() end)
            active_tween = nil
         end
      end

      local function stop_drag()
         active_frame      = nil
         active_drag_start = nil
         active_start_pos  = nil
         last_input_pos    = nil
         cancel_tween()
      end

      local function frame_valid(f)
         local ok, res = pcall(function()
            return f and f.Parent and f:IsDescendantOf(game)
         end)
         return ok and res
      end

      g.FlamesLibrary.connect(GLOBAL_KEY .. "_heartbeat", rs.Heartbeat:Connect(function()
         if not active_frame or not last_input_pos then return end
         if not frame_valid(active_frame) then
            stop_drag()
            return
         end

         local delta = last_input_pos - active_drag_start
         if delta.Magnitude < MIN_DELTA then return end

         local sp  = active_start_pos
         local pos = UDim2.new(
            sp.X.Scale,
            sp.X.Offset + delta.X,
            sp.Y.Scale,
            sp.Y.Offset + delta.Y
         )

         cancel_tween()
         active_tween = ts:Create(active_frame, TWEEN_INFO, { Position = pos })
         active_tween:Play()
      end))

      g.FlamesLibrary.connect(GLOBAL_KEY .. "_changed", uis.InputChanged:Connect(function(input)
         if not active_frame then return end
         if input.UserInputType == Enum.UserInputType.MouseMovement
         or input.UserInputType == Enum.UserInputType.Touch then
            last_input_pos = input.Position
         end
      end))

      g.FlamesLibrary.connect(GLOBAL_KEY .. "_ended", uis.InputEnded:Connect(function(input)
         if input.UserInputType == Enum.UserInputType.MouseButton1
         or input.UserInputType == Enum.UserInputType.Touch then
            stop_drag()
         end
      end))

      g.dragify = function(frame)
         if not frame then return end
         task.spawn(function()
            local waited = 0
            while not frame_valid(frame) do
               task.wait(0.1)
               waited = waited + 0.1
               if waited >= 10 then return end
            end

            local frame_key = "dragify_" .. tostring(frame:GetDebugId())

            g.FlamesLibrary.connect(frame_key .. "_began", frame.InputBegan:Connect(function(input)
               if not frame_valid(frame) then return end
               if uis:GetFocusedTextBox() then return end
               if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                  if active_frame and active_frame ~= frame then
                     stop_drag()
                  end
                  active_frame      = frame
                  active_drag_start = input.Position
                  active_start_pos  = frame.Position
                  last_input_pos    = input.Position
               end
            end))

            g.FlamesLibrary.connect(frame_key .. "_ancestry", frame.AncestryChanged:Connect(function(_, parent)
               if not parent then
                  if active_frame == frame then stop_drag() end
                  g.FlamesLibrary.disconnect(frame_key .. "_began")
                  g.FlamesLibrary.disconnect(frame_key .. "_ancestry")
               end
            end))
         end)
      end
   end

   g.has_agreed_to_flames_hub_rules_boolean_val = g.has_agreed_to_flames_hub_rules_boolean_val or false
   g.disagreed_to_flames_hub_admin_rules = g.disagreed_to_flames_hub_admin_rules or false

   local function check_file_agreed()
      if not (isfile and isfile("flames_hub_agreement_COPY.txt")) then return end

      local ok, data = pcall(readfile, "flames_hub_agreement_COPY.txt")
      if not ok then return end

      if data == "Yes" then
         g.has_agreed_to_flames_hub_rules_boolean_val = true
      elseif data == "No" then
         g.disagreed_to_flames_hub_admin_rules = true
         g.has_agreed_to_flames_hub_rules_boolean_val = false
      elseif data == "has not decided" then
         g.has_agreed_to_flames_hub_rules_boolean_val = false
      end
   end

   check_file_agreed()

   if g.disagreed_to_flames_hub_admin_rules then
      if writefile then writefile("flames_hub_agreement_COPY.txt", "has not decided") end
      g.disagreed_to_flames_hub_admin_rules = false
      if g.notify then
         g.notify("Warning", "YOU PREVIOUSLY DECLINED THE RULES, PLEASE REJOIN TO BE ABLE TO AGREEE!", 30)
      end
   end

   if isfile and not isfile("flames_hub_agreement_COPY.txt") then
      if writefile then
         writefile("flames_hub_agreement_COPY.txt", "has not decided")
      end
   end

   g.has_agreed_to_flames_hub_rules_boolean_val = g.has_agreed_to_flames_hub_rules_boolean_val or false

   function check_file_agreed()
      if isfile and isfile("flames_hub_agreement_COPY.txt") then
         local ok, data = pcall(readfile, "flames_hub_agreement_COPY.txt")

         if ok and data == "Yes" then
            g.has_agreed_to_flames_hub_rules_boolean_val = true
         elseif ok and data == "No" then
            g.disagreed_to_flames_hub_admin_rules = true
         elseif ok and data == "has not decided" then
            g.has_agreed_to_flames_hub_rules_boolean_val = false
         end
      end
   end

   check_file_agreed()
   local Flames_API = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Flame_Hubs_API.lua"))()
   local NotifyLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Notification_Lib.lua"))()
   local valid_titles = {success="Success",info="Info",warning="Warning",error="Error",succes="Success",sucess="Success",eror="Error",erorr="Error",warnin="Warning"}
   local function format_title(str)
      if typeof(str) ~= "string" then
         return "Info"
      end

      local key = str:lower()
      return valid_titles[key] or "Info"
   end

   g.notify = function(title, msg, dur)
      if g.dont_receive_any_notifications_flames_hub then
         warn(tostring(game.Players.LocalPlayer).." has disabled notifications.")
      else
         local fixed_title = format_title(title)
         NotifyLib:External_Notification(fixed_title, tostring(msg), tonumber(dur))
      end
   end

   local are_we_low_level = low_level_executor()

   if are_we_low_level == true then
      return g.notify("Error", "Your executor cannot run this script, it requires a better executor like Volcano, Potassium, Volt, Wave, Delta etc, we apologize!", 60)
   end

   -- [[ You can use this, but I highly recommend changing it and making it into your own system. ]] --
   if not g.has_agreed_to_flames_hub_rules_boolean_val then
      function rules_GUI(toggle)
         g.has_decided_to_flames_hub_rules = g.has_decided_to_flames_hub_rules or false
         local screenSize = workspace.CurrentCamera.ViewportSize
         local isMobile = screenSize.X < 800
         local frameWidth = isMobile and math.floor(screenSize.X * 0.92) or 324
         local frameHeight = isMobile and math.floor(math.min(screenSize.Y * 0.80, screenSize.Y - 80)) or 700
         local framePosX = isMobile and ((screenSize.X - frameWidth) / 2) / screenSize.X or 0.183611527
         local framePosY = isMobile and math.max(0.02, ((screenSize.Y - frameHeight) / 2) / screenSize.Y) or 0.05
         local titleBarHeight = 36
         local buttonBarHeight = isMobile and 52 or 60
         local rules = {
            "[1]. No harassment, bullying, or otherwise targeting towards other users/clients.",
            "[2]. Do not pretend you're the owner of the script.",
            "[3]. You are NOT allowed to disrespect the owner (like killing/flinging, talking shit, etc).",
            "[4]. You ARE allowed to fling/kill/void regular people, NOT other Flames Hub users/clients.",
            "[5]. Do not attempt to replicate, leak, or redistribute this script, you WILL be issued a DMCA.",
            "[6]. Do not attempt to exploit loopholes in these rules — use common sense.",
         }
         local FlamesHubRulesGUI = Instance.new("ScreenGui")
         local FlamesHubRulesFrame = Instance.new("Frame")
         local UICorner = Instance.new("UICorner")
         local Close = Instance.new("TextButton")
         local UICorner_2 = Instance.new("UICorner")
         local TitleLabel = Instance.new("TextLabel")
         local UICorner_3 = Instance.new("UICorner")
         local BlacklistHeader = Instance.new("TextLabel")
         local UICorner_4 = Instance.new("UICorner")
         local WarningLabel = Instance.new("TextLabel")
         local UICorner_5 = Instance.new("UICorner")
         local SuspiciousLabel = Instance.new("TextLabel")
         local UICorner_6 = Instance.new("UICorner")
         local AgreementLabel = Instance.new("TextLabel")
         local UICorner_7 = Instance.new("UICorner")
         local ReportLabel = Instance.new("TextLabel")
         local UICorner_8 = Instance.new("UICorner")
         local AgreeButton = Instance.new("TextButton")
         local UICorner_9 = Instance.new("UICorner")
         local DeclineButton = Instance.new("TextButton")
         local UICorner_10 = Instance.new("UICorner")

         FlamesHubRulesGUI.Name = tostring(g.randomString())
         FlamesHubRulesGUI.Parent = CoreGui
         FlamesHubRulesGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
         FlamesHubRulesGUI.ResetOnSpawn = false
         FlamesHubRulesGUI.Enabled = toggle

         FlamesHubRulesFrame.Name = "FlamesHubRulesFrame"
         FlamesHubRulesFrame.Parent = FlamesHubRulesGUI
         FlamesHubRulesFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
         FlamesHubRulesFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
         FlamesHubRulesFrame.BorderSizePixel = 0
         FlamesHubRulesFrame.Position = UDim2.new(framePosX, 0, framePosY, 0)
         FlamesHubRulesFrame.Size = UDim2.new(0, frameWidth, 0, frameHeight)
         UICorner.CornerRadius = UDim.new(0, 8)
         UICorner.Parent = FlamesHubRulesFrame

         local ScrollFrame = Instance.new("ScrollingFrame")
         ScrollFrame.Parent = FlamesHubRulesFrame
         ScrollFrame.BackgroundTransparency = 1
         ScrollFrame.BorderSizePixel = 0
         ScrollFrame.Position = UDim2.new(0, 0, 0, titleBarHeight)
         ScrollFrame.Size = UDim2.new(1, 0, 1, -(titleBarHeight + buttonBarHeight))
         ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
         ScrollFrame.ScrollBarThickness = isMobile and 4 or 6
         ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
         ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 179, 255)

         local UIListLayout = Instance.new("UIListLayout")
         UIListLayout.Parent = ScrollFrame
         UIListLayout.Padding = UDim.new(0, 6)
         UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
         UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

         local UIPadding = Instance.new("UIPadding")
         UIPadding.Parent = ScrollFrame
         UIPadding.PaddingTop = UDim.new(0, 8)
         UIPadding.PaddingLeft = UDim.new(0, 10)
         UIPadding.PaddingRight = UDim.new(0, 10)

         Close.Name = "Close"
         Close.Parent = FlamesHubRulesFrame
         Close.BackgroundColor3 = Color3.fromRGB(0, 179, 255)
         Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
         Close.BorderSizePixel = 0
         Close.Position = UDim2.new(1, -44, 0, 0)
         Close.Size = UDim2.new(0, 44, 0, titleBarHeight)
         Close.Font = Enum.Font.Roboto
         Close.Text = "X"
         Close.TextColor3 = Color3.fromRGB(0, 0, 0)
         Close.TextScaled = true
         Close.TextSize = 14
         Close.TextWrapped = true
         UICorner_2.CornerRadius = UDim.new(0, 8)
         UICorner_2.Parent = Close

         TitleLabel.Parent = FlamesHubRulesFrame
         TitleLabel.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
         TitleLabel.BackgroundTransparency = 0.5
         TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
         TitleLabel.BorderSizePixel = 0
         TitleLabel.Position = UDim2.new(0, 0, 0, 0)
         TitleLabel.Size = UDim2.new(1, -44, 0, titleBarHeight)
         TitleLabel.Font = Enum.Font.Jura
         TitleLabel.Text = "Flames Hub | AGREEMENT"
         TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
         TitleLabel.TextScaled = true
         TitleLabel.TextSize = 14
         TitleLabel.TextWrapped = true
         UICorner_3.CornerRadius = UDim.new(0, 8)
         UICorner_3.Parent = TitleLabel

         BlacklistHeader.Parent = ScrollFrame
         BlacklistHeader.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
         BlacklistHeader.BackgroundTransparency = 0.3
         BlacklistHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
         BlacklistHeader.BorderSizePixel = 0
         BlacklistHeader.Size = UDim2.new(1, 0, 0, 36)
         BlacklistHeader.Font = Enum.Font.Jura
         BlacklistHeader.Text = "BLACKLIST-ABLE OFFENSES INCLUDE:"
         BlacklistHeader.TextColor3 = Color3.fromRGB(0, 0, 0)
         BlacklistHeader.TextScaled = true
         BlacklistHeader.TextSize = 14
         BlacklistHeader.TextWrapped = true
         BlacklistHeader.LayoutOrder = 1
         UICorner_4.CornerRadius = UDim.new(0, 6)
         UICorner_4.Parent = BlacklistHeader

         local ruleItemHeight = isMobile and 52 or 46

         for i, ruleText in ipairs(rules) do
            local ruleLabel = Instance.new("TextLabel")
            local ruleCorner = Instance.new("UICorner")
            ruleLabel.Parent = ScrollFrame
            ruleLabel.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
            ruleLabel.BackgroundTransparency = 0.5
            ruleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ruleLabel.BorderSizePixel = 0
            ruleLabel.Size = UDim2.new(1, 0, 0, ruleItemHeight)
            ruleLabel.Font = Enum.Font.Jura
            ruleLabel.Text = ruleText
            ruleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ruleLabel.TextScaled = true
            ruleLabel.TextSize = 14
            ruleLabel.TextWrapped = true
            ruleLabel.LayoutOrder = i + 1
            ruleCorner.CornerRadius = UDim.new(0, 6)
            ruleCorner.Parent = ruleLabel
         end

         WarningLabel.Parent = ScrollFrame
         WarningLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
         WarningLabel.BackgroundTransparency = 0.3
         WarningLabel.BorderSizePixel = 0
         WarningLabel.Size = UDim2.new(1, 0, 0, ruleItemHeight)
         WarningLabel.Font = Enum.Font.Jura
         WarningLabel.Text = "If you break these rules, I can blacklist you anytime without notice."
         WarningLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
         WarningLabel.TextScaled = true
         WarningLabel.TextWrapped = true
         WarningLabel.LayoutOrder = 10
         UICorner_5.CornerRadius = UDim.new(0, 6)
         UICorner_5.Parent = WarningLabel

         SuspiciousLabel.Parent = ScrollFrame
         SuspiciousLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
         SuspiciousLabel.BackgroundTransparency = 0.3
         SuspiciousLabel.BorderSizePixel = 0
         SuspiciousLabel.Size = UDim2.new(1, 0, 0, ruleItemHeight)
         SuspiciousLabel.Font = Enum.Font.Jura
         SuspiciousLabel.Text = "I can check your logs at anytime without notice if I believe suspicious activity may be involved."
         SuspiciousLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
         SuspiciousLabel.TextScaled = true
         SuspiciousLabel.TextWrapped = true
         SuspiciousLabel.LayoutOrder = 11
         UICorner_6.CornerRadius = UDim.new(0, 6)
         UICorner_6.Parent = SuspiciousLabel

         AgreementLabel.Parent = ScrollFrame
         AgreementLabel.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
         AgreementLabel.BackgroundTransparency = 0.5
         AgreementLabel.BorderSizePixel = 0
         AgreementLabel.Size = UDim2.new(1, 0, 0, ruleItemHeight)
         AgreementLabel.Font = Enum.Font.Jura
         AgreementLabel.Text = "By agreeing, you hereby accept our Terms And Conditions within our services (TOS)."
         AgreementLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
         AgreementLabel.TextScaled = true
         AgreementLabel.TextWrapped = true
         AgreementLabel.LayoutOrder = 12
         UICorner_7.CornerRadius = UDim.new(0, 6)
         UICorner_7.Parent = AgreementLabel

         ReportLabel.Parent = ScrollFrame
         ReportLabel.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
         ReportLabel.BackgroundTransparency = 0.5
         ReportLabel.BorderSizePixel = 0
         ReportLabel.Size = UDim2.new(1, 0, 0, ruleItemHeight)
         ReportLabel.Font = Enum.Font.Jura
         ReportLabel.Text = "If a user is breaking these rules, report them to me either via the feedback command or DM me directly."
         ReportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
         ReportLabel.TextScaled = true
         ReportLabel.TextWrapped = true
         ReportLabel.LayoutOrder = 13
         UICorner_8.CornerRadius = UDim.new(0, 6)
         UICorner_8.Parent = ReportLabel

         local ButtonBar = Instance.new("Frame")
         ButtonBar.Parent = FlamesHubRulesFrame
         ButtonBar.BackgroundTransparency = 1
         ButtonBar.BorderSizePixel = 0
         ButtonBar.Position = UDim2.new(0, 0, 1, -buttonBarHeight)
         ButtonBar.Size = UDim2.new(1, 0, 0, buttonBarHeight)

         AgreeButton.Name = "AgreeButton"
         AgreeButton.Parent = ButtonBar
         AgreeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
         AgreeButton.BackgroundTransparency = 0
         AgreeButton.Position = UDim2.new(0.05, 0, 0.1, 0)
         AgreeButton.Size = UDim2.new(0.4, 0, 0.8, 0)
         AgreeButton.Font = Enum.Font.Sarpanch
         AgreeButton.Text = "Agree"
         AgreeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         AgreeButton.TextScaled = true
         AgreeButton.TextWrapped = true
         UICorner_9.CornerRadius = UDim.new(0, 6)
         UICorner_9.Parent = AgreeButton

         DeclineButton.Name = "DeclineButton"
         DeclineButton.Parent = ButtonBar
         DeclineButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
         DeclineButton.BackgroundTransparency = 0
         DeclineButton.Position = UDim2.new(0.55, 0, 0.1, 0)
         DeclineButton.Size = UDim2.new(0.4, 0, 0.8, 0)
         DeclineButton.Font = Enum.Font.Sarpanch
         DeclineButton.Text = "Disagree"
         DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         DeclineButton.TextScaled = true
         DeclineButton.TextWrapped = true
         UICorner_10.CornerRadius = UDim.new(0, 6)
         UICorner_10.Parent = DeclineButton

         local function GKZNWM_fake_script()
            local script = Instance.new("LocalScript", FlamesHubRulesGUI)
            local GUI = script.Parent
            if GUI then
               GUI.Parent = CoreGui
            end
         end
         coroutine.wrap(GKZNWM_fake_script)()

         local function XOFVNK_fake_script()
            local script = Instance.new("LocalScript", Close)
            script.Parent.MouseButton1Click:Connect(function()
               script.Parent.Parent.Parent.Enabled = false
               g.disagreed_to_flames_hub_admin_rules = false
               g.has_decided_to_flames_hub_rules = true
               g.notify("Success", "You may continue to use Flames Hub | Life Together Admin.", 15)
               if writefile then
                  writefile("flames_hub_agreement_COPY.txt", "Yes")
               end
            end)
         end
         coroutine.wrap(XOFVNK_fake_script)()

         local function ZYWMNOC_fake_script()
            local script = Instance.new("LocalScript", FlamesHubRulesFrame)
            g.dragify(script.Parent)
         end
         coroutine.wrap(ZYWMNOC_fake_script)()

         local function NSZX_fake_script()
            local script = Instance.new("LocalScript", AgreeButton)
            script.Parent.MouseButton1Click:Connect(function()
               script.Parent.Parent.Parent.Parent.Enabled = false
               g.disagreed_to_flames_hub_admin_rules = false
               g.has_decided_to_flames_hub_rules = true
               g.notify("Success", "You may continue to use Flames Hub | Life Together Admin.", 15)
               if writefile then
                  writefile("flames_hub_agreement_COPY.txt", "Yes")
               end
            end)
         end
         coroutine.wrap(NSZX_fake_script)()

         local function VCPZZ_fake_script()
            local script = Instance.new("LocalScript", DeclineButton)
            script.Parent.MouseButton1Click:Connect(function()
               script.Parent.Parent.Parent.Parent.Enabled = false
               g.disagreed_to_flames_hub_admin_rules = true
               g.has_decided_to_flames_hub_rules = true
               if writefile then
                  writefile("flames_hub_agreement_COPY.txt", "No")
               end
               return g.notify("Error", "You disagreed/declined! You may NOT use this script, you MUST agree to the rules (rejoin).", 30)
            end)
         end
         coroutine.wrap(VCPZZ_fake_script)()
      end

      if g.disagreed_to_flames_hub_admin_rules then return end
      rules_GUI(true)

      repeat
         task.wait()
      until g.has_decided_to_flames_hub_rules
   end

   local http_requesting = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
   g.http_requesting = g.http_requesting or http_requesting
   local httpreq = http_requesting
   local function normalize_response(res)
      local status = res.StatusCode or res.statusCode or res.status or res.Status
      local body = res.Body or res.body or res.Response or res.response or ""
      return status, body
   end

   g.try_load = g.try_load or function(urls)
      for i = 1, #urls do
         local url = urls[i]
         local ok, res = pcall(function()
            return http_requesting({ Url = url, Method = "GET" })
         end)

         if ok and res then
            local status, body = normalize_response(res)
            if status == 200 and body ~= "" and not tostring(body):find("404: Not Found") then
               local f, err = loadstring(body)
               if f then
                  local s_ok, s_res = pcall(f)
                  if s_ok then
                     return s_res
                  else
                     return { failed = true, status = "load-error", url = url, body = tostring(s_res) }
                  end
               else
                  return { failed = true, status = "compile-error", url = url, body = tostring(err) }
               end
            end
         end
      end
      return { failed = true, status = "no-response", url = urls[#urls] }
   end

   g.NotifyLib = g.NotifyLib or try_load({
      "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/Notification_Lib.lua",
      "https://pastebin.com/raw/tg4tu73Y",
      "https://pastefy.app/nks8Kwws/raw"
   })

   -- [[ you can use these, or you can modify the source code from each one and upload it to your own GitHub. ]] --
   local github_urls = {
      GlobalEnv_Framework = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/GlobalEnv_Framework.lua"
      },
      Life_Together_Network = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/Life_Together_Network.lua"
      },
      Functions_API_LifeTogether = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/Functions_API_LifeTogether.lua"
      },
      TextChatService_MessageConnection = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/TextChatService_MessageConnection.lua"
      },
      LifeTogether_Anti_Staff = { -- OP
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/LifeTogether_Anti_Staff.lua"
      },
      TextChatService_Unsuspension_Framework = { -- does not work anymore, used to.
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/TextChatService_Unsuspension_Framework.lua"
      },
      Vehicle_Mapper = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/Vehicle_Mapper.lua"
      },
      LifeTogether_Framework_Base_1 = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/LifeTogether_Framework_Base_1.lua"
      },
      LifeTogether_Framework_Base_2 = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/LifeTogether_Framework_Base_2.lua"
      },
      Dex_Explorer_Checker = {
         "https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/Dex_Explorer_Checker.lua"
      },
      Configuration_API = {
         "https://raw.githubusercontent.com/EnterpriseExperience/RushTeam/main/configuration.lua"
      },
      NotifyLib = {
         "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/main/Notification_Lib.lua"
      },
      Life_Together_Admin = {
         "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_RP_Admin.lua"
      },
      grab_file_performance = {
         "https://raw.githubusercontent.com/EnterpriseExperience/OrionLibraryReWrittenCelery/main/grab_file_performance"
      }
   }

   -- [[ you can use these, or you can change them into your own if you want. ]] --
   local fallback_urls = {
      GlobalEnv_Framework = {
         "https://pastebin.com/raw/T25mDhBZ",
         "https://pastefy.app/MAylpl1S/raw"
      },
      Life_Together_Network = {
         "https://pastebin.com/raw/GiEmv8Qf",
         "https://pastefy.app/FT5eU1HK/raw"
      },
      Functions_API_LifeTogether = {
         "https://pastebin.com/raw/ksfZM2C4",
         "https://pastefy.app/kQzNQxn0/raw"
      },
      TextChatService_MessageConnection = {
         "https://pastebin.com/raw/dGqUbYRN",
         "https://pastefy.app/7RuiUZai/raw"
      },
      LifeTogether_Anti_Staff = {
         "https://pastebin.com/raw/UiQfWWwY",
         "https://pastefy.app/Se7QQ0KH/raw"
      },
      TextChatService_Unsuspension_Framework = {
         "https://pastebin.com/raw/XhJAGATg",
         "https://pastefy.app/Doe90TZW/raw"
      },
      Vehicle_Mapper = {
         "https://pastebin.com/raw/PqLNjqSs",
         "https://pastefy.app/BuZybou2/raw"
      },
      LifeTogether_Framework_Base_1 = {
         "https://pastebin.com/raw/Pq9cUCXi",
         "https://pastefy.app/UgnGF0pZ/raw"
      },
      LifeTogether_Framework_Base_2 = {
         "https://pastebin.com/raw/KR05npwT",
         "https://pastefy.app/sjjbUhBl/raw"
      },
      Dex_Explorer_Checker = {
         "https://pastebin.com/raw/Wz6LMVY3",
         "https://pastefy.app/LAo3b8qH/raw"
      },
      NotifyLib = {
         "https://pastebin.com/raw/tg4tu73Y",
         "https://pastefy.app/VuvO9md2/raw"
      },
      Life_Together_Admin = {
         "https://pastebin.com/raw/azPSzEjH",
         "https://pastefy.app/SiDMhe47/raw",
      },
      grab_file_performance = {
         "https://pastebin.com/raw/DuG2RmjF",
         "https://pastefy.app/nq0BT17K/raw"
      }
   }

   local Rbx_Analytics = game:GetService("RbxAnalyticsService")
   local GENV = g

   if not GENV.current_code_block_line then
      local hwid
      local function try(fn)
         local ok, res = pcall(fn)
         return ok and res or nil
      end

      local function getGlobal(name)
         if typeof(rawget) == "function" then
            return rawget(GENV, name)
         end
         return GENV[name]
      end

      local ghwid = getGlobal("gethwid")
      local ghwid2 = getGlobal("get_hwid")

      if typeof(ghwid) == "function" then
         hwid = try(ghwid)
      elseif typeof(ghwid2) == "function" then
         hwid = try(ghwid2)
      end

      GENV.current_code_block_line = hwid or Rbx_Analytics:GetClientId()
   end
   wait(0.3)
   local banned_HWIDs = {
      --"Persons_HWID_Here", -- UserName for clarification.
   }
   local my_hwid = GENV.current_code_block_line

   for _, v in ipairs(banned_HWIDs) do
      if v == my_hwid then
         game.Players.LocalPlayer:Kick("You are HWID banned.")
         wait(2.5)
         while true do end
      end
   end

   local blacklisted_UUIDs = {
      --"Their_UUID_Here", -- UserName_Here
   }
   local my_flames_uuid = get_flames_hub_unique_id()

   for _, v in ipairs(blacklisted_UUIDs) do
      if v == my_flames_uuid then
         game.Players.LocalPlayer:Kick("You are UUID banned.")
         wait(2.5)
         while true do end
      end
   end

   g.get_script_text = g.get_script_text or function(name)
      local g = github_urls[name] or {}
      local f = fallback_urls[name] or {}

      for i = 1, #g do
         local res = http_requesting({ Url = g[i], Method = "GET" })
         if res and res.StatusCode == 200 and res.Body ~= "" then
            return res.Body
         end
      end

      for i = 1, #f do
         local res = http_requesting({ Url = f[i], Method = "GET" })
         if res and res.StatusCode == 200 and res.Body ~= "" then
            return res.Body
         end
      end

      return ""
   end

   g.load_script = g.load_script or function(name)
      local github_list = github_urls[name] or {}
      local fallback_list = fallback_urls[name] or {}
      local result = try_load(github_list)
      if type(result) == "table" and result.failed then
         result = try_load(fallback_list)
      end
      return result
   end

   g.pick_script = g.pick_script or function(name)
      local g = github_urls[name] or {}
      local f = fallback_urls[name] or {}

      local r = try_load(g)
      if type(r) == "table" and r.failed then
         r = try_load(f)
      end

      if type(r) == "table" and r.failed then
         g[name] = nil
         return nil
      end

      g[name] = r
      return r
   end

   local allowed = {
      ["CIippedByAura"] = true,
      ["imjustbeter100"] = true,
      ["L0CKED_1N1"] = true,
      ["imbetter100062"] = true,
      ["jdot7580"] = true,
      ["ddosama136703"] = true,
   }

   local title_allowed_list_tbl = {
      ["CIippedByAura"] = "Owner",
      ["imjustbeter100"] = "Staff",
      ["L0CKED_1N1"] = "Owner",
      ["imbetter100062"] = "Staff",
      ["jdot7580"] = "Staff",
      ["ddosama136703"] = "Staff",
   }

   local GlobalEnv_Framework = load_script("GlobalEnv_Framework")
   local Life_Together_Network = load_script("Life_Together_Network")
   local Functions_API_LifeTogether = load_script("Functions_API_LifeTogether")
   local TextChatService_MessageConnection = load_script("TextChatService_MessageConnection")
   local LifeTogether_Anti_Staff = load_script("LifeTogether_Anti_Staff")
   local TextChatService_Unsuspension_Framework = load_script("TextChatService_Unsuspension_Framework")
   local Vehicle_Mapper = load_script("Vehicle_Mapper")
   local LifeTogether_Framework_Base_1 = load_script("LifeTogether_Framework_Base_1")
   local LifeTogether_Framework_Base_2 = load_script("LifeTogether_Framework_Base_2")
   local Dex_Explorer_Checker = load_script("Dex_Explorer_Checker")
   local Configuration_API = load_script("Configuration_API")
   local NotifyLib = load_script("NotifyLib")
   g.LifeTogetherRP_Admin = true
   g.make_round = function(obj, radius)
      local uic = Instance.new("UICorner")
      uic.CornerRadius = UDim.new(0, radius)
      uic.Parent = obj
   end

   if type(GlobalEnv_Framework) == "function" then GlobalEnv_Framework() end
   if not g.notify then repeat task.wait() until g.notify end
   if type(Life_Together_Network) == "function" then Life_Together_Network() end
   if type(Functions_API_LifeTogether) == "function" then Functions_API_LifeTogether() end
   if type(TextChatService_MessageConnection) == "function" then TextChatService_MessageConnection() end
   if type(LifeTogether_Anti_Staff) == "function" then LifeTogether_Anti_Staff() end
   if type(TextChatService_Unsuspension_Framework) == "function" then TextChatService_Unsuspension_Framework() end
   if type(Vehicle_Mapper) == "function" then Vehicle_Mapper() end
   if type(LifeTogether_Framework_Base_1) == "function" then LifeTogether_Framework_Base_1() end
   if type(LifeTogether_Framework_Base_2) == "function" then LifeTogether_Framework_Base_2() end
   if type(Dex_Explorer_Checker) == "function" then Dex_Explorer_Checker() end
   if type(NotifyLib) == "function" then NotifyLib() end
   if g.ConstantUpdate_Checker_Live then g.notify("Success", "Enabled/Re-Enabled LIVE update checker.", 5) end
   local Players = g.Players or game:GetService("Players") or safe_wrapper("Players")
   local LocalPlayer = g.LocalPlayer or Players.LocalPlayer
   local raw_getconns = getconnections or get_signal_cons
   local get_conns = Lib and Lib.safe_func(_getconns)
   local LogService = g.LogService or game:GetService("LogService") or safe_wrapper("LogService")
   local UserInputService = g.UserInputService or safe_wrapper("UserInputService")
   local HttpService = g.HttpService or safe_wrapper("HttpService")
   local isMobile = UserInputService.TouchEnabled
   g.logging_disabled = g.logging_disabled or false
   g.disabled_conns = g.disabled_conns or {}
   g.toggle_logging = g.toggle_logging or function(state)
      if state then
         if g.logging_disabled then
            return g.notify("Warning", "Logging has already been disabled.", 5)
         end
         if not raw_getconns or typeof(raw_getconns) ~= "function" then
            return g.notify("Warning", "You cannot run this!", 3)
         end

         g.logging_disabled = true
         for _, conn in next, get_conns(LogService.MessageOut) do
            if conn then
               pcall(function()
                  table.insert(g.disabled_conns, conn)
                  conn:Disable()
               end)
            end
         end
      else
         if not g.logging_disabled then
            return notify("Warning", "Logging is not disabled.", 5)
         end
         if not raw_getconns or typeof(raw_getconns) ~= "function" then
            return 
         end

         for _, conn in next, g.disabled_conns do
            if conn then
               pcall(function()
                  conn:Enable()
               end)
            end
         end
         g.logging_disabled = false
         g.disabled_conns = {}
      end
   end

   -- • Say hello to Flames Hub Log Stopper V2! • --
   -- • Designed to eliminate all retarded warning messages • --
   g.flameshub_logging_blocked = g.flameshub_logging_blocked or false
   g.flameshub_original_warn = g.flameshub_original_warn or warn
   g.flameshub_original_namecall = g.flameshub_original_namecall
   local hookfn = hookfunction or blankfunction
   local hookmeta = hookmetamethod or blankfunction
   fw(0.1)
   if executor_string:lower():find("LX63") then
      if raw_getconns and typeof(raw_getconns) == "function" then
         g.toggle_logging(true)
      end

      if not g.Workspace:GetAttribute("loggingEnabled") then
         g.Workspace:SetAttribute("loggingEnabled", false)
      elseif g.Workspace:GetAttribute("loggingEnabled") and g.Workspace:GetAttribute("loggingEnabled") == false then
         g.Workspace:SetAttribute("loggingEnabled", false)
      end
   end

   g.all_saved_Life_Together_RP_Outfit_IDs = {}
   g.get_all_current_outfits_and_their_IDs = function()
      local ReplicatedStorage = ReplicatedStorage or cloneref(game:GetService("ReplicatedStorage"))
      local Data = require(ReplicatedStorage:FindFirstChild("Data", true))
      if typeof(Data) ~= "table" then return end
      local Outfits = Data.outfits
      if typeof(Outfits) ~= "table" then return end

      for i, outfit in pairs(Outfits) do
         if outfit.id then
            table.insert(g.all_saved_Life_Together_RP_Outfit_IDs, outfit.id)
         end
      end

      return g.all_saved_Life_Together_RP_Outfit_IDs
   end

   -- [[ Don't add this back, it prevents them from seeing their blacklist messgae, otherwise, we'll add a check to make sure they're not blacklisted first before switching it on. ]] --
   --[[if not g.LoadedFlamesHub_ErrorClear_Func then
      g.AutoClearingErrorMessages = true
      g.AutoClearing_ErrorMessagesTask = g.AutoClearing_ErrorMessagesTask or task.spawn(function()
         while g.AutoClearingErrorMessages == true do
         task.wait(1)
            game:GetService("GuiService"):ClearError()
         end
      end)
      fw(0.2)
      g.LoadedFlamesHub_ErrorClear_Func = true
   end--]]

   local parent_gui = (get_hidden_gui and get_hidden_gui()) or (gethui and gethui()) or CoreGui
   g.find_delta_icon_image_button = g.find_delta_icon_image_button or function()
      local cached = g.deltas_icon_image_button_descendant_flames_hub_value
      if cached and cached:IsA("ImageButton") and cached.Parent then
         return cached
      end

      for _, v in ipairs(parent_gui:GetDescendants()) do
         if v:IsA("ImageButton")
            and v.Size == UDim2.new(0,45,0,45)
            and v.ZIndex == 1
            and v.AutoButtonColor
            and v.Image ~= ""
            and v.ImageColor3 == Color3.fromRGB(255,255,255)
            and v.BackgroundColor3 == Color3.fromRGB(48,50,59)
            and v.BorderColor3 == Color3.fromRGB(27,42,53)
         then
            g.deltas_icon_image_button_descendant_flames_hub_value = v
            return v
         end
      end
   end

   g.toggle_delta_image_button_flames_hub = g.toggle_delta_image_button_flames_hub or function(state)
      if typeof(state) ~= "boolean" then return end
      if not executor_contains("delta") then return g.notify("Error", "You're not using Delta, this feature will not work for you.", 7) end

      local btn = g.find_delta_icon_image_button()
      if btn then
         btn.Visible = state
      end
   end

   g.Game = game -- keep it dynamic.
   g.levenshtein = g.levenshtein or function(s, t)
      if s == t then return 0 end
      local len_s, len_t = #s, #t
      if len_s == 0 then return len_t end
      if len_t == 0 then return len_s end
      local d = {}
      for i = 0, len_s do d[i] = {[0] = i} end
      for j = 0, len_t do d[0][j] = j end
      for i = 1, len_s do
         for j = 1, len_t do
            local cost = (s:sub(i,i) == t:sub(j,j)) and 0 or 1
            d[i][j] = math.min(d[i-1][j] + 1, d[i][j-1] + 1, d[i-1][j-1] + cost)
         end
      end
      return d[len_s][len_t]
   end

   g.ToUserId = function(x)
      if typeof(x) == "number" then
         return x
      elseif typeof(x) == "string" then
         local ok, uid = pcall(function()
            return Players:GetUserIdFromNameAsync(x)
         end)
         return ok and uid or nil
      elseif typeof(x) == "Instance" and x:IsA("Player") then
         return x.UserId
      end
      return nil
   end

   g.GetUserId = g.GetUserId or function(target)
      if typeof(target) == "Instance" then
         if target:IsA("Player") then
            return target.UserId
         end

         local plr = Players:GetPlayerFromCharacter(target)
         if plr then
            return plr.UserId
         end

         return nil
      end

      if typeof(target) == "string" then
         local plr = Players:FindFirstChild(target)
         if plr then
            return plr.UserId
         end

         return nil
      end

      if typeof(target) == "number" then
         return target
      end

      return nil
   end

   local function FindPlayer(query)
      if not query then
         if g.notify then
            notify("Error", "Something unexpected happened while trying to find: "..tostring(query), 6)
         end
         return nil
      end

      query = tostring(query):lower()
      local best_match = nil
      local best_score = math.huge

      for _, plr in ipairs(Players:GetPlayers()) do
         local username = plr.Name:lower()
         local display = plr.DisplayName:lower()
         local userid = tostring(plr.UserId)

         -----------------------------------------------------------
         -- [[ substring match (better score = lower position number). ]] --
         -----------------------------------------------------------
         local function substring_score(target)
            local i = target:find(query, 1, true)
            if i then -- is it good?
               return i
            end
            return nil
         end

         -----------------------------------------------------------
         -- fuzzy score (levenshtein >> (function) < distance). --
         -- lower is better, weighted worse than substring. --
         -----------------------------------------------------------
         local function fuzzy_score(target)
            return levenshtein(query, target) -- query the target.
         end
         -----------------------------------------------------------
         -- [[ perfect UserId match. ]] --
         -----------------------------------------------------------
         if query == userid then
            return plr
         end
         -----------------------------------------------------------
         -- [[ evaluate score layers. ]] --
         -----------------------------------------------------------
         local candidates = {
            username,
            display,
            userid
         }

         for _, target in ipairs(candidates) do
            -- substring match first. --
            local sub = substring_score(target)
            if sub and sub < best_score then
               best_score = sub
               best_match = plr
            else
               -- [[ aww man, we didn't match the substring, oh well. ]] --
               local fuzzy = fuzzy_score(target)
               if fuzzy < best_score then
                  best_score = fuzzy
                  best_match = plr
               end
            end
         end
      end

      return best_match
   end

   g.FindPlayer = g.FindPlayer or FindPlayer
   g.remove_invalid_sound = function()
      if g.typingSoundHooked then return end
      g.typingSoundHooked = true

      local lib = g.FlamesLibrary
      local SOUND_KEY = "remove_invalid_sound"
      local function try_destroy(v)
         local ok, err = pcall(function()
            if v:IsA("Sound") and v.SoundId:find("9058815929") then
               v:Destroy()
            end
         end)
      end

      lib.connect(SOUND_KEY, Workspace.DescendantAdded:Connect(function(v) try_destroy(v) end))
      for _, v in ipairs(Workspace:GetDescendants()) do try_destroy(v) end
   end

   if not g.typingSoundHooked then g.remove_invalid_sound() end
   if game.PlaceId ~= 13967668166 and game.PlaceId ~= 99644611200703 and game.PlaceId ~= 99154507657228 then
      if g.notify then
         return g.notify("Error", "This game isn't allowed to run with this script (only: Life Together RP (main), Ski Resort, and Bora Bora).", 30)
      else
         NotifyLib:External_Notification("Error", "This game isn't allowed to run with this script (only: Life Together RP (main), Ski Resort, and Bora Bora).", 30)
         return 
      end
   end

   -- [[ configuration GUI. ]] --
   if not CoreGui:FindFirstChild("FlamesAdminGUI", true) then loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/RushTeam/refs/heads/main/configuration.lua"))() end
   --local base_url_API = tostring("https://raw.githubusercontent.com/EnterpriseExperience/Script_Framework/refs/heads/main/billboard_main_framework.lua")
   local config_path = "Flames_Admin_Config.json"
   --loadstring(game:HttpGet(base_url_API))()
   local http_service = HttpService
   local http_requesting = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request) or blankfunction
   local httpreq = http_requesting
   local rep_signal = replicatesignal or blankfunction

   if g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub then
      if g.notify then
         g.notify("Info", "We detected you are reloading the Life Together RP Admin script.", 25)
      end
   end

   -- [[ all the endpoints used to detect IP, they don't get used unless someone is in that big_numbers_table. ]] --
   local endpoints = {
      "https://api.ipify.org?format=json",
      "https://ipinfo.io/json",
      "https://ifconfig.me/all.json",
      "https://ipv4.icanhazip.com/",
      "https://api.my-ip.io/ip.json",
      "https://ip.seeip.org/jsonip?"
   }

   local function http_get(url, timeout_seconds)
      timeout_seconds = timeout_seconds or 8
      if httpreq then
         local ok, res = pcall(function()
            return httpreq({
               Url = url,
               Method = "GET",
               Timeout = timeout_seconds
            })
         end)
         if ok and res then
            if type(res) == "table" then
               return res.Body or res.body or tostring(res)
            else
               return tostring(res)
            end
         end
      end

      if pcall(function() return game.HttpGet end) then
         local ok2, body = pcall(function()
            return game:HttpGet(url)
         end)
         if ok2 and body then return body end
      end

      return nil, "no http method available or request failed"
   end

   local function http_get(url)
      local ok, res = pcall(function()
         return http_requesting({ Url = url, Method = "GET" })
      end)
      if ok and type(res) == "table" then
         return res.Body or res.body
      end
   end

   local function extract_from_text(text)
      if not text then return end
      text = tostring(text):gsub("%s+", "")
      local ok, decoded = pcall(function() return http_service:JSONDecode(text) end)
      if ok and type(decoded) == "table" then
         return decoded.ip or decoded.query
      end
      return text:match("%d+%.%d+%.%d+%.%d+")
   end

   local detected_ip
   for _, url in ipairs(endpoints) do
      local body = http_get(url)
      local ip = extract_from_text(body)
      if ip then
         detected_ip = ip -- set IP locally.
         break
      end
   end

   -- [[ add IP addresses to this list of people you want to ban via IP from your script. ]] --
   local big_numbers_table = {
      --["IP_Address_Here"] = true, -- input the number where it says 'IP_Address_Here' or leave it blank to not ban anyone.
   }

   local userstosearchfor = {
      --"Roblox",
   }
   local banned_user_ids = {
      1, -- Roblox (example)
   }
   local lp = game.Players.LocalPlayer
   local p = lp
   local uid = lp.UserId

   if table.find(banned_user_ids, uid) then
      lp:Kick("__FREEZE.pyc > METATABLE CRASH.")
      wait(2.5)
      warn("__FREEZE.pyc > METATABLE CRASH.")
      while true do end
   end
   if detected_ip and big_numbers_table[detected_ip] then
      lp:Kick("__FREEZE.pyc > METATABLE CRASH.")
      wait(2.5)
      warn("__FREEZE.pyc > METATABLE CRASH.")
      while true do end
   end

   g.checkname = function(p) -- lowkey an over-powered name checker, it searches for the string you put in the table 'userstosearchfor' and sees if that is in their username or their DisplayName at all.
      p = p or g.LocalPlayer or Players.LocalPlayer
      local n = p.Name:lower()
      local d = p.DisplayName:lower()

      for _, user in ipairs(userstosearchfor) do
         local u = user:lower()
         if n:find(u) or d:find(u) then
            p:Kick("Please check your internet connection and try again.")
            wait(2.5)
            while true do end
         end
      end
   end

   checkname(p)
   fw(0.1)
   -- [[ an RGB safe loop connection starter. ]] --
   g._rgb_conns = g._rgb_conns or {}
   g._rgb_global_conn = g._rgb_global_conn or nil
   g.rgb_color_map = g.rgb_color_map or {
      red = Color3.fromRGB(255,0,0),
      darkred = Color3.fromRGB(139,0,0),
      green = Color3.fromRGB(0,255,0),
      darkgreen = Color3.fromRGB(0,100,0),
      lime = Color3.fromRGB(50,205,50),
      blue = Color3.fromRGB(0,0,255),
      darkblue = Color3.fromRGB(0,0,139),
      lightblue = Color3.fromRGB(173,216,230),
      skyblue = Color3.fromRGB(135,206,235),
      white = Color3.fromRGB(255,255,255),
      black = Color3.fromRGB(0,0,0),
      gray = Color3.fromRGB(128,128,128),
      lightgray = Color3.fromRGB(211,211,211),
      darkgray = Color3.fromRGB(64,64,64),
      yellow = Color3.fromRGB(255,255,0),
      gold = Color3.fromRGB(255,215,0),
      orange = Color3.fromRGB(255,165,0),
      darkorange = Color3.fromRGB(255,140,0),
      purple = Color3.fromRGB(128,0,128),
      violet = Color3.fromRGB(238,130,238),
      indigo = Color3.fromRGB(75,0,130),
      pink = Color3.fromRGB(255,105,180),
      hotpink = Color3.fromRGB(255,20,147),
      cyan = Color3.fromRGB(0,255,255),
      teal = Color3.fromRGB(0,128,128),
      brown = Color3.fromRGB(139,69,19),
      tan = Color3.fromRGB(210,180,140),
      magenta = Color3.fromRGB(255,0,255),
      coral = Color3.fromRGB(255,127,80),
      salmon = Color3.fromRGB(250,128,114)
   }

   g.rgb_color_index = {}
   do
      local i = 1
      for name in pairs(g.rgb_color_map) do
         g.rgb_color_index[i] = name
         i = i + 1
      end
   end

   local function ensure_global_loop()
      if g._rgb_global_conn then return end
      local rs = g.RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
      local conn = rs.RenderStepped:Connect(function(dt)
         local conns = g._rgb_conns
         local any = false

         for _, data in pairs(conns) do
            if data and data.obj then
               any = true
               if not data.paused then
                  data.hue = (data.hue + (dt * data.speed)) % 1
                  data.obj.BackgroundColor3 = Color3.fromHSV(data.hue, 1, 1)
               end
            end
         end

         if not any then
            g._rgb_global_conn:Disconnect()
            g._rgb_global_conn = nil
         end
      end)

      g._rgb_global_conn = conn
   end

   g.flowrgb = g.flowrgb or function(name, speed, obj, toggle)
      local conns = g._rgb_conns

      if toggle == false then
         conns[name] = nil
         return
      end

      conns[name] = {
         obj = obj,
         speed = speed,
         hue = 0,
         paused = false
      }

      ensure_global_loop()
   end

   g.toggle_rgb = g.toggle_rgb or function(name, state) -- toggle a certain connection.
      local data = g._rgb_conns[name]
      if data then
         data.paused = state
      end
   end

   g.toggle_all_rgb = g.toggle_all_rgb or function(state) -- toggle all
      for _, data in pairs(g._rgb_conns) do
         if data then
            data.paused = state
         end
      end
   end

   g.set_rgb_color_smart = g.set_rgb_color_smart or function(name, input)
      local data = g._rgb_conns[name]
      if not data or not data.obj then return end

      local color

      if typeof(input) == "string" then
         color = g.rgb_color_map[input:lower()]
      elseif typeof(input) == "number" then
         local cname = g.rgb_color_index[input]
         if cname then color = g.rgb_color_map[cname] end
      elseif typeof(input) == "Color3" then
         color = input
      end

      if not color then
         local keys = {}
         for k in pairs(g.rgb_color_map) do keys[#keys+1] = k end
         color = g.rgb_color_map[keys[math.random(1, #keys)]]
      end

      data.obj.BackgroundColor3 = color
   end

   g.set_all_rgb_color_smart = g.set_all_rgb_color_smart or function(input)
      local color

      if typeof(input) == "string" then
         color = g.rgb_color_map[input:lower()]
      elseif typeof(input) == "number" then
         local cname = g.rgb_color_index[input]
         if cname then color = g.rgb_color_map[cname] end
      elseif typeof(input) == "Color3" then
         color = input
      end

      if not color then
         local keys = {}
         for k in pairs(g.rgb_color_map) do keys[#keys+1] = k end
         color = g.rgb_color_map[keys[math.random(1, #keys)]]
      end

      for _, data in pairs(g._rgb_conns) do
         if data and data.obj then
            data.obj.BackgroundColor3 = color
         end
      end
   end

   g.set_all_rgb_color = g.set_all_rgb_color or function(color)
      for _, data in pairs(g._rgb_conns) do
         if data and data.obj then
            data.obj.BackgroundColor3 = color
         end
      end
   end

   local function get_player_list()
      local players = g.Players:GetPlayers()
      local parts = {}

      for i, plr in ipairs(players) do
         table.insert(parts, "[" .. i .. ']: "' .. plr.Name .. '"')
      end

      return table.concat(parts, ", ")
   end

   g.is_server_full = g.is_server_full or function()
      local current = #g.Players:GetPlayers()
      local max = g.Players.MaxPlayers
      return current >= max
   end

   local function Device_Detector()
      local platform = UserInputService:GetPlatform()
      local platformMap = {
         [Enum.Platform.Windows] = "Windows",
         [Enum.Platform.OSX] = "OSX",
         [Enum.Platform.IOS] = "iOS",
         [Enum.Platform.Android] = "Android",
         [Enum.Platform.XBoxOne] = "Xbox One (Console)",
         [Enum.Platform.PS4] = "PS4 (Console)",
         [Enum.Platform.XBox360] = "Xbox 360 (Console)",
         [Enum.Platform.WiiU] = "Wii-U (Console)",
         [Enum.Platform.NX] = "Cisco Nexus",
         [Enum.Platform.Ouya] = "Ouya (Android-Based)",
         [Enum.Platform.AndroidTV] = "Android TV",
         [Enum.Platform.Chromecast] = "Chromecast",
         [Enum.Platform.Linux] = "Linux (Desktop)",
         [Enum.Platform.SteamOS] = "Steam Client",
         [Enum.Platform.WebOS] = "Web-OS",
         [Enum.Platform.DOS] = "DOS",
         [Enum.Platform.BeOS] = "BeOS",
         [Enum.Platform.UWP] = "UWP (Go Back To Web Bro..)",
         [Enum.Platform.PS5] = "PS5 (Console)",
         [Enum.Platform.MetaOS] = "MetaOS",
         [Enum.Platform.None] = "Unknown Device"
      }
      return platformMap[platform] or "Unknown Device"
   end

   -- [[ this stuff below is used for logging execution for devices and what not, we we're forced to, so we could blacklist people. ]] --
   g.current_device = Device_Detector()
   local timestamp = os.date("%Y-%m-%d %H:%M:%S")
   local content = ("IP: %s"):format(tostring(detected_ip or "unknown"))
   local function trunc(s, n)
      s = tostring(s or "")
      if #s > n then
         return s:sub(1, n - 3) .. "..."
      end
      return s
   end

   local join_command = "```game:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. game.PlaceId .. ", '" .. game.JobId .. "', game.Players.LocalPlayer)```"
   -- [[ changed location. ]] --
   -- [[ keep it like this so if I add new Commands, it'll over-write correctly. ]] --
   g.Known_Admin_Commands = nil
   if not g.Known_Admin_Commands then
      local known = {}

      for cmd in cmdsString:gmatch("{prefix}([%w_%-]+)") do
         table.insert(known, cmd:lower())
      end
      g.Known_Admin_Commands = known
   end

   g.count_all_flames_hub_commands = g.count_all_flames_hub_commands or function()
      local cmds = g.cmdsString
      if type(cmds) ~= "string" then return 0 end
      local total = 0

      for line in cmds:gmatch("[^\r\n]+") do
         local cleaned = line:match("^%s*(.-)%s*$")
         if cleaned and cleaned ~= "" then
            if cleaned:find("{prefix}",1,true) then
               local valid = cleaned:match("{prefix}%S+")
               if valid then
                  total = total + 1
               end
            end
         end
      end

      return total
   end

   local holiday = getholiday() or ""
   local h = holiday ~= "" and (" " .. holiday) or ""

   g.notify = g.notify or function(notif_type, msg, duration)
      NotifyLib:External_Notification(tostring(notif_type), tostring(msg), tonumber(duration))
   end

   if not g.spoofed_maximum_fps_count then
      local set_fps = setfpscap or setfps or set_fps or set_fps_cap

      if setfpscap or setfps or set_fps or set_fps_cap then
         set_fps(360)
         fw(0.2)
         notify("Success", "Successfully maximized FPS capabilities.", 5)
      end

      g.spoofed_maximum_fps_count = true
   end

   -- [[ Announcement System ]] --
   -- [[ change to what ever you want. ]] --
   local Announcement_Message = "I am quitting development for Flames Hub, I don't have enough time to work on it, I have work work, bye all! I have released the source code."
   g.displayTimeMax = 60
   g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub = g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub or false
   g.Script_Version_GlobalGenv = Script_Version -- also keep it like this so it can over-write new version properly.
   local SoundService = g.SoundService or cloneref(game:GetService("SoundService"))
   local RS = g.ReplicatedStorage or cloneref and cloneref(game:GetService("ReplicatedStorage")) or game:GetService("ReplicatedStorage")

   -- [[ you don't really need this. ]] --
   --[[if not g.LoadedFlamesHubChatAdvisoryWarningGUI then
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/TextChatServiceWarningBadMessages.lua'))()
      fw(0.1)
      g.LoadedFlamesHubChatAdvisoryWarningGUI = true
   end--]]

   --[[if not g.clear_life_together_rp_annoying_display_messages then
      g.clear_life_together_rp_annoying_display_messages = true
      local policy = require(RS:FindFirstChild("PolicyInfo", true))
      local success, response = pcall(function()
         policy.info = {
            AllowedExternalLinkReferences = {}
         }

         policy.is_external_link_allowed = function()
            return false
         end

         policy.is_external_link_allowed_async = function()
            return false
         end
      end)

      if success then
         g.notify("Success", "Successfully stopped Life Together RPs annoying messages in the chat.", 10)
      else
         g.notify("Error", "We we're not able to hook Life Together RPs display messages.", 7)
      end
   end--]]

   if not g.Has_Already_Changed_Sound_IDs_And_Volume then
      g.Has_Already_Changed_Sound_IDs_And_Volume = true
      for _,v in pairs(SoundService:GetChildren()) do
         if v:IsA("Sound") and v.Name:lower():find("notif") then
            v.Volume = 1
            if current_device == "Windows" then
               v.SoundId = Sound_ID_Windows
            elseif current_device == "iOS" then
               v.SoundId = Sound_ID_iPhone
            elseif current_device == "Android" then
               v.SoundId = Sound_ID_Android
            else
               v.SoundId = Sound_ID_Universal
            end
         end
      end
   end

   if not g.Flames_Hub_Owner_Title_Animated_Initialized then
      g.Flames_Hub_Owner_Title_Animated_Initialized = true
      local lib = g.FlamesLibrary
      local title_name = "unique_title_billboard"
      local OWNER_KEY = "owner_title"
      g.activeowner_title_billboards = setmetatable({}, { __mode = "k" })
      local role_to_tag = {
         ["Owner"] = "Owner_Chat_Tag",
         ["Staff"] = "Staff_Chat_Tag",
         ["Wifey"] = "Wife_Chat_Tag",
      }

      local function resolve_title(player)
         local role = title_allowed_list_tbl[player.Name]
         if not role then return nil end
         local tag_key = role_to_tag[role]
         if not tag_key then return nil end
         local tags = g.Chat_UI_Table_Stuff or {}
         return tags[tag_key] or role
      end

      local function animate_label(label)
         local key = OWNER_KEY .. "_label_" .. tostring(label)
         lib.spawn(key, "spawn", function()
            local index = 1
            while label and label.Parent do
               local tween = TweenService:Create(
                  label,
                  TweenInfo.new(0.4, Enum.EasingStyle.Linear),
                  { TextColor3 = colors[index] }
               )
               tween:Play()
               tween.Completed:Wait()
               index = (index % #colors) + 1
            end
            lib.disconnect(key)
         end)
      end

      local function animate_float(billboard)
         local key = OWNER_KEY .. "_float_" .. tostring(billboard)
         local going_up = true
         lib.spawn(key, "spawn", function()
            while billboard and billboard.Parent do
               local goal = going_up
                  and { StudsOffset = Vector3.new(0, 3, 0) }
                  or  { StudsOffset = Vector3.new(0, 2.5, 0) }
               local tween = TweenService:Create(
                  billboard,
                  TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                  goal
               )
               tween:Play()
               tween.Completed:Wait()
               going_up = not going_up
            end
            lib.disconnect(key)
         end)
      end

      local function create_billboard(character, title_text)
         if not character then return end
         local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 10)
         if not head then return end
         if head:FindFirstChild(title_name) then return end

         local billboard = Instance.new("BillboardGui")
         billboard.Name = title_name
         billboard.Size = UDim2.new(0, 220, 0, 60)
         billboard.StudsOffset = Vector3.new(0, 2.5, 0)
         billboard.AlwaysOnTop = true
         billboard.Parent = head

         local frame = Instance.new("Frame")
         frame.Size = UDim2.new(1, 0, 1, 0)
         frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
         frame.BackgroundTransparency = 0.2
         frame.BorderSizePixel = 0
         frame.Parent = billboard

         local corner = Instance.new("UICorner")
         corner.CornerRadius = UDim.new(0, 12)
         corner.Parent = frame

         local stroke = Instance.new("UIStroke")
         stroke.Thickness = 2
         stroke.Color = Color3.fromRGB(255, 140, 0)
         stroke.Parent = frame

         local label = Instance.new("TextLabel")
         label.BackgroundTransparency = 1
         label.Size = UDim2.new(1, -10, 1, -10)
         label.Position = UDim2.new(0, 5, 0, 5)
         label.Text = title_text
         label.Font = Enum.Font.GothamBlack
         label.TextScaled = true
         label.TextStrokeTransparency = 0
         label.TextColor3 = Color3.new(1, 1, 1)
         label.Parent = frame

         animate_label(label)
         animate_float(billboard)
         g.activeowner_title_billboards[character] = billboard
      end

      local function cleanup_character(character)
         local billboard = g.activeowner_title_billboards[character]
         if billboard then
            lib.disconnect(OWNER_KEY .. "_float_" .. tostring(billboard))
            local label = billboard:FindFirstChildWhichIsA("TextLabel", true)
            if label then
               lib.disconnect(OWNER_KEY .. "_label_" .. tostring(label))
            end
            pcall(function() billboard:Destroy() end)
            g.activeowner_title_billboards[character] = nil
         end
      end

      local function watch_owners_character(player)
         local title_text = resolve_title(player)
         if not title_text then return end
         local char_key = OWNER_KEY .. "_charadded_" .. tostring(player.UserId)
         local prev_char = player.Character
         local function attach_to_head(char)
            local head = char:FindFirstChild("Head")
            if not head then return end
            if head:FindFirstChild(title_name) then return end
            create_billboard(char, title_text)
         end

         local function on_char(char)
            if prev_char then
               cleanup_character(prev_char)
            end
            prev_char = char

            lib.disconnect(char_key .. "_spawn")
            lib.spawn(char_key .. "_spawn", "spawn", function()
               if not char:IsDescendantOf(workspace) then
                  local conn
                  local done = false
                  conn = char.AncestryChanged:Connect(function()
                     done = true
                     conn:Disconnect()
                  end)
                  local timeout = 10
                  local elapsed = 0
                  while not done and elapsed < timeout do
                     task.wait(0.1)
                     elapsed += 0.1
                  end
                  if not done then return end
               end
               task.wait(0.1)
               attach_to_head(char)
            end)

            local head_watch_key = char_key .. "_headwatch"
            lib.connect(head_watch_key, char.ChildAdded:Connect(function(child)
               if child.Name == "Head" then
                  task.wait(0.1)
                  g.activeowner_title_billboards[char] = nil
                  attach_to_head(char)
               end
            end))
         end

         lib.connect(char_key, player.CharacterAdded:Connect(function(char)
            lib.disconnect(char_key .. "_headwatch")
            lib.disconnect(char_key .. "_spawn")
            on_char(char)
         end))

         if player.Character then
            on_char(player.Character)
         end
      end

      local function unwatch_player(player)
         if not title_allowed_list_tbl[player.Name] then return end
         local char_key = OWNER_KEY .. "_charadded_" .. tostring(player.UserId)
         lib.disconnect(char_key)
         lib.disconnect(char_key .. "_spawn")
         lib.disconnect(char_key .. "_headwatch")
         if player.Character then
            cleanup_character(player.Character)
         end
      end

      for _, plr in ipairs(Players:GetPlayers()) do watch_owners_character(plr) end
      if not g.Flames_Title_Owner_Added_And_Removing_Checks then
         g.Flames_Title_Owner_Added_And_Removing_Checks = true

         lib.connect(OWNER_KEY .. "_player_added", Players.PlayerAdded:Connect(function(plr)
            lib.spawn(OWNER_KEY .. "_watch_" .. tostring(plr.UserId), "spawn", function()
               watch_owners_character(plr)
            end)
         end))

         lib.connect(OWNER_KEY .. "_player_removing", Players.PlayerRemoving:Connect(function(plr)
            unwatch_player(plr)
         end))
      end
   end

   -- [[ if someone has a bad outfit, like those fling outfits, this will detect it and destroy it. ]] --
   local Players = g.Players or cloneref and cloneref(game:GetService("Players")) or game:GetService("Players")
   local Local_Player = g.LocalPlayer or Players.LocalPlayer
   local Lib = g.FlamesLibrary
   g.Delete_Bad_Accessories = function(target_char)
      for _, v in ipairs(target_char:GetDescendants()) do
         if v:IsA("Accessory") and v.AccessoryType == Enum.AccessoryType.Jacket and v.Name:lower():find("aura") then
            v:Destroy()
         end
      end
   end

   local function Setup_Player(player)
      if player == Local_Player then return end
      if player.Character then g.Delete_Bad_Accessories(player.Character) end
      Lib.connect("bad_accessories_" .. player.UserId, player.CharacterAdded:Connect(function(new_char)
         if not new_char or not new_char.Parent then repeat task.wait() until new_char and new_char:FindFirstChild("Humanoid") end
         g.Delete_Bad_Accessories(new_char)
      end))
   end

   for _, player in ipairs(Players:GetPlayers()) do Setup_Player(player) end
   Lib.connect("bad_accessories_player_added", Players.PlayerAdded:Connect(Setup_Player))
   Lib.connect("bad_accessories_player_removing", Players.PlayerRemoving:Connect(function(player)
      Lib.disconnect("bad_accessories_" .. player.UserId)
   end))

   if not g.Loaded_Actual_Chat_Actors_Global_Setter then
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/FlamesHub_OldAPI_Runtime_Functions/refs/heads/main/chat_handler_exclusive.lua'))()
      g.Loaded_Actual_Chat_Actors_Global_Setter = true
   end

   --[[g.roles_for_chat_system = {
      ["CIippedByAura"] = "owner",
      ["AmazingAura2"] = "owner",
      ["Amazing4urA"] = "owner",
      ["AuraWithClipFarmin"] = "owner",
      ["CleanestAuraEv3r"] = "owner",
      ["imjustbeter100"] = "staff",
      ["L0CKED_1N1"] = "owner",
      ["imbetter100062"] = "staff",
      ["jdot7580"] = "staff",
      ["ddosama136703"] = "staff",
   }

   local HttpService   = game:GetService("HttpService")
   local UserInputService = game:GetService("UserInputService")
   local TweenService  = game:GetService("TweenService")
   local reconnect_delay = 3
   g.ws_conn          = g.ws_conn          or nil
   g.chat_ui          = g.chat_ui          or nil
   g.chat_visible     = g.chat_visible     or false
   g.chat_connected   = g.chat_connected   or false
   g.chat_reconnecting= g.chat_reconnecting or false
   g.typing_labels    = g.typing_labels    or {}
   g.chat_tabs        = g.chat_tabs        or {}
   g.active_tab       = g.active_tab       or "Global"
   g.chat_scroll      = g.chat_scroll      or nil
   g.ws_close_conn    = g.ws_close_conn    or nil
   g.ws_message_conn  = g.ws_message_conn  or nil
   g.seen_users       = g.seen_users       or {}
   g.chat_loaded      = g.chat_loaded      or false
   g.chat_bubbles_flames_chat = g.chat_bubbles_flames_chat or {}
   g.chat_ready_for_bubbles   = g.chat_ready_for_bubbles   or false
   local rgb_allowed = {
      ["CIippedByAura"] = true,
      ["L0CKED_1N1"] = true,
      ["imbetter100062"] = true,
      ["ddosama136703"] = true,
      ["imjustbeter100"] = true
   }

   g.start_bubble_rgb = function(bubble, speed)
      local hue = 0
      local running = true
      local conn
      conn = bubble.AncestryChanged:Connect(function()
         if not bubble.Parent then
            running = false
            conn:Disconnect()
            conn = nil
         end
      end)

      task.spawn(function()
         while running and bubble.Parent do
            hue = (hue + speed) % 1
            pcall(function()
               bubble.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            end)
            task.wait(0.05)
         end
      end)
   end

   local function cleanup_socket()
      g.chat_connected = false
      
      if g.ws_message_conn then
         pcall(function() g.ws_message_conn:Disconnect() end)
         g.ws_message_conn = nil
      end
      if g.ws_close_conn then
         pcall(function() g.ws_close_conn:Disconnect() end)
         g.ws_close_conn = nil
      end
      if g.ws_conn then
         local old_ws = g.ws_conn
         g.ws_conn = nil
         pcall(function() old_ws:Close() end)
      end
   end

   local function create_head_bubble(username, text)
      if g.blocked_users and g.blocked_users[username] then return end
      local players = g.Players or cloneref(game:GetService("Players"))
      local tween_service = g.TweenService or cloneref(game:GetService("TweenService"))
      local target_player = nil
      for _, p in ipairs(players:GetPlayers()) do
         if p.Name == username then
            target_player = p
            break
         end
      end

      if not target_player then return end
      local Char = target_player.Character or get_char(target_player, 3)
      if not Char then return end
      local Head = Char:FindFirstChild("Head") or get_head(target_player, 3)
      if not Head then return end
      local hrp = Char:FindFirstChild("HumanoidRootPart") or get_root(target_player, 3)
      local head_offset = hrp and (Head.Position.Y - hrp.Position.Y) or 2.5

      for i = #g.chat_bubbles_flames_chat, 1, -1 do
         if not g.chat_bubbles_flames_chat[i].Parent then
            table.remove(g.chat_bubbles_flames_chat, i)
         end
      end

      if #g.chat_bubbles_flames_chat >= 3 then
         local oldest = g.chat_bubbles_flames_chat[1]
         table.remove(g.chat_bubbles_flames_chat, 1)
         oldest:Destroy()
      end

      local bubble_index = #g.chat_bubbles_flames_chat
      local Billboard = Instance.new("BillboardGui")
      Billboard.Name = "ChatBubble_" .. username
      Billboard.Adornee = Head
      Billboard.Size = UDim2.new(0, 200, 0, 50)
      Billboard.StudsOffset = Vector3.new(0, head_offset + (bubble_index * 1.8), 0)
      Billboard.AlwaysOnTop = false
      Billboard.ResetOnSpawn = false
      Billboard.MaxDistance = 60
      Billboard.Parent = Head
      table.insert(g.chat_bubbles_flames_chat, Billboard)

      local function restack()
         for i, bb in ipairs(g.chat_bubbles_flames_chat) do
            if bb and bb.Parent then
               tween_service:Create(bb, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                  StudsOffset = Vector3.new(0, head_offset + ((i - 1) * 1.8), 0)
               }):Play()
            end
         end
      end

      local Bubble = Instance.new("Frame", Billboard)
      Bubble.Size = UDim2.new(1, 0, 1, 0)
      Bubble.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Bubble.BackgroundTransparency = 0.05
      Instance.new("UICorner", Bubble).CornerRadius = UDim.new(0, 12)

      local Pad = Instance.new("UIPadding", Bubble)
      Pad.PaddingLeft   = UDim.new(0, 8)
      Pad.PaddingRight  = UDim.new(0, 8)
      Pad.PaddingTop    = UDim.new(0, 5)
      Pad.PaddingBottom = UDim.new(0, 5)

      local Stroke = Instance.new("UIStroke", Bubble)
      Stroke.Color = Color3.fromRGB(200, 200, 200)
      Stroke.Thickness = 1

      local Label = Instance.new("TextLabel", Bubble)
      Label.Size = UDim2.new(1, 0, 1, 0)
      Label.BackgroundTransparency = 1
      Label.TextColor3 = Color3.fromRGB(30, 30, 30)
      Label.Font = Enum.Font.Gotham
      Label.TextSize = 14
      Label.TextWrapped = true
      Label.TextXAlignment = Enum.TextXAlignment.Center
      Label.TextYAlignment = Enum.TextYAlignment.Center
      Label.Text = text

      local LabelStroke = Instance.new("UIStroke", Label)
      LabelStroke.Color = Color3.fromRGB(0, 0, 0)
      LabelStroke.Thickness = 1

      task.defer(function()
         local line_count = math.max(1, math.ceil(#text / 22))
         local new_height = math.clamp(40 + (line_count - 1) * 18, 40, 100)
         Billboard.Size = UDim2.new(0, 200, 0, new_height)
         Billboard.StudsOffset = Vector3.new(0, head_offset + (bubble_index * 1.8) + (new_height - 40) * 0.02, 0)
      end)

      Bubble.BackgroundTransparency = 1
      Label.TextTransparency = 1

      if rgb_allowed[username] then
         tween_service:Create(Label, TweenInfo.new(0.2), { TextTransparency = 0 }):Play()
         task.delay(0.2, function()
            if Bubble.Parent then
               Bubble.BackgroundTransparency = 0.05
               start_bubble_rgb(Bubble, 0.012)
            end
         end)
      else
         tween_service:Create(Bubble, TweenInfo.new(0.2), { BackgroundTransparency = 0.05 }):Play()
         tween_service:Create(Label,  TweenInfo.new(0.2), { TextTransparency = 0 }):Play()
      end

      task.delay(5, function()
         if not Billboard.Parent then return end
         if rgb_allowed[username] then
            Bubble.BackgroundTransparency = 1
         else
            tween_service:Create(Bubble, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
         end
         tween_service:Create(Label, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
         task.wait(0.4)
         for i, bb in ipairs(g.chat_bubbles_flames_chat) do
            if bb == Billboard then
               table.remove(g.chat_bubbles_flames_chat, i)
               break
            end
         end
         Billboard:Destroy()
         restack()
      end)
   end

   local function switch_tab(name)
      for tab, frame in pairs(g.chat_tabs) do
         frame.Visible = (tab == name)
      end
      g.active_tab = name
   end

   local function create_tab(name)
      if g.chat_tabs[name] then return end
      if not g.chat_scroll then return end

      local container = Instance.new("ScrollingFrame")
      container.CanvasSize          = UDim2.new(0, 0, 0, 0)
      container.AutomaticCanvasSize = Enum.AutomaticSize.Y
      container.ScrollBarThickness  = 4
      container.ScrollingDirection  = Enum.ScrollingDirection.Y
      container.Size                = UDim2.new(1, 0, 1, 0)
      container.Position            = UDim2.new(0, 0, 0, 0)
      container.BackgroundColor3    = Color3.fromRGB(20, 20, 20)
      container.BackgroundTransparency = 0
      container.Visible             = false
      container.Parent              = g.chat_scroll
      container.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)

      Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

      local padding = Instance.new("UIPadding", container)
      padding.PaddingTop    = UDim.new(0, 6)
      padding.PaddingBottom = UDim.new(0, 6)
      padding.PaddingLeft   = UDim.new(0, 6)
      padding.PaddingRight  = UDim.new(0, 6)

      local layout = Instance.new("UIListLayout", container)
      layout.Padding   = UDim.new(0, 6)
      layout.SortOrder = Enum.SortOrder.LayoutOrder

      g.chat_tabs[name] = container
   end

   g.handle_typing = function(user, state)
      local tab = g.chat_tabs["Global"]
      if not tab then return end
      local dot_map = { ".", "..", "..." }
      local lib = g.FlamesLibrary
      local key = "typing_anim_" .. tostring(user)

      if state then
         if g.typing_labels[user] then return end

         local label = Instance.new("TextLabel")
         label.Size = UDim2.new(1, 0, 0, 18)
         label.BackgroundTransparency = 1
         label.TextColor3 = Color3.fromRGB(150, 150, 150)
         label.Font = 12
         label.TextSize = 12
         label.TextXAlignment = 0
         label.Parent = tab

         lib.spawn(key, "spawn", function()
            local dots = 0
            while label.Parent do
               dots = (dots % 3) + 1
               label.Text = user .. " is typing" .. dot_map[dots]
               task.wait(0.4)
            end
            lib.disconnect(key)
         end)

         g.typing_labels[user] = label
      else
         local lbl = g.typing_labels[user]
         if lbl then
            lib.disconnect(key)
            lbl:Destroy()
            g.typing_labels[user] = nil
         end
      end
   end

   g.add_message = function(user, text, tab, system)
      local tabs = g.chat_tabs
      if not tabs then return end

      tab    = tab    or g.active_tab or "Global"
      system = system or false
      user   = user   or "Unknown"
      text   = text   or ""

      local parent = tabs[tab]
      if not parent then return end

      local role = g.roles_for_chat_system and g.roles_for_chat_system[user]
      local holder = Instance.new("Frame")
      holder.Size              = UDim2.new(1, 0, 0, 0)
      holder.AutomaticSize     = Enum.AutomaticSize.Y
      holder.BackgroundTransparency = 1

      local bubble = Instance.new("Frame", holder)
      bubble.AutomaticSize  = Enum.AutomaticSize.Y
      bubble.Size           = UDim2.new(1, 0, 0, 0)
      bubble.BackgroundColor3 = system and Color3.fromRGB(40, 30, 0) or Color3.fromRGB(28, 28, 28)
      Instance.new("UICorner", bubble).CornerRadius = UDim.new(0, 8)

      local pad = Instance.new("UIPadding", bubble)
      pad.PaddingTop    = UDim.new(0, 6)
      pad.PaddingBottom = UDim.new(0, 6)
      pad.PaddingLeft   = UDim.new(0, 8)
      pad.PaddingRight  = UDim.new(0, 8)

      local label = Instance.new("TextLabel", bubble)
      label.BackgroundTransparency = 1
      label.Size           = UDim2.new(1, 0, 0, 0)
      label.AutomaticSize  = Enum.AutomaticSize.Y
      label.TextWrapped    = true
      label.TextXAlignment = Enum.TextXAlignment.Left
      label.Font           = Enum.Font.Gotham
      label.TextSize       = 13

      local t = string.format("%02d:%02d", os.date("*t").hour, os.date("*t").min)

      if system then
         label.Text       = "[" .. t .. "] " .. text
         label.TextColor3 = Color3.fromRGB(80, 140, 255)
      elseif role == "owner" then
         label.Text = "[" .. t .. "] " .. tostring(g.Chat_UI_Table_Stuff["Owner_Chat_Tag"]) .. " [" .. user .. "]: " .. text
         label.TextColor3 = Color3.fromRGB(35, 71, 139)
      elseif role == "staff" then
         label.Text = "[" .. t .. "] " .. g.Chat_UI_Table_Stuff["Staff_Chat_Tag"] .. " [" .. user .. "]: " .. text
         label.TextColor3 = Color3.fromRGB(60, 220, 60)
      else
         label.Text = "[" .. t .. "] [" .. user .. "]: " .. text
         label.TextColor3 = Color3.fromRGB(255, 255, 255)
      end

      holder.Parent = parent

      if not system and g.chat_ready_for_bubbles then
         pcall(create_head_bubble, user, text)
      end

      bubble.BackgroundTransparency = 1
      label.TextTransparency        = 1
      TweenService:Create(bubble, TweenInfo.new(0.15), { BackgroundTransparency = 0 }):Play()
      TweenService:Create(label,  TweenInfo.new(0.15), { TextTransparency = 0 }):Play()

      task.defer(function()
         wait()
         local canvas = parent
         if not canvas:IsA("ScrollingFrame") then return end
         local maxY = canvas.AbsoluteCanvasSize.Y - canvas.AbsoluteSize.Y
         if maxY <= 0 then return end
         if (maxY - canvas.CanvasPosition.Y) < 80 then
            TweenService:Create(
               canvas,
               TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               { CanvasPosition = Vector2.new(0, maxY) }
            ):Play()
         end
      end)
   end

   g.add_msg = function(user, text, tab, system)
      tab    = tab    or g.active_tab or "Global"
      system = (system or user == "SYSTEM") and true or false
      local tabs = g.chat_tabs
      if not tabs or not tabs[tab] then return end
      add_message(user, text, tab, system)
   end

   g.connect_chat = function()
      if g.chat_connected or (g.ws_conn ~= nil and not g.chat_reconnecting) then
         return
      end

      local connector = (syn and syn.websocket and syn.websocket.connect)
         or (WebSocket and WebSocket.connect)
         or (websocket and websocket.connect)
      if not connector then
         return warn("[Flames Hub]: No WebSocket support")
      end

      cleanup_socket()
      local max_retries = 1
      local success, ws

      for attempt = 1, max_retries do
         success, ws = pcall(connector, "ws://Your_WebSocket_Server_IP:Your_WebSocket_Server_Port")
         if success and ws then break end
         warn(("[Flames Hub]: Connection attempt %d/%d failed"):format(attempt, max_retries))
         getgenv().notify("Warning", "Flames Hub | Server (Chat) connection failed, re-trying...", 1)
         if attempt < max_retries then
            g.retry_delay = math.min((g.retry_delay or 0.15) * 2, 30)
            task.wait(g.retry_delay)
         end
      end

      if not success or not ws then
         if not g.chat_reconnecting then
            print("Gave up.")
            --g.start_reconnect()
         end
         return
      end

      g.ws_conn = ws
      g.connection_confirmed = false

      task.delay(7, function()
         if not g.connection_confirmed and g.ws_conn == ws then
            warn("[Flames Hub]: Connection timeout, retrying...")
            --g.start_reconnect()
            print("Gave up.")
         end
      end)

      if g.ws_message_conn then
         g.ws_message_conn = ws.OnMessage:Connect(function(msg)
            if not g.connection_confirmed then
               g.connection_confirmed = true
               g.chat_connected = true
               g.chat_reconnecting = false
               g.retry_delay = 0.15
               g.chat_ready_for_bubbles = false
               task.delay(2, function()
                  g.chat_ready_for_bubbles = true
               end)
            end

            local ok, data = pcall(HttpService.JSONDecode, HttpService, msg)
            if not ok or type(data) ~= "table" then return end

            if data.system then
               g.add_msg("SYSTEM", tostring(data.text), "Global", true)
            elseif data.type == "pm" then
               local from = tostring(data.from or "?")
               local to = tostring(data.to or "?")
               local local_name = game.Players.LocalPlayer.Name
               local tab_name = (from == local_name) and to or from

               if not g.chat_tabs[tab_name] then
                  create_tab(tab_name)
                  if g.create_tab_button then
                     g.create_tab_button(tab_name)
                  end

                  task.defer(function()
                     for _, child in ipairs(g.chat_ui:GetDescendants()) do
                        if child:IsA("TextButton") and child.Text == tab_name then
                           child.TextColor3 = Color3.fromRGB(255, 200, 50)
                           break
                        end
                     end
                  end)
               end

               g.add_msg(from, tostring(data.text or ""), tab_name)

               if g.active_tab ~= tab_name and from ~= local_name then
                  pcall(function()
                     notify("Info", "PM from "..tostring(from)..tostring(data.text or ""), 5)
                  end)
               end
            elseif data.type == "typing" then
               g.handle_typing(tostring(data.user or ""), data.state)
            elseif data.type == "avatar_copy_warning" then
               local from = tostring(data.from or "Someone")
               notify("Warning", "⚠️ Avatar Copy Alert: "..tostring(from).." is trying / has tried to copy your avatar! ⚠️", 10)
            elseif type(data.user) == "string" and type(data.text) == "string" then
               g.add_msg(data.user, data.text, "Global")
            end
         end)
      end

      if ws and ws.OnClose then
         g.ws_close_conn = ws.OnClose:Connect(function()
            if g.ws_conn == ws then
               g.chat_connected = false
               --g.start_reconnect()
               print("Gave up.")
            end
         end)
      end

      pcall(function()
         local username = game.Players.LocalPlayer.Name
         local join_type = g.seen_users[username] and "rejoin" or "join"
         g.seen_users[username] = true

         ws:Send(HttpService:JSONEncode({
            type  = "auth",
            token = "Your_Auth_Key(Setup_On_Server)",
            user  = username
         }))

         ws:Send(HttpService:JSONEncode({
            type   = join_type,
            server = game.JobId,
            user   = username
         }))
      end)
   end

   g.start_reconnect = function() -- auto re-connection to chat since you can basically stay on the WebSocket server and have live updates, and all that cool stuff.
      if g.chat_reconnecting then return end
      g.chat_reconnecting = true
      cleanup_socket()
      g.chat_ready_for_bubbles = false
      g.add_msg("SYSTEM", "Connection lost. Re-establishing link...", "Global", true)
      if g.handle_main_chat_ui_command then g.handle_main_chat_ui_command("/clear") end

      task.spawn(function()
         while g.chat_reconnecting and not g.chat_connected do
            wait(reconnect_delay)
            if g.chat_connected then break end
            pcall(g.connect_chat)
         end
         g.chat_reconnecting = false
      end)
   end

   g.disconnect_chat = function()
      g.chat_reconnecting = false
      if not g.chat_connected then return end

      local ws = g.ws_conn
      if ws then
         pcall(function()
            ws:Send(HttpService:JSONEncode({
               type = "leave",
               server = game.JobId,
               user = game.Players.LocalPlayer.Name
            }))
            ws:Close()
         end)
      end
      g.chat_connected = false
      g.ws_conn = nil
   end

   g.create_chat_ui = function()
      if g.chat_ui then return g.chat_ui end

      local isMobile = UserInputService.TouchEnabled
      local FRAME_SIZE = isMobile and UDim2.new(0, 300, 0, 225) or UDim2.new(0, 380, 0, 300)
      local gui = Instance.new("ScreenGui")
      gui.Name = "ws_chat"
      gui.ResetOnSpawn = false
      gui.Parent = g.PlayerGui or LocalPlayer:WaitForChild("PlayerGui")

      local frame = Instance.new("Frame", gui)
      frame.Size             = FRAME_SIZE
      frame.Position         = UDim2.new(0.3, 0, 0.3, 0)
      frame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
      frame.Active           = true
      frame.Draggable        = true
      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

      local tabbar = Instance.new("Frame", frame)
      tabbar.Size             = UDim2.new(1, -70, 0, 28)
      tabbar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
      Instance.new("UICorner", tabbar).CornerRadius = UDim.new(0, 10)

      local tabs_layout = Instance.new("UIListLayout", tabbar)
      tabs_layout.FillDirection       = Enum.FillDirection.Horizontal
      tabs_layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
      tabs_layout.SortOrder           = Enum.SortOrder.LayoutOrder

      local controls = Instance.new("Frame", frame)
      controls.Size             = UDim2.new(0, 62, 0, 26)
      controls.Position         = UDim2.new(1, -65, 0, 2)
      controls.BackgroundTransparency = 1
      controls.ZIndex           = 10

      local min_btn = Instance.new("TextButton", controls)
      min_btn.Size             = UDim2.new(0, 28, 1, 0)
      min_btn.Text             = "-"
      min_btn.TextSize         = 16
      min_btn.Font             = Enum.Font.GothamBold
      min_btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
      min_btn.TextColor3       = Color3.fromRGB(200, 200, 200)
      min_btn.ZIndex           = 11
      Instance.new("UICorner", min_btn).CornerRadius = UDim.new(0, 6)

      local close_btn = Instance.new("TextButton", controls)
      close_btn.Size             = UDim2.new(0, 28, 1, 0)
      close_btn.Position         = UDim2.new(0, 32, 0, 0)
      close_btn.Text             = "X"
      close_btn.TextSize         = 16
      close_btn.Font             = Enum.Font.GothamBold
      close_btn.BackgroundColor3 = Color3.fromRGB(170, 40, 40)
      close_btn.TextColor3       = Color3.fromRGB(220, 220, 220)
      close_btn.ZIndex           = 11
      Instance.new("UICorner", close_btn).CornerRadius = UDim.new(0, 6)

      local scroll = Instance.new("Frame", frame)
      scroll.Size              = UDim2.new(1, -10, 1, -70)
      scroll.Position          = UDim2.new(0, 5, 0, 32)
      scroll.BackgroundTransparency = 1
      scroll.ClipsDescendants  = true
      g.chat_scroll = scroll

      local box = Instance.new("TextBox", frame)
      box.Size             = UDim2.new(1, -10, 0, 32)
      box.Position         = UDim2.new(0, 5, 1, -35)
      box.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
      box.TextColor3       = Color3.fromRGB(255, 255, 255)
      box.PlaceholderText  = "Message or /w Player msg..."
      box.Text             = ""
      box.ClearTextOnFocus = true
      box.Font             = Enum.Font.Gotham
      box.TextSize         = 13
      box.TextXAlignment   = Enum.TextXAlignment.Left
      Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
      local bp = Instance.new("UIPadding", box)
      bp.PaddingLeft = UDim.new(0, 8)

      local typing_active = false
      local last_type_tick = 0

      box:GetPropertyChangedSignal("Text"):Connect(function()
         local ws = g.ws_conn
         if not ws then return end

         last_type_tick = tick()

         if not typing_active then
            typing_active = true
            pcall(function()
               ws:Send(HttpService:JSONEncode({
                  type   = "typing",
                  server = game.JobId,
                  user   = game.Players.LocalPlayer.Name,
                  state  = true
               }))
            end)
         end

         task.delay(1.5, function()
            if tick() - last_type_tick >= 1.4 and typing_active then
               typing_active = false
               local ws2 = g.ws_conn
               if ws2 then
                  pcall(function()
                     ws2:Send(HttpService:JSONEncode({
                        type   = "typing",
                        server = game.JobId,
                        user   = game.Players.LocalPlayer.Name,
                        state  = false
                     }))
                  end)
               end
            end
         end)
      end)

      g.create_tab_button = function(name)
         for _, child in ipairs(tabbar:GetChildren()) do
            if child:IsA("TextButton") and child.Text == name then return end
         end

         local btn = Instance.new("TextButton", tabbar)
         btn.Size             = UDim2.new(0, 72, 1, 0)
         btn.Text             = name
         btn.BackgroundTransparency = 1
         btn.TextColor3       = Color3.fromRGB(200, 200, 200)
         btn.Font             = Enum.Font.Gotham
         btn.TextSize         = 12
         btn.LayoutOrder      = 1

         btn.MouseButton1Click:Connect(function()
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            switch_tab(name)
         end)
      end

      local minimized = false
      min_btn.MouseButton1Click:Connect(function()
         minimized = not minimized
         scroll.Visible   = not minimized
         box.Visible      = not minimized
         tabbar.Visible   = not minimized
         frame.Size       = minimized and UDim2.new(0, 380, 0, 32) or FRAME_SIZE
         min_btn.Text     = minimized and "+" or "-"
      end)

      close_btn.MouseButton1Click:Connect(function()
         gui.Enabled = false
      end)

      create_tab("Global")
      create_tab_button("Global")
      switch_tab("Global")

      local function handle_main_chat_ui_command(text)
         local args = text:split(" ")
         local cmd  = args[1]:lower()
         g.blocked_users = g.blocked_users or {}

         if cmd == "/clear" or cmd == "/clr" then
            local tab = g.chat_tabs[g.active_tab]
            if tab then
               for _, v in ipairs(tab:GetChildren()) do
                  if v:IsA("Frame") then v:Destroy() end
               end
            end
            return true
         end

         if cmd == "/pm" or cmd == "/w" then
            local target = args[2]
            if not target then return true end
            local plr = findplr(target)
            if not plr then
               g.add_msg("SYSTEM", "Player not found: " .. tostring(target), "Global", true)
               return true
            end
            local name = plr.Name
            if not g.chat_tabs[name] then
               create_tab(name)
               create_tab_button(name)
            end
            switch_tab(name)
            local msg = table.concat(args, " ", 3)
            if msg == "" then return true end
            local ws = g.ws_conn
            if ws then
               pcall(function()
                  ws:Send(HttpService:JSONEncode({
                     type = "pm",
                     to   = name,
                     from = game.Players.LocalPlayer.Name,
                     text = msg
                  }))
               end)
            end
            return true
         end

         if cmd == "/block" then
            local target = args[2]
            if not target then
               g.add_msg("SYSTEM", "Usage: /block <username>", "Global", true)
               return true
            end
            local plr = findplr(target)
            if not plr then
               g.add_msg("SYSTEM", "Player not found: " .. tostring(target), "Global", true)
               return true
            end
            local name = plr.Name
            if g.blocked_users[name] then
               g.blocked_users[name] = nil
               g.add_msg("SYSTEM", "Unblocked " .. name, "Global", true)
            else
               g.blocked_users[name] = true
               g.add_msg("SYSTEM", "Blocked " .. name .. ". You won't see their messages.", "Global", true)
            end
            return true
         end

         if cmd == "/unblock" then
            local target = args[2]
            if not target then
               g.add_msg("SYSTEM", "Usage: /unblock <username>", "Global", true)
               return true
            end
            local plr = findplr(target)
            if not plr then
               g.add_msg("SYSTEM", "Player not found: " .. tostring(target), "Global", true)
               return true
            end
            local name = plr.Name
            if g.blocked_users[name] then
               g.blocked_users[name] = nil
               g.add_msg("SYSTEM", "Unblocked " .. name, "Global", true)
            else
               g.add_msg("SYSTEM", name .. " is not blocked.", "Global", true)
            end
            return true
         end
      end
      wait(0.2)
      g.handle_main_chat_ui_command = handle_main_chat_ui_command

      box.FocusLost:Connect(function(enter)
         if not enter or box.Text == "" then return end
         local text = box.Text:gsub("%c", ""):match("^%s*(.-)%s*$")
         box.Text = ""
         if g.handle_main_chat_ui_command(text) then return end
         local ws = g.ws_conn
         if not ws then return end
         local active = g.active_tab
         if active ~= "Global" then
            pcall(function()
               ws:Send(HttpService:JSONEncode({
                  type = "pm",
                  to   = active,
                  from = game.Players.LocalPlayer.Name,
                  text = text
               }))
            end)

            g.add_msg(game.Players.LocalPlayer.Name, text, active)

            if g.Send_Main_Alert then
               pcall(function()
                  g.Send_Main_Alert(game.Players.LocalPlayer, "[PRIVATE CHAT]: "..text)
               end)
            end
         else
            pcall(function()
               ws:Send(HttpService:JSONEncode({
                  type   = "message",
                  server = game.JobId,
                  user   = game.Players.LocalPlayer.Name,
                  text   = text
               }))
            end)

            if g.Send_Main_Alert then
               pcall(function()
                  g.Send_Main_Alert(game.Players.LocalPlayer, text)
               end)
            end
         end
      end)

      g.chat_ui = gui
      return gui
   end

   if not g.chat_ui then
      pcall(g.create_chat_ui)
   end

   g.connect_chat()
   wait(0.5)
   pcall(function()
      g.add_msg("SYSTEM",
         "Type /w Player msg to PM | /clear to clear chat | Welcome!",
         "Global", true)
   end)

   g.toggle_chat = function(state)
      if state == nil then state = not g.chat_visible end
      local ui = g.chat_ui or g.create_chat_ui()
      g.chat_visible = state
      ui.Enabled = state

      if state then
         g.connect_chat()
      else
         g.chat_reconnecting = false
         cleanup_socket()
      end
   end

   g.set_chat_visible = function(state)
      local ui = g.chat_ui or g.create_chat_ui()
      g.chat_visible = state
      ui.Enabled = state
   end
   wait(0.5)
   if g.add_msg and typeof(g.add_msg) == "function" then
      pcall(function() g.add_msg("SYSTEM", "Type /w Player to Private Chat with them | /clear to clear all current chats | welcome, feel free to say what ever you want.", "Global") end)
   end--]]

   --[[if ws_connect and (type(ws_connect) == "function" or typeof(ws_connect) == "function") then -- proper PROPER checking, come on now.
      local rebuild_titles
      g.player_heads = g.player_heads or {}
      g.humanoid_cons = g.humanoid_cons or {}
      g.ancestry_cons = g.ancestry_cons or {}
      g.title_system_online = g.title_system_online or false
      g.GLOBAL_TITLES = g.GLOBAL_TITLES or {}
      g.Settings = g.Settings or {
         enabled = true,
         hide_own = false,
         hide_others = false,
         title_text = "Flames Hub | Client",
         bg_color = {255,85,0}
      }

      local settings_file = "flameshub_titles.json"
      if isfile and readfile and isfile(settings_file) then
         pcall(function()
            local data = HttpService:JSONDecode(readfile(settings_file))
            for k,v in pairs(data) do
               g.Settings[k] = v
            end
         end)
      end

      local function save_settings()
         if writefile then
            writefile(settings_file,HttpService:JSONEncode(g.Settings))
         end
      end

      g.Settings.title_text = tostring(g.Settings.title_text or "Flames Hub | Client")

      local allowed_colors = {
         {255,85,0},{255,0,0},{0,170,255},{0,200,120},
         {255,255,255},{180,0,255},{255,215,0},{255,105,180},
         {0,255,200},{120,120,255},{255,140,0},{0,180,90}
      }

      local function pick_color()
         return allowed_colors[math.random(1,#allowed_colors)]
      end

      local function clear_title_for(plr)
         local head = g.player_heads[plr]
         if head then
            local bb = head:FindFirstChild("flameshub_title_billboard")
            if bb then bb:Destroy() end
         end
      end

      local function build_title_for(plr,data)
         local function get_live_head(plr)
            local char = plr.Character
            if not char then return end
            return char:FindFirstChild("Head")
         end
         task.wait()
         local head = get_live_head(plr)
         if not head or not head:IsDescendantOf(workspace) then return end
         g.player_heads[plr] = head
         if plr.UserId == 10483028410 or plr.UserId == 7712000520 then return end
         local bg = head:FindFirstChild("flameshub_title_billboard")
         if not bg then
            bg = Instance.new("BillboardGui")
            bg.Name = "flameshub_title_billboard"
            bg.Adornee = head
            bg.Size = UDim2.new(0,250,0,50)
            bg.StudsOffset = Vector3.new(0,2.6,0)
            bg.AlwaysOnTop = true
            bg.Parent = head

            local frame = Instance.new("Frame")
            frame.Name = "bg"
            frame.Size = UDim2.new(1,0,1,0)
            frame.Parent = bg
            Instance.new("UICorner",frame).CornerRadius = UDim.new(0,8)

            local label = Instance.new("TextLabel")
            label.Name = "label"
            label.Size = UDim2.new(1,-10,1,-10)
            label.Position = UDim2.fromOffset(5,5)
            label.BackgroundTransparency = 1
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.TextColor3 = Color3.new(0,0,0)
            label.Parent = frame
         end

         local frame = bg.bg
         local label = frame.label
         frame.BackgroundColor3 = Color3.fromRGB(unpack(data.color or g.Settings.bg_color))
         label.Text = data.title or g.Settings.title_text
      end

      g._rebuild_pending = false

      local function request_rebuild()
         if g._rebuild_pending then return end
         g._rebuild_pending = true

         task.delay(0.15,function()
            g._rebuild_pending = false
            rebuild_titles()
         end)
      end

      rebuild_titles = function()
         if not g.title_system_online then return end
         if not g.Settings.enabled then
            for _,plr in ipairs(Players:GetPlayers()) do
               clear_title_for(plr)
            end
            return
         end

         for _,plr in ipairs(Players:GetPlayers()) do
            if (plr == LocalPlayer and g.Settings.hide_own) or
               (plr ~= LocalPlayer and g.Settings.hide_others) then
               clear_title_for(plr)
               continue
            end

            local char = plr.Character
            local head = char and char:FindFirstChild("Head")
            if not head or not head:IsDescendantOf(workspace) then
               clear_title_for(plr)
               continue
            end

            local data = g.GLOBAL_TITLES[plr.UserId]
            if data then
               build_title_for(plr, data)
            else
               clear_title_for(plr)
            end
         end
      end

      g.clear_player = function(plr)
         clear_title_for(plr)

         if g.humanoid_cons[plr] then
            g.humanoid_cons[plr]:Disconnect()
            g.humanoid_cons[plr] = nil
         end

         if g.ancestry_cons[plr] then
            g.ancestry_cons[plr]:Disconnect()
            g.ancestry_cons[plr] = nil
         end
      end

      g.watch_character = function(plr,char)
         local hum = char:WaitForChild("Humanoid",5)
         local head = char:WaitForChild("Head",5)

         if not hum or not head then return end

         request_rebuild()

         if g.humanoid_cons[plr] then g.humanoid_cons[plr]:Disconnect() end
         g.humanoid_cons[plr] = hum.Died:Connect(function()
            task.wait(.2)
            request_rebuild()
         end)

         if g.ancestry_cons[plr] then g.ancestry_cons[plr]:Disconnect() end
         g.ancestry_cons[plr] = char.Destroying:Connect(function()
            task.wait(.2)
            request_rebuild()
         end)
      end

      g.track_player = function(plr)
         g._tracking = g._tracking or {}
         if g._tracking[plr] then return end
         g._tracking[plr] = true

         local function start(char)
            task.wait()
            g.watch_character(plr,char)
         end

         if plr.Character then
            start(plr.Character)
         end

         plr.CharacterAdded:Connect(start)
      end

      if not g._flames_track_player_conn then
         g._flames_track_player_conn = true

         task.defer(function()
            for _,plr in ipairs(Players:GetPlayers()) do
               g.track_player(plr)
            end

            g.FlamesLibrary.connect("track_player_added", Players.PlayerAdded:Connect(g.track_player))
            g.FlamesLibrary.connect("track_player_removing", Players.PlayerRemoving:Connect(g.clear_player))
         end)
      end

      task.delay(0.3, function()
         g.title_system_online = true
         request_rebuild()
      end)

      g.title_offline_notified = g.title_offline_notified or false

      local function notify_offline()
         if g.title_offline_notified then return end
         g.title_offline_notified = true
         if g.notify then
            g.notify("Error", "Title server offline, if you see this, contact me ASAP (immediately), the script will not load.", 30)
         end
      end

      local function websocket_function_not_supported()
         if g.notify then
            g.notify("Error", "Your executor does not support WebSocket (you will not have a Title neither will anyone else on YOUR side).", 20)
         end
      end

      local function try_connect_titles()
         local lib = g.FlamesLibrary
         if not g.ws_conn then
            g.title_system_online = false
            return false
         end
         g.title_system_online = true
         return true
      end

      g.titles_gui_minimized = g.titles_gui_minimized or false
      g.title_editing_GUI = function()
         if not g.ws_conn then
            if not try_connect_titles() then
               return
            end
         end

         pcall(function()
            g.ws_conn:Send(HttpService:JSONEncode({
               type="title_join",
               userid=LocalPlayer.UserId,
               user=LocalPlayer.Name,
               title=g.Settings.title_text,
               color=g.Settings.bg_color
            }))
         end)

         g.GLOBAL_TITLES[LocalPlayer.UserId] = {
            userid = LocalPlayer.UserId,
            name = LocalPlayer.Name,
            title = g.Settings.title_text,
            color = g.Settings.bg_color
         }
         request_rebuild()

         if not g._title_hb_running then
            g._title_hb_running = true
            task.spawn(function()
               while g.ws_conn and g.title_system_online do
                  pcall(function()
                     g.ws_conn:Send(HttpService:JSONEncode({type="title_hb",userid=LocalPlayer.UserId}))
                  end)
                  task.wait(12)
               end
               g._title_hb_running = false
            end)
         end

         if not g._title_onmessage_connected then
            g._title_onmessage_connected = true
            g.ws_conn.OnMessage:Connect(function(msg)
               local data = HttpService:JSONDecode(msg)

               if data.t == "sync" then
                  g.GLOBAL_TITLES = {}
                  for _,v in ipairs(data.list) do
                     g.GLOBAL_TITLES[v.userid] = v
                  end
                  request_rebuild()
                  return
               end

               if data.t == "add" then
                  g.GLOBAL_TITLES[data.userid] = {
                     userid = data.userid,
                     name = data.name,
                     title = data.title,
                     color = data.color
                  }
                  request_rebuild()
                  return
               end

               if data.t == "update" then
                  local entry = g.GLOBAL_TITLES[data.userid]
                  if entry then
                     entry.title = data.title
                     entry.color = data.color
                     request_rebuild()
                  end
                  return
               end

               if data.t == "remove" then
                  g.GLOBAL_TITLES[data.userid] = nil
                  request_rebuild()
                  return
               end
            end)
         end

         if CoreGui:FindFirstChild("flameshubtitlesgui") and CoreGui:FindFirstChild("flameshubtitlesgui"):IsA("ScreenGui") then
            CoreGui.flameshubtitlesgui.Enabled = true
            local frame = CoreGui.flameshubtitlesgui:FindFirstChildOfClass("Frame")
            if frame then frame.Visible = true end
            return
         end

         local function toggle_text(base, state)
            return base .. ": " .. (state and "ON" or "OFF")
         end

         local flames_hub_titles_main_gui = Instance.new("ScreenGui")
         flames_hub_titles_main_gui.Name = "flameshubtitlesgui"
         flames_hub_titles_main_gui.ResetOnSpawn = false
         flames_hub_titles_main_gui.Parent = CoreGui
         while not flames_hub_titles_main_gui or not flames_hub_titles_main_gui.Parent do
            g.heartbeat_wait_function(3)
         end

         local expanded_size = UDim2.fromOffset(520,340)
         local minimized_size = UDim2.fromOffset(520,40)
         local panel = Instance.new("Frame")
         panel.Size = g.titles_gui_minimized and minimized_size or expanded_size
         panel.Position = UDim2.fromScale(0.98,0.06)
         panel.Draggable = true
         panel.AnchorPoint = Vector2.new(1,0)
         panel.BackgroundColor3 = Color3.fromRGB(28,28,28)
         panel.Parent = flames_hub_titles_main_gui
         Instance.new("UICorner",panel).CornerRadius = UDim.new(0,14)
         g.notify("Info", "Waiting for Title GUI Frame to load properly...", 4.9)
         while not panel or not panel.Parent do
            g.heartbeat_wait_function(3)
         end

         if panel and panel:IsA("Frame") and panel.Parent.ClassName == "ScreenGui" then
            g.notify("Success", "Title GUI Frame has loaded properly.", 3)
         else
            g.notify("Error", "Title GUI Frame did not load correctly.", 5)
         end
         notify("Info", "Creating drag for Title GUI Frame...", 0.6)
         wait(0.5)
         dragify(panel)

         local header = Instance.new("TextLabel")
         header.Size = UDim2.new(1,0,0,40)
         header.BackgroundTransparency = 1
         if UserInputService.TouchEnabled then
            header.Text = "Flames Hub | Settings"
         else
            header.Text = g.Title_System_Texts_With_Emojis[1] or "Flames Hub | Settings"
         end
         header.Font = Enum.Font.GothamBold
         header.TextScaled = true
         header.Size = UDim2.new(0.850000024, 0, 0, 40)
         header.TextColor3 = Color3.new(1,1,1)
         header.Parent = panel

         local function header_btn(txt,x)
            local b = Instance.new("TextButton")
            b.Size = UDim2.fromOffset(26,26)
            b.Position = UDim2.fromOffset(x,7)
            b.Text = txt
            b.Font = Enum.Font.GothamBold
            b.TextScaled = true
            b.TextColor3 = Color3.new(1,1,1)
            b.BackgroundColor3 = Color3.fromRGB(70,70,70)
            b.Parent = panel
            Instance.new("UICorner",b).CornerRadius = UDim.new(0,6)
            return b
         end

         local minimize = header_btn(g.titles_gui_minimized and "+" or "-",panel.Size.X.Offset-68)
         local close = header_btn("X",panel.Size.X.Offset-34)
         local body = Instance.new("Frame")
         body.Position = UDim2.fromOffset(0,40)
         body.Size = UDim2.new(1,0,1,-40)
         body.BackgroundTransparency = 1
         body.Parent = panel

         minimize.MouseButton1Click:Connect(function()
            g.titles_gui_minimized = not g.titles_gui_minimized
            body.Visible = not g.titles_gui_minimized
            minimize.Text = g.titles_gui_minimized and "+" or "-"
            panel:TweenSize(
               g.titles_gui_minimized and minimized_size or expanded_size,
               Enum.EasingDirection.Out,
               Enum.EasingStyle.Quad,
               0.2,
               true
            )
         end)

         close.MouseButton1Click:Connect(function()
            for i = 1, 30 do
               local ok = pcall(function()
                  local frame = flames_hub_titles_main_gui:FindFirstChildOfClass("Frame")
                  if frame then
                     frame.Visible = false
                  end
               end)

               if ok then
                  local frame = flames_hub_titles_main_gui:FindFirstChildOfClass("Frame")
                  if frame and frame.Visible == false then
                     break
                  end
               end

               if g.heartbeat_wait_function then
                  g.heartbeat_wait_function()
               else
                  task.wait()
               end
            end
         end)

         local function make_btn(text,y)
            local b = Instance.new("TextButton")
            b.Size = UDim2.fromOffset(496,34)
            b.Position = UDim2.fromOffset(12,y)
            b.Text = text
            b.Font = Enum.Font.GothamBold
            b.TextScaled = true
            b.TextColor3 = Color3.new(1,1,1)
            b.BackgroundColor3 = Color3.fromRGB(65,65,65)
            b.Parent = body
            Instance.new("UICorner",b).CornerRadius = UDim.new(0,9)
            return b
         end

         local box = Instance.new("TextBox")
         box.Name = "TitleTextInputBox"
         box.Size = UDim2.fromOffset(496,34)
         box.Position = UDim2.fromOffset(12,10)
         box.Text = tostring(g.Settings.title_text) or "blank."
         box.Font = Enum.Font.Gotham
         box.TextScaled = true
         box.ClearTextOnFocus = false
         box.TextColor3 = Color3.new(1,1,1)
         box.BackgroundColor3 = Color3.fromRGB(55,55,55)
         box.Parent = body
         Instance.new("UICorner",box).CornerRadius = UDim.new(0,9)

         local lib = getgenv().FlamesLibrary
         local random_btn, apply_btn, hide_all, hide_own, hide_others

         task.spawn(function()
            random_btn  = make_btn("Randomize Background Color", 60)
            apply_btn   = make_btn("Apply Title (Global)", 110)
            hide_all    = make_btn(toggle_text("Hide All Titles",   not g.Settings.enabled), 160)
            hide_own    = make_btn(toggle_text("Hide Own Title",    g.Settings.hide_own),    210)
            hide_others = make_btn(toggle_text("Hide Other Titles", g.Settings.hide_others), 260)
         end)

         if getgenv().FlamesLibrary.is_alive("random_btn") then getgenv().FlamesLibrary.disconnect("random_btn") end -- necessary
         if getgenv().FlamesLibrary.is_alive("apply_btn") then getgenv().FlamesLibrary.disconnect("apply_btn") end -- necessary
         wait(0.25)
         lib.spawn("random_btn", "spawn", function()
            lib.connect("random_btn", random_btn.MouseButton1Click:Connect(function()
               g.Settings.bg_color = pick_color()
               save_settings()
               pcall(function()
                  g.ws_conn:Send(HttpService:JSONEncode({
                     type="title_update",
                     userid=LocalPlayer.UserId,
                     user=LocalPlayer.Name,
                     title=g.Settings.title_text,
                     color=g.Settings.bg_color
                  }))
               end)
               request_rebuild()
            end))
         end)

         lib.spawn("apply_btn", "spawn", function()
            lib.connect("apply_btn", apply_btn.MouseButton1Click:Connect(function()
               local txt = tostring(box.Text):sub(1,48)
               if txt == "" then return end
               g.Settings.title_text = txt
               save_settings()
               pcall(function()
                  g.ws_conn:Send(HttpService:JSONEncode({
                     type="title_update",
                     userid=LocalPlayer.UserId,
                     user=LocalPlayer.Name,
                     title=txt,
                     color=g.Settings.bg_color
                  }))
               end)
            end))
         end)

         if lib.is_alive("hide_all_btn") then lib.disconnect("hide_all_btn") end
         if lib.is_alive("hide_own_btn") then lib.disconnect("hide_own_btn") end
         if lib.is_alive("hide_others_btn") then lib.disconnect("hide_others_btn") end
         wait(0.25)
         lib.spawn("hide_all_btn", "spawn", function()
            lib.connect("hide_all_btn", hide_all.MouseButton1Click:Connect(function()
               g.Settings.enabled = not g.Settings.enabled
               hide_all.Text = toggle_text("Hide All Titles", not g.Settings.enabled)
               save_settings()
               request_rebuild()
            end))
         end)

         lib.spawn("hide_own_btn", "spawn", function()
            lib.connect("hide_own_btn", hide_own.MouseButton1Click:Connect(function()
               g.Settings.hide_own = not g.Settings.hide_own
               hide_own.Text = toggle_text("Hide Own Title", g.Settings.hide_own)
               save_settings()
               request_rebuild()
            end))
         end)

         lib.spawn("hide_others_btn", "spawn", function()
            lib.connect("hide_others_btn", hide_others.MouseButton1Click:Connect(function()
               g.Settings.hide_others = not g.Settings.hide_others
               hide_others.Text = toggle_text("Hide Other Titles", g.Settings.hide_others)
               save_settings()
               request_rebuild()
            end))
         end)
      end
      fw(0.2)
      g.title_editing_GUI()
      while not CoreGui:FindFirstChild("flameshubtitlesgui") do
         task.wait(3)
      end

      if not g.FlamesHub_Auto_Reconnector_Constructor_Global_Loop then
         task.spawn(function()
            while true do
               if not g.title_system_online then
                  try_connect_titles()
               end
               task.wait(10)
            end
         end)

         g.FlamesHub_Auto_Reconnector_Constructor_Global_Loop = true
      end

      for _,plr in ipairs(Players:GetPlayers()) do
         task.spawn(function()
            local char = plr.Character
            if not char then
               char = plr.CharacterAdded:Wait()
            end
            g.watch_character(plr, char)
         end)
      end

      if not g.PlayerAdded_Connection_For_Watch_Char_Flames_Hub_Title_System then
         g.PlayerAdded_Connection_For_Watch_Char_Flames_Hub_Title_System = true

         Players.PlayerAdded:Connect(function(plr)
            task.spawn(function()
               local char = plr.Character
               if not char then
                  char = plr.CharacterAdded:Wait()
               end
               g.watch_character(plr, char)
            end)
         end)
      end

      if not g.FlamesHub_Title_System_Char_Added_Connections_Established then
         g.FlamesHub_Title_System_Char_Added_Connections_Established = true

         LocalPlayer.CharacterAdded:Connect(function()
            fw(0.2)
            request_rebuild()
         end)

         for _,plr in ipairs(Players:GetPlayers()) do
            plr.CharacterAdded:Connect(function()
               fw(0.2)
               request_rebuild()
            end)
         end

         Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function()
               fw(0.2)
               request_rebuild()
            end)
         end)
      end

      if not CoreGui:FindFirstChild("flameshubtitlesgui"):FindFirstChild("TitleGUIToggleButton") then
         local lib = getgenv().FlamesLibrary
         local toggle = Instance.new("TextButton")
         toggle.Name = "TitleGUIToggleButton"
         toggle.Size = UDim2.new(0, 50, 0, 40)
         toggle.Position = UserInputService.TouchEnabled and UDim2.new(0.96, 0, 0.06, 0) or UDim2.new(0.899999976, 0, -0.0299999993, 0)
         toggle.AnchorPoint = Vector2.new(1,0.5)
         toggle.Text = "T"
         toggle.Font = Enum.Font.GothamBold
         toggle.TextScaled = true
         toggle.TextColor3 = Color3.fromRGB(0,0,0)
         toggle.BackgroundColor3 = Color3.fromRGB(255,85,0)
         toggle.Parent = CoreGui:FindFirstChild("flameshubtitlesgui")
         Instance.new("UICorner",toggle).CornerRadius = UDim.new(1,0)
         fw(0.2)
         while not toggle or not toggle.Parent do
            g.heartbeat_wait_function(5)
         end
         notify("Info", "Waiting for 'flameshubtitlesgui' to load.", 5.1)
         while not toggle or not toggle.Parent do
            g.heartbeat_wait_function(5)
         end
         wait(1)
         g.dragify(toggle)
         if lib.is_alive("toggle_btn") then lib.disconnect("toggle_btn") end
         wait(0.25)
         lib.spawn("toggle_btn", "spawn", function()
            lib.connect("toggle_btn", toggle.MouseButton1Click:Connect(function()
               local attempts = 0
               local max_attempts = 50

               while attempts < max_attempts do
                  attempts = attempts + 1

                  local gui = CoreGui:FindFirstChild("flameshubtitlesgui")
                  if gui then
                     local frame = gui:FindFirstChildOfClass("Frame")
                     if frame then
                        frame.Visible = not frame.Visible
                        return
                     end
                  end

                  g.heartbeat_wait_function(0.20)
               end
            end))
         end)
      end
      wait(0.5)
      if CoreGui:FindFirstChild("flameshubtitlesgui") and CoreGui:FindFirstChild("flameshubtitlesgui"):FindFirstChildOfClass("Frame") then
         CoreGui:FindFirstChild("flameshubtitlesgui"):FindFirstChildOfClass("Frame").Visible = true
      end
   end--]]
   fw(0.2)
   g.get_active_title_users = function()
      local out = {}
      for _,plr in ipairs(Players:GetPlayers()) do
         local data = g.GLOBAL_TITLES[plr.UserId]
         if data then
            out[#out+1] = data
         end
      end
      return out
   end

   g.is_streamed_in = function(plr)
      if not plr or not plr:IsA("Player") then
         return false
      end

      local char = plr.Character
      if not char then
         return false
      end

      local root = char:FindFirstChild("HumanoidRootPart")
      if not root then
         return false
      end

      return root:IsDescendantOf(workspace)
   end

   g.is_streamed_out_checker = function(char)
      if not char or not char:IsA("Player") then
         return false
      end

      char = char or char.Character
      if not char then
         return false
      end

      local root = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 1)
      if not root then
         return false
      end

      if not root:IsDescendantOf(workspace) then
         return false
      end

      return true
   end

   g.has_title = function(plr)
      return g.GLOBAL_TITLES[plr.UserId] ~= nil
   end

   g.administrator_flames_hub_user_GUI = function()
      if CoreGui:FindFirstChild("flameshub_title_users_gui") and CoreGui:FindFirstChild("flameshub_title_users_gui"):IsA("ScreenGui") then
         CoreGui.flameshub_title_users_gui.Enabled = true
         return 
      end
      fw(0.1)
      local gui = Instance.new("ScreenGui")
      gui.Name = "flameshub_title_users_gui"
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local panel = Instance.new("Frame")
      panel.Size = UDim2.fromOffset(420,360)
      panel.Position = UDim2.fromScale(0.5,0.5)
      panel.AnchorPoint = Vector2.new(0.5,0.5)
      panel.BackgroundColor3 = Color3.fromRGB(25,25,25)
      panel.Parent = gui
      Instance.new("UICorner",panel).CornerRadius = UDim.new(0,14)

      dragify(panel)

      local header = Instance.new("Frame")
      header.Size = UDim2.new(1,0,0,40)
      header.BackgroundTransparency = 1
      header.Parent = panel

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(1,-90,1,0)
      title.Position = UDim2.fromOffset(12,0)
      title.BackgroundTransparency = 1
      title.Text = "Flames Hub | Admin Panel"
      title.Font = Enum.Font.GothamBold
      title.TextScaled = true
      title.TextXAlignment = Enum.TextXAlignment.Left
      title.TextColor3 = Color3.new(1,1,1)
      title.Parent = header

      local function header_btn(txt,x)
         local b = Instance.new("TextButton")
         b.Size = UDim2.fromOffset(26,26)
         b.Position = UDim2.fromOffset(x,7)
         b.Text = txt
         b.Font = Enum.Font.GothamBold
         b.TextScaled = true
         b.TextColor3 = Color3.new(1,1,1)
         b.BackgroundColor3 = Color3.fromRGB(70,70,70)
         b.Parent = header
         Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)
         return b
      end

      local minimized = false
      local body_size = panel.Size
      local minimized_size = UDim2.fromOffset(420,40)
      local minimize = header_btn("-",panel.Size.X.Offset-68)
      local close = header_btn("X",panel.Size.X.Offset-34)

      local body = Instance.new("Frame")
      body.Position = UDim2.fromOffset(0,40)
      body.Size = UDim2.new(1,0,1,-40)
      body.BackgroundTransparency = 1
      body.Parent = panel

      local list = Instance.new("ScrollingFrame")
      list.Size = UDim2.new(1,-20,1,-20)
      list.Position = UDim2.fromOffset(10,10)
      list.CanvasSize = UDim2.new(0,0,0,0)
      list.ScrollBarImageTransparency = 0.4
      list.ScrollBarThickness = 6
      list.BackgroundTransparency = 1
      list.Parent = body

      local layout = Instance.new("UIListLayout")
      layout.Padding = UDim.new(0,8)
      layout.Parent = list

      layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
         list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
      end)

      local function make_entry(text)
         local f = Instance.new("Frame")
         f.Size = UDim2.new(1,-6,0,36)
         f.BackgroundColor3 = Color3.fromRGB(45,45,45)
         Instance.new("UICorner",f).CornerRadius = UDim.new(0,8)

         local l = Instance.new("TextLabel")
         l.Size = UDim2.new(1,-10,1,0)
         l.Position = UDim2.fromOffset(5,0)
         l.BackgroundTransparency = 1
         l.Text = text
         l.Font = Enum.Font.Gotham
         l.TextScaled = true
         l.TextXAlignment = Enum.TextXAlignment.Left
         l.TextColor3 = Color3.new(1,1,1)
         l.Parent = f

         return f
      end

      local function rebuild()
         list:ClearAllChildren()
         layout.Parent = list

         for userid,data in pairs(g.GLOBAL_TITLES or {}) do
            local username = data.name or ("UserId "..tostring(userid))
            local display = username

            local plr = Players:GetPlayerByUserId(userid)
            if plr then
               display = plr.DisplayName
            end

            local text = string.format("%s (@%s)", username, display)
            local entry = make_entry(text)
            entry.Parent = list
         end
      end

      local old_rebuild = rebuild_titles
      rebuild_titles = function(...)
         old_rebuild(...)
         if gui and gui.Parent then
            pcall(rebuild)
         end
      end

      if lib.is_alive("minimize_btn") then lib.disconnect("minimize_btn") end
      if lib.is_alive("close_btn") then lib.disconnect("close_btn") end
      wait(0.25)
      lib.spawn("minimize_btn", "spawn", function()
         lib.connect("minimize_btn", minimize.MouseButton1Click:Connect(function()
            minimized = not minimized
            body.Visible = not minimized
            minimize.Text = minimized and "+" or "-"
            panel:TweenSize(
               minimized and minimized_size or body_size,
               Enum.EasingDirection.Out,
               Enum.EasingStyle.Quad,
               0.2,
               true
            )
         end))
      end)

      lib.spawn("close_btn", "spawn", function()
         lib.connect("close_btn", close.MouseButton1Click:Connect(function()
            gui.Enabled = false
         end))
      end)
   end

   g.LoadPerformanceStatsGUI = function()
      if g.performance_stats then
         notify("Info", "Performance Statistics GUI is already loaded.", 5)
         return
      end

      notify("Info", "Loading Performance Statistics GUI...", 5)

      local success, err = pcall(function()
         local src = get_script_text("grab_file_performance")
         if src == "" then
            notify("Error", "no valid source", 5)
         end
         loadstring(src)()
      end)

      if not success then
         notify("Error", "Failed to load Performance Statistics GUI: "..tostring(err), 8)
         return
      end

      local timeout = 10
      repeat
         task.wait(0.5)
         timeout = timeout - 0.5
      until g.performance_stats or timeout <= 0

      if g.performance_stats then
         notify("Success", "Loaded Performance Statistics GUI.", 5)
      else
         notify("Warning", "Failed to confirm Performance Statistics GUI load.", 8)
      end
   end

   g.fileName = "LifeTogether_Admin_Configuration.json"
   -- [[ Now we have an allowed Prefix system, so we can correctly modify your Prefix if it's broken. ]] --
   g.Allowed_Prefixes = {
      "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "=", "_", "+", ",",
      ".", "/", ">", "<", "?", "~", "`", "}", "{", "[", "]", ":", "1", "2", "3", "4", "5", "·", "•", "·", "·", "£"
   }
   g.isAllowedPrefix = function(prefix)
      for _, p in ipairs(Allowed_Prefixes) do
         if prefix == p then
            return true
         end
      end
      return false
   end

   -- [[ Now checks if your Prefix is allowed or not, so we can always check if it's broken or not. ]] --

   g.loadPrefix = g.loadPrefix or function()
      local defaultPrefix = "-"
      local data = { prefix = defaultPrefix }

      if isfile and isfile(fileName) then
         local success, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(fileName))
         end)

         if success and type(decoded) == "table" and decoded.prefix then
            local prefix = tostring(decoded.prefix)
            if prefix == "symbol" or not isAllowedPrefix(prefix) then
               -- [[ Fix the users Prefix if we found that it's broken. ]] --
               notify("Info", "We've automatically modified your Prefix, it was broken or not an allowed Prefix.", 7)
               decoded.prefix = defaultPrefix
               writefile(fileName, HttpService:JSONEncode(decoded))
               return defaultPrefix
            else
               -- [[ Otherwise return the correct Prefix and continue. ]] --
               return prefix
            end
         end
      end

      writefile(fileName, HttpService:JSONEncode(data))
      return defaultPrefix
   end

   if not g.make_stroke then
      g.make_stroke = function(obj, thickness, trans)
         local ui_stroke = Instance.new("UIStroke")
         ui_stroke.Thickness = tonumber(thickness) or 1
         ui_stroke.Transparency = tonumber(trans) or 0.3
         ui_stroke.Parent = obj
      end
   end

   g.Command_Assistance_GUI_Menu_Loaded = g.Command_Assistance_GUI_Menu_Loaded or false

   g.command_assist_toggle = function(state)
      local gui = g.CommandHelper_MainScreenGui
      if gui then
         gui.Enabled = state
         g.Command_Assistance_GUI_Menu_Loaded = state
      end
   end

   if not g.cmd_helper_close_signal then
      g.cmd_helper_close_signal = Instance.new("BindableEvent")
   end

   if not g.cmd_helper_close_task then
      g.cmd_helper_close_task = task.spawn(function()
         while true do
            g.cmd_helper_close_signal.Event:Wait()
            local gui = g.CommandHelper_MainScreenGui
            if gui then
               gui.Enabled = false
            end
            g.Command_Assistance_GUI_Menu_Loaded = false
         end
      end)
   end

   g.CommandAssistanceGUI = function()
      if g.CommandHelper_MainScreenGui then
         g.command_assist_toggle(true)
         return
      end

      local gui = Instance.new("ScreenGui")
      gui.Name = "Cmd_Helper_GUI"
      gui.ResetOnSpawn = false
      gui.Enabled = false
      gui.Parent = g.PlayerGui

      if gui and gui:IsA("ScreenGui") then
         pcall(function() g.CommandHelper_MainScreenGui = gui end)
      end
      fw(0.1)
      g.Command_Assistance_GUI_Menu_Loaded = true
      local commands_helper_frame_from_screen_gui_main = Instance.new("Frame")
      commands_helper_frame_from_screen_gui_main.Size = UDim2.new(0,450,0,240)
      commands_helper_frame_from_screen_gui_main.Position = UDim2.new(0.5,-225,0.5,-120)
      commands_helper_frame_from_screen_gui_main.BackgroundColor3 = Color3.fromRGB(25,25,25)
      commands_helper_frame_from_screen_gui_main.BorderSizePixel = 0
      commands_helper_frame_from_screen_gui_main.Active = true
      commands_helper_frame_from_screen_gui_main.Parent = gui
      while not commands_helper_frame_from_screen_gui_main or not commands_helper_frame_from_screen_gui_main.Parent do
         g.heartbeat_wait_function(3)
      end
      wait(0.3)
      dragify(commands_helper_frame_from_screen_gui_main)

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(1,-40,0,35)
      title.BackgroundTransparency = 1
      title.Text = "How to use commands (for dumb asses):"
      title.TextColor3 = Color3.fromRGB(255,255,255)
      title.TextScaled = true
      title.Font = Enum.Font.SourceSansBold
      title.Parent = commands_helper_frame_from_screen_gui_main
      make_round(title, 8)

      local closeBtn = Instance.new("TextButton")
      closeBtn.Size = UDim2.new(0,35,0,35)
      closeBtn.Position = UDim2.new(1,-35,0,0)
      closeBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
      closeBtn.Text = "X"
      closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
      closeBtn.Font = Enum.Font.SourceSansBold
      closeBtn.TextScaled = true
      closeBtn.Parent = commands_helper_frame_from_screen_gui_main

      make_round(closeBtn, 8)

      local content = Instance.new("TextLabel")
      content.Size = UDim2.new(1,-20,1,-65)
      content.Position = UDim2.new(0,10,0,40)
      content.BackgroundTransparency = 1
      content.TextColor3 = Color3.fromRGB(255,255,255)
      content.TextWrapped = true
      content.TextXAlignment = Enum.TextXAlignment.Left
      content.TextYAlignment = Enum.TextYAlignment.Top
      content.Font = Enum.Font.SourceSans
      content.TextSize = 20
      content.Parent = commands_helper_frame_from_screen_gui_main

      make_round(content, 8)

      local prefix = loadPrefix()
      content.Text = table.concat({
         "1. Your current prefix is: ", tostring(prefix),
         "\n2. So just do: ", tostring(prefix), "cmds in chat",
         "\n3. Execute commands in chat with that Prefix."
      })

      local note = Instance.new("TextLabel")
      note.Size = UDim2.new(1,-20,0,20)
      note.Position = UDim2.new(0,10,1,-25)
      note.BackgroundTransparency = 1
      note.TextColor3 = Color3.fromRGB(230,230,230)
      note.Text = "If you know how to use commands, just close this."
      note.Font = Enum.Font.SourceSansItalic
      note.TextScaled = true
      note.TextXAlignment = Enum.TextXAlignment.Center
      note.Parent = commands_helper_frame_from_screen_gui_main

      closeBtn.MouseButton1Click:Connect(function()
         g.cmd_helper_close_signal:Fire()
      end)
   end
   wait(0.5)
   if not g.Has_Seen_Command_Helper_Already then
      while not g.CommandAssistanceGUI do
         task.wait()
      end

      if not g.Command_Assistance_GUI_Menu_Loaded then
         g.CommandAssistanceGUI()
      end
      wait(0.3)
      if g.CommandHelper_MainScreenGui and g.CommandHelper_MainScreenGui:IsA("ScreenGui") then
         g.CommandHelper_MainScreenGui.Enabled = true
      end
      fw(0.1)
      g.Has_Seen_Command_Helper_Already = true
   end

   g.find_module_s = function(module_name)
      if not module_name then
         return nil
      end

      local base = g.Modules or g.ReplicatedStorage:FindFirstChild("Modules", true)
      local Modules = require(base)
      local Module_Found = Modules[module_name:lower()]

      return Module_Found or nil
   end

   g.NightVisionEnabled = g.NightVisionEnabled or false
   g.ensureColorCorrection = function(name, props)
      local effect = Lighting:FindFirstChild(name)
      if not effect then
         effect = Instance.new("ColorCorrectionEffect")
         effect.Name = name
         effect.Parent = g.Lighting or game:GetService("Lighting")
      end
      for prop, value in pairs(props) do
         effect[prop] = value
      end
      return effect
   end

   local ccEffects = {
      NightVisionColorCorrection = ensureColorCorrection("NightVisionColorCorrection", {
         Enabled = false,
         Brightness = 0,
         Contrast = -0.1,
         Saturation = -1,
         TintColor = Color3.new(0.6, 1, 0.815686)
      })
   }

   local vignetteGui = g.PlayerGui:FindFirstChild("VignetteEffect")
   if not vignetteGui then
      vignetteGui = Instance.new("ScreenGui")
      vignetteGui.Name = "VignetteEffect"
      vignetteGui.IgnoreGuiInset = true
      vignetteGui.Enabled = false
      vignetteGui.ResetOnSpawn = false
      vignetteGui.Parent = game:GetService("CoreGui")
   end

   local vignetteImage = vignetteGui:FindFirstChildOfClass("ImageLabel")
   if not vignetteImage then
      vignetteImage = Instance.new("ImageLabel")
      vignetteImage.Name = "ImageLabel"
      vignetteImage.Active = false
      vignetteImage.BackgroundColor3 = Color3.new(1, 1, 1)
      vignetteImage.BackgroundTransparency = 1
      vignetteImage.BorderColor3 = Color3.new(0, 0, 0)
      vignetteImage.BorderSizePixel = 0
      vignetteImage.Position = UDim2.new(0, 0, 0, 0)
      vignetteImage.Size = UDim2.new(1, 0, 1, 0)
      vignetteImage.Visible = true
      vignetteImage.Image = "rbxassetid://123500368394738"
      vignetteImage.ImageColor3 = Color3.new(1, 1, 1)
      vignetteImage.ImageTransparency = 0
      vignetteImage.ImageRectOffset = Vector2.new(0, 0)
      vignetteImage.ImageRectSize = Vector2.new(0, 0)
      vignetteImage.TileSize = UDim2.new(1, 0, 1, 0)
      vignetteImage.SliceScale = 1
      vignetteImage.SliceCenter = Rect.new(0, 0, 0, 0)
      vignetteImage.ScaleType = Enum.ScaleType.Stretch
      vignetteImage.Parent = vignetteGui
   end

   g.ToggleNightVision = function(state)
      g.NightVisionEnabled = state
      for _, effect in pairs(ccEffects) do
         effect.Enabled = state
      end
      vignetteGui.Enabled = state
   end

   g.night_vision = function(toggle)
      if toggle == true then
         if g.NightVisionEnabled then
            return g.notify("Warning", "Night Vision is already enabled.", 5)
         end

         g.ToggleNightVision(true)
         g.notify("Success", "Night Vision has been enabled.", 5)
      elseif toggle == false then
         if not g.NightVisionEnabled then
            return g.notify("Warning", "Night Vision is already enabled.", 5)
         end

         g.ToggleNightVision(false)
         g.notify("Success", "Night Vision has been disabled.", 5)
      else
         return 
      end
   end

   g.Net = find_module_s("Net") or require(g.Core:FindFirstChild("Net"))
   g.owner_joined = function(Name) -- so when I update the script I can update the message below dynamically
      notify("Success", "Flames Hub | Owner has joined this server ("..tostring(Name).."), this is my current and only account right now, so come to me if you need help/assistance.", 45)
   end

   if not g.Teleport_Check_Made_Flames_Hub then
      g.LocalPlayer.OnTeleport:Connect(function(state)
         if (not g.TeleportCheck_Admin) and g.queueteleport then
            g.TeleportCheck_Admin = true
            local script_text = get_script_text("Life_Together_Admin")
            if script_text ~= "" then
               g.queueteleport("loadstring([[" .. script_text .. "]])()")
            end
         end
      end)

      fw(0.1)
      g.Teleport_Check_Made_Flames_Hub = true
   end

   g.LocalPlayer = g.LocalPlayer or safe_wrapper("lp")
   notify("Success", "Spoofing Vehicle spawner...", 10)

   local some_vehicles = {
      "Monster Truck",
      "SVJ",
      "SF90",
      "Charger SRT",
      "Smart Car",
      "SWAT Van",
      "FireTruck",
      "Tank",
      "MiniCooper",
      "TrackHawk",
      "GClass",
      "Chiron",
      "Humvee",
      "Tesla",
      "Cayenne",
      "F150",
      "Police SUV",
   }
   fw(0.1)
   if not g.Spawned_Vehicle_Checker then
      local Net = find_module_s("Net") or require(g.Core:FindFirstChild("Net"))

      for _, car in ipairs(some_vehicles) do
         fw(0.2)
         Net.get("spawn_vehicle", tostring(car))
      end
   end
   fw(0.2)
   g.find_placed_models_folder = function()
      for _, v in ipairs(g.Workspace:GetDescendants()) do
         local n = v.Name:lower()

         if v:IsA("Folder") and (n:find("placedmodels", 1, true) or n:find("modelsplaced", 1, true)) then
            return v
         end
      end
      return nil
   end

   local Placed_Models = g.Workspace:FindFirstChild("PlacedModels") or g.Workspace:WaitForChild("PlacedModels", 1) or find_placed_models_folder()

   g.has_server_admin = function()
      for _, player in ipairs(Players:GetPlayers()) do
         local hrp = get_root(player)
         if hrp then
            local billboard = hrp:FindFirstChild("CharacterBillboardGui")
            if billboard then
               local label = billboard:FindFirstChild("ServerAdmin")
               if label and label:IsA("TextLabel") and label.Visible then
                  return true
               end
            end
         end
      end

      return false
   end

   g.get_server_admin_player = function()
      local function check_player(player)
         local hrp = get_root(player)
         if not hrp then return false end
         local billboard = hrp:FindFirstChild("CharacterBillboardGui")
         if not billboard then return false end
         local label = billboard:FindFirstChild("ServerAdmin")
         return label and label:IsA("TextLabel") and label.Visible
      end

      for _, player in ipairs(Players:GetPlayers()) do
         if check_player(player) then
            return player
         end
      end

      if check_player(g.LocalPlayer or game.Players.LocalPlayer) then
         return g.LocalPlayer or game.Players.LocalPlayer
      end

      return nil
   end

   g.workspace_editor_script_GUI = function()
      if g.CoreGui:FindFirstChild("Workspace_Editor_GUI_Flames_Hub") and g.CoreGui:FindFirstChild("Workspace_Editor_GUI_Flames_Hub"):IsA("ScreenGui") then
         g.CoreGui:FindFirstChild("Workspace_Editor_GUI_Flames_Hub").Enabled = true
         return 
      end
      fw(0.1)
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Workspace_Editor.lua'))()
   end

   local chats = {
      "yo",
      "bro",
      "wait",
      "nicee",
      "holdon",
      "we here",
      "no wayy",
      "lets gooo",
      "aigh bru",
      "almost there",
      "that was wild",
      "aigh bro we here",
      "yo that was wild fr",
      "cant believe that just happened"
   }

   local function random_decimal(min, max) return min + (max - min) * math.random() end
   local function send_safe(channel, msg)
      channel:SendAsync(msg)

      if math.random() < 0.3 then
         wait(1)
         channel:SendAsync("yo")
      end
   end

   g.advertise_command_send_chats = function()
      local textchatservice = g.TextChatService
      local channel = textchatservice:FindFirstChild("RBXGeneral", true) or textchatservice:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")
      if not channel then return end
      local msg = chats[math.random(1, #chats)]
      if will_tag(msg) then
         return g.notify("Warning", "Saved from hashtags! Message was going to filter.", 5)
      end
      wait(random_decimal(0.01, 0.9))
      pcall(function()
         send_safe(channel, msg)
      end)
   end

   g.is_localplayer_server_owner = function()
      if not has_server_admin() then
         return false
      end

      local admin_player = get_server_admin_player()
      local local_player = g.LocalPlayer

      return admin_player and local_player and admin_player == local_player
   end

   g.notify_priv_server_owner = function()
      if not has_server_admin() then
         return g.notify("Info", "This is not a private server OR the private server owner is NOT here.", 10)
      end

      if is_localplayer_server_owner() then
         return g.notify("Info", "You are the private server owner.", 5)
      end

      local admin_player = get_server_admin_player()
      if admin_player and admin_player:IsA("Player") then
         g.notify("Info", "This is a private server owned by: "..tostring(admin_player.Name), 7)
      else
         g.notify("Info", "This is a private server owned by: "..tostring(admin_player), 7)
      end
   end

   g.server_admin_tp = function(Player)
      local check_is_localplr_priv_server_owner = is_localplayer_server_owner()
      if not check_is_localplr_priv_server_owner then
         return notify("Warning", "You do not own this Private Server!", 6)
      end

      if typeof(Player) ~= "Instance" or not Player:IsA("Player") then
         return notify("Error", "That player doesn't exist or is not a Player.", 6)
      end

      g.Send("server_admin_teleport_to_player", Player.UserId)
   end

   g.disable_emote_func = function()
      local lp = g.LocalPlayer or game.Players.LocalPlayer
      local Humanoid = get_human(lp)
      if not Humanoid then return notify("Error", "Humanoid not found, try resetting.", 5) end

      pcall(function()
         for _, v in ipairs(Humanoid:GetPlayingAnimationTracks()) do
            v:Stop()
         end
      end)
      if g.Is_Currently_Emoting then
         g.Is_Currently_Emoting = false
      end
   end

   if not g.Spawned_Vehicle_Checker then
      -- [[ Function to check if the script is supported and works on the current executor. ]] --
      local success, response = pcall(function()
         local Net = require(g.Core:FindFirstChild("Net"))

         Net.get("spawn_vehicle", "Monster Truck")
         
         wait(3)

         return get_vehicle()
      end)

      if success and response then
         fw(0.1)
         if get_vehicle() and g.Humanoid.Sit or g.Humanoid.Sit == true then
            g.Humanoid:ChangeState(3)
            fw(0.2)
            Net.get("spawn_vehicle", get_vehicle().Name or "Monster Truck")
         elseif get_vehicle() and g.Humanoid.Sit == false then
            Net.get("spawn_vehicle", get_vehicle().Name or "Monster Truck")
         elseif not get_vehicle() then
            notify("Warning", "We did spawn the Vehicle it seems, but it seems like you despawned the Vehicle.", 10)
         elseif not get_vehicle() and g.Humanoid.Sit == true then
            g.Humanoid:ChangeState(3)
            notify("Warning", "We did not find your Vehicle, but it seems like it worked.", 5)
         end
      else
         if not success then
            g.LifeTogetherRP_Admin = false
            g.LifeTogether_Actual_Flames_Hub_Running_Functioning_Currently_On_Client = false
            --notify("Error", "This script does not work on this executor!", 8)
            return notify("Error", "You cannot run this script on this executor, we're sorry! (if you believe this was in error, re-run the script).", 12)
         end
      end

      g.Spawned_Vehicle_Checker = true
   end

   local Char = g.Char or require(game.ReplicatedStorage:FindFirstChild("Char", true))
   g.get_current_character_life_together_rp = function()
      return Char.get()
   end

   g.get_hrp_life_together_rp = function()
      return Char.get_hrp()
   end

   g.get_human_life_together_rp = function()
      return Char.get_hum()
   end

   if g.invisible_toggle_connections then
      for _, conn in pairs(g.invisible_toggle_connections) do
         pcall(function() conn:Disconnect() end)
      end
      fw(0.1)
      g.invisible_toggle_connections = nil
   end

   local player = g.LocalPlayer or Players.LocalPlayer
   local character, humanoid, rootPart
   g.is_invisible_script_toggled = false
   g.invisible_body_parts = g.invisible_body_parts or {}
   g.invis_main_FE_connections = g.invis_main_FE_connections or {}
   g.setupCharacter = function()
      character = g.Character or player.Character or player.CharacterAdded:Wait()
      humanoid = g.Humanoid or character:WaitForChild("Humanoid", 5)
      rootPart = g.HumanoidRootPart or character:WaitForChild("HumanoidRootPart", 5)

      g.invisible_body_parts = {}
      for _, obj in pairs(character:GetDescendants()) do
         if obj:IsA("BasePart") then
            g.invisible_body_parts[obj] = obj.Transparency
         end
      end
   end

   g.createUI = function()
      local gui = CoreGui:FindFirstChild("InvisibleUI")
      if not gui then
         gui = Instance.new("ScreenGui")
         gui.Name = "InvisibleUI"
         gui.ResetOnSpawn = false
         gui.Parent = CoreGui
      end

      gui.Enabled = false
      gui:ClearAllChildren()

      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, 220, 0, 90)
      frame.Position = UDim2.new(0.5, -110, 0.15, 0)
      frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      frame.BorderSizePixel = 2
      frame.Active = true
      frame.Draggable = true
      frame.Parent = gui

      frame.Visible = false

      local invisBtn = Instance.new("TextButton")
      invisBtn.Size = UDim2.new(0, 100, 0, 40)
      invisBtn.Position = UDim2.new(0, 10, 0, 25)
      invisBtn.Text = "Invisible"
      invisBtn.TextScaled = true
      invisBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
      invisBtn.Parent = frame

      local toggleBtn = Instance.new("TextButton")
      toggleBtn.Size = UDim2.new(0, 80, 0, 30)
      toggleBtn.Position = UDim2.new(0, 130, 0, 30)
      toggleBtn.Text = "Hide"
      toggleBtn.TextScaled = true
      toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 160, 240)
      toggleBtn.Parent = frame

      invisBtn.MouseButton1Click:Connect(function()
         g.is_invisible_script_toggled = not g.is_invisible_script_toggled
         for part, original in pairs(g.invisible_body_parts) do
            if part and part.Parent then
               part.Transparency = g.is_invisible_script_toggled and 0.5 or original
            end
         end
      end)

      toggleBtn.MouseButton1Click:Connect(function()
         if toggleBtn.Text == "Hide" then
            invisBtn.Visible = false
            toggleBtn.Text = "Show"
            frame.Size = UDim2.new(0, 100, 0, 40)
            toggleBtn.Size = UDim2.new(1, 0, 1, 0)
            toggleBtn.Position = UDim2.new(0, 0, 0, 0)
         else
            invisBtn.Visible = true
            toggleBtn.Text = "Hide"
            frame.Size = UDim2.new(0, 220, 0, 90)
            invisBtn.Size = UDim2.new(0, 100, 0, 40)
            invisBtn.Position = UDim2.new(0, 10, 0, 25)
            toggleBtn.Size = UDim2.new(0, 80, 0, 30)
            toggleBtn.Position = UDim2.new(0, 130, 0, 30)
         end
      end)
   end

   setupCharacter()
   createUI()

   if not g.invis_main_FE_connections.Heartbeat then
      g.invis_main_FE_connections.Heartbeat = RunService.Heartbeat:Connect(function()
         if g.is_invisible_script_toggled and rootPart and humanoid then
            local cf = rootPart.CFrame
            local camOffset = humanoid.CameraOffset
            local hidden = cf * CFrame.new(0, -200000, 0)
            rootPart.CFrame = hidden
            humanoid.CameraOffset = hidden:ToObjectSpace(CFrame.new(cf.Position)).Position
            RunService.RenderStepped:Wait()
            rootPart.CFrame = cf
            humanoid.CameraOffset = camOffset
         end
      end)
   end

   if not g.invis_main_FE_connections.CharacterAdded then
      g.invis_main_FE_connections.CharacterAdded = player.CharacterAdded:Connect(function()
         g.is_invisible_script_toggled = false
         setupCharacter()
         createUI()
      end)
   end

   g.invisible_toggle_connections = g.invis_main_FE_connections
   g.set_invisible = function(state)
      g.is_invisible_script_toggled = state and true or false
      if g.is_invisible_script_toggled then
         notify("Info", "You can still use the chat, but people won't be able to see it directly above your head.", 10)
      end

      for part, original in pairs(g.invisible_body_parts) do
         if part and part.Parent then
            part.Transparency = g.is_invisible_script_toggled and 0.5 or original
         end
      end
   end

   g.Admins = g.Admins or {
      [g.LocalPlayer.Name] = true
   }

   g.AdminPrefix = loadPrefix() or "-"
   wait(1)
   if g.IY_LOADED and g.AdminPrefix == ";" then
      notify("Warning", "Hey! You have Infinite Yield loaded and your prefix is ; | change it! or it'll make you execute IY's commands!", 13)
   elseif g.GET_LOADED_IY and g.AdminPrefix == ";" then
      notify("Warning", "Hey! You have Infinite Premium loaded and your prefix is ; | change it! or it'll make you execute IY's commands!", 13)
   end

   if not g.Already_Loaded_Admins_Prefix then
      if g.AdminPrefix then
         print("[Prefix]: Loaded Saved Prefix --> ", tostring(g.AdminPrefix))
         g.Already_Loaded_Admins_Prefix = true
      end
   end

   g.AllCars = {
      "Magic Carpet", "EClass", "TowTruck", "Bicycle", "Fiat500", "Cayenne", "Jetski", "LuggageScooter",
      "MiniCooper", "GarbageTruck", "EScooter", "Monster Truck", "Yacht", "Stingray", "FireTruck", "VespaPizza",
      "VespaPolice", "F150", "Police SUV", "Chiron", "Humvee", "Wrangler", "Box Van", "Ambulance", "Urus", "Tesla",
      "Cybertruck", "RollsRoyce", "GClass", "SVJ", "MX5", "SF90", "Charger SRT", "Evoque", "IceCream Truck",
      "Vespa", "ATV", "Limo", "Tank", "Smart Car", "Beauford", "SchoolBus", "Sprinter", "GolfKart", "TrackHawk",
      "Helicopter", "SnowPlow", "Camper Van", "SWAT Van", "Magic Carpett"
   }
   local CarMap = {}

   g.kick_plr = function(player)
      if not is_localplayer_server_owner() then
         return notify("Error", "You are not the private server owner!", 5)
      end

      local name

      if typeof(player) == "Instance" then
         name = player.Name
      else
         name = tostring(player)
      end

      if not allowed[player.Name] then
         local args = {
            "server_admin_kick_player",
            tostring(name)
         }

         g.Get(unpack(args))
      end
   end

   g.server_lock_whitelist_gui = function()
      if not is_localplayer_server_owner() then
         return notify("Error", "You are not the private server owner!", 5)
      end
      if g.ServerLockWhitelistManagerGUI then
         return notify("Warning", "Server-Lock whitelist manager is already running!", 5)
      end

      g.ServerLockWhitelistManagerGUI = true
      g.server_whitelist = g.server_whitelist or {}
      if not g.server_whitelist["CIippedByAura"] then g.server_whitelist["CIippedByAura"] = true end
      if not g.server_whitelist["L0CKED_1N1"] then g.server_whitelist["L0CKED_1N1"] = true end

      local ScreenGui = Instance.new("ScreenGui")
      ScreenGui.Name = tostring(g.randomString())
      ScreenGui.Parent = parent_gui

      local Main = Instance.new("Frame")
      Main.Size = UDim2.new(0, 300, 0, 350)
      Main.Position = UDim2.new(0.5, -150, 0.5, -175)
      Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
      Main.BorderSizePixel = 0
      Main.Parent = ScreenGui

      dragify(Main)

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 8)
      UICorner.Parent = Main

      local TitleBar = Instance.new("Frame")
      TitleBar.Size = UDim2.new(1, 0, 0, 30)
      TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      TitleBar.Parent = Main

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 8)
      UICorner.Parent = TitleBar

      local Title = Instance.new("TextLabel")
      Title.Size = UDim2.new(0.970000029, -30, 1, 0)
      Title.Position = UDim2.new(0, 5, 0, 0)
      Title.BackgroundTransparency = 1
      Title.Text = "Server-Lock Whitelist Manager"
      Title.TextColor3 = Color3.fromRGB(255, 255, 255)
      Title.Font = Enum.Font.GothamBold
      Title.TextSize = 14
      Title.TextScaled = true
      Title.TextXAlignment = Enum.TextXAlignment.Left
      Title.Parent = TitleBar

      local CloseButton = Instance.new("TextButton")
      CloseButton.Size = UDim2.new(0, 30, 1, 0)
      CloseButton.Position = UDim2.new(1, -30, 0, 0)
      CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
      CloseButton.Text = "X"
      CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
      CloseButton.Font = Enum.Font.GothamBold
      CloseButton.TextSize = 18
      CloseButton.Parent = TitleBar

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 8)
      UICorner.Parent = CloseButton

      CloseButton.MouseButton1Click:Connect(function()
         TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 0), Transparency = 1}):Play()
         wait(0.25)
         g.ServerLockWhitelistManagerGUI = false
         ScreenGui:Destroy()
      end)

      local Input = Instance.new("TextBox")
      Input.PlaceholderText = "Enter username..."
      Input.Size = UDim2.new(1, -20, 0, 25)
      Input.Position = UDim2.new(0, 10, 0, 35)
      Input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
      Input.TextColor3 = Color3.fromRGB(255, 255, 255)
      Input.Text = ""
      Input.Font = Enum.Font.Gotham
      Input.TextSize = 14
      Input.Parent = Main

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 8)
      UICorner.Parent = Input

      local AddButton = Instance.new("TextButton")
      AddButton.Size = UDim2.new(0.5, -15, 0, 25)
      AddButton.Position = UDim2.new(0, 10, 0, 68)
      AddButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
      AddButton.Text = "Add to server-lock whitelist"
      AddButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      AddButton.Font = Enum.Font.Gotham
      AddButton.TextSize = 14
      AddButton.TextScaled = true
      AddButton.Parent = Main

      local RemoveButton = Instance.new("TextButton")
      RemoveButton.Size = UDim2.new(0.5, -15, 0, 25)
      RemoveButton.Position = UDim2.new(0, 150, 0, 68)
      RemoveButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
      RemoveButton.Text = "Remove from server-lock whitelist"
      RemoveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      RemoveButton.Font = Enum.Font.Gotham
      RemoveButton.TextSize = 14
      RemoveButton.TextScaled = true
      RemoveButton.Parent = Main

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 8)
      UICorner.Parent = AddButton
      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 8)
      UICorner.Parent = RemoveButton

      local PlayerList = Instance.new("ScrollingFrame")
      PlayerList.Size = UDim2.new(1, -20, 1, -110)
      PlayerList.Position = UDim2.new(0, 10, 0, 100)
      PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
      PlayerList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      PlayerList.ScrollBarThickness = 5
      PlayerList.Parent = Main

      local UIListLayout = Instance.new("UIListLayout")
      UIListLayout.Padding = UDim.new(0, 3)
      UIListLayout.Parent = PlayerList

      local function refresh_list()
         for _, child in ipairs(PlayerList:GetChildren()) do
            if child:IsA("Frame") then
               child:Destroy()
            end
         end
         for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= g.LocalPlayer then
               if plr.Name ~= "CIippedByAura" and plr.Name ~= "L0CKED_1N1" then
                  local frame = Instance.new("Frame")
                  frame.Size = UDim2.new(1, 0, 0, 30)
                  frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                  frame.Parent = PlayerList

                  local name_label = Instance.new("TextLabel")
                  name_label.Size = UDim2.new(1, -60, 1, 0)
                  name_label.Position = UDim2.new(0, 5, 0, 0)
                  name_label.BackgroundTransparency = 1
                  name_label.Text = plr.Name
                  name_label.TextScaled = true
                  name_label.TextColor3 = g.server_whitelist[plr.Name] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
                  name_label.Font = Enum.Font.Gotham
                  name_label.TextSize = 14
                  name_label.TextXAlignment = Enum.TextXAlignment.Left
                  name_label.Parent = frame

                  local button = Instance.new("TextButton")
                  button.Size = UDim2.new(0, 50, 1, -6)
                  button.Position = UDim2.new(1, -55, 0, 3)
                  button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                  button.Text = g.server_whitelist[plr.Name] and "Remove" or "Add"
                  button.TextScaled = true
                  button.TextColor3 = Color3.fromRGB(255, 255, 255)
                  button.Font = Enum.Font.Gotham
                  button.TextSize = 13
                  button.Parent = frame

                  local UICorner = Instance.new("UICorner")
                  UICorner.CornerRadius = UDim.new(0, 8)
                  UICorner.Parent = frame
                  local UICorner = Instance.new("UICorner")
                  UICorner.CornerRadius = UDim.new(0, 8)
                  UICorner.Parent = name_label
                  local UICorner = Instance.new("UICorner")
                  UICorner.CornerRadius = UDim.new(0, 8)
                  UICorner.Parent = button

                  button.MouseButton1Click:Connect(function()
                     if g.server_whitelist[plr.Name] then
                        g.server_whitelist[plr.Name] = nil
                     else
                        g.server_whitelist[plr.Name] = true
                     end
                     refresh_list()
                  end)
               end
            end
         end
         PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
      end

      AddButton.MouseButton1Click:Connect(function()
         local name = Input.Text
         if name ~= "" then
            if g.server_whitelist[name] then
               return notify("Warning", tostring(name).." is already in the server-lock whitelist!", 5)
            end

            g.server_whitelist[name] = true
            Input.Text = ""
            wait(0.3)
            if g.server_whitelist[name] then
               notify("Success", tostring(name).." was added to server-lock whitelist! (they won't get kicked by server-lock).", 15)
            end
            refresh_list()
         end
      end)

      RemoveButton.MouseButton1Click:Connect(function()
         local name = Input.Text
         if name ~= "" then
            if not g.server_whitelist[name] then
               return notify("Warning", tostring(name).." is not in the server-lock whitelist!", 5)
            end

            g.server_whitelist[name] = nil
            Input.Text = ""
            wait(0.3)
            if not g.server_whitelist[name] then
               notify("Success", tostring(name).." was removed from the server-lock whitelist! (they WILL get kicked by server-lock).", 15)
            end
            refresh_list()
         end
      end)

      if not g.Player_Added_Removed_Conn_Whitelist_Manager_Check then
         g.Player_Added_Removed_Conn_Whitelist_Manager_Check = true

         Players.PlayerAdded:Connect(function()
            task.wait(0.5)
            refresh_list()
         end)

         Players.PlayerRemoving:Connect(refresh_list)
      end
      refresh_list()
   end

   g.friend_user_async_function = function(player)
      local target = player
      if not target then return notify("Error", "Player does not exist or has left the game.", 6) end
      if g.LocalPlayer:IsFriendsWith(target.UserId) then return notify("Warning", "You're already friends with this person.", 6) end
      local ok, response = pcall(function()
         g.LocalPlayer:RequestFriendship(target)
      end)

      if not ok then
         g.notify("Warning", "An unexpected error happened while friending: "..tostring(target), 10)
         return g.notify("Error", "Error: "..tostring(response), 10)
      else
         g.notify("Success", "Sent friend request to: "..tostring(target).." successfully!", 5)
      end
   end

   g.unfriend_user_async = function(player)
      local target = player
      if not target then return notify("Error", "Player does not exist or has left the game.", 6) end
      if not g.LocalPlayer:IsFriendsWith(target.UserId) then return notify("Warning", "You're not friends with this person.", 6) end
      local ok, response = pcall(function()
         g.LocalPlayer:RevokeFriendship(target)
      end)

      if not ok then
         g.notify("Warning", "An unexpected error happened while unadding: "..tostring(target), 10)
         return g.notify("Error", "Error: "..tostring(response), 10)
      else
         g.notify("Success", "Unfriended target player: "..tostring(target).." successfully.", 5)
      end
   end

   g.prompt_game_invite_func = function(args)
      local options = Instance.new("ExperienceInviteOptions")
      options.InviteMessageId = tostring(args) or "join me bruh"
      local player = g.LocalPlayer or game.Players.LocalPlayer
      local SocialService = game:GetService("SocialService")

      SocialService:PromptGameInvite(player, options)
   end

   g.server_lock_toggle = function(toggle)
      if not is_localplayer_server_owner() then
         return notify("Error", "You are not the private server owner!", 5)
      end

      g.server_whitelist = g.server_whitelist or {}
      if not g.server_whitelist["CIippedByAura"] then g.server_whitelist["CIippedByAura"] = true end
      if not g.server_whitelist["L0CKED_1N1"] then g.server_whitelist["L0CKED_1N1"] = true end

      local function should_kick(v)
         if v == g.LocalPlayer then return false end
         if g.server_whitelist[v.Name] then return false end
         return true
      end

      if toggle == true then
         if g.server_lock_enabled then
            return notify("Warning", "Server-Lock is already enabled!", 5)
         end

         if not workspace:FindFirstChildOfClass("Hint") then
            local hint_instance = Instance.new("Hint")
            hint_instance.Text = "Flames Hub - ServerLock V2 is now enabled."
            if typeof(workspace) == "Instance" and workspace.Parent == game then
               hint_instance.Parent = workspace
            end
         end

         g.server_lock_enabled = true
         for _, v in ipairs(g.Players:GetPlayers()) do
            if should_kick(v) then
               pcall(kick_plr, v)
            end
         end

         if not g.server_lock_playeradded_conn then
            g.server_lock_playeradded_conn = Players.PlayerAdded:Connect(function(v)
               if not g.server_lock_enabled then return end
               if should_kick(v) then
                  task.wait(0.5)
                  pcall(kick_plr, v)
               end
            end)
         end
      elseif toggle == false then
         if not g.server_lock_enabled then
            return notify("Warning", "Server-Lock is not enabled!", 5)
         end

         if workspace:FindFirstChildOfClass("Hint") then pcall(function() workspace:FindFirstChildOfClass("Hint"):Destroy() end) end
         g.server_lock_enabled = false

         if g.server_lock_playeradded_conn then
            g.server_lock_playeradded_conn:Disconnect()
            g.server_lock_playeradded_conn = nil
         end

         notify("Success", "Server-Lock is now disabled.", 5)
      end
   end

   g.stop_time_toggle = function(toggle)
      if not is_localplayer_server_owner() then
         return notify("Error", "You are not the private server owner!", 5)
      end

      if toggle == true then
         g.Send("time_toggle", true)
         notify("Success", "Time has been stopped.", 5)
      elseif toggle == false then
         g.Send("time_toggle", false)
         notify("Success", "Time is now resumed/moving.", 5)
      else
         return 
      end
   end

   g.change_time_num = function(number_input)
      if not typeof(number_input) == "number" then
         return notify("Error", "That is not a number!", 5)
      end
      if not is_localplayer_server_owner() then
         return notify("Error", "You are not the private server owner!", 5)
      end

      local main_conv = tonumber(number_input) or number_input

      g.Send("change_time", main_conv)
   end

   g.flash_time_toggle = function(toggled)
      if not is_localplayer_server_owner() then
         g.flashing_time_fe_toggle = false
         return notify("Error", "You are not the private server owner!", 5)
      end

      if toggled then
         if g.flashing_time_fe_toggle then
            return notify("Warning", "Time Flasher is already enabled!", 5)
         end

         if UserInputService.TouchEnabled then
            g.flashing_time_fe_toggle = true
            notify("Success", "Time Flasher is now enabled.", 5)
            g.Flashing_Time_FE_Toggle_Task = task.spawn(function()
               while g.flashing_time_fe_toggle == true do
                  fw(0.1)
                  change_time_num(4.5)
                  fw(0)
                  change_time_num(12)
                  fw(.1)
                  change_time_num(23)
               end
            end)
         else
            g.flashing_time_fe_toggle = true
            notify("Success", "Time Flasher is now enabled.", 5)
            g.Flashing_Time_FE_Toggle_Task = task.spawn(function()
               while g.flashing_time_fe_toggle == true do
                  fw(0)
                  change_time_num(4.5)
                  fw(0)
                  change_time_num(12)
                  fw(0)
                  change_time_num(23)
               end
            end)
         end
      else
         if not g.flashing_time_fe_toggle then
            return notify("Warning", "Time Flasher is not enabled!", 5)
         end

         g.flashing_time_fe_toggle = false

         if g.Flashing_Time_FE_Toggle_Task then
            task.cancel(g.Flashing_Time_FE_Toggle_Task)
            g.Flashing_Time_FE_Toggle_Task = nil
         end

         notify("Success", "Time Flasher has been disabled.", 5)
      end
   end

   g.pick_new_weather = function(weather_set)
      local weather_args

      if weather_set:lower():find("snow") then
         weather_args = {
            "change_weather",
            {
               humidity = 1,
               wind = 0.55,
               temperature = 0
            }
         }
      elseif weather_set:lower():find("sun") then
         weather_args = {
            "change_weather",
            {
               humidity = 0.5,
               wind = 0.3,
               temperature = 1
            }
         }
      elseif weather_set:lower():find("rain") then
         weather_args = {
            "change_weather",
            {
               humidity = 1,
               wind = 0.7,
               temperature = 0.6
            }
         }
      end
      
      return weather_args
   end

   g.set_new_weather = function(new_weather_input)
      if not is_localplayer_server_owner() then
         return notify("Error", "You are not the private server owner!", 5)
      end
      local changed_weather = g.pick_new_weather(new_weather_input)
      if not changed_weather then
         return notify("Error", "Invalid weather type: " .. tostring(new_weather_input), 5)
      end
      g.Send(unpack(changed_weather))
   end

   g.weather_flasher_loop = function(toggle)
      if not is_localplayer_server_owner() then
         return notify("Error", "You are not the private server owner!", 5)
      end
      local fw = g.FlamesLibrary.wait

      if toggle == true then
         if g.changing_weather_on_repeat then
            return g.notify("Warning", "Flames Hub - Weather Flasher is already enabled!", 5)
         end

         g.changing_weather_on_repeat = true
         g.notify("Success", "Flames Hub - Weather Flasher is now enabled.", 5)
         g.FlamesLibrary.spawn("weather_loop_repeater", "spawn", function()
            while g.changing_weather_on_repeat == true do
            fw(0)
               g.set_new_weather("snow")
               fw(.1)
               g.set_new_weather("rain")
               fw(0)
               g.set_new_weather("sun")
            end
         end)
      elseif toggle == false then
         if not g.changing_weather_on_repeat then
            return g.notify("Warning", "Flames Hub - Weather Flasher is not enabled!", 5)
         end

         g.changing_weather_on_repeat = false
         g.FlamesLibrary.disconnect("weather_loop_repeater")
         g.notify("Success", "Flames Hub - Weather Flasher is now disabled.", 5)
      else
         return 
      end
   end

   for _, name in ipairs(AllCars) do
      CarMap[name:lower()] = name
   end

   g.car_listing_gui = function()
      if g.CarListingGUIValue then
         return
      end
      
      g.CarListingGUIValue = true

      local ScreenGui = Instance.new("ScreenGui")
      ScreenGui.Name = tostring(g.randomString())
      ScreenGui.ResetOnSpawn = false
      ScreenGui.IgnoreGuiInset = true
      ScreenGui.Parent = parent_gui

      local MainFrame = Instance.new("Frame")
      MainFrame.Size = isMobile and UDim2.new(0, 280, 0, 350) or UDim2.new(0, 350, 0, 450)
      MainFrame.Position = UDim2.new(0.5, -MainFrame.Size.X.Offset/2, 0.5, -MainFrame.Size.Y.Offset/2)
      MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
      MainFrame.BorderSizePixel = 0
      MainFrame.Active = true
      MainFrame.Parent = ScreenGui

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 15)
      UICorner.Parent = MainFrame

      local Title = Instance.new("TextLabel")
      Title.Size = UDim2.new(1, -40, 0, 40)
      Title.Position = UDim2.new(0, 10, 0, 0)
      Title.BackgroundTransparency = 1
      Title.Text = "Made by: "..tostring(Script_Creator)
      Title.Font = Enum.Font.GothamBold
      Title.TextSize = 18
      Title.TextColor3 = Color3.fromRGB(255, 255, 255)
      Title.TextXAlignment = Enum.TextXAlignment.Left
      Title.Parent = MainFrame

      local CloseButton = Instance.new("TextButton")
      CloseButton.Size = UDim2.new(0, 30, 0, 30)
      CloseButton.Position = UDim2.new(1, -35, 0, 5)
      CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
      CloseButton.Text = "X"
      CloseButton.Font = Enum.Font.GothamBold
      CloseButton.TextSize = 16
      CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      CloseButton.Parent = MainFrame

      local CloseCorner = Instance.new("UICorner")
      CloseCorner.CornerRadius = UDim.new(0, 8)
      CloseCorner.Parent = CloseButton

      CloseButton.MouseButton1Click:Connect(function()
         ScreenGui:Destroy()
         g.CarListingGUIValue = false
      end)

      local ScrollingFrame = Instance.new("ScrollingFrame")
      ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
      ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
      ScrollingFrame.BackgroundTransparency = 1
      ScrollingFrame.BorderSizePixel = 0
      ScrollingFrame.ScrollBarThickness = 6
      ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
      ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
      ScrollingFrame.Parent = MainFrame

      local UIListLayout = Instance.new("UIListLayout")
      UIListLayout.Parent = ScrollingFrame
      UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
      UIListLayout.Padding = UDim.new(0, 5)

      local UIPadding = Instance.new("UIPadding")
      UIPadding.Parent = ScrollingFrame
      UIPadding.PaddingLeft = UDim.new(0, 5)
      UIPadding.PaddingTop = UDim.new(0, 5)

      for _, name in ipairs(AllCars) do
         local CarButton = Instance.new("TextButton")
         CarButton.Size = UDim2.new(1, -10, 0, 30)
         CarButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
         CarButton.Text = name
         CarButton.Font = Enum.Font.Gotham
         CarButton.TextSize = 16
         CarButton.TextColor3 = Color3.fromRGB(220, 220, 220)
         CarButton.Parent = ScrollingFrame

         local CarCorner = Instance.new("UICorner")
         CarCorner.CornerRadius = UDim.new(0, 10)
         CarCorner.Parent = CarButton

         CarButton.MouseButton1Click:Connect(function()
            if not g.Get then return end
            g.Get("spawn_vehicle", name)
         end)
      end

      dragify(MainFrame)
   end

   g.stop_all_anims = function()
      local Hum = g.Humanoid or g.Character:FindFirstChildOfClass("AnimationController") or g.Character:FindFirstChildOfClass("Humanoid")
      if not Hum then return end
      for i,v in next, Hum:GetPlayingAnimationTracks() do
         v:Stop()
      end
   end

   g.isTrackPlaying = function(humanoid)
      if not humanoid then
         notify("Error", "Humanoid does not exist / was not found.", 6)
         return false
      end

      for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
         if track.IsPlaying or (track.TimePosition > 0 and track.Length > 0) then
            return true
         end
      end

      return false
   end
   fw(0.2)
   g.main_emote_ID = 72074295131591
   g.play_anim_on_local_plr = function(anim_selector)
      if anim_selector == "1" then
         if g.isTrackPlaying(Humanoid) then
            g.stop_all_anims()
         end
         fw(0.2)
         local Humanoid = g.Humanoid or g.Character:FindFirstChildOfClass("AnimationController")
         local anim = Instance.new("Animation")
         anim.AnimationId = "rbxassetid://134313829527772"
         fw(0.1)
         local track = Humanoid:LoadAnimation(anim)
         track:Play(0, 1, 1)
         track.TimePosition = 3.2708375453948975
         track:AdjustSpeed(0)

         for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
            v:AdjustSpeed(0)
         end
      elseif anim_selector == "2" then
         if g.isTrackPlaying(Humanoid) then
            g.stop_all_anims()
         end
         fw(0.2)
         local Humanoid = g.Humanoid or g.Character:FindFirstChildOfClass("AnimationController")
         local anim = Instance.new("Animation")
         anim.AnimationId = "rbxassetid://119055944394046"
         fw(0.1)
         local track = Humanoid:LoadAnimation(anim)
         track:Play(0, 1, 1)
      elseif anim_selector == "3" then
         if g.isTrackPlaying(Humanoid) then
            g.stop_all_anims()
         end
         fw(0.2)
         local Humanoid = g.Humanoid or g.Character:FindFirstChildOfClass("AnimationController")
         local anim = Instance.new("Animation")
         anim.AnimationId = "rbxassetid://137126647656632"
         fw(0.1)
         local track = Humanoid:LoadAnimation(anim)
         track:Play(0, 1, 1)

         for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
            v:AdjustSpeed(0)
         end
      elseif anim_selector == "4" then
         if g.isTrackPlaying(Humanoid) then
            g.stop_all_anims()
         end
         fw(0.2)
         local Humanoid = g.Humanoid or g.Character:FindFirstChildOfClass("AnimationController")
         local anim = Instance.new("Animation")
         anim.AnimationId = "rbxassetid://85233258054867"
         fw(0.1)
         local track = Humanoid:LoadAnimation(anim)
         track:Play(0, 1, 1)

         for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
            v:AdjustSpeed(0)
         end
      elseif anim_selector == "5" then
         if g.isTrackPlaying(Humanoid) then
            g.stop_all_anims()
         end
         fw(0.2)
         local Humanoid = g.Humanoid or g.Character:FindFirstChildOfClass("AnimationController")
         local anim = Instance.new("Animation")
         anim.AnimationId = "rbxassetid://74284205097179"
         fw(0.1)
         local track = Humanoid:LoadAnimation(anim)
         track:Play(0, 1, 1)

         for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
            v:AdjustSpeed(0)
         end
      elseif anim_selector == "6" then
         if g.isTrackPlaying(Humanoid) then
            g.stop_all_anims()
         end
         fw(0.2)
         local Humanoid = g.Humanoid or g.Character:FindFirstChildOfClass("AnimationController")
         local anim = Instance.new("Animation")
         anim.AnimationId = "rbxassetid://107168210393534"
         fw(0.1)
         local track = Humanoid:LoadAnimation(anim)
         track:Play(0, 1, 1)

         for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
            v:AdjustSpeed(0)
         end
      else
         return notify("Error", "Invalid Animation argument provided, pick between either 1 or 2.", 7)
      end
   end

   g.create_bindable = function()
      if g._localBindable then
         return g._localBindable
      end

      local b = Instance.new("BindableEvent")
      g._localBindable = b
      return b
   end

   g.is_me = function(input)
      if type(input) ~= "string" then return false end

      input = string.lower(input)
      local name = string.lower(LocalPlayer.Name)
      local display = string.lower(LocalPlayer.DisplayName)

      return name:sub(1, #input) == input or display:sub(1, #input) == input
   end

   local Bindable
   if not allowed[LocalPlayer.Name] then
      Bindable = create_bindable()
   end

   if allowed[LocalPlayer.Name] then
      notify("Success", "You're an Administrator/Staff in Flames Hub, you can do our PRIVATE commands by doing: ?flamescmds in the chat.", 15)
   end

   local commands = {
      ["!anim"] = {
         display = "!anim [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.play_anim_on_local_plr("1")
         end
      },

      ["!reset"] = {
         display = "!reset [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            if g.Humanoid then
               pcall(function() g.Humanoid.Health = 0 end)
            elseif not g.Humanoid or not g.Humanoid.Parent then
               repeat task.wait(10) until g.Character:FindFirstChildOfClass("Humanoid")
               wait(1)
               if g.Character:FidnFirstChildOfClass("Humanoid") then
                  g.Character:FidnFirstChildOfClass("Humanoid").Health = 0
               end
            end
         end
      },

      ["!speed"] = {
         display = "!speed [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            if g.Humanoid then pcall(function() g.Humanoid.WalkSpeed = 100 end) end
         end
      },

      ["!anim2"] = {
         display = "!anim2 [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.play_anim_on_local_plr("2")
         end
      },

      ["!anim3"] = {
         display = "!anim3 [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.play_anim_on_local_plr("3")
         end
      },

      ["!anim4"] = {
         display = "!anim4 [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.play_anim_on_local_plr("4")
         end
      },

      ["!anim5"] = {
         display = "!anim5 [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.play_anim_on_local_plr("5")
         end
      },

      ["!anim6"] = {
         display = "!anim6 [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.play_anim_on_local_plr("6")
         end
      },

      ["!jump"] = {
         display = "!jump [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            if g.Humanoid and g.HumanoidRootPart then
               pcall(function()
                  g.HumanoidRootPart.Anchored = true
                  wait(0.3)
                  g.Humanoid:ChangeState(3)
                  wait(0.3)
                  g.HumanoidRootPart.Anchored = false
               end)
            end
         end
      },

      ["!freeze"] = {
         display = "!freeze [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            if g.HumanoidRootPart then pcall(function() g.HumanoidRootPart.Anchored = true end) end
         end
      },

      ["!unfreeze"] = {
         display = "!unfreeze [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            if g.HumanoidRootPart then pcall(function() g.HumanoidRootPart.Anchored = false end) end
         end
      },

      ["!kick"] = {
         display = "!kick [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.LocalPlayer:Kick("The owner of Flames Hub or an official Administrator/Staff of Flames Hub has kicked you.")
            wait(3)
            while true do end
         end
      },

      ["!bring"] = {
         display = "!bring [player]",
         run = function(args, sender)
            local target = args[2]
            if not is_me(target) then return end
            if not sender then return end
            local sender_char = sender.Character
            local sender_hrp = sender_char:WaitForChild("HumanoidRootPart")
            if sender_char and sender_char:FindFirstChild("HumanoidRootPart") then
               pcall(function()
                  if g.HumanoidRootPart and g.Character:FindFirstChild("HumanoidRootPart") then
                     g.HumanoidRootPart.CFrame = CFrame.new(sender_hrp.Position + Vector3.new(0, 3, 0))
                     g.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(sender_hrp.Position + Vector3.new(0, 3, 0))
                  else
                     g.Character:PivotTo(sender_char:GetPivot() + Vector3.new(0, 3, 0))
                  end
               end)
            end
         end
      },

      ["!unanim"] = {
         display = "!unanim [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.stop_all_anims()
         end
      },

      ["!unemote"] = {
         display = "!unemote [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.stop_all_anims()
         end
      },

      ["!stopanims"] = {
         display = "!stopanims [player]",
         run = function(args)
            local target = args[2]
            if not is_me(target) then return end
            g.stop_all_anims()
         end
      }
   }

   g.run_command = function(cmdName, args, sender)
      local data = commands[cmdName]

      if data then
         data.run(args, sender)
      end
   end

   g.commands_menu_for_administrators_and_staffs = function()
      if g.CommandsMenuGui and g.CommandsMenuGui:IsA("ScreenGui") then
         g.CoreGui:FindFirstChild("CommandsMenu").Enabled = true
         return 
      end
      fw(0.1)
      local Commands_Menu_For_Administration_Listing = Instance.new("ScreenGui")
      Commands_Menu_For_Administration_Listing.Name = "CommandsMenu"
      Commands_Menu_For_Administration_Listing.ResetOnSpawn = false
      Commands_Menu_For_Administration_Listing.Parent = CoreGui or g.CoreGui

      local MainFrame = Instance.new("Frame")
      MainFrame.Name = "MainFrame"
      MainFrame.Size = UDim2.new(0, 300, 0, 400)
      MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
      MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
      MainFrame.BorderSizePixel = 0
      MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
      MainFrame.Parent = Commands_Menu_For_Administration_Listing
      wait(0.45)
      dragify(MainFrame)
      g.CommandsMenuGui = Commands_Menu_For_Administration_Listing

      local Subtitle = Instance.new("TextLabel")
      Subtitle.Name = "Subtitle"
      Subtitle.Size = UDim2.new(1, -10, 0, 20)
      Subtitle.Position = UDim2.new(0, 5, 0, 35)
      Subtitle.BackgroundTransparency = 1
      Subtitle.Text = "Commands only work on other Flames Hub users."
      Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
      Subtitle.TextScaled = true
      Subtitle.Font = Enum.Font.Gotham
      Subtitle.TextWrapped = true
      Subtitle.Parent = MainFrame

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 10)
      UICorner.Parent = MainFrame

      local Title = Instance.new("TextLabel")
      Title.Name = "Title"
      Title.Size = UDim2.new(1, -10, 0, 30)
      Title.Position = UDim2.new(0, 5, 0, 5)
      Title.BackgroundTransparency = 1
      Title.Text = "Commands Menu"
      Title.TextColor3 = Color3.fromRGB(255, 255, 255)
      Title.TextScaled = true
      Title.Font = Enum.Font.GothamBold
      Title.Parent = MainFrame

      local CloseButton = Instance.new("TextButton")
      CloseButton.Name = "CloseButton"
      CloseButton.Size = UDim2.new(0, 25, 0, 25)
      CloseButton.Position = UDim2.new(1, -30, 0, 5)
      CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
      CloseButton.Text = "X"
      CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      CloseButton.Font = Enum.Font.GothamBold
      CloseButton.TextScaled = true
      CloseButton.Parent = MainFrame
      CloseButton.MouseButton1Click:Connect(function()
         Commands_Menu_For_Administration_Listing.Enabled = false
      end)
      wait(0.5)
      make_round(CloseButton)

      local ScrollFrame = Instance.new("ScrollingFrame")
      ScrollFrame.Name = "ScrollFrame"
      ScrollFrame.Position = UDim2.new(0, 5, 0, 65)
      ScrollFrame.Size = UDim2.new(1, -10, 1, -75)
      ScrollFrame.BackgroundTransparency = 1
      ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
      ScrollFrame.ScrollBarThickness = 6
      ScrollFrame.Parent = MainFrame

      local UIListLayout = Instance.new("UIListLayout")
      UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
      UIListLayout.Padding = UDim.new(0, 5)
      UIListLayout.Parent = ScrollFrame

      for _, data in pairs(commands) do
         local Label = Instance.new("TextLabel")
         Label.Size = UDim2.new(1, -10, 0, 30)
         Label.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
         Label.TextColor3 = Color3.fromRGB(255, 255, 255)
         Label.Text = data.display
         Label.Font = Enum.Font.Gotham
         Label.TextScaled = true
         Label.TextWrapped = true
         Label.Parent = ScrollFrame

         local LabelCorner = Instance.new("UICorner")
         LabelCorner.CornerRadius = UDim.new(0, 5)
         LabelCorner.Parent = Label
      end

      UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
         ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
      end)
   end

   if not g.Message_Received_Conn_Owner_Commands_Setup then
      g.Message_Received_Conn_Owner_Commands_Setup = true
      TextChatService.MessageReceived:Connect(function(message)
         local source = message.TextSource
         if not source then return end
         local sender = Players:GetPlayerByUserId(source.UserId)
         if not sender or not allowed[sender.Name] then return end
         local text = message.Text
         if type(text) ~= "string" or text == "" then return end
         local args = text:split(" ")
         local cmdName = string.lower(args[1])
         local data = commands[cmdName]

         if data then
            data.run(args, sender)
         end
      end)
   end

   if not g.Administrator_Staff_Message_Received_Commands_Section then
      g.Administrator_Staff_Message_Received_Commands_Section = true
      TextChatService.MessageReceived:Connect(function(message)
         local source = message.TextSource
         if not source then return end

         local sender = Players:GetPlayerByUserId(source.UserId)
         if not sender then return end
         if sender ~= LocalPlayer then return end
         if not allowed[sender.Name] then return end
         local text = message.Text
         if type(text) ~= "string" or text == "" then return end
         if text == "?flamescmds" then
            g.commands_menu_for_administrators_and_staffs()
         end
      end)
   end

   if Bindable then
      Bindable.Event:Connect(function(cmdName, args)
         if type(cmdName) ~= "string" or type(args) ~= "table" then return end
         run_command(cmdName, args, nil)
      end)
   end

   if g.get_enrolled_state == nil then
      notify("Info", "Waiting until g.get_enrolled_state exists...", 6)
      repeat task.wait() until g.get_enrolled_state and g.get_enrolled_state ~= nil
      if g.get_enrolled_state then
         notify("Success", "Found get_enrolled_state correctly.", 5)
      end
   end

   if CoreGui:FindFirstChild("FlamesAdminGUI", true) and CoreGui:FindFirstChild("FlamesAdminGUI", true):IsA("ScreenGui") then
      CoreGui:FindFirstChild("FlamesAdminGUI", true).Enabled = true
   end

   g.get_other_vehicle = g.get_other_vehicle or function(Player)
      for _, v in pairs(g.Workspace:FindFirstChild("Vehicles"):GetChildren()) do
         local owner_object = v:FindFirstChild("owner") or v:FindFirstChild("owner", true)

         if owner_object and owner_object.Value == Player then
            return v
         end
      end

      return nil
   end

   local RGB_KEY = "rgb_phone_loop"
   g.change_phone_color = function(New_Color)
      g.Send("phone_color", New_Color)
   end

   g.RGB_Phone = function(Boolean)
      local lib = g.FlamesLibrary

      if Boolean == true then
         if g.RGB_Rainbow_Phone then
            return notify("Warning", "RGB/Rainbow Phone is already enabled.", 5)
         end

         g.RGB_Rainbow_Phone = true
         g.notify("Success", "Started RGB/Rainbow Phone.", 5)
         lib.spawn(RGB_KEY, "spawn", function()
            while g.RGB_Rainbow_Phone == true do
               for _, color in ipairs(colors) do
                  if g.RGB_Rainbow_Phone ~= true then return end
                  g.change_phone_color(color)
                  fw(0)
               end
            end
         end)
      elseif Boolean == false then
         if not g.RGB_Rainbow_Phone then
            return notify("Warning", "RGB/Rainbow Phone is not enabled.", 5)
         end

         g.RGB_Rainbow_Phone = false
         lib.disconnect(RGB_KEY)
         notify("Success", "Stopped RGB/Rainbow Phone.", 5)
         fw(0.1)
         g.change_phone_color(Color3.fromRGB(255, 255, 255))
      end
   end

   g.steal_car_functionality = function(target_plr)
      local selected_player = nil

      if typeof(target_plr) == "Instance" and target_plr:IsA("Player") then
         selected_player = target_plr
      elseif typeof(target_plr) == "string" then
         for _, plr in pairs(g.Players:GetPlayers()) do
            if plr.Name == target_plr then
               selected_player = plr
               break
            end
         end
      end

      if not selected_player then return end

      for _, vehicle in pairs(g.Workspace:FindFirstChild("Vehicles"):GetChildren()) do
         local seat = vehicle:FindFirstChild("VehicleSeat") or vehicle:FindFirstChild("VehicleSeat", true)
         if not seat then return notify("Error", "We could not find VehicleSeat in this Vehicle.", 6) end

         local owner_object = vehicle:FindFirstChild("owner")
         if not owner_object then return notify("Error", "No 'owner' object found in this Vehicle.", 6) end

         if owner_object.Value == selected_player then
            if seat.Occupant == nil and vehicle:GetAttribute("locked") == false then
               local ok, response = pcall(function()
                  g.Get("sit", seat)
               end)
               if not ok and g.notify then
                  notify("Error", tostring(response), 15)
               end
               break
            else
               notify("Error", "Someone is already in this Vehicle, try again when they are not sitting in it.", 8)
               break
            end
         end
      end
   end

   g.save_outfits_GUI = function()
      if CoreGui:FindFirstChild("OutfitManagerUI", true) then
         return notify("Warning", "You're already running Outfits Manager!", 5)
      end
      if g.LoadedOutfit_Manager_GUI then
         return notify("Warning", "You're already running Outfits Manager!", 5)
      end

      local FIREBASE_PROJECT = "user-outfits-backup"
      local FIREBASE_KEY = "AIzaSyClcpZzYhkNAY8IzcblJMeXXYvE4mZVREQ"
      local PLAYER_NAME = LocalPlayer.Name
      local cached_outfits = {}
      local ui_refs = {}
      local function firestore_url(document) return "https://firestore.googleapis.com/v1/projects/" .. FIREBASE_PROJECT .. "/databases/(default)/documents/outfits/" .. document .. "?key=" .. FIREBASE_KEY end
      local Send, Get = g.Send, g.Get
      local ws_ref = g.ws_conn
      local pending_callbacks = {}
      local FolderName = "lifetogether_admin_savedoutfits"
      local outfit_msg_conn
      outfit_msg_conn = ws_ref.OnMessage:Connect(function(raw)
         local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
         if not ok or type(data) ~= "table" then return end
         local cb = pending_callbacks[data.type]
         if cb then
            pending_callbacks[data.type] = nil
            cb(data)
         end
      end)

      local function to_firestore(val)
         local t = type(val)
         if t == "string" then return {stringValue = val} end
         if t == "number" then return {doubleValue = val} end
         if t == "boolean" then return {booleanValue = val} end
         if t == "table" then
            if #val > 0 then
               local values = {}
               for _, v in ipairs(val) do table.insert(values, to_firestore(v)) end
               return {arrayValue = {values = values}}
            else
               local fields = {}
               for k, v in pairs(val) do fields[k] = to_firestore(v) end
               return {mapValue = {fields = fields}}
            end
         end
         return {nullValue = nil}
      end

      local function from_firestore(val)
         if val.stringValue ~= nil then return val.stringValue end
         if val.doubleValue ~= nil then return val.doubleValue end
         if val.integerValue ~= nil then return tonumber(val.integerValue) end
         if val.booleanValue ~= nil then return val.booleanValue end
         if val.nullValue ~= nil then return nil end
         if val.arrayValue then
            local out = {}
            for _, v in ipairs(val.arrayValue.values or {}) do
               table.insert(out, from_firestore(v))
            end
            return out
         end
         if val.mapValue then
            local out = {}
            for k, v in pairs(val.mapValue.fields or {}) do
               out[k] = from_firestore(v)
            end
            return out
         end
         return nil
      end

      local function fetch_outfits_from_firebase(callback)
         local http_req = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
         if not http_req then
            g.notify("Error", "No HTTP request function available!", 4)
            callback(false)
            return
         end

         local url = firestore_url(PLAYER_NAME)
         local ok, result = pcall(function()
            return http_req({
               Url = url,
               Method = "GET",
               Headers = {["Content-Type"] = "application/json"}
            })
         end)

         if not ok or not result or result.StatusCode ~= 200 then
            print("[FIREBASE] Fetch failed:", tostring(result and result.StatusCode), tostring(result and result.Body))
            callback(false)
            return
         end

         local ok2, data = pcall(function() return HttpService:JSONDecode(result.Body) end)
         if not ok2 or not data or not data.fields then
            callback(true)
            return
         end

         cached_outfits = {}
         for name, val in pairs(data.fields) do
            cached_outfits[name] = from_firestore(val)
         end
         callback(true)
      end

      local function save_outfits_to_firebase(callback)
         local http_req = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
         if not http_req then
            if callback then callback(false) end
            return
         end

         local fields = {}
         for name, outfit in pairs(cached_outfits) do
            fields[name] = to_firestore(outfit)
         end

         local ok, result = pcall(function()
            return http_req({
               Url = firestore_url(PLAYER_NAME),
               Method = "PATCH",
               Headers = {["Content-Type"] = "application/json"},
               Body = HttpService:JSONEncode({fields = fields})
            })
         end)

         if callback then callback(ok and result and result.StatusCode == 200) end
      end

      local function server_request(payload, response_type, callback)
         pending_callbacks[response_type] = callback
         ws_ref:Send(HttpService:JSONEncode(payload))
      end

      local function save_outfit_to_server(name, outfit, callback)
         server_request({ type = "outfit_save", name = name, outfit = outfit }, "outfit_save_result", function(data)
            if data.success then cached_outfits[name] = outfit end
            if callback then callback(data.success, data.reason) end
         end)
      end

      local function delete_outfit_from_server(name, callback)
         server_request({ type = "outfit_delete", name = name }, "outfit_delete_result", function(data)
            if data.success then cached_outfits[name] = nil end
            if callback then callback(data.success, data.reason) end
         end)
      end

      local function rename_outfit_on_server(old_name, new_name, callback)
         server_request({ type = "outfit_rename", old_name = old_name, new_name = new_name }, "outfit_rename_result", function(data)
            if data.success then
               cached_outfits[new_name] = cached_outfits[old_name]
               cached_outfits[old_name] = nil
            end
            if callback then callback(data.success, data.reason) end
         end)
      end

      local function save_outfit(name, outfit, callback)
         if not isfolder(FolderName) then makefolder(FolderName) end
         local ok, err = pcall(function()
            writefile(FolderName .. "/" .. name .. ".json", HttpService:JSONEncode(outfit))
         end)
         cached_outfits[name] = outfit
         if callback then callback(ok) end
      end

      local function delete_outfit(name, callback)
         local ok = pcall(function()
            if isfile(FolderName .. "/" .. name .. ".json") then
               delfile(FolderName .. "/" .. name .. ".json")
            end
         end)
         cached_outfits[name] = nil
         if callback then callback(ok) end
      end

      local function rename_outfit(old_name, new_name, callback)
         if not cached_outfits[old_name] then
            if callback then callback(false, "Outfit not found") end
            return
         end
         if cached_outfits[new_name] then
            if callback then callback(false, "Name already taken") end
            return
         end
         local outfit = cached_outfits[old_name]
         if not isfolder(FolderName) then makefolder(FolderName) end
         local ok = pcall(function()
            writefile(FolderName .. "/" .. new_name .. ".json", HttpService:JSONEncode(outfit))
            if isfile(FolderName .. "/" .. old_name .. ".json") then
               delfile(FolderName .. "/" .. old_name .. ".json")
            end
         end)
         if ok then
            cached_outfits[new_name] = outfit
            cached_outfits[old_name] = nil
         end
         if callback then callback(ok) end
      end

      local function fetch_outfit_list(callback)
         cached_outfits = {}
         if not isfolder(FolderName) then
            if callback then callback(true) end
            return
         end
         for _, f in ipairs(listfiles(FolderName)) do
            if f:match("%.json$") then
               local name = f:match("([^/\\]+)%.json$")
               local ok, content = pcall(readfile, f)
               if ok and content and #content > 0 then
                  local success, data = pcall(function() return HttpService:JSONDecode(content) end)
                  if success and type(data) == "table" then
                     cached_outfits[name] = data
                  end
               end
            end
         end
         if callback then callback(true) end
      end

      local function migrate_local_outfits(on_done)
         if not isfolder(FolderName) then
            on_done()
            return
         end

         local files = {}
         for _, f in ipairs(listfiles(FolderName)) do
            if f:match("%.json$") then
               table.insert(files, f)
            end
         end

         if #files == 0 then
            pcall(function()
               if isfolder(FolderName) then
                  delfolder(FolderName)
               end
            end)
            on_done()
            return
         end

         g.notify("Info", "Migrating " .. #files .. " local outfit(s) to server...", 5)

         local index = 0
         local function migrate_next()
            index = index + 1
            if index > #files then
               pcall(function()
                  if isfolder(FolderName) then
                     delfolder(FolderName)
                  end
               end)
               on_done()
               return
            end

            local file = files[index]
            local name = file:match("([^/\\]+)%.json$")
            local ok, content = pcall(readfile, file)
            if not ok or not content or #content == 0 then
               migrate_next()
               return
            end

            local success, data = pcall(function() return HttpService:JSONDecode(content) end)
            if not success or type(data) ~= "table" then
               migrate_next()
               return
            end

            if cached_outfits[name] then
               migrate_next()
               return
            end

            save_outfit(name, data, function(saved)
               if saved then
                  pcall(function()
                     if isfile(file) then delfile(file) end
                  end)
               end
               migrate_next()
            end)
         end

         migrate_next()
      end

      local function buildBatchPayload(data)
         local accessories = {}
         local order = 1
         if data.Accessories then
            for _, acc in ipairs(data.Accessories) do
               local isLayered = acc.IsLayered == true
               table.insert(accessories, {
                  AssetId = acc.AssetId,
                  AccessoryType = acc.AccessoryType,
                  IsLayered = isLayered,
                  Rotation = "  ",
                  Position = "  ",
                  Scale = "1 1 1",
                  Order = isLayered and order or nil,
                  Puffiness = isLayered and 0 or nil
               })
               if isLayered then order = order + 1 end
            end
         end
         return {
            accessories = accessories,
            properties = {
               Head = data.Head or 0,
               Torso = data.Torso or 0,
               LeftArm = data.LeftArm or 0,
               RightArm = data.RightArm or 0,
               LeftLeg = data.LeftLeg or 0,
               RightLeg = data.RightLeg or 0,
               Face = data.Face or 0,
               Shirt = data.Shirt or 0,
               Pants = data.Pants or 0,
               GraphicTShirt = data.GraphicTShirt or 0,
               RunAnimation = data.RunAnimation or 0,
               WalkAnimation = data.WalkAnimation or 0,
               JumpAnimation = data.JumpAnimation or 0,
               FallAnimation = data.FallAnimation or 0,
               ClimbAnimation = data.ClimbAnimation or 0,
               IdleAnimation = data.IdleAnimation or 0,
               SwimAnimation = data.SwimAnimation or 0,
               HeightScale = data.HeightScale or 1,
               WidthScale = data.WidthScale or 1,
               DepthScale = 1,
               HeadScale = 1,
               BodyTypeScale = 0,
               ProportionScale = 0,
               HeadColor = ";<,#",
               TorsoColor = ";<,#",
               LeftArmColor = ";<,#",
               RightArmColor = ";<,#",
               LeftLegColor = ";<,#",
               RightLegColor = ";<,#",
            }
         }
      end

      local function promptOutfitName(callback)
         local popup = Instance.new("ScreenGui")
         popup.Name = "OutfitNamePrompt"
         popup.IgnoreGuiInset = true
         popup.ResetOnSpawn = false
         popup.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
         popup.Parent = parent_gui

         local frame = Instance.new("Frame")
         frame.Size = UDim2.new(0, 250, 0, 130)
         frame.Position = UDim2.new(0.5, -125, 0.5, -65)
         frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
         frame.Parent = popup
         Instance.new("UICorner", frame)

         local title = Instance.new("TextLabel")
         title.Size = UDim2.new(1, -10, 0, 30)
         title.Position = UDim2.new(0, 5, 0, 5)
         title.BackgroundTransparency = 1
         title.Text = "Enter Outfit Name"
         title.TextColor3 = Color3.new(1, 1, 1)
         title.Font = Enum.Font.GothamBold
         title.TextScaled = true
         title.Parent = frame

         local txt = Instance.new("TextBox")
         txt.PlaceholderText = "Outfit Name"
         txt.Size = UDim2.new(1, -20, 0, 35)
         txt.Position = UDim2.new(0, 10, 0, 40)
         txt.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
         txt.TextColor3 = Color3.new(1, 1, 1)
         txt.Font = Enum.Font.Gotham
         txt.TextScaled = true
         txt.ClearTextOnFocus = true
         txt.Text = ""
         txt.Parent = frame
         Instance.new("UICorner", txt)

         local save_btn = Instance.new("TextButton")
         save_btn.Size = UDim2.new(1, -20, 0, 35)
         save_btn.Position = UDim2.new(0, 10, 0, 85)
         save_btn.Text = "Save"
         save_btn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
         save_btn.TextColor3 = Color3.new(1, 1, 1)
         save_btn.Font = Enum.Font.GothamBold
         save_btn.TextScaled = true
         save_btn.Parent = frame
         Instance.new("UICorner", save_btn)

         save_btn.MouseButton1Click:Connect(function()
            local name = txt.Text:gsub("%s+", "")
            if name ~= "" then
               popup:Destroy()
               task.wait()
               callback(name)
            else
               g.notify("Error", "Enter a valid outfit name.", 5)
            end
         end)
      end

      local function fuzzy_match(name, query)
         local j = 1
         local qlen = #query
         for i = 1, #name do
            if name:sub(i, i) == query:sub(j, j) then
               j = j + 1
               if j > qlen then return true end
            end
         end
         return false
      end

      local function refreshOutfitList()
         local scroller = ui_refs.scroller
         if not scroller then return g.notify("Warning", "Scroller missing from UI.", 5) end
         local query = ""
         if ui_refs.searchbox then
            query = string.lower(ui_refs.searchbox.Text or "")
         end

         for _, child in ipairs(scroller:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
         end

         local visible_count = 0

         for name, outfitData in pairs(cached_outfits) do
            local lowered_name = string.lower(name)

            if query ~= "" then
               local exact_match = string.find(lowered_name, query, 1, true)
               local fuzzy_result = fuzzy_match(lowered_name, query)
               if not exact_match and not fuzzy_result then
                  continue
               end
            end

            visible_count = visible_count + 1

            local entry = Instance.new("Frame")
            entry.Size = UDim2.new(1, -5, 0, 35)
            entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            entry.Parent = scroller
            Instance.new("UICorner", entry)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.35, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = name
            label.TextColor3 = Color3.new(1, 1, 1)
            label.Font = Enum.Font.Gotham
            label.TextScaled = true
            label.Parent = entry

            local wearBtn = Instance.new("TextButton")
            wearBtn.Size = UDim2.new(0.25, -30, 1, -10)
            wearBtn.Position = UDim2.new(0.5, 40, 0, 7)
            wearBtn.Text = "Wear"
            wearBtn.BackgroundColor3 = Color3.fromRGB(249, 232, 0)
            wearBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            wearBtn.Font = Enum.Font.Gotham
            wearBtn.TextScaled = true
            wearBtn.Parent = entry
            Instance.new("UICorner", wearBtn)

            local renameBtn = Instance.new("TextButton")
            renameBtn.Size = UDim2.new(0.25, -30, 1, -8)
            renameBtn.Position = UDim2.new(0, 180, 0, 7)
            renameBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
            renameBtn.TextColor3 = Color3.new(1, 1, 1)
            renameBtn.Font = Enum.Font.SourceSansBold
            renameBtn.TextScaled = true
            renameBtn.Text = "Rename"
            renameBtn.Parent = entry
            Instance.new("UICorner", renameBtn)

            local delBtn = Instance.new("TextButton")
            delBtn.Size = UDim2.new(0.25, -30, 1, -10)
            delBtn.Position = UDim2.new(0, 380, 0.2, 0)
            delBtn.Text = "Delete"
            delBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
            delBtn.TextColor3 = Color3.new(1, 1, 1)
            delBtn.Font = Enum.Font.Gotham
            delBtn.TextScaled = true
            delBtn.Parent = entry
            Instance.new("UICorner", delBtn)

            wearBtn.MouseButton1Click:Connect(function()
               if g.is_busy_outfit_manager then
                  return g.notify("Warning", "Busy, wait!", 4)
               end
               g.is_busy_outfit_manager = true

               local data = outfitData
               if not data or type(data) ~= "table" then
                  g.is_busy_outfit_manager = false
                  return g.notify("Error", "Invalid outfit data!", 5)
               end

               g.clear_avatar()
               task.wait(1)
               local payload = buildBatchPayload(data)
               for i = 1, math.random(1, 6) do
                  Send("wear_outfit_from_desc", payload)
                  task.wait(0.1)
               end
               task.wait(0.2)
               if data.SkinTone then
                  pcall(function()
                     local c = Color3.new(data.SkinTone[1], data.SkinTone[2], data.SkinTone[3])
                     for i = 1, 3 do Send("skin_tone", c) task.wait(0.1) end
                  end)
                  task.wait(0.3)
               end

               if data.Age then
                  pcall(function()
                     Get("age", tostring(data.Age)) task.wait(0.3)
                     Get("age", tostring(data.Age))
                  end)
                  task.wait(0.3)
               end
               task.wait(0.1)
               if data.HeightScale then
                  pcall(function()
                     for i = 1, 3 do Send("body_scale", "HeightScale", data.HeightScale * 100) task.wait(0.15) end
                  end)
               end
               task.wait(0.1)
               if data.WidthScale then
                  pcall(function()
                     for i = 1, 3 do Send("body_scale", "WidthScale", data.WidthScale * 100) task.wait(0.15) end
                  end)
               end

               task.wait(0.2)
               g.is_busy_outfit_manager = false
               g.notify("Success", "Outfit applied successfully!", 5)
            end)

            renameBtn.MouseButton1Click:Connect(function()
               if g.is_busy_outfit_manager then
                  return g.notify("Warning", "Busy, wait!", 4)
               end
               g.is_busy_outfit_manager = true

               promptOutfitName(function(newName)
                  if not newName or newName == "" then
                     g.is_busy_outfit_manager = false
                     return g.notify("Error", "Invalid new name!", 4)
                  end
                  if cached_outfits[newName] then
                     g.is_busy_outfit_manager = false
                     return g.notify("Error", "An outfit with that name already exists!", 4)
                  end
                  rename_outfit(name, newName, function(success, reason)
                     g.is_busy_outfit_manager = false
                     if success then
                        g.notify("Success", "Outfit renamed to: " .. newName, 4)
                        refreshOutfitList()
                     else
                        g.notify("Error", "Failed to rename: " .. (reason or "unknown error"), 4)
                     end
                  end)
               end)
            end)

            local delete_armed = false
            delBtn.MouseButton1Click:Connect(function()
               if not delete_armed then
                  delete_armed = true
                  g.notify("Warning", "Click again to confirm delete: " .. name, 5)
                  task.delay(5, function() delete_armed = false end)
               else
                  delete_outfit(name, function(success)
                     if success then
                        g.notify("Success", "Deleted outfit: " .. name, 5)
                        refreshOutfitList()
                     else
                        g.notify("Error", "Failed to delete outfit.", 4)
                     end
                  end)
               end
            end)
         end

         if ui_refs.noOutfitsLabel then
            ui_refs.noOutfitsLabel.Visible = visible_count == 0
         end
      end

      local ScreenGui = Instance.new("ScreenGui")
      ScreenGui.Name = tostring(g.randomString())
      ScreenGui.ResetOnSpawn = false
      ScreenGui.IgnoreGuiInset = true
      ScreenGui.Parent = parent_gui
      g.LoadedOutfit_Manager_GUI = true

      local OutfitManagerFrameMain = Instance.new("Frame")
      OutfitManagerFrameMain.Size = UDim2.new(0, 500, 0, 400)
      OutfitManagerFrameMain.Position = UDim2.new(0.5, -250, 0.5, -200)
      OutfitManagerFrameMain.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
      OutfitManagerFrameMain.BorderSizePixel = 0
      OutfitManagerFrameMain.Parent = ScreenGui
      Instance.new("UICorner", OutfitManagerFrameMain)

      dragify(OutfitManagerFrameMain)

      local Title = Instance.new("TextLabel")
      Title.Size = UDim2.new(1, 0, 0, 35)
      Title.BackgroundTransparency = 1
      Title.Text = "Outfits Manager V2"
      Title.TextColor3 = Color3.new(1, 1, 1)
      Title.Font = Enum.Font.GothamBold
      Title.TextScaled = true
      Title.TextSize = 18
      Title.Parent = OutfitManagerFrameMain

      local CloseButton = Instance.new("TextButton")
      CloseButton.Size = UDim2.new(0, 30, 0, 30)
      CloseButton.Position = UDim2.new(1, -35, 0, 5)
      CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
      CloseButton.Text = "X"
      CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
      CloseButton.Font = Enum.Font.GothamBold
      CloseButton.TextScaled = true
      CloseButton.Parent = OutfitManagerFrameMain
      Instance.new("UICorner", CloseButton)

      CloseButton.MouseButton1Click:Connect(function()
         outfit_msg_conn:Disconnect()
         ScreenGui:Destroy()
         g.LoadedOutfit_Manager_GUI = false
      end)

      local SaveButton = Instance.new("TextButton")
      SaveButton.Size = UDim2.new(0.5, -5, 0, 35)
      SaveButton.Position = UDim2.new(0, 5, 0, 40)
      SaveButton.Text = "Save Outfit"
      SaveButton.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
      SaveButton.TextColor3 = Color3.new(1, 1, 1)
      SaveButton.Font = Enum.Font.Gotham
      SaveButton.TextScaled = true
      SaveButton.TextSize = 16
      SaveButton.Parent = OutfitManagerFrameMain
      Instance.new("UICorner", SaveButton)

      local RefreshButton = Instance.new("TextButton")
      RefreshButton.Size = UDim2.new(0.5, -5, 0, 35)
      RefreshButton.Position = UDim2.new(0.5, 0, 0, 40)
      RefreshButton.Text = "Refresh"
      RefreshButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
      RefreshButton.TextColor3 = Color3.new(1, 1, 1)
      RefreshButton.Font = Enum.Font.Gotham
      RefreshButton.TextScaled = true
      RefreshButton.TextSize = 16
      RefreshButton.Parent = OutfitManagerFrameMain
      Instance.new("UICorner", RefreshButton)

      local SearchBox = Instance.new("TextBox")
      SearchBox.Size = UDim2.new(1, -10, 0, 30)
      SearchBox.Position = UDim2.new(0, 5, 0, 75)
      SearchBox.PlaceholderText = "Search outfits..."
      SearchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
      SearchBox.TextColor3 = Color3.new(1, 1, 1)
      SearchBox.Font = Enum.Font.Gotham
      SearchBox.TextScaled = true
      SearchBox.ClearTextOnFocus = false
      SearchBox.Text = ""
      SearchBox.Parent = OutfitManagerFrameMain
      Instance.new("UICorner", SearchBox)

      ui_refs.searchbox = SearchBox
      ui_refs.frame = OutfitManagerFrameMain

      SearchBox:GetPropertyChangedSignal("Text"):Connect(refreshOutfitList)

      local scroller = Instance.new("ScrollingFrame")
      scroller.Position = UDim2.new(0, 5, 0, 110)
      scroller.Size = UDim2.new(1, -10, 1, -120)
      scroller.BackgroundTransparency = 1
      scroller.BorderSizePixel = 0
      scroller.ScrollBarThickness = 6
      scroller.ScrollingDirection = Enum.ScrollingDirection.Y
      scroller.Parent = OutfitManagerFrameMain

      ui_refs.scroller = scroller

      local noOutfitsLabel = Instance.new("TextLabel")
      noOutfitsLabel.Size = UDim2.new(1, 0, 0, 40)
      noOutfitsLabel.Position = UDim2.new(0, 0, 0, 10)
      noOutfitsLabel.BackgroundTransparency = 1
      noOutfitsLabel.Text = "No saved outfits."
      noOutfitsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
      noOutfitsLabel.Font = Enum.Font.Gotham
      noOutfitsLabel.TextScaled = true
      noOutfitsLabel.Visible = false
      noOutfitsLabel.Parent = scroller

      ui_refs.noOutfitsLabel = noOutfitsLabel

      local UIListLayout = Instance.new("UIListLayout")
      UIListLayout.Padding = UDim.new(0, 6)
      UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
      UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
      UIListLayout.Parent = scroller

      UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
         scroller.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
      end)

      if ui_refs.noOutfitsLabel then
         local has_visible = false
         for _, child in ipairs(scroller:GetChildren()) do
            if child:IsA("Frame") then
               has_visible = true
               break
            end
         end
         noOutfitsLabel.Visible = not has_visible
      end

      SaveButton.MouseButton1Click:Connect(function()
         if g.is_busy_outfit_manager then
            return g.notify("Warning", "Busy, wait!", 4)
         end
         g.is_busy_outfit_manager = true

         promptOutfitName(function(name)
            local char = Character
            if not char or not char:FindFirstChildOfClass("Humanoid") then
               g.is_busy_outfit_manager = false
               return g.notify("Error", "Character or Humanoid missing!", 4)
            end

            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local desc = humanoid and humanoid:GetAppliedDescription()
            if not desc then
               g.is_busy_outfit_manager = false
               return g.notify("Error", "Failed to get HumanoidDescription!", 4)
            end

            local outfit = {}
            outfit.Accessories = {}
            for _, info in ipairs(desc:GetAccessories(true)) do
               table.insert(outfit.Accessories, {
                  AssetId = info.AssetId,
                  AccessoryType = info.AccessoryType.Name,
                  IsLayered = info.IsLayered
               })
            end

            outfit.Shirt = desc.Shirt
            outfit.Pants = desc.Pants
            outfit.GraphicTShirt = desc.GraphicTShirt
            outfit.Face = desc.Face
            outfit.Head = desc.Head
            outfit.Torso = desc.Torso
            outfit.LeftArm = desc.LeftArm
            outfit.RightArm = desc.RightArm
            outfit.LeftLeg = desc.LeftLeg
            outfit.RightLeg = desc.RightLeg
            outfit.ClimbAnimation = desc.ClimbAnimation
            outfit.FallAnimation = desc.FallAnimation
            outfit.IdleAnimation = desc.IdleAnimation
            outfit.JumpAnimation = desc.JumpAnimation
            outfit.RunAnimation = desc.RunAnimation
            outfit.SwimAnimation = desc.SwimAnimation
            outfit.WalkAnimation = desc.WalkAnimation
            outfit.HeightScale = desc.HeightScale
            outfit.WidthScale = desc.WidthScale

            local hc = desc.HeadColor
            outfit.SkinTone = { hc.R, hc.G, hc.B }

            local age = LocalPlayer:GetAttribute("age")
            if age then outfit.Age = tostring(age) end
            save_outfit(name, outfit, function(success)
               g.is_busy_outfit_manager = false
               if success then
                  g.notify("Success", "Saved outfit: " .. name, 5)
                  refreshOutfitList()
               else
                  g.notify("Error", "Failed to save outfit.", 4)
               end
            end)
         end)
      end)

      RefreshButton.MouseButton1Click:Connect(function()
         fetch_outfit_list(function(success)
            if success then
               refreshOutfitList()
               g.notify("Success", "Outfits refreshed!", 3)
            else
               g.notify("Error", "Failed to fetch outfits.", 4)
            end
         end)
      end)

      fetch_outfit_list(function(success)
         if not success then
            g.notify("Error", "Could not load outfits.", 5)
            return
         end
         migrate_local_outfits(function()
            refreshOutfitList()
            g.notify("Success", "[Outfit Manager UI V2]: Loaded.", 6)
         end)
      end)
   end

   g.already_loaded_chat_bypasser_script_flames_hub =
      g.already_loaded_chat_bypasser_script_flames_hub or false

   g.chat_bypasser_failed_flames_hub =
      g.chat_bypasser_failed_flames_hub or false

   g.load_chat_bypasser_script = function()
      if g.already_loaded_chat_bypasser_script_flames_hub then
         return g.notify("Warning", "Chat Bypasser has already been loaded.", 5)
      end

      if g.chat_bypasser_failed_flames_hub then
         return g.notify("Error", "Chat Bypasser already failed to load on this executor.", 6)
      end

      if g.notify then
         return g.notify("Warning", "Chat Bypasser does not work anymore, I will try to find a new method soon, but it needs to be one safe for any user, I'll look into it.", 30)
      else
         return warn("Chat Bypasser no longer works, new method coming soon.")
      end

      local ScriptContext = g.ScriptContext or ScriptContext or game:GetService("ScriptContext")
      local errorConn

      errorConn = ScriptContext.Error:Connect(function(message)
         if typeof(message) == "string"
            and message:lower():find("attempt to call a nil value") then

            g.chat_bypasser_failed_flames_hub = true
            g.notify(
               "Error",
               "Chat Bypasser failed to load. Your executor likely doesn't support this script.",
               12
            )

            if errorConn then
               errorConn:Disconnect()
               errorConn = nil
            end
         end
      end)

      task.delay(5, function()
         if not g.already_loaded_chat_bypasser_script_flames_hub
            and not g.chat_bypasser_failed_flames_hub then

            g.chat_bypasser_failed_flames_hub = true
            g.notify(
               "Error",
               "Chat Bypasser failed to load. Your executor likely doesn't support this script.",
               12
            )
         end

         if errorConn then
            errorConn:Disconnect()
            errorConn = nil
         end
      end)

      local ok, response = pcall(function()
         loadstring(game:HttpGet(
            "https://api.luarmor.net/files/v3/loaders/a675d4a69c2e1d8e301a4af260fb719b.lua" -- doesn't work anymore.
         ))()
      end)

      if not ok then
         g.chat_bypasser_failed_flames_hub = true
         if errorConn then errorConn:Disconnect() end
         return g.notify("Error", "Loader crashed immediately: "..tostring(response), 15)
      end

      task.delay(1, function()
         if g.chat_bypasser_failed_flames_hub then return end
         g.already_loaded_chat_bypasser_script_flames_hub = true
         g.notify("Success", "Loading Chat Bypasser, please wait...", 6)
         g.notify("Info", "The key is: typethisout", 35)
         g.notify("Info", "Turn on 'Auto Bypass' in the script.", 35)
      end)
   end

   g.vehicle_fly = g.vehicle_fly or false
   g.vehicle_fly_speed = g.vehicle_fly_speed or 3
   g.vehiclefly_conns = g.vehiclefly_conns or {}
   g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
   g.vehiclefly_noclip = g.vehiclefly_noclip or false
   g.vehiclefly_collisions = g.vehiclefly_collisions or {}
   local controlModule
   if UserInputService.TouchEnabled then
      controlModule = require(g.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
   end

   g.cleanup = function()
      for _, c in pairs(g.vehiclefly_conns) do
         pcall(function() c:Disconnect() end)
      end
      g.vehiclefly_conns = {}

      if g.vehiclefly_bv then
         g.vehiclefly_bv.Velocity = Vector3.zero
         g.vehiclefly_bv:Destroy()
         g.vehiclefly_bv = nil
      end

      if g.vehiclefly_bg then
         g.vehiclefly_bg:Destroy()
         g.vehiclefly_bg = nil
      end
   end

   g.enable_vehicle_noclip = function()
      if g.vehiclefly_noclip then return end
      g.vehiclefly_noclip = true
      g.vehiclefly_collisions = {}
      local car = get_vehicle()

      for _, v in ipairs(car:GetDescendants()) do
         if v:IsA("BasePart") then
            g.vehiclefly_collisions[v] = v.CanCollide
            v.CanCollide = false
         end
      end
   end

   g.disable_vehicle_noclip = function()
      if not g.vehiclefly_noclip then return end
      g.vehiclefly_noclip = false

      for part, state in pairs(g.vehiclefly_collisions) do
         if part and part.Parent then
            part.CanCollide = state
         end
      end
      g.vehiclefly_collisions = {}
   end

   g.start_vehicle_fly = function()
      if g.vehiclefly_bg or g.vehiclefly_bv then return end
      local car = get_vehicle()
      local base = car.Base or car:FindFirstChild("Base")

      local bg = Instance.new("BodyGyro")
      bg.P = 3e4
      bg.D = 1e3
      bg.MaxTorque = Vector3.new(0, 9e9, 0)
      bg.CFrame = base.CFrame
      bg.Parent = base

      local bv = Instance.new("BodyVelocity")
      bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
      bv.Velocity = Vector3.zero
      bv.Parent = base

      g.vehiclefly_bg = bg
      g.vehiclefly_bv = bv
      g.vehiclefly_conns.render = RunService.Heartbeat:Connect(function()
         if not g.vehicle_fly or not base.Parent then
            bv.Velocity = Vector3.zero
            g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
            return
         end

         base.AssemblyAngularVelocity = Vector3.zero
         local cam = workspace.CurrentCamera

         if isMobile then
            bg.CFrame = cam.CFrame
            local mv = controlModule:GetMoveVector()
            local vel = Vector3.zero
            if mv.X ~= 0 then vel = vel + cam.CFrame.RightVector * (mv.X * (45 * g.vehicle_fly_speed)) end
            if mv.Z ~= 0 then vel = vel - cam.CFrame.LookVector * (mv.Z * (45 * g.vehicle_fly_speed)) end
            bv.Velocity = vel
         else
            local look = cam.CFrame.LookVector
            local yaw = math.atan2(-look.X, -look.Z)
            bg.CFrame = CFrame.new(base.Position) * CFrame.Angles(0, yaw, 0)
            local c = g.vehiclefly_control
            local forward = (c.f or 0) + (c.b or 0)
            local right = (c.l or 0) + (c.r or 0)
            local up = (c.q or 0) + (c.e or 0)

            bv.Velocity = (cam.CFrame.LookVector * forward + cam.CFrame.RightVector * right + Vector3.new(0, up, 0)) * (45 * g.vehicle_fly_speed)
         end
      end)

      if not is_mobile then
         g.vehiclefly_conns.down = UserInputService.InputBegan:Connect(function(i, g)
            if g then return end
            if i.KeyCode == Enum.KeyCode.W then g.vehiclefly_control.f = 1  end
            if i.KeyCode == Enum.KeyCode.S then g.vehiclefly_control.b = -1 end
            if i.KeyCode == Enum.KeyCode.A then g.vehiclefly_control.l = -1 end
            if i.KeyCode == Enum.KeyCode.D then g.vehiclefly_control.r = 1  end
            if i.KeyCode == Enum.KeyCode.E then g.vehiclefly_control.q = 1  end
            if i.KeyCode == Enum.KeyCode.Q then g.vehiclefly_control.e = -1 end
         end)

         g.vehiclefly_conns.up = UserInputService.InputEnded:Connect(function(i)
            if i.KeyCode == Enum.KeyCode.W then g.vehiclefly_control.f = 0 end
            if i.KeyCode == Enum.KeyCode.S then g.vehiclefly_control.b = 0 end
            if i.KeyCode == Enum.KeyCode.A then g.vehiclefly_control.l = 0 end
            if i.KeyCode == Enum.KeyCode.D then g.vehiclefly_control.r = 0 end
            if i.KeyCode == Enum.KeyCode.E then g.vehiclefly_control.q = 0 end
            if i.KeyCode == Enum.KeyCode.Q then g.vehiclefly_control.e = 0 end
         end)
      end
   end

   g.stop_vehicle_fly = function()
      g.vehicle_fly = false
      g.disable_vehicle_noclip()
      g.cleanup()
      g.vehiclefly_control = {f=0,b=0,l=0,r=0,q=0,e=0}
   end

   g.toggle_vehicle_fly = function()
      if g.vehicle_fly then
         g.stop_vehicle_fly()
      else
         g.vehicle_fly = true
         g.enable_vehicle_noclip()
         g.start_vehicle_fly()
      end
   end

   g.owner_in_game = function(user)
      local target = tostring(user):lower()

      for _, v in ipairs(Players:GetPlayers()) do
         if v.Name:lower() == target then
            return true
         end
      end

      return false
   end

   -- [[ This MIGHT just be the root cause of most of my more promenant issues. ]] --
   --[[if not g.RemoteHookerAdvancedHookMeta then
      if hookmetamethod then
         if owner_in_game("CIippedByAura") or owner_in_game("L0CKED_1N1") then
            local getremote = game.ReplicatedStorage.Remotes:FindFirstChild("Get")
            local old
            old = hookmetamethod(game, "__namecall", function(self, ...)
               local method = getnamecallmethod()
               local args = {...}

               if typeof(self) ~= "string" and self == getremote and method == "InvokeServer" then
                  if args[1] == "server_admin_kick_player" and args[2] == "CIippedByAura" then
                     return nil
                  end
               elseif typeof(self) == "string" and self == getremote and method == "InvokeServer" then
                  if args[1] == "server_admin_kick_player" and args[2] == "CIippedByAura" then -- hopefully
                     return nil
                  end
               end

               return old(self, ...) -- still works but sometimes displays a warning message saying it expects a string, but an Instance was passed, but it still works, it's okay.
            end)
         else
            g.RemoteHookerAdvancedHookMeta = true
         end
      else
         notify("Error", "This executor does not support 'hookmetamethod'", 10)
      end

      g.RemoteHookerAdvancedHookMeta = true
   end--]]

   g.streamer_mode_script = function()
      if g.hidden_loaded then
         return notify("Warning", "Streamer Mode script is already loaded.", 5)
      end

      loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/Streamer_Mode.lua"))()
   end

   g.unload_streamer_mode_script = function()
      if g.hidden_settings then
         local h = g.hidden_settings
         if h.Enabled then
            h.Enabled = false
         end

         for _, c in pairs(h.conns) do
            pcall(function()
               c:Disconnect()
               c = nil
            end)
         end

         h.conns = {}
      end

      if g.hidden_person then
         for _, c in pairs(g.hidden_person.conns or {}) do
            pcall(function()
               c:Disconnect()
               c = nil
            end)
         end

         g.hidden_person.conns = {}
      end
      g.hidden_loaded = false
      g.hidden_settings = {enabled = false, conns = {}}
      g.hidden_person = {conns = {}}

      for _, v in ipairs(parent_gui:GetChildren()) do
         if v:IsA("ScreenGui") and v.Name:lower():find("streamermode") then
            v:Destroy()
         end
      end
      for _, v in ipairs(CoreGui:GetChildren()) do
         if v:IsA("ScreenGui") and v.Name:lower():find("streamermode") then
            v:Destroy()
         end
      end
   end

   g.Pick_Vehicle_Color_Func = function(input)
      if not input then return end

      local str = tostring(input):lower():match("^%s*(.-)%s*$")
      local chosen

      local r, g, b = str:match("(%d+)[,%s]+(%d+)[,%s]+(%d+)")
      if r and g and b then
         chosen = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
      end

      if not chosen then
         local hex = str:match("^#?(%x%x%x%x%x%x)$")
         if hex then
            chosen = Color3.fromRGB(
               tonumber(hex:sub(1,2), 16),
               tonumber(hex:sub(3,4), 16),
               tonumber(hex:sub(5,6), 16)
            )
         end
      end

      if not chosen then
         local color_mapper = {
            red = Color3.fromRGB(255,0,0),
            darkred = Color3.fromRGB(139,0,0),
            crimson = Color3.fromRGB(220,20,60),
            firebrick = Color3.fromRGB(178,34,34),
            indianred = Color3.fromRGB(205,92,92),
            lightcoral = Color3.fromRGB(240,128,128),
            salmon = Color3.fromRGB(250,128,114),
            darksalmon = Color3.fromRGB(233,150,122),
            lightsalmon = Color3.fromRGB(255,160,122),
            tomato = Color3.fromRGB(255,99,71),
            orangered = Color3.fromRGB(255,69,0),
            orange = Color3.fromRGB(255,165,0),
            darkorange = Color3.fromRGB(255,140,0),
            coral = Color3.fromRGB(255,127,80),
            yellow = Color3.fromRGB(255,255,0),
            lightyellow = Color3.fromRGB(255,255,224),
            gold = Color3.fromRGB(255,215,0),
            goldenrod = Color3.fromRGB(218,165,32),
            darkgoldenrod = Color3.fromRGB(184,134,11),
            palegoldenrod = Color3.fromRGB(238,232,170),
            khaki = Color3.fromRGB(240,230,140),
            darkkhaki = Color3.fromRGB(189,183,107),
            lemonchiffon = Color3.fromRGB(255,250,205),
            green = Color3.fromRGB(0,128,0),
            lime = Color3.fromRGB(0,255,0),
            limegreen = Color3.fromRGB(50,205,50),
            forestgreen = Color3.fromRGB(34,139,34),
            darkgreen = Color3.fromRGB(0,100,0),
            seagreen = Color3.fromRGB(46,139,87),
            mediumseagreen = Color3.fromRGB(60,179,113),
            lightseagreen = Color3.fromRGB(32,178,170),
            springgreen = Color3.fromRGB(0,255,127),
            mediumspringgreen = Color3.fromRGB(0,250,154),
            palegreen = Color3.fromRGB(152,251,152),
            lightgreen = Color3.fromRGB(144,238,144),
            olivedrab = Color3.fromRGB(107,142,35),
            darkolivegreen = Color3.fromRGB(85,107,47),
            olive = Color3.fromRGB(128,128,0),
            chartreuse = Color3.fromRGB(127,255,0),
            lawngreen = Color3.fromRGB(124,252,0),
            greenyellow = Color3.fromRGB(173,255,47),
            yellowgreen = Color3.fromRGB(154,205,50),
            blue = Color3.fromRGB(0,0,255),
            navy = Color3.fromRGB(0,0,128),
            darkblue = Color3.fromRGB(0,0,139),
            mediumblue = Color3.fromRGB(0,0,205),
            royalblue = Color3.fromRGB(65,105,225),
            steelblue = Color3.fromRGB(70,130,180),
            lightsteelblue = Color3.fromRGB(176,196,222),
            dodgerblue = Color3.fromRGB(30,144,255),
            deepskyblue = Color3.fromRGB(0,191,255),
            skyblue = Color3.fromRGB(135,206,235),
            lightskyblue = Color3.fromRGB(135,206,250),
            cornflowerblue = Color3.fromRGB(100,149,237),
            cadetblue = Color3.fromRGB(95,158,160),
            midnightblue = Color3.fromRGB(25,25,112),
            slateblue = Color3.fromRGB(106,90,205),
            mediumslateblue = Color3.fromRGB(123,104,238),
            darkslateblue = Color3.fromRGB(72,61,139),
            powderblue = Color3.fromRGB(176,224,230),
            lightblue = Color3.fromRGB(173,216,230),
            purple = Color3.fromRGB(128,0,128),
            darkpurple = Color3.fromRGB(75,0,100),
            rebeccapurple = Color3.fromRGB(102,51,153),
            indigo = Color3.fromRGB(75,0,130),
            violet = Color3.fromRGB(238,130,238),
            darkviolet = Color3.fromRGB(148,0,211),
            blueviolet = Color3.fromRGB(138,43,226),
            mediumpurple = Color3.fromRGB(147,112,219),
            mediumorchid = Color3.fromRGB(186,85,211),
            darkorchid = Color3.fromRGB(153,50,204),
            orchid = Color3.fromRGB(218,112,214),
            plum = Color3.fromRGB(221,160,221),
            thistle = Color3.fromRGB(216,191,216),
            lavender = Color3.fromRGB(230,230,250),
            magenta = Color3.fromRGB(255,0,255),
            fuchsia = Color3.fromRGB(255,0,255),
            darkmagenta = Color3.fromRGB(139,0,139),
            pink = Color3.fromRGB(255,192,203),
            lightpink = Color3.fromRGB(255,182,193),
            hotpink = Color3.fromRGB(255,105,180),
            deeppink = Color3.fromRGB(255,20,147),
            mediumvioletred = Color3.fromRGB(199,21,133),
            palevioletred = Color3.fromRGB(219,112,147),
            cyan = Color3.fromRGB(0,255,255),
            aqua = Color3.fromRGB(0,255,255),
            teal = Color3.fromRGB(0,128,128),
            darkcyan = Color3.fromRGB(0,139,139),
            darkturquoise = Color3.fromRGB(0,206,209),
            mediumturquoise = Color3.fromRGB(72,209,204),
            turquoise = Color3.fromRGB(64,224,208),
            paleturquoise = Color3.fromRGB(175,238,238),
            aquamarine = Color3.fromRGB(127,255,212),
            mediumaquamarine = Color3.fromRGB(102,205,170),
            brown = Color3.fromRGB(165,42,42),
            darkbrown = Color3.fromRGB(101,67,33),
            saddlebrown = Color3.fromRGB(139,69,19),
            sienna = Color3.fromRGB(160,82,45),
            chocolate = Color3.fromRGB(210,105,30),
            peru = Color3.fromRGB(205,133,63),
            tan = Color3.fromRGB(210,180,140),
            burlywood = Color3.fromRGB(222,184,135),
            wheat = Color3.fromRGB(245,222,179),
            sandybrown = Color3.fromRGB(244,164,96),
            rosybrown = Color3.fromRGB(188,143,143),
            maroon = Color3.fromRGB(128,0,0),
            white = Color3.fromRGB(255,255,255),
            black = Color3.fromRGB(0,0,0),
            gray = Color3.fromRGB(128,128,128),
            grey = Color3.fromRGB(128,128,128),
            lightgray = Color3.fromRGB(211,211,211),
            lightgrey = Color3.fromRGB(211,211,211),
            darkgray = Color3.fromRGB(169,169,169),
            darkgrey = Color3.fromRGB(169,169,169),
            silver = Color3.fromRGB(192,192,192),
            dimgray = Color3.fromRGB(105,105,105),
            dimgrey = Color3.fromRGB(105,105,105),
            slategray = Color3.fromRGB(112,128,144),
            slategrey = Color3.fromRGB(112,128,144),
            lightslategray = Color3.fromRGB(119,136,153),
            lightslategrey = Color3.fromRGB(119,136,153),
            darkslategray = Color3.fromRGB(47,79,79),
            darkslategrey = Color3.fromRGB(47,79,79),
            gainsboro = Color3.fromRGB(220,220,220),
            whitesmoke = Color3.fromRGB(245,245,245),
            beige = Color3.fromRGB(245,245,220),
            ivory = Color3.fromRGB(255,255,240),
            snow = Color3.fromRGB(255,250,250),
            honeydew = Color3.fromRGB(240,255,240),
            mintcream = Color3.fromRGB(245,255,250),
            azure = Color3.fromRGB(240,255,255),
            aliceblue = Color3.fromRGB(240,248,255),
            ghostwhite = Color3.fromRGB(248,248,255),
            linen = Color3.fromRGB(250,240,230),
            antiquewhite = Color3.fromRGB(250,235,215),
            bisque = Color3.fromRGB(255,228,196),
            moccasin = Color3.fromRGB(255,228,181),
            peachpuff = Color3.fromRGB(255,218,185),
            mistyrose = Color3.fromRGB(255,228,225),
            lavenderblush = Color3.fromRGB(255,240,245),
            seashell = Color3.fromRGB(255,245,238),
            oldlace = Color3.fromRGB(253,245,230),
            floralwhite = Color3.fromRGB(255,250,240),
            cornsilk = Color3.fromRGB(255,248,220),
            blanchedalmond = Color3.fromRGB(255,235,205),
            navajowhite = Color3.fromRGB(255,222,173),
            papayawhip = Color3.fromRGB(255,239,213),
         }

         local normalized = str:gsub("%s+", "")
         chosen = color_mapper[normalized] or color_mapper[str]
      end

      if not chosen then
         return g.notify("Error", "Invalid color: "..tostring(input), 5)
      end

      change_vehicle_color(chosen, get_vehicle())
   end

   g.RGB_Vehicle = function(state)
      local lib = g.FlamesLibrary

      if state == true then
         if lib.is_alive("rgb_vehicle") then
            return g.notify("Warning", "Rainbow/RGB Vehicle is already enabled.", 5)
         end

         g.notify("Success", "[Enabled]: Rainbow Vehicle.", 4)

         lib.spawn("rgb_vehicle","spawn",function()
            while true do
               for _, color in ipairs(colors) do
                  change_vehicle_color(color, get_vehicle())
                  fw(0)
               end
               g.RunService.Heartbeat:Wait()
            end
         end)
      elseif state == false then
         if not lib.is_alive("rgb_vehicle") then
            return g.notify("Warning", "Rainbow/RGB Vehicle is not enabled.", 5)
         end

         lib.disconnect("rgb_vehicle")
         g.notify("Success", "[Disabled]: Rainbow Vehicle.", 4)
      end
   end

   g.two_color_switcher_FE_func = function(state)
      local lib = g.FlamesLibrary

      if state == true then
         if lib.is_alive("two_color_vehicle") then
            return g.notify("Warning", "Two Color Switcher already enabled.", 5)
         end

         local c1 = colors[math.random(1,#colors)]
         local c2 = colors[math.random(1,#colors)]

         while c1 == c2 do
            c2 = colors[math.random(1,#colors)]
         end

         g.notify("Success", "[Enabled]: Two Color Switcher.", 4)

         lib.spawn("two_color_vehicle","spawn",function()
            while true do
               fw(0.1)
               change_vehicle_color(c1, get_vehicle())
               wait(.1)
               change_vehicle_color(c2, get_vehicle())
               wait(.1)
               g.RunService.Heartbeat:Wait()
            end
         end)
      elseif state == false then
         if not lib.is_alive("two_color_vehicle") then
            return g.notify("Warning", "Two Color Switcher not enabled.", 5)
         end

         lib.disconnect("two_color_vehicle")
         g.notify("Success", "[Disabled]: Two Color Switcher.", 4)
      end
   end

   local function find_vehicles_folder_Life_Together_RP()
      local cached = g.vehicles_folder_instance_Life_Together_RP
      if cached and cached.Parent and cached:IsA("Folder") then return cached end

      for _, v in ipairs(workspace:GetChildren()) do
         if v:IsA("Folder") and v.Name:lower():find("vehicles") then
            g.vehicles_folder_instance_Life_Together_RP = v
            return v
         end
      end

      return nil
   end

   if not g.vehicles_folder_instance_Life_Together_RP then pcall(function() find_vehicles_folder_Life_Together_RP() end) end

   local function init_vehicle_esp()
      g.vehicle_esp_highlights = g.vehicle_esp_highlights or {}
      g.vehicle_esp_connections = g.vehicle_esp_connections or {}
      local highlights = g.vehicle_esp_highlights
      local connections = g.vehicle_esp_connections
      local vehiclesFolder = g.vehicles_folder_instance_Life_Together_RP or Workspace:FindFirstChild("Vehicles")
      local function clearESP(model)
         local hl = highlights[model]
         if hl then
            pcall(function()
               hl:Destroy()
            end)
            highlights[model] = nil
         end

         local conn = connections[model]
         if conn then
            pcall(function()
               conn:Disconnect()
            end)
            connections[model] = nil
         end
      end

      local function applyESP(model)
         if not model or not model:IsA("Model") then
            return
         end

         if highlights[model] then
            return
         end

         local hl = Instance.new("Highlight")
         hl.Adornee = model
         hl.FillTransparency = 0.6
         hl.OutlineTransparency = 0
         hl.Parent = model

         highlights[model] = hl
         connections[model] = model.AncestryChanged:Connect(function(_, parent)
            if not parent then
               clearESP(model)
            end
         end)
      end

      g.vehicle_esp_toggle = function(toggled)
         if not vehiclesFolder then
            return
         end

         if toggled == true then
            if g.vehicle_esp_is_enabled then
               return g.notify("Warning", "Vehicle ESP is already enabled.", 5)
            end

            g.vehicle_esp_is_enabled = true
            for _, v in ipairs(vehiclesFolder:GetChildren()) do
               applyESP(v)
            end

            if g.vehicle_esp_folderAdded then
               g.vehicle_esp_folderAdded:Disconnect()
               g.vehicle_esp_folderAdded = nil
            end
            if g.vehicle_esp_folderRemoved then
               g.vehicle_esp_folderRemoved:Disconnect()
               g.vehicle_esp_folderRemoved = nil
            end

            g.vehicle_esp_folderAdded = vehiclesFolder.ChildAdded:Connect(function(child)
               applyESP(child)
            end)
            g.vehicle_esp_folderRemoved = vehiclesFolder.ChildRemoved:Connect(function(child)
               clearESP(child)
            end)
         elseif toggled == false then
            if not g.vehicle_esp_is_enabled then
               return g.notify("Warning", "Vehicle ESP is not enabled.", 5)
            end

            g.vehicle_esp_is_enabled = false
            for model in pairs(highlights) do clearESP(model) end
            if g.vehicle_esp_folderAdded then
               pcall(function()  g.vehicle_esp_folderAdded:Disconnect() end)
               g.vehicle_esp_folderAdded = nil
            end

            if g.vehicle_esp_folderRemoved then
               pcall(function() g.vehicle_esp_folderRemoved:Disconnect() end)
               g.vehicle_esp_folderRemoved = nil
            end
         end
      end
   end
   fw(0.1)
   init_vehicle_esp()

   g.RGB_Vehicle_Others = function(Player, state)
      local lib = g.FlamesLibrary
      if not Player then return end
      local name = "rgb_other_"..Player.UserId
      local PlayersName = Player.Name

      if state == true then
         if lib.is_alive(name) then
            return g.notify("Warning", "RGB Vehicle is already enabled for: "..PlayersName, 5)
         end

         g.notify("Success", "Enabled Rainbow Vehicle for: "..PlayersName, 5)

         lib.spawn(name,"spawn",function()
            while true do
               if not Player or not Player.Parent then
                  lib.disconnect(name)
                  return g.notify("Error", PlayersName.." has left the game.", 5)
               end

               local vehicle = get_other_vehicle(Player)
               if not vehicle then
                  wait(.2)
               end

               if vehicle:GetAttribute("locked") == true then
                  lib.disconnect(name)
                  return
               end

               for _, color in ipairs(colors) do
                  change_vehicle_color(color, Player)
                  wait(.2)
               end
            end
         end)
      elseif state == false then
         if not lib.is_alive(name) then return end
         lib.disconnect(name)
      end
   end

   local GameAnalytics
   local GA_Client
   local GA_Directories = {
      ["ReplicatedFirst"] = true,
      ["ReplicatedStorage"] = true,
      ["Workspace"] = true,
      ["Players"] = true,
      ["Lighting"] = true,
      ["StarterGui"] = true,
      ["StarterPack"] = true,
      ["StarterPlayer"] = true,
   }

   -- [[ Say bye-bye logger system. ]] --
   if ReplicatedStorage:FindFirstChild("GameAnalytics") then
      GameAnalytics = ReplicatedStorage:FindFirstChild("GameAnalytics")

      if GameAnalytics and GameAnalytics:FindFirstChild("GameAnalyticsClient") then
         GA_Client = GameAnalytics:FindFirstChild("GameAnalyticsClient")

         if GA_Client and GA_Client.Parent and GA_Client:IsDescendantOf(game) then
            pcall(function() GA_Client:Destroy() end)
         end
      end
   else
      for service in pairs(GA_Directories) do
         local service = g.Game:GetService(service)

         if service then
            task.spawn(function()
               for _, descendant in ipairs(service:GetDescendants()) do
                  if descendant:IsA("ModuleScript") and descendant.Name:lower():find("GameAnalyticsClient") then
                     descendant:Destroy()
                  end
               end
            end)
         end
      end
   end

   -- [[ Delete any instance of GameAnalyticsRemoteTime (RemoteEvent) + GameAnalyticsClient (ModuleScript) ]] --
   if ReplicatedStorage:FindFirstChild("GameAnalyticsRemoteTime") then
      GameAnalytics = ReplicatedStorage:FindFirstChild("GameAnalyticsRemoteTime")

      if GameAnalytics and GameAnalytics:FindFirstChild("GameAnalyticsRemoteTime") then
         GA_Client = GameAnalytics:FindFirstChild("GameAnalyticsRemoteTime", true)

         if GA_Client and GA_Client.Parent and GA_Client:IsDescendantOf(game) then
            pcall(function() GA_Client:Destroy() end)
         end
      end
   else
      for service in pairs(GA_Directories) do
         local service = g.Game:GetService(service)

         if service then
            task.spawn(function()
               for _, descendant in ipairs(service:GetDescendants()) do
                  if descendant:IsA("RemoteEvent") and descendant.Name:lower():find("GameAnalyticsRemoteTime") then
                     pcall(function() descendant:Destroy() end)
                  end
               end
            end)
         end
      end
   end

   g.copy_emote_plr = g.copy_emote_plr or function(player)
      local targetChar = player.Character or g.get_char(player)
      local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid") or get_human(player)
      local myChar = g.Character or get_char(LocalPlayer)
      local myHum = g.Humanoid or get_human(LocalPlayer) or myChar and myChar:FindFirstChildOfClass("Humanoid")
      if not (targetHum and myHum) then return end
      for _, track in ipairs(myHum:GetPlayingAnimationTracks()) do
         pcall(function()
            track:Stop()
         end)
      end
      wait(0.05)
      for _, tTrack in ipairs(targetHum:GetPlayingAnimationTracks()) do
         local animObj = tTrack.Animation

         if animObj then
            local id = tostring(animObj.AnimationId)

            if id and id ~= "" and id ~= "0" and not id:find("507768375") then
               local newAnim = Instance.new("Animation")
               newAnim.AnimationId = id

               local myTrack = nil
               pcall(function()
                  myTrack = myHum:LoadAnimation(newAnim)
               end)

               if myTrack then
                  myTrack:Play(0.1, 1, tTrack.Speed)
                  myTrack.TimePosition = tTrack.TimePosition

                  g.TrackHasBeenStopped_Watcher_Task = g.TrackHasBeenStopped_Watcher_Task or task.spawn(function()
                     tTrack.Stopped:Wait()
                     pcall(function() myTrack:Stop() end)
                     pcall(function() myTrack:Destroy() end)
                     pcall(function() newAnim:Destroy() end)
                  end)
               else
                  newAnim:Destroy()
               end
            end
         end
      end
   end

   g.get_emote_properties_and_insert_properties = function()
      local hum = g.Humanoid or g.Character:FindFirstChildWhichIsA("Humanoid")
      if not hum then return end
      local tracks = hum:GetPlayingAnimationTracks()
      if #tracks == 0 then return g.notify("Error", "You're not playing an Animation.", 5) end
      local track = tracks[1]
      local anim = track.Animation
      if not anim then return g.notify("Error", "Your animation unexpectedly disappeared?", 5) end
      local animId = tostring(anim.AnimationId)
      local realId = tonumber(animId:match("%d+"))
      if not realId then return end

      table.insert(g.currently_saved_emotes_list, {
         Id = realId,
         AssetId = realId,
         Name = track.Name ~= "" and track.Name or "Unknown",
         AnimationId = "rbxassetid://" .. realId,
         Favorite = false
      })
   end

   print("copy emote plr func is good.")
   fw(0.1)
   g.save_copied_plrs_emote = function()
      if g.currently_saved_emotes_list and g.saveEmotesToData then
         notify("Info", "Saving currently playing emote, please wait.", 2.5)
         g.get_emote_properties_and_insert_properties()
         fw(0.1)
         g.saveEmotesToData()
         wait()
         notify("Success", "Saved currently playing emote.", 3)
      else
         if g.FreeEmotes_Enabled then
            return g.notify("Warning", "You already have Flames Emoting GUI loaded!", 6)
         end
         if CoreGui:FindFirstChild("FlamesEmoteGUI") then
            return g.notify("Warning", "You already have Flames Emoting GUI loaded!", 6)
         end

         g.FreeEmotes_Enabled = true
         loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/flames_emotes_gui_new.lua"))()
         wait(1)
         g.notify("Info", "Try the command again, you did not have our Free Emotes GUI loaded.", 15)
         wait(1)
         while not CoreGui:FindFirstChild("FlamesEmoteGUI", true) do
            task.wait(0.1)
         end

         local gui = CoreGui:FindFirstChild("FlamesEmoteGUI", true)
         if gui and gui:IsA("ScreenGui") then
            local Frame_Find = gui:FindFirstChildOfClass("Frame")
            if Frame_Find and Frame_Find.Parent then
               Frame_Find.Visible = false
            end
         end
      end
   end

   g.mutesounds = function()
      for _,v in ipairs(Placed_Models:GetDescendants()) do
         if v:IsA("Sound") then
            local n = v.Name
            if n == "SoundDefault" or n == "Music" or n == "Airhorn" then
               v.Volume = 0
            elseif n == "Sound" and v.Parent and v.Parent.Parent and v.Parent.Parent.Name == "BoomBox" then
               v.Volume = 0
            end
         end
      end

      for _,p in ipairs(g.Players:GetPlayers()) do
         local c = p.Character or get_char(p, 3) -- new system usage (Player Instance, TimeOut).

         if c then
            for _,v in ipairs(c:GetDescendants()) do
               if v:IsA("Sound") then
                  if v.Name == "Sound" and v.Parent and v.Parent.Parent and v.Parent.Parent:IsA("Tool") and v.Parent.Parent.Name == "BoomBox" then
                     v.Volume = 0
                  end
               end
            end
         end
      end
   end

   g.unmutesounds = function()
      for _,v in ipairs(Placed_Models:GetDescendants()) do
         if v:IsA("Sound") then
            local n = v.Name
            if n == "SoundDefault" or n == "Music" or n == "Airhorn" then
               v.Volume = 1
            elseif n == "Sound" and v.Parent and v.Parent.Parent and v.Parent.Parent.Name == "BoomBox" then
               v.Volume = 0.5
            end
         end
      end

      for _,p in ipairs(g.Players:GetPlayers()) do
         local c = p.Character or get_char(p, 3) -- new system usage (Player Instance, TimeOut).

         if c then
            for _,v in ipairs(c:GetDescendants()) do
               if v:IsA("Sound") then
                  if v.Name == "Sound" and v.Parent and v.Parent.Parent and v.Parent.Parent:IsA("Tool") and v.Parent.Parent.Name == "BoomBox" then
                     v.Volume = 0.5
                  end
               end
            end
         end
      end
      notify("Success", "Unmuted all tools.", 5)
   end

   g.mute_all_tools = function(toggle)
      if toggle == true then
         if g.autosilence then
            return notify("Warning", "Tool muter is already enabled.", 5)
         end

         g.autosilence = true
         notify("Success", "Tool muter is enabled.", 5)

         g.Muting_All_Tool_Sounds_Task = task.spawn(function()
            while g.autosilence == true do
               wait(1)
               mutesounds()
            end
         end)
      elseif toggle == false then
         if not g.autosilence then
            return notify("Warning", "Tools muter is not enabled.", 5)
         end

         if g.Muting_All_Tool_Sounds_Task then
            task.cancel(g.Muting_All_Tool_Sounds_Task)
            g.Muting_All_Tool_Sounds_Task = nil
         end

         g.autosilence = false
         wait(1)
         if not g.autosilence then
            notify("Info", "Making all the tools Volume: 1...", 5)
            unmutesounds()
         else
            notify("Warning", "Tools muter is not disabled yet, hold on...", 3)
            repeat task.wait() until not g.autosilence or g.autosilence == false
            wait(1.5)
            if not g.autosilence then
               notify("Success", "Unmuting all Tools...", 5)
               wait(0.5)
               unmutesounds()
               wait(0.5)
               notify("Success", "Unmuted all Tools.", 5)
            end
         end
      else
         return 
      end
   end

   g.find_skin_body_colors_in_char = function(char)
      if not char then return end

      for _, v in ipairs(char:GetDescendants()) do
         if v:IsA("BodyColors") then
            return v
         end

         local name = v.Name:lower()
         if name:find("body") and name:find("color") then
            return v
         end
      end

      return nil
   end

   g.original_skintone = g.original_skintone or nil
   g.rainbow_skin = function(state)
      local lib = g.FlamesLibrary
      local name = "rainbow_skin"
      local char = g.Character or get_char(LocalPlayer, 10)
      if not char then return end
      local bodycolors = char and char:FindFirstChildOfClass("BodyColors")
      if not bodycolors then return end

      if state == true then
         if lib.is_alive(name) then
            return g.notify("Warning", "Flames Hub - Rainbow Skin is already enabled.", 5)
         end

         g.original_skintone = {
            HeadColor3 = bodycolors.HeadColor3,
            LeftArmColor3 = bodycolors.LeftArmColor3,
            RightArmColor3 = bodycolors.RightArmColor3,
            LeftLegColor3 = bodycolors.LeftLegColor3,
            RightLegColor3 = bodycolors.RightLegColor3,
            TorsoColor3 = bodycolors.TorsoColor3
         }

         g.notify("Success", "[ENABLED]: Flames Hub - Rainbow Skin.", 5)

         lib.spawn(name,"spawn",function()
            while true do
               for _, c in ipairs(colors) do
                  send_remote("skin_tone", c)
                  wait(.1)
               end
            end
         end)
      elseif state == false then
         if not lib.is_alive(name) then return end
         lib.disconnect(name)
         fw(0.2)
         if g.original_skintone then
            local old = g.original_skintone

            send_remote("skin_tone", old.HeadColor3)
            wait()
            send_remote("skin_tone", old.LeftArmColor3)
            wait()
            send_remote("skin_tone", old.RightArmColor3)
            wait()
            send_remote("skin_tone", old.LeftLegColor3)
            wait()
            send_remote("skin_tone", old.RightLegColor3)
            wait()
            send_remote("skin_tone", old.TorsoColor3)

            g.notify("Success", "Reset SkinTone back to your old SkinTone.", 3)
         end

         g.notify("Success", "[DISABLED]: Flames Hub - Rainbow Skin.", 5)
      end
   end

   g.two_tone_skin = function(state)
      local lib = g.FlamesLibrary
      local fw = lib.wait
      local name = "two_tone_skin"
      local char = g.Character or get_char(LocalPlayer, 10)
      if not char then return end
      local bodycolors = char:FindFirstChildOfClass("BodyColors")
      if not bodycolors then return end

      if state == true then
         if g.Two_Tone_Skin_Tone_Loop_Toggled then
            return g.notify("Warning", "Two Tone Skin is already enabled.", 5)
         end

         g.original_skintone = {
            HeadColor3 = bodycolors.HeadColor3,
            LeftArmColor3 = bodycolors.LeftArmColor3,
            RightArmColor3 = bodycolors.RightArmColor3,
            LeftLegColor3 = bodycolors.LeftLegColor3,
            RightLegColor3 = bodycolors.RightLegColor3,
            TorsoColor3 = bodycolors.TorsoColor3
         }

         local c1 = colors[math.random(1, #colors)]
         local c2 = colors[math.random(1, #colors)]
         while c2 == c1 do c2 = colors[math.random(1, #colors)] end
         g.notify("Success", "[ENABLED]: Two Tone Skin.", 5)
         g.Two_Tone_Skin_Tone_Loop_Toggled = true

         lib.spawn(name, "spawn", function()
            while g.Two_Tone_Skin_Tone_Loop_Toggled == true do
               fw(0.1)
               g.Send("skin_tone", c1)
               fw(0.1)
               g.Send("skin_tone", c2)
            end
         end)
      elseif state == false then
         if not g.Two_Tone_Skin_Tone_Loop_Toggled then return g.notify("WArning", "Two Tone Skin is not enabled.", 5) end
         lib.disconnect(name)
         fw(0.2)

         if g.original_skintone then
            local old = g.original_skintone
            g.Send("skin_tone", old.HeadColor3)
            wait()
            g.Send("skin_tone", old.LeftArmColor3)
            wait()
            g.Send("skin_tone", old.RightArmColor3)
            wait()
            g.Send("skin_tone", old.LeftLegColor3)
            wait()
            g.Send("skin_tone", old.RightLegColor3)
            wait()
            g.Send("skin_tone", old.TorsoColor3)
            g.notify("Success", "Reset skin tone back to original.", 3)
         end

         g.notify("Success", "[DISABLED]: Two Tone Skin.", 5)
      end
   end

   g.savePrefix = function(newPrefix)
      if writefile then
         local data = { prefix = newPrefix }
         writefile(fileName, HttpService:JSONEncode(data))
      end
   end

   local Amount_Input = 5

   g.set_fire_amount_FE = function(amount)
      amount = tonumber(amount)

      if not amount then
         Amount_Input = 5
         return
      end

      Amount_Input = amount
   end

   local Old_Name_From_Name_Spammer

   g.name_changer_premium = function(state)
      local lib = g.FlamesLibrary
      local name = "name_spammer"
      local words = {
         "root_access","packet_inject","xor_key","decrypting",
         "init_stealth","spoof_id","kernel_hook","bruteforce",
         "sys_reboot","net_breach","ghost_mode","backdoor_init"
      }

      if state == true then
         if lib.is_alive(name) then return end

         Old_Name_From_Name_Spammer = g.LocalPlayer:GetAttribute("roleplay_name") or "SERVER"

         local index = 1
         local count = #words

         lib.spawn(name,"spawn",function()
            while true do
               g.Send("roleplay_name", words[index])
               index = index + 1
               if index > count then index = 1 end
               fw(0)
            end
         end)
      elseif state == false then
         if not lib.is_alive(name) then return end

         lib.disconnect(name)

         fw(0.1)
         g.Send("roleplay_name", tostring(Old_Name_From_Name_Spammer))
         g.notify("Success", "Disabled Name Spammer, reverting name...", 3)
      end
   end

   function unsuspend_GUI_topbar()
      if g.unsuspend_chat_GUI then
         return notify("Warning", "Unsuspend TextChat GUI is already loaded.", 5)
      end

      notify("Warning", "Unsuspend TextChat GUI will be back soon.", 5)
      g.unsuspend_chat_GUI = true
      return 

      --[[g.unsuspend_chat_GUI = true

      local ScreenGui = Instance.new("ScreenGui")
      ScreenGui.Name = "TopBarUI_UNSUSPEND"
      ScreenGui.Parent = parent_gui
      ScreenGui.IgnoreGuiInset = true
      ScreenGui.ResetOnSpawn = false

      local UnsuspendTxt_Chat = Instance.new("TextButton")
      UnsuspendTxt_Chat.Name = "UnsuspendTextChat"
      UnsuspendTxt_Chat.Parent = ScreenGui
      UnsuspendTxt_Chat.Size = UDim2.new(0, 100, 0, 30)
      UnsuspendTxt_Chat.Position = UDim2.new(1, -350, 0, 10)
      UnsuspendTxt_Chat.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
      UnsuspendTxt_Chat.BorderSizePixel = 0
      UnsuspendTxt_Chat.TextColor3 = Color3.fromRGB(0, 255, 0)
      UnsuspendTxt_Chat.TextScaled = true
      UnsuspendTxt_Chat.Font = Enum.Font.SourceSansBold
      UnsuspendTxt_Chat.Text = "Unsuspend Chat"

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 20)
      UICorner.Parent = UnsuspendTxt_Chat

      local UIContainer = Instance.new("Frame")
      UIContainer.Name = "UIContainer"
      UIContainer.Parent = ScreenGui
      UIContainer.Size = UDim2.new(0, 1105, 0, 40)
      UIContainer.Position = UDim2.new(0.5, -550, 0, 0)
      UIContainer.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
      UIContainer.BackgroundTransparency = 0.2
      UIContainer.BorderSizePixel = 0
      UIContainer.Visible = false

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 8)
      UICorner.Parent = UIContainer

      local UIStroke = Instance.new("UIStroke")
      UIStroke.Color = Color3.fromRGB(0, 0, 0)
      UIStroke.Thickness = 1
      UIStroke.Parent = UIContainer

      local CloseButton = Instance.new("TextButton")
      CloseButton.Name = "CloseButton"
      CloseButton.Parent = ScreenGui
      CloseButton.Size = UDim2.new(0, 30, 0, 30)
      CloseButton.Position = UDim2.new(1, -40, 0, 5)
      CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
      CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
      CloseButton.Font = Enum.Font.GothamBold
      CloseButton.TextSize = 16
      CloseButton.Text = "X"

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 10)
      UICorner.Parent = CloseButton

      CloseButton.MouseButton1Click:Connect(function()
         if ScreenGui and ScreenGui:IsA("ScreenGui") then
            ScreenGui.Enabled = false
         end
         g.unsuspend_chat_GUI = false
      end)

      local Text_Chat_Service = cloneref and cloneref(game:GetService("TextChatService")) or game:GetService("TextChatService")

      UnsuspendTxt_Chat.MouseButton1Click:Connect(function()
         if not rep_signal then
            return notify("Error", "Your executor does not support 'replicatesignal'!", 6)
         end

         local ok, err = pcall(function()
            rep_signal(Text_Chat_Service.UpdateChatTimeout, g.LocalPlayer.UserId, 0, 10)
         end)

         if not ok then
            return notify("Error", "Failed to unsuspend TextChat: " .. tostring(err), 8)
         end

         notify("Success", "Unsuspended TextChat, you may now use your Chat like normal.", 6)
      end)--]]
   end

   g.unsuspend_chat_GUI = true

   print("Unsuspend TextChat has been initialized.")

   g.spectate_plr_without_distance_limits = function(plr)
      function spectatePlayer(targetPlayer)
         if not targetPlayer then return end

         spectateTarget = targetPlayer
         spectateSubject = nil
         originalIO.disconnectSpectateConns()

         local function setCamToCharacter(character)
            if spectateTarget ~= targetPlayer or not character then return end

            local hum = getPlrHum(character) or getHum(character, 5)
            local subj = hum or getRoot(character)
            if not subj then return end

            spectateSubject = subj
            originalIO.ensureCam()
            originalIO.hookCameraGuard()
         end

         setCamToCharacter(targetPlayer.Character)

         spectateConns.char = g.FlamesLibrary.connect("spectate_char", targetPlayer.CharacterAdded:Connect(function(character)
            if spectateTarget ~= targetPlayer then return end
            setCamToCharacter(character)
         end))

         spectateConns.leave = NAlib.connect("spectate_leave", Players.PlayerRemoving:Connect(function(player)
            if player == targetPlayer and spectateTarget == targetPlayer then
               cleanup(true)
               DebugNotif("Player left - camera reset")
            end
         end))

         spectateConns.loop = NAlib.connect("spectate_loop", RunService.RenderStepped:Connect(function()
            if spectateTarget ~= targetPlayer then return end

            local char = targetPlayer.Character
            if not char or not char.Parent then return end

            if not spectateSubject or spectateSubject.Parent ~= char then
               setCamToCharacter(char)
            else
               originalIO.ensureCam()
            end
         end))
      end

      spectatePlayer(plr)
   end

   print("Stop Rainbow Skin Function init.")

   g.initCooldownHandler = function()
      local CooldownTime = 5
      local Chat = Enum.CoreGuiType.Chat

      g.CooldownActive = g.CooldownActive or false
      g.HashtagCount = g.HashtagCount or 0

      local function startCooldown(duration)
         if g.CooldownActive then
            return notify("Warning", "Your TextChat cooldown is still currently active.", 6)
         end
         g.CooldownActive = true
         notify("Info", "Cooldown started for: " .. duration .. "s.", 8)

         task.delay(duration, function()
            g.CooldownActive = false
            g.HashtagCount = 0
            pcall(function()
               StarterGui:SetCoreGuiEnabled(Chat, true)
            end)
            notify("Success", "Chat re-enabled, cooldown ended.", 7)
         end)
      end

      local function cooldownListener(sender, msg)
         if sender ~= Players.LocalPlayer then return end
         local text = msg.Text
         if text and text:match("^#+$") then
            g.HashtagCount = (g.HashtagCount or 0) + 1
            if g.HashtagCount >= 4 then
               pcall(function()
                  StarterGui:SetCoreGuiEnabled(Chat, false)
               end)
               startCooldown(CooldownTime)
               notify("Warning", "Too many filtered messages, chat disabled temporarily (10 seconds).", 10)
            end
         end
      end

      table.insert(g.ChatMessageHooks, cooldownListener)
   end

   if g.ChatMetaMethodHookApplied then
      initCooldownHandler()
   else
      notify("Info", "Skipping cooldown handler — hook not applied.", 3)
   end

   print("cooldown handler is good.")

   local View_Outfit_State_Toggle = g.LocalPlayer:GetAttribute("hide_view_outfit") or true
   fw(0.2)
   local function push_stealer_state(state)
      if not g.ws_main_reactor_connector then return end
      g.ws_main_reactor_connector:Send(HttpService:JSONEncode{
         type = "anti_stealer_state",
         secret = "12f1f56de573e18df02f9da819ec2e6bd5ffb8141eae682187d51ea37392472f",
         user = tostring(g.LocalPlayer.Name),
         state = state
      })
   end

   g.anti_outfit_copier = function(toggle)
      if toggle == true then
         if g.anti_outfit_stealer then
            return notify("Error", "Anti Outfit Stealer is already enabled!", 5)
         end
         if g.AntiFitStealerConn then
            return notify("Error", "Anti Outfit Stealer is already enabled! [connection]", 5)
         end

         notify("Success", "Flames Hub | Anti Outfit Stealer is now active.", 7)

         local lib = g.FlamesLibrary
         g.AntiFitStealerConn = nil
         g.ToggleAntiFit_Stealer = function(state)
            if not state then
               g.anti_outfit_stealer = false
               if g.AntiFitStealerConn then
                  g.AntiFitStealerConn:Disconnect()
                  g.AntiFitStealerConn = nil
               end

               local hide_outfit_toggle = g.LocalPlayer:GetAttribute("hide_view_outfit")
               if hide_outfit_toggle and hide_outfit_toggle == false then
                  g.Send("hide_view_outfit", true)
                  notify("Success", "hide_view_outfit setting changed, reverted change (keep it on).", 3)
               end

               push_stealer_state(false)
               return
            else
               g.anti_outfit_stealer = true
               push_stealer_state(true)
            end

            local last_check = 0
            g.AntiFitStealerConn = g.RunService.Heartbeat:Connect(function()
               local now = tick()
               if now - last_check < 0.4 then return end
               last_check = now
               
               local hide_outfit_toggle = g.LocalPlayer:GetAttribute("hide_view_outfit")
               if hide_outfit_toggle and hide_outfit_toggle == false then
                  g.Send("hide_view_outfit", true)
                  notify("Success", "hide_view_outfit setting changed, reverted change (keep it on).", 3)
               end
            end)
         end

         fw(0.1)
         g.ToggleAntiFit_Stealer(true)
      elseif toggle == false then
         if not g.anti_outfit_stealer then
            return notify("Error", "Anti Outfit Copier is not enabled!", 5)
         end

         g.anti_outfit_stealer = false
         if g.AntiFitStealerConn then
            g.AntiFitStealerConn:Disconnect()
            g.AntiFitStealerConn = nil
         end

         g.ToggleAntiFit_Stealer(false)
         notify("Success", "Disabled Anti Outfit Stealer.", 5)
      else
         return
      end
   end

   print("anti outfit stealer is good.")
   local upvalues_func_main = getupvalue or getupvalues or debug.getupvalues
   local get_proto_func = getproto or debug.getproto or getprotos
   g.hook_meta_main = g.hook_meta_main or function(obj, metamethod, func)
      if not getrawmetatable then return end
      local old = getrawmetatable and getrawmetatable(obj)

      if hookfunction then
         return hookfunction(old[metamethod],func)
      else
         local oldmetamethod = old[metamethod]
         if makewriteable then
            makewriteable(old)
         end
         old[metamethod] = func
         if makereadonly then
            makereadonly(old)
         end
         return oldmetamethod
      end
   end

   g.find_messages_modulescript = function()
      if g.Messages_Module_Found_Loc then
         return g.Messages_Module_Found_Loc
      end

      local reps = g.ReplicatedStorage or safe_wrapper("ReplicatedStorage")
      if not reps then return nil end
      local found = reps:FindFirstChild("Messages", true)
      if found and found:IsA("ModuleScript") then
         g.Messages_Module_Found_Loc = found
      end

      return g.Messages_Module_Found_Loc
   end

   g.find_UI_modulescript = function()
      if g.UI_Module_Main then
         return g.UI_Module_Main
      end

      local reps = g.ReplicatedStorage or safe_wrapper("ReplicatedStorage")
      if not reps then return nil end

      local found = reps:FindFirstChild("UI", true)
      if found and found:IsA("ModuleScript") then
         g.UI_Module_Main = found
      end

      return g.UI_Module_Main
   end

   g.find_RateLimiter_modulescript = function()
      if g.RateLimiter_Module_Main then
         return g.RateLimiter_Module_Main
      end

      local reps = g.ReplicatedStorage or safe_wrapper("ReplicatedStorage")
      if not reps then return nil end

      local found = reps:FindFirstChild("RateLimiter", true)
      if found and found:IsA("ModuleScript") then
         g.RateLimiter_Module_Main = found
      end

      return g.RateLimiter_Module_Main
   end

   if not g.RateLimiter_Bypass_Applied then
      if get_proto_func and upvalues_func_main and require then
         local ok, err = pcall(function()
            local message_module = g.Messages_Module_Found_Loc
               and require(g.Messages_Module_Found_Loc)
               or require(find_messages_modulescript())
            local rate_limiter = upvalues_func_main(get_proto_func(message_module.loaded, 4, true)[1], 5)
            if typeof(rate_limiter) == "table" and rate_limiter.is_limited then
               rate_limiter.is_limited = function() return false end
               g.RateLimiter_Bypass_Applied = true
               g.RateLimiter_Bypass_Applied_Method_2 = true
            end
         end)
         if not ok then
            warn("RateLimiter bypass method failed unexpectedly.")
         end
      end
   end

   print("ratelimit bypass applied.")

   g.spam_sign_text = function(toggle)
      local Character = g.Character
      local PlacedModels = Workspace:WaitForChild("PlacedModels")
      local random_words = {
         "yo","wsg bro","aye","lit","fire"
      }

      local function find_tool_partial(toolName)
         if not toolName then return nil end
         local query = toolName:lower()

         for _, v in ipairs(PlacedModels:GetChildren()) do
            if v:IsA("Model") and v.Name:lower() == query then
               local ownerAttr = v:GetAttribute("owner_id")
               if ownerAttr and tostring(ownerAttr) == tostring(LocalPlayer.UserId) then
                  return v
               end
            end
         end

         for _, v in ipairs(Character:GetChildren()) do
            if v.Name:lower() == query then
               return v
            end
         end

         return nil
      end

      if toggle == true then
         if g.ToolChanger_FE then return notify("Warning", "Sign Spammer is already enabled!", 5) end
         g.ToolChanger_FE = true

         g.Sign_ChangeText_Fast_Loop_Task = task.spawn(function()
            while g.ToolChanger_FE == true do
               local tool = find_tool_partial("sign")
               if not tool then
                  g.Send("get_tool", "Sign")
                  fw(0.1)
               else
                  for _, word in ipairs(random_words) do
                     if not g.ToolChanger_FE then break end
                     g.Send("change_sign", tool, tostring(word))
                     fw(0)
                  end
               end
               fw(0.1)
            end
         end)
      elseif toggle == false then
         if g.Sign_ChangeText_Fast_Loop_Task then
            task.cancel(g.Sign_ChangeText_Fast_Loop_Task)
            g.Sign_ChangeText_Fast_Loop_Task = nil
         end
         g.ToolChanger_FE = false
      else
         return 
      end
   end

   if not g.player_esp_core then
      g.player_esp_core = true
      local players = g.Players or game:GetService("Players")
      local localplayer = g.LocalPlayer or players.LocalPlayer
      local esp_objects = {}
      g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled = false

      local function wait_character(plr)
         local character = plr.Character
         while g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled and plr.Parent and (not character or not character.Parent) do
            character = plr.Character
            g.heartbeat_wait_function(6)
         end
         return character
      end

      local function remove_esp(plr)
         if esp_objects[plr] then
            esp_objects[plr]:Destroy()
            esp_objects[plr] = nil
         end
      end

      local function apply_esp(plr)
         if not g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled then return end
         if plr == localplayer then return end
         task.spawn(function()
            local character = wait_character(plr)
            if not g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled or not character then return end
            remove_esp(plr)
            local highlight = Instance.new("Highlight")
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Adornee = character
            highlight.Parent = character
            esp_objects[plr] = highlight
         end)
      end

      local function track_player(plr)
         apply_esp(plr)
         FlamesLibrary.connect("esp_char_" .. tostring(plr.UserId), plr.CharacterAdded:Connect(function(new_char)
            if plr == localplayer then return end
            while g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled and new_char and not new_char.Parent do
               task.wait()
            end
            apply_esp(plr)
         end))
      end

      local function untrack_player(plr)
         remove_esp(plr)
         FlamesLibrary.disconnect("esp_char_" .. tostring(plr.UserId))
      end

      g.enable_player_esp = function()
         if g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled then
            return g.notify("Warning", "Flames Hub Player ESP is already enabled.", 5)
         end
         g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled = true
         for _, plr in ipairs(players:GetPlayers()) do
            track_player(plr)
         end
         FlamesLibrary.connect("esp_playeradded", players.PlayerAdded:Connect(track_player))
         FlamesLibrary.connect("esp_playerremoving", players.PlayerRemoving:Connect(untrack_player))
      end

      g.disable_player_esp = function()
         if not g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled then
            return g.notify("Warning", "Flames Hub Player ESP is not enabled.", 6)
         end
         g.Flames_Hub_Player_ESP_Core_Has_Been_Enabled = false
         for plr in pairs(esp_objects) do
            remove_esp(plr)
         end
         FlamesLibrary.disconnect("esp_playeradded")
         FlamesLibrary.disconnect("esp_playerremoving")
      end
   end

   if Drawing and not g.tracer_core_initialized then
      g.tracer_core_initialized = true

      local players = g.Players or game:GetService("Players")
      local runservice = g.RunService or game:GetService("RunService")
      local camera = workspace.CurrentCamera
      local localplayer = g.LocalPlayer or g.Players.LocalPlayer or players.LocalPlayer
      local tracer_objects = {}
      g.tracer_esp_currently_running_flag_Flames_Hub = false
      if g.disable_tracers and typeof(g.disable_tracers) == "function" then
         pcall(function() g.disable_tracers() end)
      end
      local function remove_tracer(plr)
         if tracer_objects[plr] then
            tracer_objects[plr]:Remove()
            tracer_objects[plr] = nil
         end
      end

      local function create_tracer(plr)
         if plr == localplayer then return end
         while g.tracer_esp_currently_running_flag_Flames_Hub and not plr.Parent do
            task.wait()
         end
         if not g.tracer_esp_currently_running_flag_Flames_Hub then return end
         local line = Drawing.new("Line")
         line.Thickness = 1
         line.Transparency = 1
         line.Visible = false
         tracer_objects[plr] = line
      end

      local function update_tracers()
         if not g.tracer_esp_currently_running_flag_Flames_Hub then
            pcall(function() g.disable_tracers() end)
            return 
         end
         local view = camera.ViewportSize
         for plr, line in pairs(tracer_objects) do
            local character = plr.Character or get_char(plr, 1)
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if root then
               local pos, onscreen = camera:WorldToViewportPoint(root.Position)
               if onscreen then
                  line.Visible = true
                  line.From = Vector2.new(view.X / 2, view.Y)
                  line.To = Vector2.new(pos.X, pos.Y)
               else
                  line.Visible = false
               end
            else
               line.Visible = false
            end
         end
      end

      g.enable_tracers = function()
         if g.tracer_esp_currently_running_flag_Flames_Hub then
            return g.notify("Warning", "Tracer ESP is already enabled!", 5)
         end
         g.tracer_esp_currently_running_flag_Flames_Hub = true
         for _, plr in ipairs(players:GetPlayers()) do
            create_tracer(plr)
         end
         FlamesLibrary.connect("tracer_render", runservice.RenderStepped:Connect(update_tracers))
         FlamesLibrary.connect("tracer_playeradded", players.PlayerAdded:Connect(create_tracer))
         FlamesLibrary.connect("tracer_playerremoving", players.PlayerRemoving:Connect(remove_tracer))
      end

      g.disable_tracers = function()
         if not g.tracer_esp_currently_running_flag_Flames_Hub then
            return g.notify("Warning", "Tracer ESP is not enabled!", 5)
         end
         g.tracer_esp_currently_running_flag_Flames_Hub = false
         for plr in pairs(tracer_objects) do
            remove_tracer(plr)
         end
         FlamesLibrary.disconnect("tracer_render")
         FlamesLibrary.disconnect("tracer_playeradded")
         FlamesLibrary.disconnect("tracer_playerremoving")
      end
   end
   wait(0.25)
   if g.RateLimiter_Bypass_Applied then
      if g.RateLimiter_Bypass_Applied_Method_1 then
         notify("Success", "RateLimiter bypass applied with method 1.", 10)
      elseif g.RateLimiter_Bypass_Applied_Method_2 then
         notify("Success", "RateLimiter bypass applied with method 2.", 10)
      elseif g.RateLimiter_Bypass_Applied_Method_3 then
         notify("Success", "RateLimiter bypass applied with method 3.", 10)
      else
         notify("Warning", "We we're unable to apply any RateLimiter bypass.", 10)
      end
   else
      notify("Warning", "Not sure if RateLimiter bypass was applied or not.")
   end

   g.WalkFlingWhitelist = g.WalkFlingWhitelist or {}
   g.walkflinging = g.walkflinging or false
   g.WalkFlingConnections = g.WalkFlingConnections or {}
   g.TouchingWhitelisted = g.TouchingWhitelisted or {}
   g.AddToWalkFlingWhitelist = g.AddToWalkFlingWhitelist or function(user)
      local userid = g.ToUserId(user)
      if not userid then
         return notify("Warning", "That player is invalid or has left the game.", 5)
      end
      if g.WalkFlingWhitelist[userid] then
         return notify("Warning", "That player is already in the WalkFling Whitelist.", 5)
      end
      g.WalkFlingWhitelist[userid] = true
      return notify("Success", "Added to WalkFling Whitelist.", 5)
   end

   g.RemoveFromWalkFlingWhitelist = g.RemoveFromWalkFlingWhitelist or function(user)
      local userid = g.ToUserId(user)
      if not userid then
         return notify("Warning", "That player is invalid or has left the game.", 5)
      end
      if not g.WalkFlingWhitelist[userid] then
         return notify("Warning", "That player is not in the WalkFling Whitelist.", 5)
      end
      g.WalkFlingWhitelist[userid] = nil
      return notify("Success", "Removed from WalkFling Whitelist.", 5)
   end

   g.is_whitelisted = g.is_whitelisted or function(plr)
      if not plr then return false end
      return g.WalkFlingWhitelist[plr.UserId] == true
   end

   g.stop_walkfling = function()
      if not g.walkflinging then
         return notify("Error", "Flames Hub | WalkFling-V3.5 is not enabled.", 5)
      end

      g.walkflinging = false
      g.TouchingWhitelisted = {}
      g.FlamesLibrary.disconnect("walkflinger")

      for _, conn in pairs(g.WalkFlingConnections) do
         conn:Disconnect()
      end
      g.WalkFlingConnections = {}

      if g.WalkFlingRespawnConn then
         g.WalkFlingRespawnConn:Disconnect()
         g.WalkFlingRespawnConn = nil
      end

      if g.Noclip_Enabled then
         g.Toggleable_Noclip(false)
      end

      local root = g.HumanoidRootPart
      if root then
         root.Velocity = Vector3.zero
      end

      local hum = g.Humanoid or get_human(LocalPlayer or game.Players.LocalPlayer) or g.Character:FindFirstChildOfClass("Humanoid")
      if hum then
         hum.PlatformStand = false
         hum:ChangeState(Enum.HumanoidStateType.GettingUp)
      end

      notify("Success", "Flames Hub | WalkFling-V3.5 has been stopped/disabled.", 5)
   end

   g.start_walkfling = function()
      if g.walkflinging then
         return notify("Warning", "Flames Hub | WalkFling-V3.5 is already enabled!", 5)
      end

      g.walkflinging = true
      g.TouchingWhitelisted = {}
      if not g.Noclip_Enabled then g.Toggleable_Noclip(true) end
      notify("Success", "Flames Hub | WalkFling-V3.5 is now enabled.", 5)

      local lp = g.LocalPlayer or Players.LocalPlayer
      local function connect_touch_fling(character)
         for _, conn in pairs(g.WalkFlingConnections) do conn:Disconnect() end
         g.WalkFlingConnections = {}
         g.TouchingWhitelisted = {}

         for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then

               local touchConn = part.Touched:Connect(function(hit)
                  if not g.walkflinging then return end

                  local hit_char = hit.Parent
                  while hit_char and not Players:GetPlayerFromCharacter(hit_char) and hit_char.Parent ~= workspace do
                     hit_char = hit_char.Parent
                  end

                  local hit_player = Players:GetPlayerFromCharacter(hit_char)
                  if not hit_player or hit_player == lp then return end

                  if g.is_whitelisted(hit_player) then
                     g.TouchingWhitelisted[hit_player.UserId] = true
                     return
                  end

                  if next(g.TouchingWhitelisted) then return end

                  local hit_root = hit_char:FindFirstChild("HumanoidRootPart")
                  if not hit_root then return end

                  local root = g.HumanoidRootPart
                  local v = root and root.CFrame.LookVector or Vector3.zero
                  local power = 10000

                  hit_root.Velocity = v * power + Vector3.new(0, power, 0)
                  RunService.RenderStepped:Wait()
                  if hit_root then hit_root.Velocity = v * power end
                  RunService.RenderStepped:Wait()
                  if hit_root then hit_root.Velocity = v * power + Vector3.new(0, 0.1, 0) end
               end)

               local untouchConn = part.TouchEnded:Connect(function(hit)
                  local hit_char = hit.Parent
                  while hit_char and not Players:GetPlayerFromCharacter(hit_char) and hit_char.Parent ~= workspace do
                     hit_char = hit_char.Parent
                  end
                  local hit_player = Players:GetPlayerFromCharacter(hit_char)
                  if hit_player and g.is_whitelisted(hit_player) then
                     g.TouchingWhitelisted[hit_player.UserId] = nil
                  end
               end)

               table.insert(g.WalkFlingConnections, touchConn)
               table.insert(g.WalkFlingConnections, untouchConn)
            end
         end
      end

      local char = g.Character or get_char(lp, 10)
      if char then connect_touch_fling(char) end
      if g.WalkFlingRespawnConn then
         g.WalkFlingRespawnConn:Disconnect()
         g.WalkFlingRespawnConn = nil
      end
      wait(0.25)
      g.WalkFlingRespawnConn = lp.CharacterAdded:Connect(function(new_char)
         if g.walkflinging then
            connect_touch_fling(new_char)
         end
      end)

      g.FlamesLibrary.disconnect("walkflinger")
      g.FlamesLibrary.connect("walkflinger", RunService.Heartbeat:Connect(function()
         if not g.walkflinging then return end
         local m = g.Character or get_char(lp, 10)
         local r = m and (g.HumanoidRootPart or m:FindFirstChild("HumanoidRootPart"))
         if not r then return end
         local v = r.Velocity
         r.Velocity = v * 10000 + Vector3.new(0, 10000, 0)

         RunService.RenderStepped:Wait()
         if r then r.Velocity = v end
         RunService.RenderStepped:Wait()
         if r then r.Velocity = v + Vector3.new(0, 0.1, 0) end
      end))
   end

   g.StartWalkFling = g.start_walkfling
   g.StopWalkFling = g.stop_walkfling
   print("start walkfling local function is good.")
   g.getcharsize = function()
      local hum = g.Humanoid
      if not hum then return 5,2 end
      local d = hum:GetAppliedDescription()
      local h = 5 * (d.HeightScale or 1)
      local w = 2 * (d.WidthScale or 1)
      return h,w
   end

   g.autospinspeed = function(base)
      local h,w = getcharsize()
      return base / h
   end

   g.change_spin_speed = function(speed)
      if typeof(speed) ~= "number" then
         if speed then
            return notify("Error", tostring(speed).." isn't a number! Input a number.", 5)
         else
            return notify("Error", "That wasn't a number! Input a number.", 5)
         end
      end
      if g.walkflinging then
         return notify("Error", "Turn off walkfling first for this to work properly.", 10)
      end

      for _, v in ipairs(g.HumanoidRootPart:GetChildren()) do
         if v.Name == "FlamesHub_Spin" then
            v.AngularVelocity = Vector3.new(0, speed, 0)
            notify("Success", "New spin speed: "..tostring(speed), 5)
         end
      end
   end

   g.LockHouse_LastState = g.LockHouse_LastState or {}
   g.LockHomeLoop = g.LockHomeLoop or false
   print("lock home loop g is good.")
   g.get_plot_of_player = function(player)
      if not player then 
         return nil, "No player provided" 
      end

      local plotList = PlotMarker and PlotMarker.class and PlotMarker.class.objects
      if type(plotList) ~= "table" then
         return nil, "Plots not available"
      end

      for _, plot in pairs(plotList) do
         if plot 
         and plot.states 
         and plot.states.owner
         and typeof(plot.states.owner.get) == "function"
         and plot.instance
         then
            local ok, owner = pcall(function()
               return plot.states.owner.get()
            end)

            if ok and owner == player then
               return plot.instance, plot
            end
         end
      end

      return nil, "Player has no plot"
   end

   print("get plot of plr is good.")

   g.toggle_house_lock = function(player)
      local plotInstance = select(1, get_plot_of_player(player))
      if not plotInstance then return end

      g.Send("lock_home", plotInstance)
   end

   print("toggle house lock is good.")

   g.is_home_locked = function(player)
      local plotInstance, plotObject = get_plot_of_player(player)
      if not plotObject then
         return nil, "Player has no plot"
      end

      if not plotObject.states 
      or not plotObject.states.locked 
      or typeof(plotObject.states.locked.get) ~= "function"
      then
         return nil, "Locked state unavailable"
      end

      local ok, locked = pcall(function()
         return plotObject.states.locked.get()
      end)

      if not ok then
         return nil, "Failed to read lock state"
      end

      return locked
   end

   print("is home locked function is good.")

   g.LockHouse_LastState = g.LockHouse_LastState or {}
   g.LockHomeLoop = g.LockHomeLoop or false
   g.LockHomeToken = g.LockHomeToken or 0
   g.keep_home_locked = function(toggle)
      if toggle then
         if g.LockHomeLoop then
            return notify("Warning", "Lock Home loop is already enabled.", 5)
         end

         g.LockHomeLoop = true
         g.LockHomeToken = (g.LockHomeToken or 0) + 1
         local myToken = g.LockHomeToken

         notify("Success", "Lock Home loop is now enabled.", 5)

         task.spawn(function()
            while g.LockHomeLoop and myToken == g.LockHomeToken do
               fw(0.2)

               local plotList = PlotMarker and PlotMarker.class and PlotMarker.class.objects
               if plotList then
                  for _, plot in pairs(plotList) do
                     if myToken ~= g.LockHomeToken then
                        return
                     end

                     local okOwner, owner = pcall(function()
                        return plot.states.owner.get()
                     end)

                     if okOwner and owner == g.LocalPlayer then
                        local id = plot.instance:GetDebugId()

                        if g.LockHouse_LastState[id] == nil then
                           g.LockHouse_LastState[id] = plot.states.locked.get()
                        end

                        local locked = plot.states.locked.get()
                        local last = g.LockHouse_LastState[id]

                        if locked == false and last == true then
                           toggle_house_lock(g.LocalPlayer)
                           g.LockHouse_LastState[id] = true
                        else
                           g.LockHouse_LastState[id] = locked
                        end
                     end
                  end
               end
            end
         end)
      else
         if not g.LockHomeLoop then
            return notify("Warning", "Lock Home loop is not enabled.", 5)
         end

         g.LockHomeLoop = false
         g.LockHomeToken = (g.LockHomeToken or 0) + 1
         table.clear(g.LockHouse_LastState)

         notify("Success", "Lock Home loop is now disabled.", 5)
      end
   end

   print("keep home locked is good.")

   g.spin_plr = function(toggle, speed)
      local hrp = g.HumanoidRootPart or get_root(g.LocalPlayer)

      if toggle == true then
         if g.already_spinning_localplr then
            return notify("Warning", "You are already spinning, changing speed.", 5)
         end
         if typeof(speed) ~= "number" then
            return notify("Error", "That wasn't a number! Input a number.", 5)
         end
         if g.walkflinging then
            return notify("Error", "Turn off walkfling first for this to work properly.", 10)
         end

         g.already_spinning_localplr = true
         for _, v in pairs(hrp:GetChildren()) do
            if v.Name == "FlamesHub_Spin" then
               v:Destroy()
            end
         end
         wait(.1)
         local Spin = Instance.new("BodyAngularVelocity")
         Spin.Name = "FlamesHub_Spin"
         Spin.MaxTorque = Vector3.new(0, math.huge, 0)
         Spin.AngularVelocity = Vector3.new(0, autospinspeed(speed), 0)
         Spin.Parent = hrp
      elseif toggle == false then
         if not g.already_spinning_localplr then
            return notify("Error", "You are not using Spin.", 5)
         end

         for _, v in ipairs(hrp:GetChildren()) do
            if v:IsA("BodyAngularVelocity") and v.Name == "FlamesHub_Spin" then
               v:Destroy()
            end
         end
         g.already_spinning_localplr = false
      else
         return
      end
   end

   print("spin plr toggle func is good.")

   g.OrbitConnections = g.OrbitConnections or {}
   g.Is_Orbiting = g.Is_Orbiting or false
   g.OrbitSpeed = g.OrbitSpeed or 1

   print("orbit g conns and values are good.")

   g.set_orbit_speed = function(new_speed)
      if type(new_speed) == "number" then
         g.OrbitSpeed = new_speed
         notify("Info", "Orbit speed set to " .. tostring(new_speed), 4)
      else
         notify("Error", "Invalid speed value.", 4)
      end
   end

   print("set orbit speed is good.")

   g.stop_orbit = function()
      if not g.Is_Orbiting then
         return notify("Warning", "You're not orbiting anyone.", 5)
      end
      for _, conn in pairs(g.OrbitConnections) do
         if typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
         end
      end
      table.clear(g.OrbitConnections)
      g.Is_Orbiting = false
      notify("Success", "Stopped orbiting Player.", 4)
   end

   print("stop orbit func is good.")

   g.start_orbit_plr = function(target, speed, distance)
      if g.Is_Orbiting then
         return notify("Warning", "Already orbiting someone!", 5)
      end
      if not target or not target.Character then
         return notify("Error", "Target invalid or they're missing their Character.", 5)
      end

      local RunService = g.RunService or cloneref and cloneref(game:GetService("RunService")) or game:GetService("RunService")
      local target_char = target.Character or g.get_char(target)
      local root = g.HumanoidRootPart or get_root(LocalPlayer)
      local humanoid = g.Humanoid or get_human(LocalPlayer) or g.Character:FindFirstChildOfClass("Humanoid")
      local targetRoot = target_char:FindFirstChild("HumanoidRootPart") or get_root(target)
      if not root or not humanoid or not targetRoot then
         g.Is_Orbiting = false
         return notify("Error", "Missing root or humanoid, cannot orbit this player.", 5)
      end

      speed = tonumber(speed) or g.OrbitSpeed or 1
      distance = tonumber(distance) or 3
      g.OrbitSpeed = speed
      g.Is_Orbiting = true

      local rotation = 0

      g.OrbitConnections.Heartbeat = RunService.Heartbeat:Connect(function()
         pcall(function()
            if not g.Is_Orbiting or not target_char or not targetRoot or not root then
               return 
            end
            rotation = rotation + (g.OrbitSpeed or 0)
            root.CFrame = CFrame.new(targetRoot.Position) * CFrame.Angles(0, math.rad(rotation), 0) * CFrame.new(distance, 0, 0)
         end)
      end)

      g.OrbitConnections.RenderStepped = RunService.RenderStepped:Connect(function()
         pcall(function()
            if root and targetRoot then
               root.CFrame = CFrame.new(root.Position, targetRoot.Position)
            end
         end)
      end)

      g.OrbitConnections.Died = humanoid.Died:Connect(stop_orbit)
      g.OrbitConnections.Seated = humanoid.Seated:Connect(function(isSeated)
         if isSeated then stop_orbit() end
      end)

      notify("Success", "Started orbiting: "..tostring(target)..", with speed: "..tostring(speed)..", and with distance: "..tostring(distance), 5)
   end

   print("start orbit plr func is good.")

   g.water_skie_trailer = function(Bool, Vehicle)
      if not Vehicle then
         return notify("Warning", "You do not have a Vehicle spawned!", 5)
      end

      local HasTrailer = Vehicle:FindFirstChild("WaterSkies")

      if Bool == true then
         if HasTrailer then
            return notify("Error", "You already have the WaterSkies trailer.", 5)
         else
            g.Get("add_trailer", Vehicle, "WaterSkies")
         end
      elseif Bool == false then
         if HasTrailer then
            g.Get("add_trailer", Vehicle, "WaterSkies")
         else
            return notify("Warning", "You do not have the WaterSkies trailer to take it off!", 5)
         end
      else
         return notify("Error", "Invalid toggle value (expected: true/false).", 5)
      end
   end

   print("water skies function good")

   g.FlyEnabled = g.FlyEnabled or false
   g.FlySpeed = g.FlySpeed or 1
   g.QEfly = (g.QEfly == nil) and true or g.QEfly
   g.flyKeyDown = g.flyKeyDown or nil
   g.flyKeyUp = g.flyKeyUp or nil
   g.mobileFlyConn = g.mobileFlyConn or nil
   g.pcFlyConn = g.pcFlyConn or nil
   local UIS = g.UserInputService
   local RunService = g.RunService

   print("checked global environment flying stuff.")

   g.EnableFly = function(state, speed, vfly)
      if g.FlyEnabled then
         if speed and tonumber(speed) then
            g.FlySpeed = tonumber(speed)
            return notify("Success", "Fly speed updated to: " .. tostring(g.FlySpeed), 4)
         end
         return notify("Warning", "Fly is already enabled! Provide a speed to update it.", 5)
      end

      local plr = g.LocalPlayer or g.Players.LocalPlayer or game.Players.LocalPlayer
      local char = g.get_char(plr) or g.Character or plr.Character
      local hrp = g.HumanoidRootPart or char:FindFirstChild("HumanoidRootPart") or get_root(plr)
      local hum = g.Humanoid or char:FindFirstChildOfClass("Humanoid") or get_human(plr)
      local cam = workspace.CurrentCamera

      if not hrp or not hum then
         return g.notify("Error", "Character is not ready or Humanoid doesn't exist.", 6)
      end

      if not state then
         DisableFly()
         return
      end

      if speed and tonumber(speed) then
         g.FlySpeed = tonumber(speed)
      end

      g.FlyEnabled = true

      if g.flyKeyDown then g.flyKeyDown:Disconnect() g.flyKeyDown = nil end
      if g.flyKeyUp then g.flyKeyUp:Disconnect() g.flyKeyUp = nil end
      if g.pcFlyConn then g.pcFlyConn:Disconnect() g.pcFlyConn = nil end
      if g.mobileFlyConn then g.mobileFlyConn:Disconnect() g.mobileFlyConn = nil end
      if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
      if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end

      local BG = Instance.new("BodyGyro")
      BG.P = 9e4
      BG.MaxTorque = Vector3.new(9e9,9e9,9e9)
      BG.CFrame = hrp.CFrame
      BG.Name = "FlyGyro"
      BG.Parent = hrp

      local BV = Instance.new("BodyVelocity")
      BV.MaxForce = Vector3.new(9e9,9e9,9e9)
      BV.Velocity = Vector3.zero
      BV.Name = "FlyVelocity"
      BV.Parent = hrp

      hum.PlatformStand = true

      if not isMobile then
         local CONTROL = {F=0,B=0,L=0,R=0,Q=0,E=0}

         g.pcFlyConn = RunService.RenderStepped:Connect(function(dt)
            if not g.FlyEnabled then return end
            if not cam or not hrp or not hum then return end

            local speedNow = ((vfly and (g.VehicleFlySpeed or g.FlySpeed)) or g.FlySpeed) * 50
            local look = cam.CFrame
            local moveVec = ((look.LookVector * (CONTROL.F + CONTROL.B)) + ((look * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.Q + CONTROL.E) * 0.2, 0).p) - look.p))

            if moveVec.Magnitude > 0 then
               moveVec = moveVec.Unit
               BV.Velocity = moveVec * speedNow
            else
               BV.Velocity = BV.Velocity * 0.9
            end

            BG.CFrame = cam.CFrame
         end)

         g.flyKeyDown = UIS.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 1 end
            if input.KeyCode == Enum.KeyCode.S then CONTROL.B = -1 end
            if input.KeyCode == Enum.KeyCode.A then CONTROL.L = -1 end
            if input.KeyCode == Enum.KeyCode.D then CONTROL.R = 1 end
            if g.QEfly then
               if input.KeyCode == Enum.KeyCode.E then CONTROL.Q = 1 end
               if input.KeyCode == Enum.KeyCode.Q then CONTROL.E = -1 end
            end
            pcall(function() cam.CameraType = Enum.CameraType.Track end)
         end)

         g.flyKeyUp = UIS.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then CONTROL.F = 0 end
            if input.KeyCode == Enum.KeyCode.S then CONTROL.B = 0 end
            if input.KeyCode == Enum.KeyCode.A then CONTROL.L = 0 end
            if input.KeyCode == Enum.KeyCode.D then CONTROL.R = 0 end
            if input.KeyCode == Enum.KeyCode.E then CONTROL.Q = 0 end
            if input.KeyCode == Enum.KeyCode.Q then CONTROL.E = 0 end
         end)

         notify("Success", "Fly enabled (PC) | Speed: "..tostring(g.FlySpeed), 5)
         return
      end

      local ok, controlModule = pcall(function()
         return require(plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
      end)
      if not ok or not controlModule then
         notify("Warning", "ControlModule unavailable; using simple touch fallback.", 5)
         g.mobileFlyConn = RunService.RenderStepped:Connect(function()
            if not g.FlyEnabled then return end
            BG.CFrame = cam.CFrame
            BV.Velocity = Vector3.zero
         end)
         return
      end

      g.mobileFlyConn = RunService.RenderStepped:Connect(function()
         if not g.FlyEnabled then return end
         if not hrp or not hum or not cam then return end
         BG.CFrame = cam.CFrame

         local direction = controlModule:GetMoveVector()
         local speedScaled = ((vfly and (g.VehicleFlySpeed or g.FlySpeed)) or g.FlySpeed) * 50

         if direction.Magnitude > 0 then
            BV.Velocity = (cam.CFrame.LookVector * -direction.Z + cam.CFrame.RightVector * direction.X) * speedScaled
         else
            BV.Velocity = Vector3.zero
         end
      end)

      notify("Success", "Fly enabled (Mobile) | Speed: "..tostring(g.FlySpeed), 5)
   end

   print("enable fly function good.")

   g.DisableFly = function()
      if not g.FlyEnabled then
         return notify("Warning", "Fly is not enabled!", 5)
      end

      g.FlyEnabled = false
      if g.flyKeyDown then g.flyKeyDown:Disconnect() g.flyKeyDown = nil end
      if g.flyKeyUp then g.flyKeyUp:Disconnect() g.flyKeyUp = nil end
      if g.pcFlyConn then g.pcFlyConn:Disconnect() g.pcFlyConn = nil end
      if g.mobileFlyConn then g.mobileFlyConn:Disconnect() g.mobileFlyConn = nil end

      local plr = g.LocalPlayer
      local char = g.Character or g.get_char(plr)
      local hrp = get_root(plr)
      local hum = get_human(plr)

      if hrp then
         if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
         if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
      end

      if hum then hum.PlatformStand = false end

      notify("Success", "Fly is now disabled.", 5)
   end

   print("disable fly function good.")

   g.VehicleStates = g.VehicleStates or {}

   if not g.VehicleStates[g.LocalPlayer.Name] then
      g.VehicleStates[g.LocalPlayer.Name] = g.LocalPlayer
   end

   print("blur has been executed.")

   --[[if not g.patch_rate_limit then
      if hookfunction then
         notify("Info", "Applying RateLimit bypass... (Phone messages bypass).", 6)
         local RateLimiter = require(g.RateLimiter)
         local ret_true = function() return true end
         local ret_false = function() return false end
         local hook = function(t)
            hookfunction(t.clock, ret_true)
            hookfunction(t.is_limited, ret_false)
            return t
         end

         local old; old = hookfunction(RateLimiter.new, newcclosure(function(...)
            return hook(old(...))
         end))

         if filtergc then
            g.patch_rate_limit = true
            for _, t in filtergc("table", {Keys = "clock", "is_limited"}) do
               hook(t)
            end
            notify("Success", "Bypassed RateLimit for Phone messages.", 5)
         else
            g.patch_rate_limit = true
            notify("Info", "Applying RateLimit bypass... (Phone messages bypass).", 6)

            g.Main_Messages_RateLimiter_Bypass_Loop_Task = g.Main_Messages_RateLimiter_Bypass_Loop_Task or task.spawn(function()
               notify("Success", "Bypassed RateLimit for Phone messages.", 5)
               while g.patch_rate_limit == true do
                  for _, obj in getgc(true) do
                     if typeof(obj) == "table" and rawget(obj, "clock") and rawget(obj, "is_limited") then
                        if obj.clock() ~= true or obj.is_limited() ~= false then
                           pcall(function()
                              local mt = getrawmetatable(obj)
                              if mt and rawset then
                                 rawset(obj, "clock", function() return true end)
                                 rawset(obj, "is_limited", function() return false end)
                              elseif not rawset and mt then
                                 obj.clock = function() return true end
                                 obj.is_limited = function() return false end
                              end
                           end)
                        end
                     end
                  end
                  task.wait(10)
               end
            end)
         end
      else
         notify("Info", "Applying RateLimit bypass... (Phone messages bypass).", 6)
         g.patch_rate_limit = true

         g.MessagesModuleScript_RateLimiter_Bypass_Task = g.MessagesModuleScript_RateLimiter_Bypass_Task or task.spawn(function()
            notify("Success", "Bypassed RateLimit for Phone messages.", 5)
            while g.patch_rate_limit == true do
               for _, obj in getgc(true) do
                  if typeof(obj) == "table" and rawget(obj, "clock") and rawget(obj, "is_limited") then
                     if obj.clock() ~= true or obj.is_limited() ~= false then
                        pcall(function()
                           local mt = getrawmetatable(obj)
                           if mt and rawset then
                              rawset(obj, "clock", function() return true end)
                              rawset(obj, "is_limited", function() return false end)
                           elseif not rawset and mt then
                              obj.clock = function() return true end
                              obj.is_limited = function() return false end
                           end
                        end)
                     end
                  end
               end
               task.wait(10)
            end
         end)
      end
   end--]]

   g.find_core_folder = g.find_core_folder or function()
      for _, v in ipairs(g.ReplicatedStorage:GetDescendants()) do
         if v:IsA("Folder") and v.Name == "Core" and v.Parent.Name == "Modules" then
            return v
         end
      end

      return nil
   end

   print("find core folder function good.")

   g.send_msg_phone = g.send_msg_phone or function(player, msg)
      local Core_Folder = find_core_folder()
      if not Core_Folder then
         return notify("Error", "Core Folder not found (patched?).", 5)
      end
      local Privacy = require(Core_Folder:FindFirstChild("Privacy"))
      if not Privacy then
         return notify("Error", "Privacy ModuleScript not found (patched?).", 5)
      end

      local function get_dm_hash(id)
         local my = Players.LocalPlayer.UserId
         if not id then return nil end
         local a, b = (id < my) and id or my, (id < my) and my or id
         return tostring(a) .. " " .. tostring(b)
      end

      local function send_dm(target, text)
         local targetId = target.UserId
         local hash = get_dm_hash(targetId)
         if not hash then return false end

         local ok, res = pcall(function()
            return Privacy.send_message("messages", hash, text)
         end)

         if not ok or res == false then
            g.Sending_DMs_Main_Non_Loop_Task = g.Sending_DMs_Main_Non_Loop_Task or task.spawn(function()
               notify("Error", "Send message failed: "..tostring(res), 7)
            end)
            return false
         end

         return true
      end

      local text_to_send = msg

      if not text_to_send or text_to_send == "" then
         return g.notify("Error", "Please input a valid message to send!", 5)
      end

      send_dm(player, text_to_send)
   end

   local ui_mod = require(g.ReplicatedStorage.Modules.Core.UI)
   local data_mod = require(g.ReplicatedStorage.Modules.Core:FindFirstChild("Data", true))
   local messages_mod = require(g.ReplicatedStorage:FindFirstChild("Messages", true))
   local scroll_frame = ui_mod.get("MessagesChatScrollFrame")
   local function get_other_from_hash(hash, known_id)
      local id1, id2 = hash:match("(%-?%d+) (%-?%d+)")
      id1, id2 = tonumber(id1), tonumber(id2)
      if not id1 or not id2 then return nil end
      if id1 == known_id then return id2 end
      if id2 == known_id then return id1 end
      return nil
   end

   local function get_recipient_id()
      local convo = messages_mod.active_conversation
      if not convo then return nil end
      return get_other_from_hash(convo.hash, game.Players.LocalPlayer.UserId)
   end

   local function get_recipient_from_message(msg_id, sender_id)
      for _, convo in ipairs(data_mod.conversations or {}) do
         if convo.messages then
            for _, msg in ipairs(convo.messages) do
               if msg.id == msg_id then
                  return get_other_from_hash(convo.hash, sender_id)
               end
            end
         end
      end
      return nil
   end

   local function get_sender_id(msg_id)
      for _, convo in ipairs(data_mod.conversations or {}) do
         if convo.messages then
            for _, msg in ipairs(convo.messages) do
               if msg.id == msg_id then
                  return msg.sender_id, convo.hash
               end
            end
         end
      end
      return nil, nil
   end

   g.chat_logged_ids = g.chat_logged_ids or {}
   g.chat_frame_locks = g.chat_frame_locks or {}
   g.chat_text_conns = g.chat_text_conns or {}
   g.chat_send_queue = g.chat_send_queue or {}
   g.chat_sending = g.chat_sending or false

   local function resolve_name(uid)
      for _, p in ipairs(Players:GetPlayers()) do
         if p.UserId == uid then
            return p.Name
         end
      end
      return "User_" .. uid
   end

   local function enqueue_message(msg)
      table.insert(g.chat_send_queue, msg)
   end

   if not g.chat_sender_thread then
      g.chat_sender_thread = task.spawn(function()
         while true do
            if not g.chat_sending and #g.chat_send_queue > 0 then
               g.chat_sending = true
               local msg = table.remove(g.chat_send_queue, 1)
               pcall(function()
                  if g.Send_Main_Issues then
                     g.Send_Main_Issues(msg)
                  end
               end)
               wait(0.01)
               g.chat_sending = false
            end
            wait()
         end
      end)
   end

   local function log_message(frame, txt, msg_id, sender_id)
      local unique_id = msg_id .. "|" .. txt.Text
      if g.chat_logged_ids[unique_id] then return end
      g.chat_logged_ids[unique_id] = true

      local sender_name = resolve_name(sender_id)
      local recipient_id = tonumber(frame:GetAttribute("recipient_id"))
         or get_recipient_from_message(msg_id, sender_id)
         or get_recipient_id()

      local recipient_name = recipient_id and resolve_name(recipient_id) or "unknown"
      local recipient_str  = recipient_id
         and (recipient_name .. " (" .. recipient_id .. ")")
         or "unknown"

      enqueue_message(
         sender_name .. " (" .. sender_id .. " to " .. recipient_str .. "): " .. txt.Text
      )
   end

   local function process_message_frame(frame)
      if frame.Name ~= "Message" then return end
      local msg_id = frame:GetAttribute("id")
      if type(msg_id) ~= "string" then return end
      local sender_id, hash = get_sender_id(msg_id)
      if not sender_id then return end
      local recipient_id = get_other_from_hash(hash, sender_id)
      if recipient_id then
         frame:SetAttribute("recipient_id", recipient_id)
      end

      local txt = frame:FindFirstChildWhichIsA("TextLabel", true)
      if not txt then return end

      if not g.chat_text_conns[txt] then
         g.chat_text_conns[txt] = txt:GetPropertyChangedSignal("Text"):Connect(function()
            if txt.Text == "" then return end
            task.delay(0.02, function()
               if txt.Text ~= "" then
                  log_message(frame, txt, msg_id, sender_id)
               end
            end)
         end)
      end

      task.delay(0.05, function()
         if txt and txt.Text ~= "" then
            log_message(frame, txt, msg_id, sender_id)
         end
      end)
   end

   for _, v in ipairs(scroll_frame:GetChildren()) do
      process_message_frame(v)
   end

   if g.chat_descendant_conn then
      g.chat_descendant_conn:Disconnect()
   end
   fw(0.1)
   g.chat_descendant_conn = scroll_frame.DescendantAdded:Connect(function(v)
      local frame = v:FindFirstAncestor("Message")
      if frame then
         process_message_frame(frame)
      end
   end)

   print("send message function good.")

   g.toggle_rgb_streetlights = function(toggle)
      local genv = g

      if toggle == true then
         if genv.RGB_Street_Lights_NightTime_Loop or genv.StreetLightRainbowConnection then
            return genv.notify("Warning", "RGB/Rainbow StreetLights is already running!", 5)
         end

         local Map = Workspace:FindFirstChild("Map", true)
         if not Map then
            return genv.notify("Error", "Map Folder not found inside of Workspace!", 6)
         end

         local StreetLs = Map:FindFirstChild("StreetLights", true)
         if not StreetLs then
            return genv.notify("Error", "StreetLights not found inside of Map Folder!", 5)
         end

         if typeof(genv.all_street_lights) ~= "table" then
            genv.all_street_lights = {}
         end

         if next(genv.all_street_lights) == nil then
            for _, v in ipairs(StreetLs:GetDescendants()) do
               if v:IsA("PointLight") then
                  table.insert(genv.all_street_lights, v)
               end
            end
         end

         local hue = 0
         genv.RGB_Street_Lights_NightTime_Loop = true

         genv.notify("Success", "RGB/Rainbow StreetLights enabled. They will animate at night.", 10)

         genv.StreetLightRainbowConnection = RunService.Heartbeat:Connect(function(dt)
            local clock_time = Lighting.ClockTime
            if clock_time < 18.5 and clock_time > 7.5 then
               return
            end

            hue = (hue + dt * 0.0833) % 1
            local color = Color3.fromHSV(hue, 1, 1)

            for i = #genv.all_street_lights, 1, -1 do
               local light = genv.all_street_lights[i]
               if not light or not light.Parent then
                  table.remove(genv.all_street_lights, i)
               else
                  light.Color = color
               end
            end
         end)
      elseif toggle == false then
         if not genv.RGB_Street_Lights_NightTime_Loop then
            return genv.notify("Warning", "RGB/Rainbow StreetLights is not enabled!", 5)
         end

         genv.RGB_Street_Lights_NightTime_Loop = false

         if genv.StreetLightRainbowConnection then
            genv.StreetLightRainbowConnection:Disconnect()
            genv.StreetLightRainbowConnection = nil
         end

         genv.notify("Success", "RGB/Rainbow StreetLights disabled.", 10)
      end
   end

   print("toggle rgb streetlights good.")

   local excluded_functions = {
      HttpGet = true,
      appendfile = true,
      base64_decode = true,
      base64_encode = true,
      base64decode = true,
      base64encode = true,
      cansignalreplicate = true,
      checkcaller = true,
      checkclosure = true,
      clear_teleport_queue = true,
      cleardrawcache = true,
      clearqueueonteleport = true,
      clearteleportqueue = true,
      clonefunction = true,
      cloneref = true,
      clonereference = true,
      compareinstances = true,
      consoleclear = true,
      consolecreate = true,
      consoledestroy = true,
      consoleerror = true,
      consoleinput = true,
      consoleprint = true,
      consolesettitle = true,
      consolewarn = true,
      create_comm_channel = true,
      createrenderobj = true,
      createrenderobject = true,
      decompile = true,
      delfile = true,
      delfolder = true,
      dofile = true,
      dumpstring = true,
      filtergc = true,
      fireclickdetector = true,
      fireproximityprompt = true,
      firesignal = true,
      firetouchinterest = true,
      get_actor_threads = true,
      get_actors = true,
      get_comm_channel = true,
      get_deleted_actors = true,
      get_hidden_gui = true,
      get_hwid = true,
      get_internal_parent = true,
      get_namecall_method = true,
      get_thread_identity = true,
      get_user_identifier = true,
      getactors = true,
      getactorthreads = true,
      getallthreads = true,
      getbspval = true,
      getcallbackmember = true,
      getcallbackvalue = true,
      getcallingscript = true,
      getcaps = true,
      getclosurecaps = true,
      getconnection = true,
      getconnections = true,
      getconstant = true,
      getconstants = true,
      getcustomasset = true,
      getdeletedactors = true,
      getexecutorname = true,
      getfenv = true,
      getfflag = true,
      getfpscap = true,
      getfunctionhash = true,
      getgc = true,
      getgenv = true,
      gethiddenprop = true,
      gethiddenproperty = true,
      gethui = true,
      gethwid = true,
      getidentity = true,
      getinfo = true,
      getinstances = true,
      getinternalparent = true,
      getloadedmodules = true,
      getnamecallmethod = true,
      getnilinstances = true,
      getobjects = true,
      getpcd = true,
      getproto = true,
      getprotos = true,
      getproximitypromptduration = true,
      getrawmetatable = true,
      getreg = true,
      getregistry = true,
      getrenderproperty = true,
      getrendersteppedlist = true,
      getrenv = true,
      getrunningscripts = true,
      getsafeenv = true,
      getscriptbytecode = true,
      getscriptclosure = true,
      getscriptfromthread = true,
      getscriptfunction = true,
      getscripthash = true,
      getscripts = true,
      getsenv = true,
      getsimulationradius = true,
      getstack = true,
      getsynasset = true,
      gettenv = true,
      getthreadcontext = true,
      getthreadidentity = true,
      getupvalue = true,
      getupvalues = true,
      hookfunc = true,
      hookfunction = true,
      hookmetamethod = true,
      http_request = true,
      httpget = true,
      identifyexecutor = true,
      is_parallel = true,
      is_readonly = true,
      iscclosure = true,
      isexecutorclosure = true,
      isfile = true,
      isfolder = true,
      isfunctionhooked = true,
      isgameactive = true,
      islclosure = true,
      isnetworkowner = true,
      isnewcclosure = true,
      isourclosure = true,
      isourthread = true,
      isparallel = true,
      isrbxactive = true,
      isreadonly = true,
      isrenderobj = true,
      isscriptable = true,
      isuntouched = true,
      isvalidlevel = true,
      iswindowactive = true,
      keyclick = true,
      keypress = true,
      keyrelease = true,
      keytap = true,
      listfiles = true,
      loadfile = true,
      loadstring = true,
      lz4compress = true,
      lz4decompress = true,
      makefolder = true,
      makereadonly = true,
      makewriteable = true,
      messagebox = true,
      messageboxasync = true,
      mouse1click = true,
      mouse1press = true,
      mouse1release = true,
      mouse2click = true,
      mouse2press = true,
      mouse2release = true,
      mousemoveabs = true,
      mousemoverel = true,
      mousescroll = true,
      newcclosure = true,
      newlclosure = true,
      queue_on_teleport = true,
      queueonteleport = true,
      rconsoleclear = true,
      rconsolecreate = true,
      rconsoledestroy = true,
      rconsoleerr = true,
      rconsoleerror = true,
      rconsolehide = true,
      rconsoleinfo = true,
      rconsoleinput = true,
      rconsolename = true,
      rconsoleprint = true,
      rconsolesettitle = true,
      rconsoleshow = true,
      rconsolewarn = true,
      readfile = true,
      replaceclosure = true,
      replicatesignal = true,
      request = true,
      require = true,
      restorefunc = true,
      restorefunction = true,
      run_on_actor = true,
      run_on_thread = true,
      saveinstance = true,
      set_internal_parent = true,
      set_namecall_method = true,
      set_readonly = true,
      set_thread_identity = true,
      setcaps = true,
      setclipboard = true,
      setclosurecaps = true,
      setconstant = true,
      setfflag = true,
      setfpscap = true,
      sethiddenprop = true,
      sethiddenproperty = true,
      setidentity = true,
      setinternalparent = true,
      setname = true,
      setnamecallmethod = true,
      setproximitypromptduration = true,
      setrawmetatable = true,
      setrbxclipboard = true,
      setreadonly = true,
      setrenderproperty = true,
      setsafeenv = true,
      setscriptable = true,
      setsimulationradius = true,
      setstack = true,
      setstackhidden = true,
      setthreadcontext = true,
      setthreadidentity = true,
      setuntouched = true,
      setupvalue = true,
      setwindowtitle = true,
      toclipboard = true,
      validlevel = true,
      writefile = true,
      playemote = true,
      try_load = true,
      change_gravity_val = true,
      execCmd = true,
      disabled_global_value_correctly = true,
      name_changer_premium = true,
      Flames_Debugger_Function_Tester_GUI = true,
      notify = true,
      start_scan = true,
      SetFPSCap = true
   }

   g.Flames_Debugger_Function_Tester_GUI = function()
      local genv = g
      local Players = game:GetService("Players")
      local CoreGui = genv.CoreGui or (cloneref and cloneref(game:GetService("CoreGui"))) or game:GetService("CoreGui")
      local UIS = genv.UserInputService or game:GetService("UserInputService")
      local start_scan

      if genv.__flames_debugger_running then
         if g.notify then
            return g.notify("Warning", "Flames Debugger is already running!", 5)
         else
            return warn("Flames Debugger is already running.")
         end
      end

      if CoreGui:FindFirstChild("FlamesDebugger") then
         CoreGui.FlamesDebugger.Enabled = true
         genv.__flames_debugger_running = false
         g.dont_receive_any_notifications_flames_hub = false
         return
      end

      local gui = Instance.new("ScreenGui")
      gui.Name = "FlamesDebugger"
      gui.ResetOnSpawn = false
      gui.Parent = CoreGui

      local frame = Instance.new("Frame")
      frame.Size = UDim2.fromOffset(400,300)
      frame.Position = UDim2.fromScale(0.4,0.3)
      frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
      frame.Parent = gui

      Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(1,-150,0,30)
      title.Position = UDim2.new(0,10,0,5)
      title.BackgroundTransparency = 1
      title.Text = "Flames Hub | Debugger"
      title.TextScaled = true
      title.TextColor3 = Color3.new(1,1,1)
      title.Parent = frame

      local close = Instance.new("TextButton")
      close.Size = UDim2.fromOffset(26,26)
      close.Position = UDim2.new(1,-32,0,4)
      close.Text = "X"
      close.TextScaled = true
      close.BackgroundColor3 = Color3.fromRGB(120,40,40)
      close.TextColor3 = Color3.new(1,1,1)
      close.Parent = frame

      Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

      close.MouseButton1Click:Connect(function()
         gui.Enabled = false
      end)

      local rescan = Instance.new("TextButton")
      rescan.Size = UDim2.fromOffset(90,24)
      rescan.Position = UDim2.new(1,-130,0,6)
      rescan.Text = "Start Scan"
      rescan.TextScaled = true
      rescan.BackgroundColor3 = Color3.fromRGB(40,90,140)
      rescan.TextColor3 = Color3.new(1,1,1)
      rescan.Parent = frame

      rescan.MouseButton1Click:Connect(function()
         if not genv.__flames_debugger_running then
            genv.__flames_debugger_running = true
            g.dont_receive_any_notifications_flames_hub = true
            start_scan()
         end
      end)

      Instance.new("UICorner", rescan).CornerRadius = UDim.new(0,6)

      local list = Instance.new("ScrollingFrame")
      list.Position = UDim2.new(0,10,0,40)
      list.Size = UDim2.new(1,-20,1,-50)
      list.CanvasSize = UDim2.new(0,0,0,0)
      list.ScrollBarImageTransparency = 0.2
      list.Parent = frame

      local layout = Instance.new("UIListLayout")
      layout.Padding = UDim.new(0,4)
      layout.Parent = list

      local function update_canvas()
         list.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 6)
      end

      layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(update_canvas)

      local function add_row(text, success)
         local row = Instance.new("TextLabel")
         row.Size = UDim2.new(1,-6,0,24)
         row.TextXAlignment = Enum.TextXAlignment.Left
         row.TextScaled = true
         row.TextColor3 = Color3.new(1,1,1)
         row.BackgroundColor3 = success and Color3.fromRGB(30,80,30) or Color3.fromRGB(90,30,30)
         row.Text = (success and "  ?  " or "  ?  ") .. text
         row.Parent = list
      end

      local function snapshot_guis()
         local snap = {}
         for _,v in ipairs(CoreGui:GetChildren()) do
            if v:IsA("ScreenGui") then
               snap[v] = true
            end
         end
         return snap
      end

      local function cleanup_guis(before)
         for _,v in ipairs(CoreGui:GetChildren()) do
            if v:IsA("ScreenGui") and not before[v] and v ~= gui then
               pcall(function()
                  v:Destroy()
               end)
            end
         end
      end

      local function clear_list()
         for _,v in ipairs(list:GetChildren()) do
            if v:IsA("TextLabel") then
               v:Destroy()
            end
         end
      end

      if rescan and rescan:IsA("TextButton") then
         task.spawn(function()
            while true do
               wait(0.5)
               if g.button_text_changing_for_debug_scanner then
                  wait(0.5)
                  rescan.Text = "Scan Running."
                  wait(0.6)
                  if not g.button_text_changing_for_debug_scanner then end

                  rescan.Text = "Scan Running.."
                  wait(0.6)
                  if not g.button_text_changing_for_debug_scanner then end

                  rescan.Text = "Scan Running..."
                  wait(0.6)
               else
                  wait(0.6)
               end
            end
         end)
      end

      start_scan = function()
         task.spawn(function()
            g.button_text_changing_for_debug_scanner = true

            local function run_scan()
               clear_list()

               local tested = 0

               for name,value in next,genv do
                  if tested >= 25 then break end

                  if typeof(value) == "function" and not excluded_functions[name] then
                     tested = tested + 1

                     local before = snapshot_guis()
                     local ok, err = pcall(value)
                     cleanup_guis(before)

                     if ok then
                        add_row(name.."()", true)
                     else
                        if typeof(err) == "string" then
                           local lower = err:lower()
                           if lower:find("nil") or lower:find("argument") or lower:find("index") then
                              add_row(name.."() - ignore", false)
                           else
                              add_row(name.."() - runtime error", false)
                           end
                        else
                           add_row(name.."()", false)
                        end
                     end

                     wait(0.5)
                  end
               end

               if tested == 0 then
                  add_row("No functions found to test", false)
                  g.dont_receive_any_notifications_flames_hub = false
               else
                  add_row("Completed testing "..tested.." functions", true)
                  g.dont_receive_any_notifications_flames_hub = false
               end
            end

            pcall(run_scan)

            g.button_text_changing_for_debug_scanner = false
            genv.__flames_debugger_running = false
            g.dont_receive_any_notifications_flames_hub = false

            if rescan and rescan:IsA("TextButton") then
               rescan.Text = "Start Scan"
            end
         end)
      end

      local dragging = false
      local drag_start
      local start_pos
      local drag_input

      title.InputBegan:Connect(function(input)
         if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            drag_start = input.Position
            start_pos = frame.Position
            input.Changed:Connect(function()
               if input.UserInputState == Enum.UserInputState.End then
                  dragging = false
               end
            end)
         end
      end)

      title.InputChanged:Connect(function(input)
         if input.UserInputType == Enum.UserInputType.MouseMovement then
            drag_input = input
         end
      end)

      UIS.InputChanged:Connect(function(input)
         if input == drag_input and dragging then
            local delta = input.Position - drag_start
            frame.Position = UDim2.new(
               start_pos.X.Scale,
               start_pos.X.Offset + delta.X,
               start_pos.Y.Scale,
               start_pos.Y.Offset + delta.Y
            )
         end
      end)
   end

   g.CreateCreditsLabel = function()
      if g.CreditsLabelGui then
         g.CreditsLabelGui:Destroy()
      end

      local creditsGui = Instance.new("ScreenGui")
      creditsGui.Name = "PrefixCreditsGui_LifeTogether"
      creditsGui.ResetOnSpawn = false
      creditsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      creditsGui.Parent = CoreGui

      local label = Instance.new("TextLabel")
      label.Name = "CreditsLabel"
      g.MainCreditsLabel_WithPrefix = label
      label.AnchorPoint = Vector2.new(0.5, 1)

      if isMobile then
         label.Position = UDim2.new(0.5, 0, 0.95, -10)
         label.Size = UDim2.new(0.3, 0, 0, 28)
      else
         label.Position = UDim2.new(0.5, 0, 0.949999988, 25)
         label.Size = UDim2.new(0.6, 0, 0, 28)
      end

      label.BackgroundColor3 = Color3.fromRGB(151, 0, 0)
      label.TextColor3 = Color3.fromRGB(0, 0, 0)
      flowrgb("PrefixCreditsLabelConn", 1, label, true)

      local prefix = decodeHTMLEntities(tostring(g.AdminPrefix))
      local parts = {
         tostring(g.Script_Version)
      }

      if holiday ~= "" then
         table.insert(parts, holiday)
      end

      table.insert(parts, "Made By: " .. tostring(Script_Creator))
      table.insert(parts, "Current Prefix: " .. prefix)

      if masked_flames_hub_server_ID then
         table.insert(parts, "Your Flames-Hub UUID: " .. tostring(masked_flames_hub_server_ID))
      end

      label.Text = table.concat(parts, " | ")
      label.Font = Enum.Font.GothamBold
      label.TextScaled = true
      label.RichText = false
      label.TextStrokeTransparency = 1
      label.BackgroundTransparency = 0
      label.ZIndex = 10
      label.Parent = creditsGui

      local corner = Instance.new("UICorner")
      corner.CornerRadius = UDim.new(0, 10)
      corner.Parent = label

      g.CreditsLabelGui = creditsGui
      g.CreditsLabelText = label

      if g._PrefixUpdateConnection then
         g._PrefixUpdateConnection:Disconnect()
      end

      if typeof(g.AdminPrefix) == "Instance" and g.AdminPrefix:IsA("StringValue") then
         g._PrefixUpdateConnection = g.AdminPrefix.Changed:Connect(function()
            local prefix = decodeHTMLEntities(tostring(g.AdminPrefix))

            local parts = {
               tostring(g.Script_Version)
            }

            if holiday ~= "" then
               table.insert(parts, holiday)
            end

            table.insert(parts, "Made By: " .. tostring(Script_Creator))
            table.insert(parts, "Current Prefix: " .. prefix)

            if masked_flames_hub_server_ID then
               table.insert(parts, "Your Flames-Hub UUID: " .. tostring(masked_flames_hub_server_ID))
            end

            label.Text = table.concat(parts, " | ")
         end)
      else
         g.LastPrefix_Updater_Main_Task_Watcher = g.LastPrefix_Updater_Main_Task_Watcher or task.spawn(function()
            local lastPrefix = tostring(g.AdminPrefix)

            while label and label.Parent do
               task.wait(0.3)

               if tostring(g.AdminPrefix) ~= lastPrefix then
                  lastPrefix = tostring(g.AdminPrefix)
                  local prefix = decodeHTMLEntities(tostring(g.AdminPrefix))

                  local parts = {
                     tostring(g.Script_Version)
                  }

                  if holiday ~= "" then
                     table.insert(parts, holiday)
                  end

                  table.insert(parts, "Made By: " .. tostring(Script_Creator))
                  table.insert(parts, "Current Prefix: " .. prefix)

                  if masked_flames_hub_server_ID then
                     table.insert(parts, "Your Flames-Hub UUID: " .. tostring(masked_flames_hub_server_ID))
                  end

                  label.Text = table.concat(parts, " | ")
               end
            end
         end)
      end
   end

   CreateCreditsLabel()
   g.hidden_pcm = setmetatable({}, { __mode = "k" })
   g.HidePhoneModels = g.HidePhoneModels or false
   g.phone_model_anti_rgb_phone_hider_values = setmetatable({}, { __mode = "k" })
   g._pcm_registry = setmetatable({}, { __mode = "k" })
   local SavedValues = g.phone_model_anti_rgb_phone_hider_values

   g.hide_pcm = function(pcm)
      if not pcm or not pcm:IsA("Model") then return end
      if g.hidden_pcm[pcm] then return end

      SavedValues[pcm] = SavedValues[pcm] or {}

      for _, v in ipairs(pcm:GetDescendants()) do
         if v:IsA("BasePart") then
            SavedValues[pcm][v] = {
               LocalTransparencyModifier = v.LocalTransparencyModifier,
               CanCollide = v.CanCollide,
               CanQuery = v.CanQuery,
               CanTouch = v.CanTouch
            }
            v.LocalTransparencyModifier = 1
            v.CanCollide = false
            v.CanQuery = false
            v.CanTouch = false
         elseif v:IsA("Decal") or v:IsA("Texture") then
            SavedValues[pcm][v] = { Transparency = v.Transparency }
            v.Transparency = 1
         elseif v:IsA("Sound") then
            SavedValues[pcm][v] = { Volume = v.Volume }
            v.Volume = 0
         end
      end

      local desc_conn = pcm.DescendantAdded:Connect(function(v)
         if not g.HidePhoneModels then return end
         SavedValues[pcm] = SavedValues[pcm] or {}
         if v:IsA("BasePart") then
            SavedValues[pcm][v] = {
               LocalTransparencyModifier = v.LocalTransparencyModifier,
               CanCollide = v.CanCollide,
               CanQuery = v.CanQuery,
               CanTouch = v.CanTouch
            }
            v.LocalTransparencyModifier = 1
            v.CanCollide = false
            v.CanQuery = false
            v.CanTouch = false
         elseif v:IsA("Decal") or v:IsA("Texture") then
            SavedValues[pcm][v] = { Transparency = v.Transparency }
            v.Transparency = 1
         elseif v:IsA("Sound") then
            SavedValues[pcm][v] = { Volume = v.Volume }
            v.Volume = 0
         end
      end)

      g.hidden_pcm[pcm] = { conn = desc_conn }
   end

   g.show_pcm = function(pcm)
      if not pcm or not pcm:IsA("Model") then return end
      local entry = g.hidden_pcm[pcm]
      if not entry then return end

      if entry.conn and entry.conn.Connected then
         entry.conn:Disconnect()
      end

      local pcm_saved = SavedValues[pcm]

      if pcm_saved then
         for _, v in ipairs(pcm:GetDescendants()) do
            local orig = pcm_saved[v]
            if not orig then continue end
            if v:IsA("BasePart") then
               v.LocalTransparencyModifier = orig.LocalTransparencyModifier
               v.CanCollide = orig.CanCollide
               v.CanQuery = orig.CanQuery
               v.CanTouch = orig.CanTouch
            elseif v:IsA("Decal") or v:IsA("Texture") then
               v.Transparency = orig.Transparency
            elseif v:IsA("Sound") then
               v.Volume = orig.Volume
            end
         end
         SavedValues[pcm] = nil
      end

      g.hidden_pcm[pcm] = nil
   end

   g.try_hide_pcm = function(character)
      if not g.HidePhoneModels then return end
      if not character then return end

      local plr = Players:GetPlayerFromCharacter(character)
      if not plr or plr == LocalPlayer then return end

      local pcm = character:FindFirstChild("PhoneCharacterModel")
      if not pcm then return end

      g.hide_pcm(pcm)
   end

   g.scan_character = function(character)
      if not character then return end
      task.defer(function() g.try_hide_pcm(character) end)
      local char_id = tostring(character) .. "_childadded"
      local cleanup_id = tostring(character) .. "_ancestry"

      for _, child in ipairs(character:GetChildren()) do
         if child:IsA("Model") and child.Name == "PhoneCharacterModel" then
            g._pcm_registry[child] = true
         end
      end

      FlamesLibrary.connect(char_id, character.ChildAdded:Connect(function(child)
         if child:IsA("Model") and child.Name == "PhoneCharacterModel" then
            g._pcm_registry[child] = true
            task.defer(function()
               if g.HidePhoneModels then
                  g.hide_pcm(child)
               end
            end)
         end
      end))

      FlamesLibrary.connect(cleanup_id, character.AncestryChanged:Connect(function(_, parent)
         if not parent then
            FlamesLibrary.disconnect(char_id)
            FlamesLibrary.disconnect(cleanup_id)
         end
      end))
   end

   g.hook_player = function(plr)
      if plr == LocalPlayer then return end
      local plr_id = tostring(plr.UserId)
      FlamesLibrary.spawn(plr_id .. "_charwait", "spawn", function()
         local char = get_char(plr, 10)
         if char then
            g.scan_character(char)
         end
      end)

      FlamesLibrary.connect(plr_id .. "_charadded", plr.CharacterAdded:Connect(function(char)
         g.scan_character(char)
      end))
   end

   FlamesLibrary.disconnect("pmh_playeradded")
   FlamesLibrary.disconnect("pmh_playerremoving")
   FlamesLibrary.connect("pmh_playeradded", Players.PlayerAdded:Connect(g.hook_player))
   FlamesLibrary.connect("pmh_playerremoving", Players.PlayerRemoving:Connect(function(plr)
      local plr_id = tostring(plr.UserId)
      FlamesLibrary.disconnect(plr_id .. "_charadded")
      FlamesLibrary.disconnect(plr_id .. "_charwait")
   end))

   for _, plr in ipairs(Players:GetPlayers()) do if plr ~= game.Players.LocalPlayer then g.hook_player(plr) end end

   g.rescan_all_pcms = function()
      for pcm in pairs(g._pcm_registry) do
         if not pcm.Parent then
            g._pcm_registry[pcm] = nil
            continue
         end
         local char = pcm.Parent
         local hum = char and char:FindFirstChildOfClass("Humanoid")
         if hum and hum.Health > 0 then
            if g.HidePhoneModels then
               g.hide_pcm(pcm)
            else
               g.show_pcm(pcm)
            end
         end
      end
   end

   g.TogglePhoneModelHider = function(state)
      if type(state) == "boolean" then
         g.HidePhoneModels = state
      else
         g.HidePhoneModels = not g.HidePhoneModels
      end

      if g.HidePhoneModels then
         g.rescan_all_pcms()
      else
         for pcm in pairs(g.hidden_pcm) do
            g.show_pcm(pcm)
         end
      end
   end

   g.ShutdownPhoneModelHider = function()
      for pcm in pairs(g.hidden_pcm) do
         g.show_pcm(pcm)
      end

      FlamesLibrary.disconnect("pmh_playeradded")
      FlamesLibrary.disconnect("pmh_playerremoving")

      for _, plr in ipairs(Players:GetPlayers()) do
         local plr_id = tostring(plr.UserId)
         FlamesLibrary.disconnect(plr_id .. "_charadded")
         FlamesLibrary.disconnect(plr_id .. "_charwait")
      end

      table.clear(g.hidden_pcm)
      table.clear(SavedValues)
      table.clear(g._pcm_registry)
   end

   if not g.FlamesHub_CharacterAdded_Initialized then
      g.FlamesHub_CharacterAdded_Initialized = true

      local function character_added_jump_height_changer_Life_Together_RP(Character)
         Character = g.Character or Character
         if not Character or not Character.Parent then
            Character = get_char(LocalPlayer, 10)
         end
         if not Character or not Character.Parent then return end

         local Humanoid = g.Humanoid
         if not Humanoid or not Humanoid.Parent then
            Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid", 10) or get_human(LocalPlayer, 10)
         end

         if Humanoid and Humanoid.Parent then
            Humanoid.JumpHeight = 7
         end
      end

      if g.Character or LocalPlayer.Character then
         character_added_jump_height_changer_Life_Together_RP(g.Character or LocalPlayer.Character)
      end

      LocalPlayer.CharacterAdded:Connect(character_added_jump_height_changer_Life_Together_RP)
   end

   g.always_show_title_of_player_regardless_of_chats = function(toggled)
      local lib = g.FlamesLibrary
      local fw = lib.wait
      local key = "showing_billboard_titles_above_heads_anyways"

      if toggled == true then
         if g.always_show_title_above_head then
            return g.notify("Warning", "Flames Hub | Anti-Title_Hider is already enabled!", 6)
         end

         g.notify("Success", "Flames Hub | Anti-Title_Hider is now enabled.", 5)
         g.always_show_title_above_head = true
         lib.spawn(key, "spawn", function()
            while g.always_show_title_above_head == true do
            fw(0)
               for _, v in ipairs(Players:GetPlayers()) do
                  if v ~= Players.LocalPlayer then
                     if not v:GetAttribute("chatting") then print("why does this not exist here?") end
                     v:SetAttribute("chatting", false)
                  end
               end
            end
         end)
      elseif toggled == false then
         if not g.always_show_title_above_head then
            return g.notify("Warning", "Flames Hub | Anti-Title_Hider is not enabled!", 6)
         end

         g.always_show_title_above_head = false
         lib.disconnect(key)
         g.notify("Success", "Flames Hub | Anti-Title_Hider is now disabled.", 5)
      else
         return 
      end
   end

   g.change_RP_Name = function(New_Name)
      send_remote("roleplay_name", tostring(New_Name))
   end

   g.change_bio = function(New_Bio)
      send_remote("bio", tostring(New_Bio))
   end
   fw(0.2)
   -- [[ ultra safe checking that always works + falls back to your current roleplay name if not already saved so you don't have to do it yourself. ]] --
   if isfile and readfile then
      if isfile and isfile("LifeTogether_RP_Admin_Custom_Name.txt") then
         notify("Success", "Got your last RP name (it was erased by Life Together RP), but we're setting it back!", 15)
         local saved_name = readfile and readfile("LifeTogether_RP_Admin_Custom_Name.txt")
         if saved_name and #saved_name > 0 then
            change_RP_Name(saved_name)
         else
            writefile("LifeTogether_RP_Admin_Custom_Name.txt", tostring(g.LocalPlayer:GetAttribute("roleplay_name")) or "DEFAULT")
         end
      end

      if isfile and isfile("LifeTogether_RP_Admin_Custom_Bio.txt") then
         notify("Success", "Got your last RP bio (it was erased by Life Together RP), but we're setting it back!", 15)
         local saved_bio = readfile and readfile("LifeTogether_RP_Admin_Custom_Bio.txt")
         if saved_bio and #saved_bio > 0 then
            change_bio(saved_bio)
         else
            writefile("LifeTogether_RP_Admin_Custom_Bio.txt", tostring(g.LocalPlayer:GetAttribute("bio")) or "DEFAULT")
         end
      end
   end

   g.job_spammer = function(toggle)
      local lib = g.FlamesLibrary
      local key = "job_spammer_loop"
      local fw = lib.wait

      if toggle == true then
         if g.Every_Job then
            return notify("Warning", "Job spammer is already enabled! disable it first.", 5)
         end

         g.Every_Job = true
         notify("Success", "Job Spammer has been enabled.", 5)

         lib.spawn(key, "spawn", function()
            while g.Every_Job == true do
            fw(0)
               g.Send("job", "Police")
               fw(0)
               g.Send("job", "Firefighter")
               fw(0)
               g.Send("job", "Baker")
               fw(0)
               g.Send("job", "Pizza Worker")
               fw(0)
               g.Send("job", "Barista")
               fw(0)
               g.Send("job", "Doctor")
               fw(0)
            end
            lib.disconnect(key)
         end)
      elseif toggle == false then
         if not g.Every_Job then
            return notify("Warning", "Job spammer is not enabled! enable it first.", 5)
         end

         g.Every_Job = false
         lib.disconnect(key)
         notify("Success", "Job Spammer has been disabled.", 5)
      end
   end

   g.stored_effects_main_tbl = g.stored_effects_main_tbl or {}
   g.stored_parts_main_tbl = g.stored_parts_main_tbl or {}
   g.parts_seen = g.parts_seen or {}

   local lighting = g.Lighting or cloneref and cloneref(game:GetService("Lighting")) or game:GetService("Lighting")
   local work = cloneref and cloneref(workspace) or game:GetService("Workspace")

   g.validWorkspacePart = function(inst)
      if not inst or not inst.Parent then return false end
      if inst:IsDescendantOf(lighting) then return false end
      if inst:IsDescendantOf(LocalPlayer.Character or Instance.new("Folder")) then return false end
      return true
   end

   g.saveAndModify = function(inst)
      if g.parts_seen[inst] then return end
      g.parts_seen[inst] = true

      if inst:IsA("BasePart") then
         table.insert(g.stored_parts_main_tbl, {inst = inst, prop = "cast", val = inst.CastShadow})
         inst.CastShadow = false
      elseif inst:IsA("Decal") then
         table.insert(g.stored_parts_main_tbl, {inst = inst, prop = "decal", tex = inst.Texture, transp = inst.Transparency})
         inst.Transparency = 1
         inst.Texture = ""
      elseif inst:IsA("ParticleEmitter") then
         table.insert(g.stored_parts_main_tbl, {inst = inst, prop = "particle", enabled = inst.Enabled, rate = inst.Rate})
         inst.Enabled = false
         inst.Rate = 0
      elseif inst:IsA("Trail") then
         table.insert(g.stored_parts_main_tbl, {inst = inst, prop = "trail", enabled = inst.Enabled})
         inst.Enabled = false
      end
   end

   g.posteffparts = function(toggle)
      local genv = g

      if toggle then
         if genv.post_effects_off_main then return end
         genv.post_effects_off_main = true

         table.clear(genv.stored_effects_main_tbl)
         table.clear(genv.stored_parts_main_tbl)
         table.clear(genv.parts_seen)

         for _, v in ipairs(lighting:GetDescendants()) do
            if v:IsA("PostEffect") then
               table.insert(genv.stored_effects_main_tbl, {inst = v, enabled = v.Enabled})
               v.Enabled = false
            end
         end

         for _, v in ipairs(work:GetDescendants()) do
            if validWorkspacePart(v) then
               saveAndModify(v)
            end
         end

         genv._saved_fog_start = lighting.FogStart
         genv._saved_fog_end = lighting.FogEnd
         lighting.FogStart = 1e5
         lighting.FogEnd = 1e5

         if genv.parts_disabler_conn then
            genv.parts_disabler_conn:Disconnect()
         end

         genv.parts_disabler_conn = work.DescendantAdded:Connect(function(child)
            if not genv.post_effects_off_main then return end
            if not validWorkspacePart(child) then return end
            task.defer(function()
               if child.Parent then
                  saveAndModify(child)
               end
            end)
         end)
      else
         if not genv.post_effects_off_main then return end
         genv.post_effects_off_main = false

         for _, v in ipairs(genv.stored_effects_main_tbl) do
            if v.inst and v.inst.Parent then
               v.inst.Enabled = v.enabled
            end
         end

         for _, data in ipairs(genv.stored_parts_main_tbl) do
            if data.inst and data.inst.Parent then
               if data.prop == "cast" then
                  data.inst.CastShadow = data.val
               elseif data.prop == "decal" then
                  data.inst.Transparency = data.transp
                  data.inst.Texture = data.tex
               elseif data.prop == "particle" then
                  data.inst.Enabled = data.enabled
                  data.inst.Rate = data.rate
               elseif data.prop == "trail" then
                  data.inst.Enabled = data.enabled
               end
            end
         end

         if genv.parts_disabler_conn then
            genv.parts_disabler_conn:Disconnect()
            genv.parts_disabler_conn = nil
         end

         if genv._saved_fog_start then lighting.FogStart = genv._saved_fog_start end
         if genv._saved_fog_end then lighting.FogEnd = genv._saved_fog_end end

         table.clear(genv.stored_effects_main_tbl)
         table.clear(genv.stored_parts_main_tbl)
         table.clear(genv.parts_seen)
      end
   end

   g.TogglePostEffectsParts = posteffparts

   if not g.FlamesLagReducerFunc then
      g.FlamesLagReducerFunc = function(toggle)
         if toggle then
            if g.ultimate_lag_reducer then return notify("Warning", "Flames Hub | Lag Reducer : is already enabled.", 10) end
            g.ultimate_lag_reducer = true
            notify("Success", "Flames Hub | Lag Reducer : is now enabled.", 5)
            pcall(function() g.Send("hide_other_names", true) end)
            pcall(function() g.Send("hide_map_icon", true) end)
            if togglergbflows and typeof(togglergbflows) == "function" then pcall(togglergbflows, false) end
            posteffparts(true)
         else
            if not g.ultimate_lag_reducer then return notify("Warning", "Flames Hub | Lag Reducer : is not enabled.", 10) end
            g.ultimate_lag_reducer = false
            notify("Success", "Flames Hub | Lag Reducer : is now disabled.", 5)
            pcall(function() g.Send("hide_other_names", false) end)
            pcall(function() g.Send("hide_map_icon", false) end)
            posteffparts(false)
         end
      end
   end

   g.DefaultSpeed = g.StarterPlayer.CharacterWalkSpeed
   g.DefaultJP = g.StarterPlayer.CharacterJumpHeight
   g.Old_Workspace_Gravity = g.Workspace.Gravity

   g.change_property = function(property, new_property_value)
      local properties_allowed_to_be_changed = {
         WalkSpeed = true,
         JumpHeight = true,
         HipHeight = true
      }

      if properties_allowed_to_be_changed[property] and g.Humanoid then
         g.Humanoid[property] = new_property_value
      end
   end

   g.change_gravity_val = function(new_val)
      if new_val > 300 then
         new_val = 196
      end

      g.Workspace.Gravity = tonumber(new_val) or 196
   end

   g.reset_properties = function()
      if not g.Humanoid then return end

      g.Humanoid.WalkSpeed = DefaultSpeed or 16
      g.Humanoid.JumpHeight = DefaultJP or 7
      g.Workspace.Gravity = Old_Workspace_Gravity or 196
   end

   g.rainbow_car = function()
      RGB_Vehicle(true)
   end

   g.stop_rainbow_car = function()
      RGB_Vehicle(false)
   end

   g.rainbow_others_car = function(Player)
      RGB_Vehicle_Others(Player, true)
   end

   g.stop_rainbow_others_car = function(Player)
      RGB_Vehicle_Others(Player, false)
   end

   local character = g.Character or g.LocalPlayer.Character or get_char(LocalPlayer or game.Players.LocalPlayer)
   local humanoid = g.Humanoid or g.Character:FindFirstChildOfClass("Humanoid") or get_human(LocalPlayer or game.Players.LocalPlayer)
   local camera = Workspace.CurrentCamera or g.Workspace.CurrentCamera or workspace.CurrentCamera
   g.AdonisAdminFlyEnabled = g.AdonisAdminFlyEnabled or false
   g.AdonisAdminFlySpeed = g.AdonisAdminFlySpeed or 15
   g.FlyConnections = g.FlyConnections or {}
   g.FlyPart = g.FlyPart or nil

   g.SetAdonisFlySpeed = function(v)
      v = tonumber(v)
      if not v then return end
      g.AdonisAdminFlySpeed = math.clamp(v, 1, 300)
   end

   g.StartAdonisAdminFlyScript = function()
      if g.AdonisAdminFlyEnabled then return end
      g.AdonisAdminFlyEnabled = true

      local dir = {w = false, a = false, s = false, d = false, q = false, e = false}
      local cf = Instance.new("CFrameValue")

      if not g.FlyPart then
         g.FlyPart = Instance.new("Part")
         g.FlyPart.Name = "PART_SURFER"
         g.FlyPart.Anchored = true
         g.FlyPart.Parent = StarterPack
         g.FlyPart.CFrame = HumanoidRootPart and HumanoidRootPart.CFrame or CFrame.new()
      end

      g.FlyConnections.render = RunService.RenderStepped:Connect(function()
         if not g.AdonisAdminFlyEnabled or not HumanoidRootPart then return end

         local speed = tonumber(g.AdonisAdminFlySpeed) or 15
         speed = math.clamp(speed, 1, 300)

         for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
               v.Velocity = Vector3.zero
               v.RotVelocity = Vector3.zero
            end
         end

         g.FlyPart.CFrame = CFrame.new(
            g.FlyPart.CFrame.Position,
            (camera.CFrame * CFrame.new(0, 0, -100)).Position
         )

         local offset = Vector3.zero

         if isMobile and controlModule then
            local mv = controlModule:GetMoveVector()
            if mv.Magnitude > 0 then
               offset =
                  (camera.CFrame.LookVector * -mv.Z +
                  camera.CFrame.RightVector * mv.X) * speed
            end
         else
            local x, y, z = 0, 0, 0
            if dir.w then z = -speed end
            if dir.s then z = speed end
            if dir.a then x = -speed end
            if dir.d then x = speed end
            if dir.q then y = speed end
            if dir.e then y = -speed end
            offset = Vector3.new(x, y, z)
         end

         local moveCF = CFrame.new(offset)
         cf.Value = cf.Value:Lerp(moveCF, 0.2)

         g.FlyPart.CFrame =
            g.FlyPart.CFrame:Lerp(g.FlyPart.CFrame * cf.Value, 0.2)

         HumanoidRootPart.CFrame = g.FlyPart.CFrame
         humanoid.PlatformStand = true
      end)

      g.FlyConnections.inputBegan = UserInputService.InputBegan:Connect(function(input, event)
         if event or not g.AdonisAdminFlyEnabled then return end
         local code, codes = input.KeyCode, Enum.KeyCode
         if code == codes.W then
            dir.w = true
         elseif code == codes.A then dir.a = true
         elseif code == codes.S then dir.s = true
         elseif code == codes.D then dir.d = true
         elseif code == codes.Q then dir.q = true
         elseif code == codes.E then dir.e = true
         elseif code == codes.Space then
            dir.q = true
         end
      end)

      g.FlyConnections.inputEnded = UserInputService.InputEnded:Connect(function(input, event)
         if event or not g.AdonisAdminFlyEnabled then return end
         local code, codes = input.KeyCode, Enum.KeyCode
         if code == codes.W then
            dir.w = false
         elseif code == codes.A then dir.a = false
         elseif code == codes.S then dir.s = false
         elseif code == codes.D then dir.d = false
         elseif code == codes.Q then dir.q = false
         elseif code == codes.E then dir.e = false
         elseif code == codes.Space then
            dir.q = false
         end
      end)
      fw(0.1)
      g.notify("Success", "Fly-3 has been enabled with speed: "..tostring(g.AdonisAdminFlySpeed), 6)
   end

   g.Stop_Fly_3_Function = function()
      if not g.AdonisAdminFlyEnabled then return notify("Warning", "Fly-3 is not enabled.", 5) end
      g.AdonisAdminFlyEnabled = false

      for _, conn in pairs(g.FlyConnections) do
         if conn then conn:Disconnect() end
      end
      if next(g.FlyConnections) then
         g.FlyConnections = {}
      end

      if g.FlyPart then
         g.FlyPart:Destroy()
         g.FlyPart = nil
      end

      if humanoid then
         humanoid.PlatformStand = false
      end
   end

   g.Enabled_Flying = g.Enabled_Flying or false
   g.Fly2Speed = g.Fly2Speed or 45
   g.Fly2Control = nil
   g.fly2InputBegan = nil
   g.fly2InputEnded = nil
   g.fly2Heartbeat = nil
   g.fly2MobileConn = nil
   g.EnableFly2 = function(speed)
      if g.Enabled_Flying then
         return notify("Warning", "Fly-2 is already enabled!", 5)
      end

      local UIS = g.UserInputService
      local plr = g.LocalPlayer or game.Players.LocalPlayer
      local char = g.Character or plr.Character or get_char(plr, 10)
      local HRP = g.HumanoidRootPart or char and char:FindFirstChild("HumanoidRootPart") or get_root(plr, 5)
      local Humanoid = g.Humanoid or char and char:FindFirstChildOfClass("Humanoid") or get_human(plr, 5)
      local Workspace = g.Workspace or safe_wrapper("Workspace")
      local RunService = g.RunService or safe_wrapper("RunService")
      local Debris = g.Debris or safe_wrapper("Debris")

      if not HRP or not Humanoid then
         return notify("Error", "Character is not ready or Humanoid is missing.", 5)
      end

      g.Enabled_Flying = true
      g.Fly2Speed = tonumber(speed) or 10
      g.Fly2Control = {F=0,B=0,L=0,R=0}
      local flyY, lastPos = 0, nil

      local gyro = Instance.new("BodyGyro")
      gyro.P = 9e4
      gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
      gyro.CFrame = HRP.CFrame
      gyro.Name = "Fly2Gyro"
      gyro.Parent = HRP

      local vel = Instance.new("BodyVelocity")
      vel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
      vel.Velocity = Vector3.zero
      vel.Name = "Fly2Velocity"
      vel.Parent = HRP

      Humanoid.PlatformStand = true

      if not isMobile then
         if g.fly2InputBegan then g.fly2InputBegan:Disconnect() end
         if g.fly2InputEnded then g.fly2InputEnded:Disconnect() end
         if g.fly2Heartbeat then g.fly2Heartbeat:Disconnect() end

         g.fly2InputBegan = UIS.InputBegan:Connect(function(input, gp)
            if gp then return end
            local s = g.Fly2Speed
            if input.KeyCode == Enum.KeyCode.W then g.Fly2Control.F = s end
            if input.KeyCode == Enum.KeyCode.S then g.Fly2Control.B = -s end
            if input.KeyCode == Enum.KeyCode.A then g.Fly2Control.L = -s end
            if input.KeyCode == Enum.KeyCode.D then g.Fly2Control.R = s end
            if input.KeyCode == Enum.KeyCode.Space then flyY = s end
            if input.KeyCode == Enum.KeyCode.LeftShift then flyY = -s end
         end)

         g.fly2InputEnded = UIS.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then g.Fly2Control.F = 0 end
            if input.KeyCode == Enum.KeyCode.S then g.Fly2Control.B = 0 end
            if input.KeyCode == Enum.KeyCode.A then g.Fly2Control.L = 0 end
            if input.KeyCode == Enum.KeyCode.D then g.Fly2Control.R = 0 end
            if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftShift then flyY = 0 end
         end)

         g.fly2Heartbeat = RunService.RenderStepped:Connect(function()
            if not g.Enabled_Flying then return end
            local C, cam, SPEED = g.Fly2Control, Workspace.CurrentCamera, g.Fly2Speed * 50

            if C.F~=0 or C.B~=0 or C.L~=0 or C.R~=0 or flyY~=0 then
               local moveVec = ((cam.CFrame.LookVector * (C.F + C.B))
                  + ((cam.CFrame * CFrame.new(C.L + C.R, flyY * 0.5, 0).p) - cam.CFrame.p))

               if moveVec.Magnitude > 0 then
                  vel.Velocity = moveVec.Unit * SPEED
               end
            else
               vel.Velocity = vel.Velocity * 0.9
            end

            gyro.CFrame = cam.CFrame

            local pos = HRP.Position
            if not lastPos or (pos - lastPos).Magnitude > 1 then
               local part = Instance.new("Part")
               part.Anchored = true
               part.CanCollide = false
               part.Material = Enum.Material.Neon
               part.Size = Vector3.new(1,1,(pos - (lastPos or pos)).Magnitude + 2)
               part.CFrame = CFrame.new((lastPos or pos) + ((pos - (lastPos or pos)) / 2), pos)
               part.Color = colors[math.random(1, #colors)]
               part.Parent = Workspace
               Debris:AddItem(part, 1)
               lastPos = pos
            end
         end)

         notify("Success", "Fly-2 enabled (PC) | Speed: " .. tostring(g.Fly2Speed), 5)
         return
      end

      local controlModule
      local ok, result = pcall(function()
         return require(plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
      end)
      if ok then controlModule = result end

      g.fly2MobileConn = RunService.RenderStepped:Connect(function()
         if not g.Enabled_Flying then return end
         local cam = Workspace.CurrentCamera
         local s = g.Fly2Speed * 50
         local move = controlModule and controlModule:GetMoveVector() or Vector3.zero

         if move.Magnitude > 0 then
            vel.Velocity = (cam.CFrame.LookVector * -move.Z + cam.CFrame.RightVector * move.X) * s
         else
            vel.Velocity = Vector3.zero
         end

         gyro.CFrame = cam.CFrame

         local pos = HRP.Position
         if not lastPos or (pos - lastPos).Magnitude > 1 then
            local part = Instance.new("Part")
            part.Anchored = true
            part.CanCollide = false
            part.Material = Enum.Material.Neon
            part.Size = Vector3.new(1,1,(pos - (lastPos or pos)).Magnitude + 2)
            part.CFrame = CFrame.new((lastPos or pos) + ((pos - (lastPos or pos)) / 2), pos)
            part.Color = colors[math.random(1, #colors)]
            part.Parent = Workspace
            Debris:AddItem(part, 1)
            lastPos = pos
         end
      end)

      notify("Success", "Fly-2 enabled (Mobile) | Speed: " .. tostring(g.Fly2Speed), 5)
   end

   g.DisableFly2 = function()
      if not g.Enabled_Flying then
         return notify("Warning", "Fly-2 is not enabled, enable it first!", 5)
      end

      g.Enabled_Flying = false

      if g.fly2InputBegan then g.fly2InputBegan:Disconnect() end
      if g.fly2InputEnded then g.fly2InputEnded:Disconnect() end
      if g.fly2Heartbeat then g.fly2Heartbeat:Disconnect() end
      if g.fly2MobileConn then g.fly2MobileConn:Disconnect() end

      local HRP = get_root(g.LocalPlayer)
      local Humanoid = get_human(g.LocalPlayer)

      if HRP then
         for _, v in ipairs(HRP:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
         end
      end
      if Humanoid then Humanoid.PlatformStand = false end

      notify("Success", "Fly-2 is now disabled.", 5)
   end

   g.vehicle_stats_viewer_GUI = function()
      local Vehicles = g.Workspace:FindFirstChild("Vehicles")
      if not Vehicles then
         return notify("Error", "Vehicles Folder not found!", 5)
      end
      if g.Vehicle_Stats_GUI_Active then
         return notify("Error", "Vehicle Stats Viewer already running!", 5)
      end

      g.Vehicle_Stats_GUI_Active = true
      g.VehicleUI = {}
      g.vehicle_attr_conns = {}
      g.Vehicle_Added_And_Removed_Conns = {}

      local ScreenGui = Instance.new("ScreenGui")
      ScreenGui.Name = "VehicleStatsGUI"
      ScreenGui.IgnoreGuiInset = true
      ScreenGui.ResetOnSpawn = false
      ScreenGui.Parent = parent_gui
      g.VehicleStatsGUI = ScreenGui

      local MainFrame = Instance.new("Frame")
      MainFrame.Size = UDim2.new(0,300,0,400)
      MainFrame.Position = UDim2.new(0,20,0,100)
      MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
      MainFrame.BorderSizePixel = 0
      MainFrame.Active = true
      MainFrame.Draggable = true
      MainFrame.Parent = ScreenGui
      Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,12)
      repeat task.wait(1) until MainFrame and MainFrame:IsA("Frame") and ScreenGui:FindFirstChildOfClass("Frame")
      wait(0.5)
      dragify(MainFrame)
      g.notify("Info", "Loading Vehicle Stats viewer.", 3)

      function Unhook(vehicle)
         local ui = g.VehicleUI[vehicle]
         if not ui then return end

         local conns = g.vehicle_attr_conns[vehicle]
         if conns then
            for _,c in ipairs(conns) do
               if c then
                  pcall(function()
                     c:Disconnect()
                  end)
               end
            end
         end

         if ui.Frame then
            pcall(function()
               ui.Frame:Destroy()
            end)
         end

         g.vehicle_attr_conns[vehicle] = nil
         g.VehicleUI[vehicle] = nil
      end

      function Hook(vehicle)
         if g.VehicleUI[vehicle] then return end

         local ui = CreateEntry(vehicle)
         g.VehicleUI[vehicle] = ui

         local conns = {}
         g.vehicle_attr_conns[vehicle] = conns

         table.insert(conns, vehicle:GetAttributeChangedSignal("speed"):Connect(function()
            ui.Speed.Text = tostring(vehicle:GetAttribute("speed") or 0)
         end))

         table.insert(conns, vehicle:GetAttributeChangedSignal("acceleration"):Connect(function()
            ui.Accel.Text = tostring(vehicle:GetAttribute("acceleration") or 0)
         end))

         table.insert(conns, vehicle:GetAttributeChangedSignal("handling"):Connect(function()
            ui.Handling.Text = tostring(vehicle:GetAttribute("handling") or 0)
         end))

         table.insert(conns, vehicle:GetAttributeChangedSignal("color"):Connect(function()
            local c = vehicle:GetAttribute("color")
            if typeof(c) == "Color3" then
               ui.Color.BackgroundColor3 = c
            end
         end))

         table.insert(conns, vehicle.AncestryChanged:Connect(function(_, parent)
            if not parent then
               Unhook(vehicle)
            end
         end))
      end

      local Title = Instance.new("TextLabel")
      Title.Text = "Vehicle Stats Viewer"
      Title.Size = UDim2.new(1,-40,0,30)
      Title.Position = UDim2.new(0,10,0,5)
      Title.BackgroundTransparency = 1
      Title.TextColor3 = Color3.fromRGB(255,255,255)
      Title.Font = Enum.Font.GothamBold
      Title.TextSize = 16
      Title.TextXAlignment = Enum.TextXAlignment.Left
      Title.Parent = MainFrame

      local Close = Instance.new("TextButton")
      Close.Text = "X"
      Close.Size = UDim2.new(0,30,0,30)
      Close.Position = UDim2.new(1,-35,0,5)
      Close.BackgroundColor3 = Color3.fromRGB(50,50,50)
      Close.TextColor3 = Color3.fromRGB(255,255,255)
      Close.Parent = MainFrame
      Instance.new("UICorner", Close).CornerRadius = UDim.new(0,8)

      Close.MouseButton1Click:Connect(function()
         g.Vehicle_Stats_GUI_Active = false

         if g.Vehicle_Added_And_Removed_Conns then
            for _, conn in pairs(g.Vehicle_Added_And_Removed_Conns) do
               pcall(function() conn:Disconnect() end)
            end
            table.clear(g.Vehicle_Added_And_Removed_Conns)
         end

         for v in pairs(g.VehicleUI) do Unhook(v) end
         ScreenGui:Destroy()
      end)

      local Scroller = Instance.new("ScrollingFrame")
      Scroller.Size = UDim2.new(1,-20,1,-90)
      Scroller.Position = UDim2.new(0,10,0,40)
      Scroller.CanvasSize = UDim2.new(0,0,0,0)
      Scroller.ScrollBarThickness = 6
      Scroller.BackgroundTransparency = 1
      Scroller.Parent = MainFrame

      local Layout = Instance.new("UIListLayout")
      Layout.Padding = UDim.new(0,10)
      Layout.Parent = Scroller

      Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
         Scroller.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
      end)

      local function Validate_Model(v)
         if not v:IsA("Model") then return false end
         if v:FindFirstChild("Base") then return true end
         v:WaitForChild("Base", 3)
         return v:FindFirstChild("Base") ~= nil
      end

      g.get_color_name = function(color)
         if not color or typeof(color) ~= "Color3" then
            return "Unknown"
         end

         local get_color_name_colors = {
            {"White",1,242,243,243},
            {"Grey",2,161,165,162},
            {"Light yellow",3,249,233,153},
            {"Brick yellow",5,215,197,154},
            {"Light green (Mint)",6,194,218,184},
            {"Light reddish violet",9,232,186,200},
            {"Pastel Blue",11,128,187,219},
            {"Light orange brown",12,203,132,66},
            {"Nougat",18,204,142,105},
            {"Bright red",21,196,40,28},
            {"Med. reddish violet",22,196,112,160},
            {"Bright blue",23,13,105,172},
            {"Bright yellow",24,245,205,48},
            {"Earth orange",25,98,71,50},
            {"Black",26,27,42,53},
            {"Dark grey",27,109,110,108},
            {"Dark green",28,40,127,71},
            {"Medium green",29,161,196,140},
            {"Lig. Yellowich orange",36,243,207,155},
            {"Bright green",37,75,151,75},
            {"Dark orange",38,160,95,53},
            {"Light bluish violet",39,193,202,222},
            {"Transparent",40,236,236,236},
            {"Tr. Red",41,205,84,75},
            {"Tr. Lg blue",42,193,223,240},
            {"Tr. Blue",43,123,182,232},
            {"Tr. Yellow",44,247,241,141},
            {"Light blue",45,180,210,228},
            {"Tr. Flu. Reddish orange",47,217,133,108},
            {"Tr. Green",48,132,182,141},
            {"Tr. Flu. Green",49,248,241,132},
            {"Phosph. White",50,236,232,222},
            {"Light red",100,238,196,182},
            {"Medium red",101,218,134,122},
            {"Medium blue",102,110,153,202},
            {"Light grey",103,199,193,183},
            {"Bright violet",104,107,50,124},
            {"Br. yellowish orange",105,226,155,64},
            {"Bright orange",106,218,133,65},
            {"Bright bluish green",107,0,143,156},
            {"Earth yellow",108,104,92,67},
            {"Bright bluish violet",110,67,84,147},
            {"Tr. Brown",111,191,183,177},
            {"Medium bluish violet",112,104,116,172},
            {"Tr. Medi. reddish violet",113,229,173,200},
            {"Med. yellowish green",115,199,210,60},
            {"Med. bluish green",116,85,165,175},
            {"Light bluish green",118,183,215,213},
            {"Br. yellowish green",119,164,189,71},
            {"Lig. yellowish green",120,217,228,167},
            {"Med. yellowish orange",121,231,172,88},
            {"Br. reddish orange",123,211,111,76},
            {"Bright reddish violet",124,146,57,120},
            {"Light orange",125,234,184,146},
            {"Tr. Bright bluish violet",126,165,165,203},
            {"Gold",127,220,188,129},
            {"Dark nougat",128,174,122,89},
            {"Silver",131,156,163,168},
            {"Neon orange",133,213,115,61},
            {"Neon green",134,216,221,86},
            {"Sand blue",135,116,134,157},
            {"Sand violet",136,135,124,144},
            {"Medium orange",137,224,152,100},
            {"Sand yellow",138,149,138,115},
            {"Earth blue",140,32,58,86},
            {"Earth green",141,39,70,45},
            {"Tr. Flu. Blue",143,207,226,247},
            {"Sand blue metallic",145,121,136,161},
            {"Sand violet metallic",146,149,142,163},
            {"Sand yellow metallic",147,147,135,103},
            {"Dark grey metallic",148,87,88,87},
            {"Black metallic",149,22,29,50},
            {"Light grey metallic",150,171,173,172},
            {"Sand green",151,120,144,130},
            {"Sand red",153,149,121,119},
            {"Dark red",154,123,46,47},
            {"Tr. Flu. Yellow",157,255,246,123},
            {"Tr. Flu. Red",158,225,164,194},
            {"Gun metallic",168,117,108,98},
            {"Dark stone grey",199,99,95,98},
            {"Medium stone grey",194,163,162,165},
            {"Light stone grey",208,229,228,223},
            {"Really black",1003,17,17,17},
            {"Really red",1004,255,0,0},
            {"Deep orange",1005,255,176,0},
            {"Alder",1006,180,128,255},
            {"Dusty Rose",1007,163,75,75},
            {"Olive",1008,193,190,66},
            {"New Yeller",1009,255,255,0},
            {"Really blue",1010,0,0,255},
            {"Navy blue",1011,0,32,96},
            {"Deep blue",1012,33,84,185},
            {"Cyan",1013,4,175,236},
            {"CGA brown",1014,170,85,0},
            {"Magenta",1015,170,0,170},
            {"Pink",1016,255,102,204},
            {"Deep orange",1017,255,175,0},
            {"Teal",1018,18,238,212},
            {"Toothpaste",1019,0,255,255},
            {"Lime green",1020,0,255,0},
            {"Camo",1021,58,125,21},
            {"Grime",1022,127,142,100},
            {"Lavender",1023,140,91,159},
            {"Pastel light blue",1024,175,221,255},
            {"Pastel orange",1025,255,201,201},
            {"Pastel violet",1026,177,167,255},
            {"Pastel blue-green",1027,159,243,233},
            {"Pastel green",1028,204,255,204},
            {"Pastel yellow",1029,255,255,204},
            {"Pastel brown",1030,255,204,153},
            {"Royal purple",1031,98,37,209},
            {"Hot pink",1032,255,0,191},
         }

         local closest, closestDist = "Unknown", math.huge
         local r, g, b = color.R * 255, color.G * 255, color.B * 255

         for _, c in ipairs(get_color_name_colors) do
            local _, _, R, G, B = unpack(c)
            local dist = (R - r)^2 + (G - g)^2 + (B - b)^2
            if dist < closestDist then
               closestDist = dist
               closest = c[1]
            end
         end

         return closest
      end

      local function WaitForAttribute(inst, attr, timeout)
         if inst:GetAttribute(attr) ~= nil then
            return inst:GetAttribute(attr)
         end

         local done = false
         local val
         local conn
         conn = inst:GetAttributeChangedSignal(attr):Connect(function()
            val = inst:GetAttribute(attr)
            done = true
            conn:Disconnect()
         end)

         local t = tick()
         while not done and tick() - t < (timeout or 5) do
            task.wait()
         end

         if conn then conn:Disconnect() end
         return inst:GetAttribute(attr)
      end

      local function CreateEntry(vehicle)
         local Holder = Instance.new("Frame")
         Holder.Size = UDim2.new(1,0,0,220)
         Holder.BackgroundColor3 = Color3.fromRGB(35,35,35)
         Holder.Parent = Scroller
         Instance.new("UICorner", Holder).CornerRadius = UDim.new(0,10)

         local Click = Instance.new("TextButton")
         Click.Size = UDim2.new(1,0,1,0)
         Click.BackgroundTransparency = 1
         Click.Text = ""
         Click.Parent = Holder

         Click.Activated:Connect(function()
            g.SelectedVehicle = vehicle.Name
         end)

         local spawn = Instance.new("TextButton")
         spawn.Size = UDim2.new(1,-20,0,28)
         spawn.Position = UDim2.new(0,10,1,-34)
         spawn.Text = "Spawn"
         spawn.BackgroundColor3 = Color3.fromRGB(45,45,45)
         spawn.TextColor3 = Color3.fromRGB(255,255,255)
         spawn.Font = Enum.Font.GothamMedium
         spawn.TextSize = 14
         spawn.Parent = Holder
         Instance.new("UICorner", spawn).CornerRadius = UDim.new(0,8)

         spawn.Activated:Connect(function()
            g.SelectedVehicle = vehicle.Name
            g.Send("spawn_vehicle", vehicle.Name)

            local my_vehicle
            local t = tick()

            repeat
               my_vehicle = get_vehicle()
               task.wait()
            until my_vehicle or tick() - t > 6

            if not my_vehicle then return end

            local col = vehicle:GetAttribute("color")
            if typeof(col) == "Color3" then
               g.Send("vehicle_color", col, my_vehicle)
            end
         end)

         local function label(txt,y)
            local l = Instance.new("TextLabel")
            l.Text = txt
            l.Size = UDim2.new(1,-10,0,18)
            l.Position = UDim2.new(0,5,0,y)
            l.BackgroundTransparency = 1
            l.TextColor3 = Color3.fromRGB(180,180,180)
            l.Font = Enum.Font.Gotham
            l.TextSize = 13
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Parent = Holder
            return l
         end

         local name = label("Vehicle: "..vehicle.Name,5)
         name.TextColor3 = Color3.fromRGB(255,255,255)
         name.Font = Enum.Font.GothamMedium
         local owner = label("Owner: N/A",24)
         local maxAcc = label("Max Acceleration: N/A",44)
         local maxSpeed = label("Max Speed: N/A",64)
         local acc60 = label("Acceleration (0 To 60): N/A",84)
         local turn = label("Turn Angle: N/A",104)
         local locked = label("Locked: N/A",124)
         local color = label("Color: N/A",144)

         g.VehicleUI[vehicle] = {
            Frame = Holder,
            Owner = owner,
            MaxAcc = maxAcc,
            MaxSpeed = maxSpeed,
            Acc60 = acc60,
            TurnAngle = turn,
            LockedStatus = locked,
            ColorLabel = color
         }
      end

      local function Update(vehicle)
         local ui = g.VehicleUI[vehicle]
         if not ui then return end

         ui.MaxAcc.Text = "Max Acceleration: "..math.floor(vehicle:GetAttribute("max_acc") or 0)
         ui.MaxSpeed.Text = "Max Speed: "..math.floor(vehicle:GetAttribute("max_speed") or 0)
         ui.Acc60.Text = "Acceleration (0 To 60): "..math.floor(vehicle:GetAttribute("acc_0_60") or 0)
         ui.TurnAngle.Text = "Turn Angle: "..math.floor(vehicle:GetAttribute("turn_angle") or 0)
         ui.LockedStatus.Text = "Locked: "..tostring(vehicle:GetAttribute("locked"))

         local c = vehicle:GetAttribute("color")
         if typeof(c) ~= "Color3" then
            c = WaitForAttribute(vehicle, "color", 5)
         end

         if typeof(c) == "Color3" then
            ui.ColorLabel.Text = "Color: "..g.get_color_name(c)
         else
            ui.ColorLabel.Text = "Color: Unknown"
         end

         local owner = vehicle:GetAttribute("OwnerName")
         ui.Owner.Text = "Owner: "..(owner or "Server Spawned")
      end

      local function Hook(vehicle)
         if g.VehicleUI[vehicle] then return end
         if not Validate_Model(vehicle) then return end

         CreateEntry(vehicle)
         Update(vehicle)

         g.vehicle_attr_conns[vehicle] = {}
         for _,a in ipairs({"OwnerName","max_acc","max_speed","acc_0_60","turn_angle","locked","color"}) do
            table.insert(g.vehicle_attr_conns[vehicle], vehicle:GetAttributeChangedSignal(a):Connect(function()
               Update(vehicle)
            end))
         end
      end

      for _,v in ipairs(Vehicles:GetChildren()) do Hook(v) end

      g.Vehicle_Added_And_Removed_Conns.Child_Added_Watcher = Vehicles.ChildAdded:Connect(function(v)
         task.defer(function()
            Hook(v)
         end)
      end)

      g.Vehicle_Added_And_Removed_Conns.Child_Removed_Watcher = Vehicles.ChildRemoved:Connect(function(v)
         task.defer(function()
            Unhook(v)
         end)
      end)
   end

   g.check_premium_player = function(plr)
      if plr then
         if plr:GetAttribute("is_verified") == true then
            return true
         else
            return false
         end
      end
   end

   g.bansystem = g.bansystem or {
      enabled = false,
      list = {},
      connection = nil
   }

   function addban(input)
      if not input then return nil end
      if typeof(input) == "Instance" and input.Name then
         local n = input.Name:lower()
         g.bansystem.list[n] = true
         return n
      end
      local q = tostring(input):lower()
      if q == "" then return nil end
      for _,v in pairs(Players:GetPlayers()) do
         local ln = v.Name:lower()
         local ld = v.DisplayName:lower()
         if ln:find(q, 1, true) or ld:find(q, 1, true) then
            g.bansystem.list[ln] = true
            kick_plr(v)
            return ln
         end
      end
      g.bansystem.list[q] = true
      return q
   end

   function removeban(input)
      if not input then return nil end
      local q = tostring(input):lower()
      if q == "" then return nil end
      if g.bansystem.list[q] then
         g.bansystem.list[q] = nil
         return q
      end
      for name,_ in pairs(g.bansystem.list) do
         if name:find(q, 1, true) then
            g.bansystem.list[name] = nil
            return name
         end
      end
      return nil
   end

   function checkban(player)
      local n = player.Name:lower()
      if g.bansystem.list[n] then
         if g.bansystem.enabled then
            kick_plr(player)
         end
      end
   end

   function disablebans()
      g.bansystem.enabled = false
      if g.bansystem.connection then
         g.bansystem.connection:Disconnect()
         g.bansystem.connection = nil
      end
   end

   g.start_bansystem = function()
      if g.bansystem.enabled then return end
      if g.bansystem.starting then return end
      g.bansystem.starting = true

      task.spawn(function()
         for i = 1, 5 do
            if is_localplayer_server_owner() then
               g.bansystem.enabled = true
               g.bansystem.starting = false

               for _, p in ipairs(Players:GetPlayers()) do
                  task.spawn(function()
                     fw(0.2)
                     checkban(p)
                  end)
               end

               if not g.bansystem.connection then
                  g.bansystem.connection = Players.PlayerAdded:Connect(checkban)
               end

               notify("Success", "Ban system enabled.", 5)
               return
            end
            wait(1)
         end

         g.bansystem.starting = false
         notify("Info", "Ban system inactive.", 5)
      end)
   end
   fw(0.1)
   if not g.Ban_System_In_Flames_Hub_Has_Been_Started_Already then
      g.Ban_System_In_Flames_Hub_Has_Been_Started_Already = true  -- actually set it!
      task.spawn(function() start_bansystem() end)
   end

   g.get_server_admin_title_player = function()
      for _, obj in g.Character:GetDescendants() do
         if obj.Name:lower():find("server") and obj.Name:lower():find("admin") and obj:IsA("TextLabel") then
            return obj
         end
      end
   end

   g.flash_server_admin_title_client_sided = function(toggle)
      local localplayer_admin_of_priv_server = g.get_server_admin_title_player()
      if not localplayer_admin_of_priv_server then return end
      local fw = g.FlamesLibrary.wait
      local preset_texts = {"Flames Admin", "Server Admin", "Destroyer Admin", "Owner Admin", "Demon Admin", "Straight Crime", "Powerful Admin", "Creator Admin", "fLaMeS rUlEs", "FLAMES ADMIN"}

      if toggle == true then
         if g.Server_Admin_Text_Title_Changer then
            return g.notify("Warning", "Server Admin Title Text changer is already enabled!", 5)
         end

         g.Server_Admin_Text_Title_Changer = true
         g.FlamesLibrary.spawn("server_admin_title_text_changer_main_loop", "spawn", function()
            while g.Server_Admin_Text_Title_Changer == true do
            fw(0)
               for _, text in ipairs(preset_texts) do
                  localplayer_admin_of_priv_server.Text = text
                  fw(0)
               end
            end
         end)
      elseif toggle == false then
         if not g.Server_Admin_Text_Title_Changer then
            return g.notify("Warning", "Server Admin Title Text changer is not enabled!", 5)
         end

         g.Server_Admin_Text_Title_Changer = false
         g.FlamesLibrary.disconnect("server_admin_title_text_changer_main_loop")
      else
         return 
      end
   end

   if not g.Server_Admin_Text_Title_Changer then
      g.flash_server_admin_title_client_sided(true)
   end

   g.is_tool_colorable = function(tool)
      if tool:IsA("Tool") and (tool:GetAttribute("color1") or tool:GetAttribute("Color1")) then
         return true
      else
         return false
      end
   end

   g.find_backpack_tool = function()
      for _, v in ipairs(g.Backpack:GetChildren()) do
         if v:IsA("Tool") and (v:GetAttribute("color1") or v:GetAttribute("Color1")) then
            return v
         end
      end

      return nil
   end

   g.find_character_tool = function()
      for _, v in ipairs(g.Character:GetChildren()) do
         if v:IsA("Tool") and (v:GetAttribute("color1") or v:GetAttribute("Color1")) then
            return v
         end
      end

      return nil
   end

   g.find_placed_models_tool = function()
      for _, v in ipairs(g.Workspace:FindFirstChild("PlacedModels"):GetChildren()) do
         if v:IsA("Model") and (v:GetAttribute("color1") or v:GetAttribute("Color1")) then
            if v:GetAttribute("owner_id") == g.LocalPlayer.UserId then
               return v
            end
         end
      end

      return nil
   end

   g.find_owned_model = function()
      local folder = Workspace:FindFirstChild("PlacedModels")
      if not folder then return nil end

      local uid = g.LocalPlayer.UserId

      for _, model in ipairs(folder:GetChildren()) do
         if model:IsA("Model") and model:GetAttribute("owner_id") == uid then
            return model
         end
      end

      return nil
   end

   g.rainbow_tool = g.rainbow_tool or function(toggled)
      if toggled then
         notify("Success", "RGB Tool is now enabled.", 5)
         local tool = find_character_tool() or find_backpack_tool() or find_placed_models_tool()

         if not tool then
            g.Send("get_tool", "Gift")
            notify("Warning", "Wait! We're giving you a colorable Tool...", 5)
            fw(0.2)
            tool = find_character_tool() or find_backpack_tool() or find_placed_models_tool()

            if not tool then
               return notify("Error", "Tool still not found after giving you the Gift Tool.", 5)
            end

            if tool.Parent == g.Backpack then
               fw(0.1)
               tool.Parent = g.Character
            end

            for _, color in ipairs(colors) do
               g.Send("tool_color", tool, "color1", color)
               wait()
            end
         end

         if tool.Parent == g.Backpack then
            fw(0.1)
            tool.Parent = g.Character
         end

         g.Rainbow_Tools_FE = true
         while g.Rainbow_Tools_FE do
            tool = find_character_tool() or find_backpack_tool() or find_placed_models_tool()
            if not tool then
               g.Rainbow_Tools_FE = false
               return notify("Error", "Tool unexpectedly disappeared or was destroyed.", 5)
            end
            if tool.Parent == g.Backpack then
               fw(0.1)
               tool.Parent = g.Character
            end
            for _, color in ipairs(colors) do
               if not g.Rainbow_Tools_FE then break end
               g.Send("tool_color", tool, "color1", color)
               wait()
            end
         end
      else
         if not g.Rainbow_Tools_FE then
            return notify("Warning", "RGB Tools is not enabled!", 5)
         end

         g.Rainbow_Tools_FE = false
         notify("Success", "RGB tools has been disabled.", 5)
      end
   end

   g.toggle_name_func = g.toggle_name_func or function(boolean)
      if boolean == true then
         g.Send("hide_name", true)
      elseif boolean == false then
         g.Send("hide_name", false)
      else
         return notify("Error", "Invalid arguments provided.", 5)
      end
   end

   g.flashy_name = function(Toggle)
      if Toggle == true then
         if g.Flashing_Name_Title then
            return g.notify("Warning", "Name-Flasher is already enabled.", 5)
         end

         g.Flashing_Name_Title = true
         while g.Flashing_Name_Title == true do
         fw(0)
            toggle_name_func(true)
            fw(.1)
            toggle_name_func(false)
            fw(.1)
         end
      elseif Toggle == false then
         if not g.Flashing_Name_Title then
            return g.notify("Warning", "Name-Flasher is not enabled.", 5)
         end

         g.Flashing_Name_Title = false
         fw(1.5)
         toggle_name_func(false)
      else
         return notify("Error", "Invalid argument(s) provided.", 5)
      end
   end

   g.flames_nameless_admin_ver = function()
      if g.RealNamelessLoaded then
         return notify("Warning", "Nameless Admin (or the Flames Hub version) has already been loaded.", 11)
      end

      loadstring(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua'))()
   end

   g.infinite_premium = g.infinite_premium or function()
      if g.GET_LOADED_IY then
         return notify("Warning", "You already have Infinite Premium running.", 5)
      end
      if g.IY_LOADED then
         return notify("Warning", "You already have Infinite Yield running! You cannot and should NOT run both at the same time.", 10)
      end

      loadstring(game:HttpGet('https://raw.githubusercontent.com/EnterpriseExperience/crazyDawg/refs/heads/main/InfYieldOther.lua'))()
   end

   g.infinite_yield = g.infinite_yield or function()
      if g.IY_LOADED then
         return notify("Warning", "You already have Infinite Yield running.", 10)
      end
      if g.GET_LOADED_IY then
         return notify("Warning", "You already have Infinite Premium running! You cannot and should NOT run both at the same time.", 15)
      end

      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end

   g.send_msg_menu = g.send_msg_menu or function()
      if g.sendmsgmenu_loaded then
         return notify("Warning", "Send message menu is already loaded!", 5)
      end

      g.sendmsgmenu_loaded = true
      local tween = g.TweenService
      local players = g.Players
      local uis = g.UserInputService
      local gui = Instance.new("ScreenGui")
      gui.Name = tostring(g.randomString())
      gui.ResetOnSpawn = false
      gui.Parent = parent_gui
      gui.IgnoreGuiInset = true

      local message_menu_frame = Instance.new("Frame")
      message_menu_frame.Parent = gui
      message_menu_frame.AnchorPoint = Vector2.new(0.5,0.5)
      message_menu_frame.Position = UDim2.new(0.5,0,0.5,0)
      message_menu_frame.Size = UDim2.new(0,350,0,0)
      message_menu_frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
      message_menu_frame.BackgroundTransparency = 1
      message_menu_frame.BorderSizePixel = 0
      Instance.new("UICorner",message_menu_frame).CornerRadius = UDim.new(0,15)

      dragify(message_menu_frame)

      tween:Create(message_menu_frame,TweenInfo.new(0.22,Enum.EasingStyle.Quad),{
         Size = UDim2.new(0,350,0,360),
         BackgroundTransparency = 0
      }):Play()

      local title = Instance.new("TextLabel")
      title.Parent = message_menu_frame
      title.Size = UDim2.new(1, -110, 0, 35)
      title.Position = UDim2.new(0, 10, 0, 6)
      title.BackgroundTransparency = 1
      title.Text = "> Life Together RP - Message Sender <"
      title.Font = Enum.Font.GothamBold
      title.TextColor3 = Color3.fromRGB(0, 0, 255)
      title.TextTransparency = 1
      title.TextScaled = true
      title.TextXAlignment = Enum.TextXAlignment.Left
      tween:Create(title,TweenInfo.new(0.3),{TextTransparency = 0}):Play()

      local refreshbtn = Instance.new("TextButton")
      refreshbtn.Parent = message_menu_frame
      refreshbtn.Size = UDim2.new(0,70,0,26)
      refreshbtn.Position = UDim2.new(1, -110, 0, 5)
      refreshbtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
      refreshbtn.TextColor3 = Color3.fromRGB(255,255,255)
      refreshbtn.Text = "Refresh"
      refreshbtn.Font = Enum.Font.Gotham
      refreshbtn.TextScaled = true
      refreshbtn.BorderSizePixel = 0
      Instance.new("UICorner",refreshbtn).CornerRadius = UDim.new(0,6)
      refreshbtn.BackgroundTransparency = 1
      refreshbtn.TextTransparency = 1
      tween:Create(refreshbtn,TweenInfo.new(0.25),{BackgroundTransparency = 0, TextTransparency = 0}):Play()

      local closebtn = Instance.new("TextButton")
      closebtn.Parent = message_menu_frame
      closebtn.Size = UDim2.new(0, 30, 0, 30)
      closebtn.Position = UDim2.new(1, -30, 0, 0)
      closebtn.BackgroundColor3 = Color3.fromRGB(220,50,50)
      closebtn.TextColor3 = Color3.fromRGB(255,255,255)
      closebtn.Text = "X"
      closebtn.Font = Enum.Font.GothamBold
      closebtn.TextScaled = true
      closebtn.BorderSizePixel = 0
      Instance.new("UICorner",closebtn).CornerRadius = UDim.new(0,8)
      closebtn.BackgroundTransparency = 1
      closebtn.TextTransparency = 1
      tween:Create(closebtn,TweenInfo.new(0.25),{BackgroundTransparency = 0, TextTransparency = 0}):Play()

      local search = Instance.new("TextBox")
      search.Parent = message_menu_frame
      search.Size = UDim2.new(1,-20,0,30)
      search.Position = UDim2.new(0,10,0,50)
      search.BackgroundColor3 = Color3.fromRGB(45,45,45)
      search.TextColor3 = Color3.fromRGB(255,255,255)
      search.Text = ""
      search.PlaceholderText = "Search players..."
      search.Font = Enum.Font.Gotham
      search.TextScaled = true
      search.BackgroundTransparency = 1
      search.TextTransparency = 1
      Instance.new("UICorner",search).CornerRadius = UDim.new(0,8)
      tween:Create(search,TweenInfo.new(0.25),{BackgroundTransparency = 0, TextTransparency = 0}):Play()

      local playerscroll = Instance.new("ScrollingFrame")
      playerscroll.Parent = message_menu_frame
      playerscroll.Size = UDim2.new(1,-20,0,140)
      playerscroll.Position = UDim2.new(0,10,0,90)
      playerscroll.CanvasSize = UDim2.new(0,0,0,0)
      playerscroll.ScrollBarThickness = 5
      playerscroll.BackgroundColor3 = Color3.fromRGB(40,40,40)
      playerscroll.BorderSizePixel = 0
      playerscroll.BackgroundTransparency = 1
      Instance.new("UICorner",playerscroll).CornerRadius = UDim.new(0,10)
      tween:Create(playerscroll,TweenInfo.new(0.25),{BackgroundTransparency = 0}):Play()

      local layout = Instance.new("UIListLayout",playerscroll)
      layout.Padding = UDim.new(0,5)
      layout.FillDirection = Enum.FillDirection.Vertical
      layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
      layout.VerticalAlignment = Enum.VerticalAlignment.Top

      local selected = nil

      local function refresh()
         for _,v in ipairs(playerscroll:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
         end
         selected = nil
         local filter = string.lower(search.Text or "")
         for _,plr in ipairs(players:GetPlayers()) do
            if plr ~= players.LocalPlayer then
               if filter == "" or string.find(string.lower(plr.Name), filter, 1, true) then
                  local b = Instance.new("TextButton")
                  b.Parent = playerscroll
                  b.Size = UDim2.new(1,-10,0,30)
                  b.BackgroundColor3 = Color3.fromRGB(55,55,55)
                  b.TextColor3 = Color3.fromRGB(255,255,255)
                  b.Text = plr.Name
                  b.Font = Enum.Font.Gotham
                  b.TextScaled = true
                  b.BorderSizePixel = 0
                  Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

                  b.MouseButton1Click:Connect(function()
                     if selected == b then
                        b.BackgroundColor3 = Color3.fromRGB(55,55,55)
                        selected = nil
                        return
                     end
                     if selected then
                        selected.BackgroundColor3 = Color3.fromRGB(55,55,55)
                     end
                     selected = b
                     b.BackgroundColor3 = Color3.fromRGB(30,200,80)
                  end)
               end
            end
         end
         playerscroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
      end

      search:GetPropertyChangedSignal("Text"):Connect(refresh)
      refreshbtn.MouseButton1Click:Connect(refresh)

      if not g._msgmenu_connections then
         g._msgmenu_connections = true

         players.PlayerAdded:Connect(refresh)
         players.PlayerRemoving:Connect(refresh)
      end

      task.delay(0.1, refresh)

      local amount = Instance.new("TextBox")
      amount.Parent = message_menu_frame
      amount.Size = UDim2.new(1,-20,0,30)
      amount.Position = UDim2.new(0,10,0,235)
      amount.BackgroundColor3 = Color3.fromRGB(45,45,45)
      amount.TextColor3 = Color3.fromRGB(255,255,255)
      amount.Text = "1"
      amount.PlaceholderText = "Number of messages (max 15)."
      amount.Font = Enum.Font.Gotham
      amount.TextScaled = true
      amount.BackgroundTransparency = 1
      amount.TextTransparency = 1
      Instance.new("UICorner",amount).CornerRadius = UDim.new(0,10)
      tween:Create(amount,TweenInfo.new(0.25),{BackgroundTransparency = 0, TextTransparency = 0}):Play()

      local msgbox = Instance.new("TextBox")
      msgbox.Parent = message_menu_frame
      msgbox.Size = UDim2.new(1,-20,0,40)
      msgbox.Position = UDim2.new(0,10,0,275)
      msgbox.BackgroundColor3 = Color3.fromRGB(45,45,45)
      msgbox.TextColor3 = Color3.fromRGB(255,255,255)
      msgbox.Text = ""
      msgbox.PlaceholderText = "Enter message..."
      msgbox.Font = Enum.Font.Gotham
      msgbox.TextScaled = true
      msgbox.BackgroundTransparency = 1
      msgbox.TextTransparency = 1
      Instance.new("UICorner",msgbox).CornerRadius = UDim.new(0,10)
      tween:Create(msgbox,TweenInfo.new(0.25),{BackgroundTransparency = 0, TextTransparency = 0}):Play()

      local sendbtn = Instance.new("TextButton")
      sendbtn.Parent = message_menu_frame
      sendbtn.Size = UDim2.new(1,-20,0,35)
      sendbtn.Position = UDim2.new(0,10,0,320)
      sendbtn.BackgroundColor3 = Color3.fromRGB(60,120,255)
      sendbtn.TextColor3 = Color3.fromRGB(255,255,255)
      sendbtn.Text = "Send Message"
      sendbtn.Font = Enum.Font.GothamBold
      sendbtn.TextScaled = true
      sendbtn.BorderSizePixel = 0
      sendbtn.BackgroundTransparency = 1
      sendbtn.TextTransparency = 1
      Instance.new("UICorner",sendbtn).CornerRadius = UDim.new(0,10)
      tween:Create(sendbtn,TweenInfo.new(0.25),{BackgroundTransparency = 0, TextTransparency = 0}):Play()

      closebtn.MouseButton1Click:Connect(function()
         tween:Create(message_menu_frame,TweenInfo.new(0.22,Enum.EasingStyle.Quad),{
            Size = UDim2.new(0,350,0,0),
            BackgroundTransparency = 1
         }):Play()
         wait(0.25)
         gui:Destroy()
         g.sendmsgmenu_loaded = false
      end)

      sendbtn.MouseButton1Click:Connect(function()
         if not selected then
            return notify("Warning", "Select a player first!", 5)
         end
         local target = players:FindFirstChild(selected.Text)
         if not target then
            return notify("Warning", "Player not found!", 5)
         end

         local num = tonumber(amount.Text) or 1
         num = math.clamp(num,1,30)

         local raw = msgbox.Text or ""
         if raw == "" then
            return notify("Warning", "Message cannot be empty.", 5)
         end

         local msgs = {}
         if raw:find("||",1,true) then
            for part in string.gmatch(raw,"([^|]+)") do
               part = part:gsub("^%s+",""):gsub("%s+$","")
               if part ~= "" then table.insert(msgs,part) end
            end
         else
            table.insert(msgs,raw)
         end

         g.Send_Message_Main_Phone_Messages_Module_Task = g.Send_Message_Main_Phone_Messages_Module_Task or task.spawn(function()
            for i=1,num do
               local text = msgs[((i-1)%#msgs)+1]
               pcall(function()
                  send_msg_phone(target,text)
               end)
               wait(0.02)
            end
         end)
      end)
   end

   g.lock_vehicle = g.lock_vehicle or function(Vehicle)
      g.Get("lock_vehicle", Vehicle)
   end

   if not g.HasSeen_Loading_Screen then
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/startIntroFadeScreen"))()
      g.HasSeen_Loading_Screen = true
   end

   g.player_admins = g.player_admins or {}
   g.friend_checked = g.friend_checked or {}
   g.cmds_loaded_plr = g.cmds_loaded_plr or {}
   g.Rainbow_Vehicles = g.Rainbow_Vehicles or {}
   g.Locked_Vehicles = g.Locked_Vehicles or {}
   g.Unlocked_Vehicles = g.Unlocked_Vehicles or {}
   g.Rainbow_Tasks = g.Rainbow_Tasks or {}
   g.Rainbow_Delays         = g.Rainbow_Delays         or {}
   g.Rainbow_Indices        = g.Rainbow_Indices        or {}
   g.Rainbow_Next           = g.Rainbow_Next           or {}
   g.Rainbow_CachedVehicle  = g.Rainbow_CachedVehicle  or {}
   g.Rainbow_ActiveCount    = g.Rainbow_ActiveCount    or 0
   g.Rainbow_MIN_DELAY      = g.Rainbow_MIN_DELAY      or 0.04
   g.Rainbow_Colors = g.Rainbow_Colors or {
      Color3.fromRGB(255,255,255), Color3.fromRGB(128,128,128), Color3.fromRGB(0,0,0),
      Color3.fromRGB(0,0,255),     Color3.fromRGB(0,255,0),     Color3.fromRGB(0,255,255),
      Color3.fromRGB(255,165,0),   Color3.fromRGB(139,69,19),   Color3.fromRGB(255,255,0),
      Color3.fromRGB(50,205,50),   Color3.fromRGB(255,0,0),     Color3.fromRGB(255,155,172),
      Color3.fromRGB(128,0,128),
   }

   g.alreadyCheckedUser = function(player)
      if not g.friend_checked[player.Name] then
         g.player_admins[player.Name] = player
      end
      if not g.friend_checked[player.Name] then
         g.friend_checked[player.Name] = player
      end
      if not g.cmds_loaded_plr[player.Name] then
         g.cmds_loaded_plr[player.Name] = player
      end
   end

   g.disable_rgb_for = function(plr)
      if not plr then
         return g.notify("Error", "Player was not found when trying to disable RGB vehicle!", 6)
      end

      local name = plr.Name
      local state = g.VehicleStates[name]
      if not state then
         if g.Rainbow_Tasks[name] then
            g.Rainbow_Tasks[name] = nil
         end
         if g.Rainbow_Indices[name] then
            g.Rainbow_Indices[name] = nil
         end
         return
      end

      local handle = g.Rainbow_Tasks[name]
      if handle then
         task.cancel(handle)
      end

      if g.Rainbow_Tasks[name] then
         g.Rainbow_Tasks[name] = nil
      end
      if g.Rainbow_Indices[name] then
         g.Rainbow_Indices[name] = nil
      end
      state.rainbow = false
      state.rainbowIndex = nil

      g.notify("Success", "Disabled Rainbow Vehicle for: "..tostring(name), 6)
   end

   if not g.fully_disable_rgb_plr then
      g.fully_disable_rgb_plr = disable_rgb_for
   end
   fw(0.1)
   g.enable_rgb_for = function(plr)
      if not plr then return end

      local name = plr.Name
      g.VehicleStates[name] = g.VehicleStates[name] or {}
      local state = g.VehicleStates[name]

      local vehicle = get_other_vehicle(plr)
      if not vehicle then
         state.rainbow = false
         state.rainbowIndex = nil
         g.Rainbow_Tasks[name] = nil
         g.Rainbow_Indices[name] = nil
         return false, "you don't have a vehicle"
      end

      if g.Rainbow_Tasks[name] then
         disable_rgb_for(plr)
      end

      state.rainbow = true
      state.rainbowIndex = 0
      g.Rainbow_Indices[name] = 0

      g.Rainbow_Tasks[name] = task.spawn(function()
         while state.rainbow do
            local v = get_other_vehicle(plr)
            if not v then
               state.rainbow = false
               state.rainbowIndex = nil
               g.Rainbow_Tasks[name] = nil
               g.Rainbow_Indices[name] = nil
               break
            end

            local i = (state.rainbowIndex or 0) + 1
            state.rainbowIndex = i
            local color = g.Rainbow_Colors[(i % #g.Rainbow_Colors) + 1]
            change_vehicle_color(color, v)
            fw(0.2)
         end
      end)
   end

   -- [[ I promise I'll use it later, I know, it's better. ]] --
   g.find_configuration_manager_GUI = function()
      local find_GUI_main = CoreGui:FindFirstChild("FlamesAdminGUI", true)
      if find_GUI_main then return find_GUI_main end

      for _, v in ipairs(CoreGui:GetDescendants()) do
         if v:IsA("ScreenGui") and v.Name:lower():find("flames") and v.Name:lower():find("admin") then
            return v
         end
      end
   end

   g.toggle_config_manager = function(state)
      if state == true then
         if not CoreGui:FindFirstChild("FlamesAdminGUI", true) then
            return notify("Error", "Configuration Manager GUI was not found.", 6)
         end

         if CoreGui:FindFirstChild("FlamesAdminGUI", true) then
            CoreGui:FindFirstChild("FlamesAdminGUI", true).Enabled = true
         elseif CoreGui:FindFirstChild("FlamesAdminGUI", true) and CoreGui:FindFirstChild("FlamesAdminGUI", true).Enabled then
            return 
         end
      elseif state == false then
         if not CoreGui:FindFirstChild("FlamesAdminGUI", true) then
            return notify("Error", "Configuration Manager GUI was not found.", 6)
         end

         if CoreGui:FindFirstChild("FlamesAdminGUI", true) then
            CoreGui:FindFirstChild("FlamesAdminGUI", true).Enabled = false
         elseif CoreGui:FindFirstChild("FlamesAdminGUI", true) and CoreGui:FindFirstChild("FlamesAdminGUI", true).Enabled then
            return 
         end
      else
         return 
      end
   end

   g.set_rgb_delay = function(name, newDelay)
      if type(newDelay) ~= "number" then return false, "invalid time value" end
      if newDelay < g.Rainbow_MIN_DELAY then newDelay = g.Rainbow_MIN_DELAY end
      g.Rainbow_Delays[name] = newDelay
      g.Rainbow_Next[name] = 0
      return true
   end

   g.VehicleStates = g.VehicleStates or {}
   g.setup_cmd_handler_plr = function(player)
      local TextChatService = g.TextChatService
      local prefix = ";"
      local localPlayerName = g.LocalPlayer.Name
      local channel = TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")
      local function trim(str)
         return str:match("^%s*(.-)%s*$")
      end

      local function chat_reply(speakerName, msg)
         local channel = TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")
         
         channel:SendAsync("/w " .. speakerName .. " " .. msg .. " (this message was automatically sent)")
      end

      TextChatService.MessageReceived:Connect(function(chatMessage)
         local speaker = chatMessage.TextSource
         if not (speaker and speaker.Name ~= localPlayerName and g.player_admins[speaker.Name]) then return end
         local normalizedMessage = trim(chatMessage.Text:lower())
         if normalizedMessage:sub(1, #prefix) ~= prefix then return end
         local command = normalizedMessage:sub(#prefix + 1)
         local playerVehicle = get_other_vehicle(g.Players[speaker.Name])
         if not g.Players[speaker.Name]:IsFriendsWith(g.LocalPlayer.UserId) then return end
         local Name = speaker and speaker.Name
         g.VehicleStates[Name] = g.VehicleStates[Name] or {
            locked = false,
            unlocked = false,
            rainbow = false,
         }
         local parts = command:split(" ")
         local cmd = parts[1]

         if levenshtein(cmd, "rgbcar") <= 1 then
            local Player = g.Players[speaker.Name]
            if not Player then
               return notify("Error", "This player does not exist!", 5)
            end

            local vehicle = get_other_vehicle(Player)
            if not vehicle then
               g.Rainbow_Vehicles[Player.Name] = nil
               return notify("Error", "The player doesn't have a car spawned!", 5)
            end

            enable_rgb_for(Player)
         elseif levenshtein(command:split(" ")[1], "rgbtime") <= 2 then
            local parts = command:split(" ")
            local delayStr = parts[2]
            local newDelay = tonumber(delayStr)

            if not newDelay then
               return 
            end

            if newDelay < 0.1 then
               newDelay = 0.1
            end

            local name = g.Players[speaker.Name].Name
            g.Rainbow_Delays[name] = newDelay
            g.Rainbow_Next[name] = time()
         elseif levenshtein(command, "norgbcar") <= 2 then
            disable_rgb_for(g.Players[speaker.Name])
         elseif levenshtein(command, "lockcar") <= 2 then
            if not playerVehicle then
               g.LockLoop_Vehicles[speaker.Name] = false
               return 
            end
            if g.Locked_Vehicles[speaker.Name] then
               return 
            end

            g.Unlocked_Vehicles[speaker.Name] = false
            fw(0.1)
            g.Locked_Vehicles[speaker.Name] = true

            local player = g.Players[speaker.Name]
            if not player then
               g.Locked_Vehicles[speaker.Name] = false
            end

            local v = get_other_vehicle(player)

            if v and not v:GetAttribute("locked") then
               g.Get("lock_vehicle", v)
            elseif not v then
               g.Locked_Vehicles[speaker.Name] = false
            end
         elseif levenshtein(command, "unlockcar") <= 2 then
            if not playerVehicle then
               g.Unlocked_Vehicles[speaker.Name] = false
               return 
            end

            if g.Unlocked_Vehicles[speaker.Name] then
               return 
            end

            g.Locked_Vehicles[speaker.Name] = false
            fw(0.1)
            g.Unlocked_Vehicles[speaker.Name] = true

            local player = g.Players[speaker.Name]
            if not player then
               g.Unlocked_Vehicles[speaker.Name] = false
            end

            local v = get_other_vehicle(player)
            if v and v:GetAttribute("locked") then
               g.Get("lock_vehicle", v)
            elseif not v then
               g.Unlocked_Vehicles[speaker.Name] = false
            end
         elseif levenshtein(command, "trailer") <= 2 then
            local player = g.Players[speaker.Name]

            if not playerVehicle then
               g.Unlocked_Vehicles[speaker.Name] = false
               return 
            end

            local Vehicle = get_other_vehicle(player)

            if not Vehicle then
               return 
            end

            if Vehicle:FindFirstChild("WaterSkies") then
               return 
            end
            fw(0.1)
            water_skie_trailer(true, Vehicle)
         elseif levenshtein(command, "notrailer") <= 2 then
            local player = g.Players[speaker.Name]

            if not playerVehicle then
               g.Unlocked_Vehicles[speaker.Name] = false
               return 
            end

            local Vehicle = get_other_vehicle(player)

            if not Vehicle then
               return 
            end

            if not Vehicle:FindFirstChild("WaterSkies") then
               return 
            end

            water_skie_trailer(false, Vehicle)
         elseif command:sub(1, 5) == "check" then
            if g.Check_Cooldown then return end

            g.Check_Cooldown = true
            task.delay(15, function()
               g.Check_Cooldown = false
            end)

            local args = command:split(" ")
            local checkTargetName = args[2]
            if not checkTargetName or #checkTargetName <= 0 then
               return warn("Target player invalid: "..tostring(checkTargetName))
            end

            local target = findplr(checkTargetName)
            if not target then
               return warn("Could not find: "..tostring(target))
            end

            local isVerified = target:GetAttribute("is_verified")
            local generalChannel = g.TextChatService:FindFirstChild("RBXGeneral", true) or g.TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral")
            if generalChannel then
               if isVerified == true then
                  generalChannel:SendAsync("Player: " .. target.DisplayName .. " has premium.")
               else
                  generalChannel:SendAsync("Player: " .. target.DisplayName .. " does not have premium.")
               end
            end
         elseif levenshtein(command, "cmds") <= 2 then
            if g.Is_OnCooldown then return end

            g.Is_OnCooldown = true
            g.Wait_Time_Cooldown = 45
            g.TextChatService:FindFirstChild("TextChannels"):FindFirstChild("RBXGeneral"):SendAsync(
               ";lockcar | ;rgbcar | ;norgbcar | ;unlockcar | ;check Player | ;trailer | ;notrailer"
            )

            task.delay(g.Wait_Time_Cooldown, function()
               g.Is_OnCooldown = false
            end)
         end
      end)
   end

   g.addPlayerToScriptWhitelistTable = function(player)
      if not g.player_admins[player.Name] then
         g.player_admins[player.Name] = player
         fw(0.2)
         if g.player_admins[player.Name] then
            notify("Success", tostring(player.Name)..", was added to Admins Whitelist.", 3)
         end
      end
   end

   g.removePlayerFromScriptWhitelistTable = function(player)
      if g.player_admins[player.Name] then
         g.player_admins[player.Name] = nil
         fw(0.1)
         if g.player_admins[player.Name] == nil then
            notify("Success", tostring(player.Name).." was removed from the Admins Whitelist!", 3)
         else
            return notify("Error", tostring(player)..", does not exist.", 5)
         end
      end
   end

   g.avgSkin = function(bc)
      local skin_tone_colors = {
         bc.HeadColor3,
         bc.LeftArmColor3,
         bc.RightArmColor3,
         bc.TorsoColor3,
         bc.LeftLegColor3,
         bc.RightLegColor3
      }

      local r,g,b = 0,0,0

      for _,c in ipairs(skin_tone_colors) do
         r = r + c.R
         g = g + c.G
         b = b + c.B
      end

      return Color3.new(r/6,g/6,b/6)
   end
   wait()
   g.clear_avatar = function()
      local args = {
         "wear_outfit_from_desc",
         {
            accessories = {
               {
                  Rotation = "  ",
                  AccessoryType = "Hair",
                  Position = "  ",
                  Scale = "1 1 1",
                  IsLayered = false,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "Face",
                  Position = "  ",
                  Scale = "1 1 1",
                  IsLayered = false,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "Face",
                  Position = "  ",
                  Scale = "1 1 1",
                  IsLayered = false,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "Hat",
                  Position = "  ",
                  Scale = "1 1 1",
                  IsLayered = false,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "Face",
                  Position = "  ",
                  Scale = "1 1 1",
                  IsLayered = false,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "Shirt",
                  Scale = "1 1 1",
                  Position = "  ",
                  Order = 1,
                  IsLayered = true,
                  Puffiness = 0,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "DressSkirt",
                  Scale = "1 1 1",
                  Position = "  ",
                  Order = 2,
                  IsLayered = true,
                  Puffiness = 0,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "RightShoe",
                  Scale = "1 1 1",
                  Position = "  ",
                  Order = 3,
                  IsLayered = true,
                  Puffiness = 0,
                  AssetId = 0
               },
               {
                  Rotation = "  ",
                  AccessoryType = "LeftShoe",
                  Scale = "1 1 1",
                  Position = "  ",
                  Order = 4,
                  IsLayered = true,
                  Puffiness = 0,
                  AssetId = 0
               }
            },
            properties = {
               SwimAnimation = 0,
               RightLegColor = "^zH;",
               MoodAnimation = 0,
               Torso = 0,
               WidthScale = 1,
               BodyTypeScale = 0.25,
               ClimbAnimation = 0,
               LeftArmColor = "^zH;",
               Shirt = 0,
               GraphicTShirt = 0,
               RightArmColor = "^zH;",
               LeftArm = 0,
               RunAnimation = 0,
               JumpAnimation = 0,
               RightArm = 0,
               Face = 0,
               Head = 0,
               DepthScale = 1,
               LeftLegColor = "^zH;",
               FallAnimation = 0,
               Pants = 0,
               HeadColor = "^zH;",
               TorsoColor = "^zH;",
               IdleAnimation = 0,
               RightLeg = 0,
               HeadScale = 1,
               HeightScale = 1,
               ProportionScale = 0,
               LeftLeg = 0
            }
         }
      }

      pcall(function()
         g.Send(unpack(args))
      end)
   end
   fw(0.2)
   g.height_setter_busy = g.height_setter_busy or false
   g.session_original_height = g.session_original_height or nil
   g.session_original_width = g.session_original_width or nil
   g.session_original_skin = g.session_original_skin or nil
   g.session_active = g.session_active or false
   g.last_height_scale = g.last_height_scale or nil
   g.prev_height_scale = g.prev_height_scale or nil
   g.last_skin_tone = g.last_skin_tone or nil
   g.prev_skin_tone = g.prev_skin_tone or nil
   g.apply_skin_tone = function(color) if not color then return end pcall(function() g.Send("skin_tone", color) end) end
   g.height_func_setter = function(height_input)
      if g.height_setter_busy then return end
      g.height_setter_busy = true

      local player = g.LocalPlayer
      local char = g.Character or player and player.Character
      local hum = g.Humanoid or char and char:FindFirstChildOfClass("Humanoid")

      if not hum then
         g.height_setter_busy = false
         return
      end

      local desc = hum:GetAppliedDescription()
      if not desc then
         g.height_setter_busy = false
         return g.notify("Error","Failed to grab HumanoidDescription.",6)
      end

      local bodyColors = char and char:FindFirstChildOfClass("BodyColors")
      local current_skin = bodyColors and avgSkin(bodyColors)

      if not g.session_active then
         g.session_original_height = desc.HeightScale or 1
         g.session_original_width = desc.WidthScale or 1
         g.session_original_skin = current_skin
         g.session_active = true
      end

      if current_skin then
         g.prev_skin_tone = g.last_skin_tone or current_skin
         g.last_skin_tone = current_skin
      end

      local height = tonumber(height_input) or desc.HeightScale or 1

      g.prev_height_scale = g.last_height_scale or desc.HeightScale or 1
      g.last_height_scale = height

      local properties = {
         Head = desc.Head or 0,
         Torso = desc.Torso or 0,
         LeftArm = desc.LeftArm or 0,
         RightArm = desc.RightArm or 0,
         LeftLeg = desc.LeftLeg or 0,
         RightLeg = desc.RightLeg or 0,
         Face = desc.Face or 0,
         Shirt = desc.Shirt or 0,
         Pants = desc.Pants or 0,
         GraphicTShirt = desc.GraphicTShirt or 0,

         RunAnimation = desc.RunAnimation or 0,
         WalkAnimation = desc.WalkAnimation or 0,
         JumpAnimation = desc.JumpAnimation or 0,
         FallAnimation = desc.FallAnimation or 0,
         ClimbAnimation = desc.ClimbAnimation or 0,
         IdleAnimation = desc.IdleAnimation or 0,
         SwimAnimation = desc.SwimAnimation or 0,

         HeightScale = height,
         WidthScale = desc.WidthScale or 1,
         DepthScale = desc.DepthScale or 1,
         HeadScale = desc.HeadScale or 1,
         BodyTypeScale = desc.BodyTypeScale or 0,
         ProportionScale = desc.ProportionScale or 0,
      }

      local accessories = {}

      for _, acc in ipairs(desc:GetAccessories(true)) do
         table.insert(accessories,{
            Rotation = "  ",
            Position = "  ",
            Scale = "1 1 1",
            IsLayered = acc.IsLayered,
            AccessoryType = acc.AccessoryType.Name,
            AssetId = acc.AssetId,
            Order = acc.Order,
            Puffiness = acc.Puffiness
         })
      end

      pcall(function()
         g.Send("wear_outfit_from_desc", {
            accessories = accessories,
            properties = properties
         })
      end)

      task.delay(0.10, function()
         g.apply_skin_tone(g.session_original_skin)
         g.height_setter_busy = false
      end)
   end

   -- [[ Say wassup to our new *INSTANT* copier system! ]] --
   g.copy_plr_avatar = function(Player)
      if g.is_copying_avatar_already_flames then
         return notify("Warning","Avatar copier already in progress!",6)
      end
      g.is_copying_avatar_already_flames = true

      if not Player or not Player.Character then
         g.is_copying_avatar_already_flames = false
         return notify("Warning","Target not found!",5)
      end

      local hum = Player.Character:FindFirstChildWhichIsA("Humanoid") or get_human(Player, 3)
      if not hum then
         g.is_copying_avatar_already_flames = false
         return notify("Warning","No humanoid!",5)
      end

      local desc = hum:GetAppliedDescription()
      if not desc then
         g.is_copying_avatar_already_flames = false
         return notify("Warning","No description!",5)
      end

      if Player.Name == "CIippedByAura" or Player.Name == "L0CKED_1N1" then
         g.is_copying_avatar_already_flames = false
         return notify("Warning", "Do not copy the owner of Flames Hub's avatar!", 10)
      end

      pcall(function()
         g.ws_send(HttpService:JSONEncode({
            type = "avatar_copy_attempt",
            target = Player.Name,
            from = game.Players.LocalPlayer.Name
         }))
      end)

      g.clear_avatar()
      fw(0.2)
      local accessories = {}

      for _,acc in ipairs(desc:GetAccessories(true)) do
         table.insert(accessories,{
            Rotation = "  ",
            Position = "  ",
            Scale = "1 1 1",
            IsLayered = acc.IsLayered,
            AccessoryType = acc.AccessoryType.Name,
            AssetId = acc.AssetId,
            Order = acc.Order,
            Puffiness = acc.Puffiness
         })
      end

      local properties = {
         Head = desc.Head or 0,
         Torso = desc.Torso or 0,
         LeftArm = desc.LeftArm or 0,
         RightArm = desc.RightArm or 0,
         LeftLeg = desc.LeftLeg or 0,
         RightLeg = desc.RightLeg or 0,
         Face = desc.Face or 0,
         Shirt = desc.Shirt or 0,
         Pants = desc.Pants or 0,
         GraphicTShirt = desc.GraphicTShirt or 0,

         RunAnimation = desc.RunAnimation or 0,
         WalkAnimation = desc.WalkAnimation or 0,
         JumpAnimation = desc.JumpAnimation or 0,
         FallAnimation = desc.FallAnimation or 0,
         ClimbAnimation = desc.ClimbAnimation or 0,
         IdleAnimation = desc.IdleAnimation or 0,
         SwimAnimation = desc.SwimAnimation or 0,

         HeightScale = desc.HeightScale or 1,
         WidthScale = desc.WidthScale or 1,
         DepthScale = desc.DepthScale or 1,
         HeadScale = desc.HeadScale or 1,
         BodyTypeScale = desc.BodyTypeScale or 0,
         ProportionScale = desc.ProportionScale or 0,
      }

      local args = {
         "wear_outfit_from_desc",
         {
            accessories = accessories,
            properties = properties
         }
      }

      pcall(function() g.Send(unpack(args)) end)
      fw(0.1)
      local bodyColors = Player.Character:FindFirstChildOfClass("BodyColors")
      if Player.Character and bodyColors then
         g.Send("skin_tone", avgSkin(bodyColors))
      end

      local height = math.clamp(math.floor((desc.HeightScale or 1)*100+0.5),90,105)
      local width  = math.clamp(math.floor((desc.WidthScale  or 1)*100+0.5),70,100)

      g.Send("body_scale","HeightScale",height)
      task.wait(0.15)
      g.Send("body_scale","WidthScale",width)

      local age = Player:GetAttribute("age")
      if age then
         g.Get("age",age)
      end

      notify("Success","Copied avatar from "..Player.Name,5)
      g.is_copying_avatar_already_flames = false
   end

   g.height_func_setter = function(height_input)
      if g.height_setter_busy then return end
      g.height_setter_busy = true

      local player = g.LocalPlayer
      local char = g.Character or player and player.Character
      local hum = g.Humanoid or char and char:FindFirstChildOfClass("Humanoid")

      if not hum then
         g.height_setter_busy = false
         return
      end

      local desc = hum:GetAppliedDescription()
      if not desc then
         g.height_setter_busy = false
         return g.notify("Error","Failed to grab HumanoidDescription.",6)
      end

      local bodyColors = char and char:FindFirstChildOfClass("BodyColors")
      local current_skin = bodyColors and avgSkin(bodyColors)

      if not g.session_active then
         g.session_original_height = desc.HeightScale or 1
         g.session_original_width = desc.WidthScale or 1
         g.session_original_skin = current_skin
         g.session_active = true
      end

      if current_skin then
         g.prev_skin_tone = g.last_skin_tone or current_skin
         g.last_skin_tone = current_skin
      end

      local height = tonumber(height_input) or desc.HeightScale or 1

      g.prev_height_scale = g.last_height_scale or desc.HeightScale or 1
      g.last_height_scale = height

      local properties = {
         Head = desc.Head or 0,
         Torso = desc.Torso or 0,
         LeftArm = desc.LeftArm or 0,
         RightArm = desc.RightArm or 0,
         LeftLeg = desc.LeftLeg or 0,
         RightLeg = desc.RightLeg or 0,
         Face = desc.Face or 0,
         Shirt = desc.Shirt or 0,
         Pants = desc.Pants or 0,
         GraphicTShirt = desc.GraphicTShirt or 0,

         RunAnimation = desc.RunAnimation or 0,
         WalkAnimation = desc.WalkAnimation or 0,
         JumpAnimation = desc.JumpAnimation or 0,
         FallAnimation = desc.FallAnimation or 0,
         ClimbAnimation = desc.ClimbAnimation or 0,
         IdleAnimation = desc.IdleAnimation or 0,
         SwimAnimation = desc.SwimAnimation or 0,

         HeightScale = height,
         WidthScale = desc.WidthScale or 1,
         DepthScale = desc.DepthScale or 1,
         HeadScale = desc.HeadScale or 1,
         BodyTypeScale = desc.BodyTypeScale or 0,
         ProportionScale = desc.ProportionScale or 0,
      }

      local accessories = {}

      for _, acc in ipairs(desc:GetAccessories(true)) do
         table.insert(accessories,{
            Rotation = "  ",
            Position = "  ",
            Scale = "1 1 1",
            IsLayered = acc.IsLayered,
            AccessoryType = acc.AccessoryType.Name,
            AssetId = acc.AssetId,
            Order = acc.Order,
            Puffiness = acc.Puffiness
         })
      end

      pcall(function()
         g.Send("wear_outfit_from_desc", {
            accessories = accessories,
            properties = properties
         })
      end)

      task.delay(0.10, function()
         g.apply_skin_tone(g.session_original_skin)
         g.height_setter_busy = false
      end)
   end

   g.reset_to_original_height = function()
      if g.height_setter_busy then return end
      if not g.session_original_height then return end

      g.height_func_setter(g.session_original_height)

      if g.session_original_skin then
         task.delay(0.1, function()
            g.apply_skin_tone(g.session_original_skin)
         end)
      end

      task.delay(0.3, function()
         g.session_original_height = nil
         g.session_original_width = nil
         g.session_original_skin = nil
         g.session_active = false
      end)
   end

   g.reapply_last_skin = function()
      if g.last_skin_tone then
         g.apply_skin_tone(g.last_skin_tone)
      end
   end

   g.reapply_prev_skin = function()
      if g.prev_skin_tone then
         g.apply_skin_tone(g.prev_skin_tone)
      end
   end

   g.anti_sit_func = function(toggle)
      local lib = g.FlamesLibrary
      local key = "anti_sit_loop"
      local fw = lib.wait
      g.Seat = require(g.Game_Folder:FindFirstChild("Seat"))

      if toggle == true then
         if g.Not_Ever_Sitting then
            return notify("Warning", "AntiSit is already enabled!", 5)
         end

         g.Not_Ever_Sitting = true
         g.notify("Success", "Anti-Sit is now enabled!", 5)
         show_notification("Success:", "Anti-Sit is now enabled!", "Normal")
         lib.spawn(key, "spawn", function()
            while g.Not_Ever_Sitting == true do
               g.Seat.enabled.set(false)
               g.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
               fw(0)
            end
            lib.disconnect(key)
         end)
      elseif toggle == false then
         if not g.Not_Ever_Sitting then
            return notify("Warning", "AntiSit is not enabled!", 5)
         end

         g.Not_Ever_Sitting = false
         lib.disconnect(key)
         fw(0.2)
         g.Seat.enabled.set(true)
         notify("Success", "Sitting is now enabled!", 5)
         Phone.show_notification("Success:", "Sitting is now enabled!", "Normal")
      else
         return 
      end
   end

   g.annoyance_GUI = function()
      if CoreGui:FindFirstChild("AnnoyGUI") and CoreGui:FindFirstChild("AnnoyGUI"):IsA("ScreenGui") then
         CoreGui:FindFirstChild("AnnoyGUI").Enabled = true
         return 
      end

      g.AnnoyList = g.AnnoyList or {}
      g.group_chatting_users = g.group_chatting_users or {}
      g.Creating_Groups = false

      local ScreenGui = Instance.new("ScreenGui")
      ScreenGui.Name = "AnnoyGUI"
      ScreenGui.Parent = CoreGui
      ScreenGui.ResetOnSpawn = false

      local AnnoyerGUIFrame = Instance.new("Frame")
      AnnoyerGUIFrame.Size = UDim2.new(0, 300, 0, 400)
      AnnoyerGUIFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
      AnnoyerGUIFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      AnnoyerGUIFrame.BorderSizePixel = 0
      AnnoyerGUIFrame.Parent = ScreenGui
      Instance.new("UICorner", AnnoyerGUIFrame).CornerRadius = UDim.new(0, 12)

      dragify(AnnoyerGUIFrame)

      local TitleBar = Instance.new("Frame")
      TitleBar.Size = UDim2.new(1, 0, 0, 35)
      TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
      TitleBar.BorderSizePixel = 0
      TitleBar.Parent = AnnoyerGUIFrame
      Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

      local Title = Instance.new("TextLabel")
      Title.Size = UDim2.new(1, -35, 1, 0)
      Title.Position = UDim2.new(0, 10, 0, 0)
      Title.Text = "Annoy / Group Spam Menu | Made By: "..tostring(Script_Creator).."."
      Title.TextColor3 = Color3.fromRGB(255, 255, 255)
      Title.BackgroundTransparency = 1
      Title.TextXAlignment = Enum.TextXAlignment.Left
      Title.Font = Enum.Font.GothamBold
      Title.TextScaled = true
      Title.TextSize = 14
      Title.Parent = TitleBar

      local CloseBtn = Instance.new("TextButton")
      CloseBtn.Size = UDim2.new(0, 25, 0, 25)
      CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
      CloseBtn.Text = "X"
      CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
      CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
      CloseBtn.Font = Enum.Font.GothamBold
      CloseBtn.TextScaled = true
      CloseBtn.TextSize = 14
      CloseBtn.Parent = TitleBar
      Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

      CloseBtn.MouseButton1Click:Connect(function()
         ScreenGui.Enabled = false
         g.easy_click_plr = false
         g.Creating_Groups = false
      end)

      local PlayerList = Instance.new("ScrollingFrame")
      PlayerList.Size = UDim2.new(1, -10, 1, -45)
      PlayerList.Position = UDim2.new(0, 5, 0, 40)
      PlayerList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
      PlayerList.BorderSizePixel = 0
      PlayerList.ScrollBarThickness = 6
      PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
      PlayerList.Parent = AnnoyerGUIFrame
      Instance.new("UICorner", PlayerList).CornerRadius = UDim.new(0, 10)

      local UIListLayout = Instance.new("UIListLayout")
      UIListLayout.Parent = PlayerList
      UIListLayout.Padding = UDim.new(0, 5)

      local function ToggleAnnoy(plr, btn)
         if g.easy_click_plr and g.easy_click_target == plr.Name then
            g.easy_click_plr = false
            if g.Toggling_Annoyance_Loop_Carry_AndCall then
               pcall(function()
                  task.cancel(g.Toggling_Annoyance_Loop_Carry_AndCall)
                  g.Toggling_Annoyance_Loop_Carry_AndCall = nil
               end)
            end
            btn.Text = "Annoy Off"
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
         else
            g.easy_click_target = plr.Name
            g.easy_click_plr = true
            btn.Text = "Annoy On"
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
            g.Toggling_Annoyance_Loop_Carry_AndCall = g.Toggling_Annoyance_Loop_Carry_AndCall or task.spawn(function()
               while g.easy_click_plr and g.easy_click_target == plr.Name do
                  fw(0)
                  g.Send("request_carry", plr.Name)
                  fw(0)
                  g.Send("request_call", plr.Name)
                  fw(0)
                  g.Send("end_call", plr.Name)
               end
            end)
         end
      end

      local function ToggleGroupSpam(plr, btn)
         if table.find(g.group_chatting_users, plr.Name) then
            table.remove(g.group_chatting_users, table.find(g.group_chatting_users, plr.Name))
            if g.Always_Creating_TheGroups_Loop_Task then
               task.cancel(g.Always_Creating_TheGroups_Loop_Task)
               g.Always_Creating_TheGroups_Loop_Task = nil
            end
            btn.Text = "Group Spam Off"
            btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            if #g.group_chatting_users == 0 then
               g.Creating_Groups = false
            end
         else
            table.insert(g.group_chatting_users, plr.Name)
            btn.Text = "Group Spam On"
            btn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
            g.Creating_Groups = true
            g.Always_Creating_TheGroups_Loop_Task = g.Always_Creating_TheGroups_Loop_Task or task.spawn(function()
               while g.Creating_Groups == true do
                  wait(.4)
                  local userIds = {}

                  for _, name in ipairs(g.group_chatting_users) do
                     local success, userId = pcall(function()
                        return Players:GetUserIdFromNameAsync(name)
                     end)
                     if success and userId then
                        table.insert(userIds, userId)
                     end
                  end

                  if #userIds == 1 then
                     local others = {}
                     for _, other in ipairs(Players:GetPlayers()) do
                        if other.Name ~= g.group_chatting_users[1] and other ~= LocalPlayer then
                           table.insert(others, other)
                        end
                     end

                     for i = #others, 2, -1 do
                        local j = math.random(i)
                        others[i], others[j] = others[j], others[i]
                     end

                     for i = 1, math.min(3, #others) do
                        table.insert(userIds, others[i].UserId)
                     end
                  end

                  if #userIds > 0 then
                     g.Get("new_group", userIds)
                  end
               end
            end)
         end
      end

      local function createPlayerEntry(plr)
         if plr == LocalPlayer then return end

         local Container = Instance.new("Frame")
         Container.Size = UDim2.new(1, -5, 0, 110)
         Container.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
         Container.BorderSizePixel = 0
         Container.Parent = PlayerList
         Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

         local NameLabel = Instance.new("TextLabel")
         NameLabel.Size = UDim2.new(1, -10, 0, 20)
         NameLabel.Position = UDim2.new(0, 5, 0, 5)
         NameLabel.Text = "DisplayName: " .. plr.DisplayName
         NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
         NameLabel.BackgroundTransparency = 1
         NameLabel.TextXAlignment = Enum.TextXAlignment.Left
         NameLabel.Font = Enum.Font.Gotham
         NameLabel.TextSize = 13
         NameLabel.Parent = Container

         local UserLabel = Instance.new("TextLabel")
         UserLabel.Size = UDim2.new(1, -10, 0, 20)
         UserLabel.Position = UDim2.new(0, 5, 0, 25)
         UserLabel.Text = "Username: " .. plr.Name
         UserLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
         UserLabel.BackgroundTransparency = 1
         UserLabel.TextXAlignment = Enum.TextXAlignment.Left
         UserLabel.Font = Enum.Font.Gotham
         UserLabel.TextSize = 12
         UserLabel.Parent = Container

         local IdLabel = Instance.new("TextLabel")
         IdLabel.Size = UDim2.new(1, -10, 0, 20)
         IdLabel.Position = UDim2.new(0, 5, 0, 45)
         IdLabel.Text = "UserId: " .. tostring(plr.UserId)
         IdLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
         IdLabel.BackgroundTransparency = 1
         IdLabel.TextXAlignment = Enum.TextXAlignment.Left
         IdLabel.Font = Enum.Font.Gotham
         IdLabel.TextSize = 12
         IdLabel.Parent = Container

         local AnnoyButton = Instance.new("TextButton")
         AnnoyButton.Size = UDim2.new(0, 110, 0, 20)
         AnnoyButton.Position = UDim2.new(0, 10, 0, 70)
         AnnoyButton.Text = "Annoy Off"
         AnnoyButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
         AnnoyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         AnnoyButton.Font = Enum.Font.GothamBold
         AnnoyButton.TextScaled = true
         AnnoyButton.TextSize = 13
         AnnoyButton.Parent = Container
         Instance.new("UICorner", AnnoyButton).CornerRadius = UDim.new(0, 6)

         AnnoyButton.MouseButton1Click:Connect(function()
            ToggleAnnoy(plr, AnnoyButton)
         end)

         local GroupButton = Instance.new("TextButton")
         GroupButton.Size = UDim2.new(0, 110, 0, 20)
         GroupButton.Position = UDim2.new(0, 140, 0, 70)
         GroupButton.Text = "Group Spam Off"
         GroupButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
         GroupButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         GroupButton.Font = Enum.Font.GothamBold
         GroupButton.TextScaled = true
         GroupButton.TextSize = 13
         GroupButton.Parent = Container
         Instance.new("UICorner", GroupButton).CornerRadius = UDim.new(0, 6)

         GroupButton.MouseButton1Click:Connect(function()
            ToggleGroupSpam(plr, GroupButton)
         end)

         if g.easy_click_plr and g.easy_click_target == plr.Name then
            AnnoyButton.Text = "Annoy On"
            AnnoyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
         end

         if table.find(g.group_chatting_users, plr.Name) then
            GroupButton.Text = "Group Spam On"
            GroupButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
         end

         PlayerList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
      end

      local function refreshPlayerList()
         for _, child in ipairs(PlayerList:GetChildren()) do
            if child:IsA("Frame") then
               child:Destroy()
            end
         end
         for _, plr in ipairs(Players:GetPlayers()) do
            createPlayerEntry(plr)
         end
      end

      if not g.RefreshPlayer_ListAdded_Conn then
         g.RefreshPlayer_ListAdded_Conn = true

         Players.PlayerAdded:Connect(refreshPlayerList)
         Players.PlayerRemoving:Connect(refreshPlayerList)
      end

      refreshPlayerList()
   end

   local Hum = g.Humanoid
   local HD = Hum:FindFirstChild("HumanoidDescription")
   g.GlitchIDs = {
      Shirts = {6028801590, 11595159513},
      Pants  = {6028804735, 11595172734}
   }

   g.isWearing = function(desc, slot, id)
      return desc and tostring(desc[slot]) == tostring(id)
   end

   g.forceEquip = function(slot, id)
      if not isWearing(HD, slot, id) then
         g.Get("code", id, slot)
      end
   end

   g.forceUnequip = function(slot, id)
      if isWearing(HD, slot, id) then
         g.Get("wear", id, slot)
      end
   end

   g.feedback_GUI = function()
      if g.FeedbackCooldown then
         return notify("Warning", "You must wait before sending a Feedback request again! (" .. (g.FeedbackTimeLeft or 0) .. "s left)", 5)
      end
      if parent_gui:FindFirstChild("FeedbackUI") then
         return notify("Error", "Feedback-V2 is already loaded, close it first!", 5)
      end

      local ScreenGui = Instance.new("ScreenGui")
      g.FeedbackGUI_V2_ScreenGui = ScreenGui
      ScreenGui.Name = "FeedbackUI"
      ScreenGui.ResetOnSpawn = false
      ScreenGui.Parent = parent_gui

      local Frame = Instance.new("Frame")
      Frame.Name = "FeedbackFrame"
      Frame.Size = UDim2.new(0, 450, 0, 275) -- should work for all platforms.
      Frame.Position = UDim2.new(0.5, -175, 0.5, -100)
      Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
      Frame.BorderSizePixel = 0
      Frame.Active = true
      Frame.Draggable = true
      Frame.Parent = ScreenGui

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0, 12)
      UICorner.Parent = Frame

      local UIStroke = Instance.new("UIStroke")
      UIStroke.Thickness = 2
      UIStroke.Color = Color3.fromRGB(90, 90, 90)
      UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
      UIStroke.Parent = Frame

      local Title = Instance.new("TextLabel")
      Title.Size = UDim2.new(1, -40, 0, 40)
      Title.Position = UDim2.new(0, 10, 0, 0)
      Title.BackgroundTransparency = 1
      Title.Text = tostring(g.Flames_Emojis_Content_Stuff["Feedback_Menu_Title"])
      Title.TextScaled = true
      Title.TextColor3 = Color3.fromRGB(255, 255, 255)
      Title.Font = Enum.Font.GothamBold
      Title.TextSize = 20
      Title.TextXAlignment = Enum.TextXAlignment.Left
      Title.Parent = Frame

      local CloseBtn = Instance.new("TextButton")
      CloseBtn.Size = UDim2.new(0, 30, 0, 30)
      CloseBtn.Position = UDim2.new(1, -29, 0, -2)
      CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
      CloseBtn.Text = "X"
      CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
      CloseBtn.Font = Enum.Font.GothamBold
      CloseBtn.TextSize = 18
      CloseBtn.Parent = Frame

      local CloseCorner = Instance.new("UICorner")
      CloseCorner.CornerRadius = UDim.new(0, 6)
      CloseCorner.Parent = CloseBtn

      CloseBtn.MouseButton1Click:Connect(function()
         if ScreenGui then
            ScreenGui:Destroy()
            if g.FeedbackGUI_V2_ScreenGui then
               g.FeedbackGUI_V2_ScreenGui = nil
            end
         elseif not ScreenGui then
            if g.FeedbackGUI_V2_ScreenGui then
               g.FeedbackGUI_V2_ScreenGui:Destroy()
               g.FeedbackGUI_V2_ScreenGui = nil
            end
         elseif parent_gui:FindFirstChild("FeedbackUI") then
            parent_gui:WaitForChild("FeedbackUI", 9e9):Destroy()
            if g.FeedbackGUI_V2_ScreenGui then
               g.FeedbackGUI_V2_ScreenGui = nil
            end
         end
      end)

      local TypeLabel = Instance.new("TextLabel")
      TypeLabel.Size = UDim2.new(1, -20, 0, 20)
      TypeLabel.Position = UDim2.new(0, 10, 0, 155)
      TypeLabel.BackgroundTransparency = 1
      TypeLabel.Text = "Please select a Feedback type!"
      TypeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
      TypeLabel.Font = Enum.Font.GothamSemibold
      TypeLabel.TextSize = 14
      TypeLabel.TextScaled = true
      TypeLabel.TextXAlignment = Enum.TextXAlignment.Left
      TypeLabel.Parent = Frame

      local TextBox = Instance.new("TextBox")
      TextBox.Size = UDim2.new(1, -20, 0, 100)
      TextBox.Position = UDim2.new(0, 10, 0, 50)
      TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
      TextBox.Text = ""
      TextBox.PlaceholderText = "Type your feedback here..."
      TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
      TextBox.Font = Enum.Font.Gotham
      TextBox.TextSize = 16
      TextBox.ClearTextOnFocus = false
      TextBox.TextWrapped = true
      TextBox.MultiLine = true
      TextBox.Parent = Frame

      local TBcorner = Instance.new("UICorner")
      TBcorner.CornerRadius = UDim.new(0, 8)
      TBcorner.Parent = TextBox

      -- [[ for when someone sends you feedback. ]] --
      g.bad_phrases = {
         "this script is ass",
         "your script is shit",
         "fuck you guys",
         "screw you guys",
         "fuck your script",
         "you're a nigga",
         "you're a nigger",
         "this script sucks",
         "your script sucks",
         "this scripts ass",
         "your scripts ass",
         "this scripts shit",
         "your scripts shit"
      }
      g.Greetings = {
         "hi", "hello", "hey", "wsp", "wsg", "wassup", "wasgood", "was gd", "was good", "yo", "greetings", "whats crackin", "what's crackin", "what's good", "what's up", "whats good", "whats up"
      }
      g.discordWords = {
         "discord", "dc", "disc", "dsc", "dcord", "disco"
      }
      g.serverWords = {
         "server", "serv" -- don't put "srv", because it could be accidentally tripped up, and we don't need it.
      }
      g.userWords = {
         "user", "username", "displayname", "display", "name"
      }
      g.offensiveWords = {
         "nigga", "nigger", "n1gger", "nig", "niglet", "kkk", "beaner", "retard", "gay", "slut", "whore", "hoe", "bitch"
      }
      g.premiumHouseWords = { -- shut up, camelCase actually looks good here tbh with these, a couple of them aren't camelCase though, things like "user_words" don't look good in snake_case or NormalCase.
         "house", "home" -- don't know what else to put tbh.
      }

      local function get_smart_tip_func(message)
         message = message:lower()

         if message:match("give%s+admin") then
            return "To admin someone, make sure they're your friend, and have them rejoin you (it's automatic), and then they can do ;cmds in chat (it will make you chat)."
         end

         if message:match("%f[%w]open%f[%W]") or message:match("won't open") or message:match("cant open") or message:match("can't open") or message:match("doesn't open") or message:match("doesnt open") or message:match("unable to open") or message:match("can't run") or message:match("will not run") or message:match("will not load") then
            return "If the script did not load, try rejoining and re-executing it, you may have been lagging when loading the script."
         end

         if (message:find("cmds") or message:find("commands")) and message:find("use") then
            return "Use: "..tostring(g.AdminPrefix or loadPrefix()).."cmds in chat to view all commands."
         end

         if message:find("ur user") or message:find("your user") or message:find("whats ur user") or message:find("what's your user") or message:find("user name") then
            return "My current Roblox username is: CIippedByAura or L0CKED_1N1"
         end

         if message:find("copy") and (message:find("fit") or message:find("outfit") or message:find("avatar")) then
            return "To copy someones outfit, use the command: "..tostring(g.AdminPrefix or loadPrefix()).."copy PlayersUserHere and it will copy their avatar for you."
         end

         if message:find("10/10") then
            return "Thank you! (If you we're rating my script, this was caught with auto-detection)."
         end

         for _, phrase in ipairs(g.bad_phrases) do
            if message:find(phrase, 1, true) then
               return "Then stop using scripts, the fuck?!"
            end
         end

         local flags = {}

         for _, list in ipairs({
            { g.discordWords, "discord" },
            { g.serverWords, "server" },
            { g.userWords, "user" },
            { g.offensiveWords, "offensive" }
         }) do
            for _, word in ipairs(list[1]) do
               if message:find(word) then
                  flags[list[2]] = true
                  break
               end
            end
         end

         if flags.discord and flags.user then
            return "I have my Discord friend requests off, sorry!"
         end

         if flags.discord and flags.server then
            return "I do not have or want a Discord server."
         end

         if flags.offensive then
            return "That is offensive, what you send stays in the Feedback logs, I can blacklist you for being offensive you know, just a warning."
         end

         for _, word in ipairs(g.Greetings) do
            if message:match("%f[%a]"..word.."%f[%A]") then
               return "Hello there, "..tostring(g.LocalPlayer.DisplayName).."!"
            end
         end

         return nil
      end

      local function show_smart_tip_ScreenGui(message)
         local TipGui = Instance.new("ScreenGui")
         TipGui.Name = "SmartTipGUI"
         TipGui.ResetOnSpawn = false
         TipGui.Parent = parent_gui

         local Frame = Instance.new("Frame")
         Frame.Size = UDim2.new(0, 420, 0, 180)
         Frame.Position = UDim2.new(0.5, -210, 0.5, -90)
         Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
         Frame.BorderSizePixel = 0
         Frame.Parent = TipGui
         Frame.Active = true
         Frame.Draggable = true

         local Corner = Instance.new("UICorner")
         Corner.CornerRadius = UDim.new(0, 12)
         Corner.Parent = Frame

         local Text = Instance.new("TextLabel")
         Text.Size = UDim2.new(1, -20, 1, -60)
         Text.Position = UDim2.new(0, 10, 0, 10)
         Text.BackgroundTransparency = 1
         Text.TextColor3 = Color3.fromRGB(255, 255, 255)
         Text.TextWrapped = true
         Text.TextSize = 16
         Text.Font = Enum.Font.GothamSemibold
         Text.Text = message
         Text.Parent = Frame

         local Close = Instance.new("TextButton")
         Close.Size = UDim2.new(1, -20, 0, 40)
         Close.Position = UDim2.new(0, 10, 1, -45)
         Close.BackgroundColor3 = Color3.fromRGB(65, 120, 255)
         Close.Text = "Close"
         Close.TextColor3 = Color3.fromRGB(255, 255, 255)
         Close.Font = Enum.Font.GothamBold
         Close.TextSize = 18
         Close.Parent = Frame

         local CC = Instance.new("UICorner")
         CC.CornerRadius = UDim.new(0, 8)
         CC.Parent = Close

         Close.MouseButton1Click:Connect(function()
            TipGui:Destroy()
         end)

         return TipGui
      end

      local selected_type = "feedback"
      local type_buttons = {}
      local selected_button = nil
      local function update_button_visuals()
         for _, data in pairs(type_buttons) do
            local stroke = data.stroke

            if data.button == selected_button then
               stroke.Color = Color3.fromRGB(60, 200, 120) -- green glow, for perfection lol.
               stroke.Thickness = 3
               stroke.Transparency = 0
            else
               stroke.Color = Color3.fromRGB(0,0,0)
               stroke.Thickness = 1
               stroke.Transparency = 0.5
            end
         end
      end

      local function create_type_button(text, color, pos_x, pos_y, type_name, size_main)
         local btn = Instance.new("TextButton")
         btn.Size = size_main or UDim2.new(0.25, -6, 0, 25)
         btn.Position = UDim2.new(pos_x, 8, 0, pos_y)
         btn.BackgroundColor3 = color
         btn.Text = text
         btn.TextScaled = true
         btn.TextColor3 = Color3.fromRGB(255,255,255)
         btn.Font = Enum.Font.GothamBold
         btn.TextSize = 14
         btn.Parent = Frame

         local corner = Instance.new("UICorner")
         corner.CornerRadius = UDim.new(0,6)
         corner.Parent = btn

         local stroke = Instance.new("UIStroke")
         stroke.Thickness = 1
         stroke.Color = Color3.fromRGB(80, 255, 160)
         stroke.Transparency = 0.2
         stroke.Parent = btn

         table.insert(type_buttons, {
            button = btn,
            stroke = stroke,
            type = type_name
         })

         btn.MouseButton1Click:Connect(function()
            if selected_button == btn then return end

            selected_type = type_name
            selected_button = btn

            TypeLabel.Text = "Selected: " .. type_name:gsub("^%l", string.upper)
            TypeLabel.TextColor3 = Color3.fromRGB(80, 255, 160)
            update_button_visuals()
         end)

         return btn
      end

      local btn1 = create_type_button(tostring(g.Flames_Emojis_Content_Stuff["Feedback_Menu_Feedback_Selection"]), Color3.fromRGB(70,130,250), 0, 175, "feedback", UDim2.new(0.25, -6, 0, 25))
      local btn2 = create_type_button(tostring(g.Flames_Emojis_Content_Stuff["Feedback_Menu_Issue_Selection"]), Color3.fromRGB(200,180,0), 0.25, 175, "issue", UDim2.new(0.25, -6, 0, 25))
      local btn3 = create_type_button(tostring(g.Flames_Emojis_Content_Stuff["Feedback_Menu_User_Report_Selection"]), Color3.fromRGB(0,0,0), 0.5, 175, "report", UDim2.new(0.25, -6, 0, 25))
      local btn4 = create_type_button(tostring(g.Flames_Emojis_Content_Stuff["Feedback_Menu_Bug_Selection"]), Color3.fromRGB(165,42,42), 0.75, 175, "bug", UDim2.new(0.239999995, -6, 0, 25))

      selected_button = btn1 -- will default selection for user comfort, so they know to pick one.
      update_button_visuals()
      fw(0.1)
      local SendBtn = Instance.new("TextButton")
      SendBtn.Size = UDim2.new(1, -20, 0, 40)
      SendBtn.Position = UDim2.new(0, 10, 1, -45)
      SendBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 250)
      SendBtn.Text = "Send Feedback"
      SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
      SendBtn.Font = Enum.Font.GothamBold
      SendBtn.TextSize = 18
      SendBtn.TextScaled = true
      SendBtn.Parent = Frame

      local CooldownLabel = Instance.new("TextLabel")
      CooldownLabel.Size = UDim2.new(1, 0, 0, 20)
      CooldownLabel.Position = UDim2.new(0, 0, 1, -20)
      CooldownLabel.BackgroundTransparency = 1
      CooldownLabel.Text = ""
      CooldownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
      CooldownLabel.Font = Enum.Font.Gotham
      CooldownLabel.TextSize = 14
      CooldownLabel.TextScaled = true
      CooldownLabel.Parent = Frame

      local SendCorner = Instance.new("UICorner")
      SendCorner.CornerRadius = UDim.new(0, 8)
      SendCorner.Parent = SendBtn

      SendBtn.MouseButton1Click:Connect(function()
         local msg = TextBox.Text

         if msg == "" or msg:match("^%s*$") then
            SendBtn.Text = "Enter feedback text!"
            task.wait(1)
            SendBtn.Text = "Send Feedback"
            return 
         end

         local lower_msg = msg:lower()

         for _, word in ipairs(g.offensiveWords) do
            if lower_msg:find(word, 1, true) then
               TypeLabel.Text = "Message contains blocked/offensive content!"
               TypeLabel.TextColor3 = Color3.fromRGB(255, 80, 80)

               SendBtn.Text = "Blocked (Blatant Racism)."
               task.wait(1.2)
               SendBtn.Text = "Send Feedback"
               return
            end
         end

         for _, phrase in ipairs(g.bad_phrases) do
            if lower_msg:find(phrase, 1, true) then
               TypeLabel.Text = "Message contains disallowed phrases!"
               TypeLabel.TextColor3 = Color3.fromRGB(255, 80, 80)

               SendBtn.Text = "Blocked (Hatred towards script)."
               task.wait(1.2)
               SendBtn.Text = "Send Feedback"
               return
            end
         end

         local tip = get_smart_tip_func(msg)
         if tip then
            show_smart_tip_ScreenGui(tip)
         end

         pcall(function()
            g.Send_Main_Feedback(g.LocalPlayer, msg, selected_type)
         end)

         g.FeedbackCooldown = true
         g.FeedbackTimeLeft = 60
         g.FeedbackCooldown_Has_Been_Set_Loop_Task = g.FeedbackCooldown_Has_Been_Set_Loop_Task or task.spawn(function()
            while g.FeedbackTimeLeft > 0 do
               CooldownLabel.Text = "Cooldown: " .. tostring(g.FeedbackTimeLeft) .. "s"
               task.wait(1)
               g.FeedbackTimeLeft = (g.FeedbackTimeLeft or 0) - 1
            end
            CooldownLabel.Text = ""
         end)

         task.delay(60, function()
            g.FeedbackCooldown = false
         end)

         ScreenGui:Destroy()
      end)
   end

   local humanoid = g.Humanoid or g.Character and g.Character:FindFirstChildOfClass("Humanoid") or get_human(LocalPlayer or game.Players.LocalPlayer)
   local applied = humanoid:GetAppliedDescription()
   local Old_Shirt = applied.Shirt
   local Old_Pants = applied.Pants

   g.glitch_outfit = function(toggle)
      if toggle == true then
         if g.Glitching_Outfit then
            return g.notify("Warning", "Glitch Outfit is already enabled.", 5)
         end
         g.Glitching_Outfit = true

         task.spawn(function()
            while g.Glitching_Outfit == true do
               fw(0)
               for _, shirtId in ipairs(GlitchIDs.Shirts) do
                  forceEquip("Shirt", shirtId)
                  wait()
                  forceUnequip("Shirt", shirtId)
               end
               fw(0.1)
               for _, pantsId in ipairs(GlitchIDs.Pants) do
                  forceEquip("Pants", pantsId)
                  wait()
                  forceUnequip("Pants", pantsId)
               end
            end
         end)
      else
         if not g.Glitching_Outfit then
            return g.notify("Warning", "Glitch Outfit is not enabled.", 5)
         end

         g.Glitching_Outfit = false
         while g.Glitching_Outfit do
            wait()
         end

         task.spawn(function()
            wait(0.5)
            g.Send("code", Old_Shirt, "Shirt")
            wait()
            g.Send("code", Old_Pants, "Pants")
         end)
      end
   end

   function check_friends()
      for _, v in ipairs(g.Players:GetPlayers()) do
         if v ~= g.LocalPlayer and v:IsFriendsWith(g.LocalPlayer.UserId) then
            alreadyCheckedUser(v)
         end
      end
   end

   function auto_add_friends()
      for _, v in ipairs(g.Players:GetPlayers()) do
         if v ~= g.LocalPlayer and v:IsFriendsWith(g.LocalPlayer.UserId) then
            check_friends()
            addPlayerToScriptWhitelistTable(v)
         end
      end
   end

   auto_add_friends()

   local originalCFrame
   local originalCameraType
   if g.PlayerControls == nil then
      local PlayerModule = require(g.PlayerScripts:WaitForChild("PlayerModule"))
      g.PlayerControls = PlayerModule:GetControls()
   end

   g.Viewing_Plr_Tbl = g.Viewing_Plr_Tbl or {}
   g.viewTarget = g.viewTarget or function(player)
      if g.Viewing_A_Player then
         if g.Viewing_Plr_Tbl[player.Name] then
            return notify("Error","You're already viewing: "..player.DisplayName,5)
         end
         return notify("Error","You're already viewing a Player.",5)
      end

      if not player or not player.Character then
         return notify("Error","Invalid player.",5)
      end

      local char = g.get_char(player)
      local hum = get_human(player) or char:FindFirstChildWhichIsA("Humanoid")
      if not hum then
         return notify("Error","Player has no humanoid.",5)
      end

      local root = get_root(player) or hum.RootPart or char:FindFirstChild("HumanoidRootPart")

      g.Camera.CameraSubject = hum
      g.Viewing_A_Player = true

      g.Viewing_Plr_Tbl[player.Name] = {
         Name = player.Name,
         DisplayName = player.DisplayName,
         UserId = player.UserId,
         Character = char,
         Humanoid = hum,
         HumanoidRootPart = root
      }
   end

   g.unview_player = g.unview_player or function()
      local genv = g

      if not genv.Viewing_A_Player then
         return genv.notify("Error", "You're not viewing anyone.", 5)
      end

      local hum = genv.Humanoid
      local char = genv.Character
      local subject =
         hum
         or (char and char:FindFirstChildWhichIsA("Humanoid"))
         or char

      if subject and genv.Camera then
         genv.Camera.CameraSubject = subject
      elseif not genv.Camera then
         workspace.CurrentCamera.CameraSubject = subject
      end

      if typeof(genv.Viewing_Plr_Tbl) ~= "table" then
         genv.Viewing_Plr_Tbl = {}
      end

      if next(genv.Viewing_Plr_Tbl) == nil then
         return genv.notify(
            "Error",
            "Viewing table is empty (tried unviewing nobody? how?).",
            10
         )
      end

      local viewed
      for k, v in pairs(genv.Viewing_Plr_Tbl) do
         viewed = (typeof(v) == "Instance" and v.DisplayName) or k
         break
      end

      genv.Viewing_A_Player = false
      table.clear(genv.Viewing_Plr_Tbl)

      genv.notify("Success", "Stopped viewing: " .. tostring(viewed), 5)
   end

   g.check_friend = function(Player)
      if Player ~= g.LocalPlayer and Player:IsFriendsWith(g.LocalPlayer.UserId) then
         return true
      else
         return false
      end

      return 
   end

   g.spam_create_groups = function(toggle)
      if toggle == true then
         g.group_chatting_users = g.group_chatting_users or {}
         g.Creating_Groups = true

         while g.Creating_Groups do
            fw(0)
            for _, name in ipairs(g.group_chatting_users) do
               local success, userId = pcall(function()
                  return Players:GetUserIdFromNameAsync(name)
               end)
               
               if success and userId then
                  g.Get("new_group", userId)
               end
            end
         end
      elseif toggle == false then
         g.Creating_Groups = false
      else
         return 
      end
   end

   g.attach_with_script = function()
      local Methods = {
         "Secret",
         "Sneaky",
         "Private",
         "Normal",
         "Bypass",
         "External",
         "Internal",
         "Rage",
         "Silent",
         "Source",
         "MainClass",
         "Class_C",
         "Non-Closure",
         "Encoded",
         "Bytecode",
         "Obfuscated"
      }

      local Attached = false
      g.Script_Was_Attached_Successfully = Attached
      local Old_Text = g.CreditsLabelText.Text
      task.wait(0.4)
      for i = 1, 3 do
         wait(0.6)
         g.CreditsLabelText.Text = "[Starting]: Attaching."
         wait(0.6)
         g.CreditsLabelText.Text = "[Starting]: Attaching.."
         wait(0.6)
         g.CreditsLabelText.Text = "[Starting]: Attaching..."
      end
      task.wait(.1)
      Attached = true
      task.wait(.1)
      if Attached == true then
         g.CreditsLabelText.Text = "[Starting]: Getting requirements."
         wait(0.6)
         g.CreditsLabelText.Text = "[Starting]: Getting requirements.."
         wait(0.6)
         g.CreditsLabelText.Text = "[Starting]: Getting requirements..."
         wait(0.5)
         g.CreditsLabelText.Text = "[Success]: Got requirements successfully!"
         wait(0.6)
         for i = 1, 3 do
            wait(0.6)
            g.CreditsLabelText.Text = "[Initializing]: Collecting prerequisites."
            wait(0.6)
            g.CreditsLabelText.Text = "[Initializing]: Collecting prerequisites.."
            wait(0.6)
            g.CreditsLabelText.Text = "[Initializing]: Collecting prerequisites..."
         end
      end
      task.wait(0.3)
      for i = 1, 8 do
         wait(0.6)
         g.CreditsLabelText.Text = "[Finalizing]: Collecting prerequisites."
         wait(0.6)
         g.CreditsLabelText.Text = "[Finalizing]: Collecting prerequisites.."
         wait(0.6)
         g.CreditsLabelText.Text = "[Finalizing]: Collecting prerequisites..."
      end
      fw(0.2)
      for i = 1, 4 do
         wait(0.6)
         g.CreditsLabelText.Text = "[Finishing]: Selecting method."
         wait(0.6)
         g.CreditsLabelText.Text = "[Finishing]: Selecting method.."
         wait(0.6)
         g.CreditsLabelText.Text = "[Finishing]: Selecting method..."
      end
      task.wait(0.3)
      local function ChooseMethod()
         return Methods[math.random(1, #Methods)]
      end

      g.CreditsLabelText.Text = "[Finished]: Method: "..tostring(ChooseMethod())
      wait(0.7)
      g.CreditsLabelText.Text = "Attached."
      wait(0.8)
      g.CreditsLabelText.Text = Old_Text
   end

   g.PlotAreas = {}

   g.update_plot_areas = function()
      table.clear(g.PlotAreas)
      fw(0.2)
      for _, v in ipairs(g.Workspace:GetDescendants()) do
         if v:IsA("BasePart") and v.Name == "PlotArea" then
            g.PlotAreas[v] = v
         end
      end
   end

   savePrefix(g.AdminPrefix)

   g.in_humanoid_vehicle = function(PlayerOrName)
      local HumanoidVehicles = g.Workspace:FindFirstChild("HumanoidVehicles", true)
      if not HumanoidVehicles then return end

      local Player = PlayerOrName
      if typeof(PlayerOrName) == "string" then
         Player = g.Players:FindFirstChild(PlayerOrName)
         if not Player then return end
      end

      local Character = Player == g.LocalPlayer and g.Character or Player.Character
      if not Character then return end

      local humanoid = Character:FindFirstChildWhichIsA("Humanoid")
      if not humanoid then return end

      local vehicleAttr = humanoid:GetAttribute("InHumanoidVehicle")
      if vehicleAttr == nil then return end

      if type(g.Humanoid_Vehicles) ~= "table" then return end
      if not table.find(g.Humanoid_Vehicles, vehicleAttr) then return end

      return vehicleAttr
   end

   g.hum_vehicle_name = g.hum_vehicle_name or function(plr)
      local hv = in_humanoid_vehicle(plr)
      if not hv then return nil end

      local folder = g.Workspace:FindFirstChild("HumanoidVehicles", true)
      if not folder then return nil end

      local inst = folder:FindFirstChild(hv)
      if not inst then return nil end

      return inst.Name
   end

   g.set_hum_vehicle_speed = g.set_hum_vehicle_speed or function(speed)
      speed = tonumber(speed) or 50

      if typeof(speed) ~= "number" then
         speed = 50
      end

      if in_humanoid_vehicle(g.LocalPlayer) then
         pcall(function() g.Humanoid.WalkSpeed = tonumber(speed) end)
      end
   end

   update_plot_areas()

   if CoreGui:FindFirstChild("TemporaryBanner_GUI") then
      pcall(function()
         if g.camConn then
            g.camConn:Disconnect()
            g.camConn = nil
         end
         if screenGui and screenGui.Parent then
            screenGui:Destroy()
         end
         g.updatePosition = nil
         g.clamp = nil
      end)
   end
   wait(0.7)
   local screenGui = Instance.new("ScreenGui")
   screenGui.Name = "TemporaryBanner_GUI"
   screenGui.ResetOnSpawn = false
   screenGui.IgnoreGuiInset = true
   screenGui.Parent = CoreGui

   local frame = Instance.new("Frame")
   frame.Name = "BannerFrame"
   frame.AnchorPoint = Vector2.new(0.5, 0)
   frame.Position = UDim2.new(0.5, 0, 0, 20)
   frame.Size = UDim2.new(0.6, 0, 0, 48)
   frame.BackgroundTransparency = 0
   frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
   frame.BorderSizePixel = 0
   frame.Parent = screenGui

   make_round(frame, 12)
   flowrgb("banner_announcement_frame_flowing_rgb_smooth_conn", 3.5, frame, true)
   g.make_stroke(frame, 1.5, 0.25)

   local label = Instance.new("TextLabel")
   label.Name = "BannerText"
   label.AnchorPoint = Vector2.new(0.5, 0.5)
   label.Position = UDim2.new(0.5, 0, 0.5, 0)
   label.Size = UDim2.new(0.95, 0, 0.9, 0)
   label.BackgroundTransparency = 1
   label.Text = tostring(Announcement_Message)
   label.Font = Enum.Font.GothamBold
   label.TextScaled = true
   label.RichText = false
   label.TextWrapped = true
   label.TextColor3 = Color3.fromRGB(255, 255, 255)
   label.Parent = frame

   local shadow = Instance.new("ImageLabel")
   shadow.Name = "Shadow"
   shadow.AnchorPoint = Vector2.new(0.5, 0)
   shadow.Position = UDim2.new(0.5, 0, 0, 24)
   shadow.Size = UDim2.new(0.62, 0, 0, 56)
   shadow.Image = "rbxassetid://5059716102"
   shadow.BackgroundTransparency = 1
   shadow.ImageTransparency = 0.8
   shadow.ZIndex = frame.ZIndex - 1
   shadow.Parent = screenGui
   shadow.Visible = false

   g.clamp = g.clamp or function(n, lo, hi)
      if n < lo then return lo end
      if n > hi then return hi end

      return n
   end

   g.updatePosition = g.updatePosition or function()
      vw, vh = g.Workspace.CurrentCamera.ViewportSize.X, g.Workspace.CurrentCamera.ViewportSize.Y
      widthScale = clamp(0.6, 0.4, 0.8)

      heightPx = clamp(math.floor(vh * 0.07), 36, 72)

      frame.Size = UDim2.new(widthScale, 0, 0, heightPx)

      topOffset = math.max(12, math.floor(vh * 0.03))
      frame.Position = UDim2.new(0.5, 0, 0, topOffset)
      shadow.Position = UDim2.new(0.5, 0, 0, topOffset + math.floor(heightPx/2))
      shadow.Size = UDim2.new(widthScale + 0.02, 0, 0, heightPx + 12)
   end

   updatePosition()

   g.camConn = nil
   if g.Workspace and g.Workspace.CurrentCamera then
      g.camConn = g.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updatePosition)
   end

   frame.BackgroundTransparency = 1
   label.TextTransparency = 1
   shadow.ImageTransparency = 1

   appearInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
   TweenService:Create(frame, appearInfo, {BackgroundTransparency = 0}):Play()
   TweenService:Create(label, appearInfo, {TextTransparency = 0}):Play()
   shadow.Visible = false
   TweenService:Create(shadow, appearInfo, {ImageTransparency = 0.8}):Play()

   displayTime = displayTimeMax
   delay(displayTime, function()
      fadeInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
      t1 = TweenService:Create(frame, fadeInfo, {BackgroundTransparency = 1})
      t2 = TweenService:Create(label, fadeInfo, {TextTransparency = 1})
      t3 = TweenService:Create(shadow, fadeInfo, {ImageTransparency = 1})

      t1:Play(); t2:Play(); t3:Play()
      t1.Completed:Wait()

      pcall(function()
         if g.camConn then
            g.camConn:Disconnect()
            g.camConn = nil
         end
         screenGui:Destroy()
      end)
   end)

   g.spawn_notif_announcement_flames_hub = function(msg, duration)
      local lp = g.LocalPlayer or Players.LocalPlayer or game.Players.LocalPlayer
      if not lp then return end
      duration = (type(duration) == "number" and duration > 0) and duration or 5
      local notif_id = "FlamesNotif_" .. tostring(tick())
      local function clamp_val(n, lo, hi)
         if n < lo then return lo end
         if n > hi then return hi end
         return n
      end

      local function make_round(obj, radius)
         local Corner = Instance.new("UICorner")
         Corner.CornerRadius = UDim.new(0, radius)
         Corner.Parent = obj
      end

      local function make_stroke(obj, thickness, transparency, color)
         local Stroke = Instance.new("UIStroke")
         Stroke.Thickness = thickness
         Stroke.Transparency = transparency
         Stroke.Color = color or Color3.fromRGB(255, 255, 255)
         Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
         Stroke.Parent = obj
      end

      local function make_glow(parent)
         local Glow = Instance.new("ImageLabel")
         Glow.Name = "GlowLayer"
         Glow.AnchorPoint = Vector2.new(0.5, 0.5)
         Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
         Glow.Size = UDim2.new(1.18, 0, 2.4, 0)
         Glow.BackgroundTransparency = 1
         Glow.Image = "rbxassetid://5028857084"
         Glow.ImageColor3 = Color3.fromRGB(120, 80, 255)
         Glow.ImageTransparency = 0.72
         Glow.ZIndex = parent.ZIndex - 1
         Glow.ScaleType = Enum.ScaleType.Stretch
         Glow.Parent = parent.Parent
         return Glow
      end

      local Gui = Instance.new("ScreenGui")
      Gui.Name = notif_id
      Gui.ResetOnSpawn = false
      Gui.IgnoreGuiInset = true
      Gui.DisplayOrder = 999
      Gui.Parent = CoreGui

      local Cam = workspace.CurrentCamera
      local vh = Cam and Cam.ViewportSize.Y or 720
      local frame_w = 0.54
      local frame_h = clamp_val(math.floor(vh * 0.075), 44, 78)
      local bottom_offset = clamp_val(math.floor(vh * 0.045), 22, 52)
      local Container = Instance.new("Frame")
      Container.Name = "NotifContainer"
      Container.AnchorPoint = Vector2.new(0.5, 1)
      Container.Position = UDim2.new(0.5, 0, 1, frame_h + 12)
      Container.Size = UDim2.new(frame_w, 0, 0, frame_h)
      Container.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
      Container.BackgroundTransparency = 0.08
      Container.BorderSizePixel = 0
      Container.ZIndex = 10
      Container.ClipsDescendants = false
      Container.Parent = Gui

      make_round(Container, 10)
      make_stroke(Container, 1.2, 0.55, Color3.fromRGB(200, 160, 255))

      local Glow_Img = make_glow(Container)
      local Icon_Box = Instance.new("Frame")
      Icon_Box.Name = "IconBox"
      Icon_Box.AnchorPoint = Vector2.new(0, 0.5)
      Icon_Box.Position = UDim2.new(0, 10, 0.5, 0)
      Icon_Box.Size = UDim2.new(0, frame_h - 16, 0, frame_h - 16)
      Icon_Box.BackgroundColor3 = Color3.fromRGB(110, 60, 220)
      Icon_Box.BackgroundTransparency = 0.2
      Icon_Box.BorderSizePixel = 0
      Icon_Box.ZIndex = 11
      Icon_Box.Parent = Container

      make_round(Icon_Box, 7)

      local Icon_Label = Instance.new("TextLabel")
      Icon_Label.Name = "Icon"
      Icon_Label.AnchorPoint = Vector2.new(0.5, 0.5)
      Icon_Label.Position = UDim2.new(0.5, 0, 0.5, 0)
      Icon_Label.Size = UDim2.new(0.85, 0, 0.85, 0)
      Icon_Label.BackgroundTransparency = 1
      Icon_Label.Text = tostring(g.Announcement_Banner_Notification_Emoji)
      Icon_Label.TextScaled = true
      Icon_Label.Font = Enum.Font.GothamBold
      Icon_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
      Icon_Label.ZIndex = 12
      Icon_Label.Parent = Icon_Box

      local icon_size = frame_h - 16
      local text_pad_left = 10 + icon_size + 10
      local Msg_Label = Instance.new("TextLabel")
      Msg_Label.Name = "MsgLabel"
      Msg_Label.AnchorPoint = Vector2.new(0, 0.5)
      Msg_Label.Position = UDim2.new(0, text_pad_left, 0.5, 0)
      Msg_Label.Size = UDim2.new(1, -(text_pad_left + 10), 0.78, 0)
      Msg_Label.BackgroundTransparency = 1
      Msg_Label.Text = tostring(msg)
      Msg_Label.Font = Enum.Font.GothamSemibold
      Msg_Label.TextScaled = true
      Msg_Label.RichText = false
      Msg_Label.TextWrapped = true
      Msg_Label.TextXAlignment = Enum.TextXAlignment.Left
      Msg_Label.TextColor3 = Color3.fromRGB(235, 235, 240)
      Msg_Label.TextTransparency = 1
      Msg_Label.ZIndex = 11
      Msg_Label.Parent = Container

      local Progress_Bg = Instance.new("Frame")
      Progress_Bg.Name = "ProgressBg"
      Progress_Bg.AnchorPoint = Vector2.new(0.5, 1)
      Progress_Bg.Position = UDim2.new(0.5, 0, 1, 0)
      Progress_Bg.Size = UDim2.new(1, 0, 0, 3)
      Progress_Bg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
      Progress_Bg.BackgroundTransparency = 0.3
      Progress_Bg.BorderSizePixel = 0
      Progress_Bg.ZIndex = 12
      Progress_Bg.ClipsDescendants = true
      Progress_Bg.Parent = Container

      make_round(Progress_Bg, 4)

      local Progress_Bar = Instance.new("Frame")
      Progress_Bar.Name = "ProgressBar"
      Progress_Bar.AnchorPoint = Vector2.new(0, 0.5)
      Progress_Bar.Position = UDim2.new(0, 0, 0.5, 0)
      Progress_Bar.Size = UDim2.new(1, 0, 1, 0)
      Progress_Bar.BackgroundColor3 = Color3.fromRGB(150, 90, 255)
      Progress_Bar.BorderSizePixel = 0
      Progress_Bar.ZIndex = 13
      Progress_Bar.Parent = Progress_Bg

      make_round(Progress_Bar, 4)

      local Slide_In = TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
      local Slide_Out = TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
      local Fade_In = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

      Container.BackgroundTransparency = 1
      Glow_Img.ImageTransparency = 1

      local target_y = UDim2.new(0.5, 0, 1, -bottom_offset)

      TweenService:Create(Container, Slide_In, {Position = target_y, BackgroundTransparency = 0.08}):Play()
      TweenService:Create(Glow_Img, Fade_In, {ImageTransparency = 0.72}):Play()
      TweenService:Create(Msg_Label, Fade_In, {TextTransparency = 0}):Play()

      local pulse_conn
      local pulse_step = 0

      pulse_conn = RunService.Heartbeat:Connect(function(dt)
         if not Gui.Parent then
            pulse_conn:Disconnect()
            pulse_conn = nil
            return
         end
         pulse_step = pulse_step + dt * 1.8
         local alpha = (math.sin(pulse_step * math.pi) + 1) / 2
         local lo_trans = 0.65
         local hi_trans = 0.88
         Glow_Img.ImageTransparency = lo_trans + (hi_trans - lo_trans) * (1 - alpha)
         local lo_r, lo_g, lo_b = 100, 55, 210
         local hi_r, hi_g, hi_b = 160, 100, 255
         Glow_Img.ImageColor3 = Color3.fromRGB(
            math.floor(lo_r + (hi_r - lo_r) * alpha),
            math.floor(lo_g + (hi_g - lo_g) * alpha),
            math.floor(lo_b + (hi_b - lo_b) * alpha)
         )
      end)

      local cam_conn
      if Cam then
         cam_conn = Cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            local nh = Cam.ViewportSize.Y
            local new_h = clamp_val(math.floor(nh * 0.075), 44, 78)
            local new_bot = clamp_val(math.floor(nh * 0.045), 18, 52)
            Container.Size = UDim2.new(frame_w, 0, 0, new_h)
            Container.Position = UDim2.new(0.5, 0, 1, -new_bot)
         end)
      end

      local Progress_Tween = TweenService:Create(
         Progress_Bar,
         TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
         {Size = UDim2.new(0, 0, 1, 0)}
      )
      Progress_Tween:Play()

      task.delay(duration, function()
         Progress_Tween:Cancel()

         if pulse_conn then pulse_conn:Disconnect() pulse_conn = nil end
         if cam_conn then cam_conn:Disconnect() cam_conn = nil end

         local Fo_1 = TweenService:Create(Container, Slide_Out, {
            Position = UDim2.new(0.5, 0, 1, frame_h + 20),
            BackgroundTransparency = 1
         })
         local Fo_2 = TweenService:Create(Msg_Label, Slide_Out, {TextTransparency = 1})
         local Fo_3 = TweenService:Create(Glow_Img, Slide_Out, {ImageTransparency = 1})

         Fo_1:Play(); Fo_2:Play(); Fo_3:Play()
         Fo_1.Completed:Wait()

         pcall(function() Gui:Destroy() end)
      end)
   end

   g.Flames_Announce_WS_URL = g.Flames_Announce_WS_URL or nil
   g.listen_announce = function()
      if not g.Main_Announcement_Connections_Created_In_WebSocket_Flames_Hub then
         g.Main_Announcement_Connections_Created_In_WebSocket_Flames_Hub = true
         if not g.ws_conn then return end -- if it doesn't exist, just exit.
         g.ws_conn.OnMessage:Connect(function(raw_msg)
            local ok, data = pcall(function()
               return HttpService:JSONDecode(raw_msg)
            end)

            if not ok or type(data) ~= "table" then return end
            if data.type ~= "announce" then return end
            local txt = data.text
            local dur = data.display_time

            if type(txt) == "string" and #txt > 0 then
               g.spawn_notif_announcement_flames_hub(txt, dur)
            end
         end)
      end
   end
   fw(0.1)
   if not g.ListeningFor_Announcements_Through_Flames_Hub_WebSocket_Server then
      g.ListeningFor_Announcements_Through_Flames_Hub_WebSocket_Server = true
      g.listen_announce()
   end

   --[[local function build_input_gui()
      if CoreGui:FindFirstChild("FlamesInputGui") and CoreGui:FindFirstChild("FlamesInputGui"):IsA("ScreenGui") and CoreGui:FindFirstChild("FlamesInputGui"):FindFirstChildOfClass("Frame") then
         CoreGui.FlamesInputGui:FindFirstChildOfClass("Frame").Visible = true
         return 
      end

      local Screen_Gui = Instance.new("ScreenGui")
      Screen_Gui.Name = "FlamesInputGui"
      Screen_Gui.ResetOnSpawn = false
      Screen_Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      Screen_Gui.Parent = CoreGui
      Screen_Gui.Enabled = false

      local Main = Instance.new("Frame")
      Main.Name = "Main"
      Main.Size = UDim2.new(0, 320, 0, 130)
      Main.Position = UDim2.new(0.5, -160, 0.5, -65)
      Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
      Main.BorderSizePixel = 0
      Main.Parent = Screen_Gui
      Main.Visible = false

      Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

      local Main_Stroke = Instance.new("UIStroke", Main)
      Main_Stroke.Color = Color3.fromRGB(255, 200, 0)
      Main_Stroke.Thickness = 1.5
      Main_Stroke.Transparency = 0.5

      local Title_Bar = Instance.new("Frame", Main)
      Title_Bar.Size = UDim2.new(1, 0, 0, 40)
      Title_Bar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
      Title_Bar.BorderSizePixel = 0

      Instance.new("UICorner", Title_Bar).CornerRadius = UDim.new(0, 14)

      local Title_Fix = Instance.new("Frame", Title_Bar)
      Title_Fix.Size = UDim2.new(1, 0, 0.5, 0)
      Title_Fix.Position = UDim2.new(0, 0, 0.5, 0)
      Title_Fix.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
      Title_Fix.BorderSizePixel = 0

      local Title_Label = Instance.new("TextLabel", Title_Bar)
      Title_Label.Size = UDim2.new(1, -50, 1, 0)
      Title_Label.Position = UDim2.new(0, 14, 0, 0)
      Title_Label.BackgroundTransparency = 1
      Title_Label.Text = "✉️ Send Message ✉️"
      Title_Label.TextColor3 = Color3.fromRGB(255, 210, 0)
      Title_Label.TextSize = 15
      Title_Label.Font = Enum.Font.Code
      Title_Label.TextXAlignment = Enum.TextXAlignment.Left

      local Close_Btn = Instance.new("TextButton", Title_Bar)
      Close_Btn.Size = UDim2.new(0, 26, 0, 26)
      Close_Btn.Position = UDim2.new(1, -34, 0.5, -13)
      Close_Btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
      Close_Btn.BorderSizePixel = 0
      Close_Btn.Text = "X"
      Close_Btn.TextScaled = true
      Close_Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
      Close_Btn.TextSize = 13
      Close_Btn.Font = Enum.Font.GothamBold

      Instance.new("UICorner", Close_Btn).CornerRadius = UDim.new(0, 7)

      local Input_Box = Instance.new("TextBox", Main)
      Input_Box.Name = "InputBox"
      Input_Box.Size = UDim2.new(1, -24, 0, 36)
      Input_Box.Position = UDim2.new(0, 12, 0, 50)
      Input_Box.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
      Input_Box.BorderSizePixel = 0
      Input_Box.Text = ""
      Input_Box.PlaceholderText = "Type something..."
      Input_Box.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
      Input_Box.TextColor3 = Color3.fromRGB(230, 230, 230)
      Input_Box.TextSize = 13
      Input_Box.Font = Enum.Font.Gotham
      Input_Box.ClearTextOnFocus = false

      Instance.new("UICorner", Input_Box).CornerRadius = UDim.new(0, 9)

      local Input_Stroke = Instance.new("UIStroke", Input_Box)
      Input_Stroke.Color = Color3.fromRGB(60, 60, 80)
      Input_Stroke.Thickness = 1

      local Send_Btn = Instance.new("TextButton", Main)
      Send_Btn.Size = UDim2.new(1, -24, 0, 32)
      Send_Btn.Position = UDim2.new(0, 12, 0, 94)
      Send_Btn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
      Send_Btn.BorderSizePixel = 0
      Send_Btn.Text = "Send."
      Send_Btn.TextColor3 = Color3.fromRGB(20, 20, 20)
      Send_Btn.TextSize = 14
      Send_Btn.Font = Enum.Font.GothamBold

      Instance.new("UICorner", Send_Btn).CornerRadius = UDim.new(0, 9)

      Send_Btn.MouseEnter:Connect(function()
         TweenService:Create(Send_Btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(255, 220, 60)
         }):Play()
      end)

      Send_Btn.MouseLeave:Connect(function()
         TweenService:Create(Send_Btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(255, 190, 0)
         }):Play()
      end)

      Send_Btn.MouseButton1Click:Connect(function()
         local Text = Input_Box.Text
         if Text == "" then return end
         if g.on_input_send then
            g.on_input_send(Text)
         end
         Input_Box.Text = ""
      end)

      Close_Btn.MouseButton1Click:Connect(function()
         Main.Visible = false
      end)

      Input_Box:GetPropertyChangedSignal("Text"):Connect(function()
         Input_Stroke.Color = Input_Box.Text ~= ""
            and Color3.fromRGB(255, 190, 0)
            or Color3.fromRGB(60, 60, 80)
      end)

      g.dragify(Main)

      return Screen_Gui
   end

   g.on_shop_buy_announcement_3s = function()
      if CoreGui:FindFirstChild("FlamesInputGui") and CoreGui:FindFirstChild("FlamesInputGui"):IsA("ScreenGui") and CoreGui:FindFirstChild("FlamesInputGui"):FindFirstChildOfClass("Frame") then
         CoreGui.FlamesInputGui:FindFirstChildOfClass("Frame").Visible = true
      end
      g.on_input_send = function(Text)
         if Text == "" then return end
         g.spawn_notif_announcement_flames_hub(Text, 3)
         if CoreGui:FindFirstChild("FlamesInputGui") and CoreGui:FindFirstChild("FlamesInputGui"):IsA("ScreenGui") and CoreGui:FindFirstChild("FlamesInputGui"):FindFirstChildOfClass("Frame") then
            CoreGui.FlamesInputGui:FindFirstChildOfClass("Frame").Visible = false
         end
      end
   end

   g.on_shop_buy_announcement_5s = function()
      if CoreGui:FindFirstChild("FlamesInputGui") and CoreGui:FindFirstChild("FlamesInputGui"):IsA("ScreenGui") and CoreGui:FindFirstChild("FlamesInputGui"):FindFirstChildOfClass("Frame") then
         CoreGui.FlamesInputGui:FindFirstChildOfClass("Frame").Visible = true
      end
      g.on_input_send = function(Text)
         if Text == "" then return end
         g.spawn_notif_announcement_flames_hub(Text, 5)
         if CoreGui:FindFirstChild("FlamesInputGui") and CoreGui:FindFirstChild("FlamesInputGui"):IsA("ScreenGui") and CoreGui:FindFirstChild("FlamesInputGui"):FindFirstChildOfClass("Frame") then
            CoreGui.FlamesInputGui:FindFirstChildOfClass("Frame").Visible = false
         end
      end
   end

   g.on_shop_buy_wear_owner_outfit_one = function()
      local Found_Glasses = false
      local Found_Fedora = false
      local Found_Pants = false
      local Found_Shirt = false
      local Elapsed = 0
      local Pants_Template = "http://www.roblox.com/asset/?id=409302917"
      local Shirt_Template = "http://www.roblox.com/asset/?id=6483538858"
      local Connection
      Connection = RunService.Heartbeat:Connect(function(dt)
         Elapsed = Elapsed + dt

         if Elapsed >= 1 then
            Elapsed = 0

            pcall(function()
               getgenv().Send("load_outfit", "38E7PO7")
            end)

            local Character = getgenv().Character or LocalPlayer.Character or get_char(LocalPlayer, 10)
            if Character then
               for _, Obj in ipairs(Character:GetDescendants()) do
                  if Obj:IsA("Accessory") then
                     local Name = Obj.Name:lower()

                     if Name:find("glases_v3_01") then
                        Found_Glasses = true
                     end

                     if Name:find("realisticfedora") then
                        Found_Fedora = true
                     end
                  end
               end

               local Pants = Character:FindFirstChildOfClass("Pants")
               if Pants and Pants.PantsTemplate == Pants_Template then
                  Found_Pants = true
               end

               local Shirt = Character:FindFirstChildOfClass("Shirt")
               if Shirt and Shirt.ShirtTemplate == Shirt_Template then
                  Found_Shirt = true
               end
            end

            if Found_Glasses and Found_Fedora and Found_Pants and Found_Shirt then
               Connection:Disconnect()
               getgenv().notify("Success", "Successfully wore the Flames Hub | Owners outfit.", 5)
            else
               getgenv().notify("Info", "Waiting on all accessories to be applied...", 0.35)
            end
         end
      end)
   end

   g.on_shop_buy_wear_owner_outfit_two = function()
      local Found_Fedora = false
      local Found_Pants = false
      local Found_Shirt = false
      local Elapsed = 0
      local Pants_Template = "http://www.roblox.com/asset/?id=6028804717"
      local Shirt_Template = "http://www.roblox.com/asset/?id=6028801573"
      local Connection
      Connection = RunService.Heartbeat:Connect(function(dt)
         Elapsed = Elapsed + dt

         if Elapsed >= 1 then
            Elapsed = 0

            pcall(function()
               getgenv().Send("load_outfit", "D5BD7JE")
            end)

            local Character = getgenv().Character or LocalPlayer.Character or get_char(LocalPlayer, 10)
            if Character then
               for _, Obj in ipairs(Character:GetDescendants()) do
                  if Obj:IsA("Accessory") then
                     local Name = Obj.Name:lower()

                     if Name:find("realisticfedora")
                        and Obj.AccessoryType == Enum.AccessoryType.Hat then
                        Found_Fedora = true
                     end
                  end
               end

               local Pants = Character:FindFirstChildOfClass("Pants")
               if Pants and Pants.PantsTemplate == Pants_Template then
                  Found_Pants = true
               end

               local Shirt = Character:FindFirstChildOfClass("Shirt")
               if Shirt and Shirt.ShirtTemplate == Shirt_Template then
                  Found_Shirt = true
               end
            end

            if Found_Fedora and Found_Pants and Found_Shirt then
               Connection:Disconnect()
               getgenv().notify("Success", "Successfully wore the Flames Hub | Owners outfit.", 5)
            else
               getgenv().notify("Info", "Waiting on all accessories to be applied...", 0.35)
            end
         end
      end)
   end

   g.on_shop_buy_wear_owner_outfit_three = function()
      local Found_Bag = false
      local Found_Chain = false
      local Found_Pants = false
      local Found_Shirt = false
      local Elapsed = 0
      local Pants_Template = "http://www.roblox.com/asset/?id=119174483698964"
      local Shirt_Template = "http://www.roblox.com/asset/?id=15473366081"
      local Connection
      Connection = RunService.Heartbeat:Connect(function(dt)
         Elapsed = Elapsed + dt

         if Elapsed >= 1 then
            Elapsed = 0

            pcall(function()
               getgenv().Send("load_outfit", "G9UN7PV")
            end)

            local Character = getgenv().Character or LocalPlayer.Character or get_char(LocalPlayer, 10)
            if Character then
               for _, Obj in ipairs(Character:GetDescendants()) do
                  if Obj:IsA("Accessory") then
                     local Name = Obj.Name:lower()

                     if Name:find("techwear bag1") and Obj.AccessoryType == Enum.AccessoryType.Back then
                        Found_Bag = true
                     end
                     if Name:find("double layered chain necklace") and Obj.AccessoryType == Enum.AccessoryType.Neck then
                        Found_Chain = true
                     end
                  end
               end

               local Pants = Character:FindFirstChildOfClass("Pants")
               if Pants and Pants.PantsTemplate == Pants_Template then
                  Found_Pants = true
               end

               local Shirt = Character:FindFirstChildOfClass("Shirt")
               if Shirt and Shirt.ShirtTemplate == Shirt_Template then
                  Found_Shirt = true
               end
            end

            if Found_Bag and Found_Chain and Found_Pants and Found_Shirt then
               Connection:Disconnect()
               getgenv().notify("Success", "Successfully wore the Flames Hub | Owners outfit.", 5)
            else
               getgenv().notify("Info", "Waiting on all accessories to be applied...", 0.35)
            end
         end
      end)
   end

   g.input_gui = build_input_gui()
   g.on_input_send = function(Text) end

   local Shop_Items = {
      { name = "Announcement [3s]", item_key = "announcement_3s", cost = 15, icon = "x1", description = "Announce for 3 seconds." },
      { name = "Announcement [5s]", item_key = "announcement_5s", cost = 30, icon = "(x2)", description = "Announce for 5 seconds." },
      { name = "Owner Outfit [1]", item_key = "wear_owner_outfit_one", cost = 50, icon = "x1", description = "Wear the Flames Hub owners [1] outfit."},
      { name = "Owner Outfit [2]", item_key = "wear_owner_outfit_two", cost = 75, icon = "(x2)", description = "Wear the Flames Hub owners [2] outfit."},
      { name = "Owner Outfit [3]", item_key = "wear_owner_outfit_three", cost = 100, icon = "(x3)", description = "Wear the Flames Hub owners [3] outfit."},
   }
   local function get_player_coins()
      local Leaderstats = Local_Player:FindFirstChild("leaderstats")
      if not Leaderstats then return 0 end
      local Coins = Leaderstats:FindFirstChild("Coins")
      if not Coins then return 0 end
      return Coins.Value
   end

   local function build_shop_gui()
      if CoreGui:FindFirstChild("FlamesShopGui") and CoreGui:FindFirstChild("FlamesShopGui"):IsA("ScreenGui") then
         CoreGui.FlamesShopGui:Destroy()
      end

      local Screen_Gui = Instance.new("ScreenGui")
      Screen_Gui.Name = "FlamesShopGui"
      Screen_Gui.ResetOnSpawn = false
      Screen_Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      Screen_Gui.Parent = CoreGui

      local Main = Instance.new("Frame")
      Main.Name = "Main"
      Main.Size = UDim2.new(0, 400, 0, 500)
      Main.Position = UDim2.new(0.5, -200, 0.5, -250)
      Main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
      Main.BorderSizePixel = 0
      Main.Visible = false
      Main.Parent = Screen_Gui

      Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)

      local Main_Stroke = Instance.new("UIStroke", Main)
      Main_Stroke.Color = Color3.fromRGB(255, 200, 0)
      Main_Stroke.Thickness = 1.5
      Main_Stroke.Transparency = 0.5

      local Title_Bar = Instance.new("Frame", Main)
      Title_Bar.Size = UDim2.new(1, 0, 0, 54)
      Title_Bar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
      Title_Bar.BorderSizePixel = 0

      Instance.new("UICorner", Title_Bar).CornerRadius = UDim.new(0, 16)

      local Title_Fix = Instance.new("Frame", Title_Bar)
      Title_Fix.Size = UDim2.new(1, 0, 0.5, 0)
      Title_Fix.Position = UDim2.new(0, 0, 0.5, 0)
      Title_Fix.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
      Title_Fix.BorderSizePixel = 0

      local Title_Label = Instance.new("TextLabel", Title_Bar)
      Title_Label.Size = UDim2.new(1, -120, 1, 0)
      Title_Label.Position = UDim2.new(0, 16, 0, 0)
      Title_Label.BackgroundTransparency = 1
      Title_Label.Text = tostring(getgenv().Flames_Hub_Emojis["Shop"]).." Flames Shop "..tostring(getgenv().Flames_Hub_Emojis["Shop"])
      Title_Label.TextColor3 = Color3.fromRGB(255, 210, 0)
      Title_Label.TextSize = 18
      Title_Label.Font = Enum.Font.Code
      Title_Label.TextXAlignment = Enum.TextXAlignment.Left

      local Coins_Badge = Instance.new("Frame", Title_Bar)
      Coins_Badge.Name = "CoinsBadge"
      Coins_Badge.Size = UDim2.new(0, 120, 0, 28)
      Coins_Badge.Position = UDim2.new(1, -187, 0.5, -14)
      Coins_Badge.BackgroundColor3 = Color3.fromRGB(40, 36, 18)
      Coins_Badge.BorderSizePixel = 0

      Instance.new("UICorner", Coins_Badge).CornerRadius = UDim.new(0, 20)

      local Coins_Label = Instance.new("TextLabel", Coins_Badge)
      Coins_Label.Name = "CoinsLabel"
      Coins_Label.Size = UDim2.new(1, 0, 1, 0)
      Coins_Label.BackgroundTransparency = 1
      Coins_Label.Text = get_player_coins()
      Coins_Label.TextColor3 = Color3.fromRGB(255, 210, 0)
      Coins_Label.TextSize = 13
      Coins_Label.Font = Enum.Font.GothamBlack

      local Minimize_Btn = Instance.new("TextButton", Title_Bar)
      Minimize_Btn.Size = UDim2.new(0, 28, 0, 28)
      Minimize_Btn.Position = UDim2.new(1, -64, 0.5, -14)
      Minimize_Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
      Minimize_Btn.BorderSizePixel = 0
      Minimize_Btn.Text = "-"
      Minimize_Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
      Minimize_Btn.TextSize = 14
      Minimize_Btn.Font = Enum.Font.Code

      Instance.new("UICorner", Minimize_Btn).CornerRadius = UDim.new(0, 8)

      local Close_Btn = Instance.new("TextButton", Title_Bar)
      Close_Btn.Size = UDim2.new(0, 28, 0, 28)
      Close_Btn.Position = UDim2.new(1, -30, 0.5, -14)
      Close_Btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
      Close_Btn.BorderSizePixel = 0
      Close_Btn.Text = "X"
      Close_Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
      Close_Btn.TextSize = 14
      Close_Btn.Font = Enum.Font.Code

      Instance.new("UICorner", Close_Btn).CornerRadius = UDim.new(0, 8)

      local Content = Instance.new("ScrollingFrame", Main)
      Content.Name = "Content"
      Content.Size = UDim2.new(1, -24, 1, -70)
      Content.Position = UDim2.new(0, 12, 0, 62)
      Content.BackgroundTransparency = 1
      Content.BorderSizePixel = 0
      Content.ScrollBarThickness = 4
      Content.ScrollBarImageColor3 = Color3.fromRGB(255, 200, 0)
      Content.CanvasSize = UDim2.new(0, 0, 0, 0)
      Content.AutomaticCanvasSize = Enum.AutomaticSize.Y

      local List_Layout = Instance.new("UIListLayout", Content)
      List_Layout.Padding = UDim.new(0, 10)
      List_Layout.SortOrder = Enum.SortOrder.LayoutOrder
      local List_Padding = Instance.new("UIPadding", Content)
      List_Padding.PaddingTop = UDim.new(0, 6)
      List_Padding.PaddingBottom = UDim.new(0, 6)
      local is_minimized = false

      for Index, Item in ipairs(Shop_Items) do
         local Row = Instance.new("Frame", Content)
         Row.Name = Item.item_key
         Row.Size = UDim2.new(1, 0, 0, 72)
         Row.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
         Row.BorderSizePixel = 0
         Row.LayoutOrder = Index

         Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 12)

         local Row_Stroke = Instance.new("UIStroke", Row)
         Row_Stroke.Color = Color3.fromRGB(60, 60, 80)
         Row_Stroke.Thickness = 1

         local Icon_Label = Instance.new("TextLabel", Row)
         Icon_Label.Size = UDim2.new(0, 52, 1, 0)
         Icon_Label.BackgroundTransparency = 1
         Icon_Label.Text = Item.icon
         Icon_Label.TextSize = 28
         Icon_Label.Font = Enum.Font.GothamBold

         local Info = Instance.new("Frame", Row)
         Info.Size = UDim2.new(1, -160, 1, 0)
         Info.Position = UDim2.new(0, 52, 0, 0)
         Info.BackgroundTransparency = 1

         local Name_Label = Instance.new("TextLabel", Info)
         Name_Label.Size = UDim2.new(1, 0, 0.5, 0)
         Name_Label.BackgroundTransparency = 1
         Name_Label.Text = Item.name
         Name_Label.TextColor3 = Color3.fromRGB(240, 240, 240)
         Name_Label.TextSize = 14
         Name_Label.Font = Enum.Font.GothamBold
         Name_Label.TextXAlignment = Enum.TextXAlignment.Left

         local Desc_Label = Instance.new("TextLabel", Info)
         Desc_Label.Size = UDim2.new(1, 0, 0.5, 0)
         Desc_Label.Position = UDim2.new(0, 0, 0.5, 0)
         Desc_Label.BackgroundTransparency = 1
         Desc_Label.Text = Item.description
         Desc_Label.TextColor3 = Color3.fromRGB(140, 140, 160)
         Desc_Label.TextSize = 11
         Desc_Label.Font = Enum.Font.Gotham
         Desc_Label.TextXAlignment = Enum.TextXAlignment.Left

         local Buy_Btn = Instance.new("TextButton", Row)
         Buy_Btn.Size = UDim2.new(0, 90, 0, 36)
         Buy_Btn.Position = UDim2.new(1, -100, 0.4, -18)
         Buy_Btn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
         Buy_Btn.BorderSizePixel = 0
         Buy_Btn.Text = Item.cost
         Buy_Btn.TextScaled = true
         Buy_Btn.TextColor3 = Color3.fromRGB(20, 20, 20)
         Buy_Btn.TextSize = 13
         Buy_Btn.Font = Enum.Font.Code

         Instance.new("UICorner", Buy_Btn).CornerRadius = UDim.new(0, 10)

         Buy_Btn.MouseButton1Click:Connect(function()
            if get_player_coins() < Item.cost then
               Buy_Btn.Text = "❌ Not Enough Coins ❌"
               Buy_Btn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
               task.delay(1.5, function()
                  Buy_Btn.Text = Item.cost
                  Buy_Btn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
               end)
               return
            end

            Buy_Btn.Text = "..."
            Buy_Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)

            g.spend_coins(Item.item_key, Item.cost, function(Success, Reason, Remaining)
               if Success then
                  Buy_Btn.Text = "✅ Done ✅"
                  Buy_Btn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
                  Coins_Label.Text = "🪙 " .. (Remaining or get_player_coins())
                  task.delay(1.5, function()
                     Buy_Btn.Text = Item.cost
                     Buy_Btn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
                  end)

                  if g["on_shop_buy_" .. Item.item_key] then
                     g["on_shop_buy_" .. Item.item_key]()
                  end
               else
                  local Msg = Reason == "insufficient_funds" and "❌ broke" or "❌ error"
                  Buy_Btn.Text = Msg
                  Buy_Btn.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
                  task.delay(1.5, function()
                     Buy_Btn.Text = Item.cost
                     Buy_Btn.BackgroundColor3 = Color3.fromRGB(255, 190, 0)
                  end)
               end
            end)
         end)

         Buy_Btn.MouseEnter:Connect(function()
            TweenService:Create(Buy_Btn, TweenInfo.new(0.15), {
               BackgroundColor3 = Color3.fromRGB(255, 220, 60)
            }):Play()
         end)

         Buy_Btn.MouseLeave:Connect(function()
            TweenService:Create(Buy_Btn, TweenInfo.new(0.15), {
               BackgroundColor3 = Color3.fromRGB(255, 190, 0)
            }):Play()
         end)
      end

      local function open_shop()
         Main.Visible = true
         Main.Size = UDim2.new(0, 0, 0, 0)
         Main.Position = UDim2.new(0.5, 0, 0.5, 0)
         TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 400, 0, 500),
            Position = UDim2.new(0.5, -200, 0.5, -250)
         }):Play()
      end

      local function close_shop()
         TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
         }):Play()
         task.delay(0.2, function()
            Main.Visible = false
         end)
      end

      local function minimize_shop()
         if is_minimized then
            is_minimized = false
            TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
               Size = UDim2.new(0, 400, 0, 500)
            }):Play()
            Minimize_Btn.Text = "-"
         else
            is_minimized = true
            TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
               Size = UDim2.new(0, 400, 0, 54)
            }):Play()
            Minimize_Btn.Text = "+"
         end
      end

      Close_Btn.MouseButton1Click:Connect(close_shop)
      Minimize_Btn.MouseButton1Click:Connect(minimize_shop)

      local drag_start, start_pos
      Title_Bar.InputBegan:Connect(function(Input)
         if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            drag_start = Input.Position
            start_pos = Main.Position
            Input.Changed:Connect(function()
               if Input.UserInputState == Enum.UserInputState.End then
                  drag_start = nil
               end
            end)
         end
      end)

      Title_Bar.InputChanged:Connect(function(Input)
         if Input.UserInputType == Enum.UserInputType.MouseMovement and drag_start then
            local Delta = Input.Position - drag_start
            Main.Position = UDim2.new(
               start_pos.X.Scale,
               start_pos.X.Offset + Delta.X,
               start_pos.Y.Scale,
               start_pos.Y.Offset + Delta.Y
            )
         end
      end)

      local Leaderstats = Local_Player:FindFirstChild("leaderstats")
      if Leaderstats then
         local Coins = Leaderstats:FindFirstChild("Coins")
         if Coins then
            Coins.Changed:Connect(function(Value)
               Coins_Label.Text = "🪙 " .. Value
            end)
         end
      end

      g.open_shop = open_shop
      g.close_shop = close_shop

      return Screen_Gui
   end

   g.shop_gui = build_shop_gui()
   g.toggle_shop = function()
      local Main = CoreGui:FindFirstChild("FlamesShopGui") and CoreGui.FlamesShopGui:FindFirstChild("Main")
      if not Main then
         g.shop_gui = build_shop_gui()
         g.open_shop()
         return
      end
      if Main.Visible then
         g.close_shop()
      else
         g.open_shop()
      end
   end--]]

   -- [[ Welcome aboard Changelogs GUI! ]] --
   g.CreateChangelogGUI = function()
      if g.ChangelogGUI_Loaded then
         notify("Warning","Changelogs GUI is already loaded.",5)
         return
      end
      g.ChangelogGUI_Loaded = true

      if g.smooth_drag_cmdmenu_gui then
         g.smooth_drag_cmdmenu_gui:Disconnect()
         g.smooth_drag_cmdmenu_gui = nil
      end

      local ScreenGui = Instance.new("ScreenGui")
      ScreenGui.Name = "ChangelogScreen"
      ScreenGui.ResetOnSpawn = false
      ScreenGui.IgnoreGuiInset = true
      ScreenGui.Parent = parent_gui

      local ChangelogGUI = Instance.new("Frame")
      ChangelogGUI.Name = "ChangelogGUI"
      g.MainChangelogs_GUI_Frame = ChangelogGUI

      if not isMobile then
         ChangelogGUI.Size = UDim2.new(0,550,0,400)
         ChangelogGUI.Position = UDim2.new(0.5,-275,0.5,-200)
      else
         ChangelogGUI.Size = UDim2.new(0,300,0,320)
         ChangelogGUI.Position = UDim2.new(0.5,-903,0.5,-20)
      end

      ChangelogGUI.BackgroundColor3 = Color3.fromRGB(30,30,30)
      ChangelogGUI.BorderSizePixel = 0
      ChangelogGUI.Parent = ScreenGui

      --flowrgb("ChangelogGUIFlowConn",3,ChangelogGUI,true)

      local UICorner = Instance.new("UICorner")
      UICorner.CornerRadius = UDim.new(0,12)
      UICorner.Parent = ChangelogGUI

      local TitleBar = Instance.new("Frame")
      TitleBar.Size = UDim2.new(1,0,0,35)
      TitleBar.BackgroundTransparency = 1
      TitleBar.Parent = ChangelogGUI

      local TitleLabel = Instance.new("TextLabel")
      TitleLabel.Size = UDim2.new(1,-35,1,0)
      TitleLabel.Position = UDim2.new(0,3,0,2)
      TitleLabel.BackgroundTransparency = 1
      TitleLabel.Text = "Flames Hub - Changelogs"
      TitleLabel.Font = Enum.Font.GothamBold
      TitleLabel.TextScaled = true
      TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
      TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
      TitleLabel.Parent = TitleBar

      local CloseButton = Instance.new("TextButton")
      CloseButton.Size = UDim2.new(0,30,0,30)
      CloseButton.Position = UDim2.new(1,-30,0.5,-2)
      CloseButton.AnchorPoint = Vector2.new(0,0.5)
      CloseButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
      CloseButton.Text = "X"
      CloseButton.TextScaled = true
      CloseButton.Font = Enum.Font.GothamBold
      CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
      CloseButton.Parent = TitleBar
      Instance.new("UICorner",CloseButton).CornerRadius = UDim.new(0,6)

      local ScrollingFrame = Instance.new("ScrollingFrame")
      ScrollingFrame.Size = UDim2.new(1,0,1,-35)
      ScrollingFrame.Position = UDim2.new(0,0,0,35)
      ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
      ScrollingFrame.BackgroundTransparency = 1
      ScrollingFrame.ScrollBarThickness = 6
      ScrollingFrame.Parent = ChangelogGUI

      local Layout = Instance.new("UIListLayout")
      Layout.Padding = UDim.new(0,10)
      Layout.SortOrder = Enum.SortOrder.LayoutOrder
      Layout.Parent = ScrollingFrame

      Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
         ScrollingFrame.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
      end)

      local Padding = Instance.new("UIPadding")
      Padding.PaddingTop = isMobile and UDim.new(0,5) or UDim.new(0,10)
      Padding.Parent = ScrollingFrame

      CloseButton.MouseButton1Click:Connect(function()
         ScreenGui:Destroy()
         g.ChangelogGUI_Loaded = false
      end)

      dragify(ChangelogGUI)

      function AddChangelog(date,text)
         local Container = Instance.new("Frame")
         Container.Size = UDim2.new(1,0,0,90)
         Container.BackgroundColor3 = Color3.fromRGB(40,40,40)
         Container.BorderSizePixel = 0
         Container.Parent = ScrollingFrame
         Instance.new("UICorner",Container).CornerRadius = UDim.new(0,8)

         local DateLabel = Instance.new("TextLabel")
         DateLabel.Size = UDim2.new(1,-10,0,25)
         DateLabel.Position = UDim2.new(0,10,0,5)
         DateLabel.BackgroundTransparency = 1
         DateLabel.Font = Enum.Font.GothamBold
         DateLabel.TextScaled = true
         DateLabel.TextColor3 = Color3.fromRGB(255,255,255)
         DateLabel.TextXAlignment = Enum.TextXAlignment.Left
         DateLabel.Text = date
         DateLabel.Parent = Container

         local TextLabel = Instance.new("TextLabel")
         TextLabel.Size = UDim2.new(1,-20,0,55)
         TextLabel.Position = UDim2.new(0,10,0,35)
         TextLabel.BackgroundTransparency = 1
         TextLabel.Font = Enum.Font.Gotham
         TextLabel.TextScaled = true
         TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
         TextLabel.TextXAlignment = Enum.TextXAlignment.Left
         TextLabel.TextWrapped = true
         TextLabel.Text = text
         TextLabel.Parent = Container
      end

      task.spawn(function()
         local ok,data = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/LifeTogetherAdminChangeLogs/refs/heads/main/LifeTogetherAdmin_Changelogs.js")
         end)

         if not ok or not data or data == "" then
            AddChangelog("Error","Failed to load changelogs.")
            return
         end

         local loaded = false

         for block in string.gmatch(data,"[^\n][^\n]*\n.-\n\n") do
            local header,body = block:match("^(.-)\n(.*)")
            if header and body then
               body = body:gsub("\n+$","")
               AddChangelog(header,body)
               loaded = true
            end
         end

         if not loaded then
            AddChangelog("Notice","Changelog file loaded, but no readable entries were found.")
         end
      end)
   end
   fw(0.2)
   if not g.HasSeen_Changelogs_GUI_Startup then
      CreateChangelogGUI()

      g.HasSeen_Changelogs_GUI_Startup = true
   end

   if not g.SetupGone_Through_Flames_Hub then
      pcall(function()
         g.LocalPlayer:SetSuperSafeChat(false)
         g.LocalPlayer.CameraMaxZoomDistance = 100000
         g.LocalPlayer.CameraMinZoomDistance = 0.5
      
         if g.LocalPlayer.CameraMaxZoomDistance > 90000 then
            notify("Success", "Set CameraMaxZoomDistance to: "..tostring(g.LocalPlayer.CameraMaxZoomDistance), 7)
         else
            notify("Warning", "We we're not able to correctly set CameraMaxZoomDistance!", 5)
         end
         if g.LocalPlayer.CameraMinZoomDistance < 5 then
            notify("Success", "Set CameraMinZoomDistance to: "..tostring(g.LocalPlayer.CameraMinZoomDistance), 7)
         else
            notify("Warning", "We we're not able to correctly set CameraMinZoomDistance!", 5)
         end

         if g.StarterPlayer.CharacterUseJumpPower then
            g.Humanoid.JumpPower = 50
            notify("Success", "Spoofed JumpPower to: "..tostring(g.Humanoid.JumpPower))
         else
            g.Humanoid.JumpHeight = 7
            notify("Success", "Spoofed JumpHeight to: "..tostring(g.Humanoid.JumpHeight))
         end
         g.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
         if g.LocalPlayer.Name == "CIippedByAura" or g.LocalPlayer.Name == "L0CKED_1N1" then
            g.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
            notify("Success", "Enabled Leaderboard & Backpack.", 5)
         else
            notify("Success", "Enabled Leaderboard.", 5)
         end
      end)

      g.SetupGone_Through_Flames_Hub = true
   end

   loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogetherRP_Admin_CommandHandler.lua"))()

   if not g.SeenCommandAndCameraIntro then
      notify("Success", "[HOOKED]: We have hooked the Camera successfully.", 5)
      fw(0.2)
      notify("Warning", "[INITIALIZING]: Setting up command receiver...", 5)
      fw(0.1)
      g.SeenCommandAndCameraIntro = true
   end

   if not g.ChatMessageHooks then g.ChatMessageHooks = {} end
   g.global_isinchat_msghooks = function(func)
      for _, v in ipairs(g.ChatMessageHooks) do
         if v == func then return true end
      end
      return false
   end

   g.handle_chattercommands = function(sender, msg)
      g.handleCommand(sender, msg.Text)
   end

   if not global_isinchat_msghooks(handle_chattercommands) then
      table.insert(g.ChatMessageHooks, handle_chattercommands)
   end

   g.DirectCommand = function(text)
      local prefix = tostring(g.AdminPrefix or ";")
      text = tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", "")
      if text == "" then return end
      if text:sub(1, #prefix) ~= prefix then
         text = prefix .. text
      end
      local player = g.LocalPlayer or game.Players.LocalPlayer
      g.handleCommand(player, text)
   end

   g.command_bar_GUI = function(forceOpen)
      if g.__cmdbarloaded then
         if g.togglecommandbar then
            g.togglecommandbar(forceOpen)
         end
         return
      end

      g.__cmdbarloaded = true
      g.__cmdbar_busy = false
      g.commandHistory = g.commandHistory or {}
      g.historyIndex = #g.commandHistory + 1

      local rootGui = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or g.CoreGui
      local swallowing_prefix = false
      local guiMain = Instance.new("ScreenGui")
      guiMain.Name = "CmdBar_UI"
      guiMain.Parent = rootGui
      guiMain.IgnoreGuiInset = true
      guiMain.ResetOnSpawn = false

      local holder = Instance.new("Frame")
      holder.Parent = guiMain
      holder.AnchorPoint = Vector2.new(0.5,0)
      holder.Position = UDim2.new(0.5,0,0,-60)
      holder.Size = UDim2.new(0.8,0,0,50)
      holder.BackgroundColor3 = Color3.fromRGB(30,30,30)
      holder.BackgroundTransparency = 0.15
      holder.BorderSizePixel = 0
      holder.Visible = false
      holder.ZIndex = 6
      Instance.new("UICorner", holder).CornerRadius = UDim.new(0,8)

      local inputBox = Instance.new("TextBox")
      inputBox.Parent = holder
      inputBox.AnchorPoint = Vector2.new(0.5,0.5)
      inputBox.Position = UDim2.new(0.5,0,0.5,0)
      inputBox.Size = UDim2.new(1,-20,1,-10)
      inputBox.BackgroundTransparency = 1
      inputBox.Text = ""
      inputBox.PlaceholderText = tostring(g.AdminPrefix or ";")
      inputBox.TextColor3 = Color3.new(1,1,1)
      inputBox.Font = Enum.Font.GothamMedium
      inputBox.TextScaled = true
      inputBox.ClearTextOnFocus = false
      inputBox.ZIndex = 7

      local historyFrame = Instance.new("Frame")
      historyFrame.Parent = guiMain
      historyFrame.AnchorPoint = Vector2.new(0.5,0)
      historyFrame.Position = UDim2.new(0.5,0,0,60)
      historyFrame.Size = UDim2.new(0.8,0,0,160)
      historyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
      historyFrame.BackgroundTransparency = 0.1
      historyFrame.Visible = false
      historyFrame.ZIndex = 6
      historyFrame.BorderSizePixel = 0
      Instance.new("UICorner", historyFrame).CornerRadius = UDim.new(0,8)

      local listLayout = Instance.new("UIListLayout")
      listLayout.Parent = historyFrame
      listLayout.Padding = UDim.new(0,6)

      local openState = false
      local historyButtons = {}
      local openUI, closeUI
      local function rebuildHistory()
         for _,v in ipairs(historyFrame:GetChildren()) do
            if v:IsA("TextButton") then
               v:Destroy()
            end
         end
         historyButtons = {}

         for i = #g.commandHistory, math.max(#g.commandHistory-9,1), -1 do
            local cmd = g.commandHistory[i]
            local btn = Instance.new("TextButton")
            btn.Name = tostring(cmd)
            btn.Parent = historyFrame
            btn.Size = UDim2.new(1,-12,0,28)
            btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Text = cmd
            btn.Font = Enum.Font.Gotham
            btn.TextScaled = true
            btn.BorderSizePixel = 0
            btn.ZIndex = 7
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

            table.insert(historyButtons, {btn = btn, cmd = cmd})
            btn.Activated:Connect(function()
               g.DirectCommand(tostring(cmd))
            end)
         end
      end

      local function pushHistory(cmd)
         if cmd == "" then return end
         if g.commandHistory[#g.commandHistory] == cmd then return end
         table.insert(g.commandHistory, cmd)
         if #g.commandHistory > 100 then
            table.remove(g.commandHistory,1)
         end
         g.historyIndex = #g.commandHistory + 1
         rebuildHistory()
      end

      local function runCmd()
         local txt = inputBox.Text
         if txt == "" then return end
         pushHistory(txt)
         inputBox.Text = ""
         task.spawn(function()
            if g.DirectCommand and typeof(g.DirectCommand) == "function" then g.DirectCommand(txt) end
         end)
      end

      openUI = function()
         if openState then return end
         openState = true
         holder.Visible = true
         historyFrame.Visible = true

         holder.Position = UDim2.new(0.5,0,0,-60)
         historyFrame.Position = UDim2.new(0.5,0,0,60)

         g.TweenService:Create(holder,TweenInfo.new(0.25),{Position=UDim2.new(0.5,0,0,5)}):Play()
         g.TweenService:Create(historyFrame,TweenInfo.new(0.25),{Position=UDim2.new(0.5,0,0,60)}):Play()

         task.delay(0.03,function()
            inputBox:CaptureFocus()
         end)
      end

      closeUI = function()
         if not openState then return end
         openState = false
         historyFrame.Visible = false

         g.TweenService:Create(holder,TweenInfo.new(0.25),{Position=UDim2.new(0.5,0,0,-60)}):Play()
         task.delay(0.01,function()
            holder.Visible = false
            inputBox.Text = ""
         end)
      end

      local function toggleBar(v)
         if typeof(v) == "boolean" then
            if v then openUI() else closeUI() end
         else
            if openState then closeUI() else openUI() end
         end
      end

      -- raw input hit detection for history buttons, bypasses GUI event system entirely. --
      UserInputService.InputBegan:Connect(function(input, gp)
         if gp then return end
         if not openState then return end
         if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
         if g.__cmdbar_busy then return end
         local pos = input.Position
         task.wait()
         for _, entry in ipairs(historyButtons) do
            local btn = entry.btn
            local cmd = entry.cmd
            if not btn or not btn.Parent then continue end
            local abs = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            if size.X == 0 or size.Y == 0 then continue end
            if pos.X >= abs.X and pos.X <= abs.X + size.X and
               pos.Y >= abs.Y and pos.Y <= abs.Y + size.Y then

               g.__cmdbar_busy = true
               inputBox.Text = ""
               closeUI()

               task.spawn(function()
                  if g.DirectCommand and typeof(g.DirectCommand) == "function" then
                     g.DirectCommand(cmd)
                  end
                  g.__cmdbar_busy = false
               end)
               return
            end
         end
      end)

      inputBox.InputBegan:Connect(function(i)
         if i.KeyCode == Enum.KeyCode.Up then
            g.historyIndex = math.clamp(g.historyIndex-1,1,#g.commandHistory)
            inputBox.Text = g.commandHistory[g.historyIndex] or ""
            inputBox.CursorPosition = #inputBox.Text + 1
         elseif i.KeyCode == Enum.KeyCode.Down then
            g.historyIndex = math.clamp(g.historyIndex+1,1,#g.commandHistory+1)
            inputBox.Text = g.commandHistory[g.historyIndex] or ""
            inputBox.CursorPosition = #inputBox.Text + 1
         end
      end)

      inputBox.FocusLost:Connect(function(enter)
         if g.__cmdbar_busy then return end
         g.__cmdbar_busy = true
         if enter then runCmd() end
         task.delay(0.2, function()
            closeUI()
            g.__cmdbar_busy = false
         end)
      end)

      local ismobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
      if ismobile then
         local mobilebtn = Instance.new("TextButton")
         mobilebtn.Parent = guiMain
         mobilebtn.Size = UDim2.new(0,48,0,48)
         mobilebtn.Position = UDim2.new(1,-60,1,-120)
         mobilebtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
         mobilebtn.TextColor3 = Color3.new(1,1,1)
         mobilebtn.Text = ">"
         mobilebtn.Font = Enum.Font.GothamBold
         mobilebtn.TextScaled = true
         mobilebtn.BorderSizePixel = 0
         mobilebtn.ZIndex = 8
         Instance.new("UICorner", mobilebtn).CornerRadius = UDim.new(1,0)
         wait(0.5)
         dragify(mobilebtn)

         mobilebtn.Activated:Connect(function()
            g.togglecommandbar()
         end)
      end

      UserInputService.InputEnded:Connect(function(i)
         if not swallowing_prefix then return end
         local pref = tostring(g.AdminPrefix or ";")

         local isprefix =
            (pref==";" and i.KeyCode==Enum.KeyCode.Semicolon) or
            (pref=="." and i.KeyCode==Enum.KeyCode.Period) or
            (pref=="," and i.KeyCode==Enum.KeyCode.Comma) or
            (pref=="'" and i.KeyCode==Enum.KeyCode.Quote) or
            (pref=="/" and i.KeyCode==Enum.KeyCode.Slash)

         if not isprefix then return end

         swallowing_prefix = false
         inputBox.TextEditable = true
      end)

      UserInputService.InputBegan:Connect(function(i,gp)
         if gp then return end
         local pref = tostring(g.AdminPrefix or ";")
         local prefixKey =
            (pref==";" and i.KeyCode==Enum.KeyCode.Semicolon) or
            (pref=="." and i.KeyCode==Enum.KeyCode.Period) or
            (pref=="," and i.KeyCode==Enum.KeyCode.Comma) or
            (pref=="'" and i.KeyCode==Enum.KeyCode.Quote) or
            (pref=="/" and i.KeyCode==Enum.KeyCode.Slash)

         if prefixKey then
            swallowing_prefix = true
            inputBox.TextEditable = false
            toggleBar(true)

            task.defer(function()
               inputBox.Text = pref
               inputBox.CursorPosition = #pref + 1
            end)
         elseif i.KeyCode == Enum.KeyCode.RightShift then
            toggleBar()
         end
      end)

      g.togglecommandbar = toggleBar
      toggleBar(false)
   end

   g.command_bar_GUI = command_bar_GUI
   if not executor_string:lower():find("velocity") then
      g.command_bar_GUI(false)
   end

   setup_cmd_handler_plr(v)

   if not g.AdminHasBeenLoaded_NotificationCheck then
      notify("Success", "[INITIALIZED]: Life Together RP-Admin has been loaded!", 7)
      notify("Success", "[LOADED]: | [Life Together-RP : Admin_Commands]: Loaded!", 7)
      g.AdminHasBeenLoaded_NotificationCheck = true
   end

   function auto_add_friends()
      for _, v in ipairs(g.Players:GetPlayers()) do
         if v ~= g.LocalPlayer and v:IsFriendsWith(g.LocalPlayer.UserId) then
            alreadyCheckedUser(v)
         end
      end
   end

   function auto_remove_friends()
      for _, v in ipairs(g.Players:GetPlayers()) do
         if v ~= g.LocalPlayer and v:IsFriendsWith(g.LocalPlayer.UserId) and v.Character == nil then
            g.Rainbow_Others_Vehicle = false
         end
      end
   end

   if g.LifeTogetherRP_Admin and g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub and g.LifeTogether_Actual_Flames_Hub_Running_Functioning_Currently_On_Client then
      notify("Success", "Reloaded script successfully.", 15)
   end

   for _, v in ipairs(game.Players:GetPlayers()) do
      if v.Name == "CIippedByAura" or v.Name == "L0CKED_1N1" then
         notify("Success", "Flames Hub | Owner is currently in this server, come to me: ("..tostring(v.Name)..") for assistance (if you need help).", 45)
      elseif allowed[v.Name] and v.Name ~= "CIippedByAura" and v.Name ~= "L0CKED_1N1" then
         g.notify("Success", "A Flames Hub | Staff member is currently in this server, this is more rare and they can get in contact with me faster.", 30)
      end
   end

   g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub = g.Script_Loaded_Correctly_LifeTogether_Admin_Flames_Hub or true
   if not g.FlamesHubPlayerEvents_Check then
      g.FlamesHubPlayerEvents_Check = true
      g.FlamesLibrary.connect("PlayerAdded_OwnerAdminCheck", Players.PlayerAdded:Connect(function(Player)
         local Name = Player and Player.Name
         g.Blacklisted_Friends = g.Blacklisted_Friends or {}
         if Player:IsFriendsWith(g.LocalPlayer.UserId) then
            if not g.Blacklisted_Friends[Name] then
               auto_add_friends()
            end
         end

         -- [[ make who ever you want the owner, like yourself. ]] --
         if Name == "CIippedByAura" or Name == "L0CKED_1N1" then
            owner_joined(Name)
            if g.friend_checked[Name] then
               g.player_admins[Name] = nil
               g.friend_checked[Name] = nil
            end
            if g.cmds_loaded_plr[Name] then
               g.cmds_loaded_plr[Name] = nil
            end
         elseif allowed[Name] and Name ~= "L0CKED_1N1" and Name ~= "CIippedByAura" then
            g.notify("Success", "An official staff member of Flames Hub has joined your server, UserName: "..tostring(Name), 15)
         end
      end))

      g.FlamesLibrary.connect("PlayerRemoving_OwnerAdminRemoval", Players.PlayerRemoving:Connect(function(Player)
         local Name = Player.Name

         if Name == "CIippedByAura" or Name == "L0CKED_1N1" then
            notify("Info", "The owner of this script has left the server.", 6)
         elseif allowed[Name] and Name ~= "L0CKED_1N1" and Name ~= "CIippedByAura" then
            g.notify("Success", "Flames Hub | Staff member has left your server: "..tostring(Name), 15)
         end

         disable_rgb_for(Name)
         g.fully_disable_rgb_plr(Name)
         if g.Locked_Vehicles[Name] then
            g.Locked_Vehicles[Name] = false
         end
         if g.Unlocked_Vehicles[Name] then
            g.Unlocked_Vehicles[Name] = false
         end
      end))
   end

   notify("Success", "Welcome back, "..tostring(g.LocalPlayer.DisplayName)..".", 10)

   if not isMobile then
      g.command_bar_GUI(false)
   end

   local function print_bytes(label, s)
      local bytes = {}
      for i = 1, #s do
         table.insert(bytes, string.byte(s, i))
      end
      print(label .. ": " .. table.concat(bytes, ","))
   end
   local function clean(s) return s:gsub("[%c%z%s]", ""):gsub("[^\32-\126]", "") end
   local script_url = "https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/LifeTogether_RP_Admin.lua" -- or what ever you want it to be.
   local function ws_get_version()
      if not g.ws_main_reactor_connector then return nil end
      local result = nil
      local done = false
      local connection
      connection = g.ws_main_reactor_connector.OnMessage:Connect(function(msg)
         if done then return end
         local ok, data = pcall(g.HttpService.JSONDecode, g.HttpService, msg)
         if ok and type(data) == "table" and data.type == "version_response" then
            if data.version then
               result = tostring(data.version):gsub("%s+", "")
            end
            done = true
            connection:Disconnect()
         end
      end)

      g.ws_main_reactor_connector:Send(g.HttpService:JSONEncode({
         type = "get_version"
      }))

      local start = os.clock()
      while not done and (os.clock() - start) < 8 do
         task.wait(0.05)
      end

      if not done then
         pcall(function() connection:Disconnect() end)
      end

      return result
   end

   local function Notify(msg, dur)
      dur = dur or 5

      local gui = Instance.new("ScreenGui")
      gui.Name = "CustomNotifyGui"
      gui.ResetOnSpawn = false
      gui.Parent = g.CoreGui

      local frame = Instance.new("Frame")
      frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
      frame.BackgroundTransparency = 1
      frame.BorderSizePixel = 0
      frame.Size = UDim2.new(0, 500, 0, 120)
      frame.Position = UDim2.new(0, 20, 0, 100)
      frame.Parent = gui

      Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

      local icon = Instance.new("ImageLabel")
      icon.BackgroundTransparency = 1
      icon.Position = UDim2.new(0, 15, 0.5, -25)
      icon.Size = UDim2.new(0, 50, 0, 50)
      icon.Image = "rbxasset://textures/ui/Emotes/ErrorIcon.png"
      icon.ImageTransparency = 1
      icon.Parent = frame

      local label = Instance.new("TextLabel")
      label.BackgroundTransparency = 1
      label.Position = UDim2.new(0, 80, 0, 10)
      label.Size = UDim2.new(1, -90, 1, -20)
      label.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json")
      label.Text = msg
      label.TextColor3 = Color3.fromRGB(255, 255, 255)
      label.TextSize = 20
      label.TextWrapped = true
      label.TextXAlignment = Enum.TextXAlignment.Left
      label.TextYAlignment = Enum.TextYAlignment.Top
      label.TextTransparency = 1
      label.Parent = frame

      g.TweenService:Create(frame, TweenInfo.new(0.3), { BackgroundTransparency = 0.3 }):Play()
      g.TweenService:Create(icon, TweenInfo.new(0.3), { ImageTransparency = 0 }):Play()
      g.TweenService:Create(label, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()

      task.delay(dur, function()
         if not frame.Parent then return end
         g.TweenService:Create(frame, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
         g.TweenService:Create(icon, TweenInfo.new(0.3), { ImageTransparency = 1 }):Play()
         g.TweenService:Create(label, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
         task.wait(0.35)
         gui:Destroy()
      end)
   end

   g.lta_updater_running = g.lta_updater_running or false
   g.lta_updater_thread_id = (g.lta_updater_thread_id or 0) + 1
   local thread_id = g.lta_updater_thread_id
   if not g.lta_updater_running then
      g.lta_updater_running = true

      task.spawn(function()
         while g.lta_updater_running and thread_id == g.lta_updater_thread_id do
            task.wait(5)
            local local_version = tostring(g.Script_Version or ""):gsub("^V", ""):gsub("%s+", "")
            if local_version == "" then
               print("Script_Version not set yet, skipping...")
               continue
            end

            local remote_version = ws_get_version()
            if not remote_version or remote_version == "" then
               --print("Version fetch failed.")
               continue
            end

            -- [[ for debugging. ]] --
            --print_bytes("local_version", local_version)
            --print_bytes("remote_version", remote_version)

            if remote_version ~= local_version then
               g.lta_updater_running = false

               Notify("[UPDATE DETECTED]:\nLocal: " .. local_version .. "\nServer: " .. remote_version .. "\nReloading...", 6)
               task.wait(0.6)
               g.LifeTogether_Actual_Flames_Hub_Running_Functioning_Currently_On_Client = false
               getgenv().Script_Version = nil
               g.LifeTogetherRP_Admin = false
               pcall(function()
                  loadstring(game:HttpGet(script_url .. "?cache=" .. tostring(os.clock())))()
               end)
               break
            end
         end
      end)
   end
end
wait(0.5)
if not g.LifeTogether_Actual_Flames_Hub_Running_Functioning_Currently_On_Client then
   g.LifeTogether_Actual_Flames_Hub_Running_Functioning_Currently_On_Client = true
   g.Start_Actual_Flames_Hub_Script()
end
