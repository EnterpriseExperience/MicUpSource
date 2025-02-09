## [V6 Loadstring, BETA RELEASE!]:

```lua
-- PC Version Of Script (COPY EVERYTHING HERE!)
--[[
    Animation Packages: Zombie, Catwalk Glam, Elder, Cartoony,
    Adidas, Werewolf, Vampire, Astronaut,
    Superhero, Knight, Mage, Ninja,
    Toy, NFL, No Boundaries, Oldschool,
    Pirate, Levitation, Bubbly, Robot,
    Wicked Popular, Bold, Stylish,
    Rthro [default Roblox Animation package]
--]]

--EDIT THE STUFF BELOW, SET STUFF "on" AND "off"!!
--YES, YOU HAVE TO COPY ALL OF THIS STUFF!

-- "on" means it's going to run, "off" means it's not going to run.
local Zacks_Easy_Configuration = {
    -- Use the names above to choose and load custom Animation Packages (they will keep on respawn to).
    Custom_Animation_Package_System = "off",
    Animation_Idle = "Superhero",
    Animation_Walk = "Adidas",
    Animation_Run = "Adidas",
    Animation_Jump = "Levitation",
    Animation_Fall = "Levitation",
    Animation_Climb = "Superhero",
    Death_On_Load = "on",
    Emote_Keybinds = "off",
    AntiAFK = "on",
    Loading_Screen = "off",
    Mute_Boomboxes_Cellmates_VC_Game_Setting = "off", -- Will mute the Boomboxes in the game: "Cellmates (VC)"
    Mute_Music_Volume_Cellmates_VC_Game_Setting = "off", -- Will mute the Music Volume in the game: "Cellmates (VC)"
    Mute_Sound_Effects_Cellmates_VC_Game_Setting = "off", -- Will mute the Sound Effects in the game: "Cellmates (VC)"
    System_Broken_Title = "off",
    System_Broken_Text_Title = "System Broken New Title Here",
    Fully_Loaded_Messaging = "on",
    Fully_Loaded_Message = "Zacks Easy Hub - Winning.", -- Custom message you want to chat when the script fully loads all the way.
    Huge_Baseplate = "on",
    Script_Clock_Time_GUI = "off",
    Anti_Suspend_VC = "on",
    Infinite_Yield_Premium = "on",
    Performance_Statistics = "on",
    Old_Materials = "off",
    System_Broken = "on",
    keep_tp_tool = "off",
}
-- Don't touch this stuff below, unless you know what you are doing.
getgenv().Easies_Configuration = getgenv().Easies_Configuration or {}

for key, value in pairs(Zacks_Easy_Configuration) do
    if getgenv().Easies_Configuration[key] == nil then
        getgenv().Easies_Configuration[key] = value
    end
end
wait(0.1)
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EnterpriseExperience/MicUpSource/refs/heads/main/retrieve_branch_version.lua')))()
```

```lua
https://discord.gg/VJh3kkYzBn
```

```lua
Be sure to check out our Discord for more content! We also welcome non-exploiters to!

Star this repo and save it for later!

[Alternatively, see]:

https://github.com/EnterpriseExperience/MicUpSource/wiki

UPDATE <-> [V6] [UPDATE!]:

V6 New Features:

Check out the Discord server linked above for every feature!

[Custom Exclusive Features With: Zacks Easy Hub V6 | MIC UP 🔊/17+]:

Check Discord server linked above for features!

[FEEL FREE TO USE!]

[LOTS OF FEATURES!]

[NOW HAS OP ABUSE FEATURES!]

[GOING TO BE A HUGE SCRIPT HUB SOON! INCLUDING GAMES LIKE: NEIGHBORS!]

[BYPASSES ARE WORKING, AND NEW BYPASSES ARE NOW IN THE SCRIPT TO!]

[SUPPORTS EVERY EXECUTOR!] [OFFICIALLY!]

[FE FEATURES AND CLIENT FEATURES (FUN FOR ALL!)]

[HAS AN AUTOMATIC SYSTEM FOR CONFIGURATING SCRIPTING ABILITIES! (and for compatibility to!)]

[RELEASED EMOTE/RIZZ CONFIG! NO MORE INFINITE YIELD!]
```
