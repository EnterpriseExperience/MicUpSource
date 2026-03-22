getgenv().handleCommand = function(sender, message)
   if not Admins[sender.Name] then return end

   -- [[ little bits of explanation below for the skids lmfao. ]] --
   -- [[ write to getgenv().Known_Admin_Commands if not already existant to prevent further issues. ]] --
   getgenv().sanitize_message = function(str) -- clean command message.
      local cleaned = str:gsub("%b()", "")
      cleaned = cleaned:gsub("[%z\1-\127\194-\244][\128-\191]*", function(c) -- direct.
         return (c:match("[%w%s%p]") and c) or "" -- don't return anything if we don't need to.
      end)
      return cleaned:match("^%s*(.-)%s*$") -- return that sanitized message.
   end

   message = sanitize_message(message or "") -- fully wipe the message to check if includes other unwanted text.

   local prefix = tostring(getgenv().AdminPrefix or ";") -- send to tostring or default back to ;.
   if message:sub(1, #prefix):lower() ~= prefix:lower() then return end

   local msg_no_prefix = message:sub(#prefix + 1) -- subtract prefix from the message obviously.
   local split = msg_no_prefix:split(" ") -- split here (basically for secondary arguments like > -kill Player > split[1] would be 'Player' essentially).
   local raw_cmd = (table.remove(split, 1) or ""):lower() -- fully strip the command from split to ensure the command is processed correctly.
   local cmd = raw_cmd -- easier access.
   local args = split -- argument(s) from split.
   local best, bestDist = raw_cmd, math.huge
   -- [[ levenshtein functionality handling below, handles pure text difference and matching for us. ]] --

   -- [[ add the distance with the command and compare it to make sure the command is an actual command. ]] --
   for _, real in ipairs(getgenv().Known_Admin_Commands) do
      local dist = levenshtein(raw_cmd, real)
      if dist < bestDist then
         bestDist = dist
         best = real
      end
   end

   -- [[ check if the user was really that much off, and if so, auto-correct the command automatically (people can't type tbh). ]] --
   local allowedDist = math.max(1, math.floor(#raw_cmd / 3)) -- ~1/3 of command length
   -- [[ now fixes the issues where 'un' and 'stop' weren't being detected in the command/message. ]] --
   if not (raw_cmd:sub(1,2) == "un" or raw_cmd:sub(1,4) == "stop" or best:sub(1,2) == "un" or best:sub(1,4) == "stop") and bestDist <= allowedDist and best ~= raw_cmd then
      getgenv().notify("Info", ("Auto-corrected '%s' -> '%s%s'"):format(raw_cmd, prefix, best), 6)
      raw_cmd = best
   end
   
   -- [[ clean the sent message command properly (from the raw command that was entered). ]] --
   local cleanedMessage = raw_cmd
   if #args > 0 then -- cleaned?
      cleanedMessage = cleanedMessage .. " " .. table.concat(args, " ") -- sweep it.
   end

   if getgenv().LocalPlayer.Name ~= "CIippedByAura" then -- don't handle command processing internally if you're me since I always am in testing mode with mine by default.
      getgenv().CommandAPI.Handle_Command(
         getgenv().LocalPlayer or game.Players.LocalPlayer,
         prefix .. cleanedMessage
      )
   end
   getgenv().Anti_Sit_Connection = getgenv().Anti_Sit_Connection or nil
   getgenv().anti_knockback_connection = getgenv().anti_knockback_connection or nil
   local Clip = false

   if raw_cmd == "prefix" then
      local new_prefix = tostring(split[1] or ""):gsub("%s+", "") -- take that new prefix entered from the split part of the message (after the command).

      if not getgenv().isAllowedPrefix(new_prefix) then -- is it in the allowed prefixes?
         return getgenv().notify("Warning", "This is not an allowed Prefix, sorry! Please use a regular symbolized prefix.", 7)
      end

      -- Yes, I know, finally add a check for the Prefix command, to ensure you're not able to set a blank prefix, or one with any white spaces at all.
      if new_prefix == "" then
         return getgenv().notify("Error", "Invalid prefix! It cannot be empty.", 5) -- return notify the user, since they probably won't get it otherwise.
      end
      getgenv().AdminPrefix = new_prefix
      savePrefix(getgenv().AdminPrefix) -- then if it is ACTUALLY correct, THEN we can set it, finally (save it as well, of course).
      wait(0.1) -- hold up.
      getgenv().notify("Success", "Prefix has been changed to '" .. new_prefix .. "'", 5)
      return 
   end

   if raw_cmd == "startrgbcar" or raw_cmd == "startrgbvehicle" or raw_cmd == "rgbcar" or raw_cmd == "rgbvehicle" or raw_cmd == "rgbcaron" or raw_cmd == "rgbvehicleon" then
      if getgenv().Rainbow_Vehicle then
         return getgenv().notify("Warning", "RGB vehicle is already enabled!", 5)
      end

      rainbow_car()
   elseif raw_cmd == "commandbar" or raw_cmd == "cmdbar" or raw_cmd == "commandsbar" or raw_cmd == "cmdsbar" then
      command_bar_GUI(true)
   elseif raw_cmd == "stoprgbcar" or raw_cmd == "stoprgbvehicle" or raw_cmd == "unrgbcar" or raw_cmd == "norgbcar" or raw_cmd == "unrgbvehicle" or raw_cmd == "rgbcaroff" or raw_cmd == "rgbvehicleoff" then
      if not getgenv().Rainbow_Vehicle then
         return getgenv().notify("Warning", "RGB vehicle is not enabled!", 5)
      end

      stop_rainbow_car()
   elseif raw_cmd == "rgbstreetlights" or raw_cmd == "rainbowstreetlights" or raw_cmd == "rgbstreetl" or raw_cmd == "startrgbstreetlights" or raw_cmd == "togglergbsl" or raw_cmd == "rgbsl" then
      toggle_rgb_streetlights(true)
   elseif raw_cmd == "unrgbstreetlights" or raw_cmd == "unrainbowstreetlights" or raw_cmd == "unrgbstreetl" or raw_cmd == "stoprgbstreetlights" or raw_cmd == "untogglergbsl" or raw_cmd == "unrgbsl" then
      toggle_rgb_streetlights(false)
   elseif raw_cmd == "rgbskin" or raw_cmd == "startrgbskin" or raw_cmd == "rainbowskin" or raw_cmd == "rgbskinon" or raw_cmd == "rainbowskinon" then
      rainbow_skin(true)
   elseif raw_cmd == "flames" or raw_cmd == "flameson" or raw_cmd == "startflames" then
      if getgenv().spamming_all_that_fire then
         return getgenv().notify("Warning", "You're already spamming Fire!", 5)
      end
      if getgenv().LocalPlayer:GetAttribute("is_verified") == false then
         return getgenv().notify("Error", "You need actual LifePay premium to run this!", 6)
      end

      getgenv().spamming_flames(true)
   elseif raw_cmd == "noflames" or raw_cmd == "flamesoff" or raw_cmd == "stopflames" or raw_cmd == "unflames" then
      if not getgenv().spamming_all_that_fire then
         return getgenv().notify("Warning", "You're not spamming Fire!", 5)
      end

      getgenv().spamming_flames(false)
   elseif raw_cmd == "checkpremium" or raw_cmd == "haspremium" or raw_cmd == "premiumcheck" or raw_cmd == "haslifepay" then
      local Player = findplr(split[1])
      if not Player then return getgenv().notify("Error", "Player doesn't exist or left the game.", 5) end

      local Result = check_premium_player(Player)

      if Result == true then
         return getgenv().notify("Success", "[Result]: "..tostring(Player.Name).." does have premium!", 5)
      elseif Result == false then
         return getgenv().notify("Success", "[Result]: "..tostring(Player.Name).." does not have premium.", 5)
      else
         return getgenv().notify("Error", "Something unexpectedly happened while checking Player.", 5)
      end
   elseif raw_cmd == "wfwl" or raw_cmd == "walkflingwl" or raw_cmd == "wlwalkfling" or raw_cmd == "wlwalkflingplr" or raw_cmd == "walkflingwlplr" then
      local whitelisting_plr = findplr(split[1])
      if typeof(whitelisting_plr) ~= "Instance" or not whitelisting_plr:IsA("Player") then
         return getgenv().notify("Error", "Player not found in game.", 5)
      end

      AddToWalkFlingWhitelist(whitelisting_plr)
   elseif raw_cmd == "unwfwl" or raw_cmd == "unwalkflingwl" or raw_cmd == "unwlwalkfling" or raw_cmd == "unwlwalkflingplr" or raw_cmd == "unwalkflingwlplr" then
      local removing_whitelist_plr = findplr(split[1])
      if typeof(removing_whitelist_plr) ~= "Instance" or not removing_whitelist_plr:IsA("Player") then
         return getgenv().notify("Error", "Player not found in game.", 5)
      end

      RemoveFromWalkFlingWhitelist(removing_whitelist_plr)
   elseif raw_cmd == "debugger" or raw_cmd == "flamesdebugger" or raw_cmd == "debugflames" or raw_cmd == "flamesdebug" or raw_cmd == "debuggingflames" or raw_cmd == "debug" then
      if getgenv().Flames_Debugger_Function_Tester_GUI then
         pcall(function() getgenv().Flames_Debugger_Function_Tester_GUI() end)
      else
         return getgenv().notify("Error", "Flames Debugger function not found or was not created at runtime.", 10)
      end
   elseif raw_cmd == "rainbowcar" or raw_cmd == "startrainbowcar" then
      local PlayerToRGBCar = findplr(split[1])
      if not PlayerToRGBCar then return getgenv().notify("Error", "Player does not exist!", 5) end
      if not get_other_vehicle(PlayerToRGBCar) then return getgenv().notify("Error", "Player does not have a Vehicle spawned!", 5) end
      local Checker = check_friend(PlayerToRGBCar)

      if not Checker or Checker ~= true then
         return getgenv().notify("Error", "Player is not your friend, add them to use this!", 5)
      end

      if not PlayerToRGBCar then
         return getgenv().notify("Error", "Player has magically disappeared.", 5)
      end

      if getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] then
         return getgenv().notify("Error", "Player already has they're car rainbow!", 5)
      end

      getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] = true

      local colors = {
         Color3.fromRGB(255, 255, 255),
         Color3.fromRGB(128, 128, 128),
         Color3.fromRGB(0, 0, 0),
         Color3.fromRGB(0, 0, 255),
         Color3.fromRGB(0, 255, 0),
         Color3.fromRGB(0, 255, 255),
         Color3.fromRGB(255, 165, 0),
         Color3.fromRGB(139, 69, 19),
         Color3.fromRGB(255, 255, 0),
         Color3.fromRGB(50, 205, 50),
         Color3.fromRGB(255, 0, 0),
         Color3.fromRGB(255, 155, 172),
         Color3.fromRGB(128, 0, 128),
      }

      while getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] do
         task.wait(.2)
         if PlayerToRGBCar then
            for _, color in ipairs(colors) do
               task.wait(.2)
               change_vehicle_color(color, get_other_vehicle(getgenv().Players[PlayerToRGBCar.Name]))
            end
         else
            getgenv().Rainbow_Vehicles[PlayerToRGBCar.Name] = nil
            return getgenv().notify("Error", "Player must have left the game.", 5)
         end
      end
   elseif raw_cmd == "antioutfitcopier" or raw_cmd == "antifitcopier" or raw_cmd == "antifitstealer" or raw_cmd == "antioutfitstealer" or raw_cmd == "anticopyoutfit" then
      anti_outfit_copier(true)
   elseif raw_cmd == "unantioutfitcopier" or raw_cmd == "unantifitcopier" or raw_cmd == "unantifitstealer" or raw_cmd == "unantioutfitstealer" or raw_cmd == "unanticopyoutfit" or raw_cmd == "unanticopyfit" then
      anti_outfit_copier(false)
   elseif raw_cmd == "changelogs" or raw_cmd == "changel" or raw_cmd == "changels" or raw_cmd == "changelgs" or raw_cmd == "updates" or raw_cmd == "updatelogs" or raw_cmd == "updatels" or raw_cmd == "updlogs" then
      CreateChangelogGUI()
   elseif raw_cmd == "streamermode" or raw_cmd == "streammode" or raw_cmd == "streamode" or raw_cmd == "streamermodegui" then
      streamer_mode_script()
   elseif raw_cmd == "norainbowcar" or raw_cmd == "unrainbowcar" or raw_cmd == "stoprainbowcar" then
      local PlayerToRGBCarStop = findplr(split[1])
      if not PlayerToRGBCarStop then
         return getgenv().notify("Error", "Player does not exist!", 5)
      end

      if not get_other_vehicle(PlayerToRGBCarStop) then
         return getgenv().notify("Error", "Player does not have a Vehicle spawned!", 5)
      end

      local Checker = check_friend(PlayerToRGBCarStop) or PlayerToRGBCarStop:IsFriendsWith(getgenv().LocalPlayer.UserId)
      if Checker ~= true then
         return getgenv().notify("Error", "Player is not your friend, add them to use this!", 5)
      end

      local state = getgenv().VehicleStates[PlayerToRGBCarStop.Name]
      if not state or state.rainbow ~= true then
         return getgenv().notify(
            "Warning",
            "This Player does not have Rainbow Vehicle enabled.",
            6
         )
      end

      disable_rgb_for(PlayerToRGBCarStop)
   elseif raw_cmd == "orbit" or raw_cmd == "circlearound" or raw_cmd == "startorbit" or raw_cmd == "circleplr" then
      local Target = findplr(split[1])
      if not Target then return getgenv().notify("Error", "Target doesn't exist or has left the game.", 5) end
      local speed = tonumber(split[2]) or 1
      local distance = tonumber(split[3]) or 3
      if getgenv().Is_Orbiting then
         return getgenv().notify("Warning", "You're already orbiting somebody.", 5)
      end

      start_orbit_plr(Target, speed, distance)
   elseif raw_cmd == "unorbit" or raw_cmd == "noorbit" or raw_cmd == "stoporbit" or raw_cmd == "uncirclearound" or raw_cmd == "uncircleplr" then
      if not getgenv().Is_Orbiting then
         return getgenv().notify("Warning", "You're not orbiting anyone!", 5)
      end
      
      stop_orbit()
   elseif raw_cmd == "orbitspeed" or raw_cmd == "changeorbitspeed" or raw_cmd == "neworbitspeed" or raw_cmd == "ospeed" then
      local new_speed = tonumber(split[1])

      if not getgenv().Is_Orbiting then
         return getgenv().notify("Warning", "You're not orbiting anyone, you cannot change the speed.", 8)
      end

      set_orbit_speed(new_speed)
   elseif raw_cmd == "alljobs" or raw_cmd == "startjobspammer" or raw_cmd == "everyjob" or raw_cmd == "jobspammer" or raw_cmd == "jobspam" or raw_cmd == "startjobspam" then
      if getgenv().Every_Job then
         return getgenv().notify("Warning", "Job spammer is already enabled! disable it first.", 5)
      end

      job_spammer(true)
   elseif raw_cmd == "jobsoff" or raw_cmd == "nojobs" or raw_cmd == "unjobspam" or raw_cmd == "stopjobspam" or raw_cmd == "stopjobspammer" or raw_cmd == "unjobspammer" then
      if not getgenv().Every_Job then
         return getgenv().notify("Warning", "Job spammer is not enabled! enable it first.", 5)
      end

      job_spammer(false)
   elseif raw_cmd == "vehiclefly" or raw_cmd == "carfly" or raw_cmd == "flycar" or raw_cmd == "flyvehicle" then
      local speed_input_main_vfly = tonumber(split[1]) or 5

      if getgenv().vehicle_fly then
         return getgenv().notify("Warning", "Vehicle Fly is already enabled, turn it off first.", 5)
      end
      wait(0.1) -- wait in between, just incase.
      local main_vehicle = get_vehicle()

      if speed_input_main_vfly then
         getgenv().vehicle_fly_speed = speed_input_main_vfly
      end
      wait(0.2)
      if not main_vehicle then
         return getgenv().notify("Error", "Please spawn a Vehicle first.", 5)
      end
      wait(0.1) -- don't catch in between at all, just incase.
      if main_vehicle and main_vehicle:FindFirstChild("VehicleSeat") then
         main_vehicle:FindFirstChild("VehicleSeat"):Sit(getgenv().Humanoid)
      else
         return getgenv().notify("Error", "Vehicle does not exist or could not find Vehicle seat.", 7)
      end
      wait(0.2) -- so we have time to check in between.
      getgenv().toggle_vehicle_fly()
   elseif raw_cmd == "unvehiclefly" or raw_cmd == "uncarfly" or raw_cmd == "unflycar" or raw_cmd == "unflyvehicle" then
      if not getgenv().vehicle_fly then
         return getgenv().notify("Warning", "Vehicle Fly is not enabled, enable it first.", 5)
      end

      getgenv().toggle_vehicle_fly()
   elseif raw_cmd == "vflyspeed" or raw_cmd == "vehicleflyspeed" or raw_cmd == "carflyspeed" then
      local main_input_num = tonumber(split[1]) or 5

      if main_input_num then
         getgenv().vehicle_fly_speed = main_input_num
         getgenv().notify("Info", "New vehicle fly speed: "..tostring(main_input_num), 5)
      end
   elseif raw_cmd == "stoprgbskin" or raw_cmd == "unrgbskin" or raw_cmd == "rgbskinoff" or raw_cmd == "unrainbowskin" then
      rainbow_skin(false)
   elseif raw_cmd == "startrgbphone" or raw_cmd == "rgbphone" or raw_cmd == "rgbphoneon" or raw_cmd == "rainbowphone" then
      if getgenv().RGB_Rainbow_Phone then
         return getgenv().notify("Warning", "RGB Phone is already enabled!", 5)
      end

      RGB_Phone(true)
   elseif raw_cmd == "stoprgbphone" or raw_cmd == "unrgbphone" or raw_cmd == "rgbphoneoff" or raw_cmd == "unrainbowphone" then
      if not getgenv().RGB_Rainbow_Phone then
         return getgenv().notify("Warning", "RGB Phone is not enabled!", 5)
      end

      RGB_Phone(false)
   elseif raw_cmd == "performancegui" or raw_cmd == "statsgui" or raw_cmd == "netstats" or raw_cmd == "netstatsgui" then
      LoadPerformanceStatsGUI()
   elseif raw_cmd == "inject" or raw_cmd == "attach" or raw_cmd == "secret" then
      getgenv().notify("Success", "You found a secret command, nice job.", 6)
      attach_with_script()
   elseif raw_cmd == "flashsigntext" or raw_cmd == "fastsigntext" or raw_cmd == "startsignspam" or raw_cmd == "signspamon" or raw_cmd == "signspam" or raw_cmd == "signspammer" then
      if getgenv().ToolChanger_FE then
         return getgenv().notify("Warning", "Sign spammer is already enabled! disable it first.", 5)
      end

      spam_sign_text(true)
   elseif raw_cmd == "noflashsigntext" or raw_cmd == "unfastsigntext" or raw_cmd == "stopsignspam" or raw_cmd == "signspamoff" or raw_cmd == "unsignspam" or raw_cmd == "unsignspammer" then
      if not getgenv().ToolChanger_FE then
         return getgenv().notify("Warning", "Sign spammer is not enabled! enable it first.", 5)
      end

      spam_sign_text(false)
   elseif raw_cmd == "name" or raw_cmd == "rpname" or raw_cmd == "newname" or raw_cmd == "newrpname" then
      local new_name = table.concat(split, " ")
      local max_len = 19

      if #new_name > max_len and writefile then
         getgenv().notify("Info", "Your roleplay Name exceeds 19 characters, we're saving it for you, it'll be automatically set back once you reload the script.", 15)
         writefile("LifeTogether_RP_Admin_Custom_Name.txt", new_name)
      end

      change_RP_Name(new_name)
   elseif raw_cmd == "bio" or raw_cmd == "rpbio" or raw_cmd == "newbio" then
      local new_bio = table.concat(split, " ")
      local max_len = 49

      if #new_bio > max_len and writefile then
         getgenv().notify("Info", "Your roleplay Bio exceeds 49 characters, we're saving it for you, it'll be automatically set back once you reload the script.", 15)
         writefile("LifeTogether_RP_Admin_Custom_Bio.txt", new_bio)
      end

      change_bio(new_bio)
   elseif raw_cmd == "mutetools" or raw_cmd == "mutealltools" or raw_cmd == "nosoundtools" then
      mute_all_tools(true)
   elseif raw_cmd == "unmutetools" or raw_cmd == "unmutealltools" or raw_cmd == "soundtools" then
      mute_all_tools(false)
   elseif raw_cmd == "copyanim" or raw_cmd == "takeemote" or raw_cmd == "doemote" or raw_cmd == "copemote" then
      local target_plr = findplr(split[1])
      if not target_plr then
         return getgenv().notify("Error", "Player not found or does not exist.", 5)
      end

      copy_emote_plr(target_plr)
   elseif raw_cmd == "cmdhelp" or raw_cmd == "help" or raw_cmd == "helper" or raw_cmd == "cmdhelper" or raw_cmd == "commandshelp" or raw_cmd == "commandhelp" then
      CommandAssistanceGUI()
   elseif raw_cmd == "spin" or raw_cmd == "spinning" then
      local provided_speed = split[1] and tonumber(split[1]) or 5

      spin_plr(true, provided_speed)
   elseif raw_cmd == "unspin" or raw_cmd == "nospin" or raw_cmd == "removespin" then
      spin_plr(false)
   elseif raw_cmd == "spinspeed" or raw_cmd == "newspinspeed" then
      local provided_spin_speed = split[1] and tonumber(split[1]) or 5

      if not getgenv().already_spinning_localplr then
         return getgenv().notify("Warning", "You are not currently spinning.", 5)
      end

      change_spin_speed(provided_spin_speed)
   elseif raw_cmd == "configgui" or raw_cmd == "config" or raw_cmd == "configmanager" or raw_cmd == "configurationmanager" or raw_cmd == "configsettings" then
      toggle_config_manager(true)
   elseif raw_cmd == "nightvision" or raw_cmd == "nightv" or raw_cmd == "greenvision" or raw_cmd == "armyvision" or raw_cmd == "armynightvision" then
      getgenv().night_vision(true)
   elseif raw_cmd == "unnightvision" or raw_cmd == "nonightvision" or raw_cmd == "unnightv" or raw_cmd == "ungreenvision" or raw_cmd == "unarmyvision" or raw_cmd == "unarmynightvision" then
      getgenv().night_vision(false)
   elseif raw_cmd == "fly" or raw_cmd == "fly1" or raw_cmd == "hdadminfly" or raw_cmd == "hdfly" then
      local flySpeed = tonumber(split[1]) or 10
      if getgenv().afEnabled then
         return getgenv().notify("Error", "Anti-Fling is enabled, disable it first to turn on Fly.", 7)
      end
      if getgenv().FlyEnabled then
         return getgenv().notify("Error", "Fly-1 is already enabled!", 5)
      end
      if getgenv().Enabled_Flying then
         return getgenv().notify("Error", "You cannot run 2 fly scripts at once!", 5)
      end
      wait(0.2)
      EnableFly(true, flySpeed)
      if not isMobile then
         getgenv().notify("Warning", "E = up, Q = down, WASD to move.", 5)
      end
   elseif raw_cmd == "unfly" or raw_cmd == "unfly1" or raw_cmd == "stopfly1" then
      DisableFly()
   elseif raw_cmd == "fly2" or raw_cmd == "rainbowcarpetfly" or raw_cmd == "rgbfly" or raw_cmd == "rainbowfly" then
      local Fly_Speed = tonumber(split[1]) or 10
      if getgenv().afEnabled then
         return getgenv().notify("Error", "Anti-Fling is enabled, disable it first to turn on fly-2.", 7)
      end
      if getgenv().Enabled_Flying then
         return getgenv().notify("Error", "Fly-2 is already be enabled!", 5)
      end
      if getgenv().FlyEnabled then
         return getgenv().notify("Error", "Fly-1 is already enabled! disable that fly first.", 6)
      end

      EnableFly2(Fly_Speed)
      if not isMobile then
         getgenv().notify("Warning", "E = up, Q = down, WASD to move", 5)
      end
   elseif raw_cmd == "ban" or raw_cmd == "remove" or raw_cmd == "permaban" then
      local arg = split[1]
      if not arg then
         return getgenv().notify("Error", "No player specified.", 6)
      end
      local admin_player = get_server_admin_player()
      if not is_localplayer_server_owner() then
         getgenv().notify("Warning", "Private Server is owned by: "..tostring(admin_player.Name) or "Public Server", 7)
         return getgenv().notify("Error", "Not a Private Server or you don't own it!", 6)
      end
      wait(0.1)
      local target = findplr(arg) or arg
      local added = addban(target)

      if added then
         getgenv().notify("Success", "Banned player: "..added, 5)
      else
         getgenv().notify("Error", "Failed to ban target.", 6)
      end
   elseif raw_cmd == "unban" or raw_cmd == "unremove" or raw_cmd == "unpermaban" then
      local arg = split[1]
      if not arg then
         return notify("Error", "No player specified.", 6)
      end
      local admin_player = get_server_admin_player()
      if not is_localplayer_server_owner() then
         getgenv().notify("Warning", "Private Server is owned by: "..tostring(admin_player.Name) or "Public Server", 7)
         return getgenv().notify("Error", "Not a Private Server or you don't own it!", 6)
      end
      wait(0.1)
      local target = findplr(arg) or arg
      local removed = removeban(target)

      if removed then
         getgenv().notify("Success", "Unbanned player: "..removed, 5)
      else
         getgenv().notify("Error", "Player is not banned.", 6)
      end
   elseif raw_cmd == "fly3" or raw_cmd == "adonisadminfly" or raw_cmd == "adonisfly" then
      local Fly_Speed = tonumber(split[1]) or 10

      if getgenv().Enabled_Flying then
         return getgenv().notify("Error", "Fly-2 is already be enabled!", 5)
      end
      if getgenv().FlyEnabled then
         return getgenv().notify("Error", "Fly-1 is already enabled! disable that fly first.", 6)
      end

      if not isMobile then
         getgenv().notify("Warning", "E = up, Q = down, WASD to move", 5)
      end
      getgenv().StartAdonisAdminFlyScript()
   elseif raw_cmd == "unfly3" or raw_cmd == "unadonisadminfly" or raw_cmd == "unadonisfly" then
      getgenv().Stop_Fly_3_Function()
   elseif raw_cmd == "saveemote" or raw_cmd == "saveanim" then
      getgenv().save_copied_plrs_emote()
   elseif raw_cmd == "antirgbphone" or raw_cmd == "hidergbphones" then
      if getgenv().HidePhoneModels then
         return getgenv().notify("Warning", "Anti RGB Phone is already enabled.", 5)
      end

      getgenv().notify("Success", "Enabled Anti RGB Phone.", 5)
      getgenv().TogglePhoneModelHider(true)
   elseif raw_cmd == "unantirgbphone" or raw_cmd == "unhidergbphones" then
      if not getgenv().HidePhoneModels then
         return getgenv().notify("Warning", "Anti RGB Phone is not enabled.", 5)
      end

      getgenv().notify("Success", "Disabled Anti RGB Phone.", 5)
      getgenv().TogglePhoneModelHider(false)
      getgenv().ShutdownPhoneModelHider()
   elseif raw_cmd == "outfitmanager" or raw_cmd == "saveoutfitsgui" or raw_cmd == "outfitsui" or raw_cmd == "outfitsgui" or raw_cmd == "saveoutfitsmanager" or raw_cmd == "fitsmanager" or raw_cmd == "fitmanager" or raw_cmd == "savedoutfitsgui" or raw_cmd == "savedoutfitsui" then
      save_outfits_GUI()
   elseif raw_cmd == "spawnfire" or raw_cmd == "fireamount" or raw_cmd == "spawnflames" or raw_cmd == "spawnflame" or raw_cmd == "firespawn" then
      local Amount = tonumber(split[1]) or 5
      getgenv().HasSeen_Fire_AlertFlamesHub = getgenv().HasSeen_Fire_AlertFlamesHub or false
      local isVerified = getgenv().LocalPlayer:GetAttribute("is_verified")
      if not isVerified then
         return getgenv().notify("Error", "You do not have premium, you cannot run this, sorry!", 8)
      end

      if getgenv().HasSeen_Fire_AlertFlamesHub then
         set_fire_amount_FE(Amount)
      else
         set_fire_amount_FE(Amount)

         getgenv().HasSeen_Fire_AlertFlamesHub = true
      end

      task.wait(0.2)
      for i = 1, Amount do
         getgenv().Send("request_fire")
      end
   elseif raw_cmd == "startrgbtool" or raw_cmd == "rgbtool" then
      if getgenv().Rainbow_Tools_FE then
         return getgenv().notify("Warning", "Rainbow Tool is already enabled.", 5)
      end

      rainbow_tool(true)
   elseif raw_cmd == "stoprgbtool" or raw_cmd == "unrgbtool" then
      if not getgenv().Rainbow_Tools_FE then
         return getgenv().notify("Warning", "Rainbow Tool is not enabled.", 5)
      end

      rainbow_tool(false)
   elseif raw_cmd == "unfly2" or raw_cmd == "stopfly2" then
      DisableFly2()
   elseif raw_cmd == "noemote" or raw_cmd == "noemotes" or raw_cmd == "nodance" or raw_cmd == "nodances" or raw_cmd == "dancingoff" or raw_cmd == "emotingoff" or raw_cmd == "unemote" or raw_cmd == "undance" or raw_cmd == "stopemote" or raw_cmd == "stopanim" or raw_cmd == "stopanims" then
      getgenv().disable_emoting_script()
   elseif raw_cmd == "stoptime" or raw_cmd == "notime" or raw_cmd == "pausetime" then
      stop_time_toggle(true)
   elseif raw_cmd == "unstoptime" or raw_cmd == "resumetime" then
      stop_time_toggle(false)
   elseif raw_cmd == "flashtime" or raw_cmd == "scarytime" or raw_cmd == "flashingtime" or raw_cmd == "timeflasher" or raw_cmd == "startflashingtime" then
      flash_time_toggle(true)
   elseif raw_cmd == "unflashtime" or raw_cmd == "unscarytime" or raw_cmd == "unflashingtime" or raw_cmd == "untimeflasher" or raw_cmd == "stopflashingtime" then
      flash_time_toggle(false)
   elseif raw_cmd == "needy" or raw_cmd == "needydance" or raw_cmd == "happyhula" then
      do_emote("needy_twerk") -- so what? I added it, what ever, it's unbannable btw.
   elseif raw_cmd == "griddy" then
      do_emote("griddy")
   elseif raw_cmd == "scenario" then
      do_emote("scenario")
   elseif raw_cmd == "superman" then
      do_emote("superman")
   elseif raw_cmd == "zen" then
      do_emote("zen")
   elseif raw_cmd == "motion" then
      do_emote("motion")
   elseif raw_cmd == "orangej" then
      do_emote("orangej")
   elseif raw_cmd == "aura" or raw_cmd == "aurafarm" or raw_cmd == "aurafarming" then
      do_emote("aura")
   elseif raw_cmd == "popular" then
      do_emote("popular")
   elseif raw_cmd == "kotonai" then
      do_emote("kotonai")
   elseif raw_cmd == "defaultd" then
      do_emote("defaultdance")
   elseif raw_cmd == "worm" then
      do_emote("worm")
   elseif raw_cmd == "glitching" then
      do_emote("glitch")
   elseif raw_cmd == "billyb" or raw_cmd == "billybounce" then
      do_emote("billybounce")
   elseif raw_cmd == "billyjean" then
      do_emote("billyjean")
   elseif raw_cmd == "michaelbounce" or raw_cmd == "michaelmyers" or raw_cmd == "jiggybounce" or raw_cmd == "michmyers" or raw_cmd == "myersbounce" or raw_cmd == "michaeldance" or raw_cmd == "michealmyers" or raw_cmd == "michealbounce" then
      do_emote("michaelmyers")
   elseif raw_cmd == "sturdy" or raw_cmd == "nysturdy" or raw_cmd == "newyorksturdy" or raw_cmd == "sturdydance" or raw_cmd == "getsturdy" then
      do_emote("sturdy")
   elseif raw_cmd == "jiggy" or raw_cmd == "louisiniajigg" or raw_cmd == "getjiggy" or raw_cmd == "jig" or raw_cmd == "jigg" or raw_cmd == "louijigg" or raw_cmd == "louijiggy" then
      do_emote("jiggy")
   elseif raw_cmd == "eshuffle" or raw_cmd == "electroshuffle" or raw_cmd == "electricshuffle" then
      do_emote("electroshuffle")
   elseif raw_cmd == "takethel" or raw_cmd == "takel" or raw_cmd == "takeanl" then
      do_emote("takethel")
   elseif raw_cmd == "donkeylaugh" or raw_cmd == "fortnitelaugh" or raw_cmd == "laughitup" or raw_cmd == "fnlaugh" then
      do_emote("laughitup")
   elseif raw_cmd == "reanimated" or raw_cmd == "reanimate" or raw_cmd == "fnreanimated" or raw_cmd == "fortnitereanimated" then
      do_emote("reanimated")
   elseif raw_cmd == "jabba" or raw_cmd == "jabbadance" or raw_cmd == "jabsway" or raw_cmd == "jabbasway" or raw_cmd == "jabbsway" or raw_cmd == "swayjab" or raw_cmd == "swayjabba" then
      do_emote("jabba")
   elseif raw_cmd == "tuff" or raw_cmd == "tuffdance" or raw_cmd == "tuffestdance" or raw_cmd == "toughdance" or raw_cmd == "tough" then
      do_emote("tuff")
   elseif raw_cmd == "nameless" or raw_cmd == "flamesadmin" or raw_cmd == "flamesnameless" or raw_cmd == "flamesnamelessadmin" or raw_cmd == "namelessadmin" or raw_cmd == "universaladmin" then
      flames_nameless_admin_ver()
   elseif raw_cmd == "infpremium" or raw_cmd == "infinitepremium" or raw_cmd == "loadinfprem" or raw_cmd == "infp" or raw_cmd == "iprem" or raw_cmd == "ipremium" then
      infinite_premium()
   elseif raw_cmd == "infyield" or raw_cmd == "iy" or raw_cmd == "loadiy" or raw_cmd == "infiniteyield" or raw_cmd == "iyield" then
      infinite_yield()
   elseif raw_cmd == "anticarfling" or raw_cmd == "startanticarfling" or raw_cmd == "antivehiclefling" or raw_cmd == "antivfling" or raw_cmd == "acarfling" then
      anti_car_fling(true)
   elseif raw_cmd == "unanticarfling" or raw_cmd == "stopanticarfling" or raw_cmd == "unantivehiclefling" or raw_cmd == "unantivfling" or raw_cmd == "unacarfling" then
      anti_car_fling(false)
   elseif raw_cmd == "vehiclestats" or raw_cmd == "vehiclestatsgui" or raw_cmd == "vehiclesgui" or raw_cmd == "carstatsgui" or raw_cmd == "carstats" then
      vehicle_stats_viewer_GUI()
   elseif raw_cmd == "stealcar" or raw_cmd == "stealvehicle" or raw_cmd == "takecar" or raw_cmd == "takevehicle" then
      local take_vehicle_target_plr = findplr(split[1])
      if not take_vehicle_target_plr then return getgenv().notify("error", "That Player does not exist, or has left the game.", 7) end
      local plrs_spawned_vehicle = getgenv().get_other_vehicle(take_vehicle_target_plr)
      if not plrs_spawned_vehicle then return getgenv().notify("Error", "That Player does not have a Vehicle spawned.", 6) end

      if getgenv().Character and getgenv().Character.Parent and getgenv().Character:FindFirstChild("HumanoidRootPart") then
         getgenv().Character:PivotTo(plrs_spawned_vehicle:GetPivot() + Vector3.new(0, 3, 0))
      end
      task.wait(0.2)
      getgenv().steal_car_functionality(take_vehicle_target_plr)
   elseif raw_cmd == "annoy" or raw_cmd == "spamannoy" or raw_cmd == "loopannoy" then
      local Target = findplr(split[1])
      if not Target then
         show_notification("Error:", "Player does not exist!", "Error")
         return getgenv().notify("Error", "That Player does not exist or has left the game.", 7)
      end
      if Target.Name == "FarminTooMuchAura" then
         getgenv().easy_click_plr = false
         return 
      end
      if getgenv().easy_click_plr then
         if getgenv().Currently_Annoying_Player then
            return getgenv().notify("Error", "You are already annoying: "..tostring(getgenv().Currently_Annoying_Player).."!", 5)
         else
            return getgenv().notify("Error", "You are already annoying a Player!", 5)
         end
      end

      local target_userid = Target.UserId
      local rejoin_limit = 60
      getgenv().Currently_Annoying_Player = Target.Name
      getgenv().notify("Success", "Now annoying Player: "..Target.Name, 7)
      getgenv().easy_click_plr = true
      while getgenv().easy_click_plr do
         task.wait()
         if not Target or not Target.Parent then
            local elapsed = 0
            getgenv().notify("Warning", "Target left, waiting 60 seconds for them to rejoin (if they do)...", 12)
            while elapsed < rejoin_limit and getgenv().easy_click_plr do
               local found = false
               for _, plr in ipairs(game.Players:GetPlayers()) do
                  if plr.UserId == target_userid then
                     Target = plr
                     getgenv().notify("Success", "Target rejoined, resuming annoyance loop!", 6)
                     found = true
                     break
                  end
               end

               if found then break end
               task.wait(1)
               elapsed += 1
            end

            if elapsed >= rejoin_limit then
               getgenv().Currently_Annoying_Player = nil
               getgenv().easy_click_plr = false
               return getgenv().notify(
                  "Warning",
                  "Target did not rejoin within 60 seconds, loop disabled.",
                  10
               )
            end
         end

         getgenv().Send("request_carry", Target)
         task.wait(0)
         getgenv().Send("request_call", Target)
         task.wait(0)
         getgenv().Send("end_call", Target)
         RunService.Heartbeat:Wait()
      end
   elseif raw_cmd == "blockcalls" or raw_cmd == "nocalls" or raw_cmd == "hangupcalls" or raw_cmd == "declinecalls" or raw_cmd == "autodeclinecalls" or raw_cmd == "blockcall" or raw_cmd == "autoblockcalls" then
      if getgenv().Auto_Block_All_Calls_Made then return getgenv().notify("Warning", "You already have Calls_Blocker_V2.5 enabled!", 6) end
      
      getgenv().notify("Success", "Calls_Blocker_V2.5 has been enabled.", 5)
      getgenv().Auto_Block_All_Calls_Made = true
      while getgenv().Auto_Block_All_Calls_Made == true do
      task.wait(0)
         for _, v in ipairs(getgenv().Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
               getgenv().Send("end_call", v)
            end
         end
      end
   elseif raw_cmd == "unblockcalls" or raw_cmd == "unnocalls" or raw_cmd == "unhangupcalls" or raw_cmd == "undeclinecalls" or raw_cmd == "unautodeclinecalls" or raw_cmd == "unblockcall" or raw_cmd == "unautoblockcalls" then
      if not getgenv().Auto_Block_All_Calls_Made then
         return getgenv().notify("Warning", "You do NOT have Calls_Blocker_V2.5 enabled!", 6)
      end

      getgenv().Auto_Block_All_Calls_Made = false
      getgenv().notify("Success", "Calls_Blocker_V2.5 has been disabled.", 5)
   elseif raw_cmd == "chatbypass" or raw_cmd == "chatbypasser" or raw_cmd == "bypasschat" or raw_cmd == "chatbypassgui" or raw_cmd == "chatbypassmenu" or raw_cmd == "cbypass" then
      getgenv().load_chat_bypasser_script()
   elseif raw_cmd == "freeemotes" or raw_cmd == "freeemotesgui" or raw_cmd == "allemotes" or raw_cmd == "freeemote" or raw_cmd == "freemotes" or raw_cmd == "freemotesgui" or raw_cmd == "freeemotesscript" or raw_cmd == "freemotesscript" or raw_cmd == "freemotescript" then
      if getgenv().FreeEmotes_Enabled then
         return getgenv().notify("Warning", "You already have Flames Emoting GUI loaded!", 6)
      end
      if CoreGui:FindFirstChild("FlamesEmoteGUI") then
         return getgenv().notify("Warning", "You already have Flames Emoting GUI loaded!", 6)
      end

      getgenv().FreeEmotes_Enabled = true
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/flames_emotes_gui_new.lua"))()
   elseif raw_cmd == "allcars" or raw_cmd == "allvehicles" or raw_cmd == "listvehicles" then
      car_listing_gui()
   elseif raw_cmd == "kick" or raw_cmd == "remove" then
      local targetplr = findplr(split[1])
      if not targetplr then
         return getgenv().notify("Error", "That player does not exist or has left.", 5)
      end
      if not is_localplayer_server_owner() then
         return getgenv().notify("Error", "You are not the private server owner!", 5)
      end
      if targetplr.Name == "FarminTooMuchAura" then
         return 
      end

      kick_plr(targetplr)
      getgenv().notify("Success", "Kicked player: "..tostring(targetplr), 5)
   elseif raw_cmd == "spamnames" or raw_cmd == "autonamechanger" or raw_cmd == "namechangerpremium" or raw_cmd == "namechangerauto" or raw_cmd == "namechanger" or raw_cmd == "spammingnames" or raw_cmd == "namespammer" or raw_cmd == "namespam" then
      name_changer_premium(true)
   elseif raw_cmd == "unspamnames" or raw_cmd == "unautonamechanger" or raw_cmd == "unnamechangerpremium" or raw_cmd == "unnamechangerauto" or raw_cmd == "unnamechanger" or raw_cmd == "unnamespam" or raw_cmd == "unnamespammer" then
      name_changer_premium(false)
   elseif raw_cmd == "speed" or raw_cmd == "setspeed" or raw_cmd == "newspeed" or raw_cmd == "ws" or raw_cmd == "walkspeed" or raw_cmd == "walks" then
      local New_Val = tonumber(split[1]) or 16

      if not getgenv().Humanoid then
         return getgenv().notify("Warning", "Wait until you respawn (or reset), we think you are dead, Humanoid is missing.", 10)
      end
      if getgenv().Humanoid.WalkSpeed == New_Val then
         return getgenv().notify("Warning", "Your WalkSpeed is already: "..tostring(New_Val), 5)
      end

      change_property("WalkSpeed", New_Val)
      getgenv().notify("Success", "Updated WalkSpeed to: "..tostring(New_Val), 5)
   elseif raw_cmd == "jp" or raw_cmd == "newjp" or raw_cmd == "jumpheight" or raw_cmd == "newjh" or raw_cmd == "jumph" or raw_cmd == "setjh" or raw_cmd == "setjp" then
      local New_ValJP = tonumber(split[1]) or 7

      if not getgenv().Humanoid then
         return getgenv().notify("Warning", "Wait until you respawn (or reset), we think you are dead, Humanoid is missing.", 10)
      end
      if getgenv().Humanoid.JumpPower == New_ValJP then
         return getgenv().notify("Warning", "Your JumpPower is already: "..tostring(New_ValJP), 5)
      elseif getgenv().Humanoid.JumpHeight == New_ValJP then
         return getgenv().notify("Warning", "Your JumpHeight is already: "..tostring(New_ValJP), 5)
      end

      change_property("JumpHeight", New_ValJP)
      getgenv().notify("Success", "Updated JumpHeight to: "..tostring(New_ValJP), 5)
   elseif raw_cmd == "grav" or raw_cmd == "gravity" or raw_cmd == "setgravity" or raw_cmd == "setgrav" or raw_cmd == "newgrav" or raw_cmd == "gravvalue" then
      local New_Grav = tonumber(split[1]) or 196

      if getgenv().Workspace.Gravity == New_Grav then
         return getgenv().notify("Warning", "Gravity is already: "..tostring(New_Grav), 5)
      end

      change_gravity_val(New_Grav)
   elseif raw_cmd == "unannoy" then
      if not getgenv().easy_click_plr then
         return getgenv().notify("Error", "You do not have 'annoy PlayerName' enabled! usage: "..tostring(getgenv().AdminPrefix).."annoy PlayerName", 10)
      end

      getgenv().notify("Success", "Disabled Flames Hub Annoy Player Loop.", 5)
      getgenv().Currently_Annoying_Player = nil
      getgenv().easy_click_plr = false
   elseif raw_cmd == "walkfling" or raw_cmd == "walkf" or raw_cmd == "startwalkfling" then
      getgenv().StartWalkFling()
   elseif raw_cmd == "unwalkfling" or raw_cmd == "unwalkf" or raw_cmd == "stopwalkfling" then
      getgenv().StopWalkFling()
   elseif raw_cmd == "unlockhome" or raw_cmd == "unlockhouse" then
      local is_house_currently_locked = is_home_locked(getgenv().LocalPlayer)

      if is_house_currently_locked == false then
         return getgenv().notify("Warning", "Your home is not locked.", 5)
      elseif is_house_currently_locked == true then
         toggle_house_lock(getgenv().LocalPlayer)
         getgenv().notify("Success", "Unlocked your home.", 5)
      else
         return getgenv().notify("Error", "Something unexpected happened while checking if House is locked or not.", 10)
      end
   elseif raw_cmd == "unlockplrhouse" or raw_cmd == "unlockplrhome" then
      local plr_to_lock = findplr(split[1])
      if not plr_to_lock then
         return getgenv().notify("Error", "Player not found or does not exist.", 5)
      end
      local is_house_currently_locked_plr = is_home_locked(plr_to_lock)

      if not plr_to_lock:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         return getgenv().notify("Error", "You must be friends with the player to unlock their house!", 10)
      end

      if is_house_currently_locked_plr == false then
         return getgenv().notify("Warning", tostring(plr_to_lock).."'s home is not locked.", 5)
      elseif is_house_currently_locked_plr == true then
         toggle_house_lock(plr_to_lock)
         getgenv().notify("Success", "Unlocked: "..tostring(plr_to_lock).."'s home.", 5)
      else
         return getgenv().notify("Error", "Something happened while trying to unlock: "..tostring(plr_to_lock).."'s home!", 10)
      end
   elseif raw_cmd == "lockplrhouse" or raw_cmd == "lockplrhome" then
      local plr_to_lock = findplr(split[1])
      if not plr_to_lock then
         return getgenv().notify("Error", "Player not found or does not exist.", 5)
      end
      local is_house_currently_locked_plr = is_home_locked(plr_to_lock)

      if not plr_to_lock:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         return getgenv().notify("Error", "You must be friends with the player to lock their house!", 10)
      end

      if is_house_currently_locked_plr == true then
         return getgenv().notify("Warning", tostring(plr_to_lock).."'s home is already locked.", 5)
      elseif is_house_currently_locked_plr == false then
         toggle_house_lock(plr_to_lock)
         getgenv().notify("Success", "Locked: "..tostring(plr_to_lock).."'s home.", 5)
      else
         return getgenv().notify("Error", "Something happened while trying to lock: "..tostring(plr_to_lock).."'s home!", 10)
      end
   elseif raw_cmd == "lockhouse" or raw_cmd == "lockhome" then
      local is_house_currently_locked = is_home_locked(getgenv().LocalPlayer)

      if is_house_currently_locked == true then
         return getgenv().notify("Warning", "Your home is already locked.", 5)
      elseif is_house_currently_locked == false then
         toggle_house_lock(getgenv().LocalPlayer)
         getgenv().notify("Success", "Locked your home.", 5)
      else
         return getgenv().notify("Error", "Something unexpected happened while checking if House is locked or not.", 10)
      end
   elseif raw_cmd == "countcmds" or raw_cmd == "howmanycommands" or raw_cmd == "howmanycmds" or raw_cmd == "countcommands" then
      local commands_counted = getgenv().count_all_flames_hub_commands()

      getgenv().notify("Success", "We currently have: "..tostring(commands_counted).." commands!", 10)
   elseif raw_cmd == "autolockhome" or raw_cmd == "autolockhouse" then
      getgenv().keep_home_locked(true)
   elseif raw_cmd == "unautolockhome" or raw_cmd == "unautolockhouse" then
      getgenv().keep_home_locked(false)
   elseif raw_cmd == "autolockcar" or raw_cmd == "startautolockcar" or raw_cmd == "startlockingcar" or raw_cmd == "autolockvehicle" then
      if getgenv().AutoLockOn then return getgenv().notify("Error", "You already have 'AutoLockCar' enabled, disable it first!", 6) end

      local RunService = getgenv().RunService or game:GetService("RunService")
      getgenv().AutoLockConnection = nil

      getgenv().ToggleAutoLock = function(state)
         if not state then
            getgenv().AutoLockOn = false

            if getgenv().AutoLockConnection then
               getgenv().AutoLockConnection:Disconnect()
               getgenv().AutoLockConnection = nil
            end

            local car = get_vehicle()

            if car and car:GetAttribute("locked") == true then
               lock_vehicle(car)
               getgenv().notify("Success", "Vehicle unlocked and AutoLock disabled.", 5)
            else
               getgenv().notify("Warning", "Vehicle not found, cannot unlock, disabled loop.", 5)
            end
            return 
         else
            getgenv().AutoLockOn = true
         end

         getgenv().notify("Success", "AutoLock enabled. Waiting for vehicle...", 5)

         getgenv().AutoLockConnection = getgenv().RunService.Heartbeat:Connect(function()
            local car = get_vehicle()
            if car and car:GetAttribute("locked") ~= true then
               lock_vehicle(car)
            end
         end)
      end

      getgenv().ToggleAutoLock(true)
   elseif raw_cmd == "unautolockcar" or raw_cmd == "stopautolockcar" or raw_cmd == "stoplockingcar" then
      if not getgenv().ToggleAutoLock then return getgenv().notify("Error", "You have not enabled the 'AutoLockCar' command, function not found.", 5) end
      if not getgenv().AutoLockOn then return getgenv().notify("Error", "You do not have 'AutoLockCar' enabled!", 5) end

      getgenv().ToggleAutoLock(false)
   elseif raw_cmd == "hidedelta" or raw_cmd == "hidedeltaicon" then
      getgenv().toggle_delta_image_button_flames_hub(false)
   elseif raw_cmd == "showdelta" or raw_cmd == "showdeltaicon" or raw_cmd == "unhidedelta" or raw_cmd == "unhidedeltaicon" then
      getgenv().toggle_delta_image_button_flames_hub(true)
   elseif raw_cmd == "esp" or raw_cmd == "plresp" or raw_cmd == "playeresp" or raw_cmd == "playersesp" or raw_cmd == "charesp" or raw_cmd == "characteresp" then
      getgenv().enable_player_esp()
   elseif raw_cmd == "unesp" or raw_cmd == "unplresp" or raw_cmd == "unplayeresp" or raw_cmd == "unplayersesp" or raw_cmd == "uncharesp" or raw_cmd == "uncharacteresp" then
      getgenv().disable_player_esp()
   elseif raw_cmd == "traceresp" or raw_cmd == "plrtraceresp" or raw_cmd == "lineesp" or raw_cmd == "lineplresp" then
      getgenv().enable_tracers()
   elseif raw_cmd == "untraceresp" or raw_cmd == "unplrtraceresp" or raw_cmd == "unlineesp" or raw_cmd == "unlineplresp" then
      getgenv().disable_tracers()
   elseif raw_cmd == "copyavatar" or raw_cmd == "copy" or raw_cmd == "copyav" or raw_cmd == "copyava" or raw_cmd == "stealav" or raw_cmd == "stealavatar" or raw_cmd == "steal" then
      local Target = findplr(split[1])
      if not Target then return getgenv().notify("Error", "That player doesn't exist in this game!", 5) end
      
      if getgenv().is_copying_avatar_already_flames then
         return getgenv().notify("Warning", "Copy avatar is already running!, wait a moment, until it's done.", 5)
      end

      local Target_Bio = Target:GetAttribute("bio")

      if Target_Bio and Target_Bio == "Flames Hub Anti Stealer Is Enabled." then
         return getgenv().notify("Warning", "This player has Anti Outfit Stealer on! sorry!", 7)
      end

      copy_plr_avatar(Target)
   elseif raw_cmd == "noclip" then
      if getgenv().Noclip_Enabled then
         return getgenv().notify("Error", "Noclip is already enabled!", 5)
      end
      if getgenv().Noclip_Connection then
         return getgenv().notify("Warning", "Noclip connection is active, disable Noclip and try again.", 6)
      end

      getgenv().Toggleable_Noclip(true)
   elseif raw_cmd == "vehicleesp" or raw_cmd == "caresp" or raw_cmd == "vesp" then
      vehicle_esp_toggle(true)
   elseif raw_cmd == "unvehicleesp" or raw_cmd == "uncaresp" or raw_cmd == "unvesp" then
      vehicle_esp_toggle(false)
   elseif raw_cmd == "slockmanager" or raw_cmd == "slockgui" or raw_cmd == "slockwhitelistgui" or raw_cmd == "serverlockmanager" or raw_cmd == "serverlockgui" then
      server_lock_whitelist_gui()
   elseif raw_cmd == "slock" or raw_cmd == "serverlock" or raw_cmd == "lockserver" then
      server_lock_toggle(true)
   elseif raw_cmd == "unslock" or raw_cmd == "unserverlock" or raw_cmd == "unlockserver" then
      server_lock_toggle(false)
   elseif raw_cmd == "privserver" or raw_cmd == "privserverowner" or raw_cmd == "serverowner" then
      notify_priv_server_owner()
   elseif raw_cmd == "autonoflames" or raw_cmd == "autohideflames" then
      if getgenv().firehidden then
         return getgenv().notify("Warning", "Flames Anti-Fire Spammer V3 is already enabled.", 6)
      end
      if getgenv().spamming_all_that_fire then
         return getgenv().notify("Warning", "Flames Spammer is enabled, disable it first to block other Fire!", 10)
      end

      getgenv().notify("Success", "Flames Anti-Fire Spammer V3 is now enabled.", 6)
      getgenv().set_fire_state(true)
   elseif raw_cmd == "unautonoflames" or raw_cmd == "unautohideflames" then
      if not getgenv().firehidden then
         return getgenv().notify("Warning", "Flames Anti-Fire Spammer V3 is not enabled.", 6)
      end

      getgenv().notify("Success", "Flames Anti-Fire Spammer V3 is now disabled.", 6)
      getgenv().set_fire_state(false)
   elseif raw_cmd == "antivoid" or raw_cmd == "novoid" then
      anti_void(true)
   elseif raw_cmd == "unantivoid" or raw_cmd == "unnovoid" then
      anti_void(false)
   elseif raw_cmd == "clip" or raw_cmd == "unnoclip" then
      if not getgenv().Noclip_Enabled then
         return getgenv().notify("Error", "Noclip is not enabled, enable it first.", 5)
      end

      getgenv().Toggleable_Noclip(false)
   elseif raw_cmd == "view" or raw_cmd == "spectate" then
      local View_Target = findplr(split[1])
      if not View_Target then
         return getgenv().notify("Error", "Target was not found or does not exist!", 5)
      end

      if getgenv().Viewing_A_Player then
         return getgenv().notify("Error", "You're already viewing someone, do {prefix}unview to stop.", 5)
      end

      local target_char = View_Target.Character or (getgenv().get_char and getgenv().get_char(View_Target, 30))
      if not target_char then
         return getgenv().notify("Error", "Target character not loaded!", 5)
      end

      local target_human = target_char:FindFirstChildOfClass("Humanoid")
      if not target_human then
         return getgenv().notify("Error", "Target humanoid not found!", 5)
      end

      local streamed_in = getgenv().is_streamed_in(View_Target)
      if not streamed_in then
         return getgenv().notify("Error", "You cannot view this person, they're streamed out (cannot see them from this position).", 7)
      end

      getgenv().viewTarget(View_Target)
   elseif raw_cmd == "unview" or raw_cmd == "unspectate" then
      if not getgenv().Viewing_A_Player or getgenv().Viewing_A_Player == false then
         return getgenv().notify("Error", "You're not viewing anybody!", 5)
      end

      if getgenv().Viewing_A_Player or getgenv().Viewing_A_Player == true then
         getgenv().unview_player()
      end
   elseif raw_cmd == "lockcar" then
      local Current_Car = get_vehicle()
      if not Current_Car then return getgenv().notify("Error", "You do not have a vehicle spawned!", 5) end

      if Current_Car:GetAttribute("locked") == true then
         return getgenv().notify("Error", "Your Vehicle is already locked.", 5)
      else
         lock_vehicle(get_vehicle())
         getgenv().notify("Success", "Locked vehicle: "..tostring(Current_Car), 5)
      end
   elseif raw_cmd == "unlockcar" then
      local Current_Car = get_vehicle()
      if not Current_Car then return getgenv().notify("Error", "You do not have a vehicle spawned!", 5) end
      
      if Current_Car:GetAttribute("locked") == true then
         lock_vehicle(get_vehicle())
         notify("Success", "Unlocked vehicle: "..tostring(Current_Car), 5)
      else
         return notify("Error", "Your vehicle is unlocked already!", 5)
      end
   elseif raw_cmd == "flamessettings" or raw_cmd == "titlesettings" or raw_cmd == "edittitle" then
      if CoreGui:FindFirstChild("flameshubtitlesgui") and CoreGui:FindFirstChild("flameshubtitlesgui"):IsA("ScreenGui") then
         local Main_GUI = CoreGui:FindFirstChild("flameshubtitlesgui")
         if Main_GUI and Main_GUI:FindFirstChildOfClass("Frame") then
            local Main_Frame = Main_GUI:FindFirstChildOfClass("Frame")
            if Main_Frame and Main_Frame:IsA("Frame") then
               Main_Frame.Visible = not Main_Frame.Visible
            end
         end
      end
   elseif raw_cmd == "glitchoutfit" then
      glitch_outfit(true)
   elseif raw_cmd == "noglitchoutfit" or raw_cmd == "unglitchoutfit" then
      glitch_outfit(false)
   elseif raw_cmd == "despawn" or raw_cmd == "nocar" or raw_cmd == "unspawncar" or raw_cmd == "despawncar" or raw_cmd == "unspawnvehicle" or raw_cmd == "despawnvehicle" then
      local Current_Car = get_vehicle()
      if not Current_Car then return getgenv().notify("Error", "You do not have a vehicle spawned!", 5) end
      
      if Current_Car then
         getgenv().notify("Success", "Despawned Vehicle: "..tostring(Current_Car), 5)
         spawn_any_vehicle(tostring(Current_Car.Name))
      end
   elseif raw_cmd == "trailer" or raw_cmd == "addtrailer" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a Vehicle spawned, spawn one and try again!", 7) end

      if get_vehicle() then
         getgenv().notify("Success", "Added WaterSkies to Vehicle: "..tostring(Vehicle), 5)
         water_skie_trailer(true, get_vehicle())
      end
   elseif raw_cmd == "notrailer" or raw_cmd == "untrailer" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a Vehicle spawned, spawn one and try again!", 7) end

      if get_vehicle() then
         getgenv().notify("Success", "Removed WaterSkies trailer from: "..tostring(Vehicle), 5)
         water_skie_trailer(false, get_vehicle())
      end
   elseif raw_cmd == "lagreduce" or raw_cmd == "lagreducer" or raw_cmd == "boostfps" or raw_cmd == "fpsboost" or raw_cmd == "fpsbooster" then
      getgenv().FlamesLagReducerFunc(true)
   elseif raw_cmd == "unlagreduce" or raw_cmd == "unlagreducer" or raw_cmd == "unboostfps" or raw_cmd == "unfpsboost" or raw_cmd == "unfpsbooster" then
      getgenv().FlamesLagReducerFunc(false)
   elseif raw_cmd == "rainbowtime" then
      local Player = findplr(split[1])
      if not Player then
         return notify("Error", "Player doesn't exist or has left!")
      end
      if not Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         return notify("Error", "Player is not friends with you, add them!")
      end

      local Name = Player.Name
      local new_delay = tonumber(split[2]) or 1

      getgenv().Rainbow_Delays = getgenv().Rainbow_Delays or {}
      getgenv().Rainbow_Delays[Name] = new_delay

      task.wait(0.2)
      notify("Success", "Set rainbow delay for " .. Name .. " to " .. new_delay)
   elseif raw_cmd == "annoyergui" or raw_cmd == "annoyancegui" or raw_cmd == "annoyancemenu" or raw_cmd == "annoyplrgui" or raw_cmd == "groupspamgui" or raw_cmd == "gcspamgui" then
      annoyance_GUI()
   elseif raw_cmd == "blacklist" or raw_cmd == "addblacklist" then
      local Player = findplr(split[1])
      if not Player then return end
      local Name = Player.Name

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if not getgenv().Blacklisted_Friends[Player.Name] then
            getgenv().Blacklisted_Friends[Player.Name] = Player
         end
      end
      wait(0.3)
      if getgenv().player_admins[Name] then
         getgenv().player_admins[Name] = nil
      end
      if getgenv().Rainbow_Vehicles[Name] then
         getgenv().Rainbow_Vehicles[Name] = false
      end
      if getgenv().Locked_Vehicles[Name] then
         getgenv().Locked_Vehicles[Name] = false
      end
      if getgenv().Unlocked_Vehicles[Name] then
         getgenv().Unlocked_Vehicles[Name] = false
      end
      if getgenv().Rainbow_Tasks[Name] then
         getgenv().Rainbow_Tasks[Name] = nil
      end
   elseif raw_cmd == "unblacklist" or raw_cmd == "noblacklist" or raw_cmd == "removeblacklist" then
      local Player = findplr(split[1])
      if not Player then return end
      local Name = Player.Name

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if getgenv().Blacklisted_Friends[Name] then
            getgenv().Blacklisted_Friends[Name] = nil
         end
      end
   elseif raw_cmd == "msgmenu" or raw_cmd == "msgsmenu" or raw_cmd == "sendmsgmenu" or raw_cmd == "msgsgui" or raw_cmd == "msgui" or raw_cmd == "msggui" or raw_cmd == "messagegui" or raw_cmd == "messagesgui" then
      send_msg_menu()
   elseif raw_cmd == "admin" or raw_cmd == "addadmin" then
      local Player = findplr(split[1])
      if not Player then return notify("Error", "Player does not exist!", 5) end

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         if not getgenv().player_admins[Player.Name] then
            alreadyCheckedUser(Player)
            wait(0.5)
            notify("Success", "Added "..tostring(Player.Name).." to the admin's table!", 5)
         else
            return notify("Error", "Player is already an admin!", 5)
         end
      else
         return notify("Error", "This player isn't friends with you! add them!", 5)
      end
   elseif raw_cmd == "unadmin" or raw_cmd == "removeadmin" then
      local Player = findplr(split[1])
      if not Player then return notify("Error", "Player does not exist!", 5) end

      if Player:IsFriendsWith(getgenv().LocalPlayer.UserId) then
         notify("Warning", "Removing admin for: "..tostring(Player.Name), 5)
         local Name = Player.Name

         if getgenv().player_admins[Name] then
            getgenv().player_admins[Name] = nil
            wait(0.2)
            notify("Success", "Player removed from getgenv().player_admins table!", 5)
         end
         if getgenv().Rainbow_Vehicles[Name] then
            getgenv().Rainbow_Vehicles[Name] = false
         end
         if getgenv().Locked_Vehicles[Name] then
            getgenv().Locked_Vehicles[Name] = false
         end
         if getgenv().Unlocked_Vehicles[Name] then
            getgenv().Unlocked_Vehicles[Name] = false
         end
         if getgenv().Rainbow_Tasks[Name] then
            getgenv().Rainbow_Tasks[Name] = nil
         end
         wait(0.5)
         if not getgenv().player_admins[Name] then
            notify("Success", "Player's admin has been removed successfully.", 5)
         else
            notify("Error", "Player's admin abilities we're not removed.", 5)
         end
      else
         return notify("Error", "This player isn't friends with you! add them!", 5)
      end
   elseif raw_cmd == "feedback" or raw_cmd == "feedbackgui" or raw_cmd == "feedbackui" or raw_cmd == "sendfeedback" or raw_cmd == "sendfeedbackgui" or raw_cmd == "sendfeedbackui" then
      feedback_GUI()
   elseif raw_cmd == "bringcar" or raw_cmd == "bringvehicle" or raw_cmd == "bringv" then
      local Vehicle = get_vehicle()
      if not Vehicle then return notify("Error", "You do not have a vehicle spawned!", 5) end
      local Old_CF_BringCar = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame
      local myVehicle = nil

      for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
         if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
            if v:FindFirstChild("VehicleSeat") then
               myVehicle = v
               break
            end
         end
      end

      if not myVehicle then return notify("Error", "No owned SchoolBus found", 5) end
      local seat = myVehicle:FindFirstChild("VehicleSeat")
      if seat and getgenv().Humanoid then
         getgenv().Character:PivotTo(seat.CFrame)
         task.wait(0.2)
         seat:Sit(getgenv().Humanoid)
      end
      wait(0.1)
      myVehicle:PivotTo(Old_CF_BringCar * CFrame.new(0, 10, 0))
      wait(0.1)
      notify("Success", "Brung car to player: "..tostring(getgenv().LocalPlayer), 5)
   elseif raw_cmd == "gotocar" or raw_cmd == "teleporttocar" or raw_cmd == "tptocar" or raw_cmd == "gotovehicle" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a vehicle spawned, spawn one and try again!", 7) end

      if getgenv().Character and getgenv().Character:FindFirstChild("HumanoidRootPart") then
         getgenv().Character:PivotTo(get_vehicle():GetPivot() * CFrame.new(0, 5, 0))
      end
   elseif raw_cmd == "viewcar" or raw_cmd == "viewvehicle" or raw_cmd == "spectatecar" or raw_cmd == "spectatevehicle" then
      local Camera = getgenv().Camera or workspace.CurrentCamera
      local Vehicle = get_vehicle()
      if not Vehicle then
         return getgenv().notify("Error", "You don't have a Vehicle spawned, spawn one and try again!", 7)
      end

      local fallback = getgenv().Humanoid or getgenv().Character or get_human(LocalPlayer, 30) or get_char(LocalPlayer, 45)
      if not fallback then
         return getgenv().notify("Error", "No fallback camera subject found.", 5)
      end

      if getgenv().CamWatcherConn then
         getgenv().CamWatcherConn:Disconnect()
         getgenv().CamWatcherConn = nil
      end

      local function find_vehicle_part(v)
         return v:FindFirstChildWhichIsA("VehicleSeat", true)
            or v:FindFirstChildWhichIsA("Seat", true)
            or v:FindFirstChildWhichIsA("BasePart", true)
      end

      local target = find_vehicle_part(Vehicle)
      if not target then
         return getgenv().notify("Error", "Could not find a valid vehicle part.", 5)
      end

      Camera.CameraSubject = target
      getgenv().notify("Info", "Now viewing Vehicle.", 5)

      getgenv().CamWatcherConn = target.AncestryChanged:Connect(function()
         if not target:IsDescendantOf(Workspace) then
            Camera.CameraSubject = fallback
            if getgenv().CamWatcherConn then
               getgenv().CamWatcherConn:Disconnect()
               getgenv().CamWatcherConn = nil
            end
            getgenv().notify("Info", "Vehicle lost, camera reset.", 5)
         end
      end)
   elseif raw_cmd == "unviewcar" or raw_cmd == "unviewvehicle" or raw_cmd == "unspectatecar" or raw_cmd == "unspectatevehicle" then
      local Workspace = getgenv().Workspace or workspace
      local Camera = getgenv().Camera or Workspace.CurrentCamera
      local function fallbackto()
         return getgenv().Humanoid or getgenv().Character or getgenv().LocalPlayer.Character or (get_human and get_human(getgenv().LocalPlayer)) or (get_char and get_char(getgenv().LocalPlayer))
      end

      if getgenv().CamWatcherConn then
         getgenv().CamWatcherConn:Disconnect()
         getgenv().CamWatcherConn = nil
      end

      local fb = fallbackto()
      if fb then
         Camera.CameraSubject = fb
         getgenv().notify("Info", "Camera now set back to your character.", 5)
      end
   elseif raw_cmd == "tpcar" or raw_cmd == "teleportcar" or raw_cmd == "tpvehicle" or raw_cmd == "teleportvehicle" then
      local Vehicle = get_vehicle()
      if not Vehicle then return getgenv().notify("Error", "You do not have a vehicle spawned, spawn one and try again!", 7) end
      local Goto_Player = findplr(split[1])
      if not Goto_Player then return getgenv().notify("Error", "Target player not found / does not exist / or has left the game.", 8) end
      local Old_CFrame_TP_Car = getgenv().Character:FindFirstChild("HumanoidRootPart").CFrame

      if Goto_Player and Goto_Player.Character and Goto_Player.Character:FindFirstChild("Humanoid") then
         local Target_Char = getgenv().get_char(Goto_Player)
         local Target_CFrame = Target_Char:GetPivot() * CFrame.new(0, 5, 0)
         local myVehicle = nil

         for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
            if v:IsA("Model") and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
               if v:FindFirstChild("VehicleSeat") then
                  myVehicle = v
                  break
               end
            end
         end

         if not myVehicle then return notify("Error", "No owned SchoolBus found", 5) end
         local seat = myVehicle:FindFirstChild("VehicleSeat")
         if seat and getgenv().Humanoid then
            getgenv().Character:PivotTo(seat.CFrame)
            task.wait(0.2)
            seat:Sit(getgenv().Humanoid)
         end
         wait(0.1)
         myVehicle:PivotTo(Target_CFrame)
         wait(0.3)
         if getgenv().Humanoid.Sit or getgenv().Humanoid.Sit == true then
            getgenv().Humanoid:ChangeState(3)
            wait(0.2)
            getgenv().HumanoidRootPart.CFrame = Old_CFrame_TP_Car
         else
            getgenv().HumanoidRootPart.CFrame = Old_CFrame_TP_Car
         end

         getgenv().notify("Success", "Teleported vehicle to target player: "..tostring(Goto_Player), 5)
      end
   elseif raw_cmd == "nosit" or raw_cmd == "antisit" then
      anti_sit_func(true)
   elseif raw_cmd == "carcolor" or raw_cmd == "vehiclecolor" then
      local TargetArg = split[1]
      local Color = split[2]
      local TargetPlayer = TargetArg and findplr(TargetArg)
      local Vehicle_Target

      if TargetPlayer then
         if not TargetPlayer:IsFriendsWith(getgenv().LocalPlayer.UserId) then
            return notify("Error", "Player is not friends with you, add them!", 5)
         end

         Vehicle_Target = get_other_vehicle(TargetPlayer)
         if not Vehicle_Target then
            return notify("Error", tostring(TargetPlayer).." does not have a vehicle spawned!", 5)
         end
      else
         Vehicle_Target = get_vehicle()
         if not Vehicle_Target then
            return notify("Error", "You do not have a vehicle spawned!", 5)
         end
      end

      local colors = {
         black   = Color3.fromRGB(0,0,0),
         white   = Color3.fromRGB(255,255,255),
         red     = Color3.fromRGB(255,0,0),
         orange  = Color3.fromRGB(255,165,0),
         yellow  = Color3.fromRGB(255,255,0),
         green   = Color3.fromRGB(0,255,0),
         blue    = Color3.fromRGB(0,0,255),
         purple  = Color3.fromRGB(128,0,128),
         pink    = Color3.fromRGB(255,0,191),
         teal    = Color3.fromRGB(0,128,128),
         cyan    = Color3.fromRGB(0,255,255),
         magenta = Color3.fromRGB(255,0,255),
         brown   = Color3.fromRGB(124,92,70),
         grey    = Color3.fromRGB(128,128,128),
         gray    = Color3.fromRGB(64,64,64),
         silver  = Color3.fromRGB(192,192,192),
         navy    = Color3.fromRGB(0,0,128),
         gold    = Color3.fromRGB(220,188,129),
      }

      if not Color then
         return notify("Error", "No color specified!", 5)
      end

      local col = colors[Color:lower()]
      if not col then
         return getgenv().notify("Error", "Unknown color: "..tostring(Color), 5)
      end

      change_vehicle_color(col, Vehicle_Target)
   elseif raw_cmd == "musicplr" or raw_cmd == "ytmusic" or raw_cmd == "musicplayer" or raw_cmd == "musicplayerscript" or raw_cmd == "ytmusicplayer" or raw_cmd == "ytmusicplr" then
      youtube_music_player()
   elseif raw_cmd == "resit" or raw_cmd == "unantisit" or raw_cmd == "unnosit" then
      anti_sit_func(false)
   elseif raw_cmd == "flashname" or raw_cmd == "startflashname" then
      if getgenv().Flashing_Name_Title or getgenv().Flashing_Name_Title == true then
         return notify("Error", "Your already running Flash Name!", 5)
      end

      flashy_name(true)
      getgenv().notify("Success", "Flash Name is now enabled.", 5)
   elseif raw_cmd == "unflashname" or raw_cmd == "noflashname" then
      if not getgenv().Flashing_Name_Title or getgenv().Flashing_Name_Title == false then
         return notify("Error", "Your not currently running Flash Name!", 5)
      end
      
      flashy_name(false)
      getgenv().notify("Success", "Flash Name is now disbaled.", 5)
   elseif raw_cmd == "invis" or raw_cmd == "tempinvis" or raw_cmd == "goinvis" or raw_cmd == "invisible" then
      if getgenv().is_invisible_script_toggled then
         return getgenv().notify("Warning", "You're already Invisible.", 5)
      end

      getgenv().set_invisible(true)
   elseif raw_cmd == "uninvis" or raw_cmd == "untempinvis" or raw_cmd == "bevis" or raw_cmd == "visible" then
      if not getgenv().is_invisible_script_toggled then
         return getgenv().notify("Warning", "You're not currently Invisible.", 5)
      end

      getgenv().set_invisible(false)
   elseif raw_cmd == "friend" or raw_cmd == "friendplr" or raw_cmd == "add" or raw_cmd == "addplr" then
      local target_friend_player = findplr(split[1])
      if not target_friend_player then
         return notify("Error", "That player does not exist or has left the game.", 6)
      end

      getgenv().friend_user_async_function(target_friend_player)
   elseif raw_cmd == "unfriend" or raw_cmd == "unfriendplr" or raw_cmd == "unadd" or raw_cmd == "unaddplr" then
      local target_unadd_plr = findplr(split[1])
      if not target_unadd_plr then
         return notify("Error", "That player does not exist or has left the game.", 6)
      end

      getgenv().unfriend_user_async(target_unadd_plr)
   elseif raw_cmd == "float" or raw_cmd == "walkonair" or raw_cmd == "airwalk" then
      getgenv().start_flames_float()
   elseif raw_cmd == "unfloat" or raw_cmd == "unwalkonair" or raw_cmd == "unairwalk" or raw_cmd == "nofloat" then
      getgenv().stop_flames_float()
   elseif raw_cmd == "spawnpoint" or raw_cmd == "setspawn" or raw_cmd == "makesp" or raw_cmd == "setsp" then
      getgenv().set_spawnpoint(0.1)
   elseif raw_cmd == "nospawnpoint" or raw_cmd == "nosetspawn" or raw_cmd == "unsetspawn" or raw_cmd == "unmakesp" or raw_cmd == "unsetsp" then
      getgenv().clear_spawnpoint()
   elseif raw_cmd == "loopfling" or raw_cmd == "flingloop" or raw_cmd == "alwaysfling" then
      local loop_fling_victim = findplr(split[1])
      if not loop_fling_victim then
         return getgenv().notify("Error", "That Player: "..tostring(loop_fling_victim).. " does not exist!", 7)
      end

      if loop_fling_victim and loop_fling_victim.Character then
         getgenv().start_loopfling(loop_fling_victim)
      end
   elseif raw_cmd == "unloopfling" or raw_cmd == "unflingloop" or raw_cmd == "unalwaysfling" then
      getgenv().stop_loopfling()
   elseif raw_cmd == "flashinvis" or raw_cmd == "spaminvis" then
      local is_verified = Data.is_verified
      local invis_bought = Data.invisible_bought

      if getgenv().LocalPlayer:GetAttribute("is_verified") == false then
         return getgenv().notify("Error", "You do not have LifePay premium for this (will not be FE without it).", 10)
      end

      task.wait(0.2)
      local Is_Invis = Invisible_Module.enabled.get()
      getgenv().Invisible_Flash = true

      if Is_Invis then
         notify("Warning", "You we're already invisible, turning off invisibility...", 5)
         Invisible_Module.enabled.set(false)
      end

      wait(0.1)
      while getgenv().Invisible_Flash == true do
         Invisible_Module.enabled.set(true)
         task.wait(0.05)
         Invisible_Module.enabled.set(false)
         task.wait(0.05)
      end
   elseif raw_cmd == "noflashinvis" or raw_cmd == "unflashinvis" or raw_cmd == "stopflashinvis" then
      getgenv().Invisible_Flash = false
      wait(0.5)
      if not getgenv().Invisible_Flash then
         getgenv().notify("Warning", "Invisible Flash has not disabled yet, waiting...", 3)
         repeat task.wait() until getgenv().Invisible_Flash == false
         wait(1)
         if not getgenv().Invisible_Flash then
            getgenv().notify("Success", "Disabled Invisible Flash correctly.", 5)
         end
      end
   elseif raw_cmd == "kill" and split[1] then
      local target = findplr(split[1])
      if not target then return notify("Error", "Target not found.", 5) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t = t + 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_kill_player(target)
         getgenv().notify("Success", "Killing player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif raw_cmd == "void" and split[1] then
      local target = findplr(split[1])
      if not target then return getgenv().notify("Error", "Target Player not found.", 5) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t = t + 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_void_player(target)
         getgenv().notify("Success", "Sending player to the Void | player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif raw_cmd == "rejoin" or raw_cmd == "rj" or raw_cmd == "rej" then
      local PlaceID = game.PlaceId
      local JobID = game.JobId
      local function safe_teleport()
         local success, err = pcall(function()
            if #Players:GetPlayers() <= 1 then
               getgenv().notify("Success", "You are now going to rejoin into a different server (this server is empty).", 10)
               getgenv().TeleportService:Teleport(PlaceID, LocalPlayer)
            else
               getgenv().notify("Success", "You are now going to be rejoined.", 5)
               TeleportService:TeleportToPlaceInstance(PlaceID, JobID, LocalPlayer)
            end
         end)

         if not success then
            getgenv().notify("Error", "Teleporting failed: "..tostring(err).." | going to re-try, if it doesn't work, something is wrong with the server, or you have an unstable connection.", 15)
            task.wait(3)
            safe_teleport()
         end
      end

      safe_teleport()
   elseif raw_cmd == "antifling" or raw_cmd == "startantifling" or raw_cmd == "antiflingon" then
      if getgenv().FlyEnabled then
         return getgenv().notify("Error", "Fly-1 is enabled, turn it off to turn on Anti-Fling", 7)
      end
      if getgenv().Enabled_Flying then
         return getgenv().notify("Error", "Fly-2 is enabled, turn it off to turn on Anti-Fling.", 7)
      end
      if getgenv().afEnabled then
         return getgenv().notify("Warning", "Anti-Fling is already enabled!", 5)
      end

      getgenv().Toggle_AntiFling_Boolean_Func(true)
      getgenv().ToggleNoclip(true)
      getgenv().hasSeen_AntiFling_WarningPrompt = true
      getgenv().notify("Success", "Successfully enabled Anti-Fling.", 9)
   elseif raw_cmd == "unantifling" or raw_cmd == "stopantifling" or raw_cmd == "antiflingoff" then
      if not getgenv().afEnabled then
         return getgenv().notify("Error", "Anti-Fling is not enabled.", 6)
      end

      getgenv().Toggle_AntiFling_Boolean_Func(false)
      getgenv().ToggleNoclip(false)
   elseif raw_cmd == "wseditor" or raw_cmd == "gameeditor" or raw_cmd == "gamemodder" or raw_cmd == "workspacemod" or raw_cmd == "wsmodder" or raw_cmd == "workspaceeditor" or raw_cmd == "objeditor" or raw_cmd == "objviewer" or raw_cmd == "objectviewer" or raw_cmd == "objecteditor" then
      getgenv().workspace_editor_script_GUI()
   elseif raw_cmd == "bring" and split[1] then
      local target = findplr(split[1])
      if not target then return getgenv().notify("Error", "Target not found.", 5) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t = t + 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_bring_player(target)
         getgenv().notify("Success", "Bringing player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif raw_cmd == "skydive" then
      local target = findplr(split[1])
      if not target then return notify("Error", "Target not found.", 3) end
      if getgenv().Not_Ever_Sitting then return getgenv().notify("Error", "Anti-Sit is enabled, turn it off first!", 5) end

      local function wait_for_bus(timeout)
         local t = 0
         while t < timeout do
            for _, v in ipairs(getgenv().Workspace.Vehicles:GetChildren()) do
               if v:IsA("Model") and v.Name == "SchoolBus" and v:FindFirstChild("owner") and v.owner.Value == getgenv().LocalPlayer then
                  return v
               end
            end
            task.wait(0.2)
            t = t + 0.2
         end
         return nil
      end

      local Vehicle = get_vehicle()
      if not Vehicle or Vehicle.Name ~= "SchoolBus" then
         spawn_any_vehicle("SchoolBus")
         wait(0.5)
         Vehicle = wait_for_bus(5)
      end

      if Vehicle and Vehicle.Name == "SchoolBus" then
         vehicle_skydive_player(target)
         getgenv().notify("Success", "Skydiving player: "..target.Name, 3)
      else
         getgenv().notify("Error", "Failed to spawn/find SchoolBus.", 3)
      end
   elseif raw_cmd == "goto" or raw_cmd == "tpto" or raw_cmd == "teleportto" or raw_cmd == "tpplr" or raw_cmd == "tptoplr" then
      getgenv().LastKnownPivot = getgenv().LastKnownPivot or {}

      local target = findplr(split[1])
      if not target then
         return getgenv().notify("Error", "Target does not exist!", 6)
      end

      local Character =
         getgenv().Character
         or (getgenv().LocalPlayer and getgenv().LocalPlayer.Character)
         or (getgenv().get_char and getgenv().get_char(LocalPlayer, 30))

      local Humanoid =
         getgenv().Humanoid
         or (Character and Character:FindFirstChildOfClass("Humanoid"))
         or (getgenv().get_human and getgenv().get_human(LocalPlayer, 20))

      if not (Character and Humanoid) then
         return getgenv().notify("Error", "Your character is not loaded!", 8)
      end

      local Target_Char = target.Character
      if not Target_Char and getgenv().get_char then
         Target_Char = getgenv().get_char(target, 30)
      end

      local function is_streamed_in(plr)
         if not plr or not plr.Character then
            return false
         end

         local root = plr.Character:FindFirstChild("HumanoidRootPart")
         if not root then
            return false
         end

         return root:IsDescendantOf(workspace)
      end

      local Char_Pos
      local streamed_in = is_streamed_in(target)

      if streamed_in and Target_Char then
         local ok, pivot = pcall(function()
            return Target_Char:GetPivot()
         end)

         if ok and pivot then
            Char_Pos = pivot * CFrame.new(0, 5, 0)
            getgenv().LastKnownPivot[target.UserId] = Char_Pos
         end
      else
         Char_Pos = getgenv().LastKnownPivot[target.UserId]

         if not Char_Pos then
            return getgenv().notify("Error", "No last known Position for target!", 5)
         end

         getgenv().notify("Warning", "Target is streamed out. Using last known position.", 6)
      end

      if not Char_Pos then
         return getgenv().notify("Error", "Failed to resolve teleport position!", 5)
      end

      getgenv().notify("Success", "Teleporting to player: "..tostring(target.Name), 6)

      pcall(function()
         if Humanoid.Sit then
            Humanoid:ChangeState(3)
            task.wait(0.2)
         end
      end)

      pcall(function()
         Character:PivotTo(Char_Pos)
      end)
   elseif raw_cmd == "caraccel" or raw_cmd == "vehicleaccel" then
      local val = tonumber(args[1])
      if not val then return getgenv().notify("Warning", "Usage: caraccel [number], got: "..tostring(args[1]), 4) end
      local car = get_vehicle()
      local humcar = in_humanoid_vehicle(getgenv().LocalPlayer)

      if humcar then
         set_hum_vehicle_speed(val)
      elseif car and car:GetAttribute("max_acc") then
         car:SetAttribute("max_acc", val)
         getgenv().notify("Success", "Set car max_acc to: " .. val, 5)
      else
         return getgenv().notify("Error", "Could not find car or humanoid Vehicle (skateboard, wheelchair, etc), or you're not in one.", 10)
      end
   elseif raw_cmd == "carspeed" or raw_cmd == "vehiclespeed" then
      local Vehicle = get_vehicle()
      local Hum = in_humanoid_vehicle(getgenv().LocalPlayer or game.Players.LocalPlayer)
      local HumVehicleName = hum_vehicle_name(getgenv().LocalPlayer or game.Players.LocalPlayer)
      local n = tonumber(split[2]) or 45
      if not n then n = 45 end

      if Hum and HumVehicleName then
         set_hum_vehicle_speed(n)
         return notify("Success", "Set HumanoidVehicle: "..tostring(HumVehicleName).."'s speed to: "..tostring(n), 5)
      end

      if Vehicle and Vehicle:GetAttribute("max_speed") ~= nil then
         Vehicle:SetAttribute("max_speed", n)
         return notify("Success", "Set Vehicle: "..tostring(Vehicle).."'s speed to: "..tostring(n), 5)
      end

      notify("Error", "No car or humanoid vehicle found.", 5)
   elseif raw_cmd == "turnangle" then
      local turn_angle_val = tonumber(args[1])
      if not turn_angle_val then return getgenv().notify("Warning", "Usage: turnangle [number], got: "..tostring(args[1]), 5) end

      local car = get_vehicle()
      local humcar = in_humanoid_vehicle(getgenv().LocalPlayer)

      if humcar then
         set_hum_vehicle_speed(turn_angle_val)
      elseif car and car:GetAttribute("turn_angle") then
         car:SetAttribute("turn_angle", turn_angle_val)
         getgenv().notify("Success", "Set car turn_angle to: "..tostring(turn_angle_val), 5)
      else
         getgenv().notify("Error", "Could not find car or humanoid Vehicle (skateboard, wheelchair, etc), or you're not in one.", 10)
      end
   elseif raw_cmd == "accel" then
      local val = tonumber(args[1])
      if not val then return getgenv().notify("Warning", "Usage: accel [number], got: "..tostring(args[1]), 5) end
      local car = get_vehicle()
      local humcar = in_humanoid_vehicle(getgenv().LocalPlayer)

      if humcar then
         set_hum_vehicle_speed(val)
      elseif car and car:GetAttribute("acc_0_60") then
         car:SetAttribute("acc_0_60", val)
         getgenv().notify("Success", "Set car acc_0_60 to: " .. val, 4)
      else
         getgenv().notify("Error", "Could not find car or humanoid Vehicle (skateboard, wheelchair, etc), or you're not in one.", 10)
      end
   elseif raw_cmd == "freepay" then
      if getgenv().Has_Free_LifePremium then return getgenv().notify("Error", "You have already executed FreePay!", 5) end
      if LocalPlayer:GetAttribute("is_verified") == true then
         getgenv().notify("Warning", "You already have the actual LifePremium!", 15)
      end
      wait(0.1)
      for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
         if v:GetAttribute("IsVerifiedOnly") == true then
            v:SetAttribute("IsVerifiedOnly", false)
         end
      end
      task.wait(0.1)
      if not debug.getupvalue then return getgenv().notify("Error", "This feature is unsupported in your executor!", 5) end

      local update = debug.getupvalue(Data.initiate, 2)
      update("is_verified", true)
      wait(0.2)
      if LocalPlayer:GetAttribute("is_verified") == false then
         getgenv().notify("Info", "FreePay still ran, don't worry, but, you can't spawn Premium Houses (it's not possible).", 15)
      end
      wait(0.1)
      getgenv().Has_Free_LifePremium = true
   elseif raw_cmd == "spawn" and split[1] then
      local input = split[1]:lower():gsub("%s+", "")
      local matched = false

      if input:find("broom") or input:find("broomstick") then
         spawn_any_vehicle("Magic Carpet")
         getgenv().notify("Success", "Spawning requested vehicle: Broomstick.", 3)
         return
      elseif input:find("magiccarpet") or input:find("carpet") then
         spawn_any_vehicle("Magic Carpett")
         getgenv().notify("Success", "Spawning requested vehicle: Magic Carpet.", 3)
         return
      end

      for carKey, fullName in pairs(CarMap) do
         local cleanKey = carKey:lower():gsub("%s+", "")
         if cleanKey:find(input, 1, true) then
            spawn_any_vehicle(fullName)
            getgenv().notify("Success", "Spawning requested vehicle: " .. tostring(fullName), 3)
            matched = true
            break
         end
      end

      if not matched then
         getgenv().notify("Error", tostring(input).." did not match any existing Vehicles, if you want to spawn Vehicles easier use the command: "..tostring(getgenv().AdminPrefix).."allcars", 15)
      end
   elseif raw_cmd == "antihouseban" or raw_cmd == "antihomeban" or raw_cmd == "preventhouseban" or raw_cmd == "antihousekick" or raw_cmd == "antiteleport" or raw_cmd == "antitp" or raw_cmd == "antihousetp" then
      local genv = getgenv()
      if genv.never_banned_houses or genv.AntiTeleport then
         return genv.notify("Error", "AntiHouseBan / AntiTeleport is already enabled.", 6)
      end

      genv.never_banned_houses = true
      genv.AntiTeleport = true
      genv.AntiTeleportConnections = {}

      local LocalPlayer = game.Players.LocalPlayer
      local RunService = game:GetService("RunService")
      local Character = LocalPlayer.Character or getgenv().return_char(LocalPlayer, 10)
      local HRP = Character:WaitForChild("HumanoidRootPart")
      local safe_cframe = HRP.CFrame
      local last_position = HRP.Position
      local latch_until = 0

      local function rebind()
         Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
         HRP = Character:WaitForChild("HumanoidRootPart")
         safe_cframe = HRP.CFrame
         last_position = HRP.Position
         latch_until = 0
      end

      table.insert(genv.AntiTeleportConnections,
         LocalPlayer.CharacterAdded:Connect(function()
            task.wait()
            rebind()
         end)
      )

      table.insert(genv.AntiTeleportConnections,
         RunService.Heartbeat:Connect(function()
            if not genv.AntiTeleport then return end
            if not HRP or not HRP.Parent then return end

            local now = os.clock()
            local current_position = HRP.Position
            local delta = (current_position - last_position).Magnitude

            if delta > 12 then
               latch_until = now + 0.4
               HRP.CFrame = safe_cframe
            elseif latch_until > now then
               HRP.CFrame = safe_cframe
            else
               safe_cframe = HRP.CFrame
            end

            last_position = HRP.Position
         end)
      )

      if PlotAreas then
         genv.Updating_Never_Banned_InHouses_Loop_Running_Task = task.spawn(function()
            while genv.never_banned_houses == true do
               task.wait()
               for _,v in ipairs(PlotAreas) do
                  if v then
                     v.CanCollide = false
                  end
               end
            end
         end)
      else
         for _,c in ipairs(genv.AntiTeleportConnections) do
            pcall(function() c:Disconnect() end)
         end
         genv.AntiTeleportConnections = {}
         genv.never_banned_houses = false
         genv.AntiTeleport = false
         return genv.notify("Error", "PlotAreas missing or patched.", 10)
      end

      genv.notify("Success", "AntiHouseBan enabled (Improved AntiTP).", 7)
   elseif raw_cmd == "unantiban" or raw_cmd == "unantihouseban" or raw_cmd == "antihousebanoff" or raw_cmd == "unantihomeban" or raw_cmd == "stopantihouseban" then
      local genv = getgenv()

      if not genv.never_banned_houses and not genv.AntiTeleport then
         return genv.notify("Warning", "AntiHouseBan is not enabled.", 5)
      end

      if typeof(genv.AntiTeleportConnections) == "table" then
         for _, conn in ipairs(genv.AntiTeleportConnections) do
            if typeof(conn) == "RBXScriptConnection" then
               pcall(function()
                  conn:Disconnect()
               end)
            end
         end
         table.clear(genv.AntiTeleportConnections)
      end

      if genv.Updating_Never_Banned_InHouses_Loop_Running_Task then
         task.cancel(genv.Updating_Never_Banned_InHouses_Loop_Running_Task)
         genv.Updating_Never_Banned_InHouses_Loop_Running_Task = nil
      end

      genv.never_banned_houses = false
      genv.AntiTeleport = false

      genv.notify("Success", "[Anti-Teleport]: Disabled, you CAN be banned from homes now.", 5)
   elseif raw_cmd == "caraccel" and split[2] then
      local Vehicle = get_vehicle()
      if not Vehicle then 
         return getgenv().notify("Error", "You do not have a vehicle spawned!", 5) 
      end

      local accelInput = string.trim(split[2] or "")
      local accel_max = tonumber(accelInput)
      if not accel_max then
         return getgenv().notify("Error", "You must enter a valid number (e.g., 50 or 0.5).", 7)
      end

      if Vehicle:GetAttribute("max_acc") ~= nil then
         Vehicle:SetAttribute("max_acc", accel_max)
         getgenv().notify("Success", "Set max accel to: "..tostring(accel_max), 5)
      else
         getgenv().notify("Error", "Your vehicle does not have 'max_acc' attribute.", 5)
      end
   elseif raw_cmd == "accel" and split[2] then
      local Vehicle = get_vehicle()
      if not Vehicle then 
         return getgenv().notify("Error", "You do not have a car spawned!", 5) 
      end

      local accelInput = string.trim(split[2] or "")
      local acc_zero_to_sixty = tonumber(accelInput)
      if not acc_zero_to_sixty then
         return getgenv().notify("Error", "Must be a valid number (e.g., 5 or 0.2).", 5)
      end

      if Vehicle:GetAttribute("acc_0_60") ~= nil then
         Vehicle:SetAttribute("acc_0_60", acc_zero_to_sixty)
         getgenv().notify("Success", "Set acc_0_60 to: "..tostring(acc_zero_to_sixty), 5)
      else
         getgenv().notify("Error", "Your vehicle does not have 'acc_0_60' attribute.", 5)
      end
   elseif raw_cmd == "cmds" or raw_cmd == "commands" or raw_cmd == "cmdsmenu" or raw_cmd == "commandsmenu" then
      CommandsMenu()
   end
end
