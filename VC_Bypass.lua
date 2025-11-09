-- [[ This method is OLD, use/see: https://github.com/EnterpriseExperience/MicUpSource/blob/main/New_VC_Bypass.lua ]] --

local VoiceChat_Internal = cloneref and cloneref(game:GetService("VoiceChatInternal")) or game:GetService("VoiceChatInternal")
local VoiceChat_Service = cloneref and cloneref(game:GetService("VoiceChatService")) or game:GetService("VoiceChatService")

if getgenv().voiceChat_Check then
    warn("Voice Chat already initialized.")
else
    getgenv().voiceChat_Check = true 
    
    local reconnecting = false
    local retryDuration = 3
    local maxAttempts = 250
    
    local function unsuspend()
        if reconnecting then return warn("Voice Chat Is Still Reconnecting.") end
        reconnecting = true
    
        local attempts = 0
        while attempts < maxAttempts do
            print("Attempting to reconnect to voice chat... Attempt:", attempts + 1)
            wait()
            VoiceChat_Internal:Leave()
            wait(0.2)
            VoiceChat_Service:rejoinVoice()
            wait(0.1)
            VoiceChat_Service:joinVoice()
            wait(0.3)
            VoiceChat_Internal:Leave()
            task.wait(0.3)
            VoiceChat_Service:rejoinVoice()
            VoiceChat_Service:joinVoice()
            wait(0.5)
            if VoiceChat_Internal.StateChanged ~= Enum.VoiceChatState.Ended then
                print("Successfully reconnected to voice chat!")
                reconnecting = false
                return 
            end
    
            attempts = attempts + 1
            wait(retryDuration)
        end
    
        warn("Failed to reconnect after " .. maxAttempts .. " attempts.")
        reconnecting = false
    end
    
    local function state_changed_connection(_, newState)
        if newState == Enum.VoiceChatState.Ended and not reconnecting then
            print("Voice chat disconnected, attempting to reconnect...")
            unsuspend()
        end
    end
    
    VoiceChat_Internal.StateChanged:Connect(state_changed_connection)
end

if VoiceChat_Internal.StateChanged == Enum.VoiceChatState.Ended then
    VoiceChat_Internal:Leave()
    VoiceChat_Internal:Leave()
    task.wait(0.1)
    VoiceChat_Service:rejoinVoice()
    VoiceChat_Service:joinVoice()
    wait()
    VoiceChat_Internal:Leave()
    wait(0.2)
    VoiceChat_Service:rejoinVoice()
    VoiceChat_Service:joinVoice()
    task.wait(0.2)
    VoiceChat_Service:rejoinVoice()
end
